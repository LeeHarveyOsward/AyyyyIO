return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Fiora"]=function()return _G.OrbamaFamily:Require("72ced310d820e8dde5204988f63bddce71134694c79cfe6d09cd47e5a72e594b")()end
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
if champion=="Fiora" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Fiora',profiles={normal=true,classic=true},
 Create=function(context)
-- Explicit profiles; evidence and unresolved mechanics: CombatProfiles/fiora-provenance.json.
local profiles=ChampionProfiles('Fiora')
local finite,id,manaAbove=Core.finite,Core.id,Core.manaAbove
local function ownBuff(b,u)
 local src=b.source;local actor=type(src)=='number'and src or(type(src)=='table'or type(src)=='userdata')and id(src)
 if src~=nil and type(src)~='number'and type(src)~='table'and type(src)~='userdata'then return false end
 if actor and actor~=0 and actor~=u.networkID and actor~=u.handle then return false end
 if b.sourcenID and b.sourcenID~=0 and b.sourcenID~=u.networkID then return false end
 if type(src)=='table'or type(src)=='userdata'then
  if src.networkID and src.networkID~=0 and src.networkID~=u.networkID then return false end
  if src.handle and src.handle~=0 and src.handle~=u.handle then return false end
 end
 return true
end
local function clearOwned(self)
 self.incomingAttacks={};self.attackWitness=nil;self.eAttackObservation=nil;self.rObservation=nil;self.rTarget=nil;self.preview=nil
 self.qLock=nil;self.rSeenAt=nil;self.wq=nil;self.wallPreview=nil
end

if not profiles[myHero.charName] then return end


-- Empowered attacks and targeted casts W answers regardless of health: profile wAttacks
-- (ChampionProfiles/Fiora.lua), one catalogue per profile.

local FioraChampion=class("FioraChampion")

function FioraChampion:__init()
	self.profile=profiles[myHero.charName];self.classic=self.profile.classic
 self.QRange,self.RRange=self.profile.q,self.profile.r
 if not self.classic then
   -- .55 is a conservative planning horizon, not a claimed dash-speed model.
   -- Moving targets need remaining hard CC; vital-specific pursuit is disabled.
   self.QSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=.55,Radius=80,Range=400,Speed=math.huge,Collision=false}
 end
	self.lastCast = -math.huge
	self.lastSpell = {}
	self.incomingAttacks = {}
	self.vitals={}
	self:LoadMenu()
	Core:RegisterCleanup('Fiora',function()clearOwned(self);self.vitals={};self.lastQEnd=nil end)
	self:PublishMobility()
 local ok,why=Core:RegisterPreparation('Fiora.preview',{intervalMs=100,maxDelayMs=350,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Q:Value()or Menu.Draw.R:Value()or Menu.Draw.Vitals and Menu.Draw.Vitals:Value()end,function()self.preview=nil end)
 self.preparationFallback=not ok and why=='unsupported'
 if not self.classic then
  -- Own vitals: a bounded particle scan, prepared outside the decision path.
  -- Only while something reads it: the drawing, a held fight, or the Q finisher.
  ok,why=Core:RegisterPreparation('Fiora.vitals',{intervalMs=100,maxDelayMs=300,units=1,maxUnits=1},function()self:ScanVitals();return true end,
   function()local mode=GetMode();return mode=='Combo'or mode=='Harass'or Menu.KillSteal.Q:Value()end,function()self.vitals={}end)
  self.vitalFallback=not ok and why=='unsupported'
 end
 self.vitalRouteStatus='observed_offset_or_session_learned_mapping'
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
	_G.SDK.Orbwalker:OnPreAttack(function(args)
		if self:RActive() then args.Process = false; return end
	end)
	_G.SDK.Orbwalker:OnPostAttack(function(args) self:OnPostAttack(args) end)
	_G.SDK.Orbwalker:OnPreMovement(function(args)
		if self:RActive() then args.Process = false end
	end)
end

function FioraChampion:LoadMenu()
	Menu = MenuElement({type = MENU, id = "Classic_AIO_" .. myHero.charName, name = "AyyyyIO - Fiora"})
	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.Combo:MenuElement({id = "SafeQ", name = "Never Q under an enemy turret", value = true})
	Menu.Combo:MenuElement({id = "E", name = "Use E after an attack", value = true})
	Menu.Combo:MenuElement({id = "R", name = self.classic and "Use R when it kills a lone enemy" or "Use R to win a duel or a fight", value = true})
	Menu.Combo:MenuElement({id = "RHP", name = self.classic and "Also R below my health % (0 = off)" or "R below my health % (0 = off)", value = 25, min = 0, max = 60, step = 5})
	Menu.Combo:MenuElement({id = "SafeR", name = "Never R under an enemy turret", value = true})
	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.Harass:MenuElement({id = "E", name = "Use E after an attack", value = true})
	Menu.Harass:MenuElement({id = "Mana", name = "Only above mana %", value = 40, min = 0, max = 100, step = 5})
	Menu:MenuElement({type = MENU, id = "Clear", name = "Farming"})
	Menu.Clear:MenuElement({id = "Enabled", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = false, key = 4, callback = function(v) CheckChatBlock(Menu.Clear.Enabled, v) end})
	Menu.Clear:MenuElement({id = "Mana", name = "Only above mana %", value = 30, min = 0, max = 100, step = 5})
	Menu.Clear:MenuElement({id = "LaneQ", name = "Lane: Q minions an attack would miss", value = true})
	Menu.Clear:MenuElement({id = "LaneE", name = "Lane: E after an attack", value = true})
	Menu.Clear:MenuElement({id = "JungleQ", name = "Jungle: use Q", value = true})
	Menu.Clear:MenuElement({id = "JungleW", name = "Jungle: block monster attacks with W", value = true})
	Menu.Clear:MenuElement({id = "JungleE", name = "Jungle: E after an attack", value = true})
	Menu:MenuElement({type=MENU,id="LastHit",name="Last hit"})
 Menu.LastHit:MenuElement({id="Q",name="Use Q on minions an attack would miss",value=true})
 Menu.LastHit:MenuElement({id="Mana",name="Only above mana %",value=40,min=0,max=100,step=5})
 Menu:MenuElement({type = MENU, id = "KillSteal", name = "Finishers"})
	Menu.KillSteal:MenuElement({id = "Q", name = "Q killable enemies without holding a mode key", value = true})
	if self.classic then Menu.KillSteal:MenuElement({id = "R", name = "R killable enemies without holding a mode key", value = true})
	else Menu.KillSteal:MenuElement({id = "W", name = "W killable enemies without holding a mode key", value = true})end
	Menu:MenuElement({type = MENU, id = "Misc", name = "Behaviour"})
	Menu.Misc:MenuElement({id = "AutoW", name = "Block champion attacks with W automatically", value = true})
	Menu.Misc:MenuElement({id = "WNormalHP", name = "W ordinary attacks only below health %", value = self.classic and 70 or 30, min = 0, max = 100, step = 5, menu = false})
	Menu.Misc:MenuElement({id = "FleeQ", name = self.classic and "Flee: Q to an enemy toward the cursor" or "Flee: Q toward the cursor", value = true})
	Menu.Misc:MenuElement({id = "SemiR", name = "Cast R at the selected target", key = string.byte("T")})
	if not self.classic then Menu.Misc:MenuElement({id='SideAssist',name='Q to the cursor side of your R target',key=string.byte('U')})end
	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "Q", name = "Q range", value = false})
	Menu.Draw:MenuElement({id = "R", name = "R range", value = false})
	if not self.classic then Menu.Draw:MenuElement({id = "Vitals", name = "Planned Q landing spot", value = true})end
end


function FioraChampion:ActiveBuff(unit,name)
 if not unit or not finite(unit.buffCount)or unit.buffCount<0 or unit.buffCount>128 or unit.buffCount%1~=0 then return nil end
 local lower=name:lower()
 for i=0,unit.buffCount do local b=unit:GetBuff(i)
  if b then
  local expiry=Core.buffExpiry(b)
  if type(b.name)=='string'and b.name:lower()==lower and finite(b.count)and b.count>0 and b.count%1==0 and finite(expiry)and expiry>Game.Timer()
   and(unit~=myHero or not name:find('Fiora',1,true)or ownBuff(b,myHero))then return b,expiry end
  end
 end
end

function FioraChampion:QRecast()
 return self.classic and self:ActiveBuff(myHero,"Jade_FioraQ_CD")~=nil
end

function FioraChampion:QExpiring()
 local _,expiry=self:ActiveBuff(myHero,"Jade_FioraQ_CD")
 return self.classic and expiry~=nil and expiry-Game.Timer()<=.45
end

function FioraChampion:RActive()
 if not self.classic or myHero.dead then return false end
 local spell=myHero.activeSpell
 local casting=spell and spell.valid and not spell.isStopped and (spell.name=="Jade_FioraR"or spell.name=="Jade_FioraR_Strike")
  and Game.Timer()<math.max(spell.endTime or 0,spell.castEndTime or 0)
 if casting or self:ActiveBuff(myHero,"Jade_FioraR")~=nil or self:ActiveBuff(myHero,"Jade_FioraR_Strike")~=nil then return true end
 -- Fallback when neither buff alias is what the server reports: Fiora is
 -- untargetable for the Waltz, so untargetable within 3 s of an OBSERVED own R
 -- cast is the Waltz. Untargetability alone, or a merely requested R, is not.
 return self.rSeenAt~=nil and Game.Timer()-self.rSeenAt<=3 and Game.Timer()>=self.rSeenAt and myHero.isTargetable==false
end

function FioraChampion:Ready(slot)
	local spell = myHero:GetSpellData(slot)
	-- Q's free second cast can retain the first cast's mana value in spell data.
	return spell and spell.name==self.profile[({'qName','wName','eName','rName'})[slot+1]]and finite(spell.level)and spell.level%1==0
  and spell.level>0 and spell.level<=(slot==_R and 3 or 5)and spell.currentCd==0 and Game.CanUseSpell(slot)==0
  and finite(spell.mana)and spell.mana>=0 and((slot==_Q and self:QRecast())or spell.mana<=myHero.mana)
end

function FioraChampion:Cast(slot, key, target, options)
	local now = Game.Timer()
	if not Core:InputAvailable()or not self:Ready(slot)then return false end
 options=options or {};local nativeName=myHero:GetSpellData(slot).name
 if not options.observe then local victim=target and target.networkID and target
  options.observe=function(q)local cast=Core:NativeCast(q,nativeName)
   return cast and(not victim or cast.target==victim.networkID or cast.target==victim.handle)
  end
 end
	if not Core:Cast(key,target,options) then return false end
 local request=Core.lastIntent
	Core:AfterCast(key,function()
        local observed=Game.Timer();self.lastCast,self.lastSpell[slot]=observed,observed
        -- Accepted input alone never creates an attack/movement lock.
        if self.classic and slot==_R then self.rSeenAt=observed end
        -- An observed Lunge on a champion keeps the second Lunge and the attacks on that enemy.
        if self.classic and slot==_Q and target and target.type==Obj_AI_Hero and target.networkID then
         self.qLock={target=target,identity=target.networkID,handle=target.handle,expires=observed+self.profile.qWindow}
        end
        if slot==_R and not self.classic and target and target.networkID then
         self.rObservation={target=target,identity=target.networkID,handle=target.handle,at=request and request.sentGameTime or observed,expires=observed+8}
        end
    end)
	return true
end

-- Enemy turrets whose range covers `point` (750 + bounding radius, as IsUnderTurret2).
function FioraChampion:Covering(point)
 local out={};if not point then return out end
 for _,t in ipairs(_G.SDK.ObjectManager:GetEnemyTurrets())do
  if t and not t.dead and t.pos and GetDistance(t.pos,point)<(t.boundingRadius or 0)+750 then out[#out+1]=t end
 end;return out
end
-- safe=true: never under an enemy turret. safe='held': a point under only the
-- turret(s) Fiora already stands under is allowed (Q-ing there adds no turret
-- exposure; refusing strands a dive in progress); a new or additional turret is not.
function FioraChampion:TurretSafe(point,safe)
 if not safe then return true end
 if safe~='held'then return not IsUnderTurret2(point)end
 local here=self:Covering(myHero.pos)
 for _,t in ipairs(self:Covering(point))do
  local same=false;for _,h in ipairs(here)do if h==t or GetDistance(h.pos,t.pos)<1 then same=true;break end end
  if not same then return false end
 end;return true
end
function FioraChampion:CanTarget(target, range, safe)
	if not IsValid(target) or not target.pos2D.onScreen or GetDistance(myHero.pos, target.pos) > range then return false end
 if not self:CurrentTarget(target)then return false end
	if target.type == Obj_AI_Hero and (IsInvulnerable(target) or _G.SDK.ObjectManager:IsHeroImmortal(target, false)) then return false end
	return self:TurretSafe(target.pos,safe)
end
function FioraChampion:CurrentTarget(target)
 if not IsValid(target)then return false end
 local countFn,unitFn=Game[target.type==Obj_AI_Hero and 'HeroCount'or 'MinionCount'],Game[target.type==Obj_AI_Hero and 'Hero'or 'Minion']
 if not countFn or not unitFn then return false end;local n=countFn();local max=target.type==Obj_AI_Hero and 16 or 512
 if not finite(n)or n%1~=0 or n<0 or n>max then return false end
 for i=1,n do local u=unitFn(i);if u and u.networkID==target.networkID and u.handle==target.handle and IsValid(u)then
  -- Same identity does not make a retained wrapper current. Refuse a changed
  -- native position/health rather than casting from a stale target snapshot.
  return u.pos and target.pos and GetDistance(u.pos,target.pos)==0 and u.health==target.health
 end end;return false
end

function FioraChampion:SafePoint(point,safe)
 return point and type(Game.isWall)=='function'and Game.isWall(point)==false and self:TurretSafe(point,safe)
end

-- The stab hits one unit near the endpoint, chosen natively by priority
-- (Template:Data_Fiora/Lunge, 2026-10-10): champions with a vital, champions
-- below 20% health, units Q kills within 252, the nearest champion, then
-- minions. Refuse only when a competitor outranks the intended target; a
-- minion or monster Q does not kill never outranks a champion. `predicted`:
-- the endpoint comes from a prediction that reaches the target, so a moving
-- target needs no hard crowd control (the manual side bind still does).
function FioraChampion:SingleStab(target,point,predicted)
 if not point or GetDistance(target.pos,point)>150 then return false end
 local targetPath=target.pathing
 if not predicted and not(targetPath and targetPath.hasMovePath==false and targetPath.isDashing==false)and GetHardCCDuration(target)<.55 then return false end
 local level=myHero:GetSpellData(_Q).level;local raw=(self.profile.qBase[level]or 0)+(self.profile.qAD[level]or 0)*(finite(myHero.bonusDamage)and myHero.bonusDamage or 0)
 local hero=target.type==Obj_AI_Hero;local reach,near=self.profile.stabRadius or 420,self.profile.stabPriority or 252
 local function low(u)return finite(u.health)and finite(u.maxHealth)and u.maxHealth>0 and u.health/u.maxHealth<.2 end
 local targetVital,targetLow,targetDistance=hero and self:HasVital(target),hero and low(target),GetDistance(target.pos,point)
 for _,kind in ipairs({'Hero','Minion'})do
  local countFn,unitFn=Game[kind..'Count'],Game[kind]
  if not countFn or not unitFn then return false end
  local count=countFn();local limit=kind=='Hero'and 16 or 512
  if type(count)~='number'or count<0 or count>limit or count~=math.floor(count)then return false end
  for i=1,count do local u=unitFn(i)
   if u and u.networkID~=target.networkID and u.team~=myHero.team and not u.dead and (u.health or 0)>0 then
    local path=u.pathing
    local stationary=path and path.hasMovePath==false and path.isDashing==false
    if not stationary and type(u.ms)~='number'then return false end
    local motion=stationary and 0 or math.max(u.ms or 0,path and path.dashSpeed or 0)*.55
    local d=math.max(0,GetDistance(u.pos,point)-motion)
    if d<=reach+(u.boundingRadius or 80)then
     if kind=='Hero'then
      if not hero then return false end
      if self:HasVital(u)and not targetVital then return false end
      if low(u)and not targetVital and not targetLow then return false end
      if d<targetDistance and not targetVital and not targetLow then return false end
     elseif d<=near+(u.boundingRadius or 80)and(u.health or 0)<raw then
      if not hero and d<targetDistance or hero and not targetVital and not targetLow then return false end
     end
    end
   end
  end
 end
 return true
end

function FioraChampion:CastQ(target,safe,validate,extra)
 if not self:Ready(_Q)or not self:CanTarget(target,self.QRange,safe)then return false end
 local targetID,targetHandle=target.networkID,target.handle
 local recast=self:QRecast()
 local function valid(q,r)
  if target.networkID~=targetID or target.handle~=targetHandle or not self:CanTarget(target,self.QRange,safe)or self:QRecast()~=recast then return false end
  if not self.classic then
   local point=r and r.position
   if not self:SafePoint(point,safe)or not self:SingleStab(target,point,true)then return false end
  end
  return not validate or validate(q,r)
 end
 if self.classic then return self:Cast(_Q,HK_Q,target,{range=self.QRange,validate=valid})end
 local pred=Core:Prediction(self.QSpell);pred:GetPrediction(target,myHero)
 if not pred:CanHit(target.type==Obj_AI_Hero and 3 or 2)or not self:SafePoint(pred.CastPosition,safe)
  or not self:SingleStab(target,pred.CastPosition,true)then return false end
 local options={intentTarget=target,range=self.QRange,prevalidateWorldCast=true,validate=valid}
 for k,v in pairs(extra or {})do options[k]=v end
 local ok=self:Cast(_Q,HK_Q,pred.CastPosition,options)
 if ok then self.lastQEnd={position=pred.CastPosition,expires=Game.Timer()+.6}end
 return ok
end
-- Own vitals (Normal). Bounded particle scan: names Fiora_Base_Passive_<side>
-- [_Timeout] and Fiora_Base_R_Mark_<side>_FioraOnly / Fiora_Base_R_<side>
-- _Timeout_FioraOnly (skin0 aliases). Runtime facts beat the static mapping:
-- * Owner: the one enemy champion whose edge lies within profile
--   vitals.ownerRadius of the particle; two candidates are ambiguous and refused.
-- * Direction: a particle clearly off the owner's centre (vitals.offsetMin) is
--   direct evidence; the vital point lies along that observed offset. It is
--   compared once with the name mapping (NE +z, NW +x, SE -x, SW -z, the three
--   Normal rivals' mapping): agreement within vitals.agreeCos is counted, a
--   disagreement keeps the observed direction and is traced.
-- * A particle at the owner's centre carries no direction: it uses the name
--   mapping (the side all three Normal rivals read from the name) while this
--   game has observed no disagreement. After the first disagreement the mapping
--   needs vitals.learnAfter agreements and agreements at least four times the
--   disagreements; otherwise no automatic Q goes there.
-- Every new particle is traced as 'fiora_vital' (name, offset, owner, basis).
function FioraChampion:VitalOwner(p,v,heroes)
 local best,bestD,ambiguous
 for j=1,math.min(#heroes,16)do local h=heroes[j]
  if IsValid(h)and h.team~=myHero.team and h.pos then
   local d=GetDistance(h.pos,p.pos)-(h.boundingRadius or 0)
   if d<=v.ownerRadius then
    if best then ambiguous=true end
    if not bestD or d<bestD then best,bestD=h,d end
   end
  end
 end
 if ambiguous then return nil,'ambiguous_owner'end
 return best
end
function FioraChampion:VitalMappingLearned()
 local v=self.profile.vitals;local l=self.vitalLearn
 if l==nil or l.disagree==0 then return true end
 return l.agree>=v.learnAfter and l.disagree*4<=l.agree
end
-- Observe a row's offset from its owner; the first clear offset is judged once against the name mapping.
function FioraChampion:VitalObserve(row,p,v)
 local o=row.owner;local dx,dz=p.pos.x-o.pos.x,p.pos.z-o.pos.z;local d=math.sqrt(dx*dx+dz*dz)
 row.dx,row.dz=dx,dz
 if d<v.offsetMin then return end
 row.dir={dx/d,dz/d}
 if row.judged then return end
 row.judged=true;local side=v.sides[row.side]
 row.agrees=side[1]*row.dir[1]+side[2]*row.dir[2]>=v.agreeCos
 local l=self.vitalLearn;if row.agrees then l.agree=l.agree+1 else l.disagree=l.disagree+1 end
 if not row.agrees then
  Core:Trace('fiora_vital_disagree',{name=row.name,side=row.side,owner=o.charName,dx=dx,dz=dz,agree=l.agree,disagree=l.disagree})
 end
end
function FioraChampion:ScanVitals()
 local v=self.profile.vitals;if self.classic or not v then return end
 self.vitalLearn=self.vitalLearn or {agree=0,disagree=0}
 local count=Game.ParticleCount and Game.ParticleCount()
 if not finite(count)or count<0 then self.vitals={};return end
 local now=Game.Timer();local seen={};local heroes=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(count,v.scanLimit or 400)do local p=Game.Particle(i)
  local name=p and p.valid~=false and type(p.name)=='string'and p.name
  if name and name:find('Fiora_',1,true)and(name:find('_Passive_',1,true)or name:find('_R_',1,true))then
   local side=name:match('_(N[EW])')or name:match('_(S[EW])')
   if side and v.sides[side]and p.pos then
    local key=p.handle or(name..':'..math.floor(p.pos.x)..':'..math.floor(p.pos.z))
    local row=self.vitals[key]
    if not row then
     local owner,why=self:VitalOwner(p,v,heroes)
     if owner then
      row={key=key,object=p,name=name,side=side,ult=name:find('_R_',1,true)~=nil,owner=owner,identity=owner.networkID,handle=owner.handle,firstSeen=now}
      self.vitals[key]=row;self:VitalObserve(row,p,v)
      Core:Trace('fiora_vital',{name=name,side=side,owner=owner.charName,dx=row.dx,dz=row.dz,basis=row.dir and 'observed'or 'centre',
       agrees=row.agrees,ownerBuff=self:ActiveBuff(owner,'fiorapassivemanager')~=nil})
     elseif why then
      self.vitalRefused=self.vitalRefused or {}
      if not self.vitalRefused[key]then self.vitalRefused[key]=true;Core:Trace('fiora_vital',{name=name,side=side,refused=why})end
     end
    elseif IsValid(row.owner)and row.owner.networkID==row.identity and row.owner.handle==row.handle then self:VitalObserve(row,p,v)end
    if row then seen[key]=true;row.position=Vector(p.pos.x,p.pos.y or 0,p.pos.z);row.timeout=name:find('_Timeout',1,true)~=nil
    elseif self.vitalRefused and self.vitalRefused[key]then seen[key]=true end
   end
  end
 end
 for key in pairs(self.vitals)do if not seen[key]then self.vitals[key]=nil end end
 for key in pairs(self.vitalRefused or {})do if not seen[key]then self.vitalRefused[key]=nil end end
end
function FioraChampion:HasVital(u)
 for _,row in pairs(self.vitals or {})do if row.identity==u.networkID and row.handle==u.handle then return true end end;return false
end
-- How the row's vital point is known: 'observed' offset, learned 'mapping', or nil (unknown).
function FioraChampion:VitalBasis(row)
 if row.dir then return 'observed'end
 if self:VitalMappingLearned()then return 'mapping'end
end
-- A targetable own vital on `target` (passive after vitals.reveal, R vitals after vitals.rReveal) with a known point.
function FioraChampion:Vital(target)
 local v=self.profile.vitals;local now=Game.Timer()
 for _,row in pairs(self.vitals or {})do
  if row.identity==target.networkID and row.handle==target.handle and now-row.firstSeen>=(row.ult and v.rReveal or v.reveal)and self:VitalBasis(row)then return row end
 end
end
function FioraChampion:VitalPoint(target,row,base)
 local basis=self:VitalBasis(row);if not basis then return nil end
 local dir=basis=='observed'and row.dir or self.profile.vitals.sides[row.side];local r=(target.boundingRadius or 65)+self.profile.vitals.offset
 base=base or target.pos;return Vector(base.x+dir[1]*r,base.y or 0,base.z+dir[2]*r)
end
-- The Q endpoint onto the vital, from the predicted unit position; nil when unreachable or unsafe.
function FioraChampion:VitalAim(target,safe)
 local entry=self:Vital(target);if not entry or not self:CanTarget(target,self.QRange+300,safe)then return nil end
 local pred=Core:Prediction(self.QSpell);pred:GetPrediction(target,myHero);if not pred:CanHit(2)then return nil end
 local base=pred.UnitPosition and Vector(pred.UnitPosition.x,0,pred.UnitPosition.z)
 local p=base and self:VitalPoint(target,entry,base)
 if not p or GetDistance(p,myHero.pos)>self.QRange or not self:SafePoint(p,safe)then return nil end
 return {position=p,base=base,row=entry}
end
-- The vital's true damage (3% + 4% per 100 bonus AD of maximum health), only for
-- the vital a Q endpoint `aim` (from VitalAim) actually reaches; otherwise 0.
function FioraChampion:VitalDamage(target,aim)
 if self.classic or not self.profile.vitals or not aim or not aim.row or self:Vital(target)~=aim.row then return 0 end
 local point=self:VitalPoint(target,aim.row,aim.base)
 if not point or GetDistance(aim.position,myHero.pos)>self.QRange or GetDistance(aim.position,point)>self.profile.vitals.reach then return 0 end
 return(self.profile.vitalBase+self.profile.vitalAD*(finite(myHero.bonusDamage)and myHero.bonusDamage or 0))*target.maxHealth
end
-- `permission(aim)` re-reads consent (and, for a finisher, lethality) on every check.
function FioraChampion:VitalQ(target,safe,permission,owner)
 if self.classic or not self.profile.vitals then return false,'no_vitals'end
 if not self:Ready(_Q)or not self:CanTarget(target,self.QRange+300,safe)then return false end
 local entry=self:Vital(target);if not entry then return false,self:HasVital(target)and 'vital_direction_unknown'or nil end
 local function resolve()
  local aim=self:VitalAim(target,safe);if not aim or aim.row~=entry then return nil end
  return aim
 end
 local r=resolve();if not r then return false end
 if permission and not permission(r)then return false end
 local ok=self:Cast(_Q,HK_Q,r.position,{owner=owner or 'VitalQ',intentTarget=target,range=self.QRange,prevalidateWorldCast=true,resolve=resolve,
  commitGuard=function()return Core:Current()and(not permission or permission())end,
  validate=function(_,fresh)local now=resolve();return now~=nil and fresh~=nil and GetDistance(now.position,fresh.position)<=30 and(not permission or permission(now))end})
 if ok then self.lastQEnd={position=r.position,expires=Game.Timer()+.6}end
 return ok
end

function FioraChampion:OwnRMark(target)
 if self.classic or not self:CurrentTarget(target)or target.type~=Obj_AI_Hero or target.team==myHero.team or target.team==300 then return nil end
 local b,ending=self:ActiveBuff(target,'FioraRMark');if not b then return nil end
 local src=b.source;local actor=type(src)=='number'and src or(type(src)=='table'or type(src)=='userdata')and id(src)
 if actor~=myHero.networkID and actor~=myHero.handle and b.sourcenID~=myHero.networkID then return nil end
 if not ownBuff(b,myHero)then return nil end
 local row=self.rObservation
 if row and row.identity==target.networkID and row.handle==target.handle then
  if not finite(b.startTime)or b.startTime<row.at or b.startTime>Game.Timer()then return nil end
 end
 return b,ending
end
function FioraChampion:MarkedSideAssist()
 if self.classic or not Menu.Misc.SideAssist:Value()or not self:Ready(_Q)then return false end
 local target=self.rTarget
 if not target or not self:OwnRMark(target)then
  target=self.rObservation and self.rObservation.target or _G.SDK.TargetSelector.Selected
  if not target or not self:OwnRMark(target)then return false end;self.rTarget=target
 end
 if not self:CanTarget(target,self.QRange,true)then return false end
 local targetID,targetHandle=target.networkID,target.handle
 local function resolve()
  if not Menu.Misc.SideAssist:Value()or target.networkID~=targetID or target.handle~=targetHandle or not self:OwnRMark(target)then return nil end
  local d=GetDistance(myHero.pos,mousePos);if d<30 then return nil end
  local endpoint=myHero.pos:Extended(mousePos,math.min(self.QRange,d))
  if not self:SafePoint(endpoint,true)or not self:SingleStab(target,endpoint,false)then return nil end
  return {position=endpoint}
 end
 local aim=resolve();if not aim then return false end
 return self:Cast(_Q,HK_Q,aim.position,{owner='MarkedSideAssist',intentTarget=target,range=self.QRange,
  context=Core:HeldContext(function()return Menu.Misc.SideAssist:Value()end),resolve=resolve,prevalidateWorldCast=true,
  commitGuard=function()return Core:Current()and Menu.Misc.SideAssist:Value()end,
  validate=function(_,fresh)return self:CanTarget(target,self.QRange,true)and self:OwnRMark(target)~=nil and fresh
   and self:SafePoint(fresh.position,true)and self:SingleStab(target,fresh.position,false)end})
end
-- Ready Q/R and the planned Q landing for Draw. No vitals, E or R-mark text: the game draws the vitals
-- and shows E and the mark; the health bars show the damage. Kept for a second so a late preparation
-- never blinks the rings; the landing keeps its own expiry.
-- While Flee is held with Flee Q on, the wall-hop landing is stored here too (a copy, held .5 s so a
-- single missed search never blinks it) and dropped on Flee release; Draw never searches terrain.
function FioraChampion:PreparePreview()
 local now=Game.Timer()
 self.preview={expires=now+1,q=self:Ready(_Q),r=self:Ready(_R)}
 if not self.classic and Menu.Draw.Vitals:Value()then
  local q=self.lastQEnd;if q and q.expires>now then self.preview.qEnd=q.position;self.preview.qEndExpires=q.expires end
  if GetMode()=='Flee'and Menu.Misc.FleeQ:Value()then
   local land=self:WallLanding()
   if land then self.wallPreview={position=Vector(land.x,land.y or 0,land.z),expires=now+.5}
   elseif self.wallPreview and self.wallPreview.expires<=now then self.wallPreview=nil end
  else self.wallPreview=nil end
  local w=self.wallPreview;if w then self.preview.wall=w.position;self.preview.wallExpires=w.expires;self.preview.wallReady=self.preview.q end
 else self.wallPreview=nil end
end

function FioraChampion:CastQMinion(target)
	-- Dash to an enemy minion only when it leaves the hero inside Q range and closes the gap.
	-- No switch: the first Lunge is spent, the free second one still reaches the champion.
	if not self.classic or self:QRecast() or not Menu.Combo.Q:Value() or target.type ~= Obj_AI_Hero or not self:Ready(_Q) then return false end
	local targetDistance = GetDistance(myHero.pos, target.pos)
	if targetDistance <= self.QRange or targetDistance > 1000 then return false end
	local safe, best, bestDistance = Menu.Combo.SafeQ:Value(), nil, nil
 if not self:CanTarget(target,1000,safe)then return false end
	local list=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#list,512)do local minion=list[i]
		if self:CanTarget(minion, self.QRange, safe) then
			local distance = GetDistance(minion.pos, target.pos)
			if distance <= self.QRange and distance < targetDistance - 100 and (not bestDistance or distance < bestDistance) then
				best, bestDistance = minion, distance
			end
		end
	end
	if best then return self:CastQ(best,safe,function()
  return not self:QRecast()and Menu.Combo.Q:Value()and self:CanTarget(target,1000,safe)
   and GetDistance(myHero.pos,target.pos)>self.QRange
   and GetDistance(best.pos,target.pos)<=self.QRange and GetDistance(best.pos,target.pos)+100<GetDistance(myHero.pos,target.pos)
 end)end
	return false
end

-- The last champion an observed Lunge hit, for the recast window (profile
-- qWindow, 4 s), while it is alive, the same unit and within Q/R reach. The
-- player's own selected champion always wins.
function FioraChampion:LockedTarget()
 local l=self.qLock;if not l then return nil end
 local t=l.target
 if Game.Timer()>l.expires or t.networkID~=l.identity or t.handle~=l.handle or t.dead or(t.health or 0)<=0 then self.qLock=nil;return nil end
 if not IsValid(t)or GetDistance(myHero.pos,t.pos)>math.max(self.QRange,self.RRange)then return nil end
 local selected=_G.SDK.TargetSelector.Selected
 if selected and selected~=t and IsValid(selected)then return nil end
 return t
end
function FioraChampion:GetComboTarget()
 return self.classic and self:LockedTarget()or GetTarget(math.max(self.QRange,self.RRange))
end
-- Lunge as a dodge for Evade. Numbers and their limits: ChampionProfiles/Fiora.lua qDash.
function FioraChampion:EvadeQAllowed(u)
 if u==nil then return true end
 if u.team==myHero.team then return false,'allied_unit'end
 if not self:CanTarget(u,self.QRange,true)then return false,'target_unavailable_or_turret'end
 return true
end
function FioraChampion:EvadeTargets()
 local origin=myHero.pos;local pool,seen={},{}
 local om=_G.SDK.ObjectManager
 for _,list in ipairs({om:GetEnemyHeroes(self.QRange),om:GetEnemyMinions(self.QRange),om:GetMonsters(self.QRange)})do
  for i=1,math.min(#list,16)do local u=list[i];local key=id(u)
   if key and not seen[key]and self:EvadeQAllowed(u)then seen[key]=true;pool[#pool+1]=u end
  end
 end
 -- The enemy already being fought first, then whatever lies toward the cursor.
 local keep=self:LockedTarget();local score={}
 for _,u in ipairs(pool)do score[u]=(u==keep and -1e6 or 0)+GetDistance(u.pos,mousePos)end
 table.sort(pool,function(a,b)return score[a]<score[b]end)
 local out={};local speeds={1200,1200+math.max(0,finite(myHero.ms)and myHero.ms or 0)}
 for i=1,math.min(#pool,8)do local u=pool[i]
  -- Where the Lunge ends relative to its target is not measured: both the
  -- unit's position and the near edge are declared, and both must be safe.
  local d=GetDistance(origin,u.pos);local gap=math.min(d,(u.boundingRadius or 65)+(myHero.boundingRadius or 65))
  local near=d>1 and{x=u.pos.x-(u.pos.x-origin.x)/d*gap,y=u.pos.y,z=u.pos.z-(u.pos.z-origin.z)/d*gap}or{x=u.pos.x,y=u.pos.y,z=u.pos.z}
  out[#out+1]={unit=u,id=id(u),position={x=u.pos.x,y=u.pos.y,z=u.pos.z},landings={near,{x=u.pos.x,y=u.pos.y,z=u.pos.z}},speeds=speeds}
 end
 return out
end
function FioraChampion:PublishMobility()
 local dash=self.profile.qDash;if not dash or not Core.RegisterMobility then return end
 if self.classic then
  -- Not offered until the profile marks the numbers established: what the asset's 1200 means,
  -- the cast delay and where the Lunge ends are all unmeasured (ChampionProfiles/Fiora.lua).
  if dash.established~=true then return end
  self.mobilityPublished=Core:RegisterMobility({kind='unitDash',slot=_Q,key=HK_Q,name=self.profile.qName,range=self.QRange,speeds=dash.speeds,castDelays=dash.castDelays,
   profile='classic',label='Dodge with Q onto an enemy',source=dash.source,
   targets=function()return self:EvadeTargets()end,allowed=function(u)return self:EvadeQAllowed(u)end})
 else
  self.mobilityPublished=Core:RegisterMobility({kind='dash',slot=_Q,key=HK_Q,name=self.profile.qName,range=self.QRange,speeds=dash.speeds,castDelays=dash.castDelays,
   profile='normal',label='Dodge with Q',source=dash.source,toPoint=true,
   -- Known ground only, never into an enemy turret.
   allowed=function(p)if p~=nil and not self:SafePoint(p,true)then return false,'landing_unknown_or_turret'end;return true end})
 end
end

function FioraChampion:CanFarm()
	return Menu.Clear.Enabled:Value() and manaAbove(Menu.Clear.Mana:Value()) and not IsUnderTurret(myHero)
end

function FioraChampion:Tick()
	if self.rObservation and Game.Timer()>self.rObservation.expires then self.rObservation=nil;self.rTarget=nil end
	if not Core:InputAvailable()or ShouldWait()or self:RActive()then return end
 if self.preparationFallback and(not self.nextPreview or Game.Timer()>=self.nextPreview)then self:PreparePreview();self.nextPreview=Game.Timer()+.1 end
 if self.vitalFallback and(not self.nextVitals or Game.Timer()>=self.nextVitals)then self:ScanVitals();self.nextVitals=Game.Timer()+.1 end
	if self.classic and self.qLock then
		-- Attacks stay on the enemy the Lunge hit (shared preference: only inside
		-- attack range, never over the player's selection, cleared by the core).
		local mode=GetMode();local locked=(mode=='Combo'or mode=='Harass')and self:LockedTarget()
		if locked then Core:PreferAttack('FioraLunge',locked,.25)end
	end
	if self:AutoW() then return end
	if IsCasting() or (myHero.pathing and myHero.pathing.isDashing) or _G.SDK.Orbwalker:IsAutoAttacking() then return end
	if Menu.Misc.SemiR:Value() then
		local target = GetTarget(self.RRange)
		if self:CanTarget(target, self.RRange, Menu.Combo.SafeR:Value() and 'held') and self:Cast(_R, HK_R, target,{context=Core:HeldContext(function()return Menu.Misc.SemiR:Value()end)}) then return end
	end
 if not self.classic and Menu.Misc.SideAssist:Value()and self:MarkedSideAssist()then return end
	local mode = GetMode()
	if mode == "Flee" then self:Flee(); return end
	if self:KillSteal() then return end
	if mode == "Combo" then
		self:Combo()
	elseif mode == "Harass" then
		self:Harass()
	elseif mode == "LaneClear" or mode == "LastHit" then
		if mode=="LastHit"then self:LastHit()else self:Clear(false)end
	end
end

function FioraChampion:AttackPermission(target)
 local mode=GetMode()
 if mode=='Combo'and target.type==Obj_AI_Hero then return Menu.Combo.E:Value()end
 if mode=='Harass'and target.type==Obj_AI_Hero then return Menu.Harass.E:Value()and manaAbove(Menu.Harass.Mana:Value())end
 if mode=='LaneClear'and target.type==Obj_AI_Minion and self:CanFarm()then
  return target.team==300 and self:FarmMode(true)and Menu.Clear.JungleE:Value()
   or target.team~=300 and self:FarmMode(false)and Menu.Clear.LaneE:Value()
 end
 return false
end

function FioraChampion:OnPostAttack(args)
 if not Core:InputAvailable()or ShouldWait()or self:RActive()then return end
 local witness=Core:AttackWitness(self.attackWitness,args and args.Target)
 if not witness or witness==self.attackWitness or witness.at>Game.Timer()then return end
 local target=witness.object
 self.attackWitness=witness
 if not self.classic then
  local name=myHero.activeSpell.name
  if name=='FioraEAttack'or name=='FioraEAttack2'then
   self.eAttackObservation={stage=name=='FioraEAttack'and 1 or 2,target=target.networkID,at=witness.at}
  end
 end
 local function useful()
  return self:CurrentTarget(target)and Game.Timer()-witness.at<=.35 and self:AttackPermission(target)
   and _G.SDK.Data:IsInAutoAttackRange(myHero,target)and not self:ActiveBuff(myHero,self.classic and 'Jade_FioraE'or 'FioraE')
   and(self.classic or not self:ActiveBuff(myHero,'FioraE2'))
 end
 if useful()and self:Cast(_E,HK_E,nil,{intentTarget=target,validate=useful})then return end
 local mode=GetMode();local menu=mode=='Combo'and Menu.Combo or mode=='Harass'and Menu.Harass
 if menu and menu.Q:Value()and(mode~='Harass'or manaAbove(menu.Mana:Value()))
  -- The free second Lunge is kept to chase and spent before it expires; a
  -- Lunge that kills goes out through the finisher regardless.
  and(not self:QRecast()or self:QExpiring())then
  local safe=mode~='Combo'or Menu.Combo.SafeQ:Value()and 'held'
  if not self:VitalQ(target,safe,function()return Game.Timer()-witness.at<=.35 end)then
   self:CastQ(target,safe,function()return Game.Timer()-witness.at<=.35 end)
  end
 end
end

function FioraChampion:Health(target,delay)
 return target.health+(target.shieldAD or 0)+math.max(0,target.hpRegen or 0)*(delay or 1)
end

function FioraChampion:WantR(target)
 if not Menu.Combo.R:Value()or not self:CanTarget(target,self.RRange,Menu.Combo.SafeR:Value()and 'held')then return false end
 local low=Menu.Combo.RHP:Value()>0 and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100<=Menu.Combo.RHP:Value()
 if self.classic then
  if self:GetRDmg(target)>=self:Health(target,2)or low then return true end
  -- The usual reason to press Blade Waltz: a lone enemy takes all five strikes.
  -- Combo only (the finisher without a mode key stays on the first strike), with
  -- the lower repeat share of the two sources and a 5% margin.
  return self:WaltzIsolated(target)and self:GetRMaximum(target,true)*.95>=self:Health(target,2)
 end
 -- Never on an enemy that already carries our mark.
 if self:OwnRMark(target)then return false end
 -- Grand Challenge has no immediate damage of its own.
 local followUp=(Menu.Combo.Q:Value()and self:Ready(_Q)and myHero.mana>=(myHero:GetSpellData(_R).mana or 0)+(myHero:GetSpellData(_Q).mana or 0))
   or(Menu.Combo.E:Value()and self:Ready(_E)and myHero.mana>=(myHero:GetSpellData(_R).mana or 0)+(myHero:GetSpellData(_E).mana or 0))
 if low and _G.SDK.Data:IsInAutoAttackRange(myHero,target)and followUp then return true end
 return self:RDuel(target)or self:RFight(target)
end
local function enemiesNear(pos,range,team)
 local n=0;local list=Core:DecisionUnits(team and 'GetAllyHeroes'or 'GetEnemyHeroes')
 for i=1,math.min(#list,16)do local u=list[i];if u~=myHero and IsValid(u)and GetDistance(u.pos,pos)<=range then n=n+1 end end;return n
end
-- Duel kill within the bounded profile horizon (rHorizon, 4 s): the four vitals'
-- true damage, Q and the second E attack's crit when ready, and the attacks that
-- fit the horizon at the current attack rate, against current health, shields
-- and regeneration over the horizon. Not while outnumbered (enemies within 1000
-- more than allies + 1).
function FioraChampion:RDuel(target)
 if enemiesNear(myHero.pos,1000)>enemiesNear(myHero.pos,1000,true)+1 then return false end
 local horizon=self.profile.rHorizon;local maxHealth=target.maxHealth;if not finite(maxHealth)then return false end
 local vital=(self.profile.vitalBase+self.profile.vitalAD*(finite(myHero.bonusDamage)and myHero.bonusDamage or 0))*maxHealth
 local attack=_G.SDK.Damage:GetAutoAttackDamage(myHero,target,true)
 local period=_G.SDK.Attack and _G.SDK.Attack.GetAnimation and _G.SDK.Attack:GetAnimation()
 if not finite(attack)or not finite(period)or period<=0 then return false end
 local damage=4*vital+math.floor(horizon/period)*attack
 if self:Ready(_Q)then damage=damage+self:GetQDmg(target)end
 local level=myHero:GetSpellData(_E).level
 if self:Ready(_E)and self.profile.eTwo[level]then damage=damage+attack*(self.profile.eTwo[level]-1)end
 return Core:Lethal(target,0,damage-math.max(0,target.hpRegen or 0)*horizon,{kind='physical',now=true})==true
end
-- Teamfight: two or more enemy champions within 600 of the target while Fiora is
-- below 60% health; the Victory Zone heals the team once a vital is struck.
function FioraChampion:RFight(target)
 return finite(myHero.health)and finite(myHero.maxHealth)and myHero.maxHealth>0 and myHero.health/myHero.maxHealth<.6
  and enemiesNear(target.pos,600)>=2
end

function FioraChampion:Combo()
 local target=self:GetComboTarget()
 if not IsValid(target)and self.classic then target=GetTarget(1000)end
 if not IsValid(target)then return end
 if self:WantR(target)and self:Cast(_R,HK_R,target,{validate=function()return self:WantR(target)end})then return end
 local safe=Menu.Combo.SafeQ:Value()and 'held'
 -- A vital Q also goes out inside attack range (only once vitals are established).
 if Menu.Combo.Q:Value()and self:VitalQ(target,safe,function()return Menu.Combo.Q:Value()end)then return end
 if Menu.Combo.Q:Value()and(not _G.SDK.Data:IsInAutoAttackRange(myHero,target)or self:QExpiring())then
  if not self:CastQ(target,safe)and self.classic and GetDistance(myHero.pos,target.pos)>self.QRange then self:CastQMinion(target)end
 end
end

function FioraChampion:Harass()
	if not manaAbove(Menu.Harass.Mana:Value()) or not Menu.Harass.Q:Value() then return end
	local target = self:GetComboTarget()
	if IsValid(target) and self:VitalQ(target,true,function()return Menu.Harass.Q:Value()end) then return end
	if IsValid(target) and (not _G.SDK.Data:IsInAutoAttackRange(myHero, target) or self:QExpiring()) then self:CastQ(target, true) end
end

function FioraChampion:ListedAttack(source)
	if source.charName == "Jade_Vayne" then
		local buff=self:ActiveBuff(myHero,"Jade_VayneW_Debuff")
		if buff and (buff.count or 0)>=2 then return true end
	end
	local names = self.profile.wAttacks[source.charName]
	if names == true then return true end
	if not names then return false end
	local spell = source.activeSpell
	local spellName = spell and spell.valid and spell.name
	for _, name in ipairs(names) do
		if spellName == name or self:ActiveBuff(source,name) then return true end
	end
	return false
end

function FioraChampion:AttackThreat(attack)
 local now=Game.Timer();local source=attack.source;local spell=source and source.activeSpell
 if not source or source.networkID~=attack.id or attack.handle and source.handle~=attack.handle or now>=attack.hit then return false end
 local same=spell and spell.valid and not spell.isStopped and spell.target==myHero.handle and spell.startTime==attack.start and(not attack.name or spell.name==attack.name)
 if now<attack.launch and not IsValid(source)then return false end
 if not same and(now<attack.launch or not attack.launched)then return false end
 local enabled
 if source.type==Obj_AI_Hero then
  local hp=Menu.Misc.WNormalHP:Value()
  enabled=Menu.Misc.AutoW:Value()and(self:ListedAttack(source)or hp>0 and myHero.health/myHero.maxHealth*100<=hp)
 else enabled=source.team==300 and self:FarmMode(true)and self:CanFarm()and Menu.Clear.JungleW:Value()end
 local duration=self.classic and 1.5 or .75
 local lead=math.min(duration-.05,.2+_G.SDK.Data:GetLatency())
 return enabled and attack.hit-now<=lead
end

function FioraChampion:AutoW()
 if not self:Ready(_W)or self:ActiveBuff(myHero,self.classic and 'Jade_FioraW'or 'FioraW')then return false end
 local now=Game.Timer();local sources={}
 if Menu.Misc.AutoW:Value()then
  local list=Core:DecisionUnits('GetEnemyHeroes');for i=1,math.min(#list,16)do sources[#sources+1]=list[i]end
 end
 if self:FarmMode(true)and self:CanFarm()and Menu.Clear.JungleW:Value()then
  local list=Core:DecisionUnits('GetMonsters');for i=1,math.min(#list,512)do sources[#sources+1]=list[i]end
 end
 for _,source in ipairs(sources)do
  local spell=source.activeSpell
  local listed=source.type==Obj_AI_Hero and spell and spell.valid and self:ListedAttack(source)
  if IsValid(source)and spell and spell.valid and not spell.isStopped and spell.target==myHero.handle
   and(spell.isAutoAttack or _G.SDK.Data:IsAttack(spell.name or '')or listed)then
   local data=source.attackData or {};local launch=spell.castEndTime
   if not launch or launch<=0 then launch=(spell.startTime or now)+(spell.windup or data.windUpTime or 0)end
   local speed=spell.speed and spell.speed>0 and spell.speed or data.projectileSpeed
   local ranged=(source.range or 125)>=300
   -- A listed targeted cast without a known speed counts as landing when its cast
   -- ends: the stance (profile wDuration) still covers a short flight.
   if listed and not(type(speed)=='number'and speed>0)then ranged=false end
   if not ranged or type(speed)=='number'and speed>0 then
    local travel=ranged and math.max(0,GetDistance(source.pos,myHero.pos)-(source.boundingRadius or 0)-(myHero.boundingRadius or 0))/speed or 0
    local key=tostring(source.networkID)..':'..tostring(launch)
    if finite(launch)and finite(spell.startTime)and launch>=spell.startTime and spell.startTime<=now and not self.incomingAttacks[key]then
     self.incomingAttacks[key]={source=source,id=source.networkID,handle=source.handle,name=spell.name,launch=launch,hit=launch+travel,start=spell.startTime}
    end
    if self.incomingAttacks[key]and now>=launch then self.incomingAttacks[key].launched=true end
   end
  end
 end
 local best,bestKey,count=nil,nil,0
 for key,attack in pairs(self.incomingAttacks)do
  count=count+1
  if count>64 or now>=attack.hit or now<attack.launch and(not attack.source.activeSpell or attack.source.activeSpell.isStopped)then self.incomingAttacks[key]=nil
  elseif self:AttackThreat(attack)and(not best or attack.hit<best.hit)then best,bestKey=attack,key end
 end
 if not best then return false end
 local options={priority='interactive',ttl=150,context=best.source.team==300 and Core:ModeContext('LaneClear',function()return self:FarmMode(true)end)or {priority='interactive'},
  validate=function()return self:AttackThreat(best)end}
 local aim
 if not self.classic then
  -- Defense does not depend on an offensive target or a clear projectile ray;
  -- hit/stun is never assumed. The shock flies after the poise toward the aim:
  -- the attacker where the line to it is clear, else the weakest champion on a
  -- clear line, else toward the attacker.
  aim=self:WAim(best.source)
  options.range=self.profile.wRange
  options.resolve=function()return {position=aim}end
 end
 if not self:Cast(_W,HK_W,aim,options)then return false end
 Core:AfterCast(HK_W,function()self.incomingAttacks[bestKey]=nil end)
 return true
end

-- Where a champion will stand when the shock arrives (poise + flight).
function FioraChampion:ShockPoint(u)
 local t=self.profile.wPoise+GetDistance(myHero.pos,u.pos)/self.profile.wSpeed;local path=u.pathing
 if path and path.hasMovePath and path.endPos and finite(u.ms)and u.ms>0 then return u.pos:Extended(path.endPos,math.min(GetDistance(u.pos,path.endPos),u.ms*t))end
 return u.pos
end
-- No other enemy champion stands on the shock line before `u`.
function FioraChampion:ShockClear(u,p)
 local d=GetDistance(myHero.pos,p);if d<1 then return true end
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,16)do local o=list[i]
  if o~=u and IsValid(o)and o.team~=myHero.team then
   local q=self:ShockPoint(o);local dx,dz=(p.x-myHero.pos.x)/d,(p.z-myHero.pos.z)/d
   local along=(q.x-myHero.pos.x)*dx+(q.z-myHero.pos.z)*dz;local side=math.abs((q.x-myHero.pos.x)*dz-(q.z-myHero.pos.z)*dx)
   if along>0 and along<d and side<=self.profile.wWidth+(o.boundingRadius or 65)then return false end
  end
 end;return true
end
function FioraChampion:WAim(source)
 local range=self.profile.wRange
 if source.type==Obj_AI_Hero then local p=self:ShockPoint(source)
  if GetDistance(myHero.pos,p)<=range and self:ShockClear(source,p)then return myHero.pos:Extended(p,math.min(range,GetDistance(myHero.pos,p)))end
 end
 local best,bestHealth;local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,16)do local u=list[i]
  if IsValid(u)and u.team~=myHero.team then local p=self:ShockPoint(u)
   if GetDistance(myHero.pos,p)<=range and self:ShockClear(u,p)and(not bestHealth or u.health<bestHealth)then best,bestHealth=p,u.health end
  end
 end
 if best then return myHero.pos:Extended(best,math.min(range,GetDistance(myHero.pos,best)))end
 return myHero.pos:Extended(source.pos,math.min(range,GetDistance(myHero.pos,source.pos)))
end
function FioraChampion:FarmMode(jungle)
 return _G.SDK.Orbwalker.Modes[_G.SDK[jungle and 'ORBWALKER_MODE_JUNGLECLEAR'or 'ORBWALKER_MODE_LANECLEAR']]==true
end

function FioraChampion:CanRescue(target,lastHit)
 local menu=lastHit and Menu.LastHit or Menu.Clear
 if lastHit then
  if not menu.Q:Value()or not Core:SpellFarmEnabled()or not manaAbove(menu.Mana:Value())then return false end
 elseif not self:CanFarm()or not self:FarmMode(false)or not Menu.Clear.LaneQ:Value()then return false end
 if not self:CanTarget(target,self.QRange,true)or target.type~=Obj_AI_Minion or target.team==300 or target.team==myHero.team then return false end
 local impact=self.classic and .15+GetDistance(myHero.pos,target.pos)/1200 or .55
 local damage=self:GetQDmg(target)
 -- Rescue confirmed incoming damage only when the provider's seed agrees with
 -- current native HP. Unknown shield/seed data cannot authorize a last hit.
 local hp=Core:UnshieldedLegacyForecast(target,impact)
 if not finite(hp)or hp<=0 or hp>damage then return false end
 if _G.SDK.Attack and _G.SDK.Attack:IsActive()then return false end
 if _G.SDK.Data:IsInAutoAttackRange(myHero,target)and _G.SDK.Orbwalker:CanAttack()then return false end
 return true
end

function FioraChampion:Clear(lastHitOnly)
 if lastHitOnly then return self:LastHit()end
 if not self:CanFarm()or not self:Ready(_Q)then return end
 if self:FarmMode(true)and Menu.Clear.JungleQ:Value()then
  local best;local list=Core:DecisionUnits('GetMonsters')
  for i=1,math.min(#list,512)do local u=list[i]
   if self:CanTarget(u,self.QRange,true)and(not best or u.maxHealth>best.maxHealth)then best=u end
  end
  if best and self:CastQ(best,true,function()return self:FarmMode(true)and self:CanFarm()and Menu.Clear.JungleQ:Value()end)then return end
 end
 if not self:FarmMode(false)then return end
 local list=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#list,512)do local target=list[i]
  if self:CanRescue(target,false)and self:CastQ(target,true,function()return self:CanRescue(target,false)end)then return end
 end
end

function FioraChampion:LastHit()
 if not self:Ready(_Q)then return end
 local list=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#list,512)do local target=list[i]
  if self:CanRescue(target,true)and self:CastQ(target,true,function()return self:CanRescue(target,true)end)then return end
 end
end

function FioraChampion:Flee()
	if not Menu.Misc.FleeQ:Value() or not self:Ready(_Q) then return end
 if not self.classic then
  if self:WallHop()then return true end
  local function resolve()
   local distance=GetDistance(myHero.pos,mousePos)
   if distance<100 then return nil end
   local point=myHero.pos:Extended(mousePos,math.min(400,distance))
   if not self:SafePoint(point,true)then return nil end
   return {position=point}
  end
  local r=resolve();if not r then return end
  return self:Cast(_Q,HK_Q,r.position,{resolve=resolve,range=400,validate=function(_,fresh)
   return Menu.Misc.FleeQ:Value()and fresh and self:SafePoint(fresh.position,true)
    and GetDistance(fresh.position,mousePos)+50<GetDistance(myHero.pos,mousePos)
  end})
 end
	local best, bestDistance = nil, 0
	local mouseDistance = GetDistance(myHero.pos, mousePos) - 100
	for _, units in ipairs({_G.SDK.ObjectManager:GetEnemyHeroes(self.QRange), _G.SDK.ObjectManager:GetEnemyMinions(self.QRange), _G.SDK.ObjectManager:GetMonsters(self.QRange)}) do
		for i=1,math.min(#units,32)do local unit=units[i]
			local distance = GetDistance(myHero.pos, unit.pos)
			if distance > bestDistance and GetDistance(unit.pos, mousePos) < mouseDistance and self:CanTarget(unit, self.QRange, true) then best, bestDistance = unit, distance end
		end
	end
	if best then self:CastQ(best,true,function()return Menu.Misc.FleeQ:Value()and GetDistance(best.pos,mousePos)+100<GetDistance(myHero.pos,mousePos)end)end
end

-- Wall hop (Normal Flee): when terrain lies within 120 ahead toward the cursor,
-- Q over it to the first known ground beyond, within Q range, that brings
-- Fiora at least 150 closer to the cursor; walking there is blocked by that
-- wall, so the hop saves at least as much. Unknown terrain refuses.
function FioraChampion:WallLanding()
 if type(Game.isWall)~='function'then return nil end
 local cursor=mousePos;local d=GetDistance(myHero.pos,cursor);if d<200 then return nil end
 local contact
 for step=20,120,20 do local w=Game.isWall(myHero.pos:Extended(cursor,step));if w==nil then return nil end;if w then contact=step;break end end
 if not contact then return nil end
 for step=contact+25,self.QRange,25 do local p=myHero.pos:Extended(cursor,step);local w=Game.isWall(p)
  if w==nil then return nil end
  if w==false then
   if GetDistance(myHero.pos,cursor)-GetDistance(p,cursor)>=150 and self:SafePoint(p,true)then return p end
   return nil
  end
 end
end
function FioraChampion:WallHop()
 local p=self:WallLanding();if not p then return false end
 local function resolve()local now=self:WallLanding();return now and{position=now}or nil end
 local ok=self:Cast(_Q,HK_Q,p,{owner='WallHop',range=self.QRange,resolve=resolve,prevalidateWorldCast=true,
  validate=function(_,fresh)local now=resolve();return Menu.Misc.FleeQ:Value()and now~=nil and fresh~=nil and GetDistance(now.position,fresh.position)<=30 end})
 if ok then self.lastQEnd={position=p,expires=Game.Timer()+.6}end
 return ok
end
function FioraChampion:KillSteal()
 if self.wq and self:KillWQStep()then return true end
	local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,16)do local target=list[i]
		-- The shared kill rule: health at arrival, physical shields, spell protection.
		local function kills(impact,damage)return IsValid(target)and Core:Lethal(target,impact,damage,{kind='physical'})end
		-- A Q onto a known, reachable vital counts that vital's true damage too (re-checked
		-- against the fresh endpoint on every validation; the commit guard reads consent only).
		if Menu.KillSteal.Q:Value() and self:Ready(_Q) and IsValid(target) and not self.classic and self:Vital(target)
			and self:VitalQ(target,true,function(aim)return Menu.KillSteal.Q:Value()and(aim==nil or kills(.55,function()
				local vital=self:VitalDamage(target,aim);return vital>0 and self:GetQDmg(target)+vital or 0 end))end,'KillVitalQ') then return true end
		if Menu.KillSteal.Q:Value() and self:Ready(_Q) and IsValid(target) and GetDistance(myHero.pos,target.pos)<=self.QRange
			and kills(self.classic and .15+GetDistance(myHero.pos,target.pos)/1200 or .55,function()return self:GetQDmg(target)end) and self:CastQ(target, true) then return true end
		if not self.classic and Menu.KillSteal.W:Value() and self:KillW(target) then return true end
		if not self.classic and Menu.KillSteal.W:Value() and Menu.KillSteal.Q:Value() and self:StartKillWQ(target) then return true end
		if self.classic and Menu.KillSteal.R:Value() and self:Ready(_R) and self:CanTarget(target, self.RRange, Menu.Combo.SafeR:Value() and 'held')
			and kills(.25,function()return self:GetRDmg(target)end) and self:Cast(_R, HK_R, target) then return true end
	end
	return false
end

function FioraChampion:GetWDmg(target)
 local level=myHero:GetSpellData(_W).level;local base=self.profile.wBase and self.profile.wBase[level]
 if not base or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.wAP*myHero.ap)
end
-- W finisher (Normal): the shock line after the poise (profile wPoise, wSpeed,
-- wRange, wWidth) kills from health at arrival, no other enemy champion would
-- take it first, and nothing is about to hit Fiora (W is her main defence).
function FioraChampion:KillW(target)
 if not self:Ready(_W)or not self:CanTarget(target,self.profile.wRange,false)or self:ActiveBuff(myHero,'FioraW')then return false end
 local function lethal()
  local line=Menu.KillSteal.W:Value()and self:WLine(target);if not line then return nil end
  if not Core:Lethal(target,line.delay,function()return self:GetWDmg(target)end,{kind='magical'})then return nil end
  return {position=line.position}
 end
 local r=lethal();if not r then return false end
 return self:Cast(_W,HK_W,r.position,{owner='KillW',intentTarget=target,range=self.profile.wRange,prevalidateWorldCast=true,resolve=lethal,
  context={priority='interactive',condition=function()return Menu.KillSteal.W:Value()end},
  validate=function(_,fresh)local now=lethal();return now~=nil and fresh~=nil and GetDistance(now.position,fresh.position)<=40 end})
end
-- The shock line to `target`: in reach, no nearer champion on it, and nothing about to hit Fiora.
function FioraChampion:WLine(target)
 if not IsValid(target)or Core:AllyThreat(myHero,1.0)~=nil then return nil end
 local p=self:ShockPoint(target);if GetDistance(myHero.pos,p)>self.profile.wRange or not self:ShockClear(target,p)then return nil end
 return {position=myHero.pos:Extended(p,math.min(self.profile.wRange,GetDistance(myHero.pos,p))),delay=self.profile.wPoise+GetDistance(myHero.pos,p)/self.profile.wSpeed}
end
-- W then Q kill (Normal), only when neither alone kills. Consent: both finisher
-- switches. W goes first; the Q is a separate intent that depends on the
-- mechanically observed W and is sent only after the stance, if it still kills
-- with fresh health (the shock counts only while it can still be in flight and
-- the target has not already lost its damage).
function FioraChampion:StartKillWQ(target)
 if self.wq or self.wqRetryAt and Game.Timer()<self.wqRetryAt or not self:Ready(_W)or not self:Ready(_Q)or self:ActiveBuff(myHero,'FioraW')then return false end
 if not self:CanTarget(target,self.QRange,true)or not self:CanTarget(target,self.profile.wRange,false)then return false end
 if myHero.mana<(myHero:GetSpellData(_W).mana or 0)+(myHero:GetSpellData(_Q).mana or 0)then return false end
 local line=self:WLine(target);if not line then return false end
 local qAt=self.profile.wDuration+.55
 if Core:Lethal(target,.55,function()return self:GetQDmg(target)end,{kind='physical'})
  or Core:Lethal(target,line.delay,function()return self:GetWDmg(target)end,{kind='magical'})then return false end
 local function both()return Core:Lethal(target,math.max(line.delay,qAt),function()return self:GetWDmg(target)+self:GetQDmg(target)end)end
 if not both()then return false end
 local now=Game.Timer();local plan={target=target,identity=target.networkID,handle=target.handle,expires=now+qAt+.8}
 local function lethal()
  local fresh=self.wq==plan and Menu.KillSteal.W:Value()and Menu.KillSteal.Q:Value()and self:Ready(_Q)and self:WLine(target)
  if not fresh or not Core:Lethal(target,math.max(fresh.delay,qAt),function()return self:GetWDmg(target)+self:GetQDmg(target)end)then return nil end
  return {position=fresh.position}
 end
 self.wq=plan
 local ok=self:Cast(_W,HK_W,line.position,{owner='KillWQ',intentTarget=target,range=self.profile.wRange,prevalidateWorldCast=true,resolve=lethal,
  context={priority='interactive',condition=function()return self.wq==plan and Menu.KillSteal.W:Value()and Menu.KillSteal.Q:Value()end},
  validate=function(_,fresh)local r=lethal();return r~=nil and fresh~=nil and GetDistance(r.position,fresh.position)<=40 end})
 if not ok then self.wq=nil;return false end
 plan.wIntent=Core.lastIntent;plan.wID=plan.wIntent and plan.wIntent.id
 Core:AfterCast(HK_W,function()
  if self.wq~=plan then return end
  local at=Game.Timer();plan.observedAt=at;plan.hpAtW=target.health;plan.wDamage=self:GetWDmg(target)
  plan.shockAt=at+self.profile.wPoise+GetDistance(myHero.pos,target.pos)/self.profile.wSpeed
 end)
 Core:Trace('fiora_wq',{stage='w',target=plan.identity})
 return true
end
-- Fresh W+Q lethality after the observed W: the shock still counts only before it
-- can have landed and while the target has not visibly taken it.
function FioraChampion:WQLethal(plan)
 local t=plan.target;if not IsValid(t)or t.networkID~=plan.identity or t.handle~=plan.handle then return false end
 local pending=Game.Timer()<plan.shockAt+.15 and(t.health or 0)>(plan.hpAtW or 0)-.5*(plan.wDamage or 0)
 return Core:Lethal(t,.55,function()return self:GetQDmg(t)+(pending and self:GetWDmg(t)or 0)end,{kind=not pending and 'physical'or nil})==true
end
-- Advances the W+Q plan; true while it holds the finisher slot.
function FioraChampion:KillWQStep()
 local plan=self.wq;local now=Game.Timer()
 -- An ended plan (including a sent but unseen W) never restarts at once: no replay of uncertain input.
 local function finish(why)if self.wq==plan then self.wq=nil;self.wqRetryAt=now+1 end;Core:Trace('fiora_wq',{stage='end',reason=why,target=plan.identity});return false end
 local t=plan.target
 if now>plan.expires then return finish('expired')end
 if not IsValid(t)or t.networkID~=plan.identity or t.handle~=plan.handle then return finish('target_gone')end
 if not Menu.KillSteal.W:Value()or not Menu.KillSteal.Q:Value()then return finish('consent')end
 if not plan.observedAt then
  local w=plan.wIntent;local receipt=plan.wID and Core.adapter:Poll(plan.wID)
  if receipt and(receipt.state=='cancelled_before_send'or receipt.jobCancelled)then return finish('w_cancelled')end
  if w and not w.sentAt and Core.pending[HK_W]~=w then return finish('w_not_sent')end
  if w and w.sentAt and Core.adapter:Now()-w.sentAt>400 then return finish('w_unseen')end
  return true
 end
 local q=plan.qIntent
 if q then
  if q.observedAt then return finish('q_observed')end
  if q.sentAt or Core.pending[HK_Q]==q then return true end
  plan.qIntent=nil
 end
 if not self:Ready(_Q)or self:ActiveBuff(myHero,'FioraW')then return true end
 if not self:WQLethal(plan)then return finish('not_lethal')end
 -- A dependent intent takes the ordinary path (final validator before the send), not the prevalidated one.
 local ok=self:CastQ(t,true,function()return self.wq==plan and Menu.KillSteal.Q:Value()and self:WQLethal(plan)end,
  {owner='KillWQ',dependency=plan.wID,dependencyState='mechanical',prevalidateWorldCast=false,context={priority='interactive',condition=function()return self.wq==plan end}})
 if ok then plan.qIntent=Core.lastIntent;Core:Trace('fiora_wq',{stage='q',target=plan.identity})end
 return true
end
function FioraChampion:GetQDmg(target)
 local level=myHero:GetSpellData(_Q).level;local base=self.profile.qBase[level];if not base or not finite(myHero.bonusDamage)then return 0 end
 local raw=base+self.profile.qAD[level]*myHero.bonusDamage
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw,true)
end

function FioraChampion:GetRDmg(target)
	local level = myHero:GetSpellData(_R).level
	if level == 0 or not self.classic then return 0 end
	if not self.profile.rBase[level]or not finite(myHero.bonusDamage)then return 0 end
	local damage = self.profile.rBase[level] + self.profile.rAD * myHero.bonusDamage
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,damage,true)
end
-- No other living enemy champion inside the bounce radius of the target: the
-- Waltz strikes champions only, so all five strikes fall on this one. An
-- unreadable roster is never "isolated".
function FioraChampion:WaltzIsolated(target)
 local count=Game.HeroCount and Game.HeroCount()
 if not Game.Hero or type(count)~='number'or count<0 or count>16 or count~=math.floor(count)then return false end
 for i=1,count do local enemy=Game.Hero(i)
  if enemy and enemy.team~=myHero.team and not enemy.dead and (enemy.health or 0)>0
   and enemy.networkID~=target.networkID and GetDistance(enemy.pos,target.pos)<=self.profile.rBounce then return false end
 end
 return true
end
-- floor=true: the lower repeat share (see the profile), for kill decisions.
function FioraChampion:GetRMaximum(target,floor)
 local level=myHero:GetSpellData(_R).level;if not self.classic or not self.profile.rBase[level]or not finite(myHero.bonusDamage)then return 0 end
 local damage=self.profile.rBase[level]+self.profile.rAD*myHero.bonusDamage
	-- Blade Waltz: five strikes; repeated hits deal a share of the first.
	-- Isolation is a preview of potential distribution, not guaranteed future hits.
 if self:WaltzIsolated(target)then damage=damage*(1+(self.profile.rStrikes-1)*(floor and self.profile.rRepeatFloor or self.profile.rRepeat))end
	return _G.SDK.Damage:CalculateDamage(myHero, target, _G.SDK.DAMAGE_TYPE_PHYSICAL, damage,true)
end

function FioraChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},e={node=Menu.Combo.E,label='E after an attack'},r={node=Menu.Combo.R,label='Combo R'},
  safe={node=Menu.Combo.SafeQ,label='Q turret safety'},w={node=Menu.Misc.AutoW,label='Incoming attack W'},
  farm={node=Menu.Clear.Enabled,label='Spell farming'},last={node=Menu.LastHit.Q,label='Last Hit rescue'},semi={node=Menu.Misc.SemiR,label='R bind'}}
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Fiora: controls','Fiora: combat','Fiora: farming'},function(page)
  if page==1 then return {title=self.classic and 'Classic Fiora'or 'Fiora',cards={
   {'COMBO','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..'. [[q]], [[e]] and [[r]] keep separate consent. [[semi]] shows your assisted R binding.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. Mana limits and mode release apply to waiting work.'},
   {'FLEE','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_FLEE)..'. '..(self.classic and 'Q uses a valid enemy toward your current cursor.'or 'Q follows the cursor up to 400 units and rejects unknown terrain or enemy turrets.')}}}end
  if page==2 then return {title=self.classic and 'Lunge, parry and Blade Waltz'or 'Lunge, Riposte and Grand Challenge',cards={
   {'Q',self.classic and 'Free Q2 needs an owned live recast buff. A minion gapclose cannot spend the final Q. [[safe]] applies again before sending.'or '[[q]] stabs a vital when its spot is seen beside the enemy (or the side names proved right earlier this game), otherwise the enemy itself when no other unit would take the stab. Finishers use Q, W, or W then Q when neither kills alone. The side bind dashes to the cursor side of your own R-marked target.'},
   {'W AND E','[[w]] follows an attributed incoming attack and drops cancelled windups. '..(self.classic and 'W parries the next attack.'or 'W blocks the threat even without an offensive target; a counterattack hit is not assumed. Evade handles its supported skillshot threats.')..' [[e]] requires an observed attack and the same living victim in reach.'},
   {'R',self.classic and 'Blade Waltz uses the matched first hit. Without a mode key only a first hit that kills is taken; in Combo a lone enemy that all five strikes kill is taken too (repeat hits counted at the lower 25% of the two sources). Only actual owned R state suppresses movement. After a Lunge on a champion the second Lunge and the attacks stay on that enemy for four seconds.'or '[[r]] goes out for a four-second duel you win while not outnumbered, in a fight around the target while you are below 60% health, or below your health limit with a Q or E follow-up. Never on an enemy already carrying your mark. Manual side assistance stays anchored to an owned native mark.'}},note='Sent input is not proof of a hit, a vital proc or a successful parry.'}end
  return {title='Farming and consent',cards={
   {'CLEAR','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..' for lane work or '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_JUNGLECLEAR)..' for camps. [[farm]] and the corresponding spell settings are required.'},
   {'LAST HIT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT)..' with [[farm]] and [[last]] enabled. A ready lethal attack is preferred over Q.'},
   {'LIMITS',self.classic and 'Lane Q refreshes lethal health and safety at dispatch. Classic E is a speed buff, not Normal Bladework.'or 'Q refuses a stab another unit would take, even during farming. Healing-zone routes are not planned; the side bind leaves the choice with you.'}}}
 end,cfg,links,activate)
end

function FioraChampion:Draw()
	if myHero.dead then return end
 local p=self.preview;if not p or p.expires<=Game.Timer()then return end
	if Menu.Draw.Q:Value()and p.q then Draw.Circle(myHero.pos,self.QRange,1,Draw.Color(255,66,244,113))end
	if Menu.Draw.R:Value()and p.r then Draw.Circle(myHero.pos,self.RRange,1,Draw.Color(255,244,120,66))end
 if p.qEnd and p.qEndExpires>Game.Timer()and Menu.Draw.Vitals and Menu.Draw.Vitals:Value()then Draw.Circle(p.qEnd,55,1,Draw.Color(200,120,255,180))end
 if p.wall then
  -- Released Flee clears the stored landing at once (the next preparation may be up to 100 ms away).
  if GetMode()~='Flee'then p.wall=nil;self.wallPreview=nil
  elseif p.wallExpires>Game.Timer()and Menu.Draw.Vitals and Menu.Draw.Vitals:Value()then
   Draw.Circle(p.wall,65,1,p.wallReady and Draw.Color(220,90,220,255)or Draw.Color(160,150,150,150))
  end
 end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:RegisterPolicy({
    damageTypes={Q='physical',R='physical'},
    methods={
        AutoW=function()return {priority='interactive'}end,
        OnPostAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode) or nil end,

        Combo=function()return Core:ModeContext("Combo")end,
        Harass=function()return Core:ModeContext("Harass")end,
        Clear=function()return Core:ModeContext("LaneClear")end,
        LastHit=function()return Core:ModeContext("LastHit")end,
        Flee=function()return Core:ModeContext("Flee")end,
    },
    costPaid=function(self,q,slot)return slot==_Q and self:QRecast() end,
    exceptions={non_interrupting_summoner=true},
    channel=function(self,q)
     local spell=myHero.activeSpell
     return not self:RActive()and not Core:IsChannelCast(spell,true)
    end,
    validate=function(self,q,slot,resolved)
        if slot and slot<=_R then
            if not self:Ready(slot)then return false end
            if myHero.pathing and myHero.pathing.isDashing then return false end
            if q.object and slot==_R then return self:CanTarget(q.object,self.RRange,Menu.Combo.SafeR:Value()and 'held')end
        end
        return true
    end,
})

FioraChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Fiora"]="Fiora"}
local normalSupported={["Fiora"]=true}

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
