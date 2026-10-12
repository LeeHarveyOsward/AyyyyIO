return function(require)
return function()
-- Shared Zed mechanics data. Values preserved from the maintained controller.
return {Zed={id='normal',q='ZedQ',w='ZedW',w2='ZedW2',e='ZedE',r='ZedR',r2='ZedR2',mark='ZedRDeathMark',wBuff='ZedWHandlerBuffName',rBuff='ZedR2',passiveCD='ZedPassiveCD',
 qRange=900,qRadius=45,qBlockRadius=50,qSpeed=1700,qDelay=.25,qBase={80,120,160,200,240},qAD=1,qPass=.6,
 -- Death Mark as offered to Evade: untargetable from the cast (no cast time) through a 0.6 s delay and a 0.35 s dash, then
 -- Zed stands 125 units beyond the target (Template:Data_Zed/Death_Mark, read 2026-10-08). The sum .95 s is ours.
 rUntargetable=.95,rBehind=125,rCast=0,rEvadeSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Zed/Death_Mark target range 625, no cast time, untargetable 0.6 s delay + 0.35 s dash, lands 125 beyond the target; read 2026-10-08',
 -- Shadow swaps offered to Evade (Zed-2): both recasts are blinks with no cast time; R2 waits 0.5 s after Zed
 -- reappears and is refused in the last 1.25 s. A missing number here withdraws the offer.
 w2Cast=0,w2CastSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Zed/Living_Shadow cast time none; recast Shadow Swap: Zed and the Shadow blink to swap places; read 2026-10-10',
 r2Cast=0,r2Tail=1.25,r2CastSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Zed/Death_Mark cast time none; recast blinks to swap places 0.5 s after Zed reappears, not in the last 1.25 s; read 2026-10-10',
 -- W lands between 325 and 650 (asset ZedMarker castRange 325, wiki V26.10); the shadow travels at 2500 (asset ZedWMissile).
 -- Two-step Evade dodge (W toward an Evade-chosen point, W2 once the shadow is seen there). The wiki lists no cast
 -- time; wCast .07 is a conservative bound from the asset animation (ZedW castFrame 1.98 at 30 fps = .066 s).
 -- wObserve .15 is the bound of our own shadow discovery job (35 ms interval, 150 ms maximum delay), not a game number.
 wCast=.07,wObserve=.15,wPlaceSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Zed/Living_Shadow range 650 (minimum 325), cast time none, recast none; asset ZedWMissile missileSpeed 2500 and ZedW castFrame 1.98 (bound .07 s); read 2026-10-10',
 wMin=325,wSpeed=2500,wRange=650,wSwapRange=2000,wDuration=5.25,rRange=625,rDuration=7.5,rRecast=.5,markDuration=3,rAmp={.25,.4,.55},rAD=1,
 -- E: asset ZedE castRadius 290, wiki lists 315 and 290; the caster uses 290 until the zed_e_reach trace measures it.
 eRadius=290,eShadowRadius=290,eBase={70,92.5,115,137.5,160},eAD=.7,
 passiveThreshold=.5,passiveLevels={1,7,17},passiveRatios={.05,.075,.10},monsterMod=.75,monsterCap=175,passiveDuration=10}}

end
end
