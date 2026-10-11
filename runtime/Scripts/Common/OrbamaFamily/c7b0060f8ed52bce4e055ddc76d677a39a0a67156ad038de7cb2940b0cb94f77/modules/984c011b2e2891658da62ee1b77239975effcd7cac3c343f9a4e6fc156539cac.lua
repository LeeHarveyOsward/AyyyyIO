return function(require)
return function()
-- Shared Irelia Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
local profiles=(function()
-- Shared Irelia mechanics data. Values preserved from the maintained controller.
return {Irelia={id='normal',q='IreliaQ',w='IreliaW',w2='IreliaW2',e='IreliaE',e2='IreliaE2',r='IreliaR',
 mark='IreliaMark',passive='IreliaPassiveStacks',passiveMax='IreliaPassiveStacksMax',defense='IreliaWDefense',
 qRange=600,qSpeed=1400,qBase={5,25,45,65,85},qAD=.8,qMinionBase=50,qMinionLevel=11,
 stacks=4,passiveBase=10,passiveLevel=3,passiveAD=.2,eRange=775,eDelay=.3,eRev=.35,eRadius=70,eDuration=3.5,eRecast=.25,
 eBase={70,110,150,190,230},eAP=1,wRange=775,wRadius=100,wMax=1.5,wFull=.75,wBase={10,20,30,40,50},wAD=.4,wAP=.5,wMaxBonus=2,
 wPhysicalDR={40,70},wDRAP=.08,wMagicDR=.5,
 -- 2026-10-10: W minimum +40% AD +50% AP (installed IreliaW calculation 368633251: .4 on stat 2 = AD, as Q's .8;
 -- .5 on the default stat = AP; wiki V26.17 agrees; the earlier .5 AD/.4 AP read the two terms swapped).
 -- R castRange 1000 (installed castRange, wiki V26.17; 950 is only the display override). Cast time: the installed
 -- asset says .5 (field 7c4baddc), the wiki .4; the asset value is kept.
 -- rBurst: radius around the first champion hit that the burst also marks. Not published: the 320 line width is
 -- used as a lower bound until development 'irelia_r' traces (marked champions per cast) settle it.
 -- qThrough: wiki V26.17 "dashes 100 units through the target"; unverified, used only as an extra Evade landing check.
 -- eRecast stays .25 (installed CDBetweenCast) where the wiki says .15: the conservative value.
 rRange=1000,rSpeed=2000,rDelay=.5,rRadius=160,rBurst=320,qThrough=100,rBase={125,200,275},rAP=1}}

end)()
profiles['Irelia']=profiles['Irelia']or {}
profiles['Irelia'].combat={id='normal',champion='Irelia',names={{'IreliaQ'},{'IreliaW','IreliaW2'},{'IreliaE','IreliaE2'},{'IreliaR'}},
  q={range=600,type='physical',base={5,25,45,65,85},ad=.8,minionBase=50,minionLevel=11},
  w={range=775,type='physical',base={10,20,30,40,50},ad=.4,ap=.5},
  e={range=775,type='magical',base={70,110,150,190,230},ap=1},r={range=1000,type='magical',base={125,200,275},ap=1},passiveNames={'IreliaPassiveStacksMax'},passiveBase=10,passiveLevel=3,passiveAD=.2}
profiles['Jade_Irelia']=profiles['Jade_Irelia']or {}
profiles['Jade_Irelia'].combat={id='classic',champion='Irelia',names={{'Jade_IreliaQ'},{'Jade_IreliaW'},{'Jade_IreliaE'},{'Jade_IreliaR'}},
  q={range=620,delay=.05,speed=1400,type='physical',base={20,50,80,110,140},ad=1},
  w={range=0,type='true',base={15,30,45,60,75}},e={range=325,delay=.3,type='magical',base={80,130,180,230,280},ap=.5},
  r={range=1200,radius=60,delay=.25,speed=1600,type='physical',base={80,120,160},bonusAD=.6,ap=.5},
  wNames={'Jade_IreliaW_Buff'},wPassiveHeal={5,7,9,11,13},wActiveHeal={10,14,18,22,26},wDuration=6,qRefund=35,
  eStun={1,1.25,1.5,1.75,2},rBlades=4,rChampionHeal=.25,rMinionHeal=.1,passiveRadius=1400,passiveTenacity={.1,.25,.4}}
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
