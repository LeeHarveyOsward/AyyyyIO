return function(require)
-- Enemy cast observer: the host reports currentCd=0 for enemies, so their
-- cooldowns are rebuilt from casts seen by polling and the cooldown model in
-- CombatProfiles.cooldowns. Evidence, strongest first:
--   activeSpell (new startTime; slot by name, activeSpellSlot is unset for enemies),
--   a slot name returning to its first stage (recasts; also readable in fog),
--   a visible mana drop equal to one slot's cost (casts without activeSpell),
--   a 250-520 unit jump without dash or cast from a Flash holder (out of fog only
--   with a Flash particle at either end), summoner buffs (Barrier, Ghost, Cleanse,
--   Teleport on the caster; Heal on the caster or a healed teammate; Ignite and
--   Exhaust on our heroes, pinned on the only holder in range),
--   and the mana balance across a fog interval.
-- Rows: readyAt is the latest ready time, readyMin the earliest. A "possible"
-- cast keeps the earlier readyMin, so it is never drawn as ready.
-- Assumptions recorded for live review: summoners and zero-cost spells are not
-- inferred in fog; a recall during fog means nothing was cast.
local U=require('utils.util')
local M=require('CombatProfiles.cooldowns')
local K={};K.__index=K

local SELF_BUFFS={summonerbarrier='summonerbarrier',summonerhaste='summonerhaste',summonerboost='summonerboost',
    summonerteleport='summonerteleport'}
local HEAL='summonerheal'
local TARGET_BUFFS={summonerdot='summonerdot',summonerexhaust='summonerexhaust'}
local TARGET_RANGE={summonerdot=700,summonerexhaust=750}
local FLASH='summonerflash'
local SLOT_PERIOD,BUFF_PERIOD,ITEM_PERIOD=.2,.2,2

-- revision: bumped whenever displayed state changes (rows, slot names/ranks,
-- visibility, roster), so a display can skip rebuilding unchanged frames.
function K.new(c)
    return setmetatable({c=c,states={},rows={},holders={},revision=0,allies={},targetWanted={}},K)
end

-- Lowercase name -> buff key lookups without lowering every buff on every scan.
-- Bounded: reset when it grows past 1024 distinct names.
local lowerCache,lowerCount={},0
local function lower(name)
    local v=lowerCache[name]
    if not v then
        if lowerCount>=1024 then lowerCache,lowerCount={},0 end
        v=name:lower();lowerCache[name]=v;lowerCount=lowerCount+1
    end
    return v
end
local keyCache={}
local function summonerKey(name)local v=keyCache[name];if not v then v=M.key(name);keyCache[name]=v end;return v end

local function finite(n)return U.finite(n)end
local function near(drop,cost)return finite(cost)and cost>0 and math.abs(drop-cost)<=math.max(3,cost*.05)end

function K:State(h,id,name)
    local s=self.states[id];local handle=h.handle
    if s and(s.name~=name or s.handle~=handle)then s=nil;self.rows[id]=nil end
    if not s then
        -- Staggered phase (fifths of a period) per hero; the first slot read is immediate.
        local phase=(self.phase or 0)%5;self.phase=phase+1;local now=self.c:now()
        s={id=id,name=name,handle=handle,profile=M.profile(name),slots={},recent={},buffs={},items={},
            nextSlots=0,slotPhase=phase*SLOT_PERIOD/5,nextBuffs=now+phase*BUFF_PERIOD/5,nextItems=0}
        self.states[id]=s;self.rows[id]={};self.revision=self.revision+1
    end
    return s
end

-- Slots ---------------------------------------------------------------------
function K:SlotFor(s,name,native)
    if type(native)=='number'and native>=0 and native<=5 then return native end
    local lower=name:lower()
    for slot=0,5 do local sl=s.slots[slot];if sl and sl.lower==lower then return slot end end
    local best,length
    for slot=0,5 do local sl=s.slots[slot];local n=sl and sl.lower
        if n and #n>=4 and #lower>=4 and(lower:sub(1,#n)==n or n:sub(1,#lower)==lower)and(not length or #n>length)then best,length=slot,#n end
    end
    return best
end

function K:Seconds(s,h,slot,name,rank)
    if slot>=4 then
        local shortest,longest=M.summoner(s.profile,name,s.items);return shortest,longest,false
    end
    local seconds,estimate=M.spell(s.profile,s.name,slot,name,rank,h and h.cdr)
    return seconds,seconds,estimate
end

-- Definitely not castable at `now`: a known cooldown with no early end.
function K:OnCooldown(s,slot,now)
    local row=self.rows[s.id][slot]
    return row~=nil and not row.estimate and finite(row.readyMin)and row.readyMin>now+.3
end

-- A cast whose time lies in [lo,hi]; source names the evidence.
function K:Start(s,h,slot,lo,hi,source,name)
    local sl=s.slots[slot];name=name or sl and sl.name
    if type(name)~='string'then return end
    local shortest,longest,estimate=self:Seconds(s,h,slot,name,sl and sl.level)
    local rows=self.rows[s.id];self.revision=self.revision+1
    if not shortest then rows[slot]=nil;return end
    rows[slot]={name=name,rank=sl and sl.level or 1,readyMin=lo+shortest,readyAt=hi+longest,
        estimate=estimate or hi-lo>.5 or shortest~=longest,source=source,castAt=hi,at=self.c:now()}
end

-- A cast that may or may not have happened in [lo,hi]: the latest ready time
-- grows, the earliest stays what it was without the cast.
function K:Possible(s,h,slot,lo,hi,source)
    local sl=s.slots[slot];if not sl or type(sl.name)~='string'then return end
    local _,longest=self:Seconds(s,h,slot,sl.name,sl.level);if not longest then return end
    local rows=self.rows[s.id];local old=rows[slot];local now=self.c:now()
    local readyMin=old and finite(old.readyMin)and old.readyMin or math.min(now,lo)
    local readyAt=math.max(old and old.readyAt or 0,hi+longest)
    self.revision=self.revision+1
    rows[slot]={name=sl.name,rank=sl.level or 1,readyMin=readyMin,readyAt=readyAt,estimate=true,source=source,castAt=hi,at=now}
end

function K:RefreshSlots(s,h,now)
    if not h.GetSpellData then return end
    local holders=self.holders
    for slot=0,5 do
        local d=h:GetSpellData(slot);local name=d and d.name
        local sl=s.slots[slot]
        if type(name)~='string'or name==''then s.slots[slot]=nil
        else
            if not sl then sl={};s.slots[slot]=sl end
            if sl.name and name~=sl.name then
                if not sl.pendingFrom then
                    -- First stage used: its cooldown starts when the name returns.
                    sl.pendingFrom=sl.name;sl.pendingAt=now
                    local row=self.rows[s.id][slot]
                    if row and now-row.at<=2 then self.rows[s.id][slot]=nil;self.revision=self.revision+1 end
                elseif name==sl.pendingFrom then
                    sl.pendingFrom=nil;sl.name=name;sl.level=d.level
                    if slot<=3 and now-sl.pendingAt<=30 then self:Start(s,h,slot,now-SLOT_PERIOD,now,'recast',name);s.recastAt=now end
                end
            end
            -- A name that never returns is a form or stolen spell, not a recast.
            if sl.pendingFrom and now-sl.pendingAt>30 then sl.pendingFrom=nil end
            local level=d.level or 0
            if sl.name~=name or sl.level~=level then self.revision=self.revision+1 end
            if sl.name~=name or not sl.lower then sl.lower=lower(name)end
            sl.name=name;sl.level=level;sl.cost=d.mana
            -- A positive host value (allies; enemies read 0) wins over observed casts.
            local cd=d.currentCd;local hostReady=type(cd)=='number'and cd>0 and cd<1e6 and now+cd or nil
            if(hostReady==nil)~=(sl.hostReady==nil)or hostReady and math.abs(hostReady-sl.hostReady)>.05 then self.revision=self.revision+1 end
            sl.hostReady=hostReady
            if slot>=4 then
                local key=summonerKey(name);sl.key=key
                holders[key]=holders[key]or {};holders[key][s.id]=slot
            end
        end
    end
    local rows=self.rows[s.id]
    for slot,row in pairs(rows)do if row.readyAt<now-1 then rows[slot]=nil;self.revision=self.revision+1 end end
end

function K:SummonerSlot(s,key)
    for slot=4,5 do local sl=s.slots[slot];if sl and sl.key==key then return slot end end
end

function K:Summoner(s,h,key,at,source)
    local slot=self:SummonerSlot(s,key);if not slot then return false end
    local row=self.rows[s.id][slot]
    if row and row.castAt and math.abs(row.castAt-at)<3 then return true end
    self:Start(s,h,slot,at,at,source);return true
end

-- Casts ---------------------------------------------------------------------
function K:Cast(s,h,now)
    local a=h.activeSpell
    if not a or a.valid==false then return end
    local start=a.startTime
    if start==nil or start==s.castStart then return end
    s.castStart=start
    local name=a.name
    if type(name)~='string'or name==''or a.isAutoAttack==true or name:lower():find('attack',1,true)then return end
    s.spellAt=now
    local slot=self:SlotFor(s,name,h.activeSpellSlot);if not slot then return end
    local sl=s.slots[slot];if not sl then return end
    s.recent[slot]={at=now,cost=sl.cost}
    if sl.pendingFrom then return end
    local finish=finite(a.castEndTime)and a.castEndTime>=start and a.castEndTime or now
    local seconds=self:Seconds(s,h,slot,sl.name,sl.level)
    self:Start(s,h,slot,finish,finish,'cast',seconds and sl.name or name)
end

function K:Mana(s,h,now)
    local mana=h.mana;if not finite(mana)then s.mana=nil;return end
    local previous=s.mana;s.mana=mana
    if not previous or previous-mana<1 then return end
    local drop=previous-mana
    for slot,r in pairs(s.recent)do
        if now-r.at>1.5 then s.recent[slot]=nil
        elseif not r.paid and near(drop,r.cost)then r.paid=true;return end
    end
    local found,count=nil,0
    for slot=0,3 do local sl=s.slots[slot]
        if sl and(sl.level or 0)>0 and not sl.pendingFrom and near(drop,sl.cost)and not self:OnCooldown(s,slot,now)then found=slot;count=count+1 end
    end
    if count==1 then
        self:Start(s,h,found,now,now,'mana');s.recent[found]={at=now,cost=s.slots[found].cost,paid=true}
    elseif count>1 then
        for slot=0,3 do local sl=s.slots[slot]
            if sl and(sl.level or 0)>0 and not sl.pendingFrom and near(drop,sl.cost)and not self:OnCooldown(s,slot,now)then self:Possible(s,h,slot,now,now,'mana')end
        end
    end
end

-- Flash ---------------------------------------------------------------------
function K:FlashParticle(check)
    local game=self.c.g.Game;if not game.ParticleCount or not game.Particle then return false end
    local ok,count=pcall(game.ParticleCount);if not ok then return false end
    for i=1,U.count(count,3000)do
        local p=game.Particle(i);local name=p and p.name
        if type(name)=='string'and name:lower():find('flash',1,true)then
            local pos=p.pos
            if pos and(U.dist(pos,check.from)<=160 or U.dist(pos,check.to)<=160)then return true end
        end
    end
    return false
end

function K:Position(s,h,now,visible,dead)
    local pos=h.pos;local x,z=pos and pos.x,pos and pos.z
    if dead or not finite(x)or not finite(z)then s.px=nil;return end
    if s.px and now-s.pAt<=.3 then
        local dx,dz=x-s.px,z-s.pz;local d=math.sqrt(dx*dx+dz*dz)
        if d>=250 and d<=520 then
            local slot=self:SummonerSlot(s,FLASH)
            local a=h.activeSpell;local casting=a and a.valid~=false and type(a.name)=='string'and not a.name:lower():find('attack',1,true)
            local dashing=h.pathing and h.pathing.isDashing==true
            if slot and not casting and not dashing and now-(s.spellAt or -10)>.6 and now-(s.recastAt or -10)>.6 and not self:OnCooldown(s,slot,now)then
                if visible and s.pVis then self:Summoner(s,h,FLASH,now,'flash')
                else s.flashCheck={from={x=s.px,z=s.pz},to={x=x,z=z},at=now,untilAt=now+.35}end
            end
        end
    end
    local check=s.flashCheck
    if check then
        if now>check.untilAt then s.flashCheck=nil
        elseif now>=(check.nextAt or 0)then
            check.nextAt=now+.1
            if self:FlashParticle(check)then s.flashCheck=nil;self:Summoner(s,h,FLASH,check.at,'flash')end
        end
    end
    s.px,s.pz,s.pAt,s.pVis=x,z,now,visible
end

-- Buffs ---------------------------------------------------------------------
-- Calls self[handler](self,ctx,key,start,now) once per new instance of a wanted
-- buff. The name is matched first; other buff fields are read only for wanted names.
-- `quietBefore`: the unit was not scanned at that time because no caster could
-- be credited then; an instance that already existed (start at or before it, or
-- an unknown start) is only marked seen, as that skipped scan would have done.
function K:EachBuff(unit,wanted,seen,now,handler,ctx,quietBefore)
    local getBuff=unit.GetBuff;if not getBuff then return end
    for i=0,U.count(unit.buffCount or 0,128)do
        local b=getBuff(unit,i);local name=b and b.name
        local key=type(name)=='string'and name~=''and wanted[lower(name)]
        if key and(b.count or b.stacks or 0)>0 then
            local known=finite(b.startTime)
            local start=known and b.startTime or now
            local tag=key..'@'..start
            if not seen[tag]then seen[tag]=now
                if not(quietBefore and(not known or start<=quietBefore))then self[handler](self,ctx,key,start,now)end
            end
        end
    end
    for tag,at in pairs(seen)do if now-at>30 then seen[tag]=nil end end
end

function K:Hero(id)return self.heroIndex and self.heroIndex[id]end

-- Holders of `key` on the enemy team, excluding those known to be on cooldown.
function K:Candidates(key,pos,range,now)
    local list={}
    for id,slot in pairs(self.holders[key]or {})do
        local s=self.states[id];local h=self:Hero(id)
        if s and h and not h.dead and not self:OnCooldown(s,slot,now)then
            local where,slack=h.pos,0
            if not h.visible then
                local seen=self.c.observations.lastSeen[id]
                if seen and seen.pos then where=seen.pos;slack=math.min(600,400*math.max(0,now-seen.at))else where=nil end
            end
            local d=where and U.dist(where,pos)or math.huge
            if d<=range+slack then list[#list+1]={s=s,h=h,d=d,visible=h.visible==true}end
        end
    end
    table.sort(list,function(a,b)return a.d<b.d end)
    return list
end

-- One holder in range is the caster; several are each a possible caster.
function K:Attribute(key,pos,range,at,now,source)
    local list=self:Candidates(key,pos,range,now)
    if #list==1 then self:Summoner(list[1].s,list[1].h,key,at,source)
    else for _,c in ipairs(list)do local slot=self:SummonerSlot(c.s,key);if slot then self:Possible(c.s,c.h,slot,at,at,source)end end end
end

function K:EnemyBuffs(s,h,now)
    local wanted=s.wanted
    if not wanted then
        wanted={};local any=false
        for buff,key in pairs(SELF_BUFFS)do if self:SummonerSlot(s,key)then wanted[buff]=key;any=true end end
        if self.holders[HEAL]and next(self.holders[HEAL])then wanted[HEAL]=HEAL;any=true end
        s.wanted=any and wanted or false;wanted=s.wanted
    end
    if not wanted then return end
    s.unit=h;self:EachBuff(h,wanted,s.buffs,now,'OnEnemyBuff',s)
end
function K:OnEnemyBuff(s,key,start,now)
    local h=s.unit
    if key==HEAL then
        local slot=self:SummonerSlot(s,HEAL)
        if slot and not self:OnCooldown(s,slot,now)then self:Summoner(s,h,HEAL,start,'heal')
        else self:Attribute(HEAL,h.pos,1000,start,now,'heal')end
    else self:Summoner(s,h,key,start,'buff')end
end

-- Where the holders of the wanted debuffs could be credited from, with the same
-- rules as Candidates (not dead, not known on cooldown, visible position or the
-- last seen one widened by the time since). Flat list: x, z, reach.
function K:Reach(wanted,now,out)
    local n=0
    for _,key in pairs(wanted)do
        for id,slot in pairs(self.holders[key]or {})do
            local s=self.states[id];local h=self:Hero(id)
            if s and h and not h.dead and not self:OnCooldown(s,slot,now)then
                local where,slack=h.pos,0
                if not h.visible then
                    local seen=self.c.observations.lastSeen[id]
                    if seen and seen.pos then where=seen.pos;slack=math.min(600,400*math.max(0,now-seen.at))else where=nil end
                end
                if where and finite(where.x)and finite(where.z)then
                    out[n+1]=where.x;out[n+2]=where.z;out[n+3]=TARGET_RANGE[key]+slack;n=n+3
                end
            end
        end
    end
    for i=#out,n+1,-1 do out[i]=nil end
    return n
end
-- Ignite and Exhaust land on our heroes. An ally no holder could have reached
-- (no candidate for Attribute) is not scanned: its scan could credit nobody.
-- The skip is remembered, so a debuff that began meanwhile stays uncredited
-- exactly as a scan at that time would have left it.
function K:TargetBuffs(allies,now)
    local wanted=self.targetWanted;local any=false
    for buff,key in pairs(TARGET_BUFFS)do
        if self.holders[key]and next(self.holders[key])then wanted[buff]=key;any=true else wanted[buff]=nil end
    end
    if not any then return end
    self.allyBuffs=self.allyBuffs or {};self.allySkipped=self.allySkipped or {}
    local reach=self.reachList or {};self.reachList=reach
    local n=self:Reach(wanted,now,reach)
    for _,a in ipairs(allies)do
        if a.visible~=false and not a.dead then
            local id=U.id(a);local p=a.pos;local near=false
            if p and finite(p.x)and finite(p.z)then
                for i=1,n,3 do local dx,dz=p.x-reach[i],p.z-reach[i+1];local r=reach[i+2]
                    if dx*dx+dz*dz<=r*r then near=true;break end
                end
            else near=true end
            if near then
                local seen=self.allyBuffs[id]or {};self.allyBuffs[id]=seen
                self:EachBuff(a,wanted,seen,now,'OnTargetBuff',a,self.allySkipped[id])
                self.allySkipped[id]=nil
            elseif id then self.allySkipped[id]=now end
        end
    end
end
-- The debuff appears 0.1-0.2 s after the caster's cooldown starts.
function K:OnTargetBuff(a,key,start,now)self:Attribute(key,a.pos,TARGET_RANGE[key],start-.15,now,'target')end

function K:Items(s,h)
    if not h.GetItemData then return end
    local first=self.c.g.ITEM_1;first=type(first)=='number'and first or 6
    local items=s.items;local n=0
    for i=first,first+6 do local d=h:GetItemData(i);local id=d and d.itemID;if type(id)=='number'and id>0 then n=n+1;items[n]=id end end
    for k=#items,n+1,-1 do items[k]=nil end
end

-- Fog -----------------------------------------------------------------------
function K:Recalled(id,at)local s=self.states[id];if s then s.recalledAt=at end end
function K:Teleported(unit,at)
    local s=self.states[U.id(unit)];local h=s and self:Hero(s.id)
    if s and h then self:Summoner(s,h,'summonerteleport',at,'teleport')end
end

function K:FogReturn(s,h,hide,now)
    local dt=now-hide.at
    if hide.dead or dt<.3 or s.recalledAt and s.recalledAt>=hide.at then return end
    local maxMana=h.maxMana;local m1=h.mana
    if not finite(maxMana)or maxMana<=0 or not finite(m1)or not finite(hide.mana)then return end
    local regen=finite(hide.regen)and hide.regen or finite(h.mpRegen)and h.mpRegen or 0
    local projected=hide.mana+regen*dt
    local capped=projected>=maxMana-1
    local spent=math.min(maxMana,projected)-m1
    -- Recasts finished in fog were seen through their names; remove their cost.
    local rows=self.rows[s.id]
    for slot=0,3 do local row=rows[slot];local sl=s.slots[slot]
        if row and row.source=='recast'and row.castAt>hide.at and sl and finite(sl.cost)then spent=spent-sl.cost end
    end
    local tolerance=math.max(6,3+.15*dt)
    local candidates={}
    for slot=0,3 do local sl=s.slots[slot]
        local row=rows[slot]
        if sl and(sl.level or 0)>0 and finite(sl.cost)and sl.cost>0 and not sl.pendingFrom and not(row and row.source=='recast'and row.castAt>hide.at)then
            local seconds=self:Seconds(s,h,slot,sl.name,sl.level)
            local from=row and not row.estimate and finite(row.readyMin)and row.readyMin or -math.huge
            if seconds and from<now-.1 then
                local lo=math.max(hide.at,from)
                candidates[#candidates+1]={slot=slot,cost=sl.cost,lo=lo,seconds=seconds,max=math.min(3,math.floor((now-lo)/math.max(seconds,.5))+1)}
            end
        end
    end
    if #candidates==0 then return end
    if capped then for _,c in ipairs(candidates)do self:Possible(s,h,c.slot,c.lo,now,'fog')end;return end
    if spent<=tolerance then return end
    -- Every count combination whose cost explains the spent mana.
    local matches={};local counts={}
    local function walk(i,sum)
        if sum>spent+tolerance then return end
        if i>#candidates then
            if math.abs(sum-spent)<=tolerance then local m={};for j=1,#candidates do m[j]=counts[j]end;matches[#matches+1]=m end
            return
        end
        for n=0,candidates[i].max do counts[i]=n;walk(i+1,sum+n*candidates[i].cost)end
    end
    walk(1,0)
    if #matches==0 then for _,c in ipairs(candidates)do self:Possible(s,h,c.slot,c.lo,now,'fog')end;return end
    for j,c in ipairs(candidates)do
        local all,any,fewest=true,false,math.huge
        for _,m in ipairs(matches)do if m[j]>0 then any=true;fewest=math.min(fewest,m[j])else all=false end end
        if all then self:Start(s,h,c.slot,c.lo+(fewest-1)*c.seconds,now,'fog')
        elseif any then self:Possible(s,h,c.slot,c.lo,now,'fog')end
    end
end

function K:Visibility(s,h,now,visible,dead)
    if visible~=s.visible then self.revision=self.revision+1 end
    if dead and s.hide then s.hide.dead=true end
    if s.visible and not visible and not dead then
        s.hide={at=now,mana=h.mana,regen=h.mpRegen}
    elseif visible and s.visible==false then
        -- The first visible tick repeats the mana frozen at hiding; the next one is true.
        s.returning=s.hide;s.hide=nil;s.mana=nil;s.returnAt=now
    elseif visible and s.returning and now>s.returnAt then
        local hide=s.returning;s.returning=nil
        self:FogReturn(s,h,hide,now);s.mana=h.mana
    end
    s.visible=visible
end

-- Tick ----------------------------------------------------------------------
function K:Tick(heroes,myTeam,now)
    local index=self.heroIndex or {};for k in pairs(index)do index[k]=nil end;self.heroIndex=index
    local allies=self.allies;for k=#allies,1,-1 do allies[k]=nil end
    -- Identity and team are read once per hero per tick and reused below.
    local ids,teams=self.tickIds,self.tickTeams
    if not ids then ids,teams={},{};self.tickIds,self.tickTeams=ids,teams end
    local count=#heroes
    for i=1,count do
        local h=heroes[i];local id=U.id(h);local team=h.team
        ids[i]=id or false;teams[i]=team
        if id then index[id]=h end
        if team==myTeam then allies[#allies+1]=h end
    end
    for i=#ids,count+1,-1 do ids[i]=nil;teams[i]=nil end
    -- Holders of heroes that left the roster are dropped (each hero's own entries
    -- are rebuilt when its slots refresh).
    if now>=(self.nextPrune or 0)then
        self.nextPrune=now+SLOT_PERIOD
        for _,list in pairs(self.holders)do for k in pairs(list)do if not index[k]then list[k]=nil end end end
    end
    for i=1,count do
        local h=heroes[i];local id=ids[i];local name=id and teams[i]~=myTeam and h.charName
        if type(name)=='string'then
            local s=self:State(h,id,name)
            -- Each hero keeps its own slot and buff periods, started at a staggered
            -- phase, so the scans spread over ticks instead of landing in one.
            if now>=s.nextSlots or not next(s.slots)then
                s.nextSlots=now+SLOT_PERIOD+(s.slotPhase or 0);s.slotPhase=nil
                for _,list in pairs(self.holders)do list[id]=nil end
                self:RefreshSlots(s,h,now)
            end
            if now>=s.nextItems then s.nextItems=now+ITEM_PERIOD;self:Items(s,h);s.wanted=nil end
            local visible,dead=h.visible==true,h.dead==true
            self:Visibility(s,h,now,visible,dead)
            if visible and not dead then
                self:Cast(s,h,now)
                if not s.returning then self:Mana(s,h,now)end
                if now>=s.nextBuffs then s.nextBuffs=now+BUFF_PERIOD;self:EnemyBuffs(s,h,now)end
            elseif not visible then s.mana=nil end
            self:Position(s,h,now,visible,dead)
        end
    end
    if now>=(self.nextTargets or 0)then self.nextTargets=now+BUFF_PERIOD;self:TargetBuffs(allies,now)end
end

function K:Rows(id)return self.rows[id]end
function K:Reset()self.states={};self.rows={};self.holders={};self.allyBuffs=nil;self.revision=self.revision+1 end
return K

end
