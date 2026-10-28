return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Nami"]=function()return _G.OrbamaFamily:Require("af500cbdadfad0501133a23840a054e6db876d1f79e4307ff45d5d19736c2041")()end
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
if champion=="Nami" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Nami',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent controller; asset/reference differences are recorded in
-- CombatProfiles/nami-provenance.json. Future W bounces are projections, not hits.
local profiles=ChampionProfiles('Nami')
local finite,identity,point,manaAbove,buffExpiry=Core.finite,Core.id,Core.point,Core.manaAbove,Core.buffExpiry
-- Pinned by this champion's regressions: only a ready, in-range lethal attack keeps the spell (Core:Rescue).
local readyAttack={attack='ready'}
local function cleanup(self)self.preview=nil;self.allySettings={};self.eObservation=nil end
local NamiChampion=class("NamiChampion")
function NamiChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self:LoadMenu();self.allySettings={};self:DiscoverAllies()
 self.QRange=850;self.WRange=725;self.ERange=800;self.RRange=2200
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=.95,Radius=155,Range=850,Speed=math.huge,Collision=false}
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.5,Radius=170,Range=2200,Speed=850,Collision=true,MaxCollision=0,
  CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}}
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 Core:RegisterCleanup('Nami',function()cleanup(self)end)
 local registered,why=Core:RegisterPreparation('Nami.preview',{intervalMs=150,maxDelayMs=500,units=2,maxUnits=2},
  function()self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.preparation=registered;self.previewFallback=not registered and why=='unsupported'
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
 -- W on herself, offered to Evade as an instant heal when a hit cannot be dodged (S6). Heal from the profile
 -- (wiki 2026-10-10: Normal 55-155 +40% AP, Classic 65-185 +30% AP), cast .25 s.
 Core:RegisterEffect({kind='heal',name='NamiW',slot=_W,key=HK_W,profile=self.profile.id,spell=self.profile.w,delay=self.profile.wCast,
  source='CombatProfiles/ChampionProfiles/Nami.lua wHeal/healAP (wiki read 2026-10-10)',
  amount=function()local rank=myHero:GetSpellData(_W).level;local base=self.profile.wHeal[rank]
   return base and finite(myHero.ap)and base+self.profile.healAP*myHero.ap or nil end,
  ready=function()return self:Ready(_W)and self:AllyAllowed(myHero,'Heal')end,target=function()return myHero end})
end
function NamiChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Nami'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 15,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R',value=true})
 Menu.Combo:MenuElement({id='Count',name='R must hit this many enemies',value=2,min=1,max=5,step=1})
 Menu.Combo:MenuElement({id='RKill',name='Use R to finish an enemy Q and W cannot',value=true})
 Menu:MenuElement({type=MENU,id='Support',name='Help allies without holding a mode key'})
 Menu.Support:MenuElement({id='HealHP',name='Heal allies below health %',value=50,min=5,max=90,step=5})
 Menu.Support:MenuElement({id='Mana',name='Only above mana %',value=10,min=0,max=100,step=5})
 Menu.Support:MenuElement({id='E',name='Use E on an ally who is attacking an enemy',value=true})
 Menu.Support:MenuElement({type=MENU,id='Allies',name='Ally priority (0 = never)'})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=kind,name=kind})
  Menu.Clear[kind]:MenuElement({id='Q',name='Use Q',value=true})
  Menu.Clear[kind]:MenuElement({id='E',name='Use E on your own attacks',value=true})
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions Q must hit',value=3,min=1,max=10,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='QAssist',name='Cast Q at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('U')})
 Menu.Misc:MenuElement({id='Interrupt',name='Interrupt enemy channels with Q',value=true})
 Menu.Misc:MenuElement({id='FleeQ',name='Use Q on a chasing enemy in Flee',value=true})
  Menu.Misc:MenuElement({id='ControlQ',name='Q immobilised enemies without a mode key',value=true})
  Menu.Misc:MenuElement({id='ControlMana',name='Automatic Q only above mana %',value=20,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='DashQ',name='Bubble enemies dashing onto you or an ally',value=true})
 Menu.Misc:MenuElement({id='QCount',name='Automatic Q at this many enemies hit (0 = off)',value=3,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='RPeel',name='Use R on enemies diving you or an ally',value=true})
 Menu.Misc:MenuElement({id='RCount',name='Automatic R at this many enemies hit (0 = off)',value=3,min=0,max=5,step=1})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Preview',name='R aim and hit count while using the R bind',value=true})
end
function NamiChampion:Rows(side,range)
 local rows=Core:Rows('hero',range,side=='ally')
 -- W and E treat Nami as the first ally, whether or not the roster lists her.
 if side=='ally'then
  for i=#rows,1,-1 do if identity(rows[i])==identity(myHero)then table.remove(rows,i)end end
  if IsValid(myHero)then table.insert(rows,1,myHero)end
 end
 return rows
end
function NamiChampion:Current(u)return u~=nil and point(u.pos)~=nil and Core:CurrentUnit(u,u.team==myHero.team)end
function NamiChampion:DiscoverAllies()
 for _,u in ipairs(self:Rows('ally',3000))do local id=identity(u)
  if not self.allySettings[id]then local key=StableUnitMenuKey(self,'P',u)
   -- One priority per ally for W and E: higher is helped first, 0 never.
   Menu.Support.Allies:MenuElement({id=key,name=u.charName,value=3,min=0,max=5,step=1})
   local node=Menu.Support.Allies[key]
   self.allySettings[id]={node=node,handle=u.handle}
  elseif self.allySettings[id].handle~=u.handle then self.allySettings[id].handle=u.handle end
 end
 self.nextDiscovery=Game.Timer()+1
end
function NamiChampion:AllyAllowed(u,key)
 local row=self.allySettings[identity(u)]
 return row and row.handle==u.handle and row.node:Value()>0
end
function NamiChampion:Priority(u)local row=self.allySettings[identity(u)];return row and row.node:Value()or 1 end
function NamiChampion:Ready(slot)
 local d=myHero:GetSpellData(slot);local name=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot]
 return name and d and d.name==self.profile[name]and finite(d.level)and d.level%1==0 and d.level>=1 and d.level<=(slot==_R and 3 or 5)and finite(d.currentCd)
  and d.currentCd==0 and Game.CanUseSpell(slot)==0 and finite(d.mana)and d.mana>=0 and d.mana<=myHero.mana or false
end
function NamiChampion:Damage(u,slot,bounce)
 local rank=myHero:GetSpellData(slot).level;local base=slot==_Q and self.profile.qBase[rank]or slot==_W and self.profile.wDamage[rank]
  or slot==_E and self.profile.eBase[rank]or({150,250,350})[rank]
 if not base or not finite(myHero.ap)then return 0 end
 local ratio=slot==_Q and self.profile.qAP or slot==_W and .5 or slot==_E and .2 or self.profile.rAP
 local factor=slot==_W and math.max(0,1+self.profile.bounce+self.profile.bounceAP*myHero.ap)^(bounce or 0)or 1
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,(base+ratio*myHero.ap)*factor)
end
function NamiChampion:GetQDmg(u)return self:Damage(u,_Q)end
function NamiChampion:GetWDmg(u)return self:Damage(u,_W)end
function NamiChampion:GetEDmg(u)return self:Damage(u,_E)end
function NamiChampion:GetRDmg(u)return self:Damage(u,_R)end
function NamiChampion:Heal(u,bounce)
 local rank=myHero:GetSpellData(_W).level;local base=self.profile.wHeal[rank]
 if not base or not finite(myHero.ap)or not finite(u.maxHealth)or not finite(u.health)then return 0 end
 local falloff=self.profile.healBounce or(self.profile.bounce+self.profile.bounceAP*myHero.ap)
 return math.min(math.max(0,u.maxHealth-u.health),(base+self.profile.healAP*myHero.ap)*math.max(0,1+falloff)^(bounce or 0))
end
function NamiChampion:WInput(anchor,healOnly)
 local input={allies=self:Rows('ally',2025),enemies=self:Rows('enemy',2025),effects={}}
 local rank=myHero:GetSpellData(_W).level;local ap=myHero.ap
 if not self.profile.wDamage[rank]or not self.profile.wHeal[rank]or not finite(ap)then return nil end
 local damage=self.profile.wDamage[rank]+.5*ap;local heal=self.profile.wHeal[rank]+self.profile.healAP*ap
 local damageFactor=math.max(0,1+self.profile.bounce+self.profile.bounceAP*ap)
 local healFactor=math.max(0,1+(self.profile.healBounce or self.profile.bounce+self.profile.bounceAP*ap))
 for _,rows in ipairs({input.allies,input.enemies})do for _,u in ipairs(rows)do
  local effects={};input.effects[u]=effects
  local allowed=u.team~=myHero.team or self:AllyAllowed(u,'Heal');local priority=u.team==myHero.team and 1+self:Priority(u)*.2 or 1
  local relevant=u.team==myHero.team or not healOnly and(not anchor or identity(u)==identity(anchor)and u.handle==anchor.handle)
  for stage=1,3 do
   local healing=u.team==myHero.team and math.min(math.max(0,u.maxHealth-u.health),heal*healFactor^(stage-1))or 0
   local dmg=u.team~=myHero.team and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,damage*damageFactor^(stage-1))or 0
   effects[stage]={heal=healing,damage=dmg,score=allowed and relevant and(healing+dmg)*priority or 0}
  end
 end end
 return input
end
function NamiChampion:WPaths(first,anchor,healOnly,input)
 if not self:Current(first)or first.type~=Obj_AI_Hero or GetDistance(first.pos,myHero.pos)>725 then return nil end
 input=input or self:WInput(anchor,healOnly);if not input then return nil end
 local allies,enemies=input.allies,input.enemies;local paths={};local work=0
 local function value(u,index)local rows=input.effects[u];return rows and rows[index].score or 0 end
 local function append(a,b,c)
  work=work+1;if work>180 then return end
  local list={a};if b then list[2]=b end;if c then list[3]=c end
  local score=0;local healing,damage=0,0
  for i,u in ipairs(list)do local effect=input.effects[u]and input.effects[u][i]
   if effect then score=score+effect.score;healing=healing+effect.heal;damage=damage+effect.damage end
  end
  paths[#paths+1]={units=list,score=score,heal=healing,damage=damage}
 end
 local opposite=first.team==myHero.team and enemies or allies
 for _,second in ipairs(opposite)do
  if identity(second)~=identity(first)and GetDistance(first.pos,second.pos)<=650 then
   local last=first.team==myHero.team and allies or enemies;local found=false
   for _,third in ipairs(last)do
    if identity(third)~=identity(first)and identity(third)~=identity(second)and GetDistance(second.pos,third.pos)<=650 then append(first,second,third);found=true end
   end
   if not found then append(first,second)end
  end
 end
 if #paths==0 then append(first)end
 -- The host chooses subsequent recipients. Rank the least useful legal branch;
 -- the direct effect remains the only guaranteed effect before live observations.
 local worst,best=paths[1],paths[1]
 for i=2,#paths do if paths[i].score<worst.score then worst=paths[i]end;if paths[i].score>best.score then best=paths[i]end end
 return {first=first,handle=first.handle,paths=paths,score=value(first,1)+math.max(0,worst.score-value(first,1))*.35,
  direct=value(first,1),worst=worst,best=best,work=work}
end
function NamiChampion:ChooseW(anchor,healOnly)
 local input=self:WInput(anchor,healOnly);if not input then return nil end
 local best;local allies=input.allies
 for _,u in ipairs(allies)do if GetDistance(u.pos,myHero.pos)<=725 and self:AllyAllowed(u,'Heal')then local row=self:WPaths(u,anchor,healOnly,input)
  if row and row.direct>0 and(not best or row.score>best.score)then best=row end
 end end
 if not healOnly and self:Current(anchor)and GetDistance(anchor.pos,myHero.pos)<=725 then
  local row=self:WPaths(anchor,anchor,false,input);if row and(not best or row.score>best.score)then best=row end
 end
 return best
end
function NamiChampion:CastW(first,anchor,context,permission,healOnly)
 if not self:Ready(_W)or not self:Current(first)or(permission and not permission())then return false end
 local handle=first.handle;local anchorHandle=anchor and anchor.handle;local path=self:WPaths(first,anchor,healOnly)
 if not path or path.direct<=0 then return false end
 return Core:Cast(HK_W,first,{context=context,range=725,validate=function()
  if not self:Ready(_W)or first.handle~=handle or not self:Current(first)or(permission and not permission())
   or(anchor and(anchor.handle~=anchorHandle or not self:Current(anchor)))then return false end
  local row=self:WPaths(first,anchor,healOnly)
  return row and row.direct>0 and(first.team~=myHero.team or self:AllyAllowed(first,'Heal'))
 end})
end
function NamiChampion:HealAssist()
 if not manaAbove(Menu.Support.Mana:Value())or not self:Ready(_W)then return false end
 local best,score
 for _,u in ipairs(self:Rows('ally',725))do if self:AllyAllowed(u,'Heal')and self:HealNeeded(u)then
  local current=(100-u.health/u.maxHealth*100)*self:Priority(u)
  if not best or current>score then best=u;score=current end
 end end
 if best then
  return self:CastW(best,nil,{priority='critical'},function()return manaAbove(Menu.Support.Mana:Value())and self:HealNeeded(best)end,true)
 end
 -- Second tier (Auto's bounce limit): a lighter heal whose every bounce also reaches an enemy champion,
 -- above the Harass mana minimum. The real heal above keeps the critical priority.
 if not manaAbove(Menu.Harass.Mana:Value())then return false end
 for _,u in ipairs(self:Rows('ally',725))do if self:AllyAllowed(u,'Heal')and self:HealAndPoke(u)then
  local current=(100-u.health/u.maxHealth*100)*self:Priority(u)
  if not best or current>score then best=u;score=current end
 end end
 if not best then return false end
 return self:CastW(best,nil,{priority='interactive'},function()return manaAbove(Menu.Harass.Mana:Value())and self:HealAndPoke(best)end,false)
end
function NamiChampion:HealAndPoke(u)
 if not finite(u.health)or not finite(u.maxHealth)or u.maxHealth<=0 then return false end
 local limit=Menu.Support.HealHP:Value()
 if limit<=0 or u.health/u.maxHealth*100>math.min(90,limit+20)then return false end
 local row=self:WPaths(u,nil,false)
 return row~=nil and row.direct>0 and row.worst~=nil and row.worst.damage>0
end
-- Below the health limit always. While an enemy champion's attack, targeted cast
-- or tracked skillshot is about to hit the ally (Core:AllyThreat; minion and
-- turret damage are not evidence): health after that attack's damage estimate
-- (Auto's incoming-damage rule) under the limit, or within 25 points of it
-- (capped at 90 %), so the heal lands in the trade instead of after it.
function NamiChampion:HealNeeded(u)
 if not finite(u.health)or not finite(u.maxHealth)or u.maxHealth<=0 then return false end
 local percent,limit=u.health/u.maxHealth*100,Menu.Support.HealHP:Value()
 if percent<=limit then return true end
 if limit<=0 then return false end
 local threat=Core:AllyThreat(u,1.5,{turrets=false})
 if not threat then return false end
 local damage=finite(threat.damage)and threat.damage or nil
 if not damage and threat.kind=='attack'and IsValid(threat.source)then
  -- An enemy's attack estimate reads its items; an unreadable one only leaves the +25 rule.
  local ok,value=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,threat.source,u)
  damage=ok and value or nil
 end
 if finite(damage)and damage>0 and(u.health-damage)/u.maxHealth*100<=limit then return true end
 return percent<=math.min(90,limit+25)
end
function NamiChampion:EBuff(u)
 local b=Core:OwnBuff(u,self.profile.eBuff,true)
 return b and b.count<=3 and b.count%1==0 and b or nil
end
function NamiChampion:EActive(u)
 if not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 then return true end
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and b.name==self.profile.eBuff then
   local expiry=buffExpiry(b)
   if not finite(expiry)or not finite(b.count)or expiry>Game.Timer()and b.count>0 then return true end
  end
 end
 return false
end
function NamiChampion:EOpportunity(u,farm,token)
 if not self:Current(u)or u.team~=myHero.team or GetDistance(u.pos,myHero.pos)>800 or not self:AllyAllowed(u,'E')or self:EActive(u)then return nil end
 if farm and(farm~='lane'and farm~='jungle'or u~=myHero)then return nil end
 local a=u.activeSpell;local now=Game.Timer()
 if not a or not a.valid or a.isStopped or not finite(a.startTime)or not finite(a.castEndTime)or a.startTime>now
  or a.castEndTime<=now+.05 or a.castEndTime-now>1.5 or(token and(token.start~=a.startTime or token.name~=a.name or token.target~=a.target))then return nil end
 local attack=Core:IsAttackCast(a);if not attack and(not self.profile.spellE or farm or a.isChanneling)then return nil end
 local list={}
 if farm then
  list=self:FarmRows(farm)
 else list=self:Rows('enemy',3000)end
 for i=1,math.min(#list,farm and 52 or 5)do local enemy=list[i]
  if IsValid(enemy)and(enemy.networkID==a.target or enemy.handle==a.target)and enemy.team~=myHero.team then
   if token and token.enemyHandle~=enemy.handle then return nil end
   return {name=a.name,start=a.startTime,target=a.target,enemy=enemy,enemyHandle=enemy.handle,attack=attack}
  end
 end
end
function NamiChampion:CastE(u,context,permission,farm)
 if not self:Ready(_E)or(permission and not permission())then return false end
 local token=self:EOpportunity(u,farm);if not token then return false end
 local handle=u.handle
 return Core:Cast(HK_E,u,{context=context,range=800,validate=function()return self:Ready(_E)and u.handle==handle
  and self:EOpportunity(u,farm,token)~=nil and(not permission or permission())end,
  observe=function(q)local b=self:EBuff(u);return b~=nil and u.handle==handle and self:Current(u)and q.requestGameTime<=Game.Timer()end})
end
function NamiChampion:EAssist(context,permission)
 if not self:Ready(_E)then return false end
 local best,score
 for _,u in ipairs(self:Rows('ally',800))do local token=self:EOpportunity(u,false)
  if token then local current=self:Priority(u)*100+(token.attack and 20 or 0)+(u.totalDamage or 0)*.05
   if not best or current>score then best=u;score=current end
  end
 end
 return best and self:CastE(best,context,permission,false)or false
end
function NamiChampion:CastQ(u,context,permission)
 if not self:Ready(_Q)or not self:Current(u)or u.team==myHero.team or GetDistance(u.pos,myHero.pos)>850 or(permission and not permission())then return false end
 local pred=Core:Prediction(self.QSpell);pred:GetPrediction(u,myHero)
 if not pred:CanHit(2)or not point(pred.CastPosition)then return false end
 local handle=u.handle
 return Core:Cast(HK_Q,pred.CastPosition,{context=context,range=850,intentTarget=u,prevalidateWorldCast=true,deferAttackWindup=true,
   validate=function(_,resolved)return self:Ready(_Q)and u.handle==handle and self:Current(u)and u.team~=myHero.team
    and GetDistance(u.pos,myHero.pos)<=850 and(not permission or permission(resolved and resolved.position or pred.CastPosition))end})
end
-- Multi-enemy Q (Auto, Sikaka): predicted positions of up to five enemies near Q range; candidate centres
-- are each prediction and each pair midpoint within reach; the plan with the most enemies inside the
-- bubble wins (with an anchor, only plans that contain it).
function NamiChampion:QPlan(anchor)
 if not self:Ready(_Q)then return nil end
 local pred=Core:Prediction(self.QSpell);local rows={};local enemies=self:Rows('enemy',850+self.QSpell.Radius+100)
 for i=1,math.min(#enemies,8)do local u=enemies[i]
  if #rows>=5 then break end
  if self:Current(u)and u.team~=myHero.team then pred:GetPrediction(u,myHero);local p=point(pred.CastPosition)
   if p and pred:CanHit(2)then rows[#rows+1]={unit=u,pos=p}end
  end
 end
 local best;local origin=myHero.pos
 local function consider(x,z)
  if(x-origin.x)^2+(z-origin.z)^2>850*850 then return end
  local n,has,main=0,false,nil
  for _,r in ipairs(rows)do local reach=self.QSpell.Radius+(r.unit.boundingRadius or 0)
   if(r.pos.x-x)^2+(r.pos.z-z)^2<=reach*reach then n=n+1;main=main or r.unit
    if anchor and identity(r.unit)==identity(anchor)and r.unit.handle==anchor.handle then has=true end
   end
  end
  if n==0 or anchor and not has then return end
  if not best or n>best.count then best={position={x=x,y=origin.y,z=z},count=n,unit=has and anchor or main}end
 end
 for i=1,#rows do consider(rows[i].pos.x,rows[i].pos.z)
  for j=i+1,#rows do consider((rows[i].pos.x+rows[j].pos.x)/2,(rows[i].pos.z+rows[j].pos.z)/2)end
 end
 return best
end
function NamiChampion:CastQPlan(anchor,need,context,permission)
 if not self:Ready(_Q)or(permission and not permission())then return false end
 local plan=self:QPlan(anchor);if not plan or plan.count<need then return false end
 -- The resolver keeps the plan's unit inside the bubble, so the cast never drifts to other enemies.
 local unit=plan.unit;local handle=unit.handle;local keep=anchor or unit
 return Core:Cast(HK_Q,plan.position,{context=context,range=850,intentTarget=unit,prevalidateWorldCast=true,deferAttackWindup=true,
  resolve=function()
   if unit.handle~=handle or(permission and not permission())then return nil,'q_plan_changed'end
   local fresh=self:QPlan(keep);if not fresh or fresh.count<need then return nil,'q_plan_count'end
   return {position=fresh.position,data={count=fresh.count}}
  end,
  validate=function(_,resolved)return self:Ready(_Q)and unit.handle==handle and self:Current(unit)and(not permission or permission())
   and(not resolved or not resolved.data or(resolved.data.count or 0)>=need)end})
end
-- Keyless multi-enemy Q above the automatic-Q mana limit, outside Combo and Harass.
function NamiChampion:MultiQ()
 local need=Menu.Misc.QCount:Value()
 if need<=0 or not self:Ready(_Q)or not manaAbove(Menu.Misc.ControlMana:Value())then return false end
 local mode=GetMode();if mode=='Combo'or mode=='Harass'then return false end
 local function permission()return Menu.Misc.QCount:Value()==need and manaAbove(Menu.Misc.ControlMana:Value())end
 return self:CastQPlan(nil,need,{priority='interactive',condition=permission},permission)
end
-- Q on a gap-closer's landing (Auto OnBlink, with an evidence rule): the bubble lands .99 s after the cast,
-- so it is sent at the dash end only when the enemy cannot walk out of it between landing and impact, or
-- when a melee diver lands inside its attack reach of the victim (it stands there to attack).
function NamiChampion:DashQ()
 if not Menu.Misc.DashQ:Value()or not self:Ready(_Q)or not manaAbove(Menu.Misc.ControlMana:Value())then return false end
 local victims={};for _,u in ipairs(self:Rows('ally',1500))do if #victims<5 and(u==myHero or self:AllyAllowed(u,'Heal'))then victims[#victims+1]=u end end
 local enemies=self:Rows('enemy',1400)
 for i=1,math.min(#enemies,5)do local enemy=enemies[i]
  if self:Current(enemy)and enemy.pathing and enemy.pathing.isDashing then
   for _,victim in ipairs(victims)do
    local landing=Core:DashLanding(enemy,victim.pos,500,true)
    if landing and self:DashQUseful(enemy,victim,landing)then
     local to=point(landing.to);local handle,victimHandle=enemy.handle,victim.handle
     local function permission()
      local fresh=Menu.Misc.DashQ:Value()and manaAbove(Menu.Misc.ControlMana:Value())and enemy.handle==handle and victim.handle==victimHandle
       and Core:DashLanding(enemy,victim.pos,500,true)
      return fresh and GetDistance(fresh.to,to)<=60 or false
     end
     if Core:Cast(HK_Q,to,{context={priority='interactive'},range=850,validate=function()return self:Ready(_Q)and permission()end})then return true end
    end
   end
  end
 end
 return false
end
function NamiChampion:DashQUseful(enemy,victim,landing)
 local to=landing.to;if not point(to)or GetDistance(to,myHero.pos)>850 or not finite(landing.duration)then return false end
 local wait=self.profile.qImpact-landing.duration
 if wait<=0 then return true end
 local reach=self.QSpell.Radius+(enemy.boundingRadius or 0)-30
 if finite(enemy.ms)and enemy.ms>0 and wait<=reach/enemy.ms then return true end
 local range=enemy.range
 return finite(range)and range<=300 and GetDistance(to,victim.pos)<=range+(enemy.boundingRadius or 0)+(victim.boundingRadius or 0)
end
-- Finishers without a mode key (L9Nami KillSteal, with impact time, shields and the shared kill rule):
-- W on the direct hit (bounces are projections), then Q; R in Combo under its switch, only when Q and W
-- cannot, within 1300 and with no allied champion near the target to finish it.
function NamiChampion:WLethal(u)
 if not self:Current(u)or u.type~=Obj_AI_Hero or u.team==myHero.team then return false end
 local d=GetDistance(u.pos,myHero.pos);if d>725 then return false end
 return(Core:Lethal(u,self.profile.wCast+d/self.profile.wSpeed,function()return self:GetWDmg(u)end,{kind='magical'}))
end
function NamiChampion:QLethal(u)
 if not self:Current(u)or u.type~=Obj_AI_Hero or u.team==myHero.team or GetDistance(u.pos,myHero.pos)>850 then return false end
 return(Core:Lethal(u,self.profile.qImpact,function()return self:GetQDmg(u)end,{kind='magical'}))
end
function NamiChampion:RLethal(u)
 if not self:Current(u)or u.type~=Obj_AI_Hero or u.team==myHero.team then return false end
 local d=GetDistance(u.pos,myHero.pos);if d>1300 then return false end
 for _,ally in ipairs(self:Rows('ally',d+600))do
  if ally~=myHero and IsValid(ally)and GetDistance(ally.pos,u.pos)<=600 then return false end
 end
 return(Core:Lethal(u,.5+d/self.profile.rSpeed,function()return self:GetRDmg(u)end,{kind='magical'}))
end
function NamiChampion:KillSecure()
 local enemies=self:Rows('enemy',1300);local q,w=self:Ready(_Q),self:Ready(_W)
 for i=1,math.min(#enemies,5)do local u=enemies[i]
  if w and self:WLethal(u)and self:CastW(u,u,{priority='interactive'},function()return self:WLethal(u)end,false)then return true end
  if q and self:QLethal(u)and self:CastQ(u,{priority='interactive'},function()return self:QLethal(u)end)then return true end
 end
 if GetMode()~='Combo'or not Menu.Combo.RKill:Value()or not self:Ready(_R)then return false end
 local context=Core:ModeContext('Combo')
 for i=1,math.min(#enemies,5)do local u=enemies[i]
  if not(w and self:WLethal(u))and not(q and self:QLethal(u))and self:RLethal(u)
   and self:CastR(u,context,1,function()return Menu.Combo.RKill:Value()and self:RLethal(u)end,3)then return true end
 end
 return false
end
function NamiChampion:ControlQ()
 if not Menu.Misc.ControlQ:Value()or not self:Ready(_Q)or not manaAbove(Menu.Misc.ControlMana:Value())then return false end
 for _,target in ipairs(self:Rows('enemy',850))do
  local function permission(position)return Menu.Misc.ControlQ:Value()and manaAbove(Menu.Misc.ControlMana:Value())
   and Core:ControlledHit(target,self.QSpell,position)end
  if permission()and self:CastQ(target,{priority='interactive',condition=function()return Menu.Misc.ControlQ:Value()end},permission)then return true end
 end
 return false
end
function NamiChampion:RPredictions(minHit)
 local rows={};local pred=Core:Prediction(self.RSpell)
 for _,u in ipairs(self:Rows('enemy',2200))do pred:GetPrediction(u,myHero)
  local p=point(pred.UnitPosition)
  if p and pred:CanHit(minHit or 2)then rows[#rows+1]={unit=u,pos=p}end
 end
 return rows
end
function NamiChampion:RCount(pos,anchor,rows)
 if not point(pos)then return 0,false end
 local dx,dz=pos.x-myHero.pos.x,pos.z-myHero.pos.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<1 or length>2200 then return 0,false end
 local count,primary,units=0,false,{}
 for _,row in ipairs(rows or self:RPredictions())do local u,p=row.unit,row.pos
  if p then local ux,uz=p.x-myHero.pos.x,p.z-myHero.pos.z;local along=(ux*dx+uz*dz)/length
   local cross=math.abs(ux*dz-uz*dx)/length
   if along>=0 and along<=2200 and cross<=170+(u.boundingRadius or 0)then count=count+1;units[#units+1]=u
    if anchor and identity(u)==identity(anchor)and u.handle==anchor.handle then primary=true end
   end
  end
 end
 return count,primary,units
end
function NamiChampion:RPlan(anchor,need,rows,minHit)
 if not self:Ready(_R)or not self:Current(anchor)then return nil end
 rows=rows or self:RPredictions(minHit);local best,count
 local function consider(pos)
  local n,primary=self:RCount(pos,anchor,rows)
  if primary and n>=need and(not best or n>count)then best=point(pos);count=n end
 end
 for _,row in ipairs(rows)do if identity(row.unit)==identity(anchor)and row.unit.handle==anchor.handle then consider(row.pos)end end
 for i=1,#rows do for j=i+1,#rows do local a,b=rows[i].pos,rows[j].pos;consider(Vector((a.x+b.x)/2,myHero.pos.y,(a.z+b.z)/2))end end
 if not best or not self:RRay(best,anchor)then return nil end
 return {position={x=best.x,y=best.y,z=best.z},data={count=count,anchor=identity(anchor),handle=anchor.handle}}
end
function NamiChampion:RRay(pos,anchor)
 if not point(pos)then return false end
 local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,pos,850,.5,170,self.RSpell.CollisionTypes,identity(anchor))
 return not wall and type(count)=='number'and count==0
end
function NamiChampion:CastR(u,context,minCount,permission,minHit)
 if not self:Ready(_R)or not self:Current(u)or GetDistance(u.pos,myHero.pos)>2200 or not permission or not permission()then return false end
 local plan=self:RPlan(u,minCount,nil,minHit);if not plan then return false end
 local pos=point(plan.position)
 local handle=u.handle
 return Core:Cast(HK_R,pos,{context=context,range=2200,intentTarget=u,prevalidateWorldCast=true,deferAttackWindup=true,
  validate=function(_,resolved)
   if not self:Ready(_R)or u.handle~=handle or not self:Current(u)or not permission()then return false end
   local aim=resolved and resolved.position or pos
   if not self:RRay(aim,u)then return false end
   local n,hit=self:RCount(aim,u);return hit and n>=minCount
  end,resolve=function()
   if u.handle~=handle or not permission()then return nil,'r_consent_or_identity_changed'end
   return self:RPlan(u,minCount,nil,minHit)
  end})
end
-- Distance from `p` to the wave's path from Nami toward `aim` (its full reach).
local function lineDistance(p,aim)
 local o=myHero.pos;local dx,dz=aim.x-o.x,aim.z-o.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<1 then return math.huge end
 local ux,uz=p.x-o.x,p.z-o.z;local along=(ux*dx+uz*dz)/length
 if along<0 then return math.sqrt(ux*ux+uz*uz)end
 return math.abs(ux*dz-uz*dx)/length
end
-- R without a mode key (Sikaka Auto Nami). Peel: an enemy champion diving Nami or an allowed ally
-- (Core:PeelTarget: a dash onto it, an attack on it, a melee champion in reach), at least two enemies on the
-- wave and the wave passing within 300 of the ally. Count: the menu's number of enemies on the wave while an
-- allied champion stands within 800 of the aim to follow up. Both through the shared ultimate rule.
function NamiChampion:RPeel()
 if not Menu.Misc.RPeel:Value()or not self:Ready(_R)then return false end
 local rows
 for _,ally in ipairs(self:Rows('ally',2200))do
  if ally==myHero or self:AllyAllowed(ally,'Heal')then
   local diver=Core:PeelTarget(ally,1.5)
   if diver and self:Current(diver)and GetDistance(diver.pos,ally.pos)<=500 and GetDistance(diver.pos,myHero.pos)<=2200 then
    rows=rows or self:RPredictions()
    local plan=self:RPlan(diver,2,rows)
    if plan and lineDistance(ally.pos,plan.position)<=300 then
     local _,_,units=self:RCount(plan.position,diver,rows)
     if Core:UltimateWorth({hits=units,minimum=2,impact=.5})then
      local handle=ally.handle
      if self:CastR(diver,{priority='interactive'},2,function()return Menu.Misc.RPeel:Value()and ally.handle==handle and Core:PeelTarget(ally,1.5)==diver end)then return true end
     end
    end
   end
  end
 end
 return false
end
function NamiChampion:RAuto()
 local need=Menu.Misc.RCount:Value()
 if need<=0 or not self:Ready(_R)then return false end
 local mode=GetMode();if mode=='Combo'then return false end
 local rows=self:RPredictions();if #rows<need then return false end
 local function followUp(aim)
  for _,ally in ipairs(self:Rows('ally',3000))do if ally~=myHero and IsValid(ally)and GetDistance(ally.pos,aim)<=800 then return true end end
  return false
 end
 for i=1,math.min(#rows,5)do local anchor=rows[i].unit
  local plan=self:RPlan(anchor,need,rows)
  if plan and followUp(plan.position)then
   local _,_,units=self:RCount(plan.position,anchor,rows)
   if Core:UltimateWorth({hits=units,minimum=need,impact=.5})and self:CastR(anchor,{priority='interactive'},need,function()
     return Menu.Misc.RCount:Value()==need and followUp(anchor.pos)end)then return true end
  end
 end
 return false
end
function NamiChampion:Interrupt()
 -- No mode key needed: Combo and Harass use their own mana limit, otherwise the automatic-Q limit.
 local mode=GetMode();local fighting=mode=='Combo'or mode=='Harass'
 local function mana()return manaAbove(fighting and Menu[mode].Mana:Value()or Menu.Misc.ControlMana:Value())end
 if not Menu.Misc.Interrupt:Value()or not self:Ready(_Q)or not mana()then return false end
 for _,u in ipairs(self:Rows('enemy',850))do local a=u.activeSpell
  -- The shared rule: a real channel the game reports as interruptible that outlasts the bubble's .95 s.
  if a and Core:CanInterrupt(u,.95,0)then
   local start,name=a.startTime,a.name
   if self:CastQ(u,fighting and Core:ModeContext(mode)or {priority='interactive'},function()local cast=u.activeSpell;return Menu.Misc.Interrupt:Value()and mana()
    and cast and cast.startTime==start and cast.name==name and Core:CanInterrupt(u,.95,0)end)then return true end
  end
 end
end
-- Normal E also empowers Nami's own next abilities (wiki 2026-10-10: the next three attacks or abilities).
-- Before her own Q or R, and only when no ally is attacking into an enemy, E goes on Nami first; it has no
-- cast time, and the Q or R follows on the next decision.
function NamiChampion:SelfEFirst(node,context)
 if not self.profile.spellE or not node.E:Value()or not self:Ready(_E)or not self:AllyAllowed(myHero,'E')or self:EActive(myHero)then return false end
 local handle=myHero.handle
 return Core:Cast(HK_E,myHero,{context=context,range=800,validate=function()
   return self:Ready(_E)and node.E:Value()and manaAbove(node.Mana:Value())and myHero.handle==handle and not self:EActive(myHero)
    and(self:Ready(_Q)or self:Ready(_R))end,
  observe=function(q)return self:EBuff(myHero)~=nil and q.requestGameTime<=Game.Timer()end})
end
function NamiChampion:Combat(mode)
 local node=Menu[mode];if not manaAbove(node.Mana:Value())then return false end
 local context=Core:ModeContext(mode);local u=GetTarget(2200);if not self:Current(u)then return false end
 local function rPermission()return node.R:Value()and manaAbove(node.Mana:Value())end
 if mode=='Combo'and node.R:Value()and self:Ready(_R)then
  if self:RPlan(u,node.Count:Value())and self:SelfEFirst(node,context)then return true end
  if self:CastR(u,context,node.Count:Value(),rPermission)then return true end
 end
 if node.E:Value()and self:EAssist(context,function()return node.E:Value()and manaAbove(node.Mana:Value())end)then return true end
 if node.W:Value()and self:Ready(_W)then local row=self:ChooseW(u,false)
  if row and self:CastW(row.first,u,context,function()return node.W:Value()and manaAbove(node.Mana:Value())end,false)then return true end
 end
 if not node.Q:Value()or not self:Ready(_Q)then return false end
 -- The selected target's bubble with the most enemies in it; any enemy when the selected one is out of Q reach.
 local anchor=GetDistance(u.pos,myHero.pos)<=850+self.QSpell.Radius and u or nil
 local plan=self:QPlan(anchor);if not plan then return false end
 if self:SelfEFirst(node,context)then return true end
 return self:CastQPlan(anchor,1,context,function()return node.Q:Value()and manaAbove(node.Mana:Value())end)
end
function NamiChampion:Combo()return self:Combat('Combo')end
function NamiChampion:Harass()return self:Combat('Harass')end
function NamiChampion:FarmRows(kind)return Core:Rows(kind,1000)end
function NamiChampion:QDensity(pos,kind)
 local count=0;for _,u in ipairs(self:FarmRows(kind))do if GetDistance(u.pos,pos)<=155+(u.boundingRadius or 0)then count=count+1 end end;return count
end
function NamiChampion:FarmUseful(u)
 if not self:Current(u)or u.team==300 or GetDistance(u.pos,myHero.pos)>850 then return false end
 -- A bubble that also hits a second minion softens the wave: lone minions only.
 return Core:Rescue(u,.95+Core:AttackWindupRemaining(),self:GetQDmg(u),readyAttack)and self:QDensity(u.pos,'lane')==1
end
function NamiChampion:LastHit()
 local node=Menu.LastHit;if not node.Q:Value()or not self:Ready(_Q)or not manaAbove(node.Mana:Value())then return false end
 for _,u in ipairs(self:FarmRows('lane'))do if self:FarmUseful(u)and self:CastQ(u,Core:RescueContext(),function()
  return node.Q:Value()and manaAbove(node.Mana:Value())and self:FarmUseful(u)end)then return true end end
 return false
end
function NamiChampion:Clear(kind)
 local node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear']
 if not Menu.Clear.SpellFarm:Value()or not Core:FarmModeEnabled(kind)or not manaAbove(node.Mana:Value())then return false end
 local permission=function()return Menu.Clear.SpellFarm:Value()and Core:FarmModeEnabled(kind)and manaAbove(node.Mana:Value())end
 local context=Core:FarmContext(kind,permission)
 if node.E:Value()and self:CastE(myHero,context,function()return permission()and node.E:Value()end,kind)then return true end
 if not node.Q:Value()or not self:Ready(_Q)then return false end
 local need=kind=='jungle'and 1 or Menu.Clear.LaneClear.Count:Value()
 for _,u in ipairs(self:FarmRows(kind))do
  if GetDistance(u.pos,myHero.pos)<=850 and self:QDensity(u.pos,kind)>=need then
   if self:CastQ(u,context,function()return permission()and node.Q:Value()and self:QDensity(u.pos,kind)>=need end)then return true end
  end
 end;return false
end
function NamiChampion:LaneClear()return self:Clear('lane')end
function NamiChampion:JungleClear()return self:Clear('jungle')end
function NamiChampion:Flee()
 local context=Core:ModeContext('Flee')
 if not Menu.Misc.FleeQ:Value()then return false end
 local u=GetTarget(850)
 return self:CastQ(u,context,function()return Menu.Misc.FleeQ:Value()and GetDistance(u.pos,myHero.pos)<650 end)
end
function NamiChampion:Assist()
 if Menu.Misc.RAssist:Value()then local u=GetTarget(2200)
  if self:CastR(u,Core:HeldContext(function()return Menu.Misc.RAssist:Value()end),1,function()return Menu.Misc.RAssist:Value()end)then return true end
 end
 if Menu.Misc.QAssist:Value()then return self:CastQ(GetTarget(850),Core:HeldContext(function()return Menu.Misc.QAssist:Value()end),function()return Menu.Misc.QAssist:Value()end)end
 return false
end
function NamiChampion:PreparePreview()
 -- The R wave the bind would send now (Draw only reads this). No W/E status text. Kept for a second so a
 -- late preparation never blinks it; Draw shows it only while the bind is held and R is ready.
 local target=GetTarget(2200)
 local plan=Menu.Misc.RAssist:Value()and self:Current(target)and self:RPlan(target,1)or nil
 self.preview={expires=Game.Timer()+1,profile=self.profile.id,rAim=plan and point(plan.position)or nil,rCount=plan and plan.data.count or nil}
end
-- Which range circles Draw shows (rerank drawings): only abilities that are ready, read in Tick; each its own colour.
local RANGE_COLOURS={[0]={80,160,255},{90,230,130},{255,220,80},{235,90,200}}
function NamiChampion:PrepareRanges()
 if not Menu.Draw.Ranges:Value()then self.ranges=nil;return end
 self.ranges={[0]=self:Ready(_Q)and 850 or nil,[1]=self:Ready(_W)and 725 or nil,[2]=self:Ready(_E)and 800 or nil,[3]=self:Ready(_R)and self.RRange or nil,expires=Game.Timer()+1}
end
function NamiChampion:Tick()
 if not Core:Available()or ShouldWait()then self.eObservation=nil;return end
 self:PrepareRanges()
 if Core.logger then self:DevTraces()end
 if Game.Timer()>=(self.nextDiscovery or 0)then self:DiscoverAllies()end
 if self.previewFallback and Menu.Draw.Preview:Value()and(not self.nextPreview or Game.Timer()>=self.nextPreview)then self:PreparePreview();self.nextPreview=Game.Timer()+.15 end
 if IsCasting()then return end
  if self:HealAssist()or self:KillSecure()or self:Assist()or self:Interrupt()or self:ControlQ()or self:DashQ()or self:RPeel()then return end
 -- Count rules scan every enemy: a few times per second is enough.
 if Game.Timer()>=(self.nextCount or 0)then self.nextCount=Game.Timer()+.1;if self:MultiQ()or self:RAuto()then return end end
 if Menu.Support.E:Value()and manaAbove(Menu.Support.Mana:Value())and self:EAssist({priority='interactive'},function()return Menu.Support.E:Value()and manaAbove(Menu.Support.Mana:Value())end)then return end
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')and self:LaneClear()then return end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function NamiChampion:Draw()
 if myHero.dead then return end
 local r=self.ranges
 if Menu.Draw.Ranges:Value()and r and r.expires>Game.Timer()then
  for slot=0,3 do if r[slot]then local c=RANGE_COLOURS[slot];Draw.Circle(myHero.pos,r[slot],1,Draw.Color(255,c[1],c[2],c[3]))end end
 end
 local p=self.preview;if Menu.Draw.Preview:Value()and p and p.expires>Game.Timer()then
  if p.rAim and Menu.Misc.RAssist:Value()and IsReady(_R)then
   local from=myHero.pos2D;local to=Vector(p.rAim.x,p.rAim.y or myHero.pos.y,p.rAim.z):To2D()
   Draw.Line(from.x,from.y,to.x,to.y,3,Draw.Color(255,80,160,255))
   Draw.Text('R: '..tostring(p.rCount),16,to.x,to.y,Draw.Color(255,80,160,255))
  end
 end
end
-- Health-bar damage (S9): ready Q, W and R plus one attack.
function NamiChampion:ComboDamage(u)
 local aa=_G.SDK.Damage:GetAutoAttackDamage(myHero,u);if not finite(aa)or aa<0 then aa=0 end
 local damage=aa
 if self:Ready(_Q)then damage=damage+self:GetQDmg(u)end
 if self:Ready(_W)then damage=damage+self:GetWDmg(u)end
 if self:Ready(_R)then damage=damage+self:GetRDmg(u)end
 return damage,true
end
-- Development only. Nami-8: Q landing time and bubble radius (centre-to-victim distance when an enemy's new
-- crowd-control buff appears after an observed Q). Nami-9: Nami's own movement speed right before and after
-- her own E lands on her (whether Surging Tides speeds her up).
function NamiChampion:DevTraces()
 local now=Game.Timer();local cast=myHero.activeSpell
 if cast and cast.valid and cast.name==self.profile.q and finite(cast.startTime)and cast.startTime~=self.qTraceStart then
  self.qTraceStart=cast.startTime;local at=point(cast.placementPos)
  if at then self.qWatch={start=cast.startTime,at=at,seen={},untilAt=cast.startTime+1.6}end
 end
 local w=self.qWatch
 if w then
  if now>w.untilAt then self.qWatch=nil
  else
   local enemies=self:Rows('enemy',1400)
   for i=1,math.min(#enemies,5)do local u=enemies[i];local id=identity(u)
    if id and not w.seen[id]and GetDistance(u.pos,w.at)<=400 and finite(u.buffCount)and u.buffCount>=0 and u.buffCount<=64 then
     for j=0,u.buffCount do local b=u:GetBuff(j)
      if b and b.type==5 and finite(b.startTime)and b.startTime>=w.start then
       w.seen[id]=true
       Core:Trace('nami_q_hit',{profile=self.profile.id,afterCast=now-w.start,buffStart=b.startTime-w.start,buff=b.name,
        distance=GetDistance(u.pos,w.at),bounding=u.boundingRadius,assumedDelay=self.QSpell.Delay,assumedRadius=self.QSpell.Radius})
       break
      end
     end
    end
   end
  end
 end
 local owned=self:EBuff(myHero)~=nil
 if owned and not self.selfE then
  self.selfE={msBefore=self.lastMs,msAt=myHero.ms,sampleAt=now+.25}
 elseif not owned then self.selfE=nil end
 local e=self.selfE
 if e and e.sampleAt and now>=e.sampleAt then
  e.sampleAt=nil;Core:Trace('nami_self_e_speed',{profile=self.profile.id,msBefore=e.msBefore,msAtBuff=e.msAt,msAfter=myHero.ms})
 end
 self.lastMs=myHero.ms
end
function NamiChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Nami: combat','Nami: support'},function(page)
  return {title=page==1 and 'Nami combat'or 'Nami support',cards=page==1 and {
   {'COMBAT','Combo/Harass use selected enemies and provider prediction. R requires its Combo option and hit count, or its bind. The Q bind casts a selected Q.'},
   {'BOUNCES','W evaluates all three alternating recipients, excludes repeated identities and ranks healing plus damage. Only the first recipient is selected; future bounces are projections.'},
   {'FARM','Abilities farm only while the spell-farm toggle is on. LastHit Q rescues a lone minion an attack cannot take.'}}or {
   {'HEAL','W always heals allowed allies below the health limit, highest priority first, without a mode key. An ally an enemy champion is about to hit is healed 25 points earlier; minion and turret damage does not count.'},
   {'E','E is cast on an ally who is attacking an enemy (Normal: also casting a targeted spell). Classic only empowers attacks.'},
    {'CONTROL','Q interrupts an interruptible channel that lasts until the bubble lands, with or without a mode key. Q is cast on immobilised enemies, on a diver landing next to you or an ally, and where it hits several enemies. W and Q finish a killable enemy; R peels a dive and catches a group. Flee Q peels nearby pursuers.'}},note='W bounces, heal modifiers and actual host timing require separate live acceptance.'}
 end)
end
Core:StandardPolicy(NamiChampion,{damageTypes={Q='magical',W='magical',E='magical',R='magical'}})
NamiChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Nami"]="Nami"}
local normalSupported={["Nami"]=true}

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
