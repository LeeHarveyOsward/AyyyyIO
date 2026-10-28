return function(require)
local G=require('evade.geometry')
local C={}
local function spellReader(owner)return owner and owner.GetSpellData end
local function estimate(owner,definition,reader)
    local formula=definition and definition.formula;local cast=definition and definition.cast
    local spell=reader(owner,cast.slot);local rank=spell and spell.level
    if not G.finite(rank)or rank<1 or rank>(formula.maxRank or 6) or rank~=math.floor(rank)then return end
    local raw=0
    local ap,bonusAD,totalAD,apRead,bonusADRead,totalADRead
    for _,term in ipairs(formula.terms)do
        local value=term.values and term.values[rank+1]or term.coefficient
        if not G.finite(value)then return end
        if term.stat=='ap'then
            if not apRead then ap=owner.ap;apRead=true end
            if not G.finite(ap)then return end;value=value*ap
        elseif term.stat=='bonusAD'then
            if not bonusADRead then bonusAD=owner.bonusDamage;bonusADRead=true end
            if not G.finite(bonusAD)then return end;value=value*bonusAD
        elseif term.stat=='totalAD'then
            if not totalADRead then totalAD=owner.totalDamage;totalADRead=true end
            if not G.finite(totalAD)then return end;value=value*totalAD
        elseif term.stat~='constant'then return end
        raw=raw+value
    end
    -- Repeated strikes on the same target (catalogue `strikes`, damage 'each'): the formula is one strike, the
    -- estimate is all of them. Only the amount changes; the footprint and its timing stay the record's own.
    local strikes=definition.strikes;local count=1
    if type(strikes)=='table'and strikes.each==true then
        count=strikes.count
        if not G.finite(count)or count<2 or count>30 or count~=math.floor(count)then return end
        raw=raw*count
    end
    if not G.finite(raw)or raw<0 then return end
    -- Keep the base estimate available without treating unmodeled amplification,
    -- penetration or mode modifiers as a certified lethal forecast.
    return {raw=raw,kind=formula.kind,uncertain=true,scope=formula.scope,strikes=count>1 and count or nil}
end
function C.Damage(owner,definition)
    if not definition or not definition.formula or not definition.cast then return nil,0 end
    local limit=definition.formula.maxRank
    if limit~=nil and(not G.finite(limit)or limit<1 or limit>6 or limit~=math.floor(limit))then return nil,0 end
    -- Wrapper property lookup can fail before the native method is invoked.
    local ok,reader=pcall(spellReader,owner)
    if not ok or type(reader)~='function'then return nil,0 end
    -- Guard the rank result and dependent stat reads in the same estimate.
    -- The second result counts attempted native reads, including failed calls.
    local success,damage=pcall(estimate,owner,definition,reader)
    return success and damage or nil,1
end
return C

end
