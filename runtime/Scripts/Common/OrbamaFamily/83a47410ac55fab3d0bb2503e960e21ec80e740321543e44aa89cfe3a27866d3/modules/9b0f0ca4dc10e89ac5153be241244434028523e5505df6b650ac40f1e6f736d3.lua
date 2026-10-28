return function(require)
-- Current profile data: implementation/family/current-patch.json.
-- Units: world units, seconds, raw damage.
-- Runtime aliases and gameplay outcomes require live acceptance; retained rows are not stages.
local P={version=1,patch='26.21',assetVersion='16.21.829.8620'}
local factories={}
factories['aatrox']=function()
-- Shared Aatrox Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
local D=(function()
return {
 AatroxR={
  RDuration=10,RHealingAmp={.5,.75,1},RTotalADAmp={.2,.3,.4},
 },
 AatroxQ={
  QBaseDamage={10,25,40,55,70},QExtensionTime=4,QRampBonus=.25,QSweetSpotBonus=.75,QTotalADRatio={.6,.675,.75,.825,.9},
 },
 AatroxQWrapperCast={
  mCastTime=.6,
 },
 AatroxW={
  WBaseDamage={30,40,50,60,70},WBonusADRatio=.4,castRange=825,mCastTime=.25,mMissileWidth=80,mSpeed=1800,
 },
 AatroxE={
  EMaxRange=300,ESpellVamp=16,
 },
 Jade_AatroxW={
  LowHealthPercent=50,WBaseDamage={60,95,130,165,200},WBaseHeal={20,25,30,35,40},WDamageADRatio=1,WHealADRatio=.25,WLowHealthHealBonus=3,
 },
 Jade_AatroxEConeMissile={
  EAPRatio=.6,EBaseDamage={75,120,165,210,255},EBonusADRatio=.6,castRange=1075,mMissileWidth=40,mSpeed=1250,
 },
 Jade_AatroxE={
  EHealthCostPercent=.05,mCastTime=.25,
 },
 Jade_AatroxR={
  RAttackSpeed={.4,.5,.6},RBaseDamage={200,300,400},RBonusRange=175,RDuration=12,RRadius=550,
 },
 Jade_AatroxQ={
  QBaseDamage={70,115,160,205,250},QBonusADRatio=.6,QDamageRadius=310,QHealthCostPercent=.1,QKnockupRadius=190,QMaxLeapRange=650,
 },
}
end)()
local profiles={}
profiles['Aatrox']=profiles['Aatrox']or {}
profiles['Aatrox'].combat={id='normal',champion='Aatrox',names={{'AatroxQ','AatroxQ2','AatroxQ3'},{'AatroxW'},{'AatroxE'},{'AatroxR'}},
  q={range=625,radius=90,delay=D.AatroxQWrapperCast.mCastTime,speed=math.huge,type='physical',base=D.AatroxQ.QBaseDamage,ad=D.AatroxQ.QTotalADRatio},
  -- 2026-10-10 (wiki Aatrox, Last changed V26.19, read 2026-10-10): W physical since V25.11. Q1 625x180 (half-width
  -- 90); Q2 trapezoid from 100 behind to 475 ahead, 300 to 500 wide (half-widths 150/250); Q3 300-radius circle 200
  -- ahead, 180-radius sweet spot. Q1/Q2 sweet depths are not published: 475 and 350 kept (live damage logs settle them).
  -- qWindow 4 s (asset QExtensionTime). wChainRadius: not published; 150 is below DepressiveAIONext's 185+bounding,
  -- development 'aatrox_w_pull' traces settle it. qMinion: wiki "55/60/65/70% (based on level)" without the level
  -- breakpoints; the lowest share 0.55 is used for every level so a minion kill is never overestimated.
  w={range=D.AatroxW.castRange,radius=D.AatroxW.mMissileWidth,delay=D.AatroxW.mCastTime,speed=D.AatroxW.mSpeed,type='physical',base=D.AatroxW.WBaseDamage,ad=D.AatroxW.WBonusADRatio,collision=true},
  e={range=D.AatroxE.EMaxRange},r={range=0},qStages={{range=625,width=90,sweetMin=475,sweetMax=625},{range=475,back=100,near=150,width=250,sweetMin=350,sweetMax=475},{center=200,radius=300,sweetRadius=180}},qRamp=D.AatroxQ.QRampBonus,sweetBonus=D.AatroxQ.QSweetSpotBonus,
  qWindow=D.AatroxQ.QExtensionTime,wChainRadius=150,qMinion=.55,qCast='AatroxQWrapperCast',
  passiveNames={'AatroxPassiveReady','AatroxPassive'},tetherNames={'AatroxW'},passiveHP={.04,.10},passiveCap={100,320},eHealingHP=.00013,eHealing=D.AatroxE.ESpellVamp/100,rAD=D.AatroxR.RTotalADAmp,rHealing=D.AatroxR.RHealingAmp,rDuration=D.AatroxR.RDuration}
profiles['Jade_Aatrox']=profiles['Jade_Aatrox']or {}
profiles['Jade_Aatrox'].combat={id='classic',champion='Aatrox',names={{'Jade_AatroxQ'},{'Jade_AatroxW','Jade_AatroxW2'},{'Jade_AatroxE'},{'Jade_AatroxR'}},
  q={range=D.Jade_AatroxQ.QMaxLeapRange,radius=D.Jade_AatroxQ.QDamageRadius,knockupRadius=D.Jade_AatroxQ.QKnockupRadius,delay=.6,speed=math.huge,type='physical',base=D.Jade_AatroxQ.QBaseDamage,bonusAD=D.Jade_AatroxQ.QBonusADRatio,healthCost=D.Jade_AatroxQ.QHealthCostPercent},
  w={range=0,type='physical',base=D.Jade_AatroxW.WBaseDamage,bonusAD=D.Jade_AatroxW.WDamageADRatio},
  -- E: Jade_AatroxEConeMissile castRange 1075, missile line radius 40 (field 1a24e25e; the second blade 15,
  -- castRadius 100 is the spread, not the hit width); 26.20 Jade_Aatrox spells.json, 2026-10-10.
  e={range=D.Jade_AatroxEConeMissile.castRange,radius=D.Jade_AatroxEConeMissile.mMissileWidth,delay=D.Jade_AatroxE.mCastTime,speed=D.Jade_AatroxEConeMissile.mSpeed,type='magical',base=D.Jade_AatroxEConeMissile.EBaseDamage,bonusAD=D.Jade_AatroxEConeMissile.EBonusADRatio,ap=D.Jade_AatroxEConeMissile.EAPRatio,healthCost=D.Jade_AatroxE.EHealthCostPercent},
  r={range=D.Jade_AatroxR.RRadius,type='magical',base=D.Jade_AatroxR.RBaseDamage,ap=1},wHeal=D.Jade_AatroxW.WBaseHeal,wHealAD=D.Jade_AatroxW.WHealADRatio,wHealThreshold=D.Jade_AatroxW.LowHealthPercent/100,wHealAmplifier=D.Jade_AatroxW.WLowHealthHealBonus,
  healNames={'Jade_AatroxWLife'},damageNames={'Jade_AatroxWPower'},reviveNames={'Jade_AatroxPassiveDeath'},wAttacks=3,reviveDuration=3,rDuration=D.Jade_AatroxR.RDuration,rAS=D.Jade_AatroxR.RAttackSpeed,rAttackRange=D.Jade_AatroxR.RBonusRange}
local normal,classic=profiles.Aatrox.combat,profiles.Jade_Aatrox.combat
normal.e.mobility=true;classic.q.mobility=true
function normal.rawModifier(p,raw,s,slot,rank,stats,target,options,finite)
 if slot==0 then
  local stage=options.stage or 1
  if not finite(stage)or stage%1~=0 or stage<1 or stage>3 then return 0,'invalid_stage'end
  raw=raw*(1+p.qRamp*(stage-1))*(options.sweet and 1+p.sweetBonus or 1)
  if target and target.team==300 then raw=raw+25
  elseif target and target.type~=stats.heroType and target.team then raw=raw*p.qMinion end
 end
 return raw,s.type
end
function normal.passive(p,stats,target,finite)
 if not target or not finite(target.maxHealth)then return 0 end
 local level=stats.level
 local raw=target.maxHealth*(p.passiveHP[1]+(p.passiveHP[2]-p.passiveHP[1])*(level-1)/17)
 return target.team==300 and math.min(raw,p.passiveCap[1]+(p.passiveCap[2]-p.passiveCap[1])*(level-1)/17)or raw,'magical'
end
function classic.heal(p,rank,stats,active,mantra,finite)
 local b=p.wHeal[rank];if not b or not finite(stats.bonusDamage)then return 0 end
 return(b+p.wHealAD*stats.bonusDamage)*(stats.health/stats.maxHealth<p.wHealThreshold and p.wHealAmplifier or 1)
end
return profiles

end
factories['akali']=function()
-- Shared Akali mechanics data. Values preserved from the maintained controller.
-- Classic Shadow Dance range, three sources (2026-10-08), resolved by profile match, not averaged:
--   800  installed asset research/family-assets/Jade_Akali/spells.json, the Shadow Dance record (S3 icon, base
--        100/175/250, 0.5 AP, 3 charges, recharge 25/20/15): castRange 800, DashDistance 715. This is the server's
--        own record, so r=800.
--   700  https://wiki.leagueoflegends.com/en-us/League_Classic/Akali ("TARGET RANGE: 700", dash speed 2000): the
--        values after V5.2 ("range reduced to 700 from 800") and V5.9 ("dash speed increased to 2000 from 1600").
--   675  the controller's earlier figure, no source.
--   Not live-verified. A cast from beyond the real range makes the client walk into range first; it is not lost.
--   2026-10-10 (final data accuracy): re-read Jade_AkaliR: castRange 800, castRangeDisplayOverride 775, DashDistance
--   715, no dash speed. No field explains the page's 700, so r=700: centre-to-centre 700 is inside both the asset's
--   800 and the page's 700 under either range convention; the controller never casts out of range (it used to rely on
--   the client walking in from up to 800). Superseded: r=800.
-- Classic Shadow Dance is offered to Evade with a conservative bracket (2026-10-10), not a measurement: range 700,
-- both era speeds {1600,2000}, cast delays {0,.25} (mCastTime 0; the .25 field the Normal R shares with its wiki cast
-- time), and both possible end points - on the target, and DashDistance 715 along the line - must be clear under
-- every combination (rDash.onTarget). The reserve charge, turret, health and enemy-count limits apply.
-- Same Classic page: a champion takedown grants one charge; Crescent Slash is listed as physical
-- (30/55/80/105/130 + 60% AD + 40% AP) - the controller keeps the lower of physical and magical until seen live.
-- Normal r2Dash {750,800} (2026-10-10): the recast's targeter line in the installed AkaliRb record is 750 long
--   (048557ff dddc3025, width 90; castRange 25000, castRangeDisplayOverride 575); the wiki (read 2026-10-10) says the
--   recast dashes 800. Recipients are planned inside 750 (hit under both), and the landing at 750 and at 800 must both
--   pass the turret, terrain and dash limits.
-- Normal rDash (Perfect Execution, first cast), https://wiki.leagueoflegends.com/en-us/Akali read 2026-10-08:
--   target range 675 (enemy champion), cast time 0.25, speed 1500, dashes 750 toward the target and at least 150
--   past it. Shuriken Flip's backflip (up to 400, speed not stated for the flip itself) is not offered.
-- Ranking pass 2026-10-10 (experiments/champion-ranking-20261010/dossiers/Akali.md):
--   Classic w 700 -> 475: Twilight Shroud radius 475 (cast range 270), https://wiki.leagueoflegends.com/en-us/League_Classic/Akali
--     read 2026-10-10. Drawing only; W is cast on Akali's own position.
--   Classic qMark: Mark of the Assassin detonation by the next attack or Crescent Slash, 45/70/95/120/145 + 40% AP magic,
--     same Classic page read 2026-10-10. Treated as confirmed damage only with a live owned mark and a ready attack in range.
--   Normal r2Window 10 / r2Delay 2.5: the recast is available 2.5 s after the first cast, within 10 s (wiki Akali read
--     2026-10-10). The self-buff alias 'AkaliR' (PussyAIO) is unverified: the window end is the earlier of that buff's
--     expiry and 10 s after the recast stage was first seen; the dev recorder traces the observed length (akali_r2_window).
--   Normal qFan: Five Point Strike range 500, angle 20 degrees (wiki infobox read 2026-10-10; the installed asset carries
--     castRange 550 and no angle field). The narrower 20 degree cone undercounts a wider real fan, so it is conservative
--     for hit counts. Needs a live geometry check.
--   Normal e2KillRange 1500: the E recast reaches the marked target at any distance (wiki read 2026-10-10); 1500 is the
--     policy bound for a recast that kills by itself, 1000 for every other recast.
-- Classic q 575: Jade_AkaliQ castRangeDisplayOverride (castRange 600), 16.21 ability table 2026-10-28; the earlier
--   550 had no source.
local D=(function()
return {
 AkaliW={
  castRange=350,
 },
 AkaliQ={
  APRatio=.6,castRange=550,
 },
 AkaliR={
  CooldownBetweenCasts=2.5,castRange=675,mCastTime=.25,
 },
 AkaliE={
  TotalAPRatio=1.1,castRange=825,
 },
 Jade_AkaliR={
  DashDistance=715,
 },
 Jade_AkaliQ={
  APRatioInitial=.4,APRatioProc=.4,ProcDamageBase={45,70,95,120,145},castRangeDisplayOverride=575,
 },
 Jade_AkaliE={
  ERadius=325,TotalAPRatio=.4,
 },
}
end)()
return {
 Jade_Akali={id='classic',q=D.Jade_AkaliQ.castRangeDisplayOverride,w=475,e=D.Jade_AkaliE.ERadius,r=700,qAP=D.Jade_AkaliQ.APRatioInitial,eAP=D.Jade_AkaliE.TotalAPRatio,qMark={base=D.Jade_AkaliQ.ProcDamageBase,ap=D.Jade_AkaliQ.APRatioProc},
  rDash={name='Jade_AkaliR',range=700,speeds={1600,2000},castDelays={0,.25},onTarget=true,through=D.Jade_AkaliR.DashDistance,
   source='2026-10-10 conservative bracket: wiki League_Classic/Akali (target range 700, speed 1600 before V5.9, 2000 after) and installed Jade_AkaliR (castRange 800, DashDistance 715); both end points checked'}},
 Akali={id='normal',q=500,qHitRange=D.AkaliQ.castRange,w=D.AkaliW.castRange,e=D.AkaliE.castRange,r=D.AkaliR.castRange,qAP=D.AkaliQ.APRatio,eAP=D.AkaliE.TotalAPRatio,r2Window=10,r2Delay=D.AkaliR.CooldownBetweenCasts,qFan={range=500,angle=20},e2Range=1000,e2KillRange=1500,r2Dash={750,800},
  rDash={name='AkaliR',range=D.AkaliR.castRange,speeds={1500},castDelays={D.AkaliR.mCastTime},through=750,past=150,
   source='https://wiki.leagueoflegends.com/en-us/Akali 2026-10-08: Perfect Execution first cast range 675, cast 0.25, speed 1500, dash 750 and at least 150 past the target'}},
}

end
factories['amumu']=function()
-- Shared Amumu mechanics data. Values preserved from the maintained controller.
-- wRadius: installed asset 300 (both profiles); the wiki (read 2026-10-10) says 350. Kept at the asset
-- value until 'amumu_w_edge' development traces show damage ticks beyond 300 (Amumu-4).
-- 2026-10-10 re-examined: AuraofDespair / Jade_AmumuAuraofDespair carry only castRange 300 and castRadius 300
-- (the self-toggle's indicator fields; no separate effect/damage radius exists in the client data), so no field
-- settles it. wRadius stays the confirmed (conservative) radius; Normal wReach 350 (wiki V25.18, KillerAmumu) is
-- the switch-on/keep-on reach so Despair is never off where it could already hurt. Classic has no second source.
local D=(function()
return {
 CurseoftheSadMummy={
  RCoefficient=.8,RDamage={200,300,400},
 },
 AuraofDespair={
  castRadius=300,
 },
 Tantrum={
  BaseDamage={65,95,125,155,185},castRadius=350,
 },
 BandageToss={
  BaseDamage={70,95,120,145,170},
 },
 Jade_AmumuAuraofDespair={
  castRadius=300,
 },
 Jade_AmumuCurseoftheSadMummy={
  RCoefficient=.8,RDamage={150,250,350},
 },
 Jade_AmumuBandageToss={
  APRatio=.7,BaseDamage={80,140,200,260,320},
 },
}
end)()
return {
 Amumu={id='normal',q='BandageToss',w='AuraofDespair',e='Tantrum',r='CurseoftheSadMummy',
  charges=2,passive='AmumuPDebuff',passiveKind='true_damage_amp',qBase=D.BandageToss.BaseDamage,qAP=.85,
   eBase=D.Tantrum.BaseDamage,eAP=.5,rBase=D.CurseoftheSadMummy.RDamage,rAP=D.CurseoftheSadMummy.RCoefficient,rInterrupt=true,wRadius=D.AuraofDespair.castRadius,wReach=D.Tantrum.castRadius},
 Jade_Amumu={id='classic',q='Jade_AmumuBandageToss',w='Jade_AmumuAuraofDespair',e='Jade_AmumuTantrum',r='Jade_AmumuCurseoftheSadMummy',
  charges=0,passive='Jade_AmumuCursedTouch',passiveKind='magic_resist_reduction',qBase=D.Jade_AmumuBandageToss.BaseDamage,qAP=D.Jade_AmumuBandageToss.APRatio,
   eBase={65,95,125,150,175},eAP=.5,rBase=D.Jade_AmumuCurseoftheSadMummy.RDamage,rAP=D.Jade_AmumuCurseoftheSadMummy.RCoefficient,rInterrupt=false,wRadius=D.Jade_AmumuAuraofDespair.castRadius},
}

end
factories['annie']=function()
-- Shared Annie mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 AnnieR={
  InitialDamage={150,275,400},
 },
 AnnieQ={
  APRatio=.8,BaseDamage={80,125,170,215,260},
 },
 AnnieE={
  ShieldAmount={60,95,130,165,200},ShieldDuration=3,
 },
 AnnieW={
  APRatio=.8,BaseDamage={70,110,150,190,230},
 },
 Jade_AnnieR={
  InitialDamage={200,325,450},
 },
 Jade_AnnieQ={
  APRatio=.75,BaseDamage={90,130,170,210,250},
 },
 Jade_AnnieW={
  APRatio=.8,BaseDamage={85,135,185,235,285},
 },
}
end)()
return {
 Annie={id='normal',q='Disintegrate',w='Incinerate',e='AnnieE',r='InfernalGuardian',
  guides={AnnieRController=true,InfernalGuardianGuide=true},stack='anniepassivestack',primed='anniepassiveprimed',
  qBase=D.AnnieQ.BaseDamage,qAP=D.AnnieQ.APRatio,wBase=D.AnnieW.BaseDamage,wAP=D.AnnieW.APRatio,rBase=D.AnnieR.InitialDamage,rAP=.75,allyE=true,
  -- Molten Shield: 60-200 (+40% AP) for 3 s on Annie or an ally within 800, no cast time.
  eShield=D.AnnieE.ShieldAmount,eShieldAP=.4,eShieldDuration=D.AnnieE.ShieldDuration,eDelay=0,
  shieldSource='https://wiki.leagueoflegends.com/en-us/Annie Molten Shield, read 2026-10-08 (page last changed V26.04)',
  -- Tibbers also receives the Molten Shield (wiki Annie, read 2026-10-10, V26.04): E in Combo while he fights.
  ePet=true},
 Jade_Annie={id='classic',q='Jade_Annie_Disintegrate',w='Jade_Annie_Incinerate',e='Jade_AnnieE',r='Jade_AnnieR',
  guides={Jade_Annie_InfernalGuardianGuide=true},stack='Jade_AnniePassive_StunBuildupBuff',primed='Jade_AnniePassive_StunReadyBuff',
  qBase=D.Jade_AnnieQ.BaseDamage,qAP=D.Jade_AnnieQ.APRatio,wBase=D.Jade_AnnieW.BaseDamage,wAP=D.Jade_AnnieW.APRatio,rBase=D.Jade_AnnieR.InitialDamage,rAP=.7,allyE=false},
 -- Classic Molten Shield is +20-60 armor and magic resist for 5 s on Annie (Jade_Annie/spells.json Resistances,
 -- ShieldDuration; League_Classic/Annie read 2026-10-08): no absorb amount, so no eShield and no shield offer.
 -- Whether Classic E also reaches Tibbers is unmeasured (no ePet): the dev trace annie_classic_e_tibbers settles it.
}

end
factories['caitlyn']=function()
-- Ranking pass 2026-10-10 (experiments/champion-ranking-20261010/dossiers/Caitlyn.md), wiki.leagueoflegends.com/en-us/Caitlyn
-- read 2026-10-10: Normal R crit bonus is 1 + (0.30 + 0.09 with Infinity Edge) x crit chance (was 0.3 x crit x (critDamage-1),
-- which refused kills). Headshot every 5 attacks, 4 from brush (patch 13.16; was 6, preview data only). The Normal passive
-- crit term follows the current installed CriticalStrikeScaling and calculation. Current source pins are in
-- implementation/family/current-patch.json; live Headshot acceptance remains pending. Classic: the net enabling a Headshot is unmeasured (no net buff alias),
-- so the E + Headshot finisher is Normal only.
-- Shared Caitlyn Normal/Classic mechanics; current pins are in implementation/family/current-patch.json.
-- R timing, 2026-10-08: Normal 0.375 s cast + 1 s channel (delay 1.375), missile speed 3200
-- (wiki.leagueoflegends.com/en-us/Caitlyn, Ace in the Hole); the earlier 1 / 1500 made the lethal
-- check add two more seconds of regeneration and refuse valid kills. Classic: speed 3200 and a
-- 1 s channel (wiki.leagueoflegends.com/en-us/League_Classic/Caitlyn; V1.0.0.112 raised it from
-- 2200); its "brief delay" before the channel is not quantified, so delay stays 1.
-- Classic W: arm 1.1 s and three traps per the League Classic page (V1.0.0.114: 3 from 2); the
-- earlier 1 / 2 only cost a trap or made a trap arm 0.1 s late. Classic Q cast time 1 s and Classic E
-- range 950, half width 80, speed 2000 come from Classic's own records (2026-10-28, 16.21 ability table:
-- Jade_CaitlynQ CastTime 1, Jade_CaitlynEMissile castRangeDisplayOverride 950, mMissileWidth 80, mSpeed 2000);
-- the earlier .625 / 750 / 70 / 1600 were the Normal values. Uncertain and unchanged: Classic E recoil
-- (390 here, 400 on the page). Normal E recoil speed 1000 (same page, "1600 / 1000") is recorded
-- as recoilSpeed; the Normal recoil is offered to Evade with the cast mirrored (Core:RegisterMobility aim).
local D=(function()
return {
 CaitlynPassive={
  AttacksPerHeadshot=5,CriticalStrikeScaling=.8,
 },
 CaitlynEMissile={
  castRange=800,mMissileWidth=70,mSpeed=1600,
 },
 CaitlynE={
  Damage={80,130,180,230,280},castRangeDisplayOverride=750,
 },
 CaitlynW={
  ADRatio=.3,BaseDamage={35,80,125,170,215},MaximumTraps={3,3,4,4,5},TrapDuration={30,35,40,45,50},castFrameSeconds=.25,castRadius=75,castRange=800,
 },
 CaitlynR={
  CriticalStrikeModifier=.3,RBaseDamage={300,475,650},castRange=3500,
 },
 CaitlynRMissile={
  mMissileWidth=40,mSpeed=3200,
 },
 CaitlynQ={
  BaseDamage={50,95,140,185,230},SecondaryMult=.6,castRange=1300,castRangeDisplayOverride=1250,mMissileWidth=60,mSpeed=2200,tADRatio={1.25,1.45,1.65,1.85,2.05},
 },
 Jade_CaitlynRMissile={
  mMissileWidth=40,mSpeed=3200,
 },
 Jade_CaitlynR={
  RADRatio=2,RBaseDamage={250,475,700},castRange={2000,2500,3000},
 },
 Jade_CaitlynEMissile={
  castRangeDisplayOverride=950,mMissileWidth=80,mSpeed=2000,
 },
 Jade_CaitlynE={
  Damage={80,130,180,230,280},
 },
 Jade_CaitlynW={
  BaseDamage={80,130,180,230,280},MaxTraps=3,castFrameSeconds=.25,castRadius=75,castRange=800,
 },
 Jade_CaitlynQ={
  ADRatio=1.3,BaseDamage={20,60,100,140,180},CastTime=1,ExtraHitPercentReduction=.1,MinimumDamagePercent=.5,castRangeDisplayOverride=1250,mMissileWidth=90,mSpeed=2200,
 },
}
end)()
local profiles={}
profiles['Caitlyn']=profiles['Caitlyn']or {}
profiles['Caitlyn'].combat={id='normal',champion='Caitlyn',names={{'CaitlynQ','CaitlynQ2'},{'CaitlynW'},{'CaitlynE'},{'CaitlynR'}},
   q={range=D.CaitlynQ.castRangeDisplayOverride,flightRange=D.CaitlynQ.castRange,radius=D.CaitlynQ.mMissileWidth,delay=.625,speed=D.CaitlynQ.mSpeed,type='physical',base=D.CaitlynQ.BaseDamage,ad=D.CaitlynQ.tADRatio},
  w={range=D.CaitlynW.castRange,delay=D.CaitlynW.castFrameSeconds,arm=1,radius=D.CaitlynW.castRadius,max=D.CaitlynW.MaximumTraps,duration=D.CaitlynW.TrapDuration,type='physical',base=D.CaitlynW.BaseDamage,bonusAD=D.CaitlynW.ADRatio},
   e={range=D.CaitlynE.castRangeDisplayOverride,flightRange=D.CaitlynEMissile.castRange,radius=D.CaitlynEMissile.mMissileWidth,delay=.15,speed=D.CaitlynEMissile.mSpeed,collision=true,type='magical',base=D.CaitlynE.Damage,ap=.8,recoil=390,recoilSpeed=1000},
  r={range=D.CaitlynR.castRange,delay=1.375,speed=D.CaitlynRMissile.mSpeed,radius=D.CaitlynRMissile.mMissileWidth,type='physical',base=D.CaitlynR.RBaseDamage,bonusAD=1,crit=D.CaitlynR.CriticalStrikeModifier,critIE=.09},qPierce=D.CaitlynQ.SecondaryMult,
  headshotNames={'CaitlynPassiveDriver'},trapNames={'CaitlynWSight','CaitlynWSnare'},netNames={'Eternals_CaitlynEHeadshotTracker'},trapObjectNames={'CaitlynTrap'},headshotLevel={.6,.7,.8},headshotCrit=D.CaitlynPassive.CriticalStrikeScaling,headshotAttacks=D.CaitlynPassive.AttacksPerHeadshot,headshotAttacksBrush=4}
profiles['Jade_Caitlyn']=profiles['Jade_Caitlyn']or {}
profiles['Jade_Caitlyn'].combat={id='classic',champion='Caitlyn',names={{'Jade_CaitlynQ'},{'Jade_CaitlynW'},{'Jade_CaitlynE'},{'Jade_CaitlynR'}},
  q={range=D.Jade_CaitlynQ.castRangeDisplayOverride,radius=D.Jade_CaitlynQ.mMissileWidth,delay=D.Jade_CaitlynQ.CastTime,speed=D.Jade_CaitlynQ.mSpeed,type='physical',base=D.Jade_CaitlynQ.BaseDamage,ad=D.Jade_CaitlynQ.ADRatio},
  w={range=D.Jade_CaitlynW.castRange,delay=D.Jade_CaitlynW.castFrameSeconds,arm=1.1,radius=D.Jade_CaitlynW.castRadius,max={D.Jade_CaitlynW.MaxTraps,D.Jade_CaitlynW.MaxTraps,D.Jade_CaitlynW.MaxTraps,D.Jade_CaitlynW.MaxTraps,D.Jade_CaitlynW.MaxTraps},type='magical',base=D.Jade_CaitlynW.BaseDamage,ap=.6},
  e={range=D.Jade_CaitlynEMissile.castRangeDisplayOverride,radius=D.Jade_CaitlynEMissile.mMissileWidth,delay=.15,speed=D.Jade_CaitlynEMissile.mSpeed,collision=true,type='magical',base=D.Jade_CaitlynE.Damage,ap=.8,recoil=390},
  r={range=D.Jade_CaitlynR.castRange,delay=1,speed=D.Jade_CaitlynRMissile.mSpeed,radius=D.Jade_CaitlynRMissile.mMissileWidth,type='physical',base=D.Jade_CaitlynR.RBaseDamage,bonusAD=D.Jade_CaitlynR.RADRatio},qPierceStep=D.Jade_CaitlynQ.ExtraHitPercentReduction,qPierceMin=D.Jade_CaitlynQ.MinimumDamagePercent,
  headshotNames={'Jade_CaitlynHeadshot'},headshotCountNames={'Jade_CaitlynHeadshotCount'},trapNames={'Jade_CaitlynYordleTrapDebuff'},trapObjectNames={'Jade_CaitlynTrap'},headshotBonus=.5,headshotNonChampion=1.5,headshotAttacks={8,7,6},trapLifetimeUnknown=true}
local normal,classic=profiles.Caitlyn.combat,profiles.Jade_Caitlyn.combat
normal.e.mobilitySource='https://wiki.leagueoflegends.com/en-us/Caitlyn 90 Caliber Net: recoils 390 units, cast time 0.15, speed 1600 / 1000 (missile / recoil), read 2026-10-08'
normal.e.mobility=true;classic.e.mobility=true;normal.w.requiresAmmo=true
local function modifier(p,raw,s,slot,rank,stats,target,options,finite)
 if slot==0 then
  local prior=options.prior or 0
  if not finite(prior)or prior<0 or prior%1~=0 then return 0,'invalid_prior_hits'end
  if not options.trapped then raw=raw*(p.qPierce and(prior>0 and p.qPierce or 1)or math.max(p.qPierceMin,1-prior*p.qPierceStep))end
 elseif slot==3 and p.id=='normal'then
  if not finite(stats.critChance)or not finite(stats.critDamage)or stats.critDamage<1 then return 0,'crit_state_unknown'end
  -- Up to 30% more at 100% crit chance, up to 9% more with Infinity Edge (wiki, read 2026-10-10).
  -- Infinity Edge is read from the provider's crit damage: above its 2.0 base only with item 3031/773031.
  raw=raw*(1+(p.r.crit+(stats.critDamage>2.001 and p.r.critIE or 0))*math.max(0,math.min(1,stats.critChance)))
 end
 return raw,s.type
end
normal.rawModifier=modifier;classic.rawModifier=modifier
function classic.passive(p,stats,target)
 return stats.totalDamage*(target and target.type==stats.heroType and p.headshotBonus or p.headshotNonChampion),'physical'
end
function normal.passive(p,stats,target,finite)
 if not finite(stats.critChance)or not finite(stats.critDamage)then return 0 end
 local level=stats.level
 local scale=target and target.type~=stats.heroType and 1.1 or p.headshotLevel[level>=13 and 3 or level>=7 and 2 or 1]
 return stats.totalDamage*(scale+p.headshotCrit*stats.critChance*(stats.critDamage-1)),'physical'
end
return profiles

end
factories['chogath']=function()
-- Shared Chogath mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 Feast={
  CastRangePerStack=2.5,RBaseDamage={300,475,650},RBaseMonsterDamage=1200,RMinionMaxStacks=6,
 },
 VorpalSpikesMissle={
  castRange=650,mMissileWidth=170,mSpeed=1475,
 },
 VorpalSpikes={
  BaseDamage={30,50,70,90,110},BuffDuration=6,FeastStackMultiplier=.5,PercentHealthDamage={2.5,2.85,3.2,3.55,3.9},
 },
 Rupture={
  BaseDamage={80,135,190,245,300},castRadius=230,
 },
 Jade_ChogathR={
  MaxStacks=6,RAPRatio=.7,RBaseDamage={300,475,650},RBaseMonsterDamage=1000,
 },
 Jade_ChogathQ={
  BaseDamage={80,135,190,245,305},KnockupDelay=.625,castRadius=250,
 },
 Jade_ChogathEMissile={
  castRange=650,mMissileWidth=170,mSpeed=1475,
 },
 Jade_ChogathE={
  BaseDamage={20,35,50,65,80},
 },
 Jade_ChogathW={
  BaseDamage={75,125,175,225,275},
 },
}
end)()
return {
 Chogath={id='normal',q={'Rupture'},w={'FeralScream'},e={'VorpalSpikes'},r={'Feast'},
  qBase=D.Rupture.BaseDamage,qRadius=D.Rupture.castRadius,qDelay=.625,wBase={80,130,180,230,280},wRange=585,
  eBase=D.VorpalSpikes.BaseDamage,ePercent=D.VorpalSpikes.PercentHealthDamage,eToggle=false,
  rBase=D.Feast.RBaseDamage,rMonster=D.Feast.RBaseMonsterDamage,rAP=.5,rHP=.1,stackCapKind='non_epic',stackCap=D.Feast.RMinionMaxStacks,feastBuff='Feast',
  -- LoL wiki Cho'Gath V26.17 (read 2026-10-10): Feast range +2.5 per stack up to +25; spikes 650 long, 1475 speed,
  -- width 340-500 (the narrowest half width is used); 110-310 (+30% AP) per spike against monsters; +0.5% maximum
  -- health per Feast stack (installed asset FeastStackMultiplier 0.5); E lasts 6 s (asset BuffDuration).
  rStackRange=D.Feast.CastRangePerStack,rStackRangeMax=10,eSpikeRange=D.VorpalSpikesMissle.castRange,eSpikeSpeed=D.VorpalSpikesMissle.mSpeed,eHalfWidth=D.VorpalSpikesMissle.mMissileWidth,eMonster={110,160,210,260,310},
  eStackPercent=D.VorpalSpikes.FeastStackMultiplier,eDuration=D.VorpalSpikes.BuffDuration},
 Jade_Chogath={id='classic',q={'Jade_ChogathQ'},w={'Jade_ChogathW','Jade_Chogath_FeralScream'},
  e={'Jade_ChogathE','Jade_ChogathE_Jade'},r={'Jade_ChogathR','Jade_Chogath_Feast'},
  qBase=D.Jade_ChogathQ.BaseDamage,qRadius=D.Jade_ChogathQ.castRadius,qDelay=D.Jade_ChogathQ.KnockupDelay,wBase=D.Jade_ChogathW.BaseDamage,wRange=650,
  eBase=D.Jade_ChogathE.BaseDamage,eToggle=true,rBase=D.Jade_ChogathR.RBaseDamage,rMonster=D.Jade_ChogathR.RBaseMonsterDamage,rAP=D.Jade_ChogathR.RAPRatio,rHP=0,
  stackCapKind='total',stackCap=D.Jade_ChogathR.MaxStacks,feastBuff='Jade_ChogathR',
  -- Installed Jade_ChogathEMissile: castRange 650, missileSpeed 1475, mMissileWidth 170 (the half width, the same
  -- field Normal reads; 16.21 ability table 2026-10-28, was 150 'until measured'). Feast stack range growth and
  -- per-stack spike damage are unmeasured: none here.
  -- Whether Classic Feast stacks survive death is unverified (chogath-provenance gaps): death makes the count unknown.
  eSpikeRange=D.Jade_ChogathEMissile.castRange,eSpikeSpeed=D.Jade_ChogathEMissile.mSpeed,eHalfWidth=D.Jade_ChogathEMissile.mMissileWidth,stacksMayDropOnDeath=true},
}

end
factories['corki']=function()
-- Shared Corki mechanics data. Values preserved from the maintained controller unless a source is named.
-- Normal, https://wiki.leagueoflegends.com/en-us/Corki read 2026-10-08: Q "TARGET RANGE: 825", "EFFECT RADIUS: 275",
--  "SPEED: 1100"; W "300 - 600", cast time "none", speed "650 + 100% movement speed"; E "EFFECT RADIUS: 690",
--  35 degrees; R "TARGET RANGE: 1300 / 1500", "EFFECT RADIUS: 150 / 300", width 80, speed 2000, cast 0.175.
--  rRange/bigRange were 1225 (the display override) until 2026-10-08; the installed child missiles also say
--  1300/1500 (corki-provenance.json). splash was 200 until 2026-10-08. qRadius stays 250 (installed castRadius);
--  the wiki's 275 is recorded and the smaller value is used so a counted hit is one under either reading.
--  bigBuff is the entries.json alias; a third-party script uses `mbcheck2` for the pre-rework kit. Not live-verified.
-- Classic, https://wiki.leagueoflegends.com/en-us/League_Classic/Corki read 2026-10-08: W "RANGE: 800",
--  "SPEED: 650"; E "EFFECT RADIUS: 600"; R "TARGET RANGE: 1225", "EFFECT RADIUS: 75 / 150", speed 1950, Big One
--  "increased range" without a number (bigRange stays 1225). wRange 800 = that page and the installed
--  Jade_CorkiW MaxRange 800 (research/family-assets/Jade_Corki/spells.json; it was 600 until 2026-10-08).
--  splash 75 / 150 is the page; other leads say 150 / 250 (ClassicCorki.lua) and 200 / 300 (patch V1.0.0.63), so the
--  page value is the lower bound of all leads and a counted splash hit holds under each of them.
--  Classic Q stays the installed 600-range instant spell (Jade_CorkiQ castRange 600, missileSpeed 0); the page says
--  825 lobbed at speed 1000 (the V3.14 spell). Recorded, not used.
-- eAngle (Normal only): Gatling Gun cone 35 degrees, effect radius 690 (wiki Corki read 2026-10-10). Classic E is a
--  600 radius with no angle on the page; lane E stays off for Classic until it is measured.
-- wSpeed is the dash speed WITHOUT the movement-speed part (Normal adds 100% movement speed): a floor, so a
-- consumer never assumes a faster dash than the real one. wCast 0: Normal wiki "none"; the Classic asset block has no
-- cast-time field (spells that have one carry it) and the Classic page lists none.
local D=(function()
return {
 MissileBarrage={
  ADRatio=.85,BaseDamage={90,170,250},RBigOneMissileRadius=300,
 },
 MissileBarrageMissile2={
  castRange=1500,
 },
 MissileBarrageMissile={
  castRange=1300,
 },
 PhosphorusBombMissile={
  mSpeed=1100,
 },
 PhosphorusBomb={
  ADRatio=1.25,BaseDamage={60,105,150,195,240},castRange=825,
 },
 CarpetBomb={
  DashSpeedBase=650,MaximumRange=600,MinimumRange=300,
 },
 Jade_CorkiE={
  castRange=600,
 },
 Jade_CorkiR={
  BaseDamage={120,190,260},MaxAmmoTooltip=7,
 },
 Jade_CorkiR_Missile={
  castRange=1225,
 },
 Jade_CorkiW={
  MaxRange=800,MinRange=300,
 },
 Jade_CorkiQ={
  APRatio=.5,BaseDamage={80,130,180,230,280},castRadius=250,castRange=600,
 },
}
end)()
return {
 Corki={id='normal',qRange=D.PhosphorusBomb.castRange,qSpeed=D.PhosphorusBombMissile.mSpeed,qRadius=250,qBase=D.PhosphorusBomb.BaseDamage,qAP=1,qBonusAD=D.PhosphorusBomb.ADRatio,
  rBase=D.MissileBarrage.BaseDamage,rBonusAD=D.MissileBarrage.ADRatio,rTotalAD=0,rAP=0,rMultiplier=2,rDamage='physical',
   bigBuff='corkimissilebarragecounterbig',rRange=D.MissileBarrageMissile.castRange,bigRange=D.MissileBarrageMissile2.castRange,splash=150,bigSplash=D.MissileBarrage.RBigOneMissileRadius,maxAmmo=4,eRange=690,eAngle=35,
   wName='CarpetBomb',wMinRange=D.CarpetBomb.MinimumRange,wRange=D.CarpetBomb.MaximumRange,wSpeed=D.CarpetBomb.DashSpeedBase,wCast=0,
   wSource='https://wiki.leagueoflegends.com/en-us/Corki Valkyrie range 300-600, no cast time, speed 650 + 100% movement speed (floor 650 declared), read 2026-10-08'},
 Jade_Corki={id='classic',qRange=D.Jade_CorkiQ.castRange,qSpeed=math.huge,qRadius=D.Jade_CorkiQ.castRadius,qBase=D.Jade_CorkiQ.BaseDamage,qAP=D.Jade_CorkiQ.APRatio,qBonusAD=0,
  rBase=D.Jade_CorkiR.BaseDamage,rBonusAD=0,rTotalAD=.2,rAP=.3,rMultiplier=1.5,rDamage='magical',
   bigBuff='jade_corkir_check',rRange=D.Jade_CorkiR_Missile.castRange,bigRange=D.Jade_CorkiR_Missile.castRange,splash=75,bigSplash=150,maxAmmo=D.Jade_CorkiR.MaxAmmoTooltip,eRange=D.Jade_CorkiE.castRange,
   wName='Jade_CorkiW',wMinRange=D.Jade_CorkiW.MinRange,wRange=D.Jade_CorkiW.MaxRange,wAssetMaxRange=D.Jade_CorkiW.MaxRange,wSpeed=650,wCast=0,
   wSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Corki Valkyrie RANGE 800, SPEED 650 (read 2026-10-08); research/family-assets/Jade_Corki/spells.json Jade_CorkiW MaxRange 800 / MinRange 300, no cast-time field'},
}

end
factories['ezreal']=function()
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
local D=(function()
return {
 EzrealE={
  BaseDamage={80,130,180,230,280},EAPRatio=.75,MissileRange=750,castRangeDisplayOverride=475,
 },
 EzrealQ={
  BaseDamage={20,45,70,95,120},BaseDamageADRatio=1.3,BaseDamageAPRatio=.4,castRangeDisplayOverride=1150,
 },
 EzrealW={
  APRatio=.9,BaseDamage={80,135,190,245,300},castRange=1200,castRangeDisplayOverride=1150,mMissileWidth=80,mSpeed=1700,
 },
 EzrealR={
  BaseDamage={350,550,750},RAPRatio=1.1,
 },
 Jade_EzrealW={
  APRatio=.6,BaseDamage={80,130,180,230,280},castRange=1050,mMissileWidth=100,mSpeed=1600,
 },
 Jade_EzrealR={
  BaseDamage={350,500,650},RAPRatio=1,
 },
 Jade_EzrealQ={
  BaseDamage={40,65,90,115,140},BaseDamageADRatio=1.1,
 },
 Jade_EzrealE={
  BaseDamage={75,125,175,225,275},EAPRatio=.75,MissileRange=750,castRangeDisplayOverride=475,
 },
}
end)()
return {
    Ezreal={id='normal',qRange=D.EzrealQ.castRangeDisplayOverride,qBase=D.EzrealQ.BaseDamage,qAD=D.EzrealQ.BaseDamageADRatio,qAP=D.EzrealQ.BaseDamageAPRatio,
        wRange=D.EzrealW.castRangeDisplayOverride,wSpeed=D.EzrealW.mSpeed,wRadius=D.EzrealW.mMissileWidth,wBase=D.EzrealW.BaseDamage,wAP=D.EzrealW.APRatio,wAD=1,rBase=D.EzrealR.BaseDamage,rAP=D.EzrealR.RAPRatio,rAD=1,marks=true,
        e='EzrealE',eRange=D.EzrealE.castRangeDisplayOverride,eCast=.25,eBase=D.EzrealE.BaseDamage,eAD=.6,eAP=D.EzrealE.EAPRatio,eBolt=D.EzrealE.MissileRange,eBoltSpeed=2000,
        eSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Ezreal/Arcane_Shift 2026-10-08: blink, range 475, cast 0.25'},
    Jade_Ezreal={id='classic',qRange=1100,qBase=D.Jade_EzrealQ.BaseDamage,qAD=D.Jade_EzrealQ.BaseDamageADRatio,qAP=0,
        wRange=D.Jade_EzrealW.castRange,wSpeed=D.Jade_EzrealW.mSpeed,wRadius=D.Jade_EzrealW.mMissileWidth,wBase=D.Jade_EzrealW.BaseDamage,wAP=D.Jade_EzrealW.APRatio,wAD=0,rBase=D.Jade_EzrealR.BaseDamage,rAP=D.Jade_EzrealR.RAPRatio,rAD=0,marks=false,
        e='Jade_EzrealE',eRange=D.Jade_EzrealE.castRangeDisplayOverride,eCast=.25,eBase=D.Jade_EzrealE.BaseDamage,eAD=0,eAP=D.Jade_EzrealE.EAPRatio,eBolt=D.Jade_EzrealE.MissileRange,eBoltSpeed=1000,
        eSource='research/family-assets/Jade_Ezreal/spells.json (range 475, field 11704a2b 0.25) and https://wiki.leagueoflegends.com/en-us/League_Classic/Ezreal (cast 0.25) 2026-10-08'},
}

end
factories['fiora']=function()
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
factories['fizz']=function()
-- Shared Fizz mechanics data. Values preserved from the maintained controller.
-- Normal R tiers (2026-10-10): the shark grows with the distance the lure travelled before it attached:
--  under 455 small, 455-910 medium, over 910 large (https://wiki.leagueoflegends.com/en-us/Fizz, read 2026-10-10;
--  thresholds not in the decoded assets). Medium x1.25 and large x1.5 of the small damage: asset FizzR DataValues
--  MidDamageMulti 1.25 / LargeDamageMulti 1.5 (research/family-assets/Fizz/spells.json), which equals the wiki's
--  225-525 (+75% AP) and 270-630 (+90% AP). `band`: inside 40 units past a threshold the lower tier is credited
--  (prediction error). Classic R has one fixed damage.
-- E timing (both profiles): Fizz is untargetable for 0.75 s and lands after it (Normal wiki 2026-10-10, Classic per
--  fizz-provenance.json eTiming); the hop transport before it is unmeasured, so 0.75 is a lower bound on the landing.
-- Normal E2 (2026-10-10): e2Radius 225 = FizzE DataValues SmallAoESize and FizzETwo mEffectAmount[3]
--  (research/family-assets/Fizz/spells.json; wiki Trickster effect radius 225, read 2026-10-10). e2Cast 0.15 =
--  FizzETwo castFrame 4.535 at 30 frames/s (same asset). The hop speed is published nowhere (wiki, assets: missileSpeed
--  20 is a placeholder), so e2Speed stays unset and the slam horizon is the cast-frame lower bound; the dev trace
--  fizz_e2_landing records seconds and hop length to settle it.
-- Normal wReachBonus 50: the W-empowered attack gains 50 bonus range (wiki Seastone Trident, read 2026-10-10).
local D=(function()
return {
 FizzE={
  BaseDamage={80,130,180,230,280},SmallAoESize=225,
 },
 FizzW={
  ActiveBaseDamage={50,75,100,125,150},ActiveDuration=4,ActiveRatio=.45,DoTBaseDamage={30,45,60,75,90},DoTRatio=.25,
 },
 FizzRMissile={
  mSpeed=1300,
 },
 FizzR={
  DetonationTime=2,LargeDamageMulti=1.5,MaxDistance=1300,MidDamageMulti=1.25,SmallAPRatio=.6,SmallDamage={180,300,420},
 },
 Jade_FizzR={
  APRatio=1,BaseDamage={200,325,450},DetonationTime=1.5,castRangeDisplayOverride=1275,
 },
 Jade_FizzRMissile={
  mSpeed=1350,
 },
 Jade_FizzW={
  ActiveBaseDamage={10,15,20,25,30},ActiveDuration=5,ActiveRatio=.2,DoTBaseDamage={30,40,50,60,70},DoTRatio=.35,MaxHealthScaling={.04,.05,.06,.07,.08},
 },
 Jade_FizzE={
  APRatio=.75,BaseDamage={70,120,170,220,270},
 },
 Jade_FizzQ={
  APRatio=.4,BaseDamage={10,40,70,100,130},
 },
}
end)()
return {
 Fizz={id='normal',q='FizzQ',w='FizzW',e='FizzE',e2='FizzETwo',buffer='FizzEBuffer',r='FizzR',
  wBuff='FizzWActive',wAttack='FizzWBasicAttack',onHit='FizzOnHitBuff',bleed='FizzWDOT',fish='FizzRCling',
  qBase={10,25,40,55,70},qAP=.55,wBase=D.FizzW.ActiveBaseDamage,wAP=D.FizzW.ActiveRatio,wDuration=D.FizzW.ActiveDuration,
  dotBase=D.FizzW.DoTBaseDamage,dotAP=D.FizzW.DoTRatio,eBase=D.FizzE.BaseDamage,eAP=.95,
  rBase=D.FizzR.SmallDamage,rAP=D.FizzR.SmallAPRatio,rRange=D.FizzR.MaxDistance,rSpeed=D.FizzRMissile.mSpeed,rDelay=D.FizzR.DetonationTime,rTiered=true,
  rTiers={near=455,far=910,band=40,mid=D.FizzR.MidDamageMulti,large=D.FizzR.LargeDamageMulti},eLanding=.75,
  e2Radius=D.FizzE.SmallAoESize,e2Cast=.15,wReachBonus=50},
 Jade_Fizz={id='classic',q='Jade_FizzQ',w='Jade_FizzW',e='Jade_FizzE',e2='Jade_FizzETwo',buffer='Jade_FizzEBuffer',r='Jade_FizzR',
  wBuff='Jade_FizzWActive',bleed='Jade_FizzWDOT',fish='Jade_FizzRCling',
  qBase=D.Jade_FizzQ.BaseDamage,qAP=D.Jade_FizzQ.APRatio,wBase=D.Jade_FizzW.ActiveBaseDamage,wAP=D.Jade_FizzW.ActiveRatio,wDuration=D.Jade_FizzW.ActiveDuration,
  dotBase=D.Jade_FizzW.DoTBaseDamage,dotAP=D.Jade_FizzW.DoTRatio,dotMissing=D.Jade_FizzW.MaxHealthScaling,eBase=D.Jade_FizzE.BaseDamage,eAP=D.Jade_FizzE.APRatio,
  rBase=D.Jade_FizzR.BaseDamage,rAP=D.Jade_FizzR.APRatio,rRange=D.Jade_FizzR.castRangeDisplayOverride,rSpeed=D.Jade_FizzRMissile.mSpeed,rDelay=D.Jade_FizzR.DetonationTime,rTiered=false,eLanding=.75},
}

end
factories['graves']=function()
-- Shared Graves mechanics data. Values preserved from the maintained controller.
-- Ranking pass 2026-10-10: Normal fullReload 2.08 s, the reload of both shells from empty
-- (https://wiki.leagueoflegends.com/en-us/Graves/LoL, page V26.17, read 2026-10-10); bounds the
-- observed-empty lease of the controller (Graves-1). Classic has no shells.
-- Classic wRadius 300: Jade_GravesW SmokeRadius (16.21 ability table, 2026-10-28; Normal reads the same field,
-- 200). The earlier 210 was the castRadius of the Jade_GravesW_Boom transport missile.
local D=(function()
return {
 GravesChargeShot={
  RBaseDamage={275,425,575},RFalloffDamage={200,320,440},RKnockbackDistance=400,
 },
 GravesQReturn={
  mMissileWidth=100,mSpeed=1600,
 },
 GravesQLineMis={
  mMissileWidth=40,mSpeed=3000,
 },
 GravesQLineSpell={
  BaseDamage={50,75,100,125,150},BaseDetonationDamage={80,125,170,215,260},FirstADRatio=.55,TerrainCollisionDelay=.2,bADDetonationRatio={.45,.6,.75,.9,1.05},castFrameSeconds=.25,castRange=800,
 },
 GravesSmokeGrenade={
  SmokeRadius=200,
 },
 GravesMove={
  DashMaxDistance=375,DashMinDistance=275,DashSpeed=750,MaxStacks=8,
 },
 Jade_GravesR={
  BulletADRatio=1.4,ConeADRatio=1,RBaseDamage={250,350,450},RFalloffDamage={140,230,320},
 },
 Jade_GravesQ_Attack={
  mMissileWidth=50,mSpeed=2000,
 },
 Jade_GravesQ={
  BaseDamage={60,95,130,165,200},FirstADRatio=.8,MultiHitPenalty=.35,castConeAngle=15.32,castFrameSeconds=.25,castRange=800,
 },
 Jade_GravesE={
  DashMovespeed=850,MaxDistance=425,
 },
 Jade_GravesW={
  SmokeRadius=300,
 },
}
end)()
return {
 Graves={id='normal',q='GravesQLineSpell',w='GravesSmokeGrenade',e='GravesMove',r='GravesChargeShot',
  qBase=D.GravesQLineSpell.BaseDamage,qAD=D.GravesQLineSpell.FirstADRatio,returnBase=D.GravesQLineSpell.BaseDetonationDamage,returnAD=D.GravesQLineSpell.bADDetonationRatio,
  qRange=D.GravesQLineSpell.castRange,qSpeed=D.GravesQLineMis.mSpeed,qRadius=D.GravesQLineMis.mMissileWidth,qDelay=D.GravesQLineSpell.castFrameSeconds,returnSpeed=D.GravesQReturn.mSpeed,returnRadius=D.GravesQReturn.mMissileWidth,wallDelay=D.GravesQLineSpell.TerrainCollisionDelay,endDelay=1,
  wRadius=D.GravesSmokeGrenade.SmokeRadius,eMin=D.GravesMove.DashMinDistance,eRange=D.GravesMove.DashMaxDistance,eSpeed=D.GravesMove.DashSpeed,grit='GravesEGrit',maxGrit=D.GravesMove.MaxStacks,
  rBase=D.GravesChargeShot.RBaseDamage,rCone=D.GravesChargeShot.RFalloffDamage,rAD=1.5,rConeAD=1.2,coneRange=735,recoil=D.GravesChargeShot.RKnockbackDistance,fullReload=2.08},
 Jade_Graves={id='classic',q='Jade_GravesQ',w='Jade_GravesW',e='Jade_GravesMove',r='Jade_GravesChargeShot',
  qBase=D.Jade_GravesQ.BaseDamage,qAD=D.Jade_GravesQ.FirstADRatio,qRange=D.Jade_GravesQ.castRange,qSpeed=D.Jade_GravesQ_Attack.mSpeed,qRadius=D.Jade_GravesQ_Attack.mMissileWidth,qAngle=D.Jade_GravesQ.castConeAngle,qPenalty=D.Jade_GravesQ.MultiHitPenalty,qDelay=D.Jade_GravesQ.castFrameSeconds,
  wRadius=D.Jade_GravesW.SmokeRadius,eMin=0,eRange=D.Jade_GravesE.MaxDistance,eSpeed=D.Jade_GravesE.DashMovespeed,grit='Jade_GravesPassive_Counter',maxGrit=10,eBuff='Jade_GravesE_Buff',
  rBase=D.Jade_GravesR.RBaseDamage,rCone=D.Jade_GravesR.RFalloffDamage,rAD=D.Jade_GravesR.BulletADRatio,rConeAD=D.Jade_GravesR.ConeADRatio,coneRange=800,recoil=0},
}

end
factories['hecarim']=function()
-- Hecarim Normal/Classic mechanics. Details and witnesses: CombatProfiles/hecarim-provenance.json.
-- Normal: installed 16.21 asset data/characters/hecarim/hecarim.bin (Hecarim.wad.client 2026-10-21).
-- Classic: the same client's data/characters/jade_hecarim/jade_hecarim.bin. No live recording of either yet.
-- Ranks index asset arrays from 1. E holds its minimum damage; e.max and e.maxBonusAD apply after
-- e.distance units of charge (rawModifier, options.travel).
-- e.strike: shared knock-back spec, docs/ANGLED-STRIKES.md.
local D=(function()
return {
 HecarimRamp={
  BonusADRatio=.5,DistanceToMaxDamage=1200,Duration=4,MaxBaseDamage={60,90,120,150,180},MaxKnockback=350,MaxMoveSpeed=.65,MinBaseDamage={30,45,60,75,90},MinKnockback=150,MinMoveSpeed=.25,TimeToMaxMoveSpeed=2.5,
 },
 HecarimRapidSlash={
  BaseDamage={60,90,120,150,180},BaseDamageBonusAD=.9,BuffDuration=8,MaxStacks=3,MinionDamageRatio=.6,castRadius=375,castRange=375,
 },
 HecarimUlt={
  APRatio=1,BaseDamage={150,250,350},DashSpeed=1100,FearDurationMax=1.5,FearDurationMin=.75,MaxDashRange=1000,RangeForMaxFearDuration=950,
  areaRadius=315,
 },
 HecarimW={
  APRatio=.8,BuffDuration=4,Damage={80,120,160,200,240},ResistAmount={5,10,15,20,25},castRange=525,castRangeDisplayOverride=525,
 },
 Jade_HecarimR={
  APRatio=1,BaseDamage={150,250,350},DashSpeed=1100,FearDuration=1,MaxDashRange=1000,RangeForMaxFearDuration=950,
  areaRadius=315,
 },
 Jade_HecarimE={
  BonusADRatio=.5,DistanceToMaxDamage=1200,Duration=4,Knockback=300,MaxBaseDamage={80,150,220,290,360},MaxMoveSpeed=.75,MinBaseDamage={40,75,110,145,180},MinMoveSpeed=.25,TimeToMaxMoveSpeed=2.5,
 },
 Jade_HecarimQ={
  BaseDamage={60,95,130,165,200},BaseDamageBonusAD=.6,BuffDuration=6,MaxStacks=2,MinionDamageRatio=.66,castRadius=375,castRange=375,
 },
 Jade_HecarimW={
  APRatio=.8,BuffDuration=4,Damage={80,120,160,200,240},castRange=525,castRangeDisplayOverride=525,
 },
}
end)()
local profiles={}
profiles['Hecarim']=profiles['Hecarim']or {}
profiles['Hecarim'].combat={id='normal',champion='Hecarim',names={{'HecarimRapidSlash'},{'HecarimW'},{'HecarimRamp'},{'HecarimUlt'}},
  q={range=D.HecarimRapidSlash.castRange,radius=D.HecarimRapidSlash.castRadius,delay=0,type='physical',base=D.HecarimRapidSlash.BaseDamage,bonusAD=D.HecarimRapidSlash.BaseDamageBonusAD,minion=D.HecarimRapidSlash.MinionDamageRatio,stacks=D.HecarimRapidSlash.MaxStacks,stackDuration=D.HecarimRapidSlash.BuffDuration},
  w={range=D.HecarimW.castRange,radius=D.HecarimW.castRangeDisplayOverride,duration=D.HecarimW.BuffDuration,type='magical',base=D.HecarimW.Damage,ap=D.HecarimW.APRatio,resist=D.HecarimW.ResistAmount},
  e={range=0,duration=D.HecarimRamp.Duration,haste=D.HecarimRamp.MinMoveSpeed,maxHaste=D.HecarimRamp.MaxMoveSpeed,rampTime=D.HecarimRamp.TimeToMaxMoveSpeed,distance=D.HecarimRamp.DistanceToMaxDamage,type='physical',
   base=D.HecarimRamp.MinBaseDamage,max=D.HecarimRamp.MaxBaseDamage,bonusAD=D.HecarimRamp.BonusADRatio,maxBonusAD=1,mobility=true,
   strike={push='away',distance={D.HecarimRamp.MinKnockback,D.HecarimRamp.MaxKnockback},scale='travel',full=D.HecarimRamp.DistanceToMaxDamage,source='16.21 HecarimRamp MinKnockback, MaxKnockback; DistanceToMaxDamage is assumed for knock-back scaling'}},
  -- R: dash up to 1000 at 1100, fear within 315 of the landing (Evade sheet, wiki; asset castRadius 300).
  r={range=D.HecarimUlt.MaxDashRange,minimum=300,radius=D.HecarimUlt.areaRadius,speed=D.HecarimUlt.DashSpeed,delay=.25,type='magical',base=D.HecarimUlt.BaseDamage,ap=D.HecarimUlt.APRatio,fear={D.HecarimUlt.FearDurationMin,D.HecarimUlt.FearDurationMax},fearRange=D.HecarimUlt.RangeForMaxFearDuration,mobility=true},
  eNames={'HecarimRamp'}}
profiles['Jade_Hecarim']=profiles['Jade_Hecarim']or {}
profiles['Jade_Hecarim'].combat={id='classic',champion='Hecarim',names={{'Jade_HecarimQ'},{'Jade_HecarimW'},{'Jade_HecarimE'},{'Jade_HecarimR'}},
  q={range=D.Jade_HecarimQ.castRange,radius=D.Jade_HecarimQ.castRadius,delay=0,type='physical',base=D.Jade_HecarimQ.BaseDamage,bonusAD=D.Jade_HecarimQ.BaseDamageBonusAD,minion=D.Jade_HecarimQ.MinionDamageRatio,stacks=D.Jade_HecarimQ.MaxStacks,stackDuration=D.Jade_HecarimQ.BuffDuration},
  w={range=D.Jade_HecarimW.castRange,radius=525,duration=D.Jade_HecarimW.BuffDuration,type='magical',base=D.Jade_HecarimW.Damage,ap=D.Jade_HecarimW.APRatio},
  e={range=0,duration=D.Jade_HecarimE.Duration,haste=D.Jade_HecarimE.MinMoveSpeed,maxHaste=D.Jade_HecarimE.MaxMoveSpeed,rampTime=D.Jade_HecarimE.TimeToMaxMoveSpeed,distance=D.Jade_HecarimE.DistanceToMaxDamage,type='physical',
   base=D.Jade_HecarimE.MinBaseDamage,max=D.Jade_HecarimE.MaxBaseDamage,bonusAD=D.Jade_HecarimE.BonusADRatio,maxBonusAD=1,mobility=true,
   strike={push='away',distance={D.Jade_HecarimE.Knockback,D.Jade_HecarimE.Knockback},source='16.21 Jade_HecarimE Knockback'}},
  r={range=D.Jade_HecarimR.MaxDashRange,minimum=300,radius=D.Jade_HecarimR.areaRadius,speed=D.Jade_HecarimR.DashSpeed,delay=.25,type='magical',base=D.Jade_HecarimR.BaseDamage,ap=D.Jade_HecarimR.APRatio,fear={D.Jade_HecarimR.FearDuration,D.Jade_HecarimR.FearDuration},fearRange=D.Jade_HecarimR.RangeForMaxFearDuration,mobility=true},
  eNames={'Jade_HecarimE'}}
local normal,classic=profiles.Hecarim.combat,profiles.Jade_Hecarim.combat
-- Q: reduced against lane minions. E: the charge damage grows linearly with the
-- distance travelled (options.travel) from the minimum to the maximum.
local function modifier(p,raw,s,slot,rank,stats,target,options,finite)
 if slot==0 and target and target.type~=stats.heroType and target.team~=300 then return raw*s.minion,s.type end
 if slot==2 then
  local share=options and finite(options.travel)and math.max(0,math.min(1,options.travel/s.distance))or 0
  return s.base[rank]+(s.max[rank]-s.base[rank])*share+(s.bonusAD+(s.maxBonusAD-s.bonusAD)*share)*stats.bonusDamage,s.type
 end
 return raw,s.type
end
normal.rawModifier=modifier;classic.rawModifier=modifier
return profiles

end
factories['irelia']=function()
-- Shared Irelia Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
local D=(function()
return {
 IreliaR={
  APRatio=1,BaseMissileDamage={125,200,275},castRange=1000,
 },
 IreliaPassive={
  OnHitBaseDamage=10,
 },
 IreliaE={
  BaseDamage={70,110,150,190,230},BuffDuration=3.5,MaxRange=775,RevTime=.35,
 },
 IreliaW={
  MinDamage={10,20,30,40,50},
 },
 IreliaQ={
  BaseDamage={5,25,45,65,85},castRange=600,
 },
 Jade_IreliaRSpell={
  mSpeed=1600,
 },
 Jade_IreliaR={
  BaseMissileDamage={80,120,160},ChampionHealPercent=25,MinionHealPercent=10,castRange=1200,mMissileWidth=120,
 },
 Jade_IreliaE={
  APRatio=.5,BaseDamage={80,130,180,230,280},StunDuration={1,1.25,1.5,1.75,2},castRange=325,
 },
 Jade_IreliaQ={
  BaseDamage={20,50,80,110,140},DashSpeedBonus=1400,ManaReturn=35,castRangeDisplayOverride=620,
 },
 Jade_IreliaW={
  ActiveDuration=6,Damage={15,30,45,60,75},Health={5,7,9,11,13},HealthRestoreActive={10,14,18,22,26},
 },
}
end)()
local profiles=(function()
-- Shared Irelia mechanics data. Values preserved from the maintained controller.
return {Irelia={id='normal',q='IreliaQ',w='IreliaW',w2='IreliaW2',e='IreliaE',e2='IreliaE2',r='IreliaR',
 mark='IreliaMark',passive='IreliaPassiveStacks',passiveMax='IreliaPassiveStacksMax',defense='IreliaWDefense',
 qRange=D.IreliaQ.castRange,qSpeed=1400,qBase=D.IreliaQ.BaseDamage,qAD=.8,qMinionBase=50,qMinionLevel=11,
 stacks=4,passiveBase=10,passiveLevel=3,passiveAD=.2,eRange=D.IreliaE.MaxRange,eDelay=.3,eRev=D.IreliaE.RevTime,eRadius=70,eDuration=D.IreliaE.BuffDuration,eRecast=.25,
 eBase=D.IreliaE.BaseDamage,eAP=1,wRange=775,wRadius=100,wMax=1.5,wFull=.75,wBase=D.IreliaW.MinDamage,wAD=.4,wAP=.5,wMaxBonus=2,
 wPhysicalDR={40,70},wDRAP=.08,wMagicDR=.5,
 -- 2026-10-10: W minimum +40% AD +50% AP (installed IreliaW calculation 368633251: .4 on stat 2 = AD, as Q's .8;
 -- .5 on the default stat = AP; wiki V26.17 agrees; the earlier .5 AD/.4 AP read the two terms swapped).
 -- R castRange 1000 (installed castRange, wiki V26.17; 950 is only the display override). Cast time: the installed
 -- asset says .5 (field 7c4baddc), the wiki .4; the asset value is kept.
 -- rBurst: radius around the first champion hit that the burst also marks. Not published: the 320 line width is
 -- used as a lower bound until development 'irelia_r' traces (marked champions per cast) settle it.
 -- qThrough: wiki V26.17 "dashes 100 units through the target"; unverified, used only as an extra Evade landing check.
 -- eRecast stays .25 (installed CDBetweenCast) where the wiki says .15: the conservative value.
 rRange=D.IreliaR.castRange,rSpeed=2000,rDelay=.5,rRadius=160,rBurst=320,qThrough=100,rBase=D.IreliaR.BaseMissileDamage,rAP=D.IreliaR.APRatio}}

end)()
profiles['Irelia']=profiles['Irelia']or {}
profiles['Irelia'].combat={id='normal',champion='Irelia',names={{'IreliaQ'},{'IreliaW','IreliaW2'},{'IreliaE','IreliaE2'},{'IreliaR'}},
  q={range=D.IreliaQ.castRange,type='physical',base=D.IreliaQ.BaseDamage,ad=.8,minionBase=50,minionLevel=11},
  w={range=775,type='physical',base=D.IreliaW.MinDamage,ad=.4,ap=.5},
  e={range=D.IreliaE.MaxRange,type='magical',base=D.IreliaE.BaseDamage,ap=1},r={range=D.IreliaR.castRange,type='magical',base=D.IreliaR.BaseMissileDamage,ap=D.IreliaR.APRatio},passiveNames={'IreliaPassiveStacksMax'},passiveBase=D.IreliaPassive.OnHitBaseDamage,passiveLevel=3,passiveAD=.2}
profiles['Jade_Irelia']=profiles['Jade_Irelia']or {}
profiles['Jade_Irelia'].combat={id='classic',champion='Irelia',names={{'Jade_IreliaQ'},{'Jade_IreliaW'},{'Jade_IreliaE'},{'Jade_IreliaR'}},
  q={range=D.Jade_IreliaQ.castRangeDisplayOverride,delay=.05,speed=D.Jade_IreliaQ.DashSpeedBonus,type='physical',base=D.Jade_IreliaQ.BaseDamage,ad=1},
  w={range=0,type='true',base=D.Jade_IreliaW.Damage},e={range=D.Jade_IreliaE.castRange,delay=.3,type='magical',base=D.Jade_IreliaE.BaseDamage,ap=D.Jade_IreliaE.APRatio},
  -- R: half width 120 (Jade_IreliaR own missile width 120; League_Classic/Irelia width 240). Speed 1600: the flying
  -- blade Jade_IreliaRSpell flies 1600 and the Classic page states 1600; Jade_IreliaR's own 779 matches neither and
  -- is unconfirmed until a live R trace (2026-10-28). The earlier half width 60 had no source.
  r={range=D.Jade_IreliaR.castRange,radius=D.Jade_IreliaR.mMissileWidth,delay=.25,speed=D.Jade_IreliaRSpell.mSpeed,type='physical',base=D.Jade_IreliaR.BaseMissileDamage,bonusAD=.6,ap=.5},
  wNames={'Jade_IreliaW_Buff'},wPassiveHeal=D.Jade_IreliaW.Health,wActiveHeal=D.Jade_IreliaW.HealthRestoreActive,wDuration=D.Jade_IreliaW.ActiveDuration,qRefund=D.Jade_IreliaQ.ManaReturn,
  eStun=D.Jade_IreliaE.StunDuration,rBlades=4,rChampionHeal=D.Jade_IreliaR.ChampionHealPercent/100,rMinionHeal=D.Jade_IreliaR.MinionHealPercent/100,passiveRadius=1400,passiveTenacity={.1,.25,.4}}
local normal,classic=profiles.Irelia.combat,profiles.Jade_Irelia.combat
classic.q.mobility=true
function normal.rawModifier(p,raw,s,slot,rank,stats,target,options,finite)
 if slot==0 and target and target.type~=stats.heroType and target.team~=300 then
  if not finite(stats.level)then return 0,'invalid_level'end
  raw=raw+p.q.minionBase+p.q.minionLevel*stats.level
 end
 return raw,s.type
end
function normal.passive(p,stats)
 return p.passiveBase+p.passiveLevel*stats.level+p.passiveAD*stats.bonusDamage,'magical'
end
function classic.heal(p,rank,stats,active)return(active and p.wActiveHeal or p.wPassiveHeal)[rank]or 0 end
return profiles

end
factories['janna']=function()
-- Shared Janna mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 ReapTheWhirlwind={
  Duration=3,Range=700,
 },
 EyeOfTheStorm={
  BaseShield={80,120,160,200,240},ShieldAPRatio=.55,ShieldDuration=4,castRange=800,
 },
 HowlingGale={
  BaseRange=1100,MaxDuration=3,MissileTravelTime=1.25,
 },
 SowTheWind={
  APRatio=.5,BaseDamage={55,85,115,145,175},mCastTime=.245,mSpeed=1600,
 },
 Jade_JannaReapTheWhirlwind={
  APRatioPerSecond=.35,HealBasePerSecond={70,110,150},MaxChannelDuration=4,
 },
 Jade_JannaSowTheWind={
  APRatio=.6,BaseDamage={60,115,170,225,280},mSpeed=1600,
 },
 Jade_JannaHowlingGaleSpell={
  mSpeed=900,
 },
 Jade_JannaHowlingGale={
  BaseRange=1100,MaxDuration=3,MissileTravelTime=1.25,
 },
 Jade_JannaEyeOfTheStorm={
  BaseShield={80,120,160,200,240},ShieldAPRatio=.9,ShieldDuration=5,castRange=800,
 },
}
end)()
return {
    -- 2026-10-08: E shield, W missile and R area were read from the matching page of each profile (`source`).
    -- Both pages give Q speed 880-1408 and width 240 by charge; the controller keeps its asset speed and a
    -- radius of 100 as the prediction inset for the short charges it releases (not corrected: unmeasured).
    classic={id='classic',qBegin='Jade_JannaHowlingGale',qRelease='Jade_JannaHowlingGaleSpell',
        rName='Jade_JannaReapTheWhirlwind',qSpeed=D.Jade_JannaHowlingGaleSpell.mSpeed,wBase=D.Jade_JannaSowTheWind.BaseDamage,wAP=D.Jade_JannaSowTheWind.APRatio,wEdge=false,
        wDelay=.25,wSpeed=D.Jade_JannaSowTheWind.mSpeed,rRadius=700,eRange=D.Jade_JannaEyeOfTheStorm.castRange,eTurrets=true,
        eShield=D.Jade_JannaEyeOfTheStorm.BaseShield,eShieldAP=D.Jade_JannaEyeOfTheStorm.ShieldAPRatio,eDuration=D.Jade_JannaEyeOfTheStorm.ShieldDuration,eDelay=0,
        source='research/family-assets/Jade_Janna/spells.json:1754-1817 (BaseShield, ShieldAPRatio .9, ShieldDuration 5) and https://wiki.leagueoflegends.com/en-us/League_Classic/Janna (read 2026-10-08)',
        -- 2026-10-10, https://wiki.leagueoflegends.com/en-us/League_Classic/Janna: Q range 1100 + 20 % per second of
        -- charge (1760 at 3 s), constant 1.25 s travel; R heals 70/110/150 (+35 % AP) per second for 4 s.
        qBaseRange=D.Jade_JannaHowlingGale.BaseRange,qChargeRate=220,qMaxCharge=D.Jade_JannaHowlingGale.MaxDuration,qTravel=D.Jade_JannaHowlingGale.MissileTravelTime,
        rHeal=D.Jade_JannaReapTheWhirlwind.HealBasePerSecond,rHealAP=D.Jade_JannaReapTheWhirlwind.APRatioPerSecond,rTick=1,rChannel=D.Jade_JannaReapTheWhirlwind.MaxChannelDuration},
    normal={id='normal',qBegin='HowlingGale',qRelease='HowlingGaleSpell',
        rName='ReapTheWhirlwind',qSpeed=667.666992,wBase=D.SowTheWind.BaseDamage,wAP=D.SowTheWind.APRatio,wEdge=true,
        wDelay=D.SowTheWind.mCastTime,wSpeed=D.SowTheWind.mSpeed,rRadius=D.ReapTheWhirlwind.Range,eRange=D.EyeOfTheStorm.castRange,eTurrets=true,
        eShield=D.EyeOfTheStorm.BaseShield,eShieldAP=D.EyeOfTheStorm.ShieldAPRatio,eDuration=D.EyeOfTheStorm.ShieldDuration,eDelay=0,
        source='https://wiki.leagueoflegends.com/en-us/Janna and Template:Data_Janna/Eye_of_the_Storm (read 2026-10-08)',
        -- 2026-10-10, https://wiki.leagueoflegends.com/en-us/Janna and the installed HowlingGale record
        -- (BaseRange 1100, ChargeDistancePercent 20, MissileTravelTime 1.25, MaxDuration 3): range 1100-1760 by charge,
        -- constant 1.25 s travel. R heals 25/37.5/50 (+12.5 % AP) every 0.25 s for 3 s (asset 100/150/200 +.5 AP per s).
        -- Tailwind: W deals 30 % of bonus movement speed; base movement speed 315 (wiki; the host has no base field,
        -- janna_move_speed traces settle it).
        qBaseRange=D.HowlingGale.BaseRange,qChargeRate=220,qMaxCharge=D.HowlingGale.MaxDuration,qTravel=D.HowlingGale.MissileTravelTime,
        rHeal={25,37.5,50},rHealAP=.125,rTick=.25,rChannel=D.ReapTheWhirlwind.Duration,tailwind=.3,baseMoveSpeed=315},
}

end
factories['jarvaniv']=function()
-- Shared JarvanIV mechanics data. Values preserved from the maintained controller.
-- 2026-10-08: W radius, Q cast time, R numbers, E area and the W shield were read from the matching wiki page of
-- each profile (`source`). Geometry used for prediction (Q radius 70, E radius 175, E flight) stays in the controller.
-- Classic W radius: the installed asset says castRadius 400 (research/family-assets/Jade_JarvanIV/spells.json:891),
-- the Classic page says 600. Both are recorded; the smaller one is used until a live cast settles it.
-- eqReach (2026-10-10): the largest E flag distance the E+Q dash is planned for. Q edge range 785, width 136 and
-- flag radius 65 (both wikis, read 2026-10-10) bound it near 785-850, but the real Q-to-flag limit is not
-- measured: 740 is the conservative value the controller has always used. The dev trace jarvan_eq_reach records
-- flag distance and landing for every sequence, and for the player's own Q to an own flag (manual=true, any distance,
-- the only way a flag beyond 740 is observed), until own play settles it. eRange 860 (both wikis).
local D=(function()
return {
 JarvanIVDragonStrike={
  BaseDamage={90,130,170,210,250},
 },
 JarvanIVCataclysm={
  BaseDamage={200,325,450},castRange=650,
 },
 JarvanIVDemacianStandard={
  APRatio=.8,castRangeDisplayOverride=860,
 },
 Jade_JarvanIVDemacianStandard={
  APRatio=.8,BaseDamage={60,105,150,195,240},castRangeDisplayOverride=860,
 },
 Jade_JarvanIVGoldenAegis={
  ShieldAmount={50,90,130,170,210},ShieldBonus={20,25,30,35,40},ShieldDuration=5,castRadius=400,
 },
 Jade_JarvanIVCataclysm={
  BaseDamage={200,325,450},castRange=650,
 },
 Jade_JarvanIVDragonStrike={
  BaseDamage={70,115,160,205,250},
 },
}
end)()
return {
 JarvanIV={id='normal',q='JarvanIVDragonStrike',w='JarvanIVGoldenAegis',e='JarvanIVDemacianStandard',r='JarvanIVCataclysm',
  qBase=D.JarvanIVDragonStrike.BaseDamage,qAD=1.45,eBase={80,120,160,200,240},eAP=D.JarvanIVDemacianStandard.APRatio,rAD=1.8,wRange=600,flagName='jarvanivstandard',
  qDelay=.4,eRadius=200,rBase=D.JarvanIVCataclysm.BaseDamage,rRange=D.JarvanIVCataclysm.castRange,rArena=350,rLeap=.35,eqReach=740,eRange=D.JarvanIVDemacianStandard.castRangeDisplayOverride,
  wShield={60,80,100,120,140},wShieldAD=.7,wShieldHealthPerChampion=.013,wDuration=4,wDelay=0,
  source='https://wiki.leagueoflegends.com/en-us/Jarvan_IV and Template:Data_Jarvan_IV/Golden_Aegis (read 2026-10-08)'},
 Jade_JarvanIV={id='classic',q='Jade_JarvanIVDragonStrike',w='Jade_JarvanIVGoldenAegis',e='Jade_JarvanIVDemacianStandard',r='Jade_JarvanIVCataclysm',
  qBase=D.Jade_JarvanIVDragonStrike.BaseDamage,qAD=1.2,eBase=D.Jade_JarvanIVDemacianStandard.BaseDamage,eAP=D.Jade_JarvanIVDemacianStandard.APRatio,rAD=1.5,wRange=D.Jade_JarvanIVGoldenAegis.castRadius,wRangeWiki=600,
  qDelay=.4,eRadius=200,rBase=D.Jade_JarvanIVCataclysm.BaseDamage,rRange=D.Jade_JarvanIVCataclysm.castRange,rArena=350,rLeap=.35,eqReach=740,eRange=D.Jade_JarvanIVDemacianStandard.castRangeDisplayOverride,
  wShield=D.Jade_JarvanIVGoldenAegis.ShieldAmount,wShieldPerChampion=D.Jade_JarvanIVGoldenAegis.ShieldBonus,wDuration=D.Jade_JarvanIVGoldenAegis.ShieldDuration,wDelay=0,
  source='https://wiki.leagueoflegends.com/en-us/League_Classic/Jarvan_IV (read 2026-10-08); shield values also research/family-assets/Jade_JarvanIV/spells.json:774-813'},
}

end
factories['jax']=function()
-- Shared Jax mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 JaxW={
  Damage={50,85,120,155,190},
 },
 JaxR={
  AoESize=375,SwingDamageBase={100,175,250},mCastTime=.25,
 },
 JaxE={
  APRatio=.7,BaseDamage={40,70,100,130,160},DodgeDuration=2,MaxDodgesForDamageIncrease=5,PercentHealthDamage=4,PercentIncreasedPerDodge=.2,
 },
 JaxQ={
  Damage={65,105,145,185,225},
 },
 Jade_JaxE={
  ADRatio=.5,BaseDamage={50,75,100,125,150},DodgeDuration=2,MaxDodgesForDamageIncrease=5,PercentIncreasedPerDodge=.2,
 },
 Jade_JaxW={
  ADRatio=.2,APRatio=.2,BaseDamage={40,60,80,100,120},
 },
 Jade_JaxQ={
  ADRatio=1,APRatio=.8,BaseDamage={50,75,100,125,150},
 },
}
end)()
return {
 Jax={id='normal',q={'JaxQ','JaxLeapStrike'},w='JaxW',e={'JaxE','JaxCounterStrike'},r='JaxR',
  eBuff={'JaxCounterStrike','JaxE'},wBuff='JaxW',wBuffAliases={'JaxW','JaxEmpowerTwo'},wAttack='JaxWAttack',wBase=D.JaxW.Damage,wAP=.6,wPrepare=.15,rKind='active_swing',
  -- Q 65-225 (+100% bonus AD) physical; R swing 100/175/250 (+100% AP) magic, radius 375, cast 0.25 s.
  qBase=D.JaxQ.Damage,qBonusAD=1,qAP=0,qKind='physical',rBase=D.JaxR.SwingDamageBase,rAP=1,rRadius=D.JaxR.AoESize,rCast=D.JaxR.mCastTime,
  damageSource='https://wiki.leagueoflegends.com/en-us/Jax read 2026-10-08 (last changed V26.12)',
  -- Counter Strike recast: 40-160 (+70% AP) (+4% target max HP) magic, +20% per dodged attack up to 5 (2x);
  -- dodge window 2 s, no cast time; dodges every non-turret basic attack.
  eBase=D.JaxE.BaseDamage,eAP=D.JaxE.APRatio,eHP=D.JaxE.PercentHealthDamage/100,eBonusAD=0,eKind='magical',eDodgeBonus=D.JaxE.PercentIncreasedPerDodge,eMaxDodges=D.JaxE.MaxDodgesForDamageIncrease,eDuration=D.JaxE.DodgeDuration,eDelay=0,
  eSource='https://wiki.leagueoflegends.com/en-us/Jax read 2026-10-10 (last changed V26.12): E recast damage, 2 s dodge, cast time none'},
 Jade_Jax={id='classic',q={'Jade_JaxQ','Jade_JaxLeapStrike'},w='Jade_JaxW',e={'Jade_JaxE','Jade_JaxCounterStrike'},r='Jade_JaxR',
  eBuff={'Jade_JaxE'},wBuff='Jade_JaxW',wAttack='Jade_JaxWAttack',wBase=D.Jade_JaxW.BaseDamage,wAP=D.Jade_JaxW.APRatio,wPrepare=.55,rKind='passive_slot',
  -- Q BaseDamage 50-150, ADRatio 1, APRatio .8 (asset); the wiki reads the AD part as bonus AD. Its damage
  -- type is not established (the wiki page contradicts itself), so qKind stays nil and the controller takes
  -- the lower of the physical and the magical result.
  qBase=D.Jade_JaxQ.BaseDamage,qBonusAD=D.Jade_JaxQ.ADRatio,qAP=D.Jade_JaxQ.APRatio,
  damageSource='research/family-assets/Jade_Jax/spells.json Jade_JaxLeapStrike DataValues; https://wiki.leagueoflegends.com/en-us/League_Classic/Jax read 2026-10-08',
  -- W ADRatio .2 (asset); the wiki reads it as bonus AD, the lower claim.
  wBonusAD=D.Jade_JaxW.ADRatio,
  -- Counter Strike recast (asset Jade_JaxE DataValues: BaseDamage 50-150, ADRatio .5, PercentIncreasedPerDodge .2,
  -- MaxDodgesForDamageIncrease 5, DodgeDuration 2; no cast-time field). The wiki reads the AD part as bonus AD and
  -- the damage as physical.
  eBase=D.Jade_JaxE.BaseDamage,eAP=0,eHP=0,eBonusAD=D.Jade_JaxE.ADRatio,eKind='physical',eDodgeBonus=D.Jade_JaxE.PercentIncreasedPerDodge,eMaxDodges=D.Jade_JaxE.MaxDodgesForDamageIncrease,eDuration=D.Jade_JaxE.DodgeDuration,eDelay=0,
  eSource='research/family-assets/Jade_Jax/spells.json Jade_JaxE DataValues; https://wiki.leagueoflegends.com/en-us/League_Classic/Jax read 2026-10-10'},
}

end
factories['jhin']=function()
-- Shared Jhin mechanics data. Values preserved from the maintained controller.
-- Reviewed 2026-10-08: qRange 550 is an EDGE range (the wiki's "Edge range" icon on TARGET RANGE: 550; the bounce
--  EFFECT RADIUS 450 carries "Centered range"; speed 1800 / 600, cast 0.25),
--  https://wiki.leagueoflegends.com/en-us/Template:Data_Jhin/Dancing_Grenade. qRangeEdge=true tells the controller to
--  add both gameplay radii for a centre-to-centre check. Live reach is not yet measured.
local D=(function()
return {
 JhinE={
  BaseDamage={20,80,140,200,260},ReducedDamagePercent=.65,TrapAoERadius=260,TrapArmTime=.75,TrapDetonationTime=2,TrapTriggerRadius=160,castRange=750,mCastTime=.25,
 },
 JhinETrap={
  mSpeed=1600,
 },
 JhinPassive={
  ReloadTime=2.5,
 },
 JhinR={
  ADRatio=.25,Damage={64,128,192},FourthShotMultiplier=2,MInimumDelayBetweenShots=1,PercentMissingAmp=3,
 },
 JhinRShotMis={
  mMissileWidth=80,mSpeed=5000,
 },
 JhinRShot={
  castRangeDisplayOverride=3500,
 },
 JhinW={
  BaseDamage={70,105,140,175,210},mCastTime=.75,mLineWidth=40,
 },
 JhinQ={
  ADRatio={.44,.515,.59,.665,.74},BaseDamage={44,69,94,119,144},BounceRange=450,NumberOfBounces=3,PercentAmpOnKill=.35,castRange=550,
 },
}
end)()
return {Jhin={id='normal',q='JhinQ',w='JhinW',e='JhinE',r='JhinR',rShot='JhinRShot',
 qBase=D.JhinQ.BaseDamage,qAD=D.JhinQ.ADRatio,qAP=.6,qRange=D.JhinQ.castRange,qRangeEdge=true,qBounces=D.JhinQ.NumberOfBounces,qBounce=D.JhinQ.BounceRange,qAmp=D.JhinQ.PercentAmpOnKill,
 wBase=D.JhinW.BaseDamage,wAD=.5,wRange=2500,wDelay=D.JhinW.mCastTime,wSpeed=5000,wRadius=D.JhinW.mLineWidth,mark='jhinespotteddebuff',
 -- E arming: asset TrapArmTime .75 against the wiki's 1 s (V26.16). Until the dev trace jhin_trap_spawn settles it,
 -- the conservative 1 s is used (an enemy freed before the trap arms walks out); eArmAsset keeps the asset value.
 -- E damage 20/80/140/200/260 +120% AD +100% AP magic, 65% to minions (asset JhinE BaseDamage/ReducedDamagePercent).
 eRange=D.JhinE.castRange,eArm=1,eArmAsset=D.JhinE.TrapArmTime,eDetonation=D.JhinE.TrapDetonationTime,eRadius=D.JhinE.TrapAoERadius,eTrigger=D.JhinE.TrapTriggerRadius,eSpeed=D.JhinETrap.mSpeed,eCast=D.JhinE.mCastTime,
 eBase=D.JhinE.BaseDamage,eAD=1.2,eAP=1,eMinion=D.JhinE.ReducedDamagePercent,
 rBase=D.JhinR.Damage,rAD=D.JhinR.ADRatio,rMissing=D.JhinR.PercentMissingAmp,rFourth=D.JhinR.FourthShotMultiplier,rRange=D.JhinRShot.castRangeDisplayOverride,rSpeed=D.JhinRShotMis.mSpeed,rRadius=D.JhinRShotMis.mMissileWidth,rDelay=.25,rInterval=D.JhinR.MInimumDelayBetweenShots,rHalfAngle=30.6,
 reload='JhinPassiveReload',passive='JhinPassiveAttackBuff',reloadTime=D.JhinPassive.ReloadTime}}

end
factories['jinx']=function()
-- Shared Jinx mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 JinxWMissile={
  mCastTime=.6,mMissileWidth=60,mSpeed=3300,
 },
 JinxW={
  ADRatio=1.4,Damage={10,60,110,160,210},JinxLowEndWCastTime=.4,JinxWASpeedCastTimeScalarPerHundrethSecond=.08,castRangeDisplayOverride=1450,
 },
 JinxEHit={
  mMissileWidth=120,
 },
 JinxE={
  GrenadeArmTime=.5,GrenadeDuration=5,castRange=925,missileSpeed=1750,
 },
 JinxQ={
  MinigunAttackSpeedDuration=2.5,MinigunAttackSpeedMax={30,55,80,105,130},MinigunAttackSpeedStacks=3,RocketAoERadius=250,RocketBonusRange={100,125,150,175,200},RocketTAD=1.1,
 },
 JinxR={
  AoEDamageMult=.8,AoERadius=400,BaseDamage={20,35,50},MaxDamage={200,350,500},MonsterExecuteMax=1200,PercentDamage={25,30,35},castRange=25000,mCastTime=.6,mMissileWidth=140,mSpeed=1700,
 },
}
end)()
return {Jinx={id='normal',q='JinxQ',w='JinxW',e='JinxE',r='JinxR',
 qRange=D.JinxQ.RocketBonusRange,qSplash=D.JinxQ.RocketAoERadius,qAD=D.JinxQ.RocketTAD,qMana=20,qStacks=D.JinxQ.MinigunAttackSpeedStacks,qStackLife=D.JinxQ.MinigunAttackSpeedDuration,qAS=D.JinxQ.MinigunAttackSpeedMax,
 wBase=D.JinxW.Damage,wAD=D.JinxW.ADRatio,wRange=D.JinxW.castRangeDisplayOverride,wSpeed=D.JinxWMissile.mSpeed,wRadius=D.JinxWMissile.mMissileWidth,wMin=D.JinxW.JinxLowEndWCastTime,wBaseDelay=D.JinxWMissile.mCastTime,wASScalar=D.JinxW.JinxWASpeedCastTimeScalarPerHundrethSecond,
 -- eEffect: chomper effect radius 225 (wiki Jinx V26.16, read 2026-10-10); land/arm timing stays the asset-based
 -- conservative 0.5 + d/1750 + 0.5 until the jinx_e_land trace measures it (wiki: no cast time, lands after 0.4 s).
 eRange=D.JinxE.castRange,eArm=D.JinxE.GrenadeArmTime,eDuration=D.JinxE.GrenadeDuration,eSpeed=D.JinxE.missileSpeed,eDelay=.5,eRadius=D.JinxEHit.mMissileWidth,eEffect=225,
 rMin=D.JinxR.BaseDamage,rMax=D.JinxR.MaxDamage,rMinAD=.12,rMaxAD=1.2,rMissing={D.JinxR.PercentDamage[1]/100,D.JinxR.PercentDamage[2]/100,D.JinxR.PercentDamage[3]/100},rSplash=D.JinxR.AoERadius,rSecondary=D.JinxR.AoEDamageMult,
 -- rMonsterCap: missing-health part against monsters (spells.json JinxR MonsterExecuteMax 1200; wiki V26.16).
 rMonsterCap=D.JinxR.MonsterExecuteMax,rRange=D.JinxR.castRange,rRadius=D.JinxR.mMissileWidth,rDelay=D.JinxR.mCastTime,rSpeed=D.JinxR.mSpeed,rDamageDistance=1500}}

end
factories['karma']=function()
-- Shared Karma Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
local D=(function()
return {
 KarmaSolKimShield={
  BaseShield={80,130,180,230,280},ShieldDuration=2.5,ShieldRatio=.6,castRange=800,
 },
 KarmaQMissile={
  mMissileWidth=60,mSpeed=1700,
 },
 KarmaQMissileMantra={
  castRange=950,mMissileWidth=80,
 },
 KarmaQ={
  APRatio=.7,BaseDamage={60,110,160,210,260},castRangeDisplayOverride=950,
 },
 KarmaSpiritBind={
  APRatio=.45,BaseDamage={40,65,90,115,140},LeashBreakRange=825,TetherDuration=2,castRange=675,mCastTime=.25,
 },
 KarmaMantra={
  EBonusShield={45,85,125,165},EBonusShieldRatio=.45,QBonusAPRatio=.3,QBonusDamage={40,100,160,220},QDetonationAPRatio=.5,QDetonationDamage={40,130,220,310},RWBaseHeal=17,RWHealRatio=.01,
 },
 Jade_KarmaQ={
  BaseHealingPercent=5,DamageAPRatio=.6,HealingAPRatio=.02,castConeAngle=33,
 },
 Jade_KarmaQMissileTemp={
  castRange=650,
 },
 Jade_KarmaW={
  APRatio=.7,Duration=5,LineDuration=3,MantraMultiplier=2,castRange=800,mCastTime=.25,
 },
 Jade_KarmaE={
  AoERange=500,Duration=5,castRangeDisplayOverride=625,
 },
}
end)()
local profiles={}
profiles['Karma']=profiles['Karma']or {}
profiles['Karma'].combat={id='normal',champion='Karma',names={{'KarmaQ'},{'KarmaSpiritBind'},{'KarmaSolKimShield'},{'KarmaMantra'}},
  -- Q missile half-width 60, Mantra missile 80 (26.20 KarmaQMissile / KarmaQMissileMantra lineWidth; dossier
  -- 2026-10-10); Soulflare explodes at the end of its 950 range in a 280 radius (wiki Karma, V26.10, read 2026-10-10).
  q={range=D.KarmaQ.castRangeDisplayOverride,radius=D.KarmaQMissile.mMissileWidth,delay=.25,speed=D.KarmaQMissile.mSpeed,collision=true,type='magical',base=D.KarmaQ.BaseDamage,ap=D.KarmaQ.APRatio,splash=280,
   mantra={range=D.KarmaQMissileMantra.castRange,radius=D.KarmaQMissileMantra.mMissileWidth,endBlast=280}},
  w={range=D.KarmaSpiritBind.castRange,delay=D.KarmaSpiritBind.mCastTime,type='magical',base=D.KarmaSpiritBind.BaseDamage,ap=D.KarmaSpiritBind.APRatio,leash=D.KarmaSpiritBind.LeashBreakRange,duration=D.KarmaSpiritBind.TetherDuration},
  e={range=D.KarmaSolKimShield.castRange,type='shield',base=D.KarmaSolKimShield.BaseShield,ap=D.KarmaSolKimShield.ShieldRatio,duration=D.KarmaSolKimShield.ShieldDuration},r={range=0},
  mantraNames={'KarmaMantra'},tetherNames={'KarmaSpiritBind'},rqBase=D.KarmaMantra.QBonusDamage,rqAP=D.KarmaMantra.QBonusAPRatio,rqDelayed=D.KarmaMantra.QDetonationDamage,rqDelayedAP=D.KarmaMantra.QDetonationAPRatio,rwMissingHeal=D.KarmaMantra.RWBaseHeal/100,rwHealAP=D.KarmaMantra.RWHealRatio/100,reBase=D.KarmaMantra.EBonusShield,reAP=D.KarmaMantra.EBonusShieldRatio}
profiles['Jade_Karma']=profiles['Jade_Karma']or {}
profiles['Jade_Karma'].combat={id='classic',champion='Karma',names={{'Jade_KarmaQ','Jade_KarmaQ_C'},{'Jade_KarmaW'},{'Jade_KarmaE','Jade_KarmaE_C'},{'Jade_KarmaR'}},
  q={range=D.Jade_KarmaQMissileTemp.castRange,radius=100,cone=D.Jade_KarmaQ.castConeAngle,delay=.25,speed=math.huge,type='magical',base={85,125,165,205,245,285},ap=D.Jade_KarmaQ.DamageAPRatio},
  w={range=D.Jade_KarmaW.castRange,delay=D.Jade_KarmaW.mCastTime,type='magical',base={100,140,180,220,260,300},ap=D.Jade_KarmaW.APRatio,duration=D.Jade_KarmaW.Duration,lineDuration=D.Jade_KarmaW.LineDuration},
  e={range=D.Jade_KarmaE.castRangeDisplayOverride,type='shield',base={80,120,160,200,240,280},ap=.8,duration=D.Jade_KarmaE.Duration,area=D.Jade_KarmaE.AoERange},r={range=0},
  mantraNames={'Jade_KarmaR'},mantraChargeNames={'Jade_KarmaR_Charge'},rqHeal={50,70,90,110,130,150},rqMissing=D.Jade_KarmaQ.BaseHealingPercent/100,rqHealAP=D.Jade_KarmaQ.HealingAPRatio/100,rCharges=2,rRecharge={30,25,20},wSpeed={.15,.16,.17,.18,.19,.2},wMantra=D.Jade_KarmaW.MantraMultiplier}
local normal,classic=profiles.Karma.combat,profiles.Jade_Karma.combat
normal.r.maxRank=4
for _,slot in ipairs({'q','w','e'})do classic[slot].maxRank=6 end
normal.usesMantraDamage=true
function normal.rawModifier(p,raw,s,slot,rank,stats,target,options,finite)
 if slot==0 and options.mantra then
  local r=options.ultimateRank
  if not finite(r)or r%1~=0 or not p.rqBase[r]then return 0,'mantra_rank_unknown'end
  raw=raw+p.rqBase[r]+p.rqAP*stats.ap
 end
 return raw,s.type
end
local function heal(p,rank,stats,active,mantra,finite)
 if not mantra or not finite(stats.ap)then return 0 end
 local missing=math.max(0,stats.maxHealth-stats.health)
 if p.id=='normal'then return missing*(p.rwMissingHeal+p.rwHealAP*stats.ap)end
 return(p.rqHeal[rank]or 0)+missing*(p.rqMissing+p.rqHealAP*stats.ap)
end
normal.heal=heal;classic.heal=heal
return profiles

end
factories['karthus']=function()
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
factories['kassadin']=function()
-- Shared Kassadin mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 ForcePulse={
  APRatio=.7,BaseDamage={70,100,130,160,190},
 },
 NullLance={
  BaseDamage={65,95,125,155,185},ShieldAmount={80,110,140,170,200},ShieldDuration=1.5,mCastTime=.25,mSpeed=1400,
 },
 NetherBlade={
  ActiveBaseDamage={50,75,100,125,150},PassiveBaseDamage=25,
 },
 RiftWalk={
  APRatio=.5,APStackRatio=.07,CastRange=500,MaxStacks=4,RBaseCost=40,RBaseDamage={80,95,110},RManaRatio=2,RStackDuration=15,RStackManaRatio=1,StackDamage={35,45,55},castRadius=270,mCastTime=.25,
 },
 Jade_KassadinE={
  APRatio=.7,Damage={80,130,180,230,280},
 },
 Jade_KassadinQ={
  APRatio=.7,BaseDamage={80,130,180,230,280},mCastTime=.25,mSpeed=1400,
 },
 Jade_KassadinR={
  APRatio=.8,AdditionalManaPerCast=100,BuffDuration=8,Damage={60,70,80},MaxDistance=700,MaxStacks=10,castRadius=270,mCastTime=.25,
 },
}
end)()
return {
 Kassadin={id='normal',q='NullLance',w='NetherBlade',e='ForcePulse',r='RiftWalk',wBuff='NetherBladeBuff',
  rBuff='RiftWalk',rRange=D.RiftWalk.CastRange,rBaseCost=D.RiftWalk.RBaseCost,rCostKind='double',rMax=D.RiftWalk.MaxStacks,rDuration=D.RiftWalk.RStackDuration,
  qBase=D.NullLance.BaseDamage,qAP=.8,qSpeed=D.NullLance.mSpeed,wKind='reset',wPassiveBase=D.NetherBlade.PassiveBaseDamage,wPassiveAP=.1,eBase=D.ForcePulse.BaseDamage,eAP=D.ForcePulse.APRatio,
  -- 2026-10-08. R: blink, range 500, cast 0.25, damage radius 270, 80/95/110 (+50% AP) (+2% max mana).
  -- Q: 1.5 s magic-damage shield 80..200 (+30% AP); interrupts channels. W active 50..150 (+80% AP), resets the attack, +50 attack range.
  -- Sources: https://wiki.leagueoflegends.com/en-us/Kassadin and research/family-assets/Kassadin/spells.json (RiftWalk CastRange/RBaseDamage/APRatio/
  -- RManaRatio, castRadius 270; NullLance ShieldAmount/ShieldDuration; NetherBlade ActiveBaseDamage). Shield AP 0.30: the asset's NullLance
  -- mSpellCalculations coefficient (295c2889) confirms the wiki (2026-10-10), so the old d7141e61=0.4 conflict is closed.
  -- 2026-10-10. R stack bonus per current stack: 35/45/55 (+7% AP) (+1% max mana), spells.json RiftWalk StackDamage/APStackRatio/
  -- RStackManaRatio and wiki V26.18. Counted with the stacks held before the cast (the lower of the two readings until measured).
  rCast=D.RiftWalk.mCastTime,rRadius=D.RiftWalk.castRadius,rBase=D.RiftWalk.RBaseDamage,rAP=D.RiftWalk.APRatio,rMana=D.RiftWalk.RManaRatio/100,rSource='wiki Kassadin Riftwalk + family-assets/Kassadin/spells.json RiftWalk, 2026-10-08',
  rStack=D.RiftWalk.StackDamage,rStackAP=D.RiftWalk.APStackRatio,rStackMana=D.RiftWalk.RStackManaRatio/100,wRangeBonus=50,
  qCast=D.NullLance.mCastTime,qInterrupts=true,qShield=D.NullLance.ShieldAmount,qShieldAP=.3,qShieldDuration=D.NullLance.ShieldDuration,
  qShieldSource='wiki Kassadin Null Sphere + family-assets/Kassadin/spells.json NullLance ShieldAmount/ShieldDuration, 2026-10-08',
  wBase=D.NetherBlade.ActiveBaseDamage,wAP=.8},
 Jade_Kassadin={id='classic',q='Jade_KassadinQ',w='Jade_KassadinW',e='Jade_KassadinE',r='Jade_KassadinR',
  wBuff='Jade_KassadinW_Buff',eCounter='Jade_KassadinE_Counter',eAvailable='Jade_KassadinE_CanCast',
  rBuff='Jade_KassadinR',rRange=D.Jade_KassadinR.MaxDistance,rBaseCost=D.Jade_KassadinR.AdditionalManaPerCast,rCostKind='linear',rMax=D.Jade_KassadinR.MaxStacks,rDuration=D.Jade_KassadinR.BuffDuration,
  qBase=D.Jade_KassadinQ.BaseDamage,qAP=D.Jade_KassadinQ.APRatio,qSpeed=D.Jade_KassadinQ.mSpeed,wKind='sustained',eBase=D.Jade_KassadinE.Damage,eAP=D.Jade_KassadinE.APRatio,
  -- 2026-10-08, research/family-assets/Jade_Kassadin/spells.json. R: MaxDistance 700, castRadius 270, Damage 60/70/80, current APRatio 0.8. The cast
  -- delay is not a named value: both undecoded timing fields (90fb0576, 11704a2b = 0.25) and castFrame 10.3 equal the Normal RiftWalk entry,
  -- whose 0.25 s cast time the wiki confirms. Q silences (current SilenceDuration 1..2.6 s), which ends a channel; it grants no shield.
  rCast=D.Jade_KassadinR.mCastTime,rRadius=D.Jade_KassadinR.castRadius,rBase=D.Jade_KassadinR.Damage,rAP=D.Jade_KassadinR.APRatio,rSource='family-assets/Jade_Kassadin/spells.json Jade_KassadinR (cast delay by field parity with RiftWalk), 2026-10-08',
  qCast=D.Jade_KassadinQ.mCastTime,qInterrupts=true},
}

end
factories['kogmaw']=function()
-- Shared KogMaw mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 KogMawLivingArtillery={
  APRatio={.35,.4,.45},Damage={100,140,180},castFrameSeconds=.25,castRadius=240,castRange={1300,1550,1800},
 },
 KogMawQ={
  APRatio=.9,BaseDamage={80,125,170,215,260},castRangeDisplayOverride=1175,
 },
 KogMawQMis={
  mSpeed=1650,
 },
 KogMawVoidOozeMissile={
  castRange=1360,mSpeed=1400,
 },
 KogMawIcathianSurprise={
  TooltipPassiveDuration=4,
 },
 Jade_KogMawPassive={
  passiveDuration=4,
 },
 Jade_KogMawQ={
  APRatio=.7,BaseDamage={60,110,160,210,260},castRange=625,missileSpeed=1500,
 },
 Jade_KogMawR={
  ADRatio=.5,AOERadius=240,APRatio=.3,castFrameSeconds=.25,castRange={1400,1700,2000},
 },
 Jade_KogMawEMissile={
  castRange=1280,mSpeed=1400,
 },
}
end)()
return {
 KogMaw={id='normal',qRange=D.KogMawQ.castRangeDisplayOverride,qSpeed=D.KogMawQMis.mSpeed,qBase=D.KogMawQ.BaseDamage,qAP=D.KogMawQ.APRatio,
  rBuff='kogmawlivingartillerycost',rRange=D.KogMawLivingArtillery.castRange,
  rBase=D.KogMawLivingArtillery.Damage,rAD=.75,rAP=D.KogMawLivingArtillery.APRatio,
  -- R timing: asset castFrame 7.5 (0.25 s) = wiki "CAST TIME: 0.25"; then "drops to the target location
  -- after 0.6 seconds" (https://wiki.leagueoflegends.com/en-us/Kog'Maw, read 2026-10-08). The wiki states a
  -- landing delay after the cast time (same convention as Xerath W, Cho'Gath Q), so the total is .85 s.
  -- Before 2026-10-08 this was an unsourced .6 s total; third-party leads say 1.0-1.15 s. Not live-measured:
  -- the development r_outcome rows are the check. Radius 240 = wiki "EFFECT RADIUS: 240".
  rWindup=D.KogMawLivingArtillery.castFrameSeconds,rImpact=.6,rRadius=D.KogMawLivingArtillery.castRadius,
  -- E: wiki V26.16 (read 2026-10-10) range 1360, width 240, speed 1400; asset KogMawVoidOozeMissile castRange 1360.
  eRange=D.KogMawVoidOozeMissile.castRange,eSpeed=D.KogMawVoidOozeMissile.mSpeed,
  -- Icathian Surprise (death passive): asset KogMawIcathianDisplay TooltipPassiveDuration 4, TooltipPassiveMS .4,
  -- true damage ByCharLevelInterpolation 140 -> 650 (linear over levels 1..18); radius 400 from the wiki V26.16
  -- (read 2026-10-10). Buff name kogmawicathiansurprise (shared CannotDie list).
  passive={buffs={kogmawicathiansurprise=true},duration=D.KogMawIcathianSurprise.TooltipPassiveDuration,radius=400,damageStart=140,damageEnd=650}},
 -- Classic Q is UNIT-TARGETED, range 625: installed asset research/family-assets/Jade_KogMaw/spells.json
 -- `Jade_KogMawQ` has castRange 625, missileSpeed 1500, the basic attack's targeted transport and no lineWidth
 -- block (the real skillshot `Jade_KogMawE` carries lineWidth 120), which is the Season 3 spell (patch history:
 -- targeted until V4.4, range 625 since V1.0.0.118b). Disagreeing leads, recorded and not used: the wiki page
 -- https://wiki.leagueoflegends.com/en-us/League_Classic/Kog'Maw (read 2026-10-08) says range 600 and
 -- "direction-targeted"; ClassicKogMaw.lua casts a 1000-range line (the V4.4 spell). A cast on the unit inside
 -- 625 is right under either reading; only reach beyond 625 would differ, and nothing supports that.
 Jade_KogMaw={id='classic',qRange=D.Jade_KogMawQ.castRange,qSpeed=D.Jade_KogMawQ.missileSpeed,qBase=D.Jade_KogMawQ.BaseDamage,qAP=D.Jade_KogMawQ.APRatio,
  rBuff='jade_kogmawrcost',rRange=D.Jade_KogMawR.castRange,
  rBase={180,270,360},rAD=D.Jade_KogMawR.ADRatio,rAP={D.Jade_KogMawR.APRatio,D.Jade_KogMawR.APRatio,D.Jade_KogMawR.APRatio},
  -- R timing: windup .25 s = Jade_KogMawR castFrame 7.5 and live castEnd-castStart
  -- (session a1ed0e46). Impact remainder .85 s is an estimate (third-party evade
  -- totals 1.1-1.2 s from cast start); no Classic impact measurement exists yet,
  -- see the development r_outcome rows. Radius 240 = asset AOERadius/castRadius.
  -- The Classic wiki page (read 2026-10-08) says "lands after 0.6 seconds" (.85 s total with the cast) and
  -- "EFFECT RADIUS: 100"; both disagree with the asset/third-party values and are recorded only. E on that
  -- page: range 1280, speed 1350 (ours 1200 / 1400 from the asset's display range and child missile).
  rWindup=D.Jade_KogMawR.castFrameSeconds,rImpact=.85,rRadius=D.Jade_KogMawR.AOERadius,
  -- E: asset Jade_KogMawEMissile castRange 1280 (Classic wiki 1280; its speed 1350 is recorded, the asset's 1400 used).
  eRange=D.Jade_KogMawEMissile.castRange,eSpeed=D.Jade_KogMawEMissile.mSpeed,
  -- Death passive: asset Jade_KogMawPassive passiveDuration 4, damage 125+25 per level; the explosion radius has no
  -- Classic source, so pursuit stays off for Classic (development trace kogmaw_passive settles duration and damage).
  passive={buffs={jade_kogmawicathiansurprise=true,jade_kogmawpassivebuff=true},duration=D.Jade_KogMawPassive.passiveDuration,radius=nil,unknown='classic_radius_unmeasured'}},
}

end
factories['leona']=function()
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
local D=(function()
return {
 LeonaShieldOfDaybreak={
  BaseDamage={10,35,60,85,110},
 },
 LeonaZenithBlade={
  BaseDamage={50,90,130,170,210},mCastTime=.25,
 },
 LeonaZenithBladeMissile={
  castRange=900,mMissileWidth=70,
 },
 LeonaSolarFlare={
  CCDuration=1.75,ExplosionBaseDamage={150,225,300},
 },
 LeonaSolarBarrier={
  ArmorMRDuration=3,MRBaseBonus={20,27.5,35,42.5,50},
 },
 Jade_LeonaZenithBladeMissile={
  castRange=900,mMissileWidth=90,
 },
 Jade_LeonaZenithBlade={
  BaseDamage={60,100,140,180,220},
 },
 Jade_LeonaSolarBarrier={
  BonusARMR={30,40,50,60,70},BuffDuration=3,
 },
 Jade_LeonaShieldOfDaybreak={
  Damage={40,70,100,130,160},
 },
 Jade_LeonaSolarFlare={
  CCDuration=1.5,ExplosionBaseDamage={150,250,350},
 },
}
end)()
return {
 Leona={classic=false,q=D.LeonaShieldOfDaybreak.BaseDamage,e=D.LeonaZenithBlade.BaseDamage,r=D.LeonaSolarFlare.ExplosionBaseDamage,width=D.LeonaZenithBladeMissile.mMissileWidth,
  qBuff='LeonaShieldOfDaybreak',eCast='LeonaZenithBlade',root='LeonaZenithBladeRoot',sunlight='LeonaSunlight',wBuff='LeonaSolarBarrier',
  eRange=D.LeonaZenithBladeMissile.castRange,rCast=D.LeonaZenithBlade.mCastTime,rImpact=.625,rEpicenter=100,rArea=325,rStun=D.LeonaSolarFlare.CCDuration,qBonusRange=50,
  wResist=D.LeonaSolarBarrier.MRBaseBonus,wDuration=D.LeonaSolarBarrier.ArmorMRDuration,w='LeonaSolarBarrier',
  wSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Leona/Eclipse (cast time none, armor/MR 20-50 for 3 s) + family-assets/Leona/spells.json LeonaSolarBarrier ArmorBaseBonus/MRBaseBonus/ArmorMRDuration, read 2026-10-10; rank base only (lower bound)'},
 Jade_Leona={classic=true,q=D.Jade_LeonaShieldOfDaybreak.Damage,e=D.Jade_LeonaZenithBlade.BaseDamage,r=D.Jade_LeonaSolarFlare.ExplosionBaseDamage,width=D.Jade_LeonaZenithBladeMissile.mMissileWidth,
  qBuff='Jade_LeonaShieldOfDaybreak',eCast='Jade_LeonaZenithBlade',root='Jade_LeonaZenithBladeRoot',sunlight='Jade_LeonaSunlight',wBuff='Jade_LeonaSolarBarrier',
  eRange=D.Jade_LeonaZenithBladeMissile.castRange,rCast=.25,rImpact=.625,rEpicenter=100,rArea=325,rStun=D.Jade_LeonaSolarFlare.CCDuration,qBonusRange=50,
  wResist=D.Jade_LeonaSolarBarrier.BonusARMR,wDuration=D.Jade_LeonaSolarBarrier.BuffDuration,w='Jade_LeonaSolarBarrier',
  wSource='family-assets/Jade_Leona/spells.json Jade_LeonaSolarBarrier BonusARMR/BuffDuration + wiki League_Classic/Leona, read 2026-10-10'}
}

end
factories['lucian']=function()
-- Lucian Normal/Classic mechanics. Details and witnesses: CombatProfiles/lucian-provenance.json.
-- Normal: installed 16.21 asset data/characters/lucian/lucian.bin (Lucian.wad.client 2026-10-21).
-- Classic: the same archive's data/characters/jade_lucian/jade_lucian.bin plus the live recording of an
-- enemy Jade_Lucian on 2026-10-27 (FamilyTelemetry-v2-223..234): Q windup 0.35 at rank 3, W windup 0.30,
-- W missile 1600 speed and 55 width over 1000 units, R missiles 2800 speed and 110 width over 1400 units.
-- Ranks index asset arrays from 1. Per-shot R values; the shot count is in r.shots (nil when not established).
local D=(function()
return {
 LucianRMissile={
  castRange=1200,mMissileWidth=110,mSpeed=2800,
 },
 LucianR={
  BaseDamage={15,30,45},DamageADRatio=.25,DamageAPRatio=.15,Duration=3,NumShots=22,PercentDamageAmpToMinions=200,
 },
 LucianW={
  BaseDamage={75,110,145,180,215},castFrameSeconds=.3,castRangeDisplayOverride=900,
 },
 LucianWMissile={
  mMissileWidth=55,mSpeed=1600,
 },
 LucianQ={
  BaseDamage={90,130,170,210,250},BonusADRatio=1,Range=1000,castRange=500,mCastTime=.35,
  pathWidth=120,
 },
 LucianE={
  DashSpeed=1350,MaxDistance=425,MinDistance=200,
 },
 Jade_LucianE={
  DashSpeed=1350,MaxDistance=425,MinDistance=200,
 },
 Jade_LucianRMissile={
  castRange=1200,mMissileWidth=110,mSpeed=2800,
 },
 Jade_LucianR={
  BaseDamage={40,50,60},DamageADRatio=.25,DamageAPRatio=.1,Duration=3,PercentDamageAmpToMinions=400,
 },
 Jade_LucianW={
  ADRatio=.6,APRatio=.9,BaseDamage={60,100,140,180,220},castRangeDisplayOverride=1000,mCastTime=.3,
 },
 Jade_LucianWMissile={
  mMissileWidth=55,mSpeed=1600,
 },
 Jade_LucianQ={
  BaseDamage={80,110,140,170,200},BonusADRatio={.6,.75,.9,1.05,1.2},Range=1150,Width=100,castRange=500,mCastTime=.35,
 },
}
end)()
local profiles={}
profiles['Lucian']=profiles['Lucian']or {}
profiles['Lucian'].combat={id='normal',champion='Lucian',names={{'LucianQ'},{'LucianW'},{'LucianE'},{'LucianR'}},
  q={range=D.LucianQ.castRange,beam=D.LucianQ.Range,radius=D.LucianQ.pathWidth/2,delay=D.LucianQ.mCastTime,type='physical',base=D.LucianQ.BaseDamage,bonusAD=D.LucianQ.BonusADRatio},
  w={range=D.LucianW.castRangeDisplayOverride,radius=D.LucianWMissile.mMissileWidth,delay=D.LucianW.castFrameSeconds,speed=D.LucianWMissile.mSpeed,collision=true,type='magical',base=D.LucianW.BaseDamage,ap=.9},
  e={range=D.LucianE.MaxDistance,minimum=D.LucianE.MinDistance,speed=D.LucianE.DashSpeed,mobility=true},
  r={range=D.LucianRMissile.castRange,radius=D.LucianRMissile.mMissileWidth,speed=D.LucianRMissile.mSpeed,duration=D.LucianR.Duration,type='physical',base=D.LucianR.BaseDamage,ad=D.LucianR.DamageADRatio,ap=D.LucianR.DamageAPRatio,shots=D.LucianR.NumShots,minion=D.LucianR.PercentDamageAmpToMinions/100},
  passiveNames={'LucianPassiveBuff'},channelNames={'LucianR'},
  -- Lightslinger second shot: 50% AD, 55% from level 7, 60% from level 13 against champions; full AD otherwise.
  passiveLevels={{1,.5},{7,.55},{13,.6}}}
profiles['Jade_Lucian']=profiles['Jade_Lucian']or {}
profiles['Jade_Lucian'].combat={id='classic',champion='Lucian',names={{'Jade_LucianQ'},{'Jade_LucianW'},{'Jade_LucianE'},{'Jade_LucianR'}},
  q={range=D.Jade_LucianQ.castRange,beam=D.Jade_LucianQ.Range,radius=D.Jade_LucianQ.Width/2,delay=D.Jade_LucianQ.mCastTime,type='physical',base=D.Jade_LucianQ.BaseDamage,bonusAD=D.Jade_LucianQ.BonusADRatio},
  w={range=D.Jade_LucianW.castRangeDisplayOverride,radius=D.Jade_LucianWMissile.mMissileWidth,delay=D.Jade_LucianW.mCastTime,speed=D.Jade_LucianWMissile.mSpeed,collision=true,type='magical',base=D.Jade_LucianW.BaseDamage,bonusAD=D.Jade_LucianW.ADRatio,ap=D.Jade_LucianW.APRatio},
  e={range=D.Jade_LucianE.MaxDistance,minimum=D.Jade_LucianE.MinDistance,speed=D.Jade_LucianE.DashSpeed,mobility=true},
  -- The Classic shot count scales with attack speed through values whose formula is not established: no count.
  r={range=D.Jade_LucianRMissile.castRange,radius=D.Jade_LucianRMissile.mMissileWidth,speed=D.Jade_LucianRMissile.mSpeed,duration=D.Jade_LucianR.Duration,type='physical',base=D.Jade_LucianR.BaseDamage,bonusAD=D.Jade_LucianR.DamageADRatio,ap=D.Jade_LucianR.DamageAPRatio,minion=D.Jade_LucianR.PercentDamageAmpToMinions/100},
  passiveNames={'Jade_LucianPassiveBuff'},channelNames={'Jade_LucianR'},
  passiveLevels={{1,.5}}}
local normal,classic=profiles.Lucian.combat,profiles.Jade_Lucian.combat
-- R: P.Raw gives one shot; this answers every shot of the channel landing (an upper bound the caller scales).
local function modifier(p,raw,s,slot,rank,stats,target,options,finite)
 if slot==3 then
  if not finite(s.shots)then return 0,'shot_count_unknown'end
  if target and target.team~=nil and target.type~=stats.heroType then raw=raw*(s.minion or 1)end
  return raw*s.shots,s.type
 end
 return raw,s.type
end
normal.rawModifier=modifier;classic.rawModifier=modifier
local function passive(p,stats,target)
 local ratio=1
 if not target or target.type==stats.heroType then
  ratio=p.passiveLevels[1][2]
  for _,row in ipairs(p.passiveLevels)do if stats.level>=row[1]then ratio=row[2]end end
 end
 return ratio*stats.totalDamage,'physical'
end
normal.passive=passive;classic.passive=passive
return profiles

end
factories['lulu']=function()
-- Shared Lulu mechanics data. Values preserved from the maintained controller.
-- shieldSource names where the E shield figures offered to Evade were read (2026-10-08).
local D=(function()
return {
 LuluQ={
  BaseDamage={60,95,130,165,200},MinionMod=.7,
 },
 LuluWTwo={
  mCastTime=.2419,missileSpeed=2250,
 },
 LuluE={
  BaseDamage={70,110,150,190,230},BaseShield={70,110,150,190,230},DamageAPRatio=.5,ShieldAPRatio=.5,ShieldDuration=2.5,
 },
 LuluR={
  AoERadius=400,BonusHealth={275,425,575},BuffDuration=7,mCastTime=.25,
 },
 Jade_LuluW={
  missileSpeed=2000,
 },
 Jade_LuluWTwo={
  missileSpeed=2250,
 },
 Jade_LuluE={
  BaseDamage={80,130,180,230,280},BaseShield={60,105,150,195,240},DamageAPRatio=.6,ShieldAPRatio=.4,ShieldDuration=6,
 },
 Jade_LuluQ={
  BaseDamage={80,125,170,215,260},
 },
 Jade_LuluR={
  AoERadius=400,BonusHealth={300,450,600},BuffDuration=7,mCastTime=.25,
 },
}
end)()
return {
 Lulu={id='normal',q='LuluQ',w='LuluW',e='LuluE',r='LuluR',qBase=D.LuluQ.BaseDamage,qMinion=D.LuluQ.MinionMod,
  eBase=D.LuluE.BaseDamage,eAP=D.LuluE.DamageAPRatio,shield=D.LuluE.BaseShield,shieldAP=D.LuluE.ShieldAPRatio,shieldDuration=D.LuluE.ShieldDuration,
   -- wDelay: the larger of the installed asset (.175) and the wiki W cast time (.2419, V25.16, read 2026-10-10)
   -- until the lulu_w_probe recorder settles it; a later landing only makes W interrupts stricter.
   rHealth=D.LuluR.BonusHealth,rAP=.55,wAS=true,wSpeed=D.LuluWTwo.missileSpeed,wAllySpeed=math.huge,eDelay=.175,wDelay=D.LuluWTwo.mCastTime,rDelay=D.LuluR.mCastTime,rRadius=D.LuluR.AoERadius,
   shieldBuff='lulufaerieshield',pixEnemyBuff='luluevision',rDuration=D.LuluR.BuffDuration,rOfferAP=.55,
   rSource='https://wiki.leagueoflegends.com/en-us/Lulu Wild Growth: +275/425/575 (+55% AP) health for 7 s, range 900, no cast time (read 2026-10-08); rDelay is the installed timing (later start = safe side)',
   shieldSource='https://wiki.leagueoflegends.com/en-us/Lulu Help, Pix!: 70-230 (+50% AP), 2.5 s, no cast time (read 2026-10-08); eDelay is the installed asset timing',
   -- Ally attack steroids W answers (native cast names, lower case): spell names in the installed assets
   -- research/family-assets/<Champion>/spells.json (read 2026-10-10). A name the host does not report never matches.
   wSteroids={twitchfullautomatic=true,vayneinquisition=true,kogmawbioarcanebarrage=true,asheq=true,kaisae=true,tristanaq=true,xayahw=true,highlander=true},
   -- Engage states that are neither channels nor dashes (buff names, lower case; same asset spell names). Logged by
   -- the lulu_engage_state recorder; a name the host does not use never matches.
   wEngage={hecarimramp=true,powerball=true,highlander=true,kaisae=true,swainr=true,neekor=true}},
 Jade_Lulu={id='classic',q='Jade_LuluQ',w='Jade_LuluW',e='Jade_LuluE',r='Jade_LuluR',qBase=D.Jade_LuluQ.BaseDamage,qMinion=1,
  eBase=D.Jade_LuluE.BaseDamage,eAP=D.Jade_LuluE.DamageAPRatio,shield=D.Jade_LuluE.BaseShield,shieldAP=D.Jade_LuluE.ShieldAPRatio,shieldDuration=D.Jade_LuluE.ShieldDuration,
   rHealth=D.Jade_LuluR.BonusHealth,rAP=.5,wAS=false,wSpeed=D.Jade_LuluWTwo.missileSpeed,wAllySpeed=D.Jade_LuluW.missileSpeed,eDelay=.175,wDelay=.175,rDelay=D.Jade_LuluR.mCastTime,rRadius=D.Jade_LuluR.AoERadius,
   shieldBuff='Jade_LuluFaerieShield',pixEnemyBuff='Jade_LuluFaerieBurn',rDuration=D.Jade_LuluR.BuffDuration,rOfferAP=0,
   -- The asset holds no AP coefficient for BonusHealth; rAP=.5 above is the kept controller value, so the Evade offer counts the base only.
   rSource='research/family-assets/Jade_Lulu/spells.json:2456,2482 (BonusHealth 300/450/600, BuffDuration 7; 2026-10-08); AP share not in the asset: offer uses the base amount',
   shieldSource='research/family-assets/Jade_Lulu/spells.json:705,718,731 (60-240 +40% AP, 6 s; 2026-10-08); eDelay is the installed asset timing',
   -- Classic W empowers casters (no attack-steroid catalogue). Engage states: Classic asset spell names (2026-10-10).
   wEngage={jade_rammusq=true,jade_masteryihighlander=true}},
}

end
factories['lux']=function()
-- Lux mechanics, Normal and Classic kept separate (no value is borrowed across profiles).
-- Provenance: CombatProfiles/lux-provenance.json. Arrays are indexed by spell rank (passive: by champion level).
-- Ranges are the maintained conservative values (display ranges); the wiki/asset maxima are recorded in the
-- provenance file and are settled from the development trace lux_cast_reach before any range is widened.
local D=(function()
return {
 LuxPrismaticWaveMissile={
  mInitialSpeed=2200,mMissileWidth=110,
 },
 LuxPrismaticWave={
  APRatio=.4,BaseShieldAmount={40,55,70,85,100},ShieldDuration=2.5,
 },
 LuxLightBindingMis={
  castRangeDisplayOverride=1175,mMissileWidth=70,mSpeed=1200,
 },
 LuxLightBinding={
  APRatio=.75,BaseDamage={80,120,160,200,240},RootDuration=2,castFrameSeconds=.25,
 },
 LuxIlluminationPassive={
  APRatio=.35,DebuffDuration=6,
 },
 LuxLightStrikeKugel={
  BaseDamage={65,115,165,215,265},SlowZoneDuration=5,castFrameSeconds=.25,castRadius=295,castRange=1100,missileSpeed=1300,
 },
 LuxR={
  Damage={300,400,500},castRangeDisplayOverride=3340,
 },
 Jade_LuxLightBindingMis={
  castRangeDisplayOverride=1175,mMissileWidth=70,mSpeed=1200,
 },
 Jade_LuxLightBinding={
  APRatio=.7,BaseDamage={60,110,160,210,260},castFrameSeconds=.25,
 },
 Jade_LuxPrismaticWave={
  APRatio=.35,BaseShieldAmount={80,105,130,155,180},ShieldDuration=3,
 },
 Jade_LuxPrismaticWaveMissile={
  mMissileWidth=110,mSpeed=1400,
 },
 Jade_LuxR={
  APRatio=.85,Damage={300,400,500},castRangeDisplayOverride=3340,
 },
 Jade_LuxLightStrikeKugel={
  AOEradius=350,APRatio=.6,Damage={60,105,150,195,240},SlowZoneDuration=5,castFrameSeconds=.25,castRange=1000,mSpeed=1300,
 },
 Jade_LuxIlluminationPassive={
  DebuffDuration=6,
 },
}
end)()
return {
 Lux={id='normal',qCast='LuxLightBinding',wCast='LuxPrismaticWave',eCast='LuxLightStrikeKugel',
  eToggle='LuxLightstrikeToggle',rCast='LuxR',mark={'LuxIlluminatingFraulein'},
  -- Q: 80-240 +75% AP; roots the first TWO enemies for 2 s, both at full damage (no second-target factor).
  qBase=D.LuxLightBinding.BaseDamage,qAP=D.LuxLightBinding.APRatio,qSecond=1,qRoot=D.LuxLightBinding.RootDuration,qSecondRoot=2,qRange=D.LuxLightBindingMis.castRangeDisplayOverride,qSpeed=D.LuxLightBindingMis.mSpeed,qRadius=D.LuxLightBindingMis.mMissileWidth,qDelay=D.LuxLightBinding.castFrameSeconds,
  -- W: 40-100 +40% AP for 2.5 s, out and back (a unit passed twice holds two shields; one is offered).
  wBase=D.LuxPrismaticWave.BaseShieldAmount,wAP=D.LuxPrismaticWave.APRatio,wRange=1100,wSpeed=D.LuxPrismaticWaveMissile.mInitialSpeed,wRadius=D.LuxPrismaticWaveMissile.mMissileWidth,wDelay=.25,wDuration=D.LuxPrismaticWave.ShieldDuration,
  wSource='Normal W 40/55/70/85/100 +40% AP, 2.5 s, cast .25: research/family-assets/Lux/spells.json (LuxPrismaticWave BaseShieldAmount, APRatio, ShieldDuration) and https://wiki.leagueoflegends.com/en-us/Lux (read 2026-10-10, V26.04)',
  -- E: 65-265 +80% AP, asset radius 295 (wiki 310), range 1100, missile 1300, zone 5 s.
  eBase=D.LuxLightStrikeKugel.BaseDamage,eAP=.8,eRange=D.LuxLightStrikeKugel.castRange,eSpeed=D.LuxLightStrikeKugel.missileSpeed,eRadius=D.LuxLightStrikeKugel.castRadius,eDelay=D.LuxLightStrikeKugel.castFrameSeconds,eZone=D.LuxLightStrikeKugel.SlowZoneDuration,
  -- Normal Lux cannot recast during Final Spark's cast; only Classic 26.17 allows the detonation then.
  eDuringR=false,
  -- R: 300/400/500 +120% AP, 1 s cast, half-width 95 (asset lineWidth 190; wiki 200).
  rBase=D.LuxR.Damage,rAP=1.2,rRange=D.LuxR.castRangeDisplayOverride,rRadius=95,rDelay=1,
  -- Illumination: 20 + 10 per level (+35% AP), mark 6 s, consumed by an attack or R.
  pFlat=20,pLevel=10,pAP=D.LuxIlluminationPassive.APRatio,pMark=D.LuxIlluminationPassive.DebuffDuration},
 Jade_Lux={id='classic',qCast='Jade_LuxLightBinding',wCast='Jade_LuxPrismaticWave',eCast='Jade_LuxLightStrikeKugel',
  eToggle='Jade_LuxLightstrikeToggle',rCast='Jade_LuxR',mark={'Jade_LuxIlluminatingFraulein','LuxIlluminatingFraulein'},
  -- Q: 60-260 +70% AP; passes one unit, the second takes half damage and a 1 s root.
  qBase=D.Jade_LuxLightBinding.BaseDamage,qAP=D.Jade_LuxLightBinding.APRatio,qSecond=.5,qRoot=2,qSecondRoot=1,qRange=D.Jade_LuxLightBindingMis.castRangeDisplayOverride,qSpeed=D.Jade_LuxLightBindingMis.mSpeed,qRadius=D.Jade_LuxLightBindingMis.mMissileWidth,qDelay=D.Jade_LuxLightBinding.castFrameSeconds,
  -- Shield numbers for the Evade offer. Lux herself is shielded when the cast starts (Classic Patch 2:
  -- "Shield now occurs at cast time instead of after cast time"); the offer still declares the full
  -- .25 s cast, so its window starts late rather than early. The wiki lists range 1175 and speed 2400
  -- and the asset shows display range 1150 / missile 1200: wRange and wSpeed are the maintained
  -- conservative values and only decide the ally reach, not the self shield.
  wBase=D.Jade_LuxPrismaticWave.BaseShieldAmount,wAP=D.Jade_LuxPrismaticWave.APRatio,wRange=1100,wSpeed=D.Jade_LuxPrismaticWaveMissile.mSpeed,wRadius=D.Jade_LuxPrismaticWaveMissile.mMissileWidth,wDelay=.25,wDuration=D.Jade_LuxPrismaticWave.ShieldDuration,
  wSource='Classic W 80/105/130/155/180 +35% AP, 3 s, cast .25: research/family-assets/Jade_Lux/spells.json (BaseShieldAmount, APRatio, ShieldDuration) and https://wiki.leagueoflegends.com/en-us/League_Classic/Lux (2026-10-08)',
  eBase=D.Jade_LuxLightStrikeKugel.Damage,eAP=D.Jade_LuxLightStrikeKugel.APRatio,eRange=D.Jade_LuxLightStrikeKugel.castRange,eSpeed=D.Jade_LuxLightStrikeKugel.mSpeed,eRadius=D.Jade_LuxLightStrikeKugel.AOEradius,eDelay=D.Jade_LuxLightStrikeKugel.castFrameSeconds,eZone=D.Jade_LuxLightStrikeKugel.SlowZoneDuration,
  eDuringR=true,
  rBase=D.Jade_LuxR.Damage,rAP=D.Jade_LuxR.APRatio,rRange=D.Jade_LuxR.castRangeDisplayOverride,rRadius=95,rDelay=1,
  -- Illumination: 20 at level 1 to 190 at level 18, no AP (asset calc {20,190}, linear by level assumed).
  pFlat=10,pLevel=10,pAP=0,pMark=D.Jade_LuxIlluminationPassive.DebuffDuration},
}

end
factories['malphite']=function()
-- Shared Malphite mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 Obduracy={
  ThunderclapBaseDamage={30,40,50,60,70},ThunderclapBaseDamageAPRatio=.2,ThunderclapBaseDamageArmorRatio=.15,ThunderclapBuffDuration=5,
 },
 UFSlash={
  BaseDamage={200,300,400},KnockupDuration=1.5,castRadius=270,castRange=1000,
 },
 SeismicShard={
  BaseDamage={70,120,170,220,270},
 },
 Landslide={
  BaseDamage={60,95,130,165,200},
 },
 Jade_MalphiteLandslide={
  APScaling_Jade=.2,ArmorScaling_Jade=.3,BaseDamage={60,100,140,180,220},
 },
 Jade_MalphiteUFSlash={
  BaseDamage={200,300,400},KnockupDuration=1.5,castRadius=270,castRange=1000,
 },
 Jade_MalphiteObduracy={
  ADBonus={.2,.25,.3,.35,.4},BuffDuration=6,
 },
 Jade_MalphiteSeismicShard={
  BaseDamage={70,120,170,220,270},
 },
}
end)()
return {
 Malphite={id='normal',q='SeismicShard',w='Obduracy',e='Landslide',r='UFSlash',shield='MalphiteShield',
   wKind='reset_splash',wDuration=D.Obduracy.ThunderclapBuffDuration,qBase=D.SeismicShard.BaseDamage,qAP=.6,eBase=D.Landslide.BaseDamage,eAP=.6,eArmor=.4,
   -- Unstoppable Force. The speed is 1500 + 100% movement speed (base 335 = 1835); a registration takes fixed
   -- numbers, so rSpeeds is a bracket whose slow end (a roughly 40% slowed Malphite) is the safety margin.
   rBase=D.UFSlash.BaseDamage,rAP=.9,rRange=D.UFSlash.castRange,rSpeeds={1700,1835},rDelays={0},
   rSource='https://wiki.leagueoflegends.com/en-us/Malphite Unstoppable Force: range 1000, no cast time, speed 1500 + 100% movement speed, 200/300/400 (+90% AP), base movement speed 335 (read 2026-10-08)',
   -- 2026-10-10 (wiki Malphite V26.09 read 2026-10-10; spells.json UFSlash KnockupDuration, Obduracy Thunderclap*).
   -- R prediction speed 1500 + current movement speed (rBaseSpeed), knock-up 1.5 s. Hit radius 270 (asset castRadius) is
   -- kept for counting; the wiki's 325 effect radius waits for the malphite_r_landing dev trace (rEffectRadius unused).
   -- W Thunderclap on-hit 30/40/50/60/70 (+20% AP) (+15% armor) physical while W is active.
   rBaseSpeed=1500,rKnockup=D.UFSlash.KnockupDuration,rRadius=D.UFSlash.castRadius,rEffectRadius=325,wOnHit=D.Obduracy.ThunderclapBaseDamage,wOnHitAP=D.Obduracy.ThunderclapBaseDamageAPRatio,wOnHitArmor=D.Obduracy.ThunderclapBaseDamageArmorRatio},
 Jade_Malphite={id='classic',q='Jade_MalphiteSeismicShard',w='Jade_MalphiteObduracy',e='Jade_MalphiteLandslide',r='Jade_MalphiteUFSlash',shield='Jade_MalphiteShield',
   wBuff='Jade_MalphiteObduracyBuff',wKind='ad_armor_boost',wDuration=D.Jade_MalphiteObduracy.BuffDuration,qBase=D.Jade_MalphiteSeismicShard.BaseDamage,qAP=.6,eBase=D.Jade_MalphiteLandslide.BaseDamage,eAP=D.Jade_MalphiteLandslide.APScaling_Jade,eArmor=D.Jade_MalphiteLandslide.ArmorScaling_Jade,
   -- The Classic page gives the same dash shape as Normal (the asset holds only castRange 1000, spells.json:496).
   rBase=D.Jade_MalphiteUFSlash.BaseDamage,rAP=1,rRange=D.Jade_MalphiteUFSlash.castRange,rSpeeds={1700,1835},rDelays={0},
   rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Malphite Unstoppable Force: range 1000, no cast time, speed 1500 + 100% movement speed, 200/300/400 (+100% AP), base movement speed 335 (read 2026-10-08)',
   -- 2026-10-10 (wiki League_Classic/Malphite edited 2026-09-22, read 2026-10-10; spells.json Jade_MalphiteUFSlash
   -- KnockupDuration, Jade_MalphiteObduracy ADBonus 0.20..0.40 for 6 s). Same dash model and counting radius as Normal.
   rBaseSpeed=1500,rKnockup=D.Jade_MalphiteUFSlash.KnockupDuration,rRadius=D.Jade_MalphiteUFSlash.castRadius,rEffectRadius=325,wAD=D.Jade_MalphiteObduracy.ADBonus},
}

end
factories['masteryi']=function()
-- Shared MasterYi mechanics data. Values preserved from the maintained controller.
-- wReset: Meditate resets the basic attack timer (both read 2026-10-08).
--   Normal:  https://wiki.leagueoflegends.com/en-us/Master_Yi, Meditate: "resets Master Yi's basic attack timer".
--   Classic: https://wiki.leagueoflegends.com/en-us/League_Classic/Master_Yi, Meditate notes: "immediately canceling the
--            channel for the attack reset does not guarantee one tick of healing"; the Jade_ asset declares
--            Trait_AttackReset (attack_resets.lua). Not live-timed.
-- Meditate as a defence, offered to Evade (C:RegisterEffect, 2026-10-10):
--   Normal:  70% damage reduction for the first 0.5 s, then 45/47.5/50/52.5/55%, halved against turrets, lingering
--            0.5 s; channel up to 4 s (same Normal page).
--   Classic: +100/150/200/250/300 armor and magic resistance while channelling, up to 5 s (same Classic page).
--   Asset (research/family-assets/{MasterYi,Jade_MasterYi}/spells.json, read 2026-10-10): Normal Meditate DamageReduction
--            .45/.475/.5/.525/.55 (ranks 1-5), InitialExtraDR .25/.225/.2/.175/.15 for InitialExtraDRDuration .5 (70% at
--            every rank, matching the wiki), DamageReductionTowerMod .5, HealDuration 4; Classic DefenseStat 100-300,
--            Duration 5; both castFrame 3.25 (30 fps: .108 s). Turret shots are not Evade threats, so the turret halving
--            never enters an Evade forecast.
-- Alpha Strike bounce search: asset field 8f6f40e6 550 (both profiles); the Normal wiki says 600. The controller uses
--   550 (fewer counted bounce targets is the conservative side); live bounce observation settles it.
-- Q first strike: castFrame 7.935 at 30 fps (.26 s, both assets), used as the LastHit rescue impact.
-- Alpha Strike (Normal page): marks every 0.231 s, 4 marks, reappears after 0.165 s (1.087 s with 4 bounces). The
--   controller keeps its conservative one-strike .25 s untargetable minimum; the Classic page states no duration.
local D=(function()
return {
 MasterYiPassive={
  AttackCount=4,StackDuration=4,
 },
 AlphaStrike={
  AttackDamageRatio=.7,BaseDamage={20,40,60,80,100},BonusMonsterDamage={60,85,110,135,160},
 },
 Meditate={
  DamageReduction={.45,.475,.5,.525,.55},HealDuration=4,InitialExtraDRDuration=.5,castFrame=3.25,
 },
 WujuStyle={
  ADRatio=.35,BaseDamage={20,25,30,35,40},Duration=5,
 },
 Highlander={
  RDuration=7,
 },
 Jade_MasterYiAlphaStrike={
  APRatio=1,BaseDamage={100,150,200,250,300},TotalMonsterDamage={260,320,380,440,500},
 },
 Jade_MasterYiHighlander={
  RDuration={8,10,12},
 },
 Jade_MasterYiWujuStyle={
  Duration=10,PassiveAD={15,20,25,30,35},
 },
 Jade_MasterYiMeditate={
  DefenseStat={100,150,200,250,300},Duration=5,castFrame=3.25,
 },
}
end)()
return {
    normal={id='normal',wReset=true,q='AlphaStrike',w='Meditate',e='WujuStyle',r='Highlander',qType='physical',qBase=D.AlphaStrike.BaseDamage,qAD=D.AlphaStrike.AttackDamageRatio,qMonster=D.AlphaStrike.BonusMonsterDamage,
      eBase=D.WujuStyle.BaseDamage,eBonusAD=D.WujuStyle.ADRatio,eActive='WujuStyleSuperCharged',eDuration=D.WujuStyle.Duration,rDuration=D.Highlander.RDuration,dsRatio=.5,dsCount=D.MasterYiPassive.AttackCount,dsDuration=D.MasterYiPassive.StackDuration,
      qBounce=550,qImpact=.26,wDelay=D.Meditate.castFrame/30,wChannel=D.Meditate.HealDuration,wInitialSeconds=D.Meditate.InitialExtraDRDuration,wInitial={.7,.7,.7,.7,.7},wReduction=D.Meditate.DamageReduction,
      wSource='MasterYi spells.json Meditate castFrame 3.25, DamageReduction+InitialExtraDR (.5 s), HealDuration 4; wiki Master_Yi V26.19 read 2026-10-10'},
    classic={id='classic',wReset=true,q='Jade_MasterYiAlphaStrike',w='Jade_MasterYiMeditate',e='Jade_MasterYiWujuStyle',r='Jade_MasterYiHighlander',qType='magical',qBase=D.Jade_MasterYiAlphaStrike.BaseDamage,
        -- research/family-assets/Jade_MasterYi/spells.json Jade_MasterYiAlphaStrike TotalMonsterDamage (rank 1-5)
        -- with MonsterDamageProcChance .5: a random proc, so farming never counts it as certain.
        qMonster=D.Jade_MasterYiAlphaStrike.TotalMonsterDamage,qAP=D.Jade_MasterYiAlphaStrike.APRatio,eActive='Jade_MasterYiWujuStyleSuperCharged',eDuration=D.Jade_MasterYiWujuStyle.Duration,ePassive=D.Jade_MasterYiWujuStyle.PassiveAD,rDuration=D.Jade_MasterYiHighlander.RDuration,
        qBounce=550,qImpact=.26,wDelay=D.Jade_MasterYiMeditate.castFrame/30,wChannel=D.Jade_MasterYiMeditate.Duration,wResist=D.Jade_MasterYiMeditate.DefenseStat,
        wSource='Jade_MasterYi spells.json Jade_MasterYiMeditate castFrame 3.25, DefenseStat 100-300, Duration 5; wiki League_Classic/Master_Yi read 2026-10-10'},
}

end
factories['missfortune']=function()
-- Miss Fortune ranking data (2026-10-10). The shared rows (Q/R damage, channel, waves, buff names) stay in
-- CombatProfiles/abilities.lua M.controllers.MissFortune; this file holds the numbers added for the ranking gaps.
-- Sources, read 2026-10-10:
--   Normal wiki https://wiki.leagueoflegends.com/en-us/Miss_Fortune (V26.19 infobox)
--   Normal assets research/family-assets/MissFortune/spells.json; Classic research/family-assets/Jade_MissFortune/spells.json
-- Normal Q: cast range 550 + 100% bonus attack range (wiki; asset castRange 550) -> measured live as the attack reach
--   (myHero.range plus both bounding radii). Bounce crit when Q kills the primary: 150% (+15% with Infinity Edge, item
--   3031), asset BounceCriticalMod .5. Bounce priority: 500 within 20 deg, 500 within 40, 500 within 110, 150 within 160
--   (full angles, wiki); the order inside one tier is not published.
-- Love Tap: .5 total AD, +.1 at levels 4/7/9/11/13/20/25/30 (asset MissFortunePassive calculation), halved on minions
--   (wiki; Riot 11.20). Monsters and structures are not credited (no reviewed classification).
-- Normal E: 11.25/15/18.75/22.5/26.25 (+15% AP) magic per tick, every .25 s for 2 s (current BaseDamagePerSecond/4,
--   APRatioPerSecond .6/4, TicksPerSecond 4, BaseDuration 2), slow 40% (+6% per 100 AP), cast delay .25.
-- Classic E: asset BaseDamage 95/155/215/275/335 (+80% AP) read as the TOTAL over 2 s in 8 ticks (the smaller
--   reading; the field could be per second), MoveSpeedMod -.20/-.28/-.36/-.44/-.52, Duration 2.
-- Normal W: casting grants full Strut at once, +60/70/80/90/100 flat movement speed (wiki; asset PassiveMaxMS), kept until
--   she takes non-periodic damage. wHasteSeconds 2 is a conservative planning bound for Evade (the bonus can last
--   longer). Cast delay: asset castFrame 8 (30 fps, .267 s) as the upper bound. Classic W has no movement speed
--   (asset Jade_MissFortuneViciousStrikes: ASMod, Grievous; the Classic Strut is the uncastable passive).
-- Normal R: 30 deg cone, 1450 effect radius (wiki; asset geometry 34 deg, the narrower is used for occupancy), first wave
--   .066 s after the channel starts, waves .2036/.1781/.1583 s apart (wiki). Classic: no published cone or wave timing.
local D=(function()
return {
 MissFortuneScattershot={
  BaseSlowAmount=.4,CastDelay=.25,
 },
 MissFortuneViciousStrikes={
  PassiveMaxMS={60,70,80,90,100},castFrame=8,
 },
 MissFortuneBullets={
  castRange=1450,
 },
 Jade_MissFortuneRicochetShot={
  castRangeDisplayOverride=650,
 },
 Jade_MissFortuneScattershot={
  APRatio=.8,BaseDamage={95,155,215,275,335},mCastTime=.25,
 },
}
end)()
return {
 normal={id='normal',qReach='attack',qCrit=1.5,qCritIE=.15,ieItem=3031,
  loveTap={base=.5,step=.1,levels={4,7,9,11,13,20,25,30},minion=.5},
  tiers={{range=500,angle=20},{range=500,angle=40},{range=500,angle=110},{range=150,angle=160}},
  eTick={11.25,15,18.75,22.5,26.25},eTickAP=.15,eTicks=8,eInterval=.25,eSlow=D.MissFortuneScattershot.BaseSlowAmount,eSlowAP=.0006,eDelay=D.MissFortuneScattershot.CastDelay,
  wHaste=D.MissFortuneViciousStrikes.PassiveMaxMS,wHasteSeconds=2,wDelay=D.MissFortuneViciousStrikes.castFrame/30,
  wSource='MissFortune spells.json MissFortuneViciousStrikes PassiveMaxMS 60-100, castFrame 8; wiki Miss_Fortune Strut read 2026-10-10 (full Strut on cast); 2 s planning bound',
  rAngle=30,rRange=D.MissFortuneBullets.castRange,rFirstWave=.066,rInterval={.2036,.1781,.1583}},
 classic={id='classic',qReach=D.Jade_MissFortuneRicochetShot.castRangeDisplayOverride,
  eTotal=D.Jade_MissFortuneScattershot.BaseDamage,eAP=D.Jade_MissFortuneScattershot.APRatio,eTicks=8,eInterval=.25,eSlowRank={.2,.28,.36,.44,.52},eDelay=D.Jade_MissFortuneScattershot.mCastTime,
  rAngle=30,rRange=1400},
}

end
factories['monkeyking']=function()
-- Shared MonkeyKing mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 MonkeyKingNimbus={
  BaseDamage={80,120,160,200,240},DashSpeed=1050,EndPointOffsetDistance=75,ExtraTargetRange=700,castRange=650,
 },
 MonkeyKingDecoy={
  CloneDamageMod={.4,.45,.5,.55,.6},CloneDuration=4,DashSpeed=900,MinRange=100,RangeClamp=300,StealthDuration=1,
 },
 MonkeyKingPassive={
  MaxStacks=5,
 },
 MonkeyKingDoubleAttack={
  ADRatio=.5,AttackRangeBonus={135,145,155,165,175},BaseDamage={20,45,70,95,120},
 },
}
end)()
return {
 MonkeyKing={id='normal',q='MonkeyKingDoubleAttack',w='MonkeyKingDecoy',e='MonkeyKingNimbus',r='MonkeyKingSpinToWin',leave='MonkeyKingSpinToWinLeave',
  qAttack='MonkeyKingQAttack',qBase=D.MonkeyKingDoubleAttack.BaseDamage,qBonusAD=D.MonkeyKingDoubleAttack.ADRatio,qTotalAD=1,qBonusRange=D.MonkeyKingDoubleAttack.AttackRangeBonus,
  eBase=D.MonkeyKingNimbus.BaseDamage,eAP=1,eAD=0,eKind='magical',eExtra=D.MonkeyKingNimbus.ExtraTargetRange,eBuff='MonkeyKingNimbusAS',
  stealth='MonkeyKingDecoyStealth',cloneDuration=D.MonkeyKingDecoy.CloneDuration,stealthDuration=D.MonkeyKingDecoy.StealthDuration,wRange=D.MonkeyKingDecoy.RangeClamp,wMin=D.MonkeyKingDecoy.MinRange,wSpeed=D.MonkeyKingDecoy.DashSpeed,wDelay=.3,
  cloneRatio=D.MonkeyKingDecoy.CloneDamageMod,rRecast='MonkeyKingSpinRecast',spinDuration=2,recastWindow=8,rLockout=1,rRadius=315,
  passive='MonkeyKingPassiveStack',maxStacks=D.MonkeyKingPassive.MaxStacks,
  -- The wiki gives no cast time; wDelay=.3 is the kept controller timing. Evade is given both and must be safe under either.
  -- Nimbus Strike: asset MonkeyKingNimbus DashSpeed 1050, EndPointOffsetDistance 75, castRange 650 (read 2026-10-10,
  -- installed asset, not live-verified). Offered to Evade as a unit dash next to W (SDK.ChampionMobility alternatives);
  -- development own_dash records confirm the figures in play.
  eDash={speed=D.MonkeyKingNimbus.DashSpeed,offset=D.MonkeyKingNimbus.EndPointOffsetDistance,range=D.MonkeyKingNimbus.castRange,source='research/family-assets/MonkeyKing/spells.json MonkeyKingNimbus DashSpeed 1050, EndPointOffsetDistance 75, castRange 650 (2026-10-10)'},
  -- Cyclone (asset MonkeyKingSpinToWin, wiki Wukong read 2026-10-10): 4/6/8% max health (+137.5% AD) physical per second,
  -- ticks every .25 s for 2 s, knock-up .6 s, radius 315.
  rPctPerSec={.04,.06,.08},rADPerSec=1.375,rTick=.25,rTicks=8,rKnockupSeconds=.6,
  wDelays={0,.3},wSource='https://wiki.leagueoflegends.com/en-us/Wukong Warrior Trickster: dash 100-300 at speed 900, no cast time, invisible 1 s, clone 4 s (read 2026-10-08); .3 is the kept controller delay'},
 Jade_Wukong={id='classic',q='Jade_WukongQ',w='Jade_WukongW',e='Jade_WukongE',r='Jade_WukongR',leave='Jade_WukongR_Leave',
  qAttack='Jade_WukongQAttack',qBase={30,60,90,120,150},qBonusAD=0,qTotalAD=1.1,qBonusRange={125,125,125,125,125},
  eBase={60,105,150,195,240},eAP=0,eAD=.8,eKind='physical',eExtra=320,eBuff='Jade_WukongE_Buff',
  stealth='Jade_WukongW_Stealth',cloneDuration=1.5,stealthDuration=1.5,cloneBuff='Jade_WukongW_Clone',wRange=0,
  spinDuration=4,rRadius=315,knockup='Jade_WukongR_Knockup',passive='Jade_WukongPassive',
  -- Cyclone (asset Jade_WukongR): BaseDamagePerSecond 20/110/200 (+120% AD) per second, ticks every .5 s for 4 s, knock-up .6 s.
  -- The asset's BasePercentMaxHPDmgPerSec row has no established use in this kit and is left out until measured.
  rBasePerSec={20,110,200},rADPerSec=1.2,rTick=.5,rTicks=8,rKnockupSeconds=.6,
  eSpeed=1050,eSource='research/family-assets/Jade_Wukong/spells.json:430,456,517 (Jade_WukongE DashSpeed 1050, EndPointOffsetDistance 75, castRange 650; no cast-time field; 2026-10-08)'},
}

end
factories['morgana']=function()
-- Morgana mechanics, Normal and Classic. Units: world units, seconds, raw damage.
-- Sources, read 2026-10-08:
--   installed assets research/family-assets/{Morgana,Jade_Morgana}/spells.json (DataValues, castRange, castRadius, missileSpeed)
--   League wiki https://wiki.leagueoflegends.com/en-us/Morgana (V25.21) and .../League_Classic/Morgana
-- Asset and wiki agree for each profile on Q (80-300 +90% AP, range 1300, width 140, speed 1200, cast 0.25), the W
-- range 900 and radius 280, the E amounts and 5 s duration, and R (radius 625, 3 s tether, cast 0.35, an enemy
-- champion within 575 required). Per profile:
--   Normal   W ticks every 0.5 s for 9-35 (+10% AP), doubled by missing health: `w` holds the per-second minimum.
--            E range 800, 100-320 (+70% AP). R 200/275/350 (+80% AP) per hit, stun 1.5/1.75/2.
--   Classic  W 25-85 (+20% AP) per second. E 100-300 (+70% AP); range: asset castRange 750, wiki 800, the installed
--            asset decides. R 175/250/325 (+70% AP) per hit, stun 1.5.
-- `q.reach` is not a mechanic: it is the distance beyond which a binding is walked out of (both reference scripts
-- cap their casts there). Nothing here is live-verified.
-- Added 2026-10-10 (same assets, DataValues; wiki Morgana infobox V25.21, W V25.17, R V25.09):
--   q.root        RootDuration 2/2.25/2.5/2.75/3 s (both profiles)
--   w.tick        Normal TickRate .5; w.missingAmp MissingHealthAmpPercent 1 (0-100% more by missing health);
--                 w.monster MonsterMod 170%; w.refund CDRefundPercent .05. Classic: no tick rate, no amplification,
--                 w.mrShred MRShred 4-8 by rank.
--   r.slow        SlowPercent 20 (Classic -0.2); r.haste HastePercent 20/40/60 (Normal only).
--   ccDashes      enemy dashes that apply crowd control on arrival (native cast names, lower case): spell names in
--                 research/family-assets/<Champion>/spells.json. A name the host does not report never matches.
-- W damage per counted second, amplified by the target's missing health (Normal) and against monsters.
-- options.seconds (the time the target is expected inside the soil) multiplies the per-second figure.
local D=(function()
return {
 MorganaQ={
  Damage={80,135,190,245,300},RootDuration={2,2.25,2.5,2.75,3},castRange=1300,mCastTime=.25,mMissileWidth=70,mSpeed=1200,
 },
 MorganaR={
  ChainDuration=3,Damage={200,275,350},HastePercent={20,40,60},SlowPercent=20,StunDuration={1.5,1.75,2},castRange=625,
 },
 MorganaW={
  BaseAPRatio=.2,BaseDamage={18,31,44,57,70},CDRefundPercent=.05,MissingHealthAmpPercent=1,MonsterMod=170,TickRate=.5,WDuration=5,castRadius=280,castRange=900,mCastTime=.25,
 },
 MorganaE={
  ShieldDuration=5,ShieldStrength={100,155,210,265,320},castRange=800,
 },
 Jade_MorganaR={
  ChainDuration=3,Damage={175,250,325},StunDuration=1.5,castRange=625,
 },
 Jade_MorganaQ={
  Damage={80,135,190,245,300},RootDuration={2,2.25,2.5,2.75,3},castRange=1300,castRangeDisplayOverride=1175,mCastTime=.25,mMissileWidth=70,mSpeed=1200,
 },
 Jade_MorganaE={
  ShieldDuration=5,ShieldStrength={100,150,200,250,300},castRange=750,
 },
 Jade_MorganaW={
  BaseAPRatio=.2,BaseDamage={25,40,55,70,85},Duration=5,castRadius=280,castRange=900,mCastTime=.25,
 },
}
end)()
local function soilDamage(p,raw,s,slot,rank,stats,target,options,finite)
 if slot~=1 then return raw,s.type end
 local scale=1
 if s.missingAmp and target and finite(target.health)and finite(target.maxHealth)and target.maxHealth>0 then
  scale=scale+s.missingAmp*math.max(0,math.min(1,1-target.health/target.maxHealth))
 end
 if s.monster and target and target.team==300 then scale=scale*s.monster end
 local seconds=options and options.seconds
 if finite(seconds)and seconds>0 then raw=raw*seconds end
 return raw*scale,s.type
end
local profiles={}
profiles['Morgana']=profiles['Morgana']or {}
profiles['Morgana'].combat={id='normal',champion='Morgana',names={{'MorganaQ'},{'MorganaW'},{'MorganaE'},{'MorganaR'}},rawModifier=soilDamage,
  q={range=D.MorganaQ.castRange,reach=1175,radius=D.MorganaQ.mMissileWidth,delay=D.MorganaQ.mCastTime,speed=D.MorganaQ.mSpeed,collision=true,type='magical',base=D.MorganaQ.Damage,ap=.9,root=D.MorganaQ.RootDuration},
  w={range=D.MorganaW.castRange,radius=D.MorganaW.castRadius,circle=true,delay=D.MorganaW.mCastTime,speed=math.huge,type='magical',base=D.MorganaW.BaseDamage,ap=D.MorganaW.BaseAPRatio,duration=D.MorganaW.WDuration,tick=D.MorganaW.TickRate,missingAmp=D.MorganaW.MissingHealthAmpPercent,monster=D.MorganaW.MonsterMod/100,refund=D.MorganaW.CDRefundPercent},
  e={range=D.MorganaE.castRange,type='shield',base=D.MorganaE.ShieldStrength,ap=.7,duration=D.MorganaE.ShieldDuration},
  r={range=D.MorganaR.castRange,cast=575,delay=.35,type='magical',base=D.MorganaR.Damage,ap=.8,tether=D.MorganaR.ChainDuration,stun=D.MorganaR.StunDuration,slow=D.MorganaR.SlowPercent/100,haste={D.MorganaR.HastePercent[1]/100,D.MorganaR.HastePercent[2]/100,D.MorganaR.HastePercent[3]/100}},
  ccDashes={sejuaniq=true,gragase=true,viq=true,ufslash=true,leonazenithblade=true,headbutt=true,poppye=true,rakanw=true,
   ornne=true,galioe=true,shene=true,hecarimult=true,zace=true,camillee=true,rellw_dismount=true}}
profiles['Jade_Morgana']=profiles['Jade_Morgana']or {}
profiles['Jade_Morgana'].combat={id='classic',champion='Morgana',names={{'Jade_MorganaQ'},{'Jade_MorganaW'},{'Jade_MorganaE'},{'Jade_MorganaR'}},rawModifier=soilDamage,
  q={range=D.Jade_MorganaQ.castRange,reach=D.Jade_MorganaQ.castRangeDisplayOverride,radius=D.Jade_MorganaQ.mMissileWidth,delay=D.Jade_MorganaQ.mCastTime,speed=D.Jade_MorganaQ.mSpeed,collision=true,type='magical',base=D.Jade_MorganaQ.Damage,ap=.9,root=D.Jade_MorganaQ.RootDuration},
  w={range=D.Jade_MorganaW.castRange,radius=D.Jade_MorganaW.castRadius,circle=true,delay=D.Jade_MorganaW.mCastTime,speed=math.huge,type='magical',base=D.Jade_MorganaW.BaseDamage,ap=D.Jade_MorganaW.BaseAPRatio,duration=D.Jade_MorganaW.Duration,mrShred={4,5,6,7,8}},
  e={range=D.Jade_MorganaE.castRange,type='shield',base=D.Jade_MorganaE.ShieldStrength,ap=.7,duration=D.Jade_MorganaE.ShieldDuration},
  r={range=D.Jade_MorganaR.castRange,cast=575,delay=.35,type='magical',base=D.Jade_MorganaR.Damage,ap=.7,tether=D.Jade_MorganaR.ChainDuration,stun=D.Jade_MorganaR.StunDuration,slow=.2},
  ccDashes={jade_alistarw=true,jade_poppye=true,jade_shene=true,jade_malphiteufslash=true,jade_leonazenithblade=true,jade_gragase=true,
   jade_rammusq=true,jade_jarvanivdragonstrike=true}}
return profiles

end
factories['nami']=function()
-- Shared Nami mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 NamiW={
  BaseHeal={55,80,105,130,155},HealAPRatio=.4,mCastTime=.25,
 },
 NamiQ={
  BaseDamage={90,145,200,255,310},
 },
 NamiE={
  BaseDamage={20,35,50,65,80},
 },
 Jade_NamiQ={
  APRatio=.65,BaseDamage={75,130,185,240,295},
 },
 Jade_NamiE={
  BaseDamage={25,40,55,70,85},
 },
 Jade_NamiW={
  BaseHeal={65,95,125,155,185},HealAPRatio=.3,
 },
}
end)()
return {
 Nami={id='normal',q='NamiQ',w='NamiW',e='NamiE',r='NamiR',eBuff='NamiE',spellE=true,
  qBase=D.NamiQ.BaseDamage,qAP=.5,wDamage={60,95,130,165,200},wHeal=D.NamiW.BaseHeal,healAP=D.NamiW.HealAPRatio,
  eBase=D.NamiE.BaseDamage,bounce=-.20,bounceAP=.0015,healBounce=nil,rAP=.6,
  -- Finisher timing (wiki https://wiki.leagueoflegends.com/en-us/Nami read 2026-10-10): Q lands .99 s after the cast
  -- starts, W cast .25 s and bolt speed 2500, R cast .5 s and wave speed 850.
  qImpact=.99,wCast=D.NamiW.mCastTime,wSpeed=2500,rSpeed=850},
 Jade_Nami={id='classic',q='Jade_NamiQ',w='Jade_NamiW',e='Jade_NamiE',r='Jade_NamiR',eBuff='Jade_NamiE',spellE=false,
  qBase=D.Jade_NamiQ.BaseDamage,qAP=D.Jade_NamiQ.APRatio,wDamage={70,110,150,190,230},wHeal=D.Jade_NamiW.BaseHeal,healAP=D.Jade_NamiW.HealAPRatio,
  eBase=D.Jade_NamiE.BaseDamage,bounce=-.30,bounceAP=0,healBounce=-.15,
  -- rAP: https://wiki.leagueoflegends.com/en-us/League_Classic/Nami Tidal Wave 150/250/350 (+70% AP), read 2026-10-08 (was the Normal .6).
  -- Same page: Q radius 200 and R range 2750 / width 500; the controller keeps its narrower 155 / 2200 / 170 geometry (the safe side).
  rAP=.7,
  -- Q timing from the Classic wiki page (read 2026-10-10: same .99 s landing). W bolt speed has no Classic source:
  -- 1500 (the slower wiki bounce speed) is a conservative bound for the finisher's impact time only.
  qImpact=.99,wCast=.25,wSpeed=1500,wSpeedBound=true,rSpeed=850},
}

end
factories['nasus']=function()
-- Shared Nasus mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 NasusQ={
  BonusDamage={30,50,70,90,110},BonusRange=50,
 },
 NasusE={
  DamagePerTick={10,16,22,28,34},Duration=5,InitialHitDamage={50,80,110,140,170},
 },
 NasusR={
  Duration=15,
 },
 NasusW={
  castRange=700,
 },
 Jade_NasusW={
  castRange=700,
 },
 Jade_NasusQ={
  BonusDamage={30,50,70,90,110},
 },
 Jade_NasusR={
  Duration=15,
 },
 Jade_NasusE={
  InitialDamages={55,95,135,175,215},TickDamage={11,19,27,35,43},TotalArmorShred={20,25,30,35,40},
 },
}
end)()
return {
 Nasus={id='normal',q={'NasusQ'},qBuff='NasusQ',stacks='NasusQStacks',qAttack='NasusQAttack',
  w='NasusW',e='NasusE',r='NasusR',qBase=D.NasusQ.BonusDamage,eBase=D.NasusE.InitialHitDamage,
   qRangeBonus=D.NasusQ.BonusRange,stackSmall=4,stackLarge=10,eDelay=.25,eAP=.6,eArmorKind='percent',eArmor={30,35,40,45,50},
   -- Q 30..110 and E 50..170 (+60% AP) confirmed; area and burn from the same page.
   eRadius=400,eTick=D.NasusE.DamagePerTick,eTickAP=.12,eDuration=D.NasusE.Duration,source='https://wiki.leagueoflegends.com/en-us/Nasus (read 2026-10-08)',
   -- E initial hit lands 0.264 s after the cast; R bonus health, cast and duration; W range (wiki V26.19, read 2026-10-10).
   eBurstDelay=.264,wRange=D.NasusW.castRange,rHealth={300,450,600},rCast=.2,rDuration=D.NasusR.Duration,
   -- Wards give Q stacks. Damage of one melee hit on a ward is not measured: only a ward at 1 health counts as a sure kill.
   wardKillHealth=1,rSource='https://wiki.leagueoflegends.com/en-us/Nasus (V26.19, read 2026-10-10): R +300/450/600 health, cast 0.2 s, 15 s'},
 Jade_Nasus={id='classic',q={'Jade_NasusQ','Jade_NasusSiphoningStrike'},qBuff='Jade_NasusQ',
  stacks='Jade_NasusQStacks',qAttack='Jade_NasusSiphoningStrikeAttack',
  w='Jade_NasusW',e='Jade_NasusE',r='Jade_NasusR',qBase=D.Jade_NasusQ.BonusDamage,eBase=D.Jade_NasusE.InitialDamages,
   qRangeBonus=0,stackSmall=3,stackLarge=6,eDelay=.325,eAP=.6,eArmorKind='flat',eArmor=D.Jade_NasusE.TotalArmorShred,
   eRadius=400,eTick=D.Jade_NasusE.TickDamage,eTickAP=.12,eDuration=5,source='https://wiki.leagueoflegends.com/en-us/League_Classic/Nasus (read 2026-10-08)',
   -- League_Classic/Nasus read 2026-10-10: E initial damage 0.264 s after the cast; R cast 0.2 s, 15 s, +300/450/600
   -- health kept after the duration (offered for the 15 s only); W range 700.
   eBurstDelay=.264,wRange=D.Jade_NasusW.castRange,rHealth={300,450,600},rCast=.2,rDuration=D.Jade_NasusR.Duration,
   wardKillHealth=1,rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Nasus (read 2026-10-10): R +300/450/600 health, cast 0.2 s, 15 s'},
}

end
factories['nautilus']=function()
-- Shared Nautilus mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 NautilusSplashZone={
  DamageBase={55,90,125,160,195},castRangeDisplayOverride=600,
 },
 NautilusAnchorDragMissile={
  mCastTime=.25,mMissileWidth=90,mSpeed=2000,
 },
 NautilusAnchorDrag={
  BaseDamage={85,125,165,205,245},
 },
 NautilusGrandLine={
  PrimaryDamage={150,275,400},mCastTime=.46,
 },
 Jade_NautilusQ={
  BaseDamage={60,105,150,195,240},
 },
 Jade_NautilusQ_Missile={
  mCastTime=.25,mMissileWidth=90,mSpeed=2000,
 },
 Jade_NautilusR={
  PrimaryDamage={200,325,450},mCastTime=.46,
 },
 Jade_NautilusE={
  DamageBase={60,100,140,180,220},castRadius=400,castRangeDisplayOverride=550,
 },
}
end)()
return {
 Nautilus={id='normal',q='NautilusAnchorDrag',w='NautilusPiercingGaze',e='NautilusSplashZone',r='NautilusGrandLine',
  rCast='NautilusGrandLineStart',shield='NautilusPiercingGazeShield',passive='NautilusPassiveCheck',root='NautilusPassiveRoot',
  qRoot='NautilusAnchorDragRoot',passiveCD=6,qBase=D.NautilusAnchorDrag.BaseDamage,qAP=.9,eBase=D.NautilusSplashZone.DamageBase,eRange=D.NautilusSplashZone.castRangeDisplayOverride,eArea=600,
   rBase=D.NautilusGrandLine.PrimaryDamage,
   -- Wiki Nautilus read 2026-10-10: Q reach 1122 (asset display range 1150), radius 90, speed 2000, cast .25; R cast .46,
   -- homing charge 275 units/s accelerating by 466.67 units/s per second, eruption radius 225 (knock-back band 300);
   -- Q is a 1 s stun. qControl lists the own Q-control buff names E and R wait for (the stun's native name is
   -- unconfirmed: dev trace nautilus_hook_buffs records the hooked target's buffs).
   qRange=1122,qRadius=D.NautilusAnchorDragMissile.mMissileWidth,qSpeed=D.NautilusAnchorDragMissile.mSpeed,qCast=D.NautilusAnchorDragMissile.mCastTime,rCast=D.NautilusGrandLine.mCastTime,rSpeed=275,rAccel=466.67,rRadius=225,
   qControl={'NautilusAnchorDragRoot'},
   geometrySource='https://wiki.leagueoflegends.com/en-us/Nautilus (read 2026-10-10)'},
 Jade_Nautilus={id='classic',q='Jade_NautilusQ',w='Jade_NautilusW',e='Jade_NautilusE',r='Jade_NautilusR',
  rCast='Jade_NautilusR_Start',shield='Jade_NautilusW_Shield',passive='Jade_NautilusPassive_Check',root='Jade_NautilusPassive_Root',
  qRoot='Jade_NautilusQ_Root',passiveCD=9.75,qBase=D.Jade_NautilusQ.BaseDamage,qAP=.75,eBase=D.Jade_NautilusE.DamageBase,eRange=D.Jade_NautilusE.castRadius,eArea=D.Jade_NautilusE.castRangeDisplayOverride,
   rBase=D.Jade_NautilusR.PrimaryDamage,
   -- League_Classic/Nautilus read 2026-10-10: same Q (1122, width 180, speed 2000) and R geometry/charge as Normal;
   -- R cast .46, speed 275 + 466.67 per second, radius 225/300 (Classic page). Q is a 1 s stun there too.
   qRange=1122,qRadius=D.Jade_NautilusQ_Missile.mMissileWidth,qSpeed=D.Jade_NautilusQ_Missile.mSpeed,qCast=D.Jade_NautilusQ_Missile.mCastTime,rCast=D.Jade_NautilusR.mCastTime,rSpeed=275,rAccel=466.67,rRadius=225,
   qControl={'Jade_NautilusQ_Root'},
   geometrySource='https://wiki.leagueoflegends.com/en-us/League_Classic/Nautilus (read 2026-10-10)'},
}

end
factories['nidalee']=function()
-- Shared Nidalee mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 Takedown={
  TotalADRatio=.75,
 },
 JavelinToss={
  SpearMinimumAPRatio=.5,mMissileWidth=40,
 },
 PrimalSurge={
  BaseHeal={50,75,100,125,150},
 },
 AspectOfTheCougar={
  PounceAPRatio=.3,SwipeADRatio=.7,SwipeAPRatio=.55,TakedownAPRatio=.4,
 },
 Bushwhack={
  DotDuration=4,
 },
 Jade_NidaleeBushwhack={
  DamageDuration=2.5,
 },
 Jade_NidaleePrimalSurge={
  BaseHeal={50,85,120,155,190},castRangeDisplayOverride=575,
 },
 Jade_NidaleeJavelinToss={
  APRatio=.65,mMissileWidth=60,
 },
 Jade_NidaleeAspectOfTheCougar={
  PounceAPRatio=.4,SwipeAPRatio=.6,TakedownADRatio=1,
 },
}
end)()
return {
 Nidalee={id='normal',q='JavelinToss',w='Bushwhack',e='PrimalSurge',r='AspectOfTheCougar',
  cougar={'Takedown','Pounce','Swipe'},ranks=4,healRange=900,heal=D.PrimalSurge.BaseHeal,healAP=.35,
  spear={70,90,110,130,150},spearAP=D.JavelinToss.SpearMinimumAPRatio,spearMultiplier=3.25,spearRadius=D.JavelinToss.mMissileWidth,hunt='nidaleepassivehunted',
  swipe={70,130,190,250},swipeAP=D.AspectOfTheCougar.SwipeAPRatio,swipeBonusAD=D.AspectOfTheCougar.SwipeADRatio,pounce={50,90,130,170},pounceAP=D.AspectOfTheCougar.PounceAPRatio,
  takedown={5,30,55,80},takedownAD=D.Takedown.TotalADRatio,takedownAP=D.AspectOfTheCougar.TakedownAPRatio,trapDuration=D.Bushwhack.DotDuration,
  -- Bushwhack arms 1.5 s after it lands (wiki https://wiki.leagueoflegends.com/en-us/Nidalee read 2026-10-10).
  trapArm=1.5},
 Jade_Nidalee={id='classic',q='Jade_NidaleeJavelinToss',w='Jade_NidaleeBushwhack',e='Jade_NidaleePrimalSurge',r='Jade_NidaleeAspectOfTheCougar',
  cougar={'Jade_NidaleeTakedown','Jade_NidaleePounce','Jade_NidaleeSwipe'},ranks=3,healRange=D.Jade_NidaleePrimalSurge.castRangeDisplayOverride,heal=D.Jade_NidaleePrimalSurge.BaseHeal,healAP=.7,
  spear={55,95,140,185,230},spearAP=D.Jade_NidaleeJavelinToss.APRatio,spearMultiplier=2.5,spearRadius=D.Jade_NidaleeJavelinToss.mMissileWidth,
  swipe={150,225,300},swipeAP=D.Jade_NidaleeAspectOfTheCougar.SwipeAPRatio,pounce={125,175,225},pounceAP=D.Jade_NidaleeAspectOfTheCougar.PounceAPRatio,
  takedown={40,70,100},takedownAD=D.Jade_NidaleeAspectOfTheCougar.TakedownADRatio,takedownAP=0,trapDuration=D.Jade_NidaleeBushwhack.DamageDuration,
  -- No Classic arm time is published: the Normal 1.5 s is used only as a stricter placement bound (a trap thrown
  -- under shorter control was the earlier rule); it is not a Classic mechanic claim.
  trapArm=1.5,trapArmBound=true},
}

end
factories['pantheon']=function()
-- Pantheon numbers the shared row in CombatProfiles/abilities.lua (M.controllers.Pantheon, not edited by the
-- champion work) does not carry. The controller overlays these on a private copy of that row.
local D=(function()
return {
 PantheonQMissile={
  mMissileWidth=55,mSpeed=2700,
 },
 PantheonE={
  RecastLockout=.3,ShieldDuration=1.5,SpearStrikesRadius=525,
 },
}
end)()
return {
 -- https://wiki.leagueoflegends.com/en-us/Pantheon read 2026-10-10: Q cast 0.2 s (the shared geometry row says .25),
 -- hurl +50% AP (execute +100% AP), the thrust has no AP ratio, the 50% hurl reduction applies only beyond the first
 -- unit hit; W +1.5% maximum health per 100 AP; Mortal Will empowered Q bonus 20-265.88 by level (standard growth
 -- curve assumed between the two ends); E channel 1.5 s, 60 degree cone, non-turret damage from the front blocked,
 -- strikes 1/12 of total AD every 0.125 s (100% AD over the channel), recast after 0.3 s or automatically at the end:
 -- slam 0.25 s cast, cone radius 525, 55-255 (+150% bonus AD).
 Pantheon={qCast=.2,qFlightSpeed=D.PantheonQMissile.mSpeed,qFlightRadius=D.PantheonQMissile.mMissileWidth,qHurlAP=.5,qExecuteAP=1,wHPPerAP=.00015,
  mortalWillMin=20,mortalWillMax=265.88,eBlockAngle=60,eBlockDuration=D.PantheonE.ShieldDuration,eStrikeAD=1/12,eStrikeInterval=.125,eStrikesMax=12,
  eSlamRadius=D.PantheonE.SpearStrikesRadius,eSlamCast=.25,eRecastAfter=D.PantheonE.RecastLockout,
  source='https://wiki.leagueoflegends.com/en-us/Pantheon (read 2026-10-10)'},
 -- https://wiki.leagueoflegends.com/en-us/League_Classic/Pantheon read 2026-10-10: Heartseeker Strike channels 0.75 s
 -- with three strikes; the controller keeps its 400 / 32 degree cone until the wiki 600 / 80 is measured.
 Jade_Pantheon={eChannel=.75,eStrikeInterval=.25,
  source='https://wiki.leagueoflegends.com/en-us/League_Classic/Pantheon (read 2026-10-10)'},
}

end
factories['quinn']=function()
-- Shared Quinn Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
-- 2026-10-10 (champion ranking, Quinn-6/7/8/9/12): Q castRange 1050 (Normal asset QuinnQ),
-- Q explosion radius 210 (wiki Quinn and League_Classic/Quinn), Skystrike radius 700 (asset
-- QuinnRFinale / Jade_QuinnRFinale castRadius), R stage names, E dash speeds 2500 then 850 and
-- landing 525 (wiki Quinn), Classic Harrier 25 +10/level, +15/level from level 15 (asset
-- Jade_QuinnPassive; wiki 25-215). Details: CombatProfiles/quinn-provenance.json.
local D=(function()
return {
 QuinnW={
  BuffDuration=2,castRangeDisplayOverride=2100,
 },
 QuinnR={
  ADRatio=.35,BaseDamage={60,90,120},castRangeDisplayOverride=700,
 },
 QuinnPassive={
  ADRatio=.4,
 },
 QuinnE={
  BaseDamage={40,65,90,115,140},castRange=600,
 },
 QuinnQ={
  ADRatio={.8,.85,.9,.95,1},BaseDamage={65,100,135,170,205},castRange=1050,mMissileWidth=60,mSpeed=1550,
 },
 Jade_QuinnQ={
  ADRatio=.65,APRatio=.5,BaseDamage={70,110,150,190,230},castRangeDisplayOverride=1025,mCastTime=.25,mMissileWidth=80,mSpeed=1550,
 },
 Jade_QuinnE={
  ADRatio=.2,BaseDamage={40,70,100,130,160},castRangeDisplayOverride=700,
 },
 Jade_QuinnR={
  BaseDamage={100,150,200},BonusAttackRange=-400,TransformDuration=20,
 },
}
end)()
local profiles={}
profiles['Quinn']=profiles['Quinn']or {}
profiles['Quinn'].combat={id='normal',champion='Quinn',names={{'QuinnQ'},{'QuinnW'},{'QuinnE'},{'QuinnR','QuinnRChannel','QuinnRFinale','QuinnRReturnToQuinn'}},
  q={range=D.QuinnQ.castRange,radius=D.QuinnQ.mMissileWidth,delay=.25,speed=D.QuinnQ.mSpeed,collision=true,type='physical',base=D.QuinnQ.BaseDamage,bonusAD=D.QuinnQ.ADRatio,ap=.5,monster=2,explosion=210},
  w={range=D.QuinnW.castRangeDisplayOverride,duration=D.QuinnW.BuffDuration},e={range=D.QuinnE.castRange,type='physical',base=D.QuinnE.BaseDamage,bonusAD=.2},r={range=D.QuinnR.castRangeDisplayOverride,margin=25,type='physical',base=D.QuinnR.BaseDamage,bonusAD=D.QuinnR.ADRatio},
  flightName='QuinnRFinale',channelName='QuinnRReturnToQuinn',eSpeeds={2500,850},eLanding=525,
  markNames={'QuinnW','QuinnPassive'},travelNames={'QuinnR'},passiveLevel={15,120},passiveAD=D.QuinnPassive.ADRatio,passiveMonster=75,rChannel=2,rArrival=650}
profiles['Jade_Quinn']=profiles['Jade_Quinn']or {}
profiles['Jade_Quinn'].combat={id='classic',champion='Quinn',names={{'Jade_QuinnQ','Jade_QuinnQMelee'},{'Jade_QuinnW'},{'Jade_QuinnE'},{'Jade_QuinnR','Jade_QuinnRChannel','Jade_QuinnRFinale','Jade_QuinnRReturnToJade_Quinn'}},
  q={range=D.Jade_QuinnQ.castRangeDisplayOverride,radius=D.Jade_QuinnQ.mMissileWidth,delay=D.Jade_QuinnQ.mCastTime,speed=D.Jade_QuinnQ.mSpeed,collision=true,type='physical',base=D.Jade_QuinnQ.BaseDamage,bonusAD=D.Jade_QuinnQ.ADRatio,ap=D.Jade_QuinnQ.APRatio,melee=300,explosion=210},
  w={range=1950,duration=2},e={range=D.Jade_QuinnE.castRangeDisplayOverride,type='physical',base=D.Jade_QuinnE.BaseDamage,bonusAD=D.Jade_QuinnE.ADRatio},
  r={range=700,margin=25,type='physical',base=D.Jade_QuinnR.BaseDamage,bonusAD=.5},channelName='Jade_QuinnRReturnToJade_Quinn',eLanding=525,markNames={'Jade_QuinnPassive'},valorNames={'Jade_QuinnR'},valorQ='Jade_QuinnQMelee',valorDuration=D.Jade_QuinnR.TransformDuration,valorAttackRange=D.Jade_QuinnR.BonusAttackRange,
  passiveBase=25,passivePerLevel=10,passiveLateLevel=15,passiveLatePerLevel=15,passiveAD=.5,rChannel=2,rMaximum=2,rMaximumHealth=.25}
local normal,classic=profiles.Quinn.combat,profiles.Jade_Quinn.combat
normal.e.mobility=true;classic.e.mobility=true
local function modifier(p,raw,s,slot,rank,stats,target,options,finite)
 if slot==0 and s.monster and target and target.team==300 then raw=raw*s.monster
 elseif p.id=='classic'and slot==3 then
  if not target or not finite(target.health)or not finite(target.maxHealth)or target.maxHealth<=0 then return 0,'invalid_health'end
  raw=raw*(1+math.min(1,(1-target.health/target.maxHealth)/(1-p.rMaximumHealth)))
 end
 return raw,s.type
end
normal.rawModifier=modifier;classic.rawModifier=modifier
local function passive(p,stats,target)
 local level=stats.level
 local base
 if p.id=='normal'then base=p.passiveLevel[1]+(p.passiveLevel[2]-p.passiveLevel[1])*(level-1)/17
 else
  -- Classic breakpoint calculation: +10 per level up to 14, +15 per level from 15 (25 .. 155 .. 215).
  local late=math.max(0,level-p.passiveLateLevel+1)
  base=p.passiveBase+p.passivePerLevel*(level-1-late)+p.passiveLatePerLevel*late
 end
 return base+p.passiveAD*stats.bonusDamage+(p.id=='normal'and target and target.team==300 and p.passiveMonster or 0),'physical'
end
normal.passive=passive;classic.passive=passive
return profiles

end
factories['rammus']=function()
-- Shared Rammus mechanics data. Values preserved from the maintained controller.
-- 2026-10-10 additions (ranking gaps Rammus-1/10/11): R damage, R prediction delay/speed and W resistances,
-- each with its installed-asset field and the wiki page read that day (rSource/wSource). Normal and Classic
-- are read from their own assets; nothing is borrowed across profiles.
local D=(function()
return {
 DefensiveBallCurl={
  BuffDuration=7,
 },
 PowerBall={
  KnockbackDistance=125,QBaseDamage={80,120,160,200,240},RollDuration=6,
 },
 Tremors2={
  APRatio=.6,BaseCastRange=800,InitialDamage={150,250,350},MinDashSpeed=900,
 },
 PuncturingTaunt={
  APRatio=.7,MonsterDamage={80,100,120,140,160},
 },
 Jade_RammusQ={
  AOEDamage={100,150,200,250,300},Duration=7,
 },
 Jade_RammusW={
  Duration=6,
 },
 Jade_RammusR={
  castRadius=375,
 },
}
end)()
return {
 Rammus={id='normal',q='PowerBall',qCancel='PowerBallCancel',w='DefensiveBallCurl',e='PuncturingTaunt',r='Tremors2',
  qBuff='PowerBall',wBuff='DefensiveBallCurl',eBuff='PuncturingTaunt',qDuration=D.PowerBall.RollDuration,wDuration=D.DefensiveBallCurl.BuffDuration,rKind='landing',rRadius=400,
  qBase=D.PowerBall.QBaseDamage,qAP=1,eMonster=D.PuncturingTaunt.MonsterDamage,eAP=D.PuncturingTaunt.APRatio,
  -- Soaring Slam landing damage and the prediction model. rDelay is the asset cast delay (the wiki says "no cast
  -- time"; the larger value is kept until the rammus_slam_flight trace settles it); rSpeed is the asset
  -- MinDashSpeed lower bound (the dash runs 900-2000). rRange is the base range; 150% of the average movement
  -- speed above 461.5 is not used until rammus_slam_flight records accepted landings beyond 800.
  rBase=D.Tremors2.InitialDamage,rAP=D.Tremors2.APRatio,rDelay=.25,rSpeed=D.Tremors2.MinDashSpeed,rRange=D.Tremors2.BaseCastRange,qKnockback=D.PowerBall.KnockbackDistance,
  rSource='family-assets/Rammus/spells.json Tremors2 InitialDamage/APRatio/MinDashSpeed/BaseCastRange/11704a2b + wiki.leagueoflegends.com/en-us/Rammus (V26.01), read 2026-10-10',
  -- Defensive Ball Curl: flat plus a share of total armor / magic resistance.
  wArmor={25,30,35,40,45},wArmorShare={.3,.35,.4,.45,.5},wMR={20,25,30,35,40},wMRShare={.3,.35,.4,.45,.5},wDelay=.25,
  wSource='Current installed DefensiveBallCurl FlatBonusArmor/BonusArmorPercent/FlatBonusMR/BonusMRPercent; implementation/family/current-patch.json'},
 Jade_Rammus={id='classic',q='Jade_RammusQ',w='Jade_RammusW',e='Jade_RammusE',r='Jade_RammusR',
  wAlias='Jade_Rammus_DefensiveBallCurl',eAlias='Jade_Rammus_PuncturingTaunt',rAlias='Jade_Rammus_Tremors2',
  qBuff='Jade_RammusQ',wBuff='Jade_RammusW',eBuff='Jade_RammusE',qDuration=D.Jade_RammusQ.Duration,wDuration=D.Jade_RammusW.Duration,rKind='tremors',
  -- Installed asset castRadius 375; the Classic wiki page says 385. The smaller asset value is kept (it never
  -- counts an enemy the area misses); the rammus_tremors_hits trace records hit distances to settle it.
  rRadius=D.Jade_RammusR.castRadius,
  qBase=D.Jade_RammusQ.AOEDamage,qAP=1,
  -- Tremors: one tick per second for 8 s. The delay of the first tick is unmeasured (rammus_tremors_tick trace),
  -- so no Classic R finisher is built on it.
  rTick={65,130,195},rAP=.3,
  rSource='family-assets/Jade_Rammus/spells.json Jade_RammusR BaseDamage/Duration/castRadius + wiki League_Classic/Rammus, read 2026-10-10',
  -- Defensive Ball Curl: the same flat value as armor and magic resistance (asset Armour, listed for both).
  wResist={40,60,80,100,120},wDelay=.25,
  wSource='family-assets/Jade_Rammus/spells.json Jade_RammusW Armour/Duration/11704a2b + wiki League_Classic/Rammus, read 2026-10-10'},
}

end
factories['rell']=function()
-- Shared Rell mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 RellW_Dismount={
  CrashDownKnockupDuration=.4,CrashDownStunDuration=.8,FlipStunDuration=.6,castRangeDisplayOverride=450,
 },
 RellW_MountUp={
  CrashDownTooltip={60,90,120,150,180},FlipAttackTooltip={10,25,40,55,70},ShieldBaseTooltip={20,40,60,80,100},
 },
 RellE={
  Duration=3,ExplosionRadius=300,castRange=1200,
 },
 RellQ={
  BaseDamage={60,100,140,180,220},StunDuration=.65,castRangeDisplayOverride=600,
 },
 RellR={
  GravityRadius=375,
 },
}
end)()
return {Rell={id='normal',q='RellQ',w='RellW_Dismount',w2='RellW_MountUp',e='RellE',r='RellR',
 qBase=D.RellQ.BaseDamage,qAP=.6,qRange=D.RellQ.castRangeDisplayOverride,qForward=520,qBehind=220,qStep=100,qRadius=75,qDelay=.4,qStun=D.RellQ.StunDuration,
 -- Crash Down reach, 2026-10-08: https://wiki.leagueoflegends.com/en-us/Rell "Target range 100 - 400", effect radius 180,
 -- cast 0.625, slide 320 over 0.5 s; patch 13.11 notes also give a 400 jump. The installed asset's
 -- castRangeDisplayOverride is 450 (kept as wDisplayRange, the drawn indicator); casts are planned inside 400.
 -- The leap itself has no published speed (the page describes it as happening over the cast time).
 wBase=D.RellW_MountUp.CrashDownTooltip,wAP=.6,w2Base=D.RellW_MountUp.FlipAttackTooltip,w2AP=.4,wRange=400,wMinRange=100,wDisplayRange=D.RellW_Dismount.castRangeDisplayOverride,wSlide=320,wRadius=180,wDelay=.625,
 -- Mount Up empowers the next attack for 3.5 s with 100 bonus range (same page). The two buff names are leads from a
 -- reference script (zgRell), not live verified: a name that never appears simply never triggers its rule.
 wAttackWindow=3.5,wAttackRange=100,wAttackBuff='rellwempoweredattack',wKnockupBuff='rellw_knockup',
 shieldBase=D.RellW_MountUp.ShieldBaseTooltip,shieldHP=.11,wResist=.15,wKnockup=D.RellW_Dismount.CrashDownKnockupDuration,wStun=D.RellW_Dismount.CrashDownStunDuration,w2Stun=D.RellW_Dismount.FlipStunDuration,
 eRange=D.RellE.castRange,ePct={.05,.055,.06,.065,.07},eAP=.0003,eDuration=D.RellE.Duration,eBuffer=2,eRadius=D.RellE.ExplosionRadius,eFast=.3,eSlow=.15,
 -- Full Tilt monster/structure cap by level (Rell-5): installed asset RellE mSpellCalculations 1925773807 =
 -- level curve 150 -> 300 (read 2026-10-10). The wiki (V14.23) lists 150-317.65; the installed asset wins.
 eMonsterCap={150,300},
 -- Mount Up speed burst (S6 haste offer): asset RellW_MountUp HasteTooltip/RellW_Dismount MountUpSpeed .3 with a 2 s
 -- decay (calc 2803503575), wiki en-us/Rell "+30% decaying over 2 s", read 2026-10-10.
 mountHaste=.3,mountHasteDecay=2,
 mountSource='family-assets/Rell/spells.json RellW_Dismount MountUpSpeed + RellW_MountUp calc 2803503575 (2 s) + wiki en-us/Rell, read 2026-10-10',
 rDPS={75,125,175},rAP=.55,rDuration=2,rInitial=425,rRadius=D.RellR.GravityRadius,rHorizon=225,rForce=300,
 passive='rellp_debuff',maxStacks=5,passivePct=.03,passiveLife=5,refreshLife=3.5,
 mounted='rellw_mountedbuff',dismounted='rellw_dismountedbuff',shield='rellw_shield',eEmpower='relle_empowerself',storm='rellr'}}

end
factories['ryze']=function()
-- Ryze mechanics added by the 2026-10-10 ranking work. Damage, ranges and speeds stay in abilities.lua
-- (AbilityProfiles.controllers.Ryze and the geometry rows); this file holds only the numbers those rows lack.
-- Every row names its installed-asset field and the wiki page read that day; Normal and Classic are read from
-- their own assets (research/family-assets/Ryze, Jade_Ryze) and never borrowed. See ryze-provenance.json.
local D=(function()
return {
 RyzeQWrapper={
  MovementSpeedAmount={30,35,40,45,50},MovementSpeedDuration=2,RuneDuration=4,
 },
 RyzeR={
  MinimumCastRange=1000,castRange=3000,
 },
 RyzeE={
  BounceRadius=350,BounceRadiusLargeUnit=400,BounceRadiusQLargeUnit=500,BounceRadiusQSmallUnit=350,
 },
 Jade_RyzeR={
  Duration={5,6,7},MovementSpeed={60,70,80},
 },
 Jade_RyzeE={
  MaximumHits=5,ResistShred={12,15,18,21,24},
 },
 Jade_RyzeEMissile={
  BounceRadius=350,BounceRadiusLargeUnit=400,
 },
}
end)()
return {
 Ryze={id='normal',
  -- Bonus mana (Q/W/E scale with it, 2%/3%/2%): base mana 300 + 70 per level on the standard growth curve.
  manaBase=300,manaGrowth=70,manaSource='wiki Template:Data_Ryze mp_base 300 / mp_lvl 70, read 2026-10-10',
  -- Two Runes consumed by Q use the current per-rank movement speed for 2 s; Runes last 4 s.
  runeHaste={D.RyzeQWrapper.MovementSpeedAmount[1]/100,D.RyzeQWrapper.MovementSpeedAmount[2]/100,D.RyzeQWrapper.MovementSpeedAmount[3]/100,D.RyzeQWrapper.MovementSpeedAmount[4]/100,D.RyzeQWrapper.MovementSpeedAmount[5]/100},fluxBonus={.10,.40,.70,1},runeHasteDuration=D.RyzeQWrapper.MovementSpeedDuration,runeLife=D.RyzeQWrapper.RuneDuration,
  runeSource='Current installed RyzeQWrapper MovementSpeedAmount/MovementSpeedDuration/RuneDuration; implementation/family/current-patch.json',
  -- E spread: 350 to small units, 400 to large ones (asset BounceRadius/BounceRadiusLargeUnit). Counting uses the
  -- smaller, collateral checks the larger. Q spread off a marked unit: 350 small / 500 large (BounceRadiusQ*).
  eBounceMin=D.RyzeE.BounceRadius,eBounceMax=D.RyzeE.BounceRadiusLargeUnit,qBounceSmall=D.RyzeE.BounceRadiusQSmallUnit,qBounceLarge=D.RyzeE.BounceRadiusQLargeUnit,
  bounceSource='family-assets/Ryze/spells.json RyzeE BounceRadius/BounceRadiusLargeUnit/BounceRadiusQSmallUnit/BounceRadiusQLargeUnit, read 2026-10-10',
  -- Realm Warp: 1000 minimum, 3000 maximum.
  rMin=D.RyzeR.MinimumCastRange,rMax=D.RyzeR.castRange,rRangeSource='family-assets/Ryze/spells.json RyzeR MinimumCastRange/castRange + wiki en-us/Ryze, read 2026-10-10'},
 Jade_Ryze={id='classic',
  -- E bounces: 350 from the missile (small units), 400 on the spell and for large units; at most 5 hits.
  eBounceMin=D.Jade_RyzeEMissile.BounceRadius,eBounceMax=D.Jade_RyzeEMissile.BounceRadiusLargeUnit,eMaxHits=D.Jade_RyzeE.MaximumHits,
  bounceSource='family-assets/Jade_Ryze/spells.json Jade_RyzeEMissile BounceRadius 350/BounceRadiusLargeUnit 400, Jade_RyzeE BounceRadius 400/MaximumHits 5, read 2026-10-10',
  -- E magic resistance reduction while marked (applied to the follow-up only once our mark is seen).
  eShred=D.Jade_RyzeE.ResistShred,eShredSource='family-assets/Jade_Ryze/spells.json Jade_RyzeE ResistShred + wiki League_Classic/Ryze, read 2026-10-10',
  -- Desperate Power: flat movement speed and duration by rank, no cast time.
  rHaste=D.Jade_RyzeR.MovementSpeed,rDuration=D.Jade_RyzeR.Duration,rSource='family-assets/Jade_Ryze/spells.json Jade_RyzeR MovementSpeed/Duration + wiki League_Classic/Ryze, read 2026-10-10'},
}

end
factories['seraphine']=function()
-- Shared Normal Seraphine data; no Classic mechanics are inferred.
local D=(function()
return {
 SeraphineW={
  ShieldAPRatio=.2,ShieldDuration=2.5,ShieldStrength={60,80,100,120,140},WMissingHPBase={8,10,12,14,16},
 },
 SeraphineE={
  APRatio=.5,BaseDamage={70,100,130,160,190},
 },
 SeraphineQ={
  BaseDamage={60,85,110,135,160},
 },
 SeraphineR={
  R1BaseDamage={150,200,250},
 },
}
end)()
return {
 Seraphine={id='normal',q='SeraphineQ',w='SeraphineW',e='SeraphineE',r='SeraphineR',
  qBase=D.SeraphineQ.BaseDamage,qAP=.4,eBase=D.SeraphineE.BaseDamage,eAP=D.SeraphineE.APRatio,eMinion=.7,
  -- High Note against champions and monsters: "the damage is increased by 0% - 75% (based on target's missing health)",
  -- maximum 105..280 (+70% AP) = base x1.75 (https://wiki.leagueoflegends.com/en-us/Template:Data_Seraphine/High_Note,
  -- read 2026-10-08). The page does not say at which missing health the maximum is reached. qMissingMax is therefore
  -- applied as the most conservative linear reading, +75% only at 100% missing health (bonus = .75 x missing share);
  -- a curve that caps earlier deals more. Used only as a lower bound by the champion finisher.
  qMissingMax=.75,
  -- Stage Presence (Echo): the next basic ability "casts an additional time" 0.033 s after the first
  -- (https://wiki.leagueoflegends.com/en-us/Seraphine, read 2026-10-10). The repeat is assumed to deal the
  -- original cast's damage; the dev trace seraphine_damage_sample (two health drops per echoed Q/E) settles it.
  echoDelay=.033,
  echoSource='https://wiki.leagueoflegends.com/en-us/Seraphine (Stage Presence: additional cast after 0.033 s), read 2026-10-10',
  -- Surround Sound: shield 60/80/100/120/140 (+20% AP) for 2.5 s, cast time 0.25, radius 800
  -- (https://wiki.leagueoflegends.com/en-us/Template:Data_Seraphine/Surround_Sound, read 2026-10-08).
  rBase=D.SeraphineR.R1BaseDamage,rAP=.4,shield=D.SeraphineW.ShieldStrength,shieldAP=D.SeraphineW.ShieldAPRatio,shieldDuration=D.SeraphineW.ShieldDuration,heal=D.SeraphineW.WMissingHPBase,
  shieldSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Seraphine/Surround_Sound (shield 60/80/100/120/140 +20% AP, 2.5 s, cast 0.25), read 2026-10-08; base ranks also in research/family-assets/Seraphine/spells.json SeraphineW ShieldStrength'}
}

end
factories['shen']=function()
-- Shared Shen mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 ShenQ={
  MinionDamageCap={100,125,150,175,200},
 },
 ShenE={
  castRangeDisplayOverride=600,
 },
 ShenW={
  ZoneDuration=1.75,
 },
 Jade_ShenQ={
  APRatio_Jade=.6,BaseDamage_Jade={60,100,140,180,220},castFrameSeconds=.42,castRange=475,mSpeed=1500,
 },
 Jade_ShenE={
  MaximumDistance=575,
 },
}
end)()
return {
 Shen={id='normal',q='ShenQ',w='ShenW',e='ShenE',r='ShenR',eRange=D.ShenE.castRangeDisplayOverride,qKind='blade',
  qBuff='ShenQBuff',qWeak='ShenQBuffWeak',qStrong='ShenQBuffStrong',wBuff='ShenWActive',rChannel='ShenRChannelBuffBar',
  passive='ShenPassiveShield',wRadius=350,wDuration=D.ShenW.ZoneDuration,qPercent={.02,.025,.03,.035,.04},qCap=D.ShenQ.MinionDamageCap,
  -- Twilight Assault (https://wiki.leagueoflegends.com/en-us/Template:Data_Shen/Twilight_Assault, read 2026-10-10):
  -- bonus magic damage 10-40 "based on level" (+2-4% (+1.5% per 100 AP) max health); when the blade hits a champion
  -- 5/5.5/6/6.5/7% (+2% per 100 AP) and +50% attack speed. The champion-hit tier is used only while ShenQBuffStrong is seen.
  -- The 10-40 flat part by champion level comes from the installed asset (research/family-assets/Shen/spells.json,
  -- ShenQ mSpellCalculations 290955862: QBaseOnHitDamage 10, +6 at levels 4, 7, 10, 13 and 16; read 2026-10-10).
  -- qFlat stays the level-1 value, used when the level cannot be read (a lower bound).
  qFlat=10,qFlatByLevel={10,10,10,16,16,16,22,22,22,28,28,28,34,34,34,40,40,40},
  qFlatSource='research/family-assets/Shen/spells.json ShenQ mSpellCalculations 290955862 (10 + 6 at levels 4/7/10/13/16; installed asset, read 2026-10-10)',
  qPercentAP=.015,qStrongPercent={.05,.055,.06,.065,.07},qStrongPercentAP=.02,
  qSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Shen/Twilight_Assault read 2026-10-10',
  -- Shadow Dash for Evade. The speed is 800 + 100% movement speed (base 340 = 1140); a registration takes fixed
  -- numbers, so this is a bracket whose slow end (a roughly 40% slowed Shen) is the safety margin.
  eMin=300,eSpeeds={1000,1140},eDelays={0},
  eSource='https://wiki.leagueoflegends.com/en-us/Shen Shadow Dash: range 300-600, no cast time, speed 800 + 100% movement speed, base movement speed 340 (read 2026-10-08)'},
 Jade_Shen={id='classic',q='Jade_ShenQ',w='Jade_ShenW',e='Jade_ShenE',r='Jade_ShenR',eRange=D.Jade_ShenE.MaximumDistance,qKind='target',
  qRange=D.Jade_ShenQ.castRange,qBase=D.Jade_ShenQ.BaseDamage_Jade,qAP=D.Jade_ShenQ.APRatio_Jade,qDelay=D.Jade_ShenQ.castFrameSeconds,qSpeed=D.Jade_ShenQ.mSpeed,qMark='Jade_ShenQ_Heal',
  passive='Jade_ShenPassive_Marker',passiveAttack='Jade_ShenPassive_Attack',wDuration=3,wBase={60,100,140,180,220},wAP=.6,
  wSource='research/family-assets/Jade_Shen/spells.json:1308,1321,1334 (Jade_ShenW BaseShieldAmount 60-220, APShieldMod .6, ShieldDuration 3; no cast-time field; 2026-10-08)',
  -- Same "bonus speed + movement speed" shape as Normal: DashBonusSpeed 800. The Classic base movement speed is not
  -- in the asset, so the fast end only assumes 300; the slow end is the margin. The E record carries an unnamed .25
  -- field (11704a2b) that may be a cast time: both 0 and .25 are declared and Evade must be safe under either.
  eMin=300,eSpeeds={1000,1100},eDelays={0,.25},
  eSource='research/family-assets/Jade_Shen/spells.json:488,501,514 (DashBonusSpeed 800, MinimumDistance 300, MaximumDistance 575; 2026-10-08)'},
}

end
factories['sivir']=function()
-- Sivir mechanics that are not in CombatProfiles/abilities.lua (M.controllers.Sivir keeps geometry and Q
-- coefficients). Normal and Classic are separate; no value is borrowed across profiles.
local D=(function()
return {
 SivirR={
  UltDuration={8,10,12},
 },
 Jade_SivirR={
  UltDuration=15,
 },
}
end)()
return {
 Sivir={id='normal',
  -- Boomerang Blade deals physical damage (https://wiki.leagueoflegends.com/en-us/Sivir, read 2026-10-10).
  qType='physical',qTypeSource='https://wiki.leagueoflegends.com/en-us/Sivir (Boomerang Blade: physical damage), read 2026-10-10',
  -- On the Hunt: 8/10/12 s, bonus movement speed 20-30% for Sivir and nearby allies (wiki read 2026-10-10).
  -- Used only as a chase tool in Combo (switch off by default).
  rKind='speed',rDuration=D.SivirR.UltDuration,
  rSource='https://wiki.leagueoflegends.com/en-us/Sivir (On The Hunt: 8-12 s, +20-30% movement speed), read 2026-10-10'},
 Jade_Sivir={id='classic',
  -- Classic Boomerang Blade is magic damage: own Classic asset tooltip Spell_SivirQ_Jade_Tooltip "deals
  -- <magicDamage>@TotalDamage@ magic damage</magicDamage>" (research/evade/classic-localization-evidence.json,
  -- jade_sivir.bin sha256 daf32cce..., readback verified) and https://wiki.leagueoflegends.com/en-us/League_Classic/Sivir
  -- (read 2026-10-10). Earlier builds computed it as physical.
  qType='magical',qTypeSource='Classic asset tooltip Spell_SivirQ_Jade_Tooltip (magic damage), research/evade/classic-localization-evidence.json; wiki League_Classic/Sivir read 2026-10-10',
  -- Classic On The Hunt: 15 s, +25/45/65% attack speed and +25% movement speed, allies half (wiki League_Classic/Sivir,
  -- read 2026-10-10): a fight steroid, used in Combo while Sivir attacks the target.
  rKind='attack_speed',rDuration={D.Jade_SivirR.UltDuration,D.Jade_SivirR.UltDuration,D.Jade_SivirR.UltDuration},
  rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Sivir (On The Hunt: 15 s, +25/45/65% attack speed), read 2026-10-10'},
}

end
factories['skarner']=function()
-- Skarner numbers the shared row in CombatProfiles/abilities.lua (M.controllers.Skarner, not edited by the
-- champion work) does not carry. The controller overlays these on a private copy of that row.
local D=(function()
return {
 SkarnerQ={
  AttackRange=25,
 },
 Jade_SkarnerR={
  BaseDamage={100,150,200},mCastTime=.25,
 },
 Jade_SkarnerW={
  MSBonus={.15,.17,.19,.21,.23},
 },
}
end)()
return {
 -- https://wiki.leagueoflegends.com/en-us/Skarner read 2026-10-10: Shattered Earth empowers the next three attacks
 -- (+25 attack range) within the qHold window of the shared row; throwing Upheaval ends Shattered Earth. The buff that
 -- carries the window is not confirmed by an asset or a live record: qBuff names the candidate from the installed asset
 -- index (entries.json 'SkarnerQ'); without it the controller times the window from its own observation of the stage.
 -- Impale cast time 0.75 s (shared geometry row).
 Skarner={qEmpowerRange=D.SkarnerQ.AttackRange,qLapseMargin=.5,qBuff='SkarnerQ',rInterruptDelay=.75,
  source='https://wiki.leagueoflegends.com/en-us/Skarner (read 2026-10-10)'},
 -- research/family-assets/Jade_Skarner/spells.json (installed 16.20 assets): Jade_SkarnerR castFrame 7.5 (0.25 s at 30
 -- frames per second), BaseDamage 100/150/200 at ranks 1-3, suppression 1.75 s; Jade_SkarnerW MSBonus .15/.17/.19/.21/.23.
 -- https://wiki.leagueoflegends.com/en-us/League_Classic/Skarner read 2026-10-10: Impale +50% AP; the same damage again when
 -- the suppression ends (not counted: the player may cancel the drag).
 Jade_Skarner={rCast=D.Jade_SkarnerR.mCastTime,rBase=D.Jade_SkarnerR.BaseDamage,rAP=.5,wSpeed=D.Jade_SkarnerW.MSBonus,
  source='research/family-assets/Jade_Skarner/spells.json; https://wiki.leagueoflegends.com/en-us/League_Classic/Skarner (read 2026-10-10)'},
}

end
factories['sona']=function()
-- Shared Sona mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 SonaW={
  AuraRange=400,BaseHeal={30,45,60,75,90},BaseShield={25,45,65,85,105},HealRange=1000,HealRatio=.3,ShieldDuration=1.5,ShieldRatio=.25,
 },
 SonaQ={
  BaseDamage={50,85,120,155,190},
 },
 SonaR={
  BaseDamage={150,250,350},mMissileWidth=140,
 },
 Jade_SonaR={
  APRatio=.7,BaseDamage={150,250,350},mLineWidth=140,mMissileWidth=170,
 },
 Jade_SonaW={
  APRatio=.5,Heal={30,55,80,105,130},
 },
 Jade_SonaQ={
  DamageMissile={60,110,160,210,260},
 },
}
end)()
return {
 Sona={id='normal',q='SonaQ',w='SonaW',e='SonaE',r='SonaR',qBase=D.SonaQ.BaseDamage,qAP=.4,
   healBase=D.SonaW.BaseHeal,healAP=D.SonaW.HealRatio,healRange=D.SonaW.HealRange,shieldBase=D.SonaW.BaseShield,shieldAP=D.SonaW.ShieldRatio,auraRange=D.SonaW.AuraRange,rRadius=D.SonaR.mMissileWidth,rBase=D.SonaR.BaseDamage,rAP=.5,
  auras={{'SonaQ'},{'SonaW'},{'SonaE'}},chords={{'SonaQPassiveAttack'},{'SonaWPassiveAttack'},{'SonaEPassiveAttack'}},
  count='SonaPassive',accelerando='SonaPassiveAccelerandoCount',shield='SonaWShield',hasShield=true,shieldDuration=D.SonaW.ShieldDuration,wDelay=0,
  shieldSource='https://wiki.leagueoflegends.com/en-us/Sona Aria of Perseverance: shield 25/45/65/85/105 (+25% AP) for 1.5 s, no cast time (read 2026-10-08)',
  -- Song of Celerity self haste offered to Evade: research/family-assets/Sona/spells.json SonaE SelfBaseMovementSpeed .20 for
  -- SelfMovementSpeedDurationMin 3 s (up to 7 s while undamaged; the 3 s floor is offered), no cast time (wiki read 2026-10-10).
  eHaste={.2,.2,.2,.2,.2},eHasteDuration=3,eHasteBuff='SonaESelfHaste',
  eHasteSource='research/family-assets/Sona/spells.json SonaE SelfBaseMovementSpeed/SelfMovementSpeedDurationMin; https://wiki.leagueoflegends.com/en-us/Sona (read 2026-10-10)'},
 Jade_Sona={id='classic',q='Jade_SonaQ',w='Jade_SonaW',e='Jade_SonaE',r='Jade_SonaR',qBase=D.Jade_SonaQ.DamageMissile,qAP=.5,
   healBase=D.Jade_SonaW.Heal,healAP=D.Jade_SonaW.APRatio,healRange=1000,auraRange=1000,rRadius=D.Jade_SonaR.mLineWidth,assetRRadius=D.Jade_SonaR.mMissileWidth,rBase=D.Jade_SonaR.BaseDamage,rAP=D.Jade_SonaR.APRatio,
  auras={{'Jade_SonaQ_Aura','Jade_SonaQ_AuraB'},{'Jade_SonaW_Aura','Jade_SonaW_AuraB'},{'Jade_SonaE_Aura','Jade_SonaE_AuraB'}},
  chords={{'Jade_SonaQ_AttackUpgrade','Jade_SonaQ_Attack'},{'Jade_SonaW_AttackUpgrade','Jade_SonaW_Attack'},{'Jade_SonaE_AttackUpgrade','Jade_SonaE_Attack'}},
  count='Jade_SonaPassive_Count',hasShield=false,
  -- Classic Song of Celerity active: research/family-assets/Jade_Sona/spells.json Jade_SonaE MoveSpeedMod .06-.14 (ranks 1-5),
  -- ActiveSpeedDuration 1.5 s; https://wiki.leagueoflegends.com/en-us/League_Classic/Sona active +6-14% for 1.5 s (read 2026-10-10).
  eHaste={.06,.08,.10,.12,.14},eHasteDuration=1.5,eHasteBuff='Jade_SonaE_Haste',
  eHasteSource='research/family-assets/Jade_Sona/spells.json Jade_SonaE MoveSpeedMod/ActiveSpeedDuration; https://wiki.leagueoflegends.com/en-us/League_Classic/Sona (read 2026-10-10)'},
}

end
factories['teemo']=function()
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
factories['thresh']=function()
-- Shared Normal Thresh data; no Classic mechanics are inferred.
local D=(function()
return {
 ThreshQ={
  APRatio=.9,BaseDamage={100,150,200,250,300},
 },
 ThreshW={
  BaseShieldValue={50,70,90,110,130},ShieldDuration=4,castRadius=350,
 },
 ThreshE={
  APRatio=.6,ActiveBaseDamage={65,110,155,200,245},
 },
 ThreshRPenta={
  Damage={250,400,550},mCastTime=.45,
 },
}
end)()
return {
 Thresh={id='normal',q='ThreshQ',qNative='ThreshQInternal',q2='ThreshQLeap',w='ThreshW',e='ThreshE',r='ThreshRPenta',hook='threshq',
 qBase=D.ThreshQ.BaseDamage,qAP=D.ThreshQ.APRatio,eBase=D.ThreshE.ActiveBaseDamage,eAP=D.ThreshE.APRatio,rBase=D.ThreshRPenta.Damage,shield=D.ThreshW.BaseShieldValue,
 -- Lantern numbers for the Evade shield offer and the far throw. leapHold: the fly-in waits until this much of the hook mark is left.
 shieldPerSoul=2,shieldDuration=D.ThreshW.ShieldDuration,lanternTravel=.5,lanternRadius=D.ThreshW.castRadius,lanternFar=1450,leapHold=.4,
 -- Cast times for the finishers and the Flash-Box: Flay 0.389 s, The Box 0.45 s (https://wiki.leagueoflegends.com/en-us/Thresh,
 -- read 2026-10-10). rBase above is the first wall a champion breaks (250/400/550 +100% AP).
 eCast=.389,rCast=D.ThreshRPenta.mCastTime,
 shieldSource='Thresh W: installed asset research/family-assets/Thresh/spells.json (BaseShieldValue 50..130, ShieldPerSoul 2, ShieldDuration 4, castRadius 350) and https://wiki.leagueoflegends.com/en-us/Template:Data_Thresh/Dark_Passage ("throws his lantern to the target location over 0.5 seconds", "Thresh and the first allied champion to come near the lantern are granted a shield for 4 seconds", effect radius 350), read 2026-10-08. lanternFar 1450 and leapHold are play rules, not kit numbers (hook mark 1.5 s: Template:Data_Thresh/Death_Sentence)'}
}

end
factories['tristana']=function()
-- Shared Tristana mechanics data. Values preserved from the maintained controller.
-- Reviewed 2026-10-08 (each profile from its own source; nothing is copied between them):
--  Normal W (Rocket Jump): range 900, cast 0.25, speed 1100, 70/105/140/175/210 +100% bonus AD +50% AP magic,
--   https://wiki.leagueoflegends.com/en-us/Template:Data_Tristana/Rocket_Jump. The page notes "dash speed depends
--   on the distance of the jump": 1100 is the listed figure and is used for the full-length jump only.
--  Normal E crit scaling 40% of crit chance, +12% with Infinity Edge (item 3031),
--   https://wiki.leagueoflegends.com/en-us/Template:Data_Tristana/Explosive_Charge. Abilities add a stack; a stack
--   applied by R delays a full-stack detonation to the end of the knock-back.
--  Classic W: range 900 (asset castRangeDisplayOverride), cast 0.25 (asset field 11704a2b, the same field reads
--   1.0 on Jade_EzrealR whose cast time is 1 s), 70/115/160/205/250 +80% AP (asset BaseDamage/APRatio),
--   research/family-assets/Jade_Tristana/spells.json; speed 1100 from
--   https://wiki.leagueoflegends.com/en-us/League_Classic/Tristana (not in the asset: missileSpeed 20 is no dash speed).
--  Classic R range 550: asset castRange 550 (Jade_TristanaR, spells.json:837), speed 1600 (missileSpeed :901). The
--   Classic wiki page (re-opened 2026-10-08) lists no R target range, only cast 0.25 and "2000 / 1500" speeds, so the
--   asset decides. The asset range is fixed while E's is the attack range: R does not grow with Draw a Bead.
--   Measured centre to centre here, the conservative reading (the reference script uses 600; edge semantics unverified).
--  Classic W speed 1100 and cast 0.25 were read again on that page 2026-10-08 ("SPEED: 1100", "CAST TIME: 0.25").
--  Classic E burns for a fifth of its damage per tick (asset calculation, five ticks over GrievousDuration 5).
--  Q (Rapid Fire) lasts 7 s on both profiles: asset DataValues BuffDuration 7.0 (research/family-assets/Tristana and
--   Jade_Tristana spells.json, read 2026-10-10); Normal also https://wiki.leagueoflegends.com/en-us/Tristana 2026-10-10.
--   Only the drawn Q timer reads it.
local D=(function()
return {
 TristanaE={
  APRatio=.5,ActiveBADRatio=.8,ActiveBaseDamage={60,85,110,135,160},PassiveRadius=300,mSpeed=2400,
 },
 TristanaR={
  APRatio=1,BaseDamage={225,275,325},mSpeed=2000,
 },
 TristanaQ={
  BuffDuration=7,
 },
 TristanaW={
  BaseDamage={70,105,140,175,210},castRangeDisplayOverride=900,
 },
 Jade_TristanaQ={
  BuffDuration=7,
 },
 Jade_TristanaE={
  ActiveAPRatio=1,ActiveDot={110,150,190,230,270},mSpeed=1400,
 },
 Jade_TristanaR={
  BaseDamage={300,400,500},mSpeed=1600,
 },
 Jade_TristanaW={
  APRatio=.8,BaseDamage={70,115,160,205,250},castRangeDisplayOverride=900,
 },
}
end)()
return {
 Tristana={id='normal',q='TristanaQ',w='TristanaW',e='TristanaE',r='TristanaR',eKind='charge',qDuration=D.TristanaQ.BuffDuration,
  eBuff='tristanaecharge',eBase=D.TristanaE.ActiveBaseDamage,eAD=D.TristanaE.ActiveBADRatio,eAP=D.TristanaE.APRatio,eAmp=.25,eMax=4,eCrit=.4,eCritIE=.12,eCritItem=3031,eDuration=4,eSpeed=D.TristanaE.mSpeed,eRadius=D.TristanaE.PassiveRadius,
  rBase=D.TristanaR.BaseDamage,rAD=.7,rAP=D.TristanaR.APRatio,rSpeed=D.TristanaR.mSpeed,wRange=D.TristanaW.castRangeDisplayOverride,
  wDelay=.25,wSpeed=1100,wBase=D.TristanaW.BaseDamage,wAD=1,wAP=.5,
  wSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Tristana/Rocket_Jump 2026-10-08: range 900, cast 0.25, speed 1100'},
 Jade_Tristana={id='classic',q='Jade_TristanaQ',w='Jade_TristanaW',e='Jade_TristanaE',r='Jade_TristanaR',eKind='dot',qDuration=D.Jade_TristanaQ.BuffDuration,
  eBuff='Jade_TristanaE_Debuff',eBase=D.Jade_TristanaE.ActiveDot,eAD=0,eAP=D.Jade_TristanaE.ActiveAPRatio,eDuration=5,eTicks=5,eSpeed=D.Jade_TristanaE.mSpeed,
  rBase=D.Jade_TristanaR.BaseDamage,rAD=0,rAP=1.5,rSpeed=D.Jade_TristanaR.mSpeed,rRange=550,wRange=D.Jade_TristanaW.castRangeDisplayOverride,
  wDelay=.25,wSpeed=1100,wBase=D.Jade_TristanaW.BaseDamage,wAD=0,wAP=D.Jade_TristanaW.APRatio,
  wSource='research/family-assets/Jade_Tristana/spells.json (range 900, cast 0.25) and https://wiki.leagueoflegends.com/en-us/League_Classic/Tristana (speed 1100) 2026-10-08'},
}

end
factories['twitch']=function()
-- Twitch numbers the controller adds to AbilityProfiles.controllers.Twitch (the shared abilities.lua row keeps
-- W/E/R shapes, poison/stealth names and E ratios). Sources in twitch-provenance.json (read 2026-10-10).
--  rBonusRange/rDuration/rBonusAD: spells.json TwitchFullAutomatic / Jade_TwitchR DataValues BonusRange, Duration,
--   BonusAD (ranks 1-3), wiki Twitch V26.16 for Normal.
--  rMarginSpeed: Normal R bolt speed is 5000 on the wiki but 4000 for TwitchSprayAndPrayAttack in the asset; until the
--   twitch_r_bolt dev trace settles it, interceptor margins and R-reach timing use the slower 4000 (conservative).
--   Classic Jade_TwitchR bolts: 4000 (asset).
--  dashLate: W is still worth casting at a dash end it reaches no later than this after the dash ends (controller
--   choice; W radius 300/275 covers the first steps after landing).
--  steal: epic monster names (Baron, Dragon, Herald, Atakhan; CombatProfiles/world.lua P.category), SRU_BaronSpawn excluded.
local D=(function()
return {
 TwitchFullAutomatic={
  BonusAD={30,45,60},BonusRange=300,Duration=6,
 },
 Jade_TwitchR={
  BonusAD={20,28,36},BonusRange=300,Duration=7,
 },
}
end)()
return {
 Twitch={id='normal',rBonusRange=D.TwitchFullAutomatic.BonusRange,rDuration=D.TwitchFullAutomatic.Duration,rBonusAD=D.TwitchFullAutomatic.BonusAD,rMarginSpeed=4000,rWindow=3,dashLate=.3},
 Jade_Twitch={id='classic',rBonusRange=D.Jade_TwitchR.BonusRange,rDuration=D.Jade_TwitchR.Duration,rBonusAD=D.Jade_TwitchR.BonusAD,rMarginSpeed=4000,rWindow=3,dashLate=.3},
}

end
factories['vayne']=function()
-- Shared Vayne mechanics data. Values preserved from the maintained controller.
-- E damage (2026-10-10, vayne-provenance.json): Normal research/family-assets/Vayne/spells.json VayneCondemn
-- Damage 50..190 (+50% bonus AD; wiki V26.20), terrain hit StunDamage x1.5 = 75..285 (+75% bonus AD).
-- Classic research/family-assets/Jade_Vayne/spells.json Jade_VayneE FirstHitDamage = SecondHitDamage 45..185,
-- 0.5 bonus AD each. Classic Q under R: Jade_VayneQ scalingDamageUlt .40..60 (ScalingDamage .30..50 otherwise).
-- stealth: alias lists from the installed assets (InquisitionStealth and the Q fade buff); which one the host
-- shows after Q under R is recorded by the vayne_stealth_buffs development trace (not live-verified).
local D=(function()
return {
 VayneCondemnMissile={
  mSpeed=2200,
 },
 VayneCondemn={
  Damage={50,85,120,155,190},KnockbackDistance=475,castRange=550,
 },
 VayneTumble={
  APRatio=.5,TotalADRatio={.75,.85,.95,1.05,1.15},
 },
 Jade_VayneE={
  FirstHitDamage={45,80,115,150,185},SecondHitDamage={45,80,115,150,185},castRange=550,
 },
 Jade_VayneQ_Bonus={
  ScalingDamage={.3,.35,.4,.45,.5},scalingDamageUlt={.4,.45,.5,.55,.6},
 },
}
end)()
-- Condemn's stationary cast time is declared to the shared cast-time gate.
return {
 Jade_Vayne={id='classic',wBuff='Jade_VayneW_Debuff',qBuff={'Jade_VayneQ_Bonus'},qSdkBuff='jade_vayneq_bonus',qRatio=D.Jade_VayneQ_Bonus.ScalingDamage,qRatioUlt=D.Jade_VayneQ_Bonus.scalingDamageUlt,qAP=0,rBuff='Jade_VayneR',stealth={'Jade_VayneInquisitionStealth','Jade_VayneQ_Fade'},eRange=D.Jade_VayneE.castRange,eKnockback=475,
  eBase=D.Jade_VayneE.FirstHitDamage,eAD=.5,eTerrain=D.Jade_VayneE.SecondHitDamage,eTerrainAD=.5,eCastTime=.25},
 Vayne={id='normal',wBuff='VayneSilveredDebuff',qBuff={'VayneTumble','VayneTumbleBonus'},qSdkBuff='vaynetumblebonus',qRatio=D.VayneTumble.TotalADRatio,qAP=D.VayneTumble.APRatio,rBuff='VayneInquisition',stealth={'VayneInquisitionStealth','VayneTumbleFade'},eRange=D.VayneCondemn.castRange,eKnockback=D.VayneCondemn.KnockbackDistance,
  eBase=D.VayneCondemn.Damage,eAD=.5,eTerrain={75,127.5,180,232.5,285},eTerrainAD=.75,eCastTime=.25},
}

end
factories['viktor']=function()
-- Shared Viktor mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 ViktorE={
  AftershockAPRatio=.8,BaseDamageLaser={70,110,150,190,230},Delay=1,LaserAPRatio=.5,missileSpeed=1050,
 },
 ViktorW={
  Size=275,StunDuration=1.5,castFrameSeconds=.3,castRange=800,
 },
 ViktorR={
  InitialBurstBaseDamage={100,175,250},StormRadius=325,SubsequentBurstAPRaio=.35,
 },
 ViktorQ={
  BuffDuration=2.5,MissileDamage={60,75,90,105,120},ShieldAPRatio=.2,castRange=600,mSpeed=2000,
 },
}
end)()
return {Viktor={id='normal',q='ViktorQ',w='ViktorW',e='ViktorE',r='ViktorR',r2='ViktorRGuide',
 qBase=D.ViktorQ.MissileDamage,qAP=.4,qHit={20,45,70,95,120},qHitAP=.5,qRange=D.ViktorQ.castRange,qSpeed=D.ViktorQ.mSpeed,qDelay=.25,qLife=2.5,
 shieldMin=30,shieldMax=130,shieldAP=D.ViktorQ.ShieldAPRatio,shieldAug=1.6,qMS=.3,
 -- Current installed Q shield: 30..130 by level plus 20% AP, lasting 2.5 s.
 -- The offer uses the level-1 lower bound and the existing 60% augment multiplier.
 -- Current source pins and patch notes are in implementation/family/current-patch.json.
 shieldDuration=D.ViktorQ.BuffDuration,
 shieldSource='Current installed ViktorQ ShieldAPRatio, AugmentShieldBonus, BuffDuration and level calculation; implementation/family/current-patch.json. Offered amount is the level-1 lower bound, granted at cast completion.',
 -- Wiki figures that differ from the installed asset (asset kept, it is the matching profile; not measured live):
 -- E width 90 and "range 500" (asset: missile radius 80, LaserRange 700), W effect radius 340, cast 0.25, arms after
 -- 0.75 s (asset: Size 275; the 0.3 delay below is a prediction candidate), read 2026-10-08.
 eBase=D.ViktorE.BaseDamageLaser,eAP=D.ViktorE.LaserAPRatio,eAfter={20,50,80,110,140},eAfterAP=D.ViktorE.AftershockAPRatio,eAfterDelay=D.ViktorE.Delay,eMinion=.5,
 eStart=525,eLength=700,eRadius=80,eSpeed=D.ViktorE.missileSpeed,eDelay=0,
 wRange=D.ViktorW.castRange,wRadius=D.ViktorW.Size,wDelay=D.ViktorW.castFrameSeconds,wDwell=1.25,wStun=D.ViktorW.StunDuration,wLife=4,wAugSlow=.2,
 -- Ranking 2026-10-10 (dossier Viktor-9/12, wiki Viktor V26.16 read 2026-10-10):
 --  wArm: W cast 0.25 + activation 0.75; the field is predicted where the target is once it is active (the old
 --   wDelay .3 predicted long before). The wiki radius 340 is not used for counting until the viktor_w_field dev trace
 --   settles it against the asset Size 275 (275 is the conservative of the two).
 --  qHitAD: Q discharge 20-120 (+100% AD) (+50% AP) magic; the asset row lacks the AD term.
 wArm=1,qHitAD=1,
 rBase=D.ViktorR.InitialBurstBaseDamage,rAP=.5,rTick={65,105,145},rTickAP=D.ViktorR.SubsequentBurstAPRaio,rRange=700,rGuide=20000,rRadius=D.ViktorR.StormRadius,rLife=6.5,rCadence=1,rMaxTicks=6,
 rGrow=.4,rMaxGrowth=6,rExtension=3,rFast=275,rSlow=200,
 fragments='viktorpassivecount',qEmpower='viktorqbuff',qReturn='viktorqreturn',rTimer='viktorrtimer',rMark='viktorrguide'}}

end
factories['xerath']=function()
-- Shared Normal Xerath data; no Classic mechanics are inferred.
local D=(function()
return {
 XerathLocusOfPower2={
  BaseDamage={170,220,270},
 },
 XerathArcanopulseChargeUp={
  BaseDamage={70,110,150,190,230},
 },
 XerathMageSpear={
  BaseDamage={70,100,130,160,190},
 },
 XerathArcaneBarrage2={
  BaseDamage={50,85,120,155,190},
 },
}
end)()
return {
 Xerath={id='normal',q='XerathArcanopulseChargeUp',q2='XerathArcanopulse2',w='XerathArcaneBarrage2',e='XerathMageSpear',r='XerathLocusOfPower2',shot='XerathRMissileWrapper',pulse='XerathLocusPulse',
 qBase=D.XerathArcanopulseChargeUp.BaseDamage,wBase=D.XerathArcaneBarrage2.BaseDamage,eBase=D.XerathMageSpear.BaseDamage,rBase=D.XerathLocusOfPower2.BaseDamage,shots={4,5,6},
 -- Peel distance for E on an enemy standing next to Xerath: a controller choice (reference lead zgXerath:150-153), not a game value.
 peelRange=350,
 -- Q charge, conservative side of a conflict (xerath-provenance.json q.conflict): asset/ddragon 750->1500 over 1.5 s
 -- from the buff, 4 s charge; wiki V26.17 (read 2026-10-10) 700->1450 over 1.5-1.75 s after a 0-0.25 s onset,
 -- 3 s maximum channel. Until the xerath_q_range dev trace settles it, the fallback range uses the wiki minimum and
 -- maximum, the slower growth and the full onset, and a charge is released within 3 s.
 qMin=700,qMax=1450,qOnset=.25,qGrowth=1.75,qCharge=3,
 -- R recast spacing per shot (wiki V26.17 0.627 s; rivals agree). Used for the shot budget only.
 rShot=.627,
 -- Xerath-5: while more than this much channel time is left beyond the remaining shots, a shot waits for a
 -- precise hit (controller choice, dossier Xerath-5).
 rSlack=.7,
 -- Xerath-7: a target that left vision this recently is revealed (Core:Reveal) and may take one shot at its
 -- advanced position within rBlind seconds of vanishing (controller choices; R radius 200).
 rVanish=.5,rBlind=.25,
 -- Mana Surge on-hit buff (candidate name from the asset buff list; live verification pending).
 passive='XerathAscended2OnHit'}
}

end
factories['yone']=function()
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
factories['zed']=function()
-- Shared Zed mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 ZedW={
  RecastRange=2000,SwapTimeLimit=5.25,castRangeDisplayOverride=650,
 },
 ZedR={
  RDeathMarkDuration=3,RShadowDurationDisplayed=7.5,castRange=625,
 },
 ZedQ={
  BaseDamage={80,120,160,200,240},BonusADRatio=1,castRangeDisplayOverride=900,mLineWidth=45,
 },
 ZedE={
  ADRatio=.7,BaseDamage={70,92.5,115,137.5,160},ShadowRadius=290,
 },
}
end)()
return {Zed={id='normal',q='ZedQ',w='ZedW',w2='ZedW2',e='ZedE',r='ZedR',r2='ZedR2',mark='ZedRDeathMark',wBuff='ZedWHandlerBuffName',rBuff='ZedR2',passiveCD='ZedPassiveCD',
 qRange=D.ZedQ.castRangeDisplayOverride,qRadius=D.ZedQ.mLineWidth,qBlockRadius=50,qSpeed=1700,qDelay=.25,qBase=D.ZedQ.BaseDamage,qAD=D.ZedQ.BonusADRatio,qPass=.6,
 -- Death Mark as offered to Evade: untargetable from the cast (no cast time) through a 0.6 s delay and a 0.35 s dash, then
 -- Zed stands 125 units beyond the target (Template:Data_Zed/Death_Mark, read 2026-10-08). The sum .95 s is ours.
 rUntargetable=.95,rBehind=125,rCast=0,rEvadeSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Zed/Death_Mark target range 625, no cast time, untargetable 0.6 s delay + 0.35 s dash, lands 125 beyond the target; read 2026-10-08',
 -- Shadow swaps offered to Evade (Zed-2): both recasts are blinks with no cast time; R2 waits 0.5 s after Zed
 -- reappears and is refused in the last 1.25 s. A missing number here withdraws the offer.
 w2Cast=0,w2CastSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Zed/Living_Shadow cast time none; recast Shadow Swap: Zed and the Shadow blink to swap places; read 2026-10-10',
 r2Cast=0,r2Tail=1.25,r2CastSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Zed/Death_Mark cast time none; recast blinks to swap places 0.5 s after Zed reappears, not in the last 1.25 s; read 2026-10-10',
 -- W lands between 325 and 650 (asset ZedMarker castRange 325, wiki V26.10); the shadow travels at 2500 (asset ZedWMissile).
 -- Two-step Evade dodge (W toward an Evade-chosen point, W2 once the shadow is seen there). The wiki lists no cast
 -- time; wCast .07 is a conservative bound from the asset animation (ZedW castFrame 1.98 at 30 fps = .066 s).
 -- wObserve .15 is the bound of our own shadow discovery job (35 ms interval, 150 ms maximum delay), not a game number.
 wCast=.07,wObserve=.15,wPlaceSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Zed/Living_Shadow range 650 (minimum 325), cast time none, recast none; asset ZedWMissile missileSpeed 2500 and ZedW castFrame 1.98 (bound .07 s); read 2026-10-10',
 wMin=325,wSpeed=2500,wRange=D.ZedW.castRangeDisplayOverride,wSwapRange=D.ZedW.RecastRange,wDuration=D.ZedW.SwapTimeLimit,rRange=D.ZedR.castRange,rDuration=D.ZedR.RShadowDurationDisplayed,rRecast=.5,markDuration=D.ZedR.RDeathMarkDuration,rAmp={.25,.4,.55},rAD=1,
 -- E: asset ZedE castRadius 290, wiki lists 315 and 290; the caster uses 290 until the zed_e_reach trace measures it.
 eRadius=D.ZedE.ShadowRadius,eShadowRadius=D.ZedE.ShadowRadius,eBase=D.ZedE.BaseDamage,eAD=D.ZedE.ADRatio,
 passiveThreshold=.5,passiveLevels={1,7,17},passiveRatios={.05,.075,.10},monsterMod=.75,monsterCap=175,passiveDuration=10}}

end
local cached={}
local function getProfile(identity)
 if type(identity)~='string'then return nil end
 if cached[identity]~=nil then return cached[identity]or nil end
 local base=(identity:match('^Jade_(.+)$')or identity):lower()
 local factory=factories[base];if not factory then return nil end
 local pair=factory();local row=pair[identity];local value=row and row.combat
 cached[identity]=value or false;return value
end

local function finite(v)return type(v)=='number'and v==v and v>-math.huge and v<math.huge end
local function rankValue(v,rank)return type(v)=='table'and(v[rank]or 0)or v or 0 end
function P.Get(identity)return getProfile(identity)end
function P.Range(identity,slot,rank)local p=getProfile(identity);local s=p and p[({'q','w','e','r'})[slot+1]];return s and rankValue(s.range,rank)or 0 end
function P.Raw(identity,slot,rank,stats,target,options)
 local p=getProfile(identity);local s=p and p[({'q','w','e','r'})[slot+1]];options=options or {}
 if not s or not finite(rank)or rank%1~=0 or rank<1 or not s.base or not s.base[rank]then return 0,'unsupported_or_unlearned'end
 local ad,bonus,ap=stats.totalDamage,stats.bonusDamage,stats.ap
 if not finite(ad)or not finite(bonus)or not finite(ap)then return 0,'invalid_stats'end
 local raw=s.base[rank]+rankValue(s.ad,rank)*ad+rankValue(s.bonusAD,rank)*bonus+(s.ap or 0)*ap
  local kind=s.type
  if p.rawModifier then raw,kind=p.rawModifier(p,raw,s,slot,rank,stats,target,options,finite)end
  if not finite(raw)then return 0,'invalid_damage'end
 return math.max(0,raw),kind
end
function P.Passive(identity,stats,target)
 local p=getProfile(identity);if not p then return 0 end
 local level=stats.level;local ad,bonus=stats.totalDamage,stats.bonusDamage
 if not finite(level)or not finite(ad)or not finite(bonus)then return 0 end
  if p.passive then return p.passive(p,stats,target,finite)end
 return 0
end
function P.Heal(identity,rank,stats,active,mantra)
 local p=getProfile(identity);if not p or not finite(stats.health)or not finite(stats.maxHealth)or stats.maxHealth<=0 then return 0 end
  if p.heal then return p.heal(p,rank,stats,active,mantra,finite)end
  return 0
end
P.Finite=finite
-- Only existing, reviewed missile stages share widths and speeds. Cast launch
-- remains native evidence; targeting range and projectile flight range differ.
-- This never creates an alias, a threat or an eligibility claim.
function P.ApplyCatalog(identity,set)
 local p=getProfile(identity)
 if not p or type(set)~='table'then return set end
 for slot,names in ipairs(p.names)do local spec=p[({'q','w','e','r'})[slot]]
  if spec and finite(spec.radius)and finite(spec.speed)and spec.speed>0 then
   for _,alias in ipairs(names)do local record=set[alias];local cast=record and record.cast
    if cast and cast.kind=='missile'and cast.shape=='missile'and cast.alias==alias and cast.slot==slot-1 then
     cast.radius=spec.radius;cast.speed=spec.speed
     if finite(spec.flightRange)then cast.range=spec.flightRange end
     record.sharedAbilityVersion=P.version
     local missile=cast.missile and set[cast.missile]
     if missile and missile.eligible==true and missile.missileRecord then
      missile.radius=spec.radius;missile.speed=spec.speed
      if finite(spec.flightRange)then missile.range=spec.flightRange end
      missile.sharedAbilityVersion=P.version
     end
    end
   end
  end
 end
 return set
end
return P

end
