return function(require)
-- Dangerous unit-targeted enemy spells that Evade has no threat row for (no cast
-- definition, no locked row). An enemy cast whose native activeSpell target is the
-- player becomes a defence-only targeted row ONLY when its native name is listed
-- here AND the caster's own-profile catalogue set carries an asset record of that
-- name (identity and profile check). Every other unlisted targeted cast is ignored:
-- its damage is unknown and the SDK has no spell-damage estimate Evade may use.
-- Damage stays unknown; `tier` stands in for severity (4-5: a defensive answer is
-- worth it), `ccHard` marks reviewed hard control without a claimed duration.
-- `speed`: own projectile travel to the player after cast end (world units/s);
-- absent means the impact is taken at cast end (instant model, `window` seconds
-- of contact slack). Normal profile only: no Classic name is listed (a Jade_ name
-- is never derived from a normal one). Names: own catalogue asset records 26.20
-- (Scripts/Common/EvAYYYYde/catalog.lua). Mechanics: League wiki champion data
-- pages, read 2026-10-10. Timing and the native target field are unaccepted live.
local wiki='League wiki Template:Data_<champion> (read 2026-10-10); name from own asset record; live timing unaccepted'
return {
    SyndraR={tier=5,source=wiki,note='Unleashed Power: execute-scaling burst; sphere travel speed unpublished (instant model)',window=.35},
    VayneCondemn={tier=4,ccHard=true,speed=2200,source=wiki,note='Condemn: knockback, stun against terrain; bolt speed 2200'},
    RyzeW={tier=4,ccHard=true,source=wiki,note='Rune Prison: root'},
    NautilusGrandLine={tier=5,ccHard=true,source=wiki,note='Depth Charge: knock-up; travel speed unpublished (instant model)',window=.5},
    CaitlynR={tier=5,speed=3200,source=wiki,note='Ace in the Hole: 1 s channel then a 3200 speed bullet'},
    JayceThunderingBlow={tier=4,ccHard=true,source=wiki,note='Thundering Blow: knockback'},
    MaokaiW={tier=4,ccHard=true,source=wiki,note='Twisted Advance: dash to target and root'},
    LuluW={tier=4,ccHard=true,source=wiki,note='Whimsy on an enemy: polymorph (disarm + silence)'},
    CamilleR={tier=4,ccHard=true,source=wiki,note='The Hextech Ultimatum: leap, knockback of nearby enemies, zone lock'},
    SettR={tier=4,ccHard=true,source=wiki,note='The Show Stopper: suppression while carried'},
    MordekaiserR={tier=4,source=wiki,note='Realm of Death: banished with Mordekaiser'},
}

end
