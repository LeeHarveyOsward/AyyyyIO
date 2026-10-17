return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
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
modules.observeAttack=(function(require) return _G.OrbamaFamily:Factory("0eb86cbf6312e1011d3b480290252f3b442a81d9d38e790d4fb95e6947c5bf14")(require) end)(require)
modules.recallCast=(function(require) return _G.OrbamaFamily:Factory("7dbacbbf6e267f3a5936a395354a7637172ae253a18a1dae30d7bbe860f10aa1")(require) end)(require)
modules.skillOrders=(function(require) return _G.OrbamaFamily:Factory("a8b0dae6f22e1be48bd91c9c82136f14fa6021bda02b48ebb89e55f2612db730")(require) end)(require)
modules.healthWindow=(function(require) return _G.OrbamaFamily:Factory("d533b0ef74c68b495c1d2541cc3e687ebd5a9d43ecc9bd9706750c9b1a16fec9")(require) end)(require)
modules.yunaraProfile=(function(require) return _G.OrbamaFamily:Factory("d0f8a7ede995c1c4ae39ff50186c21819723104154d9a4a209da8a785993462e")(require) end)(require)
modules.nautilusProfile=(function(require) return _G.OrbamaFamily:Factory("f730083274ce090a6b9cdaf348846a2fa53f89ad6c57c53a6c09767f82770c84")(require) end)(require)
modules["autojungle"]=_G.OrbamaFamily:Require("12c9f19e56e973236e0bcff8c7222940806f07b1c7bf1e88042f1b34eddcc520")
modules["combatMechanics"]=_G.OrbamaFamily:Require("9e32908504b1e01599ffc8a55f7d52a3a92a974d794c085ee29160c628b85e38")
modules["gameplay"]=_G.OrbamaFamily:Require("038c846d2b126f3f80142b2c55b4ace9ee78a9347b22cb2f242dcb5ed5185f2f")
modules["prediction"]=(function(require) return _G.OrbamaFamily:Factory("223a065ecf7929552d5f8dafcf2453fd9147cd6e9940ce97dc80add73aa9913b")(require) end)(require)
modules["policies"]=(function(require) return _G.OrbamaFamily:Factory("e26056d70e5dac93ebb21f4ae4fe96863a06915a942bb75b795567a932448a23")(require) end)(require)
modules["core"]=(function(require) return _G.OrbamaFamily:Factory("454102f4f573681afa019a39b08ec2a6adca91fb526d8515918046a8d866415c")(require) end)(require)
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
if champion=="Yunara" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Yunara',profiles={normal=true,classic=false},
 Create=function(context)
-- Independently written from installed Yunara assets; no Classic kit is inferred.
local profiles=YunaraProfiles
local finite,id,point=Core.finite,Core.id,Core.point
local spellOnly={attack=false} -- Core:Rescue: the attack is weighed here, by the rule this champion's regressions pin
local function ending(b)local t=Core.buffExpiry(b);return finite(t)and t or nil end
local function cleanup(self)
 self.preview=nil;self.attack=nil;self.transform=nil;self.rStart=nil;self.rGesture=nil;self.issued={};self.gestures={}
end
local YunaraChampion=class("YunaraChampion")
function YunaraChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.issued={};self.gestures={};self:LoadMenu();self.allow=Core:TargetConsent(Menu.Misc.Targets,self,'');self.targets=self.allow.targets;self:DiscoverTargets()
 self.WSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=self.profile.wDelay,Radius=self.profile.wRadius,Range=self.profile.wRange,Speed=self.profile.wSpeed,
  Collision=true,CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}}
 -- Yunara-10: prediction uses the smaller published width (radius 60); the no-softening scan keeps the asset 90.
 self.W2Spell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=self.profile.w2Delay,Radius=self.profile.w2HitRadius or self.profile.w2Radius,Range=self.profile.wRange,Speed=math.huge,Collision=false}
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Yunara',function()cleanup(self)end)
 local ok,why=Core:RegisterPreparation('Yunara.preview',{intervalMs=150,maxDelayMs=450,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end);self.previewFallback=not ok and why=='unsupported'
 Core:RegisterMobility({kind='dash',slot=_E,key=HK_E,name=self.profile.e2,range=self.profile.eRange,speeds=self.profile.eSpeeds,castDelays={self.profile.eDelay},
  profile='normal',label='Untouchable Shadow',source=self.profile.eSource,toPoint=true,allowed=function(p)
   return self:Form(self.profile.eDelay)and self:Ready(_E)and(p==nil or self:LegalDash(p,false))end})
end
function YunaraChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Yunara'})
 for _,mode in ipairs({'Combo','Harass'})do Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu[mode]:MenuElement({id='SmartW',name='Save W while empowered attacks can hit',value=true,menu=false})
  Menu[mode]:MenuElement({id='E',name='Use E toward the cursor to chase',value=mode=='Combo'})
  if mode=='Combo'then
   Menu.Combo:MenuElement({id='R',name='Use R',value=true})
   Menu.Combo:MenuElement({id='RCount',name='R needs at least this many enemies nearby',value=2,min=1,max=5,step=1})
  end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5,menu=mode~='Combo'})
 end
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 Menu.Clear:MenuElement({id='SpellHarass',name='Harass champions while lane clearing',value=false,toggle=true,key=string.byte('K'),callback=function(v)CheckChatBlock(Menu.Clear.SpellHarass,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do Menu.Clear:MenuElement({type=MENU,id=kind,name=kind})
  for _,slot in ipairs({'Q','W'})do Menu.Clear[kind]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions an ability must hit',value=3,min=1,max=8,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='W',name='Use W on a lone minion an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R near the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='HP',name='Never dash in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='Enemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='ReserveE',name='Keep mana for E, a full-stack Q and a ready R when casting W',value=true,menu=false})
 Menu.Misc:MenuElement({id='PeelE',name='Dash away with E from enemies who dash onto you',value=true})
 Menu.Misc:MenuElement({type=MENU,id='Targets',name='Enemy champions abilities may target'})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Preview',name='E landing spot',value=true})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
end
function YunaraChampion:Rows(kind,range)return Core:Rows(kind,range)end
-- A cheap check for units a caller has already confirmed with Current.
function YunaraChampion:Reach(u,range)return IsValid(u)and u.team~=myHero.team and point(u.pos)and GetDistance(u.pos,myHero.pos)<=range end
function YunaraChampion:Current(u)return Core:CurrentUnit(u)end
function YunaraChampion:DiscoverTargets()self.allow:Refresh()end
function YunaraChampion:Allowed(u)return self.allow:Allowed(u)end
function YunaraChampion:Target(range)
 local selected=_G.SDK.TargetSelector.Selected;if self:Current(selected)and self:Reach(selected,range)and self:Allowed(selected)then return selected end
 local u=GetTarget(range);if self:Current(u)and self:Allowed(u)then return u end
 for _,v in ipairs(self:Rows('hero',range))do if self:Allowed(v)then return v end end
end
-- An own buff on the player that is still active `horizon` seconds from now.
function YunaraChampion:Buff(name,horizon)
 local b=Core:OwnBuff(myHero,name,true);return b and ending(b)>Game.Timer()+(horizon or 0)and b or nil
end
function YunaraChampion:Form(horizon)
 local b=self:Buff(self.profile.r,horizon);local w=myHero:GetSpellData(_W);local e=myHero:GetSpellData(_E)
 if b and w and e and w.name==self.profile.w2 and e.name==self.profile.e2 then return true,b end
 if not b and w and e and w.name==self.profile.w and e.name==self.profile.e then return false end
 return nil
end
function YunaraChampion:Unleash()
 local n=myHero.hudAmmo;return finite(n)and n%1==0 and n>=0 and n<=self.profile.qMax and n or nil
end
function YunaraChampion:MaintainIssued()
 for slot,row in pairs(self.issued)do local q=row.q;local r=Core.adapter:Poll(q.id);local d=myHero:GetSpellData(slot)
  if d and finite(d.currentCd)and d.currentCd>0 then row.cooldownSeen=true end
  if slot==_E and row.context and row.context.mode=='Flee'and q.observedAt and row.cooldownSeen and d and d.currentCd==0 then self.gestures.FleeE=nil end
  if not Core.adapter:ContextValid({context=row.context},'continuation')or row.cooldownSeen and d and d.currentCd==0
   or d and d.name~=row.name or r and r.state=='cancelled_before_send'and not r.sentAt then self.issued[slot]=nil
  else row.uncertain=q.ambiguous or r and r.state=='send_uncertain'or q.outcome=='unobserved_handoff'or q.outcome=='unobserved'end
 end
end
function YunaraChampion:Ready(slot)
 local d=myHero:GetSpellData(slot);local p=self.profile;local form=self:Form();local expected=({[0]=p.q,[1]=form and p.w2 or p.w,[2]=form and p.e2 or p.e,[3]=p.r})[slot]
 if form==nil or not d or d.name~=expected or not finite(d.level)or d.level%1~=0 or d.level<1 or d.level>(slot==_R and 3 or 5)
  or not finite(d.currentCd)or d.currentCd>0 or Game.CanUseSpell(slot)~=0 or not finite(d.mana)or d.mana<0 or not finite(myHero.mana)or myHero.mana<d.mana
  or self.issued[slot]and self.issued[slot].uncertain then return false end
 if slot==_Q then return not form and not self:Buff(p.q)and self:Unleash()==p.qMax end
 if slot==_R then return not form end;return true
end
function YunaraChampion:Native(q,name,u)
 local a=Core:NativeCast(q,name);return a and(not u or a.target==id(u)or a.target==u.handle)or false
end
function YunaraChampion:Submit(slot,key,aim,options)
 if not Core:Cast(key,aim,options)then return false end
 local q=Core.lastIntent;self.issued[slot]={q=q,name=myHero:GetSpellData(slot).name,context=options.context}
 if slot==_W and Core.logger then self:TraceW(options.intentTarget)end
 return true
end
-- Dev evidence (Yunara-1/5/9): after an observed W, its cast time against attack speed,
-- the units on the ray, and when the target's health first drops (effective impact).
function YunaraChampion:TraceW(u)
 local spell=self:WSettings();if not spell then return end
 local row={target=u,health=u and u.health,units=u and self:Current(u)and self:RayUnits(u,spell)or nil,minion=u and u.type==Obj_AI_Minion,level=myHero.levelData and myHero.levelData.lvl}
 Core:AfterCast(HK_W,function()local a=myHero.activeSpell;row.at=Game.Timer()
  if a and a.valid and finite(a.startTime)and finite(a.castEndTime)then
   Core:Trace('yunara_w_cast',{windup=a.castEndTime-a.startTime,attackSpeed=myHero.attackSpeed,form=self:Form()==true})
  end
  self.wTrace=row end)
end
function YunaraChampion:MaintainTrace()
 local row=self.wTrace;if not row or not Core.logger then return end
 local now=Game.Timer();if not row.at or now-row.at>2 or not row.target then self.wTrace=nil;return end
 local u=row.target
 if finite(u.health)and finite(row.health)and u.health<row.health then
  Core:Trace('yunara_w_impact',{since=now-row.at,units=row.units,distance=GetDistance(u.pos,myHero.pos),drop=row.health-u.health,minion=row.minion,level=row.level})
  self.wTrace=nil
 end
end
function YunaraChampion:Projected(u,t)
 local p=u.pathing;local goal=p and(p.endPos or u.posTo)
 if p and p.hasMovePath and point(goal)and finite(u.ms)and u.ms>=0 then return u.pos:Extended(goal,math.min(GetDistance(u.pos,goal),u.ms*t))end;return point(u.pos)
end
function YunaraChampion:Spread(u,kind)
 if not self:Current(u)then return nil end
 local out={primary=id(u),units={},count=1,work=0,onhitEfficacy=self.profile.qOnhit,physicalRatio=self.profile.qSpreadAD,expires=Game.Timer()+.15}
 local rows=self:Rows(kind or(u.type==Obj_AI_Hero and 'hero'or u.team==300 and 'jungle'or 'lane'),1500);local seen={[id(u)]=true}
 local origin=self:Projected(u,.15)
 for i=1,math.min(#rows,24)do local v=rows[i];out.work=out.work+1
  if not seen[id(v)]and self:Allowed(v)and GetDistance(self:Projected(v,.15),origin)<=self.profile.qSpread then
   seen[id(v)]=true;out.units[#out.units+1]=id(v);out.count=out.count+1
  end
 end;return out
end
function YunaraChampion:AttackPermission(u)
 local mode=GetMode();local node,context,kind
 if u.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')then node=Menu[mode];context=Core:ModeContext(mode)
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then kind=u.team==300 and 'jungle'or 'lane';if not Core:FarmModeEnabled(kind)then return nil end
  node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'];context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 end
 if not node or not node.Q:Value()or not Core.manaAbove(node.Mana:Value())or not self:Allowed(u)then return nil end
 if kind=='lane'then local spread=self:Spread(u,kind);if not spread or spread.count<Menu.Clear.LaneClear.Count:Value()then return nil end end
 return context
end
function YunaraChampion:CastQ(u,context,permission)
 if not self:Ready(_Q)or not self:Current(u)or not self:Allowed(u)or not _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return false end
 local handle=u.handle;return self:Submit(_Q,HK_Q,nil,{owner='Cultivation',context=context,intentTarget=u,independent=false,
  observe=function(q)return self:Native(q,self.profile.q)end,
  validate=function()return self:Ready(_Q)and self:Current(u)and u.handle==handle and self:Allowed(u)and _G.SDK.Data:IsInAutoAttackRange(myHero,u)and(not permission or permission())end})
end
function YunaraChampion:OnPostAttack(args)
 if not Core:InputAvailable()or ShouldWait()or not self:Ready(_Q)then return end
 local a=Core:AttackWitness(self.attack,args and args.Target);if not a or a==self.attack or a.at>Game.Timer()then return end
 self.attack=a;local context=self:AttackPermission(a.object);if not context then return end
 return self:CastQ(a.object,context,function()return self.attack==a and Game.Timer()-a.at<=.35 and self:AttackPermission(a.object)~=nil end)
end
function YunaraChampion:WSettings()
 local form=self:Form();if form==nil then return nil end
 return form and self.W2Spell or self.WSpell,form and self.profile.w2 or self.profile.w
end
function YunaraChampion:WImpact(u,spell)return spell.Delay+(spell.Speed==math.huge and 0 or GetDistance(u.pos,myHero.pos)/spell.Speed)end
-- Normal W keeps mana for a ready E, the Q activation once Unleash is at 6 or
-- more, and a ready R that Combo may use. Transformed W costs nothing extra.
function YunaraChampion:WReserve()
 if not Menu.Misc.ReserveE:Value()or self:Form()==true then return true end
 local w=myHero:GetSpellData(_W);local need=finite(w.mana)and w.mana or 0
 local function add(slot)local d=myHero:GetSpellData(slot);if d and finite(d.mana)and d.mana>0 then need=need+d.mana end end
 if self:Ready(_E)then add(_E)end
 local q=myHero:GetSpellData(_Q);local n=self:Unleash()
 if q and finite(q.level)and q.level>=1 and n and n>=6 and not self:Buff(self.profile.q)then add(_Q)end
 if Menu.Combo.R:Value()and self:Ready(_R)then add(_R)end
 return myHero.mana>=need
end
-- Yunara-5: the bead passes through enemies, so only a wind wall blocks the ray.
function YunaraChampion:RayClear(p,u,spell)
 if not point(p)or GetDistance(p,myHero.pos)>spell.Range or not self:Current(u)then return false end
 if not spell.Collision then return true end
 local wall=OrbamaPrediction:GetCollision(myHero.pos,p,spell.Speed,spell.Delay,spell.Radius,spell.CollisionTypes,id(u));return not wall
end
-- Units (other than u) the bead meets before reaching u: each slows it for an
-- unmeasured time, so its arrival is unknown when this is not zero.
function YunaraChampion:RayUnits(u,spell)
 local origin=myHero.pos;local aim=point(u.pos);local dx,dz=aim.x-origin.x,aim.z-origin.z;local length=math.sqrt(dx*dx+dz*dz)
 if length<1 then return 0 end;local n=0
 for _,kind in ipairs({'lane','jungle','hero'})do
  for _,v in ipairs(self:Rows(kind,spell.Range+200))do if id(v)~=id(u)then local x,z=v.pos.x-origin.x,v.pos.z-origin.z
   local along=(x*dx+z*dz)/length;local across=math.abs(x*dz-z*dx)/length
   if along>0 and along<length and across<=spell.Radius+(v.boundingRadius or 0)then n=n+1 end
  end end
 end
 return n
end
function YunaraChampion:WAim(u,spell,name)
 if not self:Ready(_W)or myHero:GetSpellData(_W).name~=name or not self:Current(u)or not self:Allowed(u)or not self:Reach(u,spell.Range)then return nil end
 if name==self.profile.w2 and not self:Form(spell.Delay)then return nil end
 local pred=Core:Prediction(spell);pred:GetPrediction(u,myHero);local p=pred:CanHit(u.type==Obj_AI_Hero and 3 or 2)and point(pred.CastPosition)
 return p and self:RayClear(p,u,spell)and {position=p}or nil
end
function YunaraChampion:CastW(u,context,permission,rescue)
 if not self:Ready(_W)or not self:WReserve()or permission and not permission()then return false end
 local spell,name=self:WSettings();if not spell then return false end;local handle=u and u.handle
 local function resolve()
  if not u or u.handle~=handle then return nil end;local r=self:WAim(u,spell,name)
  return r and(not rescue or self:Rescue(u,spell,r.position))and r or nil
 end
 local aim=resolve();if not aim then return false end
 return self:Submit(_W,HK_W,aim.position,{owner='Arc',context=context,intentTarget=u,range=spell.Range,independent=false,prevalidateWorldCast=true,resolve=resolve,
  commitGuard=function()return Core:Current()and(not permission or permission())end,
  observe=function(q)return self:Native(q,name)end,
  validate=function(_,fresh)return self:Ready(_W)and myHero:GetSpellData(_W).name==name and self:WReserve()and self:Current(u)and u.handle==handle and self:Allowed(u)
   and fresh and self:RayClear(fresh.position,u,spell)and(name~=self.profile.w2 or self:Form(spell.Delay))and(not rescue or self:Rescue(u,spell,fresh.position))and(not permission or permission())end})
end
function YunaraChampion:Safe(p,offense)
 if not point(p)or type(Game.isWall)~='function'or Game.isWall(p)~=false or IsUnderTurret2(p)or GetEnemyCount(600,p)>Menu.Misc.Enemies:Value()then return false end
 return not offense or finite(myHero.maxHealth)and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.HP:Value()
end
function YunaraChampion:LegalDash(p,offense)
 local rank=myHero:GetSpellData(_R).level;local speed=finite(rank)and self.profile.eSpeeds[rank]
 -- The dash covers at least eMinRange: a nearer point is not where it would end, so it is not a legal landing.
 local d=point(p)and GetDistance(p,myHero.pos);return speed and d and d>=self.profile.eMinRange-.001 and d<=self.profile.eRange+.001 and self:Safe(p,offense)
  and self:Form(self.profile.eDelay+d/speed)or false
end
function YunaraChampion:EAim(goal)
 if not point(goal)then return nil end;local d=GetDistance(goal,myHero.pos);if d<50 then return nil end;return myHero.pos:Extended(goal,math.max(self.profile.eMinRange,math.min(d,self.profile.eRange)))
end
function YunaraChampion:CastE(goal,context,permission,offense,refresh)
 if not self:Ready(_E)or permission and not permission()then return false end
 local form=self:Form();local name=form and self.profile.e2 or self.profile.e;local aim=form and self:EAim(goal)
 if form and not self:LegalDash(aim,offense)or not form and self:Buff(self.profile.e)then return false end
 local function resolve()local p=self:EAim(refresh and refresh()or goal);return p and self:LegalDash(p,offense)and {position=p}or nil end
 return self:Submit(_E,HK_E,form and aim or nil,{owner='Steps',context=context,independent=false,prevalidateWorldCast=form,
  resolve=form and resolve or nil,observe=function(q)return self:Native(q,name)end,
  commitGuard=function()return Core:Current()and(not permission or permission())end,
  validate=function(_,fresh)return self:Ready(_E)and myHero:GetSpellData(_E).name==name and(not form or fresh and self:LegalDash(fresh.position,offense))
   and(form or not self:Buff(self.profile.e))and(not permission or permission())end})
end
function YunaraChampion:RPermission()return Menu.Misc.RAssist:Value()or GetMode()=='Combo'and Menu.Combo.R:Value()end
function YunaraChampion:RUseful(u)
 if not self:Current(u)or not self:Allowed(u)or not self:Reach(u,900)or not self:Safe(myHero.pos,true)then return false end
 local r=myHero:GetSpellData(_R);local w=myHero:GetSpellData(_W);local e=myHero:GetSpellData(_E)
 if not finite(w.mana)or not finite(e.mana)or w.mana<0 or e.mana<0 or myHero.mana<r.mana+w.mana+(Menu.Misc.ReserveE:Value()and e.mana or 0)then return false end
 -- Combo: a fight against several enemies, or the commitment to a kill: a target at half health or less that
 -- the upgraded attacks already reach. A full-health lone target does not get the transformation.
 if not Menu.Misc.RAssist:Value()then local n=0;for _,v in ipairs(self:Rows('hero',900))do if self:Allowed(v)then n=n+1 end end
  if n<Menu.Combo.RCount:Value()and not(u.maxHealth>0 and u.health/u.maxHealth<=.5 and _G.SDK.Data:IsInAutoAttackRange(myHero,u))then return false end
 end
 -- R is useful through native upgraded attacks or a reachable upgraded W.
 return _G.SDK.Data:IsInAutoAttackRange(myHero,u)or self:Ready(_W)
end
function YunaraChampion:StartR(u)
 if self.rStart or self.rGesture or not self:RPermission()or not self:Ready(_R)or not self:RUseful(u)then return false end
 local held=Menu.Misc.RAssist:Value();local context=held and Core:HeldContext(function()return Menu.Misc.RAssist:Value()end)or Core:ModeContext('Combo')
 local permission=held and function()return Menu.Misc.RAssist:Value()end or function()return Menu.Combo.R:Value()and GetMode()=='Combo'end
 local p={target=u,id=id(u),handle=u.handle,context=context,permission=permission,started=Game.Timer(),expires=Game.Timer()+1.2};self.rStart=p
 local ok=self:Submit(_R,HK_R,nil,{owner='Transcend',context=context,intentTarget=u,independent=false,
  observe=function(q)return self:Native(q,self.profile.r)end,
  validate=function()return self.rStart==p and permission()and self:Ready(_R)and self:RUseful(u)and u.handle==p.handle and id(u)==p.id end})
 if not ok then self.rStart=nil;return false end;self.rGesture=true;p.q=Core.lastIntent
 Core:AfterCast(HK_R,function()if self.rStart==p then p.observed=true end end);return true
end
function YunaraChampion:MaintainTransform()
 local form,b=self:Form();self.transform=form and {expires=ending(b),nativeStart=b.startTime}or nil
 local p=self.rStart;if not p then return false end;local r=Core.adapter:Poll(p.q.id)
 if not p.permission()or p.expires<Game.Timer()or not Core.adapter:ContextValid({context=p.context},'continuation')or not self:Current(p.target)or p.target.handle~=p.handle
  or r and(r.state=='cancelled_before_send'or r.state=='send_uncertain'or r.jobCancelled)then Core.adapter:Cancel(p.q.id,'transformation_ended');self.rStart=nil;return false end
 -- The transformation itself ends the wait: both transformed stages and an own
 -- buff that began after this request. (The native cast time read in the
 -- after-cast callback was not reliably there, which left only the timeout.)
 if form and finite(b.startTime)and b.startTime>=p.started-.05 then self.rStart=nil;return false end
 return true
end
function YunaraChampion:DamageW(u,spell)
 if not finite(myHero.bonusDamage)or not finite(myHero.ap)then return 0 end
 local form=spell==self.W2Spell;local rank=myHero:GetSpellData(form and _R or _W).level;local base=(form and self.profile.w2Base or self.profile.wBase)[rank]
 if not base then return 0 end;return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,
  (base+myHero.bonusDamage*(form and self.profile.w2AD or self.profile.wAD)+myHero.ap*(form and self.profile.w2AP or self.profile.wAP))*self:MinionFactor(u))
end
-- Yunara-1: W against lane minions by level (profile wMinion, conservative until measured).
function YunaraChampion:MinionFactor(u)
 if not u or u.type~=Obj_AI_Minion or u.team==300 or not self.profile.wMinion then return 1 end
 local level=myHero.levelData and myHero.levelData.lvl;if not finite(level)then return self.profile.wMinion[1].factor end
 local factor=self.profile.wMinion[1].factor
 for _,row in ipairs(self.profile.wMinion)do if level>=row.level then factor=row.factor end end
 return factor
end
function YunaraChampion:Rescue(u,spell,resolved)
 if not self:Current(u)or u.type==Obj_AI_Hero or u.team==300 or not self:Reach(u,spell.Range)then return false end
 local t=self:WImpact(u,spell);if not Core:Rescue(u,t,function()return self:DamageW(u,spell)end,spellOnly)then return false end
 -- A ready attack in reach always takes the last hit.
 if _G.SDK.Orbwalker:CanAttack()and _G.SDK.Data:IsInAutoAttackRange(myHero,u)then return false end
 -- LastHit must not soften other live units on the outgoing ray or linger.
 local aim=point(resolved)or self:Projected(u,t);local origin=myHero.pos;local dx,dz=aim.x-origin.x,aim.z-origin.z;local length=math.sqrt(dx*dx+dz*dz);if length<1 then return false end
 for _,v in ipairs(self:Rows('lane',1450))do if id(v)~=id(u)then local p=self:Projected(v,t);local x,z=p.x-origin.x,p.z-origin.z
  local along=(x*dx+z*dz)/length;local across=math.abs(x*dz-z*dx)/length
  local radius=spell==self.W2Spell and math.max(spell.Radius,self.profile.w2Radius)or spell.Radius
  if along>0 and along<=length+radius and across<=radius+(v.boundingRadius or 0)or spell==self.WSpell and GetDistance(p,aim)<=150+(v.boundingRadius or 0)then return false end
 end end;return true
end
function YunaraChampion:LastHit()
 if not Menu.LastHit.W:Value()or not self:Ready(_W)or not Core.manaAbove(Menu.LastHit.Mana:Value())then return false end
 local spell=self:WSettings();if not spell then return false end
 for _,u in ipairs(self:Rows('lane',1150))do if self:Rescue(u,spell)then return self:CastW(u,Core:RescueContext(),function()return Menu.LastHit.W:Value()and Core.manaAbove(Menu.LastHit.Mana:Value())end,true)end end
 return false
end
-- Yunara-3: no champion-damaging harass while standing in enemy tower range.
function YunaraChampion:TowerSafe(mode)return mode~='Harass'or not IsUnderTurret2(myHero.pos)end
function YunaraChampion:Combat(mode,context)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())or not self:TowerSafe(mode)then return false end
 local w=node.W:Value()and self:Ready(_W);local e=node.E:Value()and self:Ready(_E);if not w and not e then return false end
 local u=self:Target(1150);if not u then return false end;context=context or Core:ModeContext(mode);local handle=u.handle
 if w and(not node.SmartW:Value()or not self:Buff(self.profile.q)or not _G.SDK.Data:IsInAutoAttackRange(myHero,u))then
  if self:CastW(u,context,function()return node.W:Value()and Core.manaAbove(node.Mana:Value())and self:TowerSafe(mode)and(not node.SmartW:Value()or not self:Buff(self.profile.q)or not _G.SDK.Data:IsInAutoAttackRange(myHero,u))end)then return true end
 end
 if e and not _G.SDK.Data:IsInAutoAttackRange(myHero,u)and self:Reach(u,900)then
  return self:CastE(mousePos,context,function()return node.E:Value()and Core.manaAbove(node.Mana:Value())and self:TowerSafe(mode)and self:Current(u)and u.handle==handle and self:Allowed(u)
   and self:Safe(myHero.pos,true)and(not self:Form()or GetDistance(self:EAim(mousePos),u.pos)<GetDistance(myHero.pos,u.pos))end,true,function()return mousePos end)
 end;return false
end
function YunaraChampion:Combo()return self:Combat('Combo')end
function YunaraChampion:Harass()return self:Combat('Harass')end
-- Yunara-2: Harass while LaneClear is held, behind its toggle.
function YunaraChampion:ClearHarassAllowed()return Menu.Clear.SpellHarass:Value()and GetMode()=='LaneClear'end
function YunaraChampion:FarmHarass()
 if not self:ClearHarassAllowed()then return false end
 return self:Combat('Harass',Core:ModeContext('LaneClear',function()return self:ClearHarassAllowed()end))
end
-- Yunara-7: the last-hit W rescue also while LaneClear is held (spell-farm toggle).
function YunaraChampion:LaneRescue()
 if not Menu.Clear.SpellFarm:Value()or not Core:FarmModeEnabled('lane')or not Menu.LastHit.W:Value()or not self:Ready(_W)or not Core.manaAbove(Menu.LastHit.Mana:Value())then return false end
 local spell=self:WSettings();if not spell then return false end
 local context=Core:RescueContext(Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end))
 for _,u in ipairs(self:Rows('lane',1150))do if self:Rescue(u,spell)then
  return self:CastW(u,context,function()return Menu.LastHit.W:Value()and Menu.Clear.SpellFarm:Value()and Core.manaAbove(Menu.LastHit.Mana:Value())end,true)
 end end
 return false
end
function YunaraChampion:Clear(kind)
 local node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear']
 if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()or not node.W:Value()or not self:Ready(_W)or not Core.manaAbove(node.Mana:Value())then return false end
 local candidates={};local rows=self:Rows(kind,1150)
 if kind=='jungle'then rows=self:CampRows(rows)end
 for i=1,math.min(#rows,8)do local u=rows[i];local n=0;for _,v in ipairs(rows)do if GetDistance(u.pos,v.pos)<=150 then n=n+1 end end
  if kind=='jungle'and self:JungleSmart(u)or kind~='jungle'and n>=Menu.Clear.LaneClear.Count:Value()then candidates[#candidates+1]={unit=u,count=n}end
 end
 table.sort(candidates,function(a,b)return a.count>b.count or a.count==b.count and(a.unit.maxHealth or 0)>(b.unit.maxHealth or 0)end)
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 for _,candidate in ipairs(candidates)do local best=candidate.unit
  if self:CastW(best,context,function()
   if not node.W:Value()or not Core.manaAbove(node.Mana:Value())or not Menu.Clear.SpellFarm:Value()then return false end
   if kind=='jungle'then return self:JungleSmart(best)end;local n=0;for _,v in ipairs(self:Rows(kind,1150))do if GetDistance(best.pos,v.pos)<=150 then n=n+1 end end;return n>=Menu.Clear.LaneClear.Count:Value()
  end)then return true end
 end;return false
end
-- Yunara-6: jungle W stays on the camp being cleared: monsters within 600 of the
-- monster attacked last (else the nearest one), and it is saved while
-- empowered attacks already hit a monster in attack range.
function YunaraChampion:CampRows(rows)
 local anchor=_G.SDK.Orbwalker.LastTarget
 if not(anchor and anchor.team==300 and self:Current(anchor))then anchor=nil
  for _,u in ipairs(rows)do if not anchor or GetDistance(u.pos,myHero.pos)<GetDistance(anchor.pos,myHero.pos)then anchor=u end end
 end
 if not anchor then return {}end
 local out={};for _,u in ipairs(rows)do if GetDistance(u.pos,anchor.pos)<=600 then out[#out+1]=u end end;return out
end
function YunaraChampion:JungleSmart(u)
 return not(self:Buff(self.profile.q)and _G.SDK.Data:IsInAutoAttackRange(myHero,u))
end
function YunaraChampion:LaneClear()return self:Clear('lane')end
function YunaraChampion:JungleClear()return self:Clear('jungle')end
function YunaraChampion:Flee()
 -- The speed-up or dash and a slow on the pursuer are what Flee is for: no switches.
 if not self.gestures.FleeE and self:CastE(mousePos,Core:ModeContext('Flee'),nil,false,function()return mousePos end)then self.gestures.FleeE=true;return true end
 if self:Ready(_W)then local u=self:Target(1000);if u then return self:CastW(u,Core:ModeContext('Flee'))end end;return false
end
-- Yunara-8: a dash that ends within 300 and comes closer, made by the enemy
-- itself: knock-ups/knock-backs and pulls (forced displacements) are not gap-closes.
function YunaraChampion:Charging(u)
 local p=u.pathing
 return p and p.isDashing and point(p.endPos)and GetDistance(p.endPos,myHero.pos)<300 and GetDistance(p.endPos,myHero.pos)<GetDistance(u.pos,myHero.pos)
  and not HasInvalidDashBuff(u)or false
end
function YunaraChampion:Peel()
 if not Menu.Misc.PeelE:Value()or not self:Form()or not self:Ready(_E)then return false end
 for _,u in ipairs(self:Rows('hero',1200))do local p=u.pathing
  if self:Allowed(u)and self:Charging(u)then
   local goal=myHero.pos+(myHero.pos-u.pos):Normalized()*450
   return self:CastE(goal,nil,function()return Menu.Misc.PeelE:Value()and self:Current(u)and self:Charging(u)end,false,function()return myHero.pos+(myHero.pos-u.pos):Normalized()*450 end)
  end
 end;return false
end
function YunaraChampion:Assist()
 if self:RPermission()and not self.rGesture then local u=self:Target(900)
  if u and self:StartR(u)then return true end
 end;return false
end
-- The shared kill rule at W's arrival, for the form W is in.
function YunaraChampion:WKills(u)
 local spell=self:WSettings();if not spell or not self:Current(u)or u.type~=Obj_AI_Hero or IsInvulnerable(u)then return false end
 if spell==self.WSpell and self:RayUnits(u,spell)>0 then return false end
 return(Core:Lethal(u,self:WImpact(u,spell),function()return self:DamageW(u,spell)end,{kind='magical'}))
end
-- A killable enemy outside attack range is finished with W without a mode key (inside it the attacks do it).
function YunaraChampion:Finishers()
 if not self:Ready(_W)then return false end
 local rows=self:Rows('hero',self.profile.wRange)
 for i=1,math.min(#rows,5)do local u=rows[i]
  if self:Allowed(u)and not _G.SDK.Data:IsInAutoAttackRange(myHero,u)and self:WKills(u)
   and self:CastW(u,{priority='interactive'},function()return not _G.SDK.Data:IsInAutoAttackRange(myHero,u)and self:WKills(u)end)then return true end
 end
 return false
end
function YunaraChampion:Tick()
 if not Core:InputAvailable()or ShouldWait()then self.preview=nil;self.rStart=nil;return end
 self:MaintainIssued();self:MaintainTrace();if not self:RPermission()then self.rGesture=nil end
 if GetMode()~='Flee'then self.gestures.FleeE=nil end
 self.allow:Maintain()
 if self:MaintainTransform()or IsCasting()then return end
 if self:Peel()or self:Assist()or self:Finishers()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if self:FarmHarass()or self:LaneClear()or self:LaneRescue()then return end;self:JungleClear()
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and Menu.Draw.Preview:Value()and Game.Timer()>=(self.nextPreview or 0)then self:PreparePreview()end
end
function YunaraChampion:PreparePreview()
 -- The E landing only: the game shows Unleash, the form and Q. Kept for a second so a late preparation never
 -- blinks it; Draw shows it only while E is ready.
 local form=self:Form()
 self.preview={expires=Game.Timer()+1,landing=form and self:EAim(mousePos)};self.nextPreview=Game.Timer()+.15
end
function YunaraChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.Ranges:Value()then
  if IsReady(_W)then Draw.Circle(myHero.pos,self.profile.wRange,1,Draw.Color(255,150,200,255))end
  if IsReady(_E)then Draw.Circle(myHero.pos,self.profile.eRange,1,Draw.Color(255,200,220,100))end
 end
 local p=self.preview;if p and p.expires>Game.Timer()and Menu.Draw.Preview:Value()and p.landing and IsReady(_E)then
  Draw.Circle(p.landing,45,1,Draw.Color(255,100,255,200))
 end
end
function YunaraChampion:FeatureStatus()
 return {classic={supported=false,reason='installed_jade_yunara_asset_unavailable'},
  qBounces={supported=true,reason='bounded_unique_spread_candidates_no_speculative_item_or_repeated_onhit_damage'},
  wLingerLethal={supported=false,reason='future_linger_residency_ticks_and_execute_unverified'},
  normalEvadeE={supported=false,reason='movement_speed_is_not_a_dash_or_verified_immunity'}}
end
function YunaraChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Yunara: modes','Yunara: transformation'},function(page)return {title='Yunara assistance',cards=page==1 and {
  {'ATTACKS','Q needs eight native Unleash and a completed observed attack in its enabled mode. Spread candidates are unique; attacks and item procs are never duplicated.'},
  {'FARM','Enable spell farming and use the provider Lane/Jungle binds. Q follows actual attacks; W rescues isolated missed CS (LastHit and LaneClear) using confirmed incoming forecasts and the reduced damage W deals to minions. Jungle W stays on the camp being cleared. The clear-harass toggle harasses champions while LaneClear is held, never from under their tower.'},
  {'W','Both forms use fresh predicted outgoing geometry. Smart W preserves useful empowered attacks; ready escape E resources remain reserved when configured.'}}or {
  {'R','The R bind transforms near a useful selected enemy; Combo transforms against several enemies or for a target at half health or less inside attack range. Native R cast, owned buff and both transformed spell stages confirm transformation; timers do not create it.'},
  {'E','Normal E gives movement speed. Transformed E dashes toward the cursor with a safe landing. Flee always uses it; dashing away from an enemy who dashes onto you has its own switch; Evade may always use the dash. A killable enemy outside attack range is finished with W without a mode key.'},
  {'CONTROL','Releasing the originating mode or key cancels unsent work. Uncertain input is reconciled without blind replay.'}}}end)
end
-- As before, no own-channel gate is registered for Yunara.
Core:StandardPolicy(YunaraChampion,{damageTypes={Q='physical',W='magical'},channel=false,
 methods={FarmHarass=function()return Core:ModeContext('LaneClear',function()return Menu.Clear.SpellHarass:Value()end)end}})
YunaraChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={}
local normalSupported={["Yunara"]=true}

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
