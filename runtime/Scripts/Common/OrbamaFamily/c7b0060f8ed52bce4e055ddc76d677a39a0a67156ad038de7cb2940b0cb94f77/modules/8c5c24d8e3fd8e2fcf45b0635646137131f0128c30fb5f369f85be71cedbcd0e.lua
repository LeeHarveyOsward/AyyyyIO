return function(require)
return function()
-- Teemo numbers the controller adds to AbilityProfiles.controllers.Teemo (the shared abilities.lua row keeps Q speeds,
-- R ranges/speed, Normal armTime and E rows). Sources in teemo-provenance.json (read 2026-10-10).
--  rBase/rAP/rPoison: R poison 200/325/450 (+50% AP) magic damage over 4 s, both profiles (wiki Teemo and
--   League_Classic/Teemo; spells.json TeemoR / Jade_TeemoR DataValues BaseDamage, APRatio(PerTick), DebuffDuration).
--  rTrigger: trap trigger (collision) radius 160 (wiki; TeemoR TriggerRadius); Classic page lists 160 too.
--  blindBuff: Q debuff name BlindingDart in both assets (TeemoQ / Jade_TeemoQ buff name field).
--  spots: trap-spot catalogue from tools/teemo_trap_spots.py. Normal: the KillerAIO/WRAIO lead table checked against
--   our map 11 navigation grid (assets/maps/navgrid/map11/aipath_srx_2.aimesh_ngrid sha256 b7551b91dcdc3dec): open ground with 35 clearance,
--   tagged brush / edge (brush within 200) / choke (passage at most 700 wide), plus uncovered brush areas.
--   Classic: no lead table; the deepest cell of each brush area on the map 453 grid (assets/maps/navgrid/map453/aipath.aimesh_ngrid sha256
--   9a8f02985fa9ab4e). Static map evidence, not live-verified placements.
return {
 Teemo={id='normal',rBase={200,325,450},rAP=.5,rPoison=4,rTrigger=160,blindBuff='blindingdart',
  spots={map=11,rows={{1170,12320,'brush'},{1671,13000,'brush'},{2997,7597,'choke'},{2400,13511,'brush'},{3157,7206,'choke'},{3548,9286,'choke'},{3752,9437,'choke'},{3067,10899,'brush'},{3857,11358,'choke'},{3900,12829,'choke'},{4698,6140,'choke'},{4750,7211,'brush'},{4749,8022,'choke'},{4703,10063,'choke'},{4467,11841,'brush'},{6546,4723,'brush'},{6200,9288,'choke'},{6019,10405,'edge'},{6800,11558,'edge'},{6780,13011,'choke'},{7968,2197,'choke'},{7973,3362,'edge'},{7117,3100,'brush'},{7225,6216,'choke'},{7768,11808,'brush'},{7252,12546,'choke'},{8619,5622,'choke'},{8280,10245,'brush'},{9222,2129,'brush'},{9702,6319,'brush'},{9371,11445,'brush'},{9845,12060,'choke'},{10900,1970,'choke'},{10407,3091,'brush'},{10097,4972,'choke'},{10081,6590,'edge'},{10070,7299,'choke'},{11730,4091,'edge'},{11230,5575,'choke'},{11627,7103,'brush'},{12225,1292,'brush'},{12987,2028,'brush'},{12611,5318,'brush'},{12133,8821,'choke'},{13499,2837,'brush'},{5672,12696,'brush'},{2334,9710,'brush'},{9428,5612,'brush'},{8544,4808,'brush'},{7824,808,'brush'},{5474,3458,'brush'},{11874,5858,'brush'},{8374,6408,'brush'},{14074,6958,'brush'},{9974,7858,'brush'},{774,8158,'brush'},{6524,8358,'brush'},{3024,9058,'brush'},{5224,9158,'brush'},{7174,14058,'brush'}}}},
 Jade_Teemo={id='classic',rBase={200,325,450},rAP=.5,rPoison=4,rTrigger=160,blindBuff='blindingdart',
  spots={map=453,rows={{8375,1075,'brush'},{13025,1825,'brush'},{9825,2375,'brush'},{14025,2875,'brush'},{11025,3325,'brush'},{7275,3325,'brush'},{6225,3825,'brush'},{12625,3875,'brush'},{8675,3725,'brush'},{7125,4875,'brush'},{9075,5075,'brush'},{13125,5425,'brush'},{9675,6125,'brush'},{8825,6775,'brush'},{10125,6625,'brush'},{5425,7275,'brush'},{14725,7225,'brush'},{12175,7375,'brush'},{3875,8075,'brush'},{1375,8375,'brush'},{7125,8575,'brush'},{6075,8825,'brush'},{6025,9375,'brush'},{2825,10025,'brush'},{7075,10325,'brush'},{8875,10475,'brush'},{3275,11675,'brush'},{7175,11675,'brush'},{9825,11625,'brush'},{5075,12025,'brush'},{8375,12125,'brush'},{2025,13025,'brush'},{6225,13075,'brush'},{3125,13925,'brush'},{7975,14325,'brush'}}}},
}

end
end
