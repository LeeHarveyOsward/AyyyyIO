return function(require)
return function()
-- Ryze mechanics added by the 2026-10-10 ranking work. Damage, ranges and speeds stay in abilities.lua
-- (AbilityProfiles.controllers.Ryze and the geometry rows); this file holds only the numbers those rows lack.
-- Every row names its installed-asset field and the wiki page read that day; Normal and Classic are read from
-- their own assets (research/family-assets/Ryze, Jade_Ryze) and never borrowed. See ryze-provenance.json.
local D=(function()
return {
 RyzeQWrapper={
  MovementSpeedAmount={30,35,40,45,50},MovementSpeedDuration=2,RuneDuration=4,
 },
 RyzeR={
  MinimumCastRange=1000,castRange=3000,
 },
 RyzeE={
  BounceRadius=350,BounceRadiusLargeUnit=400,BounceRadiusQLargeUnit=500,BounceRadiusQSmallUnit=350,
 },
 Jade_RyzeR={
  Duration={5,6,7},MovementSpeed={60,70,80},
 },
 Jade_RyzeE={
  MaximumHits=5,ResistShred={12,15,18,21,24},
 },
 Jade_RyzeEMissile={
  BounceRadius=350,BounceRadiusLargeUnit=400,
 },
}
end)()
return {
 Ryze={id='normal',
  -- Bonus mana (Q/W/E scale with it, 2%/3%/2%): base mana 300 + 70 per level on the standard growth curve.
  manaBase=300,manaGrowth=70,manaSource='wiki Template:Data_Ryze mp_base 300 / mp_lvl 70, read 2026-10-10',
  -- Two Runes consumed by Q use the current per-rank movement speed for 2 s; Runes last 4 s.
  runeHaste={D.RyzeQWrapper.MovementSpeedAmount[1]/100,D.RyzeQWrapper.MovementSpeedAmount[2]/100,D.RyzeQWrapper.MovementSpeedAmount[3]/100,D.RyzeQWrapper.MovementSpeedAmount[4]/100,D.RyzeQWrapper.MovementSpeedAmount[5]/100},fluxBonus={.10,.40,.70,1},runeHasteDuration=D.RyzeQWrapper.MovementSpeedDuration,runeLife=D.RyzeQWrapper.RuneDuration,
  runeSource='Current installed RyzeQWrapper MovementSpeedAmount/MovementSpeedDuration/RuneDuration; implementation/family/current-patch.json',
  -- E spread: 350 to small units, 400 to large ones (asset BounceRadius/BounceRadiusLargeUnit). Counting uses the
  -- smaller, collateral checks the larger. Q spread off a marked unit: 350 small / 500 large (BounceRadiusQ*).
  eBounceMin=D.RyzeE.BounceRadius,eBounceMax=D.RyzeE.BounceRadiusLargeUnit,qBounceSmall=D.RyzeE.BounceRadiusQSmallUnit,qBounceLarge=D.RyzeE.BounceRadiusQLargeUnit,
  bounceSource='family-assets/Ryze/spells.json RyzeE BounceRadius/BounceRadiusLargeUnit/BounceRadiusQSmallUnit/BounceRadiusQLargeUnit, read 2026-10-10',
  -- Realm Warp: 1000 minimum, 3000 maximum.
  rMin=D.RyzeR.MinimumCastRange,rMax=D.RyzeR.castRange,rRangeSource='family-assets/Ryze/spells.json RyzeR MinimumCastRange/castRange + wiki en-us/Ryze, read 2026-10-10'},
 Jade_Ryze={id='classic',
  -- E bounces: 350 from the missile (small units), 400 on the spell and for large units; at most 5 hits.
  eBounceMin=D.Jade_RyzeEMissile.BounceRadius,eBounceMax=D.Jade_RyzeEMissile.BounceRadiusLargeUnit,eMaxHits=D.Jade_RyzeE.MaximumHits,
  bounceSource='family-assets/Jade_Ryze/spells.json Jade_RyzeEMissile BounceRadius 350/BounceRadiusLargeUnit 400, Jade_RyzeE BounceRadius 400/MaximumHits 5, read 2026-10-10',
  -- E magic resistance reduction while marked (applied to the follow-up only once our mark is seen).
  eShred=D.Jade_RyzeE.ResistShred,eShredSource='family-assets/Jade_Ryze/spells.json Jade_RyzeE ResistShred + wiki League_Classic/Ryze, read 2026-10-10',
  -- Desperate Power: flat movement speed and duration by rank, no cast time.
  rHaste=D.Jade_RyzeR.MovementSpeed,rDuration=D.Jade_RyzeR.Duration,rSource='family-assets/Jade_Ryze/spells.json Jade_RyzeR MovementSpeed/Duration + wiki League_Classic/Ryze, read 2026-10-10'},
}

end
end
