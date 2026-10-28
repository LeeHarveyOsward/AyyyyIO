return function(require)
return function()
-- Pantheon numbers the shared row in CombatProfiles/abilities.lua (M.controllers.Pantheon, not edited by the
-- champion work) does not carry. The controller overlays these on a private copy of that row.
local D=(function()
return {
 PantheonQMissile={
  mMissileWidth=55,mSpeed=2700,
 },
 PantheonE={
  RecastLockout=.3,ShieldDuration=1.5,SpearStrikesRadius=525,
 },
}
end)()
return {
 -- https://wiki.leagueoflegends.com/en-us/Pantheon read 2026-10-10: Q cast 0.2 s (the shared geometry row says .25),
 -- hurl +50% AP (execute +100% AP), the thrust has no AP ratio, the 50% hurl reduction applies only beyond the first
 -- unit hit; W +1.5% maximum health per 100 AP; Mortal Will empowered Q bonus 20-265.88 by level (standard growth
 -- curve assumed between the two ends); E channel 1.5 s, 60 degree cone, non-turret damage from the front blocked,
 -- strikes 1/12 of total AD every 0.125 s (100% AD over the channel), recast after 0.3 s or automatically at the end:
 -- slam 0.25 s cast, cone radius 525, 55-255 (+150% bonus AD).
 Pantheon={qCast=.2,qFlightSpeed=D.PantheonQMissile.mSpeed,qFlightRadius=D.PantheonQMissile.mMissileWidth,qHurlAP=.5,qExecuteAP=1,wHPPerAP=.00015,
  mortalWillMin=20,mortalWillMax=265.88,eBlockAngle=60,eBlockDuration=D.PantheonE.ShieldDuration,eStrikeAD=1/12,eStrikeInterval=.125,eStrikesMax=12,
  eSlamRadius=D.PantheonE.SpearStrikesRadius,eSlamCast=.25,eRecastAfter=D.PantheonE.RecastLockout,
  source='https://wiki.leagueoflegends.com/en-us/Pantheon (read 2026-10-10)'},
 -- https://wiki.leagueoflegends.com/en-us/League_Classic/Pantheon read 2026-10-10: Heartseeker Strike channels 0.75 s
 -- with three strikes; the controller keeps its 400 / 32 degree cone until the wiki 600 / 80 is measured.
 Jade_Pantheon={eChannel=.75,eStrikeInterval=.25,
  source='https://wiki.leagueoflegends.com/en-us/League_Classic/Pantheon (read 2026-10-10)'},
}

end
end
