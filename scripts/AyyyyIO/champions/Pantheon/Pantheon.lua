return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Pantheon"]=function()return _G.OrbamaFamily:Require("25221f524ffe6f624f1e8a05073915ef0240976df59106da5d132cbe7f606f06")()end
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
modules.observeAttack=(function(require) return _G.OrbamaFamily:Factory("3da377a20f2c2a192efc8343b23fb571f5cda62e822551b4678aab011deb2b69")(require) end)(require)
modules.recallCast=(function(require) return _G.OrbamaFamily:Factory("3c7cec6192229bd783dbb481829105edbbe5cfcc52fbeae7408eed05670af826")(require) end)(require)
modules.skillOrders=(function(require) return _G.OrbamaFamily:Factory("c960de90c594e7c207e7efeaca5198f2250fe65b01459ca5f3ac5dfb7747935f")(require) end)(require)
modules.healthWindow=(function(require) return _G.OrbamaFamily:Factory("d533b0ef74c68b495c1d2541cc3e687ebd5a9d43ecc9bd9706750c9b1a16fec9")(require) end)(require)
modules.yunaraProfile=(function(require) return _G.OrbamaFamily:Factory("d0f8a7ede995c1c4ae39ff50186c21819723104154d9a4a209da8a785993462e")(require) end)(require)
modules.nautilusProfile=(function(require) return _G.OrbamaFamily:Factory("f730083274ce090a6b9cdaf348846a2fa53f89ad6c57c53a6c09767f82770c84")(require) end)(require)
modules["autojungle"]=_G.OrbamaFamily:Require("8ef13010a581d447046b67d863880d3e389ac7fec6a8557c660db9c87981114d")
modules["combatMechanics"]=_G.OrbamaFamily:Require("ba52643cc532b91600830ad315958c7c83c7fb8f12edb7d0a0462abb16309ea7")
modules["gameplay"]=_G.OrbamaFamily:Require("150735cd6058eefcd206afc8513dde960e1a1f0823bdfd223db9491c39a2f4d8")
modules["strike"]=_G.OrbamaFamily:Require("38babe42b81881ea627d41ae65e32a203fdca56374f733a79b4c7f0c9465a693")
modules["prediction"]=(function(require) return _G.OrbamaFamily:Factory("223a065ecf7929552d5f8dafcf2453fd9147cd6e9940ce97dc80add73aa9913b")(require) end)(require)
modules["policies"]=(function(require) return _G.OrbamaFamily:Factory("e26056d70e5dac93ebb21f4ae4fe96863a06915a942bb75b795567a932448a23")(require) end)(require)
modules["core"]=(function(require) return _G.OrbamaFamily:Factory("f7d98e88d54ea77cb1c1c4aa026b699688271ff1aa4f6e769036de5dccf63c4f")(require) end)(require)
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
    return _G.SDK.IsRecalling(unit,Core.validating==true)
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
if champion=="Pantheon" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Pantheon',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.02


local PantheonChampion=class("PantheonChampion")

function PantheonChampion:__init()
	self:LoadMenu()
	-- The shared row plus this champion's own profile numbers (ChampionProfiles/Pantheon.lua), on a private copy.
	local shared=assert(AbilityProfiles.controllers.Pantheon[myHero.charName]);local own=ChampionProfiles('Pantheon')[myHero.charName]or {}
	self.profile={};for k,v in pairs(shared)do self.profile[k]=v end;for k,v in pairs(own)do self.profile[k]=v end
	Callback.Add("Draw", function() self:Draw() end)
	Callback.Add("Tick", function() self:Tick() end)
	self.QSpell = {Range = 600, Delay = 0.25, Speed = 1200}
	self.WSpell = {Range = 600}
	self.ESpell = {Type = OrbamaPrediction.SPELLTYPE_CONE, Delay = 0.25, Angle = 32, Range = 400, Speed = math.huge, Collision = false}
	self.farmESlopeSquared = math.tan(16*math.pi/180)^2
	self.eProbes = {}
	self.RSpell = {Range = 5500}
	if self.profile.id=='normal' then
	 self.QSpell=AbilityProfiles.Spell(myHero.charName,'Q',OrbamaPrediction)
	 self.QSpell.Speed=math.huge
	 self.ESpell=AbilityProfiles.Spell(myHero.charName,'E',OrbamaPrediction)
	 -- Lane E counts the real Normal cone (half of its 60 degrees), not the Classic 16 degree half-angle.
	 self.farmESlopeSquared=math.tan((self.ESpell.Angle or 60)/2*math.pi/180)^2
	 self.chargeCleanup={}
	 Menu.Combo:MenuElement({id='HoldQ',name='Charge Q to throw it at distant enemies',value=true,menu=false})
	 Menu.Harass:MenuElement({id='HoldQ',name='Charge Q to throw it at distant enemies',value=true,menu=false})
	 Menu:MenuElement({type=MENU,id='Flee',name='Flee'})
	 Menu.Flee:MenuElement({id='E',name='Use E to block a chaser',value=true})
	end
	self.comboTarget = nil
	self.comboTargetExpire = 0
	Core:RegisterCleanup('Pantheon',function()Core.adapter:SetBlocked('PantheonQManual','attack',false)end)
	Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
	if self.profile.id=='normal' then self:OfferBlock() end
end

-- Health-bar damage and KILL mark (S9): ready spells in reach plus one attack, each against current health.
function PantheonChampion:ComboDamage(u)
	if not IsValid(u) then return 0 end
	local d=GetDistance(u.pos,myHero.pos);local total=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)
	if IsReady(_Q) then
		if self.profile.id=='normal' then
			local held=d>self.QSpell.Range
			if not held or d<=AbilityProfiles.geometry.Pantheon.Q.flightRange then total=total+self:NormalQDamage(u,held) end
		elseif d<=self.QSpell.Range then total=total+self:GetQDmg(u) end
	end
	if IsReady(_W) and d<=self.WSpell.Range then total=total+self:GetWDmg(u) end
	if IsReady(_E) and d<=self.ESpell.Range then total=total+self:GetEDmg(u) end
	return total
end

-- Normal Aegis Assault to Evade as a directional block (S6): 1.5 s, the front cone, cast with no cast time;
-- the hero can still move in game, the offer is declared as a channel (Evade then expects no movement).
function PantheonChampion:OfferBlock()
	local p=self.profile
	if not Core.RegisterEffect or not Core.finite(p.eBlockAngle) or not Core.finite(p.eBlockDuration) then return end
	self.blockOffered,self.blockReason,self.blockAdapter=Core:RegisterEffect({kind='directional_block',name='PantheonE',slot=_E,key=HK_E,
		profile=p.id,source='CombatProfiles/ChampionProfiles/Pantheon.lua eBlockAngle/eBlockDuration: '..p.source,
		delay=0,duration=p.eBlockDuration,angle=p.eBlockAngle,channel=true,
		ready=function()return not self.charge and not self:NormalChannel()end})
end

function PantheonChampion:LoadMenu()
	local championIcon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/"..myHero.charName..".png"
	Menu = MenuElement({type = MENU, id = "Classic_AIO_"..myHero.charName, name='AyyyyIO - Pantheon', leftIcon = championIcon})

	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "E", name = "Use E", toggle = true, value = true})

	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "W", name = "Use W", toggle = true, value = false})
	Menu.Harass:MenuElement({id = "E", name = "Use E", toggle = true, value = false})
	Menu.Harass:MenuElement({id = "Mana", name = "Only above mana %", value = 40, min = 0, max = 100, step = 5})

	Menu:MenuElement({type = MENU, id = "Clear", name = "Farming"})
	Menu.Clear:MenuElement({id = "SpellFarm", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(newValue)
		if CheckChatBlock(Menu.Clear.SpellFarm, newValue) then return end
	end})
	Menu.Clear:MenuElement({id = "SpellHarass", name = "Harass champions while lane clearing", value = true})
	Menu.Clear:MenuElement({type = MENU, id = "LaneClear", name = "Lane clear"})
	Menu.Clear.LaneClear:MenuElement({id = "Q", name = "Use Q on minions it kills", value = true})
	Menu.Clear.LaneClear:MenuElement({id = "E", name = "Use E", value = true})
	Menu.Clear.LaneClear:MenuElement({id = "ECount", name = "Lane minions E must hit", value = 2, min = 1, max = 6, step = 1})
	Menu.Clear.LaneClear:MenuElement({id = "Mana", name = "Only above mana %", value = 20, min = 0, max = 100, step = 5})
	Menu.Clear:MenuElement({type = MENU, id = "JungleClear", name = "Jungle clear"})
	Menu.Clear.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.Clear.JungleClear:MenuElement({id = "W", name = "Use W", value = true})
	Menu.Clear.JungleClear:MenuElement({id = "E", name = "Use E", value = true})
	Menu.Clear.JungleClear:MenuElement({id = "Mana", name = "Only above mana %", value = 20, min = 0, max = 100, step = 5})
	Menu:MenuElement({type = MENU, id = "LastHit", name = "Last hit"})
	Menu.LastHit:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.LastHit:MenuElement({id = "Mana", name = "Only above mana %", value = 20, min = 0, max = 100, step = 5})

	Menu:MenuElement({type = MENU, id = "KillSteal", name = "Finish kills without holding a mode key"})
	Menu.KillSteal:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.KillSteal:MenuElement({id = "W", name = "Use W (leaps to the enemy, never under a turret)", value = true})
	Menu.KillSteal:MenuElement({id = "E", name = "Use E", value = true})

	Menu:MenuElement({type = MENU, id = "Misc", name = "Behaviour"})
	Menu.Misc:MenuElement({id = "SemiR", name = "Cast R toward the cursor", key = string.byte("T")})
	Menu.Misc:MenuElement({id = "RMinRange", name = "R only beyond this distance", value = 1000, min = 0, max = 3000, step = 100, menu = false})
	Menu.Misc:MenuElement({id = "InterruptW", name = "W to stun channeling enemies, not under turrets", value = true})
	Menu.Misc:MenuElement({id = "GapcloseW", name = "W to stun dashing enemies, not under turrets", value = true})

	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "Q", name = "Q range", value = false})
	Menu.Draw:MenuElement({id = "W", name = "W range", value = false})
	Menu.Draw:MenuElement({id = "E", name = "E range", value = false})
	Menu.Draw:MenuElement({id = "R", name = "R range", value = false})
end

function PantheonChampion:IsChanneling()
	if self.profile.id=='normal' then return self:NormalChannel() end
	local activeSpell = myHero.activeSpell
	local now = Game.Timer()
	for _, buff in ipairs(GetBuffs(myHero)) do
		local name = buff.name and buff.name:lower()
		if name == "jade_pantheonechannel" or name == "jade_pantheonr" then
			local ending = Core.buffExpiry(buff)
			if buff.count and buff.count > 0 and (not ending or ending <= 0 or ending > now) then return true end
		end
	end
	if not activeSpell or not activeSpell.valid or activeSpell.isStopped then return false end
	if activeSpell.name ~= "Jade_PantheonE" and activeSpell.name ~= "Jade_PantheonR" then return false end
	local ending = activeSpell.castEndTime
	return not ending or ending <= 0 or ending > now
end

function PantheonChampion:Tick()
	if self.profile.id=='normal' then return self:NormalTick() end
	local channeling = self:IsChanneling()
	_G.SDK.Orbwalker:SetAttack(not channeling)
	_G.SDK.Orbwalker:SetMovement(not channeling)
	if #self.eProbes>0 then self:EProbe() end
	if channeling then return end
	if ShouldWait() then return end
	if IsCasting() then return end

	self:SemiR()
	if self:InterruptW() or self:GapcloseW() then return end
	self:KillSteal()
	local mode = GetMode()
	if mode == "Combo" then
		self:Combo()
	elseif mode == "Harass" then
		self:Harass()
	elseif mode == "LaneClear" then
		self:FarmHarass()
		self:LaneClear()
		self:JungleClear()
	elseif mode == "LastHit" then
		self:LastHit()
	end
end

function PantheonChampion:GetComboTarget(range)
	if GetTickCount() < self.comboTargetExpire and IsValid(self.comboTarget) then
		if myHero.pos:DistanceTo(self.comboTarget.pos) <= range then
			return self.comboTarget
		end
	end
	return GetTarget(range)
end

function PantheonChampion:SetComboTarget(target)
	self.comboTarget = target
	self.comboTargetExpire = GetTickCount() + 2000
end

-- Every unit-targeted cast of either kit: the same living unit, still in range,
-- the slot still ready and the caller's own permission, re-read at dispatch.
function PantheonChampion:CastUnit(slot,key,target,range,allowed,extra)
	if not IsReady(slot) or not IsValid(target) or GetDistance(target.pos,myHero.pos)>range or allowed and not allowed() then return false end
	local identity,handle=Core.id(target),target.handle
	local options={intentTarget=target,range=range,validate=function()
		return IsReady(slot) and IsValid(target) and Core.id(target)==identity and target.handle==handle
			and GetDistance(target.pos,myHero.pos)<=range and (not allowed or allowed())
	end}
	for k,v in pairs(extra or {}) do options[k]=v end
	return Core:Cast(key,target,options)
end

-- Order W, Q, E. The spear is a targeted .25 s cast, Heartseeker a .75 s channel:
-- both fit the 1 s stun, the spear cannot be lost to an interrupted channel, its
-- short cooldown starts .75 s earlier, and it can push the target under the
-- Certain Death threshold before the strikes land.
function PantheonChampion:Fight(node,owner)
	local function on(spell) return function() return node[spell]:Value() and (not node.Mana or Core.manaAbove(node.Mana:Value())) end end
	if node.W:Value() and IsReady(_W) then
		local target = self:GetComboTarget(self.WSpell.Range)
		if IsValid(target) and target.pos2D.onScreen and self:CastUnit(_W,HK_W,target,self.WSpell.Range,on('W')) then
			local identity = Core.id(target)
			Core:AfterCast(HK_W, function()
				if IsValid(target) and Core.id(target) == identity then self:SetComboTarget(target) end
			end)
			return true
		end
	end
	if node.Q:Value() and IsReady(_Q) then
		local target = self:GetComboTarget(self.QSpell.Range)
		if IsValid(target) and target.pos2D.onScreen and self:CastUnit(_Q,HK_Q,target,self.QSpell.Range,on('Q')) then return true end
	end
	if node.E:Value() and IsReady(_E) then
		local target = self:GetComboTarget(self.ESpell.Range)
		if IsValid(target) and target.pos2D.onScreen and self:CastE(target,on('E')) then return true end
	end
	return false
end

function PantheonChampion:Combo()
	return self:Fight(Menu.Combo)
end

function PantheonChampion:Harass()
	if not Core.manaAbove(Menu.Harass.Mana:Value()) then return end
	return self:Fight(Menu.Harass)
end

-- The W stun stops a channel. No mode key: an interrupt is always worth the
-- cooldown, but the leap is bounded (never under a turret, never into more than
-- two enemies). The leap speed is not published, so the channel must outlast a
-- flat .35 s.
function PantheonChampion:InterruptW()
	if not Menu.Misc.InterruptW:Value() or not IsReady(_W) then return false end
	local list=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#list,10) do
		local target=list[i]
		local function worth()
			return Menu.Misc.InterruptW:Value() and Core:CanInterrupt(target,.35) and not IsUnderTurret2(target.pos) and GetEnemyCount(700,target.pos)<=2
		end
		if IsValid(target) and target.pos2D.onScreen and GetDistance(target.pos,myHero.pos)<=self.WSpell.Range and worth()
			and self:CastUnit(_W,HK_W,target,self.WSpell.Range,worth,{owner='InterruptW'}) then return true end
	end
	return false
end

-- An enemy dashing onto Pantheon (landing within 400) is stunned with W, with the interrupt's limits:
-- never under a turret, never into more than two enemies.
function PantheonChampion:GapcloseW()
	if not Menu.Misc.GapcloseW:Value() or not IsReady(_W) then return false end
	local list=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#list,10) do
		local target=list[i]
		local function worth()
			return Menu.Misc.GapcloseW:Value() and IsValid(target) and not IsUnderTurret2(target.pos) and GetEnemyCount(700,target.pos)<=2
				and (Core:ApproachingDash(target,myHero.pos,400)~=nil or GetDistance(target.pos,myHero.pos)<=400)
		end
		if IsValid(target) and target.pos2D.onScreen and GetDistance(target.pos,myHero.pos)<=self.WSpell.Range
			and Core:ApproachingDash(target,myHero.pos,400) and worth()
			and self:CastUnit(_W,HK_W,target,self.WSpell.Range,worth,{owner='GapcloseW'}) then return true end
	end
	return false
end

function PantheonChampion:ClearMode(jungle)
	local mode=jungle and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or _G.SDK.ORBWALKER_MODE_LANECLEAR
	return mode~=nil and _G.SDK.Orbwalker.Modes[mode]==true
end

-- Modern kit methods on the same PantheonChampion controller. No new callbacks.
local pantheonEnd=Core.buffExpiry
function PantheonChampion:NormalBuff(name)
 for _,b in ipairs(GetBuffs(myHero))do
  local e=pantheonEnd(b)
  if b.name and b.name:lower()==name and(b.count or 0)>0 and e and e>Game.Timer()then return b end
 end
end
function PantheonChampion:NormalChannel()
 local a=myHero.activeSpell
 return a and a.valid and not a.isStopped and(a.name=='PantheonE'or a.name=='PantheonR')and a.endTime and a.endTime>Game.Timer()or self:NormalBuff('pantheoneresists')~=nil
end
-- Mortal Will empowered Q bonus by level: 20 at 1 to 265.88 at 18 (wiki), on the standard growth curve.
function PantheonChampion:NormalMortalWill()
 local p=self.profile;local level=myHero.levelData and myHero.levelData.lvl
 if not Core.finite(level)then return 0 end
 local n=math.max(0,math.min(17,level-1))
 return p.mortalWillMin+(p.mortalWillMax-p.mortalWillMin)/17*n*(.7025+.0175*n)
end
-- Thrust and hurl: the execute row below 20% of maximum health on the health the spear finds (`health`,
-- default current) for both (wiki 2026-10-10); hurl +50% AP (execute +100% AP); the hurl's 50% reduction only
-- when another unit is in front (`clear`=true: this target is first on the ray; unknown counts as not first).
function PantheonChampion:NormalQDamage(target,held,health,clear)
 local rank=myHero:GetSpellData(_Q).level;if rank<=0 then return 0 end
 local p=self.profile;local ap=Core.finite(myHero.ap)and myHero.ap or 0
 health=Core.finite(health)and health or target.health
 local execute=Core.finite(health)and Core.finite(target.maxHealth)and target.maxHealth>0 and health/target.maxHealth<p.qExecuteHP
 local raw=execute and p.qExecute[rank]+p.qExecuteAD*myHero.bonusDamage+(held and p.qExecuteAP*ap or 0)
  or p.qBase[rank]+p.qAD*myHero.bonusDamage+(held and p.qHurlAP*ap or 0)
 -- Mortal Will's level-scaled damage is separate from the base Q. Native buff
 -- admission never depends on how many casts this controller requested.
 if self:NormalBuff(self.profile.passive)then raw=raw+self:NormalMortalWill()+self.profile.qAD*myHero.bonusDamage end
 if target.type==Obj_AI_Minion then raw=raw*(target.team==300 and p.qMonster or p.qMinion)end
 if held and clear~=true then raw=raw*p.qFalloff end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
end
-- No minion or other champion on the hurl's ray before `target` (the same prediction ray), else false.
function PantheonChampion:NormalRayClear(target,aim)
 local p=self.profile
 local blocked,objects=OrbamaPrediction:GetCollision(myHero.pos,aim,p.qFlightSpeed,p.qCast,p.qFlightRadius,
  {OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO},target.networkID)
 return not blocked and type(objects)=='table'and #objects==0
end
function PantheonChampion:NormalAim(target,held)
 if not IsValid(target)or not target.pos2D.onScreen then return nil end
 local spell=AbilityProfiles.Spell(myHero.charName,'Q',OrbamaPrediction)
 spell.Delay=self.profile.qCast -- 0.2 s (wiki 2026-10-10); the shared geometry row says .25
 spell.Range=held and AbilityProfiles.geometry.Pantheon.Q.flightRange or spell.Range
 if not held then spell.Speed=math.huge end
 spell.Collision=true;spell.CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}
 local pred=Core:Prediction(spell);pred:GetPrediction(target,myHero)
 if not pred:CanHit(target.type==Obj_AI_Minion and OrbamaPrediction.HITCHANCE_NORMAL or OrbamaPrediction.HITCHANCE_HIGH)then return nil end
 return pred.CastPosition
end
function PantheonChampion:NormalCastQ(target,node,context,rescue,extra)
 if self.charge or self.qUnresolved or not node.Q:Value()or not IsReady(_Q)then return false end
 local held=GetDistance(target.pos,myHero.pos)>self.QSpell.Range
 if held and not(node.HoldQ and node.HoldQ:Value())then return false end
 local aim=self:NormalAim(target,held);if not aim then return false end
 local id=target.networkID or target.handle
 local function permission()
  return IsValid(target)and(target.networkID or target.handle)==id and node.Q:Value()
   and(not rescue or self:NormalRescue(target,held))and(not extra or extra())
 end
 if not held then return Core:Cast(HK_Q,aim,{context=context,prevalidateWorldCast=true,validate=permission})end
 local a=Core.adapter;local caps=a:Capabilities();if not caps.ownedCharge then return false end
 local before=myHero.activeSpell and myHero.activeSpell.startTime
 local rank=myHero:GetSpellData(_Q).level
 local request,why=a:BeginCharge(HK_Q,{owner='PantheonQ',resource='slot:0',context=context,maxChargeMs=4000,expires=a:Now()+4000,
  ready=function()return Core:AttackWindupRemaining()<=0 end,
  mechanical=function()return permission()and IsReady(_Q)and not self:NormalChannel()and myHero:GetSpellData(_Q).name=='PantheonQ'and myHero:GetSpellData(_Q).level==rank end,
  reconcile=function()return self:NormalChargeClear()end})
 if not request then self.chargeStatus=why;return false end
 self.charge={id=request,target=target,targetID=id,node=node,context=context,permission=permission,rank=rank,previous=before,deadline=a:Now()+4000};return true
end
function PantheonChampion:NormalChargeClear()
 local active=myHero.activeSpell
 return not self:NormalBuff('pantheonq')and not(active and active.valid and not active.isStopped and active.isCharging)
  and Control.IsKeyDown and not Control.IsKeyDown(HK_Q)
end
function PantheonChampion:NormalCloseCharge(reason)
 local c=self.charge;if not c then return end;local a=Core.adapter
 for _,id in ipairs({c.release or c.id,c.id})do
  a:Cancel(id,reason);self.chargeCleanup[#self.chargeCleanup+1]=id
 end
 local r=a:Poll(c.id);if r and r.sentAt then self.qUnresolved=c.id end
 self.charge=nil;a:SetBlocked('PantheonQ','attack',false)
end
function PantheonChampion:NormalMaintainCharge()
 local a=Core.adapter
 for i=#self.chargeCleanup,1,-1 do local id=self.chargeCleanup[i]
  if not a:Poll(id)or a:Finish(id)or a:Reconcile(id)then if self.qUnresolved==id then self.qUnresolved=nil end;table.remove(self.chargeCleanup,i)end
 end
 local c=self.charge;if not c then return false end
 if not Core:InputAvailable()or not a:ContextValid({context=c.context},'continuation')or not c.permission()or a:Now()>c.deadline then self:NormalCloseCharge('context_ended_release_may_cast');return false end
 local r=a:Poll(c.id)
 if not r or r.state=='cancelled_before_send'or r.state=='send_uncertain'or r.interrupted then self:NormalCloseCharge('begin_unconfirmed');return false end
 if c.release then
  local release=a:Poll(c.release);local cast=myHero.activeSpell
  if release and release.sentGameTime and cast and cast.valid and not cast.isStopped and(cast.name=='PantheonQMissile'or cast.name=='PantheonQTap')and cast.startTime>=release.sentGameTime and cast.startTime~=c.previous then
   a:Observe(c.release,{kind='mechanical',at=a:Now(),source='owned_charge_release_native_stage',unique=true});self:NormalCloseCharge('release_observed')
  elseif not release or release.state=='cancelled_before_send'or release.state=='send_uncertain'or a:Now()>c.deadline then self:NormalCloseCharge('release_unconfirmed')end
  return true
 end
 local cast=myHero.activeSpell;local buff=self:NormalBuff('pantheonq')
 local start=cast and cast.valid and cast.isCharging and cast.name=='PantheonQ'and cast.startTime or buff and buff.startTime
 if not r.sentGameTime or not start or start<r.sentGameTime or start==c.previous then
  if r.sentAt and a:Now()-r.sentAt>500 then self:NormalCloseCharge('native_charge_missing')end;return true
 end
 if not c.observed then
  c.observed=a:Observe(c.id,{kind='mechanical',at=a:Now(),source='owned_charge_native_stage',unique=true})
 end
 if not c.observed then self:NormalCloseCharge('native_charge_ambiguous');return false end
 a:SetBlocked('PantheonQ','attack',true)
 if Game.Timer()-start<self.profile.qHold then return true end
 local aim=self:NormalAim(c.target,true);if not aim then return true end
 local options={expires=math.min(c.deadline,a:Now()+100),mechanical=function()
  local current=myHero.activeSpell;local b=self:NormalBuff('pantheonq')
  local fresh=current and current.valid and current.isCharging and current.name=='PantheonQ'and current.startTime or b and b.startTime
  return self.charge==c and c.permission()and fresh==start and Game.Timer()-start>=self.profile.qHold and myHero:GetSpellData(_Q).level==c.rank
 end,reconcile=function()return self:NormalChargeClear()end}
 if a:Capabilities().preparedChargeRelease then
  options.prevalidateWorldCast=true
  options.resolve=function()local fresh=self:NormalAim(c.target,true);return fresh and{position=fresh}or nil,'charge_ray_unavailable'end
  options.commitGuard=function()return self.charge==c and c.node.Q:Value()and IsValid(c.target)and(c.target.networkID or c.target.handle)==c.targetID and Core:InputAvailable()and a:Now()<=c.deadline end
 end
 local id,why=a:ReleaseCharge(c.id,aim,options)
 if id then c.release=id else self.chargeStatus=why;self:NormalCloseCharge('release_declined')end
 return true
end
function PantheonChampion:NormalRescue(target,held)
 local delay=(held and .6 or .25)+GetDistance(target.pos,myHero.pos)/2700
  local hp=Core:UnshieldedLegacyForecast(target,delay)
 if not hp or hp<=0 or hp>self:NormalQDamage(target,held,hp)then return false end
 return not(_G.SDK.Orbwalker:CanAttack()and _G.SDK.Data:IsInAutoAttackRange(myHero,target)and _G.SDK.Damage:GetAutoAttackDamage(myHero,target,true)>=target.health)
end
function PantheonChampion:NormalCombat(node,mode)
 local context=Core.executionContext or Core:ModeContext(mode)
 if node.Mana and not Core.manaAbove(node.Mana:Value())then return end
 local target=self:GetComboTarget(1200);if not IsValid(target)then return end
 if node.W:Value()and IsReady(_W)and GetDistance(target.pos,myHero.pos)<=600 then
  if self:CastUnit(_W,HK_W,target,600,function()return node.W:Value()end,{context=context})then
   Core:AfterCast(HK_W,function()if IsValid(target)then self:SetComboTarget(target)end end);return
  end
 end
 if node.Q:Value()and self:NormalCastQ(target,node,context)then return end
 if node.E:Value()and IsReady(_E)and GetDistance(target.pos,myHero.pos)<=self.ESpell.Range then self:CastE(target,function()return node.E:Value()end)end
end
function PantheonChampion:NormalFarm(jungle)
 local mode=jungle and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or _G.SDK.ORBWALKER_MODE_LANECLEAR
 if not _G.SDK.Orbwalker.Modes[mode]or not Menu.Clear.SpellFarm:Value()then return end
 local node=jungle and Menu.Clear.JungleClear or Menu.Clear.LaneClear
 if not Core.manaAbove(node.Mana:Value())then return end
 local targets=Core:DecisionUnits(jungle and 'GetMonsters'or'GetEnemyMinions')
  local context=Core.executionContext or Core:FarmContext(jungle and 'jungle'or'lane')
  if not jungle and IsUnderTurret(myHero)then return end
  for i=1,math.min(#targets,12)do local u=targets[i]
   if IsValid(u)and u.pos2D.onScreen then
    if node.E:Value()and IsReady(_E)and GetDistance(u.pos,myHero.pos)<=self.ESpell.Range and(jungle or self:LaneECount(u.pos,targets)>=node.ECount:Value())then
     if self:CastFarmE(u,function(_,resolved)
      return Menu.Clear.SpellFarm:Value()and node.E:Value()and(jungle or not IsUnderTurret(myHero)and self:LaneECount(resolved and resolved.position)>=node.ECount:Value())
     end)then return end
    end
   if node.Q:Value()and(jungle or self:NormalRescue(u,false))and self:NormalCastQ(u,node,context,not jungle)then return end
   if jungle and node.W:Value()and IsReady(_W)and GetDistance(u.pos,myHero.pos)<=600 then
    self:CastUnit(_W,HK_W,u,600,function()return Menu.Clear.SpellFarm:Value()and node.W:Value()and u.team==300 end,{context=context});return
   end
  end
 end
end
-- A charge the player started by hand: no attack while it lasts (an attack would end it). The Q key is never touched.
function PantheonChampion:NormalManualCharge()
 local a=myHero.activeSpell
 local manual=not self.charge and(self:NormalBuff('pantheonq')~=nil or a~=nil and a.valid and not a.isStopped and a.isCharging and a.name=='PantheonQ')
 if manual~=self.manualCharge then self.manualCharge=manual;Core.adapter:SetBlocked('PantheonQManual','attack',manual)end
end
-- Aegis Assault slams by itself when the channel ends; a recast after 0.3 s slams at once. It is recast only when
-- the slam kills an enemy in its cone now (0.25 s cast, 525, 55-255 +150% bonus AD).
function PantheonChampion:NormalSlamDamage(u)
 local rank=myHero:GetSpellData(_E).level;local base=self.profile.eSlam[rank];if not base then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,base+self.profile.eAD*myHero.bonusDamage)
end
function PantheonChampion:NormalInSlam(u,aim)
 local p=self.profile;if not IsValid(u)or not aim then return false end
 local x,z=u.pos.x-myHero.pos.x,u.pos.z-myHero.pos.z;local d=math.sqrt(x*x+z*z);local l=math.sqrt(aim.x*aim.x+aim.z*aim.z)
 if d>p.eSlamRadius+(u.boundingRadius or 0)or l<1 then return false end
 return d<1 or(x*aim.x+z*aim.z)/(d*l)>=math.cos(math.rad(p.eBlockAngle/2))
end
function PantheonChampion:NormalSlam()
 local a=myHero.activeSpell;local p=self.profile
 if not(a and a.valid and not a.isStopped and a.name=='PantheonE'and Core.finite(a.startTime))then return false end
 local aim=self.eAim;if not aim or aim.at<a.startTime-.5 then aim={x=myHero.dir and myHero.dir.x or 0,z=myHero.dir and myHero.dir.z or 0}end
 if self.slamFor==a.startTime or Game.Timer()-a.startTime<p.eRecastAfter or not Menu.KillSteal.E:Value()then return false end
 local start=a.startTime
 for _,u in ipairs(Core:DecisionUnits('GetEnemyHeroes'))do
  local function kills()
   local now=myHero.activeSpell
   return Menu.KillSteal.E:Value()and now and now.valid and not now.isStopped and now.startTime==start and self:NormalInSlam(u,aim)
    and Core:Lethal(u,p.eSlamCast,function()return self:NormalSlamDamage(u)end,{kind='physical'})
  end
  if IsValid(u)and kills()then
   self.slamFor=start
   Core:Trace('pantheon_e_slam',{elapsed=Game.Timer()-start,name=myHero:GetSpellData(_E).name})
   return Core:Cast(HK_E,nil,{owner='PantheonESlam',intentTarget=u,validate=kills})
  end
 end
 return false
end
function PantheonChampion:NormalTick()
 self:NormalManualCharge()
 if #self.eProbes>0 then self:EProbe()end
 local channel=self:NormalChannel();_G.SDK.Orbwalker:SetAttack(not channel)
 -- Directional E permits player movement. Only R's native channel blocks it.
 local active=myHero.activeSpell;_G.SDK.Orbwalker:SetMovement(not(channel and active and active.name=='PantheonR'))
 if self:NormalMaintainCharge()or ShouldWait()then return end
 if channel then self:NormalSlam();return end
 if IsCasting()then return end
 self:SemiR();if self:InterruptW()or self:GapcloseW()then return end;self:NormalKillSteal();local mode=GetMode()
 if mode=='Combo'then self:NormalCombat(Menu.Combo,mode)
 elseif mode=='Harass'then self:NormalCombat(Menu.Harass,mode)
  elseif mode=='LaneClear'then self:NormalFarmHarass();self:NormalLaneClear();self:NormalJungleClear()
 elseif mode=='LastHit'and Menu.LastHit.Q:Value()and Core.manaAbove(Menu.LastHit.Mana:Value())then
  local units=Core:DecisionUnits('GetEnemyMinions');for i=1,math.min(#units,12)do local u=units[i]
   if IsValid(u)and self:NormalRescue(u,false)and self:NormalCastQ(u,Menu.LastHit,Core:ModeContext('LastHit'),true)then return end
  end
 elseif mode=='Flee'then self:NormalFlee()end
end
-- One kill rule (Core:Lethal: health on arrival, typed shields, regeneration). Tap Q and the hurl count the
-- execute; the hurl beyond tap reach is charged by the owned charge and only halved when another unit is in
-- front; E counts the strikes that land inside a control the target is already under. Every validator
-- re-reads identity, range and the kill.
local finishNode={Q={Value=function()return Menu.KillSteal.Q:Value()end},HoldQ={Value=function()return true end}}
function PantheonChampion:NormalKillSteal()
 local units=Core:DecisionUnits('GetEnemyHeroes');local p=self.profile;local flight=AbilityProfiles.geometry.Pantheon.Q.flightRange
 for i=1,math.min(#units,10)do local u=units[i]
  if IsValid(u)and u.pos2D.onScreen then
   local id,handle=Core.id(u),u.handle;local d=GetDistance(u.pos,myHero.pos)
   local function same(range)return IsValid(u)and Core.id(u)==id and u.handle==handle and GetDistance(u.pos,myHero.pos)<=range end
   if Menu.KillSteal.Q:Value()and IsReady(_Q)and not self.charge and not self.qUnresolved then
    if d<=self.QSpell.Range then
     local function lethal()return Menu.KillSteal.Q:Value()and same(self.QSpell.Range)
      and Core:Lethal(u,p.qCast+GetDistance(u.pos,myHero.pos)/p.qFlightSpeed,function()return self:NormalQDamage(u,false)end,{kind='physical'})end
     local aim=lethal()and self:NormalAim(u,false)
     if aim and Core:Cast(HK_Q,aim,{intentTarget=u,prevalidateWorldCast=true,validate=lethal})then return end
    elseif d<=flight then
     local function lethal()
      if not Menu.KillSteal.Q:Value()or not same(flight)then return false end
      local aim=self:NormalAim(u,true);if not aim then return false end
      local clear=self:NormalRayClear(u,aim)
      return Core:Lethal(u,p.qHold+p.qCast+GetDistance(u.pos,myHero.pos)/p.qFlightSpeed,function()return self:NormalQDamage(u,true,nil,clear)end,{kind='physical'})
     end
     if lethal()and self:NormalCastQ(u,finishNode,{priority='interactive',condition=function()return Menu.KillSteal.Q:Value()end},false,lethal)then return end
    end
   end
   if Menu.KillSteal.W:Value()and IsReady(_W)and d<=600 and not IsUnderTurret2(u.pos)then
    local function lethal()return Menu.KillSteal.W:Value()and not IsUnderTurret2(u.pos)and Core:Lethal(u,.25,function()return self:GetWDmg(u)end,{kind='physical'})end
    if lethal()and self:CastUnit(_W,HK_W,u,600,lethal)then return end
   end
   if Menu.KillSteal.E:Value()and IsReady(_E)and d<=self.ESpell.Range then
    local function lethal()return Menu.KillSteal.E:Value()and Core:Lethal(u,self.ESpell.Delay,function()return self:EFinisherDmg(u)end,{kind='physical'})end
    if lethal()and self:CastE(u,lethal)then return end
   end
  end
 end
end
function PantheonChampion:NormalFlee()
 if Menu.Flee.E:Value()and IsReady(_E)then
  local target=GetTarget(self.ESpell.Range)
  if IsValid(target)then self:CastE(target,function()return Menu.Flee.E:Value()end)end
 end
end
function PantheonChampion:NormalLaneClear()return self:NormalFarm(false)end
function PantheonChampion:NormalJungleClear()return self:NormalFarm(true)end
function PantheonChampion:NormalFarmHarass()
 if self:ClearMode(false)and Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)then self:NormalCombat(Menu.Harass,'LaneClear')end
end

function PantheonChampion:RegisterNormalGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},hold={node=Menu.Combo.HoldQ,label='Charged ranged Q'},w={node=Menu.Combo.W,label='Combo W'},e={node=Menu.Combo.E,label='Combo E'},
  farm={node=Menu.Clear.SpellFarm,label='Spell farming'},harass={node=Menu.Clear.SpellHarass,label='Harass during clear'},last={node=Menu.LastHit.Q,label='Last Hit Q'},flee={node=Menu.Flee.E,label='Flee shield'},minimum={node=Menu.Misc.RMinRange,label='R minimum distance'}}
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Pantheon: combat','Pantheon: farming','Pantheon: shield and R'},function(page)
  if page==1 then return {title='Pantheon',subtitle='Mortal Will, tap spear and charged spear.',cards={
   {'COMBAT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..' for [[w]], [[q]] and [[e]]. W retains its target only after observed execution.'},
   {'CHARGED Q','Enable [[hold]] to prepare ranged Q beyond tap reach. The controller releases its own charge after a native charging stage is observed. Keep the triggering mode held.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. Harass has separate spell and charged-Q permissions. Mortal Will damage requires a current buff.'}},note='An interrupted or unconfirmed charge is cleaned up without blindly repeating its input.'}end
  if page==2 then return {title='Lane and jungle',subtitle='Choose when abilities may spend resources.',cards={
   {'CLEAR','Enable [[farm]] for lane and jungle spell farming. Lane Q rescues lethal CS; lane E requires its configured stationary-center count. Jungle Q/W/E have separate switches.'},
   {'LAST HIT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT)..' and [[last]] rescues CS. A ready lethal attack or confirmed incoming damage takes precedence.'},
   {'FARM HARASS','[[harass]] uses Harass spell permissions while Clear remains held. Releasing Clear cancels waiting casts.'}},note='Damage estimates use conservative held-Q falloff and do not promise every E strike will land.'}end
  return {title='Shield and Grand Starfall',subtitle='You choose movement and the landing destination.',cards={
   {'SHIELD','During an observed E, attacks are protected while movement stays available; Evade may raise E to block a hit it cannot dodge, and E slams early when the slam kills. [[flee]] aims E toward a nearby enemy during Flee.'},
   {'R ASSIST','Hold '..settings.key(Menu.Misc.SemiR)..' to request R toward the cursor beyond [[minimum]]. A destination beyond maximum reach is clamped.'},
   {'CHANNEL','An observed R protects both attacks and movement. Releasing the assist cancels waiting input; an already sent cast still belongs to the game.'}},note='R assist does not choose a safe landing location automatically.'}
 end,cfg,links,activate)
end


function PantheonChampion:FarmHarass()
	if self:ClearMode(false) and Menu.Clear.SpellHarass:Value() and not IsUnderTurret(myHero) then
		self:Harass()
	end
end

function PantheonChampion:FarmQUseful(target)
	if not IsValid(target) or target.team == 300 or target.team == myHero.team then return false end
	if IsUnderTurret(myHero) or myHero.pos:DistanceTo(target.pos) > self.QSpell.Range then return false end
	local impact = self.QSpell.Delay + myHero.pos:DistanceTo(target.pos)/self.QSpell.Speed
	local hp = _G.SDK.HealthPrediction:GetPrediction(target, impact)
	-- Certain Death is judged on the health the spear finds on arrival.
	return Core.finite(hp) and hp > 0 and self:GetQDmg(target,hp) >= hp
end

function PantheonChampion:LaneECount(position,minions)
	if not position then return 0 end
	local origin=myHero.pos
	local dx,dz=position.x-origin.x,position.z-origin.z
	local lengthSquared=dx*dx+dz*dz
	if lengthSquared<1 or lengthSquared>=math.huge then return 0 end
	local count,seen=0,{}
	minions=minions or _G.SDK.ObjectManager:GetEnemyMinions(self.ESpell.Range)
	for i=1,math.min(#minions,40) do
		local unit=minions[i]
		local id=Core.id(unit)
		local path=unit.pathing
		if id and not seen[id] and IsValid(unit) and unit.type==Obj_AI_Minion
			and unit.team~=300 and unit.team~=myHero.team and path and path.hasMovePath==false and not path.isDashing then
			seen[id]=true
			local x,z=unit.pos.x-origin.x,unit.pos.z-origin.z
			local along,cross=x*dx+z*dz,x*dz-z*dx
			if along>0 and x*x+z*z<=self.ESpell.Range^2 and cross*cross<=along*along*self.farmESlopeSquared then count=count+1 end
		end
	end
	return count
end

function PantheonChampion:CastFarmE(target,validate)
	return Core:Cast(HK_E,target.pos,{intentTarget=target,resolve=function()
		if not IsValid(target) then return nil,"farm_target_unavailable" end
		return {position={x=target.pos.x,y=target.pos.y,z=target.pos.z}}
	end,validate=validate})
end

function PantheonChampion:LaneClear()
	if not self:ClearMode(false) or not Menu.Clear.SpellFarm:Value() or IsUnderTurret(myHero) or not Core.manaAbove(Menu.Clear.LaneClear.Mana:Value()) then return end
	local minions = _G.SDK.ObjectManager:GetEnemyMinions(self.QSpell.Range)

	if Menu.Clear.LaneClear.E:Value() and IsReady(_E) then
		for i=1,math.min(#minions,40) do
			local minion=minions[i]
			if IsValid(minion) and minion.team ~= 300 and minion.pos2D.onScreen and myHero.pos:DistanceTo(minion.pos) <= self.ESpell.Range then
				if self:LaneECount(minion.pos,minions) >= Menu.Clear.LaneClear.ECount:Value() then
					if self:CastFarmE(minion,function(q,resolved)
						return not IsUnderTurret(myHero) and self:LaneECount(resolved and resolved.position or q.target)>=Menu.Clear.LaneClear.ECount:Value()
					end) then return end
				end
			end
		end
	end

	if Menu.Clear.LaneClear.Q:Value() and IsReady(_Q) then
		for _, minion in ipairs(minions) do
			if IsValid(minion) and minion.team ~= 300 and minion.pos2D.onScreen then
				if self:FarmQUseful(minion) then
					if self:CastUnit(_Q,HK_Q,minion,self.QSpell.Range,function()return self:FarmQUseful(minion)end) then return end
				end
			end
		end
	end
end

function PantheonChampion:LastHitUseful(target)
	if not Menu.LastHit.Q:Value() or not Core.manaAbove(Menu.LastHit.Mana:Value()) or not IsReady(_Q) or not self:FarmQUseful(target) then return false end
	if target.type ~= Obj_AI_Minion or _G.SDK.Attack:IsActive() then return false end
	if _G.SDK.Data:IsInAutoAttackRange(myHero,target) and _G.SDK.Orbwalker:CanAttack()
		and _G.SDK.Damage:GetAutoAttackDamage(myHero,target,true) >= target.health+(target.shieldAD or 0) then return false end
	return true
end

function PantheonChampion:LastHit()
	if not Menu.LastHit.Q:Value() or not Core.manaAbove(Menu.LastHit.Mana:Value()) or not IsReady(_Q) then return end
	local minions = _G.SDK.ObjectManager:GetEnemyMinions(self.QSpell.Range)
	for i=1,math.min(#minions,40) do
		local target=minions[i]
		if target.pos2D and target.pos2D.onScreen and self:LastHitUseful(target) then
			if self:CastUnit(_Q,HK_Q,target,self.QSpell.Range,function()return self:LastHitUseful(target)end) then return end
		end
	end
end

function PantheonChampion:JungleClear()
	if not self:ClearMode(true) or not Menu.Clear.SpellFarm:Value() or not Core.manaAbove(Menu.Clear.JungleClear.Mana:Value()) then return end
	local monsters = _G.SDK.ObjectManager:GetMonsters(self.QSpell.Range)
	table.sort(monsters, function(a, b) return a.maxHealth > b.maxHealth end)
	local monster = monsters[1]
	if not IsValid(monster) or not monster.pos2D.onScreen then return end

	local node = Menu.Clear.JungleClear
	local function allowed(spell) return function() return monster.team==300 and node[spell]:Value() and Core.manaAbove(node.Mana:Value()) end end
	-- Same order as against champions: the leap, the spear, then the channel.
	if node.W:Value() and IsReady(_W) then
		self:CastUnit(_W,HK_W,monster,self.WSpell.Range,allowed('W'))
		return
	end
	if node.Q:Value() and IsReady(_Q) then
		self:CastUnit(_Q,HK_Q,monster,self.QSpell.Range,allowed('Q'))
		return
	end
	if node.E:Value() and IsReady(_E) and myHero.pos:DistanceTo(monster.pos) <= self.ESpell.Range then
		self:CastFarmE(monster,allowed('E'))
	end
end

function PantheonChampion:SemiR()
	if not Menu.Misc.SemiR:Value() or not IsReady(_R) then return end
	local distance = myHero.pos:DistanceTo(mousePos)
	if distance < Menu.Misc.RMinRange:Value() then return end
	local castPosition = mousePos
	if distance > self.RSpell.Range then
		castPosition = myHero.pos:Extended(mousePos, self.RSpell.Range)
	end
	-- The policy re-reads the minimum distance; the bind and the slot are re-read here.
	Core:Cast(HK_R, castPosition, {owner='SemiR',validate=function() return Menu.Misc.SemiR:Value() and IsReady(_R) end})
end

-- Finishers use the shared kill rule (health on arrival, typed shields, spell
-- protection). Q and one Heartseeker strike include Certain Death on the
-- target's current health; later strikes of the channel are never counted.
function PantheonChampion:KillSteal()
	local enemies = _G.SDK.ObjectManager:GetEnemyHeroes(self.QSpell.Range)
	for _, target in ipairs(enemies) do
		if IsValid(target) and target.pos2D.onScreen then
			local function kills(spell,impact,damage,kind)
				return function() return Menu.KillSteal[spell]:Value() and Core:Lethal(target,impact,damage,{kind=kind}) end
			end
			local distance = myHero.pos:DistanceTo(target.pos)
			if Menu.KillSteal.Q:Value() and IsReady(_Q) then
				local lethal = kills('Q',self.QSpell.Delay+distance/self.QSpell.Speed,function() return self:GetQDmg(target) end,'physical')
				if lethal() and self:CastUnit(_Q,HK_Q,target,self.QSpell.Range,lethal) then return end
			end
			if Menu.KillSteal.W:Value() and IsReady(_W) and not IsUnderTurret2(target.pos) then
				local lethal = kills('W',.25,function() return self:GetWDmg(target) end,'magical')
				local function safe() return not IsUnderTurret2(target.pos) and lethal() end
				if lethal() and self:CastUnit(_W,HK_W,target,self.WSpell.Range,safe) then return end
			end
			if Menu.KillSteal.E:Value() and IsReady(_E) and distance <= self.ESpell.Range then
				local lethal = kills('E',self.ESpell.Delay,function() return self:EFinisherDmg(target) end,'physical')
				if lethal() and self:CastE(target,lethal) then return end
			end
		end
	end
end

function PantheonChampion:CastE(target,allowed)
	if not IsReady(_E) or allowed and not allowed() then return false end
	local prediction = Core:Prediction(self.ESpell)
	prediction:GetPrediction(target, myHero)
	if prediction:CanHit(2) then
		local identity,handle=Core.id(target),target.handle
		local aim=prediction.CastPosition
		local ok=Core:Cast(HK_E, aim, {intentTarget=target,prevalidateWorldCast=true,validate=function()
			return IsReady(_E) and IsValid(target) and Core.id(target)==identity and target.handle==handle
				and GetDistance(target.pos,myHero.pos)<=self.ESpell.Range and (not allowed or allowed())
		end})
		if ok then
			Core:AfterCast(HK_E,function()
				local dx,dz=aim.x-myHero.pos.x,aim.z-myHero.pos.z
				self.eAim={x=dx,z=dz,at=Game.Timer(),empowered=self.profile.id=='normal' and self:NormalBuff(self.profile.passive)~=nil}
				-- Development trace (Classic cone 400/32 vs wiki 600/80): where the target stood and whether it lost health.
				if Core.logger and IsValid(target) then
					local tx,tz=target.pos.x-myHero.pos.x,target.pos.z-myHero.pos.z
					local angle=math.deg(math.abs(math.atan2(dx*tz-dz*tx,dx*tx+dz*tz)))
					self.eProbes[#self.eProbes+1]={target=target,hp=target.health,at=Game.Timer(),distance=math.sqrt(tx*tx+tz*tz),angle=angle}
					if #self.eProbes>4 then table.remove(self.eProbes,1) end
				end
			end)
		end
		return ok
	end
	return false
end

-- Certain Death (Classic passive, profile source): Spear Shot and Heartseeker
-- deal double damage to any enemy unit below 15% of its MAXIMUM health, only
-- once Heartseeker is learned. `health` is the health the hit finds (a forecast
-- for last hits); it defaults to the current value.
function PantheonChampion:Execute(target,health)
	local p=self.profile
	if not p.executeHP or not p.executeMultiplier or p.executeNeedsE and myHero:GetSpellData(_E).level<1 then return 1 end
	health=health or target.health
	if not Core.finite(health) or not Core.finite(target.maxHealth) or target.maxHealth<=0 then return 1 end
	return health<target.maxHealth*p.executeHP and p.executeMultiplier or 1
end

function PantheonChampion:GetQDmg(target,health)
	if self.profile.id=='normal'then return self:NormalQDamage(target,false,health)end
	local level = myHero:GetSpellData(_Q).level
	local base = self.profile.qBase[level]
	if not base then return 0 end
	local damage = (base + myHero.bonusDamage * self.profile.qAD) * self:Execute(target,health)
	return _G.SDK.Damage:CalculateDamage(myHero, target, _G.SDK.DAMAGE_TYPE_PHYSICAL, damage)
end

function PantheonChampion:GetWDmg(target)
	if self.profile.id=='normal'then
	 local rank=myHero:GetSpellData(_W).level;if rank<=0 or not myHero.bonusHealth then return 0 end
	 local raw=target.maxHealth*(self.profile.wHP[rank]+self.profile.wBonusHP*myHero.bonusHealth+(self.profile.wHPPerAP or 0)*(myHero.ap or 0))
	 if target.team==300 then raw=math.max(self.profile.wMonsterMin,math.min(raw,self.profile.wMonsterMax))end
	 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
	end
	local level = myHero:GetSpellData(_W).level
	local base = self.profile.wBase[level]
	if not base then return 0 end
	return _G.SDK.Damage:CalculateDamage(myHero, target, _G.SDK.DAMAGE_TYPE_MAGICAL, base + myHero.ap * self.profile.wAP)
end

function PantheonChampion:GetEDmg(target,health)
	if self.profile.id=='normal'then
	 if myHero:GetSpellData(_E).level<=0 then return 0 end
	 -- One strike: 1/12 of total AD (100% AD over the 1.5 s channel, wiki 2026-10-10; was .167, two strikes).
	 local raw=myHero.totalDamage*self.profile.eStrikeAD
	 if target.type==Obj_AI_Minion and target.team~=300 then raw=raw*.5 end
	 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
	end
	local level = myHero:GetSpellData(_E).level
	local base = self.profile.eBase[level]
	if not base then return 0 end
	-- Authorization counts one predicted strike. Later channel hits are not secured.
	local damage = (base + myHero.bonusDamage * self.profile.eAD) * self:Execute(target,health)
	if target.type == Obj_AI_Minion and target.team ~= 300 then damage = damage * self.profile.eMinion end
	return _G.SDK.Damage:CalculateDamage(myHero, target, _G.SDK.DAMAGE_TYPE_PHYSICAL, damage)
end

-- Strikes that surely land: one, or every strike of the channel that falls inside a hard control the target is
-- already under (OrbamaPrediction immobile time), each with Certain Death on the health the previous one left.
function PantheonChampion:EStrikes(target)
	local p=self.profile
	local held=OrbamaPrediction.GetImmobileDuration and OrbamaPrediction:GetImmobileDuration(target)
	if not Core.finite(held) or held<=self.ESpell.Delay then return 1 end
	local interval=p.eStrikeInterval or .25;local most=p.id=='normal' and p.eStrikesMax or p.eStrikes or 1
	return math.max(1,math.min(most,math.floor((held-self.ESpell.Delay)/interval)+1))
end
function PantheonChampion:EFinisherDmg(target)
	local strikes=self:EStrikes(target)
	if strikes<=1 or self.profile.id=='normal' then return self:GetEDmg(target)*strikes end
	local health,total=target.health,0
	for i=1,strikes do local d=self:GetEDmg(target,health);total=total+d;health=health-d;if health<=0 then break end end
	return total
end

function PantheonChampion:GetEChannelDmg(target)
	-- Nominal potential only, kept separate from every lethal authorization path.
	return self:GetEDmg(target) * 3
end

function PantheonChampion:RegisterGuide(guide, settings)
	if self.profile.id=='normal'then return self:RegisterNormalGuide(guide,settings)end
	local nodes={
		comboQ={node=Menu.Combo.Q,label="Combo Q"},comboW={node=Menu.Combo.W,label="Combo W"},comboE={node=Menu.Combo.E,label="Combo E"},
		harassQ={node=Menu.Harass.Q,label="Harass Q"},harassW={node=Menu.Harass.W,label="Harass W"},harassE={node=Menu.Harass.E,label="Harass E"},
		farm={node=Menu.Clear.SpellFarm,label="Spell farming"},farmHarass={node=Menu.Clear.SpellHarass,label="Harass during clear"},
		laneQ={node=Menu.Clear.LaneClear.Q,label="Lane last-hit Q"},laneE={node=Menu.Clear.LaneClear.E,label="Lane E"},
		count={node=Menu.Clear.LaneClear.ECount,label="E stationary-center threshold"},
		jungleQ={node=Menu.Clear.JungleClear.Q,label="Jungle Q"},jungleW={node=Menu.Clear.JungleClear.W,label="Jungle W"},jungleE={node=Menu.Clear.JungleClear.E,label="Jungle E"},
		killQ={node=Menu.KillSteal.Q,label="Lethal Q"},killW={node=Menu.KillSteal.W,label="Lethal W"},killE={node=Menu.KillSteal.E,label="Lethal E"},
		minR={node=Menu.Misc.RMinRange,label="R minimum distance"},
		lastQ={node=Menu.LastHit.Q,label="Last Hit Q"},
		drawQ={node=Menu.Draw.Q,label="Q range"},drawW={node=Menu.Draw.W,label="W range"},drawE={node=Menu.Draw.E,label="E range"}
	}
	local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
	return guide:Register("champion",{"Pantheon: quick start","Pantheon: farming","Pantheon: channels and R"},function(page)
		if page==1 then return {title="Classic Pantheon",subtitle="The targeted-spear Classic kit.",cards={
			{"COMBO","Hold "..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..". [[comboW]] approaches and stuns; [[comboQ]] throws a targeted spear; [[comboE]] then channels with prediction. Each spell has its own permission."},
			{"HARASS","Hold "..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..". [[harassQ]] is enabled by default. [[harassW]] and [[harassE]] are separate choices. Releasing the initiating mode cancels waiting work."},
			{"TARGET","After observed W execution, the controller retains that living target for up to two seconds while it remains in spell range. A queued or rejected W does not start the reservation."}},note="This controller does not implement Normal Pantheon's charged spear, Mortal Will or directional shield."}end
		if page==2 then return {title="Lane and jungle",subtitle="Enable spell farming deliberately.",cards={
			{"LANE","Clear uses "..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..". Toggle [[farm]] with "..settings.key(Menu.Clear.SpellFarm)..". [[laneQ]] requires a living minion predicted to die to Q. [[laneE]] uses [[count]] inside a conservative narrow cone. Moving minions are not counted; this is not a guarantee of all channel hits."},
			{"JUNGLE","Jungle clear uses "..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_JUNGLECLEAR)..". [[jungleW]], [[jungleE]] and [[jungleQ]] have separate permissions. E stays bound to the chosen monster and refreshes its aim before dispatch."},
			{"LAST HIT","Hold "..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT).." for [[lastQ]]. It avoids an active attack and prefers an available lethal attack in range. [[farmHarass]] uses Harass permissions during Clear, bound to Clear rather than the Harass key."}},note="Flee spell assistance is not implemented. Farming damage and impact-time estimates still need live validation."}end
		return {title="Channel control and Grand Skyfall",subtitle="Choose the destination before committing.",cards={
			{"R ASSIST","Hold "..settings.key(Menu.Misc.SemiR).." to request R toward the cursor, beyond [[minR]]. A destination beyond maximum range is clamped. This is a manual destination request, not an automatic safe-landing plan."},
			{"CHANNELS","Recognized E and R channels protect attack and movement permissions. Stopped or expired cast records no longer keep those protections by themselves. A fresh channel buff can still provide independent evidence."},
			{"AUTOMATION","[[killQ]], [[killW]] and [[killE]] run independently of held combat modes. Q and E count Certain Death (double damage below 15% maximum health once E is learned); E counts one strike, or every strike that lands inside a stun the target is already under. An enemy who channels within W range, or dashes onto you, is stunned without a mode key, never under a turret. Neither estimate proves a hit. Optional [[drawQ]], [[drawW]] and [[drawE]] show ready spell ranges."}},note="Releasing the R assist cancels waiting input. It does not undo an R already sent or guarantee cancellation of an active game channel."}
	end,cfg,links,activate)
end

function PantheonChampion:EProbe()
	for i=#self.eProbes,1,-1 do local p=self.eProbes[i]
		local hit=IsValid(p.target) and p.target.health<p.hp-1
		if hit or Game.Timer()-p.at>(self.profile.eChannel or self.profile.eBlockDuration or 1)+.3 then
			Core:Trace('pantheon_e_cone',{profile=self.profile.id,distance=p.distance,angle=p.angle,hit=hit and true or false});table.remove(self.eProbes,i)
		end
	end
end

function PantheonChampion:Draw()
	if myHero.dead then return end
	if Menu.Draw.R:Value() and IsReady(_R) then Draw.Circle(myHero.pos, self.RSpell.Range, 1, Draw.Color(255, 244, 160, 66)) end
	if self.profile.id=='normal' and Menu.Draw.Q:Value() and IsReady(_Q) and Menu.Combo.HoldQ:Value() then
		Draw.Circle(myHero.pos, AbilityProfiles.geometry.Pantheon.Q.flightRange, 1, Draw.Color(255, 66, 200, 113))
	end
	if Menu.Draw.Q:Value() and IsReady(_Q) then Draw.Circle(myHero.pos, self.QSpell.Range, 1, Draw.Color(255, 66, 244, 113)) end
	if Menu.Draw.W:Value() and IsReady(_W) then Draw.Circle(myHero.pos, self.WSpell.Range, 1, Draw.Color(255, 244, 238, 66)) end
	if Menu.Draw.E:Value() and IsReady(_E) then Draw.Circle(myHero.pos, self.ESpell.Range, 1, Draw.Color(255, 66, 229, 244)) end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:RegisterPolicy({
    damageTypes={Q='physical',W='magical',E='physical'},
    methods={
        NormalCombat=function()return Core:ModeContext(GetMode())end,
        NormalLaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,
        NormalJungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
        NormalFarmHarass=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)end)end,
        NormalKillSteal=function()return {priority='interactive'}end,
        InterruptW=function()return {priority='interactive'}end,
        GapcloseW=function()return {priority='interactive'}end,
        NormalSlam=function()return {priority='interactive'}end,
        KillSteal=function()return {priority='interactive'}end,
        NormalFlee=function()return Core:ModeContext('Flee')end,


        Combo=function()return Core:ModeContext("Combo")end,
        Harass=function()return Core:ModeContext("Harass")end,
        LastHit=function()return Core:ModeContext("LastHit")end,
        LaneClear=function(self)return Core:ModeContext("LaneClear",function()return self:ClearMode(false) and Menu.Clear.SpellFarm:Value()end)end,
        JungleClear=function(self)return Core:ModeContext("LaneClear",function()return self:ClearMode(true) and Menu.Clear.SpellFarm:Value()end)end,
        FarmHarass=function(self)return Core:ModeContext("LaneClear",function()return self:ClearMode(false) and Menu.Clear.SpellHarass:Value() and not IsUnderTurret(myHero)end)end,
        SemiR=function()return Core:HeldContext(function()return Menu.Misc.SemiR:Value()end)end,
    },
    exceptions={non_interrupting_summoner=true},
    -- The finisher's own kill check counts the E strikes that land inside a control (EFinisherDmg); the shared
    -- KillSteal policy adds the difference to its one-strike GetEDmg check.
    killBonus=function(self,q,slot)if slot==_E and q.object then return self:EFinisherDmg(q.object)-self:GetEDmg(q.object)end;return 0 end,
    channel=function(self,q)return q.owner=='PantheonESlam' or not self:IsChanneling() end,
    validate=function(self,q,slot,resolved)
        if slot==_R and q.owner=='SemiR' then
            local position=resolved and resolved.position or q.target
            return position and GetDistance(position,myHero.pos)>=Menu.Misc.RMinRange:Value()
        end
        if slot==_E and q.object then return GetDistance(q.object.pos,myHero.pos)<=self.ESpell.Range end
        return true
    end,
})

PantheonChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Pantheon"]="Pantheon"}
local normalSupported={["Pantheon"]=true}

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
