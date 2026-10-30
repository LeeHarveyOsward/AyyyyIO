return function(require)
return function()
-- Lux mechanics, Normal and Classic kept separate (no value is borrowed across profiles).
-- Provenance: CombatProfiles/lux-provenance.json. Arrays are indexed by spell rank (passive: by champion level).
-- Ranges are the maintained conservative values (display ranges); the wiki/asset maxima are recorded in the
-- provenance file and are settled from the development trace lux_cast_reach before any range is widened.
local D=(function()
return {
 LuxPrismaticWaveMissile={
  mInitialSpeed=2200,mMissileWidth=110,
 },
 LuxPrismaticWave={
  APRatio=.4,BaseShieldAmount={40,55,70,85,100},ShieldDuration=2.5,
 },
 LuxLightBindingMis={
  castRangeDisplayOverride=1175,mMissileWidth=70,mSpeed=1200,
 },
 LuxLightBinding={
  APRatio=.75,BaseDamage={80,120,160,200,240},RootDuration=2,castFrameSeconds=.25,
 },
 LuxIlluminationPassive={
  APRatio=.35,DebuffDuration=6,
 },
 LuxLightStrikeKugel={
  BaseDamage={65,115,165,215,265},SlowZoneDuration=5,castFrameSeconds=.25,castRadius=295,castRange=1100,missileSpeed=1300,
 },
 LuxR={
  Damage={300,400,500},castRangeDisplayOverride=3340,
 },
 Jade_LuxLightBindingMis={
  castRangeDisplayOverride=1175,mMissileWidth=70,mSpeed=1200,
 },
 Jade_LuxLightBinding={
  APRatio=.7,BaseDamage={60,110,160,210,260},castFrameSeconds=.25,
 },
 Jade_LuxPrismaticWave={
  APRatio=.35,BaseShieldAmount={80,105,130,155,180},ShieldDuration=3,
 },
 Jade_LuxPrismaticWaveMissile={
  mMissileWidth=110,mSpeed=1400,
 },
 Jade_LuxR={
  APRatio=.85,Damage={300,400,500},castRangeDisplayOverride=3340,
 },
 Jade_LuxLightStrikeKugel={
  AOEradius=350,APRatio=.6,Damage={60,105,150,195,240},SlowZoneDuration=5,castFrameSeconds=.25,castRange=1000,mSpeed=1300,
 },
 Jade_LuxIlluminationPassive={
  DebuffDuration=6,
 },
}
end)()
return {
 Lux={id='normal',qCast='LuxLightBinding',wCast='LuxPrismaticWave',eCast='LuxLightStrikeKugel',
  eToggle='LuxLightstrikeToggle',rCast='LuxR',mark={'LuxIlluminatingFraulein'},
  -- Q: 80-240 +75% AP; roots the first TWO enemies for 2 s, both at full damage (no second-target factor).
  qBase=D.LuxLightBinding.BaseDamage,qAP=D.LuxLightBinding.APRatio,qSecond=1,qRoot=D.LuxLightBinding.RootDuration,qSecondRoot=2,qRange=D.LuxLightBindingMis.castRangeDisplayOverride,qSpeed=D.LuxLightBindingMis.mSpeed,qRadius=D.LuxLightBindingMis.mMissileWidth,qDelay=D.LuxLightBinding.castFrameSeconds,
  -- W: 40-100 +40% AP for 2.5 s, out and back (a unit passed twice holds two shields; one is offered).
  wBase=D.LuxPrismaticWave.BaseShieldAmount,wAP=D.LuxPrismaticWave.APRatio,wRange=1100,wSpeed=D.LuxPrismaticWaveMissile.mInitialSpeed,wRadius=D.LuxPrismaticWaveMissile.mMissileWidth,wDelay=.25,wDuration=D.LuxPrismaticWave.ShieldDuration,
  wSource='Normal W 40/55/70/85/100 +40% AP, 2.5 s, cast .25: research/family-assets/Lux/spells.json (LuxPrismaticWave BaseShieldAmount, APRatio, ShieldDuration) and https://wiki.leagueoflegends.com/en-us/Lux (read 2026-10-10, V26.04)',
  -- E: 65-265 +80% AP, asset radius 295 (wiki 310), range 1100, missile 1300, zone 5 s.
  eBase=D.LuxLightStrikeKugel.BaseDamage,eAP=.8,eRange=D.LuxLightStrikeKugel.castRange,eSpeed=D.LuxLightStrikeKugel.missileSpeed,eRadius=D.LuxLightStrikeKugel.castRadius,eDelay=D.LuxLightStrikeKugel.castFrameSeconds,eZone=D.LuxLightStrikeKugel.SlowZoneDuration,
  -- Normal Lux cannot recast during Final Spark's cast; only Classic 26.17 allows the detonation then.
  eDuringR=false,
  -- R: 300/400/500 +120% AP, 1 s cast, half-width 95 (asset lineWidth 190; wiki 200).
  rBase=D.LuxR.Damage,rAP=1.2,rRange=D.LuxR.castRangeDisplayOverride,rRadius=95,rDelay=1,
  -- Illumination: 20 + 10 per level (+35% AP), mark 6 s, consumed by an attack or R.
  pFlat=20,pLevel=10,pAP=D.LuxIlluminationPassive.APRatio,pMark=D.LuxIlluminationPassive.DebuffDuration},
 Jade_Lux={id='classic',qCast='Jade_LuxLightBinding',wCast='Jade_LuxPrismaticWave',eCast='Jade_LuxLightStrikeKugel',
  eToggle='Jade_LuxLightstrikeToggle',rCast='Jade_LuxR',mark={'Jade_LuxIlluminatingFraulein','LuxIlluminatingFraulein'},
  -- Q: 60-260 +70% AP; passes one unit, the second takes half damage and a 1 s root.
  qBase=D.Jade_LuxLightBinding.BaseDamage,qAP=D.Jade_LuxLightBinding.APRatio,qSecond=.5,qRoot=2,qSecondRoot=1,qRange=D.Jade_LuxLightBindingMis.castRangeDisplayOverride,qSpeed=D.Jade_LuxLightBindingMis.mSpeed,qRadius=D.Jade_LuxLightBindingMis.mMissileWidth,qDelay=D.Jade_LuxLightBinding.castFrameSeconds,
  -- Shield numbers for the Evade offer. Lux herself is shielded when the cast starts (Classic Patch 2:
  -- "Shield now occurs at cast time instead of after cast time"); the offer still declares the full
  -- .25 s cast, so its window starts late rather than early. The wiki lists range 1175 and speed 2400
  -- and the asset shows display range 1150 / missile 1200: wRange and wSpeed are the maintained
  -- conservative values and only decide the ally reach, not the self shield.
  wBase=D.Jade_LuxPrismaticWave.BaseShieldAmount,wAP=D.Jade_LuxPrismaticWave.APRatio,wRange=1100,wSpeed=D.Jade_LuxPrismaticWaveMissile.mSpeed,wRadius=D.Jade_LuxPrismaticWaveMissile.mMissileWidth,wDelay=.25,wDuration=D.Jade_LuxPrismaticWave.ShieldDuration,
  wSource='Classic W 80/105/130/155/180 +35% AP, 3 s, cast .25: research/family-assets/Jade_Lux/spells.json (BaseShieldAmount, APRatio, ShieldDuration) and https://wiki.leagueoflegends.com/en-us/League_Classic/Lux (2026-10-08)',
  eBase=D.Jade_LuxLightStrikeKugel.Damage,eAP=D.Jade_LuxLightStrikeKugel.APRatio,eRange=D.Jade_LuxLightStrikeKugel.castRange,eSpeed=D.Jade_LuxLightStrikeKugel.mSpeed,eRadius=D.Jade_LuxLightStrikeKugel.AOEradius,eDelay=D.Jade_LuxLightStrikeKugel.castFrameSeconds,eZone=D.Jade_LuxLightStrikeKugel.SlowZoneDuration,
  eDuringR=true,
  rBase=D.Jade_LuxR.Damage,rAP=D.Jade_LuxR.APRatio,rRange=D.Jade_LuxR.castRangeDisplayOverride,rRadius=95,rDelay=1,
  -- Illumination: 20 at level 1 to 190 at level 18, no AP (asset calc {20,190}, linear by level assumed).
  pFlat=10,pLevel=10,pAP=0,pMark=D.Jade_LuxIlluminationPassive.DebuffDuration},
}

end
end
