return function(require)
return function()
-- Shared Malphite mechanics data. Values preserved from the maintained controller.
return {
 Malphite={id='normal',q='SeismicShard',w='Obduracy',e='Landslide',r='UFSlash',shield='MalphiteShield',
   wKind='reset_splash',wDuration=5,qBase={70,120,170,220,270},qAP=.6,eBase={60,95,130,165,200},eAP=.6,eArmor=.4,
   -- Unstoppable Force. The speed is 1500 + 100% movement speed (base 335 = 1835); a registration takes fixed
   -- numbers, so rSpeeds is a bracket whose slow end (a roughly 40% slowed Malphite) is the safety margin.
   rBase={200,300,400},rAP=.9,rRange=1000,rSpeeds={1700,1835},rDelays={0},
   rSource='https://wiki.leagueoflegends.com/en-us/Malphite Unstoppable Force: range 1000, no cast time, speed 1500 + 100% movement speed, 200/300/400 (+90% AP), base movement speed 335 (read 2026-10-08)',
   -- 2026-10-10 (wiki Malphite V26.09 read 2026-10-10; spells.json UFSlash KnockupDuration, Obduracy Thunderclap*).
   -- R prediction speed 1500 + current movement speed (rBaseSpeed), knock-up 1.5 s. Hit radius 270 (asset castRadius) is
   -- kept for counting; the wiki's 325 effect radius waits for the malphite_r_landing dev trace (rEffectRadius unused).
   -- W Thunderclap on-hit 30/40/50/60/70 (+20% AP) (+15% armor) physical while W is active.
   rBaseSpeed=1500,rKnockup=1.5,rRadius=270,rEffectRadius=325,wOnHit={30,40,50,60,70},wOnHitAP=.2,wOnHitArmor=.15},
 Jade_Malphite={id='classic',q='Jade_MalphiteSeismicShard',w='Jade_MalphiteObduracy',e='Jade_MalphiteLandslide',r='Jade_MalphiteUFSlash',shield='Jade_MalphiteShield',
   wBuff='Jade_MalphiteObduracyBuff',wKind='ad_armor_boost',wDuration=6,qBase={70,120,170,220,270},qAP=.6,eBase={60,100,140,180,220},eAP=.2,eArmor=.3,
   -- The Classic page gives the same dash shape as Normal (the asset holds only castRange 1000, spells.json:496).
   rBase={200,300,400},rAP=1,rRange=1000,rSpeeds={1700,1835},rDelays={0},
   rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Malphite Unstoppable Force: range 1000, no cast time, speed 1500 + 100% movement speed, 200/300/400 (+100% AP), base movement speed 335 (read 2026-10-08)',
   -- 2026-10-10 (wiki League_Classic/Malphite edited 2026-09-22, read 2026-10-10; spells.json Jade_MalphiteUFSlash
   -- KnockupDuration, Jade_MalphiteObduracy ADBonus 0.20..0.40 for 6 s). Same dash model and counting radius as Normal.
   rBaseSpeed=1500,rKnockup=1.5,rRadius=270,rEffectRadius=325,wAD={.2,.25,.3,.35,.4}},
}

end
end
