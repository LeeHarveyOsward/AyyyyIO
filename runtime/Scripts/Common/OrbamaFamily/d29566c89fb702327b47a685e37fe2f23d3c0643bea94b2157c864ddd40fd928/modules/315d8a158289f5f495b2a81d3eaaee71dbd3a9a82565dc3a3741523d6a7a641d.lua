return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Leona"]=function()return _G.OrbamaFamily:Require("b0aede977ab4fac825f96047477e9ec357ecea68902754261c21befb759bdc8c")()end
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
if champion=="Leona" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Leona',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.02
-- Static candidates, not live verification. See CombatProfiles/leona-provenance.json.
local profiles=ChampionProfiles('Leona')
local finite,manaAbove,buffExpiry=Core.finite,Core.manaAbove,Core.buffExpiry
if not profiles[myHero.charName]then return end


local LeonaChampion=class("LeonaChampion")

function LeonaChampion:__init()
	self.profile=profiles[myHero.charName];self.classic=self.profile.classic
	self.WRange = 450
	local p=self.profile
	self.ESpell = { Type = OrbamaPrediction.SPELLTYPE_LINE, Delay = 0.25, Radius = p.width, Range = p.eRange, Speed = 2000, Collision = true, CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL} }
	-- R: the area (slow and damage) and the epicenter (stun) share one cast; the delay is cast time plus the impact delay.
	self.RSpell = { Type = OrbamaPrediction.SPELLTYPE_CIRCLE, Delay = p.rCast+p.rImpact, Radius = p.rArea, Range = 1200, Speed = math.huge, Collision = false }
	self.RStun = { Type = OrbamaPrediction.SPELLTYPE_CIRCLE, Delay = p.rCast+p.rImpact, Radius = p.rEpicenter, Range = 1200, Speed = math.huge, Collision = false }
	self:LoadMenu()
	self.allow=Core:TargetConsent(Menu.Combo.Targets,self,'Allow E and R on: ');self.allow:Refresh()
	self:RegisterEvade()
	-- Health-bar damage: ready Q, E and R plus one attack.
	Core:RegisterComboDamage(function(u)
	 if not IsValid(u)then return 0 end
	 return (self:Ready(_Q)and self:GetQDmg(u)or 0)+(self:Ready(_E)and self:GetEDmg(u)or 0)+(self:Ready(_R)and self:GetRDmg(u)or 0)+self:AttackDamage(u)
	end)
	Core:RegisterCleanup('Leona.state',function()self.engage=nil;self.farm=nil;self.preview=nil;self.interrupt=nil;self.rProbe=nil end)
	local prepared,reason=Core:RegisterPreparation('Leona.preview',{intervalMs=125,maxDelayMs=500,units=2,maxUnits=2},
	 function()self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
	self.previewFallback=not prepared and reason=='unsupported'
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
	_G.SDK.Orbwalker:OnPreAttack(function(args) self:OnPreAttack(args) end)
end

function LeonaChampion:LoadMenu()
	local icon = "https://ddragon.leagueoflegends.com/cdn/16.19.1/img/champion/Leona.png"
	Menu = MenuElement({ type = MENU, id = "Classic_AIO_" .. myHero.charName, name = "AyyyyIO - Leona", leftIcon = icon })
	Menu:MenuElement({ type = MENU, id = "Combo", name = "Combo" })
	for _, s in ipairs({ "Q", "W", "E", "R" }) do
		Menu.Combo:MenuElement({ id = s, name = "Use " .. s, value = true })
	end
	Menu.Combo:MenuElement({ id = "RCount", name = "R must hit this many enemies", value = 2, min = 1, max = 5, step = 1 })
	Menu.Combo:MenuElement({id='ChainR',name='Also R a single enemy stunned after E',value=true,menu=false})
	Menu.Combo:MenuElement({id='RSingle',name='Also R one enemy to reach it or secure a kill',value=true})
	Menu.Combo:MenuElement({type=MENU,id='Targets',name='Enemy champions E and R may engage'})
	Menu:MenuElement({ type = MENU, id = "Harass", name = "Harass" })
	for _, s in ipairs({ "Q", "W", "E" }) do
		Menu.Harass:MenuElement({ id = s, name = "Use " .. s, value = s ~= "E" })
	end
	Menu.Harass:MenuElement({ id = "Mana", name = "Only above mana %", value = 40, min = 0, max = 100, step = 5 })
	Menu:MenuElement({ type = MENU, id = "Clear", name = "Farming" })
	Menu.Clear:MenuElement({ id = "Enabled", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(v) CheckChatBlock(Menu.Clear.Enabled, v) end })
	Menu.Clear:MenuElement({ id = "W", name = "Use W near this many lane minions or a big monster", value = 3, min = 1, max = 8, step = 1 })
	Menu.Clear:MenuElement({ id = "E", name = "Use E on the largest jungle monster", value = true })
	Menu.Clear:MenuElement({ id = "Q", name = "Use Q on a large monster before an attack", value = true })
	Menu.Clear:MenuElement({ id = "Mana", name = "Only above mana %", value = 30, min = 0, max = 100, step = 5 })
	Menu:MenuElement({ type = MENU, id = "KillSteal", name = "Finish killable enemies" })
	Menu.KillSteal:MenuElement({ id = "E", name = "Use E (dashes in) without holding a mode key", value = false })
	Menu.KillSteal:MenuElement({ id = "R", name = "Use R without holding a mode key", value = true })
	Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
	Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
	Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
	Menu:MenuElement({ type = MENU, id = "SemiR", name = "R bind" })
	Menu.SemiR:MenuElement({ id = "Key", name = "Cast R at the selected target", key = string.byte("T") })
	Menu:MenuElement({ type = MENU, id = "Misc", name = "Behaviour" })
	Menu.Misc:MenuElement({ id = "AutoW", name = "W below health % near an enemy (0 = never)", value = 35, min = 0, max = 100, step = 5 })
	Menu.Misc:MenuElement({ id = "AntiDash", name = "Use E on enemies dashing at you or a nearby ally", value = true })
	Menu.Misc:MenuElement({id='ThreatW',name='Use W when a champion or turret is about to hit you',value=true,menu=false})
	-- E never goes under an enemy turret (target or landing); the one switch is the lethal dive exception.
	Menu.Misc:MenuElement({id='SafeE',name='Never use E on an enemy under their turret, or to land there',value=true,menu=false})
	Menu.Misc:MenuElement({id='TurretDive',name='Dive a turret with E when the kill is safe',value=false})
	Menu.Misc:MenuElement({id='InterruptQ',name='Stun enemies who channel in attack range with Q',value=true,menu=false})
	Menu.Misc:MenuElement({id='InterruptE',name='Dash with E to channelling enemies to stun them',value=true})
	Menu.Misc:MenuElement({id='InterruptR',name='Stun enemies who channel beyond E reach with R',value=true})
	Menu.Misc:MenuElement({id='FleeQ',name='Use Q on a chasing enemy in Flee',value=false})
	Menu:MenuElement({ type = MENU, id = "Draw", name = "Drawings" })
	for _, s in ipairs({ "Q", "W", "E", "R" }) do
		Menu.Draw:MenuElement({ id = s, name = s == "Q" and "Q range (attack range + 50)" or s .. " range", value = false })
	end
	Menu.Draw:MenuElement({id='Engage',name='Mark the enemy being engaged',value=false})
	Menu.Draw:MenuElement({id='Preview',name='R landing area on the current target',value=false})
end


function LeonaChampion:Ready(slot)
 local d=myHero:GetSpellData(slot)
 return d and d.level>0 and IsReady(slot)and (d.mana or 0)<=myHero.mana
end
function LeonaChampion:Buff(unit,name,owned)
 if not unit or not finite(unit.buffCount)or unit.buffCount<0 or unit.buffCount%1~=0 or unit.buffCount>128 then return nil end
 for _,b in ipairs(Core:Fresh(GetBuffs,unit))do
  local expiry=buffExpiry(b)
  if b.name==name and b.valid~=false and finite(b.count)and b.count>0 and finite(expiry)and expiry>Game.Timer()then
   if not owned then return b,expiry end
   local known,valid=false,true
   if b.sourcenID and b.sourcenID~=0 then known=true;valid=valid and b.sourcenID==myHero.networkID end
   if type(b.source)=='table'or type(b.source)=='userdata'then
    if b.source.networkID and b.source.networkID~=0 then known=true;valid=valid and b.source.networkID==myHero.networkID end
    if b.source.handle and b.source.handle~=0 then known=true;valid=valid and b.source.handle==myHero.handle end
   elseif type(b.source)=='number'and b.source~=0 then
    known=true;valid=valid and (b.source==myHero.networkID or b.source==myHero.handle)
   end
   if b.sourceName and b.sourceName~=''and b.sourceName~=myHero.charName then valid=false end
   if known and valid then return b,expiry end
  end
 end
end
function LeonaChampion:QActive()return self:Buff(myHero,self.profile.qBuff)~=nil end
-- Per-enemy engage consent (Combo E, R and the finishers); an enemy the roster has not listed yet is refused.
function LeonaChampion:Allowed(u)return self.allow:Allowed(u)==true end
-- A spell shield eats the blade (no dash follows) and the flare; unknown buff state counts as protected.
-- Leona-5: a crowd-control immune enemy (Olaf R, Black Shield, Void Shift: Core:CCImmune) is not opened on
-- either, the root and stun would not hold.
function LeonaChampion:Open(u)return Core:SpellProtected(u)==false and Core:CCImmune(u,.5)==false end
-- The Q stun only: a crowd-control immune enemy keeps the empowered attack for later.
function LeonaChampion:Stunnable(u)return Core:CCImmune(u,.3)~=true end
-- Every combat Q (pre-attack, Combo, Harass): a spell shield eats the empowered attack's stun and damage, and
-- unknown buff state counts as shielded. A crowd-control immune enemy gets Q only when Q plus the attack kills
-- (the damage still lands). Re-rank 2026-10-10 against PussyAIO Leona's ignore list.
function LeonaChampion:QUseful(t)
 if Core:SpellProtected(t)~=false then return false end
 if self:Stunnable(t)then return true end
 local windup=_G.SDK.Attack:GetWindup()
 return finite(windup)and Core:Lethal(t,windup,function()return self:GetQDmg(t)+self:AttackDamage(t)end,{attack=true})==true
end
-- W: bonus armor and magic resistance offered to Evade in both profiles. Normal offers the rank base only (its 20%
-- bonus scaling and flat per-hit reduction are left out: a lower bound of the protection).
function LeonaChampion:RegisterEvade()
 local p=self.profile
 if not p.wResist or not Core.RegisterEffect then return end
 local function value()local rank=myHero:GetSpellData(_W).level;return p.wResist[rank]end
 self.wOffered=Core:RegisterEffect({kind='resist',name='Leona.W',slot=_W,key=HK_W,profile=p.classic and 'classic'or 'normal',source=p.wSource,spell=p.w,
  delay=0,duration=p.wDuration,armor=value,magicResist=value})
end
function LeonaChampion:Heroes()
 local count=Game.HeroCount();if not finite(count)or count<0 or count%1~=0 or count>16 then return nil end
 local result={}
 for i=1,count do local u=Game.Hero(i);if u and u.type==Obj_AI_Hero then result[#result+1]=u end end
 return result
end
function LeonaChampion:InAttackRange(t)
 return IsValid(t)and t.team~=myHero.team and _G.SDK.Data:IsInAutoAttackRange(myHero,t)
end
function LeonaChampion:ModePermission(mode,spell)
 local menu=mode=='Combo'and Menu.Combo or mode=='Harass'and Menu.Harass
 return menu and GetMode()==mode and menu[spell]:Value()and (mode~='Harass'or manaAbove(menu.Mana:Value()))
end
function LeonaChampion:CastQ(t,mode,extra,context)
 if not self:Ready(_Q)or self:QActive()or not self:InAttackRange(t)or not self:ModePermission(mode,'Q')then return false end
 return Core:Cast(HK_Q,nil,{owner='EmpowerQ',context=context or Core:ModeContext(mode),intentTarget=t,
  -- The native AA range includes radii and current attack modifiers. No fixed 225 gate.
  range=math.huge,validate=function()return self:InAttackRange(t)and self:ModePermission(mode,'Q')and not self:QActive()and (not extra or extra())end})
end
-- CC staggering: a plain Q stun on an enemy already held longer than the attack windup (+.15 s) is wasted, unless the
-- empowered attack kills. The engage plan and the interrupt keep their own Q.
function LeonaChampion:AttackDamage(t)return _G.SDK.Damage:CalculateDamage(myHero,t,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)end
function LeonaChampion:QOverlaps(t)
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)then return false end
 if self:ControlRemaining(t)<=windup+.15 then return false end
 return not Core:Lethal(t,windup,function()return self:GetQDmg(t)+self:AttackDamage(t)end,{attack=true})
end
-- The blade's root is wasted on an enemy whose hard crowd control outlasts its flight.
function LeonaChampion:EOverlaps(t)
 return self:ControlRemaining(t)>self.ESpell.Delay+GetDistance(t.pos,myHero.pos)/self.ESpell.Speed
end
function LeonaChampion:LargeMonster(u)
 if not IsValid(u)or u.team~=300 then return false end
 local name=type(u.charName)=='string'and u.charName:lower()or''
 return not name:find('mini',1,true)and not name:find('plant',1,true)
end
function LeonaChampion:OnPreAttack(args)
 if not args or args.Process==false or not args.Target then return end
 local mode,t=GetMode(),args.Target
 if t.type~=Obj_AI_Hero then
  -- A stunned large monster hits back less: Q goes on the attack about to land.
  if mode=='LaneClear'and self:LargeMonster(t)and Menu.Clear.Q:Value()and self:FarmPermission(true)and self:Ready(_Q)and not self:QActive()
   and self:InRange(t)then
   Core:Cast(HK_Q,nil,{owner='JungleQ',context=Core:ModeContext('LaneClear',function()return self:FarmMode(true)end),intentTarget=t,range=math.huge,
    validate=function()return args.Process~=false and Menu.Clear.Q:Value()and self:FarmPermission(true)and self:InRange(t)and not self:QActive()end})
  end
  return
 end
 if(mode=='Combo'or mode=='Harass')and not self:QOverlaps(t)and self:QUseful(t)then
  self:CastQ(t,mode,function()return args.Process~=false and not self:QOverlaps(t)and self:QUseful(t)end)
 end
end
function LeonaChampion:InRange(t)return IsValid(t)and _G.SDK.Data:IsInAutoAttackRange(myHero,t)end
function LeonaChampion:DefensiveW()
 if Menu.Misc.AutoW:Value()==0 or myHero.maxHealth<=0 or myHero.health/myHero.maxHealth*100>Menu.Misc.AutoW:Value()then return false end
 local heroes=self:Heroes();if not heroes then return false end
 -- Explicit conservative threat policy: a current enemy within 700 at low health.
 for _,t in ipairs(heroes)do if t.team~=myHero.team and IsValid(t)and GetDistance(t.pos,myHero.pos)<=700 then return true end end
 return false
end
-- An enemy champion's attack, targeted spell or missile, a turret shot or a tracked skillshot about to land on Leona.
function LeonaChampion:ThreatW()
 if not Menu.Misc.ThreatW:Value()then return nil end
 local threat=Core:AllyThreat(myHero,.5)
 if threat and(threat.kind=='skillshot'or threat.kind=='turret'or threat.source and threat.source.type==Obj_AI_Hero)then return threat end
end
function LeonaChampion:AutoW()
 if not self:Ready(_W)then return end
 if self:DefensiveW()then
  return Core:Cast(HK_W,nil,{owner='AutoW',validate=function()return self:DefensiveW()end})
 end
 local threat=self:ThreatW()
 if threat then
  return Core:Cast(HK_W,nil,{owner='ThreatW',validate=function()return Menu.Misc.ThreatW:Value()and threat.valid()end})
 end
end
-- W needs 3 s to detonate and its resistances matter most during the dive, so it
-- starts as the engage goes out, not after arrival. "About to go out" is the
-- same test CastE applies (E allowed and ready, target outside attack range,
-- hit chance, legal ray), or this controller's own E already under way to it.
-- `fresh` is the dispatch-time form: no prediction, current positions only.
function LeonaChampion:EngageImminent(t,mode,fresh)
 local p=self.engage
 if p and p.id==t.networkID and not p.arrived then return true end
 local menu=mode=='Combo'and Menu.Combo or mode=='Harass'and Menu.Harass
 if not menu or not menu.E:Value()or not self:Ready(_E)or self:InAttackRange(t)or GetDistance(t.pos,myHero.pos)>self.ESpell.Range then return false end
 if fresh then return self:RayLegal(t,t.pos)end
 local pred=Core:Prediction(self.ESpell);pred:GetPrediction(t,myHero)
 return pred:CanHit(mode=='Harass'and 3 or 2)and self:RayLegal(t,pred.CastPosition)
end
function LeonaChampion:CombatW(t,mode)
 if not self:Ready(_W)or not self:ModePermission(mode,'W')or not IsValid(t)then return false end
 local near=GetDistance(t.pos,myHero.pos)<=self.WRange
 if not near and not self:EngageImminent(t,mode)then return false end
 return Core:Cast(HK_W,nil,{owner=mode,intentTarget=t,range=near and self.WRange or self.ESpell.Range,
  validate=function()return self:ModePermission(mode,'W')and IsValid(t)
   and(GetDistance(t.pos,myHero.pos)<=self.WRange or not near and self:EngageImminent(t,mode,true))end})
end
-- Leona lands 225 beyond the last champion hit (wiki): the turret check covers the target and that landing. The
-- optional dive exception needs the E+Q+attack burst to kill and Leona's health to cover one shot of every turret there.
function LeonaChampion:DiveAllowed(t,landing)
 if not Menu.Misc.TurretDive:Value()then return false end
 local impact=self.ESpell.Delay+GetDistance(t.pos,myHero.pos)/self.ESpell.Speed
 if not Core:Lethal(t,impact+.3,function()return self:GetEDmg(t)+(self:Ready(_Q)and self:GetQDmg(t)or 0)+self:AttackDamage(t)end)then return false end
 local shot=0
 for _,turret in ipairs(_G.SDK.ObjectManager:GetEnemyTurrets())do
  if not turret.dead and turret.pos:DistanceTo(landing)<(turret.boundingRadius or 0)+750 then
   if not finite(turret.totalDamage)then return false end
   local d=_G.SDK.Damage:CalculateDamage(turret,myHero,_G.SDK.DAMAGE_TYPE_PHYSICAL,turret.totalDamage)
   if not finite(d)then return false end
   shot=shot+d
  end
 end
 return myHero.health>shot
end
function LeonaChampion:RayLegal(t,aim,farm)
 if not IsValid(t)or not aim or GetDistance(myHero.pos,t.pos)>self.ESpell.Range then return false end
 if not farm and t.type==Obj_AI_Hero and not self:Open(t)then return false end
 local origin=myHero.pos;local length=GetDistance(origin,aim);if length<1 then return false end
 local dx,dz=(aim.x-origin.x)/length,(aim.z-origin.z)/length
 local endpoint=Vector(origin.x+dx*self.ESpell.Range,origin.y,origin.z+dz*self.ESpell.Range)
 local wall=OrbamaPrediction:GetCollision(origin,endpoint,self.ESpell.Speed,self.ESpell.Delay,self.ESpell.Radius,{OrbamaPrediction.COLLISION_YASUOWALL})
 if wall then return false end
 if not farm and Menu.Misc.SafeE:Value()then
  local landing=Vector(t.pos.x+dx*225,t.pos.y,t.pos.z+dz*225)
  if(IsUnderTurret2(t.pos)or IsUnderTurret2(landing))and not self:DiveAllowed(t,landing)then return false end
 end
 local heroes=self:Heroes();if not heroes then return false end
 local targetAlong=(t.pos.x-origin.x)*dx+(t.pos.z-origin.z)*dz
 for _,u in ipairs(heroes)do
  if u.team~=myHero.team and IsValid(u)and u.networkID~=t.networkID then
   local x,z=u.pos.x-origin.x,u.pos.z-origin.z;local along=x*dx+z*dz
   local reach=self.ESpell.Radius+(u.boundingRadius or 0)
   -- A moving champion could enter the ray before it arrives. Refuse ambiguous ordering.
   if u.pathing and u.pathing.hasMovePath then reach=reach+(u.ms or 0)*(.25+math.max(0,along)/2000)end
   if along>=-reach and along<=self.ESpell.Range+reach and math.abs(x*dz-z*dx)<=reach and (farm or along>=targetAlong-reach)then return false end
  end
 end
 return true
end
function LeonaChampion:CastE(t,hc,extra,farm)
 if not self:Ready(_E)or not IsValid(t)then return false end
 local p=Core:Prediction(self.ESpell);p:GetPrediction(t,myHero)
 if not p:CanHit(hc or 2)or not self:RayLegal(t,p.CastPosition,farm)or extra and not extra()then return false end
 local ok=Core:Cast(HK_E,p.CastPosition,{intentTarget=t,prevalidateWorldCast=true,
  validate=function(q,r)return self:RayLegal(t,r and r.position or q.target,farm)and (not extra or extra())end})
 local q=Core.lastIntent;local mode=GetMode()
 if ok and q and (q.owner=='Combo'or q.owner=='Harass')and not farm and (mode=='Combo'or mode=='Harass')and self:ModePermission(mode,'Q')then
  local plan={target=t,id=t.networkID,mode=mode,context=q.context,request=q.requestGameTime,expires=Game.Timer()+2.25,requestIntent=q,phase='e_requested'}
  self.engage=plan
  Core:AfterCast(HK_E,function()if self.engage==plan then plan.eObserved=true;plan.phase='e_observed'end end)
 end
 return ok
end
function LeonaChampion:PlanValid(p)
 local selected=_G.SDK.TargetSelector.Selected
 if selected and IsValid(selected)and selected.networkID~=p.id then return false end
 return self.engage==p and Game.Timer()<=p.expires and IsValid(p.target)and p.target.networkID==p.id
  and Core:ContinuationState(p.requestIntent,p.expires)~=nil and self:ModePermission(p.mode,'Q')
  and not p.requestIntent.ambiguous and not p.requestIntent.cancelled
end
function LeonaChampion:CompletedAttack(q,t)
 local a=Core:NativeAttack(q)
 if not a or not a.castEndTime or a.castEndTime>Game.Timer()or Game.Timer()-a.castEndTime>.35 then return false end
 return a.target==t.handle or a.target==t.networkID
end
function LeonaChampion:ObserveEngage()
 local p=self.engage;if not p then return end
 if not self:PlanValid(p)then self.engage=nil;return end
 -- While it exists the plan keeps Combo's own Q and R back. It is over once its
 -- attack was observed, and it has nothing to follow once the observed E has
 -- had its delay and full flight without rooting its target: that E missed.
 -- Both used to hold Q and R until the plan's 2.25 s expiry.
 if p.phase=='attack_observed'then self.engage=nil;return end
 local root=self:Buff(p.target,self.profile.root,true)
 local boundary=p.requestIntent.observationGameTime
 if root and finite(boundary)and finite(root.startTime)and root.startTime>=boundary and root.startTime<=Game.Timer()then p.rootObserved=true end
 if p.eObserved and not p.rootObserved then p.eAt=p.eAt or Game.Timer()
  if Game.Timer()-p.eAt>self.ESpell.Delay+self.ESpell.Range/self.ESpell.Speed+.25 and not(myHero.pathing and myHero.pathing.isDashing)then self.engage=nil;return end
 end
 if p.rootObserved then
  local heroes=self:Heroes();if not heroes then self.engage=nil;return end
  for _,u in ipairs(heroes)do if u.team~=myHero.team and u.networkID~=p.id and IsValid(u)then
   local other=self:Buff(u,self.profile.root,true)
   if other and finite(boundary)and finite(other.startTime)and other.startTime>=boundary and other.startTime<=Game.Timer()then self.engage=nil;return end
  end end
 end
 local dashing=myHero.pathing and myHero.pathing.isDashing
 if p.eObserved and dashing then p.dashObserved=true end
 if p.eObserved and p.rootObserved and p.dashObserved and not dashing and self:InAttackRange(p.target)then
  p.arrived=true
 end
 -- Q is armed as soon as the root is seen, during the dash, so the first attack on arrival stuns. The host's answer to a
 -- Q mid-dash is recorded (leona_q_mid_dash); a Q refused before it was sent falls back to the arrival Q below.
 if p.phase=='e_observed'and p.rootObserved and not p.arrived and not p.earlyQ then
  if self:QActive()then p.qObserved=true;p.phase='q_requested'
  elseif self:Ready(_Q)and self:ModePermission(p.mode,'Q')and Core:Cast(HK_Q,nil,{owner='EngageQ',context=p.context,intentTarget=p.target,range=math.huge,
   validate=function()return self:PlanValid(p)and p.rootObserved and not self:QActive()end})then
   p.phase='q_requested';p.earlyQ=Core.lastIntent;p.qRequest=Game.Timer()
   Core:AfterCast(HK_Q,function()
    if self:PlanValid(p)then p.qObserved=true end
    Core:Trace('leona_q_mid_dash',{dashing=myHero.pathing and myHero.pathing.isDashing==true,armed=self:QActive(),after=Game.Timer()-p.qRequest})
   end)
  end
 end
 if p.earlyQ and p.phase=='q_requested'and not p.qObserved then
  if self:QActive()then p.qObserved=true
  else local r=Core.adapter:Poll(p.earlyQ.id)
   if r and(r.state=='cancelled_before_send'or r.state=='rejected')then p.phase='e_observed'end
  end
 end
 if not p.arrived then return end
 if p.phase=='e_observed'then
  if self:QActive()then
   -- An already armed Q is current evidence; do not spend Q again or wait for its expiry.
   p.qObserved=true;p.phase='q_requested'
  elseif self:CastQ(p.target,p.mode,function()return self:PlanValid(p)and p.arrived end,p.context)then
   p.phase='q_requested';p.qRequest=Game.Timer()
   Core:AfterCast(HK_Q,function()if self:PlanValid(p)then p.qObserved=true end end)
  end
 end
 if p.phase=='q_requested'and p.qObserved and self:QActive()then
  -- Shared Attack owns cursor, lock checks, cancellation and reconciliation.
  local ok=Core:Attack(p.target,{owner='EngageAttack',context=p.context,ttl=200,
   validate=function()return self:PlanValid(p)and p.qObserved and self:QActive()and self:InAttackRange(p.target)end,
   observe=function(q)return self:CompletedAttack(q,p.target)end})
  if ok then p.phase='attack_requested';Core:AfterAttack(function()if self:PlanValid(p)then p.phase='attack_observed'end end)end
 end
end
-- Area R: the epicenter goes on one enemy (stunned) and every enemy the 325 area reaches counts toward RCount.
-- Bounded: at most five enemies, one epicenter and one area prediction each, positions copied out at once.
function LeonaChampion:AreaPlan(minimum)
 local rows=Core:Rows('hero',self.RSpell.Range+self.profile.rArea);local spots={}
 for i=1,math.min(#rows,5)do local u=rows[i]
  if self:Allowed(u)and self:Open(u)then
   local pred=Core:Prediction(self.RSpell);pred:GetPrediction(u,myHero)
   if pred:CanHit(2)then local c=pred.CastPosition;spots[#spots+1]={unit=u,pos={x=c.x,y=c.y,z=c.z}}end
  end
 end
 local best,bestCount
 for i=1,#spots do local u=spots[i].unit
  if GetDistance(u.pos,myHero.pos)<=self.RSpell.Range then
   local pred=Core:Prediction(self.RStun);pred:GetPrediction(u,myHero)
   if pred:CanHit(3)and GetDistance(pred.CastPosition,myHero.pos)<=self.RSpell.Range then
    local aim=Vector(pred.CastPosition.x,pred.CastPosition.y,pred.CastPosition.z);local n=0
    for j=1,#spots do if j==i or GetDistance(spots[j].pos,aim)<=self.profile.rArea then n=n+1 end end
    if n>=minimum and(not bestCount or n>bestCount)then best,bestCount={unit=u,aim=aim},n end
   end
  end
 end
 return best,bestCount
end
function LeonaChampion:AreaR()
 if self.engage or not Menu.Combo.R:Value()or not self:Ready(_R)then return false end
 local plan=self:AreaPlan(Menu.Combo.RCount:Value());if not plan then return false end
 local function fresh()
  if self.engage or not Menu.Combo.R:Value()then return nil,'r_plan_changed'end
  local p=self:AreaPlan(Menu.Combo.RCount:Value())
  if not p or p.unit~=plan.unit then return nil,'r_count_lost'end
  return {position=p.aim}
 end
 if Core:Cast(HK_R,plan.aim,{intentTarget=plan.unit,deferAttackWindup=true,prevalidateWorldCast=true,resolve=fresh,
  validate=function()return Menu.Combo.R:Value()and not self.engage end})then self:ProbeR(plan.unit);return true end
 return false
end
-- E, Q (when ready) and one attack after R land: the burst that follows a single-target R.
function LeonaChampion:ComboKills(t)
 if GetDistance(t.pos,myHero.pos)>self.ESpell.Range then return false end
 return Core:Lethal(t,self.RSpell.Delay,function()
  return self:GetRDmg(t)+(self:Ready(_E)and self:GetEDmg(t)or 0)+(self:Ready(_Q)and self:GetQDmg(t)or 0)+self:AttackDamage(t)end)
end
-- Single-target R: an opener on an enemy beyond E reach while E and Q are ready (the stun holds it for the engage), or
-- the R that makes the full combo lethal. Epicenter aim; never during an engage plan (ChainR owns that one).
function LeonaChampion:SingleReason(t)
 if self.engage or not Menu.Combo.R:Value()or not Menu.Combo.RSingle:Value()or not self:Ready(_R)or not IsValid(t)
  or not self:Allowed(t)or not self:Open(t)then return nil end
 local d=GetDistance(t.pos,myHero.pos);if d>self.RSpell.Range then return nil end
 if d>self.ESpell.Range and Menu.Combo.E:Value()and self:Ready(_E)and self:Ready(_Q)then return 'open'end
 if self:ComboKills(t)then return 'kill'end
end
function LeonaChampion:SingleR(t)
 local reason=self:SingleReason(t);if not reason then return false end
 if self:CastR(t,3,function()return self:SingleReason(t)==reason end,nil,self.RStun)then self:ProbeR(t);return true end
 return false
end
function LeonaChampion:Combo()
 local t=GetTarget(self.RSpell.Range);if not IsValid(t)or not t.pos2D.onScreen then return end
 if self:AreaR()then return end
 if self:SingleR(t)then return end
 -- R can consider farther enemies; the remaining combo needs a target E reaches.
 if GetDistance(t.pos,myHero.pos)>self.ESpell.Range then
  t=GetTarget(self.ESpell.Range);if not IsValid(t)or not t.pos2D.onScreen then return end
 end
 if self:CombatW(t,'Combo')then return end
 if Menu.Combo.E:Value()and not self:InAttackRange(t)and not self.engage and self:Allowed(t)and not self:EOverlaps(t)
  and self:CastE(t,2,function()return self:Allowed(t)and not self:EOverlaps(t)end)then return end
 if not self.engage and not self:QOverlaps(t)and self:QUseful(t)then self:CastQ(t,'Combo',function()return not self:QOverlaps(t)and self:QUseful(t)end)end
end
function LeonaChampion:Harass()
 if not manaAbove(Menu.Harass.Mana:Value())then return end
 local t=GetTarget(self.ESpell.Range);if not IsValid(t)or not t.pos2D.onScreen then return end
 if self:CombatW(t,'Harass')then return end
 if Menu.Harass.E:Value()and not self:InAttackRange(t)and not self.engage and self:Allowed(t)and not self:EOverlaps(t)
  and self:CastE(t,3,function()return self:Allowed(t)and not self:EOverlaps(t)end)then return end
 if not self.engage and not self:QOverlaps(t)and self:QUseful(t)then self:CastQ(t,'Harass',function()return not self:QOverlaps(t)and self:QUseful(t)end)end
end
function LeonaChampion:FarmMode(jungle)
 local modes=_G.SDK.Orbwalker.Modes
 return modes[jungle and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or _G.SDK.ORBWALKER_MODE_LANECLEAR]==true
end
function LeonaChampion:FarmUnits(jungle,range)
 local n=Game.MinionCount();if not finite(n)or n<0 or n%1~=0 or n>512 then return nil end
 local result={}
 for i=1,n do local u=Game.Minion(i)
  if u and u.type==Obj_AI_Minion and IsValid(u)and u.team~=myHero.team and (u.team==300)==jungle and GetDistance(myHero.pos,u.pos)<=range then result[#result+1]=u end
 end
 return result
end
function LeonaChampion:FarmPermission(jungle)
 return GetMode()=='LaneClear'and self:FarmMode(jungle)and Menu.Clear.Enabled:Value()and manaAbove(Menu.Clear.Mana:Value())
end
-- Lane W needs Clear.W minions; jungle W goes on any large monster (or Clear.W monsters).
function LeonaChampion:ClearWWorth(jungle)
 local list=self:FarmUnits(jungle,self.WRange);if not list then return false end
 if #list>=Menu.Clear.W:Value()then return true end
 if jungle then for i=1,#list do if self:LargeMonster(list[i])then return true end end end
 return false
end
function LeonaChampion:Largest(list)
 local best;for i=1,math.min(#list,16)do local u=list[i];if not best or u.maxHealth>best.maxHealth then best=u end end
 return best
end
function LeonaChampion:Clear()
 if not Menu.Clear.Enabled:Value()or not manaAbove(Menu.Clear.Mana:Value())then return end
 for _,jungle in ipairs({false,true})do
  if self:FarmPermission(jungle)and self:Ready(_W)and self:ClearWWorth(jungle)then
   return Core:Cast(HK_W,nil,{owner='Clear',context=Core:ModeContext('LaneClear',function()return self:FarmMode(jungle)end),
    validate=function()return self:FarmPermission(jungle)and self:ClearWWorth(jungle)end})
  end
 end
 if self:FarmPermission(true)and Menu.Clear.E:Value()then
  local list=self:FarmUnits(true,self.ESpell.Range);local best=list and self:Largest(list)
  if best then return self:CastE(best,2,function()return self:FarmPermission(true)and Menu.Clear.E:Value()end,true)end
 end
end
function LeonaChampion:DashThreat(t,recipient)
 if not IsValid(t)or not recipient or recipient.dead or recipient.health<=0 or not t.pathing or not t.pathing.isDashing or not t.pathing.endPos then return false end
 local finish=GetDistance(t.pathing.endPos,recipient.pos)
 return finish<=350 and finish+50<GetDistance(t.pos,recipient.pos)
end
function LeonaChampion:AntiDash()
 if not Menu.Misc.AntiDash:Value()or not self:Ready(_E)then return end
 local heroes=self:Heroes();if not heroes then return end
 for _,t in ipairs(heroes)do if t.team~=myHero.team and IsValid(t)then
  local recipient=self:DashThreat(t,myHero)and myHero or nil
  -- A support peels: an ally within 700 is protected exactly like Leona herself.
  if not recipient then
   for _,a in ipairs(heroes)do if a.team==myHero.team and GetDistance(a.pos,myHero.pos)<=700 and self:DashThreat(t,a)then recipient=a;break end end
  end
  if recipient then
   local finish=t.pathing.endPos;local endpoint=Vector(finish.x,finish.y,finish.z)
   if self:CastE(t,2,function()return Menu.Misc.AntiDash:Value()and (recipient==myHero or GetDistance(recipient.pos,myHero.pos)<=700)and self:DashThreat(t,recipient)and GetDistance(endpoint,t.pathing.endPos)<=75 end)then return true end
  end
 end end
end
-- The root does not stop a channel; the Q stun after arrival does (InterruptQ
-- takes over once the enemy is in attack range). So this dash is only worth it
-- when Q can follow and the channel outlasts blade flight, the dash and the
-- attack, and it is bounded like the finisher: never into more than two
-- enemies, never under a turret (RayLegal). An enemy already in attack range
-- is InterruptQ's. The dash speed is not published, so its time is a flat margin.
function LeonaChampion:InterruptE()
 if not Menu.Misc.InterruptE:Value()or not self:Ready(_E)or not(self:Ready(_Q)or self:QActive())then return end
 local heroes=self:Heroes();if not heroes then return end
 local function lasts(a,t)return type(a.castEndTime)=='number'and a.castEndTime>Game.Timer()+.25+GetDistance(t.pos,myHero.pos)/2000+.6 end
 for _,t in ipairs(heroes)do if t.team~=myHero.team and IsValid(t)and not self:InAttackRange(t)and GetEnemyCount(700,t.pos)<=2 then
  local a=t.activeSpell
  if Core:IsChannelCast(a,true)and a.isInterruptible~=false and type(a.startTime)=='number'and lasts(a,t)then
   local started=a.startTime
   if self:CastE(t,3,function()local b=t.activeSpell;return Menu.Misc.InterruptE:Value()and Core:IsChannelCast(b)and b.startTime==started and lasts(b,t)
    and GetEnemyCount(700,t.pos)<=2 and(self:Ready(_Q)or self:QActive())end)then return true end
  end
 end end
end
-- Q's stun is the kit's interrupt (the E root does not stop a channel): arm Q
-- on an enemy channelling inside attack range and deliver it with one owned
-- attack. Needs no mode key; the channel must outlast the attack windup.
function LeonaChampion:InterruptQ()
 local p=self.interrupt
 local function live(t)return Menu.Misc.InterruptQ:Value()and IsValid(t)and self:InAttackRange(t)end
 if p then
  if Game.Timer()>p.expires or p.target.networkID~=p.id or not live(p.target)then self.interrupt=nil;return false end
  if not p.attack and self:QActive()then
   local ok=Core:Attack(p.target,{owner='InterruptAttack',ttl=250,
    validate=function()return self.interrupt==p and self:QActive()and live(p.target)end,
    observe=function(q)return self:CompletedAttack(q,p.target)end})
   if ok then p.attack=true;Core:AfterAttack(function()if self.interrupt==p then self.interrupt=nil end end)end
  end
  return true
 end
 if not Menu.Misc.InterruptQ:Value()or self.engage or self.farm then return false end
 local armed=self:QActive();if not armed and not self:Ready(_Q)then return false end
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)or windup<0 or windup>2 then return false end
 local heroes=self:Heroes();if not heroes then return false end
 for _,t in ipairs(heroes)do if t.team~=myHero.team and live(t)and Core:CanInterrupt(t,windup+.1)then
  local plan={target=t,id=t.networkID,expires=Game.Timer()+1.25}
  if armed or Core:Cast(HK_Q,nil,{owner='InterruptQ',intentTarget=t,range=math.huge,
   validate=function()return live(t)and Core:CanInterrupt(t,windup+.05)and not self:QActive()end})then self.interrupt=plan;return true end
 end end
 return false
end
-- spell: self.RStun (epicenter aim, the stun) or self.RSpell (area, damage). Default: the epicenter.
function LeonaChampion:CastR(t,hc,validate,context,spell)
 if not self:Ready(_R)or not IsValid(t)or GetDistance(myHero.pos,t.pos)>self.RSpell.Range or validate and not validate()then return false end
 local p=Core:Prediction(spell or self.RStun);p:GetPrediction(t,myHero)
 if p:CanHit(hc or 3)then return Core:Cast(HK_R,p.CastPosition,{intentTarget=t,context=context,deferAttackWindup=true,prevalidateWorldCast=true,validate=validate})end
 return false
end
-- Dev recorder: R request to the enemy's crowd-control start (settles the cast + impact delay).
function LeonaChampion:ProbeR(t)
 if not Core.logger then return end
 self.rProbe={unit=t,id=t.networkID,at=Game.Timer(),expires=Game.Timer()+2}
end
function LeonaChampion:WatchR()
 local p=self.rProbe;if not p then return end
 if Game.Timer()>p.expires or not IsValid(p.unit)or p.unit.networkID~=p.id then self.rProbe=nil;return end
 for _,b in ipairs(Core:Fresh(GetBuffs,p.unit))do
  if(b.type==5 or b.type==10)and finite(b.startTime)and b.startTime>=p.at and type(b.name)=='string'and b.name:find('SolarFlare',1,true)then
   Core:Trace('leona_r_impact',{delay=b.startTime-p.at,kind=b.type});self.rProbe=nil;return
  end
 end
end
-- R stops a channel beyond E reach: the stun lands after cast and impact delay, on an enemy who cannot move away.
function LeonaChampion:InterruptR()
 if not Menu.Misc.InterruptR:Value()or not self:Ready(_R)then return false end
 local delay=self.RSpell.Delay+.05
 for _,t in ipairs(Core:Rows('hero',self.RSpell.Range))do
  if GetDistance(t.pos,myHero.pos)>self.ESpell.Range and self:Allowed(t)and self:Open(t)and Core:CanInterrupt(t,delay)then
   local a=t.activeSpell;local name,started=a.name,a.startTime
   if self:CastR(t,2,function()local b=t.activeSpell
    return Menu.Misc.InterruptR:Value()and b and b.name==name and b.startTime==started and Core:CanInterrupt(t,delay)and self:Open(t)end,{priority='interactive'})then
    self:ProbeR(t);return true
   end
  end
 end
 return false
end
function LeonaChampion:ControlRemaining(t)
 if not IsValid(t)or not finite(t.buffCount)or t.buffCount<0 or t.buffCount%1~=0 or t.buffCount>128 then return 0 end
 local now,remaining=Game.Timer(),0
 for _,b in ipairs(Core:Fresh(GetBuffs,t))do
  local finish=buffExpiry(b)
  if (b.type==5 or b.type==12 or b.type==25 or b.type==35)and b.valid~=false
   and finite(b.count)and b.count>0 and finite(b.startTime)and b.startTime<=now and finite(finish)and finish>now then remaining=math.max(remaining,finish-now)end
 end
 return remaining
end
function LeonaChampion:ChainR()
 local p=self.engage
 if not p or p.rIssued or p.mode~='Combo'or not p.arrived or not self:PlanValid(p)
  or not Menu.Combo.R:Value()or not Menu.Combo.ChainR:Value()or not self:Ready(_R)then return false end
 local function legal()
  -- The native CC expiry is fresh. Delay and .1s dispatch margin remain
  -- explicit conservative planning candidates, not guaranteed stun timing.
  return self:PlanValid(p)and p.arrived and Menu.Combo.R:Value()and Menu.Combo.ChainR:Value()
   and self:ControlRemaining(p.target)>=self.RSpell.Delay+.1
 end
 if self:CastR(p.target,3,legal,p.context,self.RStun)then p.rIssued=true;self:ProbeR(p.target);return true end
 return false
end
function LeonaChampion:FarmCurrent(p)
 if self.farm~=p or Game.Timer()>p.expires or GetMode()~='LastHit'or not Menu.LastHit.Q:Value()
  or not manaAbove(Menu.LastHit.Mana:Value())or not IsValid(p.target)
  or p.target.networkID~=p.id or p.target.handle~=p.handle or not self:InAttackRange(p.target)then return false end
 local n=Game.MinionCount();if not finite(n)or n<0 or n%1~=0 or n>512 then return false end
 for i=1,n do if Game.Minion(i)==p.target then return true end end
 return false
end
function LeonaChampion:QRescue(t,armed)
 if not IsValid(t)or t.type~=Obj_AI_Minion or t.team==300 or t.team==myHero.team or not self:InAttackRange(t)
  or not _G.SDK.Orbwalker:CanAttack()then return false end
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)or windup<0 or windup>2 then return false end
 local dt=windup+(armed and 0 or .15)
 local hp=Core:UnshieldedLegacyForecast(t,dt);if not finite(hp)or hp<=0 then return false end
 local aa=_G.SDK.Damage:CalculateDamage(myHero,t,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)
 local needed=hp+math.max(0,t.hpRegen or 0)*dt
 if not finite(aa)or aa+self:GetQDmg(t)<needed then return false end
 if not armed then
  local aaHP=Core:UnshieldedLegacyForecast(t,windup)
  if finite(aaHP)and aaHP>0 and aa>=aaHP+math.max(0,t.hpRegen or 0)*windup then return false end
 end
 return true
end
function LeonaChampion:LastHit()
 if self.farm or not Menu.LastHit.Q:Value()or not manaAbove(Menu.LastHit.Mana:Value())
  or not self:Ready(_Q)or self:QActive()or not _G.SDK.Orbwalker:CanAttack()then return false end
 local rows=self:FarmUnits(false,400);if not rows then return false end
 local target
 for i=1,math.min(#rows,40)do local t=rows[i]
  if self:QRescue(t,false)and(not target or t.maxHealth>target.maxHealth)then target=t end
 end
 if not target then return false end
 local p={target=target,id=target.networkID,handle=target.handle,expires=Game.Timer()+1}
 self.farm=p
 local ok=Core:Cast(HK_Q,nil,{owner='RescueQ',intentTarget=target,range=math.huge,independent=false,context=Core:ModeContext('LastHit'),
  validate=function()return self:FarmCurrent(p)and self:QRescue(target,false)and not self:QActive()end})
 if not ok then self.farm=nil;return false end
 p.q=Core.lastIntent
 -- This callback runs once the shared observer has seen the cast (a native
 -- cast or the slot's own state change). Reading the native cast again here
 -- asked for evidence the host no longer shows at this moment for an instant Q,
 -- so the plan held the tick for its full second and never attacked.
 Core:AfterCast(HK_Q,function()if self.farm==p then p.nativeQ=true end end)
 return true
end
function LeonaChampion:ContinueFarm()
 local p=self.farm;if not p then return false end
 if not self:FarmCurrent(p)or p.q.ambiguous or p.q.cancelled then self.farm=nil;return false end
 if p.attackIssued or not p.nativeQ or not self:QActive()then return true end
 if not self:QRescue(p.target,true)then self.farm=nil;return false end
 local ok=Core:Attack(p.target,{owner='RescueQAttack',context=Core:ModeContext('LastHit'),ttl=250,
  validate=function()return self:FarmCurrent(p)and p.nativeQ and self:QActive()and self:QRescue(p.target,true)end,
  observe=function(q)
   local a=Core:NativeAttack(q)
   return a and(a.target==p.handle or a.target==p.id)and finite(a.castEndTime)and a.castEndTime<=Game.Timer()and Game.Timer()-a.castEndTime<=.35
  end})
 if ok then p.attackIssued=true;Core:AfterAttack(function()if self.farm==p then self.farm=nil end end)end
 return true
end
function LeonaChampion:Flee()
 -- Low-health W is AutoW: it runs every tick, Flee included.
 if not Menu.Misc.FleeQ:Value()or not self:Ready(_Q)or self:QActive()then return false end
 local t=GetTarget(350);if not IsValid(t)or not self:InAttackRange(t)then return false end
 return Core:Cast(HK_Q,nil,{owner='FleeQ',intentTarget=t,range=math.huge,
  validate=function()return Menu.Misc.FleeQ:Value()and self:InAttackRange(t)and not self:QActive()end})
end
function LeonaChampion:PreparePreview()
 -- R landing only: the game shows W and Sunlight. Kept for a second so a late preparation never blinks it;
 -- Draw needs R ready and the target alive and seen.
 local p={expires=Game.Timer()+1}
 local t=GetTarget(self.RSpell.Range)
 if IsValid(t)then
  p.target=t.networkID;p.unit=t
  if self:Ready(_R)then local pred=Core:Prediction(self.RStun);pred:GetPrediction(t,myHero)
   if pred:CanHit(3)then local pos=pred.CastPosition;p.position=Vector(pos.x,pos.y,pos.z)end
  end
 end
 self.preview=p
end
function LeonaChampion:SemiR()
 if not Menu.SemiR.Key:Value()or not self:Ready(_R)then return false end
 local t=GetTarget(self.RSpell.Range);if not IsValid(t)or not t.pos2D.onScreen then return false end
 return self:CastR(t,3,nil,nil,self.RStun)
end
function LeonaChampion:KillSteal()
 local heroes=self:Heroes();if not heroes then return end
 for _,t in ipairs(heroes)do if t.team~=myHero.team and IsValid(t)and t.pos2D.onScreen and self:Allowed(t)then
  -- The shared kill rule: health when the spell lands, magic shields, spell shields.
  local function kills(impact,damage)return Core:Lethal(t,impact,damage,{kind='magical'})end
  if Menu.KillSteal.E:Value()and self:Ready(_E)and GetEnemyCount(700,t.pos)<=2
   and kills(self.ESpell.Delay+GetDistance(t.pos,myHero.pos)/self.ESpell.Speed,function()return self:GetEDmg(t)end)
   and self:CastE(t,3,function()return Menu.KillSteal.E:Value()and GetEnemyCount(700,t.pos)<=2 end)then return end
  if Menu.KillSteal.R:Value()and self:Ready(_R)and GetDistance(t.pos,myHero.pos)<=self.RSpell.Range
   and kills(self.RSpell.Delay,function()return self:GetRDmg(t)end)and self:CastR(t,3,nil,nil,self.RSpell)then return end
 end end
end
function LeonaChampion:Tick()
 if ShouldWait()then self.engage=nil;self.farm=nil;self.preview=nil;self.interrupt=nil;return end
 self:ObserveEngage()
 if self:ContinueFarm()or IsCasting()then return end
 if self:InterruptQ()then return end
 if self.previewFallback and Menu.Draw.Preview:Value()and Game.Timer()>=(self.nextPreview or 0)then self.nextPreview=Game.Timer()+.125;self:PreparePreview()end
 self.allow:Maintain();self:WatchR()
 if self:ChainR()then return end
 self:AutoW();self:AntiDash();self:InterruptE()
 if self:InterruptR()then return end
 if self:SemiR()then return end
 self:KillSteal()
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LaneClear'then self:Clear()
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function LeonaChampion:Magic(t,raw)return _G.SDK.Damage:CalculateDamage(myHero,t,_G.SDK.DAMAGE_TYPE_MAGICAL,raw,true)end
function LeonaChampion:GetQDmg(t)local n=myHero:GetSpellData(_Q).level;return n>0 and self:Magic(t,self.profile.q[n]+myHero.ap*.3)or 0 end
function LeonaChampion:GetEDmg(t)local n=myHero:GetSpellData(_E).level;return n>0 and self:Magic(t,self.profile.e[n]+myHero.ap*.4)or 0 end
function LeonaChampion:GetRDmg(t)local n=myHero:GetSpellData(_R).level;return n>0 and self:Magic(t,self.profile.r[n]+myHero.ap*.8)or 0 end

function LeonaChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},
  safe={node=Menu.Misc.TurretDive,label='E turret dive'},w={node=Menu.Misc.AutoW,label='Low-health W'},
  peel={node=Menu.Misc.AntiDash,label='Anti-dash E'},farm={node=Menu.Clear.Enabled,label='Spell farming'},
  semi={node=Menu.SemiR.Key,label='Assisted R binding'},r={node=Menu.Combo.RCount,label='R area hit count'}}
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Leona: controls','Leona: engage and defense','Leona: farming and limits'},function(page)
  if page==1 then return {title=self.classic and 'Classic Leona'or 'Leona',cards={
   {'COMBO','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..'. Each spell has separate permission. [[q]] empowers the next attack; it is not a held-key charge.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. Harass mana consent applies to pre-attack Q too. Releasing the mode cancels waiting work.'},
   {'ASSISTED R','Hold [[semi]]. Combo R puts the stunning center on one enemy and counts every enemy the outer area reaches toward [[r]]; it also follows up on a single enemy still stunned after E and Q, opens on a lone enemy beyond E reach while E and Q are ready, and goes out when the full combo kills. A killable enemy is finished with R (and, if enabled, E) without a mode key; per-enemy engage switches apply.'}}}end
  if page==2 then return {title='Engage and defense',cards={
   {'E AND Q','E passes through units. A possible farther champion on its full ray causes refusal, and so does a spell shield. E is refused when the target or the landing behind it is under a turret, unless [[safe]] allows a kill you survive. With [[q]] enabled, Q is armed as soon as the E root is seen, during the dash, and the first attack on arrival stuns. Q and E are not spent on an enemy already held longer than they would add.'},
   {'W','[[w]] uses a conservative low-health and nearby-enemy policy. Combat W needs a victim within 450, or starts as the E engage goes out so it is running during the dive. W grants defenses; no absorb shield or guaranteed explosion is assumed.'},
   {'PEEL','[[peel]] rejects escaping or ended dashes. Allies within 700 are peeled the same way. An enemy who channels inside attack range is stunned with Q and one attack, without a mode key. A channelling enemy farther away is reached with E when Q can follow, the channel lasts long enough, and no more than two enemies or a turret wait there.'}},note='Harass keeps E off by default: it is a committing dash.'}end
  return {title='Farming and limits',cards={
   {'CLEAR','Lane and jungle use their own provider binds with [[farm]] enabled. LastHit Q rescues a reachable minion only when a normal attack cannot take it.'},
   {'PROFILE',self.classic and 'Classic uses its own Q, E and R damage and aliases. The default native W record has armor and magic resistance; the server W variant remains unverified.'or 'Normal uses current named Q, E and R damage. Sunlight needs an ally to consume it. Removed historical R empowered attacks are not included.'},
   {'LIMITS','Low-health W also applies in Flee, which can also arm Q against a pursuer in attack range (off by default: Flee does not attack by itself). Exact R center/effect timing and W extension still need live proof.'}}}
 end,cfg,links,activate)
end

function LeonaChampion:Draw()
	if Menu.Draw.Engage:Value()and self.engage and IsValid(self.engage.target)then Draw.Circle(self.engage.target.pos,90,1,Draw.Color(200,244,180,50))end
	if myHero.dead then return end
	local p=self.preview
	local u=p and p.unit
	if Menu.Draw.Preview:Value()and p and p.expires>Game.Timer()and p.position and IsReady(_R)and u and not u.dead and u.visible~=false then
	 Draw.Circle(p.position,self.RStun.Radius,1,Draw.Color(220,244,180,50));Draw.Circle(p.position,self.RSpell.Radius,1,Draw.Color(120,244,180,50))
	end
	if Menu.Draw.Q:Value() and IsReady(_Q) then Draw.Circle(myHero.pos, (myHero.range or 125)+(myHero.boundingRadius or 65)+self.profile.qBonusRange, 1, Draw.Color(255, 66, 244, 113)) end
	if Menu.Draw.W:Value() and IsReady(_W) then Draw.Circle(myHero.pos, self.WRange, 1, Draw.Color(255, 244, 238, 66)) end
	if Menu.Draw.E:Value() and IsReady(_E) then Draw.Circle(myHero.pos, self.ESpell.Range, 1, Draw.Color(255, 66, 229, 244)) end
	if Menu.Draw.R:Value() and IsReady(_R) then Draw.Circle(myHero.pos, self.RSpell.Range, 1, Draw.Color(255, 244, 66, 96)) end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:RegisterPolicy({
    damageTypes={Q='magical',E='magical',R='magical'},
    methods={
        AutoW=function()return {priority='interactive'}end,
        InterruptR=function()return {priority='interactive'}end,
        AntiDash=function()return {priority='interactive'}end,
        InterruptE=function()return {priority='interactive'}end,
        InterruptQ=function()return {priority='interactive'}end,
        OnPreAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode) or nil end,

        Combo=function()return Core:ModeContext("Combo")end,
        Harass=function()return Core:ModeContext("Harass")end,
        Clear=function()return Core:ModeContext("LaneClear")end,
        LastHit=function()return Core:ModeContext('LastHit')end,
        Flee=function()return Core:ModeContext('Flee')end,
        SemiR=function()return Core:HeldContext(function()return Menu.SemiR.Key:Value()end)end,
    },
    exceptions={non_interrupting_summoner=true},
    channel=function(self,q)return not Core:SelfChanneling() end,
    validate=function(self,q,slot,resolved)
        if slot and slot<=_R and not self:Ready(slot)then return false end
        -- Only the engage's own Q goes out during the E dash (armed for the arrival attack).
        if myHero.pathing and myHero.pathing.isDashing and not(slot==_Q and q and q.owner=='EngageQ')then return false end
        if slot==_Q then return not self:QActive()end
        return true
    end,
})

LeonaChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Leona"]="Leona"}
local normalSupported={["Leona"]=true}

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
