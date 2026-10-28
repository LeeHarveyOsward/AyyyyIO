return function(require)
return function()
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
end
