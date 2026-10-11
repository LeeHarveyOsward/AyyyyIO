return function(require)
return function()
-- Lux mechanics, Normal and Classic kept separate (no value is borrowed across profiles).
-- Provenance: CombatProfiles/lux-provenance.json. Arrays are indexed by spell rank (passive: by champion level).
-- Ranges are the maintained conservative values (display ranges); the wiki/asset maxima are recorded in the
-- provenance file and are settled from the development trace lux_cast_reach before any range is widened.
return {
 Lux={id='normal',qCast='LuxLightBinding',wCast='LuxPrismaticWave',eCast='LuxLightStrikeKugel',
  eToggle='LuxLightstrikeToggle',rCast='LuxR',mark={'LuxIlluminatingFraulein'},
  -- Q: 80-240 +75% AP; roots the first TWO enemies for 2 s, both at full damage (no second-target factor).
  qBase={80,120,160,200,240},qAP=.75,qSecond=1,qRoot=2,qSecondRoot=2,qRange=1175,qSpeed=1200,qRadius=70,qDelay=.25,
  -- W: 40-100 +40% AP for 2.5 s, out and back (a unit passed twice holds two shields; one is offered).
  wBase={40,55,70,85,100},wAP=.4,wRange=1100,wSpeed=2200,wRadius=110,wDelay=.25,wDuration=2.5,
  wSource='Normal W 40/55/70/85/100 +40% AP, 2.5 s, cast .25: research/family-assets/Lux/spells.json (LuxPrismaticWave BaseShieldAmount, APRatio, ShieldDuration) and https://wiki.leagueoflegends.com/en-us/Lux (read 2026-10-10, V26.04)',
  -- E: 65-265 +80% AP, asset radius 295 (wiki 310), range 1100, missile 1300, zone 5 s.
  eBase={65,115,165,215,265},eAP=.8,eRange=1100,eSpeed=1300,eRadius=295,eDelay=.25,eZone=5,
  -- Normal Lux cannot recast during Final Spark's cast; only Classic 26.17 allows the detonation then.
  eDuringR=false,
  -- R: 300/400/500 +120% AP, 1 s cast, half-width 95 (asset lineWidth 190; wiki 200).
  rBase={300,400,500},rAP=1.2,rRange=3340,rRadius=95,rDelay=1,
  -- Illumination: 20 + 10 per level (+35% AP), mark 6 s, consumed by an attack or R.
  pFlat=20,pLevel=10,pAP=.35,pMark=6},
 Jade_Lux={id='classic',qCast='Jade_LuxLightBinding',wCast='Jade_LuxPrismaticWave',eCast='Jade_LuxLightStrikeKugel',
  eToggle='Jade_LuxLightstrikeToggle',rCast='Jade_LuxR',mark={'Jade_LuxIlluminatingFraulein','LuxIlluminatingFraulein'},
  -- Q: 60-260 +70% AP; passes one unit, the second takes half damage and a 1 s root.
  qBase={60,110,160,210,260},qAP=.7,qSecond=.5,qRoot=2,qSecondRoot=1,qRange=1175,qSpeed=1200,qRadius=70,qDelay=.25,
  -- Shield numbers for the Evade offer. Lux herself is shielded when the cast starts (Classic Patch 2:
  -- "Shield now occurs at cast time instead of after cast time"); the offer still declares the full
  -- .25 s cast, so its window starts late rather than early. The wiki lists range 1175 and speed 2400
  -- and the asset shows display range 1150 / missile 1200: wRange and wSpeed are the maintained
  -- conservative values and only decide the ally reach, not the self shield.
  wBase={80,105,130,155,180},wAP=.35,wRange=1100,wSpeed=1400,wRadius=110,wDelay=.25,wDuration=3,
  wSource='Classic W 80/105/130/155/180 +35% AP, 3 s, cast .25: research/family-assets/Jade_Lux/spells.json (BaseShieldAmount, APRatio, ShieldDuration) and https://wiki.leagueoflegends.com/en-us/League_Classic/Lux (2026-10-08)',
  eBase={60,105,150,195,240},eAP=.6,eRange=1000,eSpeed=1300,eRadius=350,eDelay=.25,eZone=5,
  eDuringR=true,
  rBase={300,400,500},rAP=.85,rRange=3340,rRadius=95,rDelay=1,
  -- Illumination: 20 at level 1 to 190 at level 18, no AP (asset calc {20,190}, linear by level assumed).
  pFlat=10,pLevel=10,pAP=0,pMark=6},
}

end
end
