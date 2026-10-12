return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Ezreal"]=function()return _G.OrbamaFamily:Require("215406fd402aa96cfe2cd4f5e10286c70e2c1a6a37bff20eb7b02bd2e5ac8e3d")()end
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
modules.skillOrders=(function(require) return _G.OrbamaFamily:Factory("a8b0dae6f22e1be48bd91c9c82136f14fa6021bda02b48ebb89e55f2612db730")(require) end)(require)
modules.healthWindow=(function(require) return _G.OrbamaFamily:Factory("d533b0ef74c68b495c1d2541cc3e687ebd5a9d43ecc9bd9706750c9b1a16fec9")(require) end)(require)
modules.yunaraProfile=(function(require) return _G.OrbamaFamily:Factory("d0f8a7ede995c1c4ae39ff50186c21819723104154d9a4a209da8a785993462e")(require) end)(require)
modules.nautilusProfile=(function(require) return _G.OrbamaFamily:Factory("f730083274ce090a6b9cdaf348846a2fa53f89ad6c57c53a6c09767f82770c84")(require) end)(require)
modules["autojungle"]=_G.OrbamaFamily:Require("7db0b9586a77097bb64895183d25ea6bd8618bd61f03adb899ada4e460e84c92")
modules["combatMechanics"]=_G.OrbamaFamily:Require("9e32908504b1e01599ffc8a55f7d52a3a92a974d794c085ee29160c628b85e38")
modules["gameplay"]=_G.OrbamaFamily:Require("038c846d2b126f3f80142b2c55b4ace9ee78a9347b22cb2f242dcb5ed5185f2f")
modules["prediction"]=(function(require) return _G.OrbamaFamily:Factory("223a065ecf7929552d5f8dafcf2453fd9147cd6e9940ce97dc80add73aa9913b")(require) end)(require)
modules["policies"]=(function(require) return _G.OrbamaFamily:Factory("e26056d70e5dac93ebb21f4ae4fe96863a06915a942bb75b795567a932448a23")(require) end)(require)
modules["core"]=(function(require) return _G.OrbamaFamily:Factory("8b530b74e721ee3a7364f1f753e7578ef7c7843a7dcc77812a526d9dc96147b1")(require) end)(require)
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
Core.gameplay=modules.gameplay(env,Core,CombatMechanics)
if champion=="Ezreal" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Ezreal',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.03
-- Values and evidence: CombatProfiles/ezreal-provenance.json. No live certification.
local profiles=ChampionProfiles('Ezreal')


local function IsUnderAllyTurret(unit)
	for _, turret in ipairs(_G.SDK.ObjectManager:GetAllyTurrets()) do
		local range = (turret.boundingRadius + 750 + unit.boundingRadius / 2)
		if not turret.dead then 
			if turret.pos:DistanceTo(unit.pos) < range then
				return true
			end
		end
	end
	return false
end

local LastChatOpenTimer = 0

--------------------------------------

local EzrealChampion=class("EzrealChampion")

function EzrealChampion:__init()
	self.profile=assert(profiles[myHero.charName],"Unsupported Ezreal profile")
	print("AyyyyIO - Ezreal loaded")
	self:LoadMenu()
    _G.SDK.Orbwalker:OnPostAttack(function(args)
        local unit=args and args.Target or _G.SDK.Orbwalker.LastTarget
        if unit then self:TrackAATarget(unit) end
    end)
	Callback.Add("Draw", function() self:Draw() end)
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("WndMsg", function(msg, wParam) self:OnWndMsg(msg, wParam) end)
	_G.SDK.Orbwalker:OnPreAttack(function(...) self:OnPreAttack(...) end)
	self.QSpell = {Type = OrbamaPrediction.SPELLTYPE_LINE, Delay = 0.25, Radius = 60, Range = self.profile.qRange, Speed = 2000, Collision = true, CollisionTypes = {OrbamaPrediction.COLLISION_YASUOWALL, OrbamaPrediction.COLLISION_MINION, OrbamaPrediction.COLLISION_ENEMYHERO}}
	self.QSpell.DirectionalCast=true;self.QSpell.AimErrorWorld=5
	self.WSpell = {Type = OrbamaPrediction.SPELLTYPE_LINE, Delay = 0.25, Radius = self.profile.wRadius, Range = self.profile.wRange, Speed = self.profile.wSpeed, Collision = true, CollisionTypes = {OrbamaPrediction.COLLISION_YASUOWALL}}
	self.RSpell = {Type = OrbamaPrediction.SPELLTYPE_LINE, Delay = 1.00, Radius = 160, Range = 25000, Speed = 2000, Collision = true, CollisionTypes = {OrbamaPrediction.COLLISION_YASUOWALL}}
	self.RSpell.DirectionalCast=true;self.RSpell.AimErrorWorld=5
	self.recallCast={key=HK_R,spell=self.RSpell,damageFloor=.3,
		enabled=function()return Menu.Auto.BaseR:Value()end,safe=function()return self:RSafe()end,
		damage=function(unit)return self:GetRDmg(unit)end}
	if self.profile.marks then self.WSpell.CollisionTypes[#self.WSpell.CollisionTypes+1]=OrbamaPrediction.COLLISION_ENEMYHERO end
	self.lastQ = 0
	self.lastW = 0
	self.EHelper = nil
	self.LastE = 0
	self.lastQTarget = nil
	self.lastQExpire = 0
	self.lastAATarget = nil
	self.lastAAExpire = 0
	self.lastAAWillKill = false
	-- Evade judges the danger and asks for a blink; the landing limits stay here. A blink has no travel time.
	local p=self.profile
	if p.eCast and Core.RegisterMobility then
		self.mobilityOffered,self.mobilityReason=Core:RegisterMobility({kind='dash',slot=_E,key=HK_E,name=p.e,range=p.eRange,blink=true,toPoint=true,castDelays={p.eCast},
			profile=p.id,label='Arcane Shift',source=p.eSource,allowed=function(point)return self:EvadeBlinkAllowed(point)end})
	else self.mobilityReason='blink cast time not established for this profile'end
	Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
	-- The Q-poke toggle sits in the status strip next to Spell-Farm (its bind shown there), from its own
	-- status renderer so a failing drawing can never stale it; no text under the hero.
	local scope=Core.overlayScope
	if scope then scope:Renderer('ezreal-status',function()
		local poke=Menu.Auto.HarassQ
		scope:Set('autoq',{kind='status',feature='champion',anchor='hud',label='Auto-Q',enabled=poke:Value()==true,bind=poke.Key and poke:Key(),priority=100,expires=Game.Timer()+.2})
	end,4)end
end

function EzrealChampion:LoadMenu()
	local championIcon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/".."Ezreal.png"
	Menu = MenuElement({type = MENU, id = "Classic_AIO_"..myHero.charName, name='AyyyyIO - Ezreal', leftIcon = championIcon})
	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "SemiR", name = "Cast R at the selected target", key = string.byte("T")})
	Menu.Combo:MenuElement({id = "KillE", name = "Blink in with E to finish a killable enemy", value = false})
	Menu.Combo:MenuElement({id = "KillEHP", name = "That E only above health %", value = 40, min = 0, max = 100, step = 5, menu = false})

	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "Mana", name = "Only above mana %", value = 30, min = 0, max = 100, step = 5})

	Menu:MenuElement({type = MENU, id = "Clear", name = "Farming"})
	Menu.Clear:MenuElement({id = "SpellFarm", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(newValue)
		if CheckChatBlock(Menu.Clear.SpellFarm, newValue) then return end
	end})
	Menu.Clear:MenuElement({id = "SpellHarass", name = "Harass enemy champions while lane clearing", value = true})
	Menu.Clear:MenuElement({type = MENU, id = "LaneClear", name = "Lane clear"})
	Menu.Clear.LaneClear:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Clear.LaneClear:MenuElement({id = "QSpecial", name = "Use Q on enemy summons (plants, turrets)", toggle = true, value = true, menu = false})
	Menu.Clear.LaneClear:MenuElement({id = "Mana", name = "Q minions it does not kill only above mana %", value = 40, min = 0, max = 100, step = 5})
	Menu.Clear:MenuElement({type = MENU, id = "JungleClear", name = "Jungle clear"})
	Menu.Clear.JungleClear:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	-- Only the Normal W leaves a mark that an attack detonates.
	if self.profile.marks then
		Menu.Clear.LaneClear:MenuElement({id='WTurret',name='Use W on structures you attack',value=true})
		Menu.Clear.JungleClear:MenuElement({id='WObjective',name='Use W on epic monsters you attack',value=true})
	end

	Menu:MenuElement({type = MENU, id = "LastHit", name = "Last hit"})
	Menu.LastHit:MenuElement({id = "Q", name = "Use Q when an attack cannot last hit", toggle = true, value = true})

	Menu:MenuElement({type = MENU, id = "Flee", name = "Flee"})
	Menu.Flee:MenuElement({id = "E", name = "Use E toward the cursor", value = true})

	Menu:MenuElement({type = MENU, id = "EHelper", name = "E wall check"})
	Menu.EHelper:MenuElement({id = "Enable", name = "Refuse E into walls (rebind E in the game)", toggle = true, value = false})
	Menu.EHelper:MenuElement({id = "efake", name = "Key you press for E", value = false, key = string.byte("E"), fixedKey = true})
	Menu.EHelper:MenuElement({id = "elol", name = "Key E is bound to in the game", value = false, key = string.byte("U"), fixedKey = true})

	Menu:MenuElement({type = MENU, id = "Auto", name = "Without holding a mode key"})
	Menu.Auto:MenuElement({id = "RKill", name = "Finish killable enemies with R", toggle = true, value = true})
	Menu.Auto:MenuElement({id = "RCC", name = "R immobilised enemies", toggle = true, value = false})
	Menu.Auto:MenuElement({id='RRange',name='Those R casts only within distance',value=3000,min=500,max=25000,step=500,menu=false})
	Menu.Auto:MenuElement({id='BaseR',name='R recalling enemies at their base if it kills',value=true})
	Menu.Auto:MenuElement({id = "RAOE", name = "R when it hits several enemy champions", toggle = true, value = true})
	Menu.Auto:MenuElement({id = "RCount", name = "Enemy champions that R must hit", value = 3, min = 1, max = 5, step = 1})
	Menu.Auto:MenuElement({id='ControlQ',name='Q immobilised enemies',value=true})
	Menu.Auto:MenuElement({id='QMana',name='That Q only above mana %',value=40,min=0,max=100,step=5})
	Menu.Auto:MenuElement({id='HarassQ',name='Poke enemy champions with Q',toggle=true,value=true,key=string.byte('N'),callback=function(v)CheckChatBlock(Menu.Auto.HarassQ,v)end})
	Menu.Auto:MenuElement({id='HarassMana',name='Poke with Q only above mana %',value=50,min=0,max=100,step=5})
	Menu.Auto:MenuElement({id='BlockerCS',name='Combo: Q a killable minion blocking your Q',value=true,menu=false})
	Menu.Auto:MenuElement({id='GapE',name='Use E away from enemies who dash onto you',value=true})

	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "Q", name = "Q range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "W", name = "W range", toggle = true, value = false})
end

function EzrealChampion:OnPreAttack(args)
	local mode = GetMode()
	if mode == "LaneClear" then
		if self.lastQTarget and GetTickCount() < self.lastQExpire then
			if args.Target and args.Target.handle == self.lastQTarget then
				args.Process = false
				return
			end
		else
			self.lastQTarget = nil
		end
	end
end

local LastEFake = -math.huge
function EzrealChampion:OnWndMsg(msg,wParam)
    if wParam~=Menu.EHelper.efake:Key()then return end
    if msg==KEY_UP then self.eKeyHeld=false end
    if msg==KEY_DOWN and not self.eKeyHeld then
        self.eKeyHeld=true;LastEFake=os.clock();self.eAim=nil
        local input=_G.SDK.Input
        local point
        if input and input.GetPlayerPosition then point=input:GetPlayerPosition()
        elseif Core.adapter:Available()then point=mousePos end
        if point then self.eAim=Vector(point)end
    end
end

function EzrealChampion:OnEnemyHeroLoad(enemy)
	if enemy and ({Zyra=true,Heimerdinger=true,Malzahar=true,Shaco=true})[(enemy.charName or ''):gsub('^Jade_','')] then
		self.hasSpecialMinionEnemy = true
	end
end

function EzrealChampion:TrackAATarget(unit)
    if not IsValid(unit)then return end
    local witness=ObserveAttack(_G,self.attackWitness,function(id)
        if unit.handle==id or unit.networkID==id then return unit end
    end)
    if not witness or witness==self.attackWitness or witness.at>Game.Timer()then return end
    self.attackWitness=witness
    if unit.type~=Obj_AI_Hero and unit.type~=Obj_AI_Minion then self.lastAAWillKill=false;return end
    local speed=_G.SDK.Attack:GetProjectileSpeed()
    if type(speed)~='number'or speed<=0 then return end
    local remaining=math.max(0,witness.at-Game.Timer()+GetDistance(unit.pos,myHero.pos)/speed)
    self.lastAATarget=unit.handle
    self.lastAAExpire=GetTickCount()+(remaining+.10)*1000
    -- W can be consumed by another hit first. Only the launched AA is reserved.
    self.lastAAWillKill=self:CanMyAAKill(unit)
end

function EzrealChampion:Tick()
	if Game.IsChatOpen() then
		LastChatOpenTimer = GetTickCount()
	end
	self:PreferMarked()
	if ShouldWait() then return end
	if IsCasting() then return end
	if Core:RecallBaseCast(self.recallCast)then return end
	if Core.logger then self:ObserveQReach()end
	if self:GapE()or self:KillQ()or self:ControlQ()or self:ObjectiveW()then return end
	self:SemiR()
	self:AutoR()
	self:ELogic()
	local Mode = GetMode()
	if Mode == "Combo" then
		self:Combo()
	elseif Mode == "Harass" then
		self:Harass()
	elseif Mode == "LaneClear" then
		-- The spell-farm toggle governs every farming cast; harassing champions has its own switch.
		self:FarmHarass()
		if Menu.Clear.SpellFarm:Value() then
			if Core:FarmModeEnabled('lane')then self:ClearSpecialMinions();self:LaneClear()end
			if Core:FarmModeEnabled('jungle')then self:JungleClear()end
		end
	elseif Mode == "LastHit" then
		self:LastHit()
	elseif Mode == "Flee" then
		self:Flee()
	end
	self:AutoHarassQ()
end

-- Attack the enemy carrying the W mark: the attack sets it off for free. The shared preference is renewed while a
-- marked enemy stands in attack range and the mark outlasts the attack; the core never lets it replace the champion
-- the player selected and clears it on lapse, death and range loss.
function EzrealChampion:PreferMarked()
    local mode=GetMode()
    if self.profile.marks and(mode=='Combo'or mode=='Harass')then
        local enemies=Core:DecisionUnits('GetEnemyHeroes');local best
        for i=1,math.min(#enemies,10)do local unit=enemies[i]
            if IsValid(unit)and _G.SDK.Data:IsInAutoAttackRange(myHero,unit)then
                local impact=self:AttackImpact(unit);local expiry=impact and self:MarkUntil(unit)
                if expiry and expiry>Game.Timer()+impact and(not best or unit.health<best.health)then best=unit end
            end
        end
        if best and Core:PreferAttack('EzrealMark',best,.25)then return true end
    end
    Core:ReleaseAttackPreference('EzrealMark');return false
end

-- Seconds until a basic attack started now lands on the unit.
function EzrealChampion:AttackImpact(unit)
    local speed=_G.SDK.Attack:GetProjectileSpeed();local windup=_G.SDK.Attack:GetWindup()
    if type(speed)~='number'or speed~=speed or speed<=0 or type(windup)~='number'or windup~=windup or windup<0 then return nil end
    return windup+(speed==math.huge and 0 or GetDistance(unit.pos,myHero.pos)/speed)
end

-- A ready attack in range kills this enemy. withMark: the attack also sets off an own W mark that is still there
-- when it lands (magic damage, so the two parts meet their own shields).
function EzrealChampion:AttackKills(unit,withMark)
    if not IsValid(unit)or not _G.SDK.Data:IsInAutoAttackRange(myHero,unit)or not _G.SDK.Orbwalker:CanAttack()then return false end
    local impact=self:AttackImpact(unit);if not impact then return false end
    local attack=_G.SDK.Damage:GetAutoAttackDamage(myHero,unit)
    local expiry=withMark and self:MarkUntil(unit)
    if expiry and expiry>Game.Timer()+impact then
        local both=Core:MixedHealthEstimate(unit,impact,attack*.97,math.max(0,self:GetWDmg(unit)*.97-2))
        if both then return both.lethal==true end
    end
    return(Core:Lethal(unit,impact,attack,{kind='physical',protection=false}))
end

-- Q kills this champion on arrival; a Q that lands on an own W mark sets it off as well.
function EzrealChampion:QLethal(unit,point)
    if not IsValid(unit)or unit.type~=Obj_AI_Hero then return false end
    local impact=OrbamaPrediction:GetImpactTime(self.QSpell,point or unit.pos,myHero)
    if type(impact)~='number'or impact<0 then return false end
    local expiry=self:MarkUntil(unit)
    if expiry and expiry>Game.Timer()+impact and Core:SpellProtected(unit)==false then
        local both=Core:MixedHealthEstimate(unit,impact,self:GetQDmg(unit)*.97,math.max(0,self:GetWDmg(unit)*.97-2))
        if both then return both.lethal==true end
    end
    return(Core:Lethal(unit,impact,function()return self:GetQDmg(unit)end,{kind='physical'}))
end

-- A kill with a four-second ability is always taken; an attack that already kills keeps the Q.
function EzrealChampion:KillQ()
    if not IsReady(_Q)then return false end
    local unit=Core:LethalPick(Core:Rows('hero',self.QSpell.Range),function(v)return self:QLethal(v)end,
        function(v)return not self:AttackKills(v,true)and not self:WasMyRecentKillAATarget(v)end)
    return unit~=nil and self:CastQ(unit,function(q,resolved)return self:QLethal(unit,resolved and resolved.position or q.target)end,
        false,{owner='KillQ',context={priority='interactive'}})or false
end

-- Arcane Shift landing: known open ground inside the blink, no enemy turret, never next to more enemies than now.
function EzrealChampion:SafeBlink(point)
    local p=Core.point(point)
    if not p or GetDistance(p,myHero.pos)>self.profile.eRange+5 or type(Game.isWall)~='function'or Game.isWall(p)~=false then return false,'landing_unknown_or_wall'end
    if IsUnderTurret2(p)then return false,'enemy_turret'end
    if GetEnemyCount(500,p)>GetEnemyCount(500,myHero.pos)then return false,'enemies_at_landing'end
    return true
end

function EzrealChampion:EvadeBlinkAllowed(point)
    -- With the wall-check helper on, E is bound to another key in the game: the E key would cast nothing.
    if Menu.EHelper.Enable:Value()then return false,'e_rebound_for_wall_check'end
    if point==nil then return true end
    return self:SafeBlink(point)
end

function EzrealChampion:BlinkPoint(aim)
    if not aim or not(GetDistance(aim,myHero.pos)>50)then return nil end
    local p=myHero.pos:Extended(aim,self.profile.eRange)
    return self:SafeBlink(p)and p or nil
end

-- One full-length blink toward the point aimOf() names; the point is read again at dispatch.
function EzrealChampion:CastE(aimOf,owner,context,permission)
    if not IsReady(_E)or Menu.EHelper.Enable:Value()or not permission()then return false end
    local point=self:BlinkPoint(aimOf());if not point then return false end
    return Core:Cast(HK_E,point,{owner=owner,context=context,range=self.profile.eRange,independent=false,prevalidateWorldCast=true,
        resolve=function()local p=permission()and self:BlinkPoint(aimOf());return p and {position=p}or nil end,
        validate=function(q,resolved)return permission()and not Menu.EHelper.Enable:Value()and IsReady(_E)and self:SafeBlink(resolved and resolved.position or q.target)end})
end

function EzrealChampion:Flee()
    if not Menu.Flee.E:Value()then return false end
    return self:CastE(function()return mousePos end,'FleeE',Core:ModeContext('Flee'),function()return Menu.Flee.E:Value()and GetMode()=='Flee'end)
end

-- An enemy dash that ends next to Ezreal: blink away from where it lands. Seven
-- full-length landings (straight away, +-40, +-80, +-120 degrees), each through
-- SafeBlink, scored by distance from the dash end, enemies next to the landing
-- and Evade danger, the cursor as tie-break; re-scored at dispatch.
function EzrealChampion:Dangerous(point)
    local evade=_G.SDK.Evade
    if not evade or type(evade.GetDangerIntervals)~='function'then return false end
    local now=Game.Timer()
    local ok,result=pcall(evade.GetDangerIntervals,evade,point,now,now+.75,{radius=myHero.boundingRadius or 65,workBudget=500})
    if not ok or type(result)~='table'or type(result.intervals)~='table'then return false end
    for i=1,math.min(#result.intervals,16)do local span=result.intervals[i];if span and span.possible~=true then return true end end
    return false
end
function EzrealChampion:GapLanding(unit)
    local snapshot=IsValid(unit)and Core:ApproachingDash(unit,myHero.pos,250);if not snapshot then return nil end
    local origin=Vector(myHero.pos);local from=Vector(snapshot.to.x,origin.y,snapshot.to.z)
    if GetDistance(origin,from)<1 then from=Vector(unit.pos)end
    if GetDistance(origin,from)<1 then return nil end
    local away=(origin-from):Normalized();local best,score
    for _,degrees in ipairs({0,40,-40,80,-80,120,-120})do
        local r=math.rad(degrees);local c,s=math.cos(r),math.sin(r)
        local point=origin+Vector(away.x*c-away.z*s,0,away.x*s+away.z*c)*self.profile.eRange
        if self:SafeBlink(point)then
            local value=GetDistance(point,from)-300*GetEnemyCount(500,point)-(self:Dangerous(point)and 2000 or 0)
            if mousePos then value=value-.05*GetDistance(point,mousePos)end
            if not score or value>score then best,score=point,value end
        end
    end
    return best
end
function EzrealChampion:GapE()
    if not Menu.Auto.GapE:Value()or not IsReady(_E)or Menu.EHelper.Enable:Value()then return false end
    local enemies=Core:DecisionUnits('GetEnemyHeroes')
    for i=1,math.min(#enemies,10)do local unit=enemies[i]
        if IsValid(unit)and Core:ApproachingDash(unit,myHero.pos,250)then
            return self:CastE(function()return self:GapLanding(unit)end,'GapE',{priority='interactive'},
                function()return Menu.Auto.GapE:Value()and IsValid(unit)and Core:ApproachingDash(unit,myHero.pos,250)~=nil end)
        end
    end
    return false
end
-- Arcane Shift finisher (Combo, off by default): the homing bolt goes to the
-- nearest enemy unit within 750 of the landing (a W-marked one first), so the
-- target must be that unit; bolt plus a live owned mark that outlasts it must
-- kill (shared kill rule); the landing must be open ground outside enemy turrets
-- with no more other enemies next to it than next to Ezreal, and Ezreal above
-- the configured health.
function EzrealChampion:EDamage(unit)
    local p=self.profile;local base=p.eBase and p.eBase[myHero:GetSpellData(_E).level];if not base then return 0 end
    return _G.SDK.Damage:CalculateDamage(myHero,unit,_G.SDK.DAMAGE_TYPE_MAGICAL,
        base+p.eAD*(myHero.bonusDamage or 0)+p.eAP*(myHero.ap or 0),true,false)
end
function EzrealChampion:BoltTarget(landing)
    local best,bestDistance,marked,markedDistance
    for _,method in ipairs({'GetEnemyHeroes','GetEnemyMinions','GetMonsters'})do
        local list=Core:DecisionUnits(method)
        for i=1,math.min(#list,32)do local u=list[i]
            if IsValid(u)and u.team~=myHero.team then
                local d=GetDistance(u.pos,landing)
                if d<=self.profile.eBolt then
                    if not best or d<bestDistance then best,bestDistance=u,d end
                    if self.profile.marks and u.type==Obj_AI_Hero and self:MarkUntil(u)and(not marked or d<markedDistance)then marked,markedDistance=u,d end
                end
            end
        end
    end
    return marked or best
end
function EzrealChampion:KillLanding(target)
    if not IsValid(target)then return nil end
    local distance=GetDistance(target.pos,myHero.pos);if distance<1 then return nil end
    local p=myHero.pos:Extended(target.pos,math.min(self.profile.eRange,distance))
    if type(Game.isWall)~='function'or Game.isWall(p)~=false or IsUnderTurret2(p)then return nil end
    local function others(at)local n=0;local list=Core:DecisionUnits('GetEnemyHeroes')
        for i=1,math.min(#list,10)do local u=list[i];if u~=target and IsValid(u)and GetDistance(u.pos,at)<=500 then n=n+1 end end;return n end
    if others(p)>others(myHero.pos)then return nil end
    return p
end
function EzrealChampion:KillEAllowed(target)
    if not Menu.Combo.KillE:Value()or not IsReady(_E)or Menu.EHelper.Enable:Value()or not self.profile.eBase then return false,'off'end
    if not IsValid(target)or target.type~=Obj_AI_Hero then return false,'target'end
    if not(myHero.maxHealth>0)or myHero.health/myHero.maxHealth*100<Menu.Combo.KillEHP:Value()then return false,'own_health'end
    local landing=self:KillLanding(target);if not landing then return false,'landing'end
    local reach=GetDistance(landing,target.pos);if reach>self.profile.eBolt then return false,'bolt_reach'end
    if self:BoltTarget(landing)~=target then return false,'bolt_goes_elsewhere'end
    local impact=self.profile.eCast+reach/self.profile.eBoltSpeed
    local damage=self:EDamage(target)
    local expiry=self:MarkUntil(target)
    if expiry and expiry>Game.Timer()+impact then damage=damage+self:GetWDmg(target)end
    return Core:Lethal(target,impact,damage,{kind='magical'})
end
function EzrealChampion:KillE()
    if not Menu.Combo.KillE:Value()or not IsReady(_E)or Menu.EHelper.Enable:Value()then return false end
    local enemies=Core:Rows('hero',self.profile.eRange+self.profile.eBolt)
    for i=1,math.min(#enemies,5)do local unit=enemies[i]
        if self:KillEAllowed(unit)==true then
            local landing=self:KillLanding(unit)
            return Core:Cast(HK_E,landing,{owner='KillE',context=Core:ModeContext('Combo'),range=self.profile.eRange,independent=false,prevalidateWorldCast=true,
                resolve=function()local p=self:KillLanding(unit);return p and {position=p}or nil end,
                validate=function()return self:KillEAllowed(unit)==true end})
        end
    end
    return false
end

function EzrealChampion:ControlQ()
    if not Menu.Auto.ControlQ:Value()or not IsReady(_Q)or not Core.manaAbove(Menu.Auto.QMana:Value())then return false end
    local enemies=Core:DecisionUnits('GetEnemyHeroes')
    for i=1,math.min(#enemies,16)do local unit=enemies[i]
        if Core:ControlledHit(unit,self.QSpell)and self:CastQ(unit,function(q,resolved)
            return Menu.Auto.ControlQ:Value()and Core.manaAbove(Menu.Auto.QMana:Value())
                and Core:ControlledHit(unit,self.QSpell,resolved and resolved.position or q.target)
        end,false,{owner='ControlQ',context={priority='interactive',condition=function()return Menu.Auto.ControlQ:Value()end}})then return true end
    end
    return false
end

function EzrealChampion:BlockerCS(target)
    local mode=GetMode();local node=mode=='Combo'and Menu.Combo or mode=='Harass'and Menu.Harass
    if not node or not node.Q:Value()or not Menu.Auto.BlockerCS:Value()or not IsReady(_Q)or not IsValid(target)then return false end
    local pred=Core:Prediction(self.QSpell);pred:GetPrediction(target,myHero)
    if pred:CanHit(3)or pred.LastFailureReason~='collision'then return false end
    local blockers=pred.CollionableObjects
    if type(blockers)~='table'or #blockers>8 then return false end
    local best,distance
    for i=1,#blockers do local unit=blockers[i]
        if self:CanRescue(unit)then local d=GetDistanceSqr(unit.pos,myHero.pos)
            if not distance or d<distance then best,distance=unit,d end
        end
    end
    if not best then return false end
    return self:CastQ(best,function(q,resolved)
        return Menu.Auto.BlockerCS:Value()and node.Q:Value()and self:CanRescue(best,resolved and resolved.position or q.target)
    end,true,{owner='BlockerCS',context=Core:ModeContext(mode)})
end

function EzrealChampion:ObjectiveWAllowed(unit)
    if not self.profile.marks or GetMode()~='LaneClear'or not Menu.Clear.SpellFarm:Value()or not IsValid(unit)then return false end
    local jungle=unit.type==Obj_AI_Minion and unit.team==300
    if jungle then
        local name=(unit.charName or ''):lower()
        if not(name=='sru_baron'or name=='sru_riftherald'or name=='sru_dragon'or name:match('^sru_dragon_[a-z]+$')
            or name=='sru_horde'or name:match('^sru_atakhan[a-z_]*$'))then return false end
        if not Core:FarmModeEnabled('jungle')or not Menu.Clear.JungleClear.WObjective:Value()then return false end
    -- The mark sticks to structures: turrets, inhibitors and the nexus share the one switch.
    elseif unit.type==(Obj_AI_Turret or 'AITurretClient')or Obj_AI_Barracks~=nil and unit.type==Obj_AI_Barracks or Obj_AI_Nexus~=nil and unit.type==Obj_AI_Nexus then
        if unit.team==myHero.team or not Core:FarmModeEnabled('lane')or not Menu.Clear.LaneClear.WTurret:Value()then return false end
    else return false end
    local witness=self.attackWitness
    if not witness or witness.object~=unit or witness.target~=unit.networkID and witness.target~=unit.handle
        or witness.at>Game.Timer()or Game.Timer()-witness.at>.5 then return false end
    local period=_G.SDK.Attack:GetAnimation()
    local impact=OrbamaPrediction:GetImpactTime(self.WSpell,unit.pos,myHero)
    return type(period)=='number'and period>0 and type(impact)=='number'and impact>=0 and period+impact+.25<4
        and _G.SDK.Data:IsInAutoAttackRange(myHero,unit)and not self:MarkUntil(unit)
end

function EzrealChampion:ObjectiveW()
    if not self.profile.marks or not IsReady(_W)then return false end
    local unit=self.attackWitness and self.attackWitness.object
    if not self:ObjectiveWAllowed(unit)then return false end
    return self:CastW(unit,{owner='ObjectiveW',context=Core:ModeContext('LaneClear'),deferAttackWindup=true,
        validate=function()return self:ObjectiveWAllowed(unit)end})
end

function EzrealChampion:SemiR()
	if Menu.Combo.SemiR:Value() and IsReady(_R) then
		local target = GetTarget(self.RSpell.Range)
		if IsValid(target) then
			self:CastR(target)
		end
	end
end

function EzrealChampion:Combo()
	local target = self:PreferredTarget(self.QSpell.Range)
	if not IsValid(target)then
		if Menu.Combo.Q:Value()and IsReady(_Q)then local hidden=Core:SkillshotTarget(self.QSpell,3);if hidden then self:CastQ(hidden)end end
		return
	end
	if self:KillE()then return end
	if IsValid(target) then
		if Menu.Combo.W:Value() and IsReady(_W) then
			if self:CastW(target,{ready=self:WeaveGate(target)})and self.profile.marks then return end
		end
		if Menu.Combo.Q:Value() and IsReady(_Q) then
			-- The attack that sets off an own W mark counts with the mark's damage.
			local canKillWithAA = self:AttackKills(target,true)
			local aaWillKillTarget = self:WasMyRecentKillAATarget(target)
        	if not canKillWithAA and not aaWillKillTarget then
				if not self:CastQ(target,nil,false,self:WeaveOptions(target))then self:BlockerCS(target)end
			end
		end
	end
end
-- Weaving (GGAIO, TRUSt, Auto): Q and W go into the attack cooldown. With the
-- target inside attack reach, an attack winding up or ready to start holds the
-- request (deadline unchanged) until the attack has gone; a lethal Q, a target
-- leaving reach or an out-of-reach target do not wait.
function EzrealChampion:Leaving(target)
    local path=target.pathing
    if not path or path.hasMovePath~=true or not target.posTo then return false end
    if GetDistanceSqr(target.posTo,myHero.pos)<=GetDistanceSqr(target.pos,myHero.pos)then return false end
    local reach=_G.SDK.Data:GetAutoAttackRange(myHero,target);local windup=_G.SDK.Attack:GetWindup()
    if not Core.finite(reach)or not Core.finite(windup)then return true end
    return GetDistance(target.pos,myHero.pos)+(target.ms or 0)*windup>reach
end
function EzrealChampion:WeaveGate(target)
    return function()
        if Core:AttackWindupRemaining()>0 then return false end
        if not IsValid(target)or target.type~=Obj_AI_Hero or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)or self:Leaving(target)then return true end
        local readyIn=Core:AttackReadyIn()
        return readyIn==nil or readyIn>0
    end
end
-- Q then one attack (Ezreal-3): casting Q primes Spellblade (C:SpellbladeBonus: Sheen family, 0 while already
-- primed or on its item cooldown). Whether Q itself or the next attack spends it is unmeasured, but either way the
-- pair deals Q + one attack + one proc. Lethal when that kills a champion inside attack range by the attack's
-- landing (current health and every shield, attack-only dodges refused); such a Q is not held for weaving.
function EzrealChampion:QAttackLethal(target)
    if not IsValid(target)or target.type~=Obj_AI_Hero or not IsReady(_Q)or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return false end
    local ready=Core:AttackReadyIn();local attack=self:AttackImpact(target)
    local q=OrbamaPrediction:GetImpactTime(self.QSpell,target.pos,myHero)
    if not Core.finite(ready)or not attack or not Core.finite(q)or q<0 then return false end
    local aa=_G.SDK.Damage:GetAutoAttackDamage(myHero,target)
    if not Core.finite(aa)or aa<=0 then return false end
    local impact=math.max(q,math.max(ready,self.QSpell.Delay)+attack)
    return(Core:Lethal(target,impact,self:GetQDmg(target)+aa+Core:SpellbladeBonus(target),{attack=true}))
end
function EzrealChampion:WeaveOptions(target)
    if not IsValid(target)or target.type~=Obj_AI_Hero or self:QLethal(target)or self:QAttackLethal(target)then return nil end
    return {ready=self:WeaveGate(target)}
end
-- Keyless Q poke (GGAIO, KillerEzreal, SeriesV2 ship it): outside Combo and
-- Harass, above its mana limit, never from under an enemy turret, after any
-- farming Q of this tick, below the finisher and crowd-control Q.
function EzrealChampion:AutoHarassQ()
    if not Menu.Auto.HarassQ:Value()or not IsReady(_Q)or Core.pending[HK_Q]then return false end
    local mode=GetMode();if mode=='Combo'or mode=='Harass'then return false end
    if not Core.manaAbove(Menu.Auto.HarassMana:Value())or IsUnderTurret(myHero)then return false end
    local target=self:PreferredTarget(self.QSpell.Range);if not IsValid(target)or target.type~=Obj_AI_Hero then return false end
    local options=self:WeaveOptions(target)or {}
    options.owner='AutoHarassQ';options.context={priority='normal',condition=function()return Menu.Auto.HarassQ:Value()end}
    return self:CastQ(target,function()return Menu.Auto.HarassQ:Value()and Core.manaAbove(Menu.Auto.HarassMana:Value())and not IsUnderTurret(myHero)end,false,options)
end

function EzrealChampion:Harass()
    if not Core.manaAbove(Menu.Harass.Mana:Value())then return end
    if self.profile.marks and Menu.Harass.W:Value()and IsReady(_W)then
        local target=self:PreferredTarget(self.WSpell.Range)
        if IsValid(target)and self:CastW(target,{ready=self:WeaveGate(target)})then return end
    end
	local target = self:PreferredTarget(self.QSpell.Range)
	if not IsValid(target)then
		if Menu.Harass.Q:Value()and IsReady(_Q)then local hidden=Core:SkillshotTarget(self.QSpell,3);if hidden then self:CastQ(hidden)end end
		return
	end
	if Menu.Harass.Q:Value() and IsReady(_Q) then
		if not self:CastQ(target,nil,false,self:WeaveOptions(target))then self:BlockerCS(target)end
	end
	if Menu.Harass.W:Value() and IsReady(_W) then
		self:CastW(target,{ready=self:WeaveGate(target)})
	end
end

function EzrealChampion:FarmHarass()
	if not Core:FarmModeEnabled('lane')or IsUnderTurret(myHero) then return end
	if Menu.Clear.SpellHarass:Value() then
		self:Harass()
	end
end

function EzrealChampion:LaneClear()
    if not Core:FarmModeEnabled('lane')or not IsReady(_Q)or not Menu.Clear.SpellFarm:Value()or not Menu.Clear.LaneClear.Q:Value()then return end
    local units=Core:DecisionUnits('GetEnemyMinions');local candidates={}
    for i=1,math.min(#units,32)do
        local unit=units[i]
        if IsValid(unit)and unit.team~=300 and unit.pos2D.onScreen and GetDistance(unit.pos,myHero.pos)<=self.QSpell.Range
            and not self:WasMyRecentAATarget(unit)then candidates[#candidates+1]=unit end
    end
    -- Cannon and super minions first (most gold), then the nearest.
    local function cannon(u)local n=(u.charName or ''):lower();return n:find('siege',1,true)~=nil or n:find('super',1,true)~=nil end
    table.sort(candidates,function(a,b)
        local ca,cb=cannon(a),cannon(b)
        if ca~=cb then return ca end
        return GetDistanceSqr(a.pos,myHero.pos)<GetDistanceSqr(b.pos,myHero.pos)
    end)
    local soften
    for _,unit in ipairs(candidates)do
        local hp=_G.SDK.HealthPrediction:GetPrediction(unit,self.QSpell.Delay+GetDistance(unit.pos,myHero.pos)/self.QSpell.Speed)
        if hp>0 and hp<=self:GetQDmg(unit)then
            if self:CastQ(unit,function(q,resolved)
                local p=resolved and resolved.position or q.target
                local current=_G.SDK.HealthPrediction:GetPrediction(unit,self.QSpell.Delay+GetDistance(p,myHero.pos)/self.QSpell.Speed)
                return not self:WasMyRecentAATarget(unit)and current>0 and current<=self:GetQDmg(unit)
            end,true)then return end
        elseif not soften and hp>self:GetQDmg(unit)and not (unit.charName or ''):find('Siege')and not IsUnderAllyTurret(unit)then soften=unit end
    end
    if soften and self:SoftenAllowed()then self:CastQ(soften,function()
        return self:SoftenAllowed()and not self:WasMyRecentAATarget(soften)and not IsUnderAllyTurret(soften)
            and _G.SDK.HealthPrediction:GetPrediction(soften,self.QSpell.Delay+GetDistance(soften.pos,myHero.pos)/self.QSpell.Speed)>0
    end)end
end
-- A Q that does not kill is spent only above the lane mana limit, and never
-- when it would leave less than Q + W with an enemy champion within 1200.
function EzrealChampion:SoftenAllowed()
    if not Core.manaAbove(Menu.Clear.LaneClear.Mana:Value())then return false end
    local q=myHero:GetSpellData(_Q).mana or 0;local w=myHero:GetSpellData(_W).mana or 0
    return myHero.mana>=q+w or GetEnemyCount(1200,myHero.pos)==0
end

function EzrealChampion:ClearSpecialMinions()
    if not Core:FarmModeEnabled('lane')or not IsReady(_Q)or not Menu.Clear.SpellFarm:Value()or not Menu.Clear.LaneClear.QSpecial:Value()then return end
    local units=Core:DecisionUnits('GetPlants')
    for i=1,math.min(#units,16)do
        local unit=units[i]
        if IsValid(unit)and unit.team~=myHero.team and unit.team~=300 and unit.pos2D.onScreen
            and self:CastQ(unit,function()return Menu.Clear.SpellFarm:Value()and Menu.Clear.LaneClear.QSpecial:Value()end)then return end
    end
end

function EzrealChampion:JungleClear()
    if not Core:FarmModeEnabled('jungle')or not Menu.Clear.SpellFarm:Value()or not Menu.Clear.JungleClear.Q:Value()or not IsReady(_Q)then return end
    local units=Core:DecisionUnits('GetMonsters');local candidates={}
    for i=1,math.min(#units,24)do
        local unit=units[i]
        if IsValid(unit)and unit.team==300 and unit.pos2D.onScreen and GetDistance(unit.pos,myHero.pos)<=800 then candidates[#candidates+1]=unit end
    end
    table.sort(candidates,function(a,b)return a.maxHealth>b.maxHealth end)
    for _,unit in ipairs(candidates)do if self:CastQ(unit)then return end end
end

function EzrealChampion:CanRescue(unit,point)
    if not Menu.LastHit.Q:Value()or not IsReady(_Q)or not IsValid(unit)or unit.type~=Obj_AI_Minion or unit.team==300
        or self:WasMyRecentKillAATarget(unit)then return false end
    local distance=GetDistance(point or unit.pos,myHero.pos)
    if distance>self.QSpell.Range or _G.SDK.Attack:IsActive()then return false end
    local arrival=OrbamaPrediction:GetImpactTime(self.QSpell,point or unit.pos,myHero)
    local hp=_G.SDK.HealthPrediction:GetPrediction(unit,arrival);local damage=self:GetQDmg(unit)
    if hp<=0 or hp>damage or unit.health+(unit.shieldAD or 0)+math.max(0,unit.hpRegen or 0)*arrival>damage then return false end
    if _G.SDK.Data:IsInAutoAttackRange(myHero,unit)and _G.SDK.Orbwalker:CanAttack()then
        local speed=_G.SDK.Attack:GetProjectileSpeed();if type(speed)~='number'or speed<=0 then return false end
        local aaTime=_G.SDK.Attack:GetWindup()+distance/speed;local aaHP=_G.SDK.HealthPrediction:GetPrediction(unit,aaTime)
        if aaHP>0 and aaHP<=_G.SDK.Damage:GetAutoAttackDamage(myHero,unit)then return false end
    end
    return true
end

function EzrealChampion:LastHit()
    if GetMode()~='LastHit'and not Core:FarmModeEnabled('lane')then return end
    if not Menu.LastHit.Q:Value()or not IsReady(_Q)then return end
    local minions=Core:DecisionUnits('GetEnemyMinions');local candidates={}
    for i=1,math.min(#minions,32)do if self:CanRescue(minions[i])then candidates[#candidates+1]=minions[i]end end
    table.sort(candidates,function(a,b)return a.maxHealth>b.maxHealth end)
    for _,unit in ipairs(candidates)do
        if self:CastQ(unit,function(q,resolved)return self:CanRescue(unit,resolved and resolved.position or q.target)end,true)then return end
    end
end

function EzrealChampion:RSafe()
    return GetEnemyCount(800,myHero.pos)==0
end

function EzrealChampion:RLethal(unit,point)
    if not IsValid(unit)or IsInvulnerable(unit)then return false end
    local time=OrbamaPrediction:GetImpactTime(self.RSpell,point or unit.pos,myHero)
    -- Classic attenuation lacks a live hit-order witness. Use its asset minimum.
    local damage=self:GetRDmg(unit)*(self.profile.id=='classic'and .3 or 1)
    return not HaveBuff(unit,'sionpassivezombie')and damage>unit.health+(unit.shieldAP or 0)+math.max(0,unit.hpRegen or 0)*time
        and GetDistance(unit.pos,myHero.pos)>self.QSpell.Range and GetAllyCount(500,unit.pos)==0 and self.lastQ+600<GetTickCount()
end

function EzrealChampion:AutoR()
    if not IsReady(_R)or not self:RSafe()then return end
    local enemies=Core:DecisionUnits('GetEnemyHeroes')
    for i=1,math.min(#enemies,10)do
        local enemy=enemies[i]
        if IsValid(enemy)and GetDistance(enemy.pos,myHero.pos)<=Menu.Auto.RRange:Value()then
            if Menu.Auto.RCC:Value()and Core:ControlledHit(enemy,self.RSpell)then
                if self:CastR(enemy,function(q,resolved)return Menu.Auto.RCC:Value()and self:RSafe()
                    and GetDistance(enemy.pos,myHero.pos)<=Menu.Auto.RRange:Value()
                    and Core:ControlledHit(enemy,self.RSpell,resolved and resolved.position or q.target)end)then return end
            end
            if Menu.Auto.RKill:Value()and self:RLethal(enemy)then
                if self:CastR(enemy,function(q,resolved)return Menu.Auto.RKill:Value()and self:RSafe()
                    and GetDistance(enemy.pos,myHero.pos)<=Menu.Auto.RRange:Value()
                    and self:RLethal(enemy,resolved and resolved.position or q.target)end)then return end
            end
        end
    end
    if not Menu.Auto.RAOE:Value()then return end
    local results=Core:Prediction(self.RSpell):GetAOEPrediction(myHero);local best
    for _,row in ipairs(results)do
        if row.Unit and row.Count>=Menu.Auto.RCount:Value()and Vector(row.CastPosition):To2D().onScreen
            and GetDistance(row.CastPosition,myHero.pos)<=3000 and(not best or row.Count>best.Count)then best=row end
    end
    if best then return Core:Cast(HK_R,best.CastPosition,{range=3000,prevalidateWorldCast=true,
        validate=function(q,resolved)
            local data=resolved and resolved.data
            return Menu.Auto.RAOE:Value()and self:RSafe()and data and data.targetID==q.targetID
                and type(data.count)=='number'and data.count>=Menu.Auto.RCount:Value()
        end})end
end

function EzrealChampion:WasMyRecentAATarget(unit)
	return IsValid(unit) and self.lastAATarget == unit.handle and GetTickCount() <= self.lastAAExpire
end

function EzrealChampion:WasMyRecentKillAATarget(unit)
	return self:WasMyRecentAATarget(unit) and self.lastAAWillKill
end

function EzrealChampion:CanMyAAKill(unit)
    if not IsValid(unit)then return false end
    return _G.SDK.Damage:GetAutoAttackDamage(myHero,unit)>=unit.health+(unit.shieldAD or 0)+(unit.hpRegen or 0)
end

function EzrealChampion:GetQDmg(unit)
    local base=self.profile.qBase[myHero:GetSpellData(_Q).level]
    if not base then return 0 end
    return _G.SDK.Damage:CalculateDamage(myHero,unit,_G.SDK.DAMAGE_TYPE_PHYSICAL,
        base+self.profile.qAD*myHero.totalDamage+self.profile.qAP*myHero.ap,true,false)
end

function EzrealChampion:GetWDmg(unit)
    local base=self.profile.wBase[myHero:GetSpellData(_W).level]
    if not base then return 0 end
    return _G.SDK.Damage:CalculateDamage(myHero,unit,_G.SDK.DAMAGE_TYPE_MAGICAL,
        base+self.profile.wAP*myHero.ap+self.profile.wAD*(myHero.bonusDamage or 0),true,false)
end

function EzrealChampion:GetRDmg(unit)
    local base=self.profile.rBase[myHero:GetSpellData(_R).level]
    if not base then return 0 end
    return _G.SDK.Damage:CalculateDamage(myHero,unit,_G.SDK.DAMAGE_TYPE_MAGICAL,
        base+self.profile.rAP*myHero.ap+self.profile.rAD*(myHero.bonusDamage or 0),true,false)
end

function EzrealChampion:CastQ(unit,validate,reserve,options)
    if not Core:SkillshotCurrent(unit)or unit.visible~=false and GetDistance(unit.pos,myHero.pos)>self.QSpell.Range then return false end
    if unit.visible~=false and self.profile.marks and unit.type==Obj_AI_Hero and self.awaitingW and self.awaitingW.target==unit.networkID
        and Game.Timer()<self.awaitingW.expires and not self:MarkUntil(unit)and self:GetQDmg(unit)<unit.health+(unit.shieldAD or 0)then return false end
    local prediction=Core:Prediction(self.QSpell);prediction:GetPrediction(unit,myHero)
    options=options or {}
    if not prediction:CanHit(unit.type==Obj_AI_Hero and 3 or 2)then
        if prediction.LastFailureReason=='collision'then return self:CastEdgeQ(unit,validate,reserve,options,prediction)end
        return false
    end
    options.prevalidateWorldCast=true;options.validate=validate
    local accepted=Core:Cast(HK_Q,prediction.CastPosition,options)
    if accepted then self:AfterQ(unit,reserve)end
    return accepted
end
function EzrealChampion:AfterQ(unit,reserve)
    Core:AfterCast(HK_Q,function(q)
        self.lastQ=GetTickCount()
        if reserve then self.lastQTarget=unit.handle;self.lastQExpire=GetTickCount()+(self.QSpell.Delay+GetDistance(unit.pos,myHero.pos)/self.QSpell.Speed+.1)*1000 end
        if Core.logger and not q.ambiguous and IsValid(unit)then
            local d=GetDistance(unit.pos,myHero.pos)
            self.reachProbe={unit=unit,health=unit.health,distance=d,at=Game.Timer()+self.QSpell.Delay+d/self.QSpell.Speed+.2}
        end
    end)
end
-- Development measurement for the Q reach (1150 kept; wiki and asset castRange
-- say 1200): the target distance at the cast and the health it lost on arrival.
function EzrealChampion:ObserveQReach()
    local probe=self.reachProbe;if not probe or Game.Timer()<probe.at then return end
    self.reachProbe=nil
    Core:Trace('ezreal_q_reach',{profile=self.profile.id,range=self.QSpell.Range,distance=math.floor(probe.distance),
        lost=IsValid(probe.unit)and math.floor(probe.health-probe.unit.health)or nil,hero=probe.unit.type==Obj_AI_Hero})
end
-- Edge aim (KillerEzreal): exactly one unit blocks the predicted ray, so aim up
-- to (Q radius + target radius - 5) to the side; an aim counts only when the
-- same collision query proves the whole outgoing ray clear. Standing targets
-- only; the resolver recomputes it from fresh positions.
function EzrealChampion:EdgeAim(unit,center)
    if not IsValid(unit)then return nil end
    local path=unit.pathing
    if not path or path.hasMovePath==true or path.isDashing==true then return nil end
    center=Vector(center or unit.pos);local origin=Vector(myHero.pos)
    local d=GetDistance(center,origin);if d<1 or d>self.QSpell.Range then return nil end
    local dir=(center-origin):Normalized();local side=Vector(-dir.z,0,dir.x)
    local reach=self.QSpell.Radius+(unit.boundingRadius or 0)-5;if reach<=0 then return nil end
    for _,f in ipairs({1,-1,.5,-.5})do
        local aim=center+side*(reach*f)
        if GetDistance(aim,origin)<=self.QSpell.Range then
            local wall,_,count=OrbamaPrediction:GetCollision(origin,aim,self.QSpell.Speed,self.QSpell.Delay,self.QSpell.Radius,self.QSpell.CollisionTypes,unit.networkID)
            if not wall and count==0 then return aim end
        end
    end
end
function EzrealChampion:CastEdgeQ(unit,validate,reserve,options,prediction)
    local blockers=prediction and prediction.CollionableObjects
    if type(blockers)=='table'and #blockers~=1 then return false end
    local aim=self:EdgeAim(unit,prediction and prediction.UnitPosition);if not aim then return false end
    options.prevalidateWorldCast=true;options.intentTarget=unit;options.validate=validate
    options.resolve=function()local fresh=self:EdgeAim(unit);return fresh and {position=fresh}or nil end
    local accepted=Core:Cast(HK_Q,aim,options)
    if accepted then self:AfterQ(unit,reserve)end
    return accepted
end
-- Health-bar combo (S9): two attacks, a ready Q, a ready W (Normal: set off by
-- that Q or an attack) and a ready E bolt. Partial: R, items.
function EzrealChampion:ComboDamage(u)
    local aa=_G.SDK.Damage:GetAutoAttackDamage(myHero,u)
    if not Core.finite(aa)or aa<0 then aa=0 end
    local damage=2*aa
    if IsReady(_Q)then damage=damage+self:GetQDmg(u)end
    if IsReady(_W)then damage=damage+self:GetWDmg(u)end
    if IsReady(_E)then damage=damage+self:EDamage(u)end
    -- One Spellblade proc, primed by any ready spell.
    if aa>0 and(IsReady(_Q)or IsReady(_W)or IsReady(_E))then damage=damage+Core:SpellbladeBonus(u)end
    return damage,true
end

function EzrealChampion:MarkUntil(unit)
    if not self.profile.marks or not IsValid(unit)then return nil end
    for _,buff in ipairs(GetBuffs(unit))do
        local expiry=Core.buffExpiry(buff)
        if (buff.name or ''):lower()=='ezrealwattach'and buff.count and buff.count>0
            and Core.mine(buff.source)and type(expiry)=='number'and expiry>Game.Timer()then return expiry end
    end
end

function EzrealChampion:PreferredTarget(range)
    local target=GetTarget(range)
    if not self.profile.marks or not IsValid(target)or IsValid(_G.SDK.TargetSelector.Selected)then return target end
    local marked={};local enemies=Core:DecisionUnits('GetEnemyHeroes')
    for i=1,math.min(#enemies,10)do
        local unit=enemies[i];local expiry=self:MarkUntil(unit)
        if expiry and GetDistance(unit.pos,myHero.pos)<=range
            and expiry>Game.Timer()+self.QSpell.Delay+GetDistance(unit.pos,myHero.pos)/self.QSpell.Speed then marked[#marked+1]=unit end
    end
    return #marked>0 and _G.SDK.TargetSelector:GetTarget(marked,_G.SDK.DAMAGE_TYPE_PHYSICAL)or target
end

function EzrealChampion:CanFollowW(unit)
    if not self.profile.marks then return unit.type~=Obj_AI_Hero or not self:AttackKills(unit)end
    if unit.type~=Obj_AI_Hero then return self:ObjectiveWAllowed(unit)end
    if self:MarkUntil(unit)then return false end
    local cost=myHero:GetSpellData(_W).mana or 0
    -- W is wasted on an enemy that one attack or one clear Q already kills.
    if self:AttackKills(unit)then return false end
    if _G.SDK.Data:IsInAutoAttackRange(myHero,unit)and _G.SDK.Orbwalker:CanAttack()then return myHero.mana>=cost end
    local mode=GetMode();local allowQ=mode=='Combo'and Menu.Combo.Q:Value()or mode~='Combo'and Menu.Harass.Q:Value()
    if not allowQ or not IsReady(_Q)or myHero.mana<cost+(myHero:GetSpellData(_Q).mana or 0)then return false end
    local pred=Core:Prediction(self.QSpell);pred:GetPrediction(unit,myHero)
    return pred:CanHit(3)and not self:QLethal(unit,pred.CastPosition)
end

function EzrealChampion:CastW(unit,options)
    if not IsValid(unit)or GetDistance(unit.pos,myHero.pos)>self.WSpell.Range or not self:CanFollowW(unit)then return false end
    local prediction=Core:Prediction(self.WSpell);prediction:GetPrediction(unit,myHero)
    if not prediction:CanHit(unit.type==Obj_AI_Hero and 3 or 2)then return false end
    options=options or {};local permission=options.validate;options.prevalidateWorldCast=true
    options.validate=function(q,resolved)return self:CanFollowW(unit)and(not permission or permission(q,resolved))end
    local accepted=Core:Cast(HK_W,prediction.CastPosition,options)
    if accepted then Core:AfterCast(HK_W,function()
        self.lastW=GetTickCount()
        if self.profile.marks then self.awaitingW={target=unit.networkID,expires=Game.Timer()+self.WSpell.Delay+GetDistance(unit.pos,myHero.pos)/self.WSpell.Speed+.15}end
    end)end
    return accepted
end

function EzrealChampion:CastR(unit,validate)
    local prediction=Core:Prediction(self.RSpell);prediction:GetPrediction(unit,myHero)
    if prediction:CanHit(3)then return Core:Cast(HK_R,prediction.CastPosition,{prevalidateWorldCast=true,range=self.RSpell.Range,validate=validate})end
    return false
end

function EzrealChampion:ELogic()
    if not Menu.EHelper.Enable:Value()or not Control.IsKeyDown(Menu.EHelper.efake:Key())or ShouldWait()then self.EHelper=nil;return end
    local timer=GetTickCount()
    if os.clock()>=LastEFake+.5 or self.eAttempt==LastEFake or not IsReady(_E)or Control.IsKeyDown(HK_LUS)
        or timer<self.LastE+1000 or timer<LastChatOpenTimer+1000 or timer<LevelUpKeyTimer+1000 then return end
    if not self.eAim then return end
    -- Snapshot logical aim on the key edge, before queued synthetic positioning.
    local endpoint=Vector(self.eAim);local distance=GetDistance(endpoint,myHero.pos)
    if distance<=0 then return end
    if distance>475 then endpoint=myHero.pos:Extended(endpoint,475)end
    if not Game.isWall or Game.isWall(endpoint)~=false then return end
    local key=Menu.EHelper.elol:Key();local edge=LastEFake
    local remaining=math.floor((edge+.5-os.clock())*1000)
    if remaining<=0 then return end
    local accepted=Core:Cast(key,endpoint,{slot=_E,owner='EHelper',range=475,ttl=math.min(250,remaining),independent=false,
        validate=function(q,resolved)
            local point=Vector(resolved and resolved.position or q.target)
            return os.clock()<edge+.5 and Menu.EHelper.Enable:Value()and Control.IsKeyDown(Menu.EHelper.efake:Key())
                and Menu.EHelper.elol:Key()==key and Game.isWall and Game.isWall(point)==false
        end})
    if accepted then self.eAttempt=edge;Core:AfterCast(key,function()self.LastE=GetTickCount()end)end
end

function EzrealChampion:RegisterGuide(guide,settings)
    local nodes={comboQ={node=Menu.Combo.Q,label='Combo Q'},comboW={node=Menu.Combo.W,label='Combo W'},
        harassQ={node=Menu.Harass.Q,label='Harass Q'},harassW={node=Menu.Harass.W,label='Harass W'},
        farm={node=Menu.Clear.SpellFarm,label='Spell farming'},farmHarass={node=Menu.Clear.SpellHarass,label='Clear harass'},
        lastHit={node=Menu.LastHit.Q,label='Last Hit Q'},helper={node=Menu.EHelper.Enable,label='E helper'},
        rCC={node=Menu.Auto.RCC,label='R against crowd control'},rKill={node=Menu.Auto.RKill,label='Lethal R'},rAOE={node=Menu.Auto.RAOE,label='R multi-hit'}}
    local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
    return guide:Register('champion',{'Ezreal: quick start','Ezreal: Q and W','Ezreal: E and R'},function(page)
        if page==1 then return {title=self.profile.id=='classic'and 'Classic Ezreal'or 'Ezreal',subtitle='Use the provider mode keys. Release a mode to cancel waiting work.',cards={
            {'COMBAT','Combo: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..'. [[comboQ]] and [[comboW]] have separate permissions. Harass: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..' with [[harassQ]] and [[harassW]].'},
            {'CLEAR','Clear: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..'. [[farm]] permits lane Q and jungle Q. [[farmHarass]] permits combat spells during Clear, above the Harass mana limit. Lane Clear may soften minions; Last Hit only rescues kills.'},
            {'LAST HIT','Last Hit: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT)..' with [[lastHit]]. An in-range minion can receive Q when a ready lethal attack cannot secure it. Confirmed incoming lethal damage cancels rescue.'}},note='Q collision and target validity are refreshed before send. A queued cast is not a hit.'}end
        if page==2 then return {title='Q timing and Essence Flux',subtitle=self.profile.marks and 'Normal uses live owned W marks.'or 'Classic W is a separate direct-damage spell.',cards={
            {'ATTACKS','Only a native attack witness after windup creates an incoming-attack reservation. PreAttack permission and stale attackData do not. A Q reservation starts after spell-state observation, then expires after its estimated flight.'},
            {'TARGETS',self.profile.marks and 'Q can prefer a live owned W mark that lasts through its estimated arrival. Your valid selected target takes precedence. W requires attack reach or a ready, affordable Q with a clear predicted ray.'or 'Classic Q uses 1100 range and its own damage values. Modern W mark preference and detonation assumptions are disabled.'},
            {'ASSISTANCE','Automatic Q uses the common CC hit window. Optional blocker CS rescues a lethal minion blocking a held combat Q, with a free-attack comparison. Normal Clear W has its own switches for observed turret and epic-monster attacks with an achievable follow-up; it never starts an objective.'},
            {'EVIDENCE',self.profile.marks and 'Sending W does not prove attachment. Only a live owned mark that outlasts the hit adds its damage to an attack or Q kill check; in Combo and Harass the marked enemy in attack range is attacked first unless you selected another champion. W is kept when one attack or one clear Q already kills. The mark is never added to R kill estimates.'or 'Classic W is direct damage and is kept when one ready attack already kills. Item proc damage and the E bolt target are not assumed.'},
            {'FINISH','Q is cast without a mode key on an enemy it kills, unless a ready attack already does.'}},note='Q stops at champions, minions and projectile walls. Normal W stops at eligible recipients; Classic W and R pass through champions.'}end
        return {title='Manual blink and ultimate',subtitle='The E helper is off by default and requires an in-game key rebind.',cards={
            {'E HELPER','Enable [[helper]]. Helper key: '..settings.key(Menu.EHelper.efake)..'; in-game E key: '..settings.key(Menu.EHelper.elol)..'. Set E in the game to that second key. The helper captures your endpoint within 475 units and allows one bounded attempt per press. Release cancels waiting input.'},
            {'ULTIMATE','Hold the semi-manual R bind '..settings.key(Menu.Combo.SemiR)..' for a predicted full-range shot. [[rCC]], [[rKill]] and [[rAOE]] run independently. Automatic R requires no enemy within 800 units; CC and lethal shots use the configured range and shared impact timing.'},
            {'BLINK','Flee blinks toward the cursor and E is used away from an enemy who dashes onto you; Evade may use E to dodge. Every such blink needs known open ground, no enemy turret and no more enemies next to the landing than next to you. While the wall-check helper is on these are off, because E is then bound to another key in the game.'},
            {'CANCELLATION','Chat, focus loss, unavailable spells, expired requests and released binds cancel waiting work. E rejects unknown or wall landing points. Only the Combo blink finisher (off by default) chooses an aggressive destination, when the homing bolt surely goes to the enemy it kills.'}},note=self.profile.id=='classic'and 'Classic lethal R uses the minimum damage fraction because hit order is not observed. R remains manually available.'or 'Lethal and multi-hit R, Q on immobilised enemies and blocker CS start enabled; R on immobilised enemies starts disabled. A hit or kill still requires live observation.'}
    end,cfg,links,activate)
end

function EzrealChampion:Draw()
	if myHero.dead then return end
	if Menu.Draw.Q:Value() and IsReady(_Q) then
		Draw.Circle(myHero.pos, self.QSpell.Range, 1, Draw.Color(255, 66, 244, 113))
	end
	if Menu.Draw.W:Value() and IsReady(_W) then
		Draw.Circle(myHero.pos, self.WSpell.Range, 1, Draw.Color(255, 66, 229, 244))
	end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:RegisterPolicy({
    methods={
        AutoR=function()return {priority='interactive'}end,
        OnPreAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode) or nil end,

        Combo=function()return Core:ModeContext("Combo")end,
        Harass=function()return Core:ModeContext("Harass")end,
        LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,
        JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
        ClearSpecialMinions=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value() and Menu.Clear.LaneClear.QSpecial:Value()end)end,
        FarmHarass=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellHarass:Value() and not IsUnderTurret(myHero)end)end,
        LastHit=function()return Core:ModeContext(GetMode() == "LastHit" and "LastHit" or "LaneClear")end,
        ELogic=function()return Core:HeldContext(function()return Menu.EHelper.Enable:Value() and Control.IsKeyDown(Menu.EHelper.efake:Key())end)end,
        SemiR=function()return Core:HeldContext(function()return Menu.Combo.SemiR:Value()end)end,
    },
    exceptions={non_interrupting_summoner=true},
    channel=function(self,q)return not Core:SelfChanneling() end,
    validate=function(self,q,slot,resolved)
        if q.owner=='EHelper' then return Menu.EHelper.Enable:Value() and not Control.IsKeyDown(HK_LUS) and GetTickCount()>=LastChatOpenTimer+1000 and GetTickCount()>=LevelUpKeyTimer+1000 end
        return true
    end,
})

EzrealChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Ezreal"]="Ezreal"}
local normalSupported={["Ezreal"]=true}

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
