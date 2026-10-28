return function(require)
return function()
-- Shared Malphite mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 Obduracy={
  ThunderclapBaseDamage={30,40,50,60,70},ThunderclapBaseDamageAPRatio=.2,ThunderclapBaseDamageArmorRatio=.15,ThunderclapBuffDuration=5,
 },
 UFSlash={
  BaseDamage={200,300,400},KnockupDuration=1.5,castRadius=270,castRange=1000,
 },
 SeismicShard={
  BaseDamage={70,120,170,220,270},
 },
 Landslide={
  BaseDamage={60,95,130,165,200},
 },
 Jade_MalphiteLandslide={
  APScaling_Jade=.2,ArmorScaling_Jade=.3,BaseDamage={60,100,140,180,220},
 },
 Jade_MalphiteUFSlash={
  BaseDamage={200,300,400},KnockupDuration=1.5,castRadius=270,castRange=1000,
 },
 Jade_MalphiteObduracy={
  ADBonus={.2,.25,.3,.35,.4},BuffDuration=6,
 },
 Jade_MalphiteSeismicShard={
  BaseDamage={70,120,170,220,270},
 },
}
end)()
return {
 Malphite={id='normal',q='SeismicShard',w='Obduracy',e='Landslide',r='UFSlash',shield='MalphiteShield',
   wKind='reset_splash',wDuration=D.Obduracy.ThunderclapBuffDuration,qBase=D.SeismicShard.BaseDamage,qAP=.6,eBase=D.Landslide.BaseDamage,eAP=.6,eArmor=.4,
   -- Unstoppable Force. The speed is 1500 + 100% movement speed (base 335 = 1835); a registration takes fixed
   -- numbers, so rSpeeds is a bracket whose slow end (a roughly 40% slowed Malphite) is the safety margin.
   rBase=D.UFSlash.BaseDamage,rAP=.9,rRange=D.UFSlash.castRange,rSpeeds={1700,1835},rDelays={0},
   rSource='https://wiki.leagueoflegends.com/en-us/Malphite Unstoppable Force: range 1000, no cast time, speed 1500 + 100% movement speed, 200/300/400 (+90% AP), base movement speed 335 (read 2026-10-08)',
   -- 2026-10-10 (wiki Malphite V26.09 read 2026-10-10; spells.json UFSlash KnockupDuration, Obduracy Thunderclap*).
   -- R prediction speed 1500 + current movement speed (rBaseSpeed), knock-up 1.5 s. Hit radius 270 (asset castRadius) is
   -- kept for counting; the wiki's 325 effect radius waits for the malphite_r_landing dev trace (rEffectRadius unused).
   -- W Thunderclap on-hit 30/40/50/60/70 (+20% AP) (+15% armor) physical while W is active.
   rBaseSpeed=1500,rKnockup=D.UFSlash.KnockupDuration,rRadius=D.UFSlash.castRadius,rEffectRadius=325,wOnHit=D.Obduracy.ThunderclapBaseDamage,wOnHitAP=D.Obduracy.ThunderclapBaseDamageAPRatio,wOnHitArmor=D.Obduracy.ThunderclapBaseDamageArmorRatio},
 Jade_Malphite={id='classic',q='Jade_MalphiteSeismicShard',w='Jade_MalphiteObduracy',e='Jade_MalphiteLandslide',r='Jade_MalphiteUFSlash',shield='Jade_MalphiteShield',
   wBuff='Jade_MalphiteObduracyBuff',wKind='ad_armor_boost',wDuration=D.Jade_MalphiteObduracy.BuffDuration,qBase=D.Jade_MalphiteSeismicShard.BaseDamage,qAP=.6,eBase=D.Jade_MalphiteLandslide.BaseDamage,eAP=D.Jade_MalphiteLandslide.APScaling_Jade,eArmor=D.Jade_MalphiteLandslide.ArmorScaling_Jade,
   -- The Classic page gives the same dash shape as Normal (the asset holds only castRange 1000, spells.json:496).
   rBase=D.Jade_MalphiteUFSlash.BaseDamage,rAP=1,rRange=D.Jade_MalphiteUFSlash.castRange,rSpeeds={1700,1835},rDelays={0},
   rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Malphite Unstoppable Force: range 1000, no cast time, speed 1500 + 100% movement speed, 200/300/400 (+100% AP), base movement speed 335 (read 2026-10-08)',
   -- 2026-10-10 (wiki League_Classic/Malphite edited 2026-09-22, read 2026-10-10; spells.json Jade_MalphiteUFSlash
   -- KnockupDuration, Jade_MalphiteObduracy ADBonus 0.20..0.40 for 6 s). Same dash model and counting radius as Normal.
   rBaseSpeed=1500,rKnockup=D.Jade_MalphiteUFSlash.KnockupDuration,rRadius=D.Jade_MalphiteUFSlash.castRadius,rEffectRadius=325,wAD=D.Jade_MalphiteObduracy.ADBonus},
}

end
end
