return function(require)
-- Buffs that make a champion immune to crowd control (Leona-5, 2026-10-10). One list for every
-- consumer (the AyyyyIO core's C:CCImmune). Native buff names, compared lower case. Spell shields
-- (Sivir E, Banshee's Veil, Nocturne W) are not listed: they are buff types the core's
-- C:SpellShielded already reads. Invulnerability (Kayle R) is C:SpellProtected.
-- Sources (read 2026-10-10):
--   olafragnarok           Olaf R Ragnarok: wiki Olaf (immune to crowd control while active); name used by
--                          Lee Sin's kick list (CombatProfiles/leesin.lua) and asset OlafRagnarok.
--   morganae               Morgana E Black Shield: crowd control immunity while the shield holds (wiki
--                          Template:Data_Morgana/Black_Shield 2026-10-08; EvAYYYYde defensedata ccImmune).
--   malzaharpassiveshield  Malzahar Void Shift: "crowd control immunity and 90% damage reduction" (wiki
--                          Malzahar); name used by Lee Sin's kick list.
--   jade_olafr             Classic Olaf R: "cleansing himself of all crowd control and becoming immune to
--                          them" for 6 s (wiki League_Classic/Olaf). Asset entry Jade_OlafR; the buff carrying
--                          the spell's name follows Normal Olaf (OlafRagnarok), not live-verified.
--   jade_morganae          Classic Morgana E: "grants crowd control immunity while it holds" (wiki
--                          League_Classic/Morgana 2026-10-08). Asset entry Jade_MorganaE; buff = spell name as
--                          in Normal (MorganaE), not live-verified.
-- Not listed (no reviewed buff name or no immunity): Normal Sion R (unstoppable while charging; buff name
-- unknown, asset SionR/SionRRun unproven), Malphite/Volibear/Briar R, Classic Sion and Classic Malzahar
-- (no crowd control immunity on League_Classic pages).
local names={'OlafRagnarok','MorganaE','MalzaharPassiveShield','Jade_OlafR','Jade_MorganaE'}
local set={}
for _,name in ipairs(names)do set[name:lower()]=true end
return {names=names,set=set,
    Has=function(name)return type(name)=='string'and set[name:lower()]==true end}

end
