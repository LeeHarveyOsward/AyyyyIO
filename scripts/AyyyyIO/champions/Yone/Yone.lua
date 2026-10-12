return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Yone"]=function()return _G.OrbamaFamily:Require("207297dc7c033d426acfe0f57d2b7d28a149ce9229e26943624728f166fd8faf")()end
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
if champion=="Yone" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Yone',profiles={normal=true,classic=false},
 Create=function(context)
-- Independent feature implementation; CombatProfiles/yone-provenance.json.
local profile=ChampionProfiles('Yone')[myHero.charName]
local finite,id,point,expiry=Core.finite,Core.id,Core.point,Core.buffExpiry
local function owned(b)
 local found=false;for _,key in ipairs({'source','sourceID','sourcenID','owner','ownerID'})do local v=b and b[key]
  if v and v~=0 then if type(v)=='table'or type(v)=='userdata'then v=id(v)end;if v~=myHero.networkID and v~=myHero.handle then return false end;found=true end
 end;return found
end
local function cleanup(self)if self.q3Flash then self.q3Flash:Cancel('controller_cleanup')end;self.spirit=nil;self.entry=nil;self.preview=nil;self.tornado=nil;self.lastAttack=nil;self.lastQ3CastAt=nil;self.wObservation=nil;self.missileScan=1;self.farmIndex={}
 self.detonation=nil;self.q3Hits=nil;self.flashCd=nil end
local YoneChampion=class("YoneChampion")
function YoneChampion:__init()
 assert(myHero.charName=='Yone','No verified Classic Yone kit');self.profile=profile
 -- Pinned by this champion's regressions: only a ready, in-range lethal attack keeps the spell (Core:Rescue).
 -- Yone's attack is physical or half magical; the weaker of the two is what is guaranteed.
 self.rescue={attack='ready',attackDamage=function(u)local d=_G.SDK.Damage;local ad=myHero.totalDamage
  return math.min(d:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,ad),d:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,ad*.5)+d:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,ad*.5))end}
 self.targets={};self.farmIndex={};self.missileScan=1;self:LoadMenu();self:Discover()
 -- Q3 then Flash through the shared follow-up service (spell first: Flash only after the observed Q3 cast).
 self.q3Flash=Core:FlashFollow('YoneQ3Flash')
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 -- Health-bar damage (S9, rerank drawings): the ready burst over 1.5 s (R when ready, Q, W, the attacks it holds).
 Core:RegisterComboDamage(function(u)local physical,magical=self:Burst(u,1.5,self:Ready(_R));return physical+magical,true end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Yone',function()cleanup(self)end)
 local ok,why=Core:RegisterPreparation('Yone.preview',{intervalMs=150,maxDelayMs=500,units=2,maxUnits=2},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end);self.previewFallback=not ok and why=='unsupported'
 -- Q3 always travels 450 units. A consumer may not describe a shorter dash.
 Core:RegisterMobility({kind='dash',slot=_Q,key=HK_Q,name=profile.q3,range=profile.q3Dash,speeds={profile.q3DashSpeed},castDelays={profile.q3Cast},profile='normal',label='Mortal Steel Q3',
  source=profile.mobilitySource,
  allowed=function(p)return self:Ready(_Q)and self:QState().stage==3
   and(p==nil or math.abs(GetDistance(p,myHero.pos)-450)<.5 and self:PathSafe(p,false))end})
 -- W shield: offered to Evade only once the shield value is verified on the host (see RegisterWShield).
 if profile.wShieldVerified then self:RegisterWShield()end
end
-- W shield offered to Evade with its lower bound (level-1 base plus the bonus AD share, no champion multiplier),
-- only while an enemy champion stands deep enough in the cone that it is still inside when the cast ends. The
-- window is the shortest one every attack speed shares: it starts after the longest cast and ends with the
-- shortest. Gated by profile.wShieldVerified: the installed asset's .75 override and the hit attribution are not
-- verified, so the offer stays off until development recordings (yone_w_shield) settle the value.
function YoneChampion:RegisterWShield()
 self.shieldOffered,self.shieldReason,self.shieldDefense=Core:RegisterShield({name='YoneW',slot=_W,key=HK_W,profile='normal',spell=profile.w,
  source=profile.wShieldSource,duration=profile.wShieldDuration-(profile.wCastLong-profile.wCastShort),delay=profile.wCastLong,kind='world',
  ready=function()return self:ShieldAim()~=nil end,target=function()return self:ShieldAim()end,
  amount=function()local bonus=finite(myHero.bonusDamage)and math.max(0,myHero.bonusDamage)or 0;return profile.wShieldBase+profile.wShieldBonusAD*bonus end})
 return self.shieldOffered
end
function YoneChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_Yone',name='AyyyyIO - Yone'})
 for _,mode in ipairs({'Combo','Harass'})do Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q',value=true});Menu[mode]:MenuElement({id='Q3',name='Use Q3 (dashes forward)',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='W',name='Use W',value=true})
  Menu[mode]:MenuElement({id='E',name=mode=='Combo'and 'Use E to set up Q3 or when the return kills'or 'Use E to set up Q3, then return after two attacks',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='Stack',name='Stack Q on minions when no champion is in range',value=true})
 end
 Menu.Combo:MenuElement({id='R',name='Use R',value=true});Menu.Combo:MenuElement({id='Count',name='R must hit at least (1 if it can kill)',value=2,min=1,max=5,step=1})
 Menu.Combo:MenuElement({id='ER',name='Use E to get in range for R',value=true})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'});Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do Menu.Clear:MenuElement({type=MENU,id=mode,name=mode});for _,slot in ipairs({'Q','Q3','W'})do Menu.Clear[mode]:MenuElement({id=slot,name=slot=='Q3'and 'Use Q3 (dashes forward)'or 'Use '..slot,value=true})end end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions an ability must hit',value=3,min=1,max=10,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'});Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true});Menu.LastHit:MenuElement({id='Q3',name='Also with Q3 (dashes forward)',value=true});Menu.LastHit:MenuElement({id='W',name='Use W on a lone minion an attack cannot take',value=true})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='Finish',name='Finish killable enemies with Q, W and the E return',value=true});Menu.Misc:MenuElement({id='DashQ3',name='Use Q3 on enemies who dash onto you',value=true})
 Menu.Misc:MenuElement({id='RFinish',name='Finish a killable enemy with R (lands behind them)',value=false})
 Menu.Misc:MenuElement({id='HeldQ3',name='Q3 enemies who cannot move, without a mode key',value=false})
 Menu.Misc:MenuElement({id='Q3Flash',name='Q3, then Flash to an enemy out of Q3 range',key=string.byte('O')})
 Menu.Misc:MenuElement({id='HP',name='Never dash in below health %',value=30,min=1,max=100,step=5});Menu.Misc:MenuElement({id='Enemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='AutoReturn',name='Return from E early when low on health',value=true});Menu.Misc:MenuElement({id='ReturnHP',name='Return from E below health %',value=25,min=5,max=90,step=5,menu=false})
 Menu.Misc:MenuElement({id='FleeQ3',name='Use Q3 toward the cursor when fleeing',value=true});Menu.Misc:MenuElement({id='FleeE',name='Use E toward the cursor when fleeing',value=false});Menu.Misc:MenuElement({id='FleeW',name='Use W on a pursuer when fleeing',value=true})
 Menu.Misc:MenuElement({type=MENU,id='Targets',name='Enemy champions you may dash to'})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'});Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false});Menu.Draw:MenuElement({id='Preview',name='E return spot, Q3 path and E mark damage',value=true})
end
function YoneChampion:Rows(kind,range)return Core:Rows(kind=='enemy'and 'hero'or kind,range)end
function YoneChampion:Current(u)return u~=nil and point(u.pos)~=nil and Core:CurrentUnit(u)end
function YoneChampion:Discover()
 for _,u in ipairs(self:Rows('enemy',5000))do local row=self.targets[id(u)]
  if not row then local key=StableUnitMenuKey(self,'A',u);Menu.Misc.Targets:MenuElement({id=key,name=u.charName,value=true});row={node=Menu.Misc.Targets[key]};self.targets[id(u)]=row end;row.handle=u.handle
 end;self.nextDiscovery=Game.Timer()+1
end
function YoneChampion:Allowed(u)local r=self.targets[id(u)];return u.type~=Obj_AI_Hero or r and r.handle==u.handle and r.node:Value()end
function YoneChampion:Buff(u,name)return(Core:OwnBuff(u,name,true,true))end
function YoneChampion:QState()
 local d=myHero:GetSpellData(_Q);local b=self:Buff(myHero,'YoneQ');local ready=self:Buff(myHero,'YoneQ3Ready')
 return {stage=d and(d.name==profile.q3 and 3 or d.name==profile.q and 1 or 0)or 0,stacks=b and b.count%1==0 and b.count<=2 and b.count or nil,ready=ready~=nil,expires=expiry(ready or b)}
end
function YoneChampion:Timing(slot)
 if slot==_R then return .75 end;local as=myHero.attackSpeed
 if not finite(as)or as<0 then return nil end
 return(slot==_W and .5 or .35)*(1-math.min(.5,.41667*math.max(0,as-1)))
end
function YoneChampion:Ready(slot)
 local d=myHero:GetSpellData(slot);local expected=slot==_Q and(self:QState().stage==3 and profile.q3 or profile.q)or slot==_W and profile.w or slot==_E and profile.e or profile.r
 return d and d.name==expected and finite(d.level)and d.level%1==0 and d.level>=1 and d.level<=(slot==_R and 3 or 5)and finite(d.currentCd)and d.currentCd==0
  and Game.CanUseSpell(slot)==0 and finite(d.mana)and d.mana>=0 and finite(myHero.mana)and myHero.mana>=d.mana or false
end
function YoneChampion:Safe(p,offense)
 if not point(p)or type(Game.isWall)~='function'or Game.isWall(p)~=false or IsUnderTurret2(p)or GetEnemyCount(600,p)>Menu.Misc.Enemies:Value()then return false end
 return not offense or finite(myHero.maxHealth)and myHero.maxHealth>0 and finite(myHero.health)and myHero.health/myHero.maxHealth*100>=Menu.Misc.HP:Value()
end
function YoneChampion:PathSafe(p,offense)return self:Safe(p,offense)and self:Safe(myHero.pos:Extended(p,GetDistance(p,myHero.pos)*.5),offense)end
function YoneChampion:Forecast(u,time,freshRow)
 if not(freshRow and IsValid(u)and point(u.pos)or not freshRow and self:Current(u))or not finite(time)or time<0 or time>3 then return nil end;local p=u.pathing
 if not p or not p.hasMovePath and not p.isDashing then return point(u.pos)end;local speed=p.isDashing and p.dashSpeed or u.ms
 if not point(p.endPos)or not finite(speed)or speed<=0 then return nil end;return u.pos:Extended(p.endPos,math.min(GetDistance(u.pos,p.endPos),time*speed))
end
-- upper=true (Q3 only): the descriptor with the larger reach bound (profile q3ReachUpper), for prediction of a target
-- only that bound reaches; hits and counts always use the conservative q3Reach descriptor.
function YoneChampion:Spell(slot,observedStage,upper)
 local delay=self:Timing(slot);if not delay then return nil end;local q3=slot==_Q and(observedStage==3 or observedStage==nil and self:QState().stage==3)
 upper=upper==true and q3
 self.descriptors=self.descriptors or {};local key=upper and 'q3upper'or q3 and 'q3'or slot;local spell=self.descriptors[key]
 if not spell then spell={Type=slot==_W and OrbamaPrediction.SPELLTYPE_CONE or OrbamaPrediction.SPELLTYPE_LINE,Radius=slot==_R and 112.5 or slot==_W and 0 or 80,
  Angle=slot==_W and 80 or nil,Range=slot==_Q and(upper and profile.q3ReachUpper or q3 and profile.q3Reach or 450)or slot==_W and profile.wRange or 1000,Speed=q3 and 1500 or math.huge,Collision=q3,CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}}
  self.descriptors[key]=spell
 end;spell.Delay=delay;return spell,q3
end
function YoneChampion:Geometry(slot,position,kind,spell,plannedOrigin)
 local origin=plannedOrigin or myHero.pos;local distance=GetDistance(position,origin);if distance<1 then return nil end;local dir=(position-origin)/distance;local rows={};local last,lastPosition=0,nil
 for _,u in ipairs(self:Rows(kind,spell.Range+GetDistance(origin,myHero.pos)+80))do local time=spell.Delay+(spell.Speed==math.huge and 0 or GetDistance(u.pos,origin)/spell.Speed);local p=self:Forecast(u,time,true)
  if p then local along=(p.x-origin.x)*dir.x+(p.z-origin.z)*dir.z;local hit
   if slot==_W then local len=GetDistance(p,origin);hit=len>0 and len<=profile.wRange and along/len>=math.cos(math.rad(40))else hit=along>=0 and along<=spell.Range and GetDistance(origin+dir*along,p)<=spell.Radius end
   if hit then rows[#rows+1]={target=u,handle=u.handle,along=along,position=p};if along>last then last=along;lastPosition=p end end
  end
 end
 return {hits=rows,count=#rows,landing=slot==_R and origin+dir*(last+200)or nil,championLanding=slot==_R and lastPosition and lastPosition+dir*200 or nil}
end
function YoneChampion:RLandingSafe(shape)return shape and shape.count>0 and self:Safe(shape.landing,true)and self:Safe(shape.championLanding,true)end
function YoneChampion:Intersects(slot,aim,u,spell,reach)
 local origin=myHero.pos;local length=GetDistance(origin,aim);if length<1 then return false end;local dir=(aim-origin)/length
 local p=self:Forecast(u,spell.Delay+(spell.Speed==math.huge and 0 or GetDistance(u.pos,origin)/spell.Speed),true);if not p then return false end
 local along=(p.x-origin.x)*dir.x+(p.z-origin.z)*dir.z
 if slot==_W then local dist=GetDistance(origin,p);return dist>0 and dist<=profile.wRange and along/dist>=math.cos(math.rad(40))end
 return along>=0 and along<=(reach or spell.Range)and GetDistance(origin+dir*along,p)<=spell.Radius
end
-- upper=true: a player-requested Q3 also takes a champion only the larger reach bound reaches (profile q3ReachUpper);
-- the aim is then the conservative-range point on the same line (the whirlwind's travel does not depend on it).
function YoneChampion:Plan(slot,u,offense,upper)
 if not self:Ready(slot)or not self:Current(u)or u.team==myHero.team then return nil end;local spell,q3=self:Spell(slot)
 local reachSpell=q3 and upper and self:Spell(slot,nil,true)or spell
 if not spell or not reachSpell or GetDistance(u.pos,myHero.pos)>reachSpell.Range then return nil end
 if(q3 or slot==_R)and not self:Allowed(u)then return nil end
 local pred=Core:Prediction(reachSpell);pred:GetPrediction(u,myHero);if not pred:CanHit(2)or not point(pred.CastPosition)or GetDistance(pred.CastPosition,myHero.pos)>reachSpell.Range then return nil end
 local far=GetDistance(pred.CastPosition,myHero.pos)>spell.Range
 local aim=far and point(myHero.pos:Extended(pred.CastPosition,spell.Range))or point(pred.CastPosition)
 local result={position=aim,data={spell=spell,delay=spell.Delay,q3=q3,stage=self:QState().stage,upper=far or nil,impact=spell.Delay+(spell.Speed==math.huge and 0 or GetDistance(pred.CastPosition,myHero.pos)/spell.Speed)}}
 -- At most four inexpensive alternate rays. Preserve the selected champion,
 -- and reuse the primary prediction instead of predicting each candidate again.
 if(slot==_W or slot==_R or q3)and u.type==Obj_AI_Hero and not far then
  local best=self:Geometry(slot,result.position,'enemy',spell);local primary=result.position
  for _,other in ipairs(self:Rows('enemy',spell.Range))do if other~=u then local future=self:Forecast(other,spell.Delay,true);local aim=future and(primary+future)*.5
   if aim and GetDistance(aim,myHero.pos)>=1 and self:Intersects(slot,aim,u,spell)then local shape=self:Geometry(slot,aim,'enemy',spell)
    if shape and(not best or shape.count>best.count)and(slot~=_R or self:RLandingSafe(shape))then best=shape;result.position=point(aim)end
   end
  end end
 end
 if q3 then local wall,_,n=OrbamaPrediction:GetCollision(myHero.pos,result.position,1500,spell.Delay,80,spell.CollisionTypes,id(u));if wall~=false or not finite(n)or n~=0 then return nil end
  result.data.landing=myHero.pos:Extended(result.position,450);if not self:PathSafe(result.data.landing,offense)then return nil end
 elseif slot==_R then local shape=self:Geometry(slot,result.position,'enemy',spell);if not shape then return nil end
  local found=false;for _,row in ipairs(shape.hits)do if row.target==u then found=true end end;if not found or not self:RLandingSafe(shape)then return nil end;result.data.shape=shape;result.data.landing=shape.landing
 end;return result
end
function YoneChampion:Observe(q,name)
 local cast=Core:NativeCast(q,name or q.spellName);if not cast then return false end;q.nativeCastStart=cast.startTime;q.nativeStartPos=point(cast.startPos)
 if cast.name==profile.q3 then self.lastQ3CastAt=cast.startTime;self.q3Hits={origin=point(cast.startPos),started=cast.startTime,seen={}}end
 if cast.name==profile.w then self.wObservation={q=q,started=cast.startTime,expires=cast.startTime+2,shieldObserved=false,shieldBefore=myHero.shieldAD}
  -- Development evidence for the W cast floor (0.25 here, 0.19 on the wiki).
  if finite(cast.castEndTime)and finite(cast.startTime)then Core:Trace('yone_w_windup',{observed=cast.castEndTime-cast.startTime,model=self:Timing(_W),attackSpeed=myHero.attackSpeed})end
 end;return true
end
function YoneChampion:Damage(u,slot)
 local rank=myHero:GetSpellData(slot).level;if not finite(myHero.totalDamage)or not finite(u.maxHealth)then return 0 end;local physical=_G.SDK.DAMAGE_TYPE_PHYSICAL;local magic=_G.SDK.DAMAGE_TYPE_MAGICAL
 if slot==_Q then return profile.qBase[rank]and _G.SDK.Damage:CalculateDamage(myHero,u,physical,profile.qBase[rank]+1.1*myHero.totalDamage)or 0 end
 local bonus=finite(myHero.bonusDamage)and math.max(0,myHero.bonusDamage)or 0
 local raw=slot==_W and profile.wBase[rank]and(profile.wBase[rank]+profile.wHealth[rank]*u.maxHealth)or slot==_R and profile.rBase[rank]and(profile.rBase[rank]+profile.rBonusAD*bonus)
 if not raw then return 0 end
 -- W against minions: 25% with a per-level floor; against monsters: a per-level maximum (profile, asset tables).
 -- An unreadable champion level keeps the level-1 ends (no floor, the 150 cap): the lower bound.
 if slot==_W and u.type~=Obj_AI_Hero then
  local level=myHero.levelData and myHero.levelData.lvl;level=finite(level)and math.max(1,math.min(20,math.floor(level)))or nil
  if u.team==300 then raw=math.min(raw,level and profile.wMonsterCapByLevel and profile.wMonsterCapByLevel[level]or profile.wMonsterCap)
  else raw=raw*.25;local floor=level and profile.wMinionFloor and profile.wMinionFloor[level];if floor then raw=math.max(raw,floor)end end
 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,physical,raw*.5)+_G.SDK.Damage:CalculateDamage(myHero,u,magic,raw*.5)
end
function YoneChampion:Cast(slot,u,context,permission,offense,minimum,geometry,extra)
 if not permission or not permission()then return false end;local upper=extra and extra.upper==true;local plan=self:Plan(slot,u,offense,upper);if not plan or geometry and not geometry(plan)or slot==_R and plan.data.shape.count<(minimum or 1)then return false end
 local handle=u.handle;local key=slot==_Q and HK_Q or slot==_W and HK_W or HK_R;local stage=plan.data.stage
 local defer=true;if extra and extra.deferAttackWindup~=nil then defer=extra.deferAttackWindup end
 -- The upper-bound Q3 point stays at 950; the champion it is for may stand up to q3ReachUpper away.
 return Core:Cast(key,plan.position,{context=context,intentTarget=u,range=plan.data.spell.Range,objectRange=upper and plan.data.q3 and profile.q3ReachUpper or nil,prevalidateWorldCast=true,deferAttackWindup=defer,
  observe=function(q)return self:Observe(q)end,
  resolve=function()if not permission()or u.handle~=handle or slot==_Q and self:QState().stage~=stage then return nil,'stage_or_consent_changed'end
   local fresh=self:Plan(slot,u,offense,upper);if not fresh or geometry and not geometry(fresh)or slot==_R and fresh.data.shape.count<(minimum or 1)then return nil,'geometry_changed'end;return fresh end,
  validate=function(_,r)
   if not(self:Ready(slot)and self:Current(u)and u.handle==handle and permission()and r and r.data and point(r.position))then return false end
   local spell,q3=self:Spell(slot);local reach=q3 and upper and profile.q3ReachUpper or spell and spell.Range
   if not spell or spell.Delay~=r.data.delay or slot==_Q and self:QState().stage~=stage or GetDistance(u.pos,myHero.pos)>reach or GetDistance(r.position,myHero.pos)>spell.Range
    or not self:Intersects(slot,r.position,u,spell,reach)or geometry and not geometry(r)then return false end
   if q3 then local landing=myHero.pos:Extended(r.position,450);local wall,_,n=OrbamaPrediction:GetCollision(myHero.pos,r.position,1500,spell.Delay,80,spell.CollisionTypes,id(u));return self:Allowed(u)and self:PathSafe(landing,offense)and wall==false and finite(n)and n==0 end
   if slot==_R then local shape=self:Geometry(slot,r.position,'enemy',spell);return self:Allowed(u)and shape and shape.count>=(minimum or 1)and self:RLandingSafe(shape)end;return true
  end})
end
function YoneChampion:Spirit()
 local p=self.spirit;local b=self:Buff(myHero,profile.e);local d=myHero:GetSpellData(_E)
 return p and b and d and d.name==profile.e and d.toggleState==2 and finite(b.startTime)and b.startTime==p.buffStart and expiry(b)==p.expires and Game.Timer()<p.expires and p.expires-p.started<=5.3 and p or nil
end
function YoneChampion:ObserveSpirit()
 local d=myHero:GetSpellData(_E);local b=self:Buff(myHero,profile.e);local a=myHero.activeSpell
 if a and a.valid and not a.isStopped and not a.isAutoAttack and a.name==profile.q3 and finite(a.startTime)and a.startTime<=Game.Timer()and a.startTime>=Game.Timer()-1 then self.lastQ3CastAt=a.startTime end
 local w=self.wObservation;if w then local shield=self:Buff(myHero,profile.w)
  if w.expires<Game.Timer()then self.wObservation=nil elseif w.q.observedAt and shield and finite(shield.startTime)and shield.startTime>=w.started and shield.startTime<=Game.Timer()then
   if not w.shieldObserved then local bonus=finite(myHero.bonusDamage)and myHero.bonusDamage or 0
    Core:Trace('yone_w_shield',{level=myHero.levelData and myHero.levelData.lvl,bonusAD=bonus,shieldBefore=w.shieldBefore,shieldAfter=myHero.shieldAD,
     lowerBound=profile.wShieldBase+profile.wShieldBonusAD*math.max(0,bonus)})
   end
   w.shieldObserved=true;w.shieldExpires=expiry(shield)
  end
 end
 if self.spirit and not self:Spirit()then self.spirit=nil end
 if not self.spirit and d and d.toggleState==2 and b and finite(b.startTime)and b.startTime<=Game.Timer()and a and a.valid and not a.isStopped and not a.isAutoAttack and a.name==profile.e and finite(a.startTime)
  and a.startTime<=Game.Timer()and a.startTime>=Game.Timer()-1 and b.startTime>=a.startTime and point(a.startPos)and expiry(b)>a.startTime and expiry(b)<=a.startTime+5.3 then
  self.spirit={anchor=point(a.startPos),started=a.startTime,buffStart=b.startTime,expires=expiry(b),ledger={}}
 end
 local p=self:Spirit();if not p then return end
 for key,row in pairs(p.ledger)do if not self:Current(row.target)or row.target.handle~=row.handle or row.expires<=Game.Timer()then p.ledger[key]=nil end end
 for _,u in ipairs(self:Rows('enemy',5000))do local mark=self:Buff(u,'YoneEDeathmark');local row=p.ledger[id(u)]
  if mark and finite(mark.startTime)and mark.startTime>=p.started and mark.startTime<=Game.Timer()and expiry(mark)<=p.expires+.3 then
   if not row or row.handle~=u.handle then row={target=u,handle=u.handle,attacks=0,casts=0,estimated=0,guaranteed=0,pending={},health=u.health};p.ledger[id(u)]=row end;row.expires=expiry(mark)
  elseif row then p.ledger[id(u)]=nil end
 end
 local slot=a and(a.name==profile.q or a.name==profile.q3)and _Q or a and a.name==profile.w and _W or a and a.name==profile.r and _R
 if slot and a.valid and not a.isStopped and finite(a.startTime)and a.startTime>=p.started and a.startTime<=Game.Timer()then
  local token=a.name..':'..tostring(a.startTime);local aim=point(a.placementPos or a.endPos)
  if token~=p.lastCast and aim then local spell=self:Spell(slot,a.name==profile.q3 and 3 or 1);local shape=spell and self:Geometry(slot,aim,'enemy',spell)
   if shape then p.lastCast=token;for _,hit in ipairs(shape.hits)do local row=p.ledger[id(hit.target)];if row and row.handle==hit.handle then local d=self:Damage(hit.target,slot)
    row.casts=row.casts+1;row.estimated=row.estimated+d;self:Evidence(row,d,(slot==_R and 1.1 or .9),false)end end end
  end
 end
 self:SettleEvidence(p)
end
-- E stored damage on evidence (gap Yone-8). Each own completed attack or own ability whose shape held the marked
-- champion opens a window; health the champion loses inside it counts, up to that event's computed damage. Health
-- lost with no own event open (teammates, items, Ignite) and damage absorbed by shields (no health lost) never count.
-- `landed`: the event's damage is already applied (a completed attack), so the drop since the last look is its own.
function YoneChampion:Evidence(row,damage,seconds,landed)
 if not finite(damage)or damage<=0 then return end
 local now=Game.Timer();local drop=landed and finite(row.health)and finite(row.target.health)and math.max(0,row.health-row.target.health)or 0
 local e={expected=damage,observed=math.min(drop,damage),closes=now+seconds}
 row.health=row.target.health;row.pending[#row.pending+1]=e
end
function YoneChampion:SettleEvidence(p)
 local now=Game.Timer()
 for _,row in pairs(p.ledger)do local u=row.target
  if row.pending and finite(u.health)then
   local drop=finite(row.health)and math.max(0,row.health-u.health)or 0
   for i=1,#row.pending do local e=row.pending[i];if drop<=0 then break end
    if e.closes>=now then local take=math.min(drop,e.expected-e.observed);if take>0 then e.observed=e.observed+take;drop=drop-take end end
   end
   for i=#row.pending,1,-1 do local e=row.pending[i]
    if e.closes<now then row.guaranteed=row.guaranteed+e.observed;table.remove(row.pending,i)end
   end
   row.health=u.health
  end
 end
end
-- What the E return deals to this row now: open windows count what they have seen so far.
function YoneChampion:Stored(row)
 local total=row.guaranteed or 0;for _,e in ipairs(row.pending or {})do total=total+e.observed end
 local rank=myHero:GetSpellData(_E).level;local share=profile.eStore[rank]
 return share and total*share or 0
end
function YoneChampion:ReturnKills(row)
 local u=row.target
 if not u or u.handle~=row.handle or not IsValid(u)or not finite(u.health)then return false end
 local shields=(finite(u.shieldAD)and u.shieldAD or 0)+(finite(u.shieldAP)and u.shieldAP or 0)
 return self:Stored(row)>=u.health+shields+(finite(u.hpRegen)and math.max(0,u.hpRegen)or 0)*1+2
end
-- The E return as an execute: under Finish, when a marked champion's stored lower bound kills and the anchor is safe.
function YoneChampion:Execute()
 local p=self:Spirit();if not p or not Menu.Misc.Finish:Value()then return false end
 for _,row in pairs(p.ledger)do
  if self:ReturnKills(row)then
   local ok=self:Return({priority='interactive'},function()return Menu.Misc.Finish:Value()and self:Spirit()==p and self:ReturnKills(row)end)
   if ok then self.detonation={target=row.target,handle=row.handle,at=Game.Timer(),stored=self:Stored(row)}end
   return ok
  end
 end;return false
end
-- Development evidence: delay from the execute request until the mark is gone, and whether the target died.
function YoneChampion:TraceDetonation()
 local d=self.detonation;if not d then return end
 local u=d.target;local gone=not u or u.handle~=d.handle or u.dead==true or not self:Buff(u,'YoneEDeathmark')
 if gone then Core:Trace('yone_e_detonation',{delay=Game.Timer()-d.at,dead=u and u.dead==true,stored=d.stored});self.detonation=nil
 elseif Game.Timer()-d.at>2 then self.detonation=nil end
end
function YoneChampion:OnPostAttack(args)
 if not Core:Available()then return end;local a=Core:AttackWitness(self.lastAttack,args and args.Target);if not a or a==self.lastAttack or a.at>Game.Timer()then return end;self.lastAttack=a
 local p=self:Spirit();local row=p and p.ledger[a.target];if not row or row.target~=a.object or row.handle~=a.object.handle
  or not finite(a.startTime)or a.startTime<p.started or not self:Buff(a.object,'YoneEDeathmark')then return end
 row.attacks=row.attacks+1
 -- Completed attack is not a damage event. Keep this an estimate, never an execute.
 local damage=_G.SDK.Damage:CalculateDamage(myHero,a.object,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage);row.estimated=row.estimated+damage
 -- The evidence bound uses the weaker blade (physical or half magic).
 if row.pending then self:Evidence(row,self.rescue.attackDamage(a.object),.35,true)end
end
function YoneChampion:ERFeasible(u,landing,minimum)
 if not self:Ready(_R)or not self:Current(u)or not point(landing)then return false end;local future=self:Forecast(u,1.05)
 if not future or GetDistance(future,landing)>1000 then return false end
 local spell={Range=1000,Radius=112.5,Delay=1.05,Speed=math.huge};local shape=self:Geometry(_R,future,'enemy',spell,landing)
 return shape and shape.count>=minimum and self:RLandingSafe(shape)
end
-- opts.gate: a condition for the cast itself (checked now and at dispatch, not while the entry is followed).
-- opts.reach: how close to the target the dash must end (default 700).
function YoneChampion:EEnter(u,context,permission,goal,offense,followMin,opts)
 local reach,gate=opts and opts.reach or 700,opts and opts.gate
 local d=myHero:GetSpellData(_E);if self.entry or self:Spirit()or not self:Ready(_E)or d.toggleState~=1 or not permission()or gate and not gate()or not point(goal)or not self:Safe(myHero.pos,false)then return false end
 if u and(not self:Current(u)or not self:Allowed(u))then return false end
 local p={target=u,handle=u and u.handle,permission=permission,context=context,expires=Game.Timer()+1.25,followMin=followMin};local function aim()
  local dest=u and u.pos or mousePos;if not point(dest)or GetDistance(dest,myHero.pos)<10 then return nil end;return myHero.pos:Extended(dest,300)
 end
 local landing=aim();if not landing or not self:PathSafe(landing,offense)then return false end
 if u and(not followMin and GetDistance(u.pos,landing)>reach or followMin and not self:ERFeasible(u,landing,followMin))then return false end
 self.entry=p
 -- E targets ground direction. The selected enemy is a continuation identity,
 -- not an object cast whose range is limited to the 300-unit dash endpoint.
 local ok=Core:Cast(HK_E,landing,{context=context,range=301,prevalidateWorldCast=true,
  observe=function(q)return self:Observe(q,profile.e)end,
  resolve=function()local pos=aim();return pos and {position=pos}or nil end,
  validate=function(_,r)local data=myHero:GetSpellData(_E);return self.entry==p and permission()and(not gate or gate())and self:Ready(_E)and data.toggleState==1 and point(r and r.position)and self:Safe(myHero.pos,false)and self:PathSafe(r.position,offense)
   and math.abs(GetDistance(r.position,myHero.pos)-300)<.5
   and(not u or self:Current(u)and u.handle==p.handle and self:Allowed(u)and(not followMin and GetDistance(u.pos,r.position)<=reach or followMin and self:ERFeasible(u,r.position,followMin)))end})
 if not ok then self.entry=nil;return false end;p.q=Core.lastIntent;return true
end
function YoneChampion:ContinueEntry()
 local p=self.entry;if not p then return false end;local result=Core.adapter:Poll(p.q.id)
 if not result or p.q.cancelled or result.state=='cancelled_before_send'or result.state=='send_uncertain'or not p.q.continue()or not p.permission()or Game.Timer()>p.expires
  or p.target and(not self:Current(p.target)or p.target.handle~=p.handle)then self.entry=nil;return false end
 local spirit=self:Spirit()
 -- The entry holds the whole tick (Q, W and R included). E's outcome is the
 -- spirit form itself: the slot toggled and the owned buff present after a send
 -- that required the first stage. When the native cast was not shown, an entry
 -- with nothing to follow ends there, and the E-R follow, which needs the native
 -- dash origin, gives up 0.3 s later instead of holding to the 1.25 s expiry.
 if result.sentAt and not(p.q.observedAt and spirit)then local d=myHero:GetSpellData(_E)
  if d and d.toggleState==2 and self:Buff(myHero,profile.e)then p.formAt=p.formAt or Game.Timer()
   if not p.followMin or Game.Timer()-p.formAt>.3 then self.entry=nil;return false end
  end
 end
 if p.q.observedAt and spirit then
  if spirit.started~=p.q.nativeCastStart or not point(p.q.nativeStartPos)or GetDistance(spirit.anchor,p.q.nativeStartPos)>.5 then self.entry=nil;return false end
  if not p.followMin then self.entry=nil;return false end
  if myHero.pathing and myHero.pathing.isDashing or not point(p.q.nativeStartPos)or GetDistance(myHero.pos,p.q.nativeStartPos)<40 then return true end
  local ok=self:Cast(_R,p.target,p.context,p.permission,true,p.followMin);self.entry=nil;return ok
 end;return true
end
function YoneChampion:Return(context,permission)
 local p=self:Spirit();if not p or not permission()or not self:Ready(_E)or Game.Timer()<p.started+.5 or not self:Safe(p.anchor,false)then return false end
 return Core:Cast(HK_E,nil,{context=context,owner='SoulReturn',observe=function(q)return self:Observe(q,profile.e)end,
  validate=function()return self:Spirit()==p and permission()and self:Ready(_E)and Game.Timer()>=p.started+.5 and self:Safe(p.anchor,false)end})
end
function YoneChampion:AutoReturn()
 local p=self:Spirit();if not p or not Menu.Misc.AutoReturn:Value()then return false end
 local function useful()return Menu.Misc.AutoReturn:Value()and(Game.Timer()-p.started>=4.3 or myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100<=Menu.Misc.ReturnHP:Value()
  -- An attack or turret shot that would kill, with the anchor no more crowded than here.
  or self:LethalThreat()and GetEnemyCount(600,p.anchor)<=GetEnemyCount(600,myHero.pos))end
 return useful()and self:Return({},useful)or false
end
function YoneChampion:ObserveTornado()
 if self.tornado and(self.tornado.expires<=Game.Timer()or not self.tornado.object.valid or id(self.tornado.object)~=self.tornado.id or not owned(self.tornado.object.missileData or self.tornado.object))then self.tornado=nil end
 if not finite(self.lastQ3CastAt)or Game.Timer()>self.lastQ3CastAt+1.25 or type(Game.MissileCount)~='function'or type(Game.Missile)~='function'then return end;local count=Game.MissileCount();if not finite(count)or count<0 or count>512 then return end
 for _=1,math.min(8,count)do if self.missileScan>count then self.missileScan=1 end;local u=Game.Missile(self.missileScan);self.missileScan=self.missileScan+1;local d=u and u.missileData
  local created=u and(u.createTime or d and d.startTime)
  if u and u.valid and id(u)and d and d.name=='YoneQ3Missile'and owned(d)and point(u.pos)and finite(created)and created>=self.lastQ3CastAt and created<=Game.Timer()then self.tornado={object=u,id=id(u),expires=self.lastQ3CastAt+1.25}end
 end
end
function YoneChampion:CSUseful(u,slot)
 local spell=self:Spell(slot);if not spell or not self:Current(u)or u.type==Obj_AI_Hero or u.team==300 then return false end
 return Core:Rescue(u,spell.Delay+(spell.Speed==math.huge and 0 or GetDistance(u.pos,myHero.pos)/spell.Speed),function()return self:Damage(u,slot)end,self.rescue)
end
-- A LastHit Q3 carries Yone 450 forward for one minion: only onto ground with no enemy champion near it
-- (walls and enemy turrets are refused by the plan itself).
function YoneChampion:QuietLanding(r)
 if not r.data.q3 then return true end;local landing=myHero.pos:Extended(r.position,profile.q3Dash)
 return GetEnemyCount(600,landing)==0 and GetEnemyCount(600,myHero.pos:Extended(r.position,profile.q3Dash*.5))==0
end
function YoneChampion:Farm(kind,node,context,rescue,stack)
 local state=self:QState();local q=node.Q:Value()and self:Ready(_Q)and(state.stage~=3 or node.Q3:Value());local w=not stack and node.W:Value()and self:Ready(_W)
 local wave=kind=='lane'and not rescue and not stack
 -- On a wave Q3 is kept while a visible enemy champion is within its reach plus the dash.
 if wave and q and state.stage==3 and #self:Rows('enemy',1400)>0 then q=false end
 -- On a wave Q1 needs one minion (it builds Q3); the count applies to Q3 and W.
 local function need(slot)return(slot==_Q and state.stage~=3)and 1 or Menu.Clear.LaneClear.Count:Value()end
 if not q and not w then return false end;local rows=self:Rows(kind,950);if #rows==0 then return false end;local start=self.farmIndex[kind]or 1;if start>#rows then start=1 end;self.farmIndex[kind]=(start+math.min(6,#rows)-1)%#rows+1
 for _,slot in ipairs({_Q,_W})do if(slot==_Q and q or slot==_W and w)then local best,score
  for n=1,math.min(6,#rows)do local u=rows[(start+n-2)%#rows+1];if not rescue or self:CSUseful(u,slot)then local plan=self:Plan(slot,u,false)
   if plan then local shape=self:Geometry(slot,plan.position,kind,plan.data.spell);local count=shape and shape.count or 0
    if(rescue and count==1 and self:QuietLanding(plan)or not rescue and(kind~='lane'or stack or count>=need(slot)))and(not best or count>score)then best,score=u,count end
   end
  end end
  if best and self:Cast(slot,best,context,function()return(not stack or node.Stack:Value())and node[slot==_Q and'Q'or'W']:Value()and(slot~=_Q or self:QState().stage~=3 or node.Q3:Value())and(not rescue or self:CSUseful(best,slot))end,false,nil,
   function(r)local shape=self:Geometry(slot,r.position,kind,r.data.spell);return shape and(rescue and shape.count==1 and self:QuietLanding(r)or not rescue and(kind~='lane'or stack or shape.count>=need(slot)))
    and(not wave or slot~=_Q or self:QState().stage~=3 or #self:Rows('enemy',1400)==0)end)then return true end
 end end;return false
end
-- A target that cannot leave the line during R's 0.75 s cast: one carrying the Q3 knock-up (buff name lead), or
-- any hard crowd control read from the buff type with enough of it left that walking out is impossible.
function YoneChampion:Pinned(u)
 if not self:Current(u)or u.type~=Obj_AI_Hero then return false end
 if Core:OwnBuff(u,profile.q3Knockup)then return true end
 return Core:Fresh(GetHardCCDuration,u)>=.35
end
-- Kills without a mode key: Q (Q3 only with a safe landing, like every offensive dash) and W.
function YoneChampion:Finisher()
 if not Menu.Misc.Finish:Value()then return false end
 for _,slot in ipairs({_Q,_W})do if self:Ready(slot)then local spell=self:Spell(slot)
  if spell then for _,u in ipairs(self:Rows('enemy',spell.Range))do
   local function kills()local s=self:Spell(slot);if not s or not Menu.Misc.Finish:Value()then return false end
    return(Core:Lethal(u,s.Delay+(s.Speed==math.huge and 0 or GetDistance(u.pos,myHero.pos)/s.Speed),function()return self:Damage(u,slot)end,slot==_Q and{kind='physical'}or nil))
   end
   if kills()and self:Cast(slot,u,{},kills,true)then return true end
  end end
 end end;return false
end
-- An enemy dashing onto Yone is met with Q3 aimed at the end of the dash: the knock-up stops the follow-up
-- and sets up R. Q3 carries Yone 450 along that line, so the landing passes the usual dash limits.
function YoneChampion:AntiDash()
 if not Menu.Misc.DashQ3:Value()or not self:Ready(_Q)or self:QState().stage~=3 then return false end
 for _,u in ipairs(self:Rows('enemy',950))do local snap=self:Allowed(u)and Core:ApproachingDash(u,myHero.pos,350)
  local to=snap and point(snap.to)
  if to and GetDistance(to,myHero.pos)>=10 then local handle=u.handle
   local function plan()
    local fresh=u.handle==handle and Core:ApproachingDash(u,myHero.pos,350);local now=fresh and point(fresh.to)
    if not now or GetDistance(now,to)>60 or GetDistance(now,myHero.pos)<10 then return nil end
    local aim=myHero.pos:Extended(now,profile.q3Dash);return self:PathSafe(aim,true)and{position=aim}or nil
   end
   local first=plan()
   if first and Core:Cast(HK_Q,first.position,{context={priority='critical'},range=profile.q3Dash,prevalidateWorldCast=true,resolve=plan,
    observe=function(q)return self:Observe(q,profile.q3)end,
    validate=function(_,r)return Menu.Misc.DashQ3:Value()and self:Ready(_Q)and self:QState().stage==3 and self:Current(u)and self:Allowed(u)
     and r and point(r.position)and math.abs(GetDistance(r.position,myHero.pos)-profile.q3Dash)<.5 and plan()~=nil and self:PathSafe(r.position,true)end})then return true end
  end
 end;return false
end
-- Physical and magical parts of one cast (post-mitigation); Q is physical, W and R half and half.
function YoneChampion:DamageSplit(u,slot)
 if slot==_Q then return self:Damage(u,_Q),0 end
 local rank=myHero:GetSpellData(slot).level;if not finite(myHero.totalDamage)or not finite(u.maxHealth)then return 0,0 end
 local bonus=finite(myHero.bonusDamage)and math.max(0,myHero.bonusDamage)or 0
 local raw=slot==_W and profile.wBase[rank]and(profile.wBase[rank]+profile.wHealth[rank]*u.maxHealth)or slot==_R and profile.rBase[rank]and(profile.rBase[rank]+profile.rBonusAD*bonus)
 if not raw then return 0,0 end
 local d=_G.SDK.Damage;return d:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw*.5),d:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,raw*.5)
end
-- Ready damage within `window` seconds: R when `withR` and ready, one Q when ready (a second one only when its
-- cooldown at the current attack speed fits), W when ready, and the attacks the window holds (the weaker blade).
function YoneChampion:Burst(u,window,withR)
 local physical,magical=0,0
 local function add(slot)local p,m=self:DamageSplit(u,slot);physical=physical+p;magical=magical+m end
 if withR and self:Ready(_R)then add(_R)end
 if self:Ready(_Q)then add(_Q);local cd=myHero:GetSpellData(_Q).cd;local cast=self:Timing(_Q)
  if finite(cd)and cd>0 and cast and cd+cast<=window then add(_Q)end
 end
 if self:Ready(_W)then add(_W)end
 local animation=_G.SDK.Attack and _G.SDK.Attack:GetAnimation()
 if finite(animation)and animation>0 then physical=physical+math.min(8,math.floor(window/animation))*self.rescue.attackDamage(u)end
 return physical,magical
end
-- Engagement gate, not a guaranteed kill: R may go on one champion it holds in place, or one the ready follow-up
-- kills over the knock-up and the R cast (both shield pools and regeneration through the shared health window).
function YoneChampion:RNeed(u)
 if self:Pinned(u)then return 1 end
 local physical,magical=self:Burst(u,1.5,true)
 local row=Core:MixedHealthEstimate(u,1.5,physical,magical)
 return row and row.lethal==true and 1 or Menu.Combo.Count:Value()
end
-- Spell shields and parries: a non-lethal Q3, W or R into one is wasted, and a parried knock-up stuns Yone.
local guardNames={fioraw=true,pantheone=true}
function YoneChampion:Guarded(u)
 if not u or u.type~=Obj_AI_Hero then return false end
 if Core:SpellShielded(u)==true then return true end
 local count=u.buffCount;if not finite(count)or count<0 or count>128 or count%1~=0 then return false end
 for i=0,count do local b=u:GetBuff(i)
  if b and type(b.name)=='string'and guardNames[b.name:lower()]and(not finite(b.count)or b.count>0)then
   local e=expiry(b);if not finite(e)or e>Game.Timer()then return true end
  end
 end;return false
end
-- E as a kill amplifier (gap Yone-1): the burst Yone can deal in the spirit time does not kill, but with the return
-- (its share of the damage that is not absorbed by shields) it does.
function YoneChampion:ReturnKill(u,withR)
 if not self:Current(u)or not finite(u.health)then return false end
 local share=profile.eStore[myHero:GetSpellData(_E).level];if not share then return false end
 local physical,magical=self:Burst(u,4,withR);local burst=physical+magical
 local shields=(finite(u.shieldAD)and u.shieldAD or 0)+(finite(u.shieldAP)and u.shieldAP or 0)
 local pool=u.health+shields+(finite(u.hpRegen)and math.max(0,u.hpRegen)or 0)*4
 return burst<pool and burst+share*math.max(0,burst-shields)>=pool
end
-- R without a mode key on a champion it kills (mixed damage at the 0.75 s cast, both shield pools), with the
-- per-enemy consent and the landing limits of every offensive dash.
function YoneChampion:RKills(u)
 if not self:Current(u)or Core:SpellProtected(u)~=false then return false end
 local physical,magical=self:DamageSplit(u,_R)
 local row=Core:MixedHealthEstimate(u,.75,physical,magical);return row~=nil and row.lethal==true
end
function YoneChampion:RFinish()
 if not Menu.Misc.RFinish:Value()or not self:Ready(_R)then return false end
 for _,u in ipairs(self:Rows('enemy',1000))do
  if self:Allowed(u)and self:RKills(u)and self:Cast(_R,u,{priority='interactive',condition=function()return Menu.Misc.RFinish:Value()end},
   function()return Menu.Misc.RFinish:Value()and self:RKills(u)end,true,1)then return true end
 end;return false
end
-- Q3 without a mode key on a champion held by crowd control or channelling past Q3's cast and travel.
function YoneChampion:HeldQ3()
 if not Menu.Misc.HeldQ3:Value()or not self:Ready(_Q)or self:QState().stage~=3 then return false end
 local cast=self:Timing(_Q);if not cast then return false end
 local rows=Core:ZoneTargets({range=950,arm=cast+.05,lifetime=3,arrivals=false})
 for _,row in ipairs(rows)do local u=row.unit
  if u and(row.kind=='control'or row.kind=='channel')and self:Current(u)and self:Allowed(u)and not self:Guarded(u)
   and row.freeAt>Game.Timer()+cast+GetDistance(u.pos,myHero.pos)/1500 then
   local function permission()return Menu.Misc.HeldQ3:Value()and row.valid()and row.freeAt>Game.Timer()+(self:Timing(_Q)or 1)+GetDistance(u.pos,myHero.pos)/1500 end
   if self:Cast(_Q,u,{priority='interactive',condition=function()return Menu.Misc.HeldQ3:Value()end},permission,true)then return true end
  end
 end;return false
end
-- The W shield aim: the nearest enemy champion whose position at the end of the longest cast is within 450 (deep in
-- the 600 cone), or nil.
function YoneChampion:ShieldAim()
 local best,distance
 for _,u in ipairs(self:Rows('enemy',700))do local p=self:Forecast(u,profile.wCastLong,true)
  local d=p and GetDistance(p,myHero.pos);if d and d>=1 and d<=450 and(not distance or d<distance)then best,distance=p,d end
 end;return best
end
-- An attack or turret shot about to land on Yone that deals at least her health and shields.
function YoneChampion:LethalThreat()
 local t=Core:AllyThreat(myHero,.75,{casts=false,skillshots=false});local s=t and t.source
 if not s or(t.kind~='attack'and t.kind~='turret')or not finite(s.totalDamage)then return false end
 local damage=_G.SDK.Damage:CalculateDamage(s,myHero,_G.SDK.DAMAGE_TYPE_PHYSICAL,s.totalDamage)
 return finite(damage)and damage>=myHero.health+(finite(myHero.shieldAD)and myHero.shieldAD or 0)
end
-- Development evidence: champions knocked up by Q3 with their distance from the cast origin (Q3 reach 950 or 1050),
-- and a Flash during the Q3 dash (whether it moves the knock-up line).
function YoneChampion:TraceQ3()
 local h=self.q3Hits;local now=Game.Timer()
 if h and now-h.started<=1.25 and h.origin then
  for _,u in ipairs(self:Rows('enemy',1500))do local b=Core:OwnBuff(u,profile.q3Knockup)
   if b and not h.seen[id(u)]and finite(b.startTime)and b.startTime>=h.started then h.seen[id(u)]=true
    Core:Trace('yone_q3_hit',{distance=GetDistance(u.pos,h.origin),bounding=u.boundingRadius,flash=h.flashAt and h.flashAt-h.started or nil})
   end
  end
 elseif h then self.q3Hits=nil end
 for slot=4,5 do local d=myHero:GetSpellData(slot)
  if d and type(d.name)=='string'and d.name:find('Flash',1,true)and finite(d.currentCd)then
   local old=self.flashCd and self.flashCd[slot]
   if old==0 and d.currentCd>0 and h and now-h.started<=.6 and not h.flashAt then h.flashAt=now
    Core:Trace('yone_q3_flash',{sinceQ3=now-h.started,dashing=myHero.pathing and myHero.pathing.isDashing==true})
   end
   self.flashCd=self.flashCd or {};self.flashCd[slot]=d.currentCd
  end
 end
end
-- Q3 then Flash (final re-rank flash_combos, 2026-10-10; only while the bind is held). Model, not live verified: a
-- Flash during the Q3 cast and dash carries the knock-up line forward by the Flash distance along the same
-- direction (the DepressiveYone 3.1 form: Q3 range + Flash). Only a champion the plain Q3 cannot reach even on the
-- larger bound (q3ReachUpper) and the conservative reach plus Flash does reach is planned; the Flash lands on a
-- safe point in the Q3 direction and the 450 dash after it must end on safe ground. The recorder (yone_q3_flash,
-- yone_q3_hit) settles the model from play. Returns the plan or nil, reason.
function YoneChampion:Q3FlashPlan(u)
 if not self:Ready(_Q)or self:QState().stage~=3 or not self:Current(u)or u.type~=Obj_AI_Hero or not self:Allowed(u)or self:Guarded(u)then return nil,'q3'end
 local status,why=Core:FlashStatus();if not status then return nil,why end
 local spell=self:Spell(_Q);if not spell then return nil,'timing'end
 local origin=point(myHero.pos);local p=self:Forecast(u,spell.Delay+GetDistance(u.pos,origin)/spell.Speed,true);if not p then return nil,'target'end
 local d=GetDistance(p,origin);if d<=profile.q3ReachUpper then return nil,'reachable'end
 if d>spell.Range+status.range then return nil,'beyond'end
 local dir=(p-origin)/d;local landing=origin+dir*status.range;local final=landing+dir*profile.q3Dash
 if not self:Safe(landing,true)or not self:Safe(final,true)then return nil,'landing'end
 local wall,_,n=OrbamaPrediction:GetCollision(origin,p,1500,spell.Delay,80,spell.CollisionTypes,id(u));if wall~=false or not finite(n)or n~=0 then return nil,'wall'end
 -- The whirlwind and the dash have fixed lengths: the cast point only gives the direction, so it is the dash
 -- end (a full-range point can sit off screen).
 return {origin=origin,dir=dir,aim=origin+dir*profile.q3Dash,landing=landing,range=status.range,distance=d}
end
-- Whether the Flash still adds a champion to the knock-up line cast from plan.origin: still beyond the plain larger
-- bound, within the conservative reach plus the Flash distance, and on the line.
function YoneChampion:Q3FlashUseful(plan,u,handle)
 if not self:Current(u)or u.handle~=handle or not self:Allowed(u)then return false end
 local p=point(u.pos);if not p then return false end
 local along=(p.x-plan.origin.x)*plan.dir.x+(p.z-plan.origin.z)*plan.dir.z
 local lateral=GetDistance(plan.origin+plan.dir*along,p)
 return along>profile.q3ReachUpper and along<=profile.q3Reach+plan.range and lateral<=80
end
function YoneChampion:Q3FlashAssist()
 if not Menu.Misc.Q3Flash:Value()or self.q3Flash:Busy()then return false end
 local u=GetTarget(profile.q3Reach+410);if not u then return false end
 local plan=self:Q3FlashPlan(u);if not plan then return false end
 local handle=u.handle
 local function authorized()return Menu.Misc.Q3Flash:Value()and self:Current(u)and u.handle==handle and self:Allowed(u)end
 local ok=self.q3Flash:Start({order='spell_first',aim=plan.landing,authorized=authorized,ttl=1.2,
  window=(self:Timing(_Q)or profile.q3Cast)+profile.q3Dash/profile.q3DashSpeed,
  valid=function(landing)return self:Safe(landing,true)and self:Q3FlashUseful(plan,u,handle)end,
  follow=function(held)
   return Core:Cast(HK_Q,plan.aim,{owner='YoneQ3Flash',context=held,intentTarget=u,independent=false,range=profile.q3Reach,objectRange=profile.q3Reach+plan.range,
    resolve=function()return {position=plan.aim}end,
    observe=function(q)return self:Observe(q,profile.q3)end,
    validate=function()local fresh=authorized()and self:Q3FlashPlan(u);return fresh and GetDistance(fresh.aim,plan.aim)<=80 and Core:FlashStatus()~=nil end})
  end})
 if ok then Core:Trace('yone_q3_flash_combo',{target=u.charName,distance=plan.distance})end
 return ok==true
end
function YoneChampion:Combat(mode)
 local node=Menu[mode];local context=Core:ModeContext(mode)
 if mode=='Harass'and node.E:Value()and self:TradeReturn(context,node)then return true end
 if mode=='Combo'and Menu.Combo.R:Value()and self:Ready(_R)then local u
  -- A knocked-up or otherwise held champion cannot dodge the 0.75 s cast: it is taken first and needs no count.
  for _,v in ipairs(self:Rows('enemy',1000))do if self:Pinned(v)and self:Allowed(v)and not self:Guarded(v)then u=v;break end end
  local pinned=u~=nil;u=u or GetTarget(1000)
  -- On a held champion R goes out at once: interactive priority, and it waits for no attack started after this.
  local rContext=context;local extra
  if pinned then rContext=Core:ModeContext(mode);rContext.priority='interactive';extra={deferAttackWindup=Core:AttackWindupRemaining()>0}end
  if self:Current(u)and not self:Guarded(u)and self:Cast(_R,u,rContext,function()return Menu.Combo.R:Value()and not self:Guarded(u)end,true,1,
   function(r)local shape=self:Geometry(_R,r.position,'enemy',r.data.spell);return shape and shape.count>=self:RNeed(u)end,extra)then
   if pinned then local b=Core:OwnBuff(u,profile.q3Knockup);local since=b and b.startTime
    Core:AfterCast(HK_R,function()if finite(since)then Core:Trace('yone_q3_r',{latency=Game.Timer()-since})end end)
   end
   return true
  end
 end
 if mode=='Combo'and Menu.Combo.ER:Value()and Menu.Combo.E:Value()and Menu.Combo.R:Value()then local u=GetTarget(1300);local minimum=Menu.Combo.Count:Value()
  if self:Current(u)and GetDistance(u.pos,myHero.pos)>1000 and self:EEnter(u,context,function()return Menu.Combo.ER:Value()and Menu.Combo.E:Value()and Menu.Combo.R:Value()and Menu.Combo.Count:Value()==minimum end,u.pos,true,minimum)then return true end
 end
 local stage=self:QState().stage
 -- E is the way to bring Q3 onto a target out of attack range; without Q3 the spirit time is spent walking.
 if node.E:Value()and node.Q:Value()and node.Q3:Value()and stage==3 and self:Ready(_Q)then local far=GetTarget(1150)
  local function gate()return self:Ready(_Q)and self:QState().stage==3 and self:Current(far)and not _G.SDK.Data:IsInAutoAttackRange(myHero,far)end
  if self:Current(far)and self:EEnter(far,context,function()return node.E:Value()end,far.pos,true,nil,{gate=gate,reach=850})then return true end
 end
 -- E also goes in when the burst kills only with the return (Combo).
 if mode=='Combo'and node.E:Value()then local t=GetTarget(1000);local withR=Menu.Combo.R:Value()
  local function gate()return self:ReturnKill(t,withR and Menu.Combo.R:Value())end
  if self:Current(t)and gate()and self:EEnter(t,context,function()return node.E:Value()end,t.pos,true,nil,{gate=gate})then return true end
 end
 -- Q3 asked for by the player does not refuse a target only the larger reach bound (q3ReachUpper) reaches.
 local u=GetTarget(stage==3 and profile.q3ReachUpper or profile.wRange)
 if self:Current(u)then
  local function castQ()return node.Q:Value()and(self:QState().stage~=3 or node.Q3:Value()and not self:Guarded(u))and self:Cast(_Q,u,context,function()
   return node.Q:Value()and(self:QState().stage~=3 or node.Q3:Value()and not self:Guarded(u))end,true,nil,nil,{upper=true})end
  -- With R ready the knock-up comes before W: W's cast would eat the time R needs on an airborne target.
  local q3First=mode=='Combo'and stage==3 and Menu.Combo.R:Value()and self:Ready(_R)
  if q3First and castQ()then return true end
  if node.W:Value()and not self:Guarded(u)and self:Cast(_W,u,context,function()return node.W:Value()and not self:Guarded(u)end,false)then return true end
  if not q3First and castQ()then return true end
 end
 -- Harass takes a minion an attack would lose (the LastHit rule, under the spell-farm toggle) before stacking Q.
 if mode=='Harass'and Core:SpellFarmEnabled()and self:Farm('lane',Menu.LastHit,Core:RescueContext(Core:ModeContext(mode)),true)then return true end
 if node.Stack:Value()and self:QState().stage==1 then return self:Farm('lane',node,Core:ModeContext(mode),false,true)end;return false
end
-- Harass trade (gap Yone-5): after entering E, return once two own attacks on the marked champion are observed, or
-- once Q and W are spent and no attack is ready.
function YoneChampion:TradeReturn(context,node)
 local p=self:Spirit();if not p then return false end
 local attacks=0;for _,row in pairs(p.ledger)do attacks=math.max(attacks,row.attacks or 0)end
 local spent=not self:Ready(_Q)and not self:Ready(_W)and not _G.SDK.Orbwalker:CanAttack()
 if attacks<2 and not spent then return false end
 return self:Return(context,function()return node.E:Value()and self:Spirit()==p end)
end
function YoneChampion:Combo()return self:Combat('Combo')end
function YoneChampion:Harass()return self:Combat('Harass')end
function YoneChampion:LaneClear()
 if not Core:FarmModeEnabled('lane')or not Menu.Clear.SpellFarm:Value()then return false end
 local function farm()return Menu.Clear.SpellFarm:Value()end
 -- A minion an attack would lose comes first; then the wave.
 return self:Farm('lane',Menu.LastHit,Core:RescueContext(Core:FarmContext('lane',farm)),true)or self:Farm('lane',Menu.Clear.LaneClear,Core:FarmContext('lane',farm),false)
end
function YoneChampion:JungleClear()return Core:FarmModeEnabled('jungle')and Menu.Clear.SpellFarm:Value()and self:Farm('jungle',Menu.Clear.JungleClear,Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end),false)or false end
function YoneChampion:LastHit()return self:Farm('lane',Menu.LastHit,Core:RescueContext(),true)end
function YoneChampion:QFlee()
 if not Menu.Misc.FleeQ3:Value()or not self:Ready(_Q)or self:QState().stage~=3 or not point(mousePos)or GetDistance(mousePos,myHero.pos)<10 then return false end
 local aim=myHero.pos:Extended(mousePos,450);if not self:PathSafe(aim,false)then return false end
 return Core:Cast(HK_Q,aim,{context=Core:ModeContext('Flee'),range=450,prevalidateWorldCast=true,observe=function(q)return self:Observe(q,profile.q3)end,
  resolve=function()return point(mousePos)and GetDistance(mousePos,myHero.pos)>=10 and {position=myHero.pos:Extended(mousePos,450)}or nil end,
  validate=function(_,r)return Menu.Misc.FleeQ3:Value()and self:Ready(_Q)and self:QState().stage==3 and r and point(r.position)and math.abs(GetDistance(r.position,myHero.pos)-450)<.5 and self:PathSafe(r.position,false)end})
end
function YoneChampion:Flee()
 local function usefulReturn()local p=self:Spirit();return p and(GetEnemyCount(600,p.anchor)<GetEnemyCount(600,myHero.pos)
  or point(mousePos)and GetDistance(p.anchor,mousePos)+100<GetDistance(myHero.pos,mousePos))end
 if usefulReturn()and self:Return(Core:ModeContext('Flee'),usefulReturn)then return true end
 if self:QFlee()then return true end
 if Menu.Misc.FleeE:Value()and self:EEnter(nil,Core:ModeContext('Flee'),function()return Menu.Misc.FleeE:Value()end,mousePos,false)then return true end
 local u=GetTarget(profile.wRange);return Menu.Misc.FleeW:Value()and self:Current(u)and self:Cast(_W,u,Core:ModeContext('Flee'),function()return Menu.Misc.FleeW:Value()end,false)or false
end
function YoneChampion:Assist()
 if not Menu.Misc.RAssist:Value()then return false end
 local u=GetTarget(1000);return self:Current(u)and self:Cast(_R,u,Core:HeldContext(function()return Menu.Misc.RAssist:Value()end),function()return Menu.Misc.RAssist:Value()end,true,1)or false
end
function YoneChampion:PreparePreview()
 -- No Q-stage, stack or E-timer text (the game shows them) and no kill mark (the health bars carry it). Kept for
 -- a second so a late preparation never blinks; the E spot and marks end with the spirit's own expiry.
 self:ObserveTornado();local state=self:QState();local p=self:Spirit();local marks={}
 if p then for _,row in pairs(p.ledger)do if row.expires>Game.Timer()then
  marks[#marks+1]={unit=row.target,handle=row.handle,stored=self:Stored(row),kills=self:ReturnKills(row)}end end end
 self.preview={expires=Game.Timer()+1,qrange=state.stage==3 and 950 or 450,anchor=p and point(p.anchor),spiritEnds=p and p.expires,tornado=self.tornado and point(self.tornado.object.pos),
  ready={q=self:Ready(_Q),w=self:Ready(_W),r=self:Ready(_R)},marks=marks}
end
function YoneChampion:Tick()
 if ShouldWait()or not Core:Available()then self.entry=nil;self.preview=nil;if self.q3Flash then self.q3Flash:Cancel('unavailable')end;return end
 if Game.Timer()>=(self.nextDiscovery or 0)then self:Discover()end;self:ObserveSpirit();self:TraceQ3();self:TraceDetonation()
 if self.q3Flash:Maintain()then return end
 if IsCasting()then return end
 if self:ContinueEntry()or self:Execute()or self:AutoReturn()or self:Assist()or self:Q3FlashAssist()or self:AntiDash()or self:Finisher()or self:RFinish()or self:HeldQ3()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LaneClear'then if not self:LaneClear()then self:JungleClear()end elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and Menu.Draw.Preview:Value()and Game.Timer()>=(self.nextPreview or 0)then self.nextPreview=Game.Timer()+.15;self:PreparePreview()end
end
function YoneChampion:Draw()
 if myHero.dead then return end;local p=self.preview;if not p or p.expires<=Game.Timer()then return end
 -- Ranges only for abilities that were ready when the preview was prepared.
 if Menu.Draw.Ranges:Value()then local ready=p.ready or {q=true,w=true,r=true}
  for _,row in ipairs({{ready.q,p.qrange},{ready.w,profile.wRange},{ready.r,1000}})do if row[1]then Draw.Circle(myHero.pos,row[2],1,Draw.Color(255,170,180,250))end end
 end
 local spirit=p.spiritEnds and p.spiritEnds>Game.Timer()
 if Menu.Draw.Preview:Value()then if p.anchor and spirit then Draw.Circle(p.anchor,60,1,Draw.Color(255,80,180,250))end;if p.tornado and self.tornado then Draw.Circle(p.tornado,40,1,Draw.Color(255,220,220,255))end
  for _,m in ipairs(spirit and p.marks or {})do local u=m.unit
   if u and u.handle==m.handle and not u.dead and point(u.pos)then local s=u.pos:To2D()
    Draw.Text(m.kills and 'RETURN KILLS'or string.format('stored %d',math.floor(m.stored)),14,s.x,s.y-45,m.kills and Draw.Color(255,255,60,60)or Draw.Color(255,200,200,240))
   end
  end
 end
end
function YoneChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Yone: modes','Yone: spirit'},function(page)return{title='Yone assistance',cards=page==1 and{
  {'MODES','Provider Combo, Harass, separate Lane/Jungle, LastHit and Flee. Q3 is on in Combo within the dash limits (health, enemy count, turret); E goes only when Q3 is ready and the target is out of attack range. R is cast at once on a knocked-up or otherwise held champion, else on the enemy count or a burst kill. Without a mode key Q and W finish killable enemies and Q3 meets an enemy dashing onto you. LastHit Q3 only rescues a minion and only with no enemy champion near the landing; Harass and LaneClear rescue first. On a wave Q1 builds the stack on any minion and Q3 is kept while an enemy champion is near. Q3, W and R skip spell shields and parries unless they kill.'},
  {'TIMING','Q and W use constant-work, capped attack-speed cast times. Native Q3 stage selects a 450 dash plus 950 wind projectile; W reaches 600. Delayed stage or attack-speed changes refresh or reject the intent.'},
  {'ASSIST','The R bind casts R at the selected target. Combo E-R extension has a separate switch and waits for an observed completed E dash before refreshing R. R lands behind the last champion on its current outgoing line.'}}or{
  {'RETURN','Flee returns to your E anchor when that is safer. Automatic early return at low health has its own switch. Native origin, owned state, lockout, expiry and safe return ground must remain known.'},
  {'MARKS','Only current owned champion marks enter the ledger. Each own completed attack or ability on a marked champion opens a short window; health that champion loses inside it counts up to the damage of that event, and the stored share of it executes with the E return under Finish. Health lost to anyone else, or absorbed by shields, never counts. Combo also enters E when the burst kills only with the return; Harass returns after two attacks.'},
  {'SAFETY','E return does not cleanse crowd control; automatic return also answers an attack or turret shot that would kill. E Flee is a temporary dash with forced return. W is offered to Evade as a shield with its lower bound, only while an enemy champion stands deep in the cone.'}}}end)
end
Core:StandardPolicy(YoneChampion,{damageTypes={Q='physical'}})
YoneChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={}
local normalSupported={["Yone"]=true}

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
