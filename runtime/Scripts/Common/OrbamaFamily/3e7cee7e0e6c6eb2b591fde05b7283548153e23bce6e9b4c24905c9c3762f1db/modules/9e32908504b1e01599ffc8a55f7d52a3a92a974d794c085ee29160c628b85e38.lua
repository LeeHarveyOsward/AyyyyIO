return function(require)
-- 26.20 active slot/calculation extraction. Units: world units, seconds, raw damage.
-- Provenance: research/26.20-five-champions/<identity>/{manifest,spells}.json.
-- Runtime aliases and gameplay outcomes require live acceptance; retained rows are not stages.
local P={version=1,patch='26.20',assetVersion='16.20.1'}
local factories={}
factories['aatrox']=function()
-- Shared Aatrox Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
local profiles={}
profiles['Aatrox']=profiles['Aatrox']or {}
profiles['Aatrox'].combat={id='normal',champion='Aatrox',names={{'AatroxQ','AatroxQ2','AatroxQ3'},{'AatroxW'},{'AatroxE'},{'AatroxR'}},
  q={range=625,radius=90,delay=.6,speed=math.huge,type='physical',base={10,25,40,55,70},ad={.6,.675,.75,.825,.9}},
  -- 2026-10-10 (wiki Aatrox, Last changed V26.19, read 2026-10-10): W physical since V25.11. Q1 625x180 (half-width
  -- 90); Q2 trapezoid from 100 behind to 475 ahead, 300 to 500 wide (half-widths 150/250); Q3 300-radius circle 200
  -- ahead, 180-radius sweet spot. Q1/Q2 sweet depths are not published: 475 and 350 kept (live damage logs settle them).
  -- qWindow 4 s (asset QExtensionTime). wChainRadius: not published; 150 is below DepressiveAIONext's 185+bounding,
  -- development 'aatrox_w_pull' traces settle it. qMinion: wiki "55/60/65/70% (based on level)" without the level
  -- breakpoints; the lowest share 0.55 is used for every level so a minion kill is never overestimated.
  w={range=825,radius=80,delay=.25,speed=1800,type='physical',base={30,40,50,60,70},ad=.4,collision=true},
  e={range=300},r={range=0},qStages={{range=625,width=90,sweetMin=475,sweetMax=625},{range=475,back=100,near=150,width=250,sweetMin=350,sweetMax=475},{center=200,radius=300,sweetRadius=180}},qRamp=.25,sweetBonus=.75,
  qWindow=4,wChainRadius=150,qMinion=.55,
  passiveNames={'AatroxPassiveReady','AatroxPassive'},tetherNames={'AatroxW'},passiveHP={.04,.10},passiveCap={100,320},eHealingHP=.00013,eHealing=.16,rAD={.2,.3,.4},rHealing={.5,.75,1},rDuration=10}
profiles['Jade_Aatrox']=profiles['Jade_Aatrox']or {}
profiles['Jade_Aatrox'].combat={id='classic',champion='Aatrox',names={{'Jade_AatroxQ'},{'Jade_AatroxW','Jade_AatroxW2'},{'Jade_AatroxE'},{'Jade_AatroxR'}},
  q={range=650,radius=310,knockupRadius=190,delay=.6,speed=math.huge,type='physical',base={70,115,160,205,250},bonusAD=.6,healthCost=.1},
  w={range=0,type='physical',base={60,95,130,165,200},bonusAD=1},
  -- E: Jade_AatroxEConeMissile castRange 1075, missile line radius 40 (field 1a24e25e; the second blade 15,
  -- castRadius 100 is the spread, not the hit width); 26.20 Jade_Aatrox spells.json, 2026-10-10.
  e={range=1075,radius=40,delay=.25,speed=1250,type='magical',base={75,120,165,210,255},bonusAD=.6,ap=.6,healthCost=.05},
  r={range=550,type='magical',base={200,300,400},ap=1},wHeal={20,25,30,35,40},wHealAD=.25,wHealThreshold=.5,wHealAmplifier=3,
  healNames={'Jade_AatroxWLife'},damageNames={'Jade_AatroxWPower'},reviveNames={'Jade_AatroxPassiveDeath'},wAttacks=3,reviveDuration=3,rDuration=12,rAS={.4,.5,.6},rAttackRange=175}
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
return {
 Jade_Akali={id='classic',q=550,w=475,e=325,r=700,qAP=.4,eAP=.4,qMark={base={45,70,95,120,145},ap=.4},
  rDash={name='Jade_AkaliR',range=700,speeds={1600,2000},castDelays={0,.25},onTarget=true,through=715,
   source='2026-10-10 conservative bracket: wiki League_Classic/Akali (target range 700, speed 1600 before V5.9, 2000 after) and installed Jade_AkaliR (castRange 800, DashDistance 715); both end points checked'}},
 Akali={id='normal',q=500,qHitRange=550,w=350,e=825,r=675,qAP=.6,eAP=1.1,r2Window=10,r2Delay=2.5,qFan={range=500,angle=20},e2Range=1000,e2KillRange=1500,r2Dash={750,800},
  rDash={name='AkaliR',range=675,speeds={1500},castDelays={.25},through=750,past=150,
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
return {
 Amumu={id='normal',q='BandageToss',w='AuraofDespair',e='Tantrum',r='CurseoftheSadMummy',
  charges=2,passive='AmumuPDebuff',passiveKind='true_damage_amp',qBase={70,95,120,145,170},qAP=.85,
   eBase={65,95,125,155,185},eAP=.5,rBase={200,300,400},rAP=.8,rInterrupt=true,wRadius=300,wReach=350},
 Jade_Amumu={id='classic',q='Jade_AmumuBandageToss',w='Jade_AmumuAuraofDespair',e='Jade_AmumuTantrum',r='Jade_AmumuCurseoftheSadMummy',
  charges=0,passive='Jade_AmumuCursedTouch',passiveKind='magic_resist_reduction',qBase={80,140,200,260,320},qAP=.7,
   eBase={65,95,125,150,175},eAP=.5,rBase={150,250,350},rAP=.8,rInterrupt=false,wRadius=300},
}

end
factories['annie']=function()
-- Shared Annie mechanics data. Values preserved from the maintained controller.
return {
 Annie={id='normal',q='Disintegrate',w='Incinerate',e='AnnieE',r='InfernalGuardian',
  guides={AnnieRController=true,InfernalGuardianGuide=true},stack='anniepassivestack',primed='anniepassiveprimed',
  qBase={80,125,170,215,260},qAP=.8,wBase={70,110,150,190,230},wAP=.8,rBase={150,275,400},rAP=.75,allyE=true,
  -- Molten Shield: 60-200 (+40% AP) for 3 s on Annie or an ally within 800, no cast time.
  eShield={60,95,130,165,200},eShieldAP=.4,eShieldDuration=3,eDelay=0,
  shieldSource='https://wiki.leagueoflegends.com/en-us/Annie Molten Shield, read 2026-10-08 (page last changed V26.04)',
  -- Tibbers also receives the Molten Shield (wiki Annie, read 2026-10-10, V26.04): E in Combo while he fights.
  ePet=true},
 Jade_Annie={id='classic',q='Jade_Annie_Disintegrate',w='Jade_Annie_Incinerate',e='Jade_AnnieE',r='Jade_AnnieR',
  guides={Jade_Annie_InfernalGuardianGuide=true},stack='Jade_AnniePassive_StunBuildupBuff',primed='Jade_AnniePassive_StunReadyBuff',
  qBase={90,130,170,210,250},qAP=.75,wBase={85,135,185,235,285},wAP=.8,rBase={200,325,450},rAP=.7,allyE=false},
 -- Classic Molten Shield is +20-60 armor and magic resist for 5 s on Annie (Jade_Annie/spells.json Resistances,
 -- ShieldDuration; League_Classic/Annie read 2026-10-08): no absorb amount, so no eShield and no shield offer.
 -- Whether Classic E also reaches Tibbers is unmeasured (no ePet): the dev trace annie_classic_e_tibbers settles it.
}

end
factories['caitlyn']=function()
-- Ranking pass 2026-10-10 (experiments/champion-ranking-20261010/dossiers/Caitlyn.md), wiki.leagueoflegends.com/en-us/Caitlyn
-- read 2026-10-10: Normal R crit bonus is 1 + (0.30 + 0.09 with Infinity Edge) x crit chance (was 0.3 x crit x (critDamage-1),
-- which refused kills). Headshot every 5 attacks, 4 from brush (patch 13.16; was 6, preview data only). The Normal passive
-- crit term below (critChance x (critDamage-1)) is not confirmed by the wiki text read; Hooks.attack records observed
-- Headshots (caitlyn_headshot trace) to settle it. Classic: the net enabling a Headshot is unmeasured (no net buff alias),
-- so the E + Headshot finisher is Normal only.
-- Shared Caitlyn Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
-- R timing, 2026-10-08: Normal 0.375 s cast + 1 s channel (delay 1.375), missile speed 3200
-- (wiki.leagueoflegends.com/en-us/Caitlyn, Ace in the Hole); the earlier 1 / 1500 made the lethal
-- check add two more seconds of regeneration and refuse valid kills. Classic: speed 3200 and a
-- 1 s channel (wiki.leagueoflegends.com/en-us/League_Classic/Caitlyn; V1.0.0.112 raised it from
-- 2200); its "brief delay" before the channel is not quantified, so delay stays 1.
-- Classic W: arm 1.1 s and three traps per the League Classic page (V1.0.0.114: 3 from 2); the
-- earlier 1 / 2 only cost a trap or made a trap arm 0.1 s late. Uncertain and unchanged: Classic Q
-- cast time (.625 here, 1 on the page), Classic E range (750 here, 950 on the page) and recoil
-- (390 here, 400 on the page). Normal E recoil speed 1000 (same page, "1600 / 1000") is recorded
-- as recoilSpeed; the Normal recoil is offered to Evade with the cast mirrored (Core:RegisterMobility aim).
local profiles={}
profiles['Caitlyn']=profiles['Caitlyn']or {}
profiles['Caitlyn'].combat={id='normal',champion='Caitlyn',names={{'CaitlynQ','CaitlynQ2'},{'CaitlynW'},{'CaitlynE'},{'CaitlynR'}},
   q={range=1250,flightRange=1300,radius=60,delay=.625,speed=2200,type='physical',base={50,90,130,170,210},ad={1.25,1.45,1.65,1.85,2.05}},
  w={range=800,delay=.25,arm=1,radius=75,max={3,3,4,4,5},duration={30,35,40,45,50},type='physical',base={35,80,125,170,215},bonusAD=.3},
   e={range=750,flightRange=800,radius=70,delay=.15,speed=1600,collision=true,type='magical',base={80,130,180,230,280},ap=.8,recoil=390,recoilSpeed=1000},
  r={range=3500,delay=1.375,speed=3200,radius=40,type='physical',base={300,475,650},bonusAD=1,crit=.3,critIE=.09},qPierce=.6,
  headshotNames={'CaitlynPassiveDriver'},trapNames={'CaitlynWSight','CaitlynWSnare'},netNames={'Eternals_CaitlynEHeadshotTracker'},trapObjectNames={'CaitlynTrap'},headshotLevel={.6,.8,1},headshotAttacks=5,headshotAttacksBrush=4}
profiles['Jade_Caitlyn']=profiles['Jade_Caitlyn']or {}
profiles['Jade_Caitlyn'].combat={id='classic',champion='Caitlyn',names={{'Jade_CaitlynQ'},{'Jade_CaitlynW'},{'Jade_CaitlynE'},{'Jade_CaitlynR'}},
  q={range=1250,radius=90,delay=.625,speed=2200,type='physical',base={20,60,100,140,180},ad=1.3},
  w={range=800,delay=.25,arm=1.1,radius=75,max={3,3,3,3,3},type='magical',base={80,130,180,230,280},ap=.6},
  e={range=750,radius=70,delay=.15,speed=1600,collision=true,type='magical',base={80,130,180,230,280},ap=.8,recoil=390},
  r={range={2000,2500,3000},delay=1,speed=3200,radius=40,type='physical',base={250,475,700},bonusAD=2},qPierceStep=.1,qPierceMin=.5,
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
 local scale=target and target.type~=stats.heroType and 1.1 or(level>=13 and 1 or level>=7 and .8 or .6)
 return stats.totalDamage*(scale+stats.critChance*(stats.critDamage-1)),'physical'
end
return profiles

end
factories['chogath']=function()
-- Shared Chogath mechanics data. Values preserved from the maintained controller.
return {
 Chogath={id='normal',q={'Rupture'},w={'FeralScream'},e={'VorpalSpikes'},r={'Feast'},
  qBase={80,135,190,245,300},qRadius=230,qDelay=.625,wBase={80,130,180,230,280},wRange=585,
  eBase={30,50,70,90,110},ePercent={2.5,2.85,3.2,3.55,3.9},eToggle=false,
  rBase={300,475,650},rMonster=1200,rAP=.5,rHP=.1,stackCapKind='non_epic',stackCap=6,feastBuff='Feast',
  -- LoL wiki Cho'Gath V26.17 (read 2026-10-10): Feast range +2.5 per stack up to +25; spikes 650 long, 1475 speed,
  -- width 340-500 (the narrowest half width is used); 110-310 (+30% AP) per spike against monsters; +0.5% maximum
  -- health per Feast stack (installed asset FeastStackMultiplier 0.5); E lasts 6 s (asset BuffDuration).
  rStackRange=2.5,rStackRangeMax=10,eSpikeRange=650,eSpikeSpeed=1475,eHalfWidth=170,eMonster={110,160,210,260,310},
  eStackPercent=.5,eDuration=6},
 Jade_Chogath={id='classic',q={'Jade_ChogathQ'},w={'Jade_ChogathW','Jade_Chogath_FeralScream'},
  e={'Jade_ChogathE','Jade_ChogathE_Jade'},r={'Jade_ChogathR','Jade_Chogath_Feast'},
  qBase={80,135,190,245,305},qRadius=250,qDelay=.625,wBase={75,125,175,225,275},wRange=650,
  eBase={20,35,50,65,80},eToggle=true,rBase={300,475,650},rMonster=1000,rAP=.7,rHP=0,
  stackCapKind='total',stackCap=6,feastBuff='Jade_ChogathR',
  -- Installed Jade_ChogathEMissile: castRange 650, missileSpeed 1475, castRadius 175 (half width candidate; 150
  -- is used until measured). Feast stack range growth and per-stack spike damage are unmeasured: none here.
  -- Whether Classic Feast stacks survive death is unverified (chogath-provenance gaps): death makes the count unknown.
  eSpikeRange=650,eSpikeSpeed=1475,eHalfWidth=150,stacksMayDropOnDeath=true},
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
return {
 Corki={id='normal',qRange=825,qSpeed=1100,qRadius=250,qBase={60,105,150,195,240},qAP=1,qBonusAD=1.25,
  rBase={90,170,250},rBonusAD=.85,rTotalAD=0,rAP=0,rMultiplier=2,rDamage='physical',
   bigBuff='corkimissilebarragecounterbig',rRange=1300,bigRange=1500,splash=150,bigSplash=300,maxAmmo=4,eRange=690,eAngle=35,
   wName='CarpetBomb',wMinRange=300,wRange=600,wSpeed=650,wCast=0,
   wSource='https://wiki.leagueoflegends.com/en-us/Corki Valkyrie range 300-600, no cast time, speed 650 + 100% movement speed (floor 650 declared), read 2026-10-08'},
 Jade_Corki={id='classic',qRange=600,qSpeed=math.huge,qRadius=250,qBase={80,130,180,230,280},qAP=.5,qBonusAD=0,
  rBase={120,190,260},rBonusAD=0,rTotalAD=.2,rAP=.3,rMultiplier=1.5,rDamage='magical',
   bigBuff='jade_corkir_check',rRange=1225,bigRange=1225,splash=75,bigSplash=150,maxAmmo=7,eRange=600,
   wName='Jade_CorkiW',wMinRange=300,wRange=800,wAssetMaxRange=800,wSpeed=650,wCast=0,
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
return {Jade_Fiora={classic=true,wAttacks=classicAttacks,q=600,r=400,qName='Jade_FioraQ',wName='Jade_FioraW',eName='Jade_FioraE',rName='Jade_FioraR',
 qBase={40,65,90,115,140},qAD={.6,.6,.6,.6,.6},qWindow=4,wDuration=1.5,eDuration=3,rBase={125,255,385},rAD=.85,rRepeat=.4,rRepeatFloor=.25,rStrikes=5,rBounce=600,
 qDash={established=false,speeds={1200},castDelays={0,.15},source='Jade_Fiora spells.json Jade_FioraQ castRange 600, DashMovespeedBonus 1200 (2026-10-08); speed semantics open, cast delay bracket 0-.15 unmeasured'}},
 Fiora={classic=false,q=400,r=500,qName='FioraQ',wName='FioraW',eName='FioraE',rName='FioraR',
 qDash={speeds={850,1100,1600},castDelays={0},source='https://wiki.leagueoflegends.com/en-us/Template:Data_Fiora/Lunge 2026-10-08: range 50-400, cast none, speed 1100 + 300/350% bonus movement speed within 850-1600'},
 wAttacks=normalAttacks,
 qBase={70,80,90,100,110},qAD={.9,.95,1,1.05,1.1},qRefund=.5,wDuration=.75,wRange=900,wWidth=70,wSpeed=3200,wPoise=.5,wBase={110,150,190,230,270},wAP=1,
 stabRadius=420,stabPriority=252,rHorizon=4,eDuration=3,eTwo={1.6,1.7,1.8,1.9,2},
 vitals={sides={NE={0,1},NW={1,0},SE={-1,0},SW={0,-1}},ownerRadius=100,offset=50,offsetMin=25,agreeCos=.8,learnAfter=3,reach=30,reveal=1.75,rReveal=.5,scanLimit=400},
 markDuration=8,healDuration=5,healRadius=600,healBase={80,105,130},healAD=.7,vitalBase=.03,vitalAD=.0004}}

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
return {
 Fizz={id='normal',q='FizzQ',w='FizzW',e='FizzE',e2='FizzETwo',buffer='FizzEBuffer',r='FizzR',
  wBuff='FizzWActive',wAttack='FizzWBasicAttack',onHit='FizzOnHitBuff',bleed='FizzWDOT',fish='FizzRCling',
  qBase={10,25,40,55,70},qAP=.55,wBase={50,75,100,125,150},wAP=.45,wDuration=4,
  dotBase={30,45,60,75,90},dotAP=.25,eBase={80,130,180,230,280},eAP=.95,
  rBase={180,300,420},rAP=.6,rRange=1300,rSpeed=1300,rDelay=2,rTiered=true,
  rTiers={near=455,far=910,band=40,mid=1.25,large=1.5},eLanding=.75,
  e2Radius=225,e2Cast=.15,wReachBonus=50},
 Jade_Fizz={id='classic',q='Jade_FizzQ',w='Jade_FizzW',e='Jade_FizzE',e2='Jade_FizzETwo',buffer='Jade_FizzEBuffer',r='Jade_FizzR',
  wBuff='Jade_FizzWActive',bleed='Jade_FizzWDOT',fish='Jade_FizzRCling',
  qBase={10,40,70,100,130},qAP=.4,wBase={10,15,20,25,30},wAP=.2,wDuration=5,
  dotBase={30,40,50,60,70},dotAP=.35,dotMissing={.04,.05,.06,.07,.08},eBase={70,120,170,220,270},eAP=.75,
  rBase={200,325,450},rAP=1,rRange=1275,rSpeed=1350,rDelay=1.5,rTiered=false,eLanding=.75},
}

end
factories['graves']=function()
-- Shared Graves mechanics data. Values preserved from the maintained controller.
-- Ranking pass 2026-10-10: Normal fullReload 2.08 s, the reload of both shells from empty
-- (https://wiki.leagueoflegends.com/en-us/Graves/LoL, page V26.17, read 2026-10-10); bounds the
-- observed-empty lease of the controller (Graves-1). Classic has no shells.
return {
 Graves={id='normal',q='GravesQLineSpell',w='GravesSmokeGrenade',e='GravesMove',r='GravesChargeShot',
  qBase={50,75,100,125,150},qAD=.55,returnBase={80,125,170,215,260},returnAD={.45,.6,.75,.9,1.05},
  qRange=800,qSpeed=3000,qRadius=40,qDelay=.25,returnSpeed=1600,returnRadius=100,wallDelay=.2,endDelay=1,
  wRadius=200,eMin=275,eRange=375,eSpeed=750,grit='GravesEGrit',maxGrit=8,
  rBase={275,425,575},rCone={200,320,440},rAD=1.5,rConeAD=1.2,coneRange=735,recoil=400,fullReload=2.08},
 Jade_Graves={id='classic',q='Jade_GravesQ',w='Jade_GravesW',e='Jade_GravesMove',r='Jade_GravesChargeShot',
  qBase={60,95,130,165,200},qAD=.8,qRange=800,qSpeed=2000,qRadius=50,qAngle=15.32,qPenalty=.35,qDelay=.25,
  wRadius=210,eMin=0,eRange=425,eSpeed=850,grit='Jade_GravesPassive_Counter',maxGrit=10,eBuff='Jade_GravesE_Buff',
  rBase={250,350,450},rCone={140,230,320},rAD=1.4,rConeAD=1,coneRange=800,recoil=0},
}

end
factories['irelia']=function()
-- Shared Irelia Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
local profiles=(function()
-- Shared Irelia mechanics data. Values preserved from the maintained controller.
return {Irelia={id='normal',q='IreliaQ',w='IreliaW',w2='IreliaW2',e='IreliaE',e2='IreliaE2',r='IreliaR',
 mark='IreliaMark',passive='IreliaPassiveStacks',passiveMax='IreliaPassiveStacksMax',defense='IreliaWDefense',
 qRange=600,qSpeed=1400,qBase={5,25,45,65,85},qAD=.8,qMinionBase=50,qMinionLevel=11,
 stacks=4,passiveBase=10,passiveLevel=3,passiveAD=.2,eRange=775,eDelay=.3,eRev=.35,eRadius=70,eDuration=3.5,eRecast=.25,
 eBase={70,110,150,190,230},eAP=1,wRange=775,wRadius=100,wMax=1.5,wFull=.75,wBase={10,20,30,40,50},wAD=.4,wAP=.5,wMaxBonus=2,
 wPhysicalDR={40,70},wDRAP=.08,wMagicDR=.5,
 -- 2026-10-10: W minimum +40% AD +50% AP (installed IreliaW calculation 368633251: .4 on stat 2 = AD, as Q's .8;
 -- .5 on the default stat = AP; wiki V26.17 agrees; the earlier .5 AD/.4 AP read the two terms swapped).
 -- R castRange 1000 (installed castRange, wiki V26.17; 950 is only the display override). Cast time: the installed
 -- asset says .5 (field 7c4baddc), the wiki .4; the asset value is kept.
 -- rBurst: radius around the first champion hit that the burst also marks. Not published: the 320 line width is
 -- used as a lower bound until development 'irelia_r' traces (marked champions per cast) settle it.
 -- qThrough: wiki V26.17 "dashes 100 units through the target"; unverified, used only as an extra Evade landing check.
 -- eRecast stays .25 (installed CDBetweenCast) where the wiki says .15: the conservative value.
 rRange=1000,rSpeed=2000,rDelay=.5,rRadius=160,rBurst=320,qThrough=100,rBase={125,200,275},rAP=1}}

end)()
profiles['Irelia']=profiles['Irelia']or {}
profiles['Irelia'].combat={id='normal',champion='Irelia',names={{'IreliaQ'},{'IreliaW','IreliaW2'},{'IreliaE','IreliaE2'},{'IreliaR'}},
  q={range=600,type='physical',base={5,25,45,65,85},ad=.8,minionBase=50,minionLevel=11},
  w={range=775,type='physical',base={10,20,30,40,50},ad=.4,ap=.5},
  e={range=775,type='magical',base={70,110,150,190,230},ap=1},r={range=1000,type='magical',base={125,200,275},ap=1},passiveNames={'IreliaPassiveStacksMax'},passiveBase=10,passiveLevel=3,passiveAD=.2}
profiles['Jade_Irelia']=profiles['Jade_Irelia']or {}
profiles['Jade_Irelia'].combat={id='classic',champion='Irelia',names={{'Jade_IreliaQ'},{'Jade_IreliaW'},{'Jade_IreliaE'},{'Jade_IreliaR'}},
  q={range=620,delay=.05,speed=1400,type='physical',base={20,50,80,110,140},ad=1},
  w={range=0,type='true',base={15,30,45,60,75}},e={range=325,delay=.3,type='magical',base={80,130,180,230,280},ap=.5},
  r={range=1200,radius=60,delay=.25,speed=1600,type='physical',base={80,120,160},bonusAD=.6,ap=.5},
  wNames={'Jade_IreliaW_Buff'},wPassiveHeal={5,7,9,11,13},wActiveHeal={10,14,18,22,26},wDuration=6,qRefund=35,
  eStun={1,1.25,1.5,1.75,2},rBlades=4,rChampionHeal=.25,rMinionHeal=.1,passiveRadius=1400,passiveTenacity={.1,.25,.4}}
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
return {
    -- 2026-10-08: E shield, W missile and R area were read from the matching page of each profile (`source`).
    -- Both pages give Q speed 880-1408 and width 240 by charge; the controller keeps its asset speed and a
    -- radius of 100 as the prediction inset for the short charges it releases (not corrected: unmeasured).
    classic={id='classic',qBegin='Jade_JannaHowlingGale',qRelease='Jade_JannaHowlingGaleSpell',
        rName='Jade_JannaReapTheWhirlwind',qSpeed=900,wBase={60,115,170,225,280},wAP=.6,wEdge=false,
        wDelay=.25,wSpeed=1600,rRadius=700,eRange=800,eTurrets=true,
        eShield={80,120,160,200,240},eShieldAP=.9,eDuration=5,eDelay=0,
        source='research/family-assets/Jade_Janna/spells.json:1754-1817 (BaseShield, ShieldAPRatio .9, ShieldDuration 5) and https://wiki.leagueoflegends.com/en-us/League_Classic/Janna (read 2026-10-08)',
        -- 2026-10-10, https://wiki.leagueoflegends.com/en-us/League_Classic/Janna: Q range 1100 + 20 % per second of
        -- charge (1760 at 3 s), constant 1.25 s travel; R heals 70/110/150 (+35 % AP) per second for 4 s.
        qBaseRange=1100,qChargeRate=220,qMaxCharge=3,qTravel=1.25,
        rHeal={70,110,150},rHealAP=.35,rTick=1,rChannel=4},
    normal={id='normal',qBegin='HowlingGale',qRelease='HowlingGaleSpell',
        rName='ReapTheWhirlwind',qSpeed=667.666992,wBase={55,85,115,145,175},wAP=.5,wEdge=true,
        wDelay=.245,wSpeed=1600,rRadius=700,eRange=800,eTurrets=true,
        eShield={80,120,160,200,240},eShieldAP=.55,eDuration=4,eDelay=0,
        source='https://wiki.leagueoflegends.com/en-us/Janna and Template:Data_Janna/Eye_of_the_Storm (read 2026-10-08)',
        -- 2026-10-10, https://wiki.leagueoflegends.com/en-us/Janna and the installed HowlingGale record
        -- (BaseRange 1100, ChargeDistancePercent 20, MissileTravelTime 1.25, MaxDuration 3): range 1100-1760 by charge,
        -- constant 1.25 s travel. R heals 25/37.5/50 (+12.5 % AP) every 0.25 s for 3 s (asset 100/150/200 +.5 AP per s).
        -- Tailwind: W deals 30 % of bonus movement speed; base movement speed 315 (wiki; the host has no base field,
        -- janna_move_speed traces settle it).
        qBaseRange=1100,qChargeRate=220,qMaxCharge=3,qTravel=1.25,
        rHeal={25,37.5,50},rHealAP=.125,rTick=.25,rChannel=3,tailwind=.3,baseMoveSpeed=315},
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
return {
 JarvanIV={id='normal',q='JarvanIVDragonStrike',w='JarvanIVGoldenAegis',e='JarvanIVDemacianStandard',r='JarvanIVCataclysm',
  qBase={90,130,170,210,250},qAD=1.45,eBase={80,120,160,200,240},eAP=.8,rAD=1.8,wRange=600,flagName='jarvanivstandard',
  qDelay=.4,eRadius=200,rBase={200,325,450},rRange=650,rArena=350,rLeap=.35,eqReach=740,eRange=860,
  wShield={60,80,100,120,140},wShieldAD=.7,wShieldHealthPerChampion=.013,wDuration=4,wDelay=0,
  source='https://wiki.leagueoflegends.com/en-us/Jarvan_IV and Template:Data_Jarvan_IV/Golden_Aegis (read 2026-10-08)'},
 Jade_JarvanIV={id='classic',q='Jade_JarvanIVDragonStrike',w='Jade_JarvanIVGoldenAegis',e='Jade_JarvanIVDemacianStandard',r='Jade_JarvanIVCataclysm',
  qBase={70,115,160,205,250},qAD=1.2,eBase={60,105,150,195,240},eAP=.8,rAD=1.5,wRange=400,wRangeWiki=600,
  qDelay=.4,eRadius=200,rBase={200,325,450},rRange=650,rArena=350,rLeap=.35,eqReach=740,eRange=860,
  wShield={50,90,130,170,210},wShieldPerChampion={20,25,30,35,40},wDuration=5,wDelay=0,
  source='https://wiki.leagueoflegends.com/en-us/League_Classic/Jarvan_IV (read 2026-10-08); shield values also research/family-assets/Jade_JarvanIV/spells.json:774-813'},
}

end
factories['jax']=function()
-- Shared Jax mechanics data. Values preserved from the maintained controller.
return {
 Jax={id='normal',q={'JaxQ','JaxLeapStrike'},w='JaxW',e={'JaxE','JaxCounterStrike'},r='JaxR',
  eBuff={'JaxCounterStrike','JaxE'},wBuff='JaxW',wBuffAliases={'JaxW','JaxEmpowerTwo'},wAttack='JaxWAttack',wBase={50,85,120,155,190},wAP=.6,wPrepare=.15,rKind='active_swing',
  -- Q 65-225 (+100% bonus AD) physical; R swing 100/175/250 (+100% AP) magic, radius 375, cast 0.25 s.
  qBase={65,105,145,185,225},qBonusAD=1,qAP=0,qKind='physical',rBase={100,175,250},rAP=1,rRadius=375,rCast=.25,
  damageSource='https://wiki.leagueoflegends.com/en-us/Jax read 2026-10-08 (last changed V26.12)',
  -- Counter Strike recast: 40-160 (+70% AP) (+4% target max HP) magic, +20% per dodged attack up to 5 (2x);
  -- dodge window 2 s, no cast time; dodges every non-turret basic attack.
  eBase={40,70,100,130,160},eAP=.7,eHP=.04,eBonusAD=0,eKind='magical',eDodgeBonus=.2,eMaxDodges=5,eDuration=2,eDelay=0,
  eSource='https://wiki.leagueoflegends.com/en-us/Jax read 2026-10-10 (last changed V26.12): E recast damage, 2 s dodge, cast time none'},
 Jade_Jax={id='classic',q={'Jade_JaxQ','Jade_JaxLeapStrike'},w='Jade_JaxW',e={'Jade_JaxE','Jade_JaxCounterStrike'},r='Jade_JaxR',
  eBuff={'Jade_JaxE'},wBuff='Jade_JaxW',wAttack='Jade_JaxWAttack',wBase={40,60,80,100,120},wAP=.2,wPrepare=.55,rKind='passive_slot',
  -- Q BaseDamage 50-150, ADRatio 1, APRatio .8 (asset); the wiki reads the AD part as bonus AD. Its damage
  -- type is not established (the wiki page contradicts itself), so qKind stays nil and the controller takes
  -- the lower of the physical and the magical result.
  qBase={50,75,100,125,150},qBonusAD=1,qAP=.8,
  damageSource='research/family-assets/Jade_Jax/spells.json Jade_JaxLeapStrike DataValues; https://wiki.leagueoflegends.com/en-us/League_Classic/Jax read 2026-10-08',
  -- W ADRatio .2 (asset); the wiki reads it as bonus AD, the lower claim.
  wBonusAD=.2,
  -- Counter Strike recast (asset Jade_JaxE DataValues: BaseDamage 50-150, ADRatio .5, PercentIncreasedPerDodge .2,
  -- MaxDodgesForDamageIncrease 5, DodgeDuration 2; no cast-time field). The wiki reads the AD part as bonus AD and
  -- the damage as physical.
  eBase={50,75,100,125,150},eAP=0,eHP=0,eBonusAD=.5,eKind='physical',eDodgeBonus=.2,eMaxDodges=5,eDuration=2,eDelay=0,
  eSource='research/family-assets/Jade_Jax/spells.json Jade_JaxE DataValues; https://wiki.leagueoflegends.com/en-us/League_Classic/Jax read 2026-10-10'},
}

end
factories['jhin']=function()
-- Shared Jhin mechanics data. Values preserved from the maintained controller.
-- Reviewed 2026-10-08: qRange 550 is an EDGE range (the wiki's "Edge range" icon on TARGET RANGE: 550; the bounce
--  EFFECT RADIUS 450 carries "Centered range"; speed 1800 / 600, cast 0.25),
--  https://wiki.leagueoflegends.com/en-us/Template:Data_Jhin/Dancing_Grenade. qRangeEdge=true tells the controller to
--  add both gameplay radii for a centre-to-centre check. Live reach is not yet measured.
return {Jhin={id='normal',q='JhinQ',w='JhinW',e='JhinE',r='JhinR',rShot='JhinRShot',
 qBase={44,69,94,119,144},qAD={.44,.515,.59,.665,.74},qAP=.6,qRange=550,qRangeEdge=true,qBounces=3,qBounce=450,qAmp=.35,
 wBase={70,105,140,175,210},wAD=.5,wRange=2500,wDelay=.75,wSpeed=5000,wRadius=40,mark='jhinespotteddebuff',
 -- E arming: asset TrapArmTime .75 against the wiki's 1 s (V26.16). Until the dev trace jhin_trap_spawn settles it,
 -- the conservative 1 s is used (an enemy freed before the trap arms walks out); eArmAsset keeps the asset value.
 -- E damage 20/80/140/200/260 +120% AD +100% AP magic, 65% to minions (asset JhinE BaseDamage/ReducedDamagePercent).
 eRange=750,eArm=1,eArmAsset=.75,eDetonation=2,eRadius=260,eTrigger=160,eSpeed=1600,eCast=.25,
 eBase={20,80,140,200,260},eAD=1.2,eAP=1,eMinion=.65,
 rBase={64,128,192},rAD=.25,rMissing=3,rFourth=2,rRange=3500,rSpeed=5000,rRadius=80,rDelay=.25,rInterval=1,rHalfAngle=30.6,
 reload='JhinPassiveReload',passive='JhinPassiveAttackBuff',reloadTime=2.5}}

end
factories['jinx']=function()
-- Shared Jinx mechanics data. Values preserved from the maintained controller.
return {Jinx={id='normal',q='JinxQ',w='JinxW',e='JinxE',r='JinxR',
 qRange={100,125,150,175,200},qSplash=250,qAD=1.1,qMana=20,qStacks=3,qStackLife=2.5,qAS={30,55,80,105,130},
 wBase={10,60,110,160,210},wAD=1.4,wRange=1450,wSpeed=3300,wRadius=60,wMin=.4,wBaseDelay=.6,wASScalar=.08,
 -- eEffect: chomper effect radius 225 (wiki Jinx V26.16, read 2026-10-10); land/arm timing stays the asset-based
 -- conservative 0.5 + d/1750 + 0.5 until the jinx_e_land trace measures it (wiki: no cast time, lands after 0.4 s).
 eRange=925,eArm=.5,eDuration=5,eSpeed=1750,eDelay=.5,eRadius=120,eEffect=225,
 rMin={20,35,50},rMax={200,350,500},rMinAD=.12,rMaxAD=1.2,rMissing={.25,.30,.35},rSplash=400,rSecondary=.8,
 -- rMonsterCap: missing-health part against monsters (spells.json JinxR MonsterExecuteMax 1200; wiki V26.16).
 rMonsterCap=1200,rRange=25000,rRadius=140,rDelay=.6,rSpeed=1700,rDamageDistance=1500}}

end
factories['karma']=function()
-- Shared Karma Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
local profiles={}
profiles['Karma']=profiles['Karma']or {}
profiles['Karma'].combat={id='normal',champion='Karma',names={{'KarmaQ'},{'KarmaSpiritBind'},{'KarmaSolKimShield'},{'KarmaMantra'}},
  -- Q missile half-width 60, Mantra missile 80 (26.20 KarmaQMissile / KarmaQMissileMantra lineWidth; dossier
  -- 2026-10-10); Soulflare explodes at the end of its 950 range in a 280 radius (wiki Karma, V26.10, read 2026-10-10).
  q={range=950,radius=60,delay=.25,speed=1700,collision=true,type='magical',base={60,110,160,210,260},ap=.7,splash=280,
   mantra={range=950,radius=80,endBlast=280}},
  w={range=675,delay=.25,type='magical',base={40,65,90,115,140},ap=.45,leash=825,duration=2},
  e={range=800,type='shield',base={80,130,180,230,280},ap=.6,duration=2.5},r={range=0},
  mantraNames={'KarmaMantra'},tetherNames={'KarmaSpiritBind'},rqBase={40,100,160,220},rqAP=.3,rqDelayed={40,130,220,310},rqDelayedAP=.5,rwMissingHeal=.17,rwHealAP=.0001,reBase={45,85,125,165},reAP=.45}
profiles['Jade_Karma']=profiles['Jade_Karma']or {}
profiles['Jade_Karma'].combat={id='classic',champion='Karma',names={{'Jade_KarmaQ','Jade_KarmaQ_C'},{'Jade_KarmaW'},{'Jade_KarmaE','Jade_KarmaE_C'},{'Jade_KarmaR'}},
  q={range=650,radius=100,cone=33,delay=.25,speed=math.huge,type='magical',base={70,110,150,190,230,270},ap=.6},
  w={range=800,delay=.25,type='magical',base={80,125,170,215,260,305},ap=.7,duration=5,lineDuration=3},
  e={range=625,type='shield',base={80,120,160,200,240,280},ap=.8,duration=5,area=500},r={range=0},
  mantraNames={'Jade_KarmaR'},mantraChargeNames={'Jade_KarmaR_Charge'},rqHeal={35,55,75,95,115,135},rqMissing=.05,rqHealAP=.0002,rCharges=2,rRecharge={30,25,20},wSpeed={.1,.12,.14,.16,.18,.2},wMantra=2}
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
return {
 Kassadin={id='normal',q='NullLance',w='NetherBlade',e='ForcePulse',r='RiftWalk',wBuff='NetherBladeBuff',
  rBuff='RiftWalk',rRange=500,rBaseCost=40,rCostKind='double',rMax=4,rDuration=15,
  qBase={65,95,125,155,185},qAP=.8,qSpeed=1400,wKind='reset',wPassiveBase=25,wPassiveAP=.1,eBase={70,100,130,160,190},eAP=.7,
  -- 2026-10-08. R: blink, range 500, cast 0.25, damage radius 270, 80/95/110 (+50% AP) (+2% max mana).
  -- Q: 1.5 s magic-damage shield 80..200 (+30% AP); interrupts channels. W active 50..150 (+80% AP), resets the attack, +50 attack range.
  -- Sources: https://wiki.leagueoflegends.com/en-us/Kassadin and research/family-assets/Kassadin/spells.json (RiftWalk CastRange/RBaseDamage/APRatio/
  -- RManaRatio, castRadius 270; NullLance ShieldAmount/ShieldDuration; NetherBlade ActiveBaseDamage). Shield AP 0.30: the asset's NullLance
  -- mSpellCalculations coefficient (295c2889) confirms the wiki (2026-10-10), so the old d7141e61=0.4 conflict is closed.
  -- 2026-10-10. R stack bonus per current stack: 35/45/55 (+7% AP) (+1% max mana), spells.json RiftWalk StackDamage/APStackRatio/
  -- RStackManaRatio and wiki V26.18. Counted with the stacks held before the cast (the lower of the two readings until measured).
  rCast=.25,rRadius=270,rBase={80,95,110},rAP=.5,rMana=.02,rSource='wiki Kassadin Riftwalk + family-assets/Kassadin/spells.json RiftWalk, 2026-10-08',
  rStack={35,45,55},rStackAP=.07,rStackMana=.01,wRangeBonus=50,
  qCast=.25,qInterrupts=true,qShield={80,110,140,170,200},qShieldAP=.3,qShieldDuration=1.5,
  qShieldSource='wiki Kassadin Null Sphere + family-assets/Kassadin/spells.json NullLance ShieldAmount/ShieldDuration, 2026-10-08',
  wBase={50,75,100,125,150},wAP=.8},
 Jade_Kassadin={id='classic',q='Jade_KassadinQ',w='Jade_KassadinW',e='Jade_KassadinE',r='Jade_KassadinR',
  wBuff='Jade_KassadinW_Buff',eCounter='Jade_KassadinE_Counter',eAvailable='Jade_KassadinE_CanCast',
  rBuff='Jade_KassadinR',rRange=700,rBaseCost=100,rCostKind='linear',rMax=10,rDuration=8,
  qBase={60,105,150,195,240},qAP=.7,qSpeed=1400,wKind='sustained',eBase={80,130,180,230,280},eAP=.7,
  -- 2026-10-08, research/family-assets/Jade_Kassadin/spells.json. R: MaxDistance 700, castRadius 270, Damage 60/70/80, APRatio 0.7. The cast
  -- delay is not a named value: both undecoded timing fields (90fb0576, 11704a2b = 0.25) and castFrame 10.3 equal the Normal RiftWalk entry,
  -- whose 0.25 s cast time the wiki confirms. Q silences (SilenceDuration 1..2 s), which ends a channel; it grants no shield.
  rCast=.25,rRadius=270,rBase={60,70,80},rAP=.7,rSource='family-assets/Jade_Kassadin/spells.json Jade_KassadinR (cast delay by field parity with RiftWalk), 2026-10-08',
  qCast=.25,qInterrupts=true},
}

end
factories['kogmaw']=function()
-- Shared KogMaw mechanics data. Values preserved from the maintained controller.
return {
 KogMaw={id='normal',qRange=1175,qSpeed=1650,qBase={80,125,170,215,260},qAP=.9,
  rBuff='kogmawlivingartillerycost',rRange={1300,1550,1800},
  rBase={100,140,180},rAD=.75,rAP={.35,.40,.45},
  -- R timing: asset castFrame 7.5 (0.25 s) = wiki "CAST TIME: 0.25"; then "drops to the target location
  -- after 0.6 seconds" (https://wiki.leagueoflegends.com/en-us/Kog'Maw, read 2026-10-08). The wiki states a
  -- landing delay after the cast time (same convention as Xerath W, Cho'Gath Q), so the total is .85 s.
  -- Before 2026-10-08 this was an unsourced .6 s total; third-party leads say 1.0-1.15 s. Not live-measured:
  -- the development r_outcome rows are the check. Radius 240 = wiki "EFFECT RADIUS: 240".
  rWindup=.25,rImpact=.6,rRadius=240,
  -- E: wiki V26.16 (read 2026-10-10) range 1360, width 240, speed 1400; asset KogMawVoidOozeMissile castRange 1360.
  eRange=1360,eSpeed=1400,
  -- Icathian Surprise (death passive): asset KogMawIcathianDisplay TooltipPassiveDuration 4, TooltipPassiveMS .4,
  -- true damage ByCharLevelInterpolation 140 -> 650 (linear over levels 1..18); radius 400 from the wiki V26.16
  -- (read 2026-10-10). Buff name kogmawicathiansurprise (shared CannotDie list).
  passive={buffs={kogmawicathiansurprise=true},duration=4,radius=400,damageStart=140,damageEnd=650}},
 -- Classic Q is UNIT-TARGETED, range 625: installed asset research/family-assets/Jade_KogMaw/spells.json
 -- `Jade_KogMawQ` has castRange 625, missileSpeed 1500, the basic attack's targeted transport and no lineWidth
 -- block (the real skillshot `Jade_KogMawE` carries lineWidth 120), which is the Season 3 spell (patch history:
 -- targeted until V4.4, range 625 since V1.0.0.118b). Disagreeing leads, recorded and not used: the wiki page
 -- https://wiki.leagueoflegends.com/en-us/League_Classic/Kog'Maw (read 2026-10-08) says range 600 and
 -- "direction-targeted"; ClassicKogMaw.lua casts a 1000-range line (the V4.4 spell). A cast on the unit inside
 -- 625 is right under either reading; only reach beyond 625 would differ, and nothing supports that.
 Jade_KogMaw={id='classic',qRange=625,qSpeed=1500,qBase={60,110,160,210,260},qAP=.7,
  rBuff='jade_kogmawrcost',rRange={1400,1700,2000},
  rBase={180,270,360},rAD=.5,rAP={.3,.3,.3},
  -- R timing: windup .25 s = Jade_KogMawR castFrame 7.5 and live castEnd-castStart
  -- (session a1ed0e46). Impact remainder .85 s is an estimate (third-party evade
  -- totals 1.1-1.2 s from cast start); no Classic impact measurement exists yet,
  -- see the development r_outcome rows. Radius 240 = asset AOERadius/castRadius.
  -- The Classic wiki page (read 2026-10-08) says "lands after 0.6 seconds" (.85 s total with the cast) and
  -- "EFFECT RADIUS: 100"; both disagree with the asset/third-party values and are recorded only. E on that
  -- page: range 1280, speed 1350 (ours 1200 / 1400 from the asset's display range and child missile).
  rWindup=.25,rImpact=.85,rRadius=240,
  -- E: asset Jade_KogMawEMissile castRange 1280 (Classic wiki 1280; its speed 1350 is recorded, the asset's 1400 used).
  eRange=1280,eSpeed=1400,
  -- Death passive: asset Jade_KogMawPassive passiveDuration 4, damage 125+25 per level; the explosion radius has no
  -- Classic source, so pursuit stays off for Classic (development trace kogmaw_passive settles duration and damage).
  passive={buffs={jade_kogmawicathiansurprise=true,jade_kogmawpassivebuff=true},duration=4,radius=nil,unknown='classic_radius_unmeasured'}},
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
factories['lulu']=function()
-- Shared Lulu mechanics data. Values preserved from the maintained controller.
-- shieldSource names where the E shield figures offered to Evade were read (2026-10-08).
return {
 Lulu={id='normal',q='LuluQ',w='LuluW',e='LuluE',r='LuluR',qBase={60,95,130,165,200},qMinion=.7,
  eBase={70,110,150,190,230},eAP=.5,shield={70,110,150,190,230},shieldAP=.5,shieldDuration=2.5,
   -- wDelay: the larger of the installed asset (.175) and the wiki W cast time (.2419, V25.16, read 2026-10-10)
   -- until the lulu_w_probe recorder settles it; a later landing only makes W interrupts stricter.
   rHealth={275,425,575},rAP=.55,wAS=true,wSpeed=2250,wAllySpeed=math.huge,eDelay=.175,wDelay=.2419,rDelay=.25,rRadius=400,
   shieldBuff='lulufaerieshield',pixEnemyBuff='luluevision',rDuration=7,rOfferAP=.55,
   rSource='https://wiki.leagueoflegends.com/en-us/Lulu Wild Growth: +275/425/575 (+55% AP) health for 7 s, range 900, no cast time (read 2026-10-08); rDelay is the installed timing (later start = safe side)',
   shieldSource='https://wiki.leagueoflegends.com/en-us/Lulu Help, Pix!: 70-230 (+50% AP), 2.5 s, no cast time (read 2026-10-08); eDelay is the installed asset timing',
   -- Ally attack steroids W answers (native cast names, lower case): spell names in the installed assets
   -- research/family-assets/<Champion>/spells.json (read 2026-10-10). A name the host does not report never matches.
   wSteroids={twitchfullautomatic=true,vayneinquisition=true,kogmawbioarcanebarrage=true,asheq=true,kaisae=true,tristanaq=true,xayahw=true,highlander=true},
   -- Engage states that are neither channels nor dashes (buff names, lower case; same asset spell names). Logged by
   -- the lulu_engage_state recorder; a name the host does not use never matches.
   wEngage={hecarimramp=true,powerball=true,highlander=true,kaisae=true,swainr=true,neekor=true}},
 Jade_Lulu={id='classic',q='Jade_LuluQ',w='Jade_LuluW',e='Jade_LuluE',r='Jade_LuluR',qBase={80,125,170,215,260},qMinion=1,
  eBase={80,130,180,230,280},eAP=.6,shield={60,105,150,195,240},shieldAP=.4,shieldDuration=6,
   rHealth={300,450,600},rAP=.5,wAS=false,wSpeed=2250,wAllySpeed=2000,eDelay=.175,wDelay=.175,rDelay=.25,rRadius=400,
   shieldBuff='Jade_LuluFaerieShield',pixEnemyBuff='Jade_LuluFaerieBurn',rDuration=7,rOfferAP=0,
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
return {
 Lux={id='normal',qCast='LuxLightBinding',wCast='LuxPrismaticWave',eCast='LuxLightStrikeKugel',
  eToggle='LuxLightstrikeToggle',rCast='LuxR',mark={'LuxIlluminatingFraulein'},
  -- Q: 80-240 +75% AP; roots the first TWO enemies for 2 s, both at full damage (no second-target factor).
  qBase={80,120,160,200,240},qAP=.75,qSecond=1,qRoot=2,qSecondRoot=2,qRange=1175,qSpeed=1200,qRadius=70,qDelay=.25,
  -- W: 40-100 +40% AP for 2.5 s, out and back (a unit passed twice holds two shields; one is offered).
  wBase={40,55,70,85,100},wAP=.4,wRange=1100,wSpeed=2200,wRadius=110,wDelay=.25,wDuration=2.5,
  wSource='Normal W 40/55/70/85/100 +40% AP, 2.5 s, cast .25: research/family-assets/Lux/spells.json (LuxPrismaticWave BaseShieldAmount, APRatio, ShieldDuration) and https://wiki.leagueoflegends.com/en-us/Lux (read 2026-10-10, V26.04)',
  -- E: 65-265 +80% AP, asset radius 295 (wiki 310), range 1100, missile 1300, zone 5 s.
  eBase={65,115,165,215,265},eAP=.8,eRange=1100,eSpeed=1300,eRadius=295,eDelay=.25,eZone=5,
  -- Normal Lux cannot recast during Final Spark's cast; only Classic 26.17 allows the detonation then.
  eDuringR=false,
  -- R: 300/400/500 +120% AP, 1 s cast, half-width 95 (asset lineWidth 190; wiki 200).
  rBase={300,400,500},rAP=1.2,rRange=3340,rRadius=95,rDelay=1,
  -- Illumination: 20 + 10 per level (+35% AP), mark 6 s, consumed by an attack or R.
  pFlat=20,pLevel=10,pAP=.35,pMark=6},
 Jade_Lux={id='classic',qCast='Jade_LuxLightBinding',wCast='Jade_LuxPrismaticWave',eCast='Jade_LuxLightStrikeKugel',
  eToggle='Jade_LuxLightstrikeToggle',rCast='Jade_LuxR',mark={'Jade_LuxIlluminatingFraulein','LuxIlluminatingFraulein'},
  -- Q: 60-260 +70% AP; passes one unit, the second takes half damage and a 1 s root.
  qBase={60,110,160,210,260},qAP=.7,qSecond=.5,qRoot=2,qSecondRoot=1,qRange=1175,qSpeed=1200,qRadius=70,qDelay=.25,
  -- Shield numbers for the Evade offer. Lux herself is shielded when the cast starts (Classic Patch 2:
  -- "Shield now occurs at cast time instead of after cast time"); the offer still declares the full
  -- .25 s cast, so its window starts late rather than early. The wiki lists range 1175 and speed 2400
  -- and the asset shows display range 1150 / missile 1200: wRange and wSpeed are the maintained
  -- conservative values and only decide the ally reach, not the self shield.
  wBase={80,105,130,155,180},wAP=.35,wRange=1100,wSpeed=1400,wRadius=110,wDelay=.25,wDuration=3,
  wSource='Classic W 80/105/130/155/180 +35% AP, 3 s, cast .25: research/family-assets/Jade_Lux/spells.json (BaseShieldAmount, APRatio, ShieldDuration) and https://wiki.leagueoflegends.com/en-us/League_Classic/Lux (2026-10-08)',
  eBase={60,105,150,195,240},eAP=.6,eRange=1000,eSpeed=1300,eRadius=350,eDelay=.25,eZone=5,
  eDuringR=true,
  rBase={300,400,500},rAP=.85,rRange=3340,rRadius=95,rDelay=1,
  -- Illumination: 20 at level 1 to 190 at level 18, no AP (asset calc {20,190}, linear by level assumed).
  pFlat=10,pLevel=10,pAP=0,pMark=6},
}

end
factories['malphite']=function()
-- Shared Malphite mechanics data. Values preserved from the maintained controller.
return {
 Malphite={id='normal',q='SeismicShard',w='Obduracy',e='Landslide',r='UFSlash',shield='MalphiteShield',
   wKind='reset_splash',wDuration=5,qBase={70,120,170,220,270},qAP=.6,eBase={60,95,130,165,200},eAP=.6,eArmor=.4,
   -- Unstoppable Force. The speed is 1500 + 100% movement speed (base 335 = 1835); a registration takes fixed
   -- numbers, so rSpeeds is a bracket whose slow end (a roughly 40% slowed Malphite) is the safety margin.
   rBase={200,300,400},rAP=.9,rRange=1000,rSpeeds={1700,1835},rDelays={0},
   rSource='https://wiki.leagueoflegends.com/en-us/Malphite Unstoppable Force: range 1000, no cast time, speed 1500 + 100% movement speed, 200/300/400 (+90% AP), base movement speed 335 (read 2026-10-08)',
   -- 2026-10-10 (wiki Malphite V26.09 read 2026-10-10; spells.json UFSlash KnockupDuration, Obduracy Thunderclap*).
   -- R prediction speed 1500 + current movement speed (rBaseSpeed), knock-up 1.5 s. Hit radius 270 (asset castRadius) is
   -- kept for counting; the wiki's 325 effect radius waits for the malphite_r_landing dev trace (rEffectRadius unused).
   -- W Thunderclap on-hit 30/40/50/60/70 (+20% AP) (+15% armor) physical while W is active.
   rBaseSpeed=1500,rKnockup=1.5,rRadius=270,rEffectRadius=325,wOnHit={30,40,50,60,70},wOnHitAP=.2,wOnHitArmor=.15},
 Jade_Malphite={id='classic',q='Jade_MalphiteSeismicShard',w='Jade_MalphiteObduracy',e='Jade_MalphiteLandslide',r='Jade_MalphiteUFSlash',shield='Jade_MalphiteShield',
   wBuff='Jade_MalphiteObduracyBuff',wKind='ad_armor_boost',wDuration=6,qBase={70,120,170,220,270},qAP=.6,eBase={60,100,140,180,220},eAP=.2,eArmor=.3,
   -- The Classic page gives the same dash shape as Normal (the asset holds only castRange 1000, spells.json:496).
   rBase={200,300,400},rAP=1,rRange=1000,rSpeeds={1700,1835},rDelays={0},
   rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Malphite Unstoppable Force: range 1000, no cast time, speed 1500 + 100% movement speed, 200/300/400 (+100% AP), base movement speed 335 (read 2026-10-08)',
   -- 2026-10-10 (wiki League_Classic/Malphite edited 2026-09-22, read 2026-10-10; spells.json Jade_MalphiteUFSlash
   -- KnockupDuration, Jade_MalphiteObduracy ADBonus 0.20..0.40 for 6 s). Same dash model and counting radius as Normal.
   rBaseSpeed=1500,rKnockup=1.5,rRadius=270,rEffectRadius=325,wAD={.2,.25,.3,.35,.4}},
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
return {
    normal={id='normal',wReset=true,q='AlphaStrike',w='Meditate',e='WujuStyle',r='Highlander',qType='physical',qBase={20,40,60,80,100},qAD=.7,qMonster={60,85,110,135,160},
      eBase={20,25,30,35,40},eBonusAD=.35,eActive='WujuStyleSuperCharged',eDuration=5,rDuration=7,dsRatio=.5,dsCount=4,dsDuration=4,
      qBounce=550,qImpact=.26,wDelay=3.25/30,wChannel=4,wInitialSeconds=.5,wInitial={.7,.7,.7,.7,.7},wReduction={.45,.475,.5,.525,.55},
      wSource='MasterYi spells.json Meditate castFrame 3.25, DamageReduction+InitialExtraDR (.5 s), HealDuration 4; wiki Master_Yi V26.19 read 2026-10-10'},
    classic={id='classic',wReset=true,q='Jade_MasterYiAlphaStrike',w='Jade_MasterYiMeditate',e='Jade_MasterYiWujuStyle',r='Jade_MasterYiHighlander',qType='magical',qBase={100,150,200,250,300},
        -- research/family-assets/Jade_MasterYi/spells.json Jade_MasterYiAlphaStrike TotalMonsterDamage (rank 1-5)
        -- with MonsterDamageProcChance .5: a random proc, so farming never counts it as certain.
        qMonster={260,320,380,440,500},qAP=1,eActive='Jade_MasterYiWujuStyleSuperCharged',eDuration=10,ePassive={15,20,25,30,35},rDuration={8,10,12},
        qBounce=550,qImpact=.26,wDelay=3.25/30,wChannel=5,wResist={100,150,200,250,300},
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
-- Normal E: 8.75/12.5/16.25/20/23.75 (+15% AP) magic per tick, every .25 s for 2 s (asset BaseDamagePerSecond/4,
--   APRatioPerSecond .6/4, TicksPerSecond 4, BaseDuration 2), slow 40% (+6% per 100 AP), cast delay .25.
-- Classic E: asset BaseDamage 95/155/215/275/335 (+80% AP) read as the TOTAL over 2 s in 8 ticks (the smaller
--   reading; the field could be per second), MoveSpeedMod -.20/-.28/-.36/-.44/-.52, Duration 2.
-- Normal W: casting grants full Strut at once, +60/70/80/90/100 flat movement speed (wiki; asset PassiveMaxMS), kept until
--   she takes non-periodic damage. wHasteSeconds 2 is a conservative planning bound for Evade (the bonus can last
--   longer). Cast delay: asset castFrame 8 (30 fps, .267 s) as the upper bound. Classic W has no movement speed
--   (asset Jade_MissFortuneViciousStrikes: ASMod, Grievous; the Classic Strut is the uncastable passive).
-- Normal R: 30 deg cone, 1450 effect radius (wiki; asset geometry 34 deg, the narrower is used for occupancy), first wave
--   .066 s after the channel starts, waves .2036/.1781/.1583 s apart (wiki). Classic: no published cone or wave timing.
return {
 normal={id='normal',qReach='attack',qCrit=1.5,qCritIE=.15,ieItem=3031,
  loveTap={base=.5,step=.1,levels={4,7,9,11,13,20,25,30},minion=.5},
  tiers={{range=500,angle=20},{range=500,angle=40},{range=500,angle=110},{range=150,angle=160}},
  eTick={8.75,12.5,16.25,20,23.75},eTickAP=.15,eTicks=8,eInterval=.25,eSlow=.4,eSlowAP=.0006,eDelay=.25,
  wHaste={60,70,80,90,100},wHasteSeconds=2,wDelay=8/30,
  wSource='MissFortune spells.json MissFortuneViciousStrikes PassiveMaxMS 60-100, castFrame 8; wiki Miss_Fortune Strut read 2026-10-10 (full Strut on cast); 2 s planning bound',
  rAngle=30,rRange=1450,rFirstWave=.066,rInterval={.2036,.1781,.1583}},
 classic={id='classic',qReach=650,
  eTotal={95,155,215,275,335},eAP=.8,eTicks=8,eInterval=.25,eSlowRank={.2,.28,.36,.44,.52},eDelay=.25,
  rAngle=30,rRange=1400},
}

end
factories['monkeyking']=function()
-- Shared MonkeyKing mechanics data. Values preserved from the maintained controller.
return {
 MonkeyKing={id='normal',q='MonkeyKingDoubleAttack',w='MonkeyKingDecoy',e='MonkeyKingNimbus',r='MonkeyKingSpinToWin',leave='MonkeyKingSpinToWinLeave',
  qAttack='MonkeyKingQAttack',qBase={20,45,70,95,120},qBonusAD=.5,qTotalAD=1,qBonusRange={135,145,155,165,175},
  eBase={80,120,160,200,240},eAP=1,eAD=0,eKind='magical',eExtra=700,eBuff='MonkeyKingNimbusAS',
  stealth='MonkeyKingDecoyStealth',cloneDuration=4,stealthDuration=1,wRange=300,wMin=100,wSpeed=900,wDelay=.3,
  cloneRatio={.4,.45,.5,.55,.6},rRecast='MonkeyKingSpinRecast',spinDuration=2,recastWindow=8,rLockout=1,rRadius=315,
  passive='MonkeyKingPassiveStack',maxStacks=5,
  -- The wiki gives no cast time; wDelay=.3 is the kept controller timing. Evade is given both and must be safe under either.
  -- Nimbus Strike: asset MonkeyKingNimbus DashSpeed 1050, EndPointOffsetDistance 75, castRange 650 (read 2026-10-10,
  -- installed asset, not live-verified). Offered to Evade as a unit dash next to W (SDK.ChampionMobility alternatives);
  -- development own_dash records confirm the figures in play.
  eDash={speed=1050,offset=75,range=650,source='research/family-assets/MonkeyKing/spells.json MonkeyKingNimbus DashSpeed 1050, EndPointOffsetDistance 75, castRange 650 (2026-10-10)'},
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
  q={range=1300,reach=1175,radius=70,delay=.25,speed=1200,collision=true,type='magical',base={80,135,190,245,300},ap=.9,root={2,2.25,2.5,2.75,3}},
  w={range=900,radius=280,circle=true,delay=.25,speed=math.huge,type='magical',base={18,31,44,57,70},ap=.2,duration=5,tick=.5,missingAmp=1,monster=1.7,refund=.05},
  e={range=800,type='shield',base={100,155,210,265,320},ap=.7,duration=5},
  r={range=625,cast=575,delay=.35,type='magical',base={200,275,350},ap=.8,tether=3,stun={1.5,1.75,2},slow=.2,haste={.2,.4,.6}},
  ccDashes={sejuaniq=true,gragase=true,viq=true,ufslash=true,leonazenithblade=true,headbutt=true,poppye=true,rakanw=true,
   ornne=true,galioe=true,shene=true,hecarimult=true,zace=true,camillee=true,rellw_dismount=true}}
profiles['Jade_Morgana']=profiles['Jade_Morgana']or {}
profiles['Jade_Morgana'].combat={id='classic',champion='Morgana',names={{'Jade_MorganaQ'},{'Jade_MorganaW'},{'Jade_MorganaE'},{'Jade_MorganaR'}},rawModifier=soilDamage,
  q={range=1300,reach=1175,radius=70,delay=.25,speed=1200,collision=true,type='magical',base={80,135,190,245,300},ap=.9,root={2,2.25,2.5,2.75,3}},
  w={range=900,radius=280,circle=true,delay=.25,speed=math.huge,type='magical',base={25,40,55,70,85},ap=.2,duration=5,mrShred={4,5,6,7,8}},
  e={range=750,type='shield',base={100,150,200,250,300},ap=.7,duration=5},
  r={range=625,cast=575,delay=.35,type='magical',base={175,250,325},ap=.7,tether=3,stun=1.5,slow=.2},
  ccDashes={jade_alistarw=true,jade_poppye=true,jade_shene=true,jade_malphiteufslash=true,jade_leonazenithblade=true,jade_gragase=true,
   jade_rammusq=true,jade_jarvanivdragonstrike=true}}
return profiles

end
factories['nami']=function()
-- Shared Nami mechanics data. Values preserved from the maintained controller.
return {
 Nami={id='normal',q='NamiQ',w='NamiW',e='NamiE',r='NamiR',eBuff='NamiE',spellE=true,
  qBase={90,145,200,255,310},qAP=.5,wDamage={60,95,130,165,200},wHeal={55,80,105,130,155},healAP=.4,
  eBase={20,35,50,65,80},bounce=-.20,bounceAP=.0015,healBounce=nil,rAP=.6,
  -- Finisher timing (wiki https://wiki.leagueoflegends.com/en-us/Nami read 2026-10-10): Q lands .99 s after the cast
  -- starts, W cast .25 s and bolt speed 2500, R cast .5 s and wave speed 850.
  qImpact=.99,wCast=.25,wSpeed=2500,rSpeed=850},
 Jade_Nami={id='classic',q='Jade_NamiQ',w='Jade_NamiW',e='Jade_NamiE',r='Jade_NamiR',eBuff='Jade_NamiE',spellE=false,
  qBase={75,130,185,240,295},qAP=.65,wDamage={70,110,150,190,230},wHeal={65,95,125,155,185},healAP=.3,
  eBase={25,40,55,70,85},bounce=-.30,bounceAP=0,healBounce=-.15,
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
return {
 Nasus={id='normal',q={'NasusQ'},qBuff='NasusQ',stacks='NasusQStacks',qAttack='NasusQAttack',
  w='NasusW',e='NasusE',r='NasusR',qBase={30,50,70,90,110},eBase={50,80,110,140,170},
   qRangeBonus=50,stackSmall=4,stackLarge=10,eDelay=.25,eAP=.6,eArmorKind='percent',eArmor={30,35,40,45,50},
   -- Q 30..110 and E 50..170 (+60% AP) confirmed; area and burn from the same page.
   eRadius=400,eTick={10,16,22,28,34},eTickAP=.12,eDuration=5,source='https://wiki.leagueoflegends.com/en-us/Nasus (read 2026-10-08)',
   -- E initial hit lands 0.264 s after the cast; R bonus health, cast and duration; W range (wiki V26.19, read 2026-10-10).
   eBurstDelay=.264,wRange=700,rHealth={300,450,600},rCast=.2,rDuration=15,
   -- Wards give Q stacks. Damage of one melee hit on a ward is not measured: only a ward at 1 health counts as a sure kill.
   wardKillHealth=1,rSource='https://wiki.leagueoflegends.com/en-us/Nasus (V26.19, read 2026-10-10): R +300/450/600 health, cast 0.2 s, 15 s'},
 Jade_Nasus={id='classic',q={'Jade_NasusQ','Jade_NasusSiphoningStrike'},qBuff='Jade_NasusQ',
  stacks='Jade_NasusQStacks',qAttack='Jade_NasusSiphoningStrikeAttack',
  w='Jade_NasusW',e='Jade_NasusE',r='Jade_NasusR',qBase={30,50,70,90,110},eBase={55,95,135,175,215},
   qRangeBonus=0,stackSmall=3,stackLarge=6,eDelay=.325,eAP=.6,eArmorKind='flat',eArmor={20,25,30,35,40},
   eRadius=400,eTick={11,19,27,35,43},eTickAP=.12,eDuration=5,source='https://wiki.leagueoflegends.com/en-us/League_Classic/Nasus (read 2026-10-08)',
   -- League_Classic/Nasus read 2026-10-10: E initial damage 0.264 s after the cast; R cast 0.2 s, 15 s, +300/450/600
   -- health kept after the duration (offered for the 15 s only); W range 700.
   eBurstDelay=.264,wRange=700,rHealth={300,450,600},rCast=.2,rDuration=15,
   wardKillHealth=1,rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Nasus (read 2026-10-10): R +300/450/600 health, cast 0.2 s, 15 s'},
}

end
factories['nautilus']=function()
-- Shared Nautilus mechanics data. Values preserved from the maintained controller.
return {
 Nautilus={id='normal',q='NautilusAnchorDrag',w='NautilusPiercingGaze',e='NautilusSplashZone',r='NautilusGrandLine',
  rCast='NautilusGrandLineStart',shield='NautilusPiercingGazeShield',passive='NautilusPassiveCheck',root='NautilusPassiveRoot',
  qRoot='NautilusAnchorDragRoot',passiveCD=6,qBase={85,125,165,205,245},qAP=.9,eBase={55,90,125,160,195},eRange=600,eArea=600,
   rBase={150,275,400},
   -- Wiki Nautilus read 2026-10-10: Q reach 1122 (asset display range 1150), radius 90, speed 2000, cast .25; R cast .46,
   -- homing charge 275 units/s accelerating by 466.67 units/s per second, eruption radius 225 (knock-back band 300);
   -- Q is a 1 s stun. qControl lists the own Q-control buff names E and R wait for (the stun's native name is
   -- unconfirmed: dev trace nautilus_hook_buffs records the hooked target's buffs).
   qRange=1122,qRadius=90,qSpeed=2000,qCast=.25,rCast=.46,rSpeed=275,rAccel=466.67,rRadius=225,
   qControl={'NautilusAnchorDragRoot'},
   geometrySource='https://wiki.leagueoflegends.com/en-us/Nautilus (read 2026-10-10)'},
 Jade_Nautilus={id='classic',q='Jade_NautilusQ',w='Jade_NautilusW',e='Jade_NautilusE',r='Jade_NautilusR',
  rCast='Jade_NautilusR_Start',shield='Jade_NautilusW_Shield',passive='Jade_NautilusPassive_Check',root='Jade_NautilusPassive_Root',
  qRoot='Jade_NautilusQ_Root',passiveCD=9.75,qBase={60,105,150,195,240},qAP=.75,eBase={60,100,140,180,220},eRange=400,eArea=550,
   rBase={200,325,450},
   -- League_Classic/Nautilus read 2026-10-10: same Q (1122, width 180, speed 2000) and R geometry/charge as Normal;
   -- R cast .46, speed 275 + 466.67 per second, radius 225/300 (Classic page). Q is a 1 s stun there too.
   qRange=1122,qRadius=90,qSpeed=2000,qCast=.25,rCast=.46,rSpeed=275,rAccel=466.67,rRadius=225,
   qControl={'Jade_NautilusQ_Root'},
   geometrySource='https://wiki.leagueoflegends.com/en-us/League_Classic/Nautilus (read 2026-10-10)'},
}

end
factories['nidalee']=function()
-- Shared Nidalee mechanics data. Values preserved from the maintained controller.
return {
 Nidalee={id='normal',q='JavelinToss',w='Bushwhack',e='PrimalSurge',r='AspectOfTheCougar',
  cougar={'Takedown','Pounce','Swipe'},ranks=4,healRange=900,heal={50,75,100,125,150},healAP=.35,
  spear={70,90,110,130,150},spearAP=.5,spearMultiplier=3.25,spearRadius=40,hunt='nidaleepassivehunted',
  swipe={70,130,190,250},swipeAP=.55,swipeBonusAD=.7,pounce={55,100,145,190},pounceAP=.3,
  takedown={5,30,55,80},takedownAD=.75,takedownAP=.4,trapDuration=4,
  -- Bushwhack arms 1.5 s after it lands (wiki https://wiki.leagueoflegends.com/en-us/Nidalee read 2026-10-10).
  trapArm=1.5},
 Jade_Nidalee={id='classic',q='Jade_NidaleeJavelinToss',w='Jade_NidaleeBushwhack',e='Jade_NidaleePrimalSurge',r='Jade_NidaleeAspectOfTheCougar',
  cougar={'Jade_NidaleeTakedown','Jade_NidaleePounce','Jade_NidaleeSwipe'},ranks=3,healRange=575,heal={50,85,120,155,190},healAP=.7,
  spear={55,95,140,185,230},spearAP=.65,spearMultiplier=2.5,spearRadius=60,
  swipe={150,225,300},swipeAP=.6,pounce={125,175,225},pounceAP=.4,
  takedown={40,70,100},takedownAD=1,takedownAP=0,trapDuration=2.5,
  -- No Classic arm time is published: the Normal 1.5 s is used only as a stricter placement bound (a trap thrown
  -- under shorter control was the earlier rule); it is not a Classic mechanic claim.
  trapArm=1.5,trapArmBound=true},
}

end
factories['pantheon']=function()
-- Pantheon numbers the shared row in CombatProfiles/abilities.lua (M.controllers.Pantheon, not edited by the
-- champion work) does not carry. The controller overlays these on a private copy of that row.
return {
 -- https://wiki.leagueoflegends.com/en-us/Pantheon read 2026-10-10: Q cast 0.2 s (the shared geometry row says .25),
 -- hurl +50% AP (execute +100% AP), the thrust has no AP ratio, the 50% hurl reduction applies only beyond the first
 -- unit hit; W +1.5% maximum health per 100 AP; Mortal Will empowered Q bonus 20-265.88 by level (standard growth
 -- curve assumed between the two ends); E channel 1.5 s, 60 degree cone, non-turret damage from the front blocked,
 -- strikes 1/12 of total AD every 0.125 s (100% AD over the channel), recast after 0.3 s or automatically at the end:
 -- slam 0.25 s cast, cone radius 525, 55-255 (+150% bonus AD).
 Pantheon={qCast=.2,qFlightSpeed=2700,qFlightRadius=55,qHurlAP=.5,qExecuteAP=1,wHPPerAP=.00015,
  mortalWillMin=20,mortalWillMax=265.88,eBlockAngle=60,eBlockDuration=1.5,eStrikeAD=1/12,eStrikeInterval=.125,eStrikesMax=12,
  eSlamRadius=525,eSlamCast=.25,eRecastAfter=.3,
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
local profiles={}
profiles['Quinn']=profiles['Quinn']or {}
profiles['Quinn'].combat={id='normal',champion='Quinn',names={{'QuinnQ'},{'QuinnW'},{'QuinnE'},{'QuinnR','QuinnRChannel','QuinnRFinale','QuinnRReturnToQuinn'}},
  q={range=1050,radius=60,delay=.25,speed=1550,collision=true,type='physical',base={65,100,135,170,205},bonusAD={.8,.85,.9,.95,1},ap=.5,monster=2,explosion=210},
  w={range=2100,duration=2},e={range=600,type='physical',base={40,65,90,115,140},bonusAD=.2},r={range=700,margin=25,type='physical',base={60,90,120},bonusAD=.35},
  flightName='QuinnRFinale',channelName='QuinnRReturnToQuinn',eSpeeds={2500,850},eLanding=525,
  markNames={'QuinnW','QuinnPassive'},travelNames={'QuinnR'},passiveLevel={15,120},passiveAD=.4,passiveMonster=75,rChannel=2,rArrival=650}
profiles['Jade_Quinn']=profiles['Jade_Quinn']or {}
profiles['Jade_Quinn'].combat={id='classic',champion='Quinn',names={{'Jade_QuinnQ','Jade_QuinnQMelee'},{'Jade_QuinnW'},{'Jade_QuinnE'},{'Jade_QuinnR','Jade_QuinnRChannel','Jade_QuinnRFinale','Jade_QuinnRReturnToJade_Quinn'}},
  q={range=1025,radius=80,delay=.25,speed=1550,collision=true,type='physical',base={70,110,150,190,230},bonusAD=.65,ap=.5,melee=300,explosion=210},
  w={range=1950,duration=2},e={range=700,type='physical',base={40,70,100,130,160},bonusAD=.2},
  r={range=700,margin=25,type='physical',base={100,150,200},bonusAD=.5},channelName='Jade_QuinnRReturnToJade_Quinn',eLanding=525,markNames={'Jade_QuinnPassive'},valorNames={'Jade_QuinnR'},valorQ='Jade_QuinnQMelee',valorDuration=20,valorAttackRange=-400,
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
return {
 Rammus={id='normal',q='PowerBall',qCancel='PowerBallCancel',w='DefensiveBallCurl',e='PuncturingTaunt',r='Tremors2',
  qBuff='PowerBall',wBuff='DefensiveBallCurl',eBuff='PuncturingTaunt',qDuration=6,wDuration=7,rKind='landing',rRadius=400,
  qBase={80,120,160,200,240},qAP=1,eMonster={80,100,120,140,160},eAP=.7,
  -- Soaring Slam landing damage and the prediction model. rDelay is the asset cast delay (the wiki says "no cast
  -- time"; the larger value is kept until the rammus_slam_flight trace settles it); rSpeed is the asset
  -- MinDashSpeed lower bound (the dash runs 900-2000). rRange is the base range; 150% of the average movement
  -- speed above 461.5 is not used until rammus_slam_flight records accepted landings beyond 800.
  rBase={150,250,350},rAP=.6,rDelay=.25,rSpeed=900,rRange=800,qKnockback=125,
  rSource='family-assets/Rammus/spells.json Tremors2 InitialDamage/APRatio/MinDashSpeed/BaseCastRange/11704a2b + wiki.leagueoflegends.com/en-us/Rammus (V26.01), read 2026-10-10',
  -- Defensive Ball Curl: flat plus a share of total armor / magic resistance.
  wArmor={27,32,37,42,47},wArmorShare={.3,.375,.45,.525,.6},wMR={20,25,30,35,40},wMRShare={.3,.375,.45,.525,.6},wDelay=.25,
  wSource='family-assets/Rammus/spells.json DefensiveBallCurl FlatBonusArmor/BonusArmorPercent/FlatBonusMR/BonusMRPercent/BuffDuration/11704a2b + wiki en-us/Rammus, read 2026-10-10'},
 Jade_Rammus={id='classic',q='Jade_RammusQ',w='Jade_RammusW',e='Jade_RammusE',r='Jade_RammusR',
  wAlias='Jade_Rammus_DefensiveBallCurl',eAlias='Jade_Rammus_PuncturingTaunt',rAlias='Jade_Rammus_Tremors2',
  qBuff='Jade_RammusQ',wBuff='Jade_RammusW',eBuff='Jade_RammusE',qDuration=7,wDuration=6,rKind='tremors',
  -- Installed asset castRadius 375; the Classic wiki page says 385. The smaller asset value is kept (it never
  -- counts an enemy the area misses); the rammus_tremors_hits trace records hit distances to settle it.
  rRadius=375,
  qBase={100,150,200,250,300},qAP=1,
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
return {Rell={id='normal',q='RellQ',w='RellW_Dismount',w2='RellW_MountUp',e='RellE',r='RellR',
 qBase={60,100,140,180,220},qAP=.6,qRange=600,qForward=520,qBehind=220,qStep=100,qRadius=75,qDelay=.4,qStun=.65,
 -- Crash Down reach, 2026-10-08: https://wiki.leagueoflegends.com/en-us/Rell "Target range 100 - 400", effect radius 180,
 -- cast 0.625, slide 320 over 0.5 s; patch 13.11 notes also give a 400 jump. The installed asset's
 -- castRangeDisplayOverride is 450 (kept as wDisplayRange, the drawn indicator); casts are planned inside 400.
 -- The leap itself has no published speed (the page describes it as happening over the cast time).
 wBase={60,90,120,150,180},wAP=.6,w2Base={10,25,40,55,70},w2AP=.4,wRange=400,wMinRange=100,wDisplayRange=450,wSlide=320,wRadius=180,wDelay=.625,
 -- Mount Up empowers the next attack for 3.5 s with 100 bonus range (same page). The two buff names are leads from a
 -- reference script (zgRell), not live verified: a name that never appears simply never triggers its rule.
 wAttackWindow=3.5,wAttackRange=100,wAttackBuff='rellwempoweredattack',wKnockupBuff='rellw_knockup',
 shieldBase={20,40,60,80,100},shieldHP=.11,wResist=.15,wKnockup=.4,wStun=.8,w2Stun=.6,
 eRange=1200,ePct={.05,.055,.06,.065,.07},eAP=.0003,eDuration=3,eBuffer=2,eRadius=300,eFast=.3,eSlow=.15,
 -- Full Tilt monster/structure cap by level (Rell-5): installed asset RellE mSpellCalculations 1925773807 =
 -- level curve 150 -> 300 (read 2026-10-10). The wiki (V14.23) lists 150-317.65; the installed asset wins.
 eMonsterCap={150,300},
 -- Mount Up speed burst (S6 haste offer): asset RellW_MountUp HasteTooltip/RellW_Dismount MountUpSpeed .3 with a 2 s
 -- decay (calc 2803503575), wiki en-us/Rell "+30% decaying over 2 s", read 2026-10-10.
 mountHaste=.3,mountHasteDecay=2,
 mountSource='family-assets/Rell/spells.json RellW_Dismount MountUpSpeed + RellW_MountUp calc 2803503575 (2 s) + wiki en-us/Rell, read 2026-10-10',
 rDPS={75,125,175},rAP=.55,rDuration=2,rInitial=425,rRadius=375,rHorizon=225,rForce=300,
 passive='rellp_debuff',maxStacks=5,passivePct=.03,passiveLife=5,refreshLife=3.5,
 mounted='rellw_mountedbuff',dismounted='rellw_dismountedbuff',shield='rellw_shield',eEmpower='relle_empowerself',storm='rellr'}}

end
factories['ryze']=function()
-- Ryze mechanics added by the 2026-10-10 ranking work. Damage, ranges and speeds stay in abilities.lua
-- (AbilityProfiles.controllers.Ryze and the geometry rows); this file holds only the numbers those rows lack.
-- Every row names its installed-asset field and the wiki page read that day; Normal and Classic are read from
-- their own assets (research/family-assets/Ryze, Jade_Ryze) and never borrowed. See ryze-provenance.json.
return {
 Ryze={id='normal',
  -- Bonus mana (Q/W/E scale with it, 2%/3%/2%): base mana 300 + 70 per level on the standard growth curve.
  manaBase=300,manaGrowth=70,manaSource='wiki Template:Data_Ryze mp_base 300 / mp_lvl 70, read 2026-10-10',
  -- Two Runes consumed by Q: +28..44% movement speed for 2 s; Runes last 4 s.
  runeHaste={.28,.32,.36,.40,.44},runeHasteDuration=2,runeLife=4,
  runeSource='family-assets/Ryze/spells.json RyzeQWrapper MovementSpeedAmount/MovementSpeedDuration/RuneDuration + wiki Overload, read 2026-10-10',
  -- E spread: 350 to small units, 400 to large ones (asset BounceRadius/BounceRadiusLargeUnit). Counting uses the
  -- smaller, collateral checks the larger. Q spread off a marked unit: 350 small / 500 large (BounceRadiusQ*).
  eBounceMin=350,eBounceMax=400,qBounceSmall=350,qBounceLarge=500,
  bounceSource='family-assets/Ryze/spells.json RyzeE BounceRadius/BounceRadiusLargeUnit/BounceRadiusQSmallUnit/BounceRadiusQLargeUnit, read 2026-10-10',
  -- Realm Warp: 1000 minimum, 3000 maximum.
  rMin=1000,rMax=3000,rRangeSource='family-assets/Ryze/spells.json RyzeR MinimumCastRange/castRange + wiki en-us/Ryze, read 2026-10-10'},
 Jade_Ryze={id='classic',
  -- E bounces: 350 from the missile (small units), 400 on the spell and for large units; at most 5 hits.
  eBounceMin=350,eBounceMax=400,eMaxHits=5,
  bounceSource='family-assets/Jade_Ryze/spells.json Jade_RyzeEMissile BounceRadius 350/BounceRadiusLargeUnit 400, Jade_RyzeE BounceRadius 400/MaximumHits 5, read 2026-10-10',
  -- E magic resistance reduction while marked (applied to the follow-up only once our mark is seen).
  eShred={12,15,18,21,24},eShredSource='family-assets/Jade_Ryze/spells.json Jade_RyzeE ResistShred + wiki League_Classic/Ryze, read 2026-10-10',
  -- Desperate Power: flat movement speed and duration by rank, no cast time.
  rHaste={60,70,80},rDuration={5,6,7},rSource='family-assets/Jade_Ryze/spells.json Jade_RyzeR MovementSpeed/Duration + wiki League_Classic/Ryze, read 2026-10-10'},
}

end
factories['seraphine']=function()
-- Shared Normal Seraphine data; no Classic mechanics are inferred.
return {
 Seraphine={id='normal',q='SeraphineQ',w='SeraphineW',e='SeraphineE',r='SeraphineR',
  qBase={60,85,110,135,160},qAP=.4,eBase={70,100,130,160,190},eAP=.5,eMinion=.7,
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
  rBase={150,200,250},rAP=.4,shield={60,80,100,120,140},shieldAP=.2,shieldDuration=2.5,heal={8,10,12,14,16},
  shieldSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Seraphine/Surround_Sound (shield 60/80/100/120/140 +20% AP, 2.5 s, cast 0.25), read 2026-10-08; base ranks also in research/family-assets/Seraphine/spells.json SeraphineW ShieldStrength'}
}

end
factories['shen']=function()
-- Shared Shen mechanics data. Values preserved from the maintained controller.
return {
 Shen={id='normal',q='ShenQ',w='ShenW',e='ShenE',r='ShenR',eRange=600,qKind='blade',
  qBuff='ShenQBuff',qWeak='ShenQBuffWeak',qStrong='ShenQBuffStrong',wBuff='ShenWActive',rChannel='ShenRChannelBuffBar',
  passive='ShenPassiveShield',wRadius=350,wDuration=1.75,qPercent={.02,.025,.03,.035,.04},qCap={100,125,150,175,200},
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
 Jade_Shen={id='classic',q='Jade_ShenQ',w='Jade_ShenW',e='Jade_ShenE',r='Jade_ShenR',eRange=575,qKind='target',
  qRange=475,qBase={60,100,140,180,220},qAP=.6,qDelay=.42,qSpeed=1500,qMark='Jade_ShenQ_Heal',
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
return {
 Sivir={id='normal',
  -- Boomerang Blade deals physical damage (https://wiki.leagueoflegends.com/en-us/Sivir, read 2026-10-10).
  qType='physical',qTypeSource='https://wiki.leagueoflegends.com/en-us/Sivir (Boomerang Blade: physical damage), read 2026-10-10',
  -- On the Hunt: 8/10/12 s, bonus movement speed 20-30% for Sivir and nearby allies (wiki read 2026-10-10).
  -- Used only as a chase tool in Combo (switch off by default).
  rKind='speed',rDuration={8,10,12},
  rSource='https://wiki.leagueoflegends.com/en-us/Sivir (On The Hunt: 8-12 s, +20-30% movement speed), read 2026-10-10'},
 Jade_Sivir={id='classic',
  -- Classic Boomerang Blade is magic damage: own Classic asset tooltip Spell_SivirQ_Jade_Tooltip "deals
  -- <magicDamage>@TotalDamage@ magic damage</magicDamage>" (research/evade/classic-localization-evidence.json,
  -- jade_sivir.bin sha256 daf32cce..., readback verified) and https://wiki.leagueoflegends.com/en-us/League_Classic/Sivir
  -- (read 2026-10-10). Earlier builds computed it as physical.
  qType='magical',qTypeSource='Classic asset tooltip Spell_SivirQ_Jade_Tooltip (magic damage), research/evade/classic-localization-evidence.json; wiki League_Classic/Sivir read 2026-10-10',
  -- Classic On The Hunt: 15 s, +25/45/65% attack speed and +25% movement speed, allies half (wiki League_Classic/Sivir,
  -- read 2026-10-10): a fight steroid, used in Combo while Sivir attacks the target.
  rKind='attack_speed',rDuration={15,15,15},
  rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Sivir (On The Hunt: 15 s, +25/45/65% attack speed), read 2026-10-10'},
}

end
factories['skarner']=function()
-- Skarner numbers the shared row in CombatProfiles/abilities.lua (M.controllers.Skarner, not edited by the
-- champion work) does not carry. The controller overlays these on a private copy of that row.
return {
 -- https://wiki.leagueoflegends.com/en-us/Skarner read 2026-10-10: Shattered Earth empowers the next three attacks
 -- (+25 attack range) within the qHold window of the shared row; throwing Upheaval ends Shattered Earth. The buff that
 -- carries the window is not confirmed by an asset or a live record: qBuff names the candidate from the installed asset
 -- index (entries.json 'SkarnerQ'); without it the controller times the window from its own observation of the stage.
 -- Impale cast time 0.75 s (shared geometry row).
 Skarner={qEmpowerRange=25,qLapseMargin=.5,qBuff='SkarnerQ',rInterruptDelay=.75,
  source='https://wiki.leagueoflegends.com/en-us/Skarner (read 2026-10-10)'},
 -- research/family-assets/Jade_Skarner/spells.json (installed 16.20 assets): Jade_SkarnerR castFrame 7.5 (0.25 s at 30
 -- frames per second), BaseDamage 100/150/200 at ranks 1-3, suppression 1.75 s; Jade_SkarnerW MSBonus .15/.17/.19/.21/.23.
 -- https://wiki.leagueoflegends.com/en-us/League_Classic/Skarner read 2026-10-10: Impale +50% AP; the same damage again when
 -- the suppression ends (not counted: the player may cancel the drag).
 Jade_Skarner={rCast=.25,rBase={100,150,200},rAP=.5,wSpeed={.15,.17,.19,.21,.23},
  source='research/family-assets/Jade_Skarner/spells.json; https://wiki.leagueoflegends.com/en-us/League_Classic/Skarner (read 2026-10-10)'},
}

end
factories['sona']=function()
-- Shared Sona mechanics data. Values preserved from the maintained controller.
return {
 Sona={id='normal',q='SonaQ',w='SonaW',e='SonaE',r='SonaR',qBase={50,85,120,155,190},qAP=.4,
   healBase={30,45,60,75,90},healAP=.3,healRange=1000,shieldBase={25,45,65,85,105},shieldAP=.25,auraRange=400,rRadius=140,rBase={150,250,350},rAP=.5,
  auras={{'SonaQ'},{'SonaW'},{'SonaE'}},chords={{'SonaQPassiveAttack'},{'SonaWPassiveAttack'},{'SonaEPassiveAttack'}},
  count='SonaPassive',accelerando='SonaPassiveAccelerandoCount',shield='SonaWShield',hasShield=true,shieldDuration=1.5,wDelay=0,
  shieldSource='https://wiki.leagueoflegends.com/en-us/Sona Aria of Perseverance: shield 25/45/65/85/105 (+25% AP) for 1.5 s, no cast time (read 2026-10-08)',
  -- Song of Celerity self haste offered to Evade: research/family-assets/Sona/spells.json SonaE SelfBaseMovementSpeed .20 for
  -- SelfMovementSpeedDurationMin 3 s (up to 7 s while undamaged; the 3 s floor is offered), no cast time (wiki read 2026-10-10).
  eHaste={.2,.2,.2,.2,.2},eHasteDuration=3,eHasteBuff='SonaESelfHaste',
  eHasteSource='research/family-assets/Sona/spells.json SonaE SelfBaseMovementSpeed/SelfMovementSpeedDurationMin; https://wiki.leagueoflegends.com/en-us/Sona (read 2026-10-10)'},
 Jade_Sona={id='classic',q='Jade_SonaQ',w='Jade_SonaW',e='Jade_SonaE',r='Jade_SonaR',qBase={60,110,160,210,260},qAP=.5,
   healBase={30,55,80,105,130},healAP=.5,healRange=1000,auraRange=1000,rRadius=140,assetRRadius=170,rBase={150,250,350},rAP=.7,
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
return {
 Thresh={id='normal',q='ThreshQ',q2='ThreshQLeap',w='ThreshW',e='ThreshE',r='ThreshRPenta',hook='threshq',
 qBase={100,150,200,250,300},qAP=.9,eBase={65,110,155,200,245},eAP=.6,rBase={250,400,550},shield={50,70,90,110,130},
 -- Lantern numbers for the Evade shield offer and the far throw. leapHold: the fly-in waits until this much of the hook mark is left.
 shieldPerSoul=2,shieldDuration=4,lanternTravel=.5,lanternRadius=350,lanternFar=1450,leapHold=.4,
 -- Cast times for the finishers and the Flash-Box: Flay 0.389 s, The Box 0.45 s (https://wiki.leagueoflegends.com/en-us/Thresh,
 -- read 2026-10-10). rBase above is the first wall a champion breaks (250/400/550 +100% AP).
 eCast=.389,rCast=.45,
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
return {
 Tristana={id='normal',q='TristanaQ',w='TristanaW',e='TristanaE',r='TristanaR',eKind='charge',qDuration=7,
  eBuff='tristanaecharge',eBase={60,85,110,135,160},eAD=.8,eAP=.5,eAmp=.25,eMax=4,eCrit=.4,eCritIE=.12,eCritItem=3031,eDuration=4,eSpeed=2400,eRadius=300,
  rBase={225,275,325},rAD=.7,rAP=1,rSpeed=2000,wRange=900,
  wDelay=.25,wSpeed=1100,wBase={70,105,140,175,210},wAD=1,wAP=.5,
  wSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Tristana/Rocket_Jump 2026-10-08: range 900, cast 0.25, speed 1100'},
 Jade_Tristana={id='classic',q='Jade_TristanaQ',w='Jade_TristanaW',e='Jade_TristanaE',r='Jade_TristanaR',eKind='dot',qDuration=7,
  eBuff='Jade_TristanaE_Debuff',eBase={110,150,190,230,270},eAD=0,eAP=1,eDuration=5,eTicks=5,eSpeed=1400,
  rBase={300,400,500},rAD=0,rAP=1.5,rSpeed=1600,rRange=550,wRange=900,
  wDelay=.25,wSpeed=1100,wBase={70,115,160,205,250},wAD=0,wAP=.8,
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
return {
 Twitch={id='normal',rBonusRange=300,rDuration=6,rBonusAD={30,45,60},rMarginSpeed=4000,rWindow=3,dashLate=.3},
 Jade_Twitch={id='classic',rBonusRange=300,rDuration=7,rBonusAD={20,28,36},rMarginSpeed=4000,rWindow=3,dashLate=.3},
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
return {
 Jade_Vayne={id='classic',wBuff='Jade_VayneW_Debuff',qBuff={'Jade_VayneQ_Bonus'},qSdkBuff='jade_vayneq_bonus',qRatio={.30,.35,.40,.45,.50},qRatioUlt={.40,.45,.50,.55,.60},qAP=0,rBuff='Jade_VayneR',stealth={'Jade_VayneInquisitionStealth','Jade_VayneQ_Fade'},eRange=550,eKnockback=475,
  eBase={45,80,115,150,185},eAD=.5,eTerrain={45,80,115,150,185},eTerrainAD=.5},
 Vayne={id='normal',wBuff='VayneSilveredDebuff',qBuff={'VayneTumble','VayneTumbleBonus'},qSdkBuff='vaynetumblebonus',qRatio={.75,.85,.95,1.05,1.15},qAP=.5,rBuff='VayneInquisition',stealth={'VayneInquisitionStealth','VayneTumbleFade'},eRange=550,eKnockback=475,
  eBase={50,85,120,155,190},eAD=.5,eTerrain={75,127.5,180,232.5,285},eTerrainAD=.75},
}

end
factories['viktor']=function()
-- Shared Viktor mechanics data. Values preserved from the maintained controller.
return {Viktor={id='normal',q='ViktorQ',w='ViktorW',e='ViktorE',r='ViktorR',r2='ViktorRGuide',
 qBase={60,75,90,105,120},qAP=.4,qHit={20,45,70,95,120},qHitAP=.5,qRange=600,qSpeed=2000,qDelay=.25,qLife=2.5,
 shieldMin=40,shieldMax=140,shieldAP=.25,shieldAug=1.6,qMS=.3,
 -- Q shield offered to Evade. Amount "40 - 140 (based on level) (+ 25% AP)" for 2.5 seconds, cast time 0.25, target
 -- range 600, augment "+60%" (64 - 224 +40% AP): https://wiki.leagueoflegends.com/en-us/Template:Data_Viktor/Siphon_Power
 -- and https://wiki.leagueoflegends.com/en-us/Viktor, read 2026-10-08; the installed asset agrees (ShieldAPRatio .25,
 -- AugmentShieldBonus, BuffDuration 2.5, level calculation 40..140). The page words the shield as part of the cast
 -- ("throws a draining device at the target enemy ... grants himself a shield") and only the augment's movement speed
 -- as "after the device hits", so the shield is taken as granted when the 0.25 s cast completes. No per-level table is
 -- published: the offer promises the level-1 amount (40 + 25% AP, x1.6 augmented), a lower bound at every level.
 shieldDuration=2.5,
 shieldSource='Viktor Q: https://wiki.leagueoflegends.com/en-us/Template:Data_Viktor/Siphon_Power and https://wiki.leagueoflegends.com/en-us/Viktor read 2026-10-08 (shield 40 - 140 by level + 25% AP for 2.5 seconds, cast time 0.25, target range 600, augmented +60%) and installed asset research/family-assets/Viktor/spells.json (ShieldAPRatio, AugmentShieldBonus, BuffDuration, shield calculation 40..140); offered amount is the level-1 lower bound; shield taken as granted at the end of the cast',
 -- Wiki figures that differ from the installed asset (asset kept, it is the matching profile; not measured live):
 -- E width 90 and "range 500" (asset: missile radius 80, LaserRange 700), W effect radius 340, cast 0.25, arms after
 -- 0.75 s (asset: Size 275; the 0.3 delay below is a prediction candidate), read 2026-10-08.
 eBase={70,110,150,190,230},eAP=.5,eAfter={20,50,80,110,140},eAfterAP=.8,eAfterDelay=1,eMinion=.5,
 eStart=525,eLength=700,eRadius=80,eSpeed=1050,eDelay=0,
 wRange=800,wRadius=275,wDelay=.3,wDwell=1.25,wStun=1.5,wLife=4,wAugSlow=.2,
 -- Ranking 2026-10-10 (dossier Viktor-9/12, wiki Viktor V26.16 read 2026-10-10):
 --  wArm: W cast 0.25 + activation 0.75; the field is predicted where the target is once it is active (the old
 --   wDelay .3 predicted long before). The wiki radius 340 is not used for counting until the viktor_w_field dev trace
 --   settles it against the asset Size 275 (275 is the conservative of the two).
 --  qHitAD: Q discharge 20-120 (+100% AD) (+50% AP) magic; the asset row lacks the AD term.
 wArm=1,qHitAD=1,
 rBase={100,175,250},rAP=.5,rTick={65,105,145},rTickAP=.35,rRange=700,rGuide=20000,rRadius=325,rLife=6.5,rCadence=1,rMaxTicks=6,
 rGrow=.4,rMaxGrowth=6,rExtension=3,rFast=275,rSlow=200,
 fragments='viktorpassivecount',qEmpower='viktorqbuff',qReturn='viktorqreturn',rTimer='viktorrtimer',rMark='viktorrguide'}}

end
factories['xerath']=function()
-- Shared Normal Xerath data; no Classic mechanics are inferred.
return {
 Xerath={id='normal',q='XerathArcanopulseChargeUp',q2='XerathArcanopulse2',w='XerathArcaneBarrage2',e='XerathMageSpear',r='XerathLocusOfPower2',shot='XerathRMissileWrapper',pulse='XerathLocusPulse',
 qBase={70,110,150,190,230},wBase={50,85,120,155,190},eBase={70,100,130,160,190},rBase={170,220,270},shots={4,5,6},
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
return {
 Yone={id='normal',q='YoneQ',q3='YoneQ3',w='YoneW',e='YoneE',r='YoneR',qBase={25,50,75,100,125},wBase={10,20,30,40,50},wHealth={.08,.09,.10,.11,.12},rBase={200,400,600},
 -- W reach 600: https://wiki.leagueoflegends.com/en-us/Template:Data_Yone/Spirit_Cleave ("EFFECT RADIUS: 600", angle 80), read 2026-10-08.
 -- The installed asset lists YoneW castRange 700 (a cast range, what the controller used before); the cone itself is
 -- 600 on the wiki and in the reference script. The shorter value only refuses casts between 600 and 700.
 wRange=600,
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
 rBonusAD=.8,
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
 q3KnockupTime=.75,q3Knockup='yoneq3knockup',
 -- Q3 dash offered to Evade: fixed 450 at 1500, cast 0.35 at no bonus attack speed (the longest cast).
 q3Dash=450,q3DashSpeed=1500,q3Cast=.35,
 -- E: https://wiki.leagueoflegends.com/en-us/Template:Data_Yone/Soul_Unbound (revision 2026-08-05, read 2026-10-10):
 -- the return repeats 25/27.5/30/32.5/35% of the post-mitigation damage Yone's attacks and abilities dealt to the
 -- marked champion as true damage; damage to shields is not stored; spirit 5 s, recast after 0.5 s.
 eStore={.25,.275,.30,.325,.35},
 -- W shield: wiki Yone V26.19 (read 2026-10-10): 40 - 95.88 by level (+65% bonus AD) for 1.5 s; no per-level table, so
 -- the level-1 end is the lower bound. W cast 0.5 at no bonus attack speed, 0.25 at the 50% cap this controller uses.
 -- Not verified on the host (yone-provenance shield_gate: installed .75 override, hit attribution): no Evade offer yet.
 wShieldBase=40,wShieldBonusAD=.65,wShieldDuration=1.5,wCastLong=.5,wCastShort=.25,wShieldVerified=false,
 wShieldSource='Yone W shield: https://wiki.leagueoflegends.com/en-us/Yone (V26.19, read 2026-10-10) 40 - 95.88 by level (+65% bonus AD), 1.5 s; level-1 base used as the lower bound',
 mobilitySource='Yone Q3 dash: installed asset research/family-assets/Yone (yone-provenance.json q3.dash_distance 450, q3.dash_speed 1500, q.base_windup_seconds 0.35); the wiki page Template:Data_Yone/Mortal_Steel confirms cast 0.35 - 0.175 and "dashes a fixed distance" but states neither the distance nor the dash speed (read 2026-10-08)'}
}

end
factories['zed']=function()
-- Shared Zed mechanics data. Values preserved from the maintained controller.
return {Zed={id='normal',q='ZedQ',w='ZedW',w2='ZedW2',e='ZedE',r='ZedR',r2='ZedR2',mark='ZedRDeathMark',wBuff='ZedWHandlerBuffName',rBuff='ZedR2',passiveCD='ZedPassiveCD',
 qRange=900,qRadius=45,qBlockRadius=50,qSpeed=1700,qDelay=.25,qBase={80,120,160,200,240},qAD=1,qPass=.6,
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
 wMin=325,wSpeed=2500,wRange=650,wSwapRange=2000,wDuration=5.25,rRange=625,rDuration=7.5,rRecast=.5,markDuration=3,rAmp={.25,.4,.55},rAD=1,
 -- E: asset ZedE castRadius 290, wiki lists 315 and 290; the caster uses 290 until the zed_e_reach trace measures it.
 eRadius=290,eShadowRadius=290,eBase={70,92.5,115,137.5,160},eAD=.7,
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
