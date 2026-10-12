return function(require)
local U=require('leesin.util')
local C={}
local drawingModes={{'Combo','Combo','COMBO','fight'},{'Harass','Harass','HARASS','harass'},
    {'LaneClear','Lane clear','LANECLEAR','clear'},{'JungleClear','Jungle clear','JUNGLECLEAR','clear'},
    {'LastHit','Last hit','LASTHIT','last_hit'},{'Flee','Flee','FLEE','flee'},
    {'AutoJungle','Auto-jungle',nil,'farm'},{'Insec','Insec',nil,'insec'}}
local drawingGroups={drawQRange='Q',drawWRange='W',drawERange='E',drawRRange='R',
    drawWardRange='WardRange',drawHUD='Status',drawWard='Wardjump',drawInsec='Insec',damageBars='Damage'}
C.defaults={
    guideOpen=false,guideKey=119,guidePreviousKey=118,guideNextKey=120,guidePage=1,guideScale=100,
    enabled=true,cursorKey=5,allyKey=6,wardKey=84,autoJungleKey=74,qAssistKey=85,smiteKey=78,secureKey=0,autoJungle=false,
    lastAbilities=true,lastQ=true,lastW=false,lastE=true,waveAbilities=true,waveQ=true,waveW=true,waveE=true,waveHarass=false,
    jungleAbilities=true,jungleQ=true,jungleQ2=true,jungleW=true,jungleE=true,jungleQ2MeleeOnly=true,jungleQ2RangeScale=2,
    autoClearAbilities=true,autoClearQ=true,autoClearQ2=true,autoClearW=true,autoClearE=true,
    clearKrugE=true,farmPreserveQ=true,
    waveSoften=true,waveHorizon=3,farmCameraHoldKey=32,farmQTravel=true,farmQAdjust=false,farmQBlind=true,clearQTiming=true,
    laneEstimates=true,laneDamageMargin=10,csGoldPriority=true,
    farmFollowCamera=true,farmKite=true,farmKiteDistance=260,farmKiteLeash=350,farmLocalEnemyStart=true,
    farmMinimap=true,farmSurvivalLevel=5,
    potions=true,potionJungle=true,potionAuto=true,potionFight=true,potionHP=85,
    itemCleave=true,itemTargeted=true,itemSlow=true,itemSpeed=true,itemCleanse=true,itemShield=true,
    expiryW=true,expiryE=true,recastReserve=50,
    autosmite=true,smiteCamps=true,smiteProjectionFallback=true,smiteMargin=10,smiteEpicMargin=0,smiteOverride=0,
    wardAssist=true,assistRadius=120,reuseRadius=55,wardRange=600,wardTimeout=900,cancelOnly=false,
    wardApproach=true,wardWalkRange=0,wardJumpTimeout=2000,wardFastCursor=true,wardFollowCursor=true,
    wardEarlyW=true,wardEarlyDelay=20,insecLandingMargin=180,insecCloseWard=true,
    aimLock=2,insecFlash=true,insecPreviewKey=18,insecTimeout=5,comboQ=true,comboQ2=false,comboW=true,comboW2=true,comboE=true,comboE2=true,comboR=true,
    harassQ=true,harassQ2=false,harassW=false,harassW2=false,harassE=true,harassE2=true,harassR=false,
    qOnlySelected=false,comboConserveR=true,comboWardRetry=2500,
    insecQ=true,insecBridges=true,insecW=true,insecChains=true,insecWalk=120,insecLead=120,insecOrbwalk=true,insecFlashFallback=false,
    insecAngle=35,insecStandDistance=325,insecAutoLead=true,insecDashEstimate=250,
    insecMouseTarget=true,insecMouseRadius=200,insecTrackAlly=true,drawInsecTolerance=false,
    insecPreferStructures=true,insecBasePlatform=true,
    multi=true,multiHits=3,collateralKills=true,autoMultiR=true,multiFlash=false,smiteMinionQ=false,harassDive=false,fleeJump=true,interruptR=true,drawMultiKick=true,combatEstimates=true,combatDamageMargin=25,comboWard=false,items=true,hitchance=1,q2Safety=true,
    comboPassive=true,comboBurst=true,comboKickFollow=true,comboIsolate=true,comboWardPreserveQ=false,
    comboWalkWait=1000,comboWardGain=550,comboChaseE2=true,
    idleDefense=true,reserveW=true,shieldHP=35,allyShieldHP=25,killQ=true,killE=true,killQ2=true,killR=true,
    clearEnergy=15,recallHP=25,level=true,invade=false,
    draw=true,diagnostics=false,fileLogging=false,playtestLogging=false,combatLogging=false,performanceLogging=false,mechanicsVerified=false,rangeVerified=false,
    smiteVerified=false,monsterQCap=0,farmQRespawn=true,
    defensiveR=true,
    comboIgnite=false,igniteExecute=true,
    damageBars=true,damageSafe=true,damageMax=false,damageText=false,damageSelected=false,damageCurrent=true,
    damageQ=true,damageE=true,damageR=true,damageItems=true,damageSummoners=true,damageAutos=2,
    damageWidth=100,damageX=25,damageY=-13,damageHeight=4,damageHorizon=3,drawHUD=false,drawWard=true,drawInsec=true,
    drawQRange=2,drawWRange=false,drawERange=false,drawRRange=false,drawWardRange=false}
-- Rows: {setting, menu label, nil, slider min, slider max}. Rows listed in
-- `developer` and the Validation section are not shown; they keep their defaults.
local sections={
    {'Keys',{{'cursorKey','Insec: kick toward cursor (hold)'},{'allyKey','Insec: kick toward team or turret (hold)'},
        {'insecPreviewKey','Insec preview (hold with an Insec key)'},
        {'wardKey','Wardjump (hold to aim, release to jump)'},{'autoJungleKey','Auto-jungle on / off'},{'qAssistKey','Cast Q1 only (hold)'},
        {'smiteKey','Autosmite on / off'},{'secureKey','Q + Smite an epic monster (hold)'}}},
    {'Ward',{{'wardAssist','Find a landing behind the wall near the cursor'},{'assistRadius','Wall search radius around the cursor',nil,30,240},
        {'wardApproach','Walk into jump range after release'},{'wardWalkRange','Longest walk to the jump spot (0 = any)',nil,0,20000},
        {'wardFastCursor','Chain ward to W through one cursor move'},
        {'wardFollowCursor','Move toward cursor after jump'},
        {'wardEarlyW','One early W before the ward is seen'},
        {'wardEarlyDelay','Early W delay (ms)',nil,5,100},
        {'reuseRadius','Jump to a unit or ward this close to the aim',nil,10,100},{'wardRange','Maximum placement range',nil,100,700},
        {'wardTimeout','Ward wait timeout (ms)',nil,300,1800},
        {'wardJumpTimeout','W retry window (ms)',nil,500,4000},{'cancelOnly','Cancel without movement'},
        {'fleeJump','Flee: jump toward the cursor when an enemy is near'}}},
    {'Combat',{{'comboQ','Use Q1'},{'comboQ2','Use Q2 even when it does not kill'},
        {'comboW','Use W1'},{'comboW2','Use W2'},{'comboE','Use E1'},{'comboE2','Use E2'},{'comboR','Use R'},
        {'comboConserveR','Save R when something else kills in time'},
        {'qOnlySelected','Q1 only at the selected enemy'},
        {'comboWard','Spend wards to catch a fleeing enemy'},{'comboWardRetry','Wait between chase wards (ms)',nil,1000,5000},
        {'multi','Kick an enemy into other enemies'},{'multiHits','Minimum total champions hit',nil,2,5},
        {'collateralKills','Kick an enemy into others to kill them'},
        {'autoMultiR','Multi-kick without holding a mode key'},
        {'multiFlash','Flash to kick an enemy into others'},
        {'smiteMinionQ','Smite a lane minion that blocks a killing Q'},
        {'combatEstimates','Cautious damage estimates'},
        {'combatDamageMargin','Extra health margin for kill checks',nil,0,150},
        {'comboPassive','Attack twice between spells (passive)'},
        {'comboBurst','Skip passive attacks when a kill is ready'},
        {'comboKickFollow','After a 1v1 kick, follow with Q2'},
        {'comboIsolate','Kick a marked enemy away from their team'},
        {'comboWalkWait','Walk instead when it takes less than (ms)',nil,200,2000},
        {'comboWardGain','Ward only if it saves at least (ms)',nil,100,1500},
        {'comboChaseE2','Slow with E2 before spending a ward'},
        {'insecFlash','Allow Flash'},
        {'insecLandingMargin','Minimum ward distance behind the target',nil,80,250},
        {'insecCloseWard','Allow a closer ward for a valid kick'},
        {'insecFlashFallback','No preview: Flash only if no ward is ready'},
        {'insecTimeout','Give up after (seconds)',nil,2,10},
        {'insecQ','Use Q1 and Q2 to reach the target'},{'insecBridges','Use other units as Q stepping stones'},
        {'insecMouseTarget','No selection: use enemy near cursor'},
        {'insecMouseRadius','Cursor pick radius',nil,75,350},
        {'insecTrackAlly','Follow the chosen ally until the kick is set'},
        {'insecPreferStructures','Prefer kicking into a friendly turret'},
        {'insecBasePlatform','Also kick toward our fountain'},
        {'drawInsecTolerance','Show accepted kick angle'},
        {'insecW','Use W on wards and allies to get behind'},{'insecChains','Combine Q, W and Flash'},
        {'insecWalk','Longest walk to fix the kick angle',nil,0,180},
        {'insecOrbwalk','Attack and move while waiting for a way in'},
        {'insecAngle','Accepted kick angle error (degrees)',nil,5,60},
        {'insecStandDistance','Preferred distance behind the target',nil,150,350},
        {'insecAutoLead','Predict ward handoff and dash duration'},
        {'insecDashEstimate','Initial dash duration estimate (ms)',nil,100,500},
        {'insecLead','Moving target placement prediction (ms)',nil,0,300},
        {'q2Safety','Never Q2 under an enemy turret'},{'items','Use item actives'},{'hitchance','Q prediction confidence',nil,1,3},
        {'comboIgnite','Use Ignite in Combo'},{'igniteExecute','Ignite only when it kills'}}},
    {'Harass',{{'harassQ','Use Q1'},{'harassQ2','Use Q2 (dash to the marked enemy)'},{'harassW','Use W1'},
        {'harassW2','Use W2'},{'harassE','Use E1'},{'harassE2','Use E2'},{'harassR','Use R'},
        {'harassDive','Dash in with Q2, hit, then jump back out with W'}}},
    {'Idle',{{'idleDefense','Use W and defensive items when in danger'},
        {'reserveW','Save W for jumps and life-saving shields'},
        {'expiryW','Use W2 before it expires'},{'expiryE','Use E2 before it expires if it hits an enemy'},
        {'recastReserve','Energy kept after those recasts',nil,0,100},{'shieldHP','Shield yourself below health %',nil,10,80},
        {'allyShieldHP','Shield an ally below health %',nil,10,60},{'killQ','Kill with Q1'},{'killE','Kill with E'},
        {'interruptR','Kick an enemy out of a dangerous channel'},
        {'killQ2','Use Q2 when it kills (dashes in)'},{'killR','Kill with R'}}},
    {'Activator',{{'potions','Use health potions'},
        {'potionJungle','Potions in jungle clear'},{'potionAuto','Potions in auto-jungle'},{'potionFight','Potions in fights'},
        {'potionHP','Use a potion below health %',nil,30,95},
        {'itemCleave','Tiamat / Hydra / Stridebreaker'},{'itemTargeted','Damage items cast on a champion'},
        {'itemSlow','Randuin slow'},{'itemSpeed','Movement and attack-speed items'},
        {'itemCleanse','QSS / Mercurial cleanse'},{'itemShield','Locket shield'}}},
    {'Smite',{{'autosmite','Autosmite on / off'},{'smiteCamps','Smite ordinary camps in every mode'},
        {'smiteProjectionFallback','Aim at an isolated target without hover'},
        {'smiteMargin','Camp health margin',nil,0,100},{'smiteEpicMargin','Epic monster health margin',nil,0,100},
        {'smiteOverride','Exact damage override (0 = live / profile)',nil,0,2000}}},
    {'Farm',{{'autoJungle','Auto-jungle on / off'},{'clearEnergy','Keep energy above % while clearing',nil,0,80},{'recallHP','Recall below health %',nil,10,60},
        {'farmFollowCamera','Keep the camera on Lee while auto-jungling'},{'farmCameraHoldKey','Center-camera key (held while auto-jungling)'},
        {'farmMinimap','Click the minimap for long walks'},
        {'farmQAdjust','Allow small detours to line up Q'},
        {'farmSurvivalLevel','Play camps safely until level',nil,1,10},
        {'farmLocalEnemyStart','Finish an enemy camp you start next to'},{'invade','Route into the enemy jungle'},
        {'defensiveR','Kick an attacker away, then stop routing'},
        {'level','Level up abilities automatically'}}},
    {'Wave',{
        {'csGoldPriority','When a minion must be lost, keep the richer one'},
        {'waveAbilities','Use abilities to farm the wave'},{'waveQ','Use Q1 on minions an attack would miss'},{'waveW','Use W (attack speed and healing)'},
        {'waveE','Use E1'},{'waveHarass','Also harass (last hits come first)'},
        {'waveSoften','E the whole wave when last hits stay safe'},{'waveHorizon','Look ahead for last hits (seconds)',nil,2,5},
        {'laneEstimates','Cautious lane damage estimates'},
        {'laneDamageMargin','Extra spell damage margin (%)',nil,0,40}}},
    {'LastHit',{{'lastAbilities','Use abilities to save last hits'},{'lastQ','Use Q1'},
        {'lastW','Use W (faster passive attacks)'},{'lastE','Use E1'}}},
    {'Jungle',{{'jungleAbilities','Use abilities on camps'},{'jungleQ','Use Q1'},
        {'clearQTiming','Estimate attack / Q2 finish time'},
        {'jungleQ2','Use Q2'},{'jungleQ2MeleeOnly','Only Q2 from close range'},
        {'jungleQ2RangeScale','Close range = attack range x',nil,1,4},
        {'jungleW','Use W'},{'jungleE','Use E'},
        {'clearKrugE','Save E for when Krugs split'}}},
    {'AutoClear',{{'autoClearAbilities','Use abilities on camps'},{'farmQTravel','Use Q to travel to camps'},
        {'farmKite','Kite camp monsters between attacks'},{'farmKiteDistance','Longest kite step',nil,30,400},
        {'farmKiteLeash','Stay this close to the camp',nil,150,450},
        {'farmQBlind','Q into unseen camps to check them'},{'autoClearQ','Use Q1'},
        {'farmQRespawn','Also check camps that should have respawned'},
        {'autoClearQ2','Use Q2'},{'autoClearW','Use W'},{'autoClearE','Use E'},
        {'farmPreserveQ','Save Q1 at the end of a camp for the next one'}}},
    {'Drawings',{{'drawWard','Wardjump preview'},{'drawInsec','Insec preview'},
        {'drawQRange','Q range'},{'drawWRange','W range'},{'drawERange','E range'},{'drawRRange','R range'},
        {'drawWardRange','Ward placement range'},{'drawMultiKick','Multi-kick hits and kills'},
        {'damageBars','Enemy health-bar damage'},{'damageSafe','Show a cautious estimate'},{'damageMax','Show the all-in estimate'},
        {'damageCurrent','Current combat target only'},{'damageText','Show estimated damage numbers'},{'damageSelected','Selected target only'},
        {'damageQ','Include Q'},{'damageE','Include E'},{'damageR','Include R in the all-in estimate'},
        {'damageItems','Include item actives'},{'damageSummoners','Include damaging summoner spells'},
        {'damageAutos','Attacks counted',nil,0,5},{'damageHorizon','Estimate window (seconds)',nil,1,5},
        {'damageWidth','Health-bar width',nil,50,200},{'damageX','Health-bar X offset',nil,-200,200},
        {'damageY','Health-bar Y offset',nil,-200,200},{'damageHeight','Damage strip height',nil,1,10}}},
    {'Validation',{{'mechanicsVerified','Champion damage / buffs verified'},{'rangeVerified','Ward range verified'},
        {'monsterQCap','Measured Q monster cap (0 = no Q damage budget)',nil,0,3000},
        {'smiteVerified','Smite profile measured'},{'diagnostics','Record diagnostic events'},
        {'fileLogging','Persist errors / ward / input diagnostics'},{'combatLogging','Full-match combat recording'},
        {'performanceLogging','Measure component times'},
        {'playtestLogging','Temporary detailed jungle capture'}}},
}
function C.new(profile)
    local self={values={},nodes={}}
    local shared=_G.AyyyyIO and _G.AyyyyIO.loading
    local revisedDefaults={comboIgnite='comboIgniteOptInR23',killQ2='killQ2LethalR85',comboWard='comboWardOptInR85',killR='killRR23',comboWardPreserveQ='comboWardPreserveQOptInR25',
        insecFlashFallback='insecFlashFallbackOffR86'}
    for k,v in pairs(C.defaults) do self.values[k]=v end
    -- Boolean false must not fall through to the initial default.
    function self:get(k)
        if k=='diagnostics' or k=='fileLogging' or k=='playtestLogging' or k=='combatLogging' or k=='performanceLogging' or k=='drawHUD' then return false end
        local node=self.nodes[k];if not node then return self.values[k] end
        local scope=U.buffScopeKey()
        if not scope then return node:Value() end
        if self.readScope~=scope then self.readScope=scope;self.readCache={} end
        local cached=self.readCache[k]
        if cached~=nil then return cached end
        local value=node:Value();self.readCache[k]=value;return value
    end
    function self:set(k,v)
        self.writeSerial=self.writeSerial or {};self.writeSerial[k]=(self.writeSerial[k] or 0)+1
        self.values[k]=v;if self.nodes[k] then self.nodes[k]:Value(v) end
        if self.readCache then self.readCache[k]=nil end
        self.capture=self:get('fileLogging') or self:get('diagnostics')
    end
    function self:key(k)
        -- New menu IDs avoid inheriting the old duplicated V/C bindings.
        if k=='farmKey' then k='autoJungleKey' elseif k=='qKey' then k='qAssistKey' end
        local n=self.nodes[k];return n and n:Key() or self.values[k]
    end
    function self:visible(key,sdk,mode)
        local enabled=self:get(key)
        if key=='drawQRange' then enabled=enabled~=1 end
        if not enabled then return false end
        local options=self.drawingOptions and self.drawingOptions[key]
        if not options then
            if key~='drawQRange' or self:get(key)==3 then return true end
            local active=sdk and sdk.Orbwalker and sdk.Orbwalker.Modes
            local index=sdk and sdk.ORBWALKER_MODE_HARASS
            if active and index then return active[index]==true end
            return mode=='harass'
        end
        if options.Always:Value() then return true end
        local active=sdk and sdk.Orbwalker and sdk.Orbwalker.Modes
        for _,entry in ipairs(drawingModes) do
            if options[entry[1]]:Value() then
                local index=entry[3] and sdk and sdk['ORBWALKER_MODE_'..entry[3]]
                local held
                if active and index then held=active[index]==true
                else held=mode==entry[4] end
                if entry[1]=='Insec' then held=mode=='cursor' or mode=='ally' end
                if held then return true end
            end
        end
        return false
    end
    -- Read an explicitly supplied local recording profile without replacing the provider.
    -- Read it independently without loading/replacing the provider or publishing
    -- globals. An explicitly supplied profile (including enabled=false) wins.
    local test={}
    if test.enabled then
        self.values.fileLogging=true;self.values.playtestLogging=true;self.values.combatLogging=true
        self.values.performanceLogging=test.profile==true
        for k,v in pairs(test.lho or {}) do if self.values[k]~=nil and type(v)==type(self.values[k]) then self.values[k]=v end end
    end
    self.capture=self.values.fileLogging or self.values.diagnostics
    self.menuEntries={}
    local smiteEquipped=false
    if myHero and myHero.GetSpellData then for slot=4,5 do
        local spell=myHero:GetSpellData(slot)
        if spell and (spell.name or ''):lower():find('smite',1,true) then smiteEquipped=true end
    end end
    local developer={wardEarlyW=true,wardEarlyDelay=true,wardFastCursor=true,wardRange=true,wardTimeout=true,
        wardJumpTimeout=true,insecDashEstimate=true,insecLead=true,smiteOverride=true,
        cancelOnly=true,smiteProjectionFallback=true,
        insecAutoLead=true,insecLead=true,insecDashEstimate=true,
        combatEstimates=true,laneEstimates=true,clearQTiming=true,
        -- Tuning values and display details that are only good defaults (player menu standard 2026-10-11).
        hitchance=true,assistRadius=true,wardWalkRange=true,reuseRadius=true,multiHits=true,combatDamageMargin=true,
        comboWardRetry=true,comboWalkWait=true,comboWardGain=true,insecLandingMargin=true,insecTimeout=true,
        insecMouseRadius=true,insecWalk=true,insecAngle=true,insecStandDistance=true,recastReserve=true,
        waveHorizon=true,laneDamageMargin=true,jungleQ2RangeScale=true,
        damageSafe=true,damageCurrent=true,damageSelected=true,damageQ=true,damageE=true,damageR=true,
        damageItems=true,damageSummoners=true,damageAutos=true,damageHorizon=true,damageWidth=true,
        damageX=true,damageY=true,damageHeight=true}
    local function destination(section,key)
        if shared and(section=='Smite'or section=='Activator'or key=='items'or key=='level'or key=='smiteKey')then return nil end
        if section=='Validation' or developer[key] then return nil end
        if key=='farmCameraHoldKey' then return 'Controls' end
        -- Auto-jungle shows only real choices (player request 2026-10-11); the rest keeps its defaults.
        if section=='AutoClear' then return nil end
        if section=='Farm' then
            if key=='invade' or key=='farmFollowCamera' then return 'Farming' end
            if key=='level' then return 'Assists' end
            return nil
        end
        if key:match('^insec') and key~='insecPreviewKey' then return 'Insec' end
        if key=='drawInsecTolerance' then return 'Drawings' end
        if section=='Keys' then return 'Controls' end
        if section=='Combat' then return 'Combat' end
        if section=='Idle' then return 'Assists' end
        if section=='Harass' then return 'Harass' end
        if section=='Wave' or section=='LastHit' or section=='Jungle' then return section end
        if section=='Ward' then return 'Wardjump' end
        if section=='Activator' or section=='Smite' then return 'SmiteItems' end
        if section=='Drawings' then return 'Drawings' end
        return 'Farming'
    end
    if MenuElement then
        local iconFor=require('leesin.menuicons').new()
        self.menu=MenuElement({type=MENU,id='AyyyyIOLeeSin_'..profile.id,name=shared and 'AyyyyIO - Lee Sin'or 'Lee Harvey Osward'})
        self.menu:MenuElement({id='enabled',name='Enabled',value=true,leftIcon=iconFor('enabled')});self.nodes.enabled=self.menu.enabled
        local migration=_G.SDK and SDK.MenuMigration
        if not migration then
            local ok,module=pcall(require,'Orbama.menus')
            if ok then migration=module end
        end
        if migration and migration.Grouped then migration:Grouped(self.menu,'AyyyyIOLeeSin_'..profile.id,function(a)
            return (a.id=='Guide'or a.id=='Controls')and 'Controls'or(a.id=='Drawings'or a.id=='draw')and 'Appearance'or 'Automation'
        end)end
        local groups={{'Guide','Guide'},{'Controls','Controls'},{'Combat','Combo'},{'Harass','Harass'},
            {'Assists','Automatic (no mode key)'},{'Insec','Insec'},{'Wave','Lane clear'},
            {'LastHit','Last hit'},{'Jungle','Jungle clear'},{'Wardjump','Wardjump'},
            {'Farming','Auto-jungle'},{'SmiteItems','Smite and items'},{'Drawings','Drawings'}}
        for _,group in ipairs(groups) do
            if not(shared and group[1]=='SmiteItems')then
            local icon=iconFor(group[1])
            local args={id=group[1],name=group[2],type=MENU,leftIcon=icon}
            local ok=pcall(self.menu.MenuElement,self.menu,args)
            if not ok and not self.menu[group[1]] then args.leftIcon=nil;self.menu:MenuElement(args) end
            end
        end
        self.drawingOptions={}
        local function drawingBranch(key)
            if drawingGroups[key] then return drawingGroups[key] end
            if key:match('^damage') then return 'Damage' end
            if key=='drawInsecTolerance' then return 'Insec' end
        end
        local function add(group,args,oldPath,advanced,semanticKey)
            local key=semanticKey or args.id
            args.leftIcon=iconFor(key)
            local parent=self.menu[group];local path=group
            local branch=group=='Drawings' and drawingBranch(args.id)
            if branch then
                local names={Damage='Damage estimates',Status='Status panel',WardRange='Ward range',Wardjump='Wardjump preview',Insec='Insec preview'}
                if not parent[branch] then
                    local icon=iconFor(branch)
                    parent:MenuElement({id=branch,name=names[branch] or branch..' range',type=MENU,leftIcon=icon})
                end
                parent=parent[branch];path=path..'.'..branch
            end
            local priorPath=path
            local category
            if group=='Combat' then
                if key:match('^combo[QWER]%d?$') or key=='q2Safety' or key=='hitchance' or key=='qOnlySelected' then category='Abilities'
                elseif key:match('^comboWard') or key=='comboWalkWait' or key=='comboChaseE2' then category='Chase'
                elseif key=='multi' or key=='multiHits' or key=='collateralKills' or key=='autoMultiR' or key=='multiFlash'
                    or key=='comboConserveR' or key=='comboKickFollow' or key=='comboIsolate' then category='Finishes' end
            elseif group=='Insec' then
                if key:match('^insecFlash') then category='Flash'
                elseif key=='insecQ' or key=='insecW' or key=='insecBridges' or key=='insecChains' or key=='insecCloseWard' then category='Resources'
                elseif key=='aimLock' or key:match('^insecMouse') or key=='insecTrackAlly' or key=='insecPreferStructures' or key=='insecBasePlatform' then category='Targeting' end
            elseif group=='SmiteItems' then
                category=key:match('^potion') and 'Potions' or (key:match('^smite') or key=='autosmite') and 'Smite' or 'Items'
            end
            if category then
                local names={Abilities='Abilities',Chase='Chase / ward use',Finishes='Kick / finishing',Resources='Approach tools',Targeting='Target / kick direction'}
                if not parent[category] then parent:MenuElement({id=category,name=names[category] or category,type=MENU,leftIcon=iconFor(category)}) end
                parent=parent[category];path=path..'.'..category
            end
            if advanced then
                if not parent.Advanced then parent:MenuElement({id='Advanced',name='Advanced',type=MENU}) end
                parent=parent.Advanced;path=path..'.Advanced'
            end
            if migration then
                migration:Apply(args,'AyyyyIOLeeSin_'..profile.id,oldPath,path..'.'..args.id)
                if category then migration:Apply(args,'AyyyyIOLeeSin_'..profile.id,priorPath..(advanced and '.Advanced' or '')..'.'..args.id,path..'.'..args.id) end
                if args.id:match('^draw[QWER]Range') or args.id=='drawWardRange' then
                    migration:Apply(args,'AyyyyIOLeeSin_'..profile.id,'Drawings.Ranges.'..args.id,path..'.'..args.id)
                end
                if advanced then migration:Apply(args,'AyyyyIOLeeSin_'..profile.id,group..'.Advanced.'..args.id,path..'.'..args.id) end
                local previous=group=='Assists' and 'Combat.Advanced'
                    or (group=='Wave' or group=='LastHit' or group=='Jungle') and ('Farming'..(advanced and '.Advanced' or ''))
                if previous then migration:Apply(args,'AyyyyIOLeeSin_'..profile.id,previous..'.'..args.id,path..'.'..args.id) end
            end
            if drawingGroups[args.id] then
                local key=args.id;local legacy=args.value
                args.name='Enabled';args.drop=nil
                if key=='drawQRange' then args.value=legacy~=1 end
                if migration then migration:Apply(args,'AyyyyIOLeeSin_'..profile.id,path..'.'..key,path..'.'..key) end
                parent:MenuElement(args);local enabled=parent[args.id]
                local options={};self.drawingOptions[key]=options
                local function visibility(id,label,value)
                    local option={id=id,name=label,value=value}
                    if migration then migration:Apply(option,'AyyyyIOLeeSin_'..profile.id,path..'.'..id,path..'.'..id) end
                    parent:MenuElement(option);options[id]=parent[id]
                end
                visibility('Always','Always',key~='drawQRange' or legacy==3)
                for _,entry in ipairs(drawingModes) do visibility(entry[1],entry[2],key=='drawQRange' and legacy==2 and entry[1]=='Harass') end
                if key=='drawQRange' then
                    return {Value=function(_,value)
                        if value~=nil then
                            enabled:Value(value~=1);options.Always:Value(value==3)
                            for _,entry in ipairs(drawingModes) do options[entry[1]]:Value(value==2 and entry[1]=='Harass') end
                        end
                        return enabled:Value() and (options.Always:Value() and 3 or 2) or 1
                    end}
                end
                return enabled
            end
            parent:MenuElement(args);return parent[args.id]
        end
        for _,section in ipairs(sections) do
            for _,row in ipairs(section[2]) do
                local key=row[1];local group=destination(section[1],key)
                if not group and section[1]~='Validation' and migration then
                    local saved={id=key,value=self.values[key]}
                    migration:Apply(saved,'AyyyyIOLeeSin_'..profile.id,section[1]..'.'..key,section[1]..'.Advanced.'..key)
                    local previous=key:match('^insec') and 'Insec' or section[1]=='Ward' and 'Wardjump'
                        or section[1]=='Smite' and 'SmiteItems' or section[1]=='Farm' and 'Farming'
                    if previous then migration:Apply(saved,'AyyyyIOLeeSin_'..profile.id,previous..'.'..key,previous..'.Advanced.'..key) end
                    self.values[key]=saved.value
                end
                local relevant=not (key=='clearKrugE' and profile.id~='normal')
                if (section[1]=='Smite' or key=='smiteKey' or key=='secureKey') and not smiteEquipped then relevant=false end
                self.menuEntries[#self.menuEntries+1]={key=key,old=section[1],group=group,category=not group and 'development' or row[4] and 'tuning' or 'gameplay',relevant=relevant}
                if group and relevant then
                    local args={id=revisedDefaults[key] or key,name=row[2],value=self.values[key]}
                    if key=='hitchance' then args.id='qAccuracyR54';args.name='Q prediction confidence' end
                    if key=='smiteCamps' then args.id='smiteExecuteCamps' end
                    if key=='farmKiteDistance' then args.id='farmKiteTravelR19' end
                    if section[1]=='Keys' or key=='farmCameraHoldKey' then args.key=self.values[key];args.value=nil
                    elseif key=='hitchance' then args.drop={'Normal','High','Immobile only'}
                    elseif key=='drawQRange' then args.drop={'Off','During harass','Always'}
                    elseif row[4] then args.min=row[4];args.max=row[5];args.step=1 end
                    local advanced=group~='Controls' and row[4]~=nil
                    self.nodes[key]=add(group,args,section[1]..'.'..args.id,advanced,key)
                end
            end
        end
        self.nodes.aimLock=add('Insec',{id='aimLock',name='Lock kick direction',value=self.values.aimLock,drop={'On press','When approach commits','Keep tracking until kick'}},'Combat.aimLock')
        local drawArgs={id='draw',name='Enable drawings',value=self.values.draw,leftIcon=iconFor('draw')}
        if migration then migration:Apply(drawArgs,'AyyyyIOLeeSin_'..profile.id,'Automation.draw','Appearance.draw') end
        self.menu:MenuElement(drawArgs);self.nodes.draw=self.menu.draw
        local function guide(key,label,extra)
            local args={id=key,name=label,value=self.values[key]}
            for k,v in pairs(extra or {}) do args[k]=v end
            if args.key then args.value=nil end
            local oldDefault=key=='guidePreviousKey' and 33 or key=='guideNextKey' and 34
            if oldDefault then
                -- Move saved r79 defaults to adjacent F keys, preserving custom
                -- bindings and any deliberate choice saved under the new IDs.
                args.id=key..'R80'
                if migration then
                    local root='AyyyyIOLeeSin_'..profile.id
                    migration:Apply(args,root,'Guide.'..key,'Guide.'..args.id)
                    local saved=migration.saved and migration.saved[root]
                    local current=saved and saved.Guide and saved.Guide[args.id]
                    if args.key==oldDefault and not (current and type(current.__key)=='number') then args.key=self.values[key] end
                end
            end
            self.nodes[key]=add('Guide',args,'Guide.'..args.id,false,key)
        end
        guide('guideOpen','Show / hide guide')
        guide('guideKey','Open / close guide',{key=self.values.guideKey})
        guide('guidePage','Topic',{drop=require('leesin.guide').titles})
        guide('guidePreviousKey','Previous topic',{key=self.values.guidePreviousKey})
        guide('guideNextKey','Next topic',{key=self.values.guideNextKey})
        guide('guideScale','Text size (%)',{min=80,max=150,step=5})
        -- Aliases preserve existing plugin button insertion without duplicate menu nodes.
        self.menu.Farm=self.menu.Farming;self.menu.Ward=self.menu.Wardjump;self.menu.Keys=self.menu.Controls
        self.menu.Smite=self.menu.SmiteItems
        self.bindings=require('leesin.bindings').new(self,_G.SDK)
    end
    self:set('autoJungle',false) -- Loading/reloading never starts an autonomous route.
    self:set('guideOpen',false) -- Help is temporary, never reopened by a saved toggle.
    return self
end
return C

end
