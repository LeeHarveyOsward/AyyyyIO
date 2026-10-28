return function(require)
return function()
-- Shared Aatrox Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
local D=(function()
return {
 AatroxR={
  RDuration=10,RHealingAmp={.5,.75,1},RTotalADAmp={.2,.3,.4},
 },
 AatroxQ={
  QBaseDamage={10,25,40,55,70},QExtensionTime=4,QRampBonus=.25,QSweetSpotBonus=.75,QTotalADRatio={.6,.675,.75,.825,.9},
 },
 AatroxQWrapperCast={
  mCastTime=.6,
 },
 AatroxW={
  WBaseDamage={30,40,50,60,70},WBonusADRatio=.4,castRange=825,mCastTime=.25,mMissileWidth=80,mSpeed=1800,
 },
 AatroxE={
  EMaxRange=300,ESpellVamp=16,
 },
 Jade_AatroxW={
  LowHealthPercent=50,WBaseDamage={60,95,130,165,200},WBaseHeal={20,25,30,35,40},WDamageADRatio=1,WHealADRatio=.25,WLowHealthHealBonus=3,
 },
 Jade_AatroxEConeMissile={
  EAPRatio=.6,EBaseDamage={75,120,165,210,255},EBonusADRatio=.6,castRange=1075,mMissileWidth=40,mSpeed=1250,
 },
 Jade_AatroxE={
  EHealthCostPercent=.05,mCastTime=.25,
 },
 Jade_AatroxR={
  RAttackSpeed={.4,.5,.6},RBaseDamage={200,300,400},RBonusRange=175,RDuration=12,RRadius=550,
 },
 Jade_AatroxQ={
  QBaseDamage={70,115,160,205,250},QBonusADRatio=.6,QDamageRadius=310,QHealthCostPercent=.1,QKnockupRadius=190,QMaxLeapRange=650,
 },
}
end)()
local profiles={}
profiles['Aatrox']=profiles['Aatrox']or {}
profiles['Aatrox'].combat={id='normal',champion='Aatrox',names={{'AatroxQ','AatroxQ2','AatroxQ3'},{'AatroxW'},{'AatroxE'},{'AatroxR'}},
  q={range=625,radius=90,delay=D.AatroxQWrapperCast.mCastTime,speed=math.huge,type='physical',base=D.AatroxQ.QBaseDamage,ad=D.AatroxQ.QTotalADRatio},
  -- 2026-10-10 (wiki Aatrox, Last changed V26.19, read 2026-10-10): W physical since V25.11. Q1 625x180 (half-width
  -- 90); Q2 trapezoid from 100 behind to 475 ahead, 300 to 500 wide (half-widths 150/250); Q3 300-radius circle 200
  -- ahead, 180-radius sweet spot. Q1/Q2 sweet depths are not published: 475 and 350 kept (live damage logs settle them).
  -- qWindow 4 s (asset QExtensionTime). wChainRadius: not published; 150 is below DepressiveAIONext's 185+bounding,
  -- development 'aatrox_w_pull' traces settle it. qMinion: wiki "55/60/65/70% (based on level)" without the level
  -- breakpoints; the lowest share 0.55 is used for every level so a minion kill is never overestimated.
  w={range=D.AatroxW.castRange,radius=D.AatroxW.mMissileWidth,delay=D.AatroxW.mCastTime,speed=D.AatroxW.mSpeed,type='physical',base=D.AatroxW.WBaseDamage,ad=D.AatroxW.WBonusADRatio,collision=true},
  e={range=D.AatroxE.EMaxRange},r={range=0},qStages={{range=625,width=90,sweetMin=475,sweetMax=625},{range=475,back=100,near=150,width=250,sweetMin=350,sweetMax=475},{center=200,radius=300,sweetRadius=180}},qRamp=D.AatroxQ.QRampBonus,sweetBonus=D.AatroxQ.QSweetSpotBonus,
  qWindow=D.AatroxQ.QExtensionTime,wChainRadius=150,qMinion=.55,qCast='AatroxQWrapperCast',
  passiveNames={'AatroxPassiveReady','AatroxPassive'},tetherNames={'AatroxW'},passiveHP={.04,.10},passiveCap={100,320},eHealingHP=.00013,eHealing=D.AatroxE.ESpellVamp/100,rAD=D.AatroxR.RTotalADAmp,rHealing=D.AatroxR.RHealingAmp,rDuration=D.AatroxR.RDuration}
profiles['Jade_Aatrox']=profiles['Jade_Aatrox']or {}
profiles['Jade_Aatrox'].combat={id='classic',champion='Aatrox',names={{'Jade_AatroxQ'},{'Jade_AatroxW','Jade_AatroxW2'},{'Jade_AatroxE'},{'Jade_AatroxR'}},
  q={range=D.Jade_AatroxQ.QMaxLeapRange,radius=D.Jade_AatroxQ.QDamageRadius,knockupRadius=D.Jade_AatroxQ.QKnockupRadius,delay=.6,speed=math.huge,type='physical',base=D.Jade_AatroxQ.QBaseDamage,bonusAD=D.Jade_AatroxQ.QBonusADRatio,healthCost=D.Jade_AatroxQ.QHealthCostPercent},
  w={range=0,type='physical',base=D.Jade_AatroxW.WBaseDamage,bonusAD=D.Jade_AatroxW.WDamageADRatio},
  -- E: Jade_AatroxEConeMissile castRange 1075, missile line radius 40 (field 1a24e25e; the second blade 15,
  -- castRadius 100 is the spread, not the hit width); 26.20 Jade_Aatrox spells.json, 2026-10-10.
  e={range=D.Jade_AatroxEConeMissile.castRange,radius=D.Jade_AatroxEConeMissile.mMissileWidth,delay=D.Jade_AatroxE.mCastTime,speed=D.Jade_AatroxEConeMissile.mSpeed,type='magical',base=D.Jade_AatroxEConeMissile.EBaseDamage,bonusAD=D.Jade_AatroxEConeMissile.EBonusADRatio,ap=D.Jade_AatroxEConeMissile.EAPRatio,healthCost=D.Jade_AatroxE.EHealthCostPercent},
  r={range=D.Jade_AatroxR.RRadius,type='magical',base=D.Jade_AatroxR.RBaseDamage,ap=1},wHeal=D.Jade_AatroxW.WBaseHeal,wHealAD=D.Jade_AatroxW.WHealADRatio,wHealThreshold=D.Jade_AatroxW.LowHealthPercent/100,wHealAmplifier=D.Jade_AatroxW.WLowHealthHealBonus,
  healNames={'Jade_AatroxWLife'},damageNames={'Jade_AatroxWPower'},reviveNames={'Jade_AatroxPassiveDeath'},wAttacks=3,reviveDuration=3,rDuration=D.Jade_AatroxR.RDuration,rAS=D.Jade_AatroxR.RAttackSpeed,rAttackRange=D.Jade_AatroxR.RBonusRange}
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
end
