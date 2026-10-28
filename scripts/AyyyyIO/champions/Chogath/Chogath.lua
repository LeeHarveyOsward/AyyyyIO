return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Chogath"]=function()return _G.OrbamaFamily:Require("b70a76c39ae4f6332c117a1be13ac1794dd3c2443c47d16fae0414b36d5e92e5")()end
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
if champion=="Chogath" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Chogath',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent controller; installed candidates and unresolved native stack fields
-- are recorded in CombatProfiles/chogath-provenance.json.
local profiles=ChampionProfiles('Chogath')
local finite,identity,point=Core.finite,Core.id,Core.point
local function cleanup(self,reason)
 if self.ePlan then Core.adapter:Cancel(self.ePlan.action,reason or 'controller_closed')end
 if self.poke then Core:ReleaseAttackPreference('SpikePoke')end
 self.ePlan=nil;self.eOwned=nil;self.attack=nil;self.preview=nil;self.nativeBosses={};self.poke=nil;self.feastWatch=nil;self.feastIntent=nil
 self.castTrace=nil
end
local ChogathChampion=class("ChogathChampion")
function ChogathChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.nativeBosses={};self:LoadMenu()
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=self.profile.qDelay,Radius=self.profile.qRadius,Range=950,Speed=math.huge,Collision=false}
 -- Asset W range=300 is an input indicator. Its actual cone length is separate.
 self.WSpell={Type=OrbamaPrediction.SPELLTYPE_CONE,Delay=.5,Radius=28,Angle=56,Range=self.profile.wRange,Speed=math.huge,Collision=false}
 -- Vorpal Spikes: a line from Cho'Gath through the attacked unit (profile range, half width and speed).
 self.ESpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=self.profile.eHalfWidth,Range=self.profile.eSpikeRange,Speed=self.profile.eSpikeSpeed,Collision=false}
 -- Feast stacks seen from the start of the game. Loaded later, the count is unknown and no stack-dependent
 -- behaviour (stack Feast, stack range, stack spike damage) is used.
 self.ledger=Game.Timer()<90 and {known=true,total=0,nonEpic=0,champion=0,epic=0}or {known=false,reason='loaded_mid_game'}
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Chogath',function(reason)cleanup(self,reason)end)
 local ok,reason=Core:RegisterPreparation('Chogath.preview',{intervalMs=100,maxDelayMs=400,units=2,maxUnits=2},
  function()self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.preparation=ok;self.previewFallback=not ok and reason=='unsupported'
 local discovery,why=Core:RegisterPreparation('Chogath.discovery',{intervalMs=50,maxDelayMs=250,units=2,maxUnits=2},
  function()self:ScanObjects();return true end,function()return Menu.Misc.Secure:Value()and self:Ready(_R)end,
  function()self.scanIndex=nil;self.scanAt=nil end)
 self.discoveryPreparation=discovery;self.discoveryFallback=not discovery and why=='unsupported'
 -- Health-bar damage (shared display, KILL mark): ready Q and W, one E spike and a ready Feast (true damage).
 -- Partial: further spikes and attacks are not counted.
 Core:RegisterComboDamage(function(u)
  local total=0
  for _,slot in ipairs({_Q,_W})do if self:Ready(slot)then total=total+self:Damage(u,slot)end end
  if self:Ready(_E,true)then total=total+self:Damage(u,_E)end
  if self:Ready(_R)then total=total+self:GetRDmg(u)end
  return total,true
 end)
end
function ChogathChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name="AyyyyIO - Cho'Gath"})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 Menu.Clear:MenuElement({id='Stacks',name='Use R on cannons and big monsters for stacks',value=true})
 for _,mode in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  for _,slot in ipairs({'Q','W','E'})do Menu.Clear[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
  Menu.Clear[mode]:MenuElement({id='Count',name='Minions Q and W must hit',value=mode=='LaneClear'and 3 or 1,min=1,max=10,step=1,menu=mode=='LaneClear'})
 end
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q when an attack cannot last hit',value=true})
 Menu.LastHit:MenuElement({id='W',name='Use W when an attack cannot last hit',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=15,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='Secure',name='R (Feast) Dragon and Baron when it kills',value=true})
 Menu.Misc:MenuElement({id='Interrupt',name='Interrupt enemy channels with W or Q',value=true})
 Menu.Misc:MenuElement({id='Gap',name='W enemies that dash onto me',value=true})
 Menu.Misc:MenuElement({id='ControlQ',name='Q enemies standing still, without a mode key',value=true})
 Menu.Misc:MenuElement({id='ControlMana',name='That Q only above mana %',value=40,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='FleeQ',name='Flee: use Q on a chaser',value=true})
 Menu.Misc:MenuElement({id='FleeW',name='Flee: use W on a chaser',value=true})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Q and W ranges',value=false})
 Menu.Draw:MenuElement({id='Preview',name='Mark enemies and monsters R (Feast) kills',value=true})
end
function ChogathChampion:Ready(slot,off)
 local key=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot];local d=myHero:GetSpellData(slot)
 if not key or not d then return false end
 local recognized=false;for _,name in ipairs(self.profile[key])do if d.name==name then recognized=true end end
 if not recognized or not finite(d.level)or d.level<1 or not finite(d.currentCd)or d.currentCd>0 or Game.CanUseSpell(slot)~=0 then return false end
 if not finite(d.mana)or d.mana<0 or not off and d.mana>myHero.mana then return false end
 if slot==_E and self.profile.eToggle and d.toggleState~=1 and d.toggleState~=2 then return false end
 return true
end
-- No roster check: natively discovered bosses are not in a provider list.
function ChogathChampion:Reach(u,range)return IsValid(u)and u.team~=myHero.team and GetDistance(u.pos,myHero.pos)<=range end
-- Feast reads health from this wrapper, so the roster must still hold this very
-- wrapper; a boss the provider does not list is confirmed by a native lookup.
function ChogathChampion:Current(u)
 if not IsValid(u)or not identity(u)then return false end
 if Core:DecisionUnit(u.type==Obj_AI_Hero and 'GetEnemyHeroes'or u.team==300 and 'GetMonsters'or 'GetEnemyMinions',identity(u),u.handle)==u then return true end
 local row=self.nativeBosses[identity(u)]
 if row and row.handle==u.handle then
  if type(Game.GetObjectByNetID)=='function'then local ok,v=pcall(Game.GetObjectByNetID,identity(u));if ok and v and v.handle==u.handle and identity(v)==identity(u)then return v==u and IsValid(v)end end
  if row.index and type(Game.Object)=='function'then local ok,v=pcall(Game.Object,row.index);if ok and v and v.handle==u.handle and identity(v)==identity(u)then return v==u and IsValid(v)end end
  if type(Game.GetUnderMouseObject)=='function'then local ok,v=pcall(Game.GetUnderMouseObject);if ok and v and v.handle==u.handle and identity(v)==identity(u)then return v==u and IsValid(v)end end
 end
 return false
end
function ChogathChampion:Category(u)
 if not u or u.team==myHero.team then return nil end
 if u.type==Obj_AI_Hero then return 'champion'end
 if u.type~=Obj_AI_Minion then return nil end
 if u.team~=300 then return 'non_epic'end
 local name=(u.charName or ''):lower()
 if name:find('_prop',1,true)or name:find('spawn',1,true)or name:find('plant',1,true)or name=='sru_spiritwolf'then return nil end
 local classic=self.profile.id=='classic'
 local baron=name=='sru_baron'or name=='s3baron'or name=='worm'
 local dragon=name=='sru_dragon'or name=='s3dragon'or name=='dragon'or name:match('^sru_dragon_[a-z]+$')
 if baron or dragon then return 'epic'end
 if not classic and(name=='sru_riftherald'or name=='sru_horde'or name:match('^sru_atakhan[a-z_]*$'))then return 'epic'end
 return 'non_epic'
end
function ChogathChampion:StackState()
 -- Native Feast stacks in older scripts encode health, not a count; dividing
 -- by a fixed 80 is wrong after rank changes. Category counters are not exposed
 -- by a verified host field. Keep them unknown rather than testing total < 6.
 local buff=self:FeastBuff()
 return {kind=self.profile.stackCapKind,cap=6,total=nil,nonEpic=nil,champion=nil,epic=nil,
  buffPresent=buff~=nil,rawCount=buff and buff.count,rawStacks=buff and buff.stacks,status='native_category_fields_unverified'}
end
function ChogathChampion:FeastBuff()
 if not finite(myHero.buffCount)or myHero.buffCount<0 or myHero.buffCount>128 then return nil end
 for i=0,myHero.buffCount do local b=myHero:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==self.profile.feastBuff:lower()and finite(b.count)and b.count>0 then
   local source=b.source;if type(source)=='table'or type(source)=='userdata'then source=identity(source)end
   local owned=(not source or source==0 or source==myHero.networkID or source==myHero.handle)
    and(not b.sourcenID or b.sourcenID==0 or b.sourcenID==myHero.networkID or b.sourcenID==myHero.handle)
   local expiry=Core.buffExpiry(b)
   if owned and(not expiry or expiry==0 or finite(expiry)and expiry>Game.Timer())then return b end
  end
 end
end
function ChogathChampion:Damage(u,slot)
 local rank=myHero:GetSpellData(slot).level;if not IsValid(u)or not finite(myHero.ap)then return 0 end
 if slot==_R then
  local category=self:Category(u);if not category then return 0 end
  local base=category=='champion'and self.profile.rBase[rank]or self.profile.rMonster
  if not self.profile.rBase[rank]then return 0 end
  -- Native bonusHealth is additive health; absence contributes a safe zero,
  -- never a guessed maxHealth minus an obsolete level-growth formula.
  local bonus=finite(myHero.bonusHealth)and myHero.bonusHealth>=0 and myHero.bonusHealth or 0
  return base+self.profile.rAP*myHero.ap+self.profile.rHP*bonus
 end
 local monster=u.team==300
 local base=slot==_Q and self.profile.qBase[rank]or slot==_W and self.profile.wBase[rank]
  or monster and self.profile.eMonster and self.profile.eMonster[rank]or self.profile.eBase[rank]
 if not base then return 0 end
 local raw=base+(slot==_Q and 1 or slot==_W and .7 or .3)*myHero.ap
 if slot==_E and self.profile.ePercent then
  -- Each known Feast stack adds its share of maximum health; an unknown count adds nothing.
  local l=self.ledger;local stacks=self.profile.eStackPercent and l and l.known and l.total or 0
  local percent=math.max(0,u.maxHealth or 0)*(self.profile.ePercent[rank]+stacks*(self.profile.eStackPercent or 0))/100
  if monster then percent=math.min(percent,200)end
  raw=raw+percent
 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
function ChogathChampion:GetQDmg(u)return self:Damage(u,_Q)end
function ChogathChampion:GetWDmg(u)return self:Damage(u,_W)end
function ChogathChampion:GetEDmg(u)return self:Damage(u,_E)end
function ChogathChampion:GetRDmg(u)return self:Damage(u,_R)end
-- Feast's centre range: 175, plus the profile's growth per known stack (Normal: 2.5 each, at most 10 stacks).
-- Classic growth is unmeasured and an unknown stack count adds nothing.
function ChogathChampion:FeastRange()
 local p,l=self.profile,self.ledger
 if p.rStackRange and l and l.known then return 175+p.rStackRange*math.min(l.total,p.rStackRangeMax or 10)end
 return 175
end
function ChogathChampion:RReach(u)return self:Reach(u,self:FeastRange())end
-- Feast kills `u` from its current health; `anywhere` skips the range (drawings).
function ChogathChampion:LethalR(u,anywhere)
 if not self:Current(u)or not anywhere and not self:RReach(u)or u.isImmortal or not finite(u.health)or u.health<=0 then return false end
 local shield=u.allShield;if shield==nil then shield=u.shieldAD end
 if not finite(shield)or shield<0 then return false end
 local regen=finite(u.hpRegen)and math.max(0,u.hpRegen)*.25 or 0
 if u.health+shield+regen>self:GetRDmg(u)-20 then return false end
 -- A champion also passes the shared kill rule (spell protection, shield pools; Feast is one true-damage
 -- cast, so it must kill from current health). Epic monsters stay on the private check above: a boss found
 -- by native lookup is not in the provider's health forecast, which the shared rule requires for monsters.
 return u.type~=Obj_AI_Hero or(Core:Lethal(u,.25,function()return self:GetRDmg(u)end,{kind='true',now=true}))
end
function ChogathChampion:CastR(u,context,permission)
 if not self:Ready(_R)or not self:LethalR(u)or not permission or not permission()then return false end
 local id,handle,category=identity(u),u.handle,self:Category(u)
 local owner=category=='epic'and 'ObjectiveFeast'or category=='champion'and 'ChampionFeast'or 'StackFeast'
 local ok=Core:Cast(HK_R,u,{owner=owner,intentTarget=u,context=context,
  priority=category=='epic'and 'interactive'or nil,range=self:FeastRange(),deferAttackWindup=true,
  validate=function()return self:Ready(_R)and identity(u)==id and u.handle==handle and self:Category(u)==category and permission()and self:LethalR(u)end})
 if ok then self.feastIntent={q=Core.lastIntent,unit=u,id=id,handle=handle,category=category,at=Game.Timer()}end
 return ok
end
-- Stack count kept from observed Feasts: Feast's cooldown starting right after this script sent it, followed by
-- the target's death within 0.6 s, is one stack of that category. A Feast this script did not send (a manual
-- cast) makes the count unknown: whether it killed is not known.
function ChogathChampion:LedgerUnknown(reason)
 if self.ledger.known then Core:Trace('chogath_stack_ledger_unknown',{reason=reason,total=self.ledger.total})end
 self.ledger={known=false,reason=reason}
end
function ChogathChampion:MaintainLedger()
 local now=Game.Timer();local w=self.feastWatch;local l=self.ledger
 if w then local u=w.unit
  if u.handle==w.handle and(u.dead==true or not finite(u.health)or u.health<=0)then
   if l.known then local key=w.category=='non_epic'and 'nonEpic'or w.category
    l.total=l.total+1;l[key]=(l[key]or 0)+1;Core:Trace('chogath_stack',{category=w.category,total=l.total,nonEpic=l.nonEpic})
   end
   self.feastWatch=nil
  elseif now>w.expires then self.feastWatch=nil end
 end
 local d=myHero:GetSpellData(_R);local cd=d and d.currentCd
 if finite(cd)and cd>0 and self.lastRCd==0 then
  local f=self.feastIntent
  if f and f.q and(f.q.sentAt or f.q.observedAt)and now-f.at<=2 then
   self.feastWatch={unit=f.unit,handle=f.handle,category=f.category,expires=now+.6};self.feastIntent=nil
  else self:LedgerUnknown('feast_not_sent_by_script')end
 end
 if self.feastIntent and now-self.feastIntent.at>2 then self.feastIntent=nil end
 self.lastRCd=cd
end
function ChogathChampion:StackAllowance()
 local l=self.ledger;if not l or not l.known then return nil end
 return(self.profile.stackCap or 6)-(self.profile.stackCapKind=='non_epic'and l.nonEpic or l.total)
end
-- A lane cannon or super minion, or a big camp monster (1000+ maximum health); never an epic monster.
function ChogathChampion:StackTarget(u,kind)
 if self:Category(u)~='non_epic'then return false end
 if kind=='lane'then local n=(u.charName or ''):lower();return n:find('siege',1,true)~=nil or n:find('super',1,true)~=nil end
 return u.team==300 and finite(u.maxHealth)and u.maxHealth>=1000
end
-- Stack Feast while farming: only with a known allowance left and no enemy champion within 1200.
function ChogathChampion:StackFeast(kind,context)
 if not Menu.Clear.Stacks:Value()or not self:Ready(_R)then return false end
 local left=self:StackAllowance();if not left or left<=0 or #self:Nearby('hero',1200)>0 then return false end
 local best
 for _,u in ipairs(self:Nearby(kind,self:FeastRange()+100))do
  if self:StackTarget(u,kind)and self:LethalR(u)and(not best or u.maxHealth>best.maxHealth)then best=u end
 end
 if not best then return false end
 return self:CastR(best,context,function()return Menu.Clear.Stacks:Value()and Menu.Clear.SpellFarm:Value()
  and(self:StackAllowance()or 0)>0 and #self:Nearby('hero',1200)==0 end)
end
function ChogathChampion:DiscoverBosses()
 local result,seen={},{}
 local function accept(u,index)
  if not self:Reach(u,1200)or self:Category(u)~='epic'or not identity(u)then return end
  local id=identity(u);if not seen[id]then result[#result+1]=u;seen[id]=true end
  local row=self.nativeBosses[id];local count=0;for _ in pairs(self.nativeBosses)do count=count+1 end
  if row or count<8 then self.nativeBosses[id]={handle=u.handle,index=index or row and row.index,at=Game.Timer()}end
 end
 local list=_G.SDK.ObjectManager:GetMonsters(1200);for i=1,math.min(#list,12)do accept(list[i])end
 if type(Game.GetUnderMouseObject)=='function'then local ok,u=pcall(Game.GetUnderMouseObject);if ok then accept(u)end end
 for id,row in pairs(self.nativeBosses)do
  local u;if type(Game.GetObjectByNetID)=='function'then local ok,v=pcall(Game.GetObjectByNetID,id);if ok then u=v end end
  if not u and row.index and type(Game.Object)=='function'then local ok,v=pcall(Game.Object,row.index);if ok then u=v end end
  if u and identity(u)==id and u.handle==row.handle then accept(u,row.index)
  elseif Game.Timer()-row.at>1 then self.nativeBosses[id]=nil end
 end
 if self.discoveryFallback and Game.Timer()>=(self.scanAt or 0)then self:ScanObjects();self.scanAt=Game.Timer()+.05 end
 return result
end
function ChogathChampion:ScanObjects()
 -- Optional enumeration progresses in bounded preparation chunks, retaining
 -- the last index across budget refusals. Readiness and consent precede IO.
 if not Menu.Misc.Secure:Value()or not self:Ready(_R)then return false end
 if type(Game.ObjectCount)=='function'and type(Game.Object)=='function'and Game.Timer()>=(self.scanAt or 0)then
  local ok,count=pcall(Game.ObjectCount)
  if ok and finite(count)and count>=0 and count%1==0 then
   count=math.min(count,65536);local first=self.scanIndex or 1;if first>count then first=1 end
   local last=math.min(count,first+31)
   for index=first,last do local read,u=pcall(Game.Object,index)
    if read and self:Reach(u,1200)and self:Category(u)=='epic'and identity(u)then
     local id=identity(u);local count=0;for _ in pairs(self.nativeBosses)do count=count+1 end
     if self.nativeBosses[id]or count<8 then self.nativeBosses[id]={handle=u.handle,index=index,at=Game.Timer()}end
    end
   end
   self.scanIndex=last>=count and 1 or last+1;self.scanAt=Game.Timer()+.05
  end
 end
 return true
end
function ChogathChampion:Secure()
 if not Menu.Misc.Secure:Value()or not self:Ready(_R)then return false end
 local best;for _,u in ipairs(self:DiscoverBosses())do if self:LethalR(u)and(not best or u.maxHealth>best.maxHealth)then best=u end end
 if best then return self:CastR(best,{priority='interactive'},function()return Menu.Misc.Secure:Value()and self:Category(best)=='epic'end)end
 return false
end
-- Feast is true damage: a champion it kills is eaten in every mode, no switch. W, then Q (at its 0.625 s impact,
-- with a high hit chance or a controlled target) take a kill they can; Rupture also stops a fleeing target.
-- Ignite into Feast (Chogath-4): a champion in Feast reach that Feast cannot kill yet, but would after Ignite's
-- first second of burn (true damage, current health, shields, regeneration over 1.25 s, the 20 Feast margin).
-- Utils sends Ignite (C:Ignite, only while it may); Finish's Feast then takes the kill with its own fresh check.
function ChogathChampion:IgniteBridge(u)
 if not self:Ready(_R)or not self:Current(u)or u.type~=Obj_AI_Hero or not self:RReach(u)or u.isImmortal or self:LethalR(u)then return false end
 if Core:SpellProtected(u)~=false or Core:CannotDie(u,1)then return false end
 local status=Core:IgniteStatus(u);if not status or not finite(status.damage)or not finite(status.duration)or status.duration<=0 then return false end
 local shield=u.allShield;if shield==nil then shield=u.shieldAD end
 if not finite(shield)or shield<0 or not finite(u.health)then return false end
 local regen=finite(u.hpRegen)and math.max(0,u.hpRegen)*1.25 or 0
 return u.health+shield+regen-status.damage/status.duration<=self:GetRDmg(u)-20
end
function ChogathChampion:Finish()
 if self:Ready(_R)then for _,u in ipairs(self:Nearby('hero',self:FeastRange()))do
  if self:LethalR(u)and self:CastR(u,{priority='interactive'},function()return true end)then return true end
 end
  if Game.Timer()>=(self.nextIgnite or 0)then for _,u in ipairs(self:Nearby('hero',self:FeastRange()))do
   if self:IgniteBridge(u)and Core:Ignite(u,'ChogathIgniteFeast',function()return self:IgniteBridge(u)end,{priority='interactive'})==true then
    self.nextIgnite=Game.Timer()+1;return true end
  end end
 end
 if self:Ready(_W)then for _,u in ipairs(self:Nearby('hero',self.profile.wRange))do
  local function kills()return(Core:Lethal(u,.5,function()return self:Damage(u,_W)end,{kind='magical'}))end
  if kills()and self:CastControl(u,_W,{priority='interactive'},kills)then return true end
 end end
 if self:Ready(_Q)then for _,u in ipairs(self:Nearby('hero',950))do
  local function kills()return(Core:Lethal(u,self.profile.qDelay,function()return self:Damage(u,_Q)end,{kind='magical'}))end
  if kills()and self:CastControl(u,_Q,{priority='interactive'},kills,Core:ControlledHit(u,self.QSpell)and 2 or 3)then return true end
 end end
 return false
end
-- An enemy dashing onto Cho'Gath is met with the scream as he arrives.
function ChogathChampion:Gap()
 if not Menu.Misc.Gap:Value()or not self:Ready(_W)then return false end
 for _,u in ipairs(self:Nearby('hero',self.profile.wRange))do
  if Core:ApproachingDash(u,myHero.pos,300)then
   return self:CastControl(u,_W,{priority='interactive',condition=function()return Menu.Misc.Gap:Value()end},function()
    return Menu.Misc.Gap:Value()and(Core:ApproachingDash(u,myHero.pos,300)~=nil or self:Reach(u,300))end)
  end
 end;return false
end
function ChogathChampion:Nearby(kind,range)return Core:Rows(kind,range)end
function ChogathChampion:Geometry(slot,aim,pos)
 if not point(aim)or not point(pos)then return false end
 if slot==_Q then return GetDistance(aim,myHero.pos)<=950 and GetDistance(aim,pos)<=self.profile.qRadius end
 local dx,dz=aim.x-myHero.pos.x,aim.z-myHero.pos.z;local ux,uz=pos.x-myHero.pos.x,pos.z-myHero.pos.z
 local a,b=math.sqrt(dx*dx+dz*dz),math.sqrt(ux*ux+uz*uz)
 return a>0 and b<=self.profile.wRange and(b==0 or (dx*ux+dz*uz)/(a*b)>=math.cos(math.rad(28)))
end
-- Rupture on a retreating champion: the centre moves up to 30% of the radius (at most 75) along the target's
-- path, so it still covers the predicted position and also the ground the target is walking into.
function ChogathChampion:ShapeQ(u,centre,predicted)
 local c,p=point(centre),point(predicted)
 if not c or not p or u.type~=Obj_AI_Hero then return c end
 local path=u.pathing;local to=path and path.hasMovePath and point(path.endPos)
 if not to then return c end
 local dir,away=to-p,p-point(myHero.pos)
 if dir:Len()<1 or away:Len()<1 or dir.x*away.x+dir.z*away.z<=0 then return c end
 local shifted=c+dir:Normalized()*math.min(75,self.profile.qRadius*.3)
 if GetDistance(shifted,myHero.pos)>950 or GetDistance(shifted,p)>self.profile.qRadius then return c end
 return shifted
end
function ChogathChampion:CastControl(u,slot,context,permission,hitchance)
 local range=slot==_Q and 950 or self.profile.wRange;hitchance=hitchance or 2
 if not self:Ready(slot)or not self:Reach(u,range)or not self:Current(u)or permission and not permission()then return false end
 local spell=slot==_Q and self.QSpell or self.WSpell;local pred=Core:Prediction(spell);pred:GetPrediction(u,myHero)
 if not pred:CanHit(hitchance)or not point(pred.CastPosition)or not self:Geometry(slot,pred.CastPosition,pred.UnitPosition or pred.CastPosition)then return false end
 local handle=u.handle
 local function valid(position,predicted)
  return self:Ready(slot)and u.handle==handle and self:Current(u)and self:Reach(u,range)and point(position)
   and point(predicted)and self:Geometry(slot,position,predicted)and(not permission or permission(position))
 end
 local key=slot==_Q and HK_Q or HK_W
 if slot==_Q and u.type==Obj_AI_Hero then
  -- The shaped centre is our own aim, so the resolver predicts again and reshapes it.
  local aim=self:ShapeQ(u,pred.CastPosition,pred.UnitPosition or pred.CastPosition)
  local ok=Core:Cast(key,aim,{intentTarget=u,context=context,range=range,prevalidateWorldCast=true,deferAttackWindup=true,
   resolve=function()if u.handle~=handle or not self:Current(u)then return nil end
    local p=Core:Prediction(spell);p:GetPrediction(u,myHero)
    if not p:CanHit(hitchance)or not point(p.CastPosition)then return nil end
    local unitPosition=point(p.UnitPosition or p.CastPosition)
    return {position=self:ShapeQ(u,p.CastPosition,unitPosition),data={unitPosition=unitPosition}}end,
   validate=function(_,resolved)return resolved~=nil and valid(resolved.position,resolved.data and resolved.data.unitPosition)end})
  if ok then self:WatchCast(_Q,u,aim)end
  return ok
 end
 local ok=Core:Cast(key,pred.CastPosition,{intentTarget=u,context=context,range=range,
   prevalidateWorldCast=true,deferAttackWindup=true,validate=function(_,resolved)
    local position=resolved and resolved.position or pred.CastPosition
    local predicted=resolved and resolved.data and resolved.data.unitPosition or pred.UnitPosition
    return valid(position,predicted)end})
 if ok and slot==_W and u.type==Obj_AI_Hero then self:WatchCast(_W,u,pred.CastPosition)end
 return ok
end
-- Development evidence for the unresolved Q radius and W reach: after an observed Q or W on a champion, the
-- distance from the aim (Q) or from Cho'Gath (W) and whether a knock-up or silence followed.
function ChogathChampion:WatchCast(slot,u,aim)
 local id,handle,distance=identity(u),u.handle,GetDistance(u.pos,myHero.pos)
 Core:AfterCast(slot==_Q and HK_Q or HK_W,function()
  self.castTrace={slot=slot,unit=u,id=id,handle=handle,aim=point(aim),distance=distance,at=Game.Timer()+(slot==_Q and self.profile.qDelay or .5)+.15}
 end)
end
function ChogathChampion:TraceCast()
 local t=self.castTrace;if not t or Game.Timer()<t.at then return end
 self.castTrace=nil;local u=t.unit
 if not u or u.handle~=t.handle or not point(u.pos)then return end
 local effect=false
 if finite(u.buffCount)and u.buffCount>=0 and u.buffCount<=128 then
  for i=0,u.buffCount do local b=u:GetBuff(i)
   if b and finite(b.count)and b.count>0 and(t.slot==_Q and(b.type==29 or b.type==30)or t.slot==_W and b.type==7)then effect=true end
  end
 end
 if t.slot==_Q then Core:Trace('chogath_q_outcome',{radius=self.profile.qRadius,offset=t.aim and GetDistance(u.pos,t.aim),bounding=u.boundingRadius,airborne=effect})
 else Core:Trace('chogath_w_outcome',{range=self.profile.wRange,distance=t.distance,silenced=effect})end
end
-- An enemy champion winding up an attack on a minion stands still until the windup ends. Q only when the ground
-- it can cover between that end and Rupture's impact (plus 0.1 s of input delay) stays inside 3/4 of the radius.
function ChogathChampion:CSLocked(u)
 local cast=Core:CastWindup(u,0,1.25,true);if not cast then return nil end
 for i=1,math.min(Game.HeroCount(),16)do local h=Game.Hero(i)
  if h and(h.networkID==cast.target or h.handle==cast.target)then return nil end
 end
 local free=math.max(0,self.profile.qDelay+.1-(cast.castEndTime-Game.Timer()))
 local speed=finite(u.ms)and u.ms>0 and u.ms or nil
 if not speed or speed*free>self.profile.qRadius*.75 then return nil end
 return cast
end
function ChogathChampion:CSPunish(context,permission)
 if not self:Ready(_Q)then return false end
 for _,u in ipairs(self:Nearby('hero',950))do local cast=self:CSLocked(u)
  if cast and self:CastControl(u,_Q,context,function()return(not permission or permission())
   and Core:MatchesCastWindup(u,cast,-.2,1.25,true)end)then return true end
 end;return false
end
function ChogathChampion:ControlQ()
 if not Menu.Misc.ControlQ:Value()or not self:Ready(_Q)or not Core.manaAbove(Menu.Misc.ControlMana:Value())then return false end
 for _,target in ipairs(self:Nearby('hero',950))do
  local function permission(position)return Menu.Misc.ControlQ:Value()and Core.manaAbove(Menu.Misc.ControlMana:Value())
   and Core:ControlledHit(target,self.QSpell,position)end
  if permission()and self:CastControl(target,_Q,{priority='interactive',condition=function()return Menu.Misc.ControlQ:Value()end},permission)then return true end
 end
 return self:CSPunish({priority='interactive',condition=function()return Menu.Misc.ControlQ:Value()end},
  function()return Menu.Misc.ControlQ:Value()and Core.manaAbove(Menu.Misc.ControlMana:Value())end)
end
-- Spikes through a minion: a lane minion in attack range whose spike line (through it, profile length and half
-- width) covers an enemy champion's predicted position behind it becomes the attack preference (a lease, never a
-- veto); E then follows the observed attack on it as usual.
function ChogathChampion:SpikesUsable()
 if self.profile.eToggle then return myHero:GetSpellData(_E).toggleState==2 or self:Ready(_E)end
 return self:Ready(_E)or Game.Timer()<(self.spikesUntil or 0)
end
function ChogathChampion:SpikeCovers(minion,enemy)
 local origin=point(myHero.pos);local m=point(minion.pos);if not origin or not m then return false end
 local dir=m-origin;local length=dir:Len();if length<1 then return false end;dir=dir/length
 local pred=Core:Prediction(self.ESpell);pred:GetPrediction(enemy,myHero)
 local p=point(pred.UnitPosition)or point(enemy.pos);if not p then return false end
 local rel=p-origin;local along=rel.x*dir.x+rel.z*dir.z
 return along>length and along<=self.profile.eSpikeRange and math.abs(rel.x*dir.z-rel.z*dir.x)<=self.profile.eHalfWidth
end
function ChogathChampion:EndPoke()
 if self.poke then Core:ReleaseAttackPreference('SpikePoke');self.poke=nil end
end
function ChogathChampion:SpikePoke(mode)
 local node=mode=='Harass'and Menu.Harass or mode=='LaneClear'and Menu.Clear.SpellFarm:Value()and Core:FarmModeEnabled('lane')and Menu.Clear.LaneClear
 if not node or not node.E:Value()or not Core.manaAbove(node.Mana:Value())or not self:SpikesUsable()then self:EndPoke();return false end
 local enemies=self:Nearby('hero',self.profile.eSpikeRange+200)
 if #enemies==0 then self:EndPoke();return false end
 for _,e in ipairs(enemies)do if _G.SDK.Data:IsInAutoAttackRange(myHero,e)then self:EndPoke();return false end end
 local minions=self:Nearby('lane',600)
 for i=1,math.min(#minions,12)do local m=minions[i]
  if _G.SDK.Data:IsInAutoAttackRange(myHero,m)then
   for j=1,math.min(#enemies,5)do
    if self:SpikeCovers(m,enemies[j])and Core:PreferAttack('SpikePoke',m,.5)then
     self.poke={id=identity(m),handle=m.handle,enemy=enemies[j],mode=mode};return true
    end
   end
  end
 end
 self:EndPoke();return false
end
function ChogathChampion:EPermission(u)
 local mode=GetMode();local node,context
 if u.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')then node=Menu[mode];context=Core:ModeContext(mode)
 elseif mode=='Harass'and self.poke and identity(u)==self.poke.id and u.handle==self.poke.handle then
  -- The spikes go through this minion onto the champion behind it (SpikePoke).
  node=Menu.Harass;context=Core:ModeContext('Harass')
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then local jungle=u.team==300
  if not Core:FarmModeEnabled(jungle and 'jungle'or 'lane')then return nil end
  node=Menu.Clear[jungle and 'JungleClear'or 'LaneClear'];context=Core:FarmContext(jungle and 'jungle'or 'lane',function()return Menu.Clear.SpellFarm:Value()end)
 end
 if node and node.E:Value()and Core.manaAbove(node.Mana:Value())and _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return context end
end
function ChogathChampion:OnPostAttack(args)
 if ShouldWait()then return end
 local witness=Core:AttackWitness(self.attack,args and args.Target)
 if not witness or witness==self.attack or witness.at>Game.Timer()then return end
 self.attack=witness;local u=witness.object;local context=self:EPermission(u)
 if not context or not self:Ready(_E)then return end
 if self.profile.eToggle and myHero:GetSpellData(_E).toggleState~=1 then return end
 local plan={expires=Game.Timer()+.8,context=context};self.ePlan=plan
 local ok=Core:Cast(HK_E,nil,{owner='AttackSpikes',intentTarget=u,context=context,deferAttackWindup=true,
  observe=self.profile.eToggle and function(q)return myHero:GetSpellData(_E).toggleState==2 and q.toggleState~=2 end or nil,
  validate=function()return self.ePlan==plan and self:Ready(_E)and self:EPermission(u)~=nil and self:Current(u)
   and Game.Timer()-witness.at<=.35 and(not self.profile.eToggle or myHero:GetSpellData(_E).toggleState==1)end})
 if not ok then self.ePlan=nil;return false end
 plan.action=Core.lastIntent.id
 Core:AfterCast(HK_E,function()if self.ePlan==plan then self.ePlan=nil;self.eOwned=self.profile.eToggle and {context=context}or nil end
  if not self.profile.eToggle then self.spikesUntil=Game.Timer()+(self.profile.eDuration or 6)end end)
 return true
end
function ChogathChampion:ManageE()
 local p=self.ePlan
 if p then local r=Core.adapter:Poll(p.action)
  if not r or r.jobCancelled or r.state=='cancelled_before_send'or r.state=='send_uncertain'or Game.Timer()>p.expires then self.ePlan=nil end
  if self.ePlan then return false end
 end
 if not self.profile.eToggle then return false end
 if myHero:GetSpellData(_E).toggleState==1 then self.eOwned=nil;return false end
 local owned=self.eOwned;if not owned or Core.adapter:ContextValid({context=owned.context},'continuation')then return false end
 if not self:Ready(_E,true)then return false end
 local plan={expires=Game.Timer()+.8,off=true};self.ePlan=plan
 local ok=Core:Cast(HK_E,nil,{owner='SpikesCleanup',context={priority='interactive'},observe=function(q)return myHero:GetSpellData(_E).toggleState==1 and q.toggleState~=1 end,
  validate=function()return self.ePlan==plan and self.eOwned==owned and self:Ready(_E,true)and myHero:GetSpellData(_E).toggleState==2 end})
 if not ok then self.ePlan=nil;return false end
 plan.action=Core.lastIntent.id;Core:AfterCast(HK_E,function()if self.ePlan==plan then self.ePlan=nil;self.eOwned=nil end end);return true
end
function ChogathChampion:Channel(u,delay,token)
 local a=u and u.activeSpell
 -- The shared rule: a real, interruptible channel that lasts beyond the cast.
 return self:Current(u)and Core:CanInterrupt(u,delay)and(not token or token.name==a.name and token.at==a.startTime)
end
-- Both casts are ranged and commit nothing, so a channel is interrupted without a mode key.
function ChogathChampion:Interrupt()
 if not Menu.Misc.Interrupt:Value()then return false end
 local context={priority='interactive',condition=function()return Menu.Misc.Interrupt:Value()end}
 for _,u in ipairs(self:Nearby('hero',950))do local a=u.activeSpell;local token=a and {name=a.name,at=a.startTime}
  for _,slot in ipairs({_W,_Q})do local delay=slot==_W and .5 or self.profile.qDelay
   if self:Ready(slot)and self:Channel(u,delay,token)then
    if self:CastControl(u,slot,context,function()return Menu.Misc.Interrupt:Value()and self:Channel(u,delay,token)end)then return true end
   end
  end
 end;return false
end
function ChogathChampion:Combat(mode)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return false end
 local function allowed()return node.Q:Value()and Core.manaAbove(node.Mana:Value())end
 -- Harass first punishes a champion locked in a last-hit attack, wherever the selected target is.
 if mode=='Harass'and node.Q:Value()and self:CSPunish(Core:ModeContext(mode),allowed)then return true end
 local u=GetTarget(950);if not IsValid(u)then return false end;local context=Core:ModeContext(mode)
 for _,slot in ipairs({_W,_Q})do local key=slot==_Q and 'Q'or 'W'
  if node[key]:Value()and self:CastControl(u,slot,context,function()return node[key]:Value()and Core.manaAbove(node.Mana:Value())end)then return true end
 end;return false
end
function ChogathChampion:Combo()return self:Combat('Combo')end
function ChogathChampion:Harass()return self:Combat('Harass')end
function ChogathChampion:FarmUseful(u,slot)
 if u.team==300 or not self:Current(u)then return false end
 return Core:Rescue(u,slot==_Q and self.profile.qDelay or .5,function()return self:Damage(u,slot)end)
end
function ChogathChampion:Count(kind,slot,aim)
 local n=0;for _,u in ipairs(self:Nearby(kind,slot==_Q and 1200 or self.profile.wRange))do if self:Geometry(slot,aim,u.pos)then n=n+1 end end;return n
end
function ChogathChampion:Cannon(u)local n=type(u.charName)=='string'and u.charName:lower()or '';return n:find('siege',1,true)~=nil or n:find('super',1,true)~=nil end
-- A rescue may hit other lane minions only when each of them dies to the same cast: the wave is never softened.
function ChogathChampion:RescueClean(u,slot)
 if not self:FarmUseful(u,slot)then return false end
 local delay=slot==_Q and self.profile.qDelay or .5
 for _,v in ipairs(self:Nearby('lane',slot==_Q and 1200 or self.profile.wRange))do
  if v~=u and self:Geometry(slot,u.pos,v.pos)and not Core:Lethal(v,delay,function()return self:Damage(v,slot)end)then return false end
 end;return true
end
function ChogathChampion:Rescue(node,context)
 if not Core.manaAbove(node.Mana:Value())then return false end
 for _,slot in ipairs({_W,_Q})do local key=slot==_Q and 'Q'or 'W'
  if node[key]:Value()and self:Ready(slot)then
   local best
   for _,u in ipairs(self:Nearby('lane',slot==_Q and 950 or self.profile.wRange))do
    if self:RescueClean(u,slot)and(not best or self:Cannon(u)and not self:Cannon(best)
     or self:Cannon(u)==self:Cannon(best)and u.maxHealth>best.maxHealth)then best=u end
   end
   if best and self:CastControl(best,slot,context,function()return node[key]:Value()and Core.manaAbove(node.Mana:Value())and self:RescueClean(best,slot)end)then return true end
  end
 end;return false
end
-- The best Q circle (unit positions and pair midpoints) or W cone (directions to units and pair bisectors) over
-- at most 12 predicted units. With `fixed` only that aim is weighed.
function ChogathChampion:ClearAim(kind,slot,minimum,fixed)
 local units=self:Nearby(kind,slot==_Q and 950+self.profile.qRadius or self.profile.wRange);local rows={}
 local pred=Core:Prediction(slot==_Q and self.QSpell or self.WSpell)
 for i=1,math.min(#units,12)do local u=units[i];pred:GetPrediction(u,myHero)
  local p=point(pred.UnitPosition)or point(u.pos);if p then rows[#rows+1]=p end
 end
 local origin=point(myHero.pos);local candidates={}
 if fixed then candidates[1]=point(fixed)else
  for i=1,#rows do candidates[#candidates+1]=rows[i]end
  for i=1,#rows do for j=i+1,#rows do if #candidates>=40 then break end
   if slot==_Q then candidates[#candidates+1]=(rows[i]+rows[j])/2
   else local a,b=rows[i]-origin,rows[j]-origin
    if a:Len()>0 and b:Len()>0 then candidates[#candidates+1]=origin+(a:Normalized()+b:Normalized())*300 end
   end
  end end
 end
 local best
 for _,c in ipairs(candidates)do local n=0
  for _,p in ipairs(rows)do if self:Geometry(slot,c,p)then n=n+1 end end
  if n>=minimum and(not best or n>best.count)then best={position=c,count=n}end
 end;return best
end
function ChogathChampion:Clear(kind)
 if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()then return false end
 local node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'];if not Core.manaAbove(node.Mana:Value())then return false end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 if self:StackFeast(kind,Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end))then return true end
 for _,slot in ipairs({_Q,_W})do local key=slot==_Q and 'Q'or 'W'
  if node[key]:Value()and self:Ready(slot)then
   local minimum=node.Count:Value();local plan=self:ClearAim(kind,slot,minimum)
   local function permission()return node[key]:Value()and Core.manaAbove(node.Mana:Value())end
   local range=slot==_Q and 950 or self.profile.wRange
   if plan and Core:Cast(slot==_Q and HK_Q or HK_W,plan.position,{context=context,range=range,prevalidateWorldCast=true,deferAttackWindup=true,
    resolve=function()if not permission()then return nil end;local fresh=self:ClearAim(kind,slot,minimum);return fresh and {position=fresh.position}end,
    validate=function(_,resolved)local aim=resolved and resolved.position
     return aim~=nil and permission()and self:Ready(slot)and(slot==_W or GetDistance(aim,myHero.pos)<=950)and self:ClearAim(kind,slot,minimum,aim)~=nil end})
   then return true end
  end
 end;return false
end
function ChogathChampion:LaneClear()return self:Clear('lane')end
function ChogathChampion:JungleClear()return self:Clear('jungle')end
function ChogathChampion:LastHit()return self:Rescue(Menu.LastHit,Core:RescueContext())end
function ChogathChampion:Flee()
 local u=GetTarget(950);if not IsValid(u)then return false end
 for _,slot in ipairs({_Q,_W})do local node=Menu.Misc[slot==_Q and 'FleeQ'or 'FleeW']
  if node:Value()and self:CastControl(u,slot,Core:ModeContext('Flee'),function()return node:Value()end)then return true end
 end;return false
end
-- Prepared for Draw: Feast damage, and per enemy champion (ready Q, W and R share, or a Feast kill) and per
-- monster near (a Feast kill) a mark. Draw reads only this table.
-- Only what the game does not show: who R (Feast) kills. Stacks are on the game's buff bar, combo
-- damage on the health bars. Kept for a second so a late preparation never blinks; Draw drops a dead or
-- unseen unit and everything while R is down.
function ChogathChampion:PreparePreview()
 local preview={expires=Game.Timer()+1,marks={}}
 local r=self:Ready(_R)
 if r then local heroes=self:Nearby('hero',1500)
  for i=1,math.min(#heroes,5)do local u=heroes[i]
   if self:LethalR(u,true)then preview.marks[#preview.marks+1]={unit=u,handle=u.handle,kill=true}end
  end
 end
 if r then local monsters=self:Nearby('jungle',1500)
  for i=1,math.min(#monsters,8)do local u=monsters[i]
   if self:LethalR(u,true)then preview.marks[#preview.marks+1]={unit=u,handle=u.handle,kill=true}end
  end
 end
 self.preview=preview
end
function ChogathChampion:Tick()
 -- Classic stacks may be lost on death (unverified): the count is then unknown.
 if myHero.dead and self.profile.stacksMayDropOnDeath and self.ledger.known then self:LedgerUnknown('classic_death')end
 if ShouldWait()or not Core:Available()then
  if self.ePlan then Core.adapter:Cancel(self.ePlan.action,'unavailable')end
  self:EndPoke();self.ePlan=nil;self.attack=nil;self.preview=nil;if myHero.dead then self.eOwned=nil end;return
 end
 self:MaintainLedger();self:TraceCast()
 if self.previewFallback and Menu.Draw.Preview:Value()and Game.Timer()>=(self.nextPreview or 0)then self:PreparePreview();self.nextPreview=Game.Timer()+.1 end
 if IsCasting()then return end
  if self:Secure()or self:Finish()or self:ManageE()or self:Interrupt()or self:Gap()or self:ControlQ()then return end
 local mode=GetMode()
 -- Only a lease on an attack target: it never stops the mode's own casts below.
 self:SpikePoke(mode)
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')and self:LaneClear()then return end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function ChogathChampion:Draw()
 if myHero.dead then return end
 -- Q and W rings: full colour while ready, faint on cooldown.
 if Menu.Draw.Ranges:Value()then
  Draw.Circle(myHero.pos,950,1,self:Ready(_Q)and Draw.Color(255,120,200,255)or Draw.Color(60,120,200,255))
  Draw.Circle(myHero.pos,self.profile.wRange,1,self:Ready(_W)and Draw.Color(255,120,200,255)or Draw.Color(60,120,200,255))
 end
 local p=self.preview;if Menu.Draw.Preview:Value()and p and p.expires>Game.Timer()and self:Ready(_R)then
  for _,m in ipairs(p.marks or {})do local u=m.unit
   if u and u.handle==m.handle and not u.dead and u.visible~=false and point(u.pos)then local s=u.pos:To2D()
    Draw.Text('FEAST',16,s.x,s.y-30,Draw.Color(255,255,60,60))
   end
  end
 end
end
function ChogathChampion:RegisterGuide(guide)
 return guide:Register('champion',{'ChoGath: modes','ChoGath: Feast and spikes'},function(page)
  return {title=page==1 and 'ChoGath modes'or 'Feast and observation',cards=page==1 and {
    {'COMBAT','Q predicts Rupture and leans into a retreating champion path. W uses its outgoing cone. Automatic Q uses the common CC hit window and its post-CC movement footprint, and also takes a champion standing still in a last-hit attack. Interruptible channels are answered with W or Q and an enemy dashing onto Cho\'Gath with W, without a mode key; no guessed spell-name channel list.'},
   {'FARM','Enable spell farming for separate lane and jungle binds. LastHit rescues CS after incoming-hit forecasts and free attack comparison, the cannon first; any other minion in the area must die too. Clear aims Q and W at the best spot between units. In Harass, attacks go to a minion whose spikes reach the champion behind it.'},
   {'ASSIST','Feast is cast on any champion it kills, with a 20 health margin and never into a spell shield, in every mode and without a mode key; W, then Q at a high hit chance, also take a kill they can. Flee uses Q/W peel without spending R.'}}or {
   {'SECURE','Epic Feast has its own switch and starts enabled. It ignores combat modes and selected targets, checks fresh lethal health, and never starts healthy bosses.'},
   {'E','E follows an observed completed attack. Modern E is a three-attack activation; Classic E is an owned toggle. Manual toggles stay untouched. Input acceptance is not a reset or hit.'},
   {'STACKS','Normal non-epic cap and Classic total cap are separate. Stacks are counted from observed Feast kills when the script ran from the start of the game; then Feast also takes cannons and big monsters for stacks while farming with no enemy champion near, and Normal Feast range grows with them. Loaded later, or after a Feast the script did not send, the count is unknown and none of this happens.'}},
   note='Damage uses installed candidates; missing native bonus health contributes zero. Live cast timing, stack fields, hit outcomes and FPS remain unverified.'}
 end)
end
Core:StandardPolicy(ChogathChampion,{damageTypes={Q='magical',W='magical',E='magical',R='true'},
 costPaid=function(self,q,slot)return slot==_E and self.ePlan and self.ePlan.off end,
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot,slot==_E and self.ePlan and self.ePlan.off)end;return true end})
ChogathChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Chogath"]="Chogath"}
local normalSupported={["Chogath"]=true}

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
