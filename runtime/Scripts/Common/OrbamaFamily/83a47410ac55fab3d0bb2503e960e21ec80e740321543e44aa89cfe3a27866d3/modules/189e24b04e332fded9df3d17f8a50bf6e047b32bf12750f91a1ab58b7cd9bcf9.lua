return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Skarner"]=function()return _G.OrbamaFamily:Require("932d33705853fd29210dfa20fa1c3d77f92f26264c2469b6664261e35aef6aff")()end
return function(name)
local factory=factories[name]
if not factory then error('Unknown champion mechanics family: '..tostring(name),0)end
return factory()
end
end)()
modules.patchProfiles=(function(require) return _G.OrbamaFamily:Factory("62491cf7a49019ab29c06b1e84fdc2586bc36c2220474a5c7bbe88b423fbef87")(require) end)(require)
modules.vayneProfile=(function(require) return _G.OrbamaFamily:Factory("f552a9fd4817138b08e6b40f1e86bea8d5d7dd14d811e90f5876de37afea3c50")(require) end)(require)
modules.normalVayneProfile=(function(require) return _G.OrbamaFamily:Factory("373bad3c451afb65e89573693305b3843b66f332233976d45a0797d047e81a57")(require) end)(require)(modules.vayneProfile)
modules.blitzProfile=(function(require) return _G.OrbamaFamily:Factory("14f15afda2e9ed482ac9671e6e787ea539d8975d8c953933e9533bcbdb66f516")(require) end)(require)
modules.asheProfile=(function(require) return _G.OrbamaFamily:Factory("db3ff3e9fdd10c244773b1f29c70f5bec10d1890ad97ee56aab500e5e30a3770")(require) end)(require)
modules.ahriProfile=(function(require) return _G.OrbamaFamily:Factory("30d95faa88583d2a2228a8b1d1bdc9018a149270953bbe9793f10d780603ef09")(require) end)(require)
modules.kogmawProfile=(function(require) return _G.OrbamaFamily:Factory("309e64d13d66b4a917814dd40e811f4f7a34102f488bc17c6f0c58e6b83cb99a")(require) end)(require)
modules.ccAttacks=(function(require) return _G.OrbamaFamily:Factory("8910c29691574e4993f030cf5eb46f90374ff156e8845186f008907f8858108b")(require) end)(require)
modules.ccImmunity=(function(require) return _G.OrbamaFamily:Factory("9b57e44e8a476ae172372ff41d7e51c9693d85a2fe0cd18047c4febb66abafd8")(require) end)(require)
modules.observeAttack=(function(require) return _G.OrbamaFamily:Factory("0eb86cbf6312e1011d3b480290252f3b442a81d9d38e790d4fb95e6947c5bf14")(require) end)(require)
modules.recallCast=(function(require) return _G.OrbamaFamily:Factory("7dbacbbf6e267f3a5936a395354a7637172ae253a18a1dae30d7bbe860f10aa1")(require) end)(require)
modules.skillOrders=(function(require) return _G.OrbamaFamily:Factory("c960de90c594e7c207e7efeaca5198f2250fe65b01459ca5f3ac5dfb7747935f")(require) end)(require)
modules.healthWindow=(function(require) return _G.OrbamaFamily:Factory("d533b0ef74c68b495c1d2541cc3e687ebd5a9d43ecc9bd9706750c9b1a16fec9")(require) end)(require)
modules.yunaraProfile=(function(require) return _G.OrbamaFamily:Factory("d0f8a7ede995c1c4ae39ff50186c21819723104154d9a4a209da8a785993462e")(require) end)(require)
modules.nautilusProfile=(function(require) return _G.OrbamaFamily:Factory("f730083274ce090a6b9cdaf348846a2fa53f89ad6c57c53a6c09767f82770c84")(require) end)(require)
modules["autojungle"]=_G.OrbamaFamily:Require("8ef13010a581d447046b67d863880d3e389ac7fec6a8557c660db9c87981114d")
modules["combatMechanics"]=_G.OrbamaFamily:Require("9b0f0ca4dc10e89ac5153be241244434028523e5505df6b650ac40f1e6f736d3")
modules["gameplay"]=_G.OrbamaFamily:Require("2e02eb4c9186ef962f8b5745627b3e1021e5d1f383b1a9ee1b51337498643e80")
modules["strike"]=_G.OrbamaFamily:Require("38babe42b81881ea627d41ae65e32a203fdca56374f733a79b4c7f0c9465a693")
modules["prediction"]=(function(require) return _G.OrbamaFamily:Factory("223a065ecf7929552d5f8dafcf2453fd9147cd6e9940ce97dc80add73aa9913b")(require) end)(require)
modules["policies"]=(function(require) return _G.OrbamaFamily:Factory("e26056d70e5dac93ebb21f4ae4fe96863a06915a942bb75b795567a932448a23")(require) end)(require)
modules["core"]=(function(require) return _G.OrbamaFamily:Factory("9baafe297f9228d60e519127c820be79602687ef0fc3afd68e9c25369b71a1c5")(require) end)(require)
modules.runtime=function(env,champion)
local _G,Core,SDK,Draw,Control,Callback,DelayAction,MenuElement,OrbamaPrediction,require,os,class=env,env.Core,env.SDK,env.Draw,env.Control,env.Callback,env.DelayAction,env.MenuElement,env.OrbamaPrediction,env.require,env.os,env.class
local Menu,lastQ,lastW,lastE,lastR,CoreRefreshClaims
local AbilityProfiles=modules.abilityProfiles
local ChampionProfiles=modules.championProfiles
local YunaraProfiles=modules.yunaraProfile.profiles
local NautilusProfiles=modules.nautilusProfile.profiles
local PatchProfiles=modules.patchProfiles
local VayneProfile=modules.vayneProfile
local NormalVayneProfile=modules.normalVayneProfile
local BlitzProfile=modules.blitzProfile
local AsheProfile=modules.asheProfile
local AhriProfile=modules.ahriProfile
local KogMawProfile=modules.kogmawProfile
local ObserveAttack=modules.observeAttack
local CheckChatBlock,IsReady,IsValid,StableUnitMenuKey,GetDistanceSqr,GetDistance,GetEnemyHeroes,IsUnderTurret,IsUnderTurret2,GetBuffs,HaveBuff,HasBuffContainsName,HaveBuffContainsNameNums,GetBuffData,GetEnemyCount,GetMinionCount,GetAllyCount,IsHardCC,GetHardCCDuration,IsInvulnerable,IsSlow,IsPoison,Recalling,HasInvalidDashBuff,GetMode,GetTarget,IsFacingMe,CircleCircleIntersection,FindFirstWallCollision,FindFirstWallCollisionInRectangle,IsCasting,HasItem,ShouldWait,SpellFarmDefault,CastSpellAOE
do
local Version = 2.04

lastQ, lastW, lastE, lastR = 0, 0, 0, 0

local blockFlag = false -- Prevent recursive callback
function CheckChatBlock(menuElement, newValue) -- Block menu toggle when chat is open
    if Game.IsChatOpen() and not blockFlag then
        blockFlag = true
        if menuElement then
            menuElement:Value(not newValue)
        end
        blockFlag = false
        return true
    end
    return false
end

function IsReady(spell)
	local spellData = myHero:GetSpellData(spell)
	return spellData.currentCd == 0 and spellData.level > 0 and spellData.mana <= myHero.mana and Game.CanUseSpell(spell) == 0
end

function IsValid(unit)
	return unit and unit.valid and unit.isTargetable and unit.alive and unit.visible and unit.networkID and unit.health > 0 and not unit.dead
end

-- Saved menu values are keyed by id path. networkID/handle change every game,
-- so per-unit options use the champion name (deduplicated per owner and group).
function StableUnitMenuKey(owner, prefix, unit)
	local identity = unit and (unit.networkID or unit.handle)
	local registry = owner.stableMenuKeys
	if not registry then registry = {}; owner.stableMenuKeys = registry end
	local group = registry[prefix]
	if not group then group = {byKey = {}, byUnit = {}}; registry[prefix] = group end
	if identity ~= nil and group.byUnit[identity] then return group.byUnit[identity] end
	local name = unit and type(unit.charName) == 'string' and (unit.charName:gsub('[^%w_]', '')) or ''
	if name == '' then name = tostring(identity) end
	local key, n = prefix .. name, 1
	while group.byKey[key] ~= nil do n = n + 1; key = prefix .. name .. '_' .. n end
	group.byKey[key] = identity == nil and true or identity
	if identity ~= nil then group.byUnit[identity] = key end
	return key
end

function GetDistanceSqr(Pos1, Pos2)
	local Pos2 = Pos2 or myHero.pos
	local dx = Pos1.x - Pos2.x
	local dz = (Pos1.z or Pos1.y) - (Pos2.z or Pos2.y)
	return dx^2 + dz^2
end

function GetDistance(Pos1, Pos2)
	return math.sqrt(GetDistanceSqr(Pos1, Pos2))
end

function GetEnemyHeroes()
	local EnemyHeroes = {}
	for i = 1, Game.HeroCount() do
		local Hero = Game.Hero(i)
		if Hero.isEnemy and not Hero.dead then
			table.insert(EnemyHeroes, Hero)
		end
	end
	return EnemyHeroes
end

function IsUnderTurret(unit)
	for _, turret in ipairs(_G.SDK.ObjectManager:GetEnemyTurrets()) do
		local range = (turret.boundingRadius + 750 + unit.boundingRadius / 2)
		if not turret.dead then
			if turret.pos:DistanceTo(unit.pos) < range then
				return true
			end
		end
	end
	return false
end

function IsUnderTurret2(pos)
	for _, turret in ipairs(_G.SDK.ObjectManager:GetEnemyTurrets()) do
		local range = (turret.boundingRadius + 750)
		if not turret.dead then
			if turret.pos:DistanceTo(pos) < range then
				return true
			end
		end
	end
	return false
end

local HardCCTypes = {[5] = true, [8] = true, [9] = true, [12] = true, [23] = true, [25] = true, [29] = true, [30] = true, [35] = true}

function GetBuffs(unit)
    if not Core.validating then return _G.SDK.BuffManager:GetBuffs(unit)end
    -- Send/channel validation needs current host state, even before SDK's next Prepare.
    local out={};local count=unit and unit.buffCount
    if type(count)~='number' or count~=count or count<0 or count>128 or count%1~=0 then return out end
    for i=0,count do
        local b=unit:GetBuff(i)
        if b and b.count and b.count>0 then
            local source=b.source
            if type(source)=='table' or type(source)=='userdata' then
                source={networkID=source.networkID,handle=source.handle}
            end
            out[#out+1]={name=b.name,type=b.type,count=b.count,stacks=b.stacks,duration=b.duration,
                expireTime=b.expireTime,endTime=b.endTime,startTime=b.startTime,source=source,
                sourcenID=b.sourcenID,sourceName=b.sourceName,sourceID=b.sourceID,
                owner=b.owner,ownerID=b.ownerID}
        end
    end
    return out
end

function HaveBuff(unit, buffName)
	buffName = buffName:lower()
	local buffs = GetBuffs(unit)
	for i = 1, #buffs do
		local buff = buffs[i]
		if buff.name and buff.name:lower() == buffName then
			return true
		end
	end
	return false
end

function HasBuffContainsName(unit, name)
	name = name:lower()
	local buffs = GetBuffs(unit)
	for i = 1, #buffs do
		local buff = buffs[i]
		if buff.name and buff.name:lower():find(name, 1, true) then
			return true
		end
	end
	return false
end

function HaveBuffContainsNameNums(unit, name)
	name = name:lower()
	local count = 0
	local buffs = GetBuffs(unit)
	for i = 1, #buffs do
		local buff = buffs[i]
		if buff.name and buff.name:lower():find(name, 1, true) then
			count = count + buff.count
		end
	end
	return count
end

function GetBuffData(unit, buffName)
	buffName = buffName:lower()
	local buffs = GetBuffs(unit)
	for i = 1, #buffs do
		local buff = buffs[i]
		if buff.name and buff.name:lower() == buffName then
			return true, buff
		end
	end
	return false, {type = 0, name = "", startTime = 0, expireTime = 0, duration = 0, stacks = 0, count = 0}
end

function GetEnemyCount(range, unit)
	local count = 0
	local Range = range * range
	for _, hero in ipairs(Core:DecisionUnits('GetEnemyHeroes')) do
		if IsValid(hero) and GetDistanceSqr(unit, hero.pos) < Range then
			count = count + 1
		end
	end
	return count
end

function GetMinionCount(range, unit)
	local count = 0
	local Range = range * range
	for _, minion in ipairs(Core:DecisionUnits('GetEnemyMinions')) do
		if IsValid(minion) and GetDistanceSqr(unit, minion.pos) < Range then
			count = count + 1
		end
	end
	return count
end

function GetAllyCount(range, unit)
	local count = 0
	local Range = range * range
	for _, hero in ipairs(Core:DecisionUnits('GetAllyHeroes')) do
		if IsValid(hero) and GetDistanceSqr(unit, hero.pos) < Range then
			count = count + 1
		end
	end
	return count
end

function IsHardCC(unit)
	local buffs = GetBuffs(unit)
	local now = Game.Timer()
	for i = 1, #buffs do
		local buff = buffs[i]
		if HardCCTypes[buff.type] then
			local expiry = type(buff.expireTime)=='number' and buff.expireTime>0 and buff.expireTime or buff.endTime
			if type(buff.count)=='number' and buff.count>0 and type(expiry)=='number' and expiry>now then return true end
		end
	end
	return false
end

function GetHardCCDuration(unit)
	local MaxDuration = 0
	local buffs = GetBuffs(unit)
	local now = Game.Timer()
	for i = 1, #buffs do
		local buff = buffs[i]
		if HardCCTypes[buff.type] then
			local expiry = type(buff.expireTime)=='number' and buff.expireTime>0 and buff.expireTime or buff.endTime
			local BuffDuration = type(expiry)=='number' and expiry-now or 0
			if type(buff.count)=='number' and buff.count>0 and BuffDuration > MaxDuration then
				MaxDuration = BuffDuration
			end
		end
	end
	return MaxDuration
end

function IsInvulnerable(unit)
	local buffs = GetBuffs(unit)
	for i = 1, #buffs do
		local buff = buffs[i]
		if buff.type == 18 then
			return true
		end
	end
	return false
end

function IsSlow(unit)
	local buffs = GetBuffs(unit)
	for i = 1, #buffs do
		local buff = buffs[i]
		if buff.type == 11 then
			return true
		end
	end
	return false
end

function IsPoison(unit)
	local buffs = GetBuffs(unit)
	for i = 1, #buffs do
		local buff = buffs[i]
		if buff.type == 13 or buff.type == 24 then
			return true
		end
	end
	return false
end

function Recalling(unit)
	local as = unit.activeSpell
	if as and as.valid and type(as.name)=='string' and as.name:lower():find("recall") then
		return true
	end
	local buffs = GetBuffs(unit)
	for i = 1, #buffs do
		local buff = buffs[i]
		if type(buff.name)=='string' and buff.name:lower():find("recall") then
			return true
		end
	end
	return false
end

function HasInvalidDashBuff(unit)
	local buffs = GetBuffs(unit)
	for i = 1, #buffs do
		local buff = buffs[i]
		if buff.type == 30 or buff.type == 31 or buff.name == "ThreshQ" then
			return true
		end
	end
	return false
end

function GetMode()
	return _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO] and "Combo"
		or _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS] and "Harass"
		or _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR] and "LaneClear"
		or _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR] and "LaneClear"
		or _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LASTHIT] and "LastHit"
		or _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_FLEE] and "Flee"
		or nil
end

function GetTarget(range)
	local dmgType = myHero.ap > myHero.totalDamage and _G.SDK.DAMAGE_TYPE_MAGICAL or _G.SDK.DAMAGE_TYPE_PHYSICAL
	return _G.SDK.TargetSelector:GetTarget(range, dmgType)
end

function IsFacingMe(unit)
	local V = Vector((unit.pos - myHero.pos))
	local D = Vector(unit.dir)
	local Angle = 180 - math.deg(math.acos(V*D/(V:Len()*D:Len())))
	if math.abs(Angle) < 90 then
		return true
	end
	return false
end

function CircleCircleIntersection(c1, c2, r1, r2)
	local D = GetDistance(c1,c2)
	if D > r1 + r2 or D <= math.abs(r1 - r2) then return nil end
	local A = (r1 * r1 - r2 * r2 + D * D) / (2 * D)
	local H = math.sqrt(r1 * r1 - A * A)
	local Direction = (c2 - c1):Normalized()
	local PA = c1 + A * Direction
	local S1 = PA + H * Direction:Perpendicular()
	local S2 = PA - H * Direction:Perpendicular()
	return S1, S2
end

function FindFirstWallCollision(startPos, endPos)
	local direction = (endPos - startPos):Normalized()
	local distance = startPos:DistanceTo(endPos)
	local step = 10
	for i = 0, distance, step do
		local checkPos = startPos + direction * i
		if Game.isWall(checkPos) then
			return checkPos
		end
	end
	return nil
end

function FindFirstWallCollisionInRectangle(startPos, endPos, width)
	local direction = (endPos - startPos):Normalized()
	local distance = startPos:DistanceTo(endPos)
	local perpDirection = direction:Perpendicular()
	for i = 0, distance, 10 do
		local centerPos = startPos + direction * i
		for j = -width/2, width/2, 10 do
			local checkPos = centerPos + perpDirection * j
			if Game.isWall(checkPos) then
				return checkPos
			end
		end
	end
	return nil
end

local function finiteCastNumber(n)return type(n)=='number'and n==n and n>-math.huge and n<math.huge end
function IsCasting()
	local cast=myHero.activeSpell
	if not cast or type(cast.valid)~='boolean'then return true,'cast_state_unknown'end
	if cast.valid then
		if cast.isCharging then return true end
		local start,finish=cast.startTime,cast.castEndTime
		if not finiteCastNumber(start)or not finiteCastNumber(finish)then return true,'cast_timing_unknown'end
		local now=Game.Timer()
		if not finiteCastNumber(now)then return true,'cast_clock_unknown'end
		if (now >= start and now <= finish)
		then
			return true
		end
	end
	return false
end

local slots = {ITEM_1, ITEM_2, ITEM_3, ITEM_4, ITEM_5, ITEM_6}
function HasItem(unit, itemId)
	for i = 1, #slots do
		local slot = slots[i]
		local item = unit:GetItemData(slot)
		if item and item.itemID == itemId then
			return true
		end
	end
	return false
end

function ShouldWait()
	return myHero.dead or Game.IsChatOpen() or
			(_G.JustEvade and _G.JustEvade:Evading()) or
			Recalling(myHero) or
			Control.IsKeyDown(0x11) or
			Control.IsKeyDown(0x12)
end

-- Default of the spell-farming toggle (a saved choice always wins): on for a
-- jungler (Smite equipped: the jungle is cleared with abilities) and for
-- champions whose farming is their kit (Nasus Q stacks); off otherwise.
local spellFarmChampions={Nasus=true}
function SpellFarmDefault()
	local name=myHero.charName and myHero.charName:gsub('^Jade_','')
	if spellFarmChampions[name]then return true end
	for _,slot in ipairs({SUMMONER_1,SUMMONER_2})do
		local data=slot and myHero:GetSpellData(slot)
		if data and type(data.name)=='string'and data.name:find('Smite',1,true)then return true end
	end
	return false
end

function CastSpellAOE(spellSlot, spellData, minHitCount, source, mainTarget)
	local SpellPred = Core:Prediction(spellData)
	local aoeResults = SpellPred:GetAOEPrediction(source)
	if #aoeResults == 0 then
		return false
	end
	if mainTarget then
		for i, result in ipairs(aoeResults) do
			if result.Unit.networkID == mainTarget.networkID and result.Count >= minHitCount then
				if Control.CastSpell(spellSlot, result.CastPosition) then
					return true
				end
			end
		end
	end
	table.sort(aoeResults, function(a, b) return a.Count > b.Count end)
	for i, result in ipairs(aoeResults) do
		if result.Count >= minHitCount then
			if Control.CastSpell(spellSlot, result.CastPosition) then
				return true
			end
		end
	end
	return false
end

end
env.CheckChatBlock=CheckChatBlock
env.IsReady=IsReady
env.IsValid=IsValid
env.StableUnitMenuKey=StableUnitMenuKey
env.GetDistanceSqr=GetDistanceSqr
env.GetDistance=GetDistance
env.GetEnemyHeroes=GetEnemyHeroes
env.IsUnderTurret=IsUnderTurret
env.IsUnderTurret2=IsUnderTurret2
env.GetBuffs=GetBuffs
env.HaveBuff=HaveBuff
env.HasBuffContainsName=HasBuffContainsName
env.HaveBuffContainsNameNums=HaveBuffContainsNameNums
env.GetBuffData=GetBuffData
env.GetEnemyCount=GetEnemyCount
env.GetMinionCount=GetMinionCount
env.GetAllyCount=GetAllyCount
env.IsHardCC=IsHardCC
env.GetHardCCDuration=GetHardCCDuration
env.IsInvulnerable=IsInvulnerable
env.IsSlow=IsSlow
env.IsPoison=IsPoison
env.Recalling=Recalling
env.HasInvalidDashBuff=HasInvalidDashBuff
env.GetMode=GetMode
env.GetTarget=GetTarget
env.IsFacingMe=IsFacingMe
env.CircleCircleIntersection=CircleCircleIntersection
env.FindFirstWallCollision=FindFirstWallCollision
env.FindFirstWallCollisionInRectangle=FindFirstWallCollisionInRectangle
env.IsCasting=IsCasting
env.HasItem=HasItem
env.ShouldWait=ShouldWait
env.SpellFarmDefault=SpellFarmDefault
env.CastSpellAOE=CastSpellAOE
local CombatMechanics=modules.combatMechanics
Core.strike=modules.strike(env,Core)
Core.gameplay=modules.gameplay(env,Core,CombatMechanics)
if champion=="Skarner" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Skarner',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.02
-- The shared row plus this champion's own profile numbers (ChampionProfiles/Skarner.lua), on a private copy.
local skarnerProfile={}
do local shared=assert(AbilityProfiles.controllers.Skarner[myHero.charName],'Unsupported Skarner profile')
 local own=ChampionProfiles('Skarner')[myHero.charName]or {}
 for k,v in pairs(shared)do skarnerProfile[k]=v end;for k,v in pairs(own)do skarnerProfile[k]=v end
end
local finite,identity=Core.finite,Core.id


local SkarnerChampion=class("SkarnerChampion")

function SkarnerChampion:__init()
	self.profile=skarnerProfile
	print("AyyyyIO - Skarner loaded")
	self:LoadMenu()
	Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
	Menu.LastHit:MenuElement({id='Q',name='Use Q',value=true})
	if self.profile.id=='classic'then Menu.LastHit:MenuElement({id='E',name='Use E',value=true})end
	Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=1})
	for _,name in ipairs({'Combo','Harass','Clear','KillSteal'})do Menu[name]:MenuElement({id='Mana',name='Only above mana %',value=name=='Harass'and 30 or name=='Clear'and 20 or 0,min=0,max=100,step=1,menu=(name~='KillSteal')})end
	Callback.Add("Draw", function() self:Draw() end)
	Callback.Add("Tick", function() self:Tick() end)
	self.QSpell = {Range = 350}
	self.WSpell = {Range = 900}
	-- Fracture geometry is the shared Classic row (abilities.lua: line 800, radius 70 from the asset's lineWidth, speed 1800).
	self.ESpell = assert(AbilityProfiles.Spell(myHero.charName,'E',OrbamaPrediction),'Skarner E geometry missing')
	self.ESpell.Collision = true; self.ESpell.CollisionTypes = {OrbamaPrediction.COLLISION_YASUOWALL}
	self.RSpell = {Range = 350} -- Conservative nested cast-range field; legacy top-level is 500.
	if self.profile.id=='normal' then
	 self.QSpell=AbilityProfiles.Spell(myHero.charName,'Q',OrbamaPrediction)
	 self.QSpell.Collision=true;self.QSpell.CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}
	 self.WSpell=AbilityProfiles.Spell(myHero.charName,'W',OrbamaPrediction)
	 self.ESpell=AbilityProfiles.Spell(myHero.charName,'E',OrbamaPrediction)
	 self.RSpell=AbilityProfiles.Spell(myHero.charName,'R',OrbamaPrediction)
	 Menu.Combo:MenuElement({id='PickupThrow',name='Pick up a rock early to throw Q at range',value=true,menu=false})
	 Menu.Harass:MenuElement({id='PickupThrow',name='Pick up a rock early to throw Q at range',value=true,menu=false})
	 Menu.KillSteal:MenuElement({id='W',name='Use W',value=true})
	 Menu.Harass:MenuElement({id='W',name='Use W',value=false})
	 Menu.Combo:MenuElement({id='R',name='Use R when it catches enough champions',value=true})
	 Menu.Combo:MenuElement({id='RCount',name='Champions R must catch',value=2,min=1,max=self.profile.rMaxTargets,step=1})
	 Menu.Combo:MenuElement({id='FlashR',name='Flash during R to catch a target just out of reach',value=false})
	 -- A constant minimum width is wholly inside the actual tapering hitbox; the count uses the taper itself.
	 self.RAreaSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Range=self.RSpell.Range,Radius=self.RSpell.Radius,Delay=self.RSpell.Delay,Speed=math.huge,Collision=false}
	else
	 Menu.Combo:MenuElement({id='R',name='Use R on a low target or one near an ally',value=true})
	 Menu.Combo:MenuElement({id='FlashR',name='Flash then R a target just out of reach',value=false})
	end
	Menu:MenuElement({type=MENU,id='Flee',name='Flee'})
	if self.profile.id=='normal'then Menu.Flee:MenuElement({id='E',name='Charge toward the cursor with E',value=false})
	else Menu.Flee:MenuElement({id='W',name='Use W for its speed boost',value=true})end
	Menu.Misc:MenuElement({id='InterruptR',name='Use R to stop enemy channels',value=true})
	Menu.Misc:MenuElement({id='ShieldW',name='Shield with W before a champion or turret hits',value=true})
	self:RegisterEvadeShield()
	self.flashCombo=Core:FlashFollow('SkarnerFlashR')
	Core:RegisterCleanup('Skarner',function(reason)if self.flashCombo then self.flashCombo:Cancel(reason or 'controller_closed')end;self.eProbe=nil end)
	Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
end

-- Health-bar damage and KILL mark (S9): ready abilities in reach plus one attack, against current health.
function SkarnerChampion:ComboDamage(u)
 if not IsValid(u)then return 0 end
 local d=GetDistance(u.pos,myHero.pos);local ok,total=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
 total=ok and finite(total)and total or 0
 if self.profile.id=='normal'then return total+self:NormalBurst(u,d)end
 if IsReady(_Q)and d<=self.QSpell.Range then total=total+self:GetQDmg(u)end
 if IsReady(_E)and d<=self.ESpell.Range then total=total+self:GetEDmg(u)end
 if IsReady(_R)and d<=self.RSpell.Range then total=total+self:GetRDmg(u)end
 return total
end

-- First Impale hit (the second, when the drag ends, depends on the player and is not counted).
function SkarnerChampion:GetRDmg(target)
 local p=self.profile;local rank=myHero:GetSpellData(_R).level;local base=p.rBase and p.rBase[rank]
 if not base then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+(p.rAP or 0)*(myHero.ap or 0))
end

-- R on a dangerous channel (Core:CanInterrupt: host flag or the shared channel catalogue) in reach. Normal
-- aims the area at the caster (cast 0.75 s); Classic suppresses it (cast 0.25 s, asset castFrame 7.5).
function SkarnerChampion:InterruptR()
 if not Menu.Misc.InterruptR:Value()or not IsReady(_R)then return false end
 local normal=self.profile.id=='normal';local impact=normal and self.profile.rInterruptDelay or self.profile.rCast
 if not finite(impact)then return false end
 local units=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#units,5)do local u=units[i]
  if IsValid(u)and u.pos2D.onScreen and GetDistance(u.pos,myHero.pos)<=self.RSpell.Range and Core:SpellProtected(u)==false and Core:CanInterrupt(u,impact)then
   local function valid()return Menu.Misc.InterruptR:Value()and IsValid(u)and GetDistance(u.pos,myHero.pos)<=self.RSpell.Range and Core:CanInterrupt(u,impact)end
   if normal then
    if Core:Cast(HK_R,Vector(u.pos.x,u.pos.y,u.pos.z),{intentTarget=u,range=self.RSpell.Range,validate=function(q,resolved)
     local aim=resolved and resolved.position or q.target
     return valid()and self:NormalAimCatches(aim,u)end})then return true end
   elseif Core:Cast(HK_R,u,{range=self.RSpell.Range,validate=valid})then return true end
  end
 end
 return false
end

-- Flee: Classic W for its movement speed (and shield); Normal E charges toward the cursor when enabled.
function SkarnerChampion:Flee()
 if self.profile.id=='normal'then return self:NormalFlee()end
 if not Menu.Flee.W:Value()or not IsReady(_W)then return false end
 return Core:Cast(HK_W,nil,{validate=function()return Menu.Flee.W:Value()end})
end

-- Classic Flash then R (Core:FlashFollow): a target just beyond the 350 reach, within Flash range of it. The
-- Combo R rule (low target or an ally near, not from under a turret) holds at the landing; off by default.
function SkarnerChampion:FlashR()
 if self.profile.id=='normal'then return self:NormalFlashR()end
 local combo=self.flashCombo
 if not combo or combo:Busy()or not Menu.Combo.FlashR:Value()or not Menu.Combo.R:Value()or not IsReady(_R)then return false end
 local status=Core:FlashStatus();if not status then return false end
 local rCost=myHero:GetSpellData(_R).mana;if not finite(rCost)or myHero.mana<status.cost+rCost then return false end
 local reach=self.RSpell.Range;local target=self:GetFlashTarget(reach+status.range-50)
 if not target or not self:ComboRAllowed(target,math.huge)then return false end
 local d=GetDistance(target.pos,myHero.pos);if d<=reach then return false end
 local aim=myHero.pos:Extended(target.pos,math.min(status.range,d-reach+100));local id,handle=identity(target),target.handle
 local function authorized()return Menu.Combo.FlashR:Value()and Menu.Combo.R:Value()and GetMode()=='Combo'end
 local function valid(pos)return IsReady(_R)and IsValid(target)and identity(target)==id and target.handle==handle
  and GetDistance(target.pos,pos)<=reach-25 and not IsUnderTurret2(pos)and self:ComboRAllowed(target,math.huge)end
 return combo:Start{order='flash_first',aim=aim,authorized=authorized,valid=valid,mana=rCost,
  follow=function(context)return Core:Cast(HK_R,target,{owner='FlashR',context=context,range=reach,validate=function()
   return authorized()and IsValid(target)and identity(target)==id and GetDistance(target.pos,myHero.pos)<=reach end})end}
end
function SkarnerChampion:GetFlashTarget(range)
 local selected=_G.SDK.TargetSelector.Selected
 if IsValid(selected)and selected.pos2D.onScreen and GetDistance(selected.pos,myHero.pos)<=range then return selected end
 local u=GetTarget(range);return IsValid(u)and u.pos2D.onScreen and u or nil
end

-- Shield capacity from the profile's own figures: Normal a share of maximum health, Classic a rank value plus AP.
function SkarnerChampion:ShieldAmount()
 local p=self.profile
 if p.wShieldHP then return finite(myHero.maxHealth)and p.wShieldHP*myHero.maxHealth or 0 end
 local base=p.wShield and p.wShield[myHero:GetSpellData(_W).level]
 return base and base+(p.wShieldAP or 0)*(myHero.ap or 0)or 0
end

-- Evade may use W as a timed shield. The offer exists only while the shared profile row carries every figure
-- with its source (amount, duration, cast timing); a missing one means no offer, never a borrowed value.
function SkarnerChampion:RegisterEvadeShield()
 local p=self.profile
 if type(p.wShieldSource)~='string'or p.wShieldSource==''or not finite(p.wDuration)or not(finite(p.wDelay)or finite(p.wStart))
  or not(finite(p.wShieldHP)or type(p.wShield)=='table')then
  self.shieldReason='shield amount, duration, cast timing or source missing from the profile';return false
 end
 self.shieldRegistered,self.shieldReason,self.shieldDefense=Core:RegisterShield({name='SkarnerW',slot=_W,key=HK_W,profile=p.id,
  source=p.wShieldSource,duration=p.wDuration,delay=p.wDelay,start=p.wDelay==nil and p.wStart or nil,
  amount=function()return self:ShieldAmount()end,
  ready=function()return p.id=='classic'or not self:IsImpaling()and not self:NormalCharging()and not self:BuffActive('SkarnerWShield')end})
 return self.shieldRegistered
end

-- W as a shield against evidence only: a champion's attack or targeted cast on the way, or a turret shot.
-- Tracked skillshots are Evade's decision through the offer above.
function SkarnerChampion:ThreatW()
 if not Menu.Misc.ShieldW:Value()or not IsReady(_W)or self.profile.id=='normal'and self:BuffActive('SkarnerWShield')then return false end
 local threat=Core:AllyThreat(myHero,.75,{skillshots=false});if not threat then return false end
 return Core:Cast(HK_W,nil,{validate=function()return Menu.Misc.ShieldW:Value()and threat.valid()end})
end

-- Classic Impale suppresses one enemy whom the player then drags. Combo spends it only where that pays: the
-- target is low, or an ally is close enough to follow up. Never from inside enemy turret range.
function SkarnerChampion:ComboRAllowed(target,range)
 if not Menu.Combo.R:Value()or not self:TargetAllowed(target,range or self.RSpell.Range)or IsUnderTurret(myHero)
  or IsInvulnerable(target)or Core:SpellProtected(target)~=false then return false end
 if target.health<=target.maxHealth*.4 then return true end
 local allies=Core:Rows('hero',800,true)
 for i=1,math.min(#allies,5)do if allies[i]~=myHero and not allies[i].isMe then return true end end
 return false
end

function SkarnerChampion:LoadMenu()
	local championIcon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/".."Skarner.png"
	Menu = MenuElement({type = MENU, id = "Classic_AIO_"..myHero.charName, name='AyyyyIO - Skarner', leftIcon = championIcon})

	local classic=self.profile.id=='classic'
	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.Combo:MenuElement({id = "W", name = "Use W", value = true})
	-- Normal: the charge is gated on a wall to pin the target against or a kill (NormalChargeWorth), so it stays on.
	Menu.Combo:MenuElement({id = "E", name = classic and "Use E" or "Use E to pin the target to a wall or finish it", value = true})

	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.Harass:MenuElement({id = "E", name = classic and "Use E" or "Use E to pin the target to a wall or finish it", value = classic})

	Menu:MenuElement({type = MENU, id = "Clear", name = "Farming"})
	Menu.Clear:MenuElement({id = "SpellFarm", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(newValue)
		if CheckChatBlock(Menu.Clear.SpellFarm, newValue) then return end
	end})
	Menu.Clear:MenuElement({id = "SpellHarass", name = "Harass champions while lane clearing", value = true})
	Menu.Clear:MenuElement({type = MENU, id = "LaneClear", name = "Lane clear"})
	Menu.Clear.LaneClear:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.Clear.LaneClear:MenuElement({id = "QCount", menu = false, name = "Lane minions near you for Q", value = 2, min = 1, max = 6, step = 1})
	Menu.Clear.LaneClear:MenuElement({id = "W", name = "Use W", value = true})
	Menu.Clear.LaneClear:MenuElement({id = "WCount", menu = false, name = "Lane minions near you for W", value = 2, min = 1, max = 6, step = 1})
	if classic then
	 Menu.Clear.LaneClear:MenuElement({id = "E", name = "Use E", value = true})
	 Menu.Clear.LaneClear:MenuElement({id = "ECount", menu = false, name = "Lane minions E must hit", value = 2, min = 1, max = 6, step = 1})
	end
	Menu.Clear:MenuElement({type = MENU, id = "JungleClear", name = "Jungle clear"})
	Menu.Clear.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.Clear.JungleClear:MenuElement({id = "W", name = "Use W", value = true})
	if classic then Menu.Clear.JungleClear:MenuElement({id = "E", name = "Use E", value = true})end

	Menu:MenuElement({type = MENU, id = "KillSteal", name = "Finish kills without holding a mode key"})
	Menu.KillSteal:MenuElement({id = "Q", name = "Use Q", value = true})
	if classic then Menu.KillSteal:MenuElement({id = "E", name = "Use E", value = true})end

	Menu:MenuElement({type = MENU, id = "Misc", name = "Behaviour"})
	Menu.Misc:MenuElement({id = "SemiR", name = "Cast R at the selected target", key = string.byte("T")})

	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "Q", name = "Q range", value = false})
	Menu.Draw:MenuElement({id = "W", name = "W range", value = false})
	Menu.Draw:MenuElement({id = "E", name = "E range", value = false})
	Menu.Draw:MenuElement({id = "R", name = "R range", value = false})
end

function SkarnerChampion:IsImpaling()
 if self.profile.id=='normal'then return not myHero.dead and self:BuffActive('SkarnerRImpale')end
 return not myHero.dead and self:BuffActive('Jade_SkarnerR_Buff')
end

function SkarnerChampion:Tick()
 if self.profile.id=='normal'then return self:NormalTick()end
 if ShouldWait()then _G.SDK.Orbwalker:SetAttack(true);return end
 if self.eProbe then self:TraceE()end
 local impaling=self:IsImpaling()
 _G.SDK.Orbwalker:SetAttack(not(impaling or self:RWindup()))
 if self.flashCombo:Busy()and self.flashCombo:Maintain()then return end
 if impaling then self:ImpaleActions();return end
 if IsCasting()then return end
 self:SemiR();if self:InterruptR()then return end;self:KillSteal();self:ThreatW()
 local mode=GetMode()
 if mode=='Combo'then if not self:FlashR()then self:Combo()end
 elseif mode=='Flee'then self:Flee()
 elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then
  if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR]then self:FarmHarass();self:LaneClear()end
  if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR]then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()end
end

-- Modern kit on the shared controller. Spell stages and buffs authorize recasts;
-- requested casts and PreAttack callbacks never manufacture a held rock.
function SkarnerChampion:NormalCharging()
 local a=myHero.activeSpell
 return self:BuffActive('SkarnerEGrabbed')or self:BuffActive('SkarnerE')or
  a and a.valid and not a.isStopped and a.name=='SkarnerE'and a.endTime and a.endTime>Game.Timer()
end
function SkarnerChampion:NormalRock()
 local d=myHero:GetSpellData(_Q)
 return d and d.name=='SkarnerQRockThrow'
end
-- Shattered Earth window: seconds left (nil without a held boulder). Our own observation of the stage change
-- starts the profile's qHold window; a live owned buff (profile qBuff) shortens it when it ends earlier.
function SkarnerChampion:NormalRockWindow()
 if not self:NormalRock()then self.rockSince=nil;return nil end
 local now=Game.Timer();local p=self.profile
 if not self.rockSince then
  self.rockSince=now
  if Core.logger then -- development evidence for the unconfirmed buff name
   local names={};for i=0,math.min(myHero.buffCount or 0,64)do local b=myHero:GetBuff(i)
    if b and type(b.name)=='string'and b.name:lower():find('skarner',1,true)then names[#names+1]=b.name end end
   Core:Trace('skarner_q_window',{names=names,hold=p.qHold})
  end
 end
 local ends=self.rockSince+(finite(p.qHold)and p.qHold or 5)
 if p.qBuff then local active,buffEnds=self:BuffActive(p.qBuff);if active and buffEnds<ends then ends=buffEnds end end
 return ends-now
end
-- A held boulder is thrown only when the throw is worth more than the empowered attacks it ends: the target is
-- beyond attack reach (+25 empowered range), the window is about to lapse, or the throw kills (Core:Lethal).
function SkarnerChampion:NormalThrowWanted(target)
 local p=self.profile
 local reach=_G.SDK.Data:GetAutoAttackRange(myHero,target)+(p.qEmpowerRange or 0)
 if GetDistance(target.pos,myHero.pos)>reach then return true,'beyond_attack_reach'end
 local left=self:NormalRockWindow();if left and left<=(p.qLapseMargin or .5)then return true,'empowerment_lapses'end
 local raw=self:NormalQRaw(target,true)
 if raw and raw>0 then
  local impact=self.QSpell.Delay+GetDistance(target.pos,myHero.pos)/self.QSpell.Speed
  if Core:Lethal(target,impact,function()return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)end,{kind='physical'})then return true,'kill'end
 end
 return false,'keep_empowered_attacks'
end
function SkarnerChampion:NormalQRaw(target,throw)
 local rank=myHero:GetSpellData(_Q).level;if rank<=0 then return 0 end
 local p=self.profile
 local bonusHP=myHero.bonusHealth
 if not finite(bonusHP)then return nil end
 local raw=p.qBase[rank]+p.qAD*myHero.bonusDamage+p.qBonusHP*bonusHP
 if throw then
  local extra=target.maxHealth*p.qTargetHP
  if target.team==300 then extra=math.min(extra,p.qMonsterCap[rank])end
  raw=raw+extra
 end
 return raw
end
function SkarnerChampion:NormalQ(target,node,rescue,condition,finisher)
 if not node.Q:Value()or not self:ManaAllowed(node)or not IsReady(_Q)or not IsValid(target)then return false end
 local held=self:NormalRock()
 if not held then
   local ranged=node.PickupThrow and node.PickupThrow:Value()and not rescue
   if not _G.SDK.Data:IsInAutoAttackRange(myHero,target)and not ranged then return false end
   if ranged then
    local pred=Core:Prediction(self.QSpell);pred:GetPrediction(target,myHero)
    if not pred:CanHit(OrbamaPrediction.HITCHANCE_HIGH)then return false end
   end
   return Core:Cast(HK_Q,nil,{intentTarget=target,validate=function()
    return node.Q:Value()and self:ManaAllowed(node)and not self:NormalRock()and IsValid(target)and not rescue
     and(_G.SDK.Data:IsInAutoAttackRange(myHero,target)or ranged and node.PickupThrow:Value()and GetDistance(target.pos,myHero.pos)<=self.QSpell.Range)
     and(not condition or condition())
  end})
 end
 if not target.pos2D.onScreen or GetDistance(target.pos,myHero.pos)>self.QSpell.Range then return false end
 -- Rescues and finishers carry their own kill check; every other throw keeps the empowered attacks while useful.
 local keep=not rescue and not finisher
 if keep and not self:NormalThrowWanted(target)then return false end
 local pred=Core:Prediction(self.QSpell);pred:GetPrediction(target,myHero)
 if not pred:CanHit(target.type==Obj_AI_Minion and OrbamaPrediction.HITCHANCE_NORMAL or OrbamaPrediction.HITCHANCE_HIGH)then return false end
 -- A champion or a rescued minion must really be reached; a farming throw may hit whichever unit it meets.
 local exact=target.type==Obj_AI_Hero or rescue
 if exact and not self:NormalThrowReaches(target,pred.CastPosition)then return false end
 return Core:Cast(HK_Q,pred.CastPosition,{prevalidateWorldCast=true,validate=function(q,resolved)
   return node.Q:Value()and self:ManaAllowed(node)and self:NormalRock()and IsValid(target)and(not rescue or self:NormalRescue(target,_Q))and(not condition or condition())
    and(not exact or self:NormalThrowReaches(target,resolved and resolved.position or q.target))
    and(not keep or self:NormalThrowWanted(target))
 end})
end
-- The boulder explodes on the first enemy it meets. A unit standing on the line is acceptable only when the
-- explosion there still covers the aim point: its distance to the aim plus the boulder and body radii must fit
-- inside the profile's explosion radius. Without that figure in the profile any blocker refuses the throw.
function SkarnerChampion:NormalThrowReaches(target,point)
 local s=self.QSpell
 local wall,hits=OrbamaPrediction:GetCollision(myHero.pos,point,s.Speed,s.Delay,s.Radius,
  {OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL},target.networkID)
 if wall~=false then return false end
 local splash=self.profile.qSplash
 for i=1,#(hits or {})do local u=hits[i]
  if not finite(splash)or GetDistance(u.pos,point)+s.Radius+(u.boundingRadius or 0)>splash then return false end
 end
 return true
end
-- Impale in Combo: champions are counted where they will stand when the cast completes, inside the tapering
-- area itself (body radii are not added), and only up to the kit's target limit.
function SkarnerChampion:NormalRRows()
 local enemies=Core:Rows('hero',self.RSpell.Range+150);local rows={}
 for i=1,math.min(#enemies,5)do local u=enemies[i]
  if not IsInvulnerable(u)and Core:SpellProtected(u)==false then
   local pred=Core:Prediction(self.RAreaSpell);pred:GetPrediction(u,myHero)
   if pred:CanHit(OrbamaPrediction.HITCHANCE_HIGH)and pred.UnitPosition then rows[#rows+1]={x=pred.UnitPosition.x,z=pred.UnitPosition.z}end
  end
 end
 return rows
end
function SkarnerChampion:NormalRHits(dx,dz,rows)
 local p,range,o=self.profile,self.RSpell.Range,myHero.pos;local count=0
 for i=1,#rows do local x,z=rows[i].x-o.x,rows[i].z-o.z
  local along,across=x*dx+z*dz,math.abs(x*dz-z*dx)
  if along>=0 and along<=range and across<=p.rStartWidth+(p.rEndWidth-p.rStartWidth)*along/range then count=count+1 end
 end
 return math.min(count,p.rMaxTargets)
end
function SkarnerChampion:NormalRAim(need)
 local rows=self:NormalRRows();if #rows<need then return nil end
 local o=myHero.pos;local best,bestCount
 local function try(x,z)
  local dx,dz=x-o.x,z-o.z;local length=math.sqrt(dx*dx+dz*dz);if length<1 then return end
  local count=self:NormalRHits(dx/length,dz/length,rows)
  if count>=need and(not bestCount or count>bestCount)then best,bestCount={x=dx/length,z=dz/length},count end
 end
 -- Toward each champion and between each pair: at most 5 + 10 directions.
 for i=1,#rows do try(rows[i].x,rows[i].z);for j=i+1,#rows do try((rows[i].x+rows[j].x)/2,(rows[i].z+rows[j].z)/2)end end
 return best,bestCount
end
-- The Impale area cast toward `aim` covers the unit's current position.
function SkarnerChampion:NormalAimCatches(aim,u)
 if not aim or not IsValid(u)then return false end
 local o=myHero.pos;local dx,dz=aim.x-o.x,aim.z-o.z;local l=math.sqrt(dx*dx+dz*dz);if l<1 then return false end
 return self:NormalRHits(dx/l,dz/l,{{x=u.pos.x,z=u.pos.z}})>=1
end
-- Normal R then Flash (Core:FlashFollow, spell first): Impale is cast toward a target beyond its 625 reach and the
-- Flash, requested once the cast is observed and inside the 0.75 s cast time, carries the area onto it. Off by
-- default; the landing must keep the target inside the area and stay out of enemy turret range.
function SkarnerChampion:NormalFlashR()
 local combo=self.flashCombo
 if combo:Busy()or not Menu.Combo.FlashR:Value()or not Menu.Combo.R:Value()or not IsReady(_R)then return false end
 local status=Core:FlashStatus();if not status then return false end
 local rCost=myHero:GetSpellData(_R).mana;if not finite(rCost)or myHero.mana<status.cost+rCost then return false end
 local reach=self.RSpell.Range;local target=self:GetFlashTarget(reach+status.range-75)
 if not target or IsInvulnerable(target)or Core:SpellProtected(target)~=false then return false end
 local d=GetDistance(target.pos,myHero.pos);if d<=reach then return false end
 self.RFlashSpell=self.RFlashSpell or {Type=OrbamaPrediction.SPELLTYPE_LINE,Range=reach+status.range,Radius=self.RAreaSpell.Radius,Delay=self.RAreaSpell.Delay,Speed=math.huge,Collision=false}
 local pred=Core:Prediction(self.RFlashSpell);pred:GetPrediction(target,myHero)
 local spot=pred.UnitPosition;if not pred:CanHit(OrbamaPrediction.HITCHANCE_HIGH)or not spot then return false end
 local far=GetDistance(spot,myHero.pos);if far<=reach or far>reach+status.range-75 then return false end
 local o=myHero.pos;local dx,dz=(spot.x-o.x)/far,(spot.z-o.z)/far
 local landing=Vector(o.x+dx*math.min(status.range,far-reach+150),o.y,o.z+dz*math.min(status.range,far-reach+150))
 local cast=Vector(o.x+dx*reach*.8,o.y,o.z+dz*reach*.8);local id,handle=identity(target),target.handle
 local function authorized()return Menu.Combo.FlashR:Value()and Menu.Combo.R:Value()and GetMode()=='Combo'end
 local function same()return IsValid(target)and identity(target)==id and target.handle==handle end
 local function valid(pos)return same()and GetDistance(target.pos,pos)<=reach-50 and not IsUnderTurret2(pos)end
 return combo:Start{order='spell_first',aim=landing,authorized=authorized,valid=valid,mana=rCost,window=.45,ttl=1.5,
  follow=function(context)return Core:Cast(HK_R,cast,{owner='FlashR',context=context,validate=function()return authorized()and same()end})end}
end
function SkarnerChampion:NormalComboR()
 local node=Menu.Combo
 if not node.R:Value()or not IsReady(_R)then return false end
 local aim=self:NormalRAim(node.RCount:Value());if not aim then return false end
 local o=myHero.pos;local reach=self.RSpell.Range*.8
 return Core:Cast(HK_R,Vector(o.x+aim.x*reach,o.y,o.z+aim.z*reach),{validate=function()
  return node.R:Value()and self:ManaAllowed(node)and self:NormalRHits(aim.x,aim.z,self:NormalRRows())>=node.RCount:Value()
 end})
end
-- Ixtal's Impact stuns only when the carried champion meets terrain. The charge is worth it when terrain lies
-- 100-450 units behind the target on Skarner's line (8 bounded Game.isWall samples), or when the target dies to what
-- follows the catch: ready Q, W and R plus one attack (Core:Lethal). Otherwise Q and W keep the fight.
function SkarnerChampion:NormalWallBehind(target)
 if type(Game.isWall)~='function'or not IsValid(target)then return false end
 local o,t=myHero.pos,target.pos;local dx,dz=t.x-o.x,t.z-o.z;local l=math.sqrt(dx*dx+dz*dz);if l<1 then return false end
 dx,dz=dx/l,dz/l
 for d=100,450,50 do if Game.isWall(Vector(t.x+dx*d,t.y or 0,t.z+dz*d))==true then return true,d end end
 return false
end
-- Mitigated damage of the ready abilities that reach a unit `d` away (no attack).
function SkarnerChampion:NormalBurst(u,d)
 local p,sdk=self.profile,_G.SDK;local total=0
 if IsReady(_Q)then
  local held=self:NormalRock()
  if held and d<=self.QSpell.Range or not held and d<=sdk.Data:GetAutoAttackRange(myHero,u)+(p.qEmpowerRange or 0)then
   local raw=self:NormalQRaw(u,held);if raw and raw>0 then total=total+sdk.Damage:CalculateDamage(myHero,u,sdk.DAMAGE_TYPE_PHYSICAL,raw)end
  end
 end
 local w,r=myHero:GetSpellData(_W).level,myHero:GetSpellData(_R).level
 if IsReady(_W)and w>0 and d<=self.WSpell.Range then total=total+sdk.Damage:CalculateDamage(myHero,u,sdk.DAMAGE_TYPE_MAGICAL,p.wBase[w]+p.wAP*(myHero.ap or 0))end
 if IsReady(_R)and r>0 and p.rBase[r]and d<=self.RSpell.Range then total=total+sdk.Damage:CalculateDamage(myHero,u,sdk.DAMAGE_TYPE_MAGICAL,p.rBase[r]+p.rAP*(myHero.ap or 0))end
 return total
end
function SkarnerChampion:NormalChargeWorth(target)
 if self:NormalWallBehind(target)then return true,'wall'end
 local impact=GetDistance(target.pos,myHero.pos)/600+.5
 local ok=Core:Lethal(target,impact,function()
  local okAA,aa=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,target,true)
  return self:NormalBurst(target,0)+(okAA and finite(aa)and aa or 0)
 end)
 return ok==true,ok and'kill'or'no_wall_no_kill'
end
-- Flee: an E charge toward the cursor (off by default: a long cooldown spent on running).
function SkarnerChampion:NormalFlee()
 if not Menu.Flee.E:Value()or not IsReady(_E)or self:NormalCharging()then return false end
 local cursor=mousePos and Core.point(mousePos);if not cursor then return false end
 local o=myHero.pos;local dx,dz=cursor.x-o.x,cursor.z-o.z;local l=math.sqrt(dx*dx+dz*dz);if l<50 then return false end
 return Core:Cast(HK_E,Vector(o.x+dx/l*650,o.y,o.z+dz/l*650),{validate=function()return Menu.Flee.E:Value()and not self:NormalCharging()end})
end
function SkarnerChampion:NormalW(target,node)
 if not node.W or not node.W:Value()or not self:ManaAllowed(node)or not IsReady(_W)or self:BuffActive('SkarnerWShield')then return false end
 return self:SelfCast(HK_W,target,self.WSpell.Range,function()return node.W:Value()and self:ManaAllowed(node)and not self:BuffActive('SkarnerWShield')end)
end
function SkarnerChampion:NormalCombat(node,mode)
 if not self:ManaAllowed(node)then return end
 if mode=='Combo'and self:NormalComboR()then return end
 local target=GetTarget(self.QSpell.Range);if not IsValid(target)then return end
 if self:NormalW(target,node)then return end
 if self:NormalQ(target,node)then return end
 -- E is an explicit mobility resource choice. Native charge motion is left to
 -- the player's controls; the controller sends no competing movement orders.
 if node.E:Value()and IsReady(_E)and GetDistance(target.pos,myHero.pos)<=650 and not IsUnderTurret(target)then
  if not self:NormalChargeWorth(target)then return end
  Core:Cast(HK_E,target.pos,{intentTarget=target,range=self.ESpell.Range,validate=function()return node.E:Value()and self:ManaAllowed(node)and IsValid(target)and GetDistance(target.pos,myHero.pos)<=650 and not IsUnderTurret(target)and self:NormalChargeWorth(target)end})
 end
end
function SkarnerChampion:NormalSemiR()
 if not Menu.Misc.SemiR:Value()or not IsReady(_R)then return end
 local target=self:GetRTarget();if not IsValid(target)then return end
 local pred=Core:Prediction(self.RAreaSpell);pred:GetPrediction(target,myHero)
 if not pred:CanHit(OrbamaPrediction.HITCHANCE_HIGH)then return end
 -- The bind needs only the selected target; others in the area are a bonus.
 Core:Cast(HK_R,pred.CastPosition,{context=Core:HeldContext(function()return Menu.Misc.SemiR:Value()end),prevalidateWorldCast=true,validate=function()
  return Menu.Misc.SemiR:Value()and IsValid(target)
 end})
end
function SkarnerChampion:NormalRescue(target,slot)
 local raw=slot==_Q and self:NormalRock()and self:NormalQRaw(target,true)or nil
 if not raw then return false end
 local delay=self.QSpell.Delay+GetDistance(target.pos,myHero.pos)/self.QSpell.Speed
 local hp=Core:UnshieldedLegacyForecast(target,delay)
 if not hp or hp<=0 then return false end
 local damage=_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
 if damage<hp then return false end
 if _G.SDK.Orbwalker:CanAttack()and _G.SDK.Data:IsInAutoAttackRange(myHero,target)and _G.SDK.Damage:GetAutoAttackDamage(myHero,target,true)>=target.health then return false end
 return true
end
function SkarnerChampion:NormalFarm(jungle)
 local mode=jungle and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or _G.SDK.ORBWALKER_MODE_LANECLEAR
 if not _G.SDK.Orbwalker.Modes[mode]or not Menu.Clear.SpellFarm:Value()or not self:ManaAllowed(Menu.Clear)then return end
 local node=jungle and Menu.Clear.JungleClear or Menu.Clear.LaneClear
 -- Farm mana uses the parent policy; no second settings tree is maintained.
 node.Mana=Menu.Clear.Mana
 local targets=Core:DecisionUnits(jungle and 'GetMonsters'or'GetEnemyMinions')
 for i=1,math.min(#targets,12)do local u=targets[i]
  if IsValid(u)and u.pos2D.onScreen then
    local function countQ()return jungle or not IsUnderTurret(myHero)and self:NearbyLane(self:NormalRock()and self.QSpell.Range or 300)>=Menu.Clear.LaneClear.QCount:Value()end
    if countQ()and self:NormalQ(u,node,false,countQ)then return end
    if node.W:Value()and(jungle or not IsUnderTurret(myHero)and self:NearbyLane(self.WSpell.Range)>=Menu.Clear.LaneClear.WCount:Value())then
     if self:SelfCast(HK_W,u,self.WSpell.Range,function()return node.W:Value()and self:ManaAllowed(Menu.Clear)and(jungle or not IsUnderTurret(myHero)and self:NearbyLane(self.WSpell.Range)>=Menu.Clear.LaneClear.WCount:Value())end)then return end
    end
  end
 end
end
function SkarnerChampion:NormalTick()
 if ShouldWait()then _G.SDK.Orbwalker:SetAttack(true);return end
 self:NormalRockWindow()
 local protected=self:IsImpaling()or self:NormalCharging()or self:RWindup()
 _G.SDK.Orbwalker:SetAttack(not protected)
 -- The R-Flash continuation runs during the Impale cast time.
 if self.flashCombo:Busy()and self.flashCombo:Maintain()then return end
 if protected or IsCasting()then return end
 self:NormalSemiR();if self:InterruptR()then return end;self:NormalKillSteal();self:ThreatW()
 local mode=GetMode()
 if mode=='Combo'then if not self:FlashR()then self:NormalCombat(Menu.Combo,mode)end
 elseif mode=='Flee'then self:NormalFlee()
 elseif mode=='Harass'then self:NormalCombat(Menu.Harass,mode)
  elseif mode=='LaneClear'then self:NormalFarmHarass();self:NormalLaneClear();self:NormalJungleClear()
 elseif mode=='LastHit'and Menu.LastHit.Q:Value()and self:ManaAllowed(Menu.LastHit)then
  local units=Core:DecisionUnits('GetEnemyMinions');for i=1,math.min(#units,12)do local u=units[i]
   if IsValid(u)and self:NormalRescue(u,_Q)and self:NormalQ(u,Menu.LastHit,true)then return end
  end
 end
end
function SkarnerChampion:NormalLaneClear()return self:NormalFarm(false)end
function SkarnerChampion:NormalJungleClear()return self:NormalFarm(true)end
function SkarnerChampion:NormalFarmHarass()
 if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR]and Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)then self:NormalCombat(Menu.Harass,'LaneClear')end
end
function SkarnerChampion:NormalKillSteal()
 local node=Menu.KillSteal;if not self:ManaAllowed(node)then return end
 local units=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#units,10)do local u=units[i]
  if IsValid(u)and u.pos2D.onScreen then
   local function lethalQ()
    local raw=self:NormalRock()and self:NormalQRaw(u,true)
    local impact=self.QSpell.Delay+GetDistance(u.pos,myHero.pos)/self.QSpell.Speed
    return raw and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)>=u.health+(u.shieldAD or 0)+(u.hpRegen or 0)*impact
   end
   if node.Q:Value()and self:NormalRock()and lethalQ()and self:NormalQ(u,node,false,lethalQ,true)then return end
   local function lethalW()
    local rank=myHero:GetSpellData(_W).level;if rank<=0 then return false end
    local raw=self.profile.wBase[rank]+self.profile.wAP*myHero.ap
    return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)>=u.health+(u.shieldAP or 0)+(u.hpRegen or 0)*.25
   end
   if node.W:Value()and IsReady(_W)and lethalW()and self:SelfCast(HK_W,u,self.WSpell.Range,function()return node.W:Value()and self:ManaAllowed(node)and lethalW()end)then return end
  end
 end
end
function SkarnerChampion:RegisterNormalGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},throw={node=Menu.Combo.PickupThrow,label='Prepare ranged throw'},w={node=Menu.Combo.W,label='Combo shield pulse'},e={node=Menu.Combo.E,label='Combo charge'},
  mana={node=Menu.Harass.Mana,label='Harass mana'},farm={node=Menu.Clear.SpellFarm,label='Spell farming'},last={node=Menu.LastHit.Q,label='Last Hit Q'},
  r={node=Menu.Combo.R,label='Combo Impale'},rcount={node=Menu.Combo.RCount,label='Champions to catch'},shield={node=Menu.Misc.ShieldW,label='Shield against hits'}}
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Skarner: combat','Skarner: charge, Impale and farming'},function(page)
  if page==1 then return {title='Skarner',subtitle='Boulder pickup, throw and shield pulse.',cards={
   {'COMBAT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..' for [[q]] and [[w]]. Q pickup and throwing are separate native spell stages.'},
   {'RANGED Q','[[throw]] picks up a boulder early so Q can be thrown at a target out of attack range. Turn it off to keep Q for attacks. The boulder bursts on the first enemy it meets, so a throw at a champion needs a free line, or a blocker close enough for the burst to reach. [[shield]] casts W when a champion or turret is about to hit you.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. Harass has separate Q, shield-pulse, charge and ranged-pickup choices, gated by [[mana]].'}},note='Lethal estimates do not count an unobserved wall pin, future attacks or passive damage.'}end
  return {title='Charge, Impale and farming',subtitle='You steer charge and dragging.',cards={
   {'CHARGE','[[e]] charges at a target within 650 units that is not under a turret, only when a wall stands behind it to stun it against or when the follow-up kills. You steer the charge; no competing movement commands are sent.'},
   {'IMPALE','Hold '..settings.key(Menu.Misc.SemiR)..' for a predicted R at the selected target. Others inside its tapered area are hit as well, up to three. In Combo [[r]] casts on its own when [[rcount]] champions will stand inside that area as the cast completes.'},
   {'FARMING','Enable [[farm]] for Q/W lane and jungle farming. [[last]] rescues isolated CS with an already available throw; it does not pick up a new rock speculatively.'}},note='Observed charge and Impale protect attacks while you retain movement control.'}
 end,cfg,links,activate)
end


function SkarnerChampion:GetRTarget()
	local selected = _G.SDK.TargetSelector.Selected
	if IsValid(selected) and selected.pos2D.onScreen and myHero.pos:DistanceTo(selected.pos) <= self.RSpell.Range then
		return selected
	end
	return GetTarget(self.RSpell.Range)
end

function SkarnerChampion:Combo()
 if not self:ManaAllowed(Menu.Combo)then return end
 if Menu.Combo.R:Value()and IsReady(_R)then
  local target=self:GetRTarget()
  if self:ComboRAllowed(target)and target.pos2D.onScreen
   and Core:Cast(HK_R,target,{range=self.RSpell.Range,validate=function()return self:ComboRAllowed(target)end})then return end
 end
 if Menu.Combo.E:Value()and IsReady(_E)then
  local target=GetTarget(self.ESpell.Range)
  if IsValid(target)and self:CastE(target)then return end
 end
 if Menu.Combo.Q:Value()and IsReady(_Q)then
  local target=GetTarget(self.QSpell.Range)
  if self:SelfCast(HK_Q,target,self.QSpell.Range)then return end
 end
 if Menu.Combo.W:Value()and IsReady(_W)then
  self:SelfCast(HK_W,GetTarget(self.WSpell.Range),self.WSpell.Range)
 end
end

function SkarnerChampion:ImpaleActions()
 if not self:IsImpaling()or not self:ManaAllowed(Menu.Combo)then return end
 -- Dragging continues the combo: the Combo Q/W switches decide, without a mode key.
 if Menu.Combo.Q:Value()and IsReady(_Q)then
  if self:SelfCast(HK_Q,GetTarget(self.QSpell.Range),self.QSpell.Range,function()return Menu.Combo.Q:Value()and self:IsImpaling()end)then return end
 end
 if Menu.Combo.W:Value()and IsReady(_W)then
  Core:Cast(HK_W,nil,{validate=function()return Menu.Combo.W:Value()and self:IsImpaling()and self:ManaAllowed(Menu.Combo)end})
 end
end

function SkarnerChampion:Harass()
 if not self:ManaAllowed(Menu.Harass)then return end
 if Menu.Harass.E:Value()and IsReady(_E)and self:CastE(GetTarget(self.ESpell.Range))then return end
 if Menu.Harass.Q:Value()and IsReady(_Q)then self:SelfCast(HK_Q,GetTarget(self.QSpell.Range),self.QSpell.Range)end
end

function SkarnerChampion:FarmHarass()
 if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR]and Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)then self:Harass()end
end

function SkarnerChampion:LaneClear()
 if not _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR]then return end
 if not Menu.Clear.SpellFarm:Value()or IsUnderTurret(myHero)or not self:ManaAllowed(Menu.Clear)then return end
 local menu=Menu.Clear.LaneClear
 if menu.E:Value()and IsReady(_E)then
  local minions=Core:DecisionUnits('GetEnemyMinions');local best,bestCount
  for i=1,math.min(#minions,12)do local target=minions[i]
   if target.team~=300 and self:TargetAllowed(target,self.ESpell.Range)and target.pos2D.onScreen then
    local count=self:LineHits(target.pos)
    if count>=menu.ECount:Value()and(not bestCount or count>bestCount)then best,bestCount=target,count end
   end
  end
  if best and self:CastE(best,function(q,resolved)
   return not IsUnderTurret(myHero)and self:ManaAllowed(Menu.Clear)and self:LineHits(resolved and resolved.position)>=menu.ECount:Value()
  end)then return end
 end
 local nearby=self:NearbyLane(self.QSpell.Range)
 if menu.Q:Value()and IsReady(_Q)and nearby>=menu.QCount:Value()then
  if Core:Cast(HK_Q,nil,{validate=function()return not IsUnderTurret(myHero)and self:ManaAllowed(Menu.Clear)and self:NearbyLane(self.QSpell.Range)>=menu.QCount:Value()end})then return end
 end
 if menu.W:Value()and IsReady(_W)and nearby>=menu.WCount:Value()then
  Core:Cast(HK_W,nil,{validate=function()return not IsUnderTurret(myHero)and self:ManaAllowed(Menu.Clear)and self:NearbyLane(self.QSpell.Range)>=menu.WCount:Value()end})
 end
end

function SkarnerChampion:JungleClear()
 if not _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR]then return end
 if not Menu.Clear.SpellFarm:Value()or not self:ManaAllowed(Menu.Clear)then return end
 local units=Core:DecisionUnits('GetMonsters');local monster
 for i=1,math.min(#units,16)do local u=units[i]
  if u.team==300 and self:TargetAllowed(u,self.ESpell.Range)and u.pos2D.onScreen and(not monster or u.maxHealth>monster.maxHealth)then monster=u end
 end
 if not monster then return end
 local menu=Menu.Clear.JungleClear
 if menu.E:Value()and IsReady(_E)and self:CastE(monster)then return end
 if menu.Q:Value()and IsReady(_Q)and self:SelfCast(HK_Q,monster,self.QSpell.Range)then return end
 if menu.W:Value()and IsReady(_W)then self:SelfCast(HK_W,monster,self.WSpell.Range)end
end

function SkarnerChampion:SemiR()
 if not Menu.Misc.SemiR:Value()or not IsReady(_R)then return end
 local target=self:GetRTarget()
 if self:TargetAllowed(target,self.RSpell.Range)and target.pos2D.onScreen then return Core:Cast(HK_R,target,{range=self.RSpell.Range})end
end

function SkarnerChampion:KillSteal()
 if not self:ManaAllowed(Menu.KillSteal)then return end
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,10)do local target=enemies[i]
  if IsValid(target)then
   if Menu.KillSteal.Q:Value()and IsReady(_Q)and self:QLethal(target)then
    if self:SelfCast(HK_Q,target,self.QSpell.Range,function()return Menu.KillSteal.Q:Value()and self:ManaAllowed(Menu.KillSteal)and self:QLethal(target)end,'AutoLethal')then return end
   end
   if Menu.KillSteal.E:Value()and IsReady(_E)and self:ELethal(target)and self:CastE(target,function()return Menu.KillSteal.E:Value()and self:ManaAllowed(Menu.KillSteal)and self:ELethal(target)end,'AutoLethal')then return end
  end
 end
end

function SkarnerChampion:CastE(target,condition,owner)
 if not IsReady(_E)or not self:TargetAllowed(target,self.ESpell.Range)or not target.pos2D.onScreen then return false end
 local pred=Core:Prediction(self.ESpell);pred:GetPrediction(target,myHero)
 local confidence=target.type==Obj_AI_Minion and OrbamaPrediction.HITCHANCE_NORMAL or OrbamaPrediction.HITCHANCE_HIGH
 if not pred:CanHit(confidence)then return false end
 local aim=pred.CastPosition
 local ok=Core:Cast(HK_E,aim,{owner=owner,prevalidateWorldCast=true,validate=condition})
 if ok and Core.logger then
  Core:AfterCast(HK_E,function()self.eProbe={origin={x=myHero.pos.x,z=myHero.pos.z},aim={x=aim.x,z=aim.z},at=Game.Timer()}end)
 end
 return ok
end

-- Development evidence (logger only) for the Classic Fracture conflict (asset 800 / 1800 against the page's
-- 1000 / 500): the own missile's speed between two samples and the farthest point it reached.
function SkarnerChampion:TraceE()
 local probe=self.eProbe;local now=Game.Timer()
 local function finish()
  self.eProbe=nil
  if probe.first and probe.last then
   local dx,dz=probe.last.x-probe.origin.x,probe.last.z-probe.origin.z
   Core:Trace('skarner_e_missile',{profile=self.profile.id,name=probe.name,speed=probe.speed,travel=math.sqrt(dx*dx+dz*dz),
    seconds=probe.last.at-probe.first.at,aim=probe.aim,origin=probe.origin,row={range=self.ESpell.Range,speed=self.ESpell.Speed}})
  end
 end
 if not Core.logger or not Game.MissileCount or now-probe.at>2 then return finish()end
 if now<(probe.next or 0)then return end;probe.next=now+.03
 local seen=false
 for i=1,math.min(128,Game.MissileCount())do
  local m=Game.Missile(i);local d=m and m.missileData;local name=d and d.name
  local owner=d and d.owner;if type(owner)=='table'or type(owner)=='userdata'then owner=owner.networkID or owner.handle end
  if type(name)=='string'and name:find('SkarnerE',1,true)and m.pos and(owner==myHero.networkID or owner==myHero.handle)then
   seen=true;probe.name=name;local row={x=m.pos.x,z=m.pos.z,at=now}
   if not probe.first then probe.first=row
   elseif not probe.speed and now-probe.first.at>=.05 then
    probe.speed=math.sqrt((row.x-probe.first.x)^2+(row.z-probe.first.z)^2)/(now-probe.first.at)
   end
   probe.last=row;break
  end
 end
 if not seen and probe.first then return finish()end
end

function SkarnerChampion:GetQDmg(target)
 local physical,magical=self:GetQParts(target)
 return physical+magical
end

function SkarnerChampion:GetEDmg(target)
	local level = myHero:GetSpellData(_E).level
	if level == 0 then return 0 end
	local damage = ({80, 120, 160, 200, 240})[level] + myHero.ap * 0.70
	return _G.SDK.Damage:CalculateDamage(myHero, target, _G.SDK.DAMAGE_TYPE_MAGICAL, damage)
end

function SkarnerChampion:Draw()
	if myHero.dead then return end
	if Menu.Draw.Q:Value() and IsReady(_Q) then Draw.Circle(myHero.pos, self.QSpell.Range, 1, Draw.Color(255, 66, 244, 113)) end
	if Menu.Draw.W:Value() and IsReady(_W) then Draw.Circle(myHero.pos, self.WSpell.Range, 1, Draw.Color(255, 244, 200, 66)) end
	if Menu.Draw.E:Value() and IsReady(_E) then Draw.Circle(myHero.pos, self.ESpell.Range, 1, Draw.Color(255, 66, 229, 244)) end
	if Menu.Draw.R:Value() and IsReady(_R) then Draw.Circle(myHero.pos, self.RSpell.Range, 1, Draw.Color(255, 244, 66, 104)) end
end


function SkarnerChampion:BuffActive(alias)
 local unit=myHero
 local count=unit and unit.buffCount
 if not finite(count)or count<0 or count>128 then return false end
 for i=0,count do local b=unit:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==alias:lower()and finite(b.count)and b.count>0 then
   local ending=Core.buffExpiry(b)
   if finite(ending)and ending>Game.Timer()then
    local source=b.source or b.sourceID or b.sourcenID
    local kind=type(source);local id=kind=='number'and source or(kind=='table'or kind=='userdata')and identity(source)
    if source==nil or id==myHero.networkID or id==myHero.handle then return true,ending end
   end
  end
 end
 return false
end

function SkarnerChampion:RWindup()
 local spell=myHero.activeSpell
 return spell and spell.valid and not spell.isStopped and spell.name==(self.profile.id=='normal'and'SkarnerR'or'Jade_SkarnerR')
  and finite(spell.startTime)and finite(spell.castEndTime)and spell.startTime<=Game.Timer()and spell.castEndTime>Game.Timer()
end

function SkarnerChampion:ManaAllowed(node)
 return node and node.Mana and Core.manaAbove(node.Mana:Value())
end

function SkarnerChampion:TargetAllowed(target,range)
 return IsValid(target)and GetDistance(target.pos,myHero.pos)<=range
end

function SkarnerChampion:SelfCast(key,target,range,condition,owner)
 if not self:TargetAllowed(target,range)then return false end
 return Core:Cast(key,nil,{owner=owner,intentTarget=target,validate=function()
  return self:TargetAllowed(target,range)and(not condition or condition())
 end})
end

function SkarnerChampion:NearbyLane(range)
 local units=Core:DecisionUnits('GetEnemyMinions');local count=0
 for i=1,math.min(#units,32)do local u=units[i]
  if u.team~=300 and self:TargetAllowed(u,range)then count=count+1 end
 end
 return count
end

function SkarnerChampion:LineHits(point)
 if not point then return 0 end
 local origin=myHero.pos;local dx,dz=point.x-origin.x,point.z-origin.z
 local length=math.sqrt(dx*dx+dz*dz);if length<1 then return 0 end
 dx,dz=dx/length,dz/length
 local units=Core:DecisionUnits('GetEnemyMinions');local count=0
 for i=1,math.min(#units,32)do local u=units[i]
  if u.team~=300 and IsValid(u)and u.pathing and not u.pathing.hasMovePath and not u.pathing.isDashing then
   local x,z=u.pos.x-origin.x,u.pos.z-origin.z
   local along=x*dx+z*dz;local perpendicular=x*dz-z*dx
   -- Conservative stationary centers. Bounding-radius grazes are not counted.
   if along>=0 and along<=self.ESpell.Range and perpendicular*perpendicular<=self.ESpell.Radius*self.ESpell.Radius then count=count+1 end
  end
 end
 return count
end

function SkarnerChampion:GetQParts(target,delay)
 local rank=myHero:GetSpellData(_Q).level
 if rank<1 or rank>5 then return 0,0 end
 local physical=_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,({25,40,55,70,85})[rank]+(myHero.bonusDamage or 0)*.8)
 local magical=0
 local energy,ending=self:BuffActive('Jade_SkarnerQ_Energy1')
 if energy and ending>Game.Timer()+(delay or 0)then
  magical=_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,({24,36,48,60,72})[rank]+(myHero.ap or 0)*.4)
 end
 return physical,magical
end

function SkarnerChampion:RescueDamage(target,slot,delay)
 if slot==_E then return math.max(0,self:GetEDmg(target)-math.max(0,target.shieldAP or 0))end
 local physical,magic=self:GetQParts(target,delay)
 return math.max(0,physical-math.max(0,target.shieldAD or 0))+math.max(0,magic-math.max(0,target.shieldAP or 0))
end

function SkarnerChampion:AttackRescues(target)
 local sdk=_G.SDK
 if not sdk.Orbwalker:CanAttack()or not sdk.Data:IsInAutoAttackRange(myHero,target)then return false end
 local windup=sdk.Attack:GetWindup();local speed=sdk.Attack:GetProjectileSpeed()
 if not finite(windup)or windup<0 or not(speed==math.huge or finite(speed)and speed>0)then return false end
 local impact=windup+GetDistance(myHero.pos,target.pos)/speed
 local hp=sdk.HealthPrediction:GetPrediction(target,impact)
 if not finite(hp)or hp<=0 then return false end
 return sdk.Damage:GetAutoAttackDamage(myHero,target,true)>=hp+math.max(0,target.hpRegen or 0)*impact+math.max(0,target.shieldAD or 0)
end

function SkarnerChampion:RescueAllowed(target,slot,point)
 local letter=slot==_Q and 'Q'or 'E';local menu=Menu.LastHit
 local range=slot==_Q and self.QSpell.Range or self.ESpell.Range
 if not menu[letter]:Value()or not self:ManaAllowed(menu)or not self:TargetAllowed(target,range)
  or target.type~=Obj_AI_Minion or target.team==300 or _G.SDK.Attack:IsActive()then return false end
 local delay=.25
 if slot==_Q and(not target.pathing or target.pathing.hasMovePath or target.pathing.isDashing)then return false end
 if slot==_E then
  if not point then return false end
  delay=self.ESpell.Delay+GetDistance(myHero.pos,point)/self.ESpell.Speed
 end
 local hp=_G.SDK.HealthPrediction:GetPrediction(target,delay)
 if not finite(hp)or hp<=0 then return false end
 if self:RescueDamage(target,slot,delay)<math.max(hp,target.health)+math.max(0,target.hpRegen or 0)*delay then return false end
 if self:AttackRescues(target)then return false end
 -- Last Hit rescues one CS. Reject collateral softening, including units that
 -- could enter the outgoing ray before impact. No provider arrays are changed.
 local origin=myHero.pos;local dx,dz,length
 if slot==_E then dx,dz=point.x-origin.x,point.z-origin.z;length=math.sqrt(dx*dx+dz*dz);if length<1 then return false end;dx,dz=dx/length,dz/length end
 -- Original GG retains its discovery list across a short cache interval.
 -- New collateral must be discovered during preparation, not assumed absent.
 if not Game.MinionCount or not Game.Minion then return false end
 local count=Game.MinionCount();if not finite(count)or count<0 or count>64 then return false end
 for i=1,count do
  local u=Game.Minion(i)
   if u and u.team~=myHero.team and identity(u)~=identity(target)and IsValid(u)then
    local reach=(u.boundingRadius or 35)+math.max(0,u.ms or 0)*delay
    if slot==_Q then
     if GetDistance(origin,u.pos)<=range+reach then return false end
    else
     local x,z=u.pos.x-origin.x,u.pos.z-origin.z;local along=x*dx+z*dz;local across=math.abs(x*dz-z*dx)
     if along>=-reach and along<=range+reach and across<=self.ESpell.Radius+reach then return false end
    end
   end
 end
 return true
end

function SkarnerChampion:LastHit()
 if not self:ManaAllowed(Menu.LastHit)or self:IsImpaling()then return false end
 local units=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#units,32)do local target=units[i]
  if IsValid(target)and target.team~=300 then
   if IsReady(_Q)and self:RescueAllowed(target,_Q)then
    if self:SelfCast(HK_Q,target,self.QSpell.Range,function()return self:RescueAllowed(target,_Q)end)then return true end
   end
   if Menu.LastHit.E:Value()and IsReady(_E)and self:RescueAllowed(target,_E,target.pos)then
    if self:CastE(target,function(_,resolved)return self:RescueAllowed(target,_E,resolved and resolved.position)end)then return true end
   end
  end
 end
 return false
end

function SkarnerChampion:QLethal(target)
 if not self:TargetAllowed(target,self.QSpell.Range)then return false end
 local physical,magical=self:GetQParts(target)
 local useful=math.max(0,physical-math.max(0,target.shieldAD or 0))+math.max(0,magical-math.max(0,target.shieldAP or 0))
 return useful>=target.health+math.max(0,target.hpRegen or 0)*.25
end

function SkarnerChampion:ELethal(target)
 if not self:TargetAllowed(target,self.ESpell.Range)then return false end
 local delay=self.ESpell.Delay+GetDistance(target.pos,myHero.pos)/self.ESpell.Speed
 return self:GetEDmg(target)>=target.health+math.max(0,target.shieldAP or 0)+math.max(0,target.hpRegen or 0)*delay
end

function SkarnerChampion:RegisterGuide(guide,settings)
 if self.profile.id=='normal'then return self:RegisterNormalGuide(guide,settings)end
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},w={node=Menu.Combo.W,label='Combo W'},e={node=Menu.Combo.E,label='Combo E'},
  farm={node=Menu.Clear.SpellFarm,label='Spell farming'},line={node=Menu.Clear.LaneClear.ECount,label='E line threshold'},
  r={node=Menu.Misc.SemiR,label='Hold R'},combor={node=Menu.Combo.R,label='Combo Impale'},shield={node=Menu.Misc.ShieldW,label='Shield against hits'},mana={node=Menu.Harass.Mana,label='Harass mana'},lastq={node=Menu.LastHit.Q,label='Last Hit Q'},laste={node=Menu.LastHit.E,label='Last Hit E'}}
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Classic Skarner: combat','Classic Skarner: Impale and farming'},function(page)
  if page==1 then return {title='Classic Skarner',subtitle='Energize, Crystal Slash and healing Fracture belong to this old kit.',cards={
   {'COMBAT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..' for [[e]], [[q]] and [[w]]. Self casts keep their original target and recheck its reach before sending.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. [[mana]] and separate Q/E switches control spending. Farm Harass keeps the triggering Clear mode.'},
   {'ENERGY','Only a live Q energy buff contributes the extra magic component to a lethal Q estimate. Host readiness supplies cooldown changes from Energize. No future attacks are invented.'}},note='Classic E is a piercing line. The modern boulder, charge capture and multi-target ultimate are separate mechanics and are not loaded here.'}end
  return {title='Impale and farming',subtitle='You control movement and dragging.',cards={
   {'IMPALE','Hold [[r]], T by default. A selected target takes precedence within the conservative 350-unit reach. The controller blocks its own attacks during the cast and observed Impale, then releases only that restriction. In Combo [[combor]] impales your target on its own when it is below 40% health or an allied champion is within 800 units, never from inside enemy turret range. [[shield]] casts W when a champion or turret is about to hit you.'},
   {'WHILE DRAGGING','[[q]] and [[w]] keep casting while you drag an enemy with R, without a mode key, and stop when the drag ends. You steer the drag; no E or movement is sent.'},
   {'FARMING','Enable [[farm]]. Q/W require current nearby counts. E requires [[line]] stationary centers in its actual outgoing line; a cluster beside that line does not qualify.'},
   {'LAST HIT','Hold the provider Last Hit key and [[lastq]] / [[laste]] rescue an isolated lethal CS when a ready attack or incoming damage will not secure it. Nearby collateral minions reject the cast.'}},note='R range has conflicting installed fields. Live range, E hitbox and Q/W-during-Impale acceptance remain open. Healing marks are not used for predicted sustain until ownership and aliases are verified.'}
 end,cfg,links,activate)
end

-- Explicit contexts; the shared provider owns input, cleanup and attack restrictions.
Core:RegisterPolicy({
 methods={
  NormalCombat=function()return Core:ModeContext(GetMode())end,
  NormalLaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,
  NormalJungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
  NormalFarmHarass=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)end)end,
  NormalKillSteal=function()return {priority='interactive'}end,
  NormalFlee=function()return Core:ModeContext('Flee')end,
  Flee=function()return Core:ModeContext('Flee')end,
  InterruptR=function()return {priority='interactive'}end,
  Combo=function()return Core:ModeContext('Combo')end,
  Harass=function()return Core:ModeContext('Harass')end,
  LastHit=function()return Core:ModeContext('LastHit')end,
  LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,
  JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
  FarmHarass=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)end)end,
  SemiR=function()return Core:HeldContext(function()return Menu.Misc.SemiR:Value()end)end,
  KillSteal=function()return {priority='interactive'}end,
  AutoLethal=function()return {priority='interactive'}end,
  ThreatW=function()return {priority='interactive'}end,
  ImpaleActions=function(self)return {priority='interactive',condition=function()return self:IsImpaling()end}end,
 },
 -- Dedicated typed lethal predicates above replace the generic combined-shield gate.
 damageTypes={Q='mixed',E='magical'},
 exceptions={non_interrupting_summoner=true},
  channel=function(self,q)
   if self.profile.id=='normal'then return not self:IsImpaling()and not self:NormalCharging()end
  if self:IsImpaling()then return q.owner=='ImpaleActions'and(q.key==HK_Q or q.key==HK_W)end
  return not Core:SelfChanneling(true)
 end,
 validate=function(self,q,slot)
   if self.profile.id=='normal'then return not self:IsImpaling()and not self:NormalCharging()end
  if self:IsImpaling()then return q.owner=='ImpaleActions'and(slot==_Q or slot==_W)end
  if q.owner=='ImpaleActions'then return false end
  if q.owner=='LaneClear'or q.owner=='JungleClear'or q.owner=='FarmHarass'then return self:ManaAllowed(Menu.Clear)end
  return true
 end,
})

SkarnerChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Skarner"]="Skarner"}
local normalSupported={["Skarner"]=true}

local champion=classicSupported[myHero.charName]
if not champion and normalSupported[myHero.charName] then champion=myHero.charName end
if not champion then return end
if not SDK or not SDK.OrbamaVersion or not SDK.Actions or SDK.Actions.version~=1 then print('[AyyyyIO] Orbama Actions v1 required');return end
if _G.AyyyyIO and _G.AyyyyIO.active and not _G.AyyyyIO.loading then return _G.AyyyyIO.controller end
if not OrbamaPrediction then require('OrbamaPrediction') end
if not OrbamaPrediction then print('[AyyyyIOControllers] Prediction provider required');return end
local ctx=modules.core(_G,modules,champion)
if not ctx:Active() then return ctx end
modules.runtime(ctx.env,champion)
return ctx

end
