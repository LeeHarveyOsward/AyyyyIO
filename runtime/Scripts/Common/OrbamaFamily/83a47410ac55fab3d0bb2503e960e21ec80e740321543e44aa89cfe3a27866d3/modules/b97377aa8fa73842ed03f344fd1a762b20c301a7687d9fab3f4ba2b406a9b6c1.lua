return function(require)
return function()
-- Shared Amumu mechanics data. Values preserved from the maintained controller.
-- wRadius: installed asset 300 (both profiles); the wiki (read 2026-10-10) says 350. Kept at the asset
-- value until 'amumu_w_edge' development traces show damage ticks beyond 300 (Amumu-4).
-- 2026-10-10 re-examined: AuraofDespair / Jade_AmumuAuraofDespair carry only castRange 300 and castRadius 300
-- (the self-toggle's indicator fields; no separate effect/damage radius exists in the client data), so no field
-- settles it. wRadius stays the confirmed (conservative) radius; Normal wReach 350 (wiki V25.18, KillerAmumu) is
-- the switch-on/keep-on reach so Despair is never off where it could already hurt. Classic has no second source.
local D=(function()
return {
 CurseoftheSadMummy={
  RCoefficient=.8,RDamage={200,300,400},
 },
 AuraofDespair={
  castRadius=300,
 },
 Tantrum={
  BaseDamage={65,95,125,155,185},castRadius=350,
 },
 BandageToss={
  BaseDamage={70,95,120,145,170},
 },
 Jade_AmumuAuraofDespair={
  castRadius=300,
 },
 Jade_AmumuCurseoftheSadMummy={
  RCoefficient=.8,RDamage={150,250,350},
 },
 Jade_AmumuBandageToss={
  APRatio=.7,BaseDamage={80,140,200,260,320},
 },
}
end)()
return {
 Amumu={id='normal',q='BandageToss',w='AuraofDespair',e='Tantrum',r='CurseoftheSadMummy',
  charges=2,passive='AmumuPDebuff',passiveKind='true_damage_amp',qBase=D.BandageToss.BaseDamage,qAP=.85,
   eBase=D.Tantrum.BaseDamage,eAP=.5,rBase=D.CurseoftheSadMummy.RDamage,rAP=D.CurseoftheSadMummy.RCoefficient,rInterrupt=true,wRadius=D.AuraofDespair.castRadius,wReach=D.Tantrum.castRadius},
 Jade_Amumu={id='classic',q='Jade_AmumuBandageToss',w='Jade_AmumuAuraofDespair',e='Jade_AmumuTantrum',r='Jade_AmumuCurseoftheSadMummy',
  charges=0,passive='Jade_AmumuCursedTouch',passiveKind='magic_resist_reduction',qBase=D.Jade_AmumuBandageToss.BaseDamage,qAP=D.Jade_AmumuBandageToss.APRatio,
   eBase={65,95,125,150,175},eAP=.5,rBase=D.Jade_AmumuCurseoftheSadMummy.RDamage,rAP=D.Jade_AmumuCurseoftheSadMummy.RCoefficient,rInterrupt=false,wRadius=D.Jade_AmumuAuraofDespair.castRadius},
}

end
end
