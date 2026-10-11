return function(require)
return function()
-- Shared Nidalee mechanics data. Values preserved from the maintained controller.
return {
 Nidalee={id='normal',q='JavelinToss',w='Bushwhack',e='PrimalSurge',r='AspectOfTheCougar',
  cougar={'Takedown','Pounce','Swipe'},ranks=4,healRange=900,heal={50,75,100,125,150},healAP=.35,
  spear={70,90,110,130,150},spearAP=.5,spearMultiplier=3.25,spearRadius=40,hunt='nidaleepassivehunted',
  swipe={70,130,190,250},swipeAP=.55,swipeBonusAD=.7,pounce={55,100,145,190},pounceAP=.3,
  takedown={5,30,55,80},takedownAD=.75,takedownAP=.4,trapDuration=4,
  -- Bushwhack arms 1.5 s after it lands (wiki https://wiki.leagueoflegends.com/en-us/Nidalee read 2026-10-10).
  trapArm=1.5},
 Jade_Nidalee={id='classic',q='Jade_NidaleeJavelinToss',w='Jade_NidaleeBushwhack',e='Jade_NidaleePrimalSurge',r='Jade_NidaleeAspectOfTheCougar',
  cougar={'Jade_NidaleeTakedown','Jade_NidaleePounce','Jade_NidaleeSwipe'},ranks=3,healRange=575,heal={50,85,120,155,190},healAP=.7,
  spear={55,95,140,185,230},spearAP=.65,spearMultiplier=2.5,spearRadius=60,
  swipe={150,225,300},swipeAP=.6,pounce={125,175,225},pounceAP=.4,
  takedown={40,70,100},takedownAD=1,takedownAP=0,trapDuration=2.5,
  -- No Classic arm time is published: the Normal 1.5 s is used only as a stricter placement bound (a trap thrown
  -- under shorter control was the earlier rule); it is not a Classic mechanic claim.
  trapArm=1.5,trapArmBound=true},
}

end
end
