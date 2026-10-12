return function(require)
local profiles={
    Blitzcrank={id='normal',qRange=1080,qDamage={110,160,210,260,310},qAP=1.2,qCost=100,
        rDamage={275,400,525},rAP=1,rRange=600,eBuff='PowerFist',wDuration=5,wSlow=1.5,
        wMinimumBonus=.1,shieldBreak=true,barrierMana=.35,barrierUsesCurrent=false,
        qSpeed=1800,qRadius=70,qDelay=.25,rDelay=.25,eKnockup=1,rSilence=.5,
        wAttackSpeed={.3,.4,.5,.6,.7},wMoveSpeed={.6,.65,.7,.75,.8},wMoveDecay=2.5,wSlowAmount=.3,wDelay=.18,
        eAttack='PowerFistAttack',turretRange=750,turretRangeVerified=true},
    -- Classic Q/R damage and Q range: pinned asset + patch 26.17, and the matched wiki page
    -- https://wiki.leagueoflegends.com/en-us/League_Classic/Blitzcrank (2026-10-08) agrees (60..300 +1.0 AP,
    -- 150/275/400 +1.0 AP, range 1085 centre / 1020 edge). Season 3 values (80..300, 250/375/500, 1079) are not this mode.
    Jade_Blitzcrank={id='classic',qRange=1050,qDamage={60,120,180,240,300},qAP=1,qCost=140,
        rDamage={150,275,400},rAP=1,rRange=600,eBuff='Jade_BlitzcrankPowerFist',wDuration=8,wSlow=0,
        wMinimumBonus=.16,shieldBreak=false,barrierMana=.5,barrierUsesCurrent=true,
        qSpeed=1800,qRadius=70,qDelay=.25,rDelay=.25,eKnockup=.9,rSilence=.5,
        wAttackSpeed={.3,.38,.46,.54,.62},wMoveSpeed={.16,.2,.24,.28,.32},wMoveDecay=nil,wSlowAmount=0,wDelay=.18,
        -- Classic turret attack range is not measured: 750 is the Normal wiki value, used only when the native
        -- turret.range is absent or implausible; turret_range / turret_pull_shot traces settle it (dev builds).
        eAttack='Jade_BlitzcrankPowerFistAttack',turretRange=750,turretRangeVerified=false},
}
return function(identity)
    local source=profiles[identity]
    if not source then return end
    local result={}
    for key,value in pairs(source)do
        if type(value)=='table'then local copy={};for i,v in ipairs(value)do copy[i]=v end;result[key]=copy
        else result[key]=value end
    end
    return result
end

end
