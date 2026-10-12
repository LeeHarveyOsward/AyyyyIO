return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Vayne"]=function()return _G.OrbamaFamily:Require("d40613ed5ffae032821803b0a37f77b7121411bf5070de8eb2a0a3a794cafdba")()end
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
if champion=="Vayne" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Vayne',profiles={normal=true,classic=true},
 Create=function(context)
-- Separate installed-asset profiles. Runtime alias/timing acceptance is recorded externally.
local profiles=ChampionProfiles('Vayne')
local finite=Core.finite
-- Tumble displacement for the published mobility capability (Evade escape).
-- Distance: installed asset castRangeDisplayOverride=300 for both profiles
-- (research/family-assets/{Jade_Vayne,Vayne}/spells.json; Jade_VayneQ / VayneTumble);
-- the asset has no dash speed. Classic speed: two live mid-dash samples, session
-- 606b59a7 (game 937.08-937.30 and 1240.11-1240.33: 187/186 units in .218 s, ~857/s);
-- planned as a bracket. Normal speed is unmeasured: a wider planning bracket only.
-- Cast delay bracket .05 (input/server) to .25 (asset castFrame 7.5 at 30 fps).
local dashProfiles={
 Jade_Vayne={name='Jade_VayneQ',range=300,speeds={730,860,990},castDelays={.05,.25},
  source='asset castRangeDisplayOverride 300 (jade_vayne.bin sha 95463c26); speed from 2 live mid-dash samples ~857/s session 606b59a7; bracket +-15%'},
 Vayne={name='VayneTumble',range=300,speeds={650,900,1150},castDelays={.05,.25},
  source='asset castRangeDisplayOverride 300 (Vayne spells.json); Normal dash speed unmeasured; wide planning bracket'},
}
local function activeBuff(buff,now)
 if not buff or (buff.count or 0)<=0 then return false end
 local ending=Core.buffExpiry(buff)
 return ending and ending>now
end
local VayneChampion=class("VayneChampion")

function VayneChampion:__init()		 
	self.profile=assert(profiles[myHero.charName],"Unsupported Vayne profile")
	self:LoadMenu()
	self:PublishMobility()
	Callback.Add("Draw", function() self:Draw() end)
	Callback.Add("Tick", function() self:OnTick() end)
	self.ESpell = {Type = OrbamaPrediction.SPELLTYPE_LINE, Delay = 0.25, Radius = 0, Range = 680, Speed = 2200, Collision = true, CollisionTypes = {OrbamaPrediction.COLLISION_YASUOWALL}}
	self.EPrediction=Core:Prediction(self.ESpell)
 self.QEPrediction=Core:Prediction({Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.70,Radius=0,Range=680,Speed=2200,Collision=false})
 self.flashCombo=Core:FlashFollow('VayneFlashCondemn')
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
end

function VayneChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Vayne'})
 Menu:MenuElement({type=MENU,id='Combo',name='Combo'})
 Menu.Combo:MenuElement({id='Q',name='Use Q',value=true})
 Menu.Combo:MenuElement({id='Qmode',name='Q direction',value=1,drop={'To the side of the target','Toward the cursor'}})
 Menu.Combo:MenuElement({id='Qdistance',name='Side Q keeps this distance to the target',value=500,min=200,max=700,step=50,menu=false})
 Menu.Combo:MenuElement({id='AllowDangerousQ',name='Allow Q under turrets or into more enemies',value=false})
 Menu.Combo:MenuElement({id='E',name='Use E to stun against a wall',value=true})
 Menu.Combo:MenuElement({id='QE',name='Use Q to reach a wall stun position',value=true})
 Menu.Combo:MenuElement({id='R',name='Use R',value=true})
 Menu.Combo:MenuElement({id='Renemies',name='R needs at least this many enemies nearby',value=2,min=1,max=5,step=1})
 Menu.Combo:MenuElement({id='Rdistance',name='R counts enemies within',value=500,min=250,max=750,step=50,menu=false})
 Menu:MenuElement({type=MENU,id='Harass',name='Harass'})
 Menu.Harass:MenuElement({id='Q',name='Use Q',value=true})
 Menu.Harass:MenuElement({id='E',name='Use E on a target with 2 Silver Bolts stacks',value=false})
 Menu.Harass:MenuElement({id='EStun',name='Use E to stun against a wall',value=true})
 for _,name in ipairs({'Combo','Harass'})do
  Menu[name]:MenuElement({id='AfterAttack',name='In attack range, Q only right after an attack',value=true,menu=false})
  Menu[name]:MenuElement({id='Mana',name='Only above mana %',value=name=='Combo'and 10 or 30,min=0,max=100,step=5,menu=name~='Combo'})
 end
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,name in ipairs({'LaneClear','JungleClear','LastHit'})do
  Menu:MenuElement({type=MENU,id=name,name=name})
  Menu[name]:MenuElement({id='Q',name=name=='LastHit'and 'Use Q on minions an attack cannot take'or 'Use Q',value=true})
  if name~='LastHit'then Menu[name]:MenuElement({id='AfterAttack',name='Q only right after an attack',value=true,menu=false})end
  Menu[name]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu:MenuElement({type=MENU,id='Flee',name='Flee'})
 Menu.Flee:MenuElement({id='Q',name='Use Q toward the cursor or away from a chaser',value=true})
 Menu.Flee:MenuElement({id='E',name='Use E on a chaser',value=true})
 Menu.Flee:MenuElement({id='Mana',name='Only above mana %',value=10,min=0,max=100,step=5,menu=false})
 Menu:MenuElement({type=MENU,id='Assist',name='Extra binds'})
 Menu.Assist:MenuElement({id='E',name='Cast E at the selected target',key=string.byte('T')})
 Menu.Assist:MenuElement({id='QE',name='Q to a wall stun position, then E',key=string.byte('U')})
 Menu.Assist:MenuElement({id='FlashE',name='Flash, then E the target into a wall',key=string.byte('K')})
 Menu.Assist:MenuElement({id='Mana',name='Only above mana %',value=10,min=0,max=100,step=5,menu=false})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='Eantimelee',name='Use E to push away melee enemies who reach you',value=true})
 Menu.Misc:MenuElement({id='Eantidash',name='Use E on enemies who dash onto you, else Q away',value=true})
 Menu.Misc:MenuElement({id='EKill',name='Use E to finish champions',value=true})
 Menu.Misc:MenuElement({id='EAuto',name='Stun enemies against walls without a key',value=true})
 Menu.Misc:MenuElement({id='PreserveStealth',name='Do not attack while stealthed after Q',value=false})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='E',name='E range',value=false})
 Menu.Draw:MenuElement({id='Stun',name='Wall stun target and Q position',value=true})
end

function VayneChampion:OnTick()
	self:StealthPolicy()
	if ShouldWait() then
		return
	end
	self:ObserveAttack()
	self:ObserveCondemn()
	self:FlashCondemn()
	self:SilverPreference()
	self:EAntiDash()
	self:QAntiDash()
	self:EAntiMelee()
	self:EPeel()
	self:EInterrupt()
	self:EFinisher()
	self:EAutoStun()
	if IsCasting() then return end
	self:ContinueQE();self:SemiQE();self:SemiE();self:ContinueFarm()
	local Mode = GetMode()
	if Mode == "Combo" then
		self:Combo()
	elseif Mode == "Harass" then
		self:HarassStun();self:Harass()
	elseif Mode == "Flee" then self:FleeE();self:Flee()
	elseif Mode == "LastHit" then self:LastHit()
	elseif Mode == "LaneClear" then
	 if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR]then self:LaneClear()end
	 if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR]then self:JungleClear()end
	end
end

function VayneChampion:CheckWall(from,to,length)
 if not from or not to or GetDistanceSqr(from,to)<1 then return false end
 local direction=(to-from):Normalized();local side=Vector(-direction.z,0,direction.x)
 local margin=20 -- wall must also exist this far to either side of the knockback line
 local function corridor(d)
  local p=to+direction*d
  if self:WallAt(p)~=true then return false end
  return self:WallAt(p+side*margin)==true and self:WallAt(p-side*margin)==true
 end
 -- All rays must establish the same cross-section, not unrelated thin obstacles.
 for d=0,length,20 do if corridor(d)then return true end end
 return corridor(length)
end
function VayneChampion:CanInterceptDash(target)
 if not self:IsDashThreat(target)then return false end
 local speed=target.pathing and target.pathing.dashSpeed
 if not finite(speed)or speed<=0 then return false end
 local remaining=GetDistance(target.pos,target.posTo)/speed
 local arrival=self.ESpell.Delay+GetDistance(myHero.pos,target.pos)/self.ESpell.Speed
 return remaining>=arrival
end

function VayneChampion:CanCondemn(target)
    if not IsReady(_E) or not IsValid(target) or target.type~=Obj_AI_Hero then return false end
    local spell=myHero:GetSpellData(_E)
    local range=self.profile.eRange+(target.boundingRadius or 0)+(myHero.boundingRadius or 0)
    -- Prefer the host's actual cast range if exposed; retain the Classic
    -- reference envelope when absent rather than substituting modern data.
    if spell.range and spell.range>0 then range=math.min(range,spell.range+(target.boundingRadius or 0)+(myHero.boundingRadius or 0)) end
    if GetDistance(target.pos,myHero.pos)>range then return false end
    return not _G.SDK.ObjectManager:IsHeroImmortal(target)
end

function VayneChampion:CondemnPrediction(target)
    if not self:CanCondemn(target) then return nil end
    local p=self.EPrediction;p:GetPrediction(target,myHero)
    if not p.UnitPosition then return nil end
    -- E is targeted: a moving target's skillshot hit-chance is not a reason to
    -- refuse it. The predicted impact position still determines the wall ray.
    local wall=OrbamaPrediction:GetCollision(myHero.pos,p.UnitPosition,self.ESpell.Speed,
        self.ESpell.Delay,0,self.ESpell.CollisionTypes,target.networkID)
    if wall then return nil end
    return Vector(p.UnitPosition)
end

function VayneChampion:CanStun(target)
    local impact=self:CondemnPrediction(target)
    local stun=impact and self:CheckWall(myHero.pos,impact,self.profile.eKnockback) or false
    local reason=not impact and 'invalid_or_prediction_or_projectile_wall' or not stun and 'no_safe_wall' or 'wall'
    -- Both hypotheses must agree (GGAIO checks both): a moving target is stunned
    -- only when the corridor also exists behind where it stands now, so a target
    -- walking out of the corridor does not waste Condemn on a predicted wall.
    if stun and GetDistance(impact,target.pos)>25 and not self:CheckWall(myHero.pos,Vector(target.pos),self.profile.eKnockback)then
        stun=false;reason='current_position_no_wall'
    end
    if stun then
        local direction=(Vector(impact)-Vector(myHero.pos)):Normalized()
        self.stunPreview={unit=target,id=target.networkID,impact=Vector(impact),wall=Vector(impact)+direction*self.profile.eKnockback,at=Game.Timer()}
    end
    if Core.logger then Core:Trace('condemn_evaluation',{target=target.networkID,stun=stun,reason=reason,impact=impact and {x=impact.x,z=impact.z},source={x=myHero.pos.x,z=myHero.pos.z}},500)end
    return stun
end

function VayneChampion:IsDashThreat(target)
    local path=target.pathing
    return path and path.isDashing and target.posTo
        and GetDistance(target.posTo,myHero.pos)<400
        and GetDistanceSqr(target.posTo,myHero.pos)<GetDistanceSqr(target.pos,myHero.pos)
end

function VayneChampion:IsMeleeThreat(target)
    if type(target.range)~='number'or target.range>=400 or GetDistance(target.pos,myHero.pos)>250 then return false end
    local cast=target.activeSpell
    if cast and cast.valid and cast.isAutoAttack and (cast.target==myHero.handle or cast.target==myHero.networkID) then return true end
    if target.pathing and target.pathing.hasMovePath and target.posTo then
        return GetDistanceSqr(target.posTo,myHero.pos)+25<GetDistanceSqr(target.pos,myHero.pos) and IsFacingMe(target)
    end
    return GetDistance(target.pos,myHero.pos)<=target.range+(target.boundingRadius or 0)+(myHero.boundingRadius or 0) and IsFacingMe(target)
end

function VayneChampion:EAntiMelee()
	if Menu.Misc.Eantimelee:Value() and IsReady(_E) then
		local melees = {}
		local enemies = _G.SDK.ObjectManager:GetEnemyHeroes(250)
		for i = 1, math.min(#enemies,10) do
			local enemy = enemies[i]
			if self:CanCondemn(enemy) and self:IsMeleeThreat(enemy) then
				table.insert(melees, enemy)
			end
		end
		if #melees > 0 then
			table.sort(melees, function(a, b)
				return a.health + (a.totalDamage * 2) + (a.attackSpeed * 100)
					> b.health + (b.totalDamage * 2) + (b.attackSpeed * 100)
			end)
			for i = 1, #melees do
				local target = melees[i]
				if self:CondemnPrediction(target) then
					if Core:Cast(HK_E,target,{ttl=100,independent=false}) then break end
				end
			end
		end
	end
end

function VayneChampion:EAntiDash()
	if Menu.Misc.Eantidash:Value() and IsReady(_E) then
		local enemies = _G.SDK.ObjectManager:GetEnemyHeroes(self.ESpell.Range)
		for i = 1, math.min(#enemies,10) do
			local enemy = enemies[i]
			if self:CanInterceptDash(enemy) and self:CondemnPrediction(enemy) then
				if Core:Cast(HK_E,enemy,{priority="interactive",ttl=100,independent=false}) then break end
			end
		end
	end
end

-- Condemn stops a channel (it displaces): an interruptible enemy channel that
-- outlasts the bolt's flight is answered with or without a mode key. No switch:
-- the interrupt is worth more than holding E for a wall.
function VayneChampion:InterruptAllowed(enemy)
	return self:CanCondemn(enemy)and Core:CanInterrupt(enemy,self.ESpell.Delay+GetDistance(myHero.pos,enemy.pos)/self.ESpell.Speed)
		and self:CondemnPrediction(enemy)~=nil
end
function VayneChampion:EInterrupt()
	if not IsReady(_E)then return end
	local enemies=_G.SDK.ObjectManager:GetEnemyHeroes(self.ESpell.Range)
	for i=1,math.min(#enemies,10)do
		local enemy=enemies[i]
		if self:InterruptAllowed(enemy)and Core:Cast(HK_E,enemy,{priority="interactive",ttl=100,independent=false})then break end
	end
end
-- The third Silver Bolts hit is the kit's damage: while fighting, attacks go to
-- the champion in attack range that already carries two owned stacks (the
-- weakest of them). The shared preference never overrides the player's selected
-- champion and lapses by itself when the mark or the reach is gone.
function VayneChampion:SilverTarget()
	local mode=GetMode()
	if mode~='Combo'and mode~='Harass'then return nil end
	local rank=myHero:GetSpellData(_W).level
	if type(rank)~='number'or rank<1 then return nil end
	local units=Core:DecisionUnits('GetEnemyHeroes');local best
	for i=1,math.min(#units,10)do
		local u=units[i]
		if IsValid(u)and _G.SDK.Data:IsInAutoAttackRange(myHero,u)and not _G.SDK.ObjectManager:IsHeroImmortal(u)then
			local impact=self:AttackImpact(u)
			if impact and self:SilverBoltsAt(u,impact)==2 and(not best or u.health<best.health)then best=u end
		end
	end
	return best
end
function VayneChampion:SilverPreference()
	local marked=self:SilverTarget()
	if marked then Core:PreferAttack('vayne_silver',marked,.25)else Core:ReleaseAttackPreference('vayne_silver')end
end
function VayneChampion:ModeMenu(mode)
 return Menu[mode]
end
function VayneChampion:ManaAllowed(mode)
 local node=self:ModeMenu(mode)
 return node and Core.manaAbove(node.Mana:Value())
end
function VayneChampion:WallAt(point)
 if type(Game.isWall)~='function'then return nil end
 local ok,result=pcall(Game.isWall,point)
 if not ok or type(result)~='boolean'then return nil end
 return result
end
function VayneChampion:QTerrain(endpoint)
 if not endpoint or GetDistance(endpoint,myHero.pos)<1 or GetDistance(endpoint,myHero.pos)>301 then return false end
 local length=GetDistance(endpoint,myHero.pos)
 for d=0,300,50 do
  if self:WallAt(myHero.pos:Extended(endpoint,math.min(d,length)))~=false then return false end
 end
 return true
end
function VayneChampion:PublishMobility()
 local dash=dashProfiles[myHero.charName];if not dash then return end
 Core:RegisterMobility({kind='dash',slot=_Q,key=HK_Q,name=dash.name,range=dash.range,speeds=dash.speeds,
  castDelays=dash.castDelays,profile=self.profile.id,label='Use champion dash (Vayne Q)',source=dash.source,
  allowed=function(point)return self:EvadeQAllowed(point)end})
end
-- Controller policy for an Evade escape tumble: no owned Q-to-E plan,
-- full tumble path on known walkable terrain, never into enemy turret range.
-- Threat safety is Evade's evaluation; this does not repeat it.
function VayneChampion:EvadeQAllowed(point)
 if self:QEOwnsQ()then return false,'qe_sequence_owns_q'end
 if point==nil then return true end
 local endpoint=Vector(point.x,myHero.pos.y,point.z)
 if not self:QTerrain(endpoint)then return false,'q_terrain'end
 if IsUnderTurret2(endpoint)and not IsUnderTurret(myHero)then return false,'enemy_turret'end
 return true
end
function VayneChampion:QSafe(endpoint)
 if not self:QTerrain(endpoint)then return false end
 if not Menu.Combo.AllowDangerousQ:Value()then
  if IsUnderTurret2(endpoint)and not IsUnderTurret(myHero)then return false end
  if GetEnemyCount(350,endpoint)>GetEnemyCount(350,myHero.pos)then return false end
 end
 return true
end
function VayneChampion:ObserveAttack()
 local before=self.attackWitness
 self.attackWitness=ObserveAttack(_G,self.attackWitness,function(id)
  local units=Core:DecisionUnits('GetEnemyHeroes')
  for i=1,math.min(#units,10)do local u=units[i];if u.networkID==id or u.handle==id then return u end end
  for _,method in ipairs({'GetEnemyMinions','GetMonsters'})do
   local minions=Core:DecisionUnits(method)
   for i=1,math.min(#minions,32)do local u=minions[i];if u.networkID==id or u.handle==id then return u end end
  end
 end)
 -- The Silver Bolts mark as it stood while this attack was still winding up.
 -- An attack first seen after its release has no such reading and is never
 -- counted as in flight (its hit may already be on the mark).
 local w=self.attackWitness
 if w and w~=before and w.vayneStacks==nil then
  w.vayneStacks=Game.Timer()<w.at and w.object and self:SilverBolts(w.object,0)or false
 end
end
-- Our own released attack still flying at `target` that lands within `delay`:
-- the witness must name the same target, the windup must be over (an attack
-- in windup can still be cancelled) and the mark must be unchanged since the
-- windup (a changed mark means the hit already landed). A requested attack
-- never counts.
function VayneChampion:AttackInFlight(target,delay)
 local w=self.attackWitness;local now=Game.Timer()
 if not w or not target or w.object~=target or w.target~=target.networkID or type(w.vayneStacks)~='number'or now<w.at then return false end
 local speed=_G.SDK.Attack:GetProjectileSpeed()
 if not finite(speed)or speed<=0 then return false end
 local landing=w.at+GetDistance(myHero.pos,target.pos)/speed
 if landing<=now or landing>now+(delay or 0)then return false end
 return self:SilverBolts(target,0)==w.vayneStacks
end
-- Owned stacks at `delay`, counting our attack in flight (WR 9684): one more
-- stack, and the third hit resets the mark.
function VayneChampion:SilverBoltsAt(target,delay)
 local stacks,proc=self:SilverBolts(target,delay)
 if self:AttackInFlight(target,delay)then stacks=(stacks+1)%3 end
 return stacks,proc
end
-- Harass Q for the third bolt: the empowered attack after this Q would be the
-- third owned hit, so it goes out without waiting for the next attack window.
function VayneChampion:ThirdBoltQ(target)
 if not target or target.type~=Obj_AI_Hero then return false end
 local impact=self:AttackImpact(target);if not impact then return false end
 return self:SilverBoltsAt(target,impact+.25)==2
end
-- Second return value: decline reason (development q_decline rows).
function VayneChampion:QAllowed(target,mode)
 local node=self:ModeMenu(mode)
 if not node or not node.Q:Value()then return false,'menu'end
 if(mode=='LastHit'or mode=='LaneClear'or mode=='JungleClear')and not Menu.Clear.SpellFarm:Value()then return false,'farm_toggle'end
 if not self:ManaAllowed(mode)then return false,'mana'end
 if not IsReady(_Q)then return false,'not_ready'end
 if not IsValid(target)or not(target.type==Obj_AI_Hero or self:FarmTarget(target,mode))then return false,'target'end
 if target.type==Obj_AI_Hero and _G.SDK.ObjectManager:IsHeroImmortal(target)then return false,'immortal'end
 if _G.SDK.Attack:IsActive()then return false,'attack_windup'end
 if self:HasSelfBuff(self.profile.qBuff)then return false,'q_buff_pending'end
 if GetDistance(myHero.pos,target.pos)>myHero.range+(myHero.boundingRadius or 0)+(target.boundingRadius or 0)+300 then return false,'far'end
 if node.AfterAttack and node.AfterAttack:Value()and _G.SDK.Data:IsInAutoAttackRange(myHero,target)and not(mode=='Harass'and self:ThirdBoltQ(target))then
  local witness=self.attackWitness
  if not witness or witness.object~=target or witness.target~=target.networkID then return false,'no_attack_witness'end
  if Game.Timer()<witness.at or Game.Timer()-witness.at>.35 then return false,'attack_window'end
 end
 return true
end
function VayneChampion:QPoint(target,mode,style)
 local allowed,why=self:QAllowed(target,mode)
 if not allowed then return nil,why end
 local point
 if style==1 then
  local a,b=CircleCircleIntersection(myHero.pos,target.pos,300,Menu.Combo.Qdistance:Value())
  if a and b then
   -- Keep mouse preference, but examine both legal side endpoints before refusing.
   if GetDistance(b,mousePos)<=GetDistance(a,mousePos)then a,b=b,a end
   local reach=myHero.range+(myHero.boundingRadius or 0)+(target.boundingRadius or 0)
   for i=1,2 do
    local candidate=i==1 and a or b
    if GetDistance(candidate,myHero.pos)>=1 then
     local endpoint=myHero.pos:Extended(Vector(candidate),300)
     if GetDistance(endpoint,target.pos)<=reach and self:QSafe(endpoint)then return endpoint end
    end
   end
   return nil,'side_unsafe_or_out_of_reach'
  end
 else point=mousePos end
 if not point then
  if _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return nil,'no_side_point'end
  point=target.pos
 end
 if GetDistance(point,myHero.pos)<1 then return nil,'zero_direction'end
 local endpoint=myHero.pos:Extended(Vector(point),300)
 local reach=myHero.range+(myHero.boundingRadius or 0)+(target.boundingRadius or 0)
 if GetDistance(endpoint,target.pos)>reach then return nil,'endpoint_out_of_reach'end
 if not self:QSafe(endpoint)then return nil,'endpoint_unsafe'end
 return endpoint
end
function VayneChampion:CastSafeQ(point,target,mode)
 -- Public helper keeps a bound combat target; it cannot create an unowned raw dash.
 target=target or _G.SDK.Orbwalker:GetTarget();mode=mode or GetMode()
 if not self:QAllowed(target,mode)then return false end
 local style=Menu.Combo.Qmode:Value()
 local endpoint=point and myHero.pos:Extended(Vector(point),300)or self:QPoint(target,mode,style)
 if not endpoint or not self:QSafe(endpoint)then return false end
 return Core:Cast(HK_Q,endpoint,{intentTarget=target,ttl=180,prevalidateWorldCast=true,
  resolve=function()
   if Menu.Combo.Qmode:Value()~=style then return nil,'q_policy_changed' end
   local current=self:QPoint(target,mode,style)
   return current and {position=current}or nil
  end,
  validate=function(_,resolved)
   local current=resolved and resolved.position
   return current and Menu.Combo.Qmode:Value()==style and self:QAllowed(target,mode)
    and(mode~='LastHit'or self:CanRescue(target))
    and GetDistance(current,target.pos)<=myHero.range+(myHero.boundingRadius or 0)+(target.boundingRadius or 0)
    and self:QSafe(current)
  end})
end
function VayneChampion:CombatQ(mode)
 if self:QEOwnsQ()then return false end
 self:ObserveAttack()
 local target=_G.SDK.Orbwalker:GetTarget()
 if not IsValid(target)or target.type~=Obj_AI_Hero then target=GetTarget(myHero.range+300)end
 local point,why=nil,'no_target'
 if target then point,why=self:QPoint(target,mode,Menu.Combo.Qmode:Value())end
 if point then return self:CastSafeQ(point,target,mode)end
 if Core.logger and why~='not_ready'and why~='attack_windup'and IsValid(target)and target.type==Obj_AI_Hero then
  Core:Trace('q_decline',{mode=mode,reason=why,target=target.networkID,distance=math.floor(GetDistance(myHero.pos,target.pos))},500)
 end
 return false
end
function VayneChampion:RAllowed(target)
 if not Menu.Combo.R:Value()or not self:ManaAllowed('Combo')or not IsReady(_R)or self:HasSelfBuff(self.profile.rBuff)then return false end
 if not IsValid(target)or target.type~=Obj_AI_Hero or GetDistance(myHero.pos,target.pos)>Menu.Combo.Rdistance:Value()then return false end
 local count=0;local units=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#units,10)do
  local u=units[i]
  if IsValid(u)and GetDistance(myHero.pos,u.pos)<=Menu.Combo.Rdistance:Value()then count=count+1 end
 end
 if count>=Menu.Combo.Renemies:Value()then return true end
 -- A duel is the other reason for Final Hour: one enemy who has reached Vayne
 -- (inside 350) and will not fall to the next three attacks. Poke at range and a
 -- target that is already dying do not spend the ultimate.
 if count~=1 or GetDistance(myHero.pos,target.pos)>350 then return false end
 local attack=_G.SDK.Damage:GetAutoAttackDamage(myHero,target)
 return finite(attack)and attack>0 and target.health>attack*3
end
function VayneChampion:Combo()
 if self:StartQE('Combo')then return end
 if Menu.Combo.R:Value()then
  local target=GetTarget(Menu.Combo.Rdistance:Value())
  if self:RAllowed(target)then Core:Cast(HK_R,nil,{intentTarget=target,validate=function()return self:RAllowed(target)end})end
 end
 if Menu.Combo.E:Value()and self:ManaAllowed('Combo')and IsReady(_E)then
  local targets=_G.SDK.TargetSelector:GetTargets(self.ESpell.Range)or {}
  for i=1,math.min(#targets,10)do local enemy=targets[i]
   if self:CanStun(enemy)and self:CastE(enemy,{ttl=120,independent=false,deferAttackWindup=true},true)then break end
  end
 end
 self:CombatQ('Combo')
end
function VayneChampion:Harass()
 self:CombatQ('Harass')
 if Menu.Harass.E:Value()then self:HarassCondemn(function(target)return self:HarassTwoStack(target)end,false)end
end
-- Harass E requests stay bound to the selected-target settings they were made under.
function VayneChampion:HarassCondemn(rule,stun)
 if not self:ManaAllowed('Harass')or not IsReady(_E)then return false end
 local selector=_G.SDK.TargetSelector
 local selected=selector.Selected
 local enabled,only=selector.MenuCheckSelected:Value(),selector.MenuCheckSelectedOnly:Value()
 local id,handle=selected and selected.networkID,selected and selected.handle
 local context=Core:ModeContext('Harass',function()
  return selector.MenuCheckSelected:Value()==enabled and selector.MenuCheckSelectedOnly:Value()==only
   and(not enabled or selector.Selected==selected and(not selected or selected.networkID==id and selected.handle==handle))
 end)
 local units=selector:GetTargets(self.ESpell.Range)or {}
 for i=1,math.min(#units,10)do local target=units[i]
  if rule(target)and self:CastE(target,{context=context,ttl=120,independent=false,deferAttackWindup=true},stun)then return true end
 end
 return false
end
-- The third Silver Bolt on an owned two-stack mark alive at impact, counting
-- our attack in flight.
function VayneChampion:HarassTwoStack(target)
 if not IsValid(target)then return false end
 local delay=self.ESpell.Delay+GetDistance(target.pos,myHero.pos)/self.ESpell.Speed
 return self:SilverBoltsAt(target,delay)==2 and self:CondemnPrediction(target)~=nil
end
-- Harass wall Condemn (on by default): the Combo stun rule under the Harass
-- mana gate, its own request owner so the two-stack switch does not refuse it.
function VayneChampion:HarassStun()
 if not Menu.Harass.EStun:Value()then return false end
 return self:HarassCondemn(function(target)return self:CanStun(target)end,true)
end

function VayneChampion:Draw()
	if myHero.dead then return end
	if Menu.Draw.E:Value() and IsReady(_E) then
		Draw.Circle(myHero.pos, self.profile.eRange, 1, Draw.Color(255, 244, 238, 66))
	end
	if not Menu.Draw.Stun:Value()then return end
	-- Prepared state only: no wall search, prediction or buff scan here. No Silver Bolts count: the game shows the rings.
	local now=Game.Timer();local gold=Draw.Color(255,255,200,60)
	local stun=self.stunPreview
	-- Kept up to a second (a skipped decision tick must not blink it) while the target lives and E is ready.
	if stun and now-stun.at<=1 and IsValid(stun.unit)and IsReady(_E)then
		Draw.Circle(stun.unit.pos,90,2,gold);Draw.Circle(stun.wall,50,2,gold)
		local at=stun.unit.pos:To2D();Draw.Text('STUN',16,at.x-18,at.y-60,gold)
	end
	local plan=self.qePlan
	if plan and plan.endpoint and(plan.phase=='waiting'or plan.phase=='observed')then Draw.Circle(plan.endpoint,45,2,Draw.Color(255,120,200,255))end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:RegisterPolicy({
    methods={
        LastHit=function()return Core:ModeContext('LastHit')end,
        LaneClear=function()return Core:ModeContext('LaneClear')end,
        JungleClear=function()return {mode='JungleClear',modes={_G.SDK.ORBWALKER_MODE_JUNGLECLEAR},priority='background'}end,
        SemiE=function()return Core:HeldContext(function()return Menu.Assist.E:Value()end)end,
        EAntiMelee=function()return {priority='interactive'}end,
        EAntiDash=function()return {priority='interactive'}end,
        EInterrupt=function()return {priority='interactive'}end,
        EFinisher=function()return {priority='interactive'}end,
        EPeel=function()return {priority='interactive'}end,
        QAntiDash=function()return {priority='interactive'}end,
        EAutoStun=function()return {priority='background'}end,
        FleeE=function()return Core:ModeContext('Flee')end,
        HarassStun=function()return Core:ModeContext('Harass')end,
        FlashCondemn=function()return Core:HeldContext(function()return Menu.Assist.FlashE:Value()end)end,

        Combo=function()return Core:ModeContext("Combo")end,
        Flee=function()return Core:ModeContext("Flee")end,
        Harass=function()return Core:ModeContext("Harass")end,
    },
    exceptions={non_interrupting_summoner=true},
    channel=function(self,q)return not Core:SelfChanneling() end,
    validate=function(self,q,slot,resolved)
        if slot==_E and q.object then
            if not self:CanCondemn(q.object) then return false end
            if (q.owner=='Combo'or q.owner=='Harass')and not self:ManaAllowed(q.owner)then return false end
            if q.owner=='Combo' then
                return self:CanStun(q.object)
            elseif q.owner=='Harass' then return self:HarassTwoStack(q.object)
            elseif q.owner=='HarassStun'then return Menu.Harass.EStun:Value()and self:ManaAllowed('Harass')and self:CanStun(q.object)
            elseif q.owner=='EFinisher'then return self:EFinisherAllowed(q.object)==true
            elseif q.owner=='EAutoStun'then return self:AutoStunAllowed(q.object)
            elseif q.owner=='EPeel'then return self:EPeelAllowed(q.object)
            elseif q.owner=='FleeE'then return Menu.Flee.E:Value()and self:ManaAllowed('Flee')and self:FleeETarget(q.object)
            elseif q.owner=='FlashCondemn'then return self:CanStun(q.object)
            elseif q.owner=='EAntiDash' then return Menu.Misc.Eantidash:Value()and self:CanInterceptDash(q.object) and self:CondemnPrediction(q.object)~=nil
            elseif q.owner=='EInterrupt'then return self:InterruptAllowed(q.object)
            elseif q.owner=='EAntiMelee'then return Menu.Misc.Eantimelee:Value()and self:IsMeleeThreat(q.object) and self:CondemnPrediction(q.object)~=nil end
        end
        return true
    end,
})

function VayneChampion:SilverBolts(target,delay)
 local rank=myHero:GetSpellData(_W).level
 if rank<1 or rank>5 or not target or not target.maxHealth then return 0,0 end
 local _,buff=Core:Fresh(GetBuffData,target,self.profile.wBuff)
 local shared=self.profile.id=='classic'and VayneProfile or NormalVayneProfile
 return shared.Stacks(buff,Game.Timer()+(delay or 0),myHero),shared.Damage(myHero,target)
end
function VayneChampion:HasSelfBuff(name,delay)
 if type(name)=='table'then for _,alias in ipairs(name)do if self:HasSelfBuff(alias,delay)then return true end end;return false end
 local _,buff=Core:Fresh(GetBuffData,myHero,name)
 return activeBuff(buff,Game.Timer()+(delay or 0))
end
function VayneChampion:Stealthed()return self:HasSelfBuff(self.profile.stealth)end
function VayneChampion:StealthPolicy()
 local hold=Menu.Misc.PreserveStealth:Value()and Core:Available()and self:Stealthed()
 -- This is only our client's attack block; manual input and movement remain owned by the player.
 Core.adapter:SetBlocked('stealth','attack',hold)
end
function VayneChampion:FleePoint()
 if not Menu.Flee.Q:Value()or not self:ManaAllowed('Flee')or not IsReady(_Q)or _G.SDK.Attack:IsActive()then return nil end
 if mousePos and GetDistance(mousePos,myHero.pos)>=1 then
  local point=myHero.pos:Extended(mousePos,300)
  if self:QSafe(point)then return point end
 end
 -- The cursor tumble is unsafe: directly away from the nearest chaser instead.
 local chaser=self:NearestChaser(900)
 if chaser and GetDistance(chaser.pos,myHero.pos)>=1 then
  local origin=Vector(myHero.pos)
  local away=origin+(origin-Vector(chaser.pos)):Normalized()*300
  if self:QSafe(away)then return away end
 end
end
function VayneChampion:NearestChaser(range)
 local best,distance;local units=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#units,10)do local u=units[i]
  if IsValid(u)and u.type==Obj_AI_Hero then
   local d=GetDistance(u.pos,myHero.pos)
   if d<=range and(not best or d<distance)then best,distance=u,d end
  end
 end
 return best
end
-- Flee Condemn: the nearest chaser inside its own attack reach (+50) or within
-- 300, or any enemy a wall stun is available on.
function VayneChampion:FleeETarget(u)
 if not IsValid(u)or u.type~=Obj_AI_Hero or not self:CanCondemn(u)then return false end
 local d=GetDistance(u.pos,myHero.pos)
 local reach=(type(u.range)=='number'and u.range or 0)+(u.boundingRadius or 0)+(myHero.boundingRadius or 0)+50
 if(d<=300 or d<=reach)and self:CondemnPrediction(u)then return true end
 return self:CanStun(u)
end
function VayneChampion:FleeE()
 if not Menu.Flee.E:Value()or not self:ManaAllowed('Flee')or not IsReady(_E)then return false end
 local best;local units=_G.SDK.ObjectManager:GetEnemyHeroes(self.ESpell.Range)
 for i=1,math.min(#units,10)do local u=units[i]
  if self:FleeETarget(u)and(not best or GetDistance(u.pos,myHero.pos)<GetDistance(best.pos,myHero.pos))then best=u end
 end
 return best~=nil and self:CastE(best,{ttl=100,independent=false},self.stunPreview and self.stunPreview.unit==best)or false
end
function VayneChampion:Flee()
 local point=self:FleePoint();if not point then return false end
 return Core:Cast(HK_Q,point,{ttl=150,independent=false,prevalidateWorldCast=true,
  resolve=function()local current=self:FleePoint();return current and {position=current}or nil end,
  validate=function(_,resolved)
   local current=self:FleePoint()
   return current and resolved and resolved.position and GetDistance(current,resolved.position)<1 and self:QSafe(resolved.position)
  end})
end
function VayneChampion:SemiE()
 if not Menu.Assist.E:Value()or not self:ManaAllowed('Assist')then return false end
 local target=GetTarget(self.ESpell.Range)
 if not self:CondemnPrediction(target)then return false end
 return Core:Cast(HK_E,target,{ttl=120,independent=false,validate=function()
  return Menu.Assist.E:Value()and self:ManaAllowed('Assist')and self:CondemnPrediction(target)~=nil
 end})
end
-- Held R assistance was removed by user request (2026-10-01): an unrelated G press spent R.
function VayneChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},
  e={node=Menu.Combo.E,label='Wall Condemn'},r={node=Menu.Combo.R,label='Combo R'},
  harass={node=Menu.Harass.E,label='Harass two-stack E'},
  dash={node=Menu.Misc.Eantidash,label='Anti-dash E'},melee={node=Menu.Misc.Eantimelee,label='Anti-melee E'},
  stealth={node=Menu.Misc.PreserveStealth,label='Preserve Q stealth'},flee={node=Menu.Flee.Q,label='Flee Q'},
  manualE={node=Menu.Assist.E,label='E bind'}}
 nodes.qe={node=Menu.Combo.QE,label='Combo Q-to-E'}
 nodes.qeHeld={node=Menu.Assist.QE,label='Q-to-E bind'}
 nodes.last={node=Menu.LastHit.Q,label='LastHit Q rescue'}
 nodes.lane={node=Menu.LaneClear.Q,label='Lane Q weave'};nodes.jungle={node=Menu.JungleClear.Q,label='Jungle Q weave'}
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Vayne: combat','Vayne: Condemn','Vayne: control'},function(page)
  if page==1 then return {title=self.profile.id=='classic'and 'Classic Vayne'or 'Vayne',subtitle='Combat uses your provider mode keys.',cards={
   {'TUMBLE','[[q]] keeps a reachable attack target and checks the path before sending. In attack range it waits for a witnessed attack to finish when the target is already in attack range.'},
   {'FINAL HOUR','[[r]] uses the configured nearby-enemy threshold, or a duel: one enemy who has reached you and will not fall to the next three attacks. Checked again before the request can send.'},
   {'SILVER BOLTS','While fighting, attacks go to the champion in attack range that carries two of your stacks. [[harass]] spends E only on an owned two-stack mark that lasts through the estimated impact. Normal and Classic use separate damage and buff profiles.'}},note='A request or input send is not evidence that a shot hit. No speculative Q damage is counted as a guaranteed kill.'}end
  if page==2 then return {title='Condemn',subtitle='E remains a targeted projectile.',cards={
   {'WALLS','[[e]] predicts the target at impact and samples a bounded terrain corridor behind it. Corner clearance and moving targets still affect the result.'},
   {'DEFENSE','Condemn interrupts an enemy channel in range without a mode key. [[dash]] reacts to an approaching dash. [[melee]] requires an approaching or attacking melee threat. Both run independently of Combo.'},
   {'POSITIONING','[[qe]] tumbles to a wall stun position in Combo; [[qeHeld]] does the same on its own bind. They spend Q only for a prospective same-target wall Condemn, then require the Q cast, completed displacement and a fresh E check from the actual landing.'},
   {'WAITING INPUT','The original target, mark, projectile obstruction and reason for casting are checked again. A released mode cancels waiting combat work.'}},note='Unknown terrain does not authorize a tumble or wall-stun claim. Condemn is not guaranteed to stun.'}end
  return {title='Control and movement',subtitle='The provider owns cursor and key cleanup.',cards={
   {'STEALTH','[[stealth]] pauses automated attacks while the recognized Q stealth buff remains active. It is off by default and does not block manual input or movement.'},
   {'ESCAPE','[[flee]] uses the provider Flee mode and tumbles toward the current mouse within the safe path policy.'},
   {'ASSIST','[[manualE]] requests targeted Condemn without requiring a wall. Releasing the key cancels waiting work.'}},note='[[last]], [[lane]] and [[jungle]] follow the farm toggle. The follow-up attack waits for the Q cast and its active buff on the same target.'}
 end,cfg,links,activate)
end
function VayneChampion:QBonusDamage(target)
 local rank=myHero:GetSpellData(_Q).level
 local ratio=self.profile.qRatio[rank]
 -- Classic Q scales higher during R (Jade_VayneQ scalingDamageUlt .40-.60).
 if ratio and self.profile.qRatioUlt and self:HasSelfBuff(self.profile.rBuff)then ratio=self.profile.qRatioUlt[rank]or ratio end
 if not ratio then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,ratio*myHero.totalDamage+self.profile.qAP*(myHero.ap or 0))
end
function VayneChampion:AttackImpact(target)
 local windup=_G.SDK.Attack:GetWindup();local speed=_G.SDK.Attack:GetProjectileSpeed()
 if type(windup)~='number'or windup<0 or windup~=windup or type(speed)~='number'or speed<=0 or speed~=speed then return nil end
 return windup+GetDistance(myHero.pos,target.pos)/speed
end
function VayneChampion:AttackDamageAt(target,delay)
 local sdk=_G.SDK
 if sdk.Damage.GetAutoAttackDamageAt then return sdk.Damage:GetAutoAttackDamageAt(myHero,target,delay)end
 -- Original GG has no future-mark API. Remove its current W proc and add only
 -- the independently decoded owned mark that remains alive at this impact.
 local base=sdk.Damage:GetAutoAttackDamage(myHero,target)
 local raw=sdk.BuffManager:GetBuffCount(target,self.profile.wBuff)
 if raw==2 then
  base=base-(self.profile.id=='normal'and NormalVayneProfile.Damage(myHero,{team=200,maxHealth=target.maxHealth})or VayneProfile.Damage(myHero,target))
 end
 local stacks,proc=self:SilverBolts(target,delay)
 return math.max(0,base)+(stacks==2 and proc or 0)
end
function VayneChampion:EmpoweredAttackDamage(target,delay)
 local damage=self:AttackDamageAt(target,delay)
 -- Both pinned providers already include Q in AA damage for their known alias.
 if _G.SDK.BuffManager:HasBuff(myHero,self.profile.qSdkBuff)then return damage end
 return damage+self:QBonusDamage(target)
end
function VayneChampion:FarmTarget(target,mode)
 if (mode~='LastHit'and mode~='LaneClear'and mode~='JungleClear')or not IsValid(target)or target.type~=Obj_AI_Minion then return false end
 if mode=='JungleClear'then return target.team==300 end
 return (target.team==100 or target.team==200)and target.team~=myHero.team
end
function VayneChampion:CanRescue(target)
 if not self:FarmTarget(target,'LastHit')or not self:QAllowed(target,'LastHit')then return false end
 local attack=self:AttackImpact(target);if not attack then return false end
 -- Conservative preparation budget; actual continuation requires the observed Q
 -- buff and live attack readiness, rather than injecting an estimated reset.
 local impact=attack+.45
 local hp=Core:UnshieldedLegacyForecast(target,impact)
 if not finite(hp)or hp<=0 then return false end
 local shield=math.max(0,target.shieldAD or 0);local regen=math.max(0,target.hpRegen or 0)
 local damage=self:EmpoweredAttackDamage(target,impact)
 if damage<hp+shield+regen*impact then return false end
 if _G.SDK.Orbwalker:CanAttack()and _G.SDK.Data:IsInAutoAttackRange(myHero,target)then
  local soon=Core:UnshieldedLegacyForecast(target,attack)
  if soon==nil then return false end
  if finite(soon)and soon>0 and self:AttackDamageAt(target,attack)>=soon+shield+regen*attack then return false end
 end
 return true
end
function VayneChampion:FarmQ(target,mode)
 if not self:FarmTarget(target,mode)or mode=='LastHit'and not self:CanRescue(target)then return false end
 local point=self:QPoint(target,mode,Menu.Combo.Qmode:Value());if not point then return false end
 local accepted=self:CastSafeQ(point,target,mode)
 if accepted then
  Core:AfterCast(HK_Q,function(q)
   self.farmPlan={target=target,id=target.networkID,mode=mode,context=q.context,expires=Game.Timer()+.8}
  end)
 end
 return accepted
end
function VayneChampion:FarmAttackAllowed(plan)
 if not plan or Game.Timer()>plan.expires or plan.id~=plan.target.networkID
  or not Core.adapter:ContextValid({context=plan.context})or not self:FarmTarget(plan.target,plan.mode)
  or not self:ModeMenu(plan.mode).Q:Value()
  or not self:HasSelfBuff(self.profile.qBuff)or _G.SDK.Attack:IsActive()
  or not _G.SDK.Orbwalker:CanAttack()or not _G.SDK.Data:IsInAutoAttackRange(myHero,plan.target)then return false end
 if plan.mode=='LastHit'then
  local impact=self:AttackImpact(plan.target);if not impact then return false end
  local hp=Core:UnshieldedLegacyForecast(plan.target,impact)
  if not finite(hp)or hp<=0 then return false end
  if not self:HasSelfBuff(self.profile.qBuff,impact)or self:EmpoweredAttackDamage(plan.target,impact)<hp+math.max(0,plan.target.shieldAD or 0)+math.max(0,plan.target.hpRegen or 0)*impact then return false end
 end
 return true
end
function VayneChampion:ContinueFarm()
 local plan=self.farmPlan;if not plan then return end
 if Game.Timer()>plan.expires or not Core.adapter:ContextValid({context=plan.context})or not self:FarmTarget(plan.target,plan.mode)then self.farmPlan=nil;return end
 if not self:FarmAttackAllowed(plan)then return end
 local accepted=Core:Attack(plan.target,{owner='FarmAttack',context=plan.context,ttl=120,
  validate=function()return self:FarmAttackAllowed(plan)end,
  observe=function(q)
   self:ObserveAttack();local w=self.attackWitness
   return w and w.target==plan.id and w.object==plan.target and w.at>=q.requestGameTime
  end})
 if accepted then self.farmPlan=nil end
end
function VayneChampion:LastHit()
 if not Menu.LastHit.Q:Value()then return end
 local units=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#units,32)do if self:FarmQ(units[i],'LastHit')then return end end
end
function VayneChampion:LaneClear()
 if not Menu.LaneClear.Q:Value()then return end
 local target=_G.SDK.Orbwalker:GetTarget()
 if self:FarmTarget(target,'LaneClear')then self:FarmQ(target,'LaneClear')end
end
function VayneChampion:JungleClear()
 if not Menu.JungleClear.Q:Value()then return end
 local target=_G.SDK.Orbwalker:GetTarget()
 if self:FarmTarget(target,'JungleClear')then self:FarmQ(target,'JungleClear')end
end
-- Optional positioning sequence. Input and observations remain in ActionClient.
local function qePoint(point)return point and finite(point.x)and finite(point.z)end
function VayneChampion:QEConsent(kind)
 if kind=='Combo'then
  return GetMode()=='Combo'and Menu.Combo.QE:Value()and Menu.Combo.Q:Value()and Menu.Combo.E:Value()
 end
 return kind=='Assist'and Menu.Assist.QE:Value()
end
function VayneChampion:QETarget(target,id,handle)
 return id~=nil and handle~=nil and IsValid(target)and target.type==Obj_AI_Hero
  and (target.team==100 or target.team==200)and target.team~=myHero.team
  and target.networkID==id and target.handle==handle and not _G.SDK.ObjectManager:IsHeroImmortal(target)
end
function VayneChampion:QECost(slot)
 local spell=myHero:GetSpellData(slot);local cost=spell and spell.mana
 if finite(cost)and cost>=0 then return cost end
end
function VayneChampion:QEReady(target,kind)
 local pending=Core.pending[HK_Q]
 if pending and (not self.qePlan or self.qePlan.qIntent~=pending)then return false end
 local q,e=self:QECost(_Q),self:QECost(_E)
 if q==nil or e==nil or not finite(myHero.mana)or myHero.mana<q+e then return false end
 if not self:QEConsent(kind)or not self:ManaAllowed(kind)or not IsReady(_Q)or not IsReady(_E)
  or not self:QETarget(target,target and target.networkID,target and target.handle)
  or _G.SDK.Attack:IsActive()or self:HasSelfBuff(self.profile.qBuff)
  or not myHero.pathing or myHero.pathing.isDashing~=false
  or target.pathing and target.pathing.isDashing or Core.pending[HK_E]then return false end
 if kind=='Combo'and not self:QAllowed(target,'Combo')then return false end
 return true
end
function VayneChampion:QEWallFrom(target,origin)
 -- The additional .45 seconds is a planning allowance, not observed Q duration.
 local p=self.QEPrediction;p:GetPrediction(target,origin)
 local impact=p.UnitPosition
 if not qePoint(impact)then return false end
 local range=self.profile.eRange+(target.boundingRadius or 0)+(myHero.boundingRadius or 0)
 local native=myHero:GetSpellData(_E).range
 if type(native)=='number'and native>0 then range=math.min(range,native+(target.boundingRadius or 0)+(myHero.boundingRadius or 0))end
 if GetDistance(origin,impact)>range then return false end
 local blocked=OrbamaPrediction:GetCollision(origin,impact,self.ESpell.Speed,self.ESpell.Delay+.45,0,self.ESpell.CollisionTypes,target.networkID)
 return not blocked and self:CheckWall(origin,Vector(impact),self.profile.eKnockback)
end
-- Enemies a Q-to-E may serve (at most 5): the attack target, the selector's
-- choice, then every enemy within E range + 300. None when one of them can
-- already be stunned from here (the plain Condemn takes it).
function VayneChampion:QECandidates(kind)
 local list,seen={},{}
 local reach=self.profile.eRange+300
 local function add(u)
  if #list>=5 or not IsValid(u)or u.type~=Obj_AI_Hero or seen[u]or GetDistance(u.pos,myHero.pos)>reach then return true end
  seen[u]=true
  if not self:QEReady(u,kind)then return true end
  if self:CanStun(u)then return false end
  list[#list+1]=u;return true
 end
 if not add(_G.SDK.Orbwalker:GetTarget())or not add(GetTarget(reach))then return nil end
 local units=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#units,10)do if not add(units[i])then return nil end end
 return list
end
local qeAngles={0,22.5,-22.5,45,-45,67.5,-67.5,90,-90,112.5,-112.5,135,-135,157.5,-157.5,180}
-- Sixteen tumble endpoints (every 22.5 degrees), nearest the cursor first, for
-- up to five enemies (14Series 37 rays, WR any enemy). Returns the endpoint
-- nearest the cursor that is safe and gives a wall Condemn, its ray and the
-- enemy it serves. Preparation only: the dispatch resolver re-evaluates the
-- chosen ray for the chosen enemy.
function VayneChampion:QEPoint(kind)
 local origin=Vector(myHero.pos);local aim=mousePos
 if not qePoint(origin)or not qePoint(aim)or GetDistance(origin,aim)<1 then return nil end
 local targets=self:QECandidates(kind);if not targets or #targets==0 then return nil end
 local direction=(Vector(aim)-origin):Normalized();local endpoints,evaluated=0,0
 for _,degrees in ipairs(qeAngles)do
  local radians=degrees*math.pi/180;local c,s=math.cos(radians),math.sin(radians)
  local ray=Vector(direction.x*c-direction.z*s,0,direction.x*s+direction.z*c)
  local endpoint=origin+ray*300;endpoints=endpoints+1
  if self:QSafe(endpoint)then
   for i=1,#targets do evaluated=evaluated+1
    if self:QEWallFrom(targets[i],endpoint)then
     if Core.logger then Core:Trace('condemn_evaluation',{kind='qe_search',endpoints=endpoints,evaluated=evaluated,targets=#targets,target=targets[i].networkID,stun=true},500)end
     return endpoint,ray,targets[i]
    end
   end
  end
 end
 if Core.logger then Core:Trace('condemn_evaluation',{kind='qe_search',endpoints=endpoints,evaluated=evaluated,targets=#targets,stun=false},500)end
end
function VayneChampion:QEActive()
 local plan=self.qePlan
 if plan and (plan.phase=='complete'or not self:QEConsent(plan.kind))then self.qePlan=nil;return false end
 -- A timeout alone never replays input. After the shared client has finalized
 -- our requests, a later ready spell cycle may start a fresh gameplay intention.
 if plan and Game.Timer()>plan.expires and plan.qIntent and plan.qIntent.outcome
  and (not plan.eIntent or plan.eIntent.outcome)and not Core.pending[HK_Q]and not Core.pending[HK_E]
  and self:QECost(_Q)~=nil and self:QECost(_E)~=nil
  and IsReady(_Q)and IsReady(_E)and not self:HasSelfBuff(self.profile.qBuff)
  and not IsCasting()then self.qePlan=nil;return false end
 return plan~=nil
end
-- The plan owns Q only while it is live or its own Q request is unresolved. An
-- ended plan is kept until Q and E are both ready again so that a timeout never
-- starts a second Q-E; that record must not also refuse the ordinary tumble and
-- the Evade tumble for the whole E cooldown.
function VayneChampion:QEOwnsQ()
 if not self:QEActive()then return false end
 local plan=self.qePlan
 return plan.phase~='ended'or not(plan.qIntent and plan.qIntent.outcome)
end
function VayneChampion:StartQE(kind)
 if self:QEActive()then return self.qePlan.phase~='ended'or self.qePlan.eSubmitted==true end
 if not self:QEConsent(kind)then return false end
 local endpoint,ray,target=self:QEPoint(kind);if not endpoint then return false end
 local id,handle=target.networkID,target.handle
 local danger=Menu.Combo.AllowDangerousQ:Value()
 local function consent()
  return self:QEConsent(kind)and target.networkID==id and target.handle==handle
   and Menu.Combo.AllowDangerousQ:Value()==danger
 end
 local context=kind=='Combo'and Core:ModeContext('Combo',consent)or Core:HeldContext(consent)
 local plan={kind=kind,target=target,id=target.networkID,handle=target.handle,ray=ray,origin=Vector(myHero.pos),
  expires=Game.Timer()+1.1,phase='waiting',context=context,endpoint=endpoint}
 self.qePlan=plan
 local accepted=Core:Cast(HK_Q,endpoint,{owner='QEPosition',intentTarget=target,context=context,ttl=180,
  independent=false,prevalidateWorldCast=true,
  resolve=function()
   if self.qePlan~=plan or not self:QEConsent(kind)or Game.Timer()>plan.expires then return nil,'qe_context_ended'end
   plan.origin=Vector(myHero.pos);plan.endpoint=plan.origin+plan.ray*300
   return {position=plan.endpoint}
  end,
  validate=function(_,resolved)
   local point=resolved and resolved.position
   return self.qePlan==plan and Game.Timer()<=plan.expires
    and self:QETarget(target,plan.id,plan.handle)and self:QEReady(target,kind)
    and point and GetDistance(point,myHero.pos)>=299 and GetDistance(point,myHero.pos)<=301
    and self:QSafe(point)and self:QEWallFrom(target,point)
  end,
  observe=function(q)
   local spell=myHero:GetSpellData(_Q)
   return not q.ambiguous and spell and finite(spell.currentCd)and spell.currentCd>(q.cooldown or 0)and self:HasSelfBuff(self.profile.qBuff)
  end})
 if not accepted then self.qePlan=nil;return false end
 plan.qIntent=Core.pending[HK_Q]
 Core:AfterCast(HK_Q,function(q)
  if self.qePlan==plan and not q.ambiguous and Game.Timer()<=plan.expires then plan.phase='observed'end
 end)
 return true
end
function VayneChampion:QEFollowupAllowed(plan)
 local cost=self:QECost(_E)
 if cost==nil or not finite(myHero.mana)or myHero.mana<cost then return false end
 if self.qePlan~=plan or plan.phase~='observed'or Game.Timer()>plan.expires
  or not self:QEConsent(plan.kind)or not Core.adapter:ContextValid({context=plan.context})
  or not self:QETarget(plan.target,plan.id,plan.handle)or not IsReady(_E)
  or not self:HasSelfBuff(self.profile.qBuff)or not myHero.pathing or myHero.pathing.isDashing~=false then return false end
 local displacement=GetDistance(myHero.pos,plan.origin)
 -- Sanity bounds for an observed full tumble; they are not a terrain guarantee.
 if not finite(displacement)or displacement<250 or displacement>350 then return false end
 return self:CanStun(plan.target)
end
function VayneChampion:ContinueQE()
 if not self:QEActive()then return end
 local plan=self.qePlan
 if Game.Timer()>plan.expires then plan.phase='ended';return end
 -- A Q request that was refused before it was sent cast nothing: the plan ends
 -- there instead of holding Combo's own R, E and Q to the 1.1 s expiry. The
 -- ended record stays until that expiry, so a refused attempt is not retried
 -- every tick.
 if plan.phase=='waiting'and plan.qIntent and plan.qIntent.outcome=='rejected_before_send'then plan.phase='ended';return end
 if plan.phase~='observed'or plan.eSubmitted then return end
 if Core.pending[HK_E]then plan.phase='ended';return end
 if not self:QEFollowupAllowed(plan)then
  -- The live plan holds the rest of Combo. Once the observed tumble is over
  -- (its dash seen and ended, or 0.3 s after the cast when no dash was seen) and
  -- the Condemn is still not legal from where it ended, the plan ends; Combo's
  -- own E takes the stun if one appears. It used to wait out the full 1.1 s.
  local path=myHero.pathing
  if path and path.isDashing==true then plan.dashSeen=true
  elseif path and path.isDashing==false then plan.observedAt=plan.observedAt or Game.Timer()
   if plan.dashSeen or Game.Timer()-plan.observedAt>.3 then plan.landedAt=plan.landedAt or Game.Timer()
    if Game.Timer()-plan.landedAt>.15 then plan.phase='ended'end
   end
  end
  return
 end
 local accepted=Core:Cast(HK_E,plan.target,{owner='QECondemn',context=plan.context,ttl=100,independent=false,
  validate=function()return self:QEFollowupAllowed(plan)end})
 -- One E submission per observed Q, even if dispatch later becomes uncertain.
 if accepted then
  plan.eSubmitted=true
  plan.eIntent=Core.pending[HK_E]
  Core:AfterCast(HK_E,function(q)
   if self.qePlan==plan and not q.ambiguous then plan.phase='complete'end
  end)
 end
end
function VayneChampion:SemiQE()return self:StartQE('Assist')end
-- E with a development record of the claim: was a stun predicted, and did the
-- target receive a stun within 0.6 s of the bolt (condemn_outcome trace).
function VayneChampion:CastE(target,options,stun)
 local accepted=Core:Cast(HK_E,target,options)
 if accepted and Core.logger then
  Core:AfterCast(HK_E,function(q)
   if q.ambiguous then return end
   local now=Game.Timer()
   self.condemnClaim={unit=target,id=target.networkID,owner=q.owner,stun=stun==true,at=now,
    expires=now+self.ESpell.Delay+GetDistance(myHero.pos,target.pos)/self.ESpell.Speed+.6}
  end)
 end
 return accepted
end
function VayneChampion:Stunned(unit)
 local count=unit and unit.buffCount
 if type(count)~='number'or count<0 or count>128 then return false end
 for i=0,count do local b=unit:GetBuff(i)
  if b and b.type==5 and(b.count or 0)>0 then return true end
 end
 return false
end
function VayneChampion:ObserveCondemn()
 if not Core.logger then return end
 local now=Game.Timer();local claim=self.condemnClaim
 if claim then
  local stunned=IsValid(claim.unit)and self:Stunned(claim.unit)
  if stunned or now>claim.expires then
   Core:Trace('condemn_outcome',{target=claim.id,owner=claim.owner,claimed=claim.stun,stunned=stunned==true,elapsed=now-claim.at})
   self.condemnClaim=nil
  end
 end
 -- Which stealth buff the host shows after Q under R (profile.stealth aliases).
 if(not self.stealthTraceAt or now-self.stealthTraceAt>3)and self:HasSelfBuff(self.profile.rBuff)and self:HasSelfBuff(self.profile.qBuff)then
  self.stealthTraceAt=now
  local names={};local count=myHero.buffCount
  if type(count)=='number'and count>=0 and count<=128 then
   for i=0,count do local b=myHero:GetBuff(i);local name=b and(b.count or 0)>0 and b.name
    if type(name)=='string'and #names<12 and(name:find('Stealth')or name:find('Fade')or name:find('Invis'))then names[#names+1]=name end
   end
  end
  Core:Trace('vayne_stealth_buffs',{profile=self.profile.id,names=names,recognized=self:Stealthed()})
 end
end
-- Condemn damage (profile per kit): the first hit, plus the terrain hit when
-- the wall stun holds. Physical, mitigated.
function VayneChampion:EDamage(target,stun)
 local rank=myHero:GetSpellData(_E).level;local p=self.profile
 local base=p.eBase and p.eBase[rank];if not base then return 0 end
 local bonus=finite(myHero.bonusDamage)and math.max(0,myHero.bonusDamage)or 0
 local raw=base+p.eAD*bonus
 if stun then raw=raw+p.eTerrain[rank]+p.eTerrainAD*bonus end
 local damage=_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
 return finite(damage)and damage or 0
end
function VayneChampion:EImpact(target)
 return self.ESpell.Delay+GetDistance(myHero.pos,target.pos)/self.ESpell.Speed
end
-- Condemn finisher: first hit, terrain hit when the stun holds, and the third
-- Silver Bolt when the mark (counting our attack in flight) is at two at impact.
-- Refused on a spell shield, and while the next attack in range kills first, so
-- E stays available for peel. Validation re-reads stacks, health and corridor.
function VayneChampion:EFinisherAllowed(target)
 if not Menu.Misc.EKill:Value()or not self:CanCondemn(target)then return false,'off_or_range'end
 if Core:SpellShielded(target)~=false then return false,'spell_shield'end
 local delay=self:EImpact(target)
 local stacks,proc=self:SilverBoltsAt(target,delay)
 proc=stacks==2 and finite(proc)and proc or 0
 -- Cheap gate: even the terrain hit would not reach current health.
 if self:EDamage(target,true)+proc<target.health then return false,'too_healthy'end
 if _G.SDK.Data:IsInAutoAttackRange(myHero,target)then
  local ready,impact=Core:AttackReadyIn(),self:AttackImpact(target)
  if ready and ready<=.1 and impact and Core:Lethal(target,impact,self:AttackDamageAt(target,impact),{kind='physical',attack=true})==true then
   return false,'attack_kills_first'
  end
 end
 if not self:CondemnPrediction(target)then return false,'projectile'end
 local damage=self:EDamage(target,self:CanStun(target))+proc
 return Core:Lethal(target,delay,damage,{kind='physical'})
end
function VayneChampion:EFinisher()
 if not Menu.Misc.EKill:Value()or not IsReady(_E)then return false end
 local units=_G.SDK.ObjectManager:GetEnemyHeroes(self.ESpell.Range)
 for i=1,math.min(#units,10)do local u=units[i]
  if self:EFinisherAllowed(u)==true and self:CastE(u,{priority='interactive',ttl=100,independent=false})then return true end
 end
 return false
end
-- Wall Condemn without a mode key (background). Not while a fighting or
-- farming mode is held (those decide themselves) and not on an enemy under its
-- own turret unless Vayne is already there.
function VayneChampion:AutoStunAllowed(u)
 if not Menu.Misc.EAuto:Value()or not IsValid(u)or u.type~=Obj_AI_Hero then return false end
 local sdk=_G.SDK;local m=sdk.Orbwalker.Modes
 for _,mode in ipairs({sdk.ORBWALKER_MODE_COMBO,sdk.ORBWALKER_MODE_HARASS,sdk.ORBWALKER_MODE_LANECLEAR,sdk.ORBWALKER_MODE_LASTHIT,sdk.ORBWALKER_MODE_JUNGLECLEAR})do
  if m[mode]then return false end
 end
 if IsUnderTurret2(u.pos)and not IsUnderTurret(myHero)then return false end
 return self:CanStun(u)
end
function VayneChampion:EAutoStun()
 if not Menu.Misc.EAuto:Value()or not IsReady(_E)then return false end
 local units=_G.SDK.ObjectManager:GetEnemyHeroes(self.ESpell.Range)
 for i=1,math.min(#units,10)do local u=units[i]
  if self:AutoStunAllowed(u)and self:CastE(u,{ttl=120,independent=false,deferAttackWindup=true},true)then return true end
 end
 return false
end
-- Low-health peel: at or below half health, E a ranged champion inside 200
-- that is attacking Vayne (melee threats are the anti-melee rule).
function VayneChampion:EPeelAllowed(u)
 if not Menu.Misc.Eantimelee:Value()or not IsValid(u)or u.type~=Obj_AI_Hero then return false end
 if not finite(myHero.maxHealth)or myHero.maxHealth<=0 or myHero.health>myHero.maxHealth*.5 then return false end
 if type(u.range)~='number'or u.range<400 then return false end
 if GetDistance(u.pos,myHero.pos)>200+(u.boundingRadius or 0)+(myHero.boundingRadius or 0)then return false end
 if not Core:CastWindup(u,-1,1.25,true,myHero.networkID,myHero.handle)then return false end
 return self:CanCondemn(u)and self:CondemnPrediction(u)~=nil
end
function VayneChampion:EPeel()
 if not Menu.Misc.Eantimelee:Value()or not IsReady(_E)then return false end
 local units=_G.SDK.ObjectManager:GetEnemyHeroes(400)
 for i=1,math.min(#units,10)do local u=units[i]
  if self:EPeelAllowed(u)and self:CastE(u,{priority='interactive',ttl=100,independent=false})then return true end
 end
 return false
end
-- Anti-gap tumble: a dash ending within 400 that Condemn cannot answer (E down,
-- the bolt too late, or the projectile blocked) is answered by a Q directly
-- away from the dash end, under the anti-dash switch and the Q safety policy.
function VayneChampion:EAnswersDash(enemy)
 return IsReady(_E)and self:CanInterceptDash(enemy)and self:CondemnPrediction(enemy)~=nil
end
function VayneChampion:AntiDashPoint(enemy)
 if not IsValid(enemy)or not self:IsDashThreat(enemy)then return nil end
 local origin=Vector(myHero.pos);local from=Vector(enemy.posTo)
 if GetDistance(from,origin)<1 then from=Vector(enemy.pos)end
 if GetDistance(from,origin)<1 then return nil end
 local point=origin+(origin-from):Normalized()*300
 return self:QSafe(point)and point or nil
end
function VayneChampion:QAntiDash()
 if not Menu.Misc.Eantidash:Value()or not IsReady(_Q)or self:QEOwnsQ()then return false end
 local pending=Core.pending[HK_E];if pending and pending.owner=='EAntiDash'then return false end
 local units=_G.SDK.ObjectManager:GetEnemyHeroes(1200)
 for i=1,math.min(#units,10)do local enemy=units[i]
  local point=not self:EAnswersDash(enemy)and self:AntiDashPoint(enemy)
  if point then
   return Core:Cast(HK_Q,point,{intentTarget=enemy,ttl=150,independent=false,prevalidateWorldCast=true,
    resolve=function()local current=self:AntiDashPoint(enemy);return current and {position=current}or nil end,
    validate=function(_,resolved)
     local current=resolved and resolved.position
     return current~=nil and Menu.Misc.Eantidash:Value()and not self:QEOwnsQ()and not self:EAnswersDash(enemy)
      and self:IsDashThreat(enemy)and self:QSafe(current)
    end})
  end
 end
 return false
end
-- Condemn-Flash (bind, SeriesV2 2623-2647): Flash to a landing from which the
-- knockback line through the target meets a wall, then Condemn from there.
-- Flash goes first, so the knockback direction is the landing-target line and
-- needs no mid-flight assumption. A wall stun already available is cast
-- directly without Flash.
function VayneChampion:FlashLanding(target)
 local status,why=Core:FlashStatus();if not status then return nil,why end
 local cost=self:QECost(_E);if cost==nil or not finite(myHero.mana)or myHero.mana<cost+status.cost then return nil,'mana'end
 local tpos=Vector(target.pos);local origin=Vector(myHero.pos);local best,bestDistance
 local reach=self.profile.eRange+(target.boundingRadius or 0)
 for i=0,15 do
  local a=i*math.pi/8;local u=Vector(math.cos(a),0,math.sin(a))
  -- One corridor test per direction: the wall behind the target along u.
  if self:CheckWall(tpos-u*100,tpos,self.profile.eKnockback)then
   for _,d in ipairs({200,325,450})do
    local landing=tpos-u*math.min(d,reach)
    local distance=GetDistance(landing,origin)
    if distance>=100 and distance<=status.range and self:WallAt(landing)==false and(not best or distance<bestDistance)then best,bestDistance=landing,distance end
   end
  end
 end
 if not best then return nil,'no_wall_landing'end
 return best
end
function VayneChampion:FlashCondemn()
 local combo=self.flashCombo
 if combo:Busy()then combo:Maintain();return true end
 if not Menu.Assist.FlashE:Value()or not IsReady(_E)or not self:ManaAllowed('Assist')then return false end
 local target=GetTarget(self.profile.eRange+400)
 if not IsValid(target)or target.type~=Obj_AI_Hero or _G.SDK.ObjectManager:IsHeroImmortal(target)then return false end
 if self:CanStun(target)then return self:CastE(target,{owner='FlashCondemn',ttl=120,independent=false},true)end
 local landing,why=self:FlashLanding(target)
 if not landing then
  if Core.logger then Core:Trace('flash_condemn_decline',{reason=why,target=target.networkID},500)end
  return false
 end
 local id,handle=target.networkID,target.handle;local knock=self.profile.eKnockback
 local function authorized()return Menu.Assist.FlashE:Value()and self:QETarget(target,id,handle)end
 return combo:Start({order='flash_first',aim=landing,authorized=authorized,mana=self:QECost(_E),ttl=1.0,
  valid=function(pos)
   return authorized()and IsReady(_E)and GetDistance(pos,target.pos)<=self.profile.eRange+(target.boundingRadius or 0)+(myHero.boundingRadius or 0)
    and self:CheckWall(Vector(pos),Vector(target.pos),knock)
  end,
  follow=function(context)return self:CastE(target,{owner='FlashCondemn',context=context,ttl=150,independent=false},true)end})==true
end
-- Health-bar combo (S9): two attacks, a ready Q's bonus, a ready E's first hit
-- and one Silver Bolts proc when the hits reach the third. Partial: no terrain
-- hit, items or R.
function VayneChampion:ComboDamage(u)
 local aa=_G.SDK.Damage:GetAutoAttackDamage(myHero,u)
 if not finite(aa)or aa<0 then aa=0 end
 local stacks,proc=self:SilverBoltsAt(u,0)
 if not finite(proc)then proc=0 end
 -- The provider's attack damage already carries the proc at two stacks.
 if stacks==2 then aa=math.max(0,aa-proc)end
 local damage,hits=2*aa,2
 if IsReady(_Q)then damage=damage+self:QBonusDamage(u)end
 if IsReady(_E)then damage=damage+self:EDamage(u,false);hits=hits+1 end
 if stacks+hits>=3 then damage=damage+proc end
 return damage,true
end

VayneChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Vayne"]="Vayne"}
local normalSupported={["Vayne"]=true}

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
