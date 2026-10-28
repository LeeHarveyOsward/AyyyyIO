return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Sivir"]=function()return _G.OrbamaFamily:Require("859455fcc70faebc4498e0af52f9a488ef3371d720c43757c959da26a27cf40f")()end
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
modules["combatMechanics"]=_G.OrbamaFamily:Require("fa55d9e58476517c728e6c357b2aca50c3ab206fe6ee2f8725de485a40598eff")
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
if champion=="Sivir" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Sivir',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.02


local shellSpells = {
    ["Jade_AlistarW"] = {charName = "Jade_Alistar", slot = "W", speed = math.huge, delay = 0.51},
    ["Jade_AniviaFrostbite"] = {charName = "Jade_Anivia", slot = "E", speed = 1600, delay = 0.25},
    ["Jade_AnnieQ"] = {charName = "Jade_Annie", slot = "Q", speed = 1400, delay = 0.25},
    ["Jade_BlitzcrankPowerFistAttack"] = {charName = "Jade_Blitzcrank", slot = "E", speed = math.huge, delay = 0.34},
    ["Jade_BrandE"] = {charName = "Jade_Brand", slot = "E", speed = 1800, delay = 0.25},
    ["Jade_BrandR"] = {charName = "Jade_Brand", slot = "R", speed = 1000, delay = 0.25},
    ["Jade_ChogathR"] = {charName = "Jade_Chogath", slot = "R", speed = math.huge, delay = 0.25},
    ["Jade_EvelynnE"] = {charName = "Jade_Evelynn", slot = "E", speed = 902, delay = 0.25},
    ["Jade_FiddlesticksQ"] = {charName = "Jade_Fiddlesticks", slot = "Q", speed = math.huge, delay = 0.25},
    ["Jade_FiddlesticksW"] = {charName = "Jade_Fiddlesticks", slot = "W", speed = math.huge, delay = 0.25},
    ["Jade_FiddlesticksE"] = {charName = "Jade_Fiddlesticks", slot = "E", speed = 1800, delay = 0.40},
    ["Jade_GangplankQ"] = {charName = "Jade_Gangplank", slot = "Q", speed = 2000, delay = 0.25},
    ["Jade_GarenQAttack"] = {charName = "Jade_Garen", slot = "Q", speed = math.huge, delay = 0.39},
    ["Jade_GarenR"] = {charName = "Jade_Garen", slot = "R", speed = math.huge, delay = 0.44},
    ["Jade_JannaSowTheWind"] = {charName = "Jade_Janna", slot = "W", speed = 1600, delay = 0.25},
    ["Jade_JarvanIVCataclysm"] = {charName = "Jade_JarvanIV", slot = "R", speed = math.huge, delay = 0.25},
    ["Jade_JaxQ"] = {charName = "Jade_Jax", slot = "Q", speed = math.huge, delay = 0.25},
    ["Jade_JaxWAttack"] = {charName = "Jade_Jax", slot = "W", speed = math.huge, delay = 0},
    ["Jade_KassadinQ"] = {charName = "Jade_Kassadin", slot = "Q", speed = 1400, delay = 0.25},
    ["Jade_KatarinaQ"] = {charName = "Jade_Katarina", slot = "Q", speed = 1600, delay = 0.25},
    ["Jade_KatarinaE"] = {charName = "Jade_Katarina", slot = "E", speed = math.huge, delay = 0},
    ["Jade_KayleQ"] = {charName = "Jade_Kayle", slot = "Q", speed = 1000, delay = 0.25},
    ["Jade_KogMawQ"] = {charName = "Jade_KogMaw", slot = "Q", speed = 1500, delay = 0.25},
    ["Jade_LeeSinQTwo"] = {charName = "Jade_LeeSin", slot = "Q2", speed = 2200, delay = 0.25},
    ["Jade_LeeSinR"] = {charName = "Jade_LeeSin", slot = "R", speed = 1500, delay = 0.25},
    ["Jade_LeonaShieldOfDaybreakAttack"] = {charName = "Jade_Leona", slot = "Q", speed = math.huge, delay = 0.39},
    ["Jade_LuluW"] = {charName = "Jade_Lulu", slot = "W", speed = 2000, delay = 0.175},
    ["Jade_LuluE"] = {charName = "Jade_Lulu", slot = "E", speed = math.huge, delay = 0.175},
    ["Jade_MalphiteSeismicShard"] = {charName = "Jade_Malphite", slot = "Q", speed = 1200, delay = 0.25},
    ["Jade_MalzaharE"] = {charName = "Jade_Malzahar", slot = "E", speed = 1400, delay = 0.25},
    ["Jade_MalzaharR"] = {charName = "Jade_Malzahar", slot = "R", speed = math.huge, delay = 0.25},
    ["Jade_MasterYiAlphaStrike"] = {charName = "Jade_MasterYi", slot = "Q", speed = 4000, delay = 0.10},
    ["Jade_MissFortuneRicochetShot"] = {charName = "Jade_MissFortune", slot = "Q", speed = 1400, delay = 0.25},
    ["Jade_NasusSiphoningStrikeAttack"] = {charName = "Jade_Nasus", slot = "Q", speed = math.huge, delay = 0.52},
    ["Jade_NasusW"] = {charName = "Jade_Nasus", slot = "W", speed = math.huge, delay = 0.25},
    ["Jade_NidaleeCougarTakedownAttack"] = {charName = "Jade_Nidalee", slot = "Q2", speed = math.huge, delay = 0.35},
    ["Jade_NunuE"] = {charName = "Jade_Nunu", slot = "E", speed = 1000, delay = 0.25},
    ["Jade_OlafE"] = {charName = "Jade_Olaf", slot = "E", speed = math.huge, delay = 0.25},
    ["Jade_PantheonQ"] = {charName = "Jade_Pantheon", slot = "Q", speed = 1200, delay = 0.25},
    ["Jade_PantheonW"] = {charName = "Jade_Pantheon", slot = "W", speed = math.huge, delay = 0.125},
    ["Jade_RammusE"] = {charName = "Jade_Rammus", slot = "E", speed = math.huge, delay = 0.25},
    ["Jade_RyzeQ"] = {charName = "Jade_Ryze", slot = "Q", speed = 1700, delay = 0.25},
    ["Jade_RyzeW"] = {charName = "Jade_Ryze", slot = "W", speed = math.huge, delay = 0.25},
    ["Jade_RyzeE"] = {charName = "Jade_Ryze", slot = "E", speed = 1000, delay = 0.25},
    ["Jade_ShacoTwoShivPoison"] = {charName = "Jade_Shaco", slot = "E", speed = 1500, delay = 0.25},
    ["Jade_SingedFling"] = {charName = "Jade_Singed", slot = "E", speed = math.huge, delay = 0.25},
    ["Jade_SionQ"] = {charName = "Jade_Sion", slot = "Q", speed = 1600, delay = 0.25},
    ["Jade_SkarnerR"] = {charName = "Jade_Skarner", slot = "R", speed = math.huge, delay = 0.25},
    ["Jade_SorakaE"] = {charName = "Jade_Soraka", slot = "E", speed = math.huge, delay = 0.25},
    ["Jade_TaricE"] = {charName = "Jade_Taric", slot = "E", speed = 1750, delay = 0.25},
    ["Jade_TeemoQ"] = {charName = "Jade_Teemo", slot = "Q", speed = 1500, delay = 0.25},
    ["Jade_TristanaE"] = {charName = "Jade_Tristana", slot = "E", speed = 1400, delay = 0.25},
    ["Jade_TristanaR"] = {charName = "Jade_Tristana", slot = "R", speed = 1600, delay = 0.25},
    ["Jade_TwistedFate_BlueCardPreAttack"] = {charName = "Jade_TwistedFate", slot = "Blue W", speed = 1500, delay = 0.125},
    ["Jade_TwistedFate_GoldCardPreAttack"] = {charName = "Jade_TwistedFate", slot = "Gold W", speed = 1500, delay = 0.125},
    ["Jade_TwistedFate_RedCardPreAttack"] = {charName = "Jade_TwistedFate", slot = "Red W", speed = 1500, delay = 0.125},
    ["Jade_VayneE"] = {charName = "Jade_Vayne", slot = "E", speed = 1200, delay = 0.25},
    ["Jade_VeigarBalefulStrike"] = {charName = "Jade_Veigar", slot = "Q", speed = 1200, delay = 0.25},
    ["Jade_VeigarR"] = {charName = "Jade_Veigar", slot = "R", speed = 1400, delay = 0.25},
    ["Jade_WarwickQ"] = {charName = "Jade_Warwick", slot = "Q", speed = 1500, delay = 0.25},
    ["Jade_WarwickR"] = {charName = "Jade_Warwick", slot = "R", speed = math.huge, delay = 0.10},
    ["Jade_WukongQAttack"] = {charName = "Jade_Wukong", slot = "Q", speed = math.huge, delay = 0.35},
    ["Jade_WukongE"] = {charName = "Jade_Wukong", slot = "E", speed = 2200, delay = 0},
    ["Jade_ZileanQ"] = {charName = "Jade_Zilean", slot = "Q", speed = math.huge, delay = 0.25},
    ["Jade_ZileanE"] = {charName = "Jade_Zilean", slot = "E", speed = math.huge, delay = 0.515},
}

-- Profile provenance and lifecycle scope: docs/FAMILY-SIVIR.md and docs/SIVIR-PROVENANCE.json.
local profiles=AbilityProfiles.controllers.Sivir
-- Normal: enemy abilities that are aimed at one unit and stopped by a spell shield.
-- PROVENANCE: the spell names are third-party leads (ZgjfjflAIO zgSivir.lua:6-87, vetted against kit knowledge in
-- D:/autolol-scratch/research/data-leads-findings.md section 20, 2026-10-08); none is confirmed against a live cast
-- event. A name the host never reports simply never triggers. Only rows judged unit-targeted and blockable were
-- taken. Left out on purpose: skillshots (Evade's data), self casts, removed kits, empowered attacks (whether the
-- shield stops them and which name the host reports are both unknown), Camille R (what the shield blocks is
-- unknown), and Nautilus R / Veigar R (slow homing missiles of unknown speed: a shield raised at launch could
-- run out before the hit).
-- delay is only the fallback when the cast gives no end time. speed=math.huge means the shield goes up at
-- launch: used for instant effects and for every missile whose speed is itself only a guess, which the 1.5 s
-- shield covers over these ranges. A finite speed is one that matched our own data or the wiki.
local normalThreats={
 AnnieQ={charName='Annie',slot='Q',speed=1400,delay=.25},
 Frostbite={charName='Anivia',slot='E',speed=1600,delay=.25},
 SeismicShard={charName='Malphite',slot='Q',speed=1200,delay=.25},
 BrandE={charName='Brand',slot='E',speed=math.huge,delay=.25},
 BrandR={charName='Brand',slot='R',speed=math.huge,delay=.25},
 BriarQ={charName='Briar',slot='Q',speed=math.huge,delay=.25},
 CassiopeiaE={charName='Cassiopeia',slot='E',speed=2500,delay=.125},
 Feast={charName='Chogath',slot='R',speed=math.huge,delay=.25},
 DariusExecute={charName='Darius',slot='R',speed=math.huge,delay=.3667},
 EliseHumanQ={charName='Elise',slot='Q',speed=2200,delay=.25},
 EliseSpiderQCast={charName='Elise',slot='Spider Q',speed=math.huge,delay=.25},
 Terrify={charName='Fiddlesticks',slot='Q',speed=math.huge,delay=.35},
 GangplankQProceed={charName='Gangplank',slot='Q',speed=2600,delay=.25},
 GarenR={charName='Garen',slot='R',speed=math.huge,delay=.435},
 SowTheWind={charName='Janna',slot='W',speed=math.huge,delay=.25},
 JarvanIVCataclysm={charName='JarvanIV',slot='R',speed=math.huge,delay=0},
 JayceToTheSkies={charName='Jayce',slot='Hammer Q',speed=math.huge,delay=.25},
 JayceThunderingBlow={charName='Jayce',slot='Hammer E',speed=math.huge,delay=.25},
 KatarinaQ={charName='Katarina',slot='Q',speed=1600,delay=.25},
 KatarinaE={charName='Katarina',slot='E',speed=math.huge,delay=.1},
 NullLance={charName='Kassadin',slot='Q',speed=1400,delay=.25},
 KSanteR={charName='KSante',slot='R',speed=math.huge,delay=.4},
 KhazixQ={charName='Khazix',slot='Q',speed=math.huge,delay=.25},
 KhazixQLong={charName='Khazix',slot='Evolved Q',speed=math.huge,delay=.25},
 BlindMonkRKick={charName='LeeSin',slot='R',speed=math.huge,delay=.25},
 LeblancQ={charName='Leblanc',slot='Q',speed=2000,delay=.25},
 LeblancRQ={charName='Leblanc',slot='R (Q)',speed=2000,delay=.25},
 LissandraREnemy={charName='Lissandra',slot='R',speed=math.huge,delay=0},
 LucianQ={charName='Lucian',slot='Q',speed=math.huge,delay=.25},
 LuluWTwo={charName='Lulu',slot='W',speed=2250,delay=.25},
 MalzaharE={charName='Malzahar',slot='E',speed=math.huge,delay=.25},
 MalzaharR={charName='Malzahar',slot='R',speed=math.huge,delay=0},
 AlphaStrike={charName='MasterYi',slot='Q',speed=math.huge,delay=0},
 MissFortuneRicochetShot={charName='MissFortune',slot='Q',speed=1400,delay=.25},
 NasusW={charName='Nasus',slot='W',speed=math.huge,delay=.25},
 NunuQ={charName='Nunu',slot='Q',speed=math.huge,delay=.25},
 OlafRecklessStrike={charName='Olaf',slot='E',speed=math.huge,delay=.25},
 PantheonW={charName='Pantheon',slot='W',speed=math.huge,delay=0},
 RekSaiE={charName='RekSai',slot='E',speed=math.huge,delay=.25},
 RekSaiR={charName='RekSai',slot='R',speed=math.huge,delay=1.5},
 PuncturingTaunt={charName='Rammus',slot='E',speed=math.huge,delay=.25},
 RyzeW={charName='Ryze',slot='W',speed=math.huge,delay=.25},
 Fling={charName='Singed',slot='E',speed=math.huge,delay=.25},
 SyndraR={charName='Syndra',slot='R',speed=math.huge,delay=.25},
 SylasR={charName='Sylas',slot='R',speed=math.huge,delay=.25},
 TwoShivPoison={charName='Shaco',slot='E',speed=math.huge,delay=.25},
 BlindingDart={charName='Teemo',slot='Q',speed=2500,delay=.25},
 TristanaR={charName='Tristana',slot='R',speed=2000,delay=.25},
 TrundlePain={charName='Trundle',slot='R',speed=math.huge,delay=.25},
 ViR={charName='Vi',slot='R',speed=math.huge,delay=.25},
 VayneCondemn={charName='Vayne',slot='E',speed=2200,delay=.25},
 VladimirQ={charName='Vladimir',slot='Q',speed=math.huge,delay=.25},
 -- Sivir-3 (2026-10-10): empowered attacks that are abilities (the spell shield blocks "one hostile effect,
 -- abilities and item effects", wiki Sivir read 2026-10-10). Names: zgSivir.lua:62-83 / 14Sivir.lua:24-32 leads.
 -- A row acts only when the host reports that exact name with Sivir as its target, which is the evidence; the
 -- dev trace sivir_attack_threat records each such cast (timing, target field) to confirm the rows from play.
 -- Melee contact is at the cast end; Gold Card's card speed is not ours, so the shield goes up at launch.
 LeonaShieldOfDaybreakAttack={charName='Leona',slot='Q (attack)',speed=math.huge,delay=.25,attack=true},
 PowerFistAttack={charName='Blitzcrank',slot='E (attack)',speed=math.huge,delay=.25,attack=true},
 GoldCardPreAttack={charName='TwistedFate',slot='Gold Card',speed=math.huge,delay=.25,attack=true},
 XinZhaoQThrust3={charName='XinZhao',slot='Q (third hit)',speed=math.huge,delay=.25,attack=true},
 VolibearQAttack={charName='Volibear',slot='Q (attack)',speed=math.huge,delay=.25,attack=true},
 RenektonExecute={charName='Renekton',slot='W',speed=math.huge,delay=.25,attack=true},
 RenektonSuperExecute={charName='Renekton',slot='W (empowered)',speed=math.huge,delay=.25,attack=true},
 TalonQAttack={charName='Talon',slot='Q (attack)',speed=math.huge,delay=.25,attack=true},
 DariusNoxianTacticsONHAttack={charName='Darius',slot='W (attack)',speed=math.huge,delay=.25,attack=true},
 NidaleeTakedownAttack={charName='Nidalee',slot='Cougar Q',speed=math.huge,delay=.25,attack=true},
 -- Rerank defence_evade (2026-10-10, leads zgSivir.lua:38 / 14Sivir.lua:47,80,92): Garen's empowered Q attack
 -- (silence) and Volibear's W bite (a targeted melee ability) as contact-at-cast-end rows; Ryze's E Spell Flux
 -- is a targeted missile whose speed is not measured here (asset 3500 vs wiki 4000, Ryze-6), so the shield goes
 -- up at launch. trace=true records it in sivir_attack_threat as well.
 GarenQAttack={charName='Garen',slot='Q (attack)',speed=math.huge,delay=.25,attack=true},
 VolibearW={charName='Volibear',slot='W',speed=math.huge,delay=.25,attack=true},
 RyzeE={charName='Ryze',slot='E',speed=math.huge,delay=.25,trace=true},
}
-- Sivir-3: slow homing ultimates. Their speed is not ours, so the shield follows the actual missile object at
-- Sivir (Core:TargetedMissiles: position and speed read every tick) instead of a guessed launch time.
local missileThreats={
 NautilusGrandLine={charName='Nautilus',slot='R'},
 VeigarR={charName='Veigar',slot='R'},
}
local finite,identity=Core.finite,Core.id
local SivirChampion=class("SivirChampion")
function SivirChampion:__init()
 self.profile=assert(profiles[myHero.charName],'Unsupported Sivir profile')
 self.threatSpells=self.profile.toggle and shellSpells or normalThreats
 self.missileSpells=not self.profile.toggle and missileThreats or {}
 self.data=assert(ChampionProfiles('Sivir')[myHero.charName],'Unsupported Sivir profile')
 self.Q=AbilityProfiles.Spell(myHero.charName,'Q',OrbamaPrediction)
 self.Q.Collision=true;self.Q.CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}
 self.directionalSupported=Core.adapter:Capabilities().directionalWorldCast==true
 self.threats={};self.attackWitness=nil
 self:LoadMenu()
 self:RegisterSharedShieldPolicy()
 Callback.Add('Tick',function()self:Tick()end)
 Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function()self:OnPostAttack()end)
end
function SivirChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Sivir'})
 for _,mode in ipairs({'combo','harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode=='combo'and 'Combo'or 'Harass'})
  local m=Menu[mode]
  m:MenuElement({id='Q',name='Use Q',value=true})
  m:MenuElement({id='maxRange',name='Longest Q range',value=1150,min=0,max=1250,step=10,menu=false})
  m:MenuElement({id='W',name=self.profile.toggle and 'Use W when it bounces to a second enemy'or 'Use W after an attack',value=true})
  m:MenuElement({id='mana',name='Only above mana %',value=mode=='combo'and 0 or 30,min=0,max=100,step=1})
 end
 -- Sivir-6: Classic R is a 15 s attack-speed steroid for fights; Normal R is a chase tool (off by default).
 Menu.combo:MenuElement({id='R',name=self.profile.toggle and 'Use R while attacking the target'or 'Use R to chase a target with an ally nearby',value=self.profile.toggle==true})
 Menu:MenuElement({type=MENU,id='auto',name='Without a mode key'})
 Menu.auto:MenuElement({id='Q',name='Use Q on immobilised enemies',value=true})
 -- Rerank combo (Auto Sivir): the attack reset outside the mode keys, Normal only (Classic W is a bounce toggle).
 if not self.profile.toggle then Menu.auto:MenuElement({id='W',name='Use W after your attack on a champion',value=false})end
 Menu.auto:MenuElement({id='mana',name='Only above mana %',value=30,min=0,max=100,step=1})
 Menu:MenuElement({type=MENU,id='eSetting',name='E (Spell Shield)'})
 Menu.eSetting:MenuElement({id='eDelay',name='Shield this many seconds before impact',value=.2,min=0,max=1.5,step=.01,menu=false})
 Menu.eSetting:MenuElement({type=MENU,id='blockSpell',name='Targeted spells to block'})
 Menu.eSetting:MenuElement({type=MENU,id='dash',name='Shield when these enemies dash at you'})
 Menu.eSetting:MenuElement({type=MENU,id='shared',name='Spells Evade may block with E'})
 Menu.eSetting.shared:MenuElement({id='HardCC',name='Only block stuns, roots and knock-ups',value=false})
 Menu.eSetting.shared:MenuElement({id='ComboDamage',name='In Combo, only block hits above % of health',value=0,min=0,max=100,step=1,menu=false})
 Menu.eSetting.shared:MenuElement({id='OtherDamage',name='Otherwise, only block hits above % of health',value=0,min=0,max=100,step=1,menu=false})
 _G.SDK.ObjectManager:OnEnemyHeroLoad(function(enemy)
  for name,row in pairs(self.threatSpells)do
   if row.charName==enemy.charName and not Menu.eSetting.blockSpell[name]then Menu.eSetting.blockSpell:MenuElement({id=name,name=enemy.charName..' '..row.slot,value=true})end
  end
  for name,row in pairs(self.missileSpells)do
   if row.charName==enemy.charName and not Menu.eSetting.blockSpell[name]then Menu.eSetting.blockSpell:MenuElement({id=name,name=enemy.charName..' '..row.slot,value=true})end
  end
  if not Menu.eSetting.dash[enemy.charName]then Menu.eSetting.dash:MenuElement({id=enemy.charName,name=enemy.charName,value=false})end
 end)
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q',value=true})
 Menu.LastHit:MenuElement({id='mana',name='Only above mana %',value=20,min=0,max=100,step=1})
 Menu:MenuElement({type=MENU,id='draw',name='Drawings'})
 Menu.draw:MenuElement({id='Q',name='Q range while Q is ready',value=false})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='Enabled',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.Enabled,v)end})
 for _,name in ipairs({'Lane','Jungle'})do
  Menu.Clear:MenuElement({type=MENU,id=name,name=name..' clear'})
  local n=Menu.Clear[name];n:MenuElement({id='Q',name='Use Q',value=true});n:MenuElement({id='W',name='Use W',value=true})
  n:MenuElement({id='Count',name='Minions Q must hit',value=name=='Lane'and 2 or 1,min=1,max=6,step=1,menu=false})
  n:MenuElement({id='mana',name='Only above mana %',value=20,min=0,max=100,step=1})
 end
 Menu:MenuElement({type=MENU,id='Flee',name='Flee'})
 Menu.Flee:MenuElement({id='R',name='Use R',value=false})
 Menu.Flee:MenuElement({id='mana',name='Only above mana %',value=10,min=0,max=100,step=1,menu=false})
end
function SivirChampion:RegisterSharedShieldPolicy()
 local resource=Core.adapter:SlotResource(_E)
 self.sharedShieldPolicy={source='Sivir E permissions; shared Evade ordered blockable-hit forecast and CombatProfiles shield-duration provenance',
  allow=function(option,context,result)
   if not Core:Current()or myHero.dead
    or not option or option.resource~=resource or option.profile~=self.profile.id or not option.effect or option.effect.kind~='spellShield'then return false end
   if not result then return true end
   local blocked=result.blockedSpell
   if not result.known or result.orderUncertain or result.identityConflict or not blocked then return false end
   local node=blocked.abilityName and Menu.eSetting.blockSpell[blocked.abilityName]
   if node and not node:Value()then return false end
   if Menu.eSetting.shared.HardCC:Value()and blocked.ccHard~=true then return false end
   local percent=(GetMode()=='Combo'and Menu.eSetting.shared.ComboDamage or Menu.eSetting.shared.OtherDamage):Value()
   return percent<=0 or finite(blocked.damage)and finite(myHero.maxHealth)and myHero.maxHealth>0 and blocked.damage*100>=myHero.maxHealth*percent
  end}
 return Core:RegisterDefensePolicy('Sivir.E',resource,self.sharedShieldPolicy)
end
function SivirChampion:ModeNode(mode)
 return mode=='Combo'and Menu.combo or mode=='Harass'and Menu.harass or mode=='LastHit'and Menu.LastHit
  or mode=='LaneClear'and Menu.Clear.Lane or mode=='JungleClear'and Menu.Clear.Jungle or Menu.auto
end
function SivirChampion:ManaAllowed(node)
 return node and node.mana and Core.manaAbove(node.mana:Value())
end
function SivirChampion:QDelay()
 if self.profile.toggle then return .25 end
 local speed=myHero.attackSpeed
 if not finite(speed)or speed<1 then speed=1 end
 return .25*(1-math.min(.6,(speed-1)*.5))
end
-- Q finisher without a mode key: the shared kill rule with the outbound hit at its lowest value (every unit
-- the blade passes first lowers it), so a return hit or a clean line only adds to it.
function SivirChampion:QLethal(target)
 if not IsValid(target)or target.type~=Obj_AI_Hero or GetDistance(myHero.pos,target.pos)>self.Q.Range then return false end
 return(Core:Lethal(target,self:QDelay()+GetDistance(myHero.pos,target.pos)/self.Q.Speed,function()return self:QDamage(target)end,{kind=self.data.qType}))
end
function SivirChampion:QKS()
 if not IsReady(_Q)then return false end
 local heroes=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#heroes,10)do if self:QLethal(heroes[i])and self:CastQ(heroes[i],'Kill')then return true end end
 return false
end
function SivirChampion:QAllowed(target,mode)
 if mode=='Kill'then return self:QLethal(target)end
 local m=self:ModeNode(mode)
 return IsValid(target)and m.Q:Value()and self:ManaAllowed(m)
  and GetDistance(myHero.pos,target.pos)<=math.min(self.Q.Range,m.maxRange and m.maxRange:Value()or self.Q.Range)
   and(mode~='AutoQ'or Core:ControlledHit(target,self.Q,target.pos))
end
function SivirChampion:CastQ(target,mode)
 mode=mode or GetMode()or 'AutoQ'
 if not IsReady(_Q)then return false end
 self.Q.Delay=self:QDelay()
 if not self:QAllowed(target,mode)then return false end
 local castDelay=self.Q.Delay
 local pred=Core:Prediction(self.Q);pred:GetPrediction(target,myHero)
 -- Both providers score nonhero path prediction as NORMAL, even when stationary.
 local hitchance=mode=='LastHit'and target.type==Obj_AI_Minion and OrbamaPrediction.HITCHANCE_NORMAL or OrbamaPrediction.HITCHANCE_HIGH
 if not pred:CanHit(hitchance)then return false end
 return Core:Cast(HK_Q,pred.CastPosition,{prevalidateWorldCast=true,intentTarget=target,range=self.Q.Range,
  directionalWorldCast=self.directionalSupported,directionalAimError=self.Q.AimErrorWorld,
  context=(mode=='AutoQ'or mode=='Kill')and {priority='interactive'}or Core:ModeContext(mode),validate=function(_,resolved)
   return self:QAllowed(target,mode)and math.abs(self:QDelay()-castDelay)<.001 and(mode~='LastHit'or self:CanRescue(target))
    and(mode~='AutoQ'or resolved and Core:ControlledHit(target,self.Q,resolved.position))
  end})
end
function SivirChampion:WActive()
 if self.profile.toggle then return myHero:GetSpellData(_W).toggleState==2 end
 local count=myHero.buffCount
 if not finite(count)or count<0 or count>128 then return true end
 for i=0,count do
  local b=myHero:GetBuff(i)
  if b and b.name and b.name:lower()=='sivirw'and(b.count or 0)>0 then
   local ending=Core.buffExpiry(b)
   if not finite(ending)or ending>Game.Timer()then return true end
  end
 end
 return false
end
function SivirChampion:BounceTarget(target)
 if not IsValid(target)or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return false end
 local heroes=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#heroes,10)do local other=heroes[i]
  if identity(other)~=identity(target)and IsValid(other)and GetDistance(target.pos,other.pos)<=500 then return true end
 end
 return false
end
function SivirChampion:WAllowed(target,mode)
 if(mode=='LaneClear'or mode=='JungleClear')and not Menu.Clear.Enabled:Value()then return false end
 -- 'Auto': no mode key held, an enemy champion, behind Menu.auto.W and the automatic mana limit.
 if mode=='Auto'and(GetMode()~=nil or not Menu.auto.W or not IsValid(target)or target.type~=Obj_AI_Hero)then return false end
 local node=mode=='Combo'and Menu.combo or mode=='Harass'and Menu.harass or mode=='LaneClear'and Menu.Clear.Lane or mode=='JungleClear'and Menu.Clear.Jungle
  or mode=='Auto'and Menu.auto
 if not node or not node.W:Value()or not self:ManaAllowed(node)or not IsValid(target)
  or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return false end
 if self.profile.toggle then
  if mode=='LaneClear'or mode=='JungleClear'then return myHero.mana>=self.profile.wCost and self:FarmNearby(target,mode)>=2 end
  return myHero.mana>=self.profile.wCost and self:BounceTarget(target)
 end
 local w=self.attackWitness
 return not self:WActive()and w and w.object==target and w.target==identity(target)
  and Game.Timer()>=w.at and Game.Timer()-w.at<=.35
end
function SivirChampion:CastW(target,mode)
 if not IsReady(_W)or not self:WAllowed(target,mode)or self:WActive()then return false end
 local farm=mode=='LaneClear'or mode=='JungleClear'
 local accepted=Core:Cast(HK_W,nil,{intentTarget=target,context=farm and Core:FarmContext(mode=='JungleClear'and'jungle'or'lane',function()return Menu.Clear.Enabled:Value()end)
   or mode=='Auto'and {priority='interactive'}or nil,
  validate=function()return(not farm or Menu.Clear.Enabled:Value())and self:WAllowed(target,mode)and not self:WActive()end})
 if accepted then Core:AfterCast(HK_W,function()lastW=GetTickCount();if self.profile.toggle then self.wOwned=true end end)end
 return accepted
end
function SivirChampion:ObserveAttack()
 if self.profile.toggle then return end
 self.attackWitness=ObserveAttack(_G,self.attackWitness,function(id)
  local heroes=Core:DecisionUnits('GetEnemyHeroes')
   for i=1,math.min(#heroes,10)do local hero=heroes[i];if hero.networkID==id or hero.handle==id then return hero end end
   local units=Core:DecisionUnits('GetEnemyMinions')
   for i=1,math.min(#units,32)do local u=units[i];if u.networkID==id or u.handle==id then return u end end
 end)
end
function SivirChampion:OnPostAttack()
 if self.profile.toggle or ShouldWait()then return end
 self:ObserveAttack()
 local mode=GetMode();local target=self.attackWitness and self.attackWitness.object
 if mode=='Combo'or mode=='Harass'then self:CastW(target,mode)
 elseif mode=='LaneClear'and Menu.Clear.Enabled:Value()then
  local jungle=target and target.team==300;local key=jungle and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or _G.SDK.ORBWALKER_MODE_LANECLEAR
  if _G.SDK.Orbwalker.Modes[key]then
   self:CastW(target,jungle and 'JungleClear'or'LaneClear')
  end
 elseif mode==nil and Menu.auto.W and Menu.auto.W:Value()then self:CastW(target,'Auto')
 end
end
function SivirChampion:ToggleOff()
 local spell=myHero:GetSpellData(_W)
 if not self.profile.toggle or not self.wOwned or not self:WActive()or spell.level<=0 or spell.currentCd~=0 or Game.CanUseSpell(_W)~=0 then return end
 local mode=GetMode();local target=GetTarget(self.Q.Range)
 if self:WAllowed(target,mode)then return end
 local accepted=Core:Cast(HK_W,nil,{owner='ToggleOff',context={},validate=function()
  return self:WActive()and not self:WAllowed(GetTarget(self.Q.Range),GetMode())
 end})
 if accepted then Core:AfterCast(HK_W,function()lastW=GetTickCount();self.wOwned=false end)end
end
function SivirChampion:Combo()
 local target=GetTarget(self.Q.Range)
 if not IsValid(target)then return end
 if self.profile.toggle then self:CastW(target,'Combo')end
 if self:ComboR(target)then return end
 if not self:LineQ(target,'Combo')then self:CastQ(target,'Combo')end
end
function SivirChampion:Harass()
 local target=GetTarget(self.Q.Range)
 if not IsValid(target)then return end
 if self.profile.toggle then self:CastW(target,'Harass')end
 if not self:LineQ(target,'Harass')then self:CastQ(target,'Harass')end
end
-- Sivir-2: predicted enemy champions (at most 5) the blade's line can pass. Returns points for Core:BestAim.
function SivirChampion:LinePoints(units)
 self.Q.Delay=self:QDelay();local points={}
 for i=1,math.min(#units,10)do local u=units[i]
  if #points>=5 then break end
  if IsValid(u)and u.type==Obj_AI_Hero and GetDistance(u.pos,myHero.pos)<=self.Q.Range then
   local pred=Core:Prediction(self.Q);pred:GetPrediction(u,myHero)
   local p=pred:CanHit(OrbamaPrediction.HITCHANCE_HIGH)and pred.CastPosition
   if p and finite(p.x)and finite(p.z)then points[#points+1]={x=p.x,y=p.y or 0,z=p.z,radius=u.boundingRadius or 65,unit=u}end
  end
 end
 return points
end
-- Q along the line that passes the most enemy champions: the target's own line unless another line passes
-- more and still holds a champion inside the mode's longest Q range; only for two or more champions (one
-- champion keeps CastQ). The validator predicts the same champions again and recounts the resolved ray.
function SivirChampion:LineQ(target,mode)
 if not IsReady(_Q)or not self:QAllowed(target,mode)then return false end
 local m=self:ModeNode(mode);local reach=math.min(self.Q.Range,m.maxRange:Value())
 local points=self:LinePoints(Core:DecisionUnits('GetEnemyHeroes'));if #points<2 then return false end
 local must;for i,p in ipairs(points)do if p.unit==target then must=i end end
 local shape={kind='line',width=self.Q.Radius*2,range=self.Q.Range}
 local aimS,ws,hitsS;if must then aimS,ws,hitsS=Core:BestAim(points,shape,{must=must})end
 local aimB,wb,hitsB=Core:BestAim(points,shape)
 local function near(hits)for _,i in ipairs(hits or {})do if GetDistance(points[i].unit.pos,myHero.pos)<=reach then return true end end end
 local aim,hits
 if aimB and wb>=2 and wb>(ws or 0)and near(hitsB)then aim,hits=aimB,hitsB elseif aimS and ws>=2 and near(hitsS)then aim,hits=aimS,hitsS else return false end
 local units={};for _,i in ipairs(hits)do units[#units+1]=points[i].unit end
 local need,castDelay=#units,self.Q.Delay
 local mustUnit;for _,i in ipairs(hits)do if i==must then mustUnit=points[i].unit end end
 local function count(position)
  local fresh=self:LinePoints(units);if #fresh<need then return 0 end
  local dx,dz=position.x-myHero.pos.x,position.z-myHero.pos.z;local length=math.sqrt(dx*dx+dz*dz);if length<1 then return 0 end
  local n=0
  for _,p in ipairs(fresh)do local x,z=p.x-myHero.pos.x,p.z-myHero.pos.z;local along=(x*dx+z*dz)/length
   if along>=0 and along<=self.Q.Range and math.abs(x*dz-z*dx)/length<=self.Q.Radius+p.radius then n=n+1 end
  end;return n
 end
 return Core:Cast(HK_Q,aim,{prevalidateWorldCast=true,intentTarget=units[1],range=self.Q.Range,
  directionalWorldCast=self.directionalSupported,directionalAimError=self.Q.AimErrorWorld,context=Core:ModeContext(mode),
  -- Fresh aim for the same champions; never a different set or fewer of them.
  resolve=function()
   local fresh=self:LinePoints(units);if #fresh<need then return nil,'line_changed'end
   local keep;if mustUnit then for i,p in ipairs(fresh)do if p.unit==mustUnit then keep=i end end end
   local a,w=Core:BestAim(fresh,shape,keep and {must=keep}or nil)
   if not a or w<need then return nil,'line_changed'end;return {position=a}
  end,
  validate=function(_,resolved)
   return IsReady(_Q)and m.Q:Value()and self:ManaAllowed(m)and math.abs(self:QDelay()-castDelay)<.001
    and resolved and resolved.position and count(resolved.position)>=need
  end})
end
-- Sivir-6: Combo R. Classic: the 15 s attack-speed steroid while the target is inside attack range.
-- Normal: movement speed to chase a target outside attack range (within 1500) with an ally within 1000.
function SivirChampion:RUseful(target)
 if not IsValid(target)or target.type~=Obj_AI_Hero then return false end
 local inRange=_G.SDK.Data:IsInAutoAttackRange(myHero,target)
 if self.data.rKind=='attack_speed'then return inRange end
 if inRange or GetDistance(target.pos,myHero.pos)>1500 then return false end
 local allies=Core:DecisionUnits('GetAllyHeroes')
 for i=1,math.min(#allies,5)do local a=allies[i];if a~=myHero and identity(a)~=identity(myHero)and IsValid(a)and GetDistance(a.pos,myHero.pos)<=1000 then return true end end
 return false
end
function SivirChampion:ComboR(target)
 local node=Menu.combo
 if not node.R:Value()or not IsReady(_R)or not self:ManaAllowed(node)or not self:RUseful(target)then return false end
 return Core:Cast(HK_R,nil,{context=Core:ModeContext('Combo'),intentTarget=target,validate=function()return node.R:Value()and self:ManaAllowed(node)and self:RUseful(target)end})
end
function SivirChampion:AutoQ()
 if not IsReady(_Q)or not Menu.auto.Q:Value()or not self:ManaAllowed(Menu.auto)then return end
 local heroes=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#heroes,10)do if self:QAllowed(heroes[i],'AutoQ')and self:CastQ(heroes[i],'AutoQ')then return end end
end
function SivirChampion:ThreatValid(t)
 if t.missile then
  local m=t.missile;local node=Menu.eSetting.blockSpell[t.name]
  return not myHero.dead and node~=nil and node:Value()and m.valid~=false and not m.dead and Game.Timer()<=t.deadline+.05
 end
  if myHero.dead or not t or t.cancelled or identity(t.caster)~=t.id or t.caster.dead and not t.launched then return false end
 local node=Menu.eSetting.blockSpell[t.name]
 if not node or not node:Value()or Game.Timer()>t.deadline+.05 then return false end
 local spell=t.caster.activeSpell
 if spell and spell.startTime==t.start then
  if spell.name~=t.name or spell.isStopped or spell.target~=myHero.handle and spell.target~=myHero.networkID then t.cancelled=true;return false end
  return spell.valid or Game.Timer()>=t.launch
 end
 -- A later spell must not supply the old spell's name, menu setting or target.
 -- Only a previously observed completed windup may survive activeSpell replacement.
 return t.launched==true
end
function SivirChampion:ShieldRetryable(t)
 local q=t.intent
 if not q or (t.attempts or 0)>=3 or q.sentAt or q.ambiguous then return false end
 local record=Core.adapter:Poll(q.id)
 if record then
  return record.state=='cancelled_before_send'and not record.sentAt and not record.cleanupPending
   and(not record.acquiredAt or record.releasedAt~=nil)
 end
 -- The controller retained a known unsent terminal outcome after acknowledgment.
 return q.outcome=='rejected_before_send'
end
function SivirChampion:BlockSpell()
 local now=Game.Timer();local heroes=Core:DecisionUnits('GetEnemyHeroes');local seen={};local dashTarget
 -- At most 32 recent casts survive between ticks. Expiry prevents history growth.
 local count=0
 for key,t in pairs(self.threats)do
  if now>t.deadline+.2 or identity(t.caster)~=t.id then self.threats[key]=nil else count=count+1 end
 end
 for i=1,math.min(#heroes,10)do
  local hero=heroes[i];local id=identity(hero);local spell=hero.activeSpell
  if id then seen[id]=true end
  if spell and spell.valid and not spell.isStopped and finite(spell.startTime)and spell.startTime<=now then
   local row=self.threatSpells[spell.name];local node=Menu.eSetting.blockSpell[spell.name]
   if id and id~=0 and row and row.charName==hero.charName and node and node:Value()and(spell.target==myHero.handle or spell.target==myHero.networkID)
    then
    local key=id..':'..spell.startTime
    local existing=self.threats[key]
    local launch=spell.startTime+row.delay
    if finite(spell.castEndTime)and spell.castEndTime>=spell.startTime then launch=spell.castEndTime end
    local deadline=launch+GetDistance(hero.pos,myHero.pos)/row.speed
    if not existing and count<32 and deadline>=now-.05 and deadline-now<=4 then
     self.threats[key]={id=id,caster=hero,name=spell.name,start=spell.startTime,launch=launch,deadline=deadline,key=key}
     count=count+1
     if row.attack or row.trace then Core:Trace('sivir_attack_threat',{name=spell.name,target=spell.target,start=spell.startTime,castEnd=spell.castEndTime,deadline=deadline})end
    end
   end
  end
  local dash=Menu.eSetting.dash[hero.charName]
  if not dashTarget and dash and dash:Value()and self:DashThreat(hero)then dashTarget=hero end
 end
 -- Homing missiles at Sivir (Sivir-3): the deadline follows the missile every tick.
 if next(self.missileSpells)then
  local rows=Core:TargetedMissiles();local list=rows[myHero.networkID or -1]or rows[myHero.handle or -1]
  for _,m in ipairs(list or {})do local lower=type(m.name)=='string'and m.name:lower()or''
   for name,row in pairs(self.missileSpells)do
    if lower:sub(1,#name)==name:lower()and m.owner.charName==row.charName then
     local key='missile:'..tostring(m.missile.networkID or m.missile.handle or m.name)..':'..tostring(identity(m.owner))
     local deadline=now+math.max(0,GetDistance(m.missile.pos,myHero.pos)-(myHero.boundingRadius or 65))/m.speed
     local t=self.threats[key]
     if t then t.deadline=deadline elseif count<32 and deadline-now<=4 then
      self.threats[key]={id=identity(m.owner),caster=m.owner,name=name,missile=m.missile,launched=true,deadline=deadline,launch=now,key=key};count=count+1
     end
    end
   end
  end
 end
 local best
 for key,t in pairs(self.threats)do
  -- A completed windup remains attributable until its captured impact deadline,
  -- even when the caster leaves the current visible/living hero snapshot.
  if not seen[t.id]and not t.launched then self.threats[key]=nil
  elseif self:ThreatValid(t)then
   if t.submitted and self:ShieldRetryable(t)then t.submitted=false end
   local spell=t.caster.activeSpell
   if spell and spell.valid and spell.startTime==t.start and now>=t.launch then t.launched=true end
   if not t.submitted and now>=t.deadline-Menu.eSetting.eDelay:Value()and(not best or t.deadline<best.deadline)then best=t end
  end
 end
 if not IsReady(_E)then return end
 if best then
  local captured=best
  if Core:Cast(HK_E,nil,{owner='spellshield',context={},priority='interactive',ttl=math.min(100,math.max(1,(best.deadline+.05-now)*1000)),independent=false,
   equivalence='shield:'..best.key,validate=function()return self:ThreatValid(captured)and Game.Timer()>=captured.deadline-Menu.eSetting.eDelay:Value()end})then
     best.submitted=true;best.intent=Core.lastIntent;best.attempts=(best.attempts or 0)+1
  end
 elseif dashTarget then
  local id=identity(dashTarget);local dash=Menu.eSetting.dash[dashTarget.charName]
  Core:Cast(HK_E,nil,{owner='dashshield',context={},priority='interactive',ttl=100,independent=false,
    validate=function()return identity(dashTarget)==id and dash:Value()and self:DashThreat(dashTarget)end})
 end
end
function SivirChampion:DashThreat(hero)
   return Core:ApproachingDash(hero,myHero.pos,172)~=nil
end
function SivirChampion:QDamage(target)
 local rank=myHero:GetSpellData(_Q).level;local base=self.profile.qBase[rank]
 if not base then return 0 end
 local raw=base+self.profile.qAD*(myHero.bonusDamage or 0)+self.profile.qAP*(myHero.ap or 0)
 -- One outbound hit at maximum attenuation. Return hits and item procs are not promised.
 -- Sivir-1: Normal physical, Classic magic (profile qType with source).
 return _G.SDK.Damage:CalculateDamage(myHero,target,self.data.qType=='magical'and _G.SDK.DAMAGE_TYPE_MAGICAL or _G.SDK.DAMAGE_TYPE_PHYSICAL,raw*.4)
end
function SivirChampion:AttackRescues(target)
 local sdk=_G.SDK
 if not sdk.Orbwalker:CanAttack()or not sdk.Data:IsInAutoAttackRange(myHero,target)then return false end
 local windup=sdk.Attack:GetWindup();local speed=sdk.Attack:GetProjectileSpeed()
 if not finite(windup)or windup<0 or not(speed==math.huge or finite(speed)and speed>0)then return false end
 local impact=windup+GetDistance(myHero.pos,target.pos)/speed
 local hp=sdk.HealthPrediction:GetPrediction(target,impact)
 if not finite(hp)or hp<=0 then return false end
 return sdk.Damage:GetAutoAttackDamage(myHero,target)>=hp+math.max(0,target.shieldAD or 0)+math.max(0,target.hpRegen or 0)*impact
end
function SivirChampion:CanRescue(target)
 if not self:QAllowed(target,'LastHit')or target.type~=Obj_AI_Minion or target.team==300 or _G.SDK.Attack:IsActive()then return false end
  self.Q.Delay=self:QDelay();local t=OrbamaPrediction:GetImpactTime(self.Q,target.pos,myHero)
 local hp=_G.SDK.HealthPrediction:GetPrediction(target,t)
 if not finite(hp)or hp<=0 or self:QDamage(target)<math.max(hp,target.health)+math.max(0,(self.data.qType=='magical'and target.shieldAP or target.shieldAD)or 0)+math.max(0,target.hpRegen or 0)*t then return false end
 if self:AttackRescues(target)then return false end
 return true
end
function SivirChampion:LastHit()
 if not Menu.LastHit.Q:Value()or not IsReady(_Q)then return end
 local minions=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#minions,32)do if self:CanRescue(minions[i])and self:CastQ(minions[i],'LastHit')then return end end
end
function SivirChampion:Tick()
 if ShouldWait()then return end
 self:BlockSpell()
 self:ObserveAttack()
 if IsCasting()then return end
 self:ToggleOff()
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LastHit'then self:LastHit()
 elseif mode=='LaneClear'then self:LaneClear();self:JungleClear()elseif mode=='Flee'then self:Flee()end
 if not self:QKS()then self:AutoQ()end
end
function SivirChampion:FarmNearby(target,mode)
 if not IsValid(target)then return 0 end
 local list=Core:DecisionUnits('GetEnemyMinions');local count=0
 for i=1,math.min(#list,32)do local u=list[i]
  if IsValid(u)and(u.team==300)==(mode=='JungleClear')and GetDistance(target.pos,u.pos)<=500 then count=count+1 end
 end
 return count
end
function SivirChampion:FarmHits(point,jungle)
 if not point then return 0 end
 local dx,dz=point.x-myHero.pos.x,point.z-myHero.pos.z;local len=math.sqrt(dx*dx+dz*dz);if len<1 then return 0 end
 dx,dz=dx/len,dz/len;local count=0;local units=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#units,32)do local u=units[i]
  if IsValid(u)and(u.team==300)==jungle and u.pathing and not u.pathing.hasMovePath and not u.pathing.isDashing then
   local x,z=u.pos.x-myHero.pos.x,u.pos.z-myHero.pos.z;local along=x*dx+z*dz
   if along>=0 and along<=self.Q.Range and math.abs(x*dz-z*dx)<=self.Q.Radius then count=count+1 end
  end
 end
 return count
end
function SivirChampion:Farm(jungle)
 local mode=jungle and 'JungleClear'or'LaneClear';local node=self:ModeNode(mode)
 local key=jungle and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or _G.SDK.ORBWALKER_MODE_LANECLEAR
 if not _G.SDK.Orbwalker.Modes[key]or not Menu.Clear.Enabled:Value()or not self:ManaAllowed(node)then return end
 local units=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#units,12)do local target=units[i]
  if IsValid(target)and(target.team==300)==jungle then
   if self.profile.toggle and self:CastW(target,mode)then return end
    if IsReady(_Q)and node.Q:Value()and GetDistance(myHero.pos,target.pos)<=self.Q.Range then
    self.Q.Delay=self:QDelay();local pred=Core:Prediction(self.Q);pred:GetPrediction(target,myHero)
    if pred:CanHit(OrbamaPrediction.HITCHANCE_NORMAL)and self:FarmHits(pred.CastPosition,jungle)>=node.Count:Value()then
      local castDelay=self.Q.Delay
      return Core:Cast(HK_Q,pred.CastPosition,{prevalidateWorldCast=true,intentTarget=target,range=self.Q.Range,
       directionalWorldCast=self.directionalSupported,directionalAimError=self.Q.AimErrorWorld,
       context=Core:FarmContext(jungle and 'jungle'or 'lane',function()return Menu.Clear.Enabled:Value()end),validate=function(_,resolved)
       return Menu.Clear.Enabled:Value()and self:ManaAllowed(node)and node.Q:Value()and math.abs(self:QDelay()-castDelay)<.001 and resolved and self:FarmHits(resolved.position,jungle)>=node.Count:Value()
     end})
    end
   end
  end
 end
end
function SivirChampion:LaneClear()return self:Farm(false)end
function SivirChampion:JungleClear()return self:Farm(true)end
function SivirChampion:Flee()
 if Menu.Flee.R:Value()and self:ManaAllowed(Menu.Flee)and IsReady(_R)then
  Core:Cast(HK_R,nil,{validate=function()return Menu.Flee.R:Value()and self:ManaAllowed(Menu.Flee)end})
 end
end
function SivirChampion:Draw()
 if not myHero.dead and Menu.draw.Q:Value()and IsReady(_Q)then Draw.Circle(myHero.pos,self.Q.Range,1,Draw.Color(255,255,162,0))end
end
function SivirChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.combo.Q,label='Combo Q'},w={node=Menu.combo.W,label='Combo W'},range={node=Menu.combo.maxRange,label='Q reach'},
   window={node=Menu.eSetting.eDelay,label='Shield lead time'},cc={node=Menu.eSetting.shared.HardCC,label='Only stuns, roots and knock-ups'},
  last={node=Menu.LastHit.Q,label='Last Hit Q'},mana={node=Menu.harass.mana,label='Harass mana'}}
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Sivir: combat','Sivir: shield and farming'},function(page)
  if page==1 then return {title=self.profile.toggle and 'Classic Sivir'or 'Sivir',subtitle='Use the provider mode keys.',cards={
   {'COMBAT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..' for [[q]] and [[w]]. [[range]] remains a limit before sending.'},
   {'RICOCHET',self.profile.toggle and 'Classic W toggles on for a reachable enemy with a second enemy within 500 units. It turns off when the mode, target or mana policy no longer permits it.'or 'Normal W follows a witnessed attack after its windup. Its four-second buff prevents repeated requests. It uses separate Normal mechanics.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. [[mana]] and the Harass switches govern spending. Release the mode to cancel waiting work.'}},note='Q prepares the outbound ray and takes the line through the most enemy champions. Return hits are uncertain and are never counted as guaranteed damage. An enemy the outbound Q alone kills is finished without a mode key. Combo R: '..(self.profile.toggle and 'attack speed while attacking the target.'or 'off unless you turn it on; it chases a target with an ally nearby.')}end
   return {title='Shield and farming',subtitle='Automatic E cooperates with the shared Evade threat and execution service.',cards={
    {'SHIELD','E blocks the listed targeted spells on its own, [[window]] before impact, and Evade may always use E against the skillshots it tracks. [[cc]] and the Combo/other damage limits apply to the Evade blocks and look at the first effect that would use up the shield. Switching a listed spell off also stops Evade blocking it.'},
   {'LAST HIT','[[last]] rescues a minion only when conservative outbound Q damage is lethal and a lethal attack can no longer arrive in time. Confirmed incoming lethal damage also preserves Q.'},
    {'ON THE HUNT','Optional Flee R follows the provider Flee key. Ability farming is one toggle with separate lane and jungle Q/W switches and line thresholds.'}},note='Shared protection needs active compatible Evade and its own resource permission. Unknown shieldable effects remain unmodeled. Outbound Q uses the common control window and capability-gated directional aiming; return hits are not counted as guaranteed damage.'}
 end,cfg,links,activate)
end
Core:RegisterPolicy({
 methods={Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
  AutoQ=function()return {priority='interactive'}end,QKS=function()return {priority='interactive'}end,LastHit=function()return Core:ModeContext('LastHit')end,
  LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.Enabled:Value()end)end,
  JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.Enabled:Value()end)end,
  Flee=function()return Core:ModeContext('Flee')end,
  OnPostAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode)or nil end,
  },
 costPaid=function(self,q,slot)return self.profile.toggle and slot==_W and myHero:GetSpellData(_W).toggleState==2 end,
 exceptions={non_interrupting_summoner=true},
 channel=function()return not Core:SelfChanneling()end,
})
SivirChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Sivir"]="Sivir"}
local normalSupported={["Sivir"]=true}

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
