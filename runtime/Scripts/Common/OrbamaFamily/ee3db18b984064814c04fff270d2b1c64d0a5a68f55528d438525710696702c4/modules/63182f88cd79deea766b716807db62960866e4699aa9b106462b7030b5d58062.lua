return function(require)
return function()
-- Shared Graves mechanics data. Values preserved from the maintained controller.
-- Ranking pass 2026-10-10: Normal fullReload 2.08 s, the reload of both shells from empty
-- (https://wiki.leagueoflegends.com/en-us/Graves/LoL, page V26.17, read 2026-10-10); bounds the
-- observed-empty lease of the controller (Graves-1). Classic has no shells.
-- Classic wRadius 300: Jade_GravesW SmokeRadius (16.21 ability table, 2026-10-28; Normal reads the same field,
-- 200). The earlier 210 was the castRadius of the Jade_GravesW_Boom transport missile.
local D=(function()
return {
 GravesChargeShot={
  RBaseDamage={275,425,575},RFalloffDamage={200,320,440},RKnockbackDistance=400,
 },
 GravesQReturn={
  mMissileWidth=100,mSpeed=1600,
 },
 GravesQLineMis={
  mMissileWidth=40,mSpeed=3000,
 },
 GravesQLineSpell={
  BaseDamage={50,75,100,125,150},BaseDetonationDamage={80,125,170,215,260},FirstADRatio=.55,TerrainCollisionDelay=.2,bADDetonationRatio={.45,.6,.75,.9,1.05},castFrameSeconds=.25,castRange=800,
 },
 GravesSmokeGrenade={
  SmokeRadius=200,
 },
 GravesMove={
  DashMaxDistance=375,DashMinDistance=275,DashSpeed=750,MaxStacks=8,
 },
 Jade_GravesR={
  BulletADRatio=1.4,ConeADRatio=1,RBaseDamage={250,350,450},RFalloffDamage={140,230,320},
 },
 Jade_GravesQ_Attack={
  mMissileWidth=50,mSpeed=2000,
 },
 Jade_GravesQ={
  BaseDamage={60,95,130,165,200},FirstADRatio=.8,MultiHitPenalty=.35,castConeAngle=15.32,castFrameSeconds=.25,castRange=800,
 },
 Jade_GravesE={
  DashMovespeed=850,MaxDistance=425,
 },
 Jade_GravesW={
  SmokeRadius=300,
 },
}
end)()
return {
 Graves={id='normal',q='GravesQLineSpell',w='GravesSmokeGrenade',e='GravesMove',r='GravesChargeShot',
  qBase=D.GravesQLineSpell.BaseDamage,qAD=D.GravesQLineSpell.FirstADRatio,returnBase=D.GravesQLineSpell.BaseDetonationDamage,returnAD=D.GravesQLineSpell.bADDetonationRatio,
  qRange=D.GravesQLineSpell.castRange,qSpeed=D.GravesQLineMis.mSpeed,qRadius=D.GravesQLineMis.mMissileWidth,qDelay=D.GravesQLineSpell.castFrameSeconds,returnSpeed=D.GravesQReturn.mSpeed,returnRadius=D.GravesQReturn.mMissileWidth,wallDelay=D.GravesQLineSpell.TerrainCollisionDelay,endDelay=1,
  wRadius=D.GravesSmokeGrenade.SmokeRadius,eMin=D.GravesMove.DashMinDistance,eRange=D.GravesMove.DashMaxDistance,eSpeed=D.GravesMove.DashSpeed,grit='GravesEGrit',maxGrit=D.GravesMove.MaxStacks,
  rBase=D.GravesChargeShot.RBaseDamage,rCone=D.GravesChargeShot.RFalloffDamage,rAD=1.5,rConeAD=1.2,coneRange=735,recoil=D.GravesChargeShot.RKnockbackDistance,fullReload=2.08},
 Jade_Graves={id='classic',q='Jade_GravesQ',w='Jade_GravesW',e='Jade_GravesMove',r='Jade_GravesChargeShot',
  qBase=D.Jade_GravesQ.BaseDamage,qAD=D.Jade_GravesQ.FirstADRatio,qRange=D.Jade_GravesQ.castRange,qSpeed=D.Jade_GravesQ_Attack.mSpeed,qRadius=D.Jade_GravesQ_Attack.mMissileWidth,qAngle=D.Jade_GravesQ.castConeAngle,qPenalty=D.Jade_GravesQ.MultiHitPenalty,qDelay=D.Jade_GravesQ.castFrameSeconds,
  wRadius=D.Jade_GravesW.SmokeRadius,eMin=0,eRange=D.Jade_GravesE.MaxDistance,eSpeed=D.Jade_GravesE.DashMovespeed,grit='Jade_GravesPassive_Counter',maxGrit=10,eBuff='Jade_GravesE_Buff',
  rBase=D.Jade_GravesR.RBaseDamage,rCone=D.Jade_GravesR.RFalloffDamage,rAD=D.Jade_GravesR.BulletADRatio,rConeAD=D.Jade_GravesR.ConeADRatio,coneRange=800,recoil=0},
}

end
end
