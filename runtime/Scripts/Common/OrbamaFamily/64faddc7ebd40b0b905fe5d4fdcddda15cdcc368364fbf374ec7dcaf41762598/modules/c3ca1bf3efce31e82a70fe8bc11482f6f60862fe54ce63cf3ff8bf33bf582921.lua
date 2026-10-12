return function(require)
return function()
-- Shared Annie mechanics data. Values preserved from the maintained controller.
return {
 Annie={id='normal',q='Disintegrate',w='Incinerate',e='AnnieE',r='InfernalGuardian',
  guides={AnnieRController=true,InfernalGuardianGuide=true},stack='anniepassivestack',primed='anniepassiveprimed',
  qBase={80,125,170,215,260},qAP=.8,wBase={70,110,150,190,230},wAP=.8,rBase={150,275,400},rAP=.75,allyE=true,
  -- Molten Shield: 60-200 (+40% AP) for 3 s on Annie or an ally within 800, no cast time.
  eShield={60,95,130,165,200},eShieldAP=.4,eShieldDuration=3,eDelay=0,
  shieldSource='https://wiki.leagueoflegends.com/en-us/Annie Molten Shield, read 2026-10-08 (page last changed V26.04)',
  -- Tibbers also receives the Molten Shield (wiki Annie, read 2026-10-10, V26.04): E in Combo while he fights.
  ePet=true},
 Jade_Annie={id='classic',q='Jade_Annie_Disintegrate',w='Jade_Annie_Incinerate',e='Jade_AnnieE',r='Jade_AnnieR',
  guides={Jade_Annie_InfernalGuardianGuide=true},stack='Jade_AnniePassive_StunBuildupBuff',primed='Jade_AnniePassive_StunReadyBuff',
  qBase={90,130,170,210,250},qAP=.75,wBase={85,135,185,235,285},wAP=.8,rBase={200,325,450},rAP=.7,allyE=false},
 -- Classic Molten Shield is +20-60 armor and magic resist for 5 s on Annie (Jade_Annie/spells.json Resistances,
 -- ShieldDuration; League_Classic/Annie read 2026-10-08): no absorb amount, so no eShield and no shield offer.
 -- Whether Classic E also reaches Tibbers is unmeasured (no ePet): the dev trace annie_classic_e_tibbers settles it.
}

end
end
