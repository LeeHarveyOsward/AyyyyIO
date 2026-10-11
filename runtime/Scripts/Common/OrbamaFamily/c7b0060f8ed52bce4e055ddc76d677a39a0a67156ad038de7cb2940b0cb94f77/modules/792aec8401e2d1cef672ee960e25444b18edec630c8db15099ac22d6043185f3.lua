return function(require)
local U=require('utils.util')
local World=require('CombatProfiles.world')
local Locations=require('utils.locations')
local Casts=require('utils.casts')
local RECALL_BUFFS={recall=true,recallimproved=true}
local function recallKind(name)return not name or name==''or RECALL_BUFFS[U.name(name)]==true end
local O={};O.__index=O
-- Shared read-only slot lists. Per-hero rows are refreshed in place.
local SPELL_SLOTS={0,1,2,3,4,5};local SPELL_SLOTS_TRINKET={0,1,2,3,4,5,12}
local function wardKind(ward)
    local name=(ward.charName or ''):lower()
    if name=='jammerdevice'or name=='visionward'then return 'VisionWard'end
    if name=='bluetrinket'or name=='farsightward'then return 'Farsight'end
    if name:find('trinket',1,true)then return 'Trinket'end
    if name=='sightward'then return ward.maxMana==150 and 'SightWard'or 'Trinket'end
    return 'Unknown'
end
function O.new(c)
    return setmetatable({c=c,map=c.g.Game.mapID,locations=Locations.new(c),casts=Casts.new(c),life={},pendingBase={},revision=0,heroes={},wards={},wardHistory={},turrets={},minions={},recalls={},lastSeen={},cooldowns={},hostCooldowns={},camps={},nextAt={}},O)
end
function O:CurrentMap()
    local map=self.c.g.Game.mapID
    if self.map==map then return end
    self.map=map;self.life={};self.pendingBase={};self.recalls={};self.lastSeen={};self.cooldowns={};self.hostCooldowns={};self.casts:Reset()
    self.heroes={};self.wards={};self.wardHistory={};self.turrets={};self.minions={};self.camps={};self.nextAt={}
    self.revision=self.revision+1
end
local SHARED_KINDS={Hero='heroes',Minion='minions',Ward='wards',Turret='turrets',Camp='camps'}
function O:collect(kind,limit)
    local shared=self.c.sdk and self.c.sdk.SharedData
    if shared and shared.GetObjects then
        local name=SHARED_KINDS[kind]
        local snapshot=shared:GetObjects(name)
        if snapshot and snapshot.objects and snapshot.ageMs<=80 then
            return snapshot.objects
        end
    end
    local game=self.c.g.Game;local count,read=game[kind..'Count'],game[kind]
    local list={};if not count or not read then return list end
    for i=1,U.count(count(),limit)do local o=read(i);if o and U.id(o)then list[#list+1]=o end end
    return list
end
function O:AtBase(unit,source,at,estimated)
    local id=U.id(unit);if not id or not unit.charName or unit.dead then return end
    local previous=self.lastSeen[id]
    if previous and previous.at>at then return end
    local base=self.locations:Base(unit.team)
    if not base then
        self.pendingBase[id]={unit=unit,name=unit.charName,handle=unit.handle,source=source,at=at,estimated=estimated,expires=at+10};return
    end
    self.pendingBase[id]=nil
    self.lastSeen[id]={id=id,name=unit.charName,handle=unit.handle,team=unit.team,unit=unit,pos=U.copy(base),at=at,source=source,estimated=estimated==true,map=self.map,profile=self.c.profile.id}
end
function O:EndRecall(row,status,now)
    row.status=status;row.removeAt=status=='cancelled'and now or now+2
    if status=='finished'and recallKind(row.kind)and row.unit then self:AtBase(row.unit,'recall',now,false);self.casts:Recalled(row.id,now)end
end
function O:RecallPosition(unit,now)
    local p=unit.pos
    if unit.visible and unit.valid~=false and not unit.dead and p and U.finite(p.x)and U.finite(p.z)then
        return U.copy(p),true,0
    end
    local old=self.lastSeen[U.id(unit)]
    if old and old.map==self.c.g.Game.mapID and old.profile==self.c.profile.id and old.source=='observed'and old.handle==unit.handle and old.name==unit.charName and old.team==unit.team
        and now>=old.at and now-old.at<=.2 and U.finite(old.ms)then
        return U.copy(old.pos),true,math.max(600,old.ms*1.5)*(now-old.at)
    end
    return U.copy(p),false,nil
end
function O:Recall(unit,event)
    self:CurrentMap()
    local id=U.id(unit);local kind=type(event)
    if not id or(kind~='table'and kind~='userdata')then return end
    local ok,start,finish,duration,name=pcall(function()return event.isStart,event.isFinish,event.totalTime,event.name end)
    if not ok then return end
    local now=self.c:now();local row=self.recalls[id]
    if start==true then
        if unit.dead or not unit.charName then return end
        if row and row.status=='started'and row.handle==unit.handle and row.name==unit.charName and now-row.started<.25 then return end
        local ends=U.finite(duration)and duration>0 and duration<=30000 and now+duration/1000 or nil
        local pos,known,uncertainty=self:RecallPosition(unit,now)
        if type(name)=='string'and name:lower():find('teleport',1,true)then self.casts:Teleported(unit,now)end
        self.recalls[id]={id=id,name=unit.charName,team=unit.team,pos=pos,positionKnown=known,positionUncertainty=uncertainty,started=now,ends=ends,
             unknownAt=ends and ends+1 or now+30,status='started',kind=type(name)=='string'and name or 'Recall',handle=unit.handle,unit=unit,map=self.map,profile=self.c.profile.id}
    elseif row and(not row.unit or U.id(row.unit)==id and row.unit.handle==row.handle and row.unit.charName==row.name)and(not unit.handle or unit.handle==row.handle)and(not unit.charName or unit.charName==row.name)and type(finish)=='boolean'then
        self:EndRecall(row,finish and 'finished'or 'cancelled',now)
    end
end
function O:ObserveRecall(unit,now)
    local id=U.id(unit);local row=self.recalls[id]
    if unit.dead then if row and row.status=='started'then self:EndRecall(row,'cancelled',now)end;return end
    if not unit.visible or unit.valid==false or not unit.GetBuff then return end
    if unit.isChanneling==false and(not row or row.status~='started')then
        local a=unit.activeSpell;if not a or a.valid==false or not RECALL_BUFFS[U.name(a.name)]then return end
    end
    local ok,buff=pcall(U.buff,unit,RECALL_BUFFS,now);if not ok then return end
    if buff then
        local ends=U.buffEnd(buff);local started=U.finite(buff.startTime)and buff.startTime>=0 and buff.startTime<=now and buff.startTime or now
        if not row or row.status~='started'or row.handle~=unit.handle or row.name~=unit.charName then
            local pos,known,uncertainty=self:RecallPosition(unit,now)
            row={id=id,name=unit.charName,team=unit.team,handle=unit.handle,unit=unit,pos=U.copy(unit.pos),started=started,
                ends=ends,status='started',kind=buff.name,unknownAt=ends and ends+1 or now+30,
                 positionKnown=known,positionUncertainty=uncertainty,map=self.map,profile=self.c.profile.id};row.pos=pos;self.recalls[id]=row
        elseif ends then row.ends=ends;row.unknownAt=ends+1 end
        row.sawBuff=true
    elseif row and row.sawBuff and row.status=='started'then
        local base=self.locations:Base(unit.team)
        if row.ends and now>=row.ends-.25 and base and U.dist(unit.pos,base)<=800 then self:EndRecall(row,'finished',now)
        elseif row.ends and now<row.ends-.25 then self:EndRecall(row,'cancelled',now)
        else self:EndRecall(row,'unknown',now)end
    end
end
function O:PrepareLocations()
    local c=self.c
    local demanded=c.Knowledge and c.Knowledge:Demand('bases')
    if not demanded and(not c.config:get('draw')or not c.config:get('awareness'))or not self.locations:NeedsPrepare()then
        if c.preparation then c.preparation:CancelJob('base-locations')end;return
    end
    if not self.prepareLocations then self.prepareLocations=function(token)return self.locations:Prepare(token)end end
    if c.preparation then
        c.preparation:Run('base-locations',{intervalMs=100,maxDelayMs=1000,units=1,maxUnits=64},self.prepareLocations)
        if not self.locations:NeedsPrepare()then c.preparation:CancelJob('base-locations')end
    elseif self.c:now()>=(self.locationsAt or 0)then self.locationsAt=self.c:now()+.1;self.locations:Prepare()end
end
function O:Tick()
    self:CurrentMap()
    local c=self.c;local now=c:now();local cfg=c.config
    self.revision=self.revision+1;self.at=now
    local myTeam=c.g.myHero and c.g.myHero.team
    for id,p in pairs(self.pendingBase)do
        local u=p.unit;local old=self.lastSeen[id]
        if now>p.expires or not u or U.id(u)~=id or u.handle~=p.handle or u.charName~=p.name or u.dead or u.visible or old and old.at>p.at then self.pendingBase[id]=nil
        elseif self.locations:Base(u.team)then self:AtBase(u,p.source,p.at,p.estimated)end
    end
    if now>=(self.nextAt.heroes or 0)then
        self.nextAt.heroes=now+.1;self.heroes=self:collect('Hero',32)
        local knowledge=c.Knowledge
        local recallDemand=knowledge and knowledge:Demand('recalls')
        local lastSeenDemand=knowledge and knowledge:Demand('lastSeen')
        for _,h in ipairs(self.heroes)do
            local id=U.id(h)
            local old=self.lastSeen[id]
            local state=self.life[id]
            if old and(old.name~=h.charName or old.handle~=h.handle)or state and(state.name~=h.charName or state.handle~=h.handle)then
                self.lastSeen[id]=nil;self.cooldowns[id]=nil;self.hostCooldowns[id]=nil;self.recalls[id]=nil;self.pendingBase[id]=nil;state=nil
            end
            if state and state.dead==true and h.dead==false and U.finite(h.health)and h.health>0 and not h.visible then self:AtBase(h,'respawn',now,true)end
            state=state or {name=h.charName,handle=h.handle};state.dead=h.dead;self.life[id]=state
            if recallDemand or cfg:get('draw')and(cfg:get('recalls')or cfg:get('awareness'))then self:ObserveRecall(h,now)end
            if h.visible and h.valid~=false and not h.dead then
                self.lastSeen[id]={id=id,name=h.charName,pos=U.copy(h.pos),at=now,team=h.team,handle=h.handle,unit=h,dead=false,source='observed',map=self.map,profile=c.profile.id}
                if lastSeenDemand then knowledge:Sample(h,self.lastSeen[id],old)end
                -- With the overlay, cooldowns are drawn only by the enemy panel, whose
                -- slots the cast observer reads (names, ranks, any positive host value).
                -- Host rows here would be read and never drawn.
                if c.overlayScope and not self.castError then self.cooldowns[id]=nil;self.hostCooldowns[id]=nil
                elseif cfg:get('cooldowns')and h.GetSpellData then
                    -- Reuse this hero's table and slot rows; only internal
                    -- drawing preparation reads them. Absent slots are removed.
                    local slots=self.hostCooldowns[id]or {};local indices=cfg:get('trinket')and SPELL_SLOTS_TRINKET or SPELL_SLOTS
                    for _,slot in ipairs(indices)do
                        local d=h:GetSpellData(slot)
                        if d and type(d.name)=='string'and d.name~=''and U.finite(d.currentCd)and d.currentCd>=0 then
                            local row=slots[slot]
                            -- total: the cooldown length when it started, for the progress fill.
                            if row then
                                if d.currentCd>row.readyAt-now+.5 then row.total=d.currentCd elseif d.currentCd<=0 then row.total=nil end
                                row.name=d.name;row.rank=d.level;row.readyAt=now+d.currentCd;row.ammo=d.ammo;row.at=now
                            else slots[slot]={name=d.name,rank=d.level,readyAt=now+d.currentCd,ammo=d.ammo,at=now,total=d.currentCd>0 and d.currentCd or nil}end
                        else slots[slot]=nil end
                    end
                    if indices==SPELL_SLOTS then slots[12]=nil end
                    self.hostCooldowns[id]=slots
                    -- The host reports currentCd=0 for enemies: observed casts fill
                    -- every slot the host leaves at zero; a positive host value wins.
                    local observed=myTeam~=nil and h.team~=myTeam and not self.castError and self.casts:Rows(id)
                    if observed and next(observed)then
                        local merged={};for slot,row in pairs(slots)do merged[slot]=row end
                        for slot,row in pairs(observed)do local host=slots[slot];if not host or host.readyAt<=now then merged[slot]=row end end
                        self.cooldowns[id]=merged
                    else self.cooldowns[id]=slots end
                end
            elseif h.dead then self.lastSeen[id]=nil;self.cooldowns[id]=nil;self.pendingBase[id]=nil end
        end
    end
    -- Every tick: casts are short; an error disables only this tracker.
    if cfg:get('cooldowns')and myTeam~=nil and not self.castError then
        local ok,why=pcall(self.casts.Tick,self.casts,self.heroes,myTeam,now)
        if not ok then self.castError=tostring(why);self.cooldowns={};print('[OrbamaUtils] Enemy cooldown tracking stopped: '..self.castError)end
    end
    -- Consumers are asked once per Tick; every phase below shares the answer.
    local demand
    local function campDemand()if demand==nil then demand=c.Camps and c.Camps:Demand()or false end;return demand end
    if now>=(self.nextAt.objects or 0)then
        self.nextAt.objects=now+.08
        if cfg:get('autosmite')or campDemand()then self.minions=self:collect('Minion',4096);self.minionsAt=now else self.minions={};self.minionsAt=nil end
        if cfg:get('wards')then
            self.wards=self:collect('Ward',512)
            for _,ward in ipairs(self.wards)do
                local id=U.id(ward)
                if ward.dead or ward.valid==false then self.wardHistory[id]=nil
                elseif ward.visible~=false then
                    local duration=ward.duration;local expires=U.finite(duration)and duration>0 and now+duration or nil
                    if not expires and ward.GetBuff then for index=0,U.count(ward.buffCount or 0,64)do
                        local buff=ward:GetBuff(index);local finish=buff and U.buffEnd(buff)
                        if buff and(buff.count or 0)>0 and finish and finish>now and finish-now<=180 then expires=finish;break end
                    end end
                    -- A ward does not move or change owner: a known identity refreshes
                    -- only its time fields instead of re-reading name, position, owner.
                    local row=self.wardHistory[id];local name=ward.charName
                    if row and row.name==name then row.at=now;row.expires=expires;row.visible=true
                    else
                        self.wardHistory[id]={id=id,name=name,kind=wardKind(ward),pos=U.copy(ward.pos),team=ward.team,
                            ownerID=ward.ownerID,owner=ward.owner and ward.owner.charName,at=now,expires=expires,
                            sightRange=ward.sightRange,visible=true}
                    end
                end
            end
            for id,row in pairs(self.wardHistory)do if row.expires and now>=row.expires or now-row.at>180 then self.wardHistory[id]=nil end end
        end
        if cfg:get('turrets')or cfg:get('items')or campDemand()then self.turrets=self:collect('Turret',128)end
    end
    if c.Camps and(cfg:get('autosmite')or campDemand())then c.Camps:Refresh()end
    for id,r in pairs(self.recalls)do
        if r.removeAt and now>=r.removeAt then self.recalls[id]=nil
        elseif r.status=='started'and now>(r.unknownAt or r.ends and r.ends+1 or r.started+30)then self:EndRecall(r,'unknown',now)end
    end
    local retention=cfg:get('lastSeenRetention')or 0
    if retention>0 then for id,r in pairs(self.lastSeen)do if now-r.at>retention then self.lastSeen[id]=nil;self.cooldowns[id]=nil;self.hostCooldowns[id]=nil end end end
end
function O:UpdateCamps(now)if self.c.Camps then return self.c.Camps:Refresh(true)end end
function O:Snapshot()
    local snapshot={revision=self.revision,at=self.at,profile=self.c.profile.id,identityOnly=true}
    for _,kind in ipairs({'heroes','minions','wards','turrets'})do
        local list={};for i,o in ipairs(self[kind])do list[i]=o end;snapshot[kind]=list
    end
    return snapshot
end
return O

end
