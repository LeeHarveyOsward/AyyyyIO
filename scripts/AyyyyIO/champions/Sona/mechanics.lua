return function(require)
return function()
-- Shared Sona mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 SonaW={
  AuraRange=400,BaseHeal={30,45,60,75,90},BaseShield={25,45,65,85,105},HealRange=1000,HealRatio=.3,ShieldDuration=1.5,ShieldRatio=.25,
 },
 SonaQ={
  BaseDamage={50,85,120,155,190},
 },
 SonaR={
  BaseDamage={150,250,350},mMissileWidth=140,
 },
 Jade_SonaR={
  APRatio=.7,BaseDamage={150,250,350},mLineWidth=140,mMissileWidth=170,
 },
 Jade_SonaW={
  APRatio=.5,Heal={30,55,80,105,130},
 },
 Jade_SonaQ={
  DamageMissile={60,110,160,210,260},
 },
}
end)()
return {
 Sona={id='normal',q='SonaQ',w='SonaW',e='SonaE',r='SonaR',qBase=D.SonaQ.BaseDamage,qAP=.4,
   healBase=D.SonaW.BaseHeal,healAP=D.SonaW.HealRatio,healRange=D.SonaW.HealRange,shieldBase=D.SonaW.BaseShield,shieldAP=D.SonaW.ShieldRatio,auraRange=D.SonaW.AuraRange,rRadius=D.SonaR.mMissileWidth,rBase=D.SonaR.BaseDamage,rAP=.5,
  auras={{'SonaQ'},{'SonaW'},{'SonaE'}},chords={{'SonaQPassiveAttack'},{'SonaWPassiveAttack'},{'SonaEPassiveAttack'}},
  count='SonaPassive',accelerando='SonaPassiveAccelerandoCount',shield='SonaWShield',hasShield=true,shieldDuration=D.SonaW.ShieldDuration,wDelay=0,
  shieldSource='https://wiki.leagueoflegends.com/en-us/Sona Aria of Perseverance: shield 25/45/65/85/105 (+25% AP) for 1.5 s, no cast time (read 2026-10-08)',
  -- Song of Celerity self haste offered to Evade: research/family-assets/Sona/spells.json SonaE SelfBaseMovementSpeed .20 for
  -- SelfMovementSpeedDurationMin 3 s (up to 7 s while undamaged; the 3 s floor is offered), no cast time (wiki read 2026-10-10).
  eHaste={.2,.2,.2,.2,.2},eHasteDuration=3,eHasteBuff='SonaESelfHaste',
  eHasteSource='research/family-assets/Sona/spells.json SonaE SelfBaseMovementSpeed/SelfMovementSpeedDurationMin; https://wiki.leagueoflegends.com/en-us/Sona (read 2026-10-10)'},
 Jade_Sona={id='classic',q='Jade_SonaQ',w='Jade_SonaW',e='Jade_SonaE',r='Jade_SonaR',qBase=D.Jade_SonaQ.DamageMissile,qAP=.5,
   healBase=D.Jade_SonaW.Heal,healAP=D.Jade_SonaW.APRatio,healRange=1000,auraRange=1000,rRadius=D.Jade_SonaR.mLineWidth,assetRRadius=D.Jade_SonaR.mMissileWidth,rBase=D.Jade_SonaR.BaseDamage,rAP=D.Jade_SonaR.APRatio,
  auras={{'Jade_SonaQ_Aura','Jade_SonaQ_AuraB'},{'Jade_SonaW_Aura','Jade_SonaW_AuraB'},{'Jade_SonaE_Aura','Jade_SonaE_AuraB'}},
  chords={{'Jade_SonaQ_AttackUpgrade','Jade_SonaQ_Attack'},{'Jade_SonaW_AttackUpgrade','Jade_SonaW_Attack'},{'Jade_SonaE_AttackUpgrade','Jade_SonaE_Attack'}},
  count='Jade_SonaPassive_Count',hasShield=false,
  -- Classic Song of Celerity active: research/family-assets/Jade_Sona/spells.json Jade_SonaE MoveSpeedMod .06-.14 (ranks 1-5),
  -- ActiveSpeedDuration 1.5 s; https://wiki.leagueoflegends.com/en-us/League_Classic/Sona active +6-14% for 1.5 s (read 2026-10-10).
  eHaste={.06,.08,.10,.12,.14},eHasteDuration=1.5,eHasteBuff='Jade_SonaE_Haste',
  eHasteSource='research/family-assets/Jade_Sona/spells.json Jade_SonaE MoveSpeedMod/ActiveSpeedDuration; https://wiki.leagueoflegends.com/en-us/League_Classic/Sona (read 2026-10-10)'},
}

end
end
