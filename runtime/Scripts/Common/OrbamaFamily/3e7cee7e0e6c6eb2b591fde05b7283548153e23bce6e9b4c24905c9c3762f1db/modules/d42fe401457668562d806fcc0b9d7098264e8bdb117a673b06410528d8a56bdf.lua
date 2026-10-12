return function(require)
if _G.SDK and _G.SDK.ControlWindow then return _G.SDK.ControlWindow end
-- Runtime movement constraints. Times are seconds on the supplied game clock.
-- No callbacks, identity cache, input or champion automation live here.
local M={}
local stationary={[5]=true,[12]=true,[25]=true,[30]=true,[35]=true}
local forced={[8]=true,[22]=true,[23]=true,[29]=true}
local function finite(v)return type(v)=='number'and v==v and v>-math.huge and v<math.huge end
local function windupSpell(unit)
 if(type(unit)~='table'and type(unit)~='userdata')then return nil end
 local spell=unit.activeSpell
 if(type(spell)~='table'and type(spell)~='userdata')or spell.valid~=true or spell.isStopped==true
  or not finite(spell.castEndTime)then return nil end
 return spell
end
local function attackSpell(spell,data)
 if spell.isAutoAttack==true then return true end
 if type(spell.name)~='string'or not data or type(data.IsAttack)~='function'then return false end
 local ok,yes=pcall(data.IsAttack,data,spell.name)
 return ok and not not yes
end
function M.AttackCastEnd(unit,now,data)
 if not finite(now)then return nil end
 local spell=windupSpell(unit)
 if spell and spell.castEndTime>now and attackSpell(spell,data)then return spell.castEndTime end
end
function M.IsAttackCast(spell,data)
 if(type(spell)~='table'and type(spell)~='userdata')or spell.valid~=true or spell.isStopped==true then return false end
 return attackSpell(spell,data)
end
local function duration(buff,now)
 local finish=buff.expireTime
 if not finite(finish)or finish<=0 then finish=buff.endTime end
 if finite(finish)and finish>0 then return math.max(0,finish-now),true,true end
 local value=buff.duration
 return finite(value)and math.max(0,value)or 0,false,finite(value)and value>=0
end
function M.Read(unit,buffs,now)
 local r={stationaryDuration=0,stationaryKnownDuration=0,knockDuration=0,
  forcedDuration=0,castEnd=0,attackEnd=0,slowDuration=0,slowObserved=false,
  speedStableFor=math.huge,truncated=false}
 if not unit or not finite(now)or type(buffs)~='table'then r.unavailable=true;return r end
 r.truncated=#buffs>256
 for i=1,math.min(#buffs,256)do
  local buff=buffs[i]
  if buff then
   if(type(buff)~='table'and type(buff)~='userdata')or not finite(buff.count)or buff.count<0 then
    r.unavailable=true;return r
   end
  end
  if buff and buff.count>0 then
   local remaining,known,available=duration(buff,now)
   if not available and(stationary[buff.type]or forced[buff.type]or buff.type==31 or buff.type==10
       or buff.name=='ThreshQ'or buff.name=='Jade_ThreshQ')then
    r.unavailable=true;return r
   end
   if remaining>0 then
    if buff.type==31 or buff.name=='ThreshQ'or buff.name=='Jade_ThreshQ'then
     r.knockDuration=math.max(r.knockDuration,remaining)
    elseif stationary[buff.type]then
     r.stationaryDuration=math.max(r.stationaryDuration,remaining)
     if known then r.stationaryKnownDuration=math.max(r.stationaryKnownDuration,remaining)end
    elseif forced[buff.type]then r.forcedDuration=math.max(r.forcedDuration,remaining)
    elseif buff.type==10 then
     r.slowObserved=true;r.slowDuration=math.max(r.slowDuration,remaining)
     -- A slow expiring before impact invalidates current-ms escape bounds.
     -- The host does not supply a verified post-expiry speed here.
     r.speedStableFor=math.min(r.speedStableFor,known and remaining or 0)
    end
   end
  end
 end
 local spell=windupSpell(unit)
 if spell then
  if attackSpell(spell,_G.SDK and _G.SDK.Data)then r.attackEnd=spell.castEndTime
  elseif finite(spell.windup)and spell.windup>.1 then r.castEnd=spell.castEndTime end
 end
  r.observedAt=now
  local motion=_G.SDK and _G.SDK.ChampionMotion
  if motion then return motion.AnnotateControl(r,unit,now)end
  return r
end
-- Fresh native reads are required when a host call may have changed a buff.
-- The provider's frame cache remains useful to ordinary prediction consumers.
function M.ReadNative(unit,now)
 local count=unit and unit.buffCount
 if not finite(count)or count<0 or count~=math.floor(count)or count>255
  or type(unit.GetBuff)~='function'then return M.Read(unit,nil,now)end
 local buffs={}
 for i=0,count do
  local ok,buff=pcall(unit.GetBuff,unit,i)
  if not ok then return M.Read(unit,nil,now)end
  if buff then
   if(type(buff)~='table'and type(buff)~='userdata')or not finite(buff.count)or buff.count<0 then return M.Read(unit,nil,now)end
   if buff.count>0 then buffs[#buffs+1]=buff end
  end
 end
 return M.Read(unit,buffs,now)
end
-- Check the native scan budget before entering the provider's existing cache.
-- Without this gate, rejecting a long returned array would still pay its scan.
function M.ReadCached(unit,manager,now)
 if not manager or type(manager.GetBuffs)~='function'then return M.ReadNative(unit,now)end
 local count=unit and unit.buffCount
 if not finite(now)or not finite(count)or count<0 or count~=math.floor(count)or count>255 then
  return M.Read(unit,nil,now)
 end
 local ok,buffs=pcall(manager.GetBuffs,manager,unit)
 return M.Read(unit,ok and buffs or nil,now)
end
-- Current movement speed is a retreat bound only while its observed constraints
-- remain applicable. No unknown post-slow or post-root speed is invented.
function M.SpeedBound(state,horizon,speed,dashing)
 if not state or state.unavailable or state.truncated or not finite(horizon)or horizon<0
  or not finite(speed)or speed<0 then return nil,'movement_state_unknown'end
 if dashing or state.knockDuration>0 or state.forcedDuration>0 then return nil,'forced_movement'end
 if state.pendingCasterMotion then return nil,'mobility_cast_timing_unknown'end
 if state.speedStableFor<horizon then return nil,'slow_expires_before_contact'end
 if state.stationaryDuration>0 and state.stationaryKnownDuration<horizon then return nil,'cc_ends_before_contact'end
 return speed
end
function M.Assess(state,impact,radius,speed,margin,dashing)
 local r={known=false,controlledThroughImpact=false,canHitLocked=false,canHitFromCurrentPosition=false,guaranteed=false,isLocked=false,
  stationaryDuration=state and state.stationaryDuration or 0,knockDuration=state and state.knockDuration or 0,
  impact=impact,slowObserved=state and state.slowObserved or false,reason='invalid_window'}
 margin=margin or .02
 if not state or state.unavailable or state.truncated or not finite(impact)or impact<0
  or not finite(radius)or radius<0 or not finite(speed)or speed<0 or not finite(margin)or margin<0 then return r end
 local now=state.observedAt
 local lock=math.max(state.stationaryKnownDuration,math.max(0,state.castEnd-now),math.max(0,state.attackEnd-now))
 r.known=true;r.lockDuration=lock;r.stationaryDuration=state.stationaryDuration
 r.stationaryKnownDuration=state.stationaryKnownDuration;r.isLocked=state.stationaryDuration>0 or lock>0
 r.knockDuration=state.knockDuration;r.forcedDuration=state.forcedDuration
 r.speedStableThroughImpact=state.speedStableFor>=impact+margin
  if state.knockDuration>0 or state.forcedDuration>0 or dashing then r.reason='forced_movement';return r end
  if state.pendingCasterMotion then r.known=false;r.reason='mobility_cast_timing_unknown';return r end
 r.controlledThroughImpact=state.stationaryKnownDuration>0 and state.stationaryKnownDuration>=impact+margin
 -- Conditional walking bound, not immunity to a new dash, cleanse or blink.
  local escape=math.max(0,impact+margin-lock)
  r.freeMovementSeconds=escape
  r.freeMovementFraction=impact+margin>0 and escape/(impact+margin)or 0
  r.walkingDisplacement=r.speedStableThroughImpact and speed*escape or nil
  r.preventedWalkingDistance=r.speedStableThroughImpact and speed*math.min(lock,impact+margin)or nil
  r.remainingAimMargin=r.walkingDisplacement~=nil and radius-r.walkingDisplacement or nil
 r.canHitLocked=lock>0 and(impact+margin<=lock or r.walkingDisplacement~=nil and speed>0 and r.walkingDisplacement<radius)
 r.slowFootprintContainsWalk=state.slowObserved and r.speedStableThroughImpact and speed>0
  and r.walkingDisplacement~=nil and r.walkingDisplacement<radius
 r.canHitFromCurrentPosition=r.canHitLocked or r.slowFootprintContainsWalk
 r.reason=r.controlledThroughImpact and 'stationary_through_impact'
  or r.canHitLocked and 'limited_post_lock_movement'
  or r.slowFootprintContainsWalk and 'limited_slow_movement'
  or not r.speedStableThroughImpact and 'slow_expires_before_impact'
  or state.stationaryDuration>state.stationaryKnownDuration and 'cc_expiry_unknown'
  or r.isLocked and 'lock_ends_before_impact'or 'movement_unconstrained'
  return r
end
-- An offset aim must contain the same reachable footprint as a centered aim.
-- The caller supplies the actual circle-center or outgoing-ray distance.
function M.FitAim(window,offset,radius)
 if not window or not finite(offset)or offset<0 or not finite(radius)or radius<0 then
  if window then window.aimKnown=false;window.canHitLocked=false;window.slowFootprintContainsWalk=false;window.canHitFromCurrentPosition=false;window.reason='aim_geometry_unknown'end
  return window
 end
 local walk=window.walkingDisplacement
 if window.freeMovementSeconds==0 then walk=0 end
 window.aimKnown=true;window.aimOffset=offset;window.aimRadius=radius
 window.remainingAimMargin=finite(walk)and radius-offset-walk or nil
 local fits=window.known and window.remainingAimMargin~=nil and window.remainingAimMargin>0
 local before=window.canHitFromCurrentPosition
 window.canHitLocked=window.canHitLocked and fits
 window.slowFootprintContainsWalk=window.slowFootprintContainsWalk and fits
 window.canHitFromCurrentPosition=window.canHitLocked or window.slowFootprintContainsWalk or false
 if before and not window.canHitFromCurrentPosition then window.reason='aim_excludes_reachable_footprint'end
 return window
end
return M

end
