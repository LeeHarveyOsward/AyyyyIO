return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Malphite"]=function()return _G.OrbamaFamily:Require("7630a90327b9d8f14051f2357dfd7bdcd8c0a780a1ea1fc51d4c87472552036d")()end
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
if champion=="Malphite" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Malphite',profiles={normal=true,classic=true},
 Create=function(context)
-- Shared decisions with installed Normal/Classic mechanics. Static evidence is
-- not live acceptance; R timing uses the extracted spell's conservative horizon.
local profiles=ChampionProfiles('Malphite')
local finite,point,identity,manaAbove,buffExpiry=Core.finite,Core.point,Core.id,Core.manaAbove,Core.buffExpiry
local readyAttack={attack='ready'}
local MalphiteChampion=class("MalphiteChampion")
function MalphiteChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self:LoadMenu()
 self.RRange=1000;self.ERange=400
 -- R is a dash, not a missile: no cast time and 1500 + current movement speed (profile); the speed is refreshed per plan.
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=self.profile.rDelays[1],Radius=self.profile.rRadius,Range=1000,Speed=self:RSpeed(),Collision=false}
 self.allow=Core:TargetConsent(Menu.Combo.Targets,self,'Engage with R on: ');self.allow:Refresh()
 -- Flash, then R onto a group just beyond R range (shared Core:FlashFollow, flash_first).
 self.flashCombo=Core.FlashFollow and Core:FlashFollow('MalphiteFlashR')
 self.marks={}
 -- Health-bar damage: ready Q, E and R plus one attack.
 Core:RegisterComboDamage(function(u)
  if not IsValid(u)then return 0 end
  local total=(self:Ready(_Q)and self:GetQDmg(u)or 0)+(self:Ready(_E)and self:GetEDmg(u)or 0)+(self:Ready(_R)and self:GetRDmg(u)or 0)
  local ok,aa=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
  return total+(ok and finite(aa)and aa or 0)
 end)
 self.QSpell=AbilityProfiles.Spell(myHero.charName,'Q',OrbamaPrediction)
 self.ESpell=AbilityProfiles.Spell(myHero.charName,'E',OrbamaPrediction)
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 if Core.RegisterCleanup then Core:RegisterCleanup('Malphite',function(reason)
  -- Shutdown has already disabled guarded champion methods. This owned cleanup
  -- therefore releases its request and local references directly.
  local p=self.landing;if p and p.action then Core.adapter:Cancel(p.action,reason or 'controller_closed')end
  if self.flashCombo then self.flashCombo:Cancel(reason or 'controller_closed')end
  self.landing=nil;self.preview=nil;self.attack=nil;self.wUntil=nil;self.marks={};self.ready=nil
 end)end
 -- Unstoppable Force as an Evade dash. It is the ultimate: lethalOnly asks Evade to
 -- spend it only against a hit that would kill (or hard crowd control it judges as
 -- lethal), at any health. The player's engage limits do not apply to a dodge;
 -- wall and enemy turret do.
 local p=self.profile
 self.mobilityOffered,self.mobilityReason=Core:RegisterMobility({kind='dash',slot=_R,key=HK_R,name=p.r,range=p.rRange,speeds=p.rSpeeds,castDelays=p.rDelays,toPoint=true,
  lethalOnly=true,profile=p.id,label='Unstoppable Force',source=p.rSource,allowed=function(target)
   if self.landing then return false,'engage_in_progress'end
   if target==nil then return true end
   if GetDistance(target,myHero.pos)>p.rRange+.01 then return false,'out_of_range'end
   return type(Game.isWall)=='function'and Game.isWall(target)==false and not IsUnderTurret2(target),'unsafe_landing'
  end})
end
function MalphiteChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Malphite'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R to engage',value=true})
 Menu.Combo:MenuElement({id='RCount',name='R must hit this many enemies',value=2,min=1,max=5,step=1})
 Menu.Combo:MenuElement({type=MENU,id='Targets',name='Enemy champions R may engage'})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu.Clear[mode]:MenuElement({id=slot,name=slot=='Q'and mode=='LaneClear'and 'Use Q on minions an attack cannot take'or 'Use '..slot,value=true})end
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='ECount',name='Lane minions E must hit',value=3,min=1,max=10,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='E',name='Use E on a lone minion an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=15,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='RHP',name='Never engage with R below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='REnemies',name='Never land R among more enemies than',value=3,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='ReserveQ',name='Engage only with Q ready and mana for it',value=true,menu=false})
 Menu.Misc:MenuElement({id='RequireShield',name='Engage only while the passive shield is up',value=false,menu=false})
 Menu.Misc:MenuElement({id='RFinish',name='Use R to finish a kill without a mode key',value=false})
 Menu.Misc:MenuElement({id='InterruptR',name='Use R to stop a dangerous channel',value=true})
 Menu.Misc:MenuElement({id='FlashR',name='In Combo, Flash and R a group just out of R range',value=false})
 Menu.Misc:MenuElement({id='FleeQ',name='Use Q to slow a chasing enemy in Flee',value=true})
 Menu.Misc:MenuElement({id='FleeR',name='Use R toward the cursor in Flee',value=false})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ability ranges while ready',value=false})
 Menu.Draw:MenuElement({id='Kills',name='Mark enemies an R engage kills',value=true})
 Menu.Draw:MenuElement({id='Preview',name='R landing spot',value=true})
end
function MalphiteChampion:Reach(target,range)return IsValid(target)and target.team~=myHero.team and GetDistance(target.pos,myHero.pos)<=range end
-- Charge speed: 1500 + current movement speed (profile), in 25-unit steps so the prediction object is reused.
function MalphiteChampion:RSpeed()
 local p=self.profile;local ms=myHero.ms
 if not finite(ms)or ms<=0 then return p.rSpeeds[1]end
 return math.floor((p.rBaseSpeed+ms)/25)*25
end
-- Per-enemy engage consent (Combo R, kill engage, keyless finisher). The selected-target bind is the player's own choice.
function MalphiteChampion:Allowed(u)return self.allow:Allowed(u)==true end
function MalphiteChampion:SelfBuff(name)
 local count=myHero.buffCount;if not finite(count)or count<0 or count%1~=0 or count>128 then return nil,'buff_snapshot_unknown'end
 local found
 for i=0,count do local b=myHero:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==name:lower()then
   if not finite(b.count)or b.count<0 then return nil,'buff_count_unknown'end
   if b.count>0 then
   local source=b.source;local id=type(source)=='table'or type(source)=='userdata'
   if id then source=identity(source)end
   if source~=nil and source~=0 and source~=myHero.networkID and source~=myHero.handle
    or b.sourcenID~=nil and b.sourcenID~=0 and b.sourcenID~=myHero.networkID and b.sourcenID~=myHero.handle then return nil,'foreign_buff'end
   local expiry=buffExpiry(b)
   if not finite(expiry)then return nil,'buff_expiry_unknown'end
   if expiry>Game.Timer()then if found then return nil,'duplicate_buff'end;found=b end
   end
  end
 end
 return found
end
function MalphiteChampion:Ready(slot)
 local key=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot];local s=myHero:GetSpellData(slot)
 if not key or not s or s.name~=self.profile[key]or not IsReady(slot)or not finite(s.mana)or s.mana<0 or s.mana>myHero.mana then return false end
 if slot==_W then
  if self.wUntil and self.wUntil>Game.Timer()then return false end
  if self.profile.wBuff then local b,reason=self:SelfBuff(self.profile.wBuff);if b or reason then return false end end
 end
 return true
end
function MalphiteChampion:GetQDmg(target)
 local rank=myHero:GetSpellData(_Q).level;local base=self.profile.qBase[rank]
 if not base or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.qAP*myHero.ap)
end
function MalphiteChampion:GetEDmg(target)
 local rank=myHero:GetSpellData(_E).level;local base=self.profile.eBase[rank]
 if not base or not finite(myHero.ap)or not finite(myHero.armor)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.eAP*myHero.ap+self.profile.eArmor*myHero.armor)
end
function MalphiteChampion:CastQ(target,validate,context)
 if not self:Ready(_Q)or not self:Reach(target,625)then return false end
 return Core:Cast(HK_Q,target,{intentTarget=target,range=625,context=context,deferAttackWindup=true,
  validate=function()return self:Ready(_Q)and self:Reach(target,625)and(not validate or validate())end})
end
function MalphiteChampion:CastE(target,validate,context)
 if not self:Ready(_E)or not self:Reach(target,400)then return false end
 return Core:Cast(HK_E,nil,{intentTarget=target,context=context,deferAttackWindup=true,
  validate=function()return self:Ready(_E)and self:Reach(target,400)and(not validate or validate())end})
end
function MalphiteChampion:FinishUseful(target,slot)
 local spell=slot==_Q and self.QSpell or self.ESpell
 local range=slot==_Q and spell.Range or spell.Radius
 if not self:Reach(target,range)or Core:SpellProtected(target)~=false then return false end
 if slot==_E then
  local pred=Core:Prediction(self.ESpell);pred:GetPrediction(target,myHero)
  if not pred:CanHit(OrbamaPrediction.HITCHANCE_HIGH)then return false end
 end
 local impact=OrbamaPrediction:GetImpactTime(spell,target.pos,myHero)
 local damage=slot==_Q and self:GetQDmg(target)or self:GetEDmg(target)
 local row=Core:HealthEstimate(target,impact,'magical',damage)
 return row and row.lethal or false
end
function MalphiteChampion:Finishers()
 if self.landing then return false end
 local q,e=self:Ready(_Q),self:Ready(_E)
 local r=Menu.Misc.RFinish:Value()and self:Ready(_R)
 if not q and not e and not r then return false end
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,5)do local target=list[i]
  if target and target.type==Obj_AI_Hero then local cheap=false
   for _,slot in ipairs({_E,_Q})do
    local function allowed()return self:FinishUseful(target,slot)end
    if self:Ready(slot)and allowed()then cheap=true
     local cast=slot==_Q and self.CastQ or self.CastE
     if cast(self,target,allowed,{priority='interactive'})then return true end
    end
   end
   -- The keyless R finisher (off by default, a dive): only when Q and E cannot take the kill, the engage kills at the
   -- landing, and every landing limit holds.
   if r and not cheap and self:Allowed(target)and Core:SpellProtected(target)==false then
    local plan=self:PlanR(target,1)
    if plan and self:RKills(target,plan.position)then plan.kill=true
     if self:StartR(plan,{priority='interactive',condition=function()return Menu.Misc.RFinish:Value()end},true)then return true end
    end
   end
  end
 end
 return false
end
-- R knocks up a channelling enemy: only an ultimate channel (the caster's own R) that the shared catalogue lists, a charge
-- that arrives before the channel ends, and the usual landing limits. No mode key needed.
function MalphiteChampion:UltimateChannel(t,name)
 if not(Core.ChannelNames and Core.ChannelNames[name:lower()])then return false end
 local ok,r=pcall(t.GetSpellData,t,_R)
 return ok and type(r)=='table'and r.name==name
end
function MalphiteChampion:InterruptR()
 if self.landing or not Menu.Misc.InterruptR:Value()or not self:Ready(_R)then return false end
 local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,5)do local t=list[i]
  local cast=IsValid(t)and t.team~=myHero.team and t.activeSpell
  local name=cast and cast.valid and type(cast.name)=='string'and cast.name
  if name and self:Reach(t,self.RRange+self.profile.rRadius)and self:UltimateChannel(t,name)then
   local started=cast.startTime
   local function live()local c=t.activeSpell
    return Menu.Misc.InterruptR:Value()and IsValid(t)and c and c.valid and c.name==name and c.startTime==started
     and Core:CanInterrupt(t,GetDistance(t.pos,myHero.pos)/self:RSpeed(),.1)end
   if live()then local plan=self:PlanR(t,1)
    if plan then plan.permission=live
     if self:StartR(plan,{priority='interactive',condition=function()return Menu.Misc.InterruptR:Value()end},true)then return true end
    end
   end
  end
 end
 return false
end
function MalphiteChampion:AttackPermission(target)
 local mode=GetMode();local node,context
 if target.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')then node=Menu[mode];context=Core:ModeContext(mode)
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then local jungle=target.team==300;local kind=jungle and 'jungle'or 'lane'
  if not Core:FarmModeEnabled(kind)then return nil end
  node=Menu.Clear[jungle and 'JungleClear'or 'LaneClear'];context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 end
 if node and node.W:Value()and manaAbove(node.Mana:Value())then return context end
end
function MalphiteChampion:CastW(target,context,validate)
 if not self:Ready(_W)or not IsValid(target)then return false end
 local ok=Core:Cast(HK_W,nil,{intentTarget=target,context=context,validate=function()
  return self:Ready(_W)and IsValid(target)and(not validate or validate())
 end})
 if ok then Core:AfterCast(HK_W,function()self.wUntil=Game.Timer()+self.profile.wDuration end)end
 return ok
end
function MalphiteChampion:OnPostAttack(args)
 if ShouldWait()or self.landing then return end
 local witness=Core:AttackWitness(self.attack,args and args.Target)
 if not witness or witness==self.attack or witness.at>Game.Timer()then return end
 self.attack=witness;local target=witness.object;local context=self:AttackPermission(target)
 if not context or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return end
 return self:CastW(target,context,function()
  return self.attack==witness and Game.Timer()-witness.at<=.35 and self:AttackPermission(target)~=nil
   and _G.SDK.Data:IsInAutoAttackRange(myHero,target)
 end)
end
function MalphiteChampion:Count(list,range,jungle)
 local n=0;for i=1,math.min(#list,jungle and 12 or 40)do local u=list[i]
  if(u.team==300)==jungle and self:Reach(u,range)then n=n+1 end
 end;return n
end
function MalphiteChampion:FarmUseful(target,slot)
 local range,delay=slot==_Q and 625 or 400,slot==_Q and .25+GetDistance(target.pos,myHero.pos)/1200 or .25
 if not self:Reach(target,range)or target.team==300 then return false end
 -- The shared LastHit rule; this champion's regressions pin the 'ready' attack weighing.
 if not Core:Rescue(target,delay,function()return slot==_Q and self:GetQDmg(target)or self:GetEDmg(target)end,readyAttack)then return false end
 if slot==_E and self:Count(_G.SDK.ObjectManager:GetEnemyMinions(400),400,false)~=1 then return false end
 return true
end
function MalphiteChampion:FarmQ(node)
 if not node.Q:Value()or not manaAbove(node.Mana:Value())or not self:Ready(_Q)then return false end
 local list=_G.SDK.ObjectManager:GetEnemyMinions(625);local best
 for i=1,math.min(#list,40)do local u=list[i];if(not best or u.maxHealth>best.maxHealth)and self:FarmUseful(u,_Q)then best=u end end
 if best then return self:CastQ(best,function()return self:FarmUseful(best,_Q)end)end
 return false
end
function MalphiteChampion:LaneClear()
 if not Core:FarmModeEnabled('lane')or not Menu.Clear.SpellFarm:Value()then return end
 local node=Menu.Clear.LaneClear;if not manaAbove(node.Mana:Value())then return end
 if node.E:Value()and self:Ready(_E)then local list=_G.SDK.ObjectManager:GetEnemyMinions(400)
  if self:Count(list,400,false)>=node.ECount:Value()then
   for i=1,math.min(#list,40)do if self:Reach(list[i],400)then return self:CastE(list[i],function()
    return self:Count(_G.SDK.ObjectManager:GetEnemyMinions(400),400,false)>=node.ECount:Value()
   end)end end
  end
 end
 return self:FarmQ(node)
end
function MalphiteChampion:JungleClear()
 if not Core:FarmModeEnabled('jungle')or not Menu.Clear.SpellFarm:Value()then return end
 local node=Menu.Clear.JungleClear;if not manaAbove(node.Mana:Value())then return end
 local q=node.Q:Value()and self:Ready(_Q);local e=node.E:Value()and self:Ready(_E);if not q and not e then return end
 local list=_G.SDK.ObjectManager:GetMonsters(625);local best
 for i=1,math.min(#list,12)do local u=list[i];if self:Reach(u,625)and(not best or u.maxHealth>best.maxHealth)then best=u end end
 if best then if e and self:Reach(best,400)then return self:CastE(best)elseif q then return self:CastQ(best)end end
end
function MalphiteChampion:LastHit()
 local node=Menu.LastHit;if self:FarmQ(node)then return true end
 if not node.E:Value()or not manaAbove(node.Mana:Value())or not self:Ready(_E)then return end
 local list=_G.SDK.ObjectManager:GetEnemyMinions(400)
 if self:Count(list,400,false)~=1 then return end
 for i=1,math.min(#list,40)do local u=list[i];if self:FarmUseful(u,_E)then return self:CastE(u,function()return self:FarmUseful(u,_E)end)end end
end
function MalphiteChampion:Combat(mode)
 local node=Menu[mode];if not manaAbove(node.Mana:Value())then return end
 if mode=='Combo'and node.R:Value()and self:Engage(Core:ModeContext('Combo',function()return Menu.Combo.R:Value()end),nil,true)then return true end
 local q=node.Q:Value()and self:Ready(_Q);local e=node.E:Value()and self:Ready(_E)
 -- Classic W is an armor steroid: with W enabled it is also used defensively at low health.
 local defense=self.profile.id=='classic'and node.W:Value()and self:Ready(_W)
  and myHero.maxHealth>0 and myHero.health/myHero.maxHealth<=.35
 if not q and not e and not defense then return end
 local target=GetTarget(q and 625 or 400);if not IsValid(target)then return end
 if defense and self:Reach(target,400)then return self:CastW(target,Core:ModeContext(mode),function()
  return node.W:Value()and myHero.health/myHero.maxHealth<=.35 and self:Reach(target,400)
 end)end
 if e and self:Reach(target,400)then return self:CastE(target)elseif q then return self:CastQ(target)end
end
function MalphiteChampion:Combo()return self:Combat('Combo')end
function MalphiteChampion:Harass()return self:Combat('Harass')end
function MalphiteChampion:SafeLanding(pos,offense)
 if not point(pos)or GetDistance(pos,myHero.pos)>1000 or GetDistance(pos,myHero.pos)<75
  or type(Game.isWall)~='function'or Game.isWall(pos)~=false or IsUnderTurret2(pos)
  or GetEnemyCount(600,pos)>Menu.Misc.REnemies:Value()then return false end
 if offense then
  if myHero.maxHealth<=0 or myHero.health/myHero.maxHealth*100<Menu.Misc.RHP:Value()then return false end
  if Menu.Misc.RequireShield:Value()and not self:SelfBuff(self.profile.shield)then return false end
  if Menu.Misc.ReserveQ:Value()then local s=myHero:GetSpellData(_Q)
   if not self:Ready(_Q)or myHero:GetSpellData(_R).mana+s.mana>myHero.mana then return false end
  end
 end
 return true
end
function MalphiteChampion:PredictedEnemies(anchor)
 self.RSpell.Speed=self:RSpeed()
 local rows,seen={},{};local pred=Core:Prediction(self.RSpell)
 local function add(u)
  if not self:Reach(u,1270)then return end
  local id=identity(u);if not id or seen[id]then return end;seen[id]=true
  pred:GetPrediction(u,myHero)
  if pred:CanHit(2)and point(pred.UnitPosition)then rows[#rows+1]={unit=u,id=identity(u),pos=point(pred.UnitPosition)}end
 end
  local list=Core:DecisionUnits('GetEnemyHeroes')
 local primary
 for i=1,math.min(#list,5)do local u=list[i]
  if identity(u)==identity(anchor)and u.handle==anchor.handle then primary=u;break end
 end
 -- A retained wrapper alone cannot establish that the selected hero still
 -- occupies the current roster identity. Delayed discovery refuses this R only.
 if not primary then return rows end
 add(primary)
 for i=1,math.min(#list,5)do if #rows<5 and identity(list[i])~=identity(anchor)then add(list[i])end end
 return rows
end
function MalphiteChampion:Hits(pos,rows,anchor)
 local n,primary=0,false
 for _,row in ipairs(rows)do
  if IsValid(row.unit)and identity(row.unit)==row.id and GetDistance(pos,row.pos)<=self.profile.rRadius then
   n=n+1;if row.id==identity(anchor)then primary=true end
  end
 end
 return n,primary
end
function MalphiteChampion:PlanR(anchor,need)
 if not self:Ready(_R)or not IsValid(anchor)then return nil end
 -- need: fixed hit count of the selected-target bind (1); Combo reads its slider.
 local minimum=need or Menu.Combo.RCount:Value()
 local rows=self:PredictedEnemies(anchor);if #rows<minimum then return nil end
 local candidates={};for _,row in ipairs(rows)do candidates[#candidates+1]=row.pos end
 for i=1,#rows do for j=i+1,#rows do
  if GetDistance(rows[i].pos,rows[j].pos)<=540 then candidates[#candidates+1]=(rows[i].pos+rows[j].pos)/2 end
 end end
 -- Three boundary points determine a circle. At most ten additional centres
 -- cover five champions without repeated prediction or an unbounded AOE solver.
 for i=1,#rows do for j=i+1,#rows do for k=j+1,#rows do
  local a,b,c=rows[i].pos,rows[j].pos,rows[k].pos
  local bx,bz,cx,cz=b.x-a.x,b.z-a.z,c.x-a.x,c.z-a.z
  local d=2*(bx*cz-bz*cx)
  if math.abs(d)>.001 then local bl,cl=bx*bx+bz*bz,cx*cx+cz*cz
   local centre=Vector(a.x+(bl*cz-cl*bz)/d,a.y,a.z+(bx*cl-cx*bl)/d)
   if GetDistance(centre,a)<=270 then candidates[#candidates+1]=centre end
  end
 end end end
 local best,count
 for _,aim in ipairs(candidates)do
  local pos=GetDistance(aim,myHero.pos)>1000 and myHero.pos:Extended(aim,1000)or aim
  local hits,primary=self:Hits(pos,rows,anchor)
  if primary and hits>=minimum and self:SafeLanding(pos,true)
   and(not best or hits>count or hits==count and GetDistance(pos,myHero.pos)<GetDistance(best,myHero.pos))then best,count=pos,hits end
 end
 if best then return {position=point(best),count=count,target=anchor,id=identity(anchor),need=need}end
end
function MalphiteChampion:GetRDmg(target)
 local rank=myHero:GetSpellData(_R).level;local base=self.profile.rBase[rank]
 if not base or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.rAP*myHero.ap)
end
-- R on a single enemy is worth the ultimate when the engage kills: R plus the Q
-- and E that are ready and paid for (E lands at the landing point, Q follows).
-- With a landing within attack reach of the target, the attacks that complete
-- during the 1.5 s knock-up count too (at most two), with W when it is ready and
-- paid: Normal Thunderclap on-hit once, Classic bonus AD on each attack.
-- Evaluated through the shared kill rule at arrival (plus the knock-up when
-- attacks are counted).
function MalphiteChampion:KnockupAttacks(target,landing)
 if not landing or GetDistance(landing,target.pos)>(myHero.range or 125)+(myHero.boundingRadius or 65)+(target.boundingRadius or 65)then return 0 end
 local windup=_G.SDK.Attack:GetWindup();local period=_G.SDK.Attack:GetAnimation()
 if not finite(windup)or not finite(period)or period<=0 or windup>=self.profile.rKnockup then return 0 end
 return math.min(2,math.floor((self.profile.rKnockup-windup)/period)+1)
end
function MalphiteChampion:RKills(target,landing)
 if not self:Reach(target,1270)then return false end
 local p=self.profile;local mana=myHero.mana-myHero:GetSpellData(_R).mana
 local attacks=self:KnockupAttacks(target,landing)
 local horizon=GetDistance(target.pos,myHero.pos)/self:RSpeed()+(attacks>0 and p.rKnockup or 0)
 return(Core:Lethal(target,horizon,function()
  local damage=self:GetRDmg(target)
  for _,slot in ipairs({_Q,_E})do local s=myHero:GetSpellData(slot)
   if s.level>=1 and s.currentCd==0 and finite(s.mana)and s.mana<=mana then mana=mana-s.mana;damage=damage+(slot==_Q and self:GetQDmg(target)or self:GetEDmg(target))end
  end
  if attacks>0 then
   local ok,aa=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,target,true)
   if ok and finite(aa)and aa>0 then damage=damage+attacks*aa end
   local w=myHero:GetSpellData(_W);local rank=w.level
   if self:Ready(_W)and finite(w.mana)and w.mana<=mana then
    if p.wOnHit and p.wOnHit[rank]then
     damage=damage+_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,p.wOnHit[rank]+p.wOnHitAP*math.max(0,myHero.ap)+p.wOnHitArmor*math.max(0,myHero.armor or 0))
    elseif p.wAD and p.wAD[rank]and finite(myHero.totalDamage)then
     damage=damage+attacks*_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,p.wAD[rank]*myHero.totalDamage)
    end
   end
  end
  return damage
 end,attacks>0 and {}or {kind='magical'}))
end
function MalphiteChampion:RValid(plan,pos)
 if self.landing~=plan or plan.expires<=Game.Timer()or not self:Ready(_R)or not self:SafeLanding(pos,plan.offense)then return false end
 if not plan.offense then return true end
 if identity(plan.target)~=plan.id or not IsValid(plan.target)then return false end
 if plan.kill and not self:RKills(plan.target,pos)then return false end
 if plan.permission and not plan.permission()then return false end
 if plan.consent and not self:Allowed(plan.target)then return false end
 local hits,primary=self:Hits(pos,self:PredictedEnemies(plan.target),plan.target)
 return primary and hits>=(plan.need or Menu.Combo.RCount:Value())
end
function MalphiteChampion:StartR(plan,context,offense)
 if self.landing then return false end
 plan.context=context;plan.offense=offense;plan.expires=Game.Timer()+3;self.landing=plan
 local function resolve()
  if offense then
   if identity(plan.target)~=plan.id then return nil,'recipient_replaced'end
   local nextPlan=self:PlanR(plan.target,plan.need);if not nextPlan then return nil,'geometry_changed'end
   plan.position=nextPlan.position;plan.count=nextPlan.count
  end
  if not self:RValid(plan,plan.position)then return nil,'landing_invalid'end
  return {position=plan.position}
 end
 local ok=Core:Cast(HK_R,plan.position,{owner='REngage',intentTarget=plan.target,context=context,independent=false,
  range=1000,prevalidateWorldCast=true,resolve=resolve,
  validate=function(q,r)return self:RValid(plan,r and r.position or q.target)end})
 if not ok then self.landing=nil;return false end
  plan.intent=Core.lastIntent;plan.action=plan.intent.id
 Core:AfterCast(HK_R,function()if self.landing==plan then plan.observed=true end end)
 self.preview={position=point(plan.position),count=plan.count,shield=self:SelfBuff(self.profile.shield)~=nil,expires=Game.Timer()+.35}
 return true
end
-- need: fixed hit count (the selected-target bind passes 1). kill=true: a single
-- hit is enough while the engage kills the target (revalidated until the send).
function MalphiteChampion:Engage(context,need,kill)
 if self.landing or not self:Ready(_R)then return false end
 local anchor=GetTarget(1270);if not IsValid(anchor)then return false end
 -- The selected-target bind (need 1) is the player's own choice; Combo engages respect the per-enemy switches.
 local consent=need~=1
 if consent and not self:Allowed(anchor)then return false end
 local plan=self:PlanR(anchor,need)
 if not plan and kill then local single=self:PlanR(anchor,1)
  if single and self:RKills(anchor,single.position)then plan=single;plan.kill=true end
 end
 if plan then plan.consent=consent end
 return plan and self:StartR(plan,context,true)or false
end
-- Combo Flash-R: a group of RCount enemies whose landing lies beyond R range but within Flash + R. Flash first, then R
-- from the Flash landing once the Flash is observed (shared Core:FlashFollow). Off by default.
function MalphiteChampion:FlashR()
 local combo=self.flashCombo
 if not combo or combo:Busy()or self.landing or not Menu.Misc.FlashR:Value()or not Menu.Combo.R:Value()or not self:Ready(_R)then return false end
 local status=Core:FlashStatus();if not status then return false end
 local rCost=myHero:GetSpellData(_R).mana;if not finite(rCost)or myHero.mana<status.cost+rCost then return false end
 local anchor=GetTarget(self.RRange+status.range+self.profile.rRadius)
 if not IsValid(anchor)or not self:Allowed(anchor)then return false end
 local need=Menu.Combo.RCount:Value()
 local function group(origin)
  local rows=self:PredictedEnemies(anchor);local main
  for _,row in ipairs(rows)do if row.id==identity(anchor)then main=row end end
  if not main then return nil end
  local d=GetDistance(main.pos,origin)
  if d>self.RRange-50 then return nil end
  local hits=self:Hits(main.pos,rows,anchor);return hits>=need and main.pos or nil
 end
 local spot=group(myHero.pos:Extended(anchor.pos,status.range))
 if not spot then return false end
 local d=GetDistance(spot,myHero.pos);if d<=self.RRange then return false end
 local aim=myHero.pos:Extended(spot,math.min(status.range,d-self.RRange+150))
 local identityAnchor,handle=identity(anchor),anchor.handle
 local function authorized()return Menu.Misc.FlashR:Value()and Menu.Combo.R:Value()and GetMode()=='Combo'end
 local function valid(pos)return self:Ready(_R)and IsValid(anchor)and identity(anchor)==identityAnchor and anchor.handle==handle
  and point(pos)and type(Game.isWall)=='function'and Game.isWall(pos)==false and not IsUnderTurret2(pos)
  and GetEnemyCount(600,pos)<=Menu.Misc.REnemies:Value()and group(pos)~=nil end
 return combo:Start{order='flash_first',aim=aim,authorized=authorized,valid=valid,mana=rCost,
  follow=function(context)local plan=self:PlanR(anchor);if not plan then return false end;plan.consent=true;return self:StartR(plan,context,true)end}
end
function MalphiteChampion:ClearLanding(reason)
 local p=self.landing;if p and p.action then Core.adapter:Cancel(p.action,reason)end;self.landing=nil;self.preview=nil
end
function MalphiteChampion:ContinueLanding()
 local p=self.landing;if not p then return false end
  local continuation=Core:ContinuationState(p.intent,p.expires)
  if not continuation then self:ClearLanding('engage_ended');return false end
 if p.target and(not IsValid(p.target)or identity(p.target)~=p.id)then self:ClearLanding('recipient_ended');return false end
 -- Cast observation does not prove displacement. Normal mode decisions resume
 -- once the dash and the cast are over: at the planned point, after a dash that
 -- was seen and ended anywhere, or 0.3 s after the cast when no dash was seen.
 -- Requiring an arrival within 100 units of the planned point held Q, W and E
 -- for the full 3 s whenever the charge stopped anywhere else.
 if continuation=='observed'then local dashing=myHero.pathing and myHero.pathing.isDashing==true
  p.observedAt=p.observedAt or Game.Timer();if dashing then p.dashSeen=true end
  if not dashing and not IsCasting()and(p.dashSeen or GetDistance(myHero.pos,p.position)<=100 or Game.Timer()-p.observedAt>.3)then
   self.landing=nil;self:TraceLanding(p)
  end
 end
 return true
end
-- Dev recorder: which enemies around the landing were knocked up, and how far from it (settles the 270 vs 325 radius).
function MalphiteChampion:TraceLanding(p)
 if not Core.logger then return end
 local rows={};local list=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#list,5)do local u=list[i]
  if IsValid(u)and GetDistance(u.pos,myHero.pos)<=500 then local up=false
   for _,b in ipairs(Core:Fresh(GetBuffs,u))do if b.type==29 or b.type==30 then up=true;break end end
   rows[#rows+1]={distance=math.floor(GetDistance(u.pos,myHero.pos)),knockedUp=up}
  end
 end
 Core:Trace('malphite_r_landing',{planned=p.count,offset=math.floor(GetDistance(myHero.pos,p.position)),enemies=rows})
end
function MalphiteChampion:AssistR()
 if not Menu.Misc.RAssist:Value()then self.assistUsed=false;return false end
 if self.assistUsed then return false end
 if self:Engage(Core:HeldContext(function()return Menu.Misc.RAssist:Value()end),1)then self.assistUsed=true;return true end
 return false
end
function MalphiteChampion:Flee()
 if Menu.Misc.FleeR:Value()and not self.fleeUsed and self:Ready(_R)then local pos=point(mousePos)
  if pos and GetDistance(pos,myHero.pos)>1000 then pos=myHero.pos:Extended(pos,1000)end
  if pos and self:SafeLanding(pos,false)and self:StartR({position=pos},Core:ModeContext('Flee',function()return Menu.Misc.FleeR:Value()end),false)then self.fleeUsed=true;return true end
 end
 if Menu.Misc.FleeQ:Value()and self:Ready(_Q)then local target=self:FleeTarget();if IsValid(target)then return self:CastQ(target)end end
end
-- The champion that reaches Malphite first among those closing in; with none chasing, the nearest enemy unit in Q range
-- (the slow is stolen as movement speed from any unit).
function MalphiteChampion:FleeTarget()
 local best,soonest
 local heroes=Core:Rows('hero',625)
 for i=1,#heroes do local u=heroes[i];local path=u.pathing;local d=GetDistance(u.pos,myHero.pos)
  local closing=path and path.endPos and(path.isDashing or path.hasMovePath)and GetDistance(path.endPos,myHero.pos)<d-1
  local speed=path and path.isDashing and path.dashSpeed or u.ms
  if closing and finite(speed)and speed>0 and(not soonest or d/speed<soonest)then best,soonest=u,d/speed end
 end
 if best then return best end
 local nearest,distance
 for _,kind in ipairs({'lane','jungle','hero'})do local rows=Core:Rows(kind,625)
  for i=1,#rows do local d=GetDistance(rows[i].pos,myHero.pos);if not distance or d<distance then nearest,distance=rows[i],d end end
  if nearest then return nearest end
 end
end
function MalphiteChampion:Tick()
 if ShouldWait()then self:ClearLanding('unavailable');return end
 local mode=GetMode();if mode~='Flee'then self.fleeUsed=false end
 if not Menu.Misc.RAssist:Value()then self.assistUsed=false end
 self.allow:Maintain()
 if self.flashCombo and self.flashCombo:Busy()and self.flashCombo:Maintain()then return end
 if self:ContinueLanding()or IsCasting()then return end
 self:PrepareDraw()
  if self:AssistR()then return end
  if self:InterruptR()then return end
  if self:Finishers()then return end
 if mode=='Combo'then if not self:FlashR()then self:Combo()end elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')and self:LaneClear()then return end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
-- Prepared for Draw: ready slots and, at most every .25 s, the enemies (at most five) an R engage kills.
function MalphiteChampion:PrepareDraw()
 if Menu.Draw.Ranges:Value()then self.ready={[400]=self:Ready(_E),[625]=self:Ready(_Q),[1000]=self:Ready(_R)}else self.ready=nil end
 if not Menu.Draw.Kills:Value()then self.marks={};return end
 if Game.Timer()<(self.nextMarks or 0)then return end
 self.nextMarks=Game.Timer()+.25;local marks={}
 if self:Ready(_R)then local list=Core:DecisionUnits('GetEnemyHeroes')
  for i=1,math.min(#list,5)do local u=list[i];if IsValid(u)and self:RKills(u)then marks[#marks+1]=u end end
 end
 self.marks=marks
end
function MalphiteChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.Ranges:Value()and self.ready then for _,range in ipairs({400,625,1000})do if self.ready[range]then Draw.Circle(myHero.pos,range,1,Draw.Color(255,150,200,255))end end end
 if Menu.Draw.Kills:Value()and IsReady(_R)then for _,u in ipairs(self.marks or {})do
  if IsValid(u)and u.pos2D and u.pos2D.onScreen~=false then Draw.Text('R engage kills',16,u.pos2D.x-40,u.pos2D.y-60,Draw.Color(255,255,90,60))end
 end end
 -- The committed R landing; no Granite Shield text (the game shows the shield bar).
 local landing=self.landing
 if Menu.Draw.Preview:Value()and landing and landing.position then Draw.Circle(landing.position,self.profile.rRadius,1,Draw.Color(255,255,200,100))end
end
function MalphiteChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Malphite: modes','Malphite: engage assistance'},function(page)
  return {title=page==1 and 'Malphite'or 'R engage',cards=page==1 and {
   {'MODES','Provider binds select Combo, Harass, lane/jungle, LastHit and Flee. Mana settings apply to every enabled spell.'},
   {'WEAVING','W is cast right after an attack lands. Classic gains AD and armor; Normal uses its separate reset and splash kit.'},
   {'FARM','Q rescues minions an attack cannot take. E clear counts minions around you; LastHit E is used on a lone minion only.'},
   {'FINISH','A killable enemy in reach is finished with Q or E without a mode key; R can finish too when enabled (off by default). R also stops a dangerous channel.'}}or {
   {'ENGAGE','Combo engages with R when it hits the configured number of enemies, or a single enemy the engage kills (R with the Q and E that are ready, and the attacks during the knock-up). Per-enemy switches choose who R may engage; the R bind needs only the selected target. Optional Flash then R reaches a group just out of range. Evade may dodge a lethal hit with R. Flee R toward the cursor is off by default.'},
   {'LANDING','R never lands in a wall, under an enemy turret or among more enemies than configured, and respects the health limit and the Q reserve.'},
   {'SHIELD','Optionally engage only while Granite Shield is up. Releasing the key cancels a waiting R.'}}}
 end)
end
Core:RegisterPolicy({damageTypes={Q='magical',E='magical'},methods={
 Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,
 JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
 LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end},
 exceptions={non_interrupting_summoner=true},channel=function()return not Core:SelfChanneling()end,
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot)end;return true end})
MalphiteChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Malphite"]="Malphite"}
local normalSupported={["Malphite"]=true}

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
