return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Thresh"]=function()return _G.OrbamaFamily:Require("81b7050a61aa003ff662e2eb1783d77fff37089699377398ce2e8f18a32fa6af")()end
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
if champion=="Thresh" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Thresh',profiles={normal=true,classic=false},
 Create=function(context)
-- Independent Normal-only controller; CombatProfiles/thresh-provenance.json.
-- A native hook, recast input, dash and completed landing are separate facts.
local profile=ChampionProfiles('Thresh')[myHero.charName]
local finite,id,point,own,expiry=Core.finite,Core.id,Core.point,Core.mine,Core.buffExpiry
-- Pinned by this champion's regressions: only a ready, in-range lethal attack keeps the spell (Core:Rescue).
local readyAttack={attack='ready'}
local function cleanup(self)if self.flashCombo then self.flashCombo:Cancel('controller_closed')end;self.hook=nil;self.leap=nil;self.lantern=nil;self.attack=nil;self.preview=nil;self.assistUsed=false end
local ThreshChampion=class("ThreshChampion")
function ThreshChampion:__init()
 assert(myHero.charName=='Thresh','No verified Classic Thresh kit');self.profile=profile;self.allies={};self.targets={}
 self.QRange=1075;self.WRange=950;self.ERange=500
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.5,Radius=70,Range=1075,Speed=1900,Collision=true,
  CollisionTypes={OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL}}
 self:LoadMenu();self.allow=Core:TargetConsent(Menu.Misc.Targets,self,'','E');self.targets=self.allow.targets;self:Discover();Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function()self:OnPostAttack()end)
 Core:RegisterCleanup('Thresh',function()cleanup(self)end)
 local ok,why=Core:RegisterPreparation('Thresh.preview',{intervalMs=125,maxDelayMs=500,units=2,maxUnits=2},
  function()self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.previewFallback=not ok and why=='unsupported'
 -- Evade may throw the lantern at Thresh's own feet: he is shielded when it lands (profile.shieldSource).
 -- start = the throw (0.5 s) plus a margin. Q2 is a pull to an enemy, not a dodge: it is not offered.
 self.shieldRegistered,self.shieldReason,self.shieldDefense=Core:RegisterShield({name='ThreshW',slot=_W,key=HK_W,profile=profile.id,spell=profile.w,
  source=profile.shieldSource,ready=function()return self:Ready(_W)and not self.lantern end,amount=function()return self:ShieldAmount()end,
  duration=profile.shieldDuration,start=profile.lanternTravel+.1,target=function()return point(myHero.pos)end,kind='self_shield'})
 self.flashCombo=Core:FlashFollow('ThreshFlashBox')
 -- Health-bar damage and KILL mark (S9): ready Q, E and R in reach plus one attack, against current health.
 Core:RegisterComboDamage(function(u)
  if not IsValid(u)then return 0 end
  local d=GetDistance(u.pos,myHero.pos);local ok,aa=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
  return(ok and finite(aa)and aa or 0)+(self:Ready(_Q)and d<=1075 and self:Damage(u,_Q)or 0)+(self:Ready(_E)and d<=450 and self:Damage(u,_E)or 0)
   +(self:Ready(_R)and d<=450 and self:Damage(u,_R)or 0),true
 end)
end
function ThreshChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_Thresh',name='AyyyyIO - Thresh'})
 for _,mode in ipairs({'Combo','Harass'})do Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q',value=true});Menu[mode]:MenuElement({id='Q2',name='Fly to a hooked enemy with Q2',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='E',name='Use E',value=true});Menu[mode]:MenuElement({id='Pull',name='E pulls toward you (off: pushes away)',value=true})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 15,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R',value=true})
 Menu.Combo:MenuElement({id='RCount',name='R must catch at least',value=2,min=1,max=5,step=1})
 Menu.Combo:MenuElement({id='W',name='Throw W to a far ally after a hook or E lands',value=true})
 Menu.Combo:MenuElement({id='FlashR',name='Flash during R to box a target just out of reach',value=false})
 Menu:MenuElement({type=MENU,id='Support',name='Protection'})
 Menu.Support:MenuElement({id='E',name='Stop dashes and channels with E or a hook',value=true})
 Menu.Support:MenuElement({id='Finish',name='Finish champions with Q, E or R',value=true})
 Menu.Support:MenuElement({id='Hook',name='Hook enemies who cannot move',value=true})
 Menu.Support:MenuElement({id='RCount',name='Auto R when it catches at least (0: never)',value=3,min=0,max=5,step=1})
 Menu.Support:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 Menu.Support:MenuElement({type=MENU,id='Allies',name='Ally priority for W (0: never)'})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[mode]:MenuElement({id='Q',name='Use Q',value=true});Menu.Clear[mode]:MenuElement({id='E',name='Use E',value=true})
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true});Menu.LastHit:MenuElement({id='E',name='Use E on a lone minion an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='Lantern',name='Throw W to the most important ally',key=string.byte('N')})
 Menu.Misc:MenuElement({id='Push',name='Push the selected target away with E',key=string.byte('K')})
 Menu.Misc:MenuElement({id='QMax',name='Longest hook distance',value=1075,min=300,max=1075,step=25,menu=false})
 Menu.Misc:MenuElement({id='Q2HP',name='Never fly in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='Q2Enemies',name='Never fly into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='DenyTurret',name='Never fly in under an enemy turret',value=true})
 Menu.Misc:MenuElement({id='FleeR',name='Use R on a pursuer when fleeing',value=true})
 Menu.Misc:MenuElement({id='FleeW',name='Shield yourself with W when fleeing',value=true})
 Menu.Misc:MenuElement({type=MENU,id='Targets',name='Enemy champions Q may target'})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false});Menu.Draw:MenuElement({id='Preview',name='How many enemies the R box would catch',value=true})
end
function ThreshChampion:Ready(slot,recast)
 local d=myHero:GetSpellData(slot);local names={[0]=recast and profile.q2 or profile.q,[1]=profile.w,[2]=profile.e,[3]=profile.r}
 return d and d.name==names[slot]and finite(d.level)and d.level%1==0 and d.level>=1 and d.level<=(slot==_R and 3 or 5)
  and finite(d.currentCd)and d.currentCd==0 and Game.CanUseSpell(slot)==0 and finite(d.mana)and d.mana>=0 and d.mana<=myHero.mana or false
end
-- kind: 'ally' (the player first) | 'enemy' | 'jungle' | 'lane'.
function ThreshChampion:Rows(kind,range)return Core:Rows((kind=='ally'or kind=='enemy')and 'hero'or kind,range,kind=='ally'and 'self')end
function ThreshChampion:Current(u)return u~=nil and point(u.pos)~=nil and Core:CurrentUnit(u,u.team==myHero.team)end
function ThreshChampion:Discover()
 for _,u in ipairs(self:Rows('ally',3000))do if not self.allies[id(u)]then local key=StableUnitMenuKey(self,'A',u)
  -- One priority per ally (0: never); it replaces the former per-ally submenu (switch and priority).
  Menu.Support.Allies:MenuElement({id=key..'P',name=u.charName,value=3,min=0,max=5,step=1,from='Automation.Support.Allies.'..key..'.Priority'})
  self.allies[id(u)]={node=Menu.Support.Allies[key..'P'],handle=u.handle}
 else self.allies[id(u)].handle=u.handle end end
 self.allow:Refresh()
end
function ThreshChampion:Allowed(u)return self.allow:Allowed(u)end
function ThreshChampion:AllyAllowed(u)local row=self.allies[id(u)];return row and row.handle==u.handle and row.node:Value()>0 end
function ThreshChampion:Buff(u,name,owned)return(Core:OwnBuff(u,name,owned,true))end
-- margin: seconds the control must still last (default 0.65).
function ThreshChampion:Controlled(u,margin)
 if not u or not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 or u.buffCount%1~=0 then return false end
 local types={[5]=true,[8]=true,[9]=true,[12]=true,[21]=true,[22]=true,[23]=true,[25]=true,[29]=true,[30]=true,[35]=true}
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and types[b.type]and finite(b.count)and b.count>0 and finite(expiry(b))and expiry(b)>Game.Timer()+(margin or .65)then return true end
 end;return false
end
function ThreshChampion:Native(q)
 return Core:NativeCast(q)~=nil
end
function ThreshChampion:Damage(u,slot)
 local d=myHero:GetSpellData(slot);local base=slot==_Q and profile.qBase[d.level]or slot==_E and profile.eBase[d.level]or slot==_R and profile.rBase[d.level]
 if not base or not finite(myHero.ap)then return 0 end
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+(slot==_Q and .9 or slot==_E and .6 or 1)*myHero.ap)
end
function ThreshChampion:QPlan(u)
 if not self:Ready(_Q)or not self:Current(u)or u.team==myHero.team or not self:Allowed(u)then return nil end
 local distance=GetDistance(u.pos,myHero.pos);if distance>Menu.Misc.QMax:Value()or distance<150 then return nil end
 local pred=Core:Prediction(self.QSpell);pred:GetPrediction(u,myHero)
 if not pred:CanHit(2)or not point(pred.CastPosition)or GetDistance(pred.CastPosition,myHero.pos)>1075 then return nil end
 local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,pred.CastPosition,1900,.5,70,self.QSpell.CollisionTypes,id(u))
 return wall==false and finite(count)and count==0 and{position=point(pred.CastPosition)}or nil
end
-- planner (optional): fn(self,u) -> {position} instead of the predicted QPlan (a dash end point).
function ThreshChampion:CastQ(u,context,permission,planner)
 planner=planner or self.QPlan
 if permission and not permission()then return false end;local plan=planner(self,u);if not plan then return false end;local handle=u.handle
 if not Core:Cast(HK_Q,plan.position,{intentTarget=u,context=context,range=1075,prevalidateWorldCast=true,deferAttackWindup=true,
  resolve=function()if u.handle~=handle or permission and not permission()then return nil,'hook_context_changed'end;return planner(self,u)end,
  observe=function(q)return self:Native(q)end,
  validate=function(q,r)
   if not(self:Ready(_Q)and self:Current(u)and u.handle==handle and self:Allowed(u)and(not permission or permission())and r and point(r.position))then return false end
   local distance=GetDistance(u.pos,myHero.pos);if distance<150 or distance>Menu.Misc.QMax:Value()then return false end
   local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,r.position,1900,.5,70,self.QSpell.CollisionTypes,id(u));return wall==false and finite(count)and count==0
  end})then return false end
 self.hook={target=u,handle=handle,context=context,q=Core.lastIntent,expires=Game.Timer()+3};return true
end
-- A hook mark whose populated source names someone else (the shared reader stops at an unreadable expiry
-- before it looks at the owner).
function ThreshChampion:ForeignMark(u)
 if not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 then return true end
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==profile.hook then local a,c=b.source,b.sourcenID
   if a and a~=0 and not own(a)or c and c~=0 and not own(c)then return true end
  end
 end;return false
end
function ThreshChampion:OwnedHook()
 local row=self.hook
 if row then local q=row.q;local result=Core.adapter:Poll(q.id)
  if row.expires<=Game.Timer()or not self:Current(row.target)or row.target.handle~=row.handle or q.cancelled or not q.continue()
   or result and(result.state=='cancelled_before_send'or result.state=='send_uncertain')then self.hook=nil;return nil end
  if not q.observedAt then return nil end
  local b,why=Core:OwnBuff(row.target,'ThreshQ',true,true);if b then return row.target,b,row.context end
  -- The mark is on the target of this controller's observed hook but its timing or owner cannot be read:
  -- answered as false, so the fly-in cannot wait for an end it does not know.
  if(why=='buff_expiry_unknown'or why=='buff_ownership_unknown')and self:Ready(_Q,true)and not self:ForeignMark(row.target)then return row.target,false,row.context end
  return nil
 end
 -- A recast may adopt an existing genuinely owned native tether.
 if not self:Ready(_Q,true)then return nil end;local found,buff
 for _,u in ipairs(self:Rows('enemy',975))do local b=self:Buff(u,'ThreshQ',true)
  if b then if found then return nil end;found,buff=u,b end
 end;return found,buff
end
function ThreshChampion:SafeLanding(u)
 if not self:Current(u)or not self:Allowed(u)or GetDistance(u.pos,myHero.pos)>975 or type(Game.isWall)~='function'or Game.isWall(u.pos)~=false then return false end
 local radius=myHero.boundingRadius;if not finite(radius)or radius<=0 then return false end
 for _,offset in ipairs({{radius,0},{-radius,0},{0,radius},{0,-radius}})do
  if Game.isWall(Vector(u.pos.x+offset[1],u.pos.y,u.pos.z+offset[2]))~=false then return false end
 end
 if Menu.Misc.DenyTurret:Value()and IsUnderTurret2(u.pos)then return false end
 return myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.Q2HP:Value()and GetEnemyCount(600,u.pos)<=Menu.Misc.Q2Enemies:Value()
end
-- The fly-in waits for the end of the hook mark: the target stays stunned for the whole mark, an ally has
-- time to take the lantern, and the gap-close is the same. It goes earlier only when waiting would lose
-- it: the target is about to leave the leap range, or is nearly dead and the fight is decided now.
function ThreshChampion:LeapNow(u,b)
 return expiry(b)-Game.Timer()<=profile.leapHold or GetDistance(u.pos,myHero.pos)>900
  or finite(u.health)and finite(u.maxHealth)and u.maxHealth>0 and u.health/u.maxHealth<=.25
end
function ThreshChampion:RecastQ(context,permission)
 if self.leap or not self:Ready(_Q,true)or not permission or not permission()then return false end
 local u,b=self:OwnedHook();if not u or b==nil then return false end;local blind=b==false
 if not blind and(expiry(b)<=Game.Timer()+.15 or not self:LeapNow(u,b))or not self:SafeLanding(u)then return false end
 local handle,ends=u.handle,not blind and expiry(b)
 if not Core:Cast(HK_Q,nil,{context=context,intentTarget=u,observe=function(q)return self:Native(q)end,
  validate=function()
   if not(self:Ready(_Q,true)and permission()and u.handle==handle and self:SafeLanding(u))then return false end
   if blind then local held,mark=self:OwnedHook();return held==u and mark==false end
   local fresh=self:Buff(u,'ThreshQ',true);return fresh and expiry(fresh)==ends and expiry(fresh)>Game.Timer()+.15
  end})then return false end
 self.leap={q=Core.lastIntent,target=u,handle=handle,expires=Game.Timer()+1.5,origin=point(myHero.pos)};return true
end
function ThreshChampion:ContinueLeap()
 local row=self.leap;if not row then return false end;local q=row.q;local result=Core.adapter:Poll(q.id)
 if not result or result.state=='cancelled_before_send'or q.cancelled or not q.continue()or Game.Timer()>row.expires then self.leap=nil;return false end
 if not q.observedAt then return true end
 -- The leap holds the whole tick. It ends when the observed recast's dash is
 -- over, wherever it ended, when the hooked target is gone, or 0.6 s after the
 -- cast if no dash was seen. Requiring an arrival within 150 units of the target
 -- held everything for 1.5 s whenever the pull was cut short or the target moved.
 row.observedAt=row.observedAt or Game.Timer()
 local dashing=myHero.pathing and myHero.pathing.isDashing==true;if dashing then row.dash=true end
 local gone=row.target.handle~=row.handle or not self:Current(row.target)
 if gone or not dashing and(row.dash or Game.Timer()-row.observedAt>.6)then self.leap=nil;self.hook=nil;return false end
 return true
end
function ThreshChampion:PredictPoint(u,time)
 if not self:Current(u)or not finite(time)or time<0 then return nil end
 local p=u.pathing;if not p or not p.hasMovePath and not p.isDashing then return point(u.pos)end
 if p.isDashing then
  if not point(p.endPos)or not finite(p.dashSpeed)or p.dashSpeed<=0 then return nil end
  return u.pos:Extended(p.endPos,math.min(GetDistance(u.pos,p.endPos),p.dashSpeed*time))
 end
 if not point(p.endPos)or not finite(u.ms)or u.ms<=0 then return nil end
 return u.pos:Extended(p.endPos,math.min(GetDistance(u.pos,p.endPos),u.ms*time))
end
function ThreshChampion:FlayPlan(u,pull)
 if not self:Ready(_E)or not self:Current(u)or u.team==myHero.team or myHero.pathing and myHero.pathing.isDashing or GetDistance(u.pos,myHero.pos)>450 then return nil end
 local predicted=self:PredictPoint(u,.4);if not predicted or GetDistance(predicted,myHero.pos)>450 or GetDistance(predicted,myHero.pos)<10 then return nil end
 local aim=pull and myHero.pos+(myHero.pos-predicted)or predicted
 return {position=point(aim),data={target=predicted,pull=pull}}
end
function ThreshChampion:CastE(u,pull,context,permission)
 if permission and not permission()then return false end;local plan=self:FlayPlan(u,pull);if not plan then return false end;local handle=u.handle
 return Core:Cast(HK_E,plan.position,{intentTarget=u,context=context,range=500,prevalidateWorldCast=true,deferAttackWindup=true,
  resolve=function()if u.handle~=handle or permission and not permission()then return nil,'flay_context_changed'end;return self:FlayPlan(u,pull)end,
  observe=function(q)return self:Native(q)end,
  validate=function(q,r)
   if not(self:Ready(_E)and u.handle==handle and self:Current(u)and r and r.data and point(r.position)and(not permission or permission()))then return false end
   local target=self:PredictPoint(u,.4);if not target or GetDistance(target,myHero.pos)>450 then return false end
   local desired=pull and myHero.pos+(myHero.pos-target)or target
   return GetDistance(desired,r.position)<=35
  end})
end
-- spot: an optional function giving the point the ally is being taken to (a hook pulling them).
function ThreshChampion:LanternPlan(u,spot)
 if not self:Ready(_W)or not self:Current(u)or u.team~=myHero.team or not self:AllyAllowed(u)or type(Game.isWall)~='function'then return nil end
 local target;if spot then target=spot()else target=self:PredictPoint(u,.65)end;if not target then return nil end
 local distance=GetDistance(target,myHero.pos);if distance>profile.lanternFar then return nil end
 -- An ally beyond W range gets the lantern at full range (just inside 950) on the line to them and walks the rest.
 -- Casting does not force their pickup or rescue.
 if distance>945 then target=point(myHero.pos:Extended(target,945))end
 if not target or Game.isWall(target)~=false then return nil end
 return {position=target}
end
function ThreshChampion:Lantern(u,context,permission,spot)
 if self.lantern or permission and not permission()then return false end;local plan=self:LanternPlan(u,spot);if not plan then return false end;local handle=u.handle
 -- range bounds the recipient here (the shared policy measures the intent target); LanternPlan keeps the throw itself inside 950.
 if not Core:Cast(HK_W,plan.position,{context=context,range=profile.lanternFar,intentTarget=u,prevalidateWorldCast=true,
  resolve=function()if u.handle~=handle or permission and not permission()then return nil,'lantern_context_changed'end;return self:LanternPlan(u,spot)end,
  observe=function(q)return self:Native(q)end,
  validate=function(q,r)
   if not(self:Ready(_W)and self:Current(u)and u.handle==handle and self:AllyAllowed(u)and r and point(r.position)
    and Game.isWall(r.position)==false and(not permission or permission()))then return false end
   local fresh=self:LanternPlan(u,spot);return fresh~=nil and GetDistance(fresh.position,r.position)<=35
  end})then return false end
 self.lantern={q=Core.lastIntent,target=u,handle=handle,position=plan.position,expires=Game.Timer()+6};return true
end
function ThreshChampion:ObserveLantern()
 local row=self.lantern;if not row then return end;local result=Core.adapter:Poll(row.q.id)
 if not result or result.state=='cancelled_before_send'or row.q.cancelled or Game.Timer()>row.expires or not self:Current(row.target)or row.target.handle~=row.handle then self.lantern=nil;return end
 if row.q.observedAt then local shield=self:Buff(row.target,'ThreshWShield',true)
  if shield then row.shieldObserved=true;row.shieldEnds=expiry(shield)end
 end
 -- No ally pickup, movement or rescue is inferred from the shield or timer.
end
-- Is this ally in real danger? Hits on their way come from the shared service (attack, targeted cast,
-- turret, skillshot); a healthy ally trading attacks is not in danger. Private additions, because the
-- service does not answer them: an enemy dash landing on the ally, low health with an enemy near, being
-- outnumbered, and hard crowd control with an enemy close.
function ThreshChampion:Threat(u)
 local hp=finite(u.health)and finite(u.maxHealth)and u.maxHealth>0 and u.health/u.maxHealth or 1;local best,score
 local function take(kind,value)if not best or value>score then best,score={kind=kind},value end end
 if hp<=.6 and Core:AllyThreat(u,1.5)then take('hit',1000+(1-hp)*500)end
 local near,close=0,false
 for _,enemy in ipairs(self:Rows('enemy',2400))do local d=GetDistance(enemy.pos,u.pos)
  if d<900 then near=near+1 end;if d<700 then close=true end
  if enemy.pathing and enemy.pathing.isDashing and point(enemy.pathing.endPos)and GetDistance(enemy.pathing.endPos,u.pos)<300 then take('dash',700+(1-hp)*500)end
 end
 if hp<=.3 and near>=1 then take('low',800+(1-hp)*500)end
 if near>=3 then take('outnumbered',650+(1-hp)*300)end
 if close and self:Controlled(u)then take('cc',600)end
 return best,score
end
function ThreshChampion:ThreatValid(u)return self:Threat(u)~=nil end
-- An ally caught by Blitzcrank's hook lands next to him: the lantern goes there (buff name from the
-- reference script; a name that never appears never triggers).
function ThreshChampion:Grabbed(u)
 if not Core:OwnBuff(u,'rocketgrab2')then return nil end
 for _,enemy in ipairs(self:Rows('enemy',2000))do if enemy.charName=='Blitzcrank'then return enemy end end
end
function ThreshChampion:AutoLantern(context,manual)
 if not self:Ready(_W)or self.lantern or not Core.manaAbove(Menu.Support.Mana:Value())then return false end
 local best,score,puller
 for _,u in ipairs(self:Rows('ally',profile.lanternFar))do if u~=myHero and self:AllyAllowed(u)then
  local grab=not manual and self:Grabbed(u);local value
  if manual then value=100+(1-u.health/u.maxHealth)*500 elseif grab then value=1500 else local _;_,value=self:Threat(u)end
  if value then local spot=grab and function()return self:Current(grab)and self:Grabbed(u)==grab and point(grab.pos)or nil end or nil
   if self:LanternPlan(u,spot)then value=value+self.allies[id(u)].node:Value()*1000
    if not best or value>score then best,score,puller=u,value,spot end
   end
  end
 end end
 if not best then return false end
 return self:Lantern(best,context,function()return Core.manaAbove(Menu.Support.Mana:Value())and(manual and Menu.Misc.Lantern:Value()or not manual and(puller~=nil or self:ThreatValid(best)))end,puller)
end
-- A dash ends at a known point. The hook goes there when it arrives after the landing and the target cannot walk
-- out of the 70-radius line (plus its body) in the time between; collision is checked on the ray to that point.
function ThreshChampion:DashHookPlan(u)
 if not self:Ready(_Q)or not self:Current(u)or u.team==myHero.team or not self:Allowed(u)then return nil end
 local p=u.pathing;if not p or not p.isDashing or not point(p.endPos)or not finite(p.dashSpeed)or p.dashSpeed<=0 then return nil end
 local landing=point(p.endPos);local d=GetDistance(landing,myHero.pos)
 if d<150 or d>Menu.Misc.QMax:Value()or d>1075 then return nil end
 local arrive=.5+d/1900;local lands=GetDistance(u.pos,landing)/p.dashSpeed
 if lands>arrive or(arrive-lands)*(finite(u.ms)and u.ms or 0)>self.QSpell.Radius+(u.boundingRadius or 0)then return nil end
 local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,landing,1900,.5,70,self.QSpell.CollisionTypes,id(u))
 return wall==false and finite(count)and count==0 and{position=landing}or nil
end
-- Flay direction that peels for `ally`: pull the enemy toward Thresh when the ally stands beyond it, push otherwise.
function ThreshChampion:PeelPull(spot,ally)
 return(spot.x-myHero.pos.x)*(ally.pos.x-spot.x)+(spot.z-myHero.pos.z)*(ally.pos.z-spot.z)>0
end
function ThreshChampion:DefensiveE()
 if not Menu.Support.E:Value()or not Core.manaAbove(Menu.Support.Mana:Value())then return false end
 -- A channel out of Flay's reach (or with Flay down) is stopped by the hook when it lands before the channel ends.
 if self:Ready(_Q)then for _,u in ipairs(self:Rows('enemy',Menu.Misc.QMax:Value()))do local d=GetDistance(u.pos,myHero.pos)
  if(d>450 or not self:Ready(_E))and Core:CanInterrupt(u,.5+d/1900)then local start=u.activeSpell.startTime
   if self:CastQ(u,{priority='critical'},function()local a=u.activeSpell
    return Menu.Support.E:Value()and Core.manaAbove(Menu.Support.Mana:Value())and a and a.startTime==start and Core:CanInterrupt(u,.5+GetDistance(u.pos,myHero.pos)/1900)end)then return true end
  end
 end end
 if self:Ready(_E)then
 for _,u in ipairs(self:Rows('enemy',450))do local p,a=u.pathing,u.activeSpell
  local dash=p and p.isDashing and point(p.endPos)and GetDistance(p.endPos,myHero.pos)<300
  -- Thresh-2 (b): a dash ending next to an ally is peeled the same way, pulled or pushed away from that ally.
  local pull=false
  if not dash and p and p.isDashing and point(p.endPos)then
   for _,ally in ipairs(self:Rows('ally',1000))do if ally~=myHero and GetDistance(p.endPos,ally.pos)<300 then dash=true;pull=self:PeelPull(point(p.endPos),ally);break end end
  end
  local channel=a and a.valid and not a.isStopped and Core:IsChannelCast(a)and finite(a.castEndTime)and a.castEndTime>Game.Timer()+.4
  if dash or channel then local start=a and a.startTime;local endPos=dash and point(p.endPos)
   if self:CastE(u,pull,{priority='critical'},function()
    if not Menu.Support.E:Value()or not Core.manaAbove(Menu.Support.Mana:Value())then return false end
    if dash then return u.pathing and u.pathing.isDashing and point(u.pathing.endPos)and GetDistance(u.pathing.endPos,endPos)<35 end
    local fresh=u.activeSpell;return fresh and fresh.valid and not fresh.isStopped and Core:IsChannelCast(fresh)and fresh.startTime==start and fresh.castEndTime>Game.Timer()+.4
   end)then return true end
  end
 end
 end
 -- Thresh-2 (a): a dash out of Flay's answer is hooked at its end point.
 if self:Ready(_Q)then for _,u in ipairs(self:Rows('enemy',1500))do
  local plan=self:DashHookPlan(u)
  if plan then local landing=plan.position
   local function planner(_,v)local fresh=self:DashHookPlan(v);if fresh then return fresh end
    -- The dash is over: a target standing at its end is hooked like any other.
    return GetDistance(v.pos,landing)<=35 and self:QPlan(v)or nil end
   if self:CastQ(u,{priority='critical'},function()return Menu.Support.E:Value()and Core.manaAbove(Menu.Support.Mana:Value())end,planner)then return true end
  end
 end end
 return false
end
-- Thresh-1: finish a champion without a mode key: Flay or the hook when Core:Lethal holds at their impact
-- (E 0.389 s, Q 0.5 s + travel at 1900), R when the first wall break kills a champion the box holds.
function ThreshChampion:Kills(u,slot,impact)
 return Core:Lethal(u,impact,function()return self:Damage(u,slot)end,{kind='magical'})==true
end
function ThreshChampion:BoxHolds(u)
 for _,row in ipairs(self:Crossings().rows)do if row.unit==u then return true end end
 local inner=400*math.cos(math.pi/5)-35
 local formed=self:PredictPoint(u,.65);return formed~=nil and GetDistance(u.pos,myHero.pos)<inner and GetDistance(formed,myHero.pos)<inner
end
function ThreshChampion:Finisher()
 if not Menu.Support.Finish:Value()then return false end
 local function on()return Menu.Support.Finish:Value()end;local context={priority='interactive'}
 for _,u in ipairs(self:Rows('enemy',Menu.Misc.QMax:Value()))do
  if self:Current(u)then local d=GetDistance(u.pos,myHero.pos)
   if self:Ready(_E)and d<=450 and self:Kills(u,_E,profile.eCast)then
    local pull=self:FlayChoice(u,true)~=false
    if self:CastE(u,pull,context,function()return on()and self:Kills(u,_E,profile.eCast)end)then return true end
   end
   if self:Ready(_Q)and self:Kills(u,_Q,.5+d/1900)and self:CastQ(u,context,function()
    return on()and self:Kills(u,_Q,.5+GetDistance(u.pos,myHero.pos)/1900)end)then return true end
   if self:Ready(_R)and d<=450 and self:Kills(u,_R,profile.rCast)and self:BoxHolds(u)
    and Core:Cast(HK_R,nil,{context=context,deferAttackWindup=true,intentTarget=u,observe=function(q)return self:Native(q)end,
     validate=function()return self:Ready(_R)and on()and self:Current(u)and self:Kills(u,_R,profile.rCast)and self:BoxHolds(u)end})then return true end
  end
 end
 return false
end
-- Thresh-4: a hook on an enemy who cannot leave the line before it lands (Core:ControlledHit), without a mode key.
-- No fly-in follows on its own.
function ThreshChampion:AutoHook()
 local node=Menu.Support
 if not node.Hook:Value()or not self:Ready(_Q)or not Core.manaAbove(node.Mana:Value())then return false end
 for _,u in ipairs(self:Rows('enemy',Menu.Misc.QMax:Value()))do
  -- A hard-control buff is the cheap gate; the shared hit window decides whether the line still catches it.
  if self:Current(u)and self:Allowed(u)and self:Controlled(u,.2)and Core:ControlledHit(u,self.QSpell,myHero.pos)then
   if self:CastQ(u,{priority='interactive'},function()return node.Hook:Value()and Core.manaAbove(node.Mana:Value())and Core:ControlledHit(u,self.QSpell,myHero.pos)end)then return true end
  end
 end
 return false
end
-- Thresh-7: The Box then Flash (Core:FlashFollow, spell first, off by default): R toward a target just beyond the
-- box, and the Flash inside the 0.45 s cast puts it inside the walls. The landing keeps the target's predicted
-- position inside the conservative inner radius and stays out of enemy turret range.
function ThreshChampion:FlashBox()
 local combo=self.flashCombo
 if not combo or combo:Busy()or not Menu.Combo.FlashR:Value()or not Menu.Combo.R:Value()or not self:Ready(_R)then return false end
 local status=Core:FlashStatus();if not status then return false end
 local rCost=myHero:GetSpellData(_R).mana;if not finite(rCost)or myHero.mana<status.cost+rCost then return false end
 local inner=400*math.cos(math.pi/5)-35
 local selected=_G.SDK.TargetSelector.Selected;local u=self:Current(selected)and selected or GetTarget(inner+status.range)
 if not self:Current(u)or u.team==myHero.team then return false end
 local spot=self:PredictPoint(u,profile.rCast+.2);if not spot then return false end
 local d=GetDistance(spot,myHero.pos);if d<=inner or d>inner+status.range-50 then return false end
 local landing=point(myHero.pos:Extended(spot,math.min(status.range,d-inner+120)));local handle=u.handle
 local function authorized()return Menu.Combo.FlashR:Value()and Menu.Combo.R:Value()and GetMode()=='Combo'end
 local function valid(pos)local at=self:PredictPoint(u,.2)
  return u.handle==handle and self:Current(u)and at~=nil and GetDistance(at,pos)<=inner-40 and not IsUnderTurret2(pos)end
 return combo:Start{order='spell_first',aim=landing,authorized=authorized,valid=valid,mana=rCost,window=.3,ttl=1.2,
  follow=function(context)return Core:Cast(HK_R,nil,{owner='FlashBox',context=context,observe=function(q)return self:Native(q)end,
   validate=function()return authorized()and self:Ready(_R)and u.handle==handle and self:Current(u)end})end}
end
-- The enemy Thresh holds right now: his hooked target, or one carrying his Flay effect (buff name from
-- the reference script).
function ThreshChampion:Engaged()
 local u=self:OwnedHook();if u then return u end
 for _,enemy in ipairs(self:Rows('enemy',700))do if self:Buff(enemy,'threshestun',true)then return enemy end end
end
function ThreshChampion:EngageLantern(context)
 if not Menu.Combo.W:Value()or not self:Ready(_W)or self.lantern or not Core.manaAbove(Menu.Combo.Mana:Value())then return false end
 local hooked=self:Engaged();if not hooked then return false end;local best,score
 for _,u in ipairs(self:Rows('ally',profile.lanternFar))do if u~=myHero and self:AllyAllowed(u)and finite(u.range)
  and GetDistance(u.pos,myHero.pos)>350 and GetDistance(u.pos,hooked.pos)>u.range+(u.boundingRadius or 0)+(hooked.boundingRadius or 0)and self:LanternPlan(u)then
  local value=self.allies[id(u)].node:Value();if not best or value>score then best,score=u,value end
 end end
 return best and self:Lantern(best,context,function()return Menu.Combo.W:Value()and Core.manaAbove(Menu.Combo.Mana:Value())and self:Engaged()==hooked end)or false
end
function ThreshChampion:Crossings()
 local rows={};local inner=400*math.cos(math.pi/5)-35;local outer=435
 for _,u in ipairs(self:Rows('enemy',1000))do local p=u.pathing
  if p and p.hasMovePath and not p.isDashing and point(p.endPos)and finite(u.ms)and u.ms>0 then
   local formed=self:PredictPoint(u,.65);local future=self:PredictPoint(u,1.65)
   if formed and future then local first,last=GetDistance(formed,myHero.pos),GetDistance(future,myHero.pos)
    if first<inner and last>outer or first>outer and last<inner then rows[#rows+1]={unit=u,handle=u.handle,formed=formed,future=future}end
   end
  end
 end;return {count=#rows,rows=rows,expires=Game.Timer()+.25}
end
-- Enemies the box holds: those about to walk across a wall, and those standing inside when the walls
-- form, who must cross one to leave. The inner radius is the conservative one Crossings uses.
function ThreshChampion:Caught()
 local crossing=self:Crossings();local n=crossing.count;local seen={};for _,row in ipairs(crossing.rows)do seen[id(row.unit)]=true end
 local inner=400*math.cos(math.pi/5)-35
 for _,u in ipairs(self:Rows('enemy',400))do if not seen[id(u)]and GetDistance(u.pos,myHero.pos)<inner then
  local formed=self:PredictPoint(u,.65);if formed and GetDistance(formed,myHero.pos)<inner then n=n+1 end
 end end;return n
end
-- minimum: enemies who will walk across a wall. caught (optional): enemies held in the box, counted as a
-- fallback, because enemies standing next to Thresh after a hook or Flay never satisfy the crossing rule.
function ThreshChampion:Box(context,permission,minimum,caught)
 local function worth()return self:Crossings().count>=minimum or caught and caught>0 and self:Caught()>=caught or false end
 if not self:Ready(_R)or not permission or not permission()or not worth()then return false end
 return Core:Cast(HK_R,nil,{context=context,deferAttackWindup=true,observe=function(q)return self:Native(q)end,
  validate=function()return self:Ready(_R)and permission()and worth()end})
end
function ThreshChampion:AutoBox()
 local node=Menu.Support;local function allowed()return node.RCount:Value()>0 and Core.manaAbove(node.Mana:Value())end
 return allowed()and self:Ready(_R)and self:Box({},allowed,math.huge,node.RCount:Value())or false
end
function ThreshChampion:ShieldAmount()
 local d=myHero:GetSpellData(_W);local base=d and profile.shield[d.level];if not base then return 0 end
 -- Souls add to the shield only when the soul count is read from Thresh's own buff.
 return base+(self:Charge().souls or 0)*profile.shieldPerSoul
end
-- What Flay should do to this target: true pulls, false pushes, nil keeps E. A pull only when it takes
-- the target somewhere (at least 250 away, or walking off); a push to peel: Thresh himself when low, or
-- a weakened ally the push moves the enemy away from.
function ThreshChampion:FlayChoice(u,pull)
 if not self:Current(u)then return nil end;local d=GetDistance(u.pos,myHero.pos)
 if not pull then return false end
 if myHero.maxHealth>0 and myHero.health/myHero.maxHealth<=.35 and d<=300 then return false end
 for _,ally in ipairs(self:Rows('ally',900))do if ally~=myHero and ally.maxHealth>0 and ally.health/ally.maxHealth<=.5 and GetDistance(ally.pos,u.pos)<=350
  and(u.pos.x-myHero.pos.x)*(ally.pos.x-u.pos.x)+(u.pos.z-myHero.pos.z)*(ally.pos.z-u.pos.z)<0 then return false end end
 local p=u.pathing;local leaving=p and p.hasMovePath and not p.isDashing and point(p.endPos)and GetDistance(p.endPos,myHero.pos)>d+50
 if d>=250 or leaving then return true end;return nil
end
function ThreshChampion:OnPostAttack()
 local witness=Core:AttackWitness(self.attack);if witness then self.attack=witness end
end
function ThreshChampion:Charge()
 local state={known=false,stage=0,souls=nil};local rows={}
 if not finite(myHero.buffCount)or myHero.buffCount<0 or myHero.buffCount>128 or myHero.buffCount%1~=0 then return state end
 for i=0,myHero.buffCount do local b=myHero:GetBuff(i)
  if b and type(b.name)=='string'and finite(b.count)and b.count>0 then local name=b.name:lower();local ends=expiry(b)
   local a,c=b.source,b.sourcenID;local ours=(own(a)or own(c))and(not a or a==0 or own(a))and(not c or c==0 or own(c))
   if ours and finite(ends)and ends>Game.Timer()then
    local stage=tonumber(name:match('^threshepassive([1-4])$'))
    if stage then rows[#rows+1]=stage end
    if name=='threshpassivesouls'and b.count%1==0 and b.count<=10000 then state.souls=b.count end
   end
  end
 end
 if #rows==1 then state.known=true;state.stage=rows[1]end;return state
end
function ThreshChampion:ChargedAttackUseful(u)
 local state=self:Charge();return state.known and state.stage>=3 and self:Current(u)
  and _G.SDK.Data:IsInAutoAttackRange(myHero,u)and _G.SDK.Orbwalker:CanAttack()
end
function ThreshChampion:Combat(mode)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return false end;local context=Core:ModeContext(mode)
 if mode=='Combo'and self:EngageLantern(context)then return true end
 if node.Q2:Value()and self:RecastQ(context,function()return node.Q2:Value()and Core.manaAbove(node.Mana:Value())end)then return true end
 if mode=='Combo'and self:FlashBox()then return true end
 if mode=='Combo'and node.E:Value()and self:Ready(_E)then
  for _,v in ipairs(self:Rows('enemy',450))do local p=v.pathing
   if p and p.isDashing and point(p.endPos)and GetDistance(p.endPos,myHero.pos)>GetDistance(v.pos,myHero.pos)+50 then local endPos=point(p.endPos)
    if self:CastE(v,true,context,function()return node.E:Value()and Core.manaAbove(node.Mana:Value())and v.pathing and v.pathing.isDashing
     and point(v.pathing.endPos)~=nil and GetDistance(v.pathing.endPos,endPos)<35 end)then return true end
   end
  end
 end
 if mode=='Combo'and Menu.Combo.R:Value()and self:Box(context,function()return Menu.Combo.R:Value()and Core.manaAbove(node.Mana:Value())end,Menu.Combo.RCount:Value(),math.max(2,Menu.Combo.RCount:Value()))then return true end
 local u=GetTarget(1075);if not self:Current(u)then return false end
 local flay;if node.E:Value()then flay=self:FlayChoice(u,node.Pull:Value())end
 if flay~=nil and not(mode=='Combo'and self:ChargedAttackUseful(u))and self:CastE(u,flay,context,function()return node.E:Value()and Core.manaAbove(node.Mana:Value())and(not(mode=='Combo'and self:ChargedAttackUseful(u)))and self:FlayChoice(u,node.Pull:Value())==flay end)then return true end
 if node.Q:Value()and not(mode=='Combo'and self:ChargedAttackUseful(u))then
  return self:CastQ(u,context,function()return node.Q:Value()and Core.manaAbove(node.Mana:Value())and not(mode=='Combo'and self:ChargedAttackUseful(u))end)
 end;return false
end
function ThreshChampion:Combo()return self:Combat('Combo')end
function ThreshChampion:Harass()return self:Combat('Harass')end
function ThreshChampion:CSUseful(u,slot)
 if not self:Current(u)or u.team==300 or u.team==myHero.team then return false end
 -- Flay rescue refuses other nearby lane minions.
 return Core:Rescue(u,slot==_Q and(.5+GetDistance(u.pos,myHero.pos)/1900)or .4,function()return self:Damage(u,slot)end,readyAttack)
  and(slot~=_E or #self:Rows('lane',500)<=1)
end
function ThreshChampion:Farm(kind,node,context,rescue)
 if not Core.manaAbove(node.Mana:Value())then return false end
 local rows=self:Rows(kind,node.Q:Value()and 1075 or 450);local target
 for _,u in ipairs(rows)do if(not rescue or node.Q:Value()and self:CSUseful(u,_Q)or node.E:Value()and self:CSUseful(u,_E))and(not target or u.maxHealth>target.maxHealth)then target=u end end
 if not target then return false end
 local function permission(slot)return node[slot==_Q and 'Q'or 'E']:Value()and Core.manaAbove(node.Mana:Value())
  and(not rescue or self:CSUseful(target,slot))and(slot~=_E or kind~='lane'or #self:Rows('lane',500)==1)end
 if node.E:Value()and self:CastE(target,false,context,function()return permission(_E)end)then return true end
 if node.Q:Value()then return self:CastQ(target,context,function()return permission(_Q)end)end;return false
end
function ThreshChampion:LaneClear()
 if not Core:FarmModeEnabled('lane')or not Menu.Clear.SpellFarm:Value()then return false end
 return self:Farm('lane',Menu.Clear.LaneClear,Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end),false)
end
function ThreshChampion:JungleClear()
 if not Core:FarmModeEnabled('jungle')or not Menu.Clear.SpellFarm:Value()then return false end
 return self:Farm('jungle',Menu.Clear.JungleClear,Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end),false)
end
function ThreshChampion:LastHit()return self:Farm('lane',Menu.LastHit,Core:RescueContext(),true)end
function ThreshChampion:Flee()
 local context=Core:ModeContext('Flee');local u=GetTarget(450)
 if self:Current(u)and self:CastE(u,false,context,function()return true end)then return true end
 if Menu.Misc.FleeR:Value()and self:Box(context,function()return Menu.Misc.FleeR:Value()end,1)then return true end
 -- Thresh-5: the lantern at Thresh's own feet shields him (50-130 + 2 per soul for 4 s) while a chaser is within 600.
 if Menu.Misc.FleeW:Value()and self:Ready(_W)and not self.lantern and #self:Rows('enemy',600)>0 then
  return Core:Cast(HK_W,point(myHero.pos),{context=context,observe=function(q)return self:Native(q)end,
   validate=function()return Menu.Misc.FleeW:Value()and self:Ready(_W)and #self:Rows('enemy',600)>0 end})
 end
 return false
end
function ThreshChampion:Assist()
 local m=Menu.Misc
 if m.Lantern:Value()and self:AutoLantern(Core:HeldContext(function()return m.Lantern:Value()end),true)then return true end
 local u=GetTarget(1075)
 return m.Push:Value()and self:Current(u)and self:CastE(u,false,Core:HeldContext(function()return m.Push:Value()end),function()return m.Push:Value()end)or false
end
function ThreshChampion:PreparePreview()
 -- The box count only: the game shows the hooked enemy, Flay's charge and the lantern shield. Kept for a second
 -- so a late preparation never blinks it; Draw shows it only while R is ready.
 self.preview={crossings=self:Ready(_R)and self:Caught()or 0,expires=Game.Timer()+1}
end
function ThreshChampion:Tick()
 if ShouldWait()or not Core:Available()then self.hook=nil;self.leap=nil;self.attack=nil;return end
 if Game.Timer()>=self.allow.nextRefresh then self:Discover()end;self:ObserveLantern();self:OwnedHook()
 if self.flashCombo:Busy()and self.flashCombo:Maintain()then return end
 if self:ContinueLeap()or IsCasting()then return end
 if self:Assist()or self:DefensiveE()or self:Finisher()or self:AutoHook()or self:AutoLantern()or self:AutoBox()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LaneClear'then if not self:LaneClear()then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and Menu.Draw.Preview:Value()and Game.Timer()>=(self.nextPreview or 0)then self.nextPreview=Game.Timer()+.125;self:PreparePreview()end
end
function ThreshChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.Ranges:Value()then for slot,range in pairs({[_E]=500,[_W]=950,[_Q]=1075})do if IsReady(slot)then Draw.Circle(myHero.pos,range,1,Draw.Color(255,140,240,190))end end end
 local p=self.preview;if Menu.Draw.Preview:Value()and p and p.expires>Game.Timer()and p.crossings>0 and IsReady(_R)then
  Draw.Text('R box catches '..p.crossings,14,myHero.pos2D.x,myHero.pos2D.y+45,Draw.Color(255,160,240,190))
 end
end
function ThreshChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Thresh: control','Thresh: support'},function(page)
  return {title='Thresh assistance',cards=page==1 and {
   {'MODES','Provider binds select combat, harass, separate lane/jungle, LastHit and Flee. Support spell farming starts disabled.'},
   {'HOOK','Combo and Harass hook the target. The fly-in with Q2 waits for the end of the hook mark so the stun runs its full time, and goes earlier only when the target would get out of reach or is nearly dead. Flying in under a turret starts forbidden.'},
   {'FLAY','Flay pulls a target that is at least a short walk away or walking off, and pushes to peel for you at low health or for a weakened ally. The push bind always pushes the selected target away. Without a mode key Flay stops dashes onto you or an ally and nearby channels; a channel farther away is stopped with a hook when it can land in time, and a dash with a hook at its end point.'}}or {
   {'LANTERN','The lantern bind throws W to the most important ally, at full range toward an ally who is farther away. On its own the lantern goes to an ally in danger: a hit on its way at lowered health, low health with an enemy near, outnumbered, crowd controlled, dashed onto or hooked. The ally chooses whether to take it.'},
   {'BOX','Box is used when enemies will walk across a wall, or when it holds enough enemies standing inside: the Combo count, and a separate count without a mode key.'},
   {'FARM','LastHit protects lethal normal attacks and confirmed incoming kills. Flay rescue refuses other nearby lane minions; unverified passive damage is excluded from guaranteed CS.'}}}
 end)
end
Core:StandardPolicy(ThreshChampion,{damageTypes={Q='magical',E='magical',R='magical'},exceptions={non_interrupting_summoner=true},
 methods={Finisher=function()return {priority='interactive'}end,AutoHook=function()return {priority='interactive'}end},
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot,slot==_Q and q.spellName==profile.q2)end;return true end})
ThreshChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={}
local normalSupported={["Thresh"]=true}

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
