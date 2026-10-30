return function(require)
-- Evidence-gated self shield. Unknown spell damage is deliberately not lethal.
-- Current native coverage: already airborne, targeted basic-attack missiles.
local U=require('leesin.util');local P=require('leesin.profiles')
local E={};E.__index=E
-- A targeted basic-attack missile is launched from within its source's attack
-- range (at most ~1300 including radii for extended-range champions) and flies
-- for well under a second. A source farther than this from Lee cannot own a
-- missile that reaches her within the shield lead. Includes one refresh
-- generation of relative movement.
local SOURCE_REACH=2100
local function matches(value,unit)
    if type(value)=='table' or type(value)=='userdata' then return U.same(value,unit) end
    return value~=nil and value~=0 and (value==unit.handle or value==unit.networkID)
end
function E.new(c)return setmetatable({ctx=c},E)end
function E:lead()
    local c=self.ctx
    -- Dispatch/host jitter allowance, not a claim of a zero-latency shield.
    return U.clamp(.10+(c.latency or 0)+2*(c.jitter or 0),.12,.30)
end
function E:eligibleBeforeBuffs()
    local c=self.ctx
    return c.config:get('reserveW') and c.config:get('idleDefense') and not c:blocked()
        and c:stage(1)==1 and c:ready(1) and not c.wards.pending and not c.combat.insec
        and not c:combatTransit() and not c.input:held('wardKey')
        and not c.input:held('cursorKey') and not c.input:held('allyKey')
        and not myHero.isImmortal
end
function E:eligible()
    return self:eligibleBeforeBuffs() and not U.buff(myHero,P.immortal,self.ctx:now())
end
-- Decision-scan gate over exactly the lists source() can resolve. Computed once
-- per refresh generation; validators never use it and always re-sample.
function E:sourceNearby()
    local c=self.ctx;local enemies,minions,turrets=c.enemies or {},c.minions or {},c.turrets or {}
    local g=self.gate
    if g and g.generation==c.cacheAt and g.enemies==enemies and g.minions==minions and g.turrets==turrets
        and g.enemyCount==#enemies and g.minionCount==#minions and g.turretCount==#turrets then return g.open end
    local team=myHero.team;local origin=myHero.pos;local open=false
    for _,list in ipairs({enemies,turrets,minions}) do
        for _,unit in ipairs(list) do
            if unit.team~=team and unit.valid~=false and U.dist(origin,unit.pos)<=SOURCE_REACH then open=true;break end
        end
        if open then break end
    end
    self.gate={generation=c.cacheAt,enemies=enemies,minions=minions,turrets=turrets,
        enemyCount=#enemies,minionCount=#minions,turretCount=#turrets,open=open}
    return open
end
function E:source(value)
    local c=self.ctx
    for _,list in ipairs({c.enemies or {},c.minions or {},c.turrets or {}}) do
        for _,unit in ipairs(list) do
            if matches(value,unit) and unit.valid~=false and unit.team~=myHero.team then return unit end
        end
    end
end
-- The target test runs first: almost no missile targets Lee, so the others skip
-- their validity reads. `handle`/`id` are Lee's, read once per scan by evidence().
function E:packet(missile,lead,handle,id)
    local c=self.ctx;local d=missile and missile.missileData
    if not d then return end
    local target=d.target
    if type(target)=='table' or type(target)=='userdata' then
        if not U.same(target,myHero) then return end
    else
        if handle==nil and id==nil then handle,id=myHero.handle,myHero.networkID end
        if target==nil or target==0 or target~=handle and target~=id then return end
    end
    if missile.valid==false or missile.dead
        or not U.position(missile.pos) or not U.finite(d.speed) or d.speed<=0 then return end
    local name=U.name(d.name)
    if not name:find('basicattack',1,true) and not name:find('critattack',1,true) then return end
    local remaining=math.max(0,U.dist(missile.pos,myHero.pos)-(myHero.boundingRadius or 0))/d.speed
    if remaining<=0 or remaining>lead then return end
    local source=self:source(d.owner)
    if not source or not c.sdk.Damage or not c.sdk.Damage.GetAutoAttackDamage then return end
    local ok,damage=pcall(c.sdk.Damage.GetAutoAttackDamage,c.sdk.Damage,source,myHero)
    if not ok or not U.finite(damage) or damage<=0 then return end
    return {id=U.id(missile),source=U.id(source),damage=damage,remaining=remaining}
end
function E:evidence(gated)
    if not self:eligibleBeforeBuffs() or not Game.MissileCount or not Game.Missile then return end
    if gated and not self:sourceNearby() then return end
    local ok,count=pcall(Game.MissileCount)
    if not ok or not U.finite(count) or count<0 or count>512 then return end
    local packets,seen,total,last={},{},0,0;local lead=self:lead()
    local handle,id=myHero.handle,myHero.networkID
    for i=1,math.floor(count) do
        local yes,missile=pcall(Game.Missile,i)
        if yes then
            local packet=self:packet(missile,lead,handle,id)
            if packet and packet.id and not seen[packet.id] then
                seen[packet.id]=true;packets[#packets+1]=packet
                total=total+packet.damage;last=math.max(last,packet.remaining)
            end
        end
    end
    -- Count all existing shield pools conservatively: SDK AA damage can mix
    -- types. Never treat a typed shield as absent merely because AA is physical.
    local effective=(myHero.health or 0)+(myHero.allShield or 0)+(myHero.shieldAD or 0)+(myHero.shieldAP or 0)
        +math.max(0,myHero.hpRegen or 0)*last
    if total<effective or total<=0 then return end
    -- Buff-based immunity is a veto; read Lee's buffs only for a lethal threat.
    if U.buff(myHero,P.immortal,self.ctx:now()) then return end
    return {packets=packets,damage=total,effectiveHP=effective,remaining=last,at=self.ctx:now(),
        evidence='Observed targeted AA missiles; SDK damage estimate; survival not guaranteed'}
end
function E:tick()
    local c=self.ctx
    if c.actions:pendingCast(1) then return false end
    local now=c:now()
    -- Decision scanning is bounded; final send validation always samples fresh.
    if now<(self.nextScan or 0) then return false end
    self.nextScan=now+.025
    local threat=self:evidence(true);if not threat then return false end
    local function valid()
        local fresh=self:evidence()
        if not fresh then return false,'lethal_incoming_evidence_gone' end
        -- Revalidate the same threat, not a different replacement opportunity.
        local ids={};for _,p in ipairs(fresh.packets) do ids[p.id]=true end
        for _,p in ipairs(threat.packets) do if not ids[p.id] then return false,'incoming_missile_gone' end end
        return true
    end
    local accepted=c.spells:w(myHero,'defense',true,nil,valid)
    if accepted and c.config.capture then c:log('emergency_shield_requested',threat) end
    return accepted
end
return E

end
