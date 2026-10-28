return function(require)
return function()
-- Shared Corki mechanics data. Values preserved from the maintained controller unless a source is named.
-- Normal, https://wiki.leagueoflegends.com/en-us/Corki read 2026-10-08: Q "TARGET RANGE: 825", "EFFECT RADIUS: 275",
--  "SPEED: 1100"; W "300 - 600", cast time "none", speed "650 + 100% movement speed"; E "EFFECT RADIUS: 690",
--  35 degrees; R "TARGET RANGE: 1300 / 1500", "EFFECT RADIUS: 150 / 300", width 80, speed 2000, cast 0.175.
--  rRange/bigRange were 1225 (the display override) until 2026-10-08; the installed child missiles also say
--  1300/1500 (corki-provenance.json). splash was 200 until 2026-10-08. qRadius stays 250 (installed castRadius);
--  the wiki's 275 is recorded and the smaller value is used so a counted hit is one under either reading.
--  bigBuff is the entries.json alias; a third-party script uses `mbcheck2` for the pre-rework kit. Not live-verified.
-- Classic, https://wiki.leagueoflegends.com/en-us/League_Classic/Corki read 2026-10-08: W "RANGE: 800",
--  "SPEED: 650"; E "EFFECT RADIUS: 600"; R "TARGET RANGE: 1225", "EFFECT RADIUS: 75 / 150", speed 1950, Big One
--  "increased range" without a number (bigRange stays 1225). wRange 800 = that page and the installed
--  Jade_CorkiW MaxRange 800 (research/family-assets/Jade_Corki/spells.json; it was 600 until 2026-10-08).
--  splash 75 / 150 is the page; other leads say 150 / 250 (ClassicCorki.lua) and 200 / 300 (patch V1.0.0.63), so the
--  page value is the lower bound of all leads and a counted splash hit holds under each of them.
--  Classic Q stays the installed 600-range instant spell (Jade_CorkiQ castRange 600, missileSpeed 0); the page says
--  825 lobbed at speed 1000 (the V3.14 spell). Recorded, not used.
-- eAngle (Normal only): Gatling Gun cone 35 degrees, effect radius 690 (wiki Corki read 2026-10-10). Classic E is a
--  600 radius with no angle on the page; lane E stays off for Classic until it is measured.
-- wSpeed is the dash speed WITHOUT the movement-speed part (Normal adds 100% movement speed): a floor, so a
-- consumer never assumes a faster dash than the real one. wCast 0: Normal wiki "none"; the Classic asset block has no
-- cast-time field (spells that have one carry it) and the Classic page lists none.
local D=(function()
return {
 MissileBarrage={
  ADRatio=.85,BaseDamage={90,170,250},RBigOneMissileRadius=300,
 },
 MissileBarrageMissile2={
  castRange=1500,
 },
 MissileBarrageMissile={
  castRange=1300,
 },
 PhosphorusBombMissile={
  mSpeed=1100,
 },
 PhosphorusBomb={
  ADRatio=1.25,BaseDamage={60,105,150,195,240},castRange=825,
 },
 CarpetBomb={
  DashSpeedBase=650,MaximumRange=600,MinimumRange=300,
 },
 Jade_CorkiE={
  castRange=600,
 },
 Jade_CorkiR={
  BaseDamage={120,190,260},MaxAmmoTooltip=7,
 },
 Jade_CorkiR_Missile={
  castRange=1225,
 },
 Jade_CorkiW={
  MaxRange=800,MinRange=300,
 },
 Jade_CorkiQ={
  APRatio=.5,BaseDamage={80,130,180,230,280},castRadius=250,castRange=600,
 },
}
end)()
return {
 Corki={id='normal',qRange=D.PhosphorusBomb.castRange,qSpeed=D.PhosphorusBombMissile.mSpeed,qRadius=250,qBase=D.PhosphorusBomb.BaseDamage,qAP=1,qBonusAD=D.PhosphorusBomb.ADRatio,
  rBase=D.MissileBarrage.BaseDamage,rBonusAD=D.MissileBarrage.ADRatio,rTotalAD=0,rAP=0,rMultiplier=2,rDamage='physical',
   bigBuff='corkimissilebarragecounterbig',rRange=D.MissileBarrageMissile.castRange,bigRange=D.MissileBarrageMissile2.castRange,splash=150,bigSplash=D.MissileBarrage.RBigOneMissileRadius,maxAmmo=4,eRange=690,eAngle=35,
   wName='CarpetBomb',wMinRange=D.CarpetBomb.MinimumRange,wRange=D.CarpetBomb.MaximumRange,wSpeed=D.CarpetBomb.DashSpeedBase,wCast=0,
   wSource='https://wiki.leagueoflegends.com/en-us/Corki Valkyrie range 300-600, no cast time, speed 650 + 100% movement speed (floor 650 declared), read 2026-10-08'},
 Jade_Corki={id='classic',qRange=D.Jade_CorkiQ.castRange,qSpeed=math.huge,qRadius=D.Jade_CorkiQ.castRadius,qBase=D.Jade_CorkiQ.BaseDamage,qAP=D.Jade_CorkiQ.APRatio,qBonusAD=0,
  rBase=D.Jade_CorkiR.BaseDamage,rBonusAD=0,rTotalAD=.2,rAP=.3,rMultiplier=1.5,rDamage='magical',
   bigBuff='jade_corkir_check',rRange=D.Jade_CorkiR_Missile.castRange,bigRange=D.Jade_CorkiR_Missile.castRange,splash=75,bigSplash=150,maxAmmo=D.Jade_CorkiR.MaxAmmoTooltip,eRange=D.Jade_CorkiE.castRange,
   wName='Jade_CorkiW',wMinRange=D.Jade_CorkiW.MinRange,wRange=D.Jade_CorkiW.MaxRange,wAssetMaxRange=D.Jade_CorkiW.MaxRange,wSpeed=650,wCast=0,
   wSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Corki Valkyrie RANGE 800, SPEED 650 (read 2026-10-08); research/family-assets/Jade_Corki/spells.json Jade_CorkiW MaxRange 800 / MinRange 300, no cast-time field'},
}

end
end
