return function(require)
local G=require('evade.geometry')
local T={};T.__index=T
local function bit(n,b)return math.floor(n/b)%2==1 end
function T.new(grid,team,live)
    return setmetatable({grid=grid,team=team,live=live,revision=0,obstacles={},unknown=false},T)
end
function T:Ready()return not self.unknown and (self.grid~=nil or self.runtime==true and type(self.live)=='function')end
function T:BindRuntime(g)
    -- Native collision queries operate on the currently loaded navigation mesh.
    -- This avoids selecting a static variant from champion names or map IDs.
    local game=g.Game;local id=game and game.mapID
    if id==22 or not id or type(game.isWall)~='function' then return false,'terrain_api_missing'end
    local function wall(p)
        local position=g.Vector and g.Vector(p.x,p.y or 0,p.z)or p
        local value=game.isWall(position)
        if type(value)~='boolean'then return nil end
        return value
    end
    local ok,value=pcall(wall,g.myHero.pos)
    if not ok or type(value)~='boolean'then return false,'terrain_api_unavailable'end
    self.grid=nil;self.live=wall;self.runtime=true;self.mapID=id;self.unknown=false
    self.revision=self.revision+1;self.source='Game.isWall';return true
end
function T:SetDynamic(id,shape)
    if shape and not G.valid(shape)then return false,'invalid_obstacle'end
    self.obstacles[id]=shape;self.revision=self.revision+1;return true
end
function T:SetUnknown(on)
    if self.unknown~=on then self.unknown=on;self.revision=self.revision+1 end
end
function T:Cell(x,z)
    local g=self.grid;if not g then return nil end
    if x<0 or z<0 or x>=g.nx or z>=g.nz then return true end
    local row=g.rows and g.rows[z+1]
    local flag=row and tonumber(row:sub(x*4+1,x*4+4),16) or g.flags and g.flags[z*g.nx+x+1]
    if not flag then return nil end
    if flag>=8192 then return nil end -- 4096 affects visibility, not collision.
    if bit(flag,2)or bit(flag,512)then return true end
    if bit(flag,1024)and bit(flag,2048)then return true end
    if bit(flag,1024) then return self.team~=100 end
    if bit(flag,2048) then return self.team~=200 end
    if bit(flag,4)or bit(flag,8)or bit(flag,64)then return true end
    -- Existing extracted profiles treat 2048 as a team gate. It must be
    -- interpreted before other obstacle flags, never globally cleared.
    return false
end
function T:Wall(p,t,radius)
    if self.unknown or not G.point(p)then return nil,'terrain_unknown'end
    local g=self.grid;if not self:Ready()then return nil,'map_variant_unknown'end
    if g then
        local x,z=math.floor((p.x-g.x)/g.cell),math.floor((p.z-g.z)/g.cell)
        local wall=self:Cell(x,z)
        if wall~=false then return wall,wall and 'static_wall' or 'terrain_unknown'end
    end
    if self.live then local ok,v=pcall(self.live,p);if not ok or type(v)~='boolean'then return nil,'dynamic_terrain_unknown'end;if v then return true,'live_wall'end end
    for _,s in pairs(self.obstacles)do if t>=s.starts and t<=s.ends then
        local d=G.distance(s,p,t);if not d then return nil,'dynamic_terrain_unknown'end
        if d<=(radius or 0)then return true,'dynamic_wall'end
    end end
    return false
end
-- Exact closed-cell contact for a swept champion disk. The broad phase below
-- only rejects cells; a surrounding circle cannot prove that a square blocks.
local function cornerNear(x,z,ax,az,dx,dz,inverse,r2)
    local u=math.max(0,math.min(1,((x-ax)*dx+(z-az)*dz)*inverse))
    local qx,qz=x-ax-dx*u,z-az-dz*u
    return qx*qx+qz*qz<=r2
end
local function capsuleCell(a,b,dx,dz,inverse,x0,z0,x1,z1,r2)
    local lo,hi=0,1
    if dx==0 then if a.x<x0 or a.x>x1 then hi=-1 end
    else
        local first,last=(x0-a.x)/dx,(x1-a.x)/dx
        if first>last then first,last=last,first end
        lo=math.max(lo,first);hi=math.min(hi,last)
    end
    if dz==0 then if a.z<z0 or a.z>z1 then hi=-1 end
    else
        local first,last=(z0-a.z)/dz,(z1-a.z)/dz
        if first>last then first,last=last,first end
        lo=math.max(lo,first);hi=math.min(hi,last)
    end
    if lo<=hi then return true end
    local ax,az=math.max(x0-a.x,0,a.x-x1),math.max(z0-a.z,0,a.z-z1)
    local bx,bz=math.max(x0-b.x,0,b.x-x1),math.max(z0-b.z,0,b.z-z1)
    if ax*ax+az*az<=r2 or bx*bx+bz*bz<=r2 then return true end
    return cornerNear(x0,z0,a.x,a.z,dx,dz,inverse,r2)
        or cornerNear(x0,z1,a.x,a.z,dx,dz,inverse,r2)
        or cornerNear(x1,z0,a.x,a.z,dx,dz,inverse,r2)
        or cornerNear(x1,z1,a.x,a.z,dx,dz,inverse,r2)
end
-- Native centre queries may be shared only inside the planner's explicit
-- evaluation scope. Dynamic obstacles, time/radius checks and dispatch remain
-- fresh. Charge logical work before lookup so savings never expand the search.
local function nativeWall(self,p,memo)
    local share=memo and memo.owner==self and memo.reader==self.live and memo.revision==self.revision
    local x,z,y=p.x,p.z,p.y or 0
    local bucket=share and memo.points and memo.points[x]
    local entry=bucket and bucket[z]
    if entry and entry.y==y then return true,entry.value end
    local ok,value=pcall(self.live,p)
    if share and ok and type(value)=='boolean'and not self.unknown and memo.revision==self.revision
        and memo.reader==self.live and p.x==x and p.z==z and(p.y or 0)==y and memo.count<128 then
        if not memo.points then memo.points={}end
        if not bucket then bucket={};memo.points[x]=bucket end
        if not entry then memo.count=memo.count+1 end
        bucket[z]={y=y,value=value}
    end
    return ok,value
end
function T:Segment(a,b,radius,t0,t1,budget,memo)
    if not G.point(a)or not G.point(b)or not G.finite(radius)or radius<0 then return nil,'invalid_path'end
    local g=self.grid;if not self:Ready()then return nil,'map_variant_unknown'end
    local revision=self.revision
    if g then
    -- Test every grid square intersecting the swept capsule, not a few samples.
    local minx=math.ceil((math.min(a.x,b.x)-radius-g.x)/g.cell)-1
    local maxx=math.floor((math.max(a.x,b.x)+radius-g.x)/g.cell)
    local minz=math.ceil((math.min(a.z,b.z)-radius-g.z)/g.cell)-1
    local maxz=math.floor((math.max(a.z,b.z)+radius-g.z)/g.cell)
    local half=g.cell/2;local broad2=(radius+half*1.4142135623731)^2
    local dx,dz=b.x-a.x,b.z-a.z;local length2=dx*dx+dz*dz
    local inverse=length2>0 and 1/length2 or 0;local r2=radius*radius
    for z=minz,maxz do for x=minx,maxx do
        budget.remaining=budget.remaining-1;if budget.remaining<0 then return nil,'terrain_budget'end
        local x0,z0=g.x+x*g.cell,g.z+z*g.cell
        local cx,cz=x0+half-a.x,z0+half-a.z
        local u=math.max(0,math.min(1,(cx*dx+cz*dz)*inverse))
        local qx,qz=cx-dx*u,cz-dz*u
        if qx*qx+qz*qz<=broad2 then
            local wall=self:Cell(x,z)
            if wall~=false and capsuleCell(a,b,dx,dz,inverse,x0,z0,x0+g.cell,z0+g.cell,r2)then
                if wall==nil then return nil,'terrain_unknown'end
                return false,'static_wall'
            end
        end
    end end
    end
    for _,s in pairs(self.obstacles)do
        local hit,why=G.sweep(s,a,b,t0,t1,radius,budget)
        if hit==nil then return nil,why elseif hit then return false,'dynamic_wall'end
    end
    -- Static cells do not establish the absence of runtime terrain changes.
    if self.live then
        -- The hero's centre decides whether a straight walk is possible: the game path-finds with a far
        -- smaller radius than the gameplay one, and the start point is where the hero already stands.
        -- Live 2026-10-08: nine native queries per 20 units cost about 4 ms per route (one query is about
        -- 20 us in the host), and the gameplay-radius ring refused every route within 65 units of terrain.
        local distance=G.dist(a,b);local steps=distance>0 and math.ceil(distance/25)or 0
        for i=distance>0 and 1 or 0,steps do
            budget.remaining=budget.remaining-1;if budget.remaining<0 then return nil,'terrain_budget'end
            -- Native queries are the expensive unit of a decision; the planner bounds them separately.
            if budget.native then budget.native=budget.native-1;if budget.native<0 then return nil,'terrain_budget'end end
            local p=steps>0 and G.lerp(a,b,i/steps)or a;local ok,v=nativeWall(self,p,memo)
            if not ok or type(v)~='boolean'then return nil,'dynamic_terrain_unknown'end
            if self.unknown or self.revision~=revision then return nil,'terrain_changed'end
            if v then return false,'live_wall'end
        end
    end
    return true
end
return T

end
