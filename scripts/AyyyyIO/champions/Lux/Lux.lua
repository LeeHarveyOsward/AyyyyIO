return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Lux"]=function()return _G.OrbamaFamily:Require("89459892ba4f481a961559e990c1c9d4223afa36958ba2872a218e31877b85f9")()end
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
if champion=="Lux" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Lux',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.10

-- Normal (Lux) and Classic (Jade_Lux) Lux. Every number lives in
-- CombatProfiles/ChampionProfiles/Lux.lua with its source in
-- CombatProfiles/lux-provenance.json; no value is borrowed across profiles.
local profiles = ChampionProfiles('Lux')
local finite,manaAbove=Core.finite,Core.manaAbove
-- Predicate with a map bound, not Core.point (which builds a Vector).
local function point(p)return p~=nil and finite(p.x)and finite(p.z)and math.abs(p.x)<100000 and math.abs(p.z)<100000 end
local function flat(a,b)local dx,dz=a.x-b.x,a.z-b.z;return math.sqrt(dx*dx+dz*dz)end
-- Perpendicular distance from p to the segment origin->origin+dir*length.
local function rayDistance(p,origin,dx,dz,length)
    local x,z=p.x-origin.x,p.z-origin.z;local along=x*dx+z*dz
    if along<0 or along>length then return math.huge end
    return math.abs(x*dz-z*dx)
end
-- Shorter on-screen points along the same fixed-length ray (cursor reach only).
local SCREEN_REACH={900,650,400}
-- Required prediction hit chance (2 normal, 3 high): narrow Q and R need high, the wide E zone normal.
local Q_HIT,E_HIT,R_HIT=3,2,3
local readyAttack={attack='ready'}
local function latency()
    local data=_G.SDK.Data;local ok,value=false,nil
    if data and data.GetLatency then ok,value=pcall(data.GetLatency,data)end
    return ok and finite(value)and value>=0 and value<1 and value or .05
end

local LuxChampion=class("LuxChampion")

function LuxChampion:__init()
	self.profile=assert(profiles[myHero.charName],'Unsupported Lux mechanics profile')
	local p=self.profile
	local minion,hero,wall=OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL
	self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=p.qDelay,Radius=p.qRadius,Range=p.qRange,Speed=p.qSpeed,Collision=true,MaxCollision=0,CollisionTypes={minion,hero,wall}}
	-- Light Binding continues through its first unit (Classic: half damage and a 1 s root on the
	-- second; Normal: full damage and the same 2 s root).
	self.QPassSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=p.qDelay,Radius=p.qRadius,Range=p.qRange,Speed=p.qSpeed,Collision=true,MaxCollision=1,CollisionTypes={minion,hero,wall}}
	self.WSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=p.wDelay,Radius=p.wRadius,Range=p.wRange,Speed=p.wSpeed,Collision=false}
	self.ESpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=p.eDelay,Radius=p.eRadius,Range=p.eRange,Speed=p.eSpeed,Collision=false}
	self.RSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=p.rDelay,Radius=p.rRadius,Range=p.rRange,Speed=math.huge,Collision=false}
	self.qObservedAt=-10
	self.seen={};self.blinks={};self.castSeen={}
	self:LoadMenu()
	self:RegisterShieldDefense()
	-- Health-bar combo damage (shared display): ready Q, E (or the armed zone) and R, the mark
	-- already on the enemy and one attack. The passive applied by those spells is left out.
	Core:RegisterComboDamage(function(unit)return self:ComboDamage(unit),true end)
	Core:RegisterCleanup('Lux',function()if self.chain then self.chain.cancelled=true end;self.chain=nil;Core:ReleaseAttackPreference('LuxPassive')end)
	Callback.Add("Tick",function()self:OnTick()end)
	Callback.Add("Draw",function()self:Draw()end)
	if _G.SDK.Orbwalker and _G.SDK.Orbwalker.OnPreAttack then _G.SDK.Orbwalker:OnPreAttack(function(args)self:OnPreAttack(args)end)end
end

-- Support play (Harass.Support, off): in Harass the lane minions are left to the
-- allied champion near Lux, so she does not take the farm; champions, monsters and
-- structures are still attacked.
local SUPPORT_RANGE=1050
function LuxChampion:SupportVeto(target)
	if not Menu.Harass.Support:Value()or GetMode()~='Harass'then return false end
	if not target or target.type~=Obj_AI_Minion or target.team==300 or target.team==myHero.team then return false end
	local allies=Core:DecisionUnits('GetAllyHeroes')
	for i=1,math.min(#allies,6)do local a=allies[i]
		if a~=myHero and a.networkID~=myHero.networkID and IsValid(a)and flat(a.pos,myHero.pos)<=SUPPORT_RANGE then return true end
	end
	return false
end
function LuxChampion:OnPreAttack(args)
	if args and args.Process~=false and self:SupportVeto(args.Target)then args.Process=false end
end

function LuxChampion:LoadMenu()
	local icon="http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/Lux.png"
	Menu=MenuElement({type=MENU,id="Classic_AIO_"..myHero.charName,name='AyyyyIO - Lux',leftIcon=icon})
	Menu:MenuElement({type=MENU,id="Combo",name="Combo"})
	Menu.Combo:MenuElement({id="Q",name="Use Q",value=true})
	Menu.Combo:MenuElement({id="E",name="Use E",value=true})
	Menu.Combo:MenuElement({id="R",name="Use R",value=true})
	Menu.Combo:MenuElement({id="RLethal",name="Use R when the combo will kill",value=true})
	Menu.Combo:MenuElement({id="RCount",name="Or when R hits this many enemies (0 = never)",value=3,min=0,max=5,step=1})
	Menu:MenuElement({type=MENU,id="Harass",name="Harass"})
	Menu.Harass:MenuElement({id="Q",name="Use Q",value=true})
	Menu.Harass:MenuElement({id="E",name="Use E",value=true})
	Menu.Harass:MenuElement({id="Mana",name="Only above mana %",value=40,min=0,max=100,step=5})
	Menu.Harass:MenuElement({id="Support",name="Leave lane minions to a nearby allied champion",value=false})
	Menu:MenuElement({type=MENU,id="Clear",name="Farming"})
	Menu.Clear:MenuElement({id="Enabled",name="Use abilities to farm (lane, jungle, last hit)",toggle=true,value=SpellFarmDefault(),key=73,callback=function(v)CheckChatBlock(Menu.Clear.Enabled,v)end})
	Menu.Clear:MenuElement({id="E",name="Lane minions E must hit (0 = never)",value=3,min=0,max=7,step=1})
	Menu.Clear:MenuElement({id="JungleQ",name="Use Q on jungle monsters",value=true})
	Menu.Clear:MenuElement({id="JungleE",name="Use E on jungle monsters",value=true})
	Menu.Clear:MenuElement({id="Mana",name="Only above mana %",value=30,min=0,max=100,step=5})
	Menu:MenuElement({type=MENU,id="LastHit",name="LastHit"})
	Menu.LastHit:MenuElement({id="Q",name="Use Q and E on minions an attack cannot take",value=true})
	Menu.LastHit:MenuElement({id="Mana",name="Only above mana %",value=20,min=0,max=100,step=5})
	Menu:MenuElement({type=MENU,id="Flee",name="Flee"})
	Menu.Flee:MenuElement({id="Q",name="Use Q to root a chasing enemy",value=true})
	Menu.Flee:MenuElement({id="W",name="Use W to shield yourself",value=true})
	Menu.Flee:MenuElement({id="E",name="Use E to slow a chasing enemy",value=true})
	Menu:MenuElement({type=MENU,id="Shield",name="W shield"})
	Menu.Shield:MenuElement({type=MENU,id="Allies",name="Allies W may shield"})
	_G.SDK.ObjectManager:OnAllyHeroLoad(function(args)
		if args and args.charName and not Menu.Shield.Allies[args.charName] then
			Menu.Shield.Allies:MenuElement({id=args.charName,name=args.charName,value=true})
		end
	end)
	Menu:MenuElement({type=MENU,id="KillSteal",name="Finish killable enemies without a mode key"})
	Menu.KillSteal:MenuElement({id="R",name="Use R (also Q then R when only both kill)",value=true})
	Menu:MenuElement({type=MENU,id="Misc",name="Behaviour"})
	Menu.Misc:MenuElement({id="EDetonate",name="Detonate E when an enemy is inside",value=true,menu=false})
	Menu.Misc:MenuElement({id="EHold",name="Keep the E slow while a follow-up can use it",value=false})
	Menu.Misc:MenuElement({id="QAntiDash",name="Use Q on enemies dashing or blinking at you",value=true})
	Menu.Misc:MenuElement({id="QImmobile",name="Use Q on immobile enemies",value=true})
	Menu.Misc:MenuElement({id="EImmobile",name="Use E on immobile enemies",value=true})
	Menu.Misc:MenuElement({id="RKey",name="Cast R at the enemy nearest the cursor",key=string.byte("T"),value=false})
	Menu:MenuElement({type=MENU,id="Draw",name="Drawings"})
	Menu.Draw:MenuElement({id="Q",name="Q range",value=false})
	Menu.Draw:MenuElement({id="W",name="W range",value=false})
	Menu.Draw:MenuElement({id="E",name="E range",value=false})
	Menu.Draw:MenuElement({id="R",name="R range (minimap)",value=false})
	Menu.Draw:MenuElement({id="Zone",name="E zone on the ground",value=true})
end

function LuxChampion:OnTick()
	self:TrackCasts()
	self:TrackE()
	self:TrackBlinks()
	if ShouldWait() then return end
	-- Classic 26.17: E may be detonated while Final Spark is casting (Normal: not).
	if self:DetonateE() then return end
	if IsCasting() then return end
	self:WeaveMark()
	self:AutoW()
	self:KillSteal()
	self:ChainQR()
	self:AutoQ()
	self:AutoE()
	local mode=GetMode()
	if mode=="Combo" then self:Combo()
	elseif mode=="Harass" then self:Harass()
	elseif mode=="LaneClear" then self:Clear()
	elseif mode=="LastHit" then self:LastHit()
	elseif mode=="Flee" then self:Flee() end
	self:SemiR()
end

-- Mechanics -----------------------------------------------------------------

function LuxChampion:Raw(base,ratio,slot)
	local data=myHero:GetSpellData(slot);local value=data and base[data.level or 0]
	if not value then return 0 end
	return value+ratio*(myHero.ap or 0)
end

function LuxChampion:Magic(target,raw)
	if raw<=0 or not IsValid(target)then return 0 end
	return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end

function LuxChampion:QDamage(target,second)
	local p=self.profile;local raw=self:Raw(p.qBase,p.qAP,_Q)
	if second then raw=raw*p.qSecond end
	return self:Magic(target,raw)
end
function LuxChampion:EDamage(target)return self:Magic(target,self:Raw(self.profile.eBase,self.profile.eAP,_E))end
function LuxChampion:RDamage(target)return self:Magic(target,self:Raw(self.profile.rBase,self.profile.rAP,_R))end

-- Illumination: our mark on an enemy, popped by an attack or by R. Only Lux's team can mark
-- the enemy, so an unattributed mark of this name is ours; a mark naming another source or a
-- second copy is refused (Core:SelfBuff). Returns the buff and its expiry while it still
-- holds at game time `at`.
function LuxChampion:Mark(target,at)
	if not IsValid(target)then return nil end
	local buff=Core:SelfBuff(target,self.profile.mark,true)
	local ends=buff and Core.buffExpiry(buff)
	if not finite(ends)or ends<=(at or Game.Timer())then return nil end
	return buff,ends
end
function LuxChampion:PassiveDamage(target)
	local p=self.profile;local level=myHero.levelData and myHero.levelData.lvl
	level=finite(level)and math.max(1,math.min(18,level))or 1
	return self:Magic(target,p.pFlat+p.pLevel*level+p.pAP*math.max(0,myHero.ap or 0))
end
-- One pop of the mark already on the target when it still holds at impact (R consumes it).
function LuxChampion:MarkPop(target,impact)
	return self:Mark(target,Game.Timer()+(impact or 0))and self:PassiveDamage(target)or 0
end
function LuxChampion:RKillDamage(target)return self:RDamage(target)+self:MarkPop(target,self.profile.rDelay)end

-- The shared kill rule: spell protection, magic shield pools, the health window and regeneration until impact.
local magicKill={kind='magical'}
function LuxChampion:Lethal(target,damage,delay)
	return Core:Lethal(target,delay or 0,damage,magicKill)==true
end

function LuxChampion:EArmed()
	local data=myHero:GetSpellData(_E);return data~=nil and data.name==self.profile.eToggle
end

function LuxChampion:ECastReady()
	return IsReady(_E)and not self:EArmed()
end

function LuxChampion:CastingR()
	local cast=myHero.activeSpell
	if not cast or not cast.valid or cast.name~=self.profile.rCast or cast.isStopped==true then return false end
	local finish=cast.castEndTime
	return not finite(finish)or finish<=0 or Game.Timer()<=finish+.05
end

function LuxChampion:QInFlight()
	local q=Core.pending[HK_Q]
	if q and not q.cancelled then return true end
	local p=self.profile
	return Game.Timer()-self.qObservedAt<p.qDelay+p.qRange/p.qSpeed
end

function LuxChampion:DashApproaching(target)
	local path=target and target.pathing
	return IsValid(target)and path and path.isDashing and point(target.posTo)
		and GetDistance(target.posTo,myHero.pos)<GetDistance(target.pos,myHero.pos)
		and GetDistance(target.posTo,myHero.pos)<=self.QSpell.Range or false
end

function LuxChampion:QImpact(position)return self.profile.qDelay+flat(position,myHero.pos)/self.profile.qSpeed end
function LuxChampion:ELand(position)return self.profile.eDelay+math.min(flat(position,myHero.pos),self.profile.eRange)/self.profile.eSpeed end

-- Observation --------------------------------------------------------------------

-- Development evidence for the conservative ranges (Lux-14): the distance of each own
-- observed cast placement. A placement the game clamps reveals the real maximum.
function LuxChampion:TrackCasts()
	local cast=myHero.activeSpell
	if not Core.logger or not cast or not cast.valid or not finite(cast.startTime)or self.castSeen.at==cast.startTime then return end
	local p=self.profile
	if cast.name==p.qCast or cast.name==p.wCast or cast.name==p.eCast or cast.name==p.rCast then
		self.castSeen.at=cast.startTime
		local origin=point(cast.startPos)and cast.startPos or myHero.pos
		if point(cast.placementPos)then Core:Trace('lux_cast_reach',{spell=cast.name,profile=p.id,distance=flat(origin,cast.placementPos)},250)end
	end
end

-- A blink (Flash, Ezreal E, ...) shows as a position jump of more than 400 between two
-- close looks without a dash path. Kept .35 s for an arrival Q.
function LuxChampion:TrackBlinks()
	local now=Game.Timer();local heroes=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#heroes,10)do
		local u=heroes[i];local id=u and u.networkID
		if id and IsValid(u)and point(u.pos)then
			local last=self.seen[id]
			if last and now-last.at<=.25 and flat(last,u.pos)>400 and not(u.pathing and u.pathing.isDashing)then
				self.blinks[id]={at=now,x=u.pos.x,z=u.pos.z}
			end
			last=last or {};last.x,last.z,last.at=u.pos.x,u.pos.z,now;self.seen[id]=last
		elseif id then self.seen[id]=nil end
	end
	for id,b in pairs(self.blinks)do if now-b.at>.35 then self.blinks[id]=nil end end
end

function LuxChampion:BlinkArrived(target)
	local b=IsValid(target)and self.blinks[target.networkID]
	return b and Game.Timer()-b.at<=.35 and flat(b,target.pos)<=150 or false
end

-- Aiming --------------------------------------------------------------------

-- Fresh prediction for a fixed-length line. Collision is measured to the
-- predicted target; the returned cast point may be shortened along the same
-- ray so the cursor can reach it. Returns aim or nil plus a reason.
function LuxChampion:LineAim(spell,target,hc,range)
	if not IsValid(target)then return nil,'target_invalid'end
	local prediction=Core:Prediction(spell);prediction:GetPrediction(target,myHero)
	if not prediction:CanHit(hc)then return nil,'prediction_declined'end
	local predicted=prediction.CastPosition
	if not point(predicted)then return nil,'prediction_missing'end
	local distance=flat(predicted,myHero.pos)
	if distance>(range or spell.Range)then return nil,'out_of_range'end
	if distance<1 then return nil,'aim_degenerate'end
	local second=false
	if spell.Collision then
		local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,predicted,spell.Speed,spell.Delay,spell.Radius,spell.CollisionTypes,target.networkID)
		if wall or type(count)~='number'or count>(spell.MaxCollision or 0)then return nil,'collision'end
		second=count>0
	end
	local cast=self:ScreenPoint(predicted,distance)
	if not cast then return nil,'aim_off_screen'end
	return {position=cast,predicted=Vector(predicted),second=second,hitChance=prediction.HitChance,distance=distance}
end

-- The aim itself when on screen, else a shorter on-screen point on the same ray.
function LuxChampion:ScreenPoint(aim,distance)
	local cast=Vector(aim)
	if cast:To2D().onScreen then return cast end
	distance=distance or flat(aim,myHero.pos)
	for _,reach in ipairs(SCREEN_REACH)do
		if reach<distance then
			local candidate=Vector(myHero.pos):Extended(Vector(aim),reach)
			if candidate:To2D().onScreen then return candidate end
		end
	end
	return nil
end

function LuxChampion:CastLine(key,spell,target,hc,validate,range)
	local aim=self:LineAim(spell,target,hc,range)
	if not aim then return false end
	local id=target.networkID
	return Core:Cast(key,aim.position,{intentTarget=target,range=range or spell.Range,prevalidateWorldCast=true,
		resolve=function()
			if not IsValid(target)or target.networkID~=id then return nil,'intent_ended'end
			local fresh,reason=self:LineAim(spell,target,hc,range)
			if not fresh then return nil,reason end
			return {position=fresh.position,data={targetID=id,predicted=fresh.predicted,second=fresh.second,hitChance=fresh.hitChance}}
		end,
		validate=function(q,resolved)
			local data=resolved and resolved.data or aim
			if resolved and resolved.data and resolved.data.targetID~=id then return false,'target_changed'end
			if validate then return validate(data)end
			return true
		end})
end

-- E lands where it is aimed; a target slightly past cast range can still be
-- covered from the range edge when it stays well inside the radius.
function LuxChampion:CircleAim(target,hc)
	if not IsValid(target)then return nil,'target_invalid'end
	local prediction=Core:Prediction(self.ESpell);prediction:GetPrediction(target,myHero)
	if not prediction:CanHit(hc)then return nil,'prediction_declined'end
	local predicted=prediction.CastPosition
	if not point(predicted)then return nil,'prediction_missing'end
	local range=self.ESpell.Range;local distance=flat(predicted,myHero.pos)
	local cast=Vector(predicted)
	if distance>range then
		if distance>range+self.profile.eRadius*.5 then return nil,'out_of_range'end
		cast=Vector(myHero.pos):Extended(Vector(predicted),range-1)
	end
	if not cast:To2D().onScreen then return nil,'aim_off_screen'end
	return {position=cast,predicted=Vector(predicted),hitChance=prediction.HitChance}
end

function LuxChampion:CastE(target,hc,validate)
	if not self:ECastReady()then return false end
	local aim=self:CircleAim(target,hc)
	if not aim then return false end
	local id=target.networkID
	-- Target reach includes the radius allowance; the cast point itself is clamped to E range.
	return Core:Cast(HK_E,aim.position,{intentTarget=target,range=self.ESpell.Range+self.profile.eRadius*.5,prevalidateWorldCast=true,
		resolve=function()
			if not IsValid(target)or target.networkID~=id then return nil,'intent_ended'end
			local fresh,reason=self:CircleAim(target,hc)
			if not fresh then return nil,reason end
			return {position=fresh.position,data={targetID=id,predicted=fresh.predicted}}
		end,
		validate=function()
			if self:EArmed()then return false,'e_already_armed'end
			if validate then return validate()end
			return true
		end})
end

-- E at a fixed ground point (a teleport or revive spot, a group of minions).
function LuxChampion:CastEAt(position,validate)
	if not self:ECastReady()or not point(position)or flat(position,myHero.pos)>self.ESpell.Range then return false end
	local center=Vector(position)
	if not center:To2D().onScreen then return false end
	return Core:Cast(HK_E,center,{range=self.ESpell.Range,prevalidateWorldCast=true,
		resolve=function()return {position=center}end,
		validate=function()
			if self:EArmed()then return false,'e_already_armed'end
			if validate then return validate()end
			return true
		end})
end

function LuxChampion:CastQ(target,hc,allowPass,validate)
	if not IsValid(target)or not IsReady(_Q)then return false end
	local accepted=self:CastLine(HK_Q,self.QSpell,target,hc,validate)
	if not accepted and allowPass then accepted=self:CastLine(HK_Q,self.QPassSpell,target,hc,validate)end
	if accepted then Core:AfterCast(HK_Q,function()self.qObservedAt=Game.Timer()end)end
	return accepted
end

-- Q at a fixed ground point: the ray to it may pass at most one unit.
function LuxChampion:QPointClear(position)
	local s=self.QSpell
	local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,position,s.Speed,s.Delay,s.Radius,s.CollisionTypes,nil)
	return not wall and type(count)=='number'and count<=1
end
function LuxChampion:CastQAt(position,validate)
	if not IsReady(_Q)or not point(position)then return false end
	local distance=flat(position,myHero.pos)
	if distance<1 or distance>self.QSpell.Range or not self:QPointClear(position)then return false end
	local cast=self:ScreenPoint(position,distance);if not cast then return false end
	local accepted=Core:Cast(HK_Q,cast,{range=self.QSpell.Range,prevalidateWorldCast=true,
		resolve=function()
			if not self:QPointClear(position)then return nil,'collision'end
			return {position=cast}
		end,
		validate=function()
			if validate then return validate()end
			return true
		end})
	if accepted then Core:AfterCast(HK_Q,function()self.qObservedAt=Game.Timer()end)end
	return accepted
end

function LuxChampion:CastR(target,hc,validate)
	if not IsValid(target)or not IsReady(_R)then return false end
	return self:CastLine(HK_R,self.RSpell,target,hc,validate)
end

-- Number of enemy champions whose predicted R positions lie on the beam aimed
-- at predicted. Bounded to ten heroes and one prediction each.
function LuxChampion:RHits(predicted)
	local origin=myHero.pos;local distance=flat(predicted,origin)
	if distance<1 then return 0 end
	local dx,dz=(predicted.x-origin.x)/distance,(predicted.z-origin.z)/distance
	local heroes=Core:DecisionUnits('GetEnemyHeroes');local prediction=Core:Prediction(self.RSpell);local count=0
	for i=1,math.min(#heroes,10)do
		local hero=heroes[i]
		if IsValid(hero)and flat(hero.pos,origin)<=self.RSpell.Range+200 then
			prediction:GetPrediction(hero,myHero)
			local at=prediction:CanHit(2)and prediction.UnitPosition
			if point(at)and rayDistance(at,origin,dx,dz,self.RSpell.Range)<=self.RSpell.Radius+(hero.boundingRadius or 0)*.5 then count=count+1 end
		end
	end
	return count
end

-- The beam through the most enemies: candidate aims are each enemy's predicted R position and
-- the midpoints of pairs (Core:BestAim, nearest enemies first so a tie keeps the nearest line).
function LuxChampion:BestRLine()
	local heroes=Core:DecisionUnits('GetEnemyHeroes');local prediction=Core:Prediction(self.RSpell);local points={}
	for i=1,math.min(#heroes,10)do
		local hero=heroes[i]
		if IsValid(hero)and flat(hero.pos,myHero.pos)<=self.RSpell.Range+200 then
			prediction:GetPrediction(hero,myHero)
			local at=prediction:CanHit(2)and prediction.UnitPosition
			if point(at)and flat(at,myHero.pos)<=self.RSpell.Range then
				points[#points+1]={x=at.x,z=at.z,y=at.y or 0,radius=(hero.boundingRadius or 0)*.5,d=flat(at,myHero.pos)}
			end
		end
	end
	if #points==0 then return nil,0 end
	table.sort(points,function(a,b)return a.d<b.d end)
	local aim,weight=Core:BestAim(points,{kind='line',width=self.RSpell.Radius*2,range=self.RSpell.Range})
	return aim and Vector(aim.x,aim.y or 0,aim.z)or nil,weight or 0
end

-- Lux stands still for the whole 1 s cast: a non-lethal R is refused while a visible enemy
-- who can still act could reach her during it (movement over the cast plus attack range).
function LuxChampion:RSafe()
	local heroes=Core:DecisionUnits('GetEnemyHeroes');local delay=self.profile.rDelay
	for i=1,math.min(#heroes,10)do
		local hero=heroes[i]
		if IsValid(hero)and GetHardCCDuration(hero)<delay then
			local reach=(hero.ms or 0)*delay+(hero.range or 0)+(hero.boundingRadius or 0)+(myHero.boundingRadius or 0)+100
			if flat(hero.pos,myHero.pos)<=reach then return false end
		end
	end
	return true
end

-- E zone lifecycle ------------------------------------------------------------

-- The zone is recorded only from this hero's own observed E cast geometry.
-- A queued or sent request is never treated as a placed zone.
function LuxChampion:TrackE()
	local p=self.profile;local cast=myHero.activeSpell
	if cast and cast.valid and cast.name==p.eCast and finite(cast.startTime)and cast.startTime~=self.eSeen and point(cast.placementPos)then
		self.eSeen=cast.startTime
		local origin=point(cast.startPos)and Vector(cast.startPos)or Vector(myHero.pos)
		local center=Vector(cast.placementPos);local distance=flat(origin,center)
		if distance>p.eRange then center=origin:Extended(center,p.eRange);distance=p.eRange end
		local launch=finite(cast.castEndTime)and cast.castEndTime>=cast.startTime and cast.castEndTime or cast.startTime+p.eDelay
		local land=launch+distance/p.eSpeed
		self.eZone={center=center,startTime=cast.startTime,landAt=land,expires=land+p.eZone}
		if Core.logger then Core:Trace('lux_e_zone',{x=center.x,z=center.z,start=cast.startTime,landAt=land},250)end
	end
	local zone=self.eZone
	if zone then
		local armed=self:EArmed()
		if armed then zone.armed=true end
		if Game.Timer()>zone.expires+.5 or zone.armed and not armed then self.eZone=nil end
	end
end

function LuxChampion:InZone(zone,unit)
	if not zone or not IsValid(unit)then return false end
	-- Margin for target motion during recast latency; live hits reached 329 units.
	local slack=math.max(0,unit.ms or 0)*.1
	return flat(unit.pos,zone.center)<=self.profile.eRadius-slack
end

-- Where `unit` will be `t` seconds from now along its current path (no prediction call).
local function along(unit,t)
	local path=unit.pathing
	if path and path.hasMovePath and point(path.endPos)and finite(unit.ms)and unit.ms>0 then
		local d=flat(unit.pos,path.endPos)
		if d>1 then return Vector(unit.pos):Extended(Vector(path.endPos),math.min(d,unit.ms*t))end
	end
	return Vector(unit.pos)
end

-- Holding the slow (Misc.EHold, Combo/Harass): pop now when the enemy dashes, blinks, is about to
-- step out (position latency + .1 s ahead outside radius - its size), or the zone is ending; keep
-- it while a follow-up (an ally melee, our Q or R) still profits from the slow.
function LuxChampion:HoldSlow(zone,hero)
	if not Menu.Misc.EHold:Value()then return false end
	local mode=GetMode();if mode~='Combo'and mode~='Harass'then return false end
	if zone.expires-Game.Timer()<.3 or hero.pathing and hero.pathing.isDashing or self:BlinkArrived(hero)then return false end
	local ahead=along(hero,latency()+.1)
	if flat(ahead,zone.center)>self.profile.eRadius-(hero.boundingRadius or 0)then return false end
	local follow=IsReady(_Q)and flat(hero.pos,myHero.pos)<=self.QSpell.Range or IsReady(_R)and flat(hero.pos,myHero.pos)<=self.RSpell.Range
	if not follow then
		local allies=Core:DecisionUnits('GetAllyHeroes')
		for i=1,math.min(#allies,6)do
			local ally=allies[i]
			if ally~=myHero and IsValid(ally)and(ally.range or 999)<300 and flat(ally.pos,hero.pos)<=400 then follow=true;break end
		end
	end
	return follow
end

function LuxChampion:DetonateReason(zone)
	if not zone or not zone.armed or Game.Timer()<zone.landAt or not self:EArmed()then return nil end
	local auto=Menu.Misc.EDetonate:Value()
	local mode=GetMode()
	local heroes=Core:DecisionUnits('GetEnemyHeroes');local inside,held=0,0
	for i=1,math.min(#heroes,10)do
		local hero=heroes[i]
		if self:InZone(zone,hero)then
			inside=inside+1
			if self:Lethal(hero,self:EDamage(hero)+self:MarkPop(hero,0),0)then return 'lethal'end
			if self:HoldSlow(zone,hero)then held=held+1 end
		end
	end
	-- Flee keeps the slow zone; only a kill detonates it there.
	if inside>0 and auto and mode~='Flee'then
		if held<inside then return 'champion'end
		if Core.logger then Core:Trace('lux_e_hold',{inside=inside},250)end
	end
	if mode=='LaneClear'and self:FarmAllowed()then
		local need=Menu.Clear.E:Value();local count,monster=0,false
		local minions=Core:DecisionUnits('GetEnemyMinions')
		for i=1,math.min(#minions,32)do
			local unit=minions[i]
			if self:InZone(zone,unit)then count=count+1;if unit.team==300 then monster=true end end
		end
		if monster and Menu.Clear.JungleE:Value()or need>0 and count>=need then return 'farm'end
	elseif mode=='LastHit'and Menu.Clear.Enabled:Value()and Menu.LastHit.Q:Value()then
		local minions=Core:DecisionUnits('GetEnemyMinions')
		for i=1,math.min(#minions,32)do
			local unit=minions[i]
			if unit.team~=300 and self:InZone(zone,unit)and Core:Lethal(unit,0,self:EDamage(unit))then return 'lasthit'end
		end
	end
	return nil
end

function LuxChampion:DetonateE()
	local zone=self.eZone
	if self:CastingR()and not self.profile.eDuringR then return false end
	-- One detonation input per armed stage: a sent or uncertain recast is never replayed.
	local prior=Core.pending[HK_E]
	if prior and prior.owner=='DetonateE'and(prior.sentAt or prior.ambiguous)then return false end
	local reason=self:DetonateReason(zone)
	if not reason then return false end
	local accepted=Core:Cast(HK_E,nil,{ttl=200,validate=function()
		if self.eZone~=zone then return false,'zone_changed'end
		return self:DetonateReason(zone)~=nil,'detonation_reason_ended'
	end})
	if accepted and Core.logger then Core:Trace('lux_e_detonate',{reason=reason,x=zone.center.x,z=zone.center.z,hold=Menu.Misc.EHold:Value()},250)end
	return accepted
end

-- Prismatic Barrier ------------------------------------------------------------

-- What is about to hit the unit comes from the shared evidence (Core:AllyThreat):
-- a champion's attack, a targeted cast, a turret, or a tracked skillshot the
-- unit stands in (Evade's model). A cast, a turret shot or a skillshot is always
-- worth the shield. Basic attacks are constant in lane, so they only count once
-- the unit has lost a fifth of its health: the barrier is not spent on every poke.
-- Hard crowd control already on the unit with an enemy champion within 1000 is a
-- threat too: the follow-up damage is coming and the unit cannot walk away.
-- An enemy's damage over time (Ignite, poison, burn; Core:AllyThreat kind 'dot',
-- only when nothing else is coming) counts like a basic attack once the unit has
-- lost a fifth of its health, or at any health when its known remaining damage is
-- a tenth of the unit's current health (Lux-10).
local THREAT_HORIZON,ATTACK_HEALTH,CC_RANGE,DOT_SHARE=1.25,.8,1000,.1
function LuxChampion:EnemyNear(unit,range)
	local heroes=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#heroes,10)do if IsValid(heroes[i])and flat(heroes[i].pos,unit.pos)<=range then return true end end
	return false
end
function LuxChampion:Threat(unit)
	local threat=Core:AllyThreat(unit,THREAT_HORIZON,{dots=true})
	if threat and not self:ThreatWorth(unit,threat)then threat=nil end
	if not threat and IsHardCC(unit)and self:EnemyNear(unit,CC_RANGE)then
		threat={kind='cc',impactIn=0,valid=function()return IsValid(unit)and IsHardCC(unit)and self:EnemyNear(unit,CC_RANGE)end}
	end
	return threat
end

function LuxChampion:ThreatWorth(unit,threat)
	local hurt=unit.health<=unit.maxHealth*ATTACK_HEALTH
	if threat.kind=='attack'then return hurt end
	if threat.kind=='dot'then return hurt or finite(threat.damage)and threat.damage>=unit.health*DOT_SHARE end
	return true
end

function LuxChampion:ThreatValid(unit,threat)
	if not IsValid(unit)or not threat.valid()then return false end
	return self:ThreatWorth(unit,threat)
end

function LuxChampion:ShieldAllowed(unit)
	if not IsValid(unit)or unit.maxHealth<=0 then return false end
	if unit.networkID==myHero.networkID then return true end
	local option=Menu.Shield.Allies[unit.charName]
	return option~=nil and option:Value()and GetDistance(unit.pos,myHero.pos)<=self.WSpell.Range
end

function LuxChampion:ShieldAmount()
	local p=self.profile;local data=myHero:GetSpellData(_W);local base=data and p.wBase[data.level or 0]
	return base and finite(myHero.ap)and base+p.wAP*myHero.ap or 0
end

-- Evade may use the barrier on Lux herself; it judges the danger, so there is no switch.
function LuxChampion:RegisterShieldDefense()
	if not Core.RegisterShield then return end
	local p=self.profile
	self.defenseRegistered,self.defenseReason,self.shieldDefense=Core:RegisterShield({name='LuxW',slot=_W,key=HK_W,profile=p.id,spell=p.wCast,
		source=p.wSource,duration=p.wDuration,start=p.wDelay,amount=function()return self:ShieldAmount()end,
		ready=function()return not self:CastingR()end,kind='world',
		target=function()return Vector(myHero.pos):Extended(Vector(myHero.pos)+myHero.dir,300)end})
end

-- Where the wand meets an ally: its position after the cast and the flight to it.
function LuxChampion:AllyPredicted(unit)
	local p=self.profile
	return along(unit,p.wDelay+flat(unit.pos,myHero.pos)/p.wSpeed)
end

-- Threatened allies whose predicted positions the wand passes (out and back cover the same line).
function LuxChampion:WLineCount(aim,rows)
	local origin=myHero.pos;local distance=flat(aim,origin)
	if distance<1 then return 0 end
	local dx,dz=(aim.x-origin.x)/distance,(aim.z-origin.z)/distance;local count=0
	for _,row in ipairs(rows)do
		if row.unit~=myHero and rayDistance(row.at,origin,dx,dz,self.WSpell.Range)<=self.WSpell.Radius+(row.unit.boundingRadius or 0)*.5 then count=count+1 end
	end
	return count
end

function LuxChampion:WAim(unit,threat)
	if unit.networkID~=myHero.networkID then return self:AllyPredicted(unit)end
	-- The self shield starts with the cast; aim a short throw toward the threat.
	local source=threat and threat.source
	local toward=IsValid(source)and source.pos or myHero.pos:Extended(myHero.pos+myHero.dir,300)
	if flat(toward,myHero.pos)<1 then return nil end
	return Vector(myHero.pos):Extended(Vector(toward),300)
end

function LuxChampion:AutoW()
	if not IsReady(_W)then return false end
	local allies=Core:DecisionUnits('GetAllyHeroes')
	local rows={}
	local function consider(unit)
		if not self:ShieldAllowed(unit)then return end
		local threat=self:Threat(unit)
		if threat then rows[#rows+1]={unit=unit,threat=threat,score=unit.health/math.max(1,unit.maxHealth)}end
	end
	consider(myHero)
	for i=1,math.min(#allies,6)do if allies[i]~=myHero and allies[i].networkID~=myHero.networkID then consider(allies[i])end end
	if #rows==0 then return false end
	-- One barrier. Lux is always shielded by her own cast, so the line is chosen among the
	-- threatened allies (at most four aims): the most threatened allies on the line, then the
	-- lowest health. Without a threatened ally, the threatened Lux throws toward her threat.
	local best,bestCount
	for _,row in ipairs(rows)do
		if row.unit~=myHero then
			row.at=self:AllyPredicted(row.unit)
		end
	end
	local tried=0
	for _,row in ipairs(rows)do
		if row.unit~=myHero and tried<4 then
			tried=tried+1
			local count=self:WLineCount(row.at,rows)
			if not best or count>bestCount or count==bestCount and row.score<best.score then best,bestCount=row,count end
		end
	end
	if not best then best=rows[1]end
	return self:CastW(best.unit,best.threat)
end

function LuxChampion:CastW(unit,threat)
	local aim=self:WAim(unit,threat);if not aim or not aim:To2D().onScreen then return false end
	local id=unit.networkID
	return Core:Cast(HK_W,aim,{range=self.WSpell.Range,
		resolve=function()
			if not IsValid(unit)or unit.networkID~=id then return nil,'intent_ended'end
			local fresh=self:WAim(unit,threat)
			if not fresh or not fresh:To2D().onScreen then return nil,'aim_off_screen'end
			return {position=fresh,data={targetID=id}}
		end,
		validate=function()
			if not threat then return IsValid(unit)end
			return self:ShieldAllowed(unit)and self:ThreatValid(unit,threat),'threat_ended'
		end})
end

-- Background automation ---------------------------------------------------------

function LuxChampion:KillSteal()
	local useQ=IsReady(_Q)
	local useE=self:ECastReady()
	local useR=Menu.KillSteal.R:Value()and IsReady(_R)
	if not useQ and not useE and not useR then return false end
	local heroes=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#heroes,10)do
		local target=heroes[i]
		if IsValid(target)then
			local distance=GetDistance(target.pos,myHero.pos)
			if useQ and distance<=self.QSpell.Range and self:Lethal(target,self:QDamage(target),.25)then
				-- Pass-through is used only when the second-target damage still kills.
				local pass=self:Lethal(target,self:QDamage(target,true),.25)
				if self:CastQ(target,2,pass,function(data)
					return self:Lethal(target,self:QDamage(target,data.second),.25),'kill_threshold_changed'
				end)then return true end
			end
			if useE and distance<=self.ESpell.Range+self.profile.eRadius*.5 and self:Lethal(target,self:EDamage(target),1)
				and self:CastE(target,2,function()return self:Lethal(target,self:EDamage(target),1),'kill_threshold_changed'end)then return true end
			if useR and distance<=self.RSpell.Range and self:Lethal(target,self:RKillDamage(target),self.profile.rDelay)
				and self:CastR(target,R_HIT,function()
					return Menu.KillSteal.R:Value()and self:Lethal(target,self:RKillDamage(target),self.profile.rDelay),'kill_threshold_changed'
				end)then return true end
		end
	end
	return false
end

-- Q, then R once the root is observed, when only both together (with the mark Q leaves) kill.
-- R is kept for the chain while it waits; it goes only on an observed root that outlasts R's cast,
-- never on the Q send alone, and a Q that roots nothing ends the chain.
function LuxChampion:ChainDamage(target,second)
	return self:QDamage(target,second)+self:RDamage(target)+self:PassiveDamage(target)
end
function LuxChampion:ChainQR()
	local p=self.profile;local chain=self.chain;local now=Game.Timer()
	if chain then
		local t=chain.target
		if now>chain.expires or not IsValid(t)or t.networkID~=chain.id or not IsReady(_R)or not Menu.KillSteal.R:Value()then
			if Core.logger then Core:Trace('lux_chain_end',{reason=now>chain.expires and'no_root'or'state'},250)end
			chain.cancelled=true;self.chain=nil;return false
		end
		if self.qObservedAt>=chain.at and IsHardCC(t)and GetHardCCDuration(t)>=p.rDelay then
			if self:CastR(t,2,function()
				return not chain.cancelled and Menu.KillSteal.R:Value()and IsHardCC(t)and GetHardCCDuration(t)>=p.rDelay-.1
					and self:Lethal(t,self:RKillDamage(t),p.rDelay),'chain_ended'
			end)then self.chain=nil;return true end
		end
		return false
	end
	if not Menu.KillSteal.R:Value()or not IsReady(_Q)or not IsReady(_R)or not Core:Affordable(_Q,{_R},3)then return false end
	local heroes=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#heroes,10)do
		local target=heroes[i]
		if IsValid(target)and GetDistance(target.pos,myHero.pos)<=self.QSpell.Range then
			local qImpact=self:QImpact(target.pos)
			if self:Lethal(target,self:ChainDamage(target),qImpact+p.rDelay)and not self:Lethal(target,self:QDamage(target),qImpact)
				and not self:Lethal(target,self:RKillDamage(target),p.rDelay)then
				local pass=p.qSecond>=1
				local started=now
				if self:CastQ(target,Q_HIT,pass,function(data)
					return Menu.KillSteal.R:Value()and IsReady(_R)and self:Lethal(target,self:ChainDamage(target,data.second),self:QImpact(target.pos)+p.rDelay),'kill_threshold_changed'
				end)then
					self.chain={target=target,id=target.networkID,at=started,expires=now+qImpact+.6}
					return true
				end
			end
		end
	end
	return false
end

-- Enemies who cannot move, are channelling, or are about to appear (stasis, revive, teleport),
-- from the shared scan; blinks seen arriving; dashes at Lux. Q lands while a held enemy is still
-- held, or just after an appearing one becomes free.
local ZONE_LATE=.35
-- One shared scan per tick for AutoQ and AutoE; every row re-reads its evidence at dispatch.
function LuxChampion:ZoneRows()
	local now=Game.Timer()
	if self.zoneRowsAt~=now then
		self.zoneRowsAt=now
		self.zoneRows=Core:ZoneTargets({range=math.max(self.QSpell.Range,self.ESpell.Range+self.profile.eRadius*.5)+100,arm=0,lifetime=4})
	end
	return self.zoneRows
end
-- The same evidence row from a fresh scan (dispatch-time re-read of its timing), or nil.
function LuxChampion:FreshRow(row)
	local rows=Core:ZoneTargets({range=math.max(self.QSpell.Range,self.ESpell.Range+self.profile.eRadius*.5)+100,arm=0,lifetime=4})
	for _,r in ipairs(rows)do
		if r.kind==row.kind and(row.unit and r.unit==row.unit or not row.unit and not r.unit and flat(r.position,row.position)<50)then return r end
	end
	return nil
end
local function rowTiming(row,impact)
	local left=row.freeAt-Game.Timer()
	if row.kind=='control'or row.kind=='channel'then return left>=impact end
	return impact>=left and impact<=left+ZONE_LATE
end

function LuxChampion:AutoQ()
	local dash,immobile=Menu.Misc.QAntiDash:Value(),Menu.Misc.QImmobile:Value()
	if not dash and not immobile or not IsReady(_Q)then return false end
	local heroes=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#heroes,10)do
		local target=heroes[i]
		if IsValid(target)and GetDistance(target.pos,myHero.pos)<=self.QSpell.Range+200 then
			if dash and self:DashApproaching(target)and self:CastQ(target,2,true,function()
				return Menu.Misc.QAntiDash:Value()and self:DashApproaching(target),'dash_ended'end)then return true end
			if dash and self:BlinkArrived(target)then
				local valid=function()return Menu.Misc.QAntiDash:Value()and self:BlinkArrived(target),'blink_window_ended'end
				if self:CastQ(target,2,true,valid)then return true end
				-- Prediction often declines right after a position jump; a blinker usually pauses on
				-- the landing spot, so a fast Q (lands within .45 s) goes at that spot instead.
				local b=self.blinks[target.networkID];local landing=Vector(b.x,target.pos.y or 0,b.z)
				if self:QImpact(landing)<=.45 and self:CastQAt(landing,valid)then return true end
			end
			if immobile and IsHardCC(target)and self:CastQ(target,4,true,function()
				return Menu.Misc.QImmobile:Value()and IsHardCC(target),'control_ended'end)then return true end
		end
	end
	if not immobile then return false end
	for _,row in ipairs(self:ZoneRows())do
		if row.kind~='control'and point(row.position)and flat(row.position,myHero.pos)<=self.QSpell.Range then
			local impact=self:QImpact(row.position)
			if rowTiming(row,impact)then
				local valid=function()local fresh=row.valid()and self:FreshRow(row);return Menu.Misc.QImmobile:Value()and fresh~=nil and fresh~=false and rowTiming(fresh,self:QImpact(fresh.position)),'zone_target_ended'end
				if row.kind=='channel'and row.unit then
					if self:CastQ(row.unit,2,true,function()return valid()end)then return true end
				elseif self:CastQAt(row.position,valid)then
					if Core.logger then Core:Trace('lux_zone_q',{kind=row.kind,left=row.freeAt-Game.Timer()},250)end
					return true
				end
			end
		end
	end
	return false
end

-- Lucent Singularity on an enemy who cannot leave it or is about to appear: no mode key.
-- The landed zone is then detonated by the ordinary zone rules.
function LuxChampion:AutoE()
	if not Menu.Misc.EImmobile:Value()or not self:ECastReady()then return false end
	local heroes=Core:DecisionUnits('GetEnemyHeroes');local reach=self.ESpell.Range+self.profile.eRadius*.5
	for i=1,math.min(#heroes,10)do
		local target=heroes[i]
		if IsValid(target)and GetDistance(target.pos,myHero.pos)<=reach and IsHardCC(target)and self:CastE(target,E_HIT,function()
			return Menu.Misc.EImmobile:Value()and IsHardCC(target),'control_ended'end)then return true end
	end
	for _,row in ipairs(self:ZoneRows())do
		if row.kind~='control'and point(row.position)then
			local land=self:ELand(row.position);local left=row.freeAt-Game.Timer()
			-- Held: the zone lands while the enemy is still held. Appearing: the 5 s zone is waiting.
			local fits=(row.kind=='channel')and left>=land or row.kind~='channel'and left<=self.profile.eZone-1
			if fits then
				local valid=function()return Menu.Misc.EImmobile:Value()and row.valid(),'zone_target_ended'end
				if row.kind=='channel'and row.unit then
					if self:CastE(row.unit,E_HIT,valid)then return true end
				elseif self:CastEAt(row.position,valid)then return true end
			end
		end
	end
	return false
end

function LuxChampion:SemiR()
	if not Menu.Misc.RKey:Value()or not IsReady(_R)then return false end
	local mouse=_G.SDK.Input and _G.SDK.Input.PlayerWorld or mousePos
	if not point(mouse)then return false end
	local heroes=Core:DecisionUnits('GetEnemyHeroes');local best,bestDistance
	for i=1,math.min(#heroes,10)do
		local target=heroes[i]
		if IsValid(target)and GetDistance(target.pos,myHero.pos)<=self.RSpell.Range then
			local d=flat(target.pos,mouse)
			if not bestDistance or d<bestDistance then best,bestDistance=target,d end
		end
	end
	return best~=nil and self:CastR(best,2)
end

-- Illumination weave: with our mark on an enemy champion in attack range, the next attack goes
-- to that champion (it pops the mark) in Combo and Harass, or in any mode when that attack and
-- the pop kill. A preference only: the orbwalker still decides when to attack.
function LuxChampion:WeaveMark()
	local mode=GetMode();local heroes=Core:DecisionUnits('GetEnemyHeroes');local best,bestEnds,bestKill
	for i=1,math.min(#heroes,10)do
		local hero=heroes[i]
		if IsValid(hero)and _G.SDK.Data:IsInAutoAttackRange(myHero,hero)then
			local _,ends=self:Mark(hero)
			if ends then
				local kill=Core:Lethal(hero,.25,_G.SDK.Damage:GetAutoAttackDamage(myHero,hero)+self:PassiveDamage(hero),{kind='magical',attack=true})==true
				if(kill or mode=='Combo'or mode=='Harass')and(not best or kill and not bestKill or kill==bestKill and hero.health<best.health)then
					best,bestEnds,bestKill=hero,ends,kill
				end
			end
		end
	end
	if not best then Core:ReleaseAttackPreference('LuxPassive');return false end
	return Core:PreferAttack('LuxPassive',best,math.min(1,bestEnds-Game.Timer()))
end

-- Modes -------------------------------------------------------------------------

function LuxChampion:PreferImmobile(target,range)
	if IsValid(_G.SDK.TargetSelector.Selected)then return target end
	if IsValid(target)and IsHardCC(target)then return target end
	local heroes=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#heroes,10)do
		local hero=heroes[i]
		if IsValid(hero)and GetDistance(hero.pos,myHero.pos)<=range and IsHardCC(hero)then return hero end
	end
	return target
end

function LuxChampion:Combo()
	local qReady=Menu.Combo.Q:Value()and IsReady(_Q)
	local eReady=Menu.Combo.E:Value()and self:ECastReady()
	local rReady=Menu.Combo.R:Value()and(Menu.Combo.RLethal:Value()or Menu.Combo.RCount:Value()>0)and IsReady(_R)
	if not qReady and not eReady and not rReady then return end
	if qReady then
		local target=GetTarget(self.QSpell.Range)
		if IsValid(target)and self:CastQ(target,Q_HIT,true)then return end -- fixed: without a clean line Q may pass one unit
	end
	if eReady then
		local reach=self.ESpell.Range+self.profile.eRadius*.5
		local target=self:PreferImmobile(GetTarget(reach),reach)
		-- Give an outgoing Light Binding time to root before spending E.
		if IsValid(target)and(not self:QInFlight()or IsHardCC(target))and self:CastE(target,E_HIT)then return end
	end
	if rReady then self:ComboR()end
end

-- R burst on one target: R, the mark already on it, and an armed zone it cannot walk out of.
-- On an enemy held for at least R's cast the beam is certain: a ready Combo E (cast now,
-- detonated after landing) is counted when it lands and pops before the hold ends, and R also
-- goes when it leaves the enemy within one basic attack of death and Lux can attack it.
function LuxChampion:RBurst(target)
	local p=self.profile;local damage=self:RKillDamage(target)
	local held=GetHardCCDuration(target)
	if self:EArmed()and self.eZone and IsHardCC(target)and self:InZone(self.eZone,target)then damage=damage+self:EDamage(target)
	elseif held>=p.rDelay and Menu.Combo.E:Value()and self:ECastReady()and Core:Affordable(_E,{_R},0)
		and flat(target.pos,myHero.pos)<=self.ESpell.Range and self:ELand(target.pos)+.25<=held then damage=damage+self:EDamage(target)end
	return damage
end
function LuxChampion:RBurstLethal(target)
	local p=self.profile
	if self:Lethal(target,self:RBurst(target),p.rDelay)then return true end
	if GetHardCCDuration(target)>=p.rDelay and _G.SDK.Data:IsInAutoAttackRange(myHero,target)then
		return self:Lethal(target,self:RKillDamage(target)+_G.SDK.Damage:GetAutoAttackDamage(myHero,target),p.rDelay+.3)
	end
	return false
end

function LuxChampion:ComboR()
	local heroes=Core:DecisionUnits('GetEnemyHeroes');local p=self.profile
	if self.chain then return false end -- R is kept for the Q-then-R kill
	if Menu.Combo.RLethal:Value()then
		for i=1,math.min(#heroes,10)do
			local target=heroes[i]
			if IsValid(target)and GetDistance(target.pos,myHero.pos)<=self.RSpell.Range and self:RBurstLethal(target)then
				-- A target held through the cast cannot leave the beam: normal hit chance is enough.
				local hc=GetHardCCDuration(target)>=p.rDelay and 2 or R_HIT
				if self:CastR(target,hc,function()return Menu.Combo.RLethal:Value()and self:RBurstLethal(target),'kill_threshold_changed'end)then return true end
			end
		end
	end
	local need=Menu.Combo.RCount:Value()
	if need<=0 then return false end
	local nearby=0
	for i=1,math.min(#heroes,10)do if IsValid(heroes[i])and GetDistance(heroes[i].pos,myHero.pos)<=self.RSpell.Range then nearby=nearby+1 end end
	if nearby<need or not self:RSafe()then return false end
	local aim=self:BestRLine()
	if not aim or self:RHits(aim)<need then return false end
	return self:CastRLine(aim,need)
end

-- R along a chosen line: the resolver re-chooses the best line, the validator recounts it.
function LuxChampion:CastRLine(aim,need)
	local cast=self:ScreenPoint(aim);if not cast then return false end
	return Core:Cast(HK_R,cast,{range=self.RSpell.Range,prevalidateWorldCast=true,
		resolve=function()
			local fresh=self:BestRLine()
			if not fresh then return nil,'no_line'end
			local point=self:ScreenPoint(fresh);if not point then return nil,'aim_off_screen'end
			return {position=point,data={aim=fresh}}
		end,
		validate=function(q,resolved)
			local line=resolved and resolved.data and resolved.data.aim or aim
			local wanted=Menu.Combo.RCount:Value()
			if wanted<=0 then return false,'count_disabled'end
			if not self:RSafe()then return false,'enemy_in_reach'end
			return self:RHits(line)>=wanted,'hit_count_changed'
		end})
end

function LuxChampion:Harass()
	if not manaAbove(Menu.Harass.Mana:Value())then return end
	local qReady=Menu.Harass.Q:Value()and IsReady(_Q)
	local eReady=Menu.Harass.E:Value()and self:ECastReady()
	if not qReady and not eReady then return end
	if qReady then
		local target=GetTarget(self.QSpell.Range)
		if IsValid(target)and self:CastQ(target,Q_HIT,true)then return end
	end
	if eReady then
		local reach=self.ESpell.Range+self.profile.eRadius*.5
		local target=self:PreferImmobile(GetTarget(reach),reach)
		if IsValid(target)and(not self:QInFlight()or IsHardCC(target))then self:CastE(target,E_HIT)end
	end
end

function LuxChampion:FarmAllowed()
	return Menu.Clear.Enabled:Value()and manaAbove(Menu.Clear.Mana:Value())
end

-- Predicted lane minion landing positions, bounded to 24.
function LuxChampion:FarmSamples()
	local samples={};local minions=Core:DecisionUnits('GetEnemyMinions');local prediction
	local reach=self.ESpell.Range+self.profile.eRadius
	for i=1,math.min(#minions,32)do
		if #samples>=24 then break end
		local unit=minions[i]
		if IsValid(unit)and unit.team~=300 and GetDistance(unit.pos,myHero.pos)<=reach then
			local path=unit.pathing
			if path and path.hasMovePath==false and not path.isDashing then samples[#samples+1]=Vector(unit.pos)
			else
				prediction=prediction or Core:Prediction(self.ESpell)
				prediction:GetPrediction(unit,myHero)
				if prediction:CanHit(2)and point(prediction.CastPosition)then samples[#samples+1]=Vector(prediction.CastPosition)end
			end
		end
	end
	return samples
end

function LuxChampion:CircleCount(center,samples)
	local count,radius=0,self.profile.eRadius-40
	for _,p in ipairs(samples)do if flat(p,center)<=radius then count=count+1 end end
	return count
end

function LuxChampion:LaneE()
	local need=Menu.Clear.E:Value()
	if need<=0 or not self:ECastReady()then return false end
	local samples=self:FarmSamples();local best,bestCount
	if #samples<need then return false end
	for _,candidate in ipairs(samples)do
		if flat(candidate,myHero.pos)<=self.ESpell.Range then
			local count=self:CircleCount(candidate,samples)
			if not bestCount or count>bestCount then best,bestCount=candidate,count end
		end
	end
	if not best or bestCount<need or not best:To2D().onScreen then return false end
	local center=best
	return Core:Cast(HK_E,center,{range=self.ESpell.Range,prevalidateWorldCast=true,
		resolve=function()
			if self:CircleCount(center,self:FarmSamples())<Menu.Clear.E:Value()then return nil,'farm_count_changed'end
			return {position=center}
		end,
		validate=function(q,resolved)
			if self:EArmed()then return false,'e_already_armed'end
			if not self:FarmAllowed()or IsUnderTurret(myHero)then return false,'farm_policy'end
			if not resolved then return self:CircleCount(center,self:FarmSamples())>=Menu.Clear.E:Value(),'farm_count_changed'end
			return true
		end})
end

function LuxChampion:Clear()
	if not self:FarmAllowed()then return end
	local qReady,eReady=IsReady(_Q),self:ECastReady()
	if not qReady and not eReady then return end
	if eReady and not IsUnderTurret(myHero)and self:LaneE()then return end
	local jungleQ,jungleE=Menu.Clear.JungleQ:Value()and qReady,Menu.Clear.JungleE:Value()and eReady
	if not jungleQ and not jungleE then return end
	local target
	for _,monster in ipairs(Core:DecisionUnits('GetMonsters'))do
		if IsValid(monster)and monster.pos2D.onScreen and GetDistance(monster.pos,myHero.pos)<=self.QSpell.Range
			and(not target or monster.maxHealth>target.maxHealth)then target=monster end
	end
	if not target then return end
	if jungleE and GetDistance(target.pos,myHero.pos)<=self.ESpell.Range
		and self:CastE(target,2,function()return self:FarmAllowed()and Menu.Clear.JungleE:Value(),'farm_policy'end)then return end
	if jungleQ then self:CastQ(target,2,true,function()return self:FarmAllowed()and Menu.Clear.JungleQ:Value(),'farm_policy'end)end
end

function LuxChampion:LastHitAllowed()
	return Menu.LastHit.Q:Value()and manaAbove(Menu.LastHit.Mana:Value())and not _G.SDK.Attack:IsActive()
end

-- Q only rescues a minion it kills on its own that a ready attack cannot secure.
function LuxChampion:CanRescue(target,predicted)
	if not self:LastHitAllowed()then return false end
	if not IsValid(target)or target.team==300 or target.type~=Obj_AI_Minion or not IsReady(_Q)then return false end
	local reach=GetDistance(predicted or target.pos,myHero.pos)
	if reach>self.QSpell.Range then return false end
	-- The shared LastHit rule. 'ready' is the variant this champion's regressions pin: only an
	-- attack that is ready and in range right now keeps the spell.
	return Core:Rescue(target,self.QSpell.Delay+reach/self.QSpell.Speed,function()return self:QDamage(target)end,readyAttack)
end

-- E rescue: the zone lands, then the recast pops it .25 s later.
function LuxChampion:CanRescueE(target)
	if not self:LastHitAllowed()then return false end
	if not IsValid(target)or target.team==300 or target.type~=Obj_AI_Minion or not self:ECastReady()then return false end
	if flat(target.pos,myHero.pos)>self.ESpell.Range+self.profile.eRadius-60 then return false end
	return Core:Rescue(target,self:ELand(target.pos)+.25,function()return self:EDamage(target)end,readyAttack)
end

-- A second rescue on the same Q ray behind `near` (Normal Q roots and fully damages two units).
local function behind(a,b,width)
	local origin=myHero.pos;local distance=flat(b,origin)
	if distance<1 or flat(a,origin)>=distance then return false end
	local dx,dz=(b.x-origin.x)/distance,(b.z-origin.z)/distance
	return rayDistance(a,origin,dx,dz,distance)<=width
end

function LuxChampion:LastHit()
	if not Menu.LastHit.Q:Value()then return end
	local minions=Core:DecisionUnits('GetEnemyMinions');local rescues={}
	if IsReady(_Q)then
		for i=1,math.min(#minions,32)do
			local target=minions[i]
			if self:CanRescue(target)then rescues[#rescues+1]=target end
		end
	end
	-- Normal: two rescues on one line go to the farther one through the nearer (full damage to both).
	if #rescues>=2 and self.profile.qSecond>=1 then
		for i=1,math.min(#rescues,6)do for j=1,math.min(#rescues,6)do
			local near,far=rescues[i],rescues[j]
			if near~=far and behind(near.pos,far.pos,self.QSpell.Radius+(near.boundingRadius or 0))then
				if self:CastQ(far,2,true,function(data)return self:CanRescue(far,data.predicted)and self:CanRescue(near),'rescue_ended'end)then return end
			end
		end end
	end
	local best
	for _,target in ipairs(rescues)do if not best or target.maxHealth>best.maxHealth then best=target end end
	if best then
		local target=best
		if self:CastQ(target,2,false,function(data)return self:CanRescue(target,data.predicted),'rescue_ended'end)then return end
	end
	self:LastHitE(minions)
end

-- E only when it rescues at least two minions an attack cannot take; the landed zone is
-- detonated at once by DetonateReason ('lasthit').
function LuxChampion:LastHitE(minions)
	if not self:ECastReady()or not self:LastHitAllowed()then return false end
	local points={}
	for i=1,math.min(#minions,32)do
		local unit=minions[i]
		if #points<12 and self:CanRescueE(unit)then points[#points+1]={x=unit.pos.x,y=unit.pos.y or 0,z=unit.pos.z,unit=unit}end
	end
	if #points<2 then return false end
	local aim,weight=Core:BestAim(points,{kind='circle',radius=self.profile.eRadius-40,range=self.ESpell.Range})
	if not aim or (weight or 0)<2 then return false end
	local center=Vector(aim.x,aim.y or 0,aim.z)
	local function count()
		local n=0
		for _,row in ipairs(points)do if flat(row.unit.pos,center)<=self.profile.eRadius-40 and self:CanRescueE(row.unit)then n=n+1 end end
		return n
	end
	return self:CastEAt(center,function()return count()>=2,'rescue_ended'end)
end

function LuxChampion:Flee()
	local heroes=Core:DecisionUnits('GetEnemyHeroes');local nearest,nearestDistance
	for i=1,math.min(#heroes,10)do
		local hero=heroes[i]
		if IsValid(hero)then
			local d=GetDistance(hero.pos,myHero.pos)
			if not nearestDistance or d<nearestDistance then nearest,nearestDistance=hero,d end
		end
	end
	if not nearest or nearestDistance>self.QSpell.Range+200 then return end
	if Menu.Flee.W:Value()and IsReady(_W)and nearestDistance<=1000 then self:CastW(myHero,nil)end
	if Menu.Flee.Q:Value()and IsReady(_Q)and self:CastQ(nearest,2,true)then return end
	if Menu.Flee.E:Value()and nearestDistance<=self.ESpell.Range then self:CastE(nearest,2)end
end

-- Health-bar damage: what Lux can deliver now.
function LuxChampion:ComboDamage(unit)
	if not IsValid(unit)then return 0 end
	local damage=self:MarkPop(unit,0)+_G.SDK.Damage:GetAutoAttackDamage(myHero,unit)
	if IsReady(_Q)then damage=damage+self:QDamage(unit)end
	if self:ECastReady()or self:EArmed()then damage=damage+self:EDamage(unit)end
	if IsReady(_R)then damage=damage+self:RDamage(unit)end
	return damage
end

-- Guide and drawing -------------------------------------------------------------

function LuxChampion:RegisterGuide(guide,settings)
	local nodes={comboQ={node=Menu.Combo.Q,label='Combo Q'},immobileE={node=Menu.Misc.EImmobile,label='Immobile E'},
		comboE={node=Menu.Combo.E,label='Combo E'},comboR={node=Menu.Combo.R,label='Combo R'},comboLethal={node=Menu.Combo.RLethal,label='Lethal R'},comboCount={node=Menu.Combo.RCount,label='R hit count'},
		harassQ={node=Menu.Harass.Q,label='Harass Q'},harassE={node=Menu.Harass.E,label='Harass E'},
		farm={node=Menu.Clear.Enabled,label='Spell farming'},farmE={node=Menu.Clear.E,label='Minimum E minions'},
		lastHit={node=Menu.LastHit.Q,label='Last Hit Q and E'},hold={node=Menu.Misc.EHold,label='Keep the slow'},
		detonate={node=Menu.Misc.EDetonate,label='Detonate on champions'},antiDash={node=Menu.Misc.QAntiDash,label='Anti-dash Q'},
		immobile={node=Menu.Misc.QImmobile,label='Immobile Q'},ksR={node=Menu.KillSteal.R,label='KillSteal R'}}
	local classic=self.profile.id=='classic'
	local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
	return guide:Register('champion',{'Lux: quick start','Lux: Light Binding and Singularity','Lux: shield and Final Spark'},function(page)
		if page==1 then return {title=classic and 'Classic Lux'or'Lux',subtitle='Use your provider mode keys. '..(classic and 'Classic values are used.'or'Current values are used.'),cards={
			{'COMBO','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..'. [[comboQ]] roots first, [[comboE]] waits for an outgoing Q and prefers rooted targets, then [[comboR]] fires for a lethal burst ([[comboLethal]]) or along the line through the most enemies ([[comboCount]]) when nobody can reach you during the cast.'},
			{'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. [[harassQ]] and [[harassE]] respect the harass mana threshold. Attacks go to an enemy carrying your mark. Releasing a mode cancels its waiting casts.'},
			{'FARM','Enable [[farm]] with '..settings.key(Menu.Clear.Enabled)..'. [[farmE]] counts predicted minions inside one zone. [[lastHit]] only rescues CS your attack cannot secure; E needs two such minions.'}},note='Semi-manual R: hold '..settings.key(Menu.Misc.RKey)..'. Kill finishers, anti-dash Q and shields need no mode key.'}end
		if page==2 then return {title='Light Binding and Lucent Singularity',subtitle='Root first, then the zone.',cards={
			{'Q',(classic and 'Clean lines are preferred. Without one, Q may pass its first unit; the second target takes half damage and a 1 s root, and a third unit refuses the cast.'
				or'Clean lines are preferred. Without one, Q may pass its first unit; both take full damage and the 2 s root, and a third unit refuses the cast.')..' [[antiDash]] and [[immobile]] need no mode key and also cover blinks, channels, stasis and teleport arrivals.'},
			{'E ZONE','The zone is tracked from where your E actually landed. A killable enemy inside always detonates it. [[immobileE]] places it on an enemy who cannot move or is about to appear, without a mode key.'},
			{'DETONATE','E pops the landed zone when an enemy champion is inside; [[hold]] keeps the slow until the enemy is about to leave. A missed zone is not detonated and Flee keeps the slow.'..(classic and ' Classic allows detonation during Final Spark.'or'')}},note='Ranges and radii come from the installed assets; see the provenance file.'}end
		return {title='Prismatic Barrier and Final Spark',subtitle='Shields react to real threats; R rechecks health.',cards={
			{'SHIELD','W reacts to a targeted cast, a turret shot, a tracked skillshot or crowd control on you or an enabled ally, and to basic attacks or an enemy burn or poison once that unit is below 80% health (a burn sooner when it will take a tenth of the health left). The throw follows the most threatened allies. A vanished threat cancels the request. Evade may also use the barrier on you.'},
			{'FINAL SPARK','[[ksR]] rechecks health and shields before the send and counts your mark on the target; it also roots with Q first when only Q and R together kill, and fires R only once the root is seen.'},
			{'LIMITS','Only the remaining damage of Ignite is known; other burns wait for the health limit. The beam width is conservative.'}},note='Flash during R does not move the beam; summoners remain yours.'}
	end,cfg,links,activate)
end

function LuxChampion:Draw()
	if myHero.dead then return end
	if Menu.Draw.Q:Value()and IsReady(_Q)then Draw.Circle(myHero.pos,self.QSpell.Range,1,Draw.Color(255,66,244,113))end
	if Menu.Draw.W:Value()and IsReady(_W)then Draw.Circle(myHero.pos,self.WSpell.Range,1,Draw.Color(255,120,200,255))end
	if Menu.Draw.E:Value()and self:ECastReady()then Draw.Circle(myHero.pos,self.ESpell.Range,1,Draw.Color(255,244,238,66))end
	if Menu.Draw.Zone:Value()and self.eZone then Draw.Circle(self.eZone.center,self.profile.eRadius,1,Draw.Color(200,255,255,160))end
	if Menu.Draw.R:Value()and IsReady(_R)and Draw.CircleMinimap then Draw.CircleMinimap(myHero.pos,self.RSpell.Range,1,Draw.Color(255,244,66,96))end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:RegisterPolicy({
    damageTypes={Q='magical',E='magical',R='magical'},
    methods={
        DetonateE=function()return {priority='interactive'}end,
        AutoW=function()return {priority='interactive'}end,
        AutoQ=function()return {priority='interactive'}end,
        AutoE=function()return {priority='interactive'}end,
        KillSteal=function()return {priority='interactive'}end,
        ChainQR=function()return {priority='interactive'}end,
        SemiR=function()return Core:HeldContext(function()return Menu.Misc.RKey:Value()end)end,

        Combo=function()return Core:ModeContext("Combo")end,
        Harass=function()return Core:ModeContext("Harass")end,
        Clear=function()return Core:ModeContext("LaneClear")end,
        LastHit=function()return Core:ModeContext("LastHit")end,
        Flee=function()return Core:ModeContext("Flee")end,
    },
    -- The detonation recast does not pay Lucent Singularity's cost again.
    costPaid=function(self,q,slot)return slot==_E and q.owner=='DetonateE' and self:EArmed() end,
    exceptions={non_interrupting_summoner=true},
    channel=function(self,q)
        if self:CastingR() then return q~=nil and q.owner=='DetonateE' and self.profile.eDuringR==true end
        return not Core:SelfChanneling()
    end,
    validate=function(self,q,slot,resolved)
        if self:CastingR() and not (slot==_E and q.owner=='DetonateE' and self.profile.eDuringR) then return false,'casting_r' end
        if slot==_E then
            if q.owner=='DetonateE' then
                if not self:EArmed() then return false,'e_not_armed' end
            elseif self:EArmed() then return false,'e_already_armed' end
        end
        return true
    end,
})

LuxChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Lux"]="Lux"}
local normalSupported={["Lux"]=true}

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
