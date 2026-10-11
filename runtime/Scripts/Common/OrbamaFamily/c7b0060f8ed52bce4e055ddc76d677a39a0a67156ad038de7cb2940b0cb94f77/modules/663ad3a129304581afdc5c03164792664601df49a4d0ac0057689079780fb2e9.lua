return function(require)
local B={}
local function service(c,name)
    local app=c.sdk.OrbamaUtils
    return app and app:active()and app[name]
end
function B.smite(c)
    local proxy={}
    function proxy:cast(target,owner,lethal)
        local s=service(c,'Objectives');if not s then return false end
        local context={condition=function()return not c:blocked()and c.mode==owner end}
        if owner~='secure'then return s:cast(target,'lho:'..owner,lethal,{context=context})end
        return s:Request(target,{owner='lho:secure',lethal=lethal,authorized=function()
            return not c:blocked()and c.input:held('secureKey')
        end,context=context})
    end
    -- Smite + Q: Smite the single unit blocking a Q1 the current mode decided on.
    -- Lethal from current health only; authorized while the mode and Smite stay on.
    function proxy:clearBlocker(target,owner)
        local s=service(c,'Objectives');if not s or type(s.Request)~='function'then return false,'utils_smite_unavailable'end
        local mode=c.mode
        -- An enemy lane minion goes through the explicit laneMinion request (Utils minionTarget).
        local minion=target and target.team~=300 or nil
        return s:Request(target,{owner='lho:smiteq:'..owner,lethal=true,laneMinion=minion,authorized=function()
            return not c:blocked()and c.mode==mode and c.config:get('autosmite')==true
                and(not minion or c.config:get('smiteMinionQ')==true)
        end,context={condition=function()return not c:blocked()and c.mode==mode end}})
    end
    function proxy:auto()return false end
    function proxy:followAim()return false end
    local defaults={damage=0,ready=false,inRange=false,clear=false,campTarget=false,minionTarget=false}
    return setmetatable(proxy,{__index=function(_,name)
        local s=service(c,'Objectives')
        if s and type(s[name])~='function'then return s[name]end
        if name=='resolve'then return function()local a=service(c,'Objectives');if a then return a:resolve()end end end
        if defaults[name]~=nil then return function(_,...)
            local a=service(c,'Objectives');if a then return a[name](a,...)end
            return defaults[name]
        end end
        if name=='decision'then return 'OrbamaUtils unavailable'end
    end})
end
function B.actives(c)
    local a={}
    function a:rule(id)return require('OrbamaUtils.itemdata')[c.profile.id][id]end
    function a:itemAllowed(slot,target)
        local s=service(c,'Activator')
        if not s then return false end
        return s:ItemAllowed(slot,target)
    end
    function a:tick(target,owner)
        local s=service(c,'Activator');if not s then return false end
        local mode=c.mode
        local context={condition=function()return not c:blocked()and c.mode==mode end}
        return s:Offense(target,context)
    end
    function a:defense()return false end
    function a:potions()return false end
    return a
end
function B.bindConfig(c)
    local cfg=c.config;local get,set,key=cfg.get,cfg.set,cfg.key
    local names={autosmite='autosmite',smiteCamps='smiteCamps',smiteMargin='smiteMargin',smiteEpicMargin='smiteEpicMargin',
        smiteOverride='smiteOverride',items='items',level='level',potions='potions',potionHP='potionHP',
        itemCleanse='cleanse',itemShield='shield',shieldHP='shieldHP',smiteKey='smiteKey',
        itemCleave='itemCleave',itemTargeted='itemTargeted',itemSlow='itemSlow',itemSpeed='itemSpeed'}
    function cfg:get(name)
        local app=c.sdk.OrbamaUtils;local mapped=names[name]
        if mapped then
            if app and app:active()then return app.config:get(mapped)end
            return type(self.values[name])=='number'and self.values[name]or false
        end
        return get(self,name)
    end
    function cfg:set(name,value)
        local app=c.sdk.OrbamaUtils
        if names[name]and app and app:active()then return app.config:set(names[name],value)end
        return set(self,name,value)
    end
    function cfg:key(name)
        local app=c.sdk.OrbamaUtils
        if name=='smiteKey'and app and app:active()then return app.config:key(name)end
        return key(self,name)
    end
end
return B

end
