return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Jinx"]=function()return _G.OrbamaFamily:Require("80bae11dac5f4d9c6ab898fc56245965f4129c72145c12db29e8849f8a41c8f4")()end
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
if champion=="Jinx" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Jinx',profiles={normal=true,classic=false},
 Create=function(context)
-- Independently implemented Normal kit. Native evidence never becomes a Classic kit.
local profiles=ChampionProfiles('Jinx')
local finite,id,point=Core.finite,Core.id,Core.point
local spellOnly={attack=false} -- Core:Rescue: the attack is weighed here, by the rule this champion's regressions pin
local function ray(origin,aim,p)
 local dx,dz=aim.x-origin.x,aim.z-origin.z;local len=math.sqrt(dx*dx+dz*dz);if len<1 then return nil end
 dx,dz=dx/len,dz/len;return (p.x-origin.x)*dx+(p.z-origin.z)*dz,math.abs((p.x-origin.x)*dz-(p.z-origin.z)*dx),len
end
local function cleanup(self)self.preview=nil;self.attackWitness=nil;self.eObservation=nil;self.traps={};self.weaponRequest=nil;self.wHit=nil;self.rTrace=nil end
-- Provider directional world cast (off-screen aims): only when the provider offers it.
local function directional()
 local ok,caps=pcall(function()return Core.adapter:Capabilities()end)
 return ok and type(caps)=='table'and caps.directionalWorldCast==true
end
local JinxChampion=class("JinxChampion")
function JinxChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.traps={};self:LoadMenu()
 local p=self.profile
 self.recallCast={key=HK_R,damageType='physical',
  spell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=p.rDelay,Radius=p.rRadius,Range=p.rRange,Speed=p.rSpeed,Motion=p.rMotion,
   DirectionalCast=true,AimErrorWorld=5,Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL}},
  enabled=function()return Menu.Misc.BaseR:Value()end,
  safe=function()return self:Ready(_R)and GetEnemyCount(800,myHero.pos)==0 end,
  damage=function(unit,health,effective,distance)return self:Damage(unit,_R,distance,false,effective,health)end}
 Core:RegisterCleanup('Jinx',function()cleanup(self)end)
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 _G.SDK.Orbwalker:OnPreAttack(function(args)self:OnPreAttack(args)end)
 local ok,why=Core:RegisterPreparation('Jinx.preview',{intervalMs=150,maxDelayMs=450,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.previewFallback=not ok and why=='unsupported'
 -- Health-bar damage: a ready W, a ready R at the current distance and one attack.
 Core:RegisterComboDamage(function(u)
  local total=_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0
  if self:Ready(_W)then total=total+self:Damage(u,_W)end
  if self:Ready(_R)then total=total+self:Damage(u,_R)end
  return total,true
 end)
end
function JinxChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Jinx'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Switch weapons automatically (Q)',value=true})
  Menu[mode]:MenuElement({id='W',name='Use W out of attack range or to kill',value=true})
  Menu[mode]:MenuElement({id='E',name='Use E under immobilised targets',value=true})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Combo'and 15 or 40,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R when it kills',value=true})
 Menu.Combo:MenuElement({id='RCount',name='Or when R hits at least this many',value=2,min=1,max=5,step=1})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=kind,name=kind=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[kind]:MenuElement({id='Q',name='Switch weapons automatically (Q)',value=true})
  Menu.Clear[kind]:MenuElement({id='W',name='Use W',value=true})
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=40,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions a rocket must hit',value=3,min=2,max=6,step=1})
 Menu.Clear:MenuElement({id='SpellHarass',name='Harass enemy champions with W while lane clearing',toggle=true,value=false,key=string.byte('K'),callback=function(v)CheckChatBlock(Menu.Clear.SpellHarass,v)end})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='W',name='Use W on minions an attack would miss',value=true})
 Menu.LastHit:MenuElement({id='Q',name='Switch to the minigun to last hit',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=40,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='WAssist',name='Cast W at the selected target',key=string.byte('U')})
 Menu.Misc:MenuElement({id='KillSecure',name='Finish killable enemies without holding a mode key',value=true})
 Menu.Misc:MenuElement({id='BaseR',name='R recalling enemies at their base if it kills',value=true})
 Menu.Misc:MenuElement({id='RMax',name='Longest R cast distance',value=4000,min=1000,max=12500,step=500,menu=false})
 Menu.Misc:MenuElement({id='Reserve',name='Mana to keep when attacking with rockets',value=80,min=0,max=300,step=10,menu=false})
 Menu.Misc:MenuElement({id='Splash',name='Use rockets when they splash several enemies',value=true,menu=false})
 Menu.Misc:MenuElement({id='FleeW',name='Flee: W to slow an enemy',value=true})
 Menu.Misc:MenuElement({id='FleeE',name='Flee: E behind you and under immobilised enemies',value=true})
 Menu.Misc:MenuElement({id='AutoE',name='Place E under immobile, arriving or diving enemies',value=true})
 Menu.Misc:MenuElement({id='Steal',name='R to steal Baron, Dragon or Herald',value=false})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ability ranges while ready, and your attack range',value=false})
 Menu.Draw:MenuElement({id='Preview',name='Mark enemies R kills',value=true})
end
function JinxChampion:Mana(node)return Core.manaAbove(node:Value())end
function JinxChampion:Ready(slot)
 local s=myHero:GetSpellData(slot);local key=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot]
 return s and s.name==self.profile[key]and finite(s.level)and s.level>=1 and s.level<=(slot==_R and 3 or 5)
  and finite(s.mana)and s.mana>=0 and finite(myHero.mana)and myHero.mana>=0
  and(slot==_Q and s.currentCd==0 and Game.CanUseSpell(slot)==0 or slot~=_Q and s.mana<=myHero.mana and IsReady(slot))
end
function JinxChampion:Rows(kind,range)return Core:Rows(kind=='heroes'and 'hero'or kind,range)end
function JinxChampion:Current(u)return u~=nil and point(u.pos)~=nil and Core:CurrentUnit(u)end
function JinxChampion:Target(range)
 local u=_G.SDK.TargetSelector.Selected;if self:Current(u)and GetDistance(u.pos,myHero.pos)<=range then return u end
 u=GetTarget(range);return self:Current(u)and u or nil
end
function JinxChampion:OwnBuff(name,permanent)
 if not finite(myHero.buffCount)or myHero.buffCount>128 then return nil end
 for _,b in ipairs(Core:Fresh(GetBuffs,myHero))do
  local expiry=Core.buffExpiry(b)
  local source=b.source;local owner=type(source)=='number'and source or(type(source)=='table'or type(source)=='userdata')and id(source)
  local own=owner==nil or owner==0 or owner==myHero.networkID or owner==myHero.handle
  if type(source)=='table'or type(source)=='userdata'then
   if source.networkID and source.networkID~=0 and source.networkID~=myHero.networkID then own=false end
   if source.handle and source.handle~=0 and source.handle~=myHero.handle then own=false end
  end
  if b.sourcenID and b.sourcenID~=0 and b.sourcenID~=myHero.networkID then own=false end
  if b.sourceName and b.sourceName~=''and b.sourceName~=myHero.charName then own=false end
  if b.name and b.name:lower()==name and own and finite(b.count)and b.count>0
   and(finite(expiry)and expiry>Game.Timer()or permanent and(not expiry or expiry==0))then return b end
 end
end
function JinxChampion:Weapon()
 local rocket=self:OwnBuff('jinxq',true);local gun=self:OwnBuff('jinxqicon',true)
 if rocket and not gun then return 'rocket'elseif gun and not rocket then return 'minigun'end
end
-- Get Excited (own passive buff after a takedown; asset JinxPassiveKillAttackSpeed, name not live-verified).
function JinxChampion:Excited()
 return self:OwnBuff('jinxpassivekillattackspeed',false)or self:OwnBuff('jinxpassivekill',false)
end
function JinxChampion:Stacks()
 local b=self:OwnBuff('jinxqramp',false);if not b then return nil end
 return finite(b.count)and b.count%1==0 and b.count>=1 and b.count<=3 and b.count or nil
end
function JinxChampion:Ranges(u)
 local weapon=self:Weapon();local level=myHero:GetSpellData(_Q).level;local bonus=self.profile.qRange[level]
 if not weapon or not bonus or not finite(myHero.range)or myHero.range<100 or not finite(myHero.boundingRadius)then return nil end
 local base=myHero.range-(weapon=='rocket'and bonus or 0);local radius=myHero.boundingRadius+(u and u.boundingRadius or 0)
 return base+radius,base+bonus+radius
end
function JinxChampion:Projected(u,time)
 local pos=point(u.pos);local path=u.pathing
 if pos and path and(path.hasMovePath or path.isDashing)and point(path.endPos)then local speed=path.isDashing and path.dashSpeed or u.ms
  if finite(speed)and speed>0 then return pos:Extended(path.endPos,math.min(GetDistance(pos,path.endPos),speed*time))end
 end;return pos
end
function JinxChampion:Splash(u,kind)
 if not self:Current(u)then return 0 end
 local n=1;for _,v in ipairs(self:Rows(kind or 'heroes',1600))do
  if id(v)~=id(u)and GetDistance(self:Projected(u,.25),self:Projected(v,.25))<=self.profile.qSplash then n=n+1 end
 end;return n
end
function JinxChampion:DesiredWeapon(u,kind)
 if not self:Current(u)then return nil end;local base,rocket=self:Ranges(u);if not base then return nil end
 local distance=GetDistance(myHero.pos,u.pos);if distance>rocket then return nil end
 if myHero.mana<self.profile.qMana+Menu.Misc.Reserve:Value()then return 'minigun'end
 if kind=='lane'and self:Splash(u,kind)>=Menu.Clear.LaneClear.Count:Value()or kind=='jungle'and self:Splash(u,kind)>=2
  or not kind and Menu.Misc.Splash:Value()and self:Splash(u)>=2 then return 'rocket'end
 if distance>base then return 'rocket'end
 -- Get Excited: the passive attack speed offsets the rocket penalty, so champions get rockets inside minigun reach
 -- (the mana reserve above still applies).
 if not kind and self:Excited()then return 'rocket'end
 -- Single nearby recipient: preserve native minigun attack speed and stacks.
 return 'minigun'
end
function JinxChampion:Switch(desired,context,permission)
 local weapon=self:Weapon();local spell=myHero:GetSpellData(_Q)
 if self.weaponRequest or not weapon or weapon==desired or not self:Ready(_Q)or not permission()
  or(desired=='rocket'and myHero.mana<self.profile.qMana+Menu.Misc.Reserve:Value())then return false end
 local toggle=spell.toggleState
 local function valid()return self:Ready(_Q)and self:Weapon()==weapon and myHero:GetSpellData(_Q).toggleState==toggle and permission()
  and(desired~='rocket'or myHero.mana>=self.profile.qMana+Menu.Misc.Reserve:Value())end
 local ok=Core:Cast(HK_Q,nil,{owner='WeaponSwitch',context=context,deferAttackWindup=true,validate=valid,
  observe=function(q)
   local changed=self:Weapon()==desired
   return changed and(myHero:GetSpellData(_Q).toggleState~=toggle or Core:NativeCast(q,'JinxQ')~=nil)
  end})
 if ok and Core.lastIntent then self.weaponRequest={q=Core.lastIntent,desired=desired,weapon=weapon,toggle=toggle,expires=Game.Timer()+2}end;return ok
end
function JinxChampion:MaintainWeapon()
 local row=self.weaponRequest;if not row then return end;local q=row.q;local result=Core.adapter:Poll(q.id)
 if q.observedAt or result and result.state=='cancelled_before_send'or not Core.adapter:ContextValid(q)then self.weaponRequest=nil;return end
 -- A sent or uncertain toggle gets no timer-driven replay while its original
 -- gesture remains authorized. Fresh native desired state reconciles it.
 if self:Weapon()==row.desired then self.weaponRequest=nil;return end
 -- A certain send that left the weapon and the slot's toggle exactly as they
 -- were, with Q ready again half a second later, switched nothing: a fresh
 -- decision may follow instead of waiting out the 2 s expiry. An uncertain or
 -- contested send keeps the lock above.
 if result and result.sentAt and result.state~='send_uncertain'and not q.ambiguous and Core.adapter:Now()-result.sentAt>500
  and self:Weapon()==row.weapon and myHero:GetSpellData(_Q).toggleState==row.toggle and self:Ready(_Q)then self.weaponRequest=nil;return end
 if Game.Timer()>row.expires and(not result or not result.sentAt and result.state~='send_uncertain'and result.state~='waiting')then self.weaponRequest=nil end
end
function JinxChampion:WDelay()
 local as=myHero.attackSpeed;if not finite(as)or as<=0 or as>10 then return nil end
 return math.max(self.profile.wMin,self.profile.wBaseDelay-self.profile.wASScalar*math.max(0,as-1))
end
function JinxChampion:Damage(u,slot,distance,secondary,futureHealth,observation)
 local observed=slot==_R and observation and u and observation.id==id(u)and observation.handle==u.handle and observation.name==u.charName
 if observation and not observed or not self:Current(u)and not observed then return 0 end;local p=self.profile;local rank=myHero:GetSpellData(slot).level;local raw
 if slot==_W then if not p.wBase[rank]or not finite(myHero.totalDamage)then return 0 end;raw=p.wBase[rank]+p.wAD*myHero.totalDamage
 elseif slot==_R then local maxHealth=observed and observation.maxHealth or u.maxHealth
  if not p.rMin[rank]or not finite(myHero.bonusDamage)or not finite(maxHealth)or maxHealth<=0 or futureHealth~=nil and not finite(futureHealth)then return 0 end
  local fraction=math.max(0,math.min(1,(distance or GetDistance(u.pos,myHero.pos))/p.rDamageDistance))
  raw=p.rMin[rank]+p.rMinAD*myHero.bonusDamage+fraction*(p.rMax[rank]-p.rMin[rank]+(p.rMaxAD-p.rMinAD)*myHero.bonusDamage)
  raw=raw+p.rMissing[rank]*math.max(0,maxHealth-(futureHealth or u.health));if secondary then raw=raw*p.rSecondary end
 else return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
end
function JinxChampion:GetWDmg(u)return self:Damage(u,_W)end
function JinxChampion:GetRDmg(u)return self:Damage(u,_R)end
function JinxChampion:Settings(slot)
 if slot==_W then local delay=self:WDelay();if not delay then return nil end
  return {Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=delay,Radius=60,Range=1450,Speed=3300,Collision=false,DirectionalCast=true,AimErrorWorld=5}
 end
 local p=self.profile
 return {Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=p.rDelay,Radius=p.rRadius,Range=Menu.Misc.RMax:Value(),Speed=p.rSpeed,Motion=p.rMotion,Collision=false,DirectionalCast=true,AimErrorWorld=5}
end
function JinxChampion:Predict(u,slot)
 if not self:Current(u)then return nil end;local settings=self:Settings(slot);if not settings then return nil end
 local p=Core:Prediction(settings);p:GetPrediction(u,myHero);return p:CanHit(2)and point(p.CastPosition)or nil
end
function JinxChampion:WClear(aim,u)
 local delay=self:WDelay();if not delay then return false end
 local time=delay+GetDistance(myHero.pos,aim)/3300;local target=self:Projected(u,time);local along=ray(myHero.pos,aim,target)
 if not along or along<0 then return false end
 for _,kind in ipairs({'heroes','lane','jungle'})do for _,v in ipairs(self:Rows(kind,1600))do if id(v)~=id(u)then
  local at=delay+GetDistance(v.pos,myHero.pos)/3300;local a,b=ray(myHero.pos,aim,self:Projected(v,at))
  if a and a>=0 and a<along and b<=60+(v.boundingRadius or 0)then return false end
 end end end
 local blocked,_,count=OrbamaPrediction:GetCollision(myHero.pos,aim,3300,delay,60,{OrbamaPrediction.COLLISION_YASUOWALL},id(u))
 return blocked~=true and(count or 0)==0
end
function JinxChampion:CastW(u,context,permission)
 if not self:Ready(_W)or not self:Current(u)or GetDistance(u.pos,myHero.pos)>1450 or not permission()then return false end
 local identity,handle=id(u),u.handle;local p=self:Predict(u,_W);if not p or not self:WClear(p,u)then return false end
 local dir=directional()
 local ok=Core:Cast(HK_W,p,{intentTarget=u,range=1450,context=context,deferAttackWindup=true,prevalidateWorldCast=true,
  directionalWorldCast=dir or nil,directionalAimError=dir and 5 or nil,
  resolve=function()if not self:Current(u)or id(u)~=identity or u.handle~=handle or not permission()then return nil end
   local fresh=self:Predict(u,_W);return fresh and self:WClear(fresh,u)and{position=fresh}or nil end,
  commitGuard=function()return Core:Current()and permission()end,
  validate=function(_,fresh)return self:Ready(_W)and self:Current(u)and id(u)==identity and u.handle==handle and permission()
   and fresh and self:WClear(fresh.position,u)end})
 -- After the observed W, the chain E (WChainE) may follow on a slowed target.
 if ok and Core.lastIntent then local delay=self:WDelay()or .6
  local row={unit=u,id=identity,handle=handle,flight=delay+GetDistance(u.pos,myHero.pos)/self.profile.wSpeed}
  Core:AfterCast(HK_W,function()row.observedAt=Game.Timer();row.expires=row.observedAt+row.flight+2.2;self.wHit=row end)
 end
 return ok
end
function JinxChampion:CCRemaining(u)
 if not self:Current(u)or not finite(u.buffCount)or u.buffCount>128 then return 0 end
 local kinds={[5]=true,[12]=true,[25]=true,[30]=true,[35]=true};local remaining=0
 for _,b in ipairs(Core:Fresh(GetBuffs,u))do local expiry=Core.buffExpiry(b)
  if kinds[b.type]and finite(expiry)and b.count and b.count>0 then remaining=math.max(remaining,expiry-Game.Timer())end
 end;return remaining
end
function JinxChampion:TrapLegal(p)
 if not point(p)or GetDistance(p,myHero.pos)>925 or type(Game.isWall)~='function'or Game.isWall(p)~=false then return false end
 local r=self.profile.eRadius
 local blocked,_,n=OrbamaPrediction:GetCollision(myHero.pos,p,self.profile.eSpeed,self.profile.eDelay,r,{OrbamaPrediction.COLLISION_YASUOWALL},0)
 if blocked==true or(n or 0)>0 then return false end
 for _,t in pairs(self.traps)do if t.expires>Game.Timer()and IsValid(t.object)and t.object.handle==t.handle and GetDistance(t.object.pos,p)<r then return false end end
 return true
end
function JinxChampion:CastE(p,context,permission,target,controlled)
 if not self:Ready(_E)or not permission()or not self:TrapLegal(p)then return false end
 local position=point(p);local identity,handle=id(target),target and target.handle
 local function valid()return self:Ready(_E)and permission()and self:TrapLegal(position)
  and(not target or self:Current(target)and id(target)==identity and target.handle==handle and GetDistance(target.pos,position)<=self.profile.eRadius
   and(not controlled or self:CCRemaining(target)>=self.profile.eDelay+self.profile.eArm+GetDistance(position,myHero.pos)/self.profile.eSpeed))end
 if not valid()then return false end
 local ok=Core:Cast(HK_E,position,{intentTarget=target,range=925,context=context,prevalidateWorldCast=true,deferAttackWindup=true,
  resolve=function()return valid()and{position=position}or nil end,commitGuard=function()return Core:Current()and permission()end,validate=valid})
 if ok and Core.lastIntent then local q=Core.lastIntent;local row={request=q.requestGameTime,point=position,expires=q.requestGameTime+3,distance=GetDistance(position,myHero.pos)};self.eObservation=row
  Core:AfterCast(HK_E,function()if self.eObservation==row then row.castObserved=true;row.castAt=Game.Timer()end end)
 end;return ok
end
function JinxChampion:Trap(u,context,permission)return self:Current(u)and self:CastE(u.pos,context,permission,u,true)end
-- Jinx's W slow on `u` observed after `row`'s W (own source, or no source and started after the W): its expiry.
function JinxChampion:WSlow(u,row)
 if not finite(u.buffCount)or u.buffCount>128 then return nil end
 local best
 for _,b in ipairs(Core:Fresh(GetBuffs,u))do
  if b.type==10 and finite(b.count)and b.count>0 then local expiry=Core.buffExpiry(b)
   if finite(expiry)and expiry>Game.Timer()then
    local src=b.source;local sid=type(src)=='number'and src or(type(src)=='table'or type(src)=='userdata')and id(src)or b.sourcenID
    local mine=sid==myHero.networkID or sid==myHero.handle or(sid==nil or sid==0)and finite(b.startTime)and b.startTime>=row.observedAt-.05
    if mine and(not best or expiry>best)then best=expiry end
   end
  end
 end
 return best
end
-- W then E: after an observed W, chompers where the slowed target will stand when they arm, when the slow lasts
-- past landing and arming, the target cannot walk out of the effect radius while they arm, and the spot is legal.
function JinxChampion:WChainE(mode)
 local row=self.wHit;if not row then return false end
 if Game.Timer()>row.expires then self.wHit=nil;return false end
 local node=Menu[mode];if not node or not node.E:Value()or not self:Ready(_E)then return false end
 local u=row.unit;if not self:Current(u)or id(u)~=row.id or u.handle~=row.handle then self.wHit=nil;return false end
 local p=self.profile
 local function plan()
  if not self:Current(u)or id(u)~=row.id or u.handle~=row.handle then return nil end
  local slowEnd=self:WSlow(u,row);if not slowEnd or not finite(u.ms)or u.ms*p.eArm>p.eEffect then return nil end
  local guess=self:Projected(u,p.eDelay+p.eArm);if not guess then return nil end
  local arm=p.eDelay+GetDistance(guess,myHero.pos)/p.eSpeed+p.eArm
  if slowEnd-Game.Timer()<arm then return nil end
  local at=self:Projected(u,arm);if not at or GetDistance(at,myHero.pos)>p.eRange then return nil end
  return at
 end
 local at=plan();if not at then return false end
 local ok=self:CastE(at,Core:ModeContext(mode),function()local fresh=plan();return node.E:Value()and fresh~=nil and GetDistance(fresh,at)<=p.eRadius end)
 if ok then self.wHit=nil end
 return ok
end
-- Self-peel: a melee champion (attack range <= 300) closing in within 350, or attacking Jinx within 200: chompers
-- between it and Jinx (at her feet when it is on top of her), when they arm at most 1.25 s after it could hit her.
function JinxChampion:PeelE()
 if not Menu.Misc.AutoE:Value()or not self:Ready(_E)then return false end
 local p=self.profile;local incoming=Core:IncomingAttack(myHero,0,1.25)
 for _,u in ipairs(self:Rows('heroes',600))do
  if finite(u.range)and u.range<=300 then
   local d=GetDistance(u.pos,myHero.pos);local path=u.pathing;local to=path and path.hasMovePath==true and point(path.endPos)
   local attacking=d<=200 and incoming~=nil and incoming.casterID==u.networkID
   local closing=d<=350 and type(to)=='table'and GetDistance(to,myHero.pos)<d
   if attacking or closing then
    local spot=d<=120 and point(myHero.pos)or myHero.pos:Extended(u.pos,math.min(d*.5,150))
    local function fits()
     if not Menu.Misc.AutoE:Value()or not self:Current(u)then return false end
     local now=GetDistance(u.pos,myHero.pos);if now>400 then return false end
     local armed=p.eDelay+GetDistance(spot,myHero.pos)/p.eSpeed+p.eArm
     local reach=math.max(0,now-(u.range+(u.boundingRadius or 0)+(myHero.boundingRadius or 0)))/math.max(1,finite(u.ms)and u.ms or 1)
     return armed-reach<=1.25
    end
    if fits()and self:CastE(spot,{priority='interactive'},fits)then return true end
   end
  end
 end
 return false
end
-- Without a mode key: chompers under enemies who cannot move yet or are about to arrive (stasis, revive, hard
-- control, channels, teleport and gate markers), from the shared scan. They must be armed before the enemy is free:
-- cast, flight to that spot and arming are weighed against the row's time, again at dispatch.
function JinxChampion:ZoneE()
 if not Menu.Misc.AutoE:Value()or not self:Ready(_E)then return false end
 local p=self.profile;local base=p.eDelay+p.eArm
 local rows=Core:ZoneTargets({range=p.eRange,arm=base,lifetime=p.eDuration})
 for i=1,math.min(#rows,6)do local row=rows[i];local pos=point(row.position)
  local function fits()return Menu.Misc.AutoE:Value()and row.valid()and row.freeAt-Game.Timer()>=base+GetDistance(pos,myHero.pos)/p.eSpeed end
  if pos and fits()and self:CastE(pos,{priority='interactive'},fits)then return true end
 end
 return false
end
-- An enemy dash that ends next to Jinx: chompers on the end point. The diver came to stay, but only for a
-- moment, so the trap is refused when it would arm more than a second after the dash ends (cast, flight and
-- arming against the dash time still left).
function JinxChampion:DashE()
 if not Menu.Misc.AutoE:Value()or not self:Ready(_E)then return false end
 local p=self.profile
 for _,u in ipairs(self:Rows('heroes',1500))do
  local dash=Core:ApproachingDash(u,myHero.pos,350);local pos=dash and point(dash.to)
  if pos then
   local function fits()
    if not Menu.Misc.AutoE:Value()or not self:Current(u)then return false end
    local armed=p.eDelay+p.eArm+GetDistance(pos,myHero.pos)/p.eSpeed
    local d=Core:ApproachingDash(u,myHero.pos,350)
    -- The dash may have ended while the request waited: the enemy then stands on the spot.
    if not d then return GetDistance(u.pos,pos)<=p.eRadius end
    local to=point(d.to);if not to or GetDistance(to,pos)>p.eRadius then return false end
    return armed-(finite(d.duration)and d.duration or 0)<=1
   end
   if fits()and self:CastE(pos,{priority='interactive'},fits)then return true end
  end
 end
 return false
end
function JinxChampion:MaintainTraps()
 for key,t in pairs(self.traps)do if not IsValid(t.object)or t.object.handle~=t.handle or Game.Timer()>t.expires then self.traps[key]=nil end end
 local row=self.eObservation;if not row then return end;if Game.Timer()>row.expires then self.eObservation=nil;return end;if not row.castObserved then return end
 local src=_G.SDK.ObjectManager:GetAllyMinions(1100)
 for i=1,math.min(#src,32)do local u=src[i];local owner=u.ownerID or u.ownerNetworkID or u.owner and id(u.owner)
  if owner==myHero.networkID and u.charName=='JinxMine'and IsValid(u)and finite(u.spawnTime)and u.spawnTime>=row.request and GetDistance(u.pos,row.point)<=240
   and not(row.objects and row.objects[id(u)])then
   local size=0;for _ in pairs(self.traps)do size=size+1 end
   if size>=12 then local oldest,expiry;for key,t in pairs(self.traps)do if not expiry or t.expires<expiry then oldest,expiry=key,t.expires end end;self.traps[oldest]=nil end
   self.traps[id(u)]={object=u,handle=u.handle,armedAt=u.spawnTime+.5,expires=u.spawnTime+5};row.objects=row.objects or {};row.objects[id(u)]=true
   -- Development evidence for the chomper land time (wiki 0.4 s, no cast time; ours 0.5 + d/1750).
   if Core.logger and not row.traced then row.traced=true;Core:Trace('jinx_e_land',{distance=row.distance,request=row.request,castAt=row.castAt,spawn=u.spawnTime})end
   row.count=(row.count or 0)+1;if row.count>=3 then self.eObservation=nil;return end
  end
 end
end
function JinxChampion:RTravel(distance)
 return self.profile.rDelay+OrbamaPrediction.ProjectileMotion.Time(self.profile.rMotion,distance)
end
function JinxChampion:RContactPlan(aim,anchor,scope)
 if not self:Current(anchor)or anchor.type~=Obj_AI_Hero or not point(aim)then return nil end
 local distance=GetDistance(aim,myHero.pos);if distance>Menu.Misc.RMax:Value()then return nil end
 local rows=scope and scope.rows or self:Rows('heroes',math.min(13000,distance+550));local first,firstAlong
 for _,u in ipairs(rows)do
  local time=self:RTravel(GetDistance(u.pos,myHero.pos));local pos=self:Projected(u,time);local a,b,len=ray(myHero.pos,aim,pos)
  if a and a>=0 and a<=len+140+(u.boundingRadius or 0)and b<=140+(u.boundingRadius or 0)then
   local contact=math.max(0,a-math.sqrt(math.max(0,(140+(u.boundingRadius or 0))^2-b*b)))
   if not firstAlong or contact<firstAlong then first,firstAlong=u,contact end
  end
 end
 if not first then return nil end
 -- Explosion occurs at the actual first champion's collision boundary, not
 -- the intended target's centre. Secondary damage uses that travel distance.
 local hit=myHero.pos:Extended(aim,firstAlong);local impact=self:RTravel(firstAlong)
 local p=self.profile
 local blocked,_,n=OrbamaPrediction:GetCollision(myHero.pos,hit,p.rSpeed,p.rDelay,p.rRadius,{OrbamaPrediction.COLLISION_YASUOWALL},id(first),{motion=p.rMotion})
 if blocked==true or(n or 0)>0 then return nil end
 local victims,count,anchorDamage,anchorLower={},0,nil,nil
 for _,u in ipairs(rows)do local pos=self:Projected(u,impact)
  if id(u)==id(first)or GetDistance(pos,hit)<=400+(u.boundingRadius or 0)then
   local damage=self:Damage(u,_R,firstAlong,id(u)~=id(first));victims[id(u)]=damage;count=count+1
   if id(u)==id(anchor)then
    anchorDamage=damage;local regen=finite(u.hpRegen)and math.max(0,u.hpRegen)or finite(u.healthRegen)and math.max(0,u.healthRegen)or 0
    anchorLower=self:Damage(u,_R,0,id(u)~=id(first),math.min(u.maxHealth,u.health+regen*impact))
   end
  end
 end
 if not anchorDamage then return nil end
 return {first=first,firstID=id(first),firstHandle=first.handle,position=hit,distance=firstAlong,time=impact,count=count,damage=anchorLower,estimate=anchorDamage,victims=victims}
end
function JinxChampion:RPlan(aim,anchor)
 if not point(aim)then return nil end
 local scope={rows=self:Rows('heroes',math.min(13000,GetDistance(aim,myHero.pos)+550))}
 return self:RContactPlan(aim,anchor,scope)
end
-- The rocket kills its anchor at impact by the shared kill rule: invulnerability and stasis refuse (a spell shield
-- does not stop the rocket's explosion, only its damage, which the shield pools carry), undying/revive states refuse
-- (Core:CannotDie inside Core:Lethal), and the health window ages health to the impact time.
function JinxChampion:RLethal(u,plan)
 if not plan then return false end
 local protected,why=Core:SpellProtected(u)
 if protected~=false and why~='spell_shield'then return false end
 return(Core:Lethal(u,plan.time,plan.damage,{kind='physical',protection=false}))
end
-- A cheaper kill exists: a ready lethal W, or the next two attacks inside the current weapon reach (health window
-- at the second landing, attack-only dodges counted). Automatic R waits for those.
function JinxChampion:CheaperKill(u)
 local d=GetDistance(u.pos,myHero.pos)
 if self:Ready(_W)and d<=self.profile.wRange and self:LethalW(u)then return true end
 local base,rocket=self:Ranges(u);local reach=self:Weapon()=='rocket'and rocket or base
 if not reach or d>reach then return false end
 local attack=_G.SDK.Attack;local animation=attack and attack.GetAnimation and attack:GetAnimation();local windup=attack and attack.GetWindup and attack:GetWindup()
 local ready=Core:AttackReadyIn()
 if not finite(animation)or not finite(windup)or not finite(ready)or animation<=0 then return false end
 local damage=_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)
 if not finite(damage)or damage<=0 then return false end
 return(Core:Lethal(u,ready+animation+windup,2*damage,{kind='physical',attack=true}))
end
function JinxChampion:CastR(u,context,permission,manual)
 if not self:Ready(_R)or not self:Current(u)or GetDistance(u.pos,myHero.pos)>Menu.Misc.RMax:Value()or not permission()then return false end
 local identity,handle=id(u),u.handle
 local function useful(plan)
  if not plan then return false end
  -- manual: true = bind (any hit), 'kill' = finisher (lethal only), false = Combo (lethal or enemy count).
  if manual==true then return true end
  if GetDistance(u.pos,myHero.pos)<700 then return false end
  if self:RLethal(u,plan)and not self:CheaperKill(u)then return true end
  return manual~='kill'and plan.count>=Menu.Combo.RCount:Value()
 end
 local aim=self:Predict(u,_R);local plan=aim and self:RPlan(aim,u);if not useful(plan)then return false end
 local dir=directional()
 local ok=Core:Cast(HK_R,aim,{intentTarget=u,range=Menu.Misc.RMax:Value(),context=context,deferAttackWindup=true,prevalidateWorldCast=true,
  directionalWorldCast=dir or nil,directionalAimError=dir and 5 or nil,
  resolve=function()if not self:Current(u)or id(u)~=identity or u.handle~=handle or not permission()then return nil end
   local p=self:Predict(u,_R);local fresh=p and self:RPlan(p,u);return useful(fresh)and {position=p}or nil end,
  commitGuard=function()return Core:Current()and permission()end,
  validate=function(_,fresh)return self:Ready(_R)and self:Current(u)and id(u)==identity and u.handle==handle and permission()
   and fresh and useful(self:RPlan(fresh.position,u))end})
 if ok and Core.logger and Core.lastIntent then self.rTrace={q=Core.lastIntent,unit=u,distance=GetDistance(u.pos,myHero.pos),expires=Game.Timer()+10}end
 return ok
end
-- Development evidence only: R flight time (observed cast start -> first health drop of the target) by distance,
-- to check the recorded native missile model against impact. Nothing here authorizes a cast.
function JinxChampion:TraceEvidence()
 local t=self.rTrace;if not t then return end;local now=Game.Timer();local u=t.unit
 if now>t.expires or not IsValid(u)then self.rTrace=nil;return end
 if t.q.observedAt and not t.start then local a=myHero.activeSpell
  t.start=a and a.valid and finite(a.startTime)and a.startTime or now;t.health=u.health
 elseif t.start and finite(u.health)and t.health and u.health<t.health-1 then
  Core:Trace('jinx_r_flight',{distance=t.distance,delay=now-t.start,drop=t.health-u.health});self.rTrace=nil
 end
end
-- Epic monsters (Baron, Dragon, Herald, Atakhan by name).
function JinxChampion:Epic(u)
 local n=type(u.charName)=='string'and u.charName:lower()or ''
 return n:find('baron',1,true)or n:find('dragon',1,true)or n:find('riftherald',1,true)or n:find('atakhan',1,true)
end
-- Being taken: it has lost health and a visible enemy champion stands within 800 of it.
function JinxChampion:Contested(u)
 if not finite(u.health)or not finite(u.maxHealth)or u.health>=u.maxHealth then return false end
 for _,h in ipairs(self:Rows('heroes',13000))do if GetDistance(h.pos,u.pos)<=800 then return true end end
 return false
end
-- R against a monster: the missing-health part is capped (asset JinxR MonsterExecuteMax 1200); current health
-- (not the lower health at impact) keeps that part conservative.
function JinxChampion:RMonsterDamage(u,distance)
 local p=self.profile;local rank=myHero:GetSpellData(_R).level
 if not p.rMin[rank]or not finite(myHero.bonusDamage)or not finite(u.maxHealth)or not finite(u.health)then return 0 end
 local fraction=math.max(0,math.min(1,distance/p.rDamageDistance))
 local raw=p.rMin[rank]+p.rMinAD*myHero.bonusDamage+fraction*(p.rMax[rank]-p.rMin[rank]+(p.rMaxAD-p.rMinAD)*myHero.bonusDamage)
 raw=raw+math.min(p.rMonsterCap,p.rMissing[rank]*math.max(0,u.maxHealth-u.health))
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
end
-- Objective steal (off by default): R at a contested epic monster when it kills at impact
-- (health forecast) and no enemy champion stands on the path (the rocket would explode on it).
function JinxChampion:Steal()
 if not Menu.Misc.Steal:Value()or not self:Ready(_R)then return false end
 for _,u in ipairs(self:Rows('jungle',Menu.Misc.RMax:Value()))do
  if self:Epic(u)and self:Contested(u)then
   local identity,handle=id(u),u.handle
   local function kills()
    if not self:Current(u)or id(u)~=identity or u.handle~=handle or not Menu.Misc.Steal:Value()or not self:Contested(u)then return false end
    local d=GetDistance(u.pos,myHero.pos);if d>Menu.Misc.RMax:Value()then return false end
    for _,h in ipairs(self:Rows('heroes',math.min(13000,d+550)))do local a,b=ray(myHero.pos,u.pos,h.pos)
     if a and a>=0 and a<d and b<=self.profile.rRadius+(h.boundingRadius or 0)then return false end
    end
    return(Core:Lethal(u,self:RTravel(d),function()return self:RMonsterDamage(u,d)end,{kind='physical'}))
   end
   if kills()then local dir=directional()
    if Core:Cast(HK_R,point(u.pos),{intentTarget=u,range=Menu.Misc.RMax:Value(),context={priority='interactive'},owner='RSteal',deferAttackWindup=true,prevalidateWorldCast=true,
     directionalWorldCast=dir or nil,directionalAimError=dir and 5 or nil,
     resolve=function()return kills()and{position=point(u.pos)}or nil end,commitGuard=function()return Core:Current()and Menu.Misc.Steal:Value()end,
     validate=function(_,fresh)return self:Ready(_R)and fresh~=nil and kills()end})then return true end
   end
  end
 end
 return false
end
-- W kills on arrival: the shared kill rule (physical shield pool, health window, regeneration until impact).
function JinxChampion:LethalW(u)
 local delay=self:WDelay();if not delay or not self:Current(u)then return false end
 return(Core:Lethal(u,delay+GetDistance(u.pos,myHero.pos)/self.profile.wSpeed,function()return self:Damage(u,_W)end,{kind='physical'}))
end
function JinxChampion:WUseful(u)
 local base,rocket=self:Ranges(u);local range=self:Weapon()=='rocket'and rocket or base
 return not range or GetDistance(u.pos,myHero.pos)>range or self:LethalW(u)
end
-- Rockets cost mana per shot and give up the minigun's attack speed: with no enemy champion near they go away.
function JinxChampion:NoEnemyNear()return #self:Rows('heroes',1500)==0 end
function JinxChampion:Structure(u)
 return u~=nil and IsValid(u)and u.team~=myHero.team and(u.type==Obj_AI_Turret or Obj_AI_Barracks~=nil and u.type==Obj_AI_Barracks or Obj_AI_Nexus~=nil and u.type==Obj_AI_Nexus)
end
-- Structures take no splash: the minigun's attack speed is the better weapon whenever it reaches.
function JinxChampion:StructureWeapon()
 local node=Menu.Clear.LaneClear
 if not Menu.Clear.SpellFarm:Value()or not node.Q:Value()or self:Weapon()~='rocket'or not self:Ready(_Q)then return false end
 local u=_G.SDK.Orbwalker:GetTarget();local witness=self.attackWitness
 if not self:Structure(u)and witness and witness.object and Game.Timer()-witness.at<=1.5 then u=witness.object end
 local function fits()if not self:Structure(u)then return false end;local base=self:Ranges(u);return base~=nil and GetDistance(u.pos,myHero.pos)<=base and self:NoEnemyNear()end
 return fits()and self:Switch('minigun',Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end),function()return Menu.Clear.SpellFarm:Value()and node.Q:Value()and fits()end)
end
-- The small monsters of a camp die to the rocket splash; W belongs on the big one.
function JinxChampion:SmallMonster(u,rows)
 local name=type(u.charName)=='string'and u.charName:lower()
 if name and name:find('mini',1,true)and not name:find('minion',1,true)then return true end
 for _,v in ipairs(rows)do if id(v)~=id(u)and finite(v.maxHealth)and finite(u.maxHealth)and v.maxHealth>u.maxHealth*1.5 and GetDistance(v.pos,u.pos)<=600 then return true end end
 return false
end
function JinxChampion:Combat(mode)
 local node=Menu[mode]
 if not self:Mana(node.Mana)then
  if node.Q:Value()and self:Weapon()=='rocket'then return self:Switch('minigun',Core:ModeContext(mode),function()return node.Q:Value()and not self:Mana(node.Mana)end)end
  return
 end;local u=self:Target(1450)
 if not u then
  if node.Q:Value()and self:Weapon()=='rocket'and self:Ready(_Q)and self:NoEnemyNear()then
   return self:Switch('minigun',Core:ModeContext(mode),function()return node.Q:Value()and self:NoEnemyNear()end)
  end
  return
 end
 local context=Core:ModeContext(mode);local permission=function()return self:Mana(node.Mana)end
 if self:WChainE(mode)then return true end
 if node.E:Value()and self:Ready(_E)and self:Trap(u,context,function()return node.E:Value()and permission()end)then return true end
 if node.Q:Value()and self:Ready(_Q)then local desired=self:DesiredWeapon(u)
  if desired and self:Switch(desired,context,function()return node.Q:Value()and permission()and self:Current(u)and self:DesiredWeapon(u)==desired end)then return true end
 end
 -- A spell shield takes a non-lethal W (a lethal W is refused by the shared kill rule anyway).
 local function wFits()return self:WUseful(u)and Core:SpellShielded(u)==false end
 if node.W:Value()and self:Ready(_W)and wFits()then return self:CastW(u,context,function()return node.W:Value()and permission()and wFits()end)end
end
-- Harass while lane clearing (toggle, off): W on a champion out of reach or killable, never under an enemy turret.
function JinxChampion:FarmHarass()
 if not Menu.Clear.SpellHarass:Value()or not Core:FarmModeEnabled('lane')or IsUnderTurret(myHero)then return false end
 local node=Menu.Harass
 if not node.W:Value()or not self:Ready(_W)or not self:Mana(node.Mana)then return false end
 local u=self:Target(1450);if not u then return false end
 local function permission()return Menu.Clear.SpellHarass:Value()and node.W:Value()and not IsUnderTurret(myHero)and self:Mana(node.Mana)
  and self:WUseful(u)and Core:SpellShielded(u)==false end
 if not permission()then return false end
 return self:CastW(u,Core:ModeContext('LaneClear',permission),permission)
end
function JinxChampion:Combo()return self:Combat('Combo')end
function JinxChampion:Harass()return self:Combat('Harass')end
function JinxChampion:Farm(kind)
 local node=kind=='lane'and Menu.Clear.LaneClear or Menu.Clear.JungleClear
 if not Menu.Clear.SpellFarm:Value()then return end
 if not self:Mana(node.Mana)then
  if node.Q:Value()and self:Weapon()=='rocket'then return self:Switch('minigun',Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end),function()return node.Q:Value()and Menu.Clear.SpellFarm:Value()and not self:Mana(node.Mana)end)end
  return
 end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end);local rows=self:Rows(kind,1450);local u=rows[1]
 local hint=_G.SDK.Orbwalker:GetTarget();if self:Current(hint)and hint.type==Obj_AI_Minion and(kind=='jungle')==(hint.team==300)then u=hint end
 if not u then return end;local permission=function()return Menu.Clear.SpellFarm:Value()and self:Mana(node.Mana)end
 if node.Q:Value()and self:Ready(_Q)then local desired=self:DesiredWeapon(u,kind)
  if desired and self:Switch(desired,context,function()return node.Q:Value()and permission()and self:Current(u)and self:DesiredWeapon(u,kind)==desired end)then return true end
 end
 if node.W:Value()and self:Ready(_W)then
  if kind=='jungle'then
   -- Not on a small monster and not on one a few attacks from death.
   local big;for _,v in ipairs(rows)do if not self:SmallMonster(v,rows)and v.health>myHero.totalDamage*3 and(not big or v.maxHealth>big.maxHealth)then big=v end end
   u=big;if not u then return end
  end
  return self:CastW(u,context,function()return node.W:Value()and permission()end)
 end
end
function JinxChampion:LaneClear()return self:Farm('lane')end
function JinxChampion:JungleClear()return self:Farm('jungle')end
function JinxChampion:Rescue(u)
 if not self:Current(u)or u.team==300 or GetDistance(u.pos,myHero.pos)>1450 then return false end
 local delay=self:WDelay();if not delay or not Core:Rescue(u,delay+GetDistance(u.pos,myHero.pos)/3300,self:Damage(u,_W),spellOnly)then return false end
 -- A ready attack in reach always takes the last hit.
 return not(_G.SDK.Orbwalker:CanAttack()and GetDistance(u.pos,myHero.pos)<=myHero.range+myHero.boundingRadius+(u.boundingRadius or 0))
end
function JinxChampion:Collateral(u)
 if not self:Current(u)then return true end
 for _,v in ipairs(self:Rows('lane',1500))do if id(v)~=id(u)and GetDistance(v.pos,u.pos)<=250 then return true end end
 return false
end
function JinxChampion:LastHit()
 if Menu.LastHit.Q:Value()and self:Weapon()=='rocket'and self:Ready(_Q)then
  return self:Switch('minigun',Core:ModeContext('LastHit'),function()return Menu.LastHit.Q:Value()end)
 end
 if not self:Mana(Menu.LastHit.Mana)then return end
 if Menu.LastHit.W:Value()and self:Ready(_W)then for _,u in ipairs(self:Rows('lane',1450))do
  if self:Rescue(u)then return self:CastW(u,Core:RescueContext(),function()return Menu.LastHit.W:Value()and self:Mana(Menu.LastHit.Mana)and self:Rescue(u)end)end
 end end
end
function JinxChampion:Flee()
 local u=self:Target(1450);if not u then return end
 if Menu.Misc.FleeE:Value()and self:Ready(_E)then
  if self:Trap(u,Core:ModeContext('Flee'),function()return Menu.Misc.FleeE:Value()end)then return true end
  -- A pursuer close behind: chompers on the line between you, so they arm in its path.
  local distance=GetDistance(u.pos,myHero.pos)
  if distance<=600 and distance>150 then local spot=myHero.pos:Extended(u.pos,150)
   if self:CastE(spot,Core:ModeContext('Flee'),function()return Menu.Misc.FleeE:Value()and self:Current(u)and GetDistance(u.pos,spot)<=700 end)then return true end
  end
 end
 if Menu.Misc.FleeW:Value()and self:Ready(_W)then return self:CastW(u,Core:ModeContext('Flee'),function()return Menu.Misc.FleeW:Value()end)end
end
function JinxChampion:OnPostAttack(args)
 if not Core:InputAvailable()then return end;local witness=Core:AttackWitness(self.attackWitness,args and args.Target)
 if witness and witness~=self.attackWitness then self.attackWitness=witness end
end
function JinxChampion:OnPreAttack(args)
 if not Core:InputAvailable()or not args or not args.Target then return end
 -- This only denies an automated collateral attack; it does not count a shot,
 -- mutate ammo/stacks, or intercept physical player input.
 if GetMode()=='LastHit'and Menu.LastHit.Q:Value()and self:Weapon()=='rocket'and args.Target.type==Obj_AI_Minion
  and args.Target.team~=300 and self:Collateral(args.Target)then args.Process=false end
end
-- R bind target: the selected champion, else the enemy nearest the cursor within 400, else the target selector's.
function JinxChampion:RAssistTarget()
 local range=Menu.Misc.RMax:Value();local u=_G.SDK.TargetSelector.Selected
 if self:Current(u)and GetDistance(u.pos,myHero.pos)<=range then return u end
 local best,bestD=nil,400
 for _,v in ipairs(self:Rows('heroes',range))do local d=GetDistance(v.pos,mousePos);if d<=bestD then best,bestD=v,d end end
 return best or self:Target(range)
end
function JinxChampion:Assist()
 local held=Menu.Misc.RAssist:Value()
 if held then local u=self:RAssistTarget()
  if u and self:CastR(u,{held=function()return Menu.Misc.RAssist:Value()end,priority='interactive'},function()return Menu.Misc.RAssist:Value()end,true)then return true end
 end
 local ks=Menu.Misc.KillSecure:Value();local context={priority='interactive'};local function allowed()return Menu.Misc.KillSecure:Value()end
 -- The W finisher comes before any automatic R.
 if ks and self:Ready(_W)then
  for _,u in ipairs(self:Rows('heroes',1450))do local function lethalW()return self:LethalW(u)end
   if lethalW()and self:CastW(u,context,function()return allowed()and lethalW()end)then return true end
  end
 end
 if not held and GetMode()=='Combo'and Menu.Combo.R:Value()and self:Mana(Menu.Combo.Mana)then local u=self:Target(Menu.Misc.RMax:Value())
  if u and self:CastR(u,Core:ModeContext('Combo'),function()return Menu.Combo.R:Value()and self:Mana(Menu.Combo.Mana)end,false)then return true end
 end
 if ks and self:Ready(_R)then
  for _,u in ipairs(self:Rows('heroes',Menu.Misc.RMax:Value()))do
   -- Cheap gate: the rocket's minimum-distance damage must already kill before any path is planned.
   if self:Damage(u,_R,0)>=u.health+(u.shieldAD or 0)and self:CastR(u,context,allowed,'kill')then return true end
  end
 end
 if self:Steal()then return true end
 if Menu.Misc.WAssist:Value()then local u=self:Target(1450)
  if u and self:CastW(u,{held=function()return Menu.Misc.WAssist:Value()end,priority='interactive'},function()return Menu.Misc.WAssist:Value()end)then return true end
 end
end
function JinxChampion:Tick()
 if not Core:InputAvailable()or ShouldWait()then self.preview=nil;return end
 self:MaintainWeapon();self:MaintainTraps();if Core.logger then self:TraceEvidence()end;if IsCasting()then return end;if Core:RecallBaseCast(self.recallCast)or self:Assist()or self:DashE()or self:PeelE()or self:ZoneE()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')and(self:FarmHarass()or self:StructureWeapon())then return end;if Core:FarmModeEnabled('lane')then self:LaneClear()end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and Menu.Draw.Preview:Value()and(not self.nextPreview or self.nextPreview<Game.Timer())then self:PreparePreview()end
end
-- Prepared (150 ms job): weapon reach and R kill marks from a fresh R plan for at most five enemies. No weapon,
-- stack or Get Excited text: the game shows them. Kept for a second so a late preparation never blinks it; Draw
-- reads this table and checks readiness and that each enemy lives.
function JinxChampion:PreparePreview()
 local now=Game.Timer();local kills={}
 if self:Ready(_R)then
  for _,u in ipairs(self:Rows('heroes',Menu.Misc.RMax:Value()))do if #kills>=5 then break end
   if GetDistance(u.pos,myHero.pos)>=700 then local aim=self:Predict(u,_R);local plan=aim and self:RPlan(aim,u)
    if plan and self:RLethal(u,plan)then kills[#kills+1]={unit=u,handle=u.handle}end
   end
  end
 end
 local base,rocket=self:Ranges(nil)
 self.preview={expires=now+1,kills=kills,weapon=self:Weapon(),base=base,rocket=rocket}
 self.nextPreview=now+.15
end
function JinxChampion:Draw()
 if myHero.dead then return end;local p=self.preview;local fresh=p and p.expires>=Game.Timer()
 if Menu.Draw.Ranges:Value()and fresh then
  if p.weapon=='rocket'and p.rocket then Draw.Circle(myHero.pos,p.rocket,1,Draw.Color(255,255,120,80));if p.base then Draw.Circle(myHero.pos,p.base,1,Draw.Color(150,200,200,200))end
  elseif p.base then Draw.Circle(myHero.pos,p.base,1,Draw.Color(255,200,200,200))end
  if IsReady(_W)then Draw.Circle(myHero.pos,self.profile.wRange,1,Draw.Color(255,160,200,255))end
  if IsReady(_E)then Draw.Circle(myHero.pos,self.profile.eRange,1,Draw.Color(255,255,180,100))end
 end
 if Menu.Draw.Preview:Value()and fresh and IsReady(_R)then
  for _,k in ipairs(p.kills or {})do local u=k.unit
   if u and u.handle==k.handle and u.pos2D and u.visible~=false and not u.dead then Draw.Text('R kills',16,u.pos2D.x-25,u.pos2D.y-60,Draw.Color(255,255,70,70))end
  end
 end
end
function JinxChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Jinx: weapons and farming','Jinx: control and rocket'},function(page)
  return {title=page==1 and 'Weapon decisions'or 'First champion contact',cards=page==1 and {
   {'WEAPONS','Range uses actual weapon buff, native attack range and rank bonus. Single nearby targets favor minigun speed. Rockets require mana after the next attack.'},
   {'STACKS','Ramp counts require your own current buff. PreAttack is permission only; native completed attacks supply weaving evidence.'},
   {'FARM','Enable spell farming and distinct Lane/Jungle binds. LastHit returns to minigun and refuses rocket collateral; W rescues otherwise missed CS.'}}or {
   {'CONTROL','W waits for the native attack windup and rechecks outgoing blockers; a non-lethal W skips spell shields. E needs control through travel plus arming, or follows a W that slowed the target. Without a mode key E is also placed under enemies in stasis, reviving, channelling or arriving by teleport, on the end of a dash onto you and between you and a melee attacker. Flee drops E between you and a close pursuer.'},
   {'MINIGUN','With rockets out and no enemy champion within 1500 the minigun comes back; turrets, inhibitors and the nexus are attacked with the minigun when it reaches. Jungle W goes on the big monster.'},
   {'ROCKET','The R bind casts at the selected target, else the enemy nearest the cursor; Combo R needs a kill or several enemies in the blast, and a lethal W or R is also cast without a mode key, but never when W or the next two attacks already kill. The first champion on the path sets the explosion; off-screen aims are cast toward their direction. The W bind casts W at the selected target. An optional switch steals Baron, Dragon or Herald with R.'},
   {'EVIDENCE','A sent E is not an armed trap. Missing weapon or timing data disables only dependent actions. Unknown input is never blindly replayed.'}},
   note='Normal-only candidate. Long-range travel, native trap fields and live timing retain separate acceptance.'}
 end)
end
Core:StandardPolicy(JinxChampion,{damageTypes={W='physical',R='physical'},channel=false,
 -- Native Q readiness owns the free switch; asset mana20 is paid per rocket.
 costPaid=function(self,q,slot)return slot==_Q and q.owner=='WeaponSwitch'and self:Ready(_Q)end})
JinxChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={}
local normalSupported={["Jinx"]=true}

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
