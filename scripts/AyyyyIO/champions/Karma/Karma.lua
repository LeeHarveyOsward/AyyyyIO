return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Karma"]=function()return _G.OrbamaFamily:Require("7858e73604904898085caf725e7bad9db42d5da192578865d40215cba15e04dd")()end
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
modules["autojungle"]=_G.OrbamaFamily:Require("12c9f19e56e973236e0bcff8c7222940806f07b1c7bf1e88042f1b34eddcc520")
modules["combatMechanics"]=_G.OrbamaFamily:Require("9e32908504b1e01599ffc8a55f7d52a3a92a974d794c085ee29160c628b85e38")
modules["gameplay"]=_G.OrbamaFamily:Require("038c846d2b126f3f80142b2c55b4ace9ee78a9347b22cb2f242dcb5ed5185f2f")
modules["prediction"]=(function(require) return _G.OrbamaFamily:Factory("223a065ecf7929552d5f8dafcf2453fd9147cd6e9940ce97dc80add73aa9913b")(require) end)(require)
modules["policies"]=(function(require) return _G.OrbamaFamily:Factory("e26056d70e5dac93ebb21f4ae4fe96863a06915a942bb75b795567a932448a23")(require) end)(require)
modules["core"]=(function(require) return _G.OrbamaFamily:Factory("454102f4f573681afa019a39b08ec2a6adca91fb526d8515918046a8d866415c")(require) end)(require)
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
if champion=="Karma" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Karma',profiles={normal=true,classic=true},
 Create=function(context)
local GameplayHooks=(function(g,C,P)
 local H,G,SDK=g.myHero,g.Game,g.SDK
 local function position(r,fallback)return r and r.position or fallback end
 local finite,id=C.finite,C.id
 -- Damage-over-time shield trigger (as Lux): hurt below 80 % health, or remaining damage >= 10 % of current health.
 local DOT_HURT,DOT_SHARE,DOT_LEAD=.8,.1,.1
 local function permission(f,mode,slot)return function()return f:Permission(mode,slot)end end
 local function hp(u)return u.health/u.maxHealth end
 local function f_point(p)return p and finite(p.x)and finite(p.z)and g.Vector(p.x,p.y or 0,p.z)end
 local Hooks={}

 function Hooks.menu(f,m)
  f.allyTargets={}
  m.Misc:MenuElement({type=g.MENU,id='Allies',name='Allies your shields and heals may target'})
  m.Misc:MenuElement({id='ReserveShield',name='Empower urgent ally shields with R (Mantra)',value=true,menu=false})
  m.Misc:MenuElement({id='HealHP',name='Heal with R (Mantra) below health %',value=40,min=0,max=100,step=5})
  m.Misc:MenuElement({id='ShieldHP',name='Also shield allies near an enemy below health %',value=60,min=0,max=100,step=5})
  if f.profile.id=='classic'then m.Misc:MenuElement({id='BondAlly',name='Link W to an ally to hit enemies between',value=true,menu=false})end
 end
 function Hooks.mantra(f)return f:Buff(H,f.profile.mantraNames)~=nil end
 function Hooks.shield(f,u)
  local raw=P.Raw(H.charName,2,H:GetSpellData(2).level,f:Stats(),u)
  if f.profile.id=='normal'and Hooks.mantra(f)then local rank=H:GetSpellData(3).level;raw=raw+(f.profile.reBase[rank]or 0)+f.profile.reAP*H.ap end
  return raw
 end
 function Hooks.discoverAllies(f)
  local rows=C:DecisionUnits('GetAllyHeroes')
  local function add(u)
   local identity=id(u);if identity and type(u.charName)=='string'and not f.allyTargets[identity]then
    local key=g.StableUnitMenuKey(f,'Ally',u);f.menu.Misc.Allies:MenuElement({id=key,name='Allow: '..u.charName,value=true});f.allyTargets[identity]=f.menu.Misc.Allies[key]
   end
  end
  for i=1,math.min(#rows,10)do add(rows[i])end;add(H);f.nextAllyDiscovery=G.Timer()+1
 end
 function Hooks.allyAllowed(f,u)local setting=f.allyTargets[id(u)];return setting and setting:Value()==true end
 function Hooks.observe(f)if G.Timer()>=(f.nextAllyDiscovery or 0)then Hooks.discoverAllies(f)end end
 function Hooks.allies(f)
  local rows=f:Rows('hero',f:Range(2),true);local found=false
  for _,u in ipairs(rows)do if id(u)==id(H)then found=true end end
  if not found then rows[#rows+1]=H end
  for i=#rows,1,-1 do if not Hooks.allyAllowed(f,rows[i])then table.remove(rows,i)end end;return rows
 end
  function Hooks.threat(f,u)
   local observed=C:IncomingAttack(u,0,1)
   local earliest=observed and observed.delay
   local damage=observed and SDK.Damage:GetAutoAttackDamage(observed.caster,u,true)
   -- An enemy champion's targeted ability winding up on the ally (instant or not) is a trigger at any health, as an
   -- observed attack and a targeted missile already in flight are (re-rank ally_support, 2026-10-10): the same
   -- evidence class, and an instant cast (Darius R, Vladimir Q...) leaves no later moment to shield. Its damage
   -- stays unknown (nil): no catalogue number is invented. A crowd-control attack (C.CCAttackNames) also counts.
   local control=C:AllyThreat(u,1,{turrets=false,skillshots=false})
   if control and(control.kind=='cast'or control.cc)and(not earliest or control.impactIn<earliest)then earliest=control.impactIn;damage=nil end
   -- A turret shot and a tracked enemy spell the ally stands in are known
   -- damage whatever the ally's health (shared trigger; the spell evidence
   -- is Evade's threat model asked about the ally's position).
   -- Damage over time (Karma-5, re-rank 2026-10-10, as Lux): an enemy poison, Ignite or burn on the ally is reported
   -- only when nothing else is. It is a trigger when the ally is already hurt or its known remaining damage is a
   -- meaningful share of the ally's health; an unknown amount (nil) on a healthy ally is not. The damage is ticking
   -- now, so it competes as a threat at DOT_LEAD, the earliest moment the shield timing gates accept.
   local other=C:AllyThreat(u,1,{attacks=false,casts=false,dots=true})
   if other and other.kind=='dot'then
    local worth=u.health<=u.maxHealth*DOT_HURT or finite(other.damage)and other.damage>=u.health*DOT_SHARE
    if worth and(not earliest or DOT_LEAD<earliest)then earliest=DOT_LEAD;damage=other.damage end
   elseif other and(not earliest or other.impactIn<earliest)then earliest=other.impactIn;damage=nil end
   return earliest,damage
 end
 function Hooks.defendTarget(f)
  local chosen,score
  for _,u in ipairs(Hooks.allies(f))do local timing,amount=Hooks.threat(f,u)
   if timing and timing>=.1 then local value=(amount and amount/u.health or 1-hp(u))+1/(.1+timing)
    if not score or value>score then chosen=u;score=value end
   end
  end;return chosen
 end
 function Hooks.castE(f,u,context,allowed,offense)
  if not Hooks.allyAllowed(f,u)or not f:Reach(u,f:Range(2),true)then return false end
  return f:Cast(2,u,context,{ally=true,permission=allowed,check=function()
   if not Hooks.allyAllowed(f,u)then return false end
   if offense=='flee'then return true end
   if offense then return f.profile.id=='classic'and Hooks.mantra(f)and #f:AreaRows(u.pos,f.profile.e.area)>0 end
   local t=Hooks.threat(f,u);return t and t>=.05 and t<=1 or hp(u)*100<f.menu.Misc.ShieldHP:Value()and g.GetEnemyCount(600,u.pos)>0
  end})
 end
 function Hooks.reserve(f,slot,u,context,allowed,offense)
  if Hooks.mantra(f)or context and context.mode and not f:Permission(context.mode,3)then return false end
  if not f:Ready(3)or not f:Ready(slot)or f.sequences.mantra or u.team==H.team and not Hooks.allyAllowed(f,u)then return false end
  if f.profile.id=='classic'then local spell=H:GetSpellData(3);if not finite(spell.ammo)or spell.ammo<=0 then return false end end
  if slot==0 and u.team~=H.team and not Hooks.mantraQReach(f,u)then return false end
  local grant=C.adapter:Reserve('KarmaMantra',{'slot:3','slot:'..slot},{expires=C.adapter:Now()+1500,context=context})
  if not grant then return false end
  local seq={target=u,identity=id(u),handle=u.handle,context=context,slot=slot,expires=G.Timer()+1.5,permission=allowed,ally=u.team==H.team,reservation=grant,offense=offense}
  local accepted,q=f:Cast(3,nil,context,{selfCast=true,reservation=grant,permission=allowed,check=function()return(not seq.ally or Hooks.allyAllowed(f,u))and f:Ready(slot)and f:Reach(u,f:Range(slot),seq.ally)end,
   after=function()if f.sequences.mantra==seq then seq.observed=true end end})
  if accepted then seq.action=q.id;seq.intent=q;f.sequences.mantra=seq else C.adapter:ReleaseReservation(grant,'mantra_rejected')end;return accepted
 end
 function Hooks.continue(f,key,s)
  if key~='mantra'or not Hooks.mantra(f)then return end
  -- Mantra was absent when R was reserved, so the buff after the send is the
  -- cast itself. R has no cast time and may show neither a native cast nor a
  -- cooldown before its empowered ability; waiting for that observation held
  -- Q, W and the reservation for the sequence's 1.5 s with Mantra already up.
  if not s.observed then local receipt=C.adapter:Poll(s.action);if not receipt or not receipt.sentAt then return end end
  local accepted
  if s.slot==0 then accepted=Hooks.castQ(f,s.target,s.context,s.permission,true)
  elseif s.slot==1 then accepted=Hooks.castW(f,s.target,s.context,s.permission,true)
  else accepted=Hooks.castE(f,s.target,s.context,s.permission,s.offense or false)end
  if accepted then local key=g['HK_'..({'Q','W','E'})[s.slot+1]]
   local intent=C.lastIntent
   local basic={action=intent.id,intent=intent,target=s.target,identity=s.identity,handle=s.handle,ally=s.ally,
    context=s.context,reservation=s.reservation,expires=math.min(s.expires,G.Timer()+.3)}
   f.sequences.mantra=nil;f.sequences.mantra_basic=basic
   C:AfterCast(key,function()
    if f.sequences.mantra_basic==basic then C.adapter:ReleaseReservation(basic.reservation,'mantra_basic_observed');f.sequences.mantra_basic=nil end
   end)
  end
 end
 -- Mantra Q (Normal): a wider missile (half-width 80) whose Soulflare explodes at the end of its 950 range in a 280
 -- radius, so a target the missile cannot reach directly can still be caught by the end blast. The blast point is
 -- the end of the ray toward the target's position at impact; it counts only when no minion stops the missile first
 -- and that position (a walking target is taken along its path) lies inside the blast with a reaction margin.
 local function along(u,t)
  local path=u.pathing;local p=f_point(u.pos)
  if p and path and path.hasMovePath and path.endPos and finite(u.ms)and u.ms>0 then
   local dx,dz=path.endPos.x-p.x,path.endPos.z-p.z;local l=math.sqrt(dx*dx+dz*dz)
   if l>1 then local step=math.min(l,u.ms*t);return g.Vector(p.x+dx/l*step,p.y or 0,p.z+dz/l*step),true end
  end
  return p,false
 end
 function Hooks.mantraSpec(f)local q=f.profile.q;return q.mantra and {range=q.mantra.range,radius=q.mantra.radius,delay=q.delay,speed=q.speed,collision=true}end
 function Hooks.blastAim(f,u)
  local m=f.profile.q.mantra;if not m or not f:Current(u)then return nil end
  local impact=f.profile.q.delay+m.range/f.profile.q.speed
  local at,moving=along(u,impact);if not at then return nil end
  local d=f.distance(H.pos,at);if d<1 or d>m.range+m.endBlast then return nil end
  local finish=g.Vector(H.pos.x+(at.x-H.pos.x)/d*m.range,H.pos.y,H.pos.z+(at.z-H.pos.z)/d*m.range)
  local margin=moving and(u.ms or 0)*.15 or 0
  if f.distance(finish,at)>m.endBlast-margin-(u.boundingRadius or 0)*.5 then return nil end
  local O=g.OrbamaPrediction
  local wall,_,count=O:GetCollision(H.pos,finish,f.profile.q.speed,f.profile.q.delay,m.radius,{O.COLLISION_MINION,O.COLLISION_YASUOWALL},id(u))
  if wall or type(count)~='number'or count>0 then return nil end
  return finish
 end
 -- Whether a Mantra Q (direct or end blast) can reach `u` now: reserve() spends R only for a reachable Q.
 function Hooks.mantraQReach(f,u)
  local spec=Hooks.mantraSpec(f);if not spec then return true end
  return f:Prediction(u,spec)~=nil or Hooks.blastAim(f,u)~=nil
 end
 -- Hold a plain Q for a moment when R comes back first (Normal): R ready within min(1.5 s, half Q's cooldown), nobody
 -- to defend, no group fight and the target still in reach then. Bounded by R's remaining time; nothing is held.
 function Hooks.holdQ(f,u,mode,ally)
  if f.profile.id~='normal'or ally or Hooks.mantra(f)or not f:Permission(mode,3)or Hooks.groupFight(f)then return false end
  local r,q=H:GetSpellData(3),H:GetSpellData(0)
  if not r or(r.level or 0)<1 or not finite(r.currentCd)or r.currentCd<=0 then return false end
  local qcd=finite(q.cd)and q.cd>0 and q.cd or 7
  if r.currentCd>math.min(1.5,qcd/2)then return false end
  return f.distance(H.pos,u.pos)<=f:Range(0)-(u.ms or 0)*r.currentCd
 end
 function Hooks.castQ(f,u,context,allowed,reserved)
  if f.sequences.mantra and not reserved then return false end
  if f.profile.id=='normal'and(reserved or Hooks.mantra(f))then
   local spec=Hooks.mantraSpec(f);local function up()return reserved and f.sequences.mantra_basic~=nil or Hooks.mantra(f)end
   if f:Prediction(u,spec)then return f:Cast(0,u,context,{world=true,spec=spec,permission=allowed,check=function()return up()end})end
   local aim=Hooks.blastAim(f,u)
   if aim then
    local m=f.profile.q.mantra
    return f:Cast(0,u,context,{position=aim,range=m.range+m.endBlast,permission=allowed,
     resolve=function()local fresh=Hooks.blastAim(f,u);return fresh and {position=fresh}or nil end,
     check=function()return up()and Hooks.blastAim(f,u)~=nil end})
   end
   return false
  end
  if f.profile.id=='classic'then
   local ally=u.team==H.team
   if ally and(not Hooks.mantra(f)or not Hooks.allyAllowed(f,u))then return false end
   if ally then return f:Cast(0,u,context,{position=f.point(u.pos),ally=true,range=650,permission=allowed,resolve=function()return {position=f.point(u.pos)}end,check=function()return Hooks.mantra(f)and Hooks.allyAllowed(f,u)and hp(u)*100<f.menu.Misc.HealHP:Value()end})end
   return f:Cast(0,u,context,{world=true,permission=allowed,spec={range=650,radius=100,cone=33,delay=.25,speed=math.huge},
    check=function(_,r)return f.distance(H.pos,position(r,u.pos))<=650 end})
  end
  -- Direct first-hit prediction. Splash is chosen only around a fresh first blocker.
  local pred,reason=f:Prediction(u,f.profile.q)
  if pred then return f:Cast(0,u,context,{world=true,permission=allowed})end
  if reason=='equivalent_intent_waiting'then return false end
  local chosen
  for _,v in ipairs(f:Rows('lane',950))do if f.distance(v.pos,u.pos)<f.profile.q.splash-50 then
   local p=f:Prediction(v,f.profile.q);if p then chosen=v;break end
  end end
  if not chosen then return false end
  return f:Cast(0,chosen,context,{world=true,permission=allowed,check=function(_,r)
   return f:Current(u)and f.distance(position(r,chosen.pos),u.pos)<=f.profile.q.splash-(u.ms or 0)*.15
  end})
 end
 function Hooks.bondHits(f,u)
  local count=0;for _,enemy in ipairs(f:Rows('hero',1300))do
   if id(enemy)~=id(u)and f:Line(H.pos,u.pos,enemy.pos,70+(enemy.boundingRadius or 0))then count=count+1 end
  end;return count
 end
 function Hooks.castW(f,u,context,allowed,reserved)
  if f.sequences.mantra and not reserved then return false end
  if f.profile.id=='normal'then
   local buff=f:Buff(u,f.profile.tetherNames,true);if buff then return false end
   return f:Cast(1,u,context,{permission=allowed,check=function()return f:Reach(u,675)and not f:Buff(u,f.profile.tetherNames,true)end,
    after=function(q)f.sequences.tether={action=q.id,intent=q,target=u,identity=id(u),handle=u.handle,context=context,expires=G.Timer()+2.5,observed=true,start=G.Timer()}end})
  end
  local ally=u.team==H.team
  if ally and(not Hooks.allyAllowed(f,u)or Hooks.bondHits(f,u)<1)then return false end
  return f:Cast(1,u,context,{ally=ally,permission=allowed,check=function()return ally and Hooks.allyAllowed(f,u)and f.menu.Misc.BondAlly:Value()and Hooks.bondHits(f,u)>0 or not ally and f:Reach(u,800)end})
 end
 function Hooks.combat(f,u,mode,context)
  if f.profile.id=='classic'and f:Permission(mode,0)then
   local healTarget
   for _,v in ipairs(Hooks.allies(f))do if f:Reach(v,650,true)and v~=H and hp(v)*100<f.menu.Misc.HealHP:Value()and(not healTarget or hp(v)<hp(healTarget))then healTarget=v end end
   if healTarget then
    if Hooks.mantra(f)and Hooks.castQ(f,healTarget,context,permission(f,mode,0),false)then return true end
    if Hooks.reserve(f,0,healTarget,context,permission(f,mode,0))then return true end
   elseif hp(H)*100<f.menu.Misc.HealHP:Value()and f:Reach(u,650)and Hooks.reserve(f,0,u,context,permission(f,mode,0))then return true end
  end
  local ally=Hooks.defendTarget(f)
  if ally and f:Permission(mode,2)then
   if f.menu.Misc.ReserveShield:Value()and Hooks.reserve(f,2,ally,context,permission(f,mode,2))then return true end
   if Hooks.castE(f,ally,context,permission(f,mode,2),false)then return true end
  end
  if f:Permission(mode,1)and hp(H)*100<f.menu.Misc.HealHP:Value()and f:Reach(u,f:Range(1))then
   if f.profile.id=='normal'and Hooks.reserve(f,1,u,context,permission(f,mode,1))then return true end
   if Hooks.castW(f,u,context,permission(f,mode,1))then return true end
  end
  if f.profile.id=='classic'and f:Permission(mode,2)then
   local recipient,best
   for _,v in ipairs(Hooks.allies(f))do local count=#f:AreaRows(v.pos,f.profile.e.area);if count>0 and(not best or count>best)then recipient=v;best=count end end
   if recipient then
    if Hooks.mantra(f)and Hooks.castE(f,recipient,context,permission(f,mode,2),true)then return true end
    if Hooks.reserve(f,2,recipient,context,permission(f,mode,2),true)then return true end
   end
  end
  if Hooks.speed(f,u,mode,context,ally)then return true end
  if f:Permission(mode,0)then
   if not ally and not Hooks.groupFight(f)and f:Reach(u,f:Range(0))and Hooks.reserve(f,0,u,context,permission(f,mode,0))then return true end
   if Hooks.holdQ(f,u,mode,ally)then
    if C.logger then C:Trace('karma_hold_q',{r=H:GetSpellData(3).currentCd},500)end
   elseif Hooks.castQ(f,u,context,permission(f,mode,0))then return true
   elseif mode=='Harass'and Hooks.otherQ(f,u,context,permission(f,mode,0))then return true end
  end
  if f.profile.id=='classic'and f:Permission(mode,1)and f.menu.Misc.BondAlly:Value()then
   for _,v in ipairs(Hooks.allies(f))do if v~=H and Hooks.bondHits(f,v)>0 and Hooks.castW(f,v,context,permission(f,mode,1))then return true end end
  end
  return f:Permission(mode,1)and Hooks.castW(f,u,context,permission(f,mode,1))or false
 end
 -- E on Karma for its speed (Normal: 40% for 2 s): to keep a tether that the
 -- target is about to break (predicted beyond the 825 leash before the 2 s complete), or in Combo to catch a target
 -- outside W range that Q cannot hit, never toward one under its turret. A defended ally is handled first.
 function Hooks.speed(f,u,mode,context,ally)
  if f.profile.id~='normal'or ally or not f:Permission(mode,2)or not f:Ready(2)or not Hooks.allyAllowed(f,H)then return false end
  local t=f.sequences.tether
  if t and t.target==u and t.start then
   local left=math.max(0,(f.profile.w.duration or 2)-(G.Timer()-t.start))
   local at=along(u,left);local leash=f.profile.w.leash or 825
   if left>.1 and at and f.distance(at,H.pos)>leash then
    return Hooks.castE(f,H,context,function()local s=f.sequences.tether;return s==t and f:Permission(mode,2)end,'flee')
   end
   return false
  end
  if mode~='Combo'or f.distance(H.pos,u.pos)<=f:Range(1)or not f:Safe(u.pos)then return false end
  if f:Ready(0)and f:Reach(u,f:Range(0))and f:Prediction(u,f.profile.q)then return false end
  return Hooks.castE(f,H,context,function()return f:Permission(mode,2)and f:Current(u)and f.distance(H.pos,u.pos)>f:Range(1)end,'flee')
 end
 -- Harass: when the chosen target cannot be hit, up to four other allowed enemies in Q reach (lowest health first).
 -- A selected target keeps precedence: nothing else is tried.
 function Hooks.otherQ(f,u,context,allowed)
  local ts=SDK.TargetSelector;local selected=ts.GetSelectedTarget and ts:GetSelectedTarget()
  if selected and f:Current(selected)then return false end
  local rows={}
  for _,v in ipairs(f:Rows('hero',f:Range(0)))do if id(v)~=id(u)and f:Allowed(v)then rows[#rows+1]=v end end
  table.sort(rows,function(a,b)return a.health<b.health end)
  for i=1,math.min(#rows,4)do if Hooks.castQ(f,rows[i],context,allowed)then return true end end
  return false
 end
 -- The nearest enemy closing on Karma (walking or dashing toward her), else the nearest enemy.
 function Hooks.pursuer(f,range)
  local best,bestD,near,nearD
  for _,v in ipairs(f:Rows('hero',range))do if f:Allowed(v)then
   local d=f.distance(H.pos,v.pos);local path=v.pathing;local to=path and(path.isDashing or path.hasMovePath)and path.endPos
   local closing=to and finite(to.x)and f.distance(H.pos,to)<d
   if closing and(not bestD or d<bestD)then best,bestD=v,d end
   if not nearD or d<nearD then near,nearD=v,d end
  end end
  return best or near
 end
 -- With two or more allies beside her the Mantra belongs to the group shield
 -- and its speed, not to one Q (Normal; needs E learned).
 function Hooks.groupFight(f)
  if f.profile.id~='normal'or(H:GetSpellData(2).level or 0)<1 then return false end
  local count=0;for _,v in ipairs(f:Rows('hero',1000,true))do if id(v)~=id(H)then count=count+1 end end
  return count>=2
 end
 function Hooks.farmCount(f,aim,kind,primary)
  local count=0;local length=f.distance(H.pos,aim);if length<1 then return 0 end
  for _,v in ipairs(f:Rows(kind,1100))do
   local hit
   if f.profile.id=='normal'then
    local moving=v.pathing and v.pathing.hasMovePath
    local margin=moving and(v.ms or 0)*f:Impact(0,primary)or 0
    hit=id(v)==id(primary)or f.distance(v.pos,aim)<=math.max(0,f.profile.q.splash-margin)
   else
    local d=f.distance(H.pos,v.pos);local dot=((v.pos.x-H.pos.x)*(aim.x-H.pos.x)+(v.pos.z-H.pos.z)*(aim.z-H.pos.z))/math.max(1,d*length)
    hit=d<=f.profile.q.range and dot>=math.cos(33*math.pi/360)
   end
   if hit then count=count+1 end
  end;return count
 end
 function Hooks.farm(f,u,rows,mode,context,last)
  -- Jungle: W on the largest monster when it outlives the 2 s tether (else Q takes it); below the heal threshold the
  -- Mantra W heal is used when R is allowed for this mode.
  if mode=='JungleClear'and u and u.team==300 and f:Permission(mode,1)and f:Ready(1)and f:Reach(u,f:Range(1))then
   local function survives()return f:Current(u)and u.health>f:Damage(1,u)*2 end
   if survives()then
    if f.profile.id=='normal'and hp(H)*100<f.menu.Misc.HealHP:Value()and Hooks.reserve(f,1,u,context,permission(f,mode,1))then return true end
    if Hooks.castW(f,u,context,function()return f:Permission(mode,1)and survives()end)then return true end
   end
  end
  if not f:Permission(mode,0)or not f:Ready(0)then return false end
  local kind=mode=='JungleClear'and 'jungle'or 'lane'
  local candidates={};for _,v in ipairs(rows)do if f:Reach(v,f:Range(0))and(not last or f:Rescue(v,0))then candidates[#candidates+1]=v end end
  table.sort(candidates,function(a,b)return f.distance(H.pos,a.pos)<f.distance(H.pos,b.pos)end)
  if #candidates==0 then return false end
  f.karmaFarmIndex=f.karmaFarmIndex or {};local first=(f.karmaFarmIndex[kind]or 1)-1
  for offset=1,math.min(4,#candidates)do local index=(first+offset-1)%#candidates+1;local target=candidates[index]
   local pred,reason=f:Prediction(target,f.profile.q)
   if reason=='equivalent_intent_waiting'then return false end
   f.karmaFarmIndex[kind]=index%#candidates+1
   if pred then
    local function count(aim)return Hooks.farmCount(f,aim,kind,target)end
    local function allowed()return f:Permission(mode,0)and(not last or f:Rescue(target,0))end
    local minimum=mode=='LaneClear'and f.menu.LaneClear.Count:Value()or 1
    local affected=count(pred.CastPosition)
    if(last and affected==1 or not last and affected>=minimum)and f:Cast(0,target,context,{world=true,permission=allowed,
     check=function(_,r)local n=count(position(r,pred.CastPosition));return last and n==1 or not last and n>=minimum end})then return true end
   end
  end;return false
 end
 function Hooks.flee(f,context)
  -- E is the escape: its speed helps with or without an enemy in sight. With
  -- an ally beside her, or below half health, Mantra makes it the group speed-up
  -- and the larger shield (Normal).
  if f:Permission('Flee',2)and Hooks.allyAllowed(f,H)then
   local company=false;for _,v in ipairs(f:Rows('hero',600,true))do if id(v)~=id(H)then company=true;break end end
   if f.profile.id=='normal'and(company or hp(H)<.5)and Hooks.reserve(f,2,H,context,permission(f,'Flee',2),'flee')then return true end
   if not f.sequences.mantra and Hooks.castE(f,H,context,permission(f,'Flee',2),'flee')then return true end
  end
  local u=Hooks.pursuer(f,950);if not u then return false end
  if f:Permission('Flee',1)and Hooks.castW(f,u,context,permission(f,'Flee',1))then return true end
  return f:Permission('Flee',0)and Hooks.castQ(f,u,context,permission(f,'Flee',0))or false
 end
 Hooks.options={'Independent'}
 -- Farming casts only Q (and W with its Mantra heal on a large monster).
 Hooks.modeSlots={LaneClear={'Q'},JungleClear={'Q','W','R'},LastHit={'Q'}}
 -- R (Mantra) only empowers Q, W or E, so it belongs to every fight and poke. W is a
 -- tether that commits to staying in range: not in Harass. Flee uses the whole kit.
 Hooks.defaults={Combo={R=true},Harass={R=true,W=false},Flee={Q=true,W=true,E=true,R=true}}
 Hooks.assistLabels={[0]='Cast Q at the selected target'}
 -- R (Mantra) has no target of its own: the Q bind empowers Q with it when it is ready.
 function Hooks.assist(f,slot,u,context)return slot==0 and(f:Reach(u,f:Range(0))and Hooks.reserve(f,0,u,context)or Hooks.castQ(f,u,context))or false end
 function Hooks.initialize(f)
  Hooks.discoverAllies(f)
  f:ShieldDefense(2,function()return Hooks.allyAllowed(f,H)and Hooks.shield(f,H)or 0 end,f.profile.e.duration,.3,function()return H end)
 end
 function Hooks.background(f)
  if not f.menu.Misc.Independent:Value()then return false end
  local ally=Hooks.defendTarget(f);return ally and Hooks.castE(f,ally,{priority='critical',condition=function()return f.menu.Misc.Independent:Value()end},function()return f.menu.Misc.Independent:Value()end,false)or false
 end

 Hooks.secureSlots={0}
 -- Normal: when only a Mantra Q kills, the finisher reserves R for it. The delayed field detonation is counted only
 -- for a target held until it lands (1.5 s after the hit).
 function Hooks.mantraQDamage(f,u)
  local p=f.profile;local rank=H:GetSpellData(3).level
  if p.id~='normal'or not f:Ready(3)or not finite(rank)or not p.rqBase[rank]then return nil end
  local raw=f:Raw(0,u,{mantra=true,ultimateRank=rank});if not finite(raw)or raw<=0 then return nil end
  if GetHardCCDuration(u)>=f:Impact(0,u)+1.5 then raw=raw+(p.rqDelayed[rank]or 0)+p.rqDelayedAP*(H.ap or 0)end
  return SDK.Damage:CalculateDamage(H,u,SDK.DAMAGE_TYPE_MAGICAL,raw)
 end
 function Hooks.secureDamage(f,slot,u)
  if slot~=0 or Hooks.mantra(f)then return nil end
  local plain=f:Damage(0,u);local estimate=C:HealthEstimate(u,f:Impact(0,u),'magical',plain)
  if estimate and estimate.lethal then return plain end
  return Hooks.mantraQDamage(f,u)or plain
 end
 function Hooks.secureCast(f,slot,u,context,lethal)
  if slot==0 and not Hooks.mantra(f)then
   local estimate=C:HealthEstimate(u,f:Impact(0,u),'magical',f:Damage(0,u))
   if not(estimate and estimate.lethal)then return Hooks.reserve(f,0,u,context,lethal)end
  end
  return Hooks.castQ(f,u,context,lethal,false)
 end
 function Hooks.secure(f)return f:KillSecure()end
 return Hooks
end)(_G,Core,CombatMechanics)
-- 26.20 independent Normal/Classic controller, assembled through the shared core.
local KarmaChampion=class("KarmaChampion")
function KarmaChampion:__init()self.engine=Core:CreateGameplay(self,GameplayHooks);Menu=self.engine.menu end
function KarmaChampion:Tick()return self.engine:Tick()end
function KarmaChampion:Combo()return self.engine:Combat('Combo')end
function KarmaChampion:Harass()return self.engine:Combat('Harass')end
function KarmaChampion:LaneClear()return self.engine:Farm('lane','LaneClear',false)end
function KarmaChampion:JungleClear()return self.engine:Farm('jungle','JungleClear',false)end
function KarmaChampion:LastHit()return self.engine:Farm('lane','LastHit',true)end
function KarmaChampion:Flee()return self.engine:Flee()end
-- Ranges only for ready abilities; with Mantra up (Normal) the Q reach includes the end blast. No state text:
-- the game shows Mantra and the health bars show the combo damage.
function KarmaChampion:Draw()
 local f=self.engine;if myHero.dead then return end
 if f.menu.Draw.Ranges:Value()then
  local q=f.profile.q;local mantra=q.mantra and f.ext.mantra(f)
  for slot=0,2 do if f:Ready(slot)then local range=f:Range(slot)
   if slot==0 and mantra then range=q.mantra.range+q.mantra.endBlast end
   if range>0 then Draw.Circle(myHero.pos,range,1,Draw.Color(255,120,180,255))end
  end end
 end
end
function KarmaChampion:Ready(slot)return self.engine:Ready(slot)end
function KarmaChampion:GetQDmg(u)return self.engine:Damage(0,u)end
function KarmaChampion:GetWDmg(u)return self.engine:Damage(1,u)end
function KarmaChampion:GetEDmg(u)return self.engine:Damage(2,u)end
function KarmaChampion:GetRDmg(u)return self.engine:Damage(3,u)end
function KarmaChampion:RegisterGuide(guide)return self.engine:RegisterGuide(guide)end
function KarmaChampion:FeatureStatus()return {profile=self.profile.id,patch=CombatMechanics.patch,liveVerified=false}end
local modes={};for _,mode in ipairs({'Combo','Harass','LaneClear','JungleClear','LastHit','Flee'})do local name=mode;modes[name]=function()return Core:ModeContext(name)end end
Core:RegisterPolicy({methods=modes,channel=function()return not Core:SelfChanneling(true)end,validate=function(self,q,slot)return type(slot)~='number'or slot<0 or slot>3 or self:Ready(slot)end})
KarmaChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Karma"]="Karma"}
local normalSupported={["Karma"]=true}

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
