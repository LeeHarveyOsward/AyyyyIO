return function(require)
return function()
-- Shared Leona mechanics data. Values preserved from the maintained controller.
-- Classic E (checked 2026-10-08, https://wiki.leagueoflegends.com/en-us/League_Classic/Leona): blade speed 2000
-- and cast 0.25 confirmed (a reference script's 1200 has no support). `width` is used as the blade radius:
-- 90 is the Jade_ missile record and the pre-V5.10 value; the Classic page lists WIDTH 140 (radius 70), possibly
-- inherited from the modern template. Unresolved; 90 stays until an asset or live measurement decides.
-- No Evade offer for E in either profile: the dash speed is in neither the wiki nor the asset, and the dash
-- needs a champion hit. W is a resistance buff (Classic) / flat reduction (Normal), not a shield or a share.
-- 2026-10-10 (wiki Leona V25.20 and League_Classic/Leona, read 2026-10-10; spells.json *ZenithBladeMissile castRange 900):
-- E range 900 both profiles. R: cast 0.25 then impact 0.625 (summed: whether the wiki's impact delay starts at the
-- cast end is measured by the leona_r_impact dev trace), epicenter radius 100 stuns, area radius 325 slows and damages;
-- stun 1.75 s Normal (asset LeonaSolarFlare CCDuration) / 1.5 s Classic (asset Jade_LeonaSolarFlare CCDuration).
-- Q bonus attack range 50. Classic W bonus armor and magic resistance 30/40/50/60/70 for 3 s (asset Jade_LeonaSolarBarrier
-- BonusARMR/BuffDuration; the unreferenced Barrier2 record carries the same BonusARMR).
-- Normal W (Template:Data_Leona/Eclipse read 2026-10-10; asset LeonaSolarBarrier ArmorBaseBonus/MRBaseBonus and
-- ArmorMRDuration): armor and magic resistance 20/27.5/35/42.5/50 (+20% bonus armor/MR) for 3 s, cast time none,
-- plus a flat reduction 8-24 per hit (at most 50%). Offered to Evade as `resist` with the rank base only: the 20%
-- scaling, the flat reduction and the 3 s extension on a hit are left out, so the offer is a lower bound.
return {
 Leona={classic=false,q={10,35,60,85,110},e={50,90,130,170,210},r={150,225,300},width=70,
  qBuff='LeonaShieldOfDaybreak',eCast='LeonaZenithBlade',root='LeonaZenithBladeRoot',sunlight='LeonaSunlight',wBuff='LeonaSolarBarrier',
  eRange=900,rCast=.25,rImpact=.625,rEpicenter=100,rArea=325,rStun=1.75,qBonusRange=50,
  wResist={20,27.5,35,42.5,50},wDuration=3,w='LeonaSolarBarrier',
  wSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Leona/Eclipse (cast time none, armor/MR 20-50 for 3 s) + family-assets/Leona/spells.json LeonaSolarBarrier ArmorBaseBonus/MRBaseBonus/ArmorMRDuration, read 2026-10-10; rank base only (lower bound)'},
 Jade_Leona={classic=true,q={40,70,100,130,160},e={60,100,140,180,220},r={150,250,350},width=90,
  qBuff='Jade_LeonaShieldOfDaybreak',eCast='Jade_LeonaZenithBlade',root='Jade_LeonaZenithBladeRoot',sunlight='Jade_LeonaSunlight',wBuff='Jade_LeonaSolarBarrier',
  eRange=900,rCast=.25,rImpact=.625,rEpicenter=100,rArea=325,rStun=1.5,qBonusRange=50,
  wResist={30,40,50,60,70},wDuration=3,w='Jade_LeonaSolarBarrier',
  wSource='family-assets/Jade_Leona/spells.json Jade_LeonaSolarBarrier BonusARMR/BuffDuration + wiki League_Classic/Leona, read 2026-10-10'}
}

end
end
