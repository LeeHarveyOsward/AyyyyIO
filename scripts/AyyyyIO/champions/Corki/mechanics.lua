return function(require)
return function()
-- Shared Corki mechanics data. Values preserved from the maintained controller unless a source is named.
-- Normal, https://wiki.leagueoflegends.com/en-us/Corki read 2026-10-08: Q "TARGET RANGE: 825", "EFFECT RADIUS: 275",
--  "SPEED: 1100"; W "300 - 600", cast time "none", speed "650 + 100% movement speed"; E "EFFECT RADIUS: 690",
--  35 degrees; R "TARGET RANGE: 1300 / 1500", "EFFECT RADIUS: 150 / 300", width 80, speed 2000, cast 0.175.
--  rRange/bigRange were 1225 (the display override) until 2026-10-08; the installed child missiles also say
--  1300/1500 (corki-provenance.json). splash was 200 until 2026-10-08. qRadius stays 250 (installed castRadius);
--  the wiki's 275 is recorded and the smaller value is used so a counted hit is one under either reading.
--  bigBuff is the entries.json alias; a third-party script uses `mbcheck2` for the pre-rework kit. Not live-verified.
-- Classic, https://wiki.leagueoflegends.com/en-us/League_Classic/Corki read 2026-10-08: W "RANGE: 800",
--  "SPEED: 650"; E "EFFECT RADIUS: 600"; R "TARGET RANGE: 1225", "EFFECT RADIUS: 75 / 150", speed 1950, Big One
--  "increased range" without a number (bigRange stays 1225). wRange 800 = that page and the installed
--  Jade_CorkiW MaxRange 800 (research/family-assets/Jade_Corki/spells.json; it was 600 until 2026-10-08).
--  splash 75 / 150 is the page; other leads say 150 / 250 (ClassicCorki.lua) and 200 / 300 (patch V1.0.0.63), so the
--  page value is the lower bound of all leads and a counted splash hit holds under each of them.
--  Classic Q stays the installed 600-range instant spell (Jade_CorkiQ castRange 600, missileSpeed 0); the page says
--  825 lobbed at speed 1000 (the V3.14 spell). Recorded, not used.
-- eAngle (Normal only): Gatling Gun cone 35 degrees, effect radius 690 (wiki Corki read 2026-10-10). Classic E is a
--  600 radius with no angle on the page; lane E stays off for Classic until it is measured.
-- wSpeed is the dash speed WITHOUT the movement-speed part (Normal adds 100% movement speed): a floor, so a
-- consumer never assumes a faster dash than the real one. wCast 0: Normal wiki "none"; the Classic asset block has no
-- cast-time field (spells that have one carry it) and the Classic page lists none.
return {
 Corki={id='normal',qRange=825,qSpeed=1100,qRadius=250,qBase={60,105,150,195,240},qAP=1,qBonusAD=1.25,
  rBase={90,170,250},rBonusAD=.85,rTotalAD=0,rAP=0,rMultiplier=2,rDamage='physical',
   bigBuff='corkimissilebarragecounterbig',rRange=1300,bigRange=1500,splash=150,bigSplash=300,maxAmmo=4,eRange=690,eAngle=35,
   wName='CarpetBomb',wMinRange=300,wRange=600,wSpeed=650,wCast=0,
   wSource='https://wiki.leagueoflegends.com/en-us/Corki Valkyrie range 300-600, no cast time, speed 650 + 100% movement speed (floor 650 declared), read 2026-10-08'},
 Jade_Corki={id='classic',qRange=600,qSpeed=math.huge,qRadius=250,qBase={80,130,180,230,280},qAP=.5,qBonusAD=0,
  rBase={120,190,260},rBonusAD=0,rTotalAD=.2,rAP=.3,rMultiplier=1.5,rDamage='magical',
   bigBuff='jade_corkir_check',rRange=1225,bigRange=1225,splash=75,bigSplash=150,maxAmmo=7,eRange=600,
   wName='Jade_CorkiW',wMinRange=300,wRange=800,wAssetMaxRange=800,wSpeed=650,wCast=0,
   wSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Corki Valkyrie RANGE 800, SPEED 650 (read 2026-10-08); research/family-assets/Jade_Corki/spells.json Jade_CorkiW MaxRange 800 / MinRange 300, no cast-time field'},
}

end
end
