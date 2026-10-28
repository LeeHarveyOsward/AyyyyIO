return function(require)
return function()
-- Shared Fiora mechanics data. Values preserved from the maintained controller.
-- Classic R repeat share, two sources that disagree (both read 2026-10-08, neither averaged):
--   rRepeat=.4       installed asset research/family-assets/Jade_Fiora/spells.json, Jade_FioraR ExtraHitDmgAmount
--                    (pinned by tests/check_fiora_profiles.py); used for the drawn upper estimate.
--   rRepeatFloor=.25 https://wiki.leagueoflegends.com/en-us/League_Classic/Fiora: "Hits against the same target
--                    beyond the first deal 25% damage", max single target "250 / 510 / 770 (+ 170% bonus AD)".
--                    The lower figure is the bound every kill decision on the full Waltz uses.
-- Classic W (same page): "parries the next enemy basic attack" for 1.5 s. It answers attacks only, so it is
-- not offered to Evade as a skillshot defence.
-- qDash: what Evade may assume about Lunge as a dodge.
--   Classic: unit-targeted, castRange 600 and DashMovespeedBonus 1200 (same asset). Whether 1200 is the dash
--            speed or an addition to movement speed is not stated, so both are declared per candidate
--            (1200 and 1200 + movement speed); no cast time is listed, 0 to .15 s is the planning bracket.
--            The Classic wiki page lists neither speed nor cast time (re-read 2026-10-08), so
--            established=false: the controller publishes NO Classic offer until a live measurement
--            settles speed, cast delay and landing spot; then set established=true.
--            Blade Waltz untargetability has no published duration either: not offered.
--   Normal:  https://wiki.leagueoflegends.com/en-us/Template:Data_Fiora/Lunge (2026-10-08): range 50 - 400,
--            cast time none, speed 1100 (+ 300% / 350% bonus movement speed), limits 850 and 1600.
-- wAttacks: empowered attacks and targeted casts W answers regardless of health.
--   Classic: the zg ClassicFiora 1.03 WAttackList (moved here unchanged, 2026-10-10).
--   Normal: DepressiveAIONext Fiora 2.2 RIPOSTE targeted entries (l.265-293), read 2026-10-10; spell names not yet
--   confirmed on this host (a wrong name never matches, it cannot cause a cast). SettR (The Show Stopper) is in the
--   list because EvAYYYYde marks it unmodeled; DariusExecute is left to Evade's locked row.
-- 2026-10-10 Normal additions (https://wiki.leagueoflegends.com/en-us/Template:Data_Fiora/Riposte and /Lunge, read
--   2026-10-10): W range 900 (was 750), width 140 (half 70), shock speed 3200 after a 0.5 s poise, damage
--   110/150/190/230/270 + 100% AP magic; stab radius 420, priority radius 252. rHorizon: the bounded duel horizon.
-- vitals: particle aliases from skin0-vitals.json; side mapping NE +z, NW +x, SE -x, SW -z (DepressiveAIONext 2.2
--   VITAL_OFFSETS l.1054-1059, Auto Fiora, PussyAIO agree). Reveal 1.75 s (passive) and 0.5 s (R) from the wiki
--   (2026-10-10). 2026-10-10 rule (replaces the static established=false gate): runtime facts verify each vital.
--   ownerRadius 100: the particle's distance from an enemy champion's edge; PussyAIO uses 50 from the centre, widened
--   so a particle drawn at the vital spot (edge + offset 50) still finds its owner; exactly one enemy may qualify,
--   two are ambiguous and refused. offsetMin 25: a particle at least this far from the owner's centre gives the
--   OBSERVED direction, which is used directly (no mapping needed); agreeCos .8 (about 37 degrees) judges it
--   against the name mapping, once per particle; a disagreement keeps the observed direction and is traced
--   ('fiora_vital_disagree'). A particle at the centre uses the mapping while the game has seen no disagreement;
--   after one it needs learnAfter=3 agreements and agreements >= 4x disagreements. reach 30: a Q endpoint within this of the vital point counts its damage.
--   Conservative engineering bounds, not measured numbers; 'fiora_vital' traces (dx/dz, basis, agrees) settle them.
local D=(function()
return {
 FioraQ={
  CDRefundPercent=.5,Damage={70,80,90,100,110},bADRatio={.9,.95,1,1.05,1.1},
 },
 FioraR={
  HealDuration=5,HealPerSecond={80,105,130},HealRingRadius=600,MarkDuration=8,Ratio=.7,castRange=500,
 },
 FioraWMissile={
  castRangeDisplayOverride=900,mMissileWidth=70,mSpeed=3200,
 },
 FioraW={
  BaseDamage={110,150,190,230,270},ParryDuration=.75,
 },
 FioraE={
  AttackTwoPercentTAD={1.6,1.7,1.8,1.9,2},BuffDuration=3,
 },
 Jade_FioraE={
  BuffDuration=3,
 },
 Jade_FioraR={
  AttackRadius=600,Damage={125,255,385},ExtraHitDmgAmount=.4,
 },
 Jade_FioraQ={
  Damage={40,65,90,115,140},DashMovespeedBonus=1200,RecastWindow=4,castRange=600,
 },
 Jade_FioraW={
  ParryDuration=1.5,
 },
}
end)()
local classicAttacks={
	["Jade_Leona"] = {"Jade_LeonaShieldOfDaybreakAttack", "Jade_LeonaShieldOfDaybreak"},
	["Jade_Blitzcrank"] = {"Jade_BlitzcrankPowerFistAttack", "Jade_BlitzcrankPowerFist"},
	["Jade_Garen"] = {"Jade_GarenQAttack", "Jade_GarenQ"},
	["Jade_XinZhao"] = {"Jade_XinZhaoQ_Thrust3", "Jade_XinZhaoQ_Knockup"},
	["Jade_TwistedFate"] = {"Jade_TwistedFate_GoldCardAttack", "Jade_TwistedFate_RedCardAttack", "Jade_TwistedFate_GoldCardLock", "Jade_TwistedFate_RedCardLock"},
	["Jade_Jax"] = {"Jade_JaxWAttack", "Jade_JaxW", "Jade_JaxRPassiveAttack"},
	["Jade_Nasus"] = {"Jade_NasusSiphoningStrikeAttack", "Jade_NasusQ"},
	["Jade_Wukong"] = {"Jade_WukongQ"},
	["Jade_Vayne"] = {"Jade_VayneQ_Attack", "Jade_VayneQ_Bonus"},
	["Jade_Shyvana"] = {"Jade_ShyvanaQ"},
	["Jade_Sivir"] = {"Jade_SivirWAttack", "Jade_SivirW"},
	["Jade_Kassadin"] = {"Jade_KassadinW", "Jade_KassadinW_Buff"},
	["Jade_Nidalee"] = {"Jade_NidaleeTakedown"},
	["Jade_Sona"] = {"Jade_SonaQ_Attack", "Jade_SonaW_Attack", "Jade_SonaE_Attack"},
	["Jade_Shaco"] = {"Jade_ShacoDeceive", "Jade_ShacoDeceiveCritBonus", "Jade_ShacoFromBehind"},
	["Jade_Kennen"] = {"Jade_KennenWPassiveProc"},
	["Jade_Ashe"] = {"Jade_AsheFrostArrow", "Jade_AsheQ"},
	["Jade_KogMaw"] = {"Jade_KogMawWAttack", "Jade_KogMawW"},
	["Jade_Twitch"] = true,
	["Jade_MasterYi"] = {"Jade_MasterYiWujuStyle", "Jade_MasterYiWujuStyleSuperCharged", "Jade_MasterYiDoubleStrike"},
	["Jade_Olaf"] = {"Jade_OlafW"},
	["Jade_DrMundo"] = {"Jade_DrMundoE"},
	["Jade_Chogath"] = {"Jade_ChogathE"},
	["Jade_Poppy"] = {"Jade_PoppyW", "Jade_PoppyW_Stats"},
	["Jade_Fiora"] = {"Jade_FioraE"},
	["Jade_Tristana"] = {"Jade_TristanaQ"},
	["Jade_Teemo"] = {"Jade_TeemoE_Attack", "Jade_TeemoE"},
	["Jade_Taric"] = true,
}
local normalAttacks={
	Blitzcrank={'PowerFistAttack'},Garen={'GarenQAttack'},Leona={'LeonaShieldOfDaybreakAttack'},Nautilus={'NautilusRavageStrikeAttack'},
	Renekton={'RenektonPreExecute','RenektonExecute','RenektonSuperExecute'},Volibear={'VolibearQAttack'},Vayne={'VayneCondemn'},Sett={'SettR'},
}
return {Jade_Fiora={classic=true,wAttacks=classicAttacks,q=D.Jade_FioraQ.castRange,r=400,qName='Jade_FioraQ',wName='Jade_FioraW',eName='Jade_FioraE',rName='Jade_FioraR',
 qBase=D.Jade_FioraQ.Damage,qAD={.6,.6,.6,.6,.6},qWindow=D.Jade_FioraQ.RecastWindow,wDuration=D.Jade_FioraW.ParryDuration,eDuration=D.Jade_FioraE.BuffDuration,rBase=D.Jade_FioraR.Damage,rAD=.85,rRepeat=D.Jade_FioraR.ExtraHitDmgAmount,rRepeatFloor=.25,rStrikes=5,rBounce=D.Jade_FioraR.AttackRadius,
 qDash={established=false,speeds={D.Jade_FioraQ.DashMovespeedBonus},castDelays={0,.15},source='Jade_Fiora spells.json Jade_FioraQ castRange 600, DashMovespeedBonus 1200 (2026-10-08); speed semantics open, cast delay bracket 0-.15 unmeasured'}},
 Fiora={classic=false,q=400,r=D.FioraR.castRange,qName='FioraQ',wName='FioraW',eName='FioraE',rName='FioraR',
 qDash={speeds={850,1100,1600},castDelays={0},source='https://wiki.leagueoflegends.com/en-us/Template:Data_Fiora/Lunge 2026-10-08: range 50-400, cast none, speed 1100 + 300/350% bonus movement speed within 850-1600'},
 wAttacks=normalAttacks,
 qBase=D.FioraQ.Damage,qAD=D.FioraQ.bADRatio,qRefund=D.FioraQ.CDRefundPercent,wDuration=D.FioraW.ParryDuration,wRange=D.FioraWMissile.castRangeDisplayOverride,wWidth=D.FioraWMissile.mMissileWidth,wSpeed=D.FioraWMissile.mSpeed,wPoise=.5,wBase=D.FioraW.BaseDamage,wAP=1,
 stabRadius=420,stabPriority=252,rHorizon=4,eDuration=D.FioraE.BuffDuration,eTwo=D.FioraE.AttackTwoPercentTAD,
 vitals={sides={NE={0,1},NW={1,0},SE={-1,0},SW={0,-1}},ownerRadius=100,offset=50,offsetMin=25,agreeCos=.8,learnAfter=3,reach=30,reveal=1.75,rReveal=.5,scanLimit=400},
 markDuration=D.FioraR.MarkDuration,healDuration=D.FioraR.HealDuration,healRadius=D.FioraR.HealRingRadius,healBase=D.FioraR.HealPerSecond,healAD=D.FioraR.Ratio,vitalBase=.03,vitalAD=.0004}}

end
end
