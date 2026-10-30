return function(require)
return function()
-- Shared KogMaw mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 KogMawLivingArtillery={
  APRatio={.35,.4,.45},Damage={100,140,180},castFrameSeconds=.25,castRadius=240,castRange={1300,1550,1800},
 },
 KogMawQ={
  APRatio=.9,BaseDamage={80,125,170,215,260},castRangeDisplayOverride=1175,
 },
 KogMawQMis={
  mSpeed=1650,
 },
 KogMawVoidOozeMissile={
  castRange=1360,mSpeed=1400,
 },
 KogMawIcathianSurprise={
  TooltipPassiveDuration=4,
 },
 Jade_KogMawPassive={
  passiveDuration=4,
 },
 Jade_KogMawQ={
  APRatio=.7,BaseDamage={60,110,160,210,260},castRange=625,missileSpeed=1500,
 },
 Jade_KogMawR={
  ADRatio=.5,AOERadius=240,APRatio=.3,castFrameSeconds=.25,castRange={1400,1700,2000},
 },
 Jade_KogMawEMissile={
  castRange=1280,mSpeed=1400,
 },
}
end)()
return {
 KogMaw={id='normal',qRange=D.KogMawQ.castRangeDisplayOverride,qSpeed=D.KogMawQMis.mSpeed,qBase=D.KogMawQ.BaseDamage,qAP=D.KogMawQ.APRatio,
  rBuff='kogmawlivingartillerycost',rRange=D.KogMawLivingArtillery.castRange,
  rBase=D.KogMawLivingArtillery.Damage,rAD=.75,rAP=D.KogMawLivingArtillery.APRatio,
  -- R timing: asset castFrame 7.5 (0.25 s) = wiki "CAST TIME: 0.25"; then "drops to the target location
  -- after 0.6 seconds" (https://wiki.leagueoflegends.com/en-us/Kog'Maw, read 2026-10-08). The wiki states a
  -- landing delay after the cast time (same convention as Xerath W, Cho'Gath Q), so the total is .85 s.
  -- Before 2026-10-08 this was an unsourced .6 s total; third-party leads say 1.0-1.15 s. Not live-measured:
  -- the development r_outcome rows are the check. Radius 240 = wiki "EFFECT RADIUS: 240".
  rWindup=D.KogMawLivingArtillery.castFrameSeconds,rImpact=.6,rRadius=D.KogMawLivingArtillery.castRadius,
  -- E: wiki V26.16 (read 2026-10-10) range 1360, width 240, speed 1400; asset KogMawVoidOozeMissile castRange 1360.
  eRange=D.KogMawVoidOozeMissile.castRange,eSpeed=D.KogMawVoidOozeMissile.mSpeed,
  -- Icathian Surprise (death passive): asset KogMawIcathianDisplay TooltipPassiveDuration 4, TooltipPassiveMS .4,
  -- true damage ByCharLevelInterpolation 140 -> 650 (linear over levels 1..18); radius 400 from the wiki V26.16
  -- (read 2026-10-10). Buff name kogmawicathiansurprise (shared CannotDie list).
  passive={buffs={kogmawicathiansurprise=true},duration=D.KogMawIcathianSurprise.TooltipPassiveDuration,radius=400,damageStart=140,damageEnd=650}},
 -- Classic Q is UNIT-TARGETED, range 625: installed asset research/family-assets/Jade_KogMaw/spells.json
 -- `Jade_KogMawQ` has castRange 625, missileSpeed 1500, the basic attack's targeted transport and no lineWidth
 -- block (the real skillshot `Jade_KogMawE` carries lineWidth 120), which is the Season 3 spell (patch history:
 -- targeted until V4.4, range 625 since V1.0.0.118b). Disagreeing leads, recorded and not used: the wiki page
 -- https://wiki.leagueoflegends.com/en-us/League_Classic/Kog'Maw (read 2026-10-08) says range 600 and
 -- "direction-targeted"; ClassicKogMaw.lua casts a 1000-range line (the V4.4 spell). A cast on the unit inside
 -- 625 is right under either reading; only reach beyond 625 would differ, and nothing supports that.
 Jade_KogMaw={id='classic',qRange=D.Jade_KogMawQ.castRange,qSpeed=D.Jade_KogMawQ.missileSpeed,qBase=D.Jade_KogMawQ.BaseDamage,qAP=D.Jade_KogMawQ.APRatio,
  rBuff='jade_kogmawrcost',rRange=D.Jade_KogMawR.castRange,
  rBase={180,270,360},rAD=D.Jade_KogMawR.ADRatio,rAP={D.Jade_KogMawR.APRatio,D.Jade_KogMawR.APRatio,D.Jade_KogMawR.APRatio},
  -- R timing: windup .25 s = Jade_KogMawR castFrame 7.5 and live castEnd-castStart
  -- (session a1ed0e46). Impact remainder .85 s is an estimate (third-party evade
  -- totals 1.1-1.2 s from cast start); no Classic impact measurement exists yet,
  -- see the development r_outcome rows. Radius 240 = asset AOERadius/castRadius.
  -- The Classic wiki page (read 2026-10-08) says "lands after 0.6 seconds" (.85 s total with the cast) and
  -- "EFFECT RADIUS: 100"; both disagree with the asset/third-party values and are recorded only. E on that
  -- page: range 1280, speed 1350 (ours 1200 / 1400 from the asset's display range and child missile).
  rWindup=D.Jade_KogMawR.castFrameSeconds,rImpact=.85,rRadius=D.Jade_KogMawR.AOERadius,
  -- E: asset Jade_KogMawEMissile castRange 1280 (Classic wiki 1280; its speed 1350 is recorded, the asset's 1400 used).
  eRange=D.Jade_KogMawEMissile.castRange,eSpeed=D.Jade_KogMawEMissile.mSpeed,
  -- Death passive: asset Jade_KogMawPassive passiveDuration 4, damage 125+25 per level; the explosion radius has no
  -- Classic source, so pursuit stays off for Classic (development trace kogmaw_passive settles duration and damage).
  passive={buffs={jade_kogmawicathiansurprise=true,jade_kogmawpassivebuff=true},duration=D.Jade_KogMawPassive.passiveDuration,radius=nil,unknown='classic_radius_unmeasured'}},
}

end
end
