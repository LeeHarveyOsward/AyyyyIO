return function(require)
local U=require('leesin.util');local P=require('leesin.profiles')
local B={};B.__index=B
function B.new(ctx,actions,spells,wards)
    local self=setmetatable({ctx=ctx,actions=actions,spells=spells,wards=wards},B)
    self.planner=require('leesin.insec').new(self);self.kicks=require('leesin.kickplan').new(ctx)
    self.tactics=require('leesin.tactics').new(self);return self
end
function B:planAligned(i,origin)
    return self:aligned({pos=i.plannedTarget or i.target.pos},i.plannedEndpoint or i.endpoint,origin)
end
function B:direction(target,destination)
    local endpoint=U.toward(target.pos,destination,self.ctx:kickLength(target))
    local stand=math.min(self.ctx.config:get('insecStandDistance'),self.ctx.profile.rRange-45)
    return U.toward(target.pos,destination,-stand),endpoint
end
function B:allyDestination(target,origin,preferred)
    local c=self.ctx;local best,score=nil,math.huge
    local function tower(a,range)
        -- Fountain structures may be untargetable; we target the enemy, not
        -- the recipient. Dead or invalid structures never qualify.
        if a.team~=myHero.team or a.valid==false or a.dead or not U.position(a.pos)
            or not U.finite(a.health) or a.health<=0 then return end
        local endpoint=U.toward(target.pos,a.pos,c:kickLength(target))
        local inside=U.dist(endpoint,a.pos)
        if inside<=range-35 then
            local value=inside+U.dist(origin,a.pos)*.05
            if U.same(a,preferred) or a.platform and preferred and preferred.platform then value=-1 end
            if value<score then best,score=a,value end
        end
    end
    for _,a in ipairs(c.config:get('insecPreferStructures') and c.turrets or {}) do
        local range=U.finite(a.range) and a.range>0 and a.range or 775
        tower(a,range+(a.boundingRadius or 80)+(target.boundingRadius or 0))
    end
    local spawn=c.farm.spawnPos or c.farm.spawnPoints and c.farm.spawnPoints[myHero.team]
    if spawn and c.config:get('insecPreferStructures') and c.config:get('insecBasePlatform') then
        -- A recorded spawn anchor supports a small area deep in the platform.
        -- Do not fabricate the unobserved laser's outer attack radius.
        tower({team=myHero.team,pos=spawn,health=1,charName='Base platform',platform=true},250)
    end
    if best then return U.copy(best.pos),best,'structure' end
    for _,a in ipairs(c.allies or {}) do
        if a.team==myHero.team and not U.same(a,myHero) and U.valid(a) and U.dist(target.pos,a.pos)<2000 then
            local value=U.dist(target.pos,a.pos)+c:threats(a.pos,700)*200
            if value<score then best,score=a,value end
        end
    end
    return U.copy(best and best.pos or origin),best,best and 'ally' or 'origin'
end
function B:aligned(target,endpoint,origin)
    origin=origin or myHero.pos
    if U.dist(origin,target.pos)>self.ctx.profile.rRange or U.dist(origin,target.pos)<25 then return false end
    local dx,dz=target.pos.x-origin.x,target.pos.z-origin.z
    local ex,ez=endpoint.x-target.pos.x,endpoint.z-target.pos.z
    local length=math.sqrt((dx*dx+dz*dz)*(ex*ex+ez*ez))
    if length<1 then return false end
    return (dx*ex+dz*ez)/length+1e-9>=math.cos(math.rad(self.ctx.config:get('insecAngle')))
end
function B:startInsec(kind)
    local c=self.ctx;local target=c:locked()
    local selection='Orbama selection'
    if not target and c.config:get('insecMouseTarget') then
        local nearest=c.config:get('insecMouseRadius')
        for _,enemy in ipairs(c.enemies or {}) do
            local distance=U.dist(c.aim,enemy.pos)
            if distance<nearest and c:enemyValid(enemy) then target=enemy;nearest=distance end
        end
        selection='Mouse fallback'
    end
    if not c:enemyValid(target) then c.status='Select a champion for insec';return false end
    local origin=U.copy(myHero.pos)
    if kind=='ally' and c.input:held('allyKey') and not self.allyHoldOrigin then self.allyHoldOrigin=U.copy(origin) end
    self.insec={kind=kind,target=target,origin=origin,at=c:now(),phase='approach',preview=c.input:previewHeld(),selection=selection}
    self.insec.fallbackOrigin=U.copy(kind=='ally' and self.allyHoldOrigin or origin)
    if c.config.capture then c:log('insec_started',{insecKind=kind,target=U.id(target),name=target.charName,origin=origin,
        wardSlot=c.wards:slot(),preview=self.insec.preview,flash=false,selection=selection}) end
    if kind=='ally' then self.insec.destination,self.insec.recipient,self.insec.recipientKind=self:allyDestination(target,self.insec.fallbackOrigin)
    elseif c.config:get('aimLock')==1 then
        self.insec.destination=U.copy(c.aim);self.insec.locked=true
        local direction=U.toward(target.pos,c.aim,1);self.insec.direction={x=direction.x-target.pos.x,z=direction.z-target.pos.z}
    end
    return true
end
function B:cancel(reason)
    if self.insec then
        if self.ctx.config.capture then self.ctx:log('insec_cancelled',{reason=reason or 'Mode released / input takeover',phase=self.insec.phase,
            outcome=self.insec.preview and 'Preview ended' or self.insec.commitAt and 'Stopped after resource commitment' or 'Stopped before resource commitment',
            target=U.id(self.insec.target),plan=self.insec.resource,flashReason=self.insec.flashReason,
            targetVisible=self.insec.target.visible,targetDead=self.insec.target.dead,targetHP=self.insec.target.health,
            targetable=self.insec.target.isTargetable,leeDead=myHero.dead,leeHP=myHero.health,
            rState=Game.CanUseSpell(3),rCooldown=self.ctx:spell(3).currentCd,energy=myHero.mana,
            cursorHeld=self.ctx.input:held('cursorKey'),allyHeld=self.ctx.input:held('allyKey'),
            chat=Game.IsChatOpen and Game.IsChatOpen(),focus=Game.IsOnTop and Game.IsOnTop(),
            lastInput=self.ctx.input.lastPhysicalEvent,lastTransition=self.ctx.input.lastTransition,mode=self.ctx.mode,
            request=self.insec.event and self.insec.event.id,castStatus=self.insec.event and self.insec.event.status}) end
        self.actions:cancel('insec')
        if self.wards.pending and self.wards.pending.owner=='insec' then self.wards:cancel('Insec released') end
        self.insec=nil
    end
end
function B:insecOrbwalkAllowed()
    local c=self.ctx;local i=self.insec
    if not c.config:get('insecOrbwalk') or (c.mode~='cursor' and c.mode~='ally')
        or not c.input:held(c.mode=='cursor' and 'cursorKey' or 'allyKey')
        or c.input:previewHeld() or c.input.cancel or c:blocked() or c:recalling()
        or c.wards.pending or c:combatTransit() or c.leveling.pending then return false end
    return not i or i.orbwalking and not i.preview and not i.confirmBlocked and not i.flight and not i.qWait
        and i.phase~='kick' or false
end
function B:orbwalkInsec(suppressed)
    local c=self.ctx
    if suppressed or not self:insecOrbwalkAllowed() then return end
    c.moveTarget=c.aim
    local target=self.insec and self.insec.target
    if not c:enemyValid(target) or U.dist(myHero.pos,target.pos)>c:attackRange(target) then
        target=c:target(c:attackRange(myHero)+100)
    end
    if c:enemyValid(target) and U.dist(myHero.pos,target.pos)<=c:attackRange(target) then c.attackTarget=target end
end
function B:confirmPreview()
    local i=self.insec;local c=self.ctx
    if not i or not i.preview or c.input:previewHeld() then return false end
    if not c.input:held(i.kind=='cursor' and 'cursorKey' or 'allyKey') then return false end
    local shown=i.displayPlan or i.plan
    i.preview=false;i.search=nil;i.displayPlan=nil
    if not shown then i.confirmBlocked=true;i.resource='No shown plan to confirm; hold Alt to preview';return false end
    i.contract={};i.contractIndex=1;i.flashConsent=false
    for _,step in ipairs(shown.steps) do
        i.contract[#i.contract+1]={kind=step.kind,unitID=U.id(step.unit),itemID=step.itemID}
        if step.kind=='flash' or step.kind=='rflash' then i.flashConsent=true end
    end
    i.plan=shown;i.approvedLabel=shown.label;i.at=c:now();i.confirmBlocked=nil
    self.planner:committed(i,c.aim)
    if c.config.capture then c:log('insec_confirmed',{plan=shown.label,flash=i.flashConsent,target=U.id(i.target),resources=i.contract}) end
    return true
end
function B:previewTick(i)
    local c=self.ctx
    local r=c:spell(3)
    if (r.level or 0)==0 or (r.currentCd or 0)>0 then
        i.plan=nil;i.displayPlan=nil;i.resource='R on cooldown / not learned';i.phase='preview';c.status='ALT PREVIEW | '..i.resource;return
    end
    self:geometry(i)
    if not i.stand then return end
    local plan=self.planner:adapt(i,self.planner:search(i))
    if plan and self.planner:validate(i,plan) then i.plan=plan
    elseif i.plan and not self.planner:validate(i,self.planner:adapt(i,i.plan)) then i.plan=nil end
    i.phase='preview';i.resource=i.plan and i.plan.label or 'No complete opportunity yet'
    local _,reason=self.planner:flashAllowed(i);i.flashReason=reason
    if c.config.capture then c:trace('insec_preview',{target=U.id(i.target),targetPos=U.copy(i.target.pos),plan=i.plan and i.plan.label,
        stand=U.copy(i.stand),endpoint=U.copy(i.endpoint),searching=i.search and not i.search.done,
        resources=i.plan and i.plan.steps and #i.plan.steps or 0,flashReason=reason},tostring(U.id(i.target)),.25) end
    c.status='ALT PREVIEW | Release Alt to confirm | '..i.resource
end
function B:geometry(i,wardPlacement)
    local c=self.ctx
    if i.kind=='ally' and i.recipient and (i.recipient.dead or i.recipient.valid==false or (i.recipient.health or 0)<=0) then
        i.locked=nil;i.direction=nil;i.recipient=nil
        i.destination,i.recipient,i.recipientKind=self:allyDestination(i.target,i.fallbackOrigin or i.origin)
    end
    if i.kind=='ally' and not i.locked and c.config:get('insecTrackAlly') then
        local destination,recipient,kind=self:allyDestination(i.target,i.fallbackOrigin or i.origin,i.recipient)
        if kind=='structure' or i.recipientKind=='structure' or not U.valid(i.recipient) then
            i.destination,i.recipient,i.recipientKind=destination,recipient,kind
        else i.destination=U.copy(i.recipient.pos) end
    end
    local aim=i.destination or c.aim
    if i.locked and i.direction then
        aim={x=i.target.pos.x+i.direction.x*1200,y=i.target.pos.y,z=i.target.pos.z+i.direction.z*1200}
    end
    if i.kind=='cursor' and c.config:get('aimLock')==3 then aim=c.aim end
    if not aim or U.dist(aim,i.target.pos)<10 then return end
    i.stand,i.endpoint=self:direction(i.target,aim)
    i.geometryTarget=U.copy(i.target.pos)
    i.plannedTarget=i.target.pos;i.plannedEndpoint=i.endpoint
    local lead=c.config:get('insecLead')/1000
    local pending=c.wards.pending
    local wardStep=i.plan and i.plan.steps and i.plan.steps[1] and i.plan.steps[1].kind=='ward'
    if c.config:get('insecAutoLead') and (wardPlacement or wardStep or pending and pending.owner=='insec') then
        local remaining=self.tactics:wardArrival()
        if pending and pending.owner=='insec' then remaining=remaining-math.max(0,c:now()-pending.at) end
        lead=math.max(lead,U.clamp(remaining,0,.65))
    end
    i.predictionLead=lead
    if i.target.GetPrediction and i.target.pathing and i.target.pathing.hasMovePath and lead>0 then
        local ok,p=pcall(i.target.GetPrediction,i.target,math.huge,lead)
        if ok and p and type(p.x)=='number' and type(p.z)=='number' and p.x==p.x and p.z==p.z
            and U.dist(p,i.target.pos)<300 then
            i.plannedTarget=p
            local futureAim=i.locked and i.direction and {x=p.x+i.direction.x*1200,y=p.y,z=p.z+i.direction.z*1200} or aim
            i.stand=U.toward(p,futureAim,-math.min(c.config:get('insecStandDistance'),c.profile.rRange-45))
            i.plannedEndpoint=U.toward(p,futureAim,c:kickLength(i.target))
        end
    end
    return aim
end
function B:kickValid(i)
    if not self.ctx:enemyValid(i.target) or self:kickProtected(i.target) or not self:aligned(i.target,i.endpoint) then return false end
    local target=i.target
    if target.GetPrediction and target.pathing and target.pathing.hasMovePath then
        local ok,p=pcall(target.GetPrediction,target,math.huge,.25)
        if not ok or not p or type(p.x)~='number' or type(p.z)~='number' or p.x~=p.x or p.z~=p.z then return false end
        local aim=i.destination or self.ctx.aim
        if i.locked and i.direction then aim={x=p.x+i.direction.x*1200,y=p.y,z=p.z+i.direction.z*1200} end
        if i.kind=='cursor' and self.ctx.config:get('aimLock')==3 then aim=self.ctx.aim end
        local endpoint=U.toward(p,aim,self.ctx:kickLength(target))
        if not self:aligned({pos=p},endpoint) then return false end
    end
    return true
end
function B:kickProtected(target)
    if target.spellShield==true or U.buff(target,P.kickBlocked,self.ctx:now()) then return true end
    if self.ctx.profile.id=='normal' and U.buff(target,{fioraw=true},self.ctx:now()) then return true end
    for _,buff in ipairs(U.buffs(target)) do
        if buff.type==4 and (buff.expireTime or buff.endTime or math.huge)>self.ctx:now() then return true end
    end
    return false
end
function B:wardFollowValid(p)
    if p.owner~='insec' then return true end
    local i=self.insec
    local r=self.ctx:spell(3)
    if not i or not self.ctx:enemyValid(i.target) or self:kickProtected(i.target)
        or not self:geometry(i) or (r.level or 0)==0 or (r.currentCd or 0)>0 then return false end
    -- Called immediately before W, including the fast ward-spawn callback.
    -- This closes the gap where the target moves before the ordinary tick.
    local from=p.target and p.target.pos or p.pos
    if (myHero.mana or 0)<(self.ctx:spell(1).mana or 0)+(self.ctx:spell(3).mana or 0) then return false end
    if self:aligned(i.target,i.endpoint,from) then return true end
    local plan=self.planner:adapt(i,i.plan)
    if self.planner:validate(i,plan,from,self.ctx:spell(1).mana or 0) then return true end
    -- Only when the cheap continuation check fails do we rebuild from the
    -- observed ward. This callback never executes another resource itself.
    i.plan=self.planner:plan(i,from,nil,self.ctx:spell(1).mana or 0)
    return i.plan~=nil
end
function B:insecTick()
    local c=self.ctx;local i=self.insec;if not i then return end
    if not c:enemyValid(i.target) then self:cancel('Target unavailable');return end
    if i.phase=='kick' and i.rflash and not i.rflash.done then
        if self:rflashTick(i) then return end
    end
    if i.phase=='kick' then
        if i.event.status=='observed' or i.event.status=='completed' then
            i.event.status='completed';if c.config.capture then c:log('insec_completed',{target=U.id(i.target),request=i.event.id,
                evidence='R cast acknowledged; displacement assessed separately'}) end
            self.completedSerial=(self.completedSerial or 0)+1;self.insec=nil;return
        elseif (i.event.status=='unconfirmed' or i.event.status=='cancelled') and c:ready(3) then
            if c.config.capture then c:log('insec_kick_retry',{target=U.id(i.target)}) end;i.phase='replan';i.event=nil
            if i.rflash and not i.rflash.flashEvent then i.used.f=nil end
            i.rflash=nil
        else return end
    end
    if c.input:previewHeld() and not i.preview then
        -- Already dispatched motion must settle. Alt pauses subsequent actions;
        -- it cannot retract a ward placement, dash or R that the game accepted.
        if c.wards.pending or c:dash() then i.resource='Waiting for current jump before preview';return end
        if i.flight then
            local f=i.flight
            if c:now()<=f.deadline and (U.dist(myHero.pos,f.origin)<=60
                or f.event and f.event.status~='observed' and f.event.status~='completed') then return end
            i.flight=nil
        end
        if i.qWait then
            if c:mark(i.qWait.unit) and c:stage(0)==2 then i.used.q=nil;i.qWait=nil
            elseif c:now()>i.qWait.deadline or not U.valid(i.qWait.unit) then i.qWait=nil
            else i.resource='Waiting for Q result before preview';return end
        end
        i.preview=true;i.contract=nil;i.flashConsent=false;i.search=nil;i.plan=nil;i.displayPlan=nil;i.confirmBlocked=nil;i.commitAt=nil
    end
    if i.preview then
        if c.input:previewHeld() then self:previewTick(i);return end
        self:confirmPreview()
    end
    if i.confirmBlocked then c.status=i.resource;return end
    if i.commitAt and c:now()-i.commitAt>c.config:get('insecTimeout') then self:cancel('Insec timeout');return end
    local r=c:spell(3)
    if (r.level or 0)==0 or (r.currentCd or 0)>0 then self:cancel('R cooldown / not learned');return end
    -- Native R castability is checked when R is issued. It must not discard
    -- a still-valid Q2 window while approaching or recovering from CC.
    local aim=self:geometry(i)
    if not aim then c.status='Aim away from the selected champion';return end
    if c:now()>=(i.traceAt or 0) then
        i.traceAt=c:now()+.25
        local buffs={};for _,buff in ipairs(U.buffs(i.target)) do
            if #buffs>=12 then break end
            buffs[#buffs+1]={name=buff.name,count=buff.count,expires=buff.expireTime,type=buff.type}
        end
        if c.config.capture then c:log('insec_state',{target=U.id(i.target),targetPos=U.copy(i.target.pos),origin=U.copy(myHero.pos),
             phase=i.phase,stand=U.copy(i.stand),endpoint=U.copy(i.endpoint),plan=i.resource,
             fallbackOrigin=U.copy(i.fallbackOrigin),recipient=U.id(i.recipient),recipientKind=i.recipientKind,
             used=i.used,qWaitTarget=i.qWait and U.id(i.qWait.unit),qReady=c:ready(0),qStage=c:stage(0),
             qState=Game.CanUseSpell(0),wState=Game.CanUseSpell(1),rState=Game.CanUseSpell(3),
            kickValid=self:kickValid(i),rReady=c:ready(3),wReady=c:ready(1),wStage=c:stage(1),
            wardSlot=c.wards:slot(),wardState=c.wards.pending and c.wards.pending.state,
            cursorStep=c.sdk.Cursor and c.sdk.Cursor.Step,targetBuffs=buffs,flashReason=i.flashReason}) end
    end
    if self:kickProtected(i.target) then
        i.orbwalking=true;i.plan=nil;i.resource='Waiting: spell shield / kick immunity';c.status=i.resource;return
    end
    c.status='Insec: '..i.phase..(i.locked and ' | AIM LOCKED' or ' | aiming')
    self.planner:tick(i,aim)
end
-- R > Flash: the Flash landing still sets the requested kick (aligned from there),
-- the target stays kickable and in R range, and Flash is ready and authorized.
function B:rflashValid(i)
    local c=self.ctx;local r=i and i.rflash
    if not r or not c:enemyValid(i.target) or self:kickProtected(i.target) or not self:geometry(i) then return false end
    if U.dist(myHero.pos,i.target.pos)>c.profile.rRange or U.dist(myHero.pos,r.pos)>400 or c.terrain:wall(r.pos)~=false then return false end
    if not self.planner:flashAllowed(i) or not self.planner:flashSlot(false) then return false end
    return self:aligned({pos=i.plannedTarget or i.target.pos},i.plannedEndpoint or i.endpoint,r.pos)
end
function B:startRFlash(i,step)
    local c=self.ctx
    i.rflash={pos=U.copy(step.pos),at=c:now()}
    if not self:rflashValid(i) then i.rflash=nil;return false end
    local ok,event=c.spells:r(i.target,'insec',true,function()return self:rflashValid(i),'rflash_no_longer_valid' end)
    if not ok then i.rflash=nil;return false end
    i.phase='kick';i.event=event;i.rflash.event=event
    return true
end
-- The Flash goes out only while Lee's R cast is still winding up (the kick
-- direction is decided at cast end); too late, and the Flash is not spent.
function B:rflashCasting()
    local c=self.ctx;local a=myHero.activeSpell
    return a and a.valid and U.name(a.name):find('leesinr',1,true) and U.finite(a.castEndTime)
        and a.castEndTime-c:now()>(c.latency or 0)*.5+.02 or false
end
function B:rflashTick(i)
    local c=self.ctx;local r=i.rflash
    if r.flashEvent then
        r.done=true
        if c.config.capture then c:log('insec_rflash',{target=U.id(i.target),flash=r.flashEvent.id,status=r.flashEvent.status,
            landing=r.pos,targetPos=U.copy(i.target.pos),evidence='kick direction assessed from displacement separately'}) end
        return false
    end
    if self:rflashCasting() then
        local ok,event=c.spells:flash(r.pos,'insec',function()
            if not self:rflashCasting() then return false,'r_cast_already_ended' end
            return U.dist(myHero.pos,r.pos)<=400 and c.terrain:wall(r.pos)==false,'flash_landing_invalid'
        end,true)
        if ok then r.flashEvent=event end
        return true
    end
    if c:now()-r.at>.6 or i.event.status=='cancelled' or i.event.status=='unconfirmed' then
        r.done=true
        if c.config.capture then c:log('insec_rflash_missed',{target=U.id(i.target),status=i.event.status}) end
        return false
    end
    return true
end
function B:kickHits(target,from)
    if not self.ctx:enemyValid(target) then return 0 end
    local endPos=U.toward(from or myHero.pos,target.pos,U.dist(from or myHero.pos,target.pos)+self.ctx:kickLength(target))
    local hits=1
    for _,e in ipairs(self.ctx.enemies or {}) do
        if self.ctx:enemyValid(e) and not U.same(e,target) then
            local d,t=U.segment(e.pos,target.pos,endPos)
            if t>0 and d<100+(e.boundingRadius or 65) then hits=hits+1 end
        end
    end
    return hits,endPos
end
function B:multi(target,allowReposition)
    local c=self.ctx
    if not c.config:get('comboR') or not c:ready(3) or c:combatTransit() or self.wards.pending then return false end
    if not c.config:get('multi') and not c.config:get('collateralKills') then return false end
    local now=c:now()
    if now<(self.kickSearchAt or 0) then return false end
    self.kickSearchAt=now+.08
    local plan=self.kicks:best(allowReposition~=false and now>=(self.wards.fightRetryAt or 0))
    if not plan then return false end
    plan.at=now;self.kickProposal=plan
    if plan.flash then
        -- Flash, then R from the new stand point (the existing multiTarget
        -- continuation casts R once the Flash moved Lee and the kick still pays).
        local function valid()
            if not self.kicks:flashSlot() or not c:ready(3) or c.mode~='fight' then return false,'multi_flash_unavailable' end
            local current=self.kicks:evaluate(plan.primary,plan.origin,false,true)
            return current and current.worthwhile and current.hits>=2 or false,'multi_no_longer_worthwhile'
        end
        local slot=self.kicks:flashSlot()
        local ok=slot and self.spells:submit(slot,U.copy(plan.origin),nil,'fight',{interrupt=true,delay=.05,validate=valid},{shot=U.copy(plan.origin)})
        if ok then
            self.multiTarget={target=plan.primary,untilTime=now+1.2,flash=true}
            if c.config.capture then c:log('fight_multikick_flash',{target=U.id(plan.primary),hits=plan.hits,estimatedKills=plan.kills,
                origin=plan.origin,endpoint=plan.endpoint}) end
            return true
        end
        return false
    elseif plan.ward then
        if not self:wardOpportunity(plan.primary,true) then return false end
        local function valid()
            if not self:wardOpportunity(plan.primary,true) then return false end
            local current=self.kicks:evaluate(plan.primary,plan.origin,true)
            return current and current.worthwhile and current.hits>=2 or false
        end
        if self.wards:start(plan.origin,'fight',true,nil,valid) then
            self.multiTarget={target=plan.primary,untilTime=now+1.5};if c.config.capture then c:log('fight_multikick_plan',{
                target=U.id(plan.primary),hits=plan.hits,estimatedKills=plan.kills,secondaryKills=plan.secondaryKills,
                origin=plan.origin,endpoint=plan.endpoint,confidence=c.config:get('mechanicsVerified') and 'measured profile' or 'profile estimate'}) end
            return true
        end
    elseif self:castFightR(plan.primary,true) then
        if c.config.capture then c:log('fight_multikick_cast',{target=U.id(plan.primary),hits=plan.hits,estimatedKills=plan.kills,
            secondaryKills=plan.secondaryKills,endpoint=plan.endpoint}) end;return true
    end
    return false
end
function B:defense()
    local c=self.ctx
    if not c.config:get('idleDefense') or self.wards.pending or self.insec or c:combatTransit() then return false end
    if c.config:get('reserveW') then return c.emergencyShield:tick() or self:shieldThreat() end
    if c:stage(1)~=1 or not c:ready(1) then return false end
    if U.hp(myHero)<=c.config:get('shieldHP') and c:threats(myHero.pos,850)>0 then
        return self.spells:w(myHero,'defense',true)
    end
    if c:stage(1)==1 then
        for _,a in ipairs(c.allies or {}) do
            if U.valid(a) and U.dist(myHero.pos,a.pos)<=c.profile.wRange
                and U.hp(a)<=c.config:get('allyShieldHP') and c:threats(a.pos,700)>0 and not c:underTurret(a.pos)
                then return self.spells:w(a,'defense',true) end
        end
    end
    return false
end
-- W shield value (Normal, wiki V26.12): 60-240 + 80% AP. Classic is unverified: nil.
function B:shieldValue()
    local c=self.ctx;local p=c.profile;local rank=c:spell(1).level or 0
    if not p.wShield or rank<1 then return nil end
    return (p.wShield[math.min(rank,#p.wShield)] or 0)+(p.wShieldAP or 0)*(myHero.ap or 0)
end
-- Damage a unit is predicted to take within `horizon` from attributable incoming
-- attacks (the SDK health prediction's incoming-attack index, melee included).
function B:incoming(unit,horizon)
    local c=self.ctx;local now=U.finite(unit.health) and unit.health or 0
    return math.max(0,now-c:healthAt(unit,horizon)),now+(unit.allShield or 0)+(unit.shieldAD or 0)+(unit.shieldAP or 0)
end
-- Keep W for jumps (reserveW) but shield Lee or an allied champion in W range when
-- attributable damage within 0.5 s reaches the shield value or would kill. Never
-- while an insec, a wardjump/chase or a held mobility key owns W.
function B:shieldThreat()
    local c=self.ctx
    if not c.config:get('idleDefense') or c:stage(1)~=1 or not c:ready(1) or c.actions:pendingCast(1)
        or self.wards.pending or self.insec or c:combatTransit() or c.input:held('wardKey')
        or c.input:held('cursorKey') or c.input:held('allyKey') or c:dash() then return false end
    local value=self:shieldValue()
    local function threatened(unit)
        if not U.valid(unit) or unit.team~=myHero.team or (not U.same(unit,myHero) and U.dist(myHero.pos,unit.pos)>c.profile.wRange) then return false end
        if c:threats(unit.pos,1100)==0 then return false end
        local damage,effective=self:incoming(unit,.5)
        if damage<=0 then return false end
        return damage>=effective or value and damage>=value or false,damage
    end
    local best,most
    for _,unit in ipairs({myHero,unpack(c.allies or {})}) do
        if U.same(unit,myHero) or unit.type==myHero.type then
            local yes,damage=threatened(unit)
            if yes and (not most or damage>most) then best,most=unit,damage end
        end
    end
    if not best then return false end
    local ok=self.spells:w(best,'defense',true,nil,function()
        if self.wards.pending or self.insec then return false,'w_reserved_for_jump' end
        return threatened(best)==true,'incoming_damage_gone'
    end)
    if ok and c.config.capture then c:log('shield_threat_requested',{target=U.id(best),name=best.charName,damage=most,shield=value}) end
    return ok
end
-- Largest reach of an enabled kill-secure ability (cheap gate for farming modes).
function B:killReach()
    local c=self.ctx;local reach=0
    if c.config:get('killQ2') and c:stage(0)==2 then reach=c.profile.q2Range end
    if c.config:get('killQ') and c:stage(0)==1 then reach=math.max(reach,c.profile.qRange) end
    if c.config:get('killE') then reach=math.max(reach,c.profile.eRange) end
    if c.config:get('killR') then reach=math.max(reach,c.profile.rRange) end
    return reach
end
-- Kill secure while LaneClear, LastHit or Harass is held: same switches, only
-- when an enemy champion stands inside the largest enabled reach.
function B:farmKillsteal()
    local c=self.ctx;local reach=self:killReach()
    if reach<=0 then return false end
    for _,enemy in ipairs(c.enemies or {}) do
        if c:enemyValid(enemy) and U.dist(myHero.pos,enemy.pos)<=reach then return self:killsteal(false) end
    end
    return false
end
-- R on an enemy in R range whose channel the host flags as interruptible and
-- that outlasts R's cast; not while a held insec or a jump reserves R.
function B:interruptChannel()
    local c=self.ctx
    if not c.config:get('interruptR') or not c:ready(3) or c.actions:pendingCast(3) or self.insec or self.wards.pending
        or c.input:held('cursorKey') or c.input:held('allyKey') or c:dash() then return false end
    local now=c:now();local impact=.25+(c.latency or 0)+.05
    for _,enemy in ipairs(c.enemies or {}) do
        local cast=enemy.activeSpell
        if cast and cast.valid and cast.isChanneling==true and cast.isInterruptible==true and cast.isStopped~=true
            and cast.isAutoAttack~=true and U.finite(cast.castEndTime) and cast.castEndTime>now+impact
            and c:enemyValid(enemy) and U.dist(myHero.pos,enemy.pos)<=c.profile.rRange and not self:kickProtected(enemy) then
            local name=cast.name
            local ok=self.spells:r(enemy,'interrupt',true,function()
                local current=enemy.activeSpell
                return current and current.valid and current.name==name and current.isChanneling==true and current.isStopped~=true
                    and U.finite(current.castEndTime) and current.castEndTime>c:now()+.25,'channel_ended'
            end)
            if ok then if c.config.capture then c:log('interrupt_r',{target=U.id(enemy),spell=name,left=cast.castEndTime-now}) end;return true end
        end
    end
    return false
end
-- Flee: wardjump toward the cursor (an existing jumpable unit first), only with
-- W1 ready and an enemy champion within 1200. Never through walls here.
function B:flee()
    local c=self.ctx;local w=self.wards
    if not c.config:get('fleeJump') or w.pending or self.insec or c:dash() or not w:available() then return false end
    local danger=false
    for _,enemy in ipairs(c.enemies or {}) do if c:enemyValid(enemy) and U.dist(myHero.pos,enemy.pos)<=1200 then danger=true;break end end
    if not danger or not c.aim then return false end
    local range=w:placementRange()
    local aim=U.dist(myHero.pos,c.aim)<=range and U.copy(c.aim) or U.toward(myHero.pos,c.aim,range)
    if U.dist(myHero.pos,aim)<200 then return false end
    local unit=w:reusable(myHero.pos,aim,250,.7)
    -- Placement needs Flee still held (the mode reads ward_pending once the jump starts).
    local held=function()return c.config:get('fleeJump') and (c.mode=='orbwalker' or c.app~=nil and c.app:orbwalkerMode('FLEE')) or false end
    if unit then return w:start(unit.pos,'flee',true,nil,held) end
    if not w:slot() or c.terrain:wall(aim)~=false then return false end
    return w:start(aim,'flee',true,nil,held,function()return true end)
end
-- Harass dash in and out (opt-in): after our Q1 marked the champion, Q2 in, one
-- attack or E1, then W1 back to an allied unit or ward that is at least 400 from
-- the target and within W range of the landing. Each step is its own request.
function B:diveUnit(target)
    local c=self.ctx;local best,score
    local units={};for _,u in ipairs(self.wards:objects()) do units[#units+1]=u end
    for _,u in ipairs(c.allies or {}) do units[#units+1]=u end
    for _,u in ipairs(c.minions or {}) do if u.team==myHero.team then units[#units+1]=u end end
    for _,u in ipairs(units) do
        if self.wards:jumpableUnit(u) then
            local d=U.dist(u.pos,target.pos)
            if d>=400 and d<=c.profile.wRange-50 and not c:underTurret(u.pos) then
                local value=-U.dist(u.pos,myHero.pos)
                if not score or value>score then best,score=u,value end
            end
        end
    end
    return best
end
function B:diveTick(target)
    local c=self.ctx;local d=self.dive;local now=c:now()
    if d then
        if not c:enemyValid(d.target) or now>d.untilTime or c.mode~='harass' or not c.config:get('harassDive') then self.dive=nil;return false end
        c.attackTarget=d.target
        if d.phase=='dash' then
            if c:dash() or c:combatTransit() then return true end
            if U.dist(myHero.pos,d.target.pos)<=c:attackRange(d.target)+80 then d.phase='hit';d.hitAt=now
            elseif now-d.at>1.2 then self.dive=nil;return false end
            return true
        end
        if d.phase=='hit' then
            if c.config:get('harassE') and c:stage(2)==1 and c:ready(2) and U.dist(myHero.pos,d.target.pos)<=c.profile.eRange
                and not d.eSent then
                if self.spells:e(d.target,'harass') then d.eSent=true;d.outAt=now+.3 end
                return true
            end
            if now<(d.outAt or d.hitAt+math.max(.35,c:windup()+.15)) then return true end
            d.phase='out'
        end
        if d.phase=='out' then
            local unit=d.unit
            if not c.wards:jumpable(unit) then unit=self:diveUnit(d.target) end
            if not unit or not c.wards:jumpable(unit) or c:stage(1)~=1 or not c:ready(1) then self.dive=nil;return false end
            if self.spells:w(unit,'escape',true) then
                if c.config.capture then c:log('harass_dive_out',{target=U.id(d.target),unit=U.id(unit)}) end
                self.dive=nil
            end
            return true
        end
        return false
    end
    if not c.config:get('harassDive') or not target or not c:mark(target) or c:stage(0,target)~=2 or not c:ready(0)
        or c:stage(1)~=1 or not c:ready(1) or self.wards.pending then return false end
    if c:underTurret(target.pos) then return false end
    local cost=(c:spell(0).mana or 0)+(c:spell(1).mana or 0)+(c:ready(2) and c:stage(2)==1 and (c:spell(2).mana or 0) or 0)
    if (myHero.mana or 0)<cost then return false end
    local unit=self:diveUnit(target);if not unit then return false end
    local ok=self.spells:q2(target,'harass',false,true,nil,function()
        if not U.valid(unit) or U.dist(unit.pos,target.pos)>c.profile.wRange-50 or c:underTurret(target.pos) then return false,'dive_exit_lost' end
        return c:stage(1)==1 and c:ready(1),'dive_w_unavailable'
    end,'dive')
    if ok then
        self.dive={target=target,unit=unit,phase='dash',at=now,untilTime=now+3}
        if c.config.capture then c:log('harass_dive_in',{target=U.id(target),unit=U.id(unit)}) end
    end
    return ok
end
function B:killsteal(inFight)
    local c=self.ctx;local lock=c:locked();local candidates={}
    if c:combatTransit() then return false end
    -- Q2's target-specific stage probe can update callback knowledge even for
    -- an out-of-range selected target. Preserve that path when it is enabled.
    local reach=math.huge
    if not c.config:get('killQ2') then
        reach=-1
        if c.config:get('killQ') then reach=math.max(reach,c.profile.qRange) end
        if c.config:get('killE') then reach=math.max(reach,c.profile.eRange) end
        if c.config:get('killR') then reach=math.max(reach,c.profile.rRange) end
    end
    -- Spell data and readiness are sampled once for this pass: nothing below sends
    -- input before the candidates are sorted, so every enemy sees the same values.
    local d0,d2;local readiness={}
    local function ready(slot)local r=readiness[slot];if r==nil then r=c:ready(slot)and true or false;readiness[slot]=r end;return r end
    for _,target in ipairs(lock and {lock} or c.enemies or {}) do
        if (reach==math.huge or U.valid(target) and U.dist(myHero.pos,target.pos)<=reach)
            and c:enemyValid(target) then
            local distance=U.dist(myHero.pos,target.pos)
            local function hp(slot)return U.typedHP(target,slot==2 and 'magic' or 'physical')+c.config:get('combatDamageMargin')+(target.hpRegen or 0)*.8 end
            local function add(slot,stage,delay,cost)
                -- A Q2 that kills needs only its own finisher switch: the Combo Q2 switch is about dashing in without a kill.
                if (not inFight or slot==0 and stage==2 or c.config:get(({[0]='comboQ',[2]='comboE',[3]='comboR'})[slot]))
                    and ready(slot) and c:combatDamage(slot,target,stage)>=hp(slot) then
                    candidates[#candidates+1]={slot=slot,stage=stage,target=target,delay=delay,cost=cost}
                end
            end
            if c.config:get('killE') then d2=d2 or c:spell(2) end
            if c.config:get('killQ') or c.config:get('killQ2') then d0=d0 or c:spell(0) end
            if c.config:get('killE') and c:stage(2,nil,d2)==1 and distance<=c.profile.eRange then add(2,1,.25,1) end
            if c.config:get('killQ') and c:stage(0,nil,d0)==1 and distance<=c.profile.qRange then add(0,1,.25+distance/c.profile.qSpeed,1) end
            if c.config:get('killQ2') and c:stage(0,target,d0)==2 and c:mark(target,d0.name) and distance<=c.profile.q2Range then add(0,2,.15+distance/1800,2) end
            if c.config:get('killR') and distance<=c.profile.rRange then add(3,1,.25,4) end
        end
    end
    table.sort(candidates,function(a,b)
        local aa,bb=math.floor(a.delay/.08+.5),math.floor(b.delay/.08+.5)
        if aa~=bb then return aa<bb end
        if a.cost~=b.cost then return a.cost<b.cost end
        return a.delay<b.delay
    end)
    local attempted={}
    local function submitCheaper(candidate)
        if attempted[candidate] then return false end
        attempted[candidate]=true
        if candidate.slot==2 then return self.spells:e(candidate.target,'killsteal') end
        if candidate.stage==2 then return self.spells:q2(candidate.target,'killsteal',false,true) end
        return self.spells:q1(candidate.target,'killsteal',false)
    end
    for _,candidate in ipairs(candidates) do
        local t=candidate.target;local ok
        if candidate.slot==2 then ok=submitCheaper(candidate)
        elseif candidate.slot==3 then
            -- A few milliseconds of projectile travel must not spend R before
            -- trying an authorized, timely lethal spell on this same target.
            -- Use the real submission path: a refusal is not a promised finish.
            if c.config:get('comboConserveR') then
                local horizon=self.tactics:window(t)
                for _,alternative in ipairs(candidates) do
                    if alternative.target==t and alternative.slot~=3 and alternative.delay<=horizon then
                        if submitCheaper(alternative) then return true end
                    end
                end
            end
            local policy=inFight and 'fight' or 'killsteal'
            if self:allowFinisherR(t,policy) then ok=self.spells:r(t,'killsteal',false,function()return self:allowFinisherR(t,policy)end) end
        else ok=submitCheaper(candidate) end
        if ok then return true end
    end
    return false
end
-- lethal: the R + Q2 follow kills, so it is a planned lethal sequence and needs
-- no "Q2 even when it does not kill" consent (LeeSin-4).
function B:followAllowed(target,lethal)
    local c=self.ctx
    if not (c.config:get('comboQ2') or lethal) or not c.config:get('comboKickFollow') or not c:mark(target)
        or c:stage(0,target)~=2 or not c:ready(0) or c:markLeft(target)<math.max(.5,c.latency+.35)
        or (myHero.mana or 0)<(c:spell(0).mana or 0)+(c:spell(3).mana or 0) then return false end
    local _,endpoint=self:kickHits(target)
    return not c.config:get('q2Safety') or not c:underTurret(endpoint)
end
function B:cheapFinish(target,owner)
    local c=self.ctx
    if not c.config:get('comboConserveR') then return false,'conservation_disabled' end
    local pending,reason=self.tactics:pendingFinish(target)
    if pending then self.finishAssessment=nil;return true,reason end
    local result=self.tactics:assess(target,owner or 'fight')
    self.finishAssessment=result
    if result.lethal then
        local now=c:now();local promise=self.finishPromise
        if promise and promise.target==U.id(target) and target.health>=promise.health-.5 then
            if now>promise.untilTime then return false,'cheaper_plan_made_no_damage_progress' end
        else
            self.finishPromise={target=U.id(target),health=target.health,
                untilTime=now+result.lethal.t+c.latency+math.max(.08,c.jitter*2)}
        end
    else self.finishPromise=nil end
    return result.lethal~=nil,result.lethal and (result.lethal.path or 'observed_attack_lethal') or 'no_timely_cheaper_finish'
end
function B:allowFinisherR(target,owner)
    local c=self.ctx;local cheaper,reason=self:cheapFinish(target,owner)
    if c.config.capture then c:trace('r_finisher_decision',{target=U.id(target),name=target.charName,owner=owner,
        allowed=not cheaper,reason=reason,health=target.health,physicalHP=U.typedHP(target,'physical'),
        distance=U.dist(myHero.pos,target.pos),pendingAA=c:pendingAttackDamage(target,.25),
        aaDamage=c:aaDamage(target),qDamage=c:combatDamage(0,target,1),qReady=c:ready(0),qStage=c:stage(0,target),
        eReady=c:ready(2),eStage=c:stage(2),conserve=c.config:get('comboConserveR'),
        horizon=self.finishAssessment and self.finishAssessment.horizon,
        expansions=self.finishAssessment and self.finishAssessment.expanded,
        finishTime=self.finishAssessment and self.finishAssessment.lethal and self.finishAssessment.lethal.t},
        tostring(U.id(target))..':'..tostring(cheaper)..':'..tostring(reason),.4) end
    return not cheaper,cheaper and 'cheaper_finish_available' or nil
end
function B:castFightR(target,multiple,purpose)
    local c=self.ctx;purpose=multiple and 'multi' or purpose or 'execute'
    local follow=self:followAllowed(target,purpose=='follow' and self:kickBurst(target))
    local followQ1=purpose=='followQ1'
    local function valid()
        if multiple then
            local plan=self.kicks:evaluate(target,myHero.pos,false)
            return plan and plan.hits>=2 and plan.worthwhile or false,'multi_no_longer_worthwhile'
        end
        if not self:allowFinisherR(target,'fight') then return false,'cheaper_finish_available' end
        local damage=c:combatDamage(3,target)
        if purpose=='follow' then
            local burst=self:kickBurst(target)
            if not self:followAllowed(target,burst) then return false,'q2_follow_unavailable' end
            return burst or c.config:get('comboQ2') and self:isolateUseful(target),'kick_follow_no_longer_useful'
        end
        if followQ1 then
            return self:kickQ1Allowed(target) and self:kickQ1Burst(target),'kick_q1_follow_no_longer_lethal'
        end
        return damage>=U.typedHP(target,'physical')+10,'r_no_longer_lethal'
    end
    local ok,event=self.spells:r(target,'fight',false,valid)
    if ok and follow then
        self.rFollow={target=target,event=event,untilTime=self.ctx:now()+math.min(2,self.ctx:markLeft(target)),
            targetOrigin=U.copy(target.pos),health=target.health,lethal=purpose=='follow' and self:kickBurst(target) or nil}
    elseif ok and followQ1 then
        -- R > Q1 > Q2 on an unmarked target: the kicked body flies up to the kick
        -- length over 0.8 s and is airborne, so a Q1 along that path lands.
        self.rFollow={target=target,event=event,untilTime=self.ctx:now()+2.2,q1=true,lethal=true,
            targetOrigin=U.copy(target.pos),health=target.health}
    end
    if ok and c.config.capture then c:log('fight_kick_requested',{request=event.id,target=U.id(target),
        pos=U.copy(target.pos),purpose=purpose,health=target.health,physicalHP=U.typedHP(target,'physical'),
        rDamage=c:combatDamage(3,target),markLeft=c:markLeft(target),follow=follow,
        multiMinimum=multiple and c.config:get('multiHits') or nil}) end
    return ok,event
end
-- R damage plus the Q2 that follows it (Q2 scales with the health R leaves).
function B:kickBurst(target)
    local c=self.ctx;local rDamage=c:combatDamage(3,target)
    local after=math.max(0,target.health-math.max(0,rDamage-(target.allShield or 0)-(target.shieldAD or 0)))
    return rDamage+c:combatDamage(0,target,2,after)>=U.typedHP(target,'physical')+15
end
-- R first, then Q1 onto the kicked (unmarked) target, then Q2: only when that
-- whole sequence kills and R alone does not.
function B:kickQ1Allowed(target)
    local c=self.ctx
    return c.config:get('comboKickFollow') and c.config:get('comboQ') and c.config:get('comboR')
        and c:enemyValid(target) and not c:mark(target) and c:stage(0)==1 and c:ready(0) and c:ready(3)
        and not self.spells:q1Reservation(target)
        and (myHero.mana or 0)>=(c:spell(0).mana or 0)*2+(c:spell(3).mana or 0)
        and U.dist(myHero.pos,target.pos)<=c.profile.rRange or false
end
function B:kickQ1Burst(target)
    local c=self.ctx;local hp=U.typedHP(target,'physical')
    local rDamage=c:combatDamage(3,target)
    if rDamage>=hp+10 then return false end -- R alone kills: the execute path owns it.
    local q1=c:combatDamage(0,target,1)
    if q1<=0 then return false end
    local after=math.max(0,target.health-math.max(0,rDamage+q1-(target.allShield or 0)-(target.shieldAD or 0)))
    local _,endpoint=self:kickHits(target)
    if c.config:get('q2Safety') and c:underTurret(endpoint) then return false end
    return rDamage+q1+c:combatDamage(0,target,2,after)>=hp+15
end
-- After the observed kick: Q1 onto the flying body (fresh prediction and the
-- ordinary collision check on the resolved ray), then the Q2 path below.
function B:followKickQ1(f)
    local c=self.ctx
    if c:mark(f.target) and c:stage(0,f.target)==2 then f.q1=nil;return false end
    if f.event.status~='observed' and f.event.status~='completed' then return true end
    if f.q1Event then
        local gone=f.q1Event.cancelled or f.q1Event.status=='cancelled' or f.q1Event.status=='rejected'
        if gone and c:ready(0) and c:stage(0)==1 then f.q1Event=nil else return true end
    end
    if c:stage(0)~=1 or not c:ready(0) then return true end
    local ok,event=self.spells:q1(f.target,'fight',false)
    if ok then f.q1Event=event;if c.config.capture then c:log('fight_kick_q1',{target=U.id(f.target),distance=U.dist(myHero.pos,f.target.pos)}) end end
    return true
end
function B:followKick()
    local c=self.ctx;local f=self.rFollow;if not f then return false end
    local lock=c:locked()
    local active=myHero.activeSpell
    local q2Used=active and active.valid and U.name(active.name):find('leesinqtwo',1,true)
    if f.q1 and c:enemyValid(f.target) and c:now()<=f.untilTime and not f.event.cancelled and f.event.status~='unconfirmed'
        and not (lock and not U.same(lock,f.target)) and c.config:get('comboR') then
        c.attackTarget=f.target
        if self:followKickQ1(f) then return true end
    end
    if not (c.config:get('comboQ2') or f.lethal) or not c.config:get('comboKickFollow') or not c.config:get('comboR')
        or lock and not U.same(lock,f.target) or not c:enemyValid(f.target) or c:now()>f.untilTime
        or not c:mark(f.target) or q2Used or c:stage(0,f.target)~=2 or f.event.status=='unconfirmed' or f.event.cancelled then
        if c.config.capture then c:log('fight_kick_cancelled',{target=U.id(f.target),event=f.event.status}) end;self.rFollow=nil;return false
    end
    c.attackTarget=f.target
    if f.event.status=='observed' or f.event.status=='completed' then
        local moved=f.targetOrigin and U.dist(f.target.pos,f.targetOrigin)>60
        local elapsed=c:now()-(f.event.observedAt or f.event.at or c:now())
        -- Follow the confirmed kick before its full displacement puts Q2 out
        -- of range. Expiry is urgent, but never bypasses R acknowledgement.
        if moved or elapsed>=.25 or c:markLeft(f.target)<.4 then
            if self.spells:q2(f.target,'fight',false,true,nil,nil,f.lethal and 'finisher' or nil) then
                if c.config.capture then c:log('fight_kick_follow',{target=U.id(f.target),delay=elapsed,moved=moved,
                    distance=U.dist(myHero.pos,f.target.pos),markLeft=c:markLeft(f.target)}) end
                self.rFollow=nil
            end
        end
    end
    return true
end
function B:fastBurst(target)
    if not self.ctx.config:get('comboBurst') then return false end
    local horizon=self.tactics:window(target)
    local finish=self.tactics:assess(target,'fight',math.min(.8,horizon)).lethal
    return finish~=nil and finish.first~=nil and finish.first~='AA'
end
-- Draw callback can finish a confirmed ward landing without waiting for the
-- next expensive planning tick. No graph search and no uncancellable R queue.
function B:fastKick()
    local c=self.ctx;local i=self.insec
    if not i or i.preview or i.confirmBlocked or i.phase=='kick' or i.rflash or i.flight or i.qWait
        or c:blocked() or c:dash() or c.wards.pending or c.input:previewHeld()
        or not c.input:held(i.kind=='cursor' and 'cursorKey' or 'allyKey')
        or (c:spell(3).level or 0)==0 or not c:ready(3) or c.actions:pendingCast(3)
        or i.commitAt and c:now()-i.commitAt>c.config:get('insecTimeout')
        or not U.valid(i.target) or U.dist(myHero.pos,i.target.pos)>c.profile.rRange then return false end
    if not self:geometry(i) or not self:kickValid(i) then return false end
    local ok,event=c.spells:r(i.target,'insec',true)
    if ok then i.phase='kick';i.event=event end
    return ok
end
function B:passiveHold(target)
    local c=self.ctx
    if not c.config:get('comboPassive') or not c.clear:weaving() or U.dist(myHero.pos,target.pos)>c:attackRange(target) then return false end
    local a=c.sdk.Attack;local cycle=a.GetAnimation and a:GetAnimation() or 1
    local wait=a.IsReady and not a:IsReady() and math.max(0,(a.ServerStart or c:now())+cycle-c:now()) or 0
    local impact=wait+c:windup()+c.latency*.5
    if impact>c.clear.passiveUntil-c:now() then return false end
    if c:mark(target) and impact+.65>=c:markLeft(target) then return false end
    if self:fastBurst(target) then return false end
    if target.GetPrediction and target.pathing and target.pathing.hasMovePath then
        local ok,p=pcall(target.GetPrediction,target,math.huge,impact)
        if not ok or not p or U.dist(myHero.pos,p)>c:attackRange(target) then return false end
    end
    return true
end
function B:chaseMotion(target)
    local now=self.ctx:now();local lock=0;local prediction=_G.OrbamaPrediction
    if prediction and type(prediction.GetImmobileDuration)=='function' then
        local ok,duration=pcall(prediction.GetImmobileDuration,prediction,target)
        if ok and U.finite(duration) then lock=math.max(0,duration) end
    else
        -- These types are defined by the installed Orbama runtime, in both maps.
        for _,buff in ipairs(U.buffs(target)) do
            if buff.type==5 or buff.type==12 or buff.type==25 or buff.type==30 or buff.type==35 then
                lock=math.max(lock,(U.buffEnd(buff) or now)-now)
            end
        end
    end
    local origin=U.copy(target.pos);local path=target.pathing
    local endpoint=path and path.hasMovePath and path.endPos
    local speed=U.finite(target.ms) and math.max(0,target.ms) or 0
    if not endpoint or not U.finite(endpoint.x) or not U.finite(endpoint.z) then speed=0;endpoint=origin end
    local length=U.dist(origin,endpoint)
    local function at(delay)
        return U.toward(origin,endpoint,math.min(length,speed*math.max(0,delay-lock)))
    end
    return at,lock,speed
end
function B:chaseDecision(target)
    local c=self.ctx;local at,lock,speed=self:chaseMotion(target)
    if target.pathing and target.pathing.isDashing then return false,nil,'Wait for enemy dash destination' end
    local ownSpeed=U.finite(myHero.ms) and math.max(1,myHero.ms) or 350
    local range=c:attackRange(target);local wait=c.config:get('comboWalkWait')/1000
    local arrival=self.tactics:wardArrival()
    local future=at(arrival);local distance=U.dist(myHero.pos,future)
    local landing=U.toward(myHero.pos,future,math.max(0,distance-math.min(100,range*.5)))
    local reason
    if c:underTurret(future) or c:underTurret(at(arrival+.6)) then reason='Target escaping into turret range'
    elseif U.dist(myHero.pos,landing)>self.wards:range() then reason='Predicted landing outside ward range'
    else
        local walkTime=math.huge
        -- A bounded local intercept estimate follows the current path and its
        -- endpoint. Recomputed before resource spending; no ground detour.
        local horizon=math.max(wait,arrival+c.config:get('comboWardGain')/1000)
        for n=1,16 do
            local dt=horizon*n/16
            if U.dist(myHero.pos,at(dt))<=range+ownSpeed*dt then walkTime=dt;break end
        end
        if walkTime<=wait then reason='Walking reaches attack range soon'
        elseif walkTime-arrival<c.config:get('comboWardGain')/1000 then reason='Wardjump saves too little time' end
        if c.config.capture then c:trace('combo_chase',{target=U.id(target),reason=reason or 'Ward saves approach time',
            ownSpeed=ownSpeed,targetSpeed=speed,immobile=lock,walkTime=walkTime<math.huge and walkTime or nil,
            arrival=arrival,landing=landing,future=future},tostring(U.id(target)),.4) end
    end
    return not reason,landing,reason
end
function B:gapclose(target)
    local c=self.ctx
    -- A blocked/temporarily reserved Q2 must not fall through to a ward entry.
    -- Preserving a marked Q for R-follow is an explicit optional playstyle.
    if not c.config:get('comboWardPreserveQ') and c:stage(0,target)==2 and c:mark(target) then return false end
    local flight,phase,remaining=self.spells:q1Reservation(target)
    if flight then
        if c.config.capture then c:trace('combo_chase',{target=U.id(target),reason=phase=='queued'
                and 'Q1 queued; preserve ward' or 'Wait for own Q1 impact before spending a ward',
            request=flight.event.id,phase=phase,remaining=remaining},tostring(U.id(target)),.4) end
        return false
    end
    if not c.config:get('comboWard') or not c.config:get('comboW') or not self.wards:available()
        or self.wards.pending or U.hp(myHero)<=c.config:get('shieldHP') then return false end
    local distance=U.dist(myHero.pos,target.pos);local stop=math.min(100,c:attackRange(target)*.5)
    if distance<=c:attackRange(target)+60 or distance-stop>self.wards:range() then return false end
    if c.config:get('comboChaseE2') and c.config:get('comboE2') and c:stage(2)==2 and c:ready(2)
        and c.spells:e(target,'fight') then return true end
    if not self:wardOpportunity(target,false) then return false end
    local allowed,landing=self:chaseDecision(target)
    if not allowed then return false end
    if c:underTurret(landing) or c.terrain:wall(landing)~=false then
        if c.config.capture then c:trace('combo_chase_refused',{target=U.id(target),landing=landing,
            reason=c:underTurret(landing) and 'landing under turret' or c.terrain:wall(landing)==nil and 'terrain unknown at landing' or 'landing in a wall'},
            tostring(U.id(target)),.4) end
        return false
    end
    local started=self.wards:start(landing,'fight',true,nil,function()
        if not self:wardOpportunity(target,false) or U.dist(myHero.pos,target.pos)<=c:attackRange(target)+60 then return false end
        local useful,newLanding=self:chaseDecision(target)
        return useful and U.dist(newLanding,landing)<100 and not c:underTurret(landing)
    end,function()
        -- The ward is already spent. Re-evaluating whether to buy that same
        -- approach again can strand the follow-up as soon as a slow expires.
        if not c:enemyValid(target) then return false,'Chase target unavailable' end
        if c:underTurret(landing) then return false,'Chase landing under turret' end
        local at=self:chaseMotion(target)
        local future=at(c.metrics.wardDashDuration or c.config:get('insecDashEstimate')/1000)
        if U.dist(landing,future)>c:attackRange(target)+60 then return false,'Chase target left ward landing' end
        if U.dist(myHero.pos,target.pos)<=c:attackRange(target) then return false,'Target already in attack range' end
        return true
    end)
    if not started and c.config.capture then c:trace('combo_chase_refused',{target=U.id(target),landing=landing,
        reason=self.wards.refused or 'unknown',distance=U.dist(myHero.pos,landing),range=self.wards:range()},tostring(U.id(target)),.4) end
    return started
end
-- Evidence that Q2 would reach the champion we marked although it is out of
-- sight now: our own Q is in its second stage (so a mark of ours exists), no
-- visible unit carries it, the remembered mark has not run out, and that
-- champion is still alive and hidden. Position and safety use the last seen
-- point: never under an enemy turret, never from low health.
function B:hiddenMarkValid(m)
    local c=self.ctx;local now=c:now()
    if not m or not m.id or now>=m.expires-.1 or now-m.at>3 or c:stage(0)~=2 or c:dash() then return false end
    if U.dist(myHero.pos,m.pos)>c.profile.q2Range-100 or c:underTurret(m.pos) or c:underTurret(myHero.pos)
        or U.hp(myHero)<=c.config:get('shieldHP') then return false end
    local unit
    for _,hero in ipairs(c.heroes or {}) do if U.id(hero)==m.id then unit=hero;break end end
    if not unit or unit.dead or unit.valid==false or unit.visible~=false then return false end
    for _,list in ipairs({c.enemies or {},c.minions or {}}) do
        for _,other in ipairs(list) do
            if other.team~=myHero.team and U.dist(myHero.pos,other.pos)<=c.profile.q2Range+200 and U.valid(other) and c:mark(other) then return false end
        end
    end
    return true
end
function B:hiddenQ2()
    local c=self.ctx;local m=c.qMarkSeen
    if not m or not c.config:get('comboQ2') or not c:ready(0) or not self:hiddenMarkValid(m) then return false end
    return self.spells:q2Hidden(m,'fight')
end
function B:wardOpportunity(target,multiple)
    local c=self.ctx
    if c:combatTransit() or not c:enemyValid(target) or c:mark(target) then return false end
    if self.spells:q1Reservation(target) then return false end
    if not multiple and c.config:get('comboQ') and c:ready(0) and c:stage(0)==1 then
        local aim=self.spells:predict(target)
        if aim and #self.spells:blockers(target,aim)==0 and not self.spells:projectileWall(aim) then return false end
    end
    return true
end
function B:harass(owner)
    local c=self.ctx;owner=owner or 'harass'
    if c:combatTransit() or self.wards.pending then return false end
    if owner=='harass' and self:diveTick(nil) then return true end
    local target=c:target(c.profile.qRange);if not target then return false end
    c.attackTarget=target
    if owner=='harass' and self:diveTick(target) then return true end
    if self:rotation(target,owner) then return true end
    if c.config:get('harassR') and not self:cheapFinish(target,owner) then return self.spells:r(target,owner) end
    return false
end
function B:rotation(target,owner,options)
    local horizon=self.tactics:window(target)
    options=options or {}
    local result=self.tactics:assess(target,owner,math.min(options.horizon or horizon,horizon),options)
    local plan=result.lethal or result.best
    if not plan then
        -- The survival horizon limits committed melee/finisher sequences. A
        -- ranged poke can be launched now and finish travelling after we leave.
        -- Keep this fallback out of lethal-R comparisons and all gapclosers.
        if owner=='harass' and result.model and result.model.lookup.Q1 then
            self.spells:q1Status(target,owner,'harass_projectile_beyond_plan_horizon')
            return self.spells:q1(target,owner,false)
        end
        return false
    end
    if self.ctx.config.capture then self.ctx:trace('combat_plan',{owner=owner,target=U.id(target),
        path=plan.path,first=plan.first,finish=plan.hp<=0,time=plan.t,horizon=result.horizon,
        conditional=plan.conditional,estimated=result.estimated,expanded=result.expanded},tostring(U.id(target))..':'..tostring(plan.first),.5) end
    -- The orbwalker remains the sole AA dispatcher. Future actions are never
    -- enqueued as a fixed macro: observe and rebuild after each actual action.
    if not plan.first or plan.first=='AA' then return true end
    return self.tactics:cast(plan.first,target,owner,result.model)
end
function B:isolateUseful(target)
    if not self.ctx.config:get('comboIsolate') then return false end
    local _,endpoint=self:kickHits(target);local before,after=math.huge,math.huge
    for _,enemy in ipairs(self.ctx.enemies or {}) do
        if not U.same(enemy,target) and self.ctx:enemyValid(enemy) then
            before=math.min(before,U.dist(target.pos,enemy.pos));after=math.min(after,U.dist(endpoint,enemy.pos))
        end
    end
    return before<650 and after>before+300
end
function B:fight()
    local c=self.ctx;local target=c:target(c.profile.q2Range)
    local focus=c.attackFocus
    if focus and c:now()-focus.at<c:windup()+.1 and focus.selected==c:locked() and c:enemyValid(focus.target)
        and U.dist(myHero.pos,focus.target.pos)<=c.profile.q2Range then target=focus.target end
    c.attackTarget=target;c.moveTarget=c.aim
    if c:combatTransit() or self.wards.pending then return end
    if self:followKick() then return end
    if self.multiTarget then
        local continuation=self.kicks:evaluate(self.multiTarget.target,myHero.pos,false)
        if not c.config:get('comboR') or c:now()>self.multiTarget.untilTime or not continuation then self.multiTarget=nil
        elseif continuation.worthwhile and self:castFightR(self.multiTarget.target,true) then self.multiTarget=nil;return end
    end
    if self:killsteal(true) then return end
    if self:multi(target) then return end
    -- The marked champion stepped out of sight: Q2 follows it while the mark lasts.
    if (not target or not c:mark(target)) and self:hiddenQ2() then return end
    if not target then return end
    c.clear:observe()
    local lead=math.max(.3,c.latency*.5+c.jitter*2+.15)
    if c.config:get('comboQ2') and c:stage(0)==2 and c:mark(target) and c:markLeft(target)<lead then
        if self.spells:q2(target,'fight',false) then return end
    end
    for _,slot in ipairs({1,2}) do
        if c.config:get(slot==1 and 'comboW2' or 'comboE2') and c:stage(slot)==2 and c.clear.windows[slot]
            and c.clear.windows[slot]-c:now()<lead then
            local ok
            if slot==1 then ok=self.spells:w(myHero,'fight') else ok=self.spells:e(target,'fight') end
            if ok then return end
        end
    end
    local dist=U.dist(myHero.pos,target.pos)
    local weaving=self:passiveHold(target)
    if c:stage(0)==2 and c:mark(target) then
        local q2Free=c.config:get('comboQ2')
        if q2Free and c:combatDamage(0,target,2)>=U.effectiveHP(target)+10 and self.spells:q2(target,'fight',false,true) then return end
        if q2Free and c.config:get('comboWardPreserveQ') and c.config:get('comboKickFollow') and c.config:get('comboR')
            and c:ready(3) and c:markLeft(target)>.8 and dist>c.profile.rRange and self:gapclose(target) then return end
        local rDamage=c:combatDamage(3,target)
        local afterR=math.max(0,target.health-math.max(0,rDamage-(target.allShield or 0)-(target.shieldAD or 0)))
        local burst=rDamage+c:combatDamage(0,target,2,afterR)>=U.effectiveHP(target)+15
        local tactical=q2Free and not weaving and self:isolateUseful(target)
        if c.config:get('comboR') and c:ready(3) and dist<=c.profile.rRange
            and self:followAllowed(target,burst) and (burst or tactical) then
            if not burst and c:markLeft(target)>1.2 and self:rotation(target,'fight',
                {excludeQ2=true,reserveEnergy=(c:spell(0).mana or 0)+(c:spell(3).mana or 0),horizon=c:markLeft(target)-.8}) then return end
            if self:castFightR(target,false,'follow') then return end
        end
    end
    if not weaving then
        if self:rotation(target,'fight') then return end
    end
    if self:kickQ1Allowed(target) and self:kickQ1Burst(target) and self:castFightR(target,false,'followQ1') then return end
    -- Offensive item actives also belong to Q1 / no-mark rotations and must
    -- not depend on reaching the old Q2-only branch.
    if c.actives:tick(target,'fight') then return end
    if c.config:get('comboR') and c:combatDamage(3,target)>=U.effectiveHP(target)+10 and self:castFightR(target) then return end
    if c.damageModel:castIgnite(target) then return end
    self:gapclose(target)
end
return B

end
