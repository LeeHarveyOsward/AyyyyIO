return function(require)
return function()
-- Shared Tristana mechanics data. Values preserved from the maintained controller.
-- Reviewed 2026-10-08 (each profile from its own source; nothing is copied between them):
--  Normal W (Rocket Jump): range 900, cast 0.25, speed 1100, 70/105/140/175/210 +100% bonus AD +50% AP magic,
--   https://wiki.leagueoflegends.com/en-us/Template:Data_Tristana/Rocket_Jump. The page notes "dash speed depends
--   on the distance of the jump": 1100 is the listed figure and is used for the full-length jump only.
--  Normal E crit scaling 40% of crit chance, +12% with Infinity Edge (item 3031),
--   https://wiki.leagueoflegends.com/en-us/Template:Data_Tristana/Explosive_Charge. Abilities add a stack; a stack
--   applied by R delays a full-stack detonation to the end of the knock-back.
--  Classic W: range 900 (asset castRangeDisplayOverride), cast 0.25 (asset field 11704a2b, the same field reads
--   1.0 on Jade_EzrealR whose cast time is 1 s), 70/115/160/205/250 +80% AP (asset BaseDamage/APRatio),
--   research/family-assets/Jade_Tristana/spells.json; speed 1100 from
--   https://wiki.leagueoflegends.com/en-us/League_Classic/Tristana (not in the asset: missileSpeed 20 is no dash speed).
--  Classic R range 550: asset castRange 550 (Jade_TristanaR, spells.json:837), speed 1600 (missileSpeed :901). The
--   Classic wiki page (re-opened 2026-10-08) lists no R target range, only cast 0.25 and "2000 / 1500" speeds, so the
--   asset decides. The asset range is fixed while E's is the attack range: R does not grow with Draw a Bead.
--   Measured centre to centre here, the conservative reading (the reference script uses 600; edge semantics unverified).
--  Classic W speed 1100 and cast 0.25 were read again on that page 2026-10-08 ("SPEED: 1100", "CAST TIME: 0.25").
--  Classic E burns for a fifth of its damage per tick (asset calculation, five ticks over GrievousDuration 5).
--  Q (Rapid Fire) lasts 7 s on both profiles: asset DataValues BuffDuration 7.0 (research/family-assets/Tristana and
--   Jade_Tristana spells.json, read 2026-10-10); Normal also https://wiki.leagueoflegends.com/en-us/Tristana 2026-10-10.
--   Only the drawn Q timer reads it.
return {
 Tristana={id='normal',q='TristanaQ',w='TristanaW',e='TristanaE',r='TristanaR',eKind='charge',qDuration=7,
  eBuff='tristanaecharge',eBase={60,85,110,135,160},eAD=.8,eAP=.5,eAmp=.25,eMax=4,eCrit=.4,eCritIE=.12,eCritItem=3031,eDuration=4,eSpeed=2400,eRadius=300,
  rBase={225,275,325},rAD=.7,rAP=1,rSpeed=2000,wRange=900,
  wDelay=.25,wSpeed=1100,wBase={70,105,140,175,210},wAD=1,wAP=.5,
  wSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Tristana/Rocket_Jump 2026-10-08: range 900, cast 0.25, speed 1100'},
 Jade_Tristana={id='classic',q='Jade_TristanaQ',w='Jade_TristanaW',e='Jade_TristanaE',r='Jade_TristanaR',eKind='dot',qDuration=7,
  eBuff='Jade_TristanaE_Debuff',eBase={110,150,190,230,270},eAD=0,eAP=1,eDuration=5,eTicks=5,eSpeed=1400,
  rBase={300,400,500},rAD=0,rAP=1.5,rSpeed=1600,rRange=550,wRange=900,
  wDelay=.25,wSpeed=1100,wBase={70,115,160,205,250},wAD=0,wAP=.8,
  wSource='research/family-assets/Jade_Tristana/spells.json (range 900, cast 0.25) and https://wiki.leagueoflegends.com/en-us/League_Classic/Tristana (speed 1100) 2026-10-08'},
}

end
end
