return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Fizz"]=function()return _G.OrbamaFamily:Require("ce377f4c5eb8a371fcf30926ba00209ccddf771c1ffe19a290290c9bf72f2467")()end
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
if champion=="Fizz" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Fizz',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent shared controller. Profile evidence: CombatProfiles/fizz-provenance.json.
-- Cast input, native cast, dash and damage are different observations.
local profiles=ChampionProfiles('Fizz')
local finite,id,point=Core.finite,Core.id,Core.point
-- Pinned by this champion's regressions: only a ready, in-range lethal attack keeps the spell (Core:Rescue).
local readyAttack={attack='ready'}
local function clear(self,reason)
 for _,p in ipairs({self.qPlan or false,self.ePlan or false,self.farm or false})do
  if p then for _,key in ipairs({'action','follow'})do if p[key]then Core.adapter:Cancel(p[key],reason or 'sequence_ended')end end end
 end
 self.qPlan=nil;self.ePlan=nil;self.farm=nil;self.attack=nil;self.preview=nil
 Core.adapter:SetBlocked('FizzFarm','attack',false)
end
local FizzChampion=class("FizzChampion")
function FizzChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self:LoadMenu();self.allow=Core:TargetConsent(Menu.Misc.Targets,self);self.consent=self.allow.targets;self:DiscoverTargets()
 self.QRange=550;self.ERange=325;self.RRange=self.profile.rRange
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=40,Range=self.RRange,Speed=self.profile.rSpeed,Collision=true,MaxCollision=0,
  CollisionTypes={OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL}}
 -- Where the target stands when the first hop lands (after the 0.75 s balance; the large 375 landing).
 -- Only its predicted position is read: the cast point is clamped to the hop range here.
 self.ESpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=self.profile.eLanding,Radius=375,Range=math.huge,Speed=math.huge,Collision=false}
 -- Normal: where the target stands when the early second hop slams (small area e2Radius). Delay is set per
 -- read from the hop length; without a known hop speed it is the cast-frame lower bound (profile e2Cast).
 if self.profile.e2Radius then self.E2Spell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=self.profile.e2Cast,Radius=self.profile.e2Radius,Range=math.huge,Speed=math.huge,Collision=false}end
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Fizz',function(reason)clear(self,reason)end)
 local ok,why=Core:RegisterPreparation('Fizz.preview',{intervalMs=125,maxDelayMs=400,units=1,maxUnits=1},function()
  self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.previewFallback=not ok and why=='unsupported'
end
function FizzChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Fizz'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q (dashes through the target)',value=true})
  Menu[mode]:MenuElement({id='W',name='Use W on your attacks',value=true})
  Menu[mode]:MenuElement({id='E',name='Use E to jump onto the target',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='E2',name='Hop again early when the target escapes',value=true,menu=false})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R when the combo can kill',value=true})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  for _,slot in ipairs({'Q','W','E'})do Menu.Clear[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions E must hit',value=3,min=1,max=10,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='W',name='Use W on minions an attack would miss',value=true})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on missed minions (dashes through)',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({type=MENU,id='Targets',name='Enemy champions abilities may target'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='FleeE',name='Flee: E toward the cursor',value=true})
 Menu.Misc:MenuElement({id='FleeQ',name='Flee: Q through an enemy toward the cursor',value=true})
 Menu.Misc:MenuElement({id='Finish',name='Finish killable enemies with Q without a mode key',value=true})
 Menu.Misc:MenuElement({id='HP',name='Never dash in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='Enemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='ReserveE',name='Harass: only Q in while E is ready to escape',value=true,menu=false})
 Menu.Misc:MenuElement({id='RMax',name='Longest R cast distance',value=self.profile.rRange,min=200,max=self.profile.rRange,step=25,menu=false})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Preview',name='Q landing spot',value=true})
end
function FizzChampion:Mana(node)return Core.manaAbove(node:Value())end
function FizzChampion:Rows(kind,range)return Core:Rows(kind,range)end
-- A cheap check for units a caller has already confirmed with Current.
function FizzChampion:Reach(u,range)return IsValid(u)and u.team~=myHero.team and point(u.pos)and GetDistance(u.pos,myHero.pos)<=range end
function FizzChampion:Current(u)return Core:CurrentUnit(u)end
function FizzChampion:DiscoverTargets()self.allow:Refresh()end
function FizzChampion:Allowed(u)return self.allow:Allowed(u)end
function FizzChampion:Buff(u,name)return Core:OwnBuff(u,name,true)end
function FizzChampion:Ready(slot,recast)
 local d=myHero:GetSpellData(slot);local expected=slot==_E and(recast and self.profile.e2 or self.profile.e)or self.profile[({[0]='q',[1]='w',[3]='r'})[slot]]
 if not d or not expected or d.name~=expected or not finite(d.level)or d.level<1 or not finite(d.currentCd)or d.currentCd>0 or Game.CanUseSpell(slot)~=0
  or not finite(d.mana)or d.mana<0 or not finite(myHero.mana)or myHero.mana<d.mana then return false end
 if slot==_W then local b,why=self:Buff(myHero,self.profile.wBuff);if b or why then return false end end
 return true
end
function FizzChampion:Safe(pos,offense)
 if not point(pos)or type(Game.isWall)~='function'or Game.isWall(pos)~=false or IsUnderTurret2(pos)
  or GetEnemyCount(600,pos)>Menu.Misc.Enemies:Value()then return false end
 return not offense or finite(myHero.maxHealth)and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.HP:Value()
end
function FizzChampion:QEndpoint(u)
 if not self:Reach(u,550)or GetDistance(u.pos,myHero.pos)<1 then return nil end
 return myHero.pos:Extended(u.pos,600)
end
function FizzChampion:CastQ(u,context,permission,offense,reserve)
 local landing=self:QEndpoint(u)
 if self.qPlan or self.ePlan or not self:Ready(_Q)or not self:Current(u)or not self:Allowed(u)or not self:Safe(landing,offense)
  or permission and not permission()then return false end
 local function valid()
  local p=self:QEndpoint(u);if not p or not self:Safe(p,offense)or not self:Safe(myHero.pos:Extended(p,300),offense)then return false end
  if reserve and Menu.Misc.ReserveE:Value()then local e=myHero:GetSpellData(_E);local q=myHero:GetSpellData(_Q)
   if not e or not finite(e.mana)or e.mana<0 or not self:Ready(_E)or myHero.mana<e.mana+q.mana then return false end
  end
  return self:Ready(_Q)and self:Current(u)and self:Allowed(u)and(not permission or permission())
 end
 if not valid()then return false end
 local p={target=u,id=id(u),handle=u.handle,origin=point(myHero.pos),context=context,expires=Game.Timer()+1.5};self.qPlan=p
 local ok=Core:Cast(HK_Q,u,{range=550,intentTarget=u,context=context,independent=false,deferAttackWindup=true,
  observe=function(q)local a=Core:NativeCast(q,self.profile.q);return a and(a.target==p.id or a.target==p.handle)end,
  validate=function()return self.qPlan==p and id(u)==p.id and u.handle==p.handle and valid()end})
 if not ok then self.qPlan=nil;return false end
 p.action=Core.lastIntent.id;Core:AfterCast(HK_Q,function()if self.qPlan==p then p.observed=true end end);return true
end
function FizzChampion:ContinueQ()
 local p=self.qPlan;if not p then return false end;local r=Core.adapter:Poll(p.action)
 if not r or r.jobCancelled or r.state=='cancelled_before_send'or r.state=='send_uncertain'or p.expires<=Game.Timer()
  or not Core.adapter:ContextValid({context=p.context},'continuation')or not self:Current(p.target)or id(p.target)~=p.id or p.target.handle~=p.handle then clear(self,'q_ended');return false end
 if p.observed then
  -- The plan only keeps E, W and a second Q from being queued on top of this
  -- dash. It ends when the observed cast's dash is over, wherever it ended, or,
  -- for a dash too short to be seen, a moment after the cast. Requiring a
  -- travelled distance of 480 to 720 held it for 1.5 s whenever the dash was
  -- shortened by terrain, a moving target or an interruption.
  local dashing=myHero.pathing and myHero.pathing.isDashing==true;p.observedAt=p.observedAt or Game.Timer()
  if dashing and GetDistance(myHero.pos,p.origin)>10 then p.dashObserved=true end
  if not dashing and(p.dashObserved or Game.Timer()-p.observedAt>.3)then self.qPlan=nil end
 end
 return true
end
function FizzChampion:HopAim(goal)
 if not point(goal)then return nil end
 local distance=GetDistance(goal,myHero.pos);return distance>325 and myHero.pos:Extended(goal,325)or point(goal)
end
-- E1 on a champion aims at where it will stand when the hop lands; anything else at the goal itself.
function FizzChampion:EGoal(u,goal)
 if u and u.type==Obj_AI_Hero then
  local pred=Core:Prediction(self.ESpell);pred:GetPrediction(u,myHero)
  if pred:CanHit(2)and point(pred.CastPosition)then return point(pred.CastPosition)end
 end
 return goal
end
-- E2 on a champion (Normal): its predicted position when the second hop slams, from Fizz's actual
-- position. An unsure prediction keeps the current position; a predicted spot the small slam cannot reach
-- from a full hop refuses. Classic has no E2 timing data and keeps the current position.
function FizzChampion:E2Goal(u)
 local current=u and point(u.pos);local p=self.profile;local spell=self.E2Spell
 if not current or not spell or u.type~=Obj_AI_Hero then return current end
 local delay=p.e2Cast
 if finite(p.e2Speed)and p.e2Speed>0 then delay=delay+math.floor(math.min(GetDistance(current,myHero.pos),self.ERange)/p.e2Speed*20+.5)/20 end
 spell.Delay=delay;local pred=Core:Prediction(spell);pred:GetPrediction(u,myHero)
 local cast=pred:CanHit(2)and point(pred.CastPosition)
 if not cast then return current end
 if GetDistance(cast,myHero.pos)>self.ERange+p.e2Radius then return nil end
 return cast
end
function FizzChampion:BeginE(goal,u,context,permission,offense)
 goal=self:EGoal(u,goal);local aim=self:HopAim(goal)
 if self.ePlan or self.qPlan or not self:Ready(_E)or not self:Safe(aim,offense)or u and(not self:Current(u)or not self:Allowed(u))or permission and not permission()then return false end
 local p={target=u,id=id(u),handle=u and u.handle,origin=point(myHero.pos),aim=aim,context=context,permission=permission,offense=offense,expires=Game.Timer()+1.5};self.ePlan=p
 local function freshAim()return self:HopAim(u and self:EGoal(u,u.pos)or mousePos)end
 -- The recipient is an anchored planning target, not the ground cast's object.
 -- Its identity is checked in the validator; only the hop point has cast range.
 -- +1: a diagonal aim clamped to exactly 325 rounds a hair beyond it.
 local ok=Core:Cast(HK_E,aim,{range=self.ERange+1,context=context,independent=false,deferAttackWindup=true,prevalidateWorldCast=true,
  resolve=function()local pos=freshAim();return pos and {position=pos}end,
  validate=function(_,r)return self.ePlan==p and self:Ready(_E)and self:Safe(r and r.position or freshAim(),offense)
   and(not u or id(u)==p.id and u.handle==p.handle and self:Current(u)and self:Allowed(u)
    and GetDistance(u.pos,r and r.position or freshAim())<=375)and(not permission or permission())end,
  observe=function(q)return Core:NativeCast(q,self.profile.e)~=nil or Core:NativeCast(q,self.profile.e..'One')~=nil end})
 if not ok then self.ePlan=nil;return false end
 p.action=Core.lastIntent.id;Core:AfterCast(HK_E,function()if self.ePlan==p then p.observed=true;p.observedAt=Game.Timer()end end);return true
end
function FizzChampion:EStage(p)
 return p and p.observed and p.expires>Game.Timer()and self:Ready(_E,true)and myHero.isTargetable==false
end
function FizzChampion:ContinueE()
 local p=self.ePlan;if not p then return false end;local result=Core.adapter:Poll(p.action)
 if not result or result.jobCancelled or result.state=='cancelled_before_send'or result.state=='send_uncertain'or p.expires<=Game.Timer()
  or not Core.adapter:ContextValid({context=p.context},'continuation')or p.permission and not p.permission()
  or p.target and(not self:Current(p.target)or id(p.target)~=p.id or p.target.handle~=p.handle)then clear(self,'e_ended');return false end
 if p.follow then if not Core.pending[HK_E]then self.ePlan=nil end;return true end
 if p.observed and myHero:GetSpellData(_E).name==self.profile.e and myHero.isTargetable==true and not(myHero.pathing and myHero.pathing.isDashing)then
  -- Development recording: cast observation to landing, to settle the hop transport time (profile eLanding).
  if p.observedAt then Core:Trace('fizz_e_landing',{profile=self.profile.id,seconds=Game.Timer()-p.observedAt,second=p.follow~=nil})end
  self.ePlan=nil;return false end
 if not self:EStage(p)then return true end
 local mode=GetMode();local fleeing=mode=='Flee'and Menu.Misc.FleeE:Value()
 local combat=p.target and(mode=='Combo'or mode=='Harass')and Menu[mode].E2:Value()and GetDistance(p.target.pos,myHero.pos)>375
  and GetDistance(p.target.pos,myHero.pos)<=550
 if not fleeing and not combat then return true end
 local u=p.target;local function aim()return self:HopAim(fleeing and mousePos or self:E2Goal(u))end
 -- Early second hop gives up the large slow. Buffer and an elapsed timer alone
 -- cannot authorize it: own E1 observation, native recast and untargetability do.
 local function permitted()return self:EStage(p)and (GetMode()=='Flee'and Menu.Misc.FleeE:Value()
  or u and(GetMode()=='Combo'or GetMode()=='Harass')and Menu[GetMode()].E2:Value()and GetDistance(u.pos,myHero.pos)>375
   and GetDistance(u.pos,myHero.pos)<=550)end
 local pos=aim();if not pos or not self:Safe(pos,p.offense)then return true end
 local ok=Core:Cast(HK_E,pos,{owner='Trickster',context=p.context,range=self.ERange+1,independent=false,prevalidateWorldCast=true,
  resolve=function()local destination=aim();return destination and {position=destination}end,
  validate=function(_,r)return self.ePlan==p and permitted()and self:Safe(r and r.position or aim(),p.offense)
   and(not u or self:Current(u)and id(u)==p.id and u.handle==p.handle)end,
  observe=function(q)return Core:NativeCast(q,self.profile.e2)~=nil end})
 if ok then p.follow=Core.lastIntent.id
  -- Development recording: second-hop observation to landing and its length, to settle the hop speed (profile e2Speed).
  Core:AfterCast(HK_E,function()self.e2Seen={at=Game.Timer(),from=point(myHero.pos)}end)
 end;return true
end
function FizzChampion:TraceE2()
 local s=self.e2Seen;if not s then return end;local elapsed=Game.Timer()-s.at
 if elapsed>1.5 then self.e2Seen=nil;return end
 if elapsed>0 and myHero.isTargetable==true and not(myHero.pathing and myHero.pathing.isDashing)then
  Core:Trace('fizz_e2_landing',{profile=self.profile.id,seconds=elapsed,distance=GetDistance(myHero.pos,s.from)});self.e2Seen=nil
 end
end
function FizzChampion:AttackContext(u)
 local mode=GetMode();local node,context
 if u.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')then node=Menu[mode];context=Core:ModeContext(mode)
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then local kind=u.team==300 and 'jungle'or 'lane'
  if not Core:FarmModeEnabled(kind)then return nil end;node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'];context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 end
 return node and node.W:Value()and self:Mana(node.Mana)and context or nil
end
function FizzChampion:OnPostAttack(args)
 if ShouldWait()or not Core:Available()or self.qPlan or self.ePlan or self.farm then return false end
 local witness=Core:AttackWitness(self.attack,args and args.Target);if not witness or witness==self.attack or witness.at>Game.Timer()then return false end
 self.attack=witness;local u=witness.object;local context=self:AttackContext(u)
 if not context or not self:Ready(_W)or not self:Current(u)or not _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return false end
 return Core:Cast(HK_W,nil,{context=context,intentTarget=u,observe=function(q)return self:ObserveW(q)end,validate=function()
  return self.attack==witness and Game.Timer()-witness.at<=.35 and self:Ready(_W)and self:Current(u)
   and self:AttackContext(u)~=nil and _G.SDK.Data:IsInAutoAttackRange(myHero,u)end})
end
function FizzChampion:ObserveW(q)
 -- W has no cast time, so the host may show no native cast for it. The owned
 -- empowerment appearing after the key (Ready refuses W while it is present) is
 -- the outcome itself; without it the last-hit plan kept attacks blocked until
 -- its 0.9 s expiry.
 return Core:NativeCast(q,self.profile.w)~=nil or q.sentAt~=nil and self:Buff(myHero,self.profile.wBuff)~=nil
end
function FizzChampion:Damage(u,slot)
 local p=self.profile;local rank=myHero:GetSpellData(slot).level
 local bases=slot==_Q and p.qBase or slot==_W and p.wBase or slot==_E and p.eBase or p.rBase
 local ap=slot==_Q and p.qAP or slot==_W and p.wAP or slot==_E and p.eAP or p.rAP
 if not bases[rank]or not finite(myHero.ap)then return 0 end
 local damage=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,bases[rank]+ap*myHero.ap)
 if slot==_Q or slot==_W then
  if not finite(myHero.totalDamage)then return 0 end
  damage=damage+_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)
 end
 return damage
end
function FizzChampion:Bleed(u)
 local b,why=self:Buff(u,self.profile.bleed);if not b then return nil,why end
 local rank=myHero:GetSpellData(_W).level;local base=self.profile.dotBase[rank]
 if not base or not finite(myHero.ap)or not finite(u.maxHealth)or not finite(u.health)then return nil,'bleed_stats_unknown'end
 local raw=base+self.profile.dotAP*myHero.ap
 if self.profile.dotMissing then raw=raw+self.profile.dotMissing[rank]*math.max(0,u.maxHealth-u.health);if u.team==300 then raw=math.min(300,raw)end end
 return {target=id(u),handle=u.handle,ends=Core.buffExpiry(b),rawFullDurationEstimate=raw}
end
function FizzChampion:RContact(u)
 if not self:Ready(_R)or not self:Reach(u,math.min(self.RRange,Menu.Misc.RMax:Value()))or not self:Current(u)or not self:Allowed(u)then return nil end
 local pred=Core:Prediction(self.RSpell);pred:GetPrediction(u,myHero)
 if not pred:CanHit(2)or not point(pred.CastPosition)then return nil end
 -- Collision admission includes champions and projectile walls, never minions.
 -- The same provider binding is refreshed before dispatch; it may not keep a
 -- desired farther recipient once another champion touches the outgoing ray.
 local radius=40+(u.boundingRadius or 0);local destination=pred.UnitPosition or pred.CastPosition
 local dx,dz=pred.CastPosition.x-myHero.pos.x,pred.CastPosition.z-myHero.pos.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<1 then return nil end
 local ux,uz=dx/length,dz/length;local vx,vz=destination.x-myHero.pos.x,destination.z-myHero.pos.z
 local along=vx*ux+vz*uz;local perpendicular=vx*vx+vz*vz-along*along
 if perpendicular>radius*radius then return nil end
 local contact=math.max(0,along-math.sqrt(math.max(0,radius*radius-perpendicular)))
 return {position=pred.CastPosition,distance=contact,target=u,id=id(u),handle=u.handle,expires=Game.Timer()+.25}
end
function FizzChampion:SharkBounds(u)
 local low=self:Damage(u,_R);local t=self.profile.rTiers;return low,t and low*t.large or low
end
-- Normal: the shark tier for a lure that travels `distance` before it attaches (the lower tier inside the band).
function FizzChampion:RTier(distance)
 local t=self.profile.rTiers;if not t or not finite(distance)then return 1 end
 if distance>=t.far+t.band then return t.large end
 if distance>=t.near+t.band then return t.mid end
 return 1
end
function FizzChampion:RDamage(u,contact)return self:Damage(u,_R)*self:RTier(contact and contact.distance)end
function FizzChampion:FeatureStatus()
 return {evadeE={supported=false,reason='SDK.ChampionMobility has no ground-targeted untargetable kind (Normal: untargetable 0.75 s, hop 25-400, wiki 2026-10-08; hop speed unpublished)'},
  eTiming=self.profile.id=='normal'and 'primary_duration_0.75s_transport_onset_unverified'or 'classic_duration_and_transport_onset_unverified',
  normalRTiers=self.profile.rTiered and 'distance_tier_thresholds_not_asset_verified_use_damage_bounds'or 'classic_fixed_damage',
  lastHit='guaranteed_Q_and_W_components_only_no_speculative_bleed_or_item_proc_credit'}
end
function FizzChampion:CastR(u,context,permission)
 local contact=self:RContact(u);if not contact or permission and not permission()then return false end
 return Core:Cast(HK_R,contact.position,{context=context,range=math.min(self.RRange,Menu.Misc.RMax:Value()),intentTarget=u,prevalidateWorldCast=true,deferAttackWindup=true,
  validate=function()return self:Ready(_R)and self:Current(u)and id(u)==contact.id and u.handle==contact.handle and self:Allowed(u)
   and self:Reach(u,math.min(self.RRange,Menu.Misc.RMax:Value()))and(not permission or permission())end})
end
-- What Combo kills without R: each enabled, ready ability whose reach the fight gives (Q 550, E with its
-- second hop 650; W rides an attack, so it needs attack range now or a Q/E that brings Fizz there), plus a
-- ready attack in range when W is not counted (W's damage already holds its attack).
function FizzChampion:NoRDamage(u)
 local d=GetDistance(u.pos,myHero.pos);local inAttack=_G.SDK.Data:IsInAutoAttackRange(myHero,u)
 local q=Menu.Combo.Q:Value()and self:Ready(_Q)and d<=self.QRange;local e=Menu.Combo.E:Value()and self:Ready(_E)and d<=650
 local w=Menu.Combo.W:Value()and self:Ready(_W)and(inAttack or q or e)
 local total=(q and self:Damage(u,_Q)or 0)+(e and self:Damage(u,_E)or 0)+(w and self:Damage(u,_W)or 0)
 if not w and inAttack and _G.SDK.Orbwalker:CanAttack()then total=total+_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)end
 return total
end
-- R is committed in Combo only when the abilities that can follow it finish the target, and not when they
-- already do without it. Normal credits the shark tier of the predicted contact distance.
function FizzChampion:RKills(u)
 local contact=self:RContact(u);if not contact then return false end
 local impact=.25+contact.distance/self.profile.rSpeed+self.profile.rDelay
 local without=self:NoRDamage(u)
 if without>0 and Core:Lethal(u,.5,without)then return false end
 local total=self:RDamage(u,contact)
 for slot,name in pairs({[_Q]='Q',[_W]='W',[_E]='E'})do if Menu.Combo[name]:Value()and self:Ready(slot)then total=total+self:Damage(u,slot)end end
 return(Core:Lethal(u,impact,total))
end
-- Health-bar damage: ready Q, W, E, the small shark when R is ready and one attack.
function FizzChampion:ComboDamage(u)
 local total=_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0
 for _,slot in ipairs({_Q,_W,_E,_R})do if self:Ready(slot)then total=total+self:Damage(u,slot)end end
 return total
end
-- W before the first attack: the champion is inside the empowered attack's reach (Normal profile wReachBonus 50;
-- Classic keeps the earlier +50 here, unverified) and an attack may start now (none winding up). W has no cast
-- time and resets the attack, so that attack carries it.
function FizzChampion:WReach(u)
 return finite(myHero.range)and GetDistance(u.pos,myHero.pos)<=myHero.range+(myHero.boundingRadius or 65)+(u.boundingRadius or 65)+(self.profile.wReachBonus or 50)
end
function FizzChampion:OpenW(u,node,context)
 if not node.W:Value()or not self:Ready(_W)or not self:WReach(u)or not _G.SDK.Orbwalker:CanAttack()or Core:AttackWindupRemaining()>0 then return false end
 local handle=u.handle
 return Core:Cast(HK_W,nil,{context=context,intentTarget=u,observe=function(q)return self:ObserveW(q)end,validate=function()
  return node.W:Value()and self:Mana(node.Mana)and self:Ready(_W)and self:Current(u)and u.handle==handle and self:WReach(u)and _G.SDK.Orbwalker:CanAttack()end})
end
-- Q is the chase tool: while the champion stays in attack range it is kept, unless it kills or it fills a
-- gap (attack on cooldown, W spent).
function FizzChampion:StaysInReach(u)
 if not _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return false end
 local path=u.pathing;if path and path.isDashing then return false end
 if not path or not path.hasMovePath then return true end
 local finish=point(path.endPos);return finish~=nil and GetDistance(finish,myHero.pos)<=myHero.range+(myHero.boundingRadius or 65)+(u.boundingRadius or 65)
end
function FizzChampion:HoldQ(u)
 if not self:StaysInReach(u)or self:QKills(u)then return false end
 local gap=not _G.SDK.Orbwalker:CanAttack()and not self:Ready(_W)and self:Buff(myHero,self.profile.wBuff)==nil
 return not gap
end
function FizzChampion:Combat(mode)
 local node=Menu[mode];if not self:Mana(node.Mana)then return false end
 local q=node.Q:Value()and self:Ready(_Q);local e=node.E:Value()and self:Ready(_E);local r=mode=='Combo'and node.R:Value()and self:Ready(_R)
 local w=node.W:Value()and self:Ready(_W)
 if not q and not e and not r and not w then return false end
 local u=GetTarget(r and self.RRange or 700);if not self:Current(u)then return false end
 local context=Core:ModeContext(mode);local function permitted(slot)return node[slot]:Value()and self:Mana(node.Mana)end
 if r and self:RKills(u)and self:CastR(u,context,function()return permitted('R')and self:RKills(u)end)then return true end
 if w and self:OpenW(u,node,context)then return true end
 if q and not self:HoldQ(u)and self:CastQ(u,context,function()return permitted('Q')and not self:HoldQ(u)end,true,mode=='Harass')then return true end
 if e and self:Reach(u,650)then return self:BeginE(u.pos,u,context,function()return permitted('E')end,true)end
 return false
end
-- A kill is taken without a mode key: Urchin Strike on a champion it kills (the shared kill rule at the
-- health it has when the strike lands). Q dashes through the target, so the dash limits stay in force.
function FizzChampion:QKills(u)return Core:Lethal(u,.3,function()return self:Damage(u,_Q)end)end
function FizzChampion:Finish()
 if not Menu.Misc.Finish:Value()or not self:Ready(_Q)or self.qPlan or self.ePlan then return false end
 local context={priority='interactive',condition=function()return Menu.Misc.Finish:Value()end}
 for _,u in ipairs(self:Rows('hero',550))do
  if self:Allowed(u)and self:QKills(u)and self:CastQ(u,context,function()return Menu.Misc.Finish:Value()and self:QKills(u)end,true)then return true end
 end
 return false
end
function FizzChampion:Combo()return self:Combat('Combo')end
function FizzChampion:Harass()return self:Combat('Harass')end
-- W lands with the attack it empowers, so it needs the minion in that attack's reach: on Normal the
-- empowered attack reaches 50 further (WReach, profile wReachBonus); Classic keeps plain attack range.
function FizzChampion:WInReach(u)
 if self.profile.wReachBonus then return self:WReach(u)end
 return _G.SDK.Data:IsInAutoAttackRange(myHero,u)
end
function FizzChampion:UsefulCS(u,slot)
 -- Cheap prefilter only (400 covers the empowered reach); WInReach is the exact W check.
 if not self:Current(u)or u.team==300 or not self:Reach(u,slot==_Q and 550 or 400)then return false end
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)or windup<0 then return false end
 return Core:Rescue(u,slot==_Q and .4 or windup+.30,function()return self:Damage(u,slot)end,readyAttack)
  and(slot~=_W or self:WInReach(u))
end
function FizzChampion:LastHit()
 if self.farm or not self:Mana(Menu.LastHit.Mana)then return false end
 local w=Menu.LastHit.W:Value()and self:Ready(_W);local q=Menu.LastHit.Q:Value()and self:Ready(_Q)
 if not w and not q then return false end
 local best,slot;for _,u in ipairs(self:Rows('lane',550))do local s=w and self:UsefulCS(u,_W)and _W or q and self:UsefulCS(u,_Q)and _Q
  if s and(not best or u.maxHealth>best.maxHealth)then best=u;slot=s end
 end
 if not best then return false end;local context=Core:RescueContext()
 if slot==_Q then return self:CastQ(best,context,function()return Menu.LastHit.Q:Value()and self:Mana(Menu.LastHit.Mana)and self:UsefulCS(best,_Q)end,false)end
 local p={target=best,id=id(best),handle=best.handle,context=context,expires=Game.Timer()+.9};self.farm=p
 local ok=Core:Cast(HK_W,nil,{owner='LastHit',context=context,intentTarget=best,observe=function(r)return self:ObserveW(r)end,
  validate=function()return self.farm==p and self:Ready(_W)and Menu.LastHit.W:Value()and self:Mana(Menu.LastHit.Mana)and self:UsefulCS(best,_W)end})
 if not ok then self.farm=nil;return false end
 p.action=Core.lastIntent.id;Core.adapter:SetBlocked('FizzFarm','attack',true)
 Core:AfterCast(HK_W,function()if self.farm==p then p.observed=true end end);return true
end
function FizzChampion:ContinueFarm()
 local p=self.farm;if not p then return false end;local r=Core.adapter:Poll(p.action)
 if not r or r.jobCancelled or r.state=='cancelled_before_send'or r.state=='send_uncertain'or p.expires<=Game.Timer()
  or not Core.adapter:ContextValid({context=p.context},'continuation')or not Menu.LastHit.W:Value()or id(p.target)~=p.id or p.target.handle~=p.handle
  or not self:UsefulCS(p.target,_W)then clear(self,'farm_ended');return false end
 if not p.observed or not self:Buff(myHero,self.profile.wBuff)then return true end
 Core.adapter:SetBlocked('FizzFarm','attack',false)
 if p.follow then if not Core.pending['__owned_attack']then self.farm=nil end;return true end
 if not _G.SDK.Orbwalker:CanAttack()then return true end
 local ok=Core:Attack(p.target,{owner='LastHit',context=p.context,validate=function()return self.farm==p and self:Buff(myHero,self.profile.wBuff)~=nil
  and self:Current(p.target)and p.target.handle==p.handle and self:UsefulCS(p.target,_W)end,
  observe=function(q)local a=Core:NativeAttack(q);return a
   and(self.profile.id=='classic'or a.name==self.profile.wAttack)
   and(a.target==p.id or a.target==p.handle)end})
 if ok then p.follow=Core.lastIntent.id end;return true
end
function FizzChampion:Clear(kind)
 if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()then return false end
 local node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'];if not self:Mana(node.Mana)then return false end
 local q=node.Q:Value()and self:Ready(_Q);local e=node.E:Value()and self:Ready(_E)
 if not q and not e then return false end
 local rows=self:Rows(kind,650);local best
 for _,u in ipairs(rows)do if not best or u.maxHealth>best.maxHealth then best=u end end
 if not best then return false end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 local function permitted(slot)return node[slot]:Value()and Menu.Clear.SpellFarm:Value()and self:Mana(node.Mana)end
 if e then local aim=self:HopAim(best.pos);local count=0;for _,u in ipairs(rows)do if GetDistance(u.pos,aim)<=375 then count=count+1 end end
  if kind=='jungle'or count>=node.Count:Value()then return self:BeginE(best.pos,best,context,function()
   if not permitted('E')then return false end;if kind=='jungle'then return true end
   local n=0;local p=self:HopAim(best.pos);for _,u in ipairs(self:Rows(kind,700))do if GetDistance(u.pos,p)<=375 then n=n+1 end end
   return n>=node.Count:Value()end,false)end
 end
 return q and self:CastQ(best,context,function()return permitted('Q')end,false)or false
end
function FizzChampion:LaneClear()return self:Clear('lane')end
function FizzChampion:JungleClear()return self:Clear('jungle')end
function FizzChampion:Flee()
 local context=Core:ModeContext('Flee')
 if Menu.Misc.FleeE:Value()and self:BeginE(mousePos,nil,context,function()return Menu.Misc.FleeE:Value()end,false)then return true end
 if Menu.Misc.FleeQ:Value()and self:Ready(_Q)and point(mousePos)then
  local rows=self:Rows('hero',550);for _,u in ipairs(self:Rows('lane',550))do rows[#rows+1]=u end;for _,u in ipairs(self:Rows('jungle',550))do rows[#rows+1]=u end
  for _,u in ipairs(rows)do local p=self:QEndpoint(u);if p and GetDistance(p,mousePos)+150<GetDistance(myHero.pos,mousePos)then
   if self:CastQ(u,context,function()local endPos=self:QEndpoint(u);return Menu.Misc.FleeQ:Value()and endPos and GetDistance(endPos,mousePos)+150<GetDistance(myHero.pos,mousePos)end,false)then return true end
  end end
 end;return false
end
function FizzChampion:Assist()
 if Menu.Misc.RAssist:Value()and self:Ready(_R)then local u=GetTarget(self.RRange)
  return self:Current(u)and self:CastR(u,Core:HeldContext(function()return Menu.Misc.RAssist:Value()end),function()return Menu.Misc.RAssist:Value()end)or false
 end;return false
end
-- The Q landing on the current target. No W/E/shark text: the game shows them. Kept for a second so a
-- late preparation never blinks it; Draw needs Q ready and the target alive and seen.
function FizzChampion:PreparePreview()
 local u=GetTarget(1600);local p={expires=Game.Timer()+1,profile=self.profile.id}
 if self:Current(u)then p.q=self:QEndpoint(u);p.target=u;p.handle=u.handle end
 self.preview=p
end
function FizzChampion:Tick()
 if ShouldWait()or not Core:Available()then clear(self,'unavailable');return end
 self.allow:Maintain();self:TraceE2()
 if self:ContinueQ()or self:ContinueE()or self:ContinueFarm()then return end
 -- Manual or defensive E retains player ownership. It never becomes an owned
 -- Combo recast merely because its native slot happens to show ETwo.
 local e=myHero:GetSpellData(_E);if e and(e.name==self.profile.e2 or e.name==self.profile.buffer)or IsCasting()then return end
 if self:Assist()or self:Finish()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if self:LaneClear()then return end;self:JungleClear()
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and Menu.Draw.Preview:Value()and Game.Timer()>=(self.nextPreview or 0)then self:PreparePreview();self.nextPreview=Game.Timer()+.125 end
end
function FizzChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.Ranges:Value()then for slot,range in pairs({[_Q]=self.QRange,[_E]=self.ERange,[_R]=self.RRange})do if IsReady(slot)then Draw.Circle(myHero.pos,range,1,Draw.Color(255,100,200,255))end end end
 local p=self.preview;local u=p and p.target
 if Menu.Draw.Preview:Value()and p and p.expires>Game.Timer()and p.q and IsReady(_Q)and u and not u.dead and u.visible~=false and u.handle==p.handle then
  Draw.Circle(p.q,60,1,Draw.Color(255,255,180,100))
 end
end
function FizzChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Fizz: modes','Fizz: assistance'},function(page)return {title='Fizz assistance',cards=page==1 and {
  {'MODES','Use provider Combo, Harass, separate lane/jungle, LastHit and Flee. Combo uses Q, W and E; Q is kept for the chase while the target stays in attack range, unless it kills. R is cast when the combo can kill and the other abilities alone cannot (Normal counts the bigger shark of a long throw). Harass keeps E for the escape.'},
  {'TRIDENT','W goes out as the first attack can start, or follows a real completed attack. Normal has one empowered strike; Classic grants timed on-hit damage and healing reduction. Owned bleed never follows another Fizz.'},
  {'FARM','W rescue observes its own native cast and empowerment before attacking its original minion. Confirmed incoming kills and available lethal attacks keep priority.'}}or {
  {'ASSIST','The R bind casts the shark at the selected target. Flee hops with E toward the cursor and uses the second hop early.'},
  {'LANDING','Q goes through its target. E1 aims where the target will stand when it lands and normally retains its large slowing landing; early E2 trades that for range and a smaller impact. Unsent work ends when its initiating bind is released.'},
  {'FLEE','Flee E advances toward the cursor. Escape Q uses existing enemy units only when it makes safe progress and its option is enabled.'}}}end)
end
Core:StandardPolicy(FizzChampion,{damageTypes={Q='mixed',W='mixed',E='magical',R='magical'},methods={Finish=function()return {priority='interactive'}end},
 costPaid=function(self,q,slot)return slot==_E and self:EStage(self.ePlan)end,
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot,slot==_E and self.ePlan and self.ePlan.observed)end;return true end})
FizzChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Fizz"]="Fizz"}
local normalSupported={["Fizz"]=true}

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
