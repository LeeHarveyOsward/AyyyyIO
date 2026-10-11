return function(require)
-- Shared Normal/Classic mechanics. Units: world units, seconds, raw damage.
-- Evidence: research/dual-profiles-20261006/manifest.json and per-champion provenance.
-- Asset-derived definitions are not a claim of live server verification.
local M={version=1,controllers={}}
M.controllers.MissFortune={
 MissFortune={id='normal',qBase={20,45,70,95,120},qAD=1,qAP=.35,bounce=1,bounceRange=500,eRange=1000,
  rName='missfortunebullettime',rBuff='missfortunebulletsound',wBuff='missfortuneviciousstrikes',channel=3,waves={14,16,18},
  rWaveBase={20,30,40},rWaveAD=.6,rWaveADKind='total',rWaveAP=.25},
 Jade_MissFortune={id='classic',qBase={35,70,105,140,175},qAD=.75,qAP=0,bounce=1.2,bounceRange=500,eRange=800,
  rName='jade_missfortunebullettime',rBuff='jade_missfortunebulletsound',wBuff='jade_missfortuneviciousstrikes',channel=2,waves={8,8,8},
  rWaveBase={65,95,125},rWaveAD=.45,rWaveADKind='bonus',rWaveAP=.3},
}
function M.MissFortuneRWaveRaw(runtime,rank,totalAD,bonusAD,ap)
 local p=M.controllers.MissFortune[runtime]
 if not p or type(rank)~='number'or rank%1~=0 or rank<1 or rank>3 then return nil,'r_rank_unknown'end
 local ad=totalAD;if p.rWaveADKind=='bonus'then ad=bonusAD end
 local function finite(v)return type(v)=='number'and v==v and v>=0 and v<math.huge end
 if not finite(ad)or not finite(ap)then return nil,'r_stats_unknown'end
 return p.rWaveBase[rank]+p.rWaveAD*ad+p.rWaveAP*ap
end
M.controllers.Ryze={
  Ryze={id='normal',qRange=1000,qSpeed=1700,eSpeed=1500,eSpeedMax=3500,spread=350,qBounce=350,flux='ryzee',rBuff='ryzerchannel',
  base={{75,95,115,135,155},{60,90,120,150,180},{60,90,120,150,180}},ap={.55,.6,.5},mana={.02,.03,.02}},
  Jade_Ryze={id='classic',qRange=600,qSpeed=1700,eSpeed=1000,spread=350,qBounce=0,flux='jade_ryzee',rBuff='jade_ryzer',
  base={{60,85,110,135,160},{60,95,130,165,200},{50,70,90,110,130}},ap={.4,.6,.35},mana={.065,.045,.01}},
}
M.controllers.Sivir={
 Sivir={id='normal',toggle=false,qSpeed=1450,qBase={60,85,110,135,160},qAD=.7,qAP=.6,falloff=.15,wDuration=4},
 Jade_Sivir={id='classic',toggle=true,qSpeed=1350,qBase={80,125,170,215,260},qAD=1,qAP=.75,falloff=.2,wCost=6},
}
M.controllers.Teemo={
 Teemo={id='normal',qSpeed=2500,qFast=2500,rRange={600,750,900},rSpeed=1000,armTime=1,
  eImpact={9,23,37,51,65},eAD=.05,eTickAD=.025,monster=1.6},
 Jade_Teemo={id='classic',qSpeed=1500,qFast=2500,rRange={230,230,230},rSpeed=1450,
  eImpact={10,20,30,40,50},eAD=0,eTickAD=0,monster=1.45},
}
M.controllers.Twitch={
 -- detect/warn: camouflage detection radius 500 and the warning 300 beyond it (wiki.leagueoflegends.com/en-us/Stealth and
 -- Template:Data_Twitch/Ambush, read 2026-10-08). W 950/300/1400 and the 1 s fade re-read the same day. Classic Q is the old
 -- invisibility: no detection radius is established for it, so it has none here.
 Twitch={id='normal',poison='twitchdeadlyvenom',stealth='twitchhideinshadows',r='twitchfullautomatic',wSpeed=1400,wRadius=300,rSpeed=5000,rDuration=6,falloff=.1,floor=.6,eBase={20,30,40,50,60},eAD=.35,eAP=.35,fade=1,detect=500,warn=800},
 Jade_Twitch={id='classic',poison='jade_twitchpassive_internal',stealth='jade_twitchq',r='jade_twitchr',wSpeed=1300,wRadius=275,rSpeed=4000,rDuration=7,falloff=.2,floor=.4,eBase={20,35,50,65,80},eAD=.25,eAP=.2,fade=1.25},
}
M.controllers.Karthus={Jade_Karthus={id='classic',
 qRange=875,qRadius=160,qCast=.25,qDetonate=.5,qBase={40,60,80,100,120},qAP=.3,
 wRange=1000,wCast=.25,wLength={800,900,1000,1100,1200},
 eRadius=550,eKeep=625,eIdle=.35,
 rBase={250,400,550},rAP=.6,rCast=.25,rChannel=3,
 passive='jade_karthusdeathdefiedbuff',rName='jade_karthusfallenone'},
 Karthus={id='normal',
 qRange=875,qRadius=160,qCast=.25,qDetonate=.5,qBase={40,59,78,97,116},qAP=.35,
 wRange=1000,wCast=.25,wLength={800,900,1000,1100,1200},
 eRadius=550,eKeep=625,eIdle=.35,
 rBase={200,350,500},rAP=.7,rCast=.25,rChannel=3,
 passive='karthusdeathdefiedbuff',rName='karthusfallenone'}}
M.controllers.Pantheon={
 Pantheon={id='normal',qBase={70,100,130,160,190},qAD=1.15,qHold=.35,qMaxHold=4,qExecuteHP=.2,qExecute={155,230,305,380,455},qExecuteAD=2.3,
  qMinion=.7,qMonster=.8,qFalloff=.5,wHP={.06,.065,.07,.075,.08},wBonusHP=.00004,wMonsterMin=60,wMonsterMax=150,
  eDuration=1.5,eSlam={55,105,155,205,255},eAD=1.5,passive='pantheonpassiveready',empoweredW='pantheonwempowerment'},
 -- Certain Death (Classic passive), https://wiki.leagueoflegends.com/en-us/League_Classic/Pantheon read 2026-10-08: basic attacks,
 -- Spear Shot and Heartseeker Strike "critically strike all enemies below 15% maximum health"; for Q and E that is "double
 -- damage" (2.25 with Infinity Edge, not counted here), and only once Heartseeker Strike (E) is learned. The 2012 note
 -- (V1.0.0.123, 50% bonus) is the older value; the page of this mode decides. Heartseeker deals 50% to minions. Not live-verified.
 Jade_Pantheon={id='classic',qBase={65,105,145,185,225},qAD=1.4,wBase={50,75,100,125,150},wAP=1,eBase={26,46,66,86,106},eAD=1.2,eStrikes=3,
  executeHP=.15,executeMultiplier=2,executeNeedsE=true,eMinion=.5},
}
M.controllers.Skarner={
 Skarner={id='normal',qBase={10,20,30,40,50},qAD=.9,qBonusHP=.03,qTargetHP=.11,qMonsterCap={150,200,250,300,350},qHold=5,
   wBase={50,70,90,110,130},wAP=.8,wShieldHP=.08,wDuration=2.5,eBase={30,60,90,120,150},eAD=1.2,eOwnHP=.06,
  rBase={150,250,350},rAP=1,rDuration=1.5,rStartWidth=175,rEndWidth=100,rMaxTargets=3,
  wDelay=.3,qSplash=300,
  wShieldSource='https://wiki.leagueoflegends.com/en-us/Skarner Seismic Bastion: shield 8% of maximum health for 2.5 s, cast time 0.3; Upheaval explosion radius 300; read 2026-10-08'},
 -- Classic W as offered to Evade. wStart .3 is an assumed UPPER bound for when the shield is up (the Classic cast time is not
 -- published; the old W is an instant self cast), so the offer can only start late, never early.
 Jade_Skarner={id='classic',qRange=350,eRange=800,rRange=350,wShield={70,115,160,205,250},wShieldAP=.6,wDuration=6,wStart=.3,
  wShieldSource='research/family-assets/Jade_Skarner/spells.json:1346,1385 baseBlockDamage 70..250, 6 s; https://wiki.leagueoflegends.com/en-us/League_Classic/Skarner Crystalline Exoskeleton 70/115/160/205/250 (+60% AP) up to 6 s; read 2026-10-08'},
}
-- Spell geometry is separate from cast range. Sivir's cast range is 1200 while
-- the outgoing flight can reach 1250. Widths below are radial clearance.
M.geometry={
 Malphite={Q={shape='target',range=625,delay=.25,speed=1200},E={shape='circle',range=400,castRange=0,radius=400,delay=.25,speed=math.huge}},
 Jade_Malphite={Q={shape='target',range=625,delay=.25,speed=1200},E={shape='circle',range=400,castRange=0,radius=400,delay=.25,speed=math.huge}},
 Amumu={E={shape='circle',range=350,castRange=0,radius=350,delay=.25,speed=math.huge},R={shape='circle',range=550,castRange=0,radius=550,delay=.25,speed=math.huge}},
 Jade_Amumu={E={shape='circle',range=350,castRange=0,radius=350,delay=.25,speed=math.huge},R={shape='circle',range=550,castRange=0,radius=550,delay=.25,speed=math.huge}},
 Sona={W={shape='circle',range=1000,castRange=0,radius=1000,delay=.25,speed=math.huge},R={shape='line',range=1000,radius=140,delay=.25,speed=2400,directional=true}},
 Jade_Sona={W={shape='circle',range=1000,castRange=0,radius=1000,delay=.25,speed=math.huge},R={shape='line',range=1000,radius=170,predictionRadius=140,delay=.25,speed=2400,directional=true}},
 Ahri={Q={shape='line',range=970,flightRange=1000,radius=100,delay=.25,speed=2500,acceleration=-3200,minSpeed=400,maxSpeed=2500},E={shape='line',range=975,flightRange=1000,radius=60,delay=.25,speed=1550}},
 Jade_Ahri={Q={shape='line',range=970,flightRange=1000,radius=100,delay=.25,speed=2500,acceleration=-3200,minSpeed=400,maxSpeed=2500},E={shape='line',range=975,flightRange=1000,radius=60,delay=.25,speed=1550}},
 -- Volley speed: both pinned assets (VolleyAttack / Jade_AsheVolleyAttack missileSpeed 1500, movement component 1500; no
 -- other speed field) against 2000 on both wiki pages (Template:Data_Ashe/Volley, League_Classic/Ashe, read 2026-10-08).
 -- Unresolved. The Ashe controller treats 1500..2000 as bounds (CombatProfiles/ashe.lua wSpeeds): it aims only where both
 -- speeds hit and replaces this value with the median measured from its own arrows (Ashe ObserveVolley).
  Ashe={W={shape='line',range=1200,radius=20,delay=.25,speed=1500},R={shape='line',range=25000,flightRange=25000,radius=130,delay=.25,speed=1500,acceleration=200,minSpeed=1500,maxSpeed=2100,directional=true}},
  Jade_Ashe={W={shape='line',range=1300,radius=20,delay=.25,speed=1500},R={shape='line',range=25000,flightRange=25000,radius=130,delay=.25,speed=1500,acceleration=200,minSpeed=1500,maxSpeed=2100,directional=true}},
 MissFortune={Q={shape='targeted',range=650,delay=.25,speed=1400},E={shape='circle',range=1000,radius=350,delay=.25,speed=math.huge},R={shape='cone',range=1400,flightRange=1450,radius=20,angle=34,delay=.375,speed=2000,duration=3}},
 Jade_MissFortune={Q={shape='targeted',range=650,delay=.25,speed=1400},E={shape='circle',range=800,radius=350,delay=.25,speed=math.huge},R={shape='cone',range=1400,flightRange=1450,radius=20,angle=34,delay=.375,speed=2000,duration=2}},
 Ryze={Q={shape='line',range=1000,radius=55,delay=.25,speed=1700},W={shape='targeted',range=615},E={shape='targeted',range=615,speed=1500,speedMax=3500}},
 -- Ryze W/E, 2026-10-08. Normal: wiki.leagueoflegends.com/en-us/Ryze target range 550 (edge) = 615 between centres, the asset's
 -- castRangeDisplayOverride. Classic: asset Jade_Ryze castRange 550 with the same 615 display override; the League_Classic/Ryze page
 -- says 600 (and Q 625, unit-targeted) without a range convention. 600 is inside both readings; 550 gave away reach. Q stays 600
 -- (asset castRange) against the page's 625.
 Jade_Ryze={Q={shape='targeted',range=600,delay=.25,speed=1700},W={shape='targeted',range=600},E={shape='targeted',range=600,speed=1000}},
 Sivir={Q={shape='line',range=1200,flightRange=1250,radius=90,delay=.25,speed=1450,directional=true}},
 Jade_Sivir={Q={shape='line',range=1250,flightRange=1250,radius=90,delay=.25,speed=1350,directional=true}},
 Teemo={Q={shape='targeted',range=680,delay=.25,speed=2500},R={shape='circle',ranges={600,750,900},radius=135,triggerRadius=160,explosionRadius=450,delay=.25,speed=1000}},
 Jade_Teemo={Q={shape='targeted',range=680,delay=.25,speed=1500},R={shape='circle',ranges={230,230,230},radius=135,delay=.25,speed=1450}},
 Twitch={W={shape='circle',range=950,radius=300,delay=.25,speed=1400},E={shape='circle',range=1200,castRange=0,radius=1200,delay=.25,speed=math.huge},R={shape='line',range=1100,radius=60,speed=5000}},
 Jade_Twitch={W={shape='circle',range=950,radius=275,delay=.25,speed=1300},E={shape='circle',range=1200,castRange=0,radius=1200,delay=.25,speed=math.huge},R={shape='line',range=1100,radius=60,speed=4000}},
 Karthus={Q={shape='circle',range=875,radius=160,delay=.75,speed=math.huge},W={shape='wall',range=1000,radius=100,delay=.25},E={shape='self',range=550},R={shape='global',duration=3}},
 Jade_Karthus={Q={shape='circle',range=875,radius=160,delay=.75,speed=math.huge},W={shape='wall',range=1000,radius=100,delay=.25},E={shape='self',range=550},R={shape='global',duration=3}},
 Pantheon={Q={shape='line',range=575,flightRange=1200,radius=55,delay=.25,speed=2700},W={shape='targeted',range=600},E={shape='cone',range=525,radius=0,angle=60,delay=.25,speed=math.huge},R={shape='landing',range=5500}},
 Jade_Pantheon={Q={shape='targeted',range=600,delay=.25,speed=1200},W={shape='targeted',range=600},E={shape='cone',range=400,angle=32,delay=.25,speed=math.huge},R={shape='landing',range=5500}},
 Skarner={Q={shape='line',range=1050,radius=90,delay=.25,speed=1600},W={shape='self',range=650,radius=650},E={shape='dash',range=1700,radius=160},R={shape='trapezoid',range=625,radius=100,startWidth=175,endWidth=100,delay=.75,speed=math.huge}}, -- R cast 0.75: wiki Skarner Impale, read 2026-10-08 (was .65)
 -- Classic Fracture radius 70: asset Jade_Skarner lineWidth 70 (research/family-assets/Jade_Skarner/spells.json:261), missileSpeed 1800;
 -- the League_Classic/Skarner page gives width 120 (radius 60). The earlier 120 was a full width stored as a radius. Range 800
 -- (asset era) against the page's 1000 stays 800. Read 2026-10-08.
  Jade_Skarner={Q={shape='self',range=350,radius=350},W={shape='self',range=900},E={shape='line',range=800,radius=70,delay=.25,speed=1800},R={shape='targeted',range=350}},
   Seraphine={Q={shape='circle',range=900,radius=350,predictionRadius=300,delay=.75,speed=1300},
    W={shape='circle',range=800,castRange=0,radius=800,delay=.25,speed=math.huge},
   E={shape='line',range=1300,radius=70,delay=.25,speed=1200,directional=true,shareMissile=true},
   R={shape='line',range=1200,predictionRange=3600,flightRange=25000,radius=160,predictionRadius=140,
    delay=.5,speed=1600,directional=true,shareMissile=true}},
}
function M.Spell(identity,slot,prediction)
 local profile=M.geometry[identity];local s=profile and profile[slot];if not s then return nil end
 local shape=s.shape;local types=prediction and{line=prediction.SPELLTYPE_LINE,circle=prediction.SPELLTYPE_CIRCLE,cone=prediction.SPELLTYPE_CONE}or{}
  local motion=s.acceleration and{speed=s.speed,acceleration=s.acceleration,minSpeed=s.minSpeed,maxSpeed=s.maxSpeed}or nil
    return{Type=types[shape],Range=s.castRange or s.predictionRange or s.range,Radius=s.predictionRadius or s.radius,Angle=s.angle,Delay=s.delay,Speed=s.speed,Motion=motion,Collision=false,
    DirectionalCast=s.directional==true,AimErrorWorld=s.directional and 5 or 0}
end
-- Only reviewed existing stages are overlaid. No aliases or threat eligibility
-- are inferred from a champion's playable support or from a slot letter.
local stages={
 Ahri={AhriQ='Q',AhriE='E'},Jade_Ahri={Jade_AhriQ='Q',Jade_AhriE='E'},
 Ashe={EnchantedCrystalArrow='R'},Jade_Ashe={Jade_AsheEnchantedCrystalArrow='R'},
 MissFortune={MissFortuneScattershot='E',MissFortuneBulletTime='R'},
 Jade_MissFortune={Jade_MissFortuneScattershot='E',Jade_MissFortuneBulletTime='R'},
 Sivir={SivirQ='Q'},Jade_Sivir={Jade_SivirQ='Q'},
 Jade_Twitch={Jade_TwitchW='W'},
 Karthus={KarthusLayWasteA1='Q',KarthusLayWasteA2='Q',KarthusLayWasteA3='Q',KarthusLayWasteDeadA1='Q',KarthusLayWasteDeadA2='Q',KarthusLayWasteDeadA3='Q'},
 Jade_Karthus={Jade_KarthusLayWaste='Q'},
  Pantheon={PantheonQMissile='Q'},Jade_Skarner={Jade_SkarnerE='E',Jade_SkarnerQ='Q'},
  Seraphine={SeraphineECast='E',SeraphineEMissile='E',SeraphineR='R'},
}
function M.ApplyCatalog(identity,set,external)
 for name,slot in pairs(stages[identity]or{})do
  local record=set[name];local c=record and record.cast;local s=M.geometry[identity][slot]
  if c then
    if s.shape~='self'then c.range=s.flightRange or s.range end;c.radius=s.radius or c.radius
    if c.speed and s.speed and s.speed<math.huge then c.speed=s.speed end
    if s.acceleration then c.acceleration=s.acceleration;c.minSpeed=s.minSpeed;c.maxSpeed=s.maxSpeed end
   if c.channel and c.channel.kind=='fixed_cone_emission'then
    c.halfAngle=s.angle*math.pi/360;c.channel.duration=s.duration;c.channel.speed=s.speed
   end
   record.sharedAbilityVersion=M.version
   end
   if record and s.shareMissile and record.eligible==true and record.missileRecord then
    record.range=s.flightRange or s.range;record.radius=s.radius;record.speed=s.speed
    record.sharedAbilityVersion=M.version
   end
 end
  return external and external.ApplyCatalog(identity,set)or set
end
return M

end
