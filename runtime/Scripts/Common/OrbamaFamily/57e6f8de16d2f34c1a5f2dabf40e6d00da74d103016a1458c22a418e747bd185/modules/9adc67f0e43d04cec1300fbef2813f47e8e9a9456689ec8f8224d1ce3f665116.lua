return function(require)
return function()
-- Shared Annie mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 AnnieR={
  InitialDamage={150,275,400},
 },
 AnnieQ={
  APRatio=.8,BaseDamage={80,125,170,215,260},
 },
 AnnieE={
  ShieldAmount={60,95,130,165,200},ShieldDuration=3,
 },
 AnnieW={
  APRatio=.8,BaseDamage={70,110,150,190,230},
 },
 Jade_AnnieR={
  InitialDamage={200,325,450},
 },
 Jade_AnnieQ={
  APRatio=.75,BaseDamage={90,130,170,210,250},
 },
 Jade_AnnieW={
  APRatio=.8,BaseDamage={85,135,185,235,285},
 },
}
end)()
return {
 Annie={id='normal',q='Disintegrate',w='Incinerate',e='AnnieE',r='InfernalGuardian',
  guides={AnnieRController=true,InfernalGuardianGuide=true},stack='anniepassivestack',primed='anniepassiveprimed',
  qBase=D.AnnieQ.BaseDamage,qAP=D.AnnieQ.APRatio,wBase=D.AnnieW.BaseDamage,wAP=D.AnnieW.APRatio,rBase=D.AnnieR.InitialDamage,rAP=.75,allyE=true,
  -- Molten Shield: 60-200 (+40% AP) for 3 s on Annie or an ally within 800, no cast time.
  eShield=D.AnnieE.ShieldAmount,eShieldAP=.4,eShieldDuration=D.AnnieE.ShieldDuration,eDelay=0,
  shieldSource='https://wiki.leagueoflegends.com/en-us/Annie Molten Shield, read 2026-10-08 (page last changed V26.04)',
  -- Tibbers also receives the Molten Shield (wiki Annie, read 2026-10-10, V26.04): E in Combo while he fights.
  ePet=true},
 Jade_Annie={id='classic',q='Jade_Annie_Disintegrate',w='Jade_Annie_Incinerate',e='Jade_AnnieE',r='Jade_AnnieR',
  guides={Jade_Annie_InfernalGuardianGuide=true},stack='Jade_AnniePassive_StunBuildupBuff',primed='Jade_AnniePassive_StunReadyBuff',
  qBase=D.Jade_AnnieQ.BaseDamage,qAP=D.Jade_AnnieQ.APRatio,wBase=D.Jade_AnnieW.BaseDamage,wAP=D.Jade_AnnieW.APRatio,rBase=D.Jade_AnnieR.InitialDamage,rAP=.7,allyE=false},
 -- Classic Molten Shield is +20-60 armor and magic resist for 5 s on Annie (Jade_Annie/spells.json Resistances,
 -- ShieldDuration; League_Classic/Annie read 2026-10-08): no absorb amount, so no eShield and no shield offer.
 -- Whether Classic E also reaches Tibbers is unmeasured (no ePet): the dev trace annie_classic_e_tibbers settles it.
}

end
end
