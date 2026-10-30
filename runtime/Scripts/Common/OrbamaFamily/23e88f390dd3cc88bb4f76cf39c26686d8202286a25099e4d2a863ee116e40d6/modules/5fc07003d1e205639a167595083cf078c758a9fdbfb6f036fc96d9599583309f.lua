return function()
-- Owned recording slots. Call IO methods only from the family's idle maintenance gate.
return function(g,directory,options)
    options=options or {}
    local function limit(value,default,maximum,minimum)
        if type(value)~='number' or value~=value or value==math.huge or value==-math.huge then return default end
        return math.max(minimum,math.min(maximum,math.floor(value)))
    end
    local maxBytes=limit(options.maxBytes,8388608,8388608,128)
    -- A complete serial header fits in the first chunk, even in small fixtures.
    local chunkBytes=limit(options.chunkBytes,16384,16384,64)
    local prefix=type(directory)=='string' and directory or ''
    if prefix~='' and not prefix:match('[/\\]$') then prefix=prefix..'/' end
    local S={sharing=false,shareReady=false,error=nil,full=false,path=nil,
        exportPath=prefix..'FamilySupport.jsonl',closed=false,bytes=0}
    local indexPath=prefix..'FamilyRecording-index.txt'
    local initialized,nextSerial,serial=false,nil,nil
    local copySerial,lastSerial,sourceOffset
    local function slot(n)return prefix..'FamilyRecording-'..tostring((n-1)%5+1)..'.jsonl'end
    local function open(path,mode)
        if not g or not g.io or type(g.io.open)~='function' then return nil,'io_unavailable' end
        local ok,file,message,code=pcall(g.io.open,path,mode)
        if not ok then return nil,'open_error' end
        if not file then return nil,message,code end
        return file
    end
    local function close(file)
        if not file then return true end
        local ok,result=pcall(function()return file:close()end)
        return ok and result~=nil and result~=false
    end
    local function write(file,text)
        local ok,result=pcall(function()return file:write(text)end)
        return ok and result~=nil and result~=false
    end
    local function read(file,count)
        local ok,data,message=pcall(function()return file:read(count)end)
        if not ok then return nil,'read_error' end
        if data==nil then return nil,message end
        if type(data)~='string' or #data>count then return nil,'invalid_read' end
        if #data==0 then return nil end
        return data
    end
    local function fail(reason)
        S.error=reason;S.shareReady=false;S.sharing=false
        return false,reason
    end
    local function loadIndex()
        if initialized then return true end
        local file,_,code=open(indexPath,'rb')
        if not file then
            if code==2 then nextSerial=1;initialized=true;return true end
            return fail('index_open_failed')
        end
        local data,message=read(file,64)
        local closed=close(file)
        if message then return fail('index_read_failed') end
        if not closed then return fail('index_close_failed') end
        -- Strict format, bounded decimal integer. A full read may be truncated.
        if not data or #data>=64 or not data:match('^%d+\n$') then return fail('index_invalid') end
        local number=tonumber(data)
        if not number or number<1 or number>1000000000 or number~=math.floor(number) then return fail('index_invalid') end
        nextSerial=number;initialized=true;return true
    end
    local function startSession()
        if serial then return true end
        if not loadIndex() then return false,S.error end
        if nextSerial>=1000000000 then return fail('index_exhausted') end
        -- Persist the reservation before truncating the oldest owned slot. A failed
        -- write or close has unknown completion and is never attempted again here.
        local file=open(indexPath,'wb')
        if not file then return fail('index_reserve_open_failed') end
        local written=write(file,tostring(nextSerial+1)..'\n')
        local closed=close(file)
        if not written then return fail('index_reserve_write_unknown') end
        if not closed then return fail('index_reserve_close_unknown') end
        serial=nextSerial;nextSerial=nextSerial+1;S.path=slot(serial)
        local header='{"type":"recording_session","serial":'..tostring(serial)..'}\n'
        file=open(S.path,'wb')
        if not file then return fail('recording_open_failed') end
        written=write(file,header);closed=close(file)
        if not written then return fail('recording_write_unknown') end
        if not closed then return fail('recording_close_unknown') end
        S.bytes=#header
        return true
    end
    function S:Append(text)
        if self.closed then return false,'closed' end
        if self.error then return false,self.error end
        if self.sharing then return false,'sharing' end
        if self.full then return false,'recording_full' end
        if type(text)~='string' then return false,'invalid_text' end
        if #text==0 then return true end
        -- Reject an oversized first batch before reserving or truncating any file.
        if not serial and not loadIndex() then return false,self.error end
        local headerBytes=serial and 0 or #('{"type":"recording_session","serial":'..tostring(nextSerial)..'}\n')
        if #text>maxBytes-self.bytes-headerBytes then
            self.full=true;return false,'recording_full'
        end
        if not startSession() then return false,self.error end
        if #text>maxBytes-self.bytes then self.full=true;return false,'recording_full' end
        local file=open(self.path,'ab')
        if not file then return fail('recording_open_failed') end
        local written=write(file,text)
        local closed=close(file)
        if not written then return fail('recording_write_unknown') end
        if not closed then return fail('recording_close_unknown') end
        self.bytes=self.bytes+#text
        return true
    end
    function S:RequestShare()
        if self.closed or self.error or self.sharing then return false end
        self.sharing=true;self.shareReady=false
        copySerial=nil;lastSerial=nil;sourceOffset=0
        return true
    end
    function S:Maintenance()
        if self.closed or self.error or not self.sharing then return false end
        if not copySerial then
            if not loadIndex() then return false,self.error end
            lastSerial=nextSerial-1;copySerial=math.max(1,lastSerial-4)
            local file=open(self.exportPath,'wb')
            if not file then return fail('export_open_failed') end
            if not close(file) then return fail('export_close_unknown') end
        end
        if copySerial>lastSerial then
            self.sharing=false;self.shareReady=true
            return true
        end
        local source,_,code=open(slot(copySerial),'rb')
        if not source then
            if code==2 then copySerial=copySerial+1;sourceOffset=0;return true end
            return fail('export_source_open_failed')
        end
        local positioned,offset=pcall(function()return source:seek('set',sourceOffset)end)
        if not positioned or offset~=sourceOffset then
            close(source)
            return fail('export_source_seek_failed')
        end
        -- Exactly one bounded data read/copy per maintenance call. EOF and missing
        -- slots advance once and return. No file handle survives this idle call,
        -- so cancellation or shutdown never needs to flush a file during input.
        local data,message=read(source,chunkBytes)
        local closed=close(source)
        if message then return fail('export_source_read_failed') end
        if not closed then return fail('export_source_close_failed') end
        if not data then
            copySerial=copySerial+1;sourceOffset=0;return true
        end
        if sourceOffset+#data>maxBytes then return fail('export_source_too_large') end
        if sourceOffset==0 then
            local header=data:match('^({"type":"recording_session","serial":%d+})\n')
            if not header then return fail('export_source_invalid') end
            if tonumber(header:match('"serial":(%d+)'))~=copySerial then
                -- An interrupted reservation can leave the previous slot intact.
                copySerial=copySerial+1;sourceOffset=0;return true
            end
        end
        local output=open(self.exportPath,'ab')
        if not output then return fail('export_open_failed') end
        local written=write(output,data)
        closed=close(output)
        if not written then return fail('export_write_unknown') end
        if not closed then return fail('export_close_unknown') end
        sourceOffset=sourceOffset+#data
        return true
    end
    function S:CancelShare()
        self.sharing=false;self.shareReady=false
        copySerial=nil;lastSerial=nil;sourceOffset=0
        return true
    end
    function S:Close()
        if self.closed then return true end
        self.closed=true
        return self:CancelShare()
    end
    return S
end

end
