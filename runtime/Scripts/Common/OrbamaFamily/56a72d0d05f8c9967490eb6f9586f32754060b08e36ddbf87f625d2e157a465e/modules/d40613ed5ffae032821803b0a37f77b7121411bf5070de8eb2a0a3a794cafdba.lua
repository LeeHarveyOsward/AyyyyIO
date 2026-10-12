return function(require)
return function()
-- Shared Vayne mechanics data. Values preserved from the maintained controller.
-- E damage (2026-10-10, vayne-provenance.json): Normal research/family-assets/Vayne/spells.json VayneCondemn
-- Damage 50..190 (+50% bonus AD; wiki V26.20), terrain hit StunDamage x1.5 = 75..285 (+75% bonus AD).
-- Classic research/family-assets/Jade_Vayne/spells.json Jade_VayneE FirstHitDamage = SecondHitDamage 45..185,
-- 0.5 bonus AD each. Classic Q under R: Jade_VayneQ scalingDamageUlt .40..60 (ScalingDamage .30..50 otherwise).
-- stealth: alias lists from the installed assets (InquisitionStealth and the Q fade buff); which one the host
-- shows after Q under R is recorded by the vayne_stealth_buffs development trace (not live-verified).
return {
 Jade_Vayne={id='classic',wBuff='Jade_VayneW_Debuff',qBuff={'Jade_VayneQ_Bonus'},qSdkBuff='jade_vayneq_bonus',qRatio={.30,.35,.40,.45,.50},qRatioUlt={.40,.45,.50,.55,.60},qAP=0,rBuff='Jade_VayneR',stealth={'Jade_VayneInquisitionStealth','Jade_VayneQ_Fade'},eRange=550,eKnockback=475,
  eBase={45,80,115,150,185},eAD=.5,eTerrain={45,80,115,150,185},eTerrainAD=.5},
 Vayne={id='normal',wBuff='VayneSilveredDebuff',qBuff={'VayneTumble','VayneTumbleBonus'},qSdkBuff='vaynetumblebonus',qRatio={.75,.85,.95,1.05,1.15},qAP=.5,rBuff='VayneInquisition',stealth={'VayneInquisitionStealth','VayneTumbleFade'},eRange=550,eKnockback=475,
  eBase={50,85,120,155,190},eAD=.5,eTerrain={75,127.5,180,232.5,285},eTerrainAD=.75},
}

end
end
