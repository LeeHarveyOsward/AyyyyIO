return function(require)
-- Lee Sin gameplay adapter for Orbama Actions v1. No cursor internals are written.
local U=require('leesin.util')
local Intent=require('leesin.intent')
return function(a)
    local c=a.ctx;local api=c.sdk.Actions
    assert(api and api.version==1,'Orbama Actions v1 required')
    a.api=api;a.client=assert(c.core and c.core.client,'Shared ChampionCore client required')
    -- Provider capabilities are immutable for this controller lifetime. Avoid
    -- allocating a fresh capabilities table for every validation/dispatch.
    a.capabilities=a.client:Capabilities()
    function a:syncAutomation()
        if not self.capabilities.automationClaims or not self.client.Claim then return end
        if c.sharedUtilities then
            if self.qssClaim then self.client:Claim('qss',false);self.qssClaim=nil end
            return
        end
        -- LHO implements item QSS, not summoner Cleanse. Claim only that actual
        -- enabled service; Close releases the claim on unload/error.
        local enabled=c.config:get('enabled') and c.config:get('items') and c.config:get('idleDefense') and c.config:get('itemCleanse')
        if not enabled then
            if self.qssClaim then self.client:Claim('qss',false) end
            self.qssClaim=nil;self.qssRetry=nil;return
        end
        if self.qssClaim or self.qssRetry and self.api:Now()<self.qssRetry then return end
        self.qssClaim=self.client:Claim('qss',true)==true
        self.qssRetry=not self.qssClaim and self.api:Now()+500 or nil
    end
    function a:inputAction(id) return id and self.client:Poll(id) end
    function a:inputNow() return self.api:Now() end
    function a:syncWindow(window)
        if not window or not window.event or not window.event.cursorID then return 'ready' end
        local r=self:inputAction(window.event.cursorID)
        if not r or r.jobCancelled or r.state=='cancelled_before_send' then return 'cancelled' end
        if not r.sentAt then return 'waiting' end
        if not window.sendTimeApplied then
            local sent=c:now()-math.max(0,self.api:Now()-r.sentAt)*.001
            window.deadline=window.deadline+math.max(0,sent-window.event.at)
            window.startedAt=sent;window.sendTimeApplied=true
        end
        return r.state=='send_uncertain' and 'uncertain' or 'ready'
    end
    function a:cursorBusy() local s=self.api:GetAvailability();return s.busy or s.uncertain end
    function a:cursorWaitReason()
        local s=self.api:GetAvailability()
        return s.pendingReturn and 'Checking cursor return' or s.uncertain and 'Waiting for input' or 'Automatic input in progress'
    end
    function a:hasCursorQueue() return true end
    function a:request(q)
        if q.owner~='autosmite' then
            local validate=q.validate;local guard=q.commitGuard
            q.validate=function(...)
                if c.sdk.Evade and type(c.sdk.Evade.Evading)=='function' and c.sdk.Evade:Evading()then return false,'evade_intervention'end
                return validate(...)
            end
            if guard then q.commitGuard=function(...)
                if c.sdk.Evade and type(c.sdk.Evade.Evading)=='function' and c.sdk.Evade:Evading()then return false,'evade_intervention'end
                return guard(...)
            end end
        end
        local validate=q.validate
        q.mechanical=function(resolved)return validate(q,resolved)end
        q.kind=q.targetKind;q.resolve=q.resolveWorldTarget;q.targetID=q.intentTargetID
        q.independent=q.surviveMovementCommands==true
        q.autoAcknowledge=true
        q.autoReconcile=true
        q.reconcileAfter=math.max(750,math.max(.4,c.latency*2+c.jitter*3+.2)*1000)
        q.inputCompletion=q.type=='move'or q.type=='key'or q.type=='hover'or q.type=='click'or(q.type=='attack'and q.approach)
        q.reconcile=q.reconcile or function(result)
            if result.state=='send_uncertain'then return false end
            local slot=q.slot or(q.resource and tonumber(q.resource:match('^slot:(%d+)$')))
            local active=myHero.activeSpell;local spell=slot and c:spell(slot)
            local own=active and active.valid and spell and U.name(active.name)==U.name(spell.name)
            return slot~=nil and c:ready(slot)and not own
        end
        if c.core then c.core:Invalidate()end
        local id,why
        if q.intentKey then id,why=self.client:SubmitKeyed(q.intentKey,q,q.equivalent)
        else id,why=self.client:Submit(q)end
        if not id then return false,why end
        self.lastCursorAction=id
        local r=self:inputAction(id)
        if not r then return false,'Action record unavailable' end
        return r.state~='cancelled_before_send',r.reason or r.state,{cursorID=id,keyTick=r.sentAt,
            keyAt=r.sentAt and c:now()-math.max(0,self.api:Now()-r.sentAt)*.001}
    end
    function a:dispatchCursor(key,target,owner,chain,leftClicks,verifyTarget,validate,worldIntent,execution)
        owner=owner or 'default'
        -- Owner history is diagnostic only. Dependencies belong to a concrete
        -- gameplay sequence, never to independent retries such as Autosmite.
        local previous=chain and self.client:GetAnchor(owner)
        local prior=previous and self:inputAction(previous)
        if not prior or prior.jobCancelled or prior.state=='cancelled_before_send' then previous=nil end
        local kind=not target and 'none' or target.pos and 'object' or target.z~=nil and 'world' or 'screen'
        local actionType=leftClicks and 'click' or key==(MOUSEEVENTF_RIGHTDOWN or 8) and 'move' or key and 'cast' or 'hover'
        local farmMove=actionType=='move' and owner=='farm' and c.farm
        local moveCamp=farmMove and c.farm.camp
        local moveCombat=farmMove and (c.farm.state=='clearing' or c.farm.state=='finishing')
        local moveStep=moveCombat and c.farm.kiteStep
        local moveKey=moveStep and moveStep.key;local movePhase=moveStep and moveStep.phase
        local intentKey=(actionType=='move'or actionType=='hover')and(owner..':'..actionType)or nil
        local priority=execution and execution.priority or (actionType=='hover' and 'background' or Intent.priority(owner))
        local caps=self.capabilities
        local useAim=verifyTarget and kind=='object' and caps.aimCandidates
        local reactiveCast=actionType=='cast' and not previous and kind~='screen'
            and owner~='ward' and owner~='farm' and owner~='secure'
            and (owner~='insec' or c.input:insecMovementHeld())
        if useAim and self.bodyPoint and not U.same(self.bodyPoint.target,verifyTarget) then self.bodyPoint=nil end
        -- A ward is a small model that nearby units can cover on screen; its
        -- candidates add hitbox points offset away from them (leesin.aim).
        local wardTarget=false
        if useAim then
            local pending=c.wards and c.wards.pending
            wardTarget=pending and U.same(pending.target,verifyTarget) or false
            if not wardTarget then for _,w in ipairs(c.wardObjects or {}) do if U.same(w,verifyTarget) then wardTarget=true;break end end end
        end
        local resolver=execution and execution.resolveWorldTarget
        if resolver and execution.contextValid then
            local resolve=resolver
            resolver=function(...)
                local valid,reason=execution.contextValid();if not valid then return nil,reason end
                return resolve(...)
            end
        end
        local synthetic=c.synthetic;c.synthetic=true
        local ok,why,timing=self:request{type=actionType,targetKind=kind,target=target,keys=key,
            owner=owner,priority=priority,expires=self.api:Now()+500,dependency=previous,handoff=chain==true and previous~=nil,
            count=leftClicks,verifyTarget=verifyTarget,world=worldIntent,
            resource=execution and execution.resource,
            slot=execution and execution.slot,
            context=execution and execution.contextValid and {condition=execution.contextValid} or nil,
            intentKey=intentKey,equivalent=function(old,new)
                return old.kind==kind and(kind=='object'and U.same(old.target,target)
                    or kind=='world'and U.dist(old.target,target)<5 or kind=='screen'and U.screenDist(old.target,target)<2)
            end,
            resolveWorldTarget=resolver,
            prevalidateWorldCast=resolver and caps.prevalidateWorldCast and not previous and not verifyTarget and true or nil,
            commitGuard=resolver and caps.prevalidateWorldCast and not previous and not verifyTarget and execution.contextValid or nil,
            intentTargetID=execution and execution.intentTargetID,
            survivePointerMotion=reactiveCast
                and caps.survivePointerMotion and true or nil,
            surviveMovementCommands=reactiveCast
                and caps.surviveMovementCommands and true or nil,
            aimCandidates=useAim and function()return require('leesin.aim').points(self,verifyTarget,
                (owner=='autosmite' or owner=='secure') and c.config:get('smiteProjectionFallback'),wardTarget)end or nil,
            aimFallback=useAim and caps.aimFallback and (owner=='autosmite' or owner=='secure') and c.config:get('smiteProjectionFallback')
                and function(point)return require('leesin.aim').isolated(c,verifyTarget,point)end or nil,
            retryKey=useAim and (tostring(key)..':'..tostring(verifyTarget.networkID)..':'..tostring(verifyTarget.handle)) or nil,
            validate=function()if c:blocked() then return false,'context_blocked' end
                if actionType=='move' and (owner=='cursor' or owner=='ally')
                    and (c.mode~=owner or not c.combat:insecOrbwalkAllowed()) then return false,'insec_movement_superseded' end
                if farmMove then
                    local combat=c.farm.state=='clearing' or c.farm.state=='finishing'
                    local step=c.farm.kiteStep
                    if c.farm.camp~=moveCamp or combat~=moveCombat
                        or moveStep and (not step or step.key~=moveKey or step.phase~=movePhase) then
                        return false,'farm_movement_superseded'
                    end
                end
                if validate then return validate() end;return true end}
        c.synthetic=synthetic;return ok,why,timing
    end
    function a:cancelMoveIntent(owner)
        self.client:CancelKeyed(owner..':move','Target attack supersedes pending ground movement')
    end
    function a:keyAction(keys,owner,kind,validate)
        owner=owner or 'control';kind=kind or 'key'
        local list=type(keys)=='table' and keys or {keys};local signature=owner..':'..kind..':'..table.concat(list,',')
        local id,r=self.client:KeyedAction(signature)
        if not r then
            local ok,why,timing=self:request{type=kind,targetKind='none',keys=keys,owner=owner,
                priority=owner=='farm' and 'normal' or 'background',expires=self.api:Now()+500,
                intentKey=signature,equivalent=function()return true end,
                validate=function()return not c:blocked() and (not validate or validate()) end}
            if not timing then return false,why,false end
            id=timing.cursorID;r=self:inputAction(id)
        end
        if r.state=='waiting' or r.state=='requested' then return false,'waiting',false,id end
        self.client:ConsumeKeyed(signature)
        if r.state=='cancelled_before_send' then return false,r.reason or 'declined',false,id end
        return r.state=='sent',r.state,true,id
    end
    function a:attack(target,owner)
        owner=owner or c.mode
        local intentKey='lho:attack'
        local _,prior=self.client:KeyedAction(intentKey)
        local waiting=prior and (prior.state=='waiting' or prior.state=='requested')
        local ready=c.sdk.Orbwalker:CanAttack() and U.valid(target)
            and U.dist(myHero.pos,target.pos)<=c:attackRange(target)
        if waiting and (not ready or not self.client:KeyedMatches(intentKey,owner,U.id(target))) then
            self.client:CancelKeyed(intentKey,'Attack intent no longer ready');waiting=false
        end
        -- A cooling-down or out-of-range attack must not reserve this tick and
        -- suppress the move that kites or brings the target back into range.
        if not ready then return false,'attack_not_ready','not_requested' end
        self:cancelMoveIntent(owner)
        if waiting then return true,'waiting','waiting' end
        local reservedID,reserved,reservation=self.client:ResourceAction('attack')
        if reservedID or reservation then
            return false,'Previous attack input awaiting acknowledgement',reserved and reserved.state or 'reserved'
        end
        local identity,handle=U.id(target),target.handle
        local start=c.sdk.Attack.ServerStart or 0;local activation=self.activation[owner]or 0
        local before=myHero.activeSpell;local previousEnd=before and before.castEndTime or 0
        local function nativeAttack(result)
            local spell=myHero.activeSpell
            if not result.sentGameTime or not U.valid(target)or U.id(target)~=identity or target.handle~=handle
                or not spell or not spell.valid or not U.finite(spell.startTime)
                or not U.finite(spell.castEndTime)or spell.castEndTime<=previousEnd
                or spell.startTime<result.sentGameTime-c.latency or spell.startTime>c:now()
                or c:now()-result.sentGameTime>math.max(.4,c.latency*2+c.jitter*3+.2)
                or(spell.target~=handle and spell.target~=identity)
                or not(spell.isAutoAttack==true or c.sdk.Data and c.sdk.Data:IsAttack(spell.name))then return nil end
            return {kind='mechanical',source='native_attack_start',unique=true,at=self.api:Now(),result='attack_started; impact_unobserved'}
        end
        local ok,why,timing=self:request{type='attack',targetKind='object',target=target,owner=owner,
            intentKey=intentKey,resource='attack',observation=nativeAttack,
            priority=owner=='farm' and 'background' or 'normal',expires=self.api:Now()+150,
            context={condition=function()return c.mode==owner and U.same(c.attackTarget,target)end},
            reconcile=function(result)
                local cycle=(c.sdk.Attack.ServerStart or 0)>start
                local deliberate=(self.activation[owner]or 0)>activation
                return not c.sdk.Orbwalker:IsAutoAttacking()and c.sdk.Orbwalker:CanAttack()
                    and(result.state~='send_uncertain'or cycle or deliberate)
            end,
            validate=function()return not c:blocked() and not c:recalling() and U.valid(target)
                and U.same(c.attackTarget,target) and c.mode==owner
                and c.sdk.Orbwalker:CanAttack()and U.dist(myHero.pos,target.pos)<=c:attackRange(target)
                and ((owner~='cursor' and owner~='ally') or c.combat:insecOrbwalkAllowed()) end}
        local action=timing and self:inputAction(timing.cursorID)
        return ok,why,action and action.state or 'not_requested'
    end
    function a:attackApproach(target,owner,cycle)
        if not self.capabilities.attackApproach then return false,'attack_approach_unavailable' end
        local function valid()
            return not c:blocked() and not c:recalling() and not c:dash() and U.valid(target)
                and U.same(c.attackTarget,target) and c.mode==owner and c.config:get('autoJungle')
                and not c.input.farmPaused and c.sdk.Orbwalker:CanMove() and not c.sdk.Orbwalker:IsAutoAttacking()
        end
        if not valid() then return false,'attack_approach_invalid' end
        local prior=self.approachRequest;local action=prior and self:inputAction(prior.id)
        local distance=U.dist(myHero.pos,target.pos)
        if prior and U.same(prior.target,target) and distance<(prior.distance or distance)-15 then
            prior.distance=distance;prior.progressAt=c:now()
        end
        local stalled=prior and action and action.sentAt and c:now()-(prior.progressAt or c:now())>=.6
            and (c.sdk.Attack.ServerStart or 0)<=(prior.attackStart or 0)
        local rejected=action and action.state=='cancelled_before_send' and not action.sentAt and action.aim and action.aim.exhausted
        -- One accepted ground recovery gets a bounded opportunity to move.
        -- Without progress, retry fresh target acquisition instead of returning
        -- forever after reissuing the same ineffective ground destination.
        local recoveryFinished=prior and U.same(prior.target,target) and prior.recoveryAt and c:now()-prior.recoveryAt>=.6
        if recoveryFinished and self:cursorBusy() then return false,'Approach recovery input still active' end
        if prior and U.same(prior.target,target) and (rejected or stalled) and not recoveryFinished then
            if prior.recoveryAt then return true,'waiting for approach recovery' end
            if stalled then require('leesin.aim').reject(self,action,target) end
            if not prior.recoveryYielded then
                -- Let independent spells use the released cursor this callback.
                -- Recovery is not another immediate high-frequency aim retry.
                prior.recoveryYielded=true;return false,'attack_approach_recovery_yield'
            end
            -- A nil/wrong host hover must not strand Lee just outside AA range.
            -- Move on verified ground into range; never turn ambiguous aim into
            -- an attack on an arbitrary overlapping monster.
            local goal=U.toward(target.pos,myHero.pos,math.max(70,c:attackRange(target)-35))
            local ground=require('leesin.ground');local point=ground.select(c,goal)
            if not point or U.dist(point,target.pos)>=distance-15 then
                -- Search empty ground inside attack range, including when the
                -- camp has already been dragged outside its preferred leash ring.
                local scene=ground.scene(c);local radius=math.max(70,c:attackRange(target)-35)
                local dx,dz=(myHero.pos.x-target.pos.x)/math.max(1,distance),(myHero.pos.z-target.pos.z)/math.max(1,distance)
                for _,angle in ipairs({.55,-.55,1.1,-1.1,1.57,-1.57}) do
                    local p={x=target.pos.x+(dx*math.cos(angle)-dz*math.sin(angle))*radius,y=target.pos.y,
                        z=target.pos.z+(dx*math.sin(angle)+dz*math.cos(angle))*radius}
                    if U.vector(p):To2D().onScreen and not ground.blocker(c,p,scene)
                        and c.terrain:walkLine(myHero.pos,p,myHero.boundingRadius or 35) then point=p;break end
                end
            end
            if point and U.dist(point,target.pos)<U.dist(myHero.pos,target.pos)-15
                and U.dist(myHero.pos,point)>25 and c.terrain:walkLine(myHero.pos,point,myHero.boundingRadius or 35) then
                if not prior.recoveryAt or c:now()-prior.recoveryAt>.35 then
                    local moved=self:move(point,owner)
                    if moved then
                        prior.recoveryAt=c:now()
                        if c.config.capture then c:log('attack_approach_recovery',{target=U.id(target),reason=action.reason,pos=point}) end
                        return true,'recovering attack approach on clear ground'
                    end
                else return true,'waiting for approach recovery' end
            end
        end
        self:cancelMoveIntent(owner)
        if prior and prior.cycle==cycle and U.same(prior.target,target) and action
            and action.state~='cancelled_before_send' then
            if not action.sentAt then return true,'attack approach waiting' end
            local distance=U.dist(myHero.pos,target.pos)
            if distance<(prior.distance or distance)-15 then
                prior.distance=distance;prior.progressAt=c:now()
            end
            -- A delivered click is not proof that the game accepted the order.
            -- Keep a progressing approach; reassert only after a bounded stall.
            if c:now()-(prior.progressAt or c:now())<.6 then return true,'attack approach already issued' end
        end
        if prior and action and not action.sentAt then self.client:Cancel(prior.id,'Attack approach changed') end
        local ok,why,timing=self:request{type='attack',approach=true,targetKind='object',target=target,
            verifyTarget=target,owner=owner,priority='normal',expires=api:Now()+150,validate=valid,
            retryKey='attack-approach:'..tostring(U.id(target)),
            aimCandidates=function()return require('leesin.aim').points(self,target,true)end,
            aimFallback=function(point)return require('leesin.aim').isolated(c,target,point)end}
        if timing then
            self.approachRequest={id=timing.cursorID,target=target,cycle=cycle,
                distance=U.dist(myHero.pos,target.pos),progressAt=c:now(),attackStart=c.sdk.Attack.ServerStart}
            if c.config.capture then c:log('kite_attack_approach',{cursorID=timing.cursorID,target=U.id(target),
                separation=U.dist(myHero.pos,target.pos),attackRange=c:attackRange(target),
                attackStart=c.sdk.Attack.ServerStart,cycle=c.sdk.Attack:GetAnimation(),
                cooldownLeft=math.max(0,c.sdk.Attack.ServerStart+c.sdk.Attack:GetAnimation()-c:now())}) end
        end
        return ok,why
    end
    function a:recall()
        return self:keyAction(HK_RECALL or 66,'farm','key',function()
            return c.config:get('autoJungle') and not c.input.farmPaused and not c:recalling()
                and c.farm:recallSafe(true)
        end)
    end
    function a:recallStatus(id,finished)
        local r=self:inputAction(id)
        if finished and r and not r.sentAt then
            self.client:Cancel(id,'Recall recovery finished');r=self:inputAction(id)
        end
        return r
    end
    function a:cancel(owner)
        self.client:SetAnchor(owner,nil)
        self.client:CancelOwner(owner,'LHO owner cancelled')
        for slot,e in pairs(self.spellObservations) do if e.owner==owner then
            local r=self:inputAction(e.cursorID)
            e.gameplayCancelled=true;e.cancelledAt=e.cancelledAt or c:now()
            self:quarantine(slot,e,r)
            -- Owner cancellation ends future intent, not an issued cast's
            -- observation window. Keep that slot until its original bounded
            -- observation completes; a new mode must not resend an in-flight
            -- Q just because delayed spell metadata still reports it ready.
            -- Uncertain sends retain their separate reconciliation contract.
            if not r or not r.sentAt then
                -- Release the cancelled, unsent job's slot lease now. Left to the next
                -- client Tick, pendingCast(slot) still reported it and a re-aimed
                -- request in the same callback (T re-press) was silently refused.
                if r then self.client:Finish(e.cursorID) end
                self.spellObservations[slot]=nil
                if r and not r.sentAt then e.status='cancelled' end
            end
        end end
    end
    function a:releaseMinimap() self.minimapLease=nil end
    function a:sampleCursor() end
    function a:ownsCursorPoint(owner,point)
        local id=self.client:LastAction(owner);local s=self.api:GetAvailability()
        return id and s.activeID==id and self:inputAction(id)~=nil
    end
    function a:ownsHoverAim(target,owner)
        local aim=self.hoverAim
        return aim and aim.owner==owner and U.same(aim.target,target)
            and self.api:GetAvailability().activeID==aim.id
    end
    function a:prepareHover(target,owner)
        if type(Game.GetUnderMouseObject)~='function' then return false,'Target verification unavailable' end
        if self:cursorBusy() and not self:ownsHoverAim(target,owner) then return false,'Waiting for input' end
        local point=U.vector(target.pos):To2D();if not point.onScreen then return false,'Target offscreen' end
        local ok,hovered=pcall(Game.GetUnderMouseObject)
        if ok and U.same(hovered,target) then local p=Game.cursorPos();return true,{x=p.x,y=p.y} end
        local aim=self.hoverAim
        if aim and self:ownsHoverAim(target,owner) then return false,'Waiting for hover' end
        local accepted,_,timing=self:dispatchCursor(nil,{x=point.x,y=point.y},owner,false,nil,nil,function()return U.valid(target)end)
        if accepted then self.hoverAim={owner=owner,target=target,point=point,at=c:now(),id=timing.cursorID} end
        return false,'Waiting for hover'
    end
    function a:canChainWard(slot,target,owner,anticipation)
        return c.config:get('wardFastCursor') and self:wardDependency(slot,target,owner,anticipation)
            and self.client:LastAction(owner)~=nil
    end
    function a:canChainInsecKick(slot,target,owner)
        if slot~=3 or c:dash() or not c:enemyValid(target) or U.dist(myHero.pos,target.pos)>c.profile.rRange
            or c.combat:kickProtected(target) then return false end
        if owner=='insec' and (not c.combat.insec or not c.combat:kickValid(c.combat.insec)) then return false end
        local last=self.history[#self.history]
        local action=last and self:inputAction(last.cursorID)
        return last and not last.gameplayCancelled and last.owner==owner and last.status=='observed'
            and action and not action.jobCancelled
    end
end

end
