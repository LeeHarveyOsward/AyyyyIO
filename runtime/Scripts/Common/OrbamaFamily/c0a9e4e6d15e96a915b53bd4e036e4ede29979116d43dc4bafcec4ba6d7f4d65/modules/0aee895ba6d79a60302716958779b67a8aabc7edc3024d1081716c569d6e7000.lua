return function(require)
return function()
-- Shared Akali mechanics data. Values preserved from the maintained controller.
-- Classic Shadow Dance range, three sources (2026-10-08), resolved by profile match, not averaged:
--   800  installed asset research/family-assets/Jade_Akali/spells.json, the Shadow Dance record (S3 icon, base
--        100/175/250, 0.5 AP, 3 charges, recharge 25/20/15): castRange 800, DashDistance 715. This is the server's
--        own record, so r=800.
--   700  https://wiki.leagueoflegends.com/en-us/League_Classic/Akali ("TARGET RANGE: 700", dash speed 2000): the
--        values after V5.2 ("range reduced to 700 from 800") and V5.9 ("dash speed increased to 2000 from 1600").
--   675  the controller's earlier figure, no source.
--   Not live-verified. A cast from beyond the real range makes the client walk into range first; it is not lost.
--   2026-10-10 (final data accuracy): re-read Jade_AkaliR: castRange 800, castRangeDisplayOverride 775, DashDistance
--   715, no dash speed. No field explains the page's 700, so r=700: centre-to-centre 700 is inside both the asset's
--   800 and the page's 700 under either range convention; the controller never casts out of range (it used to rely on
--   the client walking in from up to 800). Superseded: r=800.
-- Classic Shadow Dance is offered to Evade with a conservative bracket (2026-10-10), not a measurement: range 700,
-- both era speeds {1600,2000}, cast delays {0,.25} (mCastTime 0; the .25 field the Normal R shares with its wiki cast
-- time), and both possible end points - on the target, and DashDistance 715 along the line - must be clear under
-- every combination (rDash.onTarget). The reserve charge, turret, health and enemy-count limits apply.
-- Same Classic page: a champion takedown grants one charge; Crescent Slash is listed as physical
-- (30/55/80/105/130 + 60% AD + 40% AP) - the controller keeps the lower of physical and magical until seen live.
-- Normal r2Dash {750,800} (2026-10-10): the recast's targeter line in the installed AkaliRb record is 750 long
--   (048557ff dddc3025, width 90; castRange 25000, castRangeDisplayOverride 575); the wiki (read 2026-10-10) says the
--   recast dashes 800. Recipients are planned inside 750 (hit under both), and the landing at 750 and at 800 must both
--   pass the turret, terrain and dash limits.
-- Normal rDash (Perfect Execution, first cast), https://wiki.leagueoflegends.com/en-us/Akali read 2026-10-08:
--   target range 675 (enemy champion), cast time 0.25, speed 1500, dashes 750 toward the target and at least 150
--   past it. Shuriken Flip's backflip (up to 400, speed not stated for the flip itself) is not offered.
-- Ranking pass 2026-10-10 (experiments/champion-ranking-20261010/dossiers/Akali.md):
--   Classic w 700 -> 475: Twilight Shroud radius 475 (cast range 270), https://wiki.leagueoflegends.com/en-us/League_Classic/Akali
--     read 2026-10-10. Drawing only; W is cast on Akali's own position.
--   Classic qMark: Mark of the Assassin detonation by the next attack or Crescent Slash, 45/70/95/120/145 + 40% AP magic,
--     same Classic page read 2026-10-10. Treated as confirmed damage only with a live owned mark and a ready attack in range.
--   Normal r2Window 10 / r2Delay 2.5: the recast is available 2.5 s after the first cast, within 10 s (wiki Akali read
--     2026-10-10). The self-buff alias 'AkaliR' (PussyAIO) is unverified: the window end is the earlier of that buff's
--     expiry and 10 s after the recast stage was first seen; the dev recorder traces the observed length (akali_r2_window).
--   Normal qFan: Five Point Strike range 500, angle 20 degrees (wiki infobox read 2026-10-10; the installed asset carries
--     castRange 550 and no angle field). The narrower 20 degree cone undercounts a wider real fan, so it is conservative
--     for hit counts. Needs a live geometry check.
--   Normal e2KillRange 1500: the E recast reaches the marked target at any distance (wiki read 2026-10-10); 1500 is the
--     policy bound for a recast that kills by itself, 1000 for every other recast.
-- Classic q 575: Jade_AkaliQ castRangeDisplayOverride (castRange 600), 16.21 ability table 2026-10-28; the earlier
--   550 had no source.
local D=(function()
return {
 AkaliW={
  castRange=350,
 },
 AkaliQ={
  APRatio=.6,castRange=550,
 },
 AkaliR={
  CooldownBetweenCasts=2.5,castRange=675,mCastTime=.25,
 },
 AkaliE={
  TotalAPRatio=1.1,castRange=825,
 },
 Jade_AkaliR={
  DashDistance=715,
 },
 Jade_AkaliQ={
  APRatioInitial=.4,APRatioProc=.4,ProcDamageBase={45,70,95,120,145},castRangeDisplayOverride=575,
 },
 Jade_AkaliE={
  ERadius=325,TotalAPRatio=.4,
 },
}
end)()
return {
 Jade_Akali={id='classic',q=D.Jade_AkaliQ.castRangeDisplayOverride,w=475,e=D.Jade_AkaliE.ERadius,r=700,qAP=D.Jade_AkaliQ.APRatioInitial,eAP=D.Jade_AkaliE.TotalAPRatio,qMark={base=D.Jade_AkaliQ.ProcDamageBase,ap=D.Jade_AkaliQ.APRatioProc},
  rDash={name='Jade_AkaliR',range=700,speeds={1600,2000},castDelays={0,.25},onTarget=true,through=D.Jade_AkaliR.DashDistance,
   source='2026-10-10 conservative bracket: wiki League_Classic/Akali (target range 700, speed 1600 before V5.9, 2000 after) and installed Jade_AkaliR (castRange 800, DashDistance 715); both end points checked'}},
 Akali={id='normal',q=500,qHitRange=D.AkaliQ.castRange,w=D.AkaliW.castRange,e=D.AkaliE.castRange,r=D.AkaliR.castRange,qAP=D.AkaliQ.APRatio,eAP=D.AkaliE.TotalAPRatio,r2Window=10,r2Delay=D.AkaliR.CooldownBetweenCasts,qFan={range=500,angle=20},e2Range=1000,e2KillRange=1500,r2Dash={750,800},
  rDash={name='AkaliR',range=D.AkaliR.castRange,speeds={1500},castDelays={D.AkaliR.mCastTime},through=750,past=150,
   source='https://wiki.leagueoflegends.com/en-us/Akali 2026-10-08: Perfect Execution first cast range 675, cast 0.25, speed 1500, dash 750 and at least 150 past the target'}},
}

end
end
