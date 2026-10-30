return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Ryze"]=function()return _G.OrbamaFamily:Require("71503c3c02ed4c78c831410a4c4cea9118b990180ad7905fe0af69e1c6c95889")()end
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
if champion=="Ryze" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Ryze',profiles={normal=true,classic=true},
 Create=function(context)
local Version=1.04
-- Profiles and unresolved host semantics are recorded in CombatProfiles/ryze-provenance.json. Damage, ranges and
-- speeds come from AbilityProfiles; the numbers those rows lack come from ChampionProfiles/Ryze.lua (self.data).
local profiles=AbilityProfiles.controllers.Ryze
local extra=ChampionProfiles('Ryze')
local finite=Core.finite
local function valid(u)return IsValid(u)and u.pos and u.team~=myHero.team and u.pos:ToScreen().onScreen end
local function still(u)return u.pathing and u.pathing.hasMovePath==false and not u.pathing.isDashing end
local keys={HK_Q,HK_W,HK_E};local letters={'Q','W','E'}
local RyzeChampion=class("RyzeChampion")
function RyzeChampion:__init()
 self.profile=assert(profiles[myHero.charName],'Unsupported Ryze profile');self.data=assert(extra[myHero.charName],'Unsupported Ryze profile')
 self.QSpell=AbilityProfiles.Spell(myHero.charName,'Q',OrbamaPrediction)
 self.QSpell.Type=OrbamaPrediction.SPELLTYPE_LINE;self.QSpell.Collision=true
 self.QSpell.CollisionTypes={OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL}
 -- Lane spread Q: the aim ignores collision because SpreadLine judges every unit on the line itself.
 self.SpreadSpell={};for key,value in pairs(self.QSpell)do self.SpreadSpell[key]=value end
 self.SpreadSpell.Collision=false;self.SpreadSpell.CollisionTypes=nil
 self.WSpell=AbilityProfiles.Spell(myHero.charName,'W',OrbamaPrediction)
 self.ESpell=AbilityProfiles.Spell(myHero.charName,'E',OrbamaPrediction);self.ESpell.BounceRange=self.profile.spread;self.RSpell={Range=3000}
 -- Longest targeted reach of this profile's data (W/E, and the targeted Classic Q); pre-filters only.
 self.reach=math.max(self.WSpell.Range,self.ESpell.Range,self.profile.id=='classic'and self.QSpell.Range or 0)
 self.comboTargetExpire=0;self.runes={count=nil,expires=0};self.observedCast=nil
 self:LoadMenu();Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPreAttack(function(args)self:OnPreAttack(args)end)
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
 self:RegisterEvade()
end
-- Health-bar damage (S9): ready Q/W/E with their current marks plus one attack; partial (passive, R).
function RyzeChampion:ComboDamage(u)
 if not valid(u)then return 0 end
 local total=0;for slot=0,2 do if IsReady(slot)then total=total+self:Damage(slot,u)end end
 local ok,aa=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
 return total+(ok and finite(aa)and aa or 0),true
end
-- Classic Desperate Power offered to Evade as flat movement speed (S6; asset + wiki rows in self.data), no cast
-- time, only while R is ready and not already active. Normal Realm Warp is a 2 s channel: no offer.
function RyzeChampion:RegisterEvade()
 local d=self.data
 if self.profile.id~='classic'or not Core.RegisterEffect or not d.rHaste then return end
 local function rank()local r=myHero:GetSpellData(_R);return r and r.level or 0 end
 self.hasteOffered,self.hasteReason,self.hasteAdapter=Core:RegisterEffect({kind='haste',name='Ryze.R',slot=_R,key=HK_R,profile='classic',source=d.rSource,
  delay=0,ultimate=true,duration=function()return d.rDuration[rank()]end,flat=function()return d.rHaste[rank()]end,
  ready=function()return not self:Buff(myHero,self.profile.rBuff,true)end})
end
function RyzeChampion:LoadMenu()
	local championIcon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/".."Ryze"..".png"
	Menu = MenuElement({type = MENU, id = "Classic_AIO_"..myHero.charName, name='AyyyyIO - Ryze', leftIcon = championIcon})

	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "DisableAA", name = "Do not let an attack cut off a spell cast", value = true, menu = false})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.Combo:MenuElement({id = "W", name = "Use W", value = true})
	Menu.Combo:MenuElement({id = "E", name = "Use E", value = true})
	if self.profile.id=='classic' then
	Menu.Combo:MenuElement({id = "R", name = "Use R", value = true})
	Menu.Combo:MenuElement({id = "RCount", name = "R when this many enemies are near", value = 2, min = 1, max = 5, step = 1, menu = false})
	Menu.Combo:MenuElement({id = "RHP", name = "R when your health is below %", value = 35, min = 0, max = 100, step = 5, menu = false})
	end
	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.Harass:MenuElement({id = "W", name = "Use W", value = true})
	Menu.Harass:MenuElement({id = "E", name = "Use E", value = true})
	Menu.Harass:MenuElement({id = "Mana", name = "Only above mana %", value = 40, min = 0, max = 100, step = 5})

	Menu:MenuElement({type = MENU, id = "Clear", name = "Farming"})
	Menu.Clear:MenuElement({id = "SpellFarm", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(newValue)
		if CheckChatBlock(Menu.Clear.SpellFarm, newValue) then return end
	end})
	Menu.Clear:MenuElement({id = "SpellHarass", name = "Harass champions while lane clearing", value = true})
	Menu.Clear:MenuElement({type = MENU, id = "LaneClear", name = "Lane clear"})
	Menu.Clear.LaneClear:MenuElement({id = "Q", name = self.profile.id=='normal' and "Use Q on killable or E-marked minions" or "Use Q on minions it kills", value = true})
	Menu.Clear.LaneClear:MenuElement({id = "E", name = "Use E", value = true})
	Menu.Clear.LaneClear:MenuElement({id = "ECount", name = "Lane minions E must spread to", value = 2, min = 1, max = 6, step = 1, menu = false})
	Menu.Clear.LaneClear:MenuElement({id = "Mana", name = "Only above mana %", value = 20, min = 0, max = 100, step = 5})
	Menu.Clear:MenuElement({type = MENU, id = "JungleClear", name = "Jungle clear"})
	Menu.Clear.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.Clear.JungleClear:MenuElement({id = "W", name = "Use W", value = true})
	Menu.Clear.JungleClear:MenuElement({id = "E", name = "Use E", value = true})

	Menu:MenuElement({type = MENU, id = "KillSteal", name = "Finish kills without holding a mode key"})
	Menu.KillSteal:MenuElement({id = "Q", name = "Use Q", value = true})
	Menu.KillSteal:MenuElement({id = "W", name = "Use W", value = true})
	Menu.KillSteal:MenuElement({id = "E", name = "Use E", value = true})

	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "Q", name = "Q range", value = false})
	Menu.Draw:MenuElement({id = "W", name = "W range", value = false})
	Menu.Draw:MenuElement({id = "E", name = "E range", value = false})
	if self.profile.id=='normal' then Menu.Draw:MenuElement({id = "R", name = "R range (when ready)", value = false}) end
 Menu.Combo:MenuElement({id='Mana',name='Only above mana %',value=0,min=0,max=100,step=5})
 Menu.Clear.JungleClear:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu.Clear.LaneClear:MenuElement({id='W',name='Use W on minions it kills',value=true})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 for _,name in ipairs({'Q','W','E'})do Menu.LastHit:MenuElement({id=name,name='Use '..name,value=true})end
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 -- Normal spell order is fixed, not a menu: W is kept for the root on a target marked by E, Combo roots first
 -- (E, W, then Q on a target that cannot move), Harass pokes with E into Q, and Q always bounces off a marked
 -- unit to reach a marked target beyond its range.
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='AntiDash',name=self.profile.id=='normal'and 'Mark and root enemies that dash at you'or 'Root enemies that dash at you (W)',value=true})
 Menu.Misc:MenuElement({id='FleeW',name=self.profile.id=='normal'and 'Flee: slow the chaser and run faster'or 'Flee: root or slow the nearest enemy chasing you',value=true})
 if self.profile.id=='classic'then Menu.Misc:MenuElement({id='FleeR',name='Flee: use R for speed',value=true})end
 if self.profile.id=='normal'then
  Menu:MenuElement({type=MENU,id='Warp',name='R (Realm Warp)'})
  Menu.Warp:MenuElement({id='Key',name='Cast R at the cursor',key=string.byte('T')})
  Menu.Warp:MenuElement({id='Safe',name='Refuse destinations with enemies or turrets',value=true,menu=false})
  Menu.Warp:MenuElement({id='Draw',name='Show the warp destination',value=true})
 end
end

function RyzeChampion:Buff(unit,alias,owned,at)
 local count=unit and unit.buffCount;if not finite(count)or count%1~=0 or count<0 or count>128 then return nil end
 for i=0,count do local b=unit:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==alias and finite(b.count)and b.count>0 then
   local expiry=Core.buffExpiry(b)
   local source=b.source or b.caster;local kind=type(source)
   local id=kind=='number'and source or(kind=='table'or kind=='userdata')and(source.networkID or source.handle)
   local ours=id==myHero.networkID or id==myHero.handle
   if finite(expiry)and expiry>(at or Game.Timer())and(not owned or ours or unit==myHero and source==nil)then return b,expiry end
  end
 end
end
function RyzeChampion:Flux(unit,impact)return self:Buff(unit,self.profile.flux,true,Game.Timer()+(impact or 0))~=nil end
function RyzeChampion:ObserveState()
 -- Short-lived waits (bridge, diver mark, probes) expire on their own within a second; death clears them at once.
 if myHero.dead then self.runes={count=nil,expires=0};self.rootIntent=nil;self.warpPreview=nil;self.bridgeIntent=nil;self.antiDive=nil;self.eProbe=nil;self.qProbe=nil;return end
 local now=Game.Timer();if self.runes.count and self.runes.expires<=now then self.runes.count=0 end
 local cast=myHero.activeSpell
 if self.profile.id~='normal'or not cast or not cast.valid or not finite(cast.startTime)or type(cast.name)~='string'then return end
 if cast.startTime>now+.05 or cast.startTime<now-1 or self.observedCastAt and cast.startTime<=self.observedCastAt then return end
 local name=cast.name:lower();local stamp=name..':'..tostring(cast.startTime)
 if stamp==self.observedCast then return end
 if name=='ryzeq'or name=='ryzeqwrapper'then self.runes={count=0,expires=now};self.observedCast=stamp;self.observedCastAt=cast.startTime
 elseif name=='ryzew'or name=='ryzee'then
  -- Only observed casts following an observed Q establish the charge estimate.
  -- Missing native rune state is never interpreted as two charges.
  if self.runes.count then self.runes.count=math.min(2,self.runes.count+1);self.runes.expires=cast.startTime+4 end
  self.observedCast=stamp;self.observedCastAt=cast.startTime
 end
end
function RyzeChampion:OnPreAttack(args)
 if not args or args.Process==false or GetMode()~='Combo'or not Menu.Combo.DisableAA:Value()or not valid(args.Target)then return end
 local cast=myHero.activeSpell
 if cast and cast.valid and not _G.SDK.Attack:IsActive()and Core:HasObservedSpell()then
  local name=type(cast.name)=='string'and cast.name:lower()or ''
  if name:find('ryze',1,true)and finite(cast.castEndTime)and cast.castEndTime>Game.Timer()then args.Process=false end
 end
end
function RyzeChampion:ManaAllowed(menu)return not menu.Mana or Core.manaAbove(menu.Mana:Value())end
-- Fixed Normal spell order (see LoadMenu): 2 roots first (Combo), 1 ranks by damage (Harass, Classic).
function RyzeChampion:Intent(menu)return self.profile.id=='normal'and menu==Menu.Combo and 2 or 1 end
-- An unmarked Normal W only slows: once E is learned W waits for the mark. Finishers and Flee do not ask this.
function RyzeChampion:RootOnly()return self.profile.id=='normal'and myHero:GetSpellData(_E).level>0 end
function RyzeChampion:ClearMode(jungle)return _G.SDK.Orbwalker.Modes[jungle and _G.SDK.ORBWALKER_MODE_JUNGLECLEAR or _G.SDK.ORBWALKER_MODE_LANECLEAR]==true end
function RyzeChampion:Cost(slot)local d=myHero:GetSpellData(slot);return d and finite(d.mana)and math.max(0,d.mana)or math.huge end
function RyzeChampion:Range(slot)return slot==_Q and self.QSpell.Range or slot==_W and self.WSpell.Range or self.ESpell.Range end
function RyzeChampion:Impact(slot,target)return .25+(slot==_W and 0 or GetDistance(myHero.pos,target.pos)/(slot==_Q and self.profile.qSpeed or self.profile.eSpeed))end
-- Ryze-5: Normal Q/W/E scale with BONUS mana (Arcane Mastery mana is bonus mana): maximum mana minus the base
-- curve 300 + 70 (n-1)(0.7025 + 0.0175 (n-1)) at champion level n; 0 when the host values are not finite.
function RyzeChampion:BonusMana()
 local d=self.data;local n=myHero.levelData and myHero.levelData.lvl
 if not d.manaBase or not finite(myHero.maxMana)or not finite(n)or n<1 or n>18 then return 0 end
 local base=d.manaBase+d.manaGrowth*(n-1)*(.7025+.0175*(n-1))
 return math.max(0,myHero.maxMana-base)
end
-- Ryze-12: Classic E lowers magic resistance while our mark is on the target. Applied to Q/W only once the own
-- mark is seen (never to the E itself). Penetration is left out, which understates the gain (conservative).
function RyzeChampion:ShredFactor(slot,target,impact)
 local d=self.data;if self.profile.id~='classic'or slot==_E or not d.eShred then return 1 end
 local shred=d.eShred[myHero:GetSpellData(_E).level];local mr=target and target.magicResist
 if not shred or not finite(mr)or not self:Flux(target,impact or self:Impact(slot,target))then return 1 end
 local function m(x)return x>=0 and 100/(100+x)or 2-100/(100-x)end
 return m(mr-shred)/m(mr)
end
function RyzeChampion:FluxMultiplier()
 local rank=math.max(0,math.min(3,myHero:GetSpellData(_R).level))
 return 1+self.data.fluxBonus[rank+1]
end
function RyzeChampion:Damage(slot,target,impact,unmarked)
 local rank=myHero:GetSpellData(slot).level;local base=self.profile.base[slot+1]and self.profile.base[slot+1][rank];if not base then return 0 end
 local mana=self.profile.id=='classic'and myHero.maxMana or self:BonusMana()
 local raw=base+self.profile.ap[slot+1]*myHero.ap+self.profile.mana[slot+1]*mana
 if not unmarked and self.profile.id=='normal'and slot==_Q and self:Flux(target,impact or self:Impact(slot,target))then
  raw=raw*self:FluxMultiplier()
 end
 local factor=unmarked and 1 or self:ShredFactor(slot,target,impact)
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)*factor
end
function RyzeChampion:GetQDmg(t)return self:Damage(_Q,t)end
function RyzeChampion:GetWDmg(t)return self:Damage(_W,t)end
function RyzeChampion:GetEDmg(t)return self:Damage(_E,t)end
function RyzeChampion:MagicHealth(t,impact)return t.health+math.max(0,t.shieldAP or 0)+math.max(0,t.hpRegen or 0)*(impact or 0)end
-- Champions go through the shared kill rule (spell protection, shield pools, health window); minions keep the
-- strict current-health comparison that FarmLethal combines with the provider's forecast.
function RyzeChampion:Lethal(slot,target,impact)
 if not valid(target)then return false end
 impact=impact or self:Impact(slot,target)
 if target.type==Obj_AI_Hero then return Core:Lethal(target,impact,function()return self:Damage(slot,target,impact)end,{kind='magical'})==true end
 return self:Damage(slot,target,impact)>self:MagicHealth(target,impact)
end
function RyzeChampion:SelectedAllows(target,range)
 local selected=_G.SDK.TargetSelector.Selected
 return not valid(selected)or GetDistance(selected.pos,myHero.pos)>range or selected.networkID==target.networkID
end
function RyzeChampion:GetComboTarget(range)
 local selected=_G.SDK.TargetSelector.Selected
 if valid(selected)and GetDistance(selected.pos,myHero.pos)<=range then return selected end
 if GetTickCount()<self.comboTargetExpire and valid(self.comboTarget)and GetDistance(self.comboTarget.pos,myHero.pos)<=range then return self.comboTarget end
 local target=GetTarget(range);if valid(target)then return target end
end
function RyzeChampion:SetComboTarget(target)self.comboTarget=target;self.comboTargetExpire=GetTickCount()+2500 end
function RyzeChampion:Objects()
 local mc,hc=Game.MinionCount(),Game.HeroCount()
 if not finite(mc)or not finite(hc)or mc%1~=0 or hc%1~=0 or mc>256 or hc>24 or mc<0 or hc<0 then return nil end
 local out,seen={},{}
 for kind=1,2 do for i=1,(kind==1 and mc or hc)do local u=kind==1 and Game.Minion(i)or Game.Hero(i)
  if u and u.pos and u.valid and u.alive and not u.dead and u.health>0 and u.isTargetable and u.team~=myHero.team and u.networkID
   and not seen[u.networkID]and GetDistance(u.pos,myHero.pos)<=2000 then
   seen[u.networkID]=true;out[#out+1]=u;if #out>64 then return nil end
  end
 end end
 return out
end
function RyzeChampion:WallFree(slot,target)
 if slot==_W then return true end
 local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,target.pos,slot==_Q and self.profile.qSpeed or self.profile.eSpeed,.25,30,{OrbamaPrediction.COLLISION_YASUOWALL},target.networkID)
 return wall==false and count==0
end
function RyzeChampion:Legal(slot,target)
 return valid(target)and GetDistance(target.pos,myHero.pos)<=self:Range(slot)and IsReady(slot)and myHero.mana>=self:Cost(slot)
end
function RyzeChampion:BouncePair(first,target)
 if self.profile.id~='normal'or not valid(first)or not valid(target)or first.networkID==target.networkID or not still(first)or not still(target)
  or GetDistance(first.pos,myHero.pos)>self.QSpell.Range then return false end
 local radius=first.type==Obj_AI_Hero and self.data.qBounceLarge or self.data.qBounceSmall
 if GetDistance(first.pos,target.pos)>radius then return false end
 local impact=self:Impact(_Q,first)+GetDistance(first.pos,target.pos)/1500
 if not self:Flux(first,impact)or not self:Flux(target,impact)then return false end
 if first.type==Obj_AI_Minion then local hp=_G.SDK.HealthPrediction:GetPrediction(first,self:Impact(_Q,first));if not finite(hp)or hp<=0 then return false end end
 local wall,_,count=OrbamaPrediction:GetCollision(first.pos,target.pos,1500,self:Impact(_Q,first),55,{OrbamaPrediction.COLLISION_YASUOWALL},target.networkID)
 if wall~=false or count~=0 then return false end
 return true,impact
end
-- The nearest unit on the direct line to `target` (collision ignored for the aim), or nil when the line is clear
-- or a wind wall stands on it. Ryze-1(a): a marked, stationary blocker carries Q on to a marked target.
function RyzeChampion:FirstBlocker(target)
 local p=Core:Prediction(self.SpreadSpell);p:GetPrediction(target,myHero);local aim=p.CastPosition
 if not aim or not finite(aim.x)then return nil end
 local s=self.QSpell
 local wall,hits=OrbamaPrediction:GetCollision(myHero.pos,aim,s.Speed,s.Delay,s.Radius,s.CollisionTypes,target.networkID)
 if wall~=false or type(hits)~='table'then return nil end
 local best,d
 for i=1,math.min(#hits,16)do local u=hits[i];if u and u.pos and(not d or GetDistance(u.pos,myHero.pos)<d)then best,d=u,GetDistance(u.pos,myHero.pos)end end
 return best
end
-- Nothing else stands between Ryze and the first recipient of a bounced Q (wind walls included).
function RyzeChampion:LineToFirst(first)
 local s=self.QSpell
 local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,first.pos,s.Speed,s.Delay,s.Radius,s.CollisionTypes,first.networkID)
 return wall==false and(count or 0)==0
end
function RyzeChampion:CastQ(target,bounce,validate,owner,confidence)
 if not valid(target)or not IsReady(_Q)then return false end
 local first=target;local pair=false
 if GetDistance(target.pos,myHero.pos)>self.QSpell.Range then
  if not bounce or self.profile.id~='normal'then return false end
  local list=self:Objects();if not list then return false end
  first=nil
  for i=1,math.min(#list,24)do if self:BouncePair(list[i],target)then first=list[i];break end end
  if not first then return false end;pair=true
 elseif bounce and self.profile.id=='normal'then
  local direct=Core:Prediction(self.QSpell);direct:GetPrediction(target,myHero)
  if not direct:CanHit(confidence or OrbamaPrediction.HITCHANCE_HIGH)then
   local blocker=self:FirstBlocker(target)
   if blocker and valid(blocker)and self:BouncePair(blocker,target)and self:LineToFirst(blocker)then first=blocker;pair=true end
  end
 end
 local function allowed()
  if not valid(target)or not self:Legal(_Q,first)then return false end
  local at=self:Impact(_Q,first)
  if pair then local ok;ok,at=self:BouncePair(first,target);if not ok or not self:LineToFirst(first)then return false end end
  return (not validate or validate(target,at,pair))and(self.profile.id=='normal'or self:WallFree(_Q,first))
 end
 if not allowed()then return false end
 if self.profile.id=='classic'then return Core:Cast(HK_Q,first,{owner=owner,intentTarget=first,range=self.QSpell.Range,validate=allowed})end
 local prediction=Core:Prediction(self.QSpell);prediction:GetPrediction(first,myHero)
 -- Providers assign non-hero predictions Normal confidence. BouncePair already
 -- requires this first recipient to remain stationary and marked through impact.
 local chance=confidence or(pair and first.type~=Obj_AI_Hero and OrbamaPrediction.HITCHANCE_NORMAL or OrbamaPrediction.HITCHANCE_HIGH)
 if not prediction:CanHit(chance)then return false end
 local ok=Core:Cast(HK_Q,prediction.CastPosition,{owner=owner,intentTarget=first,range=self.QSpell.Range,prevalidateWorldCast=true,validate=allowed})
 if ok and pair and Core.logger then local row={first=first,target=target,distance=GetDistance(first.pos,target.pos),large=first.type==Obj_AI_Hero,health=target.health}
  Core:AfterCast(HK_Q,function()row.at=Game.Timer();self.qProbe=row end)end
 return ok
end
function RyzeChampion:CastTarget(slot,target,validate,owner)
 local function allowed()return self:Legal(slot,target)and self:WallFree(slot,target)and(not validate or validate(target,self:Impact(slot,target)))end
 if not allowed()then return false end
 local ok=Core:Cast(keys[slot+1],target,{owner=owner,intentTarget=target,range=self:Range(slot),validate=allowed})
 if ok and slot==_E and Core.logger then local distance=GetDistance(target.pos,myHero.pos)
  Core:AfterCast(HK_E,function()self.eProbe={target=target,at=Game.Timer(),distance=distance}end)end
 return ok
end
-- Ryze-11: the cooldown a cast starts. The host's current total cooldown (ability haste, Classic Q passive) when it
-- reports one, else the base values (wiki 2026-10-10). Ranking only: dispatch reads actual readiness.
function RyzeChampion:Cooldown(slot,d)
 d=d or myHero:GetSpellData(slot)
 if d and finite(d.cd)and d.cd>0 and d.cd<60 then return d.cd end
 local level=d and d.level or 1
 if self.profile.id=='normal'then return slot==_Q and 5 or slot==_W and(11.5-.5*level)or(3.75-.25*level)end
 return slot==_Q and 3.5 or 14
end
-- A bounded three-cast forecast ranks the next action. Every later action is
-- replanned from observed readiness/marks; simulated resets never authorize input.
function RyzeChampion:Plan(target,menu)
 local normal=self.profile.id=='normal';local now=Game.Timer();local distance=GetDistance(target.pos,myHero.pos)
 local initial={mana=myHero.mana,cd={},damage=0,time=0,flux=self:Flux(target),runes=self.runes.count,first=nil}
 local damage,cost,cds,enabled={},{},{},{}
 for slot=0,2 do local d=myHero:GetSpellData(slot);cost[slot]=self:Cost(slot);initial.cd[slot]=math.max(0,d.currentCd or 0)
  enabled[slot]=menu[letters[slot+1]]and menu[letters[slot+1]]:Value()and d.level>0 and distance<=self:Range(slot)
  -- Normal: marks are simulated below; Classic: the E shred is credited only for a mark already seen.
  damage[slot]=self:Damage(slot,target,self:Impact(slot,target),normal)
  cds[slot]=self:Cooldown(slot,d)
 end
 local intent=self:Intent(menu);local rootOnly=self:RootOnly();local best={};local nodes=0
 local health=self:MagicHealth(target,1)
 local function walk(state,depth)
  if depth==3 then return end
  for slot=0,2 do
   if enabled[slot]and state.mana>=cost[slot]and(slot~=_W or not rootOnly or state.flux)then
    local wait=math.max(0,state.cd[slot]);local start=state.time+wait
    if start<=1.5 and(depth>0 or wait==0 and IsReady(slot))then
     nodes=nodes+1;local next={mana=state.mana-cost[slot],cd={},time=start+.25,first=state.first or slot,flux=state.flux,runes=state.runes,damage=state.damage,utility=state.utility or 0}
     for k=0,2 do next.cd[k]=math.max(0,state.cd[k]-wait-.25)end
     next.cd[slot]=cds[slot]
     local hit=damage[slot]
     if normal then
      if slot==_Q then
       if state.flux then hit=hit*self:FluxMultiplier()end
       next.runes=0;next.flux=false
      else
       next.cd[_Q]=0;if next.runes then next.runes=math.min(2,next.runes+1)end
       if slot==_E then next.flux=true elseif state.flux then next.flux=false;if intent==2 then next.utility=next.utility+150 end end
      end
     else
      for k=0,2 do if k~=slot then next.cd[k]=math.max(0,next.cd[k]-1)end end
      if slot==_E and not state.flux then next.flux=true;next.utility=next.utility+12 end
     end
     next.damage=math.min(health,state.damage+hit)
     local score=next.damage+next.utility-next.time*25-(myHero.mana-next.mana)*.04
     if next.damage>=health then score=score+200 end
     if not best[next.first]or score>best[next.first].score then best[next.first]={slot=next.first,score=score,estimatedDamage=next.damage,seconds=next.time}end
     if next.damage<health then walk(next,depth+1)end
    end
   end
  end
 end
 walk(initial,0);local out={};for slot=0,2 do if best[slot]then out[#out+1]=best[slot]end end
 table.sort(out,function(a,b)if a.score==b.score then return a.slot<b.slot end;return a.score>b.score end)
 self.preview={target=target.networkID,choices=out,nodes=nodes,at=now,runes=self.runes.count};return out
end
function RyzeChampion:CombatAllowed(menu,target)
 return self:ManaAllowed(menu)and valid(target)and self:SelectedAllows(target,self.profile.id=='normal'and 1500 or self.reach)
end
function RyzeChampion:RootFollowup(menu,target)
 if self:Intent(menu)~=2 or not menu.W:Value()or not IsReady(_W)or not self:CombatAllowed(menu,target)then return false end
 if self:Flux(target,.25)then
  return self:CastTarget(_W,target,function()return self:CombatAllowed(menu,target)and menu.W:Value()and self:Flux(target,.25)end)
 end
 if menu.E:Value()and IsReady(_E)and myHero.mana>=self:Cost(_E)+self:Cost(_W)then
  local function allowed()return self:CombatAllowed(menu,target)and menu.E:Value()and menu.W:Value()and IsReady(_W)and myHero.mana>=self:Cost(_E)+self:Cost(_W)end
  if self:CastTarget(_E,target,allowed)then
   local q=Core.lastIntent
   if q then Core:AfterCast(HK_E,function()
    self.rootIntent={target=target,menu=menu,request=q,expires=Game.Timer()+self:Impact(_E,target)+.3}
   end)end
   return true
  end
 end
 return false
end
function RyzeChampion:ClassicR(target)
 if self.profile.id~='classic'or not Menu.Combo.R:Value()or not IsReady(_R)then return false end
 local function allowed()
  if not self:CombatAllowed(Menu.Combo,target)or GetDistance(target.pos,myHero.pos)>self.reach or self:Buff(myHero,self.profile.rBuff,true)then return false end
  local useful=false
  for slot=0,2 do if Menu.Combo[letters[slot+1]]:Value()and self:Legal(slot,target)and myHero.mana>=self:Cost(_R)+self:Cost(slot)and self:Damage(slot,target)>0 and self:WallFree(slot,target)then useful=true end end
  if not useful then return false end
  local list=Core:DecisionUnits('GetEnemyHeroes');if #list>24 then return false end
  local count=0;for i=1,#list do if valid(list[i])and GetDistance(list[i].pos,myHero.pos)<=700 then count=count+1 end end
  return count>=Menu.Combo.RCount:Value()or myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100<=Menu.Combo.RHP:Value()
 end
 if allowed()then return Core:Cast(HK_R,nil,{validate=allowed})end
 return false
end
function RyzeChampion:Combat(menu)
 if not self:ManaAllowed(menu)then return end
 -- Normal: 1500 covers a Q bounced off a marked unit to a marked target beyond the 1000 line.
 local range=self.profile.id=='normal'and 1500 or self.reach
 local target=self:GetComboTarget(range);if not valid(target)then return end
 self:SetComboTarget(target)
 local root=self.rootIntent
 if root then
  if Game.Timer()>root.expires or not root.request.continue()or root.target.networkID~=target.networkID or root.menu~=menu or self:Intent(menu)~=2 then self.rootIntent=nil
  elseif self:Flux(target,.25)then self.rootIntent=nil;if self:RootFollowup(menu,target)then return end
  else return end
 end
 local function permission(slot)return self:CombatAllowed(menu,target)and menu[letters[slot+1]]:Value()end
 -- Ryze-1(b): an E bridge is in flight; Q goes once both marks are seen.
 local bridge=self.bridgeIntent
 if bridge then
  if Game.Timer()>bridge.expires or not bridge.request.continue()or bridge.target.networkID~=target.networkID or bridge.menu~=menu then self.bridgeIntent=nil
  elseif self:Flux(target,.4)and self:Flux(bridge.first,.4)then self.bridgeIntent=nil
   if menu.Q:Value()and self:CastQ(target,true,function()return permission(_Q)end)then return end
  else return end
 end
 if menu==Menu.Combo and self:ClassicR(target)then return end
 if self:RootFollowup(menu,target)then return end
 if self.profile.id=='normal'and GetDistance(target.pos,myHero.pos)>1000 then
  if menu.Q:Value()then self:CastQ(target,true,function()return permission(_Q)end)end;return
 end
 for _,choice in ipairs(self:Plan(target,menu))do local slot=choice.slot
  if slot==_Q then
   -- Normal: a blocked line may still bounce off a marked first unit (Ryze-1a).
   if self:CastQ(target,self.profile.id=='normal',function()return permission(_Q)end)then return end
  else
   local function allowed()return permission(slot)and(slot~=_W or not self:RootOnly()or self:Flux(target,.25))end
   if self:CastTarget(slot,target,allowed)then return end
  end
 end
 self:Bridge(menu,target)
end
-- Ryze-1(b): the target stands beyond E range: E a stationary unit within E range that the spread reaches (the
-- smaller bounce radius), with mana for E and Q; Q follows only once both own marks are seen.
function RyzeChampion:Bridge(menu,target)
 if self.profile.id~='normal'or self.bridgeIntent or not menu.E:Value()or not menu.Q:Value()or not IsReady(_E)
  or myHero:GetSpellData(_Q).level<1 or myHero.mana<self:Cost(_E)+self:Cost(_Q)then return false end
 local d=GetDistance(target.pos,myHero.pos);local reach=self.data.eBounceMin
 if d<=self.ESpell.Range or d>self.ESpell.Range+reach then return false end
 local list=self:Objects();if not list then return false end
 local function usable(u)
  if not valid(u)or u.networkID==target.networkID or not still(u)or GetDistance(u.pos,myHero.pos)>self.ESpell.Range
   or GetDistance(u.pos,target.pos)>reach then return false end
  if u.type==Obj_AI_Minion then local hp=_G.SDK.HealthPrediction:GetPrediction(u,self:Impact(_E,u))
   if not finite(hp)or hp<=self:Damage(_E,u,nil,true)*1.1 then return false end end
  return true
 end
 local best,bd
 for i=1,math.min(#list,24)do local u=list[i];local dd=u and u.pos and GetDistance(u.pos,target.pos)
  if dd and(not bd or dd<bd)and usable(u)then best,bd=u,dd end
 end
 if not best then return false end
 local function allowed()return self:CombatAllowed(menu,target)and menu.E:Value()and menu.Q:Value()and usable(best)
  and myHero.mana>=self:Cost(_E)+self:Cost(_Q)end
 if not self:CastTarget(_E,best,allowed)then return false end
 local q=Core.lastIntent
 if q then Core:AfterCast(HK_E,function()
  self.bridgeIntent={target=target,first=best,menu=menu,request=q,expires=Game.Timer()+self:Impact(_E,best)+.4}
 end)end
 return true
end
function RyzeChampion:Combo()self:Combat(Menu.Combo)end
function RyzeChampion:Harass()self:Combat(Menu.Harass)end
function RyzeChampion:FarmHarass()if self:ClearMode(false)and Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)then self:Harass()end end
function RyzeChampion:KillSteal()
 local list=Core:DecisionUnits('GetEnemyHeroes');local normal=self.profile.id=='normal'
 for i=1,math.min(#list,12)do local target=list[i]
  for slot=0,2 do
   -- Normal Q may bounce off a marked unit (Ryze-2): a marked target up to 1500 away qualifies.
   local legal=self:Legal(slot,target)or slot==_Q and normal and valid(target)and IsReady(_Q)and myHero.mana>=self:Cost(_Q)
    and GetDistance(target.pos,myHero.pos)<=1500
   if Menu.KillSteal[letters[slot+1]]:Value()and legal and self:Lethal(slot,target)then
    local function allowed(_,impact)return Menu.KillSteal[letters[slot+1]]:Value()and self:Lethal(slot,target,impact)end
    if slot==_Q then if self:CastQ(target,normal,allowed,'Secure')then return end
    elseif self:CastTarget(slot,target,allowed,'Secure')then return end
   end
  end
  if self:SequenceKill(target)then return end
 end
end
-- Ryze-2: E then Q (E resets Q and its mark amplifies Q) or W then Q (reset, no amplification) when neither spell
-- kills alone. Only the first cast is sent here; Q follows through the single-spell finisher once the reset and
-- the mark are actually seen. Q's line to the target must be free.
function RyzeChampion:SequenceLethal(slot,target)
 if not valid(target)then return false end
 local t1=self:Impact(slot,target);local tq=t1+.25+GetDistance(myHero.pos,target.pos)/self.profile.qSpeed
 local q=self:Damage(_Q,target,tq,true)
 if slot==_E then q=q*self:FluxMultiplier()end
 local total=self:Damage(slot,target,t1,true)+q
 return Core:Lethal(target,tq,total,{kind='magical'})==true and self:WallFree(_Q,target)and self:FirstBlocker(target)==nil
end
function RyzeChampion:SequenceKill(target)
 local ks=Menu.KillSteal
 if self.profile.id~='normal'or not ks.Q:Value()or myHero:GetSpellData(_Q).level<1 or not valid(target)
  or GetDistance(target.pos,myHero.pos)>self.QSpell.Range then return false end
 for _,slot in ipairs({_E,_W})do
  if ks[letters[slot+1]]:Value()and self:Legal(slot,target)and myHero.mana>=self:Cost(slot)+self:Cost(_Q)and self:SequenceLethal(slot,target)then
   local function allowed()return ks[letters[slot+1]]:Value()and ks.Q:Value()and myHero.mana>=self:Cost(slot)+self:Cost(_Q)and self:SequenceLethal(slot,target)end
   if self:CastTarget(slot,target,allowed,'Secure')then return true end
  end
 end
 return false
end
-- Classic Rune Prison always roots. Normal W roots only an enemy that carries our Flux and slows otherwise.
-- A diver we marked during its dash (Ryze-10) stays a root target for a short window after it has landed.
function RyzeChampion:Diving(target)
 if Core:ApproachingDash(target,myHero.pos,450)~=nil then return true end
 local dive=self.antiDive
 return dive~=nil and dive.target==target and Game.Timer()<=dive.expires and GetDistance(target.pos,myHero.pos)<=self.WSpell.Range
end
function RyzeChampion:AntiDashAllowed(target)
 return Menu.Misc.AntiDash:Value()and valid(target)and self:Diving(target)
  and(self.profile.id=='classic'or self:Flux(target,.25))
end
function RyzeChampion:AntiDash()
 if not Menu.Misc.AntiDash:Value()or not IsReady(_W)then return false end
 local rows=Core:Rows('hero',self.WSpell.Range)
 for i=1,math.min(#rows,5)do local u=rows[i]
  if self:AntiDashAllowed(u)and self:CastTarget(_W,u,function()return self:AntiDashAllowed(u)end)then return true end
 end
 -- Ryze-10: Normal marks an unmarked diver with E first (E and W affordable); W roots once the mark is seen.
 if self.profile.id~='normal'or not IsReady(_E)or myHero.mana<self:Cost(_E)+self:Cost(_W)then return false end
 for i=1,math.min(#rows,5)do local u=rows[i]
  if valid(u)and Core:ApproachingDash(u,myHero.pos,450)~=nil and not self:Flux(u,.25)then
   local function allowed()return Menu.Misc.AntiDash:Value()and IsReady(_W)and myHero.mana>=self:Cost(_E)+self:Cost(_W)
    and(Core:ApproachingDash(u,myHero.pos,450)~=nil or GetDistance(u.pos,myHero.pos)<=self.WSpell.Range)end
   if self:CastTarget(_E,u,allowed,'AntiDash')then
    Core:AfterCast(HK_E,function()self.antiDive={target=u,expires=Game.Timer()+self:Impact(_E,u)+.5}end);return true
   end
  end
 end
 return false
end
-- Flee: stop the nearest chaser. Normal marks with E first when both spells are affordable, waits for the mark
-- and then roots; without E the W still slows.
function RyzeChampion:Flee()
 if self:FleeR()then return true end
 if not Menu.Misc.FleeW:Value()then return false end
 if IsReady(_W)and self:FleeStop()then return true end
 if self.fleeMark and Game.Timer()<self.fleeMark then return false end
 return self:FleeRunes()
end
function RyzeChampion:PlayerAim()
 local api=_G.SDK.Actions;if api and type(api.GetPlayerPosition)=='function'then local ok,p=pcall(api.GetPlayerPosition,api);if ok and p and finite(p.x)then return p end end
 return mousePos
end
-- Ryze-8: two Runes (counted only from observed casts after an observed Q) turn the next Q into +28..44% speed
-- for 2 s. Q goes toward where the player is heading; any hit is incidental.
function RyzeChampion:FleeRunes()
 if self.profile.id~='normal'or not IsReady(_Q)or myHero.mana<self:Cost(_Q)then return false end
 local function runes()return self.runes.count==2 and self.runes.expires>Game.Timer()end
 if not runes()then return false end
 local aim=self:PlayerAim();if not aim or GetDistance(aim,myHero.pos)<100 then return false end
 local point=myHero.pos:Extended(aim,math.min(600,GetDistance(aim,myHero.pos)))
 return Core:Cast(HK_Q,point,{owner='Flee',range=self.QSpell.Range,validate=function()return Menu.Misc.FleeW:Value()and runes()end})
end
-- Ryze-9: Classic Desperate Power for its movement speed when a chaser closes in within 700 and health is at or
-- below the Combo R health limit, or two enemy champions chase.
function RyzeChampion:Chasers()
 local count=0
 for _,u in ipairs(Core:Rows('hero',700))do local path=u.pathing;local d=GetDistance(u.pos,myHero.pos)
  if valid(u)and(path and path.hasMovePath and path.endPos and GetDistance(path.endPos,myHero.pos)<d or Core:ApproachingDash(u,myHero.pos,450)~=nil)then count=count+1 end
 end
 if count==0 and Core:AllyThreat(myHero,1)then count=1 end
 return count
end
function RyzeChampion:FleeR()
 if self.profile.id~='classic'or not Menu.Misc.FleeR or not Menu.Misc.FleeR:Value()or not IsReady(_R)or self:Buff(myHero,self.profile.rBuff,true)then return false end
 local function allowed()
  if not Menu.Misc.FleeR:Value()or self:Buff(myHero,self.profile.rBuff,true)then return false end
  local n=self:Chasers();if n==0 then return false end
  return n>=2 or myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100<=Menu.Combo.RHP:Value()
 end
 if not allowed()then return false end
 return Core:Cast(HK_R,nil,{owner='Flee',validate=allowed})
end
function RyzeChampion:FleeStop()
 local rows=Core:Rows('hero',self.WSpell.Range);local target,best
 for i=1,math.min(#rows,5)do local u=rows[i];local d=GetDistance(u.pos,myHero.pos)
  if valid(u)and(not best or d<best)then target,best=u,d end
 end
 if not target then return false end
 local function consent()return Menu.Misc.FleeW:Value()end
 if self.profile.id=='normal'and not self:Flux(target,.25)then
  if self.fleeMark and Game.Timer()<self.fleeMark then return false end
  if IsReady(_E)and myHero.mana>=self:Cost(_E)+self:Cost(_W)then
   if self:CastTarget(_E,target,consent)then
    Core:AfterCast(HK_E,function()self.fleeMark=Game.Timer()+self:Impact(_E,target)+.3 end);return true
   end
   return false
  end
 end
 return self:CastTarget(_W,target,consent)
end
function RyzeChampion:Cluster(target,jungle,list,predict)
 if not valid(target)or not still(target)then return 0 end
 list=list or self:Objects();if not list then return 0 end
 local count=0;local at=self:Impact(_E,target)
 for i=1,#list do local u=list[i]
  if u.type==Obj_AI_Minion and(u.team==300)==jungle and valid(u)and still(u)and GetDistance(u.pos,target.pos)<=self.data.eBounceMin then
   local hp=predict==false and u.health or _G.SDK.HealthPrediction:GetPrediction(u,at);if finite(hp)and hp>0 then count=count+1 end
  end
 end
 -- Classic E has at most five hits; nearby candidates are not proven recipients.
 return self.profile.id=='classic'and math.min(5,count)or count
end
function RyzeChampion:FarmLethal(slot,target)
 if not self:Legal(slot,target)then return false end
 local impact=self:Impact(slot,target)
 if not self:Lethal(slot,target,impact)then return false end
 local hp=_G.SDK.HealthPrediction:GetPrediction(target,impact)
 return finite(hp)and hp>0 and self:Damage(slot,target,impact)>=hp+math.max(0,target.shieldAP or 0)
end
function RyzeChampion:CollateralFree(slot,target)
 local radius=0
 -- Ryze-7: E spread from the profile's larger bounce radius (a neighbour it may reach is collateral).
 if self.profile.id=='classic'then
  if slot==_E then radius=self.data.eBounceMax end
  if self:Buff(myHero,self.profile.rBuff,true)then radius=math.max(radius,375)end
 elseif slot==_Q and self:Buff(target,self.profile.flux,false)then radius=target.type==Obj_AI_Hero and self.data.qBounceLarge or self.data.qBounceSmall
 elseif slot==_E then radius=self.data.eBounceMax end
 if radius==0 then return true end
 if not still(target)then return false end
 local list=self:Objects();if not list then return false end
 local time=self:Impact(slot,target)+.4
 for i=1,#list do local u=list[i]
  if u.networkID~=target.networkID then
   local movement=still(u)and 0 or finite(u.ms)and math.max(0,u.ms)*time
   if not movement or GetDistance(u.pos,target.pos)<=radius+(u.boundingRadius or 0)+movement then return false end
  end
 end
 return true
end
function RyzeChampion:CanRescue(slot,target,menu)
 if not menu[letters[slot+1]]:Value()or not self:ManaAllowed(menu)or not self:FarmLethal(slot,target)
  or target.type~=Obj_AI_Minion or target.team==300 or _G.SDK.Attack:IsActive()or not self:CollateralFree(slot,target)then return false end
 if _G.SDK.Data:IsInAutoAttackRange(myHero,target)and _G.SDK.Orbwalker:CanAttack()
  and _G.SDK.Damage:GetAutoAttackDamage(myHero,target,true)>=target.health+math.max(0,target.shieldAD or 0)then return false end
 return true
end
function RyzeChampion:Rescue(menu)
 local list=self:Objects();if not list then return end
 -- Each spell gets its own candidates; a blocked Q must not suppress W/E rescue.
 for slot=0,2 do if menu[letters[slot+1]]:Value()and IsReady(slot)then
  for i=1,math.min(#list,32)do local target=list[i]
   if self:CanRescue(slot,target,menu)then
    local function allowed()return self:CanRescue(slot,target,menu)end
    if slot==_Q then if self:CastQ(target,false,allowed,nil,OrbamaPrediction.HITCHANCE_NORMAL)then return true end
    elseif self:CastTarget(slot,target,allowed)then return true end
   end
  end
 end end
 if menu==Menu.LastHit and IsReady(_E)then
  for i=1,math.min(#list,32)do local target=list[i]
   if self:ChainRescue(target,menu)then
    if self:CastTarget(_E,target,function()return self:ChainRescue(target,menu)end)then return true end
   end
  end
 end
end
-- Ryze-3: a minion no single spell (nor a ready attack) can take, but E and then the mark-amplified Q (E resets
-- Q) kill at the forecast health, with mana for both, no collateral for either (the E spread covers the Q
-- spread radius) and a clear Q line. Only E is sent here; Q follows through the ordinary Q rescue once the reset
-- and the mark are seen.
function RyzeChampion:ChainRescue(target,menu)
 if self.profile.id~='normal'or not menu.E:Value()or not menu.Q:Value()or not self:ManaAllowed(menu)or not valid(target)
  or target.type~=Obj_AI_Minion or target.team==300 or not self:Legal(_E,target)or myHero:GetSpellData(_Q).level<1
  or myHero.mana<self:Cost(_E)+self:Cost(_Q)or GetDistance(target.pos,myHero.pos)>self.QSpell.Range or _G.SDK.Attack:IsActive()then return false end
 if _G.SDK.Data:IsInAutoAttackRange(myHero,target)and _G.SDK.Orbwalker:CanAttack()
  and _G.SDK.Damage:GetAutoAttackDamage(myHero,target,true)>=target.health+math.max(0,target.shieldAD or 0)then return false end
 local shield=math.max(0,target.shieldAP or 0)
 local tE=self:Impact(_E,target);local tQ=tE+.25+GetDistance(myHero.pos,target.pos)/self.profile.qSpeed
 local hpE=_G.SDK.HealthPrediction:GetPrediction(target,tE);if not finite(hpE)or hpE<=0 then return false end
 local e=self:Damage(_E,target,tE,true);if e>=hpE+shield then return false end
 local hpQ=_G.SDK.HealthPrediction:GetPrediction(target,tQ);if not finite(hpQ)or hpQ<=0 then return false end
 local q=self:Damage(_Q,target,tQ,true)*self:FluxMultiplier()
 if e+q<hpQ+shield then return false end
 return self:CollateralFree(_E,target)and self:FirstBlocker(target)==nil
end
function RyzeChampion:LastHit()return self:Rescue(Menu.LastHit)end
-- Normal wave clear by Flux spread. Q on a minion that carries our Flux also hits every marked enemy around it,
-- so after E has spread the mark one Q damages the whole wave. The marks themselves are the evidence that the
-- spread happened; .9 s covers the cast and the longest flight.
function RyzeChampion:Marked(list)
 local out={}
 for i=1,math.min(#list,48)do local u=list[i]
  if u.type==Obj_AI_Minion and u.team~=300 and valid(u)and self:Flux(u,.9)then out[#out+1]=u end
 end
 return out
end
function RyzeChampion:SpreadCount(target,marked)
 local count,own=0,false
 for i=1,#marked do local u=marked[i]
  if u.networkID==target.networkID then own=true;count=count+1
  elseif GetDistance(u.pos,target.pos)<=self.profile.qBounce then count=count+1 end
 end
 return own and GetDistance(target.pos,myHero.pos)<=self.QSpell.Range and count or 0
end
function RyzeChampion:SpreadQ(menu,permission,list)
 local marked=self:Marked(list);local need=menu.ECount:Value()
 if #marked<need then return false end
 local rows={}
 for i=1,#marked do local count=self:SpreadCount(marked[i],marked);if count>=need then rows[#rows+1]={unit=marked[i],count=count}end end
 table.sort(rows,function(a,b)if a.count~=b.count then return a.count>b.count end;return a.unit.networkID<b.unit.networkID end)
 for i=1,math.min(#rows,4)do local target=rows[i].unit
  local prediction=Core:Prediction(self.SpreadSpell);prediction:GetPrediction(target,myHero)
  if prediction:CanHit(OrbamaPrediction.HITCHANCE_NORMAL)and prediction.CastPosition and self:SpreadLine(target,prediction.CastPosition,marked,need)then
   local function allowed(q,resolved)
    local live=self:Objects();if not live or not permission()or not menu.Q:Value()or not self:Legal(_Q,target)then return false end
    local now,count=self:Marked(live),menu.ECount:Value()
    return self:SpreadCount(target,now)>=count and self:SpreadLine(target,resolved and resolved.position or q.target,now,count)
   end
   if Core:Cast(HK_Q,prediction.CastPosition,{intentTarget=target,range=self.QSpell.Range,prevalidateWorldCast=true,validate=allowed})then
    self.spreadWait=nil;return true
   end
  end
 end
 return false
end
-- The first unit the line meets carries the spread, so a blocker is acceptable when it is itself a marked minion
-- with enough marked neighbours. Anything else on the line (an unmarked minion, a champion, a wind wall) refuses.
function RyzeChampion:SpreadLine(target,point,marked,need)
 local s=self.QSpell
 local wall,hits=OrbamaPrediction:GetCollision(myHero.pos,point,s.Speed,s.Delay,s.Radius,s.CollisionTypes,target.networkID)
 if wall~=false then return false end
 for i=1,#(hits or {})do if self:SpreadCount(hits[i],marked)<need then return false end end
 return true
end
function RyzeChampion:Farm(jungle)
 local menu=jungle and Menu.Clear.JungleClear or Menu.Clear.LaneClear
 local function permission()return self:ClearMode(jungle)and Menu.Clear.SpellFarm:Value()and self:ManaAllowed(menu)and(jungle or not IsUnderTurret(myHero))end
 if not permission()then return end
 local list=self:Objects();if not list then return end
 local best,bestCount=nil,0
 for i=1,math.min(#list,12)do local u=list[i]
  if u.type==Obj_AI_Minion and(u.team==300)==jungle and valid(u)and GetDistance(u.pos,myHero.pos)<=self.reach then
   if jungle then if not best or u.maxHealth>best.maxHealth then best=u end
   elseif menu.E:Value()and IsReady(_E)then
    local count=self:Cluster(u,false,list,false);if count>bestCount then best,bestCount=u,count end
   end
  end
 end
 if jungle then
  if not best then return end
  for _,slot in ipairs({_E,_Q,_W})do
   if menu[letters[slot+1]]:Value()and self:Legal(slot,best)then
    local function allowed()return permission()and menu[letters[slot+1]]:Value()end
    if slot==_Q then if self:CastQ(best,false,allowed,nil,OrbamaPrediction.HITCHANCE_NORMAL)then return end
    elseif self:CastTarget(slot,best,allowed)then return end
   end
  end
 else
  local function spreadAllowed()
   return best and permission()and menu.E:Value()and self:Cluster(best,false)>=menu.ECount:Value()
    and(self.profile.id=='classic'or menu.Q:Value()and myHero:GetSpellData(_Q).level>0 and myHero.mana>=self:Cost(_E)+self:Cost(_Q))
  end
  local normal=self.profile.id=='normal'
  if normal and menu.Q:Value()and IsReady(_Q)and self:SpreadQ(menu,permission,list)then return end
  if spreadAllowed()and self:CastTarget(_E,best,spreadAllowed)then
   -- The E cast resets Q. Q then waits for the marks instead of being spent on a single kill first.
   if normal then local target=best;Core:AfterCast(HK_E,function()self.spreadWait=Game.Timer()+self:Impact(_E,target)+.35 end)end
   return
  end
  local holdQ=normal and self.spreadWait~=nil and Game.Timer()<self.spreadWait
  for slot=0,2 do if not(slot==_Q and holdQ)and menu[letters[slot+1]]:Value()and IsReady(slot)then
   for i=1,math.min(#list,32)do local target=list[i]
    if target.type==Obj_AI_Minion and target.team~=300 and self:FarmLethal(slot,target)then
     local function allowed()return permission()and menu[letters[slot+1]]:Value()and self:FarmLethal(slot,target)end
     if slot==_Q then if self:CastQ(target,false,allowed,nil,OrbamaPrediction.HITCHANCE_NORMAL)then return end
     elseif self:CastTarget(slot,target,allowed)then return end
    end
   end
  end end
 end
end
function RyzeChampion:LaneClear()self:Farm(false)end
function RyzeChampion:JungleClear()self:Farm(true)end
function RyzeChampion:WarpValid(point)
 if self.profile.id~='normal'or not Menu.Warp.Key:Value()or not IsReady(_R)or self:Buff(myHero,self.profile.rBuff,true)then return false,'not_authorized' end
 if not point or not finite(point.x)or not finite(point.z)then return false,'invalid_destination' end
 local distance=GetDistance(point,myHero.pos);if distance<self.data.rMin or distance>self.data.rMax then return false,'destination_range' end
 if not Core.TerrainEndpoint then return false,'terrain_capability_unavailable' end
 local terrain=Core:TerrainEndpoint(point,myHero.boundingRadius or 35)
 if not terrain or terrain.known~=true or terrain.clear~=true or terrain.profile~=self.profile.id or terrain.mapID~=Game.mapID then return false,'terrain_unknown_or_blocked' end
 if Menu.Warp.Safe:Value()then
  local heroes=Core:DecisionUnits('GetEnemyHeroes');if #heroes>24 then return false,'incomplete_enemy_list' end
  for i=1,#heroes do local u=heroes[i];if IsValid(u)and GetDistance(u.pos,point)<=800 then return false,'visible_enemy_destination' end end
  if not Game.TurretCount or not Game.Turret then return false,'turret_discovery_unavailable' end
  local count=Game.TurretCount();if not finite(count)or count<0 or count%1~=0 or count>32 then return false,'turret_discovery_unknown' end
  for i=1,count do local u=Game.Turret(i);if u and u.team~=myHero.team and not u.dead and u.health>0 and GetDistance(u.pos,point)<=900 then return false,'turret_destination' end end
 end
 return true
end
function RyzeChampion:SemiWarp()
 if self.profile.id~='normal'then return end
 if not Menu.Warp.Key:Value()then self.warpPreview=nil;return end
 local pending=Core.pending[HK_R]
 if pending then return end
 local p=mousePos;local point=p and Vector(p.x,p.y,p.z);local ok,reason=self:WarpValid(point)
 self.warpPreview={point=point,valid=ok,reason=reason,at=Game.Timer()}
 if not ok then return end
 return Core:Cast(HK_R,point,{range=3000,independent=false,resolve=function()return {position=point}end,
  validate=function()return self:WarpValid(point)end})
end
-- Measurement traces (dev recorder only). ryze_e_flight (Ryze-6a): distance and seconds from the observed E cast to
-- the own mark. ryze_q_bounce (Ryze-6b): a bounced Q's first-to-target distance, whether the first unit was large,
-- and whether the target lost health within 0.6 s.
function RyzeChampion:TickProbes()
 local now=Game.Timer();local e=self.eProbe
 if e then
  if now-e.at>1.5 then self.eProbe=nil
  elseif valid(e.target)and self:Flux(e.target)then Core:Trace('ryze_e_flight',{distance=math.floor(e.distance),seconds=now-e.at});self.eProbe=nil end
 end
 local q=self.qProbe
 if q and q.at and now-q.at>=.6 then
  Core:Trace('ryze_q_bounce',{distance=math.floor(q.distance),large=q.large,damaged=finite(q.target.health)and q.target.health<q.health});self.qProbe=nil
 end
end
function RyzeChampion:Tick()
 self:ObserveState();self:TickProbes()
 if ShouldWait()or IsCasting()then return end
 self:SemiWarp();self:KillSteal();self:AntiDash()
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='Flee'then self:Flee()
 elseif mode=='LaneClear'then
  if self:ClearMode(false)then self:FarmHarass();self:LaneClear()end
  if self:ClearMode(true)then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()end
end
function RyzeChampion:Draw()
 if myHero.dead then return end
 for slot=0,2 do if Menu.Draw[letters[slot+1]]:Value()and IsReady(slot)then Draw.Circle(myHero.pos,self:Range(slot),1,Draw.Color(255,66,244,113))end end
 -- Ryze-4: Realm Warp reach (Normal), outer maximum and inner minimum.
 if Menu.Draw.R and Menu.Draw.R:Value()and IsReady(_R)then
  Draw.Circle(myHero.pos,self.data.rMax,1,Draw.Color(255,120,160,255));Draw.Circle(myHero.pos,self.data.rMin,1,Draw.Color(255,120,160,255))
 end
 local preview=self.warpPreview
 -- Kept up to a second while the warp key is held (a late preparation must not blink it).
 if self.profile.id=='normal'and Menu.Warp.Draw:Value()and preview and preview.point and Game.Timer()-preview.at<1 then
  Draw.Circle(preview.point,65,2,preview.valid and Draw.Color(255,66,244,113)or Draw.Color(255,244,80,66))
 end
end
function RyzeChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},w={node=Menu.Combo.W,label='Combo W'},e={node=Menu.Combo.E,label='Combo E'},
  attack={node=Menu.Combo.DisableAA,label='No attacks during a spell cast'},farm={node=Menu.Clear.SpellFarm,label='Spell farming'},
  harass={node=Menu.Clear.SpellHarass,label='Lane Clear harass'},last={node=Menu.LastHit.Q,label='Last Hit Q rescue'},count={node=Menu.Clear.LaneClear.ECount,label='E cluster minimum'}}
 nodes.antidash={node=Menu.Misc.AntiDash,label='Anti-dash W'};nodes.flee={node=Menu.Misc.FleeW,label='Flee W'}
 if self.profile.id=='normal'then nodes.warpkey={node=Menu.Warp.Key,label='Hold Warp destination'}
 else nodes.r={node=Menu.Combo.R,label='Desperate Power'};nodes.rhp={node=Menu.Combo.RHP,label='R health threshold'}end
 local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Ryze: quick start','Ryze: spells','Ryze: farming and ultimate'},function(page)
  local normal=self.profile.id=='normal'
  if page==1 then return {title=normal and 'Ryze'or 'Classic Ryze',subtitle='One controller, separate Normal and Classic kits.',cards={
   {'COMBAT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..' for [[q]], [[w]] and [[e]]. A target you selected comes first.'},
   {'HARASS','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..' with its own spell switches and mana limit. [[harass]] also pokes champions while you clear a lane.'},
   {'ATTACKS','[[attack]] only stops an attack from cutting off a spell that is being cast. A ready spell alone never stops your attacks.'}},note='Letting go of the mode key stops anything still waiting. Each cast checks range, cooldown and mana again just before it goes out.'}end
  if page==2 then return {title='Spells',subtitle=normal and 'Flux marks, roots and Runes.'or 'Targeted spells and shorter cooldowns.',cards={
   {'Q',normal and 'Q is a line. Champions, minions and wind walls block it, unless the first unit hit carries your Flux mark: Q then jumps on to a marked target, also beyond Q range. Bonus damage on a marked target counts only when your mark lasts until Q lands.'or 'Classic Q is targeted and scales with your total mana. A wind wall still stops it.'},
   {'ORDER',normal and 'Combo roots first: E, then W once your mark is on the target, then Q. A target just out of E range is reached by marking a unit next to it and bouncing Q off it. Harass pokes with E into Q. Without a mark W only slows, so it waits for E. [[antidash]] marks and roots an enemy that dashes at you, and [[flee]] roots the nearest chaser and then uses two Runes on Q to run faster.'or 'Each cast shortens your other cooldowns by one second, and the order accounts for it. E lowers the target\'s magic resistance, which raises the damage of the Q and W that follow once your E has landed. [[antidash]] roots an enemy that dashes at you and [[flee]] roots the nearest chaser; R can add movement speed while fleeing.'},
   {'FINISHERS',normal and 'Without a mode key, Q, W or E finish an enemy one of them kills; when neither kills alone, E then Q (E makes Q hit harder) or W then Q are used, and Q only goes once E or W has landed.'or 'Without a mode key, Q, W or E finish an enemy one of them kills, counting the E resistance reduction after your E has landed.'}},note='Planned damage only picks the next cast. It never replaces the checks on your mark, range, cooldown and collisions.'}end
  return {title='Farming and ultimate',subtitle='Clearing and last hitting have their own switches.',cards={
   {'FARM','Turn on [[farm]] and hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..'. Lane E needs [[count]] standing minions it can spread to. '..(normal and 'E keeps mana for the Q that follows: once [[count]] minions carry your mark, one Q on a marked minion hits the whole marked wave. 'or '')..'Jungle clearing has its own mode and switches.'},
   {'LAST HIT','Hold '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT)..' with ability farming on. [[last]] and the W/E rescues take minions an attack would miss, checking incoming damage, your attack and neighbours a spread could hit.'..(normal and ' A minion neither spell takes alone is taken by E and then the stronger Q.'or '')},
   {'ULTIMATE',normal and 'Hold [[warpkey]], T by default, at a destination 1000 to 3000 away on open ground. By default destinations near visible enemies or enemy turrets are refused. This cannot see danger in the fog.'or '[[r]] uses your enemy count and [[rhp]] health limit, and only when a spell follows. It does not teleport.'}},note='A cast going out does not prove that it hit, bounced, warped or healed.'}
 end,cfg,links,activate)
end
Core:RegisterPolicy({damageTypes={Q='magical',W='magical',E='magical'},
 methods={Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
  LaneClear=function(self)return Core:ModeContext('LaneClear',function()return self:ClearMode(false)and Menu.Clear.SpellFarm:Value()end)end,
  JungleClear=function(self)return Core:ModeContext('LaneClear',function()return self:ClearMode(true)and Menu.Clear.SpellFarm:Value()end)end,
  FarmHarass=function(self)return Core:ModeContext('LaneClear',function()return self:ClearMode(false)and Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)end)end,
  LastHit=function()return Core:ModeContext('LastHit')end,KillSteal=function()return {priority='interactive'}end,Secure=function()return {priority='interactive'}end,
  Flee=function()return Core:ModeContext('Flee')end,AntiDash=function()return {priority='interactive'}end,
  SemiWarp=function()return Core:HeldContext(function()return Menu.Warp and Menu.Warp.Key:Value()end)end},
 exceptions={non_interrupting_summoner=true},
 channel=function()return not Core:SelfChanneling()end,
})
RyzeChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Ryze"]="Ryze"}
local normalSupported={["Ryze"]=true}

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
