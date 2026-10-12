return function(require)
local G=require('evade.geometry')
local ChannelLink=require('evade.channel_link')
local D=require('evade.damage')
local Trajectory=require('evade.trajectory')
local ChampionMotion=require('CombatProfiles.champion_motion')
local P={};P.__index=P
function P.new(terrain,threats)
    return setmetatable({terrain=terrain,threats=threats,maxCandidates=64,minimumCandidates=24,maxNodes=512,horizon=2,query={}},P)
end
local function unknown(why)return {safe=false,known=false,reason=why,damage=0,unknown=true,lethal=false,cc=0,hits={}}end
-- Unknown for every path of this context: no candidate route can be evaluated either.
local function blocked(why)local r=unknown(why);r.contextual=true;return r end
function P:Evaluate(path,ctx,defense,observedRoute,skipUnusableTerrain)
    if type(path)~='table'or #path==0 or #path>64 or not G.point(ctx.origin)
        or not G.finite(ctx.now)or not G.finite(ctx.speed)or ctx.speed<=0
        or not G.finite(ctx.radius)or ctx.radius<0 then return unknown('invalid_path_context')end
    -- Threat contact is tested with the hero's radius plus a safety margin (terrain is not): a route that
    -- clears a shape by a few units is a hit once latency, a slow or the server's position differ.
    local reach=ctx.radius+(ctx.margin or 0)
    if not G.finite(reach)or reach<ctx.radius then return unknown('invalid_path_context')end
    if self.threats.observationIncomplete then return blocked('observation_incomplete')end
    if self.threats.overflow then return blocked('threat_capacity')end
    if ctx.movementConstraintUnknown then return blocked('movement_constraint_unknown')end
    local function motionFresh()
        if not ctx.observedMotion then return true end
        if type(ctx.motionNow)~='function'then return false,'motion_clock_unavailable'end
        return ChampionMotion.Fresh(ctx.observedMotion,ctx.observedMotion.unit,ctx.motionNow())
    end
    local fresh,motionFailure=motionFresh()
    if not fresh then return unknown(motionFailure)end
    local threatRevision,terrainRevision=self.threats.revision,self.terrain.revision
    if not observedRoute and ctx.moveAllowed and G.point(path[1])and G.dist(ctx.origin,path[1])>5 then
        local ok,allowed=pcall(ctx.moveAllowed,path[1])
        if not ok or allowed~=true then return unknown('movement_destination_rejected')end
    end
    local speedChanges
 if ctx.speedChanges~=nil then
  local reason;speedChanges,reason=Trajectory.SpeedSchedule(ctx.speedChanges)
  if not speedChanges then return unknown(reason)end
  end
    local speedKnownUntil=ctx.speedKnownUntil
    if speedKnownUntil~=nil and not G.finite(speedKnownUntil)then return unknown('invalid_speed_expiry')end
    local expiryCovered=false
    if speedKnownUntil and speedChanges then
        for _,row in ipairs(speedChanges)do if math.abs(row.at-speedKnownUntil)<.000001 then expiryCovered=true;break end end
    end
 local budget=ctx.sharedBudget or {remaining=ctx.workBudget or 12000};local began=budget.remaining;local hits,seen={},{}
    -- A wind wall stops a blockable projectile whose remaining flight crosses the
    -- wall while it stands (defense.wall: a segment, or a radius around the caster).
    local function walled(s,at)
        local w=defense and defense.kind=='windwall'and defense.wall
        if not w or s.windwall~=true or s.shape~='missile'or s.motion or s.motionUnknown or s.speedUncertain
            or not G.finite(s.speed)or s.speed<=0 or not G.finite(defense.starts)or not G.finite(defense.ends)then return false end
        local o=s.origin or s.a;local launch=s.launch or s.starts
        if G.finite(w.radius)and G.point(w.center)then
            -- Destroyed on entering the radius: the entry must happen inside the window.
            local dx,dz=G.direction(o,s.b);local px,pz=w.center.x-o.x,w.center.z-o.z
            local along=px*dx+pz*dz;local side=math.abs(px*dz-pz*dx)
            if side>w.radius+(s.radius or 0)then return false end
            local reach=along-math.sqrt(math.max(0,(w.radius+(s.radius or 0))^2-side*side))
            local entry=launch+math.max(0,reach)/s.speed
            return entry>=defense.starts and entry<defense.ends and entry<=at
        end
        if not G.point(w.a)or not G.point(w.b)then return false end
        local rx,rz=s.b.x-o.x,s.b.z-o.z
        -- Where the remaining flight crosses a wall segment (share of the flight), or nil. The
        -- projectile's whole width must pass inside the wall: its radius narrows the segment.
        local function crosses(a,b)
            local sx,sz=b.x-a.x,b.z-a.z
            local denominator=rx*sz-rz*sx
            if math.abs(denominator)<1e-9 then return nil end
            local qx,qz=a.x-o.x,a.z-o.z
            local u=(qx*sz-qz*sx)/denominator;local v=(qx*rz-qz*rx)/denominator
            local inset=(s.radius or 0)/math.max(1,math.sqrt(sx*sx+sz*sz))
            if u<0 or u>1 or v<inset or v>1-inset then return nil end
            return u
        end
        local u=crosses(w.a,w.b);if not u then return false end
        local length=math.sqrt(rx*rx+rz*rz)
        if w.a2~=nil then
            -- A drifting wall (a2/b2 = where it ends up; a/b = next to its caster): where it stands at a
            -- given moment is not known, so the projectile must pass inside its width at both ends of the
            -- sweep, reach the far end while the wall lasts, and still be `lead` seconds from the player
            -- when the wall appears (it then meets the wall somewhere in between).
            local far=G.point(w.a2)and G.point(w.b2)and crosses(w.a2,w.b2)
            if not far then return false end
            return launch+far*length/s.speed<defense.ends and at>=defense.starts+(w.lead or .1)
        end
        local crossing=launch+u*length/s.speed
        return crossing>=defense.starts and crossing<defense.ends and crossing<=at
    end
    local function contact(row,source)
        if source then
            row.abilityName=source.abilityName;row.champion=source.champion;row.tier=source.tier
            -- Where the hit comes from (directional block) and whether it is a basic attack (attack dodge).
            row.sourcePos=source.castOrigin or source.origin;row.basicAttack=source.basicAttack==true or nil
            if defense and defense.kind=='windwall'and walled(source,row.at)then row.wallBlocked=true end
        end
        local key=row.damageID or row.id
        local index=seen[key]
        if index==nil then
            hits[#hits+1]=row;seen[key]=#hits
        elseif row.at<hits[index].at then
            hits[index]=row
        end
    end
    local potential,potentialSeen={},{}
    local potentialFirst=math.huge
    -- A continuous envelope does not identify individual hits or shield use.
    -- Only continuous full protection can remove an exposed time interval.
    local function potentialContact(s,a,b,t0,t1)
        local lo,hi=math.max(t0,s.starts),math.min(t1,s.ends)
        local untilTime=ctx.stats and ctx.stats.invulnerableUntil
        if G.finite(untilTime)then lo=math.max(lo,untilTime)end
        if lo>hi then return false end
        local function sweep(first,last)
            if first>last then return false end
            local start=G.lerp(a,b,t1>t0 and (first-t0)/(t1-t0)or 0)
            local finish=G.lerp(a,b,t1>t0 and (last-t0)/(t1-t0)or 0)
            return G.sweep(s,start,finish,first,last,reach,budget)
        end
        local continuous=defense and (defense.kind=='invulnerable'or defense.kind=='stasis'
            or defense.kind=='untargetable'and s.untargetableBlockable==true)
            and G.finite(defense.starts)and G.finite(defense.ends)and defense.ends>defense.starts
        if not continuous or defense.ends<=lo or defense.starts>hi then return sweep(lo,hi)end
        if lo<defense.starts then
            -- The included protection-start boundary is conservative. It may
            -- retain a contact, but cannot certify an untested preceding gap.
            local hit,at=sweep(lo,math.min(hi,defense.starts))
            if hit~=false then return hit,at end
        end
        return sweep(math.max(lo,defense.ends),hi)
    end
    local exposure=0;local walkingContact=false
    -- Normalized threat snapshots are immutable within this evaluation. The
    -- final revision check rejects reentrant updates; never retain this proof
    -- across evaluations or use it to authorize a later input dispatch.
    local coverParents={}
    local from,t=ctx.origin,ctx.now;local finish=ctx.now+(ctx.horizon or self.horizon)
    local function segment(a,b,t0,t1,walking)
        if walking and speedKnownUntil and not expiryCovered and t1>speedKnownUntil and G.dist(a,b)>0 then
            return false,'movement_speed_expiry_unknown'
        end
        local coverHits={}
        for _,s in ipairs(self.threats:Query(a,b,t0,t1,reach,self.query))do
            local coveredMiss=false
            local linked=s.channelInstanceID and self.threats.byID[s.channelInstanceID]
            -- A hit/unknown envelope cannot eliminate a native ray. Avoid its
            -- containment calculation entirely in those cases and at a single
            -- instant, where the native analytic sweep is cheaper.
            if linked and linked.shape=='cone'and linked.emissionSpeed and t1>t0 then
                local hit=coverHits[linked]
                if hit==nil then
                    hit=G.sweep(linked,a,b,t0,t1,reach,budget)
                    coverHits[linked]=hit==nil and 'unknown'or hit
                end
                if hit==false then
                    local parent=coverParents[s]
                    if parent==nil then parent=ChannelLink.Covered(self.threats.byID,s)or false;coverParents[s]=parent end
                    coveredMiss=parent==linked
                end
            end
            if not coveredMiss then
            local occupied,occupiedHit,occupiedAt
            -- Reuse the analytic occupancy result for both exposure and the
            -- first hit of linear circular zones within this segment only.
            if s.persistent and s.shape=='circle'and not s.motionUnknown and (s.acceleration or 0)==0 then
                if not s.radiusTransition and not s.motion and (not s.speed or s.speed==0)and (not s.launch or s.launch<=math.max(t0,s.starts))then
                    -- The unsplit disk sweep already returns its occupied interval.
                    -- Avoid allocating interval lists for stationary ground effects.
                    local last;occupiedHit,occupiedAt,last=G.sweep(s,a,b,t0,t1,reach,budget)
                    if occupiedHit==nil then return false,occupiedAt end
                    if occupiedHit then
                        if not G.finite(last)then return false,'exposure_interval_unknown'end
                        exposure=exposure+last-occupiedAt
                    end
                else
                    local intervals=G.intervals(s,a,b,t0,t1,reach,budget)
                    if not intervals.complete or not intervals.exact then return false,intervals.reason or 'exposure_interval_unknown'end
                    for _,interval in ipairs(intervals.intervals)do exposure=exposure+interval.ends-interval.starts end
                    local first=intervals.intervals[1];occupiedHit=first~=nil;occupiedAt=first and first.starts
                end
                occupied=true
            -- Other shapes retain a ranking estimate. Their continuous sweep
            -- below, never these samples, decides collision.
            elseif s.persistent and s.shape~='targeted'then
                local lo,hi=math.max(t0,s.starts),math.min(t1,s.ends)
                if hi>lo then for sample=1,16 do
                    budget.remaining=budget.remaining-1;if budget.remaining<0 then return false,'geometry_budget'end
                    local at=lo+(hi-lo)*(sample-.5)/16
                    local point=G.lerp(a,b,t1>t0 and (at-t0)/(t1-t0)or 0)
                    local distance=G.distance(s,point,at)
                    if distance==nil then return false,'geometry_unknown'end
                    if distance<=reach then exposure=exposure+(hi-lo)/16 end
                end end
            end
            local repeatInterval=s.repeatInterval
            if s.potentialDamage or G.possibleMotion(s)then
                local hit,at=potentialContact(s,a,b,t0,t1)
                if hit==nil then return false,at end
                if hit then
                    walkingContact=true;potentialFirst=math.min(potentialFirst,at)
                    if not potentialSeen[s.id]then
                        potentialSeen[s.id]=true;potential[#potential+1]=s.id
                    end
                end
            elseif repeatInterval then
                if not G.finite(repeatInterval)or repeatInterval<=0 then return false,'invalid_repeat_interval'end
                local first=math.max(0,math.ceil((t0-s.starts)/repeatInterval))
                local last=math.floor((math.min(t1,s.ends)-s.starts)/repeatInterval)
                if last-first>64 then return false,'repeat_budget'end
                for index=first,last do
                    local at=s.starts+index*repeatInterval;local key=tostring(s.damageID or s.id)..':tick:'..index
                    budget.remaining=budget.remaining-1;if budget.remaining<0 then return false,'geometry_budget'end
                    if not seen[key]then
                        local position=G.lerp(a,b,t1>t0 and (at-t0)/(t1-t0)or 0)
                        local distance=G.distance(s,position,at)
                        if distance==nil then return false,'geometry_unknown'end
                        if distance<=reach then
                    if s.shape~='targeted'then walkingContact=true end
                            contact({id=s.id,damageID=key,at=at,damage=s.damage,
                                cc=s.cc,ccUnknown=s.ccUnknown,ccHard=s.ccHard,blockable=s.blockable,parryable=s.parryable,
                                externalCounted=s.externalCounted,alreadyApplied=s.alreadyApplied,untargetableBlockable=s.untargetableBlockable},s)
                        end
                    end
                end
            elseif seen[s.damageID or s.id]==nil or hits[seen[s.damageID or s.id]].at>math.max(t0,s.starts)then
                local hit,at
                if s.shape=='targeted'then hit=s.targetID==ctx.heroID;at=math.max(t0,s.starts)
                elseif occupied then hit,at=occupiedHit,occupiedAt
                else hit,at=G.sweep(s,a,b,t0,t1,reach,budget)end
                if hit==nil then return false,at end
                if hit then
                    if s.shape~='targeted'then walkingContact=true end
                    contact({id=s.id,damageID=s.damageID,at=at,atLatest=s.shape=='targeted'and s.impactLatest or nil,damage=s.damage,cc=s.cc,ccUnknown=s.ccUnknown,ccHard=s.ccHard,parryable=s.parryable,
                        blockable=s.blockable,externalCounted=s.externalCounted,alreadyApplied=s.alreadyApplied,untargetableBlockable=s.untargetableBlockable},s)
                end
            end
            -- An initial protected contact cannot certify remaining inside a
            -- persistent zone after protection expires. Without a verified tick
            -- interval, preserve the later exposure as unknown damage.
            local firstContact=seen[s.damageID or s.id]
            firstContact=firstContact and hits[firstContact].at
            if defense and defense.kind~='heal'and s.persistent and not s.potentialDamage and not repeatInterval and defense.ends<t1
                and G.finite(firstContact)and firstContact<=defense.ends then
                local lo=math.max(t0,defense.ends+0.000001)
                local key=tostring(s.damageID or s.id)..':after-defense'
                if lo<=t1 and(seen[key]==nil or hits[seen[key]].at>math.max(lo,s.starts))then
                    local start=G.lerp(a,b,t1>t0 and (lo-t0)/(t1-t0)or 0)
                    local hit,at=G.sweep(s,start,b,lo,t1,reach,budget)
                    if hit==nil then return false,at end
                    if hit then
                        contact({id=s.id,damageID=key,at=at,
                            cc=s.cc,ccUnknown=s.ccUnknown,ccHard=s.ccHard,parryable=s.parryable,blockable=s.blockable,untargetableBlockable=s.untargetableBlockable},s)
                    end
                end
            end
            end
        end
        return true
    end
    -- All candidate routes share the currently observed dash prefix. A walking
    -- command does not redirect that native segment, and wall crossing already
    -- in progress must not be tested as an ordinary walking segment.
    if ctx.observedMotion then
        local motion=ctx.observedMotion
        if motion.at~=ctx.now or G.dist(motion.from,ctx.origin)>.001
            or motion.kind~='continuous' or not G.finite(motion.duration)or motion.duration<=0 then
            return unknown('invalid_observed_motion')
        end
        local duration=math.min(motion.duration,math.max(0,finish-t))
        local endpoint=ChampionMotion.Sample(motion,duration)
        if not G.point(endpoint)then return unknown('observed_motion_unavailable')end
        local ok,why=segment(from,endpoint,t,t+duration,false)
        if not ok then return unknown(why)end
        from,t=endpoint,t+duration
        if duration<motion.duration then return unknown('observed_motion_exceeds_horizon')end
    end
    local delay=observedRoute and (ctx.windup or 0)or (ctx.delay or 0)
    -- A walking order that is only being requested now is acquired and sent on a later callback.
    if not observedRoute and not defense and not ctx.mobility and ctx.sendLag then
        if not G.finite(ctx.sendLag)or ctx.sendLag<0 then return unknown('invalid_delay')end
        delay=math.max(delay,.035+ctx.sendLag)
    end
    if ctx.observedMotion then delay=math.max(0,delay-ctx.observedMotion.duration)end
    if not G.finite(delay)or delay<0 then return unknown('invalid_delay')end
    local controlHold=0
    if ctx.controlHoldUntil~=nil then
        if not G.finite(ctx.controlHoldUntil)then return unknown('invalid_control_hold')end
        controlHold=math.max(0,ctx.controlHoldUntil-t)
        delay=math.max(delay,controlHold+(observedRoute and 0 or .035))
    end
    local waypointDelay=observedRoute and 0 or (ctx.waypointDelay or 0)
    if not G.finite(waypointDelay)or waypointDelay<0 then return unknown('invalid_waypoint_delay')end
    local hold=math.max(controlHold,observedRoute and delay or math.min(delay,ctx.windup or 0))
    hold=math.min(hold,math.max(0,finish-t))
    local ok,why=segment(from,from,t,math.min(finish,t+hold),false)
    if not ok then return unknown(why)end;t=t+hold
    -- Before a new command takes effect, existing walking continues. Only an
    -- observed attack windup or stationary CC is stationary. Never invent a stationary reaction
    -- interval for a player already moving toward a projectile.
    local waiting=math.min(delay-hold,math.max(0,finish-t))
    if not observedRoute and waiting>0 and type(ctx.currentPath)=='table'then
        for _,point in ipairs(ctx.currentPath)do
            if not G.point(point)then return unknown('invalid_observed_path')end
            if waiting<=0 then break end
            local distance=G.dist(from,point)
            if distance>0 then
    if speedChanges then
     local old=t;local endpoint,arrival,reached,reason=Trajectory.WalkTimed(from,point,t,t+waiting,ctx.speed,speedChanges,budget,segment)
     if not endpoint then return unknown(reason)end
     from,t,waiting=endpoint,arrival,waiting-(arrival-old)
    else
     local dt=math.min(waiting,distance/ctx.speed)
     local endpoint=G.lerp(from,point,ctx.speed*dt/distance)
     ok,why=segment(from,endpoint,t,t+dt,true);if not ok then return unknown(why)end
     from,t,waiting=endpoint,t+dt,waiting-dt
    end
            end
        end
    end
    if waiting>0 then
        ok,why=segment(from,from,t,t+waiting,false);if not ok then return unknown(why)end;t=t+waiting
    end
    if ctx.immobilizedUntil then
        if not G.finite(ctx.immobilizedUntil)then return unknown('invalid_immobility')end
        local untilTime=math.min(finish,math.max(t,ctx.immobilizedUntil))
        ok,why=segment(from,from,t,untilTime,false);if not ok then return unknown(why)end;t=untilTime
        path={G.copy(from)}
    end
    local movementOrigin,movementStart=G.copy(from),t
    local timedSegments=(speedChanges or waypointDelay>0 and #path>1)and {}
 local mobility=ctx.mobility;local first=1
    if mobility then
        local dash=mobility.kind=='dash'
        if mobility.kind~='blink'and not dash or not G.finite(mobility.range)or mobility.range<=0
            or not G.finite(mobility.castDelay)or mobility.castDelay<0 or not G.point(path[1])
            or dash and(not G.finite(mobility.speed)or mobility.speed<=0)
            or G.dist(from,path[1])>mobility.range then return unknown('invalid_mobility')end
        local arrival=t+mobility.castDelay
        if arrival>finish then return unknown('route_exceeds_horizon')end
        ok,why=segment(from,from,t,arrival,false);if not ok then return unknown(why)end
        if dash then
            -- A dash is a fast linear segment: threats along it still hit, and
            -- terrain must be clear along the whole path (no wall crossing).
            local landed=arrival+G.dist(from,path[1])/mobility.speed
            if landed>finish then return unknown('route_exceeds_horizon')end
            ok,why=segment(from,path[1],arrival,landed,true);if not ok then return unknown(why)end
            ok,why=self.terrain:Segment(from,path[1],ctx.radius,arrival,landed,budget)
            if ok~=true then return unknown(why)end
            arrival=landed
        else
            ok,why=self.terrain:Segment(path[1],path[1],ctx.radius,arrival,arrival,budget)
            if ok~=true then return unknown(why)end
        end
        from,t=path[1],arrival;first=2
        movementOrigin,movementStart=G.copy(from),t
    end
    for i=first,#path do local point=path[i]
        if not G.point(point)then return unknown('invalid_endpoint')end
        -- Evade dispatches commanded waypoints separately. Preserve the wait
        -- at each handoff; an observed native path does not need these inputs.
        if i>first and waypointDelay>0 then
            local arrival=t+waypointDelay
            if arrival>finish then return unknown('route_exceeds_horizon')end
            ok,why=segment(from,from,t,arrival,false);if not ok then return unknown(why)end
            timedSegments[#timedSegments+1]={a=from,b=from,t0=t,t1=arrival}
            t=arrival
        end
        if speedChanges then
   local endpoint,arrival,reached,reason=Trajectory.WalkTimed(from,point,t,finish,ctx.speed,speedChanges,budget,function(a,b,t0,t1)
    local good,why=segment(a,b,t0,t1,true)
    if good then timedSegments[#timedSegments+1]={a=a,b=b,t0=t0,t1=t1}end
    return good,why
   end)
   if not endpoint then return unknown(reason)end
   if not reached then return unknown('route_exceeds_horizon')end
   from,t=endpoint,arrival
  else
   local dt=G.dist(from,point)/ctx.speed
   if t+dt>finish then return unknown('route_exceeds_horizon')end
            ok,why=segment(from,point,t,t+dt,true);if not ok then return unknown(why)end
            if timedSegments then timedSegments[#timedSegments+1]={a=from,b=point,t0=t,t1=t+dt}end
            from,t=point,t+dt
  end
    end
    ok,why=segment(from,from,t,finish,false);if not ok then return unknown(why)end
    -- A persistent zone that activates after arrival still makes the destination
    -- unsuitable. Do not assume leaving it without a subsequently issued route.
    local suppressed=self.threats.suppressed
    for _,s in ipairs(self.threats.list)do if s.persistent and s.ends>finish and not suppressed[s.id]then
        -- Keep the already-exposed baseline usable when comparing an exit.
        -- A protected or currently clear destination still needs its later check.
        local current=finish>=s.starts and G.distance(s,from,finish)
        local alreadyExposed=not defense and (seen[s.damageID or s.id]or potentialSeen[s.id])
            and current and current<=reach
        if not alreadyExposed then
            local hit,why=G.sweep(s,from,from,math.max(finish,s.starts),s.ends,reach,budget)
            if hit==nil then return unknown(why or 'persistent_geometry_unknown')end
            if hit then return unknown('future_persistent_zone')end
        end
    end end
    local result=D.forecast(hits,ctx.stats or {},defense)
    result.potentialHits=potential;result.potentialCount=#potential
    if #potential>0 then result.unknown=true;result.potentialDamageUnknown=true end
    result.known=true;result.safe=#potential==0 and (#hits==0 or #result.hits==0 and not result.unknown);result.arrival=t;result.position=G.copy(from)
    -- Walking safety excludes effects that ordinary movement cannot dodge.
    -- Combined damage/CC and uncertainty remain in the result for mitigation.
    result.walkSafe=not walkingContact or result.safe
    result.observedRoute=observedRoute==true
    result.work=began-budget.remaining;result.threatRevision=threatRevision
    result.exposure=exposure;result.exitClear=true
    for _,s in ipairs(self.threats:Query(from,from,t,finish,reach,self.query))do
        if s.shape~='targeted'then
            local hit,reason=G.sweep(s,from,from,t,finish,reach,budget)
            if hit==nil then return unknown(reason)end
            if hit then result.exitClear=false end
        end
    end
    -- Reject collision-doomed candidates before costly native wall queries.
    -- An exposure-only result never certifies terrain or authorizes input.
    local unusable=not result.walkSafe and not defense and not (exposure>0 and result.exitClear)
    result.terrainValidated=false
    if not observedRoute and not (skipUnusableTerrain and unusable)then
  if timedSegments then
   for _,piece in ipairs(timedSegments)do
    local free,reason=self.terrain:Segment(piece.a,piece.b,ctx.radius,piece.t0,piece.t1,budget)
    if free~=true then return unknown(reason)end
   end
  else
   local position,time=movementOrigin,movementStart
   for i=first,#path do local point=path[i]
    local arrival=time+G.dist(position,point)/ctx.speed
    local free,reason=self.terrain:Segment(position,point,ctx.radius,time,arrival,budget)
    if free~=true then return unknown(reason)end
    position,time=point,arrival
   end
  end
        result.terrainValidated=true
    end
    result.work=began-budget.remaining
    result.terrainRevision=terrainRevision;result.reason=result.safe and 'clear' or 'threat_intersection'
    result.firstImpact=potentialFirst;for _,hit in ipairs(hits)do result.firstImpact=math.min(result.firstImpact,hit.at)end
    result.path={};for _,p in ipairs(path)do result.path[#result.path+1]=G.copy(p)end
    result.danger=0
    if ctx.destinationDanger then
        local good,value=pcall(ctx.destinationDanger,from,t)
        if not good or not G.finite(value)or value<0 then return unknown('destination_danger_unknown')end
        result.danger=value
    end
    result.combatCost=0
    if ctx.combatCost then
        local good,value=pcall(ctx.combatCost,from,t)
        if not good or not G.finite(value)or value<0 then return unknown('combat_cost_unknown')end
        result.combatCost=value
    end
    -- Native terrain and adapter callbacks can invalidate an earlier phase.
    -- Never stamp a stale geometric result with a newer world revision.
    fresh,motionFailure=motionFresh()
    if not fresh then return unknown(motionFailure)end
    if self.threats.revision~=threatRevision then return unknown('threats_changed')end
    if self.terrain.revision~=terrainRevision then return unknown('terrain_changed')end
    return result
end
local function walkingSafe(r)return r and (r.safe or r.walkSafe==true)end
local terrainRefusal={static_wall=true,live_wall=true,dynamic_wall=true,terrain_unknown=true,dynamic_terrain_unknown=true}
local function compare(x,y)
    if math.abs(x-y)>.0001 then return x<y end
end
local function compareCore(a,b)
    local order=compare(walkingSafe(a)and 0 or 1,walkingSafe(b)and 0 or 1);if order~=nil then return order end
    order=compare(a.lethal and 1 or 0,b.lethal and 1 or 0);if order~=nil then return order end
    order=compare(a.unknown and (#a.hits+(a.potentialCount or 0))or 0,b.unknown and (#b.hits+(b.potentialCount or 0))or 0);if order~=nil then return order end
    -- With equally many unknown hits, the reviewed severity tier stands in for the missing damage.
    order=compare(a.unknown and a.tier or 0,b.unknown and b.tier or 0);if order~=nil then return order end
    order=compare(a.damage,b.damage);if order~=nil then return order end
    -- With equal damage, any hard control (even without a known duration) is worse.
    order=compare(a.ccHard and 1 or 0,b.ccHard and 1 or 0);if order~=nil then return order end
    order=compare(a.cc or 0,b.cc or 0);if order~=nil then return order end
    order=compare(a.danger or 0,b.danger or 0);if order~=nil then return order end
    order=compare(a.resourceCost or 0,b.resourceCost or 0);if order~=nil then return order end
    return compare(a.exposure or 0,b.exposure or 0)
end
local function positionCost(r,ctx)
    local aim=ctx.intent or ctx.origin;local first=r.path and r.path[1]or r.position
    local angle=0
    if first and G.dist(ctx.origin,aim)>5 then
        local dx,dz=G.direction(ctx.origin,aim);local x,z=G.direction(ctx.origin,first)
        angle=G.dist(ctx.origin,first)>5 and 1-math.max(-1,math.min(1,dx*x+dz*z))or 2
    end
    local remaining=r.position and G.dist(r.position,aim)or math.huge
    return ctx.flee and remaining or angle+(r.combatCost or 0),ctx.flee and angle or remaining
end
local function stale(self,result)
    return result and (result.threatRevision~=nil and result.threatRevision~=self.threats.revision
        or result.terrainRevision~=nil and result.terrainRevision~=self.terrain.revision)
end
function P:Executable(result,baseline,ctx)
    if self.threats.observationIncomplete then return false end
    if stale(self,result)or stale(self,baseline)then return false end
    if not result or not result.known or result.observedRoute or result.terrainValidated==false then return false end
    if walkingSafe(result)then return true end
    -- Leaving an already active zone necessarily intersects it initially. Permit
    -- a fully evaluated exit only when it reduces exposure without new hits.
    if not baseline or not baseline.known or walkingSafe(baseline)or not result.exitClear
        or (result.exposure or 0)+.03>=(baseline.exposure or 0)then return false end
    local old={};for _,id in ipairs(baseline.hits)do old[id]=true end
    for _,id in ipairs(result.hits)do if not old[id]then return false end end
    local oldPotential={};for _,id in ipairs(baseline.potentialHits or {})do oldPotential[id]=true end
    for _,id in ipairs(result.potentialHits or {})do if not oldPotential[id]then return false end end
    return self:Better(result,baseline,ctx)
end
-- A defensive action can leave a smaller unavoidable hit. Walking still uses
-- Executable: this permission cannot authorize a futile movement detour.
function P:DefenseExecutable(result,baseline)
    if self.threats.observationIncomplete then return false end
    if stale(self,result)or stale(self,baseline)then return false end
    if not result or not result.known or result.observedRoute or not result.terrainValidated then return false end
    if result.safe then return true end
    if not baseline or not baseline.known or baseline.safe
        or baseline.unknown or result.unknown or baseline.ccUnknown or result.ccUnknown
        or not G.finite(result.damage)or not G.finite(baseline.damage)then return false end
    -- Both forecasts stop at death. A smaller lethal total is not evidence
    -- that spending this cooldown achieves a survivable outcome.
    if result.lethal then return false end
    if baseline.lethal then return true end
    local cc,oldCC=result.cc or 0,baseline.cc or 0
    if result.damage>baseline.damage or cc>oldCC or result.ccHard and not baseline.ccHard
        or (result.danger or 0)>(baseline.danger or 0)then return false end
    return result.damage+.001<baseline.damage or cc+.001<oldCC
end
function P:Better(a,b,ctx)
    if not a or not a.known then return false end;if not b or not b.known then return true end
    local order=compareCore(a,b);if order~=nil then return order end
    local x1,x2=positionCost(a,ctx);local y1,y2=positionCost(b,ctx)
    order=compare(x1,y1);if order~=nil then return order end
    order=compare(x2,y2);if order~=nil then return order end
    return compare((a.arrival or ctx.now)-ctx.now,(b.arrival or ctx.now)-ctx.now)or false
end
function P:Retain(prior,best,ctx)
    if not prior or not (prior.continuing or prior.committed)or not prior.known or not walkingSafe(prior)or not prior.terrainValidated
        or prior.threatRevision~=self.threats.revision or prior.terrainRevision~=self.terrain.revision then return false end
    if not best or not best.known then return true end
    -- Hysteresis applies only to positioning. Never trade safety, damage, CC,
    -- destination danger or resources for a smoother line.
    if compareCore(prior,best)~=nil then return false end
    -- A dodge that is requested but not yet sent keeps its destination while it is as safe as the best:
    -- alternating between equal escapes only loses the request (live: evade_route_changed, nothing sent).
    if prior.committed then return true end
    local x1,x2=positionCost(prior,ctx);local y1,y2=positionCost(best,ctx)
    if ctx.flee then return x1<=y1+25 and x2<=y2+.02 end
    return x1<=y1+.02 and x2<=y2+25
end
local function push(heap,n)
    local i=#heap+1;while i>1 do local p=math.floor(i/2);if heap[p].f<=n.f then break end;heap[i]=heap[p];i=p end;heap[i]=n
end
local function pop(heap)
    local a,last=heap[1],table.remove(heap);if #heap>0 then
        local i=1;while i*2<=#heap do local c=i*2;if c<#heap and heap[c+1].f<heap[c].f then c=c+1 end
            if heap[c].f>=last.f then break end;heap[i]=heap[c];i=c end;heap[i]=last
    end;return a
end
function P:Search(ctx,previous)
    if ctx.trajectoryReason then
        local result=unknown(ctx.trajectoryReason);result.candidates=0;result.nodes=0
        return nil,result
    end
    local threatRevision,terrainRevision=self.threats.revision,self.terrain.revision
    local function changed()
        return self.threats.revision~=threatRevision or self.terrain.revision~=terrainRevision
    end
    local original=ctx;ctx={};for k,v in pairs(original)do ctx[k]=v end
    -- The decision is bounded by work, not by a clock: the host clock advances in ~15.6 ms steps, so a
    -- 4 ms deadline fired at the next step whatever had been done (live: 0-5 nodes, work 217-991 of
    -- 64000). `nativeBudget` counts native terrain queries, the expensive unit (about 20 us each in the
    -- host). A caller with a clock that can measure milliseconds may still pass `budgetClock`.
    ctx.sharedBudget=ctx.sharedBudget or {remaining=ctx.cycleBudget or 64000,native=ctx.nativeBudget}
    local shared=ctx.sharedBudget
    local reach=ctx.radius+(ctx.margin or 0)
    local maxCandidates=math.min(self.maxCandidates,ctx.candidateLimit or self.maxCandidates)
    local clock=ctx.budgetClock;local deadline=clock and clock()+(ctx.decisionBudgetMs or 4)
    local function timeRemaining()return (not deadline or clock()<deadline)and (not shared.native or shared.native>0)end
    local length=math.max(0,ctx.speed*(self.horizon-(ctx.delay or 0))*.8)
    local intent=G.point(ctx.intent)and ctx.intent or ctx.origin
    if G.dist(ctx.origin,intent)>length then intent=G.lerp(ctx.origin,intent,length/G.dist(ctx.origin,intent))end
    local current=ctx.currentPath and Trajectory.Clip(ctx.currentPath,ctx.origin,length)or {intent}
    local baseline=self:Evaluate(current,ctx,nil,true);local idle
    local count=1;local command;local continuing;local terrainBlocked=false
    -- Nothing can be evaluated in this state (control effect, incomplete observation): searching routes
    -- and terrain would only spend the frame (live: such decisions ran the node search to the clock step).
    if not baseline.known and baseline.contextual then baseline.candidates=count;baseline.nodes=0;return nil,baseline end
    if ctx.command then
        command=self:Evaluate({intent},ctx,nil,false,not walkingSafe(baseline));count=count+1
        -- A held orbwalker mode will issue this intention again. A safe observed
        -- dodge does not mean that replacing it with this command is safe.
        -- An unknown command cannot certify releasing a committed dodge either:
        -- the orbwalker reissues it as soon as evade unblocks movement.
        if walkingSafe(baseline) and not walkingSafe(command) and (command.known or previous and previous.path)then baseline=command end
    end
    local commandOutcome=command and(not command.known and tostring(command.reason)or walkingSafe(command)and 'safe'or 'unsafe')or nil
    if command and not command.known and terrainRefusal[command.reason]then terrainBlocked=true end
    local moving=false
    for _,point in ipairs(ctx.currentPath or {})do if G.dist(point,ctx.origin)>5 then moving=true;break end end
    -- Standing is an outcome only when already stationary. A safe idle endpoint
    -- cannot cancel a real movement order without a dispatchable stopping action.
    if walkingSafe(baseline) then
        if changed()then local r=unknown('planning_state_changed');r.candidates=count;r.nodes=0;return nil,r end
        baseline.candidates=count;baseline.nodes=0;baseline.commandOutcome=commandOutcome;return baseline,baseline
    end
    if not moving then idle=self:Evaluate({ctx.origin},ctx,nil,false,true);count=count+1 end
    local best=baseline.known and baseline or not moving and idle.known and idle or nil
    if not moving and self:Better(idle,best,ctx)then best=idle end
    if command and command.known and self:Better(command,best,ctx)then best=command end
    -- GetTickCount advances in ~15.6 ms steps, so the 4 ms soft deadline can
    -- expire before any escape is tried (live: 1-2 candidates, false no_safe).
    -- Until a walking-safe route is known, guarantee a bounded candidate floor.
    -- Candidate/work caps still bound it; terrain-node search keeps the soft clock.
    local minimumCandidates=math.min(maxCandidates,self.minimumCandidates or 0)
    local function candidateTime()
        if count<minimumCandidates and not walkingSafe(best)then return true end
        return timeRemaining()
    end
    -- Reuse only an identical commanded destination within this planning
    -- cycle. Threats remain distinct; this avoids reevaluating the same escape
    -- once per overlapping threat. Dispatch still performs fresh preparation.
    local singleCandidates={}
    local optionalToken,optionalStarted,optionalStopped
    local function consider(path)
        if count>=maxCandidates or ctx.sharedBudget.remaining<=0 or not candidateTime()then return end
        -- Preserve the candidate-attempt budget and search order. Saved work
        -- shortens the same search rather than silently expanding its workload.
        count=count+1
        local point=#path==1 and path[1];local bucket,cached,x,y,z
        local valid=G.point(point)
        if valid then
            x,y,z=point.x,point.y,point.z
            bucket=singleCandidates[x];cached=bucket and bucket[z]
            if cached and cached.y==y then return cached.result end
        end
        if optionalToken then
            if optionalStarted and not optionalToken:Checkpoint(1)then optionalStopped=true;return end
            optionalStarted=true
        end
        local r=self:Evaluate(path,ctx,nil,false,true)
        if valid and point.x==x and point.y==y and point.z==z then
            if not bucket then bucket={};singleCandidates[x]=bucket end
            bucket[z]={y=y,result=r}
        end
        if not r.known and terrainRefusal[r.reason]then terrainBlocked=true end
        if self:Better(r,best,ctx)then best=r end;return r
    end
    -- Revalidate a continuing dodge first. Releasing it merely because the
    -- observed path is now safe lets held Flee overwrite it on the next callback.
    if previous and previous.path then
        local remaining={};local skipping=true
        for _,point in ipairs(previous.path)do
            if G.dist(point,ctx.origin)>10 then skipping=false end
            if not skipping then remaining[#remaining+1]=point end
        end
        if #remaining>0 and ctx.sharedBudget.remaining>0 then
            -- A bounded refresh of the committed route is mandatory even when
            -- the soft clock budget was consumed by baseline/command checks.
            -- Skipping it used to release Flee into a still-active projectile.
            local actual=ctx.currentPath;local last=actual and actual[#actual]
            local following=last and G.dist(last,previous.path[#previous.path])<=25
            local priorContext=ctx
            if following then
                priorContext={};for k,v in pairs(ctx)do priorContext[k]=v end
                priorContext.delay=ctx.windup or 0;priorContext.waypointDelay=0
                remaining=current -- Preserve actual waypoints, including detours.
            end
            count=count+1;local prior=self:Evaluate(remaining,priorContext,nil,false,true)
            prior.continuing=following==true;prior.committed=not following and ctx.commitPrevious==true
            if prior.continuing or prior.committed then continuing=prior end
            if self:Better(prior,best,ctx)then best=prior end
        end
    end
    -- Generate the same direct/boundary candidates lazily. Discovery stops at
    -- the first checked safe route; the rest resumes only inside admission.
    local dx,dz=G.direction(ctx.origin,intent)
    local directAngles={0,math.pi/16,-math.pi/16,math.pi/8,-math.pi/8}
    local directIndex,nearbyIndex,escapeCount=1,1,0
    local nearby,boundarySecond
    local function nextSeed()
        if directIndex<=#directAngles then
            local a=directAngles[directIndex];directIndex=directIndex+1
            local x,z=dx*math.cos(a)-dz*math.sin(a),dz*math.cos(a)+dx*math.sin(a)
            return {x=ctx.origin.x+x*length*.75,y=ctx.origin.y,z=ctx.origin.z+z*length*.75}
        end
        if boundarySecond then local p=boundarySecond;boundarySecond=nil;return p end
        if escapeCount>=8 then return end
        if not nearby then
            nearby={};self.threats:Query(ctx.origin,ctx.origin,ctx.now,ctx.now+self.horizon,reach,nearby)
        end
        while nearbyIndex<=#nearby and escapeCount<8 do
            local s=nearby[nearbyIndex];nearbyIndex=nearbyIndex+1
            local center=s.speedUncertain and (s.origin or s.a)or G.center(s,ctx.now)
            local clearance=(s.radius or 0)+reach+25
            if center and (s.shape=='circle'or s.shape=='ring')then
                local x,z=G.direction(center,ctx.origin)
                if G.dist(center,ctx.origin)<1 then x,z=G.direction(ctx.origin,intent)end
                escapeCount=escapeCount+1
                return {x=center.x+x*clearance,y=ctx.origin.y,z=center.z+z*clearance}
            elseif center and s.b and (s.shape=='missile'or s.shape=='line'or s.shape=='rectangle')then
                local x,z=G.direction(center,s.b)
                local side=(ctx.origin.x-center.x)*-z+(ctx.origin.z-center.z)*x
                local sign=side>=0 and 1 or -1
                local first,second=sign*clearance-side,-sign*clearance-side
                boundarySecond={x=ctx.origin.x-z*second,y=ctx.origin.y,z=ctx.origin.z+x*second}
                escapeCount=escapeCount+1
                return {x=ctx.origin.x-z*first,y=ctx.origin.y,z=ctx.origin.z+x*first}
            end
        end
    end
    local function seeds(token)
        while not optionalStopped and candidateTime()and count<maxCandidates and ctx.sharedBudget.remaining>0 do
            if ctx.refineRoutes and not token and best and walkingSafe(best)then return end
            local p=nextSeed();if not p then return end
            consider({p})
        end
    end
    seeds()
    local radialLimit=maxCandidates-math.max(1,math.floor(maxCandidates/4));local radialLimited=false
    local function explore(token)
    optionalToken=token
    seeds(token)
    -- Refine a fully checked escape toward the intended heading. Each midpoint
    -- gets the complete time/terrain test; angular interpolation alone proves nothing.
    if best and walkingSafe(best) and best.path and #best.path==1 then
        local target=best.path[1];local distance=G.dist(ctx.origin,target)
        local bx,bz=G.direction(ctx.origin,target)
        local angle=math.atan2(dx*bz-dz*bx,dx*bx+dz*bz)
        local lo,hi=0,math.abs(angle);local sign=angle<0 and -1 or 1
        for refinement=1,5 do
            if optionalStopped or not candidateTime()or count>=maxCandidates then break end
            local a=(lo+hi)*.5;local x,z=dx*math.cos(a*sign)-dz*math.sin(a*sign),dz*math.cos(a*sign)+dx*math.sin(a*sign)
            local r=consider({{x=ctx.origin.x+x*distance,y=ctx.origin.y,z=ctx.origin.z+z*distance}})
            if r and r.known and walkingSafe(r) then hi=a else lo=a end
        end
    end
    -- If direct escapes still fail, leave a quarter of the route evaluations
    -- for complete local paths. Dense overlapping boundaries otherwise consume
    -- all 64 candidates before even the first terrain-search node is expanded.
    -- A checked safe direct escape needs no local search and keeps the full budget.
    for _,scale in ipairs({.45,.22,.75})do
        if optionalStopped or not candidateTime()or count>=maxCandidates then break end
        if count>=radialLimit and (not best or not walkingSafe(best))then radialLimited=true;break end
        for _,i in ipairs({0,1,-1,2,-2,3,-3,4,-4,5,-5,6,-6,7,-7,8})do
        if optionalStopped or not candidateTime()or count>=maxCandidates then break end
        -- Mandatory discovery ends once it has found a complete safe route.
        -- Additional quality work waits for shared admission on the next decision.
        if ctx.refineRoutes and not token and best and walkingSafe(best)then return true end
        if count>=radialLimit and (not best or not walkingSafe(best))then radialLimited=true;break end
        local a=i*math.pi/8;local x,z=dx*math.cos(a)-dz*math.sin(a),dz*math.cos(a)+dx*math.sin(a)
        consider({{x=ctx.origin.x+x*length*scale,y=ctx.origin.y,z=ctx.origin.z+z*length*scale}})
    end end
    return true
    end
    local refinementDeferred
    if ctx.refineRoutes and best and walkingSafe(best)then
        local ran,reason=ctx.refineRoutes(explore)
        if not ran then refinementDeferred=reason end
    else explore()end
    optionalToken=nil
    local expanded=0
    -- The local path search answers terrain: it runs only when a threat-free straight route was refused by a
    -- wall. In open ground it re-samples what the straight candidates covered and only spent the frame.
    if (not best or not walkingSafe(best))and terrainBlocked then
        local step=self.terrain.grid and self.terrain.grid.cell or 50
        local heap,seen={{x=0,z=0,g=0,f=0}}, {['0:0']=0}
        while #heap>0 and expanded<self.maxNodes and count<maxCandidates and ctx.sharedBudget.remaining>0 and timeRemaining()do
            local n=pop(heap);expanded=expanded+1
            local p={x=ctx.origin.x+n.x*step,y=ctx.origin.y,z=ctx.origin.z+n.z*step}
            if n.g>0 then
                local d=math.huge;for _,s in ipairs(self.threats:Query(p,p,ctx.now,ctx.now+self.horizon,reach,self.query))do
                    local v=G.distance(s,p,ctx.now+n.g/ctx.speed);if v then d=math.min(d,v)end
                end
                if d>reach then
                    local reverse={};local q=n;while q.parent do reverse[#reverse+1]={x=ctx.origin.x+q.x*step,y=ctx.origin.y,z=ctx.origin.z+q.z*step};q=q.parent end
                    local path={};for j=#reverse,1,-1 do path[#path+1]=reverse[j]end
                    local result=consider(path);if result and walkingSafe(result) then break end
                end
            end
            for x=-1,1 do for z=-1,1 do if x~=0 or z~=0 then
                local nx,nz=n.x+x,n.z+z;local key=nx..':'..nz
                local distance=n.g+step*((x~=0 and z~=0)and 1.4142135623731 or 1)
                if distance<=length and (not seen[key]or distance<seen[key])then
                    local point={x=ctx.origin.x+nx*step,y=ctx.origin.y,z=ctx.origin.z+nz*step}
                    local free=self.terrain:Segment(p,point,ctx.radius,ctx.now+n.g/ctx.speed,ctx.now+distance/ctx.speed,ctx.sharedBudget)
                    if free==true then seen[key]=distance;push(heap,{x=nx,z=nz,g=distance,f=distance+G.dist(point,intent)*.1,parent=n})end
                end
            end end end
        end
    end
    if self:Retain(continuing,best,ctx)then best=continuing end
    if best then best.candidates=count;best.nodes=expanded;best.refinementDeferred=refinementDeferred or optionalStopped and 'checkpoint'
        best.work=math.min(ctx.cycleBudget or 64000,(ctx.cycleBudget or 64000)-ctx.sharedBudget.remaining)
        best.native=shared.native and (shared.nativeGranted or ctx.nativeBudget)-math.max(0,shared.native)or nil
        best.exhausted=(radialLimited and not walkingSafe(best))or count>=maxCandidates or expanded>=self.maxNodes or ctx.sharedBudget.remaining<=0 or not timeRemaining()end
    if changed()then
        local result=unknown('planning_state_changed');result.candidates=count;result.nodes=expanded
        return nil,result
    end
    baseline.commandOutcome=commandOutcome
    return best,baseline
end
-- One decision. Routes are searched against padded shapes first (`ctx.margin`); only when none clears them
-- is the remaining budget spent on exact shapes: a tight escape beats none, and a route that is clear
-- only by less than the margin is kept rather than abandoned for nothing.
function P:Plan(ctx,previous)
    local margin=ctx.margin
    if not margin or margin<=0 then return self:Search(ctx,previous)end
    local padded={};for k,v in pairs(ctx)do padded[k]=v end
    -- A quarter of the native queries is kept back for the exact pass.
    local native=ctx.nativeBudget;local reserve=native and math.floor(native/4)or 0
    local shared={remaining=ctx.cycleBudget or 64000,native=native and native-reserve,nativeGranted=native and native-reserve}
    padded.sharedBudget=shared
    local best,baseline=self:Search(padded,previous)
    if best and walkingSafe(best)or not baseline or baseline.contextual or baseline.reason=='planning_state_changed'
        or ctx.trajectoryReason then return best,baseline end
    local exact={};for k,v in pairs(padded)do exact[k]=v end
    if native then shared.native=math.max(0,shared.native)+reserve;shared.nativeGranted=native end
    exact.margin=0;exact.candidateLimit=math.min(self.maxCandidates,self.minimumCandidates or self.maxCandidates)
    local tight,tightBaseline=self:Search(exact,previous)
    if not tight or not walkingSafe(tight)then return best,baseline end
    tight.tight=true;tight.candidates=(tight.candidates or 0)+(best and best.candidates or 0)
    tight.nodes=(tight.nodes or 0)+(best and best.nodes or 0)
    -- The padded baseline stays the reported risk unless the exact route is simply clear.
    if tightBaseline and walkingSafe(tightBaseline)then return tight,tightBaseline end
    return tight,baseline
end
return P

end
