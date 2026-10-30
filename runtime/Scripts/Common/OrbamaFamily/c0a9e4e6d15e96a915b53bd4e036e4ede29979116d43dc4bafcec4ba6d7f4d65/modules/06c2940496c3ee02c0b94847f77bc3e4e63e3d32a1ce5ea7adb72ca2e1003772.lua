return function()
-- Opt-in family recorder. Detailed instrumentation and capture remain development-only.
-- Timing is callback/CPU evidence, never render FPS. No gameplay state is changed.
return function(g,family,manifest)
    manifest=manifest or {}
    local config=type(manifest.diagnostics)=='table' and manifest.diagnostics or {}
    local function clamp(value,default,low,high)
        value=tonumber(value) or default
        if value~=value then value=default end
        return math.max(low,math.min(high,math.floor(value)))
    end
    local R={enabled=config.enabled~=false,closed=false,stats={},labels={},rows={},head=1,count=0,
        stack={},depth=0,wrapped=setmetatable({},{__mode='k'}),sequence=0,
        droppedRows=0,droppedFields=0,droppedLabels=0,droppedScopes=0,providerLost=0,
        fileFailures=0,writeFailures=0,hostFailures=0,writtenRows=0,writtenBytes=0,
        instrumentationMs=0,instrumentationCalls=0,instrumentationMaxMs=0,
        tickCount=0,busyTicks=0,busySampleMs=0,deferredMaintenance=0,providerSequence=0,providerLossThrough=0,geometryReused=0,
        fileIndex=1,fileBytes=0,fileOpened=false,nextFlush=0,nextState=0,nextReport=0,stateCache={},gameTime='unknown',
        channels={},channelList={},rowChannel={},supportCount=0}
    R.maxRows=clamp(config.maxRows,512,16,1024)
    R.maxLabels=clamp(config.maxLabels,256,4,512)
    R.maxSamples=clamp(config.maxSamples,128,16,256)
    -- maxFiles is intentionally ignored: completed files are retained indefinitely.
    R.maxFiles=0
    R.maxFileBytes=clamp(config.maxFileBytes,8388608,16384,16777216)
    R.batchRows=clamp(config.batchRows,128,1,256)
    R.sampleMs=clamp(config.sampleMs,500,100,5000)
    R.reportMs=clamp(config.reportMs,5000,1000,30000)
    R.flushMs=clamp(config.flushMs,250,250,10000)
    R.budgetMs=clamp(config.budgetMs,8,1,1000)
    -- A blocking open/write/close runs on the game thread. Live Nasus session
    -- 381abd698fd9 had 875/1328 ms flushes while other processes loaded the
    -- disk. After a slow flush the next one waits longer (doubling, bounded);
    -- fast flushes decay the delay. Excess rows are counted drops, never replays.
    R.slowFlushMs=clamp(config.slowFlushMs,50,5,1000)
    R.maxFlushBackoffMs=clamp(config.maxFlushBackoffMs,4000,0,30000)
    R.flushBackoff=0;R.slowFlushes=0;R.slowestFlushMs=0
    -- Routine rows leave capacity for provider events and critical channels.
    R.criticalReserve=clamp(config.criticalReserve,math.floor(R.maxRows/8),0,math.floor(R.maxRows/4))
    -- Reserve existing ring capacity for complete provider groups. Optional
    -- legacy reports must leave the same headroom as routine channel records.
    R.providerReserve=math.floor(R.maxRows/8)
    R.maxChannels=clamp(config.maxChannels,16,1,32)
    -- Priority rows may replace at most this many routine host samples per
    -- flush window when the ring is full. Other components' rows are never
    -- evicted, and ordinary capacity is unchanged when no priority row arrives.
    R.priorityEvictions=clamp(config.priorityEvictions,32,0,256)
    R.routine={};R.priorityUsed=0;R.evictedRoutine=0;R.droppedPriority=0;R.sampling=false
    local clock=g.GetTickCount
    R.clockKind='GetTickCount milliseconds; quantized callback clock'
    if type(clock)~='function' then
        local cpu=g.os and g.os.clock or os.clock
        clock=function()return cpu()*1000 end
        R.clockKind='os.clock CPU milliseconds; not wall time'
    end
    local timingFields={'returnRequestedAt','returnObservedAt','returnAccepted','manualAt','preparationMs','preparationBudget',
                            'positionPasses','nativePlacementConfirmedAt','screenPlacementConfirmedAt','preparedAt','warpStartedAt',
                            'gameplayValidatedAt','commitValidatedAt','budgetEnd','buttonReleaseCompletedAt','buttonRetries',
                            'buttonPhysical','pathObservedAt','pathResult','handoffStatus','interferenceCause'}
    local geometryFields={'requestedWorld','actionScreen','playerScreen','playerWorld','screenAtSend','worldAtSend','returnTarget','returnSample','observedEndpoint'}
    local geometryCache,geometryOrder,geometryCursor={},{},1
    local lastClock=0
    local function now()
        local ok,v=pcall(clock)
        if ok and type(v)=='number' and v==v and v~=math.huge and v~=-math.huge then lastClock=math.max(lastClock,v)end
        return lastClock
    end
    R.session=type(config.session)=='string' and config.session:sub(1,96)
        or tostring(manifest.generation or 'unknown'):sub(1,32)..':'..tostring(now())..':'..tostring(family):sub(-24)
    local function scalar(v)
        local t=type(v)
        if t=='string' then return v:sub(1,192) end
        if t=='boolean' then return v end
        if t=='number' and v==v and v~=math.huge and v~=-math.huge then return v end
        return 'unknown'
    end
    local function read(object,key)
        if not object then return nil end
        local ok,value=pcall(function()return object[key]end)
        if ok then return value end
        R.hostFailures=R.hostFailures+1
    end
    local function sampleCall(object,key,...)
        local fn=read(object,key);if type(fn)~='function'then return 'unknown'end
        local ok,value=pcall(fn,...)
        if ok then return scalar(value)end
        R.hostFailures=R.hostFailures+1;return 'unknown'
    end
    local function hasEntries(value)return type(value)=='table' and next(value)~=nil end
    R.passiveHolds={}
    function R:ObservePassiveHold(key,owner,lease,condition)
        local input=g.SDK and g.SDK.Input
        if not input or type(key)~='number'or type(owner)~='string'or type(lease)~='number'
            or type(condition)~='function'or input.KeysOwned[key]~=owner or not input.KeyLeases or input.KeyLeases[key]~=lease then return false end
        local count=0;for _ in pairs(self.passiveHolds)do count=count+1 end
        if not self.passiveHolds[key]and count>=8 then return false end
        self.passiveHolds[key]={owner=owner,lease=lease,condition=condition};return true
    end
    function R:ForgetPassiveHold(key,lease)
        local row=self.passiveHolds[key];if row and row.lease==lease then self.passiveHolds[key]=nil end
    end
    function R:Idle()
        local sdk=g.SDK;local input=sdk and sdk.Input
        if not input then return false end -- Unknown provider ownership is not idle evidence.
        if input.Active or (tonumber(input.InFlight) or 0)>0 or (tonumber(input.Step) or 0)>0
            or input.PendingReturn or input.Uncertain or input.Resolving
            or input.CleanupPending or input.PendingCleanup then return false end
        if input.KeysOwned==true then return false end
        for key,owner in pairs(type(input.KeysOwned)=='table'and input.KeysOwned or{})do
            local hold=self.passiveHolds[key]
            if not hold or hold.owner~=owner or not input.KeyLeases or input.KeyLeases[key]~=hold.lease then return false end
            local ok,active=pcall(hold.condition);if not ok or active~=true then self.passiveHolds[key]=nil;return false end
        end
        for _,key in ipairs({'Buttons','PendingUp','Cleanup','PendingReleases'}) do
            local v=input[key]
            if v==true or hasEntries(v) then return false end
        end
        local cursor=sdk.Cursor
        return not (cursor and ((tonumber(cursor.Step) or 0)>0 or cursor.Active))
    end
    function R:EvictRoutine()
        -- O(1): only the oldest row, and only when it is a routine host sample.
        if self.priorityUsed>=self.priorityEvictions or not self.routine[self.head] then return false end
        self.rows[self.head]=nil;self.routine[self.head]=nil;self.rowChannel[self.head]=nil;self.head=self.head%self.maxRows+1;self.count=self.count-1
        self.priorityUsed=self.priorityUsed+1;self.evictedRoutine=self.evictedRoutine+1;self.droppedRows=self.droppedRows+1
        return true
    end
    local reservedKeys={kind=true,at=true,sequence=true,session=true,gameTime=true,invalidUtf8=true}
    -- One admission path for legacy rows (channel=nil) and component channel rows.
    -- priority=true keeps the wardjump contract: when the ring is full it may
    -- replace the oldest routine host sample (bounded per flush window).
    local function append(self,kind,fields,limit,channel,priority,provider)
        if not self.enabled or self.closed then return false end
        if not provider and not priority and self.count>=self.maxRows-self.providerReserve then
            self.droppedRows=self.droppedRows+1
            if channel then channel.dropped=channel.dropped+1;channel.quotaDropped=channel.quotaDropped+1 end
            return false
        end
        if self.count>=self.maxRows and not (priority==true and self:EvictRoutine()) then
            self.droppedRows=self.droppedRows+1
            if priority==true then self.droppedPriority=self.droppedPriority+1 end
            if channel then channel.dropped=channel.dropped+1;if priority==true then channel.priorityDropped=channel.priorityDropped+1 end end
            return false
        end
        self.sequence=self.sequence+1
        local row={kind=type(kind)=='string' and kind:sub(1,80) or 'unknown',at=now(),sequence=self.sequence,session=self.session,gameTime=self.gameTime}
        local n=0
        if type(fields)=='table' then
            for key,value in pairs(fields) do
                n=n+1
                if n>limit then self.droppedFields=self.droppedFields+1;if channel then channel.truncated=channel.truncated+1 end;break end
                if type(key)=='string' and not reservedKeys[key] then
                    row[key:sub(1,64)]=scalar(value)
                    if type(value)=='table' or type(value)=='userdata' or type(value)=='function' then self.droppedFields=self.droppedFields+1 end
                else self.droppedFields=self.droppedFields+1 end
            end
        end
        local slot=(self.head+self.count-1)%self.maxRows+1
        self.rows[slot]=row;self.routine[slot]=self.sampling or nil;self.rowChannel[slot]=channel;self.count=self.count+1
        if channel then channel.rows=channel.rows+1;channel.pending=channel.pending+1 end
        return true,slot,row
    end
    function R:Event(kind,fields,priority)return (append(self,kind,fields,24,nil,priority))end

    -- Component channels: one registration per family component/controller.
    -- Callers test Wants(category) (or the `enabled`/`closed` fields) before
    -- building a record, so a disabled path allocates nothing.
    local Channel={};Channel.__index=Channel
    local componentAliases={champion='AyyyyIO',host_tick_interval='Family',host='host'}
    local function componentOf(label)
        local head=type(label)=='string' and label:match('^([^.]+)') or 'unknown'
        return componentAliases[head] or head
    end
    R.componentOf=componentOf
    function Channel:Wants(category)
        return R.enabled and not R.closed and not self.closed and self.categories[category]==true
    end
    -- Capacity inspection does not count a discarded routine sample as a lost
    -- critical event. Event still performs admission when the caller sends.
    function Channel:Remaining()
        if not R.enabled or R.closed or self.closed then return 0 end
        return math.max(0,math.min(self.quota-self.pending,R.maxRows-math.max(R.criticalReserve,R.providerReserve)-R.count))
    end
    -- Admission check for a routine (non-critical) row before its fields are
    -- built: same category, reserve and quota rules as Event. A capacity refusal
    -- is counted as the dropped row Event would have counted.
    function Channel:Admits(category)
        if not R.enabled or R.closed or self.closed then return false end
        if category~=nil and self.categories[category]~=true then self.suppressed=self.suppressed+1;return false end
        if R.count>=R.maxRows-math.max(R.criticalReserve,R.providerReserve) or self.pending>=self.quota then
            R.droppedRows=R.droppedRows+1;self.dropped=self.dropped+1;self.quotaDropped=self.quotaDropped+1
            return false
        end
        return true
    end
    function Channel:SetCategory(category,enabled)
        if type(category)=='string' and #category<=32 then self.categories[category]=enabled==true end
    end
    function Channel:Kind(kind)
        kind=tostring(kind)
        if kind:sub(1,#self.prefix)==self.prefix then return kind end
        return self.prefix..kind
    end
    local function flatten(ch,fields,out)
        -- One level only: vectors become X/Z (or X/Y) and arrays become counts.
        -- Other nested tables are counted as dropped, never serialized.
        local n=1;local limit=ch.maxFields
        for key,value in pairs(fields) do
            if n>=limit then ch.truncated=ch.truncated+1;break end
            if type(key)=='string' and not reservedKeys[key] and key~='component' then
                local t=type(value)
                if t=='table' then
                    local x,y,z=rawget(value,'x'),rawget(value,'y'),rawget(value,'z')
                    if type(x)=='number' and (type(z)=='number' or type(y)=='number') then
                        out[key..'X']=x
                        if type(z)=='number' then out[key..'Z']=z else out[key..'Y']=y end
                        n=n+2;ch.flattened=ch.flattened+1
                    elseif rawget(value,1)~=nil then
                        out[key..'Count']=#value;n=n+1;ch.summarized=ch.summarized+1
                    else ch.droppedFields=ch.droppedFields+1 end
                elseif t=='userdata' or t=='function' or t=='thread' then ch.droppedFields=ch.droppedFields+1
                else out[key]=value;n=n+1 end
            else ch.droppedFields=ch.droppedFields+1 end
        end
        out.component=ch.component
        return out
    end
    -- Coalescing: two call sites describing one event in the same callback
    -- (a legacy journal row and its trace row) become one row named after the
    -- trace kind. Only a row still queued in the ring, appended at the same
    -- recorder clock sample, with no conflicting identity field, is merged.
    -- Otherwise both rows are kept: coalescing never discards information.
    local matchKeys={'request','owner','slot','cursorID','reason','state'}
    function Channel:Coalesce(legacy,trace,where)
        legacy=self:Kind(legacy);trace=self:Kind(trace)
        local pair={legacy=legacy,trace=trace,where=where}
        self.partners[legacy]=self.partners[legacy] or {};table.insert(self.partners[legacy],pair)
        self.partners[trace]=self.partners[trace] or {};table.insert(self.partners[trace],pair)
    end
    local function satisfies(pair,traceFields)
        if not pair.where then return true end
        for key,value in pairs(pair.where)do if traceFields[key]~=value then return false end end
        return true
    end
    local function coalesce(ch,kind,out)
        local candidates=ch.partners[kind];if not candidates then return false end
        local at=now()
        for _,pair in ipairs(candidates)do
            local other=pair.legacy==kind and pair.trace or pair.legacy
            local last=ch.lastByKind[other]
            if last and R.rows[last.slot]==last.row and last.row.at==at
                and satisfies(pair,kind==pair.trace and out or last.row) then
                local row=last.row;local conflict=false
                for _,key in ipairs(matchKeys)do
                    local a,b=row[key],out[key]
                    if a~=nil and b~=nil and a~=b then conflict=true;break end
                end
                if not conflict then
                    local n=0;for _ in pairs(row)do n=n+1 end
                    for key,value in pairs(out)do
                        if row[key]==nil and type(key)=='string' and not reservedKeys[key] then
                            if n>=ch.maxFields+5 then ch.truncated=ch.truncated+1;break end
                            row[key:sub(1,64)]=scalar(value);n=n+1
                        end
                    end
                    row.kind=pair.trace;row.coalesced=pair.legacy
                    ch.lastByKind[other]=nil;ch.coalesced=ch.coalesced+1
                    return true
                end
            end
        end
        return false
    end
    -- Protected without a per-call closure.
    local function admit(ch,kind,out,priority)
        if coalesce(ch,kind,out)then return true end
        return append(R,kind,out,ch.maxFields,ch,priority)
    end
    -- Event(kind, fields, category, critical). category may be a string
    -- (subject to Wants), nil (always on) or true (priority: the wardjump trace
    -- contract). Critical/priority rows bypass the channel quota and the
    -- critical reserve and may evict routine host samples when the ring is full.
    function Channel:Event(kind,fields,category,critical)
        if not R.enabled or R.closed or self.closed then return false end
        if category==true then category=nil;critical=true end
        if category~=nil and self.categories[category]~=true then self.suppressed=self.suppressed+1;return false end
        if not critical and (R.count>=R.maxRows-math.max(R.criticalReserve,R.providerReserve) or self.pending>=self.quota) then
            R.droppedRows=R.droppedRows+1;self.dropped=self.dropped+1;self.quotaDropped=self.quotaDropped+1
            return false
        end
        kind=self:Kind(kind)
        local out=self.scratch
        if type(fields)=='table' then flatten(self,fields,out) else out.component=self.component end
        local ok,result,slot,row=pcall(admit,self,kind,out,critical==true)
        for key in pairs(out)do out[key]=nil end
        if not ok then self.errors=self.errors+1;return false end
        if slot and self.partners[kind] then self.lastByKind[kind]={slot=slot,row=row} end
        return result==true
    end
    function Channel:Close(reason)
        if self.closed then return end
        self:Event('channel_closed',{reason=type(reason)=='string' and reason or nil},nil,true)
        self.closed=true;self.enabled=false
    end
    local channelCounters={'rows','written','dropped','quotaDropped','priorityDropped','writeDropped','droppedFields',
        'flattened','summarized','truncated','suppressed','coalesced','errors'}
    function R:Channel(component,options)
        if not self.enabled or self.closed then return nil,'recorder_disabled' end
        if type(component)~='string' or component=='' or #component>48 then return nil,'invalid_component' end
        options=type(options)=='table' and options or {}
        local configured=type(config.categories)=='table' and config.categories[component]
        local existing=self.channels[component]
        if existing and not existing.closed then
            -- A second registrant (the development trace attach and the
            -- controller logger) shares the channel. It may only add categories
            -- and fill identity fields that are still unspecified.
            if type(options.categories)=='table' then
                for k,v in pairs(options.categories)do
                    if type(k)=='string' and existing.categories[k]==nil then existing.categories[k]=v==true end
                end
                if type(configured)=='table' then for k,v in pairs(configured)do if type(k)=='string' then existing.categories[k]=v==true end end end
            end
            if existing.build=='unknown' and options.build~=nil then existing.build=scalar(options.build)end
            if existing.clock=='unspecified' and type(options.clock)=='string' then existing.clock=options.clock:sub(1,96)end
            if existing.provisional and type(options.categories)=='table' then
                -- A bare trace attach reserved the channel; the owning logger sets its bounds once.
                existing.provisional=false
                existing.quota=clamp(options.quota,existing.quota,1,self.maxRows)
                existing.maxFields=clamp(options.maxFields,existing.maxFields,8,48)
                self:Event('channel_adopted',{component=component,build=existing.build,quota=existing.quota,maxFields=existing.maxFields})
            end
            return existing
        end
        if not existing and #self.channelList>=self.maxChannels then return nil,'channel_limit' end
        local categories={}
        if type(options.categories)=='table' then for k,v in pairs(options.categories)do if type(k)=='string' then categories[k]=v==true end end end
        -- Development manifest overrides: diagnostics.categories[component][name]=bool.
        if type(configured)=='table' then for k,v in pairs(configured)do if type(k)=='string' then categories[k]=v==true end end end
        local ch=setmetatable({component=component,enabled=true,closed=false,
            prefix=(type(options.prefix)=='string' and options.prefix or component)..'.',
            build=options.build~=nil and scalar(options.build) or 'unknown',
            clock=type(options.clock)=='string' and options.clock:sub(1,96) or 'unspecified',
            categories=categories,maxFields=clamp(options.maxFields,32,8,48),
            quota=clamp(options.quota,math.floor(self.maxRows/2),1,self.maxRows),scratch={},
            partners={},lastByKind={},pending=0,provisional=type(options.categories)~='table'},Channel)
        for _,key in ipairs(channelCounters)do ch[key]=0 end
        if existing then
            -- Replacement keeps cumulative evidence; a reload must not reset loss counters.
            for _,key in ipairs(channelCounters)do ch[key]=existing[key]end
            ch.pending=existing.pending;ch.replacements=(existing.replacements or 0)+1
            for index,row in ipairs(self.channelList)do if row==existing then self.channelList[index]=ch end end
            for slot,owner in pairs(self.rowChannel)do if owner==existing then self.rowChannel[slot]=ch end end
        else self.channelList[#self.channelList+1]=ch end
        self.channels[component]=ch
        local enabled={};for k,v in pairs(categories)do if v then enabled[#enabled+1]=k end end;table.sort(enabled)
        self:Event('channel_registered',{component=component,build=ch.build,clock=ch.clock,prefix=ch.prefix,
            categories=table.concat(enabled,','),quota=ch.quota,maxFields=ch.maxFields,replacements=ch.replacements or 0})
        return ch
    end
    function R:Changed(kind,key,fields,priority)
        -- Internal fixed identity/index keys only. No unbounded object-ID cache.
        local previous=self.stateCache[key];local changed=not previous
        if previous then
            for name,value in pairs(fields)do if previous[name]~=value then changed=true;break end end
            if not changed then for name in pairs(previous)do if fields[name]==nil then changed=true;break end end end
        end
        if changed and self:Event(kind,fields,priority)then self.stateCache[key]=fields;return true end
        return false
    end
    local function cost(started)
        local elapsed=math.max(0,now()-started)
        R.instrumentationMs=R.instrumentationMs+elapsed
        R.instrumentationCalls=R.instrumentationCalls+1
        R.instrumentationMaxMs=math.max(R.instrumentationMaxMs,elapsed)
    end
    local function stat(label)
        local row=R.stats[label]
        if row then return row end
        if #R.labels>=R.maxLabels then R.droppedLabels=R.droppedLabels+1;return nil end
        row={calls=0,errors=0,total=0,inclusiveTotal=0,max=0,inclusiveMax=0,overBudget=0,
            inclusiveOverBudget=0,samples={},inclusiveSamples={},index=0}
        R.stats[label]=row;R.labels[#R.labels+1]=label
        return row
    end
    local function sample(row,exclusive,inclusive)
        row.calls=row.calls+1;row.total=row.total+exclusive;row.inclusiveTotal=row.inclusiveTotal+inclusive
        row.max=math.max(row.max,exclusive);row.inclusiveMax=math.max(row.inclusiveMax,inclusive)
        if exclusive>R.budgetMs then row.overBudget=row.overBudget+1 end
        if inclusive>R.budgetMs then row.inclusiveOverBudget=row.inclusiveOverBudget+1 end
        row.index=row.index%R.maxSamples+1;row.samples[row.index]=exclusive;row.inclusiveSamples[row.index]=inclusive
    end
    -- Forward protected-call results on the Lua stack. No per-call result table.
    local function finishScope(row,label,frame,depth,began,started,ok,...)
        local ended=now()
        local inclusive=math.max(0,ended-started)
        sample(row,math.max(0,inclusive-frame.children),inclusive)
        if not ok then
            row.errors=row.errors+1
            R:Event('scope_error',{label=label,error=scalar((...))})
        end
        R.depth=depth-1
        local finished=now();local elapsed=math.max(0,finished-began)
        if R.depth>0 then local parent=R.stack[R.depth];parent.children=parent.children+elapsed end
        local overhead=math.max(0,started-began)+math.max(0,finished-ended)
        R.instrumentationMs=R.instrumentationMs+overhead;R.instrumentationCalls=R.instrumentationCalls+1
        R.instrumentationMaxMs=math.max(R.instrumentationMaxMs,overhead)
        if not ok then error((...),0) end
        return ...
    end
    function R:Wrap(object,method,label)
        if not self.enabled or self.closed or type(object)~='table' or type(object[method])~='function' then return false end
        label=type(label)=='string' and label:sub(1,96) or tostring(method):sub(1,96)
        local methods=self.wrapped[object]
        if methods and methods[method] then return false end
        local row=stat(label);if not row then return false end
        methods=methods or {};self.wrapped[object]=methods;methods[method]=true
        local original=object[method]
        object[method]=function(...)
            if not R.enabled or R.closed then return original(...) end
            if R.depth>=32 then R.droppedScopes=R.droppedScopes+1;return original(...) end
            local began=now();R.depth=R.depth+1
            local depth=R.depth;local frame=R.stack[depth] or {};R.stack[depth]=frame;frame.children=0
            local started=now()
            return finishScope(row,label,frame,depth,began,started,pcall(original,...))
        end
        return true
    end
    function R:Count(object,method,label)
        -- Native enumeration is frequent and usually below the clock resolution.
        -- Count attempts without clocks, pcall or a packed result per host call.
        -- The containing controller scope still measures the full operation.
        if not self.enabled or self.closed or type(object)~='table' or type(object[method])~='function' then return false end
        label=type(label)=='string' and label:sub(1,96) or tostring(method):sub(1,96)
        local methods=self.wrapped[object]
        if methods and methods[method] then return false end
        if self.stats[label] then return false end
        local row=stat(label);if not row then return false end
        row.countOnly=true
        methods=methods or {};self.wrapped[object]=methods;methods[method]=true
        local original=object[method]
        object[method]=function(...)
            if R.enabled and not R.closed then row.calls=row.calls+1 end
            return original(...)
        end
        return true
    end
    local function quantiles(values)
        local list={};for i=1,#values do list[i]=values[i]end;table.sort(list)
        local function q(p)return list[math.max(1,math.ceil(#list*p))] or 0 end
        return q(.5),q(.95),q(.99)
    end
    function R:Report()
        -- Called by idle Maintenance only. Sorting is excluded from owned input intervals.
        if not self:Idle()then return false end
        self.reportIndex=self.reportIndex or 1
        local finish=math.min(#self.labels,self.reportIndex+31)
        for index=self.reportIndex,finish do
            local label=self.labels[index]
            local row=self.stats[label]
            if row.countOnly then
                self:Event('host_calls',{label=label,component=componentOf(label),calls=row.calls,measurement='attempts_only',timingMeasured=false})
            else
            local p50,p95,p99=quantiles(row.samples)
            local i50,i95,i99=quantiles(row.inclusiveSamples)
            self:Event('scope',{label=label,component=componentOf(label),calls=row.calls,errors=row.errors,totalMs=row.total,
                maxMs=row.max,p50Ms=p50,p95Ms=p95,p99Ms=p99,budgetMs=self.budgetMs,overBudget=row.overBudget,
                inclusiveTotalMs=row.inclusiveTotal,inclusiveMaxMs=row.inclusiveMax,inclusiveP50Ms=i50,
                inclusiveP95Ms=i95,inclusiveP99Ms=i99,inclusiveOverBudget=row.inclusiveOverBudget,samples=#row.samples})
            end
        end
        self.reportIndex=finish+1
        if self.reportIndex<=#self.labels then return false end
        local perf=g.SDK and g.SDK.Performance
        if not self.sdkReport and perf and type(perf.Snapshot)=='function' then
            local ok,snapshot=pcall(perf.Snapshot,perf)
            if ok and type(snapshot)=='table' and type(snapshot.subsystems)=='table' then
                local retained={}
                for label,row in pairs(snapshot.subsystems)do
                    if #retained>=self.maxLabels then self.droppedLabels=self.droppedLabels+1;break end
                    retained[#retained+1]={label=label,row=row}
                end
                self.sdkReport={rows=retained,index=1,resolution=snapshot.resolution}
            else self.hostFailures=self.hostFailures+1 end
        end
        if self.sdkReport then
            local report=self.sdkReport;local finish=math.min(#report.rows,report.index+31)
            for index=report.index,finish do
                    local entry=report.rows[index];local row,label=entry.row,entry.label
                    if type(row)=='table' then
                        local inclusive=type(row.inclusive)=='table' and row.inclusive or {}
                        self:Event('sdk_scope',{label=label,component='Orbama',calls=row.calls,totalMs=row.total,maxMs=row.max,
                            p50Ms=row.median or row.p50,p95Ms=row.p95,p99Ms=row.p99,over50Ms=row.over50,over100Ms=row.over100,
                            inclusiveTotalMs=inclusive.total,inclusiveMaxMs=inclusive.max,inclusiveP50Ms=inclusive.median or inclusive.p50,
                            inclusiveP95Ms=inclusive.p95,inclusiveP99Ms=inclusive.p99,resolution=report.resolution})
                    end
            end
            report.index=finish+1
            if report.index<=#report.rows then return false end
            self.sdkReport=nil
        end
        local overlay=g.SDK and g.SDK.Overlay
        if overlay and type(overlay.Snapshot)=='function'then
            -- Idle report only; Snapshot reads retained render counters, not native projections.
            local ok,snapshot=pcall(overlay.Snapshot,overlay)
            if ok and type(snapshot)=='table'then
                local utils=g.SDK.OrbamaUtils;local enabled
                if utils and utils.config and type(utils.config.visible)=='function'then
                    local read,value=pcall(utils.config.visible,utils.config,'awareness','Minimap')
                    if read then enabled=value end
                end
                self:Event('overlay_minimap',{source=snapshot.minimapSource,anchors=snapshot.minimapAnchors,
                    projectionMisses=snapshot.minimapMisses,minimapEnabled=enabled,displaySource=snapshot.displaySource,
                    projections=snapshot.projections,primitives=snapshot.primitives,breakdown=snapshot.breakdown,failures=snapshot.failures,
                    p95Ms=snapshot.p95,p99Ms=snapshot.p99,clock=snapshot.clock,collectUs=snapshot.collectUs,dispatchUs=snapshot.dispatchUs,
                    batchUs=snapshot.batchUs,timedFrames=snapshot.timedFrames,
                    damageRowsQueued=snapshot.damageRowsQueued,damageRowsSkipped=snapshot.damageRowsSkipped,
                    damageLastTarget=snapshot.damageLastTarget,damageLastX=snapshot.damageLastX,damageLastY=snapshot.damageLastY,damageLastAnchor=snapshot.damageLastAnchor})
            end
        end
        local preparation=g.SDK and g.SDK.Preparation
        local metrics=type(preparation)=='table' and preparation.version==1 and preparation.metrics
        if type(metrics)=='table'then
            self:Event('preparation_budget',{targetHz=preparation.targetHz,
                allowanceMs=preparation.allowance,admissionCostMs=preparation.spent,
                measuredCostMs=preparation.actualSpent,usedUnits=preparation.used,
                mandatoryEstimateMs=preparation.mandatoryEstimate,lastTickMs=preparation.lastTickMs,
                runs=metrics.runs,declined=metrics.declined,errors=metrics.errors,incomplete=metrics.incomplete,
                overruns=metrics.overruns,missedDeadlines=metrics.missedDeadlines,
                totalMs=metrics.totalMs,maxMs=metrics.maxMs,clockQuality=preparation.clockQuality,
                semantics='optional preparation; not render FPS'})
        end
        for _,ch in ipairs(self.channelList)do
            self:Event('channel',{component=ch.component,build=ch.build,clock=ch.clock,rows=ch.rows,pending=ch.pending,
                written=ch.written,dropped=ch.dropped,quotaDropped=ch.quotaDropped,priorityDropped=ch.priorityDropped,
                writeDropped=ch.writeDropped,droppedFields=ch.droppedFields,flattened=ch.flattened,summarized=ch.summarized,
                truncated=ch.truncated,suppressed=ch.suppressed,coalesced=ch.coalesced,errors=ch.errors,
                closed=ch.closed==true,replacements=ch.replacements or 0,
                semantics='cumulative per component; suppressed=category off, coalesced=merged duplicate, not lost'})
        end
        self:Event('recorder',{ticks=self.tickCount,busyTicks=self.busyTicks,busySampleMs=self.busySampleMs,
            instrumentationMs=self.instrumentationMs,instrumentationCalls=self.instrumentationCalls,
            instrumentationMaxMs=self.instrumentationMaxMs,droppedRows=self.droppedRows,droppedFields=self.droppedFields,
            evictedRoutine=self.evictedRoutine,droppedPriority=self.droppedPriority,
            droppedLabels=self.droppedLabels,droppedScopes=self.droppedScopes,providerLost=self.providerLost,
            geometryReused=self.geometryReused,
            fileFailures=self.fileFailures,writeFailures=self.writeFailures,hostFailures=self.hostFailures,
            writtenRows=self.writtenRows,writtenBytes=self.writtenBytes,deferredMaintenance=self.deferredMaintenance,
            cadenceSemantics='host tick cadence, not render FPS',memoryKB=self.memoryKB or 'unknown',
            instrumentationScope='partial: Tick/Maintenance plus Wrap bookends; standalone Event copy cost omitted; A/A measurement required'})
        if self.slowFlushes>0 then
            self:Changed('recorder_io','recorderIO',{slowFlushes=self.slowFlushes,slowestFlushMs=self.slowestFlushMs,
                flushBackoffMs=self.flushBackoff,slowFlushMs=self.slowFlushMs,
                semantics='blocking file open/write/close on the game thread; later flushes deferred'})
        end
        self.reportIndex=nil
        return true
    end
    function R:SampleHost()
        if not self:Idle()then return end
        local function field(object,key)return scalar(read(object,key))end
        local hero=g.myHero
        local sdk=g.SDK;local modes=read(read(sdk,'Orbwalker'),'Modes')
        local modeRow={}
        for _,name in ipairs({'COMBO','HARASS','LANECLEAR','JUNGLECLEAR','LASTHIT','FLEE'})do
            local key=read(sdk,'ORBWALKER_MODE_'..name)
            modeRow[name]='unknown'
            if key~=nil then modeRow[name]=field(modes,key)end
        end
        self:Changed('modes','modes',modeRow)
        local active=read(hero,'activeSpell');local pos=read(hero,'pos')
        local fps=read(g.Game,'FPS')
        if type(fps)=='function'then local okay,value=pcall(fps);fps=okay and value or nil end
        fps=type(fps)=='number' and scalar(fps) or 'unknown'
        local globalMouse=read(g,'mousePos');local nativeMouse
        local mouseFn=read(g.Game,'mousePos')
        if type(mouseFn)=='function'then
            local okay,value=pcall(mouseFn)
            if okay then nativeMouse=value else self.hostFailures=self.hostFailures+1 end
        end
        self:Changed('player','player',{identity=field(hero,'charName'),id=field(hero,'networkID'),team=field(hero,'team'),
            health=field(hero,'health'),maxHealth=field(hero,'maxHealth'),mana=field(hero,'mana'),maxMana=field(hero,'maxMana'),
            dead=field(hero,'dead'),x=field(pos,'x'),z=field(pos,'z'),activeName=field(active,'name'),activeValid=field(active,'valid'),
            activeTarget=field(active,'target'),activeStart=field(active,'startTime'),activeEnd=field(active,'castEndTime'),
            channel=field(active,'isChanneling'),autoAttack=field(active,'isAutoAttack'),map=scalar(g.Game and g.Game.mapID),renderFPS=fps,
            globalMouseX=field(globalMouse,'x'),globalMouseZ=field(globalMouse,'z'),
            nativeMouseX=field(nativeMouse,'x'),nativeMouseZ=field(nativeMouse,'z')})
        self:Changed('player_gate','playerGate',{charging=field(active,'isCharging'),activeValid=field(active,'valid'),activeName=field(active,'name'),
            chatOpen=sampleCall(g.Game,'IsChatOpen'),ctrlDown=sampleCall(g.Control,'IsKeyDown',17),altDown=sampleCall(g.Control,'IsKeyDown',18)})
        local getSpell=read(hero,'GetSpellData')
        for _,slot in ipairs({0,1,2,3,4,5,12})do
            local ok,spell=false,nil
            if type(getSpell)=='function' then ok,spell=pcall(getSpell,hero,slot)end
            if not ok then self.hostFailures=self.hostFailures+1 end
            self:Changed('spell','playerSpell'..slot,{slot=slot,name=field(spell,'name'),rank=field(spell,'level'),cooldown=field(spell,'currentCd'),
                mana=field(spell,'mana'),ammo=field(spell,'ammo'),stage=field(spell,'toggleState'),usable=slot<=3 and sampleCall(g.Game,'CanUseSpell',slot)or 'unknown'})
        end
        local getItem=read(hero,'GetItemData')
        local utility=read(sdk,'OrbamaUtils')
        local locations=read(read(utility,'observations'),'locations');local bases=read(locations,'bases')
        local blue=read(read(bases,100),'pos');local red=read(read(bases,200),'pos')
        self:Changed('bases','bases',{spawnPointType=scalar(g.Obj_AI_SpawnPoint),objectCount=sampleCall(g.Game,'ObjectCount'),
            objectReader=type(read(g.Game,'Object'))=='function',scanIndex=field(locations,'index'),
            blueX=field(blue,'x'),blueZ=field(blue,'z'),redX=field(red,'x'),redZ=field(red,'z'),map=scalar(g.Game.mapID)})
        local utilityConfig=read(utility,'config');local getOption=read(utilityConfig,'get')
        local function option(name)
            if type(getOption)~='function'then return 'unknown'end
            local ok,value=pcall(getOption,utilityConfig,name)
            if ok then return scalar(value)end;return 'unknown'
        end
        self:Changed('inventory','inventory',{available=type(getItem)=='function',
            itemsEnabled=option('items'),offenseEnabled=option('offense'),unidentifiedActiveSampleMs=1000})
        self.itemSpellProbes=self.itemSpellProbes or {}
        local probeClock=now()
        for index=1,6 do
            local slot=index+5;local native=read(g,'ITEM_'..index)
            if native==nil then native=slot end
            local known=type(native)=='number'and native==native and native>=0 and native<256 and native%1==0
            local ok,item=false,nil
            if type(getItem)=='function'then
                ok,item=pcall(getItem,hero,slot)
                if not ok then self.hostFailures=self.hostFailures+1 end
            end
            local id=field(item,'itemID')
            local probe=self.itemSpellProbes[index]
            -- An unreadable/zero inventory ID is not evidence that its native
            -- active spell slot is empty. Probe independently, bounded to 1 Hz
            -- for unidentified slots; keep ordinary owned-item sampling fresh.
            if not known then probe=nil;self.itemSpellProbes[index]=nil
            elseif (type(id)=='number'and id>0 or not probe or probe.slot~=native or probe.itemID~=id
                or probeClock<probe.at or probeClock>=probe.at+1000)then
                probe={slot=native,itemID=id,at=probeClock,spellRead=false,usableRead=false}
                if type(getSpell)=='function'then
                    local found,value=pcall(getSpell,hero,native)
                    probe.spellRead=found and value~=nil
                    if found then
                        probe.name=field(value,'name');probe.cooldown=field(value,'currentCd');probe.range=field(value,'range')
                    else self.hostFailures=self.hostFailures+1 end
                end
                local canUse=read(g.Game,'CanUseSpell')
                if type(canUse)=='function'then
                    local found,value=pcall(canUse,native)
                    probe.usableRead=found and value~=nil
                    if found then probe.usable=scalar(value)else self.hostFailures=self.hostFailures+1 end
                end
                self.itemSpellProbes[index]=probe
            end
            self:Changed('item','playerItem'..index,{index=index,slot=slot,nativeSlot=known and native or 'unknown',
                itemID=id,stacks=field(item,'stacks'),ammo=field(item,'ammo'),hotkey=field(g,'HK_ITEM_'..index),
                inventoryRead=ok,itemSpellRead=probe and probe.spellRead or false,itemUsableRead=probe and probe.usableRead or false,
                name=probe and probe.name or 'unknown',cooldown=probe and probe.cooldown or 'unknown',
                usable=scalar(probe and probe.usable),range=probe and probe.range or 'unknown'})
        end
        local game=g.Game;local countFn=game and game.HeroCount;local unitFn=game and game.Hero
        local ok,count=false,nil
        if type(countFn)=='function' then ok,count=pcall(countFn)end
        if not ok or type(count)~='number' or count~=count then self:Event('heroes',{count='unknown'});return end
        count=math.max(0,math.floor(count));self:Changed('heroes','heroCount',{count=count,sampled=math.min(count,10),truncated=count>10})
        if type(unitFn)~='function' then return end
        for index=1,math.min(count,10) do
            local found,unit=pcall(unitFn,index)
            if found and unit then
                local a=read(unit,'activeSpell');local p=read(unit,'pos');local attack=read(unit,'attackData')
                self:Changed('hero','hero'..index,{id=field(unit,'networkID'),identity=field(unit,'charName'),team=field(unit,'team'),
                    handle=field(unit,'handle'),valid=field(unit,'valid'),immortal=field(unit,'isImmortal'),
                    health=field(unit,'health'),dead=field(unit,'dead'),visible=field(unit,'visible'),targetable=field(unit,'isTargetable'),
                    x=field(p,'x'),z=field(p,'z'),cast=field(a,'name'),castValid=field(a,'valid'),target=field(a,'target'),
                    castStart=field(a,'startTime'),castEnd=field(a,'castEndTime'),isAutoAttack=field(a,'isAutoAttack'),
                    attackTarget=field(attack,'target'),attackEnd=field(attack,'endTime'),attackWindup=field(attack,'windUpTime'),
                    attackWinddown=field(attack,'windDownTime'),attackAnimation=field(attack,'animationTime')})
                if unit~=hero and read(unit,'team')~=read(hero,'team')then
                    local getter=read(unit,'GetSpellData')
                    for _,slot in ipairs({0,1,2,3,4,5,12})do
                        local okay,spell=false,nil
                        if type(getter)=='function'then okay,spell=pcall(getter,unit,slot)end
                        if not okay then self.hostFailures=self.hostFailures+1 end
                        self:Changed('hero_spell','heroSpell'..index..':'..slot,{id=field(unit,'networkID'),slot=slot,
                            name=field(spell,'name'),rank=field(spell,'level'),cooldown=field(spell,'currentCd'),
                            ammo=field(spell,'ammo'),mana=field(spell,'mana'),stage=field(spell,'toggleState')})
                    end
                end
            else self.hostFailures=self.hostFailures+1 end
        end
    end
    -- Live cost of host calls and native draw calls (development only, idle, twice
    -- per session at 2 and 10 game minutes). Each probe repeats one call until
    -- 4 ms of os.clock pass (cap 20000) and subtracts an empty call; a draw probe
    -- issues 200 nearly transparent primitives in one Draw frame. Results are CPU
    -- time inside the call, not GPU cost or FPS.
    function R:ProbeHostCost()
        if config.allowProbes~=true then return end
        local cpu=g.os and g.os.clock or os.clock
        if type(cpu)~='function' then return end
        local hero=g.myHero;local game=g.Game
        if not hero or not game then return end
        local function measure(fn)
            if not pcall(fn) then return 'unavailable' end
            local n,start=0,cpu();local stop=start+.004
            repeat for _=1,50 do fn() end;n=n+50 until cpu()>=stop or n>=20000
            return (cpu()-start)*1e6/n
        end
        local probes={
            {'empty',function()end},
            {'health',function()return hero.health end},
            {'pos',function()return hero.pos end},
            {'posX',function()return hero.pos.x end},
            {'activeSpell',function()return hero.activeSpell end},
            {'buffCount',function()return hero.buffCount end},
            {'GetBuff',function()return hero:GetBuff(0)end},
            {'GetSpellData',function()return hero:GetSpellData(0)end},
            {'spellCd',function()return hero:GetSpellData(0).currentCd end},
            {'Timer',function()return game.Timer()end},
            {'CanUseSpell',function()return game.CanUseSpell(0)end},
            {'HeroCount',function()return game.HeroCount()end},
            {'Hero',function()return game.Hero(1)end},
            {'MinionCount',function()return game.MinionCount()end},
            {'To2D',function()return hero.pos:To2D()end},
        }
        local row={gameTime=self.gameTime,clock='os.clock; CPU microseconds per call minus an empty call',probe=(self.probes or 0)+1}
        local empty=measure(probes[1][2])
        for i=2,#probes do
            local v=measure(probes[i][2])
            row['us_'..probes[i][1]]=type(v)=='number'and type(empty)=='number'and math.floor(math.max(0,v-empty)*100+.5)/100 or v
        end
        self:Event('host_cost',row)
        local draw=g.Draw;local callback=g.Callback
        if not draw or not callback or type(callback.Add)~='function' or self.drawProbe then return end
        local recorder=self;local id
        local fn=function()
            if not recorder.drawProbe or recorder.drawProbe.done then return end
            recorder.drawProbe.done=true
            local color=draw.Color and draw.Color(1,0,0,0);local p=hero.pos
            local out={gameTime=recorder.gameTime,clock='os.clock; CPU microseconds per native call, 200 calls',probe=recorder.probes}
            local function time(key,f,...)
                if not pcall(f,...) then out[key]='unavailable';return end
                local start=cpu();for _=1,200 do f(...)end
                out[key]=math.floor((cpu()-start)*1e6/200*100+.5)/100
            end
            for _,k in ipairs({'Rect','Text','Circle','Line'})do
                local f=draw[k]
                if type(f)=='function' and color then
                    local args=k=='Rect'and{0,0,1,1,color}or k=='Text'and{'.',10,0,0,color}or k=='Circle'and{p,50,1,color}or{0,0,1,1,1,color}
                    time('us_'..k,f,unpack(args))
                end
            end
            -- Panel-sized primitives: a 22x16 cell, a two-digit countdown, a status line.
            if color and type(draw.Rect)=='function' then time('us_RectCell',draw.Rect,0,0,22,16,color)end
            if color and type(draw.Text)=='function' then
                time('us_TextDigits',draw.Text,'12',12,0,0,color)
                time('us_TextLine',draw.Text,'Spell farming [I] - limited by mana',12,0,0,color)
            end
            -- Sprites: a private copy of one loaded overlay asset (the overlay's own
            -- objects keep their cached scale and tint), drawn nearly transparent.
            local overlay=g.SDK and g.SDK.Overlay;local path
            for _,asset in pairs(overlay and overlay.assets or {})do
                local okPath,value=pcall(function()return asset and asset.path end)
                if okPath and type(value)=='string' then path=value;break end
            end
            local okSprite,sprite=false,nil
            if path and type(g.Sprite)=='function' then okSprite,sprite=pcall(g.Sprite,path)end
            if okSprite and sprite and color and pcall(sprite.SetColor,sprite,color) then
                time('us_SpriteSetScale',sprite.SetScale,sprite,.3)
                time('us_SpriteSetColor',sprite.SetColor,sprite,color)
                time('us_SpriteDraw',sprite.Draw,sprite,0,0)
            else out.us_SpriteDraw='unavailable' end
            recorder:Event('draw_cost',out)
            if id~=nil and type(callback.Del)=='function' then pcall(callback.Del,'Draw',id)end
        end
        self.drawProbe={done=false}
        local ok,value=pcall(callback.Add,'Draw',fn);if ok then id=value end
    end
    function R:DrainProvider(started)
        if not self.enabled or self.closed then return end
        started=started or now()
        local input=g.SDK and g.SDK.Input
        if input~=self.provider then
            self.provider=input;self.providerSequence=0;self.providerLossThrough=0
            geometryCache={};geometryOrder={};geometryCursor=1
        end
        if input and type(input.GetDiagnosticEvents)=='function' then
            local ok,events,lost=pcall(input.GetDiagnosticEvents,input,self.providerSequence,16)
            if ok and type(events)=='table' then
                -- The provider reports missing sequences immediately after the requested cursor.
                local skipped=math.max(0,tonumber(lost)or 0)
                local gapEnd=self.providerSequence+skipped
                if skipped>0 then
                    self.providerLost=self.providerLost+math.max(0,gapEnd-math.max(self.providerSequence,self.providerLossThrough))
                    self.providerLossThrough=math.max(self.providerLossThrough,gapEnd)
                end
                for i=1,math.min(#events,16) do
                    local event=events[i]
                    if type(event)=='table' and type(event.sequence)=='number' and event.sequence>self.providerSequence then
                        -- Keep this event in provider history until every output row fits.
                        local geometry={providerSequence=event.sequence,providerSession=event.session,id=event.id};local hasGeometry=false
                        for _,key in ipairs(geometryFields)do
                            local point=event[key]
                            if type(point)=='table'then
                                hasGeometry=true;geometry[key..'X']=point.x
                                local world=key=='requestedWorld'or key=='playerWorld'or key=='worldAtSend'or key=='observedEndpoint'
                                if world then geometry[key..'YorZ']=point.z else geometry[key..'YorZ']=point.y end
                            end
                        end
                        local geometryKey=event.id or 'no_action';local previous=geometryCache[geometryKey]
                        local geometryAt=type(event.at)=='number'and event.at or started
                        local reuseGeometry=hasGeometry and previous and geometryAt>=previous.at and geometryAt<previous.at+1000
                        if reuseGeometry then
                            for key,value in pairs(geometry)do
                                if key~='providerSequence'and previous.row[key]~=value then reuseGeometry=false;break end
                            end
                            if reuseGeometry then for key,value in pairs(previous.row)do
                                if key~='providerSequence'and geometry[key]~=value then reuseGeometry=false;break end
                            end end
                        end
                        local emitGeometry=hasGeometry and not reuseGeometry
                        -- Development attribution row: the provider's triggering input
                        -- edge, interference source and chord key. Only for rows whose
                        -- cause is otherwise unattributable (manual cancellations,
                        -- releases, echoes, interference) or chord commands.
                        local edge=type(event.inputEdge)=='table'and event.inputEdge or nil
                        local attribute=event.commandKey2~=nil or event.kind=='cancel_all'or event.kind=='interference'
                            or event.kind=='input_release'or event.kind=='key_echo_inferred'or event.kind=='mouse_echo_inferred'
                            or event.kind=='chat_guard'or event.kind=='button_physical_takeover'
                        local hasTiming=false
                        for _,key in ipairs(timingFields)do if event[key]~=nil then hasTiming=true;break end end
                        if self.maxRows-self.count<1+(emitGeometry and 1 or 0)+(hasTiming and 1 or 0)+(attribute and 1 or 0)+(event.kind=='hover_obstructed'and 1 or 0)then break end
                        local fields={providerSequence=event.sequence,eventKind=event.kind,providerAt=event.at,providerSession=event.session}
                        for _,key in ipairs({'id','owner','scope','actionType','targetID','commandKey','state','reason','requestedAt',
                            'acquiredAt','positionedAt','sentAt','sendCompletedAt','observedAt','releasedAt','uncertain','observation','interrupted','pointerMove','holdUntil','waitBlock'})do fields[key]=event[key]end
                        fields.buttonPending=event.buttonPending
                        if hasGeometry then fields.geometrySequence=reuseGeometry and previous.row.providerSequence or event.sequence end
                        -- Button state alone needs no auxiliary row. Keep all base fields
                        -- even when every optional input fact is present.
                        append(self,'input_event',fields,27,nil,false,true)
                        if attribute then
                            append(self,'input_attribution',{providerSequence=event.sequence,id=event.id,eventKind=event.kind,
                                inputMessage=edge and edge.message,inputParam=edge and edge.param,inputEdgeAt=edge and edge.at,
                                inputClassification=edge and edge.classification,interferenceID=event.interferenceID,
                                interferenceAt=event.interferenceAt,interferenceCause=event.interferenceCause,
                                competitor=event.competitor,commandKey=event.commandKey,commandKey2=event.commandKey2},24,nil,false,true)
                        end
                        if hasTiming then
                            local timing={providerSequence=event.sequence,id=event.id,buttonPending=event.buttonPending}
                            for _,key in ipairs(timingFields)do timing[key]=event[key]end
                            append(self,'input_timing',timing,24,nil,false,true)
                        end
                        if emitGeometry then
                            append(self,'input_geometry',geometry,24,nil,false,true)
                            if not previous then
                                if #geometryOrder<64 then geometryOrder[#geometryOrder+1]=geometryKey
                                else geometryCache[geometryOrder[geometryCursor]]=nil;geometryOrder[geometryCursor]=geometryKey;geometryCursor=geometryCursor%64+1 end
                            end
                            geometryCache[geometryKey]={at=geometryAt,row=geometry}
                        elseif reuseGeometry then self.geometryReused=self.geometryReused+1 end
                        if event.kind=='hover_obstructed'then
                            local hover={providerSequence=event.sequence,id=event.id,owner=event.owner}
                            for _,key in ipairs({'hoverName','hoverType','hoverTeam','hoverRadius','hoverX','hoverZ','hoverDistance','hoverReadFailed','pointerMove'})do hover[key]=event[key]end
                            append(self,'input_hover',hover,24,nil,false,true)
                        end
                        self.providerSequence=event.sequence
                    end
                end
            else self.hostFailures=self.hostFailures+1 end
        end
    end
    function R:Tick()
        if not self.enabled or self.closed then return end
        local started=now();self.tickCount=self.tickCount+1;self.sampling=false
        if g.Game and type(g.Game.Timer)=='function'then local okay,value=pcall(g.Game.Timer);self.gameTime=okay and scalar(value)or 'unknown'end
        local idle=self:Idle()
        if not idle then self.busyTicks=self.busyTicks+1 end
        if self.lastTick then
            local delta=math.max(0,started-self.lastTick)
            if self.lastBusy then self.busySampleMs=self.busySampleMs+delta end
            local row=stat('host_tick_interval');if row then sample(row,delta,delta)end
        end
        self.lastTick=started;self.lastBusy=not idle
        if not idle then cost(started);return end
        -- Complete provider groups get first use of free rows. Sampling and
        -- reports may use only the capacity left after the provider reserve.
        self:DrainProvider(started)
        if started>=self.nextState then
            self.nextState=started+self.sampleMs
            local gc=g.collectgarbage or collectgarbage
            if type(gc)=='function' then local ok,kb=pcall(gc,'count');self.memoryKB=ok and scalar(kb) or 'unknown' end
            self.sampling=true;self:SampleHost();self.sampling=false
        end
        if type(self.gameTime)=='number' and self.gameTime>=(self.probes==1 and 600 or 120) and (self.probes or 0)<2 then
            self.probes=(self.probes or 0)+1;self.drawProbe=nil
            local ok,err=pcall(self.ProbeHostCost,self)
            if not ok then self:Event('host_cost',{error=tostring(err)})end
        end
        cost(started)
    end
    -- Host strings can contain arbitrary bytes from invalid native objects.
    -- Preserve valid UTF-8, escaping only invalid bytes so JSONL stays UTF-8.
    local function nativeText(value)
        if not value:find('[\128-\255]')then return value end
        local i,start,n=1,1,#value;local parts
        local function continuation(b)return b and b>=128 and b<=191 end
        while i<=n do
            local b=value:byte(i);local width
            if b<128 then width=1
            else
                local c,d,e=value:byte(i+1,i+3)
                if b>=194 and b<=223 and continuation(c)then width=2
                elseif b>=224 and b<=239 and continuation(c)and continuation(d)
                    and(b~=224 or c>=160)and(b~=237 or c<=159)then width=3
                elseif b>=240 and b<=244 and continuation(c)and continuation(d)and continuation(e)
                    and(b~=240 or c>=144)and(b~=244 or c<=143)then width=4 end
            end
            if width then i=i+width
            else
                parts=parts or {};parts[#parts+1]=value:sub(start,i-1)
                parts[#parts+1]=string.char(92)..string.format('u%04x',b)
                i=i+1;start=i
            end
        end
        if not parts then return value end
        parts[#parts+1]=value:sub(start);return table.concat(parts)
    end
    local function escape(value)
        local escaped=value:gsub('[%z\1-\31\\"]',function(c)
            local aliases={['"']='\\"',['\\']='\\\\',['\n']='\\n',['\r']='\\r',['\t']='\\t'}
            return aliases[c] or string.format('\\u%04x',string.byte(c))
        end)
        local safe=nativeText(escaped)
        return '"'..safe..'"',safe~=escaped
    end
    local function encode(row)
        local keys={};for key in pairs(row)do keys[#keys+1]=key end;table.sort(keys)
        local parts={};local invalid=false
        for _,key in ipairs(keys)do
            local value=row[key];local t=type(value)
            local encodedKey,badKey=escape(key);local encodedValue,badValue
            if t=='string'then encodedValue,badValue=escape(value)
            else encodedValue=t=='number'and tostring(value)or value==true and 'true'or 'false'end
            invalid=invalid or badKey or badValue
            parts[#parts+1]=encodedKey..':'..encodedValue
        end
        if invalid then parts[#parts+1]='"invalidUtf8":true'end
        return '{'..table.concat(parts,',')..'}\n'
    end
    local directory=type(config.directory)=='string' and config.directory or (g.COMMON_PATH or g.SCRIPT_PATH or '')
    if directory~='' and not directory:match('[/\\]$')then directory=directory..'/'end
    R.pathPrefix=directory..'FamilyTelemetry-v2-'
    function R:SetEnabled(value)
        if self.closed then return false end
        if value and self.instrumentationError then return false end
        local store=self.recordingStore
        if value and store and (store.full or store.error or store.sharing or self.sharePending)then return false end
        if self.enabled==(value==true)then return true end
        if not value then self:Event('recording_paused',{})end
        self.enabled=value==true
        if self.enabled then
            self.nextState=0;self.nextReport=0;self.stateCache={}
            self:Event('session_header',{generation=family.generation,event='recording_started',session=self.session,
                detail=manifest.development and 'development'or 'support',semantics='sends are not hits; loss counters report gaps'})
        end
        return true
    end
    -- One writer owns this stream. Exponential/binary probing finds a free index
    -- without listing the directory or reading old logs. Holes are safe: every
    -- new segment checks its candidate again and all writes use append mode.
    -- Probe work persists across maintenance calls and is bounded per call.
    function R:RecoverFiles(ioLib)
        local search=self.fileSearch or {low=0,probe=1}
        self.fileSearch=search
        for attempt=1,16 do
            if not self:Idle()then return false,'input_busy' end
            local index=search.probe
            if index>=9007199254740990 then return false,'retention_index_exhausted' end
            local ok,file,reason,errno=pcall(ioLib.open,self.pathPrefix..index..'.jsonl','rb')
            if not ok then return false,'retention_open_failed' end
            local exists=file~=nil
            if exists then
                local closeOK,closed=pcall(file.close,file)
                if not closeOK or not closed then return false,'retention_close_failed' end
            elseif errno~=2 then return false,'retention_open_failed' end
            if search.linear then
                if exists then search.probe=index+1
                else self.fileIndex=index;self.segment=index-1;self.filesRecovered=true;self.fileSearch=nil;return true end
            else
                if exists then search.low=index else search.high=index end
                if search.high then
                    if search.high-search.low<=1 then
                        self.fileIndex=search.high;self.segment=search.high-1
                        self.filesRecovered=true;self.fileSearch=nil;return true
                    end
                    search.probe=math.floor((search.low+search.high)/2)
                else search.probe=index*2 end
            end
        end
        return false,'retention_pending'
    end
    function R:NextFile()
        self.fileIndex=self.fileIndex+1;self.fileBytes=0;self.fileOpened=false
        self.filesRecovered=false;self.fileSearch={linear=true,probe=self.fileIndex}
    end
    -- Request only metadata here. Existing idle maintenance finishes the queued
    -- rows and rotates once, so browser-selected files stop changing in-game.
    function R:RequestShare()
        if self.closed or not self.enabled and not self.recordingStore then return nil end
        self.shareSerial=(self.shareSerial or 0)+1
        self.sharePending={id=self.shareSerial,through=self.sequence}
        return self.shareSerial
    end
    function R:FinishShare()
        local pending=self.sharePending
        if not pending then return end
        local nextRow=self.count>0 and self.rows[self.head]
        if nextRow and nextRow.sequence<=pending.through then return end
        if self.recordingStore then
            self.enabled=false
            self.recordingStore:RequestShare()
            self.sharePending=nil
            return
        end
        self.shareReady={id=pending.id,first=self.supportFirst,last=self.supportLast,count=self.supportCount}
        self.sharePending=nil
        if self.fileOpened then self:NextFile()end
    end
    function R:IOElapsed(ioStarted)
        local elapsed=math.max(0,now()-ioStarted)
        if elapsed>=self.slowFlushMs then
            self.slowFlushes=self.slowFlushes+1;self.slowestFlushMs=math.max(self.slowestFlushMs,elapsed)
            self.flushBackoff=math.min(self.maxFlushBackoffMs,math.max(self.flushMs,self.flushBackoff*2))
        else
            self.flushBackoff=math.floor(self.flushBackoff/2)
            if self.flushBackoff<self.flushMs then self.flushBackoff=0 end
        end
        if self.flushBackoff>0 then self.nextFlush=math.max(self.nextFlush,now()+self.flushMs+self.flushBackoff)end
        return elapsed
    end
    function R:Maintenance(force)
        if self.recordingStore then
            if self.depth>0 or not self:Idle()then return false,'input_busy'end
            local store=self.recordingStore
            if store.sharing then
                local started=now()
                if started<(self.nextShare or 0)then return false,'throttled'end
                local ok,why=store:Maintenance()
                self:IOElapsed(started);self.nextShare=now()+self.flushBackoff;cost(started)
                return ok,why
            end
            local started=now()
            if not force and started<self.nextFlush then return false,'throttled'end
            self.nextFlush=started+self.flushMs+self.flushBackoff
            if self.enabled and not self.closed then
                self:DrainProvider(started)
                if started>=self.nextReport then
                    if self:Report()then self.nextReport=started+self.reportMs end
                end
            end
            if self.count==0 then self:FinishShare();return true end
            local lines,bytes={},0
            for i=1,math.min(self.count,self.batchRows)do
                local row=self.rows[(self.head+i-2)%self.maxRows+1]
                local line=encode(row);local oversized=#line>16384
                if oversized then
                    line=encode({kind='recording_row_dropped',session=self.session,at=row.at,
                        gameTime=row.gameTime,sequence=row.sequence,reason='row_too_large',encodedBytes=#line})
                end
                if bytes+#line>16384 then break end
                if oversized then self.droppedRows=self.droppedRows+1 end
                lines[#lines+1]=line;bytes=bytes+#line
            end
            -- Serialization may run host callbacks. Recheck before any disk IO.
            if not self:Idle()then return false,'input_busy'end
            local ioStarted=now()
            local ok,why=store:Append(table.concat(lines))
            self:IOElapsed(ioStarted)
            for _=1,#lines do
                local ch=self.rowChannel[self.head]
                if ch then
                    ch.pending=ch.pending-1
                    if ok then ch.written=ch.written+1 else ch.writeDropped=ch.writeDropped+1 end
                end
                self.rowChannel[self.head]=nil;self.rows[self.head]=nil;self.routine[self.head]=nil
                self.head=self.head%self.maxRows+1;self.count=self.count-1
            end
            if ok then self.writtenBytes=self.writtenBytes+bytes;self.writtenRows=self.writtenRows+#lines
            else self.droppedRows=self.droppedRows+#lines;self.writeFailures=self.writeFailures+1;self.enabled=false end
            self.priorityUsed=0;self:FinishShare();cost(started)
            return ok,why
        end
        if not self.enabled then return false,'disabled' end
        local started=now()
        if self.depth>0 or not self:Idle()then self.deferredMaintenance=self.deferredMaintenance+1;return false,'input_busy' end
        if not force and started<self.nextFlush then return false,'throttled' end
        self.nextFlush=started+self.flushMs
        self:DrainProvider(started)
        if not self.closed and (self.reportIndex or started>=self.nextReport)then
            if self:Report()then self.nextReport=started+self.reportMs end
        end
        if self.count==0 then self:FinishShare();cost(started);return true end
        local ioLib=g.io or io
        if not ioLib or type(ioLib.open)~='function' then self.fileFailures=self.fileFailures+1;cost(started);return false,'io_unavailable' end
        if not self.filesRecovered then
            local recovered,reason=self:RecoverFiles(ioLib)
            if not recovered then
                self.retentionError=reason
                if reason=='input_busy' or reason=='retention_pending' then self.deferredMaintenance=self.deferredMaintenance+1
                else self.fileFailures=self.fileFailures+1 end
                cost(started);return false,reason
            end
            self.retentionError=nil
        end
        local lines,bytes={},0
        for i=1,math.min(self.count,self.batchRows)do
            local line=encode(self.rows[(self.head+i-2)%self.maxRows+1])
            if bytes+#line>math.min(65536,self.maxFileBytes-2048)then break end
            lines[#lines+1]=line;bytes=bytes+#line
            if bytes>=65536 then break end
        end
        if self.fileBytes+bytes+2048>self.maxFileBytes then
            self:NextFile()
            local recovered,reason=self:RecoverFiles(ioLib)
            if not recovered then
                self.retentionError=reason
                if reason=='input_busy' or reason=='retention_pending' then self.deferredMaintenance=self.deferredMaintenance+1
                else self.fileFailures=self.fileFailures+1 end
                cost(started);return false,reason
            end
            self.retentionError=nil
        end
        local header=''
        if not self.fileOpened then
            header=encode({kind='session_header',session=self.session,at=self.rows[self.head].at,gameTime=self.gameTime,
                generation=scalar(family and family.generation or manifest.generation),fileIndex=self.fileIndex,segment=self.segment+1,
                droppedRows=self.droppedRows,providerLost=self.providerLost,fileFailures=self.fileFailures,writeFailures=self.writeFailures,
                clock=self.clockKind,semantics='input send is not a gameplay hit',writtenAt=now()})
        end
        bytes=bytes+#header
        local path=self.pathPrefix..self.fileIndex..'.jsonl'
        -- Recheck after serialization. No disk work is permitted inside an input host call.
        if not self:Idle() then self.deferredMaintenance=self.deferredMaintenance+1;cost(started);return false,'input_busy' end
        local ioStarted=now()
        local ok,file=pcall(ioLib.open,path,'ab')
        if not ok or not file then
            self.fileFailures=self.fileFailures+1
            if not self.fileOpened then self.filesRecovered=false;self.fileSearch={linear=true,probe=self.fileIndex} end
            self:IOElapsed(ioStarted);cost(started);return false,'open_failed'
        end
        -- Identify this reload's files without reading or copying the recording.
        if self.supportLast~=self.fileIndex then
            self.supportFirst=self.supportFirst or self.fileIndex
            self.supportLast=self.fileIndex;self.supportCount=self.supportCount+1
        end
        if header~=''then self.segment=self.segment+1 end
        local wrote,result=pcall(file.write,file,header..table.concat(lines))
        local closed,closeResult=pcall(file.close,file)
        self:IOElapsed(ioStarted)
        if not wrote or result==nil or result==false or not closed or closeResult==nil or closeResult==false then
            self.writeFailures=self.writeFailures+1
            -- Keep partial/uncertain evidence exactly as written. Never replay it;
            -- continue new rows in another file, including after a failed close.
            self:NextFile()
        else
            self.fileOpened=true;self.fileBytes=self.fileBytes+bytes
            self.writtenRows=self.writtenRows+#lines;self.writtenBytes=self.writtenBytes+bytes
        end
        local failed=not wrote or result==nil or result==false or not closed or closeResult==nil or closeResult==false
        for i=1,#lines do
            local ch=self.rowChannel[self.head]
            if ch then
                ch.pending=ch.pending-1
                if failed then ch.writeDropped=ch.writeDropped+1 else ch.written=ch.written+1 end
                self.rowChannel[self.head]=nil
            end
            self.rows[self.head]=nil;self.routine[self.head]=nil;self.head=self.head%self.maxRows+1;self.count=self.count-1
        end
        self.priorityUsed=0
        if failed then self.droppedRows=self.droppedRows+#lines end
        -- Use newly freed capacity before subsequent routine callbacks refill
        -- the ring. No disk work or host geometry queries occur in this drain.
        if not self.closed and self:Idle()then self:DrainProvider(now())end
        self:FinishShare()
        cost(started);return wrote and result~=nil and result~=false and closed and closeResult~=nil and closeResult~=false
    end
    function R:Close()
        if self.closed then return end
        self:Event('close',{pendingRows=self.count,droppedRows=self.droppedRows})
        self.closed=true
        -- Trace sinks test these fields before constructing a row.
        for _,ch in ipairs(self.channelList)do ch.closed=true;ch.enabled=false end
        -- At most one safe batch. Shutdown never forces input cleanup or unsafe disk IO.
        self:Maintenance(true)
        if self.recordingStore then self.recordingStore:Close()end
    end
    R:Event('session',{generation=family and family.generation or manifest.generation,
        dataRevision=manifest.dataRevision,build=manifest.sha256 or manifest.buildHash,
        clock=R.clockKind,quantileWindow=R.maxSamples,maxRows=R.maxRows,maxFiles=R.maxFiles,
        maxFileBytes=R.maxFileBytes,retention='append_only',semantics='sent, mechanically observed and gameplay outcome remain separate'})
    return R
end

end
