return function(require)
-- Basic attacks and empowered attacks that carry crowd control, Normal and Classic
-- names (installed assets 16.20 and wiki, read 2026-10-10). One list for every
-- consumer: the AyyyyIO core (C.CCAttackNames, ally-threat cc flag) and EvAYYYYde
-- (basic-attack threats at the player). Names are native spell names; `set` holds
-- them lower case. Classic names are the observed/asset ones, never a prefixed
-- copy of a normal name. Whether a listed attack actually applies its control on
-- a given hit (stacks, card colour) is not modelled: listed means "may carry it".
local names={'LeonaShieldOfDaybreak','LeonaShieldOfDaybreakAttack','PowerFist','PowerFistAttack','NautilusPassiveCheck',
    'NautilusPassiveRoot','GoldCardLock','GoldCardPreAttack','GoldCardAttack','GarenQ','GarenQAttack','XinZhaoQThrust3','RenektonExecute',
    'RenektonSuperExecute','VolibearQAttack','SejuaniE2','Jade_LeonaShieldOfDaybreak','Jade_LeonaShieldOfDaybreakAttack',
    'Jade_BlitzcrankPowerFist','Jade_BlitzcrankPowerFistAttack','Jade_NautilusPassive_Check','Jade_NautilusPassive_Root',
    'Jade_TwistedFate_GoldCardLock','Jade_TwistedFate_GoldCardPreAttack','Jade_TwistedFate_GoldCardAttack','Jade_GarenQ','Jade_GarenQAttack',
    'Jade_XinZhaoQ_Thrust3','Jade_XinZhaoQ_Knockup','Jade_AsheFrostArrow','Jade_KennenWPassiveProc'}
local set={}
for _,name in ipairs(names)do set[name:lower()]=true end
return {names=names,set=set,
    -- True when the native spell name is a listed control-carrying attack.
    Has=function(name)return type(name)=='string'and set[name:lower()]==true end}

end
