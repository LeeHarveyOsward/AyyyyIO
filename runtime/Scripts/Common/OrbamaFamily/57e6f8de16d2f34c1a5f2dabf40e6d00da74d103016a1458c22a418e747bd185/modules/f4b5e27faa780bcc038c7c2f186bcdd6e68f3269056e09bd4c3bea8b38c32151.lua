return function(require)
-- Shared summoner provenance. Range is blink displacement in world units;
-- native cast range is a different field and cannot certify a landing.
return {
 normal={name='SummonerFlash',displacement=400,castDelay=.05,verified=true,
  source='name: FamilyTelemetry spell/hero_spell rows, Normal LeeSin session (experiments/log-mining-evade-20260929/snap); '
   ..'displacement: 400-unit Normal Flash as already relied on by LHO insec; DDragon 16.17.1 range 425 is cast range, not displacement; '
   ..'castDelay .05 s is a conservative server allowance, Flash has no cast time'},
 classic={name='SummonerFlash_Jade',displacement=400,castDelay=.05,verified=true,
  source='name: LHO live playtest spell rows 2026-09-09 map 453 (host range field 425 = indicator); '
   ..'displacement 400 and no cast time: installed Classic asset Global.wad e53bc00a (content 16.20, read 2026-10-10) '
   ..'and wiki League_Classic/Summoner_Spells (2026-09-23); live landing confirmation pending (own_dash recorder)'},
}

end
