return function(require)
return function()
-- Shared Nautilus mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 NautilusSplashZone={
  DamageBase={55,90,125,160,195},castRangeDisplayOverride=600,
 },
 NautilusAnchorDragMissile={
  mCastTime=.25,mMissileWidth=90,mSpeed=2000,
 },
 NautilusAnchorDrag={
  BaseDamage={85,125,165,205,245},
 },
 NautilusGrandLine={
  PrimaryDamage={150,275,400},mCastTime=.46,
 },
 Jade_NautilusQ={
  BaseDamage={60,105,150,195,240},
 },
 Jade_NautilusQ_Missile={
  mCastTime=.25,mMissileWidth=90,mSpeed=2000,
 },
 Jade_NautilusR={
  PrimaryDamage={200,325,450},mCastTime=.46,
 },
 Jade_NautilusE={
  DamageBase={60,100,140,180,220},castRadius=400,castRangeDisplayOverride=550,
 },
}
end)()
return {
 Nautilus={id='normal',q='NautilusAnchorDrag',w='NautilusPiercingGaze',e='NautilusSplashZone',r='NautilusGrandLine',
  rCastName='NautilusGrandLineStart',shield='NautilusPiercingGazeShield',passive='NautilusPassiveCheck',root='NautilusPassiveRoot',
  qRoot='NautilusAnchorDragRoot',passiveCD=6,qBase=D.NautilusAnchorDrag.BaseDamage,qAP=.9,eBase=D.NautilusSplashZone.DamageBase,eRange=D.NautilusSplashZone.castRangeDisplayOverride,eArea=600,
   rBase=D.NautilusGrandLine.PrimaryDamage,
   -- Wiki Nautilus read 2026-10-10: Q reach 1122 (asset display range 1150), radius 90, speed 2000, cast .25; R cast .46,
   -- homing charge 275 units/s accelerating by 466.67 units/s per second, eruption radius 225 (knock-back band 300);
   -- Q is a 1 s stun. qControl lists the own Q-control buff names E and R wait for (the stun's native name is
   -- unconfirmed: dev trace nautilus_hook_buffs records the hooked target's buffs).
   qRange=1122,qRadius=D.NautilusAnchorDragMissile.mMissileWidth,qSpeed=D.NautilusAnchorDragMissile.mSpeed,qCast=D.NautilusAnchorDragMissile.mCastTime,rCast=D.NautilusGrandLine.mCastTime,rSpeed=275,rAccel=466.67,rRadius=225,
   qControl={'NautilusAnchorDragRoot'},
   geometrySource='https://wiki.leagueoflegends.com/en-us/Nautilus (read 2026-10-10)'},
 Jade_Nautilus={id='classic',q='Jade_NautilusQ',w='Jade_NautilusW',e='Jade_NautilusE',r='Jade_NautilusR',
  rCastName='Jade_NautilusR_Start',shield='Jade_NautilusW_Shield',passive='Jade_NautilusPassive_Check',root='Jade_NautilusPassive_Root',
  qRoot='Jade_NautilusQ_Root',passiveCD=9.75,qBase=D.Jade_NautilusQ.BaseDamage,qAP=.75,eBase=D.Jade_NautilusE.DamageBase,eRange=D.Jade_NautilusE.castRadius,eArea=D.Jade_NautilusE.castRangeDisplayOverride,
   rBase=D.Jade_NautilusR.PrimaryDamage,
   -- League_Classic/Nautilus read 2026-10-10: same Q (1122, width 180, speed 2000) and R geometry/charge as Normal;
   -- R cast .46, speed 275 + 466.67 per second, radius 225/300 (Classic page). Q is a 1 s stun there too.
   qRange=1122,qRadius=D.Jade_NautilusQ_Missile.mMissileWidth,qSpeed=D.Jade_NautilusQ_Missile.mSpeed,qCast=D.Jade_NautilusQ_Missile.mCastTime,rCast=D.Jade_NautilusR.mCastTime,rSpeed=275,rAccel=466.67,rRadius=225,
   qControl={'Jade_NautilusQ_Root'},
   geometrySource='https://wiki.leagueoflegends.com/en-us/League_Classic/Nautilus (read 2026-10-10)'},
}

end
end
