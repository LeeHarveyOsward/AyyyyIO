return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["MissFortune"]=function()return _G.OrbamaFamily:Require("f707d7a8863a298f9a38b06d5733e1d8ff49a5859c45464516f34c391f15227e")()end
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
if champion=="MissFortune" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='MissFortune',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.05
-- Exact profile data and open attribution gaps: missfortune-provenance.json.
local profiles=AbilityProfiles.controllers.MissFortune
-- Ranking data (bounce tiers, crit bounce, Love Tap, E ticks, Strut, R cone timing): ChampionProfiles/MissFortune.lua.
local extras=ChampionProfiles('MissFortune')
local finite,identity,manaAbove,buffExpiry=Core.finite,Core.id,Core.manaAbove,Core.buffExpiry
local function screen(u)return IsValid(u)and u.pos and u.pos:ToScreen().onScreen end
local function stationary(u)return u.pathing and u.pathing.hasMovePath==false and not u.pathing.isDashing end
-- Where a unit can be after `seconds` on its current path: the straight stretch from its position to the
-- point it walks to, and the distance covered. nil when its movement is unknown or a dash.
local function ahead(u,seconds)
 local path=u.pathing;if not path then return nil end
 if path.hasMovePath==false and not path.isDashing then return u.pos,0 end
 if path.hasMovePath~=true or path.isDashing~=false or not finite(u.ms)or u.ms<=0 or not finite(seconds)or seconds<0 then return nil end
 local to=u.posTo or path.endPos;if not to or not finite(to.x)or not finite(to.z)then return nil end
 local dx,dz=to.x-u.pos.x,to.z-u.pos.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<1 then return u.pos,0 end
 local travel=math.min(length,u.ms*seconds)
 return Vector(u.pos.x+dx/length*travel,u.pos.y,u.pos.z+dz/length*travel),travel
end
local function enemyUnit(u)return u and u.pos and u.valid and u.alive and not u.dead and u.health>0 and u.isTargetable and u.team~=myHero.team end
-- Inside the sector behind `origin` (unit axis ux,uz), within `range` and the full `angle` in degrees.
-- pad>0 widens it by that distance (a unit that could be inside), pad<0 shrinks it (certainly inside).
local function sector(origin,ux,uz,point,range,angle,pad)
 local ox,oz=point.x-origin.x,point.z-origin.z;local dist=math.sqrt(ox*ox+oz*oz)
 if dist>range+pad then return false end
 if dist<1e-6 then return pad>=0 end
 local c=(ox*ux+oz*uz)/dist;if c>1 then c=1 elseif c<-1 then c=-1 end
 local theta=math.acos(c);local half=math.rad(angle/2)
 if pad>=0 then
  if theta<=half then return true end
  return(theta-half>=math.pi/2 and dist or dist*math.sin(theta-half))<=pad
 end
 return theta<=half and dist*math.sin(half-theta)>=-pad
end
local MissFortuneChampion=class("MissFortuneChampion")
function MissFortuneChampion:__init()
 self.profile=assert(profiles[myHero.charName],'Unsupported Miss Fortune profile')
 self.data=assert(extras[self.profile.id],'Missing Miss Fortune ranking profile')
 -- Normal: the published bounce priority tiers. Classic: no published tiers; the conservative 60 degree cone.
 self.tiers=self.data.tiers or {{range=self.profile.bounceRange,angle=60}}
 self.QSpell=AbilityProfiles.Spell(myHero.charName,'Q',OrbamaPrediction)
 self.ESpell=AbilityProfiles.Spell(myHero.charName,'E',OrbamaPrediction)
 -- The central ray is an interior cone aim, not an assertion that all waves hit.
 self.RSpell=AbilityProfiles.Spell(myHero.charName,'R',OrbamaPrediction)
 self.RSpell.Type=OrbamaPrediction.SPELLTYPE_LINE;self.RSpell.Collision=true;self.RSpell.CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}
 self.hitEvents={}
 self:LoadMenu()
 Callback.Add('Draw',function()self:Draw()end)
 Callback.Add('Tick',function()self:Tick()end)
 _G.SDK.Orbwalker:OnPreAttack(function(args)self:OnPreAttack(args)end)
 Core:RegisterCleanup('MissFortune.plans',function()
  self:EndER('controller_shutdown');self.rPreview=nil;self.rProtected=false;self.bouncePreview=nil;self.hitEvents={}
  _G.SDK.Orbwalker:SetAttack(true);_G.SDK.Orbwalker:SetMovement(true)
 end)
 if Core.RegisterComboDamage then Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)end
 self:OfferDefense()
end
function MissFortuneChampion:LoadMenu()
	local championIcon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/".."MissFortune.png"
	Menu = MenuElement({type = MENU, id = "Classic_AIO_"..myHero.charName, name='AyyyyIO - Miss Fortune', leftIcon = championIcon})

	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "Q2", name = "Bounce Q off another unit to reach the target", toggle = true, value = true, menu = false})
	Menu.Combo:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	if self.profile.id == 'normal' then
		Menu.Combo:MenuElement({id = "R", name = "R when it kills the target or hits enough enemies", value = false})
		Menu.Combo:MenuElement({id = "RCount", name = "R must hit this many enemies", value = 3, min = 2, max = 5, step = 1})
	end

	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "Q2", name = "Bounce Q off another unit to reach the target", toggle = true, value = true, menu = false})
	Menu.Harass:MenuElement({id = "W", name = "Use W before attacks on a champion", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "E", name = "Use E", toggle = true, value = true})

	Menu:MenuElement({type = MENU, id = "Clear", name = "Farming"})
	Menu.Clear:MenuElement({id = "SpellFarm", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(newValue)
		if CheckChatBlock(Menu.Clear.SpellFarm, newValue) then return end
	end})
	Menu.Clear:MenuElement({id = "SpellHarass", name = "Harass enemy champions while lane clearing", value = true})
	Menu.Clear:MenuElement({type = MENU, id = "LaneClear", name = "LaneClear"})
	Menu.Clear.LaneClear:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Clear.LaneClear:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Clear.LaneClear:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	Menu.Clear.LaneClear:MenuElement({id = "ECount", name = "Lane minions E must hit", value = 3, min = 1, max = 5, step = 1})
	Menu.Clear:MenuElement({type = MENU, id = "JungleClear", name = "JungleClear"})
	Menu.Clear.JungleClear:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Clear.JungleClear:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Clear.JungleClear:MenuElement({id = "E", name = "Use E", toggle = true, value = true})


	Menu:MenuElement({type = MENU, id = "Misc", name = "Behaviour"})
	Menu.Misc:MenuElement({id = "R", name = "Cast R at the selected target", key = string.byte("T")})

	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "Q", name = "Q range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "E", name = "E range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "R", name = "R range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "Bounce", name = "Planned Q bounce", toggle = true, value = true})
 Menu.Harass:MenuElement({id='Mana',name='Only above mana %',value=40,min=0,max=100,step=5})
 Menu.Clear.LaneClear:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 Menu.Clear.JungleClear:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu.Combo:MenuElement({id='EReserveR',name='Keep mana for a ready R when using E',value=true,menu=false})
  -- Automatic R needs a verified cone profile; no installed profile has one yet.
  if self.profile.rConeVerified==true then
   Menu.Misc:MenuElement({id='AutoR',name='R immobilised groups without a mode key',value=false})
   Menu.Misc:MenuElement({id='RCount',name='R must hit this many immobilised enemies',value=3,min=2,max=5,step=1})
  end
  Menu.Misc:MenuElement({id='ER',name='Cast E then R at the selected target',key=string.byte('U')})
  Menu.Misc:MenuElement({id='AutoE',name='E immobilised or killable enemies automatically',value=true})
  Menu.Misc:MenuElement({id='AutoBounce',name='Bounce Q onto enemies automatically',value=true})
  Menu.Misc:MenuElement({id='BounceKillFirst',name='Only bounce off a minion that Q kills',value=true,menu=false})
  Menu.Misc:MenuElement({id='AutoMana',name='Automatic Q and E only above mana %',value=30,min=0,max=100,step=5})
  Menu.Draw:MenuElement({id='RPreview',name='R damage per wave while aiming',value=false})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
end


function MissFortuneChampion:LiveBuff(alias)
 local count=myHero.buffCount;if not finite(count)or count%1~=0 or count<0 or count>128 then return false end
 for i=0,count do local b=myHero:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==alias and finite(b.count)and b.count>0 then
   local expiry=buffExpiry(b)
   local source=b.source or b.caster;local kind=type(source)
   local id=kind=='number'and source or(kind=='table'or kind=='userdata')and identity(source)
   local owned=source==nil or id==myHero.networkID or id==myHero.handle
   if owned and finite(expiry)and expiry>Game.Timer()then return true end
  end
 end
 return false
end
function MissFortuneChampion:IsChannelingR()
 return Core:DecisionValue('MissFortune:RChannel',function()
 if myHero.dead then return false end
 local cast=myHero.activeSpell
 if cast and cast.valid and type(cast.name)=='string'and cast.name:lower()==self.profile.rName then
   if cast.isStopped==true then return false end
   if cast.isChanneling or finite(cast.castEndTime)and cast.castEndTime>Game.Timer()then return true end
 end
 return self:LiveBuff(self.profile.rBuff)
 end)
end
function MissFortuneChampion:SyncChannel()
 local protect=self:IsChannelingR()
 if protect~=self.rProtected then
  self.rProtected=protect;_G.SDK.Orbwalker:SetAttack(not protect);_G.SDK.Orbwalker:SetMovement(not protect)
  if Core.logger then self:TraceR(protect)end
 end
end
-- Development measurement (MissFortune-6): per own R channel, the health each enemy within the R radius lost
-- between channel start and end, and the profile's planned waves for it. Settles the cone and first-wave timing.
function MissFortuneChampion:TraceR(started)
 if started then
  local rows={}
  for _,u in ipairs(_G.SDK.ObjectManager:GetEnemyHeroes(self.data.rRange))do
   if #rows<5 and screen(u)then rows[#rows+1]={unit=u,id=u.networkID,health=u.health,waves=self.rPlan and self.rPlan[u.networkID]}end
  end
  self.rTrace={at=Game.Timer(),rows=rows,rank=myHero:GetSpellData(_R).level}
  return
 end
 local t=self.rTrace;self.rTrace=nil;if not t then return end
 local out={}
 for _,row in ipairs(t.rows)do out[#out+1]={id=row.id,lost=IsValid(row.unit)and row.health-row.unit.health or nil,dead=not IsValid(row.unit),plannedWaves=row.waves}end
 Core:Trace('mf_r_channel',{profile=self.profile.id,rank=t.rank,seconds=Game.Timer()-t.at,enemies=out})
end
function MissFortuneChampion:ClearMode(jungle)
 local mode=jungle and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or _G.SDK.ORBWALKER_MODE_LANECLEAR
 return _G.SDK.Orbwalker.Modes[mode]==true
end
function MissFortuneChampion:ManaAllowed(menu)
 return not menu.Mana or manaAbove(menu.Mana:Value())
end
function MissFortuneChampion:QDelay()
 if self.profile.id=='classic'then return .25 end
 local delay=myHero.attackData and myHero.attackData.windUpTime
 if finite(delay)and delay>0 and delay<=1 then return delay end
end
function MissFortuneChampion:QLaunch(delay)
 delay=delay or self:QDelay();return delay and OrbamaPrediction:GetLaunchDelay({Delay=delay})or nil
end
-- Q cast reach to a unit, centre to centre. Normal: 550 plus bonus attack range, i.e. her attack reach
-- (range plus both bounding radii) so a targeted Q never makes her walk in. Classic: the profile's 650
-- until a live edge measurement (development trace mf_q_cast).
function MissFortuneChampion:QReach(unit)
 if self.data.qReach=='attack'then
  local r=myHero.range;if not finite(r)or r<=0 then return nil end
  return r+(myHero.boundingRadius or 0)+(unit and unit.boundingRadius or 0)
 end
 return self.data.qReach
end
function MissFortuneChampion:InQReach(unit)
 local r=self:QReach(unit);return r~=nil and IsValid(unit)and GetDistance(unit.pos,myHero.pos)<=r
end
function MissFortuneChampion:HasIE()
 local id=self.data.ieItem;if not id then return false end
 for slot=6,12 do local item=myHero:GetItemData(slot);if item and item.itemID==id then return true end end
 return false
end
-- Raw Q damage. bounce: the second hit (Classic 120%). crit: the bounce after Q killed the primary
-- (Normal 150%, +15% with Infinity Edge). Love Tap is added separately for a direct hit.
function MissFortuneChampion:GetQDmg(target,bounce,crit)
 local base=self.profile.qBase[myHero:GetSpellData(_Q).level];if not base then return 0 end
 local raw=(base+self.profile.qAD*myHero.totalDamage+self.profile.qAP*myHero.ap)*(bounce and self.profile.bounce or 1)
 if bounce and crit and self.data.qCrit then raw=raw*(self.data.qCrit+(self:HasIE()and self.data.qCritIE or 0))end
 -- Impure Shots, unknown crits and item procs are not invented here.
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
end
-- Love Tap (Normal): bonus physical damage when the hit lands on a unit other than the last one she marked.
-- Eligibility comes only from observed own attack / Q casts this session (hitEvents): unknown counts 0.
function MissFortuneChampion:ObserveHits()
 local cast=myHero.activeSpell
 if not cast or not cast.valid or cast.isStopped or not finite(cast.startTime)or cast.startTime==self.lastHitStart then return end
 local q=myHero:GetSpellData(_Q)
 if not(Core:IsAttackCast(cast)or q and cast.name==q.name)then return end
 local t=cast.target;local id=type(t)=='number'and t or(type(t)=='table'or type(t)=='userdata')and identity(t)or nil
 if not id or id==0 then return end
 self.lastHitStart=cast.startTime
 local list=self.hitEvents;list[#list+1]={id=id,at=cast.startTime};if #list>4 then table.remove(list,1)end
end
function MissFortuneChampion:LoveTapEligible(unit)
 local list=self.hitEvents;if not self.data.loveTap or not list or #list==0 or not IsValid(unit)then return false end
 local now=Game.Timer()
 for i=1,#list do local row=list[i]
  if(row.id==unit.networkID or row.id==unit.handle)and(i==#list or now-row.at<=1.5)then return false end
 end
 return true
end
function MissFortuneChampion:LoveTapDamage(unit)
 local lt=self.data.loveTap;if not lt or not self:LoveTapEligible(unit)then return 0 end
 local hero=unit.type==Obj_AI_Hero;local lane=unit.type==Obj_AI_Minion and unit.team~=300
 if not hero and not lane then return 0 end
 local level=myHero.levelData and myHero.levelData.lvl;if not finite(level)or level<1 then return 0 end
 local ratio=lt.base;for _,at in ipairs(lt.levels)do if level>=at then ratio=ratio+lt.step end end
 if lane then ratio=ratio*lt.minion end
 return _G.SDK.Damage:CalculateDamage(myHero,unit,_G.SDK.DAMAGE_TYPE_PHYSICAL,ratio*myHero.totalDamage)
end
function MissFortuneChampion:QLethal(target,bounce,impact,crit)
 if not screen(target)then return false end
 local function damage()return self:GetQDmg(target,bounce,crit)+(bounce and 0 or self:LoveTapDamage(target))end
 -- Champions: the shared kill rule. Minions keep the farm estimate below (their forecast differs).
 if target.type==Obj_AI_Hero then return(Core:Lethal(target,impact or 1,damage,{kind='physical'}))end
 local health=Core:HealthEstimate(target,impact or 1,'physical',damage())
 return health and health.lethal and Core:SpellProtected(target)==false or false
end
function MissFortuneChampion:PreferredTarget(range)
 local selected=_G.SDK.TargetSelector.Selected
 if screen(selected)and GetDistance(selected.pos,myHero.pos)<=range then return selected end
 local target=GetTarget(range)
 if screen(target)and GetDistance(target.pos,myHero.pos)<=range then return target end
end
function MissFortuneChampion:QSearch()return(self:QReach(nil)or self.QSpell.Range)+self.profile.bounceRange+100 end
-- Native bounded discovery is refreshed for bounce competitors and farm validation.
-- Refuse incomplete lists instead of certifying a unique bounce or an AoE count.
function MissFortuneChampion:Objects()
 return Core:DecisionValue('MissFortune:BounceObjects',function()
 if not Game.MinionCount or not Game.Minion or not Game.HeroCount or not Game.Hero then return nil end
 local nc,hc=Game.MinionCount(),Game.HeroCount()
 if not finite(nc)or not finite(hc)or nc%1~=0 or hc%1~=0 or nc<0 or hc<0 or nc>256 or hc>24 then return nil end
 local out,seen={},{}
 for kind=1,2 do local n=kind==1 and nc or hc
  for i=1,n do local u=kind==1 and Game.Minion(i)or Game.Hero(i)
   if enemyUnit(u)and u.networkID and not seen[u.networkID]and GetDistance(u.pos,myHero.pos)<=math.max(self.QSpell.Range,self:QReach(nil)or 0)+self.profile.bounceRange+500 then
    seen[u.networkID]=true;out[#out+1]=u;if #out>64 then return nil end
   end
  end
 end
 return out
 end)
end
function MissFortuneChampion:WallFree(a,b,delay,ignore)
 local wall,objects,count=OrbamaPrediction:GetCollision(a,b,self.QSpell.Speed,delay,30,{OrbamaPrediction.COLLISION_YASUOWALL},ignore)
 return wall==false and count==0
end
-- Worst (largest) priority tier of a stretch p1..p2 certainly inside (shrunk by margin), or nil. Tiers 1-3 nest,
-- so the first tier holding the whole stretch is its worst; tier 4 is checked as its own region.
function MissFortuneChampion:WorstTier(origin,ux,uz,p1,p2,margin)
 for k,t in ipairs(self.tiers)do
  if sector(origin,ux,uz,p1,t.range,t.angle,-margin)and sector(origin,ux,uz,p2,t.range,t.angle,-margin)then return k end
 end
end
-- Best (smallest) tier a unit could be in, with its motion and size as padding; huge when none.
function MissFortuneChampion:BestTier(origin,ux,uz,point,pad)
 for k,t in ipairs(self.tiers)do if sector(origin,ux,uz,point,t.range,t.angle,pad)then return k end end
 return math.huge
end
-- A certified bounce: the recipient is certainly in a better priority tier than every other unit could be
-- (Normal tiers; Classic one 60 degree cone), both legs free of wind walls. The first unit may walk: Q homes on
-- it, so the bounce starts where it stands at impact, and the cone is shrunk by 30% of its travel.
-- Returns valid, impact, info {crit, tier, origin, firstTime}.
function MissFortuneChampion:BounceValid(first,recipient,list)
 local delay=self:QDelay()
 if not delay or not screen(first)or not screen(recipient)or first.networkID==recipient.networkID then return false end
 local reach=self:QReach(first);if not reach or GetDistance(first.pos,myHero.pos)>reach then return false end
 local launch=self:QLaunch(delay);local firstTime=launch+GetDistance(myHero.pos,first.pos)/self.QSpell.Speed
 local origin,firstTravel=ahead(first,firstTime);if not origin then return false end
 local ax,az=origin.x-myHero.pos.x,origin.z-myHero.pos.z;local axis=math.sqrt(ax*ax+az*az);if axis<1 then return false end
 local ux,uz=ax/axis,az/axis;local firstMargin=firstTravel*.3
 -- The recipient may walk: its position now and when the shot reaches the first unit must both be certainly
 -- inside its tier (the sectors are convex); 30% of the distance it covers allows for a turn.
 local future,travel=ahead(recipient,firstTime);if not future then return false end
 local margin=travel*.3+firstMargin
 local tier=self:WorstTier(origin,ux,uz,recipient.pos,future,margin);if not tier then return false end
 if first.type==Obj_AI_Minion then
  local hp=_G.SDK.HealthPrediction:GetPrediction(first,firstTime)
  if not finite(hp)or hp<=0 then return false end
 end
 local impact=firstTime+math.max(GetDistance(origin,recipient.pos),GetDistance(origin,future))/self.QSpell.Speed
 list=list or self:Objects();if not list then return false end
 local foundFirst,foundRecipient=false,false
 for i=1,#list do local u=list[i]
  if u.networkID==first.networkID then foundFirst=true
  elseif u.networkID==recipient.networkID then foundRecipient=true
  else
   local motion=stationary(u)and 0 or finite(u.ms)and math.max(0,u.ms)*impact
   if motion==false or motion==nil then return false end
   -- Same tier is refused too: the order inside a tier is not published.
   if self:BestTier(origin,ux,uz,u.pos,(u.boundingRadius or 0)+motion+firstMargin)<=tier then return false end
  end
 end
 if not foundFirst or not foundRecipient then return false end
 if not self:WallFree(myHero.pos,first.pos,launch,first.networkID)or not self:WallFree(origin,recipient.pos,firstTime,recipient.networkID)then return false end
 -- Normal: Q killing the primary makes the bounce a critical strike.
 local crit=self.data.qCrit~=nil and self:QLethal(first,false,firstTime)==true
 return true,impact,{crit=crit,tier=tier,origin=origin,firstTime=firstTime}
end
-- opts.firstType: only units of this type are tried as the first unit (two-champion shots).
function MissFortuneChampion:QLogic(target,allowBounce,validate,owner,bounceOnly,firstAllowed,opts)
 if not screen(target)or not IsReady(_Q)then return false end
 local delay=self:QDelay();if not delay then return false end
 local launch=self:QLaunch(delay)
 local first,bounced,impact,info=target,false,launch+GetDistance(target.pos,myHero.pos)/self.QSpell.Speed,nil
 if bounceOnly or not self:InQReach(target)then
  if not allowBounce then return false end
  local list=self:Objects();if not list then return false end
  first=nil;local tested=0
  for i=1,#list do local candidate=list[i]
   if candidate.networkID~=target.networkID and screen(candidate)and(not opts or not opts.firstType or candidate.type==opts.firstType)and self:InQReach(candidate)then
    tested=tested+1;if tested>12 then break end
    local valid,at,row=self:BounceValid(candidate,target,list)
    if valid and(not firstAllowed or firstAllowed(candidate,at,row))then first=candidate;impact=at;info=row;break end
   end
  end
  if not first then return false end;bounced=true
  elseif not self:WallFree(myHero.pos,first.pos,launch,first.networkID)then return false end
 if validate and not validate(target,bounced,impact,info and info.crit)then return false end
 if bounced then self.bouncePreview={first=Vector(first.pos.x,first.pos.y,first.pos.z),recipient=Vector(target.pos.x,target.pos.y,target.pos.z),at=Game.Timer(),crit=info and info.crit}end
 local firstID,recipientID=first.networkID,target.networkID;local firstHandle,recipientHandle=first.handle,target.handle
 local ok=Core:Cast(HK_Q,first,{owner=owner,intentTarget=first,range=self:QReach(first)or self.QSpell.Range,validate=function()
   if not screen(target)or target.networkID~=recipientID or target.handle~=recipientHandle
    or first.networkID~=firstID or first.handle~=firstHandle or not self:InQReach(first)then return false end
   local delay=self:QDelay();if not delay then return false end
   local launch=self:QLaunch(delay);local at=launch+GetDistance(first.pos,myHero.pos)/self.QSpell.Speed;local row
  if bounced then local valid;valid,at,row=self:BounceValid(first,target);if not valid then return false end
   elseif not self:WallFree(myHero.pos,first.pos,launch,first.networkID)then return false end
   if bounced and firstAllowed and not firstAllowed(first,at,row)then return false end
  return not validate or validate(target,bounced,at,row and row.crit)
 end})
 if ok and Core.logger then
  local q=Core.lastIntent;local planned={first=firstID,recipient=bounced and recipientID or nil,distance=GetDistance(first.pos,myHero.pos),reach=self:QReach(first),
   tier=info and info.tier,crit=info and info.crit}
  Core:AfterCast(HK_Q,function()self:TraceQ(planned,bounced and target or nil,first)end)
 end
 return ok
end
-- Development measurement (MissFortune-2/13): distance at the sent Q against the reach used, and for a bounce
-- the health of every unit near the first one a second later, so the actual recipient (Classic tiers) shows.
function MissFortuneChampion:TraceQ(planned,recipient,first)
 local rows={}
 if recipient and IsValid(first)then
  local list=self:Objects()or {}
  for i=1,#list do local u=list[i]
   if #rows<6 and u.networkID~=first.networkID and GetDistance(u.pos,first.pos)<=600 then
    local dx,dz=first.pos.x-myHero.pos.x,first.pos.z-myHero.pos.z;local ox,oz=u.pos.x-first.pos.x,u.pos.z-first.pos.z
    local l=math.sqrt(dx*dx+dz*dz)*math.sqrt(ox*ox+oz*oz)
    rows[#rows+1]={unit=u,id=u.networkID,health=u.health,distance=GetDistance(u.pos,first.pos),angle=l>0 and math.deg(math.acos(math.max(-1,math.min(1,(dx*ox+dz*oz)/l))))or nil}
   end
  end
 end
 self.qTrace={planned=planned,rows=rows,at=Game.Timer(),walking=myHero.pathing and myHero.pathing.hasMovePath==true}
end
function MissFortuneChampion:FlushQTrace()
 local t=self.qTrace;if not t or Game.Timer()-t.at<1 then return end
 self.qTrace=nil;local out={}
 for _,row in ipairs(t.rows)do out[#out+1]={id=row.id,distance=row.distance,angle=row.angle,lost=IsValid(row.unit)and row.health-row.unit.health or nil}end
 Core:Trace('mf_q_cast',{profile=self.profile.id,planned=t.planned,walkingAtSend=t.walking,neighbours=out})
end
-- A champion in an E circle: its Combo E rule (outside attack reach unless two champions are hit) and mana reserve.
function MissFortuneChampion:EAllowed(menu,target,hits)
 if not menu.E:Value()or not self:ManaAllowed(menu)or not screen(target)or not IsReady(_E)then return false end
 if menu==Menu.Combo then
  if _G.SDK.Data:IsInAutoAttackRange(myHero,target)and(hits or 1)<2 then return false end
  local reserve=0
  if Menu.Combo.EReserveR:Value()and IsReady(_R)then reserve=myHero:GetSpellData(_R).mana end
  for _,slot in ipairs({_Q,_W})do if menu[slot==_Q and 'Q'or 'W']:Value()and IsReady(slot)then reserve=reserve+myHero:GetSpellData(slot).mana end end
  return myHero.mana>=myHero:GetSpellData(_E).mana+reserve
 end
 return true
end
function MissFortuneChampion:CastE(target,validate,confidence,owner)
 if not screen(target)or not IsReady(_E)then return false end
 local prediction=Core:Prediction(self.ESpell);prediction:GetPrediction(target,myHero)
 if not prediction:CanHit(confidence or OrbamaPrediction.HITCHANCE_HIGH)then return false end
 return Core:Cast(HK_E,prediction.CastPosition,{owner=owner,intentTarget=target,range=self.ESpell.Range,prevalidateWorldCast=true,validate=validate})
end
-- Champions (current positions) an E circle at `point` reaches.
function MissFortuneChampion:EChampions(point)
 local count=0;local rows=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#rows,16)do local u=rows[i]
  if screen(u)and GetDistance(u.pos,point)<=self.ESpell.Radius+(u.boundingRadius or 0)then count=count+1 end
 end
 return count
end
-- E aim covering the most predicted champions while hitting the target (C:BestAim circle over at most 5).
-- One champion: the target's own bound prediction. Returns aim, hits.
function MissFortuneChampion:EPlan(target)
 local points,must={},nil
 local rows=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#rows,16)do local u=rows[i]
  if #points<4 and u~=target and screen(u)and GetDistance(u.pos,myHero.pos)<=self.ESpell.Range+self.ESpell.Radius then
   local p=Core:Prediction(self.ESpell);p:GetPrediction(u,myHero)
   if p:CanHit(OrbamaPrediction.HITCHANCE_NORMAL)then points[#points+1]={x=p.CastPosition.x,z=p.CastPosition.z,unit=u}end
  end
 end
 local p=Core:Prediction(self.ESpell);p:GetPrediction(target,myHero)
 if not p:CanHit(OrbamaPrediction.HITCHANCE_HIGH)then return nil end
 points[#points+1]={x=p.CastPosition.x,z=p.CastPosition.z,unit=target};must=#points
 if #points==1 then return nil,1 end
 local aim,_,hits=Core:BestAim(points,{kind='circle',radius=self.ESpell.Radius,range=self.ESpell.Range},{must=must})
 if not aim or not hits or #hits<2 then return nil,1 end
 -- Centre the circle on the covered champions when that still covers them all (margin for prediction error).
 local cx,cz=0,0;for _,i in ipairs(hits)do cx=cx+points[i].x;cz=cz+points[i].z end;cx,cz=cx/#hits,cz/#hits
 local centred=(cx-myHero.pos.x)^2+(cz-myHero.pos.z)^2<=self.ESpell.Range^2
 for _,i in ipairs(hits)do if(points[i].x-cx)^2+(points[i].z-cz)^2>self.ESpell.Radius^2 then centred=false end end
 if centred then aim={x=cx,z=cz}end
 return Vector(aim.x,myHero.pos.y,aim.z),#hits
end
function MissFortuneChampion:CombatE(menu)
 local target=self:PreferredTarget(self.ESpell.Range);if not screen(target)then return false end
 local aim,hits=self:EPlan(target)
 if not self:EAllowed(menu,target,hits)then return false end
 if not aim then return self:CastE(target,function()return self:EAllowed(menu,target)end)end
 local need=hits
 return Core:Cast(HK_E,aim,{intentTarget=target,range=self.ESpell.Range,prevalidateWorldCast=true,validate=function(q,resolved)
  local point=resolved and resolved.position or q.target
  return point~=nil and self:EAllowed(menu,target,need)and self:EChampions(point)>=need
 end})
end
-- Combo Q waits for the attack cooldown when the target is inside attack reach and Q does not kill: Q's cast
-- time is one attack windup, so sent right after an attack it costs no attack (C:WeaveWindow).
function MissFortuneChampion:WeaveWait(menu,target)
 if menu~=Menu.Combo or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)or self:QLethal(target,false)then return false end
 return not Core:WeaveWindow(self:QDelay()or .25,target)
end
-- A critical bounce off a minion Q kills beats a direct Q when it deals more than the direct hit plus Love Tap.
function MissFortuneChampion:CritBounceBetter(target)
 if not self.data.qCrit then return false end
 return self:GetQDmg(target,true,true)>self:GetQDmg(target)+self:LoveTapDamage(target)
end
-- Two champions with one Q: a champion primary whose certified bounce goes to another champion. The selected
-- target is tried first as the recipient, then as the primary.
function MissFortuneChampion:TwoChampionQ(target,allowed,owner)
 local rows=Core:DecisionUnits('GetEnemyHeroes');local heroes={}
 for i=1,math.min(#rows,16)do local u=rows[i]
  if #heroes<5 and screen(u)and GetDistance(u.pos,myHero.pos)<=self:QSearch()then heroes[#heroes+1]=u end
 end
 if #heroes<2 then return false end
 table.sort(heroes,function(a,b)return(a==target and 0 or 1)<(b==target and 0 or 1)end)
 local function primary(first)return first.type==Obj_AI_Hero and Core:SpellProtected(first)==false end
 for _,recipient in ipairs(heroes)do
  if self:QLogic(recipient,true,allowed,owner,true,primary,{firstType=Obj_AI_Hero})then return true end
 end
 return false
end
function MissFortuneChampion:Combat(menu)
 if not self:ManaAllowed(menu)then return end
 if menu.Q:Value()and IsReady(_Q)then
  local target=self:PreferredTarget(self:QSearch())
  local function allowed(_,bounce)return menu.Q:Value()and self:ManaAllowed(menu)and(not bounce or menu.Q2:Value())end
  if menu.Q2:Value()and self:TwoChampionQ(target,allowed)then
  elseif screen(target)then
   local direct=self:InQReach(target)
   local function critFirst(first,_,row)return first.type==Obj_AI_Minion and row~=nil and row.crit==true end
   if direct and menu.Q2:Value()and self:CritBounceBetter(target)
    and self:QLogic(target,true,allowed,nil,true,critFirst,{firstType=Obj_AI_Minion})then
   elseif direct and self:WeaveWait(menu,target)then
   else self:QLogic(target,menu.Q2:Value(),allowed)end
  end
 end
 if menu.E:Value()and IsReady(_E)then self:CombatE(menu)end
 if menu==Menu.Combo then self:ComboR()end
end
function MissFortuneChampion:Combo()self:Combat(Menu.Combo)end
function MissFortuneChampion:Harass()self:Combat(Menu.Harass)end
function MissFortuneChampion:FarmHarass()
 if self:ClearMode(false)and Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)then self:Harass()end
end
-- Flee: Normal W for Strut's movement speed (Classic W gives none), then E on the nearest pursuer.
function MissFortuneChampion:Flee()
 local function fleeing()return GetMode()=='Flee'and not self:IsChannelingR()end
 if not fleeing()then return false end
 if self.data.wHaste and IsReady(_W)and not self:LiveBuff(self.profile.wBuff)
  and Core:Cast(HK_W,nil,{validate=function()return fleeing()and not self:LiveBuff(self.profile.wBuff)end})then return true end
 if not IsReady(_E)then return false end
 local rows=Core:DecisionUnits('GetEnemyHeroes');local best,near
 for i=1,math.min(#rows,16)do local target=rows[i]
  if screen(target)then local d=GetDistance(target.pos,myHero.pos);if d<=700 and(not near or d<near)then best,near=target,d end end
 end
 return best~=nil and self:CastE(best,fleeing,OrbamaPrediction.HITCHANCE_NORMAL)
end
-- Strut offered to Evade (S6 haste, Normal only): casting W grants the full flat speed at once.
function MissFortuneChampion:OfferDefense()
 local d=self.data
 if not Core.RegisterEffect or not d.wHaste or not finite(d.wDelay)or not finite(d.wHasteSeconds)or type(d.wSource)~='string'then return end
 self.defenseOffered,self.defenseReason,self.defenseAdapter=Core:RegisterEffect({kind='haste',name='MissFortuneViciousStrikes',slot=_W,key=HK_W,
  profile=self.profile.id,source=d.wSource,delay=d.wDelay,duration=d.wHasteSeconds,
  flat=function()local l=myHero:GetSpellData(_W).level;return finite(l)and d.wHaste[l]or nil end,
  ready=function()return not self:LiveBuff(self.profile.wBuff)and not self:IsChannelingR()end})
end
-- E under an enemy dashing onto Miss Fortune (the automatic-E switch and its mana limit apply).
function MissFortuneChampion:AntiDash()
 local function consent()return Menu.Misc.AutoE:Value()and manaAbove(Menu.Misc.AutoMana:Value())end
 if not consent()or not IsReady(_E)then return false end
 local rows=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#rows,16)do local target=rows[i]
  if screen(target)and Core:ApproachingDash(target,myHero.pos,400)then
   return self:CastE(target,function()return consent()and Core:ApproachingDash(target,myHero.pos,400)~=nil end)
  end
 end
 return false
end
-- E as a finisher. Damage per tick from the profile; ticks counted only while the target certainly stays in
-- the circle aimed at its predicted position: its locked time after the cast delay, then the slowed walk
-- to the edge (radius / (ms x (1 - slow))). An unslowed walk during the delay shortens it.
function MissFortuneChampion:ETick(target)
 local d=self.data;local rank=myHero:GetSpellData(_E).level;if not finite(rank)then return nil end
 local raw
 if d.eTick then raw=d.eTick[rank]and d.eTick[rank]+d.eTickAP*myHero.ap
 elseif d.eTotal then raw=d.eTotal[rank]and(d.eTotal[rank]+d.eAP*myHero.ap)/d.eTicks end
 return raw and _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)or nil
end
function MissFortuneChampion:ESlow()
 local d=self.data
 if d.eSlow then return math.min(.99,d.eSlow+(d.eSlowAP or 0)*myHero.ap)end
 local rank=myHero:GetSpellData(_E).level;return d.eSlowRank and d.eSlowRank[rank]
end
function MissFortuneChampion:ETicks(target)
 local d=self.data;local slow=self:ESlow();local ms=target.ms
 if not slow or not finite(ms)or ms<0 then return 0 end
 local lock=GetHardCCDuration(target);local radius=self.ESpell.Radius
 if ms<=0 then return d.eTicks end
 local slowed=ms*(1-slow);local inside
 if lock>=d.eDelay then inside=lock-d.eDelay+radius/slowed
 else local left=radius-ms*(d.eDelay-lock);inside=left>0 and left/slowed or 0 end
 return math.max(0,math.min(d.eTicks,math.floor(inside/d.eInterval)))
end
function MissFortuneChampion:EKills(target)
 if not screen(target)or target.type~=Obj_AI_Hero or GetDistance(target.pos,myHero.pos)>self.ESpell.Range then return false end
 local ticks=self:ETicks(target);if ticks<1 then return false end
 local tick=self:ETick(target);if not tick then return false end
 return(Core:Lethal(target,self.data.eDelay+ticks*self.data.eInterval,function()return ticks*tick end,{kind='magical'}))
end
function MissFortuneChampion:EFinisher()
 if not Menu.Misc.AutoE:Value()or not IsReady(_E)or Core.adapter:ResourceAction(Core.adapter:SlotResource(_E),false)then return false end
 local rows=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#rows,16)do local target=rows[i]
  if self:EKills(target)then
   return self:CastE(target,function()return Menu.Misc.AutoE:Value()and self:EKills(target)end,OrbamaPrediction.HITCHANCE_HIGH,'EFinisher')
  end
 end
 return false
end
function MissFortuneChampion:AutoELogic()
 if not Menu.Misc.AutoE:Value()or not manaAbove(Menu.Misc.AutoMana:Value())or not IsReady(_E)
  or Core.adapter:ResourceAction(Core.adapter:SlotResource(_E),false)then return false end
 local rows=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#rows,16)do local target=rows[i]
  if screen(target)and GetDistance(target.pos,myHero.pos)<=self.ESpell.Range
   and Core:ControlledHit(target,self.ESpell,target.pos)then
   if self:CastE(target,function(q,resolved)
    return Menu.Misc.AutoE:Value()and manaAbove(Menu.Misc.AutoMana:Value())
     and Core:ControlledHit(target,self.ESpell,resolved and resolved.position or q.target)
   end,OrbamaPrediction.HITCHANCE_HIGH)then return true end
  end
 end
 return false
end
function MissFortuneChampion:AutoBounceLogic()
 if not Menu.Misc.AutoBounce:Value()or not manaAbove(Menu.Misc.AutoMana:Value())or not IsReady(_Q)
  or Core.adapter:ResourceAction(Core.adapter:SlotResource(_Q),false)then return false end
 local target=self:PreferredTarget(self:QSearch())
 if not target or target.type~=Obj_AI_Hero or Core:SpellProtected(target)~=false then return false end
 local function firstAllowed(first,at,row)
  -- A champion primary is useful by itself: both hits land on champions.
  if first.type==Obj_AI_Hero then return Core:SpellProtected(first)==false end
  if not Menu.Misc.BounceKillFirst:Value()then return Core:SpellProtected(first)==false end
  if first.type~=Obj_AI_Minion then return false end
  if row then return row.crit==true or self:QLethal(first,false,row.firstTime)end
  local launch=self:QLaunch();if not launch then return false end
  return self:QLethal(first,false,launch+GetDistance(myHero.pos,first.pos)/self.QSpell.Speed)
 end
 return self:QLogic(target,true,function()
  return Menu.Misc.AutoBounce:Value()and manaAbove(Menu.Misc.AutoMana:Value())and Core:SpellProtected(target)==false
 end,'MissFortune.autoBounce',true,firstAllowed)
end
function MissFortuneChampion:OnPreAttack(args)
 if not args or args.Process==false or not screen(args.Target)or not enemyUnit(args.Target)then return end
 local target=args.Target;local menu,context
 if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO]and target.type==Obj_AI_Hero then menu=Menu.Combo;context=Core:ModeContext('Combo')
 elseif _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS]and target.type==Obj_AI_Hero then menu=Menu.Harass;context=Core:ModeContext('Harass')
 elseif target.type==Obj_AI_Minion and Menu.Clear.SpellFarm:Value()then
  local jungle=target.team==300
  if not self:ClearMode(jungle)then return end
  menu=jungle and Menu.Clear.JungleClear or Menu.Clear.LaneClear
   context=Core:FarmContext(jungle and 'jungle'or 'lane',function()return self:ClearMode(jungle)and Menu.Clear.SpellFarm:Value()end)
 end
 if not menu then return end
 local function allowed()
  return menu.W:Value()and self:ManaAllowed(menu)and screen(target)and _G.SDK.Data:IsInAutoAttackRange(myHero,target)
   and not self:LiveBuff(self.profile.wBuff)and not self:IsChannelingR()
 end
 if IsReady(_W)and allowed()then Core:Cast(HK_W,nil,{intentTarget=target,context=context,validate=allowed})end
end
function MissFortuneChampion:KillSteal()
 if not IsReady(_Q)then return end
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,12)do local target=list[i]
  local bounce=screen(target)and not self:InQReach(target)
  -- The cheap pre-check takes the bounce at its best (critical when the profile has it); the exact
  -- crit of the chosen first unit is decided by the validator.
  if self:QLethal(target,bounce,nil,bounce and self.data.qCrit~=nil)and self:QLogic(target,true,function(recipient,isBounce,at,crit)
   return self:QLethal(recipient,isBounce,at,crit)
  end,'QSecure')then return end
 end
end
function MissFortuneChampion:FarmCount(point,jungle)
 local list=self:Objects();if not list then return 0 end
 local count=0
 for i=1,#list do local u=list[i]
  if u.type==Obj_AI_Minion and(u.team==300)==jungle and screen(u)and stationary(u)
   and GetDistance(u.pos,point)<=self.ESpell.Radius then count=count+1 end
 end
 return count
end
function MissFortuneChampion:Farm(jungle)
 local menu=jungle and Menu.Clear.JungleClear or Menu.Clear.LaneClear
 if not self:ClearMode(jungle)or not Menu.Clear.SpellFarm:Value()or not self:ManaAllowed(menu)or not jungle and IsUnderTurret(myHero)then return end
 if not(menu.Q:Value()and IsReady(_Q)or menu.E:Value()and IsReady(_E))then return end
 local list=self:Objects();if not list then return end
 local best;local laneCount=0
 for i=1,#list do local u=list[i]
  if u.type==Obj_AI_Minion and(u.team==300)==jungle and screen(u)and GetDistance(u.pos,myHero.pos)<=self.ESpell.Range then
   if not jungle then laneCount=laneCount+1 end
   if not best or jungle and u.maxHealth>best.maxHealth or not jungle and GetDistance(u.pos,myHero.pos)<GetDistance(best.pos,myHero.pos)then best=u end
  end
 end
 if not best then return end
 local function permission()return self:ClearMode(jungle)and Menu.Clear.SpellFarm:Value()and self:ManaAllowed(menu)and(jungle or not IsUnderTurret(myHero))end
 if menu.E:Value()and IsReady(_E)then
  -- Jungle E is for a group of three or a monster that outlasts three attacks, not for a small leftover.
  local function needed(point)
   if not jungle then return menu.ECount:Value()end
   local attack=_G.SDK.Damage:GetAutoAttackDamage(myHero,best,true)
   return enemyUnit(best)and finite(attack)and best.health>attack*3 and GetDistance(best.pos,point)<=self.ESpell.Radius and 1 or 3
  end
  if self:FarmCount(best.pos,jungle)>=needed(best.pos)then self:CastE(best,function(q,resolved)
   local point=resolved and resolved.position or q.target
   return permission()and menu.E:Value()and self:FarmCount(point,jungle)>=needed(point)
  end,OrbamaPrediction.HITCHANCE_NORMAL)end
 end
 if menu.Q:Value()and IsReady(_Q)and(jungle or laneCount>=3)then
  for i=1,math.min(#list,32)do local u=list[i]
   if u.type==Obj_AI_Minion and(u.team==300)==jungle and self:InQReach(u)and(jungle and u==best or not jungle and self:FarmQLethal(u))then
    if self:QLogic(u,false,function()return permission()and menu.Q:Value()and(jungle or self:FarmQLethal(u))end)then return end
   end
  end
 end
end
function MissFortuneChampion:LaneClear()self:Farm(false)end
function MissFortuneChampion:JungleClear()self:Farm(true)end
function MissFortuneChampion:FarmQLethal(target)
 local delay=self:QDelay();if not delay or not screen(target)then return false end
 local impact=self:QLaunch(delay)+GetDistance(myHero.pos,target.pos)/self.QSpell.Speed
 if not self:QLethal(target,false,impact)then return false end
 local hp=_G.SDK.HealthPrediction:GetPrediction(target,impact)
 return finite(hp)and hp>0 and hp<=self:GetQDmg(target)+self:LoveTapDamage(target)
end
function MissFortuneChampion:CanRescue(target)
 if not Menu.LastHit.Q:Value()or not self:ManaAllowed(Menu.LastHit)or not IsReady(_Q)or not self:FarmQLethal(target)
  or target.type~=Obj_AI_Minion or target.team==300 or not stationary(target)or _G.SDK.Attack:IsActive()then return false end
 if _G.SDK.Data:IsInAutoAttackRange(myHero,target)and _G.SDK.Orbwalker:CanAttack()
  and _G.SDK.Damage:GetAutoAttackDamage(myHero,target,true)>=target.health+(target.shieldAD or 0)then return false end
 local list=self:Objects();if not list then return false end
 local time=self:QDelay()+GetDistance(myHero.pos,target.pos)/self.QSpell.Speed+self.profile.bounceRange/self.QSpell.Speed
 local dx,dz=target.pos.x-myHero.pos.x,target.pos.z-myHero.pos.z;local l=math.sqrt(dx*dx+dz*dz);if l<1 then return false end
 for i=1,#list do local u=list[i]
  if u.networkID~=target.networkID then
   local motion=stationary(u)and 0 or finite(u.ms)and math.max(0,u.ms)*time
   if motion==false or motion==nil or self:BestTier(target.pos,dx/l,dz/l,u.pos,(u.boundingRadius or 0)+motion)<math.huge then return false end
  end
 end
 return true
end
function MissFortuneChampion:LastHit()
 if not Menu.LastHit.Q:Value()then return end
 local list=self:Objects();if not list then return end
 for i=1,math.min(#list,32)do local u=list[i]
  if self:CanRescue(u)and self:QLogic(u,false,function()return self:CanRescue(u)end)then return end
 end
end
function MissFortuneChampion:RPreview(target,point)
 local delay=OrbamaPrediction:GetImpactTime(self.RSpell,point,myHero)
 local window=OrbamaPrediction:AssessHitWindow(target,self.RSpell,point,myHero,.02,Core.validating==true)
 local cc=window.stationaryKnownDuration or 0
 local exposure=math.max(0,math.min(self.profile.channel,cc-delay))
 local rank=myHero:GetSpellData(_R).level
 local waves=math.floor(exposure/self.profile.channel*(self.profile.waves[rank]or 0))
 local raw=AbilityProfiles.MissFortuneRWaveRaw(myHero.charName,rank,myHero.totalDamage,myHero.bonusDamage,myHero.ap)
 local damage=raw and _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
 return {target=target.networkID,handle=target.handle,point=point,ccWaves=waves,at=Game.Timer(),
  waveBaseline=damage,text=damage and 'R: '..math.floor(damage)..' physical per wave; control exposure estimate: '..waves..' waves'or 'R wave damage unknown'}
end
function MissFortuneChampion:RSafe()
 if myHero.dead or IsUnderTurret(myHero)or myHero.maxHealth<=0 or myHero.health/myHero.maxHealth<.5 then return false end
 for _,u in ipairs(_G.SDK.ObjectManager:GetEnemyHeroes(650))do
  if screen(u)and GetDistance(u.pos,myHero.pos)<=650 then return false end
 end
 return true
end
function MissFortuneChampion:RCount(point)
 local shape=AbilityProfiles.geometry[myHero.charName].R
 local dx,dz=point.x-myHero.pos.x,point.z-myHero.pos.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<1 then return 0 end
 local count=0;local tangent=math.tan(shape.angle*math.pi/360)
 local rows=_G.SDK.ObjectManager:GetEnemyHeroes(shape.range)
 for i=1,math.min(#rows,5)do local u=rows[i]
  if screen(u)and u.type==Obj_AI_Hero then
   local x,z=u.pos.x-myHero.pos.x,u.pos.z-myHero.pos.z
   local along=(x*dx+z*dz)/length;local side=math.abs(x*dz-z*dx)/length
   local radius=math.max(0,u.boundingRadius or 0);local arrival=shape.delay+GetDistance(myHero.pos,u.pos)/shape.speed
   if along>radius and along+radius<=shape.range and side+radius<=along*tangent
    and GetHardCCDuration(u)>=arrival+.5 and self:WallFree(myHero.pos,u.pos,shape.delay,u.networkID)then count=count+1 end
  end
 end
 return count
end
function MissFortuneChampion:AutoRLogic()
 if self.profile.rConeVerified~=true then self.autoRUnavailable='profile_R_cone_and_first_wave_semantics_unverified';return false end
 if not Menu.Misc.AutoR:Value()or not IsReady(_R)or not self:RSafe()then return false end
 local rows=_G.SDK.ObjectManager:GetEnemyHeroes(self.RSpell.Range)
 for i=1,math.min(#rows,5)do local target=rows[i]
  if screen(target)then local prediction=Core:Prediction(self.RSpell);prediction:GetPrediction(target,myHero)
   if prediction:CanHit(OrbamaPrediction.HITCHANCE_HIGH)and self:RCount(prediction.CastPosition)>=Menu.Misc.RCount:Value()then
    self.rPreview=self:RPreview(target,prediction.CastPosition)
    return Core:Cast(HK_R,prediction.CastPosition,{owner='MissFortune.autoR',intentTarget=target,range=self.RSpell.Range,
     context={},independent=false,prevalidateWorldCast=true,validate=function(q,resolved)
      return Menu.Misc.AutoR:Value()and self:RSafe()and not self:IsChannelingR()
       and self:RCount(resolved and resolved.position or q.target)>=Menu.Misc.RCount:Value()
     end})
   end
  end
 end
 return false
end
-- R aim (MissFortune-7): the central ray through the most predicted champions (C:BestAim cone, the narrower
-- 30 degree cone less 3 degrees each side) that keeps `target` inside. Returns the cast point (within cast
-- range), the champions in the cone and, when only the target counts, its own bound prediction point.
local R_AIM_MARGIN=3
function MissFortuneChampion:RAim(target,confidence)
 if not screen(target)then return nil end
 local points={}
 for _,u in ipairs(_G.SDK.ObjectManager:GetEnemyHeroes(self.data.rRange))do
  if #points<4 and u~=target and screen(u)then
   local p=Core:Prediction(self.RSpell);p:GetPrediction(u,myHero)
   if p:CanHit(OrbamaPrediction.HITCHANCE_NORMAL)then points[#points+1]={x=p.CastPosition.x,z=p.CastPosition.z,unit=u}end
  end
 end
 local prediction=Core:Prediction(self.RSpell);prediction:GetPrediction(target,myHero)
 if not prediction:CanHit(confidence or OrbamaPrediction.HITCHANCE_NORMAL)then return nil end
 local bound=prediction.CastPosition
 points[#points+1]={x=bound.x,z=bound.z,unit=target}
 local aim,_,hits=Core:BestAim(points,{kind='cone',angle=self.data.rAngle-2*R_AIM_MARGIN,range=self.data.rRange},{must=#points})
 local units={}
 for _,i in ipairs(hits or {})do units[#units+1]=points[i].unit end
 if not aim or #units<=1 then return bound,{target}end
 local dx,dz=aim.x-myHero.pos.x,aim.z-myHero.pos.z;local l=math.sqrt(dx*dx+dz*dz)
 if l<1 then return bound,{target}end
 local d=math.min(l,self.RSpell.Range)
 return Vector(myHero.pos.x+dx/l*d,myHero.pos.y,myHero.pos.z+dz/l*d),units
end
-- Waves of R one enemy takes from an aim: exposure = its locked time plus the walk to the nearest cone edge
-- (or past the far end) at its speed, from the first wave's arrival; whole intervals only, no crits.
function MissFortuneChampion:RWaves(u,aim)
 local d=self.data;local rank=myHero:GetSpellData(_R).level;local maxWaves=self.profile.waves[rank]
 local interval=d.rInterval and d.rInterval[rank]
 if not maxWaves or not interval or not screen(u)or not aim then return 0 end
 local dx,dz=aim.x-myHero.pos.x,aim.z-myHero.pos.z;local l=math.sqrt(dx*dx+dz*dz);if l<1 then return 0 end
 local x,z=u.pos.x-myHero.pos.x,u.pos.z-myHero.pos.z
 local along=(x*dx+z*dz)/l;local side=math.abs(x*dz-z*dx)/l;local half=math.rad(d.rAngle/2)
 if along<=0 or along>d.rRange or side>along*math.tan(half)then return 0 end
 local edge=math.min((along*math.tan(half)-side)*math.cos(half),d.rRange-along)
 local ms=u.ms;local walk=finite(ms)and ms>0 and edge/ms or math.huge
 local inside=GetHardCCDuration(u)+walk
 local first=(self.RSpell.Delay or 0)+d.rFirstWave+along/(self.RSpell.Speed or 2000)
 if inside<first then return 0 end
 return math.min(maxWaves,math.floor((inside-first)/interval)+1),first,interval
end
function MissFortuneChampion:RKills(u,aim)
 local waves,first,interval=self:RWaves(u,aim);if waves<1 then return false end
 local rank=myHero:GetSpellData(_R).level
 local raw=AbilityProfiles.MissFortuneRWaveRaw(myHero.charName,rank,myHero.totalDamage,myHero.bonusDamage,myHero.ap);if not raw then return false end
 return(Core:Lethal(u,first+(waves-1)*interval,function()return waves*_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)end,{kind='physical'}))
end
-- Combo R (Normal, off by default): through C:UltimateWorth, when the waves kill the combo target or enough
-- enemies each take at least half of the waves; RSafe; re-decided at dispatch from the resolved aim.
function MissFortuneChampion:RWorth(target,aim,units)
 local rank=myHero:GetSpellData(_R).level;local half=(self.profile.waves[rank]or 0)/2
 local good,plan={},{}
 for _,u in ipairs(units or {})do local w=self:RWaves(u,aim);plan[u.networkID]=w;if w>=half and w>0 then good[#good+1]=u end end
 self.rPlan=plan
 local ok=Core:UltimateWorth({hits={target},kills=function(u)return self:RKills(u,aim)end})
 if ok then return true,'kill'end
 return Core:UltimateWorth({hits=good,minimum=Menu.Combo.RCount:Value()})
end
function MissFortuneChampion:ComboR()
 local option=Menu.Combo.R;if not option or not option:Value()or not IsReady(_R)or self:IsChannelingR()or not self:RSafe()then return false end
 local target=self:PreferredTarget(self.data.rRange);if not target then return false end
 local aim,units=self:RAim(target,OrbamaPrediction.HITCHANCE_HIGH);if not aim or not self:RWorth(target,aim,units)then return false end
 self.rPreview=self:RPreview(target,aim)
 return Core:Cast(HK_R,aim,{owner='MissFortune.comboR',intentTarget=target,range=self.RSpell.Range,prevalidateWorldCast=true,independent=false,
  validate=function(q,resolved)
   local point=resolved and resolved.position or q.target
   return point~=nil and Menu.Combo.R:Value()and self:RSafe()and not self:IsChannelingR()and screen(target)and self:RWorth(target,point,units)
  end})
end
function MissFortuneChampion:EndER(reason)
 local plan=self.erPlan;if not plan then return end;self.erPlan=nil
 Core:Cancel('MissFortune.ER',reason);Core.adapter:CancelGroup(plan.group,reason)
end
function MissFortuneChampion:ERLogic()
 local plan=self.erPlan;local held=Menu.Misc.ER:Value()
 if plan and(not held or Core.adapter:Now()>=plan.expires or not screen(plan.target)
   or plan.target.networkID~=plan.targetID or plan.target.handle~=plan.targetHandle)then self:EndER('ER_context_ended');return false end
 if not held then return false end
 if not plan then
  if not IsReady(_E)or not IsReady(_R)or not self:RSafe()then return false end
  local target=self:AssistTarget(math.min(self.ESpell.Range,self.RSpell.Range));if not target then return false end
  if myHero.mana<myHero:GetSpellData(_E).mana+myHero:GetSpellData(_R).mana then return false end
  local ep=Core:Prediction(self.ESpell);ep:GetPrediction(target,myHero)
  local rp=Core:Prediction(self.RSpell);rp:GetPrediction(target,myHero)
  if not ep:CanHit(OrbamaPrediction.HITCHANCE_HIGH)or not rp:CanHit(OrbamaPrediction.HITCHANCE_HIGH)then return false end
  local context=Core:HeldContext(function()return Menu.Misc.ER:Value()end);local expires=Core.adapter:Now()+1200
   local group=Core.adapter:CreateGroup('MissFortune.ER',{expires=expires,context=context,
    resources={Core.adapter:SlotResource(_E),Core.adapter:SlotResource(_R)}})
  if not group then return false end
   plan={target=target,targetID=target.networkID,targetHandle=target.handle,group=group,expires=expires};self.erPlan=plan
  local ok=Core:Cast(HK_E,ep.CastPosition,{owner='MissFortune.ER',group=group,context=context,intentTarget=target,
   range=self.ESpell.Range,prevalidateWorldCast=true,independent=false,validate=function()
     return Menu.Misc.ER:Value()and self.erPlan==plan and target.handle==plan.targetHandle and IsReady(_R)and self:RSafe()
     and myHero.mana>=myHero:GetSpellData(_E).mana+myHero:GetSpellData(_R).mana
   end})
  if not ok then self:EndER('E_refused');return false end
  Core:AfterCast(HK_E,function(q)if self.erPlan==plan then plan.observed=true;plan.eID=q.id end end)
  return true
 end
 if plan.rID then return true end
 if not plan.observed or IsCasting()then return true end
 local target=plan.target;local aim=self:RAim(target,OrbamaPrediction.HITCHANCE_HIGH)
 if not IsReady(_R)or not self:RSafe()or not aim then return true end
 local ok=Core:Cast(HK_R,aim,{owner='MissFortune.ER',group=plan.group,dependency=plan.eID,
  dependencyState='mechanical',context=Core:HeldContext(function()return Menu.Misc.ER:Value()end),
  intentTarget=target,range=self.RSpell.Range,independent=false,validate=function()
    return Menu.Misc.ER:Value()and self.erPlan==plan and target.handle==plan.targetHandle
     and plan.observed and self:RSafe()and not self:IsChannelingR()
  end})
 if ok then plan.rID=Core.lastIntent.id end
 return true
end
-- Target for a held R bind: the selected target, else the enemy nearest the cursor within 400, else the
-- target selector's (holding the key is the consent).
function MissFortuneChampion:AssistTarget(range)
 local selected=_G.SDK.TargetSelector.Selected
 if screen(selected)and GetDistance(selected.pos,myHero.pos)<=range then return selected end
 local cursor=mousePos;local best,near
 if cursor then
  for _,u in ipairs(_G.SDK.ObjectManager:GetEnemyHeroes(range))do
   if screen(u)and GetDistance(u.pos,myHero.pos)<=range then local d=GetDistance(u.pos,cursor);if d<=400 and(not near or d<near)then best,near=u,d end end
  end
 end
 return best or self:PreferredTarget(range)
end
function MissFortuneChampion:SemiRLogic()
 if not Menu.Misc.R:Value()or not IsReady(_R)or self:IsChannelingR()then return end
 local target=self:AssistTarget(self.RSpell.Range);if not target then return end
 local aim=self:RAim(target,OrbamaPrediction.HITCHANCE_NORMAL);if not aim then return end
 self.rPreview=self:RPreview(target,aim)
 return Core:Cast(HK_R,aim,{intentTarget=target,range=self.RSpell.Range,prevalidateWorldCast=true,independent=false,validate=function()
  return Menu.Misc.R:Value()and not self:IsChannelingR()and screen(target)
 end})
end
-- Health-bar estimate (S9): ready Q (with an eligible Love Tap), the E ticks it would surely deal, one attack.
function MissFortuneChampion:ComboDamage(u)
 if not screen(u)then return 0 end
 local total=_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0
 -- One mark, one Love Tap: the SDK attack estimate already carries it when its own observation credits it.
 local service=_G.SDK.Damage.GetMissFortuneLoveTap
 local inAttack=service and(service(_G.SDK.Damage,myHero,u)or 0)>0
 if IsReady(_Q)then total=total+self:GetQDmg(u)+(inAttack and 0 or self:LoveTapDamage(u))end
 if IsReady(_E)then local tick=self:ETick(u);if tick then total=total+tick*self:ETicks(u)end end
 return finite(total)and total or 0
end
function MissFortuneChampion:Tick()
 self:SyncChannel();self:ObserveHits()
 if Core.logger then self:FlushQTrace()end
 if self.erPlan and(not Menu.Misc.ER:Value()or Core.adapter:Now()>=self.erPlan.expires)then self:EndER('ER_context_ended')end
 if self:IsChannelingR()or ShouldWait()or IsCasting()then return end
 if self:ERLogic()or self:AutoRLogic()then return end
 self:SemiRLogic();self:KillSteal();self:EFinisher()
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then
  if self:ClearMode(false)then self:FarmHarass();self:LaneClear()end
  if self:ClearMode(true)then self:JungleClear()end
  elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
  self:AntiDash();self:AutoELogic();self:AutoBounceLogic()
end
function MissFortuneChampion:Draw()
 if myHero.dead then return end
 for _,entry in ipairs({{'Q',_Q,self:QReach(nil)or self.QSpell.Range},{'E',_E,self.ESpell.Range},{'R',_R,self.RSpell.Range}})do
  if Menu.Draw[entry[1]]:Value()and IsReady(entry[2])then Draw.Circle(myHero.pos,entry[3],1,Draw.Color(255,66,244,113))end
 end
 -- The last certified bounce plan (stored when it was planned; never recomputed here).
 local plan=self.bouncePreview
 -- Kept up to half a second (a skipped decision tick must not blink it) while Q is ready.
 if Menu.Draw.Bounce:Value()and plan and Game.Timer()-plan.at>=0 and Game.Timer()-plan.at<=.5 and IsReady(_Q)then
  local color=plan.crit and Draw.Color(255,255,80,80)or Draw.Color(255,255,200,60)
  Draw.Circle(plan.first,60,1,color);Draw.Circle(plan.recipient,80,2,color)
  if Draw.Line then local a,b=plan.first:To2D(),plan.recipient:To2D();Draw.Line(a.x,a.y,b.x,b.y,1,color)end
 end
 local preview=self.rPreview
 if Menu.Draw.RPreview:Value()and preview and Game.Timer()-preview.at>=0 and Game.Timer()-preview.at<1 then
  Draw.Text(preview.text,14,myHero.pos2D.x-57,myHero.pos2D.y+98,Draw.Color(255,225,225,225))
 end
end
function MissFortuneChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},bounce={node=Menu.Combo.Q2,label='Combo bounce Q'},w={node=Menu.Combo.W,label='Combo W'},e={node=Menu.Combo.E,label='Combo E'},
  farm={node=Menu.Clear.SpellFarm,label='Spell farming'},last={node=Menu.LastHit.Q,label='Last Hit Q'},
  assist={node=Menu.Misc.R,label='Hold R assist'},
   reserve={node=Menu.Combo.EReserveR,label='E reserves ready R mana'},count={node=Menu.Clear.LaneClear.ECount,label='Lane E minimum targets'},
   autoe={node=Menu.Misc.AutoE,label='Independent E on control'},autoq={node=Menu.Misc.AutoBounce,label='Independent Q bounce'},
   killfirst={node=Menu.Misc.BounceKillFirst,label='Independent bounce requires lethal first minion'},
   er={node=Menu.Misc.ER,label='Hold E then R'}}
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 local normal=self.profile.id=='normal'
 return guide:Register('champion',{'Miss Fortune: quick start','Miss Fortune: bounce and attacks','Miss Fortune: R and farming'},function(page)
  if page==1 then return {title=self.profile.id=='classic'and 'Classic Miss Fortune'or 'Miss Fortune',subtitle='Use your provider mode keys.',cards={
   {'COMBAT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..' for [[q]], [[bounce]], [[w]] and [[e]]. W assists an eligible attack attempt and respects a prior attack veto. In attack reach Q goes out right after an attack; a shot that hits two champions comes first.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. Harass has separate Q, bounce, W and E switches plus a mana minimum.'},
   {'RESOURCES','[[reserve]] keeps mana for a ready R when Combo uses E. A killable enemy is always finished with Q (direct or bounced) without a mode key; [[autoe]] also finishes with E when its ticks surely kill.'}},note='Release the triggering mode or held key to cancel its waiting action. '}end
  if page==2 then return {title='Bounce and attacks',subtitle='A bounce is a plan for two separate targets.',cards={
    {'BOUNCE','The first target may walk; the bounce is planned from where it will stand. The recipient must surely be the first choice behind it, with no other unit that could take the bounce. A new competitor, dead first target, changed recipient or wind wall cancels the shot. [[autoq]] bounces Q onto champions without a mode key; [[killfirst]] requires the first minion to die from the conservative Q damage estimate.'},
   {'PROFILE',normal and 'Normal Q reaches as far as an attack and uses the published bounce priorities. When Q kills the first unit the bounce is a critical strike (more with Infinity Edge), and Love Tap is counted on a direct hit only after an observed attack on another unit.'or 'Classic Q has separate base/AD damage and a 120% second hit and keeps a narrow 60 degree bounce cone. Impure Shots uses four stacks in the assets, but native owned stack and hit-order evidence remains incomplete.'},
    {'ATTACKS','The provider owns attack timing. [[autoe]] casts E on an immobilised enemy without a mode key. Explicit target selection is preserved where the selected target is eligible.'}},note=normal and 'Fleeing uses W for its speed, then E on the nearest pursuer; E also answers an enemy dashing onto you. Evade may use W to walk out of a spell.'or 'Fleeing uses E on the nearest pursuer (Classic W gives no speed); E also answers an enemy dashing onto you.'}end
  return {title='Bullet Time and farming',subtitle='Hold [[assist]] for a predicted cone aim through as many enemies as possible.',cards={
    {'BULLET TIME','Orbwalking pauses while R channels. [[assist]] aims at the selected target, else the enemy nearest the cursor. [[er]] casts E, then a freshly aimed R; releasing the key cancels what was not sent yet. Right-click to cancel the channel yourself.'..(normal and ' Combo R (off by default) needs its waves to kill the target or enough enemies in the cone.'or '')},
   {'CLEAR','Enable [[farm]] and hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..'. Lane E requires [[count]] current stationary targets. Jungle permissions are separate even when both modes share a key.'},
   {'LAST HIT','With [[farm]] on, hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT)..'. Q rescues a lethal minion only when incoming death, a ready lethal AA, current windup and possible bounce collateral do not rule it out.'}},note='R waves count only the time an enemy surely stays in the cone. Impure Shots and item procs are not counted. Clear and Last Hit use different damage permissions.'}
 end,cfg,links,activate)
end
Core:RegisterPolicy({
 damageTypes={Q='physical'},
 methods={Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
   LaneClear=function(self)return Core:FarmContext('lane',function()return self:ClearMode(false)and Menu.Clear.SpellFarm:Value()end)end,
   JungleClear=function(self)return Core:FarmContext('jungle',function()return self:ClearMode(true)and Menu.Clear.SpellFarm:Value()end)end,
  LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end,
  FarmHarass=function(self)return Core:ModeContext('LaneClear',function()return self:ClearMode(false)and Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)end)end,
  AntiDash=function()return {priority='interactive',condition=function()return Menu.Misc.AutoE:Value()end}end,
  KillSteal=function()return {priority='interactive'}end,QSecure=function()return {priority='interactive'}end,
  EFinisher=function()return {priority='interactive',condition=function()return Menu.Misc.AutoE:Value()end}end,
   SemiRLogic=function()return Core:HeldContext(function()return Menu.Misc.R:Value()end)end,
   AutoELogic=function()return {priority='interactive',condition=function()return Menu.Misc.AutoE:Value()end}end,
   AutoBounceLogic=function()return {priority='background',condition=function()return Menu.Misc.AutoBounce:Value()end}end},
  exceptions={non_interrupting_summoner=true},
 channel=function(self)return not self:IsChannelingR()and not Core:SelfChanneling()end,
})
MissFortuneChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_MissFortune"]="MissFortune"}
local normalSupported={["MissFortune"]=true}

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
