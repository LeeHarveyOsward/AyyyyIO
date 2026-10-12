return function(require)
return function()
-- Shared Chogath mechanics data. Values preserved from the maintained controller.
return {
 Chogath={id='normal',q={'Rupture'},w={'FeralScream'},e={'VorpalSpikes'},r={'Feast'},
  qBase={80,135,190,245,300},qRadius=230,qDelay=.625,wBase={80,130,180,230,280},wRange=585,
  eBase={30,50,70,90,110},ePercent={2.5,2.85,3.2,3.55,3.9},eToggle=false,
  rBase={300,475,650},rMonster=1200,rAP=.5,rHP=.1,stackCapKind='non_epic',stackCap=6,feastBuff='Feast',
  -- LoL wiki Cho'Gath V26.17 (read 2026-10-10): Feast range +2.5 per stack up to +25; spikes 650 long, 1475 speed,
  -- width 340-500 (the narrowest half width is used); 110-310 (+30% AP) per spike against monsters; +0.5% maximum
  -- health per Feast stack (installed asset FeastStackMultiplier 0.5); E lasts 6 s (asset BuffDuration).
  rStackRange=2.5,rStackRangeMax=10,eSpikeRange=650,eSpikeSpeed=1475,eHalfWidth=170,eMonster={110,160,210,260,310},
  eStackPercent=.5,eDuration=6},
 Jade_Chogath={id='classic',q={'Jade_ChogathQ'},w={'Jade_ChogathW','Jade_Chogath_FeralScream'},
  e={'Jade_ChogathE','Jade_ChogathE_Jade'},r={'Jade_ChogathR','Jade_Chogath_Feast'},
  qBase={80,135,190,245,305},qRadius=250,qDelay=.625,wBase={75,125,175,225,275},wRange=650,
  eBase={20,35,50,65,80},eToggle=true,rBase={300,475,650},rMonster=1000,rAP=.7,rHP=0,
  stackCapKind='total',stackCap=6,feastBuff='Jade_ChogathR',
  -- Installed Jade_ChogathEMissile: castRange 650, missileSpeed 1475, castRadius 175 (half width candidate; 150
  -- is used until measured). Feast stack range growth and per-stack spike damage are unmeasured: none here.
  -- Whether Classic Feast stacks survive death is unverified (chogath-provenance gaps): death makes the count unknown.
  eSpikeRange=650,eSpikeSpeed=1475,eHalfWidth=150,stacksMayDropOnDeath=true},
}

end
end
