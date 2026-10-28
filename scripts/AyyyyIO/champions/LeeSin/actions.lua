return function(require)
local U=require('leesin.util')
local Intent=require('leesin.intent')
local A={};A.__index=A
local hoverOffsets={{0,0},{0,-30},{0,-60},{-25,-30},{25,-30}}
local recastNames={'leesinqtwo','leesinwtwo','leesinetwo'}
-- Angle in degrees between the intended and the observed direction from one origin; nil when either is unknown.
local function directionError(origin,intended,observed)
    if not origin or not intended or not observed then return nil end
    local ax,az,bx,bz=intended.x-origin.x,intended.z-origin.z,observed.x-origin.x,observed.z-origin.z
    local length=math.sqrt((ax*ax+az*az)*(bx*bx+bz*bz))
    if not U.finite(length) or length<=0 then return nil end
    return math.deg(math.acos(U.clamp((ax*bx+az*bz)/length,-1,1)))
end
function A.new(ctx)
    local a=setmetatable({ctx=ctx,spellObservations={},history={},nextCast=0,issuedTick=-1,serial=0},A)
    require('leesin.community')(a);require('leesin.actionstate')(a);return a
end
function A:pendingCast(slot)
    local observation=self.spellObservations[slot]
    if not self.api then return observation end
    local resource=self.client:SlotResource(slot)
    if not resource then return true end
    local id,receipt,reason=self.client:ResourceAction(resource)
    if id then return observation and observation.cursorID==id and observation or receipt or true end
    return reason and true or nil
end
-- Mechanical spell evidence is attributable by the provider's command receipt
-- even when later unrelated clicks/warps marked the record 'competitor'.
-- Live 2026-09-29: unkeyed evidence was accepted for 8 of 112 sent casts.
function A:mechanicalEvidence(cursorID,source)
    local evidence={kind='mechanical',source=source,unique=true,at=self.api:Now()}
    local caps=self.api.GetCapabilities and self.api:GetCapabilities()
    local state=caps and caps.keyedMechanicalObservation and self.client.Poll and self.client:Poll(cursorID)
    local receipt=state and state.commandReceipt
    if receipt then
        evidence.attribution='command_key';evidence.key=receipt.key
        evidence.generation=receipt.generation;evidence.session=receipt.session
    end
    return evidence
end
function A:key(slot)
    if slot<4 then return ({HK_Q,HK_W,HK_E,HK_R})[slot+1] end
    if slot==4 then return HK_SUMMONER_1 elseif slot==5 then return HK_SUMMONER_2 end
    return ({HK_ITEM_1,HK_ITEM_2,HK_ITEM_3,HK_ITEM_4,HK_ITEM_5,HK_ITEM_6,HK_ITEM_7})[slot-5]
end
function A:wardDependency(slot,target,owner,anticipation)
    local c=self.ctx;local ward=c.wards and c.wards.pending
    local early=anticipation and ward==anticipation and ward.state=='placing' and not ward.earlyTried
        and target and not target.pos and U.dist(target,ward.pos)<1
    local event=ward and (early and ward.event or ward.placementEvent)
    return slot==1 and ward and (early or ward.state=='waiting_w' and ward.observed and U.same(ward.target,target))
        and event and not event.cancelled and event.owner==owner and ward.owner==owner
        and (event.before.wardKind or c.profile.wards[event.before.item] or c.wards.wardFallbacks and c.wards.wardFallbacks[event.before.item])
end
function A:observeQAim()
    local c=self.ctx;local now=c:now();local active=myHero.activeSpell
    local candidates={}
    for n=#self.history,math.max(1,#self.history-15),-1 do
        local e=self.history[n]
        if e.aimIntent and not e.aimReported then
            local r=self.api and self:inputAction(e.cursorID)
            local sentAt=r and r.sentAt and now-math.max(0,self:inputNow()-r.sentAt)/1000 or not self.api and e.keyAt
            if not sentAt then
                if e.cancelled or r and r.state=='cancelled_before_send' or now-e.at>1 then
                    e.aimReported=true
                    if c.config.capture then c:log('q_aim_not_sent',{request=e.id,cursorID=e.cursorID,
                        reason=r and r.reason or e.status or 'No send evidence'}) end
                end
            elseif now-sentAt>1 then
                e.aimReported=true;if c.config.capture then c:log('q_aim_unknown',{request=e.id,cursorID=e.cursorID,
                    reason='No matching native placement observed within one second; no timing learning'}) end
            elseif active and active.valid and active.name==e.name and active.placementPos and active.startTime
                and active.startTime>=sentAt-.02 and active.startTime<=now+.1 then
                candidates[#candidates+1]=e
            end
        end
    end
    for _,e in ipairs(candidates) do
        e.aimReported=true
        local input=c.sdk.Input;local action=input and e.cursorID and input:GetAction(e.cursorID)
        if c.config.capture then c:log('q_aim_observed',{request=e.id,cursorID=e.cursorID,inputSession=action and action.inputSession,
            requested=e.aimIntent,origin=e.aimOrigin,playerWorld=action and action.playerWorld,
            observed=U.copy(active.placementPos),nativeStart=active.startTime,
            desiredErrorDegrees=directionError(e.aimOrigin,e.aimIntent,active.placementPos),
            playerErrorDegrees=directionError(e.aimOrigin,action and action.playerWorld,active.placementPos),
            sentAt=action and action.sentAt,releasedAt=action and action.releasedAt,
            interrupted=action and action.interrupted,competitor=action and action.competitor,
            attribution=#candidates==1 and action and not action.interrupted and not action.competitor
                and 'Single matching script request; source not independently proven' or 'Ambiguous or interrupted request',
            evidence='Native placement direction only; no hit confirmation or timing learning'}) end
    end
end
function A:tick()
    if self.client then self.client:Tick()end
    local c=self.ctx;local now=c:now()
    if self.api then self:refreshUncertainty();self:syncAutomation() end
    if c.config.capture then self:observeQAim() end
    self:sampleCursor()
    self:releaseMinimap()
    local move=self.routeObservation
    if move then
        local action=self:inputAction(move.cursorID)
        local pending=action and not action.sentAt and action.state~='aborted' and action.state~='cancelled_before_send'
        local declined=action and not action.sentAt and (action.state=='aborted' or action.state=='cancelled_before_send')
        if action and action.sentAt and not move.sendObserved then
            move.sendObserved=true;move.at=now-math.max(0,self:inputNow()-action.sentAt)/1000
        end
        if declined then
            if c.config.capture then c:log('route_input_aborted',{cursorID=move.cursorID,reason=action.reason,destination=move.destination}) end
            self.routeObservation=nil;self.routeCommand=nil
        elseif pending then
            -- An accepted cursor request has not yet sent a game movement command.
        elseif not c.config:get('autoJungle') then self.routeObservation=nil
        elseif action and (action.interrupted or action.competitor) then
            -- A interrupted input has no uniquely attributable endpoint. Manual
            -- clicks already pause farming through the input handler. Replan
            -- from fresh state after the player interval, never replay this ID.
            if c.config.capture then c:log('route_input_uncertain',{cursorID=move.cursorID,reason=action.reason,
                destination=move.destination,observedDestination=myHero.pathing and U.copy(myHero.pathing.endPos),
                interrupted=action.interrupted,competitor=action.competitor}) end
            self.routeObservation=nil
            -- Keep the ordinary acknowledgement interval for this destination.
            -- Discarding the command here caused a new warp every ~180 ms.
            if self.routeCommand then self.routeCommand.uncertain=true end
            self.nextMove=math.max(self.nextMove or 0,now+.12)
        elseif c:dash() or c:recalling() or c.farm.state=='clearing' or c.farm.state=='finishing' then
            self.routeObservation=nil -- Combat, dash and recall supersede travel.
        elseif myHero.pathing and myHero.pathing.hasMovePath and myHero.pathing.endPos
            and U.dist(myHero.pathing.endPos,move.sent or move.destination)>250
            -- The path shown may still be the one from before this click: the new
            -- one needs a server round trip. Judge a path that changed since the
            -- request, or any path once the acknowledgement window has passed.
            -- Judging the old path after 0.2 s banned the minimap for 10 s and
            -- left routing on repeated screen clicks.
            and (now-move.at>math.max(.45,c.latency*2+c.jitter*3+.25)
                or now-move.at>.2 and move.pathBefore and U.dist(myHero.pathing.endPos,move.pathBefore)>60) then
            if c.config.capture then c:log('route_endpoint_mismatch',{destination=move.destination,dispatchedDestination=move.sent,
                cursorID=move.cursorID,count=(self.minimapMismatches or 0)+1,
                observedDestination=U.copy(myHero.pathing.endPos),transport=move.transport}) end
            self.routeObservation=nil;self.routeCommand=nil
            if move.transport=='minimap' then
                -- One odd endpoint (snapped to walkable ground, our own combat
                -- order) is not a broken projection; two in a row are.
                self.minimapMismatches=(self.minimapMismatches or 0)+1
                if self.minimapMismatches>=2 then
                    self.mapFit=nil;self.minimapRejectedUntil=now+10;self.minimapMismatches=0
                    if c.config.capture then c:log('route_minimap_rejected',{seconds=10,reason='two consecutive endpoint mismatches'}) end
                end
            end
            -- Native path endpoints may stop at attack range, snap to walkable
            -- ground, or be superseded by our own combat order. A mismatch is
            -- failed movement evidence, never evidence of a player's cancel.
            -- Retry from fresh planning without switching off retaliation.
            self.nextMove=math.max(self.nextMove or 0,now+.25)
            c.routeFailureReason=nil
        elseif U.dist(myHero.pos,move.origin)>40 and now-move.at>.2
            -- While the shown path still ends elsewhere the branch above decides.
            and not (myHero.pathing and myHero.pathing.hasMovePath and myHero.pathing.endPos
                and U.dist(myHero.pathing.endPos,move.sent or move.destination)>250) then
            if move.transport=='minimap' then self.minimapMismatches=0 end
            if c.config.capture then c:log('route_move_observed',{delay=now-move.at,destination=move.destination,cursorID=move.cursorID,transport=move.transport}) end;self.routeObservation=nil
        elseif now-move.at>1.5 and not move.reported then
            move.reported=true;if c.config.capture then c:log('route_move_unobserved',{destination=move.destination,origin=move.origin,
                hasMovePath=myHero.pathing and myHero.pathing.hasMovePath,endPos=myHero.pathing and U.copy(myHero.pathing.endPos)}) end
        end
    end
    if self.routeStop and not self:cursorBusy() and not c:blocked() and not c:recalling() then
        local ok=self:worldMove(myHero.pos)
        if ok then self.routeStop=nil end
    end
    if not self.api and c.cursorLease and (not self:cursorBusy() or c.sdk.Cursor.CastPos~=c.cursorLease.castPos) then c.cursorLease=nil end
    for slot,event in pairs(self.spellObservations) do
        if event.status~='input_uncertain' then
        local r=self:inputAction(event.cursorID)
        if self.api and r and not r.sentAt and r.state~='cancelled_before_send' and event.validate then
            -- A queued cast that is no longer legal must not hold its slot until
            -- dispatch or expiry. A resolving world cast is checked against its
            -- new aim at dispatch, not here against the old planning position.
            local check=event.resolveWorldTarget and event.contextValid or event.validate
            local ok,valid,why=pcall(check)
            if not ok or not valid then
                self.client:Cancel(event.cursorID,ok and (why or 'gameplay_condition_changed') or 'validation_exception')
                r=self:inputAction(event.cursorID)
            end
        end
        if self.api and r and r.state=='cancelled_before_send' then
            self.client:Finish(event.cursorID) -- Free the slot lease with the observation, not one Tick later.
            event.status='cancelled';event.cancelled=true;event.reason=r.reason;self.spellObservations[slot]=nil
            if c.config.capture then c:log('cast_cancelled',{request=event.id,cursorID=event.cursorID,owner=event.owner,slot=slot,reason=r.reason}) end
        elseif not self.api or r and r.sentAt then
        if self.api and not event.sendObserved then
            if event.aimTarget then require('leesin.aim').remember(self,r,event.aimTarget) end
            event.sendObserved=true;event.keyTick=r.sentAt;event.keyAt=now-math.max(0,self:inputNow()-r.sentAt)*.001
            event.deadline=event.keyAt+math.max(.4,c.latency*2+c.jitter*3+.2)
            event.status=r.state
            if r.resolution then
                event.aimIntent=U.copy(r.resolution.position)
                event.aimOrigin=U.copy(myHero.pos)
                event.resolution=r.resolution
            end
            if c.config.capture then c:log('cast_sent',{request=event.id,cursorID=event.cursorID,slot=slot,owner=event.owner,
                inputBoundary='Orbama_send',
                requestedAt=r.requestedAt,sentAt=r.sentAt,queue=r.sentAt>=r.requestedAt and (r.sentAt-r.requestedAt)*.001 or nil,
                invalidTiming=r.sentAt<r.requestedAt,timebase='monotonic milliseconds',gameTime=now,state=r.state,
                sendCompletedAt=r.sendCompletedAt,holdUntil=r.holdUntil,releasedAt=r.releasedAt}) end
        end
        local d=c:spell(slot)
        local q2=slot==0 and event.stage==2
        local active=myHero.activeSpell
        local q2Observed=q2 and active and active.valid and U.name(active.name):find('leesinqtwo',1,true)
            and (not active.startTime or active.startTime>=event.at-.1)
        local observed=(d.name and d.name~='' and d.name~=event.before.name) or (d.currentCd or 0)>(event.before.cd or 0)+.05
            or (d.ammo~=nil and event.before.ammo~=nil and d.ammo<event.before.ammo)
            or (d.toggleState~=nil and event.before.toggleState~=nil and d.toggleState~=event.before.toggleState)
        if event.before.item then
            local item=myHero:GetItemData(slot)
            observed=observed or not item or item.itemID~=event.before.item
                or (U.stackCount(item)<event.before.stacks)
                or (item and item.ammo~=nil and event.before.itemAmmo~=nil and item.ammo<event.before.itemAmmo)
        end
        local recastObserved
        if self.api and slot<3 and event.stage==2 then
            local evidence
            recastObserved,evidence=require('leesin.recasts').evidence(c,slot,event.recastBefore,event.keyAt)
            event.recastEvidence=evidence;observed=recastObserved and true or false
            if c.config.capture and event.lastRecastReason~=evidence.reason then
                event.lastRecastReason=evidence.reason
                c:log('recast_evidence',{cursorID=event.cursorID,slot=slot,observed=observed,evidence=evidence})
            end
            if q2 then q2Observed=recastObserved end
        end
        if q2Observed then
            c.q2Outcome={at=now,text='Q2 cast observed'}
            if c.config.capture then c:log('q2_cast_observed',{name=event.name,request=event.id,delay=now-event.at}) end
            observed=true
        end
        if observed then
            if (event.wardAnticipation or self.api) and c.clear then c.clear:accepted(slot,event.stage,not self.api) end
            if self.api and c.clear and slot<4 and (event.stage~=2 and (d.currentCd or 0)>(event.before.cd or 0)+.05
                or event.stage==1 and c:stage(slot)==2 or recastObserved) then
                c.clear:executed(slot,event.stage,event.recastEvidence and event.recastEvidence.at or now)
            end
            if self.api then
                self.client:Observe(event.cursorID,self:mechanicalEvidence(event.cursorID,'spell_metadata'))
                -- The observation ends this slot's lease; do not hold the next cast
                -- (recast, new target) for the client's following Tick.
                self.client:Finish(event.cursorID)
            end
            if q2 and not q2Observed then c.q2Outcome={at=now,text='Q state changed; Q2 hit unconfirmed'} end
            event.status='observed';event.observedAt=now;self.spellObservations[slot]=nil
            c.metrics.observed=(c.metrics.observed or 0)+1;if c.config.capture then c:log('cast_observed',{name=event.name,request=event.id,delay=now-event.at,
                slot=slot,stage=event.stage,owner=event.owner,target=event.target,encounter=event.encounter,
                insecAttempt=event.insecAttempt,evidence='Spell metadata changed; impact not confirmed'}) end
        elseif self.api and r and r.state=='send_uncertain' then
            self:quarantine(slot,event,r)
        elseif now>event.deadline then
            if event.aimTarget then require('leesin.aim').reject(self,r,event.aimTarget) end
            event.status='unconfirmed';self.spellObservations[slot]=nil
            -- The observation budget ends the slot's reservation for every sent
            -- request, cancelled or not: a key the game ignored must not block a
            -- fresh decision until the client's slower automatic reconciliation.
            if self.api and r and r.state~='send_uncertain'and c:ready(slot)
                and not(active and active.valid and U.name(active.name)==U.name(event.before.name))then
                self.client:Finish(event.cursorID,
                    (event.gameplayCancelled and 'cancelled_intent_' or '')..'observation_budget_ended; fresh_slot_ready; historical_execution_unresolved')
            end
            if c.config.capture then c:log('cast_unconfirmed',{name=event.name,request=event.id,slot=slot,owner=event.owner,
                cursorID=event.cursorID,target=event.target,stage=event.stage,before=event.before,
                after={name=d.name,cd=d.currentCd,ammo=d.ammo,toggleState=d.toggleState},
                keyAt=event.keyAt,deadline=event.deadline,recastEvidence=event.recastEvidence,
                input=r and {state=r.state,reason=r.reason,sentAt=r.sentAt,releasedAt=r.releasedAt,
                    interrupted=r.interrupted,uncertain=r.uncertain},
                active=active and {name=active.name,valid=active.valid,startTime=active.startTime},
                evidence='No attributable spell-state change before observation deadline; effect unknown'}) end
            if q2 then c.q2Outcome={at=now,text='Q2 key sent but cast unconfirmed'} end
        end
        end
        end
    end
end
function A:cast(slot,target,owner,opts)
    opts=opts or {};local c=self.ctx;local now=c:now();local key=self:key(slot)
    local function blocked(reason)
        local previous=self.lastBlock
        local same=previous and previous.owner==owner and previous.slot==slot and previous.reason==reason
            and previous.target==U.id(target)
        self.lastBlock={at=now,owner=owner,slot=slot,reason=reason,target=U.id(target),
            count=same and previous.count+1 or 1,reportAt=same and previous.reportAt or now}
        if same and now<previous.reportAt+.75 then return false end
        self.lastBlock.reportAt=now
        if c.config.capture then c:trace('cast_blocked',{slot=slot,stage=opts.stage,owner=owner,reason=reason,
            target=target and target.pos and U.id(target),pos=U.copy(target and (target.pos or target)),
            count=self.lastBlock.count,cursorStep=c.sdk.Cursor and c.sdk.Cursor.Step,pending=self.spellObservations[slot] and self.spellObservations[slot].id},
            tostring(slot)..':'..tostring(owner)..':'..reason,.75) end
        return false
    end
    -- Orbama's untargeted CastSpell branch calls CastKey directly and does not
    -- touch Cursor.Step / CastPos / CursorPos. Self-centered spells and recasts
    -- can share a cursor reservation without changing its owner or aim.
    local keyOnly=target==nil and (slot==0 and opts.stage==2 or slot==2 or slot==1 and (opts.stage or c:stage(1))==2)
    local priority=opts.smiteExecute and (owner=='autosmite' or owner=='secure')
        and c.smite and slot==c.smite:resolve() and opts.validate and opts.validate()
    local dependent=(opts.wardFollowup or opts.wardAnticipation) and self:wardDependency(slot,target,owner,opts.wardAnticipation)
    local chain=dependent and self:canChainWard(slot,target,owner,opts.wardAnticipation)
        or opts.verifyHover and self:ownsHoverAim(target,owner)
        or self:canChainInsecKick(slot,target,owner) or priority and self:hasCursorQueue()
    if c:blocked() then return blocked('Disabled / dead / chat / focus') end
    if opts.wardAnticipation and (not dependent or not (self:hasCursorQueue() or c.sdk.NativeTransport) or not opts.validate or not opts.validate()) then
        return blocked('Early W context / Orbama queue unavailable')
    end
    if c.combat and c.combat.insec and c.combat.insec.preview and owner~='autosmite' then return blocked('Insec preview owns input; no casts') end
    if self:smiteOwnsInput() and not priority then return blocked('Lethal Smite awaiting target verification') end
    if c:recalling() and not priority then return blocked('Recall active') end
    if c.leveling and c.leveling.pending and not priority then return blocked('Skill allocation owns input') end
    if not key then return blocked('No resolved binding') end
    if self.api then self:refreshUncertainty() end
    if self:pendingCast(slot) then return blocked('Slot awaiting shared-client acknowledgement or reconciliation') end
    if self:cursorBusy() and not self.api and not chain and not keyOnly then return blocked('Orbama cursor reservation') end
    if self.issuedTick==now and not dependent and not priority then return blocked('Another cast issued this tick') end
    if not opts.urgent and now<self.nextCast then return blocked('Cast spacing') end
    if opts.wardItem and slot>=6 then
        if not c.wards:itemReady(slot) then return blocked('Ward item not ready') end
    elseif not c:ready(slot) then return blocked('Native cooldown / energy / rank') end
    if slot<4 and not opts.interrupt and c.sdk.Orbwalker:IsAutoAttacking() then return blocked('Attack windup protected') end
    if target and target.pos and not U.valid(target) then return blocked('Target unavailable') end
    if target and not target.pos then target=U.vector(target) end
    local hoverPoint
    if opts.verifyHover and not self.api and not c.sdk.NativeTransport then
        local ready,point=self:prepareHover(target,owner,priority)
        if not ready then
            -- Reserve only a real hover attempt, once per lethal target. A
            -- missing API/offscreen object or failed aim must not freeze play.
            if priority and self:ownsHoverAim(target,owner)
                and (not self.smiteLease or not U.same(self.smiteLease.target,target)) then
                self.smiteLease={target=target,untilTime=now+.12,validate=opts.validate}
            end
            return blocked(point)
        end
        hoverPoint=point;chain=true
    end
    local d=c:spell(slot);local item=slot>=6 and myHero:GetItemData(slot);local stage=slot<3 and (opts.stage or c:stage(slot))
    self.serial=self.serial+1
    c.metrics.requested=(c.metrics.requested or 0)+1
    local intended=opts.intendedTarget or (target and target.pos and target)
    local event={id=self.serial,name=d.name,slot=slot,stage=stage,owner=owner,status='requested',at=now,
        intentMode=Intent.origin(c,owner),
        activation=self.activation[owner] or 0,
        wardAnticipation=opts.wardAnticipation and true or nil,
        target=U.id(intended),targetName=intended and intended.charName,targetPos=U.copy(intended and intended.pos),
        insecAttempt=owner=='insec' and c.insecTrace or nil,
        deadline=now+math.max(.4,c.latency*2+c.jitter*3+.2),
        before={name=d.name,cd=d.currentCd,ammo=d.ammo,toggleState=d.toggleState,item=item and item.itemID,
            wardKind=opts.wardItem and c.wards:wardKind(slot,item)or nil,
            itemAmmo=item and item.ammo,stacks=U.stackCount(item),stackCount=item and item.stackCount}}
    if stage==2 then
        event.recastBefore=require('leesin.recasts').snapshot(c,slot)
        event.recastBefore.targetPos=U.copy(intended and intended.pos)
    end
    local requestFields=c.config.capture and {request=event.id,name=d.name,slot=slot,stage=stage,owner=owner,key=key,requestedAt=now,
        target=event.target,targetName=event.targetName,targetPos=event.targetPos,pos=U.copy(target and (target.pos or target)),
        nativeSlot=c:spellSlot(slot),nativeState=Game.CanUseSpell(c:spellSlot(slot)),energy=myHero.mana,cost=d.mana,
        before=event.before,deadline=event.deadline} or nil
    if c.config.capture and slot==0 and stage==1 and target then
        event.aimIntent=U.copy(target.pos or target);event.aimOrigin=U.copy(myHero.pos)
    end
    -- No input waits for synchronous request-log writes. requestedAt and the
    -- dispatch timestamps preserve causality even though records follow input.
    c.synthetic=true;c.injected[key]={at=now,remaining=2}
    local ok,result
    event.dispatchAt=c:now()
    event.dispatchTick=GetTickCount and GetTickCount() or nil
    if self.api then
        local itemID=item and item.itemID;local identity=target and target.pos and U.id(target)
        local insec=c.combat and c.combat.insec
        event.modeBound=event.intentMode~=nil
        local function contextValid()
            if c:blocked() then return false,'context_blocked' end
            if event.gameplayCancelled then return false,'owner_cancelled' end
            return Intent.valid(c,event.intentMode)
        end
        local function checkLegal()
            local valid,reason=contextValid();if not valid then return false,reason end
            if c.combat and c.combat.insec and c.combat.insec.preview and owner~='autosmite' then return false,'preview_active' end
            if c.leveling and c.leveling.pending and not priority then return false,'leveling_active' end
            if owner=='fight' and c:combatTransit() then return false,'engage_in_flight' end
            if slot<4 and not c:abilityEnabled(slot,stage,owner,intended,opts.abilityPolicy) then return false,'disabled_for_mode' end
            if c:recalling() and not priority then return false,'recall_active' end
            if target and target.pos and (not U.valid(target) or U.id(target)~=identity) then return false,'target_changed_or_unavailable' end
            if slot<3 and stage and c:stage(slot,intended)~=stage then return false,'spell_stage_changed' end
            if not opts.wardItem and not c:ready(slot) then return false,'cooldown_energy_or_rank' end
            if itemID and (myHero:GetItemData(slot) or {}).itemID~=itemID then return false,'item_slot_changed' end
            if opts.wardItem and c:spell(slot).name~=event.before.name then return false,'ward_slot_changed'end
            if opts.wardItem and target and U.dist(myHero.pos,target)>c.wards:range(slot) then return false,'ward_out_of_range' end
            if opts.wardItem and target and c.terrain:wall(target)~=false then return false,'ward_placement_blocked' end
            if slot==1 and stage==1 and target and target.pos and not U.same(target,myHero) and not c.wards:jumpable(target) then return false,'invalid_w_ally_or_range' end
            if opts.validate then local allowed,why=opts.validate();if not allowed then return false,why or 'gameplay_condition_changed' end end
            if slot<4 and not opts.interrupt and c.sdk.Orbwalker:IsAutoAttacking() then return false,'attack_windup' end
            -- The final conjunction, evaluated in its original order, with a
            -- named reason per term. The anonymous result was reported as
            -- gameplay_condition_changed and hid which condition failed.
            if c:blocked() then return false,'context_blocked' end
            if target and target.pos and not (U.valid(target) and U.id(target)==identity) then return false,'target_changed_or_unavailable' end
            if intended and not U.valid(intended) then return false,'intended_target_unavailable' end
            if slot<3 and stage and c:stage(slot,intended)~=stage then return false,'spell_stage_changed' end
            if itemID and (myHero:GetItemData(slot) or {}).itemID~=itemID then return false,'item_slot_changed' end
            if opts.wardItem then
                if not c.wards:itemReady(slot,nil,self.spellObservations[slot]==event) then return false,'ward_item_unavailable' end
            elseif not c:ready(slot) then return false,'cooldown_energy_or_rank' end
            if owner=='insec' then
                if insec==nil or c.combat.insec~=insec then return false,'insec_attempt_replaced' end
                if not c.input:held(insec.kind=='cursor' and 'cursorKey' or 'allyKey') then return false,'insec_bind_released' end
                if slot==3 then
                    if not c.combat:geometry(insec) then return self:insecRefused(event,insec,target,'insec_aim_degenerate') end
                    if not (insec.rflash and c.combat:rflashValid(insec)) and not c.combat:kickValid(insec) then return self:insecRefused(event,insec,target,'insec_kick_invalid') end
                end
            end
            if slot==0 and stage==2 and not opts.hiddenMark and not (intended and c:mark(intended)
                and U.dist(myHero.pos,intended.pos)<=c.profile.q2Range and not c:dash()) then return false,'q2_mark_range_or_dash' end
            if slot==1 and stage==1 and target and target.pos and not U.same(target,myHero)
                and not c.wards:jumpable(target) then return false,'invalid_w_ally_or_range' end
            if slot>=4 and slot<=5 and U.name(d.name)=='summonerflash' then
                if not (target and U.dist(myHero.pos,target)<=400 and c.terrain:wall(target)~=true) then return false,'flash_position_invalid' end
                if owner=='insec' and not c.combat.planner:flashAllowed(insec) then return false,'flash_not_authorized' end
            end
            if slot==3 and target and target.pos and (c:dash()
                or U.dist(myHero.pos,target.pos)>c.profile.rRange or c.combat:kickProtected(target)) then
                return false,'r_target_range_dash_or_protection'
            end
            return true
        end
        local function legal() return U.withBuffScope(checkLegal) end
        local why,timing
        event.validate=legal;event.contextValid=contextValid
        event.resolveWorldTarget=opts.resolveWorldTarget~=nil
        self.client:SetAnchor(owner,dependent and c.wards.pending and
            (c.wards.pending.placementEvent or c.wards.pending.event).cursorID or nil)
        if not dependent and self:canChainInsecKick(slot,target,owner) then
            self.client:SetAnchor(owner,self.history[#self.history].cursorID)
        end
        result,why,timing=self:dispatchCursor(key,target,owner,chain,nil,opts.verifyHover and target,legal,nil,
            {priority=Intent.priority(owner,priority),resolveWorldTarget=opts.resolveWorldTarget,resource='slot:'..slot,slot=slot,
                contextValid=contextValid,intentTargetID=event.target});ok=true
        event.reason=why;event.aimTarget=opts.verifyHover and target
        if timing then event.keyAt=timing.keyAt;event.keyTick=timing.keyTick;event.cursorID=timing.cursorID end
    end
    c.synthetic=false
    if requestFields then
        requestFields.keyAt=event.keyAt;requestFields.keyTick=event.keyTick;requestFields.cursorID=event.cursorID
        c:log('cast_requested',requestFields)
    end
    U.invalidateBuffScope()
    if not ok or result~=true then
        event.status='rejected';c.metrics.rejected=(c.metrics.rejected or 0)+1
        return blocked(not ok and tostring(result) or event.reason or 'input_declined')
    end
    c.metrics.accepted=(c.metrics.accepted or 0)+1
    if not self.api and stage and c.clear and not opts.wardAnticipation then c.clear:accepted(slot,stage) end
    if not self.api and not keyOnly and self:cursorBusy() then c.cursorLease={castPos=c.sdk.Cursor.CastPos,owner=owner} end
    event.status='accepted';self.spellObservations[slot]=event;self.issuedTick=now
    if priority then self.smiteLease=nil end
    self.nextCast=now+(opts.delay or ((slot==0 or slot==3) and .25 or .06))
    self.history[#self.history+1]=event;if #self.history>128 then table.remove(self.history,1) end
    if c.telemetry then c.telemetry:safe('action',event,intended) end
    if c.config.capture then c:log('cast_accepted',{name=d.name,slot=slot,stage=stage,owner=owner,request=event.id,
        target=event.target,targetName=event.targetName,encounter=event.encounter,insecAttempt=event.insecAttempt}) end
    return true,event
end
-- Development family telemetry for a refused Insec R: records the geometry
-- behind the named reason once per request. Release builds attach no sink.
function A:insecRefused(event,insec,target,reason)
    local c=self.ctx;local d=c.familyTrace
    if d and d.enabled and not d.closed and not event.refusalTraced then
        event.refusalTraced=true
        local b=c.combat;local distance=target and target.pos and U.dist(myHero.pos,target.pos)
        local ok,aligned=pcall(function()return insec.endpoint and b:aligned(target,insec.endpoint) end)
        local wp=c.wards.pending
        d:Event('lee.insec.r_refused',{reason=reason,request=event.id,cursorID=event.cursorID,target=U.id(target),
            distance=distance,rRange=c.profile.rRange,dash=not not c:dash(),protected=b:kickProtected(target),
            aligned=ok and aligned or 'error',locked=insec.locked==true,insecKind=insec.kind,phase=insec.phase,
            predictionLead=insec.predictionLead,moving=target.pathing and target.pathing.hasMovePath or false,
            angleLimit=c.config:get('insecAngle'),wardState=wp and wp.state,sinceWardMs=c.wards.lastCompleted and (c:now()-c.wards.lastCompleted)*1000,
            ageMs=(c:now()-event.at)*1000},true)
    end
    return false,reason
end
function A:smiteOwnsInput()
    if self.api then return false end -- Dispatcher alone owns positioning and failure retry windows.
    local lease=self.smiteLease
    if not lease then return false end
    if not lease.validate() then self.smiteLease=nil;return false end
    return self.ctx:now()<=lease.untilTime
end
-- Why the minimap is not used for a route, once per reason and at most every
-- two seconds (development recording): the answer to "it refuses the minimap".
function A:minimapRefused(why,detail)
    local c=self.ctx;self.minimapWhy=why
    if not c.config.capture then return end
    local now=c:now()
    if self.minimapWhyLogged==why and now<(self.minimapWhyAt or 0) then return end
    self.minimapWhyLogged=why;self.minimapWhyAt=now+2
    local size=Game.Resolution and Game.Resolution();local rw,rh=self:renderSize(size)
    -- The own marker tells whether the host's minimap coordinates are usable at this resolution at all.
    local ok,own=pcall(function()local mm=myHero.posMM;return mm and (tostring(mm.x)..','..tostring(mm.y)) end)
    local overlay=c.sdk.Minimap or c.sdk.Overlay
    c:log('route_minimap_unavailable',{reason=why,detail=detail,apiWidth=size and size.x,apiHeight=size and size.y,
        renderWidth=rw,renderHeight=rh,ownMarker=ok and own or 'error',ownX=myHero.pos.x,ownZ=myHero.pos.z,
        anchors=overlay and overlay.minimapAnchors,source=overlay and overlay.minimapSource})
end
-- The provider's display service knows the render size when the host draws at
-- a different size than its input/API viewport; nil when it does not.
function A:renderSize(size)
    local overlay=self.ctx.sdk.Minimap or self.ctx.sdk.Overlay
    local viewport=overlay and (overlay.RenderViewport or overlay.Viewport)
    if not size or type(viewport)~='function' then return end
    local ok,w,h=pcall(viewport,overlay)
    if ok and U.finite(w) and U.finite(h) and w>=640 and h>=480 then return w,h end
end
function A:minimap(pos)
    if self.ctx:now()<(self.minimapRejectedUntil or 0) then self:minimapRefused('paused after endpoint mismatches');return end
    local service=self.ctx.sdk.Minimap
    if not service or type(service.InputPoint)~='function'then self:minimapRefused('provider minimap service unavailable');return end
    service:Prepare(self.ctx.heroes,self.ctx.turrets,self.ctx.camps)
    local map=service:InputPoint(pos)
    if not map then self:minimapRefused('no minimap projection',service.minimapSource);return end
    self.minimapWhy=nil;return map
end
function A:worldMove(destination,owner,chain)
    if self:smiteOwnsInput() then return false,'Lethal Smite awaiting target verification' end
    local ground=require('leesin.ground');local point,reason=ground.select(self.ctx,destination)
    if not point then return false,reason end
    if self.ctx.config.capture and U.dist(point,destination)>1 then
        self.ctx:trace('ground_click_adjusted',{owner=owner,goal=U.copy(destination),click=U.copy(point)},'ground_click',.25)
    end
    local accepted,why,detail=self:dispatchCursor(MOUSEEVENTF_RIGHTDOWN or 8,U.vector(point),owner or 'farm',chain,nil,nil,function()
        if not ground.safePoint(self.ctx,point)then return false,'ground_click_hud_or_offscreen'end
        return not ground.blocker(self.ctx,point),'ground_click_occupied'
    end)
    if accepted then detail=detail or {};detail.movementDestination=U.copy(point) end
    return accepted,why,detail
end
function A:clickMinimap(map,destination)
    if self:cursorBusy() then return false,self:cursorWaitReason() end
    local point={x=math.floor(map.x+.5),y=math.floor(map.y+.5)}
    return self:dispatchCursor(MOUSEEVENTF_RIGHTDOWN or 8,point,'farm',false,nil,nil,nil,destination)
end
function A:groundWaypoint(destination)
    local c=self.ctx;local distance=U.dist(myHero.pos,destination)
    -- Screen-visible final destinations go straight to native pathfinding.
    -- A conservative terrain cell must not replace a camp with a near-wall stop.
    if require('leesin.ground').safePoint(c,destination) then self.groundJob=nil;return destination end
    for length=math.min(1100,distance),300,-100 do
        local direct=U.toward(myHero.pos,destination,length)
        if require('leesin.ground').safePoint(c,direct) and c.terrain:clearance(direct,35,true) then self.groundJob=nil;return direct end
    end
    if not c.terrain:trusted() then return end
    local job=self.groundJob
    if not job or U.dist(job.goal,destination)>50 or U.dist(job.origin,myHero.pos)>100 then
        job={goal=U.copy(destination),origin=U.copy(myHero.pos)}
        job.work=coroutine.create(function()
            return require('leesin.navigation').approach(c.terrain,job.origin,job.goal,math.max(50,distance-300),1400,
                function()coroutine.yield()end,function(p)return require('leesin.ground').safePoint(c,p)end)
        end);self.groundJob=job
    end
    if not job.done and job.stepAt~=c:now() then
        job.stepAt=c:now();local ok,path=coroutine.resume(job.work)
        if not ok then self.groundJob=nil;if c.config.capture then c:log('route_ground_failed',{reason=tostring(path)}) end;return end
        if coroutine.status(job.work)=='dead' then job.done=true;job.path=path end
    end
    if job.path then
        -- Skip reached nodes and prefer the furthest visible endpoint. Native
        -- movement supplies the turns; never click Lee's current coordinates.
        for index=#job.path,1,-1 do
            local point=job.path[index]
            if U.dist(myHero.pos,point)>100 and require('leesin.ground').safePoint(c,point)
                and c.terrain:clearance(point,35,true) then return point end
        end
    end
    if job.done then self.groundJob=nil end
end
function A:move(pos,owner)
    local c=self.ctx;local now=c:now()
    local plannedKite=owner=='farm' and c.farm and c.farm.kiteStep
    local transition=plannedKite and plannedKite.key and (self.lastKiteKey~=plannedKite.key or self.lastKitePhase~=plannedKite.phase)
    self.lastCursorAction=nil
    if self:smiteOwnsInput() then return false,'Lethal Smite awaiting target verification' end
    local ward=c.wards and c.wards.pending;local cursor=c.sdk.Cursor;local lease=c.cursorLease
    local follow=owner=='ward' and ward and ward.state=='jumping' and (c:dash() or c:stage(1)==2)
    local chain=false
    if owner=='farm' and pos and U.dist(myHero.pos,pos)<25 then return false,'destination reached' end
    if not pos or c:blocked() or c:recalling() or (c.leveling and c.leveling.pending)
        or (self:cursorBusy() and not chain) or (now<(self.nextMove or 0) and not follow and not transition) then
        return false,self:cursorBusy() and self:cursorWaitReason() or c.leveling and c.leveling.pending and 'skill allocation pending' or 'input / movement cooldown'
    end
    local orb=c.sdk.Orbwalker
    if orb:IsAutoAttacking() or not orb:CanMove() or orb.MovementEnabled==false or orb.ForceMovement then return false end
    if orb.Menu and orb.Menu.MovementEnabled and not orb.Menu.MovementEnabled:Value() then return false end
    local p=U.vector(pos);c.dispatchMovement=p
    local args={Target=p,Process=true}
    local hooksOK=pcall(function() for _,fn in ipairs(orb.OnMoveCb or {}) do fn(args) end end)
    c.dispatchMovement=nil
    if not hooksOK or not args.Process or not args.Target then return false,'Orbama movement hook veto' end
    if owner=='farm' and U.dist(pos,args.Target)>80 then return false,'Orbama hook changed the camp destination' end
    p=U.vector(args.Target)
    local combat=owner=='farm' and c.farm and (c.farm.state=='clearing' or c.farm.state=='finishing')
    local kite=combat and c.farm.kiteStep
    if kite and kite.command and U.dist(kite.command.pos,p)<35 then
        local path=myHero.pathing
        if now-kite.command.at<.6 or path and path.hasMovePath and path.endPos and U.dist(path.endPos,p)<50 then
            return true,'kite command already active'
        end
    end
    local routing=owner=='farm' and not combat and U.dist(myHero.pos,p)>300
    local command=self.routeCommand
    if routing and c.farm:ensureRouter():ContinueMove(command,p) then
        return true,'route already active'
    elseif not routing then self.routeCommand=nil end
    local sent=U.copy(p)
    c.synthetic=true; c.syntheticMouseUntil=now+.08
    local screen=p:To2D()
    local travelMap=owner=='farm' and routing and U.dist(myHero.pos,p)>600 and c.config:get('farmMinimap') and self:minimap(p)
    local minimap=not not travelMap or not require('leesin.ground').safePoint(c,p)
    -- Screen movement retains precise monster coordinates. Minimap pixels are
    -- a fallback for offscreen travel, not a reason to round a visible endpoint.
    local ok,result,moveReason,projection,moveDetail
    if not minimap then
        c.dispatchMovement=p
        result,moveReason,moveDetail=self:worldMove(p,owner,chain);ok=true
        if result and moveDetail and moveDetail.movementDestination then sent=moveDetail.movementDestination end
        c.dispatchMovement=nil
    else
        local map=travelMap or (owner~='farm' or c.config:get('farmMinimap')) and self:minimap(p)
        projection=map or nil
        if map and owner=='farm' then
            result,moveReason=self:clickMinimap(map,p);ok=true -- Whole pixels, as before.
        elseif map then
            result,moveReason=self:dispatchCursor(MOUSEEVENTF_RIGHTDOWN or 8,map,owner,false,nil,nil,nil,p);ok=true
        end
        if not map and owner=='farm' then
            local waypoint=self:groundWaypoint(p)
            if waypoint then
                sent=U.copy(waypoint)
                c.dispatchMovement=U.vector(waypoint);result,moveReason,moveDetail=self:worldMove(c.dispatchMovement);ok=true;c.dispatchMovement=nil
                if result and moveDetail and moveDetail.movementDestination then sent=moveDetail.movementDestination end
                c.status=c.status..' | walking by screen clicks ('..(not c.config:get('farmMinimap') and 'minimap travel switched off'
                    or self.minimapWhy or 'no minimap projection')..')'
            end
        end
        if not ok or not result then
            local reason=moveReason or (map and 'Minimap input rejected' or 'Native minimap projection unavailable; finding ground route')
            moveReason=reason
            if self.moveFailure~=reason then self.moveFailure=reason;if c.config.capture then c:log('route_move_failed',{reason=reason,destination=U.copy(p),projection=map}) end end
        else self.moveFailure=nil end
    end
    -- The flag only brackets this dispatch. Left set, every later key and click of
    -- the player is ignored as "own input" (live 2026-10-07: auto-jungle could not
    -- be switched off, wardjump and right-click cancel were dead after one move).
    c.synthetic=false
    if ok and result then
        if routing then
            self.routeCommand={goal=U.copy(p),sent=sent,at=now,progressAt=now,progressPos=U.copy(myHero.pos),minimap=projection~=nil}
            self.routeClicks=(self.routeClicks or 0)+1
        end
        if owner=='farm' and (not self.lastRouteGoal or U.dist(self.lastRouteGoal,p)>100) then
            self.lastRouteGoal=U.copy(p)
            if c.config.capture then c:log('route_move_started',{destination=U.copy(p),dispatchedDestination=sent,origin=U.copy(myHero.pos),projection=projection,
                cursorID=self.lastCursorAction,
                transport=c.sdk.NativeTransport and 'native world' or projection and 'minimap' or minimap and 'ground fallback' or 'screen',qRank=c:spell(0).level}) end
        end
        if routing then self.routeObservation={origin=U.copy(myHero.pos),destination=U.copy(p),sent=sent,at=now,
            cursorID=self.lastCursorAction,pathBefore=myHero.pathing and myHero.pathing.hasMovePath and U.copy(myHero.pathing.endPos) or nil,
            transport=c.sdk.NativeTransport and 'native world' or projection and 'minimap' or minimap and 'ground fallback' or 'screen'} end
        if not self.api and self:cursorBusy() then c.cursorLease={castPos=c.sdk.Cursor.CastPos,owner=owner} end
        if kite then
            kite.command={pos=U.copy(p),at=now}
            self.lastKiteKey=kite.key;self.lastKitePhase=kite.phase
        end
        local action=self.lastCursorAction and c.sdk.Input and c.sdk.Input:GetAction(self.lastCursorAction)
        self.nextMove=now+.12;if c.config.capture then c:log(action and not action.sentAt and 'move_requested' or 'move_dispatched',
            {owner=owner,minimap=minimap,cursorID=self.lastCursorAction}) end;return true
    end
    return false,moveReason or 'Orbama movement declined'
end
return A

end
