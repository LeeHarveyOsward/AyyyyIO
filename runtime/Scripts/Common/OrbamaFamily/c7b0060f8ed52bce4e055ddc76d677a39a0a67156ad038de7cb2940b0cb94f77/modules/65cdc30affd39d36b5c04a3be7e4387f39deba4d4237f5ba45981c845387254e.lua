return function(require)
return function(U)
local G={}
function G.scene(c)
    local resolution=Game.Resolution and Game.Resolution()
    local scale=math.max(.75,math.min(3,(resolution and resolution.y or 1080)/1080))
    local seen,scene={},{}
    for _,list in ipairs({c.minions or {},c.heroes or {},c.turrets or {},c.wardObjects or {}}) do
        for _,m in ipairs(list) do
            local id=U.id(m)
            if id and not seen[id] and not U.same(m,myHero) and U.valid(m) then
                seen[id]=true
                local q=U.vector(m.pos):To2D()
                if q and q.onScreen~=false then
                    local radius=math.max(25,m.boundingRadius or 45)
                    local edge=U.vector({x=m.pos.x+radius,y=m.pos.y,z=m.pos.z}):To2D()
                    local width=math.max(18*scale,edge and math.abs(edge.x-q.x) or 0)
                    -- Model silhouettes extend upward from ground projection.
                    scene[#scene+1]={unit=m,x=q.x,width=width+8*scale,top=q.y-100*scale,bottom=q.y+width*.5+8*scale}
                end
            end
        end
    end
    return scene
end
function G.screenBlocker(c,p,ignore,scene)
    if not p or p.onScreen==false then return nil end
    -- A scene is shared only within this synchronous candidate search. Final
    -- input validation calls without it, projecting the current scene afresh.
    for _,row in ipairs(scene or G.scene(c)) do
        if not U.same(row.unit,ignore) and math.abs(p.x-row.x)<=row.width and p.y>=row.top and p.y<=row.bottom then return row.unit end
    end
end
return G
end

end
