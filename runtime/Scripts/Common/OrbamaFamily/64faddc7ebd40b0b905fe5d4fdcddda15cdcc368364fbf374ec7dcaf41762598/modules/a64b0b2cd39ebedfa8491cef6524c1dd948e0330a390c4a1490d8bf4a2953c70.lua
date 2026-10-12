return function(require)
return function()
-- Shared Nasus mechanics data. Values preserved from the maintained controller.
return {
 Nasus={id='normal',q={'NasusQ'},qBuff='NasusQ',stacks='NasusQStacks',qAttack='NasusQAttack',
  w='NasusW',e='NasusE',r='NasusR',qBase={30,50,70,90,110},eBase={50,80,110,140,170},
   qRangeBonus=50,stackSmall=4,stackLarge=10,eDelay=.25,eAP=.6,eArmorKind='percent',eArmor={30,35,40,45,50},
   -- Q 30..110 and E 50..170 (+60% AP) confirmed; area and burn from the same page.
   eRadius=400,eTick={10,16,22,28,34},eTickAP=.12,eDuration=5,source='https://wiki.leagueoflegends.com/en-us/Nasus (read 2026-10-08)',
   -- E initial hit lands 0.264 s after the cast; R bonus health, cast and duration; W range (wiki V26.19, read 2026-10-10).
   eBurstDelay=.264,wRange=700,rHealth={300,450,600},rCast=.2,rDuration=15,
   -- Wards give Q stacks. Damage of one melee hit on a ward is not measured: only a ward at 1 health counts as a sure kill.
   wardKillHealth=1,rSource='https://wiki.leagueoflegends.com/en-us/Nasus (V26.19, read 2026-10-10): R +300/450/600 health, cast 0.2 s, 15 s'},
 Jade_Nasus={id='classic',q={'Jade_NasusQ','Jade_NasusSiphoningStrike'},qBuff='Jade_NasusQ',
  stacks='Jade_NasusQStacks',qAttack='Jade_NasusSiphoningStrikeAttack',
  w='Jade_NasusW',e='Jade_NasusE',r='Jade_NasusR',qBase={30,50,70,90,110},eBase={55,95,135,175,215},
   qRangeBonus=0,stackSmall=3,stackLarge=6,eDelay=.325,eAP=.6,eArmorKind='flat',eArmor={20,25,30,35,40},
   eRadius=400,eTick={11,19,27,35,43},eTickAP=.12,eDuration=5,source='https://wiki.leagueoflegends.com/en-us/League_Classic/Nasus (read 2026-10-08)',
   -- League_Classic/Nasus read 2026-10-10: E initial damage 0.264 s after the cast; R cast 0.2 s, 15 s, +300/450/600
   -- health kept after the duration (offered for the 15 s only); W range 700.
   eBurstDelay=.264,wRange=700,rHealth={300,450,600},rCast=.2,rDuration=15,
   wardKillHealth=1,rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Nasus (read 2026-10-10): R +300/450/600 health, cast 0.2 s, 15 s'},
}

end
end
