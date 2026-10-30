return function(require)
return function()
-- Shared Nasus mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 NasusQ={
  BonusDamage={30,50,70,90,110},BonusRange=50,
 },
 NasusE={
  DamagePerTick={10,16,22,28,34},Duration=5,InitialHitDamage={50,80,110,140,170},
 },
 NasusR={
  Duration=15,
 },
 NasusW={
  castRange=700,
 },
 Jade_NasusW={
  castRange=700,
 },
 Jade_NasusQ={
  BonusDamage={30,50,70,90,110},
 },
 Jade_NasusR={
  Duration=15,
 },
 Jade_NasusE={
  InitialDamages={55,95,135,175,215},TickDamage={11,19,27,35,43},TotalArmorShred={20,25,30,35,40},
 },
}
end)()
return {
 Nasus={id='normal',q={'NasusQ'},qBuff='NasusQ',stacks='NasusQStacks',qAttack='NasusQAttack',
  w='NasusW',e='NasusE',r='NasusR',qBase=D.NasusQ.BonusDamage,eBase=D.NasusE.InitialHitDamage,
   qRangeBonus=D.NasusQ.BonusRange,stackSmall=4,stackLarge=10,eDelay=.25,eAP=.6,eArmorKind='percent',eArmor={30,35,40,45,50},
   -- Q 30..110 and E 50..170 (+60% AP) confirmed; area and burn from the same page.
   eRadius=400,eTick=D.NasusE.DamagePerTick,eTickAP=.12,eDuration=D.NasusE.Duration,source='https://wiki.leagueoflegends.com/en-us/Nasus (read 2026-10-08)',
   -- E initial hit lands 0.264 s after the cast; R bonus health, cast and duration; W range (wiki V26.19, read 2026-10-10).
   eBurstDelay=.264,wRange=D.NasusW.castRange,rHealth={300,450,600},rCast=.2,rDuration=D.NasusR.Duration,
   -- Wards give Q stacks. Damage of one melee hit on a ward is not measured: only a ward at 1 health counts as a sure kill.
   wardKillHealth=1,rSource='https://wiki.leagueoflegends.com/en-us/Nasus (V26.19, read 2026-10-10): R +300/450/600 health, cast 0.2 s, 15 s'},
 Jade_Nasus={id='classic',q={'Jade_NasusQ','Jade_NasusSiphoningStrike'},qBuff='Jade_NasusQ',
  stacks='Jade_NasusQStacks',qAttack='Jade_NasusSiphoningStrikeAttack',
  w='Jade_NasusW',e='Jade_NasusE',r='Jade_NasusR',qBase=D.Jade_NasusQ.BonusDamage,eBase=D.Jade_NasusE.InitialDamages,
   qRangeBonus=0,stackSmall=3,stackLarge=6,eDelay=.325,eAP=.6,eArmorKind='flat',eArmor=D.Jade_NasusE.TotalArmorShred,
   eRadius=400,eTick=D.Jade_NasusE.TickDamage,eTickAP=.12,eDuration=5,source='https://wiki.leagueoflegends.com/en-us/League_Classic/Nasus (read 2026-10-08)',
   -- League_Classic/Nasus read 2026-10-10: E initial damage 0.264 s after the cast; R cast 0.2 s, 15 s, +300/450/600
   -- health kept after the duration (offered for the 15 s only); W range 700.
   eBurstDelay=.264,wRange=D.Jade_NasusW.castRange,rHealth={300,450,600},rCast=.2,rDuration=D.Jade_NasusR.Duration,
   wardKillHealth=1,rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Nasus (read 2026-10-10): R +300/450/600 health, cast 0.2 s, 15 s'},
}

end
end
