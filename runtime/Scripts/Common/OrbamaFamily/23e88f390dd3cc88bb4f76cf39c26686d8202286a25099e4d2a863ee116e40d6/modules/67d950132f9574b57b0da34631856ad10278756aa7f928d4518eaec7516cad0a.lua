return function(require)
return function()
-- Shared Janna mechanics data. Values preserved from the maintained controller.
local D=(function()
return {
 ReapTheWhirlwind={
  Duration=3,Range=700,
 },
 EyeOfTheStorm={
  BaseShield={80,120,160,200,240},ShieldAPRatio=.55,ShieldDuration=4,castRange=800,
 },
 HowlingGale={
  BaseRange=1100,MaxDuration=3,MissileTravelTime=1.25,
 },
 SowTheWind={
  APRatio=.5,BaseDamage={55,85,115,145,175},mCastTime=.245,mSpeed=1600,
 },
 Jade_JannaReapTheWhirlwind={
  APRatioPerSecond=.35,HealBasePerSecond={70,110,150},MaxChannelDuration=4,
 },
 Jade_JannaSowTheWind={
  APRatio=.6,BaseDamage={60,115,170,225,280},mSpeed=1600,
 },
 Jade_JannaHowlingGaleSpell={
  mSpeed=900,
 },
 Jade_JannaHowlingGale={
  BaseRange=1100,MaxDuration=3,MissileTravelTime=1.25,
 },
 Jade_JannaEyeOfTheStorm={
  BaseShield={80,120,160,200,240},ShieldAPRatio=.9,ShieldDuration=5,castRange=800,
 },
}
end)()
return {
    -- 2026-10-08: E shield, W missile and R area were read from the matching page of each profile (`source`).
    -- Both pages give Q speed 880-1408 and width 240 by charge; the controller keeps its asset speed and a
    -- radius of 100 as the prediction inset for the short charges it releases (not corrected: unmeasured).
    classic={id='classic',qBegin='Jade_JannaHowlingGale',qRelease='Jade_JannaHowlingGaleSpell',
        rName='Jade_JannaReapTheWhirlwind',qSpeed=D.Jade_JannaHowlingGaleSpell.mSpeed,wBase=D.Jade_JannaSowTheWind.BaseDamage,wAP=D.Jade_JannaSowTheWind.APRatio,wEdge=false,
        wDelay=.25,wSpeed=D.Jade_JannaSowTheWind.mSpeed,rRadius=700,eRange=D.Jade_JannaEyeOfTheStorm.castRange,eTurrets=true,
        eShield=D.Jade_JannaEyeOfTheStorm.BaseShield,eShieldAP=D.Jade_JannaEyeOfTheStorm.ShieldAPRatio,eDuration=D.Jade_JannaEyeOfTheStorm.ShieldDuration,eDelay=0,
        source='research/family-assets/Jade_Janna/spells.json:1754-1817 (BaseShield, ShieldAPRatio .9, ShieldDuration 5) and https://wiki.leagueoflegends.com/en-us/League_Classic/Janna (read 2026-10-08)',
        -- 2026-10-10, https://wiki.leagueoflegends.com/en-us/League_Classic/Janna: Q range 1100 + 20 % per second of
        -- charge (1760 at 3 s), constant 1.25 s travel; R heals 70/110/150 (+35 % AP) per second for 4 s.
        qBaseRange=D.Jade_JannaHowlingGale.BaseRange,qChargeRate=220,qMaxCharge=D.Jade_JannaHowlingGale.MaxDuration,qTravel=D.Jade_JannaHowlingGale.MissileTravelTime,
        rHeal=D.Jade_JannaReapTheWhirlwind.HealBasePerSecond,rHealAP=D.Jade_JannaReapTheWhirlwind.APRatioPerSecond,rTick=1,rChannel=D.Jade_JannaReapTheWhirlwind.MaxChannelDuration},
    normal={id='normal',qBegin='HowlingGale',qRelease='HowlingGaleSpell',
        rName='ReapTheWhirlwind',qSpeed=667.666992,wBase=D.SowTheWind.BaseDamage,wAP=D.SowTheWind.APRatio,wEdge=true,
        wDelay=D.SowTheWind.mCastTime,wSpeed=D.SowTheWind.mSpeed,rRadius=D.ReapTheWhirlwind.Range,eRange=D.EyeOfTheStorm.castRange,eTurrets=true,
        eShield=D.EyeOfTheStorm.BaseShield,eShieldAP=D.EyeOfTheStorm.ShieldAPRatio,eDuration=D.EyeOfTheStorm.ShieldDuration,eDelay=0,
        source='https://wiki.leagueoflegends.com/en-us/Janna and Template:Data_Janna/Eye_of_the_Storm (read 2026-10-08)',
        -- 2026-10-10, https://wiki.leagueoflegends.com/en-us/Janna and the installed HowlingGale record
        -- (BaseRange 1100, ChargeDistancePercent 20, MissileTravelTime 1.25, MaxDuration 3): range 1100-1760 by charge,
        -- constant 1.25 s travel. R heals 25/37.5/50 (+12.5 % AP) every 0.25 s for 3 s (asset 100/150/200 +.5 AP per s).
        -- Tailwind: W deals 30 % of bonus movement speed; base movement speed 315 (wiki; the host has no base field,
        -- janna_move_speed traces settle it).
        qBaseRange=D.HowlingGale.BaseRange,qChargeRate=220,qMaxCharge=D.HowlingGale.MaxDuration,qTravel=D.HowlingGale.MissileTravelTime,
        rHeal={25,37.5,50},rHealAP=.125,rTick=.25,rChannel=D.ReapTheWhirlwind.Duration,tailwind=.3,baseMoveSpeed=315},
}

end
end
