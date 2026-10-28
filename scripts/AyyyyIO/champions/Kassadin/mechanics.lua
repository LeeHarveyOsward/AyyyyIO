return function(require)
return function()
-- Shared Kassadin mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 ForcePulse={
  APRatio=.7,BaseDamage={70,100,130,160,190},
 },
 NullLance={
  BaseDamage={65,95,125,155,185},ShieldAmount={80,110,140,170,200},ShieldDuration=1.5,mCastTime=.25,mSpeed=1400,
 },
 NetherBlade={
  ActiveBaseDamage={50,75,100,125,150},PassiveBaseDamage=25,
 },
 RiftWalk={
  APRatio=.5,APStackRatio=.07,CastRange=500,MaxStacks=4,RBaseCost=40,RBaseDamage={80,95,110},RManaRatio=2,RStackDuration=15,RStackManaRatio=1,StackDamage={35,45,55},castRadius=270,mCastTime=.25,
 },
 Jade_KassadinE={
  APRatio=.7,Damage={80,130,180,230,280},
 },
 Jade_KassadinQ={
  APRatio=.7,BaseDamage={80,130,180,230,280},mCastTime=.25,mSpeed=1400,
 },
 Jade_KassadinR={
  APRatio=.8,AdditionalManaPerCast=100,BuffDuration=8,Damage={60,70,80},MaxDistance=700,MaxStacks=10,castRadius=270,mCastTime=.25,
 },
}
end)()
return {
 Kassadin={id='normal',q='NullLance',w='NetherBlade',e='ForcePulse',r='RiftWalk',wBuff='NetherBladeBuff',
  rBuff='RiftWalk',rRange=D.RiftWalk.CastRange,rBaseCost=D.RiftWalk.RBaseCost,rCostKind='double',rMax=D.RiftWalk.MaxStacks,rDuration=D.RiftWalk.RStackDuration,
  qBase=D.NullLance.BaseDamage,qAP=.8,qSpeed=D.NullLance.mSpeed,wKind='reset',wPassiveBase=D.NetherBlade.PassiveBaseDamage,wPassiveAP=.1,eBase=D.ForcePulse.BaseDamage,eAP=D.ForcePulse.APRatio,
  -- 2026-10-08. R: blink, range 500, cast 0.25, damage radius 270, 80/95/110 (+50% AP) (+2% max mana).
  -- Q: 1.5 s magic-damage shield 80..200 (+30% AP); interrupts channels. W active 50..150 (+80% AP), resets the attack, +50 attack range.
  -- Sources: https://wiki.leagueoflegends.com/en-us/Kassadin and research/family-assets/Kassadin/spells.json (RiftWalk CastRange/RBaseDamage/APRatio/
  -- RManaRatio, castRadius 270; NullLance ShieldAmount/ShieldDuration; NetherBlade ActiveBaseDamage). Shield AP 0.30: the asset's NullLance
  -- mSpellCalculations coefficient (295c2889) confirms the wiki (2026-10-10), so the old d7141e61=0.4 conflict is closed.
  -- 2026-10-10. R stack bonus per current stack: 35/45/55 (+7% AP) (+1% max mana), spells.json RiftWalk StackDamage/APStackRatio/
  -- RStackManaRatio and wiki V26.18. Counted with the stacks held before the cast (the lower of the two readings until measured).
  rCast=D.RiftWalk.mCastTime,rRadius=D.RiftWalk.castRadius,rBase=D.RiftWalk.RBaseDamage,rAP=D.RiftWalk.APRatio,rMana=D.RiftWalk.RManaRatio/100,rSource='wiki Kassadin Riftwalk + family-assets/Kassadin/spells.json RiftWalk, 2026-10-08',
  rStack=D.RiftWalk.StackDamage,rStackAP=D.RiftWalk.APStackRatio,rStackMana=D.RiftWalk.RStackManaRatio/100,wRangeBonus=50,
  qCast=D.NullLance.mCastTime,qInterrupts=true,qShield=D.NullLance.ShieldAmount,qShieldAP=.3,qShieldDuration=D.NullLance.ShieldDuration,
  qShieldSource='wiki Kassadin Null Sphere + family-assets/Kassadin/spells.json NullLance ShieldAmount/ShieldDuration, 2026-10-08',
  wBase=D.NetherBlade.ActiveBaseDamage,wAP=.8},
 Jade_Kassadin={id='classic',q='Jade_KassadinQ',w='Jade_KassadinW',e='Jade_KassadinE',r='Jade_KassadinR',
  wBuff='Jade_KassadinW_Buff',eCounter='Jade_KassadinE_Counter',eAvailable='Jade_KassadinE_CanCast',
  rBuff='Jade_KassadinR',rRange=D.Jade_KassadinR.MaxDistance,rBaseCost=D.Jade_KassadinR.AdditionalManaPerCast,rCostKind='linear',rMax=D.Jade_KassadinR.MaxStacks,rDuration=D.Jade_KassadinR.BuffDuration,
  qBase=D.Jade_KassadinQ.BaseDamage,qAP=D.Jade_KassadinQ.APRatio,qSpeed=D.Jade_KassadinQ.mSpeed,wKind='sustained',eBase=D.Jade_KassadinE.Damage,eAP=D.Jade_KassadinE.APRatio,
  -- 2026-10-08, research/family-assets/Jade_Kassadin/spells.json. R: MaxDistance 700, castRadius 270, Damage 60/70/80, current APRatio 0.8. The cast
  -- delay is not a named value: both undecoded timing fields (90fb0576, 11704a2b = 0.25) and castFrame 10.3 equal the Normal RiftWalk entry,
  -- whose 0.25 s cast time the wiki confirms. Q silences (current SilenceDuration 1..2.6 s), which ends a channel; it grants no shield.
  rCast=D.Jade_KassadinR.mCastTime,rRadius=D.Jade_KassadinR.castRadius,rBase=D.Jade_KassadinR.Damage,rAP=D.Jade_KassadinR.APRatio,rSource='family-assets/Jade_Kassadin/spells.json Jade_KassadinR (cast delay by field parity with RiftWalk), 2026-10-08',
  qCast=D.Jade_KassadinQ.mCastTime,qInterrupts=true},
}

end
end
