return function(require)
return function()
-- Shared Nami mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 NamiW={
  BaseHeal={55,80,105,130,155},HealAPRatio=.4,mCastTime=.25,
 },
 NamiQ={
  BaseDamage={90,145,200,255,310},
 },
 NamiE={
  BaseDamage={20,35,50,65,80},
 },
 Jade_NamiQ={
  APRatio=.65,BaseDamage={75,130,185,240,295},
 },
 Jade_NamiE={
  BaseDamage={25,40,55,70,85},
 },
 Jade_NamiW={
  BaseHeal={65,95,125,155,185},HealAPRatio=.3,
 },
}
end)()
return {
 Nami={id='normal',q='NamiQ',w='NamiW',e='NamiE',r='NamiR',eBuff='NamiE',spellE=true,
  qBase=D.NamiQ.BaseDamage,qAP=.5,wDamage={60,95,130,165,200},wHeal=D.NamiW.BaseHeal,healAP=D.NamiW.HealAPRatio,
  eBase=D.NamiE.BaseDamage,bounce=-.20,bounceAP=.0015,healBounce=nil,rAP=.6,
  -- Finisher timing (wiki https://wiki.leagueoflegends.com/en-us/Nami read 2026-10-10): Q lands .99 s after the cast
  -- starts, W cast .25 s and bolt speed 2500, R cast .5 s and wave speed 850.
  qImpact=.99,wCast=D.NamiW.mCastTime,wSpeed=2500,rSpeed=850},
 Jade_Nami={id='classic',q='Jade_NamiQ',w='Jade_NamiW',e='Jade_NamiE',r='Jade_NamiR',eBuff='Jade_NamiE',spellE=false,
  qBase=D.Jade_NamiQ.BaseDamage,qAP=D.Jade_NamiQ.APRatio,wDamage={70,110,150,190,230},wHeal=D.Jade_NamiW.BaseHeal,healAP=D.Jade_NamiW.HealAPRatio,
  eBase=D.Jade_NamiE.BaseDamage,bounce=-.30,bounceAP=0,healBounce=-.15,
  -- rAP: https://wiki.leagueoflegends.com/en-us/League_Classic/Nami Tidal Wave 150/250/350 (+70% AP), read 2026-10-08 (was the Normal .6).
  -- Same page: Q radius 200 and R range 2750 / width 500; the controller keeps its narrower 155 / 2200 / 170 geometry (the safe side).
  rAP=.7,
  -- Q timing from the Classic wiki page (read 2026-10-10: same .99 s landing). W bolt speed has no Classic source:
  -- 1500 (the slower wiki bounce speed) is a conservative bound for the finisher's impact time only.
  qImpact=.99,wCast=.25,wSpeed=1500,wSpeedBound=true,rSpeed=850},
}

end
end
