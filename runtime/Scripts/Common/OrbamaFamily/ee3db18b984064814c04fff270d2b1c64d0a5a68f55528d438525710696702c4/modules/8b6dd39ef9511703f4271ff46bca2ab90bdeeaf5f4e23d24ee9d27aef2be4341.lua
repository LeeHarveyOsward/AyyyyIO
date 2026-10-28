return function(require)
local C={};C.__index=C
local defaults={enabled=true,comboQ=true,comboW=true,comboE=true,comboR=true,harassQ=true,harassW=true,harassE=false,
    -- Lane and last-hit E stay off: Shunpo is the only escape and puts Katarina inside the wave; the dash limits
    -- bound enemy champions and turrets, not lane position. A camp cannot punish the dash, so jungle E is on.
    lastQ=true,lastW=true,lastE=false,laneQ=true,laneW=true,laneE=false,jungleQ=true,jungleW=true,jungleE=true,
    idleKill=true,clearHarass=true,turret=false,offensiveWards=true,
    draw=true,ranges=false,diagnostics=false,wardApproach=true,wardRange=600,wardWalkRange=600,minHP=25,maxEnemies=2,
    clearHits=3,stasisHP=20,
    -- Not menu entries. The shared terrain planner (ChampionMobility/terrain.lua) reads the radius (without it
    -- every wall crossing is refused as 'Terrain unavailable along aim') and the landing search behind a wall,
    -- which has no switch: a jump that can cross is always the wanted one.
    assistRadius=300,wardAssist=true}
-- The family's spell-farming default (AyyyyIO common SpellFarmDefault: on with Smite, off otherwise); the same
-- rule when this factory runs without the common bundle. A saved choice always wins.
local function spellFarmDefault()
    if type(SpellFarmDefault)=='function'then local ok,value=pcall(SpellFarmDefault);if ok and type(value)=='boolean'then return value end end
    for _,slot in ipairs({4,5})do
        local data=myHero and myHero.GetSpellData and myHero:GetSpellData(slot)
        if data and type(data.name)=='string'and data.name:find('Smite',1,true)then return true end
    end
    return false
end
function C.new(profile)
    local self=setmetatable({values={},nodes={}},C)
    for k,v in pairs(defaults)do self.values[k]=v end
    self.values.spellFarm=spellFarmDefault()
    -- Explicit local recording profile, separate from saved gameplay settings.
    local test=_G.OrbamaTestConfig
    if not test then local ok,value=pcall(require,'OrbamaTestConfig');if ok then test=value end end
    self.capture=type(test)=='table'and test.enabled==true and type(test.katarina)=='table'and test.katarina.diagnostics==true
    if MenuElement then
        self.menu=MenuElement({id='KatarinaController',name=_G.AyyyyIO and 'AyyyyIO - Katarina'or 'Kata Hari - '..profile.id,type=MENU})
        local migration=SDK.MenuMigration and SDK.MenuMigration.Grouped and SDK.MenuMigration or require('Orbama.menus')
        migration:Grouped(self.menu,'KatarinaController',function(a)
            return a.key and 'Controls'or(a.id=='draw'or a.id=='ranges')and 'Appearance'or a.id=='diagnostics'and 'Tracking'or 'Automation'
        end)
        local labels={combo='Combo',harass='Harass',last='Last hit',lane='Lane clear',jungle='Jungle clear'}
        for _,mode in ipairs({'combo','harass','last','lane','jungle'})do
            self.menu:MenuElement({id=mode,name=labels[mode],type=MENU})
            for _,letter in ipairs({'Q','W','E','R'})do local id=mode..letter
                if defaults[id]~=nil then self.menu[mode]:MenuElement({id=letter,name='Use '..letter,value=defaults[id]});self.nodes[id]=self.menu[mode][letter]end
            end
        end
        -- No switch for a lethal Ignite, ending R for a kill, or the wall landing search (always wanted), and none
        -- for what is only a good default (player menu standard 2026-10-11): the controller itself (enabled), lane
        -- clear harass, walking to the wall before a jump, the lane clear W count, item actives (items.lua) and the
        -- diagnostic log (development recording uses OrbamaTestConfig). Those keys answer their `defaults` value.
        -- Zhonya's keeps its health % setting only.
        local options={{'turret','Allow dashing under enemy turrets'},{'idleKill','Finish killable enemies without holding a mode key'},
            {'draw','Draw the planned action and daggers'},{'ranges','Draw ability ranges while ready'}}
        if profile.id=='classic'then options[#options+1]={'offensiveWards','Use a ward to reach a kill in Combo'}end
        for _,row in ipairs(options)do self.menu:MenuElement({id=row[1],name=row[2],value=defaults[row[1]]});self.nodes[row[1]]=self.menu[row[1]]end
        for _,row in ipairs({{'minHP','Never dash in below health %',0,100},{'maxEnemies','Never dash into more enemies than',1,5}})do
            self.menu:MenuElement({id=row[1],name=row[2],value=defaults[row[1]],min=row[3],max=row[4],step=1});self.nodes[row[1]]=self.menu[row[1]]
        end
        self.menu:MenuElement({id='jump',name='Jump toward cursor (hold)',key=string.byte('T')})
        self.menu:MenuElement({id='extended',name='Combo may Flash or item-dash for a kill (hold)',key=string.byte('U')})
        -- One spell-farming toggle governs lane clear, jungle clear and last hit (family key I, as on every champion).
        self.menu:MenuElement({id='spellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=self.values.spellFarm,toggle=true,key=73})
        self.nodes.jump=self.menu.jump;self.nodes.extended=self.menu.extended;self.nodes.spellFarm=self.menu.spellFarm
    end
    return self
end
-- Zhonya's health limit is Orbama Utils' "Stasis below health %" (one entry for one limit); without Utils
-- the default here applies.
function C:get(k)if k=='diagnostics'then return false end;if k=='diagnostics'and self.capture then return true end;local node=self.nodes[k];if node then return node:Value()end
    if k=='stasisHP'then local utils=_G.SDK and _G.SDK.OrbamaUtils;local shared=type(utils)=='table'and utils.config
        if type(shared)=='table'and type(shared.get)=='function'then local v=shared:get('stasisHP');if type(v)=='number'then return v end end end
    return self.values[k]end
function C:close()if self.menu and self.menu.Hide then pcall(self.menu.Hide,self.menu,true)end end
return C

end
