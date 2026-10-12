return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("75920ecdc95c04d25d20998cca2c80e56f39aff902517072680d64c48fd1cb52")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["MasterYi"]=function()return _G.OrbamaFamily:Require("bae5483318392009e6f27da817d8424c25a808beebb23297893ad137c6a87285")()end
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
if champion=="MasterYi" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='MasterYi',profiles={normal=true,classic=true},
 Create=function(context)
local Version = 2.01

-- Installed asset inputs. These names are profile candidates, not live verification.
local profiles=ChampionProfiles('MasterYi')
local finite,identity,manaAbove,buffExpiry=Core.finite,Core.id,Core.manaAbove,Core.buffExpiry
-- Defensive Meditate needs an enemy champion this close.
local W_THREAT_RANGE=900
local function closeReset(self,reason)
 local row=self.resetSequence;self.resetSequence=nil
 if not row then return end
 self.lastResetReason=reason
 local client=Core.adapter
 self.retiredResets=self.retiredResets or {}
 for _,id in ipairs({row.castID,row.attackID})do if id then
  client:Cancel(id,reason or 'reset_complete')
  if not client:Finish(id)then self.retiredResets[#self.retiredResets+1]=id end
 end end
end
local function reconcileResets(self)
 local list=self.retiredResets;if not list then return end
 for i=#list,1,-1 do local id=list[i]
  if not Core.adapter:Poll(id)or Core.adapter:Finish(id)or Core.adapter:Reconcile(id)then table.remove(list,i)end
 end
end
-- Alpha Strike untargetable dodge profile published to Evade (SDK.ChampionMobility,
-- kind 'untargetable'). Asset facts (both profiles' spells.json, AlphaStrike):
-- castRange 600, castFrame 7.935 (30 fps = .26 s), bounce missileSpeed 4000,
-- bounce search 550 (field 8f6f40e6), per-strike field 11704a2b = .25.
-- Classic send-to-untargetable bracket from live family telemetry (session
-- 5e039937, Jade_MasterYi, 13 owned Q sends; 0.5 s hero samples): send ->
-- activeSpell.startTime .042-.073 s (windup .10); hero.isTargetable still true
-- at send+.170/.175/.176/.187 and already false at send+.176 (one case), so the
-- onset follows cast end (start+.10) by roughly 0-.05 s, varying per cast
-- (true at end+.039 once, false at end+.021 once). Planning bracket .14-.22 s keeps margin on
-- both sides; the coarse samples do not bound it tightly. The minimum duration
-- (.25, one strike interval, single-target assumption) stays unmeasured: the
-- samples show Yi still untargetable .46-.95 s after cast start (bounce count
-- unknown) and targetable again by .73-.75 s in two casts. classic.yi_q_timing
-- development rows measure each cast per tick. Normal timing stays unmeasured
-- (.05-.15 planning bracket); Classic evidence is not borrowed for it.
local untargetableProfiles={
    classic={name='Jade_MasterYiAlphaStrike',range=600,bounce=550,duration=.25,castDelays={.14,.22},
        source='Jade_MasterYi spells.json AlphaStrike castRange 600, bounce 550, strike field .25; start bracket .14-.22 from live telemetry 5e039937 (coarse 0.5 s samples); duration .25 unmeasured'},
    normal={name='AlphaStrike',range=600,bounce=550,duration=.25,castDelays={.05,.15},
        source='MasterYi spells.json AlphaStrike castRange 600, bounce 550, strike field .25; untargetable timing unmeasured (planning bracket)'},
}


local MasterYiChampion=class("MasterYiChampion")

function MasterYiChampion:__init()
	self.profile = profiles[myHero.charName == 'Jade_MasterYi' and 'classic' or 'normal']
	self.lastQ = 0
	self:LoadMenu()
	Callback.Add("Draw", function() self:Draw() end)
	Callback.Add("Tick", function() self:Tick() end)
	_G.SDK.Orbwalker:OnPreAttack(function(...) self:OnPreAttack(...) end)
	_G.SDK.Orbwalker:OnPostAttack(function(...) self:OnPostAttack(...) end)
	self.QSpell = {Range = 600}
	self.RSearchRange = 1000
	self.meditateStart = 0
	self.wasMeditating = false
	Core:RegisterCleanup('MasterYi.reset',function()closeReset(self,'controller_closed');self.ownQ=nil;self.preview=nil;self.lastCompletedAttack=nil;self.doubleStrikeObservation=nil;self.qActive=nil
	 self.stickSpot=nil;if Core.ReleaseMovePreference then Core:ReleaseMovePreference('yi_stick')end end)
 local ok,why=Core:RegisterPreparation('MasterYi.preview',{intervalMs=100,maxDelayMs=350,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Q:Value()end,function()self.preview=nil end)
 self.preparationFallback=not ok and why=='unsupported'
	self:PublishMobility()
	self:OfferDefense()
	if Core.RegisterComboDamage then Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)end
end

-- Health-bar combo estimate (S9): a ready Q's primary hit plus the next two attacks
-- (live E and a ready Double Strike once). Partial: bounces, crits and items omitted.
function MasterYiChampion:ComboDamage(unit)
	if not IsValid(unit)then return 0 end
	local q=self:Ready(_Q)and self:GetQDmg(unit)or 0
	local aa=self:TwoAttackForecast(unit)
	return (finite(q)and q or 0)+(finite(aa)and aa or 0)
end

-- Meditate offered to Evade (S6). Normal: staged damage reduction (70% for the first
-- .5 s, then 45-55% by rank) while channelling; Classic: flat armor and magic resist.
-- Numbers from the profile (asset + wiki, see the profile header). Evade judges the danger;
-- AutoW stays the fallback without Evade. Not offered while an own reset owns W.
function MasterYiChampion:OfferDefense()
	local p=self.profile
	if not Core.RegisterEffect or not finite(p.wDelay)or not finite(p.wChannel)or type(p.wSource)~='string'then return end
	local function rank()local d=myHero:GetSpellData(_W);local l=d and d.level;return finite(l)and l>=1 and l<=5 and l%1==0 and l or nil end
	local spec={name=p.w,slot=_W,key=HK_W,profile=p.id,source=p.wSource,spell=p.w,delay=p.wDelay,duration=p.wChannel,channel=true,
		ready=function()return not self.resetSequence and not self:IsMeditating()end}
	if p.id=='normal'then
		if not p.wReduction or not p.wInitial or not finite(p.wInitialSeconds)then return end
		spec.kind='reduction'
		spec.fraction=function()local l=rank();return l and p.wReduction[l]end
		spec.stages=function()local l=rank();if not l then return nil end
			return {{seconds=p.wInitialSeconds,fraction=p.wInitial[l]},{fraction=p.wReduction[l]}}end
	else
		if not p.wResist then return end
		spec.kind='resist'
		spec.armor=function()local l=rank();return l and p.wResist[l]end
		spec.magicResist=spec.armor
	end
	self.defenseOffered,self.defenseReason,self.defenseAdapter=Core:RegisterEffect(spec)
end

function MasterYiChampion:LoadMenu()
	local championIcon = "http://ddragon.leagueoflegends.com/cdn/16.15.1/img/champion/MasterYi.png"
	Menu = MenuElement({type = MENU, id = "Classic_AIO_"..myHero.charName, name='AyyyyIO - Master Yi', leftIcon = championIcon})

	Menu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	Menu.Combo:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "QSafe", name = "Never Q onto an enemy under their turret", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "R", name = "Use R", toggle = true, value = true})
	Menu.Combo:MenuElement({id = "WReset", name = "Use W to reset attacks", value = true})
	Menu.Combo:MenuElement({id = "Stick", name = "Stay at attack range from the target while the cursor is near it", value = false, menu = false})

	Menu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	Menu.Harass:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	if self.profile.id == 'normal' then
		Menu.Harass:MenuElement({id = "E", name = "Use E before attacks on a champion", toggle = true, value = true})
	end
	Menu.Harass:MenuElement({id = "Mana", name = "Only above mana %", value = 40, min = 0, max = 100, step = 5})

	Menu:MenuElement({type = MENU, id = "Clear", name = "Farming"})
	Menu.Clear:MenuElement({id = "SpellFarm", name = "Use abilities to farm (lane, jungle, last hit)", toggle = true, value = SpellFarmDefault(), key = 73, callback = function(newValue)
		if CheckChatBlock(Menu.Clear.SpellFarm, newValue) then return end
	end})
	Menu.Clear:MenuElement({type = MENU, id = "LaneClear", name = "LaneClear"})
	Menu.Clear.LaneClear:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Clear.LaneClear:MenuElement({id = "QCount", name = "Lane minions Q must hit", value = 3, min = 1, max = 4, step = 1})
	Menu.Clear.LaneClear:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	Menu.Clear:MenuElement({type = MENU, id = "JungleClear", name = "JungleClear"})
	Menu.Clear.JungleClear:MenuElement({id = "Q", name = "Use Q", toggle = true, value = true})
	Menu.Clear.JungleClear:MenuElement({id = "E", name = "Use E", toggle = true, value = true})
	Menu.Clear.JungleClear:MenuElement({id = "QCount", name = "Monsters Q must hit", value = 2, min = 1, max = 4, step = 1, menu = false})
	Menu.Clear.JungleClear:MenuElement({id = "QLarge", name = "Also Q a lone monster two attacks cannot kill", toggle = true, value = true, menu = false})
	Menu.Clear.JungleClear:MenuElement({id = "Mana", name = "Only above mana %", value = 15, min = 0, max = 100, step = 5})
	Menu.Clear.JungleClear:MenuElement({id = "W", name = "Use W to heal when no enemy is near", toggle = true, value = true})
	Menu.Clear.JungleClear:MenuElement({id = "WHP", name = "Heal with W below health %", value = 40, min = 10, max = 80, step = 5})
	Menu.Clear.JungleClear:MenuElement({id = "WReset", name = "Use W to reset attacks", value = true})
	Menu:MenuElement({type = MENU, id = "LastHit", name = "LastHit"})
	Menu.LastHit:MenuElement({id = "Q", name = "Use Q on minions an attack cannot take", value = true})

	Menu:MenuElement({type = MENU, id = "KillSteal", name = "Finish killable enemies"})
	Menu.KillSteal:MenuElement({id = "Q", name = "Use Q without holding a mode key", toggle = true, value = true})

	Menu:MenuElement({type = MENU, id = "Misc", name = "Behaviour"})
	Menu.Misc:MenuElement({id = "AutoW", name = "W at low health without holding a mode key", toggle = true, value = true})
	Menu.Misc:MenuElement({id = "WHP", name = "Use W below health %", value = 30, min = 5, max = 80, step = 5})
	Menu.Misc:MenuElement({id = "WChannel", name = "Keep channeling W for at least (seconds)", value = 1, min = 0, max = 3, step = 1, menu = false})
	Menu.Misc:MenuElement({id = "FleeR", name = "Use R in Flee when an enemy is near", toggle = true, value = true})
	Menu.Misc:MenuElement({id = "FleeQ", name = "Use Q in Flee on a unit toward the cursor", toggle = true, value = true})

	Menu:MenuElement({type = MENU, id = "Draw", name = "Drawings"})
	Menu.Draw:MenuElement({id = "Q", name = "Q range", toggle = true, value = false})
end

function MasterYiChampion:IsMeditating()
	if self:NativeSpell(self.profile.w, true) then return true end
	-- Live telemetry (session 6e1430a7, 8216 ticks): the unconditional buff scan
	-- here was ~65% of Yi's Tick cost. An unlearned W, or a W the host reports
	-- castable with no cooldown, cannot be an active Meditate channel; then the
	-- buff witness is not read. Any other state still reads the live buff.
	local s=myHero:GetSpellData(_W)
	if not s or (s.level or 0)<1 then return false end
	if (s.currentCd or 0)==0 and Game.CanUseSpell(_W)==0 and not self.wasMeditating then return false end
	return self:LiveBuff(self.profile.w)
end

-- Buff names come from the core's per-evaluation index (one scan per callback);
-- only a slot with the wanted name is read again.
local lowerNames={}
function MasterYiChampion:LiveBuff(name,horizon)
 local count=myHero.buffCount
 if not finite(count)or count<0 or count>128 or count%1~=0 then return nil end
 local wanted=lowerNames[name];if not wanted then wanted=name:lower();lowerNames[name]=wanted end
 local index=Core:BuffNames(myHero);if index and index.n~=count then index=nil end
 for i=0,count do local b=(not index or index[i]==wanted)and myHero:GetBuff(i)
  if b and type(b.name)=='string'and b.name:lower()==wanted then
   local last=buffExpiry(b)
   local src=b.source;local actor=type(src)=='number'and src or(type(src)=='table'or type(src)=='userdata')and identity(src)
   local sourceOK=src==nil or type(src)=='number'or type(src)=='table'or type(src)=='userdata'
   if type(src)=='table'or type(src)=='userdata'then sourceOK=sourceOK and(not src.networkID or src.networkID==0 or src.networkID==myHero.networkID)and(not src.handle or src.handle==0 or src.handle==myHero.handle)end
   if sourceOK and(not actor or actor==0 or actor==myHero.networkID or actor==myHero.handle)
    and(not b.sourcenID or b.sourcenID==0 or b.sourcenID==myHero.networkID)and(not b.sourceName or b.sourceName==''or b.sourceName==myHero.charName)
    and finite(b.count)and b.count>0 and b.count%1==0 and finite(last)and last>Game.Timer()+(horizon or 0)then return b,last end
  end
 end
end
function MasterYiChampion:Ready(slot)
 local d=myHero:GetSpellData(slot);local alias=self.profile[({'q','w','e','r'})[slot+1]]
 return d and d.name==alias and finite(d.level)and d.level%1==0 and d.level>0 and d.level<=(slot==_R and 3 or 5)
  and d.currentCd==0 and Game.CanUseSpell(slot)==0 and finite(d.mana)and d.mana>=0 and finite(myHero.mana)and myHero.mana>=d.mana
end
function MasterYiChampion:EBuff(horizon)
 return self:LiveBuff(self.profile.eActive,horizon)or self:LiveBuff(self.profile.e,horizon)
end

-- A channel lasts until its channel end. Live 2026-10-10 (Normal Meditate): the host
-- reports castEndTime==startTime and the 4 s channel end in endTime. Reading only
-- castEndTime never saw the reset's own Meditate, so the reset waited out its 1 s
-- deadline while the minimum W hold kept Yi channelling (26:39: next attack 697 ms late).
function MasterYiChampion:NativeSpell(name,channel)
    local spell=myHero.activeSpell
    if not(spell and spell.valid and not spell.isStopped and spell.name==name and finite(spell.startTime)and spell.startTime<=Game.Timer()
        and (not channel or spell.isChanneling==true) and finite(spell.castEndTime))then return false end
    local finish=spell.castEndTime
    if channel and finite(spell.endTime)and spell.endTime>finish then finish=spell.endTime end
    return finish>Game.Timer()
end

function MasterYiChampion:ObserveQ()
    local active=self:NativeSpell(self.profile.q)
    local q=Core.pending and Core.pending[HK_Q]
    local cast=q and not q.ambiguous and Core:NativeCast(q,self.profile.q)
    if cast and q.observedAt and q.object and(cast.target==q.targetID or cast.target==q.object.handle)
     and(not self.ownQ or self.ownQ.request.id~=q.id or self.ownQ.start~=cast.startTime)then
     self.ownQ={request=q,start=cast.startTime,expires=cast.startTime+3,target=q.object,targetID=q.object.networkID,handle=q.object.handle}
    end
    if not active and self.profile.id=='normal'then active=self:LiveBuff('Alpha_Striking')~=nil end
    -- Classic: its Alpha Strike buff name is unmeasured (yi_q_timing.buff); after the
    -- native cast ends, an own observed Q is still running while Yi is untargetable.
    if not active and self.profile.id=='classic'and self:ClassicAlphaHeld(self.ownQ)then active=true end
    if active and not self.qActive then self.qEnteredAt=Game.Timer() end
    if self.qActive and not active then self.qExitedAt=Game.Timer() end
    self.qActive=active
    if self.ownQ and(Game.Timer()>self.ownQ.expires or not active)then self.ownQ=nil end
end
function MasterYiChampion:CastQ(target,options)
 options=options or {};local id,handle=target and target.networkID,target and target.handle
 if not target or not self:Ready(_Q)then return false end
 options.observe=options.observe or function(q)
  local cast=Core:NativeCast(q,self.profile.q)
  return cast and(cast.target==id or cast.target==handle)
 end
 if not Core:Cast(HK_Q,target,options)then return false end
 local q=Core.lastIntent
 Core:AfterCast(HK_Q,function()
  self.lastQ=GetTickCount();local cast=Core:NativeCast(q,self.profile.q)
  if cast and not q.ambiguous and target.networkID==id and target.handle==handle then
   self.ownQ={request=q,start=cast.startTime,expires=cast.startTime+3,target=target,targetID=id,handle=handle}
  end
 end)
 return true
end
-- Classic Alpha Strike after its native cast ended: the own observed Q row, Yi
-- untargetable, within the profile's bounded window from the observed cast start.
local CLASSIC_ALPHA_WINDOW=1.5
function MasterYiChampion:ClassicAlphaHeld(row)
 if not row or not finite(row.start)then return false end
 local now=Game.Timer()
 return myHero.isTargetable==false and now>=row.start and now<=row.start+CLASSIC_ALPHA_WINDOW and now<=row.expires
end
function MasterYiChampion:OwnAlpha()
 local row=self.ownQ;if not row or not Core:InputAvailable()or Game.Timer()>row.expires or self:IsMeditating()then return nil end
 local q=row.request;local target=row.target
 if q.ambiguous or not q.observedAt or not IsValid(target)or not self:CurrentTarget(target)or target.networkID~=row.targetID or target.handle~=row.handle
  or not Core.adapter:ContextValid(q,'continuation')then return nil end
 local cast=myHero.activeSpell
 local exact=self:NativeSpell(self.profile.q)and cast.startTime==row.start and(cast.target==row.targetID or cast.target==row.handle)
 local held
 if self.profile.id=='normal'then
  local b=self:LiveBuff('Alpha_Striking');held=b and finite(b.startTime)and b.startTime>=row.start and b.startTime<=Game.Timer()and myHero.isTargetable==false
 else held=self:ClassicAlphaHeld(row)end
 return(exact or held)and row or nil
end
function MasterYiChampion:AlphaWeave()
 local row=self:OwnAlpha();if not row then return false end
 local target=row.target
 local function eAllowed()
  -- Classic E trades its passive AD for the active: only for a champion Q target.
  if self.profile.id=='classic'and target.type~=Obj_AI_Hero then return false end
  if row.request.mode=='Combo'and GetMode()=='Combo'then return Menu.Combo.E:Value()end
  return row.request.mode=='LaneClear'and target.team==300 and Core:FarmModeEnabled('jungle')and Menu.Clear.SpellFarm:Value()and Menu.Clear.JungleClear.E:Value()and manaAbove(Menu.Clear.JungleClear.Mana:Value())
 end
 if eAllowed()and self:Ready(_E)and not self:EBuff()then
  return Core:Cast(HK_E,nil,{owner='AlphaWeaveE',intentTarget=target,context=row.request.context,
   validate=function()return self:OwnAlpha()==row and eAllowed()and not self:EBuff()end,
   observe=function(q)return Core:NativeCast(q,self.profile.e)~=nil end})
 end
 if row.request.mode=='Combo'and GetMode()=='Combo'and Menu.Combo.R:Value()and self:Ready(_R)and not self:LiveBuff(self.profile.r)and self:RWanted(target)then
  return Core:Cast(HK_R,nil,{owner='AlphaWeaveR',intentTarget=target,context=row.request.context,
   validate=function()return self:OwnAlpha()==row and GetMode()=='Combo'and Menu.Combo.R:Value()and not self:LiveBuff(self.profile.r)and self:RWanted(target)end,
   observe=function(q)return Core:NativeCast(q,self.profile.r)~=nil end})
 end
 return false
end
-- Normal Double Strike: every 4th consecutive attack strikes twice. The game shows
-- 1 and 2 stacks, then the passive turns "ready" after the third attack (live,
-- player report 2026-10-10): stacks 3+ or a ready-type DoubleStrike buff mean the
-- next attack doubles. When the 2-stack buff vanishes after an own attack and no
-- double strike was seen since, the passive is ready until it times out
-- (dsDuration) or the double strike is observed. No buff at all is 0 stacks.
function MasterYiChampion:DoubleStrikeState(horizon)
 if self.profile.id~='normal'then return {kind='random',ready=false,observed=self.doubleStrikeObservation}end
 local now=Game.Timer();local track=self.dsTrack or {};self.dsTrack=track
 local stacks=self:LiveBuff('DoubleStrikeStacks',horizon)
 local ready,last=self:LiveBuff('DoubleStrikeReady',horizon)
 if not ready then
  local count=myHero.buffCount
  if finite(count)and count>=0 and count<=128 then
   local index=Core:BuffNames(myHero);if index and index.n~=count then index=nil end
   for i=0,count do local cached=index and index[i]
    local b=(not index or cached and cached:find('doublestrike',1,true))and myHero:GetBuff(i);local n=b and type(b.name)=='string'and b.name:lower()
    local src=b and b.source;local own=src==nil or src==0 or src==myHero.networkID or src==myHero.handle
     or(type(src)=='table'or type(src)=='userdata')and(src.networkID==myHero.networkID or src.handle==myHero.handle)
    local c=b and(b.count or 1)
    if n and n~='doublestrikeready'and n:find('doublestrike',1,true)and not n:find('stack',1,true)and own
     and finite(c)and c>0 and c%1==0 and(buffExpiry(b)or now+1)>now+(horizon or 0)then ready=b;last=buffExpiry(b);break end
   end
  end
 end
 local observed=self.doubleStrikeObservation;local dsAt=observed and observed.start or -math.huge
 if stacks then track.count=stacks.count;track.at=now;track.inferredReady=nil end
 local valid=stacks and finite(stacks.count)and stacks.count>=1 and stacks.count<self.profile.dsCount and stacks.count%1==0
 if valid and stacks.count>=self.profile.dsCount-1 then ready=ready or stacks end
 if not stacks and not ready and track.count==self.profile.dsCount-2 and track.at and now-track.at<=.5 then
  local attack=self.lastCompletedAttack
  if attack and(attack.finish or attack.start or 0)>=track.at-.05 and dsAt<track.at then track.inferredReady=track.at end
  track.count=nil
 end
 if track.inferredReady and(dsAt>=track.inferredReady or now-track.inferredReady>(self.profile.dsDuration or 4))then track.inferredReady=nil end
 if not ready and track.inferredReady then ready=true;last=track.inferredReady+(self.profile.dsDuration or 4)end
 if Core.logger and(self.dsTraceAt or 0)+5<now then self.dsTraceAt=now
  local names={};local count=myHero.buffCount or 0
  for i=0,math.min(count,128)do local b=myHero:GetBuff(i);local n=b and type(b.name)=='string'and b.name
   if n and n:lower():find('doublestrike',1,true)then names[#names+1]=n..':'..tostring(b.count)end end
  Core:Trace('masteryi_double_strike_buffs',{names=table.concat(names,','),inferred=track.inferredReady~=nil})
 end
 return {kind='native',ready=ready~=nil and ready~=false,stacks=valid and stacks.count or(not stacks and 0 or nil),expires=last,observed=observed}
end
function MasterYiChampion:PreparePreview()
 -- Drawing preview: kept for a second so a late preparation never blinks the circle.
 self.preview={expires=Game.Timer()+1,q=self:Ready(_Q)}
end

-- Development measurement only (Core.logger exists only in development family
-- builds; public builds never call this). One bounded record per Alpha Strike,
-- any owner: owned send (when ours), native cast start/end, the per-tick
-- isTargetable flip brackets (last true / first false / first true again), the
-- Alpha Strike buff witness and net health loss before/while untargetable.
-- Brackets are tick-sampled host reads, not server timestamps; health loss is
-- net of regeneration/heals and not attributed to a source.
local qTimingTimeout=3
function MasterYiChampion:EmitQTiming(t,outcome)
    self.qTiming=nil
    local send=t.send
    local function rel(v)return send and send.game and v and v-send.game or nil end
    Core:Trace('yi_q_timing',{profile=self.profile.id,outcome=outcome,owner=send and send.owner or 'unowned',action=send and send.id,
        sentAtMs=send and send.ms,sendGameTime=send and send.game,observationClock=send and send.clock,
        observationBoundary=send and send.boundary,
        castStart=t.castStart,castEnd=t.castEnd,firstSeen=t.firstSeen,lastTargetable=t.lastTargetable,untargetable=t.untargetable,
        lastUntargetable=t.lastUntargetable,targetableAgain=t.targetableAgain,buff=t.buff,buffStart=t.buffStart,buffEnd=t.buffEnd,
        buffSeen=t.buffSeen,buffGone=t.buffGone,healthLossBefore=t.lossBefore,healthLossDuring=t.lossDuring,
        ticks=t.ticks,maxTickGap=t.maxGap,sendToCastStart=rel(t.castStart),sendToLastTargetable=rel(t.lastTargetable),
        sendToUntargetable=rel(t.untargetable)})
end
function MasterYiChampion:TraceQTiming()
    local now=Game.Timer()
    local q=Core.pending and Core.pending[HK_Q]
    if q and q.sentAt and q.id and (not self.qSend or self.qSend.id~=q.id) then
        self.qSend={id=q.id,owner=q.owner,ms=q.sentAt,request=q.requestGameTime,
            game=q.sentGameTime,boundary=q.observationGameTime,clock=q.observationClock}
    end
    local cast=myHero.activeSpell;local t=self.qTiming
    if cast and cast.valid and cast.name==self.profile.q and type(cast.startTime)=='number'and (not t or t.castStart~=cast.startTime)then
        if t then self:EmitQTiming(t,'superseded')end
        local send=self.qSend
        if send and not(finite(send.boundary)and send.boundary<=cast.startTime and send.boundary>=cast.startTime-1)then send=nil end
        self.qSend=nil
        t={castStart=cast.startTime,castEnd=cast.castEndTime,firstSeen=now,send=send,health=myHero.health,
            lossBefore=0,lossDuring=0,ticks=0,maxGap=0,last=now}
        self.qTiming=t
    end
    if not t then return end
    t.ticks=t.ticks+1;t.maxGap=math.max(t.maxGap,now-t.last);t.last=now
    local health=myHero.health or t.health;local loss=math.max(0,(t.health or health)-health);t.health=health
    if myHero.isTargetable==false then
        if not t.untargetable then t.untargetable=now end
        if not t.targetableAgain then t.lastUntargetable=now;t.lossDuring=t.lossDuring+loss end
    elseif not t.untargetable then t.lastTargetable=now;t.lossBefore=t.lossBefore+loss
    elseif not t.targetableAgain then t.targetableAgain=now end
    if not t.buffGone then
        local found
        for _,buff in ipairs(GetBuffs(myHero))do
            if type(buff.name)=='string'and buff.name:lower():find('alphastrike',1,true)then found=buff;break end
        end
        if found then
            if not t.buffSeen then t.buffSeen=now;t.buff=found.name;t.buffStart=found.startTime
                local expiry=tonumber(found.expireTime)or 0;if expiry<=0 then expiry=tonumber(found.endTime)or 0 end;t.buffEnd=expiry end
        elseif t.buffSeen then t.buffGone=now end
    end
    if t.targetableAgain and (t.buffGone or not t.buffSeen) then self:EmitQTiming(t,'complete')
    elseif now>t.castStart+qTimingTimeout then self:EmitQTiming(t,'timeout')end
end

-- Development trace (Classic): a champion kill during Highlander refreshes every
-- cooldown. One row when Q comes off a running cooldown while R's buff is up, so the
-- refresh chain (KillSteal/Combo Q onto the next champion) can be read from play.
function MasterYiChampion:TraceKillRefresh()
    if self.profile.id~='classic'then return end
    local d=myHero:GetSpellData(_Q);local cd=d and d.currentCd
    local prev=self.lastQCooldown;self.lastQCooldown=cd
    if finite(prev)and prev>1 and cd==0 and self:LiveBuff(self.profile.r)then
        Core:Trace('yi_kill_refresh',{profile=self.profile.id,previousCooldown=prev,time=Game.Timer(),
            enemiesInQRange=GetEnemyCount(self.QSpell.Range,myHero.pos)})
    end
end

function MasterYiChampion:HandleMeditate()
	local meditating = self:IsMeditating()
	if meditating and not self.wasMeditating then
		self.meditateStart = Game.Timer()
	end
	self.wasMeditating = meditating

	local locked = meditating and Game.Timer() < self.meditateStart + Menu.Misc.WChannel:Value()
	local reset=self.resetSequence
	local owned=reset and reset.channel and self:NativeSpell(self.profile.w,true)
		and myHero.activeSpell.startTime==reset.channel.startTime and myHero.activeSpell.castEndTime==reset.channel.castEndTime
	_G.SDK.Orbwalker:SetAttack(not locked or owned==true)
	_G.SDK.Orbwalker:SetMovement(not locked)
	if not meditating then
		self.meditateStart = 0
	end
	return locked
end

function MasterYiChampion:Tick()
	if not Core:InputAvailable()then return end
	self:ObserveQ()
	-- Follow the Double Strike stacks every tick so a vanishing 2-stack buff is seen.
	if self.profile.id=='normal'then self:DoubleStrikeState()end
	if Core.logger then self:TraceQTiming();self:TraceKillRefresh() end
	local resetting=self:ContinueWReset()
	if self:HandleMeditate() then return end
	if resetting then return end
	if ShouldWait() then return end
	if self.preparationFallback and Menu.Draw.Q:Value()then self:PreparePreview()end
	if self.qActive then self:AlphaWeave();return end
	if IsCasting() then return end
	if self:AutoW() then return end

	self:KillSteal()
	local mode = GetMode()
	if mode == "Combo" then
		self:Combo()
	elseif mode == "Harass" then
		self:Harass()
	elseif mode == "LaneClear" then
		if Core:FarmModeEnabled('lane') then self:LaneClear() end
		if Core:FarmModeEnabled('jungle') then self:JungleClear() end
	elseif mode == "Flee" then
		self:Flee()
	elseif mode == "LastHit" then
		self:LastHit()
	end
end

function MasterYiChampion:OnPreAttack(args)
	if not args or args.Process == false then return end
	local target = args.Target
	if not IsValid(target) or not self:Ready(_E) or not _G.SDK.Data:IsInAutoAttackRange(myHero,target) then return end
	local mode = GetMode()
	if mode == "Combo" and Menu.Combo.E:Value() and target.type == Obj_AI_Hero then
		self:PrepareE(target)
	elseif mode == "Harass" and target.type == Obj_AI_Hero and self:HarassE() then
		self:PrepareE(target,nil,function()return self:HarassE()end)
	elseif mode == "LaneClear" and Menu.Clear.SpellFarm:Value() and target.type == Obj_AI_Minion then
		if target.team == 300 and Core:FarmModeEnabled('jungle') and Menu.Clear.JungleClear.E:Value() and manaAbove(Menu.Clear.JungleClear.Mana:Value()) then
			self:PrepareE(target,Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end))
		elseif target.team ~= 300 and Core:FarmModeEnabled('lane') and Menu.Clear.LaneClear.E:Value() then
			self:PrepareE(target,Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end))
		end
	end
end

-- Harass E (Normal only): true damage on the attacks of a trade, under the Harass mana gate.
-- Classic E gives up its passive AD for the cooldown, so it has no Harass entry.
function MasterYiChampion:HarassE()
    local option=Menu.Harass.E
    return self.profile.id=='normal'and option~=nil and option:Value()and manaAbove(Menu.Harass.Mana:Value())
end

function MasterYiChampion:PrepareE(target,context,permission)
    if not self:Ready(_E)or self:EBuff()or not self:CurrentTarget(target)then return false end
    return Core:Cast(HK_E,nil,{intentTarget=target,context=context,validate=function()
        return IsValid(target) and self:CurrentTarget(target)and not self:EBuff()and _G.SDK.Data:IsInAutoAttackRange(myHero,target)
            and(not permission or permission())
    end,observe=function(q)return Core:NativeCast(q,self.profile.e)~=nil end})
end

function MasterYiChampion:CompletedAttack(target)
    if not IsValid(target) then return nil end
    local cast=myHero.activeSpell
    local now=Game.Timer()
    if not cast or type(cast.startTime)~='number'
        or type(cast.castEndTime)~='number' or cast.startTime>cast.castEndTime
        or cast.startTime~=cast.startTime or cast.castEndTime~=cast.castEndTime
        or cast.castEndTime>now or cast.castEndTime<now-.35 then return nil end
    local witness=ObserveAttack(_G,nil,function(id)
        if target.networkID==id or target.handle==id then return target end
    end)
    if not witness then return nil end
    return {target=target,targetID=identity(target),start=cast.startTime,finish=cast.castEndTime,name=cast.name}
end

function MasterYiChampion:AttackRecipient(args)
    local cast=myHero.activeSpell
    if not cast or not cast.valid or cast.isStopped then return nil end
    local native=cast.target
    local id
    if type(native)=='table'or type(native)=='userdata'then id=identity(native) else id=native end
    if not id or id==0 then return nil end
    local function matches(unit)
        return(type(unit)=='table'or type(unit)=='userdata')and IsValid(unit)and(unit.networkID==id or unit.handle==id)
    end
    local hint=args and args.Target
    if matches(hint)then return hint end
    hint=_G.SDK.Orbwalker.LastTarget
    if matches(hint)then return hint end
    if matches(native)then return native end
    local lookup=Game.GetObjectByNetID
    if type(lookup)=='function'then local ok,unit=pcall(lookup,id);if ok and matches(unit)then return unit end end
    -- Rare argument-less callbacks may arrive after the selected target changed.
    -- Resolve the native recipient in a bounded current roster, never that selection.
    local om=_G.SDK.ObjectManager
    local lists={om:GetEnemyHeroes(self.QSpell.Range),om:GetMonsters(self.QSpell.Range),om:GetEnemyMinions(self.QSpell.Range)}
    for _,list in ipairs(lists)do for i=1,math.min(#list,40)do if matches(list[i])then return list[i]end end end
end

function MasterYiChampion:ActiveEDamage(horizon)
    if self.profile.id~='normal' then return 0 end
    local level=myHero:GetSpellData(_E).level
    if not level or level<1 or level>5 or level%1~=0 then return 0 end
    -- No cast timer guesses: a live self buff must witness the current activation.
    local buff=self:EBuff(horizon)
    if buff then
            local bonus=tonumber(myHero.bonusDamage)
            if not finite(bonus)or bonus<0 then return 0 end
            return self.profile.eBase[level]+self.profile.eBonusAD*bonus
    end
    return 0
end

function MasterYiChampion:AttackForecast(target,horizon)
    if not IsValid(target) then return {physical=0,trueDamage=0,total=0,passive='unknown'}end
    -- Native total AD already includes any observed Classic E stat change.
    -- Do not add PassiveAD again or copy Normal true damage into Classic.
    local physical=_G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)
    local trueDamage=self:ActiveEDamage(horizon)
    local passive=self:DoubleStrikeState(horizon)
    local extra=passive.ready and _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage*self.profile.dsRatio)or 0
    return {physical=physical,trueDamage=trueDamage,total=physical+trueDamage+extra,passive=passive.ready and 'native_ready_estimate'or 'unknown',passivePhysical=extra}
end

function MasterYiChampion:TwoAttackForecast(target,horizon)
 local first=self:AttackForecast(target,horizon)
 -- A currently ready Double Strike is consumed once, not once per projected AA.
 return first.total*2-(first.passivePhysical or 0)
end

function MasterYiChampion:OnPostAttack(args)
    local victim=self:AttackRecipient(args)
	local attack=self:CompletedAttack(victim)
	if not attack then return end
	local previous=self.lastCompletedAttack
	if previous and previous.targetID==attack.targetID and previous.start==attack.start and previous.finish==attack.finish then return end
	self.lastCompletedAttack=attack
 local dsName=self.profile.id=='normal'and'MasterYiDoubleStrike'or'Jade_MasterYiDoubleStrike'
 if attack.name==dsName then self.doubleStrikeObservation={targetID=attack.targetID,handle=victim.handle,start=attack.start,finish=attack.finish,name=attack.name}end
	if self:BeginWReset(attack)then return end
	if not self:Ready(_Q) or self.lastQ + 250 >= GetTickCount() then return end
	local target = victim
	if not IsValid(target) or myHero.pos:DistanceTo(target.pos) > self.QSpell.Range then return end
	local mode = GetMode()
	if mode == "Combo" and Menu.Combo.Q:Value() and target.type == Obj_AI_Hero then
		if self:CanUseQ(target, self:ComboSafety()) then
			self:CastQ(target)
		end
	elseif mode == "Harass" and Menu.Harass.Q:Value()and manaAbove(Menu.Harass.Mana:Value())and target.type == Obj_AI_Hero then
		if self:CanUseQ(target, true) then
			self:CastQ(target)
		end
	end
end

function MasterYiChampion:ResetPermission(target)
 if GetMode()=='Combo'and target.type==Obj_AI_Hero then
  return Menu.Combo.WReset,Core:ModeContext('Combo',function()return Menu.Combo.WReset:Value()end)
 end
 if target.team==300 and Menu.Clear.SpellFarm:Value()and Core:FarmModeEnabled('jungle')then
  return Menu.Clear.JungleClear.WReset,Core:FarmContext('jungle',function()
   return Menu.Clear.SpellFarm:Value()and Menu.Clear.JungleClear.WReset:Value()and manaAbove(Menu.Clear.JungleClear.Mana:Value())
  end)
 end
end

-- The reset spends Meditate, which is also the defence. It is only taken when
-- health is comfortably (20 points) above every threshold at which W would be
-- wanted for itself, and when the target needs more than the attack that has
-- just gone out: a target that attack already kills gains nothing from a second.
local W_RESET_HEALTH_MARGIN=20
function MasterYiChampion:WSpare(target)
 if not self.profile.wReset or not(myHero.maxHealth>0)then return false end
 local keep=Menu.Misc.AutoW:Value()and Menu.Misc.WHP:Value()or 0
 if target.team==300 and Menu.Clear.JungleClear.W:Value()then keep=math.max(keep,Menu.Clear.JungleClear.WHP:Value())end
 if myHero.health/myHero.maxHealth*100<=keep+W_RESET_HEALTH_MARGIN then return false end
 local attack=self:AttackForecast(target)
 return finite(attack.total)and target.health+(target.shieldAD or 0)>attack.total
end

function MasterYiChampion:BeginWReset(attack)
 if self.resetSequence or self.retiredResets and #self.retiredResets>=4 or not attack or not Core:InputAvailable()then return false end
 local client=Core.adapter;local capability=client:Capabilities().ownedChannelCancel
 if not capability or not capability.attack then return false end
 local target=attack.target;local option,context=self:ResetPermission(target)
 local function allowed()
  local current=self:CompletedAttack(target)
  return Core:InputAvailable()and option and option:Value()and client:ContextValid({context=context})
   and current and current.start==attack.start and current.targetID==attack.targetID
   and IsValid(target)and _G.SDK.Data:IsInAutoAttackRange(myHero,target)
   and not self:IsMeditating()and not self:WUseful()and not self:JungleWUseful()and self:WSpare(target)
   and self:Ready(_W)and myHero:GetSpellData(_W).name==self.profile.w
   and not _G.SDK.Attack:IsReady()
 end
 if not allowed()then return false end
 local row={target=target,targetID=attack.targetID,handle=target.handle,first=attack,context=context,option=option,
  deadline=client:Now()+1000,previous=myHero.activeSpell and myHero.activeSpell.startTime}
 local id=client:Cast(HK_W,nil,{owner='yi_meditate_reset',resource='slot:'.._W,context=context,
  channelName=self.profile.w,expires=client:Now()+math.max(1,math.floor((.35-(Game.Timer()-attack.finish))*1000)),mechanical=allowed,
  reconcile=function()
   local spell=myHero:GetSpellData(_W)
   return Core:InputAvailable()and spell and spell.name==self.profile.w and finite(spell.currentCd)
    and spell.currentCd>=0 and not self:IsMeditating()
  end})
 if not id then return false end
 row.castID=id;self.resetSequence=row;return true
end

function MasterYiChampion:ContinueWReset()
 reconcileResets(self)
 local row=self.resetSequence;if not row then return false end
 local client=Core.adapter;local target=row.target
 if not Core:InputAvailable()or not row.option:Value()or not client:ContextValid({context=row.context},'continuation')
  or not IsValid(target)or target.handle~=row.handle or target.networkID~=row.targetID or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)
  or client:Now()>row.deadline then closeReset(self,'reset_context_ended');return false end
 local source=client:Poll(row.castID)
 if not source or source.jobCancelled or source.state=='cancelled_before_send'or source.state=='send_uncertain'
  or source.interrupted then closeReset(self,'reset_cast_unresolved');return false end
 if not source.sentAt then row.waitReason='send';return true end
 if not row.attackID then
  local cast=myHero.activeSpell
  if not self:NativeSpell(self.profile.w,true)or not finite(cast.startTime)or not finite(cast.castEndTime)then row.waitReason='native_channel';return true end
  if not row.grant then
   local grant=client:GrantChannelCancel(row.castID,{name=cast.name,startTime=cast.startTime})
   if not grant then closeReset(self,'channel_ownership_refused');return false end
   row.grant=grant;row.grantExpires=client:Now()+450
   row.channel={name=cast.name,startTime=cast.startTime,castEndTime=cast.castEndTime}
  end
  if client:Now()>row.grantExpires or cast.startTime~=row.channel.startTime or cast.castEndTime~=row.channel.castEndTime then
   closeReset(self,'owned_channel_changed');return false
  end
  -- Readiness comes from the productive provider's observed reset; this consumer
  -- never writes Attack.Reset, LocalStart or the host's active channel fields.
  if not _G.SDK.Attack:IsReady()then row.waitReason='attack_readiness';return true end
  _G.SDK.Orbwalker:SetAttack(true)
  row.attackGame=Game.Timer()
  local id=client:Attack(target,{owner='yi_meditate_reset',resource='attack',cancelChannel=row.grant,context=row.context,
   expires=math.min(row.deadline,client:Now()+250),mechanical=function()
    return Core:InputAvailable()and row.option:Value()and IsValid(target)and target.handle==row.handle and target.networkID==row.targetID
     and _G.SDK.Data:IsInAutoAttackRange(myHero,target)
   end,reconcile=function()return Core:InputAvailable()and not _G.SDK.Attack:IsActive()and not self:IsMeditating()end})
  if not id then closeReset(self,'cancel_attack_refused');return false end
  row.attackID=id
 end
 local result=client:Poll(row.attackID)
 if not result or result.jobCancelled or result.state=='cancelled_before_send'or result.state=='send_uncertain'
  or result.interrupted or result.competitor then closeReset(self,'reset_attack_unresolved');return false end
 local cast=myHero.activeSpell
 local sentGame=result.sentGameTime
 if result.sentAt and cast and cast.valid and not cast.isStopped and Core:IsAttackCast(cast)
  and finite(cast.startTime)and finite(sentGame)and cast.startTime>=math.max(row.attackGame,sentGame)and cast.startTime~=row.first.start
  and(cast.target==row.targetID or cast.target==row.handle)then
  if not row.attackStart then
   local accepted=client:Observe(row.attackID,{kind='mechanical',source='native_attack_start',unique=true,at=client:Now()})
   if not accepted then closeReset(self,'attack_observation_refused');return false end
   row.attackStart=cast.startTime
  end
  if cast.startTime==row.attackStart and finite(cast.castEndTime)and cast.castEndTime<=Game.Timer()then
   self.lastResetOutcome={first=row.first.start,second=row.attackStart,finished=cast.castEndTime,targetID=row.targetID}
   closeReset(self,'native_attack_completed');return false
  end
 end
 return true
end

function MasterYiChampion:CanUseQ(target, safeMode)
	if not self:Ready(_Q)then return false end
	if myHero:GetSpellData(_Q).name~=self.profile.q then return false end
	if not IsValid(target) or myHero.pos:DistanceTo(target.pos) > self.QSpell.Range then return false end
	if not self:CurrentTarget(target)then return false end
	if not self:LandingEnvelope(target,safeMode)then return false end
	return true
end
function MasterYiChampion:ComboSafety()
 return Menu.Combo.QSafe:Value()and'dive'or false
end
-- Enemy turrets whose range covers `pos` (same reach as IsUnderTurret2), at most 16.
function MasterYiChampion:TurretsAt(pos)
 local out={};local list=_G.SDK.ObjectManager:GetEnemyTurrets()
 for i=1,math.min(#list,16)do local t=list[i]
  if t and not t.dead and t.pos and t.pos:DistanceTo(pos)<(t.boundingRadius or 0)+750 then out[#out+1]=t end
 end
 return out
end
-- Turret rule for a Q landing point. safe=false: no rule. safe=true: never inside enemy
-- turret range. safe='dive' (Combo/finisher with the turret option on): a landing inside
-- a turret's range is allowed only when Yi already stands in that same turret's range (the
-- dive is already happening), and not when that turret is shooting Yi unless Q kills.
function MasterYiChampion:TurretOK(pos,safe,target)
 if not safe then return true end
 local turrets=self:TurretsAt(pos);if #turrets==0 then return true end
 if safe~='dive'then return false end
 for _,t in ipairs(turrets)do
  if t.pos:DistanceTo(myHero.pos)>=(t.boundingRadius or 0)+750 then return false end
  if t.targetID~=nil and t.targetID==myHero.networkID and not(target and self:QKills(target))then return false end
 end
 return true
end
function MasterYiChampion:CurrentTarget(target)
 if not IsValid(target)then return false end
 local hero=target.type==Obj_AI_Hero;local count=Game[hero and'HeroCount'or'MinionCount']();local limit=hero and 16 or 512
 if not finite(count)or count<0 or count>limit or count%1~=0 then return false end
 for i=1,count do local u=Game[hero and'Hero'or'Minion'](i)
  if u and u.networkID==target.networkID and u.handle==target.handle and IsValid(u)then return u.pos and target.pos and GetDistance(u.pos,target.pos)==0 and u.health==target.health end
 end;return false
end
function MasterYiChampion:LandingEnvelope(target,safe)
 if type(Game.isWall)~='function'or Game.isWall(target.pos)~=false then return false end
 if self.profile.id=='normal'then
  for i=0,7 do local angle=i*math.pi/4;local p=Vector(target.pos.x+75*math.cos(angle),target.pos.y,target.pos.z+75*math.sin(angle))
   if Game.isWall(p)~=false or not self:TurretOK(p,safe,target)then return false end
  end
 end
 return self:TurretOK(target.pos,safe,target)
end

function MasterYiChampion:PublishMobility()
    local u=untargetableProfiles[self.profile.id];if not u or not Core.RegisterMobility then return end
    self.untargetable=u
    Core:RegisterMobility({kind='untargetable',slot=_Q,key=HK_Q,name=u.name,range=u.range,landingRange=u.range+u.bounce,
        duration=u.duration,castDelays=u.castDelays,profile=self.profile.id,label='Use Alpha Strike to dodge (Master Yi Q)',
        source=u.source,targets=function(request)return self:EvadeTargets(request)end,
        allowed=function(unit,request)return self:EvadeQAllowed(unit,request)end})
end

-- Controller policy for an Evade Alpha Strike: live Q stage and never
-- landing in enemy turret range unless Evade forecasts the current threat as lethal.
-- Threat safety is Evade's evaluation; this does not repeat it.
function MasterYiChampion:EvadeQAllowed(unit,request)
    if myHero:GetSpellData(_Q).name~=self.profile.q then return false,'q_stage_unknown'end
    if unit==nil then return true end
    if unit.team==myHero.team then return false,'allied_unit'end
    if not(request and request.lethal)and IsUnderTurret2(unit.pos)then return false,'enemy_turret'end
    if not self:CurrentTarget(unit)or not self:LandingEnvelope(unit,not(request and request.lethal))then return false,'landing_unknown_or_unsafe'end
    return true
end

local function evadeUnitKind(unit)
    return unit.type==Obj_AI_Hero and 'champion' or unit.team==300 and 'monster' or 'minion'
end

-- Bounded candidate enumeration and mode ordering for an Evade Alpha Strike.
-- Combo: current combo target, other champions by distance to it, then other
-- units by distance to it. Flee: most progress toward the flee cursor.
-- Otherwise: closest unit. Landings: the struck unit and up to three nearest
-- other units Q may bounce to; Evade requires every landing to be safe.
function MasterYiChampion:EvadeTargets(request)
    local u=self.untargetable;if not u then return {}end
    request=request or {}
    local origin=myHero.pos;local pool,seen={}, {}
    local function add(list,limit)
        for i=1,math.min(#list,limit)do local unit=list[i];local id=identity(unit)
            if id and not seen[id] and IsValid(unit) and unit.team~=myHero.team and GetDistance(unit.pos,origin)<=u.range
                and self:EvadeQAllowed(unit,request) then seen[id]=true;pool[#pool+1]=unit end
        end
    end
    local om=_G.SDK.ObjectManager
    add(om:GetEnemyHeroes(u.range),5);add(om:GetMonsters(u.range),8);add(om:GetEnemyMinions(u.range),12)
    if #pool==0 then return {}end
    local mode=GetMode();local score={}
    if mode=='Combo' then
        local target=GetTarget(self.RSearchRange)
        local anchor=IsValid(target) and target.pos or nil
        for _,unit in ipairs(pool)do
            local d=anchor and GetDistance(unit.pos,anchor) or GetDistance(unit.pos,origin)
            score[unit]=(unit==target and -2e6 or unit.type==Obj_AI_Hero and -1e6 or 0)+d
        end
    elseif mode=='Flee' then
        local aim=request.intent or (_G.SDK.Actions and _G.SDK.Actions.GetPlayerPosition and _G.SDK.Actions:GetPlayerPosition()) or mousePos
        local dx,dz=aim and aim.x-origin.x or 0,aim and aim.z-origin.z or 0;local n=math.sqrt(dx*dx+dz*dz)
        for _,unit in ipairs(pool)do
            local progress=n>1 and ((unit.pos.x-origin.x)*dx+(unit.pos.z-origin.z)*dz)/n or -GetDistance(unit.pos,origin)
            score[unit]=-progress
        end
    else
        for _,unit in ipairs(pool)do score[unit]=GetDistance(unit.pos,origin)end
    end
    table.sort(pool,function(a,b)return score[a]<score[b]end)
    local out={}
    for i=1,math.min(#pool,8)do local unit=pool[i]
        local landings={{x=unit.pos.x,y=unit.pos.y,z=unit.pos.z}};local near={}
        for _,other in ipairs(pool)do if other~=unit and GetDistance(other.pos,unit.pos)<=u.bounce then near[#near+1]=other end end
        table.sort(near,function(a,b)return GetDistance(a.pos,unit.pos)<GetDistance(b.pos,unit.pos)end)
        for j=1,math.min(#near,3)do landings[#landings+1]={x=near[j].pos.x,y=near[j].pos.y,z=near[j].pos.z}end
        out[#out+1]={unit=unit,id=identity(unit),kind=evadeUnitKind(unit),
            position={x=unit.pos.x,y=unit.pos.y,z=unit.pos.z},landings=landings}
    end
    return out
end

-- Defensive W: low health and a threat, an enemy champion within 900 or current
-- evidence of something about to hit Yi (attack or targeted cast at him, turret
-- focus, a tracked spell he stands in: C:AllyThreat).
function MasterYiChampion:WUseful()
    return Menu.Misc.AutoW:Value() and myHero.maxHealth>0
        and myHero.health/myHero.maxHealth*100<=Menu.Misc.WHP:Value()
        and(GetEnemyCount(W_THREAT_RANGE,myHero.pos)>0 or Core.AllyThreat~=nil and Core:AllyThreat(myHero,1)~=nil)
end

function MasterYiChampion:RUseful(target)
    if not IsValid(target)or not self:CurrentTarget(target)or GetDistance(target.pos,myHero.pos)>self.RSearchRange then return false end
    local attack=_G.SDK.Attack
    local period=attack and attack.GetAnimation and attack:GetAnimation()
    local windup=attack and attack.GetWindup and attack:GetWindup()
    local nextAttack=myHero.attackData and myHero.attackData.endTime
    local horizon=type(period)=='number' and period>0 and type(windup)=='number' and windup>=0
        and type(nextAttack)=='number' and math.max(0,nextAttack-Game.Timer())+period+windup or math.huge
    local aa=self:AttackForecast(target,horizon)
    local shield=(target.shieldAD or 0)+(aa.trueDamage>0 and (target.shieldAP or 0)or 0)
    return not _G.SDK.Data:IsInAutoAttackRange(myHero,target) or target.health+shield>aa.total*2-(aa.passivePhysical or 0)
end

-- A live slow on Yi (buff type 10, finite count and expiry). R removes slows and grants
-- slow immunity in both profiles (wiki pages read 2026-10-10). Cripple (attack-speed slow)
-- has no verified buff type here and is not counted.
function MasterYiChampion:Slowed()
    local count=myHero.buffCount
    if not finite(count)or count<0 or count>128 or count%1~=0 then return false end
    local now=Game.Timer()
    for i=0,count do local b=myHero:GetBuff(i)
        if b and b.type==10 and finite(b.count)and b.count>0 then
            local last=buffExpiry(b);if finite(last)and last>now then return true end
        end
    end
    return false
end
-- The target is walking away from Yi (its path ends farther than it stands now).
function MasterYiChampion:MovingAway(target)
    local path=target.pathing
    if not path or not path.hasMovePath or not path.endPos then return false end
    return GetDistance(path.endPos,myHero.pos)>GetDistance(target.pos,myHero.pos)+25
end
-- Combo R: the resource rule (RUseful), or a slowed Yi whose target is out of reach or
-- walking away (R's cleanse is what lets him catch up).
function MasterYiChampion:RWanted(target)
    if self:RUseful(target)then return true end
    return IsValid(target)and GetDistance(target.pos,myHero.pos)<=self.RSearchRange and self:Slowed()and self:MovingAway(target)
end

function MasterYiChampion:FarmCount(anchor,list)
    -- A refreshed density gate, not a guarantee of Alpha Strike bounce ordering.
    -- Radius: the profile bounce search (asset 550; the wiki's 600 is recorded, not used).
    local count,seen=0,{};local bounce=self.profile.qBounce or 550
    list=list or _G.SDK.ObjectManager:GetEnemyMinions(self.QSpell.Range+bounce)
    for i=1,math.min(#list,40) do
        local unit=list[i];local id=identity(unit)
        if id and not seen[id] and IsValid(unit) and unit.team~=300 and unit.team~=myHero.team
            and GetDistance(unit.pos,anchor.pos)<=bounce then seen[id]=true;count=count+1 end
    end
    return math.min(count,4)
end

-- Melee stick (Combo, option off by default): while the cursor is within 550 of a target
-- in attack range, walk to the point at attack reach minus 60 from the target, on the
-- cursor's side of it, instead of onto the cursor. A short shared movement lease
-- (C:PreferMove, .25 s) renewed each tick; released the moment a condition fails.
local STICK_MARGIN=60
function MasterYiChampion:StickSpot(target)
	if not Menu.Combo.Stick:Value()or not IsValid(target)or target.type~=Obj_AI_Hero or not _G.SDK.Data:IsInAutoAttackRange(myHero,target)then return nil end
	local cursor=mousePos;if not cursor or GetDistance(cursor,target.pos)>550 then return nil end
	local reach=_G.SDK.Data:GetAutoAttackRange(myHero,target)
	if not finite(reach)or reach<=STICK_MARGIN+1 then return nil end
	local dx,dz=cursor.x-target.pos.x,cursor.z-target.pos.z;local n=math.sqrt(dx*dx+dz*dz)
	if n<1 then return nil end
	local d=reach-STICK_MARGIN
	local spot=Vector(target.pos.x+dx/n*d,target.pos.y or 0,target.pos.z+dz/n*d)
	if type(Game.isWall)~='function'or Game.isWall(spot)~=false then return nil end
	return spot
end
function MasterYiChampion:MeleeStick(target)
	local spot=not self.qActive and not self:IsMeditating()and self:StickSpot(target)
	if spot and Core.PreferMove and Core:PreferMove('yi_stick',spot,.25)then
		self.stickSpot={pos=spot,expires=Game.Timer()+.25};return true
	end
	self.stickSpot=nil
	if Core.ReleaseMovePreference then Core:ReleaseMovePreference('yi_stick')end
	return false
end

function MasterYiChampion:Combo()
	local target = GetTarget(self.RSearchRange)
	self:MeleeStick(target)
	if not IsValid(target) then return end
	local inAARange = _G.SDK.Data:IsInAutoAttackRange(myHero, target)

	if Menu.Combo.R:Value() and self:Ready(_R) and not self:LiveBuff(self.profile.r) then
		if self:RWanted(target) then
			Core:Cast(HK_R,nil,{intentTarget=target,validate=function()return self:RWanted(target)end})
			return
		end
	end

	if Menu.Combo.Q:Value() and self:Ready(_Q) and self.lastQ + 250 < GetTickCount() then
		if self:CanUseQ(target, self:ComboSafety()) then
			if not inAARange then
				self:CastQ(target)
			elseif self:QKills(target) then
				self:CastQ(target,{validate=function()return self:QKills(target)end})
			end
		end
	end
end

function MasterYiChampion:Harass()
	if not Menu.Harass.Q:Value()or not manaAbove(Menu.Harass.Mana:Value())or not self:Ready(_Q) or self.lastQ + 250 >= GetTickCount() then return end
	local target = GetTarget(self.QSpell.Range)
	if IsValid(target) and not _G.SDK.Data:IsInAutoAttackRange(myHero, target) and self:CanUseQ(target, true) then
		self:CastQ(target)
	end
end

-- Lane Q keeps the mana for Meditate (learned W coming off cooldown within 30 s).
function MasterYiChampion:LaneMana()
	return Core:Affordable(_Q,{_W},30)==true
end

function MasterYiChampion:LaneClear()
	if not Core:FarmModeEnabled('lane') then return end
	if not Menu.Clear.SpellFarm:Value() or not Menu.Clear.LaneClear.Q:Value() or not self:Ready(_Q) then return end
	if IsUnderTurret(myHero) or not self:LaneMana() then return end
	local minions = _G.SDK.ObjectManager:GetEnemyMinions(self.QSpell.Range+(self.profile.qBounce or 550))
	local best
	for i=1,math.min(#minions,40) do local minion=minions[i]
		if IsValid(minion) and minion.team~=300 and minion.team~=myHero.team and minion.pos2D.onScreen
			and GetDistance(minion.pos,myHero.pos)<=self.QSpell.Range
			and (not best or minion.maxHealth>best.maxHealth)
			and self:FarmCount(minion,minions)>=Menu.Clear.LaneClear.QCount:Value() then best=minion end
	end
	if best then
		self:CastQ(best)
	end
end

-- Live monsters Alpha Strike can reach from the struck monster (bounce search
-- 550, asset field 8f6f40e6). A density gate, not a bounce-order guarantee.
function MasterYiChampion:MonsterCount(anchor,list)
    local count=0
    list=list or _G.SDK.ObjectManager:GetMonsters(self.QSpell.Range+550)
    for i=1,math.min(#list,12)do local unit=list[i]
        if IsValid(unit) and unit.team==300 and GetDistance(unit.pos,anchor.pos)<=550 then count=count+1 end
    end
    return math.min(count,4)
end

-- Q on a camp when it reaches enough monsters, or on a single monster that the
-- next two attacks will not finish (no Q wasted on a nearly dead monster).
-- Classic monster proc damage is random (50%) and is never counted here.
function MasterYiChampion:JungleQUseful(monster,list)
    if not IsValid(monster) or monster.team~=300 or GetDistance(monster.pos,myHero.pos)>self.QSpell.Range then return false end
    if not manaAbove(Menu.Clear.JungleClear.Mana:Value()) then return false end
    if self:MonsterCount(monster,list)>=Menu.Clear.JungleClear.QCount:Value() then return true end
    if not Menu.Clear.JungleClear.QLarge:Value() then return false end
    return monster.health>self:TwoAttackForecast(monster)
end

-- Sustain Meditate while clearing: only below the threshold and with no
-- visible enemy champion nearby. Its own minimum hold applies after observation.
function MasterYiChampion:JungleWUseful()
    return Menu.Clear.JungleClear.W:Value() and myHero.maxHealth>0
        and myHero.health/myHero.maxHealth*100<=Menu.Clear.JungleClear.WHP:Value()
        and GetEnemyCount(1500,myHero.pos)==0
        and #_G.SDK.ObjectManager:GetMonsters(700)>0
end

function MasterYiChampion:JungleClear()
	if not Core:FarmModeEnabled('jungle') then return end
	if not Menu.Clear.SpellFarm:Value() then return end
	if self:Ready(_W) and self:JungleWUseful() then
		return Core:Cast(HK_W,nil,{validate=function()return self:JungleWUseful()end})
	end
	if not Menu.Clear.JungleClear.Q:Value() or not self:Ready(_Q) then return end
	local monsters = _G.SDK.ObjectManager:GetMonsters(self.QSpell.Range+550)
	local best,bestCount
	for i=1,math.min(#monsters,12) do local monster=monsters[i]
		if IsValid(monster) and monster.team==300 and monster.pos2D.onScreen and GetDistance(monster.pos,myHero.pos)<=self.QSpell.Range then
			local count=self:MonsterCount(monster,monsters)
			if not best or count>bestCount or count==bestCount and monster.maxHealth>best.maxHealth then best,bestCount=monster,count end
		end
	end
	if best and self:JungleQUseful(best,monsters) then
		return self:CastQ(best,{validate=function()return self:JungleQUseful(best)end})
	end
end

function MasterYiChampion:AutoW()
	if not self:Ready(_W) then return false end
	if self:WUseful() then
		-- HandleMeditate observes the actual channel start.
		return Core:Cast(HK_W,nil,{owner='AutoW',validate=function()return self:WUseful()end})
	end
	return false
end

function MasterYiChampion:Flee()
	local function chased() return Menu.Misc.FleeR:Value() and(GetEnemyCount(1200, myHero.pos) > 0 or self:Slowed()) and not self:LiveBuff(self.profile.r) end
	if self:Ready(_R) and chased() then
		Core:Cast(HK_R,nil,{validate=chased})
	end
	self:FleeQ()
end

-- Alpha Strike as an escape: the unit that takes Yi farthest toward the cursor
-- (the same bounded, turret-refusing candidates Evade is offered), and only
-- when it really gains ground.
function MasterYiChampion:FleeQ()
	if not Menu.Misc.FleeQ:Value() or not self:Ready(_Q) or self.lastQ + 250 >= GetTickCount() then return false end
	local row=self:EvadeTargets({intent=mousePos})[1]
	local unit=row and row.unit;if not unit then return false end
	local function gains()
		return Menu.Misc.FleeQ:Value() and IsValid(unit) and GetDistance(unit.pos,mousePos)+150<GetDistance(myHero.pos,mousePos) and self:CanUseQ(unit,true)
	end
	return gains() and self:CastQ(unit,{validate=gains})
end

-- One primary hit through the shared kill rule (health on arrival, the shield
-- pool of this profile's damage type, spell protection).
function MasterYiChampion:QKills(target)
	return Core:Lethal(target,.25,function()return self:GetQDmg(target)end,{kind=self.profile.qType})
end

function MasterYiChampion:KillSteal()
	if not Menu.KillSteal.Q:Value() or not self:Ready(_Q) or self.lastQ + 250 >= GetTickCount() then return end
	-- The decision's shared enemy list (GetEnemyHeroes, already read this callback by
	-- other checks) within Q range: the same heroes in the same order as
	-- GetEnemyHeroes(range), without another full roster pass every tick.
	local enemies = {}
	for _, hero in ipairs(Core:DecisionUnits('GetEnemyHeroes')) do
		if hero.distance < self.QSpell.Range then enemies[#enemies + 1] = hero end
	end
	for _, target in ipairs(enemies) do
		if IsValid(target) and target.pos2D.onScreen and self:CanUseQ(target, self:ComboSafety()) then
			if self:QKills(target) then
				self:CastQ(target,{validate=function()return Menu.KillSteal.Q:Value() and self:QKills(target)end})
				return
			end
		end
	end
end

function MasterYiChampion:GetQDmg(target)
	local level = myHero:GetSpellData(_Q).level
	if not finite(level)or level%1~=0 or level<1 or level>5 or not IsValid(target)then return 0 end
	local normal=self.profile.id=='normal'
	local damage = self.profile.qBase[level] + (normal and self.profile.qAD*myHero.totalDamage or self.profile.qAP*myHero.ap)
 if normal and target.team==300 and target.type==Obj_AI_Minion then damage=damage+self.profile.qMonster[level]end
	return _G.SDK.Damage:CalculateDamage(myHero, target, normal and _G.SDK.DAMAGE_TYPE_PHYSICAL or _G.SDK.DAMAGE_TYPE_MAGICAL, damage)
end

-- The shared rescue rule: Q only takes a minion a basic attack cannot take in time
-- (cooldown, approach, windup and flight), at the first strike's impact (profile qImpact,
-- asset castFrame). Primary hit only; bounces are never counted.
function MasterYiChampion:LastHitUseful(target)
    if not IsValid(target) or target.team==300 or target.team==myHero.team or not self:CanUseQ(target,true) then return false end
    return Core:Rescue(target,self.profile.qImpact or .26,function()return self:GetQDmg(target)end)==true
end

function MasterYiChampion:LastHit()
    if not Menu.LastHit.Q:Value() or not self:Ready(_Q) then return end
    local list=_G.SDK.ObjectManager:GetEnemyMinions(self.QSpell.Range)
    for i=1,math.min(#list,40) do
        local target=list[i]
        if self:LastHitUseful(target) then
            return self:CastQ(target,{context=Core:RescueContext(),validate=function()return self:LastHitUseful(target)end})
        end
    end
end

function MasterYiChampion:RegisterGuide(guide,settings)
    local nodes={comboQ={node=Menu.Combo.Q,label='Combo Q'},safe={node=Menu.Combo.QSafe,label='Avoid turret Q'},
        comboE={node=Menu.Combo.E,label='E before attacks'},comboR={node=Menu.Combo.R,label='Combat R'},
        reset={node=Menu.Combo.WReset,label='Combo W reset'},jungleReset={node=Menu.Clear.JungleClear.WReset,label='Jungle W reset'},
        harass={node=Menu.Harass.Q,label='Harass Q'},mana={node=Menu.Harass.Mana,label='Harass mana'},
        farm={node=Menu.Clear.SpellFarm,label='Spell farming'},count={node=Menu.Clear.LaneClear.QCount,label='Lane density'},
        last={node=Menu.LastHit.Q,label='Last hit Q'},heal={node=Menu.Misc.AutoW,label='Defensive W'},
        hp={node=Menu.Misc.WHP,label='W health threshold'},
        flee={node=Menu.Misc.FleeR,label='Flee R'},kill={node=Menu.KillSteal.Q,label='Lethal Q'}}
    local cfg,links,activate=settings.new(guide,nodes,function()return Core:Active()end)
    return guide:Register('champion',{'Master Yi: quick start','Master Yi: Alpha Strike','Master Yi: Meditate and resets'},function(page)
        if page==1 then return {title=self.profile.id=='classic' and 'Classic Master Yi' or 'Master Yi',subtitle='Use the provider mode keys.',cards={
            {'COMBAT','Combo: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_COMBO)..'. [[comboQ]], [[comboE]] and [[comboR]] have separate permissions. R can be saved when two nearby attacks suffice; Normal counts E only while its live buff lasts through that estimate. Harass: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_HARASS)..' uses [[harass]] and [[mana]].'},
            {'FARM','Clear: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LANECLEAR)..'. Enable [[farm]] with '..settings.key(Menu.Clear.SpellFarm)..'. Lane and jungle have separate Q and E settings. [[count]] is nearby live minion density, not a guaranteed number of Q hits.'},
            {'ESCAPE','Flee: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_FLEE)..' uses [[flee]] when an enemy is within 1200 or Yi is slowed. Last hit: '..settings.bind(_G.SDK,_G.SDK.ORBWALKER_MODE_LASTHIT)..' uses [[last]] only on a minion no attack can take.'}},note='Releasing a held mode cancels waiting actions. Defensive W and lethal Q ([[kill]]) need no mode key. Evade may always dodge with Q.'}end
        if page==2 then return {title='Alpha Strike decisions',subtitle='When Q is used and where it may land.',cards={
            {'TARGET','[[comboQ]] chases targets outside attack reach or uses a conservative lethal estimate. [[kill]] counts only one primary Q hit. Passive attacks, item procs and repeated Normal Q hits are omitted.'},
            {'LANDING','[[safe]] refreshes the native target and nearby turrets before dispatch. Normal samples known terrain and the 75-unit exit ring; unknown terrain refuses Q. These samples do not guarantee a future moving landing. Choose your own Normal exit direction during Q.'},
            {'PROFILE',self.profile.id=='normal' and 'Normal uses physical primary Q damage and its asset-matched monster bonus. During an owned native Combo Q, E and explicitly authorized R can use the existing self-cast path; no channel-cancel attack or movement is injected. Double Strike readiness is native and its extra physical hit remains an estimate.' or 'Classic uses magic Q damage plus ability power. Its monster proc and Double Strike are random and never guaranteed. Native total AD includes E stat changes once; Normal true damage and during-Q casts are not copied.'}},note='Q send, attributable native start, buff state and exit are separate. E/R during Q requires the same living recipient, held mode and finite own state. Automatic exit clicks remain unavailable.'}end
        return {title='Meditate and attack permission',subtitle='Defensive healing is separate from an attack reset.',cards={
            {'DEFENSE','[[heal]] starts only below [[hp]] with a nearby enemy or something about to hit Yi, and current mana. Evade may also use W against a hit it cannot avoid. Both conditions are checked again before input. A native channel or an unexpired profile buff protects Meditate even when one witness arrives late.'},
            {'CONTROL','Attacks and movement wait at least one second after an ordinary channel is observed. A rejected W request never locks movement. Other spells preserve Meditate. An explicitly enabled owned reset permits only its verified continuation attack.'},
            {'RESET','[[reset]] and [[jungleReset]] are separate and on. The reset is skipped while health is within 20 points of a W threshold, or when the attack already kills. After a completed native attack, the script may request W, observe its own Meditate and use the provider reset to continue on that same target. Manual W is preserved. Mode release, target replacement and uncertain input cancel remaining work.'}},note='W send, channel observation and completed next-attack windup are separate. Live damage, healing and timing acceptance remain open.'}
    end,cfg,links,activate)
end

function MasterYiChampion:Draw()
	local stick=self.stickSpot
	if stick and stick.expires>=Game.Timer()and not myHero.dead then Draw.Circle(stick.pos,40,1,Draw.Color(200,242,120,34))end
	local preview=self.preview;if myHero.dead or not preview or preview.expires<Game.Timer()then return end
	if Menu.Draw.Q:Value() and preview.q then
		Draw.Circle(myHero.pos, self.QSpell.Range, 1, Draw.Color(255, 66, 244, 113))
	end
end


-- Explicit request context. Nested helpers inherit their caller's context.
Core:StandardPolicy(MasterYiChampion,{
    damageTypes={Q=myHero.charName=='Jade_MasterYi' and 'magical' or 'physical'},
    methods={
        AutoW=function()return {priority='interactive'}end,
        OnPreAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode) or nil end,
        OnPostAttack=function()local mode=GetMode();return mode and Core:ModeContext(mode) or nil end,
    },
    exceptions={non_interrupting_summoner=true},
    channel=function(self,q)
        if not self:IsMeditating()then return true end
        local row=self.resetSequence
        if not row or not q or q.owner~='yi_meditate_reset'then return false end
        if q.id==row.castID and q.channelName==self.profile.w then return true end
        local witness=row.channel;local cast=myHero.activeSpell
        return q.cancelChannel==row.castID and witness and cast and cast.valid and not cast.isStopped
            and cast.name==witness.name and cast.startTime==witness.startTime and cast.castEndTime==witness.castEndTime
    end,
    validate=function(self,q,slot,resolved)
        if slot and slot>=0 and slot<=3 and not self:Ready(slot)then return false end
        if slot==_Q and q.mode=='Harass'and not manaAbove(Menu.Harass.Mana:Value())then return false end
        if slot==_Q and q.owner=='evade_untargetable' then return true end
        if slot==_Q and q.object then
            local safe=(q.mode=='Harass' or q.mode=='LastHit' or q.mode=='Flee') or self:ComboSafety()
            if not self:CanUseQ(q.object,safe) then return false end
            if q.owner=='LaneClear' then return not IsUnderTurret(myHero) and self:LaneMana() and self:FarmCount(q.object)>=Menu.Clear.LaneClear.QCount:Value() end
        end
        if slot==_W and q.owner=='AutoW' then return self:WUseful() end
        if slot==_W and q.owner=='JungleClear' then return self:JungleWUseful() end
        if slot==_R then return not self:LiveBuff(self.profile.r) end
        return true
    end,
})

MasterYiChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_MasterYi"]="MasterYi"}
local normalSupported={["MasterYi"]=true}

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
