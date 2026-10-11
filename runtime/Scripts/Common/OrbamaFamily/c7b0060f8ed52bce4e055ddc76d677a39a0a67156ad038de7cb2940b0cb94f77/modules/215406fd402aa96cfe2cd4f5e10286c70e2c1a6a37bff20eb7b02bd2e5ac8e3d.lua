return function(require)
return function()
-- Shared Ezreal mechanics data. Values preserved from the maintained controller.
-- Reviewed 2026-10-08 (each profile from its own source; nothing is copied between them):
--  Normal E (Arcane Shift): blink, range 475, cast 0.25,
--   https://wiki.leagueoflegends.com/en-us/Template:Data_Ezreal/Arcane_Shift ("TARGET RANGE: 475", "CAST TIME: 0.25").
--  Normal W marks "the first enemy champion, epic monster, or structure hit" for 4 s; an attack or ability detonates it
--   for 80/135/190/245/300 +100% bonus AD +90% AP, https://wiki.leagueoflegends.com/en-us/Template:Data_Ezreal/Essence_Flux.
--  Classic E: range 475 (Jade_EzrealE castRangeDisplayOverride, research/family-assets/Jade_Ezreal/spells.json:1468),
--   cast 0.25 from https://wiki.leagueoflegends.com/en-us/League_Classic/Ezreal ("CAST TIME: 0.25", "TARGET RANGE: 475");
--   the asset field 11704a2b reads 0.25 on Jade_EzrealE (:1418) and 1.0 on Jade_EzrealR whose cast time is 1 s.
--  Classic Q range 1100 kept: the Classic wiki page says "TARGET RANGE: 1100" and the asset's effective range field is
--   1100 (ezreal-provenance.json); the reference script's 1050 is the asset's display override only.
--  Classic W kept at the asset values: castRange 1050 (spells.json:126), line width 100 (:312), movement speed 1600
--   (ezreal-provenance.json). The Classic wiki page lists range 1000 and speed 1550 and no width; that page describes
--   the ally-healing version of W, the installed asset is the profile that runs, so the asset decides. Both recorded.
-- E bolt (2026-10-10, ezreal-provenance.json): homes to the nearest enemy unit within MissileRange 750 of the landing
--  (an Essence Flux mark first). Normal research/family-assets/Ezreal/spells.json EzrealE BaseDamage 80..280, EAPRatio .75,
--  +60% bonus AD and speed 2000 (wiki Template:Data_Ezreal/Arcane_Shift, fetched 2026-10-10). Classic Jade_EzrealE
--  BaseDamage 75..275, EAPRatio .75, MissileRange 750; its bonus AD ratio and bolt speed are not in the asset fields read:
--  the ratio is left out (a lower bound) and the speed is a slow 1000 bound (a later impact only raises the requirement).
--  Q/W target range: wiki and asset castRange say 1200, the display override 1150; 1150 is kept until the ezreal_q_reach
--  development trace records landed hits beyond it.
return {
    Ezreal={id='normal',qRange=1150,qBase={20,45,70,95,120},qAD=1.3,qAP=.4,
        wRange=1150,wSpeed=1700,wRadius=80,wBase={80,135,190,245,300},wAP=.9,wAD=1,rBase={350,550,750},rAP=1.1,rAD=1,marks=true,
        e='EzrealE',eRange=475,eCast=.25,eBase={80,130,180,230,280},eAD=.6,eAP=.75,eBolt=750,eBoltSpeed=2000,
        eSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Ezreal/Arcane_Shift 2026-10-08: blink, range 475, cast 0.25'},
    Jade_Ezreal={id='classic',qRange=1100,qBase={40,65,90,115,140},qAD=1.1,qAP=0,
        wRange=1050,wSpeed=1600,wRadius=100,wBase={80,130,180,230,280},wAP=.6,wAD=0,rBase={350,500,650},rAP=1,rAD=0,marks=false,
        e='Jade_EzrealE',eRange=475,eCast=.25,eBase={75,125,175,225,275},eAD=0,eAP=.75,eBolt=750,eBoltSpeed=1000,
        eSource='research/family-assets/Jade_Ezreal/spells.json (range 475, field 11704a2b 0.25) and https://wiki.leagueoflegends.com/en-us/League_Classic/Ezreal (cast 0.25) 2026-10-08'},
}

end
end
