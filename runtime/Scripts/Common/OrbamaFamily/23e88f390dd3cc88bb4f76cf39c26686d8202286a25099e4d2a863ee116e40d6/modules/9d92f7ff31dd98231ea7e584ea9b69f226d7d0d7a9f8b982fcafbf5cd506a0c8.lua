return function(require)
-- Bounded positive end witnesses for reviewed cast envelopes. Fog, absent
-- fields and failed reads never mean an effect ended. No polling without a
-- published live zone. The original cast history prevents echo resurrection.
local G=require('evade.geometry')
local L={max=16}
local function epoch(spell)
    local at=spell and spell.startTime
    if not G.finite(at)or at<=0 then at=spell and spell.castStartTime end
    return G.finite(at)and at>0 and at or nil
end
local function identity(w)
    local owner=w.owner
    return owner.networkID==w.networkID and owner.handle==w.handle and owner.charName==w.champion
end
local function sample(w)
    if not identity(w)then return false end
    local owner=w.owner
    if owner.valid==false or owner.visible==false then return end
    if w.mode=='channel'then
        if owner.dead==true then return true end
        local spell=owner.activeSpell
        if not spell or type(spell.name)~='string'then return end
        local at=epoch(spell)
        local name=spell.name:lower()
        if at and math.abs(at-w.epoch)<.001 and name==w.primary then
            if spell.valid==true and spell.isStopped==false then w.running=true
            elseif spell.isStopped==true and w.running and not w.release then return true end
        end
        -- A release stage has its own execution clock. In particular Sion Q's
        -- stop flag cannot distinguish an interrupted charge from its slam.
        local finish=spell.castEndTime
        if w.release and name==w.release and spell.valid==true and at and at>=w.epoch and at<=w.now+.1
            and G.finite(finish)and finish>=at and finish<=w.now+2 then return true,math.max(w.now,finish)end
        -- Missing activeSpell, isChanneling=false and another cast are not end
        -- witnesses. Windup flags and non-interrupting summoners are ambiguous.
        return
    end
    if owner.dead==true or type(owner.GetSpellData)~='function'then return end
    local data=owner:GetSpellData(w.slot)
    local name=data and type(data.name)=='string'and data.name:lower()
    if w.mode=='toggle'then
        if name~=w.primary then return end
        local state=data.toggleState
        if state==w.active then w.armedAt=w.armedAt or w.now
        elseif state==w.inactive and w.armedAt then return true end
    elseif name==w.armed then w.armedAt=w.armedAt or w.now
    elseif name==w.primary and w.armedAt then return true end
end
local function shorten(observer,id,now,margin,mode,contactAt)
    local row=observer.threats.byID[id]
    if not row then return end
    local ends=(mode=='channel'and(contactAt or now)or math.max(now,row.starts))+margin
    if ends>=row.ends then return end
    local event=observer.threats:Snapshot(id)
    if mode=='channel'then event.starts=math.min(event.starts,now);event.arrivalLatest=math.min(event.arrivalLatest or now,now);event.impactLatest=ends end
    event.ends=ends;event.detonationObservedAt=now
    event.timingScope=mode=='recast'and 'observed_recast_detonation'or 'observed_'..mode..'_end'
    observer.threats:Observe(event)
end
local function probe(observer,id,w,now)
    w.now=now;observer.hostCalls=(observer.hostCalls or 0)+1
    local ok,ended,contactAt=pcall(sample,w)
    if ok and ended==true then
        shorten(observer,id,now,w.margin,w.mode,contactAt)
        for index=1,w.extras do shorten(observer,id..':x'..index,now,w.margin,w.mode,contactAt)end
        return true
    end
    -- Recycled owner identity: stop reading it, retaining the bounded hazard.
    return ok and ended==false
end
function L.Watch(observer,id,owner,d,spell,extras,now)
    local mode=d.mode or 'recast'
    if mode~='recast'and mode~='toggle'and mode~='channel'then return end
    if type(d.primary)~='string'or not G.finite(d.margin)or d.margin<0 or d.margin>.5 then return end
    if mode=='recast'and type(d.armed)~='string'then return end
    if mode~='channel'and(not G.finite(d.slot)or d.slot<0 or d.slot>3 or d.slot~=math.floor(d.slot))then return end
    if mode=='toggle'and(d.active~=2 or d.inactive~=1)then return end
    local at=epoch(spell)
    if mode=='channel'and(not at or spell.isChanneling~=true or spell.name:lower()~=d.primary:lower())then return end
    observer.detonations=observer.detonations or {}
    if observer.detonations[id]then return end
    local w={owner=owner,networkID=owner.networkID,handle=owner.handle,champion=owner.charName,
        mode=mode,slot=d.slot,primary=d.primary:lower(),armed=d.armed and d.armed:lower(),
        active=d.active,inactive=d.inactive,epoch=at,release=type(d.release)=='string'and d.release:lower()or nil,
        margin=d.margin,extras=type(extras)=='table'and math.min(#extras,8)or 0}
    if w.networkID==nil and w.handle==nil then return end
    if d.single==true and at then
        for priorID,prior in pairs(observer.detonations)do
            if prior.mode==mode and prior.slot==w.slot and prior.primary==w.primary and prior.networkID==w.networkID
                and prior.handle==w.handle and prior.champion==w.champion and prior.epoch and at>prior.epoch+.05 then
                shorten(observer,priorID,now,prior.margin,'replacement_cast')
                observer.detonations[priorID]=nil;observer.detonationCount=observer.detonationCount-1
            end
        end
    end
    if(observer.detonationCount or 0)>=L.max then return end
    observer.detonations[id]=w;observer.detonationCount=(observer.detonationCount or 0)+1
    if probe(observer,id,w,now)then observer.detonations[id]=nil;observer.detonationCount=observer.detonationCount-1 end
end
function L.Scan(observer,now)
    for id,w in pairs(observer.detonations)do
        local row=observer.threats.byID[id]
        local done=not row or row.ends<now
        if not done and w.now and now<w.now then w.armedAt=nil end
        if not done then done=probe(observer,id,w,now)end
        if done then observer.detonations[id]=nil;observer.detonationCount=observer.detonationCount-1 end
    end
end
return L

end
