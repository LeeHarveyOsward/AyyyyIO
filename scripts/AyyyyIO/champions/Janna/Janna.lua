return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Janna"]=function()return _G.OrbamaFamily:Require("67d950132f9574b57b0da34631856ad10278756aa7f928d4518eaec7516cad0a")()end
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
if champion=="Janna" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Janna',profiles={normal=true,classic=true},
 Create=function(context)
-- Installed profile assets, not live timing verification. See janna-provenance.json.
local profiles=ChampionProfiles('Janna')
local finite=Core.finite
-- Predicate with a map bound, not Core.point (which builds a Vector).
local function point(p)return p and finite(p.x)and finite(p.z)and math.abs(p.x)<100000 and math.abs(p.z)<100000 end
local function onRay(p,origin,aim,length,width)
    if not point(p)or not point(origin)or not point(aim)then return false end
    local dx,dz=aim.x-origin.x,aim.z-origin.z;local size=math.sqrt(dx*dx+dz*dz)
    if size<1 then return false end
    dx,dz=dx/size,dz/size
    local x,z=p.x-origin.x,p.z-origin.z;local along=x*dx+z*dz
    return along>=0 and along<=length and math.abs(x*dz-z*dx)<=width
end


local JannaChampion=class("JannaChampion")

function JannaChampion:__init()
	self.profile=profiles[myHero.charName:match('^Jade_')and 'classic'or 'normal']
	self.QSpell = { Type = OrbamaPrediction.SPELLTYPE_LINE, Delay = 0.25, Radius = 100, Range = 1100, Speed = self.profile.qSpeed, Collision = false }
	self.WRange, self.ERange, self.RRange = 550, self.profile.eRange, 600
	self.qStart = 0
	self.qTarget = nil
	self.lastE = -math.huge
	self.maxReach=self.profile.qBaseRange+self.profile.qChargeRate*self.profile.qMaxCharge
	self:LoadMenu()
	Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
	-- Eye of the Storm on Janna herself is instant in both profiles: Evade may use it against a hit it cannot dodge.
	local p=self.profile
	self.defenseRegistered,self.defenseReason,self.shieldDefense=Core:RegisterShield({name='JannaE',slot=_E,key=HK_E,profile=p.id,source=p.source,
		duration=p.eDuration,delay=p.eDelay,kind='object',target=function()return myHero end,
		ready=function()return not self:IsChannelingR()end,amount=function()return self:ShieldAmount()end})
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
end

function JannaChampion:LoadMenu()
	Menu = MenuElement({ type = MENU, id = "Classic_AIO_" .. myHero.charName, name = "AyyyyIO - Janna" })
	Menu:MenuElement({ type = MENU, id = "Combo", name = "Combo" })
	Menu.Combo:MenuElement({ id = "Q", name = "Use Q", value = true })
	Menu.Combo:MenuElement({ id = "W", name = "Use W", value = true })
	Menu.Combo:MenuElement({ id = "E", name = "Use E on allies and turrets attacking champions", value = true })
	Menu:MenuElement({ type = MENU, id = "Harass", name = "Harass" })
	Menu.Harass:MenuElement({ id = "Q", name = "Use Q", value = true })
	Menu.Harass:MenuElement({ id = "W", name = "Use W", value = true })
	Menu.Harass:MenuElement({ id = "Mana", name = "Only above mana %", value = 40, min = 0, max = 100, step = 5 })
	Menu:MenuElement({ type = MENU, id = "Clear", name = "Farming" })
	Menu.Clear:MenuElement({ id = "Enabled", name = "Use abilities to farm (lane and jungle)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(v) CheckChatBlock(Menu.Clear.Enabled, v) end })
	Menu.Clear:MenuElement({ id = "Q", name = "Lane minions Q must hit", value = 3, min = 1, max = 6, step = 1 })
	Menu.Clear:MenuElement({ id = "W", name = "Jungle: use W", value = true })
	Menu.Clear:MenuElement({ id = "Mana", name = "Only above mana %", value = 30, min = 0, max = 100, step = 5 })
	Menu:MenuElement({ type = MENU, id = "Auto", name = "Behaviour" })
	Menu.Auto:MenuElement({ type = MENU, id = "Etarget", name = "Allies to protect (shield, Monsoon, tornado)" })
	_G.SDK.ObjectManager:OnAllyHeroLoad(function(args)
		Menu.Auto.Etarget:MenuElement({ id = args.charName, name = "Allow: " .. args.charName, value = true })
	end)
	Menu.Auto:MenuElement({ id = "R", name = "R when you or an ally is below health % (0 = off)", value = 25, min = 0, max = 100, step = 5 })
	Menu.Auto:MenuElement({ id = "RCount", name = "R to push away this many diving enemies (0 = off)", value = 3, min = 0, max = 5, step = 1 })
	Menu.Auto:MenuElement({ id = "AntiDash", name = "Q enemies that dash onto you or an ally", value = true })
	Menu.Auto:MenuElement({ id = "Peel", name = "Slow enemies attacking you or a nearby ally", value = true })
	Menu.Auto:MenuElement({ id = "Immobile", name = "Q enemies who cannot move", value = true })
	Menu:MenuElement({ type = MENU, id = "Draw", name = "Drawings" })
	for _, s in ipairs({ "Q", "W", "E", "R" }) do
		Menu.Draw:MenuElement({ id = s, name = s .. " range", value = false })
	end
	Menu.Draw:MenuElement({ id = "QPath", name = "Tornado path while charging", value = true })
end

function JannaChampion:IsQCharging()
    return myHero:GetSpellData(_Q).name==self.profile.qRelease
end

function JannaChampion:IsChannelingR()
    local cast=myHero.activeSpell
    if cast and cast.valid and cast.name==self.profile.rName then return true end
    -- Retain the legacy Classic buff witness; do not invent a Normal buff alias.
    if self.profile.id=='classic'then
        for _,buff in ipairs(GetBuffs(myHero))do
            local expiry=Core.buffExpiry(buff)
            if buff.name=='Jade_JannaReapTheWhirlwind'and type(buff.count)=='number'and buff.count>0
                and type(expiry)=='number'and expiry>Game.Timer()then return true end
        end
    end
    return false
end

function JannaChampion:ReconcileQ()
    local charge=self:IsQCharging();local attempt=self.qAttempt
    if self.qCharge and (not charge or Game.Timer()>self.qCharge.started+3)then self.qCharge=nil end
    if not attempt then return end
    if charge then attempt.sawCharge=true end
    local intent=attempt.intent
    if not charge and (attempt.sawCharge or myHero:GetSpellData(_Q).currentCd>0)then
        self.qAttempt=nil;self.qCharge=nil
    elseif intent and Core.pending[HK_Q]~=intent and not intent.sentAt and not intent.ambiguous then
        self.qAttempt=nil
    end
end

function JannaChampion:Tick()
    self:ReconcileQ()
    local channel=self:IsChannelingR()
    _G.SDK.Orbwalker:SetAttack(not channel)
    _G.SDK.Orbwalker:SetMovement(not channel)
    self:TraceEvidence()
    if channel then self:MonsoonE();return end
    if ShouldWait()then return end
    -- A charging tornado is not Monsoon. Emergency defense stays executable.
    if IsCasting()then return end
    if self:AutoR()then return end
    local shielded=self:AutoE()
    local mode=GetMode()
    if not shielded and mode~='Combo'then self:TurretE()end
    if self:HandleQ()then return end
    self:AntiDash();self:Interrupt();self:Peel();self:AutoImmobile();self:KillSteal()
    if mode=='Combo'then self:Combo()
    elseif mode=='Harass'then self:Harass()
    elseif mode=='LaneClear'then self:Clear()
    elseif mode=='Flee'then self:Flee()end
end

function JannaChampion:QConsent(plan)
    if not plan or not plan.intent or not plan.intent.continue()then return false end
    if plan.purpose=='Combo'then return Menu.Combo.Q:Value()
    elseif plan.purpose=='Harass'then return Menu.Harass.Q:Value()
    elseif plan.purpose=='Clear'then return Menu.Clear.Enabled:Value()and not IsUnderTurret(myHero)
    elseif plan.purpose=='AntiDash'then return Menu.Auto.AntiDash:Value()
    elseif plan.purpose=='Immobile'then return Menu.Auto.Immobile:Value()
    end
    return plan.purpose=='Flee'or plan.purpose=='Interrupt'
end

function JannaChampion:FarmPoints(origin)
    local points={};local units=Core:DecisionUnits('GetEnemyMinions')
    local prediction=Core:Prediction(self.QSpell)
    for i=1,math.min(#units,24)do
        local unit=units[i]
        if IsValid(unit)and unit.team~=300 and GetDistance(unit.pos,origin)<=self.QSpell.Range then
            prediction:GetPrediction(unit,origin)
            if prediction:CanHit(2)then points[#points+1]={unit=unit,aim=prediction.CastPosition}end
        end
    end
    return points
end

function JannaChampion:FarmCount(origin,aim,points)
    local count=0
    for _,entry in ipairs(points or self:FarmPoints(origin))do
        if onRay(entry.aim,origin,aim,self.QSpell.Range,self.QSpell.Radius+(entry.unit.boundingRadius or 0))then count=count+1 end
    end
    return count
end

-- Tornado reach after `elapsed` seconds of charge: base range plus 20 % per second, capped at the full charge
-- (profile rows; wiki 2026-10-10 and the installed HowlingGale record).
-- Rounded down to 50 units so a charge reuses a handful of prediction settings.
function JannaChampion:QReach(elapsed)
    local p=self.profile
    local reach=p.qBaseRange+p.qChargeRate*math.max(0,math.min(p.qMaxCharge,elapsed or 0))
    return math.max(p.qBaseRange,math.floor(reach/50)*50)
end

-- Prediction settings for a release at `reach`. The extracted missile speed and the constant 1.25 s travel
-- disagree (unmeasured): beyond the base range a release must be on the ray under both models.
function JannaChampion:QSettings(reach,model)
    local q=self.QSpell;local speed=model and reach/self.profile.qTravel or q.Speed
    local cache=self.qSettingsCache or {};self.qSettingsCache=cache
    local key=(model and 'm'or 'a')..reach
    local s=cache[key]
    if not s then
        s={Type=q.Type,Delay=q.Delay,Radius=q.Radius,Range=reach,Speed=speed,Collision=false}
        cache[key]=s
    end
    return s
end

function JannaChampion:OnTornadoRay(target,plan,reach,model)
    local prediction=Core:Prediction(self:QSettings(reach,model));prediction:GetPrediction(target,plan.origin)
    return prediction:CanHit(plan.hc)and onRay(prediction.CastPosition,plan.origin,plan.aim,reach,self.QSpell.Radius+(target.boundingRadius or 0))
end

function JannaChampion:ReleaseUseful(plan)
    if not self:QConsent(plan)or not plan.origin or not plan.aim or not self:IsQCharging()then return false end
    if plan.purpose=='Clear'then return self:FarmCount(plan.origin,plan.aim)>=Menu.Clear.Q:Value()end
    if plan.purpose=='Flee'then return true end
    if plan.row and not plan.row.valid()then return false end
    local reach=self:QReach(Game.Timer()-plan.started)
    local target=plan.target
    if not target and plan.row then
        return onRay(plan.row.position,plan.origin,plan.aim,reach,self.QSpell.Radius)
    end
    if not IsValid(target)then return false end
    if not self:OnTornadoRay(target,plan,reach,false)then return false end
    -- Beyond the base range the travel model matters: the release must hold under both.
    return reach<=self.profile.qBaseRange or self:OnTornadoRay(target,plan,reach,true)
end

function JannaChampion:HandleQ()
    if not self:IsQCharging()then return false end
    local plan=self.qCharge
    if plan and plan.releaseAttempt then
        local intent=plan.releaseAttempt
        if Core.pending[HK_Q]~=intent and not intent.sentAt and not intent.ambiguous then plan.releaseAttempt=nil end
    end
    -- A manual charge, or an ambiguous start, never grants automatic release consent.
    if not plan or plan.releaseAttempt or not self:QConsent(plan)then return true end
    local elapsed=Game.Timer()-plan.started
    local delay=(plan.purpose=='AntiDash'or plan.purpose=='Interrupt'or plan.purpose=='Immobile')and .15 or (plan.purpose=='Clear'or plan.purpose=='Flee')and .45 or .65
    if elapsed<delay and not (elapsed>=.25 and IsValid(plan.target)and IsHardCC(plan.target))then return true end
    if not self:ReleaseUseful(plan)then return true end
    local accepted=Core:Cast(HK_Q,nil,{owner='ReleaseQ',context=plan.intent.context,ttl=150,
        observe=function()return not self:IsQCharging()end,
        validate=function()return self.qCharge==plan and self:ReleaseUseful(plan)end})
    if accepted then
        -- One accepted release only, including an uncertain send. No repeated recast input.
        plan.releaseAttempt=Core.lastIntent
        Core:AfterCast(HK_Q,function()
            if self.qCharge==plan then self.qCharge=nil end
            -- Development evidence for the tornado's speed and reach by charge (Janna-5): the own missile is
            -- followed for 2.5 s after the observed release (dev builds only).
            if Core.logger then
                local now=Game.Timer()
                self.qWatch={releasedAt=now,charge=now-plan.started,reach=self:QReach(now-plan.started),
                    originX=plan.origin.x,originZ=plan.origin.z,aimX=plan.aim.x,aimZ=plan.aim.z,purpose=plan.purpose,expires=now+2.5}
            end
        end)
    end
    return true
end

function JannaChampion:BeginQ(aim,target,purpose,hc,row,long)
    self:ReconcileQ()
    if not IsReady(_Q)or self:IsQCharging()or self.qAttempt or not point(aim)then return false end
    local plan={target=target,purpose=purpose,hc=hc or 2,row=row}
    local accepted=Core:Cast(HK_Q,aim,{range=long and self.maxReach or self.QSpell.Range,owner=purpose,intentTarget=target,
        observe=function()
            local intent=plan.intent;local cast=Core:NativeCast(intent,self.profile.qBegin)
            if cast
                and point(cast.startPos)and point(cast.placementPos)and GetDistance(cast.startPos,cast.placementPos)>1 then
                plan.origin=Vector(cast.startPos);plan.aim=Vector(cast.placementPos);plan.started=cast.startTime
            end
            return self:IsQCharging()
        end,
        validate=function(q,resolved)
            if self:IsQCharging()then return false end
            if purpose=='Clear'then
                return Menu.Clear.Enabled:Value()and not IsUnderTurret(myHero)
                    and self:FarmCount(myHero.pos,Vector(resolved and resolved.position or q.target))>=Menu.Clear.Q:Value()
            end
            if purpose=='AntiDash'then return Menu.Auto.AntiDash:Value()and self:IsApproaching(target)end
            if purpose=='Interrupt'then return self:Interruptible(target)end
            if purpose=='Immobile'then return Menu.Auto.Immobile:Value()and(not row or row.valid())end
            return true
        end})
    if not accepted then return false end
    if Core.lastIntent then
        plan.intent=Core.lastIntent;self.qAttempt=plan
        Core:AfterCast(HK_Q,function()
            plan.sawCharge=true
            -- Spell stage proves charging. Geometry needs an attributable native cast witness.
            if plan.origin and plan.aim and plan.started then self.qCharge=plan end
        end)
    end
    return true
end

function JannaChampion:StartQ(target,hc,purpose)
    if not IsValid(target)or not IsReady(_Q)or self:IsQCharging()or self.qAttempt then return false end
    local prediction=Core:Prediction(self.QSpell);prediction:GetPrediction(target,myHero)
    if not prediction:CanHit(hc or 2)then return false end
    return self:BeginQ(prediction.CastPosition,target,purpose or GetMode(),hc)
end

-- Charged tornado for a target beyond the base range (Janna-4): aim on the line predicted for the hold plus
-- the flight, then the release waits until the growing reach covers the target on that original ray
-- (ReleaseUseful re-predicts at every look, under both travel models). Only the begin aim's direction is used,
-- so it is placed 750 units out, where the cursor can reach it on screen.
function JannaChampion:StartLongQ(target,hc,purpose)
    if not IsValid(target)or not IsReady(_Q)or self:IsQCharging()or self.qAttempt then return false end
    local p=self.profile;local distance=GetDistance(target.pos,myHero.pos)
    local need=distance+(target.boundingRadius or 0)
    if distance<=p.qBaseRange or need>self.maxReach then return false end
    local hold=(need-p.qBaseRange)/p.qChargeRate
    -- One settings table, updated in place (the prediction facade caches by table identity).
    local settings=self.longSettings
    if not settings then
        settings={Type=self.QSpell.Type,Radius=self.QSpell.Radius,Range=self.maxReach,Collision=false};self.longSettings=settings
    end
    settings.Delay=math.floor(hold*20)/20;settings.Speed=math.floor(need/p.qTravel)
    local prediction=Core:Prediction(settings);prediction:GetPrediction(target,myHero)
    if not prediction:CanHit(hc or 2)or not point(prediction.CastPosition)then return false end
    if GetDistance(prediction.CastPosition,myHero.pos)+(target.boundingRadius or 0)>self.maxReach then return false end
    local aim=myHero.pos:Extended(Vector(prediction.CastPosition),750)
    return self:BeginQ(aim,target,purpose,hc,nil,true)
end

function JannaChampion:WReach(target)
    local range=self.WRange
    if self.profile.wEdge then range=range+(myHero.boundingRadius or 0)+(target.boundingRadius or 0)end
    return range
end

function JannaChampion:CastW(target,permission)
    if not IsValid(target)or not IsReady(_W)or GetDistance(target.pos,myHero.pos)>self:WReach(target)then return false end
    return Core:Cast(HK_W,target,{range=self:WReach(target),validate=function()
        return GetDistance(target.pos,myHero.pos)<=self:WReach(target)and(not permission or permission())end})
end

function JannaChampion:Combo()
    if self:EmpowerE()then return end
    if not (Menu.Combo.Q:Value()and IsReady(_Q))and not (Menu.Combo.W:Value()and IsReady(_W))then return end
    local target=GetTarget(self.QSpell.Range)
    if not IsValid(target)then
        if Menu.Combo.Q:Value()then self:StartLongQ(GetTarget(self.maxReach),2,'Combo')end
        return
    end
    if not target.pos2D.onScreen then return end
    if Menu.Combo.Q:Value()and self:StartQ(target,2,'Combo')then return end
    if Menu.Combo.W:Value()then self:CastW(target)end
end

-- The shield also grants attack damage while it holds (both profiles): in Combo it goes on an allowed ally, or
-- Janna herself, whose basic attack on an enemy champion is winding up. A threatened ally comes first (AutoE runs
-- before this every tick); among several attackers the one with the most attack damage gets it.
function JannaChampion:EmpowerE()
    if not Menu.Combo.E:Value()or not IsReady(_E)or Game.Timer()-self.lastE<=.25 or Core.pending[HK_E]then return false end
    local allies=self:ShieldCandidates(false);local enemies=Core:DecisionUnits('GetEnemyHeroes');local best,bestWitness
    for i=1,math.min(#allies,6)do local ally=allies[i]
        if IsValid(ally)and GetDistance(ally.pos,myHero.pos)<=self.ERange and self:ShieldAllowed(ally)then
            local cast=Core:CastWindup(ally,0,1,true)
            if cast then
                for j=1,math.min(#enemies,5)do local enemy=enemies[j]
                    if IsValid(enemy)and(cast.target==enemy.handle or cast.target==enemy.networkID)
                        and(not best or(ally.totalDamage or 0)>(best.totalDamage or 0))then best,bestWitness=ally,cast end
                end
            end
        end
    end
    -- No attacking champion: an allied turret shooting an enemy champion takes the bonus attack damage.
    if not best then return self:TurretE('EmpowerE')end
    local accepted=Core:Cast(HK_E,best,{owner='EmpowerE',validate=function()
        return Menu.Combo.E:Value()and self:ShieldAllowed(best)and GetDistance(best.pos,myHero.pos)<=self.ERange
            and Core:MatchesCastWindup(best,bestWitness,-.05,1,true)
    end})
    if accepted then Core:AfterCast(HK_E,function()self.lastE=Game.Timer()end)end
    return accepted
end

-- The enemy champion an allied turret within E range is shooting, or nil.
function JannaChampion:TurretVictim(turret)
    if not turret or turret.dead or(turret.health or 1)<=0 or not turret.pos or GetDistance(turret.pos,myHero.pos)>self.ERange then return nil end
    local id=turret.targetID
    if not id or id==0 then return nil end
    local enemies=Core:DecisionUnits('GetEnemyHeroes')
    for i=1,math.min(#enemies,5)do local enemy=enemies[i]
        if IsValid(enemy)and(enemy.networkID==id or enemy.handle==id)then return enemy end
    end
end

-- Eye of the Storm on an allied turret that is shooting an enemy champion (bonus attack damage; Classic also
-- gives Janna the kill credit). In Combo after the champion candidates; without a mode key only when no
-- shield was needed this tick (AutoE runs first). Under Combo.E in both cases.
function JannaChampion:TurretE(owner)
    if not self.profile.eTurrets or not Menu.Combo.E:Value()or not IsReady(_E)or Game.Timer()-self.lastE<=.25 or Core.pending[HK_E]then return false end
    local objects=_G.SDK.ObjectManager
    if type(objects.GetAllyTurrets)~='function'then return false end
    local turrets=objects:GetAllyTurrets(self.ERange)
    for i=1,math.min(#turrets,8)do local turret=turrets[i]
        local victim=self:TurretVictim(turret)
        if victim then
            local accepted=Core:Cast(HK_E,turret,{owner=owner or 'TurretE',validate=function()
                return Menu.Combo.E:Value()and self:TurretVictim(turret)==victim
            end})
            if accepted then Core:AfterCast(HK_E,function()self.lastE=Game.Timer()end);return true end
        end
    end
    return false
end

-- Allies E may go to: allied champions including Janna, and allied turrets in reach where the profile allows them.
function JannaChampion:ShieldCandidates(turrets)
    local source=Core:DecisionUnits('GetAllyHeroes');local allies={};local me=false
    for i=1,math.min(#source,6)do allies[#allies+1]=source[i];if source[i]==myHero then me=true end end
    if not me then allies[#allies+1]=myHero end
    if turrets and self.profile.eTurrets and _G.SDK.ObjectManager.GetAllyTurrets then
        for _,turret in ipairs(_G.SDK.ObjectManager:GetAllyTurrets(self.ERange))do allies[#allies+1]=turret end
    end
    return allies
end

-- Shield for the Evade offer, from the profile's sourced row.
function JannaChampion:ShieldAmount()
    local p=self.profile;local base=p.eShield[myHero:GetSpellData(_E).level]
    if not base or not finite(myHero.ap)then return 0 end
    return base+p.eShieldAP*math.max(0,myHero.ap)
end

function JannaChampion:Harass()
    if not Core.manaAbove(Menu.Harass.Mana:Value())then return end
    if not (Menu.Harass.Q:Value()and IsReady(_Q))and not (Menu.Harass.W:Value()and IsReady(_W))then return end
    local target=GetTarget(self.QSpell.Range)
    if not IsValid(target)then
        if Menu.Harass.Q:Value()then self:StartLongQ(GetTarget(self.maxReach),3,'Harass')end
        return
    end
    if not target.pos2D.onScreen then return end
    if Menu.Harass.Q:Value()and self:StartQ(target,3,'Harass')then return end
    if Menu.Harass.W:Value()then self:CastW(target)end
end

function JannaChampion:PoisonThreat(ally)
    for _,buff in ipairs(GetBuffs(ally))do
        local expiry=Core.buffExpiry(buff)
        if (buff.type==13 or buff.type==24)and type(buff.count)=='number'and buff.count>0
            and type(expiry)=='number'and expiry>Game.Timer()then return true end
    end
    return false
end

function JannaChampion:ThreatValid(ally,threat)
    if not IsValid(ally)then return false end
    if threat.kind=='poison'then return self:PoisonThreat(ally)end
    if threat.kind=='skillshot'or threat.kind=='missile'then return threat.valid()end
    local source=threat.source
    if not IsValid(source)or source.networkID~=threat.sourceID then return false end
    if threat.kind=='turret'then return source.targetID==ally.networkID end
    local cast=Core:ReadCast(source)
    if not cast or not cast.valid or cast.isStopped or cast.name~=threat.name or cast.startTime~=threat.startTime then return false end
    if type(cast.castEndTime)=='number'and cast.castEndTime>0 and cast.castEndTime<Game.Timer()then return false end
    return cast.target==ally.handle or cast.target==ally.networkID
end

function JannaChampion:ShieldAllowed(ally)
    -- Both profiles can shield an allied turret (profile.eTurrets); Janna herself needs no consent entry.
    if ally.type==Obj_AI_Turret then return self.profile.eTurrets==true end
    if ally==myHero then return true end
    local option=Menu.Auto.Etarget[ally.charName]
    return option and option:Value()
end

function JannaChampion:AutoE()
    if not IsReady(_E)or Game.Timer()-self.lastE<=.25 then return end
    local allies=self:ShieldCandidates(true)
    local enemies=Core:DecisionUnits('GetEnemyHeroes');local turrets=Core:DecisionUnits('GetEnemyTurrets')
    -- Targeted casts, attacks and turret focus keep this controller's own scoring instead of Core:AllyThreat:
    -- it ranks a lethal basic attack above everything else, weighs attacks by their share of the ally's health,
    -- counts damaging debuffs and also covers allied turrets, none of which the soonest-threat service does.
    -- The skillshot evidence (an ally standing in a tracked enemy spell) comes from Core:AllyThreat.
    local best,bestThreat,bestScore
    -- Each enemy's native cast is read once per decision (shared with Core:AllyThreat's skillshot fallback).
    local casts={};for j=1,math.min(#enemies,10)do casts[j]=Core:ReadCast(enemies[j]) or false end
    for i=1,math.min(#allies,12)do
        local ally=allies[i]
        if IsValid(ally)and GetDistance(ally.pos,myHero.pos)<=self.ERange and self:ShieldAllowed(ally)then
            local threat,score
            if self:PoisonThreat(ally)then threat={kind='poison'};score=1 end
            for j=1,math.min(#enemies,10)do
                local enemy=enemies[j];local cast=casts[j]or nil
                if IsValid(enemy)and cast and cast.valid and (cast.target==ally.handle or cast.target==ally.networkID)then
                    local candidate={kind='targeted',source=enemy,sourceID=enemy.networkID,name=cast.name,startTime=cast.startTime}
                    if self:ThreatValid(ally,candidate)then
                        local value=3
                        if cast.isAutoAttack==true then
                            local damage=_G.SDK.Damage:GetAutoAttackDamage(enemy,ally)
                            value=value+math.min(damage/math.max(1,ally.health),1)
                            if damage>=ally.health+(ally.shieldAD or 0)then value=value+10 end
                            -- Janna-13: a harmless poke on a healthy champion does not spend the shield before the
                            -- real burst. Kept: a hit worth a tenth of the shield, below 70 % health, a lethal or
                            -- crowd-controlling attack. Targeted spells (no damage model) and turrets always count.
                            if ally.type==Obj_AI_Hero and damage<.1*self:ShieldAmount()and ally.health>=.7*ally.maxHealth
                                and value<10 and not(Core.CCAttackNames and type(cast.name)=='string'and Core.CCAttackNames[cast.name:lower()])then value=nil end
                        end
                        if value and(not score or value>score)then threat,score=candidate,value end
                    end
                end
            end
            for j=1,math.min(#turrets,16)do
                local turret=turrets[j]
                if IsValid(turret)and turret.targetID==ally.networkID and (not score or score<2)then
                    threat={kind='turret',source=turret,sourceID=turret.networkID};score=2
                end
            end
            -- A tracked spell about to hit a champion ranks like a targeted cast. For Janna herself only a hit
            -- that is a moment away counts: before that the dodge has its chance and the shield is not spent.
            if ally.type==Obj_AI_Hero and(not score or score<3)then
                local shot=Core:AllyThreat(ally,1,{attacks=false,casts=false,turrets=false})
                -- A targeted spell missile already flying at the champion counts like its cast.
                if shot and(shot.kind=='skillshot'and(ally~=myHero or shot.impactIn<=.3)or shot.kind=='missile')then threat=shot;score=3 end
            end
            if threat then
                score=score+(1-ally.health/math.max(1,ally.maxHealth))*.5
                if not bestScore or score>bestScore then best,bestThreat,bestScore=ally,threat,score end
            end
        end
    end
    if best and self:CastE(best,bestThreat)then Core:AfterCast(HK_E,function()self.lastE=Game.Timer()end);return true end
    return false
end

function JannaChampion:CastE(ally,threat)
    return Core:Cast(HK_E,ally,{validate=threat and function()
        return self:ShieldAllowed(ally)and self:ThreatValid(ally,threat)
    end or nil})
end

function JannaChampion:AutoR()
    if not IsReady(_R)or Menu.Auto.R:Value()==0 and Menu.Auto.RCount:Value()==0 then return end
    if self:RNeeded()then return Core:Cast(HK_R,nil,{owner='AutoR',validate=function()return self:RNeeded()end})end
end

-- Monsoon heals everyone in its area and pushes enemies away: Janna or an allowed ally inside the area is
-- below the health limit with an enemy next to them, counting the hit already on its way (Janna-8), or
-- enough enemies dive Janna's area (Janna-7).
function JannaChampion:RNeeded()
    return self:EmergencyR()or self:DisengageR()
end

function JannaChampion:EmergencyR()
    local limit=Menu.Auto.R:Value();if limit<=0 then return false end
    local function low(u,reach)
        if u.maxHealth<=0 or GetEnemyCount(reach,u.pos)<=0 then return false end
        local health=u.health
        if health/u.maxHealth*100>limit then health=health-self:IncomingDamage(u,.75)end
        return health/u.maxHealth*100<=limit
    end
    if low(myHero,self.RRange)then return true end
    local allies=Core:DecisionUnits('GetAllyHeroes')
    for i=1,math.min(#allies,6)do local ally=allies[i]
        if ally~=myHero and IsValid(ally)and GetDistance(ally.pos,myHero.pos)<=self.profile.rRadius-50 and self:ShieldAllowed(ally)and low(ally,450)then return true end
    end
    return false
end

-- At least RCount enemy champions inside the area, one of them a current threat (dash, attack or targeted
-- cast) on Janna or an allowed ally there, and no ally attack winding up onto any of them: Monsoon never
-- knocks enemies out of our own engage.
function JannaChampion:DisengageR()
    local need=Menu.Auto.RCount:Value();if need<=0 then return false end
    local radius=self.profile.rRadius-50;local inside={};local count=0
    local enemies=Core:DecisionUnits('GetEnemyHeroes')
    for i=1,math.min(#enemies,5)do local enemy=enemies[i]
        if IsValid(enemy)and GetDistance(enemy.pos,myHero.pos)<=radius then
            count=count+1;inside[enemy.networkID or -i]=true;inside[enemy.handle or -i]=true
        end
    end
    if count<need then return false end
    local units=self:Protected(radius);local threatened=false
    for i=1,#units do local unit=units[i]
        local source=Core:PeelTarget(unit,1,{melee=false})
        if source and inside[source.networkID]then threatened=true end
        if unit~=myHero then
            local cast=Core:CastWindup(unit,0,1,true)
            if cast and cast.target and inside[cast.target]then return false end
        end
    end
    return threatened
end

-- Private on purpose (not Core:ApproachingDash): the landing may also be next to an allowed ally near Janna.
function JannaChampion:IsApproaching(target)
    if not(IsValid(target)and target.pathing and target.pathing.isDashing and point(target.posTo))then return false end
    local landing=target.posTo
    if GetDistance(landing,myHero.pos)<500 and GetDistance(landing,myHero.pos)<GetDistance(target.pos,myHero.pos)then return true end
    local allies=Core:DecisionUnits('GetAllyHeroes')
    for i=1,math.min(#allies,6)do local ally=allies[i]
        if ally~=myHero and IsValid(ally)and GetDistance(ally.pos,myHero.pos)<=700 and self:ShieldAllowed(ally)
            and GetDistance(landing,ally.pos)<350 and GetDistance(landing,ally.pos)<GetDistance(target.pos,ally.pos)then return true end
    end
    return false
end

-- Tornado start, the short charge and its flight must land before the channel ends.
function JannaChampion:Interruptible(target)
    return IsValid(target)and GetDistance(target.pos,myHero.pos)<=self.QSpell.Range
        and Core:CanInterrupt(target,.4+GetDistance(target.pos,myHero.pos)/self.QSpell.Speed)
end

function JannaChampion:Interrupt()
    if not IsReady(_Q)or self:IsQCharging()then return end
    local units=Core:DecisionUnits('GetEnemyHeroes')
    for i=1,math.min(#units,10)do
        if self:Interruptible(units[i])and self:StartQ(units[i],2,'Interrupt')then return end
    end
end

function JannaChampion:AntiDash()
    if not Menu.Auto.AntiDash:Value()or not IsReady(_Q)or self:IsQCharging()then return end
    local units=Core:DecisionUnits('GetEnemyHeroes')
    for i=1,math.min(#units,10)do
        if self:IsApproaching(units[i])and self:StartQ(units[i],2,'AntiDash')then return end
    end
end

-- Units Janna protects in an area: herself and the allowed allies within `radius`.
function JannaChampion:Protected(radius)
    local list={myHero};local allies=Core:DecisionUnits('GetAllyHeroes')
    for i=1,math.min(#allies,6)do local ally=allies[i]
        if ally~=myHero and not ally.isMe and IsValid(ally)and GetDistance(ally.pos,myHero.pos)<=radius and self:ShieldAllowed(ally)then list[#list+1]=ally end
    end
    return list
end

-- W peel (Janna-2): slow the enemy champion that threatens Janna or an allowed ally right now (shared
-- Core:PeelTarget: dashing onto it, attacking or casting at it, a melee champion in reach). Not on the enemy
-- a charging tornado is aimed at (the crowd control would overlap).
function JannaChampion:PeelValid(ally,enemy)
    if not Menu.Auto.Peel:Value()or not IsValid(ally)or not IsValid(enemy)then return false end
    if GetDistance(enemy.pos,myHero.pos)>self:WReach(enemy)then return false end
    if ally~=myHero and not self:ShieldAllowed(ally)then return false end
    return Core:PeelTarget(ally,1)==enemy
end

function JannaChampion:Peel()
    if not Menu.Auto.Peel:Value()or not IsReady(_W)or Core.pending[HK_W]then return false end
    local units=self:Protected(self.WRange+600)
    for i=1,#units do local ally=units[i]
        local enemy=Core:PeelTarget(ally,1)
        if enemy and IsValid(enemy)and not(self.qCharge and self.qCharge.target==enemy)
            and GetDistance(enemy.pos,myHero.pos)<=self:WReach(enemy)then
            if Core:Cast(HK_W,enemy,{owner='Peel',range=self:WReach(enemy),validate=function()return self:PeelValid(ally,enemy)end})then return true end
        end
    end
    return false
end

-- Automatic tornado on an enemy that cannot move until it lands (Janna-3): shared Core:ZoneTargets rows whose
-- freedom comes after the short charge (0.15 s) plus the slower of the two travel models.
function JannaChampion:ImmobileArm()
    local p=self.profile
    return .15+math.max(p.qTravel,p.qBaseRange/math.max(1,self.QSpell.Speed))
end

function JannaChampion:AutoImmobile()
    if not Menu.Auto.Immobile:Value()or not IsReady(_Q)or self:IsQCharging()or self.qAttempt then return false end
    if not Core.manaAbove(Menu.Harass.Mana:Value())then return false end
    local rows=Core:ZoneTargets({range=self.QSpell.Range,arm=self:ImmobileArm()})
    for i=1,math.min(#rows,6)do local row=rows[i]
        local unit=row.unit
        if unit and IsValid(unit)and unit.team~=myHero.team and GetDistance(unit.pos,myHero.pos)<=self.QSpell.Range then
            if self:BeginQ(Vector(unit.pos),unit,'Immobile',2,row)then return true end
        elseif not unit and row.position and GetDistance(row.position,myHero.pos)<=self.QSpell.Range then
            if self:BeginQ(Vector(row.position),nil,'Immobile',2,row)then return true end
        end
    end
    return false
end

-- Damage of the soonest current threat on `unit` within `horizon` (an attack or a turret shot: the SDK attack
-- estimate). Spells without a damage model count 0: the rule stays conservative.
function JannaChampion:IncomingDamage(unit,horizon)
    local threat=Core:AllyThreat(unit,horizon or .75,{skillshots=false})
    if not threat or not threat.source then return 0,threat end
    if threat.kind=='attack'or threat.kind=='turret'then
        local ok,damage=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,threat.source,unit)
        if ok and finite(damage)and damage>0 then return damage,threat end
    end
    return 0,threat
end

-- Monsoon healing that lands on a unit in the next `seconds` (profile ticks).
function JannaChampion:MonsoonHeal(seconds)
    local p=self.profile;local level=myHero:GetSpellData(_R).level or 0
    local base=p.rHeal[math.max(1,math.min(3,level))]
    if not base or not finite(seconds)or seconds<=0 then return 0 end
    return math.floor(seconds/p.rTick)*(base+p.rHealAP*math.max(0,myHero.ap or 0))
end

-- Eye of the Storm during Monsoon (Janna-9): only against a hit that kills Janna or an allowed ally before the
-- remaining heal ticks can cover it. The cast ends Monsoon; nothing less than a death justifies that.
function JannaChampion:MonsoonLethal(ally)
    if not IsValid(ally)or GetDistance(ally.pos,myHero.pos)>self.ERange then return false end
    if ally~=myHero and not self:ShieldAllowed(ally)then return false end
    local damage,threat=self:IncomingDamage(ally,1)
    if damage<=0 or not threat then return false end
    return damage>=ally.health+(ally.shieldAD or 0)+self:MonsoonHeal(threat.impactIn),threat
end

function JannaChampion:MonsoonE()
    if not IsReady(_E)or Core.pending[HK_E]then return false end
    local units=self:Protected(self.ERange)
    for i=1,#units do local ally=units[i]
        local lethal,threat=self:MonsoonLethal(ally)
        if lethal then
            return Core:Cast(HK_E,ally,{owner='MonsoonE',priority='interactive',validate=function()
                return threat.valid()and self:MonsoonLethal(ally)==true
            end})
        end
    end
    return false
end

function JannaChampion:Clear()
    if not Menu.Clear.Enabled:Value()or IsUnderTurret(myHero)then return end
    if not Core.manaAbove(Menu.Clear.Mana:Value())then return end
    if Menu.Clear.Q:Value()>0 and IsReady(_Q)and not self:IsQCharging()and not self.qAttempt then
        local points=self:FarmPoints(myHero.pos)
        for i=1,math.min(#points,6)do
            local entry=points[i]
            if self:FarmCount(myHero.pos,entry.aim,points)>=Menu.Clear.Q:Value()
                and self:BeginQ(entry.aim,entry.unit,'Clear',2)then return end
        end
    end
    if Menu.Clear.W:Value()and IsReady(_W)then
        local monsters=Core:DecisionUnits('GetMonsters')
        for i=1,math.min(#monsters,16)do if self:CastW(monsters[i])then return end end
    end
end

function JannaChampion:Flee()
    if IsReady(_E)then self:CastE(myHero);return end
    local target=IsReady(_W)and GetTarget(self.WRange+150)
    if IsValid(target)and self:CastW(target)then return end
    local aim=_G.SDK.Input and _G.SDK.Input.PlayerWorld or mousePos
    if IsReady(_Q)and point(aim)then
        local position=Vector(aim)
        if GetDistance(position,myHero.pos)>self.QSpell.Range then position=myHero.pos:Extended(position,self.QSpell.Range)end
        self:BeginQ(position,nil,'Flee',2)
    end
end

function JannaChampion:KillSteal()
    if not IsReady(_W)then return end
    local units=Core:DecisionUnits('GetEnemyHeroes')
    for i=1,math.min(#units,10)do
        local target=units[i]
        if IsValid(target)and target.pos2D.onScreen and GetDistance(target.pos,myHero.pos)<=self:WReach(target)and self:WKills(target)
            and self:CastW(target,function()return self:WKills(target)end)then return end
    end
end

-- Shared kill rule at the missile's arrival (cast time and speed from the profile's sourced row).
function JannaChampion:WKills(target)
    local p=self.profile
    return(Core:Lethal(target,p.wDelay+GetDistance(target.pos,myHero.pos)/p.wSpeed,function()return self:GetWDmg(target)end,{kind='magical'}))
end

function JannaChampion:GetWDmg(target)
    local p=self.profile;local base=p.wBase[myHero:GetSpellData(_W).level]
    if not base then return 0 end
    -- Normal Tailwind: 30 % of bonus movement speed (movement speed above the wiki base 315). Classic has none.
    local tailwind=0
    if p.tailwind and finite(myHero.ms)then tailwind=p.tailwind*math.max(0,myHero.ms-p.baseMoveSpeed)end
    return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+myHero.ap*p.wAP+tailwind)
end

-- Health-bar damage (shared overlay): ready W plus one attack. The tornado's charge-dependent damage is not
-- profiled and is left out.
function JannaChampion:ComboDamage(u)
    local total=IsReady(_W)and self:GetWDmg(u)or 0
    local ok,attack=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
    if ok and finite(attack)then total=total+attack end
    return total
end

-- Development evidence (dev builds only): the own tornado missile after an observed release (speed and reach
-- by charge, Janna-5) and Janna's movement speed at level 1 without items (Tailwind base, Janna-10).
function JannaChampion:TraceEvidence()
    if not Core.logger then return end
    if not self.msTraced and(myHero.levelData and myHero.levelData.lvl==1)then
        local items=0
        for slot=6,11 do local item=myHero.GetItemData and myHero:GetItemData(slot);if item and item.itemID and item.itemID~=0 then items=items+1 end end
        if items==0 then self.msTraced=true;Core:Trace('janna_move_speed',{profile=self.profile.id,ms=myHero.ms,wikiBase=self.profile.baseMoveSpeed})end
    end
    local w=self.qWatch
    if not w then return end
    local now=Game.Timer()
    local count=Game.MissileCount and Game.MissileCount()or 0
    for i=1,math.min(finite(count)and count or 0,64)do
        local m=Game.Missile(i);local d=m and m.missileData
        if d and m.pos and(d.owner==myHero.networkID or d.owner==myHero.handle)and type(d.name)=='string'and d.name:lower():find('howlinggale',1,true)then
            if not w.firstAt then w.firstAt,w.firstX,w.firstZ,w.name=now,m.pos.x,m.pos.z,d.name end
            w.lastAt,w.lastX,w.lastZ,w.speed=now,m.pos.x,m.pos.z,d.speed
        end
    end
    if now>w.expires or w.lastAt and now-w.lastAt>.3 then
        self.qWatch=nil
        Core:Trace('janna_q_missile',{profile=self.profile.id,purpose=w.purpose,charge=w.charge,reach=w.reach,releasedAt=w.releasedAt,
            originX=w.originX,originZ=w.originZ,aimX=w.aimX,aimZ=w.aimZ,name=w.name,firstAt=w.firstAt,firstX=w.firstX,firstZ=w.firstZ,
            lastAt=w.lastAt,lastX=w.lastX,lastZ=w.lastZ,nativeSpeed=w.speed,profileSpeed=self.QSpell.Speed,travelModel=self.profile.qTravel})
    end
end

function JannaChampion:RegisterGuide(guide,settings)
    local nodes={comboQ={node=Menu.Combo.Q,label='Combo tornado'},comboW={node=Menu.Combo.W,label='Combo slow'},
        harassQ={node=Menu.Harass.Q,label='Harass tornado'},harassW={node=Menu.Harass.W,label='Harass slow'},
        farm={node=Menu.Clear.Enabled,label='Spell farming'},farmCount={node=Menu.Clear.Q,label='Minimum Q minions'},
        ultimate={node=Menu.Auto.R,label='Emergency R health'},disengage={node=Menu.Auto.RCount,label='Disengage R'},immobile={node=Menu.Auto.Immobile,label='Tornado on immobile enemies'},
        dash={node=Menu.Auto.AntiDash,label='Approaching dash Q'},empower={node=Menu.Combo.E,label='Combo shield on an attacking ally'}}
    local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
    return guide:Register('champion',{'Janna: quick start','Janna: tornado control','Janna: protection'},function(page)
        if page==1 then return {title=self.profile.id=='classic'and 'Classic Janna'or 'Janna',subtitle='Use your provider mode keys. Defensive assistance runs independently.',cards={
            {'COMBAT','Combo: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..' with [[comboQ]] and [[comboW]]. Harass: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..' with [[harassQ]] and [[harassW]]. Harass respects its mana threshold.'},
            {'FARM','Clear: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..'. Enable [[farm]] with '..settings.key(Menu.Clear.Enabled)..'. [[farmCount]] counts predicted minions along the tornado ray. Jungle W has its own setting.'},
            {'FLEE','Flee: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_FLEE)..'. Shield yourself, slow a reachable enemy, or start a tornado toward your captured cursor aim. Releasing the mode cancels waiting inputs.'}},note='Shields, a lethal W and Q against an enemy channel are always used. Emergency R, [[dash]] and [[empower]] have their own settings.'}end
        if page==2 then return {title='Owned tornado charges',subtitle='You retain control of manual tornadoes and manual early releases.',cards={
            {'START','An accepted input is not a charge. Automatic release requires the observed recast stage and native cast origin and direction attributable to this controller. Missing geometry leaves release to you.'},
            {'RELEASE','The original mode must remain held and its Q setting enabled. Combat release checks the intended victim against the original ray; farming refreshes its hit count. Moving your mouse does not rotate a placed tornado.'},
            {'REACH','An enemy beyond 1100 gets a charged tornado: it is released once the growing reach covers the enemy on the original line, and only when it holds under both known travel speeds. [[immobile]] tornadoes enemies who cannot move until it lands. Exact speed by charge still needs live verification.'}},note='Manual charges and uncertain sends are never replayed. [[dash]] responds to an approaching endpoint, not a dash away.'}end
        return {title='Shields and Monsoon',subtitle='Fresh threats authorize protection. Monsoon preserves its channel.',cards={
            {'SHIELD','A harmless attack on a healthy champion does not spend the shield. The automatic shield checks you, enabled allies and allied turrets for current targeted casts, turret targeting or active damaging debuffs, and champions standing in an enemy spell that Evade tracks. Known lethal attack estimates outrank weaker threats. A vanished threat cancels the queued shield. Evade may also ask for your own shield against a hit it cannot dodge.'},
            {'ULTIMATE','[[ultimate]] is the health limit for you and for enabled allies inside the area, counting a hit already on its way; zero disables it. [[disengage]] pushes away that many enemies diving you, never out of an attack by your own team. During Monsoon the shield is used only to stop a death. An enemy must be next to whoever is low. Emergency R also fires while a tornado charges. Once Monsoon is observed, attacks, movement and interrupting casts are held.'},
            {'PROFILE',self.profile.id=='normal'and 'Normal W uses edge-to-edge range and its own damage values, including Tailwind bonus movement-speed damage.'or 'Classic W uses its own damage and center range. Monsoon spending follows the live spell cost, including Classic high costs. Normal shield, passive and channel values are not borrowed.'}},note='Shield damage prevented, exact enemy spell arrival and safe team-heal knockback planning remain unverified. Manual R remains available.'}
    end,cfg,links,activate)
end

function JannaChampion:Draw()
	if myHero.dead then return end
	if Menu.Draw.Q:Value() and IsReady(_Q) then Draw.Circle(myHero.pos, self.QSpell.Range, 1, Draw.Color(255, 66, 244, 113)) end
	-- The owned tornado while it charges: its observed ray, current reach and width (prepared plan, no search).
	local plan=self.qCharge
	if Menu.Draw.QPath:Value()and plan and plan.origin and plan.aim and self:IsQCharging()then
		local reach=self:QReach(Game.Timer()-plan.started)
		local finish=plan.origin:Extended(plan.aim,reach)
		local a,b=plan.origin:To2D(),finish:To2D()
		local color=Draw.Color(200, 66, 244, 113)
		if type(Draw.Line)=='function'and a and b then Draw.Line(a.x,a.y,b.x,b.y,2,color)end
		Draw.Circle(finish,self.QSpell.Radius,1,color)
	end
	if Menu.Draw.W:Value() and IsReady(_W) then Draw.Circle(myHero.pos, self.WRange, 1, Draw.Color(255, 244, 238, 66)) end
	if Menu.Draw.E:Value() and IsReady(_E) then Draw.Circle(myHero.pos, self.ERange, 1, Draw.Color(255, 66, 229, 244)) end
	if Menu.Draw.R:Value() and IsReady(_R) then Draw.Circle(myHero.pos, self.RRange, 1, Draw.Color(255, 244, 66, 96)) end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:RegisterPolicy({
    damageTypes={W='magical'},
    methods={
        AutoE=function()return {priority='interactive'}end,
        AutoR=function()return {priority='interactive'}end,
        MonsoonE=function()return {priority='interactive'}end,
        TurretE=function()return {priority='interactive'}end,
        Peel=function()return {priority='interactive'}end,
        AutoImmobile=function()return {priority='interactive'}end,
        AntiDash=function()return {priority='interactive'}end,
        Interrupt=function()return {priority='interactive'}end,

        Combo=function()return Core:ModeContext("Combo")end,
        Harass=function()return Core:ModeContext("Harass")end,
        Clear=function()return Core:ModeContext("LaneClear")end,
        Flee=function()return Core:ModeContext("Flee")end,
    },
    costPaid=function(self,q,slot)return slot==_Q and q.owner=='ReleaseQ' and self:IsQCharging() end,
    exceptions={non_interrupting_summoner=true},
    -- Monsoon blocks every cast except the lethal-only shield (MonsoonE), which ends it on purpose.
    channel=function(self,q)return not self:IsChannelingR()or q.owner=='MonsoonE'end,
    validate=function(self,q,slot,resolved)
        if q.owner=='ReleaseQ' then return slot==_Q and self:IsQCharging()end
        if slot==_Q and self:IsQCharging()then return false end
        if slot==_R and q.owner=='AutoR' then return self:RNeeded()end
        if slot==_E and q.owner=='MonsoonE' then return self:IsChannelingR()end
        return true
    end,
})

JannaChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Janna"]="Janna"}
local normalSupported={["Janna"]=true}

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
