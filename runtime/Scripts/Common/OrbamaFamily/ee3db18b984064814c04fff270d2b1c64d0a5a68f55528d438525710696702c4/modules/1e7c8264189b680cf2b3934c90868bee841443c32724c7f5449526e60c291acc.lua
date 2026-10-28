return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Teemo"]=function()return _G.OrbamaFamily:Require("8c5c24d8e3fd8e2fcf45b0635646137131f0128c30fb5f369f85be71cedbcd0e")()end
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
if champion=="Teemo" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Teemo',profiles={normal=true,classic=true},
 Create=function(context)
-- Teemo profiles and evidence limits: docs/FAMILY-TEEMO.md.
local profiles=AbilityProfiles.controllers.Teemo
local finite,id=Core.finite,Core.id
-- Added numbers (R poison, trigger radius, blind buff, trap-spot catalogue): ChampionProfiles/Teemo.lua.
local teemoData=ChampionProfiles('Teemo')
local TeemoChampion=class("TeemoChampion")
function TeemoChampion:__init()
 self.profile=assert(profiles[myHero.charName],'Unsupported Teemo identity')
 self.data=assert(teemoData[myHero.charName],'Unsupported Teemo profile data')
 self.preview={blind={},spots={},at=-1};self.trapSeen={}
 self.QRange=AbilityProfiles.geometry[myHero.charName].Q.range;self.RRange=self:RReach();self.placements={};self.attackWitness=nil
 self:LoadMenu()
 self.traps={};self.trapScan=1
 Core:RegisterPreparation('owned-trap-discovery',{intervalMs=50,maxDelayMs=250,units=32,maxUnits=32},function()return self:DiscoverTraps()end,
  function()return true end,function()self.traps={};self.trapScan=1 end)
 Callback.Add('Tick',function()self:Tick()end)
 Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Teemo',function()self.preview={blind={},spots={},at=-1};self.trapSeen={};self.lastCast=nil end)
 -- Health-bar damage: a ready Q and one attack (traps and poison are not a burst).
 Core:RegisterComboDamage(function(u)
  local q=IsReady(_Q)and self:GetQDmg(u)or 0
  return q+(_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0),true
 end)
end
function TeemoChampion:LoadMenu()
 -- Spot entries only on a map this profile has a trap-spot catalogue for.
 self.spotMenu=self.data.spots~=nil and(Game.mapID==nil or Game.mapID==self.data.spots.map)
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Teemo'})
 Menu:MenuElement({type=MENU,id='Combo',name='Combo'})
 Menu.Combo:MenuElement({id='Q',name='Use Q',value=true})
 Menu.Combo:MenuElement({id='W',name='Use W to chase or to run from a melee attacker',value=true})
 Menu.Combo:MenuElement({id='R',name=self.profile.armTime and 'Use R on a close, fleeing or charging enemy'or 'Use R on an enemy in melee range',value=true})
 Menu:MenuElement({type=MENU,id='Harass',name='Harass'})
 Menu.Harass:MenuElement({id='Q',name='Use Q',value=true})
 Menu.Harass:MenuElement({id='Mana',name='Only above mana %',value=40,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='Enabled',name='Use abilities to farm (lane, jungle, last hit)',toggle=true,value=SpellFarmDefault(),key=73,callback=function(v)CheckChatBlock(Menu.Clear.Enabled,v)end})
 Menu.Clear:MenuElement({id='Q',name='Use Q',value=true})
 Menu.Clear:MenuElement({id='R',name='Use R on camps or big waves with no enemy near',value=true})
 Menu.Clear:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Flee',name='Flee'})
 Menu.Flee:MenuElement({id='W',name='Use W',value=true})
 -- Only where the profile knows how long a trap takes to arm.
 if self.profile.armTime then Menu.Flee:MenuElement({id='R',name='Drop a trap in the path of a chaser',value=true})end
 Menu:MenuElement({type=MENU,id='Safety',name='Behaviour'})
 Menu.Safety:MenuElement({id='Stealth',name='Never break stealth for an automatic Q or trap',value=true})
 Menu.Safety:MenuElement({id='Blind',name='Blind an enemy attacking you, also outside combat',value=true})
 if self.profile.armTime then Menu.Safety:MenuElement({id='Zone',name='Trap enemies who cannot move or are arriving',value=true})end
 Menu.Safety:MenuElement({id='Reserve',name='R charges to keep',value=1,min=0,max=3,step=1})
 Menu:MenuElement({type=MENU,id='Placement',name='Trap placement'})
 Menu.Placement:MenuElement({id='Hold',name=self.spotMenu and 'Trap at the cursor or the nearest trap spot'or 'Place a trap at the cursor',key=string.byte('T')})
 Menu.Placement:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 if self.spotMenu then
  Menu.Placement:MenuElement({id='Auto',name='Trap nearby bushes and chokes with no enemy near',value=true})
  Menu.Placement:MenuElement({id='AutoReserve',name='R charges to keep when trapping spots',value=2,min=0,max=4,step=1,menu=false})
 end
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Q',name='Q range',value=false})
 Menu.Draw:MenuElement({id='R',name='R range',value=false})
 Menu.Draw:MenuElement({id='Blind',name='Blind time left on enemies',value=true})
 if self.spotMenu then Menu.Draw:MenuElement({id='Spots',name='Trap spots while placing traps',value=true})end
end
function TeemoChampion:RReach()
 return self.profile.rRange[myHero:GetSpellData(_R).level]or 0
end
function TeemoChampion:Stealthed()
 if myHero.isStealthed==true then return true end
 local count=myHero.buffCount
 if not finite(count)or count>128 then return true end
 for i=0,count do
  local b=myHero:GetBuff(i)
  if b and b.name and b.name:lower()=='camouflagestealth'and(b.count or 0)>0 then
   local ending=Core.buffExpiry(b)
   if not finite(ending)or ending>Game.Timer()then return true end
  end
 end
 return false
end
function TeemoChampion:QAllowed(t,mode)
 if not IsValid(t)or not t.pos2D.onScreen or GetDistance(myHero.pos,t.pos)>self.QRange then return false end
 local node=mode=='Combo'and Menu.Combo or mode=='Harass'and Menu.Harass or mode=='LastHit'and Menu.LastHit or mode~='KillSteal'and Menu.Clear
 if node and(not node.Q:Value()or node.Mana and not Core.manaAbove(node.Mana:Value()))then return false end
 if(mode=='LaneClear'or mode=='JungleClear')and not Menu.Clear.Enabled:Value()then return false end
 if mode=='KillSteal'and Menu.Safety.Stealth:Value()and self:Stealthed()then return false end
 return true
end
function TeemoChampion:GetQDmg(t)
 local rank=myHero:GetSpellData(_Q).level;local base=({80,125,170,215,260})[rank]
 if not base then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,t,_G.SDK.DAMAGE_TYPE_MAGICAL,base+.7*myHero.ap)
end
function TeemoChampion:PoisonRaw(rank,ap,bonusAD,monster)
 local base=self.profile.eImpact[rank];if not base then return 0,0 end
 local scale=monster and self.profile.monster or 1
 return(base+.3*ap+self.profile.eAD*bonusAD)*scale,(6*rank+.1*ap+self.profile.eTickAD*bonusAD)*scale
end
function TeemoChampion:QTimes(t)
 local d=GetDistance(myHero.pos,t.pos)
 return .25+d/self.profile.qFast,.25+d/self.profile.qSpeed
end
-- Legacy prediction includes aggregate shield state. Only the shared coherent
-- unshielded forecast may authorize damage-dependent farming or automatic Q.
function TeemoChampion:ForecastHealth(target,impact)
 local hp,reason=Core:UnshieldedLegacyForecast(target,impact)
 if not finite(hp)then return nil,reason end
 local regen=target.hpRegen
 if not finite(regen)then return nil,'regen_unknown'end
 -- Incoming lethal damage remains death; later regeneration cannot revive it.
 if hp<=0 then return hp end
 return hp+math.max(0,regen)*impact
end
function TeemoChampion:AttackRescues(target)
 local sdk=_G.SDK
 if not sdk.Orbwalker:CanAttack()or not sdk.Data:IsInAutoAttackRange(myHero,target)then return false end
 local windup=sdk.Attack:GetWindup();local speed=sdk.Attack:GetProjectileSpeed()
 if not finite(windup)or windup<0 or not(speed==math.huge or finite(speed)and speed>0)then return nil,'attack_impact_unknown'end
 local impact=windup+GetDistance(myHero.pos,target.pos)/speed
 local hp=self:ForecastHealth(target,impact)
 if not finite(hp)then return nil,'attack_health_unknown'end
 if hp<=0 then return false end
 local damage=sdk.Damage:GetAutoAttackDamage(myHero,target,true)
 if not finite(damage)then return nil,'attack_damage_unknown'end
 return damage>=hp
end
function TeemoChampion:QForecastLethal(t,scale)
 local first,last=self:QTimes(t)
 local hp=self:ForecastHealth(t,first)
 if not finite(hp)or hp<=0 then return false end
 local late=first==last and hp or self:ForecastHealth(t,last)
 if not finite(late)or late<=0 then return false end
 local damage=self:GetQDmg(t)*(scale or 1)
 return finite(damage)and damage>=math.max(hp,late)
end
function TeemoChampion:CanRescue(t,mode)
 if not self:QAllowed(t,mode)or t.type~=Obj_AI_Minion or t.team==300 or _G.SDK.Attack:IsActive()then return false end
 -- Owned poison timing remains unmodelled; never add speculative ticks.
 if not self:QForecastLethal(t)then return false end
 return self:AttackRescues(t)==false
end
function TeemoChampion:QLethal(t,scale)return self:QForecastLethal(t,scale)end
-- The finisher keeps this controller's own forecast (it weighs both recorded
-- dart speeds and refuses unknown shields, which the shared kill rule does not
-- do) and adds the shared checks: spell protection, states in which the target
-- cannot die when the dart lands (undying, revive, stasis: Core:CannotDie) and
-- the player's own Exhaust (Core:OutgoingScale).
function TeemoChampion:QFinishes(t)
 if Core:SpellProtected(t)~=false then return false end
 local _,last=self:QTimes(t)
 if Core:CannotDie(t,last)then return false end
 return self:QLethal(t,Core:OutgoingScale())
end
function TeemoChampion:CastQ(t,mode,attack)
 if not IsReady(_Q)or not self:QAllowed(t,mode)then return false end
 local targetID=id(t)
 return Core:Cast(HK_Q,t,{validate=function()
  if id(t)~=targetID or not self:QAllowed(t,mode)then return false end
  if attack and(self.attackWitness~=attack or Game.Timer()-attack.at>.35 or attack.target~=targetID)then return false end
  return mode=='LastHit'and self:CanRescue(t,mode)or mode=='LaneClear'and t.team~=300 and self:CanRescue(t,mode)
   or mode=='KillSteal'and self:QFinishes(t)or(mode~='LastHit'and mode~='LaneClear'and mode~='KillSteal')or mode=='LaneClear'and t.team==300
 end})
end
function TeemoChampion:OnPostAttack(args)
 if GetMode()~='Combo'or ShouldWait()then return end
 local target=args and(args.Target or args.target)
 local a=myHero.activeSpell
 local data=_G.SDK.Data
 local observedAttack=a and(a.isAutoAttack or data and data.IsAttack and data:IsAttack(a.name or ''))
 -- A callback with no attributable attack must not switch to a fresh selection.
 if not IsValid(target)or target.type~=Obj_AI_Hero or not a or not a.valid or not observedAttack
  or(a.target~=target.handle and a.target~=target.networkID)or not finite(a.startTime)or not finite(a.castEndTime)
  or a.castEndTime>Game.Timer()or Game.Timer()-a.castEndTime>.35 then return end
 local witness={object=target,target=id(target),at=a.castEndTime,start=a.startTime}
 self.attackWitness=witness;self:CastQ(target,'Combo',witness)
end
function TeemoChampion:RPending()
 local r=self.rRequest;if not r then return false end
 local q=r.intent
 if q.observedAt then self:RecordR(r);self.rRequest=nil;return false end
 -- The shared lifecycle owns pending input and fresh-resource reconciliation.
 -- A historical send must not become a second, permanent champion reservation.
 if Core.pending[HK_R]==q then return true end
 if q.sentAt and not r.recorded then self:RecordR(r,true)end
 self.rRequest=nil;return false
end
function TeemoChampion:RecordR(receipt,unresolved)
 if receipt.recorded then return end
 receipt.recorded=true
 local p=receipt.position;self:Occupied(p)
 local at=Game.Timer()
 if unresolved and receipt.intent.sentAt then at=at-math.max(0,Core.adapter:Now()-receipt.intent.sentAt)/1000 end
 if #self.placements<32 and Game.Timer()-at<3 then
  self.placements[#self.placements+1]={pos=Vector(p),at=at,source=unresolved and 'send unresolved'or 'cast observed'}
 end
 if not unresolved then
  self.lastRPos=Vector(p);self.lastRTime=GetTickCount();self.lastCast={at=Game.Timer(),pos=Vector(p)}
  -- Teemo-6 (Classic cast range unmeasured): the distance of every observed throw.
  if Core.logger then Core:Trace('teemo_r_cast',{profile=self.profile.id,distance=GetDistance(p,myHero.pos),reach=self:RReach()})end
 end
end
function TeemoChampion:Occupied(p)
 local now=Game.Timer();local kept={};local found=false
 for _,row in ipairs(self.placements)do
  if now-row.at<3 then kept[#kept+1]=row;if GetDistance(row.pos,p)<150 then found=true end end
 end
 self.placements=kept
 for key,row in pairs(self.traps)do
  local u=Game.Minion and Game.Minion(row.index)or nil
  if not u or id(u)~=key or u.dead or u.valid==false or u.alive==false or self:TrapOwner(u)~=myHero.networkID then self.traps[key]=nil
  elseif u.pos and GetDistance(u.pos,p)<150 then found=true end
 end
 return found or #kept>=32
end
function TeemoChampion:TrapOwner(u)
 local owner=u and(u.owner or u.ownerID or u.source or u.sourceID)
 if type(owner)=='table'or type(owner)=='userdata'then return id(owner)end
 return owner
end
function TeemoChampion:DiscoverTraps()
 if not Game.MinionCount or not Game.Minion then return true end
 local count=Game.MinionCount();if not finite(count)or count<0 or count>4096 then return true end
 local first=self.trapScan;local last=math.min(count,first+31)
 for i=first,last do local u=Game.Minion(i)
  -- Object-name discovery is a candidate filter, never a damage alias. Ownership
  -- and live identity are mandatory; a sent R does not fabricate a trap.
  local name=u and(u.charName or u.name)
  if type(name)=='string'and(name:lower():find('teemomushroom',1,true)or name:lower():find('noxioustrap',1,true))
   and self:TrapOwner(u)==myHero.networkID and u.team==myHero.team and u.valid~=false and not u.dead and u.pos then
   local key=id(u);if key then
    local current=0;for _ in pairs(self.traps)do current=current+1 end
    if self.traps[key]or current<32 then
     local row=self.traps[key]
     if not row then row={object=u,index=i,observedAt=Game.Timer()};self.traps[key]=row;self:TraceTrap(row,u,true)
     else row.object=u;row.index=i;row.observedAt=Game.Timer();self:TraceTrap(row,u,false)end
    end
   end
  end
 end
 self.trapScan=last>=count and 1 or last+1;return true
end
-- Teemo-6 dev evidence (Classic arming time is unknown): the first sighting of
-- an own trap after an observed throw and every change of its visible state in
-- the next 3 s (targetable, visible, name, health). Dev recorder only.
function TeemoChampion:TraceTrap(row,u,first)
 if not Core.logger then return end
 local now=Game.Timer()
 if first then row.firstAt=now end
 if not row.firstAt or now-row.firstAt>3 then return end
 local state=tostring(u.isTargetable)..'|'..tostring(u.visible)..'|'..tostring(u.charName or u.name)..'|'..tostring(u.health)
 if state==row.state then return end
 row.state=state
 local cast=self.lastCast
 Core:Trace('teemo_trap_arm',{profile=self.profile.id,first=first,sinceCast=cast and now-cast.at,fromCast=cast and u.pos and GetDistance(u.pos,cast.pos),
  targetable=u.isTargetable,visible=u.visible,name=u.charName or u.name,health=u.health})
end
function TeemoChampion:PlaceTrap()
 if not Menu.Placement.Hold:Value()or not Core.manaAbove(Menu.Placement.Mana:Value())or not IsReady(_R)or self:RPending()then return end
 local aim=Vector(mousePos);local range=self:RReach()
 -- A catalogued spot within 300 of the cursor and in reach wins over the cursor.
 local spot=self:SnapSpot(aim)
 if spot then aim=spot elseif GetDistance(aim,myHero.pos)>range then aim=myHero.pos:Extended(aim,range)end
 local function allowed()
  local d=myHero:GetSpellData(_R)
  if not Menu.Placement.Hold:Value()or not Core.manaAbove(Menu.Placement.Mana:Value())or not finite(d.ammo)or d.ammo<=Menu.Safety.Reserve:Value()
   or GetDistance(aim,myHero.pos)>self:RReach()or self:Occupied(aim)or not Game.isWall then return false end
  local ok,wall=pcall(Game.isWall,aim);return ok and wall==false
 end
 if not allowed()then return end
 if Core:Cast(HK_R,aim,{range=range,validate=allowed})then self:TrackR({position=aim})end
end
-- Trap-spot catalogue of this profile's map (ChampionProfiles/Teemo.lua spots),
-- nil on any other map. Rows are {x,z,kind}.
function TeemoChampion:Spots()
 local c=self.data.spots
 return c and Game.mapID==c.map and c.rows or nil
end
function TeemoChampion:SpotPoint(row)return Vector(row[1],myHero.pos.y or 0,row[2])end
function TeemoChampion:SnapSpot(cursor)
 local rows=self:Spots();if not rows then return nil end
 local reach=self:RReach();local best,bestD
 for i=1,math.min(#rows,128)do local p=self:SpotPoint(rows[i]);local d=GetDistance(p,cursor)
  if d<=300 and(not bestD or d<bestD)and GetDistance(p,myHero.pos)<=reach then best,bestD=p,d end
 end
 return best
end
function TeemoChampion:EnemyNear(range)
 local heroes=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#heroes,10)do local u=heroes[i]
  if IsValid(u)and GetDistance(u.pos,myHero.pos)<=range then return true end
 end
 return false
end
-- Upkeep: outside fights, with no enemy champion visible within 1200 and more
-- charges than the upkeep reserve, a trap goes to the nearest free catalogued
-- spot in reach (owned traps and recent throws mark a spot as taken).
function TeemoChampion:AutoSpotsAllowed()
 local mode=GetMode()
 if not Menu.Placement.Auto or not Menu.Placement.Auto:Value()or mode=='Combo'or mode=='Harass'or mode=='Flee'then return false end
 local d=myHero:GetSpellData(_R)
 return finite(d.ammo)and d.ammo>Menu.Placement.AutoReserve:Value()and not self:EnemyNear(1200)
end
function TeemoChampion:AutoSpots()
 local rows=self:Spots()
 if not rows or not IsReady(_R)or self:RPending()or not self:AutoSpotsAllowed()then return false end
 local reach=self:RReach()
 local now=Game.Timer();if self.autoAt and now<self.autoAt then return false end
 local best,bestD
 for i=1,math.min(#rows,128)do local p=self:SpotPoint(rows[i]);local d=GetDistance(p,myHero.pos)
  if d<=reach and(not bestD or d<bestD)and self:TrapSpot(p)then best,bestD=p,d end
 end
 if not best then return false end
 self.autoAt=now+.5
 local function fits()return self:Spots()~=nil and self:AutoSpotsAllowed()and self:TrapSpot(best)end
 if Core:Cast(HK_R,best,{range=reach,validate=fits})then self:TrackR({position=best});return true end
 return false
end
-- One receipt per requested trap: the shared lifecycle owns the input, the
-- receipt only remembers the spot once the cast is observed (or unresolved).
function TeemoChampion:TrackR(receipt)
 receipt.intent=Core.lastIntent;self.rRequest=receipt
 Core:AfterCast(HK_R,function()self:RecordR(receipt);if self.rRequest==receipt then self.rRequest=nil end end)
end
-- A spot a trap may go to without a mode key: charges above the reserve, in
-- reach, not doubled, known open ground, and never out of stealth when the
-- player keeps stealth.
function TeemoChampion:TrapSpot(p)
 local d=myHero:GetSpellData(_R)
 if not p or not finite(d.ammo)or d.ammo<=Menu.Safety.Reserve:Value()or GetDistance(p,myHero.pos)>self:RReach()
  or not Core.manaAbove(Menu.Placement.Mana:Value())or Menu.Safety.Stealth:Value()and self:Stealthed()or self:Occupied(p)or not Game.isWall then return false end
 local ok,wall=pcall(Game.isWall,p);return ok and wall==false
end
-- Without a mode key: a trap under an enemy who cannot move yet or is about to
-- arrive (stasis, revive, hard control, channels, teleport and gate markers:
-- the shared scan). It must have armed before the enemy is free: cast, flight
-- and the profile's arming time are weighed against the row, again at dispatch.
function TeemoChampion:ZoneR()
 local p=self.profile
 if not p.armTime or not Menu.Safety.Zone:Value()or not IsReady(_R)or self:RPending()then return false end
 local range=self:RReach();if range<=0 then return false end
 local base=.25+p.armTime
 local rows=Core:ZoneTargets({range=range,arm=base,lifetime=10})
 for i=1,math.min(#rows,6)do local row=rows[i];local pos=row.position and Vector(row.position)
  local function fits()
   return Menu.Safety.Zone:Value()and row.valid()and row.freeAt-Game.Timer()>=base+GetDistance(pos,myHero.pos)/p.rSpeed and self:TrapSpot(pos)
  end
  if pos and fits()and Core:Cast(HK_R,pos,{range=range,validate=fits})then self:TrackR({position=pos});return true end
 end
 return false
end
-- Flee: a trap where Teemo stands, when the chaser is far enough behind that
-- it has armed by the time the chaser gets there (profile arming time and the
-- chaser's own speed) but close enough to be following this path.
function TeemoChampion:FleeTrap()
 local p=self.profile
 if not p.armTime or not Menu.Flee.R:Value()or not IsReady(_R)or self:RPending()then return false end
 local t=GetTarget(900);if not IsValid(t)or not finite(t.ms)or t.ms<=0 then return false end
 local identity=id(t);local spot
 local function plan()
  if not Menu.Flee.R:Value()or not IsValid(t)or id(t)~=identity then return nil end
  local d=GetDistance(t.pos,myHero.pos);local lead=t.ms*(.25+p.armTime+.1)
  -- The chaser must still need the whole arming time to get to Teemo's own spot.
  if d<lead or d>lead+300 then return nil end
  return Vector(myHero.pos)
 end
 spot=plan();if not spot or not self:TrapSpot(spot)then return false end
 if Core:Cast(HK_R,spot,{context=Core:ModeContext('Flee'),validate=function()
  local now=plan();return now~=nil and GetDistance(now,spot)<=150 and self:TrapSpot(spot)end})then self:TrackR({position=spot});return true end
 return false
end
-- A spot for a trap thrown while a fight mode is held (the mode is the consent
-- to leave stealth): charges above the reserve, in reach, not doubled, open ground.
function TeemoChampion:CombatSpot(p)
 local d=myHero:GetSpellData(_R)
 if not p or not finite(d.ammo)or d.ammo<=Menu.Safety.Reserve:Value()or GetDistance(p,myHero.pos)>self:RReach()or self:Occupied(p)or not Game.isWall then return false end
 local ok,wall=pcall(Game.isWall,p);return ok and wall==false
end
function TeemoChampion:TrapDamage(t)
 local base=self.data.rBase[myHero:GetSpellData(_R).level]
 if not base then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,t,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.data.rAP*myHero.ap)
end
-- The direction a champion walks away from Teemo, from its current path: unit
-- vector and remaining length, or nil when it stands, dashes or approaches.
function TeemoChampion:Fleeing(t)
 local path=t.pathing
 if not path or path.hasMovePath~=true or path.isDashing or not path.endPos or not finite(t.ms)or t.ms<=0 then return nil end
 local dx,dz=path.endPos.x-t.pos.x,path.endPos.z-t.pos.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<50 or dx*(t.pos.x-myHero.pos.x)+dz*(t.pos.z-myHero.pos.z)<=0 or GetDistance(path.endPos,myHero.pos)<=GetDistance(t.pos,myHero.pos)then return nil end
 return dx/length,dz/length,length
end
-- Teemo-1 cut-off trap (profiles with a known arming time): on the path of a
-- fleeing target at the point it reaches once the trap has armed (cast, flight,
-- arming), when its path runs at least the trigger radius beyond that point;
-- worth it below 25% health or when the poison (+ a ready Q in range) kills.
function TeemoChampion:CutOffPlan(t)
 local p=self.profile
 if not p.armTime or not IsValid(t)then return nil end
 local ux,uz,length=self:Fleeing(t);if not ux then return nil end
 local along=t.ms*(.25+p.armTime)
 for _=1,2 do
  local aim={x=t.pos.x+ux*along,z=t.pos.z+uz*along}
  along=t.ms*(.25+GetDistance(aim,myHero.pos)/p.rSpeed+p.armTime)+50
 end
 if along+self.data.rTrigger>length then return nil end
 local aim=Vector(t.pos.x+ux*along,t.pos.y or 0,t.pos.z+uz*along)
 local flight=.25+GetDistance(aim,myHero.pos)/p.rSpeed
 if GetDistance(aim,myHero.pos)>self:RReach()then return nil end
 -- The poison ticks from the trigger on: a target that cannot die then is not worth a trap
 -- even when the state ends before the last tick.
 if Core:CannotDie(t,flight+p.armTime)then return nil end
 if finite(t.maxHealth)and t.maxHealth>0 and t.health/t.maxHealth<.25 then return aim end
 local damage=self:TrapDamage(t)
 if IsReady(_Q)and GetDistance(t.pos,myHero.pos)<=self.QRange then damage=damage+self:GetQDmg(t)end
 if Core:Lethal(t,flight+p.armTime+self.data.rPoison,damage,{kind='magical'})then return aim end
 return nil
end
-- Teemo-1 self trap: a melee champion walking at Teemo gets a trap 100 in front
-- of Teemo when it still needs the whole cast, flight and arming time to reach
-- it, and is close enough to be coming for Teemo.
function TeemoChampion:SelfTrapPlan(u)
 local p=self.profile
 if not p.armTime or not IsValid(u)or(u.range or 0)>300 or not finite(u.ms)or u.ms<=0 then return nil end
 local path=u.pathing;local d=GetDistance(u.pos,myHero.pos)
 if not path or path.hasMovePath~=true or path.isDashing or not path.endPos or GetDistance(path.endPos,myHero.pos)>=d-50 then return nil end
 local spot=myHero.pos:Extended(u.pos,100)
 local need=.25+GetDistance(spot,myHero.pos)/p.rSpeed+p.armTime+.1
 local arrive=GetDistance(u.pos,spot)/u.ms
 if arrive<need or arrive>need+300/u.ms then return nil end
 return Vector(spot)
end
function TeemoChampion:CombatTrap(t,plan)
 local spot=plan(t);if not spot or not self:CombatSpot(spot)then return false end
 local identity=id(t)
 if Core:Cast(HK_R,spot,{range=self:RReach(),validate=function()
  if not Menu.Combo.R:Value()or id(t)~=identity then return false end
  local now=plan(t);return now~=nil and GetDistance(now,spot)<=150 and self:CombatSpot(spot)
 end})then self:TrackR({position=spot});return true end
 return false
end
-- Teemo-2: a melee champion within 300 that walks at Teemo or winds up an
-- attack on it.
function TeemoChampion:MeleeThreat()
 local heroes=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#heroes,10)do local u=heroes[i]
  if IsValid(u)and(u.range or 0)<=300 and GetDistance(u.pos,myHero.pos)<=300 then
   local a=u.activeSpell;local path=u.pathing
   if a and a.valid and not a.isStopped and(a.target==myHero.networkID or a.target==myHero.handle)and(a.isAutoAttack or _G.SDK.Data:IsAttack(a.name or ''))then return u end
   if path and path.hasMovePath==true and path.endPos and GetDistance(path.endPos,myHero.pos)<GetDistance(u.pos,myHero.pos)-25 then return u end
  end
 end
 return nil
end
-- Teemo-3: a trap into 4+ lane minions (their positions when it has armed)
-- with spare charges (reserve + 1) and no enemy champion within 1200.
function TeemoChampion:LanePlan()
 local p=self.profile;local reach=self:RReach();local arm=p.armTime or 1
 local minions=Core:DecisionUnits('GetEnemyMinions');local points={}
 for i=1,math.min(#minions,32)do local m=minions[i]
  if #points>=24 then break end
  if IsValid(m)and m.team~=300 and GetDistance(m.pos,myHero.pos)<=reach+300 then
   local x,z=m.pos.x,m.pos.z;local path=m.pathing
   if path and path.hasMovePath==true and path.endPos and finite(m.ms)then
    local horizon=.25+GetDistance(m.pos,myHero.pos)/p.rSpeed+arm
    local dx,dz=path.endPos.x-x,path.endPos.z-z;local l=math.sqrt(dx*dx+dz*dz);local step=math.min(l,m.ms*horizon)
    if l>0 then x,z=x+dx/l*step,z+dz/l*step end
   end
   points[#points+1]={x=x,z=z,unit=m}
  end
 end
 if #points<4 then return nil end
 local aim,_,hits=Core:BestAim(points,{kind='circle',radius=300,range=reach})
 if not aim or #hits<4 then return nil end
 return Vector(aim.x,myHero.pos.y or 0,aim.z)
end
function TeemoChampion:LaneTrapAllowed()
 if not Menu.Clear.R:Value()or not Menu.Clear.Enabled:Value()or not Core.manaAbove(Menu.Clear.Mana:Value())then return false end
 local d=myHero:GetSpellData(_R)
 return finite(d.ammo)and d.ammo>Menu.Safety.Reserve:Value()+1 and not self:EnemyNear(1200)
end
function TeemoChampion:LaneTrap()
 if not IsReady(_R)or self:RPending()or not self:LaneTrapAllowed()then return false end
 local spot=self:LanePlan();if not spot or not self:CombatSpot(spot)then return false end
 if Core:Cast(HK_R,spot,{range=self:RReach(),validate=function()
  if not self:LaneTrapAllowed()then return false end
  local now=self:LanePlan();return now~=nil and GetDistance(now,spot)<=150 and self:CombatSpot(spot)
 end})then self:TrackR({position=spot});return true end
 return false
end
function TeemoChampion:RAllowed(t,mode,p)
 local node=mode=='Combo'and Menu.Combo or Menu.Clear
 if not node.R:Value()or not IsValid(t)or not t.pos2D.onScreen or not p then return false end
 if(mode=='LaneClear'or mode=='JungleClear')and(not Menu.Clear.Enabled:Value()or not Core.manaAbove(Menu.Clear.Mana:Value())or t.team~=300)then return false end
 local d=myHero:GetSpellData(_R)
 if not finite(d.ammo)or d.ammo<=Menu.Safety.Reserve:Value()then return false end
 if GetDistance(myHero.pos,p)>self:RReach()or self:Occupied(p)then return false end
 -- Preserve Classic's close-range trap behavior. Normal uses the same explicit
 -- melee defense policy; longer range is available to the resolver, not auto-map spots.
 if mode=='Combo'and GetDistance(myHero.pos,t.pos)>230 then return false end
 if not Game.isWall then return false end
 local ok,wall=pcall(Game.isWall,p);return ok and wall==false
end
function TeemoChampion:CastR(t,mode)
 mode=mode or GetMode()
 if not IsReady(_R)or self:RPending()then return false end
 self.RSpell=AbilityProfiles.Spell(myHero.charName,'R',OrbamaPrediction);self.RSpell.Range=self:RReach()
 local pred=Core:Prediction(self.RSpell);pred:GetPrediction(t,myHero)
 if not pred:CanHit(2)or not self:RAllowed(t,mode,pred.CastPosition)then return false end
 local point=Vector(pred.CastPosition);local targetID=id(t);local receipt={position=point}
 local ok=Core:Cast(HK_R,pred.CastPosition,{prevalidateWorldCast=true,validate=function(_,resolved)
  local aim=resolved and resolved.position or point
  if id(t)~=targetID or not self:RAllowed(t,mode,aim)then return false end
  point=Vector(aim);receipt.position=point;return true
 end})
 if not ok then return false end
 local d=myHero:GetSpellData(_R);local request=Core.lastIntent
 receipt.intent=request;receipt.ammo=d.ammo;receipt.cd=d.currentCd;self.rRequest=receipt
 Core:AfterCast(HK_R,function()
  self:RecordR(receipt);if self.rRequest==receipt then self.rRequest=nil end
 end)
 return true
end
function TeemoChampion:Combo()
 if Menu.Combo.W:Value()and IsReady(_W)then
  local m=self:MeleeThreat()
  if m then
   if Core:Cast(HK_W,nil,{intentTarget=m,validate=function()return Menu.Combo.W:Value()and self:MeleeThreat()~=nil end})then return end
  end
 end
 if Menu.Combo.R:Value()and self.profile.armTime and IsReady(_R)and not self:RPending()then
  local far=GetTarget(self:RReach()+400)
  if IsValid(far)and self:CombatTrap(far,function(u)return self:CutOffPlan(u)end)then return end
  local heroes=Core:DecisionUnits('GetEnemyHeroes')
  for i=1,math.min(#heroes,10)do
   if self:CombatTrap(heroes[i],function(u)return self:SelfTrapPlan(u)end)then return end
  end
 end
 local t=GetTarget(self.QRange);if not IsValid(t)or not t.pos2D.onScreen then return end
 if Menu.Combo.R:Value()and GetDistance(myHero.pos,t.pos)<=230 and self:CastR(t,'Combo')then return end
 local aa=myHero.range+myHero.boundingRadius+(t.boundingRadius or 0)
 if GetDistance(myHero.pos,t.pos)>aa then
  if self:CastQ(t,'Combo')then return end
  if Menu.Combo.W:Value()and IsReady(_W)then
   Core:Cast(HK_W,nil,{intentTarget=t,validate=function()return Menu.Combo.W:Value()and IsValid(t)and GetDistance(myHero.pos,t.pos)>myHero.range+myHero.boundingRadius+(t.boundingRadius or 0)and GetDistance(myHero.pos,t.pos)<=self.QRange end})
  end
 end
end
function TeemoChampion:Harass()
 local t=GetTarget(self.QRange);if IsValid(t)then self:CastQ(t,'Harass')end
end
function TeemoChampion:Farm(mode)
 local key=mode=='JungleClear'and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or mode=='LaneClear'and _G.SDK.ORBWALKER_MODE_LANECLEAR or _G.SDK.ORBWALKER_MODE_LASTHIT
 if not _G.SDK.Orbwalker.Modes[key]then return end
 if mode~='LastHit'and(not Menu.Clear.Enabled:Value()or IsUnderTurret(myHero))then return end
 local minions=Core:DecisionUnits('GetEnemyMinions')
 if mode~='JungleClear'then
  for i=1,math.min(#minions,32)do local m=minions[i]
   if self:CanRescue(m,mode)and self:CastQ(m,mode)then return end
  end
 end
 if mode=='LaneClear'and self:LaneTrap()then return end
 if mode~='JungleClear'then return end
 local monsters=Core:DecisionUnits('GetMonsters')
 for i=1,math.min(#monsters,16)do local m=monsters[i]
  if IsValid(m)and GetDistance(myHero.pos,m.pos)<=self.QRange and Core.manaAbove(Menu.Clear.Mana:Value())then
   if self:CastQ(m,mode)then return end
   if self:CastR(m,mode)then return end
  end
 end
end
function TeemoChampion:Clear()self:Farm('LaneClear')end
function TeemoChampion:JungleClear()self:Farm('JungleClear')end
function TeemoChampion:LastHit()self:Farm('LastHit')end
function TeemoChampion:KillSteal()
 if not IsReady(_Q)then return end
 local heroes=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#heroes,10)do local t=heroes[i]
  if self:QAllowed(t,'KillSteal')and self:QFinishes(t)and self:CastQ(t,'KillSteal')then return end
 end
end
function TeemoChampion:Tick()
 self.RRange=self:RReach();self:RPending()
 if ShouldWait()or IsCasting()then return end
 self:Prepare()
 self:PlaceTrap();self:BlindAttack();self:KillSteal();self:ZoneR();self:AutoSpots();local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then
  if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR]then self:Clear()end
   if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR]then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()
 elseif mode=='Flee'then
  if Menu.Flee.W:Value()and IsReady(_W)then
   Core:Cast(HK_W,nil,{context=Core:ModeContext('Flee'),validate=function()return Menu.Flee.W:Value()and IsReady(_W)end})
  end
  self:FleeTrap()
 end
end
-- Blinding an attack that is winding up on Teemo: always while a fight mode is
-- held (the mode is the consent to spend the mana); otherwise (lane, farming,
-- walking) behind its switch, above 20% mana and never out of stealth when the
-- player keeps stealth.
function TeemoChampion:BlindKeyless(u)
 return Menu.Safety.Blind:Value()and Core.manaAbove(20)and not(Menu.Safety.Stealth:Value()and self:Stealthed())
  and IsValid(u)and u.pos2D.onScreen and GetDistance(myHero.pos,u.pos)<=self.QRange
end
function TeemoChampion:BlindAttack()
 local mode=GetMode();local fight=mode=='Combo'or mode=='Harass'
 if not IsReady(_Q)or not fight and not Menu.Safety.Blind:Value()then return end
 local units=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#units,10)do local u=units[i];local a=u.activeSpell
  local function threat()
   local cast=u.activeSpell
   local allowed=fight and GetMode()==mode and self:QAllowed(u,mode)or not fight and(GetMode()~='Combo'and GetMode()~='Harass')and self:BlindKeyless(u)
   if not allowed or not cast or not cast.valid or cast.isStopped or cast.startTime~=a.startTime
    or(cast.target~=myHero.networkID and cast.target~=myHero.handle)then return false end
   local attack=cast.isAutoAttack or _G.SDK.Data:IsAttack(cast.name or '')
   local _,latest=self:QTimes(u)
   return attack and finite(cast.castEndTime)and cast.castEndTime>Game.Timer()+latest
  end
  if a and a.valid and threat()then
   if Core:Cast(HK_Q,u,{priority='interactive',context=fight and Core:ModeContext(mode)or nil,validate=function()return IsReady(_Q)and threat()end})then return end
  end
 end
end
-- Drawing preview, refreshed at most every 0.1 s: own Blinding Dart time left
-- on visible enemies, and catalogued spots near Teemo (free or taken) while
-- the trap key is held. Draw only renders this.
function TeemoChampion:Prepare()
 local now=Game.Timer();local view=self.preview
 if now-view.at<.1 then return end
 local blind,spots={},{}
 if Menu.Draw.Blind:Value()then
  local heroes=Core:DecisionUnits('GetEnemyHeroes')
  for i=1,math.min(#heroes,10)do local u=heroes[i];local count=u.buffCount
   if IsValid(u)and finite(count)and count>=0 and count<=128 then
    for j=0,count do local b=u:GetBuff(j)
     if b and type(b.name)=='string'and b.name:lower()==self.data.blindBuff and(b.count or 1)>0
      and(not b.sourcenID or b.sourcenID==0 or b.sourcenID==myHero.networkID or b.sourcenID==myHero.handle)then
      local ending=Core.buffExpiry(b);local total=finite(b.duration)and b.duration>0 and b.duration or nil
      if finite(ending)and ending>now then blind[#blind+1]={unit=u,ends=ending,total=total};break end
     end
    end
   end
  end
 end
 local rows=Menu.Draw.Spots and Menu.Draw.Spots:Value()and Menu.Placement.Hold:Value()and self:Spots()
 if rows then
  for i=1,math.min(#rows,128)do local p=self:SpotPoint(rows[i])
   if GetDistance(p,myHero.pos)<=1500 and #spots<24 then spots[#spots+1]={pos=p,taken=self:Occupied(p)}end
  end
  view.snap=self:SnapSpot(Vector(mousePos))
 else view.snap=nil end
 view.blind,view.spots,view.at=blind,spots,now
end
function TeemoChampion:Draw()
 if myHero.dead then return end
 local view=self.preview
 -- The prepared end time counts down here, so a late preparation neither blinks nor freezes the bar.
 local now=Game.Timer()
 for _,row in ipairs(view.blind)do local u=row.unit;local left=row.ends-now
  if left>0 and IsValid(u)and u.pos2D.onScreen then
   local x,y=u.pos2D.x-40,u.pos2D.y-70;local share=row.total and math.min(1,left/row.total)or 1
   Draw.Rect(x,y,80,6,Draw.Color(160,0,0,0));Draw.Rect(x,y,80*share,6,Draw.Color(220,200,200,40))
   Draw.Text(string.format('%.1f',left),12,x+84,y-4,Draw.Color(230,255,255,255))
  end
 end
 for _,row in ipairs(view.spots)do
  Draw.Circle(row.pos,60,1,row.taken and Draw.Color(160,140,140,140)or Draw.Color(220,80,220,80))
 end
 if view.snap then Draw.Circle(view.snap,90,2,Draw.Color(255,255,220,60))end
 if Menu.Draw.Q:Value()and IsReady(_Q)then Draw.Circle(myHero.pos,self.QRange,1,Draw.Color(255,66,244,113))end
 if Menu.Draw.R:Value()and IsReady(_R)then Draw.Circle(myHero.pos,self:RReach(),1,Draw.Color(255,244,66,96))end
end
function TeemoChampion:RegisterGuide(guide,settings)
 local cfg,links,activate=settings.new(guide,{q={node=Menu.Combo.Q,label='Combo Q'},r={node=Menu.Combo.R,label='Melee R'},reserve={node=Menu.Safety.Reserve,label='Trap reserve'},stealth={node=Menu.Safety.Stealth,label='Preserve stealth'},last={node=Menu.LastHit.Q,label='Last Hit Q'}},function()return Core:Active()end)
 return guide:Register('champion',{'Teemo: combat','Teemo: farming and traps'},function(page)
  if page==1 then return {title=self.profile.id=='classic'and 'Classic Teemo'or 'Teemo',subtitle='Use the provider mode keys.',cards={
   {'COMBAT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..'. [[q]] follows an attributable attack or reaches a target outside attack range. W helps chase a target within Q range and runs from a melee champion closing in.'..(self.profile.armTime and ' R also cuts off a fleeing enemy the poison can finish (or below 25% health) and drops a trap in front of a charging melee champion, both only where the trap has armed in time.'or '')},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. Harass has its own Q switch and mana limit. Releasing the mode cancels waiting casts.'},
   {'STEALTH','[[stealth]] prevents automatic lethal Q, the out-of-combat blind and automatic traps from breaking camouflage. Held Combo and Harass authorize Q. Flee uses W when enabled.'}},note='Q is targeted. It does not require a skillshot confidence threshold.'}end
  return {title='Farming and traps',subtitle='Keep control over charges and farming.',cards={
    {'TRAPS','[[r]] places a defensive trap against a nearby enemy. [[reserve]] preserves charges. Placement requires known clear terrain. Recent observed casts and unresolved sends briefly suppress nearby placement; neither proves a live trap object.'..(self.profile.armTime and ' Without a mode key a trap goes under an enemy who cannot move until it has armed, or who is arriving; in Flee one is dropped in the path of a chaser.'or '')..(self.spotMenu and ' The trap key snaps to a catalogued bush or choke spot within 300 of the cursor; with no enemy near, free catalogued spots in reach are kept trapped above their own charge reserve.'or '')},
   {'FARM','The farm toggle governs lane, jungle and last-hit use. [[last]] follows the same toggle and rescues a lethal Q last hit only when an available attack or confirmed incoming hit will not already secure it.'},
    {'PROFILES',self.profile.id=='classic'and 'Classic trap throw range remains 230. Its Q travel estimate covers the conflicting 1500 and 2500 asset speeds.'or 'Normal trap throw range grows from 600 to 900 with rank. The trap bind places one toward the cursor on checked clear terrain.'}},note='Owned trap discovery checks live object identity. Held combat can blind an observed attack windup directed at you; it does not cancel an already launched attack. Unobserved future poison ticks are excluded from lethal forecasts.'}
 end,cfg,links,activate)
end
Core:RegisterPolicy({damageTypes={Q='magical'},methods={
 Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 Clear=function()return Core:FarmContext('lane')end,JungleClear=function()return Core:FarmContext('jungle')end,
  LastHit=function()return Core:ModeContext('LastHit')end,KillSteal=function()return {}end,
  PlaceTrap=function()return Core:HeldContext(function()return Menu.Placement.Hold:Value()end)end,
  ZoneR=function()return {priority='interactive'}end,AutoSpots=function()return {}end,
 OnPostAttack=function()return Core:ModeContext('Combo')end},exceptions={non_interrupting_summoner=true},
 channel=function()return not Core:SelfChanneling()end})
TeemoChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Teemo"]="Teemo"}
local normalSupported={["Teemo"]=true}

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
