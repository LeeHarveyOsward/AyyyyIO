return function(require)
return function()
-- Shared KogMaw mechanics data. Values preserved from the maintained controller.
return {
 KogMaw={id='normal',qRange=1175,qSpeed=1650,qBase={80,125,170,215,260},qAP=.9,
  rBuff='kogmawlivingartillerycost',rRange={1300,1550,1800},
  rBase={100,140,180},rAD=.75,rAP={.35,.40,.45},
  -- R timing: asset castFrame 7.5 (0.25 s) = wiki "CAST TIME: 0.25"; then "drops to the target location
  -- after 0.6 seconds" (https://wiki.leagueoflegends.com/en-us/Kog'Maw, read 2026-10-08). The wiki states a
  -- landing delay after the cast time (same convention as Xerath W, Cho'Gath Q), so the total is .85 s.
  -- Before 2026-10-08 this was an unsourced .6 s total; third-party leads say 1.0-1.15 s. Not live-measured:
  -- the development r_outcome rows are the check. Radius 240 = wiki "EFFECT RADIUS: 240".
  rWindup=.25,rImpact=.6,rRadius=240,
  -- E: wiki V26.16 (read 2026-10-10) range 1360, width 240, speed 1400; asset KogMawVoidOozeMissile castRange 1360.
  eRange=1360,eSpeed=1400,
  -- Icathian Surprise (death passive): asset KogMawIcathianDisplay TooltipPassiveDuration 4, TooltipPassiveMS .4,
  -- true damage ByCharLevelInterpolation 140 -> 650 (linear over levels 1..18); radius 400 from the wiki V26.16
  -- (read 2026-10-10). Buff name kogmawicathiansurprise (shared CannotDie list).
  passive={buffs={kogmawicathiansurprise=true},duration=4,radius=400,damageStart=140,damageEnd=650}},
 -- Classic Q is UNIT-TARGETED, range 625: installed asset research/family-assets/Jade_KogMaw/spells.json
 -- `Jade_KogMawQ` has castRange 625, missileSpeed 1500, the basic attack's targeted transport and no lineWidth
 -- block (the real skillshot `Jade_KogMawE` carries lineWidth 120), which is the Season 3 spell (patch history:
 -- targeted until V4.4, range 625 since V1.0.0.118b). Disagreeing leads, recorded and not used: the wiki page
 -- https://wiki.leagueoflegends.com/en-us/League_Classic/Kog'Maw (read 2026-10-08) says range 600 and
 -- "direction-targeted"; ClassicKogMaw.lua casts a 1000-range line (the V4.4 spell). A cast on the unit inside
 -- 625 is right under either reading; only reach beyond 625 would differ, and nothing supports that.
 Jade_KogMaw={id='classic',qRange=625,qSpeed=1500,qBase={60,110,160,210,260},qAP=.7,
  rBuff='jade_kogmawrcost',rRange={1400,1700,2000},
  rBase={180,270,360},rAD=.5,rAP={.3,.3,.3},
  -- R timing: windup .25 s = Jade_KogMawR castFrame 7.5 and live castEnd-castStart
  -- (session a1ed0e46). Impact remainder .85 s is an estimate (third-party evade
  -- totals 1.1-1.2 s from cast start); no Classic impact measurement exists yet,
  -- see the development r_outcome rows. Radius 240 = asset AOERadius/castRadius.
  -- The Classic wiki page (read 2026-10-08) says "lands after 0.6 seconds" (.85 s total with the cast) and
  -- "EFFECT RADIUS: 100"; both disagree with the asset/third-party values and are recorded only. E on that
  -- page: range 1280, speed 1350 (ours 1200 / 1400 from the asset's display range and child missile).
  rWindup=.25,rImpact=.85,rRadius=240,
  -- E: asset Jade_KogMawEMissile castRange 1280 (Classic wiki 1280; its speed 1350 is recorded, the asset's 1400 used).
  eRange=1280,eSpeed=1400,
  -- Death passive: asset Jade_KogMawPassive passiveDuration 4, damage 125+25 per level; the explosion radius has no
  -- Classic source, so pursuit stays off for Classic (development trace kogmaw_passive settles duration and damage).
  passive={buffs={jade_kogmawicathiansurprise=true,jade_kogmawpassivebuff=true},duration=4,radius=nil,unknown='classic_radius_unmeasured'}},
}

end
end
