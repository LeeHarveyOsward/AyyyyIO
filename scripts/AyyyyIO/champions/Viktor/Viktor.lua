return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Viktor"]=function()return _G.OrbamaFamily:Require("d08c694d1f197b5ae5112519b5e0e26b0182de8044e6fa5f8e2790b8df59e015")()end
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
modules["autojungle"]=_G.OrbamaFamily:Require("7db0b9586a77097bb64895183d25ea6bd8618bd61f03adb899ada4e460e84c92")
modules["combatMechanics"]=_G.OrbamaFamily:Require("9e32908504b1e01599ffc8a55f7d52a3a92a974d794c085ee29160c628b85e38")
modules["gameplay"]=_G.OrbamaFamily:Require("038c846d2b126f3f80142b2c55b4ace9ee78a9347b22cb2f242dcb5ed5185f2f")
modules["prediction"]=(function(require) return _G.OrbamaFamily:Factory("223a065ecf7929552d5f8dafcf2453fd9147cd6e9940ce97dc80add73aa9913b")(require) end)(require)
modules["policies"]=(function(require) return _G.OrbamaFamily:Factory("e26056d70e5dac93ebb21f4ae4fe96863a06915a942bb75b795567a932448a23")(require) end)(require)
modules["core"]=(function(require) return _G.OrbamaFamily:Factory("8b530b74e721ee3a7364f1f753e7578ef7c7843a7dcc77812a526d9dc96147b1")(require) end)(require)
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
if champion=="Viktor" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Viktor',profiles={normal=true,classic=false},
 Create=function(context)
-- Normal kit; current installed assets and dated primary evidence in provenance.
local profiles=ChampionProfiles('Viktor')
local upgrades={viktorqaug='Q',viktorwaug='W',viktoreaug='E',viktorqwaug='QW',viktorqeaug='QE',viktorweaug='WE',viktorqweaug='QWE',viktorqweraug='QWER'}
local finite,id,point,expiry=Core.finite,Core.id,Core.point,Core.buffExpiry
local function owned(o,selfState)
 if not o then return false end;local found=false
 for _,key in ipairs({'source','ownerID','casterID','owner','sourcenID'})do local src=o[key]
  if type(src)=='number'and src~=0 then
   if not finite(src)or(src~=myHero.networkID and src~=myHero.handle)then return false end;found=true
  elseif type(src)=='table'or type(src)=='userdata'then
   if src.networkID and src.networkID~=0 then if src.networkID~=myHero.networkID then return false end;found=true end
   if src.handle and src.handle~=0 then if src.handle~=myHero.handle then return false end;found=true end
  elseif src~=nil and src~=0 then return false end
 end
 if o.sourceName and o.sourceName~=''and o.sourceName~=myHero.charName then return false end
 return found or selfState==true
end
local function ray(a,b,p)local dx,dz=b.x-a.x,b.z-a.z;local len=math.sqrt(dx*dx+dz*dz);if len<1 then return nil end
 return ((p.x-a.x)*dx+(p.z-a.z)*dz)/len,math.abs((p.x-a.x)*dz-(p.z-a.z)*dx)/len,len
end
local spellOnly={attack=false} -- Core:Rescue: the attack is weighed here, by the rule this champion's regressions pin
local function cleanup(self)self.preview=nil;self.qObservation=nil;self.eObservation=nil;self.rObservation=nil;self.storm=nil;self.attackWitness=nil;self.farmJob=nil;self.farmResult=nil;self.particleIndex=1 end
local ViktorChampion=class("ViktorChampion")
function ViktorChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self:LoadMenu();self.particleIndex=1
 local profile=self.profile
 self.WSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=profile.wArm,Radius=profile.wRadius,Range=profile.wRange,Speed=math.huge,Collision=false}
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=.25,Radius=325,Range=700,Speed=math.huge,Collision=false}
 -- The laser as the prediction engine sees it: a line from the chosen start point, not from Viktor.
 local p=self.profile;self.ESpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=p.eDelay,Radius=p.eRadius,Range=p.eLength,Speed=p.eSpeed,Collision=false}
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Viktor',function()cleanup(self)end)
 local ok,why=Core:RegisterPreparation('Viktor.optional',{intervalMs=100,maxDelayMs=350,units=2,maxUnits=2},function()self:PrepareOptional();return true end,
  function()return self:PreviewWanted()or self.rObservation and self.rObservation.observedAt~=nil
   or Menu.Clear.SpellFarm:Value()and(Core:FarmModeEnabled('lane')and Menu.Clear.LaneClear.E:Value()or Core:FarmModeEnabled('jungle')and Menu.Clear.JungleClear.E:Value())end,
  function()self.preview=nil;self.farmJob=nil;self.farmResult=nil end)
 self.preparationFallback=not ok and why=='unsupported'
 -- Evade may ask for the Q shield: Q needs an enemy unit within 600, the shield comes with the cast (profile.shieldSource).
 -- Health-bar damage: the ready Q, E (+ aftershock when augmented), the opening of a ready R and one attack.
 Core:RegisterComboDamage(function(u)
  local d=_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0
  if self:Ready(_Q)then d=d+self:Damage(u,_Q)end
  if self:Ready(_E)then d=d+self:Damage(u,_E)+self:Damage(u,_E,'aftershock')end
  if self:Ready(_R)and myHero:GetSpellData(_R).name==p.r then d=d+self:Damage(u,_R)+2*self:Damage(u,_R,'tick')end
  return d,true
 end)
 self.shieldRegistered,self.shieldReason,self.shieldDefense=Core:RegisterShield({name='ViktorQ',slot=_Q,key=HK_Q,profile=p.id,spell=p.q,source=p.shieldSource,
  amount=function()return self:ShieldFloor()end,duration=p.shieldDuration,delay=p.qDelay,kind='object',
  ready=function()return self:Ready(_Q)and not self.qObservation and self:ShieldTarget()~=nil end,target=function()return self:ShieldTarget()end})
end
-- The unit a shield Q is thrown at: a champion first (it also deals its damage), else a minion, else a monster.
function ViktorChampion:ShieldTarget()
 local range=self.profile.qRange
 return self:Rows('heroes',range)[1]or self:Rows('lane',range)[1]or self:Rows('jungle',range)[1]
end
-- The shield every level grants at least (level-1 base); the level growth between 40 and 140 is not published per level.
function ViktorChampion:ShieldFloor()
 if not finite(myHero.ap)or myHero:GetSpellData(_Q).level<1 then return 0 end
 return(self.profile.shieldMin+self.profile.shieldAP*math.max(0,myHero.ap))*(self:Upgrade('Q')==true and self.profile.shieldAug or 1)
end
function ViktorChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_Viktor',name='AyyyyIO - Viktor'})
 for _,mode in ipairs({'Combo','Harass'})do Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=slot~='W'or mode=='Combo'})end
  Menu[mode]:MenuElement({id='AfterAA',name='In attack range, Q only right after an attack',value=true,menu=false})
  if mode=='Combo'then
   Menu.Combo:MenuElement({id='R',name='Use R',value=true})
   Menu.Combo:MenuElement({id='RCount',name='R must hit at least (1 if the combo can kill)',value=2,min=1,max=5,step=1})
   Menu.Combo:MenuElement({id='WCount',name='Also use W where it catches this many enemies',value=2,min=2,max=5,step=1,menu=false})
  end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Combo'and 15 or 40,min=0,max=100,step=5,menu=mode~='Combo'})
 end
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 Menu.Clear:MenuElement({id='SpellHarass',name='Harass champions while lane clearing',value=false,toggle=true,key=string.byte('K'),callback=function(v)CheckChatBlock(Menu.Clear.SpellHarass,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do Menu.Clear:MenuElement({type=MENU,id=kind,name=kind})
  Menu.Clear[kind]:MenuElement({id='Q',name=kind=='LaneClear'and 'Use Q on minions an attack cannot take'or 'Use Q',value=true})
  Menu.Clear[kind]:MenuElement({id='E',name='Use E',value=true})
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions E must hit',value=3,min=2,max=8,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='E',name='Use E on a lone minion an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast and steer R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='Peel',name='Use W on close, dashing or immobile enemies',value=true})
 Menu.Misc:MenuElement({id='DashE',name='Use E on enemies who dash onto you',value=true})
 Menu.Misc:MenuElement({id='Finish',name='Finish killable enemies with Q and E',value=true})
 Menu.Misc:MenuElement({id='FleeW',name='Use W when fleeing',value=true})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Preview',name='Planned E laser while farming',value=true})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Kill',name='Mark enemies the storm combo kills',value=true})
end
function ViktorChampion:Rows(kind,range)return Core:Rows(kind=='heroes'and 'hero'or kind,range)end
function ViktorChampion:Current(u)
 if not u or not point(u.pos)then return false end
 if u==myHero then return IsValid(u)and Core:Current()end
 return Core:CurrentUnit(u)
end
function ViktorChampion:Target(range)
 local selected=_G.SDK.TargetSelector.Selected;if self:Current(selected)and selected.type==Obj_AI_Hero and GetDistance(myHero.pos,selected.pos)<=range then return selected end
 local u=GetTarget(range);return self:Current(u)and u.type==Obj_AI_Hero and GetDistance(myHero.pos,u.pos)<=range and u or self:Rows('heroes',range)[1]
end
function ViktorChampion:Buff(u,name,selfState)
 if not self:Current(u)or not finite(u.buffCount)or u.buffCount%1~=0 or u.buffCount<0 or u.buffCount>128 then return nil,nil,'unknown_snapshot'end
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and b.name and b.name:lower()==name then local ending=expiry(b)
   if not finite(b.count)or b.count%1~=0 or b.count<0 then return nil,nil,'invalid_count'end
   if b.count>0 and(finite(ending)and ending>Game.Timer()or selfState and(not ending or ending==0))then
    if owned(b,selfState)then return b,ending end;return nil,nil,'foreign_or_unattributed'
   end
  end
 end
end
function ViktorChampion:Augments()
 if not finite(myHero.buffCount)or myHero.buffCount%1~=0 or myHero.buffCount<0 or myHero.buffCount>128 then return {}end
 local state={Q=false,W=false,E=false,R=false};local unknown={}
 for i=0,myHero.buffCount do local b=myHero:GetBuff(i);local set=b and b.name and upgrades[b.name:lower()]
  if set then local ending=expiry(b);local countOK=finite(b.count)and b.count%1==0 and b.count>=0
   local live=countOK and b.count>0 and(finite(ending)and ending>Game.Timer()or not ending or ending==0)
   for letter in set:gmatch('.')do if not countOK then unknown[letter]=true elseif live then
    if owned(b,true)then state[letter]=true else unknown[letter]=true end
   end end
  end
 end
 for letter in pairs(unknown)do if state[letter]~=true then state[letter]=nil end end;return state
end
function ViktorChampion:Upgrade(letter)return self:Augments()[letter]end
function ViktorChampion:Fragments()
 local b,_,why=self:Buff(myHero,self.profile.fragments,true);if why then return nil end;return b and b.count or 0
end
function ViktorChampion:Empowered()
 return self:Buff(myHero,self.profile.qEmpower,true)or self:Buff(myHero,self.profile.qReturn,true)
end
function ViktorChampion:Ready(slot)
 local s=myHero:GetSpellData(slot);local name=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot]
 return s and finite(s.level)and s.level%1==0 and s.level>=1 and s.level<=(slot==_R and 3 or 5)and finite(s.mana)and s.mana>=0 and s.mana<=myHero.mana
  and(slot==_R and(s.name==self.profile.r or s.name==self.profile.r2)or slot~=_R and s.name==self.profile[name])and IsReady(slot)
end
function ViktorChampion:Projected(u,delay)
 local p=point(u.pos);local path=u.pathing;if p and path and(path.hasMovePath or path.isDashing)and point(path.endPos)then
  local speed=path.isDashing and path.dashSpeed or u.ms;if finite(speed)and speed>0 then return p:Extended(path.endPos,math.min(GetDistance(p,path.endPos),delay*speed))end
 end;return p
end
function ViktorChampion:Damage(u,slot,phase)
 if not self:Current(u)or not finite(myHero.ap)then return 0 end;local rank=myHero:GetSpellData(slot).level;local p=self.profile;local raw
 if slot==_Q then if not p.qBase[rank]then return 0 end;raw=phase=='attack'and p.qHit[rank]+p.qHitAP*myHero.ap+(p.qHitAD or 0)*(finite(myHero.totalDamage)and myHero.totalDamage or 0)or p.qBase[rank]+p.qAP*myHero.ap
 elseif slot==_E then if not p.eBase[rank]then return 0 end
  if phase=='aftershock'then if self:Upgrade('E')~=true then return 0 end;raw=p.eAfter[rank]+p.eAfterAP*myHero.ap;if u.type~=Obj_AI_Hero and u.team~=300 then raw=raw*p.eMinion end
  else raw=p.eBase[rank]+p.eAP*myHero.ap end
 elseif slot==_R then if not p.rBase[rank]then return 0 end;raw=phase=='tick'and p.rTick[rank]+p.rTickAP*myHero.ap or p.rBase[rank]+p.rAP*myHero.ap
 else return 0 end;return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
function ViktorChampion:GetQDmg(u)return self:Damage(u,_Q)end
function ViktorChampion:GetEDmg(u)return self:Damage(u,_E)end
function ViktorChampion:GetRDmg(u)return self:Damage(u,_R)end
function ViktorChampion:Shield()
 local level=myHero.levelData and myHero.levelData.lvl;if not finite(level)or level<1 or level>18 or not finite(myHero.ap)or myHero:GetSpellData(_Q).level<1 then return 0 end
 local p=self.profile;local amount=p.shieldMin+(p.shieldMax-p.shieldMin)*(level-1)/17+p.shieldAP*myHero.ap
 return amount*(self:Upgrade('Q')==true and p.shieldAug or 1)
end
function ViktorChampion:QWeave(u,afterAttack)
 if self:Empowered()then return false end
 if not afterAttack or not _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return true end
 local w=Core:AttackWitness(self.attackWitness,u);if w then self.attackWitness=w end
 return w and w.object==u and w.object.handle==u.handle and finite(w.at)and w.at<=Game.Timer()and Game.Timer()-w.at<=.75
end
function ViktorChampion:CastQ(u,context,permission,afterAttack)
 if self.qObservation or not self:Ready(_Q)or not self:Current(u)or GetDistance(myHero.pos,u.pos)>600 or not permission()or not self:QWeave(u,afterAttack)then return false end
 local identity,handle=id(u),u.handle
 local ok=Core:Cast(HK_Q,u,{range=600,context=context,deferAttackWindup=true,
  validate=function()return self:Ready(_Q)and self:Current(u)and id(u)==identity and u.handle==handle and permission()and self:QWeave(u,afterAttack)end,
  observe=function(q)local cast=Core:NativeCast(q,self.profile.q);return cast and(cast.target==identity or cast.target==handle)end})
 if ok and Core.lastIntent then local q=Core.lastIntent;local row={q=q,target=u,identity=identity,handle=handle,expires=Game.Timer()+2};self.qObservation=row
  Core:AfterCast(HK_Q,function()if self.qObservation==row then row.observedAt=Game.Timer()end end)
 end;return ok
end
function ViktorChampion:MaintainQ()
 local row=self.qObservation;if not row then return end;local r=Core.adapter:Poll(row.q.id)
 if r and r.state=='cancelled_before_send'or row.observedAt or Game.Timer()>row.expires then self.qObservation=nil end
end
function ViktorChampion:EmpoweredAttack(u,context,permission)
 if not self:Empowered()or not self:Current(u)or not _G.SDK.Orbwalker:CanAttack()or not _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return false end
 local identity,handle=id(u),u.handle;local previous=self.attackWitness
 return Core:Attack(u,{owner='QEmpoweredAttack',context=context,ttl=150,
  validate=function()return permission()and self:Empowered()~=nil and self:Current(u)and id(u)==identity and u.handle==handle end,
  observe=function(q)local cast=Core:NativeAttack(q,'ViktorQBuff')or Core:NativeAttack(q)
   if cast and(cast.target==identity or cast.target==handle)then
    local w=Core:AttackWitness(previous,u);if w then self.attackWitness=w end;return true
   end
  end})
end
function ViktorChampion:Laser(u,kind,origin,endPosition)
 if not self:Current(u)then return nil end
 local target=self:Projected(u,.2);if not target then return nil end;local distance=GetDistance(myHero.pos,target)
 local start=point(origin)or(distance>450 and myHero.pos:Extended(target,math.min(525,distance-150))or myHero.pos:Extended(target,math.max(0,distance-100)))
 local direction=point(endPosition)or target;if GetDistance(direction,start)<1 then direction=start+myHero.dir*100 end
 if GetDistance(direction,start)<1 then return nil end
 local ending=endPosition and point(endPosition)or start:Extended(direction,700)
 return self:LaserLegal(start,ending,u,kind)and{start=start,finish=ending,target=u,kind=kind or 'heroes',targetID=id(u),handle=u.handle,expires=Game.Timer()+.25}or nil
end
-- Laser on a champion. The start point is chosen first: on the target when it is within the start reach (the
-- beam is on it at once), else as far toward it as the start may go. The prediction engine then aims the laser
-- from that start point, so the beam runs along the target's path instead of along the Viktor-target line, and
-- a target the engine cannot place is not shot at. One prediction per call.
function ViktorChampion:HeroLaser(u)
 if not self:Current(u)or u.type~=Obj_AI_Hero then return nil end;local p=self.profile
 local here=point(u.pos);local distance=GetDistance(myHero.pos,here);if distance>p.eStart+p.eLength then return nil end
 local start=distance<=p.eStart and here or point(myHero.pos:Extended(here,p.eStart))
 local pred=Core:Prediction(self.ESpell);pred:GetPrediction(u,{pos=start})
 if not pred:CanHit(2)or not point(pred.CastPosition)then return nil end;local aim=point(pred.CastPosition)
 -- A target on the start point gives the engine no direction: the beam follows the path the target is walking,
 -- or continues away from Viktor when it stands still.
 if GetDistance(aim,start)<25 then local path=u.pathing
  if path and path.hasMovePath and not path.isDashing and point(path.endPos)and GetDistance(path.endPos,start)>50 then aim=point(path.endPos)
  elseif distance>=1 then aim=point(myHero.pos:Extended(start,distance+100))else return nil end
 end
 return self:Laser(u,'heroes',start,point(start:Extended(aim,p.eLength)))
end
-- Viktor-1: the laser through two champions. Besides HeroLaser (aimed by the
-- prediction along the primary target's path), the start on (or toward) the
-- primary target may aim at another champion's projected position; the plan
-- that hits the most champions wins, and it must always hit the primary target.
-- At most four extra candidates, linear projection, one wall check each.
function ViktorChampion:PairLaser(u)
 local p=self.profile;local best=self:HeroLaser(u);local count=best and #self:LaserHits(best.start,best.finish,'heroes')or 0
 local heroes=self:Rows('heroes',p.eStart+p.eLength+200)
 if #heroes<2 or not self:Current(u)then return best,count end
 local here=point(u.pos);local distance=GetDistance(myHero.pos,here);if distance>p.eStart+p.eLength then return best,count end
 local start=distance<=p.eStart and here or point(myHero.pos:Extended(here,p.eStart))
 local tried=0
 for _,v in ipairs(heroes)do
  if tried>=4 then break end
  if v~=u and self:Current(v)then tried=tried+1
   local aim=self:Projected(v,GetDistance(start,v.pos)/p.eSpeed)
   if aim and GetDistance(aim,start)>=1 then
    local plan=self:Laser(u,'heroes',start,point(start:Extended(aim,p.eLength)))
    local n=plan and #self:LaserHits(plan.start,plan.finish,'heroes')or 0
    if n>count then best,count=plan,n end
   end
  end
 end
 return best,count
end
function ViktorChampion:LaserHits(start,ending,kind)
 local rows=self:Rows(kind or 'heroes',1300);local hits={}
 for _,u in ipairs(rows)do
  local rough=math.max(0,GetDistance(start,u.pos))/1050;local a,b,len=ray(start,ending,self:Projected(u,rough))
  if a and a>=-(u.boundingRadius or 0)and a<=len+(u.boundingRadius or 0)and b<=80+(u.boundingRadius or 0)then hits[#hits+1]=u end
 end;return hits
end
function ViktorChampion:LaserLegal(start,ending,u,kind)
 if not point(start)or not point(ending)or GetDistance(start,myHero.pos)>525 or GetDistance(start,ending)<1 or GetDistance(start,ending)>700.01 then return false end
 local wall=OrbamaPrediction:GetCollision(start,ending,1050,0,80,{OrbamaPrediction.COLLISION_YASUOWALL},nil);if wall then return false end
 if u then if not self:Current(u)then return false end;for _,v in ipairs(self:LaserHits(start,ending,kind))do if id(v)==id(u)and v.handle==u.handle then return true end end;return false end
 return true
end
function ViktorChampion:CastE(plan,context,permission,minimum,rescue)
 if not plan or self.eObservation or not self:Ready(_E)or not Core.adapter:Capabilities().twoPointWorldCast or not permission()or not self:LaserLegal(plan.start,plan.finish,plan.target,plan.kind)then return false end
 local start,ending=point(plan.start),point(plan.finish);local u=plan.target;local identity,handle=id(u),u.handle
 local function valid()
  return self:Ready(_E)and permission()and self:Current(u)and id(u)==identity and u.handle==handle
   and self:LaserLegal(start,ending,u,plan.kind)and(not minimum or #self:LaserHits(start,ending,plan.kind)>=minimum)
   and(not rescue or self:Rescue(u,_E,start,ending))
 end
 if not valid()then return false end
 local ok=Core:CastTwoPoint(HK_E,start,ending,{owner='TwoPointE',intentTarget=u,context=context,deferAttackWindup=true,ttl=200,
  validate=valid,observe=function(q)
   local cast=Core:NativeCast(q,self.profile.e);if not cast then return false end
   local a,b=point(cast.startPos),point(cast.endPos or cast.placementPos)
   return a and b and GetDistance(a,start)<=80 and GetDistance(b,ending)<=80
  end})
 if ok and Core.lastIntent then local q=Core.lastIntent;local row={q=q,start=start,finish=ending,expires=Game.Timer()+2,target=u};self.eObservation=row
  Core:AfterCast(HK_E,function()if self.eObservation==row then row.observedAt=Game.Timer();row.aftershock=self:Upgrade('E')==true end
   if Core.logger then Core:Trace('viktor_e_start',{distance=GetDistance(start,myHero.pos),profile=self.profile.id})end end)
 end;return ok
end
function ViktorChampion:MaintainE()
 local row=self.eObservation;if not row then return end;local r=Core.adapter:Poll(row.q.id)
 if r and r.state=='cancelled_before_send'or Game.Timer()>row.expires or row.observedAt then self.eObservation=nil end
end
function ViktorChampion:Predict(u,slot)
 if not self:Current(u)then return nil end;local data=slot==_W and self.WSpell or self.RSpell
 local p=Core:Prediction(data);p:GetPrediction(u,myHero);if not p:CanHit(2)then return nil end
 local aim=point(p.CastPosition);if not aim or slot~=_W then return aim end
 -- Viktor-3: the field goes a little ahead along a walking target's path (up to half the
 -- radius, never past the path end or beyond W range), so the target walks into it while
 -- it builds up the stun instead of out of it.
 local path=u.pathing
 if path and path.hasMovePath and not path.isDashing and point(path.endPos)then
  local ahead=math.min(self.profile.wRadius/2,GetDistance(aim,path.endPos))
  if ahead>1 then local moved=point(aim:Extended(path.endPos,ahead));if GetDistance(moved,myHero.pos)<=self.profile.wRange then aim=moved end end
 end
 return aim
end
-- A melee champion standing on Viktor stays inside a field dropped on the pair of them.
function ViktorChampion:OnTop(u)
 return u.type==Obj_AI_Hero and finite(u.range)and u.range<=300 and GetDistance(u.pos,myHero.pos)<=300
end
-- The enemy the own storm is on: carrying its mark, or standing inside the tracked storm.
function ViktorChampion:Stormed(u)
 if self:Buff(u,self.profile.rMark,false)then return true end
 local row=self.storm;return row~=nil and self:StormCurrent()and GetDistance(row.object.pos,u.pos)<=row.radius
end
-- manual: true = the player asked; 'combo' adds the Combo reasons (a slowed target, the storm's target), which
-- keep the enemy in the field long enough without proving a stun.
function ViktorChampion:WUseful(u,manual)
 if manual==true then return true end
 -- Viktor-7: a ranged champion standing within 300 (peel only): the field goes between.
 if manual=='peel'and u.type==Obj_AI_Hero and GetDistance(u.pos,myHero.pos)<=300 and not self:OnTop(u)then return true end
 if Core:Fresh(GetHardCCDuration,u)>=.3 then return true end
 local path=u.pathing;if path and path.isDashing and point(path.endPos)and GetDistance(path.endPos,myHero.pos)<GetDistance(u.pos,myHero.pos)and GetDistance(path.endPos,myHero.pos)<=350 then return true end
 if self:OnTop(u)then return true end
 if manual=='combo'and(Core:Fresh(IsSlow,u)or self:Stormed(u))then return true end
 return GetMode()=='Flee'and GetDistance(u.pos,myHero.pos)<=500
end
-- The field between Viktor and a ranged champion next to him (Viktor-7).
function ViktorChampion:Between(u)
 if not self:Current(u)then return nil end;return point(myHero.pos:Extended(u.pos,GetDistance(myHero.pos,u.pos)/2))
end
function ViktorChampion:CastW(u,context,permission,manual)
 if not self:Ready(_W)or not permission()or u and(not self:Current(u)or not self:WUseful(u,manual))then return false end
 local between=manual=='peel'and u and not self:OnTop(u)and(u.range or 0)>300 and GetDistance(u.pos,myHero.pos)<=300
 local function aimAt()if between then return self:Between(u)end;return u and self:Predict(u,_W)or point(mousePos)end
 local identity,handle=id(u),u and u.handle;local aim=aimAt()
 if not aim or GetDistance(aim,myHero.pos)>800 then return false end
 local function fresh()
  if not permission()or u and(not self:Current(u)or id(u)~=identity or u.handle~=handle or not self:WUseful(u,manual))then return nil end
  local p=aimAt();return p and GetDistance(p,myHero.pos)<=800 and{position=p}or nil
 end
 local ok=Core:Cast(HK_W,aim,{intentTarget=u,range=800,context=context,prevalidateWorldCast=true,deferAttackWindup=true,resolve=fresh,
  commitGuard=function()return Core:Current()and permission()end,
  validate=function(_,resolved)return self:Ready(_W)and permission()and resolved and point(resolved.position)and(not u or self:Current(u)and id(u)==identity and u.handle==handle and self:WUseful(u,manual)
   and(between and GetDistance(u.pos,myHero.pos)<=300 or not between and GetDistance(self:Projected(u,self.profile.wArm),resolved.position)<=self.profile.wRadius+(u.boundingRadius or 0)))end})
 if ok then self:TraceW(aim)end
 return ok
end
-- Viktor-2: W where the active field catches at least `need` champions (their
-- projected positions once it is active), recounted on the resolved aim.
function ViktorChampion:WCatch(position)
 local n=0;local radius=self.profile.wRadius
 for _,v in ipairs(self:Rows('heroes',self.profile.wRange+radius+200))do
  local q=self:Projected(v,self.profile.wArm);if q and GetDistance(q,position)<=radius+(v.boundingRadius or 0)then n=n+1 end
 end;return n
end
function ViktorChampion:GroupAim(need)
 local heroes=self:Rows('heroes',self.profile.wRange+self.profile.wRadius);if #heroes<need then return nil end
 local points={}
 for i=1,math.min(#heroes,5)do local q=self:Projected(heroes[i],self.profile.wArm);if q then points[#points+1]={x=q.x,z=q.z}end end
 local aim,_,hits=Core:BestAim(points,{kind='circle',radius=self.profile.wRadius,range=self.profile.wRange})
 if not aim or #hits<need then return nil end
 local p=point(Vector(aim.x,myHero.pos.y or 0,aim.z));return self:WCatch(p)>=need and p or nil
end
function ViktorChampion:GroupW(context,permission)
 local need=Menu.Combo.WCount:Value();if not self:Ready(_W)or not permission()then return false end
 local aim=self:GroupAim(need);if not aim then return false end
 local ok=Core:Cast(HK_W,aim,{range=800,context=context,prevalidateWorldCast=true,deferAttackWindup=true,
  resolve=function()if not permission()then return nil end;local p=self:GroupAim(Menu.Combo.WCount:Value());return p and{position=p}or nil end,
  commitGuard=function()return Core:Current()and permission()end,
  validate=function(_,resolved)return self:Ready(_W)and permission()and resolved and point(resolved.position)and GetDistance(resolved.position,myHero.pos)<=800
   and self:WCatch(resolved.position)>=Menu.Combo.WCount:Value()end})
 if ok then self:TraceW(aim)end
 return ok
end
-- Viktor-8: W under an enemy who cannot move (or arrives) for the whole arming
-- and stun build-up (cast + activation + 1.25 s inside), from the shared scan.
function ViktorChampion:ZoneW()
 if not Menu.Misc.Peel:Value()or not self:Ready(_W)then return false end
 local need=self.profile.wArm+self.profile.wDwell
 local rows=Core:ZoneTargets({range=self.profile.wRange,arm=need,lifetime=6})
 for i=1,math.min(#rows,5)do local row=rows[i];local pos=row.position and point(row.position)
  local function fits()return Menu.Misc.Peel:Value()and self:Ready(_W)and row.valid()and row.freeAt-Game.Timer()>=need and GetDistance(pos,myHero.pos)<=self.profile.wRange end
  if pos and fits()and Core:Cast(HK_W,pos,{range=self.profile.wRange,validate=fits})then self:TraceW(pos);return true end
 end
 return false
end
-- Viktor-9 dev evidence (W activation, stun time and stun radius are wiki/asset
-- conflicts): after an observed W, the first slow and stun buff on each enemy
-- within 1200, with its time since the cast and its distance from the aim. Dev recorder only.
function ViktorChampion:TraceW(aim)
 if not Core.logger then return end
 local row={pos=aim,seen={}}
 Core:AfterCast(HK_W,function()row.at=Game.Timer();self.wTrace=row end)
end
function ViktorChampion:MaintainWTrace()
 local row=self.wTrace;if not row or not Core.logger then return end
 local now=Game.Timer();if now-row.at>5 then self.wTrace=nil;return end
 for _,u in ipairs(self:Rows('heroes',1200))do local key=id(u);local count=u.buffCount
  if key and finite(count)and count>=0 and count<=64 then
   for i=0,count do local b=u:GetBuff(i);local kind=b and(b.type==5 and 'stun'or b.type==11 and 'slow')
    if kind and(b.count or 1)>0 and not row.seen[key..kind]then row.seen[key..kind]=true
     Core:Trace('viktor_w_field',{kind=kind,since=now-row.at,distance=GetDistance(u.pos,row.pos),buff=b.name,profile=self.profile.id})
    end
   end
  end
 end
end
function ViktorChampion:RCount(p)
 local n=0;for _,u in ipairs(self:Rows('heroes',1100))do if GetDistance(self:Projected(u,.25),p)<=325+(u.boundingRadius or 0)then n=n+1 end end;return n
end
function ViktorChampion:StormObject(o)
 if not o or o.valid==false or o.dead or not id(o)or not point(o.pos)or not owned(o,false)then return false end
 local name=o.name or o.charName or '';return name=='ViktorR'or name=='ViktorChaosStorm'or name:find('Viktor',1,true)and(name:find('R_Container',1,true)or name:find('RContainer',1,true))~=nil
end
function ViktorChampion:ParticlesChunk()
 if type(Game.ParticleCount)~='function'or type(Game.Particle)~='function'then return end
 local count=Game.ParticleCount();if not finite(count)or count%1~=0 or count<0 then return end;count=math.min(count,1024)
 self.particleIndex=self.particleIndex or 1
 for _=1,16 do if self.particleIndex>count then self.particleIndex=1;break end
  local index=self.particleIndex;local o=Game.Particle(index);self.particleIndex=index+1
  if self.rObservation and self.rObservation.observedAt and self:StormObject(o)then
   local born=o.spawnTime or o.startTime
   if finite(born)and born>=self.rObservation.observedAt-.05 and born<=Game.Timer()then
    local ending=expiry(o)
    self.storm={object=o,index=index,identity=id(o),handle=o.handle,spawn=born,expires=finite(ending)and ending or self.rObservation.observedAt+6.5,expiryNative=finite(ending),radius=325};self.rObservation=nil;return
   end
  end
 end
end
function ViktorChampion:StormCurrent()
 local row=self.storm;local live=row and type(Game.Particle)=='function'and Game.Particle(row.index)
 if not row or not self:StormObject(live)or id(live)~=row.identity or live.handle~=row.handle or myHero:GetSpellData(_R).name~=self.profile.r2 then return false end
 row.object=live
 local o=row.object;local ending=expiry(o)
 if finite(ending)and ending>Game.Timer()then row.expires=ending;row.expiryNative=true end
 if Game.Timer()>=row.expires then return false end
 -- A native explicit effect radius is accepted; visual scale/boundingRadius and
 -- guessed takedown counts do not establish a grown damaging radius.
 if finite(o.effectRadius)and o.effectRadius>=325 and o.effectRadius<=325*(1+.4*6)then row.radius=o.effectRadius end
 return true
end
function ViktorChampion:MaintainR()
 if self.storm and not self:StormCurrent()then self.storm=nil end
 local row=self.rObservation;if row then local r=Core.adapter:Poll(row.q.id)
  if r and r.state=='cancelled_before_send'or Game.Timer()>row.expires then self.rObservation=nil end
 end
end
-- Engagement gate, not a guaranteed kill: R goes on a single champion when the storm's opening and two of its
-- strikes, with Q and E, finish a target that Q and E alone would not.
-- Viktor-5: only abilities that are ready count (Q, E with its aftershock when
-- augmented, an empowered attack while the Q buff is up), through the shared
-- kill rule (spell protection, cannot-die states, own Exhaust, health window).
function ViktorChampion:ReadyBurst(u)
 local d=0
 if self:Ready(_Q)then d=d+self:Damage(u,_Q)end
 if self:Ready(_E)then d=d+self:Damage(u,_E)+self:Damage(u,_E,'aftershock')end
 if self:Empowered()then d=d+self:Damage(u,_Q,'attack')end
 return d
end
function ViktorChampion:RKills(u)
 if not self:Current(u)or u.type~=Obj_AI_Hero then return false end
 local burst=self:ReadyBurst(u)
 if burst>0 and Core:Lethal(u,.5,burst,{kind='magical'})then return false end
 return(Core:Lethal(u,.25+2,burst+self:Damage(u,_R)+2*self:Damage(u,_R,'tick'),{kind='magical'}))
end
function ViktorChampion:RNeed(u,manual)
 if manual then return 1 end
 if self:RKills(u)then return 1 end
 return Menu.Combo.RCount:Value()
end
-- Viktor-4: an aim beyond the 700 cast range but within the 325 radius (+ the
-- target's size) is cast at the range edge toward it; the count is taken there.
function ViktorChampion:RAim(u)
 local aim=self:Predict(u,_R);if not aim then return nil end
 local d=GetDistance(aim,myHero.pos);if d<=700 then return aim end
 if d>700+325+(u.boundingRadius or 0)then return nil end
 return point(myHero.pos:Extended(aim,700))
end
function ViktorChampion:CastR(u,context,permission,manual)
 if not self:Ready(_R)or myHero:GetSpellData(_R).name~=self.profile.r or self.rObservation or self.storm or not self:Current(u)or not permission()then return false end
 local aim=self:RAim(u);if not aim or self:RCount(aim)<self:RNeed(u,manual)then return false end
 local identity,handle=id(u),u.handle
 local function fresh()
  if not permission()or not self:Current(u)or id(u)~=identity or u.handle~=handle then return nil end
  local p=self:RAim(u);return p and GetDistance(p,myHero.pos)<=700.5 and self:RCount(p)>=self:RNeed(u,manual)and{position=p}or nil
 end
 -- The cast range is 700; the target itself may stand up to the radius beyond it (Viktor-4).
 local ok=Core:Cast(HK_R,aim,{intentTarget=u,range=700+325+(u.boundingRadius or 0),context=context,prevalidateWorldCast=true,resolve=fresh,
  commitGuard=function()return Core:Current()and permission()end,
  validate=function(_,resolved)return self:Ready(_R)and myHero:GetSpellData(_R).name==self.profile.r and permission()and self:Current(u)and id(u)==identity and u.handle==handle and resolved
   and GetDistance(resolved.position,myHero.pos)<=700.5 and self:RCount(resolved.position)>=self:RNeed(u,manual)end,
  observe=function(q)return Core:NativeCast(q,self.profile.r)~=nil end})
 if ok and Core.lastIntent then local q=Core.lastIntent;local row={q=q,expires=Game.Timer()+3};self.rObservation=row
  Core:AfterCast(HK_R,function()if self.rObservation==row then row.observedAt=Game.Timer()end end)
 end;return ok
end
function ViktorChampion:GuideTarget(explicit)
 local selected=_G.SDK.TargetSelector.Selected;if self:Current(selected)and selected.type==Obj_AI_Hero then return selected end
 if explicit then for _,u in ipairs(self:Rows('heroes',20000))do if self:Buff(u,self.profile.rMark,false)then return u end end;return nil end
 local best,distance
 for _,u in ipairs(self:Rows('heroes',20000))do
  if self:Buff(u,self.profile.rMark,false)then return u end
  local d=self.storm and GetDistance(self.storm.object.pos,u.pos);if d and(not distance or d<distance)then best,distance=u,d end
 end;return best
end
function ViktorChampion:GuideR(u,context,permission)
 if not self:Ready(_R)or not self:StormCurrent()or not self:Current(u)or GetDistance(u.pos,myHero.pos)>20000 or not permission()then return false end
 local row=self.storm;local mark=self:Buff(u,self.profile.rMark,false);if mark and _G.SDK.TargetSelector.Selected~=u then return false end
 local speed=self:Upgrade('R')==true and 200*1.25 or 200
 local reach=GetDistance(row.object.pos,u.pos)/speed;if not finite(reach)or Game.Timer()+reach>=row.expires then return false end
 local identity,handle=id(u),u.handle
 return Core:Cast(HK_R,u,{owner='StormGuide',range=20000,context=context,ttl=200,
  validate=function()return permission()and self:Ready(_R)and self:StormCurrent()and self.storm==row and self:Current(u)and id(u)==identity and u.handle==handle and Game.Timer()+GetDistance(row.object.pos,u.pos)/speed<row.expires end,
  observe=function(q)local cast=Core:NativeCast(q,self.profile.r2);return cast and(cast.target==identity or cast.target==handle)end})
end
-- Viktor-10: with the R bind held, the own storm live and no selected or marked
-- champion, the storm is sent to the cursor (the recast directs it to a place).
-- A new order only when the cursor moved 150 from the last one, at most every 0.25 s.
function ViktorChampion:GuideToCursor()
 if not Menu.Misc.RAssist:Value()or not self:Ready(_R)or not self:StormCurrent()then return false end
 local now=Game.Timer();local last=self.cursorGuide;local aim=point(mousePos)
 if not aim or last and(now-last.at<.25 or GetDistance(last.pos,aim)<150)then return false end
 local row=self.storm
 local ok=Core:Cast(HK_R,aim,{owner='StormGuide',range=20000,context=Core:HeldContext(function()return Menu.Misc.RAssist:Value()end),ttl=200,
  validate=function()return Menu.Misc.RAssist:Value()and self:Ready(_R)and self:StormCurrent()and self.storm==row end,
  observe=function(q)return Core:NativeCast(q,self.profile.r2)~=nil end})
 if ok then self.cursorGuide={at=now,pos=aim}end
 return ok
end
function ViktorChampion:Rescue(u,slot,start,ending)
 if not self:Current(u)or u.team==300 then return false end
 if not Core:Rescue(u,slot==_Q and .25+GetDistance(myHero.pos,u.pos)/2000 or GetDistance(start or myHero.pos,u.pos)/1050,function()return self:Damage(u,slot)end,spellOnly)then return false end
 -- A ready attack in reach always takes the last hit.
 if _G.SDK.Orbwalker:CanAttack()and _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return false end
 -- The laser may touch only the minion it rescues.
 if slot==_E then local hits=self:LaserHits(start,ending,'lane');return #hits==1 and id(hits[1])==id(u)end;return GetDistance(myHero.pos,u.pos)<=600
end
function ViktorChampion:Combat(mode,context)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return end;local u=self:Target(1225);if not u then return end;context=context or Core:ModeContext(mode)
 if self:EmpoweredAttack(u,context,function()return Core.manaAbove(node.Mana:Value())end)then return true end
 if mode=='Combo'and node.W:Value()and self:Ready(_W)and self:GroupW(context,function()return node.W:Value()and Core.manaAbove(node.Mana:Value())end)then return true end
 if node.W:Value()and self:Ready(_W)and self:CastW(u,context,function()return node.W:Value()and Core.manaAbove(node.Mana:Value())end,mode=='Combo'and 'combo'or false)then return true end
 if node.Q:Value()and self:Ready(_Q)and self:CastQ(u,context,function()return node.Q:Value()and Core.manaAbove(node.Mana:Value())end,node.AfterAA:Value())then return true end
 if node.E:Value()and self:Ready(_E)and not self.eObservation then
  local plan,count=self:PairLaser(u)
  return self:CastE(plan,context,function()return node.E:Value()and Core.manaAbove(node.Mana:Value())end,count>=2 and 2 or nil)
 end
end
function ViktorChampion:Combo()return self:Combat('Combo')end
function ViktorChampion:Harass()return self:Combat('Harass')end
function ViktorChampion:ClearHarassAllowed()return Menu.Clear.SpellHarass:Value()and GetMode()=='LaneClear'and not IsUnderTurret(myHero)end
function ViktorChampion:FarmHarass()
 if not self:ClearHarassAllowed()then return end
 return self:Combat('Harass',Core:ModeContext('LaneClear',function()return self:ClearHarassAllowed()end))
end
function ViktorChampion:FarmChunk(kind)
 local node=kind=='lane'and Menu.Clear.LaneClear or Menu.Clear.JungleClear
 if not Menu.Clear.SpellFarm:Value()or not node.E:Value()or not self:Ready(_E)or not Core:FarmModeEnabled(kind)or not Core.manaAbove(node.Mana:Value())then self.farmJob=nil;self.farmResult=nil;return end
 local p=self.profile;local job=self.farmJob
 if not job or job.kind~=kind or Game.Timer()>job.expires then local rows=self:Rows(kind,p.eStart+p.eLength);local n=math.min(#rows,8)
  job={kind=kind,index=1,rows=rows,n=n,total=n*n,expires=Game.Timer()+.75};self.farmJob=job
 end
 -- Candidate (a,b) of the nearest eight units: the laser starts on a (or as far toward a as the start may go) and
 -- runs toward b; a==b is the laser on the Viktor-a line. At most 64 candidates, 16 per grant, and progress
 -- survives budget refusals. Counting is plain ray arithmetic on positions read once per grant; the wall and
 -- identity checks run once, on the winner, and again at dispatch.
 local live={};for i=1,math.min(#job.rows,24)do local u=job.rows[i];if self:Current(u)then live[#live+1]=u end end
 local function hits(start,finish,unit)local n,on=0,false
  for i=1,#live do local u=live[i];local a,b,len=ray(start,finish,u.pos);local r=u.boundingRadius or 0
   if a and a>=-r and a<=len+r and b<=p.eRadius+r then n=n+1;if u==unit then on=true end end
  end;return n,on
 end
 for _=1,16 do if job.index>job.total then break end
  local a,b=job.rows[math.floor((job.index-1)/job.n)+1],job.rows[(job.index-1)%job.n+1];job.index=job.index+1
  if self:Current(a)and self:Current(b)then local here=point(a.pos);local distance=GetDistance(here,myHero.pos);local start,finish
   if a==b then
    start=distance>450 and myHero.pos:Extended(here,math.min(p.eStart,distance-150))or myHero.pos:Extended(here,math.max(0,distance-100))
    if GetDistance(start,here)>=1 then finish=start:Extended(here,p.eLength)end
   else start=distance<=p.eStart and here or myHero.pos:Extended(here,p.eStart)
    if GetDistance(start,b.pos)>=1 then finish=start:Extended(b.pos,p.eLength)end
   end
   if finish then local n,on=hits(start,finish,a);local target=a
    if not on then n,on=hits(start,finish,b);target=b end
    if on and(not job.count or n>job.count)then job.count=n;job.start=point(start);job.finish=point(finish);job.target=target end
   end
  end
 end
 if job.index>job.total then local plan=job.target and self:Laser(job.target,kind,job.start,job.finish)
  self.farmResult=plan and{plan=plan,count=#self:LaserHits(plan.start,plan.finish,kind),kind=kind,expires=Game.Timer()+.2}or nil;self.farmJob=nil
 end
end
function ViktorChampion:Farm(kind)
 local node=kind=='lane'and Menu.Clear.LaneClear or Menu.Clear.JungleClear
 if not Menu.Clear.SpellFarm:Value()or not Core.manaAbove(node.Mana:Value())then return end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end);local rows=self:Rows(kind,600)
 if node.Q:Value()and self:Ready(_Q)then for _,u in ipairs(rows)do if kind=='jungle'or self:Rescue(u,_Q)then
  -- A lane Q is a last-hit rescue: it goes out ahead of the orbwalker.
  if self:CastQ(u,kind=='lane'and Core:RescueContext(Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end))or context,function()return node.Q:Value()and Menu.Clear.SpellFarm:Value()and Core.manaAbove(node.Mana:Value())and(kind=='jungle'or self:Rescue(u,_Q))end,false)then return true end
 end end end
 local row=self.farmResult;if node.E:Value()and row and row.kind==kind and row.expires>Game.Timer()then
  return self:CastE(row.plan,context,function()return node.E:Value()and Menu.Clear.SpellFarm:Value()and Core.manaAbove(node.Mana:Value())end,kind=='lane'and Menu.Clear.LaneClear.Count:Value()or 1)
 end
end
function ViktorChampion:LaneClear()return self:Farm('lane')end
function ViktorChampion:JungleClear()return self:Farm('jungle')end
function ViktorChampion:LastHit()
 if not Core.manaAbove(Menu.LastHit.Mana:Value())then return end;local context=Core:RescueContext()
 if Menu.LastHit.Q:Value()and self:Ready(_Q)then for _,u in ipairs(self:Rows('lane',600))do if self:Rescue(u,_Q)then
  return self:CastQ(u,context,function()return Menu.LastHit.Q:Value()and Core.manaAbove(Menu.LastHit.Mana:Value())and self:Rescue(u,_Q)end,false)
 end end end
 if Menu.LastHit.E:Value()and self:Ready(_E)then for i,u in ipairs(self:Rows('lane',1225))do if i>8 then break end;local plan=self:Laser(u,'lane')
  if plan and self:Rescue(u,_E,plan.start,plan.finish)then return self:CastE(plan,context,function()return Menu.LastHit.E:Value()and Core.manaAbove(Menu.LastHit.Mana:Value())end,1,true)end
 end end
end
function ViktorChampion:Flee()
 local u=self:Target(800);local context=Core:ModeContext('Flee')
 if u and Menu.Misc.FleeW:Value()and self:Ready(_W)and self:CastW(u,context,function()return Menu.Misc.FleeW:Value()end,false)then return true end
 -- Q on anything in reach: the shield (and the augment's speed) is what a fleeing Viktor wants; no switch.
 if self:Ready(_Q)then u=self:ShieldTarget()
  if u then return self:CastQ(u,context,function()return true end,false)end
 end
end
function ViktorChampion:Assist()
 local held=Menu.Misc.RAssist:Value();local combat=GetMode()=='Combo'
 if self:Ready(_R)and self:StormCurrent()then local u=self:GuideTarget(held)
  if not u and held then return self:GuideToCursor()end
  if u then return self:GuideR(u,held and Core:HeldContext(function()return Menu.Misc.RAssist:Value()end)or {},
   function()return not held or Menu.Misc.RAssist:Value()end)end
 end
 if self:Ready(_R)and myHero:GetSpellData(_R).name==self.profile.r and(held or combat and Menu.Combo.R:Value()and Core.manaAbove(Menu.Combo.Mana:Value()))then
  local u=self:Target(700);if u then return self:CastR(u,held and Core:HeldContext(function()return Menu.Misc.RAssist:Value()end)or Core:ModeContext('Combo'),
   function()return held and Menu.Misc.RAssist:Value()or not held and Menu.Combo.R:Value()and Core.manaAbove(Menu.Combo.Mana:Value())end,held)end
 end
end
function ViktorChampion:ELethal(u,plan)
 if not plan or not self:Current(u)then return false end
 -- The shared kill rule (shields, spell protection, health window). Viktor-13: with the E augment
 -- the aftershock 1 s later counts too, judged at the aftershock time.
 local impact=self.profile.eDelay+GetDistance(plan.start,u.pos)/self.profile.eSpeed
 if Core:Lethal(u,impact,function()return self:Damage(u,_E)end,{kind='magical'})then return true end
 if self:Upgrade('E')~=true then return false end
 return(Core:Lethal(u,impact+self.profile.eAfterDelay,function()return self:Damage(u,_E)+self:Damage(u,_E,'aftershock')end,{kind='magical'}))
end
-- Viktor-13: Q first when Q alone does not kill but Q and a ready laser on the
-- same champion do; the laser then finishes through ReactiveE.
function ViktorChampion:QThenEKills(u)
 if not self:Ready(_E)or self.eObservation or not self:Current(u)then return false end
 local p=self.profile;local qImpact=p.qDelay+GetDistance(u.pos,myHero.pos)/p.qSpeed
 if GetDistance(u.pos,myHero.pos)>p.eStart+p.eLength then return false end
 local damage=self:Damage(u,_Q)+self:Damage(u,_E)
 return(Core:Lethal(u,qImpact+.25+p.eDelay+math.max(0,GetDistance(u.pos,myHero.pos)-p.eStart)/p.eSpeed,damage,{kind='magical'}))
end
-- A kill without a mode key: Q is targeted and cannot be dodged.
function ViktorChampion:FinishQ()
 if not Menu.Misc.Finish:Value()or not self:Ready(_Q)or self.qObservation then return false end
 for _,u in ipairs(self:Rows('heroes',self.profile.qRange))do
  local function kills()return Menu.Misc.Finish:Value()and((Core:Lethal(u,self.profile.qDelay+GetDistance(u.pos,myHero.pos)/self.profile.qSpeed,function()return self:Damage(u,_Q)end,{kind='magical'}))or self:QThenEKills(u))end
  if kills()and self:CastQ(u,{},kills,false)then return true end
 end;return false
end
function ViktorChampion:ReactiveE()
 if not self:Ready(_E)or self.eObservation then return false end
 for _,u in ipairs(self:Rows('heroes',self.profile.eStart+self.profile.eLength))do
  local path=u.pathing
  local dash=Menu.Misc.DashE:Value()and path and path.isDashing and point(path.endPos)
   and GetDistance(path.endPos,myHero.pos)<=350 and GetDistance(path.endPos,myHero.pos)<GetDistance(u.pos,myHero.pos)
  -- A finisher is aimed by the prediction engine and only looked for when the damage can kill at all; a dash
  -- onto Viktor has a known path and keeps the plain geometric laser.
  local reach=self:Damage(u,_E)+self:Damage(u,_E,'aftershock')
  local plan=Menu.Misc.Finish:Value()and reach>u.health+math.max(0,u.shieldAP or 0)and self:HeroLaser(u)or dash and self:Laser(u,'heroes')or nil
  local lethal=Menu.Misc.Finish:Value()and self:ELethal(u,plan)
  if plan and(dash or lethal)then
   return self:CastE(plan,{},function()
    if lethal then return Menu.Misc.Finish:Value()and self:ELethal(u,plan)end
    local p=u.pathing
    return Menu.Misc.DashE:Value()and p and p.isDashing and point(p.endPos)
     and GetDistance(p.endPos,myHero.pos)<=350 and GetDistance(p.endPos,myHero.pos)<GetDistance(u.pos,myHero.pos)
   end,1)
  end
 end
 return false
end
function ViktorChampion:Peel()
 if not Menu.Misc.Peel:Value()or not self:Ready(_W)then return end
 for _,u in ipairs(self:Rows('heroes',800))do local p=u.pathing
  if p and p.isDashing and point(p.endPos)and GetDistance(p.endPos,myHero.pos)<=350 and GetDistance(p.endPos,myHero.pos)<GetDistance(u.pos,myHero.pos)
   or self:OnTop(u)then
   if self:CastW(u,{},function()return Menu.Misc.Peel:Value()end,false)then return true end
  elseif u.type==Obj_AI_Hero and GetDistance(u.pos,myHero.pos)<=300 then
   if self:CastW(u,{},function()return Menu.Misc.Peel:Value()end,'peel')then return true end
  end
 end
 return self:ZoneW()
end
function ViktorChampion:OnPostAttack(args)
 if not Core:InputAvailable()then return end;local witness=Core:AttackWitness(self.attackWitness,args and args.Target)
 if witness then self.attackWitness=witness end
end
function ViktorChampion:PreviewWanted()
 return Menu.Draw.Preview:Value()or Menu.Draw.Ranges:Value()or Menu.Draw.Kill:Value()
end
function ViktorChampion:PrepareOptional()
 if self.rObservation and self.rObservation.observedAt then self:ParticlesChunk()end
 if Core:FarmModeEnabled('lane')then self:FarmChunk('lane')elseif Core:FarmModeEnabled('jungle')then self:FarmChunk('jungle')else self.farmJob=nil;self.farmResult=nil end
 -- No augment/storm or farm text: the game shows the evolutions and the storm, the HUD strip the toggles.
 -- Kept for a second so a late preparation never blinks the drawing.
 local view={expires=Game.Timer()+1,laser=self.farmResult and self.farmResult.plan,ranges={},kills={}}
 if Menu.Draw.Ranges:Value()then
  if self:Ready(_Q)then view.ranges[#view.ranges+1]=self.profile.qRange end
  if self:Ready(_W)then view.ranges[#view.ranges+1]=self.profile.wRange end
  if self:Ready(_E)then view.ranges[#view.ranges+1]=self.profile.eStart;view.ranges[#view.ranges+1]=self.profile.eStart+self.profile.eLength end
  if self:Ready(_R)and myHero:GetSpellData(_R).name==self.profile.r then view.ranges[#view.ranges+1]=self.profile.rRange end
 end
 if Menu.Draw.Kill:Value()and self:Ready(_R)and myHero:GetSpellData(_R).name==self.profile.r then
  local rows=self:Rows('heroes',2000)
  for i=1,math.min(#rows,5)do local u=rows[i];if self:RKills(u)then view.kills[#view.kills+1]=u end end
 end
 self.preview=view
end
function ViktorChampion:Tick()
 if not Core:InputAvailable()or ShouldWait()then return end
 self:MaintainQ();self:MaintainE();self:MaintainR();self:MaintainWTrace()
 if self.preparationFallback and(not self.nextPreparation or Game.Timer()>=self.nextPreparation)then self:PrepareOptional();self.nextPreparation=Game.Timer()+.1 end
 if IsCasting()then return end;if self:Peel()or self:Assist()or self:FinishQ()or self:ReactiveE()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if self:FarmHarass()then return end;if Core:FarmModeEnabled('lane')then self:LaneClear()end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function ViktorChampion:Draw()
 if myHero.dead then return end
 local p=self.preview;if not p or p.expires<=Game.Timer()then return end
 if Menu.Draw.Ranges:Value()then for _,range in ipairs(p.ranges)do Draw.Circle(myHero.pos,range,1,Draw.Color(255,210,140,255))end end
 if IsReady(_R)then for _,u in ipairs(p.kills)do if IsValid(u)and u.pos2D.onScreen then Draw.Text('R kills',16,u.pos2D.x-20,u.pos2D.y-80,Draw.Color(255,255,80,80))end end end
 if Menu.Draw.Preview:Value()and p.laser and IsReady(_E)then local a,b=p.laser.start:To2D(),p.laser.finish:To2D();Draw.Line(a.x,a.y,b.x,b.y,2,Draw.Color(255,255,220,120))end
end
function ViktorChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Viktor: casts','Viktor: evolution'},function(page)return{title='Viktor assistance',cards=page==1 and{
  {'TWO POINTS','E uses the shared owned two-point transport. On a champion the laser starts on the target when it is within the start reach, else as far toward it as the start may go, and is aimed from that start point along the target\'s path. Both points and the outgoing laser are freshly confirmed before input. A refused or uncertain input never creates another raw cast.'},
  {'WEAVING','Combo Q waits for an actual recent attack when already in AA range. The Q buff allows an empowered attack; no timer creates an attack reset or lock.'},
  {'CONTROL','W is a field requiring occupancy, not instant stun: it goes on a held enemy, a dash onto you, a melee champion on top of you, and in Combo on a slowed enemy or the storm\'s target. The R bind casts at the selected target and steers your own storm; Combo R needs its enemy count, or one champion the storm with Q and E can finish. Without a mode key Q and E finish killable enemies.'}}or{
  {'AUGMENTS','Only owned native augment buffs change Q shield/speed or E aftershock estimates. Fragments are observed, never inferred from farming or upload dates.'},
  {'STORM','Only a native-observed R plus a newly spawned own storm is guided. Foreign particles, missing ownership and replaced objects are rejected. Growth/extension comes only from native effect radius/expiry, not guessed deaths.'},
  {'FARM','Provider Lane/Jungle binds remain separate. Lane and jungle E search lasers between pairs of the nearest units as well as straight ones, in bounded preparation chunks with finite results. LastHit uses only initial Q/E damage and confirmed incoming HP, never a speculative aftershock or storm duration.'}},note='Normal-only candidate. Exact effect aliases/timing and full live acceptance still need matching runtime evidence.'}end)
end
-- As before, no own-channel gate is registered for Viktor.
Core:StandardPolicy(ViktorChampion,{damageTypes={Q='magical',E='magical',R='magical'},channel=false,
 methods={FarmHarass=function()return Core:ModeContext('LaneClear',function()return Menu.Clear.SpellHarass:Value()and not IsUnderTurret(myHero)end)end}})
ViktorChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={}
local normalSupported={["Viktor"]=true}

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
