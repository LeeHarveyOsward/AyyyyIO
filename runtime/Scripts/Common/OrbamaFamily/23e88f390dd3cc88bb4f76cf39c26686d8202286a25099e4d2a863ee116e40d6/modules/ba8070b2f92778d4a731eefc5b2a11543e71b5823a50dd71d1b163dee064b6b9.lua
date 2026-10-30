return function(require)
return function()
-- Shared Rammus mechanics data. Values preserved from the maintained controller.
-- 2026-10-10 additions (ranking gaps Rammus-1/10/11): R damage, R prediction delay/speed and W resistances,
-- each with its installed-asset field and the wiki page read that day (rSource/wSource). Normal and Classic
-- are read from their own assets; nothing is borrowed across profiles.
local D=(function()
return {
 DefensiveBallCurl={
  BuffDuration=7,
 },
 PowerBall={
  KnockbackDistance=125,QBaseDamage={80,120,160,200,240},RollDuration=6,
 },
 Tremors2={
  APRatio=.6,BaseCastRange=800,InitialDamage={150,250,350},MinDashSpeed=900,
 },
 PuncturingTaunt={
  APRatio=.7,MonsterDamage={80,100,120,140,160},
 },
 Jade_RammusQ={
  AOEDamage={100,150,200,250,300},Duration=7,
 },
 Jade_RammusW={
  Duration=6,
 },
 Jade_RammusR={
  castRadius=375,
 },
}
end)()
return {
 Rammus={id='normal',q='PowerBall',qCancel='PowerBallCancel',w='DefensiveBallCurl',e='PuncturingTaunt',r='Tremors2',
  qBuff='PowerBall',wBuff='DefensiveBallCurl',eBuff='PuncturingTaunt',qDuration=D.PowerBall.RollDuration,wDuration=D.DefensiveBallCurl.BuffDuration,rKind='landing',rRadius=400,
  qBase=D.PowerBall.QBaseDamage,qAP=1,eMonster=D.PuncturingTaunt.MonsterDamage,eAP=D.PuncturingTaunt.APRatio,
  -- Soaring Slam landing damage and the prediction model. rDelay is the asset cast delay (the wiki says "no cast
  -- time"; the larger value is kept until the rammus_slam_flight trace settles it); rSpeed is the asset
  -- MinDashSpeed lower bound (the dash runs 900-2000). rRange is the base range; 150% of the average movement
  -- speed above 461.5 is not used until rammus_slam_flight records accepted landings beyond 800.
  rBase=D.Tremors2.InitialDamage,rAP=D.Tremors2.APRatio,rDelay=.25,rSpeed=D.Tremors2.MinDashSpeed,rRange=D.Tremors2.BaseCastRange,qKnockback=D.PowerBall.KnockbackDistance,
  rSource='family-assets/Rammus/spells.json Tremors2 InitialDamage/APRatio/MinDashSpeed/BaseCastRange/11704a2b + wiki.leagueoflegends.com/en-us/Rammus (V26.01), read 2026-10-10',
  -- Defensive Ball Curl: flat plus a share of total armor / magic resistance.
  wArmor={25,30,35,40,45},wArmorShare={.3,.35,.4,.45,.5},wMR={20,25,30,35,40},wMRShare={.3,.35,.4,.45,.5},wDelay=.25,
  wSource='Current installed DefensiveBallCurl FlatBonusArmor/BonusArmorPercent/FlatBonusMR/BonusMRPercent; implementation/family/current-patch.json'},
 Jade_Rammus={id='classic',q='Jade_RammusQ',w='Jade_RammusW',e='Jade_RammusE',r='Jade_RammusR',
  wAlias='Jade_Rammus_DefensiveBallCurl',eAlias='Jade_Rammus_PuncturingTaunt',rAlias='Jade_Rammus_Tremors2',
  qBuff='Jade_RammusQ',wBuff='Jade_RammusW',eBuff='Jade_RammusE',qDuration=D.Jade_RammusQ.Duration,wDuration=D.Jade_RammusW.Duration,rKind='tremors',
  -- Installed asset castRadius 375; the Classic wiki page says 385. The smaller asset value is kept (it never
  -- counts an enemy the area misses); the rammus_tremors_hits trace records hit distances to settle it.
  rRadius=D.Jade_RammusR.castRadius,
  qBase=D.Jade_RammusQ.AOEDamage,qAP=1,
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
