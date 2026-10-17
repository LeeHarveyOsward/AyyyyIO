return function(require)
local U=require('leesin.util');local P=require('leesin.profiles');local F=require('leesin.forecast')
local T={};T.__index=T
function T.new(combat) return setmetatable({b=combat,ctx=combat.ctx},T) end
function T:wardArrival()
    local c=self.ctx
    local handoff=c.metrics.wardPlacementToW or math.max(.08,c.latency*.5)
    local dash=c.metrics.wardDashDuration or c.config:get('insecDashEstimate')/1000
    return U.clamp(handoff+dash,.1,.65)
end

-- A policy horizon is not a claim that enemy spell damage is fully known.
-- Low health, nearby additional enemies and turret exposure shorten the time
-- for which a cheaper alternative may postpone an otherwise lethal R.
function T:window(target)
    local c=self.ctx;local extra=0
    for _,enemy in ipairs(c.enemies or {}) do
        if not U.same(enemy,target) and c:enemyValid(enemy) and U.dist(enemy.pos,myHero.pos)<900 then extra=extra+1 end
    end
    local health=U.clamp((myHero.health or 0)/math.max(1,myHero.maxHealth or 1),0,1)
    local horizon=U.clamp(.25+health*1.25-extra*.25,.25,1.5)
    -- Healthy isolated combat may finish a normal rotation within two seconds.
    -- Retain the existing shorter exposure budget when health or pressure is worse.
    if (c.mode=='fight' or c.mode=='harass') and health>=.75 and extra==0 then horizon=2 end
    if c:underTurret(myHero.pos) then horizon=math.min(horizon,.35) end
    return horizon,extra
end

function T:model(target,owner,horizon,options)
    local c=self.ctx;options=options or {};owner=owner or 'fight'
    local mode=owner=='killsteal' and (c.mode=='harass' and 'harass' or 'fight') or owner
    local prefix=mode=='harass' and 'harass' or 'combo'
    local distance=U.dist(myHero.pos,target.pos);local range=c:attackRange(target)
    local attack=c.sdk.Attack or {};local cycle=attack.GetAnimation and attack:GetAnimation() or 1/math.max(.5,myHero.attackSpeed or 1)
    cycle=math.max(.15,cycle);local windup=math.max(.02,c:windup())
    local pending,impact=c:pendingAttackDamage(target,horizon)
    local readyAA=attack.IsReady and attack:IsReady()
    local nextAA=readyAA and 0 or U.finite(attack.ServerStart) and math.max(0,attack.ServerStart+cycle-c:now()) or math.huge
    if pending>0 then nextAA=math.max(nextAA,cycle-(c:now()-(myHero.activeSpell.startTime or c:now()))) end
    local at,immobile,speed=self.b:chaseMotion(target)
    local future=at(horizon);local toward=U.dist(myHero.pos,future)-distance
    local retreat=horizon>0 and toward/horizon or 0
    local ownSpeed=math.max(1,myHero.ms or 350)
    local gap=math.max(0,distance-range)
    local background=owner=='killsteal' and c.mode~='fight' and c.mode~='harass'
    local autosEnabled=not options.noAutos and not background and attack.IsReady and c.sdk.Orbwalker.AttackEnabled~=false
    local plain=(autosEnabled or pending>0) and c.sdk.Damage:GetAutoAttackDamage(myHero,target,false) or 0
    -- SDK returns an aggregate for proc-inclusive attacks. Without a component
    -- split, do not pretend magic on-hit damage bypasses a target's magic shield.
    local typedShield=(target.shieldAP or 0)>0
    if typedShield then pending=math.min(pending,plain) end
    -- Do not promise attacks through a wall or into a turret. No path search
    -- inside the combinatorial search; terrain is checked once per assessment.
    local walkTo=U.toward(myHero.pos,future,math.max(0,U.dist(myHero.pos,future)-range+10))
    local corridor=distance<=range and retreat<=0 or autosEnabled and gap<=ownSpeed*horizon
        and c.terrain:walkLine(myHero.pos,walkTo,myHero.boundingRadius or 35)==true
    local movement=c.moveTarget or c.aim or myHero.pathing and myHero.pathing.endPos
    local movingToward=false
    if movement and U.position(movement) then
        local mx,mz=movement.x-myHero.pos.x,movement.z-myHero.pos.z
        local tx,tz=future.x-myHero.pos.x,future.z-myHero.pos.z
        local length=math.sqrt((mx*mx+mz*mz)*(tx*tx+tz*tz))
        movingToward=length>1 and (mx*tx+mz*tz)/length>.5
    end
    local chaseSafe=autosEnabled and corridor and movingToward and not c:underTurret(future)
    local approach=gap==0 and 0 or chaseSafe and ownSpeed>retreat and gap/(ownSpeed-retreat) or math.huge
    -- A sampled passive-enhanced attack period is valid only while charges
    -- remain. Do not extrapolate that speed after expiry or exhaustion, and
    -- do not invent future energy refunds from unobserved attacks.
    local sampledPassive=c:passive()
    local clear=c.clear;local active=myHero.activeSpell
    -- Clear consumes the charge at cast-end, before HP necessarily updates.
    -- Reserve a pending attack only if that exact cast-end was not consumed.
    local unspentPending=pending>0 and clear and active
        and clear.finishedAttack~=active.castEndTime
        and active.castEndTime>=(clear.passiveCastAt or 0)
    local cadenceCredits=math.max(0,sampledPassive-(unspentPending and 1 or 0))
    local cadenceUntil=clear and U.finite(clear.passiveUntil) and clear.passiveUntil-c:now() or 0
    local actions={};local lookup={}
    local samples,availability={},{}
    local function spell(slot)
        if not samples[slot] then samples[slot]=c:spell(slot) end
        return samples[slot]
    end
    local m={hp=(target.health or 0)+(c.config:get('combatDamageMargin') or 0),maxHP=(target.maxHealth or target.health)+(c.config:get('combatDamageMargin') or 0),
        regen=math.max(0,target.hpRegen or 0),shield=target.allShield or 0,physical=target.shieldAD or 0,magic=target.shieldAP or 0,
        energy=math.max(0,(myHero.mana or 0)-(options.reserveEnergy or 0)),distance=distance,horizon=horizon,actions=actions,aaAt=nextAA,resourceWeight=2,
        mark=c:mark(target) and c:markLeft(target) or 0}
    if pending>0 then m.pending={damage=pending,at=impact or 0} end
    local function add(a)
        if sampledPassive>0 and a.slot and a.slot<=2 then
            local apply=a.apply
            a.apply=function(s,old,dt)
                if apply then apply(s,old,dt) end
                s.cadenceCredits=2;s.cadenceUntil=old.t+3
            end
        end
        actions[#actions+1]=a;lookup[a.id]=a
    end
    local function permitted(slot,stage,lethal)
        local key=({[0]='Q',[1]='W',[2]='E',[3]='R'})[slot]..(stage==2 and '2' or '')
        -- Q2 with Combo's "Q2 even when it does not kill" off: still allowed as the
        -- last step of a sequence that kills (forecast lethalOnly); the cast uses
        -- the finisher policy. q2Safety is applied by the caller as before.
        if lethal and not background and mode=='fight' and slot==0 and stage==2 and not c.config:get('comboQ2') then
            if not c.config:get('comboQ') or c.actions:pendingCast(0) then return false end
            if availability[0]==nil then availability[0]=c:ready(0) end
            return availability[0],true
        end
        if owner=='killsteal' and c.mode~='fight' and c.mode~='harass' then
            local option=slot==0 and (stage==2 and 'killQ2' or 'killQ') or slot==2 and stage==1 and 'killE'
            if not option or not c.config:get(option) then return false end
        end
        -- Background kill permissions are independent of Combo's menu. Match
        -- the real cast path; held combat/harass retains its own restrictions.
        if (not background and not c.config:get(prefix..key))
            or not c:abilityEnabled(slot,stage,background and owner or mode,target) or c.actions:pendingCast(slot) then return false end
        if availability[slot]==nil then availability[slot]=c:ready(slot) end
        return availability[slot]
    end
    local function inRange(s,r) return s.distance+math.max(0,retreat)*s.t<=r end
    if autosEnabled then
        local firstDamage=c:aaDamage(target)
        if typedShield then firstDamage=math.min(firstDamage,plain) end
        add({id='AA',kind='physical',repeatable=true,cost=0,delay=function(s)
            local start=math.max(s.t,s.aaAt,approach)
            if s.autos>0 and retreat>0 then
                if not chaseSafe or ownSpeed<=retreat then return nil end
                start=math.max(start,s.t+retreat*windup/(ownSpeed-retreat))
            end
            if not chaseSafe and (distance>range or retreat>0 and distance+retreat*(start+windup)>range) then return nil end
            if sampledPassive>0 and ((s.cadenceCredits or cadenceCredits)<=0
                or start+windup>(s.cadenceUntil or cadenceUntil)) then return nil end
            return start+windup-s.t
        end,damage=function(s)return s.autos==0 and pending==0 and firstDamage or plain end,
        apply=function(s,old,dt)
            if sampledPassive>0 then s.cadenceCredits=math.max(0,(s.cadenceCredits or cadenceCredits)-1) end
            s.autos=s.autos+1;s.aaAt=s.t-windup+cycle;s.distance=math.min(s.distance,range);s.firstAt=old.firstAt or old.t+dt-windup end})
    end
    local qStage=c:stage(0,target,spell(0));local q1=false
    if qStage==1 and permitted(0,1) and distance<=c.profile.qRange then
        local aim=c.spells:predict(target)
        local blockers=aim and c.spells:blockers(target,aim)
        local reason=not aim and 'prediction_rejected' or #blockers>0 and 'collision'
            or c.spells:projectileWall(aim) and 'projectile_wall'
            or not c.spells:q1Useful(target,aim) and 'target_dies_before_q' or 'available_to_planner'
        q1=reason=='available_to_planner'
        -- Smite + Q: one blocker Smite removes now. Only inside a lethal Combo
        -- plan; the Smite request and its wait are part of the step's delay.
        local smite=not q1 and mode=='fight' and reason=='collision' and #blockers==1
            and not c.spells:projectileWall(aim) and c.spells:q1Useful(target,aim) and c.spells:smiteClears(blockers[1])
        if blockers and #blockers>0 then c.spells:traceCollision(target,aim,blockers,'planner') end
        c.spells:q1Status(target,owner,smite and 'smite_clears_blocker' or reason)
        if q1 or smite then
            local dmg=c:combatDamage(0,target,1);local delay=.25+U.dist(myHero.pos,aim)/c.profile.qSpeed+(smite and .15 or 0)
            add({id='Q1',slot=0,stage=1,kind='physical',energy=spell(0).mana or 0,cost=smite and 3 or 1,lethalOnly=smite or nil,smite=smite or nil,
                delay=function(s)if inRange(s,c.profile.qRange) then return delay end end,
                damage=function()return dmg end,apply=function(s)s.mark=s.t+3 end})
            q1=true
        end
    end
    local q2Allowed,q2Lethal=false,nil
    if not options.excludeQ2 and (qStage==2 and m.mark>0 or q1) then q2Allowed,q2Lethal=permitted(0,2,true) end
    if q2Allowed and not (c.config:get('q2Safety') and c:underTurret(target.pos)) then
        local full=c:combatDamage(0,target,2,target.maxHealth);local low=c:combatDamage(0,target,2,0)
        add({id='Q2',slot=0,stage=2,kind='physical',energy=qStage==2 and (spell(0).mana or 0) or 30,cost=1.5,lethalOnly=q2Lethal,
            delay=function(s)
                local dt=.15+(s.distance+math.max(0,retreat)*s.t)/1800
                if s.mark>s.t+dt and inRange(s,c.profile.q2Range) then return dt end
            end,damage=function(s)return full+(low-full)*U.clamp(1-s.hp/math.max(1,target.maxHealth),0,1) end,
            apply=function(s)s.mark=0;s.distance=0;if qStage~=2 then s.conditional=true end end})
    end
    local eStage=c:stage(2,nil,spell(2))
    if eStage==1 and permitted(2,1) and distance<=c.profile.eRange then
        local dmg=c:combatDamage(2,target,1)
        add({id='E1',slot=2,stage=1,kind='magic',energy=spell(2).mana or 0,cost=1,
            delay=function(s)if inRange(s,c.profile.eRange) then return .25 end end,damage=function()return dmg end})
    elseif eStage==2 and permitted(2,2) and distance<=c.profile.e2Range and U.buff(target,P.eMarks,c:now()) then
        -- Utility only: do not invent a mode-independent slow coefficient or
        -- count speculative slow-enabled attacks as guaranteed kill damage.
        local refresh=distance<=range and c:passive()==0
        if speed>0 and immobile<horizon and distance>range*.75 or refresh then
            add({id='E2',slot=2,stage=2,energy=spell(2).mana or 0,cost=.5,utility=refresh and c:aaDamage(target)*.2 or math.min(100,math.max(20,gap*.3)),
                delay=function(s)if inRange(s,c.profile.e2Range) then return .05 end end})
        end
    end
    local wStage=c:stage(1,nil,spell(1))
    if permitted(1,wStage) and distance<=range then
        local missing=math.max(0,(myHero.maxHealth or 0)-(myHero.health or 0))
        local refresh=c:passive()==0 and c:aaDamage(target)*.2 or 0
        -- Utility is a scheduling preference, never extra damage or a claim of
        -- measured W shielding/healing. Unknown coefficients cannot prove a kill.
        local utility=refresh+math.min(100,missing*.15)
        if utility>0 then add({id=wStage==2 and 'W2' or 'W1',slot=1,stage=wStage,
            energy=spell(1).mana or 0,cost=.5,utility=utility,delay=function()return .05 end}) end
    end
    if c.config:get('items') and mode=='fight' then
        for slot=6,11 do
            local useful,rule=c.actives:itemAllowed(slot,target)
            if useful and c:ready(slot) and not c.actions:pendingCast(slot) then
                local item=c.damageModel:item(slot,target);local slotValue=slot
                if item and not item.unknown and item.damage>0 then
                    add({id='Item'..slot,slot=slotValue,kind=item.type,cost=.5,
                        delay=function(s)if inRange(s,rule.range) then return .05 end end,damage=function()return item.damage end})
                end
            end
        end
    end
    if mode=='fight' and c.config:get('comboIgnite') then
        local slot,damage,known=c.damageModel:ignite(target)
        if slot and known and (not c.config:get('igniteExecute') or damage>=U.typedHP(target,'true')+10) then
            -- Ignite's full duration must elapse before claiming its full damage.
            add({id='Ignite',slot=slot,kind='true',cost=4,delay=function(s)if inRange(s,600) then return 5 end end,
                damage=function()return damage+math.max(0,target.hpRegen or 0)*5 end})
        end
    end
    m.lookup=lookup;m.approach=approach;m.targetSpeed=speed;m.immobile=immobile
    return m
end
-- This is a bounded wait for an existing lethal Q, not observed hit damage.
function T:pendingFinish(target)
    local c=self.ctx;local flight,phase,left=c.spells:q1Reservation(target)
    -- Public action snapshots may omit expiry. The controller's original
    -- request deadline is a conservative bound and never extends that request.
    if not flight and c.actions.api then
        local owned=c.spells.q1Flight;local event=owned and owned.event
        if owned and owned.target==U.id(target) and event and c.actions:pendingCast(0)==event
            and not event.cancelled and not event.gameplayCancelled then
            local action=c.actions:inputAction(event.cursorID)
            if action and not action.sentAt and not action.jobCancelled
                and(action.state=='waiting'or action.state=='requested')and U.finite(event.deadline)then
                flight,phase,left=owned,'queued',event.deadline-c:now()
            end
        end
    end
    if not flight or not U.finite(left) or left<=0 then return false end
    local impactLeft=left
    if phase=='queued'then
        if not U.finite(flight.duration)or flight.duration<0 then return false end
        impactLeft=left+flight.duration
    end
    local horizon=self:window(target)
    if impactLeft>horizon then return false end
    local event=flight.event
    if not event or event.target~=U.id(target) or event.stage~=1 or event.slot~=0
        or event.status=='unconfirmed' or event.status=='send_uncertain' or c:mark(target) then return false end
    if c:combatDamage(0,target,1)<U.typedHP(target,'physical')+c.config:get('combatDamageMargin')
        +math.max(0,target.hpRegen or 0)*impactLeft then return false end
    if phase=='queued' then
        -- Use the owned request's full current legality check, including its
        -- original mode/selection bindings. Never extend the request deadline.
        if event.validate then
            local ok,valid=pcall(event.validate)
            if ok and valid then return true,'lethal_q_waiting_dispatch' end
        end
        return false
    end
    if phase~='in_flight' or event.status~='observed' then return false end
    local origin=event.resolution and event.resolution.data and event.resolution.data.origin or event.aimOrigin
    local point=event.resolution and event.resolution.position or event.aimIntent
    if not U.position(origin) or not U.position(point) then return false end
    local future=self.b:chaseMotion(target)
    local predicted=future(left)
    local distance,along=U.segment(predicted,origin,point)
    if along<=0 or distance>c.profile.qRadius+(target.boundingRadius or 35)*.5 then return false end
    if #c.spells:blockers(target,point,origin)>0 or c.spells:projectileWall(point,origin,U.id(target)) then return false end
    return true,'observed_lethal_q_in_flight'
end

function T:assess(target,owner,horizon,options)
    if not self.ctx:enemyValid(target) then return {expanded=0} end
    local model=self:model(target,owner,horizon or self:window(target),options)
    local result=F.solve(model);result.model=model
    result.estimated=not (self.ctx.config:get('mechanicsVerified') or self.ctx.profile.damageVerified)
    return result
end
function T:cast(id,target,owner,model)
    local c=self.ctx;local action=model and model.lookup and model.lookup[id]
    if id=='Q1' then return c.spells:q1(target,owner,action and action.smite or false)
    elseif id=='Q2' then return c.spells:q2(target,owner,false,nil,nil,nil,action and action.lethalOnly and 'finisher' or nil)
    elseif id=='E1' or id=='E2' then return c.spells:e(target,owner)
    elseif id=='W1' or id=='W2' then return c.spells:w(myHero,owner)
    elseif id=='Ignite' then return c.damageModel:castIgnite(target)
    elseif id and id:sub(1,4)=='Item' then
        local slot=tonumber(id:sub(5));local ok,rule=c.actives:itemAllowed(slot,target)
        if ok then return c.actions:cast(slot,rule.targeted and target or nil,owner,{intendedTarget=target,
            validate=function()return c.actives:itemAllowed(slot,target)end}) end
    end
    return false
end
return T

end
