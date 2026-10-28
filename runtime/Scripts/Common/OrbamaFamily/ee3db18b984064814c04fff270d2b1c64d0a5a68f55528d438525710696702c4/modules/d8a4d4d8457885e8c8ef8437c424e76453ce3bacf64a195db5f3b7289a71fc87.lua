return function(require)
local U=require('utils.util')
local Cooldowns=require('CombatProfiles.cooldowns')
local D={};D.__index=D
function D.new(c)return setmetatable({c=c,rows={}},D)end
function D:Build(observations,preparedConfig,kind)
    if not kind then self.sourceObservations=observations end
    local c=self.c;local cfg=preparedConfig or c.config;local rows={};local now=c:now();local h=c.g.myHero
    local function add(pos,text,color,radius,kind,team,wardKind,data)
        if pos and #rows<256 and cfg:includes(kind,team,pos)then rows[#rows+1]={pos=U.copy(pos),text=text,color=color,radius=radius,kind=kind,team=team,wardKind=wardKind,data=data}end
    end
    if (not kind or kind=='wardHistory')and cfg:get('wards')then for key,w in pairs(observations.wardHistory)do
        if cfg:includes('wards',w.team,w.pos)then
            local parts={}
            if cfg:wardVisible(w.kind,'ScreenDisplay')then parts[#parts+1]=w.name or 'Ward'end
            if w.owner and cfg:wardVisible(w.kind,'OwnerDisplay')then parts[#parts+1]=w.owner end


            add(w.pos,table.concat(parts,' / '),'ward',cfg:wardVisible(w.kind,'VisionDisplay')and U.finite(w.sightRange)and w.sightRange or nil,'wards',w.team,w.kind or 'Unknown',{id=w.id,key=key,handle=w.handle,name=w.name,expiresAt=w.expires,timer=cfg:wardVisible(w.kind,'TimerDisplay')})
        end
    end end
    if (not kind or kind=='turrets')and cfg:get('turrets')then for _,t in ipairs(observations.turrets)do
        if t.valid~=false and not t.dead and U.dist(h.pos,t.pos)<1500 then
            local range=t.range or t.attackRange
            local targeting=h.networkID and t.targetID==h.networkID
            range=U.finite(range)and range>0 and range or nil
            if targeting or range then add(t.pos,targeting and 'Turret targeting you'or '','turret',range,'turrets',t.team)end
        end
    end end
    if not kind or kind=='heroes'then for _,unit in ipairs(observations.heroes)do
            local id=U.id(unit)
            if unit.visible and not unit.dead then
                if cfg:get('waypoints')and unit.pathing and unit.pathing.hasMovePath and unit.pathing.endPos and(unit.ms or 0)>0 then
                    local options=cfg.drawOptions and cfg.drawOptions.waypoints
                    local name,time
                    if preparedConfig then
                        local content=preparedConfig.content.waypoints
                        name=not content or content.Name;time=not content or content.Time
                    else name=not options or options.Name:Value();time=not options or options.Time:Value()end
                    if name or time then add(unit.pathing.endPos,(name and unit.charName or '')..(time and ' ~'..string.format('%.1fs',U.dist(unit.pos,unit.pathing.endPos)/unit.ms)or ''),'unknown',nil,'waypoints',unit.team,nil,{id=id,unit=unit,handle=unit.handle,anchor='pathend'})end
                end
                local level=unit.levelData
                if cfg:get('experience')and level and U.finite(level.exp)then
                    add(unit.pos,'Level '..tostring(level.lvl)..' | XP '..math.floor(level.exp),'cooldown',nil,'experience',unit.team,nil,{id=id,unit=unit,handle=unit.handle})
                end
            end
            -- With an overlay the enemy panel draws from live state (PublishPanel).
            if cfg:get('cooldowns')and not c.overlayScope and unit.visible and not unit.dead then
                -- One cell per slot, ready and unlearned ones included, for the
                -- health-bar strip; the text keeps only the slots still cooling down.
                local values={};local learned=false
                for slot,d in pairs(observations.cooldowns[id]or {})do
                    local label=slot==12 and 'T'or({'Q','W','E','R','D','F'})[slot+1]
                    if label and U.finite(d.readyAt)then
                        local total=d.total or(U.finite(d.castAt)and d.readyAt-d.castAt or nil)
                        values[#values+1]={slot=slot,label=label,readyAt=d.readyAt,readyMin=d.readyMin,estimate=d.estimate,
                            learned=d.rank~=0,total=total,icon=slot>=4 and slot<=5 and Cooldowns.icon(d.name)or nil,
                            text=d.rank~=0 and Cooldowns.text(label,d.readyAt,d.readyMin,d.estimate,now)or nil}
                        learned=learned or d.rank~=0
                        -- Cached by the overlay after the first request.
                        local icon=values[#values].icon;local overlay=c.sdk and c.sdk.Overlay
                        if icon and overlay and overlay.PreparePortrait then overlay:PreparePortrait(icon,'summoner')end
                    end
                end
                table.sort(values,function(a,b)return a.slot<b.slot end)
                local text={};for _,v in ipairs(values)do if v.text then text[#text+1]=v.text end end
                if learned then add(unit.pos,table.concat(text,' '),'cooldown',nil,'cooldowns',unit.team,nil,{id=id,unit=unit,cooldowns=values,handle=unit.handle})end
            end
    end end
    if (not kind or kind=='lastSeen')and cfg:get('awareness')then
        local count=0;local identities=observations.heroIndex or {}
        if not observations.heroIndex then for i=1,math.min(32,#observations.heroes)do local unit=observations.heroes[i];identities[U.id(unit)]=unit end end
        for id,seen in pairs(observations.lastSeen)do
            -- Each retained observation is its own bounded job, including absent roster entries.
            local unit=identities[id]or seen.unit
            if count<32 and unit and U.id(unit)==id and unit.handle==seen.handle and unit.charName==seen.name and not unit.visible and not unit.dead
                and ((cfg:get('lastSeenRetention')or 0)<=0 or now-seen.at<=cfg:get('lastSeenRetention'))then
                add(seen.pos,'','unknown',nil,'awareness',seen.team,nil,{id=id,key=id,name=seen.name,at=seen.at,unit=unit,handle=seen.handle,estimated=seen.estimated,source=seen.source});count=count+1
            end
        end
    end
    local recalls={}
    if (not kind or kind=='recalls')and cfg:get('recalls')then for _,r in pairs(observations.recalls)do
        if r.status=='started'and(not r.ends or now<r.ends)and(r.id==U.id(h)and cfg:get('recallSelf')~=false or r.id~=U.id(h)and cfg:includes('recalls',r.team,r.pos))and #recalls<32 then
            recalls[#recalls+1]=r
        end
    end end
    return rows,recalls,now
end
-- Camp respawn timers are not drawn (player request 2026-10-10): the game shows
-- them on the minimap. The camp service still observes camps for Smite/routing.
local categories={{'wardHistory',512},{'turrets',128},{'heroes',32},{'lastSeen',32},{'recalls',32}}
local categoryKinds={'wardHistory','turrets','heroes','lastSeen','recalls'}
local flags={'draw','wards','turrets','awareness','waypoints','experience','cooldowns','recalls','trinket','allies','wardVision','lastSeenRetention','minimapSeconds','recallSelf'}
local contentOptions={'Allies','Enemies','Distance','Name','Time','ScreenDisplay','OwnerDisplay','TimerDisplay','VisionDisplay'}
function D:ResetPreparation()
    self.progress=nil;self.completed={};self.rows={};self.recallRows={};self.preparedAt=nil;self.sourceObservations=nil
end
-- Settings tracking: a flat list of (flag or option, last value) is rebuilt only
-- when the menu structure changes. Each refresh compares values in place and
-- bumps a change counter; the prepared snapshot is rebuilt only on a change.
local function differs(a,b)return a~=b and(a==a or b==b)end
local function groupSize(group)local n=0;if group then for _ in pairs(group)do n=n+1 end end;return n end
function D:SettingsSnapshot(values,captured)
    local cfg=self.c.config
    local snapshot=setmetatable({content=captured[1],get=function(_,key)return values[key]end},{__index=cfg})
    local hero=self.c.g.myHero
    function snapshot:includes(name,team,pos)
        local options=captured[1][name];local ally=team==hero.team
        if options then
            if not options[ally and 'Allies'or 'Enemies']then return false end
            local distance=options.Distance or 0
            if distance>0 and pos then local dx,dz=pos.x-hero.pos.x,pos.z-hero.pos.z
                if dx*dx+dz*dz>distance*distance then return false end
            end
        elseif cfg.drawOptions and ally and not values.allies then return false
        elseif not cfg.drawOptions then return cfg:includes(name,team,pos)end
        return true
    end
    function snapshot:wardVisible(kind,option)
        local node=captured[2][kind]or captured[2].Unknown
        if node then return node[option]end
        return option=='TimerDisplay'or option=='MinimapDisplay'or option=='VisionDisplay'and values.wardVision
    end
    return snapshot
end
function D:RefreshSettings()
    local cfg=self.c.config;local profile=self.c.profile and self.c.profile.id or 'unknown'
    local draw,ward=cfg.drawOptions or false,cfg.wardOptions or false
    local track=self.settingsTrack
    local changed=false
    if not track or track.profile~=profile or track.draw~=draw or track.ward~=ward
        or track.drawSize~=groupSize(cfg.drawOptions)or track.wardSize~=groupSize(cfg.wardOptions)then
        track={profile=profile,draw=draw,ward=ward,drawSize=groupSize(cfg.drawOptions),wardSize=groupSize(cfg.wardOptions),
            values={},captured={},options={},optionValues={},targets={},keys={}}
        for index,group in ipairs({cfg.drawOptions or {},cfg.wardOptions or {}})do
            track.captured[index]={}
            for name,node in pairs(group)do
                local row={};track.captured[index][name]=row
                for _,key in ipairs(contentOptions)do local option=node[key]
                    if option and option.Value then
                        local n=#track.options+1
                        track.options[n]=option;track.targets[n]=row;track.keys[n]=key
                    end
                end
            end
        end
        self.settingsTrack=track;changed=true
    end
    local values=track.values
    for _,key in ipairs(flags)do local value=cfg:get(key)
        if differs(value,values[key])then values[key]=value;changed=true end
    end
    local options,optionValues,targets,keys=track.options,track.optionValues,track.targets,track.keys
    for i=1,#options do local value=options[i]:Value()
        if differs(value,optionValues[i])then optionValues[i]=value;changed=true end
    end
    if changed or not self.cachedConfig then
        -- Snapshot tables are private copies; consumers never see live options.
        for i=1,#options do targets[i][keys[i]]=optionValues[i]end
        local captured={}
        for index,group in ipairs(track.captured)do captured[index]={}
            for name,row in pairs(group)do local copy={};for k,v in pairs(row)do copy[k]=v end;captured[index][name]=copy end
        end
        local copied={};for k,v in pairs(values)do copied[k]=v end
        self.settingsRevision=(self.settingsRevision or 0)+1
        self.cachedConfig=self:SettingsSnapshot(copied,captured)
    end
    return self.settingsRevision,self.cachedConfig
end

local stableKinds={awareness='lastSeen',wards='wardHistory'}
-- Cooldown strips are time-based and their unit is revalidated every frame.
local HERO_ROW_AGE=5
local stableEntries={lastSeen=true,wardHistory=true,recalls=true}
function D:CurrentContext()
    local c=self.c;local map=c.g.Game and c.g.Game.mapID;local profile=c.profile and c.profile.id
    if self.hasContext and(self.contextMap~=map or self.contextProfile~=profile)then self:ResetPreparation()end
    self.hasContext=true;self.contextMap=map;self.contextProfile=profile
end
-- Retained observations do not expire because an optional preparation pass was
-- refused. Check their actual source and lifecycle at every display callback.
function D:StableCurrent(row,now)
    local c=self.c;local kind=stableKinds[row.kind];if not kind then return false end
    local observations=c.observations or self.sourceObservations;if not observations then return false end
    local data=row.data or {};local source=(observations[kind]or {})[data.key or data.id]
    if not source or not source.pos or source.pos.x~=row.pos.x or source.pos.z~=row.pos.z then return false end
    if row.kind=='awareness'then
        local retention=c.config:get('lastSeenRetention')or 0
        return source.name==data.name and source.handle==data.handle and source.at==data.at
            and(source.map==nil or source.map==self.contextMap)and(source.profile==nil or source.profile==self.contextProfile)
            and(retention<=0 or now-data.at<=retention)
    elseif row.kind=='wards'then
        return source.name==data.name and source.handle==data.handle and source.team==row.team and(source.kind or 'Unknown')==row.wardKind
            and(not source.expires or source.expires>now)
    end
    return false
end
function D:RecallCurrent(r,now)
    local c=self.c;local unit=r.unit;local observations=c.observations or self.sourceObservations
    return observations and observations.recalls and observations.recalls[r.id]==r and r.status=='started'and(not r.ends or now<r.ends)and(not r.removeAt or now<r.removeAt)
        and(r.map==nil or r.map==self.contextMap)and(r.profile==nil or r.profile==self.contextProfile)
        and(not unit or U.id(unit)==r.id and unit.handle==r.handle and unit.charName==r.name and(r.status~='started'or not unit.dead))
        and(r.id==U.id(c.g.myHero)and c.config:get('recallSelf')~=false or r.id~=U.id(c.g.myHero)and c.config:includes('recalls',r.team,r.pos))
end

function D:Prepare(token)
    self:CurrentContext()
    local c=self.c;local now=c:now()
    local overlay=c.sdk and c.sdk.Overlay
    if overlay and c.config:get('draw')and(c.config:get('awareness')or c.config:get('recalls'))then
        -- Portraits are cached by the overlay; ask again only when the roster or the shape set changes.
        local heroes=c.observations.heroes;local circles=c.config:get('awareness')==true
        if self.portraitHeroes~=heroes or self.portraitCount~=#heroes or self.portraitCircles~=circles then
            self.portraitHeroes,self.portraitCount,self.portraitCircles=heroes,#heroes,circles
            for i=1,math.min(32,#heroes)do
                local name=heroes[i].charName
                overlay:PreparePortrait(name)
                if circles then overlay:PreparePortrait(name,'circle')end
            end
        end
    end
    if overlay and overlay.PrepareMinimap and c.config:get('draw')and(c.config:get('awareness')or c.config:get('wards'))and now>=(self.minimapPreparedAt or 0)then
        self.minimapPreparedAt=now+.1;overlay:PrepareMinimap(c.observations.heroes,c.observations.turrets)
    end
    if not c.config:get('draw')then self:ResetPreparation();return true end
    if not token then self.rows,self.recallRows=self:Build(c.observations);self.preparedAt=now;return true end
    local profile=c.profile and c.profile.id or 'unknown'
    local settingsNow=c.g.GetTickCount and c.g.GetTickCount()or now*1000
    if not self.cachedConfig or settingsNow>=(self.settingsAt or 0)or self.settingsProfile~=profile then
        self:RefreshSettings();self.settingsAt=settingsNow+100;self.settingsProfile=profile
    end
    local revision,preparedConfig=self.settingsRevision,self.cachedConfig
    if self.preparedRevision~=revision then
        self.progress=nil;self.completed=self.completed or {}
        for id,result in pairs(self.completed)do if not result.stable then self.completed[id]=nil end end
        self.preparedRevision=revision
    end
    local state=self.progress
    if not state then
        state={entries={},index=1};local present={}
        -- A category whose drawing is switched off would build only empty rows:
        -- its entries are not queued (hero rows draw waypoints, experience, or
        -- cooldown strips without the overlay panel).
        local cfg=preparedConfig
        local wanted={wardHistory=cfg:get('wards'),turrets=cfg:get('turrets'),lastSeen=cfg:get('awareness'),recalls=cfg:get('recalls'),
            heroes=cfg:get('waypoints')or cfg:get('experience')or cfg:get('cooldowns')and not c.overlayScope}
        for _,category in ipairs(categories)do
            local name,limit=category[1],category[2];local count=0
            for key,value in pairs(wanted[name]and c.observations[name]or {})do
                if count>=limit then break end;count=count+1
                local identity=name=='lastSeen'and key or U.id(value)or value.id or key;local id=name..':'..tostring(identity)
                state.entries[#state.entries+1]={kind=name,key=key,identity=identity,id=id};present[id]=true
            end
        end
        for id in pairs(self.completed)do if not present[id]then self.completed[id]=nil end end
        self.progress=state
    end
    -- Preparation-private scratch, cleared per call; results never retain it.
    local identities=self.scratchIdentities or {};self.scratchIdentities=identities
    for k in pairs(identities)do identities[k]=nil end
    for i=1,math.min(32,#c.observations.heroes)do local unit=c.observations.heroes[i];identities[U.id(unit)]=unit end
    local view=self.scratchView
    if not view then view={wardHistory={},turrets={},heroes={},recalls={},lastSeen={}};self.scratchView=view end
    for _,kind in ipairs(categoryKinds)do local t=view[kind];for k in pairs(t)do t[k]=nil end end
    view.heroIndex=identities;view.cooldowns=c.observations.cooldowns
    local worked=0
    while state.index<=#state.entries do
        if worked>0 and not token:Checkpoint(1)then break end
        local entry=state.entries[state.index];local value=(c.observations[entry.kind]or {})[entry.key]
        local identity=value and(entry.kind=='lastSeen'and entry.key or U.id(value)or value.id or entry.key)
        if value and identity==entry.identity then
            local key=(entry.kind=='heroes'or entry.kind=='turrets')and 1 or entry.key
            view[entry.kind][key]=value
            local result=self.completed[entry.id]
            local options=preparedConfig.content.awareness;local unit=entry.kind=='lastSeen'and(identities[entry.identity]or value.unit)
            local unchanged=entry.kind=='lastSeen'and result and result.source==value and result.revision==revision
                and options and options.Distance==0 and value.pos and result.posX==value.pos.x and result.posZ==value.pos.z
                and result.observedAt==value.at and result.name==value.name and result.handle==value.handle and result.team==value.team
                and result.estimated==value.estimated and result.observationSource==value.source and result.unit==unit
                and(not unit or result.visible==unit.visible and result.dead==unit.dead)
            if not unchanged then
                local rows,recalls,at=self:Build(view,preparedConfig,entry.kind)
                self.completed[entry.id]={rows=rows,recalls=recalls,at=at,stable=stableEntries[entry.kind],source=value,revision=revision,
                    posX=value.pos and value.pos.x,posZ=value.pos and value.pos.z,observedAt=value.at,name=value.name,handle=value.handle,team=value.team,
                    estimated=value.estimated,observationSource=value.source,unit=unit,visible=unit and unit.visible,dead=unit and unit.dead}
            end
            view[entry.kind][key]=nil
        else self.completed[entry.id]=nil end
        state.index=state.index+1;worked=worked+1
    end
    local rows,recalls={},{};local publishedAt=c:now()
    for _,entry in ipairs(state.entries)do
        local result=self.completed[entry.id]
        -- Hero rows (cooldown strips) wait for a whole budgeted cycle; their
        -- cells are refreshed from live observations in Draw.
        if result and(result.stable or publishedAt-result.at<=(entry.kind=='heroes'and HERO_ROW_AGE or .5))then
            for _,row in ipairs(result.rows)do if #rows<256 and preparedConfig:get(row.kind)then row.preparedAt=result.at;rows[#rows+1]=row end end
            for _,text in ipairs(result.recalls)do if #recalls<32 then recalls[#recalls+1]={record=text,preparedAt=result.at}end end
        elseif result then self.completed[entry.id]=nil end
    end
    self.rows=rows;self.recallRows=recalls;self.preparedAt=now
    if state.index>#state.entries then self.progress=nil;return true end
    return false
end
function D:DisplayText(row,now)
 local data=row.data or {}
 if row.kind=='awareness'then return(data.estimated and '~'or '')..math.max(0,math.floor(now-data.at))..'s'end
 if data.cooldowns then
  local text={};for _,value in ipairs(data.cooldowns)do local code=value.learned~=false and Cooldowns.text(value.label,value.readyAt,value.readyMin,value.estimate,now);if code then text[#text+1]=code end end
  return table.concat(text,' ')
 end
 return row.text
end
-- Frame scratch is reused: a frame clears its sets instead of allocating them.
local ANCHORS={'Screen','Minimap'}
local function byId(a,b)return a.id<b.id end
local function wipe(t)for k in pairs(t)do t[k]=nil end;return t end
function D:Draw(draw)
 self:CurrentContext()
 local c=self.c;local g=c.g;local d=draw or g.Draw
 if not c.config:get('draw')or not d then
  if c.overlayScope then for id,r in pairs(c.overlayScope.records)do if r.feature=='tracking'then c.overlayScope:Remove(id)end end end
  return
 end
 local now=c:now();local overlay=c.sdk and c.sdk.Overlay;local scope=c.overlayScope
 local published=wipe(self.publishedScratch or {});self.publishedScratch=published
 local publish=self.publishFn
 if not publish then publish=function(id,r)self.publishedScratch[id]=true;self.c.overlayScope:Set(id,r)end;self.publishFn=publish end
 local records=self.recordCache;if not records then records={};self.recordCache=records end
 local resolution=g.Game.Resolution();local scale=(overlay and overlay:Scale()or c.config:get('scale')/100*math.max(.8,math.min(2,resolution.y/1080)))
 local size=math.floor(14*scale)
 for index,row in ipairs(self.rows)do
  local data=row.data or {};local unit=data.unit
  local stable=stableKinds[row.kind]
   local age=row.kind=='cooldowns'and HERO_ROW_AGE or .5
   local fresh=c.config:get(row.kind)and(stable and self:StableCurrent(row,now)or not stable and now-(row.preparedAt or self.preparedAt or now)<=age)
   if stable then fresh=fresh and c.config:includes(row.kind,row.team,row.pos)end
  if unit then fresh=fresh and U.id(unit)==data.id and unit.handle==data.handle and(not data.name or unit.charName==data.name)and not unit.dead and(row.kind=='awareness'or unit.valid~=false)
   and(row.kind=='awareness'and not unit.visible or row.kind~='awareness'and unit.visible)end
   if data.anchor=='pathend'then fresh=fresh and unit.pathing and unit.pathing.hasMovePath and unit.pathing.endPos~=nil end
  -- With an overlay, strips are published every frame by PublishStrips.
  if scope and row.kind=='cooldowns'then fresh=false end
  if fresh then
   local identity=row.kind..':'..tostring(data.id or index)
   if scope then
    for _,where in ipairs(ANCHORS)do
     if c.config:visible(row.kind,where)and(not row.wardKind or where~='Minimap'or c.config:wardVisible(row.wardKind,'MinimapDisplay'))then
      -- One record table per identity and anchor, refreshed in place: the overlay's
      -- per-record text caches survive and no table or id string is built per frame.
      local slot=records[identity];if not slot then slot={};records[identity]=slot end
      local record=slot[where]
      if not record or record.rowKind~=row.kind then record={feature='tracking',rowKind=row.kind,recordId=identity..':'..where};slot[where]=record end
      if record.estimated~=data.estimated then record.seconds=nil end
      record.anchor=where=='Minimap'and 'minimap'or 'world';record.pos=row.pos;record.text=row.text
      record.priority=row.color=='turret'and 90 or 10;record.expires=((stable or row.kind=='cooldowns')and now or row.preparedAt or self.preparedAt or now)+.5
      if row.kind=='awareness'then record.kind='portrait';record.name=data.name;record.at=data.at;record.estimated=data.estimated;record.projection=where=='Minimap'and data or nil;record.minimapSeconds=c.config:get('minimapSeconds')~=false
      elseif row.kind=='wards'then record.kind='ward';record.radius=row.radius;record.timer=data.timer;record.expiresAt=(c.observations or self.sourceObservations).wardHistory[data.key or data.id].expires
      else record.kind='label';record.radius=row.radius;record.cooldowns=where=='Screen'and data.cooldowns or nil;record.unit=unit
       if unit then record.pos=unit.pos;if data.anchor=='pathend'then record.pos=unit.pathing and unit.pathing.endPos;record.unit=nil end end
      end
      publish(record.recordId,record)
     end
    end
   else
     local point=data.anchor=='pathend'and unit.pathing.endPos or unit and row.kind~='awareness'and unit.pos or row.pos
     local p=g.Vector(point);local s=p:To2D();local text=self:DisplayText(row,now)
    if s and s.onScreen~=false and c.config:visible(row.kind,'Screen')then
     local x,y=s.x,s.y-35*scale
     if row.radius then d.Circle(p,row.radius,1,d.Color(100,100,225,205))end
     if row.kind=='awareness'then d.Rect(x-14*scale,y-28*scale,28*scale,28*scale,d.Color(170,23,31,38));d.Text(data.name:gsub('^Jade_',''):sub(1,3),size,x-12*scale,y-23*scale,d.Color(220,200,210,220))end
     if text~=''then d.Text(text,size,x,y,d.Color(220,180,200,210))end
    end
    if p.ToMM and c.config:visible(row.kind,'Minimap')then local mm=p:ToMM()
     if mm then
      if row.kind=='awareness'then d.Rect(mm.x-8*scale,mm.y-8*scale,16*scale,16*scale,d.Color(110,23,31,38));d.Text(data.name:gsub('^Jade_',''):sub(1,3),math.floor(8*scale),mm.x-6*scale,mm.y-4*scale,d.Color(130,200,210,220));if c.config:get('minimapSeconds')~=false then d.Text((data.estimated and '~'or '')..math.max(0,math.floor(now-data.at)),math.floor(10*scale),mm.x+10*scale,mm.y-5*scale,d.Color(240,225,235,240))end
      elseif row.kind=='wards'then d.Rect(mm.x-3*scale,mm.y-3*scale,6*scale,6*scale,d.Color(180,100,225,205))
      elseif text~=''then d.Text(text,math.floor(10*scale),mm.x,mm.y,d.Color(200,180,200,210))end
     end
    end
   end
  end
 end
 local recalls=self.recallScratch;if not recalls then recalls={};self.recallScratch=recalls end
 for i=#recalls,1,-1 do recalls[i]=nil end
 for _,value in ipairs(self.recallRows or {})do local r=value.record or value
  if r and type(r)=='table'and r.id and self:RecallCurrent(r,now)then recalls[#recalls+1]=r end
 end
 table.sort(recalls,byId)
 self.recallSlots=self.recallSlots or {}
 local used=wipe(self.usedScratch or {});local present=wipe(self.presentScratch or {});self.usedScratch,self.presentScratch=used,present
 for _,r in ipairs(recalls)do present[r.id]=true end
 for id,slot in pairs(self.recallSlots)do if not present[id]then self.recallSlots[id]=nil else used[slot]=true end end
 for _,r in ipairs(recalls)do if not self.recallSlots[r.id]then
  for slot=1,32 do if not used[slot]then self.recallSlots[r.id]=slot;used[slot]=true;break end end
 end end
 if c.config:get('recalls')and c.config:visible('recalls','Screen')then
  for i,r in ipairs(recalls)do
   if scope then publish('recall:'..r.id,{feature='tracking',kind='recall',anchor='hud',name=r.name,row=self.recallSlots[r.id],started=r.started,ends=r.ends,status=r.status=='started'and now>(r.unknownAt or r.started+30)and 'unknown'or r.status,priority=70,channelKind=r.kind,expires=now+.1})
   else d.Text(r.name..' '..(r.status=='started'and(r.ends and string.format('%.1fs',math.max(0,r.ends-now))or 'Recalling')or r.status),size,18*scale,(180+(i-1)*38)*scale,d.Color(220,180,200,210))end
  end
 end
 if scope then self:PublishPanel(now,publish,published)end
 if scope then for id,r in pairs(scope.records)do if r.feature=='tracking'and not published[id]then scope:Remove(id)end end end
 for identity,slot in pairs(records)do
  for where,r in pairs(slot)do if not published[r.recordId]then slot[where]=nil end end
  if not next(slot)then records[identity]=nil end
 end
 self:ReportStrips(now)
end
-- Enemy cooldown panel (bottom left, beside the game HUD): one row per enemy,
-- refreshed every frame from live tracker state, including enemies in fog or
-- dead. Slot names and ranks come from the cast observer (readable in fog); a
-- positive host value wins. One persistent record; row and cell tables are
-- reused, so a frame allocates nothing once the roster is known.
local LABELS={[0]='Q','W','E','R','D','F'}
-- Frames between changes only extend the record. Cells are rebuilt when the
-- cast observer's revision moves (casts, slots, visibility) or the overlay
-- dropped the record. On each hero refresh (10 Hz) only the roster, death and
-- visibility of the listed rows are compared; record.version moves only when
-- something shown changed, so the overlay recomputes its draw list only then.
function D:PanelCurrent(panel,observations,casts,team)
 local rows=panel.rows;local index=0
 for i=1,math.min(32,#observations.heroes)do
  local unit=observations.heroes[i];local id=U.id(unit)
  if id and unit.team~=team and casts.states[id]then
   if index==0 and not self.c.config:includes('cooldowns',unit.team,nil)then return false end
   index=index+1;local row=rows[index]
   if not row or row.id~=id or row.handle~=unit.handle or row.visible~=(unit.visible==true)or row.dead~=(unit.dead==true)then return false end
  end
 end
 return index==#rows
end
function D:PublishPanel(now,publish,published)
 local c=self.c;local cfg=c.config
 if not cfg:get('cooldowns')or not cfg:visible('cooldowns','Screen')then return end
 local observations=c.observations;local casts=observations.casts
 local team=c.g.myHero and c.g.myHero.team;if team==nil or not casts then return end
 local panel=self.panel or {rows={},byId={},version=0};self.panel=panel
 local record=panel.record;local stamp=observations.nextAt.heroes
 if record and panel.revision==casts.revision and panel.castError==observations.castError
  and c.overlayScope.records['cooldowns:panel']==record and #panel.rows>0
  and(panel.stamp==stamp or self:PanelCurrent(panel,observations,casts,team))then
  panel.stamp=stamp;record.expires=now+.5;published['cooldowns:panel']=true;return
 end
 panel.revision=casts.revision;panel.stamp=stamp;panel.castError=observations.castError;panel.version=panel.version+1
 local rows=panel.rows;local count=0
 local overlay=c.sdk and c.sdk.Overlay
 for i=1,math.min(32,#observations.heroes)do
  local unit=observations.heroes[i];local id=U.id(unit)
  local state=id and unit.team~=team and casts.states[id]
  if state and state.name==unit.charName and count<6 and cfg:includes('cooldowns',unit.team,nil)then
   local row=panel.byId[id]
   if not row or row.handle~=unit.handle or row.name~=unit.charName then
    row={id=id,handle=unit.handle,name=unit.charName,cells={}};panel.byId[id]=row
    if overlay and overlay.PreparePortrait then overlay:PreparePortrait(unit.charName)end
   end
   row.visible=unit.visible==true;row.dead=unit.dead==true
   local observed=not observations.castError and casts.rows[id]
   local cells=row.cells;local n=0
   for slot=0,5 do
    local sl=state.slots[slot]
    if sl and type(sl.name)=='string'then
     local d=observed and observed[slot]
     n=n+1;local cell=cells[n];if not cell then cell={};cells[n]=cell end
     cell.slot=slot;cell.label=LABELS[slot]
     -- Summoner ranks are not meaningful; a known spell there is always usable.
     cell.learned=slot>=4 or(sl.level or 0)>0
     if sl.hostReady and sl.hostReady>now then
      -- A positive host value wins (exact, no estimate; its length is unknown).
      cell.readyAt=sl.hostReady;cell.readyMin=sl.hostReady;cell.estimate=false;cell.total=nil
     else
      cell.readyAt=d and d.readyAt or 0;cell.readyMin=d and d.readyMin;cell.estimate=d and d.estimate
      cell.total=d and(d.total or(U.finite(d.castAt)and d.readyAt-d.castAt or nil))
     end
     if cell.name~=sl.name then
      cell.name=sl.name;cell.icon=slot>=4 and Cooldowns.icon(sl.name)or nil
      if cell.icon and overlay and overlay.PreparePortrait then overlay:PreparePortrait(cell.icon,'summoner')end
     end
    end
   end
   for k=#cells,n+1,-1 do cells[k]=nil end
   if n>0 then count=count+1;rows[count]=row end
  end
 end
 for k=#rows,count+1,-1 do rows[k]=nil end
 if count==0 then return end
 record=record or {feature='tracking',kind='cooldowns',anchor='hud',priority=60,rows=rows};panel.record=record
 record.version=panel.version;record.expires=now+.5;self.stripsPublished=(self.stripsPublished or 0)+count
 publish('cooldowns:panel',record)
end
-- Development telemetry: cooldown rows prepared and strip records published, every 10 s.
function D:ReportStrips(now)
 if now<(self.stripReportAt or 0)then return end
 local first=self.stripReportAt==nil;self.stripReportAt=now+10
 local published=self.stripsPublished or 0;self.stripsPublished=0
 if first then return end
 local family=rawget(_G,'OrbamaFamily');local recorder=family and family.diagnostics
 if not recorder or type(recorder.Event)~='function'then return end
 local prepared,enemies=0,0;local c=self.c;local team=c.g.myHero and c.g.myHero.team
 for _,row in ipairs(self.rows or {})do if row.kind=='cooldowns'then prepared=prepared+1 end end
 local live=0;for _ in pairs(c.observations.cooldowns or {})do live=live+1 end
 for _,h in ipairs(c.observations.heroes or {})do if h.team~=team and h.visible and not h.dead then enemies=enemies+1 end end
 pcall(recorder.Event,recorder,'utils.cooldown_rows',{prepared=prepared,published=published,liveRows=live,visibleEnemies=enemies,
  enabled=c.config:get('cooldowns')==true,screen=c.config:visible('cooldowns','Screen')==true,castError=c.observations.castError})
end
return D

end
