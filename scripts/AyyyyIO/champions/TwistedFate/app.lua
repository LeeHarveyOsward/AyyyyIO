return function(require)
local P=require('CombatProfiles.twisted_fate')
local U=require('tf.util')
local App={};App.__index=App
App.build='CardMarx-10'
function App.new()
    return setmetatable({hero=myHero,sdk=SDK,active=true,build=App.build},App)
end
function App:initialize()
    local c=self
    c.profile=assert(P.Profile(myHero.charName));c.config=require('tf.config').new(c.profile)
    if c.sdk.ChampionCore then
        c.core=assert(c.sdk.ChampionCore:Create({name='TwistedFate',profile=c.profile,
            current=function()return c.active end,onError=function(err)print('[CardMarx] stopped: '..tostring(err));c:Shutdown()end}))
        c.core:RegisterCleanup('gameplay',function()c:Shutdown()end)
    end
    c.state=require('tf.state').new(c)
    c.actions=require('tf.actions').new(c);c.cards=require('tf.cards').new(c)
    c.q=require('tf.q').new(c);c.combat=require('tf.combat').new(c)
    c.effects=require('tf.effects').new(c);c.farm=require('tf.farm').new(c);c.level=require('tf.level').new(c)
    c.state:refresh()
    c.autoJungle=require('AyyyyIO.autojungle')(_G,c.core,{
        menu=c.config.menu,menuID='OrbamaTwistedFate',menus=require('Orbama.menus'),
        available=function()return not c:blocked()and not c.state:channel()and not c.cards.manual end,
        safe=function(pos)local service=c.sdk.OrbamaUtils and c.sdk.OrbamaUtils.Camps;return service and service:Safe(pos)or false end,
        clear=function(_,_,context)
            c.jungleExecution=context;local ok,why=pcall(c.farm.tick,c.farm,'JUNGLECLEAR',nil);c.jungleExecution=nil
            if not ok then error(why,0)end
        end,
        cancel=function(reason)for _,owner in ipairs({'farm_attack','q','clear'})do c.actions:cancel(owner,reason)end end})
    return c
end
function App:record()end
function App:blocked()
    if _G.AyyyyIO and _G.AyyyyIO.Allows and not _G.AyyyyIO:Allows()then return true end
    return not self.config:get('enabled') or self.hero.dead or Game.IsChatOpen() or not Game.IsOnTop()
end
function App:tick()
    if not self.active then return end
    self.state:refresh();self.actions:tick();self.combat:pollAttack();self.plan=nil
    if self:blocked()then
        self.cards:clear()
        for _,owner in ipairs({'combat_attack','farm_attack','interrupt','peel','q','q_secure','q_zone','card_secure','level','item','summoner','classic_r','planned_active'})do self.actions:cancel(owner,'context_unavailable')end
        self.actions.client:SetBlocked('gate','attack',false);self.actions.client:SetBlocked('gate','move',false)
        self.effects:claimsUpdate();return
    end
    if self.sdk.Evade and type(self.sdk.Evade.Evading)=='function'and self.sdk.Evade:Evading()then
        self.actions.client:SetBlocked('gate','attack',false);self.actions.client:SetBlocked('gate','move',false);return
    end
    local s=self.state
    self.actions.client:SetBlocked('gate','attack',s.channeling)
    self.actions.client:SetBlocked('gate','move',s.channeling)
    if self.wasGate and not s.channeling then
        self.level.teleports=self.level.teleports or {};table.insert(self.level.teleports,Game.Timer())
        if #self.level.teleports>16 then table.remove(self.level.teleports,1)end
        if self.config:get('teleportCards') and not self.cards.manual then self.cards:auto('gold','arrival')end
    end
    self.wasGate=s.channelKind=='gate'
    -- During the Gate channel: keep a rolling card on gold, and where the profile allows W1 in the channel (Normal,
    -- wiki V26.10) start rolling at once so the gold card is held on arrival. Never at the Destiny cast: the pick
    -- window could expire before the player chooses where to Gate.
    if self.wasGate and self.config:get('teleportCards') and not self.cards.manual
        and(s.stage=='selecting' or s.stage=='idle' and self.profile.channelW1==true)then
        self.cards:auto('gold','manual_gate')
    end
    self.cards:tick()
    if s.channeling then return end
    self.effects:tick()
    if s.mode=='FLEE'then self.combat:classicR()end
    local urgent=self.combat:interrupt() or self.combat:peel()
    -- Mode-free: finish an enemy, then Wild Cards at an enemy that cannot move. Neither skips the held mode's work.
    if not urgent and not self.combat:secure()then self.combat:zone()end
    if not urgent and self.autoJungle and self.autoJungle:Tick()then self.level:tick();return end
    if not urgent then
        if s.mode=='COMBO' or s.mode=='HARASS'then self.combat:tick(s.mode,s.modeID)
        elseif s.mode=='LASTHIT' or s.mode=='LANECLEAR' or s.mode=='JUNGLECLEAR'then
            local mode,id=s.mode,s.modeID
            if self.sdk.Orbwalker.Modes[self.sdk.ORBWALKER_MODE_LANECLEAR] and self.sdk.Orbwalker.Modes[self.sdk.ORBWALKER_MODE_JUNGLECLEAR] then
                local nearest,distance=nil,math.huge
                for _,m in ipairs(s.minions)do if U.target(m) and m.team~=self.hero.team then
                    local d=U.dist(self.hero,m);if d<distance then nearest=m;distance=d end
                end end
                if nearest and nearest.team==300 then mode='JUNGLECLEAR';id=self.sdk.ORBWALKER_MODE_JUNGLECLEAR end
            end
            self.farm:tick(mode,id)
            if s.mode=='LANECLEAR' and self.config:get('farmHarass')then self.combat:tick('HARASS',s.modeID)end
        elseif s.mode=='FLEE'then self.combat:flee()
        elseif self.config:get('autoHarass') and s.mode=='NONE'then self.combat:tick('HARASS',nil)end
    end
    self.level:tick()
end
function App:draw(display)
    local Draw=display or Draw
    if not self.active or not self.config:get('draw')then return end
    -- The card the script will lock (the game shows the cycling card, not the pick): only while one is wanted.
    local p=self.hero.pos:To2D();local color=self.cards.manual and self.cards.manual.color or self.cards.desired
    if color then
        if self.display then self.display.scope:Set('card-detail',{kind='detail',feature='preview',anchor='hud',text='Picking '..color,priority=80,expires=Game.Timer()+.2})
        else Draw.Text('Picking '..color,14,p.x-80,p.y+50,Draw.Color(230,240,210,80))end
    end
    if self.plan and U.target(self.plan.target)then Draw.Circle(self.plan.target.pos,90,2,Draw.Color(220,240,210,80))end
    local qSpell=self.state.spells and self.state.spells[0]
    if self.config:get('drawQ')and qSpell and(qSpell.level or 0)>0 and(qSpell.currentCd or 0)<=0 then Draw.Circle(self.hero.pos,self.profile.q.range,1,Draw.Color(120,240,210,80))end
    -- The red card's planned splash centre and how many it reaches (prepared by the lane/jungle clear decision).
    local red=self.farm and self.farm.redPlan
    -- Kept up to a second so a skipped clear decision never blinks it, while the centre unit lives.
    if red and Game.Timer()-red.at<1 and U.target(red.unit)then
        Draw.Circle(red.unit.pos,self.profile.redRadius,1,Draw.Color(200,255,90,60))
        local q=red.unit.pos:To2D();Draw.Text(tostring(red.count),14,q.x-4,q.y-30,Draw.Color(230,255,90,60))
    end
    -- Gate stage (Normal, finite range): cursor distance and an out-of-range warning.
    local spell=self.state.spells and self.state.spells[self.profile.gateSlot]
    local cursor=_G.mousePos
    if self.profile.gateRange and spell and U.lower(spell.name)==U.lower(self.profile.gateName)and cursor and cursor.To2D then
        local distance=U.dist(self.hero,cursor);local at=cursor:To2D()
        local far=distance>self.profile.gateRange
        Draw.Text(string.format('%d%s',math.floor(distance),far and ' out of range'or''),14,at.x+18,at.y+18,
            far and Draw.Color(230,255,80,80)or Draw.Color(230,240,210,80))
    end
    -- Gate reach on the minimap while the ultimate is learned and off cooldown (profiles with a finite range).
    local range=self.profile.gateRange;local gate=range and self.state.spells and self.state.spells[self.profile.gateSlot]
    if gate and Draw.CircleMinimap and(gate.level or 0)>0 and(gate.currentCd or 0)<=0 then Draw.CircleMinimap(self.hero.pos,range,1,Draw.Color(200,240,210,80))end
end
function App:install()
    self.tickFn=function()
        local ok,err=pcall(function()
            if self.sdk.Performance and self.sdk.Performance.enabled then
                self.sdk.Performance:Call('tf_controller',function()self:tick()end)
            else self:tick()
            end
            if self.display then self.display:Prepare(self.config:get('draw'))end
            return
        end)
        if not ok then print('[CardMarx] stopped: '..tostring(err));self:Shutdown()end
    end
    self.display=require('Overlay.client').new(_G,'TwistedFate.display',function()return self.active and SDK==self.sdk and myHero==self.hero end,
        function(d)self:draw(d)end,function()return {harass={kind='status',label='Auto-harass',enabled=self.config:get('autoHarass')==true},
            spellfarm={kind='status',label='Spell farm',enabled=self.config:get('spellFarm')==true}}end,
        function()return self.combat:comboRows()end)
    if self.core and self.display then self.core:RegisterService('display',self.display)end
    self.drawFn=function()if self.drawError then return end;local ok,err=pcall(self.draw,self);if not ok and not self.drawError then self.drawError=tostring(err);print('[CardMarx] Display disabled: '..self.drawError)end end
    if self.core then
        self.tickFn=self.core:Bind(self.sdk.OnUrgent,self.tickFn)
        if not self.display then self.drawFn=self.core:Bind(self.sdk.OnDraw,self.drawFn)end
    else table.insert(self.sdk.OnUrgent,self.tickFn);if not self.display then table.insert(self.sdk.OnDraw,self.drawFn)end end
end
function App:Shutdown()
    if not self.active then return end
    self.active=false
    if self.core then self.core:Shutdown('controller_shutdown')end
    if self.display then if not self.core then self.display:Close()end;self.display=nil end
    if not self.core then U.remove(self.sdk.OnUrgent,self.tickFn);U.remove(self.sdk.OnDraw,self.drawFn)end
    if self.actions and self.actions.client then self.actions:close()end
    if not self.core and self.actions and self.actions.client and self.actions.client:HasWork() and self.sdk.OnMaintenance then
        local cleanup
        cleanup=function()
            self.actions.client:Collect()
            if not self.actions.client:HasWork()then U.remove(self.sdk.OnMaintenance,cleanup)end
        end
        table.insert(self.sdk.OnMaintenance,cleanup)
    end
    if _G.OrbamaTwistedFate==self then _G.OrbamaTwistedFate=nil end
end
return App

end
