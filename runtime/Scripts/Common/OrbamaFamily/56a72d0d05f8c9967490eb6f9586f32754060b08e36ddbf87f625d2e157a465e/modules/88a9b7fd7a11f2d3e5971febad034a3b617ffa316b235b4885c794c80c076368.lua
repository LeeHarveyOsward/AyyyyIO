return function(require)
local C={}
C.defaults={enabled=true,autosmite=true,smiteBosses=true,smiteBuffs=true,smiteOther=false,recallEnemyDefaults=true,smiteMargin=10,smiteEpicMargin=0,
    smiteOverride=0,smitePreaim=false,smiteProjectionFallback=true,smiteReserve=false,items=true,potions=true,potionHP=50,potionJungleHP=85,
    cleanse=true,shield=true,shieldHP=30,stasis=true,stasisHP=15,summonerDefense=true,offense=true,ignite=true,level=true,
    wards=true,cooldowns=true,recalls=true,turrets=true,awareness=true,
    wardVision=false,waypoints=false,experience=false,trinket=false,allies=false,draw=true,scale=100,lastSeenRetention=0,minimapSeconds=true,recallSelf=false,smiteKey=78}
C.defaults.itemCleave=true;C.defaults.itemTargeted=true;C.defaults.itemSlow=true;C.defaults.itemSpeed=true
-- Values every reader still asks for but no player tunes: no menu entry, and a
-- value saved by an older menu is ignored.
local fixed={smiteMargin=true,smiteEpicMargin=true,smiteOverride=true,smiteProjectionFallback=true,
    itemCleave=true,itemTargeted=true,itemSlow=true,itemSpeed=true,allies=true,potionJungleHP=true}
local groups={
    {'Smite','Smite',{'autosmite','smiteBosses','smiteBuffs','smiteOther','smiteReserve'}},
    {'Activator','Items and summoner spells',{'items','potions','potionHP','cleanse','shield','shieldHP','stasis','stasisHP','summonerDefense','offense','ignite','level'}},
    {'Tracking','Tracking',{'lastSeenRetention','recallSelf','wards','cooldowns','recalls','turrets','awareness','waypoints','experience'}},
    {'Drawings','Appearance',{'draw','scale','minimapSeconds'}}}
local labels={minimapSeconds='Missing-enemy timer on the minimap',recallSelf='Show my own recall',lastSeenRetention='Keep missing markers (0 = until seen or dead)',
    autosmite='Automatic Smite',smiteBosses='Bosses (dragon, Baron, grubs, Herald)',smiteBuffs='Red and blue buffs',smiteOther='Other jungle camps',smiteReserve='Keep one Smite charge near objectives',
    items='Use items automatically',potions='Drink health potions',potionHP='Potion below health %',cleanse='Remove crowd control (Cleanse, QSS, Mikael)',
    shield='Use shield items',shieldHP='Shield below health %',stasis='Use stasis (Zhonya) in emergencies',stasisHP='Stasis below health %',
    summonerDefense='Heal / Barrier when threatened',offense='Use damage and speed items while fighting',ignite='Ignite enemies it will kill',
    level='Level up abilities automatically',wards='Wards',cooldowns='Enemy cooldowns',recalls='Recalls and teleports',
    turrets='Turret range and aggro warning',awareness='Last seen position in fog',wardVision='Ward vision radius',
    waypoints='Enemy movement paths',experience='Experience bars',trinket='Trinket cooldown',draw='Enable drawings',scale='UI scale %'}
function C.new(g)
    local self={values={},entries={},g=g};local saved=g.OrbamaUtilsConfig or {}
    local migration=require('Orbama.menus');local stored=migration.saved or {}
    local profile=g.myHero and g.myHero.charName:match('^Jade_')and 'classic'or 'normal'
    local old=stored['AyyyyIOLeeSin_'..profile]
    local classic=stored.AyyyyIOControllers_Activator or stored.Classic_AIO_Activator
    local oldKeys={autosmite='autosmite',smiteCamps='smiteExecuteCamps',smiteMargin='smiteMargin',smiteEpicMargin='smiteEpicMargin',
        smiteOverride='smiteOverride',items='items',offense='items',potions='potions',potionHP='potionHP',
        shield='itemShield',cleanse='itemCleanse',shieldHP='shieldHP',level='level',smiteKey='smiteKey',
        itemCleave='itemCleave',itemTargeted='itemTargeted',itemSlow='itemSlow',itemSpeed='itemSpeed',
        smiteProjectionFallback='smiteProjectionFallback'}
    local function find(tree,key,depth,field)
        if type(tree)~='table'or depth>8 then return end
        if type(tree[key])=='table'and (field==nil or tree[key][field]~=nil) then return tree[key]end
        for _,child in pairs(tree)do local found=find(child,key,depth+1,field);if found then return found end end
    end
    -- One-time migrations. Any saved marker means applied. The hidden marker is
    -- created false and switched to true at once, so a host that saves only
    -- values changed from their creation default still records it.
    local function done(key)return find(stored.OrbamaUtils,key,0)~=nil end
    self.migrateRecall=not done('recallEnemyDefaults')
    self.migrateReserve=saved.smiteReserve==nil and not done('smiteCategoryDefaults') and find(stored.OrbamaUtils,'smiteBosses',0)==nil and find(stored.OrbamaUtils,'smiteBuffs',0)==nil and find(stored.OrbamaUtils,'smiteOther',0)==nil
    -- The retired "Also Smite normal camps" switch covered buffs and small camps.
    -- A saved "off" keeps buffs off in the category model (small camps default off).
    local oldCamps
    if self.migrateReserve then
        local entry=find(stored.OrbamaUtils,'smiteCamps',0,'__active') or find(old,'smiteExecuteCamps',0,'__active')
        if entry and type(entry.__active)=='boolean'then oldCamps=entry.__active end
        if saved.smiteCamps~=nil then oldCamps=saved.smiteCamps==true end
    end
    for k,v in pairs(C.defaults)do
        local field=k=='smiteKey'and '__key'or '__active'
        local entry=find(stored.OrbamaUtils,k,0,field)
        if not entry and oldKeys[k]then entry=find(old,oldKeys[k],0,field)end
        if not entry then
            local tracker=stored.CAMenu
            local map={wards=stored.WardAwareness,
                cooldowns=tracker and tracker.SpellTracker,waypoints=tracker and tracker.WaypointTracker,
                experience=tracker and tracker.ExpTracker,offense=classic and classic.Offensive}
            local group=map[k];entry=group and group.Enabled
            if k=='trinket'then entry=tracker and tracker.SpellTracker and tracker.SpellTracker.TrackTrinket end
            if not entry and k=='level'then entry=stored.OrbamaTwistedFate and stored.OrbamaTwistedFate.level end
        end
        local value=entry and entry[k=='smiteKey'and '__key'or '__active']
        self.values[k]=type(value)==type(v)and value or v
        if type(value)=='boolean'then self.values[k]=value end
        if saved[k]~=nil then self.values[k]=saved[k]end
        if fixed[k]then self.values[k]=v end
        -- Retire the old three-minute default once; a later explicit 180 stays.
        if k=='lastSeenRetention'and self.migrateRecall and self.values[k]==180 then self.values[k]=0 end
    end
    if self.migrateRecall then self.values.recallSelf=false end
    if self.migrateReserve then self.values.smiteReserve=false;if oldCamps==false then self.values.smiteBuffs=false end end
    function self:get(k)if k=='smiteCamps'then k='smiteOther'end;local e=self.entries[k];if e then return e:Value()end;return self.values[k]end
    function self:set(k,v)self.values[k]=v;local e=self.entries[k];if e then e:Value(v)end end
    function self:key(k)local e=self.entries[k];return e and e:Key()or self.values[k]end
    function self:install()
        if not g.MenuElement then return end
        local root=g.MenuElement({type=g.MENU,id='OrbamaUtils',name='Orbama Utils'});self.menu=root
        root:MenuElement({type=g.MENU,id='Controls',name='Controls'})
        root:MenuElement({type=g.MENU,id='Automation',name='Automation'})
        root:MenuElement({id='enabled',name='Enabled',value=self.values.enabled});self.entries.enabled=root.enabled
        for _,row in ipairs(groups)do
            local icons={Smite='/Gamsteron_Spell_SummonerSmite.png',Activator='/3157.png',Tracking='/3340.png',Drawings='/Gamsteron_Drawings.png'}
            local parent=(row[1]=='Smite'or row[1]=='Activator')and root.Automation or root
            local id=row[1]=='Drawings'and 'Appearance'or row[1]
            parent:MenuElement({type=g.MENU,id=id,name=row[2],leftIcon=migration:Icon(icons[row[1]])});local group=parent[id];root[row[1]]=group
            for _,k in ipairs(row[3])do
                local spec={id=k,name=labels[k],value=self.values[k]}
                if type(spec.value)=='number'then spec.min=k=='scale'and 50 or 0;spec.max=k=='lastSeenRetention'and 600 or k=='smiteOverride'and 2000 or k=='scale'and 200 or 100;spec.step=1 end
                group:MenuElement(spec);self.entries[k]=group[k]
            end
        end
        if self.migrateReserve then self.entries.smiteReserve:Value(false);if oldCamps==false then self.entries.smiteBuffs:Value(false)end end
        root.Smite:MenuElement({id='smiteCategoryDefaults',name='Smite category migration',value=false})
        root.Smite.smiteCategoryDefaults:Value(true)
        if root.Smite.smiteCategoryDefaults.Hide then root.Smite.smiteCategoryDefaults:Hide(true)end
        root.Controls:MenuElement({id='smiteKey',name='Auto-Smite on / off',key=self.values.smiteKey,toggle=false})
        self.entries.smiteKey=root.Controls.smiteKey;root.Smite.smiteKey=root.Controls.smiteKey
        self.drawOptions={}
        for _,name in ipairs({'wards','cooldowns','recalls','turrets','awareness','waypoints','experience'})do
            root.Drawings:MenuElement({id=name,type=g.MENU,name=labels[name]})
            local parent=root.Drawings[name];self.drawOptions[name]=parent
            local tracker=stored.CAMenu
            local oldGroup=tracker and tracker[({cooldowns='SpellTracker',waypoints='WaypointTracker',experience='ExpTracker'})[name]or '']
            local savedGroup=stored.OrbamaUtils and((stored.OrbamaUtils.Appearance and stored.OrbamaUtils.Appearance[name])or(stored.OrbamaUtils.Drawings and stored.OrbamaUtils.Drawings[name]))
            local function preference(id,oldID,default)
                local entry=savedGroup and savedGroup[id]
                if not entry then entry=oldGroup and oldGroup[oldID]end
                local value=entry and entry.__active
                if type(value)==type(default)then return value end
                return default
            end
            parent:MenuElement({id='Screen',name='On screen',value=true})
            parent:MenuElement({id='Minimap',name='On minimap',value=name=='wards'or name=='awareness'})
            parent:MenuElement({id='Enemies',name='Enemies',value=preference('Enemies','TEnemies',true)})
            parent:MenuElement({id='Allies',name='Allies',value=preference('Allies','TAllies',self.values.allies)})
            if name=='recalls'and self.migrateRecall then parent.Allies:Value(false);parent.Enemies:Value(true)end
            parent:MenuElement({id='Distance',name='Only within this distance (0 = everywhere)',value=0,min=0,max=15000,step=250})
            if name=='waypoints'then
                parent:MenuElement({id='Name',name='Show name',value=preference('Name','EPName',true)})
                parent:MenuElement({id='Time',name='Show travel estimate',value=preference('Time','EPTime',true)})
            end
        end
        if self.migrateRecall and self.entries.recallSelf then self.entries.recallSelf:Value(false)end
        root.Tracking:MenuElement({id='recallEnemyDefaults',name='Recall defaults migration',value=false})
        root.Tracking.recallEnemyDefaults:Value(true)
        if root.Tracking.recallEnemyDefaults.Hide then root.Tracking.recallEnemyDefaults:Hide(true)end
        self.wardOptions={}
        for _,kind in ipairs({'VisionWard','SightWard','Trinket','Farsight','Unknown'})do
            local names={VisionWard='Control / vision wards',SightWard='Sight wards',Trinket='Warding trinkets',Farsight='Farsight',Unknown='Other wards'}
            local parent=root.Drawings.wards
            parent:MenuElement({id=kind,type=g.MENU,name=names[kind]})
            local node=parent[kind];self.wardOptions[kind]=node
            local oldNode=stored.WardAwareness and stored.WardAwareness[kind]
            local newNode=stored.OrbamaUtils and((stored.OrbamaUtils.Appearance and stored.OrbamaUtils.Appearance.wards and stored.OrbamaUtils.Appearance.wards[kind])or(stored.OrbamaUtils.Drawings and stored.OrbamaUtils.Drawings.wards and stored.OrbamaUtils.Drawings.wards[kind]))
            for _,option in ipairs({'ScreenDisplay','OwnerDisplay','TimerDisplay','VisionDisplay','MinimapDisplay'})do
                local entry=newNode and newNode[option]or oldNode and oldNode[option]
                local value=option=='TimerDisplay'or option=='MinimapDisplay'or option=='VisionDisplay'and self.values.wardVision
                if entry and type(entry.__active)=='boolean'then value=entry.__active end
                local labels={ScreenDisplay='Name',OwnerDisplay='Owner',TimerDisplay='Lifetime',VisionDisplay='Sight radius',MinimapDisplay='On minimap'}
                node:MenuElement({id=option,name=labels[option],value=value})
            end
        end
    end
    function self:wardVisible(kind,option)
        local node=self.wardOptions and(self.wardOptions[kind]or self.wardOptions.Unknown)
        return node and node[option]:Value()or not node and(option=='TimerDisplay'or option=='MinimapDisplay'or option=='VisionDisplay'and self:get('wardVision'))
    end
    function self:includes(name,team,pos)
        local options=self.drawOptions and self.drawOptions[name]
        local ally=team==g.myHero.team
        if options then
            if not options[ally and 'Allies'or 'Enemies']:Value()then return false end
            local distance=options.Distance:Value()
            if distance>0 and pos then
                local dx,dz=pos.x-g.myHero.pos.x,pos.z-g.myHero.pos.z
                if dx*dx+dz*dz>distance*distance then return false end
            end
        elseif ally and not self:get('allies')then return false end
        return true
    end
    function self:visible(name,where)
        local options=self.drawOptions and self.drawOptions[name]
        if not options then return true end
        return options[where]:Value()==true
    end
    return self
end
return C

end
