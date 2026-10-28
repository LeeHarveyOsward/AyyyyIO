return function(require)
return function()
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
end
