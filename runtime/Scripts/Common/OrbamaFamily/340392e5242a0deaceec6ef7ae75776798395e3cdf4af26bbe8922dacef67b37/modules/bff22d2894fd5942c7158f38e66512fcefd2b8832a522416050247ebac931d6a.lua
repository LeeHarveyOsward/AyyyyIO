return function(require)
-- Predicted first blocker for unit-stopping projectiles. Pure: no host calls.
--
-- A threat may only be shortened under an explicit per-ability policy
-- ({minion=bool,monster=bool,champion=bool,source=...}). Missing/unknown policy
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
-- Validate an explicit policy. Returns nil (no clipping) for anything incomplete.
function B.policy(p)
    if type(p)~='table'or type(p.source)~='string'or p.source==''then return nil end
    local any=false
    for key in pairs(categories)do
        local v=p[key];if v~=nil and type(v)~='boolean'then return nil end
        any=any or v==true
    end
    return any and p or nil
end
local function eligible(s)
    return s.shape=='missile'and not s.motion and not s.motionUnknown and not s.speedUncertain
        and (s.acceleration or 0)==0 and G.finite(s.speed)and s.speed>0 and G.point(s.origin or s.a)and G.point(s.b)
end
-- First certain contact. Returns distance along origin->b, contact time, unit index.
-- `work` (optional table with .remaining) bounds total unit tests across calls.
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
    local best,bestAt,bestIndex
    for i=1,limit do
        if work then work.remaining=work.remaining-1;if work.remaining<0 then return nil,'work_budget'end end
        local u=units[i]
        if u and policy[u.category]==true and(casterTeam==nil or u.team~=casterTeam)
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
                    if (u.aliveUntil==nil or u.aliveUntil>=at+aliveMargin)and(not bestAt or at<bestAt)then
                        best,bestAt,bestIndex=min(length,v*(at-launch)),at,i
                    end
                end
            end
        end
    end
    if not bestAt then return nil,'no_certain_blocker'end
    return best,bestAt,bestIndex
end
-- Copy of the threat ending at the predicted blocker. The contour origin and
-- ray stay identical, so drawing and planning share one shortened capsule.
-- The full flight is retained as `unblockedB` for diagnostics and restoration.
function B.clip(s,distance,at,blocker)
    local o=s.origin or s.a;local length=G.dist(o,s.b)
    if not G.finite(distance)or distance<0 or distance>=length then return s end
    local u=distance/length
    local out={}
    for k,v in pairs(s)do out[k]=v end
    out.b={x=o.x+(s.b.x-o.x)*u,y=s.b.y or 0,z=o.z+(s.b.z-o.z)*u}
    out.unblockedB=s.unblockedB or s.b;out.blockedAt=at;out.blockedBy=blocker
    out.endpointSource='predicted_first_blocker'
    -- Retain the effect window after the contact time; never extend the flight.
    local window=max(0,(s.ends or at)-((s.launch or s.starts)+length/s.speed))
    out.ends=min(s.ends,at+window)
    return out
end
return B

end
