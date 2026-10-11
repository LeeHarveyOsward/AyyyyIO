return function(require)
return function()
-- Shared Sona mechanics data. Values preserved from the maintained controller.
return {
 Sona={id='normal',q='SonaQ',w='SonaW',e='SonaE',r='SonaR',qBase={50,85,120,155,190},qAP=.4,
   healBase={30,45,60,75,90},healAP=.3,healRange=1000,shieldBase={25,45,65,85,105},shieldAP=.25,auraRange=400,rRadius=140,rBase={150,250,350},rAP=.5,
  auras={{'SonaQ'},{'SonaW'},{'SonaE'}},chords={{'SonaQPassiveAttack'},{'SonaWPassiveAttack'},{'SonaEPassiveAttack'}},
  count='SonaPassive',accelerando='SonaPassiveAccelerandoCount',shield='SonaWShield',hasShield=true,shieldDuration=1.5,wDelay=0,
  shieldSource='https://wiki.leagueoflegends.com/en-us/Sona Aria of Perseverance: shield 25/45/65/85/105 (+25% AP) for 1.5 s, no cast time (read 2026-10-08)',
  -- Song of Celerity self haste offered to Evade: research/family-assets/Sona/spells.json SonaE SelfBaseMovementSpeed .20 for
  -- SelfMovementSpeedDurationMin 3 s (up to 7 s while undamaged; the 3 s floor is offered), no cast time (wiki read 2026-10-10).
  eHaste={.2,.2,.2,.2,.2},eHasteDuration=3,eHasteBuff='SonaESelfHaste',
  eHasteSource='research/family-assets/Sona/spells.json SonaE SelfBaseMovementSpeed/SelfMovementSpeedDurationMin; https://wiki.leagueoflegends.com/en-us/Sona (read 2026-10-10)'},
 Jade_Sona={id='classic',q='Jade_SonaQ',w='Jade_SonaW',e='Jade_SonaE',r='Jade_SonaR',qBase={60,110,160,210,260},qAP=.5,
   healBase={30,55,80,105,130},healAP=.5,healRange=1000,auraRange=1000,rRadius=140,assetRRadius=170,rBase={150,250,350},rAP=.7,
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
