return function(require)
return function()
-- Shared MasterYi mechanics data. Values preserved from the maintained controller.
-- wReset: Meditate resets the basic attack timer (both read 2026-10-08).
--   Normal:  https://wiki.leagueoflegends.com/en-us/Master_Yi, Meditate: "resets Master Yi's basic attack timer".
--   Classic: https://wiki.leagueoflegends.com/en-us/League_Classic/Master_Yi, Meditate notes: "immediately canceling the
--            channel for the attack reset does not guarantee one tick of healing"; the Jade_ asset declares
--            Trait_AttackReset (attack_resets.lua). Not live-timed.
-- Meditate as a defence, offered to Evade (C:RegisterEffect, 2026-10-10):
--   Normal:  70% damage reduction for the first 0.5 s, then 45/47.5/50/52.5/55%, halved against turrets, lingering
--            0.5 s; channel up to 4 s (same Normal page).
--   Classic: +100/150/200/250/300 armor and magic resistance while channelling, up to 5 s (same Classic page).
--   Asset (research/family-assets/{MasterYi,Jade_MasterYi}/spells.json, read 2026-10-10): Normal Meditate DamageReduction
--            .45/.475/.5/.525/.55 (ranks 1-5), InitialExtraDR .25/.225/.2/.175/.15 for InitialExtraDRDuration .5 (70% at
--            every rank, matching the wiki), DamageReductionTowerMod .5, HealDuration 4; Classic DefenseStat 100-300,
--            Duration 5; both castFrame 3.25 (30 fps: .108 s). Turret shots are not Evade threats, so the turret halving
--            never enters an Evade forecast.
-- Alpha Strike bounce search: asset field 8f6f40e6 550 (both profiles); the Normal wiki says 600. The controller uses
--   550 (fewer counted bounce targets is the conservative side); live bounce observation settles it.
-- Q first strike: castFrame 7.935 at 30 fps (.26 s, both assets), used as the LastHit rescue impact.
-- Alpha Strike (Normal page): marks every 0.231 s, 4 marks, reappears after 0.165 s (1.087 s with 4 bounces). The
--   controller keeps its conservative one-strike .25 s untargetable minimum; the Classic page states no duration.
local D=(function()
return {
 MasterYiPassive={
  AttackCount=4,StackDuration=4,
 },
 AlphaStrike={
  AttackDamageRatio=.7,BaseDamage={20,40,60,80,100},BonusMonsterDamage={60,85,110,135,160},
 },
 Meditate={
  DamageReduction={.45,.475,.5,.525,.55},HealDuration=4,InitialExtraDRDuration=.5,castFrame=3.25,
 },
 WujuStyle={
  ADRatio=.35,BaseDamage={20,25,30,35,40},Duration=5,
 },
 Highlander={
  RDuration=7,
 },
 Jade_MasterYiAlphaStrike={
  APRatio=1,BaseDamage={100,150,200,250,300},TotalMonsterDamage={260,320,380,440,500},
 },
 Jade_MasterYiHighlander={
  RDuration={8,10,12},
 },
 Jade_MasterYiWujuStyle={
  Duration=10,PassiveAD={15,20,25,30,35},
 },
 Jade_MasterYiMeditate={
  DefenseStat={100,150,200,250,300},Duration=5,castFrame=3.25,
 },
}
end)()
return {
    normal={id='normal',wReset=true,q='AlphaStrike',w='Meditate',e='WujuStyle',r='Highlander',qType='physical',qBase=D.AlphaStrike.BaseDamage,qAD=D.AlphaStrike.AttackDamageRatio,qMonster=D.AlphaStrike.BonusMonsterDamage,
      eBase=D.WujuStyle.BaseDamage,eBonusAD=D.WujuStyle.ADRatio,eActive='WujuStyleSuperCharged',eDuration=D.WujuStyle.Duration,rDuration=D.Highlander.RDuration,dsRatio=.5,dsCount=D.MasterYiPassive.AttackCount,dsDuration=D.MasterYiPassive.StackDuration,
      qBounce=550,qImpact=.26,wDelay=D.Meditate.castFrame/30,wChannel=D.Meditate.HealDuration,wInitialSeconds=D.Meditate.InitialExtraDRDuration,wInitial={.7,.7,.7,.7,.7},wReduction=D.Meditate.DamageReduction,
      wSource='MasterYi spells.json Meditate castFrame 3.25, DamageReduction+InitialExtraDR (.5 s), HealDuration 4; wiki Master_Yi V26.19 read 2026-10-10'},
    classic={id='classic',wReset=true,q='Jade_MasterYiAlphaStrike',w='Jade_MasterYiMeditate',e='Jade_MasterYiWujuStyle',r='Jade_MasterYiHighlander',qType='magical',qBase=D.Jade_MasterYiAlphaStrike.BaseDamage,
        -- research/family-assets/Jade_MasterYi/spells.json Jade_MasterYiAlphaStrike TotalMonsterDamage (rank 1-5)
        -- with MonsterDamageProcChance .5: a random proc, so farming never counts it as certain.
        qMonster=D.Jade_MasterYiAlphaStrike.TotalMonsterDamage,qAP=D.Jade_MasterYiAlphaStrike.APRatio,eActive='Jade_MasterYiWujuStyleSuperCharged',eDuration=D.Jade_MasterYiWujuStyle.Duration,ePassive=D.Jade_MasterYiWujuStyle.PassiveAD,rDuration=D.Jade_MasterYiHighlander.RDuration,
        qBounce=550,qImpact=.26,wDelay=D.Jade_MasterYiMeditate.castFrame/30,wChannel=D.Jade_MasterYiMeditate.Duration,wResist=D.Jade_MasterYiMeditate.DefenseStat,
        wSource='Jade_MasterYi spells.json Jade_MasterYiMeditate castFrame 3.25, DefenseStat 100-300, Duration 5; wiki League_Classic/Master_Yi read 2026-10-10'},
}

end
end
