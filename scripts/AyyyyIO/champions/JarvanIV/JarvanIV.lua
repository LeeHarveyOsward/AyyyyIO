return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["JarvanIV"]=function()return _G.OrbamaFamily:Require("4c736548111d5437d427c46e955551ab7819e11928ca90afa2061f275934ee6e")()end
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
if champion=="JarvanIV" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='JarvanIV',profiles={normal=true,classic=true},
 Create=function(context)
-- Independently implemented. Installed assets identify both kits; host evidence
-- admits ownership/stages. See jarvaniv-provenance.json for unmeasured geometry.
local profiles=ChampionProfiles('JarvanIV')
local finite,id,point=Core.finite,Core.id,Core.point
local function own(source)
 if type(source)=='table'or type(source)=='userdata'then return source.networkID==myHero.networkID or source.handle==myHero.handle end
 return source~=nil and source~=0 and(source==myHero.networkID or source==myHero.handle)
end
local function segment(p,a,b)
 local dx,dz=b.x-a.x,b.z-a.z;local l=dx*dx+dz*dz;if l<=0 then return math.huge,0 end
 local t=((p.x-a.x)*dx+(p.z-a.z)*dz)/l
 local x,z=a.x+math.max(0,math.min(1,t))*dx,a.z+math.max(0,math.min(1,t))*dz
 return math.sqrt((p.x-x)^2+(p.z-z)^2),t
end
local cleanup
local JarvanIVChampion=class("JarvanIVChampion")
function JarvanIVChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.flags={};self.standardRisks={};self:LoadMenu()
 self.qSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=self.profile.qDelay,Radius=70,Range=770,Speed=math.huge,Collision=false}
 -- Radius 175 is a prediction inset (the area is profile.eRadius); the flag's flight speed is not published and stays the asset figure.
 self.eSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=.25,Radius=175,Range=860,Speed=1450,Collision=false}
 -- Golden Aegis is instant in both profiles: Evade may use it against a hit it cannot dodge.
 local p=self.profile
 self.defenseRegistered,self.defenseReason,self.shieldDefense=Core:RegisterShield({name='JarvanIVW',slot=_W,key=HK_W,profile=p.id,spell=p.w,source=p.source,duration=p.wDuration,delay=p.wDelay,
  ready=function()return self:Ready(_W)end,amount=function()return self:ShieldAmount()end})
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 -- Flash combinations go through the shared Flash follow-up (Core:FlashFollow): Flash after an E+Q landing,
 -- or Flash then R onto a target just beyond R range; one combination at a time, owned cleanup.
 self.flashCombo=Core:FlashFollow('JarvanIVFlash')
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
 Core:RegisterCleanup('jarvan_sequences',function(reason)cleanup(self,reason)end)
 -- No combat scans are registered as optional work. This job copies completed
 -- gameplay previews and expires each snapshot independently.
 self.prepared=Core:RegisterPreparation('jarvan.preview',{intervalMs=100,maxDelayMs=300,units=1,maxUnits=1},function()
  self.preview={at=Game.Timer(),position=point(self.eq and self.eq.position),center=point(self.arena and self.arena.center)};return true
 end,function()return Menu.Draw.Plan:Value()end,function()self.preview=nil end)
end
function JarvanIVChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Jarvan IV'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','E','W'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu[mode]:MenuElement({id='EQ',name='Use the E+Q dash onto the target',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R (leaps onto the target)',value=true})
 Menu.Combo:MenuElement({id='RHP',name='R when the target is below health %',value=35,min=0,max=100,step=5})
 Menu.Combo:MenuElement({id='RCount',name='Or when R traps at least this many',value=2,min=1,max=5,step=1})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=kind,name=kind=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  for _,slot in ipairs({'Q','E','W'})do Menu.Clear[kind]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions an ability must hit',value=3,min=1,max=8,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack would miss',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='FleeEQ',name='Flee: E+Q toward the cursor',value=true})
 Menu.Misc:MenuElement({id='Flash',name='Flash to extend E+Q or R onto a target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='WCount',name='W with this many enemies in its range',value=1,min=1,max=5,step=1,menu=false})
 Menu.Misc:MenuElement({id='EngageHP',name='Never dash in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='Enemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Q',name='Q range',value=false})
 Menu.Draw:MenuElement({id='E',name='E range',value=false})
 Menu.Draw:MenuElement({id='R',name='R range',value=false})
 Menu.Draw:MenuElement({id='Plan',name='E+Q landing spot and R arena',value=true})
end
function JarvanIVChampion:Mana(node)return Core.manaAbove(node:Value())end
function JarvanIVChampion:Ready(slot,recast)
 local d=myHero:GetSpellData(slot);local name=slot==_Q and self.profile.q or slot==_W and self.profile.w or slot==_E and self.profile.e or self.profile.r
 if not d or d.name~=name or not finite(d.level)or d.level<1 or d.currentCd~=0 or Game.CanUseSpell(slot)~=0 then return false end
 if slot==_R and d.toggleState~=(recast and 2 or 1)then return false end
 return recast or finite(d.mana)and d.mana>=0 and d.mana<=myHero.mana
end
function JarvanIVChampion:Reach(u,range)return IsValid(u)and point(u.pos)and GetDistance(u.pos,myHero.pos)<=range end
-- Landing legality: walkable and outside enemy turret range.
function JarvanIVChampion:Legal(pos)
 return point(pos)and type(Game.isWall)=='function'and Game.isWall(pos)==false and not IsUnderTurret2(pos)
end
function JarvanIVChampion:Healthy()
 return myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.EngageHP:Value()
end
-- Legal landing plus dive risk: at most Misc.Enemies enemies within 600 and, for an engage, the health limit.
function JarvanIVChampion:Safe(pos,offense)
 if not self:Legal(pos)then return false end
 if GetEnemyCount(600,pos)>Menu.Misc.Enemies:Value()then return false end
 return not offense or self:Healthy()
end
function JarvanIVChampion:OwnedBuff(u,name)
 if not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 or u.buffCount%1~=0 then return nil end
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and b.name==name and finite(b.count)and b.count>0 then
   local expiry=Core.buffExpiry(b)
   local known=b.source~=nil and b.source~=0 or b.sourcenID~=nil and b.sourcenID~=0
   local sourceOK=(b.source==nil or b.source==0 or own(b.source))and(b.sourcenID==nil or b.sourcenID==0 or own(b.sourcenID))
   if finite(expiry)and expiry>Game.Timer()and finite(b.startTime)and b.startTime<=Game.Timer()and known and sourceOK then return b,expiry end
  end
 end
end
function JarvanIVChampion:Flag(u)
 if not u or u.team~=myHero.team or u.dead or u.valid==false or not id(u)or not point(u.pos)then return nil end
 local b,expiry=self:OwnedBuff(u,self.profile.e)
 if b then return expiry end
 -- Classic has no established standard object alias. Its own live E buff is
 -- required, rather than inventing Jade_JarvanIVStandard from the normal name.
 if self.profile.flagName and type(u.charName)=='string'and u.charName:lower()==self.profile.flagName and own(u.owner)then
  local expires=Core.buffExpiry(u)
  if finite(expires)and expires>Game.Timer()then return expires end
 end
end
function JarvanIVChampion:DiscoverFlags()
 -- One full scan per decision evaluation; validation (no scope) always rescans.
 local rows=Core:DecisionValue('JarvanIV.flags',function()local rows={};if Game.MinionCount and Game.Minion then
  for i=1,math.min(Game.MinionCount(),512)do local u=Game.Minion(i);local expiry=self:Flag(u)
   if expiry and #rows<8 then rows[#rows+1]={object=u,id=id(u),handle=u.handle,expires=expiry}end
  end
 end;return rows end)
 self.flags=rows;return rows
end
function JarvanIVChampion:FlagValid(row)return row and id(row.object)==row.id and row.object.handle==row.handle and self:Flag(row.object)~=nil end
function JarvanIVChampion:StandardRisk(position,action)
 -- A possibly spent E can create an unenumerated flag. Retain bounded evidence
 -- separately from input jobs; no timer invents that flag's expiry.
 if #self.standardRisks>=8 then self.standardRiskUnknown=true;return nil end
 local risk={position=point(position),action=action,started=Game.Timer()};self.standardRisks[#self.standardRisks+1]=risk;return risk
end
function JarvanIVChampion:RefreshStandards(rows)
 local a=myHero.activeSpell
 if a and a.valid and not a.isStopped and a.name==self.profile.e and finite(a.startTime)and a.startTime<=Game.Timer()and a.startTime~=self.lastStandardCast
  and point(a.placementPos or a.endPos)then
  self.lastStandardCast=a.startTime;local found
  for _,risk in ipairs(self.standardRisks)do if risk.action and a.startTime>=risk.started then
   local r=Core.adapter:Poll(risk.action)
   if r and r.sentAt and not r.interrupted and r.state~='send_uncertain'and GetDistance(risk.position,a.placementPos or a.endPos)<=80 then found=risk end
  end end
  if not found then found=self:StandardRisk(a.placementPos or a.endPos);if found then found.started=a.startTime end end
  if found then found.position=point(a.placementPos or a.endPos);found.attempted=true;found.placementKnown=true end
 end
 for i=#self.standardRisks,1,-1 do local risk=self.standardRisks[i]
  if risk.action and not risk.attempted then local r=Core.adapter:Poll(risk.action)
   if r and(r.sentAt or r.state=='send_uncertain')then risk.attempted=true
   elseif not r or r.jobCancelled or r.state=='cancelled_before_send'then table.remove(self.standardRisks,i);risk=nil end
  end
  if risk then
   for _,row in ipairs(rows)do local b=self:OwnedBuff(row.object,self.profile.e)
    if b and finite(b.startTime)and b.startTime>=risk.started and GetDistance(row.object.pos,risk.position)<=80 then
     risk.flag=row;risk.expires=row.expires;risk.placementKnown=true;risk.position=point(row.object.pos)
    end
   end
   if risk.expires and risk.expires<=Game.Timer()then table.remove(self.standardRisks,i)end
  end
 end
end
-- `own` is the sequence's own flag request: its observed placement is the intended dash, not a risk.
function JarvanIVChampion:DashOnRay(pos,allowed,own)
 local rows=self:DiscoverFlags();self:RefreshStandards(rows)
 if self.standardRiskUnknown then return true end
 for _,risk in ipairs(self.standardRisks)do if risk.attempted and risk~=own then
  local matching=allowed and risk.flag and risk.flag.id==allowed.id
  if not matching then
   if not risk.placementKnown then return true end
   local d,t=segment(risk.position,myHero.pos,pos);if d<=150 and t>=0 and t<=1.08 then return true end
  end
 end end
 for _,row in ipairs(rows)do local d,t=segment(row.object.pos,myHero.pos,pos)
  if d<=70 and t>=0 and t<=1.08 and row~=allowed and(not allowed or row.id~=allowed.id)then return true end
 end
 return false
end
function JarvanIVChampion:UnconfirmedE()
 self:RefreshStandards(self:DiscoverFlags())
 if self.standardRiskUnknown then return true end
 for _,risk in ipairs(self.standardRisks)do if risk.action and not risk.flag then
  local r=Core.adapter:Poll(risk.action);if r and r.state=='send_uncertain'then return true end
 end end
 return false
end
function JarvanIVChampion:Predict(slot,target)
 local pred=Core:Prediction(slot==_Q and self.qSpell or self.eSpell);pred:GetPrediction(target,myHero)
 if pred:CanHit(target.type==Obj_AI_Hero and OrbamaPrediction.HITCHANCE_HIGH or OrbamaPrediction.HITCHANCE_NORMAL)then return pred.CastPosition end
end
-- aim/reaim: an explicit aim (lane clear) and its fresh recomputation at dispatch instead of the target's prediction.
function JarvanIVChampion:CastSkill(slot,target,context,permission,aim,reaim)
 if not self:Ready(slot)or slot==_E and self:UnconfirmedE()or not self:Reach(target,slot==_Q and 770 or 860)then return false end
 local pos=aim or self:Predict(slot,target);if not pos or slot==_Q and self:DashOnRay(pos)then return false end
 local key=slot==_Q and HK_Q or HK_E;local targetID,targetHandle=id(target),target.handle
 local risk
 local ok=Core:Cast(key,pos,{intentTarget=target,context=context,prevalidateWorldCast=true,
  resolve=reaim and function()local at=reaim();if not at then return nil,'aim_lost'end;return {position=at}end or nil,
  observe=slot==_E and function(q)local a=Core:NativeCast(q,self.profile.e);return a and point(a.placementPos or a.endPos)end or nil,
  validate=function(_,resolved)local aim=resolved and resolved.position or pos
   return self:Ready(slot)and id(target)==targetID and target.handle==targetHandle and self:Reach(target,slot==_Q and 770 or 860)and(not permission or permission(aim))
    and(slot~=_Q or not self:DashOnRay(aim))end})
 if ok and slot==_E then
  risk=self:StandardRisk(pos,Core.lastIntent.id)
  Core:AfterCast(HK_E,function()if risk then local a=myHero.activeSpell;risk.position=point(a.placementPos or a.endPos);risk.attempted=true;risk.placementKnown=true end end)
 end
 return ok
end
function JarvanIVChampion:BeginEQ(goal,target,context,permission,offense)
 if self.eq or not point(goal)or not self:Ready(_Q)or not permission()then return false end
 local aim=myHero.pos:Extended(goal,math.min(self.profile.eqReach,GetDistance(goal,myHero.pos)))
 if GetDistance(aim,myHero.pos)<150 or not self:Safe(aim,offense)then return false end
 local p={position=aim,target=target,targetID=id(target),targetHandle=target and target.handle,context=context,permission=permission,
  offense=offense,started=Game.Timer(),expires=Game.Timer()+1.8,origin=point(myHero.pos),before={}}
 local rows=self:DiscoverFlags();local best
 for _,row in ipairs(rows)do p.before[row.id]=true
  if GetDistance(row.object.pos,myHero.pos)<=770 and GetDistance(row.object.pos,goal)<GetDistance(myHero.pos,goal)-100
   and self:Safe(row.object.pos,offense)and(not best or GetDistance(row.object.pos,goal)<GetDistance(best.object.pos,goal))then best=row end
 end
 self.eq=p
 if best then p.flag=best;p.position=point(best.object.pos);p.eObserved=true;return true end
 if not self:Ready(_E)or self:UnconfirmedE()or myHero.mana<myHero:GetSpellData(_Q).mana+myHero:GetSpellData(_E).mana then self.eq=nil;return false end
 local ok=Core:Cast(HK_E,aim,{owner='EQ',intentTarget=target,context=context,independent=false,prevalidateWorldCast=true,
  resolve=function()return {position=p.position}end,
  observe=function(q)local a=Core:NativeCast(q,self.profile.e);return a and point(a.placementPos or a.endPos)
   and GetDistance(a.placementPos or a.endPos,p.position)<=80 end,
  validate=function()return self.eq==p and permission()and self:Ready(_Q)and self:Ready(_E)
   and myHero.mana>=myHero:GetSpellData(_Q).mana+myHero:GetSpellData(_E).mana and self:Safe(p.position,offense)
   and(not target or self:Reach(target,770))end})
 if not ok then self.eq=nil;return false end
 p.eAction=Core.lastIntent.id;p.risk=self:StandardRisk(aim,p.eAction)
 Core:AfterCast(HK_E,function(q)if self.eq==p then
  local native=Core:NativeCast(q,self.profile.e)
  p.eObserved=true;p.eAt=Game.Timer();p.eStart=native and native.startTime or q.observationGameTime
  -- The native cast names where the flag lands: Q may follow at once (fast path), no flag object needed yet.
  p.placement=native and point(native.placementPos or native.endPos)or nil
  if p.placement and GetDistance(p.placement,p.position)>80 then p.placement=nil end
  if p.risk then p.risk.attempted=true;p.risk.placementKnown=true end
 end end)
 return true
end
function JarvanIVChampion:CancelEQ(reason)
 local p=self.eq;if p then for _,key in ipairs({'eAction','qAction'})do if p[key]then Core.adapter:Cancel(p[key],reason)end end end
 self.eq=nil
end
function JarvanIVChampion:EQValid(p)
 return self.eq==p and p.expires>Game.Timer()and Core:Available()and p.permission()
  and Core.adapter:ContextValid({context=p.context},'continuation')
  and(not p.target or id(p.target)==p.targetID and p.target.handle==p.targetHandle and self:Reach(p.target,1000))
end
function JarvanIVChampion:ContinueEQ()
 local p=self.eq;if not p then return false end
 if not self:EQValid(p)then self:CancelEQ('eq_context_ended');return false end
 for _,key in ipairs({'eAction','qAction'})do if p[key]and not(p.eObserved and key=='eAction'or p.qObserved and key=='qAction')then
  local r=Core.adapter:Poll(p[key]);if not r or r.jobCancelled or r.state=='cancelled_before_send'or r.state=='send_uncertain'then self:CancelEQ('eq_input_unconfirmed');return false end
 end end
 if not p.eObserved then return true end
 if not p.flag then
  for _,row in ipairs(self:DiscoverFlags())do local b=self:OwnedBuff(row.object,self.profile.e)
   if not p.before[row.id]and GetDistance(row.object.pos,p.position)<=80 and b and finite(b.startTime)and b.startTime>=p.eStart then p.flag=row;break end
  end
 end
 -- Fast path: the flag cast was observed with its native placement, so the geometry is fixed and Q (0.4 s
 -- cast) follows without waiting for the flag object and its buff. It is one Q request per sequence; an
 -- unconfirmed E never gets here, and half a second after the cast only a discovered own flag still counts.
 local function fast()return p.placement~=nil and p.eAt~=nil and Game.Timer()-p.eAt<=.5 end
 if p.flag then
  if not self:FlagValid(p.flag)then self:CancelEQ('flag_lost');return false end
  p.position=point(p.flag.object.pos)
 elseif p.qAction or fast()then p.position=p.placement
 else return true end
 local function spot()
  if p.flag then return self:FlagValid(p.flag)and point(p.flag.object.pos)or nil end
  return fast()and p.placement or nil
 end
 if p.qObserved then
  -- The sequence holds the whole tick. Once Q is observed it ends when the
  -- dash is over, wherever it ended, or 0.4 s after the cast when no dash was
  -- seen (a Q that missed the flag does not dash). Only an arrival at the flag
  -- is a landing for the Flash follow-up. It used to wait for a dash ending
  -- within 120 units of the flag and otherwise ran to the 1.8 s expiry.
  local path=myHero.pathing;local dashing=path and path.isDashing==true;p.qAt=p.qAt or Game.Timer()
  if dashing then p.dashObserved=true;return true end
  if p.dashObserved or Game.Timer()-p.qAt>.4 then
   if p.dashObserved and GetDistance(myHero.pos,p.position)<=120 then self.landed={at=Game.Timer(),position=point(myHero.pos),context=p.context}end
   -- Development evidence for the real Q-to-flag reach (JarvanIV-2): flag distance and where the dash ended.
   Core:Trace('jarvan_eq_reach',{profile=self.profile.id,flagDistance=GetDistance(p.origin,p.position),planned=self.profile.eqReach,
    dashed=p.dashObserved==true,landingError=GetDistance(myHero.pos,p.position)})
   self.eq=nil;return false
  end
  return true
 end
 if p.qAction then return true end
 if not self:Ready(_Q)or not self:Safe(p.position,p.offense)or GetDistance(p.position,myHero.pos)>770 then return true end
 -- Offensive continuation requires the current target on the same outgoing ray.
 local function legal()
  local at=spot()
  if not at or not self:EQValid(p)or not self:Ready(_Q)or not self:Safe(at,p.offense)or GetDistance(at,myHero.pos)>770 then return false end
  if p.target then local pred=self:Predict(_Q,p.target);if not pred then return false end
   local d,t=segment(pred,myHero.pos,at);if d>70+(p.target.boundingRadius or 0)or t<0 or t>1.08 then return false end
  end
  return not self:DashOnRay(at,p.flag,p.risk)
 end
 if not legal()then return true end
 local ok=Core:Cast(HK_Q,p.position,{owner='EQ',intentTarget=p.target,context=p.context,independent=false,prevalidateWorldCast=true,
  resolve=function()local at=spot();if not at then return nil,'flag_lost'end;return {position=at}end,
  validate=function()return legal()end,
  observe=function(q)local a=Core:NativeCast(q,self.profile.q);return a and point(a.placementPos or a.endPos)
   and GetDistance(a.placementPos or a.endPos,p.position)<=80 end})
 if ok then p.qAction=Core.lastIntent.id;Core:AfterCast(HK_Q,function()if self.eq==p then p.qObserved=true end end)end
 return true
end
function JarvanIVChampion:WUseful(target,flee,jungle)
 if not self:Ready(_W)or not self:Reach(target,self.profile.wRange)then return false end
 return flee or jungle or GetEnemyCount(self.profile.wRange,myHero.pos)>=Menu.Misc.WCount:Value()
end
-- Shield for the Evade offer: the profile's base plus what it states per enemy champion in the area.
function JarvanIVChampion:ShieldAmount()
 local p=self.profile;local rank=myHero:GetSpellData(_W).level;local base=p.wShield[rank];if not base then return 0 end
 local n=#Core:Rows('hero',p.wRange)
 if p.wShieldPerChampion then return base+p.wShieldPerChampion[rank]*n end
 if not finite(myHero.bonusDamage)or not finite(myHero.maxHealth)then return base end
 return base+p.wShieldAD*math.max(0,myHero.bonusDamage)+p.wShieldHealthPerChampion*myHero.maxHealth*n
end
function JarvanIVChampion:CastW(target,context,permission,flee,jungle)
 if not self:WUseful(target,flee,jungle)then return false end
 return Core:Cast(HK_W,nil,{intentTarget=target,context=context,validate=function()return permission()and self:WUseful(target,flee,jungle)end})
end
function JarvanIVChampion:EDamage(u)
 local base=self.profile.eBase[myHero:GetSpellData(_E).level]
 if not base or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.eAP*myHero.ap)
end
function JarvanIVChampion:RDamage(u)
 local base=self.profile.rBase[myHero:GetSpellData(_R).level]
 if not base or not finite(myHero.bonusDamage)or myHero.bonusDamage<0 then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,base+self.profile.rAD*myHero.bonusDamage)
end
-- The shared kill rule for each ability at its own impact time (Q cast, E cast and flight, R leap).
function JarvanIVChampion:Kills(slot,u)
 if not IsValid(u)or u.type~=Obj_AI_Hero or IsInvulnerable(u)then return false end
 if slot==_Q then return(Core:Lethal(u,self.qSpell.Delay,function()return self:QDamage(u)end,{kind='physical'}))end
 if slot==_E then return(Core:Lethal(u,self.eSpell.Delay+GetDistance(u.pos,myHero.pos)/self.eSpell.Speed,function()return self:EDamage(u)end,{kind='magical'}))end
 return(Core:Lethal(u,self.profile.rLeap,function()return self:RDamage(u)end,{kind='physical'}))
end
-- Enemies the arena around `center` traps, and how many more stand within 600 outside it.
function JarvanIVChampion:ArenaSplit(center)
 local trapped,free={},0;local enemies=Core:DecisionUnits('GetEnemyHeroes')
 for i=1,math.min(#enemies,5)do local u=enemies[i]
  if IsValid(u)and point(u.pos)then local d=GetDistance(u.pos,center)
   if d<=self.profile.rArena+(u.boundingRadius or 0)then trapped[#trapped+1]=u elseif d<=600 then free=free+1 end
  end
 end
 return trapped,free
end
-- R in Combo: a kill, a trapped group or a low target. Without a mode key (finish=true): only the kill.
-- Trapped enemies are the point of the cast: the enemy limit counts only those left outside the arena, and a
-- kill ignores the own-health limit. A low target alone keeps the full engage limits. `origin` is where Jarvan
-- casts from (a Flash landing), default his position.
function JarvanIVChampion:RWanted(target,finish,origin)
 origin=origin or myHero.pos
 if not Menu.Combo.R:Value()or not IsValid(target)or not point(target.pos)or GetDistance(target.pos,origin)>self.profile.rRange
  or myHero.pathing and myHero.pathing.isDashing or not self:Legal(target.pos)then return false end
 local trapped,free=self:ArenaSplit(target.pos);local cap=Menu.Misc.Enemies:Value()
 local worth,why=Core:UltimateWorth({hits=trapped,minimum=finish and 0 or Menu.Combo.RCount:Value(),impact=self.profile.rLeap,
  kills=function(u)return u==target and self:Kills(_R,u)end})
 if worth and why=='kill'then return free<=cap end
 if finish then return false end
 if worth and why=='count'then return free<=cap and self:Healthy()end
 return target.maxHealth>0 and target.health/target.maxHealth*100<=Menu.Combo.RHP:Value()and self:Safe(target.pos,true)
end
function JarvanIVChampion:BeginR(target,context,finish)
 if self.arena or self.eq or not self:Ready(_R)or not self:RWanted(target,finish)then return false end
 local p={target=target,id=id(target),handle=target.handle,context=context,expires=Game.Timer()+4.5};self.arena=p
 local ok=Core:Cast(HK_R,target,{owner='Cataclysm',range=650,context=context,
  observe=function(q)local a=Core:NativeCast(q,self.profile.r);local b=self:OwnedBuff(myHero,self.profile.r)
   return a and(a.target==p.id or a.target==p.handle)and point(a.placementPos or a.endPos)
    and b and finite(b.startTime)and b.startTime>=q.observationGameTime end,
  validate=function()return self.arena==p and self:Ready(_R)and self:RWanted(target,finish)end})
 if not ok then self.arena=nil;return false end
 p.action=Core.lastIntent.id;Core:AfterCast(HK_R,function(q)if self.arena==p then
  local a=myHero.activeSpell;p.center=point(a.placementPos or a.endPos);p.observed=true;p.started=q.requestGameTime end end);return true
end
function JarvanIVChampion:ArenaStage(p)
 local b,expiry=self:OwnedBuff(myHero,self.profile.r)
 return p and p.observed and p.center and b and finite(b.startTime)and b.startTime>=p.started
  and expiry>Game.Timer()and self:Ready(_R,true)
end
function JarvanIVChampion:ArenaEmpty(p)
 -- Hidden living champions make occupancy unknown. Current Jarvan position is
 -- never substituted for the observed arena center.
 if type(Game.HeroCount)~='function'or type(Game.Hero)~='function'then return false end
 local count=Game.HeroCount();if not finite(count)or count>16 then return false end
 for i=1,count do local u=Game.Hero(i)
  if not u then return false end
  if u.team~=myHero.team and not u.dead then if not u.visible or not point(u.pos)then return false end
   if GetDistance(u.pos,p.center)<=400+(u.boundingRadius or 0)then return false end
  end
 end
 return true
end
function JarvanIVChampion:ContinueArena()
 local p=self.arena;if not p then return false end
 if p.expires<=Game.Timer()or not Core:Available()then self:ClearArena('arena_ended');return false end
 if not p.observed then local r=Core.adapter:Poll(p.action)
  if not r or r.jobCancelled or r.state=='cancelled_before_send'or r.state=='send_uncertain'
   or not Core.adapter:ContextValid({context=p.context},'continuation')then self:ClearArena('r_unconfirmed')end
  return false
 end
 if not self:ArenaStage(p)then self:ClearArena('arena_stage_ended');return false end
 if p.release then return false end
 local empty=self:ArenaEmpty(p)
 if empty then p.emptySince=p.emptySince or Game.Timer()else p.emptySince=nil end
 if not(empty and Game.Timer()-p.emptySince>=.15)then return false end
 local ok=Core:Cast(HK_R,nil,{owner='CataclysmRelease',context={condition=function()return self.arena==p end},
  validate=function()return self.arena==p and self:ArenaStage(p)and self:ArenaEmpty(p)end,
  observe=function(q)return myHero:GetSpellData(_R).toggleState~=q.toggleState and not self:OwnedBuff(myHero,self.profile.r)end})
 if ok then p.release=Core.lastIntent.id end;return ok
end
function JarvanIVChampion:ClearArena(reason)
 local p=self.arena;if p then if p.action then Core.adapter:Cancel(p.action,reason)end;if p.release then Core.adapter:Cancel(p.release,reason)end end
 self.arena=nil
end
function JarvanIVChampion:Combat(mode)
 local node=Menu[mode];if not self:Mana(node.Mana)then return false end
 local target=GetTarget(860);if not IsValid(target)then return false end
 local context=Core:ModeContext(mode);local function allow(slot)return node[slot]:Value()and self:Mana(node.Mana)end
 if node.W:Value()and self:CastW(target,context,function()return allow('W')end)then return true end
 if mode=='Combo'and self:BeginR(target,context)then return true end
 if node.EQ:Value()and not self.eq then local pos=self:Predict(_E,target)
  if pos then
   -- The flag goes behind the target so the Q line and the dash pass through it and knock it up; a spot
   -- behind that fails the landing check falls back to the predicted position itself.
   local behind=self:Behind(pos,target)
   if behind and self:BeginEQ(behind,target,context,function()return allow('EQ')end,true)then return true end
   if self:BeginEQ(pos,target,context,function()return allow('EQ')end,true)then return true end
  end
 end
 -- Q and E are kept for the dash while the other half is ready or about to be; alone they are spent when
 -- the dash is off, not allowed at this health, the other half is more than 2 s away, or Q kills.
 local together=node.EQ:Value()and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.EngageHP:Value()
 local function waits(slot)local d=myHero:GetSpellData(slot);return together and d and finite(d.level)and d.level>0 and finite(d.currentCd)and d.currentCd<=2 end
 if node.Q:Value()and(not waits(_E)or self:Kills(_Q,target))and self:CastSkill(_Q,target,context,function()return allow('Q')and(not waits(_E)or self:Kills(_Q,target))end)then return true end
 if node.E:Value()and not waits(_Q)then return self:CastSkill(_E,target,context,function()return allow('E')and not waits(_Q)end)end
end
-- A point past the predicted target on the line from Jarvan: about 100 when it stands or comes closer,
-- about 200 when it walks away, never past the planned E+Q reach (profile eqReach).
function JarvanIVChampion:Behind(pos,target)
 local reach=self.profile.eqReach;local d=GetDistance(pos,myHero.pos);if d<1 or d>=reach then return nil end
 local path=target.pathing;local goal=path and path.hasMovePath and(path.endPos or target.posTo)
 local away=goal and finite(goal.x)and finite(goal.z)and GetDistance(goal,myHero.pos)>GetDistance(target.pos,myHero.pos)+25
 return myHero.pos:Extended(pos,math.min(reach,d+(away and 200 or 100)))
end
-- A killable enemy is finished without a mode key: Q, then E, then R (R inside its own switch and limits).
function JarvanIVChampion:Finishers()
 if self.eq or self.arena then return false end
 local q,e,r=self:Ready(_Q),self:Ready(_E),self:Ready(_R)and Menu.Combo.R:Value();if not(q or e or r)then return false end
 local rows=Core:Rows('hero',860);local context={priority='interactive'}
 for i=1,math.min(#rows,5)do local u=rows[i]
  if q and self:Kills(_Q,u)and self:CastSkill(_Q,u,context,function()return self:Kills(_Q,u)end)then return true end
  if e and self:Kills(_E,u)and self:CastSkill(_E,u,context,function()return self:Kills(_E,u)end)then return true end
 end
 for i=1,math.min(#rows,5)do local u=rows[i]
  if r and not(q and self:Kills(_Q,u))and not(e and self:Kills(_E,u))and self:BeginR(u,context,true)then return true end
 end
 return false
end
function JarvanIVChampion:Combo()return self:Combat('Combo')end
function JarvanIVChampion:Harass()return self:Combat('Harass')end
function JarvanIVChampion:FarmList(jungle,range)
 local source=jungle and _G.SDK.ObjectManager:GetMonsters(range)or _G.SDK.ObjectManager:GetEnemyMinions(range);local list={}
 for i=1,math.min(#source,jungle and 12 or 40)do local u=source[i]
  if self:Reach(u,range)and(u.team==300)==jungle and u.team~=myHero.team then list[#list+1]=u end
 end
 return list
end
function JarvanIVChampion:FarmHits(slot,pos,jungle)
 local n=0;for _,u in ipairs(self:FarmList(jungle,860))do
  if slot==_Q then local d,t=segment(u.pos,myHero.pos,pos);if d<=70+(u.boundingRadius or 0)and t>=0 and t<=1 then n=n+1 end
  elseif GetDistance(u.pos,pos)<=175 then n=n+1 end
 end;return n
end
-- Lane clear aim (JarvanIV-3): the line or circle over the predicted positions of up to 12 nearest lane
-- minions (Core:BestAim: every point and pairwise midpoint) that hits the most, a kill counting half a hit
-- more. Returns aim, a hit minion and the hit count. One minion list per evaluation.
function JarvanIVChampion:LaneAim(slot,list)
 local near={}
 for i=1,#list do near[i]=list[i]end
 table.sort(near,function(a,b)return GetDistance(a.pos,myHero.pos)<GetDistance(b.pos,myHero.pos)end)
 local points={}
 for i=1,math.min(#near,12)do local u=near[i];local pos=self:Predict(slot,u)
  if pos then
   local kills=slot==_Q and Core:Lethal(u,self.qSpell.Delay,function()return self:QDamage(u)end)
    or slot==_E and Core:Lethal(u,self.eSpell.Delay+GetDistance(u.pos,myHero.pos)/self.eSpell.Speed,function()return self:EDamage(u)end)
   points[#points+1]={x=pos.x,z=pos.z,unit=u,radius=u.boundingRadius or 0,weight=kills==true and 1.5 or 1}
  end
 end
 if #points==0 then return nil end
 local shape=slot==_Q and {kind='line',width=140,range=770}or {kind='circle',radius=175,range=860}
 local aim,_,hits=Core:BestAim(points,shape)
 if not aim then return nil end
 local pos=Vector(aim.x,myHero.pos.y,aim.z)
 if slot==_Q then pos=myHero.pos:Extended(pos,770)end
 return pos,points[hits[1]].unit,#hits
end
function JarvanIVChampion:Clear(kind)
 if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()then return false end
 local jungle=kind=='jungle';local node=Menu.Clear[jungle and 'JungleClear'or 'LaneClear'];if not self:Mana(node.Mana)then return false end
 local list=self:FarmList(jungle,860);local target
 if not jungle then
  local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
  local count=Menu.Clear.LaneClear.Count:Value()
  for _,slot in ipairs({_Q,_E})do local name=slot==_Q and 'Q'or 'E'
   if node[name]:Value()and self:Ready(slot)then
    local aim,unit,hits=self:LaneAim(slot,list)
    if aim and hits>=count and self:FarmHits(slot,aim,false)>=count
     and self:CastSkill(slot,unit,context,function(at)
      return node[name]:Value()and self:Mana(node.Mana)and Menu.Clear.SpellFarm:Value()and at~=nil and self:FarmHits(slot,at,false)>=count end,aim,
      function()local at,_,n=self:LaneAim(slot,self:FarmList(false,860));return n and n>=count and at or nil end)then return true end
   end
  end
  return false
 end
 for _,u in ipairs(list)do if not target or u.maxHealth>target.maxHealth then target=u end end
 if not target then return false end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 local function permitted(slot)return node[slot]:Value()and self:Mana(node.Mana)and Menu.Clear.SpellFarm:Value()end
 if jungle and node.W:Value()and self:CastW(target,context,function()return permitted('W')end,false,true)then return true end
 for _,slot in ipairs({_Q,_E})do local name=slot==_Q and 'Q'or 'E'
  if permitted(name)and self:Ready(slot)then local pos=self:Predict(slot,target)
   if pos and(jungle or self:FarmHits(slot,pos,false)>=Menu.Clear.LaneClear.Count:Value())then
    if self:CastSkill(slot,target,context,function(aim)
     if not permitted(name)then return false end
     return aim and(jungle or self:FarmHits(slot,aim,false)>=Menu.Clear.LaneClear.Count:Value())end)then return true end
   end
  end
 end
 return false
end
function JarvanIVChampion:LaneClear()return self:Clear('lane')end
function JarvanIVChampion:JungleClear()return self:Clear('jungle')end
-- Health-bar damage (shared overlay): ready Q, E and R plus one attack.
function JarvanIVChampion:ComboDamage(u)
 local total=0
 if self:Ready(_Q)then total=total+self:QDamage(u)end
 if self:Ready(_E)then total=total+self:EDamage(u)end
 if self:Ready(_R)then total=total+self:RDamage(u)end
 local ok,attack=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
 if ok and finite(attack)then total=total+attack end
 return total
end
function JarvanIVChampion:QDamage(u)
 local rank=myHero:GetSpellData(_Q).level;local base=self.profile.qBase[rank]
 if not base or not finite(myHero.bonusDamage)or myHero.bonusDamage<0 then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,base+self.profile.qAD*myHero.bonusDamage)
end
function JarvanIVChampion:Rescue(u)
 if not self:Reach(u,770)or u.team==300 or u.team==myHero.team then return false end
 -- Shared last-hit rule in its 'ready' form (an attack that is ready, in range and lethal keeps the minion).
 return Core:Rescue(u,self.qSpell.Delay,function()return self:QDamage(u)end,{attack='ready'})
end
function JarvanIVChampion:LastHit()
 if not Menu.LastHit.Q:Value()or not self:Mana(Menu.LastHit.Mana)or not self:Ready(_Q)then return false end
 local best;for _,u in ipairs(self:FarmList(false,770))do if self:Rescue(u)and(not best or u.maxHealth>best.maxHealth)then best=u end end
 if not best then return false end
 return self:CastSkill(_Q,best,Core:ModeContext('LastHit'),function()
  return Menu.LastHit.Q:Value()and self:Mana(Menu.LastHit.Mana)and self:Rescue(best)end)
end
function JarvanIVChampion:HeldEQ()
 if not Menu.Misc.FleeEQ:Value()or self.gestureUsed then return false end
 local function permission()return Menu.Misc.FleeEQ:Value()and GetMode()=='Flee'end
 if self:BeginEQ(mousePos,nil,Core:ModeContext('Flee'),permission,false)then self.gestureUsed=true;return true end
 return false
end
function JarvanIVChampion:Flee()
 if self:HeldEQ()then return true end
 -- Slowing a chaser while fleeing has no downside: no switch.
 local target=GetTarget(self.profile.wRange)
 if IsValid(target)then return self:CastW(target,Core:ModeContext('Flee'),function()return true end,true)end
end
-- One Flash combination per press of the Flash bind, through Core:FlashFollow (flash_first):
--  * within 1 s after an observed E+Q landing: Flash toward the cursor, landing legal and inside the dive limits;
--  * otherwise Flash toward a target just beyond R range when R is wanted from the landing, then R on it.
-- Consent, landing and the R reason are rechecked at every step; nothing is replayed.
function JarvanIVChampion:FlashAssist()
 local status,why=Core:FlashStatus();if not status then return false,why end
 local function authorized()return Core:Available()and Menu.Misc.Flash:Value()end
 if self.flashCombo:Busy()or self.flashUsed or not authorized()then return false end
 local landing=self.landed
 if landing and Game.Timer()-landing.at<=1 and Core.adapter:ContextValid({context=landing.context},'continuation')then
  local goal=point(mousePos);if not goal or GetDistance(goal,myHero.pos)<100 then return false end
  local ok,reason=self.flashCombo:Start{order='flash_first',aim=goal,authorized=authorized,ttl=.6,
   valid=function(at)return not(myHero.pathing and myHero.pathing.isDashing)and self:Safe(at,false)end,
   follow=function()return false end}
  if ok then self.flashUsed=true end;return ok,reason
 end
 if not Menu.Combo.R:Value()or not self:Ready(_R)or myHero.mana<status.cost+(myHero:GetSpellData(_R).mana or 0)then return false end
 local target=GetTarget(self.profile.rRange+status.range)
 if not IsValid(target)or GetDistance(target.pos,myHero.pos)<=self.profile.rRange then return false end
 local aim=myHero.pos:Extended(target.pos,math.min(status.range,GetDistance(target.pos,myHero.pos)))
 local function valid(at)return IsValid(target)and self:Legal(at)and self:RWanted(target,false,at)end
 if not valid(aim)then return false end
 local ok,reason=self.flashCombo:Start{order='flash_first',aim=aim,authorized=authorized,ttl=1,mana=myHero:GetSpellData(_R).mana or 0,
  valid=valid,follow=function(context)return self:BeginR(target,context)end}
 if ok then self.flashUsed=true end;return ok,reason
end
function JarvanIVChampion:Shutdown(reason)cleanup(self,reason)end
function JarvanIVChampion:Tick()
 if ShouldWait()then self:Shutdown('unavailable');return end
 local mode=GetMode();if mode~='Flee'or not Menu.Misc.FleeEQ:Value()then self.gestureUsed=false end
 if not Menu.Misc.Flash:Value()then self.flashUsed=false end
 local a=myHero.activeSpell
 self:ObserveManualQ(a)
 if a and a.valid and a.name==self.profile.e and a.startTime~=self.lastStandardCast then self:RefreshStandards(self:DiscoverFlags())end
 self:ContinueArena();if self:ContinueEQ()or self.flashCombo:Maintain()or IsCasting()then return end
 if Menu.Misc.Flash:Value()then self:FlashAssist()end
 if self:Finishers()then return end
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if self:LaneClear()then return end;self:JungleClear()
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if not self.prepared then self.preview={at=Game.Timer(),position=point(self.eq and self.eq.position),center=point(self.arena and self.arena.center)}end
end
-- Re-rank mobility_flee (2026-10-10): the sequence never plans a flag beyond eqReach, so its own trace cannot show
-- whether Q still reaches a farther flag. A Q the player casts himself (no sequence running) toward an own flag
-- near its line is recorded with the same trace kind (manual=true): flag distance from the Q origin, whether a
-- dash was seen and the landing error. Development evidence only; it sends nothing and one scan per own Q cast.
function JarvanIVChampion:ObserveManualQ(a)
 local w=self.qWatch
 if w then
  local path=myHero.pathing;local dashing=path and path.isDashing==true;if dashing then w.dashed=true end
  if not dashing and Game.Timer()-w.at>.75 then
   self.qWatch=nil
   Core:Trace('jarvan_eq_reach',{profile=self.profile.id,manual=true,flagDistance=w.distance,planned=self.profile.eqReach,
    dashed=w.dashed==true,landingError=GetDistance(myHero.pos,w.flag)})
  end
  return
 end
 if not a or not a.valid or a.name~=self.profile.q or a.startTime==self.lastManualQ then return end
 self.lastManualQ=a.startTime;if self.eq then return end
 local o=point(myHero.pos);local aim=point(a.placementPos or a.endPos);if not o or not aim then return end
 local dx,dz=aim.x-o.x,aim.z-o.z;local len=math.sqrt(dx*dx+dz*dz);if len<1 then return end;dx,dz=dx/len,dz/len
 local best,off
 for _,row in ipairs(self:DiscoverFlags())do local f=point(row.object.pos)
  if f then local along=(f.x-o.x)*dx+(f.z-o.z)*dz;local side=math.abs((f.x-o.x)*dz-(f.z-o.z)*dx)
   if along>0 and side<=150 and(not off or side<off)then best,off=f,side end
  end
 end
 if best then self.qWatch={at=Game.Timer(),flag=best,distance=GetDistance(o,best)}end
end
function JarvanIVChampion:Draw()
 if myHero.dead then return end
 -- Range circles only while the spell is ready (cheap reads, no preparation).
 if Menu.Draw.Q:Value()and self:Ready(_Q)then Draw.Circle(myHero.pos,770,1,Draw.Color(255,150,220,255))end
 if Menu.Draw.E:Value()and self:Ready(_E)then Draw.Circle(myHero.pos,self.profile.eRange,1,Draw.Color(255,255,220,120))end
 if Menu.Draw.R:Value()and self:Ready(_R)then Draw.Circle(myHero.pos,self.profile.rRange,1,Draw.Color(255,255,120,80))end
 -- Kept up to a second so a late preparation never blinks it, and only while the plan or arena still exists.
 local p=self.preview;if Menu.Draw.Plan:Value()and p and Game.Timer()-p.at<=1 then
  if p.position and self.eq then Draw.Circle(p.position,60,1,Draw.Color(255,150,220,255))end
  if p.center and self.arena then Draw.Circle(p.center,self.profile.rArena,1,Draw.Color(255,255,180,80))end
 end
end
function JarvanIVChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Jarvan IV: modes','Jarvan IV: sequences'},function(page)
  return {title=page==1 and 'Jarvan IV modes'or 'Owned sequences',cards=page==1 and {
   {'MODES','Use the provider binds. Q/E poke, W nearby defense, separate lane/jungle farming and Q rescue follow mana and target preferences.'},
   {'ENGAGE','Combo engages with the E+Q dash, the flag placed just behind the target so the dash knocks it up, and uses R on a kill, a trapped group or a low target; trapped enemies do not count against the enemy limit and a kill ignores the health limit. Q and E are kept for the dash while it is available. A killable enemy is finished with Q, E or R without a mode key. The health and enemy-count limits and landing safety are checked again before the cast.'},
   {'PROFILES','Normal and Classic share the controller. Costs use native spell data; Classic damage and stage names remain separate.'}}or {
   {'FLAG','Flee casts E+Q toward the cursor. Q follows as soon as your flag cast is seen, or once your own flag has appeared, then follows the dash to its landing.'},
   {'ARENA','The arena is dropped once every enemy is visibly outside it. Unseen enemies keep it standing.'},
   {'FLASH','Hold the Flash bind right after an E+Q landing to Flash toward the cursor, or with a target just beyond R range to Flash in and R it when R is wanted from the landing. The Utils Flash service must support the current profile.'}}}
 end)
end
Core:RegisterPolicy({damageTypes={Q='physical',E='magical',R='physical'},methods={
 Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,
 JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
 LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end,
 Finishers=function()return {priority='interactive'}end},
 channel=function()return not Core:SelfChanneling()end,
 costPaid=function(self,q,slot)return slot==_R and self:ArenaStage(self.arena)end,
 validate=function(self,q,slot)
  if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot,slot==_R and self.arena and self.arena.observed)end
  return true
 end})
-- Lexical cleanup remains callable after the family disables wrapped methods.
cleanup=function(self,reason)
 local p=self.eq;if p then for _,key in ipairs({'eAction','qAction'})do if p[key]then Core.adapter:Cancel(p[key],reason)end end end
 p=self.arena;if p then if p.action then Core.adapter:Cancel(p.action,reason)end;if p.release then Core.adapter:Cancel(p.release,reason)end end
 if self.flashCombo then self.flashCombo:Cancel(reason or 'cleanup')end
 self.eq=nil;self.arena=nil;self.flags={};self.standardRisks={};self.standardRiskUnknown=nil;self.preview=nil;self.landed=nil
end
JarvanIVChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_JarvanIV"]="JarvanIV"}
local normalSupported={["JarvanIV"]=true}

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
