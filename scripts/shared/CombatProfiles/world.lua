return function(require)
-- Extracted from the LHO profile. Preserve its documented verification limits.
local P={}
-- Every inventory item whose active places a ward an ally can jump to, per
-- profile. The one table for all ward-jumping champions (ChampionMobility/wards
-- reads it through the champion profile; OrbamaUtils' ward service directly).
-- Source of the ids: the installed client's item data (research/shop/en_US.json,
-- 16.17.1, read 2026-10-08), every item whose description places a ward; Normal
-- = items of map 11, Classic = items of map 453 (ids 770000 + the era's id).
-- Kind = how the host represents what is left:
--   'charge'   recharging charges (trinket, Sightstone, support item)
--   'stack'    purchased consumable wards, one per stack
--   'stored'   Control Wards held inside a Wardstone
--   'cooldown' one ward per cooldown, no charges (Wriggle's Lantern)
-- Not sources: 3363 Farsight Alteration (its ward "is untargetable to allies",
-- https://wiki.leagueoflegends.com/en-us/Farsight_Alteration, read 2026-10-08),
-- 3364 Oracle Lens and 773348 Red Trinket (sweepers), 3330 Scarecrow Effigy
-- (an effigy, not a ward), 4643 Vigilant Wardstone (raises ward caps, no active).
P.wards={
    normal={id='normal',yellowWard=3340,vision={[2055]=true},
        wards={[2055]='stack',  -- Control Ward
            [2056]='stack',     -- Stealth Ward (consumable; not sold on map 11, kept for modes that grant it)
            [3340]='charge',    -- Stealth Ward trinket
            -- Support items with a ward active: the current line ...
            [3866]='charge',[3867]='charge',[3869]='charge',[3870]='charge',[3871]='charge',[3876]='charge',[3877]='charge',
            -- ... and the retired line, still present in the item data.
            [3851]='charge',[3853]='charge',[3855]='charge',[3857]='charge',[3859]='charge',[3860]='charge',[3863]='charge',[3864]='charge',
            [4638]='stored',[4641]='stored'}}, -- Watchful / Stirring Wardstone
    classic={id='classic',yellowWard=773340,vision={[772043]=true},wardInventoryCharges={[772045]=true,[772049]=true},
        wards={[772043]='stack',    -- Vision Ward
            [772044]='stack',       -- Sight Ward
            [772045]='charge',      -- Ruby Sightstone
            [772049]='charge',      -- Sightstone
            [772050]='stack',       -- Explorer's Ward
            [773154]='cooldown',    -- Wriggle's Lantern
            [773160]='cooldown',    -- Feral Flare
            [773340]='charge'}}}    -- Yellow Trinket
P.wardExcluded={[3363]=true,[3364]=true,[3330]=true,[4643]=true,[773348]=true}
-- Item-spell names that place a jumpable ward, for an item id the tables above
-- do not know. Names are the long-standing public spell names of these actives;
-- they are NOT read from installed assets (the repository extracts no item
-- spells), and Classic items report '<id>Spell'. The shared resolver matches
-- numeric native names only against the active profile's ward IDs. Farsight ('TrinketOrb') and
-- sweepers are deliberately absent.
local wardSpells={{'trinkettotem','charge',1},{'itemghostward','charge',2},{'jammerdevice','stack',6},{'visionward','stack',6},
    {'sightward','stack',4},{'itemminiward','stack',4},{'wrigglelantern','cooldown',3}}
function P.wardSpellKind(name)
    if type(name)~='string'then return nil end
    name=name:lower()
    if name=='' or name:find('trinketorb',1,true) or name:find('sweep',1,true) or name:find('farsight',1,true) then return nil end
    for _,row in ipairs(wardSpells) do if name:find(row[1],1,true) then return row[2],row[3] end end
end
-- Spend order, lowest first. Rule: the free trinket charge, then other
-- recharging charges (Sightstone, support item), then a cooldown item, then
-- purchased sight wards, then Control Wards stored in a Wardstone, and a
-- Control / Vision ward stack only when it is the only source.
function P.wardRank(profile,itemID,kind)
    if itemID==profile.yellowWard then return 1 end
    if profile.vision and profile.vision[itemID] then return 6 end
    return kind=='charge' and 2 or kind=='cooldown' and 3 or kind=='stack' and 4 or 5
end
-- Placed ward objects by unit name (lower case, 'Jade_' prefix removed by the
-- caller or here). Wriggle's Lantern and Feral Flare place a 'SightWard'.
-- Sources: OrbamaUtils observations (live names), live 2026-10-08 'YellowTrinket'.
local wardObjects={sightward=true,visionward=true,jammerdevice=true,yellowtrinket=true,yellowtrinketupgrade=true,
    bluetrinket=true,farsightward=true,zombieward=true,controlward=true,stealthward=true}
local notJumpable={bluetrinket=true,farsightward=true,zombieward=true}
local function unitName(name) return (name or ''):lower():gsub('^jade_',''):gsub('[^%w]','') end
function P.wardObject(name)
    name=unitName(name)
    return wardObjects[name] or name:find('ward',1,true)~=nil or name:find('trinket',1,true)~=nil or name:find('totem',1,true)~=nil
end
function P.wardJumpable(name)
    name=unitName(name)
    return P.wardObject(name) and not notJumpable[name]
end
P.classicSmiteTargets={s3lizardelder=true,s3ancientgolem=true,lizardelder=true,ancientgolem=true,
    giantwolf=true,wraith=true,greatwraith=true,golem=true,wight=true,red=true,blue=true}
P.normalSmiteTargets={srured=true,srublue=true,srumurkwolf=true,srurazorbeak=true,
    srukrug=true,srugromp=true,srucrab=true,sruscuttlecrab=true,red=true,blue=true}
P.smites={summonersmite=600,s5summonersmiteplayerganker=1000,s5summonersmiteduel=1000,
    summonersmiteavataroffensive=1400,summonersmiteavatarutility=1400,summonersmiteavatardefensive=1400}
P.epics={Dragon=true,Elder=true,Baron=true,Herald=true,Grubs=true,Atakhan=true}
-- Seconds after camp death, not first-spawn times. Boss values are estimates
-- until a native transition is recorded; see docs/LHO-R17-PLAYTEST.md.
P.respawns={}
for profile,rows in pairs(require('CombatProfiles.camp_timing'))do
 P.respawns[profile]={};for category,row in pairs(rows)do P.respawns[profile][category]=row.respawn end
end
function P.category(name)
    name=(name or ''):lower()
    if name:find('dragon',1,true) then return name:find('elder',1,true) and 'Elder' or 'Dragon' end
    if name:find('baron',1,true) then return 'Baron' end
    if name:find('herald',1,true) then return 'Herald' end
    if name:find('horde',1,true) or name:find('voidgrub',1,true) then return 'Grubs' end
    if name:find('atakhan',1,true) then return 'Atakhan' end
    if name:find('ancientgolem',1,true) or name:find('sru_blue',1,true) then return 'Blue' end
    if name:find('lizardelder',1,true) or name:find('sru_red',1,true) then return 'Red' end
    if name:find('crab',1,true) or name:find('scuttle',1,true) then return 'River' end
    if name:find('wight',1,true) or name:find('greatwraith',1,true) then return 'Wight' end
    if name:find('wraith',1,true) then return 'Wraiths' end
    if name:find('gromp',1,true) then return 'Gromp' end
    if name:find('wolf',1,true) or name:find('wolves',1,true) then return 'Wolves' end
    if name:find('razorbeak',1,true) or name:find('raptor',1,true) then return 'Raptors' end
    if name:find('krug',1,true) then return 'Krugs' end
    if name:find('golem',1,true) then return 'Golems' end
    return 'Camp'
end
function P.jungleEntity(unit)
    local name=(unit and unit.charName or ''):lower()
    -- Map assets also contain non-camp props / the moving blue-buff spirit.
    -- Their names must not revive a cleared camp or become routing anchors.
    return name~='sru_spiritwolf' and name~='sru_baronspawn' and not name:find('_prop',1,true)
        and not name:find('plant',1,true)
end
return P

end
