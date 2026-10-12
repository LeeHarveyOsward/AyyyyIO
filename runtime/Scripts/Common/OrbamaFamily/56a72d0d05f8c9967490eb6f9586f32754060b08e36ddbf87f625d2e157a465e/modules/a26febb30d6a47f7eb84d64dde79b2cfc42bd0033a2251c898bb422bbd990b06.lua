return function(require)
-- Locked threats: hostile unit-targeted projectiles and instant unit casts whose
-- native target is the player. They become shape='targeted' rows, which the
-- planner never escapes by walking (no walking contact) but which the damage
-- forecast and defensive options (untargetable casts, spell shields) consume.
-- Own-profile data: evade.lockeddata (tools/evade_locked_threats.py).
-- Arrival interval (stationary-player model, refreshed every scan). A homing
-- projectile connects at the target's hitbox edge:
--   earliest = (distance - hero radius) / fastest speed - staleSlack
--   latest   = (distance - hero radius) / slowest speed + contactSlack
-- staleSlack: a stale position sample means the projectile is already closer.
-- contactSlack: hitbox/contact convention. Both are unmeasured planning values.
-- Player movement during flight is not modeled beyond this per-scan refresh.
-- Defence-only rows (2026-10-10): an enemy champion's basic attack whose windup
-- targets the player (SDK attack recognition, SDK auto-attack damage, crit not
-- assumed) and a dangerous unlisted targeted cast (evade.unlisteddata). Both are
-- marked `defenseOnly`: walking never answers them, and their damage alone never
-- reaches the damage share that spends an ability (only lethal or hard control).
local G=require('evade.geometry')
local ControlWindow=require('CombatProfiles.control_window')
local CCAttacks=require('CombatProfiles.cc_attacks')
local L={}
L.maxTracked=16        -- locked rows per scan (bounded host/forecast work)
L.staleSlack=.02       -- host position sample age (s)
L.contactSlack=.03     -- contact convention slack (s)
L.speedTolerance=.1    -- host speed admitted within +/-10% of the asset bounds
L.hostSpeedMin,L.hostSpeedMax=200,5000 -- sane bounds when no asset speed exists
L.maxRange=3000        -- farther locked missiles are not forecast yet
L.meleeRange=300       -- attack range below this: melee, contact at cast end
L.attackSlack=.05      -- a windup this close to its cast end counts as launched
L.unlistedWindow=0     -- extra contact window after cast end for an unlisted instant cast (contactSlack applies)
local data
local function index(identity)
    data=data or require('evade.lockeddata')
    L.lower=L.lower or {}
    local cached=L.lower[identity]
    if cached~=nil then return cached end
    local rows=data[identity];local out=false
    if rows then out={};for name,row in pairs(rows)do out[name:lower()]=row end end
    L.lower[identity]=out;return out
end
-- Reviewed sheet rows carried by a loaded catalogue set (records with `locked`).
-- The generated own-asset table keeps precedence for names it already has.
function L.Register(identity,set)
    if type(identity)~='string'or type(set)~='table'or not(set.__features and set.__features.locked)then return end
    local rows=index(identity)
    if not rows then rows={};L.lower[identity]=rows end
    for _,r in pairs(set)do
        local row=type(r)=='table'and r.name and r.locked
        if type(row)=='table'then for _,name in ipairs(row.names or {row.name})do
            local key=name:lower();if rows[key]==nil then rows[key]=row end
        end end
    end
end
function L.Lookup(identity,name)
    if type(identity)~='string'or type(name)~='string'then return nil end
    local rows=index(identity);if not rows then return nil end
    local row=rows[name]
    if row==nil then
        -- Case-folded once per distinct native name (e.g. attack missiles), then
        -- cached, including misses; bounded per identity.
        row=rows[name:lower()]or false
        rows.__n=(rows.__n or 0)+1
        if rows.__n<=128 then rows[name]=row end
    end
    return row or nil
end
function L.new()return setmetatable({scan=-1,count=0,event={},damageScratch=nil,attacks={},attackCount=0},{__index=L})end
-- Scan-scoped player identity; read once per scan only when a candidate exists.
function L:Player(observer)
    if self.scan~=observer.scanID then
        local h=observer.g.myHero
        self.scan=observer.scanID;self.count=0
        self.handle,self.networkID,self.pos,self.radius=h.handle,h.networkID,nil,h.boundingRadius
        self.heroPos=nil
    end
    return self
end
local function targetsPlayer(self,target)
    return target~=nil and target~=0 and (target==self.handle or target==self.networkID)
end
-- Speed bounds: host speed inside the asset bounds (with tolerance) narrows
-- them; otherwise the asset bounds stay. Without asset speed a sane host speed
-- is required. Returns lo,hi,source or nil,reason.
function L.Speeds(row,hostSpeed)
    local lo,hi=row.speedMin,row.speedMax
    local host=G.finite(hostSpeed)and hostSpeed>0 and hostSpeed or nil
    if G.finite(lo)and G.finite(hi)and lo>0 and hi>=lo then
        if host and host>=lo*(1-L.speedTolerance)and host<=hi*(1+L.speedTolerance)then return host,host,'host_within_asset'end
        return lo,hi,'asset_bounds'
    end
    if host and host>=L.hostSpeedMin and host<=L.hostSpeedMax then return host,host,'host_only'end
    return nil,'locked_speed_unknown'
end
local function fill(self,observer,owner,row,id,now,starts,latest,origin,speed,speedSource,delivery)
    local e=self.event
    -- One reused scratch row (the store copies); clear delivery-specific fields.
    e.castStart,e.castStartSource,e.castFinishSource,e.speedMin,e.speedMax,e.observedAt=nil,nil,nil,nil,nil,nil
    e.id=id;e.instanceID=id;e.stageID=id;e.damageID=id;e.casterID=owner.networkID or owner.handle
    e.profile=row.profile;e.evidence='observed';e.ability=row.record;e.abilityName=row.name;e.champion=owner.charName
    e.source=row.source;e.shape='targeted';e.targetID=self.networkID;e.origin=origin
    e.starts=starts;e.impactLatest=latest;e.ends=latest;e.speed=speed;e.speedSource=speedSource
    e.locked=delivery;e.blockable=row.blockable~=false;e.parryable=true
    e.untargetableBlockable=delivery=='missile'and row.untargetableBlockable~=false or row.untargetableBlockable==true
    e.cc=row.cc;e.ccUnknown=row.ccUnknown or nil;e.ccHard=row.ccHard or nil;e.tier=row.tier
    -- Own base formula only; unknown stays unknown (forecast marks it unknown,
    -- the trigger never counts it as damage). Never a guessed amount.
    local damage=not row.unknownDamage and observer:Damage(owner,row)or nil
    e.damage=damage;e.unknownDamage=damage==nil or nil
    e.damageProvenance=damage and row.damageProvenance or row.unknownReason or 'damage_estimate_unavailable'
    return e
end
-- One hostile missile with a nonzero native target. Returns true when this
-- module owns the identity (tracked or deliberately ignored), false otherwise.
function L:Missile(observer,owner,ownerView,m,d,name,id,now)
    -- Integer target check first: attacks and ally-targeted casts cost no name work.
    if not owner or not ownerView then return false end
    self:Player(observer)
    if not targetsPlayer(self,d.target)then return false end -- ally/minion target: not ours
    local row=L.Lookup(ownerView.charName,name)
    if not row or row.delivery~='missile'then return false end
    if self.count>=L.maxTracked then observer:Reject('missile_rejected',id,'locked_capacity',owner,d,now,nil,nil,nil,m,name);return true end
    local pos=m.pos
    if not G.point(pos)then return false end
    if not self.heroPos then self.heroPos=G.copy(observer.g.myHero.pos)end
    local hero=self.heroPos;if not G.point(hero)then return false end
    local lo,hi,source=L.Speeds(row,d.speed)
    if not lo then observer:Reject('missile_rejected',id,hi,owner,d,now,nil,nil,nil,m,name);return true end
    local distance=G.dist(pos,hero)
    if distance>L.maxRange then return true end
    local radius=G.finite(self.radius)and self.radius or 0
    local travel=math.max(0,distance-radius)
    local starts=now+math.max(0,travel/hi-L.staleSlack)
    local latest=now+travel/lo+L.contactSlack
    self.count=self.count+1
    local previous=observer.seen[id]
    observer.seen[id]={owner=d.owner,alias='locked:'..row.name,locked=true,at=now,pos=G.copy(pos),
        observedAt=previous and previous.locked and previous.observedAt or now}
    local e=fill(self,observer,owner,row,id,now,starts,latest,G.copy(pos),lo==hi and lo or nil,source,'missile')
    e.observedAt=observer.seen[id].observedAt;e.speedMin=lo;e.speedMax=hi
    local accepted=observer.threats:Observe(e)
    if accepted and not (previous and previous.locked)and observer.onThreat then observer.onThreat(observer.threats.byID[id]or e)end
    return true
end
local function castStart(spell)
    local start=spell.startTime;if not G.finite(start)or start<=0 then start=spell.castStartTime end
    return start
end
-- Contact interval after a windup that ends at `finish` for a projectile of
-- `speed` from `from`: the player may close or open the distance by its own
-- speed during the remaining windup; the projectile meets the hitbox edge.
local function travel(self,observer,from,speed,finish,now)
    if not self.heroPos then self.heroPos=G.copy(observer.g.myHero.pos)end
    local hero=self.heroPos;if not G.point(hero)or not G.point(from)then return nil end
    local radius=G.finite(self.radius)and self.radius or 0
    local ms=observer.g.myHero.ms;if not G.finite(ms)or ms<0 then ms=0 end
    local drift=ms*math.max(0,finish-now);local distance=G.dist(from,hero)
    if distance>L.maxRange then return nil end
    return math.max(0,distance-radius-drift)/speed,(distance+drift)/speed
end
-- A basic attack in windup at the player (SDK recognition, including empowered
-- attack names). One observation per attack: its interval is fixed when first
-- seen, so a stable attack does not bump the threat revision every scan. A
-- windup that stops before its cast end is retired by L:Reconcile.
function L:Attack(observer,owner,spell,now)
    local sdk=observer.g.SDK
    if not ControlWindow.IsAttackCast(spell,sdk and sdk.Data)then return false end
    local start,finish=castStart(spell),spell.castEndTime
    if not G.finite(start)or start<=0 or not G.finite(finish)or finish<start or finish-start>2 then return true end
    local ownerID=owner.networkID or owner.handle;if not ownerID then return true end
    local id='attack:'..tostring(ownerID)..':'..tostring(start)
    if observer.threats.byID[id]or now>finish+2 then return true end
    local tracked=self.attacks[ownerID]
    if not tracked and self.attackCount>=L.maxTracked then return true end
    local range=owner.range;local melee=G.finite(range)and range<L.meleeRange
    local data=owner.attackData;local speed=data and data.projectileSpeed
    local lo,hi
    if melee or speed==math.huge then lo,hi=0,0
    elseif G.finite(speed)and speed>0 then lo,hi=travel(self,observer,owner.pos,speed,finish,now)
        if not lo then return true end
    else return true end -- a ranged attack without a projectile speed has no known contact time
    local damage=sdk and sdk.Damage
    local ok,amount=false,nil
    if damage and type(damage.GetAutoAttackDamage)=='function'then
        ok,amount=pcall(damage.GetAutoAttackDamage,damage,owner,observer.g.myHero,true)
        observer.hostCalls=(observer.hostCalls or 0)+1
    end
    -- Without an estimate the attack is not tracked: never a guessed amount.
    if not ok or not G.finite(amount)or amount<0 then return true end
    local starts,latest=math.max(now,finish+lo-(lo>0 and L.staleSlack or 0)),finish+hi+L.contactSlack
    if latest<now then return true end
    local profile=type(owner.charName)=='string'and owner.charName:match('^Jade_')and 'classic'or 'normal'
    local cc=CCAttacks.Has(spell.name)
    local row={profile=profile,name=spell.name,source='SDK attack recognition; SDK.Damage:GetAutoAttackDamage (passives, no crit)',
        blockable=false,untargetableBlockable=true,cc=0,ccHard=cc or nil,unknownDamage=true}
    local e=fill(self,observer,owner,row,id,now,starts,latest,G.copy(owner.pos),nil,melee and 'melee_cast_end'or 'attack_projectile','attack')
    e.castStart=start;e.castStartSource='startTime';e.castFinishSource='castEndTime'
    e.damage={kind='physical',mitigated=amount};e.unknownDamage=nil
    e.damageProvenance='SDK auto-attack estimate at observation (mitigated, crit not assumed)'
    e.basicAttack=true;e.defenseOnly=true;e.ccSource=cc and 'CombatProfiles.cc_attacks'or nil
    local accepted=observer.threats:Observe(e)
    e.basicAttack,e.defenseOnly,e.ccSource=nil,nil,nil -- the scratch row is shared with other deliveries
    if accepted then
        if not tracked then self.attackCount=self.attackCount+1 end
        self.attacks[ownerID]={id=id,start=start,finish=finish}
        if observer.onThreat then observer.onThreat(observer.threats.byID[id])end
    end
    return true
end
-- A tracked windup that ends (cancelled, replaced, caster dead) before its cast
-- end never launched: its row is removed. After the cast end the row stays until
-- its impact interval passes (a ranged attack is in flight).
function L:Reconcile(observer,owner,spell,now)
    if self.attackCount==0 then return end
    local ownerID=owner.networkID or owner.handle;local tracked=ownerID and self.attacks[ownerID]
    if not tracked then return end
    if now>=tracked.finish-L.attackSlack then self.attacks[ownerID]=nil;self.attackCount=self.attackCount-1;return end
    if spell and spell.valid and spell.isStopped~=true and castStart(spell)==tracked.start and not owner.dead then return end
    observer.threats:Remove(tracked.id);self.attacks[ownerID]=nil;self.attackCount=self.attackCount-1
end
-- A dangerous unit-targeted cast at the player that no catalogue row models
-- (evade.unlisteddata). Requires the caster's own catalogue asset record of the
-- name (identity/profile) and no reviewed locked row. Damage stays unknown.
function L:Unlisted(observer,owner,spell,set,now)
    self:Player(observer)
    if not targetsPlayer(self,spell.target)or type(spell.name)~='string'then return false end
    L.unlisted=L.unlisted or require('evade.unlisteddata')
    local listed=L.unlisted[spell.name]
    if not listed or type(owner.charName)~='string'or owner.charName:match('^Jade_')then return false end
    local record=set and set.__lower and set.__lower[spell.name:lower()]
    if not record or record.profile~='normal'or L.Lookup(owner.charName,spell.name)then return false end
    local start,finish=castStart(spell),spell.castEndTime
    if not G.finite(start)or start<=0 or not G.finite(finish)or finish<start or finish-start>2 then return true end
    local ownerID=owner.networkID or owner.handle;if not ownerID then return true end
    local id='unlisted:'..tostring(ownerID)..':'..spell.name..':'..tostring(start)
    if observer.threats.byID[id]then return true end
    if self.count>=L.maxTracked then return true end
    local lo,hi=0,listed.window or L.unlistedWindow
    if listed.speed then
        lo,hi=travel(self,observer,owner.pos,listed.speed,finish,now)
        if not lo then return true end
    end
    local starts,latest=math.max(now,finish+lo),finish+hi+L.contactSlack
    if latest<now then return true end
    self.count=self.count+1
    local row={profile='normal',name=spell.name,record=record.id,source=listed.source,blockable=true,
        -- Unreviewed: becoming untargetable before contact voids a unit-targeted cast or projectile.
        untargetableBlockable=true,ccHard=listed.ccHard or nil,tier=listed.tier,unknownDamage=true,
        unknownReason='unlisted targeted cast: damage not modelled'}
    local e=fill(self,observer,owner,row,id,now,starts,latest,G.copy(owner.pos),listed.speed,listed.speed and 'unlisted_speed'or 'unlisted_cast_end','unlisted')
    e.castStart=start;e.castStartSource='startTime';e.castFinishSource='castEndTime'
    e.unlisted=true;e.defenseOnly=true
    local accepted=observer.threats:Observe(e)
    e.unlisted,e.defenseOnly=nil,nil
    if accepted and observer.onThreat then observer.onThreat(observer.threats.byID[id])end
    return true
end
-- Instant unit cast at the player: impact at cast end plus the own window.
function L:Cast(observer,owner,spell,now)
    self:Player(observer)
    if not targetsPlayer(self,spell.target)then return false end
    if self:Attack(observer,owner,spell,now)then return true end
    local row=L.Lookup(owner.charName,spell.name)
    if not row or row.delivery~='instant'then return false end
    local start=spell.startTime;if not G.finite(start)or start<=0 then start=spell.castStartTime end
    local finish=spell.castEndTime
    if not G.finite(start)or start<=0 or not G.finite(finish)or finish<start or finish-start>2 or now-finish>(row.impactWindow or 0)+.25 then return true end
    if self.count>=L.maxTracked then return true end
    self.count=self.count+1
    local ownerID=owner.networkID or owner.handle
    local id='locked-cast:'..tostring(ownerID)..':'..row.name..':'..tostring(start)
    local latest=finish+(row.impactWindow or 0)
    if latest<now then return true end
    local e=fill(self,observer,owner,row,id,now,math.max(now,finish),latest,G.copy(owner.pos),nil,'instant_cast_end','instant')
    e.castStart=start;e.castStartSource='startTime';e.castFinishSource='castEndTime'
    local fresh=observer.threats.byID[id]==nil
    local accepted=observer.threats:Observe(e)
    if accepted and fresh and observer.onThreat then observer.onThreat(observer.threats.byID[id]or e)end
    return true
end
return L

end
