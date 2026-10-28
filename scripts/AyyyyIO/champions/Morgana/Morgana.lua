return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Morgana"]=function()return _G.OrbamaFamily:Require("51e323906ca65751defc3353cec0a32510787438c8e332345770428ce31cf58f")()end
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
if champion=="Morgana" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Morgana',profiles={normal=true,classic=true},
 Create=function(context)
local GameplayHooks=(function(g,C,P)
 local H,G,SDK=g.myHero,g.Game,g.SDK
 local id=C.id
 local function permission(f,mode,slot)return function()return f:Permission(mode,slot)end end
 local finite=C.finite
 local function distance(a,b)local dx,dz=a.x-b.x,a.z-b.z;return math.sqrt(dx*dx+dz*dz)end
 -- Where a champion is `h` seconds from now on its native path: dash end point, or walking at its speed.
 local function ahead(u,h)
  local path=u.pathing;local to=path and path.endPos
  if not path or not to or not finite(to.x)or not finite(to.z)then return u.pos end
  if path.isDashing then return to end
  if not path.hasMovePath or not finite(u.ms)or u.ms<=0 then return u.pos end
  local d=distance(u.pos,to);if d<=u.ms*h then return to end
  local k=u.ms*h/d;return {x=u.pos.x+(to.x-u.pos.x)*k,y=u.pos.y,z=u.pos.z+(to.z-u.pos.z)*k}
 end
 local Hooks={}
 -- The abilities each mode really uses (the others get no menu entry).
 Hooks.modeSlots={Combo={'Q','W','R'},Harass={'Q','W','R'},LaneClear={'W'},JungleClear={'Q','W'},LastHit={'Q'},Flee={'Q'}}

 -- Q is the kit: everything else is cast onto what it holds. R has its own
 -- conditions (below), so it is on in Combo. W clears waves; Q rescues a last hit.
 Hooks.defaults={Combo={R=true},Harass={Q=true,W=true,E=false,R=false},LaneClear={Q=false,W=true},JungleClear={Q=true,W=true},LastHit={Q=true},Flee={Q=true}}
 function Hooks.menu(f,m)
  m.Combo:MenuElement({id='RCount',name='R when it catches this many enemies',value=2,min=1,max=5,step=1})
  m.Combo:MenuElement({id='FlashR',name='Flash in to catch enough enemies with R',value=false})
  m.Combo:MenuElement({id='FlashRHP',name='Never Flash in below health %',value=40,min=0,max=100,step=5,menu=false})
  if type(f.profile.r.haste)=='table'then
   m.Combo:MenuElement({id='Tether',name='Walk after shackled enemies so the shackles hold',value=true})
  end
  m.Misc:MenuElement({id='RAuto',name='R automatically at this many enemies',value=3,min=2,max=6,step=1})
  m.Misc:MenuElement({type=g.MENU,id='Allies',name='Allies Black Shield may protect'})
 end
 function Hooks.initialize(f)f.allyTargets={};f.flashR=C:FlashFollow('MorganaFlashR');Hooks.discoverAllies(f)end
 function Hooks.cleanup(f,reason)if f.flashR then f.flashR:Cancel(reason or 'controller_closed')end;f.view=nil;f.killMark=nil;f.tethered=nil
  if f.tetherMoving then C:ReleaseMovePreference('MorganaTether');f.tetherMoving=nil end end
 function Hooks.discoverAllies(f)
  local rows=C:DecisionUnits('GetAllyHeroes')
  local function add(u)
   local identity=id(u);if identity and type(u.charName)=='string'and not f.allyTargets[identity]then
    local key=g.StableUnitMenuKey(f,'Ally',u);f.menu.Misc.Allies:MenuElement({id=key,name='Allow: '..u.charName,value=true});f.allyTargets[identity]=f.menu.Misc.Allies[key]
   end
  end
  for i=1,math.min(#rows,10)do add(rows[i])end;add(H);f.nextAllyDiscovery=G.Timer()+1
 end
 function Hooks.allyAllowed(f,u)local setting=f.allyTargets[id(u)];return setting~=nil and setting:Value()==true end
 -- Ready abilities for the range circles, prepared in Tick (Draw reads no spell state).
 function Hooks.observe(f)
  if G.Timer()>=(f.nextAllyDiscovery or 0)then Hooks.discoverAllies(f)end
  if f.flashR and f.flashR:Busy()then f.flashR:Maintain()end
  Hooks.tether(f)
  if f.menu.Draw.Ranges:Value()then
   local v={ready={},range={},expires=G.Timer()+1}
   for slot=0,3 do v.ready[slot+1]=f:Ready(slot);v.range[slot+1]=slot==0 and f.profile.q.reach or f:Range(slot)end
   f.view=v
  else f.view=nil end
 end
 -- A binding flies for up to a second: beyond two thirds of its reach it only
 -- goes out on a confident prediction (live 2026-10-08: the first binding was
 -- thrown at a strafing target 1250 away and missed).
 function Hooks.castQ(f,u,context,allowed,sure)
  local reach=f.profile.q.reach
  if not f:Ready(0)or not f:Reach(u,reach)then return false end
  if not sure and f.distance(H.pos,u.pos)>reach*.68 then
   local pred=f:Prediction(u,f.profile.q);if not pred or not pred:CanHit(3)then return false end
  end
  return f:Cast(0,u,context,{world=true,range=reach,permission=allowed,after=function()f.bindingAt=G.Timer()end})
 end
 -- The selected target cannot be bound: up to four other allowed enemies in reach, in target order.
 function Hooks.castQAny(f,u,context,allowed)
  if Hooks.castQ(f,u,context,allowed)then return true end
  if not f:Ready(0)then return false end
  local tried=0
  for _,other in ipairs(f:Rows('hero',f.profile.q.reach))do if other~=u and f:Allowed(other)then
   tried=tried+1;if tried>4 then break end
   if Hooks.castQ(f,other,context,allowed)then return true end
  end end
  return false
 end
 -- A dash or blink that ends inside Q reach: the binding meets the landing when it arrives before the enemy can
 -- act again (dash end + 0.25 s). `near` limits it to landings within 400 of Morgana or an allowed ally (peel).
 function Hooks.dashLanding(f,u,near)
  local snap=f:Current(u)and C:DashLanding(u);if not snap then return nil end
  local q=f.profile.q;local d=distance(H.pos,snap.to)
  if d>q.reach or q.delay+d/q.speed>snap.duration+.25 then return nil end
  if near then local close=false
   for _,ally in ipairs(f:Rows('hero',d+400,'self'))do if(ally==H or Hooks.allyAllowed(f,ally))and distance(ally.pos,snap.to)<=400 then close=true;break end end
   if not close then return nil end
  end
  return snap
 end
 function Hooks.dashQ(f,context,allowed,near)
  if not f:Ready(0)then return false end
  for _,u in ipairs(f:Rows('hero',f.profile.q.reach+600))do
   local snap=f:Allowed(u)and Hooks.dashLanding(f,u,near)
   if snap then local to=snap.to
    local function still()local s=Hooks.dashLanding(f,u,near);return s~=nil and distance(s.to,to)<=60 end
    if Hooks.castQ(f,u,context,function()return(not allowed or allowed())and still()end,true)then return true end
   end
  end
  return false
 end
 -- Enemies that cannot leave the soil in time: rooted by the binding, otherwise
 -- controlled, in stasis, reviving or arriving by teleport.
 function Hooks.held(f,range,arm)
  return f:ZoneTargets({range=range or f:Range(1)+f.profile.w.radius-80,arm=arm or f.profile.w.delay,lifetime=f.profile.w.duration})
 end
 -- The soil is a circle: an enemy just beyond the cast range is still covered
 -- by one placed at full range toward it (live 2026-10-08: a rooted enemy 1000
 -- away got no soil until the root had ended).
 function Hooks.soilPoint(f,position)
  local range=f:Range(1);local d=f.distance(H.pos,position)
  if d<=range then return position end
  return f.point({x=H.pos.x+(position.x-H.pos.x)/d*range,y=position.y,z=H.pos.z+(position.z-H.pos.z)/d*range})
 end
 function Hooks.isHeld(f,u)
  for _,row in ipairs(Hooks.held(f))do if row.unit and id(row.unit)==id(u)and(row.kind=='control'or row.kind=='stasis'or row.kind=='channel')then return true end end
  return false
 end
 function Hooks.soil(f,context,allowed)
  if not f:Ready(1)then return false end
  for _,row in ipairs(Hooks.held(f))do
   local aim=row.position and Hooks.soilPoint(f,row.position)
   if aim and f:Cast(1,nil,context,{position=aim,permission=allowed,check=function()return row.valid()end})then return true end
  end
  return false
 end
 -- On a target that can still walk the soil only pays while the binding is
 -- unavailable; and never in the moment a binding is in flight, or W would be
 -- on cooldown when the root lands.
 -- Harass pokes with it only when the target's path keeps it inside the soil for a second after it lands.
 function Hooks.castW(f,u,context,allowed,stay)
  local function free()return not f:Ready(0)and G.Timer()-(f.bindingAt or -10)>1.6 end
  if not free()then return false end
  local w=f.profile.w
  local function stays(r)local aim=r and r.position;return not stay or aim~=nil and distance(ahead(u,w.delay+1),aim)<=w.radius end
  return f:Cast(1,u,context,{world=true,permission=allowed,check=function(q,r)return free()and stays(r)end})
 end
 -- The shackles need the enemy to stay close for three seconds. Worth it on
 -- enough enemies at once, on one that is already held, or when both hits kill.
 -- Enemies the shackles catch and hold: inside the cast radius at the cast's end (their path 0.35 s ahead), and
 -- not walking out of the 625 tether within its 3 s at their slowed speed while Morgana follows (Normal R haste).
 function Hooks.rCount(f,origin)
  origin=origin or H.pos;local r=f.profile.r;local rank=H:GetSpellData(3).level
  local haste=type(r.haste)=='table'and r.haste[rank]or 0
  local chase=(finite(H.ms)and H.ms or 0)*(1+haste);local n=0
  for _,u in ipairs(f:Rows('hero',r.range+800))do
   local at=ahead(u,r.delay);local d=distance(origin,at)
   if d<=r.cast then
    local path=u.pathing;local away=0
    if path and path.hasMovePath and not path.isDashing and path.endPos and finite(u.ms)and u.ms>0 and distance(path.endPos,origin)>d then
     local speed=u.ms*(1-(r.slow or 0));away=math.max(0,speed-chase)*math.min(r.tether,distance(at,path.endPos)/speed)
    end
    if d+away<=r.range then n=n+1 end
   end
  end
  return n
 end
 -- Normal (R haste): after an observed own R, while Combo is held, walk toward the shackled enemy closest to
 -- breaking the 625 tether (beyond 475) instead of the cursor, for the 3 s tether. Enemies are those inside the
 -- cast radius when the cast lands; a dead, replaced or already escaped (beyond 625) enemy is not followed.
 function Hooks.tether(f)
  local r=f.profile.r;if type(r.haste)~='table'or not f.menu.Combo.Tether then return end
  local now=G.Timer();local a=H.activeSpell
  if a and a.valid and a.name==f.profile.names[4][1]and finite(a.startTime)and a.startTime~=f.rCastStart then
   f.rCastStart=a.startTime;f.tethered={start=a.startTime,lands=a.startTime+r.delay,expires=a.startTime+r.delay+r.tether,rows={}}
  end
  local t=f.tethered
  if t and now>t.expires then f.tethered=nil;t=nil end
  if t and now<=t.lands then t.rows={}
   for _,u in ipairs(f:Rows('hero',r.cast+100))do if distance(H.pos,u.pos)<=r.cast then t.rows[#t.rows+1]={unit=u,id=id(u),handle=u.handle}end end
  end
  local aim
  if t and now>t.lands and f:Mode()=='Combo'and f.menu.Combo.Tether:Value()then
   local farD
   for _,row in ipairs(t.rows)do local u=row.unit
    if g.IsValid(u)and id(u)==row.id and u.handle==row.handle then local d=distance(H.pos,u.pos)
     if d>r.range-150 and d<=r.range and(not farD or d>farD)then aim,farD=u.pos,d end
    end
   end
  end
  if aim then f.tetherMoving=C:PreferMove('MorganaTether',aim,.25)==true or f.tetherMoving
  elseif f.tetherMoving then C:ReleaseMovePreference('MorganaTether');f.tetherMoving=nil end
 end
 function Hooks.castR(f,u,context,allowed)
  if not f:Ready(3)then return false end
  local function worth()
   if #f:AreaRows(H.pos,f.profile.r.cast)==0 then return false end
   if Hooks.rCount(f)>=f.menu.Combo.RCount:Value()then return true end
   if not u or not f:Reach(u,f.profile.r.cast)then return false end
   return Hooks.isHeld(f,u)or f:Reach(u,f.profile.r.cast-125)and f:Damage(3,u)*2>=u.health+(u.shieldAP or 0)
  end
  if not worth()then return false end
  return f:Cast(3,nil,context,{selfCast=true,permission=allowed,check=worth})
 end
 -- Flash, then R once the Flash is seen: enough enemies predicted inside the cast radius of the landing and not
 -- of Morgana now; the landing has no wall or turret and Morgana is above the health floor (off by default).
 function Hooks.flashR(f)
  if not f.menu.Combo.FlashR:Value()or not f.flashR or f.flashR:Busy()or not f:Permission('Combo',3)or not f:Ready(3)then return false end
  local need=f.menu.Combo.RCount:Value();if Hooks.rCount(f)>=need then return false end
  local status=C:FlashStatus();if not status then return false end
  local sx,sz,n=0,0,0
  for _,u in ipairs(f:Rows('hero',f.profile.r.cast+status.range))do if f:Allowed(u)then local at=ahead(u,f.profile.r.delay);sx,sz,n=sx+at.x,sz+at.z,n+1 end end
  if n<need then return false end
  local center={x=sx/n,y=H.pos.y,z=sz/n};local d=distance(H.pos,center);if d<1 then return false end
  local k=math.min(status.range,d)/d;local aim=f.point({x=H.pos.x+(center.x-H.pos.x)*k,y=H.pos.y,z=H.pos.z+(center.z-H.pos.z)*k})
  local function authorized()return f.menu.Combo.FlashR:Value()and f:Mode()=='Combo'and f:Permission('Combo',3)end
  local function valid(pos)return f:Ready(3)and f:Safe(pos,false)and H.maxHealth>0 and H.health/H.maxHealth*100>=f.menu.Combo.FlashRHP:Value()
   and Hooks.rCount(f,pos)>=f.menu.Combo.RCount:Value()end
  return f.flashR:Start{order='flash_first',aim=aim,authorized=authorized,valid=valid,mana=H:GetSpellData(3).mana,
   follow=function(context)return f:Cast(3,nil,context,{selfCast=true,permission=function()return f.flashR:Busy()and authorized()end,
    check=function()return Hooks.rCount(f)>=f.menu.Combo.RCount:Value()end})end}
 end
 function Hooks.combat(f,u,mode,context)
  if f.flashR and f.flashR:Busy()then return true end
  if f:Permission(mode,1)and Hooks.soil(f,context,permission(f,mode,1))then return true end
  if f:Permission(mode,0)and Hooks.castQAny(f,u,context,permission(f,mode,0))then return true end
  -- Any dash or blink ending inside reach while fighting.
  if f:Permission(mode,0)and Hooks.dashQ(f,context,permission(f,mode,0),false)then return true end
  if f:Permission(mode,3)and Hooks.castR(f,u,context,permission(f,mode,3))then return true end
  if mode=='Combo'and Hooks.flashR(f)then return true end
  return(mode=='Combo'or mode=='Harass')and f:Permission(mode,1)and Hooks.castW(f,u,context,permission(f,mode,1),mode=='Harass')or false
 end
 -- Black Shield absorbs magic damage and blocks crowd control while it holds,
 -- for five seconds, on a long cooldown: it goes to whoever is about to be hit
 -- by the worst spell. Evidence is a champion's targeted cast winding up on the
 -- ally, or a tracked enemy spell the ally stands in (Evade's threat record
 -- says whether it controls and how severe it is). Basic attacks and turret
 -- shots are physical and never count.
 --   3    the spell applies crowd control (or its control is unknown)
 --   2    a targeted champion spell, or a severe spell (tier 4-5)
 --   1    a medium spell (tier 3 or unrated)
 --   0.4  cheap poke: only worth the cooldown on an ally below a third health
 -- Morgana's own skillshots are left to Evade, which knows whether walking out
 -- works and shields her itself when it does not; a targeted spell cannot be
 -- walked out of, so that one is answered here.
 function Hooks.severity(f,u,threat)
  if threat.cc==true and(threat.kind=='attack'or threat.kind=='dash')then return 3 end
  -- A targeted spell already flying at the ally cannot be walked out of: treated like a targeted cast.
  if threat.cc==true and threat.kind=='missile'then return 3 end
  if threat.kind=='cast'or threat.kind=='missile'then return 2 end
  if threat.kind~='skillshot'then return 0 end
  local evade=SDK.Evade;local row
  if evade and type(evade.GetThreatState)=='function'and threat.id~=nil then
   local ok,value=pcall(evade.GetThreatState,evade,threat.id);row=ok and type(value)=='table'and value or nil
  end
  if not row then return 1 end
  if row.ccHard==true or C.finite(row.cc)and row.cc>0 or row.ccUnknown==true then return 3 end
  local tier=row.tier
  if not C.finite(tier)then return 1 end
  return tier>=4 and 2 or tier>=3 and 1 or .4
 end
 -- An enemy dashing to land within 200 of `u` whose dash applies crowd control on arrival (profile catalogue
 -- of native cast names). A threat row like C:AllyThreat's.
 function Hooks.ccDash(f,u)
  local list=f.profile.ccDashes;if not list then return nil end
  for _,e in ipairs(f:Rows('hero',1500))do
   local a=e.activeSpell;local name=a and a.valid and type(a.name)=='string'and a.name:lower()
   if name and list[name]then
    local snap=C:DashLanding(e,u.pos,200,true)
    if snap then local start=a.startTime
     return {kind='dash',source=e,name=a.name,cc=true,impactIn=snap.duration,valid=function()
      local b=e.activeSpell;return b and b.valid and b.startTime==start and C:DashLanding(e,u.pos,200,true)~=nil end}
    end
   end
  end
 end
 -- A basic attack counts only when it carries crowd control (shared catalogue, C.CCAttackNames): Black Shield
 -- blocks the control even though the hit is physical.
 function Hooks.ccAttack(u)
  local t=C:AllyThreat(u,1.2,{casts=false,turrets=false,skillshots=false})
  return t and t.kind=='attack'and t.cc==true and t or nil
 end
 function Hooks.shieldTarget(f)
  if not f:Ready(2)then return end
  local best
  for _,u in ipairs(f:Rows('hero',f:Range(2),'self'))do
   local self=id(u)==id(H)
   if Hooks.allyAllowed(f,u)and C:SpellProtected(u,true)==false then
    local threat=C:AllyThreat(u,1.2,{attacks=false,turrets=false,skillshots=not self})
    local other=Hooks.ccDash(f,u)or Hooks.ccAttack(u)
    if other and(not threat or other.impactIn<threat.impactIn or Hooks.severity(f,u,threat)<3)then threat=other end
    if threat and threat.impactIn>=.08 then
     local severity=Hooks.severity(f,u,threat)
     local health=C.finite(u.health)and C.finite(u.maxHealth)and u.maxHealth>0 and u.health/u.maxHealth or 1
     if severity>=1 or health<.34 then
      -- Worst spell first, then the ally with the least health, then the soonest hit.
      local score=severity*10+(1-health)*3-threat.impactIn
      if not best or score>best.score then best={unit=u,threat=threat,score=score,severity=severity}end
     end
    end
   end
  end
  return best
 end
 function Hooks.background(f)
  local function on()return f.menu.Misc.Independent:Value()end
  if not on()then return false end
  local background={priority='interactive',condition=on}
  -- A soil under an enemy who cannot move is free damage in every mode.
  if Hooks.soil(f,background,on)then return true end
  if f:Ready(0)then
   -- A binding on an enemy who cannot dodge it extends the lockdown, and it
   -- stops a channel that outlasts its flight.
   for _,row in ipairs(Hooks.held(f,f.profile.q.reach,.45))do
    if row.unit and row.kind~='arrival'and row.kind~='revive'and f:Allowed(row.unit)
     and Hooks.castQ(f,row.unit,background,function()return on()and row.valid()end,true)then return true end
   end
   for _,u in ipairs(f:Rows('hero',f.profile.q.reach))do
    if f:Allowed(u)and C:CanInterrupt(u,f:Impact(0,u))
     and Hooks.castQ(f,u,background,function()return on()and C:CanInterrupt(u,f:Impact(0,u))end,true)then return true end
   end
   -- A dash or blink landing next to Morgana or an ally she protects: bind it on arrival.
   if Hooks.dashQ(f,background,on,true)then return true end
  end
  if f:Ready(3)and #f:AreaRows(H.pos,f.profile.r.cast)>0 and Hooks.rCount(f)>=f.menu.Misc.RAuto:Value()
   and f:Cast(3,nil,background,{selfCast=true,permission=on,check=function()return Hooks.rCount(f)>=f.menu.Misc.RAuto:Value()end})then return true end
  local row=Hooks.shieldTarget(f);if not row then return false end
  local u=row.unit
  if f:Cast(2,u,{priority='critical',condition=on},{ally=true,permission=on,
   check=function()return row.threat.valid()and C:SpellProtected(u,true)==false end})then
   C:Trace('morgana_shield',{ally=u.charName,kind=row.threat.kind,spell=row.threat.name,severity=row.severity,impactIn=row.threat.impactIn,
    health=u.health,source=row.threat.source and row.threat.source.charName or nil});return true
  end
  return false
 end
 function Hooks.farm(f,u,rows,mode,context,last)
  if last then
   if not f:Permission(mode,0)or not f:Rescue(u,0)then return false end
   return f:Cast(0,u,context,{world=true,permission=function()return f:Permission(mode,0)and f:Rescue(u,0)end})
  end
  if f:Permission(mode,1)and f:Ready(1)then
   local kind=mode=='JungleClear'and 'jungle'or 'lane';local best,count
   for i=1,math.min(#rows,8)do local v=rows[i]
    if f:Reach(v,f:Range(1))then local n=#f:AreaRows(v.pos,f.profile.w.radius,kind);if not count or n>count then best,count=v,n end end
   end
   if best and(mode=='JungleClear'or count>=f.menu.LaneClear.Count:Value())
    and f:Cast(1,best,context,{position=best.pos,permission=permission(f,mode,1)})then return true end
  end
  return mode=='JungleClear'and f:Permission(mode,0)and f:Cast(0,u,context,{world=true,permission=permission(f,mode,0)})or false
 end
 -- The pursuer that reaches Morgana first (distance over closing speed, 0.25 s along its path), within Q reach.
 function Hooks.pursuer(f)
  local best,score
  for _,u in ipairs(f:Rows('hero',f.profile.q.reach))do if f:Allowed(u)then
   local d=distance(H.pos,u.pos);local closing=(d-distance(H.pos,ahead(u,.25)))/.25
   local s=closing>1 and d/closing or 100+d
   if not best or s<score then best,score=u,s end
  end end
  return best
 end
 function Hooks.flee(f,context)
  if not f:Permission('Flee',0)then return false end
  local u=Hooks.pursuer(f);return u and Hooks.castQ(f,u,context,permission(f,'Flee',0))or false
 end
 Hooks.options={'Independent'}
 Hooks.assistLabels={[0]='Cast Q at the selected target'}
 function Hooks.assist(f,slot,u,context)return slot==0 and Hooks.castQ(f,u,context)or false end
 function Hooks.gapclose(f)return f:Gapclose(Hooks.castQ,0)end

 -- Finishers without a mode key: Q first; one shackle hit (enemy within the 575 cast requirement) when Q cannot.
 Hooks.secureSlots={0,3}
 function Hooks.secureCast(f,slot,u,context,lethal)
  if slot==3 then
   if not f:Reach(u,f.profile.r.cast)then return false end
   local ok=f:Cast(3,nil,context,{selfCast=true,permission=function()return lethal()and f:Reach(u,f.profile.r.cast)end})
   if ok then f.killMark={unit=u,at=G.Timer()}end;return ok
  end
  local ok=Hooks.castQ(f,u,context,lethal);if ok then f.killMark={unit=u,at=G.Timer()}end;return ok
 end
 -- Seconds `u` is expected to stand in a soil placed on it: held until its control ends, otherwise the time
 -- to walk out of the radius; counted in whole ticks (at least the first).
 function Hooks.soilSeconds(f,u)
  local w=f.profile.w;local tick=w.tick or .5;local seconds
  for _,row in ipairs(Hooks.held(f))do if row.unit and id(row.unit)==id(u)and row.kind~='arrival'and row.kind~='revive'then
   seconds=math.min(w.duration,row.freeAt-G.Timer()-w.delay)
  end end
  if not seconds then seconds=finite(u.ms)and u.ms>0 and w.radius/u.ms or w.duration end
  return math.max(tick,math.floor(math.min(w.duration,seconds)/tick)*tick)
 end
 function Hooks.soilFinisher(f)
  if not f:Ready(1)then return false end
  local function allowed()return f.menu.Misc.KillSecure:Value()and(not finite(H.maxMana)or H.maxMana<=0 or H.mana/H.maxMana*100>=f.menu.Misc.KSMana:Value())end
  if not allowed()then return false end
  for _,u in ipairs(f:Rows('hero',f:Range(1)+f.profile.w.radius))do if f:Allowed(u)then
   local function lethal()
    if not allowed()or not f:Ready(1)or not f:Current(u)or C:SpellProtected(u)~=false then return false end
    local seconds=Hooks.soilSeconds(f,u)
    local estimate=C:HealthEstimate(u,f.profile.w.delay+seconds,'magical',f:Damage(1,u,{seconds=seconds}))
    return estimate and estimate.lethal or false
   end
   if lethal()and f:Cast(1,u,{priority='interactive',condition=allowed},{world=true,permission=lethal})then f.killMark={unit=u,at=G.Timer()};return true end
  end end
  return false
 end
 function Hooks.secure(f)return f:KillSecure()or Hooks.soilFinisher(f)end
 return Hooks
end)(_G,Core,CombatMechanics)
-- Independent Normal/Classic controller, assembled through the shared core.
local MorganaChampion=class("MorganaChampion")
function MorganaChampion:__init()self.engine=Core:CreateGameplay(self,GameplayHooks);Menu=self.engine.menu end
function MorganaChampion:Tick()return self.engine:Tick()end
function MorganaChampion:Combo()return self.engine:Combat('Combo')end
function MorganaChampion:Harass()return self.engine:Combat('Harass')end
function MorganaChampion:LaneClear()return self.engine:Farm('lane','LaneClear',false)end
function MorganaChampion:JungleClear()return self.engine:Farm('jungle','JungleClear',false)end
function MorganaChampion:LastHit()return self.engine:Farm('lane','LastHit',true)end
function MorganaChampion:Flee()return self.engine:Flee()end
-- Ready-only range circles (Q at its usable reach) from the Tick-prepared view (kept for a second so a skipped
-- tick cannot blink them) and a mark on the enemy a finisher is being cast at. No state text: the game shows E.
function MorganaChampion:Draw()
 local f=self.engine;if myHero.dead then return end
 local v=f.view
 if f.menu.Draw.Ranges:Value()and v and v.expires>Game.Timer()then
  for slot=1,4 do if v.ready[slot]and v.range[slot]>0 then Draw.Circle(myHero.pos,v.range[slot],1,Draw.Color(255,120,180,255))end end
 end
 local k=f.killMark
 if k and Game.Timer()-k.at<=.5 and k.unit and k.unit.pos then Draw.Circle(k.unit.pos,110,2,Draw.Color(255,255,60,60))end
end
function MorganaChampion:Ready(slot)return self.engine:Ready(slot)end
function MorganaChampion:GetQDmg(u)return self.engine:Damage(0,u)end
function MorganaChampion:GetWDmg(u)return self.engine:Damage(1,u)end
function MorganaChampion:GetEDmg(u)return self.engine:Damage(2,u)end
function MorganaChampion:GetRDmg(u)return self.engine:Damage(3,u)end
function MorganaChampion:RegisterGuide(guide)return self.engine:RegisterGuide(guide)end
function MorganaChampion:FeatureStatus()return {profile=self.profile.id,patch=CombatMechanics.patch,liveVerified=false}end
local modes={};for _,mode in ipairs({'Combo','Harass','LaneClear','JungleClear','LastHit','Flee'})do local name=mode;modes[name]=function()return Core:ModeContext(name)end end
Core:RegisterPolicy({methods=modes,channel=function()return not Core:SelfChanneling(true)end,validate=function(self,q,slot)return type(slot)~='number'or slot<0 or slot>3 or self:Ready(slot)end})
MorganaChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Morgana"]="Morgana"}
local normalSupported={["Morgana"]=true}

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
