return function(require)
-- Extents set by the cast itself (catalogue `charge`, see docs/ORBAMA-EVADE.md "Charged and
-- stat-scaled extents, growing areas, speed steps"). A charged ability's reach or radius grows
-- linearly from `min` at the charge start to `max` after `full` seconds; the value is fixed at
-- the release. A stat-scaled one is `factor` x the caster's stat (move speed) at the cast.
--
-- * Charge start: the observed activeSpell start of one of the record's own charge casts
--   (`casts`), kept per caster. While a start may still be running (within `hold` + grace) a
--   later sample of the same cast keeps the earliest start, so a recast that reports the
--   same name never shortens the charge. Unknown start: the maximum (the safe side).
-- * Release: the release cast's start, or the first sighting of the released projectile
--   (late sightings only lengthen the charge).
-- * Move speed: sampled every `sample` s for casters whose profile has a stat row, the
--   largest sample of the last `window` s and the read at the cast (an upper bound of the
--   game's average). Unreadable: the row's own value, reported as `stat_unknown`.
-- Linear laws are upper bounds of the stepped game formulas they cite (docs).
local G=require('evade.geometry')
local E={grace=.25,sample=.25,ring=12}
-- Value of a linear law after `elapsed` seconds of charge.
function E.Law(spec,elapsed)
    if not G.finite(elapsed)then return spec.max end
    local u=math.max(0,math.min(1,elapsed/spec.full))
    return spec.min+(spec.max-spec.min)*u
end
function E.Valid(spec)
    if type(spec)~='table'or(spec.key~='range'and spec.key~='radius')then return nil,'invalid_extent'end
    if spec.stat~=nil then
        if spec.stat~='ms'or not G.finite(spec.factor)or spec.factor<=0 or spec.factor>10
            or not G.finite(spec.window)or spec.window<0 or spec.window>10 then return nil,'invalid_stat_extent'end
        return true
    end
    if type(spec.casts)~='table'or not G.finite(spec.min)or not G.finite(spec.max)or spec.min<0 or spec.max<=spec.min
        or not G.finite(spec.full)or spec.full<=0 or not G.finite(spec.hold)or spec.hold<spec.full or spec.hold>10 then
        return nil,'invalid_charge_extent'end
    return true
end
-- Charge casts of a profile (lower-case names), built once per loaded set; false: none.
function E.Index(set)
    local index=set.__chargeIndex
    if index~=nil then return index end
    index={casts={},stat=false};local any=false
    for _,r in pairs(set)do
        local spec=type(r)=='table'and r.name and r.charge
        if type(spec)=='table'then
            any=true
            if spec.stat then index.stat=true end
            -- Longest hold among the rows that read this cast: how long a start may still run.
            for _,name in ipairs(spec.casts or {})do if type(name)=='string'and G.finite(spec.hold)then
                local key=name:lower();index.casts[key]=math.max(index.casts[key]or 0,spec.hold)
            end end
        end
    end
    if not any then index=false end
    set.__chargeIndex=index
    return index
end
-- A sampled cast of the owner: remember the start of a charge cast (one entry per caster).
function E.Cast(o,ownerID,lower,spell,index,now)
    local hold=index.casts[lower]
    if not hold then return end
    local start=spell.startTime
    if not G.finite(start)or start<=0 then start=spell.castStartTime end
    if not G.finite(start)or start<=0 or start>now+.1 then return end
    local starts=o.chargeStarts;if not starts then starts={};o.chargeStarts=starts end
    local entry=starts[ownerID]
    if entry and entry.name==lower and start>=entry.start and start-entry.start<=entry.hold then return end
    if not entry then entry={};starts[ownerID]=entry end
    entry.name,entry.start,entry.hold=lower,start,hold+E.grace
end
-- Move speed samples of a caster with a stat row; one read every `sample` seconds.
function E.Sample(o,owner,ownerID,now)
    local rings=o.statSamples;if not rings then rings={};o.statSamples=rings end
    local ring=rings[ownerID]
    if not ring then ring={at={},value={},next=1,last=-math.huge};rings[ownerID]=ring end
    if now-ring.last<E.sample then return end
    ring.last=now
    local ms=owner.ms
    if G.finite(ms)and ms>0 then
        local i=ring.next;ring.at[i],ring.value[i]=now,ms;ring.next=i%E.ring+1
    end
end
local function statValue(o,owner,ownerID,spec,now)
    local best=owner and owner.ms
    if not G.finite(best)or best<=0 then best=nil end
    local ring=o.statSamples and o.statSamples[ownerID]
    if ring then
        for i=1,E.ring do
            local at,v=ring.at[i],ring.value[i]
            if at and now-at<=spec.window and(not best or v>best)then best=v end
        end
    end
    return best
end
-- The extent of a release at `release` (seconds) and how it was found. `fallback` is the
-- row's own value (used only for an unreadable stat).
function E.Value(o,owner,ownerID,spec,release,now,fallback)
    if spec.stat then
        local stat=statValue(o,owner,ownerID,spec,now)
        if not stat then return fallback,'stat_unknown'end
        return spec.factor*stat,'stat',stat
    end
    local entry=o.chargeStarts and o.chargeStarts[ownerID]
    if entry and G.finite(release)then
        local matches=false
        for _,name in ipairs(spec.casts)do if name==entry.name then matches=true;break end end -- compiled lower-case
        local elapsed=release-entry.start
        if matches and elapsed>=-E.grace and elapsed<=spec.hold+E.grace then
            return E.Law(spec,math.max(0,elapsed)),'charge',math.max(0,elapsed)
        end
    end
    return spec.max,'charge_unknown'
end
return E

end
