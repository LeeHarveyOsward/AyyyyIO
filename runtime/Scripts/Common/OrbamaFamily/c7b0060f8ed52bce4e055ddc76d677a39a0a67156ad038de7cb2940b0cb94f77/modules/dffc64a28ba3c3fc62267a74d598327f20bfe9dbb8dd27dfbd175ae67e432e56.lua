return function(require)
return function()
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
end
