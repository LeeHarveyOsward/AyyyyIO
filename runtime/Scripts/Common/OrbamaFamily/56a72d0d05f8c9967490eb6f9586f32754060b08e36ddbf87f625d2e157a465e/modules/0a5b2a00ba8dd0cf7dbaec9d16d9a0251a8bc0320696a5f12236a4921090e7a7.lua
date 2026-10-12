return function(require)
local U=require('utils.util')
local Aim=require('InputGeometry.object_aim')(U)
local A={};A.__index=A
function A.new(ctx)
    local self=setmetatable({ctx=ctx,events={},api=true,originalGG=false},A)
    self.client=ctx.sdk.Actions:CreateClient({name='OrbamaUtils',active=function()return ctx:active()end})
    self.capabilities=self.client:Capabilities()
    return self
end
function A:inputNow()return self.client:Now()end
function A:inputAction(id)return self.client:Poll(id)end
function A:SlotAction(slot,includeReceipt)
    local resource=self.client:SlotResource(slot)
    if not resource then return nil,nil,'invalid_slot_resource'end
    return self.client:ResourceAction(resource,includeReceipt)
end
function A:SlotEvent(slot)
    local id=self:SlotAction(slot,false)
    return id and self.events[id]
end
function A:SlotBusy(slot)
    local id,_,reason=self:SlotAction(slot,false)
    return id~=nil or reason~=nil
end
function A:ConsumerHandle(event,cancel)
    local id=event.id;local client=self.client;local handle={}
    function handle:Poll(request)if request==id then return client:Poll(id)end end
    function handle:AuthorizeDependency(borrower,options)
        if not client:HasAction(id)then return nil,'utility_source_unavailable'end
        return client:AuthorizeDependency(id,borrower,options)
    end
    function handle:RevokeDependency(grant,reason)return client:RevokeDependency(grant,reason)end
    function handle:Finish()return false,'utility_owner_observes_and_acknowledges'end
    function handle:Cancel(request,reason)
        if request~=id then return false,'foreign_utility_request'end
        if cancel then return cancel(event,reason)end
        return client:Cancel(id,reason)
    end
    return handle
end
function A:key(slot)
    local g=self.ctx.g
    if slot>=6 then return g['HK_ITEM_'..(slot-5)]end
    return ({[0]=g.HK_Q,g.HK_W,g.HK_E,g.HK_R,g.HK_SUMMONER_1,g.HK_SUMMONER_2})[slot]
end
function A:cast(slot,target,owner,options)
    options=options or {};local c=self.ctx;local client=self.client
    local resource=client:SlotResource(slot)
    if not resource then return false,'invalid_slot_resource'end
    -- Inventory services may supply their profiled readiness representation
    -- (Classic Sightstone uses inventory charges). Dispatch checks it again.
    local readiness=options.readiness or function()return c:ready(slot)end
    if c:blocked()or not readiness()then return false,'not_ready'end
    local key=self:key(slot);if not key then return false,'binding_unavailable'end
    local d=c:spell(slot);local before={cd=d.currentCd or 0,ammo=d.ammo,rank=d.level,name=d.name,toggle=d.toggleState}
    local current=slot>=6 and c.g.myHero:GetItemData(slot)
    local itemID=slot>=6 and current and current.itemID
    local validator=options.validate or function()return true end
    local q={type='cast',key=key,kind=options.kind or(target and 'object'or 'none'),target=target,owner=owner,
        resource=resource,priority=options.priority or(options.smiteExecute and 'critical'or options.urgent and 'interactive'or 'normal'),
        expires=math.min(options.expires or math.huge,client:Now()+(options.ttl or 250)),replace='higher_priority',evadeCompatible=options.evadeCompatible,
        context=options.context,reservation=options.reservation,independent=options.independent,dependency=options.dependency,dependencyGrant=options.dependencyGrant,
        dependencyState=options.dependencyState,handoff=options.handoff,verifyTarget=options.verifyHover and target or nil,resolve=options.resolve,
        prevalidateWorldCast=options.prevalidateWorldCast,commitGuard=options.commitGuard,ready=options.ready,
        mechanical=function(resolved)
            if c:blocked()or not readiness()then return false,'resource_not_ready'end
            local active=c.g.myHero.activeSpell
            -- The host reports isChanneling=true for ordinary auto-attacks for
            -- their whole animation (live: 79 BasicAttack samples). An attack is
            -- never a channel; attack timing belongs to the caller's validator.
            local attack=active and active.valid and active.isAutoAttack==true
            if slot>=6 and not options.allowChannel and not attack
                and(c.g.myHero.isChanneling or active and active.valid and active.isChanneling)then return false,'channel_protected'end
            local current=slot>=6 and c.g.myHero:GetItemData(slot)
            if itemID and(not current or current.itemID~=itemID)then return false,'item_replaced'end
            return validator(resolved)
        end}
    if options.verifyHover and self.capabilities.aimCandidates then
        local fallback=c.config:get('smiteProjectionFallback')and self.capabilities.aimFallback
        q.aimCandidates=function()
            return Aim.points(self,target,fallback)
        end
        if fallback then q.aimFallback=function(point)return Aim.isolated(c,target,point)end end
    end
    q.reconcile=function()
        local fresh=c:spell(slot)
        local active=c.g.myHero.activeSpell
        local own=active and active.valid and active.isAutoAttack~=true
            and U.name(active.name)==U.name(before.name)
        return fresh and type(fresh.name)=='string'and fresh.name==before.name and not own and readiness()
            and (not itemID or c.g.myHero:GetItemData(slot)and c.g.myHero:GetItemData(slot).itemID==itemID)
    end
    local id,why=client:Submit(q)
    if not id then return false,why end
    if self.events[id]then return true,self.events[id]end
    local event={id=id,cursorID=id,slot=slot,target=target,status='requested',at=c:now(),before=before,owner=owner}
    self.events[id]=event
    return true,event
end
function A:tick()
    local c=self.ctx;local client=self.client;client:Tick()
    for id,event in pairs(self.events)do
        local r=client:Poll(id)
        if r then
            if r.sentAt and event.target then Aim.remember(self,r,event.target)end
            if r.sentAt and not r.mechanical then
                local d=c:spell(event.slot);local b=event.before
                local changed=d and((d.currentCd or 0)>b.cd+.05 or b.ammo and d.ammo and d.ammo<b.ammo
                    or b.toggle and d.toggleState~=b.toggle)
                if changed then
                    local evidence={kind='mechanical',unique=true,at=client:Now(),source='utility_resource_transition'}
                    local receipt=r.commandReceipt
                    if self.capabilities.keyedMechanicalObservation and receipt then
                        evidence.attribution='command_key';evidence.key=receipt.key;evidence.generation=receipt.generation;evidence.session=receipt.session
                    end
                    client:Observe(id,evidence);r=client:Poll(id)or r
                end
            end
            event.status=r.mechanical and 'observed'or r.sentAt and 'sent'or r.state
            if r.mechanical and event.callbacks then
                local callbacks=event.callbacks;event.callbacks=nil
                for _,fn in ipairs(callbacks)do fn()end
            end
            event.gameplayCancelled=r.jobCancelled or r.state=='cancelled_before_send'
            client:Reconcile(id)
            if not client:HasAction(id)then
                if event.status=='sent'then event.status='unconfirmed'end
                self.events[id]=nil
            end
        elseif not client:HasAction(id)then
            self.events[id]=nil
        end
    end
end
function A:cancel(owner)self.client:CancelOwner(owner,'utility_cancelled')end
function A:cursorBusy()return not self.client:Available()end
function A:ownsHoverAim()return false end
function A:prepareHover()return false,'preaim_not_supported'end
function A:close()self.client:Close('utils_shutdown');self:tick();self.client:Collect()end
return A

end
