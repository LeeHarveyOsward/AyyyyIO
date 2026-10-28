return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Jhin"]=function()return _G.OrbamaFamily:Require("e6c917010889500cd30be7e3fe1bcfd9f4ddc8802783a289cc93be1a9284c51e")()end
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
if champion=="Jhin" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Jhin',profiles={normal=true,classic=false},
 Create=function(context)
-- Independent Normal-only implementation. No Classic kit is inferred.
local profiles=ChampionProfiles('Jhin')
local finite,id,point=Core.finite,Core.id,Core.point
local spellOnly={attack=false} -- Core:Rescue: the attack is weighed here, by the rule this champion's regressions pin
local function ray(origin,aim,p)
 local dx,dz=aim.x-origin.x,aim.z-origin.z;local length=math.sqrt(dx*dx+dz*dz);if length<1 then return nil end
 dx,dz=dx/length,dz/length;local x,z=p.x-origin.x,p.z-origin.z;return x*dx+z*dz,math.abs(x*dz-z*dx),dx,dz
end
local function cleanup(self)
 self.preview=nil;self.channel=nil;self.rStart=nil;self.eObservation=nil;self.attackWitness=nil;self.traps={}
 self.rGesture=nil;_G.SDK.Orbwalker:SetAttack(true);_G.SDK.Orbwalker:SetMovement(true);Core:ReleaseAttackPreference('Jhin4th')
end
local JhinChampion=class("JhinChampion")
function JhinChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.traps={};self:LoadMenu()
 self.WSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.75,Radius=40,Range=2500,Speed=5000,Collision=false}
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=80,Range=3500,Speed=5000,Collision=false}
 Core:RegisterCleanup('Jhin',function()cleanup(self)end)
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 local ok,why=Core:RegisterPreparation('Jhin.preview',{intervalMs=150,maxDelayMs=450,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.preparation=ok;self.previewFallback=not ok and why=='unsupported'
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
end
function JhinChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Jhin'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q (also bounced off minions)',value=true})
  Menu[mode]:MenuElement({id='W',name='Use W on marked targets (roots them)',value=true})
  Menu[mode]:MenuElement({id='LongW',name='Also W targets beyond 1200 range',value=true,menu=false})
  Menu[mode]:MenuElement({id='E',name='Use E under or ahead of the target',value=true})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 15,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R when it can kill a distant target',value=true})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=kind,name=kind=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[kind]:MenuElement({id='Q',name='Use Q',value=true})
  Menu.Clear[kind]:MenuElement({id='W',name='Use W while reloading',value=true})
  Menu.Clear[kind]:MenuElement({id='E',name='Use E while reloading',value=true})
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=40,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions Q must hit',value=3,min=1,max=4,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q (W on cannons) when an attack would miss',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=40,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R (all shots) at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='WAssist',name='Cast W at the selected target',key=string.byte('U')})
 Menu.Misc:MenuElement({id='KillW',name='Finish enemies with W or Q without a mode key',value=true})
 Menu.Misc:MenuElement({id='BounceQ',name='Bounce Q off a dying minion onto a champion',value=true,menu=false})
 Menu.Misc:MenuElement({id='Reserve',name='Trap charges to keep in reserve',value=1,min=0,max=2,step=1,menu=false})
 Menu.Misc:MenuElement({id='Fourth',name='Attack with the 4th shot before casting Q',value=true,menu=false})
 Menu.Misc:MenuElement({id='FleeW',name='Flee: W marked enemies (roots them)',value=true})
 Menu.Misc:MenuElement({id='FleeE',name='Flee: E behind you and under immobilised enemies',value=true})
 Menu.Misc:MenuElement({id='AutoE',name='Place E under immobile or arriving enemies',value=true})
 Menu.Misc:MenuElement({id='AwayE',name='Place E ahead of enemies walking away',value=true})
 Menu.Misc:MenuElement({id='Gap',name='Root or trap enemies who dash onto you',value=true})
 Menu.Misc:MenuElement({id='RSafe',name='Only start R with no enemy within',value=700,min=300,max=1500,step=50,menu=false})
 Menu.Misc:MenuElement({id='RAutoAim',name='Aim R shots when you start R yourself',value=true})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Preview',name='Mark enemies R kills (also on the minimap)',value=true})
 Menu.Draw:MenuElement({id='RCone',name='R cone while channelling',value=true})
end
function JhinChampion:Mana(node)return Core.manaAbove(node:Value())end
function JhinChampion:Ready(slot,shot)
 local s=myHero:GetSpellData(slot);local letter=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot]
 return s and s.name==(shot and self.profile.rShot or self.profile[letter])and finite(s.level)and s.level>=1 and s.level<= (slot==_R and 3 or 5)
  and finite(s.mana)and s.mana>=0 and s.mana<=myHero.mana and IsReady(slot)
end
function JhinChampion:Rows(kind,range)return Core:Rows(kind=='heroes'and 'hero'or kind,range)end
function JhinChampion:Current(u)return u~=nil and point(u.pos)~=nil and Core:CurrentUnit(u)end
function JhinChampion:Target(range)
 local u=_G.SDK.TargetSelector.Selected;if self:Current(u)and GetDistance(u.pos,myHero.pos)<=range then return u end
 u=GetTarget(range);return self:Current(u)and u or nil
end
function JhinChampion:Buff(u,name)local b=Core:OwnBuff(u,name,true);return b,b and Core.buffExpiry(b)end
function JhinChampion:Ammo()
 local n=myHero.hudAmmo;local ammo=finite(n)and n%1==0 and n>=0 and n<=4 and n or nil
 local reload=self:Buff(myHero,self.profile.reload)
 local cast=myHero.activeSpell
 local observed=reload~=nil or cast and cast.valid and cast.isStopped~=true and cast.name==self.profile.reload
 return ammo,observed==true
end
function JhinChampion:Damage(u,slot,shot)
 if not self:Current(u)then return 0 end;local p=self.profile;local level=myHero:GetSpellData(slot).level;local raw
 if slot==_Q then if not p.qBase[level]then return 0 end;raw=p.qBase[level]+p.qAD[level]*myHero.totalDamage+p.qAP*myHero.ap
 elseif slot==_W then if not p.wBase[level]then return 0 end;raw=p.wBase[level]+p.wAD*myHero.totalDamage;if u.type==Obj_AI_Minion then raw=raw*.75 end
 elseif slot==_R then if not p.rBase[level]or not finite(u.maxHealth)or u.maxHealth<=0 then return 0 end
  raw=(p.rBase[level]+p.rAD*myHero.totalDamage)*(1+p.rMissing*math.max(0,math.min(1,1-u.health/u.maxHealth)))*(shot==4 and p.rFourth or 1)
 else return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,raw)
end
function JhinChampion:GetQDmg(u)return self:Damage(u,_Q)end
function JhinChampion:GetWDmg(u)return self:Damage(u,_W)end
function JhinChampion:FourthLowerBound(u)
 local ammo=self:Ammo();if ammo~=1 or not self:Current(u)then return nil end
 local level=myHero.levelData.lvl;local execute=.15+(level>=6 and .05 or 0)+(level>=11 and .05 or 0)
 -- Omit crit amplification and item interactions from this lower bound.
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage+math.max(0,u.maxHealth-u.health)*execute)
end
function JhinChampion:QUseful(u)
 if not Menu.Misc.Fourth:Value()or u.type~=Obj_AI_Hero then return true end
 local ammo=self:Ammo();if ammo~=1 or GetDistance(u.pos,myHero.pos)>myHero.range+myHero.boundingRadius+(u.boundingRadius or 0)or not _G.SDK.Orbwalker:CanAttack()then return true end
 -- Preserve a useful attack without blocking urgent W, traps or all Q casts.
 return self:Damage(u,_Q)>=u.health+(u.shieldAD or 0)
end
function JhinChampion:Projected(u,time)
 local p=point(u.pos);local path=u.pathing
 if p and path and(path.hasMovePath or path.isDashing)and point(path.endPos)then local speed=path.isDashing and path.dashSpeed or u.ms
  if finite(speed)and speed>0 then return p:Extended(path.endPos,math.min(GetDistance(p,path.endPos),time*speed))end
 end;return p
end
function JhinChampion:QScope(first,kind)
 local rows,seen={},{};local function add(list)for _,u in ipairs(list)do if #rows<18 and not seen[id(u)]then seen[id(u)]=true;rows[#rows+1]=u end end end
 add(self:Rows(kind or 'lane',1900));if not kind then add(self:Rows('heroes',1900))end
 if first and not seen[id(first)]then rows[#rows+1]=first end
 local damages={};for _,u in ipairs(rows)do damages[id(u)]=self:Damage(u,_Q)end
 return {rows=rows,damages=damages}
end
-- Q's 550 is measured between the edges of the two units: centre to centre it reaches both gameplay radii farther.
function JhinChampion:QReach(u)
 local p=self.profile;local own,other=myHero.boundingRadius,u and u.boundingRadius
 if not p.qRangeEdge or not finite(own)or own<0 or own>200 then return p.qRange end
 return p.qRange+own+(finite(other)and other>=0 and other<=300 and other or 0)
end
function JhinChampion:QPaths(first,anchor,kind,scope)
 if not self:Current(first)or GetDistance(first.pos,myHero.pos)>self:QReach(first)then return nil end
 scope=scope or self:QScope(first,kind);local rows,damages=scope.rows,scope.damages
 if not damages[id(first)]then return nil end
 local result={paths={},work=0,minHits=4,maxScore=0,first=first};local used={[id(first)]=true}
 local function walk(u,path,time,kills,score,hit)
  if #result.paths>=48 then return end
  local damage=damages[id(u)]*(1+kills*self.profile.qAmp);local killed=u.health+(u.shieldAD or 0)<=damage;local total=kills+(killed and 1 or 0)
  score=score+(u==anchor and damage or(kind and damage or 0));hit=hit or u==anchor
  local nextRows={};local at=self:Projected(u,time)
  if #path<4 then for _,v in ipairs(rows)do result.work=result.work+1
   if not used[id(v)]then local distance=GetDistance(self:Projected(v,time+.2),at)
    if distance<=450 then nextRows[#nextRows+1]={u=v,d=distance}end
   end
  end end
  table.sort(nextRows,function(a,b)return a.d<b.d end)
  if #path>=4 or #nextRows==0 then
   local copy={};for i,v in ipairs(path)do copy[i]=id(v)end
   result.paths[#result.paths+1]={units=copy,score=score,anchor=hit,kills=total};result.minHits=math.min(result.minHits,#path);result.maxScore=math.max(result.maxScore,score)
   result.minKills=math.min(result.minKills or total,total);return
  end
  -- The game picks its next recipient. Enumerate plausible nearest candidates;
  -- do not turn a speculative bounce or kill amplifier into confirmed damage.
  for i=1,math.min(#nextRows,3)do local v=nextRows[i].u;used[id(v)]=true;path[#path+1]=v
   walk(v,path,time+.2+nextRows[i].d/600,kills+(killed and 1 or 0),score,hit);path[#path]=nil;used[id(v)]=nil
  end
 end
 walk(first,{first},.25+GetDistance(first.pos,myHero.pos)/1800,0,0,false)
 local any=false;for _,p in ipairs(result.paths)do any=any or p.anchor end;result.reachesAnchor=any;return result
end
function JhinChampion:CastQ(first,context,condition)
 if not self:Ready(_Q)or not self:Current(first)or GetDistance(first.pos,myHero.pos)>self:QReach(first)or condition and not condition()then return false end
 local identity,handle=id(first),first.handle
 return Core:Cast(HK_Q,first,{range=self:QReach(first),context=context,deferAttackWindup=true,
  validate=function()return self:Ready(_Q)and self:Current(first)and id(first)==identity and first.handle==handle
   and GetDistance(first.pos,myHero.pos)<=self:QReach(first)and(not condition or condition())end})
end
function JhinChampion:QChoice(anchor)
 if self:Current(anchor)and GetDistance(anchor.pos,myHero.pos)<=self:QReach(anchor)and self:QUseful(anchor)then return anchor end
 local best,score;local rows=self:Rows('lane',self.profile.qRange+300);local scope=self:QScope(nil,nil)
 for i=1,math.min(#rows,12)do local u=rows[i];local plan=self:QPaths(u,anchor,nil,scope)
  if plan and plan.reachesAnchor and(not score or plan.maxScore>score)then best,score=u,plan.maxScore end
 end;return best
end
function JhinChampion:Predict(u,settings)
 if not self:Current(u)then return nil end;local p=Core:Prediction(settings);p:GetPrediction(u,myHero)
 return p:CanHit(2)and point(p.CastPosition)or nil
end
function JhinChampion:RayClear(aim,u,shot)
 local p=self.profile;local origin=shot and self.channel and self.channel.origin or myHero.pos
 local delay,speed,radius=shot and p.rDelay or p.wDelay,shot and p.rSpeed or p.wSpeed,shot and p.rRadius or p.wRadius
 local at=delay+GetDistance(u.pos,origin)/speed;local target=self:Projected(u,at);local distance=GetDistance(target,origin)
 for _,v in ipairs(self:Rows('heroes',4000))do if id(v)~=id(u)then
  local along,side=ray(origin,aim,self:Projected(v,delay+GetDistance(v.pos,origin)/speed))
  if along and along>=0 and along<distance and side<=radius+(v.boundingRadius or 0)then return false,'champion_interception'end
 end end
 local wall,_,count=OrbamaPrediction:GetCollision(origin,aim,speed,delay,radius,{OrbamaPrediction.COLLISION_YASUOWALL},id(u))
 return wall~=true and(count or 0)==0
end
-- Caught Out is applied by allied damage too (wiki V26.16), and only one Jhin can mark the enemies of this team:
-- a mark of this name on an enemy is accepted when its source is Jhin, an allied champion or not filled in. A source
-- naming anyone else (an enemy) is refused. The development trace jhin_mark_source records the native fields.
function JhinChampion:MarkBuff(u)
 if not u or not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 then return nil end
 local name=self.profile.mark:lower();local now=Game.Timer();local found
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==name and finite(b.count)and b.count>0 then
   local ends=Core.buffExpiry(b)
   if finite(ends)and ends>now then
    local source=b.source;if type(source)=='table'or type(source)=='userdata'then source=id(source)end
    local ok=source==nil or source==0 or source==myHero.networkID or source==myHero.handle
    if not ok then for _,ally in ipairs(Core:DecisionUnits('GetAllyHeroes'))do if ally.networkID==source or ally.handle==source then ok=true;break end end end
    if Core.logger and not self.markTraced then self.markTraced=true;Core:Trace('jhin_mark_source',{source=tostring(source),own=source==myHero.networkID or source==myHero.handle,accepted=ok},5000)end
    if not ok then return nil end
    if not found or ends>found.ends then found={buff=b,ends=ends}end
   end
  end
 end
 return found and found.buff,found and found.ends
end
function JhinChampion:Marked(u)
 local buff,expires=self:MarkBuff(u);local impact=self.profile.wDelay+GetDistance(u.pos,myHero.pos)/self.profile.wSpeed
 return buff~=nil and expires>Game.Timer()+impact
end
function JhinChampion:CastW(u,context,permission,root)
 if not self:Ready(_W)or not self:Current(u)or GetDistance(u.pos,myHero.pos)>2500 then return false end
 local identity,handle=id(u),u.handle
 local function resolve()
  if not Core:Current()or not self:Ready(_W)or not self:Current(u)or id(u)~=identity or u.handle~=handle or not permission()or root and not self:Marked(u)then return nil end
  local p=self:Predict(u,self.WSpell);return p and self:RayClear(p,u,false)and {position=p}or nil
 end
 local r=resolve();if not r then return false end
 return Core:Cast(HK_W,r.position,{intentTarget=u,context=context,range=2500,prevalidateWorldCast=true,deferAttackWindup=true,resolve=resolve,
  commitGuard=function()return Core:Current()and permission()end,
  validate=function(_,fresh)return self:Ready(_W)and self:Current(u)and id(u)==identity and u.handle==handle and permission()and(not root or self:Marked(u))
   and fresh and self:RayClear(fresh.position,u,false)end})
end
function JhinChampion:CCRemaining(u)
 if not self:Current(u)or not finite(u.buffCount)or u.buffCount>128 then return 0 end
 local types={[5]=true,[12]=true,[25]=true,[30]=true,[35]=true};local remaining=0
 for _,b in ipairs(Core:Fresh(GetBuffs,u))do local expiry=Core.buffExpiry(b)
  if types[b.type]and finite(expiry)and b.count and b.count>0 then remaining=math.max(remaining,expiry-Game.Timer())end
 end;return remaining
end
function JhinChampion:TrapLegal(p)
 if not point(p)or GetDistance(p,myHero.pos)>750 or type(Game.isWall)~='function'or Game.isWall(p)~=false then return false end
 for _,trap in pairs(self.traps)do if IsValid(trap.object)and trap.object.handle==trap.handle and GetDistance(trap.object.pos,p)<160 then return false end end
 return true
end
function JhinChampion:CastE(p,context,permission,target,controlled)
 local spell=myHero:GetSpellData(_E)
 if not self:Ready(_E)or not finite(spell.ammo)or spell.ammo%1~=0 or spell.ammo<=Menu.Misc.Reserve:Value()or not permission()or not self:TrapLegal(p)then return false end
 local position=point(p);local identity=id(target);local handle=target and target.handle
 local function valid()
  local s=myHero:GetSpellData(_E);return self:Ready(_E)and finite(s.ammo)and s.ammo>Menu.Misc.Reserve:Value()and permission()and self:TrapLegal(position)
   and(not target or self:Current(target)and id(target)==identity and target.handle==handle
    and GetDistance(target.pos,position)<=160 and(not controlled or self:CCRemaining(target)>=.25+self.profile.eArm+GetDistance(position,myHero.pos)/1600))
 end
 if not valid()then return false end
 local ok=Core:Cast(HK_E,position,{intentTarget=target,range=750,context=context,prevalidateWorldCast=true,resolve=function()return valid()and {position=position}or nil end,
  commitGuard=function()return Core:Current()and permission()end,validate=function()return valid()end})
 if ok and Core.lastIntent then local q=Core.lastIntent;local ledger={id=q.id,point=position,request=q.requestGameTime,expires=q.requestGameTime+4};self.eObservation=ledger
  Core:AfterCast(HK_E,function()if self.eObservation==ledger then ledger.castObserved=true end end)
 end;return ok
end
function JhinChampion:Trap(target,context,permission)
 if not self:Current(target)then return false end;return self:CastE(target.pos,context,permission,target,true)
end
-- W kills on arrival: the shared kill rule (physical shield pool, health window, regeneration until impact).
function JhinChampion:LethalW(u)
 if not self:Current(u)then return false end;local p=self.profile
 return(Core:Lethal(u,p.wDelay+GetDistance(u.pos,myHero.pos)/p.wSpeed,function()return self:Damage(u,_W)end,{kind='physical'}))
end
-- Q kills on arrival: the shared kill rule on its first hit.
function JhinChampion:LethalQ(u)
 if not self:Current(u)or GetDistance(u.pos,myHero.pos)>self:QReach(u)then return false end
 return Core:Lethal(u,.25+GetDistance(u.pos,myHero.pos)/1800,function()return self:Damage(u,_Q)end,{kind='physical'})==true
end
-- A lane minion Q kills (shared rule at its impact) whose next recipient is an enemy champion: the nearest unit within
-- 450 of the minion at impact is that champion. `kill`: the amplified bounce must kill the champion, and it must be
-- the only unit in bounce range (any other choice would be speculation). Returns the champion or nil.
function JhinChampion:Bounce(m,kill)
 if not self:Current(m)or m.team==300 or GetDistance(m.pos,myHero.pos)>self:QReach(m)then return nil end
 local time=.25+GetDistance(m.pos,myHero.pos)/1800
 if not Core:Lethal(m,time,function()return self:Damage(m,_Q)end)then return nil end
 local at=self:Projected(m,time);local best,bestD,count=nil,nil,0
 local function consider(list)for _,v in ipairs(list)do if id(v)~=id(m)then local d=GetDistance(self:Projected(v,time+.2),at)
  if d<=self.profile.qBounce then count=count+1;if not bestD or d<bestD then best,bestD=v,d end end end end end
 consider(self:Rows('lane',1500));consider(self:Rows('heroes',1500))
 if not best or best.type~=Obj_AI_Hero then return nil end
 if kill then
  if count~=1 then return nil end
  local impact=time+.2+bestD/600
  if not Core:Lethal(best,impact,function()return self:Damage(best,_Q)*(1+self.profile.qAmp)end,{kind='physical'})then return nil end
 end
 return best
end
-- The fourth shot crits and executes: in Combo, Harass and LaneClear the orbwalker is asked to spend it on a champion
-- in attack range (one it kills first, else the lowest health). A preference, never an attack veto; the player's
-- selected champion keeps precedence (Core:PreferAttack).
function JhinChampion:SteerFourth()
 local mode=GetMode();local ammo=self:Ammo()
 if ammo~=1 or mode~='Combo'and mode~='Harass'and mode~='LaneClear'then Core:ReleaseAttackPreference('Jhin4th');return false end
 local best,bestKill
 for _,u in ipairs(self:Rows('heroes',1500))do
  if _G.SDK.Data:IsInAutoAttackRange(myHero,u)then
   local damage=self:FourthLowerBound(u)
   local kill=damage~=nil and Core:Lethal(u,.3,damage,{kind='physical',attack=true})==true
   if not best or kill and not bestKill or kill==bestKill and u.health<best.health then best,bestKill=u,kill end
  end
 end
 if not best then Core:ReleaseAttackPreference('Jhin4th');return false end
 return Core:PreferAttack('Jhin4th',best,1)
end
-- W costs three quarters of a second of attacks. Inside attack range it is cast only when no attack is lost
-- (reloading or empty), when it kills, or when the root holds a target that is walking out of attack range.
function JhinChampion:WWorth(u)
 if not self:Current(u)then return false end
 local reach=myHero.range+myHero.boundingRadius+(u.boundingRadius or 0);local distance=GetDistance(u.pos,myHero.pos)
 if distance>reach then return true end
 local ammo,reloading=self:Ammo();if reloading or ammo==0 or self:LethalW(u)then return true end
 local path=u.pathing;local to=path and path.hasMovePath==true and point(path.endPos)
 return distance>reach-100 and to~=nil and to~=false and GetDistance(to,myHero.pos)>distance+50
end
-- Without a mode key: a trap under enemies who cannot move yet or are about to arrive (stasis, revive, hard
-- control, channels, teleport and gate markers), from the shared scan. It must be armed before the enemy is free:
-- cast, flight to that spot and arming are weighed against the row's time, again at dispatch. The charge reserve
-- stays in force.
function JhinChampion:ZoneE()
 if not Menu.Misc.AutoE:Value()or not self:Ready(_E)then return false end
 local p=self.profile;local base=.25+p.eArm
 local rows=Core:ZoneTargets({range=p.eRange,arm=base,lifetime=10})
 for i=1,math.min(#rows,6)do local row=rows[i];local pos=point(row.position)
  local function fits()return Menu.Misc.AutoE:Value()and row.valid()and row.freeAt-Game.Timer()>=base+GetDistance(pos,myHero.pos)/1600 end
  if pos and fits()and self:CastE(pos,{priority='interactive'},fits)then return true end
 end
 return false
end
-- An enemy dash that ends next to Jhin: the root when that enemy carries an own mark, else a trap on the end point.
function JhinChampion:GapPeel()
 if not Menu.Misc.Gap:Value()or not(self:Ready(_W)or self:Ready(_E))then return false end
 for _,u in ipairs(self:Rows('heroes',1500))do local dash=Core:ApproachingDash(u,myHero.pos,350)
  if dash then
   -- The dash may end while the request waits: the enemy then stands next to Jhin.
   local function near()return Menu.Misc.Gap:Value()and self:Current(u)and(Core:ApproachingDash(u,myHero.pos,350)~=nil or GetDistance(u.pos,myHero.pos)<=350)end
   if self:Ready(_W)and self:Marked(u)and self:CastW(u,{priority='interactive'},near,true)then return true end
   local pos=point(dash.to)
   if pos and self:Ready(_E)and self:CastE(pos,{priority='interactive'},near)then return true end
  end
 end
 -- A melee champion walking at Jhin from close range: W when marked, else a trap in its path at 150 from Jhin when
 -- it would arm before the walker gets there, otherwise at its feet (the 2 s detonation still lands).
 local p=self.profile
 for _,u in ipairs(self:Rows('heroes',600))do
  local path=u.pathing;local d=GetDistance(u.pos,myHero.pos)
  if finite(u.range)and u.range<=300 and d<=350 and d>100 and path and path.hasMovePath==true and not path.isDashing and point(path.endPos)
   and GetDistance(path.endPos,myHero.pos)<d then
   local function near()return Menu.Misc.Gap:Value()and self:Current(u)and GetDistance(u.pos,myHero.pos)<=400 end
   if self:Ready(_W)and self:Marked(u)and self:CastW(u,{priority='interactive'},near,true)then return true end
   if self:Ready(_E)then
    local spot=myHero.pos:Extended(u.pos,150);local arm=p.eCast+150/p.eSpeed+p.eArm
    local arrive=finite(u.ms)and u.ms>0 and(d-150)/u.ms or 0
    if arrive<arm then spot=point(u.pos)end
    if self:CastE(spot,{priority='interactive'},near)then return true end
   end
  end
 end
 return false
end
function JhinChampion:MaintainTraps()
 local size=0;for key,trap in pairs(self.traps)do
  if not IsValid(trap.object)or trap.object.handle~=trap.handle or Game.Timer()>trap.expires then self.traps[key]=nil else size=size+1 end
 end
 local row=self.eObservation;if not row then return end
 if row.expires<Game.Timer()then self.eObservation=nil;return end
 if not row.castObserved then return end
 -- Native trap discovery is supplemental: readiness never implies an object.
 local list=_G.SDK.ObjectManager:GetAllyMinions(900)
 for i=1,math.min(#list,32)do local u=list[i];local owner=u.ownerID or u.ownerNetworkID or u.owner and id(u.owner)
  if owner==myHero.networkID and u.charName=='JhinETrap'and IsValid(u)and GetDistance(u.pos,row.point)<100 and finite(u.spawnTime)and u.spawnTime>=row.request then
   if size>=16 then local oldest,at;for key,trap in pairs(self.traps)do if not at or trap.spawn<at then oldest,at=key,trap.spawn end end;self.traps[oldest]=nil end
   self.traps[id(u)]={object=u,handle=u.handle,spawn=u.spawnTime,armedAt=u.spawnTime+self.profile.eArm,expires=u.spawnTime+180};row.object=id(u);self.eObservation=nil
   -- Development evidence for the arming time: request, cast observation and native spawn of the own trap.
   if Core.logger then Core:Trace('jhin_trap_spawn',{request=row.request,spawn=u.spawnTime,x=u.pos.x,z=u.pos.z},250)end
   return
  end
 end
end
function JhinChampion:RPermission()
 if Menu.Misc.RAssist:Value()then return true end
 return GetMode()=='Combo'and Menu.Combo.R:Value()
end
-- Combo starts the channel only for a kill out of ordinary fighting range. Three
-- shots and the fourth at current health are a lower bound on the four shots.
function JhinChampion:RFinishes(u)
 return self:Current(u)and GetDistance(u.pos,myHero.pos)>1000
  and self:Damage(u,_R,1)*3+self:Damage(u,_R,4)>=u.health+(u.shieldAD or 0)
end
function JhinChampion:ChannelWitness()
 local c=myHero.activeSpell
 return c and c.valid and c.isStopped~=true and c.name=='JhinR'and finite(c.startTime)and point(c.startPos)and point(c.placementPos)and c.isChanneling==true and c
end
function JhinChampion:StartR(u)
 if not self:RPermission()or self.rGesture or self.channel or not self:Ready(_R)or not self:Current(u)or GetEnemyCount(Menu.Misc.RSafe:Value(),myHero.pos)>0 then return false end
 local p=self:Predict(u,self.RSpell);if not p then return false end
 local held=Menu.Misc.RAssist:Value();local permission=function()return held and Menu.Misc.RAssist:Value()or not held and GetMode()=='Combo'and Menu.Combo.R:Value()end
 local context=held and {held=permission,priority='interactive'}or Core:ModeContext('Combo',permission)
 local identity,handle=id(u),u.handle
 local ok=Core:Cast(HK_R,p,{owner='RStart',intentTarget=u,range=3500,context=context,prevalidateWorldCast=true,independent=false,
  commitGuard=function()return Core:Current()and self:RPermission()end,
  resolve=function()if not self:RPermission()or not self:Current(u)or id(u)~=identity or u.handle~=handle then return nil end
   local aim=self:Predict(u,self.RSpell);return aim and {position=aim}or nil end,
  validate=function()return self:Ready(_R)and self:RPermission()and self:Current(u)and id(u)==identity and u.handle==handle and GetEnemyCount(Menu.Misc.RSafe:Value(),myHero.pos)==0
   and(held or self:RFinishes(u))end,
  observe=function(q)local native=self:ChannelWitness();return native and Core:NativeCast(q,'JhinR')~=nil and myHero:GetSpellData(_R).name=='JhinRShot'end})
 if ok and Core.lastIntent then local q=Core.lastIntent;self.rGesture=true;self.rStart={id=q.id,request=q.requestGameTime,expires=q.requestGameTime+2,context=context,target=u,targetID=identity,handle=handle}
  Core:AfterCast(HK_R,function()local start=self.rStart;local native=self:ChannelWitness()
   if start and start.id==q.id and native and Core:NativeCast(q,'JhinR')then
    local ammo=myHero:GetSpellData(_R).ammo
    self.channel={origin=point(native.startPos),aim=point(native.placementPos),start=native.startTime,expires=native.startTime+10,
     ammo=finite(ammo)and ammo%1==0 and ammo>=1 and ammo<=4 and ammo or nil,shots=0,lastShot=-math.huge,context=start.context,permission=permission,target=start.target,targetID=start.targetID,handle=start.handle}
    self.rStart=nil
   end
  end)
 end;return ok
end
function JhinChampion:InCone(p)
 local c=self.channel;if not c or not point(p)then return false end
 local along,side=ray(c.origin,c.aim,p)
 return along and along>0 and GetDistance(p,c.origin)<=3500 and side<=along*math.tan(self.profile.rHalfAngle*math.pi/180)
end
function JhinChampion:MaintainChannel()
 local c=self.channel
 if self.rStart and Game.Timer()>self.rStart.expires then self.rStart=nil
  -- An unobserved start must not block adopting the live native channel for the whole gesture.
  if not c and myHero:GetSpellData(_R).name=='JhinRShot'and self:ChannelWitness()then self.rGesture=nil end
 end
 if not c then return end
 local native=myHero.activeSpell;local s=myHero:GetSpellData(_R)
 if not c.permission()or c.manualChange or c.ammo==0 and not c.pending or Game.Timer()>c.expires or s.name~='JhinRShot'or GetDistance(myHero.pos,c.origin)>100
  or native and native.valid and native.isStopped==true then
  Core:Cancel('RShot','channel_ended');self.retiredChannel=c.start;self.channel=nil;_G.SDK.Orbwalker:SetAttack(true);_G.SDK.Orbwalker:SetMovement(true);return
 end
 _G.SDK.Orbwalker:SetAttack(false);_G.SDK.Orbwalker:SetMovement(false)
 if c.pending then local result=Core.adapter:Poll(c.pending.id)
  if result and result.state=='cancelled_before_send'then
   local reason=tostring(result.reason or '')
   if reason:find('manual',1,true)or reason:find('ambiguous mouse movement',1,true)or reason:find('movement command',1,true)then c.manualChange=true end
   c.pending=nil
  elseif result and result.state=='send_uncertain'then c.uncertain=true end
  -- A finished shot request without observation is reconciled from native ammo once,
  -- instead of blocking every later shot of this channel.
  local q=c.pending
  if q and q.sentAt and not q.observedAt and q.outcome and Core.pending[q.key]~=q then
   if finite(s.ammo)and c.ammo and s.ammo==c.ammo-1 then c.ammo=s.ammo;c.shots=c.shots+1;c.lastShot=Game.Timer()
   elseif not(finite(s.ammo)and s.ammo==c.ammo)then c.manualChange=true end
   c.pending=nil
  end
 end
 -- Unexpected ammo changes may be manual shots. Stop assistance instead of
 -- attributing them to this request or replaying an uncertain one.
 if finite(s.ammo)and c.ammo and s.ammo~=c.ammo and not c.pending then c.manualChange=true end
end
-- A channel the player started (game R key) is aimed while the R bind is held, or without a key when RAutoAim is on.
-- A channel whose assistance ended (manual shot, unexpected ammo, movement, release) is never adopted again.
function JhinChampion:AdoptChannel()
 local held,auto=Menu.Misc.RAssist:Value(),Menu.Misc.RAutoAim:Value()
 if self.channel or self.rStart or self.rGesture or not held and not auto or myHero:GetSpellData(_R).name~='JhinRShot'then return false end
 local native=self:ChannelWitness();local ammo=myHero:GetSpellData(_R).ammo
 if not native or not finite(ammo)or ammo%1~=0 or ammo<1 or ammo>4 or Game.Timer()>native.startTime+10 or self.retiredChannel==native.startTime then return false end
 local permission=held and function()return Menu.Misc.RAssist:Value()end or function()return Menu.Misc.RAutoAim:Value()end
 local context=held and {held=permission,priority='interactive'}or {priority='interactive'}
 self.channel={origin=point(native.startPos),aim=point(native.placementPos),start=native.startTime,expires=native.startTime+10,ammo=ammo,shots=4-ammo,lastShot=Game.Timer(),
  permission=permission,context=context,adopted=true,auto=not held}
 self.rGesture=true;return true
end
function JhinChampion:ShotR(u)
 local c=self.channel
 if not c or c.pending or c.manualChange or c.uncertain or c.ammo==nil or c.ammo<=0 or c.shots>=4 or not c.permission()or not self:Ready(_R,true)
  or Game.Timer()-c.lastShot<1 or not self:Current(u)then return false end
 local identity,handle=id(u),u.handle;local ammo=c.ammo;local shot=5-ammo
 local function resolve()
  if self.channel~=c or not c.permission()or not self:Ready(_R,true)or myHero:GetSpellData(_R).ammo~=ammo or not self:Current(u)or id(u)~=identity or u.handle~=handle then return nil end
  local p=self:Predict(u,self.RSpell);return p and self:InCone(p)and self:RayClear(p,u,true)and {position=p}or nil
 end
 local r=resolve();if not r then return false end
 local ok=Core:Cast(HK_R,r.position,{owner='RShot',intentTarget=u,context=c.context,range=3500,independent=false,prevalidateWorldCast=true,resolve=resolve,
  commitGuard=function()return Core:Current()and self.channel==c and c.permission()end,
  validate=function(_,fresh)return self.channel==c and c.permission()and self:Ready(_R,true)and self:Current(u)and id(u)==identity and u.handle==handle
   and myHero:GetSpellData(_R).ammo==ammo and fresh and self:InCone(fresh.position)and self:RayClear(fresh.position,u,true)end,
  observe=function(q)local cast=Core:NativeCast(q,'JhinRShot')
   return cast
    and myHero:GetSpellData(_R).ammo==ammo-1
  end})
 if ok and Core.lastIntent then local q=Core.lastIntent;c.pending=q
  Core:AfterCast(HK_R,function()if self.channel==c and c.pending==q then c.ammo=ammo-1;c.shots=c.shots+1;c.lastShot=Game.Timer();c.pending=nil end end)
 end;return ok
end
-- The selected champion first; then a champion this shot kills (shared kill rule at the shot's impact), then a
-- clear ray, then the lowest effective health; the channel's own target breaks a remaining tie.
function JhinChampion:ShotDamage(u)
 local c=self.channel;local shot=c and c.ammo and 5-c.ammo or 1
 return self:Damage(u,_R,shot)
end
function JhinChampion:ChannelTarget()
 local selected=_G.SDK.TargetSelector.Selected
 if self:Current(selected)and self:InCone(selected.pos)then return selected end
 local c=self.channel;local origin=c and c.origin or myHero.pos;local best,bestKey
 for _,u in ipairs(self:Rows('heroes',3500))do
  if self:InCone(u.pos)then
   local lethal=Core:Lethal(u,self.profile.rDelay+GetDistance(u.pos,origin)/self.profile.rSpeed,function()return self:ShotDamage(u)end,{kind='physical'})==true
   local clear=self:RayClear(u.pos,u,true)==true
   local key={lethal and 1 or 0,clear and 1 or 0,-(u.health+(u.shieldAD or 0)),c and id(u)==c.targetID and 1 or 0}
   local better=not bestKey
   if not better then for i=1,4 do if key[i]~=bestKey[i]then better=key[i]>bestKey[i];break end end end
   if better then best,bestKey=u,key end
  end
 end
 return best
end
function JhinChampion:Combat(mode)
 local node=Menu[mode];if not self:Mana(node.Mana)then return end;local context=Core:ModeContext(mode);local u=self:Target(1900)
 if not u then return end
 if node.Q:Value()and self:Ready(_Q)then local first=self:QChoice(u)
  if first and self:CastQ(first,context,function()return node.Q:Value()and self:Mana(node.Mana)and self:Current(u)and self:QUseful(u)end)then return true end
 end
 local function wAllowed()return node.W:Value()and self:Mana(node.Mana)and(GetDistance(u.pos,myHero.pos)<=1200 or node.LongW:Value())and self:WWorth(u)end
 if node.W:Value()and self:Ready(_W)and self:CastW(u,context,wAllowed,true)then return true end
 -- Without a mark the W still lands for certain on a target held through its cast and flight.
 if node.W:Value()and self:Ready(_W)and not self:Marked(u)and self:HeldForW(u)
  and self:CastW(u,context,function()return wAllowed()and self:HeldForW(u)end,false)then return true end
 if node.E:Value()and self:Ready(_E)then
  local permission=function()return node.E:Value()and self:Mana(node.Mana)end
  if self:Trap(u,context,permission)then return true end
  return self:TrapAhead(u,context,permission)
 end
end
function JhinChampion:HeldForW(u)
 return self:Current(u)and self:CCRemaining(u)>=self.profile.wDelay+GetDistance(u.pos,myHero.pos)/self.profile.wSpeed
end
-- A trap where a walking target will be once it is armed (cast, flight at 1600, arming), while reloading (no attack
-- is lost) or with two charges above the reserve. The target's path must still put it within the trigger radius of
-- that spot at dispatch.
function JhinChampion:TrapSpot(u)
 local p=self.profile;local path=u.pathing
 if not self:Current(u)or not path or path.hasMovePath~=true or path.isDashing then return nil end
 local t=p.eCast+GetDistance(u.pos,myHero.pos)/p.eSpeed+p.eArm;local spot=self:Projected(u,t)
 if not spot or GetDistance(spot,myHero.pos)>p.eRange or GetDistance(spot,u.pos)<50 then return nil end
 return spot
end
-- Charge rule: while reloading (no attack is lost) or with two charges and one above the reserve. The old rule
-- (reserve+2) could never be met with the default reserve of 1 and two charges at most.
function JhinChampion:TrapAhead(u,context,permission)
 local spell=myHero:GetSpellData(_E);local _,reloading=self:Ammo()
 if not reloading and not(finite(spell.ammo)and spell.ammo>=math.max(2,Menu.Misc.Reserve:Value()+1))then return false end
 local spot=self:TrapSpot(u);if not spot then return false end
 return self:CastE(spot,context,function()
  local fresh=permission()and self:TrapSpot(u);return fresh~=nil and fresh~=false and GetDistance(fresh,spot)<=self.profile.eTrigger
 end)
end
-- Without a mode key (re-rank harass, DepressiveJhin parity): a trap ahead of an enemy walking away from Jhin,
-- under the same charge rule and dispatch re-projection as TrapAhead. Combo and Harass keep their own E switch.
-- Walking away: the path heads away from Jhin (within about 70 degrees of straight away) and ends farther off.
function JhinChampion:Away(u)
 local path=self:Current(u)and u.pathing;local to=path and path.hasMovePath==true and not path.isDashing and point(path.endPos)
 if not to then return false end
 local dx,dz,ax,az=to.x-u.pos.x,to.z-u.pos.z,u.pos.x-myHero.pos.x,u.pos.z-myHero.pos.z
 local n=math.sqrt((dx*dx+dz*dz)*(ax*ax+az*az));if n<1 then return false end
 return(dx*ax+dz*az)/n>.34 and GetDistance(to,myHero.pos)>GetDistance(u.pos,myHero.pos)+100
end
function JhinChampion:AwayE()
 local mode=GetMode()
 if not Menu.Misc.AwayE:Value()or mode=='Combo'or mode=='Harass'or not self:Ready(_E)then return false end
 local rows=self:Rows('heroes',self.profile.eRange+400)
 for i=1,math.min(#rows,5)do local u=rows[i]
  if self:Away(u)and self:TrapAhead(u,{priority='normal'},function()return Menu.Misc.AwayE:Value()and self:Away(u)end)then return true end
 end
 return false
end
function JhinChampion:Combo()return self:Combat('Combo')end
function JhinChampion:Harass()return self:Combat('Harass')end
function JhinChampion:Farm(kind)
 local node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'];if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()or not self:Mana(node.Mana)then return end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end);local rows=self:Rows(kind,self.profile.qRange+300)
 if kind=='lane'and self:CannonW(context)then return true end
 if node.Q:Value()and self:Ready(_Q)then local scope=self:QScope(nil,kind);local best,bestKills,bestHits
  for i=1,math.min(#rows,8)do local u=rows[i];local plan=self:QPaths(u,nil,kind,scope)
   if plan and(kind=='jungle'or plan.minHits>=Menu.Clear.LaneClear.Count:Value())then
    local kills=plan.minKills or 0
    if not best or kills>bestKills or kills==bestKills and plan.minHits>bestHits then best,bestKills,bestHits=u,kills,plan.minHits end
   end
  end
  if best then local u=best;return self:CastQ(u,context,function()
   local fresh=self:QPaths(u,nil,kind);return node.Q:Value()and self:Mana(node.Mana)and fresh and(kind=='jungle'or fresh.minHits>=Menu.Clear.LaneClear.Count:Value())end)
  end
 end
 local ammo,reloading=self:Ammo();if not reloading then return end
 local function reload(n)return function()local _,r=self:Ammo();return r and n:Value()and self:Mana(node.Mana)end end
 if kind=='jungle'then
  local target=rows[1];if target and node.W:Value()and self:Ready(_W)then return self:CastW(target,context,reload(node.W),false)end
  if target and node.E:Value()then return self:CastE(target.pos,context,reload(node.E),target,false)end
  return
 end
 -- Lane: the area that covers the most minions, at least the lane count.
 local need=Menu.Clear.LaneClear.Count:Value();local points={}
 for i=1,math.min(#rows,24)do local u=rows[i];if self:Current(u)then points[#points+1]={x=u.pos.x,y=u.pos.y,z=u.pos.z,unit=u,radius=(u.boundingRadius or 0)*.5}end end
 if #points<need then return end
 if node.W:Value()and self:Ready(_W)then
  local aim,weight,hits=Core:BestAim(points,{kind='line',width=self.profile.wRadius*2,range=self.profile.wRange})
  if aim and weight>=need then
   local far;for _,i in ipairs(hits)do local u=points[i].unit;if not far or GetDistance(u.pos,myHero.pos)>GetDistance(far.pos,myHero.pos)then far=u end end
   if far and self:CastW(far,context,reload(node.W),false)then return true end
  end
 end
 if node.E:Value()and self:Ready(_E)then
  local aim,weight=Core:BestAim(points,{kind='circle',radius=self.profile.eRadius,range=self.profile.eRange})
  if aim and weight>=need then
   local spot={x=aim.x,y=aim.y or 0,z=aim.z}
   local function covered()local n=0;for _,row in ipairs(points)do if self:Current(row.unit)and GetDistance(row.unit.pos,spot)<=self.profile.eRadius then n=n+1 end end;return n end
   return self:CastE(spot,context,function()return reload(node.E)()and covered()>=Menu.Clear.LaneClear.Count:Value()end)
  end
 end
end
-- W rescues a cannon minion an attack and Q cannot take: beyond Q and attack reach, the shared LastHit rule at W's
-- impact (W does 75% to minions), the ray clear of champions (W stops at the first one), spell farming on.
function JhinChampion:CannonW(context)
 if not Menu.Clear.SpellFarm:Value()or not Menu.LastHit.Q:Value()or not self:Ready(_W)or not self:Mana(Menu.LastHit.Mana)then return false end
 for _,u in ipairs(self:Rows('lane',self.profile.wRange))do
  local function cannon()return type(u.charName)=='string'and u.charName:lower():find('siege',1,true)~=nil end
  if cannon()then
   local function rescue()
    if not Menu.Clear.SpellFarm:Value()or not self:Current(u)or not cannon()then return false end
    local d=GetDistance(u.pos,myHero.pos)
    if d<=self:QReach(u)and self:Ready(_Q)or d<=myHero.range+myHero.boundingRadius+(u.boundingRadius or 0)then return false end
    return Core:Rescue(u,self.profile.wDelay+d/self.profile.wSpeed,function()return self:Damage(u,_W)end)
   end
   if rescue()and self:CastW(u,Core:RescueContext(context),rescue,false)then return true end
  end
 end
 return false
end
function JhinChampion:LaneClear()return self:Farm('lane')end
function JhinChampion:JungleClear()return self:Farm('jungle')end
function JhinChampion:Rescue(u)
 if not self:Current(u)or u.team==300 or GetDistance(u.pos,myHero.pos)>self:QReach(u)then return false end
 local time=.25+GetDistance(u.pos,myHero.pos)/1800
 if not Core:Rescue(u,time,self:Damage(u,_Q),spellOnly)then return false end
 -- A loaded, ready attack in reach always takes the last hit; a reload leaves it to Q.
 local ammo,reload=self:Ammo();if not reload and ammo~=0 and _G.SDK.Orbwalker:CanAttack()and GetDistance(u.pos,myHero.pos)<=myHero.range+myHero.boundingRadius+(u.boundingRadius or 0)then return false end
 for _,v in ipairs(self:Rows('lane',1100))do if id(v)~=id(u)and GetDistance(self:Projected(v,time),self:Projected(u,time))<=450 then return false end end
 return true
end
function JhinChampion:LastHit()
 if not Menu.LastHit.Q:Value()or not self:Mana(Menu.LastHit.Mana)then return end
 if not self:Ready(_Q)then return self:CannonW()end
 for _,u in ipairs(self:Rows('lane',self.profile.qRange+300))do if self:Rescue(u)then return self:CastQ(u,Core:RescueContext(),function()return Menu.LastHit.Q:Value()and self:Mana(Menu.LastHit.Mana)and self:Rescue(u)end)end end
 return self:CannonW()
end
function JhinChampion:Flee()
 local u=self:Target(1000);if not u then return end
 if Menu.Misc.FleeW:Value()and self:Ready(_W)and self:CastW(u,Core:ModeContext('Flee'),function()return Menu.Misc.FleeW:Value()end,true)then return true end
 if Menu.Misc.FleeE:Value()and self:Ready(_E)then
  if self:Trap(u,Core:ModeContext('Flee'),function()return Menu.Misc.FleeE:Value()end)then return true end
  -- A pursuer close behind: the trap on the line between you, so it is armed in its path.
  local distance=GetDistance(u.pos,myHero.pos)
  if distance<=600 and distance>150 then local spot=myHero.pos:Extended(u.pos,150)
   return self:CastE(spot,Core:ModeContext('Flee'),function()return Menu.Misc.FleeE:Value()and self:Current(u)and GetDistance(u.pos,spot)<=700 end)
  end
 end
end
function JhinChampion:OnPostAttack(args)
 if not Core:InputAvailable()then return end;local witness=Core:AttackWitness(self.attackWitness,args and args.Target)
 if witness and witness~=self.attackWitness then self.attackWitness=witness end
end
function JhinChampion:Assist()
 if Menu.Misc.RAssist:Value()or GetMode()=='Combo'and Menu.Combo.R:Value()then local u=self:Target(3500)
  if u and(Menu.Misc.RAssist:Value()or self:RFinishes(u))and self:StartR(u)then return true end
 end
 if Menu.Misc.KillW:Value()and self:Ready(_W)then
  local function allowed()return Menu.Misc.KillW:Value()end
  for _,u in ipairs(self:Rows('heroes',2500))do
   if self:LethalW(u)and self:CastW(u,{priority='interactive'},function()return allowed()and self:LethalW(u)end,false)then return true end
  end
 end
 if Menu.Misc.KillW:Value()and self:Ready(_Q)then
  for _,u in ipairs(self:Rows('heroes',1200))do
   if self:LethalQ(u)and self:CastQ(u,{priority='interactive'},function()return Menu.Misc.KillW:Value()and self:LethalQ(u)end)then return true end
  end
  for _,m in ipairs(self:Rows('lane',self.profile.qRange+300))do
   local hero=self:Bounce(m,true)
   if hero and self:CastQ(m,{priority='interactive'},function()local h=Menu.Misc.KillW:Value()and self:Bounce(m,true);return h==hero end)then return true end
  end
 end
 if Menu.Misc.BounceQ:Value()and GetMode()~='Combo'and self:Ready(_Q)and self:Mana(Menu.Harass.Mana)then
  for _,m in ipairs(self:Rows('lane',self.profile.qRange+300))do
   local hero=self:Bounce(m,false)
   if hero and self:CastQ(m,{priority='normal'},function()return Menu.Misc.BounceQ:Value()and GetMode()~='Combo'and self:Mana(Menu.Harass.Mana)and self:Bounce(m,false)==hero end)then return true end
  end
 end
 if Menu.Misc.WAssist:Value()and self:Ready(_W)then local u=self:Target(2500)
  if u then return self:CastW(u,{held=function()return Menu.Misc.WAssist:Value()end,priority='interactive'},function()return Menu.Misc.WAssist:Value()end,false)end
 end
end
function JhinChampion:Tick()
 if not Core:InputAvailable()or ShouldWait()then _G.SDK.Orbwalker:SetAttack(true);_G.SDK.Orbwalker:SetMovement(true);self.preview=nil;return end
 if not self:RPermission()and not(self.channel and self.channel.auto)then self.rGesture=nil end
 self:AdoptChannel();self:MaintainChannel();self:MaintainTraps()
 if self.channel then local u=self:ChannelTarget();if u then self:ShotR(u)end;return end
 if self.rStart or IsCasting()then return end
 self:SteerFourth()
 if self:Assist()or self:GapPeel()or self:ZoneE()or self:AwayE()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')then self:LaneClear()end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and Menu.Draw.Preview:Value()and(not self.nextPreview or self.nextPreview<Game.Timer())then self:PreparePreview()end
end
-- Enemies R kills only: the game shows ammo, reload, R shots and the W mark. Kept for a second so a late
-- preparation never blinks it; Draw needs R ready (or channelling) and the enemy alive and seen.
function JhinChampion:PreparePreview()
 local now=Game.Timer();local marks={};local rReady=self:Ready(_R)or self.channel~=nil
 if rReady then for _,u in ipairs(self:Rows('heroes',3500))do
  if #marks>=5 then break end
  if self:Damage(u,_R,1)*3+self:Damage(u,_R,4)>=u.health+(u.shieldAD or 0)then marks[#marks+1]={unit=u,handle=u.handle,kill=true}end
 end end
 self.preview={expires=now+1,marks=marks}
 self.nextPreview=now+.15
end
-- Health-bar combo damage (shared display): ready Q and W, the next attack (the fourth shot's lower bound when it is
-- loaded) and, with R ready, four shots. Item and crit amplification are left out.
function JhinChampion:ComboDamage(u)
 if not self:Current(u)then return 0 end
 local damage=self:FourthLowerBound(u)or _G.SDK.Damage:GetAutoAttackDamage(myHero,u)
 if self:Ready(_Q)then damage=damage+self:Damage(u,_Q)end
 if self:Ready(_W)then damage=damage+self:Damage(u,_W)end
 if self:Ready(_R)then damage=damage+self:Damage(u,_R,1)*3+self:Damage(u,_R,4)end
 return damage
end
function JhinChampion:Draw()
 if myHero.dead then return end
 -- Ranges for ready slots only (no search: Ready reads own spell data).
 if Menu.Draw.Ranges:Value()then
  if IsReady(_Q)then Draw.Circle(myHero.pos,self:QReach(),1,Draw.Color(255,180,200,255))end
  if IsReady(_E)then Draw.Circle(myHero.pos,self.profile.eRange,1,Draw.Color(255,255,180,100))end
  if IsReady(_W)then Draw.Circle(myHero.pos,self.profile.wRange,1,Draw.Color(255,120,255,160))end
  if IsReady(_R)then Draw.Circle(myHero.pos,self.profile.rRange,1,Draw.Color(255,255,100,100))end
 end
 -- The two edges of the observed channel's cone: geometry only, nothing is searched here.
 local c=self.channel
 if c and Menu.Draw.RCone:Value()and Draw.Line and c.origin and c.aim then
  local dx,dz=c.aim.x-c.origin.x,c.aim.z-c.origin.z;local length=math.sqrt(dx*dx+dz*dz)
  if length>1 then dx,dz=dx/length,dz/length;local a=c.origin:To2D();local range=self.profile.rRange
   for _,sign in ipairs({-1,1})do local angle=sign*self.profile.rHalfAngle*math.pi/180;local cs,sn=math.cos(angle),math.sin(angle)
    local b=Vector(c.origin.x+(dx*cs-dz*sn)*range,c.origin.y,c.origin.z+(dx*sn+dz*cs)*range):To2D()
    Draw.Line(a.x,a.y,b.x,b.y,1,Draw.Color(160,255,120,120))
   end
  end
 end
 local p=self.preview;if Menu.Draw.Preview:Value()and p and p.expires>=Game.Timer()and(c or IsReady(_R))then
  for _,row in ipairs(p.marks or {})do local u=row.unit
   local live=u and u.valid~=false and u.visible~=false and not u.dead and u.handle==row.handle
   if live and u.pos2D and u.pos2D.onScreen~=false then Draw.Text('R kills',14,u.pos2D.x-30,u.pos2D.y-80,Draw.Color(255,255,80,80))end
   -- R kill on the minimap too (an off-screen target is the usual R target); prepared rows only, no search.
   local mm=live and u.posMM
   if mm and mm.x and mm.y then Draw.Text('R',14,mm.x-4,mm.y-7,Draw.Color(255,255,80,80))end
  end
 end
end
function JhinChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Jhin: modes','Jhin: Curtain Call'},function(page)
  return {title=page==1 and 'Jhin assistance'or 'Four shots',cards=page==1 and {
   {'COMBAT','Combo/Harass use bounded Q bounce forecasts and owned marked first-hit W. Fourth-shot conservation leaves urgent spells available, and the fourth shot is steered onto a champion in range. W also roots unmarked targets that are held through its cast.'},
   {'W','Inside attack range W is kept for when no attack is lost (reloading), when it kills, or when the root holds a target walking out of range. Q reaches 550 between the edges of the two units.'},
   {'TRAPS','E preserves configured charges and needs control through trap arming. Without a mode key it is also placed under enemies in stasis, reviving, channelling or arriving by teleport; an enemy who dashes onto you is rooted if marked, else trapped at the landing. While reloading a trap goes where a walking target will be once armed; a melee champion walking at you gets a trap or the root. Flee drops a trap between you and a close pursuer. A cast is not an armed trap.'},
   {'FARM','Enable spell farming with distinct Lane/Jungle binds. LastHit Q rescues isolated missed CS; predicted bounce kills are never confirmed damage.'}}or {
   {'START','Hold the R bind; Combo starts R by itself only to kill a distant target. A channel you start yourself is aimed for you while that option is on. Nearby enemies reject channel start. The channel keeps its original origin and direction.'},
   {'SHOTS','Each native RShot and ammo decrement advances one shot. Predicted aim must stay inside the cone and avoid the first intervening champion.'},
   {'CONTROL','Your selected champion takes priority during R. Release assistance to cancel future shots. Unknown ammo, manual changes or uncertain input receive no replay.'}},
   note='Normal-only installed kit. Runtime aliases, bounce selection, channel geometry and live timing retain separate acceptance.'}
 end)
end
Core:StandardPolicy(JhinChampion,{damageTypes={Q='physical',W='physical',R='physical'},
 channel=function(self,q)return not Core:SelfChanneling()or q and q.owner=='RShot'and self.channel~=nil end,
 validate=function(self,q,slot)return slot==nil or slot<0 or slot>3 or self:Ready(slot,q.owner=='RShot')end})
JhinChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={}
local normalSupported={["Jhin"]=true}

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
