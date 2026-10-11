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
end
