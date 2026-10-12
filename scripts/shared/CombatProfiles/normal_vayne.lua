return function(require)
-- Installed Normal Vayne assets, separate from Jade mechanics; live match pending.
-- Source: research/family-assets/Vayne/spells.json, VayneSilveredBolts.
-- Normal fixed monster damage: Riot patch 25.17 notes (2025-08-26),
-- https://www.leagueoflegends.com/en-sg/news/game-updates/patch-25-17-notes/
-- Pinned installed values agree; neither source establishes custom runtime behavior.
-- The shared native multiplicity/expiry/ownership decoder remains unchanged.
return function(shared)
    local P={buff='VayneSilveredDebuff',Stacks=shared.Stacks,AttacksToKill=shared.AttacksToKill}
    local ratio={.04,.055,.07,.085,.10}
    local floor={40,55,70,85,100}
    local monster={140,155,170,185,200}
    function P.Damage(source,target)
        local spell=source and source:GetSpellData(1)
        local rank=spell and spell.level or 0
        if not ratio[rank] or not target or not target.maxHealth then return 0 end
        if target.team==300 then return monster[rank] end
        return math.max(floor[rank],ratio[rank]*target.maxHealth)
    end
    return P
end

end
