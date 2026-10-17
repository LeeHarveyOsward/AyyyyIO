return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
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
modules["autojungle"]=_G.OrbamaFamily:Require("12c9f19e56e973236e0bcff8c7222940806f07b1c7bf1e88042f1b34eddcc520")
modules["combatMechanics"]=_G.OrbamaFamily:Require("9e32908504b1e01599ffc8a55f7d52a3a92a974d794c085ee29160c628b85e38")
modules["gameplay"]=_G.OrbamaFamily:Require("038c846d2b126f3f80142b2c55b4ace9ee78a9347b22cb2f242dcb5ed5185f2f")
modules["prediction"]=(function(require) return _G.OrbamaFamily:Factory("223a065ecf7929552d5f8dafcf2453fd9147cd6e9940ce97dc80add73aa9913b")(require) end)(require)
modules["policies"]=(function(require) return _G.OrbamaFamily:Factory("e26056d70e5dac93ebb21f4ae4fe96863a06915a942bb75b795567a932448a23")(require) end)(require)
modules["core"]=(function(require) return _G.OrbamaFamily:Factory("454102f4f573681afa019a39b08ec2a6adca91fb526d8515918046a8d866415c")(require) end)(require)
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
if champion=="Blitzcrank" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Blitzcrank',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.03
-- Q geometry comes from the profile (CombatProfiles/blitzcrank.lua and its provenance):
-- RocketGrabMissile speed 1800, half-width 70, castFrame 7.5 (0.25 s). The Classic
-- 0.25 s windup also matches live castEnd-castStart. Delay is cast start to launch;
-- the prediction provider adds travel time and latency once.
local SPELL_SHIELD={[4]=true,[16]=true}
local SLOW={[11]=true}
local finite=Core.finite

local BlitzcrankChampion=class("BlitzcrankChampion")

function BlitzcrankChampion:__init()
	print("AyyyyIO - Blitzcrank loaded")
	self.profile=assert(BlitzProfile(myHero.charName),'Unsupported Blitzcrank profile')
	-- Decision range: the profile value, or the host's own Q range when that is shorter (Classic: pinned 1050
	-- vs installed asset 1080; the shorter one never casts a hook that cannot reach).
	local qRange=self:QDecisionRange()
	self.QSpell = { Type = OrbamaPrediction.SPELLTYPE_LINE, Delay = self.profile.qDelay, Radius = self.profile.qRadius, Range = qRange, Speed = self.profile.qSpeed, Collision = true, CollisionTypes = { OrbamaPrediction.COLLISION_MINION, OrbamaPrediction.COLLISION_ENEMYHERO, OrbamaPrediction.COLLISION_YASUOWALL } }
	self.ERange, self.RRange = 275, self.profile.rRange
	self.RSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=self.profile.rDelay,Radius=self.RRange,Range=self.RRange,Speed=math.huge,Collision=false}
	self:LoadMenu()
	self.turretTraced={}
	Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
	self:OfferHaste()
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
	_G.SDK.Orbwalker:OnPostAttack(function(args) self:OnPostAttack(args) end)
end

-- A host range outside 800..1300 is not a Rocket Grab range and is ignored.
function BlitzcrankChampion:QDecisionRange()
	local host=myHero:GetSpellData(_Q).range
	host=finite(host)and host>=800 and host<=1300 and host or nil
	return math.min(self.profile.qRange,host or math.huge)
end

function BlitzcrankChampion:LoadMenu()
	local icon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/" .. myHero.charName .. ".png"
	Menu = MenuElement({ type = MENU, id = "Classic_AIO_" .. myHero.charName, name='AyyyyIO - Blitzcrank', leftIcon = icon })
	Menu:MenuElement({ type = MENU, id = "Combo", name = "Combo" })
	for _, s in ipairs({ "Q", "W", "E", "R" }) do
		Menu.Combo:MenuElement({ id = s, name = "Use " .. s, value = true })
	end
	Menu.Combo:MenuElement({ id = "RCount", name = "Enemies in range needed for R", value = 2, min = 1, max = 5, step = 1 })
	Menu.Combo:MenuElement({id='WHealth',name='Use W to chase or to fight among several enemies only above health %',value=45,min=0,max=100,step=5,menu=false})
	Menu:MenuElement({type=MENU,id='Hook',name='Hook (Q)'})
	Menu.Hook:MenuElement({id='Semi',name='Hook the enemy nearest the cursor',key=string.byte('T')})
	-- 250: an enemy already in melee is knocked up by E; pulling it wastes the hook (the held key ignores this).
	Menu.Hook:MenuElement({id='Min',name='Hook only beyond distance',value=250,min=0,max=self.QSpell.Range,step=25,menu=false})
	Menu.Hook:MenuElement({id='Max',name='Hook only within distance',value=self.QSpell.Range,min=100,max=self.QSpell.Range,step=25,menu=false})
	Menu.Hook:MenuElement({id='UnsafePull',name='Hook while standing under an enemy turret',value=false})
	Menu.Hook:MenuElement({type=MENU,id='Targets',name='Enemy champions Q may hook'})
	self:DiscoverTargets()
	Menu:MenuElement({ type = MENU, id = "Harass", name = "Harass" })
	Menu.Harass:MenuElement({ id = "Q", name = "Use Q", value = true })
	Menu.Harass:MenuElement({ id = "E", name = "Use E", value = true })
	Menu.Harass:MenuElement({ id = "Mana", name = "Only above mana %", value = 45, min = 0, max = 100, step = 5 })
	Menu:MenuElement({ type = MENU, id = "Clear", name = "Farming" })
	Menu.Clear:MenuElement({ id = "Enabled", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(v) CheckChatBlock(Menu.Clear.Enabled, v) end })
	Menu.Clear:MenuElement({ id = "W", name = "Use W on jungle monsters", value = true })
	Menu.Clear:MenuElement({ id = "E", name = "Use E on jungle monsters", value = true })
	Menu.Clear:MenuElement({ id = "R", name = "Minions in range needed for R (0 = never)", value = 5, min = 0, max = 8, step = 1 })
	Menu.Clear:MenuElement({ id = "Mana", name = "Only above mana %", value = 30, min = 0, max = 100, step = 5 })
	Menu:MenuElement({ type = MENU, id = "KillSteal", name = "Finish kills without holding a mode key" })
	Menu.KillSteal:MenuElement({ id = "Q", name = "Use Q", value = true })
	Menu.KillSteal:MenuElement({ id = "R", name = "Use R", value = true })
	Menu:MenuElement({ type = MENU, id = "Misc", name = "Behaviour" })
	-- Interrupts (Q and R), hooks on immobilised enemies and on enemies dashing into range are fixed behaviour:
	-- nobody plays Blitzcrank without them. They share the automatic mana limit below.
	if self.profile.shieldBreak then Menu.Misc:MenuElement({id='ShieldR',name='Combo: R to break a large enemy shield',value=true})end
	Menu.Misc:MenuElement({id='MultiR',name='Cast R without holding a mode key',value=true})
	Menu.Misc:MenuElement({id='MultiRCount',name='Enemy champions that R must hit',value=3,min=2,max=5,step=1})
	-- Hooks without a mode key need a reason (immobilised, dashing in, channelling), an allowed target and the mana limit; hooking anyone at all stays opt-in.
	Menu.Misc:MenuElement({id='FreeHook',name='Hook any likely target without a mode key',value=false})
	Menu.Misc:MenuElement({id='AutoMana',name='Those automatic hooks only above mana %',value=45,min=0,max=100,step=5})
	Menu.Misc:MenuElement({id='FleeW',name='Flee: use W when enemies are near',value=true})
	Menu:MenuElement({ type = MENU, id = "Draw", name = "Drawings" })
	Menu.Draw:MenuElement({ id = "Q", name = "Hook distance band and the next hook target", value = false })
	for _, s in ipairs({ "E", "R" }) do
		Menu.Draw:MenuElement({ id = s, name = s .. " range", value = false })
	end
end

function BlitzcrankChampion:EActive()
	local present,buff=GetBuffData(myHero,self.profile.eBuff)
	local expires=Core.buffExpiry(buff)
	return present and(not expires or expires>Game.Timer())
end

function BlitzcrankChampion:DiscoverTargets()
	for _,target in ipairs(Core:DecisionUnits('GetEnemyHeroes'))do
		local name=target.charName
		if type(name)=='string'and not Menu.Hook.Targets[name]then
			Menu.Hook.Targets:MenuElement({id=name,name=name:gsub('^Jade_',''),value=true})
		end
	end
end

function BlitzcrankChampion:QCost()
	return math.max(self.profile.qCost,myHero:GetSpellData(_Q).mana or 0)
end

function BlitzcrankChampion:PotentialBarrierAfter(cost)
	local mana=self.profile.barrierUsesCurrent and math.max(0,myHero.mana-cost)or myHero.maxMana
	return mana*self.profile.barrierMana
end

-- Active buff of one of the given native types (expireTime=0 falls back to endTime).
function BlitzcrankChampion:HasBuffType(unit,types)
	local now=Game.Timer()
	for _,buff in ipairs(GetBuffs(unit))do
		if types[buff.type]and(buff.count or 1)>0 then
			local expires=Core.buffExpiry(buff)
			if not finite(expires)or expires>now then return true end
		end
	end
	return false
end

-- manual: the held semi-manual key is explicit player intent and may pull under a turret.
-- close: a lethal hook is a damage spell; the minimum distance only guards the pull.
function BlitzcrankChampion:HookAllowed(target,manual,close)
	if not IsValid(target)or not target.pos2D or not target.pos2D.onScreen then return false end
	local setting=Menu.Hook.Targets[target.charName]
	local distance=GetDistance(target.pos,myHero.pos)
	return setting and setting:Value()and(manual or close or distance>=Menu.Hook.Min:Value())
		and distance<=math.min(self.QSpell.Range,Menu.Hook.Max:Value())
		and myHero.mana>=self:QCost()
		and(manual or Menu.Hook.UnsafePull:Value()or not IsUnderTurret(myHero))
		and not self:HasBuffType(target,SPELL_SHIELD)
end

-- Required provider hit chance for this target now, or nil and a refusal reason.
-- Immobile/channeling targets keep the caller's base chance (no escalation). Dashes are only hooked when the
-- dash ends well inside range. Long or fast walking targets need the provider's
-- high chance (stable straight path); a slow relaxes the long-range threshold.
function BlitzcrankChampion:QRequirement(target,base,manual)
	if IsHardCC(target)or Core:IsChannelCast(target.activeSpell)then return base,'immobile'end
	if manual then return base,'unfiltered'end
	local path=target.pathing
	if path and path.isDashing then
		local finish=path.endPos
		if not finish or GetDistance(finish,myHero.pos)>self.QSpell.Range*.85 then return nil,'dash_far'end
		return base,'dash'
	end
	local fraction=GetDistance(target.pos,myHero.pos)/self.QSpell.Range
	local slowed=self:HasBuffType(target,SLOW)
	local fast=not slowed and(target.ms or 0)>=430
	local need=base
	if fraction>(slowed and .9 or .75)or fast and fraction>.55 then need=math.max(need,3)end
	return need,slowed and'slowed'or fast and'fast'or fraction>.75 and'long'or'normal'
end

-- Enemies threatening an ally right now (shared Core:PeelTarget: dashing onto it, attacking or casting at
-- it, a melee champion in reach), by network id. One pass per decision, not per candidate.
function BlitzcrankChampion:PeelSources()
	local sources={}
	for _,ally in ipairs(Core:DecisionUnits('GetAllyHeroes'))do
		if ally~=myHero and not ally.isMe and IsValid(ally)then
			local enemy=Core:PeelTarget(ally,1.5)
			if enemy and enemy.networkID then sources[enemy.networkID]=true end
		end
	end
	return sources
end

-- 3 lethal, 2 attacking/diving an ally (peel), 1 crowd-controlled, 0 other.
function BlitzcrankChampion:HookTier(target,peel)
	if self:GetQDmg(target)>=target.health+(target.shieldAP or 0)then return 3 end
	peel=peel or self:PeelSources()
	if peel[target.networkID]then return 2 end
	for _,ally in ipairs(Core:DecisionUnits('GetAllyHeroes'))do
		if ally~=myHero and not ally.isMe and IsValid(ally)
			and ally.health<ally.maxHealth*.5 and GetDistance(ally.pos,target.pos)<=450 then return 2 end
	end
	return IsHardCC(target)and 1 or 0
end

-- Orbama target priority 1 (the lowest; user-editable): a tank. Unknown names read 5, never low.
function BlitzcrankChampion:LowPriority(target)
	local selector=_G.SDK.TargetSelector
	if type(selector.GetPriority)~='function'then return false end
	local ok,value=pcall(selector.GetPriority,selector,target)
	return ok and finite(value)and value<=1
end

-- Ordered eligible hook targets. Target selector consent (including selected-only)
-- filters every entry; preference tier then the selector's choice then distance.
-- A lowest-priority champion (a tank) is dropped unless the hook kills, peels or lands on a crowd-controlled
-- target; keepLow keeps it (marked in list.low) for the automatic reasons that are worth it on anyone.
function BlitzcrankChampion:HookCandidates(keepLow)
	self:DiscoverTargets()
	local allowed={}
	for _,target in ipairs(Core:DecisionUnits('GetEnemyHeroes'))do
		if #allowed<5 and self:HookAllowed(target)then allowed[#allowed+1]=target end
	end
	local selector,damage=_G.SDK.TargetSelector,_G.SDK.DAMAGE_TYPE_MAGICAL
	local primary=selector:GetTarget(allowed,damage)
	if not primary then return {low={}}end
	local list,tier,distance,low={},{},{},{}
	local peel=self:PeelSources()
	for _,target in ipairs(allowed)do
		if target==primary or selector:GetTarget({target},damage)==target then
			local t=self:HookTier(target,peel)
			local lowest=t<1 and self:LowPriority(target)
			if not lowest or keepLow then
				list[#list+1]=target;tier[target]=t;distance[target]=GetDistance(target.pos,myHero.pos)
				if lowest then low[target]=true end
			end
		end
	end
	table.sort(list,function(a,b)
		if tier[a]~=tier[b]then return tier[a]>tier[b]end
		if(a==primary)~=(b==primary)then return a==primary end
		return distance[a]<distance[b]
	end)
	list.low=low
	return list
end

function BlitzcrankChampion:HookTarget()
	return self:HookCandidates()[1]
end

-- Try up to three ordered candidates; one poorly predicted target does not hide another.
function BlitzcrankChampion:TryHooks(candidates,hc)
	for i=1,math.min(3,#candidates)do
		if self:CastQ(candidates[i],hc)then return true end
	end
	return false
end

function BlitzcrankChampion:AttackReach(target)
	return math.min(self.ERange,(myHero.range or 125)+(myHero.boundingRadius or 0)+(target.boundingRadius or 0))
end

function BlitzcrankChampion:EAllowed(target)
	local attack=self.attackWitness
	return IsValid(target)and not self:EActive()and attack and attack.target==target.networkID
		and Game.Timer()>=attack.at and Game.Timer()-attack.at<=.35
		and GetDistance(target.pos,myHero.pos)<=self:AttackReach(target)
end

-- Combo: Power Fist before the first hit. The knock-up on the opening attack is how the champion is played and
-- an enemy in reach now may have walked out after a plain attack. While an own attack is winding up the cast
-- waits: once that attack lands EAllowed spends E as the attack reset instead.
function BlitzcrankChampion:ComboEAllowed(target)
	if self:EAllowed(target)then return true end
	return IsValid(target)and target.type==Obj_AI_Hero and not self:EActive()and Core:AttackWindupRemaining()<=0
		and GetDistance(target.pos,myHero.pos)<=self:AttackReach(target)
end

function BlitzcrankChampion:ObserveAttack()
	local previous=self.attackWitness
	self.attackWitness=ObserveAttack(_G,previous,function(id)
		for _,method in ipairs({'GetEnemyHeroes','GetMonsters'})do
			for _,target in ipairs(Core:DecisionUnits(method))do
				if target.networkID==id or target.handle==id then return target end
			end
		end
	end)
	-- An observed Power Fist attack on a champion is a knock-up, like a pull: it opens the same R follow-up.
	local w=self.attackWitness
	if w and w~=previous and w.object and w.object.type==Obj_AI_Hero then
		local cast=myHero.activeSpell;local name=cast and cast.valid and cast.name
		if type(name)=='string'and name:lower()==self.profile.eAttack:lower()then
			self.grab={target=w.object,targetID=w.target,at=w.at,kind='knockup'}
		end
	end
end

function BlitzcrankChampion:ChaseAllowed(target)
	if not IsValid(target)or IsUnderTurret(myHero)or IsUnderTurret(target)then return false end
	if myHero.health/math.max(1,myHero.maxHealth)*100<Menu.Combo.WHealth:Value()then return false end
	local distance=GetDistance(target.pos,myHero.pos)
	if distance<=self:AttackReach(target)or distance>self.QSpell.Range then return false end
	local closing=(myHero.ms or 0)*(1+self.profile.wMinimumBonus)-(target.ms or 0)
	return closing>0 and (distance-self:AttackReach(target))/closing<self.profile.wDuration-self.profile.wSlow
		and GetEnemyCount(600,myHero.pos)<=2
end

function BlitzcrankChampion:WRank()
	local level=myHero:GetSpellData(_W).level or 0
	return level>=1 and math.min(level,5)or nil
end

-- Mean Overdrive movement bonus over the first `seconds`: Normal decays linearly from the rank value to the
-- minimum over wMoveDecay; Classic is constant for its whole duration.
function BlitzcrankChampion:WSpeedBonus(seconds)
	local p,rank=self.profile,self:WRank()
	local start=rank and p.wMoveSpeed[rank]
	if not start then return 0 end
	local decay,floor=p.wMoveDecay,p.wMinimumBonus
	if not decay or seconds<=0 then return start end
	if seconds<=decay then return start-(start-floor)*seconds/(2*decay)end
	return((start+floor)/2*decay+floor*(seconds-decay))/seconds
end

-- Normal Overdrive ends with a 30 % self-slow; with several enemies near and low health that is a risk.
function BlitzcrankChampion:WRiskAllowed()
	if self.profile.wSlowAmount<=0 then return true end
	return GetEnemyCount(600,myHero.pos)<=1 or myHero.health/math.max(1,myHero.maxHealth)*100>=Menu.Combo.WHealth:Value()
end

-- A target that stays in reach: hard crowd control, or an observed pull / Power Fist knock-up in the last 1.5 s.
function BlitzcrankChampion:HeldTarget(target)
	if IsHardCC(target)then return true end
	return self:GrabTarget(1.5)==target
end

-- Overdrive as a damage spell in a committed melee fight (attack speed for its whole duration).
function BlitzcrankChampion:FightWAllowed(target)
	local rank=self:WRank()
	if not rank or not IsValid(target)or target.type~=Obj_AI_Hero then return false end
	if GetDistance(target.pos,myHero.pos)>self:AttackReach(target)or not self:WRiskAllowed()then return false end
	if self:HeldTarget(target)then return true end
	local path=target.pathing
	if path and path.isDashing then return false end
	local okA,period=pcall(_G.SDK.Attack.GetAnimation,_G.SDK.Attack)
	if not okA or not finite(period)or period<=.1 then period=myHero.attackData and myHero.attackData.animationTime end
	if not finite(period)or period<=.1 then return false end
	-- At least three attacks fit inside W, and the target cannot simply walk out of reach.
	local attacks=self.profile.wDuration*(1+self.profile.wAttackSpeed[rank])/period
	return attacks>=3 and(target.ms or 0)<=(myHero.ms or 0)*(1+self:WSpeedBonus(1))
end

-- W to reach hook range: Q ready and affordable after W, the target just beyond the hook window and the gap
-- closed in less than half of W's duration with the boosted speed. Never toward or from an enemy turret.
function BlitzcrankChampion:HookChaseAllowed(target)
	if not IsReady(_Q)or not self:WRank()or not IsValid(target)or target.type~=Obj_AI_Hero then return false end
	local setting=Menu.Hook.Targets[target.charName]
	if not(setting and setting:Value())or self:HasBuffType(target,SPELL_SHIELD)then return false end
	if IsUnderTurret(myHero)or IsUnderTurret(target)then return false end
	if myHero.health/math.max(1,myHero.maxHealth)*100<Menu.Combo.WHealth:Value()or GetEnemyCount(600,myHero.pos)>2 then return false end
	if myHero.mana<self:QCost()+(myHero:GetSpellData(_W).mana or 0)then return false end
	local gap=GetDistance(target.pos,myHero.pos)-math.min(self.QSpell.Range,Menu.Hook.Max:Value())
	if gap<=0 then return false end
	local half=self.profile.wDuration/2
	local closing=(myHero.ms or 0)*(1+self:WSpeedBonus(half))-(target.ms or 0)
	return closing>0 and gap/closing<half
end

function BlitzcrankChampion:Tick()
	self:ObserveAttack()
	self:TraceStartup()
	self:WatchTurretPull()
	if self.hook then self:HookTick()end
	if ShouldWait() or IsCasting() then return end
	self:DiscoverTargets()
	self:GrabFollowUp()
	self:UtilityR()
	self:MultiR()
	self:SemiQ()
	self:AutoQ()
	self:KillSteal()
	local mode = GetMode()
	if mode == "Combo" then
		self:Combo()
	elseif mode == "Harass" then
		self:Harass()
	elseif mode == "LaneClear" then
		self:Clear()
	elseif mode == "Flee" then
		self:FleeW()
	end
end

-- Hook lifecycle: request -> observed Q cast -> pull evidence or expiry. The single
-- bounded record drives E/R follow-up in every build; q_aim/q_outcome rows are
-- written only when the development logger exists (public builds omit it).
function BlitzcrankChampion:HookRecord(target,p,need,why,id,reason)
	local current=self.hook
	local cast,unit=p.CastPosition,p.UnitPosition
	if current and current.id==id and not current.castStart then
		current.aimX,current.aimZ=cast.x,cast.z
		if unit then current.predX,current.predZ=unit.x,unit.z end
		return
	end
	local h={id=id,target=target,targetID=target.networkID,requestedAt=Game.Timer(),spellName=myHero:GetSpellData(_Q).name,
		aimX=cast.x,aimZ=cast.z,predX=unit and unit.x,predZ=unit and unit.z,need=need,policy=why,reason=reason}
	self.hook=h
	if Core.logger and(not Core.logger.Wants or Core.logger:Wants('q_aim'))then
		local moving=target.pathing and target.pathing.hasMovePath and target.posTo
		local vx,vz=0,0
		if moving then
			local dx,dz=target.posTo.x-target.pos.x,target.posTo.z-target.pos.z;local len=math.sqrt(dx*dx+dz*dz)
			if len>0 then vx,vz=dx/len*(target.ms or 0),dz/len*(target.ms or 0)end
		end
		Core:Trace('q_aim',{id=id,target=h.targetID,champion=target.charName,profile=self.profile.id,aimX=h.aimX,aimZ=h.aimZ,
			predictedX=h.predX,predictedZ=h.predZ,targetX=target.pos.x,targetZ=target.pos.z,velX=vx,velZ=vz,
			dashing=target.pathing and target.pathing.isDashing or false,hitChance=p.HitChance,required=need,policy=why,
			delay=self.QSpell.Delay,speed=self.QSpell.Speed,radius=self.QSpell.Radius,timeToHit=p.TimeToHit,
			distance=GetDistance(target.pos,myHero.pos),bounding=target.boundingRadius})
	end
end

function BlitzcrankChampion:HookRefused(target,reason,need,hitChance)
	if not Core.logger then return end
	Core:Trace('q_refused',{target=target.networkID,profile=self.profile.id,reason=reason,required=need,hitChance=hitChance,
		distance=GetDistance(target.pos,myHero.pos),dashing=target.pathing and target.pathing.isDashing or false,ms=target.ms},1000)
end

-- Gameplay evidence that this hook pulled the target: a grab buff on the target,
-- a dash path ending at Blitzcrank, or closure toward the cast origin that walking
-- cannot explain. Timers alone never produce a grab.
function BlitzcrankChampion:GrabEvidence(target,h,now)
	if now<h.castStart+self.QSpell.Delay then return nil end
	for _,buff in ipairs(GetBuffs(target))do
		local name=type(buff.name)=='string'and buff.name:lower()
		if name and name:find('rocketgrab',1,true)and(buff.count or 1)>0 then return 'buff:'..buff.name end
	end
	local path=target.pathing
	if path and path.isDashing and path.endPos and h.startDistance>400 and GetDistance(path.endPos,myHero.pos)<=300 then return 'pull_path'end
	local dx,dz=target.pos.x-h.originX,target.pos.z-h.originZ
	local closed=h.startDistance-math.sqrt(dx*dx+dz*dz)
	if closed>math.max(200,(target.ms or 0)*(now-h.castStart)+150)then return 'displacement'end
end

function BlitzcrankChampion:HookTick()
	local h=self.hook;local now=Game.Timer()
	if not h.castStart then
		local cast=myHero.activeSpell
		if cast and cast.valid and cast.name==h.spellName and finite(cast.startTime)and cast.startTime>=h.requestedAt-.05 then
			h.castStart=cast.startTime;h.originX,h.originZ=myHero.pos.x,myHero.pos.z
			local placed=cast.placementPos
			if placed and finite(placed.x)and finite(placed.z)then h.placedX,h.placedZ=placed.x,placed.z end
			local t=h.target
			h.startDistance=IsValid(t)and GetDistance(t.pos,myHero.pos)or 0
			local px,pz=h.predX or h.aimX,h.predZ or h.aimZ
			local travel=math.min(self.QSpell.Range,math.sqrt((px-h.originX)^2+(pz-h.originZ)^2))/self.QSpell.Speed
			h.impactAt=h.castStart+self.QSpell.Delay+travel
		elseif now-h.requestedAt>1 then self:HookFinish(h,'cast_not_observed',now)end
		return
	end
	local t=h.target
	if not(IsValid(t)and t.networkID==h.targetID)then
		self:HookFinish(h,t and t.dead and'target_dead'or'target_not_visible',now);return
	end
	if not h.impactX and now>=h.impactAt then h.impactX,h.impactZ=t.pos.x,t.pos.z end
	local evidence=self:GrabEvidence(t,h,now)
	if evidence then
		h.evidence=evidence;self.grab={target=t,targetID=h.targetID,at=now,id=h.id,kind='pull'}
		if h.reason=='turret_pull'and Core.logger then self.turretWatch={target=t,targetID=h.targetID,id=h.id,expires=now+2.5}end
		self:HookFinish(h,'grabbed',now);return
	end
	if now>h.impactAt+.5 then self:HookFinish(h,'not_pulled',now)end
end

function BlitzcrankChampion:HookFinish(h,outcome,now)
	self.hook=nil
	if not Core.logger then return end
	local row={id=h.id,target=h.targetID,profile=self.profile.id,outcome=outcome,evidence=h.evidence,policy=h.policy,reason=h.reason,
		castStart=h.castStart,impactAt=h.impactAt,observedAt=now,radius=self.QSpell.Radius}
	local ax,az=h.placedX or h.aimX,h.placedZ or h.aimZ
	row.aimX,row.aimZ,row.aimSource=ax,az,h.placedX and'placementPos'or'request'
	local t=h.target
	if h.impactX and h.originX then
		-- Lateral offset of the target at estimated impact from the outgoing ray.
		local rx,rz=ax-h.originX,az-h.originZ;local len=math.sqrt(rx*rx+rz*rz)
		local ox,oz=h.impactX-h.originX,h.impactZ-h.originZ
		row.impactX,row.impactZ=h.impactX,h.impactZ
		if len>0 then
			row.rayOffset=math.abs(ox*rz-oz*rx)/len;row.reach=self.QSpell.Radius+(t and t.boundingRadius or 0)
			row.rayHitEstimate=row.rayOffset<=row.reach
		end
		if h.predX then row.predictionError=math.sqrt((h.impactX-h.predX)^2+(h.impactZ-h.predZ)^2)end
	end
	Core:Trace('q_outcome',row)
end

-- Fresh follow-up predicate after an observed grab (not after a request or timer).
function BlitzcrankChampion:GrabTarget(window)
	local g=self.grab
	if not g or Game.Timer()-g.at>window then return nil end
	local t=g.target
	if not IsValid(t)or t.networkID~=g.targetID then return nil end
	return t
end

function BlitzcrankChampion:GrabEAllowed()
	local t=self:GrabTarget(1.2)
	return t~=nil and self.grab.kind~='knockup'and not self:EActive()
		and GetDistance(t.pos,myHero.pos)<=self:AttackReach(t)+150
end

function BlitzcrankChampion:GrabFollowUp()
	if not IsReady(_E)or not self:GrabEAllowed()then return end
	local t=self.grab.target
	Core:Cast(HK_E,nil,{intentTarget=t,range=self:AttackReach(t)+150})
end

-- R follows Q -> E: wait while E is ready or its empowered attack is pending.
function BlitzcrankChampion:GrabRAllowed()
	local t=self:GrabTarget(2.5)
	if not t or GetDistance(t.pos,myHero.pos)>self.RRange-50 then return false end
	local age=Game.Timer()-self.grab.at
	if age<0 then return false end
	if age<1.2 and(self:EActive()or IsReady(_E))then return false end
	return true
end

function BlitzcrankChampion:ComboRAllowed()
	-- Counted where the enemies will stand when the field detonates, not where they stand now.
	return self:GrabRAllowed()or self:PredictedRCount()>=Menu.Combo.RCount:Value()
end

-- Fight R on one champion in attack reach: R plus the next attack kill at R's impact (the shared kill rule).
function BlitzcrankChampion:RFightLethal(target)
	if not IsValid(target)or target.type~=Obj_AI_Hero or GetDistance(target.pos,myHero.pos)>self.RRange-50 then return false end
	if GetDistance(target.pos,myHero.pos)>self:AttackReach(target)then return false end
	return Core:Lethal(target,self.profile.rDelay,function()
		local ok,attack=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,target,true)
		return self:GetRDmg(target)+(ok and finite(attack)and attack or 0)
	end)==true
end

function BlitzcrankChampion:SemiQ()
	if not Menu.Hook.Semi:Value()or not IsReady(_Q)then return end
	local best,bestDistance
	for _,target in ipairs(Core:DecisionUnits('GetEnemyHeroes'))do
		if self:HookAllowed(target,true)then
			local d=GetDistance(target.pos,mousePos)
			if not bestDistance or d<bestDistance then best,bestDistance=target,d end
		end
	end
	if best then self:CastQ(best,2,true)end
end

function BlitzcrankChampion:FleeW()
	if Menu.Misc.FleeW:Value()and IsReady(_W)and GetEnemyCount(900,myHero.pos)>0 then Core:Cast(HK_W,nil,{})end
end

function BlitzcrankChampion:OnPreAttack(args)
	return false
end

function BlitzcrankChampion:OnPostAttack(args)
	self:ObserveAttack()
	local target=self.attackWitness and self.attackWitness.object
	if not IsValid(target)then return end
	if not IsReady(_E)or not self:EAllowed(target)then return end
	local mode = GetMode()
	if mode == "Combo" and Menu.Combo.E:Value() and target.type == Obj_AI_Hero then
		Core:Cast(HK_E,nil,{intentTarget=target,range=self:AttackReach(target)})
	elseif mode == "Harass" and Menu.Harass.E:Value() and Core.manaAbove(Menu.Harass.Mana:Value())and target.type == Obj_AI_Hero then
		Core:Cast(HK_E,nil,{intentTarget=target,range=self:AttackReach(target)})
	elseif mode == "LaneClear" and Menu.Clear.Enabled:Value() and Menu.Clear.E:Value() and Core.manaAbove(Menu.Clear.Mana:Value())and target.team == 300 then
		Core:Cast(HK_E,nil,{intentTarget=target,range=self:AttackReach(target)})
	end
end

function BlitzcrankChampion:Combo()
	local candidates=self:HookCandidates()
	local target = candidates[1] or GetTarget(self.RRange)
	self.preview={target=candidates[1],at=Game.Timer()}
	if Menu.Combo.R:Value() and IsReady(_R)then
		if self:ComboRAllowed()then
			if Core:Cast(HK_R,nil,{})then return end
		elseif self:RFightLethal(target)then
			if Core:Cast(HK_R,nil,{intentTarget=target,range=self.RRange-50,owner='ComboRKill',context=Core:ModeContext('Combo')})then return end
		end
	end
	if not IsValid(target)then
		-- Nobody to hook or punch: W may bring the selector's target into hook range.
		if Menu.Combo.W:Value()and Menu.Combo.Q:Value()and IsReady(_W)then
			local far=GetTarget(self.QSpell.Range+900)
			if far and self:HookChaseAllowed(far)then
				Core:Cast(HK_W,nil,{intentTarget=far,owner='HookChaseW',context=Core:ModeContext('Combo')})
			end
		end
		return
	end
	if not target.pos2D.onScreen then return end
	if Menu.Combo.E:Value() and IsReady(_E)then
		-- The enemy to punch is the one in reach, which need not be the best hook target.
		local near=self:ComboEAllowed(target)and target or nil
		if not near then
			for _,enemy in ipairs(Core:Rows('hero',self.ERange))do
				if self:ComboEAllowed(enemy)then near=enemy;break end
			end
		end
		if near then
			Core:Cast(HK_E,nil,{intentTarget=near,range=self:AttackReach(near)})
			return
		end
	end
	if Menu.Combo.Q:Value() and IsReady(_Q) and self:TryHooks(candidates, 2) then return end
	if Menu.Combo.W:Value() and IsReady(_W)then
		-- The fight is with the enemy in reach, which need not be the best hook target.
		local fight=self:FightWAllowed(target)and target or nil
		if not fight then
			for _,enemy in ipairs(Core:Rows('hero',self.ERange))do
				if self:FightWAllowed(enemy)then fight=enemy;break end
			end
		end
		if fight then
			Core:Cast(HK_W,nil,{intentTarget=fight,owner='FightW',context=Core:ModeContext('Combo')})
		elseif self:ChaseAllowed(target)then Core:Cast(HK_W,nil,{intentTarget=target})end
	end
end

function BlitzcrankChampion:Harass()
	if not Core.manaAbove(Menu.Harass.Mana:Value()) then return end
	local candidates=self:HookCandidates()
	self.preview={target=candidates[1],at=Game.Timer()}
	local target = candidates[1]
	if not IsValid(target) or not target.pos2D.onScreen then return end
	if Menu.Harass.E:Value() and IsReady(_E) and self:EAllowed(target) then
		Core:Cast(HK_E,nil,{intentTarget=target,range=self:AttackReach(target)})
		return
	end
	if Menu.Harass.Q:Value() and IsReady(_Q) then self:TryHooks(candidates, 3) end
end

function BlitzcrankChampion:Clear()
	if not Menu.Clear.Enabled:Value() or not Core.manaAbove(Menu.Clear.Mana:Value()) then return end
	local monsters = _G.SDK.ObjectManager:GetMonsters(self.ERange)
	-- Every clear cast goes through the shared path: mode release, channel and readiness are checked at dispatch.
	if Menu.Clear.R:Value() > 0 and IsReady(_R) and GetMinionCount(self.RRange, myHero.pos) >= Menu.Clear.R:Value() then
		if Core:Cast(HK_R,nil,{})then return end
	end
	local monster=monsters[1]
	if IsValid(monster) then
		if Menu.Clear.E:Value() and IsReady(_E) and self:EAllowed(monster) then
			Core:Cast(HK_E,nil,{intentTarget=monster,range=self:AttackReach(monster)})
			return
		end
		if Menu.Clear.W:Value() and IsReady(_W) then Core:Cast(HK_W,nil,{intentTarget=monster,range=self.ERange+(monster.boundingRadius or 0)}) end
	end
end

-- Attack range of an allied turret. Normal: 750 (wiki). Classic is unmeasured: the native turret.range when it
-- reads a plausible value, else 750; dev builds record both (turret_range) once per turret.
function BlitzcrankChampion:TurretRange(turret)
	local p=self.profile;local native=turret.range
	local range=p.turretRange
	if not p.turretRangeVerified and finite(native)and native>=600 and native<=1000 then range=native end
	local id=turret.networkID or turret.handle
	if Core.logger and id and not self.turretTraced[id]then
		self.turretTraced[id]=true
		Core:Trace('turret_range',{profile=p.id,turret=id,native=native,bounding=turret.boundingRadius,used=range,verified=p.turretRangeVerified})
	end
	return range
end

-- The allied turret a hook on `target` pulls it into: Blitzcrank stands inside a living allied turret's range,
-- the pulled target's landing point (in front of him) is inside it too, the target is not already under it,
-- and at most one other enemy champion is within 900 (a free pull, not a dive into our face).
function BlitzcrankChampion:TurretPull(target)
	local objects=_G.SDK.ObjectManager
	if not IsValid(target)or type(objects.GetAllyTurrets)~='function'then return nil end
	local others=0
	for _,enemy in ipairs(Core:DecisionUnits('GetEnemyHeroes'))do
		if enemy~=target and IsValid(enemy)and GetDistance(enemy.pos,myHero.pos)<=900 then
			others=others+1;if others>1 then return nil end
		end
	end
	local landing=myHero.pos:Extended(target.pos,(myHero.boundingRadius or 65)+(target.boundingRadius or 65))
	local turrets=objects:GetAllyTurrets()
	for i=1,math.min(#turrets,16)do local turret=turrets[i]
		if turret and not turret.dead and(turret.health or 1)>0 and turret.pos and turret.team==myHero.team then
			local range=self:TurretRange(turret)
			if GetDistance(turret.pos,myHero.pos)<=range and GetDistance(turret.pos,landing)<=range
				and GetDistance(turret.pos,target.pos)>range+(target.boundingRadius or 0)then return turret end
		end
	end
end

-- low: a lowest-priority champion, hooked automatically only to interrupt, on crowd control or into a turret.
function BlitzcrankChampion:AutoQReason(target,point,low)
	local misc=Menu.Misc
	if not self:HookAllowed(target)then return nil end
	local impact=OrbamaPrediction:GetImpactTime(self.QSpell,point or target.pos,myHero)
	if not Core.manaAbove(misc.AutoMana:Value())then return nil end
	if Core:CanInterrupt(target,impact)then return 'interrupt'end
	if not low and Core:DashLanding(target,myHero.pos,self.QSpell.Range)then return 'dash'end
	if Core:ControlledHit(target,self.QSpell,point)then return 'controlled'end
	if self:TurretPull(target)then return 'turret_pull'end
	if not low and misc.FreeHook:Value()then return 'authorized_hook'end
end

function BlitzcrankChampion:AutoQ()
	if not IsReady(_Q)then return end
	local candidates=self:HookCandidates(true)
	for i=1,math.min(#candidates,5)do local target=candidates[i]
		local low=candidates.low[target]==true
		local reason=self:AutoQReason(target,nil,low)
		if reason and self:CastQ(target,reason=='dash'and 2 or 3,false,{owner='AutoQ',ttl=150,reason=reason,
			context={priority='interactive',condition=function()return self:AutoQReason(target,nil,low)~=nil end},
			validate=function(q,resolved)return self:AutoQReason(target,resolved and resolved.position or q.target,low)~=nil end})then return end
	end
end

-- Development evidence for the turret range: does the turret shoot the target a turret_pull hook pulled?
function BlitzcrankChampion:WatchTurretPull()
	local w=self.turretWatch
	if not w then return end
	local now=Game.Timer();local t=w.target
	if not Core.logger or not IsValid(t)or t.networkID~=w.targetID or now>w.expires then
		if Core.logger then Core:Trace('turret_pull_shot',{id=w.id,target=w.targetID,profile=self.profile.id,shot=false})end
		self.turretWatch=nil;return
	end
	local turrets=_G.SDK.ObjectManager:GetAllyTurrets()
	for i=1,math.min(#turrets,16)do local turret=turrets[i]
		if turret and turret.pos and turret.targetID==w.targetID then
			Core:Trace('turret_pull_shot',{id=w.id,target=w.targetID,profile=self.profile.id,shot=true,turret=turret.networkID,
				distance=GetDistance(turret.pos,t.pos),bounding=t.boundingRadius,native=turret.range,used=self:TurretRange(turret)})
			self.turretWatch=nil;return
		end
	end
end

-- Development: the host's Q range next to the profile value, once per load (Classic 1050 vs asset 1080).
function BlitzcrankChampion:TraceStartup()
	if self.startupTraced or not Core.logger then return end
	self.startupTraced=true
	Core:Trace('q_range',{profile=self.profile.id,profileRange=self.profile.qRange,host=myHero:GetSpellData(_Q).range,
		hostCost=myHero:GetSpellData(_Q).mana,profileCost=self.profile.qCost,used=self.QSpell.Range})
end

-- The shared kill rule at the spell's own impact time, from a fresh distance (the provider's cached
-- `distance` field can be stale or absent).
function BlitzcrankChampion:RLethal(target)
	return IsValid(target)and GetDistance(target.pos,myHero.pos)<=self.RRange
		and Core:Lethal(target,self.profile.rDelay,function()return self:GetRDmg(target)end,{kind='magical'})==true
end
function BlitzcrankChampion:QLethal(target,point)
	if not IsValid(target)then return false end
	local impact=OrbamaPrediction:GetImpactTime(self.QSpell,point or target.pos,myHero)
	return Core:Lethal(target,impact,function()return self:GetQDmg(target)end,{kind='magical'})==true
end

function BlitzcrankChampion:KillSteal()
	local rReady,qReady=Menu.KillSteal.R:Value()and IsReady(_R),Menu.KillSteal.Q:Value()and IsReady(_Q)
	if not rReady and not qReady then return end
	for _,target in ipairs(Core:Rows('hero',self.QSpell.Range))do
		if target.pos2D.onScreen then
			if rReady and self:RLethal(target)then
				if Core:Cast(HK_R,nil,{intentTarget=target,range=self.RRange,validate=function()return self:RLethal(target)end})then return end
			end
			if qReady and self:QLethal(target)then
				if self:CastQ(target,3,false,{validate=function(q,resolved)return self:QLethal(target,resolved and resolved.position or q.target)end},true)then return end
			end
		end
	end
end

-- Prediction binds this exact cast position; dispatch re-resolves the same target and
-- re-checks collision on the resolved outgoing ray (prediction facade Validate).
function BlitzcrankChampion:CastQ(target, hc, manual,options,close)
	if not self:HookAllowed(target,manual,close)then return false end
	local need,why=self:QRequirement(target,hc or 2,manual)
	if not need then self:HookRefused(target,why);return false end
	local p = Core:Prediction(self.QSpell)
	p:GetPrediction(target, myHero)
	if not p:CanHit(need) then self:HookRefused(target,p.LastFailureReason or 'hitchance',need,p.HitChance);return false end
	local opts={};for key,value in pairs(options or {})do if key~='reason'then opts[key]=value end end
	opts.prevalidateWorldCast=true
	local ok,id=Core:Cast(HK_Q, p.CastPosition,opts)
	if ok and p.CastPosition then self:HookRecord(target,p,need,why,id,options and options.reason)end
	return ok
end
function BlitzcrankChampion:Magic(t, d) return _G.SDK.Damage:CalculateDamage(myHero, t, _G.SDK.DAMAGE_TYPE_MAGICAL, d) end
function BlitzcrankChampion:GetQDmg(t)
	local l = myHero:GetSpellData(_Q).level
	if l == 0 then return 0 end
	return self:Magic(t, self.profile.qDamage[l] + self.profile.qAP*myHero.ap)
end
function BlitzcrankChampion:GetRDmg(t)
	local l = myHero:GetSpellData(_R).level
	if l == 0 then return 0 end
	return self:Magic(t, self.profile.rDamage[l] + self.profile.rAP*myHero.ap)
end

-- Health-bar damage (shared overlay): ready Q and R plus one attack. Power Fist's bonus is not profiled.
function BlitzcrankChampion:ComboDamage(u)
	local total=0
	if IsReady(_Q)then total=total+self:GetQDmg(u)end
	if IsReady(_R)then total=total+self:GetRDmg(u)end
	local ok,attack=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
	if ok and finite(attack)then total=total+attack end
	return total
end

-- Overdrive to Evade as a movement-speed burst. Normal: the mean bonus over its 2.5 s decay (the true bonus
-- is higher early on, so shorter dodges are underestimated, never overestimated). Classic: constant for 8 s.
function BlitzcrankChampion:OfferHaste()
	local p=self.profile
	if not Core.RegisterEffect then return end
	local window=p.wMoveDecay or p.wDuration
	self.hasteOffered,self.hasteReason=Core:RegisterEffect({kind='haste',name='Blitzcrank W',slot=_W,key=HK_W,profile=p.id,
		source='CombatProfiles/blitzcrank.lua wMoveSpeed/wMoveDecay/wDuration (assets 905ccf3e / e7b3ea35, read 2026-10-10)',
		delay=p.wDelay,duration=window,percent=function()return self:WRank()and self:WSpeedBonus(window)or nil end})
end

function BlitzcrankChampion:UtilityRValid(target,reason)
	if not IsValid(target)or GetDistance(target.pos,myHero.pos)>self.RRange then return false end
	if reason=='shield'then return self.profile.shieldBreak and Menu.Misc.ShieldR:Value()
		and GetMode()=='Combo'and math.max(target.shieldAD or 0,target.shieldAP or 0)>=self:GetRDmg(target)end
	return Core:CanInterrupt(target,OrbamaPrediction:GetImpactTime(self.RSpell,target.pos,myHero))
end

function BlitzcrankChampion:PredictedRCount()
	local predictor=Core:Prediction(self.RSpell);local list=Core:DecisionUnits('GetEnemyHeroes');local count,seen=0,{}
	for i=1,math.min(#list,16)do local unit=list[i];local id=unit and unit.networkID
		if id and not seen[id]and IsValid(unit)and not IsInvulnerable(unit)and not self:HasBuffType(unit,SPELL_SHIELD)
			and GetDistance(unit.pos,myHero.pos)<=self.RRange then
			seen[id]=true;predictor:GetPrediction(unit,myHero)
			if predictor:CanHit(3)and predictor.UnitPosition and GetDistance(predictor.UnitPosition,myHero.pos)<=self.RRange then count=count+1 end
		end
	end
	return count
end

function BlitzcrankChampion:MultiR()
	local misc=Menu.Misc
	local function permission()return misc.MultiR:Value()and self:PredictedRCount()>=misc.MultiRCount:Value()end
	if not misc.MultiR:Value()or not IsReady(_R)or not permission()then return false end
	return Core:Cast(HK_R,nil,{owner='MultiR',ttl=150,context={priority='interactive',condition=function()return misc.MultiR:Value()end},validate=permission})
end

function BlitzcrankChampion:UtilityR()
	if not IsReady(_R)then return end
	local interrupt=true
	local shield=self.profile.shieldBreak and Menu.Misc.ShieldR:Value()and GetMode()=='Combo'
	for _,target in ipairs(Core:DecisionUnits('GetEnemyHeroes'))do
		local reason=interrupt and self:UtilityRValid(target,'interrupt')and'interrupt'
			or shield and self:UtilityRValid(target,'shield')and'shield'
		if reason then
			local context=reason=='shield'and Core:ModeContext('Combo')or nil
			if Core:Cast(HK_R,nil,{intentTarget=target,range=self.RRange,priority='interactive',context=context,
				validate=function()return self:UtilityRValid(target,reason)end})then return end
		end
	end
end

function BlitzcrankChampion:RegisterGuide(guide,settings)
	local nodes={comboQ={node=Menu.Combo.Q,label='Combo Q'},comboE={node=Menu.Combo.E,label='Combo E'},
		comboW={node=Menu.Combo.W,label='Combo W'},harassQ={node=Menu.Harass.Q,label='Harass Q'},
		farm={node=Menu.Clear.Enabled,label='Spell farming'}}
	nodes.freeHook={node=Menu.Misc.FreeHook,label='Automatic hooks'}
	nodes.multiR={node=Menu.Misc.MultiR,label='Automatic multi-target R'}
	if self.profile.shieldBreak then nodes.shield={node=Menu.Misc.ShieldR,label='Shield removal'}end
	local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
	local titles={'Blitzcrank: quick start','Blitzcrank: hook and reset','Blitzcrank: resources'}
	return guide:Register('champion',titles,function(page)
		if page==1 then return {title='Blitzcrank: '..self.profile.id,subtitle='Use the Orbama mode keys and choose which enemies may be hooked.',cards={
			{'COMBAT','Combo: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..'. [[comboQ]] uses a fresh predicted ray. [[comboE]] empowers the first hit on an enemy in reach, or resets right after an attack that already landed.'},
			{'POKE','Harass: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. [[harassQ]] respects your mana threshold, hook distance and target permissions.'},
			{'FARM','Clear: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..'. [[farm]] is off by default. Jungle E follows observed attacks; W and lane R retain separate permissions.'}},note='Releasing the initiating mode cancels unsent work. Automatic hooks on immobilised, dashing or channelling enemies share one mana limit; kill finishers have their own switches.'}end
		if page==2 then return {title='Hook selection and Power Fist',subtitle='A Q request is not proof that the enemy was pulled.',cards={
			{'SELECTION','Turn off unwanted enemies in Hook selection. The allowed list goes to Orbama target selection, including your selected-only setting. New enemies receive their own toggle. A lowest-priority enemy (a tank) is hooked only when the hook kills, protects an ally, lands on crowd control, interrupts or pulls it into your turret.'},
			{'COLLISION','Minions, other champions and projectile walls are checked on the predicted outgoing ray. Long, fast or far-dashing targets need a higher prediction chance; spell-shielded targets are skipped. Hold '..settings.key(Menu.Hook.Semi)..' to hook the allowed enemy nearest your cursor.'},
			{'RESET','In Combo E is cast before the first hit on an enemy in reach, never over an attack that is winding up. In Harass and the jungle an attack must have landed on the same living target still in reach. A missed or uncertain hook never creates an assumed pull event. After an observed pull or Power Fist knock-up, Combo R follows. Standing under your own turret, an enemy outside it is hooked into it when at most one other enemy is near.'}},note='No automatic Flash or movement toward a hook endpoint. Choose dangerous engage targets deliberately.'}end
		return {title='W and Static Field',subtitle='Keep resources for the outcome you actually want.',cards={
			{'W','[[comboW]] gives attack speed in a melee fight when the target is held or cannot walk away, chases into attack reach, and brings a target just beyond hook range into it while Q is ready. Chasing needs sufficient health and no enemy turret; Normal W counts its later self-slow. W does not issue movement commands.'},
			{'ULTIMATE','Combo R counts enemies where they will stand when the field detonates; a kill needs no count. Q and R always interrupt a live interruptible channel that lasts through impact. [[multiR]] acts without a mode key at its enemy count. [[freeHook]] hooks any likely target without a mode key and starts disabled.'..(self.profile.shieldBreak and' [[shield]] is a separate Combo decision for large damage shields.'or' Classic does not inherit modern shield destruction.')},
			{'PROFILE',self.profile.id=='classic'and'Classic Q plans for at least 140 mana and 1050 range. Its potential Mana Barrier is based on remaining current mana.'or'Normal has its own Q damage, E buff, W timing and R profile. Classic values do not select Normal lethal casts.'}},note='Mana Barrier availability, all shield interactions and live timing still require matched gameplay evidence.'}
	end,cfg,links,activate)
end

function BlitzcrankChampion:Draw()
	if myHero.dead then return end
	if Menu.Draw.Q:Value() and IsReady(_Q) then
		-- The band hooks actually use, and the hook target the last Combo/Harass decision prepared (no new search).
		local color=Draw.Color(255, 66, 244, 113)
		Draw.Circle(myHero.pos, math.min(self.QSpell.Range, Menu.Hook.Max:Value()), 1, color)
		if Menu.Hook.Min:Value()>0 then Draw.Circle(myHero.pos, Menu.Hook.Min:Value(), 1, Draw.Color(120, 66, 244, 113)) end
		local preview=self.preview
		-- Kept up to a second while Combo/Harass is held so a skipped decision tick cannot blink it.
		local mode=GetMode()
		if preview and preview.target and Game.Timer()-preview.at<=1 and(mode=='Combo'or mode=='Harass')and IsValid(preview.target)then
			Draw.Circle(preview.target.pos, (preview.target.boundingRadius or 65)+20, 2, color)
		end
	end
	if Menu.Draw.E:Value() and IsReady(_E) then Draw.Circle(myHero.pos, self.ERange, 1, Draw.Color(255, 244, 238, 66)) end
	if Menu.Draw.R:Value() and IsReady(_R) then Draw.Circle(myHero.pos, self.RRange, 1, Draw.Color(255, 244, 66, 96)) end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:RegisterPolicy({
    damageTypes={Q='magical',R='magical'},
    methods={
        AutoQ=function()return {priority='interactive'}end,
        GrabFollowUp=function()return {priority='interactive'}end,
        SemiQ=function()return Core:HeldContext(function()return Menu.Hook.Semi:Value()end)end,
        FleeW=function()return Core:ModeContext("Flee")end,
        OnPreAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode) or nil end,
        OnPostAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode) or nil end,

        Combo=function()return Core:ModeContext("Combo")end,
        Harass=function()return Core:ModeContext("Harass")end,
        Clear=function()return Core:ModeContext("LaneClear")end,
    },
    exceptions={non_interrupting_summoner=true},
    channel=function(self,q)return not Core:SelfChanneling() end,
    validate=function(self,q,slot,resolved)
        if slot==_Q then return self:HookAllowed(q.object,q.owner=='SemiQ',q.owner=='KillSteal')end
        if slot==_E and q.owner=='GrabFollowUp'then return self:GrabEAllowed()end
        if slot==_E and q.owner=='Combo'then return self:ComboEAllowed(q.object)end
        if slot==_W and q.owner=='Clear'then return Menu.Clear.Enabled:Value()and Core.manaAbove(Menu.Clear.Mana:Value())end
        if slot==_R and q.owner=='KillSteal'then return self:RLethal(q.object)end
        if slot==_E then
            if q.mode=='Harass'and not Core.manaAbove(Menu.Harass.Mana:Value())then return false end
            if q.mode=='LaneClear'and not Core.manaAbove(Menu.Clear.Mana:Value())then return false end
            return self:EAllowed(q.object)
        end
        if slot==_W and q.owner=='Combo'then return self:ChaseAllowed(q.object)end
        if slot==_W and q.owner=='FightW'then return Menu.Combo.W:Value()and self:FightWAllowed(q.object)end
        if slot==_W and q.owner=='HookChaseW'then return Menu.Combo.W:Value()and Menu.Combo.Q:Value()and self:HookChaseAllowed(q.object)end
        if slot==_R and q.owner=='Combo'then return self:ComboRAllowed()end
        if slot==_R and q.owner=='ComboRKill'then return Menu.Combo.R:Value()and self:RFightLethal(q.object)end
        if slot==_W and q.owner=='FleeW'then return GetEnemyCount(900,myHero.pos)>0 end
        if slot==_R and q.owner=='Clear'then return GetMinionCount(self.RRange,myHero.pos)>=Menu.Clear.R:Value()end
        return true
    end,
})

BlitzcrankChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Blitzcrank"]="Blitzcrank"}
local normalSupported={["Blitzcrank"]=true}

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
