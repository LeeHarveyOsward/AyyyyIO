return function(require)
return function()
-- Shared Chogath mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 Feast={
  CastRangePerStack=2.5,RBaseDamage={300,475,650},RBaseMonsterDamage=1200,RMinionMaxStacks=6,
 },
 VorpalSpikesMissle={
  castRange=650,mMissileWidth=170,mSpeed=1475,
 },
 VorpalSpikes={
  BaseDamage={30,50,70,90,110},BuffDuration=6,FeastStackMultiplier=.5,PercentHealthDamage={2.5,2.85,3.2,3.55,3.9},
 },
 Rupture={
  BaseDamage={80,135,190,245,300},castRadius=230,
 },
 Jade_ChogathR={
  MaxStacks=6,RAPRatio=.7,RBaseDamage={300,475,650},RBaseMonsterDamage=1000,
 },
 Jade_ChogathQ={
  BaseDamage={80,135,190,245,305},KnockupDelay=.625,castRadius=250,
 },
 Jade_ChogathEMissile={
  castRange=650,mMissileWidth=170,mSpeed=1475,
 },
 Jade_ChogathE={
  BaseDamage={20,35,50,65,80},
 },
 Jade_ChogathW={
  BaseDamage={75,125,175,225,275},
 },
}
end)()
return {
 Chogath={id='normal',q={'Rupture'},w={'FeralScream'},e={'VorpalSpikes'},r={'Feast'},
  qBase=D.Rupture.BaseDamage,qRadius=D.Rupture.castRadius,qDelay=.625,wBase={80,130,180,230,280},wRange=585,
  eBase=D.VorpalSpikes.BaseDamage,ePercent=D.VorpalSpikes.PercentHealthDamage,eToggle=false,
  rBase=D.Feast.RBaseDamage,rMonster=D.Feast.RBaseMonsterDamage,rAP=.5,rHP=.1,stackCapKind='non_epic',stackCap=D.Feast.RMinionMaxStacks,feastBuff='Feast',
  -- LoL wiki Cho'Gath V26.17 (read 2026-10-10): Feast range +2.5 per stack up to +25; spikes 650 long, 1475 speed,
  -- width 340-500 (the narrowest half width is used); 110-310 (+30% AP) per spike against monsters; +0.5% maximum
  -- health per Feast stack (installed asset FeastStackMultiplier 0.5); E lasts 6 s (asset BuffDuration).
  rStackRange=D.Feast.CastRangePerStack,rStackRangeMax=10,eSpikeRange=D.VorpalSpikesMissle.castRange,eSpikeSpeed=D.VorpalSpikesMissle.mSpeed,eHalfWidth=D.VorpalSpikesMissle.mMissileWidth,eMonster={110,160,210,260,310},
  eStackPercent=D.VorpalSpikes.FeastStackMultiplier,eDuration=D.VorpalSpikes.BuffDuration},
 Jade_Chogath={id='classic',q={'Jade_ChogathQ'},w={'Jade_ChogathW','Jade_Chogath_FeralScream'},
  e={'Jade_ChogathE','Jade_ChogathE_Jade'},r={'Jade_ChogathR','Jade_Chogath_Feast'},
  qBase=D.Jade_ChogathQ.BaseDamage,qRadius=D.Jade_ChogathQ.castRadius,qDelay=D.Jade_ChogathQ.KnockupDelay,wBase=D.Jade_ChogathW.BaseDamage,wRange=650,
  eBase=D.Jade_ChogathE.BaseDamage,eToggle=true,rBase=D.Jade_ChogathR.RBaseDamage,rMonster=D.Jade_ChogathR.RBaseMonsterDamage,rAP=D.Jade_ChogathR.RAPRatio,rHP=0,
  stackCapKind='total',stackCap=D.Jade_ChogathR.MaxStacks,feastBuff='Jade_ChogathR',
  -- Installed Jade_ChogathEMissile: castRange 650, missileSpeed 1475, mMissileWidth 170 (the half width, the same
  -- field Normal reads; 16.21 ability table 2026-10-28, was 150 'until measured'). Feast stack range growth and
  -- per-stack spike damage are unmeasured: none here.
  -- Whether Classic Feast stacks survive death is unverified (chogath-provenance gaps): death makes the count unknown.
  eSpikeRange=D.Jade_ChogathEMissile.castRange,eSpikeSpeed=D.Jade_ChogathEMissile.mSpeed,eHalfWidth=D.Jade_ChogathEMissile.mMissileWidth,stacksMayDropOnDeath=true},
}

end
end
