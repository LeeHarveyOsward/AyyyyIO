return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Kassadin"]=function()return _G.OrbamaFamily:Require("a65a0f597fe6906d121d8338f433838934f016e85e316bdcfd549ac9f320b69b")()end
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
modules.observeAttack=(function(require) return _G.OrbamaFamily:Factory("3da377a20f2c2a192efc8343b23fb571f5cda62e822551b4678aab011deb2b69")(require) end)(require)
modules.recallCast=(function(require) return _G.OrbamaFamily:Factory("3c7cec6192229bd783dbb481829105edbbe5cfcc52fbeae7408eed05670af826")(require) end)(require)
modules.skillOrders=(function(require) return _G.OrbamaFamily:Factory("c960de90c594e7c207e7efeaca5198f2250fe65b01459ca5f3ac5dfb7747935f")(require) end)(require)
modules.healthWindow=(function(require) return _G.OrbamaFamily:Factory("d533b0ef74c68b495c1d2541cc3e687ebd5a9d43ecc9bd9706750c9b1a16fec9")(require) end)(require)
modules.yunaraProfile=(function(require) return _G.OrbamaFamily:Factory("d0f8a7ede995c1c4ae39ff50186c21819723104154d9a4a209da8a785993462e")(require) end)(require)
modules.nautilusProfile=(function(require) return _G.OrbamaFamily:Factory("f730083274ce090a6b9cdaf348846a2fa53f89ad6c57c53a6c09767f82770c84")(require) end)(require)
modules["autojungle"]=_G.OrbamaFamily:Require("8ef13010a581d447046b67d863880d3e389ac7fec6a8557c660db9c87981114d")
modules["combatMechanics"]=_G.OrbamaFamily:Require("ba52643cc532b91600830ad315958c7c83c7fb8f12edb7d0a0462abb16309ea7")
modules["gameplay"]=_G.OrbamaFamily:Require("150735cd6058eefcd206afc8513dde960e1a1f0823bdfd223db9491c39a2f4d8")
modules["strike"]=_G.OrbamaFamily:Require("38babe42b81881ea627d41ae65e32a203fdca56374f733a79b4c7f0c9465a693")
modules["prediction"]=(function(require) return _G.OrbamaFamily:Factory("223a065ecf7929552d5f8dafcf2453fd9147cd6e9940ce97dc80add73aa9913b")(require) end)(require)
modules["policies"]=(function(require) return _G.OrbamaFamily:Factory("e26056d70e5dac93ebb21f4ae4fe96863a06915a942bb75b795567a932448a23")(require) end)(require)
modules["core"]=(function(require) return _G.OrbamaFamily:Factory("f7d98e88d54ea77cb1c1c4aa026b699688271ff1aa4f6e769036de5dccf63c4f")(require) end)(require)
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
    return _G.SDK.IsRecalling(unit,Core.validating==true)
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
if champion=="Kassadin" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Kassadin',profiles={normal=true,classic=true},
 Create=function(context)
-- Shared decisions, separate installed-asset profiles. Live acceptance is open.
local profiles=ChampionProfiles('Kassadin')
local finite,identity,point,manaAbove,buffExpiry=Core.finite,Core.id,Core.point,Core.manaAbove,Core.buffExpiry
local KassadinChampion=class("KassadinChampion")
function KassadinChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self:LoadMenu()
 -- The legacy provider adds empowered W damage from a cooldown status alone;
 -- CS rescue weighs the guaranteed attack components instead.
 self.rescue={attack='ready',attackDamage=function(u)return self:BaseAttackDamage(u)end}
 self.ESpell={Type=OrbamaPrediction.SPELLTYPE_CONE,Delay=.25,Radius=0,Range=600,Speed=math.huge,Collision=false}
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
  _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
  Core:RegisterCleanup('Kassadin',function(reason)
   self:ClearBlink(reason or 'controller_closed');self.attack=nil;self.rWitness=nil;self.preview=nil;self.assistUsed=nil;self.fleeUsed=nil;self.wFarm=nil
   self.wKill=nil;self.burst=nil;self.fleeObserved=nil;self.qProbe=nil
  end)
  self:RegisterEvade()
  Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
end
local magical={kind='magical'}
-- Evade judges the danger; the champion only says what the kit can do and keeps its own limits.
function KassadinChampion:RegisterEvade()
 local p=self.profile
 -- Riftwalk is a blink: declared as one (no travel, it may land short of full range). The stack limit and the mana
 -- rule bound it like every other R.
 if p.rCast and Core.RegisterMobility then
  self.mobilityOffered=Core:RegisterMobility({kind='dash',slot=_R,key=HK_R,name=p.r,range=p.rRange,blink=true,toPoint=true,castDelays={p.rCast},
   profile=p.id,label='Riftwalk',source=p.rSource,
   allowed=function(pos)return not self.blink and self:RBudget(false)and(pos==nil or self:SafeEndpoint(pos))end})
 end
 -- Normal Q grants a magic-damage shield when its cast completes. It needs an enemy unit in range to be cast at all.
 if p.qShield and Core.RegisterDefense then
  local spell={Delay=p.qCast}
  local function amount()local base=p.qShield[myHero:GetSpellData(_Q).level];return base and finite(myHero.ap)and base+p.qShieldAP*math.max(0,myHero.ap)or 0 end
  local function ready()
   local evade=_G.SDK.Evade;local caps=evade and evade.GetCapabilities and evade:GetCapabilities()
   local q=Core.pending[HK_Q]
   return Core:Available()and caps and caps.timedShields==true and self:Ready(_Q)and not(q and q.sentAt)and self:ShieldRecipient()~=nil
  end
  self.shieldDefense={validated=true,source=p.qShieldSource,
   options=function(ctx)
    if not ready()or not finite(ctx.now)then return {}end
    local launch,value=OrbamaPrediction:GetLaunchDelay(spell),amount()
    if value<=0 or not finite(launch)then return {}end
    -- The wiki grants the shield at the start of the cast; until the dev recorder's kassadin_q_shield trace settles the
    -- moment it appears, the offer keeps the conservative start (after the cast) so Evade never counts a missing shield.
    return {{validated=true,profile=p.id,resource='slot:0',slot=_Q,cost=20,launch=launch,
     effect={kind='shield',shieldType='magical',amount=value,starts=ctx.now+launch+.05,ends=ctx.now+launch+p.qShieldDuration}}}
   end,
   prepare=function(option,ctx)
    if not ready()or not option.effect or option.profile~=p.id or option.resource~='slot:0'or option.effect.kind~='shield'
     or option.effect.amount~=amount()then return nil,'shield_state_changed'end
    local u=self:ShieldRecipient();local handle=u.handle;local expires=Core.adapter:Now()+20;local starts=option.effect.starts
    return {type='cast',key=HK_Q,target=u,kind='object',resource='slot:0',expires=expires,
     mechanical=function()return ready()and Core.adapter:Now()<=expires and u.handle==handle and Core:Reach(u,650)
      and Game.Timer()+OrbamaPrediction:GetLaunchDelay(spell)<=starts,'shield_state_changed'end}
   end}
  self.shieldOffered=Core:RegisterDefense('Kassadin.Q',self.shieldDefense)
 end
end
-- Whoever the shielding Q is thrown at: a champion if one is in range, else a minion or a monster.
function KassadinChampion:ShieldRecipient()
 for _,kind in ipairs({'hero','lane','jungle'})do local rows=Core:Rows(kind,650);if rows[1]then return rows[1]end end
end
function KassadinChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Kassadin'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
  Menu.Combo:MenuElement({id='R',name='Use R to blink onto the target',value=true})
  Menu.Combo:MenuElement({id='REscape',name='Blink away after the burst when in danger',value=true,menu=false})
  Menu.Harass:MenuElement({id='WMinion',name='Use W on minions when no enemy is in reach',value=true,menu=false})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu.Clear[mode]:MenuElement({id=slot,name=slot=='Q'and mode=='LaneClear'and 'Use Q on minions an attack cannot take'or 'Use '..slot,value=true})end
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='ECount',name='Lane minions E must hit',value=3,min=1,max=8,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
 -- The W last hit needs the active's damage, which only the Normal profile establishes.
 if self.profile.wBase then Menu.LastHit:MenuElement({id='W',name='Use W when the attack alone does not kill',value=true})end
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=10,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R then Q at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='FleeR',name='Use R toward the cursor in Flee',value=true})
 Menu.Misc:MenuElement({id='FleeE',name='Use E on the closest chasing enemy in Flee',value=true})
 Menu.Misc:MenuElement({id='RStacks',name='Never use R above this many stacks',value=2,min=0,max=self.profile.rMax,step=1})
 Menu.Misc:MenuElement({id='RHP',name='Never blink in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='REnemies',name='Never blink into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='ReserveR',name='Keep mana for an escape R after blinking in',value=true,menu=false})
 Menu.Misc:MenuElement({id='RFinish',name='Finish kills with a blink, or with W and an attack',value=true})
 Menu.Misc:MenuElement({id='InterruptQ',name='Interrupt enemy channels with Q',value=true})
 Menu.Misc:MenuElement({id='GapE',name='E enemies that dash onto you',value=true})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Q',name='Q range while ready',value=false})
 Menu.Draw:MenuElement({id='E',name='E range while ready',value=false})
 Menu.Draw:MenuElement({id='R',name='R range while ready (dim when a blink is unsafe)',value=false})
 Menu.Draw:MenuElement({id='Plan',name='Blink landing spot',value=true})
end
function KassadinChampion:SelfBuff(name)return Core:SelfBuff(myHero,name,true)end
function KassadinChampion:RStacks()
 -- A manual self-cast is relevant to resource state, but cannot confirm our
 -- queued blink or authorize its continuation. Cover delayed buff discovery.
 local cast=myHero.activeSpell
 if cast and cast.valid and not cast.isStopped and cast.name==self.profile.r and finite(cast.startTime)
  and cast.startTime<=Game.Timer()and cast.startTime+self.profile.rDuration>Game.Timer()then
  local expiry=cast.startTime+self.profile.rDuration
  if not self.rWitness or expiry>self.rWitness.expires then self.rWitness={expires=expiry}end
 end
 local b,reason=self:SelfBuff(self.profile.rBuff);if reason then return nil,reason end
 if not b then
  if self.rWitness and self.rWitness.expires>Game.Timer()then return nil,'awaiting_r_stack_buff'end
  return 0
 end
 local expiry=buffExpiry(b)
 if not finite(expiry)then return nil,'r_expiry_unknown'end
 if not finite(b.count)or b.count%1~=0 or b.count>self.profile.rMax
  or b.stacks~=nil and b.stacks~=b.count then return nil,'r_stack_fields_unknown'end
 return b.count
end
function KassadinChampion:RCost(stacks)
 if not finite(stacks)or stacks<0 or stacks%1~=0 or stacks>self.profile.rMax then return nil end
 return self.profile.rCostKind=='double'and self.profile.rBaseCost*2^stacks or self.profile.rBaseCost+100*stacks
end
function KassadinChampion:Cost(slot)
 local cost=myHero:GetSpellData(slot).mana
 return finite(cost)and cost>=0 and cost or nil
end
function KassadinChampion:Ready(slot)
 local letter=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot]
 if not letter or not IsReady(slot)or myHero:GetSpellData(slot).name~=self.profile[letter]then return false end
 local cost=self:Cost(slot);if not cost or cost>myHero.mana then return false end
 if slot==_W then local b,reason=self:SelfBuff(self.profile.wBuff);return not b and not reason end
 if slot==_E and self.profile.eAvailable then
  local b,reason=self:SelfBuff(self.profile.eAvailable)
  return b~=nil and not reason
 end
 if slot==_R then local stacks=self:RStacks();return stacks~=nil and self:RCost(stacks)<=myHero.mana end
 return true
end
function KassadinChampion:CastQ(target,validate,context,priority)
 if not self:Ready(_Q)or not Core:Reach(target,650)then return false end
 return Core:Cast(HK_Q,target,{range=650,intentTarget=target,context=context,priority=priority,deferAttackWindup=true,
  validate=function(q,resolved)return self:Ready(_Q)and Core:Reach(target,650)and(not validate or validate(q,resolved))end})
end
function KassadinChampion:GetQDmg(target)
 local rank=myHero:GetSpellData(_Q).level
 if not IsValid(target)or not self.profile.qBase[rank]then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,self.profile.qBase[rank]+self.profile.qAP*myHero.ap)
end
function KassadinChampion:GetEDmg(target)
 local rank=myHero:GetSpellData(_E).level
 if not IsValid(target)or not self.profile.eBase[rank]or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,self.profile.eBase[rank]+self.profile.eAP*myHero.ap)
end
-- Normal adds the bonus of the stacks held before the cast (profile rStack; read fresh on every call, so the
-- dispatch check re-reads them). Unknown stack fields and Classic (stack damage undecoded) keep the lower bound.
function KassadinChampion:GetRDmg(target)
 local p=self.profile;local rank=myHero:GetSpellData(_R).level
 if not IsValid(target)or not p.rBase or not p.rBase[rank]or not finite(myHero.ap)then return 0 end
 local mana=finite(myHero.maxMana)and math.max(0,myHero.maxMana)or 0
 local raw=p.rBase[rank]+p.rAP*myHero.ap+(p.rMana and p.rMana*mana or 0)
 if p.rStack and p.rStack[rank]then
  local stacks=self:RStacks()
  if stacks and stacks>0 then raw=raw+stacks*(p.rStack[rank]+p.rStackAP*math.max(0,myHero.ap)+p.rStackMana*mana)end
 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
-- Health-bar damage: the ready abilities plus one attack (Normal: empowered while W is ready).
function KassadinChampion:ComboDamage(u)
 if not IsValid(u)then return 0 end
 local total=0
 if self:Ready(_Q)then total=total+self:GetQDmg(u)end
 if self:Ready(_E)then total=total+self:GetEDmg(u)end
 if self:Ready(_R)then total=total+self:GetRDmg(u)end
 return total+(self.profile.wBase and self:Ready(_W)and self:WAttackDamage(u)or self:BaseAttackDamage(u))
end
function KassadinChampion:QImpact(target)return self.profile.qCast+GetDistance(target.pos,myHero.pos)/self.profile.qSpeed end
function KassadinChampion:ConeContains(aim,target)
 if not point(aim)or not IsValid(target)then return false end
 local dx,dz=aim.x-myHero.pos.x,aim.z-myHero.pos.z;local len=math.sqrt(dx*dx+dz*dz)
 if len<1 then return false end
 local tx,tz=target.pos.x-myHero.pos.x,target.pos.z-myHero.pos.z;local dist=math.sqrt(tx*tx+tz*tz)
 -- Conservative centre inclusion. The asset angle is 39 degrees; edge/radius
 -- expansion remains excluded pending live geometry proof.
 return dist<=600 and dist>0 and(dx*tx+dz*tz)/(len*dist)>=math.cos(math.rad(39))
end
function KassadinChampion:ConeCount(aim,list,jungle)
 local n=0
 for i=1,math.min(#list,jungle and 12 or 40)do local u=list[i]
  if u.team~=myHero.team and(u.team==300)==jungle and self:ConeContains(aim,u)then n=n+1 end
 end
 return n
end
function KassadinChampion:CastE(target,validate,context)
 if not self:Ready(_E)or not Core:Reach(target,600)then return false end
 local pred=Core:Prediction(self.ESpell);pred:GetPrediction(target,myHero)
 if not pred:CanHit(2)or not self:ConeContains(pred.CastPosition,target)then return false end
 return Core:Cast(HK_E,pred.CastPosition,{intentTarget=target,context=context,prevalidateWorldCast=true,deferAttackWindup=true,
  validate=function(q,resolved)
   local aim=resolved and resolved.position or q.target
   return self:Ready(_E)and self:ConeContains(aim,target)and(not validate or validate(aim))
  end})
end
function KassadinChampion:AttackPermission(target)
 local mode=GetMode();local node,context
  if target.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')then node=Menu[mode];context=Core:ModeContext(mode)
  elseif mode=='Harass'and target.type==Obj_AI_Minion and target.team~=myHero.team and target.team~=300
   and Menu.Harass.WMinion:Value()and manaAbove(Menu.Harass.Mana:Value())then
   local heroes=Core:DecisionUnits('GetEnemyHeroes')
   for i=1,math.min(#heroes,5)do local u=heroes[i]
    if IsValid(u)and _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return nil end
   end
   node=Menu.Harass;context=Core:ModeContext('Harass',function()return Menu.Harass.WMinion:Value()and manaAbove(Menu.Harass.Mana:Value())end)
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then
  local jungle=target.team==300;local kind=jungle and 'jungle'or 'lane'
  if not Core:FarmModeEnabled(kind)then return nil end
  node=Menu.Clear[jungle and 'JungleClear'or 'LaneClear'];context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 end
 if node and node.W:Value()and manaAbove(node.Mana:Value())then return context end
end
function KassadinChampion:OnPostAttack(args)
 if ShouldWait()then return end
 local witness=Core:AttackWitness(self.attack,args and args.Target)
 if not witness or witness==self.attack or witness.at>Game.Timer()then return end
 self.attack=witness;local target=witness.object;local context=self:AttackPermission(target)
 if not context or not self:Ready(_W)or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return end
 -- Normal reset and Classic sustained enhancement share preparation permission.
 -- Neither an accepted key nor a callback mutates the provider's attack timer.
 return Core:Cast(HK_W,nil,{intentTarget=target,context=context,validate=function()
  return self.attack==witness and Game.Timer()-witness.at<=.35 and self:Ready(_W)
   and self:AttackPermission(target)~=nil and _G.SDK.Data:IsInAutoAttackRange(myHero,target)
 end})
end
function KassadinChampion:FarmUseful(target)
 if not Core:Reach(target,650)or target.team==300 then return false end
 return Core:Rescue(target,.25+GetDistance(target.pos,myHero.pos)/self.profile.qSpeed,self:GetQDmg(target),self.rescue)
end
function KassadinChampion:BaseAttackDamage(target)
 local raw=Core:DecisionValue('Kassadin:base_attack',function()
  local physical=finite(myHero.totalDamage)and math.max(0,myHero.totalDamage)or 0
  local magical=0
  if self.profile.wPassiveBase and myHero:GetSpellData(_W).level>0 and finite(myHero.ap)and myHero.ap>=0 then
   magical=self.profile.wPassiveBase+self.profile.wPassiveAP*myHero.ap
  end
  return {physical=physical,magical=magical}
 end)
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw.physical)
  +(raw.magical>0 and _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,raw.magical)or 0)
end
function KassadinChampion:FarmQ(node)
 if not node.Q:Value()or not manaAbove(node.Mana:Value())or not self:Ready(_Q)then return false end
 local list=_G.SDK.ObjectManager:GetEnemyMinions(650);local best
 for i=1,math.min(#list,40)do local u=list[i]
  if(not best or u.maxHealth>best.maxHealth)and self:FarmUseful(u)then best=u end
 end
 if best then return self:CastQ(best,function()return self:FarmUseful(best)end,nil,'normal')end
end
-- W last hit (Normal): the empowered attack takes a minion the plain attack leaves alive. W resets the attack, so the
-- cast is followed at once by the attack; the shared attack preference points the orbwalker at that minion while W is armed.
function KassadinChampion:WAttackDamage(target)
 local rank=myHero:GetSpellData(_W).level;local base=self.profile.wBase and self.profile.wBase[rank]
 if not base or not finite(myHero.ap)then return 0 end
 return self:BaseAttackDamage(target)+_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.wAP*math.max(0,myHero.ap))
end
function KassadinChampion:WKill(target)
 if not Core:CurrentUnit(target)or target.team==300 or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return false end
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)or windup<0 then return false end
 if not Core:Lethal(target,windup,function()return self:WAttackDamage(target)end)then return false end
 -- A minion the plain attack already takes is the orbwalker's.
 local forecast=Core:UnshieldedLegacyForecast(target,windup)
 return finite(forecast)and self:BaseAttackDamage(target)<forecast
end
function KassadinChampion:WLastHit(node,context)
 if not self.profile.wBase then return false end
 local held=self.wFarm
 if held then
  local armed=self:SelfBuff(self.profile.wBuff)~=nil
  if node.W and node.W:Value()and held.unit.handle==held.handle and Game.Timer()<held.expires and self:WKill(held.unit)
   and(armed or Core.pending[HK_W]~=nil or Game.Timer()<held.castUntil)then
   if armed then Core:PreferAttack('KassadinW',held.unit,.25)end
   return true
  end
  self.wFarm=nil;Core:ReleaseAttackPreference('KassadinW')
 end
 if not node.W or not node.W:Value()or not manaAbove(node.Mana:Value())or not self:Ready(_W)then return false end
 local best;local list=Core:Rows('lane',400)
 for i=1,#list do local u=list[i];if(not best or u.maxHealth>best.maxHealth)and self:WKill(u)then best=u end end
 if not best then return false end
 if not Core:Cast(HK_W,nil,{owner='LastHitW',intentTarget=best,context=context,
  validate=function()return node.W:Value()and self:Ready(_W)and self:WKill(best)end})then return false end
 self.wFarm={unit=best,handle=best.handle,expires=Game.Timer()+1.5,castUntil=Game.Timer()+.3};return true
end
function KassadinChampion:LaneClear()
 if not Core:FarmModeEnabled('lane')or not Menu.Clear.SpellFarm:Value()then return end
 local node=Menu.Clear.LaneClear;if not manaAbove(node.Mana:Value())then return end
 if self:WLastHit(node,Core:RescueContext(Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)))then return true end
 if self:FarmQ(node)then return true end
 if not node.E:Value()or not self:Ready(_E)then return end
 local list=_G.SDK.ObjectManager:GetEnemyMinions(600)
 for i=1,math.min(#list,40)do local u=list[i]
  if Core:Reach(u,600)and self:ConeCount(u.pos,list,false)>=node.ECount:Value()then
   return self:CastE(u,function(aim)return self:ConeCount(aim,_G.SDK.ObjectManager:GetEnemyMinions(600),false)>=node.ECount:Value()end)
  end
 end
end
function KassadinChampion:JungleClear()
 if not Core:FarmModeEnabled('jungle')or not Menu.Clear.SpellFarm:Value()then return end
 local node=Menu.Clear.JungleClear;if not manaAbove(node.Mana:Value())then return end
 local q=node.Q:Value()and self:Ready(_Q);local e=node.E:Value()and self:Ready(_E)
 if not q and not e then return end
 local list=_G.SDK.ObjectManager:GetMonsters(650);local best
 for i=1,math.min(#list,12)do local u=list[i];if Core:Reach(u,650)and(not best or u.maxHealth>best.maxHealth)then best=u end end
 if best then if q then return self:CastQ(best)elseif e then return self:CastE(best)end end
end
function KassadinChampion:LastHit()
 if self:WLastHit(Menu.LastHit,Core:RescueContext())then return true end
 return self:FarmQ(Menu.LastHit)
end
-- A kill is always taken, with or without a mode key: Q, then E, at the health the target has when the spell lands.
-- The blink finisher is the bounded part: its own switch, the blink limits (health, enemies, turret, stacks, mana) and a kill
-- that the follow-up Q, plus R when it lands on the target, delivers from the landing spot.
function KassadinChampion:QKills(target)return Core:Lethal(target,self:QImpact(target),function()return self:GetQDmg(target)end,magical)end
function KassadinChampion:EKills(target)return Core:Lethal(target,.25,function()return self:GetEDmg(target)end,magical)end
-- The blink budget a kill needs: 'kill' when R alone kills (the landing is inside R's damage radius), true when the
-- follow-up Q (plus R when it lands on the target) kills from the landing spot, 'w' (Normal, typically with Q down)
-- when R plus the W-empowered attack kills at blink + windup with the landing inside the armed attack range
-- (+wRangeBonus), false otherwise.
function KassadinChampion:BlinkKills(target)
 if not Core:CurrentUnit(target)then return false end
 local p=self.profile
 local pos=self:Endpoint(target.pos);if not pos or not self:SafeEndpoint(pos)then return false end
 local gap=GetDistance(pos,target.pos);if gap>600 then return false end
 local inside=gap<=p.rRadius-70
 if inside and self:RBudget('kill')and Core:Lethal(target,p.rCast,function()return self:GetRDmg(target)end,magical)then return 'kill'end
 if self:RBudget(true)and Core:Lethal(target,p.rCast+p.qCast+gap/p.qSpeed+.1,function()
  return self:GetQDmg(target)+(inside and self:GetRDmg(target)or 0)end,magical)then return true end
 if p.wBase and self:RBudget('w')then
  local windup=_G.SDK.Attack:GetWindup()
  local reach=(myHero.range or 0)+(myHero.boundingRadius or 0)+(target.boundingRadius or 0)+(p.wRangeBonus or 0)
  if finite(windup)and windup>=0 and gap<=reach and Core:Lethal(target,p.rCast+windup,function()
   return self:WAttackDamage(target)+(inside and self:GetRDmg(target)or 0)end,{attack=true})then return 'w'end
 end
 return false
end
-- Without the Combo key the finisher blinks only into an isolated kill: no other enemy champion within 600 of the
-- landing and no R stacks (a single full-price blink, never a dive into a fight).
function KassadinChampion:FinishAllowed(target)
 if GetMode()=='Combo'then return true end
 if self:RStacks()~=0 then return false end
 local pos=self:Endpoint(target.pos);if not pos then return false end
 local rows=Core:Rows('hero',self.profile.rRange+700)
 for i=1,#rows do local u=rows[i];if u~=target and GetDistance(u.pos,pos)<=600 then return false end end
 return true
end
-- Keyless W finisher (re-rank killsecure): a champion in attack range the W-empowered attack kills (the plain one
-- does not) gets W and then one owned attack, outside Combo/Harass (those run WFinish with their own switch). Without
-- Combo no other enemy champion may be within 600.
function KassadinChampion:WKillAllowed(target)
 if not Menu.Misc.RFinish:Value()then return false end
 local mode=GetMode();if mode=='Combo'then return true end
 local rows=Core:Rows('hero',800)
 for i=1,#rows do local u=rows[i];if u~=target and GetDistance(u.pos,myHero.pos)<=600 then return false end end
 return true
end
function KassadinChampion:BeginWKill(u,context)
 if self.wSeq or not self.profile.wBase or not self:Ready(_W)or not self:WChampionKill(u)then return false end
 local seq={unit=u,handle=u.handle,id=identity(u),expires=Game.Timer()+1.5,castUntil=Game.Timer()+.3,context=context}
 self.wSeq=seq
 local ok=Core:Cast(HK_W,nil,{owner='KillW',intentTarget=u,context=context,validate=function()
  return self.wSeq==seq and u.handle==seq.handle and self:Ready(_W)and self:WChampionKill(u)and self:WKillAllowed(u)end})
 if not ok then self.wSeq=nil;return false end
 Core:AfterCast(HK_W,function()if self.wSeq==seq then seq.wObserved=true end end)
 return true
end
function KassadinChampion:CompletedAttack(q,t)
 local a=Core:NativeAttack(q)
 if not a or not a.castEndTime or a.castEndTime>Game.Timer()or Game.Timer()-a.castEndTime>.35 then return false end
 return a.target==t.handle or a.target==t.networkID
end
-- The armed W is delivered by one owned attack on the same champion; no timer stands in for the W buff.
function KassadinChampion:ContinueWKill()
 local seq=self.wSeq;if not seq then return false end
 local u=seq.unit
 if Game.Timer()>seq.expires or not Core:CurrentUnit(u)or u.handle~=seq.handle or identity(u)~=seq.id then self.wSeq=nil;return false end
 if seq.attack then return true end
 local armed=self:SelfBuff(self.profile.wBuff)~=nil
 if not armed then
  if Core.pending[HK_W]~=nil or Game.Timer()<seq.castUntil then return true end
  self.wSeq=nil;return false
 end
 local ok=Core:Attack(u,{owner='KillWAttack',context=seq.context,ttl=250,
  validate=function()return self.wSeq==seq and u.handle==seq.handle and self:SelfBuff(self.profile.wBuff)~=nil and Core:CurrentUnit(u)end,
  observe=function(q)return self:CompletedAttack(q,u)end})
 if ok then seq.attack=true;Core:AfterAttack(function()if self.wSeq==seq then self.wSeq=nil end end)end
 return true
end
function KassadinChampion:Finish()
 local q,e=self:Ready(_Q),self:Ready(_E)
 local r=not self.blink and Menu.Misc.RFinish:Value()and self.profile.rCast~=nil and self:RBudget('kill')
 local mode=GetMode()
 local wReady=self.profile.wBase~=nil and not self.wSeq and self:Ready(_W)
 local w=wReady and mode~='Combo'and mode~='Harass'and Menu.Misc.RFinish:Value()
 if not q and not e and not r and not w then return false end
 local rows=Core:Rows('hero',self.profile.rRange+600)
 for i=1,#rows do local u=rows[i];local distance=GetDistance(u.pos,myHero.pos);local cheap=false
  if q and distance<=650 and self:QKills(u)then cheap=true
   if self:CastQ(u,function()return self:QKills(u)end,{priority='interactive'})then return true end
  end
  if e and distance<=600 and self:EKills(u)then cheap=true
   if self:CastE(u,function()return self:EKills(u)end,{priority='interactive'})then return true end
  end
  -- A W attack kill (Combo/Harass: their WFinish) is cheap too: no blink is spent on it.
  if wReady and not cheap and self:WChampionKill(u)then cheap=true
   if w and self:WKillAllowed(u)and self:BeginWKill(u,{priority='interactive'})then return true end
  end
  -- A blink is never spent on a kill Q or E alone already takes.
  if r and not cheap then local kind=self:BlinkKills(u)
   if kind and self:FinishAllowed(u)then
    local context={priority='interactive',condition=function()return Menu.Misc.RFinish:Value()end}
    if self:StartBlink(u.pos,u,context,kind,function()return self:FinishAllowed(u)and self:BlinkKills(u)~=false end)then return true end
   end
  end
 end
 return false
end
-- Normal Q disrupts a channel and Classic Q silences, which ends one: both stop a channel that outlasts the missile.
function KassadinChampion:Interrupt()
 if not self.profile.qInterrupts or not Menu.Misc.InterruptQ:Value()or not self:Ready(_Q)then return false end
 local rows=Core:Rows('hero',650)
 for i=1,#rows do local u=rows[i]
  if Core:CanInterrupt(u,self:QImpact(u))and Core:SpellProtected(u)==false then
   local cast=u.activeSpell;local name,start=cast.name,cast.startTime
   if self:CastQ(u,function()local c=u.activeSpell
    return Menu.Misc.InterruptQ:Value()and c and c.name==name and c.startTime==start and Core:CanInterrupt(u,self:QImpact(u))
   end,{priority='interactive'})then return true end
  end
 end
 return false
end
-- E slows in a cone: an enemy whose dash ends next to Kassadin is slowed as it arrives.
function KassadinChampion:GapClose()
 if not Menu.Misc.GapE:Value()or not self:Ready(_E)then return false end
 local rows=Core:Rows('hero',900)
 for i=1,#rows do local u=rows[i]
  if Core:ApproachingDash(u,myHero.pos,350)and self:CastE(u,function()return Menu.Misc.GapE:Value()end,{priority='interactive'})then return true end
 end
 return false
end
-- Normal W before the attack: the empowered attack kills a champion the plain attack leaves alive. The preference keeps
-- the orbwalker's next attack on that champion while W is armed; a selected champion in reach is never overridden.
function KassadinChampion:WChampionKill(target)
 if not self.profile.wBase or not Core:CurrentUnit(target)or target.type~=Obj_AI_Hero
  or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return false end
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)or windup<0 then return false end
 local attack={attack=true}
 if Core:Lethal(target,windup,function()return self:BaseAttackDamage(target)end,attack)then return false end
 return Core:Lethal(target,windup,function()return self:WAttackDamage(target)end,attack)
end
function KassadinChampion:WFinish(mode)
 local node=Menu[mode];local held=self.wKill
 if held then
  local armed=self:SelfBuff(self.profile.wBuff)~=nil
  if held.mode==mode and node.W:Value()and held.unit.handle==held.handle and Game.Timer()<held.expires
   and(armed or Core.pending[HK_W]~=nil or Game.Timer()<held.castUntil)and self:WChampionKill(held.unit)then
   if armed then Core:PreferAttack('KassadinWKill',held.unit,.25)end
   return true
  end
  self.wKill=nil;Core:ReleaseAttackPreference('KassadinWKill')
 end
 if not self.profile.wBase or not node.W:Value()or not self:Ready(_W)then return false end
 local selected=_G.SDK.TargetSelector and _G.SDK.TargetSelector.Selected
 if selected and not(IsValid(selected)and _G.SDK.Data:IsInAutoAttackRange(myHero,selected))then selected=nil end
 local rows=Core:Rows('hero',600);local best
 for i=1,#rows do local u=rows[i]
  if(not selected or u==selected)and(not best or u.health<best.health)and self:WChampionKill(u)then best=u end
 end
 if not best then return false end
 if not Core:Cast(HK_W,nil,{owner='KillW',intentTarget=best,context=Core:ModeContext(mode,function()return Menu[mode].W:Value()end),
  validate=function()return Menu[mode].W:Value()and self:Ready(_W)and self:WChampionKill(best)end})then return false end
 self.wKill={unit=best,handle=best.handle,mode=mode,expires=Game.Timer()+1.5,castUntil=Game.Timer()+.3};return true
end
-- Danger after the burst: low health, outnumbered within 600, or a champion's (or turret's) hit on the way.
function KassadinChampion:Danger()
 if myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100<Menu.Misc.RHP:Value()then return 'health'end
 local enemies=GetEnemyCount(600,myHero.pos);local allies=1
 local list=Core:Rows('hero',600,true)
 for i=1,#list do if list[i]~=myHero then allies=allies+1 end end
 if enemies>allies then return 'outnumbered'end
 local threat=Core:AllyThreat(myHero,.75)
 if threat and(threat.kind=='skillshot'or threat.kind=='turret'or threat.source and threat.source.type==Obj_AI_Hero)then return threat.kind end
end
-- Toward the cursor when that landing takes Kassadin away from the enemies near him, else straight away from them.
function KassadinChampion:EscapeGoal()
 local rows=Core:Rows('hero',900);local cx,cz,n=0,0,0
 for i=1,#rows do cx=cx+rows[i].pos.x;cz=cz+rows[i].pos.z;n=n+1 end
 if n==0 then return nil end
 local centre={x=cx/n,y=myHero.pos.y,z=cz/n};local now=GetDistance(myHero.pos,centre)
 local pos=self:Endpoint(mousePos)
 if pos and self:SafeEndpoint(pos)and GetDistance(pos,centre)>now+150 then return mousePos end
 local dx,dz=myHero.pos.x-centre.x,myHero.pos.z-centre.z;local len=math.sqrt(dx*dx+dz*dz)
 if len<1 then return nil end
 local away=Vector(myHero.pos.x+dx/len*self.profile.rRange,myHero.pos.y,myHero.pos.z+dz/len*self.profile.rRange)
 pos=self:Endpoint(away)
 return pos and self:SafeEndpoint(pos)and away or nil
end
-- Blink out after the burst: the follow-up has resolved, Q and E are spent, the target lives and the next attack does
-- not kill it, and Kassadin is in danger. Combo only; the same landing limits as every blink.
function KassadinChampion:EscapeR()
 local b=self.burst;if not b or self.blink then return false end
 if Game.Timer()>b.expires or not IsValid(b.target)or b.target.handle~=b.handle then self.burst=nil;return false end
 if not Menu.Combo.REscape:Value()or self:Ready(_Q)or self:Ready(_E)or Core.pending[HK_Q]then return false end
 local windup=_G.SDK.Attack:GetWindup()
 if _G.SDK.Data:IsInAutoAttackRange(myHero,b.target)and finite(windup)
  and Core:Lethal(b.target,windup,function()return self:BaseAttackDamage(b.target)end,{attack=true})then return false end
 local danger=self:Danger();if not danger or not self:RBudget('escape')then return false end
 local goal=self:EscapeGoal();if not goal then return false end
 if self:StartBlink(goal,nil,Core:ModeContext('Combo',function()return Menu.Combo.REscape:Value()end),'escape')then
  self.burst=nil;Core:Trace('kassadin_escape',{danger=danger});return true
 end
 return false
end
function KassadinChampion:Combat(mode)
 if mode=='Combo'and self:EscapeR()then return true end
 local node=Menu[mode];if not manaAbove(node.Mana:Value())then return end
 if self:WFinish(mode)then return true end
 if mode=='Combo'and node.R:Value()and not self.blink then
  if self:OffensiveR(Core:ModeContext('Combo',function()return Menu.Combo.R:Value()and Menu.Combo.Q:Value()end))then return true end
 end
 local q=node.Q:Value()and self:Ready(_Q);local e=node.E:Value()and self:Ready(_E)
 if not q and not e then return end
 local target=GetTarget(q and 650 or 600);if not IsValid(target)then return end
 -- Q first; E takes the tick when Q was not accepted (out of its range, refused).
 if q and self:CastQ(target)then return true end
 if e then return self:CastE(target)end
end
function KassadinChampion:Combo()return self:Combat('Combo')end
function KassadinChampion:Harass()return self:Combat('Harass')end
function KassadinChampion:Endpoint(goal)
 local pos=point(goal);if not pos then return nil end
 local distance=GetDistance(pos,myHero.pos)
 if distance<75 then return nil end
 if distance>self.profile.rRange then pos=myHero.pos:Extended(pos,self.profile.rRange)end
 return pos
end
function KassadinChampion:SafeEndpoint(pos)
 return point(pos)and GetDistance(pos,myHero.pos)<=self.profile.rRange+.001
  and type(Game.isWall)=='function'and Game.isWall(pos)==false and not IsUnderTurret2(pos)
  and GetEnemyCount(600,pos)<=Menu.Misc.REnemies:Value()
end
-- kind: true (blink in, the follow-up Q is part of the plan), 'kill' (blink in for a kill R alone delivers),
-- 'escape' (blink away after the burst: the mana the reserve kept, one stack over the limit), false (defensive).
function KassadinChampion:RBudget(kind)
 if not self:Ready(_R)then return false end
 local limit=Menu.Misc.RStacks:Value()+(kind=='escape'and 1 or 0)
 local stacks=self:RStacks();if stacks==nil or stacks>limit then return false end
 local cost=math.max(self:RCost(stacks),self:Cost(_R))
 if kind==true or kind=='kill'or kind=='w'then
  if kind==true then
   if not Menu.Combo.Q:Value()or not self:Ready(_Q)then return false end
   cost=cost+self:Cost(_Q)
  elseif kind=='w'then
   if not self.profile.wBase or not self:Ready(_W)then return false end
   cost=cost+self:Cost(_W)
  end
  if Menu.Misc.ReserveR:Value()then cost=cost+self:RCost(math.min(stacks+1,self.profile.rMax))end
  if myHero.maxHealth<=0 or myHero.health/myHero.maxHealth*100<Menu.Misc.RHP:Value()then return false end
 end
 return cost<=myHero.mana
end
function KassadinChampion:BlinkValid(plan,pos)
 if self.blink~=plan or identity(plan.target)~=plan.id or plan.expires<=Game.Timer()or not self:RBudget(plan.budget)
  or not self:SafeEndpoint(pos)then return false end
  if plan.offense then return IsValid(plan.target)and plan.target.handle==plan.handle and GetDistance(plan.target.pos,pos)<=650
   and(not plan.permission or plan.permission())end
 return true
end
function KassadinChampion:StartBlink(goal,target,context,offense,permission)
 if self.blink or not self:RBudget(offense)then return false end
 local pos=self:Endpoint(goal);if not pos or not self:SafeEndpoint(pos)then return false end
  local plan={goal=point(goal),position=pos,target=target,id=identity(target),handle=target and target.handle,context=context,
   offense=offense==true or offense=='kill'or offense=='w',budget=offense,permission=permission,expires=Game.Timer()+1}
 self.blink=plan
 local function resolve()
  local p=self:Endpoint(plan.offense and plan.target.pos or plan.goal)
  if not p or not self:BlinkValid(plan,p)then return nil,'blink_plan_changed'end
  plan.position=p;return {position=p}
 end
 local ok=Core:Cast(HK_R,pos,{owner='Blink',context=context,independent=false,prevalidateWorldCast=true,resolve=resolve,
  intentTarget=target,validate=function(q,resolved)return self:BlinkValid(plan,resolved and resolved.position or q.target)end})
 if not ok then self.blink=nil;return false end
  plan.action=Core.lastIntent.id
  plan.intent=Core.lastIntent
 Core:AfterCast(HK_R,function()
  self.rWitness={expires=Game.Timer()+self.profile.rDuration}
  if self.blink==plan then plan.observed=true end
  if plan.flee then self.fleeObserved=true end
  if plan.offense then self.burst={target=plan.target,handle=plan.handle,expires=Game.Timer()+4}end
 end)
 return true
end
function KassadinChampion:OffensiveR(context)
 if not self:RBudget(true)then return false end
 local target=GetTarget(self.profile.rRange+650);if not IsValid(target)then return false end
 return self:StartBlink(target.pos,target,context,true)
end
function KassadinChampion:ClearBlink(reason)
 local p=self.blink;if p then
  if p.action then Core.adapter:Cancel(p.action,reason)end
  if p.follow then Core.adapter:Cancel(p.follow,reason)end
 end
 self.blink=nil
end
function KassadinChampion:ContinueBlink()
  local p=self.blink;if not p then return false end
  local state=Core:ContinuationState(p.intent,p.expires)
  if not state or not Core.adapter:ContextValid({context=p.context},'continuation')or identity(p.target)~=p.id
   or p.target and p.target.handle~=p.handle then self:ClearBlink('blink_ended');return false end
  if state~='observed'then return true end
 if not p.offense then self.blink=nil;return true end
 if not IsValid(p.target)then self:ClearBlink('recipient_ended');return false end
 -- 'w' blink: W and the empowered attack follow the observed blink (same keyless sequence as an in-range finish).
 if p.budget=='w'then self.blink=nil;self:BeginWKill(p.target,p.context);return true end
 if not Menu.Combo.Q:Value()then self:ClearBlink('followup_disabled');return false end
 -- The blink is instant. Its follow-up Q is only authorized from the planned
 -- point, so a blink that came up short (terrain, a late aim) gives the tick
 -- back 0.3 s after the observed cast instead of holding it to the 1 s expiry.
 if GetDistance(myHero.pos,p.position)>100 then p.observedAt=p.observedAt or Game.Timer()
  if Game.Timer()-p.observedAt>.3 then self.blink=nil;return false end
  return true
 end
  if p.follow then if not Core.adapter:HasAction(p.follow)then self.blink=nil end;return true end
 local ok=self:CastQ(p.target,function()
  if self.blink~=p or not p.observed or not Menu.Combo.Q:Value()or GetDistance(myHero.pos,p.position)>100 then return false end
  if Menu.Misc.ReserveR:Value()then
   local stacks=self:RStacks();local qCost,rCost=self:Cost(_Q),self:Cost(_R)
   if stacks==nil or not qCost or not rCost or qCost+math.max(self:RCost(stacks),rCost)>myHero.mana then return false end
  end
  return true
 end,p.context)
 if ok then p.follow=Core.lastIntent.id end
 return true
end
function KassadinChampion:AssistR()
 local held=Menu.Misc.RAssist:Value()
 if not held then self.assistUsed=false;return false end
 if self.assistUsed then return false end
 if self:OffensiveR(Core:HeldContext(function()return Menu.Misc.RAssist:Value()and Menu.Combo.Q:Value()end))then self.assistUsed=true;return true end
 return false
end
-- The enemy champion that reaches Kassadin first among those closing in (dashing, or walking to a point nearer him).
function KassadinChampion:Pursuer(range)
 local rows=Core:Rows('hero',range);local best,soonest
 for i=1,#rows do local u=rows[i];local path=u.pathing;local d=GetDistance(u.pos,myHero.pos)
  local closing=path and path.endPos and(path.isDashing or path.hasMovePath)and GetDistance(path.endPos,myHero.pos)<d-1
  local speed=path and path.isDashing and path.dashSpeed or u.ms
  if closing and finite(speed)and speed>0 and(not soonest or d/speed<soonest)then best,soonest=u,d/speed end
 end
 return best
end
-- One blink per Flee press; another only after the previous one was seen cast and an enemy is still closing in.
function KassadinChampion:Flee()
 if Menu.Misc.FleeR:Value()and not self.blink and(not self.fleeUsed or self.fleeObserved and self:Pursuer(700))
  and self:StartBlink(mousePos,nil,Core:ModeContext('Flee',function()return Menu.Misc.FleeR:Value()end),false)then
  self.fleeUsed=true;self.fleeObserved=false;self.blink.flee=true;return true
 end
 if Menu.Misc.FleeE:Value()and self:Ready(_E)then
  local target=self:Pursuer(600)
  if not target then local rows=Core:Rows('hero',600)
   for i=1,#rows do if not target or GetDistance(rows[i].pos,myHero.pos)<GetDistance(target.pos,myHero.pos)then target=rows[i]end end
  end
  if IsValid(target)then return self:CastE(target)end
 end
end
-- Dev recorder only: when the Q shield appears relative to the observed Q cast start (settles the Evade offer's start).
function KassadinChampion:ProbeQShield()
 local c=myHero.activeSpell;local now=Game.Timer()
 if c and c.valid and c.name==self.profile.q and finite(c.startTime)and(not self.qProbe or self.qProbe.start~=c.startTime)then
  self.qProbe={start=c.startTime,base=finite(myHero.shieldAP)and myHero.shieldAP or 0}
 end
 local probe=self.qProbe
 if probe and finite(myHero.shieldAP)and myHero.shieldAP>probe.base+1 then
  Core:Trace('kassadin_q_shield',{delay=now-probe.start,amount=myHero.shieldAP-probe.base});self.qProbe=nil
 elseif probe and now>probe.start+1 then self.qProbe=nil end
end
function KassadinChampion:PrepareDraw()
 local d=Menu.Draw
 -- Ready rings only; no R stack text (the game shows the stacks on the R icon and buff bar).
 if not(d.Q:Value()or d.E:Value()or d.R:Value())then self.preview=nil;return end
 self.preview={q=d.Q:Value()and self:Ready(_Q),e=d.E:Value()and self:Ready(_E),
  r=d.R:Value()and self:Ready(_R),rBudget=d.R:Value()and self:RBudget(false)}
end
function KassadinChampion:Tick()
 if ShouldWait()then self:ClearBlink('unavailable');self.wSeq=nil;return end
 self:PrepareDraw()
 if self.profile.qShield and Core.logger then self:ProbeQShield()end
 local mode=GetMode();if mode~='Flee'then self.fleeUsed=false;self.fleeObserved=false end
 if self.wKill and mode~=self.wKill.mode then self.wKill=nil;Core:ReleaseAttackPreference('KassadinWKill')end
 if not Menu.Misc.RAssist:Value()then self.assistUsed=false end
 if self:ContinueBlink()or self:ContinueWKill()or IsCasting()then return end
 if self.wFarm and mode~='LastHit'and mode~='LaneClear'then self.wFarm=nil;Core:ReleaseAttackPreference('KassadinW')end
 if self:AssistR()or self:Interrupt()or self:Finish()or self:GapClose()then return end
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then
  if Core:FarmModeEnabled('lane')and self:LaneClear()then return end
  if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function KassadinChampion:Draw()
 if myHero.dead then return end
 local v=self.preview
 if v and v.q and Menu.Draw.Q:Value()then Draw.Circle(myHero.pos,650,1,Draw.Color(255,150,120,255))end
 if v and v.e and Menu.Draw.E:Value()then Draw.Circle(myHero.pos,600,1,Draw.Color(255,255,150,220))end
 if v and v.r and Menu.Draw.R:Value()then Draw.Circle(myHero.pos,self.profile.rRange,1,v.rBudget and Draw.Color(255,120,200,255)or Draw.Color(90,120,200,255))end
 if Menu.Draw.Plan:Value()then
  if self.blink then Draw.Circle(self.blink.position,65,1,Draw.Color(255,255,200,100))end
 end
end
function KassadinChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Kassadin: modes','Kassadin: blink assistance'},function(page)
  return {title=page==1 and 'Kassadin'or 'Blink and follow-up Q',cards=page==1 and {
   {'MODES','Provider binds select Combo, Harass, lane/jungle, LastHit and Flee. Harass mana applies to every spell.'},
    {'WEAVING','W uses the actual completed attack recipient. Harass minion W shares the Harass mana limit and requires no currently attackable enemy champion. Normal reset and Classic sustained W remain separate mechanics.'},
   {'FARM','Q rescues CS using confirmed incoming HP. Normal W takes a minion the plain attack would leave alive. Lane E counts units in the outgoing cone; farming requires its own switch.'},
   {'AUTOMATIC','A kill is taken with Q or E in every mode. The blink finisher (R alone, or R then Q, counting R stacks) has its own switch and the blink limits; without Combo it only blinks with no other enemy near and no stacks. In Combo and Harass, W goes out before the attack when the empowered attack kills. Q stops enemy channels and E slows an enemy that dashes onto you.'}}or {
   {'BLINK','Combo blinks onto the target and follows with Q inside the health, enemy-count, turret and stack limits, then blinks away when the burst is spent and Kassadin is in danger. The R bind does the same on the selected target without Combo. Flee blinks toward the cursor, again while an enemy still closes in.'},
   {'BUDGET','Current stack cost, Q cost and optional next escape R are checked before spending. Unknown fields refuse R only.'},
    {'FOLLOW-UP','Q is cast after the blink has landed. Releasing the key, dying or a changed target cancels it.'}},
   note='Installed assets are candidate mechanics. Evade may blink with R inside the stack and mana limits, and may use the Normal Q shield against magic damage. Live stack fields, exact cone edges and landing timing remain open.'}
 end)
end
Core:StandardPolicy(KassadinChampion,{damageTypes={Q='magical',E='magical'},exceptions={non_interrupting_summoner=true},methods={
 Finish=function()return {priority='interactive'}end,Interrupt=function()return {priority='interactive'}end,
 GapClose=function()return {priority='interactive'}end}})
KassadinChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Kassadin"]="Kassadin"}
local normalSupported={["Kassadin"]=true}

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
