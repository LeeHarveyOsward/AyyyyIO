return function(require)
local U=require('leesin.util')
local P=require('leesin.profiles')
local R={}; R.__index=R
function R.new(profile,config)
    return setmetatable({profile=profile,config=config,sdk=_G.SDK,events={},cacheAt=-1,latency=.05,
        jitter=0,selected=nil,mode='idle',synthetic=false,injected={},status='Idle',verification={},metrics={}},R)
end
function R:now() return Game.Timer() end
function R:playerPosition()
    if self.sdk.Actions and self.sdk.Actions.GetPlayerPosition then return self.sdk.Actions:GetPlayerPosition() end
    return self.sdk.Input and self.sdk.Input:GetPlayerPosition() or U.copy(mousePos or self.aim or myHero.pos)
end
function R:log()end
function R:chatOpen()
    if self.sdk.Input and self.sdk.Input.IsChatOpen then return self.sdk.Input:IsChatOpen() end
    return Game.IsChatOpen and Game.IsChatOpen() or false
end
function R:blocked()
    if self.retired then return true end
    if self.sharedUtilities and _G.AyyyyIO and not _G.AyyyyIO:Allows()then return true end
    return not self.config:get('enabled') or myHero.dead or self:chatOpen()
        or (Game.IsOnTop and not Game.IsOnTop())
end
function R:recalling()
    if self.sdk.IsRecalling then return self.sdk.IsRecalling(myHero) end
    return U.buff(myHero,{recall=true,recallimproved=true},self:now())~=nil
end
function R:refresh()
    local now=self:now()
    if now<(self.cacheAt or 0)+.08 then return end
    self.cacheAt=now
    local ms=Game.Latency and Game.Latency() or 50
    if type(ms)=='number' and ms>=0 and ms<=2000 then
        local sample=ms/1000
        self.jitter=self.jitter*.8+math.abs(sample-self.latency)*.2
        self.latency=self.latency*.8+sample*.2
    end
    self.heroes={};self.enemies={};self.allies={};self.minions={};self.wardObjects={};self.turrets={};self.camps={}
    for _,entry in ipairs({{'Hero','heroes'},{'Minion','minions'},{'Ward','wardObjects'},{'Turret','turrets'},{'Camp','camps'}}) do
        local shared=self.sdk.SharedData
        local kind=entry[2]=='wardObjects' and 'wards' or entry[2]
        local snapshot=shared and shared:GetObjects(kind)
        if snapshot and snapshot.ageMs<=80 then self[entry[2]]=snapshot.objects
        else
            local count,get=Game[entry[1]..'Count'],Game[entry[1]]
            if count and get then for i=1,U.count(count(),entry[1]=='Minion' and 4096 or 512) do
                local unit=get(i);if unit then self[entry[2]][#self[entry[2]]+1]=unit end
            end end
        end
    end
    -- One team read per minion per refresh: jungle monsters, and every minion not
    -- on Lee's team (Q mark scans and collision candidates read only those).
    local monsters,hostile={},{};local team=myHero.team
    for _,m in ipairs(self.minions) do local side=m.team
        if side~=team then hostile[#hostile+1]=m end
        if side==300 and P.jungleEntity(m) then monsters[#monsters+1]=m end
    end
    self.monsterCache={source=self.minions,units=monsters}
    self.hostileMinions=hostile;self.hostileSource=self.minions
    local own=U.id(myHero)
    for _,h in ipairs(self.heroes) do
        if h~=myHero and U.valid(h) then
            local id=U.id(h)
            if not(id and id==own) then local list=h.team==team and self.allies or self.enemies;list[#list+1]=h end
        end
    end
end
-- Minions not on Lee's team from the current refresh; the whole list when the
-- minion list was replaced without a refresh (callers still filter by team).
function R:hostileList()
    if self.hostileMinions and self.hostileSource==self.minions then return self.hostileMinions end
    return self.minions
end
function R:spellSlot(slot)
    -- Inventory positions are 6..12; native spell-slot constants are a
    -- separate API. Do not assume ITEM_1..ITEM_7 equal those positions.
    if self.actions and self.actions.client then return self.actions.client:NativeSpellSlot(slot)end
    return slot>=6 and slot<=12 and (_G['ITEM_'..(slot-5)] or slot) or slot -- Inert fixtures without an execution client.
end
function R:spell(slot)local native=self:spellSlot(slot);return native and myHero:GetSpellData(native)or {} end
-- An own Q1 can place a mark only after its cast time and flight. While such a
-- cast may still land, scan every candidate and never reuse across callbacks.
local Q_CAST_WINDOW=1.5
-- Outside that window a new own mark cannot appear. Candidates beyond Q2 reach
-- plus a radius/motion allowance are skipped; a mark already observed follows
-- its unit regardless of distance until the mark disappears.
local Q_SCAN_ALLOWANCE=300
-- Hard cap for cross-callback reuse even if refresh stops advancing.
local Q_STAGE_REUSE_LIMIT=.1
function R:qCastRecent(now,spell)
    local clear=self.clear
    if not clear then return true end -- No cast observation: stay conservative.
    local last=clear.lastCast and clear.lastCast[0]
    if last and now-(last.at or -math.huge)<Q_CAST_WINDOW then return true end
    local executed=clear.executionBySlot and clear.executionBySlot[0]
    if executed and now-(executed.at or -math.huge)<Q_CAST_WINDOW then return true end
    -- Manual casts may not have been observed by Clear yet in this callback.
    local active=myHero.activeSpell
    if active and active.valid and U.finite(active.startTime) and now-active.startTime<Q_CAST_WINDOW
        and U.name(active.name):find('leesinq',1,true) then return true end
    local total,left=spell.cd,spell.currentCd
    return U.finite(total) and U.finite(left) and left>0 and total-left<Q_CAST_WINDOW or false
end
function R:qStageScan(name,filtered)
    local team=myHero.team;local origin=filtered and myHero.pos
    local reach=filtered and (self.profile.q2Range or 1300)+Q_SCAN_ALLOWANCE
    local sticky=self.qMarkedUnitID
    -- hostileMinions: this refresh's minions not on Lee's team (same filter as below).
    for _,list in ipairs({self:hostileList()or {},self.enemies or {}}) do
        for _,unit in ipairs(list) do
            if unit.team~=team then
                local near=not filtered or U.dist(origin,unit.pos)<=reach or sticky~=nil and U.id(unit)==sticky
                if near and U.valid(unit) and self:mark(unit,name) then
                    self.qMarkedUnitID=U.id(unit);return unit
                end
            end
        end
    end
    self.qMarkedUnitID=nil
end
function R:stage(slot,markedTarget,sampledSpell)
    local spell=sampledSpell or self:spell(slot);local name=U.name(spell.name)
    if slot==0 and (name=='leesinqone' or name=='leesinqmanager' or name=='leesinqoneability') then
        local scope=U.buffScopeKey();local cached=self.qStageCache
        local now=self:now();local toggle=spell.toggleState;local cooling=(spell.currentCd or 0)>0
        local clear=self.clear
        local lastCast=clear and clear.lastCast and clear.lastCast[0]
        local executed=clear and clear.executionBySlot and clear.executionBySlot[0]
        local minions,enemies=self.minions,self.enemies
        -- Mark-derived Q2 results keep their unit; any reuse across callbacks
        -- re-reads that unit's mark. Reuse inside one callback scope as before. Across callbacks only in
        -- the same refresh generation with unchanged spell stage/cooldown
        -- state, no input/reentrant/standalone invalidation, no new own Q
        -- cast evidence and no possible in-flight own Q1.
        if scope and cached and cached.name==name and cached.toggle==toggle and cached.cooling==cooling
            and cached.minions==minions and cached.enemies==enemies and cached.generation==self.cacheAt
            and cached.minionCount==#(minions or {}) and cached.enemyCount==#(enemies or {})
            and cached.invalidations==U.buffInvalidations() and cached.lastCast==lastCast and cached.executed==executed
            and (cached.scope==scope or cached.durable and now>=cached.at and now-cached.at<Q_STAGE_REUSE_LIMIT
                -- A reused Q2 result still re-reads its own marked unit.
                and (not cached.unit or U.valid(cached.unit) and self:mark(cached.unit,name))) then
            cached.scope=scope
            if cached.stage~=2 and U.valid(markedTarget) and self:mark(markedTarget,name) then
                cached.stage=2;cached.unit=markedTarget;self.qMarkedUnitID=U.id(markedTarget)
            end
            return cached.stage
        end
        local recent=self:qCastRecent(now,spell)
        local function resolved(stage,unit)
            if scope then self.qStageCache={scope=scope,name=name,toggle=toggle,cooling=cooling,
                minions=minions,enemies=enemies,generation=self.cacheAt,minionCount=#(minions or {}),
                enemyCount=#(enemies or {}),invalidations=U.buffInvalidations(),lastCast=lastCast,
                executed=executed,durable=not recent,at=now,stage=stage,unit=unit} end
            return stage
        end
        if U.valid(markedTarget) and self:mark(markedTarget,name) then
            self.qMarkedUnitID=U.id(markedTarget);return resolved(2,markedTarget)
        end
        local unit=self:qStageScan(name,not recent)
        if unit then return resolved(2,unit) end
        local fallback=name=='leesinqmanager' and (toggle==2 and 2 or toggle==1 and 1 or 0)
            or name=='leesinqone' and toggle==2 and 2 or 1
        return resolved(fallback)
    end
    if slot==0 and (name=='leesinqone' or name=='leesinqmanager') and spell.toggleState==2 then return 2 end
    if slot==0 and name=='leesinqmanager' and spell.toggleState==1 then return 1 end
    if name:find('two',1,true) or name:match('[qwe]2$') or name=='ironwill' or name=='cripple' then return 2 end
    if name:find('one',1,true) or name:match('[qwe]1$') or name=='safeguard' or name=='tempest' then return 1 end
    return 0
end
function R:ready(slot)
    local native=self:spellSlot(slot);if native==nil then return false end
    local d=myHero:GetSpellData(native)or {}
    if slot>=6 and (d.currentCd or 0)>0 then return false end
    return (slot>3 or (d.level or 0)>0) and (d.mana or 0)<=(myHero.mana or 0) and Game.CanUseSpell(native)==0
end
-- One buff pass accepting either own source identity. The primary identity
-- wins anywhere in the list; a handle-sourced entry is the fallback, exactly
-- as two ordered U.buff passes would select it.
local function ownMark(unit,now,primary,handle)
    if not unit or not unit.GetBuff then return nil,false end
    local fallback;local named=false;local marks=P.qMarks
    for index=0,U.count(unit.buffCount or 0,256) do
        local b=U.readBuff(unit,index)
        local name=b and b.name
        if name and marks[U.name(name)] then
            named=true
            if math.max(b.count or 0,b.stacks or 0)>0 then
                local expiry=U.buffEnd(b)
                if not expiry or expiry>now then
                    local nativeSource=b.sourcenID
                    local owner=nativeSource and nativeSource~=0 and nativeSource or b.sourceID
                    if not owner or owner==0 or owner==primary then return b,true end
                    if handle and not fallback and owner==handle then fallback=b end
                end
            end
        end
    end
    return fallback,named
end
-- Own-mark pass results shared inside one buff scope (one outer callback or
-- validation). Any input/reentrant invalidation or new scope starts empty;
-- the key also pins the clock and own identities. Never kept across scopes.
local ownMarkMemo={scope=nil}
function R:mark(unit,spellName)
    local now=self:now();local primary=U.id(myHero)
    local handle=myHero.handle and myHero.handle~=primary and myHero.handle or nil
    local mark,named
    local scope=unit and U.buffScopeKey()
    if scope then
        local memo=ownMarkMemo
        if memo.scope~=scope or memo.now~=now or memo.primary~=primary or memo.handle~=handle then
            memo={scope=scope,now=now,primary=primary,handle=handle,marks={},named={}};ownMarkMemo=memo
        end
        local cached=memo.marks[unit]
        if cached~=nil then mark,named=cached or nil,memo.named[unit]
        else
            mark,named=ownMark(unit,now,primary,handle)
            memo.marks[unit]=mark or false;memo.named[unit]=named
        end
    else mark,named=ownMark(unit,now,primary,handle) end
    -- A native wrapper may change while it is scanned. Only a unit carrying a
    -- mark-named entry can differ from the historical second pass; repeat it.
    if not mark and named and handle then mark=U.buff(unit,P.qMarks,now,handle) end
    -- Remember our mark on an enemy champion: when that champion steps into a
    -- brush the buff becomes unreadable although Q2 is still castable.
    if mark and unit.type==myHero.type and unit.team~=myHero.team and unit.team~=300 then
        local seen=self.qMarkSeen;if not seen then seen={pos={}};self.qMarkSeen=seen end
        seen.id=U.id(unit);seen.name=unit.charName;seen.at=now;seen.expires=U.buffEnd(mark) or now+3
        seen.pos.x=unit.pos.x;seen.pos.y=unit.pos.y;seen.pos.z=unit.pos.z
    end
    -- Recorded in both runtimes: the active QOne debuff's sourcenID equals
    -- the monster's ID, not Lee's. Accept that representation only while our
    -- own slot explicitly exposes QTwo, and only for an unambiguous target.
    -- Foreign caster IDs retain the existing ownership rule.
    if not mark and U.name(spellName or self:spell(0).name)=='leesinqtwo' then
        local function recipientMark(target)
            local b=U.buff(target,{leesinqone=true},self:now(),U.id(target))
            local source=b and (b.sourcenID and b.sourcenID~=0 and b.sourcenID or b.sourceID)
            return b and source==U.id(target) and b or nil
        end
        mark=recipientMark(unit)
        if mark then
            local scan=self.recipientMarkScan;local id=U.id(unit)
            if scan and scan.at==self:now() and scan.target==id then return not scan.ambiguous and mark or nil end
            local ambiguous=false
            for _,list in ipairs({self.minions or {},self.enemies or {}}) do
                for _,other in ipairs(list) do
                    if U.valid(other) and not U.same(other,unit) and recipientMark(other) then ambiguous=true;break end
                end
                if ambiguous then break end
            end
            self.recipientMarkScan={at=self:now(),target=id,ambiguous=ambiguous}
            if ambiguous then return nil end
        end
    end
    return mark
end
function R:trace(kind,fields,key,interval)
    local persistent=self.config:get('combatLogging') and (fields and (fields.owner=='autosmite' or fields.owner=='insec' or fields.owner=='fight')
        or kind:match('^smite_') or kind:match('^insec_') or kind:match('^combo_'))
    if not persistent and (not self.config:get('playtestLogging') or self.playtestState=='finished') then return end
    self.traceLimits=self.traceLimits or {};key=kind..':'..tostring(key or '')
    if self:now()<(self.traceLimits[key] or 0) then return end
    self.traceLimits[key]=self:now()+(interval or 1);self:log(kind,fields)
end
function R:markLeft(unit)
    local b=self:mark(unit)
    return b and math.max(0,(U.buffEnd(b) or (self:now()+.2))-self:now()) or 0
end
function R:passive() return self.clear and self:now()<self.clear.passiveUntil and self.clear.passiveLeft or 0 end
function R:dash() return myHero.pathing and myHero.pathing.isDashing end
function R:combatTransit()
    local now=self:now();local active=myHero.activeSpell
    if self:dash() then self.combatDashActive=true;return true end
    if self.combatDashActive then self.combatDashActive=nil;self.combatDashEndedAt=now end
    if active and active.valid and U.name(active.name):find('leesinqtwo',1,true)
        and U.finite(active.startTime) and active.startTime>(self.combatDashEndedAt or -math.huge)
        and now-active.startTime>=0 and now-active.startTime<.8 then return true end
    local press=self.manualSpells and self.manualSpells[0]
    -- Bridge the physical-Q2 to native-dash acknowledgement gap, without
    -- treating an unacknowledged press as an indefinitely active dash.
    return press and press.before and press.before.stage==2 and press.at>(self.combatDashEndedAt or -math.huge)
        and now-press.at>=0 and now-press.at<.20 or false
end
function R:abilityEnabled(slot,stage,owner,target,abilityPolicy)
    local jungleW=slot==1 and (U.same(target,myHero) or stage==2 and target==nil)
        and (owner=='farm' and abilityPolicy=='autoClear' or owner=='clear' and abilityPolicy=='jungle')
    if slot==1 and self.config:get('reserveW') and not jungleW then
        -- Controller policy: explicit mobility owns W, ordinary rotations do not.
        -- A life-saving shield: Lee himself or an allied champion (combat:defense evidence).
        if owner=='defense' then return stage==1 and target~=nil and (U.same(target,myHero)
            or target.team==myHero.team and target.type==myHero.type) end
        -- A Combo W onto a ward or an ally is the chase / reposition jump (its own
        -- switch: comboWard); a Combo W on Lee himself is the ordinary rotation.
        local jump=owner=='fight' and stage==1 and target and not U.same(target,myHero)
        local mobility=owner=='escape' or owner=='flee' or owner=='evade'
        if owner~='ward' and owner~='insec' and not mobility and not jump then return false end
        if stage~=1 or mobility and (not target or U.same(target,myHero)) then return false end
    end
    local mode=owner
    if owner=='expiry' or owner=='defense' or owner=='killsteal' then mode=self.mode end
    local prefix=mode=='fight' and 'combo' or mode=='harass' and 'harass'
    -- Kill secure has its own switches (killQ/killE/killQ2/killR; Combo's own are
    -- checked by combat:killsteal). A Q2 that ends a planned lethal sequence or an
    -- explicit harass dive is governed by its own decision, not the "Q2 even when it
    -- does not kill" switch.
    if owner=='killsteal' or slot==0 and stage==2 and (abilityPolicy=='finisher' or abilityPolicy=='dive') then prefix=nil end
    if prefix and slot>=0 and slot<=3 then
        local key=({[0]='Q',[1]='W',[2]='E',[3]='R'})[slot]
        if not self.config:get(prefix..key..(stage==2 and '2' or '')) then return false end
    end
    if slot==0 and stage==1 and self.config:get('qOnlySelected') and target and target.type==myHero.type and target.team~=300
        and target.team~=myHero.team and mode~='insec' and mode~='farm' then
        local selector=self.sdk.TargetSelector;local selected=selector and selector.Selected or self.selected
        if not U.same(target,selected) then return false end
    end
    return true
end
function R:pendingAttackDamage(target,delay)
    local active=myHero.activeSpell;local now=self:now()
    if not target or not active or not active.valid or active.isStopped then return 0 end
    local name=U.name(active.name)
    if not active.isAutoAttack and not name:find('basicattack',1,true) and not name:find('critattack',1,true) then return 0 end
    local id=active.target
    if not id or id==0 or id~=target.handle and id~=target.networkID then return 0 end
    local finish=active.castEndTime;local start=active.startTime
    if not U.finite(finish) or not U.finite(start) or start>now or finish<start or finish-start>1.5
        or finish>now+delay or now>finish+math.min(.12,self.latency*.5+.06) then return 0 end
    local attack=self.finishingAttack
    if not attack or attack.start~=start or attack.target~=U.id(target) then
        attack={start=start,target=U.id(target),health=target.health};self.finishingAttack=attack
    end
    -- Once damage is visible, never subtract that auto again from remaining HP.
    if target.health<attack.health-.5 then return 0 end
    return math.max(0,self:aaDamage(target)),math.max(0,finish-now)
end
function R:attackFinishesBefore(target,delay)
    return target and self:pendingAttackDamage(target,delay)>=U.typedHP(target,'physical')+5 or false
end
function R:attackRange(target)
    if self.sdk.Data and self.sdk.Data.GetAutoAttackRange then return self.sdk.Data:GetAutoAttackRange(myHero,target) end
    return (myHero.range or 125)+(myHero.boundingRadius or 65)+(target and target.boundingRadius or 0)
end
-- How far R displaces `target`. Normal: 800, reduced by up to both gameplay radii
-- (wiki V26.12 bug note); the shortest kick is used so hit counts never overstate.
function R:kickLength(target)
    local p=self.profile
    if not p.kickRadiusReduction then return p.kickDistance end
    return math.max(0,p.kickDistance-(myHero.boundingRadius or 65)-(target and target.boundingRadius or 65))
end
function R:jungleQ2Range(target)
    return math.min(self.profile.q2Range,self:attackRange(target)*U.clamp(self.config:get('jungleQ2RangeScale') or 2,1,4))
end
function R:windup()
    return self.sdk.Attack and self.sdk.Attack.GetWindup and self.sdk.Attack:GetWindup() or .25
end
function R:healthAt(target,delay)
    local hp=self.sdk.HealthPrediction
    if hp and hp.GetPrediction then
        local ok,value=pcall(hp.GetPrediction,hp,target,math.max(0,delay))
        if ok and type(value)=='number' and value==value and value>-math.huge and value<math.huge then return value end
    end
    return target.health or 0
end
function R:aaDamage(target)
    local d=self.sdk.Damage
    if d and d.GetAutoAttackDamage then return d:GetAutoAttackDamage(myHero,target,true) end
    return (myHero.totalDamage or 0)*100/(100+math.max(0,target.armor or 0))
end
function R:damage(slot,target,stage,healthOverride)
    if not self.config:get('mechanicsVerified') and not self.profile.damageVerified then return 0 end
    return self:spellDamageEstimate(slot,target,stage,healthOverride)
end
function R:combatDamage(slot,target,stage,healthOverride)
    local damage=self:damage(slot,target,stage,healthOverride)
    if self.config:get('mechanicsVerified') or self.profile.damageVerified then return damage end
    if self.config:get('combatEstimates') and self:enemyValid(target) then
        -- Deliberately separate from objective/Smite guaranteed damage.
        return self:spellDamageEstimate(slot,target,stage,healthOverride)*.9
    end
    return 0
end
function R:spellDamageEstimate(slot,target,stage,healthOverride)
    local p=self.profile;local rank=self:spell(slot).level or 0
    if rank==0 then return 0 end
    local bonus=myHero.bonusDamage or math.max(0,(myHero.totalDamage or 0)-(myHero.baseDamage or 0))
    local raw,dtype=0,self.sdk.DAMAGE_TYPE_PHYSICAL
    if slot==0 then
        raw=(p.qBase[rank] or 0)+p.qRatio*bonus
        if stage==2 then
            local missing=math.max(0,(target.maxHealth or 0)-(healthOverride or target.health or 0))
            if p.id=='classic' then raw=raw+missing*.08
            else raw=raw*(1+missing/math.max(1,target.maxHealth or 1)) end
            -- Never count an unmeasured monster execute amplification as guaranteed.
            if target.team==300 then raw=(p.qBase[rank] or 0)+p.qRatio*bonus end
        end
    elseif slot==2 then raw=(p.eBase[rank] or 0)+p.eRatio*(p.id=='normal' and (myHero.totalDamage or 0) or bonus);dtype=self.sdk.DAMAGE_TYPE_MAGICAL
    elseif slot==3 then raw=(p.rBase[rank] or 0)+p.rRatio*bonus end
    if slot==0 and target.team==300 then
        local cap=self.config:get('monsterQCap')
        if not cap or cap<=0 then return 0 end
        raw=math.min(raw,cap)
    end
    if self.sdk.Damage and self.sdk.Damage.CalculateDamage then
        return self.sdk.Damage:CalculateDamage(myHero,target,dtype,raw,true,slot==3)
    end
    local resist=dtype==self.sdk.DAMAGE_TYPE_MAGICAL and (target.magicResist or 0) or (target.armor or 0)
    return raw*(resist>=0 and 100/(100+resist) or 2-100/(100-resist))
end
function R:enemyValid(target)
    if not U.valid(target) or target.team==myHero.team or target.team==300 then return false end
    local now=self:now()
    if U.buff(target,P.immortal,now) then return false end
    if target.isImmortal and not U.buff(target,P.reviveReady,now) then
        -- Native immortality also marks passive resurrection readiness.
        -- Let the active provider distinguish it from active protection.
        local objects=self.sdk.ObjectManager
        if not objects or type(objects.IsHeroImmortal)~='function' then return false end
        local ok,immortal=pcall(objects.IsHeroImmortal,objects,target,false)
        if not ok or immortal~=false then return false end
    end
    return true
end
function R:locked()
    local selector=self.sdk.TargetSelector
    local target
    if selector and selector.GetSelectedTarget then target=selector:GetSelectedTarget()
    elseif selector and selector.GetTarget then target=selector.Selected else target=self.selected end
    if selector and selector.GetTarget and selector.MenuCheckSelected and not selector.MenuCheckSelected:Value() then return nil end
    if not self.selectionOwned and not target and not (selector and selector.GetSelectedTarget) then target=selector and selector.Selected end
    if target and (target.dead or (target.health or 0)<=0) then self.selected=nil;return nil end
    return target
end
function R:target(range)
    local selector=self.sdk.TargetSelector
    if selector and selector.GetTarget then
        local target=selector:GetTarget(range,self.sdk.DAMAGE_TYPE_PHYSICAL or 1,false)
        return self:enemyValid(target) and U.dist(myHero.pos,target.pos)<=range and target or nil
    end
    local lock=self:locked()
    if lock then return self:enemyValid(lock) and U.dist(myHero.pos,lock.pos)<=range and lock or nil end
    local best,score=nil,math.huge
    for _,e in ipairs(self.enemies or {}) do
        if self:enemyValid(e) and U.dist(myHero.pos,e.pos)<=range then
            local mouseDistance=U.dist(self.aim,e.pos)
            local value=U.effectiveHP(e)/math.max(1,self:aaDamage(e)) + U.dist(myHero.pos,e.pos)/100
            if mouseDistance<300 then value=value-30+mouseDistance/20 end
            if value<score then best,score=e,value end
        end
    end
    return best
end
-- Enemy turrets with their fixed team, position and radius, rebuilt with each
-- turret snapshot (refresh). `dead` and Lee's own radius are read on every call.
-- Routing asks this 8-13 times per tick; each former call read ~70 host fields.
function R:enemyTurretRows()
    local rows=self.enemyTurrets
    if rows and rows.source==self.turrets then return rows end
    rows={source=self.turrets};local team=myHero.team
    for _,t in ipairs(self.turrets or {}) do
        if t.team~=team then local p=t.pos
            if p then rows[#rows+1]={unit=t,x=p.x,z=p.z or p.y,radius=(t.boundingRadius or 80)+775}end
        end
    end
    self.enemyTurrets=rows;return rows
end
function R:underTurret(pos)
    if not pos then return false end
    local rows=self:enemyTurretRows();local own=myHero.boundingRadius or 65;local x,z=pos.x,pos.z or pos.y
    for i=1,#rows do local r=rows[i];local limit=r.radius+own
        if limit>0 and not r.unit.dead then local dx,dz=x-r.x,z-r.z
            if dx*dx+dz*dz<limit*limit then return true end
        end
    end
    return false
end
function R:threats(pos,range)
    local count=0
    for _,e in ipairs(self.enemies or {}) do if U.dist(e.pos,pos)<range then count=count+1 end end
    return count
end
return R

end
