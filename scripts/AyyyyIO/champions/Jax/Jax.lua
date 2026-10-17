return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Jax"]=function()return _G.OrbamaFamily:Require("7ac4ec8958064dee1c06bdcd438aa3363edd386b1af5ae1722fb4e1f6cbd2d31")()end
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
if champion=="Jax" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Jax',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent implementation. Both kits share decisions, not unverified mechanics.
local profiles=ChampionProfiles('Jax')
local finite,identity,position=Core.finite,Core.id,Core.point
local function alias(name,names)for _,v in ipairs(names)do if name==v then return true end end;return false end
local cleanup
local JaxChampion=class("JaxChampion")
function JaxChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self:LoadMenu()
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('jax_sequence',function(reason)cleanup(self,reason)end)
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
 self:OfferDefense()
end
-- Counter Strike to Evade: basic attacks inside the dodge window miss (profile duration and cast delay).
-- A first cast only; the recast is this controller's decision (an E Evade starts is adopted below).
function JaxChampion:OfferDefense()
 local p=self.profile
 if not Core.RegisterEffect or not finite(p.eDuration)or not finite(p.eDelay)or type(p.eSource)~='string'then return end
 self.defenseOffered,self.defenseReason,self.defenseAdapter=Core:RegisterEffect({kind='attack_dodge',name=p.e[1],slot=_E,key=HK_E,profile=p.id,source=p.eSource,
  delay=p.eDelay,duration=p.eDuration,ready=function()local b,why=self:Buff(p.eBuff);return not self.ePlan and not b and not why and self:Ready(_E)end})
end
function JaxChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Jax'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q to jump onto the target',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='W',name='Use W after an attack',value=true})
  Menu[mode]:MenuElement({id='E1',name='Use E before jumping in and near the target',value=true})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
 if self.profile.rKind=='active_swing'then
  Menu.Combo:MenuElement({id='R',name='Use R',value=true})
  Menu.Combo:MenuElement({id='RCount',name='R with this many enemies nearby',value=2,min=1,max=5,step=1})
  Menu.Combo:MenuElement({id='RHP',name='Or with one enemy below my health %',value=40,min=0,max=100,step=5})
 end
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[mode]:MenuElement({id='Q',name='Use Q to jump to the target',value=true})
  Menu.Clear[mode]:MenuElement({id='W',name='Use W after an attack',value=true})
  Menu.Clear[mode]:MenuElement({id='E1',name='Use E',value=true})
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='ECount',name='Lane minions E must hit',value=3,min=1,max=8,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='W',name='Use W on minions an attack would miss',value=true})
 Menu.LastHit:MenuElement({id='Q',name='Jump with Q to minions an attack would miss',value=false})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=10,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='FleeQ',name='Flee: Q to a unit or ward toward the cursor',value=true})
 Menu.Misc:MenuElement({id='Ward',name='Flee: place a ward to jump to if needed',value=true})
 Menu.Misc:MenuElement({id='FleeE',name='Flee: E against a nearby enemy',value=true})
 Menu.Misc:MenuElement({id='KillQ',name='Finish a killable enemy without a mode key',value=true})
 Menu.Misc:MenuElement({id='AutoE',name='Auto E against attacks, dashes and channels',value=true})
 Menu.Misc:MenuElement({id='AutoEMana',name='That E only above mana %',value=25,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='QHP',name='Never dash in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='QEnemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Q',name='Q range while Q is ready',value=false})
 Menu.Draw:MenuElement({id='ERange',name='E range while E is ready',value=false})
 if self.profile.rKind=='active_swing'then Menu.Draw:MenuElement({id='R',name='R area while R is ready',value=false})end
 Menu.Draw:MenuElement({id='Plan',name='Jump spot, last-hit target and finishable enemy',value=true})
 Menu.Draw:MenuElement({id='E',name='Counter Strike area while it is up',value=true})
end
function JaxChampion:Mana(node)return Core.manaAbove(node:Value())end
function JaxChampion:Buff(names)
 if names==self.profile.wBuff and self.profile.wBuffAliases then names=self.profile.wBuffAliases end
 if type(names)=='string'then names={names}end
 if not finite(myHero.buffCount)or myHero.buffCount<0 or myHero.buffCount%1~=0 or myHero.buffCount>128 then return nil,'buff_snapshot_unknown'end
 local found
 for i=0,myHero.buffCount do local b=myHero:GetBuff(i)
  if b and alias(b.name,names)and finite(b.count)and b.count>0 then
   local expiry=Core.buffExpiry(b)
   local function ours(id)return not id or id==0 or id==myHero.networkID or id==myHero.handle end
   local src=b.source;local owned=ours(b.sourcenID)
   if type(src)=='table'or type(src)=='userdata'then owned=owned and ours(src.networkID)and ours(src.handle)else owned=owned and ours(src)end
   if not finite(expiry)or not owned or b.sourceName and b.sourceName~=''and b.sourceName~=myHero.charName then return nil,'buff_evidence_unknown'end
   if expiry>Game.Timer()then if found then return nil,'duplicate_buff'end;found=b end
  end
 end
 return found
end
function JaxChampion:Ready(slot,recast)
 local d=myHero:GetSpellData(slot)
 if recast then if not d or d.currentCd~=0 or d.level<=0 or Game.CanUseSpell(slot)~=0 then return false end
 elseif not IsReady(slot)then return false end
 local names=slot==_Q and self.profile.q or slot==_E and self.profile.e
 if names and not alias(d.name,names)or slot==_W and d.name~=self.profile.w or slot==_R and(d.name~=self.profile.r or self.profile.rKind~='active_swing')then return false end
 if not recast and(not finite(d.mana)or d.mana<0 or d.mana>myHero.mana)then return false end
 if slot==_W then local b,reason=self:Buff(self.profile.wBuff);return not b and not reason end
 return true
end
function JaxChampion:Reach(target,range)return IsValid(target)and GetDistance(target.pos,myHero.pos)<=range end
function JaxChampion:SafeLanding(pos,offense)
 if not position(pos)or type(Game.isWall)~='function'or Game.isWall(pos)~=false or IsUnderTurret2(pos)then return false end
 if GetEnemyCount(600,pos)>Menu.Misc.QEnemies:Value()then return false end
 return not offense or myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.QHP:Value()
end
function JaxChampion:CastQ(target,context,offense,validate)
 if not self:Ready(_Q)or not self:Reach(target,700)or not self:SafeLanding(target.pos,offense)then return false end
 return Core:Cast(HK_Q,target,{range=700,intentTarget=target,context=context,independent=false,deferAttackWindup=true,
  validate=function()return self:Ready(_Q)and self:Reach(target,700)and self:SafeLanding(target.pos,offense)and(not validate or validate())end})
end
-- Leap Strike damage from the profile's sourced figures. Classic's damage type is not established, so
-- the lower of both mitigations is the claim there.
function JaxChampion:QDamage(target)
 local p=self.profile;local base=p.qBase and p.qBase[myHero:GetSpellData(_Q).level]
 if not base or not finite(myHero.bonusDamage)or myHero.bonusDamage<0 or not finite(myHero.ap)or myHero.ap<0 then return 0 end
 local raw=base+p.qBonusAD*myHero.bonusDamage+p.qAP*myHero.ap
 local physical=_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
 if p.qKind=='physical'then return physical end
 return math.min(physical,_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,raw))
end
-- Empower's bonus magic damage (it also charges Leap Strike). Classic's AD part is read as bonus AD, the
-- lower of both readings.
function JaxChampion:WDamage(target)
 local p=self.profile;local base=p.wBase[myHero:GetSpellData(_W).level]
 if not base or not finite(myHero.ap)or myHero.ap<0 or not finite(myHero.bonusDamage)or myHero.bonusDamage<0 then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+p.wAP*myHero.ap+(p.wBonusAD or 0)*myHero.bonusDamage)
end
-- Counter Strike recast damage with the dodges actually observed in this window (never assumed).
function JaxChampion:EDamage(target,dodged)
 local p=self.profile;local base=p.eBase and p.eBase[myHero:GetSpellData(_E).level]
 if not base or not finite(myHero.ap)or myHero.ap<0 or not finite(myHero.bonusDamage)or myHero.bonusDamage<0
  or not finite(target.maxHealth)or target.maxHealth<=0 then return 0 end
 local raw=(base+p.eAP*myHero.ap+p.eBonusAD*myHero.bonusDamage+p.eHP*target.maxHealth)*(1+p.eDodgeBonus*math.min(p.eMaxDodges,dodged or 0))
 return _G.SDK.Damage:CalculateDamage(myHero,target,p.eKind=='physical'and _G.SDK.DAMAGE_TYPE_PHYSICAL or _G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
-- The leap's flight time is unpublished: the kill must hold from current health, not from a forecast.
-- An Empower already on Jax (or one about to be cast, `withW`) adds its magic damage to the leap.
function JaxChampion:QKills(target,withW)
 local empowered=withW or self:Buff(self.profile.wBuff)~=nil
 return(Core:Lethal(target,.35,function()return self:QDamage(target)+(empowered and self:WDamage(target)or 0)end,
  {kind=not empowered and self.profile.qKind or nil,now=true}))
end
function JaxChampion:FinisherContext()return {priority='interactive',condition=function()return Menu.Misc.KillQ:Value()end}end
-- The Normal swing finishes someone in it even without Combo.
function JaxChampion:RFinisher()
 if self.profile.rKind~='active_swing'or not self:Ready(_R)or not self:RKills()then return false end
 return Core:Cast(HK_R,nil,{context=self:FinisherContext(),validate=function()return Menu.Misc.KillQ:Value()and self:Ready(_R)and self:RKills()end})
end
function JaxChampion:Finisher()
 self.killPreview=nil
 if not Menu.Misc.KillQ:Value()then return false end
 if self:RFinisher()then return true end
 if not self:Ready(_Q)then return false end
 local rows=Core:Rows('hero',700);local wReady=Game.Timer()-(self.killW or -10)>1.5 and self:Ready(_W)
 for i=1,#rows do local u=rows[i]
  if self:SafeLanding(u.pos,true)then
   if self:QKills(u)then
    self.killPreview={unit=u,at=Game.Timer()}
    return self:CastQ(u,self:FinisherContext(),true,function()return Menu.Misc.KillQ:Value()and self:QKills(u)end)
   end
   -- Empower first: the leap then carries it. The leap itself still needs the empowerment seen on Jax.
   if wReady and self:QKills(u,true)then
    self.killPreview={unit=u,at=Game.Timer()}
    local ok=Core:Cast(HK_W,nil,{intentTarget=u,context=self:FinisherContext(),validate=function()
     return Menu.Misc.KillQ:Value()and self:Ready(_W)and self:Ready(_Q)and self:Reach(u,700)and self:SafeLanding(u.pos,true)and self:QKills(u,true)end})
    if ok then self.killW=Game.Timer();return true end
   end
  end
 end
 return false
end
function JaxChampion:AttackPermission(target)
 local mode=GetMode();local node,context
 if target.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')then node=Menu[mode];context=Core:ModeContext(mode)
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then
  local jungle=target.team==300;local kind=jungle and 'jungle'or 'lane'
  if not Core:FarmModeEnabled(kind)then return nil end
  node=Menu.Clear[jungle and 'JungleClear'or 'LaneClear'];context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 end
 if node and node.W:Value()and self:Mana(node.Mana)then return context end
end
function JaxChampion:OnPostAttack(args)
 if ShouldWait()or self.farm then return end
 local witness=Core:AttackWitness(self.attack,args and args.Target)
 if not witness or witness==self.attack or witness.at>Game.Timer()then return end
 self.attack=witness;local target=witness.object;local context=self:AttackPermission(target)
 if not context or not self:Ready(_W)or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return end
 return Core:Cast(HK_W,nil,{intentTarget=target,context=context,validate=function()
  return self.attack==witness and Game.Timer()-witness.at<=.35 and self:Ready(_W)
   and self:AttackPermission(target)~=nil and _G.SDK.Data:IsInAutoAttackRange(myHero,target)
 end})
end
function JaxChampion:EStage(plan)
 local b,reason=self:Buff(self.profile.eBuff)
 if reason or not b or not plan or not plan.observed then return false end
 local expiry=Core.buffExpiry(b)
 -- Readiness and native stage admission are authoritative. Do not manufacture
 -- a Classic minimum recast time from the modern kit or an elapsed timer.
 return expiry>Game.Timer()and finite(b.startTime)and b.startTime>=plan.started-.05
  and self:Ready(_E,true)and myHero:GetSpellData(_E).toggleState==2
end
function JaxChampion:BeginE(target,context,permission,recastPermission,targetRange)
 targetRange=targetRange or 375
 if not finite(targetRange)or targetRange<375 or targetRange>1500 then return false end
 local active,why=self:Buff(self.profile.eBuff)
 if self.ePlan or active or why or not self:Ready(_E)or not self:Reach(target,targetRange)or not permission()then return false end
 local plan={target=target,id=identity(target),handle=target.handle,context=context,permission=recastPermission or permission,started=Game.Timer(),expires=Game.Timer()+2.5}
 self.ePlan=plan
 local ok=Core:Cast(HK_E,nil,{owner='CounterStrike',context=context,intentTarget=target,
  observe=function(q)
   local native=myHero.activeSpell;local a=native and alias(native.name,self.profile.e)and Core:NativeCast(q,native.name)
   local b=self:Buff(self.profile.eBuff)
   return b and finite(b.startTime)and finite(q.observationGameTime)and b.startTime>=q.observationGameTime-.05
    and(a
     or myHero:GetSpellData(_E).toggleState~=q.toggleState)
  end,validate=function()local b,reason=self:Buff(self.profile.eBuff)
    return self.ePlan==plan and target.handle==plan.handle and not b and not reason and self:Ready(_E)and self:Reach(target,targetRange)and permission()
  end})
 if not ok then self.ePlan=nil;return false end
 plan.intent=Core.lastIntent;plan.action=plan.intent.id;Core:AfterCast(HK_E,function()if self.ePlan==plan then plan.observed=true end end)
 return true
end
-- A plan that ends while its Counter Strike is still up must not be adopted as a manual one.
function JaxChampion:HandledE()local b=self:Buff(self.profile.eBuff);if b and finite(b.startTime)then self.eHandled=b.startTime end end
function JaxChampion:ClearE(reason)
 local p=self.ePlan;if p then if p.action then Core.adapter:Cancel(p.action,reason)end;if p.follow then Core.adapter:Cancel(p.follow,reason)end end
 if p then self:HandledE()end
 self.ePlan=nil
end
-- A Counter Strike the player (or Evade) started is adopted: its recast is timed like an own plan.
function JaxChampion:AdoptE()
 if self.ePlan or not Menu.Misc.AutoE:Value()then return false end
 local b,why=self:Buff(self.profile.eBuff)
 if not b or why or not finite(b.startTime)or b.startTime<=(self.eHandled or -1)+.01 or myHero:GetSpellData(_E).toggleState~=2 then return false end
 self.eHandled=b.startTime
 self.ePlan={adopted=true,observed=true,started=b.startTime,expires=Core.buffExpiry(b)+.3,
  context={priority='critical',condition=function()return Menu.Misc.AutoE:Value()end},permission=function()return Menu.Misc.AutoE:Value()end}
 return true
end
-- Dodged attacks raise the recast damage. Only champion attacks seen aimed at Jax whose impact fell inside the
-- current window count (distinct caster and start); anything not observed counts as not dodged.
function JaxChampion:TrackDodges()
 local b=self:Buff(self.profile.eBuff)
 if not b or not finite(b.startTime)then self.dodges=nil;return end
 local d=self.dodges;if not d or d.start~=b.startTime then d={start=b.startTime,seen={},n=0};self.dodges=d end
 local now=Game.Timer();local rows=Core:Rows('hero',1500)
 for i=1,#rows do local u=rows[i]
  local cast=Core:CastWindup(u,-1,1.25,true,myHero.networkID,myHero.handle)
  local speed=u.attackData and u.attackData.projectileSpeed
  if cast and(speed==math.huge or finite(speed)and speed>0)then
   local key=tostring(cast.casterID or cast.casterHandle)..':'..tostring(cast.start)
   if not d.seen[key]then d.seen[key]=cast.castEndTime+(speed==math.huge and 0 or GetDistance(u.pos,myHero.pos)/speed)end
  end
 end
 local n=0;for _,at in pairs(d.seen)do if at>=d.start and at<=now then n=n+1 end end
 d.n=n
end
function JaxChampion:Dodged()return self.dodges and self.dodges.n or 0 end
function JaxChampion:EKills(u)
 return(Core:Lethal(u,.1,function()return self:EDamage(u,self:Dodged())end,{kind=self.profile.eKind}))
end
-- Where a champion will be in `h` seconds from its current path (dash end point, or walking at its speed).
local function ahead(u,h)
 local path=u.pathing;local to=path and path.endPos
 if not path or not position(to)then return u.pos end
 if path.isDashing then return to end
 if not path.hasMovePath or not finite(u.ms)or u.ms<=0 then return u.pos end
 local d=GetDistance(u.pos,to);if d<=u.ms*h then return to end
 return u.pos:Extended(to,u.ms*h)
end
-- Why to recast now, or nil to keep collecting dodges. Champions: a kill, an interruptible channel, someone
-- inside about to leave the area (0.2 s ahead) while nobody is about to enter, or the window ending.
-- Units (farming): the plan's unit leaving, a channel or the window ending.
function JaxChampion:RecastReason(p,expiry)
 local now=Game.Timer();local rows=Core:Rows('hero',1200);local inside,leaving,entering={},false,false
 for i=1,#rows do local u=rows[i]
  local d=GetDistance(u.pos,myHero.pos);local later=GetDistance(ahead(u,.2),myHero.pos)
  if d<=375 then inside[#inside+1]=u;if later>375 then leaving=true end elseif later<=375 then entering=true end
 end
 for i=1,#inside do local u=inside[i]
  if self:EKills(u)then self.killPreview={unit=u,at=now};return 'kill'end
  if Core:CanInterrupt(u,0,.05)then return 'interrupt'end
 end
 local hero=p.adopted or p.target.type==Obj_AI_Hero
 if hero then
  if #inside==0 then return nil end
  if leaving and not entering then return 'leaving'end
 else
  if not self:Reach(p.target,375)then return nil end
  if GetDistance(p.target.pos,myHero.pos)>300 then return 'leaving'end
  if Core:CanInterrupt(p.target,0,.05)then return 'interrupt'end
 end
 if expiry-now<=.25 then return 'expiry'end
end
function JaxChampion:ContinueE()
 if self:Buff(self.profile.eBuff)then self:TrackDodges()else self.dodges=nil end
 self:AdoptE()
 local p=self.ePlan;if not p then return false end
 if p.adopted then
  if p.expires<=Game.Timer()or not self:Buff(self.profile.eBuff)then self.ePlan=nil;return false end
 else
  local continuation=Core:ContinuationState(p.intent,p.expires)
  if not continuation or identity(p.target)~=p.id or p.target.handle~=p.handle then self:ClearE('e_context_ended');return false end
  p.observed=continuation=='observed'
 end
 if p.observed and not p.permission()then self:ClearE('recast_disabled');return false end
 if p.follow then if not Core.adapter:HasAction(p.follow)then self:HandledE();self.ePlan=nil end;return false end
 -- Interrupt plan: Q carries Jax into the stun once Counter Strike is seen.
 if p.leap and p.observed and not p.leapSent and not self:Reach(p.target,375)then
  if self:CastQ(p.target,p.context,true,function()return p.permission()and Core:CanInterrupt(p.target,1.1,.05)end)then p.leapSent=true;return true end
 end
 if not self:EStage(p)then return false end
 local b=self:Buff(self.profile.eBuff);local reason=self:RecastReason(p,Core.buffExpiry(b))
 if not reason then return false end
 local function still()
  if reason=='kill'or reason=='interrupt'or reason=='expiry'then return true end
  return p.adopted or p.target.type==Obj_AI_Hero or self:Reach(p.target,375)
 end
 local ok=Core:Cast(HK_E,nil,{owner='CounterStrike',context=p.context,intentTarget=p.target,
  observe=function(q)local b=self:Buff(self.profile.eBuff);local d=myHero:GetSpellData(_E)
   return not b and(d.toggleState~=q.toggleState or d.currentCd>(q.cooldown or 0))end,
  validate=function()return self.ePlan==p and p.permission()and self:EStage(p)and still()end})
 if ok then p.follow=Core.lastIntent.id;p.reason=reason end
 return ok
end
-- An enemy dashing onto Jax is about to attack him and ends inside the stun radius: E starts while he arrives.
function JaxChampion:GapE()
 local rows=Core:Rows('hero',1200)
 for i=1,#rows do local u=rows[i]
  if Core:ApproachingDash(u,myHero.pos,300)then
   local function permission()
    return Menu.Misc.AutoE:Value()and self:Mana(Menu.Misc.AutoEMana)and(Core:ApproachingDash(u,myHero.pos,300)~=nil or self:Reach(u,375))
   end
   return self:BeginE(u,{priority='critical',condition=function()return Menu.Misc.AutoE:Value()end},permission,function()return Menu.Misc.AutoE:Value()end,1200)
  end
 end
 return false
end
function JaxChampion:DefensiveE()
 if not Menu.Misc.AutoE:Value()or self.ePlan or not self:Ready(_E)or not self:Mana(Menu.Misc.AutoEMana)then return false end
 local witness=Core:IncomingAttack(myHero,.2,1.5)
 if not witness or not self:Reach(witness.caster,1500)then return self:GapE()end
 local function permission()
  if not Menu.Misc.AutoE:Value()or not self:Mana(Menu.Misc.AutoEMana)then return false end
  local fresh=Core:IncomingAttack(myHero,.2,1.5)
  return fresh and fresh.casterID==witness.casterID and fresh.casterHandle==witness.casterHandle
   and fresh.name==witness.name and fresh.start==witness.start and fresh.targetID==witness.targetID
 end
 local context={priority='critical',condition=function()return Menu.Misc.AutoE:Value()end}
 return self:BeginE(witness.caster,context,permission,function()return Menu.Misc.AutoE:Value()end,1500)
end
-- Start Counter Strike to stun a channel that outlasts the minimum recast (1 s) plus the leap: the caster
-- within the area, or within Q range with a safe landing. The leap's flight time is unpublished; .5 s is a
-- conservative bound that only makes the start rarer.
function JaxChampion:InterruptE()
 if not Menu.Misc.AutoE:Value()or self.ePlan or not self:Ready(_E)or not self:Mana(Menu.Misc.AutoEMana)then return false end
 local rows=Core:Rows('hero',700)
 for i=1,#rows do local u=rows[i]
  local near=self:Reach(u,375);local travel=near and 0 or .5
  if Core:CanInterrupt(u,1.1+travel,.05)and(near or self:Ready(_Q)and self:SafeLanding(u.pos,true))then
   local function permission()return Menu.Misc.AutoE:Value()and Core:CanInterrupt(u,1.1,.05)end
   if self:BeginE(u,{priority='critical',condition=function()return Menu.Misc.AutoE:Value()end},permission,function()return Menu.Misc.AutoE:Value()end,700)then
    self.ePlan.leap=not near;return true
   end
  end
 end
 return false
end
function JaxChampion:RUseful()
 if self.profile.rKind~='active_swing'or not Menu.Combo.R:Value()or not self:Ready(_R)then return false end
 local n=GetEnemyCount(375,myHero.pos)
 if n>=Menu.Combo.RCount:Value()or n>0 and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100<=Menu.Combo.RHP:Value()then return true end
 return n>0 and self:RKills()
end
-- The swing itself finishes someone standing in it.
function JaxChampion:RKills()
 local p=self.profile;local base=p.rBase and p.rBase[myHero:GetSpellData(_R).level]
 if not base or not finite(myHero.ap)or myHero.ap<0 then return false end
 local rows=Core:Rows('hero',p.rRadius)
 for i=1,#rows do local u=rows[i]
  if(Core:Lethal(u,p.rCast,function()return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+p.rAP*myHero.ap)end,{kind='magical'}))then return true end
 end
 return false
end
function JaxChampion:Combat(mode)
 local node=Menu[mode];if not self:Mana(node.Mana)then return end
 if mode=='Combo'and self:RUseful()then return Core:Cast(HK_R,nil,{validate=function()return self:RUseful()end})end
 if not(node.E1:Value()and self:Ready(_E)or node.Q:Value()and self:Ready(_Q))then return end
 local context=Core:ModeContext(mode)
 local function eAllowed()return node.E1:Value()and self:Mana(node.Mana)end
 -- An enemy within leap range attacking Jax: Counter Strike first (no Behaviour mana floor in a fight).
 if node.E1:Value()and not self.ePlan and self:Ready(_E)then
  local witness=Core:IncomingAttack(myHero,.2,1.5)
  if witness and self:Reach(witness.caster,700)then
   local function same()local fresh=Core:IncomingAttack(myHero,.2,1.5)
    return fresh and fresh.casterID==witness.casterID and fresh.start==witness.start and fresh.name==witness.name end
   if self:BeginE(witness.caster,context,function()return eAllowed()and same()end,function()return self:Mana(node.Mana)end,700)then return true end
  end
 end
 local target=GetTarget(700);if not IsValid(target)then return end
 if node.E1:Value()and self:BeginE(target,context,eAllowed,function()return self:Mana(node.Mana)end)then return true end
 if node.Q:Value()and not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then
  -- Empower also charges Leap Strike: W goes first when the leap is about to be cast, never on its own.
  -- One attempt per leap: an empowerment the buff read does not show must not hold the leap back.
  if node.W:Value()and Game.Timer()-(self.wLead or -10)>1.5 and self:Ready(_W)and self:Ready(_Q)and self:Reach(target,700)and self:SafeLanding(target.pos,true)then
   local ok=Core:Cast(HK_W,nil,{intentTarget=target,context=context,validate=function()
    return node.W:Value()and node.Q:Value()and self:Mana(node.Mana)and self:Ready(_W)and self:Ready(_Q)and self:Reach(target,700)
     and self:SafeLanding(target.pos,true)and not _G.SDK.Data:IsInAutoAttackRange(myHero,target)end})
   if ok then self.wLead=Game.Timer();return true end
  end
  if Game.Timer()-(self.wLead or -10)<.15 and self:Ready(_W)then return true end
  -- Counter Strike before the leap: the stun is ready when Jax lands (recast only after the native minimum).
  if node.E1:Value()and self:Ready(_Q)and self:SafeLanding(target.pos,true)and self:BeginE(target,context,
   function()return eAllowed()and node.Q:Value()and self:Ready(_Q)and self:SafeLanding(target.pos,true)end,function()return self:Mana(node.Mana)end,700)then return true end
  -- The leap waits for that Counter Strike to be seen, at most .15 s.
  local p=self.ePlan;if p and p.target==target and not p.observed and Game.Timer()-p.started<.15 then return true end
  return self:CastQ(target,context,true,function()return node.Q:Value()and self:Mana(node.Mana)end)
 end
end
function JaxChampion:Combo()return self:Combat('Combo')end
function JaxChampion:Harass()return self:Combat('Harass')end
function JaxChampion:FarmDamage(target)
 local rank=myHero:GetSpellData(_W).level;if not self.profile.wBase[rank]or not finite(myHero.ap)or myHero.ap<0
  or not finite(myHero.totalDamage)or myHero.totalDamage<0 then return 0 end
 -- Classic's AD/stat and splash relationship stays out of lethal estimates.
 -- Both profiles include only guaranteed base W and basic AD components.
 local magic=self.profile.wBase[rank]+(self.profile.id=='normal'and self.profile.wAP*myHero.ap or 0)
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)
  +_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,magic)
end
function JaxChampion:FarmUseful(target,prepared)
 if not self:Reach(target,myHero.range+myHero.boundingRadius+(target.boundingRadius or 0))or target.team==300 or target.team==myHero.team then return false end
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)or windup<0 then return false end
 -- The shared LastHit rule: Empower resets the attack, so it rescues a minion the ready attack would not
 -- take at its own landing (or any minion while the attack is still on cooldown).
 return Core:Rescue(target,windup+(prepared and 0 or self.profile.wPrepare),function()return self:FarmDamage(target)end,
  {attack='ready',attackDamage=function(u)return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)end})
end
-- Q rescue: the flight time is unpublished, so the leap must kill from current health and the minion must be
-- one the basic attack cannot take in time.
function JaxChampion:QRescue(target)
 if target.team==300 or target.team==myHero.team then return false end
 local damage=self:QDamage(target)
 return damage>0 and(Core:Lethal(target,.35,damage,{now=true}))and Core:Rescue(target,.35,damage)
end
function JaxChampion:LastHitQ()
 if not Menu.LastHit.Q:Value()or not self:Mana(Menu.LastHit.Mana)or not self:Ready(_Q)then return false end
 local best=Core:LethalPick(Core:Rows('lane',700),function(u)return self:QRescue(u)end,function(u)return self:Reach(u,700)end,
  function(u)return self:SafeLanding(u.pos,true)end)
 if not best then return false end
 return self:CastQ(best,Core:RescueContext(),true,function()return Menu.LastHit.Q:Value()and self:Mana(Menu.LastHit.Mana)and self:QRescue(best)end)
end
function JaxChampion:LastHit()
 if self.farm then return end
 if not Menu.LastHit.W:Value()or not self:Mana(Menu.LastHit.Mana)or not self:Ready(_W)then return self:LastHitQ()end
 local list=_G.SDK.ObjectManager:GetEnemyMinions(350);local best
 for i=1,math.min(#list,40)do local u=list[i];if(not best or u.maxHealth>best.maxHealth)and self:FarmUseful(u)then best=u end end
 if not best then return self:LastHitQ()end
 local plan={target=best,id=identity(best),handle=best.handle,expires=Game.Timer()+.9,context=Core:ModeContext('LastHit')};self.farm=plan
 local ok=Core:Cast(HK_W,nil,{owner='LastHit',intentTarget=best,context=plan.context,
  validate=function()return self.farm==plan and self:Ready(_W)and self:FarmUseful(best)end})
 if not ok then self.farm=nil;return false end
 plan.intent=Core.lastIntent;plan.action=plan.intent.id;Core.adapter:SetBlocked('jax_farm','attack',true)
 Core:AfterCast(HK_W,function()if self.farm==plan then plan.observed=true end end);return true
end
function JaxChampion:ClearFarm(reason)
 local p=self.farm;if p then if p.action then Core.adapter:Cancel(p.action,reason)end;if p.attack then Core.adapter:Cancel(p.attack,reason)end end
 self.farm=nil;Core.adapter:SetBlocked('jax_farm','attack',false)
end
function JaxChampion:ContinueFarm()
 local p=self.farm;if not p then return false end
 local continuation=Core:ContinuationState(p.intent,p.expires)
 -- Attacks stay blocked until W is seen. The empowerment itself, present after
 -- the key was sent, is that evidence as much as the slot's state change; a W
 -- whose cooldown only starts with the attack otherwise held the block to expiry.
 local receipt=continuation and Core.adapter:Poll(p.action);local empowered=self:Buff(self.profile.wBuff)~=nil
 local cast=continuation=='observed'or empowered and receipt~=nil and receipt.sentAt~=nil
 if not continuation or identity(p.target)~=p.id or p.target.handle~=p.handle
   or not Menu.LastHit.W:Value()or not self:FarmUseful(p.target,cast and empowered)then self:ClearFarm('farm_ended');return false end
 p.observed=cast
 if not p.observed or not empowered then return true end
 Core.adapter:SetBlocked('jax_farm','attack',false)
 if p.attack then if not Core.adapter:HasAction(p.attack)then self.farm=nil end;return true end
 if _G.SDK.Orbwalker:CanAttack()then
  local ok=Core:Attack(p.target,{owner='LastHit',context=p.context,validate=function()
    return self.farm==p and p.target.handle==p.handle and self:Buff(self.profile.wBuff)~=nil and self:FarmUseful(p.target,true)
  end,observe=function(q)local a=Core:NativeAttack(q,self.profile.wAttack);return a
   and(a.target==p.target.networkID or a.target==p.target.handle)end})
  if ok then p.attack=Core.lastIntent.id end
 end
 return true
end
function JaxChampion:NearbyFarmCount(jungle)
 local list=jungle and _G.SDK.ObjectManager:GetMonsters(375)or _G.SDK.ObjectManager:GetEnemyMinions(375);local n=0
 for i=1,math.min(#list,jungle and 12 or 40)do local u=list[i]
  if self:Reach(u,375)and(u.team==300)==jungle and u.team~=myHero.team then n=n+1 end
 end
 return n
end
function JaxChampion:Clear(kind)
 if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()then return end
 local jungle=kind=='jungle';local node=Menu.Clear[jungle and 'JungleClear'or 'LaneClear']
 if not self:Mana(node.Mana)or not(node.Q:Value()and self:Ready(_Q)or node.E1:Value()and self:Ready(_E))then return end
 local list=jungle and _G.SDK.ObjectManager:GetMonsters(700)or _G.SDK.ObjectManager:GetEnemyMinions(700);local best,nearBest,n= nil,nil,0
 for i=1,math.min(#list,jungle and 12 or 40)do local u=list[i]
  if self:Reach(u,700)and(u.team==300)==jungle and u.team~=myHero.team then
   if not best or u.maxHealth>best.maxHealth then best=u end
   if self:Reach(u,375)then n=n+1;if not nearBest or u.maxHealth>nearBest.maxHealth then nearBest=u end end
  end
 end
 if not best then return end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 if nearBest and node.E1:Value()and(jungle or n>=Menu.Clear.LaneClear.ECount:Value())then
  if self:BeginE(nearBest,context,function()return node.E1:Value()and Menu.Clear.SpellFarm:Value()and self:Mana(node.Mana)
   and(jungle or self:NearbyFarmCount(false)>=Menu.Clear.LaneClear.ECount:Value())end,
   function()return Menu.Clear.SpellFarm:Value()and self:Mana(node.Mana)end)then return true end
 end
 if not node.Q:Value()or not self:Ready(_Q)then return end
 local function allowed()return node.Q:Value()and self:Mana(node.Mana)end
 if not jungle then
  -- A lane leap is spent on a minion it kills that the attack cannot take now (out of range or on cooldown),
  -- the weakest first; the biggest minion only when Jax is out of range of every minion.
  local canAttack=_G.SDK.Orbwalker:CanAttack()
  local kill=Core:LethalPick(Core:Rows('lane',700),function(u)return self:QKills(u)end,
   function(u)return self:Reach(u,700)and(not canAttack or not _G.SDK.Data:IsInAutoAttackRange(myHero,u))end,
   function(u)return self:SafeLanding(u.pos,false)end)
  if kill then return self:CastQ(kill,context,false,function()return allowed()and self:QKills(kill)end)end
  for i=1,math.min(#list,40)do local u=list[i]
   if self:Reach(u,700)and u.team~=300 and u.team~=myHero.team and _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return end
  end
 end
 if not _G.SDK.Data:IsInAutoAttackRange(myHero,best)then return self:CastQ(best,context,false,allowed)end
end
function JaxChampion:LaneClear()return self:Clear('lane')end
function JaxChampion:JungleClear()return self:Clear('jungle')end
function JaxChampion:JumpContext()return Core:ModeContext('Flee',function()return Menu.Misc.FleeQ:Value()end)end
-- Leap Strike targets any unit: allied champions, minions and wards, and also enemy minions, neutral monsters
-- and enemy wards that are visible and targetable. Never an enemy champion while fleeing.
function JaxChampion:JumpObjects(goal)
 local result,seen={},{};local function add(u)
  local id=identity(u)
  if id and not seen[id]and u~=myHero and self:Reach(u,700)
   and(u.team==myHero.team or u.type~=Obj_AI_Hero and u.visible~=false and u.isTargetable~=false)
   and self:SafeLanding(u.pos,false)and GetDistance(u.pos,goal)+75<GetDistance(myHero.pos,goal)then seen[id]=true;result[#result+1]=u end
 end
 if Game.HeroCount and Game.Hero then for i=1,math.min(Game.HeroCount(),16)do add(Game.Hero(i))end end
 if Game.MinionCount and Game.Minion then for i=1,math.min(Game.MinionCount(),512)do add(Game.Minion(i))end end
 if Game.WardCount and Game.Ward then for i=1,math.min(Game.WardCount(),64)do add(Game.Ward(i))end end
 return result
end
function JaxChampion:ClearJump(reason)
 local p=self.jump;if p then
  if p.ward then p.service:Cancel(p.ward,p.owner)end
  if p.action then Core.adapter:Cancel(p.action,reason)end
 end
 self.jump=nil
end
function JaxChampion:BeginJump()
 if self.jump or self.jumpUsed or not self:Ready(_Q)then return false end
 local goal=position(mousePos);if not goal or GetDistance(goal,myHero.pos)<150 then return false end
 local context=self:JumpContext();local candidates=self:JumpObjects(goal);local best
 -- Closest to the cursor; an allied unit wins a near tie (within 25 units).
 local function score(u)return GetDistance(u.pos,goal)-(u.team==myHero.team and 25 or 0)end
 for _,u in ipairs(candidates)do if not best or score(u)<score(best)then best=u end end
 if best then
  if self:CastQ(best,context,false)then self.jumpUsed=true;return true end
  return false
 end
 if not Menu.Misc.Ward:Value()then return false end
 if type(Game.WardCount)~='function'or type(Game.Ward)~='function'then return false end
 local service=_G.SDK.OrbamaUtils and _G.SDK.OrbamaUtils.Wards
 if not service or type(service.Request)~='function'or type(service.Cancel)~='function'then return false end
 local aim=myHero.pos:Extended(goal,math.min(600,GetDistance(goal,myHero.pos)))
 if not self:SafeLanding(aim,false)then return false end
 local before={};if Game.WardCount and Game.Ward then for i=1,math.min(Game.WardCount(),64)do before[identity(Game.Ward(i))or 0]=true end end
 local plan={position=aim,context=context,expires=Game.Timer()+.9,owner='JaxJump',service=service,before=before}
 self.jump=plan
 local function permission()return self.jump==plan and Core:Available()and Menu.Misc.Ward:Value()
  and Core.adapter:ContextValid({context=context},'continuation')and plan.expires>Game.Timer()end
 local ok,event=service:Request(aim,{owner=plan.owner,context=context,range=600,authorized=permission,
  validate=function(pos)return permission()and self:Ready(_Q)and self:SafeLanding(pos,false)and GetDistance(pos,myHero.pos)<=600 end})
 if not ok then self.jump=nil;return false end
 plan.ward=event;self.jumpUsed=true;return true
end
function JaxChampion:ContinueJump()
 local p=self.jump;if not p then return false end
 if p.expires<=Game.Timer()or not Core:Available()or not Core.adapter:ContextValid({context=p.context},'continuation')
  or p.ward.gameplayCancelled then self:ClearJump('jump_ended');return false end
 if p.action then if not Core.adapter:HasAction(p.action)then self.jump=nil end;return true end
 -- Spending was authorized before placement. After consumption, actual object
 -- discovery and Q legality matter, not current inventory charges.
 if p.ward.status~='observed'and p.ward.status~='sent'and p.ward.status~='unconfirmed'then return true end
 if not Game.WardCount or not Game.Ward then return true end
 for i=1,math.min(Game.WardCount(),64)do local ward=Game.Ward(i);local id=identity(ward)
  if id and not p.before[id]and ward.team==myHero.team and self:Reach(ward,700)and GetDistance(ward.pos,p.position)<=100 then
   if self:CastQ(ward,p.context,false,function()return self.jump==p and GetDistance(ward.pos,p.position)<=100 end)then p.action=Core.lastIntent.id;return true end
  end
 end
 return true
end
function JaxChampion:Flee()
 if Menu.Misc.FleeQ:Value()and self:BeginJump()then return true end
 if Menu.Misc.FleeE:Value()and self:Ready(_E)then
  local target=GetTarget(375);if IsValid(target)then return self:BeginE(target,Core:ModeContext('Flee'),function()return Menu.Misc.FleeE:Value()end)end
 end
end
function JaxChampion:Shutdown(reason)cleanup(self,reason)end
function JaxChampion:Tick()
 if ShouldWait()then self:Shutdown('unavailable');return end
 self:PrepareView()
 local mode=GetMode();if mode~='Flee'then self.jumpUsed=false end
 if self:ContinueJump()or self:ContinueFarm()then return end
 if self:ContinueE()or IsCasting()then return end
 if self:DefensiveE()or self:InterruptE()or self:Finisher()then return end
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')and self:LaneClear()then return end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
-- Health-bar damage and KILL mark (shared display): the ready abilities and one attack. The recast uses the
-- dodges seen so far in an active window; Empower counts once.
function JaxChampion:ComboDamage(u)
 local total=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,finite(myHero.totalDamage)and myHero.totalDamage or 0)
 if self:Ready(_Q)then total=total+self:QDamage(u)end
 if self:Ready(_W)or self:Buff(self.profile.wBuff)then total=total+self:WDamage(u)end
 if self:Ready(_E)or self.ePlan and self:EStage(self.ePlan)then total=total+self:EDamage(u,self:Dodged())end
 if self.profile.rKind=='active_swing'and self:Ready(_R)and finite(myHero.ap)then
  local base=self.profile.rBase[myHero:GetSpellData(_R).level]
  if base then total=total+_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.rAP*myHero.ap)end
 end
 return total
end
-- Counter Strike's window for Draw, prepared in Tick (start and end of the buff).
function JaxChampion:PrepareView()
 local b=self:Buff(self.profile.eBuff)
 self.eView=b and finite(b.startTime)and {start=b.startTime,ends=Core.buffExpiry(b)}or nil
end
function JaxChampion:Draw()
 if myHero.dead then return end
 local v=self.eView
 if Menu.Draw.E:Value()and v and v.ends>Game.Timer()then
  -- The area only: the game shows the recast and the time left on the E icon.
  Draw.Circle(myHero.pos,375,2,Draw.Color(255,255,170,60))
 end
 -- Ready-gated range circles: native readiness and spell name only (no buff or object reads in Draw).
 if Menu.Draw.Q:Value()and self:Ready(_Q)then Draw.Circle(myHero.pos,700,1,Draw.Color(255,120,200,255))end
 if Menu.Draw.ERange:Value()and self:Ready(_E)then Draw.Circle(myHero.pos,375,1,Draw.Color(255,255,220,120))end
 if Menu.Draw.R and Menu.Draw.R:Value()and self:Ready(_R)then Draw.Circle(myHero.pos,self.profile.rRadius,1,Draw.Color(255,255,120,80))end
 if Menu.Draw.Plan:Value()then local p=self.jump and self.jump.position or self.farm and self.farm.target.pos
  if p then Draw.Circle(p,65,1,Draw.Color(255,255,200,100))end
  local k=self.killPreview
  -- Kept up to a second (a skipped decision tick must not blink it) while the enemy lives and is seen.
  if k and Game.Timer()-k.at<=1 and k.unit and not k.unit.dead and k.unit.visible~=false and k.unit.pos then Draw.Circle(k.unit.pos,90,2,Draw.Color(255,255,60,60))end
 end
end
function JaxChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Jax: modes','Jax: jump assistance'},function(page)
  return {title=page==1 and 'Jax modes'or 'Jump assistance',cards=page==1 and {
   {'MODES','Use provider Combo, Harass, lane/jungle, LastHit and Flee binds. Combo starts E, then jumps onto the target with Q inside the health and enemy-count limits, with W first so the leap is empowered. An enemy that Q, W then Q, the E recast or the R swing kills is finished without a mode key.'},
   {'WEAVING','W follows the actual completed attack. LastHit W (and Q, if enabled) only takes a minion the basic attack would miss.'},
    {'COUNTER STRIKE','E is recast when it kills, a channel can be interrupted, someone is about to leave the area with nobody entering, or it is about to end; dodged attacks raise its damage. An E you start yourself is timed the same way. Attacks, dashes onto Jax and long channels are met with E even without a mode key.'}}or {
   {'JUMP','Flee jumps with Q to a safe unit toward the cursor: allied champions, minions and wards, enemy minions, monsters and enemy wards (never an enemy champion). Existing units are preferred.'},
   {'WARD','Without a unit to jump to, Flee places a ward. Q waits for the new ward to appear; releasing Flee cancels the rest.'},
   {'PROFILES','Normal R checks champions in its actual nearby area. Classic R is passive and receives no active cast.'}}}
 end)
end
Core:RegisterPolicy({damageTypes={W='magical'},methods={
 Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,
 JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
 LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end},
 exceptions={non_interrupting_summoner=true},channel=function()return not Core:SelfChanneling()end,
 costPaid=function(self,q,slot)return slot==_E and self.ePlan and self:EStage(self.ePlan)end,
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot,slot==_E and self.ePlan and self.ePlan.observed)end;return true end})
-- Capture before the family wraps gameplay methods. Cleanup must remain usable
-- after the controller becomes inactive, without invoking a decision callback.
local clearJump,clearE,clearFarm=JaxChampion.ClearJump,JaxChampion.ClearE,JaxChampion.ClearFarm
cleanup=function(self,reason)clearJump(self,reason);clearE(self,reason);clearFarm(self,reason)end
JaxChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Jax"]="Jax"}
local normalSupported={["Jax"]=true}

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
