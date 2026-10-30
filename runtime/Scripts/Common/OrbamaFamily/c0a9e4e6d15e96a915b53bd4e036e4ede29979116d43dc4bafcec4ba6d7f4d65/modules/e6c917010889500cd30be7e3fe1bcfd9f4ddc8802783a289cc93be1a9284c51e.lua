return function(require)
return function()
-- Shared Jhin mechanics data. Values preserved from the maintained controller.
-- Reviewed 2026-10-08: qRange 550 is an EDGE range (the wiki's "Edge range" icon on TARGET RANGE: 550; the bounce
--  EFFECT RADIUS 450 carries "Centered range"; speed 1800 / 600, cast 0.25),
--  https://wiki.leagueoflegends.com/en-us/Template:Data_Jhin/Dancing_Grenade. qRangeEdge=true tells the controller to
--  add both gameplay radii for a centre-to-centre check. Live reach is not yet measured.
local D=(function()
return {
 JhinE={
  BaseDamage={20,80,140,200,260},ReducedDamagePercent=.65,TrapAoERadius=260,TrapArmTime=.75,TrapDetonationTime=2,TrapTriggerRadius=160,castRange=750,mCastTime=.25,
 },
 JhinETrap={
  mSpeed=1600,
 },
 JhinPassive={
  ReloadTime=2.5,
 },
 JhinR={
  ADRatio=.25,Damage={64,128,192},FourthShotMultiplier=2,MInimumDelayBetweenShots=1,PercentMissingAmp=3,
 },
 JhinRShotMis={
  mMissileWidth=80,mSpeed=5000,
 },
 JhinRShot={
  castRangeDisplayOverride=3500,
 },
 JhinW={
  BaseDamage={70,105,140,175,210},mCastTime=.75,mLineWidth=40,
 },
 JhinQ={
  ADRatio={.44,.515,.59,.665,.74},BaseDamage={44,69,94,119,144},BounceRange=450,NumberOfBounces=3,PercentAmpOnKill=.35,castRange=550,
 },
}
end)()
return {Jhin={id='normal',q='JhinQ',w='JhinW',e='JhinE',r='JhinR',rShot='JhinRShot',
 qBase=D.JhinQ.BaseDamage,qAD=D.JhinQ.ADRatio,qAP=.6,qRange=D.JhinQ.castRange,qRangeEdge=true,qBounces=D.JhinQ.NumberOfBounces,qBounce=D.JhinQ.BounceRange,qAmp=D.JhinQ.PercentAmpOnKill,
 wBase=D.JhinW.BaseDamage,wAD=.5,wRange=2500,wDelay=D.JhinW.mCastTime,wSpeed=5000,wRadius=D.JhinW.mLineWidth,mark='jhinespotteddebuff',
 -- E arming: asset TrapArmTime .75 against the wiki's 1 s (V26.16). Until the dev trace jhin_trap_spawn settles it,
 -- the conservative 1 s is used (an enemy freed before the trap arms walks out); eArmAsset keeps the asset value.
 -- E damage 20/80/140/200/260 +120% AD +100% AP magic, 65% to minions (asset JhinE BaseDamage/ReducedDamagePercent).
 eRange=D.JhinE.castRange,eArm=1,eArmAsset=D.JhinE.TrapArmTime,eDetonation=D.JhinE.TrapDetonationTime,eRadius=D.JhinE.TrapAoERadius,eTrigger=D.JhinE.TrapTriggerRadius,eSpeed=D.JhinETrap.mSpeed,eCast=D.JhinE.mCastTime,
 eBase=D.JhinE.BaseDamage,eAD=1.2,eAP=1,eMinion=D.JhinE.ReducedDamagePercent,
 rBase=D.JhinR.Damage,rAD=D.JhinR.ADRatio,rMissing=D.JhinR.PercentMissingAmp,rFourth=D.JhinR.FourthShotMultiplier,rRange=D.JhinRShot.castRangeDisplayOverride,rSpeed=D.JhinRShotMis.mSpeed,rRadius=D.JhinRShotMis.mMissileWidth,rDelay=.25,rInterval=D.JhinR.MInimumDelayBetweenShots,rHalfAngle=30.6,
 reload='JhinPassiveReload',passive='JhinPassiveAttackBuff',reloadTime=D.JhinPassive.ReloadTime}}

end
end
