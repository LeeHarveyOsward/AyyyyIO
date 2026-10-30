return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Zed"]=function()return _G.OrbamaFamily:Require("71a31e470e4fead48be954df339915b00bd8625966173a24ba573646dff6526b")()end
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
if champion=="Zed" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Zed',profiles={normal=true,classic=false},
 Create=function(context)
-- Installed Normal kit. Shadows, cast receipts, marks and damage are separate witnesses.
local profiles=ChampionProfiles('Zed')
local finite,id,point=Core.finite,Core.id,Core.point
local function live(u)return u and IsValid(u)and u.pos and finite(u.pos.x)and finite(u.pos.z)end
local function expiry(b)local n=Core.buffExpiry(b);return finite(n)and n or nil end
local function own(b)
 local known=false;for _,k in ipairs({'source','sourceID','sourcenID','owner','ownerID'})do local n=b and b[k]
  if n~=nil and n~=0 then if type(n)=='table'or type(n)=='userdata'then n=id(n)end;if n~=myHero.networkID and n~=myHero.handle then return false end;known=true end
 end;return known
end
local spellOnly={attack=false} -- Core:Rescue: the attack is weighed here, by the rule this champion's regressions pin
local function line(a,b,p,r)
 local dx,dz=b.x-a.x,b.z-a.z;local length=dx*dx+dz*dz;if length<1 then return false end
 local t=((p.x-a.x)*dx+(p.z-a.z)*dz)/length;if t<0 or t>1 then return false end
 return (p.x-a.x-t*dx)^2+(p.z-a.z-t*dz)^2<=r*r,t
end
local ZedChampion=class("ZedChampion")
function ZedChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.issued={};self.shadows={};self.searches={};self.gestures={};self:LoadMenu();self.allow=Core:TargetConsent(Menu.Misc.Targets,self,'','Enemy');self.targets=self.allow.targets;self:DiscoverTargets()
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=self.profile.qDelay,Radius=self.profile.qRadius,Range=self.profile.qRange,Speed=self.profile.qSpeed,Collision=false}
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 Core:RegisterCleanup('Zed',function()self.issued={};self.shadows={};self.searches={};self.mark=nil;self.preview=nil;self.follow=nil;self.gestures={};self.markEnded=nil;self.eTrace=nil end)
 local yes,why=Core:RegisterPreparation('Zed.shadow',{intervalMs=35,maxDelayMs=150,units=1,maxUnits=1},function()return self:DiscoverShadows()end,
  function()return next(self.searches)~=nil end,function()self.searchIndex=1 end);self.shadowFallback=not yes and why=='unsupported'
 yes,why=Core:RegisterPreparation('Zed.preview',{intervalMs=150,maxDelayMs=450,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end);self.previewFallback=not yes and why=='unsupported'
 self:RegisterEvade()
 -- Health-bar damage: ready Q and E (single hit each) and one attack.
 Core:RegisterComboDamage(function(u)
  local total=_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0
  if self:Ready(_Q)then total=total+self:Damage(_Q,u)end
  if self:Ready(_E)then total=total+self:Damage(_E,u)end
  return total,true
 end)
end
-- Death Mark makes Zed untargetable for its whole delay and dash. Evade may use it as a dodge, but an ultimate is
-- only spent that way against a hit that would kill, or on the champion the Combo would mark for a kill anyway.
-- The landing is behind the target: never under an enemy turret unless the alternative is dying.
function ZedChampion:EvadeRLanding(u)
 local d=GetDistance(u.pos,myHero.pos);if d<1 then return nil end
 return myHero.pos:Extended(u.pos,d+self.profile.rBehind)
end
function ZedChampion:EvadeRAllowed(u,request)
 local lethal=request and request.lethal==true
 local combo=GetMode()=='Combo'and Menu.Combo.R:Value()
 if u==nil then return lethal or combo,'ultimate_kept'end
 if not self:Allowed(u)or u.type~=Obj_AI_Hero then return false,'target_policy'end
 if not lethal and not(combo and self:RKills(u))then return false,'ultimate_kept'end
 local landing=self:EvadeRLanding(u);if not landing then return false,'landing_unknown'end
 if not lethal and IsUnderTurret2(landing)then return false,'enemy_turret'end
 return true
end
function ZedChampion:EvadeRTargets(request)
 local rows={};local list=self:Rows('hero',self.profile.rRange)
 for i=1,math.min(#list,5)do local u=list[i]
  if self:EvadeRAllowed(u,request)then local landing=self:EvadeRLanding(u)
   rows[#rows+1]={unit=u,id=id(u),position=point(u.pos),landings={landing}}
  end
 end
 return rows
end
function ZedChampion:RegisterEvade()
 local p=self.profile;if not p.rEvadeSource or not Core.RegisterMobility then return end
 self.mobilityOffered,self.mobilityReason=Core:RegisterMobility({kind='untargetable',slot=_R,key=HK_R,name=p.r,range=p.rRange,landingRange=p.rRange+p.rBehind,
  duration=p.rUntargetable,castDelays={p.rCast},profile=p.id,label='Use Death Mark to dodge (Zed R)',source=p.rEvadeSource,
  targets=function(request)return self:EvadeRTargets(request)end,allowed=function(u,request)return self:EvadeRAllowed(u,request)end})
 self:RegisterSwapOffers()
end
-- Shadow swaps offered to Evade as owned teleports (W2 and R2): a live owned shadow that is safe (no enemy turret,
-- not into the enemy count limit) within swap range, with the recast ready. Evade judges the danger; the landing
-- is re-read from the shadow at dispatch. No offer when the profile lacks a sourced recast cast time.
function ZedChampion:SwapReady(kind)
 local p=self.profile;if not Menu.Misc.EvadeSwap:Value()then return nil end
 local u=self:Shadow(kind);local search=self.searches[kind];local slot=kind=='w'and _W or _R
 if not u or not search or not self:Ready(slot,kind=='w'and p.w2 or p.r2)or GetDistance(u.pos,myHero.pos)>p.wSwapRange or not self:Safe(u.pos,false)then return nil end
 if kind=='r'and(Game.Timer()<search.started+p.rUntargetable+p.rRecast or Game.Timer()>search.expires-p.r2Tail)then return nil end
 return u
end
function ZedChampion:RegisterSwapOffers()
 local p=self.profile;self.swapOffers={}
 if not Core.RegisterEffect then return end
 for _,row in ipairs({{kind='w',slot=_W,key=HK_W,spell=p.w2,delay=p.w2Cast,source=p.w2CastSource},{kind='r',slot=_R,key=HK_R,spell=p.r2,delay=p.r2Cast,source=p.r2CastSource,ultimate=true}})do
  local kind=row.kind
  if finite(row.delay)and row.delay>=0 and type(row.source)=='string'and row.source~=''and(kind~='r'or finite(p.r2Tail))then
   self.swapOffers[kind]=Core:RegisterEffect({kind='owned_teleport',name='ZedShadowSwap'..kind:upper(),slot=row.slot,key=row.key,spell=row.spell,profile=p.id,
    source=row.source,delay=row.delay,ultimate=row.ultimate,ready=function()return self:SwapReady(kind)~=nil end,
    destinations=function()local u=self:SwapReady(kind);if not u then return {}end;return {{id=kind..':'..tostring(id(u)),position=point(u.pos)}}end})==true
  end
 end
 -- No live shadow to swap to: Evade may place one with W at a point it picks and swap with W2 once the shadow is
 -- seen there. Evade judges it as a blink landing after W + travel (distance/2500) + discovery + W2.
 if finite(p.wCast)and finite(p.wSpeed)and finite(p.wObserve)and finite(p.w2Cast)and type(p.wPlaceSource)=='string'then
  self.placeOffer=Core:RegisterEffect({kind='owned_teleport',name='ZedShadowPlace',slot=_W,key=HK_W,spell=p.w,profile=p.id,source=p.wPlaceSource,delay=p.wCast,
   -- Validating its own unsent W keeps that W ready; any other W in flight does not.
   ready=function()local row=self.issued[_W];return self:PlaceReady(row~=nil and row.q.owner=='evade_defense')end,
   place={range=p.wRange,minRange=p.wMin,speed=p.wSpeed,recastDelay=p.w2Cast,observe=p.wObserve,
    aim=function(at)return self:PlaceAim(at)end,
    submit=function(aim,valid,request)return self:PlaceW(aim,valid,request)end,
    arrived=function(at)local u=self:Shadow('w');return u~=nil and GetDistance(u.pos,at)<=100 end,
    recast=function(valid)return self:Swap('w',{priority='critical'},valid,false)end}})==true
 end
end
-- W1 for the Evade dodge: only with the switch, W (not W2) ready and no shadow Evade could already swap to.
function ZedChampion:PlaceReady(validation)
 return Menu.Misc.EvadeSwap:Value()and self:Ready(_W,nil,validation)and not self.searches.w and not self:Shadow('w')and not self:SwapReady('w')and not self:SwapReady('r')
end
function ZedChampion:PlaceAim(at)
 local d=GetDistance(myHero.pos,at);if d<1 then return nil end
 local q=myHero.pos:Extended(at,math.max(self.profile.wMin,math.min(d,self.profile.wRange)))
 return self:Safe(q,false)and q or nil
end
function ZedChampion:PlaceW(aim,valid,request)
 if not self:PlaceReady()then return false end
 local witness={}
 local ok=self:Submit(_W,HK_W,aim,{owner=request.owner,priority='critical',ttl=request.ttl,independent=false,evadeCompatible=request.evadeCompatible,range=self.profile.wRange+1,
  validate=function()return valid()end,
  observe=function(q)local a=not q.ambiguous and Core:NativeCast(q,self.profile.w);local e=a and point(a.endPos or a.placementPos)
   if not e or GetDistance(e,q.target)>100 then return false end;witness.started=a.startTime;witness.anchor=e;return true end})
 if ok then Core:AfterCast(HK_W,function()self.searches.w={observed=true,started=witness.started,anchor=witness.anchor,expires=witness.started+self.profile.wDuration};self.shadows.w=nil;self.searchIndex=1 end)end
 return ok
end
function ZedChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_Zed',name='AyyyyIO - Zed'})
 for _,mode in ipairs({'Combo','Harass'})do Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','E','W'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot..(slot=='W'and' (place a shadow)'or''),value=true})end
  if mode=='Combo'then Menu.Combo:MenuElement({id='Swap',name='Swap to the W shadow to reach the target',value=true});Menu.Combo:MenuElement({id='R',name='Use R when the full combo can kill',value=true})
   Menu.Combo:MenuElement({id='TurretR',name='Allow that R under a turret attacking an ally',value=false})end
  Menu[mode]:MenuElement({id='Mana',name='Only above energy %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5,menu=mode~='Combo'})
 end
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'});Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do Menu.Clear:MenuElement({type=MENU,id=kind,name=kind});for _,slot in ipairs({'Q','E'})do Menu.Clear[kind]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu.Clear[kind]:MenuElement({id='W',name='Use W (place a shadow) when Q and E are ready',value=kind=='JungleClear'})
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above energy %',value=20,min=0,max=100,step=5})end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions an ability must hit',value=3,min=1,max=8,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'});Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true});Menu.LastHit:MenuElement({id='E',name='Use E on a lone minion an attack cannot take',value=true});Menu.LastHit:MenuElement({id='Mana',name='Only above energy %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('T')});Menu.Misc:MenuElement({id='ReturnAssist',name='Swap back to your safest shadow',key=string.byte('U')})
 Menu.Misc:MenuElement({id='EngageHP',name='Never dash in below health %',value=30,min=5,max=100,step=5});Menu.Misc:MenuElement({id='Enemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='ReturnHP',name='Swap to a safer shadow when low on health',value=true});Menu.Misc:MenuElement({id='HP',name='Low means below health %',value=25,min=5,max=100,step=5,menu=false})
 Menu.Misc:MenuElement({id='KillSecure',name='Finish killable enemies without a mode key',value=true})
 Menu.Misc:MenuElement({id='AutoE',name='Use E automatically on enemy champions in reach',value=true})
 Menu.Misc:MenuElement({id='MarkReturn',name='Swap back after Death Mark when a shadow is safer',value=true,menu=false})
 Menu.Misc:MenuElement({id='EvadeSwap',name='Let Evade dodge with shadow swaps',value=true})
 Menu.Misc:MenuElement({id='FleeW',name='Use W and shadow swaps when fleeing',value=true});Menu.Misc:MenuElement({id='FleeE',name='Use E to slow pursuers when fleeing',value=true})
 Menu.Misc:MenuElement({type=MENU,id='Targets',name='Enemy champions abilities may target'})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'});Menu.Draw:MenuElement({id='Preview',name='Shadows, swap range and kill marks',value=true})
end
function ZedChampion:Current(u)
 if not live(u)then return false end
 local method=u.type==Obj_AI_Hero and'GetEnemyHeroes'or u.team==300 and'GetMonsters'or'GetEnemyMinions'
 local rows=Core:DecisionUnits(method)
 if Core.evaluation and not Core.validating then
  local index=Core:DecisionValue('Zed.membership.'..method,function()
   local result={};for i=1,math.min(#rows,512)do local v=rows[i];local key=id(v)
    if key~=nil and result[key]==nil then result[key]={object=v,networkID=v.networkID,handle=v.handle}end
   end;return result
  end)
  local row=index[id(u)];return row~=nil and row.object==u and row.networkID==u.networkID and row.handle==u.handle
 end
 for i=1,math.min(#rows,512)do local v=rows[i];if id(v)==id(u)then return v==u and v.handle==u.handle end end;return false
end
function ZedChampion:Rows(kind,range,qualify)
 local raw=Core:DecisionUnits(kind=='hero'and'GetEnemyHeroes'or kind=='jungle'and'GetMonsters'or'GetEnemyMinions');local rows,seen={},{};local members=qualify and{}
 -- Map-wide unordered list: scan beyond the row cap so nearby units and blockers are not skipped.
 local cap=kind=='hero'and 5 or 32
 for i=1,math.min(#raw,512)do if not qualify and #rows>=cap then break end;local u=raw[i];local key=id(u)
  if qualify then
   -- This roster is consumed synchronously by one ray, after its collision call.
   -- An invalid first wrapper still rejects a later duplicate of its identity.
   if key~=nil and not seen[key]then seen[key]=true
    if live(u)and GetDistance(u.pos,myHero.pos)<=range then rows[#rows+1]=u;members[u]={object=u,id=key,handle=u.handle,type=u.type,team=u.team}end
   end
  elseif key~=nil and not seen[key]and live(u)and GetDistance(u.pos,myHero.pos)<=range and self:Current(u)then rows[#rows+1]=u;seen[key]=true end
 end;return rows,members
end
-- A champion the roster has not listed yet is allowed; only a switched-off entry refuses.
function ZedChampion:Allowed(u)return self:Current(u)and(u.type~=Obj_AI_Hero or not self.targets[id(u)]or self.targets[id(u)]:Value())end
function ZedChampion:DiscoverTargets()self.allow:Refresh()end
function ZedChampion:Target(range)
 local selected=_G.SDK.TargetSelector.Selected;if self:Allowed(selected)and GetDistance(selected.pos,myHero.pos)<=range then return selected end
 local rows=self:Rows('hero',range);for i=#rows,1,-1 do if not self:Allowed(rows[i])then table.remove(rows,i)end end
 return _G.SDK.TargetSelector:GetTarget(rows,_G.SDK.DAMAGE_TYPE_PHYSICAL)
end
-- An own buff that is still active `delay` seconds from now.
function ZedChampion:Buff(u,name,delay)
 local b=u and u.GetBuff and Core:OwnBuff(u,name,true);return b and expiry(b)>Game.Timer()+(delay or 0)and b or nil
end
function ZedChampion:Ready(slot,name,validation)
 local d=myHero:GetSpellData(slot);name=name or({[0]=self.profile.q,[1]=self.profile.w,[2]=self.profile.e,[3]=self.profile.r})[slot]
 if not d or d.name~=name or not finite(d.level)or d.level%1~=0 or d.level<1 or d.level>(slot==_R and 3 or 5)or not finite(d.currentCd)or d.currentCd>0 or Game.CanUseSpell(slot)~=0 then return false end
 local free=name==self.profile.w2 and self:Shadow('w')or name==self.profile.r2 and self:Shadow('r')
 if not finite(myHero.mana)or not free and(not finite(d.mana)or d.mana<0 or myHero.mana<d.mana)then return false end
 local row=self.issued[slot];return not row or validation and not row.uncertain
end
-- An enemy turret whose current target is an allied champion or minion, while Zed survives one of its shots.
function ZedChampion:TurretOnAlly(t)
 local target=t.targetID;if not finite(target)or target==0 or target==myHero.networkID or target==myHero.handle then return false end
 local found=false
 for _,method in ipairs({'GetAllyHeroes','GetAllyMinions'})do local list=_G.SDK.ObjectManager[method]and _G.SDK.ObjectManager[method](_G.SDK.ObjectManager)or {}
  for i=1,math.min(#list,48)do local u=list[i];if u and u~=myHero and(u.networkID==target or u.handle==target)and IsValid(u)then found=true;break end end
  if found then break end
 end
 if not found or not finite(t.totalDamage)or not finite(myHero.health)then return false end
 return myHero.health>_G.SDK.Damage:CalculateDamage(t,myHero,_G.SDK.DAMAGE_TYPE_PHYSICAL,t.totalDamage)
end
function ZedChampion:Safe(p,offensive,dive)
 if not point(p)or not Game.isWall or Game.isWall(p)~=false then return false end
 if offensive and(not finite(myHero.health)or not finite(myHero.maxHealth)or myHero.maxHealth<=0 or myHero.health/myHero.maxHealth*100<Menu.Misc.EngageHP:Value())then return false end
 for _,t in ipairs(_G.SDK.ObjectManager:GetEnemyTurrets(2500))do if IsValid(t)and GetDistance(t.pos,p)<775+(t.boundingRadius or 0)+(myHero.boundingRadius or 0)and not(dive and self:TurretOnAlly(t))then return false end end
 local n=0;for _,u in ipairs(self:Rows('hero',3000))do if GetDistance(u.pos,p)<600 then n=n+1 end end;return n<=Menu.Misc.Enemies:Value()
end
function ZedChampion:Project(u,t,member)
 if member then
  if member.object~=u or member.id~=id(u)or member.handle~=u.handle or member.type~=u.type or member.team~=u.team or not live(u)then return nil end
 elseif not self:Current(u)then return nil end;local p=u.pathing
 local function compute()
  if p and p.hasMovePath and point(p.endPos)and finite(u.ms)and u.ms>=0 then return u.pos:Extended(p.endPos,math.min(GetDistance(u.pos,p.endPos),u.ms*t))end;return point(u.pos)
 end
 if not Core.evaluation or Core.validating then return compute()end
 local cache=Core:DecisionValue('Zed.projections',function()return {}end)
 local endPos=p and p.endPos;local row=cache[u]
 local x,y,z=u.pos.x,u.pos.y or 0,u.pos.z;local moving=p and p.hasMovePath;local ex,ey,ez=endPos and endPos.x,endPos and endPos.y,endPos and endPos.z
 if not row or row.x~=x or row.y~=y or row.z~=z or row.ms~=u.ms or row.moving~=moving or row.ex~=ex or row.ey~=ey or row.ez~=ez then
  row={x=x,y=y,z=z,ms=u.ms,moving=moving,ex=ex,ey=ey,ez=ez,points={}};cache[u]=row
 end
 local result=row.points[t];if not result then result=compute();if result then row.points[t]={x=result.x,y=result.y,z=result.z}end end
 return result and Vector(result.x,result.y or 0,result.z)or nil -- Never lend the private memo to a caller.
end
function ZedChampion:Shadow(kind)
 local row=self.shadows[kind];local s=self.searches[kind];if not row or not s or not Game.Minion or Game.Timer()>=s.expires then return nil end
 local u=Game.Minion(row.index)
 if u~=row.object or id(u)~=row.id or u.handle~=row.handle or not self:ShadowEligible(u,s)then self.shadows[kind]=nil;return nil end;return u
end
function ZedChampion:ShadowEligible(u,s)
 local birth=u and(u.spawnTime or u.creationTime)
 return s and s.observed and s.expires>Game.Timer()and u and u.valid and not u.dead and u.team==myHero.team and u.type==Obj_AI_Minion and own(u)
  and u.isClone==true and(u.charName=='ZedShadow'or u.charName==myHero.charName)and point(u.pos)and id(u)and finite(birth)and birth>=s.started-.05 and birth<=Game.Timer()and birth<=s.started+.8
end
function ZedChampion:DiscoverShadows()
 for kind,s in pairs(self.searches)do if s.expires<=Game.Timer()then self.searches[kind]=nil;self.shadows[kind]=nil end end
 if not next(self.searches)or not Game.MinionCount or not Game.Minion then return true end
 local n=Game.MinionCount();if not finite(n)or n<1 then return true end;n=math.min(n,512);self.searchIndex=self.searchIndex or 1
 for _=1,math.min(n,24)do if self.searchIndex>n then self.searchIndex=1 end;local index=self.searchIndex;self.searchIndex=index+1;local u=Game.Minion(index)
  local kind,best,matches=nil,nil,0;for k,s in pairs(self.searches)do if not self:Shadow(k)and self:ShadowEligible(u,s)then
   local d=GetDistance(u.pos,s.anchor);if d<=100 then matches=matches+1;if not best or d<best then kind=k;best=d end end end end
  if matches>1 then kind=nil end -- Overlapping generation/anchor evidence cannot distinguish W from R.
  if kind then local other=kind=='w'and'r'or'w';local known=self.shadows[other]
   if not known or known.id~=id(u)then self.shadows[kind]={object=u,index=index,id=id(u),handle=u.handle}end end
 end;return true
end
function ZedChampion:Origins()
 local rows={myHero};local seen={[id(myHero)]=true};for _,kind in ipairs({'w','r'})do local u=self:Shadow(kind);if u and not seen[id(u)]then rows[#rows+1]=u;seen[id(u)]=true end end;return rows
end
function ZedChampion:Damage(slot,u,scale)
 local p=self.profile;local d=myHero:GetSpellData(slot);local base=slot==_Q and p.qBase[d.level]or slot==_E and p.eBase[d.level]
 if not base or not finite(myHero.bonusDamage)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,(base+(slot==_Q and p.qAD or p.eAD)*myHero.bonusDamage)*(scale or 1))
end
function ZedChampion:PassiveDamage(u)
 local p=self.profile;local lvl=myHero.levelData and myHero.levelData.lvl
 if not self:Current(u)or not finite(lvl)or lvl%1~=0 or lvl<1 or lvl>18 or not finite(u.maxHealth)or not finite(u.health)or u.health>=u.maxHealth*p.passiveThreshold or self:Buff(u,p.passiveCD)then return 0 end
 local ratio=p.passiveRatios[lvl>=p.passiveLevels[3]and 3 or lvl>=p.passiveLevels[2]and 2 or 1];local raw=ratio*u.maxHealth
 if u.team==300 then raw=math.min(raw*p.monsterMod,p.monsterCap)end -- Lower bound: cap all camps when epic classification is unknown.
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
function ZedChampion:Ray(u,origin,aim,target)
 local p=self.profile;if GetDistance(origin.pos,aim)<1 then return nil end;local finish=origin.pos:Extended(aim,p.qRange)
 local pos=target or self:Project(u,p.qDelay+GetDistance(origin.pos,u.pos)/p.qSpeed);if not pos then return nil end
 local hit,t=line(origin.pos,finish,pos,p.qRadius+(u.boundingRadius or 0));if not hit then return nil end
 local wall,_,count=OrbamaPrediction:GetCollision(origin.pos,finish,p.qSpeed,p.qDelay,p.qBlockRadius,{OrbamaPrediction.COLLISION_YASUOWALL},id(u))
 if wall~=false or not finite(count)or count~=0 then return nil end
 local before=false;local collateral=0;for _,kind in ipairs({'hero','lane','jungle'})do local rows,members=self:Rows(kind,3100,true);for _,v in ipairs(rows)do if id(v)~=id(u)then
  local future=self:Project(v,p.qDelay+GetDistance(origin.pos,v.pos)/p.qSpeed,members[v]);if future then local yes,vt=line(origin.pos,finish,future,p.qBlockRadius+(v.boundingRadius or 0));if yes then collateral=collateral+1;if vt<t then before=true end end end
 end end end
 return{origin=origin,endpoint=point(finish),impact=p.qDelay+GetDistance(origin.pos,pos)/p.qSpeed,damage=self:Damage(_Q,u,before and p.qPass or 1),blocked=before,collateral=collateral}
end
function ZedChampion:QPlan(u,validation)
 if not self:Ready(_Q,nil,validation)or not self:Allowed(u)or GetDistance(u.pos,myHero.pos)>2900 then return nil end
 local origins=self:Origins();local pred=Core:Prediction(self.QSpell);local candidates,projected={},{}
 for _,o in ipairs(origins)do if GetDistance(o.pos,u.pos)<=self.profile.qRange then pred:GetPrediction(u,o)
  local pos=point(pred.CastPosition);if pos and pred:CanHit(u.type==Obj_AI_Hero and 3 or 2)then candidates[#candidates+1]=pos;projected[id(o)]=point(pred.UnitPosition)or pos end end end
 if #candidates>1 then local a,b=candidates[1],candidates[2];candidates[#candidates+1]=Vector((a.x+b.x)/2,(a.y+b.y)/2,(a.z+b.z)/2)end
 local best;for _,aim in ipairs(candidates)do if GetDistance(aim,myHero.pos)<=2900 then local rays={};local lower,impact=0,0;local collateral=0
  for _,o in ipairs(origins)do local ray=projected[id(o)]and self:Ray(u,o,aim,projected[id(o)]);if ray then rays[#rays+1]=ray;if ray.damage>lower then lower=ray.damage;impact=ray.impact end;collateral=collateral+ray.collateral end end
  if #rays>0 and(not best or #rays>#best.rays or #rays==#best.rays and lower>best.lower)then best={position=aim,rays=rays,lower=lower,impact=impact,collateral=collateral}end
 end end
 if best and Core.evaluation and not Core.validating then
  best.scope=Core.evaluation;best.victim=u;best.victimID=id(u);best.handle=u.handle;best.at=Game.Timer()
  best.targetPosition=point(u.pos);best.originPositions={};for i,o in ipairs(origins)do best.originPositions[i]={object=o,id=id(o),handle=o.handle,position=point(o.pos)}end
 end;return best
end
-- No collateral, and a ready attack in reach always takes the last hit.
function ZedChampion:Rescue(u,damage,impact,collateral)
 return collateral==0 and Core:Rescue(u,impact,damage,spellOnly)and not(_G.SDK.Data:IsInAutoAttackRange(myHero,u)and _G.SDK.Orbwalker:CanAttack())
end
function ZedChampion:Submit(slot,key,aim,options)
 if self.issued[slot]or not Core:Cast(key,aim,options)then return false end
 self.issued[slot]={q=Core.lastIntent,name=myHero:GetSpellData(slot).name};return true
end
function ZedChampion:MaintainIssued()
 for slot,row in pairs(self.issued)do local q=row.q;local r=Core.adapter:Poll(q.id);local d=myHero:GetSpellData(slot)
  if not q.sentAt and(not r or r.state=='cancelled_before_send')then self.issued[slot]=nil
  else
   if r and(r.state=='send_uncertain'or r.interrupted or r.competitor)then row.uncertain=true end
   if finite(d.currentCd)and d.currentCd>0 then row.cooldownSeen=true end
   if row.cooldownSeen and d.currentCd==0 and Game.CanUseSpell(slot)==0 or q.observedAt and not row.uncertain and d.name~=row.name then self.issued[slot]=nil end
   -- A certain, finished send with no observation and no consumed cooldown cast nothing;
   -- fresh readiness permits a new decision instead of locking the slot for the game.
   if self.issued[slot]and q.sentAt and not q.observedAt and not row.uncertain and not row.cooldownSeen and q.outcome and Core.pending[q.key]~=q
    and finite(d.currentCd)and d.currentCd==0 and Game.CanUseSpell(slot)==0 then self.issued[slot]=nil end
  end
 end
end
function ZedChampion:CastQ(u,context,permission,rescue,prepared)
 if permission and not permission()then return false end
 local plan
 if prepared and prepared.scope and prepared.scope==Core.evaluation and not Core.validating and prepared.victim==u
  and prepared.victimID==id(u)and prepared.handle==u.handle and prepared.at==Game.Timer()and self:Ready(_Q)and self:Allowed(u)
  and GetDistance(prepared.targetPosition,u.pos)==0 then
  local origins=self:Origins();local same=#origins==#prepared.originPositions
  for i,o in ipairs(origins)do local old=prepared.originPositions[i]
   if not old or old.object~=o or old.id~=id(o)or old.handle~=o.handle or GetDistance(old.position,o.pos)~=0 then same=false;break end
  end
  if same then plan=prepared end
 end
 plan=plan or self:QPlan(u);if not plan or rescue and not self:Rescue(u,plan.lower,plan.impact,plan.collateral)then return false end
 local handle=u.handle;local function solve()
  return Core:Fresh(function()
   if u.handle~=handle or permission and not permission()then return nil end
   local fresh=self:QPlan(u,true);if not fresh or rescue and not self:Rescue(u,fresh.lower,fresh.impact,fresh.collateral)then return nil end;return fresh
  end)
 end
 return self:Submit(_Q,HK_Q,plan.position,{owner='JointShuriken',context=context,intentTarget=u,range=2900,independent=false,deferAttackWindup=true,prevalidateWorldCast=true,
  resolve=function()local p=solve();return p and{position=p.position}end,commitGuard=function()return Core:Current()and(not permission or permission())end,
  validate=function(_,r)local p=solve();return p and r and point(r.position)and GetDistance(p.position,r.position)<=5 end,
  observe=function(q)return Core:NativeCast(q,self.profile.q)~=nil end})
end
function ZedChampion:EHits(u)
 if not self:Allowed(u)then return nil end;local pos=self:Project(u,.05);if not pos then return nil end
 local n=0;for _,o in ipairs(self:Origins())do local radius=o==myHero and self.profile.eRadius or self.profile.eShadowRadius;if GetDistance(pos,o.pos)<=radius then n=n+1 end end
 return n>0 and n or nil -- Multiple E origins control slow; damage is never multiplied.
end
function ZedChampion:ECount(kind)
 local n=0;for _,u in ipairs(self:Rows(kind,2900))do if self:EHits(u)then n=n+1 end end;return n
end
function ZedChampion:CastE(u,context,permission,rescue,kind,count)
 if not self:Ready(_E)or not self:EHits(u)or permission and not permission()or count and self:ECount(kind)<count then return false end
 local handle=u.handle;local function legal()return self:Allowed(u)and u.handle==handle and self:EHits(u)and(not permission or permission())and(not count or self:ECount(kind)>=count)
  and(not rescue or self:Rescue(u,self:Damage(_E,u),.05,self:ECount('lane')-1))end
 if not legal()then return false end
 local ok=self:Submit(_E,HK_E,nil,{owner='ShadowSlash',context=context,intentTarget=u,independent=false,validate=legal,observe=function(q)return Core:NativeCast(q,self.profile.e)~=nil end})
 if ok and Core.logger and u.type==Obj_AI_Hero then self.eTrace={q=Core.lastIntent,unit=u,distance=GetDistance(u.pos,myHero.pos),health=u.health,expires=Game.Timer()+1.5}end
 return ok
end
-- Development evidence only: E reach from Zed (asset 290, wiki 315 and 290) by the target's distance at the send and
-- whether its health dropped right after the observed cast. Nothing here authorizes a cast.
function ZedChampion:TraceEvidence()
 local t=self.eTrace;if not t then return end;local now=Game.Timer()
 if now>t.expires or not live(t.unit)then self.eTrace=nil;return end
 if t.q.observedAt and not t.at then t.at=now;t.health=t.unit.health
 elseif t.at and now-t.at>=.25 then
  Core:Trace('zed_e_reach',{distance=t.distance,hit=finite(t.unit.health)and finite(t.health)and t.unit.health<t.health-1,radius=self.profile.eRadius});self.eTrace=nil
 end
end
-- W lands between its minimum and maximum range (asset ZedMarker castRange 325, wiki 325-650).
function ZedChampion:WPosition(pos)
 if not point(pos)or GetDistance(myHero.pos,pos)<50 then return nil end
 local p=myHero.pos:Extended(pos,math.max(self.profile.wMin,math.min(GetDistance(myHero.pos,pos),self.profile.wRange)));return self:Safe(p,false)and p or nil
end
-- opts.follow: nil = E then Q from the shadow, 'q' = Q only (energy W+Q), 'r' = swap to the shadow then Death Mark.
function ZedChampion:CastW(pos,context,permission,target,opts)
 local kind=opts and opts.follow
 local function energy()if kind=='q'then return self:QEnergy(true)end;return self:PostEnergy(true)end
 if not self:Ready(_W)or permission and not permission()or target and not energy()then return false end;local aim=self:WPosition(pos);if not aim then return false end
 local witness={};local handle=target and target.handle
 local function solve()if permission and not permission()or target and(not self:Allowed(target)or target.handle~=handle or not energy())then return nil end
  return self:WPosition(target and target.pos or mousePos)end
 local ok=self:Submit(_W,HK_W,aim,{owner='LivingShadow',context=context,intentTarget=target,independent=false,range=self.profile.wRange+1,
  -- The shadow goes toward the target; the target itself may stand up to a Q length beyond it.
  objectRange=target and self.profile.wRange+self.profile.qRange or nil,prevalidateWorldCast=true,
  resolve=function()local p=solve();return p and{position=p}end,commitGuard=function()return Core:Current()and(not permission or permission())end,
  validate=function(_,r)local p=solve();return p and r and point(r.position)and GetDistance(p,r.position)<=5 end,
  observe=function(q)local a=not q.ambiguous and Core:NativeCast(q,self.profile.w);local p=a and point(a.endPos or a.placementPos)
   if not p or GetDistance(p,q.target)>100 then return false end;witness.started=a.startTime;witness.anchor=p;return true end})
 if ok then Core:AfterCast(HK_W,function()self.searches.w={observed=true,started=witness.started,anchor=witness.anchor,expires=witness.started+self.profile.wDuration};self.shadows.w=nil;self.searchIndex=1
  if target then self.follow={target=target,handle=handle,context=context,permission=permission,kind=kind,expires=Game.Timer()+(kind=='r'and 1.5 or 1)}end end)end;return ok
end
function ZedChampion:QEnergy(w)
 local q=myHero:GetSpellData(_Q);local extra=w and myHero:GetSpellData(_W).mana or 0
 return self:Ready(_Q)and finite(extra)and finite(q.mana)and myHero.mana>=q.mana+extra
end
-- Whether a live origin (Zed or an owned shadow) already reaches the target with Q.
function ZedChampion:QReach(u)
 for _,o in ipairs(self:Origins())do if GetDistance(o.pos,u.pos)<=self.profile.qRange then return true end end
 return false
end
function ZedChampion:PostEnergy(w)
 local q=myHero:GetSpellData(_Q);local e=myHero:GetSpellData(_E);local extra=w and myHero:GetSpellData(_W).mana or 0
 return self:Ready(_Q)and self:Ready(_E)and finite(extra)and finite(q.mana)and finite(e.mana)and myHero.mana>=q.mana+e.mana+extra
end
-- Engagement gate for Combo R, not a guaranteed kill: Q, E and two attacks plus the mark's stored share.
-- Passive damage once the target's health after `dealt` falls below the threshold (own cooldown buff absent).
function ZedChampion:PassiveAfter(u,dealt)
 local p=self.profile;local lvl=myHero.levelData and myHero.levelData.lvl
 if not finite(lvl)or lvl%1~=0 or lvl<1 or lvl>18 or not finite(u.maxHealth)or u.maxHealth<=0 or self:Buff(u,p.passiveCD)then return 0 end
 if u.health-dealt>=u.maxHealth*p.passiveThreshold then return 0 end
 local raw=p.passiveRatios[lvl>=p.passiveLevels[3]and 3 or lvl>=p.passiveLevels[2]and 2 or 1]*u.maxHealth
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
-- Q, E, two attacks and the passive (when Q+E bring the target below half health), amplified by the mark, plus
-- the mark's own share; a ready Ignite the Utils activator may use is added and then also sent (CastR).
function ZedChampion:RKills(u)
 local amp=self.profile.rAmp[myHero:GetSpellData(_R).level];if not amp or not finite(myHero.totalDamage)or not live(u)or not finite(u.health)then return false end
 local physical=_G.SDK.DAMAGE_TYPE_PHYSICAL;local spells=self:Damage(_Q,u)+self:Damage(_E,u)
 local dealt=spells+2*_G.SDK.Damage:CalculateDamage(myHero,u,physical,myHero.totalDamage)
 dealt=dealt+self:PassiveAfter(u,spells)
 local need=u.health+math.max(0,u.shieldAD or 0);local total=dealt*(1+amp)+_G.SDK.Damage:CalculateDamage(myHero,u,physical,myHero.totalDamage*self.profile.rAD)
 if total>=need then return true,false end
 local ignite=Core:IgniteStatus(u)
 if ignite and total+ignite.damage>=need then return true,true end
 return false
end
function ZedChampion:CastR(u,context,permission,dive)
 if not self:Ready(_R)or not permission()or not self:Allowed(u)or u.type~=Obj_AI_Hero or GetDistance(u.pos,myHero.pos)>self.profile.rRange or not self:PostEnergy(false)or not self:Safe(u.pos,true,dive)or not self:Safe(myHero.pos,false)then return false end
 local _,ignite=self:RKills(u)
 local handle=u.handle;local witness={};local ok=self:Submit(_R,HK_R,u,{owner='DeathMark',context=context,independent=false,range=self.profile.rRange,
  validate=function()return permission()and self:Allowed(u)and u.handle==handle and self:PostEnergy(false)and self:Safe(u.pos,true,dive)and self:Safe(myHero.pos,false)end,
  observe=function(q)local a=not q.ambiguous and Core:NativeCast(q,self.profile.r)
   if not a or(a.target~=id(u)and a.target~=handle)then return false end;witness.started=a.startTime;witness.origin=point(a.startPos);return true end})
 if ok then Core:AfterCast(HK_R,function()
  if witness.origin then self.searches.r={observed=true,started=witness.started,anchor=witness.origin,expires=witness.started+self.profile.rDuration};self.shadows.r=nil;self.searchIndex=1 end
  self.mark={target=u,id=id(u),handle=handle,requestedStart=witness.started,seen=false,qualifiedDamage=0,healthLoss=0,context=context,expires=witness.started+self.profile.markDuration+.8}
  -- The kill estimate counted Ignite: it is sent through Utils once the mark is cast.
  if ignite then Core:Ignite(u,'DeathMarkIgnite',function()return self:Allowed(u)and u.handle==handle end)end
 end)end;return ok
end
function ZedChampion:MaintainMark()
 local m=self.mark;if not m then return end
 -- Observed end of a seen mark (target death or the mark buff gone): a swap back may follow (MarkReturn).
 local function ended()if m.seen then self.markEnded={expires=Game.Timer()+2}end;self.mark=nil end
 if m.seen and m.target.handle==m.handle and(m.target.dead==true or finite(m.target.health)and m.target.health<=0)then ended();return end
 if not self:Current(m.target)or m.target.handle~=m.handle or Game.Timer()>=m.expires then if Game.Timer()>=m.expires then ended()else self.mark=nil end;return end
 local b=self:Buff(m.target,self.profile.mark)
 if b and finite(b.startTime)and b.startTime>=m.requestedStart and b.startTime<=Game.Timer()then
  if not m.seen then m.seen=true;m.start=b.startTime;m.expires=expiry(b);m.health=m.target.health end
  if finite(m.health)and finite(m.target.health)then m.healthLoss=m.healthLoss+math.max(0,m.health-m.target.health);m.health=m.target.health end
 elseif m.seen then ended()end
 -- Health loss is visible but not attributable damage. No lethal credit or automatic mark return.
end
function ZedChampion:MarkPreview()
 local m=self.mark;if not m or not m.seen then return nil end
 local rank=myHero:GetSpellData(_R).level;if not self.profile.rAmp[rank]or not finite(myHero.totalDamage)then return nil end
 return {target=m.id,expires=m.expires,qualifiedDamage=m.qualifiedDamage,unattributedHealthLoss=m.healthLoss,
  baseDamage=_G.SDK.Damage:CalculateDamage(myHero,m.target,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage*self.profile.rAD),payoutUnknown=true}
end
function ZedChampion:Swap(kind,context,permission,offensive)
 local u=self:Shadow(kind);local slot=kind=='w'and _W or _R;local name=kind=='w'and self.profile.w2 or self.profile.r2;local key=kind=='w'and HK_W or HK_R
 local search=self.searches[kind]
 if not u or not self:Ready(slot,name)or not permission()or not self:Safe(u.pos,offensive)or GetDistance(u.pos,myHero.pos)>self.profile.wSwapRange
  or kind=='r'and Game.Timer()<search.started+self.profile.rRecast then return false end
 local row=self.shadows[kind];local witness={origin=point(myHero.pos),endpoint=point(u.pos)}
 return self:Submit(slot,key,nil,{owner='OwnedShadowSwap',context=context,independent=false,
  validate=function()local fresh=self:Shadow(kind);local yes=permission()and self.shadows[kind]==row and fresh and self:Safe(fresh.pos,offensive)and GetDistance(fresh.pos,myHero.pos)<=self.profile.wSwapRange
   and(kind~='r'or Game.Timer()>=search.started+self.profile.rRecast)
   if yes then witness.origin=point(myHero.pos);witness.endpoint=point(fresh.pos)end;return yes end,
  observe=function(q)local a=Core:NativeCast(q,name);return a and GetDistance(myHero.pos,witness.endpoint)<=90 and GetDistance(myHero.pos,witness.origin)>50 end})
end
function ZedChampion:Risk(p)
 local n=0;for _,u in ipairs(self:Rows('hero',3000))do if GetDistance(u.pos,p)<600 then n=n+1 end end
 for _,t in ipairs(_G.SDK.ObjectManager:GetEnemyTurrets(2500))do if IsValid(t)and GetDistance(t.pos,p)<775+(t.boundingRadius or 0)+(myHero.boundingRadius or 0)then n=n+10 end end;return n
end
function ZedChampion:Return(context,permission,improvement)
 local current=self:Risk(myHero.pos)
 local best,bestScore;for _,kind in ipairs({'r','w'})do local s=self:Shadow(kind)
  if s and self:Safe(s.pos,false)then local risk=self:Risk(s.pos)
   if risk<=current and(not improvement or risk<current)and(context.mode~='Flee'or GetDistance(s.pos,mousePos)+75<GetDistance(myHero.pos,mousePos))then local score=risk*10000+GetDistance(s.pos,mousePos);if not bestScore or score<bestScore then best=kind;bestScore=score end end
  end end
 return best and self:Swap(best,context,function()local fresh=self:Shadow(best);local risk=fresh and self:Risk(fresh.pos);return permission()and risk and risk<=self:Risk(myHero.pos)
  and(not improvement or risk<self:Risk(myHero.pos))and(context.mode~='Flee'or GetDistance(fresh.pos,mousePos)+75<GetDistance(myHero.pos,mousePos))end,false)or false
end
-- Death Mark out of reach (625-1250): W toward the target, swap onto the shadow once it is observed, then R with
-- fresh kill and safety checks. Same switch and gates as Combo R; the W point must be safe for an engage and
-- within 600 of the target.
function ZedChampion:ReachR(u,context)
 local d=GetDistance(u.pos,myHero.pos);local p=self.profile
 if d<=p.rRange or d>p.wRange+600 or not self:Ready(_R)or not self:Ready(_W)or self:Shadow('w')or not self:PostEnergy(true)or not self:RKills(u)then return false end
 local anchor=self:WPosition(u.pos);if not anchor or GetDistance(anchor,u.pos)>600 or not self:Safe(anchor,true)then return false end
 return self:CastW(u.pos,context,function()return Menu.Combo.R:Value()and self:RKills(u)end,u,{follow='r'})
end
function ZedChampion:Combat(mode)
 local node=Menu[mode];if GetMode()~=mode or not Core.manaAbove(node.Mana:Value())then return false end
 local context=Core:ModeContext(mode,function()return Core.manaAbove(node.Mana:Value())end);local u=self:Target(2900);if not u then return false end
 if mode=='Combo'and Menu.Combo.R:Value()then
  local function rAllowed()return Menu.Combo.R:Value()and self:RKills(u)end
  if self:CastR(u,context,rAllowed,Menu.Combo.TurretR:Value())then return true end
  if node.W:Value()and self:ReachR(u,context)then return true end
 end
 if node.E:Value()and self:CastE(u,context,function()return node.E:Value()end)then return true end
 if node.W:Value()and GetDistance(u.pos,myHero.pos)<=1100 and self:PostEnergy(true)and self:CastW(u.pos,context,function()return node.W:Value()and Core.manaAbove(node.Mana:Value())end,u)then return true end
 -- E on cooldown: W then Q alone, when no current origin reaches the target with Q but the shadow would.
 if node.W:Value()and node.Q:Value()and not self:Ready(_E)and self:QEnergy(true)and GetDistance(u.pos,myHero.pos)<=self.profile.wRange+self.profile.qRange
  and not self:QReach(u)then local anchor=self:WPosition(u.pos)
  if anchor and GetDistance(anchor,u.pos)<=self.profile.qRange and self:CastW(u.pos,context,function()return node.W:Value()and node.Q:Value()and Core.manaAbove(node.Mana:Value())end,u,{follow='q'})then return true end
 end
 if mode=='Combo'and Menu.Combo.Swap:Value()and self:Shadow('w')and GetDistance(u.pos,myHero.pos)>self.profile.eRadius then
  local s=self:Shadow('w');local handle=u.handle;if GetDistance(s.pos,u.pos)<=self.profile.eShadowRadius and self:PostEnergy(false)and self:Swap('w',context,function()local fresh=self:Shadow('w');return Menu.Combo.Swap:Value()and self:Allowed(u)and u.handle==handle and fresh and GetDistance(fresh.pos,u.pos)<=self.profile.eShadowRadius and self:PostEnergy(false)end,true)then return true end end
 return node.Q:Value()and self:CastQ(u,context,function()return node.Q:Value()end)or false
end
function ZedChampion:ContinueFollow()
 local f=self.follow;if not f then return false end
 if Game.Timer()>f.expires or not Core.adapter:ContextValid({context=f.context})or f.permission and not f.permission()or not self:Allowed(f.target)or f.target.handle~=f.handle then self.follow=nil;return false end
 if f.kind=='r'then
  if f.swapObserved then
   if self:CastR(f.target,f.context,function()return(not f.permission or f.permission())and self:RKills(f.target)end,Menu.Combo.TurretR:Value())then self.follow=nil;return true end
   return false
  end
  if f.swapIssued then local row=self.issued[_W];if row then return true end;self.follow=nil;return false end
  if not self:Shadow('w')then return false end
  if self:Swap('w',f.context,function()local s=self:Shadow('w');return(not f.permission or f.permission())and s~=nil and GetDistance(s.pos,f.target.pos)<=self.profile.rRange end,true)then
   f.swapIssued=true;Core:AfterCast(HK_W,function()f.swapObserved=true end);return true
  end
  return false
 end
 if not self:Shadow('w')then return false end
 if f.kind=='q'then if self:CastQ(f.target,f.context,f.permission)then self.follow=nil;return true end;return false end
 if not f.eIssued and self:Ready(_E)and self:EHits(f.target)then
  if self:CastE(f.target,f.context,f.permission)then f.eIssued=true;Core:AfterCast(HK_E,function()f.eObserved=true end);return true end
 end
 -- The follow-up Q waits for this E, not for one way of seeing it: a native
 -- cast, E's cooldown having started, or the request having ended unsent all end
 -- the wait. Waiting for the native cast alone held the tick to the 1 s expiry
 -- and then dropped the Q whenever the host showed no cast for the instant E.
 if f.eIssued and not f.eObserved then local row=self.issued[_E];if row and not row.cooldownSeen then return true end end
 if self:CastQ(f.target,f.context,f.permission)then self.follow=nil;return true end
 return false
end
function ZedChampion:Combo()return self:Combat('Combo')end
function ZedChampion:Harass()return self:Combat('Harass')end
-- Clear W: the unit whose shadow spot (W lands within E reach of it) puts the most units under E from Zed and the
-- shadow together; lane needs the count, jungle one monster. Q and E must be ready with energy for all three.
function ZedChampion:ClearW(kind,rows,count,context,node)
 if not node.W or not node.W:Value()or not self:Ready(_W)or self:Shadow('w')or not self:PostEnergy(true)then return false end
 local best,bestN
 for i=1,math.min(#rows,12)do local u=rows[i];local anchor=self:WPosition(u.pos)
  if anchor and GetDistance(anchor,u.pos)<=self.profile.eShadowRadius then local n=0
   for j=1,math.min(#rows,24)do local v=rows[j];local at=self:Project(v,.05)
    if at and(GetDistance(at,anchor)<=self.profile.eShadowRadius or GetDistance(at,myHero.pos)<=self.profile.eRadius)then n=n+1 end
   end
   if n>=count and(not bestN or n>bestN or n==bestN and(u.maxHealth or 0)>(best.maxHealth or 0))then best,bestN=u,n end
  end
 end
 return best~=nil and self:CastW(best.pos,context,function()return node.W:Value()and Menu.Clear.SpellFarm:Value()and Core.manaAbove(node.Mana:Value())end,best)
end
function ZedChampion:Farm(kind,rescue)
 if rescue then if GetMode()~='LastHit'or not Core.manaAbove(Menu.LastHit.Mana:Value())then return false end
 elseif not Menu.Clear.SpellFarm:Value()or not Core:FarmModeEnabled(kind)then return false end
 local node=rescue and Menu.LastHit or Menu.Clear[kind=='lane'and'LaneClear'or'JungleClear'];if not Core.manaAbove(node.Mana:Value())then return false end
 local context=rescue and Core:RescueContext(Core:ModeContext('LastHit',function()return Core.manaAbove(node.Mana:Value())end))or Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()and Core.manaAbove(node.Mana:Value())end)
 local rows=self:Rows(kind,2900);local count=kind=='lane'and not rescue and Menu.Clear.LaneClear.Count:Value()or 1
 if not rescue and self:ClearW(kind,rows,count,context,node)then return true end
 if kind=='jungle'and not rescue then
  -- Jungle: E on any monster in reach, then the Q plan hitting the most monsters, ties to the largest.
  if node.E:Value()then for i=1,math.min(#rows,12)do if self:CastE(rows[i],context,function()return node.E:Value()end,false,kind,1)then return true end end end
  if not node.Q:Value()or not self:Ready(_Q)then return false end
  local best,bestPlan
  for i=1,math.min(#rows,6)do local u=rows[i];local plan=self:QPlan(u)
   if plan and(not bestPlan or plan.collateral>bestPlan.collateral or plan.collateral==bestPlan.collateral and(u.maxHealth or 0)>(best.maxHealth or 0))then best,bestPlan=u,plan end
  end
  return best~=nil and self:CastQ(best,context,function()return node.Q:Value()end,false,bestPlan)or false
 end
 for i=1,math.min(#rows,12)do local u=rows[i]
  if node.E:Value()and self:CastE(u,context,function()return node.E:Value()end,rescue,kind,count)then return true end
  if node.Q:Value()and self:Ready(_Q)then local p=self:QPlan(u)
   if p and(rescue or kind=='jungle'or p.collateral+1>=count)and self:CastQ(u,context,function()return node.Q:Value()end,rescue,p)then return true end end
 end;return false
end
function ZedChampion:LaneClear()return self:Farm('lane')end
function ZedChampion:JungleClear()return self:Farm('jungle')end
function ZedChampion:LastHit()return self:Farm('lane',true)end
function ZedChampion:Flee()
 if GetMode()~='Flee'then return false end;local context=Core:ModeContext('Flee');local permission=function()return GetMode()=='Flee'and Menu.Misc.FleeW:Value()end
 if permission()then if self:Return(context,permission)then return true end;if self:CastW(mousePos,context,permission)then return true end end
 local u=self:Target(2900);return Menu.Misc.FleeE:Value()and u and self:CastE(u,context,function()return Menu.Misc.FleeE:Value()end)or false
end
function ZedChampion:Assist()
 for _,name in ipairs({'RAssist','ReturnAssist'})do local node=Menu.Misc[name]
  if not node:Value()then self.gestures[name]=nil
  elseif not self.gestures[name]then local permission=function()return node:Value()end;local context=Core:HeldContext(permission);local yes
   if name=='ReturnAssist'then yes=self:Return(context,permission)
   else local u=self:Target(self.profile.rRange);yes=u and self:CastR(u,context,permission)end
   if yes then self.gestures[name]=true;return true end
  end
 end;return false
end
-- Background finisher (no mode key): Q when the plan's lower damage kills at impact, E when it kills now, or W
-- toward a target 900-1550 away and Q from the shadow when that Q kills on arrival (follow fires Q only).
function ZedChampion:KillSecure()
 if not Menu.Misc.KillSecure:Value()or Recalling(myHero)then return false end
 local context={priority='interactive'};local p=self.profile
 for _,u in ipairs(self:Rows('hero',p.wRange+p.qRange))do
  -- Cheap gate before any plan: a single Q or E must at least reach current health.
  if self:Allowed(u)and(self:Damage(_Q,u)>=u.health or self:Damage(_E,u)>=u.health)then
   local function qKills()local plan=self:QPlan(u,true);return plan~=nil and(Core:Lethal(u,plan.impact,plan.lower,{kind='physical'}))end
   local function eKills()return self:EHits(u)~=nil and(Core:Lethal(u,.05,self:Damage(_E,u),{kind='physical'}))end
   if self:Ready(_Q)and qKills()and self:CastQ(u,context,function()return Menu.Misc.KillSecure:Value()and qKills()end)then return true end
   if self:Ready(_E)and eKills()and self:CastE(u,context,function()return Menu.Misc.KillSecure:Value()and eKills()end)then return true end
   local d=GetDistance(u.pos,myHero.pos)
   if d>p.qRange and self:Ready(_W)and not self:Shadow('w')and self:QEnergy(true)then local anchor=self:WPosition(u.pos)
    local function wqKills()local a=self:WPosition(u.pos);if not a or GetDistance(a,u.pos)>p.qRange then return false end
     local impact=GetDistance(myHero.pos,a)/p.wSpeed+p.qDelay+GetDistance(a,u.pos)/p.qSpeed
     return(Core:Lethal(u,impact,self:Damage(_Q,u),{kind='physical'}))end
    if anchor and wqKills()and self:CastW(u.pos,context,function()return Menu.Misc.KillSecure:Value()and wqKills()end,u,{follow='q'})then return true end
   end
  end
 end
 return false
end
-- E on an enemy champion in reach of Zed or a shadow without a mode key (slow, and W cooldown back on a hit);
-- energy above the Harass floor, never while recalling, and not while farming with spell farming off.
function ZedChampion:AutoE()
 if not Menu.Misc.AutoE:Value()or not self:Ready(_E)or not Core.manaAbove(Menu.Harass.Mana:Value())or Recalling(myHero)then return false end
 local mode=GetMode();if(mode=='LastHit'or mode=='LaneClear')and not Menu.Clear.SpellFarm:Value()then return false end
 for _,u in ipairs(self:Rows('hero',1000))do
  if self:EHits(u)and self:CastE(u,{priority='normal'},function()return Menu.Misc.AutoE:Value()and Core.manaAbove(Menu.Harass.Mana:Value())end)then return true end
 end
 return false
end
function ZedChampion:MarkReturn()
 local m=self.markEnded;if not m then return false end
 if Game.Timer()>m.expires or not Menu.Misc.MarkReturn:Value()then self.markEnded=nil;return false end
 local deadline=m.expires;local permission=function()return Menu.Misc.MarkReturn:Value()and Game.Timer()<=deadline end
 if self:Return({priority='interactive',condition=permission},permission,true)then self.markEnded=nil;return true end
 return false
end
function ZedChampion:Tick()
 if not Core:InputAvailable()then self.follow=nil;return end
 self:MaintainIssued();self:MaintainMark();if Core.logger then self:TraceEvidence()end;if self.shadowFallback then self:DiscoverShadows()end;if self.previewFallback then self:PreparePreview()end
 self.allow:Maintain()
 if ShouldWait()then return end
 if Menu.Misc.ReturnHP:Value()and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100<Menu.Misc.HP:Value()then
  local permission=function()return Menu.Misc.ReturnHP:Value()and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100<Menu.Misc.HP:Value()end
  if self:Return({priority='critical',condition=permission},permission,true)then return end
 end
 if self:Assist()or self:ContinueFollow()or self:MarkReturn()or self:KillSecure()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LaneClear'then self:LaneClear();self:JungleClear()elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if mode~='Combo'and mode~='Harass'and not Core.pending[HK_E]then self:AutoE()end
end
-- Prepared (150 ms job): shadows with time left, kill marks for at most five enemies (R ready: the Death Mark
-- estimate; R down: ready Q plus E against health and shields), Q readiness. Draw only reads this table.
function ZedChampion:PreparePreview()
 if not Menu.Draw.Preview:Value()then self.preview=nil;return end
 local now=Game.Timer();local origins={}
 for _,kind in ipairs({'w','r'})do local u=self:Shadow(kind);local search=self.searches[kind]
  if u and search then origins[#origins+1]={unit=u,handle=u.handle,pos=point(u.pos),expires=search.expires,kind=kind}end
 end
 local kills={};local rReady,qReady,eReady=self:Ready(_R),self:Ready(_Q),self:Ready(_E)
 for _,u in ipairs(self:Rows('hero',2900))do if #kills>=5 then break end
  if self:Allowed(u)then local label
   if rReady and self:RKills(u)then label='R kills'
   elseif not rReady and(qReady or eReady)then
    local damage=(qReady and self:Damage(_Q,u)or 0)+(eReady and self:Damage(_E,u)or 0)
    if damage>=u.health+math.max(0,u.shieldAD or 0)and not Core:CannotDie(u,.3)then label='Q+E kills'end
   end
   if label then kills[#kills+1]={unit=u,handle=u.handle,label=label}end
  end
 end
 -- No shadow-timer or Death Mark text: the W/R icons and the mark show them. Kept for a second so a late
 -- preparation never blinks; each shadow is drawn at its live position until it expires or is gone.
 self.preview={expires=now+1,origins=origins,kills=kills,qReady=qReady,swapRange=self.profile.wSwapRange,qRange=self.profile.qRange}
end
function ZedChampion:Draw()
 local p=self.preview;if not Menu.Draw.Preview:Value()or not p or Game.Timer()>p.expires or myHero.dead then return end
 if p.qReady then Draw.Circle(myHero.pos,p.qRange,1,Draw.Color(120,120,200,255))end
 local now=Game.Timer()
 for _,o in ipairs(p.origins)do local u=o.unit
  if o.expires>now and u and not u.dead and u.handle==o.handle and point(u.pos)then
   Draw.Circle(u.pos,50,1,Draw.Color(180,180,80,255))
   if o.kind=='w'then Draw.Circle(u.pos,p.swapRange,1,Draw.Color(70,180,80,255))end
  end
 end
 for _,k in ipairs(p.kills or {})do local u=k.unit
  if u and u.handle==k.handle and u.pos2D and u.visible~=false and not u.dead then Draw.Text(k.label,16,u.pos2D.x-25,u.pos2D.y-60,Draw.Color(255,255,70,70))end
 end
end
function ZedChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Zed: shadows','Zed: combat'},function(page)return{title='Zed assistance',cards=page==1 and{
  {'ORIGINS','One Q aim accounts for current own live shadow rays. Spawn requests, allied lookalikes and enemy shadows never become origins.'},
  {'SWAPS','The return bind swaps back to your safest shadow, and after a Death Mark ends a safer shadow is taken automatically. Combo swaps and Combo R each have their own switch; Combo R waits until Q, E, two attacks, the passive and the mark can kill, and reaches a target up to 1250 away with W, a swap and R.'},
  {'STAGES','Current owned objects, finite native creation/expiry and actual W2/R2 govern swaps. Cancellation and uncertain sends never replay.'}}or{
  {'MARK','The R bind casts Death Mark at the selected target when energy remains for Q and E. The marked target stays fixed when selection changes; health loss is not qualified damage.'},
  {'FARM','Spell Farm and separate Lane/Jungle settings govern spending. LastHit saves isolated CS from current confirmed health forecasts. Without a mode key Q, E or W then Q finish killable champions and E slows champions in reach.'},
  {'LIMITS','No mark-lethal auto return from guessed damage. Evade may use Death Mark against a hit that would kill (untargetable 0.95 s, landing behind the target; not live-measured); external FPS requires live measurement.'}}}end)
end
function ZedChampion:FeatureStatus()
 return{classic={supported=false,reason='installed_jade_zed_asset_unavailable'},markLethal={supported=false,reason='native_attributed_damage_event_and_pre_mitigation_qualification_contract_unavailable'},
  shadow={supported=true,reason='accepted_native_cast_anchor_plus_real_owned_clone_creation_identity_required_missing_fields_gate_only_shadow_actions'},
  evadeSwap={supported=self.swapOffers and(self.swapOffers.w or self.swapOffers.r)==true,reason='owned_teleport_offers_w2_r2_live_safe_shadow_recast_cast_time_none_wiki_2026-10-10'},
  evadePlace={supported=self.placeOffer==true,reason='owned_teleport_place_w_then_w2_after_observed_shadow_cast_bound_0.07_travel_d/2500_discovery_0.15'},evadeR={supported=self.mobilityOffered==true,reason='untargetable_0.95s_landing_125_beyond_target_wiki_2026-10-08_only_for_lethal_hits_or_a_combo_kill'},
  extraQDamage={supported=false,reason='joint_ray_candidates_not_observed_hits_extra_same_target_multiplier_unverified'}}
end
-- As before, no own-channel gate is registered for Zed.
Core:StandardPolicy(ZedChampion,{damageTypes={Q='physical',E='physical',R='physical'},channel=false,
 methods={KillSecure=function()return {priority='interactive',condition=function()return Menu.Misc.KillSecure:Value()end}end,
  AutoE=function()return {priority='normal',condition=function()return Menu.Misc.AutoE:Value()end}end,
  MarkReturn=function()return {priority='interactive'}end},
 costPaid=function(self,q,slot)return slot==_W and q.spellName==self.profile.w2 and self:Shadow('w')~=nil or slot==_R and q.spellName==self.profile.r2 and self:Shadow('r')~=nil end,
 validate=function(self,q,slot)return type(slot)~='number'or slot<0 or slot>3 or self:Ready(slot,q.spellName,true)end})
ZedChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={}
local normalSupported={["Zed"]=true}

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
