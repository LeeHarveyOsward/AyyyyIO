return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Hecarim"]=function()return _G.OrbamaFamily:Require("d3ca887ec54ad35b415528cdadd4c8d3572ad8004ef2ae26bab2a2d299e8c63e")()end
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
modules["combatMechanics"]=_G.OrbamaFamily:Require("fa55d9e58476517c728e6c357b2aca50c3ab206fe6ee2f8725de485a40598eff")
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
if champion=="Hecarim" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Hecarim',profiles={normal=true,classic=true},
 Create=function(context)
local GameplayHooks=(function(g,C,P)
 local H,G,SDK=g.myHero,g.Game,g.SDK
 local id=C.id
 local finite=P.Finite
 local function permission(f,mode,slot)return function()return f:Permission(mode,slot)end end
 local Hooks={}

 -- Q, W and E are self casts around Hecarim; R dashes to a point and fears on
 -- arrival. Combo R needs an enemy count at the landing (Combo.RCount), a kill
 -- or a channel to break; every landing avoids walls and turrets.
 Hooks.defaults={Combo={R=true},LaneClear={W=false},Flee={R=false}}
 Hooks.options={'HP','Interrupt'}
 Hooks.modeSlots={Combo={'Q','W','E','R'},Harass={'Q','W'},LaneClear={'Q','W'},JungleClear={'Q','W'},LastHit={'Q'},Flee={'E','R'}}
 Hooks.assistLabels={[3]='Cast R at the selected target'}
 function Hooks.menu(f,menu)
  menu.Combo:MenuElement({id='RCount',name='R when the landing fears this many enemies',value=2,min=1,max=5,step=1})
  menu.Combo:MenuElement({id='SteerE',name='Steer E knock-back toward allies',value=true})
 end
 Hooks.strikeLabel='Planned E approach'
 local function charging(f)return f:Buff(H,f.profile.eNames)~=nil end
 -- Inside an area around Hecarim: 20 inside the unit's edge at its current position.
 local function inside(f,u,radius)return f:Current(u)and f.distance(H.pos,u.pos)<=radius+(u.boundingRadius or 0)-20 end
 local function count(f,kind,radius)local n=0;for _,u in ipairs(f:Rows(kind,radius+200))do if inside(f,u,radius)then n=n+1 end end;return n end
 function Hooks.castQ(f,u,context,allowed)
  if not f:Ready(0)or not inside(f,u,f.profile.q.radius)then return false end
  return f:Cast(0,u,context,{selfCast=true,range=f.profile.q.radius+(u.boundingRadius or 0),permission=allowed,check=function()return inside(f,u,f.profile.q.radius)end})
 end
 -- Spirit of Dread pulses for 4 s: cast with the enemy well inside the aura.
 function Hooks.castW(f,u,context,allowed)
  local radius=f.profile.w.radius-75
  if not f:Ready(1)or not inside(f,u,radius)then return false end
  return f:Cast(1,u,context,{selfCast=true,range=f.profile.w.radius,permission=allowed,check=function()return inside(f,u,radius)end})
 end
 -- Devastating Charge: haste for 4 s, the next attack knocks back and hits
 -- harder for the distance travelled. Started for a target outside attack
 -- range within the charge's reach, or one walking away inside it.
 local function leaving(f,u)
  local path=u.pathing;local to=path and path.hasMovePath==true and f.point(path.endPos)
  return to and f.distance(to,H.pos)>f.distance(u.pos,H.pos)+50 or false
 end
 local CHARGE_REACH=1350
 local function wantsE(f,u)
  if charging(f)or not f:Current(u)then return false end
  local d=f.distance(H.pos,u.pos);if d>CHARGE_REACH then return false end
  return not f:AttackReach(u)or leaving(f,u)
 end
 function Hooks.castE(f,u,context,allowed)
  if not f:Ready(2)or not wantsE(f,u)then return false end
  -- Waits out an own attack windup: cast inside it, the charge cancelled that attack (live s354).
  return f:Cast(2,u,context,{selfCast=true,range=CHARGE_REACH,permission=allowed,check=function()return wantsE(f,u)end,
   after=function()if C.logger then f.chargeObservedAt=G.Timer()end end})
 end
 -- R landing: the predicted positions of up to five enemies (and the middle of
 -- each close pair) are candidates; the landing is clamped to 300-1000 and must
 -- fear the anchor and at least `need` enemies 25 inside the fear radius.
 -- Prediction range is the dash (an enemy may stand up to the radius beyond).
 function Hooks.rSpec(f)
  if not f.hecarimRSpec then local r=f.profile.r;f.hecarimRSpec={circle=true,delay=r.delay,speed=r.speed,radius=r.radius,range=r.range}end
  return f.hecarimRSpec
 end
 local function clamp(f,p)
  local r=f.profile.r;local dx,dz=p.x-H.pos.x,p.z-H.pos.z;local d=math.sqrt(dx*dx+dz*dz);if d<1 then return nil end
  local length=math.max(r.minimum,math.min(r.range,d))
  return g.Vector(H.pos.x+dx/d*length,H.pos.y,H.pos.z+dz/d*length)
 end
 function Hooks.rPlan(f,anchor,need,offense)
  if not f:Ready(3)or not f:Current(anchor)then return nil end
  local r=f.profile.r;local rows={};local anchorRow
  for _,u in ipairs(f:Rows('hero',r.range+r.radius+100))do
   if #rows>=5 then break end
   if f:Allowed(u)then local pred=f:Prediction(u,Hooks.rSpec(f));local p=pred and f.point(pred.UnitPosition)
    if p then rows[#rows+1]={unit=u,position=p};if u==anchor then anchorRow=rows[#rows]end end
   end
  end
  if not anchorRow or #rows<need then return nil end
  local candidates={anchorRow.position}
  for i=1,#rows do if rows[i]~=anchorRow then candidates[#candidates+1]=rows[i].position end
   for j=i+1,#rows do if f.distance(rows[i].position,rows[j].position)<=r.radius*2 then
    local a,b=rows[i].position,rows[j].position;candidates[#candidates+1]=g.Vector((a.x+b.x)/2,a.y,(a.z+b.z)/2)end end
  end
  local best
  for _,c in ipairs(candidates)do local landing=clamp(f,c)
   if landing and f:Safe(landing,offense)then local n,hit=0,false
    for _,row in ipairs(rows)do if f.distance(row.position,landing)<=r.radius+(row.unit.boundingRadius or 0)-25 then n=n+1;hit=hit or row==anchorRow end end
    if hit and n>=need and(not best or n>best.count or n==best.count and f.distance(landing,H.pos)<f.distance(best.position,H.pos))then best={position=landing,count=n}end
   end
  end
  return best
 end
 -- `reason` re-proves the cast's purpose at dispatch (kill, channel); the
 -- landing is recomputed and must stay within 100 of the planned one.
 function Hooks.castR(f,u,context,allowed,need,offense,reason)
  local plan=Hooks.rPlan(f,u,need,offense);if not plan or reason and not reason()then return false end
  local identity,handle=id(u),u.handle
  return f:Cast(3,nil,context,{position=plan.position,range=f.profile.r.range+5,permission=allowed,weave=false,check=function()
   if not f:Current(u)or id(u)~=identity or u.handle~=handle or reason and not reason()then return false end
   local fresh=Hooks.rPlan(f,u,need,offense);return fresh~=nil and f.distance(fresh.position,plan.position)<=100
  end})
 end
 local function rImpact(f,u)return f.profile.r.delay+f.distance(H.pos,u.pos)/f.profile.r.speed end
 -- R kills when Q (ready) adds to it at the landing; not when Q and one attack already would.
 function Hooks.rKills(f,u)
  if u.type~=g.Obj_AI_Hero then return false end
  local q=f:Ready(0)and f:Damage(0,u)or 0
  if f:AttackReach(u)then
   local ok,aa=pcall(SDK.Damage.GetAutoAttackDamage,SDK.Damage,H,u,true)
   if C:Lethal(u,.25,function()return q+(ok and finite(aa)and aa or 0)end,{kind='physical'})then return false end
  end
  return C:Lethal(u,rImpact(f,u),function()return f:Damage(3,u)+q end,{kind='magical'})==true
 end
 -- A channel still running when the riders arrive is broken by the fear.
 function Hooks.rInterrupt(f,mode,context)
  if not f.menu.Misc.Interrupt:Value()or not f:Permission(mode,3)or not f:Ready(3)then return false end
  for _,u in ipairs(f:Rows('hero',f.profile.r.range+f.profile.r.radius))do
   local function channel()return f.menu.Misc.Interrupt:Value()and C:CanInterrupt(u,rImpact(f,u))end
   if f:Allowed(u)and channel()and Hooks.castR(f,u,context,permission(f,mode,3),1,false,channel)then return true end
  end
  return false
 end
 function Hooks.combat(f,u,mode,context)
  if mode=='Combo'then
   if Hooks.rInterrupt(f,mode,context)then return true end
   if f:Permission(mode,3)then
    if Hooks.castR(f,u,context,permission(f,mode,3),f.menu.Combo.RCount:Value(),false)then return true end
    local function kill()return Hooks.rKills(f,u)end
    if kill()and Hooks.castR(f,u,context,permission(f,mode,3),1,true,kill)then return true end
   end
   if f:Permission(mode,2)and Hooks.castE(f,u,context,permission(f,mode,2))then return true end
  end
  -- Q and W on the nearest allowed enemy inside their area, not only the target.
  for _,slot in ipairs({0,1})do if f:Permission(mode,slot)then
   local cast=slot==0 and Hooks.castQ or Hooks.castW
   if cast(f,u,context,permission(f,mode,slot))then return true end
   for _,v in ipairs(f:Rows('hero',f.profile.w.radius+200))do if v~=u and f:Allowed(v)and cast(f,v,context,permission(f,mode,slot))then return true end end
  end end
  return false
 end
 -- The empowered attack of a running charge goes to the combat target.
 -- Development trace: the charge buff name is not established (FAMILY-HECARIM.md). Shortly
 -- after an observed charge, record whether it is recognized and the own buffs naming Hecarim.
 -- Distance charged so far (the knock-back grows with it on Normal): the hero's
 -- walked distance since the charge buff appeared, sampled every tick.
 local function track(f)
  if not charging(f)then f.chargeFrom=nil;f.chargeTravel=0;return end
  local p=f.point(H.pos);if f.chargeFrom and p then f.chargeTravel=(f.chargeTravel or 0)+f.distance(f.chargeFrom,p)end;f.chargeFrom=p
 end
 -- The empowered attack kills anyway (charge at its expected travel, the attack,
 -- a ready Q): the side does not matter, the strike is not steered.
 function Hooks.strikeKills(f,u,travel,reach)
  local q=f:Ready(0)and f:Damage(0,u)or 0
  local ok,aa=pcall(SDK.Damage.GetAutoAttackDamage,SDK.Damage,H,u,true)
  local impact=math.max(0,f.distance(H.pos,u.pos)-reach)/math.max(1,H.ms or 345)
  return C:Lethal(u,impact,function()return f:Damage(2,u,{travel=travel})+(ok and finite(aa)and aa or 0)+q end,{kind='physical'})==true
 end
 -- Angled strike (shared steering, docs/ANGLED-STRIKES.md): while the charge runs
 -- in Combo and the target is within 1000, the knock-back side is chosen (toward
 -- allies or an allied turret, away from the enemy team) and Hecarim walks round
 -- to it before the empowered attack lands.
 local STEER_REACH=1000
 function Hooks.strike(f,mode)
  if mode~='Combo'then return nil,'mode'end
  if not f.menu.Combo.SteerE:Value()then return nil,'off'end
  local b=f:Buff(H,f.profile.eNames);if not b then return nil,'not_charging'end
  local u=f:Target(1600);if not u or u.type~=g.Obj_AI_Hero or not f:Current(u)then return nil,'no_target'end
  local d=f.distance(H.pos,u.pos);if d>STEER_REACH then return nil,'far'end
  local spec=f.profile.e.strike;local reach=(H.range or 125)+(H.boundingRadius or 0)+(u.boundingRadius or 0)
  local travel=(f.chargeTravel or 0)+math.max(0,d-reach);local ends=C.buffExpiry(b)
  -- Up to 1 s of walking round: the charge lasts 4 s and Hecarim is the fastest unit on the field while it runs.
  return u,spec,{distance=C.strike.Distance(spec,travel),standoff=reach,window=1,remaining=finite(ends)and ends-G.Timer()or nil,
   lethal=function()return Hooks.strikeKills(f,u,travel,reach)end}
 end
 function Hooks.observe(f)
  track(f)
  local at=f.chargeObservedAt;if not at or G.Timer()-at<.15 then return end;f.chargeObservedAt=nil
  local names={};local n=H.buffCount
  if type(n)=='number'and n>=0 and n<=128 then for i=0,n do local b=H:GetBuff(i);local name=b and(b.count or 0)>0 and b.name
   if type(name)=='string'and #names<8 and name:find('Hecarim')then names[#names+1]=name end end end
  C:Trace('hecarim_e_buff',{profile=f.profile.id,recognized=charging(f),names=table.concat(names,','),seconds=G.Timer()-at})
 end
 function Hooks.attackTarget(f,mode)
  if(mode~='Combo'and mode~='Harass')or not charging(f)then return nil end
  local u=f:Target(1600);return u and f:AttackReach(u)and u or nil
 end
 function Hooks.assist(f,slot,u,context)
  if slot~=3 then return false end
  return Hooks.castR(f,u,context,nil,1,false)
 end
 -- Farming: Q with `Count` lane minions inside it, or a minion only Q can take
 -- in LastHit; W with one more minion than Q. Jungle Q and W on the camp.
 function Hooks.farm(f,u,rows,mode,context,last)
  local q,w=f.profile.q.radius,f.profile.w.radius-75
  if last then
   if not f:Permission(mode,0)then return false end
   for _,m in ipairs(rows)do if inside(f,m,q)and f:Rescue(m,0)then
    return f:Cast(0,m,context,{selfCast=true,range=q+(m.boundingRadius or 0),permission=function()return f:Permission(mode,0)and f:Rescue(m,0)end,check=function()return inside(f,m,q)end})
   end end
   return false
  end
  if mode=='LaneClear'then
   local need=f.menu.LaneClear.Count:Value()
   if f:Permission(mode,0)and f:Ready(0)then
    for _,m in ipairs(rows)do if inside(f,m,q)then
     local enough=count(f,'lane',q)>=need
     if(enough or f:Rescue(m,0))and f:Cast(0,m,context,{selfCast=true,range=q+(m.boundingRadius or 0),permission=permission(f,mode,0),
      check=function()return inside(f,m,q)and(count(f,'lane',q)>=need or f:Rescue(m,0))end})then return true end
     break
    end end
   end
   if f:Permission(mode,1)and f:Ready(1)and count(f,'lane',w)>=need+1 then
    for _,m in ipairs(rows)do if inside(f,m,w)then
     return f:Cast(1,m,context,{selfCast=true,range=f.profile.w.radius,permission=permission(f,mode,1),check=function()return count(f,'lane',w)>=need+1 end})
    end end
   end
   return false
  end
  if f:Permission(mode,0)and Hooks.castQ(f,u,context,permission(f,mode,0))then return true end
  return f:Permission(mode,1)and Hooks.castW(f,u,context,permission(f,mode,1))or false
 end
 -- Flee: the charge's haste, then (switch, default off) R toward the cursor.
 function Hooks.flee(f,context)
  if f:Permission('Flee',2)and f:Ready(2)and not charging(f)then
   if f:Cast(2,nil,context,{selfCast=true,permission=permission(f,'Flee',2),weave=false})then return true end
  end
  if not f:Permission('Flee',3)or not f:Ready(3)then return false end
  local cursor=C:CursorWorld();local p=cursor and clamp(f,cursor)
  if not p or not f:Safe(p,false)then return false end
  return f:Cast(3,nil,context,{position=p,range=f.profile.r.range+5,permission=permission(f,'Flee',3),weave=false,check=function()return f:Safe(p,false)end})
 end
 -- A dash onto Hecarim is answered with the charge: its empowered attack knocks
 -- the diver back (the attack goes to the combat target, Hooks.attackTarget).
 local function answerE(f,u,context,allowed)
  if not f:Ready(2)or charging(f)then return false end
  return f:Cast(2,u,context,{selfCast=true,range=800,permission=allowed,weave=false})
 end
 function Hooks.gapclose(f)return f:Gapclose(answerE)end
 Hooks.secureSlots={0}
 function Hooks.secureCast(f,slot,u,context,lethal)return Hooks.castQ(f,u,context,lethal)end
 function Hooks.secure(f)return f:KillSecure()end
 -- Health bars and KILL marks: ready Q, half of W's 4 s aura, E at its
 -- distance to the enemy, R, and one attack.
 function Hooks.comboDamage(f,u)
  local total=0
  local function add(slot,options,share)if f:Ready(slot)then local ok,d=pcall(f.Damage,f,slot,u,options);if ok and finite(d)then total=total+d*(share or 1)end end end
  add(0);add(1,nil,.5);add(2,{travel=f.distance(H.pos,u.pos)});add(3)
  local ok,aa=pcall(SDK.Damage.GetAutoAttackDamage,SDK.Damage,H,u,true);if ok and finite(aa)then total=total+aa end
  return total,true
 end
 function Hooks.initialize(f)
  local r,e=f.profile.r,f.profile.e;local name=f.profile.names[4][1]
  -- Onslaught of Shadows: 1100 dash, 300-1000 (asset DashSpeed, MaxDashRange); only against a lethal hit.
  f.mobilityOffered,f.mobilityReason=C:RegisterMobility({kind='dash',slot=3,key=g.HK_R,name=name,range=r.range,speeds={r.speed},castDelays={r.delay},
   toPoint=true,lethalOnly=true,profile=f.profile.id,label='Onslaught of Shadows',source='16.21 asset '..name..' DashSpeed 1100, MaxDashRange 1000',
   allowed=function(p)return p==nil or f.distance(H.pos,p)>=r.minimum-5 and f:Safe(p,false)end})
  -- Devastating Charge: at least the starting 25% haste for its 4 s.
  if C.RegisterEffect then
   f.hasteOffered,f.hasteReason=C:RegisterEffect({kind='haste',name=f.profile.names[3][1],slot=2,key=g.HK_E,profile=f.profile.id,
    source='16.21 asset '..f.profile.names[3][1]..' MinMoveSpeed 0.25, Duration 4',delay=0,duration=e.duration,percent=e.haste,
    ready=function()return f:Ready(2)and not charging(f)end})
  end
 end
 return Hooks
end)(_G,Core,CombatMechanics)
-- 26.21 Normal and Classic controller, assembled through the shared core.
local HecarimChampion=class("HecarimChampion")
function HecarimChampion:__init()self.engine=Core:CreateGameplay(self,GameplayHooks);Menu=self.engine.menu end
function HecarimChampion:Tick()return self.engine:Tick()end
function HecarimChampion:Combo()return self.engine:Combat('Combo')end
function HecarimChampion:Harass()return self.engine:Combat('Harass')end
function HecarimChampion:LaneClear()return self.engine:Farm('lane','LaneClear',false)end
function HecarimChampion:JungleClear()return self.engine:Farm('jungle','JungleClear',false)end
function HecarimChampion:LastHit()return self.engine:Farm('lane','LastHit',true)end
function HecarimChampion:Flee()return self.engine:Flee()end
function HecarimChampion:Draw()return self.engine:Draw()end
function HecarimChampion:Ready(slot)return self.engine:Ready(slot)end
function HecarimChampion:GetQDmg(u)return self.engine:Damage(0,u)end
function HecarimChampion:GetWDmg(u)return self.engine:Damage(1,u)end
function HecarimChampion:GetEDmg(u)return self.engine:Damage(2,u)end
function HecarimChampion:GetRDmg(u)return self.engine:Damage(3,u)end
function HecarimChampion:RegisterGuide(guide)return self.engine:RegisterGuide(guide)end
function HecarimChampion:FeatureStatus()return {profile=self.profile.id,patch=CombatMechanics.patch,liveVerified=false,
 evadeR={supported=self.engine.mobilityOffered==true,reason=self.engine.mobilityReason,liveVerified=false},
 evadeE={supported=self.engine.hasteOffered==true,reason=self.engine.hasteReason,liveVerified=false}}end
local modes={};for _,mode in ipairs({'Combo','Harass','LaneClear','JungleClear','LastHit','Flee'})do local name=mode;modes[name]=function()return Core:ModeContext(name)end end
Core:RegisterPolicy({methods=modes,channel=function()return not Core:SelfChanneling(true)end,validate=function(self,q,slot)return type(slot)~='number'or slot<0 or slot>3 or self:Ready(slot)end})
HecarimChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Hecarim"]="Hecarim"}
local normalSupported={["Hecarim"]=true}

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
