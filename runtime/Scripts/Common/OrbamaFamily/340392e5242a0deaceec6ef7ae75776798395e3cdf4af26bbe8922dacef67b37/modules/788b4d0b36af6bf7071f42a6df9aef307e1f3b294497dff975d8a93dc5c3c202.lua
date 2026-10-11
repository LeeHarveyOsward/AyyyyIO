return function(require)
return function()
-- Shared Jhin mechanics data. Values preserved from the maintained controller.
-- Reviewed 2026-10-08: qRange 550 is an EDGE range (the wiki's "Edge range" icon on TARGET RANGE: 550; the bounce
--  EFFECT RADIUS 450 carries "Centered range"; speed 1800 / 600, cast 0.25),
--  https://wiki.leagueoflegends.com/en-us/Template:Data_Jhin/Dancing_Grenade. qRangeEdge=true tells the controller to
--  add both gameplay radii for a centre-to-centre check. Live reach is not yet measured.
return {Jhin={id='normal',q='JhinQ',w='JhinW',e='JhinE',r='JhinR',rShot='JhinRShot',
 qBase={44,69,94,119,144},qAD={.44,.515,.59,.665,.74},qAP=.6,qRange=550,qRangeEdge=true,qBounces=3,qBounce=450,qAmp=.35,
 wBase={70,105,140,175,210},wAD=.5,wRange=2500,wDelay=.75,wSpeed=5000,wRadius=40,mark='jhinespotteddebuff',
 -- E arming: asset TrapArmTime .75 against the wiki's 1 s (V26.16). Until the dev trace jhin_trap_spawn settles it,
 -- the conservative 1 s is used (an enemy freed before the trap arms walks out); eArmAsset keeps the asset value.
 -- E damage 20/80/140/200/260 +120% AD +100% AP magic, 65% to minions (asset JhinE BaseDamage/ReducedDamagePercent).
 eRange=750,eArm=1,eArmAsset=.75,eDetonation=2,eRadius=260,eTrigger=160,eSpeed=1600,eCast=.25,
 eBase={20,80,140,200,260},eAD=1.2,eAP=1,eMinion=.65,
 rBase={64,128,192},rAD=.25,rMissing=3,rFourth=2,rRange=3500,rSpeed=5000,rRadius=80,rDelay=.25,rInterval=1,rHalfAngle=30.6,
 reload='JhinPassiveReload',passive='JhinPassiveAttackBuff',reloadTime=2.5}}

end
end
