return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Rell"]=function()return _G.OrbamaFamily:Require("6e3ece2d9f66d059190b4e41a3c766efb8c3b85b445594f1a4924d04b17dc478")()end
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
if champion=="Rell" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Rell',profiles={normal=true,classic=false},
 Create=function(context)
-- Normal Full Tilt kit, independently implemented from pinned assets and Riot.
local profiles=ChampionProfiles('Rell')
local finite,id,point=Core.finite,Core.id,Core.point
local spellOnly={attack=false} -- Core:Rescue: the attack is weighed here, by the rule this champion's regressions pin
local function ray(origin,aim,p)
 local dx,dz=aim.x-origin.x,aim.z-origin.z;local l=math.sqrt(dx*dx+dz*dz);if l<1 then return nil end
 dx,dz=dx/l,dz/l;return (p.x-origin.x)*dx+(p.z-origin.z)*dz,math.abs((p.x-origin.x)*dz-(p.z-origin.z)*dx)
end
local function cleanup(self)self.preview=nil;self.wObservation=nil;self.eObservation=nil;self.rObservation=nil;self.storm=nil;self.attackWitness=nil;self.pullProbe=nil end
local RellChampion=class("RellChampion")
function RellChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self:LoadMenu();self.allyMenus={}
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.4,Radius=75,Range=600,Speed=math.huge,Collision=false}
 Core:RegisterCleanup('Rell',function()cleanup(self)end)
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 local ok,why=Core:RegisterPreparation('Rell.preview',{intervalMs=150,maxDelayMs=450,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Preview:Value()or Menu.Draw.Ranges:Value()end,function()self.preview=nil end)
 self.previewFallback=not ok and why=='unsupported'
 -- The public transport exists, but current W slide/timing and shield-start
 -- evidence cannot certify an Evade forecast for Crash Down. Ordinary held casts still work.
 self.evadeUnavailable='W_slide_speed_and_shield_start_unverified'
 self:RegisterEvade()
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
end
-- Mount Up offered to Evade as a speed burst (S6): +30% decaying over 2 s (asset MountUpSpeed and its 2 s decay,
-- wiki 2026-10-10), offered as the mean of a linear decay (15% for 2 s), so a short dodge is underestimated,
-- never overestimated. Only while dismounted with Mount Up ready; no cast time.
function RellChampion:RegisterEvade()
 local p=self.profile
 if not Core.RegisterEffect or not finite(p.mountHaste)or not finite(p.mountHasteDecay)then return end
 self.hasteOffered,self.hasteReason,self.hasteAdapter=Core:RegisterEffect({kind='haste',name='Rell.MountUp',slot=_W,key=HK_W,profile=p.id,source=p.mountSource,
  delay=0,duration=p.mountHasteDecay,percent=p.mountHaste/2,ready=function()return self:Form()=='dismounted'and self:Ready(_W)end})
end
-- Health-bar damage (S9): ready Q, W in the current form and R plus one attack; partial (passive, E explosion).
function RellChampion:ComboDamage(u)
 if not self:Current(u)then return 0 end
 local total=0
 for _,slot in ipairs({_Q,_W,_R})do if self:Ready(slot)then total=total+self:Damage(u,slot)end end
 local ok,aa=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
 return total+(ok and finite(aa)and aa or 0),true
end
function RellChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Rell'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q',value=true})
  Menu[mode]:MenuElement({id='EngageW',name='Use W (crash down onto enemies)',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='E',name='Use E',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='EngageE',name='Use E to run at enemies out of reach',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Combo'and 15 or 40,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='Passive',name='Spread attacks to stack the passive',value=true,menu=false})
 Menu.Combo:MenuElement({id='R',name='Use R',value=true})
 Menu.Combo:MenuElement({id='RCount',name='R only when it pulls at least this many enemies',value=2,min=1,max=5,step=1})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=kind,name=kind=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[kind]:MenuElement({id='Q',name='Use Q',value=true})
  Menu.Clear[kind]:MenuElement({id='W',name='Use W',value=true})
  Menu.Clear[kind]:MenuElement({id='E',name='Use E',value=true})
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions Q must hit',value=2,min=2,max=8,step=1,menu=false})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Allies',name='Allies E may target'})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='WAssist',name='Cast W toward the cursor',key=string.byte('U')})
 Menu.Misc:MenuElement({id='EAssist',name='Cast E with your preferred ally',key=string.byte('N')})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R when an enemy is in reach',key=string.byte('T')})
 Menu.Misc:MenuElement({id='AntiDashQ',name='Stun enemies that dash at you or channel (Q)',value=true})
 Menu.Misc:MenuElement({id='FleeW',name='Mount up with W when fleeing',value=true})
 Menu.Misc:MenuElement({id='FleeE',name='Use E when fleeing',value=true})
 Menu.Misc:MenuElement({id='FleeQ',name='Use Q on a chaser when fleeing',value=true})
 Menu.Misc:MenuElement({id='Enemies',name='Never crash into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='TurretCrash',name='Combo W may crash under an enemy turret',value=false})
 Menu.Misc:MenuElement({id='PreserveShield',name='Keep the W shield in fights (no remount)',value=true,menu=false})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Preview',name='Show where the W bind would crash down',value=true})
end
function RellChampion:Rows(kind,range)return Core:Rows((kind=='ally'or kind=='heroes')and 'hero'or kind,range,kind=='ally')end
function RellChampion:Current(u)
 if u==myHero then return IsValid(u)and Core:Current()end
 return u~=nil and point(u.pos)~=nil and Core:CurrentUnit(u,u.team==myHero.team)
end
function RellChampion:Target(range)
 local u=_G.SDK.TargetSelector.Selected;if self:Current(u)and u.team~=myHero.team and GetDistance(u.pos,myHero.pos)<=range then return u end
 u=GetTarget(range);if self:Current(u)and u.team~=myHero.team and u.type==Obj_AI_Hero and GetDistance(u.pos,myHero.pos)<=range then return u end
 return self:Rows('heroes',range)[1]
end
function RellChampion:Buff(u,name,selfState)
 if not self:Current(u)or not finite(u.buffCount)or u.buffCount%1~=0 or u.buffCount<0 or u.buffCount>128 then return nil end
 for i=0,u.buffCount do local b=u:GetBuff(i);if b and b.name and b.name:lower()==name then
  local expiry=Core.buffExpiry(b)
  local source=b.source;local owner=type(source)=='number'and source or(type(source)=='table'or type(source)=='userdata')and id(source)
  local owned=owner==myHero.networkID or owner==myHero.handle or selfState and u==myHero and(owner==nil or owner==0)
  if type(source)=='table'or type(source)=='userdata'then
   if source.networkID and source.networkID~=0 and source.networkID~=myHero.networkID then owned=false end
   if source.handle and source.handle~=0 and source.handle~=myHero.handle then owned=false end
  end
  if b.sourcenID and b.sourcenID~=0 and b.sourcenID~=myHero.networkID then owned=false end
  if b.sourceName and b.sourceName~=''and b.sourceName~=myHero.charName then owned=false end
  if not finite(b.count)or b.count<0 then return nil,nil,'malformed_count'end
  if finite(b.count)and b.count>0 and(finite(expiry)and expiry>Game.Timer()or selfState and(not expiry or expiry==0))then
   if owned then return b,expiry else return nil,nil,'foreign_or_unattributed'end
  end
 end end
end
function RellChampion:Form()
 local name=myHero:GetSpellData(_W).name;local mounted=self:Buff(myHero,self.profile.mounted,true);local dismounted=self:Buff(myHero,self.profile.dismounted,true)
 if name==self.profile.w and not dismounted then return 'mounted'elseif name==self.profile.w2 and not mounted then return 'dismounted'end
end
function RellChampion:Ready(slot)
 local s=myHero:GetSpellData(slot);local key=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot]
 return s and finite(s.level)and s.level>=1 and s.level<=(slot==_R and 3 or 5)and finite(s.mana)and s.mana>=0 and s.mana<=myHero.mana
  and(slot==_W and self:Form()~=nil or slot~=_W and s.name==self.profile[key])and IsReady(slot)
end
function RellChampion:Passive(u)
 if not self:Current(u)or u.type~=Obj_AI_Hero or u.team==myHero.team or not finite(u.buffCount)or u.buffCount%1~=0 or u.buffCount<0 or u.buffCount>128 then return nil end
 local b,expiry,why=self:Buff(u,self.profile.passive,false);if why then return nil end
 if not b then return 0 end
 if not finite(b.count)or b.count%1~=0 or b.count<1 or b.count>5 then return nil end;return b.count,expiry
end
-- Seconds our own Crash Down knock-up still holds `u`, or nil (owned, named buff with an expiry).
function RellChampion:KnockLeft(u)
 local name=self.profile.wKnockupBuff;if not name then return nil end
 local b,expiry=self:Buff(u,name,false);if not b or not finite(expiry)then return nil end
 local left=expiry-Game.Timer();return left>0 and left or nil
end
-- Mount Up's empowered attack is waiting and `u` is inside its extended reach: Q would only delay that attack.
function RellChampion:AttackWaiting(u)
 local name=self.profile.wAttackBuff
 return name~=nil and self:Current(u)and self:Buff(myHero,name,true)~=nil
  and GetDistance(u.pos,myHero.pos)<=myHero.range+myHero.boundingRadius+(u.boundingRadius or 0)+self.profile.wAttackRange
end
function RellChampion:Projected(u,time)
 -- An enemy we knocked up only starts moving when the knock-up ends.
 time=math.max(0,time-(self:KnockLeft(u)or 0))
 local pos=point(u.pos);local path=u.pathing
 if pos and path and(path.hasMovePath or path.isDashing)and point(path.endPos)then local speed=path.isDashing and path.dashSpeed or u.ms
  if finite(speed)and speed>0 then return pos:Extended(path.endPos,math.min(GetDistance(pos,path.endPos),time*speed))end
 end;return pos
end
function RellChampion:Damage(u,slot)
 if not self:Current(u)then return 0 end;local p=self.profile;local rank=myHero:GetSpellData(slot).level;local raw
 if slot==_Q then if not p.qBase[rank]then return 0 end;raw=p.qBase[rank]+p.qAP*myHero.ap
 elseif slot==_W then if not p.wBase[rank]then return 0 end;local mounted=self:Form()=='mounted';raw=(mounted and p.wBase[rank]or p.w2Base[rank])+(mounted and p.wAP or p.w2AP)*myHero.ap
 elseif slot==_E then if not p.ePct[rank]or not finite(u.maxHealth)then return 0 end;raw=(p.ePct[rank]+p.eAP*myHero.ap)*u.maxHealth
  if u.type~=Obj_AI_Hero then local level=myHero.levelData.lvl;local cap=p.eMonsterCap;if not finite(level)or level<1 or level>18 or not cap then return 0 end
   raw=math.min(raw,cap[1]+(cap[2]-cap[1])*(level-1)/17)end
 elseif slot==_R then if not p.rDPS[rank]then return 0 end;raw=(p.rDPS[rank]+p.rAP*myHero.ap)*p.rDuration
 else return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
function RellChampion:GetQDmg(u)return self:Damage(u,_Q)end
function RellChampion:GetRDmg(u)return self:Damage(u,_R)end
function RellChampion:QHits(aim,kind)
 local rows=self:Rows(kind or 'heroes',1000);local hits={};for _,u in ipairs(rows)do local pos=self:Projected(u,.4);local a,b=ray(myHero.pos,aim,pos)
  if a and a>=-220-(u.boundingRadius or 0)and a<=520+100+(u.boundingRadius or 0)and b<=75+(u.boundingRadius or 0)then hits[#hits+1]=u end
 end;return hits
end
function RellChampion:PredictQ(u)
 if not self:Current(u)then return nil end
 local left=self:KnockLeft(u)
 if left then
  -- W into Q: the strike takes qDelay to land. It is cast so that its stun begins as the knock-up ends, at the
  -- spot where the enemy comes down; while more of the knock-up remains than that, Q waits.
  if left>self.profile.qDelay then return nil end
  local path=u.pathing;local p=path and path.isDashing and point(path.endPos)or point(u.pos)
  return p and GetDistance(p,myHero.pos)<=self.profile.qRange and p or nil
 end
 local p=Core:Prediction(self.QSpell);p:GetPrediction(u,myHero);return p:CanHit(2)and point(p.CastPosition)or nil
end
function RellChampion:QSafe(aim)
 if not point(aim)or GetDistance(aim,myHero.pos)<1 or type(Game.isWall)~='function'then return false end
 local landing=myHero.pos:Extended(aim,self.profile.qStep)
 for i=1,3 do local ok,wall=pcall(Game.isWall,myHero.pos:Extended(landing,self.profile.qStep*i/3));if not ok or wall~=false then return false end end
 return not IsUnderTurret2(landing)or IsUnderTurret2(myHero.pos)
end
function RellChampion:CastQ(u,context,permission,commitPermission)
 if not self:Ready(_Q)or not self:Current(u)or GetDistance(u.pos,myHero.pos)>600 or not permission()then return false end
 local aim=self:PredictQ(u);if not aim or not self:QSafe(aim)then return false end;local identity,handle=id(u),u.handle
 local function fresh()
  if not self:Current(u)or id(u)~=identity or u.handle~=handle or not permission()then return nil end
  local p=self:PredictQ(u);if not p or not self:QSafe(p)then return nil end;local a,b=ray(myHero.pos,p,self:Projected(u,.4))
  if not a or a< -220-(u.boundingRadius or 0)or a>620+(u.boundingRadius or 0)or b>75+(u.boundingRadius or 0)then return nil end
  return {position=p}
 end
 return Core:Cast(HK_Q,aim,{intentTarget=u,range=600,context=context,prevalidateWorldCast=true,deferAttackWindup=true,resolve=fresh,
  commitGuard=function()return Core:Current()and(commitPermission or permission)()end,
  validate=function(_,resolved)
   if not self:Ready(_Q)or not self:Current(u)or id(u)~=identity or u.handle~=handle or not permission()or not resolved or not self:QSafe(resolved.position)then return false end
   local a,b=ray(myHero.pos,resolved.position,self:Projected(u,.4))
   return a and a>=-220-(u.boundingRadius or 0)and a<=620+(u.boundingRadius or 0)and b<=75+(u.boundingRadius or 0)
  end})
end
-- Turret dive (rerank combo, zgRell): only in Combo with Misc.TurretCrash on; walls and the enemy limit still hold.
-- SafeCrash runs again in the dispatch validator, so a released Combo or a switch turned off refuses the send.
function RellChampion:TurretCrashAllowed()return Menu.Misc.TurretCrash:Value()==true and GetMode()=='Combo'end
function RellChampion:SafeCrash(p)
 p=point(p);if not p or not Core:Current()or type(Game.isWall)~='function'or GetDistance(p,myHero.pos)>self.profile.wRange+1 then return false end
 local distance=GetDistance(p,myHero.pos);local last=distance>1 and myHero.pos:Extended(p,distance+320)or point(p)
 local dive=self:TurretCrashAllowed()
 for i=0,8 do local sample=p:Extended(last,GetDistance(p,last)*i/8)
  local ok,wall=pcall(Game.isWall,sample);if not ok or wall~=false or not dive and IsUnderTurret2(sample)or GetEnemyCount(450,sample)>Menu.Misc.Enemies:Value()then return false end
 end;return true
end
function RellChampion:CrashPoint(u)
 local aim=u and self:Projected(u,.625)or point(mousePos);if not aim then return nil end
 -- The leap lands between the profile's minimum and maximum reach; a nearer or farther aim is clamped onto that span.
 local distance=GetDistance(aim,myHero.pos);if distance<1 then return nil end
 local low,high=self.profile.wMinRange,self.profile.wRange
 local p=(distance>high or distance<low)and point(myHero.pos:Extended(aim,math.max(low,math.min(high,distance))))or point(aim)
 return self:SafeCrash(p)and p or nil
end
function RellChampion:CastW(u,context,permission)
 if self.wObservation or not self:Ready(_W)or not permission()then return false end
 local form=self:Form();local identity,handle=id(u),u and u.handle
 if form=='dismounted'then
  if Menu.Misc.PreserveShield:Value()and self:Buff(myHero,self.profile.shield,true)and GetEnemyCount(350,myHero.pos)>0 and GetMode()~='Flee'and not Menu.Misc.WAssist:Value()then return false end
  local function valid()return self:Ready(_W)and self:Form()==form and permission()and(not u or self:Current(u)and id(u)==identity and u.handle==handle)end
  local ok=Core:Cast(HK_W,nil,{context=context,deferAttackWindup=true,validate=valid,observe=function(q)
   return self:Form()=='mounted'and Core:NativeCast(q,self.profile.w2)~=nil
  end})
  if ok and Core.lastIntent then self:TrackW(Core.lastIntent,form,nil,u)end;return ok
 end
 local p=self:CrashPoint(u);if not p then return false end
 local function valid(position)return self:Ready(_W)and self:Form()==form and permission()and self:SafeCrash(position)
  and(not u or self:Current(u)and id(u)==identity and u.handle==handle and GetDistance(self:Projected(u,.625),position)<=180+(u.boundingRadius or 0))end
 if not valid(p)then return false end
 -- With an intent target the shared policy measures this range to the enemy as well: leap plus slide and area.
 local ok=Core:Cast(HK_W,p,{intentTarget=u,range=self.profile.wRange+(u and self.profile.wSlide+self.profile.wRadius or 5),context=context,prevalidateWorldCast=true,deferAttackWindup=true,
  resolve=function()local aim=self:CrashPoint(u);return aim and valid(aim)and{position=aim}or nil end,
  commitGuard=function()return Core:Current()and permission()end,validate=function(_,resolved)return resolved and valid(resolved.position)end,
  observe=function(q)
   return Core:NativeCast(q,self.profile.w)~=nil
    and(self:Form()=='dismounted'or myHero.pathing and myHero.pathing.isDashing==true)
  end})
 if ok and Core.lastIntent then self:TrackW(Core.lastIntent,form,p,u)end;return ok
end
function RellChampion:TrackW(q,form,p,u)
 local row={q=q,form=form,point=p,origin=point(myHero.pos),target=u,targetID=id(u),handle=u and u.handle,expires=Game.Timer()+2};self.wObservation=row
 Core:AfterCast(HK_W,function()if self.wObservation==row then row.castObserved=true end end)
end
function RellChampion:MaintainW()
 local row=self.wObservation;if not row then return end;local result=Core.adapter:Poll(row.q.id)
 if result and result.state=='cancelled_before_send'or not Core.adapter:ContextValid(row.q)then self.wObservation=nil;return end
 local path=myHero.pathing
 -- The form change after the send is W's outcome. When the native cast that
 -- the observer asks for was not shown, the settled new form still ends the
 -- lock instead of leaving the next W refused until the 2 s expiry.
 if not row.castObserved then local form=self:Form()
  if Game.Timer()>row.expires or result and result.sentAt and form and form~=row.form and not(path and path.isDashing)then self.wObservation=nil end
  return
 end
 if row.form=='mounted'and path and path.isDashing and point(path.endPos)then row.nativeLanding=point(path.endPos);row.dashing=true end
 if row.form=='mounted'and self:Form()=='dismounted'and(not path or not path.isDashing)and self:Buff(myHero,self.profile.dismounted,true)then
  row.landed=GetDistance(myHero.pos,row.origin)<=self.profile.wDisplayRange+self.profile.wSlide+100;row.landing=point(myHero.pos);self.wObservation=nil
 elseif row.form=='dismounted'and self:Form()=='mounted'then self.wObservation=nil
 elseif Game.Timer()>row.expires then self.wObservation=nil end
end
function RellChampion:AllyMenus()
 local rows=self:Rows('ally',2000);rows[#rows+1]=myHero
 for _,u in ipairs(rows)do local key=StableUnitMenuKey(self,'a',u);if not self.allyMenus[key]then
  Menu.Allies:MenuElement({type=MENU,id=key,name=u==myHero and 'Rell (self)'or u.charName})
  Menu.Allies[key]:MenuElement({id='Enabled',name='Use E with this ally',value=true})
  Menu.Allies[key]:MenuElement({id='Priority',name='Priority (higher wins)',value=u==myHero and 1 or 3,min=1,max=5,step=1});self.allyMenus[key]=true
 end end
end
function RellChampion:AllyAllowed(u)
 if not self:Current(u)or u.team~=myHero.team or u.type~=Obj_AI_Hero or GetDistance(u.pos,myHero.pos)>1200 then return false end
 local node=Menu.Allies[StableUnitMenuKey(self,'a',u)];return node and node.Enabled:Value(),node
end
function RellChampion:AllyChoice()
 self:AllyMenus();local selected=_G.SDK.TargetSelector.Selected;if self:AllyAllowed(selected)then return selected end
 local rows=self:Rows('ally',1200);rows[#rows+1]=myHero;local best,score
 for _,u in ipairs(rows)do local yes,node=self:AllyAllowed(u);if yes then local value=node.Priority:Value()*10
  if finite(u.maxHealth)and u.maxHealth>0 then value=value+(1-u.health/u.maxHealth)end
  if not score or value>score then best,score=u,value end
 end end;return best
end
function RellChampion:EFeasible(u,approach)
 if not self:Current(u)then return false end
 local distance=GetDistance(u.pos,myHero.pos);local cost=myHero:GetSpellData(_E).mana
 if self:Ready(_Q)and distance<=600 and myHero.mana>=cost+myHero:GetSpellData(_Q).mana then return true end
 if _G.SDK.Orbwalker:CanAttack()and distance<=myHero.range+myHero.boundingRadius+(u.boundingRadius or 0)then return true end
 if approach==true and u.type==Obj_AI_Hero and distance<=900 and self:Ready(_W)and self:Form()=='mounted'
  and myHero.mana>=cost+myHero:GetSpellData(_W).mana then
  local p=self:CrashPoint(u);return p~=nil and GetDistance(self:Projected(u,.625),p)<=180+(u.boundingRadius or 0)
 end;return false
end
function RellChampion:CastE(ally,context,permission,target,approach)
 if not self:Ready(_E)or self.eObservation or not self:AllyAllowed(ally)or not permission()or self:Buff(myHero,self.profile.eEmpower,true)
  or target and not self:EFeasible(target,approach)then return false end
 local identity,handle=id(ally),ally.handle;local targetID,targetHandle=id(target),target and target.handle
 local function valid()return self:Ready(_E)and self:AllyAllowed(ally)and id(ally)==identity and ally.handle==handle and permission()
  and not self:Buff(myHero,self.profile.eEmpower,true)and(not target or self:Current(target)and id(target)==targetID and target.handle==targetHandle and self:EFeasible(target,approach))end
 local ok=Core:Cast(HK_E,ally,{range=1200,context=context,deferAttackWindup=true,validate=valid,
  observe=function(q)local cast=Core:NativeCast(q,self.profile.e)
   return cast~=nil
    and(cast.target==ally.networkID or cast.target==ally.handle or cast.target==nil and ally==myHero)
  end})
 if ok and Core.lastIntent then local q=Core.lastIntent;local row={q=q,ally=ally,allyID=identity,handle=handle,expires=Game.Timer()+2};self.eObservation=row
  Core:AfterCast(HK_E,function()if self.eObservation==row then row.castObserved=true end end)
 end;return ok
end
function RellChampion:MaintainE()
 local row=self.eObservation;if not row then return end;local result=Core.adapter:Poll(row.q.id)
 if result and result.state=='cancelled_before_send'or not Core.adapter:ContextValid(row.q)or row.castObserved or Game.Timer()>row.expires then self.eObservation=nil end
end
function RellChampion:RCount()
 local count=0;for _,u in ipairs(self:Rows('heroes',600))do
  if GetDistance(myHero.pos,self:Projected(u,.1))<=425+(u.boundingRadius or 0)then count=count+1 end
 end;return count
end
-- Rell-1: never during Rell's own dash (crash leap/slide): the pull would start from a point she is leaving. The
-- count is made again from where she stands once the dash has ended.
function RellChampion:Dashing()local path=myHero.pathing;return path~=nil and path.isDashing==true end
function RellChampion:CastR(context,permission,manual)
 if not self:Ready(_R)or self.storm or self.rObservation or self:Dashing()or not permission()or self:RCount()<(manual and 1 or Menu.Combo.RCount:Value())then return false end
 local function valid()return self:Ready(_R)and not self.storm and not self:Dashing()and permission()and self:RCount()>=(manual and 1 or Menu.Combo.RCount:Value())end
 local ok=Core:Cast(HK_R,nil,{context=context,validate=valid,observe=function(q)
  return Core:NativeCast(q,self.profile.r)~=nil
 end})
 if ok and Core.lastIntent then local q=Core.lastIntent;local row={q=q,expires=Game.Timer()+3};self.rObservation=row
  Core:AfterCast(HK_R,function()if self.rObservation==row then row.observedAt=Game.Timer();self:ProbePull();self:MaintainStorm()end end)
 end;return ok
end
function RellChampion:MaintainStorm()
 if self.storm and(Game.Timer()>=self.storm.expires or not self:Buff(myHero,self.profile.storm,true))then self.storm=nil end
 local row=self.rObservation;if not row then return end;local result=Core.adapter:Poll(row.q.id)
 if result and result.state=='cancelled_before_send'or Game.Timer()>row.expires then self.rObservation=nil;return end
 if row.observedAt then local b,expires=self:Buff(myHero,self.profile.storm,true)
  if b and finite(expires)and expires>Game.Timer()then self.storm={expires=expires,cast=row.observedAt};self.rObservation=nil end
 end
end
function RellChampion:PassiveTarget()
 local selected=_G.SDK.TargetSelector.Selected;if self:Current(selected)and selected.team~=myHero.team then return selected end
 local best,count;for _,u in ipairs(self:Rows('heroes',500))do local stacks=self:Passive(u)
  if stacks and GetDistance(u.pos,myHero.pos)<=myHero.range+myHero.boundingRadius+(u.boundingRadius or 0)and(not count or stacks<count)then best,count=u,stacks end
 end;return best,count
end
function RellChampion:Spread()
 if not Menu.Combo.Passive:Value()or not _G.SDK.Orbwalker:CanAttack()then return false end
 local u,count=self:PassiveTarget();if not u or count==nil or count>=5 then return false end
 local identity,handle=id(u),u.handle;local previous=self.attackWitness
 local ok=Core:Attack(u,{owner='PassiveAttack',context=Core:ModeContext('Combo'),priority='background',ttl=120,
  validate=function()local n=self:Passive(u);return Menu.Combo.Passive:Value()and self:Current(u)and id(u)==identity and u.handle==handle and n~=nil and n<5 and self:PassiveTarget()==u end,
  observe=function(q)local witness=Core:AttackWitness(previous,u)
   if witness and witness~=previous and finite(witness.startTime)and finite(q.sentGameTime)and witness.startTime>=q.sentGameTime then self.attackWitness=witness;return true end
  end});return ok
end
-- Rell-4: in a fight, Mount Up only when the empowered attack (3.5 s window, +100 range, 0.2 s cast) can reach the
-- target: the gap beyond that reach is closable at ~1.15x speed (Mount Up's decaying 30%) within 3.5 - 0.4 s, or the
-- target walks away and no shield needs keeping (a chase). rell_w_cooldown records whether the two W forms share a
-- cooldown before Mount Up is ever used only to bring Crash Down back. A target walking away is closed on at the
-- speed difference only.
function RellChampion:MountUseful(u)
 if not self:Current(u)then return false end
 local p=self.profile;local d=GetDistance(u.pos,myHero.pos)
 local reach=(myHero.range or 175)+(myHero.boundingRadius or 65)+(u.boundingRadius or 65)+p.wAttackRange
 local ms=finite(myHero.ms)and myHero.ms>0 and myHero.ms or 330
 local path=u.pathing
 local away=path~=nil and path.hasMovePath==true and point(path.endPos)~=nil and GetDistance(path.endPos,myHero.pos)>d
 -- A target walking away is closed on only at the speed difference.
 local closing=1.15*ms-(away and finite(u.ms)and u.ms or 0)
 if closing>0 and d-reach<=closing*(p.wAttackWindow-.4)then return true end
 return away and not self:Buff(myHero,p.shield,true)
end
function RellChampion:Combat(mode)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return end;local context=Core:ModeContext(mode);local u=self:Target(900);if not u then return end
 local function castQ()
  return node.Q:Value()and self:Ready(_Q)and not self:AttackWaiting(u)
   and self:CastQ(u,context,function()return node.Q:Value()and Core.manaAbove(node.Mana:Value())and not self:AttackWaiting(u)end,
    function()return node.Q:Value()and Core.manaAbove(node.Mana:Value())end)
 end
 local function castW()
  if not node.EngageW:Value()or not self:Ready(_W)or self:Form()=='dismounted'and not self:MountUseful(u)then return false end
  return self:CastW(u,context,function()return node.EngageW:Value()and Core.manaAbove(node.Mana:Value())and(self:Form()~='dismounted'or self:MountUseful(u))end)
 end
 -- Mounted, the crash comes first: its knock-up turns the narrow, slow Q into a certain hit. An enemy that is
 -- already held (our knock-up or any hard control) gets Q at once.
 local held=self:KnockLeft(u)~=nil or(GetHardCCDuration(u)or 0)>0
 if not held and self:Form()=='mounted'and castW()then return true end
 if castQ()then return true end
 if castW()then return true end
 if node.E:Value()and self:Ready(_E)and self:EFeasible(u,node.EngageE:Value())then local ally=self:AllyChoice()
  local approach=node.EngageE:Value()
  if ally and self:CastE(ally,context,function()return node.E:Value()and Core.manaAbove(node.Mana:Value())and(not approach or node.EngageE:Value())end,u,approach)then return true end
 end
 if mode=='Combo'then return self:Spread()end
end
function RellChampion:Combo()return self:Combat('Combo')end
function RellChampion:Harass()return self:Combat('Harass')end
function RellChampion:Farm(kind)
 local node=kind=='lane'and Menu.Clear.LaneClear or Menu.Clear.JungleClear
 if not Menu.Clear.SpellFarm:Value()or not Core.manaAbove(node.Mana:Value())then return end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end);local rows=self:Rows(kind,600);local u=rows[1];if not u then return end
 local function permission()return Menu.Clear.SpellFarm:Value()and Core.manaAbove(node.Mana:Value())end
 if node.Q:Value()and self:Ready(_Q)then for i=1,math.min(#rows,8)do local target=rows[i];local aim=self:PredictQ(target)
  if aim and(kind=='jungle'or #self:QHits(aim,kind)>=Menu.Clear.LaneClear.Count:Value())then
   return self:CastQ(target,context,function()local p=self:PredictQ(target);return node.Q:Value()and permission()and p and(kind=='jungle'or #self:QHits(p,kind)>=Menu.Clear.LaneClear.Count:Value())end,
    function()return node.Q:Value()and permission()end)
  end
 end end
 if node.W:Value()and self:Ready(_W)and self:CastW(u,context,function()return node.W:Value()and permission()end)then return true end
 if node.E:Value()and self:Ready(_E)then self:AllyMenus();return self:CastE(myHero,context,function()return node.E:Value()and permission()end,u,false)end
end
function RellChampion:LaneClear()return self:Farm('lane')end
function RellChampion:JungleClear()return self:Farm('jungle')end
function RellChampion:Rescue(u)
 if not self:Current(u)or u.team==300 or GetDistance(u.pos,myHero.pos)>600 or not Core:Rescue(u,.4,self:Damage(u,_Q),spellOnly)then return false end
 -- A ready attack in reach always takes the last hit.
 if _G.SDK.Orbwalker:CanAttack()and GetDistance(u.pos,myHero.pos)<=myHero.range+myHero.boundingRadius+(u.boundingRadius or 0)then return false end
 local aim=self:PredictQ(u);if not aim then return false end
 local hits=self:QHits(aim,'lane');return #hits==1 and id(hits[1])==id(u)
end
function RellChampion:LastHit()
 if not Menu.LastHit.Q:Value()or not self:Ready(_Q)or not Core.manaAbove(Menu.LastHit.Mana:Value())then return end
 for _,u in ipairs(self:Rows('lane',600))do if self:Rescue(u)then return self:CastQ(u,Core:RescueContext(),function()return Menu.LastHit.Q:Value()and Core.manaAbove(Menu.LastHit.Mana:Value())and self:Rescue(u)end,
  function()return Menu.LastHit.Q:Value()and Core.manaAbove(Menu.LastHit.Mana:Value())end)end end
end
function RellChampion:Flee()
 local context=Core:ModeContext('Flee')
 if Menu.Misc.FleeW:Value()and self:Form()=='dismounted'and self:Ready(_W)and self:CastW(nil,context,function()return Menu.Misc.FleeW:Value()end)then return true end
 if Menu.Misc.FleeE:Value()and self:Ready(_E)then local ally=self:FleeAlly();if ally and self:CastE(ally,context,function()return Menu.Misc.FleeE:Value()end)then return true end end
 local u=self:Target(600);if u and Menu.Misc.FleeQ:Value()and self:Ready(_Q)then return self:CastQ(u,context,function()return Menu.Misc.FleeQ:Value()end)end
end
-- Rell-2: Full Tilt is 30% instead of 15% while Rell faces the empowered ally (wiki V26.07). Fleeing, the selected
-- ally still wins; otherwise an allowed ally ahead of Rell toward the player's aim (smallest angle, then priority),
-- else Rell herself.
function RellChampion:PlayerAim()
 local api=_G.SDK.Actions;if api and type(api.GetPlayerPosition)=='function'then local p=point(api:GetPlayerPosition());if p then return p end end
 return point(mousePos)
end
function RellChampion:FleeAlly()
 self:AllyMenus();local selected=_G.SDK.TargetSelector.Selected;if self:AllyAllowed(selected)then return selected end
 local aim=self:PlayerAim();local fallback=self:AllyAllowed(myHero)and myHero or nil
 if not aim or GetDistance(aim,myHero.pos)<50 then return fallback or self:AllyChoice()end
 local ax,az=aim.x-myHero.pos.x,aim.z-myHero.pos.z;local al=math.sqrt(ax*ax+az*az)
 local best,bestCos,bestPriority
 for _,u in ipairs(self:Rows('ally',1200))do local yes,node=self:AllyAllowed(u)
  if yes and u~=myHero then local x,z=u.pos.x-myHero.pos.x,u.pos.z-myHero.pos.z;local l=math.sqrt(x*x+z*z)
   if l>1 then local cos=(x*ax+z*az)/(l*al);local priority=node.Priority:Value()
    if cos>0 and(not best or cos>bestCos+.05 or math.abs(cos-bestCos)<=.05 and priority>bestPriority)then best,bestCos,bestPriority=u,cos,priority end
   end
  end
 end
 return best or fallback or self:AllyChoice()
end
-- Rell-3: Mount Up again outside fights (no visible enemy champion within 1500, no Combo/Harass/Flee) for the mounted
-- movement speed and a W cycle that is ready when the next fight starts. Background priority, no mode key.
function RellChampion:Remount(mode)
 if mode=='Combo'or mode=='Harass'or mode=='Flee'or self.wObservation or self:Form()~='dismounted'or not self:Ready(_W)
  or #self:Rows('heroes',1500)>0 then return false end
 return self:CastW(nil,{priority='background'},function()
  local m=GetMode();return m~='Combo'and m~='Harass'and m~='Flee'and #self:Rows('heroes',1500)==0 end)
end
-- Rell-6: Q on an enemy champion it kills (plus the Full Tilt explosion while Rell holds the empowerment), without a
-- mode key; the kill is rechecked at dispatch through the shared kill rule.
function RellChampion:QKills(u)
 if not self:Current(u)or u.type~=Obj_AI_Hero or u.team==myHero.team or GetDistance(u.pos,myHero.pos)>self.profile.qRange then return false end
 local damage=self:Damage(u,_Q)
 if self:Buff(myHero,self.profile.eEmpower,true)then damage=damage+self:Damage(u,_E)end
 return Core:Lethal(u,self.profile.qDelay,damage,{kind='magical'})==true
end
function RellChampion:FinishQ()
 if not self:Ready(_Q)then return false end
 for _,u in ipairs(self:Rows('heroes',self.profile.qRange))do
  if self:QKills(u)and self:CastQ(u,{priority='interactive'},function()return self:QKills(u)end)then return true end
 end
 return false
end
-- Measurement traces (dev recorder only). rell_r_pull (Rell-5): enemy distances at the observed R cast and 0.3 s
-- later (425 asset vs 450 wiki initial pull). rell_w_cooldown (Rell-4): the W cooldown right after a form change.
function RellChampion:ProbePull()
 if not Core.logger then return end
 local rows={};for _,u in ipairs(self:Rows('heroes',600))do if #rows<5 then rows[#rows+1]={unit=u,handle=u.handle,distance=GetDistance(u.pos,myHero.pos)}end end
 if #rows>0 then self.pullProbe={at=Game.Timer(),rows=rows}end
end
function RellChampion:TickProbes()
 local probe=self.pullProbe
 if probe and Game.Timer()-probe.at>=.3 then local out={}
  for _,row in ipairs(probe.rows)do local u=row.unit
   if u.handle==row.handle and point(u.pos)then out[#out+1]={before=math.floor(row.distance),after=math.floor(GetDistance(u.pos,myHero.pos))}end
  end
  Core:Trace('rell_r_pull',{rows=out,initial=self.profile.rInitial});self.pullProbe=nil
 end
 if Core.logger then local form=self:Form()
  if form and self.lastForm and form~=self.lastForm then local d=myHero:GetSpellData(_W);Core:Trace('rell_w_cooldown',{from=self.lastForm,to=form,cd=d and d.currentCd})end
  self.lastForm=form
 end
end
-- Q without a mode key on an enemy dashing at Rell (landing within 350) or holding an interruptible channel
-- that outlasts the strike.
function RellChampion:ReactionReason(u)
 if not Menu.Misc.AntiDashQ:Value()or not self:Current(u)then return nil end
 if Core:ApproachingDash(u,myHero.pos,350)then return 'dash'end
 if Core:CanInterrupt(u,self.profile.qDelay)then return 'interrupt'end
end
function RellChampion:Reactions()
 if not Menu.Misc.AntiDashQ:Value()or not self:Ready(_Q)then return false end
 for _,u in ipairs(self:Rows('heroes',self.profile.qRange))do
  if self:ReactionReason(u)and self:CastQ(u,{priority='interactive'},function()return self:ReactionReason(u)~=nil end,
   function()return Menu.Misc.AntiDashQ:Value()end)then return true end
 end
 return false
end
function RellChampion:OnPostAttack(args)
 if not Core:InputAvailable()then return end;local witness=Core:AttackWitness(self.attackWitness,args and args.Target)
 if witness and witness~=self.attackWitness then self.attackWitness=witness end
end
function RellChampion:Assist()
 if Menu.Misc.RAssist:Value()then if self:CastR({held=function()return Menu.Misc.RAssist:Value()end,priority='interactive'},function()return Menu.Misc.RAssist:Value()end,true)then return true end
 elseif GetMode()=='Combo'and Menu.Combo.R:Value()and Core.manaAbove(Menu.Combo.Mana:Value())then
  if self:CastR(Core:ModeContext('Combo'),function()return Menu.Combo.R:Value()and Core.manaAbove(Menu.Combo.Mana:Value())end,false)then return true end
 end
 if Menu.Misc.WAssist:Value()then return self:CastW(nil,{held=function()return Menu.Misc.WAssist:Value()end,priority='interactive'},function()return Menu.Misc.WAssist:Value()end)end
 if Menu.Misc.EAssist:Value()then local ally=self:AllyChoice();return ally and self:CastE(ally,{held=function()return Menu.Misc.EAssist:Value()end,priority='interactive'},function()return Menu.Misc.EAssist:Value()end)end
end
function RellChampion:Tick()
 if not Core:InputAvailable()or ShouldWait()then self.preview=nil;return end
 self:MaintainW();self:MaintainE();self:MaintainStorm()
 self:TickProbes()
 if IsCasting()then return end;if self:Assist()then return end;if self:Reactions()then return end;if self:FinishQ()then return end
 local mode=GetMode();if self:Remount(mode)then return end
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')then self:LaneClear()end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and Menu.Draw.Preview:Value()and(not self.nextPreview or self.nextPreview<Game.Timer())then self:PreparePreview()end
end
function RellChampion:PreparePreview()
 local form=self:Form()
 -- Rell-8: the form decides the crash circle; while the W bind is held the cursor crash point is prepared here.
 local crash=form=='mounted'and Menu.Misc.WAssist:Value()and self:CrashPoint(nil)or nil
 -- No form/passive/R text: the game shows them. Kept for a second so a late preparation never blinks it.
 self.preview={expires=Game.Timer()+1,mounted=form=='mounted',crash=crash};self.nextPreview=Game.Timer()+.15
end
function RellChampion:Draw()
 if myHero.dead then return end;local p=self.preview;local fresh=p and p.expires>=Game.Timer()
 if Menu.Draw.Ranges:Value()then
  if IsReady(_Q)then Draw.Circle(myHero.pos,600,1,Draw.Color(255,160,200,255))end
  if IsReady(_R)then Draw.Circle(myHero.pos,425,1,Draw.Color(255,255,180,100))end
  if IsReady(_E)then Draw.Circle(myHero.pos,self.profile.eRange,1,Draw.Color(255,120,255,160))end
  if fresh and p.mounted and IsReady(_W)then Draw.Circle(myHero.pos,self.profile.wRange,1,Draw.Color(255,255,120,120))end
 end
 if Menu.Draw.Preview:Value()and fresh and p.crash and Menu.Misc.WAssist:Value()then Draw.Circle(p.crash,self.profile.wRadius,1,Draw.Color(255,255,120,120))end
end
function RellChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Rell: native forms','Rell: Full Tilt and support'},function(page)
  return {title=page==1 and 'Mount and control'or 'Current Full Tilt',cards=page==1 and {
   {'CONTROL','Q stuns and breaks shields. W uses native Dismount/MountUp stages; contradictory form evidence blocks W. Hold U for a safe cursor W. Mounted, Combo crashes first and Q follows so that its stun starts as the knock-up ends. Q waits while the Mount Up attack is ready and the enemy is inside its reach, and it stuns enemies that dash at you or channel without a mode key.'},
   {'ENGAGE','Combo crashes in with W within the enemy limit and casts R on its enemy count, never during her own dash. Dismounted, Combo mounts up only when the empowered attack can still reach the target. Q finishes an enemy it kills without a mode key, and Rell mounts up again when no enemy is near. Hold T for local Magnet Storm. Its initial pull is 425; continued gravity is 375 and is not a guaranteed stun.'},
   {'PASSIVE','Only your own current per-target passive stacks guide optional attacks. Selected targets win; urgent Q/W/E control is evaluated first.'}}or {
   {'FULL TILT','Current E accelerates you and an allowed ally, empowering the next attack/Q. Hold N for prioritized ally/self; ally priorities preserve player selection. Fleeing, E picks an ally ahead of you (faster while you face it), else yourself.'},
   {'FARM','Ability farming is one toggle and starts off. Lane/Jungle binds stay separate. LastHit Q rescues isolated CS using confirmed incoming damage.'},
   {'EVIDENCE','Native casts, form transitions, dash landing and effects are different observations. Refused casts do not change forms or grant passive/shields.'}},
   note='Normal-only candidate. W slide/shield timing does not yet certify a public Evade forecast for Crash Down; Mount Up is offered to Evade as a speed burst. No old E tether-stun is used.'}
 end)
end
Core:StandardPolicy(RellChampion,{damageTypes={Q='magical',W='magical',E='magical',R='magical'},channel=false})
RellChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={}
local normalSupported={["Rell"]=true}

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
