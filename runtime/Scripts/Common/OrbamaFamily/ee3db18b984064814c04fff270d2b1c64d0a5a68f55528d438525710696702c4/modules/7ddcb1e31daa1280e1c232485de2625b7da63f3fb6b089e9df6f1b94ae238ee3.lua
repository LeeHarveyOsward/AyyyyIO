return function(require)
return function()
-- Twitch numbers the controller adds to AbilityProfiles.controllers.Twitch (the shared abilities.lua row keeps
-- W/E/R shapes, poison/stealth names and E ratios). Sources in twitch-provenance.json (read 2026-10-10).
--  rBonusRange/rDuration/rBonusAD: spells.json TwitchFullAutomatic / Jade_TwitchR DataValues BonusRange, Duration,
--   BonusAD (ranks 1-3), wiki Twitch V26.16 for Normal.
--  rMarginSpeed: Normal R bolt speed is 5000 on the wiki but 4000 for TwitchSprayAndPrayAttack in the asset; until the
--   twitch_r_bolt dev trace settles it, interceptor margins and R-reach timing use the slower 4000 (conservative).
--   Classic Jade_TwitchR bolts: 4000 (asset).
--  dashLate: W is still worth casting at a dash end it reaches no later than this after the dash ends (controller
--   choice; W radius 300/275 covers the first steps after landing).
--  steal: epic monster names (Baron, Dragon, Herald, Atakhan; CombatProfiles/world.lua P.category), SRU_BaronSpawn excluded.
local D=(function()
return {
 TwitchFullAutomatic={
  BonusAD={30,45,60},BonusRange=300,Duration=6,
 },
 Jade_TwitchR={
  BonusAD={20,28,36},BonusRange=300,Duration=7,
 },
}
end)()
return {
 Twitch={id='normal',rBonusRange=D.TwitchFullAutomatic.BonusRange,rDuration=D.TwitchFullAutomatic.Duration,rBonusAD=D.TwitchFullAutomatic.BonusAD,rMarginSpeed=4000,rWindow=3,dashLate=.3},
 Jade_Twitch={id='classic',rBonusRange=D.Jade_TwitchR.BonusRange,rDuration=D.Jade_TwitchR.Duration,rBonusAD=D.Jade_TwitchR.BonusAD,rMarginSpeed=4000,rWindow=3,dashLate=.3},
}

end
end
