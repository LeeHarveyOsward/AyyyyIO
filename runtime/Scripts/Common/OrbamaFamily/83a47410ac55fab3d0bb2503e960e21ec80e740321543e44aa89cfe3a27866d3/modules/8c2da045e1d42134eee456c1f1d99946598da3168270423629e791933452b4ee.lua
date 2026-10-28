return function(require)
-- Live champion names (host charName) whose asset identity is spelled differently.
-- Catalogue and locked-threat data stay keyed by the asset identity; lookups by
-- charName resolve through this table. Each row needs live evidence.
--   Jade_Fiddlesticks: FamilyTelemetry 2026-10-27 reports charName Jade_Fiddlesticks for
--   the Classic kit whose asset is data/characters/jade_fiddlesticks as Jade_FiddleSticks.
--   Normal FiddleSticks matches its asset and needs no row.
local I={Jade_Fiddlesticks='Jade_FiddleSticks'}
function I.Resolve(name)return I[name]or name end
return I

end
