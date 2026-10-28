return function(require)
return function()
-- Shared Vayne mechanics data. Values preserved from the maintained controller.
-- E damage (2026-10-10, vayne-provenance.json): Normal research/family-assets/Vayne/spells.json VayneCondemn
-- Damage 50..190 (+50% bonus AD; wiki V26.20), terrain hit StunDamage x1.5 = 75..285 (+75% bonus AD).
-- Classic research/family-assets/Jade_Vayne/spells.json Jade_VayneE FirstHitDamage = SecondHitDamage 45..185,
-- 0.5 bonus AD each. Classic Q under R: Jade_VayneQ scalingDamageUlt .40..60 (ScalingDamage .30..50 otherwise).
-- stealth: alias lists from the installed assets (InquisitionStealth and the Q fade buff); which one the host
-- shows after Q under R is recorded by the vayne_stealth_buffs development trace (not live-verified).
local D=(function()
return {
 VayneCondemnMissile={
  mSpeed=2200,
 },
 VayneCondemn={
  Damage={50,85,120,155,190},KnockbackDistance=475,castRange=550,
 },
 VayneTumble={
  APRatio=.5,TotalADRatio={.75,.85,.95,1.05,1.15},
 },
 Jade_VayneE={
  FirstHitDamage={45,80,115,150,185},SecondHitDamage={45,80,115,150,185},castRange=550,
 },
 Jade_VayneQ_Bonus={
  ScalingDamage={.3,.35,.4,.45,.5},scalingDamageUlt={.4,.45,.5,.55,.6},
 },
}
end)()
-- Condemn's stationary cast time is declared to the shared cast-time gate.
return {
 Jade_Vayne={id='classic',wBuff='Jade_VayneW_Debuff',qBuff={'Jade_VayneQ_Bonus'},qSdkBuff='jade_vayneq_bonus',qRatio=D.Jade_VayneQ_Bonus.ScalingDamage,qRatioUlt=D.Jade_VayneQ_Bonus.scalingDamageUlt,qAP=0,rBuff='Jade_VayneR',stealth={'Jade_VayneInquisitionStealth','Jade_VayneQ_Fade'},eRange=D.Jade_VayneE.castRange,eKnockback=475,
  eBase=D.Jade_VayneE.FirstHitDamage,eAD=.5,eTerrain=D.Jade_VayneE.SecondHitDamage,eTerrainAD=.5,eCastTime=.25},
 Vayne={id='normal',wBuff='VayneSilveredDebuff',qBuff={'VayneTumble','VayneTumbleBonus'},qSdkBuff='vaynetumblebonus',qRatio=D.VayneTumble.TotalADRatio,qAP=D.VayneTumble.APRatio,rBuff='VayneInquisition',stealth={'VayneInquisitionStealth','VayneTumbleFade'},eRange=D.VayneCondemn.castRange,eKnockback=D.VayneCondemn.KnockbackDistance,
  eBase=D.VayneCondemn.Damage,eAD=.5,eTerrain={75,127.5,180,232.5,285},eTerrainAD=.75,eCastTime=.25},
}

end
end
