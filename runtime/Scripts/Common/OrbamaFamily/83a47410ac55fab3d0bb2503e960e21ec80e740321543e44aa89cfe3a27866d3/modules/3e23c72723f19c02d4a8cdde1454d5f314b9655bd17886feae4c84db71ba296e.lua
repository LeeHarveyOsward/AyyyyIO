return function(require)
return function()
-- Shared MonkeyKing mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 MonkeyKingNimbus={
  BaseDamage={80,120,160,200,240},DashSpeed=1050,EndPointOffsetDistance=75,ExtraTargetRange=700,castRange=650,
 },
 MonkeyKingDecoy={
  CloneDamageMod={.4,.45,.5,.55,.6},CloneDuration=4,DashSpeed=900,MinRange=100,RangeClamp=300,StealthDuration=1,
 },
 MonkeyKingPassive={
  MaxStacks=5,
 },
 MonkeyKingDoubleAttack={
  ADRatio=.5,AttackRangeBonus={135,145,155,165,175},BaseDamage={20,45,70,95,120},
 },
}
end)()
return {
 MonkeyKing={id='normal',q='MonkeyKingDoubleAttack',w='MonkeyKingDecoy',e='MonkeyKingNimbus',r='MonkeyKingSpinToWin',leave='MonkeyKingSpinToWinLeave',
  qAttack='MonkeyKingQAttack',qBase=D.MonkeyKingDoubleAttack.BaseDamage,qBonusAD=D.MonkeyKingDoubleAttack.ADRatio,qTotalAD=1,qBonusRange=D.MonkeyKingDoubleAttack.AttackRangeBonus,
  eBase=D.MonkeyKingNimbus.BaseDamage,eAP=1,eAD=0,eKind='magical',eExtra=D.MonkeyKingNimbus.ExtraTargetRange,eBuff='MonkeyKingNimbusAS',
  stealth='MonkeyKingDecoyStealth',cloneDuration=D.MonkeyKingDecoy.CloneDuration,stealthDuration=D.MonkeyKingDecoy.StealthDuration,wRange=D.MonkeyKingDecoy.RangeClamp,wMin=D.MonkeyKingDecoy.MinRange,wSpeed=D.MonkeyKingDecoy.DashSpeed,wDelay=.3,
  cloneRatio=D.MonkeyKingDecoy.CloneDamageMod,rRecast='MonkeyKingSpinRecast',spinDuration=2,recastWindow=8,rLockout=1,rRadius=315,
  passive='MonkeyKingPassiveStack',maxStacks=D.MonkeyKingPassive.MaxStacks,
  -- The wiki gives no cast time; wDelay=.3 is the kept controller timing. Evade is given both and must be safe under either.
  -- Nimbus Strike: asset MonkeyKingNimbus DashSpeed 1050, EndPointOffsetDistance 75, castRange 650 (read 2026-10-10,
  -- installed asset, not live-verified). Offered to Evade as a unit dash next to W (SDK.ChampionMobility alternatives);
  -- development own_dash records confirm the figures in play.
  eDash={speed=D.MonkeyKingNimbus.DashSpeed,offset=D.MonkeyKingNimbus.EndPointOffsetDistance,range=D.MonkeyKingNimbus.castRange,source='research/family-assets/MonkeyKing/spells.json MonkeyKingNimbus DashSpeed 1050, EndPointOffsetDistance 75, castRange 650 (2026-10-10)'},
  -- Cyclone (asset MonkeyKingSpinToWin, wiki Wukong read 2026-10-10): 4/6/8% max health (+137.5% AD) physical per second,
  -- ticks every .25 s for 2 s, knock-up .6 s, radius 315.
  rPctPerSec={.04,.06,.08},rADPerSec=1.375,rTick=.25,rTicks=8,rKnockupSeconds=.6,
  wDelays={0,.3},wSource='https://wiki.leagueoflegends.com/en-us/Wukong Warrior Trickster: dash 100-300 at speed 900, no cast time, invisible 1 s, clone 4 s (read 2026-10-08); .3 is the kept controller delay'},
 Jade_Wukong={id='classic',q='Jade_WukongQ',w='Jade_WukongW',e='Jade_WukongE',r='Jade_WukongR',leave='Jade_WukongR_Leave',
  qAttack='Jade_WukongQAttack',qBase={30,60,90,120,150},qBonusAD=0,qTotalAD=1.1,qBonusRange={125,125,125,125,125},
  eBase={60,105,150,195,240},eAP=0,eAD=.8,eKind='physical',eExtra=320,eBuff='Jade_WukongE_Buff',
  stealth='Jade_WukongW_Stealth',cloneDuration=1.5,stealthDuration=1.5,cloneBuff='Jade_WukongW_Clone',wRange=0,
  spinDuration=4,rRadius=315,knockup='Jade_WukongR_Knockup',passive='Jade_WukongPassive',
  -- Cyclone (asset Jade_WukongR): BaseDamagePerSecond 20/110/200 (+120% AD) per second, ticks every .5 s for 4 s, knock-up .6 s.
  -- The asset's BasePercentMaxHPDmgPerSec row has no established use in this kit and is left out until measured.
  rBasePerSec={20,110,200},rADPerSec=1.2,rTick=.5,rTicks=8,rKnockupSeconds=.6,
  eSpeed=1050,eSource='research/family-assets/Jade_Wukong/spells.json:430,456,517 (Jade_WukongE DashSpeed 1050, EndPointOffsetDistance 75, castRange 650; no cast-time field; 2026-10-08)'},
}

end
end
