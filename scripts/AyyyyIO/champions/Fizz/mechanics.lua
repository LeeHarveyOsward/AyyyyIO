return function(require)
return function()
-- Shared Fizz mechanics data. Values preserved from the maintained controller.
-- Normal R tiers (2026-10-10): the shark grows with the distance the lure travelled before it attached:
--  under 455 small, 455-910 medium, over 910 large (https://wiki.leagueoflegends.com/en-us/Fizz, read 2026-10-10;
--  thresholds not in the decoded assets). Medium x1.25 and large x1.5 of the small damage: asset FizzR DataValues
--  MidDamageMulti 1.25 / LargeDamageMulti 1.5 (research/family-assets/Fizz/spells.json), which equals the wiki's
--  225-525 (+75% AP) and 270-630 (+90% AP). `band`: inside 40 units past a threshold the lower tier is credited
--  (prediction error). Classic R has one fixed damage.
-- E timing (both profiles): Fizz is untargetable for 0.75 s and lands after it (Normal wiki 2026-10-10, Classic per
--  fizz-provenance.json eTiming); the hop transport before it is unmeasured, so 0.75 is a lower bound on the landing.
-- Normal E2 (2026-10-10): e2Radius 225 = FizzE DataValues SmallAoESize and FizzETwo mEffectAmount[3]
--  (research/family-assets/Fizz/spells.json; wiki Trickster effect radius 225, read 2026-10-10). e2Cast 0.15 =
--  FizzETwo castFrame 4.535 at 30 frames/s (same asset). The hop speed is published nowhere (wiki, assets: missileSpeed
--  20 is a placeholder), so e2Speed stays unset and the slam horizon is the cast-frame lower bound; the dev trace
--  fizz_e2_landing records seconds and hop length to settle it.
-- Normal wReachBonus 50: the W-empowered attack gains 50 bonus range (wiki Seastone Trident, read 2026-10-10).
local D=(function()
return {
 FizzE={
  BaseDamage={80,130,180,230,280},SmallAoESize=225,
 },
 FizzW={
  ActiveBaseDamage={50,75,100,125,150},ActiveDuration=4,ActiveRatio=.45,DoTBaseDamage={30,45,60,75,90},DoTRatio=.25,
 },
 FizzRMissile={
  mSpeed=1300,
 },
 FizzR={
  DetonationTime=2,LargeDamageMulti=1.5,MaxDistance=1300,MidDamageMulti=1.25,SmallAPRatio=.6,SmallDamage={180,300,420},
 },
 Jade_FizzR={
  APRatio=1,BaseDamage={200,325,450},DetonationTime=1.5,castRangeDisplayOverride=1275,
 },
 Jade_FizzRMissile={
  mSpeed=1350,
 },
 Jade_FizzW={
  ActiveBaseDamage={10,15,20,25,30},ActiveDuration=5,ActiveRatio=.2,DoTBaseDamage={30,40,50,60,70},DoTRatio=.35,MaxHealthScaling={.04,.05,.06,.07,.08},
 },
 Jade_FizzE={
  APRatio=.75,BaseDamage={70,120,170,220,270},
 },
 Jade_FizzQ={
  APRatio=.4,BaseDamage={10,40,70,100,130},
 },
}
end)()
return {
 Fizz={id='normal',q='FizzQ',w='FizzW',e='FizzE',e2='FizzETwo',buffer='FizzEBuffer',r='FizzR',
  wBuff='FizzWActive',wAttack='FizzWBasicAttack',onHit='FizzOnHitBuff',bleed='FizzWDOT',fish='FizzRCling',
  qBase={10,25,40,55,70},qAP=.55,wBase=D.FizzW.ActiveBaseDamage,wAP=D.FizzW.ActiveRatio,wDuration=D.FizzW.ActiveDuration,
  dotBase=D.FizzW.DoTBaseDamage,dotAP=D.FizzW.DoTRatio,eBase=D.FizzE.BaseDamage,eAP=.95,
  rBase=D.FizzR.SmallDamage,rAP=D.FizzR.SmallAPRatio,rRange=D.FizzR.MaxDistance,rSpeed=D.FizzRMissile.mSpeed,rDelay=D.FizzR.DetonationTime,rTiered=true,
  rTiers={near=455,far=910,band=40,mid=D.FizzR.MidDamageMulti,large=D.FizzR.LargeDamageMulti},eLanding=.75,
  e2Radius=D.FizzE.SmallAoESize,e2Cast=.15,wReachBonus=50},
 Jade_Fizz={id='classic',q='Jade_FizzQ',w='Jade_FizzW',e='Jade_FizzE',e2='Jade_FizzETwo',buffer='Jade_FizzEBuffer',r='Jade_FizzR',
  wBuff='Jade_FizzWActive',bleed='Jade_FizzWDOT',fish='Jade_FizzRCling',
  qBase=D.Jade_FizzQ.BaseDamage,qAP=D.Jade_FizzQ.APRatio,wBase=D.Jade_FizzW.ActiveBaseDamage,wAP=D.Jade_FizzW.ActiveRatio,wDuration=D.Jade_FizzW.ActiveDuration,
  dotBase=D.Jade_FizzW.DoTBaseDamage,dotAP=D.Jade_FizzW.DoTRatio,dotMissing=D.Jade_FizzW.MaxHealthScaling,eBase=D.Jade_FizzE.BaseDamage,eAP=D.Jade_FizzE.APRatio,
  rBase=D.Jade_FizzR.BaseDamage,rAP=D.Jade_FizzR.APRatio,rRange=D.Jade_FizzR.castRangeDisplayOverride,rSpeed=D.Jade_FizzRMissile.mSpeed,rDelay=D.Jade_FizzR.DetonationTime,rTiered=false,eLanding=.75},
}

end
end
