return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Seraphine"]=function()return _G.OrbamaFamily:Require("26f5bfb7c91ccd0160ba59e828627e818f0ae8147052ecfb3d0ccd0a329dd284")()end
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
if champion=="Seraphine" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Seraphine',profiles={normal=true,classic=false},
 Create=function(context)
-- Independently implemented Normal profile; seraphine-provenance.json.
local profile=ChampionProfiles('Seraphine')[myHero.charName]
local casts={SeraphineQ={SeraphineQ=true,SeraphineQCast=true,SeraphineQCastEcho=true},SeraphineW={SeraphineW=true,SeraphineWCast=true,SeraphineWCastEcho=true},
 SeraphineE={SeraphineE=true,SeraphineECast=true,SeraphineECastEcho=true},SeraphineR={SeraphineR=true}}
local finite,id,point,ends,ours=Core.finite,Core.id,Core.point,Core.buffExpiry,Core.mine
local function source(b)local a,c=b.source,b.sourcenID;return(ours(a)or ours(c))and(not a or a==0 or ours(a))and(not c or c==0 or ours(c))end
local function cleanup(self)self.chain=nil;self.echoWait=nil;self.lastAttack=nil;self.lastNative=nil;self.observedEcho=nil;self.rObservation=nil;self.sample=nil;self.farmIndex={}end
local SeraphineChampion=class("SeraphineChampion")
function SeraphineChampion:__init()
 assert(myHero.charName=='Seraphine','No verified Classic Seraphine kit');self.profile=profile;self.allies={};self.farmIndex={}
  self.QSpell=AbilityProfiles.Spell(myHero.charName,'Q',OrbamaPrediction)
  self.ESpell=AbilityProfiles.Spell(myHero.charName,'E',OrbamaPrediction)
  self.RSpell=AbilityProfiles.Spell(myHero.charName,'R',OrbamaPrediction)
  for _,spell in ipairs({self.QSpell,self.ESpell,self.RSpell})do spell.Collision=true;spell.CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}end
  self.directionalSupported=Core.adapter:Capabilities().directionalWorldCast==true
  self.WImpact=AbilityProfiles.Spell(myHero.charName,'W',OrbamaPrediction)
 self:LoadMenu();self:Discover();Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function()local witness=Core:AttackWitness(self.lastAttack);if witness then self.lastAttack=witness end end)
 _G.SDK.Orbwalker:OnPreAttack(function(args)self:OnPreAttack(args)end)
 Core:RegisterCleanup('Seraphine',function()cleanup(self)end)
 self:RegisterDefense()
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
end
function SeraphineChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_Seraphine',name='AyyyyIO - Seraphine'})
 for _,mode in ipairs({'Combo','Harass'})do Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q',value=true});Menu[mode]:MenuElement({id='E',name='Use E',value=true})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Combo'and 0 or 40,min=0,max=100,step=5})
 end
 -- Seraphine-9: the minion switch belongs to Harass. A value saved at its old place (Shield and heal) is read once.
 do local spec={id='Minions',name='Attack minions in Harass',value=false};local m=_G.SDK and _G.SDK.MenuMigration
  if m and type(m.Apply)=='function'then for _,old in ipairs({'Support.HarassMinions','Automation.Support.HarassMinions'})do pcall(m.Apply,m,spec,'Classic_AIO_Seraphine',old,old)end end
  Menu.Harass:MenuElement(spec)
 end
 Menu.Combo:MenuElement({id='R',name='Use R',value=true});Menu.Combo:MenuElement({id='Count',name='R only when it hits enemies',value=2,min=1,max=5,step=1})
 Menu:MenuElement({type=MENU,id='Passive',name='Passive (Echo and notes)'})
 -- The doubled cast (Echo) is always kept for E: a doubled E roots, and a root is what makes Q and R land.
 Menu.Passive:MenuElement({id='Notes',name='Attack first when passive notes are ready',value=true,menu=false})
 Menu:MenuElement({type=MENU,id='Support',name='Shield and heal (W)'})
 Menu.Support:MenuElement({id='HP',name='Heal when missing health % is at least',value=25,min=5,max=90,step=5})
 Menu.Support:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 Menu.Support:MenuElement({type=MENU,id='Allies',name='Ally priority for W (0: never)'})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[mode]:MenuElement({id='Q',name='Use Q',value=true});Menu.Clear[mode]:MenuElement({id='E',name='Use E',value=true})
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions Q must hit',value=2,min=1,max=10,step=1,menu=false})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q',value=true});Menu.LastHit:MenuElement({id='E',name='Use E',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='R',name='Cast R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='FleeW',name='Use W for speed when fleeing',value=true});Menu.Misc:MenuElement({id='FleeE',name='Use E on a chaser when fleeing',value=true})
 Menu.Misc:MenuElement({id='FleeR',name='Use R on a chaser when fleeing',value=false})
 Menu.Misc:MenuElement({id='Interrupt',name='Use R to stop dangerous channels',value=true})
 Menu:MenuElement({type=MENU,id='Auto',name='Automatic Q and E (no mode key)'})
 -- Q and E on immobilised enemies and as finishers are fixed behaviour: a certain hit or kill is always taken.
 Menu.Auto:MenuElement({id='AntiDash',name='Use E on enemies that dash at you',value=true})
 Menu.Auto:MenuElement({id='Mana',name='Those casts only above mana % (finishers exempt)',value=30,min=0,max=100,step=5})
 Menu.Auto:MenuElement({id='EOnlyControl',name='Combo E only on enemies that cannot dodge',value=false,menu=false})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'});Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
end
function SeraphineChampion:Ready(slot)
 local d=myHero:GetSpellData(slot);local name=({[0]=profile.q,[1]=profile.w,[2]=profile.e,[3]=profile.r})[slot]
 return d and d.name==name and finite(d.level)and d.level%1==0 and d.level>=1 and d.level<=(slot==_R and 3 or 5)
  and finite(d.currentCd)and d.currentCd==0 and Game.CanUseSpell(slot)==0 and finite(d.mana)and d.mana>=0 and d.mana<=myHero.mana or false
end
function SeraphineChampion:Rows(kind,range)
 local rows,seen={},{};local list=Core:DecisionUnits(kind=='ally'and'GetAllyHeroes'or kind=='enemy'and'GetEnemyHeroes'or kind=='jungle'and'GetMonsters'or'GetEnemyMinions')
 local function add(u)if id(u)and not seen[id(u)]and IsValid(u)and point(u.pos)and GetDistance(u.pos,myHero.pos)<=range
  and(kind~='lane'or u.team~=300 and u.team~=myHero.team)and(kind~='jungle'or u.team==300)then seen[id(u)]=true;rows[#rows+1]=u end end
 if kind=='ally'then add(myHero)end
 -- The SDK list is map-wide and unordered; bound accepted rows, not the scan, so nearby units are not skipped.
 local cap=kind=='lane'and 40 or kind=='jungle'and 16 or 5
 for i=1,math.min(#list,512)do if #rows>=cap then break end;add(list[i])end;return rows
end
function SeraphineChampion:Current(u)
 if not IsValid(u)or not point(u.pos)then return false end;if u==myHero then return true end
 local kind=u.type==Obj_AI_Hero and(u.team==myHero.team and'ally'or'enemy')or(u.team==300 and'jungle'or'lane')
 for _,v in ipairs(self:Rows(kind,5000))do if v==u and id(v)==id(u)and v.handle==u.handle then return true end end;return false
end
function SeraphineChampion:Discover()
 for _,u in ipairs(self:Rows('ally',5000))do local row=self.allies[id(u)]
  -- One priority per ally (0: never protect); it replaces the former per-ally submenu (switch and priority).
  if not row then local key=StableUnitMenuKey(self,'A',u)
   Menu.Support.Allies:MenuElement({id=key..'P',name=u.charName,value=3,min=0,max=5,step=1,from='Automation.Support.Allies.'..key..'.Priority'})
   row={node=Menu.Support.Allies[key..'P']};self.allies[id(u)]=row
  end;row.handle=u.handle
 end;self.nextDiscovery=Game.Timer()+1
end
function SeraphineChampion:AllyAllowed(u)local row=self.allies[id(u)];return row and row.handle==u.handle and row.node:Value()>0 end
function SeraphineChampion:Buff(u,name,owned)
 if not u or not finite(u.buffCount)or u.buffCount%1~=0 or u.buffCount<0 or u.buffCount>128 then return nil end;local found
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==name:lower()and finite(b.count)and b.count>0 and finite(ends(b))and ends(b)>Game.Timer()and(not owned or source(b))then
   if found then return nil end;found=b
  end
 end;return found
end
function SeraphineChampion:Echo()
 local a,b=self:Buff(myHero,'SeraphinePassiveEchoStage1',true),self:Buff(myHero,'SeraphinePassiveEchoStage2',true)
 if a and b then return {known=false,stage=0}end;return {known=a~=nil or b~=nil,stage=b and 2 or a and 1 or 0,expires=ends(b or a)}
end
function SeraphineChampion:Notes(u)
 local b=self:Buff(u,'SeraphinePassiveNotesBuff',true)or self:Buff(u,'SeraphinePassiveNotes',true)
 return b and b.count%1==0 and b.count<=4 and b.count or nil
end
function SeraphineChampion:ObserveNative()
 if self.rObservation and self.rObservation.q.observedAt then
  for _,u in ipairs(self:Rows('enemy',5000))do local b=self:Buff(u,'SeraphineR',true)
   if b and finite(b.startTime)and finite(self.rObservation.q.nativeCastStart)and b.startTime>=self.rObservation.q.nativeCastStart
    and b.startTime<=Game.Timer()and not self.rObservation.hits[id(u)]then
    self.rObservation.hits[id(u)]={handle=u.handle,ends=ends(b),distance=self.rObservation.origin and GetDistance(u.pos,self.rObservation.origin)}end
  end
 end
 local a=myHero.activeSpell
 if not(a and a.valid and not a.isStopped and type(a.name)=='string'and finite(a.startTime)and a.startTime<=Game.Timer()and a.startTime>=Game.Timer()-2)then return end
 local token=a.name..':'..tostring(a.startTime);if token==self.lastNative then return end;self.lastNative=token
 if a.name=='SeraphineQCastEcho'or a.name=='SeraphineECastEcho'or a.name=='SeraphineWCastEcho'then self.observedEcho={spell=a.name,at=a.startTime}end
end
function SeraphineChampion:Native(q,u)
 local a=myHero.activeSpell;if not(a and casts[q.spellName]and casts[q.spellName][a.name])then return false end
 local cast=Core:NativeCast(q,a.name);if cast then q.nativeCastStart=cast.startTime;self:StartSample(u,a.name);return true end;return false
end
-- Dev-recorder evidence for numbers the wiki leaves open (Seraphine-1/3/6): the target's health before an
-- observed own Q/E and 1.2 s later (the missing-health curve, and two drops for an echoed cast), and R's
-- accepted cast distance with the distance of every charmed champion. Traces only; no decision reads them.
function SeraphineChampion:StartSample(u,name)
 if self.sample or not(name:find('SeraphineQ',1,true)or name:find('SeraphineE',1,true))or not u or u==myHero
  or u.type~=Obj_AI_Hero and u.team~=300 or not finite(u.health)or not finite(u.maxHealth)then return end
 local slot=name:find('SeraphineQ',1,true)and _Q or _E
 self.sample={unit=u,handle=u.handle,spell=name,health=u.health,maxHealth=u.maxHealth,
  expected=self:Damage(u,slot,true),at=Game.Timer(),drops={}}
end
function SeraphineChampion:Sample()
 local s=self.sample;if not s then return end;local u=s.unit
 if u.handle~=s.handle or not finite(u.health)then self.sample=nil;return end
 if u.health<(s.last or s.health)-1 and #s.drops<4 then s.drops[#s.drops+1]={at=Game.Timer()-s.at,health=u.health}end;s.last=u.health
 if Game.Timer()-s.at>=1.2 then
  Core:Trace('seraphine_damage_sample',{spell=s.spell,health=s.health,maxHealth=s.maxHealth,missing=1-s.health/s.maxHealth,expected=s.expected,drops=s.drops})
  self.sample=nil
 end
end
function SeraphineChampion:TraceR()
 local o=self.rObservation;if not o or not o.q or not o.q.observedAt or not o.origin or not point(o.aim)then return end
 local hits={};for _,h in pairs(o.hits)do hits[#hits+1]=h.distance end
 Core:Trace('seraphine_r_reach',{aim=GetDistance(o.aim,o.origin),hits=hits})
end
function SeraphineChampion:PredictPoint(u,time,freshRow)
 if not(freshRow and IsValid(u)and point(u.pos)or not freshRow and self:Current(u))or not finite(time)or time<0 or time>4 then return nil end;local p=u.pathing
 if not p or not p.hasMovePath and not p.isDashing then return point(u.pos)end
 local speed=p.isDashing and p.dashSpeed or u.ms
 if not point(p.endPos)or not finite(speed)or speed<=0 then return nil end
 return u.pos:Extended(p.endPos,math.min(GetDistance(u.pos,p.endPos),speed*time))
end
function SeraphineChampion:ControlTier(u,time)
 if not self:Current(u)or not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 or u.buffCount%1~=0 then return 0 end
 local slow,immobile=false,false
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and finite(b.count)and b.count>0 and finite(ends(b))and ends(b)>Game.Timer()+time then
   if b.type==11 or type(b.name)=='string'and b.name:lower()=='seraphineeslow'then slow=true end
   if b.type==5 or b.type==12 or b.type==22 or b.type==23 or b.type==25 or b.type==30 or b.type==35 then immobile=true end
  end
 end;return immobile and 3 or slow and 2 or 1
end
function SeraphineChampion:Damage(u,slot,lower)
 local d=myHero:GetSpellData(slot);local base=slot==_Q and profile.qBase[d.level]or slot==_E and profile.eBase[d.level]or slot==_R and profile.rBase[d.level]
  if not base or not finite(myHero.ap)then return 0 end;local raw=base+(slot==_Q and profile.qAP or slot==_E and profile.eAP or profile.rAP)*myHero.ap
  if slot==_E and u.type~=Obj_AI_Hero and u.team~=300 then raw=raw*profile.eMinion end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
function SeraphineChampion:Plan(slot,u)
 local spell=slot==_Q and self.QSpell or self.ESpell
 if not self:Ready(slot)or not self:Current(u)or u.team==myHero.team or GetDistance(u.pos,myHero.pos)>spell.Range then return nil end
 local pred=Core:Prediction(spell);pred:GetPrediction(u,myHero)
 if not pred:CanHit(2)or not point(pred.CastPosition)or GetDistance(pred.CastPosition,myHero.pos)>spell.Range then return nil end
  local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,pred.CastPosition,spell.Speed,OrbamaPrediction:GetLaunchDelay(spell),spell.Radius+(spell.AimErrorWorld or 0),spell.CollisionTypes,id(u))
 if wall~=false or not finite(count)or count~=0 then return nil end
  local impact=OrbamaPrediction:GetImpactTime(spell,pred.CastPosition,myHero);local echo=self:Echo()
 return {position=point(pred.CastPosition),data={impact=impact,echo=echo.known and echo.stage==2,tier=slot==_E and self:ControlTier(u,impact)or 0}}
end
function SeraphineChampion:CastSpell(slot,u,context,permission,requireEcho,geometry,allowChain)
 if permission and not permission()then return false end;local plan=self:Plan(slot,u);if not plan or requireEcho and not plan.data.echo or geometry and not geometry(plan)then return false end;local handle=u.handle
 local spell=slot==_Q and self.QSpell or self.ESpell;local key=slot==_Q and HK_Q or HK_E
  local ok=Core:Cast(key,plan.position,{context=context,intentTarget=u,range=spell.Range,prevalidateWorldCast=true,deferAttackWindup=true,
   directionalWorldCast=spell.DirectionalCast and self.directionalSupported,directionalAimError=spell.AimErrorWorld,
  observe=function(q)return self:Native(q,u)end,
  resolve=function()if u.handle~=handle or permission and not permission()then return nil,'context_changed'end
   local fresh=self:Plan(slot,u);if requireEcho and(not fresh or not fresh.data.echo)then return nil,'echo_consumed'end
   if fresh and geometry and not geometry(fresh)then return nil,'farming_geometry_changed'end;return fresh end,
  validate=function(q,r)
   if not(self:Ready(slot)and self:Current(u)and u.handle==handle and r and r.data and point(r.position)and(not permission or permission())and(not geometry or geometry(r)))then return false end
   local echo=self:Echo();if requireEcho and not(echo.known and echo.stage==2)then return false end
    local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,r.position,spell.Speed,OrbamaPrediction:GetLaunchDelay(spell),spell.Radius+(spell.AimErrorWorld or 0),spell.CollisionTypes,id(u))
   return wall==false and finite(count)and count==0 and GetDistance(u.pos,myHero.pos)<=spell.Range
    and(slot~=_E or r.data.tier==self:ControlTier(u,r.data.impact))
  end})
  if ok and slot==_E and allowChain~=false then self.chain={q=Core.lastIntent,target=u,handle=handle,context=context,expires=Game.Timer()+math.min(2,plan.data.impact+1),impact=plan.data.impact,permission=permission,finisher=allowChain=='finisher'}end
 return ok
end
function SeraphineChampion:ContinueChain()
   local row=self.chain;if not row then return false end;local q=row.q;local state=Core:ContinuationState(q,row.expires)
   if not state
  or not self:Current(row.target)or row.target.handle~=row.handle or row.permission and not row.permission()then self.chain=nil;return false end
  if state~='observed'then return true end
 -- Casting E is not observing its control effect. Q follows only a current
  -- own E slow lasting through impact, or root/stun whose remaining movement
  -- footprint fits the common outgoing Q window.
 local mode=GetMode();local node=mode=='Combo'and Menu.Combo or mode=='Harass'and Menu.Harass
  -- The finisher chain (Seraphine-1) belongs to no mode: its Q is wanted only while it kills on its own.
  if row.finisher then node={Q={Value=function()return true end},Mana={Value=function()return 0 end}}end
  if not node or not node.Q:Value()or not Core.manaAbove(node.Mana:Value())or GetDistance(row.target.pos,myHero.pos)>self.QSpell.Range then self.chain=nil;return false end
  if not self:Ready(_Q)then return true end
  local eligible=false;local earliest=OrbamaPrediction:GetImpactTime(self.QSpell,row.target.pos,myHero)
 for _,name in ipairs({'SeraphineESlow','SeraphineERoot','SeraphineEStun'})do local b=self:Buff(row.target,name,true)
   if b and(ends(b)>Game.Timer()+earliest or name~='SeraphineESlow'and Core:ControlledHit(row.target,self.QSpell,row.target.pos))then eligible=true;break end
 end
 -- The chain keeps the rest of Combo back while it waits for E's control. Once
 -- the observed E has had its full time to impact and no control is on the
 -- target, it missed: the chain ends there instead of at its fixed expiry.
 if not eligible then row.observedAt=row.observedAt or Game.Timer()
  if Game.Timer()-row.observedAt>row.impact+.3 then self.chain=nil;return false end
  return true
 end
 local plan=self:Plan(_Q,row.target)
 if plan then for _,name in ipairs({'SeraphineESlow','SeraphineERoot','SeraphineEStun'})do local b=self:Buff(row.target,name,true)
   if b and(ends(b)>Game.Timer()+plan.data.impact or name~='SeraphineESlow'and Core:ControlledHit(row.target,self.QSpell,plan.position))then
    if row.finisher and not self:Finisher(row.target,_Q,plan.position)then self.chain=nil;return false end
    local context=row.finisher and {priority='interactive'}or Core:ModeContext(mode,function()return q.continue()and Game.Timer()<=row.expires and(not row.permission or row.permission())end)
    if node and node.Q:Value()and Core.manaAbove(node.Mana:Value())and self:CastSpell(_Q,row.target,context,function()
     return node.Q:Value()and Core.manaAbove(node.Mana:Value())and q.continue()and Game.Timer()<=row.expires
    end,nil,function(fresh)
     for _,alias in ipairs({'SeraphineESlow','SeraphineERoot','SeraphineEStun'})do local own=self:Buff(row.target,alias,true)
      if own and(ends(own)>Game.Timer()+fresh.data.impact or alias~='SeraphineESlow'and Core:ControlledHit(row.target,self.QSpell,fresh.position))then return not row.finisher or self:Finisher(row.target,_Q,fresh.position)end
     end
     return false
    end)then self.chain=nil;return true end
  end
 end end
 return true
end
function SeraphineChampion:ShieldValue()local d=myHero:GetSpellData(_W);return profile.shield[d.level]and finite(myHero.ap)and(profile.shield[d.level]+profile.shieldAP*myHero.ap)or 0 end
-- Evade may use W as a timed self-shield through the shared offer; it judges the danger, so there is no mana
-- limit or switch here. Amount, duration and source are the profile's figures.
function SeraphineChampion:RegisterDefense()
 if not Core.RegisterShield then return false end
 local function capacityKnown()
  if not finite(myHero.buffCount)or myHero.buffCount%1~=0 or myHero.buffCount<0 or myHero.buffCount>128 then return false end
  -- Unclassified active buffs could reduce shielding. This limits only the
  -- capacity forecast, not ordinary W assistance or native Echo decisions.
  for i=0,myHero.buffCount do local b=myHero:GetBuff(i)
   if b and(not finite(b.count)or b.count<0 or b.count>0 and(not finite(ends(b))or ends(b)>Game.Timer()))then return false end
  end;return true
 end
 local ok,why,adapter=Core:RegisterShield({name='Seraphine.W',slot=_W,key=HK_W,profile=profile.id,spell=profile.w,source=profile.shieldSource,
  amount=function()return self:ShieldValue()end,duration=profile.shieldDuration,delay=self.WImpact.Delay,kind='self',
  -- The capability is read again at dispatch as well: a consumer that withdrew it gets no cast.
  ready=function()
   local evade=_G.SDK.Evade;local caps=evade and evade.GetCapabilities and evade:GetCapabilities()
   return caps~=nil and caps.timedShields==true and capacityKnown()and self:Ready(_W)
  end})
 self.defense=adapter;return ok,why
end
function SeraphineChampion:HealPossible()
 local echo=self:Echo();return echo.known and echo.stage==2 or finite(myHero.shieldAD)and finite(myHero.shieldAP)and(myHero.shieldAD>0 or myHero.shieldAP>0)
end
-- What is about to hit `u`: the shared evidence (a champion's attack or targeted cast on the way, an enemy turret
-- targeting it, a tracked skillshot it stands in). The shield must be up before the hit, so a threat that lands
-- sooner than W's own cast is left out; a turret keeps shooting, so that one always counts.
function SeraphineChampion:Threat(u)
 local threat=Core:AllyThreat(u,2.5)
 if threat and(threat.kind=='turret'or threat.impactIn>=OrbamaPrediction:GetLaunchDelay(self.WImpact)+.05)then return threat,threat.impactIn end
end
-- Seraphine-4: an ally at 30% health or less that a visible enemy champion reaches within the shield's
-- 2.5 s (attack range and both radii plus one second of movement, or a dash landing in attack range) gets
-- W before a hit is seen; burst can land before any evidence. W: shield 2.5 s, CD 22 (wiki 2026-10-10).
function SeraphineChampion:Peril(u)
 for _,e in ipairs(self:Rows('enemy',2200))do
  local reach=(finite(e.range)and e.range or 0)+(e.boundingRadius or 65)+(u.boundingRadius or 65)
  if GetDistance(e.pos,u.pos)<=reach+(finite(e.ms)and e.ms or 0)or Core:ApproachingDash(e,u.pos,reach)then return e end
 end
end
function SeraphineChampion:WUseful(u,manual)
  if not self:Current(u)or u.team~=myHero.team or not self:AllyAllowed(u)or not finite(u.health)or not finite(u.maxHealth)or u.maxHealth<=0 or GetDistance(u.pos,myHero.pos)>self.WImpact.Radius then return nil end
 local future=self:PredictPoint(u,.25);if not future or GetDistance(future,myHero.pos)>780 then return nil end
 if manual then return {kind='manual'}end
 do local token,impact=self:Threat(u)
  if token and not self:Buff(u,'SeraphineWShield',true)then return {kind='shield',token=token,impact=impact}end
 end
 if u.health/u.maxHealth<=.3 and not self:Buff(u,'SeraphineWShield',true)and self:Peril(u)then return {kind='peril'}end
 if self:HealPossible()and finite(u.maxHealth)and u.maxHealth>0 and(1-u.health/u.maxHealth)*100>=Menu.Support.HP:Value()then
  local healed,caster=self:PredictPoint(u,2.75),self:PredictPoint(myHero,2.75);if healed and caster and GetDistance(healed,caster)<=780 then return {kind='heal'}end
 end;return nil
end
function SeraphineChampion:W(u,context,permission,manual)
 if not self:Ready(_W)or not Core.manaAbove(Menu.Support.Mana:Value())or permission and not permission()then return false end
 local useful=self:WUseful(u,manual);if not useful then return false end;local handle=u.handle
 return Core:Cast(HK_W,nil,{context=context,intentTarget=u,observe=function(q)return self:Native(q)end,
  validate=function(q)
   if not(self:Ready(_W)and Core.manaAbove(Menu.Support.Mana:Value())and u.handle==handle and(not permission or permission()))then return false end
   local fresh=self:WUseful(u,manual);return fresh and fresh.kind==useful.kind and(useful.kind~='shield'or useful.token.valid())
  end})
end
function SeraphineChampion:AutoW(context,manual)
 if not self:Ready(_W)or not Core.manaAbove(Menu.Support.Mana:Value())then return false end
 local best,score
 for _,u in ipairs(self:Rows('ally',800))do local useful=self:WUseful(u,manual)
  if useful then local value=self.allies[id(u)].node:Value()*1000+(useful.kind=='shield'and 500 or useful.kind=='peril'and 250 or 0)+(1-u.health/u.maxHealth)*100
   if not best or value>score then best,score=u,value end
  end
 end
 return best and self:W(best,context,nil,manual)or false
end
function SeraphineChampion:Relay(position,target)
 local origin=point(myHero.pos);if not origin or not point(position)then return nil end;local distance=GetDistance(position,origin)
  if distance<10 or distance>self.RSpell.Range then return nil end;local direction=(position-origin)/distance;local rows,seen={},{}
  local launch=OrbamaPrediction:GetLaunchDelay(self.RSpell);local segment=AbilityProfiles.geometry[myHero.charName].R.range
  for _,kind in ipairs({'ally','enemy'})do for _,u in ipairs(self:Rows(kind,self.RSpell.Range))do if u~=myHero and not seen[id(u)]then
  seen[id(u)]=true;local offset=u.pos-origin;local along=offset.x*direction.x+offset.z*direction.z
   if along>0 then local p=self:PredictPoint(u,launch+along/self.RSpell.Speed,true)
    if p then along=(p.x-origin.x)*direction.x+(p.z-origin.z)*direction.z;p=self:PredictPoint(u,launch+math.max(0,along)/self.RSpell.Speed,true)
    if p then along=(p.x-origin.x)*direction.x+(p.z-origin.z)*direction.z;local projected=origin+direction*along
      if along>0 and along<=self.RSpell.Range and GetDistance(projected,p)<=self.RSpell.Radius-(self.RSpell.AimErrorWorld or 0)then rows[#rows+1]={unit=u,handle=u.handle,along=along,position=p,
       -- Seraphine-7: an untargetable or spell-shielded enemy neither takes the hit nor extends the range.
       blocked=u.team~=myHero.team and(u.isTargetable==false or Core:SpellProtected(u)~=false)}end
    end
   end
  end
 end end end
 table.sort(rows,function(a,b)return a.along<b.along end)
  local reach,hits,found,relays=segment,0,false,{}
  for _,row in ipairs(rows)do if row.along>reach then break end
   if not row.blocked then reach=row.along+segment;relays[#relays+1]=row;if row.unit.team~=myHero.team then hits=hits+1 end;if row.unit==target then found=true end end
  end
 return found and {count=hits,reach=reach,relays=relays}or nil
end
function SeraphineChampion:RPlan(u)
 if not self:Ready(_R)or not self:Current(u)or u.team==myHero.team or GetDistance(u.pos,myHero.pos)>3600 then return nil end
 local pred=Core:Prediction(self.RSpell);pred:GetPrediction(u,myHero);if not pred:CanHit(2)or not point(pred.CastPosition)then return nil end
 local relay=self:Relay(pred.CastPosition,u);if not relay then return nil end
  local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,pred.CastPosition,self.RSpell.Speed,OrbamaPrediction:GetLaunchDelay(self.RSpell),self.RSpell.Radius+(self.RSpell.AimErrorWorld or 0),self.RSpell.CollisionTypes,id(u))
 return wall==false and finite(count)and count==0 and{position=point(pred.CastPosition),data=relay}or nil
end
function SeraphineChampion:R(u,context,permission,minimum)
 if not permission or not permission()then return false end;local plan=self:RPlan(u);if not plan or plan.data.count<minimum then return false end;local handle=u.handle
  local ok=Core:Cast(HK_R,plan.position,{context=context,intentTarget=u,range=self.RSpell.Range,prevalidateWorldCast=true,deferAttackWindup=true,
   directionalWorldCast=self.RSpell.DirectionalCast and self.directionalSupported,directionalAimError=self.RSpell.AimErrorWorld,
  observe=function(q)return self:Native(q)end,
  resolve=function()if not permission()or u.handle~=handle then return nil,'relay_context_changed'end;local fresh=self:RPlan(u);return fresh and fresh.data.count>=minimum and fresh or nil end,
  validate=function(q,r)
   if not(self:Ready(_R)and self:Current(u)and u.handle==handle and permission()and r and point(r.position))then return false end
   local relay=self:Relay(r.position,u);if not relay or relay.count<minimum then return false end
    local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,r.position,self.RSpell.Speed,OrbamaPrediction:GetLaunchDelay(self.RSpell),self.RSpell.Radius+(self.RSpell.AimErrorWorld or 0),self.RSpell.CollisionTypes,id(u));return wall==false and finite(count)and count==0
  end})
 if ok then self.rObservation={q=Core.lastIntent,hits={},expires=Game.Timer()+4,origin=point(myHero.pos),aim=plan.position}end;return ok
end
function SeraphineChampion:NotesUseful(u)
 local n=self:Notes(myHero);return Menu.Passive.Notes:Value()and n and n>0 and self:Current(u)and _G.SDK.Data:IsInAutoAttackRange(myHero,u)and _G.SDK.Orbwalker:CanAttack()
end
function SeraphineChampion:OnPreAttack(args)
 if not Core:Available()or not args or args.Process==false then return end
 if GetMode()=='Harass'and not Menu.Harass.Minions:Value()and args.Target and args.Target.type~=Obj_AI_Hero then args.Process=false end
end
function SeraphineChampion:Combat(mode)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return false end;local context=Core:ModeContext(mode)
 if self:ContinueChain()then return true end
 if mode=='Combo'and Menu.Combo.R:Value()then local r=GetTarget(3600);if self:Current(r)and self:R(r,context,function()return Menu.Combo.R:Value()and Core.manaAbove(node.Mana:Value())end,Menu.Combo.Count:Value())then return true end end
  local u=GetTarget(1300);if not self:Current(u)then self.echoWait=nil;return false end
  if self:NotesUseful(u)then self.echoWait=nil;return false end
  local echo=self:Echo()
  if self:WaitForEcho(u,mode,node,echo)then return false end
 for _,slot in ipairs({_E,_Q})do local name=slot==_Q and'Q'or'E'
   -- Seraphine-2: with the E target beyond Q range, Q takes the selector's target inside Q range.
   local target=u;if slot==_Q and GetDistance(u.pos,myHero.pos)>self.QSpell.Range then target=GetTarget(self.QSpell.Range);if not self:Current(target)then target=nil end end
   if target and node[name]:Value()and self:CastSpell(slot,target,context,function()return node[name]:Value()and Core.manaAbove(node.Mana:Value())end,
    echo.known and echo.stage==2,
    function(plan)return slot~=_E or not Menu.Auto.EOnlyControl:Value()or Core:ControlledHit(u,self.ESpell,plan.position)end)then return true end
 end;return false
end
function SeraphineChampion:WaitForEcho(u,mode,node,echo)
 -- The doubled cast is kept for E: when E is at most `budget` seconds from ready, Q waits that long for it.
 local budget=.6;local now=Game.Timer()
 if not echo.known or echo.stage~=2 or not finite(echo.expires)then self.echoWait=nil;return false end
 local slot=_E
 local d=myHero:GetSpellData(slot);local remaining=d and d.currentCd
 local useful=finite(remaining)and remaining>0 and remaining<=budget and finite(d.mana)and d.mana<=myHero.mana
  and echo.expires>now+remaining+.25
 if useful then
   useful=node.E:Value()and GetDistance(u.pos,myHero.pos)<=self.ESpell.Range
    and(not Menu.Auto.EOnlyControl:Value()or Core:ControlledHit(u,self.ESpell,u.pos))
 end
 if not useful then self.echoWait=nil;return false end
 local wait=self.echoWait
 if not wait or wait.id~=id(u)or wait.handle~=u.handle or wait.mode~=mode or wait.slot~=slot or wait.echoExpires~=echo.expires then
  wait={id=id(u),handle=u.handle,mode=mode,slot=slot,echoExpires=echo.expires,deadline=now+budget};self.echoWait=wait
 end
 return now<wait.deadline
end
-- Damage of hits landing in order. High Note grows with the champion's missing health, read from the health
-- left after the hits before it and by the most conservative reading of the published 0%-75% (see the
-- profile), so the estimate stays a lower bound. No x2 shortcut: each hit advances the health.
function SeraphineChampion:Burst(u,hits)
 if not finite(u.health)or not finite(u.maxHealth)or u.maxHealth<=0 then return 0 end;local hp,total=u.health,0
 for _,slot in ipairs(hits)do local d=self:Damage(u,slot,true)
  if slot==_Q and u.team~=myHero.team and(u.type==Obj_AI_Hero or u.team==300)then d=d*(1+profile.qMissingMax*math.max(0,math.min(1,1-hp/u.maxHealth)))end
  total=total+d;hp=hp-d
 end;return total
end
-- The cast about to be made repeats itself when an owned Echo is at stage 2 (read fresh at dispatch too).
function SeraphineChampion:Echoed()local echo=self:Echo();return echo.known and echo.stage==2 end
function SeraphineChampion:Finisher(u,slot,aim)
 local spell=slot==_Q and self.QSpell or self.ESpell
 if not self:Current(u)or u.type~=Obj_AI_Hero or u.team==myHero.team then return false end
 local hits,impact={slot},OrbamaPrediction:GetImpactTime(spell,aim or u.pos,myHero)
 if self:Echoed()then hits[2]=slot;impact=impact+profile.echoDelay end
 return Core:Lethal(u,impact,self:Burst(u,hits),{kind='magical'})==true
end
-- Seraphine-1: E then Q kills when neither kills alone. Both ready, mana for both, and Q still reaches the
-- target where E leaves it. Echo at stage 2 doubles E (the cast made first); Q's bonus reads health after E.
function SeraphineChampion:PairKills(u,aim)
 if not self:Current(u)or u.type~=Obj_AI_Hero or u.team==myHero.team or not self:Ready(_E)or not self:Ready(_Q)then return false end
 local de,dq=myHero:GetSpellData(_E),myHero:GetSpellData(_Q)
 if not(de and dq and finite(de.mana)and finite(dq.mana)and de.mana+dq.mana<=myHero.mana)then return false end
 local eImpact=OrbamaPrediction:GetImpactTime(self.ESpell,aim or u.pos,myHero)
 local at=self:PredictPoint(u,eImpact,true);if not at or GetDistance(at,myHero.pos)>self.QSpell.Range then return false end
 local hits={_E};if self:Echoed()then hits[2]=_E end;hits[#hits+1]=_Q
 return Core:Lethal(u,eImpact+OrbamaPrediction:GetImpactTime(self.QSpell,at,myHero),self:Burst(u,hits),{kind='magical'})==true
end
function SeraphineChampion:IndependentSpells()
 -- Finishers ignore the mana limit; casts on immobilised enemies respect it.
 for _,slot in ipairs({_E,_Q})do local name=slot==_Q and 'Q'or 'E';local spell=slot==_Q and self.QSpell or self.ESpell
  if self:Ready(slot)and not Core.adapter:ResourceAction(Core.adapter:SlotResource(slot),false)then
   -- A kill, a certain hit on an immobilised enemy, or (E) an enemy dashing at Seraphine.
   local function qualifies(u,aim)
    return self:Finisher(u,slot,aim)
     or Core.manaAbove(Menu.Auto.Mana:Value())and(Core:ControlledHit(u,spell,aim)
      or slot==_E and Menu.Auto.AntiDash:Value()and Core:ApproachingDash(u,myHero.pos,450)~=nil)
   end
   local candidates={};for _,u in ipairs(self:Rows('enemy',spell.Range))do if qualifies(u,u.pos)then candidates[#candidates+1]=u end end
   local selected=_G.SDK.TargetSelector.Selected
   if self:Current(selected)and selected.team~=myHero.team and GetDistance(selected.pos,myHero.pos)<=spell.Range then
    candidates=qualifies(selected,selected.pos)and {selected}or {}
   end
   local attempts=0
   while #candidates>0 and attempts<3 do
    local u=_G.SDK.TargetSelector:GetTarget(candidates,_G.SDK.DAMAGE_TYPE_MAGICAL);if not u then break end
    attempts=attempts+1
    local context={priority='interactive'}
    if self:CastSpell(slot,u,context,nil,nil,
     function(plan)return qualifies(u,plan.position)end,false)then return true end
    for i=#candidates,1,-1 do if candidates[i]==u then table.remove(candidates,i)end end
   end
  end
 end
 return self:PairFinisher()
end
function SeraphineChampion:PairFinisher()
 if self.chain or not self:Ready(_E)or not self:Ready(_Q)or Core.adapter:ResourceAction(Core.adapter:SlotResource(_E),false)then return false end
 local candidates={};for _,u in ipairs(self:Rows('enemy',self.ESpell.Range))do if self:PairKills(u,u.pos)then candidates[#candidates+1]=u end end
 local selected=_G.SDK.TargetSelector.Selected
 if self:Current(selected)and selected.team~=myHero.team and GetDistance(selected.pos,myHero.pos)<=self.ESpell.Range then candidates=self:PairKills(selected,selected.pos)and {selected}or {}end
 local u=#candidates>0 and _G.SDK.TargetSelector:GetTarget(candidates,_G.SDK.DAMAGE_TYPE_MAGICAL)
 return u and self:CastSpell(_E,u,{priority='interactive'},nil,nil,function(plan)return self:PairKills(u,plan.position)end,'finisher')or false
end
-- Health-bar damage: ready E (doubled by a stage-2 Echo) then Q in order, ready R and one attack.
function SeraphineChampion:ComboDamage(u)
 local hits={};if self:Ready(_E)then hits[1]=_E;if self:Echoed()then hits[2]=_E end end;if self:Ready(_Q)then hits[#hits+1]=_Q end
 local total=self:Burst(u,hits)+(self:Ready(_R)and self:Damage(u,_R)or 0)
 local ok,attack=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true);if ok and finite(attack)then total=total+attack end
 return total
end
function SeraphineChampion:Combo()return self:Combat('Combo')end
function SeraphineChampion:Harass()return self:Combat('Harass')end
function SeraphineChampion:Count(slot,position,kind)
 local spell=slot==_Q and self.QSpell or self.ESpell;local count=0;local origin=myHero.pos;local direction=position-origin;local length=direction:Len();if length<=0 then return 0 end;direction=direction/length
  for _,u in ipairs(self:Rows(kind,spell.Range+spell.Radius))do local p=self:PredictPoint(u,OrbamaPrediction:GetImpactTime(spell,u.pos,myHero),true)
  if p then local hit
    if slot==_Q then hit=GetDistance(p,position)<=spell.Radius else local along=(p.x-origin.x)*direction.x+(p.z-origin.z)*direction.z;hit=along>=0 and along<=spell.Range and GetDistance(origin+direction*along,p)<=spell.Radius end
   if hit then count=count+1 end
  end
 end;return count
end
function SeraphineChampion:CSUseful(u,slot,geometryPrepared)
 if not self:Current(u)or u.team==300 or u.team==myHero.team then return false end
  local spell=slot==_Q and self.QSpell or self.ESpell;local time=OrbamaPrediction:GetImpactTime(spell,u.pos,myHero);local hp=Core:UnshieldedLegacyForecast(u,time)
 if not finite(hp)or hp<=0 or self:Damage(u,slot,true)<hp+(u.hpRegen or 0)*time then return false end
 if _G.SDK.Data:IsInAutoAttackRange(myHero,u)and _G.SDK.Orbwalker:CanAttack()then
  local t=myHero.attackData.windUpTime or .25;local future=Core:UnshieldedLegacyForecast(u,t);local aa=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)
  if finite(future)and future>0 and aa>=future+(u.hpRegen or 0)*t then return false end
 end
 return geometryPrepared or self:Count(slot,u.pos,'lane')==1
end
function SeraphineChampion:Farm(kind,node,context,rescue)
 if not Core.manaAbove(node.Mana:Value())or not(node.Q:Value()and self:Ready(_Q)or node.E:Value()and self:Ready(_E))then return false end;local rows=self:Rows(kind,1300)
 if #rows==0 then return false end;local start=(self.farmIndex[kind]or 1);if start>#rows then start=1 end
 self.farmIndex[kind]=(start+math.min(6,#rows)-1)%#rows+1
 for _,slot in ipairs({_Q,_E})do local name=slot==_Q and'Q'or'E'
  if node[name]:Value()and self:Ready(slot)then local best,score
   for i=1,math.min(#rows,6)do local u=rows[(start+i-2)%#rows+1];if(not rescue or self:CSUseful(u,slot,true))and GetDistance(u.pos,myHero.pos)<=(slot==_Q and 900 or 1300)then
    local plan=self:Plan(slot,u);if plan then local count=self:Count(slot,plan.position,kind);local value=rescue and u.maxHealth or count*10000+u.maxHealth
     if(rescue and count==1 or not rescue and(kind~='lane'or count>=(slot==_Q and Menu.Clear.LaneClear.Count:Value()or 2)))and(not best or value>score)then best,score=u,value end
    end
   end end
   if best and self:CastSpell(slot,best,context,function()
    if not node[name]:Value()or not Core.manaAbove(node.Mana:Value())then return false end
    if rescue then return self:CSUseful(best,slot,true)end;return true
   end,nil,function(r)
    if rescue then return self:Count(slot,r.position,kind)==1 end
    return kind~='lane'or self:Count(slot,r.position,kind)>=(slot==_Q and Menu.Clear.LaneClear.Count:Value()or 2)
   end)then return true end
  end
 end;return false
end
function SeraphineChampion:LaneClear()return Core:FarmModeEnabled('lane')and Menu.Clear.SpellFarm:Value()and self:Farm('lane',Menu.Clear.LaneClear,Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end),false)or false end
function SeraphineChampion:JungleClear()return Core:FarmModeEnabled('jungle')and Menu.Clear.SpellFarm:Value()and self:Farm('jungle',Menu.Clear.JungleClear,Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end),false)or false end
function SeraphineChampion:LastHit()return self:Farm('lane',Menu.LastHit,Core:ModeContext('LastHit'),true)or false end
function SeraphineChampion:Flee()
 local context=Core:ModeContext('Flee')
 if Menu.Misc.FleeW:Value()and self:W(myHero,context,function()return Menu.Misc.FleeW:Value()end,true)then return true end
 local u=GetTarget(1300);if not self:Current(u)then return false end
 if Menu.Misc.FleeE:Value()and self:CastSpell(_E,u,context,function()return Menu.Misc.FleeE:Value()end)then return true end
 return Menu.Misc.FleeR:Value()and self:R(u,context,function()return Menu.Misc.FleeR:Value()end,1)or false
end
-- Seraphine-8: R's charm stops a dangerous channel the charm reaches before it ends (no mode key).
function SeraphineChampion:Interrupt()
 if not Menu.Misc.Interrupt:Value()or not self:Ready(_R)then return false end
 for _,u in ipairs(self:Rows('enemy',3600))do
  local function stoppable()return Menu.Misc.Interrupt:Value()and self:Current(u)
   and Core:CanInterrupt(u,OrbamaPrediction:GetLaunchDelay(self.RSpell)+GetDistance(u.pos,myHero.pos)/self.RSpell.Speed)end
  if stoppable()and self:R(u,{priority='interactive'},stoppable,1)then return true end
 end;return false
end
function SeraphineChampion:Assist()
 if Menu.Misc.R:Value()then local u=GetTarget(3600);return self:Current(u)and self:R(u,Core:HeldContext(function()return Menu.Misc.R:Value()end),function()return Menu.Misc.R:Value()end,1)or false end
 return false
end
function SeraphineChampion:Tick()
 if ShouldWait()or not Core:Available()then self.chain=nil;self.echoWait=nil;return end
 if Game.Timer()>=(self.nextDiscovery or 0)then self:Discover()end;self:ObserveNative();if self.rObservation and self.rObservation.expires<Game.Timer()then self:TraceR();self.rObservation=nil end
 if IsCasting()then return end
  local mode=GetMode();if mode~='Combo'and mode~='Harass'then self.echoWait=nil end
  self:Sample()
  -- A finisher E's follow-up Q (Seraphine-1) runs without a mode key and blocks nothing else.
  if self.chain and self.chain.finisher then self:ContinueChain()end
  if self:AutoW()or self:Interrupt()or self:Assist()or self:IndependentSpells()then return end
  if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LaneClear'then if not self:LaneClear()then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function SeraphineChampion:Draw()
 if myHero.dead then return end
 -- Ready abilities only; no passive/notes/shield text (the game shows the echo, the notes and the shield).
 if Menu.Draw.Ranges:Value()then for slot,range in pairs({[_W]=800,[_Q]=900,[_E]=1300})do if IsReady(slot)then Draw.Circle(myHero.pos,range,1,Draw.Color(255,200,120,240))end end end
end
function SeraphineChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Seraphine: control','Seraphine: support'},function(page)return{title='Seraphine assistance',cards=page==1 and{
  {'MODES','Provider binds select Combo, Harass, separate Lane/Jungle, LastHit and Flee. Ability farming is one toggle and starts off. Harass leaves minions alone unless you enable it.'},
   {'ECHO','The doubled cast is always kept for E, whose doubled hit roots. Only owned current native Echo stages count. Waiting keeps one target, mode and original deadline and owns no cursor. E input alone does not prove CC; follow-up Q waits for current own E control and also retains its active combat bind.'},
  {'RELAY','T holds selected R. Every champion relay must intersect the outgoing predicted ray and refresh remaining1200 range; spell-shielded or untargetable enemies neither count nor relay. Combo R needs its enemy count.'}}or{
  {'RESCUE','W reacts independently to what is about to hit an ally or you (a champion\'s attack or targeted cast, an enemy turret shot, a tracked skillshot), to an ally at 30% health or less an enemy can reach, or to feasible existing-shield/Echo healing, honoring ally preferences, priority and mana.'},
  {'NOTES','Observed owned notes can prefer an available native-range attack. Timers and spell requests never create notes or passive damage; attack execution remains with Orbama.'},
   {'ASSISTANCE','Q and E are always cast at immobilised or killable enemies without a mode key, and E at an enemy dashing at you unless you switch that off; finishers ignore the mana limit. Finishers count the Echo repeat, and E then Q when only both together kill (Q follows once E\'s slow is seen); notes and item procs are left out. Q\'s missing-health bonus is read from the health left after the hits before it, by the most conservative reading of the published 0-75%. R stops dangerous channels unless you switch that off. Combo/Harass E can separately require the shared control window. Directional E/R use capability-gated ray aiming for visible off-screen targets.'},
   {'LIMITS','Q uses current1300 speed/.4AP and conservative bloom timing; lethal farming counts only one minimum-damage cast. Relay, healing and hits stay estimates until actual native effects are observed.'}}}end)
end
Core:RegisterPolicy({damageTypes={Q='magical',E='magical',R='magical'},methods={Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
  LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end,
  IndependentSpells=function()return {priority='interactive'}end},channel=function()return not Core:SelfChanneling()end,
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot)end;return true end})
SeraphineChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={}
local normalSupported={["Seraphine"]=true}

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
