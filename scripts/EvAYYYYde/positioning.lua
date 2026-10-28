return function(require)
-- Position penalties are not incoming damage predictions. Only current visible
-- enemy reach and live turret range are used; missing fields are not invented.
local G=require('evade.geometry')
local P={}
-- Orbama's own windup of the next basic attack (SDK.Attack:GetWindup: attack speed, champion
-- exceptions), else the host's attackData; nil when neither is readable.
function P.Windup(g,sdk)
    local attack=sdk.Attack
    if attack and type(attack.GetWindup)=='function'then
        local ok,value=pcall(attack.GetWindup,attack)
        if ok and G.finite(value)and value>=0 and value<=1.5 then return value end
    end
    local data=g.myHero.attackData
    if data and G.finite(data.windUpTime)and data.windUpTime>=0 then return math.min(1.5,data.windUpTime)end
end
local function alive(unit,h)
    return unit and not unit.dead and unit.valid~=false and unit.visible~=false and unit.isTargetable~=false
        and unit.team~=h.team and G.point(unit.pos)
end
-- The minion Orbama's health prediction marks killable by the next attack (LastHitable) within attack
-- reach: the lowest predicted health. Reads the provider's per-tick farm list; no own prediction and no
-- call that changes the provider's last-hit lock. Bounded to 32 entries.
function P.LastHit(sdk,h)
    local health=sdk.HealthPrediction
    if type(health)~='table'or health.IsLastHitable~=true or type(health.FarmMinions)~='table'or not G.finite(h.range)then return end
    local best,low
    for i=1,math.min(32,#health.FarmMinions)do local row=health.FarmMinions[i]
        local unit=type(row)=='table'and row.LastHitable==true and row.Minion
        if alive(unit,h)and G.point(h.pos)and G.dist(h.pos,unit.pos)<=h.range+(h.boundingRadius or 0)+(unit.boundingRadius or 0)then
            local hp=G.finite(row.PredictedHP)and row.PredictedHP or math.huge
            if not best or hp<low then best,low=unit,hp end
        end
    end
    return best
end
-- The orbwalker's attack in the current mode, read once per decision: the target it keeps (Combo, Harass
-- and JungleClear: the provider's target; LaneClear and LastHit: the pending last hit only), its reach,
-- Orbama's windup and whether an attack may start now. nil in Flee, without a mode or without a target.
function P.Attack(g,sdk,mode,now)
    if mode==nil or mode==sdk.ORBWALKER_MODE_FLEE then return end
    local h=g.myHero;local orb=sdk.Orbwalker
    if not G.finite(h.range)or not G.finite(h.ms)or h.ms<=0 then return end
    local kind,target,lastHit
    if mode==sdk.ORBWALKER_MODE_LASTHIT or mode==sdk.ORBWALKER_MODE_LANECLEAR then
        kind=mode==sdk.ORBWALKER_MODE_LASTHIT and 'lasthit'or 'clear'
        target=P.LastHit(sdk,h);lastHit=target~=nil
    elseif mode==sdk.ORBWALKER_MODE_COMBO or mode==sdk.ORBWALKER_MODE_HARASS or mode==sdk.ORBWALKER_MODE_JUNGLECLEAR then
        kind=mode==sdk.ORBWALKER_MODE_COMBO and 'combo'or mode==sdk.ORBWALKER_MODE_HARASS and 'harass'or 'jungle'
        if type(orb.GetTarget)=='function'then local ok,unit=pcall(orb.GetTarget,orb);if ok then target=unit end end
    end
    if not alive(target,h)then return end
    local ready=nil
    local attack=sdk.Attack
    if attack and type(attack.IsReady)=='function'then local ok,value=pcall(attack.IsReady,attack);if ok then ready=value==true end end
    local data=h.attackData;local readyAt=data and data.endTime
    if ready==nil then ready=G.finite(readyAt)and G.finite(now)and now>=readyAt end
    if ready then readyAt=now end
    return {kind=kind,target=target,id=target.networkID or target.handle,position=G.copy(target.pos),lastHit=lastHit,
        reach=h.range+(h.boundingRadius or 0)+(target.boundingRadius or 0),speed=h.ms,windup=P.Windup(g,sdk),
        ready=ready,readyAt=G.finite(readyAt)and readyAt or nil}
end
-- Cost of a destination from which the attack target is out of reach: the walk back, in seconds (at most
-- 1), less the time until the attack is ready anyway; a pending last hit weighs half as much again. Ranked
-- after safety, damage, control and destination danger, before the cursor heading (an angle term of 0-2),
-- so among equally safe escapes the one that keeps attacking wins. No host reads per candidate.
function P.Combat(attack)
    if not attack then return end
    local position,reach,speed,ready=attack.position,attack.reach,attack.speed,attack.readyAt
    local weight=attack.lastHit and 1.5 or 1
    return function(point,arrival)
        local gap=G.dist(point,position)-reach
        if gap<=0 then return 0 end
        local wait=G.finite(ready)and math.max(0,ready-arrival)or 0
        return weight*math.min(1,math.max(0,gap/speed-wait))
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
