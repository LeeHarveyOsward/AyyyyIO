return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Karthus"]=function()return _G.OrbamaFamily:Require("7ab9b15ab2148550fa10ffdb7f7c6fc9c39c59bf69f1c52aed2d443761603261")()end
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
if champion=="Karthus" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Karthus',profiles={normal=true,classic=true},
 Create=function(context)
-- Explicit Normal/Classic values are maintained in CombatProfiles/abilities.lua.
local P=assert(AbilityProfiles.controllers.Karthus[myHero.charName],'Unsupported Karthus profile')
-- Additions from the 2026-10-10 ranking work (detonation window, Requiem fog bound): CombatProfiles/ChampionProfiles.
local X=assert(ChampionProfiles('Karthus')[myHero.charName],'Unsupported Karthus profile')
local finite,manaAbove=Core.finite,Core.manaAbove
local function enemy(u)return IsValid(u)and u.pos~=nil and u.team~=myHero.team end
local function onScreen(u)return enemy(u)and u.pos:ToScreen().onScreen end
local function still(u)return u.pathing~=nil and u.pathing.hasMovePath==false and not u.pathing.isDashing end
local function copy(t)local o={};for k,v in pairs(t)do o[k]=v end;return o end
-- Rescue order: super, then siege (cannon) minions, then the larger maximum health, then the lower health.
local function minionValue(u)
 local name=type(u.charName)=='string'and u.charName:lower()or ''
 return name:find('super',1,true)and 3 or(name:find('siege',1,true)or name:find('cannon',1,true))and 2 or 1
end
local function byValue(a,b)
 local va,vb=minionValue(a),minionValue(b);if va~=vb then return va>vb end
 local ma,mb=finite(a.maxHealth)and a.maxHealth or 0,finite(b.maxHealth)and b.maxHealth or 0;if ma~=mb then return ma>mb end
 local ha,hb=finite(a.health)and a.health or 0,finite(b.health)and b.health or 0;if ha~=hb then return ha<hb end
 return(a.networkID or 0)<(b.networkID or 0)
end
local KarthusChampion=class("KarthusChampion")
function KarthusChampion:__init()
 self.profile=P;self.extra=X
 -- Delay is cast time plus detonation. Normal detonation is a window (wiki V26.03: 0.528-0.759 s): QSpell plans
 -- the late end, QSpellEarly the early end, and an aim must hold the target at both. The provider adds latency once.
 self.QSpell=copy(AbilityProfiles.Spell(myHero.charName,'Q',OrbamaPrediction));self.QSpell.Delay=P.qCast+X.qDetonateMax
 if X.qDetonateMin<X.qDetonateMax then self.QSpellEarly=copy(self.QSpell);self.QSpellEarly.Delay=P.qCast+X.qDetonateMin end
 -- Wall thickness is not established; the asset castRadius is a conservative tolerance.
 self.WSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=P.wCast,Radius=100,Range=P.wRange,Speed=math.huge,Collision=false}
 self.ESpell={Range=P.eRadius}
 self.RImpact={Delay=P.rCast+P.rChannel,Speed=math.huge,Range=25000}
 self.recallCast={key=HK_R,spell=self.RImpact,selfCast=true,
  enabled=function()return Menu.R.Auto:Value()and Menu.R.BaseR:Value()and Menu.R.Count:Value()==1 end,
  safe=function()return self:RecallSafe()end,damage=function(u)return self:RDamage(u)end,
  submitted=function(q)self.rRequest=q end}
 self.eOwned=false;self.eIdleSince=nil;self.rPreview=nil;self.locked=false
 self.comboTargetExpire=0
 -- Core:Rescue with the 'ready' attack rule: Lay Waste is Karthus's farming tool (a one-second cooldown
 -- against a slow attack), so only an attack that is ready, in range and lethal on landing keeps the minion.
 self.rescueRule={attack='ready',attackDamage=function(u)return _G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)end}
 -- Death Defied: Karthus cannot attack, so the attack is never weighed.
 self.zombieRule={attack=false}
 self:LoadMenu()
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 Core:RegisterCleanup('Karthus',function()
  self.rPreview=nil;self.rRequest=nil;self.rUntil=nil;self.eRequest=nil;self.eOwned=false;self.eIdleSince=nil
  self.comboTarget=nil;self.comboTargetExpire=0;self.locked=false;self.qTrace=nil;self.wTrace=nil
  _G.SDK.Orbwalker:SetAttack(true);_G.SDK.Orbwalker:SetMovement(true)
 end)
 local ok,why=Core:RegisterPreparation('Karthus.requiem',{intervalMs=125,maxDelayMs=450,units=2,maxUnits=2},
  function()self:PrepareRPreview();return true end,
  function()return Menu.Draw.Kills:Value()and myHero:GetSpellData(_R).level>0 end,function()self.rPreview=nil end)
 self.previewFallback=not ok and why=='unsupported'
 -- Health-bar damage: a ready Q (not isolated), a ready R and one attack. Isolation and fog are not modelled here.
 Core:RegisterComboDamage(function(u)
  local total=_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0
  if self:Ready(_Q)then total=total+self:QDamage(u,false)end
  if self:Ready(_R)then total=total+self:RDamage(u)end
  return total,true
 end)
end
function KarthusChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id="Classic_AIO_"..myHero.charName,name="AyyyyIO - Karthus"})
 Menu:MenuElement({type=MENU,id='Combo',name='Combo'})
 Menu.Combo:MenuElement({id='Q',name='Use Q',value=true})
 Menu.Combo:MenuElement({id='W',name='Use W',value=true})
 Menu.Combo:MenuElement({id='E',name='Use E near enemy champions',value=true})
 Menu.Combo:MenuElement({id='EMana',name='E only above mana %',value=10,min=0,max=100,step=5,menu=false})
 Menu:MenuElement({type=MENU,id='Harass',name='Harass'})
 Menu.Harass:MenuElement({id='Q',name='Use Q',value=true})
 Menu.Harass:MenuElement({id='E',name='Use E near enemy champions',value=true})
 Menu.Harass:MenuElement({id='Mana',name='Only above mana %',value=35,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',toggle=true,value=SpellFarmDefault(),key=73,callback=function(v)
  if CheckChatBlock(Menu.Clear.SpellFarm,v)then return end end})
 Menu.Clear:MenuElement({type=MENU,id='LaneClear',name='Lane clear'})
 Menu.Clear.LaneClear:MenuElement({id='Q',name='Use Q to last hit',value=true})
 Menu.Clear.LaneClear:MenuElement({id='QWave',name='Also Q the wave when nothing dies',value=true})
 Menu.Clear.LaneClear:MenuElement({id='QCount',name='Lane minions that Q must hit',value=3,min=2,max=6,step=1})
 Menu.Clear.LaneClear:MenuElement({id='E',name='Use E',value=true})
 Menu.Clear.LaneClear:MenuElement({id='ECount',name='Lane minions E must hit',value=4,min=1,max=8,step=1})
 Menu.Clear.LaneClear:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 Menu.Clear:MenuElement({type=MENU,id='JungleClear',name='Jungle clear'})
 Menu.Clear.JungleClear:MenuElement({id='Q',name='Use Q',value=true})
 Menu.Clear.JungleClear:MenuElement({id='E',name='Use E',value=true})
 Menu.Clear.JungleClear:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack would miss',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=25,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Flee',name='Flee'})
 Menu.Flee:MenuElement({id='W',name='Use W on the nearest chaser',value=true})
 Menu:MenuElement({type=MENU,id='Auto',name='Behaviour'})
 Menu.Auto:MenuElement({id='QImmobile',name='Q immobilised enemies without a mode key',value=true})
 Menu.Auto:MenuElement({id='Mana',name='That Q only above mana %',value=20,min=0,max=100,step=5})
 Menu.Auto:MenuElement({id='ReactiveW',name='W dashing or immobile enemies and melee attackers',value=true})
 Menu.Auto:MenuElement({id='WMana',name='That W only above mana %',value=40,min=0,max=100,step=5})
 Menu.Auto:MenuElement({id='WKey',name='Cast W at the target',key=string.byte('U')})
 Menu:MenuElement({type=MENU,id='R',name='R (Requiem)'})
 Menu.R:MenuElement({id='Auto',name='Cast R when it kills, without a mode key',value=true})
 Menu.R:MenuElement({id='BaseR',name='R a killable enemy who is recalling',value=true})
 Menu.R:MenuElement({id='Count',name='Kills R must get',value=1,min=1,max=5,step=1})
 Menu.R:MenuElement({id='Safe',name='Only with no enemy within (0 = off)',value=1100,min=0,max=2500,step=50})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Q',name='Q range',value=false})
 Menu.Draw:MenuElement({id='W',name='W range',value=false})
 Menu.Draw:MenuElement({id='E',name='E range',value=false})
  Menu.Draw:MenuElement({id='Kills',name='R damage against each enemy',value=true})
end
-- Own buff read with bounded count; expiry uses expireTime, then endTime.
function KarthusChampion:Buff(unit,alias)
 local count=unit and unit.buffCount
 if not finite(count)or count<0 or count>128 or count%1~=0 then return nil end
 for i=0,count do local b=unit:GetBuff(i)
  if b and type(b.name)=='string'and finite(b.count)and b.count>0 and b.name:lower()==alias then
   local expiry=Core.buffExpiry(b)
   if not finite(expiry)then return b,nil end
   if expiry>Game.Timer()then return b,expiry end
  end
 end
end
-- Death Defied: present, plus remaining seconds only when expiry is readable.
function KarthusChampion:Passive()
 local b,expiry=self:Buff(myHero,P.passive)
 if not b then return false end
 return true,expiry and expiry-Game.Timer()or nil
end
function KarthusChampion:Ready(slot)
 local d=myHero:GetSpellData(slot)
 if not d or(d.level or 0)<1 or Game.CanUseSpell(slot)~=0 or(d.currentCd or 0)>0 then return false end
 return self:Passive()or not finite(d.mana)or d.mana<=myHero.mana
end
-- Defile state from the native toggle (1 off, 2 on; GoS host convention). Any other
-- value is unknown and disables automatic toggling rather than guessing.
function KarthusChampion:EState()
 local d=myHero:GetSpellData(_E);local t=d and d.toggleState
 if(d and d.level or 0)<1 then return nil end
 if t==2 then return 'on'elseif t==1 then return 'off'end
 return nil
end
function KarthusChampion:QDamage(target,isolated)
 local rank=myHero:GetSpellData(_Q).level;local base=P.qBase[rank]
 if not base or not enemy(target)then return 0 end
 local raw=(base+P.qAP*myHero.ap)*(isolated and 2 or 1)
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
function KarthusChampion:RDamage(target)
 local rank=myHero:GetSpellData(_R).level;local base=P.rBase[rank]
 if not base then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+P.rAP*myHero.ap)
end
-- Late end of the detonation window (regeneration, champion kill checks); the early end is the first moment the
-- blast may land, so a minion must also be lethal there (Rescue holds at both ends).
function KarthusChampion:QImpact()return OrbamaPrediction:GetImpactTime(self.QSpell,myHero.pos,myHero)end
function KarthusChampion:QImpactEarly()return OrbamaPrediction:GetImpactTime(self.QSpellEarly or self.QSpell,myHero.pos,myHero)end
function KarthusChampion:QKills(target,isolated,rule)
 local function damage()return self:QDamage(target,isolated)end
 if not Core:Rescue(target,self:QImpactEarly(),damage,rule)then return false end
 return not self.QSpellEarly or Core:Rescue(target,self:QImpact(),damage,rule)
end
function KarthusChampion:QReach()return P.qRange+P.qRadius end
-- Bounded neighborhood of other enemy units near a predicted point. Movement slack is
-- conservative: an isolation claim must survive the blast delay.
function KarthusChampion:Neighbors(target,at)
 local out={};local scanned=0;local reach=P.qRadius*2+300
 for _,method in ipairs({'GetEnemyHeroes','GetEnemyMinions','GetMonsters'})do
  local list=Core:DecisionUnits(method)
  for i=1,#list do local u=list[i];scanned=scanned+1
   if scanned>96 then return nil end
   if u~=target and enemy(u)and u.networkID~=target.networkID then
    local dx,dz=u.pos.x-at.x,u.pos.z-at.z
    if dx*dx+dz*dz<=reach*reach then
     local slack=still(u)and 0 or math.min(math.max(0,u.ms or 0)*self.QSpell.Delay,300)
     out[#out+1]={x=u.pos.x,z=u.pos.z,r=(u.boundingRadius or 45)+slack}
     if #out>16 then return nil end
    end
   end
  end
 end
 return out
end
local function isolated(others,x,z)
 if not others then return false end
 for i=1,#others do local o=others[i];local reach=P.qRadius+o.r
  if(o.x-x)^2+(o.z-z)^2<=reach*reach then return false end
 end
 return true
end
-- Fresh Q aim for one target: prediction, then a bounded search (16 centers) for a
-- blast that keeps the predicted target inside while excluding other units.
-- One prediction copied out of the provider object (two settings may share it).
local function predictQ(settings,target,hc)
 local pred=Core:Prediction(settings);pred:GetPrediction(target,myHero)
 if not pred:CanHit(hc)then return nil,'prediction_declined'end
 local cast,unit=pred.CastPosition,pred.UnitPosition
 if not cast or not unit or not finite(cast.x)or not finite(cast.z)or not finite(unit.x)or not finite(unit.z)then return nil,'prediction_missing'end
 return {x=cast.x,z=cast.z,ux=unit.x,uz=unit.z,hitChance=pred.HitChance}
end
function KarthusChampion:QAim(target,hc,isolate)
 if not onScreen(target)then return nil,'target_invalid'end
 local late,why=predictQ(self.QSpell,target,hc);if not late then return nil,why end
 local early=late
 if self.QSpellEarly then early,why=predictQ(self.QSpellEarly,target,hc);if not early then return nil,why end end
 local r2=P.qRadius*P.qRadius
 -- The blast must hold the predicted target at both ends of the detonation window.
 local function covers(x,z)return(x-late.ux)^2+(z-late.uz)^2<=r2 and(x-early.ux)^2+(z-early.uz)^2<=r2 end
 local unit={x=(late.ux+early.ux)/2,z=(late.uz+early.uz)/2}
 local hx,hz=myHero.pos.x,myHero.pos.z;local range2=P.qRange*P.qRange
 local others=self:Neighbors(target,unit)
 local x,z=late.x,late.z
 if early~=late and not covers(x,z)then x,z=(late.x+early.x)/2,(late.z+early.z)/2 end
 local alone,offset=isolated(others,x,z),0
 if isolate and not alone and others then
  for _,off in ipairs({60,100})do
   for k=0,7 do local a=k*math.pi/4;local cx,cz=unit.x+math.cos(a)*off,unit.z+math.sin(a)*off
    if(cx-hx)^2+(cz-hz)^2<=range2 and covers(cx,cz)and isolated(others,cx,cz)then x,z,alone,offset=cx,cz,true,off;break end
   end
   if offset>0 then break end
  end
 end
 if not covers(x,z)then return nil,'target_outside_blast'end
 if(x-hx)^2+(z-hz)^2>range2+1 then return nil,'aim_out_of_range'end
 local spread=math.sqrt((late.ux-early.ux)^2+(late.uz-early.uz)^2)
 return {position=Vector(x,myHero.pos.y,z),data={targetID=target.networkID,isolated=alone,offset=offset,hitChance=late.hitChance,spread=spread}}
end
-- Segment intersection on the ground plane (a->b against c->d).
local function crosses(ax,az,bx,bz,cx,cz,dx,dz)
 local function side(px,pz,qx,qz,rx,rz)return(qx-px)*(rz-pz)-(qz-pz)*(rx-px)end
 local d1,d2=side(cx,cz,dx,dz,ax,az),side(cx,cz,dx,dz,bx,bz)
 local d3,d4=side(ax,az,bx,bz,cx,cz),side(ax,az,bx,bz,dx,dz)
 return(d1>0)~=(d2>0)and(d3>0)~=(d4>0)
end
-- Wall of Pain across the escape path: a target moving away gets the wall ahead of it on its path, one approaching
-- gets it between it and Karthus, a still (or `direct`) target gets it on its predicted position. The wall is
-- perpendicular to Karthus->centre (wiki V26.03) with the rank length; a moved centre is kept only when the target's
-- next second of path crosses that segment, otherwise the aim falls back onto the target.
function KarthusChampion:WAim(target,direct)
 if not onScreen(target)then return nil,'target_invalid'end
 local pred=Core:Prediction(self.WSpell);pred:GetPrediction(target,myHero)
 if not pred:CanHit(OrbamaPrediction.HITCHANCE_NORMAL)then return nil,'prediction_declined'end
 local c=pred.CastPosition
 if not c or not finite(c.x)or not finite(c.z)then return nil,'prediction_missing'end
 local hx,hz=myHero.pos.x,myHero.pos.z;local x,z,kind=c.x,c.z,'on_target'
 local path=target.pathing;local ms=target.ms;local endPos=path and path.endPos
 if not direct and path and path.hasMovePath==true and not path.isDashing and endPos and finite(endPos.x)and finite(endPos.z)and finite(ms)and ms>0 then
  local dx,dz=endPos.x-target.pos.x,endPos.z-target.pos.z;local len=math.sqrt(dx*dx+dz*dz)
  local rx,rz=target.pos.x-hx,target.pos.z-hz;local rl=math.sqrt(rx*rx+rz*rz)
  if len>1 and rl>1 then dx,dz=dx/len,dz/len
   local offset=(target.boundingRadius or 65)+ms*.25+50;local mx,mz
   if dx*rx+dz*rz>0 then mx,mz,kind=c.x+dx*offset,c.z+dz*offset,'ahead'
   else mx,mz,kind=c.x-rx/rl*offset,c.z-rz/rl*offset,'between'end
   local d=math.sqrt((mx-hx)^2+(mz-hz)^2)
   if d>P.wRange then mx,mz=hx+(mx-hx)/d*P.wRange,hz+(mz-hz)/d*P.wRange;d=P.wRange end
   local half=(P.wLength[myHero:GetSpellData(_W).level]or P.wLength[1])/2
   local travel=math.min(ms,len)
   if d>1 and crosses(target.pos.x,target.pos.z,target.pos.x+dx*travel,target.pos.z+dz*travel,
     mx-(mz-hz)/d*half,mz+(mx-hx)/d*half,mx+(mz-hz)/d*half,mz-(mx-hx)/d*half)then x,z=mx,mz
   else kind='on_target'end
  end
 end
 if(x-hx)^2+(z-hz)^2>P.wRange*P.wRange+1 then return nil,'aim_out_of_range'end
 return {position=Vector(x,myHero.pos.y,z),data={targetID=target.networkID,kind=kind}}
end
-- One prepared world-cast path: fresh aim before positioning, same target only.
function KarthusChampion:CastAim(key,target,aimFn,maxRange,reach,validate,owner)
 local aim=aimFn()
 if not aim then return false end
 return Core:Cast(key,aim.position,{owner=owner,intentTarget=target,range=reach,prevalidateWorldCast=true,
  resolve=function()return aimFn()end,
  validate=function(q,resolved)
   local p=resolved and resolved.position or q.target
   if not p or GetDistance(p,myHero.pos)>maxRange+1 then return false,'point_out_of_range'end
    if validate then return validate(resolved and resolved.data or aim.data,p)end
   return true
  end})
end
function KarthusChampion:CastQ(target,hc,isolate,validate,owner)
 if not self:Ready(_Q)or not onScreen(target)or GetDistance(target.pos,myHero.pos)>self:QReach()then return false end
 local ok,id=self:CastAim(HK_Q,target,function()return self:QAim(target,hc,isolate)end,P.qRange,self:QReach(),validate,owner)
 if ok and Core.logger and Core.lastIntent and Core.lastIntent.key==HK_Q then self.qTrace={q=Core.lastIntent,unit=target,expires=Game.Timer()+2}end
 return ok,id
end
function KarthusChampion:CastW(target,validate,owner,direct)
 if not self:Ready(_W)or not onScreen(target)or GetDistance(target.pos,myHero.pos)>P.wRange then return false end
 local ok,id=self:CastAim(HK_W,target,function()return self:WAim(target,direct)end,P.wRange,P.wRange+50,validate,owner)
 if ok and Core.logger and Core.lastIntent and Core.lastIntent.key==HK_W then self.wTrace={q=Core.lastIntent,unit=target,expires=Game.Timer()+2}end
 return ok,id
end
-- Development evidence only (no recorder in public builds): Lay Waste detonation time from the observed cast start
-- to the target's first health drop, and whether a wall cast onto a target slows it (spawn overlap). Bounded to one
-- pending sample each; nothing here authorizes a cast.
function KarthusChampion:TraceEvidence()
 local now=Game.Timer();local t=self.qTrace
 if t then
  local q,u=t.q,t.unit
  if now>t.expires or not IsValid(u)then self.qTrace=nil
  elseif q.observedAt and not t.start then
   local s=myHero.activeSpell
   t.start=s and s.valid and finite(s.startTime)and s.startTime or now;t.health=u.health;t.expires=t.start+1.5
  elseif t.start and finite(u.health)and t.health and u.health<t.health-1 then
   Core:Trace('karthus_q_detonation',{profile=P.id,delay=now-t.start,drop=t.health-u.health,target=u.networkID});self.qTrace=nil
  end
 end
 local w=self.wTrace
 if w then
  local q,u=w.q,w.unit
  if now>w.expires or not IsValid(u)then self.wTrace=nil
  elseif q.observedAt and not w.at then w.at=now;w.moving=u.pathing and u.pathing.hasMovePath==true
  elseif w.at and now-w.at>=.6 then
   local slowed=false;local count=u.buffCount
   if finite(count)and count>=0 and count<=128 then for i=0,count do local b=u:GetBuff(i);if b and b.type==10 and finite(b.count)and b.count>0 then slowed=true;break end end end
   Core:Trace('karthus_w_overlap',{profile=P.id,slowed=slowed,moving=w.moving,distance=q.target and GetDistance(q.target,u.pos)or nil});self.wTrace=nil
  end
 end
end
function KarthusChampion:Hit(menu)return menu==Menu.Harass and OrbamaPrediction.HITCHANCE_HIGH or OrbamaPrediction.HITCHANCE_NORMAL end
function KarthusChampion:Target(range)
 local selected=_G.SDK.TargetSelector.Selected
 if onScreen(selected)and GetDistance(selected.pos,myHero.pos)<=range then return selected end
 if GetTickCount()<self.comboTargetExpire and onScreen(self.comboTarget)and GetDistance(self.comboTarget.pos,myHero.pos)<=range then return self.comboTarget end
 local t=_G.SDK.TargetSelector:GetTarget(range,_G.SDK.DAMAGE_TYPE_MAGICAL)
 if onScreen(t)then self.comboTarget=t;self.comboTargetExpire=GetTickCount()+2500;return t end
end
function KarthusChampion:SelectedAllows(target,range)
 local selected=_G.SDK.TargetSelector.Selected
 return not onScreen(selected)or GetDistance(selected.pos,myHero.pos)>range or selected.networkID==target.networkID
end
function KarthusChampion:Combat(menu)
 local reach=self:QReach();local target=self:Target(math.max(reach,menu.W and 850 or 0))
 if not target then return end
 local function allowed()return onScreen(target)and self:SelectedAllows(target,reach)end
 if menu.W and menu.W:Value()and self:Ready(_W)and GetDistance(target.pos,myHero.pos)<=850 then
  if self:CastW(target,function()return allowed()and menu.W:Value()and GetDistance(target.pos,myHero.pos)<=850 end)then return end
 end
 if menu.Q:Value()then self:CastQ(target,self:Hit(menu),true,function()return allowed()and menu.Q:Value()end)end
end
function KarthusChampion:Combo()self:Combat(Menu.Combo)end
-- Harass pokes first; with no champion Q queued, Q rescues a minion an attack would miss (spell-farm toggle,
-- Harass and LastHit mana).
function KarthusChampion:Harass()
 if not manaAbove(Menu.Harass.Mana:Value())then return end
 self:Combat(Menu.Harass)
 if Core.pending[HK_Q]or not Menu.Clear.SpellFarm:Value()then return end
 self:Rescue(Menu.LastHit,function()return GetMode()=='Harass'and Menu.Clear.SpellFarm:Value()and manaAbove(Menu.Harass.Mana:Value())end)
end
-- No mode key: the same rescue as LastHit, never while recalling; a mode key cancels it.
function KarthusChampion:IdleQ()return GetMode()==nil and Menu.Clear.SpellFarm:Value()and Menu.LastHit.Q:Value()and not Recalling(myHero)end
function KarthusChampion:IdleRescue()
 if not self:IdleQ()then return false end
 return self:Rescue(Menu.LastHit,function()return self:IdleQ()end)
end
function KarthusChampion:QLethal(target,isolated,horizon)
 if not enemy(target)then return false end
 -- The shared kill rule without its safety margin: Lay Waste is back in a second, so a near miss costs little.
 return(Core:Lethal(target,horizon or self:QImpact(),function()return self:QDamage(target,isolated)end,{kind='magical',margin=1,flat=0}))
end
function KarthusChampion:KillSteal()
 if not self:Ready(_Q)then return false end
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,10)do local t=list[i]
   if onScreen(t)and GetDistance(t.pos,myHero.pos)<=self:QReach()and self:QLethal(t,true)then
   local aim=self:QAim(t,OrbamaPrediction.HITCHANCE_NORMAL,true)
   if aim and self:QLethal(t,aim.data.isolated)then
    if self:CastQ(t,OrbamaPrediction.HITCHANCE_NORMAL,true,function(data)
      return data~=nil and self:QLethal(t,data.isolated)end,'QSecure')then return true end
   end
  end
 end
 return false
end
-- Reuse invariant terms only inside this synchronous evaluation. Dispatch
-- validation bypasses that scope; the prepared overlay cannot authorize R.
function KarthusChampion:RHealth()
 return Core:DecisionValue('Karthus:RequiemHealth',function()
  local rank=myHero:GetSpellData(_R).level;local base=P.rBase[rank]
  if not base or not finite(myHero.ap)then return {rows={},kills=0,complete=false,reason='r_damage_unknown',at=Game.Timer()}end
  local raw=base+P.rAP*myHero.ap
  local horizon=OrbamaPrediction:GetImpactTime(self.RImpact,myHero.pos,myHero)
  local function damageFor(unit)return _G.SDK.Damage:CalculateDamage(myHero,unit,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)end
  local view=Core:HealthRows(horizon,'magical',damageFor,{includeHidden=true,limit=16})
  self:RefineRows(view,horizon,damageFor)
  return view
 end)
end
-- Visible lethal rows lose their kill when the enemy cannot die before Requiem lands (undying, revive, stasis:
-- Core:CannotDie at the impact time). Fogged rows get a bounded upper estimate (FogRow).
function KarthusChampion:RefineRows(view,horizon,damageFor)
 local byID={};local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,16)do local u=list[i];local key=u and(u.networkID or u.handle);if key then byID[key]=u end end
 local knowledge=Core:GetKnowledge()
 local units=knowledge and knowledge:Units(true)
 if units then for i=1,math.min(#units,16)do local u=units[i];local key=u and(u.networkID or u.handle);if key and not byID[key]then byID[key]=u end end end
 local kills=0
 for _,row in ipairs(view.rows)do local unit=byID[row.id]
  if row.known and row.lethal then
   local blocked,why=unit and Core:CannotDie(unit,horizon)
   if blocked or not unit then row.lethal=false;row.cannotDie=blocked==true;row.reason=why or 'unit_missing'end
  elseif not row.known and row.reason=='not_visible'and unit and knowledge then self:FogRow(row,unit,knowledge,horizon,damageFor)end
  if row.lethal then kills=kills+1 end
 end
 view.kills=kills
end
-- An enemy last seen at most fogAge s ago, not recalling and not near its fountain: upper health = last seen health
-- plus regeneration over the time since then and the impact time (capped at maximum health), plus shields and a
-- margin for unseen potions or heals. The row counts as a kill only when R beats that upper bound.
function KarthusChampion:FogRow(row,unit,knowledge,horizon,damageFor)
 row.estimate='fog'
 if knowledge:Recall(unit)then row.reason='fog_recall';return end
 local seen=knowledge:Health(unit,X.fogAge);local last=knowledge:LastSeen(unit,X.fogAge)
 if not seen or not last or not last.pos then row.reason='fog_too_long';return end
 local base=knowledge:Base(unit.team)
 if not base or not base.pos then row.reason='fog_base_unknown';return end
 if GetDistance(last.pos,base.pos)<=X.fogBase then row.reason='fog_near_base';return end
 local age=finite(seen.age)and seen.age or X.fogAge
 local health=math.min(seen.maxHealth,seen.health+math.max(0,seen.hpRegen)*(age+horizon))
 local damage=damageFor(unit)
 if not finite(damage)then row.reason='fog_damage_unknown';return end
 row.age=age;row.upper=health+math.max(0,seen.shieldAD)+math.max(0,seen.shieldAP)+X.fogMargin;row.damage=damage
 row.lethal=damage*.97>=row.upper and not Core:CannotDie(unit,horizon);row.reason=nil
end
function KarthusChampion:RKills()
 local view=self:RHealth()
 return view.complete and view.kills or nil
end
function KarthusChampion:PrepareRPreview()
 if not Menu.Draw.Kills:Value()then self.rPreview=nil;return end
 local view=self:RHealth();local lines={}
 for i=1,math.min(#view.rows,10)do
  local row=view.rows[i];local name=tostring(row.name or 'Enemy'):gsub('^Jade_','')
  if row.known then
   lines[#lines+1]={text=name..': '..math.ceil(row.upper)..' HP+shield / '..math.floor(row.damage)..' R'..(row.lethal and ' [lethal estimate]'or row.cannotDie and ' [cannot die]'or ''),lethal=row.lethal}
  elseif row.estimate=='fog'and row.upper then
   lines[#lines+1]={text=name..': ~'..math.ceil(row.upper)..' HP, '..math.floor(row.age)..' s ago / '..math.floor(row.damage)..' R'..(row.lethal and ' [fog estimate]'or ''),lethal=row.lethal,fog=true}
  else lines[#lines+1]={text=name..': '..(row.reason=='not_visible'and 'health unknown in fog'or tostring(row.reason or 'unknown')),lethal=false}end
 end
 self.rPreview={kills=view.kills,at=Game.Timer(),lines=lines,complete=view.complete}
end
-- Policy only. Readiness belongs to the planner's admission check: a sent R is
-- no longer ready, and that must not cancel the request tracking its channel.
function KarthusChampion:RecallSafe()
 local present,remaining=self:Passive()
 if present and(not remaining or remaining<P.rCast+P.rChannel+.1)then return false end
 if not present and Menu.R.Safe:Value()>0 then
  for _,u in ipairs(Core:DecisionUnits('GetEnemyHeroes'))do if enemy(u)and GetDistance(u.pos,myHero.pos)<Menu.R.Safe:Value()then return false end end
 end
 if not present and IsUnderTurret2(myHero.pos)then return false end
 return true
end
function KarthusChampion:RAllowed()
 if not Menu.R.Auto:Value()then return false,'disabled'end
 if not self:Ready(_R)or self:RChanneling()then return false,'not_ready'end
 local present,remaining=self:Passive()
 if present then
  -- An unknown or short passive cannot authorize the full channel.
  if not remaining or remaining<P.rCast+P.rChannel+.1 then return false,'passive_too_short'end
 end
 -- Alive, a channel inside an enemy turret's range is not cast; during Death Defied R is free and one kill is enough.
 if not present and IsUnderTurret2(myHero.pos)then return false,'under_turret'end
 local kills=self:RKills()
 if not kills or kills<(present and 1 or Menu.R.Count:Value())then return false,'not_lethal'end
 local safe=Menu.R.Safe:Value()
 if not present and safe>0 then
  local list=Core:DecisionUnits('GetEnemyHeroes')
  for i=1,#list do local u=list[i];if enemy(u)and GetDistance(u.pos,myHero.pos)<safe then return false,'enemy_nearby'end end
 end
 return true
end
function KarthusChampion:Requiem()
 local ok=self:RAllowed()
 if not ok then return false end
 local accepted,id=Core:Cast(HK_R,nil,{owner='Requiem',validate=function()return self:RAllowed()end})
 local q=Core.lastIntent;if accepted and q and q.key==HK_R then self.rRequest=q end
 return accepted,id
end
-- The channel window is anchored to an observed R start (native cast start, or this
-- controller's mechanically observed request) because the host's channel fields for
-- Jade Requiem are unverified. A stopped R cast ends the window immediately.
function KarthusChampion:RChanneling()
 local now=Game.Timer();local s=myHero.activeSpell;local full=P.rCast+P.rChannel
 if s and s.valid and type(s.name)=='string'and s.name:lower()==P.rName then
  if s.isStopped==true then self.rUntil=nil;self.rRequest=nil;return false end
  if finite(s.startTime)and s.startTime<=now+.05 and s.startTime>now-full-.5 then
   local untilAt=s.startTime+full+.1
   if not self.rUntil or untilAt>self.rUntil then self.rUntil=untilAt end
  elseif s.isChanneling==true then return true end
 end
 local q=self.rRequest
 if q then
  if q.observedAt then
   local untilAt=now+full+.1-math.max(0,Core.adapter:Now()-q.observedAt)/1000
   if not self.rUntil or untilAt>self.rUntil then self.rUntil=untilAt end
   self.rRequest=nil
  elseif Core.pending[HK_R]~=q then self.rRequest=nil
  -- Between a sent R and its observed start, movement would cancel the cast.
  elseif q.sentAt and Core.adapter:Now()-q.sentAt<=500 then return true end
 end
 if self.rUntil then
  if now<self.rUntil then return true end
  self.rUntil=nil
 end
 return false
end
function KarthusChampion:UpdateLock()
 local lock=self:RChanneling()==true
 if lock~=self.locked then
  self.locked=lock;_G.SDK.Orbwalker:SetAttack(not lock);_G.SDK.Orbwalker:SetMovement(not lock)
 end
 return lock
end
function KarthusChampion:ClearMode(jungle)return _G.SDK.Orbwalker.Modes[jungle and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or _G.SDK.ORBWALKER_MODE_LANECLEAR]==true end
local function countWithin(list,center,radius,filter,limit)
 local n=0
 for i=1,math.min(#list,limit or 48)do local u=list[i]
  if enemy(u)and(not filter or filter(u))and GetDistance(u.pos,center)<=radius then n=n+1 end
 end
 return n
end
-- Whether an aura is justified right now; `keep` uses a slightly larger radius.
function KarthusChampion:EWanted(keep)
 local radius=keep and P.eKeep or P.eRadius;local at=myHero.pos
  if self:Passive()then return countWithin(Core:DecisionUnits('GetEnemyHeroes'),at,radius)>0 or countWithin(Core:DecisionUnits('GetEnemyMinions'),at,radius)>0 end
 local mode=GetMode()
 if mode=='Combo'or mode=='Harass'then
  local menu=Menu[mode]
  if not menu.E:Value()then return false end
  if not manaAbove(mode=='Combo'and Menu.Combo.EMana:Value()or Menu.Harass.Mana:Value())then return false end
  return countWithin(Core:DecisionUnits('GetEnemyHeroes'),at,radius)>0
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then
  if self:ClearMode(false)then
   local m=Menu.Clear.LaneClear
    if m.E:Value()and manaAbove(m.Mana:Value())and countWithin(Core:DecisionUnits('GetEnemyMinions'),at,radius)>=m.ECount:Value()-(keep and 1 or 0)then return true,'lane'end
  end
  if self:ClearMode(true)then
   local m=Menu.Clear.JungleClear
    if m.E:Value()and manaAbove(m.Mana:Value())and countWithin(Core:DecisionUnits('GetMonsters'),at,radius)>0 then return true,'jungle'end
  end
 end
 return false
end
function KarthusChampion:EContext()
 if self:Passive()then return {priority='interactive',condition=function()return self:Passive()end}end
 local mode=GetMode()
 if mode=='LaneClear'then
   local _,kind=self:EWanted(false)
   if kind then return Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)end
   return {priority='background',condition=function()return false end}
 end
 if mode=='Combo'or mode=='Harass'then return Core:ModeContext(mode)end
 return {priority='interactive'}
end
-- Ownership follows the request's mechanical observation, not its continuation
-- callbacks: a mode released after send must not strand an owned aura. Ambiguous or
-- unobserved sends never establish ownership.
function KarthusChampion:ObserveDefile()
 local q=self.eRequest
 if q then
  if q.observedAt then
   if q.eTurn=='on'and self:EState()=='on'then self.eOwned=true elseif q.eTurn=='off'then self.eOwned=false end
   self.eRequest=nil
  elseif Core.pending[HK_E]~=q then self.eRequest=nil end
 end
 if self:EState()=='off'then self.eOwned=false;self.eIdleSince=nil end
end
-- Only an observed own activation is turned off; manual auras are never touched.
function KarthusChampion:Defile()
 self:ObserveDefile()
 local state=self:EState()
 if not state or Game.CanUseSpell(_E)~=0 or Core.pending[HK_E]then return false end
 if state=='off'then
  if not self:Ready(_E)or not self:EWanted(false)then return false end
  if Core:Cast(HK_E,nil,{owner='Defile',context=self:EContext(),validate=function()return self:EState()=='off'and self:EWanted(false)end})then
   local q=Core.lastIntent;if q and q.key==HK_E then q.eTurn='on';self.eRequest=q end
   return true
  end
  return false
 end
 if not self.eOwned or self:Passive()then self.eIdleSince=nil;return false end
 if self:EWanted(true)then self.eIdleSince=nil;return false end
 local now=Game.Timer();self.eIdleSince=self.eIdleSince or now
 if now-self.eIdleSince<P.eIdle then return false end
 if Core:Cast(HK_E,nil,{owner='DefileOff',validate=function()return self:EState()=='on'and self.eOwned and not self:Passive()and not self:EWanted(true)end})then
  local q=Core.lastIntent;if q and q.key==HK_E then q.eTurn='off';self.eRequest=q end
  return true
 end
 return false
end
-- CS rescue: impact-time HP, isolation-aware damage, no softening, no dying minion.
function KarthusChampion:FarmCandidate(target,menu,aim)
 if not enemy(target)or target.type~=Obj_AI_Minion or target.team==300 then return false end
 return self:QKills(target,aim==nil or aim.isolated,self.rescueRule)
end
-- Candidates in reach, most valuable first (super, siege, larger maximum health), then up to four are tried.
function KarthusChampion:RescueOrder()
 local list=Core:DecisionUnits('GetEnemyMinions');local out={}
 for i=1,math.min(#list,24)do local m=list[i]
  if enemy(m)and m.type==Obj_AI_Minion and m.team~=300 and GetDistance(m.pos,myHero.pos)<=self:QReach()then out[#out+1]=m end
 end
 if #out>1 then table.sort(out,byValue)end
 return out
end
function KarthusChampion:Rescue(menu,permission)
 if not menu.Q:Value()or not self:Ready(_Q)or not manaAbove(menu.Mana:Value())or _G.SDK.Attack:IsActive()then return false end
 local list=self:RescueOrder();local tried=0
 for i=1,#list do local m=list[i]
  if tried>=4 then break end
  if self:FarmCandidate(m,menu)then
   tried=tried+1
   local aim=self:QAim(m,OrbamaPrediction.HITCHANCE_NORMAL,true)
   if aim and self:FarmCandidate(m,menu,aim.data)then
    if self:CastQ(m,OrbamaPrediction.HITCHANCE_NORMAL,true,function(data)
     return(not permission or permission())and menu.Q:Value()and self:FarmCandidate(m,menu,data)end)then return true end
   end
  end
 end
 return false
end
function KarthusChampion:LastHit()return self:Rescue(Menu.LastHit)end
function KarthusChampion:LaneClear()
 local menu=Menu.Clear.LaneClear
 local function permission()return self:ClearMode(false)and Menu.Clear.SpellFarm:Value()and manaAbove(menu.Mana:Value())end
 if not permission()then return end
 if self:Rescue(menu,permission)then return end
 if not menu.Q:Value()or not menu.QWave:Value()or not self:Ready(_Q)then return end
 local list=Core:DecisionUnits('GetEnemyMinions');local best,bestCount=nil,0
 for i=1,math.min(#list,12)do local m=list[i]
  if enemy(m)and m.team~=300 and still(m)and GetDistance(m.pos,myHero.pos)<=P.qRange then
   local n=countWithin(list,m.pos,P.qRadius,function(u)return u.team~=300 and still(u)end,24)
   if n>bestCount then best,bestCount=m,n end
  end
 end
 if not best or bestCount<menu.QCount:Value()then return end
 self:CastQ(best,OrbamaPrediction.HITCHANCE_NORMAL,false,function()
  return permission()and menu.QWave:Value()and countWithin(Core:DecisionUnits('GetEnemyMinions'),best.pos,P.qRadius,function(u)return u.team~=300 end,24)>=menu.QCount:Value()end)
end
function KarthusChampion:JungleClear()
 local menu=Menu.Clear.JungleClear
 local function permission()return self:ClearMode(true)and Menu.Clear.SpellFarm:Value()and manaAbove(menu.Mana:Value())end
 if not permission()or not menu.Q:Value()or not self:Ready(_Q)then return end
 local list=Core:DecisionUnits('GetMonsters');local best
 for i=1,math.min(#list,12)do local m=list[i]
  if enemy(m)and GetDistance(m.pos,myHero.pos)<=self:QReach()and(not best or(m.maxHealth or 0)>(best.maxHealth or 0))then best=m end
 end
 if best then self:CastQ(best,OrbamaPrediction.HITCHANCE_NORMAL,false,function()return permission()and menu.Q:Value()end)end
end
function KarthusChampion:Flee()
 if not Menu.Flee.W:Value()or not self:Ready(_W)then return end
 local list=Core:DecisionUnits('GetEnemyHeroes');local best,bestD=nil,650
 for i=1,math.min(#list,10)do local u=list[i]
  if onScreen(u)then local d=GetDistance(u.pos,myHero.pos);if d<=bestD then best,bestD=u,d end end
 end
 if best then self:CastW(best,function()return Menu.Flee.W:Value()and GetDistance(best.pos,myHero.pos)<=650 end)end
end
-- The shared hit window includes bounded movement after stationary CC expires.
function KarthusChampion:AutoQ()
 if not Menu.Auto.QImmobile:Value()or not self:Ready(_Q)or not manaAbove(Menu.Auto.Mana:Value())then return false end
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,10)do local t=list[i]
   if onScreen(t)and GetDistance(t.pos,myHero.pos)<=self:QReach()and Core:ControlledHit(t,self.QSpell,t.pos)then
    if self:CastQ(t,OrbamaPrediction.HITCHANCE_HIGH,true,function(_,point)
     return Menu.Auto.QImmobile:Value()and manaAbove(Menu.Auto.Mana:Value())and Core:ControlledHit(t,self.QSpell,point)
    end,'AutoQ')then return true end
   end
 end
 return false
end
-- A melee champion (attack range <= 300) within 350 that is closing in or whose attack is winding up at Karthus.
function KarthusChampion:MeleeOnMe(target)
 if not onScreen(target)or not finite(target.range)or target.range>300 then return false end
 local d=GetDistance(target.pos,myHero.pos);if d>350 then return false end
 local incoming=Core:IncomingAttack(myHero,0,1.25)
 if incoming and incoming.casterID==target.networkID then return true end
 local path=target.pathing;local to=path and path.hasMovePath==true and path.endPos
 return type(to)=='table'and finite(to.x)and finite(to.z)and GetDistance(to,myHero.pos)<d
end
function KarthusChampion:WReaction(target,point)
 return Menu.Auto.ReactiveW:Value()and manaAbove(Menu.Auto.WMana:Value())
  and(Core:ControlledHit(target,self.WSpell,point)or Core:DashLanding(target,myHero.pos,P.wRange)~=nil or self:MeleeOnMe(target))
end
function KarthusChampion:ReactiveW()
 if not Menu.Auto.ReactiveW:Value()or not self:Ready(_W)or not manaAbove(Menu.Auto.WMana:Value())or self:Passive()then return false end
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,16)do local target=list[i]
  if onScreen(target)and GetDistance(target.pos,myHero.pos)<=P.wRange and self:WReaction(target,target.pos)then
   -- The peel wall goes on the attacker itself: it is already on top of Karthus.
   if self:CastW(target,function(_,point)return not self:Passive()and self:WReaction(target,point)end,'ReactiveW',self:MeleeOnMe(target))then return true end
  end
 end
 return false
end
-- W bind: the selected champion in reach, else the nearest one, with the escape-path placement.
function KarthusChampion:WAssist()
 if not Menu.Auto.WKey:Value()or not self:Ready(_W)then return false end
 local target=_G.SDK.TargetSelector.Selected
 if not onScreen(target)or GetDistance(target.pos,myHero.pos)>P.wRange then
  target=nil;local best=P.wRange;local list=Core:DecisionUnits('GetEnemyHeroes')
  for i=1,math.min(#list,10)do local u=list[i]
   if onScreen(u)then local d=GetDistance(u.pos,myHero.pos);if d<=best then target,best=u,d end end
  end
 end
 if not target then return false end
 return self:CastW(target,function()return Menu.Auto.WKey:Value()and onScreen(target)and GetDistance(target.pos,myHero.pos)<=P.wRange end,'WAssist')
end
-- Death Defied with no champion in reach: Q the most valuable minion or monster it kills (isolation-aware, no
-- attack weighed: Karthus cannot attack), else the largest group of minions. Normal Karthus cannot move, so the
-- reach is fixed around him.
function KarthusChampion:PassiveFarm()
 local best
 for _,method in ipairs({'GetEnemyMinions','GetMonsters'})do
  local list=Core:DecisionUnits(method)
  for i=1,math.min(#list,24)do local u=list[i]
   if enemy(u)and u.type==Obj_AI_Minion and GetDistance(u.pos,myHero.pos)<=self:QReach()and(not best or byValue(u,best))
    and self:QKills(u,false,self.zombieRule)then best=u end
  end
 end
 if best then
  return self:CastQ(best,OrbamaPrediction.HITCHANCE_NORMAL,true,function(data)return self:Passive()and self:QKills(best,data~=nil and data.isolated,self.zombieRule)end,'Passive')
 end
 local list=Core:DecisionUnits('GetEnemyMinions');local cluster,count=nil,1
 for i=1,math.min(#list,12)do local m=list[i]
  if enemy(m)and m.team~=300 and GetDistance(m.pos,myHero.pos)<=P.qRange then
   local n=countWithin(list,m.pos,P.qRadius,function(u)return u.team~=300 end,24)
   if n>count then cluster,count=m,n end
  end
 end
 if cluster then return self:CastQ(cluster,OrbamaPrediction.HITCHANCE_NORMAL,false,function()return self:Passive()end,'Passive')end
 return false
end
-- Death Defied: spells are free; prefer champions, then minions (PassiveFarm).
function KarthusChampion:PassiveSpells()
 if not self:Passive()then return false end
 -- The wall is free too: it goes down first on whoever is in reach, then Q keeps firing.
 if self:Ready(_W)and not Core.pending[HK_W]then local w=self:Target(P.wRange)
  if w and self:CastW(w,function()return self:Passive()end,'Passive')then return true end
 end
 if not self:Ready(_Q)then return false end
 local t=self:Target(self:QReach())
 if t then return self:CastQ(t,OrbamaPrediction.HITCHANCE_NORMAL,true,function()return self:Passive()end,'Passive')end
 return self:PassiveFarm()
end
function KarthusChampion:Tick()
 if self:UpdateLock()then return end
 if Core.logger then self:TraceEvidence()end
 if ShouldWait()or IsCasting()then return end
 if self.previewFallback and Menu.Draw.Kills:Value()and myHero:GetSpellData(_R).level>0
  and Game.Timer()>=(self.nextPreview or 0)then self.nextPreview=Game.Timer()+.125;self:PrepareRPreview()end
 if Core:RecallBaseCast(self.recallCast)or self:Requiem()then return end
 if self:KillSteal()then return end
 if self:PassiveSpells()then return end
 self:Defile()
 if self:WAssist()then return end
 local mode=GetMode()
 if mode=='Combo'then self:Combo()
 elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then
  if self:ClearMode(false)then self:LaneClear()end
  if self:ClearMode(true)then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()
 elseif mode=='Flee'then self:Flee()
 elseif mode==nil and not Core.pending[HK_Q]then self:IdleRescue()end
 if not Core.pending[HK_W]then self:ReactiveW()end
 if not Core.pending[HK_Q]then self:AutoQ()end
end
function KarthusChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.Q:Value()and IsReady(_Q)then Draw.Circle(myHero.pos,P.qRange,1,Draw.Color(255,66,244,113))end
 if Menu.Draw.W:Value()and IsReady(_W)then Draw.Circle(myHero.pos,P.wRange,1,Draw.Color(255,66,184,244))end
 if Menu.Draw.E:Value()and IsReady(_E)then Draw.Circle(myHero.pos,P.eRadius,1,Draw.Color(255,200,120,244))end
 local r=self.rPreview
 -- Kept up to a second so a late preparation never blinks the list.
 if Menu.Draw.Kills:Value()and r and Game.Timer()-r.at>=0 and Game.Timer()-r.at<1 then
   Draw.Text('Requiem lethal estimates: '..r.kills..(r.complete and ''or ' [incomplete]'),16,myHero.pos2D.x-57,myHero.pos2D.y+78,Draw.Color(255,255,160,80))
   for i=1,#r.lines do local line=r.lines[i]
    local color=line.fog and(line.lethal and Draw.Color(170,220,110,110)or Draw.Color(150,160,160,160))or line.lethal and Draw.Color(255,255,80,80)or Draw.Color(255,210,210,210)
    Draw.Text(line.text,14,myHero.pos2D.x-57,myHero.pos2D.y+78+i*17,color)
   end
 end
end
function KarthusChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},w={node=Menu.Combo.W,label='Combo W'},e={node=Menu.Combo.E,label='Combo Defile'},
  hq={node=Menu.Harass.Q,label='Harass Q'},farm={node=Menu.Clear.SpellFarm,label='Spell farming'},last={node=Menu.LastHit.Q,label='Last Hit Q rescue'},
   wave={node=Menu.Clear.LaneClear.QWave,label='Q wave clear'},immobile={node=Menu.Auto.QImmobile,label='Q on controlled champions'},
   reactivew={node=Menu.Auto.ReactiveW,label='Automatic W'},wkey={node=Menu.Auto.WKey,label='Wall of Pain bind'},
  r={node=Menu.R.Auto,label='Automatic lethal Requiem'},
  rsafe={node=Menu.R.Safe,label='Requiem safety radius'},flee={node=Menu.Flee.W,label='Flee W'}}
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Karthus: quick start','Karthus: Lay Waste and Defile','Karthus: Requiem and Death Defied'},function(page)
  if page==1 then return {title=self.profile.id=='classic'and 'Classic Karthus'or 'Karthus',subtitle='One controller with separate Normal and Classic damage profiles.',cards={
   {'COMBAT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..' for [[w]], [[q]] and [[e]]. A valid selected champion takes priority within reach.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..' for [[hq]] with its own mana consent. Release the mode to cancel unsent casts.'},
   {'FARM','[[farm]] enables Clear spells. [[last]] rescues minions your attack cannot take, also in Harass and with no mode key held (never while recalling). Siege and super minions are rescued first. [[wave]] also clears the wave when nothing dies.'}},note='Hold Flee for [[flee]] at the nearest chaser. Hold [[wkey]] for a wall at the selected or nearest champion.'}end
  if page==2 then return {title='Lay Waste and Defile',subtitle='Isolation doubles Q damage; Defile is an owned toggle.',cards={
   {'Q','Q blasts after 0.25 s cast plus the detonation delay (Normal 0.528-0.759 s, Classic 0.5 s); the blast must hold the predicted target at both ends. The aim searches 16 nearby centers that keep the predicted target inside while excluding other units, so a lone hit deals double damage. Lethal checks use isolated damage only when that aim is isolated.'},
   {'DEFILE','[[e]] turns the aura on near champions. Only an aura this controller turned on is switched off when it is no longer justified. A manually enabled aura is never touched.'},
    {'CC','[[immobile]] uses the shared prediction window, including limited movement after stationary control expires. [[reactivew]] places W on immobilised targets, dash landings and melee champions on top of you without a mode key. A moving target gets the wall across its path: ahead of it when it runs, between you when it comes.'}},note='Unknown toggle state disables automatic Defile instead of guessing.'}end
  return {title='Requiem and Death Defied',subtitle='Global damage after a three-second channel.',cards={
    {'REQUIEM','[[r]] requires enough lethal estimates from fresh visible health, magic shields and ordinary regeneration over the impact horizon. Spell shields, invulnerability and states that cannot die (undying, revive, stasis) exclude a target. [[rsafe]] refuses R near visible enemies or under an enemy turret.'},
   {'PASSIVE','Death Defied keeps casting the free wall, Q and E, and farms minions with Q when no champion is in reach. One kill is enough for R then; it starts only when the remaining passive time covers the whole channel.'},
   {'CHANNEL','Attacks and movement are paused while Requiem is observed channeling, then restored.'}},note='An enemy unseen for at most five seconds counts only when R beats its last health plus regeneration and a margin; recalling or near its fountain it never counts. Cast return does not prove a kill.'}
 end,cfg,links,activate)
end
Core:RegisterPolicy({damageTypes={Q='magical',R='magical'},
 methods={Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
   LaneClear=function(self)return Core:FarmContext('lane',function()return self:ClearMode(false)and Menu.Clear.SpellFarm:Value()end)end,
   JungleClear=function(self)return Core:FarmContext('jungle',function()return self:ClearMode(true)and Menu.Clear.SpellFarm:Value()end)end,
  LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end,
  KillSteal=function()return {priority='interactive'}end,Requiem=function()return {priority='interactive'}end,
   PassiveSpells=function()return {priority='interactive'}end,AutoQ=function()return {priority='normal'}end,
   IdleRescue=function(self)return {priority='normal',condition=function()return self:IdleQ()end}end,
   WAssist=function()return Core:HeldContext(function()return Menu.Auto.WKey:Value()end)end,
   ReactiveW=function()return {priority='interactive',condition=function()return Menu.Auto.ReactiveW:Value()end}end},
 exceptions={non_interrupting_summoner=true},
 -- Death Defied casts are free; turning Defile off does not spend its upkeep.
 costPaid=function(self,q,slot)return self:Passive()or slot==_E and self:EState()=='on'end,
 channel=function()return not Core:SelfChanneling()end,
})
KarthusChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Karthus"]="Karthus"}
local normalSupported={["Karthus"]=true}

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
