return function(require)
return function()
-- Shared Viktor mechanics data. Values preserved from the maintained controller.
return {Viktor={id='normal',q='ViktorQ',w='ViktorW',e='ViktorE',r='ViktorR',r2='ViktorRGuide',
 qBase={60,75,90,105,120},qAP=.4,qHit={20,45,70,95,120},qHitAP=.5,qRange=600,qSpeed=2000,qDelay=.25,qLife=2.5,
 shieldMin=40,shieldMax=140,shieldAP=.25,shieldAug=1.6,qMS=.3,
 -- Q shield offered to Evade. Amount "40 - 140 (based on level) (+ 25% AP)" for 2.5 seconds, cast time 0.25, target
 -- range 600, augment "+60%" (64 - 224 +40% AP): https://wiki.leagueoflegends.com/en-us/Template:Data_Viktor/Siphon_Power
 -- and https://wiki.leagueoflegends.com/en-us/Viktor, read 2026-10-08; the installed asset agrees (ShieldAPRatio .25,
 -- AugmentShieldBonus, BuffDuration 2.5, level calculation 40..140). The page words the shield as part of the cast
 -- ("throws a draining device at the target enemy ... grants himself a shield") and only the augment's movement speed
 -- as "after the device hits", so the shield is taken as granted when the 0.25 s cast completes. No per-level table is
 -- published: the offer promises the level-1 amount (40 + 25% AP, x1.6 augmented), a lower bound at every level.
 shieldDuration=2.5,
 shieldSource='Viktor Q: https://wiki.leagueoflegends.com/en-us/Template:Data_Viktor/Siphon_Power and https://wiki.leagueoflegends.com/en-us/Viktor read 2026-10-08 (shield 40 - 140 by level + 25% AP for 2.5 seconds, cast time 0.25, target range 600, augmented +60%) and installed asset research/family-assets/Viktor/spells.json (ShieldAPRatio, AugmentShieldBonus, BuffDuration, shield calculation 40..140); offered amount is the level-1 lower bound; shield taken as granted at the end of the cast',
 -- Wiki figures that differ from the installed asset (asset kept, it is the matching profile; not measured live):
 -- E width 90 and "range 500" (asset: missile radius 80, LaserRange 700), W effect radius 340, cast 0.25, arms after
 -- 0.75 s (asset: Size 275; the 0.3 delay below is a prediction candidate), read 2026-10-08.
 eBase={70,110,150,190,230},eAP=.5,eAfter={20,50,80,110,140},eAfterAP=.8,eAfterDelay=1,eMinion=.5,
 eStart=525,eLength=700,eRadius=80,eSpeed=1050,eDelay=0,
 wRange=800,wRadius=275,wDelay=.3,wDwell=1.25,wStun=1.5,wLife=4,wAugSlow=.2,
 -- Ranking 2026-10-10 (dossier Viktor-9/12, wiki Viktor V26.16 read 2026-10-10):
 --  wArm: W cast 0.25 + activation 0.75; the field is predicted where the target is once it is active (the old
 --   wDelay .3 predicted long before). The wiki radius 340 is not used for counting until the viktor_w_field dev trace
 --   settles it against the asset Size 275 (275 is the conservative of the two).
 --  qHitAD: Q discharge 20-120 (+100% AD) (+50% AP) magic; the asset row lacks the AD term.
 wArm=1,qHitAD=1,
 rBase={100,175,250},rAP=.5,rTick={65,105,145},rTickAP=.35,rRange=700,rGuide=20000,rRadius=325,rLife=6.5,rCadence=1,rMaxTicks=6,
 rGrow=.4,rMaxGrowth=6,rExtension=3,rFast=275,rSlow=200,
 fragments='viktorpassivecount',qEmpower='viktorqbuff',qReturn='viktorqreturn',rTimer='viktorrtimer',rMark='viktorrguide'}}

end
end
