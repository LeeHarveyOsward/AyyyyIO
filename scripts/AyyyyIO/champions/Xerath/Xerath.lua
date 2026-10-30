return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Xerath"]=function()return _G.OrbamaFamily:Require("6b2c74a00309ceb63c807f47efc5537e6e0ff81f4a4070e688822144a7501c41")()end
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
modules.observeAttack=(function(require) return _G.OrbamaFamily:Factory("3da377a20f2c2a192efc8343b23fb571f5cda62e822551b4678aab011deb2b69")(require) end)(require)
modules.recallCast=(function(require) return _G.OrbamaFamily:Factory("3c7cec6192229bd783dbb481829105edbbe5cfcc52fbeae7408eed05670af826")(require) end)(require)
modules.skillOrders=(function(require) return _G.OrbamaFamily:Factory("c960de90c594e7c207e7efeaca5198f2250fe65b01459ca5f3ac5dfb7747935f")(require) end)(require)
modules.healthWindow=(function(require) return _G.OrbamaFamily:Factory("d533b0ef74c68b495c1d2541cc3e687ebd5a9d43ecc9bd9706750c9b1a16fec9")(require) end)(require)
modules.yunaraProfile=(function(require) return _G.OrbamaFamily:Factory("d0f8a7ede995c1c4ae39ff50186c21819723104154d9a4a209da8a785993462e")(require) end)(require)
modules.nautilusProfile=(function(require) return _G.OrbamaFamily:Factory("f730083274ce090a6b9cdaf348846a2fa53f89ad6c57c53a6c09767f82770c84")(require) end)(require)
modules["autojungle"]=_G.OrbamaFamily:Require("8ef13010a581d447046b67d863880d3e389ac7fec6a8557c660db9c87981114d")
modules["combatMechanics"]=_G.OrbamaFamily:Require("ba52643cc532b91600830ad315958c7c83c7fb8f12edb7d0a0462abb16309ea7")
modules["gameplay"]=_G.OrbamaFamily:Require("150735cd6058eefcd206afc8513dde960e1a1f0823bdfd223db9491c39a2f4d8")
modules["strike"]=_G.OrbamaFamily:Require("38babe42b81881ea627d41ae65e32a203fdca56374f733a79b4c7f0c9465a693")
modules["prediction"]=(function(require) return _G.OrbamaFamily:Factory("223a065ecf7929552d5f8dafcf2453fd9147cd6e9940ce97dc80add73aa9913b")(require) end)(require)
modules["policies"]=(function(require) return _G.OrbamaFamily:Factory("e26056d70e5dac93ebb21f4ae4fe96863a06915a942bb75b795567a932448a23")(require) end)(require)
modules["core"]=(function(require) return _G.OrbamaFamily:Factory("f7d98e88d54ea77cb1c1c4aa026b699688271ff1aa4f6e769036de5dccf63c4f")(require) end)(require)
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
    return _G.SDK.IsRecalling(unit,Core.validating==true)
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
if champion=="Xerath" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Xerath',profiles={normal=true,classic=false},
 Create=function(context)
-- Independent feature implementation; CombatProfiles/xerath-provenance.json.
local profile=ChampionProfiles('Xerath')[myHero.charName]
local finite,id,point=Core.finite,Core.id,Core.point
local function ending(b)local t=Core.buffExpiry(b);return finite(t)and t or nil end
-- Pinned by this champion's regressions: only a ready, in-range lethal attack keeps the spell (Core:Rescue).
local readyAttack={attack='ready'}
local XerathChampion=class("XerathChampion")
function XerathChampion:__init()
 assert(myHero.charName=='Xerath','No verified Classic Xerath kit');self.profile=profile;self.targets={};self.farmIndex={};self.cleanupPhases={};self:LoadMenu();self:Discover()
 self.spells={[_Q]={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.5,Radius=72.5,Range=profile.qMax,Speed=math.huge,Collision=false},
 [_W]={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=.75,Radius=250,Range=1000,Speed=math.huge,Collision=false},
 [_E]={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=60,Range=1125,Speed=1400,Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_YASUOWALL}},
 [_R]={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=.61,Radius=200,Range=5000,Speed=math.huge,Collision=false,AllowOffscreenCircle=true}}
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(a)self:PostAttack(a)end)
 Core:RegisterCleanup('Xerath',function()
  -- Cleanup runs after the controller is retired; wrapped gameplay methods are
  -- deliberately inactive then. Close the owned public requests directly.
  local c=self.charge;if c then if c.release then Core.adapter:Cancel(c.release.id,'controller_cleanup')end;Core.adapter:Cancel(c.begin.id,'controller_cleanup')end
  Core.adapter:SetBlocked('XerathQ','attack',false);Core.adapter:SetBlocked('XerathR','attack',false);Core.adapter:SetBlocked('XerathR','move',false)
  self.charge=nil;self.cleanupPhases={};self.chain=nil;self.artillery=nil;self.rStart=nil;self.preview=nil;self.lastAttack=nil
 end)
 local ok,why=Core:RegisterPreparation('Xerath.preview',{intervalMs=150,maxDelayMs=450,units=2,maxUnits=2},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Ranges:Value()or Menu.Draw.RKills:Value()or Menu.Draw.RMinimap:Value()end,function()self.preview=nil end);self.previewFallback=not ok and why=='unsupported'
 -- Health-bar damage (S9): ready Q, W and E plus one attack.
 Core:RegisterComboDamage(function(u)
  local total=_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0
  for _,slot in ipairs({_Q,_W,_E})do if self:Ready(slot)or slot==_Q and self.charge then total=total+self:Damage(u,slot)end end
  return total,true
 end)
end
function XerathChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_Xerath',name='AyyyyIO - Xerath'})
 for _,mode in ipairs({'Combo','Harass'})do Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=mode=='Combo'or slot~='E'})end
  if mode=='Combo'then Menu.Combo:MenuElement({id='R',name='Use R on distant enemies it can kill',value=true})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Combo'and 0 or 35,min=0,max=100,step=5,menu=mode~='Combo'})
 end
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'});Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 -- Rerank harass (zgXerath): a toggle with its own key and HUD status; the value saved at Clear.Harass is read once.
 do local spec={id='SpellHarass',name='Harass champions while lane clearing',value=false,toggle=true,key=string.byte('K'),
   callback=function(v)CheckChatBlock(Menu.Clear.SpellHarass,v)end}
  local m=_G.SDK and _G.SDK.MenuMigration
  -- Apply migrates a key for a keyed entry, so the old on/off value is read through a key-less copy.
  if m and type(m.Apply)=='function'then local old={id='SpellHarass',value=false}
   if pcall(m.Apply,m,old,'Classic_AIO_Xerath','Clear.Harass','Clear.SpellHarass')and type(old.value)=='boolean'then spec.value=old.value end end
  Menu.Clear:MenuElement(spec)
 end
 for _,mode in ipairs({'LaneClear','JungleClear'})do Menu.Clear:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu.Clear[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions an ability must hit',value=3,min=1,max=10,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'});for _,slot in ipairs({'Q','W','E'})do Menu.LastHit:MenuElement({id=slot,name='Use '..slot..' on a lone minion an attack cannot take',value=true})end
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Start R and fire at enemies near the cursor',key=string.byte('T')})
 Menu.Misc:MenuElement({id='MouseRange',name='R targets enemies this close to the cursor',value=700,min=200,max=1500,step=100,menu=false})
 Menu.Misc:MenuElement({id='RMin',name='Start R only on enemies farther than',value=1400,min=500,max=2500,step=100,menu=false});Menu.Misc:MenuElement({id='RHP',name='Never start R below health %',value=40,min=5,max=100,step=5})
 Menu.Misc:MenuElement({id='AntiGap',name='Use E on enemies who dash in or get close',value=true})
 Menu.Misc:MenuElement({id='QAssist',name='Aim and fire my own Q charges',value=true})
 Menu.Misc:MenuElement({id='RAuto',name='Fire R shots automatically after I start R',value=true})
 Menu.Misc:MenuElement({type=MENU,id='Targets',name='R target priority (0: never)'})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'});Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='RKills',name='R shots needed to kill each enemy',value=true});Menu.Draw:MenuElement({id='RMinimap',name='R range on the minimap while R is ready',value=true})
end
function XerathChampion:Rows(kind,range)return Core:Rows(kind=='enemy'and 'hero'or kind,range)end
function XerathChampion:Current(u)return u~=nil and point(u.pos)~=nil and Core:CurrentUnit(u)end
function XerathChampion:Discover()
 for _,u in ipairs(self:Rows('enemy',5500))do local row=self.targets[id(u)];if not row then local key=StableUnitMenuKey(self,'A',u)
  -- One slider per enemy (menu depth): 0 never fires R at it; the old per-enemy Priority is migrated.
  Menu.Misc.Targets:MenuElement({id=key,name=u.charName,value=3,min=0,max=5,step=1,from='Automation.Misc.Targets.'..key..'.Priority'})
  local node=Menu.Misc.Targets[key];row={node=node};self.targets[id(u)]=row end;row.handle=u.handle end;self.nextDiscovery=Game.Timer()+1
end
function XerathChampion:Allowed(u)local row=self.targets[id(u)];return row and row.handle==u.handle and row.node:Value()>0 end
function XerathChampion:Buff(u,name,requireOwn)return(Core:OwnBuff(u,name,requireOwn,true))end
function XerathChampion:Mana(node)
 return not node or Core.manaAbove(node.Mana:Value())
end
function XerathChampion:Ready(slot,shot,begin)
 local d=myHero:GetSpellData(slot);local expected=slot==_Q and profile.q or slot==_W and profile.w or slot==_E and profile.e or shot and profile.shot or profile.r
 if not d or d.name~=expected or not finite(d.level)or d.level%1~=0 or d.level<1 or d.level>(slot==_R and 3 or 5)or not finite(d.currentCd)or d.currentCd~=0 or Game.CanUseSpell(slot)~=0 then return false end
 if slot==_Q and(self.charge and not begin or self.qUnresolved or #self.cleanupPhases>0 or self.qRecent and Game.Timer()-self.qRecent<.3)then return false end
 return shot and self:Channel()~=nil or finite(d.mana)and d.mana>=0 and finite(myHero.mana)and myHero.mana>=d.mana
end
function XerathChampion:Project(u,time)
 if not IsValid(u)or not point(u.pos)or not finite(time)or time<0 or time>4 then return nil end;local p=u.pathing
 if not p or not p.hasMovePath and not p.isDashing then return point(u.pos)end;local speed=p.isDashing and p.dashSpeed or u.ms
 if not point(p.endPos)or not finite(speed)or speed<=0 then return nil end;return u.pos:Extended(p.endPos,math.min(GetDistance(u.pos,p.endPos),time*speed))
end
function XerathChampion:Spell(slot,range)local s=self.spells[slot];if slot==_Q then s.Range=range or profile.qMax end;return s end
-- Seconds of charge until Q reaches `dist` (conservative profile growth, onset included).
function XerathChampion:ChargeWait(dist)return profile.qOnset+math.max(0,dist-profile.qMin)*profile.qGrowth/(profile.qMax-profile.qMin)end
function XerathChampion:Hit(slot,aim,u,range)
 local spell=self:Spell(slot,range);local dist=GetDistance(myHero.pos,aim);if dist<1 then return false end;local time=spell.Delay+(spell.Speed==math.huge and 0 or GetDistance(u.pos,myHero.pos)/spell.Speed);local p=self:Project(u,time);if not p then return false end
 if slot==_W or slot==_R then return GetDistance(p,aim)<=spell.Radius end
 local dir=(aim-myHero.pos)/dist;local along=(p.x-myHero.pos.x)*dir.x+(p.z-myHero.pos.z)*dir.z
 return along>=0 and along<=spell.Range and GetDistance(myHero.pos+dir*along,p)<=spell.Radius
end
function XerathChampion:Count(slot,aim,kind,range)
 local spell=self:Spell(slot,range);local count=0;for _,u in ipairs(self:Rows(kind,spell.Range+spell.Radius))do if self:Hit(slot,aim,u,range)then count=count+1 end end;return count
end
function XerathChampion:Aim(slot,u,range,chance)
 local spell=self:Spell(slot,range);if not self:Current(u)or GetDistance(u.pos,myHero.pos)>spell.Range then return nil end
 if slot==_R and u.pos:To2D().onScreen==false and OrbamaPrediction.OffscreenCirclePrediction~=true then return nil end
 local pred=Core:Prediction(spell);pred:GetPrediction(u,myHero);local aim=point(pred.CastPosition)
 if not aim or not pred:CanHit(chance or 2)or GetDistance(aim,myHero.pos)>spell.Range or not self:Hit(slot,aim,u,range)then return nil end
 -- Xerath-2: a long E flight against a champion who can walk out of it needs a precise prediction, unless the
 -- target cannot move for the flight or carries our W slow.
 if slot==_E and u.type==Obj_AI_Hero then local flight=.25+GetDistance(u.pos,myHero.pos)/1400
  if flight*(finite(u.ms)and u.ms or 0)>spell.Radius+(u.boundingRadius or 65)+100 and not pred:CanHit(3)and(GetHardCCDuration(u)or 0)<flight and not self:Buff(u,'XerathWSlow',true)then return nil end
 end
 if slot==_E then local wall,_,n=OrbamaPrediction:GetCollision(myHero.pos,aim,1400,.25,60,spell.CollisionTypes,id(u));if wall~=false or not finite(n)or n~=0 then return nil end end
 if slot==_W and u.type==Obj_AI_Hero then local best=self:Count(slot,aim,'enemy');local primary=aim
  for _,other in ipairs(self:Rows('enemy',1000))do if other~=u then local p=self:Project(other,.75);local candidate=p and(p+primary)*.5
   if candidate and GetDistance(candidate,myHero.pos)<=1000 and self:Hit(slot,candidate,u)then local n=self:Count(slot,candidate,'enemy');if n>best then aim,best=candidate,n end end
  end end
 end
 return {position=aim,data={impact=spell.Delay+(spell.Speed==math.huge and 0 or GetDistance(u.pos,myHero.pos)/spell.Speed),range=spell.Range,prepared=Game.Timer(),origin=point(myHero.pos)}}
end
function XerathChampion:ObserveCast(q,name)
 local native=Core:NativeCast(q,name or q.spellName);if not native then return false end;q.nativeStart=native.startTime
 -- Development evidence for the delay conflict (Xerath-8): native start minus the send time.
 if Core.logger and finite(q.sentGameTime)and finite(native.startTime)then Core:Trace('xerath_cast_start',{name=native.name,delay=native.startTime-q.sentGameTime},200)end
 if native.name==profile.r then self.rStart={started=native.startTime,origin=point(native.startPos or myHero.pos)}end
 if native.name==profile.pulse or native.name==profile.shot then self:RecordPulse(native,q.object)end;return true
end
function XerathChampion:Cast(slot,u,context,permission,geometry,chance)
 local shot=slot==_R;local channel=shot and self:Channel();if not permission()or not self:Ready(slot,shot)or self.charge or not shot and self:Channel()then return false end
 if shot and(not channel or channel.remaining<=0 or not self:Allowed(u)or Game.Timer()<(channel.lastPulse or channel.started)+.6)then return false end
 local plan=self:Aim(slot,u,nil,chance);if not plan or geometry and not geometry(plan)then return false end;local handle=u.handle;local key=slot==_W and HK_W or slot==_E and HK_E or HK_R
 local minimap=shot and plan.position:To2D().onScreen==false;local options={context=context,intentTarget=u,range=plan.data.range,prevalidateWorldCast=not minimap,deferAttackWindup=not shot,exceptions=shot and{channel='artillery'}or nil,
  observe=function(q)return shot and(self:ObserveCast(q,profile.pulse)or self:ObserveCast(q,profile.shot))or self:ObserveCast(q)end,
  resolve=function()if not permission()or u.handle~=handle then return nil,'context_or_identity_changed'end;local p=self:Aim(slot,u,nil,chance);return p and(not geometry or geometry(p))and p or nil end,
  validate=function(_,r)
   r=minimap and plan or r
   if minimap and(Game.Timer()-plan.data.prepared>.05 or GetDistance(plan.data.origin,myHero.pos)>5)then return false end
   if not permission()or not self:Ready(slot,shot)or not self:Current(u)or u.handle~=handle or not r or not point(r.position)or GetDistance(r.position,myHero.pos)>self.spells[slot].Range or not self:Hit(slot,r.position,u)or geometry and not geometry(r)then return false end
   if shot then local now=self:Channel();return now==channel and now.remaining>0 and self:Allowed(u)and Game.Timer()>=(now.lastPulse or now.started)+.6 end
   if slot==_E then local wall,_,n=OrbamaPrediction:GetCollision(myHero.pos,r.position,1400,.25,60,self.spells[_E].CollisionTypes,id(u));return wall==false and finite(n)and n==0 end;return true
  end}
 if minimap then options.world=plan.position;options.resolve=nil;options.prevalidateWorldCast=nil;options.ttl=50
  if not point(plan.position)or not plan.position.ToMM then return false end
  return Core:Cast(key,plan.position:ToMM(),options)
 end
 return Core:Cast(key,plan.position,options)
end
function XerathChampion:Damage(u,slot,center)
 local d=myHero:GetSpellData(slot);if not finite(d.level)or not finite(myHero.ap)then return 0 end
 local base=slot==_Q and profile.qBase[d.level]or slot==_W and profile.wBase[d.level]or slot==_E and profile.eBase[d.level]or profile.rBase[d.level]
 if not base then return 0 end;local ratio=slot==_Q and .9 or slot==_W and .65 or .45;local raw=base+ratio*myHero.ap
 if slot==_W and center then raw=raw*1.667 end;return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
function XerathChampion:Phase(name,context)return {spellName=name,resource='slot:0',context=context,requestedAt=Core.adapter:Now(),requestGameTime=Game.Timer(),previousCastStart=myHero.activeSpell and myHero.activeSpell.startTime}end
function XerathChampion:PhaseCheck(q,check)
 return function(r)if not Core:InputAvailable()or not check(r)then return false end;q.dispatchGameTime=Game.Timer();q.dispatchCastStart=myHero.activeSpell and myHero.activeSpell.startTime;return true end
end
function XerathChampion:ObservePhase(q)
 local r=Core.adapter:Poll(q.id);if not r then return nil end;q.sentAt=r.sentAt;q.sentGameTime=r.sentGameTime;q.observationGameTime=Core.adapter:Capabilities().nativeSendGameTime and r.sentGameTime or q.dispatchGameTime
 if r.state=='send_uncertain'or r.interrupted or r.competitor then q.ambiguous=true end
 local native=not q.ambiguous and Core:NativeCast(q,q.spellName)
 if native and not q.observedAt and Core.adapter:Observe(q.id,{kind='mechanical',at=Core.adapter:Now(),source='spell_state_transition',unique=true})then q.observedAt=Core.adapter:Now();q.nativeStart=native.startTime;if q.spellName==profile.q2 then self.qRecent=native.startTime end end
 return r,native
end
function XerathChampion:ChargeReconciled()
 local a=myHero.activeSpell;return Core:Current()and not self:Buff(myHero,profile.q,false)and not(a and a.valid and not a.isStopped and(a.name==profile.q or a.name==profile.q2))and Control.IsKeyDown and not Control.IsKeyDown(HK_Q)
end
function XerathChampion:CollectPhases()
 for i=#self.cleanupPhases,1,-1 do local q=self.cleanupPhases[i];local r=Core.adapter:Poll(q.id)
  if not r or Core.adapter:Finish(q.id)or Core.adapter:Reconcile(q.id)then if self.qUnresolved==q then self.qUnresolved=nil end;table.remove(self.cleanupPhases,i)end
 end
end
function XerathChampion:CloseCharge(reason)
 local c=self.charge;if not c then return end
 if c.release then Core.adapter:Cancel(c.release.id,reason);self.cleanupPhases[#self.cleanupPhases+1]=c.release end
 if finite(c.begin.nativeStart)then self.ownedChargeStart=c.begin.nativeStart end
 local r=Core.adapter:Poll(c.begin.id);if r and r.sentAt then self.qUnresolved=c.release and c.release.sentAt and c.release or c.begin end
 Core.adapter:Cancel(c.begin.id,reason);self.cleanupPhases[#self.cleanupPhases+1]=c.begin;self.charge=nil;self.chargeStatus='owned_cleanup_'..tostring(reason)
 Core.adapter:SetBlocked('XerathQ','attack',false);self:CollectPhases()
end
function XerathChampion:ChargeBuff(c)
 local b=self:Buff(myHero,profile.q,true);local q=c and c.begin
 return q and q.observedAt and b and finite(b.startTime)and b.startTime>=q.nativeStart and b.startTime<=Game.Timer()and ending(b)<=q.nativeStart+4.3 and b or nil
end
function XerathChampion:ChargeRange(c)
 local b=self:ChargeBuff(c);if not b then return nil end
 -- A matching observed native range is preferred; elapsed time is not a cast witness. The fallback is the
 -- conservative side of the asset/wiki conflict (profile qMin/qMax/qOnset/qGrowth; Xerath-8).
 local a=myHero.activeSpell;local range=a and a.valid and a.isCharging and a.name==profile.q and a.range
 local age=Game.Timer()-b.startTime
 if Core.logger and finite(range)then Core:Trace('xerath_q_range',{age=age,range=range},250)end
 if finite(range)and range>=profile.qMin and range<=1500 then return range end
 return math.min(profile.qMax,profile.qMin+(profile.qMax-profile.qMin)/profile.qGrowth*math.max(0,age-profile.qOnset))
end
function XerathChampion:StartQ(u,context,permission,geometry,rescue,node)
 local a=myHero.activeSpell
 if not permission()or not self:Mana(node)or not self:Ready(_Q)or self:Channel()or not Core.adapter:Capabilities().ownedCharge or self:Buff(myHero,profile.q,false)or a and a.valid and a.isCharging then return false end
 local plan=self:Aim(_Q,u,profile.qMax);if not plan or geometry and not geometry(plan)or rescue and not self:CSUseful(u,_Q,.5+self:ChargeWait(GetDistance(plan.position,myHero.pos)))then return false end
 local handle=u.handle;local rank=myHero:GetSpellData(_Q).level;local q=self:Phase(profile.q,context)
 local request,why=Core.adapter:BeginCharge(HK_Q,{owner='Arcanopulse',resource='slot:0',context=context,exceptions={channel='charge_begin'},priority=context and context.priority or'normal',maxChargeMs=profile.qCharge*1000,expires=Core.adapter:Now()+profile.qCharge*1000,
  ready=function()return Core:AttackWindupRemaining()<=0 end,reconcile=function()return self:ChargeReconciled()end,
  mechanical=self:PhaseCheck(q,function()return permission()and self:Mana(node)and self:Ready(_Q,false,true)and not self:Channel()and not Core:SelfChanneling()and self:Current(u)and u.handle==handle and GetDistance(u.pos,myHero.pos)<=profile.qMax and myHero:GetSpellData(_Q).level==rank end)})
 if not request then self.chargeStatus=why;return false end;q.id=request
 self.charge={begin=q,target=u,handle=handle,rank=rank,context=context,permission=permission,geometry=geometry,rescue=rescue,deadline=Core.adapter:Now()+profile.qCharge*1000};return true
end
-- Xerath-3: a combat charge (not a farming one, not after the release was requested) moves to another enemy:
-- first one the Q kills, else (not a finisher) the target selector's choice inside the current range.
function XerathChampion:CombatCharge(c)
 local mode=c.context and c.context.mode;return c.finisher==true or mode=='Combo'or mode=='Harass'
end
function XerathChampion:Retarget(c,lost)
 if c.release or c.geometry or c.rescue or not self:CombatCharge(c)then return false end
 local range=self:ChargeRange(c)or profile.qMin;local rows=self:Rows('enemy',profile.qMax);local pick
 for i=1,math.min(#rows,5)do local u=rows[i]
  if u~=c.target and GetDistance(u.pos,myHero.pos)<=range and self:Kills(_Q,u,.5)then pick=u;break end
 end
 if not pick and lost and not c.finisher then local u=GetTarget(range);if self:Current(u)and u.type==Obj_AI_Hero then pick=u end end
 if not pick then return false end
 if Core.logger then Core:Trace('xerath_q_retarget',{from=id(c.target),to=id(pick),lost=lost==true,range=range})end
 c.target,c.handle=pick,pick.handle;c.retargets=(c.retargets or 0)+1;return true
end
function XerathChampion:MaintainCharge()
 local c=self.charge;if not c then return false end
 if not Core:InputAvailable()or not Core.adapter:ContextValid({context=c.context},'continuation')or Core.adapter:Now()>c.deadline then self:CloseCharge('context_or_target_ended_release_may_cast');return false end
 local lost=not self:Current(c.target)or c.target.handle~=c.handle
 if lost and not self:Retarget(c,true)then
  -- Nobody to move the beam to: keep the charge for a replacement until shortly before the deadline.
  if c.release or c.geometry or c.rescue or not self:CombatCharge(c)or Core.adapter:Now()>c.deadline-250 then self:CloseCharge('context_or_target_ended_release_may_cast');return false end
  local result=self:ObservePhase(c.begin);if not result or result.state=='cancelled_before_send'or c.begin.ambiguous then self:CloseCharge('begin_unconfirmed');return false end
  c.waiting=true;return true
 end
 c.waiting=nil
 if not lost and not c.release and not self:Kills(_Q,c.target,.5)then self:Retarget(c,false)end
 if not c.permission()then self:CloseCharge('context_or_target_ended_release_may_cast');return false end
 local result=self:ObservePhase(c.begin);if not result or result.state=='cancelled_before_send'or c.begin.ambiguous then self:CloseCharge('begin_unconfirmed');return false end
 if c.release then local r=self:ObservePhase(c.release)
  if not r or r.state=='cancelled_before_send'or c.release.ambiguous or c.release.observedAt or Core.adapter:Now()>c.deadline then self:CloseCharge(c.release.observedAt and'release_observed'or'release_unconfirmed')end;return true
 end
 local b=self:ChargeBuff(c);if not b then if Core.adapter:Now()>c.deadline-profile.qCharge*1000+500 then self:CloseCharge('native_charge_missing')end;return true end
 Core.adapter:SetBlocked('XerathQ','attack',true);local range=self:ChargeRange(c)
 if not range or Game.Timer()-b.startTime<.05 then return true end
 local plan=self:Aim(_Q,c.target,range)
 if not plan or c.geometry and not c.geometry(plan)or c.rescue and not self:CSUseful(c.target,_Q,.5)then if Core.adapter:Now()>c.deadline-250 then self:CloseCharge('release_aim_unavailable')end;return true end
 local aim=point(plan.position);local prepared=Game.Timer();local origin=point(myHero.pos);local q=self:Phase(profile.q2,c.context)
 local options={expires=math.min(c.deadline,Core.adapter:Now()+250),exceptions={channel='charge_release'},reconcile=function()return self:ChargeReconciled()end,
  mechanical=self:PhaseCheck(q,function(resolved)
   local current=self:ChargeBuff(c);local d=myHero:GetSpellData(_Q);local freshRange=self:ChargeRange(c)
   local p=resolved and point(resolved.position)or aim;local data=resolved and resolved.data;local at=data and data.prepared or prepared;local from=data and data.origin or origin
   return self.charge==c and p and finite(at)and Game.Timer()-at<=.05 and point(from)and GetDistance(from,myHero.pos)<=5 and c.permission()and self:Current(c.target)and c.target.handle==c.handle and current and d and(d.name==profile.q or d.name==profile.q2)and d.level==c.rank
    and freshRange and GetDistance(p,myHero.pos)<=freshRange and self:Hit(_Q,p,c.target,freshRange)
    and(not c.geometry or c.geometry({position=p,data={range=freshRange,impact=.5}}))and(not c.rescue or self:CSUseful(c.target,_Q,.5))
  end)}
 if Core.adapter:Capabilities().preparedChargeRelease then
  options.prevalidateWorldCast=true
  options.resolve=function()
   if self.charge~=c or not c.permission()or not self:Current(c.target)or c.target.handle~=c.handle or Core.adapter:Now()>c.deadline then return nil,'charge_context_changed'end
   local current=self:ChargeRange(c);local fresh=current and self:Aim(_Q,c.target,current)
   if not fresh or c.geometry and not c.geometry(fresh)or c.rescue and not self:CSUseful(c.target,_Q,.5)then return nil,'charge_ray_unavailable'end
   fresh.data.prepared=Game.Timer();fresh.data.origin=point(myHero.pos);return fresh
  end
  options.commitGuard=function()return self.charge==c and c.permission()and Core:InputAvailable()and IsValid(c.target)and c.target.handle==c.handle and Core.adapter:Now()<=c.deadline end
 else options.expires=math.min(c.deadline,Core.adapter:Now()+50)end
 local request,why=Core.adapter:ReleaseCharge(c.begin.id,aim,options)
 if request then q.id=request;c.release=q else self.chargeStatus=why;self:CloseCharge('release_declined')end;return true
end
-- Rerank combo (Auto Xerath, zgXerath): a Q charge the player started (own native charge buff, no owned charge)
-- is aimed and fired once the Q key is up (Misc.QAssist): an enemy Q kills first, else the target selector inside
-- the current range. Never while the player holds Q or its state cannot be read; one release per charge.
function XerathChampion:NativeCharge()
 if self.charge or self.qUnresolved or #self.cleanupPhases>0 or self.qRecent and Game.Timer()-self.qRecent<.3 then return nil end
 local b=self:Buff(myHero,profile.q,true);local d=myHero:GetSpellData(_Q)
 -- The buff of a charge this controller began (and just closed) is never adopted.
 if b and self.ownedChargeStart and math.abs((b.startTime or 0)-self.ownedChargeStart)<=.3 then return nil end
 if not b or not finite(b.startTime)or b.startTime>Game.Timer()or not ending(b)or ending(b)<=Game.Timer()or not d or(d.name~=profile.q and d.name~=profile.q2)then return nil end
 return b
end
function XerathChampion:NativeChargeRange(b)
 local a=myHero.activeSpell;local range=a and a.valid and a.isCharging and a.name==profile.q and a.range
 if finite(range)and range>=profile.qMin and range<=1500 then return range end
 return math.min(profile.qMax,profile.qMin+(profile.qMax-profile.qMin)/profile.qGrowth*math.max(0,Game.Timer()-b.startTime-profile.qOnset))
end
function XerathChampion:KeyUp()return Control.IsKeyDown~=nil and Control.IsKeyDown(HK_Q)==false end
function XerathChampion:AdoptQ()
 if not Menu.Misc.QAssist:Value()or Core.pending[HK_Q]then return false end
 local b=self:NativeCharge();if not b or Game.Timer()-b.startTime<.05 or self.adopted==b.startTime or not self:KeyUp()then return false end
 local start=b.startTime;local range=self:NativeChargeRange(b);local pick
 for _,u in ipairs(self:Rows('enemy',range))do if self:Kills(_Q,u,.5)then pick=u;break end end
 if not pick then local u=GetTarget(range);if self:Current(u)and u.type==Obj_AI_Hero then pick=u end end
 local plan=pick and self:Aim(_Q,pick,range);if not plan then return false end
 local handle=pick.handle
 local function charge()local now=self:NativeCharge();return now and now.startTime==start and now or nil end
 local function permission()return Menu.Misc.QAssist:Value()and charge()~=nil and self:KeyUp()end
 local function fresh()
  local now=charge();if not now or not permission()or not self:Current(pick)or pick.handle~=handle then return nil,'charge_or_target_changed'end
  local r=self:NativeChargeRange(now);local aim=self:Aim(_Q,pick,r);if not aim then return nil,'charge_ray_unavailable'end;aim.data.range=r;return aim
 end
 local ok=Core:Cast(HK_Q,plan.position,{owner='Xerath.adoptQ',context=Core:HeldContext(permission),intentTarget=pick,range=range,exceptions={channel='charge_release'},
  prevalidateWorldCast=true,deferAttackWindup=false,resolve=fresh,commitGuard=function()return Core:InputAvailable()and permission()end,
  observe=function(q)return self:ObserveCast(q,profile.q2)end,
  validate=function(_,r)
   local now=charge();if not now or not permission()or not self:Current(pick)or pick.handle~=handle or not r or not point(r.position)then return false end
   local current=self:NativeChargeRange(now);return GetDistance(r.position,myHero.pos)<=current and self:Hit(_Q,r.position,pick,current)
  end})
 if ok then self.adopted=start;if Core.logger then Core:Trace('xerath_q_adopted',{target=id(pick),range=range,age=Game.Timer()-start})end end
 return ok
end
function XerathChampion:Chain(slot,u,nextSlot,context,permission,continuation)
 if self.chain then return false end;local firstCost=myHero:GetSpellData(slot).mana;local nextCost=myHero:GetSpellData(nextSlot).mana
 if not self:Ready(nextSlot)or not finite(firstCost)or not finite(nextCost)or firstCost+nextCost>myHero.mana or not self:Cast(slot,u,context,permission)then return false end
 self.chain={slot=slot,nextSlot=nextSlot,target=u,handle=u.handle,q=Core.lastIntent,context=context,permission=continuation or permission,expires=Game.Timer()+2};return true
end
function XerathChampion:Controlled(chain,arrival)
 if not chain.q.observedAt or not finite(chain.q.nativeStart)then return nil end
 for _,name in ipairs(chain.slot==_W and{'XerathWSlow','XerathWSweetSpot'}or{'XerathMageSpear'})do local b=self:Buff(chain.target,name,true)
  if b and finite(b.startTime)and b.startTime>=chain.q.nativeStart and b.startTime<=Game.Timer()and ending(b)>Game.Timer()+arrival then
   if Core.logger then Core:Trace('xerath_control_start',{slot=chain.slot,delay=b.startTime-chain.q.nativeStart},500)end
   return b
  end
 end;return nil
end
function XerathChampion:ContinueChain()
 local c=self.chain;if not c then return false end;local r=Core.adapter:Poll(c.q.id)
 if not r or c.q.cancelled or r.state=='send_uncertain'or r.state=='cancelled_before_send'or not c.q.continue()or not c.permission()or not self:Current(c.target)or c.target.handle~=c.handle or Game.Timer()>c.expires then self.chain=nil;return false end
 local arrival=c.nextSlot==_W and .75 or c.nextSlot==_E and .25+GetDistance(c.target.pos,myHero.pos)/1400 or .55+self:ChargeWait(GetDistance(c.target.pos,myHero.pos))
 -- The chain holds the whole tick while it waits for the first spell's control.
 -- Once that observed spell has had its full delay and flight (W 0.8 s, E up to
 -- 1.05 s) plus a margin and the target carries no control, it missed: the
 -- chain ends there instead of holding Q, W and E to the fixed 2 s expiry.
 if not self:Controlled(c,arrival)then
  if c.q.observedAt then c.seenAt=c.seenAt or Game.Timer()
   if Game.Timer()-c.seenAt>(c.slot==_W and .8 or 1.05)+.3 then self.chain=nil;return false end
  end
  return true
 end
 self.chain=nil;local control=function()return c.permission()and self:Controlled(c,arrival)~=nil end
 if c.nextSlot==_Q then return self:StartQ(c.target,c.context,control)end
 return self:Cast(c.nextSlot,c.target,c.context,control)
end
function XerathChampion:Channel()
 local c=self.artillery;local b=self:Buff(myHero,profile.r,true);local d=myHero:GetSpellData(_R)
 return c and b and d and d.name==profile.shot and finite(b.startTime)and b.startTime==c.buffStart and ending(b)==c.expires and Game.Timer()<c.expires and c or nil
end
function XerathChampion:RecordPulse(native,u)
 local c=self:Channel();if not c or not finite(native.startTime)or native.startTime<c.started or native.startTime>Game.Timer()then return end
 local token=tostring(native.startTime)
 if token~=c.lastToken then c.lastToken=token;c.lastPulse=native.startTime;c.nativeShots=c.nativeShots+1;c.remaining=math.max(0,c.maximum-c.nativeShots)end
 if u and self:Current(u)then local row=c.targets[id(u)]or {handle=u.handle,requested=0,observed=0,hits=0};c.targets[id(u)]=row
  if row.lastNative~=native.startTime then row.observed=row.observed+1;row.lastNative=native.startTime end
 end
end
function XerathChampion:ObserveChannel()
 local a=myHero.activeSpell;local b=self:Buff(myHero,profile.r,true);local d=myHero:GetSpellData(_R)
 if a and a.valid and not a.isStopped and not a.isAutoAttack and a.name==profile.r and finite(a.startTime)and a.startTime<=Game.Timer()and a.startTime>=Game.Timer()-1 then self.rStart={started=a.startTime,origin=point(a.startPos or myHero.pos)}end
 if self.artillery and not self:Channel()then self.artillery=nil end
 local start=self.rStart
 if not self.artillery and b and d and d.name==profile.shot and start and Game.Timer()-start.started<=1 and finite(b.startTime)and b.startTime>=start.started and b.startTime<=Game.Timer()and ending(b)<=start.started+10.3 and profile.shots[d.level]then
  self.artillery={started=start.started,buffStart=b.startTime,expires=ending(b),maximum=profile.shots[d.level],remaining=profile.shots[d.level],nativeShots=0,targets={}}
 end
 if a and a.valid and not a.isStopped and not a.isAutoAttack and(a.name==profile.pulse or a.name==profile.shot)then self:RecordPulse(a)end
 local c=self:Channel();if c then local shots=self:Buff(myHero,'XerathRShots',true);c.nativeCount=shots and shots.count or nil
  -- Native shot count and ramp aliases are recorded, not assumed to mean hits.
  for key,row in pairs(c.targets)do local target;for _,u in ipairs(self:Rows('enemy',5000))do if id(u)==key and u.handle==row.handle then target=u end end
   if not target then c.targets[key]=nil else local ramp=self:Buff(target,'XerathRRampUp',true);row.rampCandidate=ramp and ramp.count or nil end
  end
 end
end
function XerathChampion:RSafe()
 return finite(myHero.health)and finite(myHero.maxHealth)and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.RHP:Value()and not IsUnderTurret2(myHero.pos)and GetEnemyCount(900,myHero.pos)==0
end
-- `n` R shots kill `u`: one shot by the health window at its impact, several from current health.
function XerathChampion:ShotKills(u,n)
 return(Core:Lethal(u,profile.rShot,function()return self:Damage(u,_R)*n end,{kind='magical',now=n>1,margin=1,flat=0}))==true
end
function XerathChampion:ShotsToKill(u,most)
 for n=1,math.min(most or 0,6)do if self:ShotKills(u,n)then return n end end
end
-- Shot order (Xerath-4/6): a selected target first; then an enemy one shot kills; inside a channel an enemy within
-- 900 (the danger); then one the remaining shots kill; then the target selector (Combo) or the cursor (bind).
function XerathChampion:RTarget(manual)
 local selected=_G.SDK.TargetSelector and _G.SDK.TargetSelector.Selected
 if self:Current(selected)and self:Allowed(selected)and GetDistance(selected.pos,myHero.pos)<=5000 then return selected end
 local c=self:Channel();local shots=c and c.remaining or profile.shots[myHero:GetSpellData(_R).level]or 0
 local mouse=point(mousePos);if manual and not mouse then return nil end
 local best,score
 for _,u in ipairs(self:Rows('enemy',5000))do
  if self:Allowed(u)and(not manual or GetDistance(u.pos,mouse)<=Menu.Misc.MouseRange:Value())then
   local d=GetDistance(u.pos,myHero.pos);local rank=3
   if self:ShotKills(u,1)then rank=0 elseif c and d<=900 then rank=1 elseif shots>1 and self:ShotKills(u,shots)then rank=2 end
   local row=self.targets[id(u)];local s=rank*10-row.node:Value()*.05+(manual and GetDistance(u.pos,mouse)/Menu.Misc.MouseRange:Value()or d/5000)
   if rank<3 or manual then if not best or s<score then best,score=u,s end end
  end
 end
 if best or manual then return best end
 local u=GetTarget(5000);return self:Current(u)and self:Allowed(u)and u or nil
end
-- Combo starts the channel only for a kill within its shots, allowing one miss.
function XerathChampion:RKills(u)
 local shots=profile.shots[myHero:GetSpellData(_R).level];if not shots or not finite(u.health)then return false end
 -- Shared kill rule from current health (the barrage lands over seconds; nobody else's hit is counted on).
 return(Core:Lethal(u,self.spells[_R].Delay,function()return self:Damage(u,_R)*math.max(1,shots-1)end,{kind='magical',now=true,margin=1,flat=0}))
end
function XerathChampion:StartR(u,context,permission)
 if self.charge or self:Channel()or not permission()or not self:Ready(_R)or not self:Current(u)or not self:Allowed(u)or not self:RSafe()or GetDistance(u.pos,myHero.pos)<Menu.Misc.RMin:Value()or not self:Aim(_R,u)then return false end
 local handle=u.handle
 return Core:Cast(HK_R,nil,{context=context,observe=function(q)return self:ObserveCast(q,profile.r)end,
  validate=function()return permission()and self:Ready(_R)and self:Current(u)and u.handle==handle and self:Allowed(u)and self:RSafe()and GetDistance(u.pos,myHero.pos)>=Menu.Misc.RMin:Value()and GetDistance(u.pos,myHero.pos)<=5000 end})
end
-- Xerath-7: the enemy the channel last aimed at, while visible, and where it is likely to be once it vanished.
function XerathChampion:TrackFocus(c,u)
 local p=u.pathing;c.focus={unit=u,handle=u.handle,pos=point(u.pos),to=p and p.hasMovePath and point(p.endPos)or nil,ms=u.ms,at=Game.Timer()}
end
function XerathChampion:Vanished(c)
 local f=c.focus;if not f then return nil end;local u=f.unit
 if not u or u.handle~=f.handle or u.dead==true then c.focus=nil;return nil end
 if u.visible~=false then if self:Current(u)then self:TrackFocus(c,u)end;return nil end
 local age=Game.Timer()-f.at;if age>profile.rVanish then return nil end
 local reach=(finite(f.ms)and f.ms or 0)*age
 local p=f.to and GetDistance(f.pos,f.to)>1 and f.pos:Extended(f.to,math.min(GetDistance(f.pos,f.to),reach))or f.pos
 return p,age,f
end
function XerathChampion:BlindShot(c,p,context,permission)
 if GetDistance(p,myHero.pos)>5000 or c.remaining<=0 or Game.Timer()<(c.lastPulse or c.started)+.6 or not self:Ready(_R,true)then return false end
 local function valid()local now=self:Channel();return permission()and now==c and now.remaining>0 and Game.Timer()>=(now.lastPulse or now.started)+.6 and GetDistance(p,myHero.pos)<=5000 end
 local options={context=context,range=5000,exceptions={channel='artillery'},owner='Xerath.blind',
  observe=function(q)return self:ObserveCast(q,profile.pulse)or self:ObserveCast(q,profile.shot)end,validate=function()return valid()end}
 if p:To2D().onScreen==false then options.world=p;options.ttl=50;return Core:Cast(HK_R,p:ToMM(),options)end
 options.prevalidateWorldCast=true;options.resolve=function()return valid()and{position=p}or nil end
 return Core:Cast(HK_R,p,options)
end
function XerathChampion:Artillery()
 local manual=Menu.Misc.RAssist:Value();local combo=GetMode()=='Combo'and Menu.Combo.R:Value();local c=self:Channel()
 -- Rerank ultimate (Auto Xerath): a channel the player started fires on its own (Misc.RAuto), bound to that
 -- channel: the context and permission end with it. It never starts R.
 local auto=not manual and not combo and c~=nil and Menu.Misc.RAuto:Value()
 if not manual and not combo and not auto then self:ReleaseLocks();return c~=nil end
 local context,permission
 if manual then context=Core:HeldContext(function()return Menu.Misc.RAssist:Value()end);permission=function()return Menu.Misc.RAssist:Value()end
 elseif combo then context=Core:ModeContext('Combo');permission=function()return Menu.Combo.R:Value()end
 else local channel=c;permission=function()return Menu.Misc.RAuto:Value()and self:Channel()==channel end;context=Core:HeldContext(permission)end
 if c then
  -- A target that just left vision: reveal its likely spot once, and shoot there once right after it vanished.
  local p,age,f=self:Vanished(c)
  if p then
   if not f.revealed then f.revealed=true;local ok,why=Core:Reveal(p,'Xerath.reveal',function()return self:Channel()==c end);f.revealReason=ok and 'requested'or why end
   if age<=profile.rBlind and not f.blind and self:BlindShot(c,p,context,permission)then f.blind=true
    Core.adapter:SetBlocked('XerathR','attack',true);Core.adapter:SetBlocked('XerathR','move',true)
    if Core.logger then Core:Trace('xerath_r_shot',{reason='blind',age=age})end;return true
   end
  end
 end
 local u=self:RTarget(manual);if not self:Current(u)then self:ReleaseLocks();return c~=nil end
 if not c then return self:StartR(u,context,manual and permission or function()return permission()and self:RKills(u)end)end
 -- Xerath-6: safety decides whether R starts, not whether a running channel keeps firing.
 Core.adapter:SetBlocked('XerathR','attack',true);Core.adapter:SetBlocked('XerathR','move',true)
 -- Xerath-5: while the channel has time to spare beyond the remaining shots, a shot waits for a precise hit
 -- unless the target cannot move.
 local slack=c.expires-Game.Timer()-c.remaining*profile.rShot
 local controlled=(GetHardCCDuration(u)or 0)>=self.spells[_R].Delay
 local chance=(slack>profile.rSlack and not controlled)and 3 or 2
 if self:Cast(_R,u,context,permission,nil,chance)then local row=c.targets[id(u)]or{handle=u.handle,requested=0,observed=0,hits=0};c.targets[id(u)]=row;row.requested=row.requested+1;self:TrackFocus(c,u)
  if Core.logger then Core:Trace('xerath_r_shot',{reason=controlled and 'immobile'or chance==3 and 'precise'or 'slack_spent',slack=slack,target=id(u)})end
 end;return true
end
function XerathChampion:ReleaseLocks()Core.adapter:SetBlocked('XerathR','attack',false);Core.adapter:SetBlocked('XerathR','move',false)end
function XerathChampion:CSUseful(u,slot,impact)
 if not self:Current(u)or u.type==Obj_AI_Hero or u.team==300 then return false end
 return Core:Rescue(u,impact or self.spells[slot].Delay+(slot==_E and GetDistance(u.pos,myHero.pos)/1400 or 0),function()return self:Damage(u,slot)end,readyAttack)
end
function XerathChampion:Farm(kind,node,context,rescue)
 if not self:Mana(node)then return false end;local slots={};for _,slot in ipairs({_Q,_W,_E})do local name=slot==_Q and'Q'or slot==_W and'W'or'E';if node[name]:Value()and self:Ready(slot)then slots[#slots+1]=slot end end;if #slots==0 then return false end
 local rows=self:Rows(kind,1500);if #rows==0 then return false end;local first=self.farmIndex[kind]or 1;if first>#rows then first=1 end;self.farmIndex[kind]=(first+math.min(6,#rows)-1)%#rows+1
 for _,slot in ipairs(slots)do local best,score
  for n=1,math.min(6,#rows)do local u=rows[(first+n-2)%#rows+1];local p=self:Aim(slot,u);local time=p and p.data.impact+(slot==_Q and self:ChargeWait(GetDistance(p.position,myHero.pos))or 0)
   if p and(not rescue or self:CSUseful(u,slot,time))then local count=self:Count(slot,p.position,kind,p.data.range)
    if(rescue and count==1 or not rescue and(kind~='lane'or count>=Menu.Clear.LaneClear.Count:Value()))and(not best or count>score)then best,score=u,count end
   end
  end
  if best then local name=slot==_Q and'Q'or slot==_W and'W'or'E';local permission=function()return node[name]:Value()and self:Mana(node)end
   local geometry=function(p)local count=self:Count(slot,p.position,kind,p.data.range);return rescue and count==1 or not rescue and(kind~='lane'or count>=Menu.Clear.LaneClear.Count:Value())end
   if slot==_Q then if self:StartQ(best,context,function()return node[name]:Value()end,geometry,rescue,node)then return true end
   elseif self:Cast(slot,best,context,function()return permission()and(not rescue or self:CSUseful(best,slot))end,geometry)then return true end
  end
 end;return false
end
function XerathChampion:Combat(mode,context)
 local node=Menu[mode];if not self:Mana(node)or not(node.Q:Value()and self:Ready(_Q)or node.W:Value()and self:Ready(_W)or node.E:Value()and self:Ready(_E))then return false end;context=context or Core:ModeContext(mode);local u=GetTarget(1500);if not self:Current(u)then return false end
 local function permitted(slot)return function()return node[slot]:Value()and self:Mana(node)end end
 if node.E:Value()and self:Buff(u,profile.e,true)then if node.W:Value()and self:Cast(_W,u,context,permitted('W'))then return true end end
 local control=function()return node.W:Value()and node.E:Value()end
 if control()and self:Approaching(u)and self:Chain(_E,u,_W,context,function()return control()and self:Mana(node)end,control)then return true end
 if control()and self:Chain(_W,u,_E,context,function()return control()and self:Mana(node)end,control)then return true end
 if node.Q:Value()then
  for _,slot in ipairs({_W,_E})do local name=slot==_W and'W'or'E';local allowed=function()return node[name]:Value()and node.Q:Value()end
   if allowed()and self:Chain(slot,u,_Q,context,function()return allowed()and self:Mana(node)end,allowed)then return true end
  end
 end
 if node.E:Value()and self:Cast(_E,u,context,permitted('E'))then return true end
 if node.W:Value()and self:Cast(_W,u,context,permitted('W'))then return true end
 return node.Q:Value()and self:StartQ(u,context,function()return node.Q:Value()end,nil,false,node)or false
end
function XerathChampion:Combo()return self:Combat('Combo')end
function XerathChampion:Harass()return self:Combat('Harass')end
function XerathChampion:ClearHarassAllowed()return Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)end
function XerathChampion:LaneClear()
 if not Core:FarmModeEnabled('lane')then return false end
 if self:ClearHarassAllowed()and self:Combat('Harass',Core:FarmContext('lane',function()return self:ClearHarassAllowed()end))then return true end
 return Menu.Clear.SpellFarm:Value()and self:Farm('lane',Menu.Clear.LaneClear,Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end),false)or false
end
function XerathChampion:JungleClear()return Core:FarmModeEnabled('jungle')and Menu.Clear.SpellFarm:Value()and self:Farm('jungle',Menu.Clear.JungleClear,Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end),false)or false end
function XerathChampion:LastHit()return self:Farm('lane',Menu.LastHit,Core:RescueContext(),true)end
function XerathChampion:Approaching(u)
 local p=u.pathing;return self:Current(u)and p and p.isDashing and point(p.endPos)and GetDistance(p.endPos,myHero.pos)<=450 and GetDistance(p.endPos,myHero.pos)<GetDistance(u.pos,myHero.pos)
end
-- Peel: an enemy champion that is already on top of Xerath (walked, flashed or blinked in) gets the stun as
-- well, not only one seen dashing in. 350 is inside every melee threat range and outside none of his own.
function XerathChampion:Threatening(u)
 return self:Approaching(u)or self:Current(u)and GetDistance(u.pos,myHero.pos)<=profile.peelRange
end
function XerathChampion:AntiGap()
 if not Menu.Misc.AntiGap:Value()or not self:Ready(_E)or self.charge or self:Channel()then return false end
 for _,u in ipairs(self:Rows('enemy',1125))do if self:Threatening(u)and self:Cast(_E,u,{},function()return Menu.Misc.AntiGap:Value()and self:Threatening(u)end)then return true end end;return false
end
-- Shared kill rule per ability at its own impact time. W counts its outer damage only (the centre is a bonus).
function XerathChampion:Kills(slot,u,impact)
 if not self:Current(u)or u.type~=Obj_AI_Hero or IsInvulnerable(u)then return false end
 local s=self.spells[slot];impact=impact or s.Delay+(s.Speed==math.huge and 0 or GetDistance(u.pos,myHero.pos)/s.Speed)
 return(Core:Lethal(u,impact,function()return self:Damage(u,slot)end,{kind='magical'}))
end
-- A killable enemy is finished without a mode key: W, then E, then a Q charge held only while the kill stands.
function XerathChampion:Finishers()
 if self.charge or self.chain or self:Channel()then return false end
 local w,e,q=self:Ready(_W),self:Ready(_E),self:Ready(_Q);if not(w or e or q)then return false end
 local rows=self:Rows('enemy',1500);local context={priority='interactive'}
 for i=1,math.min(#rows,5)do local u=rows[i]
  if w and self:Kills(_W,u)and self:Cast(_W,u,context,function()return self:Kills(_W,u)end)then return true end
  if e and self:Kills(_E,u)and self:Cast(_E,u,context,function()return self:Kills(_E,u)end)then return true end
  -- The charge needs up to 1.5 s to reach 1500: the kill is judged at that later impact.
  local wait=.5+self:ChargeWait(GetDistance(u.pos,myHero.pos))
  if q and self:Kills(_Q,u,wait)and self:StartQ(u,context,function()local c=self.charge;return self:Kills(_Q,c and c.target or u,.5)end,nil,false)then self.charge.finisher=true;return true end
 end
 return false
end
-- A stun or slow on a chaser while fleeing has no downside: no switches.
function XerathChampion:Flee()
 if not(self:Ready(_E)or self:Ready(_W))then return false end
 local u=GetTarget(1125);if not self:Current(u)then return false end;local context=Core:ModeContext('Flee')
 if self:Cast(_E,u,context,function()return true end)then return true end
 return self:Cast(_W,u,context,function()return true end)or false
end
-- Xerath-9: with the Mana Surge on-hit ready, the champion inside attack range is the attack target (mana restore
-- doubled against champions). A short lease the core releases; never vetoes attacks.
function XerathChampion:Passive()
 local mode=GetMode();if mode~='Combo'and mode~='Harass'and mode~='LaneClear'then return false end
 if not self:Buff(myHero,profile.passive,true)then return false end
 local best;for _,u in ipairs(self:Rows('enemy',1500))do if _G.SDK.Data:IsInAutoAttackRange(myHero,u)and(not best or u.health<best.health)then best=u end end
 return best~=nil and Core:PreferAttack('Xerath.passive',best,.25)
end
-- Xerath-1: E (else W) on enemies who cannot move (hard control, channels) while the stun still lands in time;
-- timed onto the spot where a stasis, revive or teleport/gate arrival ends. No mode key, always on.
function XerathChampion:ZoneCast(slot,pos,valid)
 local key=slot==_E and HK_E or HK_W;local range=slot==_E and 1125 or 1000
 local function ok()
  if not self:Ready(slot)or self.charge or self:Channel()or GetDistance(pos,myHero.pos)>range or not valid()then return false end
  if slot==_E then local wall,_,n=OrbamaPrediction:GetCollision(myHero.pos,pos,1400,.25,60,self.spells[_E].CollisionTypes);return wall==false and finite(n)and n==0 end
  return true
 end
 if not ok()then return false end
 return Core:Cast(key,pos,{owner='Xerath.zone',context={priority='interactive'},range=range,prevalidateWorldCast=true,deferAttackWindup=true,
  observe=function(q)return self:ObserveCast(q)end,resolve=function()return ok()and{position=pos}or nil end,validate=function()return ok()end})
end
local zoneSpec={range=1125,arm=.25,lifetime=4}
-- The current end of the evidence behind `row` (a fresh scan): the stun, channel or stasis may have changed.
function XerathChampion:ZoneLeft(row)
 if not row.valid()then return nil end
 for _,r in ipairs(Core:ZoneTargets(zoneSpec))do
  if r.kind==row.kind and(row.unit and r.unit==row.unit or not row.unit and GetDistance(r.position,row.position)<=50)then return r.freeAt-Game.Timer()end
 end
end
function XerathChampion:AutoZone()
 if self.charge or self:Channel()then return false end
 local e,w=self:Ready(_E),self:Ready(_W);if not(e or w)then return false end
 local context={priority='interactive'};local wTime=self.spells[_W].Delay
 for _,row in ipairs(Core:ZoneTargets(zoneSpec))do
  local d=GetDistance(row.position,myHero.pos);local left=row.freeAt-Game.Timer();local eTime=.25+d/1400
  local u=row.unit
  if(row.kind=='control'or row.kind=='channel')and u and self:Current(u)then
   local function still(t)return function()local l=self:Current(u)and self:ZoneLeft(row);return l~=nil and l~=false and l>=t()end end
   if e and left>=eTime and self:Cast(_E,u,context,still(function()return .25+GetDistance(u.pos,myHero.pos)/1400 end))then return true end
   if w and d<=1000 and left>=wTime and self:Cast(_W,u,context,still(function()return wTime end))then return true end
  elseif row.kind~='control'and row.kind~='channel'then
   -- Lands no earlier than the end and at most 0.15 s (E) / 0.2 s (W) after it.
   local function timed(t,late)return function()local l=self:ZoneLeft(row);return l~=nil and t>=l and t<=l+late end end
   if e and eTime>=left and eTime<=left+.15 and self:ZoneCast(_E,row.position,timed(eTime,.15))then return true end
   if w and d<=1000 and wTime>=left and wTime<=left+.2 and self:ZoneCast(_W,row.position,timed(wTime,.2))then return true end
  end
 end
 return false
end
function XerathChampion:PostAttack(args)
 if not Core:Available()then return end;local a=Core:AttackWitness(self.lastAttack,args and args.Target);if not a or a==self.lastAttack or a.at>Game.Timer()then return end;self.lastAttack=a;self.lastPassiveAttack={at=a.at,target=a.target,passiveCandidate=self:Buff(myHero,'XerathAscended2OnHit',true)~=nil}
end
function XerathChampion:PreparePreview()
 local c=self:Channel();local range=self.charge and self:ChargeRange(self.charge)or profile.qMin
 local rReady=c~=nil or self:Ready(_R);local kills={}
 if Menu.Draw.RKills:Value()and rReady then local most=c and c.remaining or profile.shots[myHero:GetSpellData(_R).level]
  for _,u in ipairs(self:Rows('enemy',5000))do if #kills>=5 then break end
   local n=self:ShotsToKill(u,most);if n then kills[#kills+1]={unit=u,handle=u.handle,shots=n}end
  end
 end
 self.preview={expires=Game.Timer()+1,qrange=range or profile.qMin,kills=kills,rReady=rReady,qReady=self.charge~=nil or self:Ready(_Q),wReady=self:Ready(_W),eReady=self:Ready(_E)}
end
function XerathChampion:Tick()
 if not Core:Available()then self:CloseCharge('input_unavailable');self:ReleaseLocks();self.chain=nil;self.preview=nil;return end
 self:CollectPhases();self:ObserveChannel();if Game.Timer()>=(self.nextDiscovery or 0)then self:Discover()end
 if self.previewFallback and Game.Timer()>=(self.nextPreview or 0)then self.nextPreview=Game.Timer()+.15;self:PreparePreview()end
 if self:MaintainCharge()then return end
 if ShouldWait()then self.chain=nil;self:ReleaseLocks();return end
 if self:NativeCharge()then self:AdoptQ();return end
 if self:Artillery()or self:ContinueChain()or IsCasting()then return end
 self:Passive()
 if self:AntiGap()or self:AutoZone()or self:Finishers()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LaneClear'then if not self:LaneClear()then self:JungleClear()end elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and Game.Timer()>=(self.nextPreview or 0)then self.nextPreview=Game.Timer()+.15;self:PreparePreview()end
end
function XerathChampion:Draw()
 if myHero.dead then return end;local p=self.preview;if not p or p.expires<=Game.Timer()then return end
 if Menu.Draw.Ranges:Value()then
  if p.qReady then Draw.Circle(myHero.pos,p.qrange,1,Draw.Color(255,160,210,245))end
  if p.wReady then Draw.Circle(myHero.pos,1000,1,Draw.Color(255,160,210,245))end
  if p.eReady then Draw.Circle(myHero.pos,1125,1,Draw.Color(255,160,210,245))end
 end
 if Menu.Draw.RMinimap:Value()and p.rReady and Draw.CircleMinimap then Draw.CircleMinimap(myHero.pos,5000,1,Draw.Color(255,160,210,245))end
 if p.rReady and Menu.Misc.RAssist:Value()and point(mousePos)then Draw.Circle(mousePos,Menu.Misc.MouseRange:Value(),1,Draw.Color(200,255,200,120))end
 if Menu.Draw.RKills:Value()then for _,k in ipairs(p.kills or {})do local u=k.unit
  if u and u.handle==k.handle and u.visible~=false and not u.dead and u.pos2D then Draw.Text('R: '..k.shots..(k.shots==1 and' shot'or' shots'),16,u.pos2D.x-30,u.pos2D.y-60,Draw.Color(255,255,90,90))end
 end end
end
function XerathChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Xerath: modes','Xerath: channel'},function(page)return{title='Xerath assistance',cards=page==1 and{
  {'MODES','Provider Combo/Harass, separate local Lane/Jungle, isolated LastHit rescue and Flee. Spell farming and farm-bound Harass have separate permission. Resources and queued modes stay bound to their trigger.'},
  {'CHARGE','Combo and Harass charge Q on the current target. The public provider owns only its own Q key, slot and finite charge. Native start and own charge buff precede a current predicted release. Movement stays available while charging. A Q charge you start yourself is aimed and fired for you once you let go of the key.'},
  {'CONTROL','A landed W or E is always followed by the next ability; the slow or stun must come from your own cast. E collision uses its actual outgoing ray, including new blockers. Readiness alone never suppresses mana-restoring attacks. A killable enemy is finished with W, E or Q without a mode key, and E also stuns an enemy who dashes onto you or stands next to you. Without a mode key, E (else W) also lands on an enemy who cannot move, or where a stasis, revive or teleport ends. A long E needs a precise prediction unless the target cannot move. A Q charge moves to an enemy it kills, or to a new target if the first one is lost. With the passive ready, an enemy champion in attack range is attacked for the mana.'}}or{
  {'ARTILLERY','The R bind starts R and fires at enemies near the cursor. An explicitly selected target has precedence. Combo R has its own switch and starts only when the remaining shots can kill, allowing one miss. The channel must have native activation and an owned finite buff before shooting. Shots go first to an enemy one shot kills, then to an enemy close to you, then to one the remaining shots kill; while time is left a shot waits for a precise hit. A running channel keeps firing when an enemy comes close, and a channel you start yourself fires on its own. A target that walks into fog is revealed with your trinket or a ward and gets one shot where it is headed.'},
  {'SHOTS','Native shot starts, requested casts and candidate ramp buffs remain separate. The displayed remaining value is an upper ceiling, not a verified hit count or guaranteed lethal barrage. A missing loaded Classic kit stays inactive.'},
  {'CLEANUP','Releasing a mode/key, manual takeover, lost target, chat, focus, death or disable closes owned work. Ending a charge can release an already begun Q. Cleanup is not an undo or a confirmed hit; uncertain inputs are never replayed.'}}}end)
end
-- LaneClear carries no spell-farm condition: harassing while lane clearing has its own switch.
Core:StandardPolicy(XerathChampion,{damageTypes={Q='magical',W='magical',E='magical',R='magical'},methods={LaneClear=function()return Core:FarmContext('lane')end},
 channel=function(self)return not self.charge and not self:Channel()and not Core:SelfChanneling()end,exceptions={charge_begin=true,charge_release=true,artillery=true},
 costPaid=function(self,q,slot)return slot==_R and q.spellName==profile.shot and self:Channel()~=nil or slot==_Q and q.owner=='Xerath.adoptQ'end,
 validate=function(self,q,slot)
  if slot==_Q and q.owner=='Xerath.adoptQ'then return self:NativeCharge()~=nil end
  return type(slot)~='number'or slot<0 or slot>3 or self:Ready(slot,slot==_R and q.spellName==profile.shot)end})
XerathChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={}
local normalSupported={["Xerath"]=true}

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
