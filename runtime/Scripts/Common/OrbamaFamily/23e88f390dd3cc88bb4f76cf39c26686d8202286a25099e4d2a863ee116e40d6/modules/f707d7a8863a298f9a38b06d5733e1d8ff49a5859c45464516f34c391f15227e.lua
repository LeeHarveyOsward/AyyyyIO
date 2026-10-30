return function(require)
return function()
-- Miss Fortune ranking data (2026-10-10). The shared rows (Q/R damage, channel, waves, buff names) stay in
-- CombatProfiles/abilities.lua M.controllers.MissFortune; this file holds the numbers added for the ranking gaps.
-- Sources, read 2026-10-10:
--   Normal wiki https://wiki.leagueoflegends.com/en-us/Miss_Fortune (V26.19 infobox)
--   Normal assets research/family-assets/MissFortune/spells.json; Classic research/family-assets/Jade_MissFortune/spells.json
-- Normal Q: cast range 550 + 100% bonus attack range (wiki; asset castRange 550) -> measured live as the attack reach
--   (myHero.range plus both bounding radii). Bounce crit when Q kills the primary: 150% (+15% with Infinity Edge, item
--   3031), asset BounceCriticalMod .5. Bounce priority: 500 within 20 deg, 500 within 40, 500 within 110, 150 within 160
--   (full angles, wiki); the order inside one tier is not published.
-- Love Tap: .5 total AD, +.1 at levels 4/7/9/11/13/20/25/30 (asset MissFortunePassive calculation), halved on minions
--   (wiki; Riot 11.20). Monsters and structures are not credited (no reviewed classification).
-- Normal E: 11.25/15/18.75/22.5/26.25 (+15% AP) magic per tick, every .25 s for 2 s (current BaseDamagePerSecond/4,
--   APRatioPerSecond .6/4, TicksPerSecond 4, BaseDuration 2), slow 40% (+6% per 100 AP), cast delay .25.
-- Classic E: asset BaseDamage 95/155/215/275/335 (+80% AP) read as the TOTAL over 2 s in 8 ticks (the smaller
--   reading; the field could be per second), MoveSpeedMod -.20/-.28/-.36/-.44/-.52, Duration 2.
-- Normal W: casting grants full Strut at once, +60/70/80/90/100 flat movement speed (wiki; asset PassiveMaxMS), kept until
--   she takes non-periodic damage. wHasteSeconds 2 is a conservative planning bound for Evade (the bonus can last
--   longer). Cast delay: asset castFrame 8 (30 fps, .267 s) as the upper bound. Classic W has no movement speed
--   (asset Jade_MissFortuneViciousStrikes: ASMod, Grievous; the Classic Strut is the uncastable passive).
-- Normal R: 30 deg cone, 1450 effect radius (wiki; asset geometry 34 deg, the narrower is used for occupancy), first wave
--   .066 s after the channel starts, waves .2036/.1781/.1583 s apart (wiki). Classic: no published cone or wave timing.
local D=(function()
return {
 MissFortuneScattershot={
  BaseSlowAmount=.4,CastDelay=.25,
 },
 MissFortuneViciousStrikes={
  PassiveMaxMS={60,70,80,90,100},castFrame=8,
 },
 MissFortuneBullets={
  castRange=1450,
 },
 Jade_MissFortuneRicochetShot={
  castRangeDisplayOverride=650,
 },
 Jade_MissFortuneScattershot={
  APRatio=.8,BaseDamage={95,155,215,275,335},mCastTime=.25,
 },
}
end)()
return {
 normal={id='normal',qReach='attack',qCrit=1.5,qCritIE=.15,ieItem=3031,
  loveTap={base=.5,step=.1,levels={4,7,9,11,13,20,25,30},minion=.5},
  tiers={{range=500,angle=20},{range=500,angle=40},{range=500,angle=110},{range=150,angle=160}},
  eTick={11.25,15,18.75,22.5,26.25},eTickAP=.15,eTicks=8,eInterval=.25,eSlow=D.MissFortuneScattershot.BaseSlowAmount,eSlowAP=.0006,eDelay=D.MissFortuneScattershot.CastDelay,
  wHaste=D.MissFortuneViciousStrikes.PassiveMaxMS,wHasteSeconds=2,wDelay=D.MissFortuneViciousStrikes.castFrame/30,
  wSource='MissFortune spells.json MissFortuneViciousStrikes PassiveMaxMS 60-100, castFrame 8; wiki Miss_Fortune Strut read 2026-10-10 (full Strut on cast); 2 s planning bound',
  rAngle=30,rRange=D.MissFortuneBullets.castRange,rFirstWave=.066,rInterval={.2036,.1781,.1583}},
 classic={id='classic',qReach=D.Jade_MissFortuneRicochetShot.castRangeDisplayOverride,
  eTotal=D.Jade_MissFortuneScattershot.BaseDamage,eAP=D.Jade_MissFortuneScattershot.APRatio,eTicks=8,eInterval=.25,eSlowRank={.2,.28,.36,.44,.52},eDelay=D.Jade_MissFortuneScattershot.mCastTime,
  rAngle=30,rRange=1400},
}

end
end
