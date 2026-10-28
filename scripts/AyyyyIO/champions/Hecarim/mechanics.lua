return function(require)
return function()
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
end
