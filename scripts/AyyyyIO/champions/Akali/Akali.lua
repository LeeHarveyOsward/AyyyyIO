return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Akali"]=function()return _G.OrbamaFamily:Require("0aee895ba6d79a60302716958779b67a8aabc7edc3024d1081716c569d6e7000")()end
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
modules["combatMechanics"]=_G.OrbamaFamily:Require("fa55d9e58476517c728e6c357b2aca50c3ab206fe6ee2f8725de485a40598eff")
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
if champion=="Akali" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Akali',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.03
-- Values and unresolved host aliases are recorded in CombatProfiles/akali-provenance.json.
local profiles=ChampionProfiles('Akali')
local finite,identity=Core.finite,Core.id


local AkaliChampion=class("AkaliChampion")

function AkaliChampion:__init()
	self.profile=assert(profiles[myHero.charName],'Unsupported Akali profile')
	self.classic=self.profile.id=='classic'
	self.QRange,self.WRange,self.ERange,self.RRange=self.profile.q,self.profile.w,self.profile.e,self.profile.r
	-- The narrow central Q ray is a conservative subset of the fan, not an AOE count.
	self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=10,Range=self.QRange,Speed=math.huge,Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}}
	self.ESpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.4,Radius=60,Range=self.ERange,Speed=1900,Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL}}
	if self.classic then self.QSpell=nil;self.ESpell=nil end
	-- R2 hits are planned inside the shorter of the two dash lengths (profile r2Dash) so no recipient is out of reach.
	self.R2Spell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.125,Radius=45,Range=self.profile.r2Dash and self.profile.r2Dash[1]or 750,Speed=3000,Collision=false}
	self:LoadMenu()
	Core:RegisterCleanup('Akali.RFirst',function(reason)self:EndBurst(reason)end)
	Core:RegisterCleanup('Akali.KillChain',function(reason)self:EndChain(reason)end)
	-- Health-bar damage and KILL marks: ready abilities only, no attacks counted (partial).
	Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
	self:PublishMobility()
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
end

function AkaliChampion:LoadMenu()
	local icon = "http://ddragon.leagueoflegends.com/cdn/16.16.1/img/champion/Akali.png"
	Menu = MenuElement({ type = MENU, id = "Classic_AIO_" .. myHero.charName, name='AyyyyIO - Akali', leftIcon = icon })
	Menu:MenuElement({ type = MENU, id = "Combo", name = "Combo" })
	-- The whole kit: R only for a kill or to close a gap with a follow-up, and every dash
	-- (R, E2) passes the turret, health and enemy-count limits below.
	for _, spell in ipairs({ "Q", "W", "E", "R" }) do
		Menu.Combo:MenuElement({ id = spell, name = "Use " .. spell, value = true })
	end
	if not self.classic then Menu.Combo:MenuElement({id='E2',name='Use E again to dash to the marked enemy',value=true}) end
	Menu.Combo:MenuElement({id='RFirst',name='Open with R, then E',value=false})
	Menu.Combo:MenuElement({id='Weave',name='Attack with a ready empowered attack before casting',value=true,menu=false})
	Menu.Combo:MenuElement({ id = "WHP", name = "Use W below health %", value = 55, min = 0, max = 100, step = 5, menu = false })
	if not self.classic then Menu.Combo:MenuElement({id='WEnergy',name='Use W below energy %',value=25,min=0,max=100,step=5,menu=false}) end
	if self.classic then Menu.Combo:MenuElement({ id = "RReserve", name = "R charges to keep in reserve", value = 1, min = 0, max = 2, step = 1, menu = false }) end
	Menu.Combo:MenuElement({ id = "SafeR", name = "Never dash under an enemy turret", value = true })
	Menu.Combo:MenuElement({id='MobilityHP',name='Never dash in below health %',value=30,min=1,max=100,step=5})
	Menu.Combo:MenuElement({id='MobilityEnemies',name='Never dash into more enemies than',value=2,min=1,max=5,step=1})

	Menu:MenuElement({ type = MENU, id = "Harass", name = "Harass" })
	Menu.Harass:MenuElement({ id = "Q", name = "Use Q", value = true })
	Menu.Harass:MenuElement({ id = "E", name = "Use E", value = true })
	Menu.Harass:MenuElement({ id = "Mana", name = "Only above energy %", value = 40, min = 0, max = 100, step = 5 })

	Menu:MenuElement({ type = MENU, id = "Clear", name = "Farming" })
	Menu.Clear:MenuElement({ id = "Enabled", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(v) CheckChatBlock(Menu.Clear.Enabled, v) end })
	Menu.Clear:MenuElement({ id = "Q", name = "Use Q", value = true })
	if self.classic then Menu.Clear:MenuElement({ id = "E", name = "Units near you for E", value = 3, min = 1, max = 8, step = 1 })end
	Menu.Clear:MenuElement({ id = "Mana", name = "Only above energy %", value = 30, min = 0, max = 100, step = 5 })
	Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
	Menu.LastHit:MenuElement({id='Q',name='Use Q when an attack cannot last hit',value=true})
	Menu.LastHit:MenuElement({id='Mana',name='Only above energy %',value=40,min=0,max=100,step=5})

	Menu:MenuElement({ type = MENU, id = "KillSteal", name = "Finish kills without holding a mode key" })
	for _, spell in ipairs({ "Q", "E", "R" }) do
		Menu.KillSteal:MenuElement({ id = spell, name = "Use " .. spell, value = true })
	end
	if not self.classic then Menu.KillSteal:MenuElement({id='E2',name='Dash with E2 when it kills',value=true})end

	Menu:MenuElement({ type = MENU, id = "Flee", name = "Flee" })
	Menu.Flee:MenuElement({ id = "W", name = "Use W", value = true })
	if self.classic then Menu.Flee:MenuElement({ id = "R", name = "Use R on a unit towards the cursor", value = true }) end

	Menu:MenuElement({ type = MENU, id = "Draw", name = "Drawings" })
	for _, spell in ipairs({ "Q", "W", "E", "R" }) do
		Menu.Draw:MenuElement({ id = spell, name = spell .. " range", value = false })
	end
	Menu.Draw:MenuElement({ id = "Plan", name = "Mark the enemy a combo is aimed at", value = true })
end

function AkaliChampion:ResourcePercent()
	return myHero.maxMana > 0 and myHero.mana / myHero.maxMana * 100 or 100
end

function AkaliChampion:RAmmo()
 local ammo=myHero:GetSpellData(_R).ammo
 return type(ammo)=='number' and ammo>=0 and ammo==math.floor(ammo) and ammo or 0
end

function AkaliChampion:OwnedBuff(target,name)
 local now=Game.Timer()
 for _,buff in ipairs(GetBuffs(target))do
  local expiry=Core.buffExpiry(buff)
  if buff.name and buff.name:lower()==name:lower() and buff.count and buff.count>0 and type(expiry)=='number' and expiry>now
   and Core.mine(buff.source)then return expiry end
 end
end

function AkaliChampion:Marked(target)
 return self.classic and self:OwnedBuff(target,'Jade_AkaliQ')or nil
end

function AkaliChampion:Stage(slot)
 if self.classic then return 1 end
 local name=(myHero:GetSpellData(slot).name or ''):lower()
 local base=slot==_E and 'akalie'or slot==_R and 'akalir'or 'akaliq'
 if name==base then return 1 end
 if name==base..'b'then return 2 end
 return 0
end

function AkaliChampion:InAutoAttackRange(target)
 if _G.SDK.Data and _G.SDK.Data.IsInAutoAttackRange then return _G.SDK.Data:IsInAutoAttackRange(myHero,target)end
 return GetDistance(myHero.pos,target.pos)<=(myHero.range or 125)+(myHero.boundingRadius or 65)+(target.boundingRadius or 65)
end

function AkaliChampion:Weave(target)
 if not Menu.Combo.Weave:Value()or not self:InAutoAttackRange(target)then return false end
 local expiry=self.classic and self:Marked(target)or self:OwnedBuff(myHero,'AkaliPWeapon')
 if not expiry then return false end
 -- Classic: the next attack detonates the owned mark, so it goes to the marked enemy.
 if self.classic then Core:PreferAttack('Akali.Mark',target,.25)end
 local attack=_G.SDK.Attack
 if attack and attack.IsActive and attack:IsActive()then return true end
 if not _G.SDK.Orbwalker:CanAttack()then return false end
 -- A blocked/unobserved attack cannot suppress spells for the entire buff duration.
 local token=tostring(identity(target))..':'..tostring(expiry)
 if self.weaveToken~=token then self.weaveToken=token;self.weaveStarted=Game.Timer()end
 return Game.Timer()-self.weaveStarted<.35 and expiry-Game.Timer()>.2
end

function AkaliChampion:SafePoint(point,safe)
 if not point or type(Game.isWall)~='function' or Game.isWall(point)~=false then return false end
 return not safe or not IsUnderTurret2(point)
end

function AkaliChampion:MobilityConsent(point)
 local health,maxHealth=myHero.health,myHero.maxHealth
 local minimumHP=Menu.Combo.MobilityHP:Value();local maximum=Menu.Combo.MobilityEnemies:Value()
 local radius=650
 if not finite(minimumHP)or minimumHP<0 or minimumHP>100 or not finite(maximum)or maximum<0 or maximum>16
  or maximum~=math.floor(maximum)or not finite(radius)or radius<=0 or radius>2000 then return false end
 if not finite(health)or health<=0 or not finite(maxHealth)or maxHealth<=0 or health/maxHealth*100<minimumHP then return false end
 if not point or not finite(point.x)or not finite(point.z)then return false end
 local list=Core:DecisionUnits('GetEnemyHeroes')
 if type(list)~='table'or #list>16 then return false end
 local count,seen=0,{};radius=radius^2
 for i=1,#list do local enemy=list[i]
  if type(enemy)~='table'and type(enemy)~='userdata'then return false end
  if IsValid(enemy)then
   local id=identity(enemy);local p=enemy.pos
   if not finite(id)or id<=0 or not p or not finite(p.x)or not finite(p.z)then return false end
   if not seen[id]then
    seen[id]=true
    if (p.x-point.x)^2+(p.z-point.z)^2<=radius then count=count+1 end
   end
  end
 end
 -- This is a limit on observed eligible enemies, not evidence that fog is safe.
 return count<=maximum
end

function AkaliChampion:CanR(target,safe,spendReserve)
 if not IsValid(target)or GetDistance(myHero.pos,target.pos)>self.RRange then return false end
 if self.classic then
  return self:RAmmo()>(spendReserve and 0 or Menu.Combo.RReserve:Value())and self:SafePoint(target.pos,safe)and self:MobilityConsent(target.pos)
 end
 if self:Stage(_R)~=1 or target.type~=myHero.type then return false end
 local landing=myHero.pos:Extended(target.pos,715)
 return self:SafePoint(landing,safe)and self:MobilityConsent(landing)
end

-- far=true: the 1500 reach of a recast that kills by itself (Akali-9); every other
-- recast keeps 1000. The landing is the marked enemy either way.
function AkaliChampion:CanE2(target,far)
 if self.classic then return false end
 local expiry=IsValid(target)and self:OwnedBuff(target,'AkaliEMis')
 return Menu.Combo.E2:Value()and self:Stage(_E)==2 and expiry and expiry>Game.Timer()+.15
  and GetDistance(myHero.pos,target.pos)<=(far and self.profile.e2KillRange or self.profile.e2Range)
  and self:SafePoint(target.pos,Menu.Combo.SafeR:Value())and self:MobilityConsent(target.pos)
end

function AkaliChampion:CastPred(key,target,settings,validate,options)
 if not IsValid(target)then return false end
 local pred=Core:Prediction(settings);pred:GetPrediction(target,myHero)
 if not pred:CanHit(target.type==myHero.type and 3 or 2)then return false end
 options=options or {}
 -- The prepared world certificate excludes ordinary dependencies/handoffs.
 -- A dependent follow-up retains the provider's regular final validation path.
 options.prevalidateWorldCast=not options.dependency and not options.handoff
 options.range=settings.Range;options.validate=validate
 return Core:Cast(key,pred.CastPosition,options)
end

function AkaliChampion:CastQ(target,validate,options)
 if self.classic then
  options=options or {};options.range=self.QRange;options.validate=validate
  return Core:Cast(HK_Q,target,options)
 end
 return self:CastPred(HK_Q,target,self.QSpell,function(q,r)
  return self:Stage(_Q)==1 and(not validate or validate(q,r))
 end,options)
end

function AkaliChampion:CastE(target,validate,options,far)
 options=options or {}
 if self.classic then
  options.intentTarget=target;options.range=self.ERange;options.validate=validate
  return Core:Cast(HK_E,nil,options)
 end
 if self:Stage(_E)==2 then
  if not self:CanE2(target,far)then return false end
  options.intentTarget=target;options.range=far and self.profile.e2KillRange or self.profile.e2Range
  options.validate=function(q,r)return self:CanE2(target,far)and(not validate or validate(q,r))end
  return Core:Cast(HK_E,nil,options)
 end
 if self:Stage(_E)~=1 then return false end
 return self:CastPred(HK_E,target,self.ESpell,function(q,r)
   local point=r and r.position;local landing=point and myHero.pos:Extended(Vector(point),-400)
   return self:Stage(_E)==1 and landing and self:SafePoint(landing,Menu.Combo.SafeR:Value())and self:MobilityConsent(landing)
    and(not validate or validate(q,r))
  end,options)
end

function AkaliChampion:CastR(target,spendReserve,validate,options)
 if not self.classic and self:Stage(_R)==2 then
  return self:CastPred(HK_R,target,self.R2Spell,function(q,r)
    return self:Stage(_R)==2 and r and self:R2LandingsSafe(Vector(r.position))
    and(not validate or validate(q,r))
  end,options)
 end
 if not self:CanR(target,Menu.Combo.SafeR:Value(),spendReserve)then return false end
 return Core:Cast(HK_R,target,{range=self.RRange,validate=function(q,r)
  return self:CanR(target,Menu.Combo.SafeR:Value(),spendReserve)and(not validate or validate(q,r))
 end})
end

-- The recast dashes a fixed length toward the aim: the targeter line (750) and the wiki (800) disagree, so both
-- possible end points must pass the turret, terrain and dash limits (profile r2Dash).
function AkaliChampion:R2LandingsSafe(toward)
 local safe=Menu.Combo.SafeR:Value()
 for _,length in ipairs(self.profile.r2Dash or {750})do
  local landing=myHero.pos:Extended(toward,length)
  if not self:SafePoint(landing,safe)or not self:MobilityConsent(landing)then return false end
 end
 return true
end

-- Perfect Execution's first cast (Normal) or Shadow Dance (Classic, conservative bracket) as a dodge for
-- Evade (numbers and source: ChampionProfiles/Akali.lua rDash). It needs an enemy champion and it
-- dashes INTO that enemy, so the same turret, health and enemy-count limits as
-- every other dash apply; Evade only judges whether the travel is safe. Both
-- possible end points are declared and both must be safe (Normal: the plain dash
-- length and the minimum distance past the target; Classic: see EvadeRTargets).
function AkaliChampion:EvadeRAllowed(unit)
 if unit==nil then return self:Stage(_R)==1 end
 if unit.team==myHero.team or unit.type~=myHero.type then return false,'needs_enemy_champion'end
 if not self:CanR(unit,true,false)then return false,'dash_limits'end
 return true
end
function AkaliChampion:EvadeRTargets()
 local dash=self.profile.rDash;local out={}
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(dash.range)
 for i=1,math.min(#list,5)do local u=list[i]
  if identity(u)and self:EvadeRAllowed(u)then
   local d=GetDistance(myHero.pos,u.pos)
   if d>1 then
    -- Normal: the dash length and the minimum distance past the target. Classic (onTarget): on the target and the
    -- asset's DashDistance along the line, whichever the server does.
    local a=dash.onTarget and Vector(u.pos)or myHero.pos:Extended(u.pos,dash.through)
    local b=dash.onTarget and myHero.pos:Extended(u.pos,dash.through)or myHero.pos:Extended(u.pos,math.max(dash.through,d+dash.past))
    if self:SafePoint(a,true)and self:SafePoint(b,true)then
     out[#out+1]={unit=u,id=identity(u),position={x=u.pos.x,y=u.pos.y,z=u.pos.z},landings={{x=a.x,y=a.y,z=a.z},{x=b.x,y=b.y,z=b.z}}}
    end
   end
  end
 end
 return out
end
function AkaliChampion:PublishMobility()
 local dash=self.profile.rDash;if not dash or not Core.RegisterMobility then return end
 self.mobilityPublished=Core:RegisterMobility({kind='unitDash',slot=_R,key=HK_R,name=dash.name,range=dash.range,speeds=dash.speeds,castDelays=dash.castDelays,
  profile=self.profile.id,label='Dodge with R onto an enemy champion',source=dash.source,
  targets=function()return self:EvadeRTargets()end,allowed=function(u)return self:EvadeRAllowed(u)end})
end

function AkaliChampion:EndBurst(reason)
 local plan=self.burst;if not plan then return end;self.burst=nil
 Core:Cancel('Akali.RFirst',reason or 'burst_ended')
 Core.adapter:CancelGroup(plan.group,reason or 'burst_ended')
end

function AkaliChampion:BurstContext(plan)
 return Core:ModeContext('Combo',function()
  return self.burst==plan and Menu.Combo.RFirst:Value()and Menu.Combo.R:Value()and Menu.Combo.E:Value()
 end)
end

function AkaliChampion:BurstTargetValid(plan)
 if not Menu.Combo.RFirst:Value()or not Menu.Combo.R:Value()or not Menu.Combo.E:Value()
  or GetMode()~='Combo'or Core.adapter:Now()>=plan.expires
  or not IsValid(plan.target)or not plan.target.pos2D.onScreen or plan.target.networkID~=plan.targetID then return false end
 local selected=_G.SDK.TargetSelector.Selected
 return not IsValid(selected)or selected.networkID==plan.targetID
end

function AkaliChampion:CanStartBurst(target,prepare)
 if not Menu.Combo.RFirst:Value()or not Menu.Combo.R:Value()or not Menu.Combo.E:Value()or GetMode()~='Combo'
  or not IsReady(_R)or not IsReady(_E)or self:Stage(_R)~=1 or self:Stage(_E)~=1 then return false end
 if prepare and not Core.adapter:ContextValid({owner='Akali.RFirst',type='cast',kind='object',key=HK_R,
  resource='slot:'.._R,target=target,targetID=target and target.networkID,context=Core:ModeContext('Combo')})then return false end
 if not self:CanR(target,Menu.Combo.SafeR:Value(),false)then return false end
 local eCost,rCost=myHero:GetSpellData(_E).mana or 0,myHero:GetSpellData(_R).mana or 0
 if not finite(eCost)or eCost<0 or not finite(rCost)or rCost<0 or not finite(myHero.mana)or myHero.mana<eCost+rCost then return false end
 if self.classic then return true end
 local landing=myHero.pos:Extended(target.pos,715)
 local aim=target.pos
 if prepare then
  -- Initial feasibility is computed before admission/cursor acquisition. The
  -- post-R cast always predicts again from the observed current casting origin.
  local prediction=Core:Prediction(self.ESpell);prediction:GetPrediction(target,{pos=landing})
  if not prediction:CanHit(OrbamaPrediction.HITCHANCE_HIGH)then return false end
  aim=prediction.CastPosition
 end
 local recoil=aim and landing:Extended(Vector(aim),-400)
 return aim and GetDistance(landing,aim)<=self.ERange and recoil
  and self:SafePoint(recoil,Menu.Combo.SafeR:Value())and self:MobilityConsent(recoil)
end

function AkaliChampion:BurstMotionReady()
 local path=myHero.pathing;local cast=myHero.activeSpell
 if not path or path.isDashing~=false or not cast or type(cast.valid)~='boolean'then return false end
 if cast.valid then
  local now=Game.Timer()
  if not finite(cast.startTime)or not finite(cast.castEndTime)or not finite(now)
   or cast.isCharging or now<=cast.castEndTime then return false end
 end
 return true
end

function AkaliChampion:BurstCombo(target)
 local plan=self.burst
 if plan and(not self:BurstTargetValid(plan)or ShouldWait())then self:EndBurst('burst_context_ended');return false end
 if not plan then
  if not self:CanStartBurst(target,true)then return false end
  local expires=Core.adapter:Now()+1200
  plan={target=target,targetID=target.networkID,expires=expires};self.burst=plan
  local context=self:BurstContext(plan)
  plan.group=Core.adapter:CreateGroup('Akali.RFirst',{expires=expires,context=context,resources={'slot:'.._R,'slot:'.._E}})
  if not plan.group then self.burst=nil;return false end
  local accepted=Core:Cast(HK_R,target,{owner='Akali.RFirst',group=plan.group,context=context,
   independent=false,range=self.RRange,ttl=math.min(450,expires-Core.adapter:Now()),
   validate=function()return self.burst==plan and self:BurstTargetValid(plan)and self:CanStartBurst(target,false)end,
   observe=function(q)
    local cast=Core:NativeCast(q,q.spellName)
    return cast and(cast.target==plan.targetID or cast.target==target.handle)and self.burst==plan
   end})
  if not accepted then self:EndBurst('burst_R_refused');return false end
  plan.rID=Core.lastIntent.id;plan.rIntent=Core.lastIntent
  Core:AfterCast(HK_R,function()if self.burst==plan then plan.observed=true end end)
  return true
 end
 local pendingID=plan.eID or plan.rID;local receipt=pendingID and Core.adapter:Poll(pendingID)
 if receipt and(receipt.state=='cancelled_before_send'or receipt.jobCancelled)then self:EndBurst('burst_input_cancelled');return false end
 -- The plan holds the whole tick. Only R seen natively at its recipient lets E
 -- follow; R visibly spent (next stage, cooldown or a charge) without that for
 -- 0.3 s ends the plan instead of holding every other decision to its 1.2 s
 -- deadline. Ordinary Combo then decides afresh; E is not authorized from here.
 if not plan.eID and not plan.observed and receipt and receipt.sentAt then
  if not plan.spentAt and(self:Stage(_R)~=1 or Core:CooldownStarted(plan.rIntent))then plan.spentAt=Game.Timer()end
  if plan.spentAt and Game.Timer()-plan.spentAt>.3 then self:EndBurst('burst_R_recipient_unseen');return false end
 end
 if plan.eID or not plan.observed or not self:BurstMotionReady()then return true end
 -- R cost/readiness are deliberately not checked again after R was observed.
 if not IsReady(_E)or self:Stage(_E)~=1 or GetDistance(myHero.pos,plan.target.pos)>self.ERange then return true end
 local accepted=self:CastE(plan.target,function()
  return self.burst==plan and plan.observed and self:BurstTargetValid(plan)
   and self:BurstMotionReady()
 end,{owner='Akali.RFirst',group=plan.group,dependency=plan.rID,dependencyState='mechanical',
  context=self:BurstContext(plan),independent=false,intentTarget=plan.target,
  ttl=math.min(250,plan.expires-Core.adapter:Now())})
 if accepted then
  plan.eID=Core.lastIntent.id
  Core:AfterCast(HK_E,function()if self.burst==plan then self:EndBurst('burst_E_observed')end end)
 end
 return true
end

-- Two-spell finisher without a mode key (Akali-3): the E recast first, then Q or
-- the R recast once that dash is seen and over. Both steps belong to one owned
-- group; the follow-up asks the kill rule again from where Akali landed, and a
-- recast never seen on that enemy ends the plan without the follow-up.
function AkaliChampion:ChainFollowDamage(target,slot)
 return slot==_Q and self:GetQDmg(target)or self:R2Damage(target)
end

function AkaliChampion:ChainSlot(target)
 if self.classic or not Menu.KillSteal.E:Value()or not Menu.KillSteal.E2:Value()or not IsReady(_E)
  or self:Stage(_E)~=2 or not self:CanE2(target)then return nil end
 local distance=GetDistance(myHero.pos,target.pos);local eCost=myHero:GetSpellData(_E).mana or 0
 for _,slot in ipairs({_Q,_R})do
  local allowed=slot==_Q and Menu.KillSteal.Q:Value()and self:Stage(_Q)==1 or slot==_R and Menu.KillSteal.R:Value()and self:Stage(_R)==2
  local cost=myHero:GetSpellData(slot).mana or 0
  if allowed and IsReady(slot)and finite(cost)and finite(eCost)and myHero.mana>=cost+eCost then
   local impact=.1+distance/1500+(slot==_Q and .25 or .125)
   if Core:Lethal(target,impact,function()return self:GetEDmg(target)+self:ChainFollowDamage(target,slot)end,{kind='magical'})then return slot end
  end
 end
end

function AkaliChampion:EndChain(reason)
 local plan=self.chain;if not plan then return end;self.chain=nil
 Core:Cancel('Akali.KillChain',reason or 'chain_ended')
 if plan.group then Core.adapter:CancelGroup(plan.group,reason or 'chain_ended')end
end

function AkaliChampion:ChainValid(plan)
 return self.chain==plan and Core.adapter:Now()<plan.expires and IsValid(plan.target)and plan.target.networkID==plan.targetID
  and Menu.KillSteal.E:Value()and Menu.KillSteal.E2:Value()
  and(plan.slot==nil or plan.slot==_Q and Menu.KillSteal.Q:Value()or plan.slot==_R and Menu.KillSteal.R:Value())
end

-- Kill secure from the first E (final re-rank killsecure, 2026-10-10): E1 when E1 + the E2 recast, or E1 + E2 + Q,
-- kills and E1 alone does not. Returns true and the follow-up slot (nil: E2 finishes). The recast's cost cannot be
-- read before stage 2, so E's cost is counted twice (conservative; energy regenerated meanwhile is not counted).
-- Every part is weighed at the last hit's impact: E1 flight, the recast dash from the E1 landing 400 behind, then Q.
function AkaliChampion:FirstChainFollow(target)
 if self.classic or not Menu.KillSteal.E:Value()or not Menu.KillSteal.E2:Value()or not IsReady(_E)or self:Stage(_E)~=1
  or not IsValid(target)then return false end
 local distance=GetDistance(myHero.pos,target.pos);local eCost=myHero:GetSpellData(_E).mana or 0
 if distance>self.ERange or not finite(eCost)or myHero.mana<2*eCost then return false end
 local impact=self.ESpell.Delay+distance/self.ESpell.Speed+.1+(distance+400)/1500
 local function both()return self:EDamageAt(target,1)+self:EDamageAt(target,2)end
 if Core:Lethal(target,impact,both,{kind='magical'})then return true,nil end
 if not Menu.KillSteal.Q:Value()or not IsReady(_Q)or self:Stage(_Q)~=1 then return false end
 local qCost=myHero:GetSpellData(_Q).mana or 0
 if not finite(qCost)or myHero.mana<2*eCost+qCost then return false end
 if Core:Lethal(target,impact+.25,function()return both()+self:GetQDmg(target)end,{kind='magical'})then return true,_Q end
 return false
end

-- E1 is planned and sent inside the kill-chain group; the recast waits for E1 seen cast, then for our own AkaliEMis
-- mark on that enemy (bounded by the E1 flight) and asks the kill rule again from the current health; a miss, a
-- target no longer lethal or a consent switched off ends the plan without E2. The E2 -> Q step is the shared one.
function AkaliChampion:StartFirstChain(target)
 local ok,slot=self:FirstChainFollow(target);if not ok then return false end
 local now=Core.adapter:Now();local expires=now+2500
 local plan={target=target,targetID=target.networkID,slot=slot,expires=expires,first=true};self.chain=plan
 plan.context={priority='normal',condition=function()return self:ChainValid(plan)end}
 plan.group=Core.adapter:CreateGroup('Akali.KillChain',{expires=expires,context=plan.context,resources=slot and {'slot:'.._E,'slot:'..slot}or {'slot:'.._E}})
 if not plan.group then self.chain=nil;return false end
 local accepted=self:CastE(target,function()
   if not self:ChainValid(plan)or plan.e1Observed then return false end
   local again,follow=self:FirstChainFollow(target);return again and follow==slot
  end,{owner='Akali.KillChain',group=plan.group,context=plan.context,independent=false,ttl=math.min(400,expires-now)})
 if not accepted then self:EndChain('chain_E1_refused');return false end
 plan.e1ID=Core.lastIntent.id;plan.e1Intent=Core.lastIntent
 Core:AfterCast(HK_E,function()if self.chain==plan and not plan.e1Observed then plan.e1Observed=true;plan.e1At=Game.Timer()end end)
 Core:Trace('akali_kill_chain',{target=plan.targetID,start='E1',follow=slot==_Q and 'E2+Q'or 'E2'})
 return true
end

function AkaliChampion:FirstChainStep(plan)
 local receipt=Core.adapter:Poll(plan.e1ID)
 if receipt and(receipt.state=='cancelled_before_send'or receipt.jobCancelled)then self:EndChain('chain_input_cancelled');return false end
 if not plan.e1Observed then
  if receipt and receipt.sentAt then
   if not plan.e1SpentAt and(self:Stage(_E)~=1 or Core:CooldownStarted(plan.e1Intent))then plan.e1SpentAt=Game.Timer()end
   if plan.e1SpentAt and Game.Timer()-plan.e1SpentAt>.3 then self:EndChain('chain_E1_unseen');return false end
  end
  return true
 end
 local target=plan.target
 if self:Stage(_E)~=2 or not self:OwnedBuff(target,'AkaliEMis')then
  if Game.Timer()-plan.e1At>self.ESpell.Delay+self.ERange/self.ESpell.Speed+.25 then self:EndChain('chain_E1_missed');return false end
  return true
 end
 -- The E1 action keeps the E slot until its post-send hold and cleanup settle; the recast waits for that release.
 if Core.adapter:ResourceAction(Core.adapter:SlotResource(_E),false)then return true end
 if not IsReady(_E)or not self:BurstMotionReady()then return true end
 local q=plan.slot==_Q
 local function lethal()
  if not self:ChainValid(plan)or not self:BurstMotionReady()then return false end
  if q and(not IsReady(_Q)or self:Stage(_Q)~=1 or myHero.mana<(myHero:GetSpellData(_Q).mana or 0))then return false end
  local impact=.1+GetDistance(myHero.pos,target.pos)/1500+(q and .25 or 0)
  return Core:Lethal(target,impact,function()return self:EDamageAt(target,2)+(q and self:GetQDmg(target)or 0)end,{kind='magical'})
 end
 if not lethal()then self:EndChain('chain_E2_not_lethal');return false end
 local accepted=self:CastE(target,lethal,{owner='Akali.KillChain',group=plan.group,dependency=plan.e1ID,dependencyState='mechanical',
  context=plan.context,independent=false,ttl=math.min(300,plan.expires-Core.adapter:Now())},not q)
 if not accepted then self:EndChain('chain_E2_refused');return false end
 plan.eID=Core.lastIntent.id;plan.eIntent=Core.lastIntent
 Core:AfterCast(HK_E,function()if self.chain==plan then if plan.slot then plan.observed=true else self:EndChain('chain_done')end end end)
 return true
end

function AkaliChampion:StartChain(target)
 if not self.classic and self:Stage(_E)==1 then return self:StartFirstChain(target)end
 local slot=self:ChainSlot(target);if not slot then return false end
 local now=Core.adapter:Now();local expires=now+1500
 local plan={target=target,targetID=target.networkID,slot=slot,expires=expires};self.chain=plan
 plan.context={priority='normal',condition=function()return self:ChainValid(plan)end}
 plan.group=Core.adapter:CreateGroup('Akali.KillChain',{expires=expires,context=plan.context,resources={'slot:'.._E,'slot:'..slot}})
 if not plan.group then self.chain=nil;return false end
 local accepted=self:CastE(target,function()return self:ChainValid(plan)and not plan.observed and self:ChainSlot(target)==slot end,
  {owner='Akali.KillChain',group=plan.group,context=plan.context,independent=false,ttl=math.min(400,expires-now)})
 if not accepted then self:EndChain('chain_E2_refused');return false end
 plan.eID=Core.lastIntent.id;plan.eIntent=Core.lastIntent
 Core:AfterCast(HK_E,function()if self.chain==plan then plan.observed=true end end)
 Core:Trace('akali_kill_chain',{target=plan.targetID,follow=slot==_Q and 'Q'or 'R'})
 return true
end

function AkaliChampion:ChainStep()
 local plan=self.chain
 if not self:ChainValid(plan)then self:EndChain('chain_context_ended');return false end
 if plan.first and not plan.eID then return self:FirstChainStep(plan)end
 local pendingID=plan.fID or plan.eID;local receipt=pendingID and Core.adapter:Poll(pendingID)
 if receipt and(receipt.state=='cancelled_before_send'or receipt.jobCancelled)then self:EndChain('chain_input_cancelled');return false end
 if not plan.fID and not plan.observed and receipt and receipt.sentAt then
  if not plan.spentAt and(self:Stage(_E)~=2 or Core:CooldownStarted(plan.eIntent))then plan.spentAt=Game.Timer()end
  if plan.spentAt and Game.Timer()-plan.spentAt>.3 then self:EndChain('chain_E2_unseen');return false end
 end
 if plan.fID or not plan.observed or not plan.slot or not self:BurstMotionReady()then return true end
 local slot,target=plan.slot,plan.target
 local key=slot==_Q and HK_Q or HK_R
 if not IsReady(slot)then return true end
 local function lethal()
  local impact=slot==_Q and .25 or .125+GetDistance(myHero.pos,target.pos)/3000
  return self:ChainValid(plan)and self:BurstMotionReady()and Core:Lethal(target,impact,function()return self:ChainFollowDamage(target,slot)end,{kind='magical'})
 end
 if not lethal()then self:EndChain('chain_follow_not_lethal');return false end
 local options={owner='Akali.KillChain',group=plan.group,dependency=plan.eID,dependencyState='mechanical',
  context=plan.context,independent=false,ttl=math.min(300,plan.expires-Core.adapter:Now())}
 local accepted
 if slot==_Q then accepted=self:CastQ(target,lethal,options)else accepted=self:CastR(target,false,lethal,options)end
 if accepted then
  plan.fID=Core.lastIntent.id
  Core:AfterCast(key,function()if self.chain==plan then self:EndChain('chain_done')end end)
 end
 return true
end

-- Perfect Execution's recast window (Akali-1). The earlier of the self-buff's
-- expiry (alias unverified) and 10 s after the recast stage was first seen.
function AkaliChampion:TrackR2()
 if self.classic then return end
 local now=Game.Timer();local stage=self:Stage(_R)
 if stage==2 then
  if not self.r2Seen then self.r2Seen=now;self.r2Buff=nil end
  if not self.r2Buff then local buff=Core:SelfBuff(myHero,'AkaliR');local ends=buff and Core.buffExpiry(buff)
   if finite(ends)and ends>now then self.r2Buff=ends end end
 elseif self.r2Seen then
  -- Dev recorder: settles the window length and the buff alias from play.
  Core:Trace('akali_r2_window',{seconds=now-self.r2Seen,buffSeconds=self.r2Buff and self.r2Buff-self.r2Seen or nil})
  self.r2Seen=nil;self.r2Buff=nil
 end
end

function AkaliChampion:R2WindowEnd()
 if self.classic or self:Stage(_R)~=2 or not self.r2Seen then return nil end
 local ends=self.r2Seen+self.profile.r2Window
 if self.r2Buff and self.r2Buff<ends then ends=self.r2Buff end
 return ends
end

function AkaliChampion:R2Deadline()
 local ends=self:R2WindowEnd();local now=Game.Timer()
 return ends~=nil and ends>now and ends-now<.6
end

function AkaliChampion:R2Multiplier(target)
 local health=math.min(target.maxHealth,target.health+(target.hpRegen or 0))
 local missing=target.maxHealth>0 and 1-health/target.maxHealth or 0
 return 1+2*math.min(1,math.max(0,missing)/.7)
end

function AkaliChampion:R2Kills(target)
 return Core:Lethal(target,.125+GetDistance(myHero.pos,target.pos)/3000,function()return self:R2Damage(target)end,{kind='magical'})
end

-- R recast recipient (Akali-2): a kill first (weakest), otherwise, only when the
-- window is about to close or the missing-health bonus has at least doubled the
-- damage, the enemy it hurts most. A selected enemy is the only candidate.
function AkaliChampion:R2Pick()
 if self.classic or self:Stage(_R)~=2 then return nil end
 local selected=_G.SDK.TargetSelector.Selected
 local list=IsValid(selected)and selected.team~=myHero.team and {selected}or Core:DecisionUnits('GetEnemyHeroes')
 local rows={}
 for i=1,math.min(#list,5)do local u=list[i]
  if IsValid(u)and u.type==myHero.type and u.pos2D.onScreen and GetDistance(myHero.pos,u.pos)<=self.R2Spell.Range then
   if self:R2LandingsSafe(u.pos)then rows[#rows+1]=u end
  end
 end
 if #rows==0 then return nil end
 local pick=Core:LethalPick(rows,function(u)return self:R2Kills(u)end)
 if pick then return pick,'kill'end
 local deadline=self:R2Deadline();local best,bestDamage
 for i=1,#rows do local u=rows[i]
  if deadline or self:R2Multiplier(u)>=2 then
   local damage=self:R2Damage(u);if not best or damage>bestDamage then best,bestDamage=u,damage end
  end
 end
 return best,best and(deadline and 'expiring'or 'missing_health')
end

function AkaliChampion:CastR2()
 local unit=self:R2Pick();if not unit then return false end
 return self:CastR(unit,false,function()return self:R2Pick()==unit end)
end

-- Any held mode except Flee: a recast about to expire goes to the best enemy in reach.
function AkaliChampion:ExpiringR2()
 if self.classic or not Menu.Combo.R:Value()or not IsReady(_R)or not self:R2Deadline()then return false end
 return self:CastR2()
end

function AkaliChampion:Tick()
 self:TrackR2()
 if ShouldWait()then self:EndBurst('burst_unavailable');self:EndChain('chain_unavailable');return end
 if self.burst then self:BurstCombo();return end
 if self.chain then self:ChainStep();return end
 if IsCasting()or(myHero.pathing and myHero.pathing.isDashing)then return end
 if self:KillSteal()then return end
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then self:Clear()elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end

function AkaliChampion:EnemiesNear(radius)
 local list=Core:DecisionUnits('GetEnemyHeroes');local count,seen=0,{}
 for i=1,math.min(#list,16)do local u=list[i];local id=identity(u)
  if id and not seen[id]and IsValid(u)and GetDistance(myHero.pos,u.pos)<=radius then seen[id]=true;count=count+1 end
 end
 return count
end

-- W (Akali-5): low health or energy with the target close, an observed hit on
-- Akali within half a second while under the health limit, or two enemy
-- champions within 500.
function AkaliChampion:NeedW(target)
 local hp=myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100 or 100
 if IsValid(target)and GetDistance(myHero.pos,target.pos)<=500
  and(hp<=Menu.Combo.WHP:Value()or(not self.classic and self:ResourcePercent()<=Menu.Combo.WEnergy:Value()))then return true end
 if hp<=Menu.Combo.WHP:Value()and Core:AllyThreat(myHero,.5)then return true end
 return self:EnemiesNear(500)>=2
end

function AkaliChampion:CastW(target)
 return Core:Cast(HK_W,myHero.pos,{resolve=function()
  return {position={x=myHero.pos.x,y=myHero.pos.y,z=myHero.pos.z}}
 end,validate=function()return not target or self:NeedW(target)end})
end

function AkaliChampion:ComboTarget()
 local target=GetTarget(not self.classic and self:Stage(_E)==2 and 1000 or math.max(self.ERange,self.RRange))
 -- Preserve a valid explicit selection and provider refusal. Otherwise the live
 -- owned E mark identifies the continuation, not an unrelated selector winner.
 if self.classic or not IsValid(target)or IsValid(_G.SDK.TargetSelector.Selected)or not Menu.Combo.E:Value()
  or not IsReady(_E)or self:Stage(_E)~=2 or self:CanE2(target)then return target end
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,16)do local marked=list[i]
  if IsValid(marked)and marked.pos2D.onScreen and self:CanE2(marked)then return marked end
 end
 return target
end

-- Single-stage finishers through the shared kill rule (Akali-12): impact time,
-- shields, spell protection and cannot-die states. Classic E keeps the lower
-- physical/magical estimate against both shield pools.
function AkaliChampion:CanPriorityFinish(target,slot)
 if not IsValid(target)or not target.pos2D.onScreen or not IsReady(slot)then return false end
 local distance=GetDistance(myHero.pos,target.pos)
 if slot==_E then
  if not Menu.Combo.E:Value()then return false end
  if self.classic then return distance<=self.ERange and Core:Lethal(target,.25,function()return self:GetEDmg(target)end)end
  return self:CanE2(target,true)and Core:Lethal(target,.1+distance/1500,function()return self:GetEDmg(target)end,{kind='magical'})
 end
 if slot==_R and Menu.Combo.R:Value()then
  if self.classic then return self:CanR(target,Menu.Combo.SafeR:Value(),false)and self:RKills(target)end
  return self:Stage(_R)==2 and distance<=self.R2Spell.Range and self:R2Kills(target)
 end
 return false
end

function AkaliChampion:RKills(target)
 if not self.classic and self:Stage(_R)==2 then return self:R2Kills(target)end
 local impact=.25+GetDistance(myHero.pos,target.pos)/(self.classic and 1600 or 1500)
 return Core:Lethal(target,impact,function()return self:GetRDmg(target)end,{kind='magical'})
end

function AkaliChampion:PriorityFinish(target)
 local e,r=self:CanPriorityFinish(target,_E),self:CanPriorityFinish(target,_R)
 local first,second=_E,_R
 if r and(not e or (myHero:GetSpellData(_R).mana or 0)<(myHero:GetSpellData(_E).mana or 0))then first,second=_R,_E end
 for i=1,2 do local slot=i==1 and first or second
  if (slot==_E and e or slot==_R and r)then
   local validate=function()return self:CanPriorityFinish(target,slot)end
   local accepted
   if slot==_E then accepted=self:CastE(target,validate,nil,true)else accepted=self:CastR(target,false,validate)end
   if accepted then return true end
  end
 end
 return false
end

-- Classic mark detonation (Akali-12): with a live owned mark and a ready attack
-- in range, the detonation is confirmed damage for that attack.
function AkaliChampion:MarkDamage(target)
 local mark=self.profile.qMark;local level=myHero:GetSpellData(_Q).level or 0
 if not mark or level<1 or level>5 then return 0 end
 return self:Magic(target,mark.base[level]+mark.ap*myHero.ap)
end

function AkaliChampion:MarkAttackReady(target)
 return self.classic and IsValid(target)and self:Marked(target)~=nil and self:InAutoAttackRange(target)and _G.SDK.Orbwalker:CanAttack()
end

-- The attack takes the kill: the marked enemy gets the attack instead of R or E.
function AkaliChampion:MarkKills(target)
 if not self:MarkAttackReady(target)then return false end
 if not Core:Lethal(target,.3,function()return self:MarkDamage(target)+_G.SDK.Damage:GetAutoAttackDamage(myHero,target,true)end,{attack=true})then return false end
 Core:PreferAttack('Akali.Mark',target,.25)
 return true
end

-- E recast held as a chase tool (Akali-4): while the marked enemy is inside
-- attack range, the mark has more than 0.6 s and the recast alone does not kill.
function AkaliChampion:HoldE2(target)
 if self.classic or self:Stage(_E)~=2 or not IsValid(target)or not self:InAutoAttackRange(target)then return false end
 local expiry=self:OwnedBuff(target,'AkaliEMis')
 if not expiry or expiry-Game.Timer()<=.6 then return false end
 if Core:Lethal(target,.1+GetDistance(myHero.pos,target.pos)/1500,function()return self:GetEDmg(target)end,{kind='magical'})then return false end
 local token=tostring(identity(target))..':'..tostring(expiry)
 if self.e2HoldToken~=token then
  -- Dev recorder: how often a held recast is later cast versus lost to expiry.
  self.e2HoldToken=token;Core:Trace('akali_e2_hold',{target=identity(target),left=expiry-Game.Timer()})
 end
 return true
end

function AkaliChampion:Combo()
 if self.burst then return self:BurstCombo()end
 if self:ExpiringR2()then return true end
 local target=self:ComboTarget()
 if not IsValid(target)or not target.pos2D.onScreen then return end
 if Menu.Combo.RFirst:Value()and self:BurstCombo(target)then return true end
 if Menu.Combo.W:Value()and IsReady(_W)and self:NeedW(target)then
  return self:CastW(target)
 end
 if self:MarkKills(target)then return end
 if self:PriorityFinish(target)then return true end
 local weave=self:Weave(target)
 if Menu.Combo.Q:Value()and IsReady(_Q)and GetDistance(myHero.pos,target.pos)<=self.QRange and not weave and not self:Marked(target)then
  if self:CastQ(target,function()return not self:Marked(target)end)then return true end
 end
 if weave then return end
 if Menu.Combo.E:Value()and IsReady(_E)and not self:HoldE2(target)and(self:CanE2(target)or GetDistance(myHero.pos,target.pos)<=self.ERange)then
  if self:CastE(target,function()return not self:HoldE2(target)end)then return true end
 end
 if Menu.Combo.R:Value()and IsReady(_R)then
  if not self.classic and self:Stage(_R)==2 then return self:CastR2()end
  -- Spend R for lethal damage or actual gap closing with an affordable follow-up.
  local lethal=self:RKills(target)
   local follow=Menu.Combo.Q:Value()and IsReady(_Q)and myHero.mana>=(myHero:GetSpellData(_Q).mana or 0)
  if lethal or(self:Stage(_R)==1 and not self:InAutoAttackRange(target)and(follow or self:Marked(target)))then
   return self:CastR(target,false,function()return self:RKills(target)
    or(self:Stage(_R)==1 and not self:InAutoAttackRange(target)and(self:Marked(target)
      or(Menu.Combo.Q:Value()and IsReady(_Q)and myHero.mana>=(myHero:GetSpellData(_Q).mana or 0))))end)
  end
 end
end

function AkaliChampion:Harass()
 if self:ExpiringR2()then return true end
 if not Core.manaAbove(Menu.Harass.Mana:Value())then return end
 local target=GetTarget(self.QRange)
 if not IsValid(target)or not target.pos2D.onScreen then return end
 if Menu.Harass.Q:Value()and IsReady(_Q)and not self:Marked(target)and not self:Weave(target)then
  if self:CastQ(target,function()return not self:Marked(target)end)then return true end
 end
 -- Harass never follows E2 into the enemy. Normal E1 still validates its recoil.
 if Menu.Harass.E:Value()and IsReady(_E)and self:Stage(_E)==1 and GetDistance(myHero.pos,target.pos)<=self.ERange then return self:CastE(target)end
end

function AkaliChampion:FarmAllowed(lastHit)
 local menu=lastHit and Menu.LastHit or Menu.Clear
 return(lastHit and menu.Q:Value()or not lastHit and menu.Enabled:Value())and Core.manaAbove(menu.Mana:Value())and not IsUnderTurret(myHero)
end

function AkaliChampion:QRescueClear(target)
 -- Native discovery is required here: original GG can retain a minion list
 -- through a new spawn, even inside a fresh mechanical validator.
 if not Game.MinionCount or not Game.Minion then return false end
 local count=Game.MinionCount()
 if type(count)~='number'or count<0 or count>128 then return false end
 for i=1,count do local u=Game.Minion(i)
  if IsValid(u)and u.team~=myHero.team and u.networkID~=target.networkID then
   local path=u.pathing
   local stationary=path and path.hasMovePath==false and path.isDashing==false
   if not stationary and type(u.ms)~='number'then return false end
   local motion=stationary and 0 or math.max(u.ms or 0,path and path.dashSpeed or 0)*.25
   if GetDistance(myHero.pos,u.pos)<=self.profile.qHitRange+(u.boundingRadius or 80)+motion then return false end
  end
 end
 return true
end

function AkaliChampion:CanRescue(target,lastHit)
 if not self:FarmAllowed(lastHit)or not IsValid(target)or target.type~=Obj_AI_Minion or target.team==300 or target.team==myHero.team
  or GetDistance(myHero.pos,target.pos)>self.QRange then return false end
 if _G.SDK.Attack and _G.SDK.Attack:IsActive()then return false end
 local impact=.25+(self.classic and GetDistance(myHero.pos,target.pos)/1000 or 0)
 local damage=self:GetQDmg(target);local shield=target.shieldAP or 0
 if target.health+shield+math.max(0,target.hpRegen or 0)*impact>damage then return false end
 local health=_G.SDK.HealthPrediction:GetPrediction(target,impact)
 if health<=0 or health+shield>damage then return false end
 if self:InAutoAttackRange(target)and _G.SDK.Orbwalker:CanAttack()then
  local damage=_G.SDK.Damage:GetAutoAttackDamage(myHero,target,true)
  if damage>=target.health+(target.shieldAD or 0)then return false end
 end
 -- Normal Q affects a fan: Last Hit refuses nearby living neighbours rather than soften a wave.
 if not self.classic and not self:QRescueClear(target)then return false end
 return true
end

function AkaliChampion:LastHit()
 if self:ExpiringR2()then return true end
 if not self:FarmAllowed(true)or not IsReady(_Q)then return end
 local list=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#list,32)do local target=list[i]
  if self:CanRescue(target,true)and self:CastQ(target,function()return self:CanRescue(target,true)end)then return true end
 end
end

function AkaliChampion:NearbyFarm()
 local count,seen=0,{}
 for _,method in ipairs({'GetEnemyMinions','GetMonsters'})do
  local list=Core:DecisionUnits(method)
  for i=1,math.min(#list,32)do local u=list[i];local id=identity(u)
   if id and not seen[id]and IsValid(u)and GetDistance(myHero.pos,u.pos)<=self.ERange then count=count+1;seen[id]=true end
  end
 end
 return count
end

-- Normal LaneClear Q fan (Akali-7). One bounded preparation: lane minions in
-- reach, each weighed by whether Q kills it at impact. A cast needs two kills,
-- or three minions hit while no ready attack has a kill to take first.
function AkaliChampion:InFan(origin,aim,u)
 local fan=self.profile.qFan
 local dx,dz=aim.x-origin.x,aim.z-origin.z;local ux,uz=u.pos.x-origin.x,u.pos.z-origin.z
 local length,distance=math.sqrt(dx*dx+dz*dz),math.sqrt(ux*ux+uz*uz)
 if length<1 or distance>fan.range+(u.boundingRadius or 0)then return false end
 if distance<1 then return true end
 return(dx*ux+dz*uz)/(length*distance)>=math.cos(math.rad(fan.angle/2))
end

function AkaliChampion:AttackKillPending()
 if not _G.SDK.Orbwalker:CanAttack()then return false end
 local list=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#list,32)do local u=list[i]
  if IsValid(u)and self:InAutoAttackRange(u)and _G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)>=u.health+(u.shieldAD or 0)then return true end
 end
 return false
end

function AkaliChampion:FanCount(aim)
 local list=Core:DecisionUnits('GetEnemyMinions');local origin=myHero.pos;local kills,hits=0,0
 for i=1,math.min(#list,32)do local u=list[i]
  if IsValid(u)and u.team~=300 and u.team~=myHero.team and self:InFan(origin,aim,u)then
   hits=hits+1
   if Core:Lethal(u,.25,function()return self:GetQDmg(u)end)then kills=kills+1 end
  end
 end
 return kills,hits
end

function AkaliChampion:FanWorth(kills,hits,attackKill)
 return kills>=2 or hits>=3 and not attackKill
end

function AkaliChampion:FanQ()
 if self.classic or not Menu.Clear.Q:Value()or not IsReady(_Q)or self:Stage(_Q)~=1 then return false end
 local list=Core:DecisionUnits('GetEnemyMinions');local points={};local fan=self.profile.qFan
 for i=1,math.min(#list,32)do local u=list[i]
  if #points<24 and IsValid(u)and u.team~=300 and u.team~=myHero.team and GetDistance(myHero.pos,u.pos)<=fan.range then
   points[#points+1]={x=u.pos.x,z=u.pos.z,unit=u,weight=Core:Lethal(u,.25,function()return self:GetQDmg(u)end)and 10 or 1}
  end
 end
 if #points<2 then return false end
 local aim=Core:BestAim(points,{kind='cone',angle=fan.angle,range=fan.range})
 if not aim then return false end
 local direction=myHero.pos:Extended(Vector(aim.x,myHero.pos.y,aim.z),math.min(400,self.QRange))
 aim={x=direction.x,y=direction.y,z=direction.z}
 local attackKill=self:AttackKillPending()
 local kills,hits=self:FanCount(aim)
 if not self:FanWorth(kills,hits,attackKill)then return false end
 return Core:Cast(HK_Q,aim,{range=self.QRange,validate=function()
  if not self:FarmAllowed(false)or self:Stage(_Q)~=1 then return false end
  local k,h=self:FanCount(aim);return self:FanWorth(k,h,self:AttackKillPending())
 end})
end

-- Classic LaneClear (Akali-8): the next attack detonates an owned mark on a
-- minion; Q marks a ranged minion inside attack range that survives Q and the
-- detonation, so both land.
function AkaliChampion:DetonateMinionMark()
 local list=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#list,32)do local u=list[i]
  if IsValid(u)and self:InAutoAttackRange(u)and self:Marked(u)then Core:PreferAttack('Akali.Mark',u,.25);return true end
 end
 return false
end

function AkaliChampion:CanMarkMinion(u)
 return self.classic and IsValid(u)and u.type==Obj_AI_Minion and u.team~=300 and u.team~=myHero.team
  and(u.range or 0)>=300 and self:InAutoAttackRange(u)and GetDistance(myHero.pos,u.pos)<=self.QRange
  and not self:Marked(u)and u.health>self:GetQDmg(u)+self:MarkDamage(u)
end

function AkaliChampion:MarkMinionQ()
 if not Menu.Clear.Q:Value()or not IsReady(_Q)then return false end
 local list=Core:DecisionUnits('GetEnemyMinions');local best
 for i=1,math.min(#list,32)do local u=list[i]
  if self:CanMarkMinion(u)and(not best or u.maxHealth>best.maxHealth)then best=u end
 end
 if not best then return false end
 return Core:Cast(HK_Q,best,{range=self.QRange,validate=function()return self:FarmAllowed(false)and self:CanMarkMinion(best)end})
end

function AkaliChampion:Clear()
 if self:ExpiringR2()then return true end
 if not self:FarmAllowed(false)then return end
 if self.classic then self:DetonateMinionMark()end
 if self.classic and IsReady(_E)and self:NearbyFarm()>=Menu.Clear.E:Value()then
  return Core:Cast(HK_E,nil,{validate=function()return self:FarmAllowed(false)and self:NearbyFarm()>=Menu.Clear.E:Value()end})
 end
 if not Menu.Clear.Q:Value()or not IsReady(_Q)then return end
 local list=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#list,32)do local target=list[i]
  if self:CanRescue(target,false)and self:CastQ(target,function()return self:CanRescue(target,false)end)then return true end
 end
 if GetMode()=='LaneClear'and _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR]then
  if self.classic then if self:MarkMinionQ()then return true end
  elseif self:FanQ()then return true end
 end
 local best;list=Core:DecisionUnits('GetMonsters')
 for i=1,math.min(#list,32)do local u=list[i]
  if IsValid(u)and GetDistance(myHero.pos,u.pos)<=self.QRange and(not best or u.maxHealth>best.maxHealth)then best=u end
 end
 if best then return self:CastQ(best,function()return self:FarmAllowed(false)end)end
end

function AkaliChampion:Flee()
 if Menu.Flee.W:Value()and IsReady(_W)then return self:CastW()end
 if not self.classic or not Menu.Flee.R:Value()or not IsReady(_R)then return end
 local best,bestDistance=nil,GetDistance(myHero.pos,mousePos)-100
 for _,method in ipairs({'GetEnemyHeroes','GetEnemyMinions','GetMonsters'})do
  local list=Core:DecisionUnits(method)
  for i=1,math.min(#list,32)do local unit=list[i]
   if self:CanR(unit,true,false)and GetDistance(unit.pos,mousePos)<bestDistance then best=unit;bestDistance=GetDistance(unit.pos,mousePos)end
  end
 end
 if best then return Core:Cast(HK_R,best,{validate=function()return self:CanR(best,true,false)
  and GetDistance(best.pos,mousePos)+100<GetDistance(myHero.pos,mousePos)end})end
end


function AkaliChampion:KillSteal()
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,16)do local target=list[i]
  if IsValid(target)and target.pos2D.onScreen then
   local distance=GetDistance(myHero.pos,target.pos)
   -- The shared kill rule: health on arrival, magic shields, spell protection.
   -- Classic E's damage type is unresolved, so it is weighed against both shield pools.
   local function kills(spell,impact,damage,kind,now)
    return function()return Menu.KillSteal[spell]:Value()and Core:Lethal(target,impact,damage,{kind=kind,now=now})end
   end
   if Menu.KillSteal.Q:Value()and IsReady(_Q)and distance<=self.QRange then
    local lethal=kills('Q',.25+(self.classic and distance/1000 or 0),function()return self:GetQDmg(target)end,'magical')
    if lethal()and self:CastQ(target,lethal)then return true end
   end
   local recast=not self.classic and self:Stage(_E)==2
   if Menu.KillSteal.E:Value()and(not recast or Menu.KillSteal.E2:Value())and IsReady(_E)and(distance<=self.ERange or self:CanE2(target,true))then
    local lethal=kills('E',recast and .1+distance/1500 or .25,function()return self:GetEDmg(target)end,not self.classic and 'magical'or nil)
    if lethal()and self:CastE(target,lethal,nil,true)then return true end
   end
   if Menu.KillSteal.R:Value()and IsReady(_R)then
    -- A kill is worth a reserved Classic charge (a takedown returns one), but a
    -- charge that only the kill refunds is spent on current health alone, never
    -- on someone else's hit landing first.
    local reserved=self.classic and self:RAmmo()<=Menu.Combo.RReserve:Value()
    local lethal=kills('R',.25,function()return self:GetRDmg(target)end,'magical',reserved or nil)
    if lethal()and self:CastR(target,self.classic,lethal)then return true end
   end
   if self:StartChain(target)then return true end
  end
 end
end

function AkaliChampion:Magic(target,damage)
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,damage,true)
end

function AkaliChampion:GetQDmg(target)
 local level=myHero:GetSpellData(_Q).level;if level==0 then return 0 end
 return self:Magic(target,({45,70,95,120,145})[level]+myHero.ap*self.profile.qAP+(self.classic and 0 or .65*myHero.totalDamage))
end

function AkaliChampion:GetEDmg(target)
 local level=myHero:GetSpellData(_E).level;if level==0 then return 0 end
 if self.classic then
  -- Jade E's damage type is unresolved. Use the lower resistance result for lethal decisions.
  local raw=({30,55,80,105,130})[level]+myHero.totalDamage*.6+myHero.ap*.4
  return math.min(self:Magic(target,raw),_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw,true))
 end
 return self:EDamageAt(target,self:Stage(_E))
end

-- Normal E damage of a given stage (1: the shuriken's 30 %, 2: the recast's 70 %).
function AkaliChampion:EDamageAt(target,stage)
 local level=myHero:GetSpellData(_E).level;if self.classic or level==0 or stage~=1 and stage~=2 then return 0 end
 return self:Magic(target,(70*level+myHero.totalDamage+myHero.ap*self.profile.eAP)*(stage==2 and .7 or .3))
end

function AkaliChampion:GetRDmg(target)
 local level=myHero:GetSpellData(_R).level;if level==0 then return 0 end
 if self.classic then return self:Magic(target,({100,175,250})[level]+myHero.ap*.5)end
 if self:Stage(_R)==1 then return self:Magic(target,110*level+.5*(myHero.bonusDamage or 0)+.3*myHero.ap)end
 if self:Stage(_R)==2 then return self:R2Damage(target)end
 return 0
end

-- The recast's damage at the target's current missing health (either stage).
function AkaliChampion:R2Damage(target)
 local level=myHero:GetSpellData(_R).level;if self.classic or level==0 then return 0 end
 return self:Magic(target,(70*level+.3*myHero.ap)*self:R2Multiplier(target))
end

-- Ready abilities only (Akali-6, shared health-bar display): Q, the whole E
-- (both casts when the first is ready), R (Normal: both casts when the first
-- is ready), a live Classic mark. No attacks.
function AkaliChampion:ComboDamage(u)
 if not IsValid(u)then return 0 end
 local damage=0
 if IsReady(_Q)then damage=damage+self:GetQDmg(u)end
 if IsReady(_E)then
  local level=myHero:GetSpellData(_E).level
  if self.classic or self:Stage(_E)==2 then damage=damage+self:GetEDmg(u)
  elseif self:Stage(_E)==1 and level>0 then damage=damage+self:Magic(u,70*level+myHero.totalDamage+myHero.ap*self.profile.eAP)end
 end
 if IsReady(_R)then
  damage=damage+self:GetRDmg(u)
  if not self.classic and self:Stage(_R)==1 then damage=damage+self:R2Damage(u)end
 end
 if self.classic and self:Marked(u)then damage=damage+self:MarkDamage(u)end
 return damage
end

function AkaliChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},e={node=Menu.Combo.E,label='Combo E'},r={node=Menu.Combo.R,label='Combo R'},
  safe={node=Menu.Combo.SafeR,label='R turret safety'},farm={node=Menu.Clear.Enabled,label='Spell farming'},last={node=Menu.LastHit.Q,label='Last Hit Q'},
  burst={node=Menu.Combo.RFirst,label='R then E opener'},limits={node=Menu.Combo.MobilityHP,label='Dash health and enemy limits'}}
 if not self.classic then nodes.e2={node=Menu.Combo.E2,label='Follow E mark'}end
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Akali: controls','Akali: combat','Akali: farming'},function(page)
  if page==1 then return {title=self.classic and 'Classic Akali'or 'Akali',subtitle='Use the provider mode bindings.',cards={
    {'COMBO','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..'. [[q]], [[e]] and [[r]] have separate controls. R is spent for a kill or to close the gap when Q can follow. Optional [[burst]] waits for R on the same recipient and its dash end, then checks E from your current position. Releasing Combo ends unsent steps.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. Releasing a mode cancels its waiting spells.'},
   {'FLEE','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_FLEE)..'. W can cover your position. '..(self.classic and 'R follows a unit toward the current cursor and preserves your reserve.'or 'E and R movement remain manual in Flee.')}}}end
  if page==2 then return {title='Marks, attacks and dashes',cards={
    {'WEAVING','Combo allows a ready attack a short opportunity to consume an owned passive or Q mark. It does not disable your attacks or wait indefinitely. A lethal single-stage E or R is cast before other spells; it credits no hypothetical follow-up attacks.'},
   {'DASHES',self.classic and 'Combo and Flee keep one R charge in reserve. A killing R without a mode key may spend a reserved charge. [[safe]] applies again before send.'or '[[e2]] needs a live mark attributed to you on the same target. R1 targets a champion; R2 uses predicted aim and missing-health damage. [[safe]] checks the dash endpoint.'},
    {'EVIDENCE','A sent spell is not a confirmed hit. An unknown or expired mark cannot authorize a follow-up. [[limits]] check your HP and known enemies at a dash landing; fog can still hide threats.'}},note=self.classic and 'Classic E damage type remains unresolved; lethal checks use the lower physical or magical estimate.'or 'Q aims the narrow center of the fan. E during an R dash, shroud-anchor E2 and automatic passive-ring movement require further mechanic verification.'}end
  return {title='Farming',cards={
   {'CLEAR','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..' with [[farm]] enabled. Q rescues minions or targets a camp unit. Classic E needs the configured nearby count.'},
   {'LAST HIT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT)..' with [[last]] enabled. Q preserves a ready lethal attack and refuses a minion already dying to incoming damage.'},
   {'NORMAL Q','Normal Last Hit refuses nearby living minions to avoid softening the wave with the fan. Rank five adds no removed minion damage bonus.'}}}
 end,cfg,links,activate)
end

function AkaliChampion:Draw()
	if myHero.dead then return end
	if Menu.Draw.Q:Value() and IsReady(_Q) then Draw.Circle(myHero.pos, self.QRange, 1, Draw.Color(255, 66, 244, 113)) end
	if Menu.Draw.W:Value() and IsReady(_W) then Draw.Circle(myHero.pos, self.WRange, 1, Draw.Color(255, 244, 238, 66)) end
	if Menu.Draw.E:Value() and IsReady(_E) then Draw.Circle(myHero.pos, self.ERange, 1, Draw.Color(255, 66, 229, 244)) end
	if Menu.Draw.R:Value() and IsReady(_R) then Draw.Circle(myHero.pos, self.RRange, 1, Draw.Color(255, 244, 66, 96)) end
	-- The committed plan only (no search): R-then-E opener or the two-spell finisher.
	local plan = self.burst or self.chain
	if Menu.Draw.Plan:Value() and plan and IsValid(plan.target) then
		Draw.Circle(plan.target.pos, 120, 2, Draw.Color(255, 255, 60, 60))
		Draw.Text(self.chain and "Finishing" or "R then E", 14, plan.target.pos2D.x - 30, plan.target.pos2D.y - 70, Draw.Color(255, 255, 90, 90))
	end
end


-- Explicit request context. Nested helpers retain the triggering mode.
Core:RegisterPolicy({
 damageTypes={Q='magical',E='magical',R='magical'},
 methods={Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
  Clear=function()return Core:ModeContext('LaneClear')end,LastHit=function()return Core:ModeContext('LastHit')end,
  Flee=function()return Core:ModeContext('Flee')end},
 exceptions={non_interrupting_summoner=true},
 channel=function()return not Core:SelfChanneling()end,
 validate=function(self,q,slot)
  if myHero.pathing and myHero.pathing.isDashing then return false end
  if not self.classic and q.owner=='KillSteal' and slot==_E and self:Stage(_E)==2 and not Menu.KillSteal.E2:Value()then return false end
  if slot==_E and self.classic and q.object then
   if GetDistance(myHero.pos,q.object.pos)>self.ERange then return false end
   if q.owner=='KillSteal' then return self:GetEDmg(q.object)>=q.object.health+(q.object.hpRegen or 0)+math.max(q.object.shieldAP or 0,q.object.shieldAD or 0)end
  end
  return true
 end,
})

AkaliChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Akali"]="Akali"}
local normalSupported={["Akali"]=true}

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
