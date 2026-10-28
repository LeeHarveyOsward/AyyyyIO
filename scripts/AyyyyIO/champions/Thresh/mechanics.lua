return function(require)
return function()
-- Shared Normal Thresh data; no Classic mechanics are inferred.
local D=(function()
return {
 ThreshQ={
  APRatio=.9,BaseDamage={100,150,200,250,300},
 },
 ThreshW={
  BaseShieldValue={50,70,90,110,130},ShieldDuration=4,castRadius=350,
 },
 ThreshE={
  APRatio=.6,ActiveBaseDamage={65,110,155,200,245},
 },
 ThreshRPenta={
  Damage={250,400,550},mCastTime=.45,
 },
}
end)()
return {
 Thresh={id='normal',q='ThreshQ',qNative='ThreshQInternal',q2='ThreshQLeap',w='ThreshW',e='ThreshE',r='ThreshRPenta',hook='threshq',
 qBase=D.ThreshQ.BaseDamage,qAP=D.ThreshQ.APRatio,eBase=D.ThreshE.ActiveBaseDamage,eAP=D.ThreshE.APRatio,rBase=D.ThreshRPenta.Damage,shield=D.ThreshW.BaseShieldValue,
 -- Lantern numbers for the Evade shield offer and the far throw. leapHold: the fly-in waits until this much of the hook mark is left.
 shieldPerSoul=2,shieldDuration=D.ThreshW.ShieldDuration,lanternTravel=.5,lanternRadius=D.ThreshW.castRadius,lanternFar=1450,leapHold=.4,
 -- Cast times for the finishers and the Flash-Box: Flay 0.389 s, The Box 0.45 s (https://wiki.leagueoflegends.com/en-us/Thresh,
 -- read 2026-10-10). rBase above is the first wall a champion breaks (250/400/550 +100% AP).
 eCast=.389,rCast=D.ThreshRPenta.mCastTime,
 shieldSource='Thresh W: installed asset research/family-assets/Thresh/spells.json (BaseShieldValue 50..130, ShieldPerSoul 2, ShieldDuration 4, castRadius 350) and https://wiki.leagueoflegends.com/en-us/Template:Data_Thresh/Dark_Passage ("throws his lantern to the target location over 0.5 seconds", "Thresh and the first allied champion to come near the lantern are granted a shield for 4 seconds", effect radius 350), read 2026-10-08. lanternFar 1450 and leapHold are play rules, not kit numbers (hook mark 1.5 s: Template:Data_Thresh/Death_Sentence)'}
}

end
end
