return function(require)
local Channels=require('evade.channels')
local PostDeath=require('evade.postdeath')
local G=require('evade.geometry')
local Calculations=require('evade.calculations')
local Returns=require('evade.returns')
local Locked=require('evade.locked')
local Identities=require('evade.identities')
local Extras=require('evade.extras')
local Landings=require('evade.landings')
local Impacts=require('evade.impacts')
local Anchors=require('evade.anchors')
local Extents=require('evade.extents')
local Abilities=require('CombatProfiles.abilities')
local CombatMechanics=require('CombatProfiles.champion_mechanics')
local function readCastFinish(spell,start)
    local finish=spell.castEndTime
    if G.finite(finish)and finish>=start then return finish,'castEndTime' end
    local windup=spell.windup
    if not G.finite(windup)then return nil,nil,'missing_cast_finish' end
    if windup<0 then return nil,nil,'invalid_cast_windup' end
    return start+windup,'windup'
end
local O={};O.__index=O
-- The facing rule of a gaze ability (`gaze`: the safe sense relative to the caster) for the planner:
-- broken, the ability's hard control conditional on facing applies (its longest stated duration, or an
-- unknown duration); met, only its soft effect does. One table per definition.
local facingRules=setmetatable({},{__mode='k'})
local function facingRule(gaze,definition)
    if gaze~='away'and gaze~='toward'then return nil end
    local key=facingRules[definition]
    if key and key.sense==gaze then return key end
    local rule={sense=gaze}
    local profile=type(definition.ccProfile)=='table'and definition.ccProfile.effects
    for _,effect in ipairs(type(profile)=='table'and profile or {})do
        if type(effect)=='table'and effect.conditional=='facing'and effect.hard==true then
            rule.hard=true
            if G.finite(effect.lowerBound)and effect.lowerBound>(rule.cc or 0)then rule.cc=effect.lowerBound end
        end
    end
    facingRules[definition]=rule;return rule
end
local function sameCastPoint(a,b)
    return a and b and a.x==b.x and a.z==b.z and (a.y or 0)==(b.y or 0)
end
local function indexHero(index,id,hero)
    if not G.finite(id)or id<=0 or id~=math.floor(id)then return end
    local previous=index[id]
    if previous==nil or previous==hero then index[id]=hero
    else index[id]=false end -- Native owner references do not identify an ID namespace.
end
local function indexMissileAliases(set)
    if set.__missileLower then return set.__missileLower end
    local index={};set.__missileLower=index
    -- Preserve every stage while folding spelling once per loaded profile.
    -- An unsupported alternative must still veto alias-only resolution.
    for alias,names in pairs(set.__missileAliases or {})do
        local key=alias:lower();local bucket=index[key]
        if not bucket then bucket={};index[key]=bucket end
        for _,name in ipairs(names)do
            local duplicate=false
            for _,prior in ipairs(bucket)do if prior==name then duplicate=true;break end end
            if not duplicate then bucket[#bucket+1]=name end
        end
    end
    return index
end
-- One cast/missile index for every loaded set, including development shadow sets.
function O.IndexSet(set)
    set.__casts={};set.__lower={}
    for name,r in pairs(set)do if type(r)=='table'and r.name then
        set.__lower[name:lower()]=r
        if r.cast and (r.walkThreat or r.defensiveThreat)then for _,alias in ipairs(r.cast.aliases)do
            local key=alias:lower();local prior=set.__casts[key]
            if prior==nil then set.__casts[key]=r
            elseif prior~=r then
                -- Several stages can serialize one script alias. A
                -- native alias alone cannot select one by pairs order.
                set.__casts[key]=false
            end
        end end
    end end
    indexMissileAliases(set)
    return set
end
-- Optional development shadow work is isolated: an error there is counted and
-- can never abort, delay or alter the enemy observation pass.
local function shadowCall(shadow,method,...)
    if not pcall(shadow[method],shadow,...)then shadow.errors=(shadow.errors or 0)+1 end
end
function O.new(g,threats,catalog)
    return setmetatable({g=g,threats=threats,catalog=catalog,heroes={},roster={},loaded={},seen={},casts={},lastCast={},unknown={},nextRoster=0,maxMissiles=1024,
        returns=Returns.new(),locked=Locked.new(),landings=Landings.new()},O)
end
function O:Roster(now,shadow)
    if now<self.nextRoster then return end;self.nextRoster=now+.5
    local game=self.g.Game
    self.hostCalls=(self.hostCalls or 0)+1;local count=game.HeroCount()
    if not G.finite(count)or count<0 or count~=math.floor(count)then return false,'hero_snapshot_invalid'end
    if count>64 then return false,'hero_scan_budget'end
    self.roster={};self.heroes={};self.heroViews=nil;self.heroIndexClean=nil;self.allies={}
    if shadow then shadowCall(shadow,'Reset')end
    for i=1,math.min(count,64)do
        self.hostCalls=self.hostCalls+1;local h=game.Hero(i)
        if not h then return false,'hero_read_failed'end
        if h and h.charName and h.team~=self.g.myHero.team then
            local f=self.catalog[Identities.Resolve(h.charName)]
            if f and not self.loaded[h.charName]then
                local set=Abilities.ApplyCatalog(h.charName,f(),CombatMechanics);self.loaded[h.charName]=set;O.IndexSet(set)
                self.loadedCount=(self.loadedCount or 0)+1
                -- Buff zones, placed objects and marks cost nothing unless a champion that has them is present.
                for feature in pairs(set.__features or {})do self.features=self.features or {};self.features[feature]=true end
                Locked.Register(h.charName,set)
                if self.onDiscover then self.onDiscover(h.charName,set)end
            end
            self.roster[#self.roster+1]=h
            indexHero(self.heroes,h.networkID,h)
            indexHero(self.heroes,h.handle,h)
        elseif h.charName then
            -- Allied champions can stop unit-colliding projectiles (evade.collision).
            if h~=self.g.myHero then self.allies[#self.allies+1]=h end
            if shadow then shadowCall(shadow,'Ally',h,self.g.myHero)end
        end
    end
    -- Only a completed refresh without an ambiguous owner namespace permits the
    -- missile team prefilter; an ambiguous owner must still fail the whole scan.
    local clean=true
    for _,hero in pairs(self.heroes)do if hero==false then clean=false;break end end
    self.heroIndexClean=clean
    for id in pairs(self.knownCastSamples or {})do if not self.heroes[id]then self.knownCastSamples[id]=nil end end
end
function O:Allowed(owner,definition)
    return not self.enabled or self.enabled(owner.charName,definition.castAlias or definition.name)
end
local function excludedEpoch(kind,data)
    if kind=='missile'then return 'native_identity_sample'end
    local start=data.startTime
    if not G.finite(start)or start<=0 then start=data.castStartTime end
    if G.finite(start)and start>0 then return 'start:'..tostring(start)end
    local finish=data.endTime
    if G.finite(finish)and finish>0 then return 'end:'..tostring(finish)end
    finish=data.castEndTime
    if G.finite(finish)and finish>0 then return 'cast-end:'..tostring(finish)end
    return 'epoch_unknown'
end
local function excludedKey(kind,owner,record,nativeKey)
    local id=owner.networkID or owner.handle
    if not G.finite(id)or id<=0 or id~=math.floor(id)then return nil end
    local key=kind..':'..owner.charName..':'..tostring(id)..':'..record.name
    if kind=='missile'then
        local missileID=type(nativeKey)=='string'and #nativeKey<=64 and tonumber(nativeKey:match('^missile:(%d+)$'))
        if not G.finite(missileID)or missileID<=0 then return nil end
        key=key..':'..nativeKey
    end
    return key
end
function O:ObserveExcluded(kind,owner,record,object,data,now,nativeKey,ownerView)
    -- Exclusion is runtime policy, not proof that all interactions are harmless.
    -- Reuse this scan's objects; no extra enumeration or modeled threat.
    if not self.onExcluded or not self.diagnostics then return end
    local readable,enabled=pcall(self.diagnostics)
    if not readable or not enabled then return end
    if self.excludedAt~=now then self.excludedAt=now;self.excludedEvents=0 end
    if (self.excludedEvents or 0)>=4 then return end
    local keyOK,key=pcall(excludedKey,kind,ownerView or owner,record,nativeKey)
    if not keyOK then
        self.excludedEvents=(self.excludedEvents or 0)+1
        self.excludedErrors=(self.excludedErrors or 0)+1;return
    end
    if not key then return end
    local prior=self.excluded and self.excluded[key]
    if not prior and (self.excludedCount or 0)>=128 then self.excludedOverflow=true;return end
    local ok,epoch=pcall(excludedEpoch,kind,data)
    if not ok then
        self.excludedEvents=(self.excludedEvents or 0)+1
        self.excludedErrors=(self.excludedErrors or 0)+1;return
    end
    if prior and (type(prior)=='table'and prior.epoch or prior)==epoch then return end
    self.excludedEvents=(self.excludedEvents or 0)+1
    self.excluded=self.excluded or {}
    self.excluded[key]=kind=='missile'and {epoch=epoch,nativeKey=nativeKey}or epoch
    if not prior then self.excludedCount=(self.excludedCount or 0)+1 end
    -- Optional native diagnostic fields must not abort mandatory observation.
    if not pcall(self.onExcluded,kind,owner,record,object,data,now,epoch)then
        self.excludedErrors=(self.excludedErrors or 0)+1
    end
end
function O:CastCapacity(add,expires)
    local count=0
    for _ in pairs(self.casts)do count=count+1 end
    if count+add<=self.threats.max then return true end
    self.threats.overflow=true
    self.threats.overflowUntil=math.max(self.threats.overflowUntil or 0,expires)
    return false
end
local function castEpoch(spell)
    local start=spell.startTime
    if start==nil or start==0 then start=spell.castStartTime end
    return start
end
function O:CancelCast(owner,spell,now,definition)
    local ownerID=owner.networkID or owner.handle
    local start=castEpoch(spell)
    local profile=definition and definition.cast
    if not profile or owner.team==self.g.myHero.team or not ownerID or not G.finite(now)or not G.finite(start)or start<=0
        or start>now+.1 or now-start>2 then return end
    for id,c in pairs(self.casts)do
        if c.owner==ownerID and c.alias==profile.alias and c.starts==start and not c.linked and c.launch
            and now<(c.cancelUntil or c.launch)then
            self.threats:Remove(id);Extras.Remove(self,id,profile)
            if c.instanceID and self.fanEpochs and self.fanEpochs[c.instanceID]then
                self.casts[id]=nil -- The bounded fan parent already retains this epoch.
            else
                c.cancelled=true;c.geometryUnknown=nil
                -- Keep only the native observation window, not a cancelled zone's
                -- full duration. Old echoes cannot become a fresh ability instance.
                c.ends=math.max(start+2,now)
            end
        end
    end
    local finish=readCastFinish(spell,start);if not finish then return end
    if now>=finish then return end -- A completed cast can leave a persistent effect.
    local id='cast:'..tostring(ownerID)..':'..profile.alias..':'..tostring(start)
    if self.casts[id]or self.fanEpochs and self.fanEpochs[id]then return end
    local expires=math.max(start+2,now)
    if not self:CastCapacity(1,expires+.5)then
        -- No eviction of a live epoch. During this exceptional gap no new cast
        -- forecast may be fabricated from an unretained cancelled identity.
        self.cancellationGapUntil=math.max(self.cancellationGapUntil or 0,expires+.5)
        return
    end
    self.casts[id]={owner=ownerID,alias=profile.alias,starts=start,launch=finish,ends=expires,cancelled=true}
end
function O:Damage(owner,definition)
    -- Share only within this observation pass. Spell rank/AP/readiness are read
    -- again next tick; a nil estimate is cached as unknown, never as zero damage.
    if not self.damageScope then return Calculations.Damage(owner,definition)end
    local bucket=self.damageScope[owner]
    if not bucket then bucket={};self.damageScope[owner]=bucket end
    local result=bucket[definition]
    if result==nil then
        local damage,reads=Calculations.Damage(owner,definition)
        self.hostCalls=self.hostCalls+(reads or 0)
        result=damage or false;bucket[definition]=result
    end
    return result or nil
end
-- `objectName` may carry this scan's already-read object.name; `pos==nil` with an
-- object reads object.pos only when a row is emitted. Same values, fewer host reads.
function O:Reject(kind,id,reason,owner,spell,now,definition,pos,details,object,objectName)
    if not self.onReject or not self.diagnostics or not self.diagnostics()then return end
    self.rejections=self.rejections or {};self.rejectionCount=self.rejectionCount or 0
    local prior=self.rejections[id]
    if not prior and self.rejectionCount>=128 then return end
    local spellName=spell.name
    if prior then
        if objectName==nil then objectName=object and object.name end
        -- One row per unchanged identity while it remains present. A lingering stale
        -- wrapper (Classic Jade_GravesQ_SoundMissile: 232 rows per object) only keeps
        -- its entry alive; the prune in the missile scan forgets it 2 s after its
        -- last sighting, so a later reappearance is reported again.
        if prior.reason==reason and prior.name==spellName and prior.objectName==objectName then
            prior.seenAt=now;return
        end
    end
    -- New evidence for one kind/reason/name is bounded per second, before any
    -- further object read. The first rows always pass; suppressed attempts (one per
    -- call, so a still-present identity counts again each tick) are added to that
    -- key's next emitted row as `throttled`.
    local key=kind..'|'..tostring(reason)..'|'..tostring(spellName)
    if not self.rejectionWindow or now-self.rejectionWindow>=1 or now<self.rejectionWindow then
        self.rejectionWindow=now;self.rejectionRates={}
    end
    local used=self.rejectionRates[key]or 0
    if used>=4 then
        local throttled=self.rejectionThrottled or {};self.rejectionThrottled=throttled
        if throttled[key]then throttled[key]=throttled[key]+1
        elseif(self.rejectionThrottledKeys or 0)<64 then
            throttled[key]=1;self.rejectionThrottledKeys=(self.rejectionThrottledKeys or 0)+1
        else self.rejectionThrottledOther=(self.rejectionThrottledOther or 0)+1 end
        return
    end
    self.rejectionRates[key]=used+1
    if not prior then
        if objectName==nil then objectName=object and object.name end
        self.rejectionCount=self.rejectionCount+1
    end
    if pos==nil and object then pos=object.pos end
    self.rejections[id]={reason=reason,name=spellName,objectName=objectName,at=now,seenAt=now}
    local endPos=spell.endPos or spell.placementPos
    local row={id=id,reason=reason,champion=owner and owner.charName or 'unknown',
        name=spellName,objectName=objectName,ability=definition and definition.name,owner=spell.owner,
        speed=spell.speed,width=spell.width,target=spell.target,start=spell.startTime,finish=spell.castEndTime,
        expectedSpeed=definition and definition.speed,expectedRadius=definition and definition.radius,
        x=pos and pos.x,z=pos and pos.z,toX=endPos and endPos.x,toZ=endPos and endPos.z}
    if details then for field,value in pairs(details)do row[field]=value end end
    local throttled=self.rejectionThrottled
    if throttled and throttled[key]then
        row.throttled=throttled[key];throttled[key]=nil;self.rejectionThrottledKeys=self.rejectionThrottledKeys-1
    end
    if self.rejectionThrottledOther then row.throttledOther=self.rejectionThrottledOther;self.rejectionThrottledOther=nil end
    self.onReject(kind,row)
end
local function epochMatches(model,distance,at,launch)
    local earliest,latest=G.travelTimeBounds(model,math.max(0,distance))
    return launch>=at-latest-.1 and launch<=at-earliest+.1
end
local function displacementBounds(model,speed,elapsed,remaining)
    local lower,upper
    if model.speedUncertain then
        elapsed=math.max(0,elapsed);lower,upper=model.minSpeed*elapsed,model.maxSpeed*elapsed
    elseif not model.acceleration or model.acceleration==0 then
        -- The common constant-speed observation needs no temporary motion table.
        lower=math.max(model.minSpeed or 0,math.min(model.maxSpeed or math.huge,speed or 0))*math.max(0,elapsed)
        upper=lower
    else
        lower=G.travel({speed=speed,acceleration=model.acceleration,minSpeed=model.minSpeed,maxSpeed=model.maxSpeed},elapsed)
        upper=lower
    end
    if remaining then lower,upper=math.min(lower,remaining),math.min(upper,remaining)end
    return lower,upper
end
local function withinBounds(distance,lower,upper,floor,fraction)
    return distance>=lower-math.max(floor,lower*fraction)and distance<=upper+math.max(floor,upper*fraction)
end
function O:MatchObservedCast(owner,c,origin,destination,start,launch)
    if c.shape~='missile'then return end
    local chosen,chosenID;local ownerID=owner.networkID or owner.handle
    local ax,az=G.direction(origin,destination)
    for id,previous in pairs(self.seen)do
        if previous.confirmed and not previous.castLinked and previous.damageID
            and (previous.owner==ownerID or previous.owner==owner.handle)
            and previous.at>=start and G.point(previous.start)then
            local matches=previous.alias==c.missile
            if not matches and c.missiles then
                for _,alias in ipairs(c.missiles)do if alias==previous.alias then matches=true;break end end
            end
            if matches and G.dist(origin,previous.start)<=150 then
                local bx,bz=G.direction(previous.start,previous.endpoint)
                local px,pz=previous.pos.x-previous.start.x,previous.pos.z-previous.start.z
                local progress=px*bx+pz*bz
                -- Match forward correlation: radial distance cannot establish a
                -- launch epoch for a stale off-ray start or a position behind it.
                if progress>=0 and math.abs(px*bz-pz*bx)<=20
                    -- A fixed-time cast's speed is per flight: use the projectile's own.
                    and ax*bx+az*bz>.98 and epochMatches(c.flightTime and {speed=previous.speed}or c,progress,previous.at,launch)then
                    if chosen then return nil,nil,'ambiguous_observed_cast'end -- simultaneous emitters
                    chosen=previous;chosenID=id
                end
            end
        end
    end
    return chosen,chosenID
end
local function spellRank(owner,slot)local data=owner:GetSpellData(slot);return data and data.level end
-- Own-profile wall (c.wall): a stationary segment perpendicular to the cast
-- direction, centred on the native placement clamped to own castRange. Length
-- follows the caster's current rank when readable, else the profile envelope.
-- Returns a,b,length,lengthSource,hostReads or nil,reason.
local function wallSegment(owner,c,origin,destination,length)
    local w=c.wall
    if c.shape~='rectangle'or type(w)~='table'or not G.finite(w.length)or w.length<=0 or w.length>5000
        or not G.finite(c.range)or c.range<=0 or not G.finite(c.radius)or c.radius<=0 then return nil,'invalid_wall_profile'end
    if not G.finite(length)or length<1 then return nil,'zero_cast_direction'end
    local size,source,reads=w.length,'envelope',nil
    if type(w.lengths)=='table'and G.finite(c.slot)then
        reads=1
        local ok,rank=pcall(spellRank,owner,c.slot)
        local value=ok and G.finite(rank)and rank==math.floor(rank)and rank>=1 and w.lengths[rank]
        if G.finite(value)and value>0 and value<=w.length then size,source=value,'rank' end
    end
    local dx,dz=(destination.x-origin.x)/length,(destination.z-origin.z)/length
    local center=length>c.range and G.lerp(origin,destination,c.range/length)or G.copy(destination)
    local half=size/2
    return {x=center.x+dz*half,y=center.y or 0,z=center.z-dx*half},
        {x=center.x-dz*half,y=center.y or 0,z=center.z+dx*half},size,source,reads
end
local function geometryRejected(observer,previous,reject,reason,c,ownerID,key,start,finish,now)
    if not previous and c.nativeCastGeometry==true then
        -- Keep attributable identity/timing even when there is no drawable ray.
        -- This capability is for profiled straight-projectile cast observations.
        local launch=math.max(start,finish)
        local _,latest=G.travelTimeBounds(c,c.range);local ends=launch+latest
        if not G.finite(ends)then reject('cast_geometry_lifetime_unmodeled');return end
        local count=0;for _ in pairs(observer.casts)do count=count+1 end
        if count>=observer.threats.max then
            observer.threats.overflow=true
            observer.threats.overflowUntil=math.max(observer.threats.overflowUntil or 0,ends)
            reject('cast_geometry_capacity');return
        end
        local id='cast:'..key
        previous={owner=ownerID,alias=c.alias,missile=c.missile,missiles=c.missiles,
            observedAt=now,starts=start,launch=launch,ends=ends,damageID=id,linked=false}
        observer.casts[id]=previous;observer.lastCast[ownerID]=key
    end
    if previous then
        previous.geometryUnknown=true;observer.castGeometryUnmodeled=true
        observer.threats:Remove(previous.damageID)
    end
    reject(reason)
end
function O:ObserveFan(base,c,owner,start,launch,key,reject,placement,definition)
    local offsets=c.rays
    if c.shape~='missile'or type(offsets)~='table'or #offsets<2 or #offsets>16
      or(c.hitRule~='once_per_cast'and c.hitRule~='per_projectile')then reject('invalid_fan_model');return end
    local anchor=base.castOrigin
    if c.fanAnchor~=nil and c.fanAnchor~='caster'and c.fanAnchor~='placement'then
        reject('invalid_fan_anchor');return
    end
    if c.fanAnchor=='placement'then
        if not G.point(placement)or not G.finite(c.fanPlacementRange)or c.fanPlacementRange<=0 then
            reject('fan_placement_evidence_missing');return
        end
        local distance=G.dist(base.castOrigin,placement)
        if distance<1 or distance>c.fanPlacementRange+1e-6 then
            reject('fan_placement_outside_profile');return
        end
        anchor=G.copy(placement)
    end
    local delay=c.fanDelay;if delay==nil then delay=0 end
    if not G.finite(delay)or delay<0 or delay>20 then reject('invalid_fan_delay');return end
    local cancelUntil=launch
    if delay>0 then
        -- Completion commits the ability; later activation is not extra windup.
        launch=launch+delay
        base.nativeCastEnd=cancelUntil;base.castLaunch=launch;base.launch=launch
        base.starts=base.starts+delay;base.ends=base.ends+delay
        if base.arrivalLatest then base.arrivalLatest=base.arrivalLatest+delay end
        base.clockEvidence='native_completion_plus_profile_delay'
    end
    local dx,dz=G.direction(base.castOrigin,base.b)
    local rays={};local maxOriginOffset=0;local minSeparation=math.pi
    for i=1,#offsets do
        local entry=offsets[i];local angle=entry;local forward,side,aimDistance=0,0,nil
        if type(entry)=='table'then
            angle=entry.angle;forward=entry.originForward or 0;side=entry.originSide or 0
            aimDistance=entry.aimDistance
        end
        if not G.finite(angle)or math.abs(angle)>math.pi
          or not G.finite(forward)or not G.finite(side)
          or aimDistance~=nil and(not G.finite(aimDistance)or aimDistance<=0)then
            reject('invalid_fan_ray');return
        end
        local origin={x=anchor.x+dx*forward-dz*side,y=anchor.y,
            z=anchor.z+dz*forward+dx*side}
        if not G.point(origin)then reject('invalid_fan_origin');return end
        local co,si=math.cos(angle),math.sin(angle)
        local ax,az=dx*co-dz*si,dx*si+dz*co
        if aimDistance then
            -- The aim point is relative to the selected anchor. An offset emitter
            -- aiming at that point does not fly at the locator's own angle.
            local target={x=anchor.x+ax*aimDistance,y=origin.y,z=anchor.z+az*aimDistance}
            if not G.point(target)or G.dist(origin,target)<1 then reject('invalid_fan_aim');return end
            ax,az=G.direction(origin,target)
        end
        local destination={x=origin.x+ax*c.range,y=origin.y,z=origin.z+az*c.range}
        if not G.point(destination)then reject('invalid_fan_endpoint');return end
        for j=1,i-1 do
            local prior=rays[j]
            local gap=math.acos(math.max(-1,math.min(1,ax*prior.dx+az*prior.dz)))
            if gap<1e-6 then reject('duplicate_fan_ray');return end
            minSeparation=math.min(minSeparation,gap)
        end
        maxOriginOffset=math.max(maxOriginOffset,G.dist(anchor,origin))
        rays[i]={origin=origin,destination=destination,dx=ax,dz=az}
    end
    -- Separation follows resolved flight directions, not targeter angles.
    local matchDot=math.cos(math.min(math.acos(.98),minSeparation*.45))
    -- Direction/epoch metadata is invariant across rays. Scan observation
    -- history once, before ray-specific direction matching, within this cast.
    local observed={};local scanned=0;local ownerID=owner.networkID or owner.handle
    for observedID,previous in pairs(self.seen)do
        scanned=scanned+1
        if scanned>self.maxMissiles then
            self.threats.overflow=true;self.threats.overflowUntil=math.max(self.threats.overflowUntil or 0,base.ends)
            reject('fan_correlation_budget');return
        end
        if previous.confirmed and not previous.castLinked and previous.damageID
          and(previous.owner==ownerID or previous.owner==owner.handle)
          and previous.at>=start and G.point(previous.start)then
            local matches=previous.alias==c.missile
            if not matches and c.missiles then
                for _,alias in ipairs(c.missiles)do if alias==previous.alias then matches=true;break end end
            end
            if matches and G.dist(anchor,previous.start)<=maxOriginOffset+150 then
                local bx,bz=G.direction(previous.start,previous.endpoint)
                local px,pz=previous.pos.x-previous.start.x,previous.pos.z-previous.start.z
                local progress=px*bx+pz*bz
                if progress>=0 and math.abs(px*bz-pz*bx)<=20
                  and epochMatches(c,progress,previous.at,launch)then
                    observed[#observed+1]={id=observedID,previous=previous,dx=bx,dz=bz}
                end
            end
        end
    end
    if (self.fanEpochCount or 0)>=self.threats.max then
        self.threats.overflow=true;self.threats.overflowUntil=math.max(self.threats.overflowUntil or 0,base.ends)
        reject('fan_epoch_capacity');return
    end
    local prepared,used={},{};local required=0;local latest=base.ends;local damageRead=false
    for index,ray in ipairs(rays)do
        local origin,destination=ray.origin,ray.destination
        local id=base.id..':ray:'..index;local damageID=c.hitRule=='once_per_cast'and base.id or id
        local prior,priorID
        local ax,az=ray.dx,ray.dz
        for _,entry in ipairs(observed)do
            if ax*entry.dx+az*entry.dz>matchDot and G.dist(origin,entry.previous.start)<=150 then
                if prior then prior=nil;priorID=nil;break end -- ambiguous simultaneous emitters
                prior,priorID=entry.previous,entry.id
            end
        end
        -- Expired unobserved rays cannot publish a new forecast. A linked native
        -- projectile retains its independently observed lifetime and damage.
        if prior or base.ends>=base.observedAt then
        local event
        if prior then
            if used[priorID]then reject('ambiguous_fan_projectile');return end
            used[priorID]=true;event=self.threats:Snapshot(priorID)
            if not event then reject('missing_fan_observation');return end
        else
            if not damageRead then base.damage=self:Damage(owner,definition);damageRead=true end
            event={};for field,value in pairs(base)do event[field]=value end
            event.id=id;event.origin=origin;event.b=destination
            event.contourOrigin=G.copy(origin)
        end
        event.instanceID=base.instanceID;event.stageID=id;event.damageID=damageID
        local valid,why=G.valid(event);if not valid then reject(why);return end
        if not self.threats.byID[event.id]then required=required+1 end
        latest=math.max(latest,event.ends)
        prepared[#prepared+1]={event=event,prior=prior,castID=id,cast={owner=base.casterID,
            alias=c.alias,missile=c.missile,missiles=c.missiles,origin=origin,destination=destination,
            starts=start,launch=launch,cancelUntil=cancelUntil,ends=base.ends,observedAt=prior and prior.observedAt or base.observedAt,
            damageID=damageID,instanceID=base.instanceID,stageID=id,linked=prior~=nil,matchDot=matchDot}}
        end
    end
    if #self.threats.list+required>self.threats.max then
        self.threats.overflow=true;self.threats.overflowUntil=math.max(self.threats.overflowUntil or 0,latest)
        reject('threat_capacity');return
    end
    local additional=0
    for _,row in ipairs(prepared)do if not self.casts[row.castID]then additional=additional+1 end end
    if not self:CastCapacity(additional,latest)then reject('cast_history_capacity');return end
    for _,row in ipairs(prepared)do
        local accepted,why=self.threats:Observe(row.event)
        if not accepted then
            self.threats.overflow=true;self.threats.overflowUntil=math.max(self.threats.overflowUntil or 0,latest)
            reject(why or 'fan_publication_failed');return
        end
        self.casts[row.castID]=row.cast
        if row.prior then
            row.prior.castLinked=true;row.prior.damageID=row.event.damageID
            row.prior.instanceID=row.event.instanceID;row.prior.stageID=row.event.stageID
        end
    end
    self.fanEpochs=self.fanEpochs or {}
    self.fanEpochs[base.id]=math.max(latest,start+2)+.5
    self.fanEpochCount=(self.fanEpochCount or 0)+1
    self.lastCast[base.casterID]=key
    for _,row in ipairs(prepared)do
        if not row.prior and self.onThreat then self.onThreat(row.event)end
    end
end

function O:ObserveCast(owner,spell,now,knownSet)
    if self.channels and owner then self.channels:Reconcile(owner,spell,now)end
    -- Own spawn delays anchor predicted returns at an attributable cast (evade.returns).
    if self.returns and owner and spell then self.returns:Cast(self,owner,spell,now)end
    -- A tracked basic-attack windup that stopped before its cast end never launched (evade.locked).
    if owner and self.locked and self.locked.attackCount>0 then self.locked:Reconcile(self,owner,spell,now)end
    -- The cast scan passes this pass's profile set (false: none loaded) to avoid
    -- re-reading owner.charName; direct callers still resolve it here.
    local set=knownSet
    if set==nil then set=owner and self.loaded[owner.charName]end
    if set==false then set=nil end
    local definition=spell and type(spell.name)=='string'and set and set.__casts and set.__casts[spell.name:lower()]
    -- Charge starts for this profile's charged rows (evade.extents); the charge cast itself may model nothing.
    local chargeIndex=set and set.__chargeIndex
    if chargeIndex==nil and set then chargeIndex=Extents.Index(set)end
    if chargeIndex and owner and spell and type(spell.name)=='string'then
        local ownerID=owner.networkID or owner.handle
        if ownerID then Extents.Cast(self,ownerID,spell.name:lower(),spell,chargeIndex,now)end
    end
    if definition and self.onKnownCast and self.diagnostics and self.diagnostics()then
        local ownerID=owner.networkID or owner.handle
        local epoch=spell.startTime or spell.castStartTime
        if ownerID then
        self.knownCastSamples=self.knownCastSamples or {}
        local prior=self.knownCastSamples[ownerID]
        if not prior or prior.name~=spell.name or prior.epoch~=epoch or prior.valid~=spell.valid or prior.stopped~=spell.isStopped then
            self.knownCastSamples[ownerID]={name=spell.name,epoch=epoch,valid=spell.valid,stopped=spell.isStopped}
            self.onKnownCast(owner,spell,definition)
        end
        end
    end
    if definition and definition.cast and definition.cast.channel then
        if owner.team==self.g.myHero.team or owner.dead and not definition.cast.postDeath or not self:Allowed(owner,definition)then return end
        self.channels=self.channels or Channels.new(self.threats)
        local t,why,buffReads=self.channels:Observe(owner,spell,definition,now,self.g.myHero,self.Damage,self)
        if buffReads then self.hostCalls=(self.hostCalls or 0)+buffReads end
        if t and self.onThreat then self.onThreat(t)
        elseif t==nil then self:Reject('cast_rejected','channel:'..tostring(owner.networkID or owner.handle),why,owner,spell,now,definition,owner.pos)end
        return
    end
    -- A stop is a cancellation only after the same cast was seen running. The host shows
    -- isStopped from the first sample for casts that launch (live 2026-10-28, Classic: 17 of 20
    -- Blitzcrank grabs, 25 of 28 Aatrox E, 40 of 51 Kassadin R were first seen stopped and fired;
    -- earlier sessions: 126 of 181 Ezreal Q). No cast was ever seen to change its flag.
    local stopped=spell and spell.isStopped==true
    if stopped then
        local ownerID=owner and(owner.networkID or owner.handle)
        local seen=ownerID and self.running and self.running[ownerID]
        if seen and seen.name==spell.name and seen.start==castEpoch(spell)then
            self:CancelCast(owner,spell,now,definition)
            return
        end
    end
    if not owner or not spell or not spell.valid or type(spell.name)~='string'or owner.team==self.g.myHero.team then return end
    -- `set`/`definition` above already hold this synchronous call's lookup for
    -- the same owner and string spell name; no second charName read or lower().
    if owner and owner.dead and not(set and set.__postDeath)then return end
    if not definition then
        -- Own-profile instant unit cast at the player (evade.locked).
        if definition==nil and self.locked and self.locked:Cast(self,owner,spell,now)then return end
        if definition==false then
            self:Reject('cast_rejected','cast-alias:'..tostring(owner.networkID or owner.handle)..':'..spell.name,
                'cast_alias_ambiguous',owner,spell,now,nil,owner.pos)
        end
        local record=set and set.__lower and set.__lower[spell.name:lower()]
        if record and (record.threatRole=='utility'or record.threatRole=='non_hostile_component')then
            self:ObserveExcluded('cast',owner,record,nil,spell,now);return
        end
        -- A listed dangerous targeted cast at the player that no row models (evade.unlisteddata).
        if definition==nil and self.locked and self.locked:Unlisted(self,owner,spell,set,now)then return end
        local key=owner.charName..':'..spell.name
        -- Unknown-cast recording needs a stable observation epoch even when the
        -- host reports zero startup for a channel. This does not authorize a threat.
        local startup=spell.startTime
        if not G.finite(startup)or startup<=0 then startup=spell.castStartTime end
        local castID='unknown'
        if G.finite(startup)and startup>0 then castID=startup
        elseif G.finite(spell.endTime)and spell.endTime>0 then castID='end:'..tostring(spell.endTime)
        elseif G.finite(spell.castEndTime)and spell.castEndTime>0 then castID='cast-end:'..tostring(spell.castEndTime)end
        if self.onUnknownCast and (not self.diagnostics or self.diagnostics())and self.unknown[key]~=castID and (self.unknown[key]or (self.unknownCount or 0)<128)
            and not spell.isAutoAttack and not spell.name:lower():find('attack',1,true)then
            if not self.unknown[key]then self.unknownCount=(self.unknownCount or 0)+1 end
            self.unknown[key]=castID
            self.onUnknownCast(owner,spell)
        end
        return
    end
    local rejectID='cast:'..tostring(owner.networkID or owner.handle)..':'..spell.name
    local function reject(reason)self:Reject('cast_rejected',rejectID,reason,owner,spell,now,definition,owner.pos)end
    if not self:Allowed(owner,definition)then reject('menu_disabled');return end
    local c=definition.cast;local start=spell.startTime;local startSource='startTime'
    if start==nil or start==0 then start=spell.castStartTime;startSource='castStartTime' end
    if not G.finite(start)or start<=0 or start>now+.1 or now-start>2 then reject('invalid_cast_start');return end
    local finish,finishSource,finishReason=readCastFinish(spell,start)
    if not finish then reject(finishReason);return end
    local ownerID=owner.networkID or owner.handle;if not ownerID then return end
    if not stopped then
        self.running=self.running or {}
        local seen=self.running[ownerID]
        if not seen then seen={};self.running[ownerID]=seen end
        seen.name=spell.name;seen.start=start
    end
    local key=tostring(ownerID)..':'..c.alias..':'..tostring(start)
    if self.lastCast[ownerID]==key and c.nativeCastGeometry~=true then return end
    -- Charged or stat-scaled reach/radius, fixed at this release (evade.extents).
    local extent=definition.charge
    local extentValue,extentSource,extentInput
    if extent then
        if not Extents.Valid(extent)then reject('invalid_extent');return end
        extentValue,extentSource,extentInput=Extents.Value(self,owner,ownerID,extent,start,now,extent.key=='radius'and c.radius or c.range)
    end
    local radius=extent and extent.key=='radius'and extentValue or c.radius
    local id='cast:'..key
    -- A fan's parent survives ray replacement and prelaunch cancellation.
    -- An older cast echo cannot republish rays after another cast becomes latest.
    if c.rays and self.fanEpochs and self.fanEpochs[id]then return end
    local previous=self.casts[id]
    if previous then
        if previous.cancelled then return end
        if c.nativeCastGeometry~=true or previous.linked or now>previous.ends then return end
    elseif self.lastCast[ownerID]==key then return end
    local authorized,admissionReason,buffReads=PostDeath.Authorize(owner,spell,definition,now)
    if buffReads then self.hostCalls=(self.hostCalls or 0)+buffReads end
    if not authorized then reject(admissionReason);return end
    -- Only explicitly profiled native cast coordinates may revise an instance.
    -- Caster movement alone is not evidence that a launched ray moved with it.
    local origin=spell.startPos or owner.pos;local destination=spell.placementPos or spell.endPos
    if c.nativeCastGeometry==true and not G.point(spell.startPos)then geometryRejected(self,previous,reject,'native_cast_origin_missing',c,ownerID,key,start,finish,now);return end
    if not G.point(origin)then geometryRejected(self,previous,reject,'missing_origin',c,ownerID,key,start,finish,now);return end
    if c.anchor=='caster'then destination=origin end
    -- Sheet anchor: the place this caster's own named projectile last ended (a ball left
    -- on the ground), while recent and inside its leash; otherwise the caster.
    if c.anchorMissile then
        local kept=self.anchors and self.anchors[tostring(ownerID or owner.networkID or owner.handle)..':'..c.anchorMissile]
        local at=origin
        if kept and now-kept.at<=(c.anchorAge or 20)and G.point(origin)and G.dist(kept.pos,origin)<=(c.anchorLeash or 1300)then at=kept.pos end
        origin=at;destination=at
    end
    -- A self-cast directional sheet shape (no native placement) follows the caster's facing.
    if c.useFacing and G.point(origin)and(not G.point(destination)or G.dist(origin,destination)<1)then
        local dir=owner.dir
        if G.point(dir)and(dir.x~=0 or dir.z~=0)then destination={x=origin.x+dir.x*100,y=origin.y or 0,z=origin.z+dir.z*100}end
    end
    if not G.point(destination)then geometryRejected(self,previous,reject,'missing_destination',c,ownerID,key,start,finish,now);return end
    if previous and not previous.geometryUnknown and sameCastPoint(previous.origin,origin)
        and sameCastPoint(previous.nativeDestination,destination)and previous.launch==math.max(start,finish)then return end
    local nativeDestination=c.nativeCastGeometry==true and G.copy(destination)or nil
    origin=G.copy(origin);destination=G.copy(destination)
    local length=G.dist(origin,destination)
    local wallA,wallB,wallLength,wallSource
    if c.wall~=nil then
        local reads;wallA,wallB,wallLength,wallSource,reads=wallSegment(owner,c,origin,destination,length)
        if reads then self.hostCalls=(self.hostCalls or 0)+reads end
        if not wallA then geometryRejected(self,previous,reject,wallB,c,ownerID,key,start,finish,now);return end
    end
    -- Reviewed landings whose observed projectile ends a fixed distance beyond the
    -- native placement and/or stops at the own range (e.g. Classic Chum the Waters).
    if c.placementExtension~=nil or c.clampToRange~=nil then
        if c.shape~='circle'or c.anchor=='caster'or c.wall~=nil or (c.clampToRange~=nil and c.clampToRange~=true)
            or (c.placementExtension~=nil and (not G.finite(c.placementExtension)or c.placementExtension<0 or c.placementExtension>200))
            or not G.finite(c.range)or c.range<=0 then reject('invalid_landing_projection');return end
        if length<1 then geometryRejected(self,previous,reject,'zero_cast_direction',c,ownerID,key,start,finish,now);return end
        local reach=length+(c.placementExtension or 0)
        if c.clampToRange then reach=math.min(reach,c.range)end
        destination=G.lerp(origin,destination,reach/length);length=reach
    end
    -- A reviewed ground ring (e.g. a cage perimeter) is centred on the placement like a circle.
    local reach=extent and extent.key=='range'and extentValue or c.range
    -- Sheet circle a fixed distance ahead of the caster in the aimed direction.
    if c.centerForward~=nil then
        if c.shape~='circle'and c.shape~='ring'or not G.finite(c.centerForward)or c.centerForward<0 or c.centerForward>3000 then
            reject('invalid_center_offset');return end
        if length<1 then geometryRejected(self,previous,reject,'zero_cast_direction',c,ownerID,key,start,finish,now);return end
        destination=G.lerp(origin,destination,c.centerForward/length);length=c.centerForward
    end
    if c.shape~='circle'and c.shape~='ring' then
        if length<1 then geometryRejected(self,previous,reject,'zero_cast_direction',c,ownerID,key,start,finish,now);return end
        -- Sheet shapes: `toCursor` stops at the aimed point (not below minRange);
        -- `originForward` starts the footprint ahead of (negative: behind) the caster.
        if c.toCursor then reach=math.max(c.minRange or 0,math.min(length,reach))end
        local shift=c.originForward
        if shift~=nil then
            if not G.finite(shift)or math.abs(shift)>2000 then reject('invalid_origin_shift');return end
            local ux,uz=(destination.x-origin.x)/length,(destination.z-origin.z)/length
            local moved={x=origin.x+ux*shift,y=origin.y or 0,z=origin.z+uz*shift}
            destination={x=moved.x+ux*length,y=destination.y or 0,z=moved.z+uz*length};origin=moved
        end
        destination=G.lerp(origin,destination,reach/length)
        -- `reverse`: the effect starts at the far end and travels back toward the caster.
        if c.reverse then origin,destination=destination,origin end
    elseif c.anchor~='caster'and length>c.range+100 then geometryRejected(self,previous,reject,'cast_out_of_range',c,ownerID,key,start,finish,now);return end
    local launch=math.max(start,finish)
    -- Sheet delay between cast completion (or, `strikeFrom='start'`, the cast start) and the effect.
    if c.strikeDelay~=nil then
        if c.transportSpeed~=nil or c.groundDelay~=nil or c.landingFlights or not G.finite(c.strikeDelay)or c.strikeDelay<0 or c.strikeDelay>10
            or c.strikeFrom~=nil and c.strikeFrom~='start'then reject('invalid_strike_delay');return end
        launch=math.max(start,(c.strikeFrom=='start'and start or launch)+c.strikeDelay)
    end
    local activation,latestActivation=launch,launch
    if c.transportSpeed~=nil or c.transportSpeedMin~=nil or c.transportFloorMin~=nil or c.transportFloorMax~=nil then
        if c.shape~='circle'then reject('invalid_transport_shape');return end
        if not G.finite(c.transportSpeed)or c.transportSpeed<=0
            or not G.finite(c.transportSpeedMin)or c.transportSpeedMin<=0
            or c.transportSpeedMin>c.transportSpeed then reject('invalid_transport_speed');return end
        local floorMin,floorMax=0,0
        if c.transportFloorMin~=nil or c.transportFloorMax~=nil then
            floorMin,floorMax=c.transportFloorMin,c.transportFloorMax
            if not G.finite(floorMin)or not G.finite(floorMax)or floorMin<0
                or floorMax<floorMin or floorMax>20 then reject('invalid_transport_floor');return end
        end
        -- Reviewed transports observed in flight before the reported cast completion
        -- are anchored at the native start plus an own measured launch-delay interval.
        local base,delayMin,delayMax=launch,0,0
        if c.transportFrom~=nil then
            if c.transportFrom~='start'or not G.finite(c.transportDelayMin)or not G.finite(c.transportDelayMax)
                or c.transportDelayMin<0 or c.transportDelayMax<c.transportDelayMin or c.transportDelayMax>2 then
                reject('invalid_transport_from');return end
            base,delayMin,delayMax=start,c.transportDelayMin,c.transportDelayMax
        end
        -- `arrivalDelay`: reviewed pause between arrival and the hit (sheet rows).
        local after=c.arrivalDelay or 0
        if not G.finite(after)or after<0 or after>5 then reject('invalid_arrival_delay');return end
        activation=base+delayMin+math.max(floorMin,length/c.transportSpeed)+after
        latestActivation=base+delayMax+math.max(floorMax,length/c.transportSpeedMin)+after
        if latestActivation+(c.effectWindow or .15)<now then reject('transport_already_expired');return end
    end
    if c.landingFlights then
        local flights=c.landingFlights
        if c.shape~='circle'or c.transportSpeed~=nil or c.groundDelay~=nil or c.rays
            or type(flights)~='table'or #flights<1 or #flights>8 then reject('invalid_landing_flights');return end
        local earliest,latest=math.huge,0
        for index=1,#flights do
            local flight=flights[index]
            if type(flight)~='table'or not G.finite(flight.value)or flight.value<=0 then reject('invalid_landing_flight');return end
            local travel
            if flight.kind=='fixed'and flight.value<=10 then travel=flight.value
            elseif flight.kind=='speed'then travel=length/flight.value
            else reject('invalid_landing_flight_kind');return end
            if not G.finite(travel)or travel<0 or travel>20 then reject('invalid_landing_travel');return end
            earliest=math.min(earliest,travel);latest=math.max(latest,travel)
        end
        activation=launch+earliest;latestActivation=launch+latest
        if latestActivation+(c.effectWindow or .15)<now then reject('landing_already_expired');return end
    end
    if c.groundDelay then
        local delay=c.groundDelay
        if c.shape~='circle'or c.transportSpeed~=nil or c.rays
            or type(delay)~='table'or delay.origin~='start_or_finish'
            or not G.finite(delay.seconds)or delay.seconds<0 or delay.seconds>10
            or finish-start>20 then reject('invalid_ground_delay');return end
        -- The source gives a delay but not the native clock's origin. Cover
        -- both interpretations without delaying the cast's commitment boundary.
        activation=math.max(launch,start+delay.seconds)
        latestActivation=launch+delay.seconds
        if latestActivation+(c.effectWindow or .15)<now then reject('ground_already_expired');return end
    end
    local threat={id=id,instanceID=id,stageID=id,damageID=id,casterID=ownerID,profile=definition.profile,evidence='cast-derived',
        ability=definition.id,abilityName=definition.name,champion=owner.charName,source=definition.source,
        shape=c.shape,origin=(c.shape=='circle'or c.shape=='ring')and destination or origin,b=destination,radius=radius,
        starts=activation,ends=latestActivation+(c.effectWindow or .15),persistent=c.persistent,halfAngle=c.halfAngle,
        castOrigin=origin,contourOrigin=c.shape=='missile'and G.copy(origin)or nil,
        observedAt=previous and previous.observedAt or now,castStart=start,castLaunch=launch,arrivalLatest=latestActivation,
        castStartSource=startSource,castFinishSource=finishSource,
        length=reach,blockable=c.blockable~=false and not c.persistent,timingScope=c.timing,
        tier=definition.tier,windwall=definition.windwall,gaze=c.gaze,facing=c.gaze and facingRule(c.gaze,definition)or nil,zonePolicy=c.zonePolicy,collide=definition.collide,
        untargetableBlockable=definition.untargetableBlockable==true or c.shape=='missile'and definition.untargetableBlockable~=false,
            cc=definition.cc,ccUnknown=definition.ccUnknown,ccHard=definition.ccHard,parryable=definition.parryable,
            repeatInterval=c.repeatInterval,innerRadius=c.innerRadius,arcRadius=c.arcRadius,parts=c.parts,
            zones=c.zones or definition.zones,displace=definition.displace}
    if wallA then threat.origin=wallA;threat.b=wallB;threat.length=wallLength;threat.wallLengthSource=wallSource end
    if c.shape=='missile'then
        threat.speed=c.speed;threat.acceleration=c.acceleration;threat.minSpeed=c.minSpeed;threat.maxSpeed=c.maxSpeed;threat.speedUncertain=c.speedUncertain
        -- Fixed-time flight (`flightTime`): arrival is launch plus that time whatever
        -- the distance, so the constant speed is this cast's own length over it.
        if c.flightTime~=nil then
            if not G.finite(c.flightTime)or c.flightTime<=0 or c.flightTime>10 then reject('invalid_flight_time');return end
            threat.speed=math.max(reach,1)/c.flightTime;threat.flightTime=c.flightTime
            threat.acceleration,threat.minSpeed,threat.maxSpeed,threat.speedUncertain=nil,nil,nil,nil
        end
        -- Speed step (`speedStep`): the flight changes speed once, `at` units from its start.
        local step=definition.speedStep
        if step and c.flightTime==nil and not c.curve and not threat.acceleration and not threat.speedUncertain then
            threat.speedStep={at=step.at,speed=step.speed}
        end
        local _,latest=G.travelTimeBounds(threat,reach);threat.launch=launch;threat.ends=launch+latest
        -- Curved flight (`curve`): its static corridor from launch to the curve's arrival.
        if c.curve~=nil then
            local arrival=launch+(c.flightTime or latest*(type(c.curve)=='table'and c.curve.stretch or 1))
            local ok,why=G.curveCorridor(threat,c.curve,launch,arrival)
            if not ok then reject(why);return end
        end
    end
    -- Growing circle (`grow`): its radius rises linearly from `initial` to the full radius.
    local grow=c.grow
    if grow and threat.shape=='circle'then
        local from=activation
        local time=grow.time or(G.finite(grow.speed)and grow.speed>0 and(threat.radius-grow.initial)/grow.speed)
        if not G.finite(grow.initial)or grow.initial<0 or grow.initial>=threat.radius or not G.finite(time)or time<=0 or time>10 then
            reject('invalid_growth');return
        end
        threat.radiusTransition={initial=grow.initial,final=threat.radius,starts=from,ends=from+time}
        -- The effect window counts from the full size: a wave is live until its front arrives.
        threat.ends=math.max(threat.ends,from+time+(c.effectWindow or .15))
    end
    if extent then threat.extentSource,threat.extentValue,threat.extentInput=extentSource,extentValue,extentInput end
    if self.clip and threat.collide then threat=self.clip(self,threat,now)end
    if not c.rays and threat.ends<now then reject('cast_already_expired');return end
    if not c.rays then threat.damage=self:Damage(owner,definition)end
    if self.cancellationGapUntil and now<=self.cancellationGapUntil then
        self.threats.overflow=true
        self.threats.overflowUntil=math.max(self.threats.overflowUntil or 0,threat.ends)
        reject('cast_cancellation_history_incomplete');return
    end
    if not c.rays and not previous and not self:CastCapacity(1,threat.ends)then
        reject('cast_history_capacity');return
    end
    if c.rays then return self:ObserveFan(threat,c,owner,start,launch,key,reject,spell.placementPos or spell.endPos,definition)end
    local prior,priorID,correlationReason=self:MatchObservedCast(owner,c,origin,destination,start,launch)
    if correlationReason and c.nativeCastGeometry==true then
        geometryRejected(self,previous,reject,correlationReason,c,ownerID,key,start,finish,now);return
    end
    if prior then
        if previous then
            -- A late native correction can match a missile first seen on the
            -- corrected ray. Merge metadata before removing the obsolete cast.
            local row=self.threats:Snapshot(priorID)
            if not row then geometryRejected(self,previous,reject,'cast_revision_missile_missing',c,ownerID,key,start,finish,now);return end
            row.damageID=previous.damageID;row.instanceID=previous.damageID;row.stageID=previous.damageID
            row.observedAt=math.min(previous.observedAt,prior.observedAt)
            row.contourOrigin=G.copy(origin)
            if not self.threats:Observe(row)then geometryRejected(self,previous,reject,'cast_revision_merge_rejected',c,ownerID,key,start,finish,now);return end
            self.threats:Remove(id)
            prior.damageID=row.damageID;prior.instanceID=row.instanceID
            prior.observedAt=row.observedAt;prior.contourOrigin=G.copy(origin)
            if self.onThreat then self.onThreat(row)end
        end
        prior.castLinked=true;self.lastCast[ownerID]=key
        self.casts[id]={owner=ownerID,alias=c.alias,missile=c.missile,missiles=c.missiles,
            origin=origin,destination=destination,nativeDestination=nativeDestination,observedAt=prior.observedAt,
            starts=start,launch=launch,ends=threat.ends,damageID=prior.damageID,linked=true}
        return
    end
    if self.threats:Observe(threat)then
        if self.onThreat then self.onThreat(threat)end
        local anchor=definition.anchored
        if anchor and anchor.unit~='hit'then
            -- The area follows a unit or object (evade.anchors); an unknown anchor removes it.
            self.anchored=self.anchored or Anchors.new(self.threats)
            local tracked,why=self.anchored:Cast(self,threat,owner,spell,anchor,now)
            if not tracked and not self.threats.byID[id]then reject(why or 'anchor_unresolved');self.lastCast[ownerID]=key;return end
        elseif threat.shape=='missile'then self:TrackFlight(threat,definition.impact,anchor,now)end
        if c.detonation then self:WatchDetonation(id,owner,c.detonation)end
        if c.extras then Extras.Publish(self,threat,c,origin,destination,launch,now)end
        if c.follow then self.auras=self.auras or require('evade.auras').new(self.threats);self.auras:Follow(id,owner,c.follow)end
        self.lastCast[ownerID]=key
        self.casts[id]={owner=ownerID,alias=c.alias,missile=c.missile,missiles=c.missiles,origin=origin,destination=destination,
            nativeDestination=nativeDestination,observedAt=threat.observedAt,
            starts=start,launch=launch,ends=threat.ends,damageID=id,linked=false}
    elseif previous then geometryRejected(self,previous,reject,'cast_revision_rejected',c,ownerID,key,start,finish,now)end
end
-- A published straight flight with an impact area and/or a hit anchor (evade.impacts,
-- evade.anchors). An invalid spec publishes nothing; the flight itself stands.
function O:TrackFlight(row,impact,anchor,now)
    if anchor and anchor.unit~='hit'then anchor=nil end
    if not impact and not anchor then return end
    if impact and not Impacts.Valid(impact)then impact=nil end
    if anchor and not Anchors.Valid(anchor)then anchor=nil end
    if not impact and not anchor then return end
    self.impacts=self.impacts or Impacts.new(self.threats)
    if anchor then self.anchored=self.anchored or Anchors.new(self.threats)end
    self.impacts:Track(self,row,impact,anchor,now)
end
local function sameMissileModel(a,b)
    return a.radius==b.radius and a.speed==b.speed and a.range==b.range
        and a.projectTargetToCastRange==b.projectTargetToCastRange
        and a.acceleration==b.acceleration and a.minSpeed==b.minSpeed and a.maxSpeed==b.maxSpeed and a.speedUncertain==b.speedUncertain
        and a.castAlias==b.castAlias and a.effectGroup==b.effectGroup
        and a.cc==b.cc and a.ccUnknown==b.ccUnknown and a.ccHard==b.ccHard and a.parryable==b.parryable
        and a.blockable==b.blockable and (a.castAlias~=nil or a.formula==b.formula)
end
-- `mName` is this scan's object name; d.name is read at most once, only when needed.
local function missileDefinition(set,mName,d)
    -- Known projectile stages remain canonical even when their geometry is not
    -- supported. A return or visual cannot borrow a straight outbound model.
    local exact;local dName,dRead
    for index=1,2 do
        local name=mName
        if index==2 then dName=d.name;dRead=true;name=dName end
        if type(name)=='string'then
            local direct=set[name]or set.__lower and set.__lower[name:lower()]
            if direct and (direct.exclusion or direct.threatRole=='utility')then return nil,'excluded_missile_component'end
            if direct and direct.missileRecord and not(direct.eligible and direct.walkThreat)then
                return nil,'unsupported_exact_missile_stage'
            end
            if direct and direct.eligible and direct.walkThreat then
                if exact and not sameMissileModel(exact,direct)then return nil,'conflicting_exact_missile_stages'end
                exact=exact or direct
            end
        end
    end
    if exact then return exact end
    local chosen
    local aliasesByName=indexMissileAliases(set)
    for index=1,2 do
        local name=mName
        if index==2 then
            if not dRead then dName=d.name;dRead=true end
            name=dName
        end
        local aliases=type(name)=='string'and aliasesByName[name:lower()]
        for _,alias in ipairs(aliases or {})do
            local row=set[alias]
            if not row or not row.eligible or not row.walkThreat then return nil,'unsupported_shared_missile_alias'end
            if chosen and not sameMissileModel(chosen,row)then return nil,'ambiguous_missile_stage'end
            chosen=chosen or row
        end
    end
    return chosen
end
-- Unknown hostile projectile: untargeted, native speed and width in a plausible
-- skillshot band, not a known transport/visual of a modelled cast. It is drawn,
-- reported once and avoided by walking; with unknown damage and control it never
-- spends a defensive resource. Bounded per scan.
O.unknownMax=8;O.unknownSpeedMin,O.unknownSpeedMax=400,5000;O.unknownWidthMin,O.unknownWidthMax=30,400;O.unknownReach=2500
function O:ObserveUnknown(owner,ownerView,set,m,d,name,id,now)
    if d.target~=0 or m.valid==false or type(name)~='string'then return false end
    local speed,width=d.speed,d.width
    if not G.finite(speed)or speed<O.unknownSpeedMin or speed>O.unknownSpeedMax
        or not G.finite(width)or width<O.unknownWidthMin or width>O.unknownWidthMax then return false end
    local lower=name:lower()
    if lower:find('attack',1,true)then return false end
    local record=set and(set[name]or set.__lower and set.__lower[lower])
    if record and(record.cast or record.castAlias or record.exclusion or record.returnTracking or record.transportOf
        or record.threatRole=='utility'or record.threatRole=='non_hostile_component')then return false end
    local pos,finish=m.pos,d.endPos
    if not G.point(pos)or not G.point(finish)then return false end
    local hero=self.g.myHero.pos
    if not G.point(hero)or G.dist(pos,hero)>O.unknownReach then return false end
    local distance=G.dist(pos,finish);if distance<1 then return false end
    if self.unknownScan~=self.scanID then self.unknownScan=self.scanID;self.unknownUsed=0 end
    if self.unknownUsed>=O.unknownMax then return false end
    local ownerID=ownerView.networkID or ownerView.handle
    -- A modelled cast of this caster in flight already owns its transport and visuals.
    for _,c in pairs(self.casts)do
        if c.owner==ownerID and not c.cancelled and now<=c.ends and now-c.starts<=1.5 then return false end
    end
    local definition=set and set.UnknownProjectile
    if definition and not self:Allowed(owner,definition)then return false end
    self.unknownUsed=self.unknownUsed+1
    local previous=self.seen[id];local at=G.copy(pos)
    local observedAt=previous and previous.generic and previous.observedAt or now
    self.seen[id]={generic=true,owner=d.owner,alias='unknown:'..name,at=now,pos=at,observedAt=observedAt}
    local threat={id=id,instanceID=id,stageID=id,damageID=id,casterID=d.owner,profile=definition and definition.profile or 'normal',
        evidence='observed',abilityName='UnknownProjectile',nativeAlias=name,champion=ownerView.charName,
        shape='missile',origin=at,b=G.copy(finish),radius=width,speed=speed,starts=now,launch=now,ends=now+distance/speed,
        observedAt=observedAt,positionObservedAt=now,unknownProjectile=true,tier=2,ccUnknown=true,blockable=true,
        untargetableBlockable=true,widthSource='host_only',speedSource='host_only',endpointSource='host_endpos'}
    local accepted=self.threats:Observe(threat)
    if accepted and not(previous and previous.generic)then
        self.unmodeled=self.unmodeled or {};self.unmodeled[ownerView.charName..':'..name]=true;self.unmodeledDirty=true
        if self.onThreat then self.onThreat(threat)end
    end
    return accepted~=nil
end
function O:MissileDefinition(set,m,d)
    if not set then return end
    return missileDefinition(set,m.name,d)
end

function O:FindCorrelation(owner,definition,d,now,pos)
if not next(self.casts)then return end
if not G.point(pos)or not G.point(d.startPos)or not G.point(d.endPos)then return nil,nil,'missing_correlation_position'end
local dx,dz=G.direction(d.startPos,d.endPos)
local px,pz=pos.x-d.startPos.x,pos.z-d.startPos.z
local progress=px*dx+pz*dz
if progress<0 or math.abs(px*dz-pz*dx)>20 then return nil,nil,'off_ray_correlation'end
-- A speed-step phase model times its flight from the start with its record (stepBase).
local earliest,latest=G.travelTimeBounds(definition.stepBase or definition,progress)
local chosen,spatialCandidate
for id,c in pairs(self.casts)do
local matches=c.missile==definition.name
if not matches and c.missiles then for _,name in ipairs(c.missiles)do if name==definition.name then matches=true;break end end end
if not c.cancelled and not c.linked and G.point(c.origin)and G.point(c.destination)and c.owner==(owner.networkID or owner.handle)and matches
and now>=c.starts and now<=c.ends+.25 and G.finite(c.launch)then
local distance=G.dist(c.origin,d.startPos)
local ax,az=G.direction(c.origin,c.destination)
if distance<=150 and ax*dx+az*dz>(c.matchDot or .98)then
spatialCandidate=true
if c.launch>=now-latest-.1 and c.launch<=now-earliest+.1 then
-- Close origins alone cannot distinguish repeated or simultaneous casts.
-- Preserve ambiguous observations rather than borrow another cast's identity.
if chosen then return nil,nil,'ambiguous_cast_epoch'end
chosen=id
end
end
end
end
    if chosen then return chosen,self.casts[chosen] end
    if spatialCandidate then return nil,nil,'cast_epoch_mismatch'end
end
function O:Correlate(owner,definition,d,now,pos)
    local id,c,why=self:FindCorrelation(owner,definition,d,now,pos)
    if id then c.linked=true;self.threats:Remove(id);return c.damageID,c end
    return nil,nil,why
end
function O:SharedEffect(definition,owner,d,pos,now)
    if not definition.effectGroup then return end
    -- A profile groups components, not every nearby projectile from this caster.
    -- Match a bounded constant-flight epoch and admit each canonical component
    -- once. Shared membership survives one sibling disappearing from enumeration.
    if definition.acceleration or definition.speedUncertain or not G.point(d.startPos)
      or not G.point(d.endPos)or not G.point(pos)or not G.finite(now)
      or not G.finite(definition.speed)or definition.speed<=0 then return end
    local dx,dz=G.direction(d.startPos,d.endPos)
    local px,pz=pos.x-d.startPos.x,pos.z-d.startPos.z
    local progress=px*dx+pz*dz
    if progress<0 or math.abs(px*dz-pz*dx)>20 then return end
    local launch=now-progress/definition.speed
    local chosen;local scanned=0
    for _,previous in pairs(self.seen)do
        scanned=scanned+1;if scanned>self.maxMissiles then return nil,nil,'effect_group_budget'end
        local members=previous.effectMembers
        if previous.owner==owner and previous.group==definition.effectGroup
          and members and members.constantFlight
          and members.profile==definition.profile and members.source==definition.source
          and previous.confirmed and previous.damageID and previous.instanceID
          and members.count<16 and not members.aliases[definition.name]
          and now>=members.firstAt and now-members.firstAt<=.15
          and now>=previous.at and now-previous.at<=.15
          and G.point(previous.start)and G.point(previous.pos)and G.point(previous.endpoint)
          and G.finite(previous.speed)and previous.speed>0
          and G.dist(previous.start,d.startPos)<=20
          and G.dist(previous.pos,pos)<100
          and G.dist(previous.hostEndpoint or previous.endpoint,d.endPos)<=20 then
            local bx,bz=G.direction(previous.start,previous.endpoint)
            local qx,qz=previous.pos.x-previous.start.x,previous.pos.z-previous.start.z
            local distance=qx*bx+qz*bz
            if distance>=0 and math.abs(qx*bz-qz*bx)<=20 and dx*bx+dz*bz>.999
              and math.abs(launch-(previous.at-distance/previous.speed))<=.1 then
                if chosen and(chosen.damageID~=previous.damageID or chosen.instanceID~=previous.instanceID)then
                    return nil,nil,'ambiguous_effect_group'
                end
                chosen=previous
            end
        end
    end
    if chosen then return chosen.damageID,chosen end
end
-- A missile wrapper need not duplicate its attributable champion's team.
-- Known contradictory teams remain rejected; unknown ownership never borrows one.
local function missileHostile(object,owner,myTeam,team,teamRead)
    if owner==false then return nil,'owner_identity_ambiguous'end
    if owner and owner.valid==false then return false,'owner_invalid'end
    -- The scan may already hold this pass's object.team sample (prefilter).
    if not teamRead then team=object.team end
    if team~=nil and team~=0 and not G.finite(team)then return false,'invalid_team'end
    if G.finite(team)and team>0 then
        if owner and G.finite(owner.team)and owner.team~=team then return false,'team_conflict'end
        if team==myTeam()or team>=300 then return false,'friendly_or_neutral'end
        return true,'object_team'
    end
    if team~=nil and team~=0 then return false,'invalid_team'end
    if not owner or not G.finite(owner.team)or owner.team<=0 then return false,'team_unattributed'end
    if owner.team==myTeam()or owner.team>=300 then return false,'friendly_or_neutral'end
    return true,'owner_team'
end
function O:MissileHostile(object,owner)
    local g=self.g
    return missileHostile(object,owner,function()return g.myHero.team end)
end
-- Stable host identity fields of a roster hero, read once per scan (a missile
-- pass otherwise re-reads them for every projectile that hero owns). Views are
-- reset with the roster and never outlive the wrapper they describe.
local function heroView(self,hero)
    local views=self.heroViews
    if not views then views={};self.heroViews=views end
    local view=views[hero]
    if view and view.scan==self.scanID then return view end
    if not view then view={};views[hero]=view end
    view.scan=self.scanID;view.valid=hero.valid;view.team=hero.team
    view.networkID=hero.networkID;view.handle=hero.handle;view.charName=hero.charName
    return view
end
function O:IngressSample(reason,object,data,owner)
    local report=self.ingressReport;if not report then return end
    report.counts[reason]=(report.counts[reason]or 0)+1
    if report.sampleAttempts>=4 or report.sampled[reason]then return end
    report.sampled[reason]=true
    report.sampleAttempts=report.sampleAttempts+1
    local ok,sample=pcall(function()
        local pos=object.pos
        return {reason=reason,objectName=object.name,dataName=data and data.name,
        missileID=object.networkID,missileHandle=object.handle,team=object.team,valid=object.valid,dead=object.dead,
        owner=data and data.owner,ownerID=owner and owner.networkID,ownerHandle=owner and owner.handle,
        ownerTeam=owner and owner.team,champion=owner and owner.charName,target=data and data.target,
        speed=data and data.speed,width=data and data.width,x=pos and pos.x,z=pos and pos.z}
    end)
    if ok then report.samples[#report.samples+1]=sample
    else report.sampleFailures=report.sampleFailures+1 end
end
function O:Tick(now)
    local previous=self.threats.observationIncomplete==true
    self.threats.observationIncomplete=true;self.hostCalls=0
    local ran,ok,why
    if G.finite(now)then ran,ok,why=pcall(self.Scan,self,now)
    else ran,ok,why=true,false,'invalid_observation_time'end
    self.damageScope=nil
    local ingress=self.ingressReport;self.ingressReport=nil
    if ingress and self.onMissileIngress then
        ingress.complete=ran and ok==true;ingress.reason=why
        pcall(self.onMissileIngress,ingress)
    end
    if not ran then self.lastError=type(ok)=='string'and ok or 'non_string_observation_error';ok=false;why='observation_failed'
    else self.lastError=nil end
    local incomplete=ok~=true
    self.threats.observationIncomplete=incomplete
    if incomplete and why~='trajectory_unmodeled'and why~='cast_geometry_unmodeled'then self.nextRoster=0 end
    if previous~=incomplete then self.threats.revision=self.threats.revision+1 end
    return ok==true,why
end
function O:Scan(now)
    local shadow=self.shadow
    if shadow then
        local ran,active=pcall(shadow.Begin,shadow,self,now)
        if not ran or active~=true then shadow=nil end
    end
    self.damageScope={};self.scanID=(self.scanID or 0)+1
    local rosterOK,rosterReason=self:Roster(now,shadow)
    if rosterOK==false then return false,rosterReason end
    -- Phases are methods so development profiling can attribute observer cost.
    self:ScanCasts(now,shadow)
    self.landings:Prune(now)
    local ok,why,trajectoryUnmodeled=self:ScanMissiles(now,shadow)
    if not ok then return false,why end
    self:ScanAttached(now)
    local present,stamp=self.present,self.scanID
    local impacts=self.impacts
    for id in pairs(self.seen)do if present[id]~=stamp then
        -- A projectile seen to disappear has stopped: its impact collapses there (evade.impacts).
        if impacts then impacts:Stopped(self,id,now)end
        self.threats:Remove(id);self.seen[id]=nil
    end end
    if self.flightModels then for id in pairs(self.flightModels)do if present[id]~=stamp then self.flightModels[id]=nil end end end
    if self.extentModels then for id in pairs(self.extentModels)do if present[id]~=stamp then self.extentModels[id]=nil end end end
    -- Only a completed native scan retires these diagnostic identities. The
    -- next sample is still raw evidence, not proof of a new cast or impact.
    if self.excluded then for key,row in pairs(self.excluded)do
        if type(row)=='table'and present[row.nativeKey]~=stamp then
            self.excluded[key]=nil;self.excludedCount=self.excludedCount-1
        end
    end end
    for id,at in pairs(present)do if at~=stamp then present[id]=nil end end
    -- Retire absent returns/segments and publish predictions after the complete pass.
    if self.returns then self.returns:Finish(self,now)end
    -- Impact areas from this pass's flights, then areas that follow their anchors.
    if self.impacts then self.impacts:Scan(self,now)end
    if self.anchored then self.anchored:Scan(self,now)end
    self.damageScope=nil;self.threats:Expire(now)
    if self.castGeometryUnmodeled then
        self.castGeometryUnmodeled=false
        for _,cast in pairs(self.casts)do
            if cast.geometryUnknown and not cast.linked and now<=cast.ends then self.castGeometryUnmodeled=true;break end
        end
    end
    if trajectoryUnmodeled then return false,'trajectory_unmodeled'end
    if self.castGeometryUnmodeled then return false,'cast_geometry_unmodeled'end
    return true
end
-- A recastable ground zone (own profile `detonation`) ends at its observed
-- recast: the owner's slot first shows the armed recast name, then the primary
-- name again. Only that positive transition shortens the zone; unreadable,
-- fogged or never-armed samples keep the own timeout. One slot read per live zone.
function O:WatchDetonation(id,owner,d)
    self.detonations=self.detonations or {}
    if self.detonations[id]or (self.detonationCount or 0)>=16 then return end
    if type(d.slot)~='number'or type(d.armed)~='string'or type(d.primary)~='string'then return end
    self.detonations[id]={owner=owner,slot=d.slot,armed=d.armed:lower(),primary=d.primary:lower(),margin=G.finite(d.margin)and d.margin or .15}
    self.detonationCount=(self.detonationCount or 0)+1
end
function O:Detonations(now)
    for id,w in pairs(self.detonations)do
        local row=self.threats.byID[id];local done=not row or row.ends<now
        if not done and type(w.owner.GetSpellData)=='function'then
            self.hostCalls=(self.hostCalls or 0)+1
            local ok,data=pcall(w.owner.GetSpellData,w.owner,w.slot)
            local name=ok and data and type(data.name)=='string'and data.name:lower()
            if name==w.armed then w.armedAt=w.armedAt or now
            elseif name==w.primary and w.armedAt then
                done=true
                local ends=math.max(now,row.starts)+w.margin
                if ends<row.ends then
                    local event=self.threats:Snapshot(id)
                    event.ends=ends;event.detonationObservedAt=now;event.timingScope='observed_recast_detonation'
                    self.threats:Observe(event)
                end
            end
        end
        if done then self.detonations[id]=nil;self.detonationCount=self.detonationCount-1 end
    end
end
-- Caster-attached zones, placed objects and marks on the player (own modules,
-- each sampled at its own period; skipped entirely without a champion that has such rows).
function O:ScanAttached(now)
    local features=self.features
    if features then
        if features.aura then
            self.auras=self.auras or require('evade.auras').new(self.threats)
        end
        if features.hazard then
            self.hazards=self.hazards or require('evade.hazards').new(self.threats);self.hazards:Scan(self,now)
        end
        if features.mark then
            self.marks=self.marks or require('evade.marks').new(self.threats);self.marks:Scan(self,now)
        end
    end
    if self.auras then self.auras:Scan(self,now)end
end
function O:ScanCasts(now,shadow)
    for id,c in pairs(self.casts)do if now>c.ends+.5 then self.casts[id]=nil end end
    if self.detonations then self:Detonations(now)end
    if self.cancellationGapUntil and now>self.cancellationGapUntil then self.cancellationGapUntil=nil end
    if self.channels then self.channels:Expire(now)end
    if self.fanEpochs then
        for id,expires in pairs(self.fanEpochs)do
            if now>expires then self.fanEpochs[id]=nil;self.fanEpochCount=self.fanEpochCount-1 end
        end
    end
    for _,owner in ipairs(self.roster)do
        local set=self.loaded[owner.charName]
        if owner.valid~=false and owner.visible~=false and(not owner.dead or set and set.__postDeath)then
            self:ObserveCast(owner,owner.activeSpell,now,set or false)
            -- Move speed samples for a stat-scaled row of this caster (evade.extents).
            local index=set and set.__chargeIndex
            if index and index.stat then Extents.Sample(self,owner,owner.networkID or owner.handle,now)end
        elseif owner.dead then
            if self.channels then self.channels:Reconcile(owner,owner.activeSpell,now)end
            if self.locked and self.locked.attackCount>0 then self.locked:Reconcile(self,owner,nil,now)end
        end
    end
    if shadow then shadowCall(shadow,'Casts',now)end
end
-- FixedTimeMovement (`flightTime`): the flight lasts that long whatever its
-- length, so its constant speed is this projectile's own length over the time.
-- The catalogue speed is only nominal (range / flightTime). One model per
-- projectile, measured at first sight and kept while its native end stays put
-- (a host startPos that follows the caster does not re-time it); pruned with the scan.
local function flightTimeModel(self,id,definition,d,charged)
    local start,finish=d.startPos,d.endPos
    if not G.point(start)or not G.point(finish)then return nil,'flight_time_geometry_missing'end
    local time=definition.flightTime
    if not G.finite(time)or time<=0 or time>10 then return nil,'invalid_flight_time'end
    local models=self.flightModels;if not models then models={};self.flightModels=models end
    local kept=models[id]
    if kept and kept.base==definition and math.abs(kept.ex-finish.x)<=20 and math.abs(kept.ez-finish.z)<=20 then
        return kept.model
    end
    -- A charged flight (`charge`) flies its charged reach in the same fixed time.
    local length=charged or definition.projectTargetToCastRange and G.finite(definition.range)and definition.range or G.dist(start,finish)
    if length<1 then return nil,'flight_time_geometry_missing'end
    local model=setmetatable({speed=length/time},{__index=definition})
    models[id]={base=definition,ex=finish.x,ez=finish.z,model=model}
    return model
end
-- Charged reach of an observed projectile (`charge`, evade.extents): fixed at its first
-- sighting (the release, or later: only longer) and kept for the projectile's lifetime.
function O:ChargedRange(id,owner,spec,now)
    local kept=self.extentModels and self.extentModels[id]
    if kept and kept.spec==spec then return kept.value,kept.source,kept.input end
    if not Extents.Valid(spec)or spec.key~='range'then return end
    local ownerID=owner.networkID or owner.handle
    local value,source,input=Extents.Value(self,owner,ownerID,spec,now,now,spec.max)
    if not G.finite(value)or value<=0 then return end
    self.extentModels=self.extentModels or {}
    self.extentModels[id]={spec=spec,value=value,source=source,input=input}
    return value,source,input
end
-- Speed step (`speedStep`) of an observed projectile: the speed of its current phase, by its
-- progress from its native start; a missing start takes the later speed (earlier arrival).
-- stepBase keeps the record for timing the whole flight from its start (cast correlation).
local function stepModel(definition,d,pos)
    local step=definition.speedStep
    local progress=G.point(d.startPos)and G.point(pos)and G.dist(d.startPos,pos)
    if progress and progress<step.at then return setmetatable({stepAfter=step.at,stepBase=definition},{__index=definition})end
    return setmetatable({speed=step.speed,speedStep=false,stepBase=definition},{__index=definition})
end
-- Curved projectile (`curve`): the host reports its start, end and current
-- position, never the curve. It is the static corridor of its whole flight
-- (G.curveCorridor) from the native start to the native end, anchored at the
-- correlated cast's launch or the first sighting, so later samples do not move it.
-- A sample outside the corridor is reported; the corridor is kept.
function O:ObserveCurved(owner,set,definition,m,d,id,now)
    local start,finish,pos=d.startPos,d.endPos,m.pos
    if not G.point(start)or not G.point(finish)or not G.point(pos)then
        self.threats:Remove(id);self.seen[id]=nil
        self:Reject('missile_rejected',id,'curve_geometry_missing',owner,d,now,definition,pos,nil,m);return
    end
    local ownerID=owner.networkID or owner.handle
    local previous=self.seen[id]
    if previous and(not previous.curve or previous.owner~=d.owner or previous.alias~=definition.name
        or G.dist(previous.start,start)>20 or G.dist(previous.hostEndpoint,finish)>20)then
        self.threats:Remove(id);previous=nil
    end
    local launch,damageID,observedAt,instanceID=now,id,now,id..':'..tostring(now)
    if previous then launch,damageID,observedAt,instanceID=previous.launch,previous.damageID,previous.observedAt,previous.instanceID
    else
        -- The modelled cast this projectile carries, when exactly one matches.
        local chosen,chosenID
        for key,c in pairs(self.casts)do
            local matches=c.missile==definition.name
            if not matches and c.missiles then for _,name in ipairs(c.missiles)do if name==definition.name then matches=true;break end end end
            if matches and c.owner==ownerID and not c.cancelled and not c.linked and G.finite(c.launch)
                and now>=c.starts and now<=c.ends+.25 and G.point(c.origin)and G.dist(c.origin,start)<=400 then
                if chosen then chosen=false;break end
                chosen,chosenID=c,key
            end
        end
        if chosen then
            chosen.linked=true;self.threats:Remove(chosenID)
            launch,damageID,observedAt=math.min(now,chosen.launch),chosen.damageID,chosen.observedAt or now
            instanceID=chosen.damageID
        end
    end
    local length=G.dist(start,finish)
    local time=definition.flightTime
    if time==nil and G.finite(definition.speed)and definition.speed>0 then
        time=length*(type(definition.curve)=='table'and definition.curve.stretch or 1)/definition.speed
    end
    if not G.finite(time)or time<=0 or time>10 or length<1 then
        self.threats:Remove(id);self.seen[id]=nil
        self:Reject('missile_rejected',id,'invalid_flight_time',owner,d,now,definition,pos,nil,m);return
    end
    local effects=set[definition.castAlias]or definition
    local threat={id=id,instanceID=instanceID,stageID=instanceID,damageID=damageID,casterID=d.owner,profile=definition.profile,
        evidence='observed',ability=definition.id,abilityName=definition.castAlias or definition.name,champion=owner.charName,
        source=definition.source,shape='missile',origin=G.copy(start),b=G.copy(finish),radius=definition.radius,
        observedAt=observedAt,starts=launch,ends=launch+time,blockable=definition.blockable~=false,endpointSource='host_endpos',
        damage=self:Damage(owner,effects),cc=effects.cc,ccUnknown=effects.ccUnknown,ccHard=effects.ccHard,parryable=effects.parryable,
        untargetableBlockable=effects.untargetableBlockable~=false,tier=effects.tier or definition.tier,
        windwall=effects.windwall or definition.windwall,zones=effects.zones or definition.zones,flightTime=definition.flightTime,
        displace=effects.displace or definition.displace,
        nativeAlias=definition.name}
    if effects.cast and effects.cast.blockable==false then threat.blockable=false end
    local ok,why=G.curveCorridor(threat,definition.curve,launch,launch+time)
    if not ok then
        self.threats:Remove(id);self.seen[id]=nil
        self:Reject('missile_rejected',id,why,owner,d,now,definition,pos,nil,m);return
    end
    self.seen[id]={curve=true,owner=d.owner,alias=definition.name,at=now,pos=G.copy(pos),start=G.copy(start),hostEndpoint=G.copy(finish),
        launch=launch,damageID=damageID,observedAt=observedAt,instanceID=instanceID}
    if G.distance(threat,pos,now)>1 then self:Reject('missile_uncertain',id,'curve_outside_envelope',owner,d,now,definition,pos,nil,m)end
    local accepted=self.threats:Observe(threat)
    if accepted and not previous and self.onThreat then self.onThreat(threat)end
end
function O:ScanMissiles(now,shadow)
    local game=self.g.Game
    if type(game.MissileCount)~='function'or type(game.Missile)~='function'then self.damageScope=nil;return false,'missile_api_missing'end
    local shared=self.g.SDK and self.g.SDK.Projectiles
    local snapshot,count
    if shared then
        local why,calls;snapshot,why,calls=shared:Snapshot(self.maxMissiles)
        self.hostCalls=self.hostCalls+(calls or 0)
        if not snapshot then
            if why=='missile_scan_budget'then self.threats.overflow=true;self.scanOverflow=true end
            self.damageScope=nil;return false,why
        end
        count=snapshot.count
    else self.hostCalls=self.hostCalls+1;count=game.MissileCount()end
    if not G.finite(count)or count<0 or count~=math.floor(count)then return false,'missile_snapshot_invalid'end
    self.missileCount=count
    if count>self.maxMissiles then self.threats.overflow=true;self.scanOverflow=true;self.damageScope=nil;return false,'missile_scan_budget'end
    if self.scanOverflow then
        self.scanOverflow=nil;self.threats.overflow=self.threats.overflowUntil~=nil and now<=self.threats.overflowUntil
    end
    if self.onMissileIngress and self.diagnostics and self.diagnostics()and now>=(self.nextIngress or 0)then
        self.nextIngress=now+2
        self.ingressReport={at=now,total=count,counts={},samples={},sampled={},sampleAttempts=0,sampleFailures=0}
    end
    -- Reused presence set: entries carry this scan's stamp; the completed scan prunes others.
    local present=self.present;if not present then present={};self.present=present end
    local stamp=self.scanID;local trajectoryUnmodeled=false
    local readMyTeam=self.readMyTeam
    if not readMyTeam then
        readMyTeam=function()
            if self.myTeamScan~=self.scanID then self.myTeamScan=self.scanID;self.myTeam=self.g.myHero.team end
            return self.myTeam
        end
        self.readMyTeam=readMyTeam
    end
    for id,entry in pairs(self.rejections or {})do if now-(entry.seenAt or entry.at)>2 or now<entry.at then self.rejections[id]=nil;self.rejectionCount=self.rejectionCount-1 end end
    -- A positive own-team or neutral object team is never hostile, whatever its
    -- missileData says (team conflicts are rejected too). Live ingress: 58% of
    -- enumerated missiles. Skip their composite missileData/dead reads unless a
    -- consumer of non-hostile objects is active this scan (development ally shadow,
    -- the 2-s ingress sample) or the owner index is ambiguous, which must still
    -- fail the scan. Outputs are identical; only unused reads are avoided.
    local prefilter=not shadow and not self.ingressReport and self.heroIndexClean==true
    for i=1,count do
        local m
        if snapshot then m=snapshot.objects[i]
        else self.hostCalls=self.hostCalls+1;m=game.Missile(i)end
        if not m then return false,'missile_read_failed'end
        local preTeam,teamRead,friendly
        if prefilter then
            preTeam=m.team;teamRead=true
            friendly=G.finite(preTeam)and preTeam>0 and(preTeam==readMyTeam()or preTeam>=300)
        end
        if not friendly then
        -- Each native field is read once per missile per scan (host reads dominate
        -- this pass); the values are the same within one synchronous scan.
        local d=m and m.missileData
        local owner,ownerView,dOwner,mValid,nativeID,idKey
        local hostile,teamReason
        if not d then teamReason='missing_data'
        elseif m.dead==true then teamReason='dead_object'
        else
            dOwner=d.owner;owner=self.heroes[dOwner]
            -- false marks an ambiguous native owner namespace; keep it distinct from nil.
            if owner then ownerView=heroView(self,owner)elseif owner==false then ownerView=false end
            hostile,teamReason=missileHostile(m,ownerView,readMyTeam,preTeam,teamRead)
            mValid=m.valid
            if mValid==false and hostile then
                teamReason='invalid_object'
                nativeID=m.networkID or m.handle;idKey='missile:'..tostring(nativeID)
                local prior=self.seen[idKey]
                if prior and prior.owner==dOwner and prior.wrapperState~=false then
                    hostile=false -- An actual validity transition still retires its track.
                end
            end
        end
        if self.ingressReport then self:IngressSample(teamReason,m,d,owner~=false and owner or nil)end
        if hostile==nil and teamReason=='owner_identity_ambiguous'then return false,teamReason end
        if shadow and d and not hostile and teamReason~='dead_object'then
            local ally=shadow.heroes[dOwner]
            if ally then shadowCall(shadow,'Missile',self,ally,m,d,now)end
        end
        if hostile then
            -- A cached native wrapper can be recycled between roster refreshes.
            if owner and dOwner~=ownerView.networkID and dOwner~=ownerView.handle then
                return false,'owner_identity_changed'
            end
            -- Only a roster hero's projectile consults its name (catalog, returns,
            -- diagnostics); a diagnostic row for another owner reads it lazily.
            local mName;if owner then mName=m.name end
            local set=owner and self.loaded[ownerView.charName]
            -- Own-profile caster returns and blade segments have their own models. A
            -- consumed object skips the straight-flight path; outbound/blade anchors do not.
            local modeled=set and self.returns and self.returns:Missile(self,owner,set,m,d,now)
            if not modeled and set then modeled=self.landings:Missile(self,owner,set,m,d,mName,now)end
            local definition,definitionReason
            if not modeled and set then definition,definitionReason=missileDefinition(set,mName,d)end
            local id
            if not modeled then
                if nativeID==nil then nativeID=m.networkID or m.handle end
                id=nativeID
            end
            if id then
                if not idKey then idKey='missile:'..tostring(id)end
                id=idKey;present[id]=stamp
                -- A projectile locked onto the player becomes a targeted row (evade.locked).
                local locked=d.target~=0 and self.locked and self.locked:Missile(self,owner,ownerView,m,d,mName,id,now)
                local flightReason
                local charged,chargeSource,chargeInput
                local chargeSpec=not locked and definition and definition.eligible and definition.charge
                if chargeSpec then charged,chargeSource,chargeInput=self:ChargedRange(id,owner,chargeSpec,now)end
                if not locked and definition and definition.eligible and definition.flightTime~=nil and not definition.curve then
                    definition,flightReason=flightTimeModel(self,id,definition,d,charged)
                end
                if not locked and not flightReason and definition and definition.eligible and definition.speedStep
                    and definition.flightTime==nil and not definition.curve and not definition.acceleration then
                    definition=stepModel(definition,d,m.pos)
                end
                if locked then
                elseif flightReason then
                    self.threats:Remove(id);self.seen[id]=nil
                    self:Reject('missile_rejected',id,flightReason,owner,d,now,nil,m.pos,nil,m,mName)
                elseif definition and definition.curve and definition.eligible and self:Allowed(owner,definition)and d.target==0 then
                    self:ObserveCurved(owner,set,definition,m,d,id,now)
                elseif definition and definition.eligible and self:Allowed(owner,definition)and d.target==0 and G.point(m.pos)and G.point(d.endPos)
                    and (G.finite(definition.speed)and definition.speed>0)then
        -- Native fields belong to this synchronous observation only.
        local nativeSpeed=d.speed
        local previous=self.seen[id];local pos=G.copy(m.pos)
        -- Missile handles can be recycled without an intervening empty scan.
        -- Neither damage identity nor motion confirmation belongs to the new owner.
                    local movedStart=previous and previous.start and G.point(d.startPos)
    and G.dist(previous.start,d.startPos)>.001
                    local retainedFlight=false
                    if movedStart and previous.owner==dOwner and previous.alias==definition.name
                      and (previous.confirmed or previous.motionUnknown)and G.point(previous.hostEndpoint)
                      and G.dist(previous.hostEndpoint,d.endPos)<=20 then
                      -- A mutable caster-origin field cannot reset a projectile
                      -- whose observed displacement still matches the same flight.
                      local anchor=previous.motionPos or previous.pos
                      local elapsed=now-(previous.motionAt or previous.at)
                      local lower,expected=displacementBounds(definition,previous.motionSpeed or previous.speed,elapsed,G.dist(anchor,previous.endpoint))
                      local distance=G.dist(anchor,pos)
                      retainedFlight=elapsed>=0 and (distance<=.001 or withinBounds(distance,lower,expected,30,.3))
                        and G.segment(pos,anchor,previous.endpoint)<=20
                    end
                    if previous and (previous.owner~=dOwner or previous.alias~=definition.name
                        or movedStart and G.dist(previous.start,d.startPos)>20 and not retainedFlight)then
            self.threats:Remove(id);previous=nil
        end
                    -- A recycled native ID can repeat the same owner, ray and position.
                    -- Expiry alone is insufficient: require a distinct attributable cast
                    -- whose launch agrees with this observation before replacing history.
                    local freshDamage,freshCast
                    if previous and G.finite(previous.flightEnd)and now>previous.flightEnd
                        and G.finite(nativeSpeed)and nativeSpeed>0
                        and math.abs(nativeSpeed-definition.speed)<=math.max(20,definition.speed*.1)
                        and (not G.finite(d.width)or d.width<=definition.radius*2+10)then
                        local key,c=self:FindCorrelation(owner,definition,d,now,pos)
                        if key and now>=c.launch and c.damageID~=previous.damageID and c.launch>previous.flightEnd then
                            c.linked=true;self.threats:Remove(key);self.threats:Remove(id)
                            freshDamage,freshCast=c.damageID,c;previous=nil;retainedFlight=false
                        end
                    end
                    local endpoint;local endpointSource='host_endpos'
                    local cast=definition.cast or set[definition.castAlias]and set[definition.castAlias].cast
                    -- Native endPos can be the cast's aimed point, not its maximum
                    -- flight endpoint. Use the already-supported full-range cast
                    -- model when its exact stage and observed origin are available.
                local projectedRange=charged or cast and cast.shape=='missile'and cast.range
                    or definition.projectTargetToCastRange and definition.range
                local observedLength=projectedRange and G.point(d.startPos)and G.dist(d.startPos,d.endPos)
                if retainedFlight then
                      endpoint=G.copy(previous.endpoint);endpointSource='retained_observed_flight'
                    elseif G.finite(projectedRange)and projectedRange>0
                    and observedLength and observedLength>1 then
                    local dx,dz=(d.endPos.x-d.startPos.x)/observedLength,(d.endPos.z-d.startPos.z)/observedLength
                    local px,pz=pos.x-d.startPos.x,pos.z-d.startPos.z
                    -- Some host startPos samples follow the caster rather than
                    -- the projectile. Extending that ray rotates a valid flight.
                    if math.abs(px*dz-pz*dx)<=20 and px*dx+pz*dz>=-20 then
                        endpoint={x=d.startPos.x+dx*projectedRange,y=d.startPos.y,z=d.startPos.z+dz*projectedRange}
                        endpointSource=charged and 'charged_range'or cast and cast.shape=='missile'and 'cast_profile_range'or 'missile_profile_range'
                    else endpointSource='host_endpos_start_off_ray' end
                    end
                    endpoint=endpoint or G.copy(d.endPos)
                    -- Match live owner/alias/metadata first. Subsequent unexpected motion invalidates
                    -- the fixed-trajectory model rather than silently fitting it.
                    local metadataSpeed=G.finite(nativeSpeed)and nativeSpeed>0 and math.abs(nativeSpeed-definition.speed)<=math.max(20,definition.speed*.1)
                    local speedConflict=false
                    local boundedSpeed=definition.minSpeed and definition.maxSpeed and not definition.acceleration
                    if boundedSpeed then
                        metadataSpeed=G.finite(nativeSpeed)and nativeSpeed>=definition.minSpeed and nativeSpeed<=definition.maxSpeed
                        speedConflict=G.finite(nativeSpeed)and nativeSpeed>0 and not metadataSpeed
                    end
                    local speed=metadataSpeed and nativeSpeed or definition.speed
                    if definition.acceleration and G.point(d.startPos)then
                        -- Retained flight uses its established launch origin. The host's
                        -- mutable caster field cannot change acceleration progress.
                        local launchOrigin=retainedFlight and previous.start or d.startPos
                        local progress=G.dist(launchOrigin,pos)
                        speed=math.max(definition.minSpeed,math.min(definition.maxSpeed,
                            math.sqrt(math.max(0,definition.speed^2+2*definition.acceleration*progress))))
                    end
                    local width=G.finite(d.width)and d.width>0 and d.width or nil
                    local confirmed=metadataSpeed or definition.acceleration~=nil and G.point(d.startPos)
                    local rejection=not confirmed and 'speed_waiting_for_motion'or nil
                    local speedOrigin=previous and previous.speedOrigin or pos
                    local speedAt=previous and previous.speedAt or now
                    local speedValidated=previous and previous.speedValidated
                    if not confirmed and not definition.acceleration and previous and now>speedAt then
                        local elapsed=now-speedAt;local lower,expected=displacementBounds(definition,definition.speed,elapsed)
                        local distance=G.dist(speedOrigin,pos)
                        if speedValidated or elapsed>=.04 and elapsed<=.25 and withinBounds(distance,lower,expected,8,.12)then
                            confirmed=true;speedValidated=true
                        elseif elapsed>.25 then speedOrigin=pos;speedAt=now end
                    end
                    local motionDiagnostic
                    -- Host position refreshes need not share the callback cadence.
                    -- Keep the last changed sample as the motion anchor, including
                    -- its time; unchanged callbacks must not postpone arrival.
                    local motionPos=previous and (previous.motionPos or previous.pos)or pos
                    local motionAt=previous and (previous.motionAt or previous.at)or now
                    local motionSpeed=previous and (previous.motionSpeed or previous.speed)or speed
                    local motionUnknown=false;local motionRejected=false
                    if previous and previous.owner==dOwner and previous.alias==definition.name and now>previous.at then
                      local elapsed=now-motionAt;local distance=G.dist(motionPos,pos)
                      local changed=distance>.001
                      -- Match the same endpoint-clamped bounds used by collision.
                      local lower,expected=displacementBounds(definition,motionSpeed,elapsed,G.dist(motionPos,previous.endpoint))
                      local off=G.segment(pos,motionPos,previous.endpoint)
                      local endpointShift=G.dist(previous.endpoint,endpoint)
                      local motion=(not changed or withinBounds(distance,lower,expected,30,.3))
                        and off<=20 and endpointShift<=20
                      -- This is a bounded observation tolerance, not a claim that
                      -- the host refreshes within 100 ms. Beyond it, retain the
                      -- observed flight corridor with unknown contact timing.
                      local stale=not changed and elapsed>=.1-1e-9 and G.dist(pos,endpoint)>20
                      if motion and stale and (previous.confirmed or previous.motionUnknown)then
                        confirmed=false;motionUnknown=true;rejection='position_stale'
                      elseif not motion or not changed and previous.motionRejected then
                        confirmed=false;speedValidated=false;speedOrigin=pos;speedAt=now;rejection='trajectory_mismatch'
                        -- A rejected time model does not erase an observed hostile body.
                        -- Keep a known corridor time-uncertain; an unexplained direction
                        -- change cannot certify any new route until motion is observed.
                        if previous.confirmed or previous.motionUnknown or previous.motionRejected then
                            motionRejected=true
                            if off<=20 and endpointShift<=20 and not previous.trajectoryUnmodeled then motionUnknown=true
                            else trajectoryUnmodeled=true end
                        end
                      end
                      if (motionUnknown or not motion)and self.diagnostics and self.diagnostics()then
                        motionDiagnostic={elapsed=elapsed,displacement=distance,expectedTravel=expected,expectedTravelMin=lower,
                          offRay=off,endpointShift=endpointShift,previousX=motionPos.x,previousZ=motionPos.z}
                      end
                      if changed then motionPos=pos;motionAt=now;motionSpeed=speed end
                    end
                    if speedConflict then
                        confirmed=false;motionUnknown=true;motionRejected=true;rejection='speed_bounds_mismatch'
                    end
                    local wrapperMotion=previous and previous.wrapperMotion or false
                    local wrapperOrigin=previous and previous.wrapperOrigin or pos
                    local wrapperAt=previous and previous.wrapperAt or now
                    if mValid==false then
                        -- A projectile from a caster in fog has no cast to see. First seen
                        -- near its own launch point, on its own ray and far from its end, it
                        -- is a fresh flight: waiting one more sample cost the 2026-10-27
                        -- Vayne game 47 of ~200 ms against Classic Graves' Buckshot from fog.
                        if not previous and not wrapperMotion and owner and owner.visible==false and G.point(d.startPos)
                            and G.dist(d.startPos,pos)<=400 and G.segment(pos,d.startPos,endpoint)<=20
                            and G.dist(pos,endpoint)>100 then wrapperMotion=true end
                        -- Enumeration and metadata alone cannot resurrect a stale wrapper.
                        -- Require displacement matching the independently profiled flight.
                        if not wrapperMotion and now>wrapperAt then
                            local elapsed=now-wrapperAt
                            local distance=G.dist(wrapperOrigin,pos)
                            local lower,expected=displacementBounds(definition,previous and previous.wrapperSpeed or speed,elapsed)
                            -- A fast flight is resolvable on the next ~36 ms host sample; slow flights keep
                            -- the 40 ms floor. Either way a stationary stale wrapper cannot pass the bounds.
                            if elapsed>=.02 and (elapsed>=.04 or expected>=24) and elapsed<=.25 and distance>1
                                and withinBounds(distance,lower,expected,8,.12)
                                and G.segment(pos,wrapperOrigin,endpoint)<=20 then wrapperMotion=true
                            elseif elapsed>.25 then wrapperOrigin=pos;wrapperAt=now end
                        end
                        if not wrapperMotion then
                            confirmed=false;motionUnknown=false;rejection='wrapper_validity_unconfirmed'
                        end
                    end
                    -- Width disagreement remains unsupported even during a stale
                    -- sample window; the old narrow corridor cannot validate it.
                    if width and width>definition.radius*2+10 then confirmed=false;motionUnknown=false;rejection='width_mismatch'end
                local damageID=freshDamage or previous and previous.damageID;local correlated=freshCast;local shared
                if confirmed and not damageID then
                    local correlationReason
                    damageID,correlated,correlationReason=self:Correlate(owner,definition,d,now,pos)
                    if correlationReason then self:Reject('correlation_unresolved',id,correlationReason,owner,d,now,definition,pos,nil,m)end
                    if not damageID then
                        local sharedReason
                        damageID,shared,sharedReason=self:SharedEffect(definition,dOwner,d,pos,now)
                        if sharedReason then self:Reject('correlation_unresolved',id,sharedReason,owner,d,now,definition,pos,nil,m)end
                    end
                    damageID=damageID or id
                end
                local contourOrigin=correlated and correlated.origin or previous and previous.contourOrigin
                      or endpointSource~='host_endpos_start_off_ray'and G.point(d.startPos)and G.copy(d.startPos)or G.copy(pos)
                local instanceID=correlated and(correlated.instanceID or correlated.damageID)or previous and previous.instanceID
                    or shared and shared.instanceID or id..':'..tostring(now)
                    local stageID=correlated and correlated.stageID or previous and previous.stageID or instanceID
                    if shared then stageID=id..':'..tostring(now)end
                local observedAt=correlated and correlated.observedAt or previous and previous.observedAt or now
                local effectMembers=previous and previous.effectMembers or shared and shared.effectMembers
                if confirmed and definition.effectGroup then
                    if not effectMembers then effectMembers={firstAt=now,count=0,aliases={},
                        constantFlight=not definition.acceleration and not definition.speedUncertain,
                        profile=definition.profile,source=definition.source}end
                    if not effectMembers.aliases[definition.name]then
                        effectMembers.aliases[definition.name]=true;effectMembers.count=effectMembers.count+1
                    end
                end
        if definition.anchorSource then
            -- Remembered endpoint for a later cast anchored on this projectile (cast.anchorMissile).
            self.anchors=self.anchors or {}
            self.anchors[tostring(ownerView.networkID or ownerView.handle)..':'..definition.name]={pos=G.copy(endpoint),at=now}
        end
        self.seen[id]={pos=pos,at=now,speed=speed,owner=dOwner,alias=definition.name,start=retainedFlight and previous.start or G.point(d.startPos)and G.copy(d.startPos),hostEndpoint=retainedFlight and previous.hostEndpoint or G.copy(d.endPos),
                        effectMembers=effectMembers,
                        endpoint=endpoint,damageID=damageID,group=definition.effectGroup,confirmed=confirmed,castLinked=previous and previous.castLinked or correlated~=nil,
                      speedOrigin=speedOrigin,speedAt=speedAt,speedValidated=speedValidated,
                      motionPos=motionPos,motionAt=motionAt,motionSpeed=motionSpeed,motionUnknown=motionUnknown,
                       wrapperState=mValid,wrapperMotion=wrapperMotion,wrapperOrigin=wrapperOrigin,wrapperAt=wrapperAt,
                       wrapperSpeed=previous and previous.wrapperSpeed or speed,
                      contourOrigin=contourOrigin,instanceID=instanceID,stageID=stageID,observedAt=observedAt}
                    if motionRejected then
                        self.seen[id].motionRejected=true
                        self.seen[id].trajectoryUnmodeled=not motionUnknown
                    end
                    if confirmed or motionUnknown then
                      local distance=G.dist(motionPos,endpoint)
                    local threat={id=id,instanceID=instanceID,stageID=stageID,damageID=damageID or id,casterID=dOwner,profile=definition.profile,
                            evidence='observed',ability=definition.id,abilityName=definition.castAlias or definition.name,champion=owner.charName,
                        source=definition.source,shape='missile',origin=motionPos,contourOrigin=contourOrigin,observedAt=observedAt,
                        b=G.copy(endpoint),endpointSource=endpointSource,radius=math.max(width or 0,definition.radius),speed=motionSpeed,
                        motionUnknown=motionUnknown or nil,positionObservedAt=motionAt,
                            widthSource=width and 'asset_and_observation'or 'profile_asset',
                            speedSource=definition.speedUncertain and 'asset_speed_bounds_onset_unresolved'or speedValidated and 'asset_confirmed_by_motion'or definition.acceleration and 'asset_acceleration'or 'host_and_asset',
                            acceleration=definition.acceleration,minSpeed=definition.minSpeed,maxSpeed=definition.maxSpeed,
                         speedUncertain=definition.speedUncertain and not motionUnknown or nil,
                        starts=motionUnknown and now or motionAt,launch=motionAt,blockable=definition.blockable~=false,
                    damage=self:Damage(owner,set[definition.castAlias]or definition)}
            local effects=set[definition.castAlias]or definition
            if effects.cast and effects.cast.blockable==false then threat.blockable=false end
            threat.cc=effects.cc;threat.ccUnknown=effects.ccUnknown;threat.ccHard=effects.ccHard;threat.parryable=effects.parryable
            threat.untargetableBlockable=effects.untargetableBlockable~=false
            threat.tier=effects.tier or definition.tier;threat.windwall=effects.windwall or definition.windwall
            threat.collide=effects.collide or definition.collide
            threat.zones=effects.zones or definition.zones;threat.flightTime=definition.flightTime
            threat.displace=effects.displace or definition.displace
            if definition.stepAfter then
                -- The step is `at` units from the native start; the row starts at the latest moved sample.
                local start=self.seen[id].start
                local left=definition.stepAfter-(G.point(start)and G.dist(start,motionPos)or 0)
                if left>0 then threat.speedStep={at=left,speed=definition.speedStep.speed}else threat.speed=definition.speedStep.speed end
            end
            if charged then threat.extentSource,threat.extentValue,threat.extentInput=chargeSource,charged,chargeInput end
                        local _,latest=G.travelTimeBounds(threat,distance)
                        local flightEnd=motionAt+latest
                        self.seen[id].flightEnd=not(boundedSpeed and motionUnknown)and flightEnd or nil
                        threat.ends=motionUnknown and now+.25 or flightEnd
                      threat.nativeAlias=definition.name
                      threat.nativeEmitterOrigin=self.seen[id].start
                      if self.channels then self.channels:Correlate(threat)end
                      if self.clip and threat.collide and not motionUnknown then threat=self.clip(self,threat,now)end
                      local accepted=self.threats:Observe(threat)
                      local impact,anchor=definition.impact or effects.impact,definition.anchored or effects.anchored
                      if accepted and(impact or anchor)then self:TrackFlight(threat,impact,anchor,now)end
                if accepted and confirmed and(not previous or not previous.confirmed)then
                    if self.onThreat then self.onThreat(threat)end
                    -- First attributable native sample; never confuse the prepared
                    -- endpoint or contour with host-reported projectile geometry.
                    if self.onMissileObservation and self.diagnostics and self.diagnostics()then
                        self.onMissileObservation(owner,m,d,pos,now,threat)
                    end
                end
                      if motionUnknown then self:Reject('missile_uncertain',id,rejection,owner,d,now,definition,m.pos,motionDiagnostic,m)end
                else self.threats:Remove(id);self:Reject('missile_rejected',id,rejection,owner,d,now,definition,m.pos,motionDiagnostic,m)end
                else
                    -- An unrecognised hostile straight projectile is still a body in flight:
                    -- a conservative walking-only threat from its own native ray (ObserveUnknown).
                    -- A known but unsupported stage (a hop, a return, a visual) stays excluded.
                    local generic=owner and not definition and definitionReason==nil
                        and self:ObserveUnknown(owner,ownerView,set,m,d,mName,id,now)
                    if not generic then self.threats:Remove(id)end
                    if generic then
                    elseif definitionReason then
                self.seen[id]=nil
                self:Reject('missile_rejected',id,definitionReason,owner,d,now,nil,nil,nil,m,mName)
            elseif definition then
                        local reason=not self:Allowed(owner,definition)and 'menu_disabled'or d.target~=0 and 'targeted_or_unknown_target'
                            or not G.point(m.pos)and 'missing_position'or not G.point(d.endPos)and 'missing_endpoint'or 'missing_speed'
                        self:Reject('missile_rejected',id,reason,owner,d,now,definition,m.pos,nil,m)
                    elseif not owner and d.target==0 and G.point(m.pos)and G.point(self.g.myHero.pos)
                        and G.dist(m.pos,self.g.myHero.pos)<1500 then
                        self:Reject('missile_rejected',id,'owner_not_attributed',nil,d,now,nil,m.pos,nil,m)
                    end
                    -- Bounded diagnostics only; unknown objects are not invented threats.
                    local name=mName
                    local known=type(name)=='string'and set and (set[name]or set.__lower and set.__lower[name:lower()])
                    local excludedRole=known and (known.threatRole=='utility'or known.threatRole=='non_hostile_component')
                    if owner and excludedRole then
                        self:ObserveExcluded('missile',owner,known,m,d,now,id,ownerView)
                    end
                    -- Excluded components never become unknown rows; skip their key work.
                    local unknownKey=owner and not excludedRole and type(name)=='string'and (not self.diagnostics or self.diagnostics())
                  and ownerView.charName..':missile:'..name
                if unknownKey and not self.unknown[unknownKey]and name:match('^[%w_]+$')
                        and (self.unknownCount or 0)<128 and G.finite(d.width)and d.width>0 then
                        self.unknown[unknownKey]=true;self.unknownCount=(self.unknownCount or 0)+1
                        if self.onUnknown then self.onUnknown(name,owner,d,m,now)end
                    end
                end
            end
        end
        end -- not friendly (prefiltered)
    end
    return true,nil,trajectoryUnmodeled
end
return O

end
