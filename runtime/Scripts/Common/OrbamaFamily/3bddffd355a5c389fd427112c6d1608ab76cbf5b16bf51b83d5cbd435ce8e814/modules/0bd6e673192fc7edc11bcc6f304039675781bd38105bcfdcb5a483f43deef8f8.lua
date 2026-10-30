return function(require)
local U=require('kata.util')
local A={};A.__index=A
function A.new(c)
    local self=setmetatable({c=c,observations={},history={},observedAt={},cooldownSeen={}},A)
    self.client=c.core and c.core.client or c.sdk.Actions:CreateClient({name='Katarina',active=function()return c.active and c.sdk==SDK end})
    if self.client.CooperateWithEvade then
        self.client:CooperateWithEvade({committed=function()return c.state:channel()==true or self:rStarting()end,
            yield=function(evidence)
                if not evidence.likelyDeath then return false end
                self.client:YieldUnsent();c.mobility:cancel('evade_emergency')
                self.client:SetBlocked('channel','attack',false);self.client:SetBlocked('channel','move',false)
                return true
            end})
        self.client:RegisterEmergencyYield(function(resource)return self.client:YieldUnsent(resource)end)
    end
    self.client:Condition('channel','channel',function(q)
        return q.resource=='slot:3'or not c.state:channel()and not self:rStarting()
    end,{release=true})
    return self
end
-- An unsent or just-sent R may still start its channel. A sent R that never
-- became a channel must not block every other spell until reconciliation
-- (live 2026-10-03: Q/E refused 23 times over 1.5 s after an interrupted R).
function A:rStarting()
    local id,receipt=self.client:ResourceAction(self.client:SlotResource(3))
    if not id then return false end
    local observation=self.observations[id]
    local at=observation and observation.sentTime or receipt and receipt.sentGameTime
    return at==nil or Game.Timer()-at<.4
end
function A:slotObservation(slot)
    local id=self.client:ResourceAction(self.client:SlotResource(slot),false)
    return id and self.observations[id]
end
function A:slotBusy(slot)
    local resource=self.client:SlotResource(slot)
    if not resource then return true end
    local id,_,reason=self.client:ResourceAction(resource,false)
    return id~=nil or reason~=nil
end
function A:key(slot)
    if slot<6 then return ({[0]=HK_Q,[1]=HK_W,[2]=HK_E,[3]=HK_R,[4]=HK_SUMMONER_1,[5]=HK_SUMMONER_2})[slot]end
    return ({[6]=HK_ITEM_1,[7]=HK_ITEM_2,[8]=HK_ITEM_3,[9]=HK_ITEM_4,[10]=HK_ITEM_5,[11]=HK_ITEM_6,[12]=HK_ITEM_7})[slot]
end
function A:context(owner)
    local c=self.c
    return {condition=function()return c:available()and c:ownerActive(owner)end}
end
function A:submit(a)
    local c=self.c;local resource
    if a.slot~=nil then resource=self.client:SlotResource(a.slot)else resource=a.kind or'move'end
    if not resource then return false,'invalid_slot_resource'end
    local priorID,_,reserved=self.client:ResourceAction(resource,false)
    if priorID or reserved then
        local prior=priorID and self.observations[priorID]
        if not prior and reserved=='foreign_resource_reserved'then
            -- A delegated receipt authorizes inspection only through the client
            -- returned by Utils, never by reading another client's hub entries.
            for _,record in pairs(self.observations)do
                if record.resource==resource and record.client and record.client~=self.client then
                    local delegatedID=record.client:ResourceAction(resource,false)
                    if delegatedID==record.id then prior=record;break end
                end
            end
        end
        if prior and prior.a.owner==a.owner and U.id(prior.a.target)==U.id(a.target)and a.priority then
            (prior.client or self.client):UpdatePriority(prior.id,a.priority)
        end
        return false,'resource_pending'
    end
    local key=a.slot and self:key(a.slot)
    if a.slot and not key then return false,'missing_slot_key'end
    local origin=U.copy(c.hero.pos);local identity=U.id(a.anchor or a.target)
    local q={owner=a.owner,resource=resource,priority=a.priority or 'normal',
        expires=self.client:Now()+(a.ttl or 350),context=self:context(a.owner),targetID=identity,
        -- Evade's own requested escape passes the client's intervention gate (evade.lua Strike).
        evadeCompatible=a.evadeCompatible==true or nil,
        exceptions=a.release and {channel='release'}or nil,
        mechanical=function(resolved)
            if a.slot and not c.state:ready(a.slot)then return false,'spell_not_ready'end
            if identity and U.id(a.anchor or a.target)~=identity then return false,'target_identity_changed'end
            return c:legal(a,resolved and resolved.position)
        end,
        reconcile=function()
            local active=c.hero.activeSpell
            -- Shutdown may retire this client while its physical send settles.
            -- A fresh readable cooldown permits releasing the lease without declaring a hit.
            local spell=a.slot and c.state:spell(a.slot)
            -- Only this slot's own active cast blocks reconciliation; attacks do not
            -- (live: a sent-but-unexecuted Q/E stayed pending for 5 s during autos).
            local own=active and active.valid and a.slot and a.slot<4 and c.profile.spellNames[a.slot][U.name(active.name)]
            return c.sdk==SDK and c.hero==myHero and not own
                and(not a.slot or U.finite(spell.currentCd)and(spell.currentCd>0 or c.state:ready(a.slot)))
        end,
        independent=a.owner=='combo'or a.owner=='harass',reconcileAfter=450}
    local selfCast=a.slot==1 or a.slot==3 or a.rule and a.rule.active=='stasis'
    local aim=not selfCast and(a.pos or a.target)or nil
    if a.pos then
        q.kind='world'
        if a.anchor then q.resolve=function()
            local pos=c:landing(a.anchor,a.target,a.side,a.dagger)
            if not pos or U.dist(pos,a.pos)>160 then return nil,'landing_budget_exceeded'end
            return {position=pos}
        end end
    elseif a.target and not selfCast then q.kind='object'else q.kind='none'end
    if a.kind=='move'then q.kind='world';q.independent=false end
    local id,why;local execution=self.client
    local integrated=_G.AyyyyIO and _G.AyyyyIO.active
    -- Ward placement is part of the jump sequence (like Lee's), not a utility item:
    -- it uses this client's world cast. Live 2026-10-03: the Utils activator path
    -- aborted every ward with 'Projection failed before cursor acquisition'.
    local utility=a.slot and not a.ward and(a.slot>=6 or a.slot>=4 and U.summoner(c.state:spell(a.slot).name)=='summonerdot')
    if integrated and utility then
        local service=c.sdk.OrbamaUtils
        if not service or not service:active()then return false,'OrbamaUtils_unavailable'end
        q.target=aim
        local validate=q.mechanical
        q.mechanical=function(resolved)
            if not a.release and c.state:channel()then return false,'channel_protected'end
            return validate(resolved)
        end
        id,why=service.Activator:Submit(q,a.slot,{owner='kata:'..a.owner,offensive=a.rule and a.rule.active~='stasis',allowChannel=a.release})
        if id then execution=why end
    elseif a.kind=='move'then
        if a.release then self.client:SetBlocked('channel','move',false)end
        id,why=self.client:Move(aim,q)
    elseif a.kind=='attack'then id,why=self.client:Attack(a.target,q)
    else id,why=self.client:Cast(key,aim,q)end
    if not id then c:log('rejected',a,why);return false,why end
    a.actionID=id
    local record={id=id,client=execution,a=a,origin=origin,event=c.state.serial,at=Game.Timer(),resource=resource,
        generation=c.manualGeneration or 0,oldCd=a.slot and c.state:spell(a.slot).currentCd}
    self.observations[id]=record;c:log('requested',a,id);return true,record
end
function A:tick()
    local c=self.c;self.client:Tick()
    -- Bound to the observation it follows: a cooldown seen after that cast (see App:ready).
    for slot,at in pairs(self.observedAt)do local seen=c.state.spells[slot];if seen and seen.cd>0 then self.cooldownSeen[slot]=at end end
    for id,q in pairs(self.observations)do
        local client=q.client or self.client
        local r=client:Poll(q.id)
        if r then
            if q.status~=r.state then q.status=r.state;c:log(r.state,q.a,r.reason)end
            if r.sentAt and not q.sentTime then q.sentTime=Game.Timer()-(self.client:Now()-r.sentAt)/1000 end
            if r.sentAt and not r.mechanical and not q.observed then
                local event=q.a.slot and c.state.events[q.a.slot]
                local attributable=(c.manualGeneration or 0)==q.generation
                local observed=attributable and event and event.serial>q.event and event.at>=q.sentTime-.02
                -- Blink evidence needs actual displacement, an intended endpoint and no competing manual spell.
                if not observed and attributable and q.a.slot==2 then
                    local pos=q.a.pos or(q.a.target and q.a.target.pos)
                    observed=pos and not c.state:ready(2)and U.dist(q.origin,c.hero.pos)>100 and U.dist(c.hero.pos,pos)<100 and Game.Timer()-q.sentTime<.5
                end
                if observed then
                    local ok,why=client:Observe(q.id,{kind='mechanical',unique=true,source=event and event.source or 'blink_position',at=client:Now()})
                    -- The provider refuses attribution when another input competed during
                    -- the hold (e.g. W then R). The evidence here is this slot's own cast
                    -- after the send, so it settles this controller's bookkeeping.
                    if not ok and why=='ambiguous'and event then q.localObserved=true;ok=true end
                    if ok then
                        q.observed=true;c.state:expect(q.a.slot,q.origin,q.a.target);c:log('mechanical',q.a,q.id)
                        if q.a.slot then self.observedAt[q.a.slot]=Game.Timer()end
                        if q.a.slot==2 and q.a.owner=='harass'then c.trade={origin=q.origin,at=Game.Timer(),expires=Game.Timer()+2,target=q.a.combatTarget or q.a.target}end
                    end
                end
            end
            if r.state=='cancelled_before_send'or q.observed or r.mechanical then
                client:Finish(q.id,q.localObserved and 'own slot cast observed; provider attribution ambiguous'or nil)
            elseif r.sentAt then client:Reconcile(q.id)end
            if not client:HasAction(q.id)then
                q.finished=true;self.history[#self.history+1]=q
                if #self.history>32 then table.remove(self.history,1)end
                self.observations[id]=nil
            end
        elseif not client:HasAction(q.id)then
            q.finished=true;q.outcome='receipt_expired; historical_outcome_unknown'
            self.history[#self.history+1]=q;if #self.history>32 then table.remove(self.history,1)end
            self.observations[id]=nil
        end
    end
end
function A:cancel(owner,why)
    -- Do not remove the permanent channel condition by cancelling its owner.
    for _,q in pairs(self.observations)do if not owner or q.a.owner==owner then (q.client or self.client):Cancel(q.id,why)end end
end
function A:close()self:cancel(nil,'Katarina shutdown');if not self.c.core then self.client:Close('Katarina shutdown')end end
return A

end
