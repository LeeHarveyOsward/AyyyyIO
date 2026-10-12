return function(require)
return function()
-- Shared JarvanIV mechanics data. Values preserved from the maintained controller.
-- 2026-10-08: W radius, Q cast time, R numbers, E area and the W shield were read from the matching wiki page of
-- each profile (`source`). Geometry used for prediction (Q radius 70, E radius 175, E flight) stays in the controller.
-- Classic W radius: the installed asset says castRadius 400 (research/family-assets/Jade_JarvanIV/spells.json:891),
-- the Classic page says 600. Both are recorded; the smaller one is used until a live cast settles it.
-- eqReach (2026-10-10): the largest E flag distance the E+Q dash is planned for. Q edge range 785, width 136 and
-- flag radius 65 (both wikis, read 2026-10-10) bound it near 785-850, but the real Q-to-flag limit is not
-- measured: 740 is the conservative value the controller has always used. The dev trace jarvan_eq_reach records
-- flag distance and landing for every sequence, and for the player's own Q to an own flag (manual=true, any distance,
-- the only way a flag beyond 740 is observed), until own play settles it. eRange 860 (both wikis).
return {
 JarvanIV={id='normal',q='JarvanIVDragonStrike',w='JarvanIVGoldenAegis',e='JarvanIVDemacianStandard',r='JarvanIVCataclysm',
  qBase={90,130,170,210,250},qAD=1.45,eBase={80,120,160,200,240},eAP=.8,rAD=1.8,wRange=600,flagName='jarvanivstandard',
  qDelay=.4,eRadius=200,rBase={200,325,450},rRange=650,rArena=350,rLeap=.35,eqReach=740,eRange=860,
  wShield={60,80,100,120,140},wShieldAD=.7,wShieldHealthPerChampion=.013,wDuration=4,wDelay=0,
  source='https://wiki.leagueoflegends.com/en-us/Jarvan_IV and Template:Data_Jarvan_IV/Golden_Aegis (read 2026-10-08)'},
 Jade_JarvanIV={id='classic',q='Jade_JarvanIVDragonStrike',w='Jade_JarvanIVGoldenAegis',e='Jade_JarvanIVDemacianStandard',r='Jade_JarvanIVCataclysm',
  qBase={70,115,160,205,250},qAD=1.2,eBase={60,105,150,195,240},eAP=.8,rAD=1.5,wRange=400,wRangeWiki=600,
  qDelay=.4,eRadius=200,rBase={200,325,450},rRange=650,rArena=350,rLeap=.35,eqReach=740,eRange=860,
  wShield={50,90,130,170,210},wShieldPerChampion={20,25,30,35,40},wDuration=5,wDelay=0,
  source='https://wiki.leagueoflegends.com/en-us/League_Classic/Jarvan_IV (read 2026-10-08); shield values also research/family-assets/Jade_JarvanIV/spells.json:774-813'},
}

end
end
