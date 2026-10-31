return function(require)
return function()
-- Shared Normal Yone data; no Classic mechanics are inferred.
local D=(function()
return {
 YoneQ={
  ADRatio=1.05,BaseDamage={25,50,75,100,125},Q3DashSpeed=1500,Q3KnockupDuration=.75,QBaseCastTime=.35,
 },
 YoneR={
  ADRatio=.8,BaseDamage={200,400,600},
 },
 YoneW={
  BaseDamage={10,20,30,40,50},ShieldDuration=1.5,ShieldbADRatio=.65,castConeDistance=600,
 },
}
end)()
return {
 Yone={id='normal',q='YoneQ',q3='YoneQ3',w='YoneW',e='YoneE',r='YoneR',qAD=D.YoneQ.ADRatio,qBase=D.YoneQ.BaseDamage,wBase=D.YoneW.BaseDamage,wHealth={.08,.09,.10,.11,.12},rBase=D.YoneR.BaseDamage,
 -- W reach 600: https://wiki.leagueoflegends.com/en-us/Template:Data_Yone/Spirit_Cleave ("EFFECT RADIUS: 600", angle 80), read 2026-10-08.
 -- The installed asset lists YoneW castRange 700 (a cast range, what the controller used before); the cone itself is
 -- 600 on the wiki and in the reference script. The shorter value only refuses casts between 600 and 700.
 wRange=D.YoneW.castConeDistance,
 -- W against monsters: the same page gives "a maximum threshold of 150 - 340 (based on level) against monsters" with no
 -- per-level table, so only the level-1 end is used: a lower bound of the damage at every level. The minion "minimum
 -- threshold of 40 - 490 (based on level)" is NOT applied: the page does not say whether it replaces the 25% minion
 -- damage or is reduced with it, and it has no per-level table (the reference script's 20-step table is a lead only).
 wMonsterCap=150,
 -- Rerank data_accuracy (2026-10-10): the per-level tables are in the installed asset (research/family-assets/Yone/
 -- spells.json YoneW mSpellCalculations): 2282348956 lists the monster maximum 140 + 10 per champion level (150 at
 -- level 1 ... 340 at 20), 1835163517 the minion minimum 30 + 10 per level, +20 from level 9, +40 from level 14 (40 at
 -- level 1 ... 490 at 20). They match the wiki ranges (Yone V26.19: 150 - 340 against monsters, minimum 40 - 490
 -- against minions) and zgYone.lua:314-320. The minion minimum is a floor under the 25% minion damage (MinionMod).
 -- wMonsterCap stays the bound when the champion level cannot be read.
 wMonsterCapByLevel={150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340},
 wMinionFloor={40,50,60,70,80,90,100,110,130,150,170,190,210,250,290,330,370,410,450,490},
 wLevelSource='research/family-assets/Yone/spells.json YoneW mSpellCalculations 2282348956 (monster maximum) and 1835163517 (minion minimum), installed asset read 2026-10-10; wiki Yone V26.19 ranges 150-340 / 40-490',
 -- R: https://wiki.leagueoflegends.com/en-us/Template:Data_Yone/Fate_Sealed, read 2026-10-08: "200 / 400 / 600 (+ 80% bonus AD)",
 -- half physical half magic, cast 0.75, range 1000, width 225, blink 200 beyond the last champion, knock-up 0.75 s.
 -- yone-provenance.json recorded the asset ratio as "total_ad_ratio 0.8"; the wiki and the reference script both say bonus
 -- AD, which is also the lower figure, so kill estimates use bonus AD.
 rBonusAD=D.YoneR.ADRatio,
 -- Q3: knock-up 0.75 s (Template:Data_Yone/Mortal_Steel, read 2026-10-08). q3Reach 950 is the installed asset's
 -- YoneQ3Missile castRange (the distance the whirlwind's centre travels; yone-provenance.json q3.projectile_range).
 -- q3ReachUpper 1050 is the same asset's YoneQ3 targeter line length (the drawn indicator, with a 100-unit locator
 -- offset on that line), which is what the wiki's "1050 centred" and the rivals copy (re-read 2026-10-10,
 -- research/family-assets/Yone/spells.json YoneQ3 048557ff). They measure different things and the knock-up edge
 -- for a champion centre is not measured (dev trace yone_q3_hit). Dual bound: hits, counts and kill claims use 950;
 -- a player-requested Combo/Harass Q3 does not refuse a target only 1050 reaches (aimed along the same line), and
 -- Q3 + Flash spends Flash only on a target beyond 1050 (the plain Q3 cannot reach it even on the larger bound).
 q3Reach=950,q3ReachUpper=1050,
 -- q3Knockup is the buff name the reference script reads; not confirmed live, so the controller also accepts any
 -- knock-up or other hard crowd control read from the buff type.
 q3KnockupTime=D.YoneQ.Q3KnockupDuration,q3Knockup='yoneq3knockup',
 -- Q3 dash offered to Evade: fixed 450 at 1500, cast 0.35 at no bonus attack speed (the longest cast).
 q3Dash=450,q3DashSpeed=D.YoneQ.Q3DashSpeed,q3Cast=D.YoneQ.QBaseCastTime,
 -- E: https://wiki.leagueoflegends.com/en-us/Template:Data_Yone/Soul_Unbound (revision 2026-08-05, read 2026-10-10):
 -- the return repeats 25/27.5/30/32.5/35% of the post-mitigation damage Yone's attacks and abilities dealt to the
 -- marked champion as true damage; damage to shields is not stored; spirit 5 s, recast after 0.5 s.
 eStore={.25,.275,.30,.325,.35},
 -- W shield: wiki Yone V26.19 (read 2026-10-10): 40 - 95.88 by level (+65% bonus AD) for 1.5 s; no per-level table, so
 -- the level-1 end is the lower bound. W cast 0.5 at no bonus attack speed, 0.25 at the 50% cap this controller uses.
 -- Not verified on the host (yone-provenance shield_gate: installed .75 override, hit attribution): no Evade offer yet.
 wShieldBase=40,wShieldBonusAD=D.YoneW.ShieldbADRatio,wShieldDuration=D.YoneW.ShieldDuration,wCastLong=.5,wCastShort=.25,wShieldVerified=false,
 wShieldSource='Yone W shield: https://wiki.leagueoflegends.com/en-us/Yone (V26.19, read 2026-10-10) 40 - 95.88 by level (+65% bonus AD), 1.5 s; level-1 base used as the lower bound',
 mobilitySource='Yone Q3 dash: installed asset research/family-assets/Yone (yone-provenance.json q3.dash_distance 450, q3.dash_speed 1500, q.base_windup_seconds 0.35); the wiki page Template:Data_Yone/Mortal_Steel confirms cast 0.35 - 0.175 and "dashes a fixed distance" but states neither the distance nor the dash speed (read 2026-10-08)'}
}

end
end
