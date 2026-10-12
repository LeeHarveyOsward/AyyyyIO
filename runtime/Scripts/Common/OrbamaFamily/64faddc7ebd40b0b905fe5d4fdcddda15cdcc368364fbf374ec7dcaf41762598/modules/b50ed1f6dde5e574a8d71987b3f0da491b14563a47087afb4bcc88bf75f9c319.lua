return function(require)
-- Position penalties are not incoming damage predictions. Only current visible
-- enemy reach and live turret range are used; missing fields are not invented.
local G=require('evade.geometry')
local P={}
function P.Combat(g,sdk,mode)
    if mode==nil or mode~=sdk.ORBWALKER_MODE_COMBO and mode~=sdk.ORBWALKER_MODE_HARASS then return end
    local orb=sdk.Orbwalker;local h=g.myHero
    if type(orb.GetTarget)~='function'or not G.finite(h.range)or not G.finite(h.ms)or h.ms<=0 then return end
    local ok,target=pcall(orb.GetTarget,orb)
    if not ok or not target or target.dead or target.valid==false or target.visible==false
        or target.isTargetable==false or target.team==h.team or not G.point(target.pos)then return end
    local position=G.copy(target.pos)
    local reach=h.range+(h.boundingRadius or 0)+(target.boundingRadius or 0)
    local speed=h.ms;local ready=h.attackData and h.attackData.endTime
    -- A small route preference, not predicted dealt damage. It cannot outrank
    -- safety, CC, turret exposure or cooldown cost. No host reads per candidate.
    return function(point,arrival)
        local gap=math.max(0,G.dist(point,position)-reach)
        local approach=gap/speed
        local wait=G.finite(ready)and math.max(0,ready-arrival)or 0
        return .025*math.min(1,math.max(0,approach-wait))
    end
end
function P.Snapshot(g,sdk,enemies,radius,advisory)
    local zones={}
    -- Placed objects with an attack range (turrets, plants): where a dodge ends matters.
    for _,zone in ipairs(advisory or {})do
        if G.point(zone.position)and G.finite(zone.range)and zone.range>0 then
            zones[#zones+1]={position=zone.position,range=zone.range+radius,weight=zone.weight or 1,kind='placed_object'}
        end
    end
    local function add(unit,weight,kind)
        if not unit or unit.valid==false or unit.dead or unit.visible==false
            or unit.team==g.myHero.team or not G.point(unit.pos)
            or not G.finite(unit.range)or unit.range<=0 then return end
        local reach=unit.range+(unit.boundingRadius or 0)+radius
        zones[#zones+1]={position=G.copy(unit.pos),range=reach,weight=weight,kind=kind}
    end
    local manager=sdk.ObjectManager
    if manager and type(manager.GetEnemyTurrets)=='function'then
        for _,unit in ipairs(manager:GetEnemyTurrets()or {})do add(unit,10,'turret')end
    end
    for _,unit in ipairs(enemies or {})do add(unit,1,'enemy_attack_reach')end
    return function(point)
        local penalty=0
        for _,zone in ipairs(zones)do
            local distance=G.dist(zone.position,point)
            if distance<zone.range then penalty=penalty+zone.weight*(1+(zone.range-distance)/zone.range)end
        end
        return penalty
    end
end
-- Units whose hover can turn a ground right-click into an attack/follow. World
-- distance is a conservative proxy for the host's screen hitbox; the provider's
-- send-time GetUnderMouseObject check stays authoritative. Bounded snapshot.
function P.HoverUnits(g,sdk,origin,reach,limit)
    local units={};local manager=sdk and sdk.ObjectManager;local me=g.myHero
    if not manager or not G.point(origin)or not G.finite(reach)then return units end
    for _,name in ipairs({'GetHeroes','GetMinions','GetMonsters'})do
        if #units>=limit then break end
        if type(manager[name])=='function'then
            local ok,list=pcall(manager[name],manager)
            for _,u in ipairs(ok and type(list)=='table'and list or {})do
                if #units>=limit then break end
                if u and u~=me and (u.networkID==nil or u.networkID~=me.networkID)and u.valid~=false and not u.dead
                    and u.visible~=false and G.point(u.pos)and G.dist(u.pos,origin)<=reach then
                    local radius=u.boundingRadius
                    units[#units+1]={position=G.copy(u.pos),radius=G.finite(radius)and radius>0 and radius or 65}
                end
            end
        end
    end
    return units
end
function P.HoverBlocked(units,point,margin)
    for _,u in ipairs(units)do if G.dist(u.position,point)<u.radius+margin then return true end end
    return false
end
return P

end
