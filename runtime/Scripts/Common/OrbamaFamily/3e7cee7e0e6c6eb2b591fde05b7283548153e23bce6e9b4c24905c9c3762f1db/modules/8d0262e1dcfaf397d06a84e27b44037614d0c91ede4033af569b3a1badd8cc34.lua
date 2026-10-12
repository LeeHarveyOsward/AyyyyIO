return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Graves"]=function()return _G.OrbamaFamily:Require("7872519c7a6fbf0ce6863be6ab04bf767678191bf4764c01ead7181830ee869f")()end
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
if champion=="Graves" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Graves',profiles={normal=true,classic=true},
 Create=function(context)
-- Independently implemented decisions. Mechanics witnesses and conflicts are in
-- CombatProfiles/graves-provenance.json. Projected impacts never become hits.
local profiles=ChampionProfiles('Graves')
local finite,id,point=Core.finite,Core.id,Core.point
local spellOnly={attack=false} -- Core:Rescue: the attack is weighed here, by the rule this champion's regressions pin
local function cleanup(self)
 if self.burst then local plan=self.burst;self.burst=nil;Core:Cancel('Graves.Burst','controller_closed');if plan.group then Core.adapter:CancelGroup(plan.group,'controller_closed')end end
 self.preview=nil;self.attackWitness=nil;self.dash=nil;self.lastDash=nil;self.state=nil;self.assistRActive=nil;self.empty=nil;self.shellOneAt=nil;self.shellTwoAt=nil
end
local function ray(origin,aim,p)
 local dx,dz=aim.x-origin.x,aim.z-origin.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<1 then return nil end;dx,dz=dx/length,dz/length
 local x,z=p.x-origin.x,p.z-origin.z;return x*dx+z*dz,math.abs(x*dz-z*dx),dx,dz
end
local GravesChampion=class("GravesChampion")
function GravesChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self:LoadMenu()
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=self.profile.qDelay,Radius=self.profile.qRadius,Range=self.profile.qRange,Speed=self.profile.qSpeed,Collision=false}
 self.WSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=.25,Radius=self.profile.wRadius,Range=950,Speed=1650,Collision=false}
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=100,Range=1000+self.profile.coneRange,Speed=2100,Collision=false}
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Graves',function()cleanup(self)end)
 local ok,why=Core:RegisterPreparation('Graves.preview',{intervalMs=150,maxDelayMs=500,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.preparation=ok;self.previewFallback=not ok and why=='unsupported'
 -- Graves-9: the wiki gives Quickdraw no cast time and a 275-375 dash to the
 -- point; .25 and full-length landings stay (both conservative for Evade) until
 -- own recorded dashes (graves_dash trace) settle them.
 Core:RegisterMobility({kind='dash',slot=_E,key=HK_E,name=self.profile.e,range=self.profile.eRange,
  speeds={self.profile.eSpeed},castDelays={.25},profile=self.profile.id,label='Quickdraw',source='CombatProfiles/graves-provenance.json',
  allowed=function(p)return not self.dash and(p==nil or self:SafeDash(p))end})
 -- Health-bar damage and KILL marks (shared display): ready Q, W, R and one attack.
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
end
function GravesChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Graves'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu[mode]:MenuElement({id='E',name='Use E after an attack (toward the cursor)',value=true})
  Menu[mode]:MenuElement({id='EngageE',name='Allow E to move closer to the enemy',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 10,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R when it kills',value=true})
 Menu.Combo:MenuElement({id='DashKill',name='Dash in with E when Q and R then kill',value=false})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=kind,name=kind=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[kind]:MenuElement({id='Q',name='Use Q',value=true})
  Menu.Clear[kind]:MenuElement({id='E',name='Use E after an attack (toward the cursor)',value=true})
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=40,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions Q must hit',value=3,min=1,max=8,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack would miss',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=40,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='FleeE',name='Flee: E toward the cursor',value=true})
 Menu.Misc:MenuElement({id='FleeW',name='Flee: W on the nearest enemy',value=true})
 Menu.Misc:MenuElement({id='KillR',name='R killable enemies without holding a mode key',value=true})
 Menu.Misc:MenuElement({id='Enemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='GapW',name='W enemies that dash onto you',value=true})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Preview',name='E landing spot',value=true})
end
function GravesChampion:Mana(node)return Core.manaAbove(node:Value())end
function GravesChampion:Ready(slot)
 local letter=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot];local s=myHero:GetSpellData(slot)
 return letter and s and s.name==self.profile[letter]and finite(s.level)and s.level>=1 and s.level<= (slot==_R and 3 or 5)
  and finite(s.mana)and s.mana>=0 and s.mana<=myHero.mana and IsReady(slot)
end
function GravesChampion:Rows(kind,range)return Core:Rows(kind=='heroes'and 'hero'or kind,range)end
function GravesChampion:Current(u)return u~=nil and point(u.pos)~=nil and Core:CurrentUnit(u)end
function GravesChampion:Target(range)
 local selected=_G.SDK.TargetSelector.Selected
 if self:Current(selected)and GetDistance(selected.pos,myHero.pos)<=range then return selected end
 local u=GetTarget(range);return self:Current(u)and u or nil
end
function GravesChampion:OwnedBuff(name,maxCount,buffs)
 if not finite(myHero.buffCount)or myHero.buffCount>128 then return nil end
 for _,b in ipairs(buffs or Core:Fresh(GetBuffs,myHero))do
  local expires=Core.buffExpiry(b)
  local source=b.source;local owner=type(source)=='number'and source or(type(source)=='table'or type(source)=='userdata')and id(source)
  local owned=owner==myHero.networkID or owner==myHero.handle
  if type(source)=='table'or type(source)=='userdata'then
   if source.networkID and source.networkID~=0 and source.networkID~=myHero.networkID then owned=false end
   if source.handle and source.handle~=0 and source.handle~=myHero.handle then owned=false end
  end
  if b.name==name and owned and(not b.sourcenID or b.sourcenID==0 or b.sourcenID==myHero.networkID)
   and(not b.sourceName or b.sourceName==''or b.sourceName==myHero.charName)
   and finite(expires)and expires>Game.Timer()and finite(b.count)and b.count%1==0 and b.count>=1 and b.count<=maxCount then return b,expires end
 end
end
function GravesChampion:State()
 local buffs=finite(myHero.buffCount)and myHero.buffCount<=128 and Core:Fresh(GetBuffs,myHero)or {}
 local grit,expires=self:OwnedBuff(self.profile.grit,self.profile.maxGrit,buffs)
 local state={grit=grit and grit.count or nil,gritExpires=expires,ammo=nil,reload='unknown',classicAS=false}
 if self.profile.id=='normal'then
  -- The readable GoS reference supplies these runtime aliases. Absence is
  -- unknown, never proof of zero shells. No reload completion timer is invented.
  local one=self:OwnedBuff('gravesbasicattackammo1',1,buffs);local two=self:OwnedBuff('gravesbasicattackammo2',1,buffs)
  if one and not two then state.ammo=1;state.reload='loaded'elseif two and not one then state.ammo=2;state.reload='loaded'end
  local now=Game.Timer()
  if one or two then
   if state.ammo==1 then self.shellOneAt=now elseif state.ammo==2 then self.shellTwoAt=now end
   -- A shell buff still showing right after the attack is that attack's own.
   if self.empty and now-self.empty.at>.15 then self.empty=nil end
  -- Graves-1: one shell seen, then an observed attack, then neither shell buff:
  -- empty, on a lease that ends with any shell buff or the full reload (profile).
  elseif self.empty and now-self.empty.at<=self.profile.fullReload+.02 then state.ammo=0;state.reload='spent'
  else self.empty=nil end
 else state.classicAS=self:OwnedBuff(self.profile.eBuff,1,buffs)~=nil end
 self.state=state;return state
end
function GravesChampion:Damage(u,slot,phase,hits)
 if not self:Current(u)then return 0 end;local p=self.profile;local rank=myHero:GetSpellData(slot).level;local raw,kind
 if slot==_Q then
  local base=p.qBase[rank];if not base then return 0 end
  raw=base+p.qAD*myHero.bonusDamage
  if p.id=='classic'then raw=raw*(1+math.max(0,(hits or 1)-1)*p.qPenalty)
  elseif phase=='return'then raw=p.returnBase[rank]+p.returnAD[rank]*myHero.bonusDamage end;kind=_G.SDK.DAMAGE_TYPE_PHYSICAL
 elseif slot==_W then local b=({60,110,160,210,260})[rank];if not b then return 0 end;raw=b+.6*myHero.ap;kind=_G.SDK.DAMAGE_TYPE_MAGICAL
 elseif slot==_R then local b=phase=='cone'and p.rCone or p.rBase;if not b[rank]then return 0 end
  raw=b[rank]+(phase=='cone'and p.rConeAD or p.rAD)*myHero.bonusDamage;kind=_G.SDK.DAMAGE_TYPE_PHYSICAL
 else return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,kind,raw)
end
-- Ready Q, W, R (direct) and one attack: the shared health-bar estimate.
function GravesChampion:ComboDamage(u)
 if not self:Current(u)then return 0 end
 local total=0
 for _,slot in ipairs({_Q,_W,_R})do if self:Ready(slot)then total=total+self:Damage(u,slot)end end
 local ok,aa=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true);if ok and finite(aa)then total=total+aa end
 return total
end
function GravesChampion:GetQDmg(u)return self:Damage(u,_Q)end
function GravesChampion:GetRDmg(u)return self:Damage(u,_R)end
function GravesChampion:Predict(u,settings)
 if not self:Current(u)then return nil end
 local p=Core:Prediction(settings);p:GetPrediction(u,myHero);if not p:CanHit(2)then return nil end
 return point(p.CastPosition),point(p.UnitPosition or u.pos)
end
function GravesChampion:Projected(u,time)
 local p=point(u.pos);if not p then return nil end;local path=u.pathing
 local destination=path and path.endPos
 if path and(path.hasMovePath or path.isDashing)and point(destination)then
  local speed=path.isDashing and path.dashSpeed or u.ms
  if not finite(speed)or speed<=0 then return p end
  return p:Extended(destination,math.min(GetDistance(destination,p),speed*time))
 end;return p
end
function GravesChampion:WallClear(origin,aim,speed,delay,radius,u)
 local wall,_,count=OrbamaPrediction:GetCollision(origin,aim,speed,delay,radius,{OrbamaPrediction.COLLISION_YASUOWALL},id(u))
 return wall~=true and(count or 0)==0
end
function GravesChampion:QHits(aim,u)
 -- Pure geometry over this bounded evaluation's already validated roster.
 if not IsValid(u)or not point(u.pos)then return 0 end;local p=self.profile;local x,y,dx,dz=ray(myHero.pos,aim,u.pos)
 if not x or x<0 or x>p.qRange+(u.boundingRadius or 0)then return 0 end
 if p.id=='normal'then return y<=p.qRadius+(u.boundingRadius or 0)and 1 or 0 end
 local n=0;for _,a in ipairs({-p.qAngle,0,p.qAngle})do
  local angle=a*math.pi/180;local rx,rz=dx*math.cos(angle)-dz*math.sin(angle),dx*math.sin(angle)+dz*math.cos(angle)
  local tx,tz=u.pos.x-myHero.pos.x,u.pos.z-myHero.pos.z;local along,side=tx*rx+tz*rz,math.abs(tx*rz-tz*rx)
  if along>=0 and along<=p.qRange and side<=p.qRadius+(u.boundingRadius or 0)then n=n+1 end
 end;return n
end
function GravesChampion:CastQ(u,context,condition,options)
 if not self:Ready(_Q)or not self:Current(u)or GetDistance(u.pos,myHero.pos)>self.profile.qRange then return false end
 local identity,handle=id(u),u.handle
 options=options or {}
 local function resolve()
  if not Core:Current()or not self:Ready(_Q)or not self:Current(u)or id(u)~=identity or u.handle~=handle or condition and not condition()then return nil end
  local p=self:Predict(u,self.QSpell);if not p then return nil end
  local terrain=self:QTerrain(p,u);if terrain=='blocked'then return nil end
  return {position=p,data={terrain=terrain}}
 end
 local r=resolve();if not r then return false end
 local accepted=Core:Cast(HK_Q,r.position,{context=options.context or context,intentTarget=u,range=self.profile.qRange,prevalidateWorldCast=not options.dependency,deferAttackWindup=true,
  owner=options.owner,group=options.group,dependency=options.dependency,dependencyState=options.dependencyState,independent=options.independent,ttl=options.ttl,
  commitGuard=function()return Core:Current()end,resolve=resolve,
  validate=function(_,fresh)local p=fresh and fresh.position;return self:Ready(_Q)and self:Current(u)and id(u)==identity and u.handle==handle
   and p and(not condition or condition(p))and self:WallClear(myHero.pos,p,self.profile.qSpeed,.25,self.profile.qRadius,u)
   and self:QTerrain(p,u)~='blocked'end})
 if accepted and r.data.terrain=='behind'then Core:Trace('graves_q_terrain_behind',{target=identity,distance=math.floor(GetDistance(u.pos,myHero.pos))})
  -- Outcome of that shell once the detonation has had time (Graves-2): health lost and where the target stood.
  if Core.logger then local aim=point(r.position)
   Core:AfterCast(HK_Q,function()self:Probe('graves_q_terrain_hits',1.6,{aim=aim},{u})end)
  end
 end
 return accepted
end
-- Graves-2 (Normal): the shell stops at terrain. A bounded sample along the
-- outgoing ray (25-unit steps to the Q range, at most 32 reads): 'blocked'
-- when terrain comes before the target, 'behind' when it lies behind it (the
-- early detonation; its damage is not counted until its blast width is
-- measured), 'open' otherwise. Unknown terrain reads as open: only a wall seen
-- in front of the target refuses.
function GravesChampion:QTerrain(aim,u)
 if self.profile.id~='normal'or type(Game.isWall)~='function'or not point(aim)then return 'open'end
 local along=ray(myHero.pos,aim,u.pos);if not along then return 'open'end
 local front=along-(u.boundingRadius or 0)
 local step=25;local count=math.min(32,math.floor(self.profile.qRange/step))
 local origin=myHero.pos;local dx,dz=aim.x-origin.x,aim.z-origin.z;local length=math.sqrt(dx*dx+dz*dz);if length<1 then return 'open'end
 dx,dz=dx/length,dz/length
 for i=1,count do local d=i*self.profile.qRange/count
  local ok,wall=pcall(Game.isWall,Vector(origin.x+dx*d,origin.y,origin.z+dz*d))
  if ok and wall==true then return d<front and 'blocked'or 'behind'end
 end
 return 'open'
end
function GravesChampion:CastW(u,context,condition)
 if not self:Ready(_W)or not self:Current(u)or GetDistance(u.pos,myHero.pos)>950 then return false end
 local identity,handle=id(u),u.handle
 local function resolve()
  if not Core:Current()or not self:Ready(_W)or not self:Current(u)or id(u)~=identity or u.handle~=handle or condition and not condition()then return nil end
  local p=self:Predict(u,self.WSpell);return p and {position=p}or nil
 end
 local r=resolve();if not r then return false end
 return Core:Cast(HK_W,r.position,{context=context,intentTarget=u,range=950,prevalidateWorldCast=true,deferAttackWindup=true,resolve=resolve,
  commitGuard=function()return Core:Current()end,
  validate=function(_,fresh)return self:Ready(_W)and self:Current(u)and id(u)==identity and u.handle==handle and fresh and fresh.position
   and(not condition or condition())and self:WallClear(myHero.pos,fresh.position,1650,.25,self.profile.wRadius,u)end})
end
function GravesChampion:SafeDash(p)
 if not point(p)or not Core:Current()or type(Game.isWall)~='function'then return false end
 local distance=GetDistance(p,myHero.pos);if distance<math.max(50,self.profile.eMin)or distance>self.profile.eRange then return false end
 if IsUnderTurret2(p)or GetEnemyCount(450,p)>Menu.Misc.Enemies:Value()then return false end
 local radius=myHero.boundingRadius or 35
 for i=0,8 do local a=i*math.pi/4;local q=i==8 and p or Vector(p.x+math.cos(a)*radius,p.y,p.z+math.sin(a)*radius)
  local ok,wall=pcall(Game.isWall,q);if not ok or wall~=false then return false end
 end;return true
end
function GravesChampion:DashPoint()
 if not point(mousePos)then return nil end;local d=GetDistance(mousePos,myHero.pos);if d<math.max(50,self.profile.eMin)then return nil end
 local p=myHero.pos:Extended(mousePos,math.min(d,self.profile.eRange));return self:SafeDash(p)and p or nil
end
function GravesChampion:AttackRangeFrom(q,target)
 return GetDistance(q,target.pos)<=myHero.range+myHero.boundingRadius+(target.boundingRadius or 0)
end
-- Graves-5: with a target the cursor landing must keep it in attack range;
-- otherwise up to 8 points on the dash ring that do (and pass the caller's
-- direction rule and the landing safety), the one nearest the cursor.
function GravesChampion:SideLanding(target,condition)
 local cursor=point(mousePos);local best,bestDistance
 local length=self.profile.eRange
 for i=0,7 do local a=i*math.pi/4
  local q=Vector(myHero.pos.x+math.cos(a)*length,myHero.pos.y,myHero.pos.z+math.sin(a)*length)
  if self:AttackRangeFrom(q,target)and(not condition or condition(q))and self:SafeDash(q)then
   local d=cursor and GetDistance(q,cursor)or 0
   if not best or d<bestDistance then best,bestDistance=q,d end
  end
 end
 return best
end
-- at: an explicit landing (the dash in for a kill); with a target the landing
-- must keep it in attack range unless `reach` is false.
function GravesChampion:CastE(context,condition,target,at,reach)
 if not self:Ready(_E)or self.dash then return false end
 local p=at and point(at)or self:DashPoint()
 if target and reach~=false and(not p or condition and not condition(p)or not self:AttackRangeFrom(p,target))then p=self:SideLanding(target,condition)end
 if not p then return false end
 if condition and not condition(p)then return false end
 local anchor=id(target);local handle=target and target.handle;local origin=point(myHero.pos)
 local function valid(fresh)
  local q=fresh and fresh.position or p
  return self:Ready(_E)and(not condition or condition(q))and self:SafeDash(q)
   and(not target or self:Current(target)and id(target)==anchor and target.handle==handle
    and(reach==false or self:AttackRangeFrom(q,target)))
 end
 if not valid()then return false end
 local accepted=Core:Cast(HK_E,p,{context=context,owner='Quickdraw',range=self.profile.eRange,intentTarget=target,independent=false,
  prevalidateWorldCast=true,commitGuard=function()return Core:Current()end,
  resolve=function()return valid()and {position=point(p)}or nil end,validate=function(_,fresh)return valid(fresh)end})
 if accepted and Core.lastIntent then
  local q=Core.lastIntent;local ledger={id=q.id,request=q.requestGameTime,expires=q.requestGameTime+1.5,origin=origin,point=point(p)}
  self.dash=ledger;Core:AfterCast(HK_E,function()if self.dash==ledger then ledger.castObserved=true end end)
 end;return accepted
end
function GravesChampion:MaintainDash()
 local p=self.dash;if not p then return end
 -- The ledger holds the whole tick while it exists. It ends when the request
 -- ended unsent, when the observed cast's dash is over wherever it ended, or,
 -- for a dash not seen, a moment after the cast. It used to need a native cast
 -- and path end point matching the plan and a landing within 100 units of it,
 -- and otherwise (a shortened dash, a refused key) held everything for 1.5 s.
 local path=myHero.pathing;local dashing=path and path.isDashing==true;local r=Core.adapter:Poll(p.id)
 if not p.castObserved and(not r or r.state=='cancelled_before_send')then self.lastDash=p;self.dash=nil;return end
 if p.castObserved then p.castAt=p.castAt or Game.Timer()
  if dashing then p.dashObserved=true;p.dashAt=p.dashAt or Game.Timer()
  elseif p.dashObserved or Game.Timer()-p.castAt>.3 then p.landed=p.dashObserved and GetDistance(myHero.pos,p.point)<100 or nil
   -- Graves-9 dev recorder: requested versus travelled length and cast-to-dash delay.
   Core:Trace('graves_dash',{requested=math.floor(GetDistance(p.origin,p.point)),travelled=math.floor(GetDistance(p.origin,myHero.pos)),
    delay=p.dashAt and p.dashAt-p.castAt or nil,dashed=p.dashObserved==true})
   self.lastDash=p;self.dash=nil;return end
 end
 if Game.Timer()>p.expires then self.lastDash=p;self.dash=nil end
end
function GravesChampion:AttackPermission(u)
 local mode=GetMode()
 if u.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')then return Menu[mode],Core:ModeContext(mode)end
 if u.type==Obj_AI_Minion and Menu.Clear.SpellFarm:Value()then local kind=u.team==300 and 'jungle'or 'lane'
  if Core:FarmModeEnabled(kind)then return Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'],Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)end
 end
end
function GravesChampion:Weave(witness)
 local u=witness and witness.object
 if not u or not self:Current(u)or id(u)~=witness.target or Game.Timer()<witness.at or Game.Timer()-witness.at>.35 then return false end
 local settings,context=self:AttackPermission(u);if not settings or not settings.E:Value()or not self:Mana(settings.Mana)or not self:Ready(_E)then return false end
 local state=self:State();if self.profile.id=='normal'and state.ammo~=1 and state.ammo~=0 then return false end
 if state.classicAS then return false end
 local function directionAllowed(p)
  if u.type~=Obj_AI_Hero then return true end
  if not p then return false end
  return settings.EngageE:Value()or GetDistance(p,u.pos)>=GetDistance(myHero.pos,u.pos)-75
 end
 return self:CastE(context,function(candidate)
  local current=self:State();local setting=self:AttackPermission(u)
  return setting==settings and settings.E:Value()and self:Mana(settings.Mana)and Game.Timer()-witness.at<=.35 and directionAllowed(candidate)
   and(self.profile.id=='classic'and not current.classicAS or current.ammo==1 or current.ammo==0)
 end,u)
end
-- Graves-1 evidence: the attack that followed a seen single shell spent it.
-- Dev recorder: every observed attack lists Graves' own buff names, to settle
-- whether an explicit empty or reload buff exists.
function GravesChampion:NoteAttack(witness)
 if self.profile.id~='normal'then return end
 if self.shellOneAt and finite(witness.startTime)and self.shellOneAt>=witness.startTime-.5 and(not self.shellTwoAt or self.shellTwoAt<self.shellOneAt)then
  self.empty={at=witness.at};self.shellOneAt=nil
 end
 local names={};if finite(myHero.buffCount)and myHero.buffCount<=128 then
  for _,b in ipairs(Core:Fresh(GetBuffs,myHero))do if #names<8 and type(b.name)=='string'and b.name:lower():find('graves',1,true)then names[#names+1]=b.name..':'..tostring(b.count)end end
 end
 Core:Trace('graves_attack_buffs',{names=table.concat(names,','),at=witness.at},250)
end
function GravesChampion:OnPostAttack(args)
 if ShouldWait()or not Core:InputAvailable()then return end
 local witness=Core:AttackWitness(self.attackWitness,args and args.Target)
 if witness and witness~=self.attackWitness then self.attackWitness=witness;self:NoteAttack(witness);return self:Weave(witness)end
end
function GravesChampion:RPlan(u,aim)
 if not self:Current(u)then return nil end
 aim=point(aim);if not aim then aim=self:Predict(u,self.RSpell)end;if not aim then return nil end
 local victim=self:Projected(u,.25+GetDistance(u.pos,myHero.pos)/2100)
 local x,y,dx,dz=ray(myHero.pos,aim,victim);if not x then return nil end
 local terminal=1100;local first
 for _,v in ipairs(self:Rows('heroes',2000))do
  local projected=self:Projected(v,.25+GetDistance(v.pos,myHero.pos)/2100)
  local along,side=ray(myHero.pos,aim,projected)
  if along and along>=0 and along<=1100 and side<=100+(v.boundingRadius or 0)then
   -- Front edge of the first champion's capsule determines explosion origin.
   local contact=math.max(0,along-math.sqrt(math.max(0,(100+(v.boundingRadius or 0))^2-side^2)))
   if contact<terminal then terminal=contact;first=v end
  end
 end
 local blast=Vector(myHero.pos.x+dx*terminal,myHero.pos.y,myHero.pos.z+dz*terminal)
 local phase;if first==u then phase='direct'else
  local forward=(victim.x-blast.x)*dx+(victim.z-blast.z)*dz
  local lateral=math.abs((victim.x-blast.x)*dz-(victim.z-blast.z)*dx)
  if forward>=0 and forward<=self.profile.coneRange and lateral+(u.boundingRadius or 0)<=forward*math.tan(math.pi/12)then phase='cone'end
 end
 if not phase then return nil end
 local castPoint=myHero.pos:Extended(aim,math.min(1000,GetDistance(aim,myHero.pos)))
 if not self:WallClear(myHero.pos,blast,2100,.25,100,u)then return nil end
 -- Recoil is exclusive to the Normal kit. Unknown/walled rear landing refuses
 -- only R; it does not change E consent or assume Classic has modern recoil.
 if self.profile.recoil>0 then
  local back=Vector(myHero.pos.x-dx*self.profile.recoil,myHero.pos.y,myHero.pos.z-dz*self.profile.recoil)
  if type(Game.isWall)~='function'or Game.isWall(back)~=false or IsUnderTurret2(back)then return nil end
  for i=0,7 do local a=i*math.pi/4;local edge=Vector(back.x+math.cos(a)*(myHero.boundingRadius or 35),back.y,back.z+math.sin(a)*(myHero.boundingRadius or 35))
   if Game.isWall(edge)~=false then return nil end
  end
 end
 return {position=castPoint,phase=phase,first=id(first),blast=blast,impact=.25+terminal/2100,damage=self:Damage(u,_R,phase)}
end
function GravesChampion:CastR(u,context,permission,lethal,options)
 if not self:Ready(_R)or not permission()or not self:Current(u)then return false end
 local identity,handle=id(u),u.handle
 local function resolve()
  if not Core:Current()or not self:Ready(_R)or not permission()or not self:Current(u)or id(u)~=identity or u.handle~=handle then return nil end
  local plan=self:RPlan(u);if not plan then return nil end
  if lethal and not self:Kills(u,plan.impact,plan.damage)then return nil end
  return {position=plan.position,data=plan}
 end
 local r=resolve();if not r then return false end
 options=options or {}
 local accepted=Core:Cast(HK_R,r.position,{context=context,intentTarget=u,range=1000,prevalidateWorldCast=not options.dependency,deferAttackWindup=true,resolve=resolve,
  owner=options.owner,group=options.group,dependency=options.dependency,dependencyState=options.dependencyState,independent=options.independent,ttl=options.ttl,
  commitGuard=function()return Core:Current()and permission()end,
  validate=function(_,fresh)
   if not permission()or not self:Ready(_R)or not self:Current(u)or id(u)~=identity or u.handle~=handle or not fresh then return false end
   local plan=self:RPlan(u,fresh.position);return plan and(not lethal or self:Kills(u,plan.impact,plan.damage))
  end})
 if accepted then
  -- Graves-8 dev recorder: where every champion stood relative to the planned
  -- blast when R was seen cast, to settle the cone width (asset 30 vs wiki 60).
  local plan=r.data
  Core:AfterCast(HK_R,function()
   local rows={};local dx,dz=plan.position.x-myHero.pos.x,plan.position.z-myHero.pos.z;local l=math.sqrt(dx*dx+dz*dz)
   if l<1 then return end;dx,dz=dx/l,dz/l
   for _,v in ipairs(self:Rows('heroes',2000))do if #rows<5 then
    local fx,fz=v.pos.x-plan.blast.x,v.pos.z-plan.blast.z
    rows[#rows+1]=string.format('%s:%d:%d',tostring(id(v)),math.floor(fx*dx+fz*dz),math.floor(math.abs(fx*dz-fz*dx)))
   end end
   Core:Trace('graves_r_cone',{phase=plan.phase,first=plan.first,rows=table.concat(rows,',')})
   -- Which of those champions actually lost health (Graves-8): lateral offset against health lost.
   if Core.logger then self:Probe('graves_r_cone_hits',.9,{blast=point(plan.blast),dx=dx,dz=dz},self:Rows('heroes',2000))end
  end)
 end
 return accepted
end
-- The shared kill rule: shields, spell protection, regeneration and the health window, for Q, W and R alike.
function GravesChampion:Kills(u,impact,damage,kind)return(Core:Lethal(u,impact,damage,{kind=kind or 'physical'}))end
function GravesChampion:QKills(u)
 return self:Kills(u,self.profile.qDelay+GetDistance(u.pos,myHero.pos)/self.profile.qSpeed,function()return self:Damage(u,_Q)end)
end
function GravesChampion:WKills(u)
 return self:Kills(u,.25+GetDistance(u.pos,myHero.pos)/1650,function()return self:Damage(u,_W)end,'magical')
end
-- Graves-6 (Normal): with the target in attack range, a loaded shell and an
-- attack ready, Q waits for the attack unless it kills or the target is
-- walking out of range.
function GravesChampion:QWaitsForAttack(u)
 if self.profile.id~='normal'or not _G.SDK.Orbwalker:CanAttack()or not self:AttackRangeFrom(myHero.pos,u)then return false end
 local state=self:State();if not state.ammo or state.ammo<1 then return false end
 if self:QKills(u)then return false end
 local path=u.pathing;local edge=myHero.range+myHero.boundingRadius+(u.boundingRadius or 0)
 if path and path.hasMovePath and point(path.endPos)and GetDistance(path.endPos,myHero.pos)>GetDistance(u.pos,myHero.pos)and GetDistance(u.pos,myHero.pos)>edge-75 then return false end
 return true
end
function GravesChampion:Combat(mode)
 local settings=Menu[mode];if not self:Mana(settings.Mana)then return end
 local context=Core:ModeContext(mode)
 if mode=='Combo'and Menu.Combo.R:Value()and self:DashKill(context)then return true end
 local target=self:Target(950);if not target then return end
 if mode=='Combo'and Menu.Combo.R:Value()and self:Ready(_R)and self:CastR(target,context,function()return Menu.Combo.R:Value()end,true)then return true end
 if mode=='Combo'and Menu.Combo.R:Value()and self:StartBurst(target,context,function()return Menu.Combo.R:Value()and settings.Q:Value()end)then return true end
 if settings.Q:Value()and self:Ready(_Q)and not self:QWaitsForAttack(target)and self:CastQ(target,context,function()return settings.Q:Value()and self:Mana(settings.Mana)and not self:QWaitsForAttack(target)end)then return true end
 if settings.W:Value()and self:Ready(_W)and self:CastW(target,context,function()return settings.W:Value()and self:Mana(settings.Mana)end)then return true end
 return self:Weave(self.attackWitness)
end
function GravesChampion:Combo()return self:Combat('Combo')end
function GravesChampion:Harass()return self:Combat('Harass')end
function GravesChampion:Farm(kind)
 local settings=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear']
 if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()or not self:Mana(settings.Mana)then return end
 if self:Weave(self.attackWitness)then return true end
 if not settings.Q:Value()or not self:Ready(_Q)then return end
 local function dense(u,aim,roster)
  local count=0;for _,v in ipairs(roster or self:Rows(kind,self.profile.qRange))do if self:QHits(aim or u.pos,v)>0 then count=count+1 end end
  return kind=='jungle'or count>=Menu.Clear.LaneClear.Count:Value()
 end
 local roster=self:Rows(kind,self.profile.qRange)
 for i=1,math.min(#roster,12)do local u=roster[i];if dense(u,nil,roster)then
  return self:CastQ(u,Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end),function(aim)
   return settings.Q:Value()and self:Mana(settings.Mana)and dense(u,aim)
  end)
 end end
end
function GravesChampion:LaneClear()return self:Farm('lane')end
function GravesChampion:JungleClear()return self:Farm('jungle')end
function GravesChampion:Rescue(u,aim)
 if not self:Current(u)or u.team==300 or GetDistance(u.pos,myHero.pos)>self.profile.qRange then return false end
 if not Core:Rescue(u,self.profile.qDelay+GetDistance(u.pos,myHero.pos)/self.profile.qSpeed,self:Damage(u,_Q),spellOnly)then return false end
 -- A ready attack in reach always takes the last hit.
 if GetDistance(u.pos,myHero.pos)<=myHero.range+myHero.boundingRadius+(u.boundingRadius or 0)and _G.SDK.Orbwalker:CanAttack()then return false end
 for _,v in ipairs(self:Rows('lane',self.profile.qRange+350))do if id(v)~=id(u)then
  if self.profile.id=='normal'then
   -- Conservative full-path envelope covers the return and terminal T blast,
   -- whose exact native width is still unresolved. Avoid wave-softening CS.
   local along,side=ray(myHero.pos,aim or u.pos,v.pos)
   if along and along>=0 and along<=self.profile.qRange+300 and side<=300+(v.boundingRadius or 0)then return false end
  elseif self:QHits(aim or u.pos,v)>0 then return false end
 end end
 return true
end
function GravesChampion:LastHit()
 if not Menu.LastHit.Q:Value()or not self:Mana(Menu.LastHit.Mana)or not self:Ready(_Q)then return end
 local roster=self:Rows('lane',self.profile.qRange)
 for i=1,math.min(#roster,12)do local u=roster[i];if self:Rescue(u)then
  return self:CastQ(u,Core:RescueContext(),function(aim)return Menu.LastHit.Q:Value()and self:Mana(Menu.LastHit.Mana)and self:Rescue(u,aim)end)
 end end
end
function GravesChampion:Flee()
 if Menu.Misc.FleeE:Value()and self:Ready(_E)and self:CastE(Core:ModeContext('Flee'),function()return GetMode()=='Flee'and Menu.Misc.FleeE:Value()end)then return true end
 if Menu.Misc.FleeW:Value()and self:Ready(_W)then local u=self:Target(600)
  if u then return self:CastW(u,Core:ModeContext('Flee'),function()return Menu.Misc.FleeW:Value()end)end
 end
end
function GravesChampion:Assist()
 if not Menu.Misc.RAssist:Value()then self.assistRActive=nil end
 if Menu.Misc.RAssist:Value()and not self.assistRActive and self:Ready(_R)then local u=self:Target(1000+self.profile.coneRange)
  if u then local ok=self:CastR(u,{held=function()return Menu.Misc.RAssist:Value()end,priority='interactive'},function()return Menu.Misc.RAssist:Value()end,false)
   if ok then self.assistRActive=true end;return ok
  end
 end
end
function GravesChampion:Finish()
 -- A kill with the outgoing Q shot or the smoke costs a short cooldown and needs no switch; it also spares R.
 local context={priority='interactive'}
 if self:Ready(_Q)then for _,u in ipairs(self:Rows('heroes',self.profile.qRange))do
  if self:QKills(u)and self:CastQ(u,context,function()return self:QKills(u)end)then return true end
 end end
 if self:Ready(_W)then for _,u in ipairs(self:Rows('heroes',950))do
  if self:WKills(u)and self:CastW(u,context,function()return self:WKills(u)end)then return true end
 end end
 if not Menu.Misc.KillR:Value()or not self:Ready(_R)then return end
 local function allowed()return Menu.Misc.KillR:Value()end
 for _,u in ipairs(self:Rows('heroes',1000+self.profile.coneRange))do
  if u.health<=self:Damage(u,_R)and self:CastR(u,{priority='interactive'},allowed,true)then return true end
 end
 for _,u in ipairs(self:Rows('heroes',self.profile.qRange))do
  if self:StartBurst(u,nil,allowed)then return true end
 end
end
-- Graves-3: Q then R when only both together kill. Q goes first; R follows in
-- the same owned group once that Q is seen cast, and counts the Q only while it
-- has not visibly landed; it re-asks the kill rule from current health.
function GravesChampion:BurstDamage(u,plan)
 local p=plan or self:RPlan(u);if not p then return nil end
 return p.impact,function()return self:Damage(u,_Q)+p.damage end
end
function GravesChampion:BurstLethal(u)
 if not self:Current(u)or not self:Ready(_Q)or not self:Ready(_R)then return false end
 local q,r=myHero:GetSpellData(_Q).mana or 0,myHero:GetSpellData(_R).mana or 0
 if not finite(q)or not finite(r)or myHero.mana<q+r then return false end
 local plan=self:RPlan(u);if not plan or self:Kills(u,plan.impact,plan.damage)then return false end
 local qImpact=self.profile.qDelay+GetDistance(u.pos,myHero.pos)/self.profile.qSpeed
 if self:QKills(u)then return false end
 return self:Kills(u,math.max(plan.impact,qImpact),function()return self:Damage(u,_Q)+plan.damage end)
end
function GravesChampion:EndBurst(reason)
 local plan=self.burst;if not plan then return end;self.burst=nil
 Core:Cancel('Graves.Burst',reason or 'burst_ended')
 if plan.group then Core.adapter:CancelGroup(plan.group,reason or 'burst_ended')end
end
function GravesChampion:BurstValid(plan)
 return self.burst==plan and Core.adapter:Now()<plan.expires and plan.allowed()and self:Current(plan.target)and id(plan.target)==plan.targetID
end
function GravesChampion:StartBurst(u,context,allowed)
 if self.burst or GetDistance(u.pos,myHero.pos)>self.profile.qRange or not self:BurstLethal(u)then return false end
 local now=Core.adapter:Now();local plan={target=u,targetID=id(u),expires=now+1500,allowed=allowed}
 self.burst=plan
 plan.context={priority=context and context.priority or 'interactive',modes=context and context.modes,mode=context and context.mode,
  combat=context and context.combat,condition=function()return self:BurstValid(plan)and(not context or not context.condition or context.condition())end}
 plan.group=Core.adapter:CreateGroup('Graves.Burst',{expires=plan.expires,context=plan.context,resources={'slot:'.._Q,'slot:'.._R}})
 if not plan.group then self.burst=nil;return false end
 local accepted=self:CastQ(u,plan.context,function()return self:BurstValid(plan)and not plan.qObserved and self:BurstLethal(u)end,
  {owner='Graves.Burst',group=plan.group,context=plan.context,independent=false,ttl=400})
 if not accepted then self:EndBurst('burst_Q_refused');return false end
 plan.qID=Core.lastIntent.id;plan.qIntent=Core.lastIntent
 Core:AfterCast(HK_Q,function()if self.burst==plan then plan.qObserved=true;plan.qHealth=u.health;plan.qDamage=self:Damage(u,_Q)end end)
 Core:Trace('graves_burst',{target=plan.targetID})
 return true
end
function GravesChampion:BurstStep()
 local plan=self.burst
 if not self:BurstValid(plan)then self:EndBurst('burst_context_ended');return false end
 local receipt=Core.adapter:Poll(plan.rID or plan.qID)
 if receipt and(receipt.state=='cancelled_before_send'or receipt.jobCancelled)then self:EndBurst('burst_input_cancelled');return false end
 if not plan.qObserved then
  if receipt and receipt.sentAt and Core:CooldownStarted(plan.qIntent)then plan.spentAt=plan.spentAt or Game.Timer()end
  if plan.spentAt and Game.Timer()-plan.spentAt>.3 then self:EndBurst('burst_Q_unseen')end
  return true
 end
 if plan.rID or not self:Ready(_R)then return true end
 local u=plan.target
 local function lethal()
  if not self:BurstValid(plan)then return false end
  local r=self:RPlan(u);if not r then return false end
  -- The Q in flight counts until the target's health shows it landed.
  local landed=finite(plan.qHealth)and u.health<=plan.qHealth-plan.qDamage*.5
  return self:Kills(u,r.impact,function()return r.damage+(landed and 0 or self:Damage(u,_Q))end)
 end
 if not lethal()then self:EndBurst('burst_R_not_lethal');return false end
 -- The kill premise rides on R's permission, so its resolver and validator re-ask it.
 local ok=self:CastR(u,plan.context,lethal,false,
  {owner='Graves.Burst',group=plan.group,dependency=plan.qID,dependencyState='mechanical',independent=false,ttl=300})
 if ok then
  plan.rID=Core.lastIntent.id
  Core:AfterCast(HK_R,function()if self.burst==plan then self:EndBurst('burst_done')end end)
 end
 return true
end
-- Graves-4 (off by default): E toward an enemy just beyond Q range when Q and
-- R then kill it; the landing must be safe (towers, enemy count, terrain).
function GravesChampion:DashKill(context)
 if not Menu.Combo.DashKill:Value()or not self:Ready(_E)or self.dash then return false end
 local cost=(myHero:GetSpellData(_E).mana or 0)+(myHero:GetSpellData(_Q).mana or 0)+(myHero:GetSpellData(_R).mana or 0)
 if not finite(cost)or myHero.mana<cost then return false end
 for _,u in ipairs(self:Rows('heroes',self.profile.qRange+self.profile.eRange))do
  local d=GetDistance(u.pos,myHero.pos)
  if d>self.profile.qRange and self:BurstLethal(u)then
   local landing=myHero.pos:Extended(u.pos,self.profile.eRange)
   if GetDistance(landing,u.pos)<=self.profile.qRange-50 and self:SafeDash(landing)then
    local ok=self:CastE(context,function()return Menu.Combo.DashKill:Value()and self:Current(u)and self:BurstLethal(u)end,u,landing,false)
    if ok then return true end
   end
  end
 end
 return false
end
function GravesChampion:GapSmoke()
 if not Menu.Misc.GapW:Value()or not self:Ready(_W)then return end
 for _,u in ipairs(self:Rows('heroes',950))do
  if Core:ApproachingDash(u,myHero.pos,300)then
   return self:CastW(u,{priority='interactive'},function()return Menu.Misc.GapW:Value()and Core:ApproachingDash(u,myHero.pos,300)~=nil end)
  end
 end
end
-- Development hit probes: health of at most five units now, traced with their loss `after` seconds later
-- (relative to `frame`: along/lateral offsets from a blast point and direction, or the distance to an aim).
-- At most four open probes; replaced units are skipped.
function GravesChampion:Probe(kind,after,frame,units)
 self.probes=self.probes or {};if #self.probes>=4 then return end
 local rows={}
 for i=1,math.min(#units,5)do local v=units[i]
  if IsValid(v)and finite(v.health)then rows[#rows+1]={unit=v,handle=v.handle,id=id(v),health=v.health}end
 end
 if #rows>0 then self.probes[#self.probes+1]={kind=kind,at=Game.Timer()+after,frame=frame,rows=rows}end
end
function GravesChampion:MaintainProbes()
 local list=self.probes;if not list then return end
 for i=#list,1,-1 do local pr=list[i]
  if Game.Timer()>=pr.at then table.remove(list,i)
   local out={};local f=pr.frame
   for _,row in ipairs(pr.rows)do local v=row.unit
    if v and v.handle==row.handle and finite(v.health)and v.pos then local where
     if f.blast then local fx,fz=v.pos.x-f.blast.x,v.pos.z-f.blast.z;where=string.format('%d:%d',math.floor(fx*f.dx+fz*f.dz),math.floor(math.abs(fx*f.dz-fz*f.dx)))
     elseif f.aim then where=tostring(math.floor(GetDistance(v.pos,f.aim)))end
     out[#out+1]=string.format('%s:%s:%d',tostring(row.id),where or '?',math.floor(row.health-v.health))
    end
   end
   Core:Trace(pr.kind,{rows=table.concat(out,',')})
  end
 end
end
function GravesChampion:Tick()
 if self.probes then self:MaintainProbes()end
 if ShouldWait()or not Core:InputAvailable()then self:EndBurst('burst_unavailable');return end
 if not Menu.Misc.RAssist:Value()then self.assistRActive=nil end
 self:MaintainDash();if self.dash then return end
 if self.burst then self:BurstStep();return end
 if IsCasting()then return end
 if self:Assist()or self:GapSmoke()or self:Finish()then return end
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')then self:LaneClear()end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and(not self.nextPreview or self.nextPreview<=Game.Timer())and Menu.Draw.Preview:Value()then self:PreparePreview()end
end
function GravesChampion:PreparePreview()
 if not Menu.Draw.Preview:Value()or not Core:Current()then self.preview=nil;return end
 -- The E landing only: the game shows shells and True Grit. Kept for a second so a late preparation
 -- never blinks it; Draw needs E ready.
 self.preview={expires=Game.Timer()+1,point=self:Ready(_E)and self:DashPoint()or nil}
 self.nextPreview=Game.Timer()+.15
end
function GravesChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.Ranges:Value()then
  if IsReady(_Q)then Draw.Circle(myHero.pos,self.profile.qRange,1,Draw.Color(255,180,200,255))end
  if IsReady(_W)then Draw.Circle(myHero.pos,950,1,Draw.Color(255,220,180,100))end
  if IsReady(_E)then Draw.Circle(myHero.pos,self.profile.eRange,1,Draw.Color(255,120,255,160))end
  if IsReady(_R)then Draw.Circle(myHero.pos,1000,1,Draw.Color(255,255,120,120));Draw.Circle(myHero.pos,1000+self.profile.coneRange,1,Draw.Color(160,255,120,120))end
 end
 local p=self.preview;if Menu.Draw.Preview:Value()and p and p.expires>=Game.Timer()and p.point and IsReady(_E)then
  Draw.Circle(p.point,50,1,Draw.Color(255,255,220,100))
 end
end
function GravesChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Graves: modes','Graves: profile mechanics'},function(page)
  return {title=page==1 and 'Graves assistance'or 'Separate kits',cards=page==1 and {
   {'COMBAT','Provider Combo/Harass binds control Q/W and attack-linked E. R fires only when it kills, in Combo or on its own; a kill Q or W can take is taken with those first, without a mode key. The R bind casts at the selected target.'},
   {'FARM','Enable spell farming for distinct Lane/Jungle binds. LastHit Q rescues isolated missed CS using confirmed incoming damage.'},
   {'CONTROL','Quickdraw checks current endpoint, enemy counts and towers. Flee uses its own E/W settings. Evade may dash with E when the landing is safe.'}}or {
   {'NORMAL','Owned shell buffs inform attack-linked E. Missing ammo is unknown. Q is not cast when terrain stops the shell before the target; terrain behind the target is noted but its early detonation is not counted as damage. An observed attack that spends the last shell lets E reload.'},
   {'CLASSIC','Buckshot has three rays with reduced additional hits. Quickdraw grants attack speed; True Grit is combat-driven. Modern ammo and recoil are not copied.'},
   {'R','First champion contact sets the cone origin and damage phase. New blockers are rechecked before positioning. A send never proves an explosion, landing or attack reset.'}},
   note='Installed mechanics and offline regression evidence require matching live acceptance. Terrain detonation damage and the R cone width are not counted until measured.'}
 end)
end
Core:StandardPolicy(GravesChampion,{damageTypes={Q='physical',W='magical',R='physical'},methods={
 Assist=function()return {held=function()return Menu.Misc.RAssist:Value()end,priority='interactive'}end,
 GapSmoke=function()return {priority='interactive'}end,Finish=function()return {priority='interactive'}end}})
GravesChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Graves"]="Graves"}
local normalSupported={["Graves"]=true}

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
