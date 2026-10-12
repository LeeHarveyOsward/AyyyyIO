return function(require)
-- Primary: Riot patch 26.20; current active BIN calculations pinned in research/26.20-five-champions.
-- Separate profiles; damage raw, ratios scalar, durations seconds.
return {
 Jade_Fizz={qAP=.4,wAP=.2,wBase={10,15,20,25,30}},
 Jade_Graves={rCone={140,230,320},rConeAD=1},
 Jade_Fiora={wBonusAD={10,15,20,25,30}},
 Jade_Nautilus={shieldHP={.15,.15,.15,.15,.15},shieldStat='bonusHealth',shieldDuration=10,wDotBase={40,65,90,115,140},wDotAP=.4,wDotDuration=2},
 Jade_Kennen={wPassiveBase={25,40,55,70,85},wPassiveBonusAD=1},
 Yunara={qBase={3,8,13,18,23},qAP=.2},
 items={normal={hexplateRangedAS=.25,hexplateRangedMS=.1,rocketbeltHaste=10,rocketbeltDamage=135,rocketbeltAP=.15,hurricaneAD=.60},
  classic={spiritVisageHP5=20,forceOfNatureHP5=40,warmogHP5=30}},
}

end
