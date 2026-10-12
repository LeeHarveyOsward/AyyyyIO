return function(require)
-- Typed native health bounds. No callbacks, history, speculative incoming
-- attacks, item procs or implicit fog observations belong in this calculator.
local M={version=1}
local function finite(value)return type(value)=='number'and value==value and value>-math.huge and value<math.huge end
function M.Read(unit,horizon,kind)
    if not unit or not finite(horizon)or horizon<0 or horizon>60 then return nil,'invalid_health_horizon'end
    local field=kind=='magical'and 'shieldAP'or kind=='physical'and 'shieldAD'
    if not field then return nil,'unsupported_shield_damage_type'end
    local health,regen,shield,maximum=unit.health,unit.hpRegen,unit[field],unit.maxHealth
    if not finite(health)or health<=0 or unit.dead==true or unit.valid==false then return nil,'invalid_health_target'end
    if not finite(regen)or regen<0 then return nil,'regeneration_unknown'end
    if not finite(shield)or shield<0 then return nil,'typed_shield_unknown'end
    local gain=regen*horizon
    if finite(maximum)and maximum>0 and maximum>=health then gain=math.min(gain,maximum-health)end
    return {health=health,shield=shield,regeneration=gain,upper=health+shield+gain,
        horizon=horizon,damageType=kind,source='current_native_health_and_ordinary_regeneration',
        id=unit.networkID or unit.handle,handle=unit.handle}
end
function M.Qualify(unit,horizon,kind,damage)
    if not finite(damage)or damage<0 then return nil,'damage_unknown'end
    local row,reason=M.Read(unit,horizon,kind)
    if not row then return nil,reason end
    row.damage=damage;row.margin=damage-row.upper;row.lethal=row.margin>0
    return row
end
-- Each native eligible pool is charged separately. A shared shield may therefore
-- be charged twice; this is a conservative bound, not ordered shield simulation.
function M.QualifyMixed(unit,horizon,physical,magical)
    if not finite(physical)or physical<0 or not finite(magical)or magical<0 then return nil,'damage_unknown'end
    local kind=physical>0 and 'physical'or 'magical'
    local row,reason=M.Read(unit,horizon,kind)
    if not row then return nil,reason end
    local physicalShield,magicalShield=0,0
    if physical>0 then
        physicalShield=unit.shieldAD
        if not finite(physicalShield)or physicalShield<0 then return nil,'physical_shield_unknown'end
    end
    if magical>0 then
        magicalShield=unit.shieldAP
        if not finite(magicalShield)or magicalShield<0 then return nil,'magical_shield_unknown'end
    end
    local useful=math.max(0,physical-physicalShield)+math.max(0,magical-magicalShield)
    row.damageType='mixed';row.physical=physical;row.magical=magical
    row.physicalShield=physicalShield;row.magicalShield=magicalShield
    row.shield=nil;row.upper=row.health+row.regeneration
    row.damage=physical+magical;row.useful=useful;row.margin=useful-row.upper;row.lethal=row.margin>0
    row.shieldAttribution='conservative_separate_eligible_pools'
    return row
end
return M

end
