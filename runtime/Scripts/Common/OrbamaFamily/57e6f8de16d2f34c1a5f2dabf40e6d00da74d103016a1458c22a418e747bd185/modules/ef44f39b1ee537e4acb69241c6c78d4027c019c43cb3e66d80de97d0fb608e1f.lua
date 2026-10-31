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
local D=(function()
return {
 TristanaE={
  APRatio=.5,ActiveBADRatio=.8,ActiveBaseDamage={60,85,110,135,160},PassiveRadius=300,mSpeed=2400,
 },
 TristanaR={
  APRatio=1,BaseDamage={225,275,325},mSpeed=2000,
 },
 TristanaQ={
  BuffDuration=7,
 },
 TristanaW={
  BaseDamage={70,105,140,175,210},castRangeDisplayOverride=900,
 },
 Jade_TristanaQ={
  BuffDuration=7,
 },
 Jade_TristanaE={
  ActiveAPRatio=1,ActiveDot={110,150,190,230,270},mSpeed=1400,
 },
 Jade_TristanaR={
  BaseDamage={300,400,500},mSpeed=1600,
 },
 Jade_TristanaW={
  APRatio=.8,BaseDamage={70,115,160,205,250},castRangeDisplayOverride=900,
 },
}
end)()
return {
 Tristana={id='normal',q='TristanaQ',w='TristanaW',e='TristanaE',r='TristanaR',eKind='charge',qDuration=D.TristanaQ.BuffDuration,
  eBuff='tristanaecharge',eBase=D.TristanaE.ActiveBaseDamage,eAD=D.TristanaE.ActiveBADRatio,eAP=D.TristanaE.APRatio,eAmp=.25,eMax=4,eCrit=.4,eCritIE=.12,eCritItem=3031,eDuration=4,eSpeed=D.TristanaE.mSpeed,eRadius=D.TristanaE.PassiveRadius,
  rBase=D.TristanaR.BaseDamage,rAD=.7,rAP=D.TristanaR.APRatio,rSpeed=D.TristanaR.mSpeed,wRange=D.TristanaW.castRangeDisplayOverride,
  wDelay=.25,wSpeed=1100,wBase=D.TristanaW.BaseDamage,wAD=1,wAP=.5,
  wSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Tristana/Rocket_Jump 2026-10-08: range 900, cast 0.25, speed 1100'},
 Jade_Tristana={id='classic',q='Jade_TristanaQ',w='Jade_TristanaW',e='Jade_TristanaE',r='Jade_TristanaR',eKind='dot',qDuration=D.Jade_TristanaQ.BuffDuration,
  eBuff='Jade_TristanaE_Debuff',eBase=D.Jade_TristanaE.ActiveDot,eAD=0,eAP=D.Jade_TristanaE.ActiveAPRatio,eDuration=5,eTicks=5,eSpeed=D.Jade_TristanaE.mSpeed,
  rBase=D.Jade_TristanaR.BaseDamage,rAD=0,rAP=1.5,rSpeed=D.Jade_TristanaR.mSpeed,rRange=550,wRange=D.Jade_TristanaW.castRangeDisplayOverride,
  wDelay=.25,wSpeed=1100,wBase=D.Jade_TristanaW.BaseDamage,wAD=0,wAP=D.Jade_TristanaW.APRatio,
  wSource='research/family-assets/Jade_Tristana/spells.json (range 900, cast 0.25) and https://wiki.leagueoflegends.com/en-us/League_Classic/Tristana (speed 1100) 2026-10-08'},
}

end
end
