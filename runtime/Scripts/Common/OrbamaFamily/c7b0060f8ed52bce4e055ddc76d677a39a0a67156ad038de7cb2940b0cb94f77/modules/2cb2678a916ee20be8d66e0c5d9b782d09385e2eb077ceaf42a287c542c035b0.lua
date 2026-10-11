return function(require)
return function()
-- Shared Amumu mechanics data. Values preserved from the maintained controller.
-- wRadius: installed asset 300 (both profiles); the wiki (read 2026-10-10) says 350. Kept at the asset
-- value until 'amumu_w_edge' development traces show damage ticks beyond 300 (Amumu-4).
-- 2026-10-10 re-examined: AuraofDespair / Jade_AmumuAuraofDespair carry only castRange 300 and castRadius 300
-- (the self-toggle's indicator fields; no separate effect/damage radius exists in the client data), so no field
-- settles it. wRadius stays the confirmed (conservative) radius; Normal wReach 350 (wiki V25.18, KillerAmumu) is
-- the switch-on/keep-on reach so Despair is never off where it could already hurt. Classic has no second source.
return {
 Amumu={id='normal',q='BandageToss',w='AuraofDespair',e='Tantrum',r='CurseoftheSadMummy',
  charges=2,passive='AmumuPDebuff',passiveKind='true_damage_amp',qBase={70,95,120,145,170},qAP=.85,
   eBase={65,95,125,155,185},eAP=.5,rBase={200,300,400},rAP=.8,rInterrupt=true,wRadius=300,wReach=350},
 Jade_Amumu={id='classic',q='Jade_AmumuBandageToss',w='Jade_AmumuAuraofDespair',e='Jade_AmumuTantrum',r='Jade_AmumuCurseoftheSadMummy',
  charges=0,passive='Jade_AmumuCursedTouch',passiveKind='magic_resist_reduction',qBase={80,140,200,260,320},qAP=.7,
   eBase={65,95,125,150,175},eAP=.5,rBase={150,250,350},rAP=.8,rInterrupt=false,wRadius=300},
}

end
end
