return function(require)
-- Spell and summoner cooldown model for observed enemy casts.
--
-- Champion spells: per-rank base seconds from cooldown_data.lua (installed assets,
-- separate Normal and Classic profiles), scaled by the caster's live `cdr` stat:
-- cooldown = base * (1 - cdr), running from the cast end. Live 2026-10 (Normal,
-- CooldownProbe logs 1-6): visible recasts arrived 0.00-0.08 s after this model's
-- ready time for Amumu, Kog'Maw, Lee Sin, Xerath, Ziggs and Twisted Fate.
--
-- Summoners are not in champion assets. Normal values are live ally readings
-- (Flash 300, Ignite 180, Barrier 180) or current patch notes (the rest, not yet
-- observed). Summoner haste is only partly observable: boots are read from items,
-- Cosmic Insight (18) is not, so the result is a range.
-- Classic values below are ASSUMPTIONS (older-season numbers, 0-15 % summoner
-- reduction) until a Classic game is recorded; Classic `cdr` is assumed to have the
-- same meaning as Normal.
local Data=require('CombatProfiles.cooldown_data')
local M={}

local function key(name)
    return type(name)=='string'and name:lower():gsub('^jade_',''):gsub('_jade$',''):gsub('[^%w]','')or ''
end
M.key=key

function M.profile(charName)
    return type(charName)=='string'and charName:match('^Jade_')and 'classic'or 'normal'
end

-- Summoner base seconds by normalized spell name.
M.SUMMONERS={
    normal={summonerflash=300,summonerdot=180,summonerbarrier=180,summonerheal=240,summonerhaste=240,
        summonerexhaust=240,summonerboost=240,summonerteleport=360,s12summonerteleportupgrade=330,
        summonermana=240,summonersnowball=80,summonercherryflash=300,summonercherryhold=60},
    classic={summonerflash=300,summonerdot=210,summonerbarrier=210,summonerheal=240,summonerhaste=210,
        summonerexhaust=210,summonerboost=210,summonerteleport=300,summonermana=180,summonerclairvoyance=60},
}
-- Observable summoner haste per item ID (Normal: Ionian Boots of Lucidity).
M.SUMMONER_HASTE_ITEMS={normal={[3158]=10},classic={}}
-- Unobservable reductions: upper bound of the unknown part.
M.SUMMONER_HIDDEN={normal={haste=18},classic={fraction=.15}}

-- Champions whose slots swap between forms or stolen spells: a slot name says
-- nothing about which cooldown is running, so no estimate is shown.
M.UNSUPPORTED={nidalee=true,jayce=true,elise=true,gnar=true,aphelios=true,udyr=true,hwei=true}
M.UNSUPPORTED_SLOT={sylas={[3]=true}}

-- Spells whose cooldown can end early through refunds or resets that are not
-- observable here. The model value is an upper bound, drawn with "~".
-- Live 2026-10: Ezreal Q hits refunded 1.47-1.49 s to every slot; Amumu E came back
-- up to 4.4 s early; Kog'Maw Q up to 3.3 s early (cause unknown); Anivia E 2.6 s.
-- The others are documented resets/reductions, not yet observed live.
M.REFUND={
    ezreal={[0]=true,[1]=true,[2]=true,[3]=true},amumu={[2]=true},kogmaw={[0]=true},anivia={[2]=true},
    masteryi={[0]=true},katarina={[0]=true,[1]=true,[2]=true,[3]=true},darius={[3]=true},pyke={[3]=true},
    irelia={[0]=true},zed={[1]=true},tryndamere={[0]=true},akali={[2]=true},rengar={[0]=true,[1]=true,[2]=true},
    kassadin={[3]=true},
    belveth={[0]=true,[1]=true,[2]=true},kindred={[0]=true},samira={[2]=true},viego={[3]=true},
    yasuo={[0]=true},yone={[0]=true},
}

local function champ(charName)return key(charName)end

function M.supported(charName,slot)
    local c=champ(charName)
    if M.UNSUPPORTED[c]then return false end
    local s=M.UNSUPPORTED_SLOT[c];if s and s[slot]then return false end
    return true
end

function M.refund(charName,slot)local r=M.REFUND[champ(charName)];return r and r[slot]==true or false end

local function lookup(profile,spellName)
    local rows=Data[profile];if not rows or type(spellName)~='string'then return end
    local lower=spellName:lower()
    if profile=='classic'then
        return rows[lower]or rows['jade_'..lower:gsub('^jade_','')]or rows[lower:gsub('_jade$','')]
    end
    return rows[lower]
end

-- Base seconds for `spellName` at `rank`, or nil when no verified row exists.
function M.base(profile,spellName,rank)
    local row=lookup(profile,spellName);if not row then return end
    local n=#row;if n==0 then return end
    local r=type(rank)=='number'and rank>=1 and math.floor(rank)or 1
    return row[math.min(r,n)]
end

-- Ammo/charge spells are drawn by nobody: a single cast does not empty the slot.
function M.ammo(profile,spellName)
    local rows=Data.ammo and Data.ammo[profile];if not rows or type(spellName)~='string'then return false end
    local lower=spellName:lower()
    return rows[lower]~=nil or profile=='classic'and rows['jade_'..lower:gsub('^jade_','')]~=nil
end

local function fraction(cdr)
    if type(cdr)~='number'or cdr~=cdr or cdr<0 then return 0 end
    return math.min(cdr,.8)
end

-- Champion spell cooldown in seconds after the cast; nil without data.
-- Returns seconds, estimate (true when refunds can shorten it).
function M.spell(profile,charName,slot,spellName,rank,cdr)
    if not M.supported(charName,slot)then return end
    local base=M.base(profile,spellName,rank);if not base or base<=0 then return end
    if M.ammo(profile,spellName)then return end
    return base*(1-fraction(cdr)),M.refund(charName,slot)
end

function M.isSummoner(profile,spellName)
    local rows=M.SUMMONERS[profile];return rows~=nil and rows[key(spellName)]~=nil
end

-- Summoner cooldown range: shortest, longest seconds. `items` is a list of item IDs.
function M.summoner(profile,spellName,items)
    local rows=M.SUMMONERS[profile];local base=rows and rows[key(spellName)];if not base then return end
    local haste=0;local byItem=M.SUMMONER_HASTE_ITEMS[profile]or {}
    for _,id in ipairs(items or {})do haste=haste+(byItem[id]or 0)end
    local longest=base*100/(100+haste)
    local hidden=M.SUMMONER_HIDDEN[profile]or {}
    local shortest=longest
    if hidden.haste then shortest=base*100/(100+haste+hidden.haste)end
    if hidden.fraction then shortest=longest*(1-hidden.fraction)end
    return shortest,longest
end

-- Overlay icon (OrbamaOverlay/summoners/<icon>.png) for a summoner slot name.
local ICONS={summonerflash='summonerflash',summonerdot='summonerdot',summonerbarrier='summonerbarrier',summonerheal='summonerheal',
    summonerhaste='summonerhaste',summonerexhaust='summonerexhaust',summonerboost='summonerboost',summonerteleport='summonerteleport',
    s12summonerteleportupgrade='summonerteleport',summonermana='summonermana',summonersnowball='summonersnowball',
    summonercherryflash='summonerflash'}
function M.icon(spellName)
    local k=key(spellName)
    return ICONS[k]or k:find('smite',1,true)and 'summonersmite'or nil
end

-- Text for one prepared row; nil when the slot is ready.
-- readyAt is the latest ready time, readyMin the earliest (may be in the past).
function M.text(label,readyAt,readyMin,estimate,now)
    if type(readyAt)~='number'then return end
    local hi=math.ceil(readyAt-now);if hi<=0 then return end
    local lo=type(readyMin)=='number'and math.max(0,math.ceil(readyMin-now))or hi
    if hi-lo>2 then return label..':'..lo..'-'..hi end
    return label..':'..((estimate or lo~=hi)and '~'or '')..hi
end

return M

end
