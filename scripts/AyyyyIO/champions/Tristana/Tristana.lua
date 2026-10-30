return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Tristana"]=function()return _G.OrbamaFamily:Require("ef44f39b1ee537e4acb69241c6c78d4027c019c43cb3e66d80de97d0fb608e1f")()end
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
if champion=="Tristana" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Tristana',profiles={normal=true,classic=true},
 Create=function(context)
-- Independently rebuilt decisions; actual Normal/Classic mechanics stay profiled.
local profiles=ChampionProfiles('Tristana')
local finite,identity=Core.finite,Core.id
local TristanaChampion=class("TristanaChampion")
function TristanaChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.issued={};self.targets={};self:LoadMenu();self:UpdateRanges();self:DiscoverTargets()
 local profile=self.profile
 -- The landing kills, so the jump comes back: one such jump in flight at a time.
 self.finisher=Core:ResetChain(_W)
 -- Aim only: a point the target is likely to be at when the jump lands. The damage radius is larger.
 self.WSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=profile.wDelay,Radius=150,Range=profile.wRange,Speed=profile.wSpeed,Collision=false}
 -- Where an enemy out of R range stands when a jump toward it lands (the longest jump: cast plus 900/1100).
 self.RJumpSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=profile.wDelay+profile.wRange/profile.wSpeed,Radius=150,Range=math.huge,Speed=math.huge,Collision=false}
 -- Flash behind the selected target, then R knocks it toward the team (shared Flash follow-up).
 self.flashR=Core:FlashFollow('TristanaFlashR')
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Tristana',function()self.issued={};self.charge=nil;self.dot=nil;self.jump=nil;self.jumpPreview=nil;self.preview=nil;self.attackWitness=nil;self.qUntil=nil;self.finisher:Clear();self.flashR:Cancel('cleanup')end)
 -- Evade judges the danger and asks for a full-length jump; the landing limits stay here.
 self.mobilityOffered,self.mobilityReason=Core:RegisterMobility({kind='dash',slot=_W,key=HK_W,name=profile.w,range=profile.wRange,speeds={profile.wSpeed*.75,profile.wSpeed},toPoint=true,castDelays={profile.wDelay},
  profile=profile.id,label='Rocket Jump',source=profile.wSource,allowed=function(point)return self:EvadeJumpAllowed(point)end})
 local yes,why=Core:RegisterPreparation('Tristana.preview',{intervalMs=150,maxDelayMs=450,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.W:Value()end,function()self.preview=nil;self.jumpPreview=nil end);self.previewFallback=not yes and why=='unsupported'
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
 self.featureStatus={evadeW='W offered to Evade from the profile figures (listed speed; the jump is modelled as a straight full-length dash)',ERLethal='R plus the charge at its stacks after R (Normal) or the burn ticks still to come (Classic); live impact order unverified',classicLastHit='Classic DoT first-tick timing unverified; no future full-DoT CS credit',
  qTimer='Q time left: the own buff named like the Q spell when the host lists it (name unverified live), else the observed own Q cast plus the 7 s asset duration'}
end
function TristanaChampion:LoadMenu()
 local charge=self.profile.eKind=='charge'
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Tristana'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q',value=true})
  Menu[mode]:MenuElement({id='E',name='Use E',value=true})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='W',name='Jump on an enemy when the landing kills it',value=true})
 Menu.Combo:MenuElement({id='WR',name='Jump closer to an enemy when R would then kill it',value=true})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 Menu.Clear:MenuElement({id='SpellHarass',name='Also harass champions while lane clearing',value=false})
 for _,mode in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[mode]:MenuElement({id='Q',name='Use Q',value=true})
  if mode=='JungleClear'or charge then Menu.Clear[mode]:MenuElement({id='E',name=mode=='LaneClear'and 'Use E on turrets and full waves'or 'Use E',value=true})end
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='QCount',name=charge and 'Lane minions needed for Q and for E on a wave'or 'Lane minions needed for Q',value=3,min=1,max=8,step=1,menu=false})
 if charge then
  Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
  Menu.LastHit:MenuElement({id='E',name='Use E on a lone minion an attack cannot take',value=true})
  Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='SemiR',name='Cast R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='FlashR',name='R bind: Flash behind to knock toward allies',value=false})
 if charge then Menu.Misc:MenuElement({id='ERAssist',name='Cast R to detonate a nearly full E charge',key=string.byte('U')})end
 Menu.Misc:MenuElement({id='WEngage',name='Jump on the selected target and fight',key=string.byte('N')})
 Menu.Misc:MenuElement({id='EngageHP',name='Never jump in below health %',value=30,min=5,max=100,step=5})
 Menu.Misc:MenuElement({id='WEnemies',name='Never jump into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='Rgap',name='Knock back enemies who dash onto you with R',value=true})
 Menu.Misc:MenuElement({id='RPeel',name='Knock back an enemy on top of you at low health',value=true})
 Menu.Misc:MenuElement({id='PeelHP',name='Low health for that knock-back, %',value=35,min=5,max=100,step=5,menu=false})
 Menu.Misc:MenuElement({id='Rint',name='Interrupt channelled abilities with R',value=true})
 Menu.Misc:MenuElement({id='FleeW',name='Use W toward the cursor when fleeing',value=true})
 Menu.Misc:MenuElement({type=MENU,id='Targets',name='Enemy champions abilities may target'})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='R',name='R range while R is ready',value=false})
 Menu.Draw:MenuElement({id='W',name='Jump landing point',value=true})
end
function TristanaChampion:UpdateRanges()
 -- Runtime reach includes the actual profile's passive progression.
 -- Classic Buster Shot has its own fixed range; it does not grow with Draw a Bead.
 self.ERange=myHero.range+myHero.boundingRadius;self.RRange=self.profile.rRange or self.ERange
end
function TristanaChampion:Ready(slot,validation)
 local letter=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot]
 local d=myHero:GetSpellData(slot);local row=self.issued[slot]
 return letter and d and finite(d.level)and d.level%1==0 and d.level>=1 and d.level<=(slot==_R and 3 or 5)and finite(d.mana)and d.mana>=0 and finite(myHero.mana)and d.mana<=myHero.mana
  and finite(d.currentCd)and d.currentCd==0 and Game.CanUseSpell(slot)==0 and d.name==self.profile[letter]and(not row or validation and not row.uncertain)
end
function TristanaChampion:Current(u)
 if not IsValid(u)or not u.pos or not finite(u.pos.x)or not finite(u.pos.z)then return false end
 local method=u.type==Obj_AI_Hero and'GetEnemyHeroes'or u.type==Obj_AI_Turret and'GetEnemyTurrets'or u.team==300 and'GetMonsters'or'GetEnemyMinions'
 local rows=Core:DecisionUnits(method);for i=1,math.min(#rows,512)do local v=rows[i];if identity(v)==identity(u)then return v==u and v.handle==u.handle end end;return false
end
function TristanaChampion:Reach(target,range)
 return self:Current(target)and target.team~=myHero.team and finite(range)and GetDistance(target.pos,myHero.pos)<=range
end
function TristanaChampion:DiscoverTargets()
 local rows=Core:DecisionUnits('GetEnemyHeroes');for i=1,math.min(#rows,10)do local u=rows[i];if self:Current(u)and not self.targets[identity(u)]then local key=StableUnitMenuKey(self,'Enemy',u);Menu.Misc.Targets:MenuElement({id=key,name=u.charName or key,value=true});self.targets[identity(u)]=Menu.Misc.Targets[key]end end
end
function TristanaChampion:Allowed(u)return self:Current(u)and(u.type~=Obj_AI_Hero or not self.targets[identity(u)]or self.targets[identity(u)]:Value())end
function TristanaChampion:Submit(slot,key,aim,options)
 if self.issued[slot]or not Core:Cast(key,aim,options)then return false end;self.issued[slot]={q=Core.lastIntent};return true
end
function TristanaChampion:MaintainIssued()
 for slot,row in pairs(self.issued)do local q=row.q;local r=Core.adapter:Poll(q.id);local d=myHero:GetSpellData(slot)
  if not q.sentAt and(not r or r.state=='cancelled_before_send')then self.issued[slot]=nil
  else if r and(r.state=='send_uncertain'or r.interrupted or r.competitor)then row.uncertain=true end
   if finite(d.currentCd)and d.currentCd>0 then row.cooldownSeen=true end
   if row.cooldownSeen and d.currentCd==0 and Game.CanUseSpell(slot)==0 then self.issued[slot]=nil end
   -- A certain, finished send with no observation and no consumed cooldown cast nothing;
   -- fresh readiness permits a new decision instead of locking the slot for the game.
   if self.issued[slot]and q.sentAt and not q.observedAt and not row.uncertain and not row.cooldownSeen and q.outcome and Core.pending[q.key]~=q
    and finite(d.currentCd)and d.currentCd==0 and Game.CanUseSpell(slot)==0 then self.issued[slot]=nil end
  end
 end
end
function TristanaChampion:OwnedBuff(target)
 if not IsValid(target)or not target.GetBuff or not finite(target.buffCount)or target.buffCount%1~=0 or target.buffCount<0 or target.buffCount>128 then return nil end
 local function ours(id)return id and id~=0 and(id==myHero.networkID or id==myHero.handle)end
 for i=0,math.min(target.buffCount,64)do local b=target:GetBuff(i);if b then
  local expiry=Core.buffExpiry(b)
  local known,owned=false,true
  for _,key in ipairs({'source','sourceID','sourcenID','owner','ownerID'})do local n=b[key]
   if type(n)=='table'or type(n)=='userdata'then
    for _,v in ipairs({n.networkID or 0,n.handle or 0})do if v~=0 then known=true;owned=owned and ours(v)end end
   elseif n~=nil and n~=0 then known=true;owned=owned and ours(n)end
  end
  owned=known and owned and(not b.sourceName or b.sourceName==''or b.sourceName==myHero.charName)
  if type(b.name)=='string'and b.name:lower()==self.profile.eBuff:lower()and owned and finite(expiry)and expiry>Game.Timer()then return b,expiry end
 end end
end
function TristanaChampion:Charge(target,impact)
 local p=self.charge
 if self.profile.eKind~='charge'or not p or not p.observed or p.target~=target or identity(target)~=p.id or p.handle and p.handle~=target.handle or not self:Current(target)or Game.Timer()>p.expires then return nil end
 local buff,expiry=self:OwnedBuff(target)
 if not buff or expiry<=Game.Timer()+(impact or 0)or not finite(buff.startTime)or buff.startTime<p.request-.05 then return nil end
 local count=buff.count
 if not finite(count)or count%1~=0 or count<0 or count>self.profile.eMax then return nil end
 if buff.stacks~=nil and buff.stacks~=count then return nil end
 return count,expiry
end
function TristanaChampion:GetTarget()
 local selected=_G.SDK.TargetSelector.Selected
 if self:Allowed(selected)and self:Reach(selected,self.ERange)and selected.type==Obj_AI_Hero then return selected end
 local mode=GetMode()
 if(mode=='Combo'or mode=='Harass')and self.charge and self:Allowed(self.charge.target)and self:Reach(self.charge.target,self.ERange)and self:Charge(self.charge.target)then return self.charge.target end
 local target=_G.SDK.Orbwalker:GetTarget()
 if self:Allowed(target)and self:Reach(target,self.ERange)and target.type==Obj_AI_Hero then return target end
 local raw=Core:DecisionUnits('GetEnemyHeroes');local rows={};for i=1,math.min(#raw,10)do local u=raw[i];if self:Allowed(u)and self:Reach(u,self.ERange)then rows[#rows+1]=u end end
 local chosen=_G.SDK.TargetSelector:GetTarget(rows,_G.SDK.DAMAGE_TYPE_PHYSICAL)
 if self:Allowed(chosen)and self:Reach(chosen,self.ERange)then return chosen end;return rows[1]
end
function TristanaChampion:AttackPermission(target)
 local mode=GetMode()
 local p=self.jump;if p and not p.continuationEnded and p.target==target and p.landed and p.held()and self:EngageAllowed(p.target)then return Menu.Combo,p.context end
 if target.type==Obj_AI_Hero then
  if mode=='Combo'or mode=='Harass'then return Menu[mode],Core:ModeContext(mode)end
  if Core:FarmModeEnabled('lane')and Menu.Clear.SpellHarass:Value()then return Menu.Harass,Core:FarmContext('lane',function()return Menu.Clear.SpellHarass:Value()end)end
 elseif target.type==Obj_AI_Turret then
  if self.profile.eKind=='charge'and Core:FarmModeEnabled('lane')and Menu.Clear.SpellFarm:Value()then return Menu.Clear.LaneClear,Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end
 elseif target.type==Obj_AI_Minion and Menu.Clear.SpellFarm:Value()then
  local kind=target.team==300 and 'jungle'or 'lane'
  if Core:FarmModeEnabled(kind)then return Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'],Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)end
 end
end
function TristanaChampion:AttackUseful(witness)
 local target=witness and witness.object
 if not witness or not finite(witness.at)then return false end
 local p=self.jump;if p and p.target==target and p.held()and not p.continuationEnded and(not p.landed or not p.started or witness.at<p.started)then return false end
 return target and identity(target)==witness.target and finite(witness.at)and Game.Timer()>=witness.at and Game.Timer()-witness.at<=.35 and self:Allowed(target)and self:Reach(target,self.ERange)and self:AttackPermission(target)~=nil
end
function TristanaChampion:CastE(target,context,validate)
 if not self:Ready(_E)or not self:Allowed(target)or not self:Reach(target,self.ERange)or(self.profile.eKind=='dot'and target.type==Obj_AI_Turret)then return false end
 local handle=target.handle;local started
 local ok=self:Submit(_E,HK_E,target,{range=self.ERange,intentTarget=target,context=context,deferAttackWindup=true,
  validate=function()return self:Ready(_E,true)and self:Allowed(target)and target.handle==handle and self:Reach(target,myHero.range+myHero.boundingRadius)and(not validate or validate())end,
  observe=function(q)local a=Core:NativeCast(q,self.profile.e);if not a or not self:Current(target)or target.handle~=handle or(a.target~=identity(target)and a.target~=handle)then return false end;started=a.startTime;return true end})
 if ok then Core:AfterCast(HK_E,function()local p={target=target,id=identity(target),handle=handle,request=started,expires=started+self.profile.eDuration+.8,observed=true}
  if self.profile.eKind=='charge'then self.charge=p else self.dot=p end end)end
 return ok
end
-- The small monsters of a camp die to the splash; the charge belongs on the big one. Camp names differ per
-- profile, so besides the modern "Mini" names a monster standing next to a clearly bigger one counts as small.
function TristanaChampion:SmallMonster(u)
 if u.type~=Obj_AI_Minion or u.team~=300 then return false end
 local name=type(u.charName)=='string'and u.charName:lower()
 if name and name:find('mini',1,true)and not name:find('minion',1,true)then return true end
 local rows=Core:DecisionUnits('GetMonsters')
 for i=1,math.min(#rows,24)do local v=rows[i]
  if v~=u and IsValid(v)and finite(v.maxHealth)and finite(u.maxHealth)and v.maxHealth>u.maxHealth*1.5 and GetDistance(v.pos,u.pos)<=600 then return true end
 end
 return false
end
-- Normal lane clear: the charge on a minion standing in a full wave (the blast clears it), never while an enemy
-- turret is in reach (the charge belongs on the turret) and not on a minion that dies before it is worth it.
function TristanaChampion:WaveE(u)
 local p=self.profile;if p.eKind~='charge'or not self:Reach(u,self.ERange)or u.health<=myHero.totalDamage*2 then return false end
 local turrets=Core:DecisionUnits('GetEnemyTurrets');for i=1,math.min(#turrets,16)do if self:Reach(turrets[i],self.ERange+150)then return false end end
 local rows=Core:Rows('lane',self.ERange+p.eRadius);local n=0
 for i=1,math.min(#rows,40)do if GetDistance(rows[i].pos,u.pos)<=p.eRadius then n=n+1 end end
 return n>=Menu.Clear.LaneClear.QCount:Value()
end
-- E goes out before the first attack, so every attack of the trade stacks it (one more stack at detonation).
function TristanaChampion:OpenE(mode)
 local settings=Menu[mode];if not settings.E:Value()or not self:Ready(_E)or not Core.manaAbove(settings.Mana:Value())then return false end
 local target=self:GetTarget();if not target or target.type~=Obj_AI_Hero then return false end
 return self:CastE(target,Core:ModeContext(mode),function()return settings.E:Value()and Core.manaAbove(settings.Mana:Value())end)
end
function TristanaChampion:OpenJungleE()
 local settings=Menu.Clear.JungleClear
 if not Menu.Clear.SpellFarm:Value()or not settings.E:Value()or not self:Ready(_E)or not Core.manaAbove(settings.Mana:Value())then return false end
 local rows=Core:Rows('jungle',self.ERange);local best
 for i=1,#rows do local u=rows[i]
  -- Not on a monster a few attacks from death: the charge would die with it.
  if not self:SmallMonster(u)and u.health>myHero.totalDamage*3 and(not best or u.maxHealth>best.maxHealth)then best=u end
 end
 return best~=nil and self:CastE(best,Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end),function()return settings.E:Value()and Core.manaAbove(settings.Mana:Value())end)
end
-- Attack the enemy carrying the charge: the shared preference, renewed while it holds. The core never lets
-- it replace the champion the player selected and clears it on lapse, death and range loss.
function TristanaChampion:PreferCharged()
 local mode=GetMode();local p=self.charge;local u=p and p.target
 if u and(u.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')or u.type~=Obj_AI_Hero and mode=='LaneClear')
  and self:Allowed(u)and self:Charge(u)and Core:PreferAttack('TristanaCharge',u,.25)then return true end
 Core:ReleaseAttackPreference('TristanaCharge');return false
end
function TristanaChampion:Weave(witness)
 if not self:AttackUseful(witness)then return end
 local target=witness.object;local settings,context=self:AttackPermission(target)
 if not settings or not Core.manaAbove(settings.Mana:Value())then return end
 local valid=function()return self:AttackUseful(witness)and self:AttackPermission(target)==settings and Core.manaAbove(settings.Mana:Value())end
 local wave=target.type==Obj_AI_Minion and target.team~=300
 local eAllowed=target.type==Obj_AI_Hero or target.team==300 and not self:SmallMonster(target)or target.type==Obj_AI_Turret or wave and self:WaveE(target)
 if eAllowed and settings.E:Value()and self:Ready(_E)and self:CastE(target,context,wave and function()return valid()and self:WaveE(target)end or valid)then return true end
 if not settings.Q:Value()or not self:Ready(_Q)then return end
 if target.type==Obj_AI_Minion and target.team~=300 then
  local n=0;local list=_G.SDK.ObjectManager:GetEnemyMinions(self.ERange)
  for i=1,math.min(#list,40)do local u=list[i];if self:Reach(u,self.ERange)and u.team~=300 then n=n+1 end end
  if n<Menu.Clear.LaneClear.QCount:Value()then return end
 end
 return self:CastQ(target,context,function()
  if not valid()then return false end
  if target.type==Obj_AI_Minion and target.team~=300 then return GetMinionCount(self.ERange,myHero.pos)>=Menu.Clear.LaneClear.QCount:Value()end
  return true
 end)
end
-- Q has no cast time; the observed cast starts the drawn attack-speed timer.
function TristanaChampion:CastQ(target,context,validate)
 local ok=self:Submit(_Q,HK_Q,nil,{intentTarget=target,context=context,observe=function(q)return Core:NativeCast(q,self.profile.q)~=nil end,
  validate=function()return self:Ready(_Q,true)and validate()end})
 if ok then Core:AfterCast(HK_Q,function()self.qUntil=Game.Timer()+self.profile.qDuration end)end
 return ok
end
-- Q at the first attack of a trade: the Combo or Harass champion is in attack range and an attack may start
-- now (none winding up). Q never delays that attack, so the opener already gets the attack speed.
function TristanaChampion:OpenQ(mode)
 local settings=Menu[mode];if not settings.Q:Value()or not self:Ready(_Q)or not Core.manaAbove(settings.Mana:Value())then return false end
 local target=self:GetTarget();if not target or target.type~=Obj_AI_Hero then return false end
 local function attackNow()return _G.SDK.Data:IsInAutoAttackRange(myHero,target)and _G.SDK.Orbwalker:CanAttack()and Core:AttackWindupRemaining()<=0 end
 if not attackNow()then return false end
 local handle=target.handle
 return self:CastQ(target,Core:ModeContext(mode),function()return settings.Q:Value()and Core.manaAbove(settings.Mana:Value())and target.handle==handle and self:Allowed(target)and attackNow()end)
end
function TristanaChampion:OnPostAttack(args)
 if ShouldWait()then return end
 local witness=Core:AttackWitness(self.attackWitness,args and args.Target)
 if not witness or witness==self.attackWitness or witness.at>Game.Timer()then return end
 self.attackWitness=witness;return self:Weave(witness)
end
function TristanaChampion:Combo()return self:OpenE('Combo')or self:OpenQ('Combo')or self:Weave(self.attackWitness)end
function TristanaChampion:Harass()return self:OpenE('Harass')or self:OpenQ('Harass')or self:Weave(self.attackWitness)end
function TristanaChampion:LaneClear()if Core:FarmModeEnabled('lane')then return self:Weave(self.attackWitness)end end
function TristanaChampion:JungleClear()if Core:FarmModeEnabled('jungle')then return self:OpenJungleE()or self:Weave(self.attackWitness)end end
function TristanaChampion:GetRDmg(target)
 local base=self.profile.rBase[myHero:GetSpellData(_R).level];if not base or not IsValid(target)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.rAD*myHero.bonusDamage+self.profile.rAP*myHero.ap)
end
-- The Normal charge at `count` stacks. Infinity Edge raises the crit share; other item effects are left out.
function TristanaChampion:ChargeDamage(target,count)
 local p=self.profile;local base=p.eBase[myHero:GetSpellData(_E).level]
 local crit=myHero.critChance;if p.eKind~='charge'or not base or not finite(crit)or crit<0 or crit>1 then return 0 end
 local share=p.eCrit+(crit>0 and HasItem(myHero,p.eCritItem)and p.eCritIE or 0)
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,(base+p.eAD*myHero.bonusDamage+p.eAP*myHero.ap)*(1+count*p.eAmp)*(1+crit*share))
end
function TristanaChampion:GetEDmg(target)
 -- Classic's full future DoT is never immediate lethal damage.
 local count=self:Charge(target);if count==nil then return 0 end
 return self:ChargeDamage(target,count)
end
-- Classic: the part of the burn still to come, counted in whole ticks.
function TristanaChampion:BurnLeft(target)
 local p=self.profile;local row=self.dot
 if p.eKind~='dot'or not row or not row.observed or row.target~=target or identity(target)~=row.id or row.handle~=target.handle then return 0,0 end
 local buff,expiry=self:OwnedBuff(target);local base=p.eBase[myHero:GetSpellData(_E).level]
 if not buff or not base then return 0,0 end
 local left=expiry-Game.Timer();local ticks=math.max(0,math.min(p.eTicks,math.floor(left*p.eTicks/p.eDuration)))
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,(base+p.eAP*myHero.ap)*ticks/p.eTicks),left
end
function TristanaChampion:RImpact(target)return .35+GetDistance(target.pos,myHero.pos)/self.profile.rSpeed end
-- `impact` given: R cast from somewhere else (after a jump) landing that many seconds from now; reach is
-- then the caller's. Without it: R cast from here at a target in reach.
function TristanaChampion:RCandidate(target,impact)
 return target and target.type==Obj_AI_Hero and(impact and finite(impact)and self:Current(target)and target.team~=myHero.team or not impact and self:Reach(target,self.RRange))
end
function TristanaChampion:LethalR(target,impact)
 if not self:RCandidate(target,impact)then return false end
 -- Magic damage: the shared rule charges the magic shield pool and the regeneration until impact.
 return(Core:Lethal(target,impact or self:RImpact(target),function()return self:GetRDmg(target)end,{kind='magical'}))
end
-- E + R, the kill pattern: neither kills alone, both together do. Normal: R adds a stack; a full charge
-- then goes off when the knock-back ends, a partial one when it expires. Classic: R plus the burn to come.
function TristanaChampion:LethalER(target,impact)
 if not self:RCandidate(target,impact)or Core:SpellProtected(target)~=false then return false end
 local p=self.profile;impact=impact or self:RImpact(target);local r=self:GetRDmg(target)*.97-2;if r<=0 then return false end
 if p.eKind=='charge'then
  local count,expiry=self:Charge(target,impact);if not count then return false end
  local left=expiry-Game.Timer();local after=math.min(count+1,p.eMax)
  local alone=Core:HealthEstimate(target,left,'physical',self:ChargeDamage(target,count)*.97)
  if alone and alone.lethal then return false end
  local both=Core:MixedHealthEstimate(target,after>=p.eMax and impact+1 or left,self:ChargeDamage(target,after)*.97,r)
  return both~=nil and both.lethal==true
 end
 local burn,left=self:BurnLeft(target);if burn<=0 or left<=impact then return false end
 if Core:Lethal(target,left,burn,{kind='magical',protection=false})then return false end
 return(Core:Lethal(target,left,burn+self:GetRDmg(target),{kind='magical',protection=false}))
end
function TristanaChampion:AttackKills(target)
 return _G.SDK.Data:IsInAutoAttackRange(myHero,target)and _G.SDK.Orbwalker:CanAttack()
  and _G.SDK.Damage:GetAutoAttackDamage(myHero,target,true)*.97>=target.health+(target.shieldAD or 0)+2
end
function TristanaChampion:CastR(target,validate,context)
 if not self:Ready(_R)or not self:Reach(target,self.RRange)or target.type~=Obj_AI_Hero then return false end
 local handle=target.handle
 return self:Submit(_R,HK_R,target,{range=self.RRange,context=context,observe=function(q)local a=Core:NativeCast(q,self.profile.r);return a and self:Current(target)and target.handle==handle and(a.target==identity(target)or a.target==handle)end,
  validate=function()return self:Ready(_R,true)and self:Allowed(target)and target.handle==handle and self:Reach(target,self.profile.rRange or myHero.range+myHero.boundingRadius)and(not validate or validate())end})
end
function TristanaChampion:Dashing()local path=myHero.pathing;return path and path.isDashing==true end
function TristanaChampion:KillSteal()
 -- Mid-jump the R waits for the landing (a jump into R range lands first).
 if not self:Ready(_R)or self:Dashing()then return end
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(self.RRange)
 for i=1,math.min(#list,10)do local u=list[i]
  -- A ready attack that kills keeps the ultimate.
  if self:Reach(u,self.RRange)and not self:AttackKills(u)and self:LethalR(u)then return self:CastR(u,function()return self:LethalR(u)end)end
 end
end
-- Its own decision: the shared KillSteal policy weighs R's damage alone.
function TristanaChampion:DetonateKill()
 if not self:Ready(_R)or self:Dashing()then return end
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(self.RRange)
 for i=1,math.min(#list,10)do local u=list[i]
  if self:Reach(u,self.RRange)and not self:AttackKills(u)and self:LethalER(u)then return self:CastR(u,function()return self:LethalER(u)end)end
 end
end
function TristanaChampion:Interrupt()
 if not Menu.Misc.Rint:Value()or not self:Ready(_R)then return end
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(self.RRange)
 for i=1,math.min(#list,10)do local u=list[i]
  -- A recall is not worth the ultimate.
  if self:Reach(u,self.RRange)and not Recalling(u)and Core:CanInterrupt(u,self:RImpact(u))then
   return self:CastR(u,function()return Menu.Misc.Rint:Value()and Core:CanInterrupt(u,self:RImpact(u))end)
  end
 end
end
function TristanaChampion:GapThreat(target)
 local p=target and target.pathing
 -- Kept beside Core:ApproachingDash on purpose: this one reads the raw dash end point and leaves out dashes
 -- named in the shared "not a gap-closer" list; the shared reader needs a complete motion sample.
 return self:Reach(target,self.RRange)and p and p.isDashing and p.endPos and not HasInvalidDashBuff(target)and GetDistance(p.endPos,myHero.pos)<300 and GetDistance(p.endPos,myHero.pos)<GetDistance(target.pos,myHero.pos)
end
function TristanaChampion:AntiGapcloser()
 if not Menu.Misc.Rgap:Value()or not self:Ready(_R)then return end
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(self.RRange)
 for i=1,math.min(#list,10)do local u=list[i];if self:GapThreat(u)then return self:CastR(u,function()return Menu.Misc.Rgap:Value()and self:GapThreat(u)end)end end
end
-- Self-peel: low on health with an enemy champion on top of her (its attack or cast aimed at her, a dash
-- landing on her or a melee champion in reach, from the shared peel reader), R knocks it away and stuns it.
-- Not into crowd-control immunity or a spell shield. When fleeing with the jump ready to a safe landing the
-- jump escapes and R is kept, unless R kills.
function TristanaChampion:PeelThreat(validation)
 if not Menu.Misc.RPeel:Value()or not self:Ready(_R,validation)or not finite(myHero.health)or not finite(myHero.maxHealth)or myHero.maxHealth<=0
  or myHero.health/myHero.maxHealth*100>Menu.Misc.PeelHP:Value()then return nil end
 local u=Core:PeelTarget(myHero,.75)
 if not u or not self:Allowed(u)or not self:Reach(u,math.min(self.RRange,250+(u.boundingRadius or 65)))then return nil end
 local impact=self:RImpact(u)
 if Core:CCImmune(u,impact)~=false or Core:SpellProtected(u)~=false then return nil end
 return u
end
function TristanaChampion:SelfPeel()
 local u=self:PeelThreat();if not u then return false end
 if GetMode()=='Flee'and Menu.Misc.FleeW:Value()and self:Ready(_W)and not self.jump and self:JumpPoint()and not self:LethalR(u)then return false end
 return self:CastR(u,function()return self:PeelThreat(true)==u end)
end
-- Flash-R: where to stand so the knock-back (away from Tristana) sends the target toward the team: the allied
-- champions within 1500 of it, else the closest allied turret within 1500.
function TristanaChampion:TeamAnchor(u)
 local x,z,n=0,0,0;local rows=Core:Rows('hero',nil,true)
 for i=1,#rows do local a=rows[i];if a~=myHero and IsValid(a)and GetDistance(a.pos,u.pos)<=1500 then x,z,n=x+a.pos.x,z+a.pos.z,n+1 end end
 if n>0 then return {x=x/n,y=u.pos.y or 0,z=z/n}end
 local best;local turrets=Core:DecisionUnits('GetAllyTurrets')
 for i=1,math.min(#turrets,16)do local t=turrets[i];if IsValid(t)and GetDistance(t.pos,u.pos)<=1500 and(not best or GetDistance(t.pos,u.pos)<GetDistance(best.pos,u.pos))then best=t end end
 return best and {x=best.pos.x,y=best.pos.y or 0,z=best.pos.z}or nil
end
-- A landing behind `u` as seen from the team: within R reach of it and on the far side of its line to the anchor.
function TristanaChampion:InsecLanding(u,pos,anchor)
 anchor=anchor or self:TeamAnchor(u);if not anchor or not pos then return false end
 local ax,az=u.pos.x-anchor.x,u.pos.z-anchor.z;local bx,bz=pos.x-u.pos.x,pos.z-u.pos.z
 local la,lb=math.sqrt(ax*ax+az*az),math.sqrt(bx*bx+bz*bz)
 return la>=200 and lb>0 and(ax*bx+az*bz)/(la*lb)>=.8 and lb<=self.RRange-25 and not IsUnderTurret2(pos)
end
function TristanaChampion:FlashInsec()
 local combo=self.flashR
 if combo:Busy()or not Menu.Misc.FlashR:Value()or not Menu.Misc.SemiR:Value()or not self:Ready(_R)then return false end
 local u=_G.SDK.TargetSelector.Selected;if not self:Allowed(u)or u.type~=Obj_AI_Hero or u.team==myHero.team then return false end
 local anchor=self:TeamAnchor(u);if not anchor then return false end
 -- Already behind it: the plain R does it.
 if self:InsecLanding(u,myHero.pos,anchor)then return false end
 local status=Core:FlashStatus();if not status then return false end
 local rCost=myHero:GetSpellData(_R).mana;if not finite(rCost)or myHero.mana<status.cost+rCost then return false end
 local d=GetDistance(anchor,u.pos);local back=150
 local aim={x=u.pos.x+(u.pos.x-anchor.x)/d*back,y=u.pos.y or 0,z=u.pos.z+(u.pos.z-anchor.z)/d*back}
 if GetDistance(aim,myHero.pos)>status.range or not self:InsecLanding(u,aim,anchor)then return false end
 local handle=u.handle
 local function authorized()return Menu.Misc.FlashR:Value()and Menu.Misc.SemiR:Value()end
 local function valid(pos)return self:Ready(_R)and self:Allowed(u)and u.handle==handle and myHero.mana>=status.cost+rCost and self:InsecLanding(u,pos)end
 return(combo:Start{order='flash_first',aim=aim,authorized=authorized,valid=valid,mana=rCost,
  follow=function(context)return self:CastR(u,function()return authorized()and u.handle==handle and self:InsecLanding(u,myHero.pos)end,context)end})
end
function TristanaChampion:SemiR()
 if not Menu.Misc.SemiR:Value()or not self:Ready(_R)then return end
 local selected=_G.SDK.TargetSelector.Selected
 if self:Reach(selected,self.RRange)and selected.type==Obj_AI_Hero then return self:CastR(selected)end
 if self.charge and self:Charge(self.charge.target)then
  local target=self:GetTarget();if self:Reach(target,self.RRange)then return self:CastR(target)end
 end
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(self.RRange);local best
 for i=1,math.min(#list,10)do local u=list[i];if self:Reach(u,self.RRange)and(not best or GetDistance(u.pos,myHero.pos)<GetDistance(best.pos,myHero.pos))then best=u end end
 if best then return self:CastR(best)end
end
-- Jump closer for an R kill: the enemy is out of R reach now; the jump lands R reach minus 50 short of where
-- it is predicted to stand, and R (or the charge or burn with R) still kills at that later impact. R itself
-- goes out from the ordinary kill decisions once the jump has landed; the takedown gives the jump back.
function TristanaChampion:RJumpPoint(u,predicted)
 local p=self.profile;local pos=predicted or u.pos;local d=GetDistance(pos,myHero.pos);local keep=self.RRange-50
 if not finite(d)or d<=self.RRange or d-keep>p.wRange or keep<=0 then return nil end
 local t=(d-keep)/d;local point={x=myHero.pos.x+(pos.x-myHero.pos.x)*t,y=myHero.pos.y or 0,z=myHero.pos.z+(pos.z-myHero.pos.z)*t}
 return self:SafeJump(point)and point or nil
end
function TristanaChampion:RJumpAim(u)
 local aim=Core:Prediction(self.RJumpSpell);aim:GetPrediction(u,myHero)
 if not aim:CanHit(2)or not aim.CastPosition then return nil end
 return self:RJumpPoint(u,aim.CastPosition)
end
function TristanaChampion:JumpRKills(u,point)
 local p=self.profile;if not point or u.type~=Obj_AI_Hero or not self:Allowed(u)or not self:Ready(_R)then return false end
 local w,r=myHero:GetSpellData(_W).mana,myHero:GetSpellData(_R).mana
 if not finite(w)or not finite(r)or myHero.mana<w+r then return false end
 local impact=p.wDelay+GetDistance(point,myHero.pos)/p.wSpeed+.35+(self.RRange-50)/p.rSpeed
 return self:LethalR(u,impact)or self:LethalER(u,impact)
end
function TristanaChampion:RJump()
 if GetMode()~='Combo'or not Menu.Combo.WR:Value()or self.jump or self.finisher:Busy()or not self:Ready(_W)or not self:Ready(_R)or not self:JumpFit()then return false end
 local aims={}
 local u=Core:LethalPick(Core:Rows('hero',self.profile.wRange+self.RRange),function(v)local point=self:RJumpAim(v);aims[v]=point;return self:JumpRKills(v,point)end,
  function(v)return self:Allowed(v)and not self:Reach(v,self.RRange)end)
 if not u then return false end
 local handle=u.handle
 local ok=self:Submit(_W,HK_W,aims[u],{owner='RJump',context=Core:ModeContext('Combo'),intentTarget=u,range=self.profile.wRange,objectRange=self.profile.wRange+self.RRange,prevalidateWorldCast=true,
  resolve=function()local point=u.handle==handle and self:RJumpAim(u);return point and {position=point}or nil end,
  observe=function(q)return Core:NativeCast(q,self.profile.w)~=nil end,
  validate=function(q,resolved)local point=resolved and resolved.position or q.target
   return Menu.Combo.WR:Value()and self:Ready(_W,true)and u.handle==handle and self:JumpFit()and self:SafeJump(point)and not self:Reach(u,self.RRange)and self:JumpRKills(u,point)end})
 if ok then self.finisher:Begin(u,Core.lastIntent,2.5)end
 return ok
end
function TristanaChampion:SafeJump(point)
 return point and finite(point.x)and finite(point.z)and GetDistance(point,myHero.pos)<=self.profile.wRange and type(Game.isWall)=='function'and Game.isWall(point)==false and not IsUnderTurret2(point)and GetEnemyCount(600,point)<=Menu.Misc.WEnemies:Value()
end
function TristanaChampion:JumpPoint(target)
 local aim=target and target.pos or mousePos;local distance=GetDistance(aim,myHero.pos);if not finite(distance)or distance<100 then return nil end
 local p=myHero.pos:Extended(aim,math.min(distance,self.profile.wRange))
 return self:SafeJump(p)and {x=p.x,y=p.y,z=p.z}or nil
end
function TristanaChampion:Jump(held,context,target)
 if not held()or not self:Ready(_W)or self.jump then return false end
 if target and not self:EngageAllowed(target,true)then return false end
 local point=self:JumpPoint(target);self.jumpPreview=point;if not point then return false end
 local handle=target and target.handle;local witness={};local function legal()return held()and(not target or target.handle==handle and self:EngageAllowed(target,true))end
 local ok=self:Submit(_W,HK_W,point,{owner='Jump',context=context,intentTarget=target,range=self.profile.wRange,independent=false,prevalidateWorldCast=true,
  resolve=function()local p=legal()and self:JumpPoint(target);return p and {position=p}or nil end,
  commitGuard=function()return Core:Current()and held()end,
  validate=function(_,resolved)return legal()and self:Ready(_W,true)and self:SafeJump(resolved and resolved.position or point)end,
  observe=function(q)local a=Core:NativeCast(q,self.profile.w);if not a then return false end
   witness.started=a.startTime;local endPos=a.endPos or a.placementPos;if endPos and finite(endPos.x)and finite(endPos.z)and GetDistance(endPos,q.target)<=100 then witness.endpoint={x=endPos.x,y=endPos.y,z=endPos.z}end;return true end})
 if ok then local p={id=Core.lastIntent.id,held=held,context=context,target=target,handle=handle,deadline=Core.lastIntent.requestGameTime+2.5};self.jump=p;Core:AfterCast(HK_W,function()if self.jump==p then p.observed=true;p.started=witness.started;p.endpoint=witness.endpoint;p.deadline=witness.started+2.5 end end)end
 return ok
end
function TristanaChampion:MaintainJump()
 local p=self.jump;if not p then return end
 local result=Core.adapter:Poll(p.id)
 if not p.held()then Core.adapter:Cancel(p.id,'jump_key_released');self.jump=nil;self.jumpPreview=nil;return end
 if result and(result.state=='cancelled_before_send'or result.state=='aborted')then self.jump=nil;return end
 local cd=myHero:GetSpellData(_W).currentCd
 if p.observed and finite(cd)and cd>0 then p.seenCooldown=true end
 if p.observed and p.seenCooldown and self:Ready(_W)then p.resetObserved=true end
 if Game.Timer()>p.deadline then p.continuationEnded=true end
 -- Landing is the observed cast's dash having ended, wherever it ended: the
 -- follow-up checks its own reach. Requiring the native cast's end point and a
 -- landing within 90 units of it left the jump unlanded, and attacks and E on its
 -- target refused until the 2.5 s deadline, whenever the host omitted that point
 -- or the jump came up short.
 if p.observed and Game.Timer()<=p.deadline then local path=myHero.pathing
  if path and path.isDashing then p.dashSeen=true end
  if p.dashSeen and path and not path.isDashing then p.landed=true end
 end
 -- One request per held gesture. Reset observation never starts a second engage.
end
function TristanaChampion:EngageAllowed(u,paid)
 if not Menu.Misc.WEngage:Value()or not self:Allowed(u)or u.type~=Obj_AI_Hero or not finite(myHero.health)or not finite(myHero.maxHealth)or myHero.maxHealth<=0 or myHero.health/myHero.maxHealth*100<Menu.Misc.EngageHP:Value()then return false end
 if not self:SafeJump(u.pos)then return false end
 local q,e,w=myHero:GetSpellData(_Q),myHero:GetSpellData(_E),myHero:GetSpellData(_W)
 if paid and not(Menu.Combo.Q:Value()and self:Ready(_Q,true)or Menu.Combo.E:Value()and self:Ready(_E,true))then return false end
 local function remaining(slot,d,on)local row=self.issued[slot];if not on or not paid and(row and row.q.observedAt or d.currentCd>0)then return 0 end;return d.mana end
 local cost=remaining(_Q,q,Menu.Combo.Q:Value())+remaining(_E,e,Menu.Combo.E:Value())+(paid and w.mana or 0)
 return finite(cost)and myHero.mana>=cost and(not paid or GetDistance(u.pos,myHero.pos)<=self.profile.wRange)and(Menu.Combo.E:Value()or Menu.Combo.Q:Value())
end
function TristanaChampion:Engage()
 if not Menu.Misc.WEngage:Value()then return false end
 local p=self.jump
 if not p then local u=_G.SDK.TargetSelector.Selected;if not self:EngageAllowed(u,true)then return false end
  local held=function()return Menu.Misc.WEngage:Value()end;return self:Jump(held,Core:HeldContext(held),u)
 end
 if not p.target or p.continuationEnded then return false end
 if not p.held()or not self:Allowed(p.target)or p.target.handle~=p.handle or not self:EngageAllowed(p.target)then return false end
 if not p.landed or p.deadline and Game.Timer()>p.deadline or not self:Reach(p.target,self.ERange)then return false end
 -- E first after the landing, so the attacks that follow stack it.
 if not p.opened and Menu.Combo.E:Value()and self:Ready(_E)then local target=p.target
  if self:CastE(target,p.context,function()return self.jump==p and not p.continuationEnded and p.held()and target.handle==p.handle and self:EngageAllowed(target)end)then p.opened=true;return true end
 end
 local witness=Core:AttackWitness(nil,p.target)
 if witness and witness.at>=p.started then self.attackWitness=witness;return self:Weave(witness)or true end
 if not p.attack and _G.SDK.Orbwalker:CanAttack()then
  local target=p.target;local ok=Core:Attack(target,{owner='JumpAttack',context=p.context,ttl=350,
   validate=function()return self.jump==p and not p.continuationEnded and p.held()and p.landed and target.handle==p.handle and self:EngageAllowed(target)and self:Reach(target,self.ERange)end,
   observe=function(q)local a=Core:NativeAttack(q);return a and(a.target==identity(target)or a.target==p.handle)end})
  if ok then p.attack=Core.lastIntent;return true end
 end;return false
end
function TristanaChampion:JumpDamage(target)
 local p=self.profile;local base=p.wBase[myHero:GetSpellData(_W).level];if not base then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,base+p.wAD*myHero.bonusDamage+p.wAP*myHero.ap)
end
-- The landing kills from current health, or it adds the fourth stack and the charge that goes off with it
-- does. Either way the jump comes back, so it costs no escape.
function TristanaChampion:JumpKills(target,point)
 local p=self.profile
 if target.type~=Obj_AI_Hero or not self:Allowed(target)or not self:Reach(target,p.wRange)then return false end
 local impact=p.wDelay+GetDistance(point or target.pos,myHero.pos)/p.wSpeed+.1;local w=self:JumpDamage(target);if w<=0 then return false end
 if Core:Lethal(target,impact,w,{now=true,kind='magical'})then return true end
 if p.eKind~='charge'or self:Charge(target,impact)~=p.eMax-1 or Core:SpellProtected(target)~=false then return false end
 local both=Core:MixedHealthEstimate(target,impact,self:ChargeDamage(target,p.eMax)*.97,math.max(0,w*.97-2))
 return both~=nil and both.lethal==true
end
function TristanaChampion:JumpFit()
 return finite(myHero.health)and finite(myHero.maxHealth)and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.EngageHP:Value()
end
function TristanaChampion:FinishJump()
 if GetMode()~='Combo'or not Menu.Combo.W:Value()or self.jump or self.finisher:Busy()or not self:Ready(_W)or not self:JumpFit()then return false end
 local u=Core:LethalPick(Core:Rows('hero',self.profile.wRange),function(v)return self:JumpKills(v)end,
  function(v)return self:Allowed(v)and not self:AttackKills(v)end,function(v)return self:SafeJump(v.pos)end)
 if not u then return false end
 local handle=u.handle;local aim=Core:Prediction(self.WSpell);aim:GetPrediction(u,myHero)
 if not aim:CanHit(3)or not self:SafeJump(aim.CastPosition)then return false end
 local ok=self:Submit(_W,HK_W,aim.CastPosition,{owner='FinishJump',context=Core:ModeContext('Combo'),intentTarget=u,range=self.profile.wRange,prevalidateWorldCast=true,
  observe=function(q)return Core:NativeCast(q,self.profile.w)~=nil end,
  validate=function(q,resolved)local point=resolved and resolved.position or q.target
   return Menu.Combo.W:Value()and self:Ready(_W,true)and u.handle==handle and self:JumpFit()and self:SafeJump(point)and self:JumpKills(u,point)end})
 if ok then self.finisher:Begin(u,Core.lastIntent,2.5)end
 return ok
end
-- Evade's use of the jump: never over an own jump in progress, and only onto a landing the player's own
-- limits allow (known open ground, no enemy turret, not into more enemies than configured).
function TristanaChampion:EvadeJumpAllowed(point)
 if self.jump or self.issued[_W]or self.finisher:Busy()then return false,'own_jump_in_progress'end
 if point==nil then return true end
 local p=Core.point(point)
 if not p or GetDistance(p,myHero.pos)>self.profile.wRange+5 or type(Game.isWall)~='function'or Game.isWall(p)~=false then return false,'landing_unknown_or_wall'end
 if IsUnderTurret2(p)then return false,'enemy_turret'end
 if GetEnemyCount(600,p)>Menu.Misc.WEnemies:Value()then return false,'enemies_at_landing'end
 return true
end
function TristanaChampion:ERAssist()
 if self.profile.eKind~='charge'or not Menu.Misc.ERAssist:Value()or not self:Ready(_R)then return false end
 local selected=_G.SDK.TargetSelector.Selected;local u=self.charge and self.charge.target
 if selected and self:Allowed(selected)and selected~=u then return false end
 local function legal()return Menu.Misc.ERAssist:Value()and u and self:Allowed(u)and self:Charge(u,.35+GetDistance(u.pos,myHero.pos)/self.profile.rSpeed)==3 end
 return legal()and self:CastR(u,legal,Core:HeldContext(function()return Menu.Misc.ERAssist:Value()end))or false
end
function TristanaChampion:RescueE(u)
 if self.profile.eKind~='charge'or not self:Reach(u,self.ERange)or u.team==300 or u.type~=Obj_AI_Minion then return false end
 local delay=.35+GetDistance(myHero.pos,u.pos)/self.profile.eSpeed+self.profile.eDuration
 local hp=Core:UnshieldedLegacyForecast(u,delay);local base=self.profile.eBase[myHero:GetSpellData(_E).level]
 if not hp or hp<=0 or not base or _G.SDK.Data:IsInAutoAttackRange(myHero,u)and _G.SDK.Orbwalker:CanAttack()then return false end
 if not finite(u.ms)then return false end
 local rows=Core:DecisionUnits('GetEnemyMinions');for i=1,math.min(#rows,48)do local v=rows[i];if v~=u and self:Current(v)then
  -- A long delayed bomb needs an isolated reachability envelope, not just current splash geometry.
  if not finite(v.ms)or GetDistance(v.pos,u.pos)<=self.profile.eRadius+(v.boundingRadius or 0)+(u.boundingRadius or 0)+(u.ms+v.ms)*delay then return false end
 end end
 local damage=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,base+self.profile.eAD*myHero.bonusDamage+self.profile.eAP*myHero.ap)
 return damage>=hp+(u.hpRegen or 0)*delay
end
function TristanaChampion:LastHit()
 if self.profile.eKind~='charge'or GetMode()~='LastHit'or not Menu.LastHit.E:Value()or not Core.manaAbove(Menu.LastHit.Mana:Value())or not self:Ready(_E)then return false end
 local list=Core:DecisionUnits('GetEnemyMinions');for i=1,math.min(#list,24)do local u=list[i]
  if self:RescueE(u)then return self:CastE(u,Core:ModeContext('LastHit',function()return Menu.LastHit.E:Value()and Core.manaAbove(Menu.LastHit.Mana:Value())end),function()return self:RescueE(u)end)end
 end;return false
end
-- Health-bar damage: ready R, the charge as it stands (or E from no stacks when ready), the burn still to
-- come (Classic), a ready jump landing and one attack. Partial: future stacks and items are left out.
function TristanaChampion:ComboDamage(u)
 local total=_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true) or 0
 if self:Ready(_R)then total=total+self:GetRDmg(u)end
 if self:Ready(_W)then total=total+self:JumpDamage(u)end
 if self.profile.eKind=='charge'then
  local count=self:Charge(u);if count then total=total+self:ChargeDamage(u,count)elseif self:Ready(_E)then total=total+self:ChargeDamage(u,0)end
 else total=total+self:BurnLeft(u)end
 return total
end
-- Remaining Q time: the own buff named like the Q spell, else the observed own Q cast plus its duration.
function TristanaChampion:QLeft()
 local now=Game.Timer();local name=self.profile.q:lower();local count=myHero.buffCount
 if finite(count)and count>=0 and count<=128 then
  for i=0,math.min(count,64)do local b=myHero:GetBuff(i)
   if b and type(b.name)=='string'and b.name:lower()==name and(b.count or 1)>0 then local e=Core.buffExpiry(b);if finite(e)and e>now then return e-now end end
  end
 end
 return self.qUntil and self.qUntil>now and self.qUntil-now or nil
end
function TristanaChampion:PreparePreview()
 -- The jump landing only: the game shows E's charge on the enemy and Q's time. Kept for a second so a late
 -- preparation never blinks it; Draw shows it only while W is ready.
 self.jumpPreview=Menu.Draw.W:Value()and self:Ready(_W)and self:JumpPoint()or nil
 self.preview={expires=Game.Timer()+1,jump=self.jumpPreview}
end
function TristanaChampion:Flee()if Menu.Misc.FleeW:Value()then return self:Jump(function()return Menu.Misc.FleeW:Value()and GetMode()=='Flee'end,Core:ModeContext('Flee'))end end
function TristanaChampion:Tick()
 self:UpdateRanges();self:MaintainIssued();self:MaintainJump()
 -- The refund is the evidence that the slot is free again; its cooldown may never have been seen.
 if self.finisher:Maintain()=='refunded'then self.issued[_W]=nil end
 if Game.Timer()>=(self.nextTargets or 0)then self.nextTargets=Game.Timer()+1;self:DiscoverTargets()end
 if self.previewFallback and Menu.Draw.W:Value()and Game.Timer()>=(self.nextPreview or 0)then self.nextPreview=Game.Timer()+.15;self:PreparePreview()end
 for _,kind in ipairs({'charge','dot'})do local p=self[kind];if p and(Game.Timer()>p.expires or identity(p.target)~=p.id or p.target.handle~=p.handle or not self:Current(p.target))then self[kind]=nil end end
 self:PreferCharged()
 if self.flashR:Maintain()then return end
 if ShouldWait()or IsCasting()then return end
 if self:AntiGapcloser()or self:SelfPeel()or self:Interrupt()or self:FlashInsec()or self:SemiR()or self:ERAssist()or self:FinishJump()or self:KillSteal()or self:DetonateKill()or self:RJump()or self:Engage()then return end
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')then self:LaneClear()end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function TristanaChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.R:Value()and IsReady(_R)then Draw.Circle(myHero.pos,self.RRange,1,Draw.Color(255,66,229,244))end
 local p=self.preview
 if p and p.expires>Game.Timer()and Menu.Draw.W:Value()and p.jump and IsReady(_W)then Draw.Circle(p.jump,50,1,Draw.Color(255,66,229,244))end
end
function TristanaChampion:RegisterGuide(guide,settings)
 return guide:Register('champion',{'Tristana: attack assistance','Tristana: jumps and R'},function(page)
  return {title=page==1 and 'Attack-linked spells'or 'Held mobility',cards=page==1 and {
   {'ATTACK','E opens on a Combo or Harass target in reach before the first attack and Q goes out as that first attack can start; on farm targets Q follows a completed attack. In Combo and Harass the enemy carrying your charge is attacked first, unless you selected another champion.'},
    {'FARM','Lane and jungle retain their own binds. In the jungle E goes on the big monster; in lane Normal E goes on a turret, or on a minion standing in a full wave when no turret is in reach. Normal LastHit E follows the farm toggle, saves isolated otherwise missed CS and counts base expiry damage only. Classic future DoT is excluded.'},
   {'PROFILE','Normal owns a charge ledger. Classic E remains a separate DoT; future ticks are not immediate lethal damage.'}}or {
    {'JUMP','Flee jumps toward the cursor; the engage bind jumps on the selected target and casts E after the landing. In Combo a jump whose landing kills is taken inside the health, enemy-count and turret limits, because the kill gives the jump back; it also jumps closer to an enemy out of R reach when R (with your E) would then kill it. Evade may use the jump to dodge.'},
    {'R','R is cast without a key when it kills, or when it and your E together kill and neither does alone (Normal: the charge with the stack R adds; Classic: the burn still to come). It also knocks back dashes onto you, an enemy on top of you when your health is low, and interrupts channels. One bind casts R at the selected target (optionally after a Flash behind it, so it flies toward your team); on Normal a second detonates a nearly full charge.'},
    {'STATE','The attack preference for the charged enemy is a short shared lease that never replaces your selected champion. Release and press again for a new engage jump.'}},note='Live charge fields and the E/R impact order remain pending acceptance.'}
 end)
end
Core:RegisterPolicy({damageTypes={R='magical'},methods={
 Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 LaneClear=function()return Core:FarmContext('lane')end,JungleClear=function()return Core:FarmContext('jungle')end,
 OnPostAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode)end,
 SemiR=function()return Core:HeldContext(function()return Menu.Misc.SemiR:Value()end)end,
 Flee=function()return Core:ModeContext('Flee')end,AntiGapcloser=function()return {priority='interactive'}end,SelfPeel=function()return {priority='interactive'}end,
 Interrupt=function()return {priority='interactive'}end},
 exceptions={non_interrupting_summoner=true},channel=function()return not Core:SelfChanneling()end,
 validate=function(self,q,slot)
   if slot and slot>=_Q and slot<=_R then return self:Ready(slot,true)end
  -- Standalone Classic's existing activator also uses this facade. Its item
  -- and summoner intentions retain their own validation, outside champion data.
  return true
 end})
TristanaChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Tristana"]="Tristana"}
local normalSupported={["Tristana"]=true}

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
