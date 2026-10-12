return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Twitch"]=function()return _G.OrbamaFamily:Require("6cb9591923b22a84d167bc3e1640b3cb25157609c432fa4898943d136f707417")()end
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
if champion=="Twitch" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Twitch',profiles={normal=true,classic=true},
 Create=function(context)
local profiles=AbilityProfiles.controllers.Twitch
local finite,identity=Core.finite,Core.id
local function valid(u)return IsValid(u)and u.pos and u.team~=myHero.team end
local function distance(a,b)return GetDistance(a.pos or a,b.pos or b)end
local function still(u)return u.pathing and u.pathing.hasMovePath==false and not u.pathing.isDashing end
local TwitchChampion=class("TwitchChampion")
function TwitchChampion:__init()
 self.profile=assert(profiles[myHero.charName],'unsupported Twitch profile')
 self.data=assert(ChampionProfiles('Twitch')[myHero.charName],'unsupported Twitch profile data')
 self.WSpell=AbilityProfiles.Spell(myHero.charName,'W',OrbamaPrediction)
 self.ESpell=AbilityProfiles.Spell(myHero.charName,'E',OrbamaPrediction)
 self.WSpell.Collision=true;self.WSpell.CollisionTypes={OrbamaPrediction.COLLISION_YASUOWALL}
 self:LoadMenu();self.qRecall=nil
 self.duel=Core:TargetConsent(Menu.Combo.R1v1Targets,self,'Against ','R1v1')
 Core:RegisterCleanup('twitch-gameplay',function()self.qRecall=nil;self.rPreview=nil;self.stealthPreview=nil;self.venom=nil;self.ePreview=nil;self.rBolt=nil;self.qBreak=nil end)
 self.preparedStealth,self.stealthPreparationStatus=Core:RegisterPreparation('stealth-timer',{intervalMs=100,maxDelayMs=250,units=1,maxUnits=1},function()
  local buff,expires=self:Stealth();self.stealthPreview={at=Core.adapter:Now(),present=buff~=nil,expires=expires};return true
 end,function()return Menu.Draw.qtimer~=nil and Menu.Draw.qtimer:Value()end,function()self.stealthPreview=nil end)
 -- E damage preview (Twitch-5): at most five champions every 100 ms; Draw only reads these rows.
 local ok,why=Core:RegisterPreparation('e-preview',{intervalMs=100,maxDelayMs=300,units=1,maxUnits=1},function()self:PrepareEPreview();return true end,
  function()return Menu.Draw.EDamage:Value()end,function()self.ePreview=nil end)
 self.ePreviewFallback=not ok and why=='unsupported'
 -- Health-bar damage (S9): a ready E on owned poison (useful damage after shields) plus one attack.
 Core:RegisterComboDamage(function(u)
  local total=SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0
  if self:Ready(_E)then local row=self:EResult(u);if row and finite(row.useful)then total=total+row.useful end end
  return total,true
 end)
 if SDK.Orbwalker and type(SDK.Orbwalker.OnPostAttack)=='function'then SDK.Orbwalker:OnPostAttack(function()self:OnPostAttack()end)end
 Callback.Add('Tick',function()self:OnTick()end);Callback.Add('Draw',function()self:Draw()end)
end
function TwitchChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Twitch'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='W',name='Use W',value=true})
  Menu[mode]:MenuElement({id='E',name='Use E',value=true})
  Menu[mode]:MenuElement({id='Estacks',name='E at this many poison stacks',value=6,min=1,max=6,step=1})
  Menu[mode]:MenuElement({id='Eenemies',name='E needs that many stacks on at least',value=1,min=1,max=5,step=1,menu=false})
  Menu[mode]:MenuElement({id='EExpire',name='E early before poison ends or the target escapes',value=true,menu=false})
  if mode=='Combo'then
   Menu.Combo:MenuElement({id='R',name='Use R',value=true})
   Menu.Combo:MenuElement({id='Renemies',name='R needs at least this many enemies',value=2,min=1,max=5,step=1})
   Menu.Combo:MenuElement({id='Rrange',name='R counts enemies within',value=750,min=300,max=1500,step=50,menu=false})
   Menu.Combo:MenuElement({id='RLine',name='R counts only enemies lined up for piercing',value=false,menu=false})
   Menu.Combo:MenuElement({id='RReach',name='Use R to reach a kill just outside attack range',value=true})
   Menu.Combo:MenuElement({id='R1v1',name='Use R in a one-on-one against the champions below',value=false})
   Menu.Combo:MenuElement({type=MENU,id='R1v1Targets',name='One-on-one R'})
  end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Combo'and 0 or 30,min=0,max=100,step=5,menu=mode~='Combo'})
 end
 Menu.Harass:MenuElement({id='SpellHarass',name='Also harass champions while lane clearing',value=false,toggle=true,key=string.byte('K'),callback=function(v)CheckChatBlock(Menu.Harass.SpellHarass,v)end})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear','LastHit'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode})
  if mode~='LastHit'then Menu.Clear[mode]:MenuElement({id='W',name='Use W',value=true})end
  Menu.Clear[mode]:MenuElement({id='E',name=mode=='LastHit'and 'Use E on minions an attack cannot take'or 'Use E',value=true})
  Menu.Clear[mode]:MenuElement({id='Count',name=mode=='JungleClear'and 'Monsters an ability must hit'or 'Minions an ability must hit',value=mode=='LaneClear'and 3 or 1,min=1,max=6,step=1,menu=mode=='LaneClear'or false})
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='qrecall',name='Recall in stealth (Q, then recall)',key=string.byte('T')})
 Menu.Misc:MenuElement({id='stopq',name='Never break stealth with W',value=true})
 Menu.Misc:MenuElement({id='PreserveE',name='Stay stealthed rather than use E unless it kills',value=true})
 Menu.Misc:MenuElement({id='stopr',name='No W while R is active',value=false,menu=false})
 Menu.Misc:MenuElement({id='UrgentE',name='E when low and being attacked',value=true})
 Menu.Misc:MenuElement({id='UrgentHP',name='Low means below health %',value=25,min=5,max=100,step=5,menu=false})
 Menu.Misc:MenuElement({id='QGapclose',name='Use Q when an enemy dashes onto you',value=true})
 Menu.Misc:MenuElement({id='QFlee',name='Use Q when fleeing',value=true})
 Menu.Misc:MenuElement({id='WGapclose',name='Slow an enemy that dashes onto you (W)',value=true})
 Menu.Misc:MenuElement({id='ESteal',name='Secure Baron, Dragon or Herald with E',value=true})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 -- The game shows the stealth time; only the reveal range (Normal: an established radius) is drawn.
 if self.profile.detect then Menu.Draw:MenuElement({id='qtimer',name='Reveal range while stealthed',value=true})end
 Menu.Draw:MenuElement({id='EDamage',name='Mark enemies E kills',value=true})
end
function TwitchChampion:Buff(u,alias,owned,at)
 if not u or not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 or u.buffCount%1~=0 then return end
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==alias and finite(b.count)and b.count>0 then
   local expires=Core.buffExpiry(b)
   local source=b.source or b.caster;local kind=type(source)
   local id=kind=='number'and source or(kind=='table'or kind=='userdata')and identity(source)
   if finite(expires)and expires>(at or Game.Timer())and(not owned or id==myHero.networkID or id==myHero.handle or u==myHero and source==nil)then return b,expires end
  end
 end
end
-- Normal only: count the poison's refreshes per enemy (every stack restarts its duration), capped at 6 and
-- started at 1 when the poison is first seen, so it never exceeds the real number. Whether the Normal host
-- reports the stack number in `stacks`/`count` is not live-verified (the reference script does not trust it).
-- Champions are read every tick; minions and monsters within E range every 100 ms (Twitch-7: lane and jungle E
-- no longer depend on the unverified native field). The full scan is bounded to 64 units by Objects().
function TwitchChampion:TrackPoison()
 if self.profile.id~='normal'then return end
 local rows=self.venom or {};self.venom=rows
 local now=Game.Timer();local full=not self.nextUnitPoison or now>=self.nextUnitPoison
 local list=full and self:Objects()or nil
 if full then self.nextUnitPoison=now+.1;if not list then full=false end end
 if not list then list=self:Objects(true)end
 if not list then return end
 local live={}
 for _,u in ipairs(list)do local id=u.networkID;local hero=u.type==Obj_AI_Hero
  if hero or distance(u,myHero)<=self.ESpell.Radius then
   local b,expires=self:Buff(u,self.profile.poison,true)
   if b and id then
    live[id]=true;local native=b.stacks;if native==nil then native=b.count end
    local row=rows[id]
    if not row or row.handle~=u.handle or row.expires<=now then row={n=1,handle=u.handle,expires=expires,native=native,changed=false,hero=hero};rows[id]=row
    else
     if expires>row.expires+.05 then row.n=math.min(6,row.n+1)end
     if native~=row.native then row.changed=true;row.native=native end
     row.expires=expires
    end
   end
  end
 end
 for id,row in pairs(rows)do if not live[id]and(full or row.hero or row.expires<=now)then rows[id]=nil end end
end
-- Development evidence only (Twitch-7): stack particles near a unit, to settle whether the native stacks/count
-- field is the stack number. Never a runtime stack source until live names are confirmed.
function TwitchChampion:StackParticles(u)
 if not Core.logger or type(Game.ParticleCount)~='function'or type(Game.Particle)~='function'then return end
 local count=Game.ParticleCount();if not finite(count)or count<0 then return end
 local names={}
 for i=1,math.min(count,400)do local p=Game.Particle(i);local name=p and type(p.name)=='string'and p.name:lower()
  if name and name:find('twitch',1,true)and name:find('stack',1,true)and p.pos and distance(p.pos,u)<=200 then names[#names+1]=name;if #names>=4 then break end end
 end
 return table.concat(names,',')
end
-- Stacks, expiry and where the number came from. The native field is used whenever it is a plausible stack
-- number. The observed count replaces it only when the native field is not one, or when it has never moved
-- while more refreshes were seen than it reports (a field that does not count stacks).
function TwitchChampion:Poison(u,impact)
 local b,expires=self:Buff(u,self.profile.poison,true,Game.Timer()+(impact or 0));if not b then return end
 local n=b.stacks;if n==nil then n=b.count end
 local plausible=finite(n)and n%1==0 and n>=1 and n<=6
 local row=self.venom and self.venom[u.networkID]
 if row and row.handle==u.handle and row.expires>Game.Timer()and(not plausible or not row.changed and row.n>n)then
  return row.n,expires,'observed'
 end
 if not plausible then return end
 return n,expires,'native'
end
function TwitchChampion:Stealth()return self:Buff(myHero,self.profile.stealth,true)end
function TwitchChampion:RActive()return self:Buff(myHero,self.profile.r,true)end
function TwitchChampion:Cost(slot)local d=myHero:GetSpellData(slot);return d and finite(d.mana)and math.max(0,d.mana)or math.huge end
function TwitchChampion:Ready(slot)return IsReady(slot)and myHero:GetSpellData(slot).level>0 and myHero.mana>=self:Cost(slot)end
function TwitchChampion:Objects(heroesOnly)
 if heroesOnly then
  local out,seen={},{};local units=Core:DecisionUnits('GetEnemyHeroes')
  if #units>24 then return end
  for _,u in ipairs(units)do if valid(u)and u.networkID and not seen[u.networkID]and distance(u,myHero)<=1800 then seen[u.networkID]=true;out[#out+1]=u end end
  return out
 end
 local out,seen={},{};local counts={Game.HeroCount(),Game.MinionCount()}
 if not finite(counts[1])or counts[1]>24 or counts[1]<0 or counts[1]%1~=0 or not finite(counts[2])or counts[2]>256 or counts[2]<0 or counts[2]%1~=0 then return end
 for kind=1,2 do for i=1,counts[kind]do local u=kind==1 and Game.Hero(i)or Game.Minion(i)
  if valid(u)and u.networkID and not seen[u.networkID]and distance(u,myHero)<=1800 then seen[u.networkID]=true;out[#out+1]=u;if #out>64 then return end end
 end end
 return out
end
function TwitchChampion:EImpact(u)return OrbamaPrediction:GetLaunchDelay(self.ESpell)end
function TwitchChampion:AttackRescues(u)
 if not SDK.Data:IsInAutoAttackRange(myHero,u)or not SDK.Orbwalker:CanAttack()then return false end
 local attack=SDK.Attack
 local windup=attack:GetWindup();local speed=attack:GetProjectileSpeed()
 if not finite(windup)or windup<0 or not(speed==math.huge or finite(speed)and speed>0)then return false end
 local impact=windup+distance(u,myHero)/speed
 local health=SDK.HealthPrediction:GetPrediction(u,impact)
 if not finite(health)or health<=0 then return false end
 return SDK.Damage:GetAutoAttackDamage(myHero,u,true)>=health+math.max(0,u.hpRegen or 0)*impact+math.max(0,u.shieldAD or 0)
end
-- Mitigated E damage. Both parts carry the player's own outgoing modifier (Exhaust, Core:OutgoingScale; Twitch-6).
function TwitchChampion:EDamage(u,n)
 local rank=myHero:GetSpellData(_E).level;local base=self.profile.eBase[rank]
 n=n or self:Poison(u,self:EImpact(u));if not base or not n then return 0,0 end
 local physical=base+n*(10+5*rank+self.profile.eAD*myHero.bonusDamage)
 local magic=n*self.profile.eAP*myHero.ap
 if self.profile.id=='classic'then physical=physical+magic;magic=0 end
 local scale=Core:OutgoingScale()
 return scale*SDK.Damage:CalculateDamage(myHero,u,SDK.DAMAGE_TYPE_PHYSICAL,physical),scale*SDK.Damage:CalculateDamage(myHero,u,SDK.DAMAGE_TYPE_MAGICAL,magic)
end
-- Private kill rule on purpose: E is physical plus magic damage in one hit, and Core:Lethal weighs one kind.
-- A champion that cannot die at impact (undying, stasis, revive; Core:CannotDie) is never lethal (Twitch-6).
function TwitchChampion:EResult(u)
 local impact=self:EImpact(u)
 if not finite(impact)or impact<0 then return end
 local n,_,source=self:Poison(u,impact);if not n or not valid(u)or distance(u,myHero)>self.ESpell.Radius or Core:SpellProtected(u)~=false then return end
 local physical,magic=self:EDamage(u,n)
 local result=Core:MixedHealthEstimate(u,impact,physical,magic);if not result then return end
 result.target=u;result.stacks=n;result.stackSource=source;result.magic=magic;result.impact=impact
 if result.lethal and u.type==Obj_AI_Hero then local blocked,why=Core:CannotDie(u,impact);if blocked then result.lethal=false;result.refused=why end end
 -- Development trace: which evidence the stack number came from (native field, observed refreshes, particles).
 if Core.logger then local row=self.venom and self.venom[u.networkID];local now=Game.Timer()
  if(u.type==Obj_AI_Hero or row)and(self.particleNext or 0)<=now then self.particleNext=now+1
   Core:Trace('e_stacks',{target=u.networkID,kind=u.type==Obj_AI_Hero and 'hero'or u.team==300 and 'monster'or 'minion',stacks=n,source=source,native=row and row.native,observed=row and row.n,particles=self:StackParticles(u),profile=self.profile.id},1000)
  end
 end
 return result
end
function TwitchChampion:Preserve(slot,secure)
 if self.qRecall then return false end
 if slot==_W and Menu.Misc.stopq:Value()and self:Stealth()then return false end
 -- A kill is taken even from stealth; every other E respects the switch.
 if slot==_E and not secure and Menu.Misc.PreserveE:Value()and self:Stealth()then return false end
 if slot==_W and Menu.Misc.stopr:Value()and self:RActive()then return false end
 return true
end
function TwitchChampion:Target(range)
 local selected=SDK.TargetSelector.Selected
 if valid(selected)and distance(selected,myHero)<=range then return selected end
 local t=SDK.Orbwalker:GetTarget();if valid(t)and t.type==Obj_AI_Hero and distance(t,myHero)<=range then return t end
 t=GetTarget(range);if valid(t)then return t end
end
function TwitchChampion:CombatE(menu,secure)
 if not self:Ready(_E)or not secure and not Core.manaAbove(menu.Mana:Value())or not self:Preserve(_E,secure)then return false end
 local list=self:Objects(true);if not list then return false end
 local count,urgent=0,false
 for _,u in ipairs(list)do if u.type==Obj_AI_Hero then
  local result=self:EResult(u);if result then
   if secure and result.lethal then return true end
   if not secure then
    if result.stacks>=menu.Estacks:Value()then count=count+1 end
    local _,expires=self:Poison(u)
    if result.lethal or menu.EExpire:Value()and result.stacks>=2 and expires-Game.Timer()<.65 then urgent=true end
    if menu.EExpire:Value()and result.stacks>=2 and u.pathing and u.pathing.hasMovePath and u.posTo and distance(u.posTo,myHero)>1200 and distance(u,myHero)>1100 then urgent=true end
   end
  end
 end end
 return not secure and(count>=menu.Eenemies:Value()or urgent)
end
function TwitchChampion:CastE(validate,owner,context,priority,secure)
 local function allowed()return self:Ready(_E)and self:Preserve(_E,secure)and validate()end
 if not allowed()then return false end
 return Core:Cast(HK_E,nil,{owner=owner,context=context,priority=priority,validate=allowed})
end
function TwitchChampion:UrgentEAllowed()
 if not Menu.Misc.UrgentE:Value()or not finite(myHero.health)or not finite(myHero.maxHealth)or myHero.maxHealth<=0
  or myHero.health*100/myHero.maxHealth>Menu.Misc.UrgentHP:Value()or not Core:IncomingAttack(myHero,0,1)then return false end
 local list=self:Objects(true);if not list then return false end
 for _,u in ipairs(list)do local row=self:EResult(u)
  if row and row.stacks>=2 and row.useful>0 then return true end
 end
 return false
end
function TwitchChampion:UrgentE()
 if not Menu.Misc.UrgentE:Value()then return false end
 return self:CastE(function()return self:UrgentEAllowed()end,'urgent-e',{priority='critical'},'critical')
end
function TwitchChampion:DefensiveQ(flee)
 local function allowed()
  if not self:Ready(_Q)or self:Stealth()or self.qRecall or not finite(myHero.maxMana)or myHero.maxMana<=0
   or myHero.mana*100/myHero.maxMana<20 then return false end
  if flee then return Menu.Misc.QFlee:Value()and SDK.Orbwalker.Modes[SDK.ORBWALKER_MODE_FLEE]end
  if not Menu.Misc.QGapclose:Value()then return false end
  local enemies=self:Objects(true);if not enemies then return false end
  for _,enemy in ipairs(enemies)do if Core:ApproachingDash(enemy,myHero.pos,450)then return true end end
  return false
 end
 if not allowed()then return false end
 local context=flee and Core:ModeContext('Flee')or{priority='interactive'}
 return Core:Cast(HK_Q,nil,{owner=flee and 'flee-q'or 'gapclose-q',context=context,validate=allowed})
end
-- Flee: Q first. With Q down, W slows the nearest pursuer; never from stealth and never while Q is still
-- fading in (the cast would give the position away or restart nothing useful).
function TwitchChampion:FleeW()
 local function open()
  return SDK.Orbwalker.Modes[SDK.ORBWALKER_MODE_FLEE]and not self:Stealth()and not self.qRecall
   and Game.Timer()-(Core.observedSpells[_Q]or -math.huge)>self.profile.fade+.25
 end
 if not self:Ready(_W)or not open()then return false end
 local list=self:Objects(true);if not list then return false end
 local best,near
 for _,u in ipairs(list)do local d=distance(u,myHero);if d<=700 and(not near or d<near)then best,near=u,d end end
 if not best then return false end
 return self:CastW(best,nil,function()return open()and distance(best,myHero)<=750 end)
end
function TwitchChampion:Flee()return self:DefensiveQ(true)or self:FleeW()end
function TwitchChampion:SelectedAllows(target,range)
 local selected=SDK.TargetSelector.Selected
 return not valid(selected)or distance(selected,myHero)>range or selected.networkID==target.networkID
end
function TwitchChampion:CastW(target,menu,extra)
 local function allowed()
  return valid(target)and(target.type~=Obj_AI_Hero or self:SelectedAllows(target,950))and target.pos:ToScreen().onScreen and distance(target,myHero)<=950 and self:Ready(_W)and self:Preserve(_W)and(not menu or Core.manaAbove(menu.Mana:Value())and menu.W:Value())and(not extra or extra())
 end
 if not allowed()then return false end
 local prediction=Core:Prediction(self.WSpell);prediction:GetPrediction(target,myHero)
 if not prediction:CanHit(target.type==Obj_AI_Hero and OrbamaPrediction.HITCHANCE_HIGH or OrbamaPrediction.HITCHANCE_NORMAL)then return false end
 return Core:Cast(HK_W,prediction.CastPosition,{intentTarget=target,range=950,prevalidateWorldCast=true,validate=allowed})
end
-- Some enemy champion is inside the current attack reach (an unreadable roster counts as yes).
function TwitchChampion:InReachOfAny()
 local list=self:Objects(true);if not list then return true end
 for _,u in ipairs(list)do if SDK.Data:IsInAutoAttackRange(myHero,u)then return true end end
 return false
end
-- Combat Q is an engage (Twitch-3): only while no enemy champion is inside attack reach, so the next attack does
-- not end the fade before camouflage. Whether Ambush attack speed is still granted when an attack breaks the fade
-- is recorded by the twitch_q_break dev trace; in-range Q stays out until that is known.
function TwitchChampion:QAllowed(menu,target)
 return menu.Q:Value()and Core.manaAbove(menu.Mana:Value())and self:Ready(_Q)and not self:Stealth()and not self.qRecall and valid(target)and target.type==Obj_AI_Hero and distance(target,myHero)<=950 and self:SelectedAllows(target,950)
  and not self:InReachOfAny()
end
-- Q answers a dash onto Twitch first (DefensiveQ); W is the answer only when that Q is not available.
function TwitchChampion:QAnswersDash()
 return Menu.Misc.QGapclose:Value()and self:Ready(_Q)and not self:Stealth()and not self.qRecall and finite(myHero.maxMana)and myHero.maxMana>0 and myHero.mana*100/myHero.maxMana>=20
end
-- Twitch-2: W at the end of an enemy dash onto Twitch when the cask lands no later than dashLate after the dash
-- ends. No mode key; stealth and R rules from Preserve; the dash is re-read at dispatch.
function TwitchChampion:DashW()
 if not Menu.Misc.WGapclose:Value()or not self:Ready(_W)or self.qRecall or self:QAnswersDash()or not self:Preserve(_W)then return false end
 local list=self:Objects(true);if not list then return false end
 for _,enemy in ipairs(list)do
  local dash=Core:ApproachingDash(enemy,myHero.pos,450)
  if dash and distance(dash.to,myHero)<=950 and .25+distance(dash.to,myHero)/self.profile.wSpeed<=dash.duration+self.data.dashLate then
   local id,handle=enemy.networkID,enemy.handle;local aim=Vector(dash.to.x,dash.to.y or 0,dash.to.z)
   local function allowed()
    if not Menu.Misc.WGapclose:Value()or not self:Ready(_W)or not self:Preserve(_W)or self:QAnswersDash()or not valid(enemy)or enemy.networkID~=id or enemy.handle~=handle or distance(aim,myHero)>950 then return false end
    local now=Core:ApproachingDash(enemy,myHero.pos,450)
    if now then return distance(now.to,aim)<=50 end
    return not(enemy.pathing and enemy.pathing.isDashing)and distance(enemy,aim)<=self.profile.wRadius*.5
   end
   if Core:Cast(HK_W,aim,{owner='dash-w',context={priority='interactive'},intentTarget=enemy,range=950,prevalidateWorldCast=true,
    resolve=function()return allowed()and{position=aim}or nil end,validate=function()return allowed()end})then return true end
  end
 end
 return false
end
function TwitchChampion:RLine(target,active)
 if not valid(target)or not still(target)then return end
 local range=myHero.range+(active and 0 or 300)
 if distance(target,myHero)>range+(myHero.boundingRadius or 0)+(target.boundingRadius or 0)then return end
 local list=self:Objects();if not list then return end
 local dx,dz=target.pos.x-myHero.pos.x,target.pos.z-myHero.pos.z;local length=math.sqrt(dx*dx+dz*dz);if length<1 then return end
 dx,dz=dx/length,dz/length
 local reach=range+math.max(250,range*.3);local hits={}
 for _,u in ipairs(list)do
  local x,z=u.pos.x-myHero.pos.x,u.pos.z-myHero.pos.z;local along=x*dx+z*dz;local across=math.abs(x*dz-z*dx)
  -- Refuse ambiguous moving interceptors instead of assigning full damage past them.
  -- Twitch-9: the slower asset bolt speed until the twitch_r_bolt trace settles wiki 5000 vs asset 4000.
  local time=.25+math.max(0,along)/self.data.rMarginSpeed
  local margin=not still(u)and math.max(0,u.ms or 0)*time or 0
  if along>0 and along<=reach and across<=60+(u.boundingRadius or 0)+margin then
   if not still(u)then return end
   hits[#hits+1]={target=u,along=along,seconds=time}
  end
 end
 table.sort(hits,function(a,b)return a.along<b.along end)
 local wall,_,count=OrbamaPrediction:GetCollision(myHero.pos,myHero.pos+Vector(dx*reach,0,dz*reach),self.data.rMarginSpeed,.25,60,{OrbamaPrediction.COLLISION_YASUOWALL},target.networkID)
 if wall~=false or count~=0 then return end
 local heroes,value=0,0;local bonus=active and 0 or self.data.rBonusAD[myHero:GetSpellData(_R).level]or 0
 for i,hit in ipairs(hits)do
  hit.scale=math.max(self.profile.floor,self.profile.id=='classic'and(1-self.profile.falloff)^(i-1)or 1-self.profile.falloff*(i-1))
  hit.damage=SDK.Damage:CalculateDamage(myHero,hit.target,SDK.DAMAGE_TYPE_PHYSICAL,(myHero.totalDamage+bonus)*hit.scale)
  if hit.target.type==Obj_AI_Hero then heroes=heroes+1;value=value+math.min(hit.target.health,hit.damage)end
 end
 return {target=target,hits=hits,heroes=heroes,estimatedDamage=value,at=Game.Timer(),range=reach}
end
function TwitchChampion:AttackReach(u)return(myHero.range or 0)+(myHero.boundingRadius or 0)+(u.boundingRadius or 0)end
-- No other enemy champion within the R count range.
function TwitchChampion:RAlone(target)
 local list=self:Objects(true);if not list then return false end
 for _,u in ipairs(list)do if u.networkID~=target.networkID and distance(u,myHero)<=Menu.Combo.Rrange:Value()then return false end end
 return true
end
-- Twitch-1 (b): R lets Twitch attack a target just outside base reach (R bonus range). Lethal when the attacks the
-- observed attack timer fits into min(R duration, rWindow) kill at the last landing (health window, cannot-die
-- states and own Exhaust through Core:Lethal). Returns lethal, attacks, last landing.
function TwitchChampion:RReachKills(target,d)
 local attack=SDK.Attack;if type(attack)~='table'or type(attack.GetWindup)~='function'or type(attack.GetAnimation)~='function'then return false end
 local windup,animation,readyIn=attack:GetWindup(),attack:GetAnimation(),Core:AttackReadyIn()
 if not finite(windup)or windup<0 or not finite(animation)or animation<=0 or not finite(readyIn)then return false end
 local bonus=self.data.rBonusAD[myHero:GetSpellData(_R).level];if not bonus then return false end
 local window=math.min(self.data.rDuration,self.data.rWindow);local flight=d/self.data.rMarginSpeed;local n,landing=0,nil
 for k=1,12 do local t=readyIn+(k-1)*animation+windup+flight;if t>window then break end;n,landing=k,t end
 if n==0 then return false end
 local hit=SDK.Damage:CalculateDamage(myHero,target,SDK.DAMAGE_TYPE_PHYSICAL,(myHero.totalDamage or 0)+bonus)
 if not finite(hit)or hit<=0 then return false end
 return(Core:Lethal(target,landing,n*hit,{kind='physical',attack=true}))==true,n,landing
end
-- Twitch-1: single-target R. 'duel': a consented champion within R reach with no other enemy champion around;
-- 'reach': a kill just outside base attack reach.
function TwitchChampion:RSingle(target)
 if target.type~=Obj_AI_Hero then return false end
 local d=distance(target,myHero);local reach=self:AttackReach(target)
 if d>reach+self.data.rBonusRange then return false end
 if Menu.Combo.R1v1:Value()and self.duel:Allowed(target)and self:RAlone(target)then return 'duel'end
 if Menu.Combo.RReach:Value()and d>reach and self:RReachKills(target,d)then return 'reach'end
 return false
end
function TwitchChampion:RAllowed(target)
 if not Menu.Combo.R:Value()or not self:Ready(_R)or not Core.manaAbove(Menu.Combo.Mana:Value())or self:RActive()or self.qRecall then return false end
 if not valid(target)then return false end
 local selected=SDK.TargetSelector.Selected;if valid(selected)and distance(selected,myHero)<=1100 and selected.networkID~=target.networkID then return false end
 self.rReason=self:RSingle(target);if self.rReason then return true end
 if distance(target,myHero)>Menu.Combo.Rrange:Value()then return false end
 self.rPreview=nil
 if Menu.Combo.RLine:Value()then
  local line=self:RLine(target,false);if not line then return false end
  self.rPreview=line;return line.heroes>=Menu.Combo.Renemies:Value()
 end
 local list=self:Objects(true);if not list then return false end;local count=0
 for _,u in ipairs(list)do if u.type==Obj_AI_Hero and distance(u,myHero)<=Menu.Combo.Rrange:Value()then count=count+1 end end
 return count>=Menu.Combo.Renemies:Value()
end
function TwitchChampion:Combat(menu)
 if not Core.manaAbove(menu.Mana:Value())or self.qRecall then return end
  if menu.E:Value()then if self:CastE(function()return menu.E:Value()and self:CombatE(menu,false)end)then return end end
 local target=self:Target(1100);if not target then return end
 if menu==Menu.Combo and self:RAllowed(target)then
  local reason=self.rReason
  if Core:Cast(HK_R,nil,{intentTarget=target,validate=function()return self:RAllowed(target)end})then
   -- A reach-kill R is logged with its estimate so a wasted R can be told apart afterwards.
   if reason=='reach'and Core.logger then local _,n,landing=self:RReachKills(target,distance(target,myHero))
    Core:Trace('twitch_r_reach',{target=target.networkID,distance=distance(target,myHero),health=target.health,attacks=n,landing=landing})
   end
   return
  end
 end
 if self:QAllowed(menu,target)then if Core:Cast(HK_Q,nil,{intentTarget=target,validate=function()return self:QAllowed(menu,target)end})then return end end
 self:CastW(target,menu)
end
function TwitchChampion:Combo()self:Combat(Menu.Combo)end
function TwitchChampion:Harass()self:Combat(Menu.Harass)end
function TwitchChampion:FarmHarass()
 if SDK.Orbwalker.Modes[SDK.ORBWALKER_MODE_LANECLEAR]and Menu.Harass.SpellHarass:Value()and not IsUnderTurret(myHero)then self:Harass()end
end
function TwitchChampion:EKS()
  return self:CastE(function()return self:CombatE(nil,true)end,'EKS',nil,nil,true)
end
-- Epic monsters by name (CombatProfiles/world.lua P.category); the Baron spawn prop is not one.
function TwitchChampion:Epic(u)
 local n=type(u.charName)=='string'and u.charName:lower()or ''
 if n:find('baronspawn',1,true)or n:find('_prop',1,true)then return false end
 return(n:find('baron',1,true)or n:find('dragon',1,true)or n:find('herald',1,true)or n:find('atakhan',1,true))~=nil
end
-- Twitch-8: E secures Baron, Dragon or Herald when it kills at impact by the monster health forecast (attacks in
-- flight included). Independent of mode keys and of the spell-farm toggle; a kill also leaves stealth.
function TwitchChampion:StealE()
 if not Menu.Misc.ESteal:Value()or not self:Ready(_E)or not self:Preserve(_E,true)then return false end
 for _,u in ipairs(Core:Rows('jungle',self.ESpell.Radius))do
  if self:Epic(u)and self:Poison(u)then
   local id,handle=u.networkID,u.handle
   local function kills()
    if not Menu.Misc.ESteal:Value()or not valid(u)or u.networkID~=id or u.handle~=handle then return false end
    local row=self:EResult(u);if not row or not finite(row.damage)or row.damage<=0 then return false end
    return(Core:Lethal(u,row.impact,row.damage))==true
   end
   if kills()and self:CastE(kills,'ESteal',{priority='interactive'},nil,true)then return true end
  end
 end
 return false
end
function TwitchChampion:RecallValid(state)
 return self.qRecall==state and Menu.Misc.qrecall:Value()and Core:ContinuationState(state.request,state.expires)~=nil and distance(state.origin,myHero)<=35 and(not myHero.pathing or not myHero.pathing.endPos or distance(state.path,myHero.pathing.endPos)<=10)
end
function TwitchChampion:QRecall()
 if not Menu.Misc.qrecall:Value()then self.qRecall=nil;return end
 if Recalling(myHero)then self.qRecall=nil;return end
 local state=self.qRecall
 if state then
  if not self:RecallValid(state)then self.qRecall=nil;return end
  state.observed=Core:ContinuationState(state.request,state.expires)=='observed'
  if state.recallRequest then
   if Core:ContinuationState(state.recallRequest,state.expires)==nil then self.qRecall=nil end
   return
  end
  if state.observed and self:Stealth()then
   local ok=Core:Cast(HK_RECALL or string.byte('B'),nil,{owner='recall',independent=false,validate=function()return self:RecallValid(state)and self:Stealth()~=nil end,observe=function()return Recalling(myHero)end})
   if ok then state.recallRequest=Core.lastIntent end
  end
  return
 end
 if not self:Ready(_Q)or self:Stealth()then return end
 local ok=Core:Cast(HK_Q,nil,{independent=false,validate=function()return Menu.Misc.qrecall:Value()and self:Ready(_Q)and not self:Stealth()end})
 if ok then
   state={request=Core.lastIntent,expires=Game.Timer()+4,observed=false,origin=Vector(myHero.pos.x,myHero.pos.y,myHero.pos.z),path=Vector((myHero.pathing and myHero.pathing.endPos)or myHero.pos)};self.qRecall=state
 end
end
function TwitchChampion:Farm(mode)
 local menu=Menu.Clear[mode];local code=mode=='JungleClear'and SDK.ORBWALKER_MODE_JUNGLECLEAR or mode=='LastHit'and SDK.ORBWALKER_MODE_LASTHIT or SDK.ORBWALKER_MODE_LANECLEAR
 local function permission()return Menu.Clear.SpellFarm:Value()and SDK.Orbwalker.Modes[code]and Core.manaAbove(menu.Mana:Value())and not self.qRecall end
 if not permission()then return end
  local jungle=mode=='JungleClear';local last=mode=='LastHit'
 local function victim(u)return u.type==Obj_AI_Minion and(u.team==300)==jungle and valid(u)end
 local function evaluateE()
  if not permission()or not menu.E:Value()then return false end
  local current=self:Objects();if not current then return false end;local count=0
  for _,u in ipairs(current)do
   local result=self:EResult(u)
   if result and u.type==Obj_AI_Minion then
    if not victim(u)then if last then return false end
    else
      local hp=SDK.HealthPrediction:GetPrediction(u,result.impact)
     if finite(hp)and hp>0 then
      -- A monster E kills is taken at any stack count (nothing is gained by waiting, a steal is lost).
      if jungle then if result.stacks>=4 or result.lethal then count=count+1 end
      else
       local lethal=result.useful>hp+math.max(0,u.hpRegen or 0)*result.impact
       if last then
        if not lethal or SDK.Attack:IsActive()then return false end
        if self:AttackRescues(u)then return false end
       end
       if lethal then count=count+1 end
      end
     elseif last then return false end
    end
   end
  end
  return count>=menu.Count:Value()
 end
  if self:CastE(evaluateE)then return end
  if last or not menu.W:Value()or not self:Ready(_W)then return end
  local list=self:Objects();if not list then return end
 local best,bestCount=nil,0
 for i=1,math.min(#list,12)do local u=list[i];if victim(u)and still(u)and distance(u,myHero)<=950 then local count=0
  for _,v in ipairs(list)do if victim(v)and still(v)and distance(v,u)<=self.profile.wRadius then count=count+1 end end
  if count>bestCount then best,bestCount=u,count end
 end end
 if best and bestCount>=menu.Count:Value()then
  self:CastW(best,menu,function()if not permission()then return false end;local current=self:Objects();if not current then return false end;local count=0
   for _,u in ipairs(current)do if victim(u)and still(u)and distance(u,best)<=self.profile.wRadius then count=count+1 end end
   return still(best)and count>=menu.Count:Value()
  end)
 end
end
function TwitchChampion:LaneClear()self:Farm('LaneClear')end
function TwitchChampion:JungleClear()self:Farm('JungleClear')end
function TwitchChampion:LastHit()self:Farm('LastHit')end
function TwitchChampion:OnTick()
 if myHero.dead then self.qRecall=nil;self.rPreview=nil end
 self:TrackPoison();self.duel:Maintain();if Core.logger then self:TraceEvidence()end
 if self.ePreviewFallback and Menu.Draw.EDamage:Value()and(not self.nextEPreview or self.nextEPreview<=Game.Timer())then self:PrepareEPreview()end
 if ShouldWait()then return end
 self:QRecall();if IsCasting()or self.qRecall then return end
  if self:UrgentE()then return end
  if self:EKS()or self:StealE()or self:DefensiveQ(false)or self:DashW()then return end;local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then
  if SDK.Orbwalker.Modes[SDK.ORBWALKER_MODE_LANECLEAR]then self:FarmHarass();self:LaneClear()end
  if SDK.Orbwalker.Modes[SDK.ORBWALKER_MODE_JUNGLECLEAR]then self:JungleClear()end
  elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
-- Twitch-5: E rows for at most five champions (useful damage after shields, lethal). Draw only reads them.
function TwitchChampion:PrepareEPreview()
 local rows={};local now=Game.Timer()
 if self:Ready(_E)then local list=self:Objects(true)
  for _,u in ipairs(list or {})do if #rows>=5 then break end
   local r=self:EResult(u);if r and finite(r.useful)and r.useful>0 then rows[#rows+1]={unit=u,handle=u.handle,useful=r.useful,lethal=r.lethal==true}end
  end
 end
 self.ePreview={expires=now+1,rows=rows};self.nextEPreview=now+.1
end
-- Development evidence (Twitch-3/12, Twitch-9): own buffs after an attack breaks Q during the fade, and the time
-- from an R attack's windup end to the target's health drop.
function TwitchChampion:OnPostAttack()
 if not Core.logger then return end
 local now=Game.Timer()
 if now-(Core.observedSpells[_Q]or -math.huge)<=self.profile.fade then self.qBreak={at=now}end
 if self:RActive()then local handle=myHero.attackData and myHero.attackData.target
  local t=handle and Game.GetObjectByHandle and Game.GetObjectByHandle(handle)
  if valid(t)and finite(t.health)then self.rBolt={unit=t,handle=t.handle,health=t.health,start=now,distance=distance(t,myHero)}end
 end
end
function TwitchChampion:TraceEvidence()
 local now=Game.Timer();local q=self.qBreak
 if q and now>=q.at+.3 then self.qBreak=nil;local names={}
  local count=myHero.buffCount
  if finite(count)and count>=0 and count<=128 then for i=0,count do local b=myHero:GetBuff(i)
   if b and type(b.name)=='string'and b.name:lower():find('twitch',1,true)and(not finite(b.count)or b.count>0)then names[#names+1]=b.name end
  end end
  Core:Trace('twitch_q_break',{profile=self.profile.id,buffs=table.concat(names,',')})
 end
 local r=self.rBolt
 if r then local u=r.unit
  if not valid(u)or u.handle~=r.handle or now-r.start>1 then self.rBolt=nil
  elseif finite(u.health)and u.health<r.health then self.rBolt=nil
   Core:Trace('twitch_r_bolt',{profile=self.profile.id,distance=r.distance,delay=now-r.start})
  end
 end
end
function TwitchChampion:Draw()
 if myHero.dead then return end
 local preview=self.ePreview
 -- 'E kills' only (the health bars show E's damage); kept for a second while E is ready.
 if Menu.Draw.EDamage:Value()and preview and preview.expires>=Game.Timer()and IsReady(_E)then
  for _,row in ipairs(preview.rows)do local u=row.unit
   if row.lethal and u and u.handle==row.handle and u.visible~=false and not u.dead and u.pos2D then Draw.Text('E kills',18,u.pos2D.x-25,u.pos2D.y-60,Draw.Color(255,255,70,70))end
  end
 end
 -- No stealth timer text (the game shows it); the reveal range while stealthed. A prepared sample is kept for
 -- a second so a late preparation never blinks the circles; the stealth's own expiry still ends them.
 if Menu.Draw.qtimer and Menu.Draw.qtimer:Value()then
   local buff,expires
   if self.preparedStealth then
    local row=self.stealthPreview;if not row or Core.adapter:Now()-row.at>1000 then return end
    buff=row.present;expires=row.expires
   elseif self.stealthPreparationStatus=='unsupported'then buff,expires=self:Stealth()
   else return end
   -- Enemy champions inside the inner circle reveal Twitch; inside the outer one they get the warning.
   if buff and expires and expires>Game.Timer()then
    Draw.Circle(myHero.pos,self.profile.detect,1,Draw.Color(200,255,0,0),true);Draw.Circle(myHero.pos,self.profile.warn,1,Draw.Color(200,188,77,26),true)
   end
 end
end
function TwitchChampion:RegisterGuide(guide,settings)
 local nodes={q={node=Menu.Combo.Q,label='Combo Q'},w={node=Menu.Combo.W,label='Combo W'},e={node=Menu.Combo.E,label='Combo E'},stacks={node=Menu.Combo.Estacks,label='E stack threshold'},r={node=Menu.Combo.R,label='Combo R'},recall={node=Menu.Misc.qrecall,label='Recall in stealth'},preserve={node=Menu.Misc.stopq,label='Never break stealth with W'},farm={node=Menu.Clear.SpellFarm,label='Use abilities to farm'}}
  nodes.urgent={node=Menu.Misc.UrgentE,label='E when low and being attacked'}
  nodes.flee={node=Menu.Misc.QFlee,label='Q when fleeing'}
  nodes.gapclose={node=Menu.Misc.QGapclose,label='Q when an enemy dashes onto you'}
  nodes.dashw={node=Menu.Misc.WGapclose,label='Slow an enemy that dashes onto you'}
  nodes.steal={node=Menu.Misc.ESteal,label='Secure Baron, Dragon or Herald with E'}
  nodes.reach={node=Menu.Combo.RReach,label='R to reach a kill'}
  nodes.duel={node=Menu.Combo.R1v1,label='One-on-one R'}
  nodes.harass={node=Menu.Harass.SpellHarass,label='Harass while lane clearing'}
  nodes.epreview={node=Menu.Draw.EDamage,label='E damage and kills'}
  local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
 return guide:Register('champion',{'Twitch: combat','Twitch: poison and stealth','Twitch: farming'},function(page)
  if page==1 then return {title=self.profile.id=='classic'and 'Classic Twitch'or 'Twitch',cards={{'COMBAT','Hold '..settings.bind(SDK,SDK.ORBWALKER_MODE_COMBO)..' for [[q]], [[w]], [[e]] and [[r]]. Release the actual triggering mode to cancel waiting input.'},{'E','[[stacks]] counts currently owned poison within caster-centered E range. E fires early before poison expires or the target escapes. A predicted poison tick is never a confirmed hit.'},{'R','R counts nearby enemy champions.'},{'ONE TARGET','[[reach]] casts R when the target stands just outside attack range and the attacks that fit into the next three seconds kill it. [[duel]] casts R on a chosen champion when no other enemy champion is near. Q is used only to engage, while no enemy champion is inside attack range.'},{'HARASS','[[harass]] also harasses champions while lane clearing, never under an enemy turret. [[epreview]] shows E damage over enemies and marks the ones E kills.'}}}end
   if page==2 then return {title='Poison and stealth',cards={{'POISON','Stacks, owner and expiry are read from the poison itself. If the stack number is unreadable, the number of poison refreshes seen on that enemy is used instead. Unknown or foreign poison cannot authorize E. E is a self cast; cursor location does not define its victims.'},{'RECALL','Hold [[recall]] to request Q, then wait for Q and a live stealth buff before recall. Releasing the key or losing the request continuation cancels future steps.'},{'DEFENSE','[[urgent]] requires low own HP, a current enemy attack windup and useful owned poison. [[flee]] keeps the actual Flee bind; with Q on cooldown and no stealth, W slows the nearest pursuer. [[gapclose]] requires a native approaching dash. Q starts preparation and does not promise immediate stealth. With Q unavailable, [[dashw]] drops W where the dash ends. [[steal]] takes an epic monster E kills, in any mode.'},{'PRESERVATION','[[preserve]] blocks W during stealth. E has its own stealth switch; an E that kills is used anyway. Q send alone is not stealth; R send alone is not an active R buff.'}}}end
  return {title='Farming',cards={{'MODES','Enable [[farm]] and the desired lane, jungle or Last Hit switches. Each mode keeps its own held bind and mana policy.'},{'E','Lane E compares impact-time HP. Last Hit refuses nonlethal marked-minion collateral and a lethal attack that can arrive in time. Jungle E uses a stack threshold, or fires at once when it kills the monster.'},{'POISON','A projected poison tick is not a confirmed kill. E rescue uses current owned stacks and the expected health when E lands.'}}}
 end,cfg,links,activate)
end
function TwitchChampion:ClearContext(jungle,condition)
 local code=jungle and SDK.ORBWALKER_MODE_JUNGLECLEAR or SDK.ORBWALKER_MODE_LANECLEAR
 local context=Core:ModeContext('LaneClear',function()return SDK.Orbwalker.Modes[code]and condition()end)
 context.modes={code}
 return context
end
Core:RegisterPolicy({damageTypes={E='mixed'},methods={
 Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 FarmHarass=function(self)return self:ClearContext(false,function()return Menu.Harass.SpellHarass:Value()and not IsUnderTurret(myHero)end)end,
 LaneClear=function(self)return self:ClearContext(false,function()return Menu.Clear.SpellFarm:Value()end)end,
 JungleClear=function(self)return self:ClearContext(true,function()return Menu.Clear.SpellFarm:Value()end)end,
  LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end,QRecall=function()return Core:HeldContext(function()return Menu.Misc.qrecall:Value()end)end,
 EKS=function()return {priority='interactive'}end},exceptions={non_interrupting_summoner=true},channel=function()return not Core:SelfChanneling()end})
TwitchChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Twitch"]="Twitch"}
local normalSupported={["Twitch"]=true}

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
