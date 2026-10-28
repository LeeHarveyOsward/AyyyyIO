return function(require)
return function()
-- Shared Normal Seraphine data; no Classic mechanics are inferred.
local D=(function()
return {
 SeraphineW={
  ShieldAPRatio=.2,ShieldDuration=2.5,ShieldStrength={60,80,100,120,140},WMissingHPBase={8,10,12,14,16},
 },
 SeraphineE={
  APRatio=.5,BaseDamage={70,100,130,160,190},
 },
 SeraphineQ={
  BaseDamage={60,85,110,135,160},
 },
 SeraphineR={
  R1BaseDamage={150,200,250},
 },
}
end)()
return {
 Seraphine={id='normal',q='SeraphineQ',w='SeraphineW',e='SeraphineE',r='SeraphineR',
  qBase=D.SeraphineQ.BaseDamage,qAP=.4,eBase=D.SeraphineE.BaseDamage,eAP=D.SeraphineE.APRatio,eMinion=.7,
  -- High Note against champions and monsters: "the damage is increased by 0% - 75% (based on target's missing health)",
  -- maximum 105..280 (+70% AP) = base x1.75 (https://wiki.leagueoflegends.com/en-us/Template:Data_Seraphine/High_Note,
  -- read 2026-10-08). The page does not say at which missing health the maximum is reached. qMissingMax is therefore
  -- applied as the most conservative linear reading, +75% only at 100% missing health (bonus = .75 x missing share);
  -- a curve that caps earlier deals more. Used only as a lower bound by the champion finisher.
  qMissingMax=.75,
  -- Stage Presence (Echo): the next basic ability "casts an additional time" 0.033 s after the first
  -- (https://wiki.leagueoflegends.com/en-us/Seraphine, read 2026-10-10). The repeat is assumed to deal the
  -- original cast's damage; the dev trace seraphine_damage_sample (two health drops per echoed Q/E) settles it.
  echoDelay=.033,
  echoSource='https://wiki.leagueoflegends.com/en-us/Seraphine (Stage Presence: additional cast after 0.033 s), read 2026-10-10',
  -- Surround Sound: shield 60/80/100/120/140 (+20% AP) for 2.5 s, cast time 0.25, radius 800
  -- (https://wiki.leagueoflegends.com/en-us/Template:Data_Seraphine/Surround_Sound, read 2026-10-08).
  rBase=D.SeraphineR.R1BaseDamage,rAP=.4,shield=D.SeraphineW.ShieldStrength,shieldAP=D.SeraphineW.ShieldAPRatio,shieldDuration=D.SeraphineW.ShieldDuration,heal=D.SeraphineW.WMissingHPBase,
  shieldSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Seraphine/Surround_Sound (shield 60/80/100/120/140 +20% AP, 2.5 s, cast 0.25), read 2026-10-08; base ranks also in research/family-assets/Seraphine/spells.json SeraphineW ShieldStrength'}
}

end
end
