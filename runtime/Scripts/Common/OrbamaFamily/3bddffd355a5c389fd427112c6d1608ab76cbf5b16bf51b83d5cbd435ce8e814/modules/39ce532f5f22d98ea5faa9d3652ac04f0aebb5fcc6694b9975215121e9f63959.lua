return function(require)
return function(U,geometry)
geometry=geometry or require('InputGeometry.screen')(U)
local A={}
function A.reject(actions,record,target)
    if not record or not record.sentAt or not record.aim or record.aim.source~='client_projection' then return end
    local old=actions.aimTrial
    if old and old.action==record.id then return end
    actions.aimTrial={target=U.id(target),action=record.id,at=actions.ctx:now(),
        index=old and old.target==U.id(target) and (old.index+1)%5 or 1}
    actions.bodyPoint=nil
end
-- Read-only candidate provider; successful observations update the cache elsewhere.
-- Bounded alternatives on a small object's own hitbox (a ward), offset away
-- from nearby units whose projected bodies can cover it: live 2026-10-01 a W
-- onto a ward failed hover_identity_mismatch for ~600 ms because an enemy
-- champion ~115 units away was the host under-mouse object at every default
-- point. Geometry only orders candidates; native hover identity remains the
-- sole send authority, so a fully covered ward still yields no click.
A.overlapRadius=200;A.overlapUnits=8
local ring={{-1,0},{1,0},{-1,-20},{1,-20},{-.6,-38},{.6,-38},{0,-40},{0,.5},{-.7,.4},{.7,.4}}
function A.overlapPoints(c,target,p,scale)
    local tp=target.pos;local near={};local r2=A.overlapRadius*A.overlapRadius
    for _,list in ipairs({c.heroes or {},c.minions or {},c.wardObjects or {}}) do
        for _,m in ipairs(list) do
            if #near>=A.overlapUnits then break end
            local mp=m.pos
            if mp and m~=target and not U.same(m,target) and not U.same(m,myHero) then
                local dx,dz=mp.x-tp.x,mp.z-tp.z
                if dx*dx+dz*dz<=r2 and U.valid(m) then near[#near+1]=m end
            end
        end
    end
    if #near==0 then return nil end
    local scene=geometry.scene({heroes=near})
    if #scene==0 then return nil end
    local covered=geometry.screenBlocker(c,p,target,scene)~=nil
    -- Screen direction away from the nearby bodies, nearest weighted most.
    local ax,ay=0,0
    for _,row in ipairs(scene) do
        local q=U.vector(row.unit.pos):To2D()
        if q then
            local dx,dy=p.x-q.x,p.y-q.y;local d=math.sqrt(dx*dx+dy*dy)
            if d>.5 then ax=ax+dx/(d*d);ay=ay+dy/(d*d) end
        end
    end
    local norm=math.sqrt(ax*ax+ay*ay);if norm>0 then ax,ay=ax/norm,ay/norm end
    local br=math.max(20,math.min(60,target.boundingRadius or 30))
    local edge=U.vector({x=tp.x+br,y=tp.y,z=tp.z}):To2D()
    local hw=math.max(12*scale,math.min(30*scale,edge and math.abs(edge.x-p.x) or 0))
    local best={}
    for _,o in ipairs(ring) do
        local x=p.x+o[1]*hw;local y=p.y+(math.abs(o[2])<1 and o[2]*hw or o[2]*scale)
        local point={x=x,y=y}
        if not geometry.screenBlocker(c,point,target,scene) then
            local dx,dy=x-p.x,y-p.y;local d=math.sqrt(dx*dx+dy*dy)
            point.score=d>0 and (dx*ax+dy*ay)/d or 0
            -- Linear insertion into a list of at most three; ties keep ring order.
            local at=#best+1
            for i=1,#best do if point.score>best[i].score then at=i;break end end
            if at<=3 then table.insert(best,at,point);best[4]=nil end
        end
    end
    return best,covered
end
function A.points(actions,target,preferIsolated,avoidOverlap)
    local p=U.vector(target.pos):To2D();local size=Game.Resolution and Game.Resolution()
    if not p or p.onScreen==false or not size then return {} end
    local origin=U.vector(myHero.pos):To2D();local old=actions.bodyPoint
    local out={};local scale=math.max(.5,math.min(3,size.y/1080))
    local function add(x,y)
        if x<0 or y<0 or x>=size.x or y>=size.y then return end
        for _,q in ipairs(out) do if U.screenDist(q,{x=x,y=y})<2 then return end end
        if #out<5 then out[#out+1]={x=x,y=y} end
    end
    if old and U.same(old.target,target) and actions:inputNow()-old.at>=0 and actions:inputNow()-old.at<1000
        and old.width==size.x and old.height==size.y and U.screenDist(old.projection,p)<12
        and U.screenDist(old.origin,origin)<12 then add(old.point.x,old.point.y) end
    -- When the host has no hover identity, start with an isolated body point
    -- instead of spending a positioning phase on ground that cannot qualify.
    if preferIsolated then
        local scene=geometry.scene(actions.ctx)
        -- Evaluate lateral candidates too before acquiring the cursor. Otherwise
        -- a reachable side of a crowded monster may be last in the list and
        -- never reached before the bounded positioning budget expires.
        local offsets={{0,60},{0,30},{0,15},{-18,30},{18,30}}
        local trial=actions.aimTrial
        local start=trial and trial.target==U.id(target) and actions.ctx:now()-trial.at<5 and trial.index or 0
        for i=1,#offsets do
            local offset=offsets[(start+i-1)%#offsets+1]
            local point={x=p.x+offset[1]*scale,y=p.y-offset[2]*scale}
            if A.isolated(actions.ctx,target,point,scene) then add(point.x,point.y);break end
        end
    end
    if avoidOverlap then
        local away,covered=A.overlapPoints(actions.ctx,target,p,scale)
        if away then
            if not covered then add(p.x,p.y) end
            for _,q in ipairs(away) do add(q.x,q.y) end
        end
    end
    add(p.x,p.y);add(p.x,p.y-60*scale);add(p.x,p.y-30*scale)
    add(p.x-18*scale,p.y-45*scale);add(p.x+18*scale,p.y-45*scale)
    return out
end
function A.isolated(c,target,point,scene)
    if not U.valid(target) or target.team~=300 or not point then return false end
    local screen=U.vector(target.pos):To2D();local size=Game.Resolution and Game.Resolution()
    if not screen.onScreen or not size then return false end
    local scale=math.max(.5,math.min(3,size.y/1080))
    -- Only a central body point, never an unrelated ground position. Nearby
    -- projected bodies reject this approximation; native identity wins always.
    if math.abs(point.x-screen.x)>20*scale or point.y>screen.y-10*scale or point.y<screen.y-80*scale then return false end
    return not geometry.screenBlocker(c,point,target,scene)
end
function A.remember(actions,r,target)
    local aim=r and r.aim
    if not aim or not aim.hoverConfirmed or not aim.position or not r.sentAt then return end
    local size=Game.Resolution and Game.Resolution();if not size then return end
    actions.bodyPoint={target=target,point=U.copy(aim.position),projection=U.vector(target.pos):To2D(),
        origin=U.vector(myHero.pos):To2D(),at=aim.confirmedAt,width=size.x,height=size.y}
end
return A

end

end
