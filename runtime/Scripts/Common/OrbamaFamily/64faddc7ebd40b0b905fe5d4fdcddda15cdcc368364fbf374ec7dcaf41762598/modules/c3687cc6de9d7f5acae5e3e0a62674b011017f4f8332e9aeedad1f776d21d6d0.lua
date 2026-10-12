return function(require)
-- A defense candidate belongs to one registration of its resource owner.
local F={};F.__index=F
function F.new()return setmetatable({adapters={},epochs={},policies={},policySerial=0,revision=0},F)end
local function active(a)
    if not a.active then return true end
    local ok,yes=pcall(a.active);return ok and yes==true
end
function F:RegisterPolicy(resource,name,spec)
    if type(resource)~='string'or resource==''or #resource>100 or type(name)~='string'or name==''or #name>160
        or type(spec)~='table'or type(spec.allow)~='function'or type(spec.active)~='function'
        or type(spec.source)~='string'or spec.source==''then return false,'defense_policy_required'end
    local old=self.policies[resource]
    if old then
        local ok,yes=pcall(old.spec.active)
        if not ok or yes~=false then return false,'defense_policy_owner_exists'end
        self.policies[resource]=nil
    end
    local count=0;for _ in pairs(self.policies)do count=count+1 end
    if count>=8 then return false,'defense_policy_limit'end
    self.policySerial=self.policySerial+1;self.revision=self.revision+1
    self.policies[resource]={name=name,spec=spec,epoch=self.policySerial}
    return true,self.policySerial
end
function F:UnregisterPolicy(resource,name,epoch)
    local row=self.policies[resource]
    if not row or row.name~=name or row.epoch~=epoch then return false,'defense_policy_changed'end
    self.policies[resource]=nil;self.revision=self.revision+1;return true
end
function F:PolicyEpoch(resource)local row=self.policies[resource];return row and row.epoch end
function F:PolicyAllowed(resource,option,ctx,result)
    local row=self.policies[resource];if not row then return true end
    local ok,yes=pcall(row.spec.active)
    if not ok then return false end
    if yes==false then return true end
    if yes~=true then return false end
    local ran,allowed=pcall(row.spec.allow,option,ctx,result)
    return ran and allowed==true and self.policies[resource]==row
end
function F:Register(name,adapter)
    if type(name)~='string'or self.adapters[name]or type(adapter)~='table'
        or type(adapter.options)~='function'or type(adapter.prepare)~='function'
        or type(adapter.source)~='string'or adapter.validated~=true
        or adapter.active~=nil and type(adapter.active)~='function'then return false,'verified_adapter_required'end
    self.revision=self.revision+1;self.adapters[name]=adapter;self.epochs[name]=self.revision;return true,self.revision
end
function F:Unregister(name,epoch)
    if epoch==nil or self.epochs[name]~=epoch then return false,'defense_registration_changed'end
    self:Remove(name);return true
end
function F:Remove(name)
    self.adapters[name]=nil;self.epochs[name]=nil;self.revision=self.revision+1
end
function F:Current(candidate)
    if type(candidate)~='table'then return false end
    local a=self.adapters[candidate.adapter]
    if not a or self.epochs[candidate.adapter]~=candidate.epoch or not active(a)
        or self.adapters[candidate.adapter]~=a or self.epochs[candidate.adapter]~=candidate.epoch then return false end
    local v=candidate.option
    return type(v)=='table'and v.validated==true and v.profile==candidate.profile and v.resource==candidate.resource
        and candidate.policyEpoch==self:PolicyEpoch(candidate.resource)
        and v.ultimate==candidate.ultimate and v.summoner==candidate.summoner and v.item==candidate.item
end
function F:Options(ctx,permissions)
    local result={}
    for name,a in pairs(self.adapters)do
        local epoch=self.epochs[name]
        if active(a)then
            local ok,options=pcall(a.options,ctx)
            if ok and type(options)=='table'and active(a)and self.adapters[name]==a and self.epochs[name]==epoch then
                for i=1,math.min(#options,16)do local v=options[i]
                    if #result>=32 then return result end
                    if type(v)=='table'and v.validated==true and v.profile==ctx.profile and v.resource~=nil
                        and(not v.ultimate or permissions.ultimates)and(not v.summoner or permissions.summoners)
                        and(not v.item or permissions.items)and self:PolicyAllowed(v.resource,v,ctx)then
                        result[#result+1]={adapter=name,epoch=epoch,option=v,profile=v.profile,resource=v.resource,
                            ultimate=v.ultimate,summoner=v.summoner,item=v.item,policyEpoch=self:PolicyEpoch(v.resource)}
                    end
                end
            end
        end
    end
    return result
end
function F:Prepare(candidate,ctx)
    if not self:Current(candidate)then return nil,'defense_owner_changed'end
    if not self:PolicyAllowed(candidate.resource,candidate.option,ctx,candidate.evaluation)then return nil,'defense_policy_declined'end
    if ctx.profile~=nil and ctx.profile~=candidate.profile then return nil,'defense_profile_changed'end
    local a=self.adapters[candidate.adapter]
    local ok,value,why=pcall(a.prepare,candidate.option,ctx)
    if not ok then return nil,'defense_prepare_error'end
    if not self:Current(candidate)then return nil,'defense_owner_changed'end
    if type(value)~='table'or type(value.mechanical)~='function'then return nil,why or 'defense_declined'end
    if value.resource~=nil and value.resource~=candidate.resource then return nil,'defense_resource_changed'end
    -- Do not alter an adapter's reusable intent template or stack wrappers on it.
    local intent={};for k,v in pairs(value)do intent[k]=v end
    intent.resource=candidate.resource
    local mechanical=value.mechanical
    intent.mechanical=function(...)
        if not self:Current(candidate)then return false,'defense_owner_changed'end
        if not self:PolicyAllowed(candidate.resource,candidate.option,ctx,candidate.evaluation)then return false,'defense_policy_declined'end
        return mechanical(...)
    end
    if value.commitGuard then
        local guard=value.commitGuard
        intent.commitGuard=function(...)
            if not self:Current(candidate)then return false,'defense_owner_changed'end
            if not self:PolicyAllowed(candidate.resource,candidate.option,ctx,candidate.evaluation)then return false,'defense_policy_declined'end
            return guard(...)
        end
    end
    return intent
end
return F

end
