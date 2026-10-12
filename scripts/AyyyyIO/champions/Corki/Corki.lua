return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Corki"]=function()return _G.OrbamaFamily:Require("67c4d820aee2d3e2f8d8c11a3f7d8ddc6104eb5d898d061ea89aa04e58bd212c")()end
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
if champion=="Corki" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Corki',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.03

-- Exact identities select mechanics. See docs/FAMILY-CORKI.md and corki-provenance.json.
local profiles=ChampionProfiles('Corki')
local CorkiChampion=class("CorkiChampion")
function CorkiChampion:__init()
 self.profile=assert(profiles[myHero.charName],'Unsupported Corki profile')
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=.25,Radius=self.profile.qRadius,Range=self.profile.qRange,
  Speed=self.profile.qSpeed,Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}}
 self.ESpell={Range=self.profile.eRange}
 self.R1Spell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.175,Radius=40,Range=self.profile.rRange,Speed=2000,
  Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}}
 self.R2Spell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.175,Radius=40,Range=self.profile.bigRange,Speed=2000,
  Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}}
 self:LoadMenu()
 Callback.Add('Draw',function()self:Draw()end)
 Callback.Add('Tick',function()self:Tick()end)
 _G.SDK.Orbwalker:OnPreAttack(function(args)self:OnPreAttack(args)end)
 -- Valkyrie as an Evade dash: the danger is Evade's judgement, the landing rules are this controller's.
 local p=self.profile
 self.mobilityOffered,self.mobilityReason=Core:RegisterMobility({kind='dash',slot=_W,key=HK_W,name=p.wName,range=p.wRange,
  speeds={p.wSpeed},castDelays={p.wCast},profile=p.id,label='Valkyrie',source=p.wSource,
  allowed=function(point)if point~=nil and not self:LandingSafe(point)then return false,'landing_unknown_turret_or_enemy'end;return true end})
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
end

function CorkiChampion:LoadMenu()
	local championIcon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/".."Corki.png"
	Menu = MenuElement({type = MENU, id = "Classic_AIO_"..myHero.charName, name='AyyyyIO - Corki', leftIcon = championIcon})

	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "R", name = "Use R", toggle = true, value = true})

	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "R", name = "Use R", toggle = true, value = true})
	-- Normal holds 4 missiles: a reserve of 3 would allow Harass R only at a full stock.
	Menu.Harass:MenuElement({id = "Rammo", name = "R missiles to keep in reserve", value = self.profile.id=='normal'and 1 or 3, min = 0, max = self.profile.maxAmmo, step = 1})
	Menu.Harass:MenuElement({id='Mana',name='Only above mana %',value=40,min=0,max=100,step=5})

	Menu:MenuElement({type = MENU, id = "Clear", name = "Farming"})
	Menu.Clear:MenuElement({id = "SpellFarm", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(newValue)
		if CheckChatBlock(Menu.Clear.SpellFarm, newValue) then return end
	end})
	Menu.Clear:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
	Menu.Clear:MenuElement({id = "SpellHarass", name = "Harass enemy champions while lane clearing", value = true})
	Menu.Clear:MenuElement({type = MENU, id = "LaneClear", name = "Lane clear"})
	Menu.Clear.LaneClear:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Clear.LaneClear:MenuElement({id = "QCount", name = "Minions Q must hit", value = 2, min = 1, max = 6, step = 1})
	-- Lane E needs the cone angle; Classic's is unmeasured, so Classic does not offer it.
	if self.profile.eAngle then
		Menu.Clear.LaneClear:MenuElement({id = "E", name = "Use E when attacking into a group of minions", value = true})
		Menu.Clear.LaneClear:MenuElement({id = "ECount", name = "Minions E must reach", value = 3, min = 1, max = 6, step = 1, menu = false})
	end
	-- Lane R counts minions inside the missile's splash, so it needs the profile's splash radius.
	if self.profile.splash then
		Menu.Clear.LaneClear:MenuElement({id = "R", name = "Use R", toggle = true, value = true})
		Menu.Clear.LaneClear:MenuElement({id = "RCount", name = "Minions R must hit", value = 2, min = 1, max = 6, step = 1})
		Menu.Clear.LaneClear:MenuElement({id = "Rammo", name = "R missiles to keep in reserve", value = self.profile.id=='normal'and 2 or 3, min = 0, max = self.profile.maxAmmo, step = 1})
	end
	Menu.Clear:MenuElement({type = MENU, id = "JungleClear", name = "Jungle clear"})
	Menu.Clear.JungleClear:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Clear.JungleClear:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	Menu.Clear.JungleClear:MenuElement({id = "R", name = "Use R", toggle = true, value = true})

	Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
	Menu.LastHit:MenuElement({id='Q',name='Use Q when an attack cannot last hit',value=true})
	Menu.LastHit:MenuElement({id='R',name='Use R on cannons, or any minion at full missiles',value=true})
	Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
	Menu:MenuElement({type = MENU, id = "Misc", name = "Behaviour"})
	Menu.Misc:MenuElement({id = "SemiR", name = "Cast R at the selected target", key = string.byte("T")})
	Menu.Misc:MenuElement({id='EscapeW',name='Escape with W towards the cursor',key=string.byte('U')})
	Menu.Misc:MenuElement({id='KillR',name='Finish kills with R or Q without a mode key',value=true})
	Menu.Misc:MenuElement({id = "Qcc", name = "Q and R immobilised enemies without a mode key", toggle = true, value = true})
	Menu.Misc:MenuElement({id='DefensiveW',name='W away from enemies that dash at you when hurt',value=true})
	Menu.Misc:MenuElement({id='DefensiveHP',name='That W only below health %',value=60,min=10,max=100,step=5,menu=false})

	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "Q", name = "Q range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "E", name = "E range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "R", name = "R range", toggle = true, value = false})
end


function CorkiChampion:BigOne()
 for _,buff in ipairs(GetBuffs(myHero))do
  local expiry=Core.buffExpiry(buff)
  if buff.name and buff.name:lower()==self.profile.bigBuff and buff.count and buff.count>0
   and type(expiry)=='number' and expiry>Game.Timer()then return true end
 end
 return false
end
function CorkiChampion:RSpell()return self:BigOne()and self.R2Spell or self.R1Spell end
function CorkiChampion:AmmoAllowed(reserve)
 local ammo=myHero:GetSpellData(_R).ammo
 return type(ammo)=='number'and ammo==math.floor(ammo)and ammo>math.max(0,reserve or 0)
end
function CorkiChampion:ManaAllowed(menu)
 return not menu.Mana or Core.manaAbove(menu.Mana:Value())
end
function CorkiChampion:QDamage(target)
 local base=self.profile.qBase[myHero:GetSpellData(_Q).level];if not base then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,
  base+self.profile.qAP*(myHero.ap or 0)+self.profile.qBonusAD*(myHero.bonusDamage or 0),true,false)
end
function CorkiChampion:RDamage(target)
 local base=self.profile.rBase[myHero:GetSpellData(_R).level];if not base then return 0 end
 local raw=base+self.profile.rBonusAD*(myHero.bonusDamage or 0)+self.profile.rTotalAD*(myHero.totalDamage or 0)+self.profile.rAP*(myHero.ap or 0)
 if self:BigOne()then raw=raw*self.profile.rMultiplier end
 return _G.SDK.Damage:CalculateDamage(myHero,target,self.profile.rDamage=='physical'and _G.SDK.DAMAGE_TYPE_PHYSICAL or _G.SDK.DAMAGE_TYPE_MAGICAL,raw,true,false)
end
-- Never turn an attack attempt into a recharge refund. Host ammo/readiness remain authoritative.
function CorkiChampion:OnPreAttack(args)
 local target=args and args.Target;local mode=GetMode()
 if args and args.Process==false then return end
 if mode=='LaneClear'then return self:LaneE(target)end
 local menu=mode=='Combo'and Menu.Combo or mode=='Harass'and Menu.Harass
 if not menu or not IsValid(target)or target.type~=Obj_AI_Hero
  or not menu.E:Value()or not self:ManaAllowed(menu)or not IsReady(_E)or GetDistance(target.pos,myHero.pos)>self.ESpell.Range
  or menu==Menu.Harass and not self:WReserve(_E)then return end
 Core:Cast(HK_E,nil,{intentTarget=target,range=self.ESpell.Range,validate=function()
  return menu.E:Value()and self:ManaAllowed(menu)and GetDistance(target.pos,myHero.pos)<=self.ESpell.Range
   and(menu~=Menu.Harass or self:WReserve(_E))
 end})
end
-- Valkyrie reserve (TRUSt "save mana for W"): outside Combo and finishers, a Q,
-- E or R that would leave less mana than W costs is refused while W is learned
-- and comes off cooldown within 3 s. Host costs; no switch.
function CorkiChampion:WReserve(slot)
 local w=myHero:GetSpellData(_W)
 if not w or(w.level or 0)<1 then return true end
 return(Core:Affordable(slot,{_W},3))
end
-- Lane E (Normal): the attack goes into a group; the gun's cone toward the
-- attack target must reach at least the configured number of minions that
-- survive this attack (health forecast). Classic's cone angle is unmeasured.
function CorkiChampion:LaneECount(target)
 local p=self.profile;if not p.eAngle or not IsValid(target)then return 0 end
 local origin=myHero.pos;local dx,dz=target.pos.x-origin.x,target.pos.z-origin.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<1 then return 0 end
 dx,dz=dx/length,dz/length
 local cosHalf=math.cos(math.rad(p.eAngle/2));local list=Core:DecisionUnits('GetEnemyMinions');local count,seen=0,{}
 for i=1,math.min(#list,32)do local u=list[i]
  if IsValid(u)and u.team~=300 and u.networkID and not seen[u.networkID]then
   local ux,uz=u.pos.x-origin.x,u.pos.z-origin.z;local d=math.sqrt(ux*ux+uz*uz)
   if d<=p.eRange and(d<1 or(ux*dx+uz*dz)/d>=cosHalf)then
    seen[u.networkID]=true
    local hp=Core:UnshieldedLegacyForecast(u,.5)
    if Core.finite(hp)and hp>0 and(u~=target or hp>_G.SDK.Damage:GetAutoAttackDamage(myHero,u))then count=count+1 end
   end
  end
 end
 return count
end
function CorkiChampion:LaneE(target)
 local menu=Menu.Clear.LaneClear
 local function allowed()
  return menu.E~=nil and menu.E:Value()and self:ClearMode(false)and self:FarmAllowed()and IsValid(target)and target.type==Obj_AI_Minion
   and target.team~=300 and target.team~=myHero.team and not IsUnderTurret(myHero)and self:WReserve(_E)
   and self:LaneECount(target)>=menu.ECount:Value()
 end
 if not IsReady(_E)or not allowed()then return end
 Core:Cast(HK_E,nil,{intentTarget=target,range=self.ESpell.Range,validate=allowed})
end
function CorkiChampion:CastQ(target,validate,defer)
  if not IsReady(_Q)or not Core:SkillshotCurrent(target)then return false end
 local pred=Core:Prediction(self.QSpell);pred:GetPrediction(target,myHero)
 if not pred:CanHit(target.type==Obj_AI_Hero and OrbamaPrediction.HITCHANCE_HIGH or OrbamaPrediction.HITCHANCE_NORMAL)then return false end
 local unit=pred.UnitPosition or target.pos
 if GetDistance(unit,myHero.pos)<=self.profile.qRange then
  return Core:Cast(HK_Q,pred.CastPosition,{prevalidateWorldCast=true,validate=validate,deferAttackWindup=defer==true or nil})
 end
 -- Edge reach: a champion predicted just beyond cast range gets the bomb at maximum range on that line.
 -- The shared resolver refuses a target outside the spell's range at dispatch, so this cast carries its own.
 if target.type~=Obj_AI_Hero then return false end
 local point=self:QEdgePoint(target,pred);if not point then return false end
 return Core:Cast(HK_Q,point,{intentTarget=target,range=self:QReach(),prevalidateWorldCast=true,
  resolve=function()local fresh=self:QEdgePoint(target);return fresh and{position=fresh}or nil end,validate=validate,deferAttackWindup=defer==true or nil})
end
-- Half a blast radius past cast range; the other half absorbs movement during the flight.
function CorkiChampion:QReach()return self.profile.qRange+self.profile.qRadius*.5 end
function CorkiChampion:QEdgePoint(target,pred)
 if not IsValid(target)or not target.pos2D.onScreen then return nil end
 if not pred then
  pred=Core:Prediction(self.QSpell);pred:GetPrediction(target,myHero)
  if not pred:CanHit(OrbamaPrediction.HITCHANCE_HIGH)then return nil end
 end
 local unit=pred.UnitPosition or target.pos;local reach=GetDistance(unit,myHero.pos)
 if reach<=self.profile.qRange or reach>self:QReach()then return nil end
 return Vector(myHero.pos):Extended(Vector(unit.x,myHero.pos.y,unit.z),self.profile.qRange)
end
local function stationary(unit)
 local path=unit.pathing
 return path and path.hasMovePath==false and path.isDashing==false
end
function CorkiChampion:MissileRay(target,point,big)
 local spell=big and self.R2Spell or self.R1Spell
 local wall,objects,count=OrbamaPrediction:GetCollision(myHero.pos,Vector(point),spell.Speed,spell.Delay,spell.Radius,
  {OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL},target.networkID)
 if wall then return false end
 if count==0 then return true,Vector(point)end
 -- A blocked ray is fired only when the explosion on the first blocker still covers the target. Standing
 -- units give the exact first contact. A moving blocker may meet the missile earlier or step aside, so it is
 -- weighed at the earliest point it can reach; a moving target adds a quarter of its travel as aim error.
 -- Every later contact lies nearer the target, so the earliest one is the worst case.
 local splash=big and self.profile.bigSplash or self.profile.splash
 if not splash or type(objects)~='table'or count>32 or #objects<count then return false end
 local source=myHero.pos;local dx,dz=point.x-source.x,point.z-source.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<=0 then return false end
 dx,dz=dx/length,dz/length
 local exact=stationary(target);local slack=0
 if not exact then
  -- Unknown movement is not standing still, and it is not a known speed either.
  local path=target.pathing
  if not path or path.hasMovePath~=true or path.isDashing~=false or type(target.ms)~='number'or target.ms<=0 then return false end
  slack=target.ms*(spell.Delay+length/spell.Speed)*.25
 end
 local first=length;local found=false;local seen={};local moving=0
 for i=1,count do
  local unit=objects[i]
  if not IsValid(unit)or not unit.networkID then return false end
  if not seen[unit.networkID]then
   seen[unit.networkID]=true
   local ux,uz=unit.pos.x-source.x,unit.pos.z-source.z
   local along=ux*dx+uz*dz;local across=ux*dz-uz*dx
   local radius=spell.Radius+(unit.boundingRadius or 0);local entry
   if stationary(unit)then
    if along>=0 and along<=length and across*across<=radius*radius then entry=math.max(0,along-math.sqrt(radius*radius-across*across))
    else return false end
   else
    local path=unit.pathing
    if not path or path.hasMovePath~=true or path.isDashing~=false or type(unit.ms)~='number'or unit.ms<=0 then return false end
    moving=moving+1;if moving>8 then return false end
    entry=along-radius-unit.ms*(spell.Delay+math.max(0,along)/spell.Speed)
    if entry<0 then return false end
   end
   if entry<first then first=entry;found=true end
  end
 end
 -- Only moving units behind the target were reported: the missile reaches the target itself.
 if not found then if moving>0 then return true,Vector(point)end;return false end
 local impact=Vector(source.x+dx*first,source.y,source.z+dz*first)
 -- Require the target center inside the splash. No optimistic bounding-radius extension.
 return GetDistance(exact and target.pos or point,impact)+slack<=splash,impact
end
function CorkiChampion:CastR(target,validate,reserve,defer)
 if not IsReady(_R)or not self:AmmoAllowed(reserve)or not IsValid(target)or not target.pos2D.onScreen then return false end
 local big=self:BigOne();local spell=big and self.R2Spell or self.R1Spell
 local pred=Core:Prediction(spell);pred:GetPrediction(target,myHero)
 if not pred:CanHit(target.type==Obj_AI_Hero and OrbamaPrediction.HITCHANCE_HIGH or OrbamaPrediction.HITCHANCE_NORMAL)or not self:MissileRay(target,pred.CastPosition,big)then return false end
 local accepted=Core:Cast(HK_R,pred.CastPosition,{prevalidateWorldCast=true,deferAttackWindup=defer==true or nil,validate=function(q,resolved)
  if self:BigOne()~=big or not self:AmmoAllowed(reserve)then return false end
  local valid,impact=self:MissileRay(target,resolved and resolved.position or q.target,big)
  if valid then self.rImpact=impact end
  return valid and (not validate or validate(q,resolved,impact))
 end})
 if accepted and Core.logger then
  Core:AfterCast(HK_R,function(q)if not q.ambiguous then self:ProbeSplash(big)end end)
 end
 return accepted
end
-- Development measurement of the missile's explosion radius (Classic splash is
-- unsettled: 75/150, 150/250 or 200/300): health of the units around the impact
-- before and shortly after it lands (corki_r_splash trace).
function CorkiChampion:ProbeSplash(big)
 local impact=self.rImpact;if not impact then return end
 local rows={};local spell=big and self.R2Spell or self.R1Spell
 for _,method in ipairs({'GetEnemyMinions','GetEnemyHeroes','GetMonsters'})do
  local list=Core:DecisionUnits(method)
  for i=1,math.min(#list,32)do local u=list[i]
   if #rows<16 and IsValid(u)and GetDistance(u.pos,impact)<=400 then rows[#rows+1]={unit=u,health=u.health,distance=GetDistance(u.pos,impact)}end
  end
 end
 self.splashProbe={at=Game.Timer()+spell.Delay+GetDistance(impact,myHero.pos)/spell.Speed+.3,big=big,impact=impact,rows=rows}
end
function CorkiChampion:ObserveSplash()
 local probe=self.splashProbe;if not probe or Game.Timer()<probe.at then return end
 self.splashProbe=nil
 local rows={}
 for _,row in ipairs(probe.rows)do
  if IsValid(row.unit)then rows[#rows+1]={distance=math.floor(row.distance),lost=math.floor(row.health-row.unit.health),radius=row.unit.boundingRadius}end
 end
 Core:Trace('corki_r_splash',{profile=self.profile.id,big=probe.big,splash=probe.big and self.profile.bigSplash or self.profile.splash,rows=rows})
end
function CorkiChampion:Tick()
 if Core.logger then self:ObserveSplash()end
 if ShouldWait()or IsCasting()then return end
  if self:EscapeW()or self:DefensiveW()then return end
  self:SemiR();self:AutoQ();self:KillSteal()
 local mode=GetMode()
 if mode=='Combo'then self:Combo()
 elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then
  if self:ClearMode(false)then self:FarmHarass();self:LaneClear()end
  if self:ClearMode(true)then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()
 elseif mode=='Flee'then self:Flee()end
end
-- Combo, Harass and clear harass wait for an observed attack windup to finish
-- (the attack lands, the spell follows in the same window); finishers and the
-- immobile-target casts do not wait. Harass keeps mana for Valkyrie.
function CorkiChampion:Combat(menu)
 if not self:ManaAllowed(menu)then return end
 local harass=menu==Menu.Harass
 local function reserve(slot)return not harass or self:WReserve(slot)end
  if menu.Q:Value()and reserve(_Q)then
   local target=GetTarget(self.QSpell.Range)
   if not IsValid(target)then target=Core:SkillshotTarget(self.QSpell,OrbamaPrediction.HITCHANCE_HIGH)end
   if not IsValid(target)then target=GetTarget(self:QReach())end
   if menu==Menu.Combo and self:SpellAttackFinish(menu,target,_Q)then return end
   self:CastQ(target,function()return menu.Q:Value()and self:ManaAllowed(menu)and reserve(_Q)end,true)
  end
 if menu.R:Value()and reserve(_R)then
  local target=GetTarget(self:RSpell().Range)
  if menu==Menu.Combo and self:SpellAttackFinish(menu,target,_R)then return end
  self:CastR(target,function()return menu.R:Value()and self:ManaAllowed(menu)and reserve(_R)end,menu.Rammo and menu.Rammo:Value()or 0,true)
 end
end
function CorkiChampion:Combo()self:Combat(Menu.Combo)end
function CorkiChampion:Harass()self:Combat(Menu.Harass)end
-- Immobilised enemies without a mode key: the bomb first; the missile when Q is
-- down or the enemy is beyond the bomb, keeping the Harass missile reserve
-- unless the missile kills.
function CorkiChampion:AutoQ()
 if not Menu.Misc.Qcc:Value()then return end
 local q,r=IsReady(_Q),IsReady(_R)
 if not q and not r then return end
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,10)do
  local target=enemies[i]
  if IsValid(target)then
   if q and Core:ControlledHit(target,self.QSpell)and self:CastQ(target,function(intent,resolved)
    return Menu.Misc.Qcc:Value()and Core:ControlledHit(target,self.QSpell,resolved and resolved.position or intent.target)
   end)then return end
   if r and(not q or GetDistance(target.pos,myHero.pos)>self:QReach())and Core:ControlledHit(target,self:RSpell())then
    local reserve=self:RLethal(target)and 0 or Menu.Harass.Rammo:Value()
    if self:CastR(target,function(intent,resolved)
     return Menu.Misc.Qcc:Value()and Core:ControlledHit(target,self:RSpell(),resolved and resolved.position or intent.target)
    end,reserve)then return end
   end
  end
 end
end
function CorkiChampion:SemiR()
 if Menu.Misc.SemiR:Value()then self:CastR(GetTarget(self:RSpell().Range))end
end
-- Finishers use the shared kill rule (shield pools, spell protection, health at the landing).
function CorkiChampion:RLethal(target)
 local spell=self:RSpell()
 return(Core:Lethal(target,spell.Delay+GetDistance(target.pos,myHero.pos)/spell.Speed,function()return self:RDamage(target)end,{kind=self.profile.rDamage}))
end
function CorkiChampion:QLethal(target)
 return(Core:Lethal(target,self.QSpell.Delay+GetDistance(target.pos,myHero.pos)/self.QSpell.Speed,function()return self:QDamage(target)end,{kind='magical'}))
end
function CorkiChampion:KillSteal()
 if not Menu.Misc.KillR:Value()then return end
 local r=IsReady(_R)and self:AmmoAllowed(0);local q=IsReady(_Q)
 if not r and not q then return end
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,10)do
  local target=enemies[i]
  if IsValid(target)and target.type==Obj_AI_Hero then
   -- The missile first: it is faster, and the bomb's cooldown is the longer one.
   if r and self:RLethal(target)and self:CastR(target,function()return Menu.Misc.KillR:Value()and self:RLethal(target)end)then return end
   if q and GetDistance(target.pos,myHero.pos)<=self:QReach()and self:QLethal(target)
    and self:CastQ(target,function()return Menu.Misc.KillR:Value()and self:QLethal(target)end)then return end
  end
 end
end
function CorkiChampion:ClearMode(jungle)
 local sdk=_G.SDK
 local mode=jungle and sdk.ORBWALKER_MODE_JUNGLECLEAR or sdk.ORBWALKER_MODE_LANECLEAR
 return sdk.Orbwalker.Modes[mode]==true
end
function CorkiChampion:FarmAllowed()return Menu.Clear.SpellFarm:Value()and self:ManaAllowed(Menu.Clear)end
function CorkiChampion:FarmHarass()
 if self:ClearMode(false)and Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)then self:Harass()end
end
function CorkiChampion:LaneCount(point,radius)
 local list=Core:DecisionUnits('GetEnemyMinions');local count,seen=0,{}
 for i=1,math.min(#list,32)do
  local unit=list[i]
  if IsValid(unit)and unit.team~=300 and unit.networkID and not seen[unit.networkID]and stationary(unit)
   and GetDistance(unit.pos,point)<=radius then seen[unit.networkID]=true;count=count+1 end
 end
 return count
end
function CorkiChampion:LaneClear()
 if not self:ClearMode(false)or not self:FarmAllowed()or IsUnderTurret(myHero)then return end
 local menu=Menu.Clear.LaneClear;local list=Core:DecisionUnits('GetEnemyMinions')
 if menu.Q:Value()and IsReady(_Q)and self:WReserve(_Q)then
  local aim=self:LaneQAim()
  if aim and Core:Cast(HK_Q,aim,{range=self.QSpell.Range,prevalidateWorldCast=true,resolve=function()return {position=aim}end,
   validate=function(q,resolved)
    local point=resolved and resolved.position or q.target
    return self:FarmAllowed()and menu.Q:Value()and not IsUnderTurret(myHero)and self:WReserve(_Q)
     and GetDistance(point,myHero.pos)<=self.QSpell.Range and self:LaneCount(point,self.QSpell.Radius)>=menu.QCount:Value()
   end})then return end
 end
 if not self:WReserve(_R)then return end
 for i=1,math.min(#list,32)do
  local target=list[i]
  if IsValid(target)and target.team~=300 and stationary(target)then
   -- Classic splash radius has no named asset value. Preserve direct R only for jungle/combat.
   local radius=self:BigOne()and self.profile.bigSplash or self.profile.splash
   if radius and menu.R:Value()and self:LaneCount(target.pos,radius)>=menu.RCount:Value()then
    local function coverage(q,resolved,impact)
     local point=resolved and resolved.position or q.target
     -- Direct contact occurs before the aim center by the projectile/target radii.
     if GetDistance(impact,point)<1 then impact=Vector(point):Extended(myHero.pos,self:RSpell().Radius+(target.boundingRadius or 0))end
     return self:FarmAllowed()and menu.R:Value()and not IsUnderTurret(myHero)and self:WReserve(_R)
      and self:LaneCount(impact,radius)>=menu.RCount:Value()
    end
    if self:CastR(target,coverage,menu.Rammo:Value())then return end
   end
  end
 end
end
-- Lane Q centre: the best circle over the stationary lane minions in reach
-- (each minion and each pair midpoint, shared C:BestAim, at most 24 points);
-- the dispatch recount stays.
function CorkiChampion:LaneQAim()
 local list=Core:DecisionUnits('GetEnemyMinions');local points={};local seen={}
 local reach=self.QSpell.Range+self.QSpell.Radius
 for i=1,math.min(#list,32)do local u=list[i]
  if #points<24 and IsValid(u)and u.team~=300 and u.networkID and not seen[u.networkID]and stationary(u)and GetDistance(u.pos,myHero.pos)<=reach then
   seen[u.networkID]=true;points[#points+1]={x=u.pos.x,z=u.pos.z}
  end
 end
 if #points<Menu.Clear.LaneClear.QCount:Value()then return nil end
 local aim,weight=Core:BestAim(points,{kind='circle',radius=self.QSpell.Radius,range=self.QSpell.Range})
 if not aim or weight<Menu.Clear.LaneClear.QCount:Value()then return nil end
 local point=Vector(aim.x,myHero.pos.y,aim.z)
 if self:LaneCount(point,self.QSpell.Radius)<Menu.Clear.LaneClear.QCount:Value()then return nil end
 return point
end
-- Spell then attack (Corki-2): a ready Q or missile primes Spellblade (C:SpellbladeBonus: Sheen family, 0 while
-- already primed or on its item cooldown), so the next attack carries the bonus. Lethal when the spell plus one
-- attack and that bonus kill a champion inside attack range by the time the attack lands (current health and
-- every shield, attack-only dodges refused); the spell then goes out at once instead of waiting for a windup and
-- the held Combo's orbwalker sends the attack. A spell that kills alone is left to the finishers.
function CorkiChampion:SpellAttackLethal(target,slot)
 if not IsValid(target)or target.type~=Obj_AI_Hero or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return false end
 local ready=Core:AttackReadyIn();if not Core.finite(ready)then return false end
 local spell=slot==_Q and self.QSpell or self:RSpell();local d=GetDistance(target.pos,myHero.pos)
 local data=myHero.attackData or {};local windup=Core.finite(data.windUpTime)and data.windUpTime or .3
 local speed=Core.finite(data.projectileSpeed)and data.projectileSpeed>0 and data.projectileSpeed or 2000
 local attackAt=math.max(ready,spell.Delay)+windup+d/speed
 local impact=math.max(spell.Delay+d/spell.Speed,attackAt)
 local aa=_G.SDK.Damage:GetAutoAttackDamage(myHero,target)
 if not Core.finite(aa)or aa<=0 then return false end
 local first=slot==_Q and self:QDamage(target)or self:RDamage(target)
 if not Core.finite(first)or first<=0 then return false end
 return(Core:Lethal(target,impact,first+aa+Core:SpellbladeBonus(target),{attack=true}))
end
function CorkiChampion:SpellAttackFinish(menu,target,slot)
 if not IsValid(target)or target.type~=Obj_AI_Hero then return false end
 if slot==_Q then
  return IsReady(_Q)and not self:QLethal(target)and self:SpellAttackLethal(target,_Q)
   and self:CastQ(target,function()return menu.Q:Value()and GetMode()=='Combo'and self:SpellAttackLethal(target,_Q)end)or false
 end
 return IsReady(_R)and self:AmmoAllowed(0)and not self:RLethal(target)and self:SpellAttackLethal(target,_R)
  and self:CastR(target,function()return menu.R:Value()and GetMode()=='Combo'and self:SpellAttackLethal(target,_R)end,0)or false
end
-- Health-bar combo (S9): two attacks (one with a Spellblade proc primed by a ready spell), a ready Q and a ready
-- missile. Partial.
function CorkiChampion:ComboDamage(u)
 local aa=_G.SDK.Damage:GetAutoAttackDamage(myHero,u)
 if not Core.finite(aa)or aa<0 then aa=0 end
 local damage=2*aa
 if aa>0 and(IsReady(_Q)or IsReady(_R)and self:AmmoAllowed(0))then damage=damage+Core:SpellbladeBonus(u)end
 if IsReady(_Q)then damage=damage+self:QDamage(u)end
 if IsReady(_R)and self:AmmoAllowed(0)then damage=damage+self:RDamage(u)end
 return damage,true
end
function CorkiChampion:JungleClear()
 if not self:ClearMode(true)or not self:FarmAllowed()then return end
 local menu=Menu.Clear.JungleClear;local list=Core:DecisionUnits('GetMonsters');local target
 for i=1,math.min(#list,32)do
  local unit=list[i]
  if IsValid(unit)and unit.team==300 and unit.pos2D.onScreen and GetDistance(unit.pos,myHero.pos)<=self.QSpell.Range
   and(not target or unit.maxHealth>target.maxHealth)then target=unit end
 end
 if not target then return end
 if menu.Q:Value()and self:WReserve(_Q)and self:CastQ(target,function()return self:FarmAllowed()and menu.Q:Value()and self:WReserve(_Q)end)then return end
 if menu.R:Value()and self:WReserve(_R)and self:CastR(target,function()return self:FarmAllowed()and menu.R:Value()and self:WReserve(_R)end)then return end
 -- E is a self cast around the attack: used when the monster is inside its reach.
 local function gun()return self:FarmAllowed()and menu.E:Value()and IsValid(target)and GetDistance(target.pos,myHero.pos)<=self.ESpell.Range and self:WReserve(_E)end
 if IsReady(_E)and gun()then Core:Cast(HK_E,nil,{intentTarget=target,range=self.ESpell.Range,validate=gun})end
end
function CorkiChampion:RescueFootprint(target,point,impact)
 -- Original GG may retain its minion snapshot through a new spawn. Native
 -- bounded discovery keeps a waiting Last Hit cast from missing new collateral.
 if not Game.MinionCount or not Game.Minion then return false end
 local count=Game.MinionCount()
 if type(count)~='number'or count<0 or count>128 then return false end
 for i=1,count do
  local unit=Game.Minion(i)
  if IsValid(unit)and unit.team~=myHero.team and unit.networkID~=target.networkID then
   -- Unknown/moving paths can enter the blast before impact. Require clearance
   -- for their full movement bound instead of assuming collateral is harmless.
   local motion=stationary(unit)and 0 or (unit.ms or 0)*impact
   if not stationary(unit)and type(unit.ms)~='number'then return false end
   if GetDistance(unit.pos,point)<=self.QSpell.Radius+(unit.boundingRadius or 0)+motion then return false end
  end
 end
 return true
end
-- Last-hit rescue through the shared rule (C:Rescue): the bomb only for a
-- minion the next basic attack cannot take in time, weighing its cooldown,
-- approach and flight.
function CorkiChampion:CanRescue(target,point)
 if not Menu.LastHit.Q:Value()or not self:ManaAllowed(Menu.LastHit)or not IsReady(_Q)or not IsValid(target)
  or target.type~=Obj_AI_Minion or target.team==300 or not target.pos2D.onScreen or _G.SDK.Attack:IsActive()then return false end
 point=point or target.pos
 local reach=GetDistance(point,myHero.pos);if reach>self.QSpell.Range then return false end
 local impact=self.QSpell.Delay+reach/self.QSpell.Speed
 local damage=self:QDamage(target)
 if target.health+(target.shieldAP or 0)+math.max(0,target.hpRegen or 0)*impact>damage then return false end
 if not self:RescueFootprint(target,point,impact)then return false end
 return Core:Rescue(target,impact,damage)
end
function CorkiChampion:Cannon(u)
 local name=type(u.charName)=='string'and u.charName:lower()or''
 return name:find('siege',1,true)~=nil or name:find('super',1,true)~=nil
end
-- Missile rescue: when the bomb cannot (down, or the minion is beyond it), a
-- cannon or super minion an attack cannot take, or any minion while the stock is
-- full, within the lane missile reserve. Direct hit or a splash that the
-- missile ray proves covers it.
function CorkiChampion:CanRescueR(target)
 if not Menu.LastHit.R:Value()or not self:ManaAllowed(Menu.LastHit)or not IsReady(_R)or not IsValid(target)
  or target.type~=Obj_AI_Minion or target.team==300 or not target.pos2D.onScreen or _G.SDK.Attack:IsActive()then return false end
 local spell=self:RSpell();local reach=GetDistance(target.pos,myHero.pos);if reach>spell.Range then return false end
 if Menu.LastHit.Q:Value()and IsReady(_Q)and reach<=self.QSpell.Range and self:CanRescue(target)then return false end
 if not self:AmmoAllowed(self:LaneReserve())then return false end
 if not self:Cannon(target)and myHero:GetSpellData(_R).ammo~=self.profile.maxAmmo then return false end
 return Core:Rescue(target,spell.Delay+reach/spell.Speed,function()return self:RDamage(target)end)
end
function CorkiChampion:LaneReserve()
 local node=Menu.Clear.LaneClear.Rammo;return node and node:Value()or 0
end
function CorkiChampion:LastHit()
 local q,r=Menu.LastHit.Q:Value(),Menu.LastHit.R:Value()
 if not q and not r then return end
 local list=Core:DecisionUnits('GetEnemyMinions')
 for i=1,math.min(#list,32)do local target=list[i]
  if q and self:CanRescue(target)and self:CastQ(target,function(intent,resolved)return self:CanRescue(target,resolved and resolved.position or intent.target)end)then return end
  if r and self:CanRescueR(target)and self:CastR(target,function()return self:CanRescueR(target)end,self:LaneReserve())then return end
 end
end
-- Landing rules for a dash Evade asks for: inside the dash's real reach (a shorter cast still flies the
-- minimum distance), known clear ground, no enemy turret, and not next to an enemy champion.
function CorkiChampion:LandingSafe(point)
 if not point or not Game.isWall or type(point.x)~='number'or type(point.z)~='number'then return false end
 local reach=GetDistance(point,myHero.pos)
 if reach<self.profile.wMinRange or reach>self.profile.wRange or not Vector(point):ToScreen().onScreen or IsUnderTurret({pos=Vector(point),boundingRadius=myHero.boundingRadius})then return false end
 for _,offset in ipairs({{0,0},{1,0},{-1,0},{0,1},{0,-1}})do
  local probe=Vector(point.x+offset[1]*myHero.boundingRadius,point.y or 0,point.z+offset[2]*myHero.boundingRadius)
  local ok,wall=pcall(Game.isWall,probe);if not ok or wall~=false then return false end
 end
 local enemies=Core:DecisionUnits('GetEnemyHeroes');if #enemies>10 then return false end
 for i=1,#enemies do local unit=enemies[i]
  if IsValid(unit)and GetDistance(unit.pos,point)<350 and GetDistance(unit.pos,point)<GetDistance(unit.pos,myHero.pos)then return false end
 end
 return true
end
function CorkiChampion:EscapePositionSafe(point)
  if not point or not Game.isWall then return false end
  local reach=GetDistance(point,myHero.pos)
  if reach<self.profile.wMinRange or reach>self.profile.wRange or not Vector(point):ToScreen().onScreen or IsUnderTurret({pos=Vector(point),boundingRadius=myHero.boundingRadius})then return false end
 -- Landing footprint only: W can cross terrain, but an unknown/wall landing is refused.
 for _,offset in ipairs({{0,0},{1,0},{-1,0},{0,1},{0,-1}})do
  local probe=Vector(point.x+offset[1]*myHero.boundingRadius,point.y or 0,point.z+offset[2]*myHero.boundingRadius)
  local ok,wall=pcall(Game.isWall,probe);if not ok or wall~=false then return false end
 end
 local enemies=Core:DecisionUnits('GetEnemyHeroes');if #enemies>10 then return false end;local threatened=false
 for i=1,math.min(#enemies,10)do local unit=enemies[i]
  if IsValid(unit)then
   local before=GetDistance(unit.pos,myHero.pos);local after=GetDistance(unit.pos,point)
   if before<900 then threatened=true;if after<before+100 then return false end end
   if after<500 then return false end
  end
 end
 return threatened
end
function CorkiChampion:WReady()
 local spell=myHero:GetSpellData(_W)
 return spell and spell.name==self.profile.wName and IsReady(_W)
end
function CorkiChampion:EscapeSafe(point,flee)
 local held;if flee then held=GetMode()=='Flee'else held=Menu.Misc.EscapeW:Value()end
 return held and self:WReady()and self:EscapePositionSafe(point)
end
-- The escape bind and the Flee mode share one rule: W toward the cursor with the landing checks.
function CorkiChampion:EscapeW(flee)
  flee=flee==true
  if flee and GetMode()~='Flee'or not flee and not Menu.Misc.EscapeW:Value()then return end
  if not self:WReady()then return end
  local distance=GetDistance(mousePos,myHero.pos);if distance<self.profile.wMinRange then return end
  local point=myHero.pos:Extended(mousePos,math.min(self.profile.wRange,distance))
  if not self:EscapeSafe(point,flee)then return end
  return Core:Cast(HK_W,point,{range=self.profile.wRange,independent=false,prevalidateWorldCast=true,
   resolve=function()return {position=point}end,
   validate=function(q,resolved)return self:EscapeSafe(resolved and resolved.position or q.target,flee)end})
end
function CorkiChampion:Flee()return self:EscapeW(true)end
function CorkiChampion:Approaching(target)
 if not IsValid(target)or GetDistance(target.pos,myHero.pos)>900 then return nil end
  return Core:ApproachingDash(target,myHero.pos,550)
end
function CorkiChampion:DefensiveW()
 local misc=Menu.Misc
 local function consent()return misc.DefensiveW:Value()and myHero.maxHealth>0
  and myHero.health/myHero.maxHealth*100<=misc.DefensiveHP:Value()end
 if not consent()or not self:WReady()then return false end
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,10)do local target=enemies[i];local snapshot=self:Approaching(target)
  if snapshot then
   local function destination()
    if not consent()or not self:WReady()then return nil end
    local fresh=self:Approaching(target);if not fresh then return nil end
    local dx,dz=myHero.pos.x-fresh.to.x,myHero.pos.z-fresh.to.z;local length=math.sqrt(dx*dx+dz*dz)
    if length<1 then return nil end
    local range=self.profile.wRange-1
    local pos=Vector(myHero.pos.x+dx/length*range,myHero.pos.y,myHero.pos.z+dz/length*range)
    return self:EscapePositionSafe(pos)and pos or nil
   end
   local aim=destination()
   if aim and Core:Cast(HK_W,aim,{owner='DefensiveW',range=self.profile.wRange,ttl=150,prevalidateWorldCast=true,
    context={priority='critical',condition=consent},resolve=function()local pos=destination();return pos and {position=pos}end,
    validate=function(_,resolved)return consent()and self:WReady()and self:Approaching(target)~=nil
     and resolved and self:EscapePositionSafe(resolved.position)end})then return true end
  end
 end
 return false
end

function CorkiChampion:Draw()
	if myHero.dead then return end

	if Menu.Draw.Q:Value() and IsReady(_Q) then
		Draw.Circle(myHero.pos, self.QSpell.Range, 1, Draw.Color(255, 66, 244, 113))
	end
	if Menu.Draw.E:Value() and IsReady(_E) then
		Draw.Circle(myHero.pos, self.ESpell.Range, 1, Draw.Color(255, 244, 238, 66))
	end
	if Menu.Draw.R:Value() and IsReady(_R) then
		if self:BigOne() then
			Draw.Circle(myHero.pos, self.R2Spell.Range, 1, Draw.Color(255, 244, 66, 104))
		else
			Draw.Circle(myHero.pos, self.R1Spell.Range, 1, Draw.Color(255, 244, 66, 104))
		end
	end
end



function CorkiChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},e={node=Menu.Combo.E,label='Combo E'},r={node=Menu.Combo.R,label='Combo R'},
  reserve={node=Menu.Harass.Rammo,label='Harass R reserve'},farm={node=Menu.Clear.SpellFarm,label='Spell farming'},
  farmHarass={node=Menu.Clear.SpellHarass,label='Clear harass'},lastHit={node=Menu.LastHit.Q,label='Last Hit Q'},
  semiR={node=Menu.Misc.SemiR,label='Selected-target R bind'},autoQ={node=Menu.Misc.Qcc,label='Q and R on crowd control'},killR={node=Menu.Misc.KillR,label='R kill secure'}}
 if Menu.Misc.EscapeW then nodes.escape={node=Menu.Misc.EscapeW,label='Escape W bind'}end
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Corki: quick start','Corki: missiles and movement','Corki: farming'},function(page)
  if page==1 then return {title=self.profile.id=='classic'and 'Classic Corki'or 'Corki',subtitle='Use your Orbama mode keys.',cards={
   {'COMBAT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..' for [[q]], [[e]] and [[r]]. E assists an eligible attack attempt within its reach; it does not block your attacks.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. [[reserve]] is the number of missiles kept after a cast. Low mana cancels waiting harass.'},
   {'ASSISTANCE','Hold [[semiR]] to fire a missile at your target. [[autoQ]] and [[killR]] act without a mode key and start enabled.'}},note='Release a mode or assist key to cancel its waiting spells. Manual attacks and movement stay provider-owned.'}end
  if page==2 then return {title='Missiles and movement',subtitle='Missile stages and ammo come from current host state.',cards={
   {'MISSILES','Champion and minion blockers both matter. A blocked missile is fired only when its explosion on the first blocker still covers the target; moving units are weighed at the earliest point they can reach. Q reaches a champion just beyond its cast range with the edge of the blast.'},
   {'AMMO','Normal and Classic have separate damage and missile profiles. The controller never grants ammo from an attack attempt or delays spells just because a Spellblade buff exists.'},
    {'VALKYRIE','Hold [[escape]] to dash toward the cursor only when the landing moves away from nearby enemies, avoids turrets and has known clear ground. The Flee mode does the same. Defensive W reacts to an enemy dashing at you below the configured health threshold. Evade may also dodge with W onto known clear ground outside enemy turrets. Offensive W remains manual.'}},note='A requested missile or accepted input does not prove a cast, hit or kill.'}end
  return {title='Farming',subtitle='[[farm]] is off by default.',cards={
   {'CLEAR','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..'. Q counts stationary minions inside the intended blast. R counts minions inside the splash of its first impact.'},
   {'JUNGLE','Q, E and R have separate switches. The largest nearby camp unit is preferred. [[farmHarass]] allows harass during Clear and keeps the Clear key as its cancellation context.'},
   {'LAST HIT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT)..' with [[farm]] and [[lastHit]] enabled to rescue a Q-lethal minion. A ready lethal attack, active windup, nearby collateral target or confirmed incoming lethal damage prevents Q.'}},note='Farm checks mana, current targets and permissions again before send. No W is spent on farming.'}
 end,cfg,links,activate)
end

Core:RegisterPolicy({
 methods={
  AutoQ=function()return {priority='interactive'}end,
  KillSteal=function()return {priority='interactive'}end,
  OnPreAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode)or nil end,
  Combo=function()return Core:ModeContext('Combo')end,
  Harass=function()return Core:ModeContext('Harass')end,
  LaneClear=function(self)return Core:ModeContext('LaneClear',function()return self:ClearMode(false)and Menu.Clear.SpellFarm:Value()end)end,
  JungleClear=function(self)return Core:ModeContext('LaneClear',function()return self:ClearMode(true)and Menu.Clear.SpellFarm:Value()end)end,
  FarmHarass=function(self)return Core:ModeContext('LaneClear',function()return self:ClearMode(false)and Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)end)end,
  LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end,
  SemiR=function()return Core:HeldContext(function()return Menu.Misc.SemiR:Value()end)end,
  EscapeW=function()return Core:HeldContext(function()return Menu.Misc.EscapeW and Menu.Misc.EscapeW:Value()end)end,
 },
 exceptions={non_interrupting_summoner=true},
 channel=function()return not Core:SelfChanneling()end,
})
CorkiChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Corki"]="Corki"}
local normalSupported={["Corki"]=true}

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
