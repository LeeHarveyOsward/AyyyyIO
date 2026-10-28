return function(require)
return function()
-- Shared Irelia Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
local D=(function()
return {
 IreliaR={
  APRatio=1,BaseMissileDamage={125,200,275},castRange=1000,
 },
 IreliaPassive={
  OnHitBaseDamage=10,
 },
 IreliaE={
  BaseDamage={70,110,150,190,230},BuffDuration=3.5,MaxRange=775,RevTime=.35,
 },
 IreliaW={
  MinDamage={10,20,30,40,50},
 },
 IreliaQ={
  BaseDamage={5,25,45,65,85},castRange=600,
 },
 Jade_IreliaRSpell={
  mSpeed=1600,
 },
 Jade_IreliaR={
  BaseMissileDamage={80,120,160},ChampionHealPercent=25,MinionHealPercent=10,castRange=1200,mMissileWidth=120,
 },
 Jade_IreliaE={
  APRatio=.5,BaseDamage={80,130,180,230,280},StunDuration={1,1.25,1.5,1.75,2},castRange=325,
 },
 Jade_IreliaQ={
  BaseDamage={20,50,80,110,140},DashSpeedBonus=1400,ManaReturn=35,castRangeDisplayOverride=620,
 },
 Jade_IreliaW={
  ActiveDuration=6,Damage={15,30,45,60,75},Health={5,7,9,11,13},HealthRestoreActive={10,14,18,22,26},
 },
}
end)()
local profiles=(function()
-- Shared Irelia mechanics data. Values preserved from the maintained controller.
return {Irelia={id='normal',q='IreliaQ',w='IreliaW',w2='IreliaW2',e='IreliaE',e2='IreliaE2',r='IreliaR',
 mark='IreliaMark',passive='IreliaPassiveStacks',passiveMax='IreliaPassiveStacksMax',defense='IreliaWDefense',
 qRange=D.IreliaQ.castRange,qSpeed=1400,qBase=D.IreliaQ.BaseDamage,qAD=.8,qMinionBase=50,qMinionLevel=11,
 stacks=4,passiveBase=10,passiveLevel=3,passiveAD=.2,eRange=D.IreliaE.MaxRange,eDelay=.3,eRev=D.IreliaE.RevTime,eRadius=70,eDuration=D.IreliaE.BuffDuration,eRecast=.25,
 eBase=D.IreliaE.BaseDamage,eAP=1,wRange=775,wRadius=100,wMax=1.5,wFull=.75,wBase=D.IreliaW.MinDamage,wAD=.4,wAP=.5,wMaxBonus=2,
 wPhysicalDR={40,70},wDRAP=.08,wMagicDR=.5,
 -- 2026-10-10: W minimum +40% AD +50% AP (installed IreliaW calculation 368633251: .4 on stat 2 = AD, as Q's .8;
 -- .5 on the default stat = AP; wiki V26.17 agrees; the earlier .5 AD/.4 AP read the two terms swapped).
 -- R castRange 1000 (installed castRange, wiki V26.17; 950 is only the display override). Cast time: the installed
 -- asset says .5 (field 7c4baddc), the wiki .4; the asset value is kept.
 -- rBurst: radius around the first champion hit that the burst also marks. Not published: the 320 line width is
 -- used as a lower bound until development 'irelia_r' traces (marked champions per cast) settle it.
 -- qThrough: wiki V26.17 "dashes 100 units through the target"; unverified, used only as an extra Evade landing check.
 -- eRecast stays .25 (installed CDBetweenCast) where the wiki says .15: the conservative value.
 rRange=D.IreliaR.castRange,rSpeed=2000,rDelay=.5,rRadius=160,rBurst=320,qThrough=100,rBase=D.IreliaR.BaseMissileDamage,rAP=D.IreliaR.APRatio}}

end)()
profiles['Irelia']=profiles['Irelia']or {}
profiles['Irelia'].combat={id='normal',champion='Irelia',names={{'IreliaQ'},{'IreliaW','IreliaW2'},{'IreliaE','IreliaE2'},{'IreliaR'}},
  q={range=D.IreliaQ.castRange,type='physical',base=D.IreliaQ.BaseDamage,ad=.8,minionBase=50,minionLevel=11},
  w={range=775,type='physical',base=D.IreliaW.MinDamage,ad=.4,ap=.5},
  e={range=D.IreliaE.MaxRange,type='magical',base=D.IreliaE.BaseDamage,ap=1},r={range=D.IreliaR.castRange,type='magical',base=D.IreliaR.BaseMissileDamage,ap=D.IreliaR.APRatio},passiveNames={'IreliaPassiveStacksMax'},passiveBase=D.IreliaPassive.OnHitBaseDamage,passiveLevel=3,passiveAD=.2}
profiles['Jade_Irelia']=profiles['Jade_Irelia']or {}
profiles['Jade_Irelia'].combat={id='classic',champion='Irelia',names={{'Jade_IreliaQ'},{'Jade_IreliaW'},{'Jade_IreliaE'},{'Jade_IreliaR'}},
  q={range=D.Jade_IreliaQ.castRangeDisplayOverride,delay=.05,speed=D.Jade_IreliaQ.DashSpeedBonus,type='physical',base=D.Jade_IreliaQ.BaseDamage,ad=1},
  w={range=0,type='true',base=D.Jade_IreliaW.Damage},e={range=D.Jade_IreliaE.castRange,delay=.3,type='magical',base=D.Jade_IreliaE.BaseDamage,ap=D.Jade_IreliaE.APRatio},
  -- R: half width 120 (Jade_IreliaR own missile width 120; League_Classic/Irelia width 240). Speed 1600: the flying
  -- blade Jade_IreliaRSpell flies 1600 and the Classic page states 1600; Jade_IreliaR's own 779 matches neither and
  -- is unconfirmed until a live R trace (2026-10-28). The earlier half width 60 had no source.
  r={range=D.Jade_IreliaR.castRange,radius=D.Jade_IreliaR.mMissileWidth,delay=.25,speed=D.Jade_IreliaRSpell.mSpeed,type='physical',base=D.Jade_IreliaR.BaseMissileDamage,bonusAD=.6,ap=.5},
  wNames={'Jade_IreliaW_Buff'},wPassiveHeal=D.Jade_IreliaW.Health,wActiveHeal=D.Jade_IreliaW.HealthRestoreActive,wDuration=D.Jade_IreliaW.ActiveDuration,qRefund=D.Jade_IreliaQ.ManaReturn,
  eStun=D.Jade_IreliaE.StunDuration,rBlades=4,rChampionHeal=D.Jade_IreliaR.ChampionHealPercent/100,rMinionHeal=D.Jade_IreliaR.MinionHealPercent/100,passiveRadius=1400,passiveTenacity={.1,.25,.4}}
local normal,classic=profiles.Irelia.combat,profiles.Jade_Irelia.combat
classic.q.mobility=true
function normal.rawModifier(p,raw,s,slot,rank,stats,target,options,finite)
 if slot==0 and target and target.type~=stats.heroType and target.team~=300 then
  if not finite(stats.level)then return 0,'invalid_level'end
  raw=raw+p.q.minionBase+p.q.minionLevel*stats.level
 end
 return raw,s.type
end
function normal.passive(p,stats)
 return p.passiveBase+p.passiveLevel*stats.level+p.passiveAD*stats.bonusDamage,'magical'
end
function classic.heal(p,rank,stats,active)return(active and p.wActiveHeal or p.wPassiveHeal)[rank]or 0 end
return profiles

end
end
