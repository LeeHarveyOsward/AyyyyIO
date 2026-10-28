return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Nidalee"]=function()return _G.OrbamaFamily:Require("f2e40e448cc6540fa01a30aaa1af2e2fbb32a4b2c1c0e355c2bcfd01c57c1836")()end
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
if champion=="Nidalee" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Nidalee',profiles={normal=true,classic=true},
 Create=function(context)
-- Independently implemented; see CombatProfiles/nidalee-provenance.json.
-- Hidden-form cooldowns are observations, never fixed post-cast timers.
local profiles=ChampionProfiles('Nidalee')
local finite,id,expiry=Core.finite,Core.id,Core.buffExpiry
local function validPoint(p)return p and finite(p.x)and finite(p.z)and(p.y==nil or finite(p.y))end
local function point(p)return validPoint(p)and Vector(p.x,p.y or 0,p.z)end
local function trapControlled(u,arm)
 -- Stationary control only: fear/taunt and slows can still move the recipient. The control must last
 -- until the trap is armed (cast .25 s + arm), otherwise the enemy walks off before it can trigger.
 local buffs=GetBuffs(u);local now=Game.Timer()
 for i=1,math.min(#buffs,64)do local b=buffs[i];local finish=expiry(b)
  if(b.type==5 or b.type==12 or b.type==25 or b.type==35)and finite(b.count)and b.count>0
   and finite(finish)and finish>now+.25+(arm or 0)then return true end
 end
 return false
end
-- Pinned by this champion's regressions: only a ready, in-range lethal attack keeps the spell (Core:Rescue).
local readyAttack={attack='ready'}
local function cleanup(self)self.sequence=nil;self.leap=nil;self.empower=nil;self.attack=nil;self.preview=nil;self.cooldowns={human={},cougar={}};self.traps={}end
-- kind: 'combat' (W2 is the Engage switch), 'lane' (traps and pounce never farm a wave) or 'jungle'.
local function formMenu(node,defaults,kind)
 node:MenuElement({id='Q',name='Use Q (Javelin Toss)',value=defaults.Q})
 -- Existing slot choices seed the cougar setting once at menu load.
 node:MenuElement({id='Q2',name='Use cougar Q (Takedown)',value=node.Q:Value()})
 if kind~='lane'then node:MenuElement({id='W',name='Use W (Bushwhack trap)',value=defaults.W})end
 if kind=='jungle'then node:MenuElement({id='W2',name='Use cougar W (Pounce)',value=node.W:Value()})end
 node:MenuElement({id='E2',name='Use cougar E (Swipe)',value=defaults.E})
 node:MenuElement({id='R',name='Switch form automatically',value=defaults.R})
end
local NidaleeChampion=class("NidaleeChampion")
function NidaleeChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.cooldowns={human={},cougar={}};self.traps={};self.allies={}
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=self.profile.spearRadius,Range=1500,Speed=1300,Collision=true,
  CollisionTypes={OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL},
   DirectionalCast=true,AimErrorWorld=5}
 self:LoadMenu();self:SampleForm();self:DiscoverAllies()
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function()self:OnPostAttack()end)
 Core:RegisterCleanup('Nidalee',function()cleanup(self)end)
 local ok,why=Core:RegisterPreparation('Nidalee.preview',{intervalMs=150,maxDelayMs=500,units=1,maxUnits=1},
  function()self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.previewFallback=not ok and why=='unsupported'
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
end
function NidaleeChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Nidalee'})
 for _,mode in ipairs({'Combo','Harass'})do Menu:MenuElement({type=MENU,id=mode,name=mode})
  formMenu(Menu[mode],{Q=true,W=true,E=mode=='Combo',R=mode=='Combo'},'combat')
  Menu[mode]:MenuElement({id='Engage',name='Use cougar W (Pounce onto enemies)',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 15,min=0,max=100,step=5})
 end
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  formMenu(Menu.Clear[mode],{Q=true,W=true,E=true,R=true},mode=='LaneClear'and 'lane'or 'jungle')
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions Swipe must hit',value=2,min=1,max=10,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q (Javelin Toss)',value=true})
 Menu.LastHit:MenuElement({id='Q2',name='Use cougar Q (Takedown)',value=Menu.LastHit.Q:Value()})
 Menu.LastHit:MenuElement({id='E',name='Use cougar E (Swipe) on a lone minion',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Heal',name='Healing'})
 Menu.Heal:MenuElement({id='HP',name='Heal below health %',value=70,min=5,max=100,step=5})
 Menu.Heal:MenuElement({id='Mana',name='Only above mana %',value=35,min=0,max=100,step=5})
 Menu.Heal:MenuElement({id='Transform',name='Leave cougar form to heal',value=false})
 Menu.Heal:MenuElement({id='AttackSpeed',name='Use E on an attacking ally in Combo',value=true})
 Menu.Heal:MenuElement({type=MENU,id='Recipients',name='Heal priority per ally (0 = never)'})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='Spear',name='Cast Q at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='Flee',name='Pounce toward the cursor when fleeing',value=true})
 Menu.Misc:MenuElement({id='Enemies',name='Never pounce into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='HP',name='Never pounce in below health %',value=30,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ability ranges',value=false})
 Menu.Draw:MenuElement({id='Preview',name='Cooldowns of the other form',value=true})
end
function NidaleeChampion:Form()
 return Core:DecisionValue('Nidalee.form',function()
  local q,w,e=myHero:GetSpellData(_Q),myHero:GetSpellData(_W),myHero:GetSpellData(_E)
  if not q or not w or not e then return nil end;q,w,e=q.name,w.name,e.name
 if q==self.profile.q and w==self.profile.w and e==self.profile.e then return 'human'end
 if q==self.profile.cougar[1]and w==self.profile.cougar[2]and e==self.profile.cougar[3]then return 'cougar'end
 end)
end
function NidaleeChampion:SampleForm()
 local form=self:Form();if not form then return nil end
 for slot=0,2 do local d=myHero:GetSpellData(slot)
   if finite(d.currentCd)and d.currentCd>=0 and finite(d.level)then
    local row=self.cooldowns[form][slot]or{};local now=Game.Timer()
    row.ends=now+d.currentCd;row.at=now;row.rank=d.level;row.name=d.name;self.cooldowns[form][slot]=row
   end
 end;self.observedForm=form;return form
end
function NidaleeChampion:HiddenReady(form,slot)
 local r=self.cooldowns[form]and self.cooldowns[form][slot]
 return r and r.rank>0 and r.ends<=Game.Timer()or false
end
function NidaleeChampion:SpellMenuKey(slot,spellName)
  local letter=slot==_Q and 'Q'or slot==_W and 'W'or slot==_E and 'E'or slot==_R and 'R'
  if letter and slot~=_R then
   local name=spellName or myHero:GetSpellData(slot).name
   if name==self.profile.cougar[slot+1]then return letter..'2'end
  end
  return letter
end
function NidaleeChampion:Ready(slot)
 local form=self:Form();local d=myHero:GetSpellData(slot);local rank=slot==_R and self.profile.ranks or 5
 return form and d and(slot~=_R or d.name==self.profile.r)and finite(d.level)and d.level%1==0 and d.level>=1 and d.level<=rank
  and finite(d.currentCd)and d.currentCd==0 and Game.CanUseSpell(slot)==0 and finite(d.mana)and d.mana>=0 and d.mana<=myHero.mana or false
end
-- kind: 'ally' (the player first) | 'enemy' | 'jungle' | 'lane'.
function NidaleeChampion:Rows(kind,range)return Core:Rows((kind=='ally'or kind=='enemy')and 'hero'or kind,range,kind=='ally'and 'self')end
function NidaleeChampion:Current(u)return u~=nil and validPoint(u.pos)and Core:CurrentUnit(u,u.team==myHero.team)end
-- The player's own Hunt mark, single and with enough time left to finish a pounce.
function NidaleeChampion:Hunt(u)
 if not self.profile.hunt or not self:Current(u)then return nil end
 local b=Core:OwnBuff(u,self.profile.hunt,true,true);return b and expiry(b)>Game.Timer()+.3 and b or nil
end
function NidaleeChampion:DiscoverAllies()
 for _,u in ipairs(self:Rows('ally',3000))do if not self.allies[id(u)]then local key=StableUnitMenuKey(self,'P',u)
  -- One priority per ally: higher is healed first, 0 never.
  Menu.Heal.Recipients:MenuElement({id=key,name=u.charName,value=3,min=0,max=5,step=1});local node=Menu.Heal.Recipients[key]
  self.allies[id(u)]={node=node,handle=u.handle}
 else self.allies[id(u)].handle=u.handle end end;self.nextAllies=Game.Timer()+1
end
function NidaleeChampion:AllyAllowed(u)local row=self.allies[id(u)];return row and row.handle==u.handle and row.node:Value()>0 end
function NidaleeChampion:HealAmount(u)
 local base=self.profile.heal[myHero:GetSpellData(_E).level]
 return self:Form()=='human'and base and finite(myHero.ap)and math.min(math.max(0,u.maxHealth-u.health),base+self.profile.healAP*myHero.ap)or 0
end
function NidaleeChampion:Damage(u,slot)
 local d=myHero:GetSpellData(slot);local base,raw;local form=self:Form();local rank=form=='cougar'and myHero:GetSpellData(_R).level or d and d.level
 if not d or not finite(myHero.ap)or not finite(myHero.totalDamage)then return 0 end
 if form=='human'and slot==_Q then base=self.profile.spear[rank];raw=base and base+self.profile.spearAP*myHero.ap
 elseif form=='cougar'and slot==_Q then base=self.profile.takedown[rank];raw=base and base+self.profile.takedownAD*myHero.totalDamage+self.profile.takedownAP*myHero.ap
 elseif form=='cougar'and slot==_W then base=self.profile.pounce[rank];raw=base and base+self.profile.pounceAP*myHero.ap
 elseif form=='cougar'and slot==_E then
  -- Unknown bonus AD affects only this damage estimate. Classic has no such term.
  if self.profile.swipeBonusAD and not finite(myHero.bonusDamage)then return 0 end
  base=self.profile.swipe[rank];raw=base and base+self.profile.swipeAP*myHero.ap
   +(self.profile.swipeBonusAD and self.profile.swipeBonusAD*myHero.bonusDamage or 0)
 end
 -- Distance and missing-health amplification are excluded from lethal decisions
 -- until their profile-matched server interpolation has been measured.
 return raw and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,math.max(0,raw))or 0
end
function NidaleeChampion:SpearDamage(u)
 local rank=self:Form()=='human'and myHero:GetSpellData(_Q).level or self.cooldowns.human[0]and self.cooldowns.human[0].rank
 local base=rank and self.profile.spear[rank]
 if not base or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.spearAP*myHero.ap)
end
function NidaleeChampion:SpearCurrent(u)
 if self:Current(u)then return true end
 if not u or u.visible~=false or u.valid==false or u.dead or u.team==myHero.team or u.type~=Obj_AI_Hero then return false end
 -- A recall without an observed starting position does not locate the target.
 local knowledge=Core:GetKnowledge();if not knowledge then return false end
 local recall=knowledge:Recall(u)
 return recall and recall.positionKnown==true or knowledge:LastSeen(u,.75)~=nil
end
function NidaleeChampion:SpearPlan(u)
 if self:Form()~='human'or not self:Ready(_Q)or not self:SpearCurrent(u)or u.team==myHero.team then return nil end
 local pred=Core:Prediction(self.QSpell);pred:GetPrediction(u,myHero)
  if not pred:CanHit(2)or not validPoint(pred.CastPosition)or GetDistance(pred.CastPosition,myHero.pos)>1500 then return nil end
 -- Preserve the shared prediction binding and its launch timing. Dispatch
 -- resolves and checks this same full ray through the common prediction service.
 return {position=pred.CastPosition}
end
function NidaleeChampion:CastSpear(u,context,permission)
 if permission and not permission()then return false end;local plan=self:SpearPlan(u);if not plan then return false end;local handle=u.handle
 return Core:Cast(HK_Q,plan.position,{intentTarget=u,context=context,range=1500,prevalidateWorldCast=true,deferAttackWindup=true,
  validate=function(q,r)
    if not(self:Ready(_Q)and self:Form()=='human'and u.handle==handle and self:SpearCurrent(u)and(not permission or permission())and r and validPoint(r.position))then return false end
   return true -- The bound common prediction performs the fresh ray check.
  end})
end
function NidaleeChampion:NativeCast(q,target)
 local a=Core:NativeCast(q)
 return a and(not target or a.target==id(target)or a.target==target.handle)
end
function NidaleeChampion:Transform(form,context,permission,target)
 local previous=self:Form();if not previous or previous==form or not self:Ready(_R)or permission and not permission()then return false end
 -- Classic R resets the attack timer (League_Classic patch 4; Riot 26.19 notes): a switch that is wanted
 -- anyway waits, inside its deadline, for the attack in reach to go first, so the reset is not wasted on a
 -- ready attack. Never a switch made only for the reset. Normal: no reset documented.
 local ready=self.profile.id=='classic'and target and target.type==Obj_AI_Hero and function()return(Core:WeaveWindow(0,target))end or nil
 return Core:Cast(HK_R,nil,{context=context,deferAttackWindup=true,ready=ready,
  -- The form change is the outcome. It is attributed to this R by its native
  -- cast or, when the host shows none for the instant switch, by R's cooldown.
  observe=function(q)if self:NativeCast(q)then q.nativeFormCast=true end;return(q.nativeFormCast or Core:CooldownStarted(q))and self:Form()==form end,
  validate=function()return self:Ready(_R)and self:Form()==previous and(not permission or permission())end})
end
function NidaleeChampion:StartTransform(form,context,permission,target,kind)
 if self.sequence then return false end
 if not self:Transform(form,context,permission,target)then return false end
 self.sequence={form=form,context=context,permission=permission,target=target,handle=target and target.handle,kind=kind,q=Core.lastIntent,expires=Game.Timer()+1.2};return true
end
function NidaleeChampion:Heal(u,context,permission)
 if self:Form()~='human'or not self:Ready(_E)or not self:Current(u)or u.team~=myHero.team or not self:AllyAllowed(u)
  or GetDistance(u.pos,myHero.pos)>self.profile.healRange or permission and not permission()then return false end
 local handle=u.handle
 return Core:Cast(HK_E,u,{context=context,range=self.profile.healRange,observe=function(q)return self:NativeCast(q,u)end,
  validate=function()return self:Ready(_E)and self:Form()=='human'and u.handle==handle and self:Current(u)and self:AllyAllowed(u)
   and(not permission or permission())end})
end
-- Below the health limit always. While an enemy champion's attack, targeted
-- cast or tracked skillshot is about to hit the ally (Core:AllyThreat; minion
-- and turret damage are not evidence) the limit is 20 points higher, capped at
-- 95 %: the heal lands in the trade instead of after it.
function NidaleeChampion:HealEligible(u)
 if not(self:Current(u)and u.team==myHero.team and self:AllyAllowed(u)and finite(u.maxHealth)and u.maxHealth>0 and finite(u.health)
  and u.maxHealth-u.health>=25 and Core.manaAbove(Menu.Heal.Mana:Value()))then return false end
 local percent,limit=u.health/u.maxHealth*100,Menu.Heal.HP:Value()
 if percent<limit then return true end
 return percent<math.min(95,limit+20)and Core:AllyThreat(u,1.5,{turrets=false})~=nil
end
-- A champion an ability kills is finished without a mode key: the spear in human
-- form; Swipe, Takedown and Pounce (dive limits apply) in cougar form, then a
-- switch back for a spear that kills. Minimum damage only: the distance and
-- missing-health bonuses are not counted, so the estimate errs toward not casting.
function NidaleeChampion:Finisher()
 local form=self:Form();local context={priority='interactive'}
 local enemies=self:Rows('enemy',1500)
 local function spearKills(u)return self:Current(u)and GetDistance(u.pos,myHero.pos)<=1500
  and Core:Lethal(u,.25+GetDistance(u.pos,myHero.pos)/1300,function()return self:SpearDamage(u)end,{kind='magical'})end
 if form=='human'then
  if not self:Ready(_Q)then return false end
  for i=1,math.min(#enemies,5)do local u=enemies[i]
   if spearKills(u)and self:CastSpear(u,context,function()return spearKills(u)end)then return true end
  end
  return false
 end
 if form~='cougar'then return false end
 -- Cougar: Swipe (.25 s), Takedown (on the next attack) and Pounce (dive limits apply) at their own minimum
 -- damage, then a switch back for a spear that kills.
 for i=1,math.min(#enemies,5)do local u=enemies[i]
  if self:Current(u)then local d=GetDistance(u.pos,myHero.pos)
   local function swipeKills()return self:Current(u)and GetDistance(u.pos,myHero.pos)<=300
    and Core:Lethal(u,.25,function()return self:Damage(u,_E)end,{kind='magical'})end
   if d<=300 and self:Ready(_E)and swipeKills()and self:Swipe(u,context,swipeKills)then return true end
   local function takedownKills()local windup=myHero.attackData and myHero.attackData.windUpTime
    return self:Current(u)and _G.SDK.Data:IsInAutoAttackRange(myHero,u)and finite(windup)
     and Core:Lethal(u,windup,function()return self:Damage(u,_Q)end,{kind='magical'})end
   if self:Ready(_Q)and takedownKills()and self:Takedown(u,context,takedownKills,true)then return true end
   local function pounceKills()return self:Current(u)and self:PouncePlan(u,u.pos,true)~=nil
    and Core:Lethal(u,.5,function()return self:Damage(u,_W)end,{kind='magical'})end
   if self:Ready(_W)and pounceKills()and self:Pounce(u,u.pos,context,pounceKills,true)then return true end
   if self:Ready(_R)and self:HiddenReady('human',_Q)and spearKills(u)
    and self:StartTransform('human',context,function()return spearKills(u)end,u,'spear')then return true end
  end
 end
 return false
end
function NidaleeChampion:AutoHeal()
 if not Core.manaAbove(Menu.Heal.Mana:Value())then return false end
 local form=self:Form();if form=='human'and not self:Ready(_E)or form=='cougar'and(not Menu.Heal.Transform:Value()or not self:HiddenReady('human',_E))then return false end
 local best,score
 for _,u in ipairs(self:Rows('ally',self.profile.healRange))do if self:HealEligible(u)then
  local value=self.allies[id(u)].node:Value()*1000+u.maxHealth-u.health;if not best or value>score then best,score=u,value end
 end end
 if not best then return false end;local permission=function()return self:HealEligible(best)end
 if form=='human'then return self:Heal(best,nil,permission)end
 return self:StartTransform('human',nil,function()return Menu.Heal.Transform:Value()and permission()end,best,'heal')
end
function NidaleeChampion:AttackSpeedAssist()
 if not Menu.Heal.AttackSpeed:Value()or self:Form()~='human'or not self:Ready(_E)or not Core.manaAbove(Menu.Heal.Mana:Value())then return false end
 local best,token,score
 for _,u in ipairs(self:Rows('ally',self.profile.healRange))do local a=u.activeSpell
  if self:AllyAllowed(u)and a and a.valid and not a.isStopped and Core:IsAttackCast(a)and finite(a.startTime)and finite(a.castEndTime)
   and a.startTime<=Game.Timer()and a.castEndTime>=Game.Timer()then
   local target
   for _,enemy in ipairs(self:Rows('enemy',2000))do if a.target==id(enemy)or a.target==enemy.handle then target=enemy;break end end
   if target then local value=self.allies[id(u)].node:Value()
    if not best or value>score then best,token,score=u,{start=a.startTime,target=a.target},value end
   end
  end
 end
 if not best then return false end
 return self:Heal(best,Core:ModeContext('Combo'),function()local a=best.activeSpell
  return Menu.Heal.AttackSpeed:Value()and Core.manaAbove(Menu.Heal.Mana:Value())and a and a.valid and not a.isStopped and a.startTime==token.start
   and a.target==token.target and finite(a.castEndTime)and a.castEndTime>=Game.Timer()end)
end
function NidaleeChampion:SafeLanding(p,offense)
  if not validPoint(p)or type(Game.isWall)~='function'or Game.isWall(p)~=false or IsUnderTurret2(p)then return false end
 -- Endpoint clearance samples keep a unit's body out of nearby wall cells.
 local radius=myHero.boundingRadius;if not finite(radius)or radius<=0 or radius>100 then return false end
 for _,v in ipairs({Vector(p.x+radius,p.y,p.z),Vector(p.x-radius,p.y,p.z),Vector(p.x,p.y,p.z+radius),Vector(p.x,p.y,p.z-radius)})do if Game.isWall(v)~=false then return false end end
 if offense and(myHero.maxHealth<=0 or myHero.health/myHero.maxHealth*100<Menu.Misc.HP:Value()or GetEnemyCount(600,p)>Menu.Misc.Enemies:Value())then return false end
 return true
end
function NidaleeChampion:PouncePlan(u,aim,offense)
  if self:Form()~='cougar'or not self:Ready(_W)or not validPoint(aim)then return nil end
 local distance=GetDistance(aim,myHero.pos);if distance<40 then return nil end
 local hunt=u and self:Hunt(u);local range=hunt and 750 or 400
 if u and(not self:Current(u)or distance>range)then return nil end
 local destination=distance>range and myHero.pos:Extended(aim,range)or point(aim)
 -- Normal non-hunted and Classic direction casts jump the full displayed 400.
 -- Restrict those to an explicit 400 endpoint; a shorter cursor is not landing proof.
 if not hunt then destination=myHero.pos:Extended(aim,400)end
 if not self:SafeLanding(destination,offense)then return nil end
 return {position=point(destination),origin=point(myHero.pos),range=range,hunt=hunt and expiry(hunt),target=u,handle=u and u.handle}
end
function NidaleeChampion:Pounce(u,aim,context,permission,offense)
 if self.leap or permission and not permission()then return false end;local plan=self:PouncePlan(u,aim,offense);if not plan then return false end
 local function resolve()
  if permission and not permission()or u and u.handle~=plan.handle then return nil,'pounce_context_changed'end
  local current=u and u.pos or point(mousePos);if not current then return nil end
  if not u and GetDistance(current,aim)>50 then return nil,'cursor_direction_changed'end
  local fresh=self:PouncePlan(u,current,offense)
  if not fresh or GetDistance(myHero.pos,plan.origin)>35 then return nil,'pounce_origin_changed'end;return fresh
 end
 if not Core:Cast(HK_W,plan.position,{intentTarget=u,context=context,range=plan.range,prevalidateWorldCast=true,deferAttackWindup=true,resolve=resolve,
  observe=function(q)return self:NativeCast(q)end,
  validate=function(q,r)
   return self:Ready(_W)and self:Form()=='cougar'and r and point(r.position)and self:SafeLanding(r.position,offense)
    and GetDistance(myHero.pos,plan.origin)<=35 and(not permission or permission())and(not u or u.handle==plan.handle and self:Current(u)
     and(not plan.hunt or self:Hunt(u)and expiry(self:Hunt(u))==plan.hunt))
  end})then return false end
 self.leap={q=Core.lastIntent,origin=plan.origin,position=plan.position,hunt=plan.hunt~=nil,expires=Game.Timer()+1.2};return true
end
function NidaleeChampion:ContinueLeap()
 local row=self.leap;if not row then return false end;local q=row.q;local r=Core.adapter:Poll(q.id)
 if not r or r.state=='cancelled_before_send'or q.cancelled or not q.continue()or Game.Timer()>row.expires then self.leap=nil;return false end
 -- The lock only keeps a second pounce from being queued on top of this one.
 -- It ends on the first solid evidence: the cast seen (natively, or by W going
 -- on cooldown in cougar form) and its dash over, wherever that dash ended, or,
 -- for a dash too short to be seen, a moment after the cast. Requiring a landing
 -- within 80 units of the planned point held it for the full 1.2 s whenever the
 -- pounce was shortened, blocked or redirected at a moving hunted target.
 if not q.observedAt and not(self:Form()=='cougar'and Core:CooldownStarted(q))then return true end
 row.castAt=row.castAt or Game.Timer()
 if myHero.pathing and myHero.pathing.isDashing then row.dash=true;return true end
 if row.dash or Game.Timer()-row.castAt>.3 then
  self.leap=nil;self:SampleForm()
  -- Development only: travelled distance and time settle Pounce range and dash speed per profile.
  if Core.logger then Core:Trace('nidalee_pounce',{profile=self.profile.id,travelled=GetDistance(myHero.pos,row.origin),
   planned=GetDistance(row.position,row.origin),seconds=Game.Timer()-row.castAt,dashSeen=row.dash==true,hunt=row.hunt==true})end
  return false
 end
 return true
end
function NidaleeChampion:Swipe(u,context,permission)
 if self:Form()~='cougar'or not self:Ready(_E)or not self:Current(u)or GetDistance(u.pos,myHero.pos)>300 or permission and not permission()then return false end
 local handle=u.handle
 return Core:Cast(HK_E,point(u.pos),{intentTarget=u,context=context,range=350,deferAttackWindup=true,waitingKey='swipe',
  resolve=function()if u.handle~=handle or not self:Current(u)or GetDistance(u.pos,myHero.pos)>300 then return nil end;return {position=point(u.pos)}end,
  observe=function(q)return self:NativeCast(q)end,
  validate=function(q,r)return self:Ready(_E)and self:Form()=='cougar'and u.handle==handle and self:Current(u)and GetDistance(u.pos,myHero.pos)<=300
   and r and GetDistance(u.pos,r.position)<=35 and(not permission or permission())end})
end
function NidaleeChampion:SwipeCount(aim,kind)
 if not point(aim)then return 0 end;local length=GetDistance(aim,myHero.pos);if length<=0 then return 0 end
 local dx,dz=(aim.x-myHero.pos.x)/length,(aim.z-myHero.pos.z)/length;local count=0
 for _,u in ipairs(self:Rows(kind,300))do local x,z=u.pos.x-myHero.pos.x,u.pos.z-myHero.pos.z;local d=math.sqrt(x*x+z*z)
  if d>0 and(x*dx+z*dz)/d>=math.cos(math.pi/4)then count=count+1 end
 end;return count
end
function NidaleeChampion:OnPostAttack()
 local a=myHero.activeSpell;local target=_G.SDK.Orbwalker.LastTarget
 if not a or not a.valid or not Core:IsAttackCast(a)or not target or not self:Current(target)or not finite(a.startTime)or not finite(a.castEndTime)
  or a.startTime>Game.Timer()or a.castEndTime>Game.Timer()or Game.Timer()-a.castEndTime>.12 or(a.target~=id(target)and a.target~=target.handle)then return end
 self.attack={start=a.startTime,ends=a.castEndTime,target=target,handle=target.handle,expires=Game.Timer()+.3}
end
function NidaleeChampion:AttackFresh(u)
 local a=self.attack;local native=myHero.activeSpell
 return a and a.target==u and a.handle==u.handle and a.expires>Game.Timer()and self:Current(u)
  and(not native or not native.valid or native.startTime==a.start)
end
function NidaleeChampion:Takedown(u,context,permission,rescue,followPermission)
 if self.empower or self:Form()~='cougar'or not self:Ready(_Q)or not self:Current(u)or not _G.SDK.Data:IsInAutoAttackRange(myHero,u)
  or not rescue and not self:AttackFresh(u)or permission and not permission()then return false end
 local handle=u.handle;local witness=self.attack
 if not Core:Cast(HK_Q,nil,{context=context,observe=function(q)return self:NativeCast(q)end,
  validate=function()return self:Ready(_Q)and self:Form()=='cougar'and u.handle==handle and self:Current(u)and _G.SDK.Data:IsInAutoAttackRange(myHero,u)
   and(rescue or self.attack==witness and self:AttackFresh(u))and(not permission or permission())end})then return false end
 self.empower={q=Core.lastIntent,target=u,handle=handle,context=context,permission=followPermission or permission,expires=Game.Timer()+1};return true
end
function NidaleeChampion:ContinueTakedown()
 local row=self.empower;if not row then return false end;local r=Core.adapter:Poll(row.q.id)
 if not r or r.state=='cancelled_before_send'or row.q.cancelled or not row.q.continue()or row.permission and not row.permission()or Game.Timer()>row.expires then self.empower=nil;return false end
 -- Takedown has no cast time, so the host may never show a native cast for it
 -- and the wait then ran to its 1 s expiry with the whole tick held. Q going on
 -- cooldown in cougar form is the same cast seen another way (accepted a moment
 -- later, so a shown native cast is preferred); a sent key that produced neither
 -- within 0.3 s only releases the lock, without the follow-up attack.
 if not row.q.observedAt then
  if self:Form()=='cougar'and Core:CooldownStarted(row.q)then row.cooldownAt=row.cooldownAt or Game.Timer();if Game.Timer()-row.cooldownAt<.1 then return true end
  elseif r.sentAt and Core.adapter:Now()-r.sentAt>300 then self.empower=nil;return false
  else return true end
 end
 self.attack=nil
 local u=row.target;if not self:Current(u)or u.handle~=row.handle or self:Form()~='cougar'then self.empower=nil;return false end
 -- No direct ResetAutoAttack call: the productive SDK owns native reset evidence.
 local previous=myHero.activeSpell and myHero.activeSpell.startTime
 if Core:Attack(u,{context=row.context,validate=function()return self:Form()=='cougar'and self:Current(u)and u.handle==row.handle and(not row.permission or row.permission())end,
  observe=function(q)local a=Core:NativeAttack(q);return a and a.startTime~=previous
   and(a.target==id(u)or a.target==u.handle)end})then self.empower=nil end
 return true
end
function NidaleeChampion:Trap(u,context,permission)
 if self:Form()~='human'or not self:Ready(_W)or not self:Current(u)or GetDistance(u.pos,myHero.pos)>900 or permission and not permission()then return false end
 local p=point(u.pos);if not p or type(Game.isWall)~='function'or Game.isWall(p)~=false then return false end
 for _,row in ipairs(self.traps)do if row.expires>Game.Timer()and GetDistance(p,row.position)<150 then return false end end
 local arm=self.profile.trapArm
 if u.type==Obj_AI_Hero and not trapControlled(u,arm)then return false end
 local handle=u.handle
 if not Core:Cast(HK_W,p,{intentTarget=u,context=context,range=900,observe=function(q)return self:NativeCast(q)end,
  validate=function()return self:Ready(_W)and self:Form()=='human'and self:Current(u)and u.handle==handle and GetDistance(u.pos,p)<60
   and Game.isWall(p)==false and(u.type~=Obj_AI_Hero or trapControlled(u,arm))and(not permission or permission())end})then return false end
 -- An accepted placement is a short anti-spam claim, never a spawned trap.
 self.traps[#self.traps+1]={position=p,expires=Game.Timer()+2,q=Core.lastIntent};if #self.traps>8 then table.remove(self.traps,1)end;return true
end
-- Traps from the shared scan (Core:ZoneTargets): stasis, revives, channels, teleport and gate arrivals
-- and hard control that last until the trap is armed (cast .25 s + arm).
function NidaleeChampion:ZoneTrap(context,permission)
 if self:Form()~='human'or not self:Ready(_W)or permission and not permission()or type(Game.isWall)~='function'then return false end
 local rows=Core:ZoneTargets({range=900,arm=.25+self.profile.trapArm})
 for i=1,math.min(#rows,5)do local row=rows[i];local p=point(row.position)
  local claimed=not p
  for _,t in ipairs(p and self.traps or {})do if t.expires>Game.Timer()and GetDistance(p,t.position)<150 then claimed=true;break end end
  if p and not claimed and Game.isWall(p)==false and GetDistance(p,myHero.pos)<=900 then
   if Core:Cast(HK_W,p,{context=context,range=900,observe=function(q)return self:NativeCast(q)end,
    validate=function()return self:Ready(_W)and self:Form()=='human'and row.valid()and Game.isWall(p)==false and(not permission or permission())end})then
    self.traps[#self.traps+1]={position=p,expires=Game.Timer()+2,q=Core.lastIntent};if #self.traps>8 then table.remove(self.traps,1)end
    return true
   end
  end
 end
 return false
end
function NidaleeChampion:ContinueTransform()
 local row=self.sequence;if not row then return false end;local r=Core.adapter:Poll(row.q.id)
 if not r or r.state=='cancelled_before_send'or row.q.cancelled or not row.q.continue()or row.permission and not row.permission()or Game.Timer()>row.expires then self.sequence=nil;return false end
 if not row.q.observedAt or self:Form()~=row.form then return true end
 self.sequence=nil;self:SampleForm();local u=row.target
 if u and(u.handle~=row.handle or not self:Current(u))then return false end
 if row.kind=='spear'then return self:CastSpear(u,row.context,row.permission)
 elseif row.kind=='heal'then return self:Heal(u,row.context,row.permission)
 elseif row.kind=='pounce'then return self:Pounce(nil,point(mousePos),row.context,row.permission,false)
 elseif row.kind=='hunt'or row.kind=='huntfarm'then return self:Pounce(u,u.pos,row.context,row.permission,row.kind=='hunt')end
 return false
end
-- A fresh own Hunt mark lets Pounce reach 750 (Normal). From human form: switch and jump at once while
-- the mark lasts for the switch and the jump, Pounce is (or may be) ready and the landing is allowed.
function NidaleeChampion:HuntEngage(u,offense)
 if not self.profile.hunt or self:Form()~='human'or not self:Ready(_R)then return false end
 local mark=self:Hunt(u);if not mark or expiry(mark)<Game.Timer()+.55 then return false end
 if GetDistance(u.pos,myHero.pos)>750 then return false end
 local known=self.cooldowns.cougar[_W];if known and not self:HiddenReady('cougar',_W)then return false end
 return self:SafeLanding(u.pos,offense)
end
function NidaleeChampion:CougarUseful(u,node,hidden)
 local distance=GetDistance(u.pos,myHero.pos)
 local function ready(slot)
  if not hidden then return self:Ready(slot)end
  -- First entry can inspect an unseen form. It cannot authorize a spell until
  -- the observed form/readiness checks pass. Known cooldowns remain binding.
  local row=self.cooldowns.cougar[slot]
  return not row or self:HiddenReady('cougar',slot)
 end
 local attackRange=hidden and(125+(myHero.boundingRadius or 0)+(u.boundingRadius or 0))or nil
 if node.Q2:Value()and ready(_Q)and(hidden and distance<=attackRange or not hidden and _G.SDK.Data:IsInAutoAttackRange(myHero,u))then return true end
 if node.E2:Value()and ready(_E)and distance<=300 then return true end
 if node.Engage:Value()and ready(_W)then
  if hidden then return distance<=350 end
  return self:PouncePlan(u,u.pos,true)~=nil
 end
 return false
end
function NidaleeChampion:Combat(mode)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return false end;local u=GetTarget(1500)
 if not self:Current(u)then
  if not node.Q:Value()then return false end
  u=Core:SkillshotTarget(self.QSpell,2);if not u then return false end
  local context=Core:ModeContext(mode)
  local permission=function()return node.Q:Value()and Core.manaAbove(node.Mana:Value())end
  if self:Form()=='human'then return self:CastSpear(u,context,permission)end
  if node.R:Value()and self:HiddenReady('human',_Q)then
   return self:Transform('human',context,function()return node.R:Value()and permission()and self:SpearCurrent(u)end)
  end
  return false
 end
 if mode=='Combo'and self:AttackSpeedAssist()then return true end
 local context=Core:ModeContext(mode);local permission=function()return Core.manaAbove(node.Mana:Value())end;local form=self:Form()
 if form=='human'then
  if node.Q:Value()and self:CastSpear(u,context,function()return node.Q:Value()and permission()end)then return true end
  if node.W:Value()and(self:ZoneTrap(context,function()return node.W:Value()and permission()end)
   or self:Trap(u,context,function()return node.W:Value()and permission()end))then return true end
  if node.Engage:Value()and node.R:Value()and self:HuntEngage(u,true)then
   return self:StartTransform('cougar',context,function()return node.Engage:Value()and node.R:Value()and permission()and self:Current(u)
    and(self:Form()=='cougar'or self:HuntEngage(u,true))end,u,'hunt')
  end
   if node.R:Value()and GetDistance(u.pos,myHero.pos)<=350 and self:SafeLanding(u.pos,true)and self:CougarUseful(u,node,true)then
     return self:StartTransform('cougar',context,function()return node.R:Value()and permission()and self:Current(u)
      and(self:Form()=='cougar'or GetDistance(u.pos,myHero.pos)<=350 and self:SafeLanding(u.pos,true)and self:CougarUseful(u,node,true))end,u,'combat')
  end
 else
   if node.E2:Value()and self:Swipe(u,context,function()return node.E2:Value()and permission()end)then return true end
   if node.Q2:Value()and self:Takedown(u,context,function()return node.Q2:Value()and permission()end)then return true end
   if node.Engage:Value()and self:Pounce(u,u.pos,context,function()return node.Engage:Value()and permission()end,true)then return true end
   -- Low on health with nothing left to do in cougar form: back to human and heal (even with the
   -- mid-fight heal switch off, which keeps its meaning).
   if self:HiddenReady('human',_E)and self:HealEligible(myHero)and not self:CougarUseful(u,node,false)then
    return self:StartTransform('human',context,function()return self:HealEligible(myHero)and(self:Form()=='human'or not self:CougarUseful(u,node,false))end,myHero,'heal')
   end
   -- Harass returns to human for the spear even with its form switch off: leaving cougar form is no dive.
   local back=node.R:Value()or mode=='Harass'
   if back and node.Q:Value()and self:HiddenReady('human',_Q)and not self:CougarUseful(u,node,false)then
    return self:StartTransform('human',context,function()return(node.R:Value()or mode=='Harass')and node.Q:Value()and permission()
     and self:Current(u)and self:HiddenReady('human',_Q)and(self:Form()=='human'or not self:CougarUseful(u,node,false))end,u,'spear')
  end
 end;return false
end
function NidaleeChampion:Combo()return self:Combat('Combo')end
function NidaleeChampion:Harass()return self:Combat('Harass')end
function NidaleeChampion:CSUseful(u,slot)
 if not self:Current(u)or u.team==300 or u.team==myHero.team then return false end
 -- Earliest native windup / spell onset prevents predicted later damage from
 -- authorizing a cast that would merely soften a still-healthy minion.
 local impact=self:Form()=='human'and(.25+GetDistance(u.pos,myHero.pos)/1300)or slot==_Q and(myHero.attackData.windUpTime or .25)or .25
 -- A lone-minion rule keeps Swipe from softening the wave.
 return Core:Rescue(u,impact,function()return self:Damage(u,slot)end,readyAttack)
  and not(self:Form()=='cougar'and slot==_E and #self:Rows('lane',350)>1)
end
function NidaleeChampion:CSContinuation(u)
 local impact=myHero.attackData.windUpTime
 if not finite(impact)or impact<0 or not self:Current(u)then return false end
 local hp=Core:UnshieldedLegacyForecast(u,impact)
 return finite(hp)and hp>0 and self:Damage(u,_Q)>=hp+(u.hpRegen or 0)*impact
end
function NidaleeChampion:Farm(kind,node,context,rescue)
  if not Core.manaAbove(node.Mana:Value())then return false end;local form=self:Form();local rows=self:Rows(kind,form=='human'and 1500 or 400);local u
 local qnode=form=='cougar'and node.Q2 or node.Q
 local wnode=form=='cougar'and node.W2 or node.W
 local enode=node.E2 or node.E
 for _,v in ipairs(rows)do if(not rescue or qnode:Value()and self:CSUseful(v,_Q)or enode:Value()and self:CSUseful(v,_E))and(not u or v.maxHealth>u.maxHealth)then u=v end end;if not u then return false end
 local function permission(slot)return Core.manaAbove(node.Mana:Value())and(slot==_Q and qnode or slot==_W and wnode or enode):Value()
  and(not rescue or self:CSUseful(u,slot))and(slot~=_E or form~='cougar'or kind~='lane'or rescue or self:SwipeCount(u.pos,'lane')>=node.Count:Value())end
 if form=='human'then
  if node.Q:Value()and self:CastSpear(u,context,function()return permission(_Q)end)then return true end
  if not rescue and kind=='jungle'and node.W:Value()and self:Trap(u,context,function()return permission(_W)end)then return true end
  if not rescue and kind=='jungle'and node.R:Value()and node.W2 and node.W2:Value()and self:HuntEngage(u,false)then
   return self:StartTransform('cougar',context,function()return node.R:Value()and node.W2:Value()and Core.manaAbove(node.Mana:Value())
    and self:Current(u)and(self:Form()=='cougar'or self:HuntEngage(u,false))end,u,'huntfarm')
  end
  if not rescue and node.R:Value()and GetDistance(u.pos,myHero.pos)<=350 then return self:Transform('cougar',context,function()return node.R:Value()and Core.manaAbove(node.Mana:Value())and self:Current(u)and GetDistance(u.pos,myHero.pos)<=350 end)end
 else
   if enode:Value()and(kind=='jungle'or rescue or #self:Rows('lane',300)>=node.Count:Value())and self:Swipe(u,context,function()return permission(_E)end)then return true end
   if qnode:Value()and self:Takedown(u,context,function()return permission(_Q)end,rescue,rescue and function()
    return qnode:Value()and self:CSContinuation(u)
  end or nil)then return true end
   if not rescue and kind=='jungle'and wnode:Value()and GetDistance(u.pos,myHero.pos)>=350 then return self:Pounce(u,u.pos,context,function()return permission(_W)end,false)end
   if not rescue and node.R:Value()and node.Q:Value()and self:HiddenReady('human',_Q)and not self:Ready(_Q)and not self:Ready(_E)then
    return self:StartTransform('human',context,function()return node.R:Value()and node.Q:Value()and Core.manaAbove(node.Mana:Value())end,u,'spear')end
 end;return false
end
function NidaleeChampion:LaneClear()
 if not Core:FarmModeEnabled('lane')or not Menu.Clear.SpellFarm:Value()then return false end
 return self:Farm('lane',Menu.Clear.LaneClear,Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end),false)
end
function NidaleeChampion:JungleClear()
 if not Core:FarmModeEnabled('jungle')or not Menu.Clear.SpellFarm:Value()then return false end
 return self:Farm('jungle',Menu.Clear.JungleClear,Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end),false)
end
function NidaleeChampion:LastHit()return self:Farm('lane',Menu.LastHit,Core:RescueContext(),true)end
function NidaleeChampion:Flee(context,permission)
 context=context or Core:ModeContext('Flee');permission=permission or function()return Menu.Misc.Flee:Value()end
  if not permission()or not validPoint(mousePos)then return false end
 if self:Form()=='human'then return self:StartTransform('cougar',context,permission,nil,'pounce')end
 return self:Pounce(nil,point(mousePos),context,permission,false)
end
function NidaleeChampion:Assist()
 if Menu.Misc.Spear:Value()then local u=GetTarget(1500);if not self:Current(u)then return false end
  local permission=function()return Menu.Misc.Spear:Value()end;local context=Core:HeldContext(permission)
  if self:Form()=='human'then return self:CastSpear(u,context,permission)end
  return self:StartTransform('human',context,permission,u,'spear')
 end;return false
end
function NidaleeChampion:PreparePreview()
 -- Only what the game does not show: the other form's cooldowns (the current form, its spells and R are on
 -- the HUD). End times are kept, so Draw counts down without a new preparation and never blinks.
 local current=self:Form();local rows={}
 for _,form in ipairs({'human','cougar'})do if form~=current then for slot=0,2 do local row=self.cooldowns[form][slot]
   if row and finite(row.ends)then rows[#rows+1]={label=(form=='human'and 'Human 'or 'Cougar ')..({'Q','W','E'})[slot+1],ends=row.ends}end end end end
 self.preview={lines=rows,expires=Game.Timer()+1}
end
function NidaleeChampion:Tick()
 if ShouldWait()or not Core:Available()then self.sequence=nil;self.leap=nil;self.empower=nil;self.attack=nil;return end
 self:SampleForm();if Game.Timer()>=(self.nextAllies or 0)then self:DiscoverAllies()end
 if Core.logger then self:DevTraces()end
 if self:ContinueLeap()or self:ContinueTakedown()or self:ContinueTransform()or IsCasting()then return end
 if self:Assist()or self:AutoHeal()or self:Finisher()then return end
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LaneClear'then if not self:LaneClear()then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and Menu.Draw.Preview:Value()and Game.Timer()>=(self.nextPreview or 0)then self.nextPreview=Game.Timer()+.15;self:PreparePreview()end
end
-- Health-bar damage (S9): the spear when human Q is ready (or ready after a switch), the cougar abilities
-- that are ready in cougar form, plus one attack. Minimum damage only (no distance or missing-health bonus).
function NidaleeChampion:ComboDamage(u)
 local aa=_G.SDK.Damage:GetAutoAttackDamage(myHero,u);if not finite(aa)or aa<0 then aa=0 end
 local damage=aa;local form=self:Form()
 if form=='human'and self:Ready(_Q)or form=='cougar'and self:HiddenReady('human',_Q)then damage=damage+self:SpearDamage(u)end
 if form=='cougar'then for _,slot in ipairs({_Q,_W,_E})do if self:Ready(slot)then damage=damage+self:Damage(u,slot)end end end
 return damage,true
end
-- Development only. Nidalee-2: spear damage against distance travelled (launch point, victim distance,
-- health lost, minimum damage). Nidalee-6: Swipe hits by angle off the cast direction.
function NidaleeChampion:DevTraces()
 local now=Game.Timer();local cast=myHero.activeSpell
 if cast and cast.valid and finite(cast.startTime)and cast.startTime~=self.traceStart and(cast.name==self.profile.q or cast.name==self.profile.cougar[3])then
  self.traceStart=cast.startTime;local at=point(cast.placementPos)
  local spear=cast.name==self.profile.q;local rows={}
  local list={}
  for _,kind in ipairs({'enemy','jungle','lane'})do local more=self:Rows(kind,spear and 1600 or 450);for i=1,math.min(#more,10)do list[#list+1]=more[i]end end
  for i=1,math.min(#list,10)do local u=list[i]
   if self:Current(u)and finite(u.health)then rows[#rows+1]={unit=u,handle=u.handle,health=u.health,minimum=spear and self:SpearDamage(u)or self:Damage(u,_E)} end
  end
  self.watch={spear=spear,origin=point(myHero.pos),at=at,start=cast.startTime,rows=rows,untilAt=now+(spear and 1.6 or .4)}
 end
 local w=self.watch;if not w or now<w.untilAt and w.spear then
  if w and w.spear then
   for _,r in ipairs(w.rows)do local u=r.unit
    if not r.done and self:Current(u)and u.handle==r.handle and finite(u.health)and u.health<r.health-.5*r.minimum then
     r.done=true;Core:Trace('nidalee_spear',{profile=self.profile.id,travelled=GetDistance(u.pos,w.origin),lost=r.health-u.health,
      minimum=r.minimum,afterCast=now-w.start,unitType=u.type==Obj_AI_Hero and 'hero'or 'unit'})
    end
   end
  end
  return
 end
 if now<w.untilAt then return end
 self.watch=nil
 if w.spear or not w.at then return end
 local dx,dz=w.at.x-w.origin.x,w.at.z-w.origin.z;local length=math.sqrt(dx*dx+dz*dz);if length<1 then return end
 for _,r in ipairs(w.rows)do local u=r.unit
  if self:Current(u)and u.handle==r.handle then
   local x,z=u.pos.x-w.origin.x,u.pos.z-w.origin.z;local d=math.sqrt(x*x+z*z)
   local angle=d>0 and math.deg(math.acos(math.max(-1,math.min(1,(x*dx+z*dz)/(d*length)))))or 0
   Core:Trace('nidalee_swipe',{profile=self.profile.id,distance=d,angle=angle,hit=finite(u.health)and u.health<r.health-1})
  end
 end
end
function NidaleeChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.Ranges:Value()then Draw.Circle(myHero.pos,self.observedForm=='human'and 1500 or 400,1,Draw.Color(255,150,220,100))end
 local p=self.preview;if Menu.Draw.Preview:Value()and p and p.expires>Game.Timer()then
  local now,y=Game.Timer(),myHero.pos2D.y+40
  for _,line in ipairs(p.lines)do local left=line.ends-now
   if left>0 then Draw.Text(string.format('%s %.1fs',line.label,left),12,myHero.pos2D.x,y,Draw.Color(255,180,220,130));y=y+14 end
  end
 end
end
function NidaleeChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Nidalee: modes','Nidalee: forms'},function(page)
  return {title='Nidalee assistance',cards=page==1 and {
   {'MODES','Provider binds control Combo, Harass, separate lane/jungle, LastHit and Flee. Ability farming is one toggle and starts off.'},
    {'CONTROL','Human and cougar abilities are selected separately. Combo R switches for reachable useful actions. Combo pounces onto a target within the health and enemy limits. Hold the spear bind for spear assistance; Flee pounces toward the cursor after a terrain check. A champion an ability kills is finished without a mode key, switching back for the spear when needed. A fresh Hunt mark lets Combo switch and pounce from up to 750. Low on health with nothing left in cougar form, Nidalee switches back to heal. Pounce is not offered to Evade (its dash speed is not published).'},
   {'HEAL','Heals run without a mode key, by missing health and mana; an ally an enemy champion is about to hit is healed 20 points earlier. Each ally, and you, has its own switch and priority. Leaving cougar form to heal is a separate option.'}}or {
   {'FORMS','Human and cougar cooldowns retain native observations. An unseen form starts unknown. Continuations require actual transformation and current native readiness.'},
   {'HUNT','Only your fresh normal Hunt permits an extended jump. Classic uses its own kit and no modern Hunt. Jumps wait for cast, dash and actual landing.'},
   {'FARM','LastHit preserves lethal attacks and confirmed incoming kills. Spear distance and cougar execute amplification are excluded from lethal guarantees. Trap placement claims do not prove spawned traps.'}}}
 end)
end
Core:StandardPolicy(NidaleeChampion,{damageTypes={Q='magical',W='magical',E='magical'},exceptions={non_interrupting_summoner=true}})
NidaleeChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Nidalee"]="Nidalee"}
local normalSupported={["Nidalee"]=true}

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
