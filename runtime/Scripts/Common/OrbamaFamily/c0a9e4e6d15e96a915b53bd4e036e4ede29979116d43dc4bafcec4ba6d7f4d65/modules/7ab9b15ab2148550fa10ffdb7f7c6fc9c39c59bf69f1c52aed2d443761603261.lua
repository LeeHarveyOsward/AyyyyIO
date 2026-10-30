return function(require)
return function()
-- Karthus numbers that the controller reads beside AbilityProfiles.controllers.Karthus (abilities.lua is shared
-- data; these rows only add what the 2026-10-10 ranking work needed). Sources: karthus-provenance.json.
-- Lay Waste detonation: Normal wiki V26.03 (read 2026-10-10) gives 0.528-0.759 s after the 0.25 s cast and notes the
-- figure as inconsistent; both ends are planned against. Classic (League Classic wiki, fetched 2026-10-02) 0.5 s.
-- Requiem fog bound: last seen at most fogAge s ago (rival choice, unverified) plus fogMargin HP for unseen
-- consumables (unknown; conservative start, to be measured from logs); not used when last seen within fogBase
-- units of the enemy fountain (regeneration there is not modelled).
return {
 Karthus={id='normal',qDetonateMin=.528,qDetonateMax=.759,fogAge=5,fogMargin=150,fogBase=2500},
 Jade_Karthus={id='classic',qDetonateMin=.5,qDetonateMax=.5,fogAge=5,fogMargin=150,fogBase=2500},
}

end
end
