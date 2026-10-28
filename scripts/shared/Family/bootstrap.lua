local digest=(function()
local native=bit32 or bit
local floor=math.floor
local modulus=4294967296
local xor4={}
for a=0,15 do
    xor4[a]={}
    for b=0,15 do
        local x,y,value,place=a,b,0,1
        for _=1,4 do
            if x%2~=y%2 then value=value+place end
            x=floor(x/2);y=floor(y/2);place=place*2
        end
        xor4[a][b]=value
    end
end
local function bxor(a,b)
    if native then return native.bxor(a,b)%modulus end
    local value,place=0,1
    for _=1,8 do
        value=value+xor4[a%16][b%16]*place
        a=floor(a/16);b=floor(b/16);place=place*16
    end
    return value
end
local function band(a,b)
    if native then return native.band(a,b)%modulus end
    return (a+b-bxor(a,b))/2
end
local function rotate(a,n)
    return floor(a/2^n)+(a%2^n)*2^(32-n)
end
local function triple(a,b,c)return bxor(bxor(a,b),c)end
local constants={
    1116352408,1899447441,3049323471,3921009573,961987163,1508970993,2453635748,2870763221,
    3624381080,310598401,607225278,1426881987,1925078388,2162078206,2614888103,3248222580,
    3835390401,4022224774,264347078,604807628,770255983,1249150122,1555081692,1996064986,
    2554220882,2821834349,2952996808,3210313671,3336571891,3584528711,113926993,338241895,
    666307205,773529912,1294757372,1396182291,1695183700,1986661051,2177026350,2456956037,
    2730485921,2820302411,3259730800,3345764771,3516065817,3600352804,4094571909,275423344,
    430227734,506948616,659060556,883997877,958139571,1322822218,1537002063,1747873779,
    1955562222,2024104815,2227730452,2361852424,2428436474,2756734187,3204031479,3329325298}
return function(message,pause)
    local length=#message
    local tail=string.char(128)..string.rep('\0',(55-length)%64)
    local bits=length*8
    for shift=7,0,-1 do tail=tail..string.char(floor(bits/256^shift)%256) end
    message=message..tail
    local h={1779033703,3144134277,1013904242,2773480762,1359893119,2600822924,528734635,1541459225}
    local w={}
    for start=1,#message,64 do
        for i=0,15 do local a,b,c,d=message:byte(start+i*4,start+i*4+3);w[i]=((a*256+b)*256+c)*256+d end
        for i=16,63 do
            local a,b=w[i-15],w[i-2]
            w[i]=(w[i-16]+triple(rotate(a,7),rotate(a,18),floor(a/8))+w[i-7]
                +triple(rotate(b,17),rotate(b,19),floor(b/1024)))%modulus
        end
        local a,b,c,d,e,f,g,k=unpack(h)
        for i=0,63 do
            local t1=(k+triple(rotate(e,6),rotate(e,11),rotate(e,25))
                +bxor(band(e,f),band(modulus-1-e,g))+constants[i+1]+w[i])%modulus
            local t2=(triple(rotate(a,2),rotate(a,13),rotate(a,22))
                +triple(band(a,b),band(a,c),band(b,c)))%modulus
            k=g;g=f;f=e;e=(d+t1)%modulus;d=c;c=b;b=a;a=(t1+t2)%modulus
        end
        local values={a,b,c,d,e,f,g,k}
        for i=1,8 do h[i]=(h[i]+values[i])%modulus end
        if pause then pause() end
    end
    local result={}
    for i=1,8 do result[i]=string.format('%08x',h[i]) end
    return table.concat(result)
end

end)()
local runtime=(function()
return function(g, manifest, read, digest,storage)
    assert(manifest.api==1 and type(manifest.generation)=='string','Unsupported family generation')
    local family={api=1,generation=manifest.generation,active=true,components={},pending={},factories={},values={}}
    local provider,hero
    local bootOrder={'OrbamaPrediction','OrbamaUtils','AyyyyIO','EvAYYYYde'}
    local loading={}
    local function valid()
        return family.active and g.OrbamaFamily==family
            and (not provider or g.SDK==provider and not provider.Stopped) and (not hero or g.myHero==hero)
    end
    function family:Factory(id)
        assert(valid(),'Family instance changed')
        if self.factories[id] then return self.factories[id] end
        local row=assert(manifest.modules[id],'Module absent from selected generation: '..tostring(id))
        assert(not loading[id],'Cyclic module load: '..id)
        loading[id]=true
        local ok,value=pcall(function()
            local data=assert(read(row.file,row.bytes),'Missing family module: '..id)
            assert(#data==row.bytes and digest(data)==row.sha256,'Family module hash mismatch: '..id)
            local chunk=assert(g.loadstring(data,'@family/'..self.generation..'/'..row.file))
            return chunk()
        end)
        loading[id]=nil
        if not ok then error(value,0) end
        assert(type(value)=='function','Module did not return a factory: '..id)
        self.factories[id]=value
        return value
    end
    function family:Require(id)
        assert(valid(),'Family instance changed')
        local record=self.values[id]
        if record then
            assert(record.state=='ready','Module is unavailable: '..id)
            return record.value
        end
        record={state='loading'};self.values[id]=record
        local ok,value=pcall(self.Factory,self,id)
        if ok then ok,value=pcall(value,function(name)return self:Require(name)end) end
        if not ok then record.state='failed';record.reason=tostring(value);error(value,0) end
        record.state='ready';record.value=value
        return value
    end
    function family:Profile()
        local h=g.myHero
        local name=h and h.charName
        local base=type(name)=='string' and name:match('^Jade_(.+)$')
        return {identity=name,champion=base or name,mechanics=base and 'classic' or 'normal',
            objectID=h and (h.networkID or h.handle),map=g.Game and g.Game.mapID,
            variant=nil,dataRevision=manifest.dataRevision,generation=self.generation,
            modeVerified=false}
    end
    function family:GetPreparationScope(component,owner,active)
        if not valid()then return nil,'inactive_family'end
        if not manifest.components[component]then return nil,'unknown_component'end
        local record=self.components[component]
        if record and record.preparationStopped then return nil,'inactive_component'end
        if type(owner)~='string'or owner==''or #owner>80 then return nil,'invalid_owner'end
        local sdk=g.SDK;local service=sdk and sdk.Preparation
        if not service or service.version~=1 then return nil,'preparation_unavailable'end
        local capabilities=service.GetCapabilities and service:GetCapabilities()
        if not capabilities or not capabilities.lifecycleBinding then return nil,'preparation_lifecycle_unavailable'end
        self.preparationScopes=self.preparationScopes or {}
        local scopes=self.preparationScopes[component]
        if not scopes then scopes={};self.preparationScopes[component]=scopes end
        for name,scope in pairs(scopes)do if not scope:Alive()then scopes[name]=nil end end
        local existing=scopes[owner]
        if existing and existing:Alive()then return existing end
        local scope,reason=service:Register('family:'..component..':'..owner,{active=function()
            local record=family.components[component]
            return valid()and g.SDK==sdk and record and not record.preparationStopped and(record.state=='loading'or record.state=='ready')
                and(not active or active())
        end})
        if scope then scopes[owner]=scope end
        return scope,reason
    end
    function family:ClosePreparation(component)
        local all=self.preparationScopes or {}
        for name,scopes in pairs(all)do
            if not component or name==component then
                if self.components[name]then self.components[name].preparationStopped=true end
                for _,scope in pairs(scopes)do scope:Close()end
                all[name]=nil
            end
        end
        if component and self.components[component]then self.components[component].preparationStopped=true end
    end
    function family:Shutdown(reason)
        if not self.active then return end
        self.active=false;self.pending={}
        self:ClosePreparation()
        if self.guide then pcall(self.guide.Shutdown,self.guide)end
        if self.maintenance and g.SDK and g.SDK.OnMaintenance then
            for i=#g.SDK.OnMaintenance,1,-1 do if g.SDK.OnMaintenance[i]==self.maintenance then table.remove(g.SDK.OnMaintenance,i)end end
        end
        -- Controllers release their own action scopes. Provider cleanup runs last.
        for _,name in ipairs({'AyyyyIO','EvAYYYYde','OrbamaUtils','OrbamaPrediction','Orbama'}) do
            local record=self.components[name];local c=record and record.value
            if c and type(c.Shutdown)=='function' then pcall(c.Shutdown,c,reason or 'family_shutdown') end
        end
        if self.support then pcall(self.support.Close,self.support)end
        if self.diagnostics then
            local sdk=self.components.Orbama and self.components.Orbama.value
            local input=sdk and sdk.Input
            pcall(self.diagnostics.Event,self.diagnostics,'family_shutdown',{reason=reason or 'family_shutdown',
                providerStopped=sdk and sdk.Stopped==true or false,
                ownedKeys=input and next(input.KeysOwned or{})~=nil or false,
                pendingKeyUp=input and next(input.PendingUp or{})~=nil or false,
                pendingButtons=input and next(input.Buttons or{})~=nil or false})
            pcall(self.diagnostics.Close,self.diagnostics)
        end
        if self.diagnosticMaintenance and g.SDK and g.SDK.OnMaintenance then
            for i=#g.SDK.OnMaintenance,1,-1 do if g.SDK.OnMaintenance[i]==self.diagnosticMaintenance then table.remove(g.SDK.OnMaintenance,i)end end
        end
    end
    function family:Boot(name)
        assert(valid(),'Family instance changed')
        if manifest.development and not self.diagnostics and not self.diagnosticError then
            local ok,reason=pcall(function()
                self.diagnostics=self:Require('Family.diagnostics')(g,self,manifest)
                self.development=self:Require('Family.development')(g,self)
                if manifest.modules['Family.support']then self.support=self:Require('Family.support')(g,self)end
            end)
            if not ok then self.diagnosticError=tostring(reason);if g.print then g.print('[Family diagnostics] '..self.diagnosticError)end end
        end
        local spec=assert(manifest.components[name],'Unknown family component: '..tostring(name))
        local record=self.components[name]
        if record then return record.value,record.state end
        for _,dependency in ipairs(spec.requires or {}) do
            local _,state=self:Boot(dependency)
            if state=='failed' then return nil,'dependency_failed' end
        end
        if name~='Orbama' and not (g.SDK and g.SDK.OrbamaVersion and g.SDK.Actions) then
            self.pending[name]=true;return nil,'waiting_provider'
        end
        if name~='Orbama' then
            provider=g.SDK;hero=g.myHero
            if not self.guide and manifest.modules['Guide.family'] and g.SDK.UIInput then
                self.guide=self:Require('Guide.family').new(g,self)
            end
        end
        if name=='AyyyyIO' and g.SDK.ChampionCore and g.SDK.ChampionCore.active
            and g.SDK.ChampionCore.active:Current()then
            -- Refusal is not a failed module load. No controller factory ran,
            -- and the existing owner must remain usable and keep its callbacks.
            self.pending[name]=nil
            return nil,'champion_controller_active'
        end
        if name=='AyyyyIO' and manifest.roster and not manifest.roster[g.myHero.charName] then
            self.components[name]={state='unsupported',reason='champion_profile_unimplemented'}
            self.pending[name]=nil
            return nil,'unsupported'
        end
        record={state='loading'};self.components[name]=record
        local ok,value=pcall(self.Require,self,spec.module)
        if not ok then
            self:ClosePreparation(name)
            record.state='failed';record.reason=tostring(value)
            if g.print then g.print('['..name..'] '..record.reason) end
            return nil,'failed'
        end
        record.state='ready';record.value=value;self.pending[name]=nil
        if name=='Orbama'and type(value)=='table'and type(value.Shutdown)=='function'then
            local shutdown=value.Shutdown
            value.Shutdown=function(component,reason)
                if family.active and family.components.Orbama.value==component then
                    family:Shutdown(reason or 'provider_shutdown');return true
                end
                return shutdown(component,reason)
            end
        elseif name~='Orbama'and type(value)=='table'and type(value.Shutdown)=='function'then
            local shutdown=value.Shutdown
            value.Shutdown=function(component,...)
                family:ClosePreparation(name)
                return shutdown(component,...)
            end
        end
        if name~='Orbama'then self:GetPreparationScope(name,'component')end
        if self.development then
            local attached,reason=pcall(self.development.OnBoot,name,value)
            if not attached then pcall(self.diagnostics.Event,self.diagnostics,'instrumentation_error',{component=name,reason=tostring(reason)})end
        end
        if self.guide and value and manifest.modules['Guide.services'] then
            self:Require('Guide.services').Register(self.guide,name,value)
        end
        if name=='AyyyyIO' and self.guide and value and value.controller and value.controller.ctx and value.controller.ctx.guide then
            self.guide:RegisterLee(value.controller.ctx.guide,self:Require('leesin.guidelinks'))
        end
        if name=='AyyyyIO' and self.guide and value and value.controller and value.controller.RegisterGuide then
            value.controller:RegisterGuide(self.guide,self:Require('Guide.settings'))
        end
        return value,'ready'
    end
    function family:Tick()
        if not valid() then self:Shutdown('runtime_identity_changed');return end
        if g.SDK and g.SDK.OrbamaVersion and g.SDK.Actions then
            if self.diagnostics then
                if self.development and self.diagnosticProvider~=g.SDK then
                    local attached,why=pcall(self.development.OnBoot,'Orbama',g.SDK)
                    if attached then self.diagnosticProvider=g.SDK else self.diagnosticError=tostring(why)end
                end
                local ok,reason=pcall(self.diagnostics.Tick,self.diagnostics)
                if not ok then self.diagnosticError=tostring(reason)end
                if self.support then
                    local worked,why=pcall(self.support.Tick,self.support)
                    if not worked then self.diagnosticError='support: '..tostring(why)end
                end
                if not self.diagnosticMaintenance and g.SDK.OnMaintenance then
                    self.diagnosticMaintenance=function()
                        local worked,why=pcall(self.diagnostics.Maintenance,self.diagnostics)
                        if not worked then self.diagnosticError=tostring(why)end
                    end
                    table.insert(g.SDK.OnMaintenance,self.diagnosticMaintenance)
                end
            end
            if not self.guide and manifest.modules['Guide.family'] and g.SDK.UIInput then
                self.guide=self:Require('Guide.family').new(g,self)
            end
            if storage and not self.updater and manifest.modules['Family.updater'] and g.SDK.OnMaintenance then
                self.updater=self:Require('Family.updater')(g,self,manifest,digest,storage)
                self.maintenance=function()self.updater:Maintenance()end
                table.insert(g.SDK.OnMaintenance,self.maintenance)
            end
            if next(self.pending) then
                for _,name in ipairs(bootOrder) do if self.pending[name] then self:Boot(name) end end
            end
        end
    end
    if g.Callback and g.Callback.Add then
        g.Callback.Add('Tick',function()if family.active then family:Tick()end end)
        g.Callback.Add('UnLoad',function()family:Shutdown('unload')end)
    end
    return family
end

end)()
local start=(function()
return function(g, digest, runtime)
    local base=assert(g.COMMON_PATH,'COMMON_PATH is unavailable')
    if not base:match('[/\\]$') then base=base..'/' end
    base=base..'OrbamaFamily/'
    local function read(path,limit)
        local f=assert(g.io.open(path,'rb'),'Missing family file: '..path)
        local body=f:read(limit+1);f:close()
        assert(body and #body<=limit,'Invalid family file size: '..path)
        return body
    end
    local pointer=read(base..'current',160)
    local generation,expected=pointer:match('^FAMILY1\n([a-f0-9]+)\n([a-f0-9]+)\n$')
    assert(generation and #generation==64 and expected and #expected==64,'Invalid family selector')
    local root=base..generation..'/'
    local body=read(root..'manifest.lua',1000000)
    assert(digest(body)==expected,'Family manifest hash mismatch')
    local manifest=assert(g.loadstring(body,'@family/manifest'))()
    assert(manifest.generation==generation,'Mixed family generations')
    local function readUpdate(path,limit)
        assert(path:match('^update%-[a-f0-9]+%-[a-f0-9]+%.lua$') or
            path:match('^update%-[a-f0-9]+%-manifest%.lua$') or path:match('^update%-[ab]$'),'Invalid update path')
        return read(base..path,limit)
    end
    for _,slot in ipairs({'a','b'})do
        local ok,choice=pcall(function()
            local pointer=readUpdate('update-'..slot,256)
            local sequence,id,hash=pointer:match('^FAMILYUPDATE1\n(%d+)\n([a-f0-9]+)\n([a-f0-9]+)\n$')
            sequence=tonumber(sequence)
            if not sequence or sequence<=(manifest.sequence or 0) or not id or #id~=64 or not hash or #hash~=64 then return end
            local text=readUpdate('update-'..id..'-manifest.lua',1000000)
            if digest(text)~=hash then return end
            local candidate=assert(g.loadstring(text,'@family/update-manifest'))()
            if candidate.api~=manifest.api or candidate.generation~=id or candidate.sequence~=sequence then return end
            if (candidate.development==true)~=(manifest.development==true)then return end
            local checked={}
            for _,row in pairs(candidate.modules)do
                if not checked[row.sha256] then
                    local module=readUpdate('update-'..id..'-'..row.sha256..'.lua',row.bytes)
                    if #module~=row.bytes or digest(module)~=row.sha256 then return end
                    checked[row.sha256]=true
                end
            end
            candidate.updateSlot=slot;return candidate
        end)
        if ok and choice then manifest=choice end
    end
    local storage={read=readUpdate}
    function storage.write(path,data)
        assert(path:match('^update%-[a-f0-9]+%-[a-f0-9]+%.lua$') or
            path:match('^update%-[a-f0-9]+%-manifest%.lua$') or path:match('^update%-[ab]$'),'Invalid update path')
        local file=assert(g.io.open(base..path,'wb'))
        local written=file:write(data);local closed=file:close()
        return written~=nil and closed~=nil and readUpdate(path,#data)==data
    end
    return runtime(g,manifest,function(path,limit)
        assert(path:match('^modules/[a-f0-9]+%.lua$'),'Invalid family module path')
        if manifest.updateSlot then
            return readUpdate('update-'..manifest.generation..'-'..path:match('^modules/(.+)$'),limit)
        end
        return read(root..path,limit)
    end,digest,storage)
end

end)()
return start(_G,digest,runtime)
