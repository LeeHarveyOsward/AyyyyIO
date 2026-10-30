return function(require)
return function()
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
end
