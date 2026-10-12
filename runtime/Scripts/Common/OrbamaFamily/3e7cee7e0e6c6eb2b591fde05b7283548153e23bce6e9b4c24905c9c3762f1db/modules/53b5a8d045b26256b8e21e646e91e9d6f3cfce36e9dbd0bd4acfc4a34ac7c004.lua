return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Irelia"]=function()return _G.OrbamaFamily:Require("984c011b2e2891658da62ee1b77239975effcd7cac3c343f9a4e6fc156539cac")()end
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
if champion=="Irelia" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Irelia',profiles={normal=true,classic=true},
 Create=function(context)
-- Farming under an enemy turret (both profiles). A farming landing inside an
-- enemy turret's range is allowed only while that turret is shooting an allied
-- minion, at least two allied minions stand in its range to take the next
-- shots, and no enemy champion is within 600 of the landing. Combat landings
-- never use this. Turret reach: 775 plus bounding radii, as the Normal check.
local function TurretFarmable(g,pos)
 local om=g.SDK and g.SDK.ObjectManager;local hero=g.myHero
 if not pos or not om or type(om.GetEnemyTurrets)~='function'or type(om.GetAllyMinions)~='function'or type(om.GetEnemyHeroes)~='function'then return false,'objects_unavailable'end
 local function far(a,b)local x,z=a.x-b.x,a.z-b.z;return math.sqrt(x*x+z*z)end
 local allies=om:GetAllyMinions(2000)or {}
 for _,t in ipairs(om:GetEnemyTurrets(2000)or {})do
  if t and t.valid~=false and not t.dead and t.pos and far(t.pos,pos)<775+(t.boundingRadius or 0)+(hero.boundingRadius or 0)then
   local reach=775+(t.boundingRadius or 0);local tanking,count=false,0
   for i=1,math.min(#allies,32)do local m=allies[i]
    if m and m.valid~=false and not m.dead and m.pos and far(m.pos,t.pos)<=reach then
     count=count+1;if t.targetID~=nil and t.targetID~=0 and(m.networkID==t.targetID or m.handle==t.targetID)then tanking=true end
    end
   end
   if not tanking then return false,'turret_not_on_minion'end
   if count<2 then return false,'too_few_allied_minions'end
  end
 end
 for _,u in ipairs(om:GetEnemyHeroes(1600)or {})do
  if u and not u.dead and u.visible~=false and u.pos and far(u.pos,pos)<600 then return false,'enemy_champion_near'end
 end
 return true
end
local GameplayHooks=(function(g,C,P)
 local H,G,SDK=g.myHero,g.Game,g.SDK
 local function finite(v)return P.Finite(v)end
 local function owner(u)return u and(u.networkID or u.handle)end
 local function permission(f,mode,slot)return function()return f:Permission(mode,slot)end end
 local function hp(u)return u.health/u.maxHealth end
  local function channel(u)return u and C:IsChannelCast(u.activeSpell,false)end
 local Hooks={}

 function Hooks.menu(f,m)
  m.Misc:MenuElement({id='Stun',name='Save E for the stun while in attack range',value=true})
  m.Misc:MenuElement({id='InterruptE',name='Interrupt channels with E without a mode key',value=true})
 end
 function Hooks.qDamage(f,u)
  local value=f:Damage(0,u)
  if SDK.Damage.GetIreliaQOnHitDamage then value=value+SDK.Damage:GetIreliaQOnHitDamage(H,u,{at=G.Timer()+f:Impact(0,u)})
  elseif f:Buff(H,f.profile.wNames)then value=value+f:Damage(1,u)end
  return value
 end
 -- True when Q alone kills this unit from its current health. The refund only
 -- comes with the kill, so it must not depend on anyone else's hit landing
 -- first (live 2026-10-08: one clear Q in three left the minion alive and Q on
 -- full cooldown). The forecast only confirms the unit is still alive on arrival.
 -- The shared kill rule (C:Lethal, opts.now) is this check, generalised.
 function Hooks.qKills(f,u)
  local hero=u.type==g.Obj_AI_Hero
  return(C:Lethal(u,hero and 0 or f:Impact(0,u),function()return Hooks.qDamage(f,u)end,
   hero and {now=true,margin=1,flat=0,protection=false}or {now=true}))
 end
 -- Seconds from `origin` to a dash onto `to` (profile cast delay and speed).
 function Hooks.qTravel(f,origin,to)local q=f.profile.q;return(q.delay or 0)+f.distance(origin,to)/q.speed end
 -- Q kills `u` from its current health when cast from `origin` after `offset`
 -- seconds (the earlier hops of a route); the forecast only confirms it lives.
 function Hooks.qKillsAt(f,u,origin,offset)
  return(C:Lethal(u,offset+Hooks.qTravel(f,origin,u.pos),function()return Hooks.qDamage(f,u)end,{now=true}))
 end
 -- A farming landing: the usual offensive check, or under an enemy turret that
 -- is busy with allied minions (TurretFarmable) when the turret was the only reason.
 function Hooks.farmSafe(f,pos)
  pos=f.point(pos);if not pos then return false end
  if f:Safe(pos,true)then return true end
  if type(G.isWall)~='function'or G.isWall(pos)~=false or not g.IsUnderTurret2(pos)then return false end
  if not finite(H.health)or not finite(H.maxHealth)or H.maxHealth<=0 or H.health/H.maxHealth*100<f.menu.Misc.HP:Value()then return false end
  return(TurretFarmable(g,pos))
 end
 -- opts.farm: farming landing rule (Hooks.farmSafe); opts.offense=false: an
 -- escape dash, judged by terrain and turrets only.
 function Hooks.castQ(f,u,context,allowed,requireKill,opts)
  opts=opts or {}
  local function landing()if opts.farm then return Hooks.farmSafe(f,u.pos)end;return f:Safe(u.pos,opts.offense~=false)end
  if f.sequences.q or not f:Ready(0)or not f:Reach(u,f:Range(0))or not landing()then return false end
  if u.type==g.Obj_AI_Hero and not f.menu.Misc.Risk:Value()and not f:AttackReach(u)then return false end
  local function lethal()return Hooks.qKills(f,u)end
  if requireKill and not lethal()then return false end
  local seq={target=u,identity=owner(u),handle=u.handle,context=context,expires=G.Timer()+1.5,origin=f.point(H.pos),allowDead=true}
  -- Farming contexts are background work, dispatched only after the orbwalker
  -- had its turn in a tick. A Q that kills is refunded and takes the last hit:
  -- it goes ahead of move and attack clicks (live 2026-10-08: such a Q waited
  -- up to 2 s and only ever went out right after an attack).
  local accepted,q=f:Cast(0,u,context,{permission=allowed,priority=(requireKill or lethal())and 'normal' or nil,
   check=function()return(not f.sequences.q or f.sequences.q==seq)and landing()and(not requireKill or lethal())end,
   after=function(intent)if f.sequences.q==seq then seq.observed=true;seq.observedAt=G.Timer();seq.cast=intent.spellName;seq.nativeStart=H.activeSpell and H.activeSpell.startTime end end})
  if accepted then seq.action=q.id;seq.intent=q;f.sequences.q=seq end;return accepted
 end
 function Hooks.continue(f,key,s)
  if key=='q'then
   local dash=H.pathing;local dashing=dash and dash.isDashing==true
   if s.observed and dashing and f.distance(H.pos,s.origin)>25 then s.dash=true end
   local killed=s.target.dead==true or s.target.health<=0
   -- The sequence only keeps a second Q from being queued on top of this one.
   -- It ends on the first solid evidence: the refund itself (target dead and Q
   -- ready again), the observed dash having ended, or, for a dash too short to
   -- be seen, a moment after the cast. Live 2026-10-08: it waited for a native
   -- cast timestamp that was never available and always ran to its 1.5 s
   -- expiry, so a zero-cooldown Q was used once every 1.5 to 2 s.
   local refunded=s.observed and killed and f:Ready(0)
   if refunded or s.observed and not dashing and(s.dash or G.Timer()-s.observedAt>.3)then
    local same=true;for _,row in ipairs(C:DecisionUnits(s.target.type==g.Obj_AI_Hero and 'GetEnemyHeroes'or s.target.team==300 and 'GetMonsters'or 'GetEnemyMinions'))do if owner(row)==s.identity and row.handle~=s.handle then same=false end end
    if same and killed and f:Ready(0)then f.lastReset={id=s.identity,at=G.Timer(),kind='kill_refund_observed'}end
    if s.farm then s.farm.target=s.target;s.farm.at=G.Timer()+.3;s.farm.seconds=G.Timer()-s.observedAt;s.farm.dashSeen=s.dash==true;f.qFarmResult=s.farm end
    f.sequences.q=nil
   end
  elseif key=='r'and s.observed then
   local spell=H:GetSpellData(3)
   if s.remaining<=0 or not spell or spell.name~='Jade_IreliaR'then f.sequences.r=nil;return end
   if f:Ready(3)and G.Timer()-s.observedAt>=.15 then
    local allowed=function()return f:SequenceValid(s)and f:Permission(s.mode,3)end
    Hooks.castR(f,s.target,s.context,allowed,s)
   end
  end
 end
 function Hooks.castE(f,u,context,allowed)
  -- E stuns a target with more health % than Irelia and only slows otherwise.
  -- Holding it for the stun is right while she is hitting the target; once the
  -- target is out of attack reach the slow is what keeps the fight going.
  local function useful()return not f.menu.Misc.Stun:Value()or hp(u)>hp(H)or channel(u)or hp(u)<=.25 or not f:AttackReach(u)end
  if not useful()then return false end
  return f:Cast(2,u,context,{permission=allowed,check=useful})
 end
 -- Classic E stuns only a target with a higher health share than Irelia's
 -- (profile eStun, 1 to 2 s); otherwise it only slows, which stops neither a
 -- dash nor a channel. Both answers below are skipped when the stun cannot apply.
 function Hooks.stuns(u)return hp(u)>hp(H)end
 function Hooks.gapclose(f)
  return f:Gapclose(function(_,u,context,allowed)
   if not Hooks.stuns(u)then return false end
   return f:Cast(2,u,context,{permission=allowed,check=function()return Hooks.stuns(u)end})
  end,2)
 end
 -- Channels within E range, without a mode key, bound to the observed cast.
 function Hooks.background(f)
  if not f.menu.Misc.InterruptE:Value()or not f:Ready(2)then return false end
  for _,u in ipairs(f:Rows('hero',f:Range(2)))do
   if f:Allowed(u)and Hooks.stuns(u)and C:CanInterrupt(u,f:Impact(2,u))then
    local name,start=u.activeSpell.name,u.activeSpell.startTime
    local function open()local a=u.activeSpell
     return f.menu.Misc.InterruptE:Value()and Hooks.stuns(u)and a and a.name==name and a.startTime==start and C:CanInterrupt(u,f:Impact(2,u))
    end
    if f:Cast(2,u,{priority='interactive',condition=function()return f.menu.Misc.InterruptE:Value()end},{permission=open,check=open})then return true end
   end
  end
  return false
 end
 function Hooks.castW(f,u,context,allowed)
  if f:Buff(H,f.profile.wNames)or not f:AttackReach(u)then return false end
  return f:Cast(1,nil,context,{selfCast=true,permission=allowed,check=function()return f:AttackReach(u)and not f:Buff(H,f.profile.wNames)end})
 end
 function Hooks.castR(f,u,context,allowed,sequence)
  if not f:Ready(3)then return false end
  return f:Cast(3,u,context,{world=true,permission=allowed,after=function(q)
   local seq=sequence or {target=u,identity=owner(u),handle=u.handle,context=context,expires=G.Timer()+8,remaining=f.profile.rBlades,mode=context.mode or 'Combo'}
   seq.action=q.id;seq.intent=q;seq.observed=true;seq.observedAt=G.Timer();seq.remaining=seq.remaining-1;f.sequences.r=seq
  end})
 end
 -- Q route through units Q kills (each refunds Q). A champion target: prefer
 -- the first hop from which a chain of at most three refunded hops ends within
 -- Q range of it; every later hop must kill from current health at its own
 -- arrival (the sum of the earlier dashes). Without such a chain the hop with
 -- the most progress is taken, as before. Only the first hop is cast; the next
 -- is planned again after the refund. At most 12 units and 48 kill checks.
 -- `offense=false` (Flee) judges landings by terrain and turrets only.
 function Hooks.route(f,u,context,allowed,offense,chainOnly)
  if f.sequences.q then return false end
  local range=f:Range(0);local goal=u.pos;local champion=u.type==g.Obj_AI_Hero;local budget=48
  local function safe(p)return f:Safe(p,offense~=false)end
  local function kills(v,origin,offset)if budget<=0 then return false end;budget=budget-1;return Hooks.qKillsAt(f,v,origin,offset)end
  local rows={};for _,kind in ipairs({'lane','jungle'})do for _,v in ipairs(f:Rows(kind,champion and range*2 or range))do if #rows<12 then rows[#rows+1]=v end end end
  local before=f.distance(H.pos,goal);local first={}
  for _,v in ipairs(rows)do
   local progress=before-f.distance(v.pos,goal)
   if f.distance(H.pos,v.pos)<=range and progress>100 and safe(v.pos)and kills(v,H.pos,0)then
    first[#first+1]={unit=v,progress=progress,t=Hooks.qTravel(f,H.pos,v.pos)}
   end
  end
  table.sort(first,function(a,b)return a.progress>b.progress end)
  local best,depth=first[1]and first[1].unit,first[1]and 1
  if champion and first[1]then
   local function reaches(p)return f.distance(p,goal)<=range end
   local function chain(pos,t,level,visited)
    if level>3 then return nil end
    for _,v in ipairs(rows)do
     if not visited[v]and f.distance(pos,v.pos)<=range and f.distance(pos,goal)-f.distance(v.pos,goal)>100 and safe(v.pos)and kills(v,pos,t)then
      if reaches(v.pos)then return level end
      visited[v]=true;local found=chain(v.pos,t+Hooks.qTravel(f,pos,v.pos),level+1,visited);visited[v]=nil
      if found then return found end
     end
    end
   end
   local found
   for _,n in ipairs(first)do if reaches(n.unit.pos)then found=n;depth=1;break end end
   for i=1,math.min(#first,3)do if found then break end
    local n=first[i];local level=chain(n.unit.pos,n.t,2,{[n.unit]=true});if level then found=n;depth=level end
   end
   if found then best=found.unit elseif chainOnly then return false end
  end
  if chainOnly and not(champion and first[1])then return false end
  if best and Hooks.castQ(f,best,context,allowed,true,{offense=offense})then
   C:Trace('irelia_route',{profile='classic',hops=depth,checks=48-budget,target=champion and u.charName or 'cursor'},.5);return true
  end
  return false
 end
 function Hooks.combat(f,u,mode,context)
  if f:Permission(mode,2)and Hooks.castE(f,u,context,permission(f,mode,2))then return true end
  if f:Permission(mode,1)and Hooks.castW(f,u,context,permission(f,mode,1))then return true end
  if f:Permission(mode,0)then
   -- Out of attack reach, a minion Q kills on the way comes first: its refund
   -- leaves Q ready for the champion, two dashes for the price of one.
   local far=mode=='Combo'and not f:AttackReach(u)
   if far and Hooks.route(f,u,context,permission(f,mode,0))then return true end
   if Hooks.castQ(f,u,context,permission(f,mode,0),false)then return true end
   if mode=='Combo'and not far and Hooks.route(f,u,context,permission(f,mode,0))then return true end
  end
  return f:Permission(mode,3)and Hooks.castR(f,u,context,permission(f,mode,3))or false
 end
 -- Runs every tick. Writes the settled outcome of a farming Q.
 function Hooks.observe(f)
  local r=f.qFarmResult
  if r and G.Timer()>=r.at then
   f.qFarmResult=nil
   C:Trace('irelia_q_farm',{mode=r.mode,name=r.name,expectedHealth=r.health,expectedDamage=r.damage,
    killed=r.target.dead==true or(r.target.health or 0)<=0,healthAfter=r.target.health,refunded=f:Ready(0),
    seconds=r.seconds,dashSeen=r.dashSeen})
  end
 end
 function Hooks.cleanup(f)
  C:ReleaseAttackPreference('IreliaQSetup');f.qFarmResult=nil
 end
 function Hooks.farmDamage(f,slot,u,damage)return slot==0 and Hooks.qDamage(f,u)or damage end
 function Hooks.farm(f,u,rows,mode,context,last)
  -- A killing Q is refunded, so every minion it kills is a free last hit, in
  -- LastHit as well as while clearing. Take the weakest killable one first:
  -- it is the one most likely to be lost to someone else's hit.
  if f:Permission(mode,0)and not f.sequences.q then
   local best=C:LethalPick(rows,function(v)return Hooks.qKills(f,v)end,function(v)return f:Reach(v,f:Range(0))end)
   if best and Hooks.castQ(f,best,context,function()return f:Permission(mode,0)end,true,{farm=true})then
    -- Evidence for the kill estimate: what was expected, then what happened.
    f.sequences.q.farm={mode=mode,health=best.health,damage=Hooks.qDamage(f,best),name=best.charName}
    return true
   end
   -- Nothing dies to Q yet. While clearing, attack the minion that one basic
   -- attack brings into Q's kill range: attack, then Q, then the refund, which
   -- is the wave-clear rhythm the kit is built for (live 2026-10-08: Q stood
   -- ready while minions sat a few health above its damage). The shared attack
   -- preference (C:PreferAttack) lasts a quarter second and is renewed here each
   -- tick, so it can never leak into another mode.
   if not last and not best and f:Ready(0)then
    local pick=C:AttackPreferred('IreliaQSetup')
    if not(pick and f:Current(pick)and f:AttackReach(pick))then
     pick=nil
     for _,v in ipairs(rows)do
      if f:AttackReach(v)and not Hooks.qKills(f,v)then
       local after=v.health-SDK.Damage:GetAutoAttackDamage(H,v,true)
       if after>0 and Hooks.qDamage(f,v)*.97>=after+2 and(not pick or v.health<pick.health)then pick=v end
      end
     end
    end
    if pick then C:PreferAttack('IreliaQSetup',pick,.25)end
   end
   -- W's on-hit damage rides on Q. When that alone turns a minion in Q range
   -- into a kill, W pays for itself with the refund (live 2026-10-08: Q stood
   -- ready for 1.5 s on a minion 16 health above its damage while Irelia walked
   -- into attack reach). Kept above 40 % mana so it never starves the fight.
   if not best and f:Ready(0)and f:Ready(1)and not f:Buff(H,f.profile.wNames)and C.manaAbove(40)then
    for _,v in ipairs(rows)do
     if f:Reach(v,f:Range(0))and Hooks.farmSafe(f,v.pos)and(Hooks.qDamage(f,v)+f:Damage(1,v))*.97>=v.health+2
      and f:Cast(1,nil,context,{selfCast=true,permission=function()return f:Permission(mode,0)end,
       check=function()return f:Ready(0)and not f:Buff(H,f.profile.wNames)end})then return true end
    end
   end
   -- Why nothing was cast although Q is ready: the closest call among the
   -- minions in range (throttled; development recording only).
   if f:Ready(0)and G.Timer()>=(f.qIdleTraceAt or 0)then
    f.qIdleTraceAt=G.Timer()+.5
    local inRange,closest,margin=0,nil,nil
    for _,v in ipairs(rows)do if f:Reach(v,f:Range(0))then
     inRange=inRange+1;local need=v.health-Hooks.qDamage(f,v)*.97
     if not margin or need<margin then closest,margin=v,need end
    end end
    C:Trace('irelia_q_idle',{mode=mode,rows=#rows,inRange=inRange,chosen=best and best.charName or nil,
     closest=closest and closest.charName or nil,closestHealth=closest and closest.health or nil,
     closestDamage=closest and Hooks.qDamage(f,closest)or nil,missingDamage=margin,
     safe=closest and Hooks.farmSafe(f,closest.pos)or nil,wActive=f:Buff(H,f.profile.wNames)~=nil})
   end
  end
  if last then return false end
  if mode=='JungleClear'and f:Permission(mode,1)and Hooks.castW(f,u,context,permission(f,mode,1))then return true end
  return mode=='JungleClear'and f:Permission(mode,2)and Hooks.castE(f,u,context,permission(f,mode,2))or false
 end
 function Hooks.flee(f,context)
  local cursor=f.point(g.mousePos);if not cursor then return false end
  if f:Permission('Flee',0)then
   if Hooks.route(f,{pos=cursor},context,permission(f,'Flee',0),false)then return true end
   local u=Hooks.fleeUnit(f,cursor)
   if u and Hooks.castQ(f,u,context,function()return f:Permission('Flee',0)and Hooks.fleeUnit(f,cursor,u)==u end,false,{offense=false})then return true end
  end
  local u=f:Target(325);return u and f:Permission('Flee',2)and Hooks.castE(f,u,context,permission(f,'Flee',2))or false
 end
 -- Flee without a refunded hop: one Q onto a lane or jungle unit that moves
 -- Irelia at least 300 toward the cursor and lands among fewer enemy champions
 -- than stand around her now. Q then goes on its full cooldown. `only`
 -- re-checks a chosen unit at dispatch.
 function Hooks.fleeUnit(f,cursor,only)
  local here=g.GetEnemyCount(600,H.pos);if here<=0 then return nil end
  local before=f.distance(H.pos,cursor);local best,bestProgress,count=nil,nil,0
  for _,kind in ipairs({'lane','jungle'})do for _,v in ipairs(f:Rows(kind,f:Range(0)))do
   count=count+1;if count>12 then break end
   local progress=before-f.distance(v.pos,cursor)
   if(not only or v==only)and progress>=300 and f:Safe(v.pos,false)and g.GetEnemyCount(600,v.pos)<here and(not bestProgress or progress>bestProgress)then best,bestProgress=v,progress end
  end;if count>12 then break end end
  return best
 end
 -- Evade may dodge by dashing onto a unit (SDK.ChampionMobility 'unitDash').
 -- Where Q ends relative to its target is not established for this profile
 -- (the controller only observes the hero within 125 of a killed target), so
 -- both the unit's position and the near-side contact point (bounding radii
 -- short of it) are declared and Evade requires every one to be safe.
 function Hooks.evadeLandings(f,u)
  local to=f.point(u.pos);if not to then return {}end
  local d=f.distance(H.pos,to);local gap=(u.boundingRadius or 0)+(H.boundingRadius or 0)
  if d<=gap+1 then return {to}end
  return {to,f.point({x=to.x+(H.pos.x-to.x)/d*gap,y=to.y,z=to.z+(H.pos.z-to.z)/d*gap})}
 end
 -- u=nil: unit-independent readiness. The controller's own dash rules apply.
 function Hooks.evadeAllowed(f,u)
  if f.sequences.q or H.pathing and H.pathing.isDashing then return false,'q_in_flight'end
  if not u then return true end
  if not f:Reach(u,f:Range(0))or not f:Allowed(u)then return false,'target_invalid'end
  if u.type==g.Obj_AI_Hero and not f.menu.Misc.Risk:Value()and not f:AttackReach(u)then return false,'champion_policy'end
  for _,p in ipairs(Hooks.evadeLandings(f,u))do if not f:Safe(p,true)then return false,'landing_unsafe'end end
  return true
 end
 -- At most 8 of the first 16 units in Q range: those Q kills first (refunded,
 -- so free), then the rest in lane, jungle, champion order.
 function Hooks.evadeTargets(f)
  local free,rest,count={},{},0
  for _,kind in ipairs({'lane','jungle','hero'})do for _,u in ipairs(f:Rows(kind,f:Range(0)))do
   count=count+1;if count>16 then break end
   if Hooks.evadeAllowed(f,u)then
    local kills=Hooks.qKills(f,u);local list=kills and free or rest
    list[#list+1]={unit=u,id=owner(u),position=f.point(u.pos),landings=Hooks.evadeLandings(f,u),free=kills,kind=kind}
   end
  end;if count>16 then break end end
  for _,row in ipairs(rest)do if #free>=8 then break end;free[#free+1]=row end
  for i=#free,9,-1 do free[i]=nil end
  return free
 end
 function Hooks.initialize(f)
  -- Q-killable minion rings, drawn from the prepared preview only.
  local base=f.Draw
  f.Draw=function(self)
   base(self);local p=self.preview
   if H.dead or not self.menu.Draw.Preview:Value()or not p or not(p.expires>G.Timer())then return end
   for _,row in ipairs(p.killable or {})do local v=row.unit
    if v and not v.dead and v.handle==row.handle and f.point(v.pos)then g.Draw.Circle(v.pos,60,1,g.Draw.Color(200,120,255,120))end
   end
  end
  local q=f.profile.q
  C:RegisterMobility({kind='unitDash',slot=0,key=g.HK_Q,name=f.profile.names[1][1],range=q.range,speeds={q.speed},castDelays={q.delay},
   profile=f.profile.id,refunds=true,label='Dodge with Q onto a unit',source='26.20 active Jade_Irelia slot extraction (Q range/speed/delay); landing offset unverified',
   targets=function()return Hooks.evadeTargets(f)end,allowed=function(u)return Hooks.evadeAllowed(f,u)end})
 end
 Hooks.options={'Risk'}
 Hooks.modeSlots={Combo={'Q','W','E','R'},Harass={'Q','W','E','R'},LaneClear={'Q'},JungleClear={'Q','W','E'},LastHit={'Q'},Flee={'Q','E'}}
 Hooks.previewLabel='Mark minions Q kills'
 Hooks.defaults={Combo={R=true},Harass={Q=false},LaneClear={Q=true},JungleClear={Q=true},LastHit={Q=true},Flee={E=true}}
 Hooks.assistLabels={[0]='Cast Q at the selected target',[3]='Cast R at the selected target'}
 function Hooks.assist(f,slot,u,context)return slot==0 and Hooks.castQ(f,u,context,nil,false)or slot==3 and Hooks.castR(f,u,context,nil)or false end
 function Hooks.preview(f,p)
  -- The minions Q kills now, by the same rule the farming Q uses (at most 12).
  local killable={}
  if H:GetSpellData(0).level>=1 then
   for _,v in ipairs(f:Rows('lane',f:Range(0)+300))do if #killable>=12 then break end
    if Hooks.qKills(f,v)then killable[#killable+1]={unit=v,handle=v.handle}end
   end
  end
  p.killable=killable
 end

 Hooks.secureSlots={0,2,3}
 function Hooks.secureDamage(f,slot,u)return slot==0 and Hooks.qDamage(f,u)or f:Damage(slot,u)end
 function Hooks.secureCast(f,slot,u,context,lethal)return slot==0 and Hooks.castQ(f,u,context,lethal,true)or slot==2 and Hooks.castE(f,u,context,lethal)or slot==3 and Hooks.castR(f,u,context,lethal)end
 -- Classic finisher beyond Q range (fix round): a chain of refunded hops that ends within Q range of an
 -- allowed champion whose current health Q takes; only a full chain is used (chainOnly). The hop validator and
 -- the final kill are re-checked through `allowed`.
 function Hooks.secureRoute(f)
  local function allowed()return f.menu.Misc.KillSecure:Value()and(finite(H.maxMana)and(H.maxMana<=0 or H.mana/H.maxMana*100>=f.menu.Misc.KSMana:Value()))end
  if not allowed()or f.sequences.q or not f:Ready(0)then return false end
  local range=f:Range(0)
  -- Up to three refunded hops and the final Q: champions within four Q ranges.
  for i,u in ipairs(f:Rows('hero',range*4))do if i>5 then break end
   if f:Allowed(u)and f.distance(H.pos,u.pos)>range then
    local function kills()return f:Current(u)and f:Allowed(u)and C:SpellProtected(u)==false and(C:Lethal(u,.3,function()return Hooks.qDamage(f,u)end,{now=true}))==true end
    if kills()and Hooks.route(f,u,{priority='interactive',condition=allowed},function()return allowed()and kills()end,true,true)then return true end
   end
  end
  return false
 end
 function Hooks.secure(f)return f:KillSecure()or Hooks.secureRoute(f)end
 return Hooks
end)(_G,Core,CombatMechanics)
-- Separate installed Normal and Classic kits share the common Core and client.
local profiles=ChampionProfiles('Irelia')
local finite,id,point=Core.finite,Core.id,Core.point
local function own(b)
 local found=false;for _,k in ipairs({'source','sourcenID','owner','ownerID'})do local n=b and b[k]
  if n~=nil and n~=0 then if type(n)=='table'or type(n)=='userdata'then n=id(n)end
   if n~=myHero.networkID and n~=myHero.handle then return false end;found=true end
 end;return found
end
local function ending(b)local t=Core.buffExpiry(b);return finite(t)and t or nil end
local function onLine(a,b,p,r)
 local dx,dz=b.x-a.x,b.z-a.z;local d=dx*dx+dz*dz;if d<1 then return false end
 local t=((p.x-a.x)*dx+(p.z-a.z)*dz)/d;if t<0 or t>1 then return false end
 local x,z=a.x+t*dx,a.z+t*dz;return(p.x-x)^2+(p.z-z)^2<=r*r,t
end
local IreliaChampion=class("IreliaChampion")
function IreliaChampion:__init()
 if myHero.charName=='Jade_Irelia'then self.engine=Core:CreateGameplay(self,GameplayHooks);Menu=self.engine.menu;return end
 self.profile=assert(profiles[myHero.charName]);self.issued={};self.targets={};self.gestures={};self:LoadMenu();self:DiscoverTargets();self:RegisterWDefense();self:PublishMobility()
 self.ESpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=self.profile.eDelay+self.profile.eRev,Radius=self.profile.eRadius,Range=self.profile.eRange,Speed=math.huge,Collision=false}
  -- Release timing is a conservative planning estimate, not a measured effect witness.
  self.WSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=self.profile.wRadius,Range=self.profile.wRange,Speed=math.huge,Collision=false}
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=self.profile.rDelay,Radius=self.profile.rRadius,Range=self.profile.rRange,Speed=self.profile.rSpeed,
  Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}}
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 Core:RegisterCleanup('Irelia',function()
  -- Wrapped champion methods reject disabled controllers. Cleanup uses the
  -- owned public client directly after Shutdown has disabled callbacks.
  local c=self.charge
  if c then
   if c.release then Core.adapter:Cancel(c.release.id,'controller_cleanup')end
   Core.adapter:Cancel(c.begin.id,'controller_cleanup')
  end
  Core.adapter:SetBlocked('IreliaW','attack',false);Core.adapter:SetBlocked('IreliaW','move',false)
  if self.rFlash then self.rFlash:Cancel('controller_cleanup')end
  self.charge=nil;self.chargeCleanup=nil;self.issued={};self.blade=nil;self.route=nil;self.routeWork=nil;self.preview=nil;self.gestures={};self.rTrace=nil
 end)
 local ok,why=Core:RegisterPreparation('Irelia.route',{intervalMs=40,maxDelayMs=150,units=1,maxUnits=1},function()return self:PrepareRoute()end,
  function()return self:RoutePermission()~=nil and self:Ready(_Q)end,function()self.routeWork=nil;self.route=nil end);self.routeFallback=not ok and why=='unsupported'
 ok,why=Core:RegisterPreparation('Irelia.preview',{intervalMs=150,maxDelayMs=450,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end);self.previewFallback=not ok and why=='unsupported'
end
function IreliaChampion:RegisterWDefense()
 -- Evade judges the danger; W is always offered to it.
 local function ready()return Core:Available()and not self.charge and self:Ready(_W)and Core.adapter:Capabilities().ownedCharge end
 Core:RegisterDefense('IreliaW',{validated=true,source='26.20 IreliaW active damage reduction calculations and owned ActionClient charge',
  active=function()return true end,
  options=function(context)
   local caps=_G.SDK.Evade and _G.SDK.Evade:GetCapabilities();local reduction=self:WReduction()
   if not caps or not caps.typedDamageReduction or not caps.ownedDefenseSubmission or not ready()or not reduction or not finite(context.now)then return {}end
    local launch=OrbamaPrediction:GetLaunchDelay({Delay=0})
    if not finite(launch)or not finite(self.profile.wFull)or self.profile.wFull<=.1 then return {}end
    return {{validated=true,profile='normal',resource='slot:1',slot=_W,cost=30,launch=launch,
     effect={kind='reduction',starts=context.now+launch+.05,ends=context.now+launch+self.profile.wFull-.05,
      fractions={physical=reduction.physical,magical=reduction.magical},immobilizes=true,immobilizedUntil=context.now+launch+1.5}}}
  end,
  prepare=function(option,context)
   local reduction=self:WReduction();local effect=option.effect
   if not ready()or not reduction or option.profile~='normal'or option.resource~='slot:1'or not effect or effect.kind~='reduction'
    or not effect.fractions or effect.fractions.physical~=reduction.physical or effect.fractions.magical~=reduction.magical
     or not finite(context.now)or not finite(option.launch)or option.launch~=OrbamaPrediction:GetLaunchDelay({Delay=0})
     or effect.starts~=context.now+option.launch+.05 or effect.ends~=context.now+option.launch+self.profile.wFull-.05
     or effect.immobilizes~=true or effect.immobilizedUntil~=context.now+option.launch+1.5 then return nil,'w_defense_changed'end
    local expires=Core.adapter:Now()+20
    local preparedAt=Game.Timer()
    local function dispatchGuard()
     local elapsed=Game.Timer()-preparedAt;local launch=OrbamaPrediction:GetLaunchDelay({Delay=0})
     local current=self:WReduction()
     return Core:Available()and Core.adapter:Now()<=expires
      and finite(elapsed)and elapsed>=0 and finite(launch)and elapsed+launch<=effect.starts-context.now
      and current and current.physical==effect.fractions.physical and current.magical==effect.fractions.magical
    end
    local function valid()return ready()and dispatchGuard()end
   local intent={type='cast',key=HK_W,resource='slot:1',expires=expires,mechanical=valid}
   intent.championDefense={submit=function()
    if not valid()then return nil,'w_defense_changed'end
     if not self:StartW(nil,{priority='critical'},nil,dispatchGuard)then return nil,'owned_charge_declined'end
    local id=self.charge.begin.id;local handle={}
    function handle:Poll(request)if request==id then return Core.adapter:Poll(id)end end
    function handle:Finish()return false,'controller_owner_observes_and_acknowledges'end
    function handle:Cancel(request,why)if request==id then return Core.adapter:Cancel(id,why)end end
    return id,'requested',handle
   end};return intent
  end})
end
function IreliaChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_Irelia',name='AyyyyIO - Irelia'})
 for _,mode in ipairs({'Combo','Harass'})do Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,k in ipairs({'Q','E'})do Menu[mode]:MenuElement({id=k,name='Use '..k,value=true})end
  Menu[mode]:MenuElement({id='W',name='Use W (charges while standing still)',value=false})
  Menu[mode]:MenuElement({id='EngageQ',name='Dash to enemies outside attack range',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R (mark, kill or hit several champions)',value=true})
 Menu.Combo:MenuElement({id='RFlash',name='Flash after R to bend it into more champions',value=false})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do Menu.Clear:MenuElement({type=MENU,id=kind,name=kind=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[kind]:MenuElement({id='Q',name='Use Q on marked or killable targets',value=true})
  Menu.Clear[kind]:MenuElement({id='E',name='Use E',value=true})
  Menu.Clear[kind]:MenuElement({id='W',name='Use W (charges while standing still)',value=false})
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='ECount',name='Lane minions E must hit',value=3,min=1,max=8,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack would miss',value=true});Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({type=MENU,id='Targets',name='Enemy champions abilities may target'})
 Menu.Misc:MenuElement({id='EAssist',name='Cast E (both blades) at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('U')})
 Menu.Misc:MenuElement({id='FleeE',name='Flee: E the nearest enemy',value=true})
 Menu.Misc:MenuElement({id='HP',name='Never dash in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='Enemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='InterruptE',name='Interrupt channels with E without a mode key',value=true})
 Menu.Misc:MenuElement({id='Gapclose',name='Answer enemy dashes onto you with E',value=true})
 Menu.Misc:MenuElement({id='KillSecure',name='Finish killable enemies without holding a mode key',value=true})
 Menu.Misc:MenuElement({id='KSMana',name='Finishers only above mana %',value=0,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='AutoW',name='Block attacks with W without a mode key',value=true})
 Menu.Misc:MenuElement({id='AutoWHP',name='Only block with W below health %',value=50,min=5,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Preview',name='E blade, planned E and Q route, minions Q kills',value=true})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
end
function IreliaChampion:Rows(kind,range)
 local raw=Core:DecisionUnits(kind=='hero'and'GetEnemyHeroes'or kind=='jungle'and'GetMonsters'or'GetEnemyMinions')
 -- Map-wide unordered list: filter by range before the row cap so nearby units are not skipped.
 local out,seen={},{};local cap=kind=='hero'and 5 or 32
 for i=1,math.min(#raw,512)do if #out>=cap then break end;local u=raw[i];local n=id(u)
  if n and not seen[n]and u and point(u.pos)and GetDistance(u.pos,myHero.pos)<=range and self:Current(u)then seen[n]=true;out[#out+1]=u end end;return out
end
function IreliaChampion:Current(u)
 if not u or not IsValid(u)or not point(u.pos)then return false end
 local found=Core:DecisionUnits(u.type==Obj_AI_Hero and'GetEnemyHeroes'or u.team==300 and'GetMonsters'or'GetEnemyMinions')
 for i=1,math.min(#found,512)do local v=found[i];if id(v)==id(u)then return v.handle==u.handle and v==u end end;return false
end
function IreliaChampion:IdentityPresent(u)
 local rows=Core:DecisionUnits(u.type==Obj_AI_Hero and'GetEnemyHeroes'or u.team==300 and'GetMonsters'or'GetEnemyMinions')
 for i=1,math.min(#rows,80)do local v=rows[i];if id(v)==id(u)then return v==u and v.handle==u.handle end end;return false
end
function IreliaChampion:DiscoverTargets()
 for _,u in ipairs(self:Rows('hero',2000))do if not self.targets[id(u)]then local key=StableUnitMenuKey(self,'Enemy',u);Menu.Misc.Targets:MenuElement({id=key,name='Allow: '..(u.charName or key),value=true});self.targets[id(u)]=Menu.Misc.Targets[key]end end
end
function IreliaChampion:Allowed(u)return self:Current(u)and(u.type~=Obj_AI_Hero or not self.targets[id(u)]or self.targets[id(u)]:Value())end
function IreliaChampion:Target(range)
 local t=_G.SDK.TargetSelector.Selected;if self:Allowed(t)and GetDistance(t.pos,myHero.pos)<=range then return t end
 local rows=self:Rows('hero',range);for i=#rows,1,-1 do if not self:Allowed(rows[i])then table.remove(rows,i)end end
 return _G.SDK.TargetSelector:GetTarget(rows,_G.SDK.DAMAGE_TYPE_PHYSICAL)
end
function IreliaChampion:Buff(u,name,delay)
 if not u or not u.GetBuff then return nil end
 for i=0,math.min(u.buffCount or 0,64)do local b=u:GetBuff(i);local stop=ending(b)
  if b and type(b.name)=='string'and b.name:lower()==name:lower()and finite(b.count)and b.count>0 and own(b)and stop and stop>Game.Timer()+(delay or 0)then return b end end
end
function IreliaChampion:Stacks()
 local b=self:Buff(myHero,self.profile.passive);local max=self:Buff(myHero,self.profile.passiveMax)
 if max then return self.profile.stacks end
 if b and finite(b.count)and b.count%1==0 and b.count>=1 and b.count<self.profile.stacks then return b.count end
 if b then return nil end;return 0
end
function IreliaChampion:Ready(slot,stage,validation)
 if self.engine then return self.engine:Ready(slot) end
 local d=myHero:GetSpellData(slot);local name=stage or({[0]=self.profile.q,[1]=self.profile.w,[2]=self.profile.e,[3]=self.profile.r})[slot]
 local free=slot==_E and name==self.profile.e2 and self:Blade()~=nil
 if not d or d.name~=name or not finite(d.level)or d.level%1~=0 or d.level<1 or d.level>(slot==_R and 3 or 5)or not finite(d.currentCd)or d.currentCd>0
  or Game.CanUseSpell(slot)~=0 or not finite(myHero.mana)or not free and(not finite(d.mana)or d.mana<0 or myHero.mana<d.mana)then return false end
 local row=self.issued[slot];return not row or validation and not row.uncertain
end
function IreliaChampion:Mana(node)return Core.manaAbove(node:Value())end
function IreliaChampion:Project(u,delay)
 if not self:Current(u)then return nil end;local p=u.pathing;local dest=p and p.endPos
 if p and p.hasMovePath and point(dest)and finite(u.ms)and u.ms>=0 then return u.pos:Extended(dest,math.min(GetDistance(u.pos,dest),u.ms*delay))end;return point(u.pos)
end
-- `farm`: a farming landing may stand under an enemy turret that is busy with
-- allied minions (TurretFarmable), above the health limit. Never for combat.
function IreliaChampion:Safe(p,offense,farm)
 if not point(p)or not Game.isWall or Game.isWall(p)~=false then return false end
 local healthy=finite(myHero.health)and finite(myHero.maxHealth)and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.HP:Value()
 if offense and not healthy then return false end
 local turret=false
 for _,t in ipairs(_G.SDK.ObjectManager:GetEnemyTurrets(2000))do if IsValid(t)and GetDistance(t.pos,p)<775+(t.boundingRadius or 0)+(myHero.boundingRadius or 0)then turret=true;break end end
 if turret and not(farm and not offense and healthy and TurretFarmable(_G,point(p)))then return false end
 local count=0;for _,u in ipairs(self:Rows('hero',1800))do if GetDistance(u.pos,p)<600 then count=count+1 end end;return count<=Menu.Misc.Enemies:Value()
end
function IreliaChampion:QImpact(u,origin)
 if not finite(myHero.ms)or myHero.ms<0 then return nil end;return GetDistance(u.pos,origin or myHero.pos)/(self.profile.qSpeed+myHero.ms)
end
function IreliaChampion:DamageQ(u,options)
 if self.engine then return self.engine.ext.qDamage(self.engine,u)end
 local d=myHero:GetSpellData(_Q);local level=myHero.levelData and myHero.levelData.lvl
 if not d or not self.profile.qBase[d.level]or not finite(myHero.totalDamage)or not finite(level)or level%1~=0 or level<1 or level>18 then return 0 end
 local raw=self.profile.qBase[d.level]+self.profile.qAD*myHero.totalDamage
 if u.type~=Obj_AI_Hero and u.team~=300 then raw=raw+self.profile.qMinionBase+self.profile.qMinionLevel*level end
 -- Current observed champion on-hit comes from the shared provider. Item graphs
 -- without an ability-applicability contract are excluded from reset credit.
 local value=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
 if _G.SDK.Damage.GetIreliaQOnHitDamage then value=value+_G.SDK.Damage:GetIreliaQOnHitDamage(myHero,u,options)end
 return value
end
-- Q kills `u` from its CURRENT health when it lands after `delay` (the shared
-- kill rule, C:Lethal now=true). The refund comes only with the kill, so it must
-- not depend on someone else's hit landing first; the forecast only confirms the
-- unit is still alive on arrival (Classic live 2026-10-08: one clear Q in three
-- left the minion alive when the forecast was counted).
function IreliaChampion:QLethal(u,delay,spentSpellblade)
 return Core:Lethal(u,delay,function()return self:DamageQ(u,{at=Game.Timer()+delay,targetHealth=u.health,spentSpellblade=spentSpellblade})end,
  {now=true,kind=u.type==Obj_AI_Hero and 'physical'or nil})==true
end
function IreliaChampion:QEligible(u,reset,rescue,origin,offset,spentSpellblade,farm)
 if not self:Allowed(u)or GetDistance(u.pos,origin or myHero.pos)>self.profile.qRange then return false end
 local delay=self:QImpact(u,origin);if not delay then return false end;delay=delay+(offset or 0)
 local hero=u.type==Obj_AI_Hero
 local pos=self:Project(u,delay);if not pos or not self:Safe(pos,hero,farm and not hero)then return false end
 local marked=self:Buff(u,self.profile.mark,delay+.03)~=nil;local hp=Core:UnshieldedLegacyForecast(u,delay)
 if hp and hp<=0 or not hp and not marked then return false end
 local lethal=hp~=nil and self:QLethal(u,delay,spentSpellblade)
 if reset and not marked and not lethal or rescue and not lethal then return false end
 if rescue and _G.SDK.Data:IsInAutoAttackRange(myHero,u)and _G.SDK.Orbwalker:CanAttack()then return false end
 return true,marked,lethal,pos,delay
end
function IreliaChampion:Submit(slot,key,aim,options)
 if self.issued[slot]or not Core:Cast(key,aim,options)then return false end
 self.issued[slot]={q=Core.lastIntent,name=myHero:GetSpellData(slot).name,context=options.context,blocked=true};return true
end
function IreliaChampion:CastQ(u,context,reset,rescue,permission,farm)
 if not self:Ready(_Q)or self.charge or not self:QEligible(u,reset,rescue,nil,nil,nil,farm)then return false end
 local handle=u.handle;local ok=self:Submit(_Q,HK_Q,u,{owner='Bladesurge',context=context,independent=false,range=self.profile.qRange,deferAttackWindup=true,
  validate=function(q)
   local yes=self:Current(u)and u.handle==handle and self:QEligible(u,reset,rescue,nil,nil,nil,farm)and(not permission or permission())
   if yes then q.markExpiry=ending(self:Buff(u,self.profile.mark,(self:QImpact(u)or 0)+.03))end;return yes
  end,
   observe=function(q)local a=Core:NativeCast(q,self.profile.q);local yes=a and(a.target==id(u)or a.target==handle)
    if yes then q.nativeStart=a.startTime end;return yes end})
 if ok then local row=self.issued[_Q];row.unit=u;row.handle=handle;row.resetExpected=reset;row.expires=Game.Timer()+1.5 end;return ok
end
-- Evade may dodge by dashing onto a unit (SDK.ChampionMobility 'unitDash').
-- Where Q ends relative to its target is not established in the profile (the
-- controller only accepts an observed dash end within 150 of the unit), so the
-- unit's projected position and the near-side contact point (bounding radii
-- short of it) are both declared and Evade requires every one to be safe.
-- Travel uses the controller's own estimate (qSpeed plus movement speed) and
-- the bare qSpeed as a second timing; no cast time is modeled, as in QImpact.
-- Wiki V26.17 says the dash ends 100 units through the target; that point is
-- declared as a third landing (unverified, so it only adds a safety check).
function IreliaChampion:EvadeQLandings(u,pos)
 local to=point(pos or u.pos);if not to then return {}end
 local d=GetDistance(myHero.pos,to);local gap=(u.boundingRadius or 0)+(myHero.boundingRadius or 0)
 if d<=gap+1 then return {to}end
 local x,z=(to.x-myHero.pos.x)/d,(to.z-myHero.pos.z)/d;local through=self.profile.qThrough or 100
 return {to,point({x=to.x-x*gap,y=to.y,z=to.z-z*gap}),point({x=to.x+x*through,y=to.y,z=to.z+z*through})}
end
-- u=nil: unit-independent readiness. Returns allowed, reason-or-free, landing.
function IreliaChampion:EvadeQAllowed(u)
 local path=myHero.pathing
 if self.charge or self.issued[_Q]or path and path.isDashing then return false,'q_in_flight'end
 if not u then return true end
 local ok,marked,lethal,pos=self:QEligible(u,false,false)
 if not ok then return false,'target_ineligible'end
 for _,p in ipairs(self:EvadeQLandings(u,pos))do if not self:Safe(p,u.type==Obj_AI_Hero)then return false,'landing_unsafe'end end
 return true,marked or lethal,pos
end
-- At most 8 of the first 16 units in Q range: those whose Q is refunded (kill
-- or mark) first, then the rest in lane, jungle, champion order.
function IreliaChampion:EvadeTargets()
 local free,rest,count={},{},0;local ms=myHero.ms
 local speeds={self.profile.qSpeed,finite(ms)and ms>0 and self.profile.qSpeed+ms or nil}
 for _,kind in ipairs({'lane','jungle','hero'})do for _,u in ipairs(self:Rows(kind,self.profile.qRange))do
  count=count+1;if count>16 then break end
  local ok,refund,pos=self:EvadeQAllowed(u)
  if ok then
   local list=refund and free or rest
   list[#list+1]={unit=u,id=id(u),position=point(u.pos),landings=self:EvadeQLandings(u,pos),free=refund==true,speeds=speeds,kind=kind}
  end
 end;if count>16 then break end end
 for _,row in ipairs(rest)do if #free>=8 then break end;free[#free+1]=row end
 for i=#free,9,-1 do free[i]=nil end
 return free
end
function IreliaChampion:PublishMobility()
 if not Core.RegisterMobility then return end
 Core:RegisterMobility({kind='unitDash',slot=_Q,key=HK_Q,name=self.profile.q,range=self.profile.qRange,speeds={self.profile.qSpeed},castDelays={0},
  profile='normal',refunds=true,label='Dodge with Q onto a unit',source='Irelia profile qRange/qSpeed and controller QImpact; landing offset unverified',
  targets=function()return self:EvadeTargets()end,allowed=function(u)local ok,why=self:EvadeQAllowed(u);return ok,not ok and why or nil end})
end
function IreliaChampion:MaintainIssued()
 for slot,row in pairs(self.issued)do local q=row.q;local r=Core.adapter:Poll(q.id);local d=myHero:GetSpellData(slot)
  if not q.sentAt and(not r or r.state=='cancelled_before_send')then self.issued[slot]=nil
  else
   if r and(r.state=='send_uncertain'or r.interrupted or r.competitor)then row.uncertain=true end
    if slot==_Q and q.observedAt and not row.uncertain and self:IdentityPresent(row.unit)then
     local path=myHero.pathing
     local a=Core:NativeCast(q,self.profile.q)
     if a and a.startTime==q.nativeStart and path and path.isDashing and point(path.endPos)and row.unit.handle==row.handle and Game.Timer()<row.expires
     and GetDistance(path.endPos,row.unit.pos)<=150 then row.dashEnd=point(path.endPos);row.dashSeen=true end
    if row.dashSeen and path and not path.isDashing and GetDistance(myHero.pos,row.dashEnd)<=90 then
     row.landed=true
     local consumed=q.markExpiry and q.markExpiry>Game.Timer()and not self:Buff(row.unit,self.profile.mark)
     local killed=row.unit.handle==row.handle and(row.unit.dead or row.unit.health<=0)
     if row.resetExpected and(consumed or killed or row.cooldownSeen)and Game.CanUseSpell(_Q)==0 and d.currentCd==0 then
      self.lastReset={target=id(row.unit),at=Game.Timer(),endpoint=row.dashEnd};self.issued[slot]=nil
      if self.route then self.route.visited[id(row.unit)]=true;self.route.step=(self.route.step or 0)+1 end
     end
    end
   elseif q.observedAt and not row.uncertain and slot~=_W then self.issued[slot]=nil end
   if self.issued[slot]then
    if finite(d.currentCd)and d.currentCd>0 then row.cooldownSeen=true end
    if row.cooldownSeen and d.currentCd==0 and Game.CanUseSpell(slot)==0 then self.issued[slot]=nil end
    -- The lock only keeps a second Q from being queued on top of this one. A
    -- refunded Q never shows a cooldown, and the reset credit above needs the
    -- native cast and the path end point to still be readable during the dash;
    -- when they were not, nothing ended the lock while the target stayed in the
    -- roster. Q observed, no dash in progress 0.3 s later and Q ready again is
    -- the refund itself: the lock ends, without claiming a reset for the route.
    if self.issued[slot]and slot==_Q and q.observedAt and not row.uncertain and not row.cooldownSeen then
     row.observedAt=row.observedAt or Game.Timer();local path=myHero.pathing
     if not(path and path.isDashing)and Game.Timer()-row.observedAt>.3 and d.currentCd==0 and Game.CanUseSpell(slot)==0 then self.issued[slot]=nil end
    end
    if self.issued[slot]and row.context and not Core.adapter:ContextValid({context=row.context})and(not r or not r.keyOwned)then
     if q.sentAt then row.blocked=true else self.issued[slot]=nil end
    end
   end
   -- A certain, finished send with no observation and no consumed cooldown cast nothing;
   -- fresh readiness permits a new decision instead of locking the slot for the game.
   if self.issued[slot]and q.sentAt and not q.observedAt and not row.uncertain and not row.cooldownSeen and q.outcome and Core.pending[q.key]~=q
    and finite(d.currentCd)and d.currentCd==0 and Game.CanUseSpell(slot)==0 then self.issued[slot]=nil end
  end
 end
end
function IreliaChampion:RoutePermission()
 local mode=GetMode()
 if mode=='Flee'and point(mousePos)then return Core:ModeContext('Flee'),point(mousePos),'flee'end
 if mode=='Combo'and Menu.Combo.Q:Value()and self:Mana(Menu.Combo.Mana)then
  local u=self:Target(1400);if u then return Core:ModeContext('Combo',function()return Menu.Combo.Q:Value()and self:Mana(Menu.Combo.Mana)end),point(u.pos),'combat',u end
 end
 -- Without Combo/Flee: a hop route to an allowed champion beyond Q range that Q kills from current health
 -- (Misc.KillSecure and its mana floor). RouteFinish requires the kill at the chain's arrival.
 if mode~='Combo'and mode~='Flee'then local u=self:SecureRouteTarget()
  if u then return {priority='interactive',condition=function()return self:SecureAllowed()end},point(u.pos),'secure',u end
 end
end
function IreliaChampion:SecureAllowed()return Menu.Misc.KillSecure:Value()and self:Mana(Menu.Misc.KSMana)end
-- The nearest allowed champion 600-1500 away whose current health one Q takes (at most five checked).
function IreliaChampion:SecureRouteTarget()
 -- No readiness read here: the route's own pending Q must not withdraw its permission at dispatch.
 if not self:SecureAllowed()or self.charge then return nil end
 local best,bestD
 for i,u in ipairs(self:Rows('hero',1500))do if i>5 then break end
  local d=GetDistance(u.pos,myHero.pos)
  if d>self.profile.qRange and self:Allowed(u)and(not bestD or d<bestD)and self:QLethal(u,.3)then best,bestD=u,d end
 end
 return best
end
function IreliaChampion:SecureRoute()
 local _,_,kind=self:RoutePermission();return kind=='secure'and self:ContinueRoute()
end
-- A Q route is a chain of up to three hops through units Q refunds (owned
-- mark, or a kill from current health at that hop's own arrival: the sum of the
-- earlier dashes). RouteChain answers whether the hops are still valid now, and
-- where and when the last one lands; mana covers every hop plus the final Q.
function IreliaChampion:RouteChain(path,final)
 local cost=myHero:GetSpellData(_Q).mana;if not finite(cost)or cost<0 or myHero.mana<cost*(#path+(final and 1 or 0))then return false end
 local origin,t=point(myHero.pos),0
 for i,u in ipairs(path)do
  if not origin or GetDistance(u.pos,origin)>self.profile.qRange or not self:QEligible(u,true,false,origin,t,i>1)then return false end
  t=t+self:QImpact(u,origin);origin=point(u.pos)
 end
 return true,origin,t
end
-- E is ready for an engage after the hop: first stage, the switches, and mana for Q and E.
function IreliaChampion:EngageReady()
 local e=myHero:GetSpellData(_E);local q=myHero:GetSpellData(_Q)
 return Menu.Combo.EngageQ:Value()and Menu.Combo.E:Value()and e.name==self.profile.e and self:Ready(_E)and not self:Blade()
  and finite(e.mana)and finite(q.mana)and myHero.mana>=q.mana+e.mana
end
-- How a combat route ends from `origin` after `t` seconds: 'q' the target is
-- Q-eligible from there; 'e' (an engage hop) the target was out of E reach and
-- the landing brings it within E range less the blade margin (775-100), with E
-- ready for the first blade during the dash.
function IreliaChampion:RouteFinish(origin,t,target,kind,engage)
 if kind=='flee'then return 'goal'end
 if not target or not origin then return nil end
 if kind=='secure'then
  -- The last landing is the target itself: QEligible's rescue path needs the kill at that arrival and a Safe landing.
  if GetDistance(target.pos,origin)>self.profile.qRange then return nil end
  local ok,_,lethal=self:QEligible(target,false,true,origin,t,true);return ok and lethal and 'q'or nil
 end
 if GetDistance(target.pos,origin)<=self.profile.qRange and self:QEligible(target,true,false,origin,t,true)then return 'q'end
 if engage and GetDistance(target.pos,myHero.pos)>self.profile.eRange-100 and GetDistance(target.pos,origin)<=self.profile.eRange-100 and self:EngageReady()then return 'e'end
end
local function routeTop(nodes,n)
 table.sort(nodes,function(a,b)return a.progress>b.progress end);local out={}
 for i=1,math.min(#nodes,n)do out[i]=nodes[i]end;return out
end
-- Bounded beam search in the 'Irelia.route' preparation job: at most 12 units,
-- depth 3, the best 3 chains of each depth expanded, 4 hop checks per chunk
-- (cheap distance and progress rejections are free). Progress is kept across
-- refusals; the search restarts when Irelia, the goal or the target moved. A
-- deeper level is searched only while no shorter route exists. Only the first
-- hop is ever submitted; the next one is planned again after its refund.
function IreliaChampion:PrepareRoute()
 local context,goal,kind,target=self:RoutePermission();if not context or not self:Ready(_Q)or self.charge then self.routeWork=nil;return true end
 local w=self.routeWork;local now=Game.Timer()
 if not w or w.kind~=kind or w.target~=id(target)or GetDistance(w.origin,myHero.pos)>60 or GetDistance(w.goal,goal)>100 or now>w.expires then
  local rows,seen={},{};for _,k in ipairs({'lane','jungle','hero'})do for _,u in ipairs(self:Rows(k,1200))do
   if #rows<12 and not seen[id(u)]then rows[#rows+1]=u;seen[id(u)]=true end end end
  w={rows=rows,index=1,goal=goal,kind=kind,target=id(target),origin=point(myHero.pos),expires=now+.25,context=context,depth=1,nodes={},
   engage=kind=='combat'and self:EngageReady()};self.routeWork=w
 end
 local initial=GetDistance(w.origin,w.goal);local budget=4
 local function finish()
  self.routeWork=nil;self.routeSearched={kind=kind,at=now,found=w.best~=nil}
  if w.best then
   self.route={first=w.best[1],path=w.best,kind=kind,goal=goal,target=target,context=context,expires=now+.15,visited={},step=0,engage=w.bestHow=='e'}
   Core:Trace('irelia_route',{profile='normal',kind=kind,hops=#w.best,how=w.bestHow,target=target and target.charName or 'cursor'},.5)
  end;return true
 end
 local function consider(path,progress)
  local ok,origin,t=self:RouteChain(path,kind~='flee');if not ok then return end
  local how=self:RouteFinish(origin,t,target,kind,w.engage)
  if how and(not w.bestScore or progress>w.bestScore)then w.best=path;w.bestScore=progress;w.bestHow=how end
  if not how and kind~='flee'then w.nodes[#w.nodes+1]={path=path,origin=origin,progress=progress}end
 end
 while budget>0 do
  if w.depth==1 then
   local u=w.rows[w.index]
   if not u then
    if w.best or kind=='flee'or #w.nodes==0 then return finish()end
    w.depth=2;w.frontier=routeTop(w.nodes,3);w.nodes={};w.pair=1;w.expires=w.expires+.25
   else
    w.index=w.index+1;budget=budget-1
    local progress=initial-GetDistance(u.pos,w.goal)
    if progress>100 then consider({u},progress)end
   end
  else
   local count=#w.rows;local parent=w.frontier[math.floor((w.pair-1)/count)+1]
   if not parent then
    if w.best or w.depth>=3 or #w.nodes==0 then return finish()end
    w.depth=w.depth+1;w.frontier=routeTop(w.nodes,3);w.nodes={};w.pair=1;w.expires=w.expires+.25
   else
    local u=w.rows[(w.pair-1)%count+1];w.pair=w.pair+1
    local fresh=true;for _,v in ipairs(parent.path)do if v==u then fresh=false end end
    local progress=initial-GetDistance(u.pos,w.goal)
    if fresh and GetDistance(u.pos,parent.origin)<=self.profile.qRange and progress>parent.progress+100 then
     budget=budget-1;local path={};for i,v in ipairs(parent.path)do path[i]=v end;path[#path+1]=u;consider(path,progress)
    end
   end
  end
 end;return false
end
function IreliaChampion:ContinueRoute()
 local context,goal,kind,target=self:RoutePermission();local r=self.route
 if not context or not r or kind~=r.kind or r.target and target~=r.target or Game.Timer()>r.expires then return false end
 if r.visited[id(r.first)]or not self:Ready(_Q)then return false end
 return self:CastQ(r.first,r.context,true,false,function()
  local c,g,k,t=self:RoutePermission()
  if c==nil or k~=r.kind or r.target and t~=r.target or GetDistance(r.first.pos,g)+100>=GetDistance(myHero.pos,g)then return false end
  if k=='flee'then return true end
  local ok,origin,at=self:RouteChain(r.path or {r.first},true)
  return ok and t~=nil and self:RouteFinish(origin,at,t,k,r.engage)~=nil
 end)
end
function IreliaChampion:Aim(u,spell)
 if not self:Allowed(u)or GetDistance(u.pos,myHero.pos)>spell.Range then return nil end
 local p=Core:Prediction(spell);p:GetPrediction(u,myHero)
 if not p:CanHit(u.type==Obj_AI_Hero and 3 or 2)then return nil end
 local pos=point(p.CastPosition);return pos and GetDistance(pos,myHero.pos)<=spell.Range and pos or nil
end
function IreliaChampion:Blade()
 local b=self.blade;local buff=self:Buff(myHero,self.profile.e)
 if not b or not b.native or Game.Timer()<b.nativeStart+self.profile.eRecast or not point(b.position)or not buff or not finite(buff.startTime)or buff.startTime<b.nativeStart or ending(buff)<=Game.Timer()+self.profile.eDelay+self.profile.eRev
  or myHero:GetSpellData(_E).name~=self.profile.e2 then return nil end
 if b.object and(not b.object.valid or b.object.handle~=b.objectHandle or not own(b.object))then return nil end
 return b
end
function IreliaChampion:ECount(a,b,kind)
 local count=0;for _,u in ipairs(self:Rows(kind or'hero',1600))do local p=self:Project(u,self.ESpell.Delay)
  if p and onLine(a,b,p,self.profile.eRadius+(u.boundingRadius or 0))then count=count+1 end end;return count
end
-- Other allowed enemy champions within E range, with their positions when the
-- blades meet (at most 4).
function IreliaChampion:EOthers(u)
 local out={};for _,v in ipairs(self:Rows('hero',self.profile.eRange+150))do
  if #out>=4 then break end
  if v~=u and self:Allowed(v)then local p=self:Project(v,self.ESpell.Delay);if p then out[#out+1]={unit=v,pos=p}end end
 end;return out
end
-- The second blade, recomputed from the native first blade: the line from it
-- through the target, extended past the target, or past a second champion when
-- that line still crosses the target and hits more champions.
function IreliaChampion:EEnd(u)
 local b=self:Blade();if not b then return nil end
 local p=self:Aim(u,self.ESpell);if not p or GetDistance(p,b.position)<10 then return nil end
 local radius=self.profile.eRadius+(u.boundingRadius or 0)
 local function past(to,extra)
  local dist=GetDistance(to,b.position);if dist<10 then return nil end
  local stop=b.position:Extended(to,dist+extra)
  if GetDistance(stop,myHero.pos)>self.profile.eRange then stop=b.position:Extended(to,dist+50)end
  if GetDistance(stop,myHero.pos)>self.profile.eRange or not onLine(b.position,stop,p,radius)then return nil end
  return stop
 end
 local best=past(p,150);if not best then return nil end
 local others=self:EOthers(u)
 if #others>0 then
  local count=self:ECount(b.position,best)
  for _,o in ipairs(others)do local stop=past(o.pos,150)
   if stop then local n=self:ECount(b.position,stop);if n>count then best,count=stop,n end end
  end
 end
 return best
end
-- The first blade for a line through the target and a second champion: placed
-- beyond that champion, away from the target, so the second blade drawn through
-- the target (EEnd) crosses both. nil when no pair beats the plain placement.
function IreliaChampion:EPair(u,p,from,plain)
 local others=self:EOthers(u);if #others==0 then return nil end
 local best,bestStop,count=nil,nil,self:ECount(plain,p:Extended(plain,-150))
 for _,o in ipairs(others)do
  local d=GetDistance(o.pos,p)
  if d>=60 then
   local first=p:Extended(o.pos,d+150);local stop=o.pos:Extended(p,d+150)
   if GetDistance(first,from)<=self.profile.eRange and GetDistance(first,myHero.pos)<=self.profile.eRange and GetDistance(stop,myHero.pos)<=self.profile.eRange then
    local n=self:ECount(first,stop);if n>count and n>=2 then best,bestStop,count=first,stop,n end
   end
  end
 end
 return best,bestStop
end
-- `from` (optional function): where the first blade is aimed from, e.g. the end
-- of Irelia's own Q dash while she is still dashing.
function IreliaChampion:CastE(u,context,kind,minCount,permission,proof,from)
 if self.charge or self.issued[_E]or not self:Allowed(u)then return false end
 local stage=myHero:GetSpellData(_E).name;local second=stage==self.profile.e2
 if second and not self:Blade()then return false end
 if not self:Ready(_E,second and self.profile.e2 or self.profile.e)then return false end
 local handle=u.handle;local function solve()
  if not self:Allowed(u)or u.handle~=handle or permission and not permission()or proof and not proof()then return nil end
  local pos,lineEnd;if second then pos=self:EEnd(u)else pos=self:Aim(u,self.ESpell)end
  if not pos then return nil end
  if not second then
   local origin=from and from()or point(myHero.pos);if not origin then return nil end
   local target=pos
   if from then pos=origin:Extended(target,GetDistance(target,origin)+150)
    if GetDistance(pos,myHero.pos)>self.profile.eRange then pos=origin:Extended(target,GetDistance(target,origin)+50)end
   else pos=myHero.pos:Extended(target,math.min(self.profile.eRange,GetDistance(target,myHero.pos)+150))end
   if not kind then local pair,stop=self:EPair(u,target,origin,pos);if pair then pos,lineEnd=pair,stop end end
   if point(pos)and not lineEnd then lineEnd=pos:Extended(target,GetDistance(pos,target)+150)end
  end
  if not point(pos)or GetDistance(pos,myHero.pos)>self.profile.eRange then return nil end
  local first=second and self:Blade().position or point(myHero.pos)
  if minCount and self:ECount(first,pos,kind)<minCount then return nil end
  -- The line this decision plans, kept for the drawing preview (champion targets only).
  if u.type==Obj_AI_Hero then self.ePlanned={a=second and first or pos,b=second and pos or lineEnd,unit=u,handle=handle,stage=stage,mode=GetMode(),at=Game.Timer()}end
  return pos
 end
 local pos=solve();if not pos then return false end
 local ok=self:Submit(_E,HK_E,pos,{owner=second and 'Duet2'or'Duet1',context=context,intentTarget=u,independent=false,prevalidateWorldCast=true,
  resolve=function()local p=solve();return p and{position=p}end,
  commitGuard=function()return Core:Current()and(not permission or permission())end,
  validate=function(_,r)local p=solve();return myHero:GetSpellData(_E).name==stage and p and r and point(r.position)and GetDistance(r.position,p)<=5 end,
  observe=function(q)
   local a=not q.ambiguous and Core:NativeCast(q,stage);if not a then return false end
    if not second then local p=point(a.endPos or a.placementPos);if not p or GetDistance(p,myHero.pos)>self.profile.eRange or GetDistance(p,q.target)>100 then return false end
     q.nativeBlade={native=true,nativeStart=a.startTime,position=p,context=context,target=u,handle=handle,expires=a.startTime+self.profile.eDuration,object=nil}
    end;return true
   end})
  if ok then Core:AfterCast(HK_E,function(q)if second then self.blade=nil else self.blade=q.nativeBlade end end)end
  return ok
end
function IreliaChampion:Phase(slot,name,context)
 return {spellName=name,resource='slot:'..slot,context=context,requestGameTime=Game.Timer(),previousCastStart=myHero.activeSpell and myHero.activeSpell.startTime}
end
function IreliaChampion:PhaseValidation(q,check)
 return function(...)if not Core:InputAvailable()or not check(...)then return false end
  q.dispatchGameTime=Game.Timer();q.dispatchCastStart=myHero.activeSpell and myHero.activeSpell.startTime;return true end
end
function IreliaChampion:ChargeReconciled()
 local a=myHero.activeSpell
 return Core:Current()and not self:Buff(myHero,self.profile.defense)and not(a and a.valid and(a.name==self.profile.w or a.name==self.profile.w2))
  and Control.IsKeyDown and not Control.IsKeyDown(HK_W)
end
function IreliaChampion:CollectCharges()
 local rows=self.chargeCleanup;if not rows then return end
 for i=#rows,1,-1 do local q=rows[i];local r=Core.adapter:Poll(q.id)
  if not r or Core.adapter:Finish(q.id)or Core.adapter:Reconcile(q.id)then table.remove(rows,i)end
 end
end
function IreliaChampion:ObservePhase(q)
 local r=Core.adapter:Poll(q.id);if not r then return nil end
 q.sentAt=r.sentAt;q.sentGameTime=r.sentGameTime;q.observationGameTime=Core.adapter:Capabilities().nativeSendGameTime and r.sentGameTime or q.dispatchGameTime
 if r.state=='send_uncertain'or r.interrupted or r.competitor then q.ambiguous=true end
 local native=not q.ambiguous and Core:NativeCast(q,q.spellName)
 if native and not q.observedAt then
  local yes=Core.adapter:Observe(q.id,{kind='mechanical',at=Core.adapter:Now(),source='spell_state_transition',unique=true})
  if yes then q.observedAt=Core.adapter:Now();q.nativeStart=native.startTime end
 end;return r,native
end
function IreliaChampion:StartW(u,context,permission,dispatchGuard)
 if self.charge or self.issued[_W]or self.chargeCleanup and #self.chargeCleanup>0 or not self:Ready(_W)or self:Buff(myHero,self.profile.defense)or not Core.adapter:Capabilities().ownedCharge then return false end
 if u and(not self:Allowed(u)or GetDistance(u.pos,myHero.pos)>self.profile.wRange)then return false end
 local q=self:Phase(_W,self.profile.w,context);local handle=u and u.handle
 local request,why=Core.adapter:BeginCharge(HK_W,{owner='DefiantDance',resource='slot:1',priority=context and context.priority or'normal',context=context,
   maxChargeMs=1500,expires=Core.adapter:Now()+1500,reconcile=function()return self:ChargeReconciled()end,
   ready=function()return dispatchGuard and not dispatchGuard()or Core:AttackWindupRemaining()<=0 end,
   mechanical=self:PhaseValidation(q,function()return self:Ready(_W)and(not dispatchGuard or dispatchGuard())
    and(not u or self:Allowed(u)and u.handle==handle and GetDistance(u.pos,myHero.pos)<=self.profile.wRange)and(not permission or permission())end)})
 if not request then self.chargeStatus=why;return false end
 q.id=request;self.charge={begin=q,target=u,handle=handle,permission=permission,context=context,deadline=Core.adapter:Now()+1500};return true
end
function IreliaChampion:CloseCharge(reason)
 local c=self.charge;if not c then return end
 local raw=Core.adapter:Poll(c.begin.id);c.begin.sentAt=c.begin.sentAt or raw and raw.sentAt
 if c.begin.sentAt and not self.issued[_W]then self.issued[_W]={q=c.begin,name=self.profile.w,context=c.context,blocked=true,uncertain=true}end
 self.chargeCleanup=self.chargeCleanup or{}
 if c.release then Core.adapter:Cancel(c.release.id,reason);self.chargeCleanup[#self.chargeCleanup+1]=c.release end
 Core.adapter:Cancel(c.begin.id,reason);self.chargeCleanup[#self.chargeCleanup+1]=c.begin
 Core.adapter:SetBlocked('IreliaW','attack',false);Core.adapter:SetBlocked('IreliaW','move',false);self:CollectCharges()
 self.charge=nil;self.chargeStatus='owned_cleanup_'..tostring(reason)
end
function IreliaChampion:ChargeBuff(c)
 local b=self:Buff(myHero,self.profile.defense);local q=c.begin
 return q.observedAt and b and finite(b.startTime)and b.startTime>=q.nativeStart and b.startTime<=Game.Timer()and b or nil
end
function IreliaChampion:WReduction()
 local lvl=myHero.levelData and myHero.levelData.lvl
 if not finite(lvl)or lvl%1~=0 or lvl<1 or lvl>18 or not finite(myHero.ap)then return nil end
 local p=self.profile;local percent=p.wPhysicalDR[1]+(p.wPhysicalDR[2]-p.wPhysicalDR[1])*(lvl-1)/17+p.wDRAP*myHero.ap
 return{physical=math.min(1,math.max(0,percent/100)),magical=math.min(1,math.max(0,percent*p.wMagicDR/100)),trueDamage=0,
  observedActive=self.charge~=nil and self:ChargeBuff(self.charge)~=nil,immobilizes=true}
end
function IreliaChampion:DamageW(u)
 if self.engine then return self.engine:Damage(1,u)end
 local d=myHero:GetSpellData(_W);local p=self.profile
 if not p.wBase[d.level]or not finite(myHero.totalDamage)or not finite(myHero.ap)then return 0 end
 local b=self.charge and self:ChargeBuff(self.charge);local scale=b and 1+p.wMaxBonus*math.min(p.wFull,math.max(0,Game.Timer()-b.startTime))/p.wFull or 1
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,(p.wBase[d.level]+p.wAD*myHero.totalDamage+p.wAP*myHero.ap)*scale)
end
function IreliaChampion:MaintainCharge()
 local c=self.charge;if not c then return false end
 if not Core:InputAvailable()or not Core.adapter:ContextValid({context=c.context},'continuation')or c.permission and not c.permission()then self:CloseCharge('context_ended');return false end
 local r=self:ObservePhase(c.begin)
 if not r or r.state=='cancelled_before_send'then self:CloseCharge('begin_declined');return false end
 if c.begin.ambiguous then self.issued[_W]={q=c.begin,name=self.profile.w,context=c.context,blocked=true,uncertain=true};self:CloseCharge('begin_uncertain');return false end
 if c.release then
  local result=self:ObservePhase(c.release)
  if not result or result.state=='cancelled_before_send'or result.state=='send_uncertain'or c.release.observedAt or Core.adapter:Now()>c.deadline then
   self.issued[_W]={q=c.release.sentAt and c.release or c.begin,name=self.profile.w,context=c.context,blocked=true,uncertain=not c.release.observedAt}
   self:CloseCharge(c.release.observedAt and 'release_observed'or'release_unconfirmed')
  end;return true
 end
 local b=self:ChargeBuff(c)
 if not b then if Core.adapter:Now()>c.deadline-150 then self:CloseCharge('native_charge_missing')end;return true end
 Core.adapter:SetBlocked('IreliaW','attack',true);Core.adapter:SetBlocked('IreliaW','move',true)
 local age=Game.Timer()-b.startTime
 if c.target and(not self:Current(c.target)or c.target.handle~=c.handle)then self:CloseCharge('target_lost_release_may_cast');return true end
 if age<self.profile.wFull then return true end
 local aim=c.target and self:Aim(c.target,self.WSpell)or point(mousePos)
 if not aim or GetDistance(aim,myHero.pos)>self.profile.wRange then self:CloseCharge('release_aim_unavailable');return true end
 local q=self:Phase(_W,self.profile.w2,c.context)
 local request,why=Core.adapter:ReleaseCharge(c.begin.id,aim,{expires=math.min(c.deadline,Core.adapter:Now()+180),reconcile=function()return self:ChargeReconciled()end,
  mechanical=self:PhaseValidation(q,function()
   local current=self:ChargeBuff(c);if not current or Game.Timer()-current.startTime>self.profile.wMax then return false end
   local fresh=c.target and self:Aim(c.target,self.WSpell)or point(mousePos)
   return fresh and GetDistance(fresh,aim)<=10 and GetDistance(fresh,myHero.pos)<=self.profile.wRange
  end)})
 if request then q.id=request;c.release=q else self.chargeStatus=why;self:CloseCharge('release_declined')end;return true
end
function IreliaChampion:RContact(pos,u)
 local origin=myHero.pos;local projected=self:Project(u,self.profile.rDelay+GetDistance(u.pos,origin)/self.profile.rSpeed)
 if not point(pos)or not projected then return false end
 local target=onLine(origin,pos,projected,self.profile.rRadius+(u.boundingRadius or 0))
 if not target then return false end
 local first,firstT;for _,v in ipairs(self:Rows('hero',1200))do local p=self:Project(v,self.profile.rDelay+GetDistance(v.pos,origin)/self.profile.rSpeed)
  if p then local yes,t=onLine(origin,pos,p,self.profile.rRadius+(v.boundingRadius or 0));if yes and(not firstT or t<firstT)then first=v;firstT=t end end end
 if first~=u then return false end
 local wall,_,count=OrbamaPrediction:GetCollision(origin,pos,self.profile.rSpeed,self.profile.rDelay,self.profile.rRadius,self.RSpell.CollisionTypes,id(u));return not wall and count==0
end
function IreliaChampion:CastR(u,context,permission,proof)
 if self.charge or not self:Ready(_R)or not permission()or proof and not proof()or not self:Allowed(u)then return false end
 local handle=u.handle;local function solve()
  if not self:Ready(_R,nil,true)or not permission()or proof and not proof()or not self:Allowed(u)or u.handle~=handle then return nil end
  local p=self:Aim(u,self.RSpell);return p and self:RContact(p,u)and p or nil
 end;local pos=solve();if not pos then return false end
 return self:Submit(_R,HK_R,pos,{owner='VanguardsEdge',context=context,intentTarget=u,independent=false,prevalidateWorldCast=true,
  resolve=function()local p=solve();return p and{position=p}end,commitGuard=function()return Core:Current()and permission()end,
  validate=function(_,r)return r and point(r.position)and permission()and(not proof or proof())and self:Allowed(u)and u.handle==handle and self:RContact(r.position,u)end,
  observe=function(q)local yes=Core:NativeCast(q,self.profile.r)~=nil;if yes then self:NoteR(u,'target')end;return yes end})
end
-- An observed own R: E2 waits briefly for its mark (HoldE2), and a development
-- trace counts the champions carrying our mark a second later. The explosion
-- radius on first contact is not published; those traces settle it.
function IreliaChampion:NoteR(u,why)
 if self.rObservedAt and Game.Timer()-self.rObservedAt<.3 then return end
 self.rObservedAt=Game.Timer();local plan=self.rPlan
 self.rTrace={at=Game.Timer()+1,target=u and u.charName,why=plan and plan.reason or why,planned=plan and plan.count,origin=point(myHero.pos)}
end
function IreliaChampion:TraceR()
 local t=self.rTrace;if not t or Game.Timer()<t.at then return end
 self.rTrace=nil;local marked=0
 for _,v in ipairs(self:Rows('hero',1600))do if self:Buff(v,self.profile.mark)then marked=marked+1 end end
 Core:Trace('irelia_r',{target=t.target,reason=t.why,plannedChampions=t.planned,markedChampions=marked,burstRadius=self.profile.rBurst})
end
-- Allowed champions within the burst radius of the target's predicted position
-- at first contact (the target included). The burst radius is not published;
-- profile rBurst (the 320 line width) is a lower bound until 'irelia_r' traces.
function IreliaChampion:RGroup(u)
 local origin=myHero.pos;local delay=self.profile.rDelay+GetDistance(u.pos,origin)/self.profile.rSpeed
 local contact=self:Project(u,delay);if not contact then return 0 end
 local count=0
 for _,v in ipairs(self:Rows('hero',self.profile.rRange+self.profile.rBurst))do
  if self:Allowed(v)then local p=self:Project(v,delay);if p and GetDistance(p,contact)<=self.profile.rBurst+(v.boundingRadius or 0)then count=count+1 end end
 end
 return count
end
-- Confirmed damage of ready abilities only: R, the first E blade when E is ready
-- (or the second when a blade waits), and one Q onto the R mark when Q is ready
-- and the dash in is allowed. No speculative extra Qs or attacks.
function IreliaChampion:RKills(u)
 local r=self.profile.rBase[myHero:GetSpellData(_R).level];if not r or not finite(myHero.ap)then return false end
 local magic=r+self.profile.rAP*myHero.ap;local e=myHero:GetSpellData(_E);local eBase=self.profile.eBase[e.level]
 if eBase and(self:Blade()or e.name==self.profile.e and self:Ready(_E))then magic=magic+eBase+self.profile.eAP*myHero.ap end
 local damage=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,magic)
 if self:Ready(_Q)and GetDistance(u.pos,myHero.pos)<=self.profile.qRange+150 and self:Safe(u.pos,true)then damage=damage+self:DamageQ(u)end
 return Core:Lethal(u,OrbamaPrediction:GetImpactTime(self.RSpell,u.pos,myHero),damage,{kind='magical'})==true
end
-- Why Combo R is worth it now: 'mark' (E is down and Q will dash onto the mark),
-- 'group' (two or more champions at first contact) or 'kill'; nil otherwise.
function IreliaChampion:RReason(u)
 if self:RSetsUpQ(u)then return 'mark'end
 local count=self:RGroup(u);if count>=2 then return 'group',count end
 if self:RKills(u)then return 'kill'end
end
-- R then Flash (off by default): Flash during R's cast moves where the blades
-- start while they keep their direction (DepressiveAIONext CurvedR model; not
-- live verified). Twelve Flash angles; only a landing that hits at least two
-- champions and more than the straight R is taken. The shared Flash follow-up
-- (Core:FlashFollow, spell_first) requests the Flash only after the R cast is
-- observed, within .2 s, and nothing is replayed.
function IreliaChampion:RFlashPlan(u)
 if not Menu.Combo.RFlash:Value()or not self:Ready(_R)or not self:Allowed(u)then return nil,'off'end
 local status,why=Core:FlashStatus();if not status then return nil,why end
 local rCost=myHero:GetSpellData(_R).mana;if not finite(rCost)or myHero.mana<rCost+status.cost then return nil,'mana'end
 local heroes={};for _,v in ipairs(self:Rows('hero',self.profile.rRange+status.range))do if self:Allowed(v)then heroes[#heroes+1]=v end end
 if #heroes<2 then return nil,'one_champion'end
 local healthy=finite(myHero.health)and finite(myHero.maxHealth)and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.HP:Value()
 if not healthy then return nil,'health'end
 local origin=point(myHero.pos);local target=self:Project(u,self.profile.rDelay+GetDistance(u.pos,origin)/self.profile.rSpeed)
 if not target then return nil,'target'end
 local dx,dz=target.x-origin.x,target.z-origin.z;local len=math.sqrt(dx*dx+dz*dz);if len<1 then return nil,'target'end;dx,dz=dx/len,dz/len
 local range=self.profile.rRange
 local function hits(from)
  if not from then return 0 end
  local stop=point({x=from.x+dx*range,y=from.y,z=from.z+dz*range});local n=0
  for _,v in ipairs(heroes)do local p=self:Current(v)and self:Project(v,self.profile.rDelay+GetDistance(v.pos,from)/self.profile.rSpeed)
   if p and onLine(from,stop,p,self.profile.rRadius+(v.boundingRadius or 0))then n=n+1 end end
  return n
 end
 local straight=hits(origin);local best,bestN
 for i=0,11 do local a=i*math.pi/6;local c,sn=math.cos(a),math.sin(a)
  local land=point({x=origin.x+(dx*c-dz*sn)*status.range,y=origin.y,z=origin.z+(dx*sn+dz*c)*status.range})
  if land and self:Safe(land,false)then local n=hits(land);if n>=2 and n>straight and(not bestN or n>bestN)then best,bestN=land,n end end
 end
 if not best then return nil,'no_better_line'end
 -- Kept for the drawing preview: the landing and the bent R line from it.
 self.rFlashSeen={landing=best,stop=point({x=best.x+dx*range,y=best.y,z=best.z+dz*range}),unit=u,handle=u.handle,at=Game.Timer()}
 -- The cast aims at the predicted target (the direction is what matters; a
 -- full-range point can sit off screen).
 return {landing=best,hits=bestN,straight=straight,aim=target,hitsFrom=hits}
end
function IreliaChampion:RFlash(u,context)
 local plan=self:RFlashPlan(u);if not plan then return false end
 self.rFlash=self.rFlash or Core:FlashFollow('IreliaRFlash')
 if self.rFlash:Busy()then return false end
 local function authorized()return GetMode()=='Combo'and Menu.Combo.R:Value()and Menu.Combo.RFlash:Value()and self:Allowed(u)end
 local ok=self.rFlash:Start({order='spell_first',aim=plan.landing,authorized=authorized,window=.2,ttl=1.2,
  valid=function(landing)return plan.hitsFrom(landing)>=2 end,
  follow=function(held)
   if not self:Ready(_R)then return false end
   return self:Submit(_R,HK_R,plan.aim,{owner='VanguardsEdgeFlash',context=held,intentTarget=u,independent=false,
    validate=function()return authorized()and self:Ready(_R,nil,true)and plan.hitsFrom(point(myHero.pos))>=1 end,
    observe=function(q)local yes=Core:NativeCast(q,self.profile.r)~=nil;if yes then self:NoteR(u,'flash')end;return yes end})
  end})
 if ok then self.rPlan={reason='flash',count=plan.hits};Core:Trace('irelia_rflash',{target=u.charName,hits=plan.hits,straight=plan.straight})end
 return ok==true
end
-- Hold the second blade (it lives 3.5 s) while the target already carries our
-- mark that Q (ready within .5 s) will consume, or for .6 s after our observed R
-- until its mark appears: the blade then marks and stuns again. Never once the
-- blade is about to expire.
function IreliaChampion:HoldE2(u,engage)
 local b=self:Buff(myHero,self.profile.e);local stop=b and ending(b)
 if not stop or stop<=Game.Timer()+.75 then return false end
 local q=myHero:GetSpellData(_Q);local impact=self:QImpact(u)
 if impact and q.name==self.profile.q and finite(q.currentCd)and q.currentCd<=.5 and engage(u)
  and self:Buff(u,self.profile.mark,impact+q.currentCd+.03)and self:QEligible(u,true,false)then return true end
 return self.rObservedAt~=nil and Game.Timer()-self.rObservedAt<=.6 and not self:Buff(u,self.profile.mark)
end
-- E is castable during Q's dash (wiki V26.17). While our own observed Q dash is
-- under way the first blade is aimed from where the dash ends, past the
-- predicted target; the request is valid only while that dash lasts.
function IreliaChampion:DashE(u,context,permission)
 local row=self.issued[_Q];local path=myHero.pathing
 if not row or not row.q.observedAt or row.uncertain or not path or path.isDashing~=true or not point(path.endPos)then return false end
 if myHero:GetSpellData(_E).name~=self.profile.e or self:Blade()or GetDistance(path.endPos,u.pos)>self.profile.eRange then return false end
 local stamp=row.q
 local function dashing()local r=self.issued[_Q];local p=myHero.pathing;return r~=nil and r.q==stamp and p~=nil and p.isDashing==true and point(p.endPos)~=nil end
 return self:CastE(u,context,nil,nil,permission,dashing,function()local p=myHero.pathing;return p and point(p.endPos)end)
end
-- Q another champion that carries our mark first (refunded), the one whose
-- landing is nearest the combat target; dashes outside attack range need EngageQ.
function IreliaChampion:NinjaQ(u,context,node,engage)
 if not self:Ready(_Q)then return false end
 local best,bestD
 for _,v in ipairs(self:Rows('hero',self.profile.qRange))do
  if v~=u and engage(v)then local ok,marked,_,pos=self:QEligible(v,true,false)
   if ok and marked then local d=GetDistance(pos,u.pos);if not bestD or d<bestD then best,bestD=v,d end end
  end
 end
 return best~=nil and self:CastQ(best,context,true,false,function()return node.Q:Value()and self:Mana(node.Mana)and engage(best)end)
end
-- Passive stacks before the engage: while E is down and the target is not
-- marked, a refunded Q onto a lane or jungle unit within 400 of the target that
-- does not move Irelia away from it (passive: +1 stack per non-champion hit).
function IreliaChampion:StackQ(u,context,node)
 local stacks=self:Stacks()
 if not stacks or stacks>=self.profile.stacks or not self:Ready(_Q)or self:Blade()or self:Ready(_E)or self:Buff(u,self.profile.mark)then return false end
 local here=GetDistance(myHero.pos,u.pos);local best,bestD
 for _,kind in ipairs({'lane','jungle'})do for i,v in ipairs(self:Rows(kind,self.profile.qRange))do if i>12 then break end
  local d=GetDistance(v.pos,u.pos)
  if d<=400 and d<=here then local ok,_,_,pos=self:QEligible(v,true,false)
   if ok and self:Safe(pos,true)and(not bestD or d<bestD)then best,bestD=v,d end
  end
 end end
 return best~=nil and self:CastQ(best,context,true,false,function()
  local p=self:Project(best,self:QImpact(best)or 0);return node.Q:Value()and self:Mana(node.Mana)and p~=nil and self:Safe(p,true)and not self:Buff(u,self.profile.mark)end)
end
-- R marks its target for a Q reset: spend it when E cannot mark and the dash in is allowed.
function IreliaChampion:RSetsUpQ(u)
 return self:Ready(_Q)and not self:Blade()and myHero:GetSpellData(_E).name==self.profile.e and not self:Ready(_E)
  and not self:Buff(u,self.profile.mark)and GetDistance(u.pos,myHero.pos)<=self.profile.qRange+150 and self:Safe(u.pos,true)
end
function IreliaChampion:Combat(mode)
 if self.engine then return self.engine:Combat(mode)end
 local node=Menu[mode];if GetMode()~=mode or not self:Blade()and not self:Mana(node.Mana)then return false end
 local context=Core:ModeContext(mode,function()return self:Blade()~=nil or self:Mana(node.Mana)end);local u=self:Target(self.profile.rRange);if not u then return false end
 local function engage(v)return node.EngageQ:Value()or _G.SDK.Data:IsInAutoAttackRange(myHero,v)end
 if node.E:Value()and self:DashE(u,context,function()return node.E:Value()end)then return true end
 if node.Q:Value()and self:Buff(u,self.profile.mark,(self:QImpact(u)or 0)+.03)and engage(u)then
  if self:CastQ(u,context,true,false,function()return node.Q:Value()and self:Mana(node.Mana)and engage(u)end)then return true end
 end
 if node.Q:Value()and self:NinjaQ(u,context,node,engage)then return true end
 if self:Blade()and node.E:Value()then
  if not self:HoldE2(u,engage)then return self:CastE(u,self.blade.context,nil,nil,function()return node.E:Value()end)end
 elseif node.E:Value()and self:CastE(u,context,nil,nil,function()return node.E:Value()end)then return true end
 if node.Q:Value()and(self.profile.qRange>=GetDistance(u.pos,myHero.pos))and engage(u)then
  if self:CastQ(u,context,true,false,function()return node.Q:Value()and engage(u)and self:Mana(node.Mana)end)then return true end end
 if mode=='Combo'and node.Q:Value()and self:StackQ(u,context,node)then return true end
 if mode=='Combo'and Menu.Combo.R:Value()and self:Ready(_R)then
  if self:RFlash(u,context)then return true end
  local why,count=self:RReason(u)
  if why and self:CastR(u,context,function()return Menu.Combo.R:Value()end,function()return self:RReason(u)~=nil end)then self.rPlan={reason=why,count=count};return true end
 end
 if node.W:Value()then return self:StartW(u,context,function()return node.W:Value()end)end;return false
end
function IreliaChampion:Combo()return self:Combat('Combo')end
function IreliaChampion:Harass()return self:Combat('Harass')end
function IreliaChampion:Farm(kind)
 if self.engine then return self.engine:Farm(kind,kind=='lane'and 'LaneClear'or 'JungleClear',false)end
 if not Menu.Clear.SpellFarm:Value()or not Core:FarmModeEnabled(kind)then return false end
 local node=Menu.Clear[kind=='lane'and'LaneClear'or'JungleClear'];if not self:Blade()and not self:Mana(node.Mana)then return false end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()and(self:Blade()~=nil or self:Mana(node.Mana))end)
 local rows=self:Rows(kind,self.profile.eRange)
 if node.Q:Value()and self:Ready(_Q)then for i=1,math.min(#rows,12)do if self:CastQ(rows[i],context,true,false,function()return node.Q:Value()end,true)then return true end end end
 if node.E:Value()and self:Ready(_E,myHero:GetSpellData(_E).name)then
  local count=kind=='lane'and Menu.Clear.LaneClear.ECount:Value()or 1
  for i=1,math.min(#rows,6)do if self:CastE(rows[i],self:Blade()and self.blade.context or context,kind,count,function()return node.E:Value()end)then return true end end
 end
 if node.W:Value()and rows[1]then return self:StartW(rows[1],context,function()return node.W:Value()end)end;return false
end
function IreliaChampion:LaneClear()return self:Farm('lane')end
function IreliaChampion:JungleClear()return self:Farm('jungle')end
function IreliaChampion:LastHit()
 if self.engine then return self.engine:Farm('lane','LastHit',true)end
 if GetMode()~='LastHit'or not Menu.LastHit.Q:Value()or not self:Mana(Menu.LastHit.Mana)or not self:Ready(_Q)then return false end
 local context=Core:ModeContext('LastHit',function()return Menu.LastHit.Q:Value()and self:Mana(Menu.LastHit.Mana)end)
 for i,u in ipairs(self:Rows('lane',self.profile.qRange))do if i>12 then break end;if self:CastQ(u,context,true,true,function()return Menu.LastHit.Q:Value()end,true)then return true end end;return false
end
function IreliaChampion:Flee()
 if self.engine then return self.engine:Flee()end
 if GetMode()~='Flee'then return false end
 if self:ContinueRoute()or self:FleeQ()then return true end
 local u=self:Target(self.profile.eRange);if Menu.Misc.FleeE:Value()and u then
  return self:CastE(u,self:Blade()and self.blade.context or Core:ModeContext('Flee'),nil,nil,function()return Menu.Misc.FleeE:Value()end)
 end;return false
end
-- Flee without a refunded hop: once the route search toward the cursor has
-- just finished empty, one Q onto a lane or jungle unit that moves Irelia at
-- least 300 toward the cursor and lands among fewer enemy champions than stand
-- around her now. Q then goes on its full cooldown.
function IreliaChampion:FleeUnit(cursor,only)
 local function near(p)local n=0;for _,v in ipairs(self:Rows('hero',1800))do if GetDistance(v.pos,p)<600 then n=n+1 end end;return n end
 local here=near(myHero.pos);if here<=0 then return nil end
 local before=GetDistance(myHero.pos,cursor);local best,bestProgress,count=nil,nil,0
 for _,kind in ipairs({'lane','jungle'})do for _,v in ipairs(self:Rows(kind,self.profile.qRange))do
  count=count+1;if count>12 then break end
  local progress=before-GetDistance(v.pos,cursor)
  if(not only or v==only)and progress>=300 then
   local ok,_,_,pos=self:QEligible(v,false,false)
   if ok and near(pos)<here and(not bestProgress or progress>bestProgress)then best,bestProgress=v,progress end
  end
 end;if count>12 then break end end
 return best
end
function IreliaChampion:FleeQ()
 local searched=self.routeSearched;local r=self.route
 if not self:Ready(_Q)or self.charge or not searched or searched.kind~='flee'or searched.found or Game.Timer()-searched.at>.3
  or r and Game.Timer()<=r.expires and not r.visited[id(r.first)]then return false end
 local cursor=point(mousePos);if not cursor then return false end
 local u=self:FleeUnit(cursor);if not u then return false end
 return self:CastQ(u,Core:ModeContext('Flee'),false,false,function()local c=point(mousePos);return GetMode()=='Flee'and c~=nil and self:FleeUnit(c,u)==u end)
end
function IreliaChampion:Assist()
 for _,key in ipairs({'EAssist','RAssist'})do local node=Menu.Misc[key]
  if not node:Value()then self.gestures[key]=nil
  elseif not self.gestures[key]then
   local context=Core:HeldContext(function()return node:Value()end);local u=self:Target(self.profile.rRange);local yes
   if key=='EAssist'and u then yes=self:CastE(u,context,nil,nil,function()return node:Value()end)
   elseif key=='RAssist'and u then yes=self:CastR(u,context,function()return node:Value()end)end
   if yes then self.gestures[key]=true end
  elseif key=='EAssist'and self:Blade()then local u=self:Target(self.profile.eRange);if u then return self:CastE(u,Core:HeldContext(function()return node:Value()end),nil,nil,function()return node:Value()end)end end
 end;return self:ContinueRoute()
end
function IreliaChampion:Interrupt()
 if not Menu.Misc.InterruptE:Value()or self.charge then return false end
 for _,u in ipairs(self:Rows('hero',self.profile.eRange))do local a=u.activeSpell
  if a and a.valid and a.isChanneling and not a.isStopped and finite(a.castEndTime)and a.castEndTime>Game.Timer()+self.ESpell.Delay+(self:Blade()and 0 or self.profile.eRecast+self.profile.eDelay)then
   return self:CastE(u,self:Blade()and self.blade.context or{condition=function()return Menu.Misc.InterruptE:Value()and u.activeSpell==a and a.valid and not a.isStopped end},nil,nil,
    function()return Menu.Misc.InterruptE:Value()and u.activeSpell==a and a.valid and a.castEndTime>Game.Timer()+self.ESpell.Delay end)
  end
 end;return false
end
function IreliaChampion:IncomingAttack(u,token)
  if not self:Current(u)then return nil end
  local a=Core:CastWindup(u,token and -1 or -.05,1.25,true,myHero.networkID,myHero.handle)
  if not a or token and(a.name~=token.name or a.start~=token.start or id(u)~=token.id or u.handle~=token.handle)then return nil end
 local speed=u.attackData and u.attackData.projectileSpeed
  if speed~=math.huge and(not finite(speed)or speed<=0)then return nil end
  local impact=a.castEndTime-Game.Timer()+(speed==math.huge and 0 or GetDistance(u.pos,myHero.pos)/speed)
  -- The acquisition horizon must not cancel an already-owned stance just before impact.
   return impact>=(token and -.1 or .3)and impact<=1.2 and{name=a.name,start=a.start,impact=impact,id=id(u),handle=u.handle}or nil
end
function IreliaChampion:AutoW()
 if not Menu.Misc.AutoW:Value()or not self:Ready(_W)or self.charge or not finite(myHero.health)or not finite(myHero.maxHealth)or myHero.maxHealth<=0
  or myHero.health/myHero.maxHealth*100>Menu.Misc.AutoWHP:Value()then return false end
 for _,u in ipairs(self:Rows('hero',1600))do local token=self:IncomingAttack(u)
  if token then local function valid()return Menu.Misc.AutoW:Value()and self:IncomingAttack(u,token)~=nil end
   return self:StartW(nil,{priority='critical',condition=valid},valid)
  end
 end;return false
end
function IreliaChampion:DashDefense()
 local mode=GetMode();if not Menu.Misc.Gapclose:Value()or(mode~='Combo'and mode~='Harass')or not Menu[mode].E:Value()or self.charge then return false end
 local allowed=function()return Menu.Misc.Gapclose:Value()and Menu[mode].E:Value()end
 for _,u in ipairs(self:Rows('hero',self.profile.eRange))do
   local function incoming()
    local p=self:Allowed(u)and Core:ApproachingDash(u,myHero.pos,300)
    return p and GetDistance(p.to,myHero.pos)+50<GetDistance(p.from,myHero.pos)or false
  end
  if incoming()and self:CastE(u,Core:ModeContext(mode,allowed),nil,nil,allowed,incoming)then return true end
 end;return false
end
function IreliaChampion:IndependentSecure()
 local function allowed()return Menu.Misc.KillSecure:Value()and self:Mana(Menu.Misc.KSMana)end
 if not allowed()or self.charge then return false end
 local context={priority='interactive',condition=allowed}
 for _,u in ipairs(self:Rows('hero',self.profile.rRange))do if self:Allowed(u)then
  -- Inside attack range: marked or killing Q. Beyond it, up to Q range: only a
  -- Q that kills from current health (QEligible rescue), landing Safe(pos,true).
  if _G.SDK.Data:IsInAutoAttackRange(myHero,u)then if self:CastQ(u,context,true,false,allowed)then return true end
  elseif self:CastQ(u,context,false,true,allowed)then return true end
  local function lethal(slot,delay)
   local rank=myHero:GetSpellData(slot).level;local base=slot==_E and self.profile.eBase[rank]or self.profile.rBase[rank]
   if not base then return false end
   local raw=base+(slot==_E and self.profile.eAP or self.profile.rAP)*myHero.ap
   local damage=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
    local estimate=Core:HealthEstimate(u,delay,'magical',damage)
    return self:Allowed(u)and estimate and estimate.lethal and Core:SpellProtected(u)==false or false
  end
  local blade=self:Blade()
   if blade and Core.adapter:ContextValid({context=blade.context})and lethal(_E,OrbamaPrediction:GetImpactTime(self.ESpell,u.pos,myHero))
    and self:CastE(u,context,nil,nil,allowed,function()return lethal(_E,OrbamaPrediction:GetImpactTime(self.ESpell,u.pos,myHero))end)then return true end
   if lethal(_R,OrbamaPrediction:GetImpactTime(self.RSpell,u.pos,myHero))
    and self:CastR(u,context,allowed,function()return lethal(_R,OrbamaPrediction:GetImpactTime(self.RSpell,u.pos,myHero))end)then return true end
 end end;return false
end
function IreliaChampion:Tick()
 if self.engine then return self.engine:Tick() end
 if not Core:InputAvailable()then self:CloseCharge('input_unavailable');return end
 self:CollectCharges();self:MaintainIssued();if self:MaintainCharge()then return end
 if self.blade and(Game.Timer()>self.blade.expires or myHero:GetSpellData(_E).name==self.profile.e)then self.blade=nil end
 if not self.nextDiscover or Game.Timer()>self.nextDiscover then self:DiscoverTargets();self.nextDiscover=Game.Timer()+1 end
 if self.routeFallback then self:PrepareRoute()end;if self.previewFallback then self:PreparePreview()end
 self:TraceR()
 if ShouldWait()then if self.rFlash then self.rFlash:Cancel('unavailable')end;return end
 if self.rFlash and self.rFlash:Maintain()then return end
 if self:AutoW()or self:Assist()or self:Interrupt()or self:DashDefense()or self:IndependentSecure()or self:SecureRoute()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LaneClear'then self:LaneClear();self:JungleClear()elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
-- Everything Draw shows is prepared here (budgeted job): the minions Q kills
-- now by the farming rule (at most 12), the ready E blade and the Q route. No
-- passive, mark or damage text: the game shows the stacks and marks, the health
-- bars the damage. Kept for a second so a late preparation never blinks it;
-- Draw drops a unit that died and a blade or route that ended.
-- Planned actions (drawn with Draw.Preview) are copies of what the planners already decided:
-- the E line the last E decision solved, the R-Flash landing (only with
-- Combo.RFlash on), every hop of the prepared Q route and the champion a
-- finishing route kills. Each copy is held up to a second while a planner skips
-- a cycle, so it does not flicker, and is dropped at once on death, when the mode
-- that planned it is released, its unit dies or the plan is spent.
local function rowAlive(row)local v=row and row.unit;return v and not v.dead and v.visible~=false and v.handle==row.handle and point(v.pos)and v end
function IreliaChampion:PlanLive(row,mode)
 if not row or myHero.dead or not Menu.Draw.Preview:Value()then return false end
 if row.mode=='secure'then if mode=='Combo'or mode=='Flee'or not self:SecureAllowed()then return false end
 elseif row.mode~=mode then return false end
 if row.kind=='e'then return myHero:GetSpellData(_E).name==row.stage and rowAlive(row)and true or false end
 if row.kind=='r'then return Menu.Combo.RFlash:Value()and IsReady(_R)and rowAlive(row)and true or false end
 return true
end
function IreliaChampion:PreparePlans(now)
 local old=self.preview and self.preview.plans or {};local mode=GetMode();local plans={}
 local function keep(fresh,prev)
  if fresh then fresh.till=now+1;return self:PlanLive(fresh,mode)and fresh or nil end
  if prev and now<=prev.till and self:PlanLive(prev,mode)then return prev end
 end
 local e=self.ePlanned
 plans.e=keep(e and now-e.at<=.3 and point(e.a)and point(e.b)and{kind='e',a=point(e.a),b=point(e.b),unit=e.unit,handle=e.handle,stage=e.stage,mode=e.mode},old.e)
 local r=Menu.Combo.RFlash:Value()and self.rFlashSeen
 plans.r=keep(r and now-r.at<=.3 and point(r.landing)and point(r.stop)and{kind='r',landing=point(r.landing),stop=point(r.stop),unit=r.unit,handle=r.handle,mode='Combo'},old.r)
 local route=self.route;local fresh
 if route and now<=route.expires+.3 then
  local hops={};for i,v in ipairs(route.path or {route.first})do if i>3 then break end;hops[i]={unit=v,handle=v.handle}end
  local t=route.target;fresh={kind='route',source=route,hops=hops,target=t and{unit=t,handle=t.handle},kill=route.kind=='secure',
   mode=route.kind=='combat'and'Combo'or route.kind=='flee'and'Flee'or'secure'}
 end
 plans.route=keep(fresh,old.route)
 return plans
end
function IreliaChampion:PreparePreview()
 if self.engine then return self.engine:PreparePreview()end
 local shows=Menu.Draw.Preview:Value();local plans=shows
 if not shows and not plans or myHero.dead then self.preview=nil;return end
 local killable={}
 if shows and myHero:GetSpellData(_Q).level>=1 then
  for i,v in ipairs(self:Rows('lane',self.profile.qRange+300))do if i>12 then break end
   local delay=self:QImpact(v);if delay and self:QLethal(v,delay)then killable[#killable+1]={unit=v,handle=v.handle}end
  end
 end
 local now=Game.Timer();local route=self.route;local first=route and route.first
 self.preview={expires=now+1,blade=self:Blade()and point(self.blade.position),route=first and{unit=first,handle=first.handle},killable=killable,
  plans=plans and self:PreparePlans(now)or nil}
end
local function drawLine(a,b,width,color)
 if type(Draw.Line)~='function'or not a or not b then return end
 local x,y=a:To2D(),b:To2D();if x and y then Draw.Line(x.x,x.y,y.x,y.y,width,color)end
end
-- Geometry only: copies made by PreparePlans plus cheap liveness reads.
function IreliaChampion:DrawPlans(plans)
 local now=Game.Timer();local mode=GetMode()
 local function live(row)return row and now<=row.till and self:PlanLive(row,mode)end
 local e=plans.e;if live(e)then local c=Draw.Color(200,255,220,80);drawLine(e.a,e.b,2,c);Draw.Circle(e.a,40,1,c)end
 local r=plans.r;if live(r)then local c=Draw.Color(200,255,140,60);drawLine(point(myHero.pos),r.landing,1,c);Draw.Circle(r.landing,65,1,c);drawLine(r.landing,r.stop,2,c)end
 local route=plans.route
 if live(route)then
  local c=Draw.Color(200,180,80,220);local from=point(myHero.pos);local visited=route.source and route.source.visited or {}
  for _,row in ipairs(route.hops)do local v=rowAlive(row)
   if v and not visited[id(v)]then local to=point(v.pos);drawLine(from,to,2,c);Draw.Circle(to,55,1,c);from=to end
  end
  local t=rowAlive(route.target)
  if t and route.mode~='Flee'then drawLine(from,point(t.pos),1,c)
   if route.kill then Draw.Circle(t.pos,(t.boundingRadius or 65)+40,2,Draw.Color(230,255,70,70))end
  end
 end
end
function IreliaChampion:Draw()
 if self.engine then return self.engine:Draw() end
 if myHero.dead then return end
 if Menu.Draw.Ranges:Value()then
  for slot,r in pairs({[_Q]=self.profile.qRange,[_E]=self.profile.eRange,[_R]=self.profile.rRange})do if IsReady(slot)then Draw.Circle(myHero.pos,r,1,Draw.Color(255,120,180,255))end end
 end
 local p=self.preview;if not p or Game.Timer()>p.expires then return end
 if p.plans and Menu.Draw.Preview:Value()then self:DrawPlans(p.plans)end
 if not Menu.Draw.Preview:Value()then return end
 local route=self.route and rowAlive(p.route);if route then Draw.Circle(route.pos,55,1,Draw.Color(180,80,220,255))end
 if p.blade and self.blade then Draw.Circle(p.blade,40,1,Draw.Color(180,255,220,80))end
 for _,row in ipairs(p.killable or {})do local v=rowAlive(row);if v then Draw.Circle(v.pos,60,1,Draw.Color(200,120,255,120))end end
end
function IreliaChampion:RegisterGuide(guide)
 if self.engine then return self.engine:RegisterGuide(guide) end
 return guide:Register('champion',{'Irelia: control','Irelia: combat'},function(page)return{title='Irelia assistance',cards=page==1 and{
  {'ROUTES','Q dashes through marked or killable units: toward the cursor in Flee, to the target in Combo, through the wave while clearing.'},
  {'DUET','The E bind places the first blade and casts the second once it can hit the target.'},
  {'DANCE','W charges while standing still and releases at full charge; cancelling it can still release the cast.'}}or{
  {'SAFETY','Dashes respect the health and enemy-count limits and enemy turrets. Combo R marks the target when E is down, hits two or more champions or finishes a kill; Flash after R stays off unless enabled. Farming Q may land under an enemy turret only while it shoots allied minions. The R bind casts at the selected target.'},
  {'FARM','The farm toggle and the lane and jungle menus control spending. LastHit Q only takes minions an attack would miss.'},
  {'LIMITS','Marks, stacks, resets and the W charge are read from the game; timers never stand in for them.'}}}end)
end
function IreliaChampion:FeatureStatus()
 local evadeQ={supported=true,liveVerified=false,contract='SDK.ChampionMobility unitDash',
  scope='dash_onto_unit_refunded_casts_first_no_immunity_travel_hit_tested',
  unverified='landing_offset_modelled_as_unit_position_and_near_side_contact_point_both_must_be_safe_wall_crossing_not_modelled'}
 if self.engine then return {profile=self.profile.id,patch=CombatMechanics.patch,liveVerified=false,evadeQ=evadeQ} end
 return{classic={supported=true,liveVerified=false,source='26.20 active Jade_Irelia slot extraction'},
  objectBladeAdoption={supported=false,reason='ground_object_alias_and_owner_contract_unverified_native_cast_endpoint_is_used'},
   evadeQ=evadeQ,
  evadeW={supported=true,liveVerified=false,scope='physical_and_half_magical_only_during_bounded_owned_charge_window'},
  procResetCredit={supported=false,reason='conditional_item_onhit_graph_not_verified_base_Q_is_conservative'}}
end
Core:RegisterPolicy({damageTypes={Q='physical',W='physical',E='magical',R='magical'},methods={
 Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,
 JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
 LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end},
 costPaid=function(self,q,slot)return slot==_E and q.spellName==self.profile.e2 and self:Blade()~=nil end,
 validate=function(self,q,slot)return type(slot)~='number'or slot<0 or slot>3 or self:Ready(slot,q.spellName,true)end})
IreliaChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Irelia"]="Irelia"}
local normalSupported={["Irelia"]=true}

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
