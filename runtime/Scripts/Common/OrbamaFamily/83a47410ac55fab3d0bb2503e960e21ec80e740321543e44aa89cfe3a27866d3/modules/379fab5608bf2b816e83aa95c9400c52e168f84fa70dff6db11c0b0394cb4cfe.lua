return function(require)
return function()
-- Shared Viktor mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 ViktorE={
  AftershockAPRatio=.8,BaseDamageLaser={70,110,150,190,230},Delay=1,LaserAPRatio=.5,missileSpeed=1050,
 },
 ViktorW={
  Size=275,StunDuration=1.5,castFrameSeconds=.3,castRange=800,
 },
 ViktorR={
  InitialBurstBaseDamage={100,175,250},StormRadius=325,SubsequentBurstAPRaio=.35,
 },
 ViktorQ={
  BuffDuration=2.5,MissileDamage={60,75,90,105,120},ShieldAPRatio=.2,castRange=600,mSpeed=2000,
 },
}
end)()
return {Viktor={id='normal',q='ViktorQ',w='ViktorW',e='ViktorE',r='ViktorR',r2='ViktorRGuide',
 qBase=D.ViktorQ.MissileDamage,qAP=.4,qHit={20,45,70,95,120},qHitAP=.5,qRange=D.ViktorQ.castRange,qSpeed=D.ViktorQ.mSpeed,qDelay=.25,qLife=2.5,
 shieldMin=30,shieldMax=130,shieldAP=D.ViktorQ.ShieldAPRatio,shieldAug=1.6,qMS=.3,
 -- Current installed Q shield: 30..130 by level plus 20% AP, lasting 2.5 s.
 -- The offer uses the level-1 lower bound and the existing 60% augment multiplier.
 -- Current source pins and patch notes are in implementation/family/current-patch.json.
 shieldDuration=D.ViktorQ.BuffDuration,
 shieldSource='Current installed ViktorQ ShieldAPRatio, AugmentShieldBonus, BuffDuration and level calculation; implementation/family/current-patch.json. Offered amount is the level-1 lower bound, granted at cast completion.',
 -- Wiki figures that differ from the installed asset (asset kept, it is the matching profile; not measured live):
 -- E width 90 and "range 500" (asset: missile radius 80, LaserRange 700), W effect radius 340, cast 0.25, arms after
 -- 0.75 s (asset: Size 275; the 0.3 delay below is a prediction candidate), read 2026-10-08.
 eBase=D.ViktorE.BaseDamageLaser,eAP=D.ViktorE.LaserAPRatio,eAfter={20,50,80,110,140},eAfterAP=D.ViktorE.AftershockAPRatio,eAfterDelay=D.ViktorE.Delay,eMinion=.5,
 eStart=525,eLength=700,eRadius=80,eSpeed=D.ViktorE.missileSpeed,eDelay=0,
 wRange=D.ViktorW.castRange,wRadius=D.ViktorW.Size,wDelay=D.ViktorW.castFrameSeconds,wDwell=1.25,wStun=D.ViktorW.StunDuration,wLife=4,wAugSlow=.2,
 -- Ranking 2026-10-10 (dossier Viktor-9/12, wiki Viktor V26.16 read 2026-10-10):
 --  wArm: W cast 0.25 + activation 0.75; the field is predicted where the target is once it is active (the old
 --   wDelay .3 predicted long before). The wiki radius 340 is not used for counting until the viktor_w_field dev trace
 --   settles it against the asset Size 275 (275 is the conservative of the two).
 --  qHitAD: Q discharge 20-120 (+100% AD) (+50% AP) magic; the asset row lacks the AD term.
 wArm=1,qHitAD=1,
 rBase=D.ViktorR.InitialBurstBaseDamage,rAP=.5,rTick={65,105,145},rTickAP=D.ViktorR.SubsequentBurstAPRaio,rRange=700,rGuide=20000,rRadius=D.ViktorR.StormRadius,rLife=6.5,rCadence=1,rMaxTicks=6,
 rGrow=.4,rMaxGrowth=6,rExtension=3,rFast=275,rSlow=200,
 fragments='viktorpassivecount',qEmpower='viktorqbuff',qReturn='viktorqreturn',rTimer='viktorrtimer',rMark='viktorrguide'}}

end
end
