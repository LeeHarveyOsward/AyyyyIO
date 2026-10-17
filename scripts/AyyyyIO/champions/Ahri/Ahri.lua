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
if champion=="Ahri" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Ahri',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.01
local finite=Core.finite


local AhriChampion=class("AhriChampion")

function AhriChampion:__init()		 
	self.profile=assert(AhriProfile(myHero.charName),'Unsupported Ahri mechanics profile')
	print("AyyyyIO - Ahri loaded")
	self:LoadMenu()
	Callback.Add("Draw", function() self:Draw() end)
	Callback.Add("Tick", function() self:OnTick() end)
	self.QSpell = AbilityProfiles.Spell(myHero.charName,'Q',OrbamaPrediction)
	self.QSpell.Collision=true;self.QSpell.CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}
	self.ESpell = AbilityProfiles.Spell(myHero.charName,'E',OrbamaPrediction)
	self.ESpell.Collision=true;self.ESpell.CollisionTypes={OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL}
	-- Spirit Rush as an Evade dash only where range, speed and cast delay are established (Normal).
	local p=self.profile
	if p.rSpeedFloor and p.rDelay then
		self.mobilityOffered,self.mobilityReason=Core:RegisterMobility({kind='dash',slot=_R,key=HK_R,name=p.rName,range=p.rRange,
			speeds={p.rSpeedFloor},castDelays={p.rDelay},profile=p.id,label='Spirit Rush',source=p.rSource,
			allowed=function(point)return self:EvadeRAllowed(point)end})
	else self.mobilityReason='dash speed and cast delay not established for this profile'end
	-- Charm, then Flash during its cast time (Ahri-2): the shared follow-up service owns the Flash.
	self.eFlash=Core:FlashFollow('AhriEFlash')
	self.seen={};self.blinks={}
	Core:RegisterCleanup('Ahri',function()if self.eFlash then self.eFlash:Cancel('cleanup')end;self.seen={};self.blinks={};self.rush=nil;self.rPreview=nil;self.qReturn=nil end)
	-- Health-bar damage (S9): the lower-bound burst of ready spells (one Q pass, first flame, Charm, one bolt) and one attack.
	Core:RegisterComboDamage(function(u)
		return self:Burst(u,true)+(_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0),true
	end)
end

-- Champion policy for an Evade dash; the danger is Evade's judgement. The declared speed is the dash at base
-- movement speed, so a slowed Ahri (a slower dash than declared) is refused.
function AhriChampion:EvadeRAllowed(point)
	if(myHero.ms or 0)<self.profile.rBaseMS then return false,'slowed_below_declared_speed'end
	if point==nil then return true end
	point=Core.point(point)
	if not point or Game.isWall(point)then return false,'wall'end
	return true
end

function AhriChampion:LoadMenu()
	local championIcon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/"..myHero.charName..".png"
	Menu = MenuElement({type = MENU, id = "Classic_AIO_"..myHero.charName, name='AyyyyIO - Ahri', leftIcon = championIcon})
	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	Menu.Combo:MenuElement({id='R',name='Use R to finish kills or follow a Charm',value=true})
	Menu.Combo:MenuElement({id='RHealth',name='Never dash in with R below health %',value=30,min=0,max=100,step=5})
	Menu.Combo:MenuElement({id='REnemies',name='Never dash in with R into more enemies than',value=2,min=1,max=5,step=1})

	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "Mana", name = "Only above mana %", value = 40, min = 0, max = 100, step = 5})

	Menu:MenuElement({type = MENU, id = "Clear", name = "Farming"})
	Menu.Clear:MenuElement({id = "Enabled", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(v) CheckChatBlock(Menu.Clear.Enabled, v) end})
	Menu.Clear:MenuElement({id = "Q", name = "Lane minions Q must hit", value = 3, min = 1, max = 8, step = 1})
	Menu.Clear:MenuElement({id = "W", name = "Lane minions near you for W", value = 3, min = 1, max = 6, step = 1})
	Menu.Clear:MenuElement({id = "JungleQ", name = "Use Q on jungle monsters", value = true})
	Menu.Clear:MenuElement({id = "JungleW", name = "Use W on jungle monsters", value = true})
	Menu.Clear:MenuElement({id = "Mana", name = "Only above mana %", value = 30, min = 0, max = 100, step = 5})
	Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
	Menu.LastHit:MenuElement({id='Q',name='Use Q when an attack cannot last hit',value=true})
	Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})

	Menu:MenuElement({type = MENU, id = "Misc", name = "Behaviour"})
	Menu.Misc:MenuElement({id = "EAntiDash", name = "Charm enemies that dash at you (E)", value = true})
	-- Q and E on immobilised enemies and the Q finisher are fixed behaviour: a guaranteed hit or kill is always taken.
	Menu.Misc:MenuElement({id='ProximityW',name='W when an enemy is close, without a mode key',value=true})
	Menu.Misc:MenuElement({id='AutoMana',name='Automatic casts only above mana %',value=40,min=0,max=100,step=5})
	Menu.Misc:MenuElement({id='FleeR',name='Flee: dash with R toward the cursor',value=true})
	Menu.Misc:MenuElement({id='FleeE',name='Flee: charm the nearest enemy chasing you',value=true})
	Menu.Misc:MenuElement({id='PeelR',name='Dash away with R from melee enemies when low',value=true})
	Menu.Misc:MenuElement({id='PeelHP',name='Dash away only below health %',value=50,min=5,max=100,step=5,menu=false})
	-- Charm-Flash only where the cast-origin rule is established (Normal; Classic needs the recorder first).
	if self.profile.eFlashOrigin then
		Menu.Misc:MenuElement({id='EFlash',name='Charm and Flash to reach a far enemy',key=string.byte('T')})
		Menu.Misc:MenuElement({id='EFlashKill',name='Charm and Flash only when the whole burst kills',value=false})
	end

	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "Q", name = "Q range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "W", name = "W range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "E", name = "E range", toggle = true, value = false})
	Menu.Draw:MenuElement({id='R',name='R range and the planned landing',value=false})
end

function AhriChampion:OnTick()
	self:TrackBlinks();self:PrepareRush();if Core.logger then self:TraceQReturn()end
	-- The Flash of a running Charm-Flash goes out during Charm's cast time, so it is kept before the casting gate.
	if self.eFlash:Maintain()then return end
	if ShouldWait() then
		return
	end
	if IsCasting() then return end
	if self:PeelR()or self:ExpiringR()or self:EFlashAssist()then return end
	self:AutoE()
	self:AutoTargets()
	local Mode = GetMode()
	if Mode == "Combo" then
		self:Combo()
	elseif Mode == "Harass" then
		self:Harass()
	elseif Mode == "LaneClear" then
		self:Clear()
	elseif Mode == "LastHit" then
		self:LastHit()
	elseif Mode == "Flee" then
		self:Flee()
	end
end

-- Spirit Rush ------------------------------------------------------------------------------------------------
-- A running Spirit Rush: the remaining dashes cost nothing, so they are judged more freely than the first.
function AhriChampion:RActive()
	return Core:SelfBuff(myHero,self.profile.rBuffs)~=nil
end

-- Lower bound of what lands on one enemy: one Q pass, the first Fox-Fire, Charm and one bolt per ready spell.
function AhriChampion:Burst(target,withR)
	local p,total=self.profile,0
	local function add(slot,base,ap,use)
		local rank=base[myHero:GetSpellData(slot).level]
		if rank and use~=false and IsReady(slot)then total=total+rank+ap*myHero.ap end
	end
	add(_Q,p.qDamage,p.qAP);add(_W,p.wDamage,p.wAP);add(_E,p.eDamage,p.eAP);add(_R,p.rBolt,p.rAP,withR)
	if total<=0 then return 0 end
	return self:Amp(target)*_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,total,true,false)
end

-- Classic Charm: a charmed enemy takes more damage from Ahri for 6 s (profile eAmp). A live own Charm is the
-- attributable evidence (the amplification debuff name is not established); Normal has no such effect.
function AhriChampion:Amp(target)
	local amp=self.profile.eAmp
	return(amp and target and target.type==Obj_AI_Hero and self:CharmUntil(target))and 1+amp or 1
end

function AhriChampion:BurstKills(target,withR)
	return Core:Lethal(target,.6,function()return self:Burst(target,withR)end,{kind='magical'})==true
end

-- Charm is blocked from `from` by a minion or a wind wall (the target itself is skipped).
function AhriChampion:EBlocked(target,from)
	local spell=self.ESpell
	local blocked,_,count=OrbamaPrediction:GetCollision(from,target.pos,spell.Speed,spell.Delay,spell.Radius,
		{OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_YASUOWALL},target.networkID)
	return blocked==true or(count or 0)>0
end

-- Why a dash is worth it now, or nil. A first cast needs a kill; a running Rush may also chase and reposition.
function AhriChampion:RReason(target,active)
	if not IsValid(target)or IsInvulnerable(target)then return nil end
	local distance=GetDistance(target.pos,myHero.pos)
	if distance>self.profile.rRange+550 then return nil end
	local kills=self:BurstKills(target,true)
	-- A dash is spent on a kill only when it adds something: the gap, or the bolt the burst needs.
	if kills and(distance>(active and 550 or 700)or not self:BurstKills(target,false))then return 'kill'end
	if self:CharmUntil(target)and distance>550 and(active or self:Burst(target,true)>=target.health*.5)then return 'charm'end
	if Menu.Combo.E:Value()and IsReady(_E)and distance<=self.ESpell.Range and(active or kills)and self:EBlocked(target,myHero.pos)then return 'reposition'end
end

-- A landing inside the limits: on walkable ground, outside enemy turret range, not among more enemies than allowed.
-- Ahri-9: one more enemy is accepted per allied champion near the landing, and two melee enemies close to it
-- refuse it unless the dash is for a kill.
function AhriChampion:RLanding(point,reason)
	point=Core.point(point)
	if not point or Game.isWall(point)or IsUnderTurret2(point)then return nil end
	local allies=0
	for _,ally in ipairs(Core:DecisionUnits('GetAllyHeroes'))do
		if ally~=myHero and IsValid(ally)and ally.networkID~=myHero.networkID and GetDistance(ally.pos,point)<=600 then allies=allies+1 end
	end
	if GetEnemyCount(600,point)>Menu.Combo.REnemies:Value()+allies then return nil end
	if reason~='kill'then local melee=0
		for _,enemy in ipairs(Core:Rows('hero',math.max(1,GetDistance(point,myHero.pos)+350)))do
			if(enemy.range or 600)<300 and GetDistance(enemy.pos,point)<=350 then melee=melee+1 end
		end
		if melee>=2 then return nil end
	end
	return point
end

-- Toward the cursor first (the player's side), then toward the target without ending in its lap, then sideways.
function AhriChampion:RPoint(target,reason)
	local origin,range=myHero.pos,self.profile.rRange
	local distance=GetDistance(target.pos,origin)
	local toward=target.pos-origin;local length=toward:Len()
	if length<=0 then return nil end
	local dir=toward/length;local side=Vector(-dir.z,0,dir.x)
	local list={origin:Extended(mousePos,range),origin+dir*math.min(range,math.max(100,distance-400)),origin+side*range,origin-side*range}
	for i=1,#list do
		local point=self:RLanding(list[i],reason)
		if point and GetDistance(point,target.pos)<=550 and(reason~='reposition'or not self:EBlocked(target,point))then return point end
	end
end

function AhriChampion:RAllowed(target,point)
	if not Menu.Combo.R:Value()or myHero.health/math.max(1,myHero.maxHealth)*100<Menu.Combo.RHealth:Value()then return false end
	local reason=self:RReason(target,self:RActive())
	return reason~=nil and(point==nil or self:RLanding(point,reason)~=nil and GetDistance(point,target.pos)<=600
		and GetDistance(point,myHero.pos)<=self.profile.rRange+25)
end

function AhriChampion:ComboR()
	if not Menu.Combo.R:Value()or not IsReady(_R)then return false end
	local target=self:PreferredTarget(self.profile.rRange+550)
	if not IsValid(target)or not self:RAllowed(target)then return false end
	local point=self:RPoint(target,self:RReason(target,self:RActive()))
	if not point then return false end
	self.rPreview={point=point,expires=Game.Timer()+.5}
	-- No `range` option: with an intent target the shared policy measures it to the enemy, not to the landing.
	return Core:Cast(HK_R,point,{intentTarget=target,validate=function(q)return self:RAllowed(target,q.target)end})
end

-- Flee: the dash goes where the player points. A first cast needs an enemy near enough to matter.
function AhriChampion:FleeRAllowed()
	return Menu.Misc.FleeR:Value()and(self:RActive()or GetEnemyCount(900,myHero.pos)>0)
end

function AhriChampion:Flee()
	if Menu.Misc.FleeE:Value()and IsReady(_E)then
		local nearest,best
		for _,enemy in ipairs(Core:Rows('hero',700))do
			local d=GetDistance(enemy.pos,myHero.pos)
			if not best or d<best then nearest,best=enemy,d end
		end
		if nearest and self:CastPrediction(HK_E,nearest,function()return Menu.Misc.FleeE:Value()end)then return true end
	end
	if IsReady(_R)and self:FleeRAllowed()then
		local point=self:FleePoint()
		if point then
			return Core:Cast(HK_R,point,{range=self.profile.rRange+25,validate=function()return self:FleeRAllowed()end})
		end
	end
	return false
end

-- Ahri-4: toward the cursor first; when that landing is terrain, the nearest of +-15 and +-30 degrees and shorter
-- dashes whose landing and path are walkable. Whether Spirit Rush crosses terrain is not established (own_dash
-- recorder), so a path through a wall is not taken.
function AhriChampion:FleePoint()
	local origin=myHero.pos;local aim=mousePos and Core.point(mousePos)
	if not aim or GetDistance(aim,origin)<1 then return nil end
	local dx,dz=aim.x-origin.x,aim.z-origin.z;local len=math.sqrt(dx*dx+dz*dz);dx,dz=dx/len,dz/len
	local range=self.profile.rRange
	local function clear(point)
		if not point or Game.isWall(point)then return false end
		for f=.25,.75,.25 do if Game.isWall(Core.point(origin+(point-origin)*f))then return false end end
		return true
	end
	for _,scale in ipairs({1,.75,.5})do
		for _,degrees in ipairs({0,15,-15,30,-30})do
			local a=math.rad(degrees);local c,sn=math.cos(a),math.sin(a)
			local point=Core.point(Vector(origin.x+(dx*c-dz*sn)*range*scale,origin.y,origin.z+(dx*sn+dz*c)*range*scale))
			if clear(point)then return point end
		end
	end
end

-- Ahri-3: dash away from a melee champion that reaches Ahri below the health limit. Any held mode, or without one
-- while a running Spirit Rush makes the dash free. Sixteen landings: the one farthest from every melee threat,
-- preferring the cursor side and keeping the target inside Q range.
function AhriChampion:MeleeThreats(from)
	local list={}
	for _,enemy in ipairs(Core:Rows('hero',900))do
		if(enemy.range or 600)<300 and GetDistance(enemy.pos,from or myHero.pos)<=(enemy.range or 0)+(enemy.boundingRadius or 65)+(myHero.boundingRadius or 65)+100 then list[#list+1]=enemy end
	end
	return list
end
function AhriChampion:PeelAllowed()
	if not Menu.Misc.PeelR:Value()or not IsReady(_R)or not finite(myHero.health)or not finite(myHero.maxHealth)or myHero.maxHealth<=0
		or myHero.health*100/myHero.maxHealth>Menu.Misc.PeelHP:Value()then return false end
	local mode=GetMode();if(mode==nil or mode=='')and not self:RActive()then return false end
	local threat=Core:AllyThreat(myHero,.6,{melee=true,turrets=false,skillshots=false})
	local source=threat and threat.source
	return source~=nil and source.type==Obj_AI_Hero and(source.range or 600)<300 and #self:MeleeThreats()>0
end
function AhriChampion:PeelPoint()
	local threats=self:MeleeThreats();if #threats==0 then return nil end
	local origin,range=myHero.pos,self.profile.rRange;local target=GetTarget(1500);local best,score
	local cursor=mousePos and Core.point(mousePos)
	for i=0,15 do local a=i*math.pi/8
		local point=self:RLanding(Vector(origin.x+math.cos(a)*range,origin.y,origin.z+math.sin(a)*range),'peel')
		if point then local nearest=math.huge
			for _,u in ipairs(threats)do nearest=math.min(nearest,GetDistance(u.pos,point))end
			local value=nearest+(cursor and -.1*GetDistance(point,cursor)or 0)+(IsValid(target)and GetDistance(target.pos,point)<=self.QSpell.Range and 100 or 0)
			if nearest>GetDistance(threats[1].pos,origin)and(not best or value>score)then best,score=point,value end
		end
	end
	return best
end
function AhriChampion:PeelR()
	if not self:PeelAllowed()then return false end
	local point=self:PeelPoint();if not point then return false end
	local mode=GetMode();local context=(mode and mode~='')and Core:ModeContext(mode)or{priority='interactive'}
	return Core:Cast(HK_R,point,{owner='AhriPeelR',context=context,range=self.profile.rRange+25,
		validate=function()return self:PeelAllowed()and self:RLanding(point,'peel')~=nil end})
end

-- Ahri-5: the running Spirit Rush from its own buff (expiry, and the dash count when the buff carries one; the
-- field meaning is recorded in development). Takedown extensions show up as a later expiry.
function AhriChampion:PrepareRush()
	local b=Core:SelfBuff(myHero,self.profile.rBuffs)
	if not b then self.rush=nil;return end
	local ends=Core.buffExpiry(b);local n=finite(b.stacks)and b.stacks>0 and b.stacks or finite(b.count)and b.count>1 and b.count or nil
	local rush=self.rush
	if not rush or rush.started~=b.startTime then
		rush={started=b.startTime};self.rush=rush
		if Core.logger then Core:Trace('ahri_rush_buff',{name=b.name,count=b.count,stacks=b.stacks,duration=b.duration,profile=self.profile.id})end
	end
	rush.expires=ends;rush.charges=n
end
function AhriChampion:ExpiringR()
	local rush=self.rush;if not rush or not finite(rush.expires)or not IsReady(_R)then return false end
	local left=rush.expires-Game.Timer();if left>1 or left<=.05 then return false end
	local origin,range=myHero.pos,self.profile.rRange;local best,score
	for i=0,15 do local a=i*math.pi/8
		local point=self:RLanding(Vector(origin.x+math.cos(a)*range,origin.y,origin.z+math.sin(a)*range),'expiring')
		if point then local nearest,inBolt=math.huge,false
			for _,u in ipairs(Core:Rows('hero',range+self.profile.rBoltRange))do local d=GetDistance(u.pos,point);nearest=math.min(nearest,d);if d<=self.profile.rBoltRange then inBolt=true end end
			if inBolt and(not best or nearest>score)then best,score=point,nearest end
		end
	end
	if not best then return false end
	return Core:Cast(HK_R,best,{owner='AhriExpiringR',context={priority='interactive'},range=range+25,
		validate=function()local r=self.rush;return r==rush and finite(r.expires)and r.expires>Game.Timer()and self:RLanding(best,'expiring')~=nil end})
end

-- Ahri-2: hold the bind for Charm then Flash. The Flash lands on the line toward the predicted target, so the
-- Charm keeps its line whether the cast keeps the clicked point or the direction; the Charm must reach and be
-- unblocked from that landing. Charm goes first, the Flash only after Charm's cast start is observed.
function AhriChampion:EFlashPlan(target)
	local status=Core:FlashStatus();if not status or not IsValid(target)or not IsReady(_E)then return nil end
	local origin=Core.point(myHero.pos);local d=GetDistance(target.pos,origin);local range=self.ESpell.Range
	if d<=range or d>range+status.range then return nil end
	local dir=(target.pos-origin)/d;local landing=Core.point(origin+dir*status.range)
	local prediction=Core:Prediction(self.ESpell);prediction:GetPrediction(target,{pos=landing,boundingRadius=myHero.boundingRadius or 65})
	local aim=Core.point(prediction.CastPosition)
	if not aim or not prediction:CanHit(3)then return nil end
	local reach=GetDistance(aim,origin);if reach<status.range+50 then return nil end
	dir=(aim-origin)/reach;landing=Core.point(origin+dir*status.range)
	if GetDistance(aim,landing)>range then return nil end
	local blocked,_,count=OrbamaPrediction:GetCollision(landing,aim,self.ESpell.Speed,self.ESpell.Delay,self.ESpell.Radius,self.ESpell.CollisionTypes,target.networkID)
	if blocked or(count or 0)>0 then return nil end
	return {landing=landing,aim=Core.point(origin+dir*math.min(reach,range-20)),target=target,dir=dir}
end
function AhriChampion:EFlashAuthorized(target)
	return Menu.Misc.EFlash~=nil and Menu.Misc.EFlash:Value()and IsValid(target)and(not Menu.Misc.EFlashKill:Value()or self:BurstKills(target,false))
end
function AhriChampion:EFlashAssist()
	if not Menu.Misc.EFlash or not Menu.Misc.EFlash:Value()or self.eFlash:Busy()or not IsReady(_E)then return false end
	local selected=_G.SDK.TargetSelector.Selected
	local target=IsValid(selected)and selected or GetTarget(self.ESpell.Range+400)
	if not IsValid(target)or not self:EFlashAuthorized(target)then return false end
	local plan=self:EFlashPlan(target);if not plan then return false end
	local handle=target.handle
	local ok=self.eFlash:Start({order='spell_first',aim=plan.landing,window=.2,ttl=1.2,
		authorized=function()return self:EFlashAuthorized(target)and target.handle==handle end,
		valid=function(landing)return GetDistance(landing,plan.landing)<=60 end,
		follow=function(held)
			-- No intent target: the shared range rule would measure Charm to the enemy beyond its range, not to the aim.
			return Core:Cast(HK_E,plan.aim,{owner='AhriEFlash',context=held,independent=false,range=self.ESpell.Range,
				validate=function()return self:EFlashAuthorized(target)and target.handle==handle and Core:FlashStatus()~=nil
					and GetDistance(target.pos,myHero.pos)<=self.ESpell.Range+400 end})
		end})
	if ok and Core.logger then Core:Trace('ahri_eflash',{target=target.networkID,landing=plan.landing,aim=plan.aim})end
	return ok==true
end

-- Ahri-7: a visible enemy whose position jumps far between two close observations without a dash path blinked
-- (Flash, blink spells). The landing is a gap close when it is nearer to Ahri than the start.
function AhriChampion:TrackBlinks()
	local now=Game.Timer();local rows=Core:Rows('hero',1600)
	for i=1,math.min(#rows,5)do local u=rows[i];local key=u.networkID
		local prev=self.seen[key]
		if prev and prev.handle==u.handle and now-prev.at<=.15 and now>prev.at and not(u.pathing and u.pathing.isDashing)then
			local jump=GetDistance(prev.pos,u.pos)
			if jump>250+(finite(u.ms)and u.ms or 0)*(now-prev.at)then
				self.blinks[key]={unit=u,handle=u.handle,from=prev.pos,landing=Core.point(u.pos),at=now}
				if Core.logger then Core:Trace('ahri_blink',{target=key,jump=jump,dt=now-prev.at})end
			end
		end
		self.seen[key]={pos=Core.point(u.pos),at=now,handle=u.handle}
	end
	for key,row in pairs(self.blinks)do if now-row.at>.6 then self.blinks[key]=nil end end
end
function AhriChampion:BlinkApproaching(row)
	return row and Game.Timer()-row.at<=.6 and IsValid(row.unit)and row.unit.handle==row.handle
		and GetDistance(row.landing,myHero.pos)<=self.ESpell.Range and GetDistance(row.landing,myHero.pos)<GetDistance(row.from,myHero.pos)
end

function AhriChampion:OnPreAttack(args)
	-- Actual windups remain provider-owned. Readiness adds no attack veto.
end

function AhriChampion:CharmUntil(target)
	if not IsValid(target)then return nil end
	local now=Game.Timer()
	for _,buff in ipairs(GetBuffs(target))do
		local expiry=Core.buffExpiry(buff)
		if buff.type==23 and buff.count and buff.count>0 and type(expiry)=='number'and expiry>now
			and Core.mine(buff.source)then return expiry end
	end
end

function AhriChampion:PreferredTarget(range)
	local target=GetTarget(range)
	if not IsValid(target)or IsValid(_G.SDK.TargetSelector.Selected)or self:CharmUntil(target)then return target end
	local charmed={}
	for _,candidate in ipairs(Core:DecisionUnits('GetEnemyHeroes'))do
		if IsValid(candidate)and GetDistance(candidate.pos,myHero.pos)<=range and self:CharmUntil(candidate)then
			charmed[#charmed+1]=candidate
		end
	end
	return #charmed>0 and _G.SDK.TargetSelector:GetTarget(charmed,_G.SDK.DAMAGE_TYPE_MAGICAL)or target
end

function AhriChampion:DashApproaching(target)
	return Core:ApproachingDash(target,myHero.pos,self.ESpell.Range)~=nil
end

function AhriChampion:AutoE()
	if Menu.Misc.EAntiDash:Value() and IsReady(_E) then
		local enemies = _G.SDK.ObjectManager:GetEnemyHeroes(self.ESpell.Range)
		for i = 1, #enemies do
			local enemy = enemies[i]
			if self:DashApproaching(enemy)and self:CastPrediction(HK_E,enemy,
				function()return Menu.Misc.EAntiDash:Value()and self:DashApproaching(enemy)end)then return end
		end
		for key,row in pairs(self.blinks)do
			if self:BlinkApproaching(row)and self:CastPrediction(HK_E,row.unit,
				function()return Menu.Misc.EAntiDash:Value()and self.blinks[key]==row and self:BlinkApproaching(row)end)then return end
		end
	end
end

function AhriChampion:OutgoingImpact(settings,point)
	return OrbamaPrediction:GetImpactTime(settings,point,myHero)
end

function AhriChampion:ImmobileFor(target,settings,point)
	if not IsValid(target)or not Core.manaAbove(Menu.Misc.AutoMana:Value())then return false end
	return Core:ControlledHit(target,settings,point)
end

function AhriChampion:OutgoingQLethal(target,point)
	if not IsValid(target)or IsInvulnerable(target)
		or GetDistance(point or target.pos,myHero.pos)>self.QSpell.Range then return false end
	local impact=self:OutgoingImpact(self.QSpell,point or target.pos)
	if Core:CannotDie(target,impact)then return false end
	local magic=self:OutgoingQDamage(target)*Core:OutgoingScale()
	-- Ahri-1: the return pass (the same amount as true damage) counts only while the target is held on the line
	-- by our own Charm until the return arrives. The return flight time is not established (profile
	-- qReturnTime, settled by the ahri_q_return trace), so without it only the outgoing hit qualifies.
	local back=self:ReturnTime(point or target.pos)
	local until_=back and self:CharmUntil(target)
	if back and until_ and until_-Game.Timer()>=impact+back then
		local raw=self.profile.qDamage[myHero:GetSpellData(_Q).level]
		local trueDamage=raw and(raw+self.profile.qAP*myHero.ap)*self:Amp(target)*Core:OutgoingScale()or 0
		local mixed=Core:MixedHealthEstimate(target,impact+back,trueDamage,magic)
		if mixed then return mixed.lethal==true end
	end
	local health=Core:HealthEstimate(target,impact,'magical',magic)
	return health and health.lethal or false
end

-- Seconds from the outgoing hit at `point` until the return pass reaches it again, or nil while the return
-- flight is unmeasured.
function AhriChampion:ReturnTime(point)
	local t=self.profile.qReturnTime;if not finite(t)then return nil end
	return t
end
-- Development evidence for Ahri-1: the return missile's distance to Ahri over time after an observed own Q.
function AhriChampion:TraceQReturn()
	local cast=Core.observedSpells and Core.observedSpells[_Q];if not cast or Game.Timer()-cast>3 then if self.qReturn and #self.qReturn.samples>0 then Core:Trace('ahri_q_return',self.qReturn);self.qReturn=nil end;return end
	if not self.qReturn or self.qReturn.cast~=cast then self.qReturn={cast=cast,samples={},profile=self.profile.id}end
	local row=self.qReturn;if #row.samples>=12 or type(Game.MissileCount)~='function'then return end
	local count=Game.MissileCount();if not finite(count)then return end
	for i=1,math.min(count,64)do local m=Game.Missile(i);local data=m and m.missileData;local name=data and type(data.name)=='string'and data.name:lower()
		if name and name:find('ahri',1,true)and name:find('return',1,true)and m.pos then
			row.samples[#row.samples+1]={t=Game.Timer()-cast,d=GetDistance(m.pos,myHero.pos)};break
		end
	end
end

-- Fox-Fire finisher: one flame only (the repeat flames are reduced). Normal Fox-Fire prefers champions over
-- minions; the Classic page states no priority, so there the enemy must also be the nearest target.
function AhriChampion:WLethal(target)
	if not IsValid(target)or IsInvulnerable(target)then return false end
	local distance=GetDistance(target.pos,myHero.pos);if distance>550 then return false end
	local p=self.profile;local base=p.wDamage[myHero:GetSpellData(_W).level];if not base then return false end
	if p.id~='normal'then
		for _,method in ipairs({'GetEnemyMinions','GetMonsters','GetEnemyHeroes'})do
			local units=Core:DecisionUnits(method)
			for i=1,math.min(#units,32)do local u=units[i]
				if u~=target and IsValid(u)and GetDistance(u.pos,myHero.pos)<=distance then return false end
			end
		end
	end
	return Core:Lethal(target,.6,function()
		return self:Amp(target)*_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+p.wAP*myHero.ap,true,false)
	end,{kind='magical'})==true
end

function AhriChampion:AutoTargets()
	local misc=Menu.Misc
	-- A kill is worth the last mana; the other automatic casts keep their reserve.
	local mana=Core.manaAbove(misc.AutoMana:Value())
	local qCC,qFinish=mana,true
	local eCC,wClose=mana,mana and misc.ProximityW:Value()
	local qReady=(qCC or qFinish)and IsReady(_Q)
	local eReady=eCC and IsReady(_E)
	local wFinish=IsReady(_W)and lastW+250<GetTickCount()
	local wReady=wClose and wFinish
	if not(qReady or eReady or wFinish)then return false end
	local seen,count={},0
	local enemies=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#enemies,16)do
		local target=enemies[i];local id=target and target.networkID
		if id and not seen[id]and IsValid(target)and target.type==Obj_AI_Hero and target.team~=myHero.team then
			seen[id]=true;count=count+1
			if eReady and GetDistance(target.pos,myHero.pos)<=self.ESpell.Range and self:ImmobileFor(target,self.ESpell)then
				if self:CastPrediction(HK_E,target,function(q,resolved)
					return self:ImmobileFor(target,self.ESpell,resolved and resolved.position or q.target)
				end)then return true end
			end
			if qReady and GetDistance(target.pos,myHero.pos)<=self.QSpell.Range then
				local cc=qCC and self:ImmobileFor(target,self.QSpell)
				local lethal=qFinish and self:OutgoingQLethal(target)
				-- Ahri-8: a Q finisher no other ready finisher can take accepts the normal hit chance; a miss costs
				-- only mana and cooldown, a skipped kill costs the kill.
				local chance=(lethal and not cc and not(wFinish and self:WLethal(target)))and 2 or 3
				if (cc or lethal)and self:CastPrediction(HK_Q,target,function(q,resolved)
					local point=resolved and resolved.position or q.target
					return self:ImmobileFor(target,self.QSpell,point)or self:OutgoingQLethal(target,point)
				end,nil,chance)then return true end
			end
			if wReady and GetDistance(target.pos,myHero.pos)<=350 then
				if self:CastW(target,function()
					return misc.ProximityW:Value()and Core.manaAbove(misc.AutoMana:Value())
						and GetDistance(target.pos,myHero.pos)<=350
				end)then return true end
			end
			if wFinish and self:WLethal(target)and self:CastW(target,function()return self:WLethal(target)end)then return true end
			if count>=5 then break end
		end
	end
	return false
end
	
function AhriChampion:Combo()
	if self:ComboR()then return end
	self:Combat(Menu.Combo)
end

function AhriChampion:Harass()
	if not Core.manaAbove(Menu.Harass.Mana:Value())then return end
	self:Combat(Menu.Harass)
end

function AhriChampion:Combat(menu)
	if menu.W:Value()and IsReady(_W)and lastW+250<GetTickCount()then self:CastW(GetTarget(700))end
	for _,letter in ipairs({'E','Q'})do
		local slot,key=letter=='E'and _E or _Q,letter=='E'and HK_E or HK_Q
		if menu[letter]:Value()and IsReady(slot)then
			local range=900
			local target=letter=='Q'and self:PreferredTarget(range)or GetTarget(range)
			if not IsValid(target)then
				local settings=letter=='Q'and self.QSpell or self.ESpell
				local bounded={};for name,value in pairs(settings)do bounded[name]=value end;bounded.Range=math.min(range,settings.Range)
				target=Core:SkillshotTarget(bounded,3)
			end
			if target and Core:SkillshotCurrent(target)then
				self:CastPrediction(key,target,nil,range)
			end
		end
	end
end

function AhriChampion:CastW(target,validate)
	if not IsValid(target)or GetDistance(target.pos,myHero.pos)>700 then return false end
	local accepted=Core:Cast(HK_W,nil,{intentTarget=target,range=700,validate=validate})
	if accepted then Core:AfterCast(HK_W,function()lastW=GetTickCount()end)end
	return accepted
end

function AhriChampion:FarmAllowed()
	return Menu.Clear.Enabled:Value()and Core.manaAbove(Menu.Clear.Mana:Value())
end

function AhriChampion:OutgoingQDamage(target,preparedDamage)
	if preparedDamage then return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,preparedDamage,true,false)end
	local base=self.profile.qDamage[myHero:GetSpellData(_Q).level]
	if not base then return 0 end
	return self:Amp(target)*_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.qAP*myHero.ap,true,false)
end

function AhriChampion:LastHitBudget()
	if not Menu.LastHit.Q:Value()or not Core.manaAbove(Menu.LastHit.Mana:Value())
		or _G.SDK.Attack:IsActive()then return nil end
	local spell=myHero:GetSpellData(_Q);local base=self.profile.qDamage[spell.level]
	if not base or spell.currentCd~=0 or spell.mana>myHero.mana or Game.CanUseSpell(_Q)~=0 then return nil end
	return base+self.profile.qAP*myHero.ap
end

function AhriChampion:CanRescue(target,point,preparedDamage)
	local raw=preparedDamage or self:LastHitBudget()
	if not raw or not IsValid(target)or target.team==300 or target.type~=Obj_AI_Minion or not target.pos2D.onScreen then return false end
	local reach=GetDistance(point or target.pos,myHero.pos)
	if reach>self.QSpell.Range then return false end
	local sdk=_G.SDK
	local impact=self.QSpell.Delay+OrbamaPrediction.ProjectileMotion.Time(self.QSpell.Motion,reach)
	local damage=self:OutgoingQDamage(target,raw)
	-- Do not rely on a return hit or future damage to make Q lethal.
	local upper=target.health+(target.shieldAD or 0)+(target.shieldAP or 0)+math.max(0,target.hpRegen or 0)*impact
	if upper>damage then return false end
	local hp=sdk.HealthPrediction:GetPrediction(target,impact)
	if hp<=0 or hp>damage then return false end
	local aaRange=myHero.range+myHero.boundingRadius+target.boundingRadius
	if GetDistance(target.pos,myHero.pos)<=aaRange and sdk.Orbwalker:CanAttack()then
		local speed=sdk.Attack:GetProjectileSpeed()
		if type(speed)~='number'or speed<=0 then return false end
		local aaTime=sdk.Attack:GetWindup()+math.max(0,GetDistance(target.pos,myHero.pos)-myHero.boundingRadius-target.boundingRadius)/speed
		local aaHP=sdk.HealthPrediction:GetPrediction(target,aaTime)
		if aaHP>0 and aaHP<=sdk.Damage:GetAutoAttackDamage(myHero,target,true)then return false end
	end
	return true
end

function AhriChampion:LastHit()
	local raw=self:LastHitBudget();if not raw then return end
	local minions=Core:DecisionUnits('GetEnemyMinions');local candidates={}
	for i=1,math.min(#minions,32)do
		local target=minions[i]
		if self:CanRescue(target,nil,raw)then candidates[#candidates+1]=target end
	end
	table.sort(candidates,function(a,b)return a.maxHealth>b.maxHealth end)
	for _,target in ipairs(candidates)do
		if self:CastPrediction(HK_Q,target,function(q,resolved)
			return self:CanRescue(target,resolved and resolved.position or q.target)
		end,nil,2)then return end
	end
end

function AhriChampion:LaneSamples()
	local samples,seen={},{}
	local prediction
	local minions=Core:DecisionUnits('GetEnemyMinions')
	for i=1,math.min(#minions,32)do
		local minion=minions[i]
		if #samples>=24 then break end
		if IsValid(minion)and not seen[minion.networkID]and minion.team~=300 and minion.pos2D.onScreen and GetDistance(minion.pos,myHero.pos)<=self.QSpell.Range then
			seen[minion.networkID]=true
			local path=minion.pathing
			if path and path.hasMovePath==false and not path.isDashing then
				local position=Vector(minion.pos)
				samples[#samples+1]={unit=minion,point=position,position=position,radius=self.QSpell.Radius+(minion.boundingRadius or 0)}
			else
				prediction=prediction or Core:Prediction(self.QSpell)
				prediction:GetPrediction(minion,myHero)
				if prediction:CanHit(2)and prediction.CastPosition and prediction.UnitPosition then
					samples[#samples+1]={unit=minion,point=prediction.CastPosition,position=prediction.UnitPosition,radius=self.QSpell.Radius+(minion.boundingRadius or 0)}
				end
			end
		end
	end
	return samples
end

function AhriChampion:RayCount(point,samples)
	local source=myHero.pos
	local dx,dz=point.x-source.x,point.z-source.z
	local length=math.sqrt(dx*dx+dz*dz)
	if length<=0 then return 0 end
	dx,dz=dx/length,dz/length
	local count,farthest=0,0
	for _,row in ipairs(samples)do
		local x,z=row.position.x-source.x,row.position.z-source.z
		local along=math.max(0,math.min(self.QSpell.Range,x*dx+z*dz))
		local ox,oz=x-along*dx,z-along*dz
		if ox*ox+oz*oz<=row.radius*row.radius then count=count+1;farthest=math.max(farthest,along)end
	end
	return count,farthest
end

function AhriChampion:FarmRayValid(point,samples)
	local hits,distance=self:RayCount(point,samples)
	if hits<Menu.Clear.Q:Value()then return false end
	local endpoint=myHero.pos:Extended(Vector(point),distance)
	local spell=self.QSpell
	local blocked,_,count=OrbamaPrediction:GetCollision(myHero.pos,endpoint,spell.Speed,spell.Delay,spell.Radius,spell.CollisionTypes)
	return not blocked and count==0
end

function AhriChampion:LaneQ()
	local samples=self:LaneSamples();local best
	for _,row in ipairs(samples)do
		row.hits=self:RayCount(row.point,samples)
	end
	table.sort(samples,function(a,b)return a.hits>b.hits end)
	for _,row in ipairs(samples)do
		if row.hits<Menu.Clear.Q:Value()then break end
		if self:FarmRayValid(row.point,samples)then best=row;break end
	end
	if not best then return false end
	local prediction=Core:Prediction(self.QSpell)
	prediction:GetPrediction(best.unit,myHero)
	if not prediction:CanHit(2)or not prediction.CastPosition then return false end
	return Core:Cast(HK_Q,prediction.CastPosition,{prevalidateWorldCast=true,validate=function(q,resolved)
		return self:FarmAllowed()and not IsUnderTurret(myHero)
			and self:FarmRayValid(resolved and resolved.position or q.target,self:LaneSamples())
	end})
end

function AhriChampion:Clear()
	if not self:FarmAllowed()then return end
	local qReady, wReady = IsReady(_Q), IsReady(_W) and lastW + 250 < GetTickCount()
	if not qReady and not wReady then return end
	local laneQ, laneW = Menu.Clear.Q:Value() > 0 and qReady, Menu.Clear.W:Value() > 0 and wReady
	if (laneQ or laneW) and not IsUnderTurret(myHero) then
		if laneQ and self:LaneQ()then return end
		if laneW and GetMinionCount(700, myHero.pos) >= Menu.Clear.W:Value() then
			local minions=Core:DecisionUnits('GetEnemyMinions')
			for _,minion in ipairs(minions)do
				if minion.team~=300 and self:CastW(minion,function()
					return self:FarmAllowed()and not IsUnderTurret(myHero)and GetMinionCount(700,myHero.pos)>=Menu.Clear.W:Value()
				end)then return end
			end
		end
	end
	local jungleQ, jungleW = Menu.Clear.JungleQ:Value() and qReady, Menu.Clear.JungleW:Value() and wReady
	if not jungleQ and not jungleW then return end
	local target
	for _,monster in ipairs(Core:DecisionUnits('GetMonsters'))do
		if IsValid(monster)and monster.pos2D.onScreen and GetDistance(monster.pos,myHero.pos)<=self.QSpell.Range
			and(not target or monster.maxHealth>target.maxHealth)then target=monster end
	end
	if not target then return end
	if jungleQ then
		if self:CastPrediction(HK_Q,target,function()return self:FarmAllowed()and Menu.Clear.JungleQ:Value()end)then return end
	end
	-- A fresh distance: the provider's cached `distance` field can be stale or absent.
	if jungleW and GetDistance(target.pos,myHero.pos) <= 700 then
		self:CastW(target,function()return self:FarmAllowed()and Menu.Clear.JungleW:Value()end)
	end
end

function AhriChampion:CastPrediction(spell,target,validate,range,hitchance)
	local settings=spell==HK_Q and self.QSpell or spell==HK_E and self.ESpell
	if not settings or not Core:SkillshotCurrent(target)then return false end
	local prediction=Core:Prediction(settings)
	prediction:GetPrediction(target,myHero)
	if not prediction:CanHit(hitchance or 3)then return false end
	return Core:Cast(spell,prediction.CastPosition,{prevalidateWorldCast=true,range=range,validate=validate})
end

function AhriChampion:RegisterGuide(guide,settings)
	local nodes={comboQ={node=Menu.Combo.Q,label='Combo Q'},comboW={node=Menu.Combo.W,label='Combo W'},
		comboE={node=Menu.Combo.E,label='Combo E'},harassE={node=Menu.Harass.E,label='Harass E'},
		farm={node=Menu.Clear.Enabled,label='Spell farming'},jungleQ={node=Menu.Clear.JungleQ,label='Jungle Q'},
		jungleW={node=Menu.Clear.JungleW,label='Jungle W'},antiDash={node=Menu.Misc.EAntiDash,label='Anti-dash E'}}
	nodes.lastHitQ={node=Menu.LastHit.Q,label='Last Hit Q'}
	nodes.closeW={node=Menu.Misc.ProximityW,label='Close-range W'}
	nodes.comboR={node=Menu.Combo.R,label='Combo R'}
	nodes.fleeR={node=Menu.Misc.FleeR,label='Flee R'}
	nodes.peelR={node=Menu.Misc.PeelR,label='Dash away from melee'}
	if Menu.Misc.EFlash then nodes.eflash={node=Menu.Misc.EFlash,label='Charm then Flash'}end
	local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
	return guide:Register('champion',{'Ahri: quick start','Ahri: Charm and casting','Ahri: farming'},function(page)
		if page==1 then return {title=self.profile.id=='classic'and 'Classic Ahri'or 'Ahri',subtitle='Use Orbama mode keys. Spell readiness never disables your attacks.',cards={
			{'COMBO','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..'. [[comboQ]], [[comboW]] and [[comboE]] have separate permissions. Q and E are cast within 900 units for reliable hits.'},
			{'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. Q, W and [[harassE]] poke above the Harass mana limit. Release the mode to cancel waiting casts.'},
			{'CONTROL','[[antiDash]] is independent of combat modes. It only keeps an E request while the target is still dashing toward you. Channel, focus and chat conditions remain active.'}},note='[[comboR]] dashes to finish a kill the whole burst reaches, to follow a Charm and to get around a blocked Charm, inside your health and enemy-count limits and never under an enemy turret. [[fleeR]] dashes toward the cursor, stepping around terrain. [[peelR]] dashes away from a melee enemy who reaches you while you are low. '..(Menu.Misc.EFlash and 'Holding [[eflash]] charms an enemy just beyond Charm range and Flashes during the cast; Flash is never used otherwise.'or 'Flash remains manual.')..' The last free dash of a running Spirit Rush is used before it expires.'}end
		if page==2 then return {title='Charm preference and spell evidence',subtitle='An E cast is not proof that Charm hit.',cards={
			{'PREFERENCE','Q can prefer an enemy with a live Charm buff attributed to Ahri. Expired, foreign or unknown-source buffs do not establish that preference. Your valid explicit selection takes precedence.'},
			{'FRESH AIM','Q and E resolve prediction and collision again when executable. Orbama can finish full validation before cursor positioning through its prepared-cast capability. Moving targets and new blockers can still cancel an outdated request.'},
			{'FOX-FIRE','W retains a living intended enemy within 700 units. [[closeW]] casts it without a mode key within 350 units, above the automatic mana limit. Being near an enemy does not guarantee every Fox-Fire hits them.'},
			{'REACTIONS','Q and E are always cast at immobilised enemies through the shared prediction window, which allows a brief post-CC movement window when it still fits inside the spell footprint. Q always finishes an enemy when its outgoing magic hit exceeds current health, shields and regeneration. W does the same within 550 units when one flame is enough. Only the finishers ignore the automatic mana limit.'}},note='A first Spirit Rush needs a kill; while one is running the free dashes also chase and reposition. Return-flight aiming and exact acceleration still need verification.'}end
		return {title='Lane and jungle farming',subtitle='[[farm]] must be enabled before either farming path spends spells.',cards={
			{'LANE Q','Clear: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..'. The Q threshold counts predicted minions on one outgoing ray, not a circle around a minion. Coverage is checked again before send.'},
			{'JUNGLE','[[jungleQ]] and [[jungleW]] have separate controls. The largest eligible camp unit is preferred without sorting the provider\'s object list. Low mana or mode release cancels waiting work.'},
			{'LAST HIT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT)..' with [[lastHitQ]] enabled. Q only rescues a minion already killable by its outgoing hit when a ready attack cannot secure it. Incoming lethal damage, an active attack or lost consent cancels the request.'}},note='Q damage uses separate Normal and Classic values. Acceleration and return-flight timing still need live verification; Last Hit is conservative.'}
	end,cfg,links,activate)
end

function AhriChampion:Draw()
	if myHero.dead then return end

	if Menu.Draw.Q:Value() and IsReady(_Q) then
		Draw.Circle(myHero.pos, self.QSpell.Range, 1, Draw.Color(255, 66, 244, 113))
	end
	if Menu.Draw.W:Value() and IsReady(_W) then
		Draw.Circle(myHero.pos, self.profile.wRange, 1, Draw.Color(255, 120, 170, 255))
	end
	if Menu.Draw.E:Value() and IsReady(_E) then
		Draw.Circle(myHero.pos, self.ESpell.Range, 1, Draw.Color(255, 244, 238, 66))
	end
	local rush=self.rush
	if Menu.Draw.R:Value()then
		if rush or IsReady(_R)then Draw.Circle(myHero.pos,self.profile.rRange,1,Draw.Color(200,255,120,200))end
		local preview=self.rPreview
		if preview and preview.expires>Game.Timer()and(rush or IsReady(_R))then Draw.Circle(preview.point,60,1,Draw.Color(220,255,120,200))end
	end
	if Menu.Misc.EFlash and Menu.Misc.EFlash:Value()and IsReady(_E)then Draw.Circle(myHero.pos,self.ESpell.Range+400,1,Draw.Color(200,244,238,66))end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:RegisterPolicy({
    methods={
        AutoE=function()return {priority='interactive'}end,
        AutoTargets=function()return {priority='interactive'}end,
        OnPreAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode) or nil end,

        Combo=function()return Core:ModeContext("Combo")end,
        Harass=function()return Core:ModeContext("Harass")end,
        Clear=function()return Core:ModeContext("LaneClear")end,
        LastHit=function()return Core:ModeContext("LastHit")end,
        Flee=function()return Core:ModeContext("Flee")end,
    },
    exceptions={non_interrupting_summoner=true},
    channel=function(self,q)return not Core:SelfChanneling() end,
    validate=function(self,q,slot,resolved)
        if slot==_R and q.kind=='world' then return not Game.isWall(Vector((resolved and resolved.position)or q.target))end
        return true
    end,
})

AhriChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Ahri"]="Ahri"}
local normalSupported={["Ahri"]=true}

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
