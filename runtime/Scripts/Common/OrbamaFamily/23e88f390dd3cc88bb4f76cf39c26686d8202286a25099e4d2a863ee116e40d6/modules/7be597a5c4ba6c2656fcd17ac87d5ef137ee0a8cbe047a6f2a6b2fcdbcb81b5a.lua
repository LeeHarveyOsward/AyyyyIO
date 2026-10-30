return function(require)
local Link=require('evade.channel_link')
local PostDeath=require('evade.postdeath')
-- Fixed-origin, fixed-direction, constant-speed emission envelopes, timed
-- targeted effects and stationary self-centred areas of rooted casters only.
-- A profile must explicitly opt in. Host isChanneling alone is insufficient.
local G=require('evade.geometry')
local C={};C.__index=C
function C.clock(spell,profile,now)
    if not profile or (profile.kind~='fixed_cone_emission'and profile.kind~='timed_targeted_effect'
            and profile.kind~='self_centered_area')
        or not G.finite(profile.duration)or profile.duration<=0 or profile.duration>20
        or profile.kind=='fixed_cone_emission'and(not G.finite(profile.speed)or profile.speed<=0)then return nil,'unsupported_channel_model'end
    if not spell or spell.valid~=true or spell.isChanneling~=true
        or spell.isStopped==true then return nil,'channel_not_observed'end
    local launch,finish=spell.castEndTime,spell.endTime
    if not G.finite(launch)or launch<=0 or not G.finite(finish)
        or math.abs(finish-launch-profile.duration)>.05 then return nil,'channel_clock_disagreement'end
    if not G.finite(now)or finish<now then return nil,'channel_clock_outside_observation'end
    local start=spell.startTime;local startSource='startTime'
    if start==nil or start==0 then start=spell.castStartTime;startSource='castStartTime' end
    local evidence='native_cast_start'
    if start==nil or start==0 then
        -- A corroborated native launch/end pair supplies the emission epoch.
        -- This is not a fabricated windup or a start=now fallback.
        if launch>now+.1 then return nil,'channel_clock_outside_observation'end
        start=launch;evidence='native_launch_and_profile_duration';startSource='corroborated_launch_end_pair'
    elseif not G.finite(start)or start<=0 or start>launch or launch-start>2 or start>now+.1 then
        return nil,'invalid_channel_start'
    end
    return {start=start,launch=launch,finish=finish,evidence=evidence,startSource=startSource}
end
function C.new(threats)return setmetatable({threats=threats,active={},max=64,count=0},C)end
function C:Stop(row,now,reason)
    if row.closed or now>=row.emissionEnd then return false end
    row.closed=true
    local t=self.threats:Snapshot(row.id)
    if not t then return false end
    if row.kind=='timed_targeted_effect'then
        -- An interruption after the earliest possible impact cannot erase it.
        if now<t.starts then self.threats:Remove(row.id);return true end
        return false
    end
    if row.kind=='self_centered_area'then
        -- No further emissions start; already-released daggers home on their
        -- own targets, so walking out of the area no longer changes them.
        self.threats:Remove(row.id);return true
    end
    if now<t.emissionStart then self.threats:Remove(row.id);return true end
    t.emissionEnd=math.min(t.emissionEnd,now)
    t.ends=t.emissionEnd+t.length/t.emissionSpeed
    t.continuationConditional=false;t.channelStopReason=reason
    self.threats:Observe(t);return true
end
function C:Reconcile(owner,spell,now)
    if next(self.active)==nil then return end -- No retained channel: no owner identity read.
    local ownerID=owner.networkID or owner.handle
    for _,row in pairs(self.active)do
        if row.owner==ownerID then
            if owner.dead and row.kind~='timed_targeted_effect'then self:Stop(row,now,'caster_death')
            elseif row.kind=='self_centered_area'and not row.closed and G.point(owner.pos)
                and G.dist(owner.pos,row.center)>row.moveTolerance then
                -- The caster is rooted while channeling: displacement ends it.
                self:Stop(row,now,'caster_moved')
            elseif spell and spell.name==row.nativeName
                and G.finite(spell.endTime)and math.abs(spell.endTime-row.nativeEnd)<.001
                and spell.isStopped==true then self:Stop(row,now,'observed_channel_stop')end
            -- An absent/invalid activeSpell is not proof of interruption. Keep
            -- its bounded forecast; a missing observation cannot erase bullets.
        end
    end
end
function C:Observe(owner,spell,definition,now,target,damageReader,damageContext)
    local c=definition.cast;local profile=c and c.channel
    local clock,reason=C.clock(spell,profile,now);if not clock then return nil,reason end
    if c.shape=='targeted'then return self:ObserveTargeted(owner,spell,definition,now,target,clock,damageReader,damageContext)end
    if profile.kind=='self_centered_area'then return self:ObserveArea(owner,spell,definition,now,clock)end
    if c.shape~='cone'or not G.finite(c.range)or c.range<=0
        or not G.finite(c.halfAngle)or c.halfAngle<=0 or c.halfAngle>=math.pi/2
        or not G.finite(c.radius)or c.radius<0 then return nil,'unsupported_channel_geometry'end
    local ownerID=owner.networkID or owner.handle
    if not ownerID then return nil,'channel_owner_missing'end
    local key=tostring(ownerID)..':'..c.alias..':'..tostring(clock.finish)
    local existing=self.active[key]
    if existing then return false,'channel_already_observed'end
    local aliases
    if profile.nativeAliases~=nil then
        if type(profile.nativeAliases)~='table'or #profile.nativeAliases<1 or #profile.nativeAliases>16
        or not G.finite(profile.nativeOriginRadius)or profile.nativeOriginRadius<0 or profile.nativeOriginRadius>500
        or not G.finite(profile.nativeRayTolerance)or profile.nativeRayTolerance<0 or profile.nativeRayTolerance>50
        or not G.finite(profile.nativeTimeTolerance)or profile.nativeTimeTolerance<0 or profile.nativeTimeTolerance>.25 then
            return nil,'invalid_channel_native_profile'
        end
        aliases={}
        for _,alias in ipairs(profile.nativeAliases)do
            if type(alias)~='string'or #alias==0 or #alias>128 then return nil,'invalid_channel_native_alias'end
            aliases[alias:lower()]=true
        end
    end
    if self.count>=self.max then
        self.threats.overflow=true
        self.threats.overflowUntil=math.max(self.threats.overflowUntil or 0,clock.finish+c.range/profile.speed)
        return nil,'channel_capacity'
    end
    local origin=spell.startPos or owner.pos;local destination=spell.placementPos or spell.endPos
    if not G.point(origin)or not G.point(destination)or G.dist(origin,destination)<1 then
        return nil,'channel_direction_missing'
    end
    origin=G.copy(origin);destination=G.lerp(origin,destination,c.range/G.dist(origin,destination))
    local id='channel:'..key
    local t={id=id,instanceID=id,stageID=id,damageID=id,casterID=ownerID,profile=definition.profile,
        ability=definition.id,abilityName=definition.name,champion=owner.charName,source=definition.source,
        evidence='cast-derived',shape='cone',origin=origin,b=destination,radius=c.radius,length=c.range,
        halfAngle=c.halfAngle,starts=clock.launch,ends=clock.finish+c.range/profile.speed,
        emissionStart=clock.launch,emissionEnd=clock.finish,emissionSpeed=profile.speed,
        potentialDamage=true,persistent=true,continuationConditional=true,timingScope='continuous_emission_envelope',
        observedAt=now,castOrigin=G.copy(origin),castStart=clock.start,castLaunch=clock.launch,
        clockEvidence=clock.evidence,castStartSource=clock.startSource,castFinishSource='castEndTime',cc=definition.cc,ccUnknown=definition.ccUnknown,ccHard=definition.ccHard}
    -- The envelope has no verified individual bullet phase or damage identity.
    -- Do not assign whole-channel damage to one contact or invent periodic gaps.
    local accepted,why=self.threats:Observe(t);if not accepted then return nil,why end
    self.active[key]={id=id,owner=ownerID,nativeName=spell.name,nativeEnd=clock.finish,
        emissionEnd=clock.finish,expires=t.ends,closed=false,ownerHandle=owner.handle,
        nativeAliases=aliases,nativeOriginRadius=profile.nativeOriginRadius,
        nativeRayTolerance=profile.nativeRayTolerance,nativeTimeTolerance=profile.nativeTimeTolerance}
    self.count=self.count+1
    if aliases then
        -- Late cast discovery links existing native stages without removing
        -- their geometry or conflating damage events. H.list is capped at 512.
        for _,native in ipairs(self.threats.list)do
            if native.shape=='missile'and native.nativeAlias then
                local parent=Link.Match(self.active,self.threats.byID,native)
                if parent~=native.channelInstanceID then
                    local copy=self.threats:Snapshot(native.id)
                    if Link.SetParent(copy,parent)then self.threats:Observe(copy)end
                end
            end
        end
    end
    return t
end
function C:ObserveTargeted(owner,spell,definition,now,target,clock,damageReader,damageContext)
    local cast=definition.cast;local profile=cast.channel
    if profile.kind~='timed_targeted_effect' or profile.scope~='global_enemy_champions'
        or clock.evidence~='native_cast_start' then return nil,'targeted_channel_scope_unknown'end
    local targetID=target and target.networkID
    if not target or target.dead or target.team==owner.team
        or not G.finite(targetID)or targetID<=0 or targetID~=math.floor(targetID)then
        return nil,'targeted_channel_recipient_unknown'
    end
    local ownerID=owner.networkID or owner.handle
    if not ownerID then return nil,'channel_owner_missing'end
    local key=tostring(ownerID)..':'..cast.alias..':'..tostring(clock.finish)
    if self.active[key]then return false,'channel_already_observed'end
    if self.count>=self.max then
        self.threats.overflow=true
        self.threats.overflowUntil=math.max(self.threats.overflowUntil or 0,clock.finish)
        return nil,'channel_capacity'
    end
    local authorized,admissionReason,buffReads=PostDeath.Authorize(owner,spell,definition,now,clock.finish)
    if not authorized then return nil,admissionReason,buffReads end
    local id='channel:'..key
    -- Native cast completion starts the channel. The effect's exact relation to
    -- startup versus completion is not yet accepted, so retain both endpoints.
    local first=math.max(clock.launch,clock.start+profile.duration)
    local t={id=id,instanceID=id,stageID=id,damageID=id,casterID=ownerID,
        targetID=targetID,profile=definition.profile,ability=definition.id,
        abilityName=definition.name,champion=owner.charName,source=definition.source,
        evidence='cast-derived',shape='targeted',starts=first,ends=clock.finish,
        impactLatest=clock.finish,observedAt=now,castStart=clock.start,
        castLaunch=clock.launch,clockEvidence=clock.evidence,castStartSource=clock.startSource,castFinishSource='castEndTime',
        timingScope='conditional channel completion; startup/completion interval',
        postDeathObserved=owner.dead==true,continuationConditional=true,damage=damageReader and damageReader(damageContext,owner,definition)or nil,
        cc=definition.cc,ccUnknown=definition.ccUnknown,ccHard=definition.ccHard,blockable=false,parryable=false}
    local accepted,why=self.threats:Observe(t);if not accepted then return nil,why,buffReads end
    self.active[key]={id=id,kind='timed_targeted_effect',owner=ownerID,
        nativeName=spell.name,nativeEnd=clock.finish,emissionEnd=clock.finish,
        expires=clock.finish,closed=false}
    self.count=self.count+1
    return t,nil,buffReads
end

-- Stationary caster-centred area for the observed channel (rooted caster).
-- Possible contacts only: target selection and per-dagger damage are unknown.
function C:ObserveArea(owner,spell,definition,now,clock)
    local c=definition.cast;local profile=c.channel
    if c.shape~='circle'or c.anchor~='caster'or not G.finite(c.radius)or c.radius<=0 or c.radius>2000
        or not G.finite(profile.moveTolerance)or profile.moveTolerance<0 or profile.moveTolerance>200 then
        return nil,'unsupported_channel_geometry'
    end
    local ownerID=owner.networkID or owner.handle
    if not ownerID then return nil,'channel_owner_missing'end
    local key=tostring(ownerID)..':'..c.alias..':'..tostring(clock.finish)
    if self.active[key]then return false,'channel_already_observed'end
    local center=spell.startPos or owner.pos
    if not G.point(center)then return nil,'channel_origin_missing'end
    center=G.copy(center)
    if G.point(owner.pos)and G.dist(owner.pos,center)>profile.moveTolerance then return nil,'channel_caster_displaced'end
    if self.count>=self.max then
        self.threats.overflow=true
        self.threats.overflowUntil=math.max(self.threats.overflowUntil or 0,clock.finish)
        return nil,'channel_capacity'
    end
    local id='channel:'..key
    local t={id=id,instanceID=id,stageID=id,damageID=id,casterID=ownerID,profile=definition.profile,
        ability=definition.id,abilityName=definition.name,champion=owner.charName,source=definition.source,
        evidence='cast-derived',shape='circle',origin=center,b=G.copy(center),radius=c.radius,
        starts=clock.launch,ends=clock.finish,persistent=true,continuationConditional=true,
        timingScope='self_centered_channel_area',observedAt=now,castOrigin=G.copy(center),castStart=clock.start,
        castLaunch=clock.launch,clockEvidence=clock.evidence,castStartSource=clock.startSource,castFinishSource='castEndTime',
        blockable=false,parryable=false,cc=definition.cc,ccUnknown=definition.ccUnknown,ccHard=definition.ccHard}
    local accepted,why=self.threats:Observe(t);if not accepted then return nil,why end
    self.active[key]={id=id,kind='self_centered_area',owner=ownerID,ownerHandle=owner.handle,
        nativeName=spell.name,nativeEnd=clock.finish,emissionEnd=clock.finish,expires=clock.finish,
        closed=false,center=G.copy(center),moveTolerance=profile.moveTolerance}
    self.count=self.count+1
    return t
end
function C:Expire(now)
    for key,row in pairs(self.active)do
        -- Keep cancelled identities until their original horizon has passed;
        -- delayed native echoes cannot restart a cancelled channel.
        if now>row.expires+.5 then self.active[key]=nil;self.count=self.count-1 end
    end
end
function C:Correlate(threat)return Link.Attach(self.active,self.threats.byID,threat)end
return C

end
