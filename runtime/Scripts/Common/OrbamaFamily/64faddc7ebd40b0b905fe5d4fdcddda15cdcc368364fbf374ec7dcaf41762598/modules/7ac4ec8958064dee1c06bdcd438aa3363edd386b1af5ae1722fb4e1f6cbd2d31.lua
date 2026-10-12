return function(require)
return function()
-- Shared Jax mechanics data. Values preserved from the maintained controller.
return {
 Jax={id='normal',q={'JaxQ','JaxLeapStrike'},w='JaxW',e={'JaxE','JaxCounterStrike'},r='JaxR',
  eBuff={'JaxCounterStrike','JaxE'},wBuff='JaxW',wBuffAliases={'JaxW','JaxEmpowerTwo'},wAttack='JaxWAttack',wBase={50,85,120,155,190},wAP=.6,wPrepare=.15,rKind='active_swing',
  -- Q 65-225 (+100% bonus AD) physical; R swing 100/175/250 (+100% AP) magic, radius 375, cast 0.25 s.
  qBase={65,105,145,185,225},qBonusAD=1,qAP=0,qKind='physical',rBase={100,175,250},rAP=1,rRadius=375,rCast=.25,
  damageSource='https://wiki.leagueoflegends.com/en-us/Jax read 2026-10-08 (last changed V26.12)',
  -- Counter Strike recast: 40-160 (+70% AP) (+4% target max HP) magic, +20% per dodged attack up to 5 (2x);
  -- dodge window 2 s, no cast time; dodges every non-turret basic attack.
  eBase={40,70,100,130,160},eAP=.7,eHP=.04,eBonusAD=0,eKind='magical',eDodgeBonus=.2,eMaxDodges=5,eDuration=2,eDelay=0,
  eSource='https://wiki.leagueoflegends.com/en-us/Jax read 2026-10-10 (last changed V26.12): E recast damage, 2 s dodge, cast time none'},
 Jade_Jax={id='classic',q={'Jade_JaxQ','Jade_JaxLeapStrike'},w='Jade_JaxW',e={'Jade_JaxE','Jade_JaxCounterStrike'},r='Jade_JaxR',
  eBuff={'Jade_JaxE'},wBuff='Jade_JaxW',wAttack='Jade_JaxWAttack',wBase={40,60,80,100,120},wAP=.2,wPrepare=.55,rKind='passive_slot',
  -- Q BaseDamage 50-150, ADRatio 1, APRatio .8 (asset); the wiki reads the AD part as bonus AD. Its damage
  -- type is not established (the wiki page contradicts itself), so qKind stays nil and the controller takes
  -- the lower of the physical and the magical result.
  qBase={50,75,100,125,150},qBonusAD=1,qAP=.8,
  damageSource='research/family-assets/Jade_Jax/spells.json Jade_JaxLeapStrike DataValues; https://wiki.leagueoflegends.com/en-us/League_Classic/Jax read 2026-10-08',
  -- W ADRatio .2 (asset); the wiki reads it as bonus AD, the lower claim.
  wBonusAD=.2,
  -- Counter Strike recast (asset Jade_JaxE DataValues: BaseDamage 50-150, ADRatio .5, PercentIncreasedPerDodge .2,
  -- MaxDodgesForDamageIncrease 5, DodgeDuration 2; no cast-time field). The wiki reads the AD part as bonus AD and
  -- the damage as physical.
  eBase={50,75,100,125,150},eAP=0,eHP=0,eBonusAD=.5,eKind='physical',eDodgeBonus=.2,eMaxDodges=5,eDuration=2,eDelay=0,
  eSource='research/family-assets/Jade_Jax/spells.json Jade_JaxE DataValues; https://wiki.leagueoflegends.com/en-us/League_Classic/Jax read 2026-10-10'},
}

end
end
