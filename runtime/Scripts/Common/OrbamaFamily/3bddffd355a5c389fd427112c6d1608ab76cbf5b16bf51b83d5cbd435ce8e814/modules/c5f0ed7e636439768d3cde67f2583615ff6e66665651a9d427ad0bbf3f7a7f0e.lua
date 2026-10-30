return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
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
if champion=="Ashe" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Ashe',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 1.02


local AsheChampion=class("AsheChampion")

function AsheChampion:__init()
	self.profile=assert(AsheProfile(myHero.charName),'Unsupported Ashe mechanics profile')
	print("AyyyyIO - Ashe loaded")
	self:LoadMenu()
	Callback.Add("Draw", function() self:Draw() end)
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("WndMsg", function(msg,key) self:OnInput(msg,key) end)
	_G.SDK.Orbwalker:OnPreAttack(function(...) self:OnPreAttack(...) end)
	_G.SDK.Orbwalker:OnPostAttack(function() self:OnPostAttack() end)
	self.WSpell = AbilityProfiles.Spell(myHero.charName,'W',OrbamaPrediction)
	self.WSpell.Collision=true;self.WSpell.CollisionTypes={OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_YASUOWALL}
	self.RSpell = AbilityProfiles.Spell(myHero.charName,'R',OrbamaPrediction)
	self.RSpell.Collision=true;self.RSpell.CollisionTypes={OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL}
	self.recallCast={key=HK_R,spell=self.RSpell,enabled=function()return Menu.KillSteal.BaseR:Value()end,
		safe=function()return GetEnemyCount(800,myHero.pos)==0 end,damage=function(unit)return self:GetRDmg(unit)end}
	-- Volley without collision for the fan solver's predicted champion positions.
	self.WFan={};for k,v in pairs(self.WSpell)do self.WFan[k]=v end;self.WFan.Collision=false;self.WFan.CollisionTypes=nil
	-- Volley speed (Ashe-7): asset and wiki disagree (profile.wSpeeds). WSpell/WFan carry the slower bound,
	-- the *Fast copies the faster one, until ObserveVolley measured own arrows (self.volleySpeed.value).
	local speeds=self.profile.wSpeeds;self.wSpeedLo,self.wSpeedHi=math.min(speeds[1],speeds[2]),math.max(speeds[1],speeds[2])
	self.volleySpeed={samples={},rejected=0}
	self.WSpellFast={};for k,v in pairs(self.WSpell)do self.WSpellFast[k]=v end
	self.WFanFast={};for k,v in pairs(self.WFan)do self.WFanFast[k]=v end
	self:ApplyWSpeed(self.wSpeedLo,self.wSpeedHi)
	self.rConsent=Core:TargetConsent(Menu.Misc.RTargets,self,'Allow: ','RReact')
	Callback.Add("Tick",function()self:ObserveVolley()end)
	-- Health-bar damage: ready W and R plus the attacks of the next 2 s.
	Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
end

function AsheChampion:LoadMenu()
	local championIcon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/"..myHero.charName..".png"
	Menu = MenuElement({type = MENU, id = "Classic_AIO_"..myHero.charName, name='AyyyyIO - Ashe', leftIcon = championIcon})

	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "R", name = "Use R to kill, hit two or on a half-health target", value = true})
	Menu.Combo:MenuElement({id = "Raoe", name = "Use R when it hits 3 or more enemies", toggle = true, value = true})

	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Harass:MenuElement({id = "Mana", name = "Only above mana %", value = 40, min = 0, max = 100, step = 5})

	Menu:MenuElement({type = MENU, id = "Clear", name = "Farming"})
	Menu.Clear:MenuElement({id = "SpellFarm", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(newValue)
		if CheckChatBlock(Menu.Clear.SpellFarm, newValue) then return end
	end})
	Menu.Clear:MenuElement({id = "SpellHarass", name = "Harass enemy champions while lane clearing", value = true})
	Menu.Clear:MenuElement({id = "Mana", name = "Only above mana %", value = 30, min = 0, max = 100, step = 5})
	Menu.Clear:MenuElement({type = MENU, id = "LaneClear", name = "Lane clear"})
	Menu.Clear.LaneClear:MenuElement({id = "W", name = "Use W", toggle = true, value = true})
	Menu.Clear.LaneClear:MenuElement({id = "Count", name = "Minions W must hit (and near you for Q)", value = 2, min = 1, max = 6, step = 1})
	Menu.Clear:MenuElement({type = MENU, id = "JungleClear", name = "Jungle clear"})
	if not self.profile.qToggle then
		Menu.Clear.LaneClear:MenuElement({id='Q',name='Use Q (also on turrets)',value=true})
		Menu.Clear.JungleClear:MenuElement({id='Q',name='Use Q',value=true})
	end
	Menu.Clear.JungleClear:MenuElement({id = "W", name = "Use W", toggle = true, value = true})

	Menu:MenuElement({type = MENU, id = "KillSteal", name = "Finish kills without holding a mode key"})
	Menu.KillSteal:MenuElement({id='BaseR',name='R recalling enemies at their base if it kills',value=true})

	Menu:MenuElement({type = MENU, id = "Misc", name = "Behaviour"})
	Menu.Misc:MenuElement({id = "Rsm", name = "Cast R at the selected target", key = string.byte("T")})
	Menu.Misc:MenuElement({id='FinisherR',name='Finish killable enemies with R',value=true})
	Menu.Misc:MenuElement({id='InterruptR',name='Interrupt enemy channels with R',value=true})
	Menu.Misc:MenuElement({id='GapcloseR',name='R enemies that dash at you',value=true})
	Menu.Misc:MenuElement({id='PeelR',name='R an enemy attacking you when your health is low',value=true})
	Menu.Misc:MenuElement({id='GroupR',name='R three or more enemies without holding a mode key',value=true})
	Menu.Misc:MenuElement({type=MENU,id='RTargets',name='Enemy champions R reactions may target'})
	Menu.Misc:MenuElement({id='ReactiveRRange',name='Those automatic R casts only within',value=1800,min=500,max=4000,step=100,menu=false})
	Menu.Misc:MenuElement({id='LostScout',name='Reveal a target lost from sight with E',value=true})

	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "W", name = "W range", toggle = true, value = false})
	Menu.Draw:MenuElement({id = "R", name = "Range of the automatic R casts", value = false})
end

function AsheChampion:OnPreAttack(args)
	if not self.profile.qToggle then return end
	if args.Process==false or ShouldWait() then return end
	local target = args.Target
	if IsValid(target) and IsReady(_Q) and myHero:GetSpellData(_Q).toggleState == 1 then
		if target.type == Obj_AI_Hero then
			if GetMode() == "Combo" and Menu.Combo.Q:Value() or (GetMode() == "Harass" and Menu.Harass.Q:Value() and Core.manaAbove(Menu.Harass.Mana:Value())) then
				self:SetFrost(true,target)
			end
		end
	end
end

function AsheChampion:OnInput(msg,key)
	if not self.profile.qToggle then return end
	if msg~=256 or key~=HK_Q then return end
	local edge=_G.SDK.Input and _G.SDK.Input.LastInputEdge
	if edge and edge.classification~='new manual press or unmatched echo' then return end
	if not edge and Core.adapter:IsSending() then return end
	self.frostRequest=nil;self.frostOwned=false
end

function AsheChampion:ObserveFrost()
	if not self.profile.qToggle then return end
	local request=self.frostRequest
	if request then
		local q=request.intent
		if q.observedAt then
			self.frostOwned=not q.ambiguous and request.enabled and myHero:GetSpellData(_Q).toggleState==2
			self.frostRequest=nil
		elseif q.outcome or Core.adapter:Now()>q.expires+750 then self.frostRequest=nil end
	end
	if myHero:GetSpellData(_Q).toggleState~=2 then self.frostOwned=false end
end

function AsheChampion:SetFrost(enabled,target)
	if not self.profile.qToggle then return false end
	local expected=enabled and 1 or 2
	if self.frostRequest or myHero:GetSpellData(_Q).toggleState~=expected then return false end
	local accepted,id=Core:Cast(HK_Q,nil,{intentTarget=target,
		validate=function()
			if myHero:GetSpellData(_Q).toggleState~=expected then return false end
			if not enabled then return self.frostOwned and GetMode()~='Combo' and GetMode()~='Harass' end
			return IsValid(target) and GetDistance(target.pos,myHero.pos)<=myHero.range+myHero.boundingRadius+target.boundingRadius
		end})
	if accepted then
		local q=Core.pending[HK_Q]
		if q and q.id==id then self.frostRequest={intent=q,enabled=enabled} end
	end
	return accepted
end

function AsheChampion:ReleaseFrost()
	if not self.profile.qToggle then return end
	if self.frostOwned and GetMode()~='Combo' and GetMode()~='Harass' then self:SetFrost(false) end
end

function AsheChampion:FocusState()
	if self.profile.qToggle then return false,false end
	local ready,active=false,false
	for _,buff in ipairs(GetBuffs(myHero))do
		local name=buff.name and buff.name:lower()
		local expiry=Core.buffExpiry(buff)
		if buff.count and buff.count>0 and type(expiry)=='number'and expiry>Game.Timer()
			and(not buff.source or Core.mine(buff.source))then
			if name==self.profile.qActive then active=true end
			if name==self.profile.qReady then ready=true end
		end
	end
	return ready,active
end

function AsheChampion:FocusReady()
	if self.profile.qToggle or not IsReady(_Q) then return false end
	local ready,active=self:FocusState()
	return ready and not active
end

function AsheChampion:FocusAllowed(target)
	local witness=self.attackWitness
	if not witness or witness.mode~=GetMode()or not IsValid(target)or witness.target~=target.networkID then return false end
	local age=Game.Timer()-witness.at
	local cast=myHero.activeSpell
	if cast and cast.valid and cast.castEndTime and cast.castEndTime>Game.Timer()then return false end
	if age<0 or age>.35 or GetDistance(target.pos,myHero.pos)>myHero.range+myHero.boundingRadius+target.boundingRadius then return false end
	return self:FocusReady()
end

function AsheChampion:ObserveAttack()
	if self.profile.qToggle then return end
	local mode=GetMode()
	local allowed=mode=='Combo'and Menu.Combo.Q:Value()or mode=='Harass'and Menu.Harass.Q:Value()and Core.manaAbove(Menu.Harass.Mana:Value())
		or mode=='LaneClear'and self:FarmAllowed()and(self:ClearMode(false)and Menu.Clear.LaneClear.Q:Value()or self:ClearMode(true)and Menu.Clear.JungleClear.Q:Value())
	if not allowed then self.attackWitness=nil;self.attackMode=nil;return end
	self.attackMode=mode
	self.attackWitness=ObserveAttack(_G,self.attackSample,function(id)
		for _,method in ipairs({'GetEnemyHeroes','GetEnemyMinions','GetMonsters','GetEnemyTurrets'})do
			for _,target in ipairs(Core:DecisionUnits(method))do
				if target.networkID==id or target.handle==id then return target end
			end
		end
	end)
	if self.attackWitness and self.attackWitness~=self.attackSample then self.attackWitness.mode=mode end
	self.attackSample=self.attackWitness
end

function AsheChampion:OnPostAttack()
	if self.profile.qToggle or ShouldWait() then return end
	self:ObserveAttack()
	local target=self.attackWitness and self.attackWitness.object
	if not self:FocusAllowed(target)then return end
	local mode=self.attackMode
	local node=mode=='Combo'and Menu.Combo.Q or mode=='Harass'and Menu.Harass.Q
	if mode=='LaneClear'and self:FarmAllowed()then
		if not self:FarmQTarget(target)or not self:ClearMode(target.team==300)then return end
		node=target.team==300 and Menu.Clear.JungleClear.Q or Menu.Clear.LaneClear.Q
	end
	if not node or not node:Value() then return end
	Core:Cast(HK_Q,nil,{intentTarget=target,context=mode=='LaneClear'and self:ClearContext(target.team==300)or nil,observe=function()
		return Core:Fresh(function()local _,active=self:FocusState();return active end)
	end,validate=function()
		return node:Value() and(mode~='LaneClear'or self:FarmAllowed()and self:FarmQTarget(target)and self:ClearMode(target.team==300))and self:FocusAllowed(target)
	end})
end

function AsheChampion:TrackScoutTarget()
	if not Menu.Misc.LostScout:Value()then self.scoutTarget=nil;self.scoutAttempt=nil;return end
	local mode=GetMode()
	if mode~='Combo'and mode~='Harass'then return end
	local range=self.profile.eRange[myHero:GetSpellData(_E).level]
	local target=range and GetTarget(math.min(range,2000))
	if IsValid(target)then self.scoutTarget={unit=target,id=target.networkID,handle=target.handle,name=target.charName,at=Game.Timer()}end
end

function AsheChampion:LostScoutObservation()
	local focus=self.scoutTarget
	if not Menu.Misc.LostScout:Value()or not focus or Game.Timer()-focus.at>3 then return nil end
	local unit=focus.unit
	if not unit or unit.valid==false or unit.dead or unit.visible or unit.networkID~=focus.id
		or unit.handle~=focus.handle or unit.charName~=focus.name then return nil end
	local knowledge=Core:GetKnowledge()
	local row=knowledge and knowledge:LastSeen(unit,2)
	local range=self.profile.eRange[myHero:GetSpellData(_E).level]
	if not row or not range or row.age<.15 or GetDistance(row.pos,myHero.pos)>range then return nil end
	return row,range
end

function AsheChampion:AutoScout()
	if not Menu.Misc.LostScout:Value()or not IsReady(_E)then return false end
	local row,range=self:LostScoutObservation()
	if not row or self.scoutAttempt and self.scoutAttempt.id==row.id and self.scoutAttempt.at==row.at then return false end
	local destination=self:ScoutPoint(self.scoutTarget.unit,row,range)
	if not destination or not self:ScoutWorth(self.scoutTarget.unit,row)then return false end
	local accepted=Core:Cast(HK_E,destination,{range=range,owner='AutoScout',ttl=150,
		context={priority='background',condition=function()return Menu.Misc.LostScout:Value()end},
		validate=function()
			local fresh=self:LostScoutObservation()
			return fresh and fresh.id==row.id and fresh.handle==row.handle and fresh.at==row.at
				and fresh.map==row.map and fresh.profile==row.profile and GetDistance(fresh.pos,destination)<=1
		end})
	-- One request per disappearance, including uncertain input. A new visible
	-- observation permits another scout; no cast or vision outcome is inferred.
	if accepted then self.scoutAttempt={id=row.id,at=row.at}end
	return accepted
end

function AsheChampion:ReactiveReason(target,point)
	local misc=Menu.Misc
	if not IsValid(target)or IsInvulnerable(target)or GetDistance(target.pos,myHero.pos)>misc.ReactiveRRange:Value()then return nil end
	local impact=OrbamaPrediction:GetImpactTime(self.RSpell,point or target.pos,myHero)
	if type(impact)~='number'or impact~=impact or impact<0 then return nil end
	local allowed=self.rConsent:Allowed(target)
	if allowed and misc.InterruptR:Value()and Core:CanInterrupt(target,impact)then return 'interrupt' end
	if allowed and misc.GapcloseR:Value()then
		local dash=Core:ApproachingDash(target,myHero.pos,700)
		if dash and self:DashThreat(target,dash)then return 'approaching_dash'end
	end
	if allowed and misc.PeelR:Value()and self:PeelThreat(target)then return 'peel'end
	if misc.FinisherR:Value()and self:RKills(target,impact)then return 'finisher'end
	if misc.GroupR:Value()and self:RGroupCount(target)>=3 then return 'group'end
end
-- A dash is a threat when Ashe's threat evidence names the dasher, or it ends
-- inside the dasher's attack range of her (a tank engaging the team is not).
function AsheChampion:DashThreat(target,dash)
	local threat=Core:AllyThreat(myHero,1)
	if threat and threat.source==target then return true end
	return dash.to~=nil and GetDistance(dash.to,myHero.pos)<=(target.range or 0)+(target.boundingRadius or 65)+(myHero.boundingRadius or 65)
end
-- Self-peel: an enemy champion within 700 whose attack or targeted cast is about
-- to hit Ashe while her health after that hit is at most 40%. R's stun is at its
-- 1 s minimum this close (profile rStunMin).
function AsheChampion:PeelThreat(target)
	if GetDistance(target.pos,myHero.pos)>700 or not target.visible then return false end
	local threat=Core:AllyThreat(myHero,.75,{turrets=false,skillshots=false})
	if not threat or threat.source~=target or(threat.kind~='attack'and threat.kind~='cast')or not threat.valid()then return false end
	local damage=0
	if threat.kind=='attack'then local ok,value=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,target,myHero);if ok and Core.finite(value)then damage=value end end
	return myHero.maxHealth>0 and(myHero.health-damage)/myHero.maxHealth<=self.profile.peelHealth
end
-- Enemy champions inside the 400 blast around the target's predicted position at
-- the arrow's arrival (at most five predictions, after a cheap count gate).
function AsheChampion:RGroupCount(target)
	if not IsValid(target)or GetEnemyCount(self.profile.rBlast+500,target.pos)<3 then return 0 end
	local prediction=Core:Prediction(self.RSpell);prediction:GetPrediction(target,myHero)
	local center=prediction.UnitPosition;if not center then return 0 end
	local cx,cz=center.x,center.z;local count=0;local enemies=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#enemies,5)do local u=enemies[i]
		if IsValid(u)and GetDistance(u.pos,target.pos)<=self.profile.rBlast+500 then
			local x,z=u.pos.x,u.pos.z
			if u~=target then prediction:GetPrediction(u,myHero);local p=prediction.UnitPosition;if p then x,z=p.x,p.z end end
			if(x-cx)^2+(z-cz)^2<=self.profile.rBlast^2 then count=count+1 end
		end
	end
	return count
end

-- Shared kill rule for the arrow alone at its arrival (spell shields, shield pools, health window).
function AsheChampion:RKills(target,impact)
	impact=impact or OrbamaPrediction:GetImpactTime(self.RSpell,target.pos,myHero)
	if type(impact)~='number'or impact~=impact or impact<0 then return false end
	return(Core:Lethal(target,impact,function()return self:GetRDmg(target)end,{kind='magical'}))
end

-- The arrow plus what fits into its stun: basic attacks on a target inside attack range and one Volley.
-- Only the shortest stun is counted on (profile.rStunMin, the page's value at the caster) and plain attack
-- damage, so the estimate is a lower bound; it is judged from current health with every shield pool.
function AsheChampion:RStunKills(target)
	local impact=OrbamaPrediction:GetImpactTime(self.RSpell,target.pos,myHero)
	if type(impact)~='number'or impact~=impact or impact<0 then return false end
	local stun=self.profile.rStunMin;local distance=GetDistance(target.pos,myHero.pos)
	return(Core:Lethal(target,impact,function()
		local total=self:GetRDmg(target)
		if _G.SDK.Data:IsInAutoAttackRange(myHero,target)then
			local attack=Core:AttackImpact(target);local period=_G.SDK.Attack:GetAnimation()
			if attack and Core.finite(period)and period>0 and stun>attack then
				total=total+(1+math.floor((stun-attack)/period))*_G.SDK.Damage:GetAutoAttackDamage(myHero,target)
			end
		end
		-- WSpell.Speed is the slower bound until measured: the Volley must land inside the stun even then.
		if IsReady(_W)and distance<=self.WSpell.Range and self.WSpell.Delay+distance/self.WSpell.Speed<=stun then total=total+self:GetWDmg(target)end
		return total
	end,{now=true}))
end

-- Combo R is on with a condition, never on a full-health lone target: inside 1000 it must kill, kill together
-- with the stun follow-up, catch a second enemy in its area, or find the target at half health or less.
function AsheChampion:ComboRWanted(target)
	if not IsValid(target)or GetDistance(target.pos,myHero.pos)>1000 then return false end
	if target.maxHealth>0 and target.health/target.maxHealth<=.5 then return true end
	if GetEnemyCount(self.profile.rBlast,target.pos)>=2 then return true end
	return self:RKills(target)or self:RStunKills(target)
end

-- Farming abilities need the farming switch and the farming mana limit.
function AsheChampion:FarmAllowed()
	return Menu.Clear.SpellFarm:Value()and Core.manaAbove(Menu.Clear.Mana:Value())
end

function AsheChampion:WKills(target)
	if not IsValid(target)or IsInvulnerable(target)then return false end
	local distance=GetDistance(target.pos,myHero.pos)
	local function kills(speed)return(Core:Lethal(target,self.WSpell.Delay+distance/speed,function()return self:GetWDmg(target)end,{kind='physical'}))end
	-- Until own arrows measured the speed, the kill must hold at the impact time of both sources.
	if not kills(self.WSpell.Speed)then return false end
	return self.volleySpeed.value~=nil or kills(self.WSpellFast.Speed)
end

function AsheChampion:ReactiveR()
	local misc=Menu.Misc
	if not(misc.InterruptR:Value()or misc.GapcloseR:Value()or misc.FinisherR:Value())or not IsReady(_R)then return false end
	local enemies=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#enemies,16)do
		local target=enemies[i]
		if self:ReactiveReason(target)and self:CastR(target,{owner='ReactiveR',ttl=150,
			context={priority='interactive'},validate=function(q,resolved)
				return self:ReactiveReason(target,resolved and resolved.position or q.target)~=nil
			end})then return true end
	end
	return false
end

function AsheChampion:Tick()
	self:ObserveFrost()
	self:ObserveAttack()
	if ShouldWait() then
		return
	end
	if IsCasting() then return end
	self.rConsent:Maintain()
	self:TrackScoutTarget()
	if Core:RecallBaseCast(self.recallCast)then return end
	if self:ReactiveR()then return end
	self:ReleaseFrost()
	self:SemiManualR()
	if self:AutoScout()then return end
	self:KillSteal()
	local Mode = GetMode()
	if Mode == "Combo" then
		self:Combo()
	elseif Mode == "Harass" then
		self:Harass()
	elseif Mode == "LaneClear" then
		if self:ClearMode(false)then self:FarmHarass();self:LaneClear()end
		if self:ClearMode(true)then self:JungleClear()end
	elseif Mode == "Flee" then
		self:Flee()
	end
end

function AsheChampion:KillSteal()
	-- A Volley that kills is always taken (shared kill rule, checked again at dispatch): no switch.
	if not IsReady(_W) then return end
	local enemies = _G.SDK.ObjectManager:GetEnemyHeroes(self.WSpell.Range)
	for i=1,math.min(#enemies,5) do local target=enemies[i]
		if self:WKills(target) and self:CastW(target,function()return self:WKills(target)end) then return true end
	end
end

function AsheChampion:SemiManualR()
	if Menu.Misc.Rsm:Value() and IsReady(_R) then
		local target = _G.SDK.TargetSelector.Selected
		if IsValid(target) and GetDistance(target.pos,myHero.pos)<=self.RSpell.Range then
			self:CastR(target)
			return
		end
		local ts=_G.SDK.TargetSelector
		if ts.MenuCheckSelectedOnly and ts.MenuCheckSelectedOnly:Value() and IsValid(target) then return end
		local enemies = _G.SDK.ObjectManager:GetEnemyHeroes(self.RSpell.Range)
		local best,distance
		for _,candidate in ipairs(enemies) do
			if IsValid(candidate) and GetDistance(candidate.pos,myHero.pos)<=self.RSpell.Range then
				local d=GetDistance(mousePos,candidate.pos)
				if not distance or d<distance then best,distance=candidate,d end
			end
		end
		if best then self:CastR(best) end
	end
end

-- The fan aim is used when it hits two or more champions, or when the single
-- line to the target is blocked but another arrow still reaches it (Ashe-1).
function AsheChampion:CastW(target,validate)
	local WPrediction = Core:Prediction(self.WSpell)
	WPrediction:GetPrediction(target, myHero)
	local single=WPrediction:CanHit(2)and self:WBothSpeeds(target,WPrediction.CastPosition)
	if not single or GetEnemyCount(self.WSpell.Range+200,myHero.pos)>=2 then
		local fan=self:FanPlan(target)
		if fan and(fan.count>=2 or not single)then return self:CastFan(fan,target,validate)end
	end
	if single then
		local ok=Core:Cast(HK_W, WPrediction.CastPosition,{prevalidateWorldCast=true,validate=function(q,resolved)
			if not self:WBothSpeeds(target,resolved and resolved.position)then return false end
			return not validate or validate(q,resolved)
		end})
		if ok then self.volleyAt=Game.Timer();self.volleyAim=math.deg(math.atan2(WPrediction.CastPosition.z-myHero.pos.z,WPrediction.CastPosition.x-myHero.pos.x))end
		return ok
	end
end
-- Volley speed (Ashe-7). The installed asset says 1500, both wiki pages 2000 (profile.wSpeeds). Until own arrows
-- measured it (ObserveVolley), a line Volley keeps the slower aim and is sent only when that same arrow also reaches
-- the target's position predicted for the faster speed, so a wrong source cannot turn a cast into a miss.
function AsheChampion:ApplyWSpeed(lo,hi)
	self.WSpell.Speed=lo;self.WFan.Speed=lo;self.WSpellFast.Speed=hi;self.WFanFast.Speed=hi
end
function AsheChampion:RayReaches(aim,p,radius)
	local ox,oz=myHero.pos.x,myHero.pos.z;local ax,az=aim.x-ox,aim.z-oz;local len=math.sqrt(ax*ax+az*az)
	if len<1 then return false end
	ax,az=ax/len,az/len;local dx,dz=p.x-ox,p.z-oz;local along=dx*ax+dz*az
	return along>0 and along<=self.WSpell.Range+radius and math.abs(dx*az-dz*ax)<=self.profile.wArrowWidth/2+radius
end
function AsheChampion:WBothSpeeds(target,aim)
	if self.volleySpeed.value then return true end
	if not aim or not IsValid(target)then return false end
	local fast=Core:Prediction(self.WSpellFast);fast:GetPrediction(target,myHero)
	if not fast:CanHit(2)then return false end
	local p=fast.UnitPosition;if not p then return false end
	return self:RayReaches(aim,p,target.boundingRadius or 65)
end
-- Volley fan (Normal; Classic until measured: none). Arrows are spread evenly
-- over the cone; each is stopped by the first enemy unit within its width.
function AsheChampion:FanShape()
	local rank=myHero:GetSpellData(_W).level;local arrows=self.profile.wArrows and self.profile.wArrows[rank]
	local cone=self.profile.wCone and self.profile.wCone[rank]
	if not arrows or not cone then return nil end
	return arrows,math.rad(cone)
end
local function wrap(a)while a>math.pi do a=a-2*math.pi end;while a<-math.pi do a=a+2*math.pi end;return a end
-- rows: {unit,x,z,radius,hero}; returns the units hit (set), the number of
-- champions and the number of lane minions among them.
function AsheChampion:FanHits(theta,rows,arrows,cone)
	local ox,oz=myHero.pos.x,myHero.pos.z;local half=self.profile.wArrowWidth/2;local range=self.WSpell.Range
	local hits,count,minions={},0,0
	for i=0,arrows-1 do
		local a=theta-cone/2+(arrows>1 and cone*i/(arrows-1)or cone/2);local ux,uz=math.cos(a),math.sin(a)
		local first,firstAlong
		for _,row in ipairs(rows)do
			local dx,dz=row.x-ox,row.z-oz;local along=dx*ux+dz*uz
			if along>0 and along<=range+row.radius and math.abs(dx*uz-dz*ux)<=half+row.radius and(not firstAlong or along<firstAlong)then first,firstAlong=row,along end
		end
		if first and not hits[first.unit]then
			hits[first.unit]=true
			if first.hero then count=count+1 elseif first.lane then minions=minions+1 end
		end
	end
	return hits,count,minions
end
function AsheChampion:FanRows(target,predict,spell)
	local rows={};local range=self.WSpell.Range+100;local prediction=predict and Core:Prediction(spell or self.WFan)
	local function add(u,hero,lane)
		if #rows>=30 or not IsValid(u)or GetDistance(u.pos,myHero.pos)>range then return end
		local x,z=u.pos.x,u.pos.z
		if prediction and hero then prediction:GetPrediction(u,myHero);local p=prediction.UnitPosition;if p then x,z=p.x,p.z elseif u==target then return end end
		rows[#rows+1]={unit=u,x=x,z=z,radius=u.boundingRadius or 65,hero=hero,lane=lane}
	end
	if target then add(target,target.type==Obj_AI_Hero,target.type~=Obj_AI_Hero and target.team~=300)end
	local enemies=Core:DecisionUnits('GetEnemyHeroes');local others=0
	for i=1,math.min(#enemies,5)do local u=enemies[i];if u~=target and others<4 then others=others+1;add(u,true,false)end end
	for _,method in ipairs({'GetEnemyMinions','GetMonsters'})do
		for _,u in ipairs(Core:DecisionUnits(method))do if u~=target then add(u,false,method=='GetEnemyMinions'and u.team~=300)end end
	end
	return rows
end
function AsheChampion:FanPlan(target)
	local arrows,cone=self:FanShape();if not arrows or not IsValid(target)or target.type~=Obj_AI_Hero then return nil end
	local rows=self:FanRows(target,true);local main=rows[1]
	if not main or main.unit~=target then return nil end
	-- Until the Volley speed is measured, the champions are also predicted for the faster bound: the target must be
	-- hit under both, and only the champions hit under both are counted (Ashe-7).
	local alt=not self.volleySpeed.value and self:FanRows(target,true,self.WFanFast)or nil
	if alt and(not alt[1]or alt[1].unit~=target)then return nil end
	local base=math.atan2(main.z-myHero.pos.z,main.x-myHero.pos.x);local best
	for i=0,arrows-1 do
		local offset=-cone/2+(arrows>1 and cone*i/(arrows-1)or cone/2);local theta=wrap(base-offset)
		local hits,count=self:FanHits(theta,rows,arrows,cone)
		if alt and hits[target]then
			local altHits=self:FanHits(theta,alt,arrows,cone)
			if not altHits[target]then hits={}else count=0;for u in pairs(hits)do if altHits[u]and u.type==Obj_AI_Hero then count=count+1 end end end
		end
		if hits[target]and(not best or count>best.count or count==best.count and math.abs(offset)<math.abs(best.offset))then
			best={theta=theta,count=count,offset=offset,arrows=arrows,cone=cone}
		end
	end
	if not best then return nil end
	local distance=math.min(self.WSpell.Range,math.sqrt((main.x-myHero.pos.x)^2+(main.z-myHero.pos.z)^2))
	best.point=Vector(myHero.pos.x+math.cos(best.theta)*distance,myHero.pos.y,myHero.pos.z+math.sin(best.theta)*distance)
	-- A wind wall on the way to the target stops that arrow.
	local hit=Vector(main.x,myHero.pos.y,main.z)
	if OrbamaPrediction.GetCollision and OrbamaPrediction:GetCollision(myHero.pos,hit,self.WSpell.Speed,self.WSpell.Delay,self.WSpell.Radius,{OrbamaPrediction.COLLISION_YASUOWALL},target.networkID)then return nil end
	return best
end
function AsheChampion:CastFan(fan,target,validate)
	local theta,arrows,cone=fan.theta,fan.arrows,fan.cone
	self.volleyAt=Game.Timer();self.volleyAim=math.deg(theta)
	return Core:Cast(HK_W,fan.point,{prevalidateWorldCast=true,intentTarget=target,validate=function(q,resolved)
		if not IsValid(target)or GetDistance(target.pos,myHero.pos)>self.WSpell.Range+(target.boundingRadius or 65)then return false end
		local hits=self:FanHits(theta,self:FanRows(target,false),arrows,cone)
		return hits[target]==true and(not validate or validate(q,resolved))
	end})
end
-- Lane W: the minion aim whose arrows' first units include the most lane minions.
function AsheChampion:LaneFan(need)
	local arrows,cone=self:FanShape();if not arrows then return nil end
	local rows=self:FanRows(nil,false);local best,bestCount,tried=nil,0,0
	for _,row in ipairs(rows)do
		if row.lane and tried<8 then tried=tried+1
			local theta=math.atan2(row.z-myHero.pos.z,row.x-myHero.pos.x);local _,_,count=self:FanHits(theta,rows,arrows,cone)
			if count>bestCount then best,bestCount=row,count end
		end
	end
	if best and bestCount>=need then return best.unit,bestCount end
end
function AsheChampion:LaneFanCount(minion)
	local arrows,cone=self:FanShape();if not arrows or not IsValid(minion)then return 0 end
	local _,_,count=self:FanHits(math.atan2(minion.pos.z-myHero.pos.z,minion.pos.x-myHero.pos.x),self:FanRows(nil,false),arrows,cone)
	return count
end
-- Volley in a fight: never into a ready attack on a target in attack range, and
-- after the Ranger's Focus of that attack (Ashe-2).
function AsheChampion:WeaveOK(target)
	if not IsValid(target)or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return true end
	local q=Core.pending[HK_Q];if q and not q.sentAt then return false end
	return(Core:WeaveWindow(self.WSpell.Delay,target))
end
function AsheChampion:CombatW(mode)
	local node=Menu[mode]
	if not node.W:Value()or not IsReady(_W)or mode=='Harass'and(IsUnderTurret(myHero)or not Core.manaAbove(Menu.Harass.Mana:Value()))then return false end
	local target = GetTarget(self.WSpell.Range)
	if IsValid(target) and target.pos2D.onScreen then
		if self:WeaveOK(target)then return self:CastW(target)end
	elseif not IsValid(target)then
		local hidden=Core:SkillshotTarget(self.WSpell,2);if hidden then return self:CastW(hidden)end
	end
	return false
end
-- Flee: slow the nearest enemy champion closing in within 900 (Ashe-3).
function AsheChampion:Approaching(u)
	local to=u.pathing and u.pathing.hasMovePath and u.pathing.endPos or u.posTo
	return to~=nil and GetDistance(to,myHero.pos)+25<GetDistance(u.pos,myHero.pos)
end
function AsheChampion:Flee()
	if not IsReady(_W)then return false end
	local best,bestDistance;local enemies=Core:DecisionUnits('GetEnemyHeroes')
	for i=1,math.min(#enemies,5)do local u=enemies[i]
		if IsValid(u)then local d=GetDistance(u.pos,myHero.pos)
			if d<=self.profile.fleeRange and self:Approaching(u)and(not bestDistance or d<bestDistance)then best,bestDistance=u,d end
		end
	end
	if not best then return false end
	return self:CastW(best,function()return GetMode()=='Flee'and IsValid(best)and GetDistance(best.pos,myHero.pos)<=self.profile.fleeRange end)
end
-- Hawkshot aim (Ashe-9): the last-seen position advanced along the last observed
-- path for the arrow's flight, kept within the reveal of the last-seen point.
function AsheChampion:ScoutPoint(unit,row,range)
	local origin=Vector(row.pos);local point=origin
	local knowledge=Core:GetKnowledge()
	if knowledge and knowledge.Predict then
		local flight=GetDistance(row.pos,myHero.pos)/self.profile.eSpeed
		local ok,sample=pcall(knowledge.Predict,knowledge,unit,flight,{maxAge=2})
		if ok and sample and sample.pos then point=Vector(sample.pos)end
	end
	local limit=self.profile.eReveal-100;local d=GetDistance(point,origin)
	if d>limit then point=origin+(point-origin)*(limit/d)end
	if GetDistance(point,myHero.pos)>range then point=origin end
	return point
end
-- Classic Hawkshot is one 60 s cast: only for a target a follow-up can finish.
function AsheChampion:ScoutWorth(unit,row)
	if not self.profile.qToggle then return true end
	local health=row.health or unit.health;local maxHealth=row.maxHealth or unit.maxHealth
	if not Core.finite(health)or not Core.finite(maxHealth)or maxHealth<=0 then return false end
	if health/maxHealth<=self.profile.scoutHealth then return true end
	return IsReady(_W)and self:GetWDmg(unit)>=health+(row.shieldAD or 0)or IsReady(_R)and self:GetRDmg(unit)>=health+(row.shieldAP or 0)
end
function AsheChampion:ComboDamage(u)
	local total=0
	if IsReady(_W)then total=total+self:GetWDmg(u)end
	if IsReady(_R)then total=total+self:GetRDmg(u)end
	local ok,attack=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
	if ok and Core.finite(attack)then
		local okA,period=pcall(_G.SDK.Attack.GetAnimation,_G.SDK.Attack)
		if not okA or not Core.finite(period)or period<=.2 then period=1 end
		total=total+attack*math.max(1,math.floor(2/period))
	end
	return total,true
end
-- Volley speed calibration (Ashe-7) and development evidence. For 1.5 s after an own W (scripted or manual: the
-- cooldown starting), own Volley arrows are sampled every 30 ms: each arrow followed for at least 0.25 s gives one
-- speed (host position steps of a server tick then cost at most ~13%). Samples outside 0.75x..1.25x of the two
-- sources are discarded as broken observations; the median of the first three accepted samples, clamped to the
-- sources' range, becomes the speed every Volley prediction uses for the rest of the game. The development build
-- also records each sample and the host's own missile speed field (`ashe_volley_missile`).
local VOLLEY_SAMPLES,VOLLEY_SPAN=3,.25
function AsheChampion:AddVolleySample(speed)
	local state=self.volleySpeed;if state.value then return end
	local lo,hi=self.wSpeedLo,self.wSpeedHi
	if not Core.finite(speed)or speed<lo*.75 or speed>hi*1.25 then state.rejected=state.rejected+1;return end
	local samples=state.samples;samples[#samples+1]=speed
	if #samples<VOLLEY_SAMPLES then return end
	local sorted={};for i,v in ipairs(samples)do sorted[i]=v end;table.sort(sorted)
	state.median=sorted[math.floor((#sorted+1)/2)];state.value=math.max(lo,math.min(hi,state.median))
	self:ApplyWSpeed(state.value,state.value)
	if Core.logger then Core:Trace('ashe_volley_speed',{profile=self.profile.id,median=state.median,speed=state.value,samples=#samples,rejected=state.rejected})end
end
function AsheChampion:ObserveVolley()
	local now=Game.Timer();local cd=myHero:GetSpellData(_W).currentCd or 0
	if cd>0 and(self.wCooldownSeen or 0)<=0 and(not self.volleyAt or now-self.volleyAt>.5)then self.volleyAt=now end
	self.wCooldownSeen=cd
	if self.volleySpeed.value and not Core.logger then return end
	if not self.volleyAt or now-self.volleyAt>1.5 or not Game.MissileCount then return end
	if now<(self.nextVolleyScan or 0)then return end;self.nextVolleyScan=now+.03
	if self.volleySeenAt~=self.volleyAt then self.volleySeen={};self.volleySeenAt=self.volleyAt end
	local seen=self.volleySeen
	for i=1,math.min(128,Game.MissileCount())do
		local m=Game.Missile(i);local d=m and m.missileData;local name=d and d.name
		local owner=d and d.owner;if type(owner)=='table'or type(owner)=='userdata'then owner=owner.networkID or owner.handle end
		if name and m.pos and(owner==myHero.networkID or owner==myHero.handle)then
			for _,known in ipairs(self.profile.volleyMissiles)do if name==known then
				local key=m.networkID or m.handle;local row=key and seen[key]
				if key and not row then seen[key]={x=m.pos.x,z=m.pos.z,at=now}
				elseif row and not row.done and now-row.at>=VOLLEY_SPAN then row.done=true
					local dx,dz=m.pos.x-row.x,m.pos.z-row.z;local speed=math.sqrt(dx*dx+dz*dz)/(now-row.at)
					if Core.logger then Core:Trace('ashe_volley_missile',{profile=self.profile.id,name=name,rank=myHero:GetSpellData(_W).level,speed=speed,
						field=d.speed,direction=math.deg(math.atan2(dz,dx)),aim=self.volleyAim})end
					self:AddVolleySample(speed)
				end
				break
			end end
		end
	end
end

function AsheChampion:CastR(target,options)
	local RPrediction = Core:Prediction(self.RSpell)
	RPrediction:GetPrediction(target, myHero)
	if RPrediction:CanHit(3) then
		options=options or {};options.prevalidateWorldCast=true
		return Core:Cast(HK_R, RPrediction.CastPosition,options)
	end
end
function AsheChampion:GetRDmg(target)
	local base=self.profile.rDamage[myHero:GetSpellData(_R).level];if not base then return 0 end
	return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.rAP*myHero.ap,true,false)
end

function AsheChampion:Combo()
	self:CombatW('Combo')
	if (Menu.Combo.R:Value() or Menu.Combo.Raoe:Value()) and IsReady(_R) then
		-- The arrow opens a fight it can win on a target close enough to follow up, or lands on a group from afar.
		local function wanted(target)
			return IsValid(target) and (Menu.Combo.R:Value() and self:ComboRWanted(target)
				or Menu.Combo.Raoe:Value() and self:RGroupCount(target) >= 3)
		end
		local target = GetTarget(2000)
		if wanted(target) and target.pos2D.onScreen then
			self:CastR(target,{validate=function()return wanted(target)end})
		end
	end
end

function AsheChampion:Harass()
	if IsUnderTurret(myHero) then return end
	self:CombatW('Harass')
end

-- Turrets and monsters always; a lane minion only with a wave around Ashe (Q costs 30 mana).
function AsheChampion:FarmQTarget(target)
	if target.team==myHero.team then return false end
	if target.type==(Obj_AI_Turret or 'AITurretClient')or target.team==300 then return true end
	return target.type==Obj_AI_Minion and GetMinionCount(myHero.range+myHero.boundingRadius+65,myHero.pos)>=Menu.Clear.LaneClear.Count:Value()
end

function AsheChampion:ClearMode(jungle)
	local sdk=_G.SDK
	local mode=jungle and sdk.ORBWALKER_MODE_JUNGLECLEAR or sdk.ORBWALKER_MODE_LANECLEAR
	return sdk.Orbwalker.Modes[mode]==true
end

function AsheChampion:ClearContext(jungle,condition)
	local context=Core:ModeContext('LaneClear',function()return self:ClearMode(jungle)and(not condition or condition())end)
	context.modes={jungle and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or _G.SDK.ORBWALKER_MODE_LANECLEAR}
	return context
end

function AsheChampion:FarmHarass()
	if self:ClearMode(false)and Menu.Clear.SpellHarass:Value() then
		self:Harass()
	end
end

function AsheChampion:LaneClear()
	if not self:ClearMode(false)then return end
	if self:FarmAllowed() then
		if Menu.Clear.LaneClear.W:Value() and IsReady(_W) and self:FanShape() then
			local need=Menu.Clear.LaneClear.Count:Value();local minion=self:LaneFan(need)
			if minion then Core:Cast(HK_W,minion,{validate=function()return self:FarmAllowed()and Menu.Clear.LaneClear.W:Value()and IsValid(minion)and self:LaneFanCount(minion)>=Menu.Clear.LaneClear.Count:Value()end})end
			return
		end
		if Menu.Clear.LaneClear.W:Value() and IsReady(_W) then
			local minions = _G.SDK.ObjectManager:GetEnemyMinions(self.WSpell.Range)
			for i, minion in ipairs(minions) do
				if IsValid(minion) and minion.team ~= 300 then
					if GetMinionCount(300, minion.pos) >= Menu.Clear.LaneClear.Count:Value() then
						Core:Cast(HK_W, minion,{validate=function()return self:FarmAllowed()and Menu.Clear.LaneClear.W:Value()and IsValid(minion)end});return
					end
				end
			end
		end
	end
end

function AsheChampion:JungleClear()
	if not self:ClearMode(true)then return end
	if self:FarmAllowed() then
		if Menu.Clear.JungleClear.W:Value() and IsReady(_W) then
			local minions = _G.SDK.ObjectManager:GetMonsters(600)
			for i, minion in ipairs(minions) do
				if IsValid(minion) and minion.team == 300 then
					Core:Cast(HK_W, minion,{validate=function()return self:FarmAllowed()and Menu.Clear.JungleClear.W:Value()and IsValid(minion)end});return
				end
			end
		end
	end
end

function AsheChampion:GetWDmg(target)
	local level = myHero:GetSpellData(_W).level
	if level > 0 then
		local WDmg = self.profile.wDamage[level] + (myHero[self.profile.wAD] or 0)
		return _G.SDK.Damage:CalculateDamage(myHero, target, _G.SDK.DAMAGE_TYPE_PHYSICAL, WDmg)
	else
		return 0
	end
end

function AsheChampion:RegisterGuide(guide,settings)
	local qName=self.profile.qToggle and'Frost Shot'or"Ranger's Focus"
	local nodes={comboQ={node=Menu.Combo.Q,label='Combo '..qName},comboW={node=Menu.Combo.W,label='Combo Volley'},
		harassQ={node=Menu.Harass.Q,label='Harass '..qName},harassW={node=Menu.Harass.W,label='Harass Volley'},
		farm={node=Menu.Clear.SpellFarm,label='Spell farming'},farmHarass={node=Menu.Clear.SpellHarass,label='Clear harass'},
		multiR={node=Menu.Combo.Raoe,label='Grouped-target R'},comboR={node=Menu.Combo.R,label='Combo R'}}
	local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
	return guide:Register('champion',{'Ashe: quick start','Ashe: '..qName,'Ashe: arrow and farming'},function(page)
		if page==1 then return {title='Ashe: '..self.profile.id,subtitle=self.profile.qToggle and'Classic uses a mana-per-attack Q toggle.'or'Normal Q uses live Focus readiness and observed attack timing.',cards={
			{'COMBO','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..'. [[comboQ]] '..(self.profile.qToggle and'enables Frost Shot for an eligible attack.'or'waits for a completed observed attack and a valid Focus-ready buff.')..' [[comboW]] aims Volley with prediction and collision checks.'},
			{'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..'. [[harassQ]] and [[harassW]] have separate permissions. Harass Volley avoids casting while you are under an enemy turret.'},
			{'CONTROL','Releasing a mode cancels its waiting casts. Holding movement does not remove an eligible waiting combat skillshot. Manual R: '..settings.key(Menu.Misc.Rsm)..'. Harass casts stop below the Harass mana limit.'}},note='The profiles have separate damage and resource data. Arena, ARAM and live acceptance remain open.'}end
		if page==2 and not self.profile.qToggle then return {title="Ranger's Focus",subtitle='A PostAttack callback alone does not prove an attack occurred.',cards={
			{'ACTIVATION','The controller observes the native attack and waits for its windup to finish. Q needs the live Focus-ready buff and enough mana. An active Q buff, expired readiness or missing evidence prevents activation.'},
			{'STRUCTURES','Normal attacks can build Focus on structures. Clear Q follows its lane and jungle settings, together with Spell farming. The controller reads readiness rather than inventing stacks from issued attacks.'},
			{'CANCELLATION','The original mode, target reach, readiness and farm permission remain binding until send. Releasing the mode cancels waiting Q. Normal Q never uses Classic toggle cleanup.'}},note='The attack observer is shared with Blitzcrank. Champion-specific spell and resource rules remain here.'}end
		if page==2 then return {title='Frost Shot ownership',subtitle='Turning on Q costs mana on subsequent attacks in Classic.',cards={
			{'START','Q may be requested only for a permitted attack against a living champion in reach. A denied PreAttack callback cannot enable it. An input request alone does not establish that the toggle changed.'},
			{'LEAVING COMBAT','After an attributable Q-on observation, the controller may turn its own toggle off outside Combo and Harass. Returning to combat cancels a waiting Q-off request.'},
			{'MANUAL Q','An already active manual toggle is preserved. A manual Q input relinquishes automatic ownership. Uncertain input does not establish ownership and is never blindly repeated.'}},note='No gameplay input is sent while chat, focus, death or an active channel blocks execution.'}end
		return {title='Enchanted Crystal Arrow and farm',subtitle='Champion interception matters for R; nearby units alone do not prove a Volley fan hit.',cards={
			{'ULTIMATE','Hold the Misc ultimate bind to aim at a valid selection, otherwise the nearest valid on-screen enemy to your cursor. Other champions and projectile walls can intercept the arrow. [[comboR]] fires on a Combo target within 1000 units when the arrow kills, kills together with the attacks and Volley that fit into its stun, catches a second enemy in its area, or the target is at half health or less; never on a lone full-health target. [[multiR]] keeps its separate permission.'},
			{'CLEAR','Lane: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..'. Jungle: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_JUNGLECLEAR)..'. [[farm]] uses the matching held mode. [[farmHarass]] needs lane clear. Farm Q applies only to minions, monsters and structures, never champions. Farm Q and W stop below the farming mana limit. A Volley that kills an enemy is always cast.'},
			{'ASSISTANCE','Last-seen Hawkshot uses a recently observed combat target and one request per disappearance. Its destination needs provider-confirmed world positioning. Optional R reactions use shared prediction and fresh channel, dash or lethal checks. Interrupt R requires explicit native interruptibility evidence.'},
			{'LIMITS',(self.profile.qToggle and'Classic lane W uses a nearby-minion count: its arrow fan is not measured yet.'or'Volley aims its arrow fan at the most champions and counts lane minions by the first unit each arrow meets.')..' The R finishers, channel and dash reactions, low-health self-peel, keyless R on three or more and last-seen Hawkshot all start enabled.'}},note='No automatic Flash, shopping or global manual-Q takeover.'}
	end,cfg,links,activate)
end

function AsheChampion:Draw()
	if myHero.dead then return end

	if Menu.Draw.R:Value() and IsReady(_R) then
		Draw.Circle(myHero.pos, Menu.Misc.ReactiveRRange:Value(), 1, Draw.Color(255, 120, 200, 255))
	end

	if Menu.Draw.W:Value() and IsReady(_W) then
		Draw.Circle(myHero.pos, self.WSpell.Range, 1, Draw.Color(255, 66, 229, 244))
	end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:RegisterPolicy({
    damageTypes={W='physical'},
    methods={

        OnPreAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode) or nil end,
        OnPostAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode) or nil end,

        Combo=function()return Core:ModeContext("Combo")end,
        Harass=function()return Core:ModeContext("Harass")end,
        Flee=function()return Core:ModeContext("Flee")end,
        LaneClear=function(self)return self:ClearContext(false,function()return Menu.Clear.SpellFarm:Value()end)end,
        JungleClear=function(self)return self:ClearContext(true,function()return Menu.Clear.SpellFarm:Value()end)end,
        FarmHarass=function(self)return self:ClearContext(false,function()return Menu.Clear.SpellHarass:Value() and not IsUnderTurret(myHero)end)end,
        SemiManualR=function()return Core:HeldContext(function()return Menu.Misc.Rsm:Value()end)end,
        ReleaseFrost=function()return Core:HeldContext(function()return GetMode()~='Combo' and GetMode()~='Harass' end)end,
    },
    costPaid=function(self,q,slot)return self.profile.qToggle and slot==_Q and myHero:GetSpellData(_Q).toggleState==2 end,
    exceptions={non_interrupting_summoner=true},
    channel=function(self,q)return not Core:SelfChanneling() end,
    validate=function(self,q,slot,resolved)
        if slot==_Q then
            if q.owner=='Combo' or q.owner=='Harass'then return myHero:GetSpellData(_Q).toggleState~=2 end
        end
        return true
    end,
})

AsheChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Ashe"]="Ashe"}
local normalSupported={["Ashe"]=true}

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
