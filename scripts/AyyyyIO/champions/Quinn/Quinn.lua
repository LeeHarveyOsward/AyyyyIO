return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Quinn"]=function()return _G.OrbamaFamily:Require("dffc64a28ba3c3fc62267a74d598327f20bfe9dbb8dd27dfbd175ae67e432e56")()end
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
if champion=="Quinn" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Quinn',profiles={normal=true,classic=true},
 Create=function(context)
local GameplayHooks=(function(g,C,P)
 local H,G,SDK=g.myHero,g.Game,g.SDK
 local id=C.id
 local finite=P.Finite
 local function permission(f,mode,slot)return function()return f:Permission(mode,slot)end end
 local function hp(u)return u.health/u.maxHealth end
 local function channel(u)return u and C:IsChannelCast(u.activeSpell,false)end
 local Hooks={}

 -- Combat R only ends flight with Skystrike; Flee R takes off once no enemy is near.
 Hooks.defaults={Combo={R=true},JungleClear={E=true},Flee={E=true,R=true}}
 function Hooks.valor(f)
  return f.profile.id=='classic'and H:GetSpellData(0).name==f.profile.valorQ
 end
 -- Normal flight is the QuinnRFinale stage only. The 2 s take-off channel shows
 -- QuinnRReturnToQuinn: a recast there cancels the channel and starts the
 -- cooldown, so no R is ever sent in that stage (Quinn-9).
 function Hooks.flight(f)
  return f.profile.id=='normal'and H:GetSpellData(3).name==f.profile.flightName
 end
 function Hooks.channelStage(f)
  local stage=H:GetSpellData(3).name==f.profile.channelName
  if stage then C:Trace('quinn_r_channel',{profile=f.profile.id,selfChanneling=C:SelfChanneling(true)==true},1)end
  return stage
 end
 function Hooks.travel(f)
  if f.profile.id=='classic'then return Hooks.valor(f)end
  return Hooks.flight(f)
 end
 -- Skystrike hits within its 700 radius; the centre of a target is required a
 -- margin inside it so the target cannot walk out while the cast resolves.
 function Hooks.skyReach(f)return f:Range(3)-(f.profile.r.margin or 0)end
 function Hooks.mark(f,u)return f:Buff(u,f.profile.markNames,true)end
 -- The attack on a Harrier-marked enemy is the kit's damage: the shared attack
 -- preference keeps attacks on the marked champion while it is in attack range.
 function Hooks.attackTarget(f,mode)
  if mode~='Combo'and mode~='Harass'then return end
  for _,u in ipairs(f:Rows('hero',900))do if f:Allowed(u)and f:AttackReach(u)and Hooks.mark(f,u)then return u end end
 end
 -- In flight any damaging ability ends the flight with an automatic Skystrike
 -- around Quinn: Q only when that Skystrike also reaches the target (Quinn-1).
 local function flightClear(f,u)return not Hooks.flight(f)or f:Reach(u,Hooks.skyReach(f))end
 function Hooks.castQ(f,u,context,allowed)
  if Hooks.mark(f,u)and f:AttackReach(u)then return false end
  if not flightClear(f,u)then return false end
  if Hooks.valor(f)then return f:Cast(0,u,context,{selfCast=true,range=f.profile.q.melee,permission=allowed,check=function()return Hooks.valor(f)and f:Reach(u,f.profile.q.melee)end})end
  if f:Cast(0,u,context,{world=true,permission=allowed,check=function()return flightClear(f,u)end})then return true end
  return Hooks.splashQ(f,u,context,allowed)
 end
 -- Q stops at the first unit and explodes for 210 around it. When a minion
 -- blocks the line to a champion standing beside it, aim at that minion
 -- (Quinn-10): the champion's predicted position must lie inside the explosion
 -- (25 short of its edge) around the minion's predicted position, and nothing
 -- else, a wind wall included, may stand on the line to the minion.
 function Hooks.qSettings(f)
  local q=f.profile.q;local O=g.OrbamaPrediction
  if not f.quinnQSettings then
   f.quinnQSettings={Type=O.SPELLTYPE_LINE,Delay=q.delay,Radius=q.radius,Range=f:Range(0),Speed=q.speed,Collision=true,DirectionalCast=true,AimErrorWorld=5,
    CollisionTypes={O.COLLISION_MINION,O.COLLISION_ENEMYHERO,O.COLLISION_YASUOWALL}}
  end
  return f.quinnQSettings
 end
 function Hooks.splashQ(f,u,context,allowed)
  if u.type~=g.Obj_AI_Hero or not f:Current(u)or not f:Ready(0)then return false end
  local O=g.OrbamaPrediction;if not O or type(O.GetCollision)~='function'then return false end
  local q=f.profile.q;local settings=Hooks.qSettings(f)
  local pred=C:Prediction(settings);pred:GetPrediction(u,H)
  if pred:CanHit(2)or pred.LastFailureReason~='collision'then return false end
  local target,aim,list=f.point(pred.UnitPosition),f.point(pred.CastPosition),pred.CollionableObjects
  if not target or not aim or type(list)~='table'then return false end
  local dx,dz=aim.x-H.pos.x,aim.z-H.pos.z;local length=math.sqrt(dx*dx+dz*dz);if length<1 then return false end
  local first,nearest
  for i=1,math.min(#list,8)do local o=list[i]
   if type(o)=='table'and o.pos then local along=((o.pos.x-H.pos.x)*dx+(o.pos.z-H.pos.z)*dz)/length
    if not nearest or along<nearest then nearest,first=along,o end
   end
  end
  if not first or first.type==g.Obj_AI_Hero or not f:Current(first)then return false end
  local radius=(q.explosion or 0)-25+(u.boundingRadius or 0)
  local cp=f:Prediction(first,q);local landing=cp and f.point(cp.UnitPosition);local cast=cp and f.point(cp.CastPosition)
  if not landing or not cast or f.distance(landing,target)>radius then return false end
  local wall=O:GetCollision(H.pos,cast,q.speed,q.delay,q.radius,{O.COLLISION_YASUOWALL},first.networkID)
  if wall then return false end
  local identity,handle=id(first),first.handle
  return f:Cast(0,nil,context,{position=cast,range=f:Range(0),permission=allowed,check=function()
   return f:Current(u)and f:Allowed(u)and f:Current(first)and id(first)==identity and first.handle==handle and flightClear(f,u)
    and f.distance(first.pos,cast)<=q.radius+(first.boundingRadius or 0)+(first.ms or 0)*.5 and f.distance(first.pos,u.pos)<=radius+(u.ms or 0)*.25
  end})
 end
 function Hooks.landing(f,u)
  if Hooks.valor(f)then return f.point(u.pos)end
  -- Vault returns Quinn away from the recipient to a fixed attack-distance arc.
  -- Reject both approach and return when terrain/safety cannot be established.
  if f.distance(u.pos,H.pos)<1 then return end
  return u.pos:Extended(H.pos,f.profile.eLanding or 525)
 end
 -- timed: right after an observed attack (Hooks.attack). Without it an E on a
 -- target in attack range waits for the attack cooldown so it never delays a
 -- ready attack; E resets the attack timer and re-marks (Quinn-3).
 function Hooks.castE(f,u,context,allowed,peel,interrupt,timed)
  if not f:Ready(2)or not f:Reach(u,f:Range(2))then return false end
  -- In flight E ends the flight with a Skystrike at the target after the bounce:
  -- only in Combo (Quinn-1).
  if Hooks.flight(f)and not(context and context.mode=='Combo')then return false end
  if Hooks.mark(f,u)and f:AttackReach(u)and not channel(u)and not peel then return false end
  if not peel and not f:AttackReach(u)and not channel(u)then
   -- Classic Valor E lands on the target with no vault back: a real dive with
   -- its own switch, off by default (Quinn-14).
   if Hooks.valor(f)then if not f.menu.Misc.ValorDive:Value()then return false end
   elseif not f.menu.Misc.Risk:Value()then return false end
  end
  if not peel and not interrupt and not timed and f:AttackReach(u)and not C:WeaveWindow(0,u)then return false end
   local function safe()
    local landing=Hooks.landing(f,u);return landing and f:Safe(landing,not peel)and f:Safe(u.pos,not peel)
     and f:Safe((H.pos+u.pos)/2,false)and(not interrupt or C:CanInterrupt(u,f:Impact(2,u)))
     and(not Hooks.flight(f)or context and context.mode=='Combo')
  end
  if not safe()then return false end
  return f:Cast(2,u,context,{permission=allowed,check=function()return safe()end,after=function(q)
   f.sequences.vault={action=q.id,intent=q,target=u,identity=id(u),handle=u.handle,context=context,origin=f.point(H.pos),started=G.Timer(),expires=G.Timer()+1.25,observed=true,valor=Hooks.valor(f)}
  end})
 end
 -- After an observed attack on a champion in range whose mark it consumed, E
 -- follows at once: reset, re-mark and the next attack procs Harrier again.
 function Hooks.attack(f,observation)
  local u=observation and observation.object;local mode=f:Mode()
  if(mode~='Combo'and mode~='Harass')or not u or u.type~=g.Obj_AI_Hero or not f:Current(u)or not f:Allowed(u)
   or not f:Permission(mode,2)or not f:AttackReach(u)or Hooks.mark(f,u)then return false end
  return Hooks.castE(f,u,f:Context(mode),function()return f:Permission(mode,2)and not Hooks.mark(f,u)end,false,false,true)
 end
 function Hooks.castR(f,u,context,allowed)
  if not Hooks.travel(f)or Hooks.channelStage(f)then return false end
  if not f:Reach(u,Hooks.skyReach(f))then return false end
  if f.profile.id=='classic'and f:Damage(3,u)<u.health+(u.shieldAD or 0)and hp(H)>.5 then return false end
  return f:Cast(3,u,context,{selfCast=true,range=f:Range(3),permission=allowed,check=function()return Hooks.travel(f)and not Hooks.channelStage(f)and f:Reach(u,Hooks.skyReach(f))end})
 end
 -- W reveals 2100 (Classic 1950) around Quinn. Up to five allowed enemy
 -- champions seen in the last 1.5 s near attack range (and the combat or
 -- selected target) are remembered by identity; one that turns invisible
 -- while its last position is inside the reveal is the trigger (Quinn-2).
 local function see(f,u)
  if not u or u.type~=g.Obj_AI_Hero or u.team==H.team or not u.valid or u.dead or not u.visible or not f:Allowed(u)then return end
  local tracked=f.tracked;local identity=id(u);local now=G.Timer();local oldest
  for i,t in ipairs(tracked)do
   if t.id==identity and t.handle==u.handle then t.object=u;t.position=f.point(u.pos);t.at=now;return end
   if not oldest or t.at<tracked[oldest].at then oldest=i end
  end
  local row={object=u,id=identity,handle=u.handle,position=f.point(u.pos),at=now}
  if #tracked>=5 then tracked[oldest]=row else tracked[#tracked+1]=row end
 end
 function Hooks.observe(f)
  local tracked=f.tracked or {};f.tracked=tracked;local now=G.Timer()
  for i=#tracked,1,-1 do local t=tracked[i];local o=t.object
   if now-t.at>1.5 or o.dead or(o.health or 0)<=0 or o.handle~=t.handle or id(o)~=t.id then table.remove(tracked,i)end
  end
  local selected=SDK.TargetSelector.GetSelectedTarget and SDK.TargetSelector:GetSelectedTarget()
  if selected and selected.pos and f.distance(H.pos,selected.pos)<=f.profile.w.range then see(f,selected)end
  for _,u in ipairs(f:Rows('hero',(H.range or 525)+(H.boundingRadius or 65)+300))do see(f,u)end
 end
 function Hooks.vision(f,mode,context)
  if not f:Permission(mode,1)then return false end
  local now=G.Timer();local t
  for _,row in ipairs(f.tracked or {})do
   if row.object.visible==false and now-row.at<=1.5 and f.distance(H.pos,row.position)<=f.profile.w.range then t=row;break end
  end
  if not t then return false end
  return f:Cast(1,nil,context,{selfCast=true,permission=permission(f,mode,1),check=function()
   local listed=false;for _,row in ipairs(f.tracked or {})do if row==t then listed=true;break end end
   return listed and t.object.visible==false and not t.object.dead and id(t.object)==t.id and t.object.handle==t.handle
    and G.Timer()-t.at<=1.5 and f.distance(H.pos,t.position)<=f.profile.w.range
  end,after=function()f.tracked={}end})
 end
 function Hooks.combat(f,u,mode,context)
  see(f,u)
  if f:Permission(mode,3)and Hooks.castR(f,u,context,permission(f,mode,3))then return true end
   if f.menu.Misc.Interrupt:Value()and C:CanInterrupt(u,f:Impact(2,u))and f:Permission(mode,2)
    and Hooks.castE(f,u,context,function()return f.menu.Misc.Interrupt:Value()and f:Permission(mode,2)end,true,true)then return true end
  if f:Permission(mode,0)and Hooks.castQ(f,u,context,permission(f,mode,0))then return true end
  if f:Permission(mode,2)and Hooks.castE(f,u,context,permission(f,mode,2),false)then return true end
  return Hooks.vision(f,mode,context)
 end
 function Hooks.background(f)
  local mode=f:Mode();return(mode=='Combo'or mode=='Harass')and Hooks.vision(f,mode,f:Context(mode))or false
 end
 -- Lane minions inside the Q explosion around `pos` (Valor: around Quinn).
 function Hooks.explosionCount(f,pos,rows)
  local radius=Hooks.valor(f)and f.profile.q.melee or f.profile.q.explosion;local n=0
  for _,m in ipairs(rows)do if f.distance(m.pos,pos)<=radius+(m.boundingRadius or 0)then n=n+1 end end
  return n
 end
 -- LaneClear Q: of at most 8 minions in range that are first on their own line,
 -- the one whose explosion covers the most lane minions; at most three are
 -- predicted. The count is taken again before the input is sent (Quinn-6).
 function Hooks.laneQ(f,rows,mode,context)
  local need=f.menu.LaneClear.Count:Value()
  local function enough(m)return f:Permission(mode,0)and Hooks.explosionCount(f,Hooks.valor(f)and H.pos or m.pos,f:Rows('lane',1300))>=need end
  if Hooks.valor(f)then
   if Hooks.explosionCount(f,H.pos,rows)<need then return false end
   for _,m in ipairs(rows)do if f:Reach(m,f.profile.q.melee)then return Hooks.castQ(f,m,context,function()return enough(m)end)end end
   return false
  end
  local q=f.profile.q;local range=f:Range(0);local candidates={}
  -- First on its own line: no other lane minion nearer on the Q path. Units
  -- behind it are inside the same explosion, so the line needs no collision
  -- prediction of its own; this check is repeated before sending.
  local function first(m,list)
   local d=f.distance(H.pos,m.pos)
   for _,o in ipairs(list)do
    if o~=m and f.distance(H.pos,o.pos)<d and f:Line(H.pos,m.pos,o.pos,q.radius+(o.boundingRadius or 0))then return false end
   end
   return true
  end
  for _,m in ipairs(rows)do if #candidates>=8 then break end
   if f.distance(H.pos,m.pos)<=range and first(m,rows)then candidates[#candidates+1]={unit=m,count=Hooks.explosionCount(f,m.pos,rows)}end
  end
  table.sort(candidates,function(a,b)return a.count>b.count end)
  if not f.quinnLaneSpec then local spec={};for k,v in pairs(q)do spec[k]=v end;spec.collision=false;spec.range=range;f.quinnLaneSpec=spec end
  for i=1,math.min(#candidates,3)do local c=candidates[i]
   if c.count<need then break end
   local m=c.unit
   if f:Cast(0,m,context,{world=true,spec=f.quinnLaneSpec,check=function()return flightClear(f,m)end,
    permission=function()return enough(m)and first(m,f:Rows('lane',1300))end})then return true end
  end
  return false
 end
 function Hooks.farm(f,u,rows,mode,context,last)
  if last then
   if #rows~=1 or not f:Permission(mode,0)or not f:Rescue(u,0)then return false end
   return Hooks.castQ(f,u,context,function()return f:Permission(mode,0)and #f:Rows('lane',1100)==1 and f:Rescue(u,0)end)
  end
  if mode=='LaneClear'then return f:Permission(mode,0)and Hooks.laneQ(f,rows,mode,context)or false end
  if f:Permission(mode,0)and Hooks.castQ(f,u,context,permission(f,mode,0))then return true end
  return mode=='JungleClear'and f:Permission(mode,2)and Hooks.castE(f,u,context,permission(f,mode,2),false)or false
 end
 -- W passive: an attack on a marked unit gives +20-40% move speed for 2 s. In
 -- Flee, attack a marked unit in range when the windup is short and nothing can
 -- reach Quinn before it ends (Quinn-5). Normal only: the Classic trigger is
 -- not established; 'quinn_w_speed' traces record the gain.
 function Hooks.speedTarget(f)
  if f.profile.id~='normal'or Hooks.flight(f)or(H:GetSpellData(1).level or 0)<1 then return end
  local windup=H.attackData and H.attackData.windUpTime
  if not finite(windup)or windup<=0 or windup>=.3 then return end
  if C:AllyThreat(H,windup+.1,{dashes=true,melee=true})then return end
  for _,kind in ipairs({'hero','lane','jungle'})do
   for _,u in ipairs(f:Rows(kind,1000))do if f:AttackReach(u)and Hooks.mark(f,u)then return u,windup end end
  end
 end
 function Hooks.speedAttack(f,context)
  local u,windup=Hooks.speedTarget(f);if not u then return false end
  local identity,handle,previous=id(u),u.handle,f.attack;local speed=H.ms
  return C:Attack(u,{owner='QuinnFleeSpeed',context=context,priority='interactive',ttl=150,
   validate=function()return id(u)==identity and u.handle==handle and Hooks.speedTarget(f)~=nil and Hooks.mark(f,u)~=nil and f:AttackReach(u)end,
   observe=function(q)local witness=C:AttackWitness(previous,u)
    if witness and witness~=previous and finite(witness.startTime)and finite(q.sentGameTime)and witness.startTime>=q.sentGameTime then
     C:Trace('quinn_w_speed',{profile=f.profile.id,msBefore=speed,msAtWindup=H.ms,windup=windup});return true
    end
   end})==true
 end
 function Hooks.flee(f,context)
  local u=f:Target(f:Range(2));local flying=Hooks.flight(f)
  if u and not flying and f:Permission('Flee',2)and Hooks.castE(f,u,context,permission(f,'Flee',2),true)then return true end
  if f:Permission('Flee',3)and not Hooks.travel(f)and not Hooks.channelStage(f)and not C:SelfChanneling(true)
   and g.GetEnemyCount(1000,H.pos)==0 then
   return f:Cast(3,nil,context,{selfCast=true,weave=false,permission=permission(f,'Flee',3),
    check=function()return not Hooks.travel(f)and not Hooks.channelStage(f)and g.GetEnemyCount(1000,H.pos)==0 end})
  end
  if Hooks.speedAttack(f,context)then return true end
  return u and not flying and f:Permission('Flee',0)and Hooks.castQ(f,u,context,permission(f,'Flee',0))or false
 end
 Hooks.options={'Risk','Interrupt'}
 -- The abilities each mode really uses (the others get no menu entry).
 Hooks.modeSlots={Combo={'Q','W','E','R'},Harass={'Q','W','E','R'},LaneClear={'Q'},JungleClear={'Q','E'},LastHit={'Q'},Flee={'Q','E','R'}}
 Hooks.assistLabels={[0]='Cast Q at the selected target',[3]='Cast R at the selected target, or take off'}
 function Hooks.menu(f,menu)
  if f.profile.id=='classic'then
   menu.Misc:MenuElement({id='ValorDive',name='Dive enemies out of attack range in Valor form',value=false})
  end
 end
 function Hooks.assist(f,slot,u,context)
  if slot==0 then return Hooks.castQ(f,u,context)end
  if Hooks.channelStage(f)then return false end
  if Hooks.travel(f)then return Hooks.castR(f,u,context)end
  if g.GetEnemyCount(1000,H.pos)>0 then return false end
  return f:Cast(3,nil,context,{selfCast=true,weave=false,
   check=function()return g.GetEnemyCount(1000,H.pos)==0 and not Hooks.travel(f)and not Hooks.channelStage(f)end})
 end
 function Hooks.continue(f,key,s)
  if key=='vault'and s.observed then
   if H.pathing and H.pathing.isDashing and f.distance(H.pos,s.origin)>25 then s.dash=true end
   if s.dash and not(H.pathing and H.pathing.isDashing)then
    -- Development evidence for the Classic vault speeds and attack reset.
    C:Trace('quinn_e_dash',{profile=f.profile.id,valor=s.valor,seconds=G.Timer()-(s.started or G.Timer()),
     moved=f.distance(H.pos,s.origin),attackReadyIn=C:AttackReadyIn()})
    f.sequences.vault=nil
   end
  end
 end
 Hooks.previewLabel='Ring on the enemy your abilities aim at'
 -- E then one marked attack: lethal when the health at the attack's landing is
 -- below E plus that attack with Harrier (counted unless a mark is already on
 -- the target, then the attack already includes it). Combo or Harass only, where
 -- the attack preference then takes the marked target (Quinn-11).
 function Hooks.finisherDamage(f,u)
  local total=f:Damage(2,u)
  local ok,attack=pcall(SDK.Damage.GetAutoAttackDamage,SDK.Damage,H,u,true)
  if not ok or not finite(attack)then return 0 end
  total=total+attack
  if not Hooks.mark(f,u)then total=total+SDK.Damage:CalculateDamage(H,u,SDK.DAMAGE_TYPE_PHYSICAL,P.Passive(H.charName,f:Stats(),u))end
  return total
 end
 function Hooks.finisher(f)
  local mode=f:Mode();if mode~='Combo'and mode~='Harass'then return false end
  if not f:Ready(2)or Hooks.flight(f)then return false end
  local function allowed()return f.menu.Misc.KillSecure:Value()and f:Mode()==mode and finite(H.maxMana)and(H.maxMana<=0 or H.mana/H.maxMana*100>=f.menu.Misc.KSMana:Value())end
  if not allowed()then return false end
  for _,u in ipairs(f:Rows('hero',f:Range(2)))do if f:Allowed(u)then
   local function lethal()
    if not allowed()or not f:Current(u)or not f:Reach(u,f:Range(2))then return false end
    local windup=H.attackData and H.attackData.windUpTime;if not finite(windup)then return false end
    local impact=f.distance(H.pos,u.pos)/((f.profile.eSpeeds or {})[1]or 2500)+windup
    return C:Lethal(u,impact,function()return Hooks.finisherDamage(f,u)end,{kind='physical',attack=true})==true
   end
   if lethal()and Hooks.castE(f,u,f:Context(mode),lethal,false,false,true)then return true end
  end end
  return false
 end
 -- Evade may vault (Quinn-12): Normal E dashes 2500 to the target, then 850 back
 -- to 525 from it. Both the contact point and the final landing are declared.
 -- Classic vault speeds are not established: no offer ('quinn_e_dash' traces).
 function Hooks.evadeLandings(f,u)
  local to=f.point(u.pos);local d=to and f.distance(H.pos,to)
  if not d or d<1 then return {}end
  local gap=(u.boundingRadius or 0)+(H.boundingRadius or 0)
  local contact=f.point({x=to.x+(H.pos.x-to.x)/d*math.min(gap,d),y=to.y,z=to.z+(H.pos.z-to.z)/d*math.min(gap,d)})
  return {contact,f.point(Hooks.landing(f,u))}
 end
 function Hooks.evadeAllowed(f,u)
  if Hooks.flight(f)or Hooks.valor(f)or f.sequences.vault or H.pathing and H.pathing.isDashing then return false,'not_on_foot'end
  if not u then return true end
  if not f:Reach(u,f:Range(2))or not f:Allowed(u)then return false,'target_invalid'end
  for _,p in ipairs(Hooks.evadeLandings(f,u))do if not f:Safe(p,false)then return false,'landing_unsafe'end end
  return true
 end
 function Hooks.evadeTargets(f)
  local out,count={},0
  for _,kind in ipairs({'lane','jungle','hero'})do for _,u in ipairs(f:Rows(kind,f:Range(2)))do
   count=count+1;if count>16 or #out>=8 then return out end
   if Hooks.evadeAllowed(f,u)then out[#out+1]={unit=u,id=id(u),position=f.point(u.pos),landings=Hooks.evadeLandings(f,u),free=false,kind=kind}end
  end end
  return out
 end
 function Hooks.initialize(f)
  f.tracked={}
  -- Ranges of ready abilities (shared rule) and a ring on the target the prepared
  -- preview chose (Quinn-13), drawn at its live position while it lives and is seen.
  local base=f.Draw
  f.Draw=function(self)
   base(self);if H.dead then return end
   local p=self.preview;local u=p and p.expires>G.Timer()and p.unit
   if self.menu.Draw.Preview:Value()and u and not u.dead and u.visible~=false and id(u)==p.target and f.point(u.pos)then
    g.Draw.Circle(u.pos,90,2,g.Draw.Color(220,255,120,80))
   end
  end
  if f.profile.id=='normal'then
   local e=f.profile.e
   f.mobilityOffered,f.mobilityReason=C:RegisterMobility({kind='unitDash',slot=2,key=g.HK_E,name=f.profile.names[3][1],range=e.range,speeds=f.profile.eSpeeds,castDelays={0},
    profile=f.profile.id,label='Dodge with E (vault)',source='wiki Quinn 2026-10-10 (dash 2500 then 850, lands 525 away); 26.20 QuinnE castRange 600',
    targets=function()return Hooks.evadeTargets(f)end,allowed=function(u)return Hooks.evadeAllowed(f,u)end})
  else f.mobilityOffered,f.mobilityReason=false,'classic_vault_speeds_unknown'end
 end

 Hooks.secureSlots={0,2,3}
 function Hooks.secureDamage(f,slot,u)if slot==3 and not Hooks.travel(f)then return 0 end;return f:Damage(slot,u)end
 -- Dashes onto Quinn, then a melee champion winding up an attack or a targeted
 -- cast on her within 300 (Quinn-4): vault away. Never in Valor form (Classic
 -- Valor E dashes in) and not in flight outside Combo.
 function Hooks.meleePeel(f)
  if Hooks.valor(f)or not f.menu.Misc.Gapclose:Value()then return false end
  local mode=f:Mode();local fighting=mode=='Combo'or mode=='Harass'
  if fighting and not f:Permission(mode,2)then return false end
  local threat=C:AllyThreat(H,.5,{turrets=false,skillshots=false})
  local u=threat and threat.source
  if not u or u.type~=g.Obj_AI_Hero or(threat.kind~='attack'and threat.kind~='cast')or not finite(u.range)or u.range>=300
   or not f:Reach(u,300+(u.boundingRadius or 65))or not f:Allowed(u)then return false end
  local function allowed()return f.menu.Misc.Gapclose:Value()and(not fighting or f:Permission(mode,2))and threat.valid()end
  local context=fighting and f:Context(mode,function()return f.menu.Misc.Gapclose:Value()end)
   or {priority='interactive',condition=function()return f.menu.Misc.Gapclose:Value()end}
  return Hooks.castE(f,u,context,allowed,true)
 end
 function Hooks.gapclose(f)return f:Gapclose(Hooks.castE)or Hooks.meleePeel(f)end
 function Hooks.secureCast(f,slot,u,context,lethal)return slot==0 and Hooks.castQ(f,u,context,lethal)or slot==2 and Hooks.castE(f,u,context,lethal,false,false,true)or slot==3 and Hooks.castR(f,u,context,lethal)end
 function Hooks.secure(f)return f:KillSecure()or Hooks.finisher(f)end
 return Hooks
end)(_G,Core,CombatMechanics)
-- 26.20 independent Normal/Classic controller, assembled through the shared core.
local QuinnChampion=class("QuinnChampion")
function QuinnChampion:__init()self.engine=Core:CreateGameplay(self,GameplayHooks);Menu=self.engine.menu end
function QuinnChampion:Tick()return self.engine:Tick()end
function QuinnChampion:Combo()return self.engine:Combat('Combo')end
function QuinnChampion:Harass()return self.engine:Combat('Harass')end
function QuinnChampion:LaneClear()return self.engine:Farm('lane','LaneClear',false)end
function QuinnChampion:JungleClear()return self.engine:Farm('jungle','JungleClear',false)end
function QuinnChampion:LastHit()return self.engine:Farm('lane','LastHit',true)end
function QuinnChampion:Flee()return self.engine:Flee()end
function QuinnChampion:Draw()return self.engine:Draw()end
function QuinnChampion:Ready(slot)return self.engine:Ready(slot)end
function QuinnChampion:GetQDmg(u)return self.engine:Damage(0,u)end
function QuinnChampion:GetWDmg(u)return self.engine:Damage(1,u)end
function QuinnChampion:GetEDmg(u)return self.engine:Damage(2,u)end
function QuinnChampion:GetRDmg(u)return self.engine:Damage(3,u)end
function QuinnChampion:RegisterGuide(guide)return self.engine:RegisterGuide(guide)end
function QuinnChampion:FeatureStatus()return {profile=self.profile.id,patch=CombatMechanics.patch,liveVerified=false,
 evadeE={supported=self.engine.mobilityOffered==true,reason=self.engine.mobilityReason,liveVerified=false}}end
local modes={};for _,mode in ipairs({'Combo','Harass','LaneClear','JungleClear','LastHit','Flee'})do local name=mode;modes[name]=function()return Core:ModeContext(name)end end
Core:RegisterPolicy({methods=modes,channel=function()return not Core:SelfChanneling(true)end,validate=function(self,q,slot)return type(slot)~='number'or slot<0 or slot>3 or self:Ready(slot)end})
QuinnChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Quinn"]="Quinn"}
local normalSupported={["Quinn"]=true}

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
