return function(require)
return function()
-- Shared Rammus mechanics data. Values preserved from the maintained controller.
-- 2026-10-10 additions (ranking gaps Rammus-1/10/11): R damage, R prediction delay/speed and W resistances,
-- each with its installed-asset field and the wiki page read that day (rSource/wSource). Normal and Classic
-- are read from their own assets; nothing is borrowed across profiles.
return {
 Rammus={id='normal',q='PowerBall',qCancel='PowerBallCancel',w='DefensiveBallCurl',e='PuncturingTaunt',r='Tremors2',
  qBuff='PowerBall',wBuff='DefensiveBallCurl',eBuff='PuncturingTaunt',qDuration=6,wDuration=7,rKind='landing',rRadius=400,
  qBase={80,120,160,200,240},qAP=1,eMonster={80,100,120,140,160},eAP=.7,
  -- Soaring Slam landing damage and the prediction model. rDelay is the asset cast delay (the wiki says "no cast
  -- time"; the larger value is kept until the rammus_slam_flight trace settles it); rSpeed is the asset
  -- MinDashSpeed lower bound (the dash runs 900-2000). rRange is the base range; 150% of the average movement
  -- speed above 461.5 is not used until rammus_slam_flight records accepted landings beyond 800.
  rBase={150,250,350},rAP=.6,rDelay=.25,rSpeed=900,rRange=800,qKnockback=125,
  rSource='family-assets/Rammus/spells.json Tremors2 InitialDamage/APRatio/MinDashSpeed/BaseCastRange/11704a2b + wiki.leagueoflegends.com/en-us/Rammus (V26.01), read 2026-10-10',
  -- Defensive Ball Curl: flat plus a share of total armor / magic resistance.
  wArmor={27,32,37,42,47},wArmorShare={.3,.375,.45,.525,.6},wMR={20,25,30,35,40},wMRShare={.3,.375,.45,.525,.6},wDelay=.25,
  wSource='family-assets/Rammus/spells.json DefensiveBallCurl FlatBonusArmor/BonusArmorPercent/FlatBonusMR/BonusMRPercent/BuffDuration/11704a2b + wiki en-us/Rammus, read 2026-10-10'},
 Jade_Rammus={id='classic',q='Jade_RammusQ',w='Jade_RammusW',e='Jade_RammusE',r='Jade_RammusR',
  wAlias='Jade_Rammus_DefensiveBallCurl',eAlias='Jade_Rammus_PuncturingTaunt',rAlias='Jade_Rammus_Tremors2',
  qBuff='Jade_RammusQ',wBuff='Jade_RammusW',eBuff='Jade_RammusE',qDuration=7,wDuration=6,rKind='tremors',
  -- Installed asset castRadius 375; the Classic wiki page says 385. The smaller asset value is kept (it never
  -- counts an enemy the area misses); the rammus_tremors_hits trace records hit distances to settle it.
  rRadius=375,
  qBase={100,150,200,250,300},qAP=1,
  -- Tremors: one tick per second for 8 s. The delay of the first tick is unmeasured (rammus_tremors_tick trace),
  -- so no Classic R finisher is built on it.
  rTick={65,130,195},rAP=.3,
  rSource='family-assets/Jade_Rammus/spells.json Jade_RammusR BaseDamage/Duration/castRadius + wiki League_Classic/Rammus, read 2026-10-10',
  -- Defensive Ball Curl: the same flat value as armor and magic resistance (asset Armour, listed for both).
  wResist={40,60,80,100,120},wDelay=.25,
  wSource='family-assets/Jade_Rammus/spells.json Jade_RammusW Armour/Duration/11704a2b + wiki League_Classic/Rammus, read 2026-10-10'},
}

end
end
