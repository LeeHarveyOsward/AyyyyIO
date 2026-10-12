return function(require)
local U=require('tf.util')
local Cards=require('tf.cards')
local A={};A.__index=A
function A.new(c)
    local self=setmetatable({c=c,pending={},cardIntentGeneration=0},A)
    c.actions=self -- retain ownership if a later constructor step fails
    self.client=c.core and c.core.client or c.sdk.Actions:CreateClient({name='TwistedFate',active=function()return c.active and c.config:get('enabled')end})
    if self.client.CooperateWithEvade then
        self.client:CooperateWithEvade({committed=function()return c.state:channel()==true end,
            yield=function(evidence)
                if not evidence.likelyDeath then return false end
                self.client:YieldUnsent();c.cards:clear()
                self.client:SetBlocked('gate','attack',false);self.client:SetBlocked('gate','move',false)
                return true
            end})
        self.client:RegisterEmergencyYield(function(resource)return self.client:YieldUnsent(resource)end)
    end
    self.client:Condition('channel','manual_channel',function(q)
        local active,kind=c.state:channel()
        return not active or q.tfLock~=nil and Cards.channelAllows(c.profile,kind,q.tfLock==true)
    end)
    return self
end
function A:submit(slot,q,observe)
    local c=self.c;local client=self.client
    if slot>=4 and _G.AyyyyIO and _G.AyyyyIO.active then
        local utils=c.sdk.OrbamaUtils
        if not utils or not utils:active()then return nil,'OrbamaUtils_unavailable'end
        local check=q.mechanical
        q.mechanical=function(resolved)
            if c:blocked()or c.state:channel()then return false,'context_ended'end
            return not check or check(resolved)
        end
        return utils.Activator:Submit(q,slot,{owner='tf:'..(q.owner or 'combat'),offensive=q.owner=='planned_active'})
    end
    q.resource=client:SlotResource(slot)
    if not q.resource then return nil,'invalid_slot_resource'end
    q.owner=q.owner or 'combat';q.priority=q.priority or 'normal'
    q.expires=q.expires or client:Now()+220
    q.keys=q.keys or {({[0]=HK_Q,[1]=HK_W,[2]=HK_E,[3]=HK_R,[4]=HK_SUMMONER_1,[5]=HK_SUMMONER_2})[slot]}
    q.kind=q.kind or 'none';q.type=q.type or 'cast'
    q.equivalence=q.equivalence or (q.owner..':'..slot..':'..tostring(q.targetID or '')..':'..tostring(q.tfStage or ''))
    local before=c.hero:GetSpellData(slot);local beforeName=before.name;local beforeRank=before.level
    local beforeCD=before.currentCd or 0;local serial=c.state.serial
    local unresolved;local cardIntent=self.cardIntentGeneration
    q.reconcile=function(record)
        local d=c.hero:GetSpellData(slot)
        if not d or not d.name then return false end
        -- Native card/Q evidence remains champion policy. The shared client
        -- retains the actual lease until that policy can reconcile the old send.
        if not unresolved then
            unresolved={name=d.name,rank=d.level,cd=d.currentCd or 0,stage=c.state.stage,color=c.state.color}
            c:record('resource_awaiting_state',{slot=slot,id=record and record.id,name=d.name,rank=d.level,cooldown=d.currentCd})
        end
        local changed=d.name~=unresolved.name or d.level~=unresolved.rank or(d.currentCd or 0)>unresolved.cd+.05
            or slot==1 and(c.state.stage~=unresolved.stage or c.state.color~=unresolved.color)
        local deliberate=slot==1 and self.cardIntentGeneration>cardIntent
        if changed or deliberate then return true end
        if slot==0 and q.freshReadyReplan==true and d.level>0 and(d.currentCd or 0)<=0
            and U.lower(d.name)==U.lower(c.profile.qName)and c.state:ready(slot)and not c.state:channel()
            and client:Available()then
            local at=Game.Timer();local active=c.hero.activeSpell
            if active and active.valid and U.lower(active.name)==U.lower(c.profile.qName)then unresolved.readyAt=nil
            elseif unresolved.readyAt and at>unresolved.readyAt then
                c:record('resource_reopened',{slot=slot,id=record and record.id,reason='fresh_ready_observed',historicalExecution='unknown'})
                return true
            else unresolved.readyAt=at end
        else unresolved.readyAt=nil end
        return false
    end
    if c.jungleExecution and(q.owner=='q'or q.owner=='farm_attack'or q.owner=='clear')then
        q.context=c.jungleExecution
    end
    local id,why=client:Submit(q)
    if id and not self.pending[id]then
        self.pending[id]={slot=slot,name=beforeName,rank=beforeRank,cd=beforeCD,serial=serial,observe=observe,owner=q.owner}
        c:record('requested',{id=id,slot=slot,owner=q.owner,mode=c.state.mode,target=q.targetID,stage=q.tfStage,lock=q.tfLock,
            desired=c.cards and c.cards.desired,observed=c.state.color})
    end
    return id,why
end
function A:busy(slot)
    local resource=self.client:SlotResource(slot)
    if not resource then return true,'invalid_slot_resource'end
    local id,_,reason=self.client:ResourceAction(resource,false)
    return id~=nil or reason~=nil,reason
end
function A:tick()
    local c=self.c;local client=self.client;client:Tick()
    for id,p in pairs(self.pending)do
        local r=client:Poll(id)
        if r then
            if c.config:get('diagnostics') and (p.loggedState~=r.state or p.loggedSent~=r.sentAt)then
                p.loggedState=r.state;p.loggedSent=r.sentAt
                c:record('action_state',{id=id,slot=p.slot,owner=p.owner,state=r.state,reason=r.reason,
                    requestedAt=r.requestedAt,sentAt=r.sentAt,releasedAt=r.releasedAt,cleanupPending=r.cleanupPending,
                    interrupted=r.interrupted,competitor=r.competitor})
            end
            if r.sentAt and not r.mechanical then
                local d=c.hero:GetSpellData(p.slot)
                -- A cooldown transition is a resource observation; a timer is not.
                local seen=p.observe and p.observe(p) or not p.observe and d and
                    (d.level~=p.rank or (d.currentCd or 0)>p.cd+.05)
                if seen then
                    local evidence={kind='mechanical',unique=true,at=client:Now(),source='fresh_tf_state'}
                    local receipt=r.commandReceipt
                    if client:Capabilities().keyedMechanicalObservation and receipt then
                        evidence.attribution='command_key';evidence.key=receipt.key
                        evidence.generation=receipt.generation;evidence.session=receipt.session
                    end
                    local accepted,why=client:Observe(id,evidence)
                    if p.observationReason~=tostring(accepted)..':'..tostring(why)then
                        p.observationReason=tostring(accepted)..':'..tostring(why)
                        c:record('action_observation',{id=id,accepted=accepted,reason=why,attribution=evidence.attribution})
                    end
                    r=client:Poll(id) or r
                end
            end
            client:Reconcile(id)
            if not r.sentAt and r.state=='cancelled_before_send' then client:Finish(id)end
        end
        if not client:HasAction(id)then self.pending[id]=nil;c:record('completed',{id=id,state=r and r.state,
            mechanical=r and r.mechanical~=nil and r.mechanical~=false or false,reason=r and r.reason,sentAt=r and r.sentAt})end
    end
end
function A:cancel(owner,reason)
    local utils=self.c.sdk.OrbamaUtils
    if _G.AyyyyIO and utils and utils:active()then utils.actions:cancel('tf:'..owner)end
    self.client:CancelOwner(owner,reason)
    -- Only a new physical card choice is new consent, not repeated shutdown or
    -- loss-of-context cancellation. Old sends still need provider cleanup.
    if owner=='cards'and reason=='manual_card_changed'then self.cardIntentGeneration=self.cardIntentGeneration+1 end
end
function A:close()
    for _,owner in ipairs({'item','summoner','planned_active'})do self:cancel(owner,'tf_shutdown')end
    local utils=self.c.sdk.OrbamaUtils;if _G.AyyyyIO and utils and utils:active()then utils.Leveling:Cancel('TwistedFate')end
    if not self.c.core then self.client:Close('tf_shutdown')end;self:tick();self.client:Collect()
end
return A

end
