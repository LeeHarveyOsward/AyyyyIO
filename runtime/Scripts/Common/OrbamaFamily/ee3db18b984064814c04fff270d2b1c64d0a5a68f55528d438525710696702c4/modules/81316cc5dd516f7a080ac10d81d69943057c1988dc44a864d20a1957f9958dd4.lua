return function()
return function(g,family,manifest,digest,storage)
    local updater={state='current',enabled=true,nextCheck=0,token=0,index=1}
    -- Release repository (tools/publish_release.py): family-channel at the root, the runtime under
    -- runtime/ at its LOLEXT paths, every download pinned to the channel's commit.
    local base='https://raw.githubusercontent.com/LeeHarveyOsward/AyyyyIO/'
    local family_root='runtime/Scripts/Common/OrbamaFamily/'
    local function now()return g.GetTickCount()/1000 end
    local function alive()return family.active and g.OrbamaFamily==family end
    local function fail(reason)
        updater.token=updater.token+1;updater.waiting=false;updater.job=nil
        updater.state='unavailable';updater.reason=reason;updater.nextCheck=now()+600
    end
    local function request(url,limit,accept)
        updater.token=updater.token+1;local token=updater.token
        updater.waiting=true;updater.deadline=now()+45
        local ok=pcall(g.GetWebResultAsync,url,function(body)
            if not alive() or updater.token~=token or not updater.waiting then return end
            updater.waiting=false
            if type(body)~='string' or #body>limit then fail('invalid_download');return end
            updater.job=coroutine.create(function()accept(body)end)
        end)
        if not ok then fail('request_failed')end
    end
    local function write(path,body)
        local ok,result=pcall(storage.write,path,body)
        if not ok or not result then error('update_write_failed')end
    end
    -- Staged releases never pile up: before a new release is downloaded, every staged release in the two
    -- update slots except the running one and the new one is switched off and its files deleted (emptied
    -- where the sandbox does not allow deleting). A game folder holds at most the installed release and two
    -- staged ones.
    local function remove(path)
        local root=g.COMMON_PATH
        if type(root)=='string' and g.os and g.os.remove then
            if not root:match('[/\\]$') then root=root..'/' end
            local ok,done=pcall(g.os.remove,root..'OrbamaFamily/'..path)
            if ok and done then return end
        end
        pcall(storage.write,path,'')
    end
    local function clearStaged(running,incoming)
        for _,slot in ipairs({'a','b'})do
            local ok,pointer=pcall(storage.read,'update-'..slot,256)
            local generation=ok and type(pointer)=='string' and pointer:match('^FAMILYUPDATE1\n%d+\n([a-f0-9]+)\n')
            if generation and #generation==64 and generation~=running and generation~=incoming then
                pcall(storage.write,'update-'..slot,'FAMILYUPDATE0\n')
                local read,text=pcall(storage.read,'update-'..generation..'-manifest.lua',1000000)
                local compiled=read and type(text)=='string' and g.loadstring(text,'@family-update/stale')
                local loaded,stale=false,nil
                if compiled then loaded,stale=pcall(compiled)end
                if loaded and type(stale)=='table' and type(stale.modules)=='table' then
                    local seen={}
                    for _,row in pairs(stale.modules)do
                        if type(row)=='table' and type(row.sha256)=='string' and row.sha256:match('^[a-f0-9]+$') and not seen[row.sha256] then
                            seen[row.sha256]=true;remove('update-'..generation..'-'..row.sha256..'.lua')
                        end
                    end
                end
                remove('update-'..generation..'-manifest.lua')
            end
        end
    end
    local download
    local function stageManifest(body,expected,size,generation,sequence,commit)
        if #body~=size or digest(body,coroutine.yield)~=expected then fail('manifest_hash');return end
        local compile=g.loadstring(body,'@family-update/manifest')
        if not compile then fail('manifest_syntax');return end
        local candidate=compile()
        if candidate.api~=manifest.api or candidate.generation~=generation or candidate.sequence~=sequence
            or type(candidate.modules)~='table' or type(candidate.components)~='table' then fail('incompatible_release');return end
        if (candidate.development==true)~=(manifest.development==true)then fail('recording_channel_mismatch');return end
        for name in pairs(manifest.components)do if not candidate.components[name] then fail('component_removed');return end end
        local seen,files={},{}
        for _,row in pairs(candidate.modules)do
            if type(row.file)~='string' or row.file~='modules/'..tostring(row.sha256)..'.lua'
                or type(row.sha256)~='string' or #row.sha256~=64 or not row.sha256:match('^[a-f0-9]+$')
                or type(row.bytes)~='number' or row.bytes<1 or row.bytes>8000000 then fail('invalid_module');return end
            local prior=seen[row.file]
            if prior and (prior.sha256~=row.sha256 or prior.bytes~=row.bytes)then fail('conflicting_module');return end
            if not prior then files[#files+1]=row;seen[row.file]=row end
        end
        if #files==0 or #files>8192 then fail('module_limit');return end
        table.sort(files,function(a,b)return a.file<b.file end)
        clearStaged(manifest.generation,generation)
        updater.candidate={body=body,hash=expected,files=files,generation=generation,sequence=sequence,commit=commit}
        updater.index=1;updater.state='downloading';updater.job=nil
        download()
    end
    download=function()
        local candidate=updater.candidate;local row=candidate.files[updater.index]
        if not row then
            write('update-'..candidate.generation..'-manifest.lua',candidate.body)
            local slot=manifest.updateSlot=='a' and 'b' or 'a'
            write('update-'..slot,'FAMILYUPDATE1\n'..candidate.sequence..'\n'..candidate.generation..'\n'..candidate.hash..'\n')
            updater.state='ready';updater.pending=candidate.generation;updater.job=nil
            return
        end
        local path=family_root..candidate.generation..'/'..row.file
        request(base..candidate.commit..'/'..path,row.bytes,function(body)
            if #body~=row.bytes or digest(body,coroutine.yield)~=row.sha256 then fail('module_hash');return end
            if not g.loadstring(body,'@family-update/'..row.file)then fail('module_syntax');return end
            write('update-'..candidate.generation..'-'..row.sha256..'.lua',body)
            updater.index=updater.index+1;updater.job=nil;download()
        end)
    end
    function updater:Tick()
        if not alive() or self.state=='ready' then return end
        if self.waiting and now()>self.deadline then fail('timeout');return end
        if self.job then
            local job=self.job;local ok,why=coroutine.resume(job)
            if not ok then fail(tostring(why))
            elseif job==self.job and coroutine.status(job)=='dead' then self.job=nil end
        elseif not self.waiting and now()>=self.nextCheck then
            self.nextCheck=now()+600;self.state='checking'
            request(base..'main/family-channel',512,function(body)
                local sequence,commit,generation,size,hash=body:match('^FAMILYCHANNEL1\n(%d+)\n([a-f0-9]+)\n([a-f0-9]+)\n(%d+)\n([a-f0-9]+)\n$')
                sequence=tonumber(sequence);size=tonumber(size)
                if not sequence or not commit or #commit~=40 or not generation or #generation~=64
                    or not hash or #hash~=64 or not size or size<1 or size>1000000 then fail('invalid_channel');return end
                if sequence<=(manifest.sequence or 0) then self.state='current';self.job=nil;return end
                self.job=nil
                request(base..commit..'/'..family_root..generation..'/manifest.lua',size,
                    function(text)stageManifest(text,hash,size,generation,sequence,commit)end)
            end)
        end
    end
    function updater:Maintenance()
        if not alive() then return end
        local sdk=g.SDK;local input=sdk and sdk.Input
        if input and (input.Active or input.Step~=0 or input.InFlight and input.InFlight>0)then return end
        for _,held in pairs(sdk and sdk.Orbwalker and sdk.Orbwalker.Modes or {})do if held then return end end
        local spell=g.myHero and g.myHero.activeSpell
        if spell and spell.valid then return end
        local ok,why=pcall(self.Tick,self);if not ok then fail(tostring(why))end
    end
    return updater
end

end
