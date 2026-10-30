return function(require)
-- Champion experience thresholds: total experience at which each level starts.
-- Source: https://wiki.leagueoflegends.com/en-us/Experience_(champion), Summoner's
-- Rift table, cumulative column (thresholds last changed in V3.14), read 2026-10-29.
-- Only the Normal profile on Summoner's Rift (map 11) is sourced. Howling Abyss has
-- a different table and the Classic profile has none recorded: progress there is
-- unknown, never borrowed.
local E={}
local RIFT={0,280,660,1140,1720,2400,3180,4060,5040,6120,7300,8580,9960,11440,13020,14700,16480,18360}
E.tables={normal={[11]=RIFT}}
local function finite(n)return type(n)=='number'and n==n and math.abs(n)<math.huge end
-- Fraction of the current level completed, or nil and a reason. `exp` is read as
-- total experience; a value outside the level's own interval (zero, a per-level
-- count, a sentinel) is not credible.
function E.progress(profile,map,level,exp)
    local t=E.tables[profile]and E.tables[profile][map]
    if not t then return nil,'no_sourced_table'end
    if not finite(level)or level%1~=0 or level<1 or level>#t then return nil,'level_unknown'end
    if level==#t then return nil,'max_level'end
    if not finite(exp)or exp<=0 then return nil,'experience_unknown'end
    local low,high=t[level],t[level+1]
    if exp<low or exp>=high then return nil,'experience_inconsistent'end
    return(exp-low)/(high-low)
end
return E

end
