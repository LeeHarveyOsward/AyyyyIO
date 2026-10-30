return function(require)
local U=require('utils.util')
local World=require('CombatProfiles.world')
local App={};App.__index=App
function App.new(g)
    local self=setmetatable({g=g,sdk=g.SDK,hero=g.myHero,heroName=g.myHero.charName,enabled=true,build='OrbamaUtils-2',hooks={},nativeHooks={},allies={},minions={}},App)
    self.profile={id=g.myHero.charName:match('^Jade_')and 'classic'or 'normal'}
    self.config=require('utils.config').new(g)
    self.actions=require('utils.actions').new(self)
    self.observations=require('utils.observations').new(self)
    self.Knowledge=require('utils.knowledge').new(self)
    self.Objectives=require('utils.objectives').new(self,self.actions)
    self.Activator=require('utils.activator').new(self)
    self.Leveling=require('utils.leveling').new(self)
    self.Wards=require('utils.wards').new(self)
    self.Flash=require('utils.flash').new(self)
    self.Reveal=require('utils.reveal').new(self)
    self.Camps=require('utils.camps').new(self)
    self.drawing=require('utils.drawing').new(self)
    self.drawPreparationConfig={intervalMs=100,maxDelayMs=500,units=2,maxUnits=32}
    self.prepareDrawing=function(token)return self.drawing:Prepare(token)end
    if self.sdk.Preparation and self.sdk.Preparation.version==1 then
        self.preparationAvailable=true
        local family=g.OrbamaFamily
        local active=function()return self:active()end
        if family and family.GetPreparationScope then
            self.preparation=family:GetPreparationScope('OrbamaUtils','display',active)
        else self.preparation=self.sdk.Preparation:Register('OrbamaUtils.display',{active=active})end
    end
    self.latency=g.Game.Latency and g.Game.Latency()/1000 or .04
    self.leveling={pending=false};self.farm={known={}}
    local app=self
    function self.farm:epicSoon()
        if not app.config:get('smiteReserve')then return false end
        local _,classic,d=app.Objectives:resolve()
        if classic or not d or(d.ammo or 0)>1 then return false end
        for _,camp in pairs(self.known)do
            if World.epics[camp.category]and U.dist(g.myHero.pos,camp.pos)<1600 then return true end
        end
        return false
    end
    self.Camps:Current()
    return self
end
function App:active()return self.enabled and self.g.SDK==self.sdk and self.g.myHero==self.hero and self.hero.charName==self.heroName and self.sdk.OrbamaUtils==self end
function App:now()return self.g.Game.Timer()end
function App:spellSlot(slot)return self.actions.client:NativeSpellSlot(slot)end
-- Spell data, readiness and items for one game-time instant. Every callback at
-- the same Game.Timer value sees the same game state (input is applied by the
-- game later), so Smite, the activator and the status line share one native
-- read per slot instead of repeating ~11 us GetSpellData / ~9 us CanUseSpell calls.
function App:instant()
    local now=self.g.Game.Timer();local memo=self.instantMemo
    if not memo or memo.at~=now then memo={at=now,spells={},usable={},items={}};self.instantMemo=memo end
    return memo
end
function App:spell(slot)
    local native=self:spellSlot(slot)
    if not native then return {}end
    local spells=self:instant().spells;local d=spells[native]
    if d==nil then d=self.g.myHero:GetSpellData(native)or false;spells[native]=d end
    return d or {}
end
function App:ready(slot)
    local native=self:spellSlot(slot);if native==nil then return false end
    local memo=self:instant();local usable=memo.usable[native]
    if usable==nil then usable=self.g.Game.CanUseSpell(native);memo.usable[native]=usable end
    local d=memo.spells[native]
    if d==nil then d=self.g.myHero:GetSpellData(native)or false;memo.spells[native]=d end
    d=d or {}
    return usable==0 and(d.currentCd or 0)<=0 and(d.mana or 0)<=(self.g.myHero.mana or 0)
end
function App:item(slot)
    local items=self:instant().items;local item=items[slot]
    if item==nil then item=self.g.myHero:GetItemData(slot)or false;items[slot]=item end
    return item or nil
end
function App:blocked()return not self:active()or not self.config:get('enabled')or self.g.myHero.dead
    or self.g.Game.IsChatOpen()or not self.g.Game.IsOnTop()end
function App:recalling()return self.sdk.IsRecalling(self.g.myHero,true)end
function App:threats(pos,range)
    local n=0;for _,h in ipairs(self.observations.heroes)do
        if h.team~=self.g.myHero.team and U.valid(h)and U.dist(pos,h.pos)<=range then n=n+1 end
    end;return n
end
function App:GetCapabilities()return {version=1,objectives=true,activator=true,observations=true,recalls=true,leveling=true,wards=true,camps=true,campKnowledgeVersion=2,
    wardRequests=true,flashRequests=true,revealRequests=true,delegatedReservations=true,knowledge=true,preaim=false,armedSmite=true,minionSmiteRequests=true,normal=true,classic=true}end
function App:AuthorizeReservation(client,token,resources)
    if not self:active()or not self.actions or not self.actions.client then return nil,'utils_inactive'end
    if not client or type(client.Authorize)~='function'then return nil,'invalid_reservation_owner'end
    return client:Authorize(token,self.actions.client,resources)
end
local function skip()end
function App:Tick()
    self.actions:tick()
    self.Leveling:Tick()
    if self:active()then
        self.observations:Tick();self.minions=self.observations.minions;self.allies={}
        self.heroes=self.observations.heroes;self.turrets=self.observations.turrets;self.wardObjects=self.observations.wards
        for _,h in ipairs(self.observations.heroes)do if h.team==self.g.myHero.team and not U.same(h,self.g.myHero)then self.allies[#self.allies+1]=h end end
        self.Activator:Tick()
        if not self:blocked()then
            self.Objectives:auto()
            if self.classicActivator and(self.config:get('items')or self.config:get('ignite'))then self.classicActivator:tick()end
        end
        self.observations:PrepareLocations()
        if not self.drawError and self.config:get('draw')and self.preparation then
            local _,reason,err=self.preparation:Run('drawing',self.drawPreparationConfig,self.prepareDrawing)
            if reason=='callback_error'then self:DisplayFailure(err)end
        elseif not self.drawError and self.config:get('draw')and not self.preparationAvailable and self:now()>=(self.drawAt or 0)then
            self.drawAt=self:now()+.1;local ok,err=pcall(self.drawing.Prepare,self.drawing);if not ok then self:DisplayFailure(err)end
        elseif not self.config:get('draw')then
            if self.preparation then self.preparation:CancelJob('drawing')end;self.drawing:ResetPreparation()
        end
    end
end
function App:PublishStatus()
 local scope=self.overlayScope;if not scope then return end
 -- Which summoner slot holds Smite only changes with the summoner itself: the
 -- status line (drawn every frame) looks it up twice a second, not every frame.
 local now=self:now()
 if not self.smiteSlotAt or now-self.smiteSlotAt>=.5 or now<self.smiteSlotAt then self.smiteSlotAt=now;self.smiteSlot=self.Objectives:resolve()end
 local d=self.smiteSlot;local enabled=self.config:get('autosmite')
 -- Without Smite equipped there is nothing to secure: no status row, no menu.
 local equipped=d~=nil
 if self.smiteShown~=equipped then
  self.smiteShown=equipped;local menu=self.config.menu
  for _,node in ipairs({menu and menu.Smite,menu and menu.Controls and menu.Controls.smiteKey})do
   if node and type(node.Hide)=='function'then pcall(node.Hide,node,not equipped)end
  end
 end
 if not equipped then scope:Remove('autosmite');return end
 scope:Set('autosmite',{feature='objectives',kind='status',anchor='hud',label='Auto-Smite',bind=self.config:key('smiteKey'),
  enabled=enabled,reason=enabled and not self.config:get('enabled')and 'suspended'or enabled and not d and 'Smite unavailable'or nil,
  priority=100,expires=now+.2})
end
function App:DisplayFailure(err)
 if self.drawError then return end
 self.drawError=tostring(err);self.drawing:ResetPreparation()
 if self.preparation then self.preparation:CancelJob('drawing')end
 if self.overlayScope then self.overlayScope:Clear()end
 print('[OrbamaUtils] Display disabled: '..self.drawError)
end
function App:install()
    self.config:install();local app=self
    if self.profile.id=='classic'and self.config.menu then self.classicActivator=require('utils.classic_activator')(self)end
    local function add(list,fn)
        local guarded=function(...)if not app:active()then
            if app.enabled then app:Shutdown('instance_changed')end
        else
            local ok,why=pcall(fn,...)
            if not ok then app.error=tostring(why);app:Shutdown('callback_error');print('[OrbamaUtils] '..app.error)end
        end end
        list[#list+1]=guarded;self.hooks[#self.hooks+1]={list=list,fn=guarded}
    end
    add(self.sdk.OnTick,function()self:Tick()end)
    local overlay=self.sdk.Overlay
    if overlay and overlay.GetCapabilities and overlay:GetCapabilities().ownedScopes then
        self.overlayScope=overlay:Register('OrbamaUtils',{active=function()return app:active()end})
    end
    local function draw(d)
        if self.drawError then return end
        local ok,err=pcall(self.drawing.Draw,self.drawing,d)
        if not ok then self:DisplayFailure(err)end
    end
    if self.overlayScope then self.overlayScope:Renderer('utils-status',function()self:PublishStatus()end,4);self.overlayScope:Renderer('tracking',draw,2)else add(self.sdk.OnDraw,function()draw()end)end
    add(self.sdk.OnWndMsg,function(msg,key)
        if key~=self.config:key('smiteKey')then return end
        if msg==257 then self.smiteHeld=false
        elseif msg==256 and not self.smiteHeld and not self:blocked()then
            self.smiteHeld=true;self.config:set('autosmite',not self.config:get('autosmite'))
            if not self.config:get('autosmite')then self.actions:cancel('autosmite')end
        end
    end)
    if self.sdk.OnUrgent then add(self.sdk.OnUrgent,function()if not self:blocked()then self.Objectives:auto(true)end end)end
    local callback=self.g.Callback
    if callback and callback.Add then
        local fn=function(unit,event)if app:active()then
            local ok,why=pcall(app.observations.Recall,app.observations,unit,event)
            if not ok and not app.recallError then app.recallError=tostring(why);print('[OrbamaUtils] Recall event skipped: '..app.recallError)end
        end end
        local ok,id=pcall(callback.Add,'ProcessRecall',fn)
        if ok and id~=nil then self.nativeHooks[#self.nativeHooks+1]={kind='ProcessRecall',id=id}
        elseif not ok then self.recallCallbackUnavailable=true end
    end
end
function App:Shutdown(reason)
    if not self.enabled then return end
    self.enabled=false;self.reason=reason;self.actions:close()
    if self.Knowledge then self.Knowledge:Close()end
    if self.Camps then self.Camps:Close()end
    if self.overlayScope then self.overlayScope:Close();self.overlayScope=nil end
    if self.preparation then self.preparation:Close();self.preparation=nil end
    if self.drawing then self.drawing:ResetPreparation()end
    for _,hook in ipairs(self.hooks)do for i=#hook.list,1,-1 do if hook.list[i]==hook.fn then table.remove(hook.list,i)end end end
    self.hooks={}
    if self.g.Callback and self.g.Callback.Del then for _,hook in ipairs(self.nativeHooks or {})do pcall(self.g.Callback.Del,hook.kind,hook.id)end end
    self.nativeHooks={}
end
return App

end
