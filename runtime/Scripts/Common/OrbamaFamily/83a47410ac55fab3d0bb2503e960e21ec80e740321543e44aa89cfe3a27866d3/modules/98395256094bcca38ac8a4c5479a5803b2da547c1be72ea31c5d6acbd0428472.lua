return function(require)
local U=require('kata.util');local Profiles=require('kata.profiles')
local App={};App.__index=App
function App.new()
    return setmetatable({hero=myHero,sdk=SDK,active=true,build=Profiles.build,callbacks={},manualGeneration=0,enemies={},allies={},minions={}},App)
end
function App:coreOptions(profile)
    return {name='Katarina',profile=profile,current=function()return self.active end,
        onError=function(err)self:log('error',nil,err);self:Shutdown('callback_error');print('[Katarina] '..tostring(err))end}
end
function App:Start(replace)
    if replace then
        local options=self:coreOptions(assert(Profiles.select(myHero.charName)))
        options.replace=replace
        options.prepare=function(core)self:init(core);self:install()end
        local core,why=self.sdk.ChampionCore:Create(options)
        assert(core,why);return self
    end
    self:init();self:install();return self
end
function App:init(core)
    self.profile=assert(Profiles.select(myHero.charName))
    self.config=require('kata.config').new(self.profile)
    if self.sdk.ChampionCore then
        self.core=core or assert(self.sdk.ChampionCore:Create(self:coreOptions(self.profile)))
        self.core:RegisterCleanup('gameplay',function(reason)self:Shutdown(reason)end)
    end
    self.state=require('kata.state').new(self)
    self.actions=require('kata.actions').new(self)
    self.session=tostring(self.actions.client:Now())
    self.items=require('kata.items').new(self)
    self.damage=require('kata.damage').new(self)
    self.planner=require('kata.planner').new(self)
    self.mobility=require('kata.mobility').new(self)
    self.evade=require('kata.evade').new(self)
    self.autoJungle=require('AyyyyIO.autojungle')(_G,self.core,{
        menu=self.config.menu,menuID='KatarinaController',menus=require('Orbama.menus'),
        available=function()return self:available()and not self.state:channel()and not self.actions:rStarting()end,
        safe=function(pos)return self.state:enemiesNear(pos,1000)==0 and not self.state:turret(pos)end,
        clear=function()
            local action=self.planner:farm('jungle');if action then self.actions:submit(action)end
        end,
        cancel=function(reason)self.actions:cancel('jungle',reason)end})
    return self
end
function App:now()return Game.Timer()end
function App:spell(slot)return self.state:spell(slot)end
-- Live 2026-10-03: the host reports a cooldown a few frames after the observed
-- cast, which produced a duplicate request/send of the same spell.
-- The guard only bridges the frames until the host shows that cooldown. Once it
-- has been seen, a slot that is ready again was reset (takedown, dagger pickup)
-- and continues the chain at once instead of waiting out the guard.
function App:ready(slot)
    local at=self.actions.observedAt[slot]
    local settling=at and Game.Timer()-at<.35 and self.actions.cooldownSeen[slot]~=at
    return not self.actions:slotBusy(slot)and not settling and self.state:ready(slot)
end
-- The family spell-farming toggle (key I): governs lane clear, jungle clear and last hit.
function App:spellFarm()return self.config:get('spellFarm')~=false end
function App:mouse()
    local p=Game.mousePos
    if type(p)=='function'then local ok,value=pcall(p);p=ok and value or nil end
    return U.copy(p)or U.copy(mousePos)
end
function App:mode()
    local m=self.sdk.Orbwalker.Modes
    for _,row in ipairs({{'flee','ORBWALKER_MODE_FLEE'},{'combo','ORBWALKER_MODE_COMBO'},{'harass','ORBWALKER_MODE_HARASS'},
        {'last','ORBWALKER_MODE_LASTHIT'},{'lane','ORBWALKER_MODE_LANECLEAR'},{'jungle','ORBWALKER_MODE_JUNGLECLEAR'}})do
        if self.sdk[row[2]]and m[self.sdk[row[2]]]then return row[1]end
    end
end
function App:ownerActive(owner)
    if owner=='defense'or owner=='evade'then return true end
    if owner=='jump'then
        -- Brief key-state gaps (live: the jump context ended 30 ms after start
        -- while T was held) must not cancel a placed ward; release still ends it.
        local now=Game.Timer()
        if self.config:get('jump')==true then self.jumpHeldAt=now;return not self.mobility.doneHeld end
        local pending=self.mobility.pending
        local placed=pending and(pending.state=='ward_ready'or pending.event and pending.event.a and pending.event.a.ward
            and(pending.event.sentTime or pending.event.observed))
        return placed and self.jumpHeldAt~=nil and now-self.jumpHeldAt<=.15 and not self.mobility.doneHeld or false
    end
    -- The finisher also runs under the farming and Harass keys; Combo and Flee decide for themselves.
    if owner=='idle'then local mode=self:mode();return self.config:get('idleKill')and mode~='combo'and mode~='flee'end
    -- Poke while lane clearing: never from under an enemy turret (the cast draws its fire).
    if owner=='laneharass'then return self.config:get('clearHarass')and self:ownerActive('lane')and not self.state:turret(self.hero.pos)end
    if owner=='jungle'and self.autoJungle and self.autoJungle:Active()then return true end
    if owner=='lane'or owner=='jungle'then
        local mode=self:mode();local id=self.sdk[owner=='lane'and 'ORBWALKER_MODE_LANECLEAR'or 'ORBWALKER_MODE_JUNGLECLEAR']
        return (mode=='lane'or mode=='jungle')and self.sdk.Orbwalker.Modes[id]==true
    end
    return self:mode()==owner
end
function App:available()
    if _G.AyyyyIO and _G.AyyyyIO.Allows and not _G.AyyyyIO:Allows()then return false end
    return self.active and self.sdk==SDK and self.hero==myHero and myHero.charName==self.profile.hero and self.config:get('enabled')
        and not myHero.dead and not Game.IsChatOpen()and Game.IsOnTop()
        and not U.buff(myHero,{recall=true,recallimproved=true,zhonyasringshield=true},Game.Timer())
end
function App:anchorValid(o,origin)
    local d=self.state.daggers[U.id(o)]
    if d then return self.profile.id=='normal'and self.state:daggerValid(d)and U.dist(origin or self.hero.pos,d.pos)<=self.profile.eRange end
    if not U.valid(o)or U.same(o,self.hero)or U.dist(origin or self.hero.pos,o.pos)>self.profile.eRange then return false end
    local id=U.id(o)
    -- The owned ward the jump just placed and identified (Game.Ward, owner and
    -- position matched) can precede SharedData and may not be named '*ward*'.
    local pending=self.mobility and self.mobility.pending
    if pending and pending.anchor and U.id(pending.anchor)==id then return self.profile.id=='classic'and o.team==self.hero.team end
    for _,w in ipairs(self.state.objects.wards or {})do if U.id(w)==id then
        local n=U.name(w.charName)
        return self.profile.id=='classic'and w.team==self.hero.team and n~='bluetrinket'and n~='farsightward'and n~='zombieward'
    end end
    -- A new ward can precede SharedData's identity refresh.
    local n=U.name(o.charName)
    if n:find('ward',1,true)or n:find('trinket',1,true)then return self.profile.id=='classic'and o.team==self.hero.team and n~='bluetrinket'and n~='farsightward'and n~='zombieward'end
    for _,kind in ipairs({'heroes','minions'})do for _,x in ipairs(self.state.objects[kind]or {})do if U.id(x)==id then return true end end end
    return false
end
function App:anchors()
    local out,seen={},{}
    local function add(o)if #out<64 and U.id(o)and not seen[U.id(o)]and self:anchorValid(o)then out[#out+1]=o;seen[U.id(o)]=true end end
    for _,o in ipairs(self.state.objects.heroes or {})do add(o)end
    for _,d in pairs(self.state.daggers)do add(d.object)end
    for _,o in ipairs(self.state.objects.minions or {})do add(o)end
    if self.profile.id=='classic'then for _,o in ipairs(self.state.objects.wards or {})do add(o)end end
    return out
end
function App:landing(anchor,target,side,dagger)
    if not self:anchorValid(anchor)then return end
    local pos=dagger and dagger.pos or anchor.pos
    if self.profile.id=='classic'then return U.copy(pos)end
    if side then if U.dist(pos,side)<=self.profile.eOffset then return U.copy(side)else return end end
    local toward=target and U.predict(target,.15)or self:mouse()or self.hero.pos
    return U.toward(pos,toward,math.min(100,U.dist(pos,toward)))
end
function App:hasReturn(pos,used)
    -- E has just been spent. An ally in range is not an immediately available escape.
    return U.dist(pos,self.hero.pos)<=550 and not self.state:turret(pos)
        and self.mobility.terrain:walkLine(pos,self.hero.pos,self.hero.boundingRadius or 35)==true
end
function App:attackRange(o)return(self.hero.range or 125)+(self.hero.boundingRadius or 35)+(o.boundingRadius or 35)end
function App:healthPrediction(o,delay)
    local hp=self.sdk.HealthPrediction or self.sdk.Health
    if hp and hp.GetPrediction then return hp:GetPrediction(o,delay)end
    return o.health
end
function App:aaSaves(o,deadline)
    local attack=self.sdk.Attack
    if U.dist(self.hero.pos,o.pos)>self:attackRange(o)then return false end
    local delay=attack and attack.GetWindup and attack:GetWindup()or .3
    if delay>deadline or (self.sdk.Orbwalker.CanAttack and not self.sdk.Orbwalker:CanAttack())then return false end
    return self.damage:amount('AA',o)>=self:healthPrediction(o,delay)
end
function App:legal(a,resolved,farmFacts)
    if not self:available()or not self:ownerActive(a.owner)then return false,'context_ended'end
    if a.validate then local ok,why=a.validate();if not ok then return false,why or 'dependent_validation'end end
    local pos=resolved or a.pos;local t=a.combatTarget or a.target
    local rules=a.owner=='laneharass'and 'harass'or a.owner
    if a.slot and a.slot<=3 and(rules=='combo'or rules=='harass'or rules=='lane'or rules=='jungle'or rules=='last')then
        if not self.config:get(rules..({'Q','W','E','R'})[a.slot+1])then return false,'spell_setting_disabled'end
    end
    if a.farm and U.valid(t)then
        local impact=a.slot==0 and .25+U.dist(self.hero.pos,t.pos)/self.profile.qSpeed or .2
        -- Only the synchronous planner lends these facts. They are never put
        -- on the action; queued dispatch calls legal() without them.
        local facts=farmFacts and farmFacts.target==t and farmFacts.impact==impact
            and farmFacts.at==Game.Timer()and farmFacts.observedHP==t.health and farmFacts
        local hp=facts and facts.hp or self:healthPrediction(t,impact)
        if hp<=0 then return false,'already_dying_to_incoming_hit'end
        if a.owner=='last'then
            local damage=facts and facts.damage or self.damage:amount(a.slot,t)
            local saved
            if facts and facts.aaSaved~=nil then saved=facts.aaSaved else saved=self:aaSaves(t,impact)end
            if damage<hp or saved then return false,'last_hit_no_longer_needed'end
        end
    end
    if self.state:channel()and a.owner=='combo'and a.release then
        local emptyMove=a.kind=='move'and self.state:enemiesNear(self.hero.pos,self.profile.rRange)==0
        local better=emptyMove
        if not better and a.slot and a.slot<6 and U.valid(t)and not self.damage:lethal(3,t,.34)then
            better=self.damage:lethal(a.slot,t,.3)
            -- Katarina-7: the released cast opens a sequence that still kills inside .6 s; this cast's own slot
            -- is reserved by its queued request, so its readiness is read from the host.
            if not better and a.sequence then
                local est=self.planner:estimate(t,self.hero.pos,3,function(slot)if slot==a.slot then return self.state:ready(slot)end;return self:ready(slot)end)
                better=est.lethal and est.time<=.6 and not self.damage:lethal(3,t,est.time+.1)
            end
        end
        if not better then return false,'r_followup_no_longer_better'end
    end
    if a.extended and(not self.config:get('extended')or self:mode()~='combo')then return false,'extended_consent_ended'end
    if a.kind=='move'then return U.position(pos)and self.mobility.terrain:wall(pos)==false,'movement_terrain_unknown'end
    if a.kind=='attack'then return U.valid(t)and U.dist(self.hero.pos,t.pos)<=self:attackRange(t),'attack_invalid'end
    if a.ward then return true end
    if a.rule then
        local item=self.hero:GetItemData(a.slot)
        if not item or item.itemID~=a.itemID or not self.items:enabled(a.itemID)then return false,'item_changed'end
        if a.rule.active=='stasis'then return self.items:stasisNeeded(),'stasis_not_needed'end
        if a.rule.active=='move'then return a.extended and self.planner:safe(pos,t),'movement_item_unsafe'end
        return U.valid(t)and U.dist(self.hero.pos,t.pos)<=a.rule.range and not self.damage:protected(t),'item_target_invalid'
    end
    if a.slot==1 and a.prepareWall then return a.owner=='jump'or a.owner=='flee','wall_context'end
    -- Katarina-9: Flee W for its movement speed (Normal: always; Classic: only when it strikes a champion).
    if a.slot==1 and a.fleeSpeed then
        return a.owner=='flee'and self.state:enemiesNear(self.hero.pos,self.profile.id=='normal'and 1000 or self.profile.wRange)>0,'flee_speed_no_enemy'
    end
    if not U.valid(t)and not a.dagger then return false,'invalid_target'end
    if t and t.team~=self.hero.team and not a.escape and(self.damage:protected(t)or self.damage:spellShield(t))then return false,'target_protected'end
    if a.slot==0 then return U.dist(self.hero.pos,t.pos)<=self.profile.qRange,'q_range'end
    if a.slot==1 then return U.dist(self.hero.pos,t.pos)<=self.profile.wRange,'w_range'end
    if a.slot==2 then
        local anchor=a.anchor or t;local landing=pos or anchor.pos
        if not self:anchorValid(anchor)then return false,'e_anchor_invalid'end
        if self.profile.id=='normal'and U.dist(landing,anchor.pos)>self.profile.eOffset then return false,'e_offset'end
        if pos and self.mobility.terrain:wall(pos)~=false then return false,'e_terrain_unknown'end
        if a.owner~='jump'and not self.planner:safe(landing,t,a.escape)then return false,'e_safety'end
        -- Avoid selecting a different overlapping E anchor at the outgoing aim.
        if pos then for _,o in ipairs(self:anchors())do
            if not U.same(o,anchor)and U.dist(o.pos,pos)+5<U.dist(anchor.pos,pos)then return false,'e_ambiguous_anchor'end
        end end
        if a.owner=='harass'and(not self:hasReturn(landing,anchor)or self.state:enemiesNear(landing,450)>1)then return false,'harass_no_return'end
        return true
    end
    if a.slot==3 then return not self.state:channel()and not self.state:interruptIncoming()and self.state:enemiesNear(self.hero.pos,self.profile.rActivation)>0,'r_activation_or_observed_interrupt'end
    if a.slot==4 or a.slot==5 then
        local name=U.summoner(self.state:spell(a.slot).name)
        if name=='summonerflash'then return a.extended and U.dist(self.hero.pos,pos)<=400 and self.mobility.terrain:wall(pos)==false and self.planner:safe(pos,t),'flash_invalid'end
        return name=='summonerdot'and U.dist(self.hero.pos,t.pos)<=600 and self.damage:lethal(a.slot,t,5),'ignite_not_lethal'
    end
    return false,'unsupported_action'
end
function App:record()end
function App:flushLog()end
function App:log()end
function App:tick()if self.active then self:decide()end end
function App:decide()
    self.state:refresh();self.items:refresh();self.actions:tick()
    if not self:available()then
        self.actions:cancel(nil,'unavailable');self.mobility:cancel('unavailable')
        self.actions.client:SetBlocked('channel','attack',false);self.actions.client:SetBlocked('channel','move',false);return
    end
    if self.sdk.Evade and type(self.sdk.Evade.Evading)=='function'and self.sdk.Evade:Evading()then
        self.actions.client:SetBlocked('channel','attack',false);self.actions.client:SetBlocked('channel','move',false);return
    end
    local channel=self.state:channel()
    local protect=channel==true or self.actions:rStarting()
    self.actions.client:SetBlocked('channel','attack',protect);self.actions.client:SetBlocked('channel','move',protect)
    local mode=self:mode();local owner=self.config:get('jump')and 'jump'or(mode=='flee'and 'flee'or nil)
    if mode~='harass'then self.trade=nil end
    local defense=self.items:activeCandidate(nil,nil)
    if defense then self.actions:submit(defense);return end
    if self.mobility:tick(owner)then return end
    if self.autoJungle and self.autoJungle:Tick()then return end
    local action
    if not channel and self:ownerActive('idle')then action=self.planner:finisher()end
    if action then
    elseif mode=='combo'or mode=='harass'then action=self.planner:combat(mode)
    elseif mode=='lane'or mode=='jungle'or mode=='last'then
        if not channel then
            if mode=='lane'and self:ownerActive('laneharass')then action=self.planner:combat('harass','laneharass')end
            local farm=self:spellFarm()
            action=action or farm and self.planner:farm(mode)or nil
            if not action and farm and mode=='lane'and self:ownerActive('jungle')then action=self.planner:farm('jungle')end
            if not action and mode~='last'then action=self.planner:pickup(mode)end
        end
    end
    if channel and self.state:enemiesNear(self.hero.pos,self.profile.rRange)==0 and mode=='combo'then
        local pos=self:mouse();if pos then action={kind='move',pos=pos,owner='combo',release=true}end
    end
    self.preview=action
    if action then if action.kind=='wardplan'then self.mobility:start(action.pos,action.owner,action.target)else
        local ok,record=self.actions:submit(action)
        if ok and action.gapQ then self.followQ={target=action.gapQ,record=record,expires=Game.Timer()+1.2}end
    end end
end
function App:draw(display)
    local Draw=display or Draw
    if not self.active or not self.config:get('draw')or not Draw then return end
    local p=self.mobility.preview or self.preview
    if p and p.pos and Draw.Circle then Draw.Circle(U.vector(p.pos),65,2,Draw.Color(220,120,230,180))end
    -- Ability range circles while the ability is ready (native readiness only; re-rank drawings 2026-10-10).
    if Draw.Circle and self.config:get('ranges')then local st,p,h=self.state,self.profile,self.hero.pos
        if st:ready(0)then Draw.Circle(h,p.qRange,1,Draw.Color(120,120,190,255))end
        if st:ready(1)then Draw.Circle(h,p.wRange,1,Draw.Color(120,200,120,255))end
        if st:ready(2)then Draw.Circle(h,p.eRange,1,Draw.Color(120,255,170,90))end
        if st:ready(3)then Draw.Circle(h,p.rRange,1,Draw.Color(120,255,90,90))end
    end
    -- Katarina-10: own daggers from prepared state (state:scan / markDaggerHits); a ring when a pickup reaches a champion.
    if self.profile.id=='normal'and Draw.Circle then
        local now=Game.Timer()
        for _,d in pairs(self.state.daggers)do
            local landed=now>=d.land
            Draw.Circle(U.vector(d.pos),landed and 70 or 45,2,landed and Draw.Color(220,90,230,120)or Draw.Color(200,255,195,75))
            if landed and d.hitsEnemy then Draw.Circle(U.vector(d.pos),self.profile.daggerRadius,1,Draw.Color(170,235,80,80))end
            if not landed and Draw.Text then
                local s=U.vector(d.pos):To2D()
                if s and s.onScreen~=false then Draw.Text(string.format('%.1f',d.land-now),14,s.x-8,s.y-8,Draw.Color(230,255,195,75))end
            end
        end
    end
    local j=self.mobility.shown
    -- Cleared when the key is released; kept up to a second so a late tick never blinks it.
    if j and j.pos and Draw.Circle and Draw.Line and Game.Timer()-(j.at or 0)<1 then pcall(function()
        local green,amber,red,white=Draw.Color(230,65,225,165),Draw.Color(230,255,195,75),Draw.Color(230,235,80,80),Draw.Color(230,220,225,235)
        local color=not j.valid and red or j.approach and amber or green
        local function line(x,y,col)
            if not U.position(x)or not U.position(y)then return end
            local p,q=U.vector(x):To2D(),U.vector(y):To2D()
            if p and q and U.finite(p.x)and U.finite(p.y)and U.finite(q.x)and U.finite(q.y)then
                local overlay=self.sdk.Overlay
                if overlay then local ax,ay,bx,by=overlay:Clip(p.x,p.y,q.x,q.y);if ax then Draw.Line(ax,ay,bx,by,2,col)end
                else Draw.Line(p.x,p.y,q.x,q.y,2,col)end
            end
        end
        Draw.Circle(U.vector(j.pos),50,2,color)
        if j.raw then Draw.Circle(U.vector(j.raw),15,1,white);line(j.raw,j.pos,color)end
        if j.path then local from=self.hero.pos
            for _,point in ipairs(j.path)do line(from,point,amber);from=point end
            if j.stand then Draw.Circle(U.vector(j.stand),35,2,amber);line(j.stand,j.pos,color)end
        else line(self.hero.pos,j.stand or j.pos,color)end
        if j.walkTo then Draw.Circle(U.vector(j.walkTo),20,1,white)end
        local b=U.vector(j.pos):To2D()
        if Draw.Text and b and b.onScreen~=false then Draw.Text(j.label or '',16,b.x+15,b.y,color)end
    end)end
    local action=self.preview;local target=action and(action.combatTarget or action.target)
    if U.valid(target)and Draw.Circle then
        Draw.Circle(target.pos,target.boundingRadius or 45,1,Draw.Color(200,220,170,70))
        local screen=target.pos2D
        if not self.display and screen and screen.onScreen~=false and Draw.Text and action.estimate then Draw.Text('~'..math.floor(action.estimate)..' damage',14,screen.x,screen.y-30,Draw.Color(220,220,230,200))end
    end
end
function App:event(msg,param)
    if not self.active then return end
    local cursor=self.sdk.Cursor
    if cursor and cursor.IsSyntheticEvent and cursor:IsSyntheticEvent()then return end
    if msg==256 and(param==HK_Q or param==HK_W or param==HK_E or param==HK_R)then self.manualGeneration=self.manualGeneration+1;self.actions:cancel(nil,'manual_spell')end
    if msg==516 then
        self.trade=nil
        self.mobility:cancel('manual_pointer');self.mobility.doneHeld=true
        -- A physical right click can interrupt R; never replay or suppress it.
        self.actions.client:SetBlocked('channel','move',false)
    end
end
function App:install()
    local function attach(list,fn)
        assert(type(list)=='table','SDK callback list unavailable')
        if self.core then return self.core:Bind(list,fn)end
        local wrapper=function(...)if not self.active then return end;local ok,why=pcall(fn,...);if not ok then self:log('error',nil,why);self:Shutdown('callback_error');print('[Katarina] '..tostring(why))end end
        list[#list+1]=wrapper;self.callbacks[#self.callbacks+1]={list=list,fn=wrapper}
    end
    -- Health-bar damage and a kill mark for every visible enemy champion within 2500 (at most 5), from the same
    -- short Q/W/E/attack estimate the planner uses (partial: R, items and passive daggers left out). The HUD
    -- shows the spell-farming toggle like every family champion.
    self.display=require('Overlay.client').new(_G,'Katarina.display',function()return self.active and SDK==self.sdk and myHero==self.hero and(not self.core or self.core:Current())end,
        function(d)self:draw(d)end,function()
            local node=self.config.nodes.spellFarm
            return {spellfarm={kind='status',label='Spell farm',enabled=self:spellFarm(),bind=node and node.Key and node:Key()or 73,priority=100}}
        end,function()
            if self.hero.dead or Game.IsChatOpen()or not Game.IsOnTop()then return end
            return self:damageRows()
        end)
    if self.core and self.display then self.core:RegisterService('display',self.display)end
    attach(self.sdk.OnTick,function()self:tick();if self.display then self.display:Prepare(self.config:get('draw'))end end)
    if not self.display then attach(self.sdk.OnDraw,function()if self.drawError then return end;local ok,err=pcall(self.draw,self);if not ok and not self.drawError then self.drawError=tostring(err);print('[Katarina] Display disabled: '..self.drawError)end end)end
    attach(self.sdk.OnWndMsg,function(m,p)self:event(m,p)end)
    if Callback and Callback.Add then
        self.unload=function()self:Shutdown('unload')end
        if self.core then self.core:Bind('UnLoad',self.unload)else Callback.Add('UnLoad',self.unload)end
    end
    self.loadedAt=Game.Timer();self.state:refresh();self.items:refresh();self:log('controller_ready',nil,self.build);self:flushLog(true)
end
function App:damageRows()
    local rows={}
    for _,o in ipairs(self.enemies)do
        if #rows>=5 then break end
        if U.valid(o)and U.dist(self.hero.pos,o.pos)<=2500 then
            local result=self.planner:estimate(o,self.hero.pos)
            if result.damage>0 then rows[#rows+1]={unit=o,damage=result.damage,partial=true,killable=result.lethal==true}end
        end
    end
    return rows
end
function App:Shutdown(reason)
    if not self.active then return end;self.active=false
    if self.core then self.core:Shutdown(reason)end
    if self.display then if not self.core then self.display:Close()end;self.display=nil end
    if self.evade then self.evade:close()end
    if self.actions then self.actions:close()end
    for _,row in ipairs(self.callbacks)do for i=#row.list,1,-1 do if row.list[i]==row.fn then table.remove(row.list,i)end end end
    self.callbacks={}
    if not self.core and self.unload and Callback and Callback.Del then pcall(Callback.Del,'UnLoad',self.unload)end
    if self.config then self.config:close()end
    if self.logger then self:record('shutdown',{reason=reason});pcall(self.flushLog,self,true)end
    if _G.KatarinaController==self then _G.KatarinaController=nil end
end
return App

end
