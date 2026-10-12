return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Annie"]=function()return _G.OrbamaFamily:Require("c3ca1bf3efce31e82a70fe8bc11482f6f60862fe54ce63cf3ff8bf33bf582921")()end
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
if champion=="Annie" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Annie',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent implementation; installed profile evidence: annie-provenance.json.
local profiles=ChampionProfiles('Annie')
local finite,id,point,own=Core.finite,Core.id,Core.point,Core.mine
local function cleanup(self,reason)
 if self.flashCombo then self.flashCombo:Cancel(reason or 'controller_closed')end
 if self.petOrder then Core.adapter:Cancel(self.petOrder,reason or 'controller_closed')end
 if self.prime and self.prime.action then Core.adapter:Cancel(self.prime.action,reason or 'controller_closed')end
 if self.summon and self.summon.action then Core.adapter:Cancel(self.summon.action,reason or 'controller_closed')end
 self.followUp=nil;self.flashTarget=nil;self.igniteFollow=nil;self.petETrace=nil;self.pet=nil;self.summon=nil;self.preview=nil;self.petOrder=nil;self.petAutomatic=nil;self.prime=nil
end
local AnnieChampion=class("AnnieChampion")
function AnnieChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.sdk=_G.SDK;self.hero=myHero;self:LoadMenu();self.ePriorities={};self:RefreshEPriorities()
 self.WSpell={Type=OrbamaPrediction.SPELLTYPE_CONE,Delay=.25,Radius=210,Range=600,Speed=math.huge,Collision=false}
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=.25,Radius=250,Range=600,Speed=math.huge,Collision=false}
 self.PreviewSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=.25,Radius=250,Range=1200,Speed=math.huge,Collision=false}
 -- Flash, then R through the shared follow-up service (Core:FlashFollow); Q and W follow the observed R.
 self.flashCombo=Core:FlashFollow('AnnieFlash')
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 -- Health-bar damage and the kill mark (shared display): ready Q, W and R wherever the enemy stands.
 Core:RegisterComboDamage(function(u)return self:Burst(u,nil,true),true end)
 Core:RegisterCleanup('Annie',function(reason)cleanup(self,reason)end)
 local ok,why=Core:RegisterPreparation('Annie.preview',{intervalMs=120,maxDelayMs=350,units=2,maxUnits=2},
  function()self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.prepared=ok;self.previewFallback=not ok and why=='unsupported'
 -- Only a profile with a real absorb amount offers E to the defensive consumer; it judges the danger, so
 -- neither the health limit nor the mana limit of the automatic shield applies to it.
 local p=self.profile
 if p.eShield and Core.RegisterShield then
  self.shieldOffered,self.shieldReason,self.shieldDefense=Core:RegisterShield({name='AnnieE',slot=_E,key=HK_E,profile=p.id,spell=p.e,source=p.shieldSource,
   duration=p.eShieldDuration,delay=p.eDelay,kind='object',target=function()return myHero end,ready=function()return not self.prime end,
   amount=function()local base=p.eShield[myHero:GetSpellData(_E).level];return base and finite(myHero.ap)and base+p.eShieldAP*math.max(0,myHero.ap)or 0 end})
 end
end
function AnnieChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Annie'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R (Tibbers)',value=true})
 Menu.Combo:MenuElement({id='Count',name='Enemies R must hit with the stun ready',value=2,min=1,max=5,step=1})
 Menu.Combo:MenuElement({id='StunR',name='Save the stun for R while R is ready',value=false})
 Menu.Harass:MenuElement({id='Preserve',name='Keep a ready stun instead of poking with it',value=false})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  for _,slot in ipairs({'Q','W'})do Menu.Clear[mode]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=25,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions W must hit',value=3,min=1,max=10,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q when an attack cannot last hit',value=true})
 Menu.LastHit:MenuElement({id='W',name='Use W when Q is down and two minions would be lost',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=15,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R (Tibbers) at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='FlashAssist',name='Flash, then R the selected target',key=string.byte('U')})
 Menu.Misc:MenuElement({id='Pet',name='Send Tibbers to the cursor',key=string.byte('N')})
 Menu.Misc:MenuElement({id='Flash',name='Allow the Flash-R bind to use Flash',value=false})
 Menu.Misc:MenuElement({id='EngageHP',name='Never Flash in below health %',value=30,min=1,max=100,step=5,menu=false})
 Menu.Misc:MenuElement({id='Enemies',name='Never Flash into more enemies than',value=2,min=1,max=5,step=1,menu=false})
 Menu.Misc:MenuElement({id='StunAssist',name='Selected-target R only with the stun ready',value=false})
 Menu.Misc:MenuElement({id='AutoPet',name='Tibbers follows the Combo target',value=true})
 Menu.Misc:MenuElement({id='EHP',name='E on champions about to be hit below health %',value=80,min=1,max=100,step=5,menu=false})
 Menu.Misc:MenuElement({id='EMana',name='E only above mana %',value=15,min=0,max=100,step=5,menu=false})
 if self.profile.allyE then
  Menu.Misc:MenuElement({type=MENU,id='EPriorities',name='E shield priority per champion (0 = never)'})
 end
 Menu.Misc:MenuElement({id='Interrupt',name='Stun enemy channels with Q',value=true})
 Menu.Misc:MenuElement({id='GapStun',name='Stun enemies that dash onto me with Q',value=true})
 Menu.Misc:MenuElement({id='SaveFarmStun',name='Keep a ready stun while farming near enemies',value=true,menu=false})
 Menu.Misc:MenuElement({id='AutoStunW',name='Stun with W without holding a mode key',value=true})
 Menu.Misc:MenuElement({id='AutoStunR',name='Stun with R without holding a mode key',value=true})
 Menu.Misc:MenuElement({id='AutoStunCount',name='Enemy champions those stuns must hit',value=3,min=2,max=5,step=1})
 Menu.Misc:MenuElement({id='AutoStunMana',name='Those stuns only above mana %',value=40,min=0,max=100,step=5,menu=false})
 Menu.Misc:MenuElement({id='BuildStun',name='Build the stun while no enemy is near',value=true})
 Menu.Misc:MenuElement({id='FleeE',name='Flee: use E',value=true})
 Menu.Misc:MenuElement({id='FleeStun',name='Flee: stun a chaser with Q',value=true})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Q range while Q is ready',value=false})
 Menu.Draw:MenuElement({id='Preview',name='R landing spot, hit count and Tibbers aura',value=true})
end
-- Classic E shields only Annie, so only the ally-shield profile has a priority list.
function AnnieChampion:RefreshEPriorities()
 if not self.profile.allyE then self.nextPriorities=math.huge;return end
 for i=1,math.min(Game.HeroCount(),16)do local u=Game.Hero(i);local identity=id(u)
  if u and u.team==myHero.team and identity and type(u.charName)=='string'and not self.ePriorities[identity]then
   local key=StableUnitMenuKey(self,'P',u);Menu.Misc.EPriorities:MenuElement({id=key,name=u.charName,value=3,min=0,max=5,step=1})
   self.ePriorities[identity]=Menu.Misc.EPriorities[key]
  end
 end;self.nextPriorities=Game.Timer()+1
end
function AnnieChampion:EPriority(u)
 if not self.profile.allyE then return u==myHero and 3 or 0 end
 local node=self.ePriorities[id(u)];return node and node:Value()or 0
end
function AnnieChampion:Reach(u,range)return IsValid(u)and point(u.pos)and GetDistance(u.pos,myHero.pos)<=range end
function AnnieChampion:Current(u,ally)
 if not u or not id(u)or not u.handle or not IsValid(u)then return false end
 if u==myHero then return ally==true end
 if u.type==Obj_AI_Hero then
  for i=1,math.min(Game.HeroCount(),16)do local v=Game.Hero(i)
   if v and id(v)==id(u)and v.handle==u.handle and IsValid(v)and(v.team==myHero.team)==(ally==true)then return true end
  end
 else
  for i=1,math.min(Game.MinionCount(),512)do local v=Game.Minion(i)
   if v and id(v)==id(u)and v.handle==u.handle and IsValid(v)and v.team~=myHero.team then return true end
  end
 end;return false
end
function AnnieChampion:Ready(slot,guide)
 local d=myHero:GetSpellData(slot);local name=slot==_Q and self.profile.q or slot==_W and self.profile.w or slot==_E and self.profile.e or self.profile.r
 if not d or(not guide and d.name~=name or guide and not self.profile.guides[d.name])then return false end
 return finite(d.level)and d.level>=1 and finite(d.currentCd)and d.currentCd==0 and Game.CanUseSpell(slot)==0
  and finite(d.mana)and d.mana>=0 and d.mana<=myHero.mana
end
function AnnieChampion:Buff(u,name)
 if not u or not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 or u.buffCount%1~=0 then return nil end
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==name:lower()and finite(b.count)and b.count>0 then
   local expiry=Core.buffExpiry(b)
   local known=b.source~=nil and b.source~=0 or b.sourcenID~=nil and b.sourcenID~=0
   if finite(expiry)and expiry>Game.Timer()and known
    and(b.source==nil or b.source==0 or own(b.source))and(b.sourcenID==nil or b.sourcenID==0 or own(b.sourcenID))then return b end
  end
 end
end
function AnnieChampion:Stun()
 if self:Buff(myHero,self.profile.primed)then return true,4 end
 local b=self:Buff(myHero,self.profile.stack);local n=b and b.count
 if finite(n)and n%1==0 and n>=1 and n<=3 then return false,n end
 return false,0
end
-- A primed stun is kept while farming near an enemy champion. Under an allied turret the turret answers a dive,
-- so the stun is only kept for an enemy already inside Q range there.
function AnnieChampion:FarmStunAllowed()
 local primed=self:Stun();if not primed or not Menu.Misc.SaveFarmStun:Value()or GetEnemyCount(1000,myHero.pos)==0 then return true end
 return GetEnemyCount(625,myHero.pos)==0 and self:UnderAllyTurret()
end
function AnnieChampion:UnderAllyTurret()
 local objects=_G.SDK.ObjectManager;if not objects or type(objects.GetAllyTurrets)~='function'then return false end
 local turrets=objects:GetAllyTurrets()
 for i=1,math.min(#turrets,32)do local t=turrets[i]
  if t and not t.dead and point(t.pos)and GetDistance(t.pos,myHero.pos)<(finite(t.boundingRadius)and t.boundingRadius or 0)+750 then return true end
 end;return false
end
-- The SDK's own undying and revive reading (Tryndamere R, Kindred R, Zilean R, Kayle R, ...): no burst is spent on a
-- champion that cannot die. Shared service S2 moves this reading inside Core:Lethal.
function AnnieChampion:Immortal(u)
 if not u or u.type~=Obj_AI_Hero then return false end
 local objects=_G.SDK.ObjectManager;if not objects or type(objects.IsHeroImmortal)~='function'then return false end
 local ok,result=pcall(objects.IsHeroImmortal,objects,u,false);return ok and result==true
end
-- Three stacks, E ready and mana for E plus `slot`: the next cast can carry the stun.
function AnnieChampion:Primable(slot)
 local _,stacks=self:Stun();if stacks~=3 or not self:Ready(_E)then return false end
 local e,s=myHero:GetSpellData(_E).mana,slot and myHero:GetSpellData(slot).mana or 0
 return finite(e)and finite(s)and myHero.mana>=e+s
end
-- E is kept for a champion the shared threat reading says is about to be hit.
function AnnieChampion:DefenseWanted()
 for i=1,math.min(Game.HeroCount(),16)do local u=Game.Hero(i)
  if u and u.team==myHero.team and self:EUseful(u)then return true end
 end;return false
end
function AnnieChampion:Damage(u,slot)
 local rank=myHero:GetSpellData(slot).level;local base=slot==_Q and self.profile.qBase[rank]or slot==_W and self.profile.wBase[rank]or self.profile.rBase[rank]
 if not base or not finite(myHero.ap)then return 0 end
 local scale=slot==_Q and self.profile.qAP or slot==_W and self.profile.wAP or self.profile.rAP
 return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+scale*myHero.ap)
end
function AnnieChampion:GetQDmg(u)return self:Damage(u,_Q)end
function AnnieChampion:GetWDmg(u)return self:Damage(u,_W)end
function AnnieChampion:GetRDmg(u)return self:Damage(u,_R)end
function AnnieChampion:CastQ(u,context,permission)
 if not self:Ready(_Q)or not self:Reach(u,625)or not self:Current(u)or(permission and not permission())then return false end
 local identity,handle=id(u),u.handle
 return Core:Cast(HK_Q,u,{intentTarget=u,range=625,context=context,deferAttackWindup=true,
  validate=function()return self:Ready(_Q)and id(u)==identity and u.handle==handle and self:Current(u)and self:Reach(u,625)and(not permission or permission())end})
end
function AnnieChampion:Rows(kind,origin)
 local list=kind=='hero'and _G.SDK.ObjectManager:GetEnemyHeroes(1200)or kind=='jungle'and _G.SDK.ObjectManager:GetMonsters(800)or _G.SDK.ObjectManager:GetEnemyMinions(800)
 local rows,seen={},{};local predictor=Core:Prediction(self.PreviewSpell)
 for i=1,math.min(#list,kind=='hero'and 5 or kind=='jungle'and 12 or 40)do local u=list[i];local identity=id(u)
  if identity and not seen[identity]and IsValid(u)and u.team~=myHero.team and(kind=='hero'or(u.team==300)==(kind=='jungle'))then
   seen[identity]=true;predictor:GetPrediction(u,myHero)
   if predictor:CanHit(2)and point(predictor.UnitPosition)then rows[#rows+1]={unit=u,id=identity,handle=u.handle,position=point(predictor.UnitPosition)}end
  end
 end;return rows
end
function AnnieChampion:ConeHit(pos,aim,origin)
 local dx,dz=aim.x-origin.x,aim.z-origin.z;local length=math.sqrt(dx*dx+dz*dz)
 local ux,uz=pos.x-origin.x,pos.z-origin.z;local distance=math.sqrt(ux*ux+uz*uz)
 -- Native castConeAngle is a half-angle candidate; use the smaller 24.76
 -- rather than the broader script/UI cone to avoid claiming edge hits.
 return length>0 and distance<=600 and(distance==0 or(dx*ux+dz*uz)/(length*distance)>=math.cos(math.rad(24.76)))
end
function AnnieChampion:Solve(slot,u,minimum,kind,origin)
 origin=origin or myHero.pos;local rows=self:Rows(kind or 'hero',origin);local candidates={};local anchor
 for _,row in ipairs(rows)do if row.id==id(u)and row.handle==u.handle then anchor=row end end
 if not anchor then return nil end
 if slot==_W then
  for _,row in ipairs(rows)do candidates[#candidates+1]=row.position end
  for i=1,#rows do for j=i+1,#rows do if #candidates>=15 then break end
   local a,b=rows[i].position-origin,rows[j].position-origin
   if a:Len()>0 and b:Len()>0 then candidates[#candidates+1]=origin+(a:Normalized()+b:Normalized())*300 end
  end end
 else
  for _,row in ipairs(rows)do candidates[#candidates+1]=row.position end
  for i=1,#rows do for j=i+1,#rows do if #candidates>=15 then break end;candidates[#candidates+1]=(rows[i].position+rows[j].position)/2 end end
 end
 local best
 for i=1,math.min(#candidates,15)do local aim=point(candidates[i])
  if slot==_R and GetDistance(aim,origin)>600 then aim=origin:Extended(aim,600)end
  local anchorHit=slot==_W and self:ConeHit(anchor.position,aim,origin)or slot==_R and GetDistance(anchor.position,aim)<=250
  if anchorHit and GetDistance(aim,origin)<=600 then local count=0
   for _,row in ipairs(rows)do if slot==_W and self:ConeHit(row.position,aim,origin)or slot==_R and GetDistance(row.position,aim)<=250 then count=count+1 end end
   if count>=minimum and(not best or count>best.count)then best={position=aim,count=count,rows=rows}end
  end
 end;return best
end
function AnnieChampion:PetSnapshot()
 local seen={};for i=1,math.min(Game.MinionCount(),512)do local u=Game.Minion(i);if u and id(u)then seen[id(u)]=true end end;return seen
end
function AnnieChampion:CastArea(slot,u,context,minimum,permission,kind)
 if not self:Ready(slot)or not self:Current(u)or not self:Reach(u,slot==_R and 850 or 600)or(permission and not permission())then return false end
 local plan=self:Solve(slot,u,minimum,kind);if not plan then return false end
 local identity,handle=id(u),u.handle;local key=slot==_W and HK_W or HK_R
 local summon=slot==_R and {before=self:PetSnapshot(),center=point(plan.position),expires=Game.Timer()+1.5}or nil
 -- Shared legacy object-range checks use the anchor's reachable effect range.
 -- The explicit validator separately requires a legal 600-unit cast center.
 local ok=Core:Cast(key,plan.position,{intentTarget=u,context=context,range=slot==_R and 850 or 600,prevalidateWorldCast=true,deferAttackWindup=true,
  resolve=function()if(permission and not permission())or not self:Current(u)then return nil end
   local fresh=self:Solve(slot,u,minimum,kind);return fresh and {position=fresh.position}end,
  validate=function(_,resolved)local aim=resolved and resolved.position
   if not aim or not self:Ready(slot)or id(u)~=identity or u.handle~=handle or not self:Current(u)or(permission and not permission())then return false end
   local rows=self:Rows(kind or 'hero');local count,anchor=0,false
   for _,row in ipairs(rows)do local hit=slot==_W and self:ConeHit(row.position,aim,myHero.pos)or slot==_R and GetDistance(row.position,aim)<=250
    if hit then count=count+1;if row.id==identity and row.handle==handle then anchor=true end end
   end;return anchor and count>=minimum and GetDistance(aim,myHero.pos)<=600
  end,
  observe=slot==_R and function(q)local a=Core:NativeCast(q,self.profile.r)
   return a and point(a.placementPos or a.endPos)end or nil})
 if ok and summon then
  summon.action=Core.lastIntent.id;self.summon=summon
  Core:AfterCast(HK_R,function(q)if self.summon==summon then
   local native=Core:NativeCast(q,self.profile.r)
   summon.observed=true;summon.started=native and native.startTime or q.observationGameTime;summon.center=point(myHero.activeSpell.placementPos or myHero.activeSpell.endPos)
  end end)
 end;return ok
end
function AnnieChampion:EUseful(u,flee)
 if not self:Current(u,true)or not self:Reach(u,800)or not self:Ready(_E)or not Core.manaAbove(Menu.Misc.EMana:Value())then return false end
 if not self.profile.allyE and u~=myHero then return false end
 if self:EPriority(u)<=0 then return false end
 if flee then return u==myHero and Menu.Misc.FleeE:Value()and GetMode()=='Flee'and GetEnemyCount(800,myHero.pos)>0 end
 -- The shared threat reading: an attack on its way, a targeted cast, a turret shot or a tracked skillshot.
 return u.maxHealth>0 and u.health/u.maxHealth*100<=Menu.Misc.EHP:Value()and Core:AllyThreat(u,.75)~=nil
end
function AnnieChampion:CastE(u,context,flee)
 if not self:EUseful(u,flee)then return false end
 local identity,handle=id(u),u.handle
 return Core:Cast(HK_E,self.profile.allyE and u or nil,{owner='Defense',intentTarget=u,range=self.profile.allyE and 800 or nil,
  context=context,priority='critical',validate=function()return id(u)==identity and u.handle==handle and self:EUseful(u,flee)end})
end
function AnnieChampion:Defend()
 if not self:Ready(_E)or not Core.manaAbove(Menu.Misc.EMana:Value())then return false end
 local best;for i=1,math.min(Game.HeroCount(),16)do local u=Game.Hero(i)
  if self:EUseful(u)and(not best or self:EPriority(u)>self:EPriority(best)
   or self:EPriority(u)==self:EPriority(best)and u.health/u.maxHealth<best.health/best.maxHealth)then best=u end
 end
 return best and self:CastE(best,{priority='critical'})or false
end
function AnnieChampion:Combat(mode)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return false end
 local u=GetTarget(850);if not IsValid(u)then return false end
 local context=Core:ModeContext(mode)
 if mode=='Combo'and self:FollowIgnite()then return true end
 local ok=self:CombatCasts(mode,node,u,context)
 -- The burst kills only with Ignite: once one of its spells is observed, Utils sends Ignite (FollowIgnite).
 if ok and mode=='Combo'and not self.igniteFollow and not self:BurstKills(u,node)and self:BurstKills(u,node,true)then
  self.igniteFollow={unit=u,id=id(u),handle=u.handle,node=node,started=Game.Timer(),expires=Game.Timer()+3}
 end
 return ok
end
function AnnieChampion:CombatCasts(mode,node,u,context)
 if mode=='Combo'then
  -- At three stacks E readies the stun first; the cast that follows waits for the native primed buff (at most 1 s).
  if self.prime then return false end
  if self:ComboPrime(u,node)then return true end
  if node.R:Value()and self:Ready(_R)then
   local count=self:RMinimum(u,node)
   if self:CastArea(_R,u,context,count,function()return node.R:Value()and Core.manaAbove(node.Mana:Value())
    and self:RMinimum(u,node)<=count end)then return true end
  end
 end
 local function permit(slot)
  if not node[slot]:Value()or not Core.manaAbove(node.Mana:Value())then return false end
  local primed=self:Stun()
  return not primed or(mode=='Harass'and not node.Preserve:Value()or mode=='Combo'and(not node.StunR:Value()or not node.R:Value()or not self:Ready(_R)))
 end
 if permit('Q')and self:CastQ(u,context,function()return permit('Q')end)then return true end
 if permit('W')and self:CastArea(_W,u,context,1,function()return permit('W')end)then return true end
 return mode=='Combo'and self:PetShield(context)or false
end
-- Ignite as part of the burst (Annie-14): counted only while Utils may use a ready Ignite on this enemy, and then
-- always sent through C:Ignite (FollowIgnite, FlashFollowUp). Its full 5 s true burn is counted, as the rival does.
function AnnieChampion:IgniteDamage(u)local status=Core:IgniteStatus(u);return status and status.damage or 0 end
-- The remaining ready burst plus Ignite kills while the burst alone does not.
function AnnieChampion:IgniteFinishes(u,node)
 return IsValid(u)and not self:Immortal(u)and self:IgniteDamage(u)>0 and not self:BurstKills(u,node)and self:BurstKills(u,node,true)
end
function AnnieChampion:FollowIgnite()
 local f=self.igniteFollow;if not f then return false end
 local u=f.unit
 if Game.Timer()>f.expires or GetMode()~='Combo'or not self:Current(u)or id(u)~=f.id or u.handle~=f.handle then self.igniteFollow=nil;return false end
 local observed=false
 for _,slot in ipairs({_R,_Q,_W})do local at=Core.observedSpells and Core.observedSpells[slot];if at and at>=f.started then observed=true end end
 if not observed then return false end
 self.igniteFollow=nil
 local node=f.node
 if not self:IgniteFinishes(u,node)then return false end
 return Core:Ignite(u,'AnnieIgnite',function()return GetMode()=='Combo'and self:Current(u)and u.handle==f.handle and self:IgniteFinishes(u,node)end,Core:ModeContext('Combo'))==true
end
-- Ready burst on one champion: R, Q and W when ready, consented (node) and in reach.
function AnnieChampion:Burst(u,node,anywhere)
 local total=0
 for _,row in ipairs({{_R,'R',850},{_Q,'Q',625},{_W,'W',600}})do local slot,key,range=row[1],row[2],row[3]
  if self:Ready(slot)and(not node or node[key]:Value())and(anywhere or self:Reach(u,range))then total=total+self:Damage(u,slot)end
 end;return total
end
function AnnieChampion:BurstKills(u,node,ignite)
 if not IsValid(u)or self:Immortal(u)then return false end
 local damage=self:Burst(u,node)+(ignite and self:IgniteDamage(u)or 0);return damage>0 and Core:Lethal(u,.25,damage,{kind='magical'})==true
end
-- Enemies Combo R must hit: one when the burst kills the target; two when R alone kills another enemy inside the
-- same circle; the configured count with the stun ready or primable; two more without it (at most five).
function AnnieChampion:RMinimum(u,node)
 if self:BurstKills(u,node)or self:BurstKills(u,node,true)then return 1 end
 local count=node.Count:Value()
 if not(self:Stun()or self:Primable(_R))then count=math.min(5,count+2)end
 if count>2 then local plan=self:Solve(_R,u,2)
  if plan then for _,row in ipairs(plan.rows)do local v=row.unit
   if GetDistance(row.position,plan.position)<=250 and IsValid(v)and not self:Immortal(v)
    and Core:Lethal(v,.25,function()return self:GetRDmg(v)end,{kind='magical'})==true then return 2 end
  end end
 end;return count
end
-- One E per plan at three stacks when the next stun cast is executable. E is not taken from a threatened champion.
function AnnieChampion:StartPrime(held,context,useful,owner)
 if self.prime then return false end
 local _,stacks=self:Stun()
 if stacks~=3 or not held()or not self:Ready(_E)or not useful()or self:DefenseWanted()then return false end
 local ok=Core:Cast(HK_E,self.profile.allyE and myHero or nil,{owner=owner or 'Prime',intentTarget=myHero,context=context,
  validate=function()local _,n=self:Stun();return held()and n==3 and self:Ready(_E)and useful()and not self:DefenseWanted()end})
 if ok then self.prime={action=Core.lastIntent.id,expires=Game.Timer()+1,held=held}end;return ok
end
function AnnieChampion:MaintainPrime()
 local p=self.prime;if not p then return end
 local r=Core.adapter:Poll(p.action)
 if not r or r.jobCancelled or r.state=='cancelled_before_send'or r.state=='send_uncertain'or Game.Timer()>=p.expires or not p.held()then
  Core.adapter:Cancel(p.action,'prime_ended');self.prime=nil
 elseif self:Stun()then self.prime=nil end
end
function AnnieChampion:ComboPrime(u,node)
 local _,stacks=self:Stun();if stacks~=3 or not self:Ready(_E)then return false end
 local function useful()
  if not self:Current(u)then return false end
  if node.R:Value()and self:Ready(_R)and self:Primable(_R)and self:Solve(_R,u,self:BurstKills(u,node)and 1 or node.Count:Value())then return true end
  return node.Q:Value()and self:Ready(_Q)and self:Primable(_Q)and self:Reach(u,625)
   or node.W:Value()and self:Ready(_W)and self:Primable(_W)and self:Reach(u,600)
 end
 local function held()return GetMode()=='Combo'and Core.manaAbove(node.Mana:Value())end
 return self:StartPrime(held,Core:ModeContext('Combo'),useful,'ComboPrime')
end
-- Normal E also shields Tibbers and adds a stack: cast it on Annie while Tibbers fights near an enemy champion.
-- Classic: whether Classic E reaches Tibbers is unmeasured (see TracePetE), so Classic does not do this.
function AnnieChampion:PetShield(context)
 if not self.profile.ePet or not self:Ready(_E)or not Core.manaAbove(Menu.Misc.EMana:Value())or not self:PetValid(self.pet)then return false end
 local pet=self.pet
 local function useful()
  if self.pet~=pet or not self:PetValid(pet)or not point(pet.object.pos)then return false end
  local rows=Core:Rows('hero')
  for i=1,#rows do if GetDistance(rows[i].pos,pet.object.pos)<=800 then return true end end;return false
 end
 if not useful()or self:DefenseWanted()then return false end
 return Core:Cast(HK_E,self.profile.allyE and myHero or nil,{owner='PetShield',intentTarget=myHero,range=self.profile.allyE and 800 or nil,context=context,
  validate=function()return self:Ready(_E)and Core.manaAbove(Menu.Misc.EMana:Value())and useful()and not self:DefenseWanted()end})
end
-- Development evidence for Classic: Tibbers' resistances around an E cast while he is alive.
function AnnieChampion:TracePetE()
 if self.profile.ePet then return end
 local pet=self.pet;local d=myHero:GetSpellData(_E);local cd=d and d.currentCd;local now=Game.Timer()
 local t=self.petETrace
 if t and now-t.at>=.4 then
  if pet and pet==t.pet and pet.object then Core:Trace('annie_classic_e_tibbers',{armorBefore=t.armor,armorAfter=pet.object.armor,mrBefore=t.mr,mrAfter=pet.object.magicResist,
   buffsBefore=t.buffs,buffsAfter=pet.object.buffCount})end
  self.petETrace=nil
 elseif not t and pet and finite(cd)and cd>0 and self.lastECd==0 and self.petLast and self.petLast.pet==pet then
  local b=self.petLast;self.petETrace={pet=pet,at=now,armor=b.armor,mr=b.mr,buffs=b.buffs}
 end
 -- The previous tick's values are the "before" sample: E has no cast time.
 self.petLast=pet and pet.object and {pet=pet,armor=pet.object.armor,mr=pet.object.magicResist,buffs=pet.object.buffCount}or nil
 self.lastECd=cd
end
function AnnieChampion:Combo()return self:Combat('Combo')end
-- Harass first takes a minion an attack would lose (the LastHit rule, governed by the spell-farm toggle), then pokes.
function AnnieChampion:Harass()
 local function permission()return Core:SpellFarmEnabled()and Core.manaAbove(Menu.LastHit.Mana:Value())end
 if permission()and self:RescueCast(Core:RescueContext(Core:ModeContext('Harass')),permission)then return true end
 return self:Combat('Harass')
end
function AnnieChampion:FarmList(jungle)
 local list=jungle and _G.SDK.ObjectManager:GetMonsters(625)or _G.SDK.ObjectManager:GetEnemyMinions(625);local rows,seen={},{}
 for i=1,math.min(#list,jungle and 12 or 40)do local u=list[i];local identity=id(u)
  if identity and not seen[identity]and self:Reach(u,625)and u.team~=myHero.team and(u.team==300)==jungle then seen[identity]=true;rows[#rows+1]=u end
 end;return rows
end
-- Q returns its mana on a kill: Clear may take every minion Q kills (`every`); Last Hit leaves the attack its own.
-- slot _W: the same rule for W (0.25 s, no travel).
function AnnieChampion:Rescue(u,every,slot)
 slot=slot or _Q;local range=slot==_Q and 625 or 600
 if not self:Current(u)or u.team==300 or not self:Reach(u,range)or not self:FarmStunAllowed()then return false end
 local delay=slot==_Q and .25+GetDistance(u.pos,myHero.pos)/1400 or .25;local hp=Core:UnshieldedLegacyForecast(u,delay)
 if not finite(hp)or hp<=0 or hp+(u.hpRegen or 0)*delay>self:Damage(u,slot)then return false end
 if not every and _G.SDK.Orbwalker:CanAttack()and _G.SDK.Data:IsInAutoAttackRange(myHero,u)then local windup=_G.SDK.Attack:GetWindup()
  local speed=myHero.attackData and myHero.attackData.projectileSpeed
  if not finite(windup)or not finite(speed)or speed<=0 then return false end
  local impact=windup+GetDistance(u.pos,myHero.pos)/speed;local ahp=Core:UnshieldedLegacyForecast(u,impact)
  local aa=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)
  if finite(ahp)and ahp>0 and ahp+(u.hpRegen or 0)*impact<=aa then return false end
 end;return true
end
-- The best W cone over minions W must rescue; at least two of them. With `aim` only that cone is weighed.
function AnnieChampion:RescueCone(aim)
 local dying={}
 for _,u in ipairs(self:FarmList(false))do if #dying>=12 then break end;if self:Rescue(u,false,_W)then dying[#dying+1]=u end end
 if #dying<2 then return nil end
 local origin=point(myHero.pos);local candidates={}
 if aim then candidates[1]=point(aim)else
  for i=1,#dying do candidates[#candidates+1]=point(dying[i].pos)end
  for i=1,#dying do for j=i+1,#dying do if #candidates>=24 then break end
   local a,b=point(dying[i].pos)-origin,point(dying[j].pos)-origin
   if a:Len()>0 and b:Len()>0 then candidates[#candidates+1]=origin+(a:Normalized()+b:Normalized())*300 end
  end end
 end
 local best
 for _,c in ipairs(candidates)do local n=0
  for _,u in ipairs(dying)do if self:ConeHit(u.pos,c,origin)then n=n+1 end end
  if n>=2 and(not best or n>best.count)then best={position=c,count=n}end
 end;return best
end
function AnnieChampion:RescueW(context,permission)
 local plan=self:RescueCone();if not plan then return false end
 local function allowed()return Menu.LastHit.W:Value()and permission()end
 return Core:Cast(HK_W,plan.position,{context=context,range=600,prevalidateWorldCast=true,deferAttackWindup=true,
  resolve=function()if not allowed()then return nil end;local fresh=self:RescueCone();return fresh and {position=fresh.position}end,
  validate=function(_,resolved)local aim=resolved and resolved.position
   return aim~=nil and allowed()and self:Ready(_W)and GetDistance(aim,myHero.pos)<=600 and self:RescueCone(aim)~=nil end})
end
-- Q takes the biggest minion an attack cannot take in time; with Q down W takes two or more such minions.
function AnnieChampion:RescueCast(context,permission)
 if Menu.LastHit.Q:Value()and self:Ready(_Q)then
  local best;for _,u in ipairs(self:FarmList(false))do if self:Rescue(u)and(not best or u.maxHealth>best.maxHealth)then best=u end end
  return best and self:CastQ(best,context,function()return Menu.LastHit.Q:Value()and permission()and self:Rescue(best)end)or false
 end
 return Menu.LastHit.W:Value()and self:Ready(_W)and self:RescueW(context,permission)or false
end
function AnnieChampion:LastHit()
 local function permission()return Core.manaAbove(Menu.LastHit.Mana:Value())end
 if not permission()then return false end
 return self:RescueCast(Core:ModeContext('LastHit'),permission)
end
-- Lane W: the cone that kills the cannon, else the most kills, then the most hits; it needs two kills, the cannon
-- or the configured hit count. With `aim` only that cone is weighed.
function AnnieChampion:Cannon(u)return type(u.charName)=='string'and u.charName:lower():find('siege',1,true)~=nil end
function AnnieChampion:LaneCone(minimum,aim)
 local rows=self:Rows('lane');if #rows==0 then return nil end
 local origin=point(myHero.pos);local candidates={}
 if aim then candidates[1]=point(aim)else
  for i=1,math.min(#rows,15)do candidates[#candidates+1]=rows[i].position end
  for i=1,#rows do for j=i+1,#rows do if #candidates>=24 then break end
   local a,b=rows[i].position-origin,rows[j].position-origin
   if a:Len()>0 and b:Len()>0 then candidates[#candidates+1]=origin+(a:Normalized()+b:Normalized())*300 end
  end end
 end
 local kills={}
 for k,row in ipairs(rows)do local v=row.unit;kills[k]=Core:Lethal(v,.25,function()return self:GetWDmg(v)end)==true end
 local best
 for _,c in ipairs(candidates)do local hits,killed,cannon=0,0,false
  for k,row in ipairs(rows)do if self:ConeHit(row.position,c,origin)then hits=hits+1
   if kills[k]then killed=killed+1;cannon=cannon or self:Cannon(row.unit)end end end
  if(killed>=2 or cannon or hits>=minimum)and(not best or cannon and not best.cannon
   or cannon==best.cannon and(killed>best.kills or killed==best.kills and hits>best.hits))then best={position=c,hits=hits,kills=killed,cannon=cannon}end
 end;return best
end
function AnnieChampion:LaneW(context,permission)
 local minimum=Menu.Clear.LaneClear.Count:Value();local plan=self:LaneCone(minimum);if not plan then return false end
 return Core:Cast(HK_W,plan.position,{context=context,range=600,prevalidateWorldCast=true,deferAttackWindup=true,
  resolve=function()if not permission()then return nil end;local fresh=self:LaneCone(minimum);return fresh and {position=fresh.position}end,
  validate=function(_,resolved)local aim=resolved and resolved.position
   return aim~=nil and permission()and self:Ready(_W)and GetDistance(aim,myHero.pos)<=600 and self:LaneCone(minimum,aim)~=nil end})
end
-- Jungle: E on Annie when a monster's attack on her is winding up or in flight (shield or resistances, reflect, and
-- a stack). The shared threat reading only watches champions, so the monster's own attack cast is read here.
function AnnieChampion:MonsterAttack(list)
 local me,handle=myHero.networkID,myHero.handle
 for i=1,math.min(#list,12)do local m=list[i]
  local cast=m and m.team==300 and Core:CastWindup(m,-.5,.75,true,me,handle)
  if cast then return m,cast end
 end
end
function AnnieChampion:JungleE(list,context,permission)
 if not self:Ready(_E)or self:Stun()or not Core.manaAbove(Menu.Misc.EMana:Value())then return false end
 local monster,cast=self:MonsterAttack(list);if not monster then return false end
 return Core:Cast(HK_E,self.profile.allyE and myHero or nil,{owner='JungleE',intentTarget=myHero,context=context,
  validate=function()return permission()and self:Ready(_E)and not self:Stun()and Core.manaAbove(Menu.Misc.EMana:Value())
   and Core:MatchesCastWindup(monster,cast,-.5,.75,true)end})
end
function AnnieChampion:Clear(kind)
 if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()or not self:FarmStunAllowed()then return false end
 local jungle=kind=='jungle';local node=Menu.Clear[jungle and 'JungleClear'or 'LaneClear'];if not Core.manaAbove(node.Mana:Value())then return false end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end);local list=self:FarmList(jungle)
 local function permit(slot)return node[slot]:Value()and Core.manaAbove(node.Mana:Value())and self:FarmStunAllowed()and Menu.Clear.SpellFarm:Value()end
 if jungle and #list>0 and self:JungleE(list,context,function()return Menu.Clear.SpellFarm:Value()end)then return true end
 if permit('W')and self:Ready(_W)then
  if not jungle then if self:LaneW(context,function()return permit('W')end)then return true end
  else
   local best;for _,u in ipairs(list)do if self:Reach(u,600)and(not best or u.maxHealth>best.maxHealth)then best=u end end
   if best and self:CastArea(_W,best,context,1,function()return permit('W')end,kind)then return true end
  end
 end
 if permit('Q')and self:Ready(_Q)then for _,u in ipairs(list)do
  if jungle or self:Rescue(u,true)then if self:CastQ(u,context,function()return permit('Q')and(jungle or self:Rescue(u,true))end)then return true end end
 end end;return false
end
function AnnieChampion:LaneClear()return self:Clear('lane')end
function AnnieChampion:JungleClear()return self:Clear('jungle')end
function AnnieChampion:Interrupt()
 if not Menu.Misc.Interrupt:Value()or not self:Stun()or not self:Ready(_Q)then return false end
 -- The shared rule: a real, interruptible channel that outlasts Q's cast and flight. No mode key needed.
 local function open(u)return Core:CanInterrupt(u,.25+GetDistance(u.pos,myHero.pos)/1400)end
 local rows=Core:Rows('hero',625)
 for i=1,#rows do local u=rows[i]
  if open(u)then local name,start=u.activeSpell.name,u.activeSpell.startTime
   return self:CastQ(u,{priority='interactive',condition=function()return Menu.Misc.Interrupt:Value()end},function()local c=u.activeSpell
    return Menu.Misc.Interrupt:Value()and self:Stun()and c and c.name==name and c.startTime==start and open(u)end)
  end
 end;return false
end
-- A ready stun answers an enemy dashing onto Annie.
function AnnieChampion:GapStun()
 if not Menu.Misc.GapStun:Value()or not self:Stun()or not self:Ready(_Q)then return false end
 local rows=Core:Rows('hero',625)
 for i=1,#rows do local u=rows[i]
  if Core:ApproachingDash(u,myHero.pos,350)then
   return self:CastQ(u,{priority='interactive',condition=function()return Menu.Misc.GapStun:Value()end},function()
    return Menu.Misc.GapStun:Value()and self:Stun()and(Core:ApproachingDash(u,myHero.pos,350)~=nil or self:Reach(u,350))end)
  end
 end;return false
end
-- A kill Q, W or R takes on its own is taken without a mode key; the stun is not held back for it. A champion the
-- SDK reads as unable to die (undying, revive, stasis-on-death) is never a kill.
function AnnieChampion:Kills(u,slot)
 if self:Immortal(u)then return false end
 return(Core:Lethal(u,slot==_Q and .25+GetDistance(u.pos,myHero.pos)/1400 or .25,function()return self:Damage(u,slot)end,{kind='magical'}))
end
function AnnieChampion:Finisher()
 local context={priority='interactive'}
 if self:Ready(_Q)then local rows=Core:Rows('hero',625)
  for i=1,#rows do local u=rows[i];if self:Kills(u,_Q)and self:CastQ(u,context,function()return self:Kills(u,_Q)end)then return true end end
 end
 if self:Ready(_W)then local rows=Core:Rows('hero',600)
  for i=1,#rows do local u=rows[i];if self:Kills(u,_W)and self:CastArea(_W,u,context,1,function()return self:Kills(u,_W)end)then return true end end
 end
 -- Tibbers only for a kill ready Q and W cannot take; the 250 circle reaches 850 (centre clamped to 600).
 if self:Ready(_R)then local rows=Core:Rows('hero',850)
  local function cheaper(u)return self:Ready(_Q)and self:Reach(u,625)and self:Kills(u,_Q)or self:Ready(_W)and self:Reach(u,600)and self:Kills(u,_W)end
  for i=1,#rows do local u=rows[i]
   if not cheaper(u)and self:Kills(u,_R)and self:CastArea(_R,u,context,1,function()return not cheaper(u)and self:Kills(u,_R)end)then return true end
  end
 end
 return false
end
function AnnieChampion:Flee()
 if self:CastE(myHero,Core:ModeContext('Flee'),true)then return true end
 if Menu.Misc.FleeStun:Value()and self:Stun()then local u=GetTarget(625)
  if IsValid(u)then return self:CastQ(u,Core:ModeContext('Flee'),function()return Menu.Misc.FleeStun:Value()and self:Stun()end)end
 end;return false
end
function AnnieChampion:Assist()
 if not Menu.Misc.RAssist:Value()or self.prime or Menu.Misc.StunAssist:Value()and not self:Stun()then return false end
 local u=GetTarget(850);if not IsValid(u)then return false end
 return self:CastArea(_R,u,Core:HeldContext(function()return Menu.Misc.RAssist:Value()end),1,
  function()return Menu.Misc.RAssist:Value()and(not Menu.Misc.StunAssist:Value()or self:Stun())end)
end
function AnnieChampion:PrimeStun()
 if self.prime then self:MaintainPrime();return false end
 local function held()return Menu.Misc.RAssist:Value()or Menu.Misc.FlashAssist:Value()and Menu.Misc.Flash:Value()end
 if self.primeUsed or not held()or not self:Ready(_R)then return false end
 local ok=self:StartPrime(held,Core:HeldContext(held),function()return self:Ready(_R)and self:PrimeUseful()end)
 if ok then self.primeUsed=true end;return ok
end
function AnnieChampion:PrimeUseful()
 local budget=myHero:GetSpellData(_E).mana+myHero:GetSpellData(_R).mana
 if myHero.mana<budget then return false end
 if Menu.Misc.RAssist:Value()then local u=GetTarget(850)
  return self:Current(u)and self:Reach(u,850)and self:Solve(_R,u,1)~=nil
 end
 if not Menu.Misc.FlashAssist:Value()or not Menu.Misc.Flash:Value()then return false end
 local status=Core:FlashStatus();if not status or budget+status.cost>myHero.mana then return false end
 local u=GetTarget(600+status.range);if not self:Current(u)then return false end
 local distance=GetDistance(u.pos,myHero.pos);if distance<=600 or distance>600+status.range then return false end
 local aim=myHero.pos:Extended(u.pos,math.min(status.range,distance-550))
 return self:SafeFlash(aim)and self:Solve(_R,u,1,'hero',aim)~=nil
end
function AnnieChampion:SafeFlash(pos)
 return point(pos)and type(Game.isWall)=='function'and Game.isWall(pos)==false and not IsUnderTurret2(pos)
  and GetEnemyCount(600,pos)<=Menu.Misc.Enemies:Value()and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.EngageHP:Value()
end
-- Flash toward the selected target, then R once the Flash is observed and Annie stands at the landing (shared
-- Core:FlashFollow); Q and W follow the sent R for two seconds while the bind is held.
function AnnieChampion:FlashAssist()
 local combo=self.flashCombo
 if combo:Busy()or self.followUp or self.flashUsed or self.prime or not Menu.Misc.FlashAssist:Value()or not Menu.Misc.Flash:Value()or not self:Ready(_R)
  or Menu.Misc.StunAssist:Value()and not self:Stun()then return false end
 local status=Core:FlashStatus();if not status then return false end
 local rCost=myHero:GetSpellData(_R).mana
 if not finite(rCost)or myHero.mana<status.cost+rCost then return false end
 local u=GetTarget(600+status.range);if not self:Current(u)or not self:Reach(u,600+status.range)then return false end
 local distance=GetDistance(u.pos,myHero.pos);if distance<=600 then return false end
 local aim=point(myHero.pos):Extended(u.pos,math.min(status.range,distance-550));local identity,handle=id(u),u.handle
 local function authorized()return Core.enabled and _G.SDK==self.sdk and _G.myHero==self.hero and Menu.Misc.FlashAssist:Value()and Menu.Misc.Flash:Value()end
 local function stun()return not Menu.Misc.StunAssist:Value()or self:Stun()end
 local function valid(pos)return self:Ready(_R)and self:Current(u)and id(u)==identity and u.handle==handle and self:SafeFlash(pos)
  and myHero.mana>=status.cost+myHero:GetSpellData(_R).mana and stun()and self:Solve(_R,u,1,'hero',pos)~=nil end
 local ok=combo:Start{order='flash_first',aim=aim,authorized=authorized,valid=valid,mana=rCost,
  follow=function(context)return self:CastArea(_R,u,context,1,function()return combo:Busy()and authorized()and stun()end)end}
 if ok then self.flashUsed=true;self.flashTarget={unit=u,id=identity,handle=handle}end;return ok
end
function AnnieChampion:ContinueFlash()
 local combo=self.flashCombo
 if combo:Busy()then
  local p=combo.plan;local owned=combo:Maintain()
  if not combo:Busy()and p.followed and combo.last and combo.last.reason=='done'and self.flashTarget then
   local t=self.flashTarget;self.followUp={unit=t.unit,id=t.id,handle=t.handle,expires=Game.Timer()+2}
  end
  if owned then return true end
 end
 return self:FlashFollowUp()
end
-- After the Flash-R: Q, then W on the same target while the bind is held, for at most two seconds.
function AnnieChampion:FlashFollowUp()
 local f=self.followUp;if not f then return false end
 local u=f.unit
 local function held()return self.followUp==f and Menu.Misc.FlashAssist:Value()and Menu.Misc.Flash:Value()end
 if Game.Timer()>=f.expires or not held()or not self:Current(u)or id(u)~=f.id or u.handle~=f.handle then self.followUp=nil;return false end
 local function permission()return held()and id(u)==f.id and u.handle==f.handle end
 -- Ignite once when the remaining burst plus Ignite kills and the burst alone does not. Bound to the held bind
 -- and this target, not to the follow-up window (which ends as soon as Q and W are spent).
 if not f.ignited and self:IgniteFinishes(u)then
  local function bind()return Menu.Misc.FlashAssist:Value()and Menu.Misc.Flash:Value()end
  if Core:Ignite(u,'AnnieFlashIgnite',function()return bind()and id(u)==f.id and u.handle==f.handle and self:IgniteFinishes(u)end,Core:HeldContext(bind))==true then f.ignited=true end
 end
 if self:Ready(_Q)and self:Reach(u,625)then return self:CastQ(u,Core:HeldContext(held),permission)end
 if self:Ready(_W)and self:Reach(u,600)then return self:CastArea(_W,u,Core:HeldContext(held),1,permission)end
 if not self:Ready(_Q)and not self:Ready(_W)then self.followUp=nil end
 return false
end
function AnnieChampion:DiscoverPet()
 local summon=self.summon
 if not summon or not summon.observed or not summon.center or summon.expires<=Game.Timer()then return false end
 local found
 for i=1,math.min(Game.MinionCount(),512)do local u=Game.Minion(i)
  if u and u.team==myHero.team and not u.dead and u.valid~=false and id(u)and not summon.before[id(u)]
   and own(u.owner)and point(u.pos)and GetDistance(u.pos,summon.center)<=300
   and u.type==Obj_AI_Minion and finite(u.totalDamage)and u.totalDamage>0 and finite(u.range)and u.range>0
   and finite(u.maxHealth)and u.maxHealth>1 and finite(u.attackSpeed)and u.attackSpeed>0
   and finite(u.spawnTime)and u.spawnTime>=summon.started and u.spawnTime<=Game.Timer()then
   if found then return false end;found=u
  end
 end
 if found then self.pet={object=found,id=id(found),handle=found.handle,expires=summon.started+45};self.summon=nil;return true end;return false
end
function AnnieChampion:PetValid(p)
 if not p or p.expires<=Game.Timer()or not p.object or p.object.dead or not own(p.object.owner)then return false end
 for i=1,math.min(Game.MinionCount(),512)do local u=Game.Minion(i)
  if u and id(u)==p.id and u.handle==p.handle and u.team==myHero.team and not u.dead and u.valid~=false and own(u.owner)then return true end
 end;return false
end
function AnnieChampion:PetAssist()
 if not Menu.Misc.Pet:Value()or self.petUsed or not self:Ready(_R,true)or not self:PetValid(self.pet)then return false end
 local aim=_G.SDK.GetPlayerPosition and _G.SDK.GetPlayerPosition()or nil
 if not point(aim)or GetDistance(aim,myHero.pos)>600 or type(Game.isWall)~='function'or Game.isWall(aim)~=false then return false end
 local pet=self.pet;local pos=point(aim)
 local ok=Core:Cast(HK_R,pos,{owner='Pet',range=600,context=Core:HeldContext(function()return Menu.Misc.Pet:Value()end),
  resolve=function()return {position=pos}end,prevalidateWorldCast=true,
  validate=function()return Menu.Misc.Pet:Value()and self.pet==pet and self:PetValid(pet)and self:Ready(_R,true)
   and Game.isWall(pos)==false end,
  observe=function(q)local a=myHero.activeSpell;return a and self.profile.guides[a.name]and Core:NativeCast(q,a.name)~=nil end})
 if ok then
  self.petUsed=true;self.petOrder=Core.lastIntent.id
  Core:AfterCast(HK_R,function(q)if self.pet==pet and not q.ambiguous then self.petAutomatic=nil end end)
 end;return ok
end
-- Keyless multi-stun: with the stun primed, R or W on the configured enemy count; at three stacks E primes it first
-- when one of those casts is executable right now.
function AnnieChampion:AutoStun()
 local misc=Menu.Misc
 if self.prime or not(misc.AutoStunR:Value()or misc.AutoStunW:Value())or not Core.manaAbove(misc.AutoStunMana:Value())then return false end
 local target=GetTarget(850);if not self:Current(target)then return false end
 local primed=self:Stun()
 if not primed then
  local function plan()
   if not self:Current(target)then return false end
   for _,slot in ipairs({_R,_W})do local node=slot==_R and misc.AutoStunR or misc.AutoStunW
    if node:Value()and self:Ready(slot)and self:Primable(slot)and self:Solve(slot,target,misc.AutoStunCount:Value())then return true end
   end;return false
  end
  local function held()return(misc.AutoStunR:Value()or misc.AutoStunW:Value())and Core.manaAbove(misc.AutoStunMana:Value())end
  return self:StartPrime(held,{priority='interactive',condition=held},plan,'AutoPrime')
 end
 for _,slot in ipairs({_R,_W})do
  local node=slot==_R and misc.AutoStunR or misc.AutoStunW
  if node:Value()and self:Ready(slot)then
   local function permission()return node:Value()and self:Stun()and Core.manaAbove(misc.AutoStunMana:Value())end
   if self:CastArea(slot,target,{priority='interactive',condition=permission},misc.AutoStunCount:Value(),permission)then return true end
  end
 end
 return false
end
function AnnieChampion:AutoPet()
 if not Menu.Misc.AutoPet:Value()or Menu.Misc.Pet:Value()or GetMode()~='Combo'
  or not self:Ready(_R,true)or not self:PetValid(self.pet)then return false end
 local pet=self.pet;local previous=self.petAutomatic
 if previous and previous.pet==pet then
  local q=previous.intent
  -- Uncertain or unattributable input requires a new pet or explicit manual
  -- order. Cooldown-free pet commands must not be blindly replayed.
  if not q.observedAt or q.ambiguous or Game.Timer()-(q.observationGameTime or previous.at)<.35 then return false end
 end
 local target=GetTarget(600)
 if not self:Current(target)or not self:Reach(target,600)then return false end
 local destination=point(target.pos);local identity,handle=id(target),target.handle
 if not destination or type(Game.isWall)~='function'or Game.isWall(destination)~=false then return false end
 if previous and previous.pet==pet and previous.id==identity and GetDistance(previous.position,destination)<75 then return false end
 local function permission()return Menu.Misc.AutoPet:Value()and not Menu.Misc.Pet:Value()and self.pet==pet
  and self:PetValid(pet)and self:Ready(_R,true)and self:Current(target)and id(target)==identity
  and target.handle==handle and self:Reach(target,600)end
 local accepted=Core:Cast(HK_R,destination,{owner='AutoPet',range=600,context=Core:ModeContext('Combo',permission),ttl=150,
  intentTarget=target,prevalidateWorldCast=true,
  resolve=function()if not permission()then return nil end;local pos=point(target.pos)
   if not pos or Game.isWall(pos)~=false then return nil end;return {position=pos}end,
  validate=function(_,resolved)return permission()and resolved and Game.isWall(resolved.position)==false end,
  observe=function(q)local cast=myHero.activeSpell
   return cast and self.profile.guides[cast.name]and Core:NativeCast(q,cast.name)~=nil end})
 if accepted then self.petAutomatic={pet=pet,intent=Core.lastIntent,id=identity,position=destination,at=Game.Timer()}end
 return accepted
end
-- Enemy champions whose last known position is within 2500 of Annie: a visible one, or one hidden for under 3 s.
-- Hidden longer, the last position no longer says where the enemy is and the area counts as quiet for it.
function AnnieChampion:QuietArea()
 local now=Game.Timer();local seen=self.seen or {};self.seen=seen;local quiet=true
 for i=1,math.min(Game.HeroCount(),16)do local u=Game.Hero(i);local identity=id(u)
  if u and identity and u.team~=myHero.team and not u.dead then
   if u.visible~=false then seen[identity]=now end
   local pos=point(u.pos)
   if not pos or(u.visible~=false or now-(seen[identity]or -math.huge)<3)and GetDistance(pos,myHero.pos)<=2500 then quiet=false end
  end
 end;return quiet
end
-- With no mode key, no enemy champion near and no recall: E on Annie at 90% mana, W at full mana (the fountain)
-- where no minion or monster stands, until the stun is primed.
function AnnieChampion:BuildStun()
 local misc=Menu.Misc
 if not misc.BuildStun:Value()or GetMode()~=nil or self.prime or self:Stun()or Recalling(myHero)or not self:QuietArea()then return false end
 local function permission()return misc.BuildStun:Value()and GetMode()==nil and not self:Stun()and not Recalling(myHero)and self:QuietArea()end
 local context={priority='background',condition=permission}
 if self:Ready(_E)and Core.manaAbove(90)then
  return Core:Cast(HK_E,self.profile.allyE and myHero or nil,{owner='BuildStun',intentTarget=myHero,context=context,
   validate=function()return permission()and self:Ready(_E)and Core.manaAbove(90)end})
 end
 local function clear()return #Core:Rows('lane',900)==0 and #Core:Rows('jungle',900)==0 end
 if self:Ready(_W)and Core.manaAbove(98)and clear()then
  local cursor=point(_G.SDK.GetPlayerPosition and _G.SDK.GetPlayerPosition()or mousePos)
  if not cursor or GetDistance(cursor,myHero.pos)<1 then return false end
  local aim=point(myHero.pos):Extended(cursor,300)
  return Core:Cast(HK_W,aim,{owner='BuildStun',range=600,context=context,prevalidateWorldCast=true,
   resolve=function()return permission()and {position=aim}or nil end,
   validate=function()return permission()and self:Ready(_W)and Core.manaAbove(98)and clear()end})
 end
 return false
end
-- The R landing spot (with how many it hits) and Tibbers. No stun-stack text: the game shows Pyromania;
-- combo damage and the kill mark are on the health bars (shared display). Kept for a second so a late
-- preparation never blinks it; Draw shows the landing only while R is ready and Tibbers while it lives.
function AnnieChampion:PreparePreview()
 if not Menu.Draw.Preview:Value()then self.preview=nil;return end
 local preview={expires=Game.Timer()+1}
 local u=self:Ready(_R)and GetTarget(850);local r=u and IsValid(u)and self:Solve(_R,u,1)
 preview.count,preview.position=r and r.count or 0,r and point(r.position)
 local pet=self.pet;if pet and pet.object then preview.pet={object=pet.object,handle=pet.handle,expires=pet.expires}end
 self.preview=preview
end
function AnnieChampion:Shutdown(reason)cleanup(self,reason)end
function AnnieChampion:Tick()
 if ShouldWait()then self:Shutdown('unavailable');return end
 if Game.Timer()>=(self.nextPriorities or 0)then self:RefreshEPriorities()end
 if not Menu.Misc.FlashAssist:Value()then self.flashUsed=false end
 if not Menu.Misc.Pet:Value()then self.petUsed=false end
 if not Menu.Misc.RAssist:Value()and not Menu.Misc.FlashAssist:Value()then self.primeUsed=false end
 if self.pet and not self:PetValid(self.pet)then self.pet=nil;if self.petOrder then Core.adapter:Cancel(self.petOrder,'pet_identity_ended');self.petOrder=nil end end
 self:DiscoverPet();self:TracePetE()
 if Menu.Misc.BuildStun:Value()then self:QuietArea()end
 if self:ContinueFlash()or self:Defend()or IsCasting()then return end
  if self:PrimeStun()or self:Assist()or self:FlashAssist()or self:PetAssist()or self:Interrupt()or self:GapStun()or self:Finisher()or self:AutoStun()or self:AutoPet()then return end
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LaneClear'then
  if not self:LaneClear()then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()elseif not mode then self:BuildStun()end
 if self.previewFallback then self:PreparePreview()end
end
function AnnieChampion:Draw()
 if myHero.dead then return end
 local color=Draw.Color(255,220,130,70)
 if Menu.Draw.Ranges:Value()and self:Ready(_Q)then Draw.Circle(myHero.pos,625,1,color)end
 local p=self.preview;if not p or p.expires<=Game.Timer()or not Menu.Draw.Preview:Value()then return end
 if p.position and p.count>0 and self:Ready(_R)then
  Draw.Circle(p.position,250,1,color);local s=p.position:To2D();Draw.Text('R hits '..p.count,16,s.x-20,s.y,color)
 end
 local pet=p.pet;local o=pet and pet.object
 if o and not o.dead and o.handle==pet.handle and point(o.pos)and pet.expires>Game.Timer()then Draw.Circle(o.pos,350,1,color)end
end
function AnnieChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Annie: modes','Annie: assistance'},function(page)
  return {title=page==1 and 'Annie modes'or 'Annie assistance',cards=page==1 and {
   {'MODES','Use provider Combo/Harass and separate lane/jungle binds. Q rescues living CS using impact health (also while holding Harass); with Q down W takes two minions an attack would lose. Lane W aims at the cone that kills the most minions, the cannon first.'},
   {'STUN','Native owned primed buffs control reservation. At three stacks E readies the stun before a Combo or automatic stun cast. With no enemy near, E (and W at full mana) build the stun. A primed stun is kept while farming near enemies, except under an allied turret.'},
   {'DEFENSE','E goes on a champion below the health limit who is about to be hit by an attack, a targeted spell, a turret or a tracked skillshot, and on Annie against monster attacks while jungling. Normal E also protects allies by priority, shields Tibbers in Combo and is offered to Evade as a shield; Classic E is self defense. A ready stun answers channels and enemies dashing onto Annie; a kill Q, W or R takes is taken without a mode key, never on a champion that cannot die.'}}or {
   {'TIBBERS','The selected-target R bind casts Tibbers on your chosen enemy; at three stacks E readies the stun first. Combo R needs its enemy count with the stun ready (two more without it), two when R kills one of them, or one target that the burst kills.'},
   {'FLASH','Allow Flash in the menu, then hold the Flash-R bind. R waits for actual Flash execution and native landing, then Q and W follow; release cancels remaining work.'},
    {'PET','The Tibbers bind sends your Tibbers toward the cursor once per press. Optional automatic pet orders follow the held Combo target after an attributable previous order, with bounded spacing and no uncertain-input replay. Native owner, unique spawn and guide stage are required.'},
    {'MULTI-STUN','Automatic W and R stuns have separate switches and share an enemy count and a mana limit. Native stun readiness and fresh predicted hit geometry are required.'}}}
 end)
end
Core:RegisterPolicy({damageTypes={Q='magical',W='magical',R='magical'},methods={
 Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,
 JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
 LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end},
 channel=function()return not Core:SelfChanneling()end,
  validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot,slot==_R and(q.owner=='Pet'or q.owner=='AutoPet'))end;return true end})
AnnieChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Annie"]="Annie"}
local normalSupported={["Annie"]=true}

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
