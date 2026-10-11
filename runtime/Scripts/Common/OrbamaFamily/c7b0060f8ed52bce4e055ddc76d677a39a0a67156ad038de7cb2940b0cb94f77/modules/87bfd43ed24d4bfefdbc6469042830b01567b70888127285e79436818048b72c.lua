return function(require)
return function()
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
end
