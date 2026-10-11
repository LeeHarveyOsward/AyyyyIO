return function(require)
return function()
-- Shared MonkeyKing mechanics data. Values preserved from the maintained controller.
return {
 MonkeyKing={id='normal',q='MonkeyKingDoubleAttack',w='MonkeyKingDecoy',e='MonkeyKingNimbus',r='MonkeyKingSpinToWin',leave='MonkeyKingSpinToWinLeave',
  qAttack='MonkeyKingQAttack',qBase={20,45,70,95,120},qBonusAD=.5,qTotalAD=1,qBonusRange={135,145,155,165,175},
  eBase={80,120,160,200,240},eAP=1,eAD=0,eKind='magical',eExtra=700,eBuff='MonkeyKingNimbusAS',
  stealth='MonkeyKingDecoyStealth',cloneDuration=4,stealthDuration=1,wRange=300,wMin=100,wSpeed=900,wDelay=.3,
  cloneRatio={.4,.45,.5,.55,.6},rRecast='MonkeyKingSpinRecast',spinDuration=2,recastWindow=8,rLockout=1,rRadius=315,
  passive='MonkeyKingPassiveStack',maxStacks=5,
  -- The wiki gives no cast time; wDelay=.3 is the kept controller timing. Evade is given both and must be safe under either.
  -- Nimbus Strike: asset MonkeyKingNimbus DashSpeed 1050, EndPointOffsetDistance 75, castRange 650 (read 2026-10-10,
  -- installed asset, not live-verified). Offered to Evade as a unit dash next to W (SDK.ChampionMobility alternatives);
  -- development own_dash records confirm the figures in play.
  eDash={speed=1050,offset=75,range=650,source='research/family-assets/MonkeyKing/spells.json MonkeyKingNimbus DashSpeed 1050, EndPointOffsetDistance 75, castRange 650 (2026-10-10)'},
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
