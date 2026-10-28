return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["KogMaw"]=function()return _G.OrbamaFamily:Require("15cd3f4a7d5215cdadc5bfb59e9f6394dec44d7342f663bd9cc0f3c87e452a01")()end
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
if champion=="KogMaw" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='KogMaw',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.02
-- Installed assets and primary Normal references: kogmaw-provenance.json.
-- Classic targeted Q is an asset-backed candidate, not a live transport claim.
local profiles=ChampionProfiles('KogMaw')
local finite,identity,manaAbove,buffExpiry=Core.finite,Core.id,Core.manaAbove,Core.buffExpiry
local function onScreen(target)return IsValid(target)and target.pos and target.pos:ToScreen().onScreen end
local KogMawChampion=class("KogMawChampion")
function KogMawChampion:__init()
 self.profile=assert(profiles[myHero.charName],'Unsupported KogMaw profile')
 self.profile.wBuff=assert(KogMawProfile.BuffName(myHero.charName),'Missing W profile')
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=70,Range=self.profile.qRange,Speed=self.profile.qSpeed,
  Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL}}
 self.ESpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=120,Range=self.profile.eRange,Speed=self.profile.eSpeed,
  Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}}
 -- E half-width retains an inherited estimate. R Delay is the total cast-start-to-impact
 -- time (windup + impact); the prediction provider adds latency/2 + its extra delay once.
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=self.profile.rWindup+self.profile.rImpact,Radius=self.profile.rRadius,
  Range=self:RRange(),Speed=math.huge,Collision=false}
  self:LoadMenu()
  self.rConsent={};self:DiscoverRConsent()
  Core:RegisterCleanup('KogMaw',function()self.rConsent={};self.motion=nil;self.rOutcome=nil;self.rImpact=nil;self.nextConsent=nil
   self.passive=nil;Core:ReleaseMovePreference('KogMawPassive')end)
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
 Callback.Add('Draw',function()self:Draw()end)
 Callback.Add('Tick',function()self:OnTick()end)
end
function KogMawChampion:LoadMenu()
	local championIcon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/".."KogMaw.png"
	Menu = MenuElement({type = MENU, id = "Classic_AIO_"..myHero.charName, name="AyyyyIO - Kog'Maw", leftIcon = championIcon})
	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "R", name = "Use R", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "Rstacks", name = "Stop using R at this many stacks", value = 3, min = 1, max = 10, step = 1})
	-- Normal R doubles below 40% health, so Combo saves its stacking cost for that; Classic R has no such step.
	Menu.Combo:MenuElement({id='RHealth',name='Use R only on enemies below health %',value=self.profile.id=='normal'and 40 or 100,min=10,max=100,step=5})

	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	-- Harass R poke (TRUSt): its own, lower stack limit; the Harass mana minimum applies.
	Menu.Harass:MenuElement({id = "R", name = "Use R", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "Rstacks", name = "Stop using R at this many stacks", value = 1, min = 1, max = 10, step = 1})

	Menu:MenuElement({type = MENU, id = "Misc", name = "Behaviour"})
	Menu.Misc:MenuElement({id = "SMR", name = "Cast R at the selected target", key = string.byte("T")})
	Menu.Misc:MenuElement({id = "WHold", name = "Only attack while W is active (no Q, E, R)", value = false})
	-- Only where the explosion radius is known (Normal); Classic has no source for it yet.
	if self.profile.passive and self.profile.passive.radius then
		Menu.Misc:MenuElement({id = "Pursuit", name = "After death, walk toward enemies while a mode is held", value = true, menu = false})
	end

	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "Q", name = "Q range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "E", name = "E range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "R", name = "R range", toggle = true, value = false})

 Menu.Harass:MenuElement({id='Mana',name='Only above mana %',value=40,min=0,max=100,step=5})
  Menu.Misc:MenuElement({id='Rmana',name='Keep this mana % after R',value=15,min=0,max=100,step=5})
  Menu.Misc:MenuElement({type=MENU,id='RTargets',name='Enemy champions R may target'})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
  Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
  Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
  Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,
   callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
  for _,kind in ipairs({'LaneClear','JungleClear'})do
   Menu.Clear:MenuElement({type=MENU,id=kind,name=kind})
   Menu.Clear[kind]:MenuElement({id='Q',name=kind=='LaneClear'and 'Use Q on minions an attack cannot take'or 'Use Q',value=true})
   Menu.Clear[kind]:MenuElement({id='E',name='Use E',value=true})
   Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
  end
  Menu.Clear.LaneClear:MenuElement({id='ECount',name='Lane minions E must hit',value=3,min=1,max=8,step=1})
  Menu.Clear.JungleClear:MenuElement({id='W',name='Use W',value=true})
end


function KogMawChampion:RRange()return self.profile.rRange[myHero:GetSpellData(_R).level]or 0 end
function KogMawChampion:DiscoverRConsent()
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,16)do local unit=enemies[i];local id=unit and unit.networkID
  if id and unit.type==Obj_AI_Hero and unit.team~=myHero.team and type(unit.charName)=='string'and not self.rConsent[id]then
   local key=StableUnitMenuKey(self,'R',unit)
   if not Menu.Misc.RTargets[key]then Menu.Misc.RTargets:MenuElement({id=key,name=unit.charName,value=true})end
   self.rConsent[id]={node=Menu.Misc.RTargets[key],handle=unit.handle,name=unit.charName}
  end
 end
 self.nextConsent=Game.Timer()+1
end
function KogMawChampion:RConsented(unit)
 local entry=unit and self.rConsent[unit.networkID]
 return entry and entry.handle==unit.handle and entry.name==unit.charName and entry.node:Value()==true or false
end
-- Self-buff enumeration is bounded and refreshed at dispatch. Missing/invalid
-- expiry cannot authorize a cost-dependent cast. Native count is not stacks.
function KogMawChampion:BuffCount(alias)
 local count=myHero.buffCount
 if not finite(count)or count%1~=0 or count<0 or count>128 then return nil end
 local result=0
 for i=0,count do
  local b=myHero:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==alias then
   local n=b.count
   if not finite(n)or n<0 or n%1~=0 then return nil end
   if n>0 then
    local expiry=buffExpiry(b)
    if not finite(expiry)then return nil end
    if expiry>Game.Timer()then
     local source=b.source or b.caster
     local kind=type(source)
     if source~=nil and kind~='number'and kind~='table'and kind~='userdata'then return nil end
     local id=kind=='number'and source or identity(source)
     if id and id~=myHero.networkID and id~=myHero.handle then return nil end
     result=math.max(result,n)
    end
   end
  end
 end
 return result
end
function KogMawChampion:WActive()local n=self:BuffCount(self.profile.wBuff);return n and n>0 end
function KogMawChampion:ManaAllowed(menu)
 return not menu.Mana or manaAbove(menu.Mana:Value())
end
function KogMawChampion:RCost()
 local stacks=self:BuffCount(self.profile.rBuff)
 if not stacks or stacks>9 then return nil end
 local reported=myHero:GetSpellData(_R).mana
 if not finite(reported)or reported<0 then return nil end
 -- Host cost can exceed the reconstructed minimum; never spend the lower value.
 return math.max(reported,math.min(400,40+40*stacks)),stacks
end
function KogMawChampion:RAllowed(policy)
 -- Cheap gates first: the buff scan in RCost runs only when R could be cast.
 -- The reconstructed cost is never below the reported cost, so these refusals
 -- are the same ones RCost would produce.
 if not IsReady(_R)then return false end
 -- A kill is worth the mana: lethal R only needs its cost to be payable (the reserve keeps mana for
 -- Combo, Harass and the R bind).
 local reserve=policy=='kill'and 0 or Menu.Misc.Rmana:Value()
 local reported=myHero:GetSpellData(_R).mana
 if finite(reported)and reported>=0 and(myHero.mana<reported or myHero.maxMana<=0
  or (myHero.mana-reported)/myHero.maxMana*100<reserve)then return false end
 local cost,stacks=self:RCost()
 if not cost or not IsReady(_R)or myHero.mana<cost then return false end
 if myHero.maxMana<=0 or (myHero.mana-cost)/myHero.maxMana*100<reserve then return false end
  -- Combo and Harass R are stack-limited; the R bind and lethal R are deliberate spends.
  if policy==true then return stacks<Menu.Combo.Rstacks:Value()end
  if policy=='harass'then return stacks<Menu.Harass.Rstacks:Value()end
  return true
end
-- Keep W's cost (GGAIO WMana, TRUSt "save mana for W"): with an enemy champion close, Q, E and Combo or
-- Harass R must leave the mana for W while W is learned, not running and ready within 3 s. Host costs;
-- the finishers (QKS, RKS) do not ask. No switch: W is the champion's damage.
function KogMawChampion:EnemyNear(range)
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,10)do local unit=enemies[i]
  if IsValid(unit)and unit.team~=myHero.team and GetDistance(unit.pos,myHero.pos)<=range then return true end
 end
 return false
end
function KogMawChampion:WReserve(slot)
 local w=myHero:GetSpellData(_W)
 if not w or(w.level or 0)<1 or self:BuffCount(self.profile.wBuff)~=0 or not self:EnemyNear(1000)then return true end
 if slot~=_R then return(Core:Affordable(slot,{_W},3))end
 if not finite(w.mana)or w.mana<=0 or not finite(w.currentCd)or w.currentCd>3 then return true end
 local cost=self:RCost()
 return cost~=nil and myHero.mana-cost>=w.mana
end
function KogMawChampion:WReach(target)
 local rank=myHero:GetSpellData(_W).level
 if rank<1 then return 0 end
 -- Base range avoids adding W twice when the runtime already expands myHero.range.
 return 500+110+20*rank+(myHero.boundingRadius or 0)+(target.boundingRadius or 0)
end
function KogMawChampion:WAllowed(target)
 return onScreen(target)and myHero:GetSpellData(_W).level>0 and self:BuffCount(self.profile.wBuff)==0
  and GetDistance(target.pos,myHero.pos)<=self:WReach(target)
end
function KogMawChampion:PreferredTarget(range)
 local selected=_G.SDK.TargetSelector.Selected
 if onScreen(selected)and GetDistance(selected.pos,myHero.pos)<=range then return selected end
 local current=_G.SDK.Orbwalker:GetTarget()
 if onScreen(current)and current.type==Obj_AI_Hero and GetDistance(current.pos,myHero.pos)<=range then return current end
 local target=GetTarget(range)
 if onScreen(target)and GetDistance(target.pos,myHero.pos)<=range then return target end
end
function KogMawChampion:QDamage(target)
 local base=self.profile.qBase[myHero:GetSpellData(_Q).level]
 return base and _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.qAP*myHero.ap)or 0
end
function KogMawChampion:RDamage(target,impact)
 local rank=myHero:GetSpellData(_R).level;local base=self.profile.rBase[rank]
 if not base then return 0 end
 if self.profile.id=='classic'and target.type~=Obj_AI_Hero then base=base/2.25 end
 local raw=base+self.profile.rAD*myHero.bonusDamage+self.profile.rAP[rank]*myHero.ap
 if self.profile.id=='normal'then
  if not finite(target.maxHealth)or target.maxHealth<=0 then return 0 end
   impact=impact or OrbamaPrediction:GetImpactTime(self.RSpell,target.pos,myHero)
   if not finite(impact)or impact<0 then return 0 end
   local hp=math.min(target.maxHealth,target.health+math.max(0,target.hpRegen or 0)*impact)
  local ratio=math.max(0,hp/target.maxHealth)
  raw=raw*(ratio<.4 and 2 or 1+.8333333333*(1-ratio))
 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
function KogMawChampion:RLethal(target)
  if not onScreen(target)or target.type~=Obj_AI_Hero or not self:RConsented(target)or IsInvulnerable(target)
   or GetDistance(target.pos,myHero.pos)>self:RRange()then return false end
  local impact=OrbamaPrediction:GetImpactTime(self.RSpell,target.pos,myHero)
  if not finite(impact)or impact<0 then return false end
  local health=Core:HealthEstimate(target,impact,'magical',self:RDamage(target,impact))
  return health and health.lethal or false
end
function KogMawChampion:SpellAllowed(slot,target,range,menu)
  if not onScreen(target)or not IsReady(slot)or GetDistance(target.pos,myHero.pos)>range then return false end
  if slot==_R and not self:RConsented(target)then return false end
 if menu and(not self:ManaAllowed(menu)or not menu[({[_Q]='Q',[_W]='W',[_E]='E',[_R]='R'})[slot]]:Value())then return false end
 if slot~=_W and Menu.Misc.WHold:Value()and self:BuffCount(self.profile.wBuff)~=0 then return false end
 return true
end
function KogMawChampion:CastPrediction(key,target,range,validate,confidence,extra)
 local slot=({[HK_Q]=_Q,[HK_E]=_E,[HK_R]=_R})[key]
 if not slot then return false end
 range=range or(slot==_Q and self.profile.qRange or slot==_E and self.ESpell.Range or self:RRange())
 if not self:SpellAllowed(slot,target,range)then return false end
  local options={};for name,value in pairs(extra or {})do options[name]=value end
  options.intentTarget=target;options.range=range;options.validate=validate
 if slot==_Q and self.profile.id=='classic'then return Core:Cast(key,target,options)end
 local spell=slot==_Q and self.QSpell or slot==_E and self.ESpell or self.RSpell
 if slot==_Q then
  local windup=myHero.attackData and myHero.attackData.windUpTime
  if not finite(windup)or windup<=0 or windup>1 then return false end
  self.QSpell.Delay=windup
  local check=validate
  options.validate=function(q,resolved)
   return myHero.attackData and myHero.attackData.windUpTime==windup and(not check or check(q,resolved))
  end
 end
 if slot==_R then self.RSpell.Range=self:RRange()end
 local prediction=Core:Prediction(spell);prediction:GetPrediction(target,myHero)
 if not prediction:CanHit(confidence or OrbamaPrediction.HITCHANCE_HIGH)then return false end
 options.prevalidateWorldCast=true
 return Core:Cast(key,prediction.CastPosition,options)
end
-- R aim. Prediction (speed=huge) returns UnitPosition = predicted position at
-- impact (path cut at ms*(Delay+latency/2+extra)). Aim on the segment between the
-- current and predicted impact positions so both "keeps walking" and "stops now"
-- leave the hitbox inside the circle: back-off = min(travel/2, radius-safety), so
-- the predicted impact position is always inside radius-safety of the aim.
-- spread = worst of those two cases; hit requires spread <= radius+boundingRadius.
local R_SAFETY=40
-- Live 2026-10-03 (session 24e5e15f, 10 Classic R outcomes): targets covered on
-- average ~0.3 of the predicted straight-line travel before impact (they turn or
-- stop during the 1.1 s delay). Lead the aim by this fraction, still keeping the
-- predicted impact position within radius-safety of the aim.
local R_LEAD=.35
-- Live 2026-10-04 (session 22eb504a:1694031, 24 judged R): misses were reversals
-- (target ended -0.2..-3.5x along the predicted path) after recent direction
-- changes. Track a short per-enemy heading history; stack-gated Combo R waits
-- while a target is juking. Lethal/killsteal R (gate=false) is unaffected.
local JUKE_WINDOW,JUKE_ANGLE_COS,JUKE_MIN_SPEED=1.0,math.cos(math.rad(75)),120
function KogMawChampion:TrackMotion()
 local now=Game.Timer();if now<(self.motionAt or 0)then return end
 self.motionAt=now+.1;self.motion=self.motion or {}
 local range=self:RRange()+400
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,10)do local t=enemies[i]
  if onScreen(t)and GetDistance(t.pos,myHero.pos)<=range then
   local id=t.networkID;local m=self.motion[id]
   if not m then m={x=t.pos.x,z=t.pos.z,at=now};self.motion[id]=m
   elseif now-m.at>=.1 then
    local dx,dz,dt=t.pos.x-m.x,t.pos.z-m.z,now-m.at
    local speed=math.sqrt(dx*dx+dz*dz)/dt
    if speed>=JUKE_MIN_SPEED then
     local ux,uz=dx/(speed*dt),dz/(speed*dt)
     if m.ux and ux*m.ux+uz*m.uz<JUKE_ANGLE_COS then m.turnAt=now end
     m.ux,m.uz=ux,uz
    end
    m.x,m.z,m.at=t.pos.x,t.pos.z,now
   end
  end
 end
end
function KogMawChampion:Juking(target)
 local m=self.motion and self.motion[target.networkID]
 return m~=nil and m.turnAt~=nil and Game.Timer()-m.turnAt<=JUKE_WINDOW
end
function KogMawChampion:RAim(target,gate)
  if not onScreen(target)or not self:RConsented(target)then return nil,'target_invalid_or_unconsented' end
 local spell=self.RSpell;spell.Range=self:RRange()
 local prediction=Core:Prediction(spell);prediction:GetPrediction(target,myHero)
  if not prediction:CanHit(OrbamaPrediction.HITCHANCE_HIGH)then return nil,'prediction_declined' end
  local channel=Core:ControlledHit(target,spell,prediction.CastPosition)
  local unit=prediction.UnitPosition
 if not unit then return nil,'prediction_missing' end
 local now=target.pos
 local dx,dz=unit.x-now.x,unit.z-now.z
 local travel=math.sqrt(dx*dx+dz*dz)
 if gate and not channel and travel>150 and self:Juking(target)then
  if Core.logger then Core:Trace('r_decline',{target=target.networkID,reason='recent_direction_change',travel=travel},1000)end
  return nil,'recent_direction_change'
 end
 local lead=math.max(travel*R_LEAD,travel-math.max(0,spell.Radius-R_SAFETY))
 local back=travel-math.min(travel,lead)
 local x,z=unit.x,unit.z
 if travel>1 then x,z=x-dx/travel*back,z-dz/travel*back end
 local spread=math.max(travel-back,back)
 local reach=spell.Radius+(target.boundingRadius or 0)
 if spread>reach then return nil,'spread_exceeds_radius' end
 if gate and spread>reach-R_SAFETY then return nil,'low_chance_moving_target' end
 local aim=Vector(x,now.y or 0,z)
 if GetDistance(aim,myHero.pos)>spell.Range then return nil,'aim_out_of_range' end
 return {position=aim,unit={x=unit.x,z=unit.z},spread=spread,travel=travel,channel=channel==true,
   hitChance=prediction.HitChance,timeToHit=prediction.TimeToHit}
end
-- Selected champion is exclusive. Otherwise the preferred target is kept unless
-- another in-range enemy is stationary/immobile/channeling or clearly easier.
-- filter(unit) (Combo: health at impact under the menu's limit) narrows every candidate: the selected
-- champion still wins when it passes, otherwise the low enemies in range compete (zgKogMaw, GGAIO).
function KogMawChampion:RTarget(range,gate,filter)
 local selected=_G.SDK.TargetSelector.Selected
  if onScreen(selected)and GetDistance(selected.pos,myHero.pos)<=range then
   if not self:RConsented(selected)then return nil,nil end
   if not filter or filter(selected)then return selected,self:RAim(selected,gate)end
  end
 local preferred=self:PreferredTarget(range)
 local best,bestAim=nil,nil
  if preferred and self:RConsented(preferred)and(not filter or filter(preferred))then
  bestAim=self:RAim(preferred,gate);best=bestAim and preferred
  if bestAim and bestAim.spread<=1 then return best,bestAim end
 end
 local enemies=Core:DecisionUnits('GetEnemyHeroes');local checked=0
 for i=1,math.min(#enemies,10)do local target=enemies[i]
  if checked>=4 then break end
   if target~=preferred and onScreen(target)and target.type==Obj_AI_Hero and self:RConsented(target)and GetDistance(target.pos,myHero.pos)<=range
    and(not filter or filter(target))then
   checked=checked+1
   local aim=self:RAim(target,gate)
   if aim and(not bestAim or aim.spread+60<bestAim.spread)then best,bestAim=target,aim end
  end
 end
 return best,bestAim
end
function KogMawChampion:CastR(target,aim,validate,gate,weave)
 if not target or not aim or not self:SpellAllowed(_R,target,self:RRange())then return false end
 local options={intentTarget=target,range=self:RRange(),validate=validate,prevalidateWorldCast=true}
 if weave then options.ready=weave;options.deferAttackWindup=true end
 -- Resolver: same target, fresh prediction and aim; never a new target or decision loop.
 options.resolve=function()
  local fresh,reason=self:RAim(target,gate)
  if not fresh then return nil,reason end
  local r=self.rOutcome
  if r and r.target==target and not r.castStart then r.aim=fresh end
  return {position=fresh.position,data={targetID=target.networkID,hitChance=fresh.hitChance,spread=fresh.spread}}
 end
 local ok,id=Core:Cast(HK_R,aim.position,options)
 if ok and Core.logger and Core.logger:Wants('r_aim')then self:RRecord(target,aim,id)end
 return ok,id
end
-- Development diagnostic (Core.logger exists only in development family builds):
-- one bounded pending R record; aim at request, actual target position at impact.
function KogMawChampion:RRecord(target,aim,id)
 local current=self.rOutcome
 if current and current.id==id and not current.castStart then current.aim=aim;return end
 local moving=target.pathing and target.pathing.hasMovePath
 self.rOutcome={id=id,target=target,targetID=target.networkID,aim=aim,requestedAt=Game.Timer(),spellName=myHero:GetSpellData(_R).name}
 Core:Trace('r_aim',{id=id,target=target.networkID,profile=self.profile.id,aimX=aim.position.x,aimZ=aim.position.z,
  targetX=target.pos.x,targetZ=target.pos.z,predictedX=aim.unit.x,predictedZ=aim.unit.z,speed=moving and target.ms or 0,
  hitChance=aim.hitChance,delay=self.RSpell.Delay,timeToHit=aim.timeToHit,spread=aim.spread,travel=aim.travel,
  channel=aim.channel,radius=self.RSpell.Radius,bounding=target.boundingRadius})
end
function KogMawChampion:ROutcomeTick()
 local r=self.rOutcome;local now=Game.Timer()
 if not Core.logger then self.rOutcome=nil;return end
 if not r.castStart then
  local cast=myHero.activeSpell
  if cast and cast.valid and cast.name==r.spellName and finite(cast.startTime)and cast.startTime>=r.requestedAt-.05 then
   r.castStart=cast.startTime;r.impactAt=cast.startTime+self.RSpell.Delay
   local placed=cast.placementPos;if placed and finite(placed.x)and finite(placed.z)then r.placedX,r.placedZ=placed.x,placed.z end
   -- Impact timing (KogMaw-9): the target's first health drop after the cast settles rImpact per profile.
   local t=r.target
   if IsValid(t)and finite(t.health)then
    local expected=self:RDamage(t)
    self.rImpact={id=r.id,target=t,targetID=r.targetID,castStart=r.castStart,health=t.health,
     drop=math.max(30,.3*(finite(expected)and expected or 0)),expected=expected,untilAt=r.castStart+2}
   end
  elseif now-r.requestedAt>1.5 then
   self.rOutcome=nil;Core:Trace('r_outcome',{id=r.id,target=r.targetID,profile=self.profile.id,outcome='cast_not_observed'})
  end
  return
 end
 if now<r.impactAt then return end
 self.rOutcome=nil
 local t=r.target;local valid=IsValid(t)and t.networkID==r.targetID
 local ax,az=r.placedX or r.aim.position.x,r.placedZ or r.aim.position.z
 local row={id=r.id,target=r.targetID,profile=self.profile.id,castStart=r.castStart,impactAt=r.impactAt,observedAt=now,
  aimX=ax,aimZ=az,aimSource=r.placedX and 'placementPos' or 'request',radius=self.RSpell.Radius}
 if valid then
  local d=math.sqrt((t.pos.x-ax)^2+(t.pos.z-az)^2);local reach=self.RSpell.Radius+(t.boundingRadius or 0)
  row.targetX=t.pos.x;row.targetZ=t.pos.z;row.distance=d;row.reach=reach;row.hit_estimate=d<=reach
  row.predictionError=math.sqrt((t.pos.x-r.aim.unit.x)^2+(t.pos.z-r.aim.unit.z)^2);row.outcome=d<=reach and 'inside' or 'outside'
 else row.outcome=t and t.dead and 'target_dead' or 'target_not_visible' end
 Core:Trace('r_outcome',row)
end
-- Development only: seconds from the observed R cast start to the target's first health drop of at least
-- 30% of the expected R damage (other damage can land first; `drop` and `expected` let the analysis judge).
function KogMawChampion:RImpactTick()
 local r=self.rImpact;local now=Game.Timer()
 if not Core.logger then self.rImpact=nil;return end
 local t=r.target
 if not IsValid(t)or t.networkID~=r.targetID then
  self.rImpact=nil;Core:Trace('r_impact',{id=r.id,target=r.targetID,profile=self.profile.id,outcome='target_lost',afterCast=now-r.castStart})
  return
 end
 if finite(t.health)and t.health<=r.health-r.drop then
  self.rImpact=nil
  Core:Trace('r_impact',{id=r.id,target=r.targetID,profile=self.profile.id,outcome='health_drop',afterCast=now-r.castStart,
   drop=r.health-t.health,expected=r.expected,assumedDelay=self.RSpell.Delay,radius=self.RSpell.Radius})
  return
 end
 if finite(t.health)and t.health>r.health then r.health=t.health end
 if now>r.untilAt then self.rImpact=nil;Core:Trace('r_impact',{id=r.id,target=r.targetID,profile=self.profile.id,outcome='no_drop',assumedDelay=self.RSpell.Delay})end
end
-- Combat reach: a short margin inside the maximum (the prediction already demands a high hit chance and
-- refuses a target that would leave). Classic Q is unit-targeted and needs none.
function KogMawChampion:CombatRange(slot)
 if slot==_Q then return self.profile.id=='normal'and self.profile.qRange-75 or self.profile.qRange end
 return self.profile.eRange-50
end
-- Attack weaving (GGAIO post-attack, TRUSt OnPostAttack): with the target in attack reach, Q, E and R go
-- into the attack cooldown instead of delaying a ready attack (Normal Q costs a whole attack windup).
-- The request waits inside its deadline; a target leaving reach does not wait.
function KogMawChampion:Leaving(target)
 local path=target.pathing
 if not path or path.hasMovePath~=true or not target.posTo then return false end
 if GetDistance(target.posTo,myHero.pos)<=GetDistance(target.pos,myHero.pos)then return false end
 local reach=_G.SDK.Data:GetAutoAttackRange(myHero,target);local readyIn=Core:AttackReadyIn()
 local windup=_G.SDK.Attack:GetWindup()
 if not finite(reach)or not finite(windup)or not finite(readyIn)then return true end
 return GetDistance(target.pos,myHero.pos)+(target.ms or 0)*(readyIn+windup)>reach
end
function KogMawChampion:CastTime(slot)
 if slot==_Q and self.profile.id=='normal'then local w=myHero.attackData and myHero.attackData.windUpTime;return finite(w)and w or .25 end
 return .25
end
function KogMawChampion:WeaveGate(target,slot)
 if not IsValid(target)or target.type~=Obj_AI_Hero then return nil end
 return function()
  if Core:AttackWindupRemaining()>0 then return false end
  if not IsValid(target)or self:Leaving(target)then return true end
  return(Core:WeaveWindow(self:CastTime(slot),target))
 end
end
-- Normal R at or under the health limit at impact (regeneration projected, as RDamage). Classic's limit
-- defaults to 100 (no execute step).
function KogMawChampion:RLowEnough(target)
 if not IsValid(target)or not finite(target.maxHealth)or target.maxHealth<=0 or not finite(target.health)then return false end
 local impact=OrbamaPrediction:GetImpactTime(self.RSpell,target.pos,myHero)
 if not finite(impact)or impact<0 then return false end
 local hp=math.min(target.maxHealth,target.health+math.max(0,target.hpRegen or 0)*impact)
 return hp/target.maxHealth*100<=Menu.Combo.RHealth:Value()
end
function KogMawChampion:Combat(menu)
 if not self:ManaAllowed(menu)then return end
 for _,entry in ipairs({{_Q,HK_Q},{_E,HK_E}})do
  local slot,key=entry[1],entry[2];local range=self:CombatRange(slot)
  if menu[slot==_Q and 'Q'or 'E']:Value()and IsReady(slot)then
  local target=self:PreferredTarget(range)
  if self:SpellAllowed(slot,target,range,menu)and self:WReserve(slot)then
   -- A lethal Q goes now; the finisher path would take it anyway.
   local gate=not(slot==_Q and self:QLethal(target))and self:WeaveGate(target,slot)or nil
   self:CastPrediction(key,target,range,function()return self:SpellAllowed(slot,target,range,menu)and self:WReserve(slot)end,nil,
    gate and {ready=gate,deferAttackWindup=true}or nil)
  end
  end
 end
 if menu.W:Value()and IsReady(_W)then
  local target=self:PreferredTarget(1000)
  if self:WAllowed(target)then
   Core:Cast(HK_W,nil,{intentTarget=target,range=self:WReach(target),validate=function()
    return menu.W:Value()and self:ManaAllowed(menu)and self:WAllowed(target)
   end})
  end
 end
 local policy=menu==Menu.Combo and true or 'harass'
  if menu.R and menu.R:Value()and self:RAllowed(policy)and self:WReserve(_R)then
  -- Stack-limited Combo and Harass R refuse low-chance moving shots (spread near the edge, a juking target).
  local filter=menu==Menu.Combo and function(unit)return self:RLowEnough(unit)end or nil
  local target,aim=self:RTarget(self:RRange(),true,filter)
   if target and aim then
    self:CastR(target,aim,function()return menu.R:Value()and self:ManaAllowed(menu)and self:RAllowed(policy)and self:WReserve(_R)
     and(not filter or filter(target))end,true,self:WeaveGate(target,_R))
   end
 end
end
function KogMawChampion:Combo()self:Combat(Menu.Combo)end
function KogMawChampion:Harass()self:Combat(Menu.Harass)end
function KogMawChampion:SMR()
  if not Menu.Misc.SMR:Value()or not self:RAllowed('semi')then return end
 local target,aim=self:RTarget(self:RRange(),false)
  self:CastR(target,aim,function()return Menu.Misc.SMR:Value()and self:RAllowed('semi')end,false)
end
function KogMawChampion:RKS()
  if not self:RAllowed('kill')then return end
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,10)do local target=enemies[i]
  if self:RLethal(target)and self:CastR(target,self:RAim(target,false),function()
    return self:RAllowed('kill')and self:RLethal(target)
  end,false)then return end
 end
end
-- Q finisher without a mode key: the shared kill rule at the missile's landing (magic shields, health window).
function KogMawChampion:QLethal(target)
 if not onScreen(target)or target.type~=Obj_AI_Hero or IsInvulnerable(target)then return false end
 local delay=self.profile.id=='normal'and myHero.attackData and myHero.attackData.windUpTime or .25
 if not finite(delay)or delay<0 then return false end
 return(Core:Lethal(target,delay+GetDistance(target.pos,myHero.pos)/self.profile.qSpeed,function()return self:QDamage(target)end,{kind='magical'}))
end
function KogMawChampion:QKS()
 if not IsReady(_Q)then return false end
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,10)do local target=enemies[i]
  if GetDistance(target.pos,myHero.pos)<=self.profile.qRange and self:QLethal(target)
   and self:CastPrediction(HK_Q,target,self.profile.qRange,function()return self:QLethal(target)end)then return true end
 end
 return false
end
-- E under an enemy dashing onto Kog'Maw: the slow field covers the landing and the way out.
function KogMawChampion:AntiDash()
 if not IsReady(_E)then return false end
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,10)do local target=enemies[i]
  if onScreen(target)and target.type==Obj_AI_Hero and Core:ApproachingDash(target,myHero.pos,400)then
   return self:CastPrediction(HK_E,target,self.ESpell.Range,function()return Core:ApproachingDash(target,myHero.pos,400)~=nil end)
  end
 end
 return false
end
-- Flee: E slows the nearest pursuer.
function KogMawChampion:Flee()
 if not IsReady(_E)then return false end
 local enemies=Core:DecisionUnits('GetEnemyHeroes');local best,near
 for i=1,math.min(#enemies,10)do local target=enemies[i]
  if onScreen(target)and target.type==Obj_AI_Hero then
   local d=GetDistance(target.pos,myHero.pos);if d<=900 and(not near or d<near)then best,near=target,d end
  end
 end
 return best~=nil and self:CastPrediction(HK_E,best,1000,function()return GetMode()=='Flee'end)
end
function KogMawChampion:CanRescue(target)
 if not Menu.LastHit.Q:Value()or not self:ManaAllowed(Menu.LastHit)or not self:SpellAllowed(_Q,target,self.profile.qRange)
  or target.type~=Obj_AI_Minion or target.team==300 or _G.SDK.Attack:IsActive()then return false end
 local delay=self.profile.id=='normal'and myHero.attackData and myHero.attackData.windUpTime or .25
 if not finite(delay)then return false end
 local impact=delay+GetDistance(target.pos,myHero.pos)/self.profile.qSpeed
 local damage=self:QDamage(target)
 if damage<target.health+math.max(0,target.shieldAP or 0)+math.max(0,target.hpRegen or 0)*impact then return false end
 local hp=_G.SDK.HealthPrediction:GetPrediction(target,impact)
 if not finite(hp)or hp<=0 or hp>damage then return false end
 if GetDistance(target.pos,myHero.pos)<=myHero.range+myHero.boundingRadius+target.boundingRadius and _G.SDK.Orbwalker:CanAttack()then
  local aa=_G.SDK.Damage:GetAutoAttackDamage(myHero,target,true)
  if aa>=target.health+(target.shieldAD or 0)then return false end
 end
 return true
end
function KogMawChampion:LastHit()
 if not Menu.LastHit.Q:Value()then return end
 local minions=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#minions,32)do local target=minions[i]
  if self:CanRescue(target)and self:CastPrediction(HK_Q,target,self.profile.qRange,function()return self:CanRescue(target)end,OrbamaPrediction.HITCHANCE_NORMAL)then return end
 end
end
function KogMawChampion:FarmPermission(kind,letter)
 local node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear']
 return Core:FarmModeEnabled(kind)and Menu.Clear.SpellFarm:Value()and node[letter]:Value()and self:ManaAllowed(node)
end
function KogMawChampion:FarmQUseful(target)
 if not self:SpellAllowed(_Q,target,self.profile.qRange)or target.type~=Obj_AI_Minion or target.team==300 then return false end
 local delay=self.profile.id=='normal'and myHero.attackData and myHero.attackData.windUpTime or .25
 if not finite(delay)or delay<=0 then return false end
 local impact=OrbamaPrediction:GetImpactTime({Delay=delay,Speed=self.profile.qSpeed},target.pos,myHero)
 if not finite(impact)or impact<0 then return false end
 local damage=self:QDamage(target)
 if damage<target.health+math.max(0,target.shieldAP or 0)+math.max(0,target.hpRegen or 0)*impact then return false end
 local hp=_G.SDK.HealthPrediction:GetPrediction(target,impact)
 if not finite(hp)or hp<=0 or hp>damage then return false end
 local sdk=_G.SDK
 if sdk.Orbwalker:CanAttack()and sdk.Data:IsInAutoAttackRange(myHero,target)then
  local windup,speed=sdk.Attack:GetWindup(),sdk.Attack:GetProjectileSpeed()
  if not finite(windup)or windup<0 or not finite(speed)or speed<=0 then return false end
  local time=windup+math.max(0,GetDistance(target.pos,myHero.pos)-myHero.boundingRadius-target.boundingRadius)/speed
  local aaHP=sdk.HealthPrediction:GetPrediction(target,time)
  if finite(aaHP)and aaHP>0 and aaHP+math.max(0,target.shieldAD or 0)<=sdk.Damage:GetAutoAttackDamage(myHero,target,true)then return false end
 end
 return true
end
function KogMawChampion:EWaveCount(aim)
 if not aim then return 0 end
 local origin=myHero.pos;local dx,dz=aim.x-origin.x,aim.z-origin.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<1 then return 0 end
 dx,dz=dx/length,dz/length
 local list=Core:DecisionUnits('GetEnemyMinions');local predictor=Core:Prediction(self.ESpell);local count,seen,checked=0,{},0
 for i=1,math.min(#list,32)do local unit=list[i];local id=unit and unit.networkID
  if id and not seen[id]and onScreen(unit)and unit.team~=300 and unit.team~=myHero.team
   and GetDistance(unit.pos,origin)<=self.ESpell.Range then
   seen[id]=true;checked=checked+1
   predictor:GetPrediction(unit,myHero)
   if predictor:CanHit(OrbamaPrediction.HITCHANCE_NORMAL)and predictor.UnitPosition then
    local position=predictor.UnitPosition;local x,z=position.x-origin.x,position.z-origin.z
    local along=x*dx+z*dz;local across=x*dz-z*dx;local radius=self.ESpell.Radius+(unit.boundingRadius or 0)
    if along>=0 and along<=self.ESpell.Range and across*across<=radius*radius then
     local impact=OrbamaPrediction:GetImpactTime(self.ESpell,position,myHero)
     local hp=finite(impact)and _G.SDK.HealthPrediction:GetPrediction(unit,impact)
     if finite(hp)and hp>0 then count=count+1 end
    end
   end
   if checked>=24 then break end
  end
 end
 return count
end
function KogMawChampion:Farm(kind)
 local q=self:FarmPermission(kind,'Q')and IsReady(_Q)
 local e=self:FarmPermission(kind,'E')and IsReady(_E)
 local w=kind=='jungle'and self:FarmPermission(kind,'W')and IsReady(_W)
 if not q and not e and not w then return false end
 local list=Core:DecisionUnits(kind=='jungle'and 'GetMonsters'or 'GetEnemyMinions');local rows,seen={},{}
 for i=1,math.min(#list,kind=='jungle'and 16 or 32)do local unit=list[i];local id=unit and unit.networkID
  if id and not seen[id]and onScreen(unit)and unit.team~=myHero.team and(unit.team==300)==(kind=='jungle')
   and GetDistance(unit.pos,myHero.pos)<=self.ESpell.Range then seen[id]=true;rows[#rows+1]=unit end
 end
 table.sort(rows,function(a,b)return a.maxHealth>b.maxHealth end)
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 -- Jungle W on the largest monster in its reach, unless the camp dies to two or three attacks anyway.
 local big=rows[1]
 if w and big then
  local function useful()
   if not self:FarmPermission(kind,'W')or not self:WAllowed(big)then return false end
   local attack=_G.SDK.Damage:GetAutoAttackDamage(myHero,big,true)
   return finite(attack)and big.health>attack*3
  end
  if useful()and Core:Cast(HK_W,nil,{intentTarget=big,range=self:WReach(big),context=context,validate=useful})then return true end
 end
 local attempts=0
 for i=1,#rows do local target=rows[i]
  if q and self:SpellAllowed(_Q,target,self.profile.qRange)and(kind=='jungle'or self:FarmQUseful(target))then
   attempts=attempts+1
   if self:CastPrediction(HK_Q,target,self.profile.qRange,function()
    return self:FarmPermission(kind,'Q')and(kind=='jungle'or self:FarmQUseful(target))end,OrbamaPrediction.HITCHANCE_NORMAL,{context=context})then return true end
   if attempts>=3 then break end
  end
 end
 for i=1,math.min(#rows,3)do local target=rows[i]
  if e then
   local minimum=kind=='lane'and Menu.Clear.LaneClear.ECount:Value()or 1
   local predictor=Core:Prediction(self.ESpell);predictor:GetPrediction(target,myHero)
   if predictor:CanHit(OrbamaPrediction.HITCHANCE_NORMAL)and(kind=='jungle'or self:EWaveCount(predictor.CastPosition)>=minimum)then
    if self:CastPrediction(HK_E,target,self.ESpell.Range,function(request,resolved)
     return self:FarmPermission(kind,'E')and(kind=='jungle'or self:EWaveCount(resolved and resolved.position or request.target)>=Menu.Clear.LaneClear.ECount:Value())
    end,OrbamaPrediction.HITCHANCE_NORMAL,{context=context})then return true end
   end
  end
 end
 return false
end
function KogMawChampion:LaneClear()return self:Farm('lane')end
function KogMawChampion:JungleClear()return self:Farm('jungle')end
function KogMawChampion:OnTick()
  if Game.Timer()>=(self.nextConsent or 0)then self:DiscoverRConsent()end
 if self.rOutcome then self:ROutcomeTick()end
 if self.rImpact then self:RImpactTick()end
 if Core.logger and self.profile.id=='classic'then self:QTransportTrace()end
 -- Before the dead-state early return: the death passive is the one thing to do while dead.
 self:Pursue()
 if IsReady(_R)then self:TrackMotion()end
 if ShouldWait()or IsCasting()then return end
 -- The cheap kill first: R costs more with every stack.
 if not self:QKS()then self:RKS()end
 self:AntiDash()
 if Menu.Misc.SMR:Value()then self:SMR()end
 local mode=GetMode()
  if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()
  elseif mode=='LaneClear'then if not self:LaneClear()then self:JungleClear()end end
end
-- Health-bar damage (S9): one attack plus ready Q and R.
function KogMawChampion:ComboDamage(u)
 local aa=_G.SDK.Damage:GetAutoAttackDamage(myHero,u)
 if not finite(aa)or aa<0 then aa=0 end
 local damage=aa
 if IsReady(_Q)then damage=damage+self:QDamage(u)end
 if IsReady(_R)and u.type==Obj_AI_Hero then damage=damage+self:RDamage(u)end
 return damage,true
end
-- Icathian Surprise (death passive). While its buff runs and a mode key is held, the orbwalker walks to
-- the point whose explosion catches the most enemy champions at their positions when it goes off, a
-- lethal one counting three times (true damage from the profile, the shared kill rule). Without a mode
-- key the player's own clicks move Kog'Maw. Classic: no known radius, so only the development trace runs.
local PASSIVE_OWNER='KogMawPassive'
function KogMawChampion:PassiveExpiry()
 local names=self.profile.passive and self.profile.passive.buffs;local count=myHero.buffCount
 if not names or not finite(count)or count<0 or count>128 or count%1~=0 then return nil end
 local now=Game.Timer()
 for i=0,count do local b=myHero:GetBuff(i);local name=b and type(b.name)=='string'and b.name:lower()
  if name and names[name]and(not finite(b.count)or b.count>0)then
   local expiry=buffExpiry(b)
   if finite(expiry)and expiry>now then return expiry,b.name end
  end
 end
 return nil
end
function KogMawChampion:PassiveDamage()
 local p=self.profile.passive;if not p or not p.damageStart then return nil end
 local level=myHero.levelData and myHero.levelData.lvl
 if not finite(level)then return p.damageStart end
 level=math.max(1,math.min(18,level))
 return p.damageStart+(p.damageEnd-p.damageStart)*(level-1)/17
end
function KogMawChampion:PursuitPoint(remaining)
 local radius=self.profile.passive.radius;local speed=myHero.ms
 if not finite(speed)or speed<=0 or not finite(remaining)or remaining<=0 then return nil end
 local reach=speed*remaining
 local enemies=Core:DecisionUnits('GetEnemyHeroes');local points={};local nearest,near
 for i=1,math.min(#enemies,10)do local u=enemies[i]
  if #points>=5 then break end
  if IsValid(u)and u.team~=myHero.team and u.pos and GetDistance(u.pos,myHero.pos)<=reach+radius+600 then
   local x,z=u.pos.x,u.pos.z
   local to=u.pathing and u.pathing.hasMovePath and u.posTo
   if to and finite(u.ms)then
    local dx,dz=to.x-x,to.z-z;local l=math.sqrt(dx*dx+dz*dz);local step=math.min(l,u.ms*remaining)
    if l>1 then x,z=x+dx/l*step,z+dz/l*step end
   end
   local lethal=Core:Lethal(u,remaining,function()return self:PassiveDamage()end,{kind='true',protection=false})
   points[#points+1]={x=x,z=z,weight=lethal and 3 or 1,unit=u}
   local d=(x-myHero.pos.x)^2+(z-myHero.pos.z)^2
   if not near or d<near then nearest,near=points[#points],d end
  end
 end
 if #points==0 then return nil end
 local aim,weight=Core:BestAim(points,{kind='circle',radius=radius-50,range=reach})
 -- Nobody can be reached in time: still close in on the nearest (the explosion may catch a chaser).
 if not aim or not weight or weight<=0 then aim=nearest end
 return Vector(aim.x,myHero.pos.y,aim.z)
end
function KogMawChampion:PassiveTrace(p,phase)
 if not Core.logger then return end
 local now=Game.Timer()
 if phase=='start'then
  p.health={};local enemies=Core:DecisionUnits('GetEnemyHeroes');local nearby=0
  for i=1,math.min(#enemies,10)do local u=enemies[i]
   if IsValid(u)and u.team~=myHero.team and GetDistance(u.pos,myHero.pos)<=900 and nearby<5 then
    nearby=nearby+1;p.health[#p.health+1]={unit=u,id=u.networkID,health=u.health}
   end
  end
  Core:Trace('kogmaw_passive',{phase='start',profile=self.profile.id,buff=p.name,dead=p.dead,remaining=p.expiry-now,nearby=nearby})
  return
 end
 local lost,most,within=0,0,0
 for _,row in ipairs(p.health or {})do local u=row.unit
  if IsValid(u)and u.networkID==row.id and finite(u.health)then
   local d=row.health-u.health;if d>0 then lost=lost+d;most=math.max(most,d)end
   if GetDistance(u.pos,myHero.pos)<=500 then within=within+1 end
  end
 end
 Core:Trace('kogmaw_passive',{phase='end',profile=self.profile.id,buff=p.name,duration=now-p.startAt,dead=myHero.dead==true,
  healthLost=lost,largestLoss=most,enemiesWithin500=within,expectedDamage=self:PassiveDamage()})
end
function KogMawChampion:Pursue()
 local now=Game.Timer();local p=self.passive
 if not p and now<(self.passiveCheckAt or 0)then return end
 self.passiveCheckAt=now+.1
 local expiry,name=self:PassiveExpiry()
 if not expiry then
  if p then self.passive=nil;Core:ReleaseMovePreference(PASSIVE_OWNER);self:PassiveTrace(p,'end')end
  return
 end
 if not p then p={startAt=now,expiry=expiry,name=name,dead=myHero.dead==true};self.passive=p;self:PassiveTrace(p,'start')end
 p.expiry=expiry
 if not self.profile.passive.radius or not Menu.Misc.Pursuit or not Menu.Misc.Pursuit:Value()or not GetMode()then
  Core:ReleaseMovePreference(PASSIVE_OWNER);return
 end
 local aim=self:PursuitPoint(expiry-now)
 if aim then Core:PreferMove(PASSIVE_OWNER,aim,.3)else Core:ReleaseMovePreference(PASSIVE_OWNER)end
end
-- Development only (KogMaw-8): how the host sends Classic Q. A unit handle in `target` with no distant
-- placement point means the asset's targeted missile; a placement point beyond 625 means a line.
function KogMawChampion:QTransportTrace()
 local cast=myHero.activeSpell
 if not cast or not cast.valid or not finite(cast.startTime)or cast.startTime==self.qTraceStart then return end
 local q=myHero:GetSpellData(_Q);if not q or cast.name~=q.name then return end
 self.qTraceStart=cast.startTime
 local row={profile=self.profile.id,spell=cast.name,startTime=cast.startTime}
 local target=cast.target
 if type(target)=='number'then
  row.target=target
  local enemies=Core:DecisionUnits('GetEnemyHeroes')
  for i=1,math.min(#enemies,10)do local u=enemies[i]
   if u and(u.handle==target or u.networkID==target)then row.targetDistance=GetDistance(u.pos,myHero.pos);break end
  end
 end
 local placed=cast.placementPos
 if placed and finite(placed.x)and finite(placed.z)then row.placedX,row.placedZ=placed.x,placed.z;row.placedDistance=GetDistance(placed,myHero.pos)end
 local finish=cast.endPos
 if finish and finite(finish.x)and finite(finish.z)then row.endDistance=GetDistance(finish,myHero.pos)end
 Core:Trace('kogmaw_q_transport',row)
end
function KogMawChampion:Draw()
 if myHero.dead then return end
 for _,entry in ipairs({{'Q',_Q,self.profile.qRange},{'E',_E,self.ESpell.Range},{'R',_R,self:RRange()}})do
  if Menu.Draw[entry[1]]:Value()and IsReady(entry[2])then Draw.Circle(myHero.pos,entry[3],1,Draw.Color(255,66,244,113))end
 end
end
function KogMawChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},w={node=Menu.Combo.W,label='Combo W'},e={node=Menu.Combo.E,label='Combo E'},r={node=Menu.Combo.R,label='Combo R'},
  stacks={node=Menu.Combo.Rstacks,label='Combo R stack limit'},mana={node=Menu.Misc.Rmana,label='R mana reserve'},semi={node=Menu.Misc.SMR,label='Hold R assist'},
  last={node=Menu.LastHit.Q,label='Last Hit Q'},harass={node=Menu.Harass.Mana,label='Harass mana minimum'},
  whold={node=Menu.Misc.WHold,label='Only attack during W'}}
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'KogMaw: quick start','KogMaw: artillery','KogMaw: attacks and farming'},function(page)
  if page==1 then return {title=self.profile.id=='classic'and 'Classic KogMaw'or 'KogMaw',subtitle='Use your provider mode keys.',cards={
   {'COMBAT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..' for [[q]], [[w]], [[e]] and [[r]]. Q and E keep a margin inside their maximum reach, even for an attack target or selected champion.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. Separate spell switches and [[harass]] control spending. Release the mode to cancel waiting casts.'},
   {'Q PROFILE',self.profile.id=='normal'and 'Q stops on the first enemy. Minions, champions and wind walls can block it. Its cast timing follows the current attack frame.'or 'Classic Q uses the asset-backed 625-range targeted missile path. Live host transport and interception still need acceptance trials.'}},note='A valid selected champion takes precedence within reach; dead or distant attack targets do not suppress alternatives.'}end
  if page==2 then return {title='Living Artillery',subtitle='Current range, mana and live stacks are checked again before sending.',cards={
   {'ASSIST','Hold [[semi]] to aim R at the preferred target. A lethal Q, else a lethal R, is cast without a mode key when the damage estimate beats health, regeneration and magic shields. E answers an enemy dashing onto you and slows the nearest pursuer while fleeing.'},
    {'COST','[[stacks]] limits Combo R (Harass R has its own limit); held assistance and lethal R ignore it. [[mana]] applies to every R path except a lethal one. R target consent filters every path and is checked again before sending. Expired cost buffs are ignored; unreadable active cost evidence refuses R.'},
   {'DAMAGE',self.profile.id=='normal'and 'Normal R gains damage against missing health and doubles below 40% health. Regeneration can remove that threshold before impact.'or 'Classic R uses its separate champion damage and 1400/1700/2000 ranges. It does not borrow Normal missing-health scaling.'}},note='R is aimed where the target will be at impact; a target that just changed direction is skipped in Combo.'}end
  return {title='Attacks and farming',subtitle='W extends attack reach; the provider owns attack timing and movement.',cards={
   {'W','W requires a living target in its extended reach. A live W buff prevents a repeat. [[whold]] optionally pauses Q, E and R during W; it never creates imaginary attacks or resets.'},
   {'LAST HIT','Enable [[last]] and hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT)..' to rescue a Q-lethal minion. A current windup, confirmed incoming lethal damage or a ready lethal attack prevents Q.'},
    {'SPELL FARMING','Lane and jungle Q/E have separate switches behind the spell-farm toggle. Lane E counts future minion centers on its actual outgoing ray. Lane Q only rescues a Q-lethal minion when a ready attack cannot secure it.'}},note='Q, E and R wait for the attack cooldown when the target is in attack range, and leave the mana for W.'}
 end,cfg,links,activate)
end
Core:StandardPolicy(KogMawChampion,{
 methods={RKS=function()return {priority='interactive'}end,QKS=function()return {priority='interactive'}end,
  AntiDash=function()return {priority='interactive'}end,
  SMR=function()return Core:HeldContext(function()return Menu.Misc.SMR:Value()end)end},
 exceptions={non_interrupting_summoner=true},
 validate=function(self,q,slot)
  if(slot==_Q or slot==_E or slot==_R)and Menu.Misc.WHold:Value()and self:BuffCount(self.profile.wBuff)~=0 then return false end
   if slot==_R then local policy=q.owner=='Combo'and true or q.owner=='Harass'and 'harass'or q.owner=='SMR'and 'semi'or q.owner=='RKS'and 'kill'or false
    return self:RAllowed(policy)and q.object and self:RConsented(q.object)and GetDistance(q.object.pos,myHero.pos)<=self:RRange()end
  return true
 end,
})
KogMawChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_KogMaw"]="KogMaw"}
local normalSupported={["KogMaw"]=true}

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
