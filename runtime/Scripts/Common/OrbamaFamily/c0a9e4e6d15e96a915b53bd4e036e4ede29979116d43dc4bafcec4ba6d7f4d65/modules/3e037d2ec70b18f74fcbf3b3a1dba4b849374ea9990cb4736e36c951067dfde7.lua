return function(require)
-- World x/z, distances in game units, times in seconds. No host calls.
local G={}
local ProjectileMotion=require('CombatProfiles.projectile_motion')
local sqrt,abs,min,max,cos,sin,huge=math.sqrt,math.abs,math.min,math.max,math.cos,math.sin,math.huge
-- Called for every interval, route and sample check: a local function over local upvalues.
local function finite(n)return type(n)=='number' and n==n and abs(n)<huge end
G.finite=finite
-- Scratch route point for distance samples that are consumed at once (G.distance keeps no reference).
local probe={x=0,y=0,z=0}
local function probeAt(a,b,t)probe.x=a.x+(b.x-a.x)*t;probe.y=a.y or 0;probe.z=a.z+(b.z-a.z)*t;return probe end
G.probe=probeAt
function G.point(p)return p and finite(p.x) and finite(p.z) and (p.y==nil or finite(p.y))end
function G.copy(p)return p and {x=p.x,y=p.y or 0,z=p.z}end
function G.dist(a,b)return sqrt((a.x-b.x)^2+(a.z-b.z)^2)end
function G.lerp(a,b,t)return {x=a.x+(b.x-a.x)*t,y=a.y or 0,z=a.z+(b.z-a.z)*t}end
function G.segment(p,a,b)
    local x,z=b.x-a.x,b.z-a.z;local d=x*x+z*z
    local t=d>0 and max(0,min(1,((p.x-a.x)*x+(p.z-a.z)*z)/d)) or 0
    local qx,qz=p.x-(a.x+x*t),p.z-(a.z+z*t)
    return sqrt(qx*qx+qz*qz),t
end
function G.direction(a,b)
    local d=sqrt((a.x-b.x)^2+(a.z-b.z)^2);if d<.00001 then return 1,0 end
    return (b.x-a.x)/d,(b.z-a.z)/d
end
-- A speed step (`s.speedStep={at=units from the origin,speed=later speed}`) splits one
-- constant-speed flight in two constant-speed phases (catalogue `speedStep`).
local function stepTime(s)local step=s.speedStep;return step and step.at/s.speed end
G.stepTime=stepTime
function G.travel(s,dt)
    return ProjectileMotion.Travel(s,dt)
end
function G.travelTime(s,distance)
    return ProjectileMotion.Time(s,distance)
end
function G.travelBounds(s,dt)
    if s.speedUncertain then dt=max(0,dt);return s.minSpeed*dt,s.maxSpeed*dt end
    local distance=G.travel(s,dt);return distance,distance
end
function G.travelTimeBounds(s,distance)
    if s.speedUncertain then distance=max(0,distance);return distance/s.maxSpeed,distance/s.minSpeed end
    local at=G.travelTime(s,distance);return at,at
end
function G.center(s,t)
    if s.speedUncertain then return nil end -- A region of possible centers, not one observed position.
    if s.motion then
        local nodes=s.motion
        for i=2,#nodes do
            if t<=nodes[i].at then
                local a,b=nodes[i-1],nodes[i];return G.lerp(a.pos,b.pos,max(0,min(1,(t-a.at)/(b.at-a.at))))
            end
        end
        return G.copy(nodes[#nodes].pos)
    end
    local origin=s.origin or s.a
    if not origin then return nil end
    local dt=max(0,t-(s.launch or s.starts))
    if s.speed and s.b then
        local length=G.dist(origin,s.b);local distance=max(0,min(length,G.travel(s,dt)))
        return G.lerp(origin,s.b,length>0 and distance/length or 0)
    end
    return origin
end
local function angle(x,z)return math.atan2 and math.atan2(z,x) or math.atan(z/x)end
local function delta(a,b)return (a-b+math.pi)%(2*math.pi)-math.pi end
-- A transition describes the damage radius; s.radius remains its maximum
-- spatial/display envelope. Times are absolute seconds, not cast-relative.
function G.radiusAt(s,t)
    local r=s.radiusTransition
    if not r then return s.radius end
    local u=max(0,min(1,(t-r.starts)/(r.ends-r.starts)))
    return r.initial+(r.final-r.initial)*u
end
function G.distance(s,p,t)
    if s.motionUnknown then return nil end
    if s.speedUncertain then
        local origin=s.origin or s.a;local length=G.dist(origin,s.b)
        if length==0 then return G.dist(origin,p)-s.radius end
        local dt=max(0,t-(s.launch or s.starts))
        local rear=min(length,s.minSpeed*dt);local front=min(length,s.maxSpeed*dt)
        local dx,dz=(s.b.x-origin.x)/length,(s.b.z-origin.z)/length
        local x,z=p.x-origin.x,p.z-origin.z
        local along,side=x*dx+z*dz,x*dz-z*dx
        local gap=max(rear-along,along-front,0)
        return sqrt(gap*gap+side*side)-s.radius
    end
    local kind=s.shape;local a=G.center(s,t)
    if kind=='compound' then
        local d=math.huge
        for _,part in ipairs(s.parts or {})do
            if t>=part.starts and (part.motionUnknown or t<=part.ends)then
                local x=G.distance(part,p,t);if not x then return nil end;d=min(d,x)
            end
        end
        return d
    end
    if not a then return nil end
    local radius=s.radius or 0
    if s.radiusTransition then radius=G.radiusAt(s,t)end
    if kind=='circle' or kind=='missile' then return G.dist(a,p)-radius end
    if kind=='line' then return s.b and G.segment(p,a,s.b)-radius end
    if kind=='ring' then local d=G.dist(a,p);return max((s.innerRadius or 0)-d,d-radius)end
    local b=s.b;if not b then return nil end
    local dx,dz=G.direction(a,b);local x,z=p.x-a.x,p.z-a.z
    local forward,side=x*dx+z*dz,abs(x*dz-z*dx)
    if kind=='rectangle' then
        local length=s.length or G.dist(a,b);local qx,qz=abs(forward-length/2)-length/2,side-radius
        return sqrt(max(qx,0)^2+max(qz,0)^2)+min(max(qx,qz),0)
    end
    if kind=='cone' then
        local half=s.halfAngle;if not half then return nil end
        local length=s.length or G.dist(a,b)
        local inner=0
        if s.emissionSpeed then
            length=min(length,max(0,(t-s.emissionStart)*s.emissionSpeed))
            inner=max(0,(t-s.emissionEnd)*s.emissionSpeed)
        end
        local c,si=cos(half),sin(half)
  -- Reflect onto the positive side of the axis. Of the symmetric radial
  -- edges, that side is always at least as close; no endpoint tables needed.
  local projection=max(0,min(length,forward*c+side*si))
  local qx,qz=forward-projection*c,side-projection*si
  local radial=sqrt(x*x+z*z);local inside=radial<=length and forward>=radial*c
  local d=sqrt(qx*qx+qz*qz)
        if forward>=radial*c then d=min(d,abs(radial-length))end
        d=inside and -d or d
        if s.emissionSpeed then
            -- Maximum of Lipschitz lower distances to the cone and radial
            -- tail is a conservative distance to their intersection. No grid.
            return max(d,inner-radial)-radius
        end
        return d
    end
    if kind=='arc' then
        if not s.arcRadius or not s.halfAngle then return nil end
        local theta=angle(x,z);local axis=angle(dx,dz);local offset=delta(theta,axis)
        local theta2=axis+max(-s.halfAngle,min(s.halfAngle,offset))
  local qx,qz=x-math.cos(theta2)*s.arcRadius,z-math.sin(theta2)*s.arcRadius
  return sqrt(qx*qx+qz*qz)-radius
    end
    return nil
end
local shapes={circle=true,missile=true,line=true,rectangle=true,cone=true,ring=true,arc=true}
function G.valid(s)
    if type(s)~='table' or not finite(s.starts) or not finite(s.ends) or s.ends<s.starts then return false,'invalid_time' end
    if s.radiusTransition~=nil then
        local r=s.radiusTransition
        if type(r)~='table'or s.shape~='circle'or s.speed or s.acceleration
            or not finite(r.initial)or r.initial<0 or not finite(r.final)or r.final<0
            or not finite(r.starts)or not finite(r.ends)or r.ends<=r.starts
            or not finite(r.ends-r.starts)or s.radius~=max(r.initial,r.final)
            or not finite((r.final-r.initial)/(r.ends-r.starts))then
            return false,'invalid_radius_transition'
        end
    end
    if s.speedStep~=nil then
        local step=s.speedStep
        if type(step)~='table'or s.shape~='missile'or s.motion or s.speedUncertain or(s.acceleration or 0)~=0
            or not finite(s.speed)or s.speed<=0 or not finite(step.at)or step.at<0 or not finite(step.speed)or step.speed<=0 then
            return false,'invalid_speed_step'
        end
    end
    if s.contactPossible~=nil and(s.contactPossible~=true or s.shape~='circle'or not s.radiusTransition)then
        return false,'invalid_possible_contact'
    end
    if s.potentialDamage~=nil then
        if s.potentialDamage~=true or s.emissionSpeed==nil or not s.persistent
        or s.damage~=nil or s.repeatInterval~=nil then return false,'invalid_potential_emissions'end
    end
    if s.emissionSpeed~=nil or s.emissionStart~=nil or s.emissionEnd~=nil then
        if s.shape~='cone'or s.motion or s.speed or not finite(s.length)or s.length<=0
            or not finite(s.halfAngle)or s.halfAngle<=0 or s.halfAngle>=math.pi/2
            or not finite(s.emissionSpeed)or s.emissionSpeed<=0
            or not finite(s.emissionStart)or not finite(s.emissionEnd)
            or s.emissionEnd<s.emissionStart or s.starts~=s.emissionStart
            or math.abs(s.ends-(s.emissionEnd+s.length/s.emissionSpeed))>1e-6 then
            return false,'invalid_emission_envelope'
        end
    end
    if s.speedUncertain~=nil then
        local origin=s.origin or s.a;local launch=s.launch or s.starts
        if s.speedUncertain~=true or s.shape~='missile' or s.motion or s.motionUnknown
            or s.acceleration~=nil or not G.point(origin)or not G.point(s.b)
            or not finite(s.minSpeed)or not finite(s.maxSpeed)
            or s.minSpeed<=0 or s.maxSpeed<s.minSpeed or not finite(launch)
            or s.starts<launch
            or s.ends>launch+G.dist(origin,s.b)/s.minSpeed+1e-6
            or s.persistent or s.repeatInterval or s.potentialDamage then
            return false,'invalid_speed_envelope'
        end
    end
    if s.shape=='targeted' then
        if s.impactLatest~=nil and (not finite(s.impactLatest)or s.impactLatest<s.starts or s.impactLatest>s.ends)then
            return false,'invalid_impact_interval'
        end
        return s.targetID~=nil,'missing_target'
    end
    if s.shape=='compound' then
        if type(s.parts)~='table' or #s.parts==0 or #s.parts>16 then return false,'invalid_parts'end
        for _,p in ipairs(s.parts)do if p.shape=='compound' or p.shape=='targeted' or not G.valid(p)then return false,'invalid_part'end end
        return true
    end
    if not G.point(s.origin or s.a) then return false,'invalid_origin'end
       if not shapes[s.shape] then return false,'unknown_shape'end
    if s.motionUnknown and s.shape~='missile'then return false,'invalid_uncertain_motion'end
    if not finite(s.radius) or s.radius<0 then return false,'invalid_radius'end
    if s.shape~='circle' and s.shape~='ring' and not G.point(s.b) then return false,'invalid_endpoint'end
    if (s.shape=='cone'or s.shape=='rectangle')and s.length~=nil
  and (not finite(s.length)or s.length<0)then return false,'invalid_length'end
 if s.shape=='cone' or s.shape=='arc' then
        if not finite(s.halfAngle) or s.halfAngle<=0 or s.halfAngle>math.pi then return false,'invalid_angle'end
    end
    if s.shape=='arc' and (not finite(s.arcRadius) or s.arcRadius<0)then return false,'invalid_arc'end
    if s.shape=='ring' and (not finite(s.innerRadius) or s.innerRadius<0 or s.innerRadius>s.radius)then return false,'invalid_ring'end
    if s.speed~=nil and (not finite(s.speed) or s.speed<0)then return false,'invalid_speed'end
    if s.acceleration~=nil and not finite(s.acceleration) then return false,'invalid_acceleration'end
    if s.minSpeed~=nil and (not finite(s.minSpeed)or s.minSpeed<0)then return false,'invalid_min_speed'end
    if s.maxSpeed~=nil and (not finite(s.maxSpeed)or s.maxSpeed<(s.minSpeed or 0))then return false,'invalid_max_speed'end
    if s.speed and (s.minSpeed and s.speed<s.minSpeed or s.maxSpeed and s.speed>s.maxSpeed)then return false,'speed_outside_bounds'end
    if s.launch~=nil and not finite(s.launch)then return false,'invalid_launch'end
    if s.motion then
        if #s.motion<2 or #s.motion>32 then return false,'invalid_motion'end
        for i,n in ipairs(s.motion)do
            if not G.point(n.pos) or not finite(n.at) or i>1 and n.at<=s.motion[i-1].at then return false,'invalid_motion'end
        end
    end
    return true
end
function G.uncertainMotion(s)
    if s.motionUnknown then return true end
    if s.shape~='compound'then return false end
    for _,part in ipairs(s.parts)do if part.motionUnknown then return true end end
    return false
end
function G.motionBound(s)
    local growth=s.radiusTransition and abs(s.radiusTransition.final-s.radiusTransition.initial)/(s.radiusTransition.ends-s.radiusTransition.starts)or 0
    if s.speedUncertain then return s.maxSpeed end
    if s.motionUnknown then return nil end
    if s.emissionSpeed then return s.emissionSpeed end
    local v=(s.speed or 0)+abs(s.acceleration or 0)*max(0,s.ends-(s.launch or s.starts))
    if s.maxSpeed then v=min(v,s.maxSpeed)end
    if s.speedStep then v=max(v,s.speedStep.speed)end
    for i=2,#(s.motion or {})do local a,b=s.motion[i-1],s.motion[i];v=max(v,G.dist(a.pos,b.pos)/(b.at-a.at))end
    v=v+growth
    for _,part in ipairs(s.parts or {})do local bound=G.motionBound(part);if not bound then return nil end;v=max(v,bound)end
    -- Moving directional primitives can change their orientation. Only fixed
    -- directional shapes and translated circular primitives have this bound.
    if (s.motion or s.speed and s.speed>0) and s.shape~='circle' and s.shape~='missile' and s.shape~='ring' then return nil end
    return v
end
-- Conservative continuous collision. A Lipschitz bound rejects entire time
-- intervals, so a fast missile cannot slip between sampled positions.
local function circleInterval(s,a,b,t0,t1,l,h,radius,budget)
        budget.remaining=budget.remaining-1;if budget.remaining<0 then return nil,'geometry_budget'end
        local cx,cz,dx,dz
        if not s.motion and s.speed and s.b then
            -- The same immutable ray is used at both interval endpoints. Share
            -- its length locally; no live state or cross-query result is cached.
            local origin=s.origin or s.a;local length=G.dist(origin,s.b)
            local launch=s.launch or s.starts
            local first=max(0,min(length,G.travel(s,max(0,l-launch))))
            local last=max(0,min(length,G.travel(s,max(0,h-launch))))
            local u=length>0 and first/length or 0;local v=length>0 and last/length or 0
            cx,cz=origin.x+(s.b.x-origin.x)*u,origin.z+(s.b.z-origin.z)*u
            dx,dz=origin.x+(s.b.x-origin.x)*v,origin.z+(s.b.z-origin.z)*v
        else
            local c,d=G.center(s,l),G.center(s,h);cx,cz,dx,dz=c.x,c.z,d.x,d.z
        end
        local duration=t1-t0
        local u=duration>0 and (l-t0)/duration or 0;local v=duration>0 and (h-t0)/duration or 0
        local x,z=a.x+(b.x-a.x)*u-cx,a.z+(b.z-a.z)*u-cz
        local vx,vz=(b.x-a.x)*(v-u)-(dx-cx),(b.z-a.z)*(v-u)-(dz-cz)
        local r=s.radius+radius+.001;local cc=x*x+z*z-r*r
        local aa=vx*vx+vz*vz;if aa<1e-20 then if cc<=0 then return true,l,h end;return false end
        local bb=2*(x*vx+z*vz);local discriminant=bb*bb-4*aa*cc
        if discriminant<0 then return false end
        local root=sqrt(discriminant)
        local enter,leave=(-bb-root)/(2*aa),(-bb+root)/(2*aa)
        if leave>=0 and enter<=1 then return true,l+(h-l)*max(0,enter),l+(h-l)*min(1,leave)end
        return false
end
-- A stationary line is a capsule. Its intersection with a linear route is
-- convex: the rectangle and two endpoint disks yield one occupied interval.
-- All calculations use the route clipped to the threat's active time window.
local function staticLine(s)
    return s.shape=='line'and not s.motion and
        (s.speed==nil or s.speed==0 and (s.acceleration or 0)==0)
end
local function diskSpan(x,z,vx,vz,r)
    local aa=vx*vx+vz*vz
    if aa==0 then if x*x+z*z<=r*r then return 0,1 end;return end
    local cross=x*vz-z*vx
    local remaining=r*r-cross*cross/aa
    if remaining<0 then return end
    local mid=-(x*vx+z*vz)/aa;local half=sqrt(remaining/aa)
    local first,last=max(0,mid-half),min(1,mid+half)
    if first<=last then return first,last end
end
local function slabSpan(x,v,lower,upper,first,last)
    if v==0 then if x<lower or x>upper then return end;return first,last end
    local a,b=(lower-x)/v,(upper-x)/v
    if a>b then a,b=b,a end
    first,last=max(first,a),min(last,b)
    if first<=last then return first,last end
end
local function capsuleInterval(s,a,b,t0,t1,lo,hi,radius,budget)
    budget.remaining=budget.remaining-1
    if budget.remaining<0 then return nil,'geometry_budget'end
    local origin=s.origin or s.a
    local dx,dz=s.b.x-origin.x,s.b.z-origin.z
    local length=sqrt(dx*dx+dz*dz)
    local duration=t1-t0
    local u=duration>0 and (lo-t0)/duration or 0
    local span=duration>0 and (hi-lo)/duration or 0
    local x,z=a.x+(b.x-a.x)*u-origin.x,a.z+(b.z-a.z)*u-origin.z
    local vx,vz=(b.x-a.x)*span,(b.z-a.z)*span
    local r=s.radius+radius+.001
    if length==0 then
        local first,last=diskSpan(x,z,vx,vz,r)
        if first then return true,lo+(hi-lo)*first,lo+(hi-lo)*last end
        return false
    end
    dx,dz=dx/length,dz/length
    local forward,side=x*dx+z*dz,x*dz-z*dx
    local along,across=vx*dx+vz*dz,vx*dz-vz*dx
    local first,last=slabSpan(forward,along,0,length,0,1)
    if first then first,last=slabSpan(side,across,-r,r,first,last)end
    local f,l=diskSpan(forward,side,along,across,r)
    if f then first,last=min(first or f,f),max(last or l,l)end
    f,l=diskSpan(forward-length,side,along,across,r)
    if f then first,last=min(first or f,f),max(last or l,l)end
    if first then return true,lo+(hi-lo)*first,lo+(hi-lo)*last end
    return false
end
local function staticRectangle(s)
    return s.shape=='rectangle'and not s.motion and
        (s.speed==nil or s.speed==0 and (s.acceleration or 0)==0)
end
local function rectangleSpan(x,z,vx,vz,left,right,bottom,top)
    local first,last=slabSpan(x,vx,left,right,0,1)
    if first then return slabSpan(z,vz,bottom,top,first,last)end
end
-- Disk clearance expands a rectangle into two strips and four round corners.
-- Do not replace the round corners with an enlarged axis-aligned rectangle.
local function rectangleInterval(s,a,b,t0,t1,lo,hi,radius,budget)
    budget.remaining=budget.remaining-1
    if budget.remaining<0 then return nil,'geometry_budget'end
    local origin=s.origin or s.a;local dx,dz=G.direction(origin,s.b)
    local length=s.length or G.dist(origin,s.b)
    local duration=t1-t0
    local u=duration>0 and (lo-t0)/duration or 0
    local span=duration>0 and (hi-lo)/duration or 0
    local x,z=a.x+(b.x-a.x)*u-origin.x,a.z+(b.z-a.z)*u-origin.z
    local vx,vz=(b.x-a.x)*span,(b.z-a.z)*span
    local forward,side=x*dx+z*dz,x*dz-z*dx
    local along,across=vx*dx+vz*dz,vx*dz-vz*dx
    local r,width=radius+.001,s.radius
    local first,last=rectangleSpan(forward,side,along,across,-r,length+r,-width,width)
    local f,l=rectangleSpan(forward,side,along,across,0,length,-width-r,width+r)
    if f then first,last=min(first or f,f),max(last or l,l)end
    f,l=diskSpan(forward,side-width,along,across,r)
    if f then first,last=min(first or f,f),max(last or l,l)end
    f,l=diskSpan(forward,side+width,along,across,r)
    if f then first,last=min(first or f,f),max(last or l,l)end
    f,l=diskSpan(forward-length,side-width,along,across,r)
    if f then first,last=min(first or f,f),max(last or l,l)end
    f,l=diskSpan(forward-length,side+width,along,across,r)
    if f then first,last=min(first or f,f),max(last or l,l)end
    if first then return true,lo+(hi-lo)*first,lo+(hi-lo)*last end
    return false
end
local function linearCircle(s,a,b,t0,t1,lo,hi,radius,budget)
    -- Fixed-speed missiles stop at their endpoint. Splitting there keeps each
    -- relative-motion interval linear; it must not extrapolate past that point.
    local launch=s.launch or s.starts
    local arrival=s.speed and s.speed>0 and s.b and launch+G.travelTime(s,G.dist(s.origin or s.a,s.b))
    -- A speed step is a third breakpoint: each phase is linear on its own.
    local step=s.speedStep and arrival and launch+stepTime(s)
    local from=lo
    if launch>from and launch<hi then local hit,at=circleInterval(s,a,b,t0,t1,from,launch,radius,budget);if hit~=false then return hit,at end;from=launch end
    if step and step>from and step<hi and step<arrival then local hit,at=circleInterval(s,a,b,t0,t1,from,step,radius,budget);if hit~=false then return hit,at end;from=step end
    if arrival and arrival>from and arrival<hi then local hit,at=circleInterval(s,a,b,t0,t1,from,arrival,radius,budget);if hit~=false then return hit,at end;from=arrival end
    return circleInterval(s,a,b,t0,t1,from,hi,radius,budget)
end
-- Explicit motion nodes define constant velocity between successive times.
-- Split at each node, including stationary intervals before/after the track.
local function motionIntervals(s,lo,hi,visit)
local from=lo
for _,node in ipairs(s.motion)do
if node.at>from and node.at<hi then
if not visit(from,node.at)then return false end
from=node.at
end
end
return visit(from,hi)
end
-- On each constant-acceleration interval the relative route is a quadratic
-- Bezier curve. Its control hull and chord-deviation bound enclose every point.
-- Rejection therefore tests the entire interval, not sparse path samples.
local function acceleratedIntervals(s,a,b,t0,t1,lo,hi,radius,budget,add,firstOnly)
    local total=t1-t0;local first,reason
    local r=s.radius+radius+.001;local rr=r*r
    if not finite(rr)then return false,'geometry_numeric'end
    local function emit(l,h)
        first=first or l;if add then add(l,h)end
    end
    local function visit(x0,z0,x1,z1,x2,z2,l,h,depth)
        budget.remaining=budget.remaining-1
        if budget.remaining<0 then reason='geometry_budget';return false end
        if firstOnly and x0*x0+z0*z0<=rr then emit(l,l);return true end
        local minX,maxX=min(x0,x1,x2),max(x0,x1,x2)
        local minZ,maxZ=min(z0,z1,z2),max(z0,z1,z2)
        local nearX,nearZ=max(minX,0,-maxX),max(minZ,0,-maxZ)
        if nearX*nearX+nearZ*nearZ>rr then return true end
        local dx,dz=x2-x0,z2-z0;local dd=dx*dx+dz*dz
        local u=dd>0 and max(0,min(1,-(x0*dx+z0*dz)/dd))or 0
        local cx,cz=x0+u*dx,z0+u*dz
        local bx,bz=x1-(x0+x2)*.5,z1-(z0+z2)*.5
        local bow=.5*sqrt(bx*bx+bz*bz)
        if not finite(dd)or not finite(bow)then reason='geometry_numeric';return false end
        if cx*cx+cz*cz>(r+bow)*(r+bow)then return true end
        if max(x0*x0+z0*z0,x1*x1+z1*z1,x2*x2+z2*z2)<=rr
            or depth>=14 or h-l<=.001 then emit(l,h);return true end
        local ax,az=(x0+x1)*.5,(z0+z1)*.5
        local bx,bz=(x1+x2)*.5,(z1+z2)*.5
        local mx,mz=(ax+bx)*.5,(az+bz)*.5;local mid=(l+h)*.5
        if not visit(x0,z0,ax,az,mx,mz,l,mid,depth+1)then return false end
        if firstOnly and first then return true end
        return visit(mx,mz,bx,bz,x2,z2,mid,h,depth+1)
    end
    local launch=s.launch or s.starts;local acceleration=s.acceleration
    local limit=acceleration>0 and (s.maxSpeed or math.huge)or (s.minSpeed or 0)
    local cap=launch+max(0,(limit-s.speed)/acceleration)
    local arrival=launch+G.travelTime(s,G.dist(s.origin or s.a,s.b))
    local from=lo
    for piece=1,4 do
        local finish=hi
        if launch>from then finish=min(finish,launch)end
        if cap>from then finish=min(finish,cap)end
        if arrival>from then finish=min(finish,arrival)end
        if finish<=launch or from>=cap or from>=arrival then
            local hit,l,h=circleInterval(s,a,b,t0,t1,from,finish,radius,budget)
            if hit==nil then return false,l end
            if hit then emit(l,h)end
        else
            local c,m,d=G.center(s,from),G.center(s,(from+finish)*.5),G.center(s,finish)
            local u=total>0 and (from-t0)/total or 0
            local v=total>0 and (finish-t0)/total or 0
            local x0,z0=a.x+(b.x-a.x)*u-c.x,a.z+(b.z-a.z)*u-c.z
            local x2,z2=a.x+(b.x-a.x)*v-d.x,a.z+(b.z-a.z)*v-d.z
            local xm,zm=a.x+(b.x-a.x)*(u+v)*.5-m.x,a.z+(b.z-a.z)*(u+v)*.5-m.z
            local x1,z1=2*xm-(x0+x2)*.5,2*zm-(z0+z2)*.5
            if not finite(x0)or not finite(z0)or not finite(x1)or not finite(z1)
                or not finite(x2)or not finite(z2)then return false,'geometry_numeric'end
            if not visit(x0,z0,x1,z1,x2,z2,from,finish,0)then return false,reason end
        end
        if firstOnly and first then return true,nil,first end
        if finish>=hi then return true,nil,first end
        from=finish
    end
    return false,'geometry_piece_budget'
end
-- A straight bounded-speed projectile occupies an expanding capsule at each
-- instant. Clip the route against its lateral strip and its two moving end disks.
-- The front stops at the range endpoint; the last possible arrival ends the model.
-- No time samples or predicted single center are used to establish clearance.
local function positiveSpan(x,v,first,last)
    if v==0 then if x<0 then return end;return first,last end
    local at=-x/v
    if v>0 then first=max(first,at)else last=min(last,at)end
    if first<=last then return first,last end
end
local function speedEnvelopeIntervals(s,a,b,t0,t1,lo,hi,radius,budget,emit,firstOnly)
    local origin=s.origin or s.a;local length=G.dist(origin,s.b)
    if length==0 then
        budget.remaining=budget.remaining-1
        if budget.remaining<0 then return false,'geometry_budget'end
        local at=s.launch or s.starts
        if at<lo or at>hi then return true end
        local position=G.lerp(a,b,t1>t0 and(at-t0)/(t1-t0)or 0)
        if G.dist(position,origin)<=s.radius+radius+.001 then
            if emit then emit(at,at)end
            return true,nil,at
        end
        return true
    end
    local dx,dz=(s.b.x-origin.x)/length,(s.b.z-origin.z)/length
    local launch=s.launch or s.starts;local arrival=launch+length/s.maxSpeed
    local latest=launch+length/s.minSpeed;hi=min(hi,latest)
    if hi<lo then return true end
    local duration=t1-t0;local r=s.radius+radius+.001
    local from=lo
    for piece=1,2 do
        budget.remaining=budget.remaining-1
        if budget.remaining<0 then return false,'geometry_budget'end
        local finish=arrival>from and arrival<hi and arrival or hi
        local u=duration>0 and(from-t0)/duration or 0
        local v=duration>0 and(finish-t0)/duration or 0
        local px,pz=a.x+(b.x-a.x)*u-origin.x,a.z+(b.z-a.z)*u-origin.z
        local qx,qz=(b.x-a.x)*(v-u),(b.z-a.z)*(v-u)
        local x,z=px*dx+pz*dz,px*dz-pz*dx
        local vx,vz=qx*dx+qz*dz,qx*dz-qz*dx
        local rear=min(length,s.minSpeed*max(0,from-launch))
        local front=min(length,s.maxSpeed*max(0,from-launch))
        local vr=min(length,s.minSpeed*max(0,finish-launch))-rear
        local vf=min(length,s.maxSpeed*max(0,finish-launch))-front
        if not finite(x)or not finite(z)or not finite(vx)or not finite(vz)
            or not finite(rear)or not finite(front)or not finite(vr)or not finite(vf)then
            return false,'geometry_numeric'
        end
        local first,last=diskSpan(x-rear,z,vx-vr,vz,r)
        local f,l=diskSpan(x-front,z,vx-vf,vz,r)
        if f then first=min(first or f,f);last=max(last or l,l)end
        f,l=slabSpan(z,vz,-r,r,0,1)
        if f then f,l=positiveSpan(x-rear,vx-vr,f,l)end
        if f then f,l=positiveSpan(front-x,vf-vx,f,l)end
        if f then first=min(first or f,f);last=max(last or l,l)end
        if first then
            local enter,leave=from+(finish-from)*first,from+(finish-from)*last
            if emit then emit(enter,leave)end
            if firstOnly then return true,nil,enter end
        end
        if finish>=hi then return true end
        from=finish
    end
    return false,'geometry_piece_budget'
end
function G.possibleMotion(s)
    if s.speedUncertain or s.contactPossible then return true end
    if s.shape=='compound'then
        for _,part in ipairs(s.parts)do if part.speedUncertain or part.contactPossible then return true end end
    end
    return false
end
-- On each radius piece, squared distance minus squared radius is quadratic.
-- Analytic roots and convexity delimit the complete occupied interval. No
-- temporal samples, temporary arrays or per-piece callback closures are needed.
local function radiusMotion(nodes,count,index,from,finish)
    if index==1 then return nodes[1].pos.x,nodes[1].pos.z,0,0 end
    if index>count then return nodes[count].pos.x,nodes[count].pos.z,0,0 end
    local left,right=nodes[index-1],nodes[index]
    local dt=right.at-left.at;local ratio=(from-left.at)/dt
    local dx,dz=right.pos.x-left.pos.x,right.pos.z-left.pos.z
    local step=(finish-from)/dt
    return left.pos.x+dx*ratio,left.pos.z+dz*ratio,dx*step,dz*step
end
local function radiusIntervals(s,a,b,t0,t1,lo,hi,padding,budget,emit,firstOnly)
    local r=s.radiusTransition;local from=lo;local first
    local nodes=s.motion;local count=nodes and #nodes or 0;local index=1
    -- One forward cursor visits each motion breakpoint at most once. Include
    -- clamped spans before/after the motion plus the two radius breakpoints.
    if nodes then while index<=count and nodes[index].at<=from do index=index+1 end end
    for piece=1,count+3 do
        local finish=hi
        if r.starts>from and r.starts<finish then finish=r.starts end
        if r.ends>from and r.ends<finish then finish=r.ends end
        if nodes and index<=count and nodes[index].at<finish then finish=nodes[index].at end
        budget.remaining=budget.remaining-1
        if budget.remaining<0 then return false,'geometry_budget'end
        local duration=t1-t0
        local u=duration>0 and (from-t0)/duration or 0
        local span=duration>0 and (finish-from)/duration or 0
        local x,z=a.x+(b.x-a.x)*u,a.z+(b.z-a.z)*u
        local vx,vz=(b.x-a.x)*span,(b.z-a.z)*span
        if nodes then
            local cx,cz,mx,mz=radiusMotion(nodes,count,index,from,finish)
            x,z=x-cx,z-cz;vx,vz=vx-mx,vz-mz
        else
            local origin=s.origin or s.a;x,z=x-origin.x,z-origin.z
        end
        local rad=G.radiusAt(s,from)+padding+.001
        local dr=G.radiusAt(s,finish)-G.radiusAt(s,from)
        local aa=vx*vx+vz*vz-dr*dr
        local bb=2*(x*vx+z*vz-rad*dr)
        local cc=x*x+z*z-rad*rad
        if not finite(aa)or not finite(bb)or not finite(cc)then return false,'geometry_numeric'end
        local scale=max(abs(aa),abs(bb),abs(cc),1);aa,bb,cc=aa/scale,bb/scale,cc/scale
        local left,right
        if aa==0 then
            if bb~=0 then left=-cc/bb end
        else
            local discriminant=bb*bb-4*aa*cc
            if discriminant>=-1e-14 then
                local root=sqrt(max(0,discriminant))
                local q=-.5*(bb+(bb>=0 and root or -root))
                if q==0 then left=0 else left,right=q/aa,cc/q end
                if right and right<left then left,right=right,left end
            end
        end
        -- Distance along a linear route is convex; subtracting a nonnegative
        -- affine radius preserves a convex sublevel set. Qualifying endpoints
        -- and analytic roots therefore delimit one interval, never two islands.
        local enter,leave
        if cc<=0 then enter,leave=0,0 end
        if aa+bb+cc<=0 then enter,leave=enter or 1,1 end
        if left and left>=0 and left<=1 then enter=min(enter or left,left);leave=max(leave or left,left)end
        if right and right>=0 and right<=1 then enter=min(enter or right,right);leave=max(leave or right,right)end
        if enter then
            local at,untilTime=from+(finish-from)*enter,from+(finish-from)*leave
            first=first or at;if emit then emit(at,untilTime)end
        end
        if firstOnly and first then return true,nil,first end
        if finish>=hi then return true,nil,first end
        from=finish
        if nodes then while index<=count and nodes[index].at<=from do index=index+1 end end
    end
    return false,'geometry_piece_budget'
end
function G.sweep(s,a,b,t0,t1,radius,budget,clipLo,clipHi)
    -- `finite` inlined: this entry runs once per threat per route segment (about half a million times in the
    -- ten-champion stress scenario).
    if not(type(t0)=='number'and t0==t0 and abs(t0)<huge)or not(type(t1)=='number'and t1==t1 and abs(t1)<huge)or t1<t0
        or not(type(radius)=='number'and radius==radius and abs(radius)<huge)or radius<0 then return nil,'invalid_interval'end
    local lo,hi=max(t0,s.starts),(s.motionUnknown or s.shape=='compound'and G.uncertainMotion(s))and t1 or min(t1,s.ends)
    lo=max(lo,clipLo or lo);hi=min(hi,clipHi or hi)
    if hi<lo then return false end
    if s.shape=='compound'then
        local first,unknown
        for _,part in ipairs(s.parts)do
            local hit,at=G.sweep(part,a,b,t0,t1,radius,budget,lo,hi)
            if hit==nil then unknown=at
            elseif hit then first=min(first or at,at)end
            if budget.remaining<0 then return nil,'geometry_budget'end
        end
        if unknown then return nil,unknown end
        if first then return true,first end
        return false
    end
    if s.speedUncertain then
        local complete,reason,first=speedEnvelopeIntervals(s,a,b,t0,t1,lo,hi,radius,budget,nil,true)
        if not complete then return nil,reason end
        if first then return true,first end
        return false
    end
    if s.motionUnknown then
        -- The observed straight-flight corridor remains spatial evidence. A
        -- route outside it is clear; contact inside has no validated timing.
        local corridor={shape='line',origin=s.origin,b=s.b,radius=s.radius,starts=s.starts,ends=t1}
        local hit,reason=G.sweep(corridor,a,b,t0,t1,radius,budget,lo,hi)
        if hit then return nil,'motion_unknown'end
        return hit,reason
    end
    if s.radiusTransition then
        local complete,reason,first=radiusIntervals(s,a,b,t0,t1,lo,hi,radius,budget,nil,true)
        if not complete then return nil,reason end
        if first then return true,first end
        return false
    end
    if staticLine(s)then return capsuleInterval(s,a,b,t0,t1,lo,hi,radius,budget)end
    if staticRectangle(s)then return rectangleInterval(s,a,b,t0,t1,lo,hi,radius,budget)end
    if (s.shape=='circle'or s.shape=='missile')and s.motion then
local result,at=false
motionIntervals(s,lo,hi,function(l,h)
result,at=circleInterval(s,a,b,t0,t1,l,h,radius,budget)
return result==false
end)
return result,at
end
if (s.shape=='circle'or s.shape=='missile')and not s.motion and (not s.acceleration or s.acceleration==0)then
        return linearCircle(s,a,b,t0,t1,lo,hi,radius,budget)
    end
    if (s.shape=='circle'or s.shape=='missile')and not s.motion and s.speed and s.b and s.acceleration and s.acceleration~=0 then
        local complete,reason,first=acceleratedIntervals(s,a,b,t0,t1,lo,hi,radius,budget,nil,true)
        if not complete then return nil,reason end
        if first then return true,first end
        return false
    end
    local speed=G.motionBound(s);if not speed then return nil,'motion_unknown'end
    local duration=t1-t0;local player=duration>0 and G.dist(a,b)/duration or 0
    -- During full emission occupancy neither radial boundary moves. Restrict
    -- the bound only to subintervals wholly inside that proven stationary span.
    local settled=s.emissionSpeed and s.emissionStart+s.length/s.emissionSpeed
    local emissionEnd=s.emissionEnd
    local function sample(t)
        return G.distance(s,probeAt(a,b,duration>0 and (t-t0)/duration or 0),t)
    end
    budget.remaining=budget.remaining-1
    if budget.remaining<0 then return nil,'geometry_budget'end
    local initial=sample(lo)
    if initial==nil then return nil,'geometry_unknown'end
    if initial<=radius then return true,lo end
    local function visit(l,h,depth)
        budget.remaining=budget.remaining-1
        if budget.remaining<0 then return nil,'geometry_budget'end
        local mid=(l+h)/2;local d=sample(mid)
        if d==nil then return nil,'geometry_unknown'end
        local motion=settled and l>=settled and h<=emissionEnd and 0 or speed
        if d-radius>(player+motion)*(h-l)/2+0.001 then return false end
        if depth>=14 or h-l<=.001 then return true,l end
        local hit,at=visit(l,mid,depth+1);if hit~=false then return hit,at end
        return visit(mid,h,depth+1)
    end
    return visit(lo,hi,0)
end
-- Full occupied intervals use the same relative-motion equation as route sweeps.
-- Complex shapes enclose the possible contact interval; work exhaustion is explicit.
function G.intervals(s,a,b,t0,t1,radius,budget,clipLo,clipHi)
    local out={intervals={},complete=false,exact=false}
    if not G.point(a)or not G.point(b)or not finite(t0)or not finite(t1)or t1<t0
        or not finite(radius)or radius<0 or not G.valid(s)then out.reason='invalid_interval';return out end
    if s.shape=='targeted'then out.reason='targeted_effect';return out end
    budget=budget or {remaining=12000}
    local lo,hi=max(t0,s.starts),(s.motionUnknown or s.shape=='compound'and G.uncertainMotion(s))and t1 or min(t1,s.ends)
    lo=max(lo,clipLo or lo);hi=min(hi,clipHi or hi)
    if hi<lo then out.complete=true;out.exact=true;return out end
    if s.shape=='compound'then
        local pending={};out.exact=true
        for _,part in ipairs(s.parts)do
            local child=G.intervals(part,a,b,t0,t1,radius,budget,lo,hi)
            if not child.complete then out.reason=child.reason;out.exact=false;return out end
            out.exact=out.exact and child.exact
            out.possible=out.possible or child.possible
            for _,interval in ipairs(child.intervals)do pending[#pending+1]=interval end
        end
        table.sort(pending,function(a,b)return a.starts<b.starts end)
        for _,interval in ipairs(pending)do
            local prior=out.intervals[#out.intervals]
            if prior and interval.starts<=prior.ends+1e-9 then prior.ends=max(prior.ends,interval.ends)
            else out.intervals[#out.intervals+1]={starts=interval.starts,ends=interval.ends}end
        end
        out.complete=true;return out
    end
    if s.motionUnknown then
        local hit,reason=G.sweep(s,a,b,t0,t1,radius,budget,lo,hi)
        out.complete=hit==false;out.exact=out.complete;out.reason=reason
        return out
    end
    local function add(l,h)
        local prior=out.intervals[#out.intervals]
        if prior and l<=prior.ends+1e-9 then prior.ends=max(prior.ends,h)
        else out.intervals[#out.intervals+1]={starts=l,ends=h}end
    end
    if s.speedUncertain then
        out.possible=true
        out.complete,out.reason=speedEnvelopeIntervals(s,a,b,t0,t1,lo,hi,radius,budget,add,false)
        if not out.complete then out.intervals={}end
        return out
    end
    if s.radiusTransition then
        out.complete,out.reason=radiusIntervals(s,a,b,t0,t1,lo,hi,radius,budget,add,false)
        out.exact=out.complete
        -- A reachable-region bound describes possible contact, never an exact hit.
        if s.contactPossible then out.exact=false;out.possible=true end
        if not out.complete then out.intervals={}end
        return out
    end
    if staticLine(s)or staticRectangle(s)then
        local interval=s.shape=='line'and capsuleInterval or rectangleInterval
        local hit,first,last=interval(s,a,b,t0,t1,lo,hi,radius,budget)
        if hit==nil then out.reason=first;return out end
        if hit then add(first,last)end
        out.complete=true;out.exact=true;return out
    end
    if (s.shape=='circle'or s.shape=='missile')and s.motion then
out.exact=true
out.complete=motionIntervals(s,lo,hi,function(l,h)
local hit,first,last=circleInterval(s,a,b,t0,t1,l,h,radius,budget)
if hit==nil then out.reason=first;return false end
if hit then add(first,last)end
return true
end)
return out
end
if (s.shape=='circle'or s.shape=='missile')and not s.motion and (s.acceleration or 0)==0 then
        out.exact=true
        local function visit(l,h)
            local hit,first,last=circleInterval(s,a,b,t0,t1,l,h,radius,budget)
            if hit==nil then out.reason=first;return false end
            if hit then add(first,last)end;return true
        end
        local launch=s.launch or s.starts
        local arrival=s.speed and s.speed>0 and s.b and launch+G.travelTime(s,G.dist(s.origin or s.a,s.b))
        local step=s.speedStep and arrival and launch+stepTime(s)
        local from=lo
        if launch>from and launch<hi then if not visit(from,launch)then return out end;from=launch end
        if step and step>from and step<hi and step<arrival then if not visit(from,step)then return out end;from=step end
        if arrival and arrival>from and arrival<hi then if not visit(from,arrival)then return out end;from=arrival end
        out.complete=visit(from,hi);return out
    end
    if (s.shape=='circle'or s.shape=='missile')and not s.motion and s.speed and s.b and s.acceleration and s.acceleration~=0 then
        out.complete,out.reason=acceleratedIntervals(s,a,b,t0,t1,lo,hi,radius,budget,add,false)
        return out
    end
    local speed=G.motionBound(s)
    if not speed then out.reason='motion_unknown';return out end
    local duration=t1-t0;local player=duration>0 and G.dist(a,b)/duration or 0
    local settled=s.emissionSpeed and s.emissionStart+s.length/s.emissionSpeed
    local emissionEnd=s.emissionEnd
    local function visit(l,h,depth)
        budget.remaining=budget.remaining-1
        if budget.remaining<0 then out.reason='geometry_budget';return false end
        local mid=(l+h)/2
        local d=G.distance(s,probeAt(a,b,duration>0 and (mid-t0)/duration or 0),mid)
        if d==nil then out.reason='geometry_unknown';return false end
        local motion=settled and l>=settled and h<=emissionEnd and 0 or speed
        local reach=(player+motion)*(h-l)/2+.001
        if d-radius>reach then return true end
        if d+reach<=radius or depth>=14 or h-l<=.001 then add(l,h);return true end
        return visit(l,mid,depth+1)and visit(mid,h,depth+1)
    end
    out.complete=visit(lo,hi,0);return out
end
-- Curved flight (catalogue `curve`, fractions of the chord length L unless noted):
-- the host reports start, end and current position, never the curve, so a curved
-- missile becomes the static corridor of its whole flight: the chord widened on
-- both sides by the largest sideways excursion (bulge*L + pad units; both sides,
-- because the record's side convention is not established), extended `back`*L+pad
-- behind the start and `over`*L+pad beyond the end (pad covers the record's start
-- offset in any direction), dangerous from launch to arrival.
-- Mutates and returns `s`; nil,reason for an unusable curve. Never clipped by units.
function G.curveCorridor(s,curve,launch,arrival)
    if type(curve)~='table'then return nil,'invalid_curve'end
    local bulge,pad,back,over=curve.bulge or 0,curve.pad or 0,curve.back or 0,curve.over or 0
    if not G.finite(bulge)or bulge<0 or bulge>2 or not G.finite(pad)or pad<0 or pad>1000
        or not G.finite(back)or back<0 or back>1 or not G.finite(over)or over<0 or over>1 then return nil,'invalid_curve'end
    local o,b=s.origin or s.a,s.b
    if not G.point(o)or not G.point(b)or not G.finite(launch)or not G.finite(arrival)or arrival<launch then return nil,'invalid_curve'end
    local length=G.dist(o,b);if length<1 then return nil,'zero_curve_chord'end
    local dx,dz=(b.x-o.x)/length,(b.z-o.z)/length
    local behind,beyond=back*length+pad,over*length+pad
    s.origin={x=o.x-dx*behind,y=o.y or 0,z=o.z-dz*behind}
    s.b={x=b.x+dx*beyond,y=b.y or 0,z=b.z+dz*beyond}
    s.a=nil;s.shape='rectangle';s.length=length+behind+beyond
    s.radius=(s.radius or 0)+bulge*length+pad
    s.starts=launch;s.ends=arrival;s.launch=nil
    s.speed,s.acceleration,s.minSpeed,s.maxSpeed,s.speedUncertain=nil,nil,nil,nil,nil
    s.contourOrigin=nil;s.positionObservedAt=nil
    s.curveChord=length;s.curveEnvelope=true
    return s
end
-- Damage zones inside one threat (catalogue `zones`, at most 8, first match wins):
-- {axis='radial'|'along',from=,to=,damage=multiplier,cc=,ccHard=}. `radial` is the
-- distance from the threat's centre at t (circle or ring centre, the projectile
-- body, a cone or strike apex); `along` is the distance along the aim from where
-- the flight or strike starts. A zone without `cc` keeps the threat's own control.
-- Returns multiplier, cc, ccHard, zone index (0: no zone, the threat's own values),
-- or nil when p is outside the threat at t. Reads only; no planner decision uses it yet.
function G.zoneAt(s,p,t)
    if t<s.starts or t>s.ends then return nil end
    local d=G.distance(s,p,t);if d==nil or d>0 then return nil end
    local zones=s.zones
    if type(zones)=='table'then
        local radial,along
        for i=1,min(#zones,8)do
            local z=zones[i];local value
            if z.axis=='radial'then
                if radial==nil then local c=G.center(s,t);radial=c and G.dist(c,p)or false end
                value=radial
            elseif z.axis=='along'then
                if along==nil then
                    local o,b=s.contourOrigin or s.castOrigin or s.origin or s.a,s.b
                    if G.point(o)and G.point(b)then local dx,dz=G.direction(o,b);along=(p.x-o.x)*dx+(p.z-o.z)*dz else along=false end
                end
                value=along
            end
            if value and value>=z.from and value<z.to then
                local cc,hard=z.cc,z.ccHard
                if cc==nil then cc,hard=s.cc,s.ccHard end
                return z.damage or 1,cc,hard==true,i
            end
        end
    end
    return 1,s.cc,s.ccHard==true,0
end
return G

end
