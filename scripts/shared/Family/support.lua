return function()
-- Shared opt-in support controls. File IO stays in idle recorder maintenance.
return function(g,family)
    local recorder=family.diagnostics
    local store=recorder.recordingStore
    local directory=recorder.pathPrefix:gsub('FamilyTelemetry%-v2%-$','')
    local S={closed=false}
    local function now()
        return type(g.GetTickCount)=='function'and g.GetTickCount()or os.clock()*1000
    end
    function S:Publish(lines)
        self.lines=lines;self.columns=nil;self.layoutAt=0;self.expires=now()+90000
    end
    function S:Show()
        if self.closed then return false end
        if store then store.shareReady=false end
        self.request=recorder:RequestShare()
        self:Publish({self.request and 'Preparing FamilySupport.jsonl when input is idle...'or 'Recording is unavailable.',
            'Recording pauses while the share file is prepared.', 'Folder: '..directory})
        return self.request~=nil
    end
    function S:Tick()
        if self.closed then return end
        local sdk=g.SDK;local main=sdk and sdk.Menu and sdk.Menu.Main
        if not self.menu and main then
            main:MenuElement({type=g.MENU,id='SupportLogs',name='Support logs'})
            self.menu=main.SupportLogs
            if type(self.menu.Hide)=='function'then self.menu:Hide(false)end
            self.menu:MenuElement({id='record',name='Record support logs',value=false})
            self.menu:MenuElement({type=g.SPACE,name='Recording starts off each reload'})
            self.menu:MenuElement({type=g.SPACE,name='Keeps 5 recordings, up to 8 MiB each'})
            self.menu:MenuElement({type=g.SPACE,name='Share file: FamilySupport.jsonl'})
            self.menu:MenuElement({type=g.SPACE,name='Folder: LOLEXT > Scripts > Common'})
            self.menu:MenuElement({id='share',name='Prepare share file and show location',value=false})
            self.menu:MenuElement({id='dismiss',name='Hide instructions',value=false})
            self.menu.record:Value(false);self.menu.share:Value(false);self.menu.dismiss:Value(false)
        end
        if self.menu and self.menu.record:Value()~=recorder.enabled then
            if not recorder:SetEnabled(self.menu.record:Value())then self.menu.record:Value(recorder.enabled)end
        end
        if self.menu and self.menu.share:Value()then self.menu.share:Value(false);self:Show()end
        if self.menu and self.menu.dismiss:Value()then
            self.menu.dismiss:Value(false);self.request=nil;self.lines=nil;self.displayLines=nil
        end
        local at=(self.lines or self.request)and now()or 0
        if recorder.instrumentationError and not self.instrumentationNotified then
            self.instrumentationNotified=true
            self:Publish({'Recording stopped: '..tostring(recorder.instrumentationError),
                'Detailed recording could not start. Reload before retrying.'})
        end
        if store and (store.full or store.error)and not self.storageNotified then
            self.storageNotified=true;recorder:SetEnabled(false)
            self:Publish({store.full and 'Recording stopped at the storage limit.'or 'Recording stopped: '..tostring(store.error),
                'Existing recordings are retained.', 'Folder: '..directory})
        end
        if self.menu and (self.request or store and(store.full or store.error))then self.menu.record:Value(false)end
        if self.request and store and store.shareReady then
            local lines={'Share this file: FamilySupport.jsonl','Folder: '..directory,
                'Recording is paused. Enable it again to continue.',
                'The file contains up to five recordings.', 'Nothing is uploaded automatically.'}
            self.request=nil;self:Publish(lines)
            if g.print then pcall(g.print,'[Support logs]\n'..table.concat(lines,'\n')..'\nRecording: '..recorder.session)end
        elseif self.request and store and store.error then
            self.request=nil;self:Publish({'Share file is incomplete: '..tostring(store.error),'Folder: '..directory})
        end
        if self.lines and at>=self.expires then self.lines=nil;self.displayLines=nil end
        if not self.scope and sdk and sdk.Overlay then
            self.scope=sdk.Overlay:Register('Family.support',{active=function()return not self.closed end})
            if self.scope then self.scope:Renderer('status',function(draw)self:Draw(draw)end,5)end
        end
        if self.lines and at>=self.layoutAt then
            self.layoutAt=at+1000
            local width=sdk and sdk.Overlay and sdk.Overlay.Viewport and select(1,sdk.Overlay:Viewport())or 1280
            local columns=math.max(24,math.min(120,math.floor((width-40)/9)))
            if columns~=self.columns then
                self.columns=columns;self.displayLines={}
                for _,line in ipairs(self.lines)do
                    local offset=1
                    while offset<=#line do
                        local last=math.min(#line,offset+columns-1)
                        -- UTF-8 continuation bytes stay with their leading byte.
                        while last>=offset and last<#line and line:byte(last+1)>=128 and line:byte(last+1)<192 do last=last-1 end
                        if last<offset then last=math.min(#line,offset+3)end
                        self.displayLines[#self.displayLines+1]=line:sub(offset,last);offset=last+1
                    end
                end
            end
        end
    end
    function S:Draw(draw)
        if self.closed or not self.displayLines then return end
        local color=draw.Color(255,225,235,255);local y=130
        for _,line in ipairs(self.displayLines)do draw.Text(line,15,20,y,color);y=y+20 end
    end
    function S:Close()
        if self.closed then return end
        self.closed=true
        if self.scope then self.scope:Close()end
        if self.menu and type(self.menu.Hide)=='function'then self.menu:Hide(true)end
    end
    return S
end

end
