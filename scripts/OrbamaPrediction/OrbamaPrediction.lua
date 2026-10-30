return function()
-- OrbamaPrediction: the family's maintained prediction service.
-- Its historical source attribution is retained in reference/.
if _G.OrbamaPrediction then return _G.OrbamaPrediction end
local Version = '1.0.0'
local math_huge = math.huge
local math_pi = math.pi
local math_sqrt = assert(math.sqrt)
local math_abs = assert(math.abs)
local math_min = assert(math.min)
local math_max = assert(math.max)
local math_pow = assert(math.pow)
local math_atan = assert(math.atan)
local math_acos = assert(math.acos)
local table_remove = assert(table.remove)
local table_insert = assert(table.insert)
local Game, Vector, Draw, Callback = _G.Game, _G.Vector, _G.Draw, _G.Callback
local Menu, Immobile, Math, Path, UnitData, ObjectManager, Collision, Prediction, YasuoWall
local COLLISION_MINION = 0
local COLLISION_ALLYHERO = 1
local COLLISION_ENEMYHERO = 2
local COLLISION_YASUOWALL = 3
local HITCHANCE_IMPOSSIBLE = 0
local HITCHANCE_COLLISION = 1
local HITCHANCE_NORMAL = 2
local HITCHANCE_HIGH = 3
local HITCHANCE_IMMOBILE = 4
local SPELLTYPE_LINE = 0
local SPELLTYPE_CIRCLE = 1
local SPELLTYPE_CONE = 2
local ProjectileMotion=(function()
if _G.OrbamaFamily then return _G.OrbamaFamily:Require("06fbdc8a07528935e1404d6223757f86c9a4a58b716fb3fde4e1084e2cd806c2") end
-- World units and seconds. Shared by prediction, forecasts and Evade.
local M={};local min,max,sqrt=math.min,math.max,math.sqrt
local function finite(n)return type(n)=='number'and n==n and n>-math.huge and n<math.huge end
function M.Valid(s)
 return type(s)=='table'and finite(s.speed)and s.speed>0 and finite(s.acceleration or 0)
  and finite(s.minSpeed)and finite(s.maxSpeed)and s.minSpeed>0 and s.minSpeed<=s.speed and s.speed<=s.maxSpeed
  and(s.speedStep==nil or type(s.speedStep)=='table'and(s.acceleration or 0)==0
   and finite(s.speedStep.at)and s.speedStep.at>=0 and finite(s.speedStep.speed)
   and s.speedStep.speed>=s.minSpeed and s.speedStep.speed<=s.maxSpeed)
end
function M.Travel(s,dt)
 if s.speedUncertain then return nil end
 dt=max(0,dt);local step=s.speedStep
 if step then local first=min(dt,step.at/s.speed);return s.speed*first+step.speed*(dt-first)end
 local v=s.speed or 0;local a=s.acceleration or 0
 local floor,ceiling=s.minSpeed or 0,s.maxSpeed or math.huge;v=max(floor,min(ceiling,v))
 local limit=a>0 and ceiling or floor
 local ramp=a~=0 and max(0,(limit-v)/a)or math.huge;local first=min(dt,ramp)
 return v*first+.5*a*first*first+(dt-first)*(v+a*first)
end
function M.Time(s,distance)
 if s.speedUncertain then return nil end
 if distance<=0 then return 0 end
 local step=s.speedStep
 if step then return min(distance,step.at)/s.speed+max(0,distance-step.at)/step.speed end
 local v,a=s.speed or 0,s.acceleration or 0
 if a==0 then return v>0 and distance/v or math.huge end
 local floor,ceiling=s.minSpeed or 0,s.maxSpeed or math.huge;v=max(floor,min(ceiling,v))
 local limit=a>0 and ceiling or floor;local ramp=max(0,(limit-v)/a)
 local covered=ramp<math.huge and v*ramp+.5*a*ramp*ramp or math.huge
 if distance>covered then return limit>0 and ramp+(distance-covered)/limit or math.huge end
 return 2*distance/(v+sqrt(max(0,v*v+2*a*distance)))
end
return M

end)()
local ControlWindow=(function()
if _G.OrbamaFamily then return _G.OrbamaFamily:Require("d42fe401457668562d806fcc0b9d7098264e8bdb117a673b06410528d8a56bdf") end
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

end)()
local ChampionMotion=(function()
if _G.OrbamaFamily then return _G.OrbamaFamily:Require("a1065fd9c06af1a474441a702bd65f660b7f9d53a9aa919016e0bb00158fafa9") end
if _G.SDK and _G.SDK.ChampionMotion then return _G.SDK.ChampionMotion end
-- Pure motion geometry. All times are game seconds, distances world units.
-- A native path snapshot is evidence of current movement, not a future guarantee.
local M={};local huge=math.huge
local Catalog=(function()
-- Generated by tools/build_mobility_catalog.py from pinned own-profile semantic review. These hints only reject unmodeled cast movement.
-- They authorize no timing, native alias, future targetability or early cast.
return {["allKinematicsAccepted"]=false,["champions"]={["Aatrox"]={["AatroxE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="fc14f9f3",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Ahri"]={["AhriR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="6db3bf5c",["role"]="caster",["status"]="cast_motion_timing_unknown"},["AhriTumble"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="6db3bf5c",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Akali"]={["AkaliE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="d5ec2f6e",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["AkaliR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="abcec076",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Akshan"]={["AkshanE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="3ac50482",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Alistar"]={["Headbutt"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="7cf37f42",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Ambessa"]={["AmbessaPassive"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="3f70c67a",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["AmbessaR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="aea46fb6",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Amumu"]={["BandageToss"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="b38f1c85",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["AurelionSol"]={["AurelionSolW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="68ab7ecb",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Aurora"]={["AuroraE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="backwards_recoil",["record"]="0eab3e26",["role"]="caster",["status"]="cast_motion_timing_unknown"},["AuroraR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="6211eb64",["role"]="caster",["status"]="cast_motion_timing_unknown"},["AuroraW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="b52de922",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Azir"]={["AzirEWrapper"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="ac0fca0a",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Belveth"]={["BelvethQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="e43cee20",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Braum"]={["BraumW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="0afd8cab",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Briar"]={["BriarQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="0792ec1a",["role"]="caster",["status"]="cast_motion_timing_unknown"},["BriarR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="ambiguous_asset_alias",["role"]="caster_phase_unresolved",["source_records"]={"064b73fe","389c642a"},["status"]="cast_motion_timing_unknown"},["BriarW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="064b73fe",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Caitlyn"]={["CaitlynE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="backwards_recoil",["record"]="13cc1d66",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Camille"]={["CamilleE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="adb9b42f",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["CamilleR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="e3460673",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Corki"]={["CarpetBomb"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="ebf5911e",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Darius"]={["DariusExecute"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="796fc80c",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Diana"]={["DianaTeleport"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="b3774c4f",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Ekko"]={["EkkoE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="c17121b4",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["EkkoR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="44a0a76e",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Elise"]={["EliseSpiderE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="8f0a0d7e",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["EliseSpiderQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="2a7bb98e",["role"]="caster",["status"]="cast_motion_timing_unknown"},["EliseSpiderQCast"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="4f276575",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Evelynn"]={["EvelynnE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="c043c6bb",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["EvelynnR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="95752487",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Ezreal"]={["EzrealE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="dc04aa93",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["FiddleSticks"]={["FiddleSticksR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="ba8d91b5",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Fiora"]={["FioraQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="66056b65",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Fizz"]={["FizzE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="8a784fd1",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["FizzQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="a20d4eb1",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Galio"]={["GalioE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="e63305b2",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["GalioR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="ddda8d02",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Gnar"]={["GnarBigE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="9f74846c",["role"]="caster",["status"]="cast_motion_timing_unknown"},["GnarE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="c55ae02c",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Gragas"]={["GragasE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="a004ee15",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Graves"]={["GravesChargeShot"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="backwards_recoil",["record"]="4f0c48fc",["role"]="caster",["status"]="cast_motion_timing_unknown"},["GravesMove"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="f1097a88",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Gwen"]={["GwenE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="987f7411",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Hecarim"]={["HecarimCharge"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="7d580bab",["role"]="caster",["status"]="cast_motion_timing_unknown"},["HecarimRamp"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="empowered_attack",["record"]="9f4b3437",["role"]="caster",["status"]="cast_motion_timing_unknown"},["HecarimUlt"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="7d580bab",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Illaoi"]={["IllaoiW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="e7f7fb3c",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Irelia"]={["IreliaQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="559d3602",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Ivern"]={["IvernQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="dfc0ea08",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Jade_Ahri"]={["Jade_AhriR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="9f9b7a01",["role"]="caster",["status"]="cast_motion_timing_unknown"},["Jade_AhriTumble"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="9f9b7a01",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Akali"]={["Jade_AkaliR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="ecccc4d3",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Alistar"]={["Jade_AlistarW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="d6f873e9",["role"]="caster",["status"]="cast_motion_timing_unknown"},["Jade_Alistar_Headbutt"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="d6f873e9",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Amumu"]={["Jade_AmumuBandageToss"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="dbe32de8",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Jade_Corki"]={["Jade_CorkiW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="167c1285",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Ezreal"]={["Jade_EzrealE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="484dad46",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_FiddleSticks"]={["Jade_FiddlesticksR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="3152c43a",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Fiora"]={["Jade_FioraQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="d9e63e34",["role"]="caster",["status"]="cast_motion_timing_unknown"},["Jade_FioraR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="8466abee",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Jade_Fizz"]={["Jade_FizzE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="a34cae74",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["Jade_FizzQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="880b7dc4",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Gragas"]={["Jade_GragasE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="34ebf6cc",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Jade_Graves"]={["Jade_GravesE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="3f51dc77",["role"]="caster",["status"]="cast_motion_timing_unknown"},["Jade_GravesMove"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="3f51dc77",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_JarvanIV"]={["Jade_JarvanIVCataclysm"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="e9e6d9b4",["role"]="caster",["status"]="cast_motion_timing_unknown"},["Jade_JarvanIVDragonStrike"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="flag_contact",["record"]="75528e00",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Jax"]={["Jade_JaxLeapStrike"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="e4ba6564",["role"]="caster",["status"]="cast_motion_timing_unknown"},["Jade_JaxQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="e4ba6564",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Kassadin"]={["Jade_KassadinR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="9785a4a5",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Katarina"]={["Jade_KatarinaE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_blink",["record"]="921b11aa",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_LeeSin"]={["Jade_LeeSinQTwo"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="c6bb7b85",["role"]="caster",["status"]="cast_motion_timing_unknown"},["Jade_LeeSinWOne"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="697bf3ab",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Leona"]={["Jade_LeonaZenithBlade"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="ea4c4d90",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Jade_Malphite"]={["Jade_MalphiteUFSlash"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="82e176d7",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_MasterYi"]={["Jade_MasterYiAlphaStrike"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="a29ffabd",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["Jade_MasterYiAlphaStrike_Jade"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="a29ffabd",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Jade_Nautilus"]={["Jade_NautilusQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="081e4e0c",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Jade_Nidalee"]={["Jade_NidaleePounce"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="1f3eec17",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Pantheon"]={["Jade_PantheonR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="4257ad6e",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["Jade_PantheonW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="e1e6b6fe",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Poppy"]={["Jade_PoppyE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="c0fda0a9",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Shaco"]={["Jade_ShacoDeceive"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="4e7db2f1",["role"]="caster",["status"]="cast_motion_timing_unknown"},["Jade_ShacoHallucinateFull"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="4372373d",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Jade_Shen"]={["Jade_ShenE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="e868f611",["role"]="caster",["status"]="cast_motion_timing_unknown"},["Jade_ShenR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="cfd6b84d",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Jade_Shyvana"]={["Jade_ShyvanaR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="17bfe0c9",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Tristana"]={["Jade_TristanaW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="a3f9a931",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Tryndamere"]={["Jade_TryndamereE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="16f47364",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_TwistedFate"]={["Jade_TwistedFateE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="03c5ff9d",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Vayne"]={["Jade_VayneQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="6cabf57e",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_Warwick"]={["Jade_WarwickR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="d9a77a83",["role"]="caster",["status"]="cast_motion_timing_unknown"},["Spell_Jade_WarwickR_Jade_Name"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="d9a77a83",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jade_XinZhao"]={["Jade_XinZhaoE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="65bbe52a",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["JarvanIV"]={["JarvanIVCataclysm"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="b8a22699",["role"]="caster",["status"]="cast_motion_timing_unknown"},["JarvanIVDragonStrike"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="flag_contact",["record"]="2e6e6233",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jax"]={["JaxLeapStrike"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="d013db15",["role"]="caster",["status"]="cast_motion_timing_unknown"},["JaxQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="d013db15",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Jayce"]={["JayceToTheSkies"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="d92275de",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["KSante"]={["KSanteE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="b10b69ac",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["KSanteR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="9e51853e",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["KSanteW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="5df6d404",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["KSanteW_AllOut"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="7ac3757c",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["ViQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="5df6d404",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Kaisa"]={["KaisaR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="c6cf8c09",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Kalista"]={["KalistaMysticShot"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="bb32079f",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["KalistaPassiveBuff"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="a01ea455",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Kassadin"]={["RiftWalk"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="e1613a1e",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Katarina"]={["KatarinaEWrapper"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="6e72ff69",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Kayn"]={["KaynE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="steerable",["record"]="11a87d5f",["role"]="caster",["status"]="cast_motion_timing_unknown"},["KaynQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="86102787",["role"]="caster",["status"]="cast_motion_timing_unknown"},["KaynR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="3af07951",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Khazix"]={["KhazixE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="cc25a559",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Kindred"]={["KindredQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="801e961b",["role"]="caster",["status"]="cast_motion_timing_unknown"},["KindredQ_URFWrapper"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="473e984e",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Kled"]={["KledE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="ambiguous_asset_alias",["role"]="caster_phase_unresolved",["source_records"]={"2f0a234a","ff9b05fc"},["status"]="cast_motion_timing_unknown"},["KledE2"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="2f0a234a",["role"]="caster",["status"]="cast_motion_timing_unknown"},["KledPassive"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="bce23f7c",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["KledR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="bfe4081e",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["KledRiderQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="43262d94",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Leblanc"]={["LeblancRW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="2be0efb7",["role"]="caster",["status"]="cast_motion_timing_unknown"},["LeblancRWReturn"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="return_anchor",["record"]="8060d5c5",["role"]="caster",["status"]="cast_motion_timing_unknown"},["LeblancW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="9e241b91",["role"]="caster",["status"]="cast_motion_timing_unknown"},["LeblancWReturn"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="return_anchor",["record"]="3f47cc2b",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["LeeSin"]={["LeeSinQTwo"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="45c13604",["role"]="caster",["status"]="cast_motion_timing_unknown"},["LeeSinWOne"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="b0bdf97a",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Leona"]={["LeonaZenithBlade"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="b75d4fc3",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Lillia"]={["LilliaW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="7adbd7c1",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Lissandra"]={["LissandraE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="projectile_then_optional_recast",["record"]="a1131751",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Locke"]={["LockeE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="a4862468",["role"]="caster",["status"]="cast_motion_timing_unknown"},["LockeW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="33932228",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Lucian"]={["LucianE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="fbc5d69a",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Malphite"]={["UFSlash"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="f5f60e76",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Maokai"]={["MaokaiW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="54ee4620",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["MasterYi"]={["AlphaStrike"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="d92e7768",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["MonkeyKing"]={["MonkeyKingDecoy"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="d57a351a",["role"]="caster",["status"]="cast_motion_timing_unknown"},["MonkeyKingNimbus"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="0c285690",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Naafiri"]={["NaafiriE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="ed9dd43a",["role"]="caster",["status"]="cast_motion_timing_unknown"},["NaafiriW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="1ec7d9ae",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Nautilus"]={["NautilusAnchorDrag"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="fa3b0257",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Nidalee"]={["Pounce"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="968ed22f",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Nilah"]={["NilahE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="66e74808",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Nocturne"]={["NocturneParanoia2"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="4cefd0c2",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Nunu"]={["NunuW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="steerable",["record"]="354a71fe",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Ornn"]={["OrnnE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="bf291d15",["role"]="caster",["status"]="cast_motion_timing_unknown"},["OrnnW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="bounded_forward_movement",["record"]="40c5ec65",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Pantheon"]={["PantheonR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="af885c69",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["PantheonW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="b1bd6bab",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Poppy"]={["PoppyE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="d97b36e6",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Pyke"]={["PykeE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="f58ed42b",["role"]="caster",["status"]="cast_motion_timing_unknown"},["PykeR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="9f166575",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Qiyana"]={["QiyanaE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="d1c02c91",["role"]="caster",["status"]="cast_motion_timing_unknown"},["QiyanaW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="edea3b6d",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Quinn"]={["QuinnE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="ea8449e3",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Rakan"]={["RakanE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="347e8dc7",["role"]="caster",["status"]="cast_motion_timing_unknown"},["RakanECast"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="af50c1e8",["role"]="caster",["status"]="cast_motion_timing_unknown"},["RakanECastXaya"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="f0a3e6bd",["role"]="caster",["status"]="cast_motion_timing_unknown"},["RakanERecast"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="efc557a5",["role"]="caster",["status"]="cast_motion_timing_unknown"},["RakanW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="b881a3db",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Rammus"]={["Tremors2"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="ec99bb9d",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["RekSai"]={["RekSaiEBurrowed"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="e228f849",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["RekSaiR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="f91b0077",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["RekSaiRWrapper"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="36cd608e",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Rell"]={["RellW_Dismount"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="353a8963",["role"]="caster",["status"]="cast_motion_timing_unknown"},["RellW_MountUp"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="empowered_attack",["record"]="7a3f929a",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Renekton"]={["RenektonSliceAndDice"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="afd59b1c",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Rengar"]={["RengarPassive"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="fc0d743d",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Riven"]={["RivenFeint"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="4b549414",["role"]="caster",["status"]="cast_motion_timing_unknown"},["RivenTriCleave"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="0503aab8",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Samira"]={["SamiraE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="02cd963f",["role"]="caster",["status"]="cast_motion_timing_unknown"},["SamiraPassive"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="f36b7373",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["SamiraPassiveCombo"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="68bcb430",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Sejuani"]={["SejuaniQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="e55035f3",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Sett"]={["SettR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="cb66e070",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Shaco"]={["Deceive"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="a2958f02",["role"]="caster",["status"]="cast_motion_timing_unknown"},["HallucinateFull"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="1d67f72a",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Shen"]={["ShenE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="1e79b3f6",["role"]="caster",["status"]="cast_motion_timing_unknown"},["ShenR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="ac2796f8",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Shyvana"]={["ShyvanaR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="4403b128",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Sion"]={["SionR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="steerable_charge",["record"]="9068b1df",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Skarner"]={["SkarnerE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="steerable_charge_and_carry",["record"]="9023194c",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Smolder"]={["SmolderE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="steerable_flight",["record"]="cd89213c",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Sylas"]={["SylasE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="d06ed7fa",["role"]="caster",["status"]="cast_motion_timing_unknown"},["SylasW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="b8537062",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["TahmKench"]={["TahmKenchW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="0be5ff2f",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Taliyah"]={["TaliyahR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="ec6281fc",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Talon"]={["TalonE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="a62841ba",["role"]="caster",["status"]="cast_motion_timing_unknown"},["TalonQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="6b08ddd2",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Thresh"]={["AhriSeduce"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="000ed512",["role"]="caster",["status"]="cast_motion_timing_unknown"},["ThreshQLeap"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="000ed512",["role"]="caster",["status"]="cast_motion_timing_unknown"},["ThreshW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="cf201df4",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Tristana"]={["TristanaW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="914611ae",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Tryndamere"]={["TryndamereE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="06fd9ca9",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["TwistedFate"]={["Gate"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="3d404705",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Udyr"]={["UdyrE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="bacddfd4",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Urgot"]={["UrgotE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="c390cd61",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Vayne"]={["VayneTumble"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="cd0141dd",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Vex"]={["VexR2"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="25b848a1",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Vi"]={["ViQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="17776de5",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["ViR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="07156abf",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Viego"]={["ViegoPassive"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="possession_transition",["record"]="b575d74c",["role"]="caster",["status"]="cast_motion_timing_unknown"},["ViegoR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="56d913c4",["role"]="caster",["status"]="cast_motion_timing_unknown"},["ViegoW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="982dbbd4",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Volibear"]={["VolibearR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="025ee4ae",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Warwick"]={["WarwickQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="80a152fa",["role"]="caster",["status"]="cast_motion_timing_unknown"},["WarwickR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="c848846e",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["XinZhao"]={["XinZhaoE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="ac9602af",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Yasuo"]={["YasuoDashWrapper"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="2dc604b4",["role"]="caster",["status"]="cast_motion_timing_unknown"},["YasuoE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="4729cd21",["role"]="caster",["status"]="cast_motion_timing_unknown"},["YasuoR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="5e8860b1",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Yone"]={["YoneE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="8d2b10a5",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["YoneQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="0fef7a85",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["YoneR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="b0dd8917",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Yunara"]={["YunaraE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="e66bfa1c",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Yuumi"]={["YuumiE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="3720efd4",["role"]="caster",["status"]="cast_motion_timing_unknown"},["YuumiW"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="53c7a415",["role"]="caster",["status"]="cast_motion_timing_unknown"},["YuumiWAlly"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="7a2b19f7",["role"]="caster",["status"]="cast_motion_timing_unknown"},["YuumiWAttach"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="3720efd4",["role"]="caster",["status"]="cast_motion_timing_unknown"},["YuumiWCast"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="targeted_or_target_relative",["record"]="0adba91e",["role"]="caster",["status"]="cast_motion_timing_unknown"},["YuumiWEnd"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="b7eb7eda",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["YuumiWEndWrapper"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="d91fa89d",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Zaahen"]={["ZaahenE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="46d03e3f",["role"]="caster",["status"]="cast_motion_timing_unknown"},["ZaahenQ"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_recast",["record"]="4056fb0f",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Zac"]={["ZacE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="46e41974",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"}},["Zed"]={["Landslide"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="return_anchor",["record"]="7d9fef31",["role"]="caster",["status"]="cast_motion_timing_unknown"},["ZedR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="conditional_or_multiple_phases",["record"]="723ad699",["role"]="caster_or_recipient",["status"]="cast_motion_timing_unknown"},["ZedR2"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="return_anchor",["record"]="7d9fef31",["role"]="caster",["status"]="cast_motion_timing_unknown"},["ZedW2"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="return_anchor",["record"]="e0c2427d",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Zeri"]={["ZeriE"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="direction_or_ground",["record"]="b30e62f2",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["Zoe"]={["ZoeR"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="blink_or_channelled_relocation",["record"]="ca553bd0",["role"]="caster",["status"]="cast_motion_timing_unknown"}}},["classicIdentities"]=71,["commandTriggers"]={["Ambessa"]={["names"]={["AmbessaE"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="3f70c67a",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"},["AmbessaQ"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="3f70c67a",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"},["AmbessaQ1"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="3f70c67a",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"},["AmbessaQ2"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="3f70c67a",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"},["AmbessaQWrapper"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="3f70c67a",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"},["AmbessaW"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="3f70c67a",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"}}},["Kalista"]={["names"]={["KalistaBasicAttack"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="a01ea455",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"},["KalistaBasicAttackPow"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="a01ea455",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"},["KalistaBasicAttackSlow"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="a01ea455",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"},["KalistaCritAttack"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="a01ea455",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"},["KalistaMysticShot"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="a01ea455",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"},["SonaHymnofValorMissile"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="a01ea455",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"}},["onObservedAutoAttack"]={["castCanTriggerMotion"]=true,["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="attack_or_command_triggered",["record"]="a01ea455",["role"]="caster_command_unresolved",["status"]="cast_motion_timing_unknown"}}},["installedIdentities"]=245,["normalIdentities"]=174,["summoners"]={["classic"]={["SummonerFlash_Jade"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="summoner_stage_review_pending",["role"]="caster",["status"]="cast_motion_timing_unknown"},["SummonerTeleport_Jade"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="summoner_stage_review_pending",["role"]="caster",["status"]="cast_motion_timing_unknown"}},["normal"]={["SummonerCherryFlash"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="summoner_stage_review_pending",["role"]="caster",["status"]="cast_motion_timing_unknown"},["SummonerFlash"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="summoner_stage_review_pending",["role"]="caster",["status"]="cast_motion_timing_unknown"},["SummonerPoroRecall"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="summoner_stage_review_pending",["role"]="caster",["status"]="cast_motion_timing_unknown"},["SummonerPoroThrow"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="summoner_stage_review_pending",["role"]="no_immediate_caster_relocation",["status"]="cast_motion_timing_unknown"},["SummonerSnowURFSnowball_Mark"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="summoner_stage_review_pending",["role"]="no_immediate_caster_relocation",["status"]="cast_motion_timing_unknown"},["SummonerSnowball"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="summoner_stage_review_pending",["role"]="no_immediate_caster_relocation",["status"]="cast_motion_timing_unknown"},["SummonerTeleport"]={["kinematic_accepted"]=false,["native_alias_accepted"]=false,["phase"]="summoner_stage_review_pending",["role"]="caster",["status"]="cast_motion_timing_unknown"}}}}

end)()
M.Catalog=Catalog
local function finite(v)return type(v)=='number'and v==v and v>-huge and v<huge end
local function object(v)return type(v)=='table'or type(v)=='userdata'end
local function point(v)return object(v)and finite(v.x)and finite(v.z or v.y)end
local function copy(v)return {x=v.x,z=v.z or v.y}end
local function distance(a,b)local x,z=b.x-a.x,(b.z or b.y)-(a.z or a.y);return math.sqrt(x*x+z*z)end
local function readNode(unit,index)
 local ok,value=pcall(unit.GetPath,unit,index)
 if ok then return value end
end
function M.PendingCast(unit,now)
 if not object(unit)or not finite(now)then return nil end
 local spell=unit.activeSpell
 if not object(spell)or spell.valid~=true or spell.isStopped==true or type(spell.name)~='string'then return nil end
 local finish=spell.endTime
 if not finite(finish)or finish<=0 then finish=spell.castEndTime end
 if finite(finish)and finish>0 and finish<=now then return nil end
 local own=Catalog.champions[unit.charName]
 local hint=own and own[spell.name]
 local trigger=Catalog.commandTriggers and Catalog.commandTriggers[unit.charName]
 if trigger then
  local command=trigger.names[spell.name]
  if not command and trigger.onObservedAutoAttack then
   local sdk=_G.SDK;local control=sdk and sdk.ControlWindow
   local attack=spell.isAutoAttack==true
   if not attack and control and type(control.IsAttackCast)=='function'then attack=control.IsAttackCast(spell,sdk.Data)end
   if attack then command=trigger.onObservedAutoAttack end
  end
  hint=command or hint
 end
 if not hint then
  local profile=type(unit.charName)=='string'and unit.charName:match('^Jade_')and 'classic'or 'normal'
  hint=Catalog.summoners[profile][spell.name]
 end
 if hint and(hint.role=='no_immediate_caster_relocation'
  or hint.phase=='attack_or_command_triggered'and not hint.castCanTriggerMotion or hint.phase=='empowered_attack')then return nil end
 return hint
end
function M.AnnotateControl(state,unit,now)
 local hint=M.PendingCast(unit,now)
 if hint then state.pendingCasterMotion=hint;state.castEnd=0;state.attackEnd=0 end
 state.motionClassified=true
 return state
end
local function sameState(snapshot,unit)
 if not object(unit)or snapshot.unit~=unit or snapshot.id~=unit.networkID or snapshot.identity~=unit.charName then return false end
 local path=unit.pathing
 return object(path)and path.isDashing==true and path.dashSpeed==snapshot.speed and point(unit.pos)
  and point(path.endPos)and distance(path.endPos,snapshot.to)<=.001
  and distance(unit.pos,snapshot.from)<=.001 and unit.ms==snapshot.walkingSpeed
  and path.pathIndex==snapshot.pathIndex and path.pathCount==snapshot.pathCount
end
function M.ReadPath(unit,now,control)
  if not object(unit)or not finite(now)or not point(unit.pos)then return nil,'invalid_motion_unit'end
  if control and(type(control)~='table'or control.unavailable or control.truncated)then return nil,'native_motion_control_state_unknown'end
  if not finite(unit.networkID)or unit.networkID<=0 or type(unit.charName)~='string'or unit.charName==''then
   return nil,'motion_identity_unknown'
  end
  local path=unit.pathing
  if not object(path)or path.isDashing~=true then return nil,'no_observed_dash'end
  local hint=M.PendingCast(unit,now)
  if hint and type(hint.phase)=='string'and hint.phase:find('steerable',1,true)then
   return nil,'native_dash_direction_not_committed'
  end
 if not point(path.endPos)or not finite(path.dashSpeed)or path.dashSpeed<=0 or path.dashSpeed>100000 then
  return nil,'native_dash_parameters_unknown'
 end
  local from,to,speed=copy(unit.pos),copy(path.endPos),path.dashSpeed
  local identity,id=unit.charName,unit.networkID
  local first,last=path.pathIndex,path.pathCount
  if(first==nil)~=(last==nil)then return nil,'native_dash_segments_unknown'end
  local walkingSpeed=finite(unit.ms)and unit.ms>=0 and unit.ms or nil
  local length=distance(from,to)
 if length<=.001 then return nil,'dash_already_at_endpoint'end
  if length/speed>5 then return nil,'native_dash_horizon_unknown'end
 -- Curved or segmented native movement cannot be replaced by one straight ray.
  local nodes
  if first~=nil and last~=nil then
  if not finite(first)or not finite(last)or first%1~=0 or last%1~=0 or first<0
   or last<first or last-first>3 then return nil,'native_dash_segments_unknown'end
  if last>first and type(unit.GetPath)~='function'then return nil,'native_dash_segments_unknown'end
   if type(unit.GetPath)=='function'then
    nodes={}
    local dx,dz=to.x-from.x,to.z-from.z
   for i=first,last do
     local p=readNode(unit,i)
    if not point(p)then return nil,'native_dash_segments_unknown'end
     local x,z=p.x-from.x,(p.z or p.y)-from.z
    local along=(x*dx+z*dz)/length
     if math.abs(x*dz-z*dx)/length>1 or along < -1 or along>length+1 then
     return nil,'native_dash_not_straight'
     end
     nodes[#nodes+1]=copy(p)
   end
  end
 end
  local snapshot={unit=unit,id=id,identity=identity,at=now,
   from=from,to=to,duration=length/speed,
   speed=speed,walkingSpeed=walkingSpeed,
   walkingKnownFor=control and control.slowObserved and control.speedStableFor or huge,
   pathIndex=first,pathCount=last,nodes=nodes,
   evidence='native_path',kind='continuous',guaranteed=false}
  if not sameState(snapshot,unit)then return nil,'native_motion_changed_during_read'end
  return snapshot
end
function M.Fresh(snapshot,unit,now)
  if not snapshot or not object(unit)or snapshot.unit~=unit or snapshot.id~=unit.networkID or snapshot.identity~=unit.charName
  or not finite(now)or now<snapshot.at or now-snapshot.at>.05 then return false,'motion_identity_or_age_changed'end
  if not sameState(snapshot,unit)then return false,'motion_changed'end
  if snapshot.nodes then
   if type(unit.GetPath)~='function'then return false,'motion_changed'end
   for i,node in ipairs(snapshot.nodes)do
    local current=readNode(unit,snapshot.pathIndex+i-1)
    if not point(current)or distance(current,node)>.001 then return false,'motion_changed'end
   end
  end
  local hint=M.PendingCast(unit,now)
  if hint and type(hint.phase)=='string'and hint.phase:find('steerable',1,true)then
   return false,'native_dash_direction_not_committed'
  end
  if not sameState(snapshot,unit)then return false,'motion_changed'end
 return true
end
function M.Sample(snapshot,after)
 if not snapshot or not finite(after)or after<0 or after>5 then return nil,nil,'invalid_motion_horizon'end
 if after<=snapshot.duration then
  local ratio=after/snapshot.duration
  return {x=snapshot.from.x+(snapshot.to.x-snapshot.from.x)*ratio,
   z=snapshot.from.z+(snapshot.to.z-snapshot.from.z)*ratio},0
 end
 if not finite(snapshot.walkingSpeed)or after>(snapshot.walkingKnownFor or huge)then
  return copy(snapshot.to),nil,'post_landing_speed_unknown'
 end
 -- The landing point is the centre of possible walking, not a stationary target.
 return copy(snapshot.to),snapshot.walkingSpeed*(after-snapshot.duration)
end
local function roots(a,b,c)
 if math.abs(a)<1e-9 then
  if math.abs(b)<1e-9 then return c==0 and 0 or nil end
  return -c/b
 end
 local d=b*b-4*a*c;if d<0 then return nil end
 local q=-.5*(b+(b>=0 and 1 or -1)*math.sqrt(d))
 if q==0 then return -b/(2*a)end
 local x,y=q/a,c/q
 if x>y then x,y=y,x end
 return x,y
end
-- A fixed outgoing ray and a moving blocker must overlap in space AND time.
-- Delay is already the final launch delay; this layer adds no transport latency.
-- After landing, an enclosing walking footprint can establish possible contact
-- or exclusion, never a confirmed future hit. Caller still checks Fresh.
function M.RayContacts(snapshot,source,destination,projectileSpeed,delay,radius)
 if not snapshot or not point(snapshot.from)or not point(snapshot.to)
  or not finite(snapshot.duration)or snapshot.duration<=0 or snapshot.duration>5
  or not point(source)or not point(destination)or not finite(delay)or delay<0 or delay>5
  or not finite(radius)or radius<0 or type(projectileSpeed)~='number'
  or projectileSpeed~=projectileSpeed or projectileSpeed<=0 then return nil,'invalid_motion_ray'end
 local dx,dz=destination.x-source.x,(destination.z or destination.y)-(source.z or source.y)
 local length=math.sqrt(dx*dx+dz*dz)
 if length<=.001 then return nil,'invalid_motion_ray'end
 local function closest(position,a,b)
  local x,z=b.x-a.x,b.z-a.z;local n=x*x+z*z
  local f=n>0 and math.max(0,math.min(1,((position.x-a.x)*x+(position.z-a.z)*z)/n))or 0
  local p={x=a.x+x*f,z=a.z+z*f};return distance(position,p),p
 end
 if projectileSpeed==huge then
  local position,escape,why=M.Sample(snapshot,delay)
  if escape==nil then return nil,why end
  local gap,nearest=closest(position,copy(source),copy(destination))
  return {hit=gap<=radius+escape,phase='sampled_ray',position=position,nearest=nearest,
   timeLowerBound=delay,conservative=escape>0,guaranteed=false}
 end
 if not finite(projectileSpeed)then return nil,'invalid_motion_ray'end
 local finish=delay+length/projectileSpeed
 if finish>5 then return nil,'motion_ray_horizon_unknown'end
 local px,pz=dx/length*projectileSpeed,dz/length*projectileSpeed
 local function projectile(t)return {x=source.x+px*(t-delay),z=(source.z or source.y)+pz*(t-delay)}end
 local ending=math.min(snapshot.duration,finish)
 if ending>=delay then
  local vx,vz=(snapshot.to.x-snapshot.from.x)/snapshot.duration,(snapshot.to.z-snapshot.from.z)/snapshot.duration
  local ax,az=snapshot.from.x-source.x+px*delay,snapshot.from.z-(source.z or source.y)+pz*delay
  local bx,bz=vx-px,vz-pz;local a=bx*bx+bz*bz
  local t=a>0 and math.max(delay,math.min(ending,-(ax*bx+az*bz)/a))or delay
  local x,z=ax+bx*t,az+bz*t
  if x*x+z*z<=radius*radius then
   local entry=delay
   if(ax+bx*delay)^2+(az+bz*delay)^2>radius*radius then
    local first=roots(a,2*(ax*bx+az*bz),ax*ax+az*az-radius*radius)
    if first then entry=math.max(delay,math.min(t,first))end
   end
   return {hit=true,phase='native_prefix',timeLowerBound=entry,
    position=M.Sample(snapshot,entry),nearest=projectile(entry),conservative=false,guaranteed=false}
  end
 end
 if finish>snapshot.duration then
  local _,escape,why=M.Sample(snapshot,finish)
  if escape==nil then return nil,why end
  local start=math.max(delay,snapshot.duration)
  local gap,nearest=closest(snapshot.to,projectile(start),copy(destination))
  if gap<=radius+escape then return {hit=true,phase='post_landing_envelope',timeLowerBound=start,
   position=copy(snapshot.to),nearest=nearest,conservative=true,guaranteed=false}end
 end
 return {hit=false,phase='bounded_exclusion',guaranteed=false}
end
function M.Intercept(snapshot,source,projectileSpeed,launchDelay,radius)
 if not snapshot or not point(source)or not finite(launchDelay)or launchDelay<0 or launchDelay>5
  or not finite(radius)or radius<0 or type(projectileSpeed)~='number'
  or projectileSpeed~=projectileSpeed or projectileSpeed<=0 then return nil,'invalid_interception'end
 local impact
 if projectileSpeed==huge then impact=launchDelay
 elseif finite(projectileSpeed)then
  local vx=(snapshot.to.x-snapshot.from.x)/snapshot.duration
  local vz=(snapshot.to.z-snapshot.from.z)/snapshot.duration
  local x,z=snapshot.from.x-source.x,snapshot.from.z-(source.z or source.y)
  -- |target(t)-source| = projectileSpeed * (t-launchDelay).
  local s2=projectileSpeed*projectileSpeed
  local a=vx*vx+vz*vz-s2
  local b=2*(x*vx+z*vz+s2*launchDelay)
  local c=x*x+z*z-s2*launchDelay*launchDelay
  local first,last=roots(a,b,c)
  for _,t in ipairs({first or -1,last or -1})do
   if t>=launchDelay and t<=snapshot.duration and (not impact or t<impact)then impact=t end
  end
  if not impact then
   local at=launchDelay+distance(source,snapshot.to)/projectileSpeed
   if at>=snapshot.duration then impact=at end
  end
 end
 if not impact or impact>5 then return nil,'no_bounded_interception'end
 local pos,escape,why=M.Sample(snapshot,impact)
 if not pos or escape==nil then return nil,why end
 return {position=pos,impact=impact,postLandingSeconds=math.max(0,impact-snapshot.duration),
  escapeRadius=escape,footprintCovered=escape<radius,remainingRadius=math.max(0,radius-escape),
  motion=snapshot,guaranteed=false}
end
return M

end)()

YasuoWall = {
	HasYasuo = false,
	Hero = nil,
	wallCastPos = nil,
	wallPos = nil,
	wallLevel = 0,
	wallCastTime = 0,
	LastScanTime = 0,
	WALL_DURATION = 4,
	SCAN_INTERVAL = 0.1,
}

function YasuoWall:OnEnemyHeroLoad(args)
	if args.charName == "Yasuo" or args.charName == "Jade_Yasuo" then
		self.HasYasuo = true
		self.Hero = args.unit
	end
end

function YasuoWall:OnTick()
	local currentTime = Game.Timer()
	if self.wallCastTime > 0 and currentTime - self.wallCastTime > self.WALL_DURATION then
		self.wallLevel = 0
		self.wallCastTime = 0
		self.wallCastPos = nil
		self.wallPos = nil
	end
	if not self.HasYasuo or not self.Hero or not Game.ParticleCount then return end
	if currentTime - self.LastScanTime < self.SCAN_INTERVAL then
		return
	end
	self.LastScanTime = currentTime
	local wLevel = self.Hero:GetSpellData(_W).level
	if wLevel > self.wallLevel then
		self.wallLevel = wLevel
	end
	local pCount = Game.ParticleCount()
	for i = 1, pCount do
		local obj = Game.Particle(i)
		if obj and obj.pos then
			local name = obj.name
			if name then
				local lower = name:lower()
				if lower:find("yasuo", 1, true) then
					if lower:find("_w_windwall_activate", 1, true) then
						if not self.wallCastPos then
							self.wallCastPos = Math:Get2D(obj.pos)
						end
						if self.wallCastTime == 0 then
							self.wallCastTime = currentTime
						end
					elseif lower:find("_w_windwall_enemy", 1, true) then
						self.wallPos = obj.pos
					end
				end
			end
		end
	end
end

function YasuoWall:IsWallActive()
	return self.HasYasuo and self.wallCastPos and self.wallPos and Game.Timer() - self.wallCastTime <= self.WALL_DURATION
end

function YasuoWall:CheckCollision(source, castPos)
	if not self:IsWallActive() then
		return false
	end
	local pos = Math:Get2D(self.wallPos)
	local wallThickness = 100
	local width = 250 + 70 * self.wallLevel + wallThickness
	local direction = Math:Perpendicular(Math:Normalized(pos, self.wallCastPos))
	local startPos = Math:Extended(pos, direction, width / 2)
	local endPos = Math:Extended(startPos, direction, -width)
	local intersectionResult = Math:Intersection(startPos, endPos, source, castPos)
	return intersectionResult.Intersects
end

-- No menu (player menu standard 2026-10-11): range share, fallback ping and extra delay are tuning
-- values, not player choices, so prediction keeps these defaults. Measured ping is used when the host has it.
local function fixed(value)return {Value=function()return value end}end
Menu =
{
    MaxRange = fixed(100),
    Latency = fixed(50),
    ExtraDelay = fixed(60),
}

function Menu:GetMaxRange()
	local result = self.MaxRange:Value() * 0.01
	return result
end

function Menu:GetLatency()
	local latency = Game.Latency()
	local result = type(latency)=='number' and latency==latency and latency>=0 and latency<math_huge and latency or self.Latency:Value()
	return result * 0.001
end

function Menu:GetExtraDelay()
	local result = self.ExtraDelay:Value() * 0.001
	return result
end
local function launchDelay(delay)
	if type(delay)~='number'or delay~=delay or delay<0 or delay==math_huge then return math_huge end
	return delay+Menu:GetLatency()/2+Menu:GetExtraDelay()
end
--[[
enum class BuffType {
    Internal = 0,
    Aura = 1,
    CombatEnchancer = 2,
    CombatDehancer = 3,
    SpellShield = 4,
    Stun = 5,
    Invisibility = 6,
    Silence = 7,
    Taunt = 8,
    Berserk = 9,
    Polymorph = 10,
    Slow = 11,
    Snare = 12,
    Damage = 13,
    Heal = 14,
    Haste = 15,
    SpellImmunity = 16,
    PhysicalImmunity = 17,
    Invulnerability = 18,
    AttackSpeedSlow = 19,
    NearSight = 20,
    Fear = 22,
    Charm = 23,
    Poison = 24,
    Suppression = 25,
    Blind = 26,
    Counter = 27,
    Currency = 21,
    Shred = 28,
    Flee = 29,
    Knockup = 30,
    Knockback = 31,
    Disarm = 32,
    Grounded = 33,
    Drowsy = 34,
    Asleep = 35,
    Obscured = 36,
    ClickProofToEnemies = 37,
    Unkillable = 38
};
--]]

Immobile = {
	IMMOBILE_TYPES = {
		[5] = true,
		[12] = true,
		[25] = true,
		[30] = true,
		[35] = true,
	},
}

function Immobile:GetDuration(unit)
	local r=self:Read(unit)
	return r.stationaryDuration,r.castEnd,r.attackEnd,r.knockDuration
end
function Immobile:Read(unit)
	local now=Game.Timer()
	local state=ControlWindow.ReadCached(unit,SDK and SDK.BuffManager,now)
	return state.motionClassified and state or ChampionMotion.AnnotateControl(state,unit,now)
end
function Immobile:CanHit(unit, timeToHit, radius)
	local r=ControlWindow.Assess(self:Read(unit),timeToHit,radius or 0,unit.ms or 0,.02,unit.pathing and unit.pathing.isDashing)
	return r.canHitFromCurrentPosition,r.isLocked,r.stationaryDuration,r.knockDuration,r
end
Math = {}

function Math:Get2D(p)
	p = p.pos == nil and p or p.pos
	return { x = p.x, z = p.z == nil and p.y or p.z }
end

function Math:Get3D(p)
	local result = Vector(p.x, p.y, p.z)
	return result
end

function Math:GetDistance(p1, p2)
	local dx = p2.x - p1.x
	local dz = p2.z - p1.z
	return math_sqrt(dx * dx + dz * dz)
end

function Math:IsInRange(p1, p2, range)
	local dx = p1.x - p2.x
	local dz = p1.z - p2.z
	if dx * dx + dz * dz <= range * range then
		return true
	end
	return false
end

function Math:VectorsEqual(p1, p2, num)
	num = num or 5
	if self:GetDistance(p1, p2) < num then
		return true
	end
	return false
end

function Math:Normalized(p1, p2)
	local dx = p1.x - p2.x
	local dz = p1.z - p2.z
	local length = math_sqrt(dx * dx + dz * dz)
	local sol = nil
	if length > 0 then
		local inv = 1.0 / length
		sol = { x = (dx * inv), z = (dz * inv) }
	end
	return sol
end

function Math:Extended(vec, dir, range)
	if dir == nil then
		return vec
	end
	return { x = vec.x + dir.x * range, z = vec.z + dir.z * range }
end

function Math:Perpendicular(dir)
	if dir == nil then
		return nil
	end
	return { x = -dir.z, z = dir.x }
end

function Math:Intersection(s1, e1, s2, e2)
	local IntersectionResult = { Intersects = false, Point = { x = 0, z = 0 } }
	local deltaACz = s1.z - s2.z
	local deltaDCx = e2.x - s2.x
	local deltaACx = s1.x - s2.x
	local deltaDCz = e2.z - s2.z
	local deltaBAx = e1.x - s1.x
	local deltaBAz = e1.z - s1.z
	local denominator = deltaBAx * deltaDCz - deltaBAz * deltaDCx
	local numerator = deltaACz * deltaDCx - deltaACx * deltaDCz
	if denominator == 0 then
        if numerator ~= 0 then return IntersectionResult end
        local length2=deltaBAx*deltaBAx+deltaBAz*deltaBAz
        if length2==0 then
            local dx,dz=e2.x-s2.x,e2.z-s2.z
            local cross=(s1.x-s2.x)*dz-(s1.z-s2.z)*dx
            if cross==0 and s1.x>=math_min(s2.x,e2.x) and s1.x<=math_max(s2.x,e2.x)
                and s1.z>=math_min(s2.z,e2.z) and s1.z<=math_max(s2.z,e2.z) then
                return {Intersects=true,Point={x=s1.x,z=s1.z}}
            end
            return IntersectionResult
        end
        local t0=((s2.x-s1.x)*deltaBAx+(s2.z-s1.z)*deltaBAz)/length2
        local t1=((e2.x-s1.x)*deltaBAx+(e2.z-s1.z)*deltaBAz)/length2
        local lo,hi=math_max(0,math_min(t0,t1)),math_min(1,math_max(t0,t1))
        if lo<=hi then return {Intersects=true,Point={x=s1.x+lo*deltaBAx,z=s1.z+lo*deltaBAz}} end
        return IntersectionResult
    end
	local r = numerator / denominator
	if r < 0 or r > 1 then
		return IntersectionResult
	end
	local s = (deltaACz * deltaBAx - deltaACx * deltaBAz) / denominator
	if s < 0 or s > 1 then
		return IntersectionResult
	end
	local point = { x = s1.x + r * deltaBAx, z = s1.z + r * deltaBAz }
	return { Intersects = true, Point = point }
end

function Math:ClosestPointOnLineSegment(p, p1, p2)
	local px = p.x
	local pz = p.z
	local ax = p1.x
	local az = p1.z
	local bx = p2.x
	local bz = p2.z
	local bxax = bx - ax
	local bzaz = bz - az
	local length2 = bxax * bxax + bzaz * bzaz
	if length2 == 0 then return {x=ax,z=az}, false end
	local t = ((px - ax) * bxax + (pz - az) * bzaz) / length2
	if t < 0 then
		return p1, false
	end
	if t > 1 then
		return p2, false
	end
	return { x = ax + t * bxax, z = az + t * bzaz }, true
end

function Math:Intercept(src, spos, epos, sspeed, tspeed)
	local dx = epos.x - spos.x
	local dz = epos.z - spos.z
	local magnitude = math_sqrt(dx * dx + dz * dz)
	local tx = spos.x - src.x
	local tz = spos.z - src.z
	if sspeed<=0 then return nil end
	if sspeed==math_huge then return 0 end
	if magnitude==0 or tspeed==0 then return math_sqrt(tx*tx+tz*tz)/sspeed end
	local tvx = (dx / magnitude) * tspeed
	local tvz = (dz / magnitude) * tspeed
	local a = tvx * tvx + tvz * tvz - sspeed * sspeed
	local b = 2 * (tvx * tx + tvz * tz)
	local c = tx * tx + tz * tz
	local ts
	if math_abs(a) < 1e-6 then
		if math_abs(b) < 1e-6 then
			if math_abs(c) < 1e-6 then
				ts = { 0, 0 }
			end
		else
			ts = { -c / b, -c / b }
		end
	else
		local disc = b * b - 4 * a * c
		if disc >= 0 then
			disc = math_sqrt(disc)
			local a = 2 * a
			ts = { (-b - disc) / a, (-b + disc) / a }
		end
	end
	local sol
	if ts then
		local t0 = ts[1]
		local t1 = ts[2]
		local t = math_min(t0, t1)
		if t < 0 then
			t = math_max(t0, t1)
		end
		if t > 0 then
			sol = t
		end
	end
	return sol
end

function Math:Polar(p1)
	local x = p1.x
	local z = p1.z
	if x == 0 then
		if z > 0 then
			return 90
		end
		if z < 0 then
			return 270
		end
		return 0
	end
	local theta = math_atan(z / x) * (180.0 / math_pi) --RadianToDegree
	if x < 0 then
		theta = theta + 180
	end
	if theta < 0 then
		theta = theta + 360
	end
	return theta
end

function Math:AngleBetween(p1, p2)
	if p1 == nil or p2 == nil then
		return nil
	end
	local theta = self:Polar(p1) - self:Polar(p2)
	if theta < 0 then
		theta = theta + 360
	end
	if theta > 180 then
		theta = 360 - theta
	end
	return theta
end

function Math:FindAngle(p1, center, p2)
	local b = math_pow(center.x - p1.x, 2) + math_pow(center.z - p1.z, 2)
	local a = math_pow(center.x - p2.x, 2) + math_pow(center.z - p2.z, 2)
	local c = math_pow(p2.x - p1.x, 2) + math_pow(p2.z - p1.z, 2)
	if a==0 or b==0 then return 0 end
	local cosine=math_max(-1,math_min(1,(a + b - c) / math_sqrt(4 * a * b)))
	local angle = math_acos(cosine) * (180 / math_pi)
	if angle > 90 then
		angle = 180 - angle
	end
	return angle
end

function Math:CircleCircleIntersection(center1, center2, radius1, radius2)
	local result = {}
	local D = self:GetDistance(center1, center2)
	if radius1<0 or radius2<0 or D==0 or D > radius1 + radius2 or D < math_abs(radius1 - radius2) then
		return result
	end
	local A = (radius1 * radius1 - radius2 * radius2 + D * D) / (2 * D)
	local H = math_sqrt(math_max(0,radius1 * radius1 - A * A))
	local Direction = self:Normalized(center2, center1)
	local PA = self:Extended(center1, Direction, A)
	local DirectionPerpendicular = self:Perpendicular(Direction)
	table_insert(result, self:Extended(PA, DirectionPerpendicular, H))
	if H>0 then table_insert(result, self:Extended(PA, DirectionPerpendicular, -H)) end
	return result
end

function Math:MEC(points)
	local n = #points
	if n == 0 then
		return nil, 0
	end
	if n == 1 then
		return { x = points[1].x, z = points[1].z }, 0
	end
	local bestC, bestR = nil, math_huge
	local function covers(cx, cz, r)
		local r2 = (r + 0.01) * (r + 0.01)
		for k = 1, n do
			local dx, dz = points[k].x - cx, points[k].z - cz
			if dx * dx + dz * dz > r2 then
				return false
			end
		end
		return true
	end
	for i = 1, n - 1 do
		for j = i + 1, n do
			local cx, cz = (points[i].x + points[j].x) / 2, (points[i].z + points[j].z) / 2
			local dx, dz = points[i].x - cx, points[i].z - cz
			local r = math_sqrt(dx * dx + dz * dz)
			if r < bestR and covers(cx, cz, r) then
				bestC, bestR = { x = cx, z = cz }, r
			end
		end
	end
	for i = 1, n - 2 do
		for j = i + 1, n - 1 do
			for k = j + 1, n do
				local ax, az = points[i].x, points[i].z
				local bx, bz = points[j].x, points[j].z
				local cx, cz = points[k].x, points[k].z
				local d = 2 * (ax * (bz - cz) + bx * (cz - az) + cx * (az - bz))
				if math_abs(d) > 1e-6 then
					local a2, b2, c2 = ax * ax + az * az, bx * bx + bz * bz, cx * cx + cz * cz
					local ux = (a2 * (bz - cz) + b2 * (cz - az) + c2 * (az - bz)) / d
					local uz = (a2 * (cx - bx) + b2 * (ax - cx) + c2 * (bx - ax)) / d
					local dx, dz = ax - ux, az - uz
					local r = math_sqrt(dx * dx + dz * dz)
					if r < bestR and covers(ux, uz, r) then
						bestC, bestR = { x = ux, z = uz }, r
					end
				end
			end
		end
	end
	return bestC, bestR
end

Path = {}

function Path:GetLenght(path)
	local result = 0
	for i = 1, #path - 1 do
		result = result + Math:GetDistance(path[i], path[i + 1])
	end
	return result
end

function Path:CutPath(path, distance)
	local result = {}
	if distance <= 0 then
		return path
	end
	for i = 1, #path - 1 do
		local a, b = path[i], path[i + 1]
		local dist = Math:GetDistance(a, b)
		if dist > distance then
			table_insert(result, Math:Extended(a, Math:Normalized(b, a), distance))
			for j = i + 1, #path do
				table_insert(result, path[j])
			end
			break
		end
		distance = distance - dist
	end
	return #result > 0 and result or { path[#path] }
end  
function Path:CutPath2(path, distance, endPoint)
    local result = {}
    if distance <= 0 then
        return path
    end
    for i = 1, #path - 1 do
        local a, b = path[i], path[i + 1]
        local dist = Math:GetDistance(a, b)
        if dist > distance then
            table_insert(result, Math:Extended(a, Math:Normalized(b, a), distance))
            for j = i + 1, #path do
                table_insert(result, path[j])
            end
			distance=0
            break
        end
        distance = distance - dist
    end
    
    -- Check if there's still some distance left and if endPoint is provided
    if distance > 0 and endPoint then
        local lastPoint = result[#result] or path[#path]
        local distanceToEnd = Math:GetDistance(lastPoint, endPoint)
        
        -- If the distance to the endPoint is less than the remaining distance,
        -- then just add the endPoint to the result
		local backfillDistance = math_max(distance - 5, 0)
		if distanceToEnd <= backfillDistance then
            table_insert(result, endPoint)
        else
			table_insert(result, Math:Extended(lastPoint, Math:Normalized(endPoint, lastPoint), backfillDistance))
        end
    end
    
    return #result > 0 and result or { path[#path] }
end






function Path:ReversePath(path)
	local result = {}
	for i = #path, 1, -1 do
		table_insert(result, path[i])
	end
	return result
end

function Path:GetPath(unit)
	local currentPos = Math:Get2D(unit.pos)
	local result = { currentPos }
	local pathing = unit.pathing
	if not pathing or not pathing.hasMovePath then
		return result
	end

	if pathing.isDashing then
		local endPos = pathing.endPos
		if endPos ~= nil and endPos.x ~= nil then
			local point = Math:Get2D(endPos)
			if not Math:VectorsEqual(currentPos, point, 1) then
				table_insert(result, point)
			end
		end
		return result
	end

	local pathIndex = pathing.pathIndex or 0
	local pathCount = pathing.pathCount or -1
	for i = pathIndex, pathCount do
		local pos = unit.GetPath and unit:GetPath(i)
		if pos ~= nil and pos.x ~= nil then
			local point = Math:Get2D(pos)
			if not Math:VectorsEqual(result[#result], point, 1) then
				table_insert(result, point)
			end
		end
	end
	return result
end

function Path:GetPredictedPath(source, speed, movespeed, path)
	local result = {}
	local tT = 0
	for i = 1, #path - 1 do
		local a = path[i]
		table_insert(result, a)
		local b = path[i + 1]
		local tB = Math:GetDistance(a, b) / movespeed
		local direction = Math:Normalized(b, a)
		a = Math:Extended(a, direction, -(movespeed * tT))
		local t = Math:Intercept(source, a, b, speed, movespeed)
		if t and t >= tT and t <= tT + tB then
			table_insert(result, Math:Extended(a, direction, t * movespeed))
			return result, t
		end
		tT = tT + tB
	end
	return nil, -1
end
UnitData = {
	Visible = {},
	Waypoints = {},
}

function UnitData:OnVisible(id, visible)
	if self.Visible[id] == nil then
		self.Visible[id] = { visible = visible, visibleTick = GetTickCount(), invisibleTick = GetTickCount() }
	end
	if visible then
		if not self.Visible[id].visible then
			self.Visible[id].visible = true
			self.Visible[id].visibleTick = GetTickCount()
		end
	else
		if self.Visible[id].visible then
			self.Visible[id].visible = false
			self.Visible[id].invisibleTick = GetTickCount()
		end
	end
end

function UnitData:OnWaypoint(id, path, hasMovePath, isDashing, endPos)
	local timer = GetTickCount()
	if self.Waypoints[id] == nil then
		self.Waypoints[id] = {
			moving = hasMovePath,
			dashing = isDashing,
			path = path,
			tick = timer,
			stoptick = timer,
			pos = endPos,
		}
	end
	if hasMovePath then
		if not Math:VectorsEqual(self.Waypoints[id].pos, endPos, 50) then
			self.Waypoints[id].tick = timer
		end
		self.Waypoints[id].pos = endPos
	elseif self.Waypoints[id].moving then
		self.Waypoints[id].stoptick = GetTickCount()
	end
	-- path=nil (an allied hero in the per-tick pass) keeps the stored path; a
	-- prediction reads its target's whole path itself (OnPrediction) before using it.
	if path ~= nil then self.Waypoints[id].path = path end
	self.Waypoints[id].moving = hasMovePath
	self.Waypoints[id].dashing = isDashing
end

function UnitData:OnTick()
	local id, visible, path, pathing, hasMovePath, isDashing, endPos
	for i, unit in ipairs(ObjectManager:GetHeroes()) do
		if not YasuoWall.HasYasuo and unit.isEnemy and (unit.charName=='Yasuo' or unit.charName=='Jade_Yasuo') then
			YasuoWall:OnEnemyHeroLoad({charName=unit.charName,unit=unit})
		end
		id = unit.networkID
		visible = unit.visible
		self:OnVisible(id, visible)
		if visible then
			pathing = unit.pathing
			if pathing then
				hasMovePath = pathing.hasMovePath
				isDashing = pathing.isDashing
				endPos = Math:Get2D(pathing.endPos or unit.pos)
				-- An enemy's last visible path serves fog predictions, so it is read every
				-- tick. An allied hero is always visible when predicted, and GetPrediction
				-- reads its target's path itself (OnPrediction) before any path use.
				path = unit.isEnemy and Path:GetPath(unit) or nil
				self:OnWaypoint(id, path, hasMovePath, isDashing, endPos)
			end
		end
	end
end

function UnitData:OnPrediction(unit)
	local id = unit.networkID
	local visible = unit.visible
	self:OnVisible(id, visible)
	if visible and unit.pathing then
		local hasMovePath = unit.pathing.hasMovePath
		local isDashing = unit.pathing.isDashing
		local endPos = Math:Get2D(unit.pathing.endPos or unit.pos)
		self:OnWaypoint(id, Path:GetPath(unit), hasMovePath, isDashing, endPos)
	end
end

-- One observation pass per host tick. Prediction itself refreshes its target,
-- so correctness does not depend on Draw frequency or callback ordering.
Callback.Add("Tick", function()
    UnitData:OnTick()
    YasuoWall:OnTick()
end)
ObjectManager = {}

function ObjectManager:IsValid(unit)
	if unit and unit.valid and unit.visible and not unit.dead and unit.isTargetable then
		return true
	end
	return false
end

-- Cache identities only within the current game timestamp; visibility,
-- health and targetability remain live predicates at each use.
function ObjectManager:Snapshot(kind)
    local now=Game.Timer();local count=Game[kind..'Count']()
    local old=self[kind]
    if old and old.at==now and old.count==count then return old.units end
    local units={}
    for i=1,count do local unit=Game[kind](i);if unit then units[#units+1]=unit end end
    self[kind]={at=now,count=count,units=units};return units
end
function ObjectManager:GetHeroes()
    local result={}
    for _,hero in ipairs(self:Snapshot('Hero')) do
        if hero.valid and not hero.dead then result[#result+1]=hero end
    end
    return result
end

function ObjectManager:GetEnemyHeroes()
	local _EnemyHeroes = {}
	for _,hero in ipairs(self:Snapshot('Hero')) do
		if self:IsValid(hero) and hero.isEnemy then
			table_insert(_EnemyHeroes, hero)
		end
	end
	return _EnemyHeroes
end

function ObjectManager:GetAllyHeroes()
	local _AllyHeroes = {}
	for _,hero in ipairs(self:Snapshot('Hero')) do
		if self:IsValid(hero) and hero.isAlly then
			table_insert(_AllyHeroes, hero)
		end
	end
	return _AllyHeroes
end
Collision = {}
local collisionCandidateGroups={{'minions',COLLISION_MINION,4096},{'enemyHeroes',COLLISION_ENEMYHERO,512},{'allyHeroes',COLLISION_ALLYHERO,512}}

function Collision:GetCollision(source, castPos, speed, delay, radius, collisionTypes, skipID, options)
	local motion=type(options)=='table'and options.motion
	if motion and(not ProjectileMotion.Valid(motion)or motion.speedUncertain)then return true,{},0 end
	local castOrigin,castDestination=source,castPos
	local function predictionSpeed(pos)
		if not motion then return speed end
		local distance=Math:GetDistance(castOrigin,pos);local time=ProjectileMotion.Time(motion,distance)
		return time>0 and distance/time or motion.speed
	end
	-- Keep legacy margins for existing callers; precise callers can opt into
	-- host hitboxes without an additional safety halo or endpoint truncation.
	local padding,trim=15,75
	if type(options)=='table' then
		if type(options.padding)=='number' and options.padding==options.padding and options.padding>=0 and options.padding<math_huge then padding=options.padding end
		if type(options.trim)=='number' and options.trim==options.trim and options.trim>=0 and options.trim<math_huge then trim=options.trim end
	end
	if trim>0 then
		source = Math:Extended(source, Math:Normalized(source, castPos), trim)
		castPos = Math:Extended(castPos, Math:Normalized(castPos, source), trim)
	end
	-- Opt-in options.scope: a caller-owned table whose lifetime the caller
	-- bounds to one frozen evaluation (no input, no new callback). Unit reads
	-- and GetPrediction results are then shared by every query in that scope.
	-- Same predicates and order; without a scope every read stays fresh.
	local scope = type(options)=='table' and type(options.scope)=='table' and options.scope or nil
	local rows = scope and scope.rows
	if scope and not rows then rows={};scope.rows=rows end
	local isWall, collisionObjects, collisionCount = false, {}, 0
	local function nativeContact(object,bodyRadius)
		if not(object.pathing and object.pathing.isDashing==true)then return nil end
		if type(ChampionMotion.RayContacts)~='function'then return nil,'native_ray_capability_unavailable'end
		if motion then return nil,'accelerated_ray_native_motion_unmodeled' end
		local control=object.type==Obj_AI_Hero and Immobile:Read(object)or nil
		if control and((control.forcedDuration or 0)>0 or(control.knockDuration or 0)>0)then
			return nil,'collision_forced_movement_unknown'
		end
		local snapshot,why=ChampionMotion.ReadPath(object,Game.Timer(),control)
		if not snapshot then return nil,why end
		-- Legacy segment margins do not relocate the physical launch/arrival ray.
		-- Temporal native contact uses the actual original outgoing segment.
		local contact;contact,why=ChampionMotion.RayContacts(snapshot,castOrigin,castDestination,speed,delay,radius+padding+bodyRadius)
		if not contact then return nil,why end
		local fresh;fresh,why=ChampionMotion.Fresh(snapshot,object,Game.Timer())
		if not fresh then return nil,why end
		return contact
	end
	local clearances
	local projectileScope=type(options)=='table'and options.scope or nil
	if not projectileScope or projectileScope.valid~=true then projectileScope={valid=true}end
	local function incomingFlightClear(a,b)return not YasuoWall:CheckCollision(a,b)end
	local function clearedBeforeContact(object,pos,nearest,bodyRadius)
		if type(options)=='table'and options.observedClearance==false then return false end
		local api=SDK and SDK.Projectiles
		if not api or type(api.WillNPCClearBefore)~='function'or object.type~=_G.Obj_AI_Minion then return false end
		local ms=object.ms
		if type(ms)~='number'or ms<0 or ms~=ms or ms==math_huge then return false end
		local lateral=Math:GetDistance(pos,nearest)
		local total=radius+padding+bodyRadius
		local entry=math_max(0,Math:GetDistance(castOrigin,nearest)-math_sqrt(math_max(0,total*total-lateral*lateral)))
		-- Earliest possible encounter, allowing the blocker to approach during
		-- launch delay. Accelerated projectiles use their fastest speed bound.
		local fastest=motion and motion.maxSpeed or speed
		if type(fastest)~='number'or fastest<=0 or fastest~=fastest then return false end
		local contact=delay+math_max(0,entry-ms*delay)/(fastest+ms)
		local ok,clear,reason,evidence=pcall(api.WillNPCClearBefore,api,object,contact,.03,incomingFlightClear,projectileScope)
		if not ok or clear~=true then return false end
		clearances=clearances or {};clearances[#clearances+1]={unit=object,reason=reason,evidence=evidence}
		return true
	end
	local objects, seen = {}, {}
	local reach=Math:GetDistance(source,castPos)+radius+150
	local lead=delay+(motion and ProjectileMotion.Time(motion,reach+trim)or(speed>0 and reach/speed or 0))
	for i, colType in pairs(collisionTypes or {0,3}) do
		if colType == COLLISION_YASUOWALL then
			isWall = YasuoWall:CheckCollision(source, castPos)
			if isWall then
				return isWall, collisionObjects, collisionCount
			end
		elseif colType == COLLISION_MINION and rows then
			for _,unit in ipairs(ObjectManager:Snapshot('Minion')) do
				local row=rows[unit]
				if not row then
					row={id=unit.networkID,eligible=false}
					if ObjectManager:IsValid(unit) and (unit.isEnemy or unit.team==300) then
						row.eligible=true;row.pos=Math:Get2D(unit.pos);row.ms=unit.ms or 0
					end
					rows[unit]=row
				end
				if row.id ~= skipID and row.eligible and (Math:IsInRange(source, row.pos, reach+row.ms*lead)
					or(unit.pathing and unit.pathing.isDashing==true))then
					table_insert(objects, unit)
				end
			end
		elseif colType == COLLISION_MINION then
			for _,unit in ipairs(ObjectManager:Snapshot('Minion')) do
				if
					unit.networkID ~= skipID
					and ObjectManager:IsValid(unit)
					and (unit.isEnemy or unit.team==300)
					and (Math:IsInRange(source, Math:Get2D(unit.pos), reach+(unit.ms or 0)*lead)
						or(unit.pathing and unit.pathing.isDashing==true))
				then
					table_insert(objects, unit)
				end
			end
		elseif colType == COLLISION_ENEMYHERO and rows then
			local heroes=scope.enemyHeroes
			if not heroes then heroes=ObjectManager:GetEnemyHeroes();scope.enemyHeroes=heroes end
			for _,unit in ipairs(heroes) do
				local row=rows[unit]
				if not row then row={id=unit.networkID,eligible=true,pos=Math:Get2D(unit.pos),ms=unit.ms or 0};rows[unit]=row end
				if row.id ~= skipID and (Math:IsInRange(source, row.pos, reach+row.ms*lead)
					or(unit.pathing and unit.pathing.isDashing==true))then
					table_insert(objects, unit)
				end
			end
		elseif colType == COLLISION_ALLYHERO then
			for k, unit in pairs(ObjectManager:GetAllyHeroes()) do
				if unit.networkID ~= skipID and (Math:IsInRange(source, Math:Get2D(unit.pos), reach+(unit.ms or 0)*lead)
					or(unit.pathing and unit.pathing.isDashing==true))then
					table_insert(objects, unit)
				end
			end
		elseif colType == COLLISION_ENEMYHERO then
			for k, unit in pairs(ObjectManager:GetEnemyHeroes()) do
				if unit.networkID ~= skipID and (Math:IsInRange(source, Math:Get2D(unit.pos), reach+(unit.ms or 0)*lead)
					or(unit.pathing and unit.pathing.isDashing==true))then
					table_insert(objects, unit)
				end
			end
		end
	end
	-- Caller-discovered identities supplement native enumeration; they use the
	-- same ray, motion and incoming-hit rules below. Lists are dense snapshots.
	-- Limits match the family's bounded discovery lists, including whole-map
	-- minions. Exceeding them declines the query instead of dropping blockers.
	local extra;if type(options)=='table'then extra=options.candidates end
	if extra~=nil then
		if type(extra)~='table'then return true,{},0,nil,'collision_candidates_invalid'end
		local allowed={};for _,kind in pairs(collisionTypes or{0,3})do allowed[kind]=true end
		local candidateSeen={}
		for _,unit in ipairs(objects)do candidateSeen[unit.networkID or unit]=true end
		for _,group in ipairs(collisionCandidateGroups)do
			local kind=group[2];local list=allowed[kind]and extra[group[1]]or nil
			if list~=nil then
				if type(list)~='table'then return true,{},0,nil,'collision_candidate_list_invalid'end
				if #list>group[3]then return true,{},0,nil,'collision_candidates_truncated'end
				for i=1,#list do
					local unit=list[i]
					if type(unit)~='table'and type(unit)~='userdata'then return true,{},0,nil,'collision_candidate_invalid'end
					local matches=kind==COLLISION_MINION and unit.type==Obj_AI_Minion and(unit.isEnemy or unit.team==300)
						or kind==COLLISION_ENEMYHERO and unit.type==Obj_AI_Hero and unit.isEnemy
						or kind==COLLISION_ALLYHERO and unit.type==Obj_AI_Hero and unit.isAlly
					-- The identity is read only for a unit of the requested kind.
					local id=matches and unit.networkID
					if matches and id~=skipID and not candidateSeen[id or unit]and ObjectManager:IsValid(unit)then
						local p=unit.pos
						if not p or type(p.x)~='number'or type(p.z)~='number'or p.x~=p.x or p.z~=p.z
							or math_abs(p.x)==math_huge or math_abs(p.z)==math_huge then
							return true,{},0,nil,'collision_candidate_position_unknown'
						end
						local row=rows and rows[unit]
						if not row then
							row={id=id,eligible=true,pos=Math:Get2D(p),ms=unit.ms or 0}
							if rows then rows[unit]=row end
						end
						if type(row.ms)~='number'or row.ms~=row.ms or row.ms<0 or row.ms==math_huge then
							return true,{},0,nil,'collision_candidate_movement_speed_unknown'
						end
						if Math:IsInRange(source,row.pos,reach+row.ms*lead)or(unit.pathing and unit.pathing.isDashing==true)then
							candidateSeen[id or unit]=true;table_insert(objects,unit)
						end
					end
				end
			end
		end
	end
	for i, object in ipairs(objects) do
		local row=rows and rows[object]
		if row and row.id~=nil then
		if not seen[row.id] then
		seen[row.id]=true
		local radiusTotal=row.radius
		if not radiusTotal then radiusTotal=object.boundingRadius or 45;row.radius=radiusTotal end
		local objectPos = row.pos
		local pointLine, isOnSegment = Math:ClosestPointOnLineSegment(objectPos, source, castPos)
		local isCol = isOnSegment and Math:IsInRange(objectPos, pointLine, radius + padding + radiusTotal)
		local native,why=nativeContact(object,radiusTotal)
		if why then return true,collisionObjects,collisionCount,clearances,why end
		if native then
			isCol=native.hit;objectPos=native.position or objectPos;pointLine=native.nearest or pointLine
		elseif not isCol then
			local moving=row.moving
			if moving==nil then
				moving=(object.pathing and object.pathing.hasMovePath and object.GetPrediction) and true or false
				row.moving=moving
			end
			if moving then
				local flightSpeed=predictionSpeed(objectPos)
				local key=flightSpeed..':'..delay;local predicted=row.predicted and row.predicted[key]
				if not predicted then
					predicted=Math:Get2D(object:GetPrediction(flightSpeed, delay) or object.pos)
					row.predicted=row.predicted or {};row.predicted[key]=predicted
				end
				pointLine, isOnSegment = Math:ClosestPointOnLineSegment(predicted, source, castPos)
				isCol = isOnSegment and Math:IsInRange(predicted, pointLine, radius + padding + radiusTotal)
				objectPos=predicted
			end
		end
		if isCol and(native or not clearedBeforeContact(object,objectPos,pointLine,radiusTotal))then
			table_insert(collisionObjects, object)
			collisionCount = collisionCount + 1
		end
		end
		else
		local id=object.networkID or object
		if not seen[id] then
		seen[id]=true
		local isCol = false
		local objectPos = Math:Get2D(object.pos)
		local pointLine, isOnSegment = Math:ClosestPointOnLineSegment(objectPos, source, castPos)
		local native,why=nativeContact(object,object.boundingRadius or 45)
		if why then return true,collisionObjects,collisionCount,clearances,why end
		if native then
			isCol=native.hit;objectPos=native.position or objectPos;pointLine=native.nearest or pointLine
		elseif isOnSegment and Math:IsInRange(objectPos, pointLine, radius + padding + (object.boundingRadius or 45)) then
			isCol = true
		elseif object.pathing and object.pathing.hasMovePath and object.GetPrediction then
			objectPos = Math:Get2D(object:GetPrediction(predictionSpeed(objectPos), delay) or object.pos)
			pointLine, isOnSegment = Math:ClosestPointOnLineSegment(objectPos, source, castPos)
			if isOnSegment and Math:IsInRange(objectPos, pointLine, radius + padding + (object.boundingRadius or 45)) then
				isCol = true
			end
		end
		if isCol and(native or not clearedBeforeContact(object,objectPos,pointLine,object.boundingRadius or 45))then
			table_insert(collisionObjects, object)
			collisionCount = collisionCount + 1
		end
	end
	end
	end
	return isWall, collisionObjects, collisionCount,clearances
end
Prediction = {}

function Prediction:GetPrediction(target, source, speed, delay, radius, isHero, knowledge)
	if not target or not target.pos or not source or not speed or speed<=0 then return nil,nil,-1 end
	if isHero and not target.visible then
		if not knowledge then return nil,nil,-1,nil,'hidden_target_unobserved'end
		local sample,why=knowledge:Predict(target,0,{confidence=true})
		if not sample then return nil,nil,-1,nil,why end
		local impact=launchDelay(delay)+Math:GetDistance(Math:Get2D(sample.pos),source)/speed
		for i=1,4 do
			sample,why=knowledge:Predict(target,impact,{confidence=true})
			if not sample then return nil,nil,-1,nil,why end
			local nextImpact=launchDelay(delay)+Math:GetDistance(Math:Get2D(sample.pos),source)/speed
			if math_abs(nextImpact-impact)<=.002 then
				local pos=Math:Get2D(sample.pos)
				return pos,pos,nextImpact,nil,nil,{scope=knowledge,sample=sample,impact=nextImpact,at=Game.Timer()}
			end
			impact=nextImpact
		end
		return nil,nil,-1,nil,'fog_interception_unresolved'
	end
	-- A fresh native dash bypasses walking-history warmup, including enemies
	-- outside the playable roster. After landing, expose walking uncertainty.
	if target.visible and target.pathing and target.pathing.isDashing then
		local control=isHero and Immobile:Read(target)or nil
		local snapshot,why=ChampionMotion.ReadPath(target,Game.Timer(),control)
		if not snapshot then return nil,nil,-1,nil,why end
		local hit,why=ChampionMotion.Intercept(snapshot,source,speed,launchDelay(delay),radius or 0)
		if not hit then return nil,nil,-1,nil,why end
		return hit.position,hit.position,hit.impact,hit
	end
	if isHero and target.visible and ChampionMotion.PendingCast(target,Game.Timer())then
		return nil,nil,-1,nil,'mobility_cast_timing_unknown'
	end
	local id, ms = target.networkID, target.ms or 0
	if not target.pathing or ms<=0 then
		local pos=Math:Get2D(target.pos);return pos,pos,launchDelay(delay)+Math:GetDistance(pos,source)/speed
	end
	if target.pathing.isDashing and target.pathing.dashSpeed and target.pathing.dashSpeed > 0 then
		ms = target.pathing.dashSpeed
	end
	local delay2 = launchDelay(delay)
	if not isHero then
		local hasMovePath = target.pathing.hasMovePath
		if not hasMovePath then
			local pos = Math:Get2D(target.pos)
			return pos, pos, delay2 + Math:GetDistance(pos, source) / speed
		end
		local path = Path:GetPath(target)
		if #path <= 1 then
			local pos = Math:Get2D(target.pos)
			return pos, pos, delay2 + Math:GetDistance(pos, source) / speed
		end
		local path2 = Path:CutPath(path, ms * delay2)
		if speed == math_huge then
			return path2[1], path2[1], delay2
		end
		local path3 = Path:GetPredictedPath(source, speed, ms, path2)
		if path3 then
			local pos = path3[#path3]
			return pos, pos, delay2 + Math:GetDistance(pos, source) / speed
		end
		local pos = path[#path]
		return pos, pos, delay2 + Math:GetDistance(pos, source) / speed
	end
	UnitData:OnPrediction(target)
	-- Fresh visible hard CC is actionable immediately, even during the
	-- visibility-history warmup. Forced movement (fear/charm/taunt/knockback)
	-- must not masquerade as a stationary, guaranteed hit.
	local currentLock
	if target.visible then
		local pos=Math:Get2D(target.pos)
		local impact=delay2+Math:GetDistance(pos,source)/speed
		local canHit,locked,_,knock=Immobile:CanHit(target,impact,radius)
		currentLock=locked
		if canHit and knock==0 then return pos,pos,impact end
	end
	local vis = UnitData.Visible[id]
	if vis.visible then
		if GetTickCount() < vis.visibleTick + 100 then
			return nil, nil, -1
		end
	elseif GetTickCount() > vis.invisibleTick + 1000 then
		return nil, nil, -1
	end
	local wp = UnitData.Waypoints[id]
	if not wp then return nil,nil,-1 end
	if wp.moving then
		if currentLock==nil then
			local _,locked=Immobile:CanHit(target,delay2+Math:GetDistance(target.pos,source)/speed,radius)
			currentLock=locked
		end
		if currentLock then return nil,nil,-1 end -- Lock ends before arrival; do not invent post-CC direction.
	end
	if wp.moving and #wp.path <= 1 then
		return nil, nil, -1
	end
	if not wp.moving then
		local pos = Math:Get2D(target.pos)
		return pos, pos, delay2 + Math:GetDistance(pos, source) / speed
	end
	if speed == math_huge then
		local path = Path:CutPath(wp.path, ms * delay2)
		if wp.dashing then
			return path[1], path[1], delay2
		end
		local path2 = Path:CutPath(wp.path, (ms * delay2) - radius / 2)
		return path[1], path2[1], delay2
	end
	local path, time = Path:GetPredictedPath(source, speed, ms, Path:CutPath(wp.path, ms * delay2))
	if path then
		if wp.dashing then
			local unitPos = path[#path]
			return unitPos, unitPos, delay2 + Math:GetDistance(unitPos, source) / speed
		end
		local path2 = Path:CutPath2(Path:ReversePath(path), radius / 2, target.pos)
		return path[#path], path2[1], delay2 + Math:GetDistance(path2[1], source) / speed
	end
	local p = wp.path[#wp.path]
	return p, p, delay2 + Math:GetDistance(p, source) / speed
end
local function controlAimOffset(settings,unit,point,source)
	local function valid(value)
		if type(value)~='table'and type(value)~='userdata'then return false end
		value=value.pos or value
		if type(value)~='table'and type(value)~='userdata'then return false end
		local z=value.z==nil and value.y or value.z
		return type(value.x)=='number'and value.x==value.x and math_abs(value.x)<math_huge
			and type(z)=='number'and z==z and math_abs(z)<math_huge
	end
	if not valid(unit)or not valid(point)or not valid(source)then return nil end
	local p,u,o=Math:Get2D(point),Math:Get2D(unit),Math:Get2D(source)
	if settings.Type==SPELLTYPE_CIRCLE then return Math:GetDistance(p,u)end
	if settings.Type~=nil and settings.Type~=SPELLTYPE_LINE then return nil end
	local x,z=p.x-o.x,p.z-o.z;local length=x*x+z*z
	if settings.DirectionalCast then
		local range=settings.Range
		if type(range)~='number'or range~=range or range<=0 or range==math_huge or length<=0 then return nil end
		local scale=range/math_sqrt(length);x,z=x*scale,z*scale;length=range*range
	end
	if length<=0 then return nil end
	local t=math_max(0,math_min(1,((u.x-o.x)*x+(u.z-o.z)*z)/length))
	local dx,dz=u.x-o.x-x*t,u.z-o.z-z*t
	return math_sqrt(dx*dx+dz*dz)
end
local SpellMethods = {}
function SpellMethods:ResetOutput()
		self.HitChance = 0
		self.LastFailureReason = nil
		self.HitWindow = nil
		self.NativeMotion = nil
		self.FogObservation = nil
		self.PredictionFailureReason = nil
		self.ClearanceObjects = nil
		self.CollisionFailureReason = nil
		self.CastPosition = nil
		self.UnitPosition = nil
		self.TimeToHit = 0
		self.CollionableObjects = {}
	end
function SpellMethods:GetOutput()
		self.TargetIsHero = self.Target.type == Obj_AI_Hero
		self.RealRadius = (self.UseBoundingRadius and self.Radius + self.Target.boundingRadius or self.Radius)-self.AimErrorWorld
		local knowledge=self.KnowledgeScope
		if self.FogPermission and not self.FogPermission()then knowledge=nil end
		self.UnitPosition, self.CastPosition, self.TimeToHit, self.NativeMotion, self.PredictionFailureReason, self.FogObservation = Prediction:GetPrediction(
			self.Target,
			self.Source,
			self.Speed,
			self.Delay,
			self.RealRadius,
		self.TargetIsHero,knowledge
		)
		if self.Motion and self.CastPosition then
			local speed=self.Speed;local converged=false
			-- Bounded local interception refinement. Reject unresolved rays instead
			-- of treating an average speed as a measured projectile trajectory.
			for i=1,8 do
				local distance=Math:GetDistance(self.CastPosition,self.Source)
				local flight=ProjectileMotion.Time(self.Motion,distance)
				if not flight or flight>=math_huge then break end
				if math_abs(flight-distance/speed)<=.001 then
					self.TimeToHit=self.TimeToHit-distance/speed+flight;converged=true;break
				end
				speed=distance>0 and distance/flight or self.Motion.speed
				self.UnitPosition,self.CastPosition,self.TimeToHit,self.NativeMotion,self.PredictionFailureReason,self.FogObservation=Prediction:GetPrediction(self.Target,self.Source,speed,self.Delay,self.RealRadius,self.TargetIsHero,knowledge)
				if not self.CastPosition then break end
			end
			if not converged then self.UnitPosition=nil;self.CastPosition=nil;self.TimeToHit=-1 end
		end
	end
function SpellMethods:HighHitChance()
		local wp, tick = UnitData.Waypoints[self.Target.networkID], GetTickCount()
		if not self.Target.visible then
			return false
		end
		if not wp then return false end
		if wp.moving then
			if tick < wp.tick + 150 then
				return true
			end
			-- wp.path is the target's path read by this prediction (OnPrediction).
			if tick > wp.tick + 1000 and wp.path and Path:GetLenght(wp.path) > 1000 then
				return true
			end
			return false
		end
		if tick - wp.stoptick < 50 then
			return true
		end
		if tick - wp.stoptick > 1000 then
			return true
		end
		return false
	end
function SpellMethods:IsCollision()
		local isWall, collisionObjects, collisionCount, clearances, reason = Collision:GetCollision(
			self.Source,
			self.CastPosition,
			self.Speed,
			launchDelay(self.Delay),
			self.Radius+self.AimErrorWorld,
			self.CollisionTypes,
			self.Target.networkID
			,self.Motion and {motion=self.Motion}or nil
		)
		self.ClearanceObjects=clearances
		self.CollisionFailureReason=reason

		if isWall or collisionCount > self.MaxCollision then
			self.CollionableObjects = collisionObjects
			return true
		end
		return false	
	end
function SpellMethods:IsInRange(deferScreen)
		local range = self.Range * Menu:GetMaxRange()
		local unitRange = range
		if self.Type == SPELLTYPE_CIRCLE then
			unitRange = unitRange + self.RealRadius
		end
		if not Math:IsInRange(self.UnitPosition, self.Source, unitRange) then
			return false
		end
		local castDirection = Math:Normalized(self.UnitPosition, self.Source)
		if not Math:IsInRange(self.CastPosition, self.Source, range) then
			self.CastPosition = Math:Extended(self.Source, castDirection, range)
		end
		local y = self.Target.pos.y
		y = y > 100 and 100 or y
		self.CastPosition.y = y
		self.UnitPosition.y = y
		return deferScreen or self:IsScreenAimValid()
	end
function SpellMethods:IsScreenAimValid()
		local castPos3D = Math:Get3D(self.CastPosition)
		self.IsOnScreen = castPos3D:To2D().onScreen
		if not self.IsOnScreen then
			-- Explicit geometry-only prediction for an independently validated
			-- minimap transport. Legacy casts retain their screen restrictions.
			if self.Type == SPELLTYPE_CIRCLE and self.AllowOffscreenCircle then return true end
			if self.Type == SPELLTYPE_CIRCLE then
				return false
			end
			-- Keep the complete outgoing ray for prediction and collision. The
			-- provider may choose a visible cursor point for an explicitly profiled
			-- directional ability; screen placement is not prediction geometry.
		end
		return true
	end
function SpellMethods:CanHit(hitChance)
		hitChance = hitChance or HITCHANCE_NORMAL
		self.LastFailureReason = nil
		if self.UnitPosition == nil or self.CastPosition == nil then
			self.HitChance = 0
				self.LastFailureReason = self.PredictionFailureReason or 'prediction_unavailable'
			return false
		end
		-- Range clamping changes the outgoing shape and precedes its hit window.
		if self.Range ~= math_huge and not self:IsInRange(true) then
			self.LastFailureReason = 'prediction_out_of_range'
			return false
		end
		--[[if self.Type ~= SPELLTYPE_CIRCLE and self.TimeToHit > 0.7 and Math:FindAngle(self.CastPosition, self.Target.pos, myHero.pos) > 90 - self.TimeToHit * 30 then
			return false
		end]]
		self.HitChance = HITCHANCE_NORMAL
		if self.FogObservation then
			local fresh,why=self:FogFresh()
			if not fresh then self.HitChance=0;self.LastFailureReason=why;return false end
			local sample=self.FogObservation.sample
			if sample.source=='observed_recall'or sample.confidence=='high'then self.HitChance=HITCHANCE_HIGH end
		end
		if self.NativeMotion then
			local valid,why=ChampionMotion.Fresh(self.NativeMotion.motion,self.Target,Game.Timer())
			if not valid then self.HitChance=0;self.LastFailureReason=why;return false end
			local _,escape=ChampionMotion.Sample(self.NativeMotion.motion,self.TimeToHit+.02)
			self.NativeMotion.escapeRadius=escape
			local offset=controlAimOffset(self,self.UnitPosition,self.CastPosition,self.Source)
			self.NativeMotion.aimOffset=offset
			self.NativeMotion.footprintCovered=escape~=nil and offset~=nil and escape+offset<self.RealRadius
			if self.NativeMotion.footprintCovered then self.HitChance=HITCHANCE_HIGH end
		end
		if self.TargetIsHero and not self.FogObservation then
			local canHitLocked, isLocked, duration, knockduration, window =
				Immobile:CanHit(self.Target, self.TimeToHit, self.RealRadius)
			window=ControlWindow.FitAim(window,controlAimOffset(self,self.Target,self.CastPosition,self.Source),self.RealRadius)
			canHitLocked=window.canHitFromCurrentPosition
			self.HitWindow=self.NativeMotion or window
			if window.reason=='mobility_cast_timing_unknown'and not self.NativeMotion then
				self.HitChance=0;self.LastFailureReason=window.reason;return false
			end
			if knockduration ~= 0 then
				self.HitChance = 0
				self.LastFailureReason = 'knockback_active'
				return false
			end
			if self.NativeMotion and(window.forcedDuration or 0)>0 then
				self.HitChance=0;self.LastFailureReason='forced_movement';return false
			end
			if canHitLocked then
				self.HitChance = window.controlledThroughImpact and HITCHANCE_IMMOBILE or HITCHANCE_HIGH
			end
			if not self.NativeMotion and window.known and not isLocked and(window.forcedDuration or 0)==0 and window.speedStableThroughImpact~=false and self.HitChance == HITCHANCE_NORMAL and self:HighHitChance() then
				self.HitChance = HITCHANCE_HIGH
			end			
		end
		if self.HitChance < hitChance then
			self.LastFailureReason = 'hitchance_below_threshold'
			return false
		end
		if self.Range ~= math_huge and not self:IsScreenAimValid()then
			self.LastFailureReason='prediction_offscreen';return false
		end
		if self.Collision and self:IsCollision() then
			self.LastFailureReason = self.CollisionFailureReason or 'collision'
			return false
		end
		if self.NativeMotion then
			local fresh,why=ChampionMotion.Fresh(self.NativeMotion.motion,self.Target,Game.Timer())
			if not fresh then self.HitChance=0;self.LastFailureReason=why;return false end
		end
		if not self.FogObservation and not Math:VectorsEqual(self.PosTo, Math:Get2D(self.Target.posTo or self.Target.pos), 50) then
			self.LastFailureReason = 'path_changed'
			return false
		end

		-- The old 5ms CPU-time deadline rejected freshly calculated results
		-- during host stalls. Bound age by a quarter-radius of movement, capped
		-- at 50ms; never let a slow frame authorize an old cached prediction.
		local maxAge=math_min(.05,math_max(.005,(self.RealRadius or self.Radius or 0)*.25/math_max(1,self.Target.ms or 0)))
		if os.clock() - self.StartTime > maxAge then
			self.LastFailureReason = 'prediction_expired'
			return false
		end
		return true
	end
function SpellMethods:FogFresh()
	local fog=self.FogObservation
	if not fog or self.Target.visible or self.Target.dead or self.Target.valid==false
		or self.FogPermission and not self.FogPermission()then return false,'fog_context_changed'end
	local sample,why=fog.scope:Predict(self.Target,self.TimeToHit,{confidence=true})
	if not sample then return false,why end
	if sample.id~=fog.sample.id or sample.handle~=fog.sample.handle or sample.name~=fog.sample.name
		or sample.source~=fog.sample.source or sample.observationAt~=fog.sample.observationAt then return false,'fog_observation_changed'end
	if not sample.uncertainty or sample.uncertainty>=self.RealRadius then return false,'fog_uncertainty_exceeds_footprint'end
	if Math:GetDistance(Math:Get2D(sample.pos),self.UnitPosition)>math_max(1,self.RealRadius*.1)then return false,'fog_aim_changed'end
	return true
end
function SpellMethods:GetPrediction(target, source)
		self:ResetOutput()
		if not target or not target.pos then return end
		self.Target = target
		source=source or myHero
		local sourcePos = source.pos == nil and source or source.pos
		self.Source = Math:Get2D(sourcePos)
		self.SourceY = sourcePos.y or myHero.pos.y
		self.PosTo = Math:Get2D(target.posTo or target.pos)
		self.StartTime = os.clock()
		self:GetOutput()
	end
function SpellMethods:GetAOEPrediction(source)
		local aoetargets = {}
		local enemies = ObjectManager:GetEnemyHeroes()
		for i = 1, #enemies do
			local enemy = enemies[i]
			if not SDK.ObjectManager:IsHeroImmortal(enemy) then
				self:GetPrediction(enemy, source)
				if self:CanHit(HITCHANCE_NORMAL) then
					table_insert(
						aoetargets,
						{ enemy, self.HitChance, self.TimeToHit, self.CastPosition, self.UnitPosition }
					)
				end
			end
		end
		local result = {}
		local isCircle = self.Type == SPELLTYPE_CIRCLE
		local range = self.Range * Menu:GetMaxRange()
		for i = 1, #aoetargets do
			local aoetarget = aoetargets[i]
			local count = 1
			local distance = 0
			local castpos = aoetarget[4]
			if isCircle then
				local anchor = aoetarget[5]
				local cluster = { anchor }
				for j = 1, #aoetargets do
					if i ~= j and Math:GetDistance(anchor, aoetargets[j][5]) < self.RealRadius * 2 then
						table_insert(cluster, aoetargets[j][5])
					end
				end
				while #cluster > 1 do
					local center, r = Math:MEC(cluster)
					if r <= self.RealRadius - 10 and (range == math_huge or Math:IsInRange(center, self.Source, range)) then
						castpos = center
						break
					end
					local far, fi = -1, 2
					for k = 2, #cluster do
						local dd = Math:GetDistance(cluster[k], anchor)
						if dd > far then
							far, fi = dd, k
						end
					end
					table_remove(cluster, fi)
				end
			elseif self.Type == SPELLTYPE_LINE and range ~= math_huge then
				local anchor = aoetarget[5]
				local gate = self.Radius + aoetarget[1].boundingRadius / 3
				local bestCount, bestPos = 1, nil
				for j = 1, #aoetargets do
					if i ~= j then
						local other = aoetargets[j][5]
						local mid = { x = (anchor.x + other.x) / 2, z = (anchor.z + other.z) / 2 }
						local dir = Math:Normalized(mid, self.Source)
						if dir then
							local endpos = Math:Extended(self.Source, dir, range)
							local pa, aOn = Math:ClosestPointOnLineSegment(anchor, self.Source, endpos)
							if aOn and Math:IsInRange(anchor, pa, gate) then
								local cnt, farthest = 0, 0
								for k = 1, #aoetargets do
									local unitpos = aoetargets[k][5]
									local pl, isOn = Math:ClosestPointOnLineSegment(unitpos, self.Source, endpos)
									if isOn and Math:IsInRange(unitpos, pl, self.RealRadius) then
										cnt = cnt + 1
										local dp = Math:GetDistance(self.Source, pl)
										if dp > farthest then
											farthest = dp
										end
									end
								end
								if cnt > bestCount then
									bestCount = cnt
									bestPos = Math:Extended(self.Source, dir, farthest)
								end
							end
						end
					end
				end
				if bestPos then
					castpos = bestPos
				end
			end
			if castpos ~= aoetarget[4] then
				castpos.y = aoetarget[4].y
			end
			for j = 1, #aoetargets do
				if i ~= j then
					local d
					local unitpos = aoetargets[j][5]
					if isCircle then
						d = Math:GetDistance(castpos, unitpos)
					else
						local pointLine, isOnSegment = Math:ClosestPointOnLineSegment(unitpos, self.Source, castpos)
						d = Math:GetDistance(pointLine, unitpos)
					end
					if d < self.RealRadius then
						count = count + 1
						distance = distance + d
					end
				end
			end
			table_insert(result, {
				Count = count,
				Distance = distance,
				Unit = aoetarget[1],
				HitChance = aoetarget[2],
				TimeToHit = aoetarget[3],
				CastPosition = castpos,
			})
		end
		return result
	end
function Prediction:SpellPrediction(args)
	local c = {}
	do -- __init()
		c.Collision, c.MaxCollision, c.CollisionTypes = false, 0, { 0, 3 }
		c.AimErrorWorld=args.AimErrorWorld or 0
		c.DirectionalCast=args.DirectionalCast==true
		c.AllowOffscreenCircle=args.AllowOffscreenCircle==true
		if args.Motion~=nil then
			assert(ProjectileMotion.Valid(args.Motion),'Invalid projectile motion')
			c.Motion={speed=args.Motion.speed,acceleration=args.Motion.acceleration or 0,minSpeed=args.Motion.minSpeed,maxSpeed=args.Motion.maxSpeed,speedUncertain=args.Motion.speedUncertain or nil}
            if args.Motion.speedStep then c.Motion.speedStep={at=args.Motion.speedStep.at,speed=args.Motion.speedStep.speed}end
		end
		if args.Collision ~= nil then
			c.Collision = args.Collision
		end
		if args.MaxCollision ~= nil then
			c.MaxCollision = args.MaxCollision
		end
		if args.CollisionTypes ~= nil then
			c.CollisionTypes = args.CollisionTypes
		end
		c.Type, c.Speed, c.Range, c.Delay, c.Radius, c.UseBoundingRadius =
			SPELLTYPE_LINE, math_huge, math_huge, 0, 1, false
		if args.Type ~= nil then
			c.Type = args.Type
		end
		if args.Speed ~= nil then
			c.Speed = args.Speed
		end
		if args.Range ~= nil then
			c.Range = args.Range
		end
		if args.Delay ~= nil then
			c.Delay = args.Delay
		end
		if args.Radius ~= nil then
			c.Radius = args.Radius
		end
		assert(type(c.AimErrorWorld)=='number'and c.AimErrorWorld==c.AimErrorWorld
			and c.AimErrorWorld>=0 and c.AimErrorWorld<=5 and(c.AimErrorWorld==0 or c.AimErrorWorld<c.Radius),'Invalid directional aim margin')
		assert(not c.DirectionalCast or c.Type==SPELLTYPE_LINE,'Directional casts require reviewed line geometry')
		assert(c.AimErrorWorld==0 or c.DirectionalCast,'Aim margin requires directional cast opt-in')
		if args.UseBoundingRadius or (args.UseBoundingRadius == nil and c.Type == SPELLTYPE_LINE) then
			c.UseBoundingRadius = true
		end
	end
	for name,method in pairs(SpellMethods) do c[name]=method end
	return c
end
--[[
	OrbamaPrediction - Global Class, API
]]
_G.OrbamaPrediction = {
	ChampionMotion = ChampionMotion,
	ProjectileMotion = ProjectileMotion,
	OffscreenCirclePrediction = true,
	FullRayPrediction = true,
	DirectionalAimError = true,
	CollisionOptions = true,
	CollisionScope = true,
	CollisionCandidates = true,
	ControlWindowAssessment = true,
	KnowledgePrediction = true,
	COLLISION_MINION = COLLISION_MINION,
	COLLISION_ALLYHERO = COLLISION_ALLYHERO,
	COLLISION_ENEMYHERO = COLLISION_ENEMYHERO,
	COLLISION_YASUOWALL = COLLISION_YASUOWALL,
	HITCHANCE_IMPOSSIBLE = HITCHANCE_IMPOSSIBLE,
	HITCHANCE_COLLISION = HITCHANCE_COLLISION,
	HITCHANCE_NORMAL = HITCHANCE_NORMAL,
	HITCHANCE_HIGH = HITCHANCE_HIGH,
	HITCHANCE_IMMOBILE = HITCHANCE_IMMOBILE,
	SPELLTYPE_LINE = SPELLTYPE_LINE,
	SPELLTYPE_CIRCLE = SPELLTYPE_CIRCLE,
	SPELLTYPE_CONE = SPELLTYPE_CONE,
}
function OrbamaPrediction:GetPrediction(target, source, speed, delay, radius)
	if not target or not target.pos then return nil,nil,-1 end
	source=source or myHero
	return Prediction:GetPrediction(target, Math:Get2D(source), speed, delay, radius, target.type == Obj_AI_Hero)
end
function OrbamaPrediction:GetCollision(source, castPos, speed, delay, radius, collisionTypes, skipID, options)
	return Collision:GetCollision(source, castPos, speed, delay, radius, collisionTypes, skipID, options)
end
function OrbamaPrediction:SpellPrediction(args)
	return Prediction:SpellPrediction(args)
end
function OrbamaPrediction:MotionFresh(spell,target)
	if spell and spell.FogObservation then return spell:FogFresh()end
	local observed=spell and spell.NativeMotion
	if not observed then return true end
	return ChampionMotion.Fresh(observed.motion,target or spell.Target,Game.Timer())
end
function OrbamaPrediction:ClosestPointOnLineSegment(p, p1, p2)
	return Math:ClosestPointOnLineSegment(p, p1, p2)
end
function OrbamaPrediction:IsInRange(p1, p2, range)
	return Math:IsInRange(p1, p2, range)
end
function OrbamaPrediction:GetImmobileDuration(unit)
	return Immobile:GetDuration(unit)
end
-- Cheap fixed-point arrival estimate. The same latency and extra-delay policy
-- as full prediction is applied once. This does not predict the target's path.
local function finiteWindowNumber(v)
	return type(v)=='number'and v==v and v>-math_huge and v<math_huge
end
local function validWindowPoint(p)
	if type(p)~='table'and type(p)~='userdata'then return false end
	p=p.pos==nil and p or p.pos
	if type(p)~='table'and type(p)~='userdata'then return false end
	return finiteWindowNumber(p.x)and finiteWindowNumber(p.z==nil and p.y or p.z)
end
function OrbamaPrediction:GetImpactTime(settings,point,source)
	if type(settings)~='table'or not point then return math_huge end
	source=source or myHero
	if not validWindowPoint(point)or not validWindowPoint(source)then return math_huge end
	local p,o=Math:Get2D(point),Math:Get2D(source)
	local delay,speed=settings.Delay or 0,settings.Speed or math_huge
	if type(delay)~='number'or delay~=delay or delay<0 or delay==math_huge
		or type(speed)~='number'or speed~=speed or speed<=0 then return math_huge end
	local distance=Math:GetDistance(p,o)
	local travel
	if settings.Motion then
		if not ProjectileMotion.Valid(settings.Motion)then return math_huge end
		travel=ProjectileMotion.Time(settings.Motion,distance)
	else travel=distance/speed end
	if not travel or travel~=travel or travel<0 then return math_huge end
	return launchDelay(delay)+travel
end
function OrbamaPrediction:GetLaunchDelay(settings)
	return type(settings)=='table'and launchDelay(settings.Delay or 0)or math_huge
end
function OrbamaPrediction:AssessHitWindow(unit,settings,point,source,margin,fresh)
	if(type(unit)~='table'and type(unit)~='userdata')or type(settings)~='table'then
		return ControlWindow.Assess(nil,math_huge,0,0,margin)
	end
	local impact=self:GetImpactTime(settings,point or unit and unit.pos,source)
	local radius=settings and settings.Radius or 0
	if not finiteWindowNumber(radius)or radius<0 then return ControlWindow.Assess(nil,impact,radius,0,margin)end
	if unit and settings and(settings.UseBoundingRadius==true or settings.UseBoundingRadius==nil and(settings.Type or SPELLTYPE_LINE)==SPELLTYPE_LINE)then
		local body=unit.boundingRadius or 0
		if not finiteWindowNumber(body)or body<0 then return ControlWindow.Assess(nil,impact,radius,0,margin)end
		radius=radius+body
	end
	local control=fresh and ControlWindow.ReadNative(unit,Game.Timer())or Immobile:Read(unit)
	if not control.motionClassified then control=ChampionMotion.AnnotateControl(control,unit,Game.Timer())end
	local window=ControlWindow.Assess(control,impact,radius,
		unit and unit.ms or 0,margin or .02,unit and unit.pathing and unit.pathing.isDashing)
	point=point or unit and unit.pos;source=source or myHero
	local aimError=settings.AimErrorWorld or 0
	if not validWindowPoint(point)or not validWindowPoint(unit)or not validWindowPoint(source)
		or not finiteWindowNumber(aimError)or aimError<0 then return ControlWindow.FitAim(window,nil,radius)end
	return ControlWindow.FitAim(window,controlAimOffset(settings,unit,point,source),math.max(0,radius-aimError))
end
function OrbamaPrediction:FindAngle(p1, center, p2)
	return Math:FindAngle(p1, center, p2)
end
function OrbamaPrediction:GetDistance(p1, p2)
	return Math:GetDistance(p1, p2)
end
function OrbamaPrediction:CircleCircleIntersection(center1, center2, radius1, radius2)
	return Math:CircleCircleIntersection(center1, center2, radius1, radius2)
end

OrbamaPrediction.Version=Version
OrbamaPrediction.BaseVersion='OrbamaPrediction 1.59'
_G.OrbamaPrediction=OrbamaPrediction
return OrbamaPrediction

end
