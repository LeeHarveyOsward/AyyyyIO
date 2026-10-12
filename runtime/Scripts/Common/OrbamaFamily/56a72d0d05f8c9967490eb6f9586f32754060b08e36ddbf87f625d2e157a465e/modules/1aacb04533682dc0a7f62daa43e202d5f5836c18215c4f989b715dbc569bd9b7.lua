return function(require)
return function()
-- Shared Jinx mechanics data. Values preserved from the maintained controller.
return {Jinx={id='normal',q='JinxQ',w='JinxW',e='JinxE',r='JinxR',
 qRange={100,125,150,175,200},qSplash=250,qAD=1.1,qMana=20,qStacks=3,qStackLife=2.5,qAS={30,55,80,105,130},
 wBase={10,60,110,160,210},wAD=1.4,wRange=1450,wSpeed=3300,wRadius=60,wMin=.4,wBaseDelay=.6,wASScalar=.08,
 -- eEffect: chomper effect radius 225 (wiki Jinx V26.16, read 2026-10-10); land/arm timing stays the asset-based
 -- conservative 0.5 + d/1750 + 0.5 until the jinx_e_land trace measures it (wiki: no cast time, lands after 0.4 s).
 eRange=925,eArm=.5,eDuration=5,eSpeed=1750,eDelay=.5,eRadius=120,eEffect=225,
 rMin={20,35,50},rMax={200,350,500},rMinAD=.12,rMaxAD=1.2,rMissing={.25,.30,.35},rSplash=400,rSecondary=.8,
 -- rMonsterCap: missing-health part against monsters (spells.json JinxR MonsterExecuteMax 1200; wiki V26.16).
 rMonsterCap=1200,rRange=25000,rRadius=140,rDelay=.6,rSpeed=1700,rDamageDistance=1500}}

end
end
