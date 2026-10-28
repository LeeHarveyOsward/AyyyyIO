return function(require)
return function()
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
end
