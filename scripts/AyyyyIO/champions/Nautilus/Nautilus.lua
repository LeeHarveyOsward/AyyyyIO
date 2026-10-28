return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Nautilus"]=function()return _G.OrbamaFamily:Require("8729e6d0494729db4b6f4a22d4d763525582990f6701cf26f0cc4e222a00cf44")()end
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
if champion=="Nautilus" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Nautilus',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent controller. Installed kit evidence and source comparisons are in
-- CombatProfiles/nautilus-provenance.json. Estimated secondary hits are not hits.
local profiles=ChampionProfiles('Nautilus')
for identity,shared in pairs(NautilusProfiles)do
 local p=profiles[identity];if p then for key,value in pairs(shared)do p[key]=value end end
end
local finite,identity,point=Core.finite,Core.id,Core.point
-- Pinned by this champion's regressions: only a ready, in-range lethal attack keeps the spell (Core:Rescue).
local readyAttack={attack='ready'}
local function cleanup(self,reason)
 local p=self.hook;if p and p.action then Core.adapter:Cancel(p.action,reason or 'controller_closed')end
 self.hook=nil;self.attack=nil;self.preview=nil;self.wObserved=nil;self.assistUsed=false
end
local NautilusChampion=class("NautilusChampion")
function NautilusChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self:LoadMenu();self.allow=Core:TargetConsent(Menu.Misc.Targets,self,'Allow Q/R: ');self.consent=self.allow.targets;self:RefreshConsent();self:RegisterShieldDefense()
 local pr=self.profile
 -- Q reach 1122 (wiki, both profiles; the asset display range 1150 overshoots). The hook grabs the first
 -- champion on its way: prediction checks minions and wind walls, CastQ asks for that champion itself.
 self.QRange=pr.qRange;self.ERange=pr.eRange;self.RRange=825
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=pr.qCast,Radius=pr.qRadius,Range=pr.qRange,Speed=pr.qSpeed,Collision=true,MaxCollision=0,
  CollisionTypes={OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_YASUOWALL}}
 -- R is a homing charge: the cast (.46) plus an accelerating travel, see RImpact.
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=pr.rCast,Radius=100,Range=825,Speed=math.huge,Collision=false}
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Nautilus',function(reason)cleanup(self,reason)end)
 local ok,reason=Core:RegisterPreparation('Nautilus.preview',{intervalMs=125,maxDelayMs=500,units=2,maxUnits=2},
  function()self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.previewFallback=not ok and reason=='unsupported'
end
function NautilusChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Nautilus'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu[mode]:MenuElement({id=slot,name=slot=='Q'and 'Use Q (hook, pulls you in)'or 'Use '..slot,value=slot~='Q'or mode=='Combo'})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5,menu=mode=='Harass'})
 end
 Menu.Combo:MenuElement({id='R',name='Use R',value=true})
 Menu.Combo:MenuElement({id='RCount',name='R only when it hits at least this many enemies',value=1,min=1,max=5,step=1})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=kind,name=kind=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  for _,slot in ipairs({'Q','W','E'})do Menu.Clear[kind]:MenuElement({id=slot,name=slot=='Q'and 'Use Q (pulls you in)'or 'Use '..slot,value=true})end
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='ECount',name='Lane minions E must hit',value=2,min=1,max=10,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q (pulls you to the minion)',value=true})
 Menu.LastHit:MenuElement({id='E',name='Use E',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({type=MENU,id='Targets',name='Enemy champions Q and R may target'})
 Menu.Misc:MenuElement({id='QAssist',name='Cast Q at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('U')})
 Menu.Misc:MenuElement({id='QHP',name='Never hook in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='QEnemies',name='Never hook into more enemies than',value=3,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='WHP',name='Shield with W below health %',value=35,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='InterruptQ',name='Interrupt enemy channels with Q while fighting',value=true})
 Menu.Misc:MenuElement({id='InterruptR',name='Interrupt enemy channels with R in Combo',value=true})
 Menu.Misc:MenuElement({id='Finish',name='Finish killable enemies without a mode key',value=true})
 Menu.Misc:MenuElement({id='PeelE',name='Use E on a chaser when fleeing',value=true})
 Menu.Misc:MenuElement({id='PeelR',name='Use R on a chaser when fleeing',value=true})
 Menu.Misc:MenuElement({id='Gapclose',name='Answer enemy dashes onto you',value=true})
 Menu.Misc:MenuElement({id='Peel',name='Protect allies from divers, R only on a low ally',value=true})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Preview',name='R path and how many it would hit',value=true})
end
function NautilusChampion:Rows(kind,range)return Core:Rows(kind,range)end
function NautilusChampion:Current(u)return Core:CurrentUnit(u)end
function NautilusChampion:RefreshConsent()self.allow:Refresh()end
function NautilusChampion:Allowed(u)return self.allow:Allowed(u)end
function NautilusChampion:OwnedBuff(u,name)return Core:OwnBuff(u,name,true)end
function NautilusChampion:PassiveReady(u)
 local b,reason=self:OwnedBuff(u,self.profile.passive)
 return not b and not reason
end
function NautilusChampion:Ready(slot)
 local name=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot];local d=myHero:GetSpellData(slot)
 if not name or not d or d.name~=self.profile[name]or not finite(d.level)or d.level<1 or not finite(d.currentCd)or d.currentCd>0
  or Game.CanUseSpell(slot)~=0 or not finite(d.mana)or d.mana<0 or not finite(myHero.mana)or myHero.mana<0 or d.mana>myHero.mana then return false end
 if slot==_W then local buff,reason=self:OwnedBuff(myHero,self.profile.shield)
  if buff or reason then return false end
 end
 return true
end
function NautilusChampion:GetQDmg(u)
 local base=self.profile.qBase[myHero:GetSpellData(_Q).level];if not base or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.qAP*myHero.ap)
end
function NautilusChampion:GetEDmg(u)
 local base=self.profile.eBase[myHero:GetSpellData(_E).level];if not base or not finite(myHero.ap)then return 0 end
 -- One inner wave only. Additional waves and modern monster bonuses need a
 -- verified wave/impact graph and are never counted as guaranteed farming damage.
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+.5*myHero.ap)
end
function NautilusChampion:GetRDmg(u)
 local base=self.profile.rBase[myHero:GetSpellData(_R).level];if not base or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+.8*myHero.ap)
end
function NautilusChampion:ShieldAmount()
 local rank=myHero:GetSpellData(_W).level;local base=self.profile.shieldBase[rank]
 local health=self.profile.shieldStat=='bonusHealth'and myHero.bonusHealth or myHero.maxHealth
 return base and finite(health)and health>=0 and base+self.profile.shieldHP[rank]*health or 0
end
function NautilusChampion:GetWDmg(u)
 local p=self.profile.id=='classic'and PatchProfiles.Jade_Nautilus
 local rank=myHero:GetSpellData(_W).level;local base=p and p.wDotBase[rank]
 if not base or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+p.wDotAP*myHero.ap)
end
function NautilusChampion:ClearRay(pos)
 if not point(pos)or type(Game.isWall)~='function'then return false end
 local distance=GetDistance(pos,myHero.pos);if distance>self.QRange then return false end
 local steps=math.max(1,math.ceil(distance/25))
 local dx,dz=pos.x-myHero.pos.x,pos.z-myHero.pos.z
 if distance<1 then return Game.isWall(pos)==false end
 for i=0,steps do local p=myHero.pos:Extended(pos,distance*i/steps)
  for _,offset in ipairs({-90,0,90})do
   if Game.isWall(Vector(p.x-dz/distance*offset,p.y,p.z+dx/distance*offset))~=false then return false end
  end
 end
 return true
end
function NautilusChampion:SafeQ(pos,offense)
 if not point(pos)or type(Game.isWall)~='function'or Game.isWall(pos)~=false or IsUnderTurret2(pos)
  or IsUnderTurret2((myHero.pos+point(pos))/2)or GetEnemyCount(600,pos)>Menu.Misc.QEnemies:Value()then return false end
 if offense and(myHero.maxHealth<=0 or myHero.health/myHero.maxHealth*100<Menu.Misc.QHP:Value())then return false end
 -- An engage keeps the mana for E (fixed: a hook without its follow-up is wasted).
 -- An interrupt or a kill (offense is then a name, not true) is worth the hook alone.
 if offense==true then local d=myHero:GetSpellData(_E)
  if not d or not finite(d.mana)or d.mana<0 or myHero:GetSpellData(_Q).mana+d.mana>myHero.mana then return false end
 end
 return true
end
-- The first enemy champion on the hook's resolved ray (excluding the aimed unit), or nil; why when unknown.
function NautilusChampion:FirstChampion(pos,aim)
 local q=self.QSpell
 local blocked,objects=OrbamaPrediction:GetCollision(myHero.pos,pos,q.Speed,q.Delay,q.Radius,{OrbamaPrediction.COLLISION_ENEMYHERO},aim and aim.networkID)
 if blocked or type(objects)~='table'then return nil,'collision_unknown'end
 local first,best
 for i=1,math.min(#objects,5)do local u=objects[i]
  if u and u~=aim and u.type==Obj_AI_Hero and IsValid(u)then local d=GetDistance(u.pos,myHero.pos);if not best or d<best then first,best=u,d end end
 end
 return first
end
-- Hit chance for a hook: engage hooks beyond 700 on a target that can still move need a high chance (a
-- missed hook costs the engage and 14-10 s, Classic 18-10 s); interrupts, kills and near hooks keep 2.
function NautilusChampion:HookChance(u,offense)
 if offense~=true or GetDistance(u.pos,myHero.pos)<=700 then return 2 end
 local immobile=OrbamaPrediction.GetImmobileDuration and OrbamaPrediction:GetImmobileDuration(u)
 return finite(immobile)and immobile>0 and 2 or 3
end
function NautilusChampion:CastQ(u,context,permission,offense,priority)
 local R=self.QRange
 if self.hook or not self:Ready(_Q)or not Core:Reach(u,R)or not self:Current(u)or not self:Allowed(u)
  or not self:SafeQ(u.pos,offense)or(permission and not permission())then return false end
 local pred=Core:Prediction(self.QSpell);pred:GetPrediction(u,myHero)
 local chance=self:HookChance(u,offense)
 if not pred:CanHit(chance)or not point(pred.CastPosition)or not self:ClearRay(pred.CastPosition)then return false end
 -- Dredge Line pulls the first champion it touches. An engage accepts that champion when the hook may target
 -- it and it passes the same landing rules; an interrupt or a kill needs its own target and refuses.
 local first,why=self:FirstChampion(pred.CastPosition,u);if why then return false end
 if first and(offense~=true or not self:Current(first)or not self:Allowed(first)or not self:SafeQ(first.pos,offense))then return false end
 local recipient=first or u
 local aimID,aimHandle=identity(u),u.handle
 local p={target=recipient,id=identity(recipient),handle=recipient.handle,origin=point(myHero.pos),context=context,expires=Game.Timer()+3,
  distance=GetDistance(u.pos,myHero.pos),chance=chance,redirected=first~=nil}
 self.hook=p
 -- The same first-champion query on the ray that is really sent.
 local function contact(pos)
  local f,unknown=self:FirstChampion(pos,u);if unknown then return false end
  if not first then return f==nil end
  return f~=nil and identity(f)==p.id and f.handle==p.handle and self:Current(f)and self:Allowed(f)and self:SafeQ(f.pos,offense)
 end
 local ok=Core:Cast(HK_Q,pred.CastPosition,{intentTarget=u,context=context,priority=priority,range=R,prevalidateWorldCast=true,deferAttackWindup=true,
  validate=function(_,r)local pos=r and r.position or pred.CastPosition
   return self.hook==p and self:Ready(_Q)and identity(u)==aimID and u.handle==aimHandle and self:Current(u)
   and Core:Reach(u,R)and self:Allowed(u)and self:SafeQ(u.pos,offense)and self:SafeQ(pos,offense)
   and self:ClearRay(pos)and contact(pos)and(not permission or permission())end})
 if not ok then self.hook=nil;return false end
 p.action=Core.lastIntent.id
 Core:AfterCast(HK_Q,function()if self.hook==p then p.observed=true end end)
 return true
end
function NautilusChampion:ContinueHook()
 local p=self.hook;if not p then return false end
 local r=Core.adapter:Poll(p.action)
 if not r or r.jobCancelled or r.state=='cancelled_before_send'or r.state=='send_uncertain'or p.expires<=Game.Timer()
  or not Core.adapter:ContextValid({context=p.context},'continuation')
  or not p.terrain and(not self:Current(p.target)or identity(p.target)~=p.id or p.target.handle~=p.handle)then
  cleanup(self,'hook_ended');return false
 end
 if p.observed then
  local dashing=myHero.pathing and myHero.pathing.isDashing
  if dashing and GetDistance(myHero.pos,p.origin)>25 and not p.dashObserved then p.dashObserved=true
   -- Development trace: the hooked champion's buff names for 1.2 s settle the Q stun buff name (Nautilus-8).
   if Core.logger and not p.terrain then self.buffProbe={target=p.target,untilAt=Game.Timer()+1.2,names={},seen={},count=0}end
  end
  -- The hook holds the whole tick (W, E and R included). It ends when the
  -- pull that followed the observed cast is over, wherever it ended (a hooked
  -- wall is not next to the target), or, with no pull seen, once the anchor's
  -- delay and full flight have passed: that hook missed. A miss used to hold
  -- everything for the plan's 3 s. No timer or key send advances a combo; the
  -- follow-ups check their own reach.
  p.observedAt=p.observedAt or Game.Timer()
  local flown=Game.Timer()-p.observedAt>self.QSpell.Delay+self.QSpell.Range/self.QSpell.Speed+.2
  if not dashing and not IsCasting()and(p.dashObserved or flown)then
   if not p.terrain then
    Core:Trace('nautilus_hook',{distance=p.distance,chance=p.chance,redirected=p.redirected,pulled=p.dashObserved==true})
    if not p.dashObserved then self.lastMiss=Game.Timer()end
   end
   self.hook=nil
  end
 end
 return true
end
-- Our own hook or passive control on `u` ends within 0.25 s (or there is none): a new control chains.
function NautilusChampion:ControlReady(u)
 if not u or u.type~=Obj_AI_Hero then return true end
 local names={self.profile.root,self.profile.qRoot}
 for _,name in ipairs(self.profile.qControl or {})do if name~=self.profile.qRoot then names[#names+1]=name end end
 for _,name in ipairs(names)do local b,reason=self:OwnedBuff(u,name)
  if reason then return false end
  local expires=Core.buffExpiry(b)
  if expires and expires>Game.Timer()+.25 then return false end
 end
 return true
end
-- Seconds from the R request to the primary knock-up at distance d: cast plus the accelerating charge
-- (distance = v t + a t^2 / 2, profile rSpeed and rAccel, wiki 2026-10-10).
function NautilusChampion:RImpact(d)
 local p=self.profile;local v,a=p.rSpeed,p.rAccel
 if not finite(d)or d<0 or not finite(v)or not finite(a)or a<=0 then return nil end
 return p.rCast+(-v+math.sqrt(v*v+2*a*d))/a
end
function NautilusChampion:CastE(u,context,permission,inner,priority,now)
 local range=inner and 350 or self.ERange
 if not self:Ready(_E)or not self:Current(u)or not Core:Reach(u,range)then return false end
 -- Fixed: E waits until the own root is about to end, so its slow chains the
 -- control instead of overlapping it. `now` (a kill) does not wait.
 local function controlReady()return now or self:ControlReady(u)end
 if not controlReady()then return false end
 local id,handle=identity(u),u.handle
 return Core:Cast(HK_E,nil,{intentTarget=u,context=context,priority=priority,deferAttackWindup=true,validate=function()
  return self:Ready(_E)and identity(u)==id and u.handle==handle and self:Current(u)and Core:Reach(u,range)and controlReady()and(not permission or permission())end})
end
function NautilusChampion:CastW(u,context,permission)
 if not self:Ready(_W)or not self:Current(u)then return false end
 local id,handle=identity(u),u.handle
 local ok=Core:Cast(HK_W,nil,{intentTarget=u,context=context,validate=function()
  return self:Ready(_W)and identity(u)==id and u.handle==handle and self:Current(u)and(not permission or permission())end})
 if ok then Core:AfterCast(HK_W,function()self.wObserved=Game.Timer()end)end
 return ok
end
function NautilusChampion:AttackPermission(u)
 local mode=GetMode();local node,context
 if u.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')then node=Menu[mode];context=Core:ModeContext(mode)
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then local kind=u.team==300 and 'jungle'or 'lane'
  if not Core:FarmModeEnabled(kind)then return nil end
  node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'];context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 end
 if node and node.W:Value()and Core.manaAbove(node.Mana:Value())then return context end
end
function NautilusChampion:OnPostAttack(args)
 if ShouldWait()or self.hook then return end
 local witness=Core:AttackWitness(self.attack,args and args.Target)
 if not witness or witness==self.attack or witness.at>Game.Timer()then return end
 self.attack=witness;local u=witness.object;local context=self:AttackPermission(u)
 if not context or not _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return end
 return self:CastW(u,context,function()return self.attack==witness and Game.Timer()-witness.at<=.35
  and self:AttackPermission(u)~=nil and _G.SDK.Data:IsInAutoAttackRange(myHero,u)end)
end
-- Estimated R hits (never recorded as hits): the primary target at its knock-up time, plus enemies whose
-- predicted position at the charge's pass is inside the eruption radius (225, less 50 for movement) of the path.
function NautilusChampion:PathRows(u)
 if not self:Current(u)or not Core:Reach(u,825)then return nil end
 local function at(v,delay)
  if not finite(delay)then return nil end
  local spell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=delay,Radius=1,Range=1200,Speed=math.huge,Collision=false}
  local pred=Core:Prediction(spell);pred:GetPrediction(v,myHero)
  return pred:CanHit(2)and point(pred.UnitPosition)or nil
 end
 local destination=at(u,self:RImpact(GetDistance(u.pos,myHero.pos)));if not destination then return nil end
 local dx,dz=destination.x-myHero.pos.x,destination.z-myHero.pos.z;local length=dx*dx+dz*dz;local count=1
 local reach=self.profile.rRadius-50
 if length>1 then
  local len=math.sqrt(length)
  for _,v in ipairs(self:Rows('hero',1000))do
   if v~=u and(identity(v)~=identity(u)or v.handle~=u.handle)then
    local t=((v.pos.x-myHero.pos.x)*dx+(v.pos.z-myHero.pos.z)*dz)/length
    if t>-.2 and t<1.2 then
     local pos=at(v,self:RImpact(math.max(0,math.min(1,t))*len))
     if pos then
      t=((pos.x-myHero.pos.x)*dx+(pos.z-myHero.pos.z)*dz)/length
      if t>=0 and t<=1 and GetDistance(Vector(myHero.pos.x+dx*t,myHero.pos.y,myHero.pos.z+dz*t),pos)<=reach+(v.boundingRadius or 0)then count=count+1 end
     end
    end
   end
  end
 end
 return {target=u,position=destination,count=count,expires=Game.Timer()+.35}
end
-- Combo R is worth the ultimate only when the target is not already held by our own control, and one of:
-- it is the selected target, the hook is not available (cooldown or a miss), it hits two or more (and the
-- R count), or R + E + one attack kill it.
function NautilusChampion:RWorth(u,count)
 if not self:ControlReady(u)then return false end
 if _G.SDK.TargetSelector.Selected==u then return true end
 if not self:Ready(_Q)or self.lastMiss and Game.Timer()-self.lastMiss<3 then return true end
 -- The prepared preview (same target, still fresh) saves a second path search in the same moment.
 local view=self.preview
 local path=view and view.target==u and view.count and view.expires>Game.Timer()and view or self:PathRows(u)
 if path and path.count>=math.max(2,count or 1)then return true end
 local d=GetDistance(u.pos,myHero.pos)
 return(Core:Lethal(u,self:RImpact(d)or 2,function()
  return self:GetRDmg(u)+(self:Ready(_E)and self:GetEDmg(u)or 0)+_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)end))
end
function NautilusChampion:CastR(u,context,permission,count)
 if not self:Ready(_R)or not self:Current(u)or not Core:Reach(u,825)or not self:Allowed(u)then return false end
 local id,handle=identity(u),u.handle
 local function valid()
  if not self:Ready(_R)or identity(u)~=id or u.handle~=handle or not self:Current(u)or not Core:Reach(u,825)or not self:Allowed(u)
   or(permission and not permission())then return false end
  if count and count>1 then local path=self:PathRows(u);return path~=nil and path.count>=count end
  return true
 end
 if not valid()then return false end
 return Core:Cast(HK_R,u,{intentTarget=u,range=825,context=context,deferAttackWindup=true,validate=valid,
  observe=function(q)local native=myHero.activeSpell;local name=native and native.name
   local a=(name==self.profile.r or name==self.profile.rCast)and Core:NativeCast(q,name)
   return a and(a.target==id or a.target==handle)end})
end
-- Staggering Blow roots each enemy once per cooldown. While the attack target's
-- passive is spent, attacks go to another enemy in attack range whose passive is
-- fresh. The shared preference (a short lease renewed each tick) lets the
-- orbwalker make that attack itself, and it never overrides the player's selection.
function NautilusChampion:PassivePreference(u)
 local fresh
 if self:Current(u)and _G.SDK.Data:IsInAutoAttackRange(myHero,u)and not self:PassiveReady(u)
  and not(_G.SDK.TargetSelector.Selected==u and IsValid(u))then
  for _,v in ipairs(self:Rows('hero',300))do
   if v~=u and self:PassiveReady(v)and _G.SDK.Data:IsInAutoAttackRange(myHero,v)then fresh=v;break end
  end
 end
 if fresh then return Core:PreferAttack('NautilusPassive',fresh,.25)end
 Core:ReleaseAttackPreference('NautilusPassive');return false
end
function NautilusChampion:RegisterShieldDefense()
 if not Core.RegisterShield then return end
 -- start: the fixed request-to-shield time this controller has always declared.
 self.defenseRegistered,self.defenseReason,self.shieldDefense=Core:RegisterShield({name='NautilusW',slot=_W,key=HK_W,profile=self.profile.id,
  source=self.profile.shieldSource,
  ready=function()return self:Ready(_W)and not self.hook end,amount=function()return self:ShieldAmount()end,
  duration=self.profile.shieldDuration,start=.30})
end
function NautilusChampion:LowHP()return myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100<=Menu.Misc.WHP:Value()end
-- The shared rule (a real, interruptible channel that outlasts the impact; an
-- attack windup the host flags as channelling is not one), bound to the cast seen.
function NautilusChampion:Channel(u,delay,token)
 local a=u and u.activeSpell
 return self:Current(u)and a and Core:CanInterrupt(u,delay)and(not token or token.name==a.name and token.start==a.startTime)or false
end
function NautilusChampion:Interrupt()
 local mode=GetMode();if mode~='Combo'and mode~='Harass'then return false end
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return false end
 local q=Menu.Misc.InterruptQ:Value()and self:Ready(_Q);local r=mode=='Combo'and Menu.Misc.InterruptR:Value()and self:Ready(_R)
 if not q and not r then return false end
 for _,u in ipairs(self:Rows('hero',self.QRange))do local a=u.activeSpell;local token=a and {name=a.name,start=a.startTime}
  if q and self:Channel(u,.25+GetDistance(u.pos,myHero.pos)/2000,token)then
   if self:CastQ(u,Core:ModeContext(mode),function()return Menu.Misc.InterruptQ:Value()and self:Channel(u,.25+GetDistance(u.pos,myHero.pos)/2000,token)and Core.manaAbove(node.Mana:Value())end,'interrupt')then return true end
  end
  if r and Core:Reach(u,825)and self:Channel(u,self:RImpact(GetDistance(u.pos,myHero.pos)),token)then
   if self:CastR(u,Core:ModeContext(mode),function()return Menu.Misc.InterruptR:Value()and self:Channel(u,self:RImpact(GetDistance(u.pos,myHero.pos)),token)and Core.manaAbove(node.Mana:Value())end,1)then return true end
  end
 end
 return false
end
function NautilusChampion:Combat(mode)
 local node=Menu[mode]
 -- The attack preference costs nothing: it waits for neither mana nor a ready spell.
 local near=GetTarget(300);if IsValid(near)then self:PassivePreference(near)else Core:ReleaseAttackPreference('NautilusPassive')end
 if not Core.manaAbove(node.Mana:Value())then return false end
 local q=node.Q:Value()and self:Ready(_Q);local e=node.E:Value()and self:Ready(_E)
 local w=node.W:Value()and self:LowHP()and self:Ready(_W)
 local r=mode=='Combo'and node.R:Value()and self:Ready(_R)
 if not q and not e and not w and not r then return false end
 local u=GetTarget(q and self.QRange or r and 825 or self.ERange);if not IsValid(u)then return false end
 local context=Core:ModeContext(mode)
 -- R takes the selector's target inside its own range, not the farther hook target.
 local ru=r and(Core:Reach(u,825)and u or GetTarget(825))
 if IsValid(ru)and self:RWorth(ru,node.RCount:Value())
  and self:CastR(ru,context,function()return node.R:Value()and Core.manaAbove(node.Mana:Value())and self:RWorth(ru,node.RCount:Value())end,node.RCount:Value())then return true end
 if w and Core:Reach(u,650)and self:CastW(u,context,function()return node.W:Value()and self:LowHP()and Core.manaAbove(node.Mana:Value())end)then return true end
 if e and self:CastE(u,context,function()return node.E:Value()and Core.manaAbove(node.Mana:Value())end)then return true end
 if q and not _G.SDK.Data:IsInAutoAttackRange(myHero,u)then
  return self:CastQ(u,context,function()return node.Q:Value()and Core.manaAbove(node.Mana:Value())end,true)
 end
 return false
end
function NautilusChampion:Combo()return self:Combat('Combo')end
function NautilusChampion:Harass()return self:Combat('Harass')end
function NautilusChampion:FarmUseful(u,slot)
 if u.team==300 or not Core:Reach(u,slot==_Q and self.QRange or 350)then return false end
 -- Outer/later E waves could soften other minions. LastHit E permits only one
 -- current lane minion in the complete profile area, not just the inner wave.
 return Core:Rescue(u,slot==_Q and .25+GetDistance(u.pos,myHero.pos)/2000 or .25,slot==_Q and self:GetQDmg(u)or self:GetEDmg(u),readyAttack)
  and(slot~=_E or #self:Rows('lane',self.profile.eArea)==1)
end
function NautilusChampion:Farm(kind,node,context,lastHit)
 if not Core.manaAbove(node.Mana:Value())then return false end
 local q=node.Q:Value()and self:Ready(_Q);local e=node.E:Value()and self:Ready(_E)
 if not q and not e then return false end
 local rows=self:Rows(kind,q and self.QRange or self.ERange);local u
 local function useful(v,slot)
  return node[slot==_Q and 'Q'or 'E']:Value()and Core.manaAbove(node.Mana:Value())
   and(kind=='jungle'or(not lastHit and slot==_E and #self:Rows('lane',self.ERange)>=node.ECount:Value())or self:FarmUseful(v,slot))
 end
 for _,v in ipairs(rows)do
  if (e and Core:Reach(v,lastHit and 350 or self.ERange)and useful(v,_E)or q and useful(v,_Q))
   and(not u or v.maxHealth>u.maxHealth)then u=v end
 end
 if not u then return false end
 local function permission(slot)return useful(u,slot)end
 -- A cast that saves a last hit goes out ahead of background wave clearing.
 if e and permission(_E)and self:CastE(u,context,function()return permission(_E)end,lastHit,
  kind=='lane'and(lastHit or #self:Rows('lane',self.ERange)<node.ECount:Value())and 'normal'or nil)then return true end
 if q and permission(_Q)then return self:CastQ(u,context,function()return permission(_Q)end,false,kind=='lane'and 'normal'or nil)end
 return false
end
function NautilusChampion:LaneClear()
 if not Core:FarmModeEnabled('lane')or not Menu.Clear.SpellFarm:Value()then return false end
 return self:Farm('lane',Menu.Clear.LaneClear,Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end),false)
end
function NautilusChampion:JungleClear()
 if not Core:FarmModeEnabled('jungle')or not Menu.Clear.SpellFarm:Value()then return false end
 return self:Farm('jungle',Menu.Clear.JungleClear,Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end),false)
end
function NautilusChampion:LastHit()return self:Farm('lane',Menu.LastHit,Core:ModeContext('LastHit'),true)end
-- Dredge Line pulls Nautilus to terrain it hits and gives half its cooldown
-- back: the first wall toward the cursor, far enough to beat walking, with no
-- unit in the anchor's way and a landing that is not under an enemy turret or
-- among more enemies. Unknown terrain is not a wall. Returns wall, landing.
function NautilusChampion:WallHook()
 local aim=mousePos;if type(Game.isWall)~='function'or not point(aim)then return nil end
 local d=GetDistance(aim,myHero.pos);if d<1 then return nil end
 local dx,dz=(aim.x-myHero.pos.x)/d,(aim.z-myHero.pos.z)/d;local landing
 for step=25,1050,25 do
  local p=Vector(myHero.pos.x+dx*step,myHero.pos.y,myHero.pos.z+dz*step);local wall=Game.isWall(p)
  if wall==true then
   if step<400 or not landing or IsUnderTurret2(landing)or GetEnemyCount(600,landing)>GetEnemyCount(600,myHero.pos)then return nil end
   local blocked,_,count=OrbamaPrediction:GetCollision(myHero.pos,p,self.QSpell.Speed,self.QSpell.Delay,self.QSpell.Radius,self.QSpell.CollisionTypes)
   if blocked or type(count)~='number'or count>0 then return nil end
   return p,landing
  elseif wall~=false then return nil end
  landing=p
 end
end
function NautilusChampion:FleeHook(context)
 if self.hook or not self:Ready(_Q)then return false end
 local wall=self:WallHook();if not wall then return false end
 local p={terrain=true,origin=point(myHero.pos),context=context,expires=Game.Timer()+3};self.hook=p
 local ok=Core:Cast(HK_Q,wall,{context=context,range=self.QRange,prevalidateWorldCast=true,
  resolve=function()local fresh=self:WallHook();return fresh and {position=fresh}or nil end,
  validate=function(_,r)return self.hook==p and self:Ready(_Q)and(r and r.position or self:WallHook())~=nil end})
 if not ok then self.hook=nil;return false end
 p.action=Core.lastIntent.id
 Core:AfterCast(HK_Q,function()if self.hook==p then p.observed=true end end)
 return true
end
function NautilusChampion:Flee()
 local context=Core:ModeContext('Flee');local u=GetTarget(825)
 if IsValid(u)then
  if self:LowHP()and Core:Reach(u,650)
   and self:CastW(u,context,function()return self:LowHP()end)then return true end
  if Menu.Misc.PeelR:Value()and Core:Reach(u,400)and self:CastR(u,context,function()return Menu.Misc.PeelR:Value()and Core:Reach(u,400)end,1)then return true end
  if Menu.Misc.PeelE:Value()and self:CastE(u,context,function()return Menu.Misc.PeelE:Value()end)then return true end
 end
 return self:FleeHook(context)
end
-- A kill needs no mode key. E and R first (they do not move Nautilus); the hook
-- only under its own landing rules and health floor. One kill rule: Core:Lethal.
local magic={kind='magical'}
function NautilusChampion:Finish()
 if not Menu.Misc.Finish:Value()then return false end
 local q,e,r=self:Ready(_Q),self:Ready(_E),self:Ready(_R)
 if not q and not e and not r then return false end
 for _,u in ipairs(self:Rows('hero',self.QRange))do
  local function kills(slot)
   local d=GetDistance(u.pos,myHero.pos)
   if slot==_E then return Core:Lethal(u,.25,function()return self:GetEDmg(u)end,magic)end
   if slot==_R then return Core:Lethal(u,self:RImpact(d),function()return self:GetRDmg(u)end,magic)end
   return Core:Lethal(u,.25+d/2000,function()return self:GetQDmg(u)end,magic)
  end
  local function still(slot)return function()return Menu.Misc.Finish:Value()and kills(slot)end end
  if e and Core:Reach(u,350)and kills(_E)and self:CastE(u,nil,still(_E),true,nil,true)then return true end
  if r and Core:Reach(u,825)and self:Allowed(u)and kills(_R)and self:CastR(u,nil,still(_R),1)then return true end
  if q and not self.hook and self:Allowed(u)and kills(_Q)and self:CastQ(u,nil,still(_Q),'finish')then return true end
 end
 return false
end
-- An enemy dashing onto Nautilus: E when it lands inside the inner wave, the hook when it lands outside
-- attack range (landing rules apply). No mode key needed.
function NautilusChampion:AntiDash()
 if not Menu.Misc.Gapclose:Value()then return false end
 local e,q=self:Ready(_E),self:Ready(_Q)and not self.hook and GetMode()~='Flee'
 if not e and not q then return false end
 local context={priority='interactive',condition=function()return Menu.Misc.Gapclose:Value()end}
 for _,u in ipairs(self:Rows('hero',1000))do
  local snap=Core:ApproachingDash(u,myHero.pos,300);local to=snap and point(snap.to)
  if to then
   local landing=GetDistance(to,myHero.pos)
   if e and landing<=350 and self:CastE(u,context,function()return Menu.Misc.Gapclose:Value()
    and(Core:ApproachingDash(u,myHero.pos,300)~=nil or Core:Reach(u,350))end,false,'interactive',true)then return true end
   if q and landing>myHero.range+myHero.boundingRadius+(u.boundingRadius or 0)
    and self:CastQ(u,context,function()return Menu.Misc.Gapclose:Value()end,true,'interactive')then return true end
  end
 end
 return false
end
-- An allied champion within 1000 under attack or dived (Core:PeelTarget): E on the diver in reach, R from
-- range when the ally is below 40% health, the hook only when it does not land deeper than the ally.
function NautilusChampion:Peel()
 if not Menu.Misc.Peel:Value()then return false end
 local q,e,r=self:Ready(_Q)and not self.hook and GetMode()~='Flee',self:Ready(_E),self:Ready(_R)
 if not q and not e and not r then return false end
 local allies=Core:DecisionUnits('GetAllyHeroes')
 for i=1,math.min(#allies,5)do local ally=allies[i]
  if ally and ally~=myHero and not ally.isMe and IsValid(ally)and finite(ally.maxHealth)and ally.maxHealth>0
   and GetDistance(ally.pos,myHero.pos)<=1000 then
   local enemy=Core:PeelTarget(ally,.75)
   if enemy and self:Current(enemy)then
    local handle=ally.handle
    local function still()return Menu.Misc.Peel:Value()and IsValid(ally)and ally.handle==handle and Core:PeelTarget(ally,.75)==enemy end
    local context={priority='interactive',condition=function()return Menu.Misc.Peel:Value()end}
    if e and Core:Reach(enemy,self.ERange)and self:CastE(enemy,context,still,false,'interactive')then return true end
    if r and ally.health/ally.maxHealth<.4 and Core:Reach(enemy,825)
     and self:CastR(enemy,context,function()return still()and ally.health/ally.maxHealth<.4 end,1)then return true end
    if q and GetDistance(enemy.pos,myHero.pos)<=GetDistance(ally.pos,myHero.pos)+250
     and self:CastQ(enemy,context,still,true,'interactive')then return true end
   end
  end
 end
 return false
end
-- Development traces (only with the recorder): buffs on a hooked champion, and the length of a fresh
-- Staggering Blow lockout on a target (Normal lockout is unmeasured; profile 6).
function NautilusChampion:Probes(near)
 local b=self.buffProbe
 if b then
  if Game.Timer()>b.untilAt or not IsValid(b.target)then
   Core:Trace('nautilus_hook_buffs',{profile=self.profile.id,names=table.concat(b.names,',')});self.buffProbe=nil
  else
   local u=b.target
   for i=0,math.min(u.buffCount or 0,64)do local x=u:GetBuff(i);local name=x and x.name
    if type(name)=='string'and(x.count or 0)>0 and not b.seen[name]and b.count<24 then b.seen[name]=true;b.count=b.count+1;b.names[#b.names+1]=name end
   end
  end
 end
 if near and Core.logger then
  local x=self:OwnedBuff(near,self.profile.passive)
  if x and finite(x.startTime)and x.startTime~=self.passiveSeen then self.passiveSeen=x.startTime
   local expiry=Core.buffExpiry(x);if expiry then Core:Trace('nautilus_passive_check',{profile=self.profile.id,lockout=expiry-x.startTime})end
  end
 end
end
function NautilusChampion:Assist()
 if not Menu.Misc.QAssist:Value()then self.assistUsed=false end
 if Menu.Misc.QAssist:Value()and not self.assistUsed and self:Ready(_Q)then local u=GetTarget(self.QRange)
  if IsValid(u)and self:CastQ(u,Core:HeldContext(function()return Menu.Misc.QAssist:Value()end),function()return Menu.Misc.QAssist:Value()end,true)then self.assistUsed=true;return true end
 end
 if Menu.Misc.RAssist:Value()and self:Ready(_R)then local u=GetTarget(825)
  return IsValid(u)and self:CastR(u,Core:HeldContext(function()return Menu.Misc.RAssist:Value()end),function()return Menu.Misc.RAssist:Value()end,1)or false
 end
 return false
end
function NautilusChampion:PreparePreview()
 local ready=self:Ready(_R);local u=GetTarget(ready and 825 or 300)
 -- The R path only: the game shows the shield and W. A copy kept for a second so a late preparation never
 -- blinks it; Draw shows it only while R is ready.
 local rows=ready and IsValid(u)and self:PathRows(u)
 self.preview={expires=Game.Timer()+1,position=rows and rows.position,count=rows and rows.count}
end
function NautilusChampion:Tick()
 if ShouldWait()then cleanup(self,'unavailable');return end
 self.allow:Maintain()
 if not Menu.Misc.QAssist:Value()then self.assistUsed=false end
 if self:ContinueHook()or IsCasting()then return end
 if Core.logger then self:Probes(GetTarget(300))end
 if self:Assist()or self:Interrupt()or self:Finish()or self:AntiDash()or self:Peel()then return end
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if self:LaneClear()then return end;self:JungleClear()
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and Menu.Draw.Preview:Value()and Game.Timer()>=(self.nextPreview or 0)then self.nextPreview=Game.Timer()+.125;self:PreparePreview()end
end
function NautilusChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.Ranges:Value()then for slot,r in pairs({[_E]=self.ERange,[_R]=825,[_Q]=self.QRange})do if IsReady(slot)then Draw.Circle(myHero.pos,r,1,Draw.Color(255,120,180,255))end end end
 local p=self.preview
 if Menu.Draw.Preview:Value()and p and p.expires>Game.Timer()and p.position and IsReady(_R)then
  if Draw.Line then local a,b=myHero.pos:To2D(),p.position:To2D();Draw.Line(a.x,a.y,b.x,b.y,1,Draw.Color(255,180,200,255))end
  if(p.count or 0)>0 then local s=p.position:To2D();Draw.Text('R hits '..p.count,16,s.x,s.y,Draw.Color(255,180,200,255))end
 end
end
function NautilusChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Nautilus: modes','Nautilus: control'},function(page)
  return {title='Nautilus assistance',cards=page==1 and {
   {'MODES','Provider binds select combat, harass, separate lane/jungle, LastHit and Flee. Ability farming is one toggle and starts off. Enemies dashing onto you get E or the hook; allies being dived get E, the hook and, when low, R.'},
   {'SHIELD','W follows a real completed attack or your low-health defensive policy. Cast input does not prove a shield or attack reset.'},
   {'FARM','LastHit preserves available lethal attacks and refuses confirmed incoming kills. E rescue uses one inner wave and protects other lane minions.'}}or {
   {'ASSIST','The hook bind casts one safe hook per press; the R bind casts Depth Charge at the selected target. Combo and Flee use R on their own, and a killable enemy is finished without a mode key.'},
   {'HOOK','Current recipient, first-unit collision, sampled terrain and safe approach are checked before input. Continuation waits for a real cast, displacement and dash end.'},
   {'PASSIVE','While your target cannot be rooted again yet, attacks prefer another enemy in attack range who can; your selected target always wins. Flee hooks the first wall toward the cursor. R path counts are estimates; moving targets can leave that path. Combo spends R when it hits two or more, kills with E and an attack, follows a missed hook or hits your selected target, never on a target your own hook or passive still holds.'}}}
 end)
end
Core:StandardPolicy(NautilusChampion,{damageTypes={Q='magical',E='magical',R='magical'},exceptions={non_interrupting_summoner=true}})
NautilusChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Nautilus"]="Nautilus"}
local normalSupported={["Nautilus"]=true}

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
