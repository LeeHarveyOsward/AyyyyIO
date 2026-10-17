return function(require)
-- Mechanics retained from LHO actives, with their original profile scope.
local normal={
    [3222]={range=0,allyCleanse=true,rangeFromHost=true,group='itemCleanse',damage=false},
    [3157]={range=0,group='itemStasis',damage=false,stasis=true},
    [3077]={range=400,group='itemCleave'},[3074]={range=400,group='itemCleave'},
    [3748]={range=300,group='itemCleave',reset=true},[6698]={range=400,group='itemCleave'},
    [6631]={range=400,group='itemCleave'},[3143]={range=500,group='itemSlow',damage=false,champion=true},
    [3142]={range=700,group='itemSpeed',damage=false,champion=true},
    [2065]={range=700,group='itemSpeed',damage=false,champion=true},
    [3146]={range=600,group='itemTargeted',targeted=true,champion=true},
    [3140]={range=0,group='itemCleanse',damage=false,cleanse=true},[3139]={range=0,group='itemCleanse',damage=false,cleanse=true},
    [3190]={range=600,group='itemShield',damage=false,shield=true}}
local classic={
    [773157]={range=0,group='itemStasis',damage=false,stasis=true},
    [773077]={range=400,group='itemCleave'},[773074]={range=400,group='itemCleave'},
    [773143]={range=500,group='itemSlow',damage=false,champion=true},
    [773144]={range=450,group='itemTargeted',targeted=true,champion=true},
    [773153]={range=450,group='itemTargeted',targeted=true,champion=true},
    [773146]={range=600,group='itemTargeted',targeted=true,champion=true},
    [773142]={range=600,group='itemSpeed',damage=false,attackSpeed=true},
    [773069]={range=700,group='itemSpeed',damage=false,champion=true},
    [773140]={range=0,group='itemCleanse',damage=false,cleanse=true},[773139]={range=0,group='itemCleanse',damage=false,cleanse=true},
    [773190]={range=600,group='itemShield',damage=false,shield=true}}
local potions={normal={[2003]={heal=120,duration=15},[2031]={heal=100,duration=12,charge=true},[2033]={heal=100,duration=12,charge=true}},
    classic={[772003]={heal=150,duration=15},[773521]={heal=150,duration=15},[772041]={heal=120,duration=12,charge=true}}}
return {normal=normal,classic=classic,potions=potions}

end
