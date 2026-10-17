return function(require)
return function()
-- Ryze mechanics added by the 2026-10-10 ranking work. Damage, ranges and speeds stay in abilities.lua
-- (AbilityProfiles.controllers.Ryze and the geometry rows); this file holds only the numbers those rows lack.
-- Every row names its installed-asset field and the wiki page read that day; Normal and Classic are read from
-- their own assets (research/family-assets/Ryze, Jade_Ryze) and never borrowed. See ryze-provenance.json.
return {
 Ryze={id='normal',
  -- Bonus mana (Q/W/E scale with it, 2%/3%/2%): base mana 300 + 70 per level on the standard growth curve.
  manaBase=300,manaGrowth=70,manaSource='wiki Template:Data_Ryze mp_base 300 / mp_lvl 70, read 2026-10-10',
  -- Two Runes consumed by Q: +28..44% movement speed for 2 s; Runes last 4 s.
  runeHaste={.28,.32,.36,.40,.44},runeHasteDuration=2,runeLife=4,
  runeSource='family-assets/Ryze/spells.json RyzeQWrapper MovementSpeedAmount/MovementSpeedDuration/RuneDuration + wiki Overload, read 2026-10-10',
  -- E spread: 350 to small units, 400 to large ones (asset BounceRadius/BounceRadiusLargeUnit). Counting uses the
  -- smaller, collateral checks the larger. Q spread off a marked unit: 350 small / 500 large (BounceRadiusQ*).
  eBounceMin=350,eBounceMax=400,qBounceSmall=350,qBounceLarge=500,
  bounceSource='family-assets/Ryze/spells.json RyzeE BounceRadius/BounceRadiusLargeUnit/BounceRadiusQSmallUnit/BounceRadiusQLargeUnit, read 2026-10-10',
  -- Realm Warp: 1000 minimum, 3000 maximum.
  rMin=1000,rMax=3000,rRangeSource='family-assets/Ryze/spells.json RyzeR MinimumCastRange/castRange + wiki en-us/Ryze, read 2026-10-10'},
 Jade_Ryze={id='classic',
  -- E bounces: 350 from the missile (small units), 400 on the spell and for large units; at most 5 hits.
  eBounceMin=350,eBounceMax=400,eMaxHits=5,
  bounceSource='family-assets/Jade_Ryze/spells.json Jade_RyzeEMissile BounceRadius 350/BounceRadiusLargeUnit 400, Jade_RyzeE BounceRadius 400/MaximumHits 5, read 2026-10-10',
  -- E magic resistance reduction while marked (applied to the follow-up only once our mark is seen).
  eShred={12,15,18,21,24},eShredSource='family-assets/Jade_Ryze/spells.json Jade_RyzeE ResistShred + wiki League_Classic/Ryze, read 2026-10-10',
  -- Desperate Power: flat movement speed and duration by rank, no cast time.
  rHaste={60,70,80},rDuration={5,6,7},rSource='family-assets/Jade_Ryze/spells.json Jade_RyzeR MovementSpeed/Duration + wiki League_Classic/Ryze, read 2026-10-10'},
}

end
end
