return function(require)
return function()
-- Shared Normal Thresh data; no Classic mechanics are inferred.
return {
 Thresh={id='normal',q='ThreshQ',q2='ThreshQLeap',w='ThreshW',e='ThreshE',r='ThreshRPenta',hook='threshq',
 qBase={100,150,200,250,300},qAP=.9,eBase={65,110,155,200,245},eAP=.6,rBase={250,400,550},shield={50,70,90,110,130},
 -- Lantern numbers for the Evade shield offer and the far throw. leapHold: the fly-in waits until this much of the hook mark is left.
 shieldPerSoul=2,shieldDuration=4,lanternTravel=.5,lanternRadius=350,lanternFar=1450,leapHold=.4,
 -- Cast times for the finishers and the Flash-Box: Flay 0.389 s, The Box 0.45 s (https://wiki.leagueoflegends.com/en-us/Thresh,
 -- read 2026-10-10). rBase above is the first wall a champion breaks (250/400/550 +100% AP).
 eCast=.389,rCast=.45,
 shieldSource='Thresh W: installed asset research/family-assets/Thresh/spells.json (BaseShieldValue 50..130, ShieldPerSoul 2, ShieldDuration 4, castRadius 350) and https://wiki.leagueoflegends.com/en-us/Template:Data_Thresh/Dark_Passage ("throws his lantern to the target location over 0.5 seconds", "Thresh and the first allied champion to come near the lantern are granted a shield for 4 seconds", effect radius 350), read 2026-10-08. lanternFar 1450 and leapHold are play rules, not kit numbers (hook mark 1.5 s: Template:Data_Thresh/Death_Sentence)'}
}

end
end
