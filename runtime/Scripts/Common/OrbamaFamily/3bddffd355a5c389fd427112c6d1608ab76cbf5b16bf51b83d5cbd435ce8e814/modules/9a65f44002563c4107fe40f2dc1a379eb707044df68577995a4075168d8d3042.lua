return function(require)
-- Live danger of a threat to the player, in shares of current health (1 = lethal):
--   effective damage now   the threat's own damage (caster stats at the cast, evade.calculations)
--                          through the player's armor / magic resist, minus typed and general shields;
--   hard control           seconds of control x controlShare of health (the cost of standing still), plus
--                          what the enemy team can add while it lasts: the caster and every visible enemy
--                          that can reach the player in that time, with their ready abilities (compiled
--                          formulas, own live stats) and basic attacks; a pull (catalogue `displace`)
--                          is followed up where it leaves the player, next to the caster;
--   lethal risk            damage plus that follow-up reaches current health: the value is at least 1.
-- A reviewed severity tier stands in only when the damage is unknown and no hard control is known
-- (basis 'tier'); every such fallback is counted and reported once per threat.
-- Cost: one record per threat row per player-state change (weak-keyed by the row, which Observe replaces on
-- change). The enemy snapshot is read at most every teamInterval and only when hard control needs it; an
-- enemy's burst is read once per snapshot. Ranking a route only sums cached records.
local G=require('evade.geometry')
local D=require('evade.damage')
local Calculations=require('evade.calculations')
local M={};M.__index=M
M.tierShare={.02,.06,.12,.25,.45}
M.controlShare=.05
M.unknownControl=1
M.abilityWindow=1
M.engage=1000
M.teamInterval=.25
M.maxEnemies=10
M.maxZones=8
M.slotDefinitions=4
M.maxReported=256
function M.new(source)
    return setmetatable({source=source,records=setmetatable({},{__mode='k'}),slotIndex=setmetatable({},{__mode='k'}),
        reported={},reportedCount=0,serial=0,teamSerial=0,now=0,fallbacks=0,teamReads=0},M)
end
-- Seconds of hard control: a known positive duration, or reviewed hard control of unknown length.
function M.Control(cc,hard)
    if G.finite(cc)and cc>0 then return cc end
    return hard==true and M.unknownControl or 0
end
local function pool(value)return G.finite(value)and value>0 and value or 0 end
-- Mitigated damage of one effect (plain or components) after the player's shields, or nil when unknown.
function M.Damage(effect,stats)
    if type(effect)~='table'or type(stats)~='table'then return nil end
    local parts=effect.components;local count=1
    if parts~=nil then
        if type(parts)~='table'or #parts==0 or #parts>8 then return nil end
        count=#parts
    end
    local physical,magical,other=0,0,0
    for i=1,count do
        local part=parts and parts[i]or effect
        local value=D.amount(part,stats)
        if value==nil then return nil end
        if part.kind=='physical'then physical=physical+value elseif part.kind=='magical'then magical=magical+value
        else other=other+value end
    end
    local left=math.max(0,physical-pool(stats.physicalShield))+math.max(0,magical-pool(stats.magicShield))+other
    return math.max(0,left-pool(stats.shield))
end
-- The formula. `damage` nil = unknown; `followUp` nil = unknown (counts as nothing, flagged by the caller).
function M.Value(health,damage,control,followUp,tier)
    local r={damage=damage,control=control,followUp=followUp}
    if damage==nil and control<=0 or not G.finite(health)or health<=0 then
        local share=G.finite(tier)and M.tierShare[math.max(1,math.min(5,math.floor(tier)))]
        r.basis=share and 'tier'or(G.finite(health)and health>0 and 'unknown'or 'stats_unknown');r.value=share or nil
        return r
    end
    local lost=(damage or 0)+(followUp or 0)
    r.value=(lost+control*M.controlShare*health)/health
    r.lethal=lost>=health or nil
    if r.lethal then r.value=math.max(r.value,1)end
    r.basis=damage==nil and 'control'or control>0 and 'damage_control'or 'damage'
    return r
end
-- Uncached, team-free danger (pure callers and tests): follow-up stays unknown.
function M.Of(t,stats)
    local control=M.Control(t.cc,t.ccHard)
    local r=M.Value(type(stats)=='table'and stats.health,M.Damage(t.damage,stats),control,nil,t.tier)
    r.followUpUnknown=control>0 or nil
    return r
end
-- A new player state invalidates every record: health in steps of 0.5 % of maximum health, resists,
-- shields, and the position in 100-unit cells (the follow-up depends on who can reach the player).
function M:Begin(stats,origin,now)
    if G.finite(now)then self.now=now end
    local step=G.finite(stats.maxHealth)and stats.maxHealth>0 and stats.maxHealth*.005 or 1
    local health=G.finite(stats.health)and math.floor(stats.health/step)or -1
    local x=G.point(origin)and math.floor(origin.x/100)or 0;local z=G.point(origin)and math.floor(origin.z/100)or 0
    local key=self.key
    if key and key[1]==health and key[2]==stats.maxHealth and key[3]==stats.armor and key[4]==stats.magicResist
        and key[5]==(stats.shield or 0)and key[6]==(stats.physicalShield or 0)and key[7]==(stats.magicShield or 0)
        and key[8]==x and key[9]==z then return end
    self.key={health,stats.maxHealth,stats.armor,stats.magicResist,stats.shield or 0,stats.physicalShield or 0,stats.magicShield or 0,x,z}
    self.serial=self.serial+1
end
-- Ability definitions with a compiled formula, by slot, once per loaded champion set.
function M:Slots(set)
    local slots=self.slotIndex[set]
    if slots then return slots end
    slots={}
    for _,definition in pairs(set)do
        local slot=type(definition)=='table'and definition.formula and type(definition.cast)=='table'and definition.cast.slot
        if G.finite(slot)and slot>=0 and slot<=3 then
            local list=slots[slot]or {};slots[slot]=list
            if #list<M.slotDefinitions then list[#list+1]=definition end
        end
    end
    self.slotIndex[set]=slots;return slots
end
local function readEnemy(e)
    if e.dead==true or e.valid==false then return nil end
    if e.visible==false then return false end
    local pos=e.pos
    if not G.point(pos)then return nil end
    return {id=e.networkID,pos={x=pos.x,y=pos.y or 0,z=pos.z},ms=G.finite(e.ms)and e.ms or 0,
        reach=(G.finite(e.range)and e.range or 0)+(G.finite(e.boundingRadius)and e.boundingRadius or 0),unit=e,charName=e.charName}
end
-- Visible enemies (position, reach, speed); `hidden` counts enemies the follow-up cannot see.
function M:Team()
    local team=self.team
    if team and self.now>=team.at and self.now<team.at+M.teamInterval then return team end
    self.teamSerial=self.teamSerial+1
    team={at=self.now,serial=self.teamSerial,hidden=0}
    local ok,enemies=pcall(self.source.enemies)
    if ok and type(enemies)=='table'then
        team.list={}
        for _,e in ipairs(enemies)do
            if #team.list>=M.maxEnemies then break end
            local good,row=pcall(readEnemy,e)
            if good and row then team.list[#team.list+1]=row elseif good and row==false then team.hidden=team.hidden+1 end
        end
    end
    self.team=team;return team
end
-- Ready ability damage and basic attacks of one enemy, read once per snapshot (raw, mitigated at use).
-- Known only when its attack or at least one ability slot could be read; an unread enemy is not zero.
function M:Burst(row)
    if row.burst~=nil then return row.burst or nil end
    local e=row.unit;local burst={abilities={}}
    local ok=pcall(function()
        local total,data=e.totalDamage,e.attackData;local interval=type(data)=='table'and data.animationTime
        if G.finite(total)and total>0 and G.finite(interval)and interval>0 then
            burst.attack={raw=total,kind='physical'};burst.rate=1/interval;burst.known=true
        end
        local set=self.source.sets and self.source.sets(row.charName)
        if type(set)~='table'then return end
        for slot,definitions in pairs(self:Slots(set))do
            local spell=e:GetSpellData(slot);self.teamReads=self.teamReads+1
            if type(spell)=='table'then burst.known=true end
            if spell and G.finite(spell.level)and spell.level>0 and(not G.finite(spell.currentCd)or spell.currentCd<=0)then
                local best
                for _,definition in ipairs(definitions)do
                    local damage=Calculations.Damage(e,definition);self.teamReads=self.teamReads+1
                    if damage and(not best or damage.raw>best.raw)then best=damage end
                end
                if best then burst.abilities[#burst.abilities+1]=best end
            end
        end
    end)
    row.burst=ok and burst.known and burst or false
    return row.burst or nil
end
-- One enemy's mitigated burst is valid for the current player state (once per state and snapshot).
local function prepare(self,row)
    if row.state==self.serial then return end
    row.state=self.serial;row.ready=nil
end
-- Where a hit leaves the player for the follow-up (catalogue `displace`, to='caster'): pulled toward the
-- caster by `distance` (absent: all the way, the stated upper bound), ending `stop` short of him. The
-- caster's position is his row in the enemy snapshot, else where his cast started. Returns the point and
-- how far it moved, or nil without a displacement or a known caster position.
function M.Displaced(t,origin,team)
    local d=t.displace
    if type(d)~='table'or d.to~='caster'or not G.point(origin)then return nil end
    local anchor
    if team and team.list and t.casterID~=nil then
        for _,row in ipairs(team.list)do if row.id==t.casterID then anchor=row.pos;break end end
    end
    anchor=anchor or G.point(t.castOrigin)and t.castOrigin or G.point(t.nativeEmitterOrigin)and t.nativeEmitterOrigin or nil
    if not anchor then return nil end
    local dx,dz=anchor.x-origin.x,anchor.z-origin.z;local length=math.sqrt(dx*dx+dz*dz)
    local move=math.max(0,length-(G.finite(d.stop)and math.max(0,d.stop)or 0))
    if G.finite(d.distance)then move=math.min(move,math.max(0,d.distance))end
    if length<=0 or move<=0 then return {x=origin.x,y=origin.y or 0,z=origin.z},0 end
    return {x=origin.x+dx/length*move,y=origin.y or 0,z=origin.z+dz/length*move},move
end
local function contribution(self,row,stats)
    if row.ready~=nil then return row.ready end
    local burst=self:Burst(row)
    row.ready=burst~=nil
    if burst then
        local abilities=0
        for _,ability in ipairs(burst.abilities)do abilities=abilities+(D.amount(ability,stats)or 0)end
        row.abilities=abilities
        row.attack=burst.attack and(D.amount(burst.attack,stats)or 0)*burst.rate or 0
    end
    return row.ready
end
-- Damage the enemy team can add during `control` seconds. Casters (one id or a set) always count;
-- others count within max(engage, own reach) plus what they walk in that time; attacks count within
-- attack reach plus that walk. Unknown (nil) when there is no enemy snapshot or a caster is not in it
-- or cannot be read.
function M:FollowUp(control,casters,origin,stats)
    if not self.source or control<=0 then return nil end
    local team=self:Team()
    if not team.list then return nil end
    local total,count,found=0,0,0
    local wanted=type(casters)=='table'and casters or nil
    local expected=0
    if wanted then for _ in pairs(wanted)do expected=expected+1 end elseif casters~=nil then expected=1 end
    local abilityShare=math.min(1,control/M.abilityWindow)
    local at=G.point(origin)and origin or nil
    for _,row in ipairs(team.list)do
        prepare(self,row)
        local walk=row.ms*control;local distance=at and G.dist(row.pos,at)or math.huge
        local caster=row.id~=nil and(wanted and wanted[row.id]or row.id==casters)
        if(caster or distance<=math.max(M.engage,row.reach)+walk)and contribution(self,row,stats)then
            count=count+1;if caster then found=found+1 end
            total=total+row.abilities*abilityShare
            if distance<=row.reach+walk then total=total+row.attack*control end
        end
    end
    if found<expected then return nil,count end
    return total,count
end
local function bands(self,t,stats,origin,damage,record,at)
    local zones=t.zones
    if type(zones)~='table'or #zones==0 or #zones>M.maxZones then return end
    -- Zones use the shared threat format (geometry.lua G.zoneAt): {axis='radial'|'along', from, to, damage, cc, ccHard}.
    local out,memo={},{}
    record.base=record.value
    for i,zone in ipairs(zones)do
        if type(zone)~='table'or(zone.axis~='radial'and zone.axis~='along')or not G.finite(zone.from)or not G.finite(zone.to)then return end
        local scale=zone.damage;if scale==nil then scale=1 end
        if not G.finite(scale)or scale<0 then return end
        local cc,hard=zone.cc,zone.ccHard
        if cc==nil and hard==nil then cc,hard=t.cc,t.ccHard end
        local control=M.Control(cc,hard)
        local follow=memo[control]
        if follow==nil then follow=control>0 and self:FollowUp(control,t.casterID,at or origin,stats)or false;memo[control]=follow end
        local band=M.Value(stats.health,damage and damage*scale,control,follow or nil,t.tier)
        out[i]=band.value
        if band.value and(record.value==nil or band.value>record.value)then record.value=band.value;record.lethal=band.lethal end
    end
    record.bands=out
end
-- Cached danger record of one threat row for the current player state.
local function cached(self,t,stats,origin)
    local record=self.records[t]
    local team=self.team
    if record and record.state==self.serial and(record.control==0 or not self.source
        or team and record.team==team.serial and self.now<team.at+M.teamInterval)then return record end
    local control=M.Control(t.cc,t.ccHard)
    local damage=M.Damage(t.damage,stats)
    local followUp,enemies,at,moved
    if control>0 or t.zones then at,moved=M.Displaced(t,origin,self.source and self:Team())end
    if control>0 then followUp,enemies=self:FollowUp(control,t.casterID,at or origin,stats)end
    record=M.Value(stats.health,damage,control,followUp,t.tier)
    record.enemies=enemies;record.followUpUnknown=control>0 and followUp==nil or nil;record.displaced=moved
    bands(self,t,stats,origin,damage,record,at)
    record.state=self.serial;record.team=self.team and self.team.serial
    self.records[t]=record
    -- Once per damage occurrence: Observe replaces a changed row, and the cast-derived and observed
    -- rows of one hit share its damageID. Bounded: a full set starts over.
    local key=t.damageID or t.id or t
    if record.basis=='tier'and not self.reported[key]then
        if self.reportedCount>=M.maxReported then self.reported={};self.reportedCount=0 end
        self.reported[key]=true;self.reportedCount=self.reportedCount+1;self.fallbacks=self.fallbacks+1
        if self.onFallback then pcall(self.onFallback,t,record)end
    end
    return record
end
function M:Threat(t,stats,origin,now)
    self:Begin(stats,origin,now)
    return cached(self,t,stats,origin)
end
-- Which zone band a point is in at `at` (G.zoneAt), or nil without zones or outside every band.
function M.Band(t,point,at)
    if type(t.zones)~='table'or #t.zones==0 or not G.point(point)then return nil end
    local _,_,_,index=G.zoneAt(t,point,at or t.starts)
    if index and index>0 then return index end
end
-- Danger at one point: its band's value, the unzoned value outside every band, else the threat's value.
function M:At(t,point,at,stats,origin,now)
    local record=self:Threat(t,stats,origin,now)
    if record.bands then
        local band=M.Band(t,point,at)
        if band and record.bands[band]~=nil then return record.bands[band],band end
        if record.base~=nil then return record.base end
    end
    return record.value
end
-- Danger of a whole forecast (planner result): its damage after shields and defenses, the follow-up
-- during its total hard control, tier stand-ins for hits of unknown damage and no control, and zone
-- bands where the contact point is known (`contactBands[id]`). Written onto the result.
function M:Outcome(result,stats,origin,now,byID,contactBands)
    self:Begin(stats,origin,now)
    local health=stats.health
    local fallback,fallbacks,extra,casters,at,moved=0,0,0,nil,nil,nil
    local scratch=self.casters;if scratch then for k in pairs(scratch)do scratch[k]=nil end end
    for _,id in ipairs(result.hits or {})do
        local t=byID and byID[id]
        if t then
            local record=cached(self,t,stats,origin)
            if record.basis=='tier'then fallback=fallback+(record.value or 0);fallbacks=fallbacks+1 end
            if M.Control(t.cc,t.ccHard)>0 and t.casterID~=nil then scratch=scratch or {};self.casters=scratch;casters=scratch;casters[t.casterID]=true end
            -- The first pull among the hits decides where the follow-up finds the player.
            if not at and t.displace and M.Control(t.cc,t.ccHard)>0 then at,moved=M.Displaced(t,origin,self.source and self:Team())end
            local band=contactBands and contactBands[id]
            if band and record.damage and type(t.zones)=='table'and type(t.zones[band])=='table'then
                local scale=t.zones[band].damage
                if G.finite(scale)and scale>=0 then extra=extra+record.damage*(scale-1)end
            end
        end
    end
    local control=M.Control(result.cc,result.ccHard)
    local followUp,enemies
    if control>0 then followUp,enemies=self:FollowUp(control,casters,at or origin,stats)end
    local damage=G.finite(result.damage)and math.max(0,result.damage+extra)or nil
    local r=M.Value(health,damage,control,followUp,nil)
    local value=r.value
    if fallbacks>0 then value=(value or 0)+fallback end
    if result.lethal==true then value=math.max(value or 0,1)end
    result.hitDanger=value;result.dangerHealth=G.finite(health)and health or nil
    result.dangerBasis=fallbacks>0 and((value or 0)>fallback and 'mixed'or 'tier')or r.basis
    result.controlSeconds=control;result.followUp=followUp;result.followUpEnemies=enemies;result.displaced=at and moved or nil
    result.followUpUnknown=control>0 and followUp==nil or nil;result.lethalRisk=r.lethal
    result.tierFallbacks=fallbacks
    return result
end
-- Whether a forecast is worth a cooldown (ability, item, ultimate): lethal now or with the follow-up during
-- its control, or a danger of at least `share` of current health (`health`: the caller's current health,
-- used when the forecast carries no danger). Basic-attack damage alone never counts. Hard control without
-- team evidence keeps qualifying as before.
function M.Matters(outcome,share,health)
    if type(outcome)~='table'or not outcome.known then return false,'forecast_unknown'end
    if outcome.lethal==true then return true,'lethal'end
    if outcome.lethalRisk==true then return true,'lethal_follow_up'end
    local hard=G.finite(outcome.cc)and outcome.cc>0 or outcome.ccHard==true
    local value,basis=outcome.hitDanger,outcome.dangerBasis
    health=outcome.dangerHealth or health
    if value==nil then
        -- A forecast built without a danger model: its damage share, the tier for unknown damage.
        if hard then return true,'hard_cc'end
        value=0
        if outcome.unknown==true and G.finite(outcome.tier)then
            value=M.tierShare[math.max(1,math.min(5,math.floor(outcome.tier)))];basis='tier'
        end
        if G.finite(outcome.damage)and G.finite(health)and health>0 and outcome.damage>0 then
            value=value+outcome.damage/health;basis=basis and 'mixed'or 'damage'
        end
    elseif hard and outcome.followUpUnknown then return true,'hard_cc'end
    if G.finite(outcome.attackDamage)and G.finite(health)and health>0 then value=value-outcome.attackDamage/health end
    if G.finite(share)and value>0 and value>=share then
        return true,hard and 'hard_cc_danger'or basis=='tier'and 'severity_tier'or 'danger_share'
    end
    return false,'below_danger_threshold'
end
return M

end
