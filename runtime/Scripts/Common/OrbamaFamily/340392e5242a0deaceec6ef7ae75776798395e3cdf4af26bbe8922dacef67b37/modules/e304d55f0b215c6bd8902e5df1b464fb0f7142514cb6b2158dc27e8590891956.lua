return function(require)
-- Presentation geometry only. Build outside Draw and never use it to certify safety.
local G=require('evade.geometry')
local C={};local pi=math.pi
local fields={'radius','innerRadius','halfAngle','arcRadius','length'}
local function point(x,z,y)return {x=x,z=z,y=y or 0}end
local function append(t,v)t[#t+1]=v end
local function signature(s,now,out)
    append(out,s.shape)
    if s.shape=='compound'then
        append(out,#s.parts);for _,p in ipairs(s.parts)do signature(p,now,out)end;return
    end
    local a=s.shape=='missile'and(s.contourOrigin or s.origin or s.a)or G.center(s,now)
    append(out,a and a.x or false);append(out,a and a.y or 0);append(out,a and a.z or false)
    append(out,s.b and s.b.x or false);append(out,s.b and s.b.y or 0);append(out,s.b and s.b.z or false)
    for _,key in ipairs(fields)do
        -- Capsule endpoints define their length. Cast-only range metadata may
        -- disappear at missile handoff without changing any rendered vertex.
        local value=s[key]
        if key=='length'and s.shape~='cone'and s.shape~='rectangle'then value=nil end
        append(out,value or false)
    end
    if s.shape=='cone'then append(out,s.emissionSpeed~=nil)end
end
function C.signature(s,now,out)
    out=out or {};for i=#out,1,-1 do out[i]=nil end;signature(s,now,out);return out
end
function C.same(a,b)
    if not a or #a~=#b then return false end
    for i=1,#a do if a[i]~=b[i]then return false end end;return true
end
function C.reason(a,b)
    if not a then return 'first_observation'end
    if a[1]~=b[1]then return 'shape_or_stage'end
    if a[1]=='compound'then return 'compound_revision'end
    for i=8,#b do if a[i]~=b[i]then return 'dimensions'end end
    for i=5,7 do if a[i]~=b[i]then return 'endpoint_or_direction'end end
    return 'anchor_position'
end
function C.vertexCount(s)
    if s.shape=='targeted'then return 0 end
    if s.shape=='compound'then local n=0;for _,part in ipairs(s.parts)do n=n+C.vertexCount(part)end;return n end
    if s.shape=='circle'then return 25 end
    if s.shape=='ring'then return s.innerRadius>0 and 50 or 25 end
    if s.shape=='cone'then return s.emissionSpeed and s.radius>0 and 44 or 26 end
    if s.shape=='arc'then return 68 end
    if s.shape=='rectangle'then return 4 end
    return 22
end
function C.build(s,now)
    local mesh={vertices={},edges={}}
    local function strip(vertices,closed)
        local offset=#mesh.vertices
        for _,v in ipairs(vertices)do append(mesh.vertices,v)end
        for i=2,#vertices do append(mesh.edges,{offset+i-1,offset+i})end
        if closed and #vertices>1 then append(mesh.edges,{offset+#vertices,offset+1})end
    end
    local function arc(a,r,axis,half,steps,out)
        out=out or {}
        for i=0,steps do local t=axis-half+2*half*i/steps
            append(out,point(a.x+math.cos(t)*r,a.z+math.sin(t)*r,a.y))
        end;return out
    end
    local function shape(t)
        if t.shape=='compound'then for _,p in ipairs(t.parts)do shape(p)end;return end
        if t.shape=='targeted'then return end
        local a=t.shape=='missile'and(t.contourOrigin or t.origin or t.a)or G.center(t,now)
        if not a then return end
        local r=t.radius
        if t.shape=='circle'or t.shape=='ring'then
            strip(arc(a,r,0,pi,24),false)
            if t.shape=='ring'and t.innerRadius>0 then strip(arc(a,t.innerRadius,0,pi,24),false)end
            return
        end
        local dx,dz=G.direction(a,t.b);local axis=math.atan2(dz,dx)
        if t.shape=='cone'then
            local length=t.length or G.dist(a,t.b)
            if t.emissionSpeed and r>0 then
                -- Cached full-sector outline, padded by the projectile radius.
                -- Quarter-circle joins and the rear apex arc use a fixed budget.
                local lower,upper=axis-t.halfAngle,axis+t.halfAngle
                local left=point(a.x+math.cos(lower)*length,a.z+math.sin(lower)*length,a.y)
                local right=point(a.x+math.cos(upper)*length,a.z+math.sin(upper)*length,a.y)
                local vertices=arc(left,r,lower-pi/4,pi/4,4)
                arc(a,length+r,axis,t.halfAngle,24,vertices)
                arc(right,r,upper+pi/4,pi/4,4,vertices)
                arc(a,r,axis+pi,pi/2-t.halfAngle,8,vertices)
                strip(vertices,true)
            else
                local vertices={G.copy(a)};arc(a,length,axis,t.halfAngle,24,vertices);strip(vertices,true)
            end
        elseif t.shape=='arc'then
            local vertices=arc(a,t.arcRadius+r,axis,t.halfAngle,24)
            local inner=arc(a,math.max(0,t.arcRadius-r),axis,t.halfAngle,24)
            for i=#inner,1,-1 do append(vertices,inner[i])end;strip(vertices,true)
            -- Rounded ends match the stroked arc used by collision distance.
            local left=point(a.x+math.cos(axis-t.halfAngle)*t.arcRadius,a.z+math.sin(axis-t.halfAngle)*t.arcRadius,a.y)
            local right=point(a.x+math.cos(axis+t.halfAngle)*t.arcRadius,a.z+math.sin(axis+t.halfAngle)*t.arcRadius,a.y)
            strip(arc(left,r,axis-t.halfAngle-pi/2,pi/2,8),false)
            strip(arc(right,r,axis+t.halfAngle+pi/2,pi/2,8),false)
        elseif t.shape=='rectangle'then
            local b=point(a.x+dx*(t.length or G.dist(a,t.b)),a.z+dz*(t.length or G.dist(a,t.b)),a.y)
            strip({point(a.x-dz*r,a.z+dx*r,a.y),point(b.x-dz*r,b.z+dx*r,b.y),
                point(b.x+dz*r,b.z-dx*r,b.y),point(a.x+dz*r,a.z-dx*r,a.y)},true)
        else
            -- A moving disc sweeps a capsule, including both radius-expanded ends.
            local vertices=arc(t.b,r,axis,pi/2,10)
            local rear=#mesh.vertices+#vertices+1
            arc(a,r,axis+pi,pi/2,10,vertices);strip(vertices,true)
            -- Rear cap indexes for Draw-time tail clipping of a top-level missile.
            -- Draw translates these vertices along the axis; the mesh is never mutated.
            if t==s and t.shape=='missile'then
                mesh.tail={first=rear,last=#mesh.vertices,dx=dx,dz=dz,length=G.dist(a,t.b),ax=a.x,az=a.z}
            end
        end
    end
    shape(s);return mesh
end
return C

end
