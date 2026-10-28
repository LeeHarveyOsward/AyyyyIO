return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Sona"]=function()return _G.OrbamaFamily:Require("78bdb9773e0dd255a26533a610c546326f5c7c22d9a7009e30e19ea0779dfc53")()end
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
if champion=="Sona" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Sona',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent implementation; profile evidence and excluded mechanics are in
-- CombatProfiles/sona-provenance.json. Q/W/E are self casts, never aimed bolts.
local profiles=ChampionProfiles('Sona')
local finite,id,point=Core.finite,Core.id,Core.point
local function owned(b)
 local source=b.source;if type(source)=='table'or type(source)=='userdata'then source=id(source)end
 return(source==myHero.networkID or source==myHero.handle or b.sourcenID==myHero.networkID or b.sourcenID==myHero.handle)
  and(not source or source==0 or source==myHero.networkID or source==myHero.handle)
  and(not b.sourcenID or b.sourcenID==0 or b.sourcenID==myHero.networkID or b.sourcenID==myHero.handle)
end
local readyAttack={attack='ready'}
local function cleanup(self)self.preview=nil;self.attack=nil;self.priorities={};self.nextPreview=nil end
local SonaChampion=class("SonaChampion")
function SonaChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.priorities={};self:LoadMenu();self:DiscoverAllies()
  self.RSpell=AbilityProfiles.Spell(myHero.charName,'R',OrbamaPrediction)
  self.RSpell.Collision=true;self.RSpell.MaxCollision=0;self.RSpell.CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}
  self.WSpell=AbilityProfiles.Spell(myHero.charName,'W',OrbamaPrediction)
  self.directionalSupported=Core.adapter:Capabilities().directionalWorldCast==true
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 Core:RegisterCleanup('Sona',function()cleanup(self)end)
 local ok,reason=Core:RegisterPreparation('Sona.preview',{intervalMs=100,maxDelayMs=400,units=2,maxUnits=2},
  function()self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.preparation=ok;self.previewFallback=not ok and reason=='unsupported'
 self:RegisterDefense();self:RegisterHaste()
 self.flashCombo=Core:FlashFollow('SonaFlashR')
 Core:RegisterCleanup('SonaFlash',function(reason)if self.flashCombo then self.flashCombo:Cancel(reason or 'controller_closed')end end)
 -- Health-bar damage and KILL mark (S9): ready Q and R in reach plus one attack, against current health.
 Core:RegisterComboDamage(function(u)
  if not IsValid(u)then return 0 end
  local d=GetDistance(u.pos,myHero.pos);local ok,aa=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
  return(ok and finite(aa)and aa or 0)+(self:Ready(_Q)and d<=825 and self:GetQDmg(u)or 0)+(self:Ready(_R)and d<=self.RSpell.Range and self:GetRDmg(u)or 0),true
 end)
end
function SonaChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Sona'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','E'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=slot=='Q'or mode=='Combo'})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
  Menu[mode]:MenuElement({id='Chord',name='Keep a ready Power Chord as',value=1,drop={'Any','Q damage','W damage reduction','E slow'},menu=false})
 end
 Menu.Combo:MenuElement({id='R',name='Use R',value=true})
 Menu.Combo:MenuElement({id='RCount',name='R must hit at least',value=2,min=1,max=5,step=1})
 Menu.Combo:MenuElement({id='FlashR',name='Flash then R when that hits enough champions',value=false})
 Menu:MenuElement({type=MENU,id='Auto',name='Healing and protection'})
 Menu.Auto:MenuElement({id='HP',name='Heal below health %',value=65,min=0,max=100,step=5})
 Menu.Auto:MenuElement({id='Mana',name='Only above mana %',value=15,min=0,max=100,step=5})
 Menu.Auto:MenuElement({id='SpeedE',name='Use E to speed up an ally caught by crowd control',value=true})
 Menu.Auto:MenuElement({type=MENU,id='Allies',name='Heal priority per ally (0 = never)'})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'});Menu.Clear[mode]:MenuElement({id='Q',name='Use Q',value=true})
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions Q must hit',value=2,min=1,max=2,step=1,menu=false})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='InterruptR',name='Interrupt enemy channels with R',value=true})
 Menu.Misc:MenuElement({id='PeelR',name='Stun with R an enemy hitting a low-health ally',value=true})
 Menu.Misc:MenuElement({id='KillQ',name='Finish champions with Q',value=true})
 Menu.Misc:MenuElement({id='KillR',name='Finish a champion with R',value=true})
 Menu.Misc:MenuElement({id='AutoR',name='Cast R on a group without holding a mode key',value=true})
 Menu.Misc:MenuElement({id='AutoRCount',name='Automatic R must hit at least',value=3,min=2,max=5,step=1})
 Menu.Misc:MenuElement({id='FleeE',name='Use E when fleeing',value=true})
 Menu.Misc:MenuElement({id='ReserveW',name='Keep mana for W when casting Q or E',value=true,menu=false})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities and the aura',value=false})
 Menu.Draw:MenuElement({id='Preview',name='How many enemies R would hit',value=true})
end
function SonaChampion:Ready(slot)
 local key=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot];local d=key and myHero:GetSpellData(slot)
 return d and d.name==self.profile[key]and finite(d.level)and d.level>=1 and finite(d.currentCd)and d.currentCd<=0
  and finite(d.mana)and d.mana>=0 and finite(myHero.mana)and d.mana<=myHero.mana and Game.CanUseSpell(slot)==0 or false
end
function SonaChampion:Reserve(slot)
 if not Menu.Misc.ReserveW:Value()or slot==_W or not self:Ready(_W)then return true end
 local a,b=myHero:GetSpellData(slot),myHero:GetSpellData(_W)
 return a and b and finite(a.mana)and finite(b.mana)and a.mana+b.mana<=myHero.mana
end
function SonaChampion:Current(u)
 if not IsValid(u)or not id(u)then return false end
 if u==myHero then return true end
  local list=u.type==Obj_AI_Hero and Core:DecisionUnits(u.team==myHero.team and 'GetAllyHeroes'or 'GetEnemyHeroes')
  or u.team==300 and _G.SDK.ObjectManager:GetMonsters(1500)or _G.SDK.ObjectManager:GetEnemyMinions(1500)
 for i=1,math.min(#list,u.type==Obj_AI_Hero and 5 or u.team==300 and 12 or 40)do local v=list[i]
  if id(v)==id(u)and v.handle==u.handle and IsValid(v)then return true end
 end;return false
end
function SonaChampion:Reach(u,range)return self:Current(u)and point(u.pos)and GetDistance(u.pos,myHero.pos)<=range end
function SonaChampion:Enemies(range)
  local list=Core:DecisionUnits('GetEnemyHeroes');local out,seen={},{}
 for i=1,math.min(#list,5)do local u=list[i];if not seen[id(u)]and self:Reach(u,range)and u.team~=myHero.team then seen[id(u)]=true;out[#out+1]=u end end
 return out
end
function SonaChampion:Allies()
  local list=Core:DecisionUnits('GetAllyHeroes');local out,seen={},{}
 if IsValid(myHero)then out[1]=myHero;seen[id(myHero)]=true end
 for i=1,math.min(#list,5)do local u=list[i];if not seen[id(u)]and u.team==myHero.team and self:Reach(u,1000)then seen[id(u)]=true;out[#out+1]=u end end
 return out
end
function SonaChampion:DiscoverAllies()
 for _,u in ipairs(self:Allies())do local identity=id(u)
  if not self.priorities[identity]then local key=StableUnitMenuKey(self,'A',u)
   Menu.Auto.Allies:MenuElement({id=key,name=u.charName,value=3,min=0,max=5,step=1})
   self.priorities[identity]={node=Menu.Auto.Allies[key],handle=u.handle}
  elseif self.priorities[identity].handle~=u.handle then self.priorities[identity].handle=u.handle end
 end;self.nextAllies=Game.Timer()+1
end
function SonaChampion:Priority(u)local p=self.priorities[id(u)];return p and p.handle==u.handle and p.node:Value()or 0 end
function SonaChampion:BuffSnapshot()
 local out={}
 if not finite(myHero.buffCount)or myHero.buffCount%1~=0 or myHero.buffCount<0 or myHero.buffCount>128 then return out end
 for i=0,myHero.buffCount do local b=myHero:GetBuff(i)
  if b and type(b.name)=='string'and finite(b.count)and b.count>0 and owned(b)then
   local expiry=Core.buffExpiry(b)
   if finite(expiry)and expiry>Game.Timer()then if out[b.name]~=nil then out[b.name]=false else out[b.name]=b end end
  end
 end;return out
end
function SonaChampion:Buff(names,snapshot)
 if type(names)=='string'then names={names}end;if not names then return nil end
 local buffs=snapshot or self:BuffSnapshot();local found
 for _,name in ipairs(names)do local b=buffs[name]
  if b==false then return nil end
  if b then if found then return nil end;found=b end
 end;return found
end
function SonaChampion:State()
 local state={};local auraCount,effectCount=0,0;local snapshot=self:BuffSnapshot()
 local b=self:Buff(self.profile.count,snapshot)
 if b and b.count%1==0 and b.count<=3 then state.stacks=b.count;state.ready=b.count==3 end
 for i=1,3 do
  if self:Buff(self.profile.auras[i],snapshot)then auraCount=auraCount+1;state.aura=i end
  if self:Buff(self.profile.chords[i],snapshot)then effectCount=effectCount+1;state.effect=i;state.ready=true end
 end
 if auraCount>1 then state.aura=nil end;if effectCount>1 then state.effect=nil end
 if self.profile.accelerando then local a=self:Buff(self.profile.accelerando,snapshot);if a and a.count%1==0 and a.count<=120 then state.accelerando=a.count end end
 return state
end
function SonaChampion:ChordAllows(slot,mode,urgent)
 if urgent or slot==_R then return true end
 local node=Menu[mode or GetMode()];local desired=node and node.Chord and node.Chord:Value()or 1
 if desired==1 then return true end
 local state=self:State();return not state.ready or slot+1==desired-1
end
function SonaChampion:GetQDmg(u)
 local d=myHero:GetSpellData(_Q);local base=d and self.profile.qBase[d.level]
 return base and finite(myHero.ap)and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.qAP*myHero.ap)or 0
end
function SonaChampion:GetRDmg(u)
  local d=myHero:GetSpellData(_R);local base=d and self.profile.rBase[d.level]
 return base and finite(myHero.ap)and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.rAP*myHero.ap)or 0
end
function SonaChampion:HealValue(u)
 local d=myHero:GetSpellData(_W);local base=d and self.profile.healBase[d.level]
 if not base or not finite(myHero.ap)or not finite(u.health)or not finite(u.maxHealth)or u.maxHealth<=0 then return 0 end
 return math.max(0,math.min(u.maxHealth-u.health,base+self.profile.healAP*myHero.ap))
end
function SonaChampion:IncomingAttack(u)
 -- Real incoming champion damage on this ally (Core:AllyThreat: an attack on its
 -- way, a targeted cast winding up, a tracked skillshot) is prevention evidence.
 -- Nearby enemies, minion attacks and a held attack command are not. Turret shots
 -- are left out: W is the expensive spell and its shield is small against them.
 local t=Core:AllyThreat(u,1.5,{turrets=false})
 return t~=nil and(t.kind=='cast'or t.impactIn>=OrbamaPrediction:GetLaunchDelay(self.WSpell)+.05)
end
function SonaChampion:ShieldValue()
 local d=myHero:GetSpellData(_W);local base=self.profile.hasShield and d and self.profile.shieldBase[d.level]
 return base and finite(myHero.ap)and math.max(0,base+self.profile.shieldAP*myHero.ap)or 0
end
-- Normal only: the W shield is offered to Evade for the player's own dodge
-- (Evade judges the danger, so the healing mana limit does not apply). Classic W has no shield.
function SonaChampion:RegisterDefense()
 local p=self.profile;if not p.hasShield or not Core.RegisterShield then return false,'no_shield_in_profile'end
 local ok,why,adapter=Core:RegisterShield({name='Sona.W',slot=_W,key=HK_W,profile=p.id,spell=p.w,source=p.shieldSource,
  amount=function()return self:ShieldValue()end,duration=p.shieldDuration,delay=p.wDelay})
 self.defense=adapter;return ok,why
end
-- Damage already on its way to an ally within 0.75 s whose amount is known: every observed champion attack
-- landing in that window (rerank ally_support: several attackers are summed) plus each enemy turret shooting it
-- (its attack damage). Each attack counts once by its event identity (attacker and windup start); one turret shot
-- per turret. Targeted casts, missiles and skillshots carry no known amount here and add nothing.
local IMMINENT=.75
local function attackDamage(source,u)
 local ok,damage=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,source,u)
 if not ok or not finite(damage)then -- without the provider's attack model: the attacker's total attack damage, mitigated
  ok,damage=pcall(_G.SDK.Damage.CalculateDamage,_G.SDK.Damage,source,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,source.totalDamage)
 end
 return ok and finite(damage)and damage>0 and damage or 0
end
function SonaChampion:Imminent(u)
 if not IsValid(u)or not point(u.pos)then return 0 end
 local total,seen,now=0,{},Game.Timer()
 local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,5)do local enemy=enemies[i]
  if IsValid(enemy)and enemy.team~=u.team and point(enemy.pos)then
   local cast=Core:CastWindup(enemy,-1,1.25,true,u.networkID,u.handle)
   local speed=enemy.attackData and enemy.attackData.projectileSpeed
   if cast and(speed==math.huge or finite(speed)and speed>0)then
    local delay=cast.castEndTime+(speed==math.huge and 0 or GetDistance(enemy.pos,u.pos)/speed)-now
    local key=tostring(cast.casterID or cast.casterHandle)..':'..tostring(cast.start)
    if delay>=0 and delay<=IMMINENT and not seen[key]then seen[key]=true;total=total+attackDamage(enemy,u)end
   end
  end
 end
 local turrets=Core:DecisionUnits('GetEnemyTurrets')
 for i=1,math.min(#turrets,16)do local turret=turrets[i]
  if IsValid(turret)and u.networkID~=nil and turret.targetID==u.networkID and GetDistance(turret.pos,u.pos)<=1100 then total=total+attackDamage(turret,u)end
 end
 return total
end
function SonaChampion:WUseful(u)
  if not Core.manaAbove(Menu.Auto.Mana:Value())or not self:Reach(u,self.profile.healRange)or u.team~=myHero.team or self:Priority(u)<=0
  or not finite(u.health)or not finite(u.maxHealth)or u.maxHealth<=0 then return false end
 local heal=self:HealValue(u)
  if heal>=25 and u.health/u.maxHealth*100<=Menu.Auto.HP:Value()then return true,'heal',heal end
  if heal>=25 and(u.health-self:Imminent(u))/u.maxHealth*100<=Menu.Auto.HP:Value()then return true,'projected_heal',heal end
  if heal>=25 and u.health/u.maxHealth*100<=80
   and Core:ControlledHit(u,self.WSpell,myHero.pos)then return true,'control_heal',heal end
 if self.profile.hasShield and self:Reach(u,self.profile.auraRange)
  and finite(u.shieldAD)and finite(u.shieldAP)and u.shieldAD==0 and u.shieldAP==0 and self:IncomingAttack(u)then
  local shield=self:ShieldValue();if shield>0 then return true,'shield',shield end
 end;return false
end
function SonaChampion:AutoW()
 if not self:Ready(_W)or not Core.manaAbove(Menu.Auto.Mana:Value())then return false end
 local best,score
 for _,u in ipairs(self:Allies())do local yes,kind,value=self:WUseful(u)
  if yes then local nextScore=self:Priority(u)*100+value+(kind=='shield'and 1000 or 1000*(1-u.health/u.maxHealth))
   if not score or nextScore>score then best,score=u,nextScore end
  end
 end
 if not best then return false end
 local handle=best.handle
 return Core:Cast(HK_W,nil,{owner='Healing',priority='critical',intentTarget=best,deferAttackWindup=false,
  validate=function()return self:Ready(_W)and best.handle==handle and self:WUseful(best)end})
end
function SonaChampion:CastQ(u,context,permission)
 if not self:Ready(_Q)or not self:Reserve(_Q)or not self:Reach(u,825)or u.team==myHero.team or(permission and not permission())then return false end
 local handle=u.handle
 return Core:Cast(HK_Q,nil,{intentTarget=u,context=context,deferAttackWindup=true,validate=function()
  return self:Ready(_Q)and self:Reserve(_Q)and u.handle==handle and self:Reach(u,825)and(not permission or permission())end})
end
function SonaChampion:CastE(context,permission,urgent)
 if not self:Ready(_E)or not self:Reserve(_E)or(permission and not permission())or self:Buff(self.profile.id=='normal'and 'SonaESelfHaste'or 'Jade_SonaE_Haste')then return false end
 return Core:Cast(HK_E,nil,{context=context,validate=function()return self:Ready(_E)and self:Reserve(_E)
  and self:ChordAllows(_E,nil,urgent)and(not permission or permission())and not self:Buff(self.profile.id=='normal'and 'SonaESelfHaste'or 'Jade_SonaE_Haste')end})
end
-- Rerank ally_support (Auto Odyssey Sona E.Cleanse): E speeds up an ally (heal priority above 0, inside the
-- aura) whose crowd control ends while the haste still runs (hard control ending within the haste duration less
-- .5 s, an enemy champion within 1000), or an ally an enemy champion is diving, attacking or standing next to
-- (Core:PeelTarget). The chosen Power Chord and the W mana reserve are kept; everything is read again at dispatch.
function SonaChampion:SpeedReason(u)
 if u==myHero or u.networkID==myHero.networkID or self:Priority(u)<=0 or not self:Reach(u,self.profile.auraRange)then return nil end
 local cc=GetHardCCDuration(u);local window=(self.profile.eHasteDuration or 0)-.5
 if finite(cc)and cc>0 and cc<=window then
  for _,enemy in ipairs(self:Enemies(2000))do if GetDistance(enemy.pos,u.pos)<=1000 then return 'controlled'end end
 end
 if Core:PeelTarget(u,1)then return 'threatened'end
 return nil
end
function SonaChampion:SpeedAlly()
 if not Menu.Auto.SpeedE:Value()or not self:Ready(_E)or not Core.manaAbove(Menu.Auto.Mana:Value())or not self:ChordAllows(_E)then return false end
 local best,reason,score
 for _,u in ipairs(self:Allies())do local why=self:SpeedReason(u)
  if why then local value=self:Priority(u)*100+(1-u.health/u.maxHealth)*10;if not score or value>score then best,reason,score=u,why,value end end
 end
 if not best then return false end
 local handle=best.handle
 return self:CastE({priority='interactive'},function()return Menu.Auto.SpeedE:Value()and Core.manaAbove(Menu.Auto.Mana:Value())
  and best.handle==handle and IsValid(best)and self:SpeedReason(best)~=nil end)
end
-- `flash` (a Flash range) predicts champions out to R range plus that range, for plans from a Flash landing.
function SonaChampion:RRows(flash)
  local spell=self.RSpell
  if flash then
   if not self.RFlashSpell or self.RFlashSpell.Range~=spell.Range+flash then
    self.RFlashSpell={};for k,v in pairs(spell)do self.RFlashSpell[k]=v end;self.RFlashSpell.Range=spell.Range+flash
   end
   spell=self.RFlashSpell
  end
  return Core:DecisionValue(flash and 'Sona:RRowsFlash'or 'Sona:RRows',function()
   local rows={};local pred=Core:Prediction(spell)
   for _,u in ipairs(self:Enemies(spell.Range+200))do pred:GetPrediction(u,myHero)
    if Core:SpellProtected(u)==false and pred:CanHit(2)and point(pred.CastPosition)and point(pred.UnitPosition)then
     rows[#rows+1]={unit=u,id=id(u),handle=u.handle,pos=point(pred.UnitPosition),aim=point(pred.CastPosition)}
    end
   end;return rows
  end)
end
function SonaChampion:RayHits(aim,rows,anchor,origin)
 if not point(aim)then return 0,false end
 origin=origin or myHero.pos
 local dx,dz=aim.x-origin.x,aim.z-origin.z;local length=math.sqrt(dx*dx+dz*dz)
  if length<1 or length>self.RSpell.Range+.01 then return 0,false end
 dx,dz=dx/length,dz/length;local count,primary=0,false
 for _,row in ipairs(rows)do local x,z=row.pos.x-origin.x,row.pos.z-origin.z;local along=x*dx+z*dz
   if along>=0 and along<=self.RSpell.Range and math.abs(x*dz-z*dx)<=self.RSpell.Radius-self.RSpell.AimErrorWorld then count=count+1;if row.unit==anchor then primary=true end end
 end;return count,primary
end
function SonaChampion:RayClear(aim,anchor,origin)
 origin=origin or myHero.pos
 if not point(aim)or GetDistance(aim,origin)<1 or type(OrbamaPrediction.GetCollision)~='function'then return false end
 -- The whole outgoing beam, including continuation past the selected target,
 -- must use the same ray as the hit-count geometry.
  local endpoint=origin:Extended(aim,self.RSpell.Range)
  local wall,_,count=OrbamaPrediction:GetCollision(origin,endpoint,self.RSpell.Speed,OrbamaPrediction:GetLaunchDelay(self.RSpell),self.RSpell.Radius+self.RSpell.AimErrorWorld,
  {OrbamaPrediction.COLLISION_YASUOWALL},id(anchor))
 return wall==false and finite(count)and count==0
end
-- `origin` (default the player) plans from another position, e.g. a Flash landing.
function SonaChampion:PlanR(anchor,preparedRows,origin)
 origin=origin and point(origin)or myHero.pos
 if not self:Current(anchor)or not point(anchor.pos)or GetDistance(anchor.pos,origin)>1100 then return nil end
 local rows=preparedRows or self:RRows();local candidates={}
 for _,row in ipairs(rows)do local p=row.aim;if GetDistance(p,origin)>1000 then p=origin:Extended(p,1000)end;candidates[#candidates+1]=p end
 for i=1,#rows do for j=i+1,#rows do local p=(rows[i].aim+rows[j].aim)/2;if GetDistance(p,origin)>1000 then p=origin:Extended(p,1000)end;candidates[#candidates+1]=p end end
 local best
 for _,p in ipairs(candidates)do local hits,primary=self:RayHits(p,rows,anchor,origin)
  if primary and(not best or hits>best.count or hits==best.count and GetDistance(p,origin)<GetDistance(best.position,origin))
   and self:RayClear(p,anchor,origin)then best={position=point(p),count=hits}end
 end;return best
end
function SonaChampion:CastR(anchor,context,count,permission,preparedPlan)
 if not self:Ready(_R)or not self:Current(anchor)or(permission and not permission())then return false end
 local handle=anchor.handle;local plan=preparedPlan or self:PlanR(anchor);if not plan or plan.count<count then return false end
 local function resolve()
  if not self:Ready(_R)or anchor.handle~=handle or not self:Current(anchor)or(permission and not permission())then return nil,'r_context_changed'end
  local fresh=self:PlanR(anchor);if not fresh or fresh.count<count then return nil,'r_line_changed'end
  return {position=fresh.position}
 end
  return Core:Cast(HK_R,plan.position,{intentTarget=anchor,context=context,range=self.RSpell.Range,prevalidateWorldCast=true,resolve=resolve,
   directionalWorldCast=self.directionalSupported,directionalAimError=self.RSpell.AimErrorWorld,
  validate=function(q,r)
   if not self:Ready(_R)or anchor.handle~=handle or not self:Current(anchor)or(permission and not permission())then return false end
   local aim=r and r.position or q.target;local hits,primary=self:RayHits(aim,self:RRows(),anchor);return primary and hits>=count and self:RayClear(aim,anchor)
  end})
end
function SonaChampion:AutoR()
 if not Menu.Misc.AutoR:Value()or not self:Ready(_R)then return false end
 local count=Menu.Misc.AutoRCount:Value();local rows=self:RRows()
 if #rows<count then return false end
 local selected=_G.SDK.TargetSelector.Selected
 local function allowed()return Menu.Misc.AutoR:Value()and Menu.Misc.AutoRCount:Value()<=count end
 -- A valid explicit selection owns the anchor. Otherwise search at most five
 -- current recipients, sharing the unchanged prediction rows during preparation.
 for _,row in ipairs(rows)do if row.unit==selected then
  local plan=self:PlanR(selected,rows)
  return plan and plan.count>=count and self:CastR(selected,{priority='interactive'},count,allowed,plan)or false
 end end
 for _,row in ipairs(rows)do local plan=self:PlanR(row.unit,rows)
  if plan and plan.count>=count and self:CastR(row.unit,{priority='interactive'},count,allowed,plan)then return true end
 end
 return false
end
function SonaChampion:Combat(mode)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return false end
 local u=GetTarget(1000);if not IsValid(u)then return false end;local context=Core:ModeContext(mode)
 -- A charged Power Chord belongs on the champion, not on a minion the orbwalker would last-hit first.
 if _G.SDK.Data:IsInAutoAttackRange(myHero,u)and self:State().ready then Core:PreferAttack('Sona.chord',u,.25)end
 if mode=='Combo'and node.R:Value()and self:CastR(u,context,node.RCount:Value(),function()return node.R:Value()and Core.manaAbove(node.Mana:Value())end)then return true end
 if node.Q:Value()and self:ChordAllows(_Q,mode)and self:CastQ(u,context,function()return node.Q:Value()and Core.manaAbove(node.Mana:Value())and self:ChordAllows(_Q,mode)end)then return true end
 if node.E:Value()and self:Reach(u,1000)and not _G.SDK.Data:IsInAutoAttackRange(myHero,u)then
  return self:CastE(context,function()return node.E:Value()and Core.manaAbove(node.Mana:Value())and self:Reach(u,1000)and self:ChordAllows(_E,mode)end)
 end;return false
end
function SonaChampion:Combo()return self:Combat('Combo')end
function SonaChampion:Harass()return self:Combat('Harass')end
function SonaChampion:FarmRows()
 if #self:Enemies(825)>0 then return nil end
 local rows,seen={},{}
 for _,kind in ipairs({'lane','jungle'})do local list=kind=='lane'and _G.SDK.ObjectManager:GetEnemyMinions(825)or _G.SDK.ObjectManager:GetMonsters(825)
  for i=1,math.min(#list,kind=='lane'and 40 or 12)do local u=list[i]
   if not seen[id(u)]and u.team~=myHero.team and self:Reach(u,825)then seen[id(u)]=true;rows[#rows+1]=u end
  end
 end
 table.sort(rows,function(a,b)local da,db=GetDistance(a.pos,myHero.pos),GetDistance(b.pos,myHero.pos);return da<db or da==db and id(a)<id(b)end)
 return rows
end
function SonaChampion:RescueUseful(u)
 -- The shared LastHit rule; this champion's regressions pin the 'ready' attack weighing.
 return Core:Rescue(u,.25+GetDistance(u.pos,myHero.pos)/1300,function()return self:GetQDmg(u)end,readyAttack)
end
function SonaChampion:FarmValid(kind,rescue)
 local rows=self:FarmRows();if not rows or #rows==0 then return nil end
 local n=math.min(#rows,2)
 if rescue and #rows>2 then return nil end -- automatic bolt tie/order uncertainty
 for i=1,#rows do local u=rows[i]
  if(u.team==300)~=(kind=='jungle')or rescue and not self:RescueUseful(u)then return nil end
 end
 if not rescue and kind=='lane'and n<Menu.Clear.LaneClear.Count:Value()then return nil end
 return rows[1]
end
function SonaChampion:Clear(kind)
 if not Menu.Clear.SpellFarm:Value()or not Core:FarmModeEnabled(kind)then return false end
 local node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'];if not node.Q:Value()or not Core.manaAbove(node.Mana:Value())then return false end
 local u=self:FarmValid(kind,false);return u and self:CastQ(u,Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end),function()
  return node.Q:Value()and Core.manaAbove(node.Mana:Value())and self:FarmValid(kind,false)==u end)or false
end
function SonaChampion:LaneClear()return self:Clear('lane')end
function SonaChampion:JungleClear()return self:Clear('jungle')end
function SonaChampion:LastHit()
 local node=Menu.LastHit;if not node.Q:Value()or not Core.manaAbove(node.Mana:Value())then return false end
 local u=self:FarmValid('lane',true);return u and self:CastQ(u,Core:ModeContext('LastHit'),function()
  return node.Q:Value()and Core.manaAbove(node.Mana:Value())and self:FarmValid('lane',true)==u end)or false
end
function SonaChampion:Channel(u,token)
  local a=u.activeSpell;return self:Current(u)and Core:CanInterrupt(u,OrbamaPrediction:GetImpactTime(self.RSpell,u.pos,myHero))
   and a.name==token.name and a.startTime==token.start
end
-- Dangerous channels are stopped without a mode key (Core:CanInterrupt filters them).
function SonaChampion:Interrupt()
 if not Menu.Misc.InterruptR:Value()or not self:Ready(_R)then return false end
 for _,u in ipairs(self:Enemies(1000))do local a=u.activeSpell;local token=a and {name=a.name,start=a.startTime}
  if token and finite(token.start)and token.start<=Game.Timer()and self:Channel(u,token)then
   return self:CastR(u,{priority='interactive'},1,function()return Menu.Misc.InterruptR:Value()and self:Channel(u,token)end)
  end
 end;return false
end
-- Sona-1: peel for an ally (or Sona) with a heal priority below 40% health: the enemy champion dashing onto it,
-- attacking it or in melee reach of it (Core:PeelTarget) is the R anchor; others on the line are a bonus.
function SonaChampion:PeelR()
 if not Menu.Misc.PeelR:Value()or not self:Ready(_R)then return false end
 for _,ally in ipairs(self:Allies())do
  if self:Priority(ally)>0 and finite(ally.health)and finite(ally.maxHealth)and ally.maxHealth>0 and ally.health/ally.maxHealth<=.4 then
   local source=Core:PeelTarget(ally,1)
   if source and self:Reach(source,1000)and Core:SpellProtected(source)==false then
    local handle,sourceID=ally.handle,id(source)
    local function still()
     if not Menu.Misc.PeelR:Value()or ally.handle~=handle or not IsValid(ally)or ally.health/ally.maxHealth>.4 then return false end
     local now=Core:PeelTarget(ally,1);return now~=nil and id(now)==sourceID
    end
    if self:CastR(source,{priority='interactive'},1,still)then return true end
   end
  end
 end
 return false
end
-- Sona-3: Q goes to the two nearest visible enemy champions in 825 (its own targeting); it finishes one of them
-- when Core:Lethal holds at the bolt's arrival. R finishes a champion on a planned line (cast 0.25 s, 2400).
function SonaChampion:QRecipients()
 local list=self:Enemies(825)
 table.sort(list,function(a,b)local da,db=GetDistance(a.pos,myHero.pos),GetDistance(b.pos,myHero.pos);return da<db or da==db and id(a)<id(b)end)
 return {list[1],list[2]}
end
function SonaChampion:QKills(u)
 local recipients=self:QRecipients()
 if recipients[1]~=u and recipients[2]~=u then return false end
 return Core:Lethal(u,GetDistance(u.pos,myHero.pos)/1300,function()return self:GetQDmg(u)end,{kind='magical'})==true
end
function SonaChampion:RKills(u)
 return self:Reach(u,1000)and Core:Lethal(u,.25+GetDistance(u.pos,myHero.pos)/2400,function()return self:GetRDmg(u)end,{kind='magical'})==true
end
function SonaChampion:KillSteal()
 if Menu.Misc.KillQ:Value()and self:Ready(_Q)then
  for _,u in ipairs(self:QRecipients())do
   if self:QKills(u)and self:CastQ(u,{priority='interactive'},function()return Menu.Misc.KillQ:Value()and self:QKills(u)end)then return true end
  end
 end
 if Menu.Misc.KillR:Value()and self:Ready(_R)then
  for _,u in ipairs(self:Enemies(1000))do
   if self:RKills(u)and self:CastR(u,{priority='interactive'},1,function()return Menu.Misc.KillR:Value()and self:RKills(u)end)then return true end
  end
 end
 return false
end
-- Sona-6: Flash then R when the plain R misses the Combo count and an R planned from a Flash landing (toward each
-- predicted champion, Flash range) reaches it with the combo target on the line. Off by default; the R follows
-- only once the Flash is observed and is planned again from where Sona stands.
function SonaChampion:FlashR()
 local combo=self.flashCombo;local node=Menu.Combo
 if not combo or combo:Busy()or not node.FlashR:Value()or not node.R:Value()or not self:Ready(_R)or not Core.manaAbove(node.Mana:Value())then return false end
 local status=Core:FlashStatus();if not status then return false end
 local rCost=myHero:GetSpellData(_R).mana;if not finite(rCost)or myHero.mana<status.cost+rCost then return false end
 local need=node.RCount:Value();local rows=self:RRows(status.range);if #rows<need then return false end
 local anchor=GetTarget(1000+status.range);if not IsValid(anchor)or Core:SpellProtected(anchor)~=false then return false end
 local here=self:PlanR(anchor);if here and here.count>=need then return false end
 local best
 for i=1,math.min(#rows,5)do local row=rows[i]
  local landing=point(myHero.pos:Extended(row.pos,math.min(status.range,GetDistance(row.pos,myHero.pos))))
  if landing and GetDistance(landing,myHero.pos)>=100 and not IsUnderTurret2(landing)then
   local plan=self:PlanR(anchor,rows,landing)
   if plan and plan.count>=need and(not best or plan.count>best.count)then best={landing=landing,count=plan.count}end
  end
 end
 if not best then return false end
 local handle=anchor.handle
 local function authorized()return node.FlashR:Value()and node.R:Value()and GetMode()=='Combo'end
 local function valid(pos)
  if not self:Ready(_R)or anchor.handle~=handle or IsUnderTurret2(pos)then return false end
  local plan=self:PlanR(anchor,self:RRows(status.range),pos);return plan~=nil and plan.count>=need
 end
 return combo:Start{order='flash_first',aim=best.landing,authorized=authorized,valid=valid,mana=rCost,
  follow=function(context)return self:CastR(anchor,context,need,authorized)end}
end
function SonaChampion:Assist()
 if Menu.Misc.RAssist:Value()and self:Ready(_R)then local u=GetTarget(1100);if IsValid(u)then
  return self:CastR(u,Core:HeldContext(function()return Menu.Misc.RAssist:Value()end),1,function()return Menu.Misc.RAssist:Value()end)
 end end
 return false
end
-- Song of Celerity's own speed offered to Evade (S6 haste): profile numbers only; no offer while the haste runs.
function SonaChampion:RegisterHaste()
 local p=self.profile;if not Core.RegisterEffect or type(p.eHaste)~='table'or not finite(p.eHasteDuration)or type(p.eHasteSource)~='string'then return false end
 self.hasteOffered,self.hasteReason=Core:RegisterEffect({kind='haste',name='Sona.E',slot=_E,key=HK_E,profile=p.id,spell=p.e,source=p.eHasteSource,
  delay=0,duration=p.eHasteDuration,percent=function()local d=myHero:GetSpellData(_E);return d and p.eHaste[d.level]end,
  ready=function()return not self:Buff(p.eHasteBuff)end})
 return self.hasteOffered
end
function SonaChampion:Flee()return Menu.Misc.FleeE:Value()and self:CastE(Core:ModeContext('Flee'),function()return Menu.Misc.FleeE:Value()end,true)or false end
function SonaChampion:PreparePreview()
 -- R hit count only: the game shows the aura, Power Chord and Accelerando. Kept for a second so a late
 -- preparation never blinks it; Draw shows it only while R is ready.
 local anchor=GetTarget(1100);local plan=IsValid(anchor)and self:Ready(_R)and self:PlanR(anchor)
 self.preview={count=plan and plan.count or 0,position=plan and plan.position,expires=Game.Timer()+1}
end
function SonaChampion:Tick()
 if ShouldWait()or not Core:Available()then self.preview=nil;return end
 if Game.Timer()>=(self.nextAllies or 0)then self:DiscoverAllies()end
 if self.previewFallback and Menu.Draw.Preview:Value()and Game.Timer()>=(self.nextPreview or 0)then self:PreparePreview();self.nextPreview=Game.Timer()+.1 end
 if self.flashCombo:Busy()and self.flashCombo:Maintain()then return end
 if IsCasting()then return end
 if self:AutoW()or self:SpeedAlly()or self:Assist()or self:Interrupt()or self:PeelR()or self:KillSteal()or self:AutoR()then return end
 local mode=GetMode();if mode=='Combo'then if not self:FlashR()then self:Combo()end elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')and self:LaneClear()then return end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function SonaChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.Ranges:Value()then
  if IsReady(_Q)then Draw.Circle(myHero.pos,825,1,Draw.Color(255,100,200,255))end
  if IsReady(_W)or IsReady(_R)then Draw.Circle(myHero.pos,1000,1,Draw.Color(255,100,200,255))end
  Draw.Circle(myHero.pos,self.profile.auraRange,1,Draw.Color(120,100,200,255))
 end
 local p=self.preview;if Menu.Draw.Preview:Value()and p and p.expires>Game.Timer()and p.count>0 and IsReady(_R)then
  Draw.Text('R hits '..p.count,16,myHero.pos2D.x,myHero.pos2D.y+50,Draw.Color(255,255,200,100))
 end
end
function SonaChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Sona: assistance','Sona: profiles'},function(page)
  return {title=page==1 and 'Sona assistance'or 'Aura and Power Chord',cards=page==1 and {
   {'MODES','Provider binds choose Combo/Harass, separate lane and jungle farming, LastHit and Flee. Q is a self cast with automatic recipients.'},
    {'PROTECTION','Ally priorities decide when to request W; the game chooses its heal recipient. Normal W also shields an ally in the aura against an attack, targeted spell or skillshot of an enemy champion that is about to land (minion and turret damage do not trigger it), and Evade may use it for you. A charged Power Chord attack is aimed at the champion in reach. A stunned or rooted ally is healed from 80% health, and E speeds up an ally caught by crowd control or under attack. W and E are self casts.'},
    {'ASSIST','The selected-target bind casts an R line through that target. Combo, interrupt, ally peel, finishing and automatic multi-target R each have their own switch. Automatic R counts current unprotected predicted recipients and rechecks its outgoing wall ray using common geometry and launch timing. Visible off-screen R uses capability-gated directional aim.'}}or {
   {'CHORD','Choose which prepared chord to preserve in Combo/Harass. A queued spell or key does not create stacks or an effect. Urgent healing and escape may change the prepared effect.'},
   {'PROFILES','Normal uses short buff auras, healing and shields. Classic uses its own AD/AP and AR/MR auras and heal coefficients. Copied Accelerando metadata never activates a Classic mechanic.'},
   {'FARM','Ability farming follows the farm toggle (off by default). LastHit Q requires every possible automatic recipient to need rescue and rejects unknown shield forecasts, incoming lethal hits and crowded waves.'}}}
 end)
end
Core:RegisterPolicy({damageTypes={Q='magical',R='magical'},methods={Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
 LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end,
 PeelR=function()return {priority='interactive'}end,KillSteal=function()return {priority='interactive'}end,Interrupt=function()return {priority='interactive'}end},channel=function()return not Core:SelfChanneling()end,
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot)end;return true end})
SonaChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Sona"]="Sona"}
local normalSupported={["Sona"]=true}

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
