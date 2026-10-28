return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Nasus"]=function()return _G.OrbamaFamily:Require("8a712de7c838ff16f6802cccdfc09d677f514841751d55d12c616d0b1885d386")()end
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
if champion=="Nasus" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Nasus',profiles={normal=true,classic=true},
 Create=function(context)
-- Independently implemented from the family contracts and extracted assets.
-- Profile data are installed-asset candidates; live acceptance remains separate.
local profiles=ChampionProfiles('Nasus')
local finite,identity,manaAbove,buffExpiry=Core.finite,Core.id,Core.manaAbove,Core.buffExpiry
local NasusChampion=class("NasusChampion")

function NasusChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self:LoadMenu()
 -- Radius 380 is a deliberate prediction inset; the area itself is profile.eRadius (400).
 -- The initial hit lands eBurstDelay after the cast (both wiki pages): prediction and the E kill rule
 -- aim at that moment, not at the end of the cast.
 self.ESpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=self.profile.eDelay+self.profile.eBurstDelay,Radius=380,Range=650,Speed=math.huge,Collision=false}
 Callback.Add('Tick',function()self:Tick()end)
 Callback.Add('Draw',function()self:Draw()end)
  _G.SDK.Orbwalker:OnPreAttack(function(args)self:OnPreAttack(args)end)
  _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
  Core:RegisterCleanup('Nasus',function(reason)self:ClearFarm(reason);Core:ReleaseAttackPreference('StackFarm')end)
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
 self:OfferDefense()
end
-- Fury of the Sands to Evade as bonus health (S6 heal, bonus=true) for its duration. Profile numbers with
-- their source; the R switch is the consent.
function NasusChampion:OfferDefense()
 local p=self.profile
 if not Core.RegisterEffect or not p.rHealth or not finite(p.rCast)or not finite(p.rDuration)then return end
 self.defenseOffered,self.defenseReason,self.defenseAdapter=Core:RegisterEffect({kind='heal',bonus=true,name=p.r,slot=_R,key=HK_R,
  profile=p.id,spell=p.r,ultimate=true,delay=p.rCast,duration=p.rDuration,source='CombatProfiles/ChampionProfiles/Nasus.lua rHealth/rCast/rDuration: '..p.rSource,
  amount=function()return p.rHealth[myHero:GetSpellData(_R).level]end,
  ready=function()return Menu.Combo.R:Value()and not self:Buff(myHero,p.r)end})
end
-- Health-bar damage (S9): a ready Q attack (or one plain attack) plus the initial E hit when ready.
function NasusChampion:ComboDamage(u)
 if not IsValid(u)then return 0 end
 local total=self:QReady()and self:GetQDmg(u)or _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)
 if IsReady(_E)then total=total+self:GetEDmg(u)end
 return total
end
function NasusChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Nasus'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5,menu=mode=='Harass'})
 end
 Menu.Combo:MenuElement({id='R',name='R when low near an enemy, also outside modes',value=true})
 Menu.Combo:MenuElement({id='RHP',name='Use R below health %',value=35,min=1,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,
  callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 Menu.Clear:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 Menu.Clear:MenuElement({id='LaneQ',name='Lane: last hit with Q for stacks',value=true})
 Menu.Clear:MenuElement({id='JungleQ',name='Jungle: use Q',value=true})
 Menu.Clear:MenuElement({id='LaneE',name='Lane: use E on groups its first hit will not kill',value=true})
 Menu.Clear:MenuElement({id='ECount',name='Lane minions E must hit',value=3,min=1,max=8,step=1})
 Menu.Clear:MenuElement({id='JungleE',name='Jungle: use E',value=true})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='Q',name='Last hit with Q for stacks',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=10,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
  Menu.Misc:MenuElement({id='AutoQ',name='Last hit with Q without holding a mode key',value=false})
  Menu.Misc:MenuElement({id='AutoQMana',name='Automatic Q last hits only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='E',name='E range while E is ready',value=false})
 Menu.Draw:MenuElement({id='W',name='W range while W is ready',value=false})
 Menu.Draw:MenuElement({id='Stacks',name='Mark the minion Q will last hit',value=true})
end
-- Fresh native read on every call, as Core:Fresh(GetBuffs) was, but the name is
-- tested before copying a buff's fields. The full copy read ~16 native fields
-- for every positive buff on myHero (live Nasus farming: ~0.8 ms per call).
-- Same order, count>0 filter, buffCount guard and plain-table result.
local function freshBuffs(unit,name)
 local count=unit.buffCount
 if not finite(count)or count<0 or count>128 or count%1~=0 then return function()end end
 local i=-1
 return function()
  while i<count do
   i=i+1
   local b=unit:GetBuff(i)
   if b and b.name==name and b.count and b.count>0 then
    local source=b.source
    if type(source)=='table'or type(source)=='userdata'then source={networkID=source.networkID,handle=source.handle}end
    return {name=b.name,type=b.type,count=b.count,stacks=b.stacks,duration=b.duration,
     expireTime=b.expireTime,endTime=b.endTime,startTime=b.startTime,source=source,
     sourcenID=b.sourcenID,sourceName=b.sourceName,sourceID=b.sourceID,owner=b.owner,ownerID=b.ownerID}
   end
  end
 end
end
function NasusChampion:Buff(unit,name)
 if not unit or not finite(unit.buffCount)or unit.buffCount>128 then return nil end
 local function ours(id)return not id or id==0 or id==myHero.networkID or id==myHero.handle end
 for b in freshBuffs(unit,name)do
  local expiry=buffExpiry(b)
  local source=b.source;local owned=ours(b.sourcenID)
  if type(source)=='table'or type(source)=='userdata'then
   owned=owned and ours(source.networkID)and ours(source.handle)
  elseif type(source)=='number'then owned=owned and ours(source)end
  if b.name==name and (b.count or 0)>0 and (not expiry or expiry==0 or expiry>Game.Timer())
   and owned
   and (not b.sourceName or b.sourceName==''or b.sourceName==myHero.charName)then return b end
 end
end
function NasusChampion:QActive()return self:Buff(myHero,self.profile.qBuff)~=nil end
function NasusChampion:QReady()
 if not IsReady(_Q)or self:QActive()then return false end
 local name=myHero:GetSpellData(_Q).name
 for _,alias in ipairs(self.profile.q)do if name==alias then return true end end
 return false
end
function NasusChampion:Stacks()
 local result=Core:DecisionValue('Nasus:stacks',function()
 local b=self:Buff(myHero,self.profile.stacks)
 if not b then return {0,'lower_bound'} end
 -- The historical GoS families explicitly read stacks. count is presence;
 -- do not take its maximum with an unrelated native field. Unverified fields
 -- contribute zero, so unknown bonus damage never authorizes a last hit.
 if not finite(b.stacks)or b.stacks<0 or b.stacks%1~=0 or b.stacks>1000000 then return {0,'lower_bound'}end
 return {b.stacks,'native_stacks_candidate'}
 end)
 return result[1],result[2]
end
function NasusChampion:GetQDmg(target)
 local rank=myHero:GetSpellData(_Q).level
 if not self.profile.qBase[rank]or not IsValid(target)then return 0 end
 local stacks=self:Stacks()
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,
  myHero.totalDamage+self.profile.qBase[rank]+stacks)
end
local function inQReach(self,target)
 return IsValid(target)and GetDistance(target.pos,myHero.pos)<=myHero.range+myHero.boundingRadius
  +(target.boundingRadius or 0)+self.profile.qRangeBonus
end
function NasusChampion:InQReach(target)return inQReach(self,target)end
-- The last own basic attack that was seen to land (shared witness) hit this unit a moment ago.
function NasusChampion:JustAttacked(target)
 local a=self.attack
 return a~=nil and target~=nil and a.object==target and Game.Timer()-a.at>=0 and Game.Timer()-a.at<=.35
end
-- The stack needs the kill, not the first hit: attacks already in flight count (shared kill rule, exact figures).
-- prep.blade(unit) adds the Spellblade bonus the Q cast primes (Sheen family, C:SpellbladeBonus, mitigated).
local function qKills(target,prep,opts)
 return prep.raw~=nil and(Core:Lethal(target,prep.horizon,function()
  return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,prep.raw)
   +(prep.blade and prep.blade(target)or 0)end,opts))
end
local exact={margin=1,flat=0}
-- An empowered attack is not stopped by a spell shield; invulnerability is ruled out by the caller.
local champion={kind='physical',protection=false}
-- Wards give stacks. One melee hit's damage on a ward is unmeasured: only a ward the next hit surely
-- kills (profile wardKillHealth) is a candidate, after every minion.
local function isWard(u)return u.type==Obj_AI_Minion and finite(u.maxHealth)and u.maxHealth<=6 end
-- Invariant inputs of one farm evaluation: impact horizon, Q rank and stacks.
-- Each candidate still reads its own fresh position, team, health forecast and
-- armor (CalculateDamage). Returns nil when the horizon is unknown. With a plan,
-- the Spellblade bonus taken at planning is kept until Q is observed; after that
-- it counts only while the bonus is primed (the shared service then reports 0).
local function farmPrep(self,plan)
 local windup=_G.SDK.Attack:GetWindup()
 if not finite(windup)or windup<0 then return nil end
 local base=self.profile.qBase[myHero:GetSpellData(_Q).level]
 local prep={horizon=windup+.15,raw=base and myHero.totalDamage+base+self:Stacks()}
 if plan then
  local b=plan.blade
  if b and b>0 and(not plan.observed or Core:SpellbladeBonus(plan.target)==0)then prep.blade=function(u)return u==plan.target and b or 0 end end
 elseif Core:SpellbladeBonus()>0 then prep.blade=function(u)return Core:SpellbladeBonus(u)end end
 return prep
end
local function wardUseful(self,target)
 return IsValid(target)and inQReach(self,target)and target.team~=myHero.team and target.team~=300
  and finite(target.health)and target.health>0 and target.health<=self.profile.wardKillHealth
end
local function farmUseful(self,target,jungle,prep)
  if not inQReach(self,target)or target.type~=Obj_AI_Minion or target.team==myHero.team or (target.team==300)~=jungle then return false end
 if not jungle and isWard(target)then return wardUseful(self,target)end
 prep=prep or farmPrep(self);if not prep then return false end
 -- Bound the plan, use incoming attacks at impact, and refresh after Q is observed.
 if jungle then local hp=Core:UnshieldedLegacyForecast(target,prep.horizon);return finite(hp)and hp>0 end
 return qKills(target,prep,exact)
end
function NasusChampion:FarmUseful(target,jungle)return farmUseful(self,target,jungle)end
function NasusChampion:PlanUseful(target,kind,prep)
 if kind~='kill'then return farmUseful(self,target,kind=='jungle',prep)end
 if not IsValid(target)or target.type~=Obj_AI_Hero or target.team==myHero.team or IsInvulnerable(target)or not inQReach(self,target)then return false end
 prep=prep or farmPrep(self)
 return prep~=nil and qKills(target,prep,champion)
end
-- An enemy champion close enough that a trade would want the Q reset (Q reach plus 150).
function NasusChampion:ChampionNear()
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,5)do local u=list[i]
  if IsValid(u)and u.team~=myHero.team and GetDistance(u.pos,myHero.pos)<=myHero.range+myHero.boundingRadius
   +(u.boundingRadius or 0)+self.profile.qRangeBonus+150 then return true end
 end
 return false
end
function NasusChampion:FarmPermission(kind)
  if kind=='auto'then local mode=GetMode()
   return mode~='Combo'and mode~='Harass'and mode~='Flee'and Menu.Misc.AutoQ:Value()and manaAbove(Menu.Misc.AutoQMana:Value())
  end
  if kind=='kill'then return true end
 if kind=='last' then return GetMode()=='LastHit'and Menu.LastHit.Q:Value()and manaAbove(Menu.LastHit.Mana:Value())end
 -- Harass takes stack last hits while no champion trade needs the Q.
 if kind=='harass'then return GetMode()=='Harass'and Menu.LastHit.Q:Value()and Menu.Clear.SpellFarm:Value()
  and manaAbove(Menu.Harass.Mana:Value())and not self:ChampionNear()end
 return Core:FarmModeEnabled(kind)and Menu.Clear.SpellFarm:Value()and manaAbove(Menu.Clear.Mana:Value())
  and (kind=='jungle'and Menu.Clear.JungleQ:Value()or kind=='lane'and Menu.Clear.LaneQ:Value())
end
-- The best stack recipient among `units`: the largest killable minion (cannon first), then a sure-kill ward.
local function stackPick(units,limit,useful)
 local best,ward
 for i=1,math.min(#units,limit)do local u=units[i]
  if IsValid(u)and useful(u)then
   if isWard(u)then ward=ward or u elseif not best or u.maxHealth>best.maxHealth then best=u end
  end
 end
 return best or ward
end
local function enemyWards()
 local cached=_G.SDK.Cached
 return cached and type(cached.GetWards)=='function'and cached:GetWards()or {}
end
function NasusChampion:StartFarm(kind)
  if self.farmPlan or Core.adapter:ResourceAction(Core.adapter:SlotResource(_Q),false)or not self:FarmPermission(kind)
  or not Core:DecisionValue('Nasus:qready',function()return self:QReady()end)then return false end
 local jungle=kind=='jungle'
 local prep=farmPrep(self);if not prep then return false end
  local units=kind=='kill'and Core:DecisionUnits('GetEnemyHeroes')or jungle and Core:DecisionUnits('GetMonsters')or Core:DecisionUnits('GetEnemyMinions')
  local best
  -- Jungle: Q is an attack reset. It follows an attack that just landed (one more hit per cooldown) or takes
  -- the monster it kills (stacks). With no witnessed attack for a while it arms first, as it always did.
  local stale=jungle and not(self.attack and Game.Timer()-self.attack.at<2.5)
  if kind=='kill'then
   local candidates={}
   for i=1,math.min(#units,16)do local u=units[i];if self:PlanUseful(u,kind,prep)then candidates[#candidates+1]=u end end
   best=_G.SDK.TargetSelector:GetTarget(candidates,_G.SDK.DAMAGE_TYPE_PHYSICAL)
  else
   best=stackPick(units,jungle and 12 or 40,function(u)
    return self:PlanUseful(u,kind,prep)and(not jungle or stale or self:JustAttacked(u)or qKills(u,prep,exact))end)
   if not best and not jungle then best=stackPick(enemyWards(),16,function(u)return isWard(u)and wardUseful(self,u)end)end
  end
  if not best then return false end
  local context=(kind=='auto'or kind=='kill')and {priority=kind=='kill'and 'interactive'or 'background',condition=function()return self:FarmPermission(kind)end}
   or kind=='last'and Core:ModeContext('LastHit')or kind=='harass'and Core:ModeContext('Harass')or Core:FarmContext(kind)
  -- The observed Normal sequence can take 1.3 seconds. This original fixed
  -- gameplay deadline allows that continuation without holding input or renewal.
  -- A lane last hit is time-critical: it goes out ahead of background farming.
  local plan={target=best,id=identity(best),handle=best.handle,kind=kind,context=context,expires=Game.Timer()+1.5,
   priority=(kind=='last'or kind=='lane'or kind=='harass')and 'normal'or nil,ward=isWard(best)or nil,
   blade=prep.blade and prep.blade(best)or 0}
  local ok=Core:Cast(HK_Q,nil,{owner='StackFarm',intentTarget=best,context=context,priority=plan.priority,independent=false,
   validate=function()return identity(best)==plan.id and best.handle==plan.handle and self:FarmPermission(kind)
    and self:QReady()and self:PlanUseful(best,kind,farmPrep(self,plan))end})
 if not ok then return false end
 plan.action=Core.lastIntent.id;self.farmPlan=plan;self.view={target=best,at=Game.Timer()}
 if plan.ward then Core:Trace('nasus_ward_q',{health=best.health,maxHealth=best.maxHealth,name=best.charName})end
 Core.adapter:SetBlocked('stack_farm','attack',true)
 Core:AfterCast(HK_Q,function()if self.farmPlan==plan then plan.observed=true end end)
 return true
end
function NasusChampion:ClearFarm(reason)
 local p=self.farmPlan
 if p and p.action then Core.adapter:Cancel(p.action,reason or 'farm_ended')end
 if p and p.attack then Core.adapter:Cancel(p.attack,reason or 'farm_ended')end
 if p then Core:ReleaseAttackPreference('StackFarm')end
 self.farmPlan=nil;Core.adapter:SetBlocked('stack_farm','attack',false)
end
-- The empowered attack has started on the planned recipient (fresh native cast).
function NasusChampion:QAttackStarted(p)
 local a=myHero.activeSpell
 if not a or not a.valid or a.isStopped or a.name~=self.profile.qAttack then return false end
 local id=a.target;if type(id)=='table'or type(id)=='userdata'then id=identity(id)end
 return id==nil or id==p.target.networkID or id==p.target.handle
end
-- Ends a plan whose empowered attack is on its way: nothing is cancelled (it was sent).
function NasusChampion:FinishFarm(p,now)
 Core:Trace('nasus_q_attack',{kind=p.kind,ward=p.ward,owned=p.attack~=nil,
  sendToBuff=p.sentSeen and p.buffAt and p.buffAt-p.sentSeen,buffToAttack=p.buffAt and now-p.buffAt})
 self.farmPlan=nil;Core:ReleaseAttackPreference('StackFarm');Core.adapter:SetBlocked('stack_farm','attack',false)
end
function NasusChampion:ContinueFarm()
 local p=self.farmPlan;if not p then return false end
 local now=Game.Timer()
 if p.buffAt and self:QAttackStarted(p)then self:FinishFarm(p,now);return true end
 -- Fresh check each tick at the current impact horizon (the 0.25 s refresh after the buff included).
  if now>=p.expires or identity(p.target)~=p.id or p.target.handle~=p.handle or not self:FarmPermission(p.kind)
   or not self:PlanUseful(p.target,p.kind,farmPrep(self,p))then self:ClearFarm('farm_context_changed');return false end
 local result=Core.adapter:Poll(p.action)
 if not result or result.jobCancelled or result.state=='cancelled_before_send'or result.state=='aborted'then
  self:ClearFarm('farm_input_ended');return false
 end
 if result.sentAt and not p.sentSeen then p.sentSeen=now end
 -- Observation authorizes continuation; a timer or accepted key does not. The
 -- buff was absent when the plan started (QReady), so its presence after the
 -- send is fresh native evidence even while the key attribution is ambiguous.
 if not(p.observed or result.sentAt)or not self:QActive()then return true end
 p.observed=true
 Core.adapter:SetBlocked('stack_farm','attack',false)
 -- The orbwalker's own reset attack goes to the planned minion at once (attack preference, and OnPreAttack
 -- redirects); with a mode key held it gets one tick before the owned attack below takes over.
 Core:PreferAttack('StackFarm',p.target,1)
 if not p.buffAt then
  p.buffAt=now
  local mode=GetMode()
  if mode and mode~='Flee'then return true end
 end
 if p.attack then
  if not Core.pending['__owned_attack'] then self:FinishFarm(p,now)end
  return true
 end
 if not _G.SDK.Orbwalker:CanAttack()then return true end
  local ttl=math.max(1,math.min(150,math.floor((p.expires-Game.Timer())*1000)))
  local sent=Core:Attack(p.target,{owner='StackFarm',context=p.context,priority=p.priority,ttl=ttl,
   validate=function()return self.farmPlan==p and identity(p.target)==p.id and p.target.handle==p.handle
    and self:FarmPermission(p.kind)and self:QActive()and self:PlanUseful(p.target,p.kind,farmPrep(self,p))end,
  observe=function(q)
   local a=Core:NativeAttack(q,self.profile.qAttack)
   local id=a and a.target;if type(id)=='table'or type(id)=='userdata'then id=identity(id)end
   return a and a.valid and not a.isStopped and a.name==self.profile.qAttack
    and (id==p.target.networkID or id==p.target.handle)
  end})
 if sent then p.attack=Core.lastIntent.id end
 return true
end
-- An armed Q without a plan (an expired plan, a manual Q): its hit goes to the largest minion it kills,
-- else a sure-kill ward. In Combo and Harass a champion in reach keeps the hit.
function NasusChampion:SteerArmedQ()
 if self.farmPlan then return false end
 local mode=GetMode()
 if not mode or mode=='Flee'or not self:QActive()or(mode=='Combo'or mode=='Harass')and self:ChampionNear()then
  Core:ReleaseAttackPreference('StackFarm');return false
 end
 local prep=farmPrep(self);if not prep then return false end
 local function useful(u)
  if u.team==myHero.team or u.team==300 or _G.SDK.Data:IsInAutoAttackRange(myHero,u)~=true then return false end
  if isWard(u)then return wardUseful(self,u)end
  return u.type==Obj_AI_Minion and qKills(u,prep,exact)
 end
 local best=stackPick(Core:DecisionUnits('GetEnemyMinions'),40,useful)
 if not best then best=stackPick(enemyWards(),16,function(u)return isWard(u)and useful(u)end)end
 if not best then Core:ReleaseAttackPreference('StackFarm');return false end
 self.view={target=best,at=Game.Timer()}
 return Core:PreferAttack('StackFarm',best,.5)
end
function NasusChampion:OnPreAttack(args)
 if not args or args.Process==false then return end
 local p=self.farmPlan
 if p then
  if p.observed and args.Target~=p.target and identity(p.target)==p.id and IsValid(p.target)
   and _G.SDK.Data:IsInAutoAttackRange(myHero,p.target)and self:QActive()then args.Target=p.target end
  return
 end
 -- Q resets the attack timer, so it is armed after an attack lands (OnPostAttack). Before the attack it is
 -- armed only for a target that is leaving: the one hit it gets is then the empowered one.
 local target=args.Target
 if not Core.pending[HK_Q]and self:CombatQ(target)and self:Leaving(target)then
  Core:Cast(HK_Q,nil,{intentTarget=target,validate=function()return self:QReady()and self:InQReach(target)end})
 end
end
-- A champion walking out of reach at least as fast as Nasus and not withered: there will be no second hit.
function NasusChampion:Leaving(target)
 local p=target and target.pathing;local goal=p and p.hasMovePath and(p.endPos or target.posTo)
 return goal and finite(goal.x)and finite(goal.z)and GetDistance(goal,myHero.pos)>GetDistance(target.pos,myHero.pos)+50
  and finite(target.ms)and finite(myHero.ms)and target.ms>=myHero.ms and not self:Buff(target,self.profile.w)or false
end
function NasusChampion:CombatQ(target)
 local mode=GetMode();local settings=mode=='Combo'and Menu.Combo or mode=='Harass'and Menu.Harass
 return settings and target and target.type==Obj_AI_Hero and settings.Q:Value()and manaAbove(settings.Mana:Value())and self:QReady()
  and inQReach(self,target)and mode or nil
end
function NasusChampion:OnPostAttack(args)
 if not Core:InputAvailable()or ShouldWait()then return end
 local a=Core:AttackWitness(self.attack,args and args.Target);if not a or a==self.attack or a.at>Game.Timer()then return end
 self.attack=a;local target=a.object
 if self.farmPlan or Core.pending[HK_Q]or not target then return end
 local mode=self:CombatQ(target)
 if mode then
  return Core:Cast(HK_Q,nil,{owner='ResetQ',intentTarget=target,context=Core:ModeContext(mode),
   validate=function()return self.attack==a and self:JustAttacked(target)and self:CombatQ(target)==mode end})
 end
 if target.team==300 and target.type==Obj_AI_Minion then return self:StartFarm('jungle')end
 -- Siphoning Strike also hits structures. After an attack on one lands, Q is the reset there, but only
 -- while no enemy minion is near: with a wave at the turret the cooldown belongs to the next stack.
 if self:StructureQ(target)then
  return Core:Cast(HK_Q,nil,{owner='ResetQ',intentTarget=target,context=Core:FarmContext('lane'),
   validate=function()return self.attack==a and self:JustAttacked(target)and self:StructureQ(target)end})
 end
end
function NasusChampion:StructureQ(target)
 if not IsValid(target)or target.team==myHero.team or not(target.type==Obj_AI_Turret or Obj_AI_Barracks~=nil and target.type==Obj_AI_Barracks
  or Obj_AI_Nexus~=nil and target.type==Obj_AI_Nexus)or not self:FarmPermission('lane')or not self:QReady()then return false end
 local list=_G.SDK.ObjectManager:GetEnemyMinions(700)
 for i=1,math.min(#list,40)do local u=list[i]
  if IsValid(u)and u.team~=300 and u.team~=myHero.team and GetDistance(u.pos,myHero.pos)<=700 then return false end
 end
 return true
end
function NasusChampion:WitherUseful(target,flee)
 if not IsValid(target)or target.type~=Obj_AI_Hero or GetDistance(target.pos,myHero.pos)>700 then return false end
 if self:Buff(target,self.profile.w)then return false end
 if flee then return GetDistance(target.pos,myHero.pos)<=600 end
 return not _G.SDK.Data:IsInAutoAttackRange(myHero,target)or (target.attackSpeed or 0)>=myHero.attackSpeed
end
function NasusChampion:CastE(target,validate)
 if Core.pending[HK_E]or not IsValid(target)or not IsReady(_E)or myHero:GetSpellData(_E).name~=self.profile.e then return false end
 local prediction=Core:Prediction(self.ESpell);prediction:GetPrediction(target,myHero)
 if not prediction:CanHit(2)then return false end
 if not Core:Cast(HK_E,prediction.CastPosition,{intentTarget=target,prevalidateWorldCast=true,
  deferAttackWindup=true,validate=validate})then return false end
 -- Development trace: observed E cast -> first health loss of the aimed unit (settles eBurstDelay per profile).
 Core:AfterCast(HK_E,function()if IsValid(target)then self.eProbe={target=target,hp=target.health,at=Game.Timer()}end end)
 return true
end
function NasusChampion:EProbe()
 local p=self.eProbe;if not p then return end
 local now=Game.Timer()
 if now-p.at>1 or not IsValid(p.target)then self.eProbe=nil;return end
 if p.target.health<p.hp-1 then
  Core:Trace('nasus_e_first_damage',{profile=self.profile.id,delay=now-p.at,planned=self.profile.eBurstDelay});self.eProbe=nil
 end
end
function NasusChampion:GetEDmg(target)
 local base=self.profile.eBase[myHero:GetSpellData(_E).level]
 if not base or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.eAP*myHero.ap)
end
function NasusChampion:ELethal(target,aim)
 if not IsValid(target)
  or target.type~=Obj_AI_Hero or target.team==myHero.team or IsInvulnerable(target)then return false end
 local impact=OrbamaPrediction:GetImpactTime(self.ESpell,aim or target.pos,myHero)
 if not finite(impact)or impact<0 then return false end
 -- Shared kill rule: spell shields and invulnerability, shield pools and the health window (first hit only).
 return(Core:Lethal(target,impact,function()return self:GetEDmg(target)end,{kind='magical'}))
end
function NasusChampion:Finishers()
 if self:StartFarm('kill')then return true end
 if not IsReady(_E)then return false end
 local list=Core:DecisionUnits('GetEnemyHeroes');local candidates={}
 for i=1,math.min(#list,16)do local target=list[i]
  if self:ELethal(target)and GetDistance(target.pos,myHero.pos)<=self.ESpell.Range then candidates[#candidates+1]=target end
 end
 local target=_G.SDK.TargetSelector:GetTarget(candidates,_G.SDK.DAMAGE_TYPE_MAGICAL)
 if not target then return false end
 return self:CastE(target,function(q,resolved)return self:ELethal(target,resolved and resolved.position or q.target)end)
end
-- One rule and one health limit, with or without a mode key: low with an enemy in reach. In Combo the
-- transformation also opens a fight against several enemies once it has started to hurt.
-- Incoming harm decides earlier: an observed attack on Nasus counts with its damage, any other observed threat
-- (a cast, a targeted missile, a dash onto him, a skillshot Evade cannot dodge) raises the limit by 10 points.
function NasusChampion:RUseful()
 if not Menu.Combo.R:Value()or not(myHero.maxHealth>0)or self:Buff(myHero,self.profile.r)then return false end
 local hp=myHero.health/myHero.maxHealth*100
 local limit=Menu.Combo.RHP:Value()
 if GetEnemyCount(700,myHero.pos)>0 then
  if hp<=limit then return true end
  if hp<=limit+25 then
   local threat=Core:AllyThreat(myHero,.5,{dashes=true})
   if threat then
    local loss=10
    if threat.kind=='attack'and IsValid(threat.source)then
     loss=_G.SDK.Damage:CalculateDamage(threat.source,myHero,_G.SDK.DAMAGE_TYPE_PHYSICAL,threat.source.totalDamage or 0)/myHero.maxHealth*100
    end
    if finite(loss)and hp-loss<=limit then return true end
   end
  end
 end
 return GetMode()=='Combo'and hp<=75 and GetEnemyCount(600,myHero.pos)>=2
end
function NasusChampion:Combat(mode)
 local settings=Menu[mode];if not manaAbove(settings.Mana:Value())then return end
 local target=GetTarget(700);if not IsValid(target)then return end
 if settings.W:Value()and not Core.pending[HK_W]and IsReady(_W)and myHero:GetSpellData(_W).name==self.profile.w and self:WitherUseful(target,false)then
  return Core:Cast(HK_W,target,{range=700,validate=function()return self:WitherUseful(target,false)end})
 end
 if settings.E:Value()and IsReady(_E)and GetDistance(target.pos,myHero.pos)<=650 then return self:CastE(target)end
end
function NasusChampion:Combo()return self:Combat('Combo')end
function NasusChampion:Harass()return self:Combat('Harass')end
function NasusChampion:LaneClear()
 if self:StartFarm('lane')then return true end
 if not Core:FarmModeEnabled('lane')or not Menu.Clear.SpellFarm:Value()or not Menu.Clear.LaneE:Value()
  or not manaAbove(Menu.Clear.Mana:Value())or not IsReady(_E)then return end
 local list=_G.SDK.ObjectManager:GetEnemyMinions(1030)
 -- Lane E softens a group for Q. Its first hit must not kill any minion in the area (that last hit and its
 -- stacks belong to Q: the cast is skipped), and the burn that follows may bring at most one minion down:
 -- Q takes that one as it drops, a second would die to the burn unstacked. An unknown burn refuses.
 local p=self.profile;local rank=myHero:GetSpellData(_E).level;local base,tick=p.eBase[rank],p.eTick[rank]
 if not base or not tick or not finite(myHero.ap)then return end
 local first=base+p.eAP*myHero.ap;local raw=first+(tick+p.eTickAP*myHero.ap)*p.eDuration
 local function dense(anchor,live)
  local n,burned=0,0
  for j=1,math.min(#live,40)do local v=live[j]
   if IsValid(v)and v.team~=300 and v.team~=myHero.team and GetDistance(v.pos,anchor.pos)<=p.eRadius then n=n+1
    if not finite(v.health)or v.health<=_G.SDK.Damage:CalculateDamage(myHero,v,_G.SDK.DAMAGE_TYPE_MAGICAL,first)then return false end
    if v.health<=_G.SDK.Damage:CalculateDamage(myHero,v,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)then burned=burned+1;if burned>1 then return false end end
   end
  end
  return n>=Menu.Clear.ECount:Value()and n
 end
 -- The densest anchor wins (tie: the closest); one dense() evaluation per anchor.
 local best,count,distance
 for i=1,math.min(#list,40)do local u=list[i]
  if IsValid(u)and u.team~=300 and u.team~=myHero.team then
   local d=GetDistance(u.pos,myHero.pos)
   if d<=650 then
    local n=dense(u,list)
    if n and(not best or n>count or n==count and d<distance)then best,count,distance=u,n,d end
   end
  end
 end
 if best then return self:CastE(best,function()return dense(best,_G.SDK.ObjectManager:GetEnemyMinions(1030))~=false end)end
end
function NasusChampion:JungleClear()
 if self:StartFarm('jungle')then return true end
 if not Core:FarmModeEnabled('jungle')or not Menu.Clear.SpellFarm:Value()or not Menu.Clear.JungleE:Value()
  or not manaAbove(Menu.Clear.Mana:Value())or not IsReady(_E)then return end
 local list=_G.SDK.ObjectManager:GetMonsters(650);local best
 for i=1,math.min(#list,12)do local u=list[i];if IsValid(u)and (not best or u.maxHealth>best.maxHealth)then best=u end end
 if best then return self:CastE(best)end
end
function NasusChampion:LastHit()return self:StartFarm('last')end
function NasusChampion:Flee()
 if Core.pending[HK_W]or not IsReady(_W)or myHero:GetSpellData(_W).name~=self.profile.w then return end
 local target=GetTarget(600)
 if self:WitherUseful(target,true)then return Core:Cast(HK_W,target,{range=700,validate=function()return self:WitherUseful(target,true)end})end
end
-- W on an enemy dashing onto Nasus: the cripple slows its attacks and the slow stops the follow-up.
-- Any mode but Flee (Flee has its own W); consent through Combo W.
function NasusChampion:DashW(target)
 return IsValid(target)and target.type==Obj_AI_Hero and target.team~=myHero.team and Menu.Combo.W:Value()
  and manaAbove(Menu.Combo.Mana:Value())and GetMode()~='Flee'and GetDistance(target.pos,myHero.pos)<=self.profile.wRange
  and not self:Buff(target,self.profile.w)
end
function NasusChampion:AntiDash()
 if Core.pending[HK_W]or GetMode()=='Flee'or not Menu.Combo.W:Value()or not IsReady(_W)or myHero:GetSpellData(_W).name~=self.profile.w then return false end
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,5)do local u=list[i]
  if self:DashW(u)and Core:ApproachingDash(u,myHero.pos,350)then
   return Core:Cast(HK_W,u,{owner='DashW',range=self.profile.wRange,validate=function()return self:DashW(u)end})
  end
 end
 return false
end
function NasusChampion:AutoR()
 if not Core.pending[HK_R]and IsReady(_R)and self:RUseful()then
  return Core:Cast(HK_R,nil,{validate=function()return self:RUseful()end})
 end
end
function NasusChampion:Tick()
 if ShouldWait()then self:ClearFarm('unavailable');return end
 if self:ContinueFarm()then return end
 if IsCasting()then return end
  self:EProbe()
  if self:AutoR()then return end
  if self:AntiDash()then return end
  if self:Finishers()then return end
  self:SteerArmedQ()
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then if not self:StartFarm('harass')then self:Harass()end
 elseif mode=='LaneClear'then
  if Core:FarmModeEnabled('lane')then self:LaneClear()end
  if not self.farmPlan and Core:FarmModeEnabled('jungle')then self:JungleClear()end
  elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
  if not self.farmPlan then self:StartFarm('auto')end
end
function NasusChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.E:Value()and IsReady(_E)then Draw.Circle(myHero.pos,650,1,Draw.Color(255,120,200,255))end
 if Menu.Draw.W:Value()and IsReady(_W)then Draw.Circle(myHero.pos,self.profile.wRange,1,Draw.Color(255,200,160,255))end
 if not Menu.Draw.Stacks:Value()then return end
 -- Prepared values only: the last stack plan or steered hit. No stack text: the game shows the Q stacks.
 local v=self.view
 if v and Game.Timer()-v.at<=1.5 and IsValid(v.target)then Draw.Circle(v.target.pos,(v.target.boundingRadius or 40)+20,2,Draw.Color(255,255,210,60))end
end
function NasusChampion:RegisterGuide(guide,settings)
 return guide:Register('champion',{'Nasus: modes','Nasus: stack farming'},function(page)
  return {title=page==1 and 'Nasus'or 'Stack farming',cards=page==1 and {
   {'MODES','Combo and Harass use provider binds. Q follows an attack that landed, so the next attack comes at once; it is armed first only on a target walking away. W and E have separate permissions.'},
   {'CLEAR','With the spell-farm toggle on, Q last hits for stacks. Lane E is cast on three or more minions when its first hit kills none of them and its burn at most one, so the last hits stay with Q. Q also follows an attack on a turret when no minion is near. In the jungle Q follows an attack or takes the kill. Harass also takes Q last hits while no enemy champion is close.'},
   {'DEFENSE','R is used below the health limit with an enemy nearby, with or without a mode key, and in Combo against two or more enemies once the fight has started; an attack or spell about to hit lets it go out earlier. W slows an enemy dashing onto Nasus. Flee uses W.'}}or {
   {'IMPACT','Stack last hits use confirmed incoming attacks at an estimated impact. Unknown shields or forecast seeds refuse farming.'},
   {'Q THEN ATTACK','The attack follows only once Q is actually armed. A refused Q is not repeated blindly.'},
    {'NO MODE KEY','A killable enemy is always finished with Q or E. Q last hits without a mode key are an option (off by default) with their own mana limit; they pause in Combo, Harass and Flee.'},
    {'PROFILE','Normal and Classic share decisions. E armor reduction, stack awards and native spell names remain separate. Sheen-family bonus the Q cast primes is counted; other item procs and unknown stack fields are omitted.'}},
   note='Installed assets are candidate mechanics. Live timing, stack fields and reset behavior still require acceptance.'}
 end)
end
Core:StandardPolicy(NasusChampion,{damageTypes={E='magical'},exceptions={non_interrupting_summoner=true},methods={
 OnPreAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode)end,
 OnPostAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode)end,
 AutoR=function()return {priority='interactive'}end,AntiDash=function()return {priority='interactive'}end,Finishers=function()return {priority='interactive'}end},
 validate=function(self,q,slot)
  if slot==_R then return myHero:GetSpellData(_R).name==self.profile.r end
  return true
 end})
NasusChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Nasus"]="Nasus"}
local normalSupported={["Nasus"]=true}

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
