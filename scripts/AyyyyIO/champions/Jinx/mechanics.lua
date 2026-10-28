return function(require)
return function()
-- Shared Jinx mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 JinxWMissile={
  mCastTime=.6,mMissileWidth=60,mSpeed=3300,
 },
 JinxW={
  ADRatio=1.4,Damage={10,60,110,160,210},JinxLowEndWCastTime=.4,JinxWASpeedCastTimeScalarPerHundrethSecond=.08,castRangeDisplayOverride=1450,
 },
 JinxEHit={
  mMissileWidth=120,
 },
 JinxE={
  GrenadeArmTime=.5,GrenadeDuration=5,castRange=925,missileSpeed=1750,
 },
 JinxQ={
  MinigunAttackSpeedDuration=2.5,MinigunAttackSpeedMax={30,55,80,105,130},MinigunAttackSpeedStacks=3,RocketAoERadius=250,RocketBonusRange={100,125,150,175,200},RocketTAD=1.1,
 },
 JinxR={
  AoEDamageMult=.8,AoERadius=400,BaseDamage={20,35,50},MaxDamage={200,350,500},MonsterExecuteMax=1200,PercentDamage={25,30,35},castRange=25000,mCastTime=.6,mMissileWidth=140,mSpeed=1700,
 },
}
end)()
return {Jinx={id='normal',q='JinxQ',w='JinxW',e='JinxE',r='JinxR',
 qRange=D.JinxQ.RocketBonusRange,qSplash=D.JinxQ.RocketAoERadius,qAD=D.JinxQ.RocketTAD,qMana=20,qStacks=D.JinxQ.MinigunAttackSpeedStacks,qStackLife=D.JinxQ.MinigunAttackSpeedDuration,qAS=D.JinxQ.MinigunAttackSpeedMax,
 wBase=D.JinxW.Damage,wAD=D.JinxW.ADRatio,wRange=D.JinxW.castRangeDisplayOverride,wSpeed=D.JinxWMissile.mSpeed,wRadius=D.JinxWMissile.mMissileWidth,wMin=D.JinxW.JinxLowEndWCastTime,wBaseDelay=D.JinxWMissile.mCastTime,wASScalar=D.JinxW.JinxWASpeedCastTimeScalarPerHundrethSecond,
 -- eEffect: chomper effect radius 225 (wiki Jinx V26.16, read 2026-10-10); land/arm timing stays the asset-based
 -- conservative 0.5 + d/1750 + 0.5 until the jinx_e_land trace measures it (wiki: no cast time, lands after 0.4 s).
 eRange=D.JinxE.castRange,eArm=D.JinxE.GrenadeArmTime,eDuration=D.JinxE.GrenadeDuration,eSpeed=D.JinxE.missileSpeed,eDelay=.5,eRadius=D.JinxEHit.mMissileWidth,eEffect=225,
 rMin=D.JinxR.BaseDamage,rMax=D.JinxR.MaxDamage,rMinAD=.12,rMaxAD=1.2,rMissing={D.JinxR.PercentDamage[1]/100,D.JinxR.PercentDamage[2]/100,D.JinxR.PercentDamage[3]/100},rSplash=D.JinxR.AoERadius,rSecondary=D.JinxR.AoEDamageMult,
 -- rMonsterCap: missing-health part against monsters (spells.json JinxR MonsterExecuteMax 1200; wiki V26.16).
 rMonsterCap=D.JinxR.MonsterExecuteMax,rRange=D.JinxR.castRange,rRadius=D.JinxR.mMissileWidth,rDelay=D.JinxR.mCastTime,rSpeed=D.JinxR.mSpeed,rDamageDistance=1500}}

end
end
