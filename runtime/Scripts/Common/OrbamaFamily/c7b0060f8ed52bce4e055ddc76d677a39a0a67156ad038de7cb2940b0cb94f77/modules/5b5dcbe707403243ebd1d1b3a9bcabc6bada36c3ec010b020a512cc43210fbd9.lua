return function(require)
local M={}
function M.new(p)
    local menu=MenuElement({id='OrbamaTwistedFate',name=_G.AyyyyIO and 'AyyyyIO - Twisted Fate'or 'Card Marx - '..p.id,type=MENU})
    local migration=SDK.MenuMigration and SDK.MenuMigration.Grouped and SDK.MenuMigration or require('Orbama.menus')
    migration:Grouped(menu,'OrbamaTwistedFate',function(a)
        return (a.id=='cards'or a.id=='spellFarm')and 'Controls'or (a.id=='draw'or a.id=='drawQ')and 'Appearance'
            or a.id=='diagnostics'and 'Tracking'or 'Automation'
    end)
    local nodes={}
    local function add(id,name,value,parent)
        parent=parent or menu;parent:MenuElement({id=id,name=name,value=value});nodes[id]=parent[id]
    end
    -- Good defaults without a menu entry: an in-memory setting keeps the reader (and tests) working.
    local function fixed(id,value)
        nodes[id]={fixed=true,Value=function(self,v)if v~=nil then value=v end;return value end}
    end
    fixed('enabled',true)
    menu:MenuElement({id='cards',name='Pick a card',type=MENU})
    for _,row in ipairs({{'gold','Gold',84},{'red','Red',85},{'blue','Blue',73}})do
        menu.cards:MenuElement({id=row[1],name=row[2]..' card (tap: pick once, hold: keep picking)',key=row[3],toggle=false});nodes[row[1]]=menu.cards[row[1]]
    end
    -- The family spell-farming toggle (TF runs its own core, so it owns the same switch): it governs Last hit, Lane
    -- clear and Jungle clear. Default as the family's SpellFarmDefault: on with Smite, off otherwise. Key J, because
    -- the family key I is TF's blue card bind.
    local farmDefault=type(SpellFarmDefault)=='function'and SpellFarmDefault()
    if type(SpellFarmDefault)~='function'then
        for _,slot in ipairs({SUMMONER_1 or 4,SUMMONER_2 or 5})do
            local d=myHero:GetSpellData(slot);if d and type(d.name)=='string'and d.name:find('Smite',1,true)then farmDefault=true end
        end
    end
    menu:MenuElement({id='spellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=farmDefault==true,key=75,toggle=true})
    nodes.spellFarm=menu.spellFarm
    for _,row in ipairs({{'COMBO','Combo'},{'HARASS','Harass'},{'LASTHIT','Last hit'},{'LANECLEAR','Lane clear'},{'JUNGLECLEAR','Jungle clear'},{'FLEE','Flee'}})do
        local name=row[1];menu:MenuElement({id=name,name=row[2],type=MENU})
        add(name..'Q','Use Q',name~='FLEE',menu[name]);add(name..'W','Use W (cards)',true,menu[name])
    end
    fixed('interrupt',true)
    fixed('peel',true)
    fixed('zoneQ',true)
    add('secure','Finish enemies with Wild Cards or a card',true)
    add('autoHarass','Harass without holding a mode key',false)
    add('farmHarass','Harass enemy champions while lane clearing',true)
    fixed('teleportCards',true)
    if p.autoRVerified then add('classicR','Use R (slow) in Combo and Flee',true)end
    fixed('defense',true)
    fixed('offense',true)
    add('ghost','Use Ghost in Combo and Flee',false)
    -- One switch for automatic ability levels, Orbama Utils' "Level up abilities automatically" (this entry
    -- duplicated it); a value set here (tests) wins, and without Utils it stays on.
    do local override
        nodes.level={Value=function(_,v)
            if v~=nil then override=v end;if override~=nil then return override end
            local utils=_G.SDK and _G.SDK.OrbamaUtils;local shared=type(utils)=='table'and utils.config
            if type(shared)=='table'and type(shared.get)=='function'then return shared:get('level')==true end
            return true
        end}
    end
    add('draw','Draw the planned action',true)
    add('drawQ','Wild Cards range while Q is ready',false)
    local c={menu=menu,nodes=nodes}
    function c:get(id)if id=='diagnostics'then return false end;return self.nodes[id] and self.nodes[id]:Value()end
    return c
end
return M

end
