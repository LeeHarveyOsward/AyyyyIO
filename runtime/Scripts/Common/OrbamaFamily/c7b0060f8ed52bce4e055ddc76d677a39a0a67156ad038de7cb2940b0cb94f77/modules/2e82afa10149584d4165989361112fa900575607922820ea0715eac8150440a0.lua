return function(require)
return function()
-- Shared Kassadin mechanics data. Values preserved from the maintained controller.
return {
 Kassadin={id='normal',q='NullLance',w='NetherBlade',e='ForcePulse',r='RiftWalk',wBuff='NetherBladeBuff',
  rBuff='RiftWalk',rRange=500,rBaseCost=40,rCostKind='double',rMax=4,rDuration=15,
  qBase={65,95,125,155,185},qAP=.8,qSpeed=1400,wKind='reset',wPassiveBase=25,wPassiveAP=.1,eBase={70,100,130,160,190},eAP=.7,
  -- 2026-10-08. R: blink, range 500, cast 0.25, damage radius 270, 80/95/110 (+50% AP) (+2% max mana).
  -- Q: 1.5 s magic-damage shield 80..200 (+30% AP); interrupts channels. W active 50..150 (+80% AP), resets the attack, +50 attack range.
  -- Sources: https://wiki.leagueoflegends.com/en-us/Kassadin and research/family-assets/Kassadin/spells.json (RiftWalk CastRange/RBaseDamage/APRatio/
  -- RManaRatio, castRadius 270; NullLance ShieldAmount/ShieldDuration; NetherBlade ActiveBaseDamage). Shield AP 0.30: the asset's NullLance
  -- mSpellCalculations coefficient (295c2889) confirms the wiki (2026-10-10), so the old d7141e61=0.4 conflict is closed.
  -- 2026-10-10. R stack bonus per current stack: 35/45/55 (+7% AP) (+1% max mana), spells.json RiftWalk StackDamage/APStackRatio/
  -- RStackManaRatio and wiki V26.18. Counted with the stacks held before the cast (the lower of the two readings until measured).
  rCast=.25,rRadius=270,rBase={80,95,110},rAP=.5,rMana=.02,rSource='wiki Kassadin Riftwalk + family-assets/Kassadin/spells.json RiftWalk, 2026-10-08',
  rStack={35,45,55},rStackAP=.07,rStackMana=.01,wRangeBonus=50,
  qCast=.25,qInterrupts=true,qShield={80,110,140,170,200},qShieldAP=.3,qShieldDuration=1.5,
  qShieldSource='wiki Kassadin Null Sphere + family-assets/Kassadin/spells.json NullLance ShieldAmount/ShieldDuration, 2026-10-08',
  wBase={50,75,100,125,150},wAP=.8},
 Jade_Kassadin={id='classic',q='Jade_KassadinQ',w='Jade_KassadinW',e='Jade_KassadinE',r='Jade_KassadinR',
  wBuff='Jade_KassadinW_Buff',eCounter='Jade_KassadinE_Counter',eAvailable='Jade_KassadinE_CanCast',
  rBuff='Jade_KassadinR',rRange=700,rBaseCost=100,rCostKind='linear',rMax=10,rDuration=8,
  qBase={60,105,150,195,240},qAP=.7,qSpeed=1400,wKind='sustained',eBase={80,130,180,230,280},eAP=.7,
  -- 2026-10-08, research/family-assets/Jade_Kassadin/spells.json. R: MaxDistance 700, castRadius 270, Damage 60/70/80, APRatio 0.7. The cast
  -- delay is not a named value: both undecoded timing fields (90fb0576, 11704a2b = 0.25) and castFrame 10.3 equal the Normal RiftWalk entry,
  -- whose 0.25 s cast time the wiki confirms. Q silences (SilenceDuration 1..2 s), which ends a channel; it grants no shield.
  rCast=.25,rRadius=270,rBase={60,70,80},rAP=.7,rSource='family-assets/Jade_Kassadin/spells.json Jade_KassadinR (cast delay by field parity with RiftWalk), 2026-10-08',
  qCast=.25,qInterrupts=true},
}

end
end
