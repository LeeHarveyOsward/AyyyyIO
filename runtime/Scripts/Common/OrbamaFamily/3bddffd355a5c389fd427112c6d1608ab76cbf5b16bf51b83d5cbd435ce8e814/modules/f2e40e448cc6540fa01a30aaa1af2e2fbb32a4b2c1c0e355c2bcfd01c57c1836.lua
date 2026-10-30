return function(require)
return function()
-- Shared Nidalee mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 Takedown={
  TotalADRatio=.75,
 },
 JavelinToss={
  SpearMinimumAPRatio=.5,mMissileWidth=40,
 },
 PrimalSurge={
  BaseHeal={50,75,100,125,150},
 },
 AspectOfTheCougar={
  PounceAPRatio=.3,SwipeADRatio=.7,SwipeAPRatio=.55,TakedownAPRatio=.4,
 },
 Bushwhack={
  DotDuration=4,
 },
 Jade_NidaleeBushwhack={
  DamageDuration=2.5,
 },
 Jade_NidaleePrimalSurge={
  BaseHeal={50,85,120,155,190},castRangeDisplayOverride=575,
 },
 Jade_NidaleeJavelinToss={
  APRatio=.65,mMissileWidth=60,
 },
 Jade_NidaleeAspectOfTheCougar={
  PounceAPRatio=.4,SwipeAPRatio=.6,TakedownADRatio=1,
 },
}
end)()
return {
 Nidalee={id='normal',q='JavelinToss',w='Bushwhack',e='PrimalSurge',r='AspectOfTheCougar',
  cougar={'Takedown','Pounce','Swipe'},ranks=4,healRange=900,heal=D.PrimalSurge.BaseHeal,healAP=.35,
  spear={70,90,110,130,150},spearAP=D.JavelinToss.SpearMinimumAPRatio,spearMultiplier=3.25,spearRadius=D.JavelinToss.mMissileWidth,hunt='nidaleepassivehunted',
  swipe={70,130,190,250},swipeAP=D.AspectOfTheCougar.SwipeAPRatio,swipeBonusAD=D.AspectOfTheCougar.SwipeADRatio,pounce={50,90,130,170},pounceAP=D.AspectOfTheCougar.PounceAPRatio,
  takedown={5,30,55,80},takedownAD=D.Takedown.TotalADRatio,takedownAP=D.AspectOfTheCougar.TakedownAPRatio,trapDuration=D.Bushwhack.DotDuration,
  -- Bushwhack arms 1.5 s after it lands (wiki https://wiki.leagueoflegends.com/en-us/Nidalee read 2026-10-10).
  trapArm=1.5},
 Jade_Nidalee={id='classic',q='Jade_NidaleeJavelinToss',w='Jade_NidaleeBushwhack',e='Jade_NidaleePrimalSurge',r='Jade_NidaleeAspectOfTheCougar',
  cougar={'Jade_NidaleeTakedown','Jade_NidaleePounce','Jade_NidaleeSwipe'},ranks=3,healRange=D.Jade_NidaleePrimalSurge.castRangeDisplayOverride,heal=D.Jade_NidaleePrimalSurge.BaseHeal,healAP=.7,
  spear={55,95,140,185,230},spearAP=D.Jade_NidaleeJavelinToss.APRatio,spearMultiplier=2.5,spearRadius=D.Jade_NidaleeJavelinToss.mMissileWidth,
  swipe={150,225,300},swipeAP=D.Jade_NidaleeAspectOfTheCougar.SwipeAPRatio,pounce={125,175,225},pounceAP=D.Jade_NidaleeAspectOfTheCougar.PounceAPRatio,
  takedown={40,70,100},takedownAD=D.Jade_NidaleeAspectOfTheCougar.TakedownADRatio,takedownAP=0,trapDuration=D.Jade_NidaleeBushwhack.DamageDuration,
  -- No Classic arm time is published: the Normal 1.5 s is used only as a stricter placement bound (a trap thrown
  -- under shorter control was the earlier rule); it is not a Classic mechanic claim.
  trapArm=1.5,trapArmBound=true},
}

end
end
