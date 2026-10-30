return function(require)
-- Predicted stopping blocker for unit-stopping projectiles. Pure: no host calls.
--
-- A threat may only be shortened under an explicit per-ability policy
-- ({minion=bool,monster=bool,champion=bool,count=N,source=...}). `count` (default
-- 1) is the unit the projectile stops at: Lux's Light Binding passes the first
-- enemy and stops at the second (count=2). Only certain contacts are counted, so
-- the predicted stop is never earlier than the real one: an uncertain unit that
-- is actually hit only stops the flight sooner. Missing/unknown policy
-- means the projectile is treated as non-colliding (full length), which is the
-- safe direction for the walking planner. Champion-only policies ignore minions
-- and monsters. The caller supplies a bounded unit snapshot (no controlled
-- player): {x,z,radius,vx,vz,category,team,aliveUntil}. Velocity is a linear
-- forecast; its error grows with lead time and shrinks the contact radius, so a
-- reported contact is certain under that bound. A blocker that may move away or
-- die before contact therefore does not clip. Only constant-speed fixed flights
-- are clipped; accelerated, speed-uncertain, redirected and motion-unknown
-- flights keep their full length.
local G=require('evade.geometry')
local B={}
B.defaults={margin=10,errorRate=100,aliveMargin=.1,maxUnits=32,maxWork=96}
local sqrt,max,min=math.sqrt,math.max,math.min
local categories={minion=true,monster=true,champion=true}
B.maxCount=8
-- Reused per-call buffers of the `count` earliest certain contacts (sorted by time).
local hitAt,hitDistance,hitIndex={},{},{}
-- Validate an explicit policy. Returns nil (no clipping) for anything incomplete.
function B.policy(p)
    if type(p)~='table'or type(p.source)~='string'or p.source==''then return nil end
    local n=p.count
    if n~=nil and(type(n)~='number'or n%1~=0 or n<1 or n>B.maxCount)then return nil end
    local any=false
    for key in pairs(categories)do
        local v=p[key];if v~=nil and type(v)~='boolean'then return nil end
        any=any or v==true
    end
    return any and p or nil
end
local function eligible(s)
    return s.shape=='missile'and not s.motion and not s.motionUnknown and not s.speedUncertain and not s.speedStep
        and (s.acceleration or 0)==0 and G.finite(s.speed)and s.speed>0 and G.point(s.origin or s.a)and G.point(s.b)
end
-- The policy's `count`-th certain contact (first by default). Returns distance
-- along origin->b, contact time, unit index. `work` (optional table with
-- .remaining) bounds total unit tests across calls.
function B.firstContact(s,policy,units,count,now,casterTeam,options,work)
    policy=B.policy(policy);if not policy or not eligible(s)then return nil,'no_policy_or_unsupported_flight'end
    options=options or B.defaults
    local margin,errorRate=options.margin or B.defaults.margin,options.errorRate or B.defaults.errorRate
    local aliveMargin=options.aliveMargin or B.defaults.aliveMargin
    local o=s.origin or s.a;local length=G.dist(o,s.b);if length<1 then return nil,'degenerate'end
    local dx,dz=(s.b.x-o.x)/length,(s.b.z-o.z)/length
    local v=s.speed;local launch=s.launch or s.starts
    local from=max(now,launch);local arrival=launch+length/v
    if from>=arrival then return nil,'flight_complete'end
    local limit=min(count or #units,options.maxUnits or B.defaults.maxUnits)
    local needed=policy.count or 1;local found=0
    for i=1,limit do
        if work then work.remaining=work.remaining-1;if work.remaining<0 then return nil,'work_budget'end end
        local u=units[i]
        if u and not u.uncertain and policy[u.category]==true and(casterTeam==nil or u.team~=casterTeam)
            and G.finite(u.x)and G.finite(u.z)and G.finite(u.radius)then
            -- Cheap corridor gate in the ray frame using the forecast envelope.
            local ux,uz=u.x-o.x,u.z-o.z
            local along,side=ux*dx+uz*dz,ux*dz-uz*dx
            local vx,vz=u.vx or 0,u.vz or 0
            local reach=(s.radius or 0)+u.radius+sqrt(vx*vx+vz*vz)*(arrival-now)
            if along>=-reach and along<=length+reach and side<=reach and side>=-reach then
                -- Relative motion from t0: rel(tau)=P+V*tau, with projectile
                -- c(t)=o+d*v*(t-launch) and unit p(t)=u+vel*(t-now). The certain
                -- contact radius shrinks linearly: r(tau)=R0-e*tau. Solve
                -- |P+V*tau|^2<=(R0-e*tau)^2 with r>=0 exactly (one quadratic).
                local t0=from
                local px=u.x+vx*(t0-now)-(o.x+dx*v*(t0-launch))
                local pz=u.z+vz*(t0-now)-(o.z+dz*v*(t0-launch))
                local rx,rz=vx-dx*v,vz-dz*v
                local e=u.errorRate or errorRate -- a moving unit carries its own speed as the bound
                local R0=(s.radius or 0)+u.radius-margin-e*(t0-now)
                local last=arrival-t0
                if e>0 then last=min(last,R0/e)end
                local hit
                if R0>0 and last>=0 then
                    local aa=rx*rx+rz*rz-e*e;local bb=2*(px*rx+pz*rz+R0*e);local cc=px*px+pz*pz-R0*R0
                    if cc<=0 then hit=0
                    elseif aa>1e-9 then
                        local disc=bb*bb-4*aa*cc
                        if disc>=0 then
                            local root=sqrt(disc);local enter,leave=(-bb-root)/(2*aa),(-bb+root)/(2*aa)
                            if leave>=0 and enter<=last then hit=max(0,enter)end
                        end
                    end -- A non-positive leading term (unit outrunning the error bound) never clips.
                end
                if hit then
                    local at=t0+hit
                    if (u.aliveUntil==nil or u.aliveUntil>=at+aliveMargin)and(found<needed or at<hitAt[found])then
                        -- Insert into the `needed` earliest contacts (insertion sort, N<=8).
                        local slot=found<needed and found+1 or found
                        while slot>1 and hitAt[slot-1]>at do
                            hitAt[slot],hitDistance[slot],hitIndex[slot]=hitAt[slot-1],hitDistance[slot-1],hitIndex[slot-1]
                            slot=slot-1
                        end
                        hitAt[slot],hitDistance[slot],hitIndex[slot]=at,min(length,v*(at-launch)),i
                        if found<needed then found=found+1 end
                    end
                end
            end
        end
    end
    if found<needed then return nil,'no_certain_blocker'end
    return hitDistance[needed],hitAt[needed],hitIndex[needed]
end
-- Every place where a flight MAY stop on a unit of the policy's classes (evade.impacts):
-- certain or not, about to die or not (`uncertain` rows count here). Each unit gives an
-- interval [from,to] of distance along origin->b that holds the flight's centre at contact:
-- the unit may walk toward the line at its own speed (`errorRate`, else the default) until
-- the flight reaches it, which bounds |x| <= (R0+e*tau0)/(1-e/v) with tau0 the flight's
-- latest time to the unit's own distance and v its slowest speed (or, when e>=v, the whole
-- remaining flight). Written into the caller's reused `from`/`to` arrays sorted by `from`;
-- beyond `limit` intervals the last one is widened to cover the rest. Returns the count.
-- Intervals past the flight's (clipped) end are dropped; `to` is capped at it.
function B.possibleStops(s,policy,units,count,now,casterTeam,options,work,from,to,limit)
    policy=B.policy(policy)
    if not policy or s.shape~='missile'or s.motion or s.motionUnknown or not G.point(s.origin or s.a)or not G.point(s.b)then return 0 end
    options=options or B.defaults
    local errorRate,margin=options.errorRate or B.defaults.errorRate,options.margin or B.defaults.margin
    local o=s.origin or s.a;local length=G.dist(o,s.b);if length<1 then return 0 end
    local dx,dz=(s.b.x-o.x)/length,(s.b.z-o.z)/length
    local launch=s.launch or s.starts
    local _,flight=G.travelTimeBounds(s,length)
    if not G.finite(flight)then return 0 end
    local slowest=s.speedUncertain and s.minSpeed or math.min(s.speed or 0,s.minSpeed or s.speed or 0)
    if (s.acceleration or 0)<0 and not s.minSpeed then slowest=0 end
    local remaining=max(0,launch+flight-now)
    local found=0
    for i=1,min(count or #units,options.maxUnits or B.defaults.maxUnits)do
        if work then work.remaining=work.remaining-1;if work.remaining<0 then break end end
        local u=units[i]
        if u and policy[u.category]==true and(casterTeam==nil or u.team~=casterTeam)
            and G.finite(u.x)and G.finite(u.z)and G.finite(u.radius)then
            local ux,uz=u.x-o.x,u.z-o.z
            local along,side=ux*dx+uz*dz,ux*dz-uz*dx
            local e=u.errorRate or errorRate
            local R0=(s.radius or 0)+u.radius+margin
            local reach
            if slowest>e then
                local _,latest=G.travelTimeBounds(s,max(0,min(length,along)))
                reach=(R0+e*max(0,launch+(latest or flight)-now))/(1-e/slowest)
            else reach=R0+e*remaining end
            local lo,hi=max(0,along-reach),min(length,along+reach)
            if side<=reach and side>=-reach and lo<=hi then
                local slot=found+1
                if found>=limit then slot=limit;lo=min(lo,from[limit]);hi=max(hi,to[limit])
                else found=found+1 end
                while slot>1 and from[slot-1]>lo do
                    from[slot],to[slot]=from[slot-1],to[slot-1];slot=slot-1
                end
                from[slot],to[slot]=lo,hi
            end
        end
    end
    return found
end
-- Copy of the threat ending at the predicted blocker. The contour origin and
-- ray stay identical, so drawing and planning share one shortened capsule.
-- The full flight is retained as `unblockedB` for diagnostics and restoration.
-- `count` (default 1) is the policy's stopping unit, recorded as `blockedCount`.
function B.clip(s,distance,at,blocker,count)
    local o=s.origin or s.a;local length=G.dist(o,s.b)
    if not G.finite(distance)or distance<0 or distance>=length then return s end
    local u=distance/length
    local out={}
    for k,v in pairs(s)do out[k]=v end
    out.b={x=o.x+(s.b.x-o.x)*u,y=s.b.y or 0,z=o.z+(s.b.z-o.z)*u}
    out.unblockedB=s.unblockedB or s.b;out.blockedAt=at;out.blockedBy=blocker
    count=count or 1
    out.blockedCount=count
    out.endpointSource=count==1 and 'predicted_first_blocker'or 'predicted_nth_blocker'
    -- Retain the effect window after the contact time; never extend the flight.
    local window=max(0,(s.ends or at)-((s.launch or s.starts)+length/s.speed))
    out.ends=min(s.ends,at+window)
    return out
end
return B

end
