return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Lucian"]=function()return _G.OrbamaFamily:Require("b74460e7226f83da2efa08861b0ae7ce68e4f03857ba07fc9afb4d4a272f1db8")()end
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
if champion=="Lucian" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Lucian',profiles={normal=true,classic=true},
 Create=function(context)
local GameplayHooks=(function(g,C,P)
 local H,G,SDK=g.myHero,g.Game,g.SDK
 local id=C.id
 local finite=P.Finite
 local function permission(f,mode,slot)return function()return f:Permission(mode,slot)end end
 local Hooks={}

 -- Lightslinger: every ability makes the next attack fire twice. The kit is two
 -- shots per ability, so abilities go between attacks and never over a pending
 -- empowered attack. The second shot leaves 0.25-0.33 s after the first one's
 -- cast end (enemy Jade_Lucian recording, 2026-10-27); a cast before then can
 -- cost it, so abilities wait that long after an empowered attack.
 local SECOND_SHOT=.35
 Hooks.defaults={Combo={R=true},JungleClear={E=true}}
 Hooks.options={'Risk','PreferPassive'}
 Hooks.modeSlots={Combo={'Q','W','E','R'},Harass={'Q','W','E'},LaneClear={'Q'},JungleClear={'Q','W','E'},LastHit={'Q'},Flee={'E'}}
 Hooks.assistLabels={[0]='Cast Q at the selected target',[3]='Cast R at the selected target'}
 function Hooks.empowered(f)return f:Buff(H,f.profile.passiveNames)~=nil end
 function Hooks.culling(f)return f:Buff(H,f.profile.channelNames)~=nil end
 -- R in flight shows another spell name in slot R (Ready refuses it); the buff
 -- refuses a recast as well, which would end the channel.
 function Hooks.ready(f,slot)if slot==3 and Hooks.culling(f)then return false end end
 function Hooks.menu(f,menu)
  menu.Combo:MenuElement({id='RLock',name='Move to keep R on the target',value=true})
 end
 -- The Culling fires along the direction it was cast in while Lucian moves.
 -- In Combo he walks sideways onto the line through the target's position in
 -- 0.25 s (the shared movement lease); his distance along the line is kept,
 -- so he never walks at the target. Off the line by less than 40, beyond
 -- R's reach, behind him or a wall or turret landing: no lease.
 local LOCK_OWNER='LucianRLock'
 local function lockPoint(f)
  local d=f.rDirection;if not d or f:Mode()~='Combo'or not f.menu.Combo.RLock:Value()then return nil end
  local u=f:Target(f.profile.r.range);if not u then return nil end
  local lead=(u.ms or 0)*.25;local path=u.pathing;local to=path and path.hasMovePath==true and f.point(path.endPos)
  local tx,tz=u.pos.x,u.pos.z
  if to then local dx,dz=to.x-tx,to.z-tz;local l=math.sqrt(dx*dx+dz*dz);if l>1 then local k=math.min(lead,l)/l;tx,tz=tx+dx*k,tz+dz*k end end
  local x,z=tx-H.pos.x,tz-H.pos.z;local along=x*d.x+z*d.z;local cross=x*d.z-z*d.x
  if along<=100 or along>f.profile.r.range-50 or math.abs(cross)<40 then return nil end
  local p=g.Vector(tx-d.x*along,H.pos.y,tz-d.z*along)
  return f:Safe(p,false)and p or nil
 end
 function Hooks.observe(f)
  local cast=H.activeSpell
  if cast and cast.valid and type(cast.name)=='string'and cast.name:find('PassiveAttack',1,true)and finite(cast.castEndTime)then
   local until_=cast.castEndTime+SECOND_SHOT;if not f.secondShotUntil or until_>f.secondShotUntil then f.secondShotUntil=until_ end
  end
  if not Hooks.culling(f)then
   if f.rDirection then f.rDirection=nil;C:ReleaseMovePreference(LOCK_OWNER)end
   -- The direction comes from the R cast itself (startPos to placementPos).
   local from,to=cast and cast.valid and cast.name==f.profile.names[4][1]and f.point(cast.startPos),cast and f.point(cast.placementPos or cast.endPos)
   if from and to then local dx,dz=to.x-from.x,to.z-from.z;local l=math.sqrt(dx*dx+dz*dz);f.rCast=l>1 and {x=dx/l,z=dz/l}or nil end
   return
  end
  f.rDirection=f.rDirection or f.rCast;f.rCast=nil
  local p=lockPoint(f)
  if p then C:PreferMove(LOCK_OWNER,p,.25)else C:ReleaseMovePreference(LOCK_OWNER)end
 end
 -- An ability may go now: no second shot is still to leave, and with the
 -- target in attack range no empowered attack is waiting and the cast fits
 -- before the next attack (C:WeaveWindow). Out of range nothing is delayed.
 function Hooks.window(f,u,castTime)
  if f.secondShotUntil and G.Timer()<f.secondShotUntil then return false end
  if not u or not f:AttackReach(u)then return true end
  if Hooks.empowered(f)and f.menu.Misc.PreferPassive:Value()then return false end
  return(C:WeaveWindow(castTime,u))
 end
 local function qReach(f,u)return f:Range(0)+(u.boundingRadius or 0)end
 function Hooks.qSettings(f)
  if not f.lucianQSettings then local q=f.profile.q;local O=g.OrbamaPrediction
   f.lucianQSettings={Type=O.SPELLTYPE_LINE,Delay=q.delay,Radius=q.radius,Range=q.beam,Speed=math.huge,Collision=false}
  end
  return f.lucianQSettings
 end
 -- The beam from the player through `via` reaches `p` (a point with a unit radius).
 local function beamHits(f,via,p,radius)
  local dx,dz=via.x-H.pos.x,via.z-H.pos.z;local length=math.sqrt(dx*dx+dz*dz);if length<1 then return false end
  local x,z=p.x-H.pos.x,p.z-H.pos.z;local along=(x*dx+z*dz)/length
  return along>0 and along<=f.profile.q.beam and math.abs(x*dz-z*dx)/length<=f.profile.q.radius+radius,along
 end
 -- Q through another unit: the beam continues to its full length behind the
 -- unit Q is cast on. Of at most 12 units in cast range whose beam reaches the
 -- champion's predicted position (20 inside its edge), the nearest one.
 -- Dispatch re-reads both units and the champion's current position.
 function Hooks.extendedQ(f,u,context,allowed)
  if u.type~=g.Obj_AI_Hero or not f:Current(u)or not f:Ready(0)then return false end
  if f.distance(H.pos,u.pos)>f.profile.q.beam+(u.boundingRadius or 0)then return false end
  local pred=C:Prediction(Hooks.qSettings(f));pred:GetPrediction(u,H)
  local aim=pred:CanHit(2)and f.point(pred.UnitPosition);if not aim then return false end
  local radius=(u.boundingRadius or 65)-20;local best,bestAlong;local seen=0
  for _,kind in ipairs({'lane','jungle','hero'})do
   for _,v in ipairs(f:Rows(kind,f:Range(0)+200))do seen=seen+1;if seen>12 then break end
    if v~=u and f:Reach(v,qReach(f,v))and f:Allowed(v)then
     local hit,along=beamHits(f,v.pos,aim,radius)
     if hit and along>f.distance(H.pos,v.pos)and(not best or along<bestAlong)then best,bestAlong=v,along end
    end
   end
  end
  if not best then return false end
  local via,identity,handle=best,id(best),best.handle
  return f:Cast(0,via,context,{range=qReach(f,via),permission=allowed,check=function()
   return f:Current(u)and f:Allowed(u)and id(via)==identity and via.handle==handle and Hooks.window(f,nil)
    and(beamHits(f,via.pos,u.pos,radius+(u.ms or 0)*f.profile.q.delay*.5))
  end})
 end
 function Hooks.castQ(f,u,context,allowed,urgent)
  if not urgent and not Hooks.window(f,u,f.profile.q.delay)then return false end
  if f:Reach(u,qReach(f,u))then
   return f:Cast(0,u,context,{range=qReach(f,u),permission=allowed,check=function()return urgent or Hooks.window(f,u,f.profile.q.delay)end})
  end
  return Hooks.extendedQ(f,u,context,allowed)
 end
 function Hooks.castW(f,u,context,allowed,urgent)
  if not urgent and not Hooks.window(f,u,f.profile.w.delay)then return false end
  return f:Cast(1,u,context,{world=true,permission=allowed,check=function()return urgent or Hooks.window(f,u,f.profile.w.delay)end})
 end
 -- E lands toward the cursor, at least 200 and at most 425 away. With a
 -- target the landing keeps it in attack range: the cursor landing when it
 -- does, otherwise the nearest of 8 landings around the player that does.
 -- `engage` lets the landing bring an out-of-range target into range.
 local function inRange(p,u)
  local dx,dz=p.x-u.pos.x,p.z-u.pos.z
  return math.sqrt(dx*dx+dz*dz)<=(H.range or 500)+(H.boundingRadius or 65)+(u.boundingRadius or 65)-25
 end
 local function landingFree(f,p,offense)
  if not f:Safe(p,offense)then return false end
  local r=H.boundingRadius or 65
  for i=0,3 do local a=i*math.pi/2;if G.isWall(g.Vector(p.x+math.cos(a)*r,p.y,p.z+math.sin(a)*r))~=false then return false end end
  return true
 end
 function Hooks.landing(f,u,engage,away)
  local e=f.profile.e;local cursor=C:CursorWorld();local origin=H.pos
  local function along(dir)
   local dx,dz=dir.x-origin.x,dir.z-origin.z;local d=math.sqrt(dx*dx+dz*dz);if d<1 then return nil end
   local length=math.max(e.minimum,math.min(d,e.range))
   return g.Vector(origin.x+dx/d*length,origin.y,origin.z+dz/d*length)
  end
  local function fits(p)
   if not p then return false end
   if away and f.distance(p,away.pos)<=f.distance(origin,away.pos)+100 then return false end
   if u and not inRange(p,u)then return false end
   return landingFree(f,p,engage==true)
  end
  local p=cursor and along(cursor);if fits(p)then return p end
  if not u and not away then return nil end
  local best,score
  for i=0,7 do local a=i*math.pi/4;local q=g.Vector(origin.x+math.cos(a)*e.minimum,origin.y,origin.z+math.sin(a)*e.minimum)
   if fits(q)then local s=cursor and f.distance(q,cursor)or 0;if not best or s<score then best,score=q,s end end
  end
  return best
 end
 function Hooks.castE(f,u,context,allowed)
  if not f:Ready(2)then return false end
  local engage=u and not f:AttackReach(u)
  if engage and not(f.menu.Misc.Risk:Value()and f:Reach(u,f.profile.e.range+(H.range or 500)))then return false end
  if u and not engage and not Hooks.window(f,u,0)then return false end
  local p=Hooks.landing(f,u,engage);if not p then return false end
  local identity,handle=id(u),u and u.handle
  return f:Cast(2,nil,context,{position=p,range=f.profile.e.range+5,permission=allowed,check=function()
   return(not u or f:Current(u)and id(u)==identity and u.handle==handle and(engage or Hooks.window(f,u,0))and inRange(p,u))
    and landingFree(f,p,engage)
  end})
 end
 function Hooks.combat(f,u,mode,context)
  if f:Permission(mode,3)and Hooks.castR(f,u,context,permission(f,mode,3),true)then return true end
  if f:Permission(mode,2)and Hooks.castE(f,u,context,permission(f,mode,2))then return true end
  if f:Permission(mode,0)and Hooks.castQ(f,u,context,permission(f,mode,0))then return true end
  return f:Permission(mode,1)and Hooks.castW(f,u,context,permission(f,mode,1))or false
 end
 -- After an observed attack the next ability goes at once (E resets the
 -- attack timer, Q and W fit the attack cooldown).
 function Hooks.attack(f,observation)
  local u=observation and observation.object;if not u or not f:Current(u)then return false end
  local mode=f:Mode()
  if u.type==g.Obj_AI_Hero then
   if(mode~='Combo'and mode~='Harass')or not f:Allowed(u)then return false end
   return Hooks.combat(f,u,mode,f:Context(mode))
  end
  if mode=='LaneClear'and u.team==300 then mode='JungleClear'end
  if mode~='JungleClear'or u.team~=300 then return false end
  local context=f:Context(mode)
  if f:Permission(mode,2)and Hooks.castE(f,u,context,permission(f,mode,2))then return true end
  if f:Permission(mode,0)and Hooks.castQ(f,u,context,permission(f,mode,0))then return true end
  return f:Permission(mode,1)and Hooks.castW(f,u,context,permission(f,mode,1))or false
 end
 -- The Culling: shots along one direction for 3 s. Combo uses it to finish an
 -- enemy outside attack range that Q and W cannot, counting half of the
 -- profile's shots (a design margin for a moving target, not a mechanic).
 -- Classic has no established shot count: only the selected-target bind casts it.
 function Hooks.rDamage(f,u)return f:Damage(3,u)*.5 end
 function Hooks.rSpec(f)
  if not f.lucianRSpec then local r=f.profile.r;f.lucianRSpec={range=r.range-100,radius=r.radius,speed=r.speed,delay=.1,collision=true}end
  return f.lucianRSpec
 end
 function Hooks.castR(f,u,context,allowed,needLethal)
  if not f:Ready(3)or u.type~=g.Obj_AI_Hero or not f:Reach(u,f.profile.r.range-100)then return false end
  if needLethal then
   if f:AttackReach(u)then return false end
   local quick=(f:Ready(0)and f:Damage(0,u)or 0)+(f:Ready(1)and f:Damage(1,u)or 0)
   local impact=f.distance(H.pos,u.pos)/f.profile.r.speed+.5
   if quick>0 and C:Lethal(u,impact,function()return quick end,{kind='physical'})then return false end
   local function lethal()return C:Lethal(u,impact,function()return Hooks.rDamage(f,u)end,{kind='physical'})==true end
   if not lethal()then return false end
   local base=allowed;allowed=function()return(not base or base())and lethal()end
  end
  return f:Cast(3,u,context,{world=true,spec=Hooks.rSpec(f),permission=allowed,weave=false})
 end
 function Hooks.assist(f,slot,u,context)
  if slot==0 then return Hooks.castQ(f,u,context,nil,true)end
  return Hooks.castR(f,u,context,nil,false)
 end
 -- LaneClear Q: the minion in cast range whose beam covers the most lane minions.
 function Hooks.laneQ(f,rows,mode,context)
  local need=f.menu.LaneClear.Count:Value();local best,count;local seen=0
  local function hits(via)local n=0;for _,m in ipairs(rows)do if beamHits(f,via.pos,m.pos,m.boundingRadius or 0)then n=n+1 end end;return n end
  for _,m in ipairs(rows)do seen=seen+1;if seen>12 then break end
   if f:Reach(m,qReach(f,m))then local n=hits(m);if n>=need and(not best or n>count)then best,count=m,n end end
  end
  if not best then return false end
  return f:Cast(0,best,context,{range=qReach(f,best),permission=function()return f:Permission(mode,0)and hits(best)>=need end,
   check=function()return Hooks.window(f,nil)end})
 end
 function Hooks.farm(f,u,rows,mode,context,last)
  if last then
   if not f:Permission(mode,0)or not f:Rescue(u,0)or not f:Reach(u,qReach(f,u))then return false end
   return f:Cast(0,u,context,{range=qReach(f,u),permission=function()return f:Permission(mode,0)and f:Rescue(u,0)end})
  end
  if mode=='LaneClear'then return f:Permission(mode,0)and Hooks.laneQ(f,rows,mode,context)or false end
  -- JungleClear: E, Q and W follow observed attacks (Hooks.attack); out of
  -- attack range Q and W still start the camp.
  if f:AttackReach(u)then return false end
  if f:Permission(mode,0)and Hooks.castQ(f,u,context,permission(f,mode,0))then return true end
  return f:Permission(mode,1)and Hooks.castW(f,u,context,permission(f,mode,1))or false
 end
 function Hooks.flee(f,context)
  if not f:Permission('Flee',2)or not f:Ready(2)then return false end
  local p=Hooks.landing(f,nil,false);if not p then return false end
  return f:Cast(2,nil,context,{position=p,range=f.profile.e.range+5,permission=permission(f,'Flee',2),weave=false,check=function()return landingFree(f,p,false)end})
 end
 -- A dash onto Lucian is answered with E away from the dasher.
 local function evadeE(f,u,context,allowed)
  if not f:Ready(2)then return false end
  local p=Hooks.landing(f,nil,false,u);if not p then return false end
  return f:Cast(2,nil,context,{position=p,range=f.profile.e.range+5,permission=allowed,weave=false,check=function()return landingFree(f,p,false)end})
 end
 function Hooks.gapclose(f)return f:Gapclose(evadeE)end
 Hooks.secureSlots={0,1}
 function Hooks.secureCast(f,slot,u,context,lethal)
  if slot==0 then return Hooks.castQ(f,u,context,lethal,true)end
  return Hooks.castW(f,u,context,lethal,true)
 end
 function Hooks.secure(f)return f:KillSecure()end
 -- Health bars and KILL marks: ready Q and W, the attacks they empower (one
 -- attack plus a second shot per ready Q, W and E) and half of a known R.
 function Hooks.comboDamage(f,u)
  local total,spells=0,0
  for slot=0,2 do if f:Ready(slot)then spells=spells+1;if slot<2 then local ok,d=pcall(f.Damage,f,slot,u);if ok and finite(d)then total=total+d end end end end
  local ok,aa=pcall(SDK.Damage.GetAutoAttackDamage,SDK.Damage,H,u,true);if ok and finite(aa)then total=total+aa*(1+spells)end
  if spells>0 then
   local stats=f:Stats();local raw=P.Passive(H.charName,stats,u)
   if finite(raw)and raw>0 then total=total+spells*SDK.Damage:CalculateDamage(H,u,SDK.DAMAGE_TYPE_PHYSICAL,raw)end
  end
  if f:Ready(3)then local d=Hooks.rDamage(f,u);if finite(d)then total=total+d end end
  return total,true
 end
 function Hooks.initialize(f)
  local e=f.profile.e
  -- Relentless Pursuit: 1350 dash to the point, 200-425 long (both installed assets).
  f.mobilityOffered,f.mobilityReason=C:RegisterMobility({kind='dash',slot=2,key=g.HK_E,name=f.profile.names[3][1],range=e.range,speeds={e.speed},castDelays={0},
   toPoint=true,profile=f.profile.id,label='Dodge with E',source='16.21 asset '..f.profile.names[3][1]..' DashSpeed 1350, MinDistance 200, MaxDistance 425',
   allowed=function(p)return p==nil or f.distance(H.pos,p)>=e.minimum-5 and landingFree(f,p,false)end})
 end
 function Hooks.cleanup(f)f.secondShotUntil=nil;f.rDirection=nil;f.rCast=nil;C:ReleaseMovePreference(LOCK_OWNER)end
 return Hooks
end)(_G,Core,CombatMechanics)
-- 26.21 Normal and Classic controller, assembled through the shared core.
local LucianChampion=class("LucianChampion")
function LucianChampion:__init()self.engine=Core:CreateGameplay(self,GameplayHooks);Menu=self.engine.menu end
function LucianChampion:Tick()return self.engine:Tick()end
function LucianChampion:Combo()return self.engine:Combat('Combo')end
function LucianChampion:Harass()return self.engine:Combat('Harass')end
function LucianChampion:LaneClear()return self.engine:Farm('lane','LaneClear',false)end
function LucianChampion:JungleClear()return self.engine:Farm('jungle','JungleClear',false)end
function LucianChampion:LastHit()return self.engine:Farm('lane','LastHit',true)end
function LucianChampion:Flee()return self.engine:Flee()end
function LucianChampion:Draw()return self.engine:Draw()end
function LucianChampion:Ready(slot)return self.engine:Ready(slot)end
function LucianChampion:GetQDmg(u)return self.engine:Damage(0,u)end
function LucianChampion:GetWDmg(u)return self.engine:Damage(1,u)end
function LucianChampion:GetEDmg(u)return 0 end
function LucianChampion:GetRDmg(u)return self.engine:Damage(3,u)end
function LucianChampion:RegisterGuide(guide)return self.engine:RegisterGuide(guide)end
function LucianChampion:FeatureStatus()return {profile=self.profile.id,patch=CombatMechanics.patch,liveVerified=false,
 evadeE={supported=self.engine.mobilityOffered==true,reason=self.engine.mobilityReason,liveVerified=false}}end
local modes={};for _,mode in ipairs({'Combo','Harass','LaneClear','JungleClear','LastHit','Flee'})do local name=mode;modes[name]=function()return Core:ModeContext(name)end end
Core:RegisterPolicy({methods=modes,channel=function()return not Core:SelfChanneling(true)end,validate=function(self,q,slot)return type(slot)~='number'or slot<0 or slot>3 or self:Ready(slot)end})
LucianChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Lucian"]="Lucian"}
local normalSupported={["Lucian"]=true}

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
