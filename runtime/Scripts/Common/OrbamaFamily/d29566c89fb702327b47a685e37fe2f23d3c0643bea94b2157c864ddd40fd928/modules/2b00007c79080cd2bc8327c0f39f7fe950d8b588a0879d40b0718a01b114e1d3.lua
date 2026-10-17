return function(require)
-- Additional footprints of one reviewed cast (catalog `cast.extras`): second
-- hits, sweet spots, bounces, the far bar of a T shape. Each part is placed in
-- the cast frame (origin -> aimed point) and shares the cast's identity. A part
-- shares the cast's damage identity unless it is a separate hit (`separate`).
-- Pure geometry on the already-read cast: no host calls.
local G=require('evade.geometry')
local X={max=8}
local shapes={circle=true,rectangle=true,cone=true,ring=true,missile=true}
function X.Publish(observer,base,c,origin,destination,launch,now)
    local parts=c.extras
    if type(parts)~='table'or #parts<1 or #parts>X.max then return 0 end
    local dx,dz=G.direction(origin,destination)
    local published=0
    for index=1,#parts do
        local e=parts[index]
        if type(e)=='table'and shapes[e.shape]and G.finite(e.radius)and e.radius>=0 then
            local anchor=e.anchor=='destination'and destination or origin
            local angle=e.angle or 0;local co,si=math.cos(angle),math.sin(angle)
            local ax,az=dx*co-dz*si,dx*si+dz*co
            if e.absolute then ax,az=co,si end -- a world-fixed orientation
            local forward,side=e.forward or 0,e.side or 0
            local o={x=anchor.x+dx*forward-dz*side,y=anchor.y or 0,z=anchor.z+dz*forward+dx*side}
            if e.back then o.x,o.z=o.x-ax*e.back,o.z-az*e.back end -- start behind the anchor along the part's own axis
            local length=e.range or 1
            local t={}
            for k,v in pairs(base)do if type(v)~='table'then t[k]=v end end
            t.castOrigin=base.castOrigin and G.copy(base.castOrigin)or nil
            t.id=base.id..':x'..index;t.stageID=t.id;t.damageID=e.separate and t.id or base.damageID
            t.shape=e.shape;t.radius=e.radius;t.origin=o;t.length=e.range
            t.b={x=o.x+ax*length,y=o.y,z=o.z+az*length}
            t.halfAngle=e.halfAngle;t.innerRadius=e.innerRadius;t.persistent=e.persistent;t.repeatInterval=e.repeatInterval
            t.contourOrigin=nil;t.speed=nil;t.launch=nil;t.acceleration=nil;t.minSpeed=nil;t.maxSpeed=nil;t.speedUncertain=nil
            -- `arrive`: timed from the cast's own (travel-dependent) activation instead of its launch.
            t.starts=(e.arrive and base.starts or launch)+(e.delay or 0);t.arrivalLatest=t.starts
            t.ends=t.starts+(e.window or .15)
            if e.shape=='missile'then
                if not G.finite(e.speed)or e.speed<=0 then t=nil
                else t.speed=e.speed;t.launch=t.starts;t.ends=t.starts+length/e.speed;t.contourOrigin=G.copy(o)end
            end
            if t then
                t.blockable=e.blockable~=false and not e.persistent and base.blockable
                if e.cc~=nil then t.cc=e.cc end
                if e.ccHard~=nil then t.ccHard=e.ccHard end
                if e.tier~=nil then t.tier=e.tier end
                if e.zonePolicy~=nil then t.zonePolicy=e.zonePolicy end
                if t.ends>=now and G.valid(t)and observer.threats:Observe(t)then published=published+1 end
            end
        end
    end
    return published
end
-- A cancelled cast takes its unstarted parts with it.
function X.Remove(observer,id,c)
    local parts=c and c.extras
    if type(parts)~='table'then return end
    for index=1,math.min(#parts,X.max)do observer.threats:Remove(id..':x'..index)end
end
return X

end
