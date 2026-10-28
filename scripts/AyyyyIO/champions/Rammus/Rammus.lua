return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Rammus"]=function()return _G.OrbamaFamily:Require("ba8070b2f92778d4a731eefc5b2a11543e71b5823a50dd71d1b163dee064b6b9")()end
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
if champion=="Rammus" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Rammus',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent feature implementation. Installed assets are candidates, not live proof.
local profiles=ChampionProfiles('Rammus')
local finite,id,point=Core.finite,Core.id,Core.point
-- Pinned by this champion's regressions: only a ready, in-range lethal attack keeps the spell (Core:Rescue).
local readyAttack={attack='ready'}
local function cancelPlan(p,reason)
 if not p then return end
 if p.action then Core.adapter:Cancel(p.action,reason)end
 if p.move then Core.adapter:Cancel(p.move,reason);Core.adapter:Finish(p.move)end
end
local function cleanup(self,reason)
 cancelPlan(self.roll,reason);cancelPlan(self.landing,reason);cancelPlan(self.interrupt,reason)
 if self.flashCombo then self.flashCombo:Cancel(reason or 'controller_closed')end
 self.roll=nil;self.landing=nil;self.interrupt=nil;self.preview=nil;self.moves={};self.peelWatch=nil;self.tremorsProbe=nil
 Core.adapter:SetBlocked('RammusRoll','attack',false)
end
local function collectMoves(self)
 for action in pairs(self.moves or {})do local r=Core.adapter:Poll(action)
  if not r then self.moves[action]=nil
  elseif r.mechanical and r.cleanupPending~=true or not r.sentAt and r.state=='cancelled_before_send'and r.cleanupPending~=true then
   Core.adapter:Finish(action);self.moves[action]=nil
  elseif r.sentAt and Core.adapter:Reconcile(action)then self.moves[action]=nil end
 end
end
local RammusChampion=class("RammusChampion")
function RammusChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.moves={};self:LoadMenu()
 local p=self.profile
 -- Normal prediction delay/speed from the profile (Rammus-10); Classic Tremors is caster-centred and never predicted.
 self.RSpell={Type=OrbamaPrediction.SPELLTYPE_CIRCLE,Delay=p.rDelay or .25,Speed=p.rSpeed or 900,Radius=p.rRadius,Range=p.rRange or 800,Collision=false}
 self.msSamples={}
 -- Flash, then taunt a target just out of E range (shared Core:FlashFollow, flash_first). Off by default.
 self.flashCombo=Core.FlashFollow and Core:FlashFollow('RammusFlashE')
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
 self:RegisterEvade()
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 Core:RegisterCleanup('Rammus',function(reason)cleanup(self,reason)end)
 local accepted,why=Core:RegisterPreparation('rammus_display',{intervalMs=100,maxDelayMs=250,units=1,maxUnits=1},
  function()self:PrepareDraw();return true end,
  function()return Menu.Draw.Preview:Value()or Menu.Draw.Ranges:Value()end,function()self.preview=nil end)
 self.drawFallback=not accepted and why=='unsupported'
end
function RammusChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Rammus'})
 local tremors=self.profile.rKind=='tremors'
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q (roll into the target)',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='W',name='Use W when an enemy attacks you',value=true})
  Menu[mode]:MenuElement({id='E',name='Use E',value=true})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5,menu=mode=='Harass'})
 end
 Menu.Combo:MenuElement({id='R',name=tremors and 'Use R'or 'Use R (leap onto enemies)',value=true})
 Menu.Combo:MenuElement({id='RCount',name='R only when it hits at least this many enemies',value=2,min=1,max=5,step=1})
 if not tremors then Menu.Combo:MenuElement({id='RKill',name='Use R on a single enemy it kills',value=true})end
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=kind,name=kind=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[kind]:MenuElement({id='Q',name='Use Q',value=true})
  Menu.Clear[kind]:MenuElement({id='W',name='Use W when attacked',value=true})
  if kind=='JungleClear'then Menu.Clear[kind]:MenuElement({id='E',name='Use E',value=true})end
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='QCount',name='Lane minions next to you for Q',value=2,min=1,max=8,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on a lone minion next to you',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='Roll',name='Cast Q at the selected target',key=string.byte('U')})
 Menu.Misc:MenuElement({id='Slam',name='Cast R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='Interrupt',name=tremors and 'Interrupt nearby enemy channels with E'or 'Interrupt channels with E or by rolling into them',value=true})
 Menu.Misc:MenuElement({id='Peel',name='Taunt enemies dashing onto you or a nearby ally',value=true})
 Menu.Misc:MenuElement({id='AllyPeel',name='Taunt an enemy attacking an ally next to you',value=true})
 Menu.Misc:MenuElement({id='FlashE',name='In Combo, Flash to taunt a target out of E range',value=false})
 Menu.Misc:MenuElement({id='AutoW',name='Use W when an enemy champion is about to hit you',value=true})
 Menu.Misc:MenuElement({id='FleeQ',name='Use Q when fleeing',value=true})
 Menu.Misc:MenuElement({id='FleeE',name='Taunt a chaser when fleeing',value=true})
 if not tremors then Menu.Misc:MenuElement({id='FleeR',name='Use R to escape when fleeing',value=false})end
 Menu.Misc:MenuElement({id='Health',name='Never dash in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='Enemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='ReserveE',name='Keep mana for E when engaging',value=true,menu=false})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Preview',name='Roll destination and the R area',value=true})
end
function RammusChampion:Reach(u,range)return Core:Reach(u,range)end
function RammusChampion:Buff(u,name)return Core:SelfBuff(u,name)end
function RammusChampion:Rolling()local b,reason=self:Buff(myHero,self.profile.qBuff);return b~=nil,reason end
function RammusChampion:Stance()local b,reason=self:Buff(myHero,self.profile.wBuff);return b~=nil,reason end
-- fromStance: Q may end the W stance (wiki: casting Q ends W); only the Combo chase asks for it (Rammus-6).
function RammusChampion:Ready(slot,cancel,fromStance)
 local p=self.profile;local letter=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot];local d=myHero:GetSpellData(slot)
 if not letter or not d or d.level<=0 or Game.CanUseSpell(slot)~=0 or d.currentCd~=0 then return false end
 if cancel then return slot==_Q and p.qCancel~=nil and d.name==p.qCancel and self:Rolling()end
 if d.name~=p[letter]and d.name~=p[letter..'Alias']or not finite(d.mana)or d.mana<0 or d.mana>myHero.mana then return false end
 local rolling,qr=self:Rolling()
 if slot==_Q or slot==_W then local stance,wr=self:Stance();return not rolling and not qr and(not stance or slot==_Q and fromStance==true)and not wr end
 if slot==_E then return not rolling and not qr end
 return not qr
end
function RammusChampion:Reserve(slot)
 if not Menu.Misc.ReserveE:Value()then return true end
 local e=myHero:GetSpellData(_E);local s=myHero:GetSpellData(slot)
 local eReady=self:Ready(_E)
 if slot==_R and self.profile.rKind=='landing'and self:Rolling()then
  -- R ends rolling. Spending is evaluated for the remaining legal native E,
  -- while any future taunt must still wait for actual landing and Q termination.
  eReady=e and e.level>0 and e.currentCd==0 and Game.CanUseSpell(_E)==0
   and(e.name==self.profile.e or e.name==self.profile.eAlias)
 end
 return eReady and finite(e.mana)and finite(s.mana)and e.mana>=0 and s.mana>=0 and e.mana+s.mana<=myHero.mana
end
function RammusChampion:Safe(pos,offense)
 if not point(pos)or type(Game.isWall)~='function'or Game.isWall(pos)~=false or IsUnderTurret2(pos)then return false end
 if GetEnemyCount(600,pos)>Menu.Misc.Enemies:Value()then return false end
 return not offense or finite(myHero.maxHealth)and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.Health:Value()
end
function RammusChampion:Current(u,expected,handle)return IsValid(u)and id(u)==expected and u.handle==handle and Core:CurrentUnit(u)end
function RammusChampion:PlayerAim()
 local api=_G.SDK.Actions;local input=_G.SDK.Input
 if api and type(api.GetPlayerPosition)=='function'then return point(api:GetPlayerPosition())end
 if input and type(input.GetPlayerPosition)=='function'then return point(input:GetPlayerPosition())end
 -- Original-GG lacks a verified independent logical aim during synthetic input.
 if Core.adapter:Available()then return point(mousePos)end
end
function RammusChampion:RollPath(pos,target)
 if not self:Safe(pos,target and target.type==Obj_AI_Hero)then return false end
 local origin=myHero.pos;local length=GetDistance(pos,origin);if length<20 or length>900 then return false end
 for i=1,8 do if Game.isWall(origin:Extended(pos,length*i/8))~=false then return false end end
 local list=_G.SDK.ObjectManager:GetEnemyMinions(1000)
 if #list>64 then return false end
 local heroes=_G.SDK.ObjectManager:GetEnemyHeroes(1000)
 local units={};for i=1,#list do units[#units+1]=list[i]end
 for i=1,math.min(#heroes,5)do units[#units+1]=heroes[i]end
 local dx,dz=(pos.x-origin.x)/length,(pos.z-origin.z)/length
 for i=1,#units do local u=units[i]
  if IsValid(u)and id(u)~=id(target)then
   local along=(u.pos.x-origin.x)*dx+(u.pos.z-origin.z)*dz
   local cross=math.abs((u.pos.x-origin.x)*dz-(u.pos.z-origin.z)*dx)
   if along>0 and along<length-40 and cross<=75+(u.boundingRadius or 65)then return false end
  end
 end
 return true
end
function RammusChampion:StartRoll(target,context,flee,extra,fromStance)
 if self.roll or not self:Ready(_Q,nil,fromStance)then return false end
 local function escapePath()
  local aim=self:PlayerAim();if not aim or GetDistance(aim,myHero.pos)<150 then return false end
  local pos=GetDistance(aim,myHero.pos)>650 and myHero.pos:Extended(aim,650)or aim
  return self:RollPath(pos,nil)
 end
 if flee and not escapePath()then return false end
 if not flee and(not self:Reach(target,900)or not self:Reserve(_Q)or not self:RollPath(target.pos,target))then return false end
 local p={target=target,id=id(target),handle=target and target.handle,context=context,flee=flee,extra=extra,expires=Game.Timer()+self.profile.qDuration+.8}
 self.roll=p
 local function valid()
  return self.roll==p and self:Ready(_Q,nil,fromStance)and(not extra or extra())and(flee and escapePath()or not flee and self:Current(target,p.id,p.handle)
   and self:Reach(target,900)and self:Reserve(_Q)and self:RollPath(target.pos,target))
 end
 local ok=Core:Cast(HK_Q,nil,{owner=fromStance and 'PowerballChase'or 'Powerball',context=context,intentTarget=target,independent=false,validate=valid})
 if not ok then self.roll=nil;return false end
 p.action=Core.lastIntent.id
 Core:AfterCast(HK_Q,function()if self.roll==p then p.observed=true end end)
 return true
end
function RammusChampion:ClearRoll(reason)cancelPlan(self.roll,reason);self.roll=nil;Core.adapter:SetBlocked('RammusRoll','attack',false)end
function RammusChampion:MoveRoll(p,pos)
 if p.move then
  local r=Core.adapter:Poll(p.move);if not r then self:ClearRoll('move_result_missing');return false end
  if r.jobCancelled or r.state=='cancelled_before_send'or r.state=='send_uncertain'then self:ClearRoll('move_interrupted');return false end
  if r.sentAt then
   if r.mechanical and r.cleanupPending~=true then
    -- Finish may already have completed through the client's deferred cleanup.
    Core.adapter:Finish(p.move);p.move=nil;p.nextMove=Game.Timer()+.1;return true
   end
   local path=myHero.pathing
   if path and path.hasMovePath and point(path.endPos)and GetDistance(path.endPos,p.movePos)<=50
    and(not p.beforePath or GetDistance(p.beforePath,path.endPos)>50)then
    Core.adapter:Observe(p.move,{kind='mechanical',unique=true,source='fresh_owned_move_path',at=Core.adapter:Now()})
    if Core.adapter:Finish(p.move)then p.move=nil;p.nextMove=Game.Timer()+.1 end
   elseif Core.adapter:Now()>r.sentAt+1000 then self:ClearRoll('move_unconfirmed')end
  end
  return true
 end
 if p.nextMove and p.nextMove>Game.Timer()then return true end
 local retained=0;for _ in pairs(self.moves)do retained=retained+1 end
 if retained>=8 then self:ClearRoll('move_results_full');return false end
 if not self:RollPath(pos,p.target)then self:ClearRoll('roll_path_blocked');return false end
 local start=point(myHero.pathing and myHero.pathing.endPos);p.movePos=point(pos);p.beforePath=start
 local opts={owner='RammusRoll',resource='move',priority='interactive',expires=Core.adapter:Now()+200,context=p.context,
  mechanical=function(resolved)
   return self.roll==p and self:Rolling()and(not p.extra or p.extra())and(p.flee or self:Current(p.target,p.id,p.handle))
    and self:RollPath(resolved and resolved.position or p.movePos,p.target)
  end,
  reconcile=function()
   -- Historical uncertainty remains. Fresh path state plus provider cleanup
   -- only releases this resource for a newly decided movement after the plan.
   -- Lexical reads remain available when the controller has been disabled.
   local path=myHero.pathing
   return self.roll~=p and myHero.dead~=true and finite(myHero.health)and myHero.health>0
    and path and type(path.hasMovePath)=='boolean'and point(path.endPos)~=nil
    and not(myHero.activeSpell and myHero.activeSpell.valid)
  end,
  resolve=function()
   local aim=p.flee and self:PlayerAim()or p.target and point(p.target.pos)
   if not aim then return nil,'aim_unknown'end
   local pos=GetDistance(aim,myHero.pos)>650 and myHero.pos:Extended(aim,650)or aim
   if not self:RollPath(pos,p.target)then return nil,'path_changed'end
   p.movePos=point(pos);return {position=pos}
  end}
 if Core.adapter:Capabilities().prevalidateWorldMove then opts.prevalidateWorldMove=true;opts.commitGuard=function()return self.roll==p end end
 p.move=Core.adapter:Move(pos,opts)
 if not p.move then self:ClearRoll('move_declined');return false end
 self.moves[p.move]=true
 return true
end
function RammusChampion:ContinueRoll()
 local p=self.roll;if not p then return false end
 local r=p.action and Core.adapter:Poll(p.action)
 if not Core:Available()or p.expires<=Game.Timer()or not r or r.jobCancelled or r.state=='cancelled_before_send'
  or not Core.adapter:ContextValid({context=p.context},'continuation')or p.extra and not p.extra()
  or not p.flee and not self:Current(p.target,p.id,p.handle)then self:ClearRoll('roll_ended');return false end
 local rolling,reason=self:Rolling()
 if reason then self:ClearRoll(reason);return false end
 if not p.observed then return true end
 if not rolling then self:ClearRoll('roll_collision_or_end');return false end
 Core.adapter:SetBlocked('RammusRoll','attack',true)
 self:TraceRoll(p)
 if not p.flee and GetDistance(p.target.pos,myHero.pos)<=125 then return true end
 local aim=p.flee and self:PlayerAim()or point(p.target.pos);if not aim then self:ClearRoll('aim_unknown');return false end
 local pos=GetDistance(aim,myHero.pos)>650 and myHero.pos:Extended(aim,650)or aim
 return self:MoveRoll(p,pos)
end
function RammusChampion:Threat(u)
 local a=u and u.activeSpell
 return a and a.valid and a.isStopped~=true and Core:IsAttackCast(a)
  and(a.target==myHero.networkID or a.target==myHero.handle)and finite(a.startTime)and a.startTime<=Game.Timer()
  and finite(a.castEndTime)and a.castEndTime>Game.Timer()and self:Reach(u,600)and self:Current(u,id(u),u.handle)
end
function RammusChampion:CastW(u,context,extra)
 if not self:Ready(_W)or not self:Threat(u)then return false end
 return Core:Cast(HK_W,nil,{intentTarget=u,context=context,validate=function()return self:Ready(_W)and self:Threat(u)and(not extra or extra())end})
end
-- Defensive Ball Curl against real incoming champion damage (Core:AllyThreat:
-- an enemy champion's attack on its way, a targeted cast winding up on Rammus or
-- a tracked skillshot he stands in). Minion attacks and turret shots do not
-- spend it. Not while rolling, and not in Flee, where the stance would hold Q back.
function RammusChampion:DefendW(context,extra)
 if self.roll or not self:Ready(_W)or extra and not extra()then return false end
 local threat=Core:AllyThreat(myHero,1.5,{turrets=false});if not threat then return false end
 return Core:Cast(HK_W,nil,{owner='Defense',intentTarget=threat.source,context=context,priority=context and context.priority or 'interactive',
  validate=function()return not self.roll and self:Ready(_W)and threat.valid()and(not extra or extra())end})
end
function RammusChampion:CastE(u,context,extra,priority)
 if not self:Ready(_E)or not self:Reach(u,325)then return false end
 local recipient,handle=id(u),u.handle
 if not self:Current(u,recipient,handle)then return false end
 local buff,reason=self:Buff(u,self.profile.eBuff);if buff or reason then return false end
 return Core:Cast(HK_E,u,{range=325,context=context,priority=priority,intentTarget=u,validate=function()
  local b,r=self:Buff(u,self.profile.eBuff)
  return self:Ready(_E)and self:Reach(u,325)and self:Current(u,recipient,handle)and not b and not r and(not extra or extra())
 end})
end
function RammusChampion:Latency()
 local data=_G.SDK.Data;local ok,v=pcall(function()return data and data.GetLatency and data:GetLatency()end)
 return ok and finite(v)and v>=0 and v<.5 and v or .05
end
-- A channel still running when the interrupting hit lands: E's 0.25 s cast plus latency (Rammus-10), or the
-- roll's arrival for the Q interrupt. Host channels count as before; the shared catalogue (Core:CanInterrupt)
-- adds dangerous channels the host leaves unflagged. An explicit isInterruptible=false refuses.
function RammusChampion:Channel(u,name,start,impact,range)
 local a=u and u.activeSpell;impact=impact or .25+self:Latency()
 if not self:Reach(u,range or 325)or not a or not a.valid or a.isInterruptible==false or a.isStopped==true
  or not finite(a.startTime)or a.startTime>Game.Timer()or a.name~=name or a.startTime~=start then return false end
 return Core:IsChannelCast(a)and finite(a.castEndTime)and a.castEndTime>Game.Timer()+impact or Core:CanInterrupt(u,impact)
end
-- Seconds the roll needs to reach `pos`: current movement speed without the roll's ramp (the slowest the roll
-- can be), plus latency. rammus_roll_speed records the real ramp before anything relies on it.
function RammusChampion:RollEta(pos)
 local ms=finite(myHero.ms)and myHero.ms>100 and myHero.ms or 300
 return GetDistance(pos,myHero.pos)/ms+self:Latency()
end
-- Rammus-5: a channel beyond E range is broken by rolling into it (knock-back), when the roll path is clear and
-- safe and the channel outlasts the roll's slowest arrival. Normal only (qKnockback in its profile).
function RammusChampion:InterruptRoll()
 if not self.profile.qKnockback or self.roll or not self:Ready(_Q)then return false end
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(900)
 for i=1,math.min(#list,5)do local u=list[i];local a=u.activeSpell
  if a and IsValid(u)and GetDistance(u.pos,myHero.pos)>325 then
   local name,start=a.name,a.startTime
   local fresh=function()return Menu.Misc.Interrupt:Value()and self:Channel(u,name,start,self:RollEta(u.pos),900)end
   if fresh()and self:StartRoll(u,{condition=function()return Menu.Misc.Interrupt:Value()end,priority='interactive'},false,fresh)then return true end
  end
 end
 return false
end
function RammusChampion:InterruptE()
 if not Menu.Misc.Interrupt:Value()or self.interrupt then return false end
 local rolling=self:Rolling();if not rolling and not self:Ready(_E)then return self:InterruptRoll()end
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(325)
 for i=1,math.min(#list,5)do local u=list[i];local a=u.activeSpell
  if a and self:Channel(u,a.name,a.startTime)then
   local name,start=a.name,a.startTime;local context={condition=function()return Menu.Misc.Interrupt:Value()end,priority='interactive'}
   local fresh=function()return self:Channel(u,name,start)end
   if not rolling then return self:CastE(u,context,fresh,'interactive')end
   if not self.profile.qCancel or not self:Ready(_Q,true)then self.lastRefusal='rolling_interrupt_cancel_unverified';return false end
   self:ClearRoll('interrupt')
   local p={target=u,id=id(u),handle=u.handle,context=context,expires=Game.Timer()+.45,fresh=fresh}
   self.interrupt=p
   local ok=Core:Cast(HK_Q,nil,{owner='CancelRoll',context=context,priority='interactive',validate=function()
    return self.interrupt==p and self:Ready(_Q,true)and self:Current(u,p.id,p.handle)and fresh()
   end})
   if not ok then self.interrupt=nil;return false end
   p.action=Core.lastIntent.id;Core:AfterCast(HK_Q,function()if self.interrupt==p then p.observed=true end end)
   return true
  end
 end
 return not rolling and self:InterruptRoll()
end
function RammusChampion:ContinueInterrupt()
 local p=self.interrupt;if not p then return false end
 local r=Core.adapter:Poll(p.action)
 if not r or r.jobCancelled or r.state=='cancelled_before_send'or p.expires<=Game.Timer()
  or not Core.adapter:ContextValid({context=p.context},'continuation')or not self:Current(p.target,p.id,p.handle)or not p.fresh()then
  cancelPlan(p,'interrupt_ended');self.interrupt=nil;return false
 end
 if p.observed and not self:Rolling()and self:Ready(_E)then
  local ok=self:CastE(p.target,p.context,p.fresh,'interactive');self.interrupt=nil;return ok
 end
 return true
end
-- Allies next to Rammus (at most four) whose divers and attackers he taunts away.
function RammusChampion:NearAllies(radius)
 local out={};local list=Core:DecisionUnits('GetAllyHeroes')
 for i=1,math.min(#list,6)do local a=list[i]
  if a and a~=myHero and not a.isMe and IsValid(a)and a.team==myHero.team and GetDistance(a.pos,myHero.pos)<=radius then out[#out+1]=a;if #out>=4 then break end end
 end
 return out
end
-- Rammus-3: any enemy champion (<= 5) dashing to land within 325 of Rammus (shared Core:ApproachingDash) or within
-- 150 of an ally within 325 of him (Core:DashLanding). E needs the diver in its range; while it is still out of
-- range the landing is remembered and the taunt follows within 0.5 s of the dash's end.
function RammusChampion:DashThreat(u)
 if not IsValid(u)then return false end
 if Core:ApproachingDash(u,myHero.pos,325)then return true end
 for _,ally in ipairs(self:NearAllies(325))do if Core:DashLanding(u,ally.pos,150,true)then return true end end
 return false
end
function RammusChampion:Peel()
 if not Menu.Misc.Peel:Value()or not self:Ready(_E)then return false end
 local now=Game.Timer();local w=self.peelWatch
 if w and(w.untilAt<now or not self:Current(w.unit,w.id,w.handle))then self.peelWatch=nil;w=nil end
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(1200)
 for i=1,math.min(#list,5)do local u=list[i]
  local watched=w and w.unit==u and w.handle==u.handle
  if watched or self:DashThreat(u)then
   if not watched then
    local snap=Core:DashLanding(u,nil,nil,false);local duration=snap and finite(snap.duration)and snap.duration or .5
    self.peelWatch={unit=u,id=id(u),handle=u.handle,untilAt=now+math.min(duration,2)+.5};w=self.peelWatch
   end
   local watch=self.peelWatch
   local function threat()return self.peelWatch==watch and Game.Timer()<=watch.untilAt and self:Current(u,watch.id,watch.handle)end
   if self:Reach(u,325)and self:CastE(u,{condition=function()return Menu.Misc.Peel:Value()end},threat,'interactive')then return true end
  end
 end
 return false
end
-- Rammus-4: taunt the enemy champion attacking, casting at or dashing onto an ally next to Rammus (shared
-- Core:PeelTarget; melee proximity alone is not evidence), within E range, while Rammus is healthy enough to take
-- the redirected attacks (Misc.Health). Normal W then answers those attacks.
function RammusChampion:Healthy()
 return finite(myHero.maxHealth)and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.Health:Value()
end
function RammusChampion:AllyPeel()
 if not Menu.Misc.AllyPeel:Value()or not self:Ready(_E)or not self:Healthy()then return false end
 for _,ally in ipairs(self:NearAllies(325+600))do
  local source=Core:PeelTarget(ally,1,{melee=false})
  if source and self:Reach(source,325)then
   local handle=ally.handle
   local function still()return Menu.Misc.AllyPeel:Value()and self:Healthy()and IsValid(ally)and ally.handle==handle
    and Core:PeelTarget(ally,1,{melee=false})==source end
   if self:CastE(source,{condition=function()return Menu.Misc.AllyPeel:Value()end},still,'interactive')then return true end
  end
 end
 return false
end
function RammusChampion:UltimateRange()
 if self.profile.rKind=='tremors'then return self.profile.rRadius end
 -- The asset's generic 25000 field is not a landing range. Base800 remains
 -- legal without guessing bonus range from an unverified native movement rate.
 return 800
end
function RammusChampion:RPosition(u)
 local pred=Core:Prediction(self.RSpell);pred:GetPrediction(u,myHero)
 return pred:CanHit(2)and point(pred.UnitPosition or pred.CastPosition)or nil
end
-- need: enemies the area must hit; a selected-target bind passes 1.
function RammusChampion:RGeometry(anchor,need)
 need=need or Menu.Combo.RCount:Value()
 if not self:Ready(_R)or not IsValid(anchor)or not self:Reserve(_R)then return nil end
 local classic=self.profile.rKind=='tremors';local radius=self.profile.rRadius;local rolling=not classic and self:Rolling()
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(1200);local rows,seen,primary={}, {},false
 for i=1,math.min(#list,5)do local u=list[i];local uid=id(u)
  if uid and not seen[uid]and IsValid(u)then
   seen[uid]=true;local aim=classic and point(u.pos)or self:RPosition(u)
   if aim then local isAnchor=uid==id(anchor)and u.handle==anchor.handle
    rows[#rows+1]={unit=u,position=aim,anchor=isAnchor};primary=primary or isAnchor
   end
  end
 end
 if not primary or #rows<need then return nil end
 local candidates=classic and {point(myHero.pos)}or {}
 if not classic then
  for _,row in ipairs(rows)do candidates[#candidates+1]=row.position end
  for i=1,#rows do for j=i+1,#rows do
   if GetDistance(rows[i].position,rows[j].position)<=radius*2 then candidates[#candidates+1]=(rows[i].position+rows[j].position)/2 end
  end end
 end
 local best,count,knockups
 for _,aim in ipairs(candidates)do
  local pos=not classic and GetDistance(aim,myHero.pos)>800 and myHero.pos:Extended(aim,800)or aim
  local n,hit,k=0,false,0
  for _,row in ipairs(rows)do local distance=GetDistance(row.position,pos)
   if distance<=radius then n=n+1;hit=hit or row.anchor and(not rolling or distance<=200)end
   if rolling and distance<=200 then k=k+1 end
  end
  if hit and n>=need and self:Safe(pos,true)
   and(not best or n>count or n==count and(k>knockups or k==knockups and GetDistance(pos,myHero.pos)<GetDistance(best,myHero.pos)))then best,count,knockups=pos,n,k end
 end
 if best then return {position=point(best),count=count,knockups=knockups,need=need,target=anchor,id=id(anchor),handle=anchor.handle}end
end
function RammusChampion:StartR(plan,context,flee)
 if self.landing or not plan or not self:Ready(_R)then return false end
 plan.context=context;plan.flee=flee;plan.expires=Game.Timer()+2;self.landing=plan
 plan.origin=point(myHero.pos);plan.averageMs=self:AverageMs()
 local function geometry()
  if self.landing~=plan or not self:Ready(_R)or plan.expires<=Game.Timer()then return nil end
  if flee then return self:Safe(plan.position,false)and GetDistance(plan.position,myHero.pos)<=800 and plan or nil end
  if not self:Current(plan.target,plan.id,plan.handle)then return nil end
  local refreshed=self:RGeometry(plan.target,plan.need)
  -- A single-target reason (kill, Q+R knock-up, Classic taunt) is re-proved at the refreshed landing.
  if refreshed and plan.check and not plan.check(refreshed)then return nil end
  return refreshed
 end
 local modern=self.profile.rKind=='landing';local opts={owner='RammusR',context=context,intentTarget=plan.target,independent=false,
  validate=function(q,r)
   local refreshed=geometry();if not refreshed then return false end
   if modern then local pos=r and r.position or q.target
    return point(pos)and self:Safe(pos,not flee)and GetDistance(pos,refreshed.position)<=25
   end
   return true
  end}
 if modern then
  opts.range=800;opts.prevalidateWorldCast=true
  opts.resolve=function()local nextPlan=geometry();if not nextPlan then return nil,'landing_changed'end
   plan.position=point(nextPlan.position);plan.count=nextPlan.count;return {position=plan.position}
  end
 end
 local ok=Core:Cast(HK_R,modern and plan.position or nil,opts)
 if not ok then self.landing=nil;return false end
 if modern and self.roll then self:ClearRoll('slam_transition')end
 plan.action=Core.lastIntent.id;Core:AfterCast(HK_R,function()if self.landing==plan then plan.observed=true end end)
 return true
end
-- Combo passes combo=true: when the enemy count is not met, R still goes on one enemy for a reason that makes a
-- lone slam worth it (Rammus-1/2): Normal while the observed roll carries the target into the 200 knock-up circle
-- (RGeometry demands that circle while rolling), or when the landing kills it (Combo.RKill); Classic while the
-- target holds Rammus's own taunt (it walks to him, inside the Tremors area). Each reason is rechecked at dispatch.
function RammusChampion:EngageR(context,need,combo)
 if self.landing or not self:Ready(_R)then return false end
 local u=GetTarget(self:UltimateRange()+self.profile.rRadius)
 if IsValid(u)then local plan=self:RGeometry(u,need);if plan then self.rPlanSeen={position=plan.position,at=Game.Timer()};return self:StartR(plan,context,false)end end
 if not combo then return false end
 local classic=self.profile.rKind=='tremors'
 if IsValid(u)then
  local check
  if not classic and self:Rolling()then check=function()return self:Rolling()==true end
  elseif classic and self:Taunted(u)then check=function()return self:Taunted(u)end end
  local plan=check and self:RGeometry(u,1)
  if plan then plan.reason=classic and 'taunted'or 'knockup';plan.check=check;self.rPlanSeen={position=plan.position,at=Game.Timer()};return self:StartR(plan,context,false)end
 end
 if classic or not Menu.Combo.RKill:Value()then return false end
 -- Finisher: the lowest-health enemy (<= 5) the landing kills, then its landing geometry.
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(self:UltimateRange()+self.profile.rRadius);local best
 for i=1,math.min(#list,5)do local e=list[i]
  if IsValid(e)and(not best or e.health<best.health)and self:RKills(e,e.pos)then best=e end
 end
 local plan=best and self:RGeometry(best,1)
 if not plan or not self:RKills(best,plan.position)then return false end
 plan.reason='kill';plan.check=function(refreshed)return Menu.Combo.RKill:Value()and self:RKills(best,refreshed.position)end
 self.rPlanSeen={position=plan.position,at=Game.Timer()}
 return self:StartR(plan,context,false)
end
-- Classic: the enemy holds Rammus's own taunt (Core:SelfBuff requires the player as the source).
function RammusChampion:Taunted(u)local b=self:Buff(u,self.profile.eBuff);return b~=nil end
function RammusChampion:GetRDmg(u)
 local p=self.profile;local rank=myHero:GetSpellData(_R).level
 local base=(p.rBase or p.rTick or {})[rank]
 return base and finite(myHero.ap)and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+p.rAP*myHero.ap)or 0
end
-- Normal landing damage kills `u` when Rammus lands at `pos`: impact after the cast delay and the slowest dash
-- (asset MinDashSpeed), through the shared kill rule (spell shields, cannot-die states, Exhaust).
function RammusChampion:RKills(u,pos)
 if self.profile.rKind~='landing'or not IsValid(u)or not point(pos)then return false end
 local impact=(self.profile.rDelay or .25)+GetDistance(pos,myHero.pos)/(self.profile.rSpeed or 900)
 return Core:Lethal(u,impact,self:GetRDmg(u),{kind='magical'})==true
end
function RammusChampion:ContinueR()
 local p=self.landing;if not p then return false end
 local r=Core.adapter:Poll(p.action)
 if not Core:Available()or not r or r.jobCancelled or r.state=='cancelled_before_send'or p.expires<=Game.Timer()
  or not Core.adapter:ContextValid({context=p.context},'continuation')or p.target and not self:Current(p.target,p.id,p.handle)then
  cancelPlan(p,'r_ended');self.landing=nil;return false
 end
 -- The landing holds the whole tick. After the observed cast it ends when the
 -- leap and the cast are over: at the planned point, after a dash that was seen
 -- and ended anywhere, or 0.3 s after the cast when no dash was seen. Requiring
 -- an arrival within 100 units of the planned point held everything for 2 s.
 if p.observed then local dashing=myHero.pathing and myHero.pathing.isDashing==true
  p.observedAt=p.observedAt or Game.Timer();if dashing then p.dashSeen=true;p.dashAt=p.dashAt or Game.Timer()end
  if self.profile.rKind=='tremors'then self:ProbeTremors(p);self.landing=nil
  elseif not dashing and not IsCasting()
   and(p.dashSeen or GetDistance(myHero.pos,p.position)<=100 or Game.Timer()-p.observedAt>.3)then self:TraceSlam(p);self.landing=nil end
 end
 return true
end
function RammusChampion:GetQDmg(u)
 local rank=myHero:GetSpellData(_Q).level;local base=self.profile.qBase[rank]
 return base and finite(myHero.ap)and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.qAP*myHero.ap)or 0
end
function RammusChampion:GetEDmg(u)
 if self.profile.id~='normal'or u.team~=300 then return 0 end
 local rank=myHero:GetSpellData(_E).level;local base=self.profile.eMonster[rank]
 return base and finite(myHero.ap)and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.eAP*myHero.ap)or 0
end
function RammusChampion:CountLane()return #Core:Rows('lane',250)end
function RammusChampion:Rescue(u)
 return Core:Reach(u,125)and u.team~=300 and self:CountLane()==1 and Core:Rescue(u,.25,self:GetQDmg(u),readyAttack)
end
function RammusChampion:LocalQ(u,context,extra)
 if not self:Ready(_Q)or not self:Reach(u,125)then return false end
 return Core:Cast(HK_Q,nil,{intentTarget=u,context=context,validate=function()return self:Ready(_Q)and self:Reach(u,125)and(not extra or extra())end})
end
function RammusChampion:LastHit()
 if not Menu.LastHit.Q:Value()or not Core.manaAbove(Menu.LastHit.Mana:Value())or not self:Ready(_Q)then return false end
 local list=_G.SDK.ObjectManager:GetEnemyMinions(125)
 for i=1,math.min(#list,40)do local u=list[i];if self:Rescue(u)then return self:LocalQ(u,Core:RescueContext(),function()return self:Rescue(u)end)end end
 return false
end
function RammusChampion:LaneClear()
 if not Core:FarmModeEnabled('lane')or not Menu.Clear.SpellFarm:Value()then return false end
 local node=Menu.Clear.LaneClear;if not Core.manaAbove(node.Mana:Value())then return false end
 local w=node.W:Value()and self:Ready(_W);local q=node.Q:Value()and self:Ready(_Q)
 if not w and not q then return false end
 local qUseful=q and self:CountLane()>=node.QCount:Value()
 local context=Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)
 local list=_G.SDK.ObjectManager:GetEnemyMinions(325)
 for i=1,math.min(#list,40)do local u=list[i]
  if u.team~=300 and self:Reach(u,325)then
   if w and self:CastW(u,context)then return true end
   if qUseful and self:LocalQ(u,context,function()return self:CountLane()>=node.QCount:Value()end)then return true end
  end
 end
 return false
end
function RammusChampion:JungleClear()
 if not Core:FarmModeEnabled('jungle')or not Menu.Clear.SpellFarm:Value()then return false end
 local node=Menu.Clear.JungleClear;if not Core.manaAbove(node.Mana:Value())then return false end
 local w=node.W:Value()and self:Ready(_W);local e=node.E:Value()and self:Ready(_E);local q=node.Q:Value()and self:Ready(_Q)
 if not w and not e and not q then return false end
 local list=_G.SDK.ObjectManager:GetMonsters(325);local best
 for i=1,math.min(#list,12)do local u=list[i];if self:Reach(u,325)and u.team==300
  and(not best or u.maxHealth>best.maxHealth)then best=u end end
 if not best then return false end
 local context=Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)
 if w and self:CastW(best,context)then return true end
 local function aliveAtImpact()local hp=Core:UnshieldedLegacyForecast(best,.25);return finite(hp)and hp>0 end
 if e and aliveAtImpact()and self:CastE(best,context,aliveAtImpact)then return true end
 if q and aliveAtImpact()then return self:LocalQ(best,context,aliveAtImpact)end
 return false
end
-- Rammus-6: Q may end the W stance in Combo to chase a target that is out of E range and walking away, while
-- nothing is about to hit Rammus (the stance is then not doing its job). Rechecked at dispatch.
function RammusChampion:Chase(u)
 if GetMode()~='Combo'or not IsValid(u)or not self:Stance()then return false end
 local d=GetDistance(u.pos,myHero.pos);local path=u.pathing
 return d>325 and path and path.hasMovePath==true and point(path.endPos)~=nil and GetDistance(path.endPos,myHero.pos)>d
  and Core:AllyThreat(myHero,1)==nil
end
-- Rammus-1: Combo Q on an enemy the roll kills when the selected target cannot be rolled into (out of reach or a
-- blocked path). Impact uses the slowest arrival (RollEta); the kill is rechecked at dispatch.
function RammusChampion:QKills(u)
 return IsValid(u)and self:Reach(u,900)and Core:Lethal(u,self:RollEta(u.pos),self:GetQDmg(u),{kind='magical'})==true
end
function RammusChampion:LethalRoll(context,skip)
 if self.roll or not self:Ready(_Q)then return false end
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(900);local rows={}
 for i=1,math.min(#list,5)do local e=list[i];if e~=skip then rows[#rows+1]=e end end
 local k=Core:LethalPick(rows,function(e)return self:QKills(e)end,function(e)return self:RollPath(e.pos,e)end)
 return k~=nil and self:StartRoll(k,context,false,function()return self:QKills(k)end)
end
function RammusChampion:Combat(mode)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return false end
 local context=Core:ModeContext(mode)
 if mode=='Combo'and node.R:Value()and self:EngageR(Core:ModeContext(mode,function()return Menu.Combo.R:Value()end),nil,true)then return true end
 -- Any enemy champion about to hit Rammus, not only the current target (a ranged attacker is outside target reach).
 if node.W:Value()and self:DefendW(context,function()return node.W:Value()and Core.manaAbove(node.Mana:Value())end)then return true end
 local u=GetTarget(math.max(node.Q:Value()and 900 or 325,mode=='Combo'and Menu.Misc.FlashE:Value()and 700 or 0))
 local qContext=Core:ModeContext(mode,function()return node.Q:Value()and Core.manaAbove(node.Mana:Value())end)
 if not IsValid(u)then return mode=='Combo'and node.Q:Value()and self:LethalRoll(qContext)or false end
 if node.E:Value()and self:CastE(u,context)then return true end
 if node.W:Value()and self:CastW(u,context)then return true end
 if node.Q:Value()then
  if self:StartRoll(u,qContext,false)then return true end
  if mode=='Combo'and self:Chase(u)and self:StartRoll(u,qContext,false,function()return self:Chase(u)end,true)then return true end
  if mode=='Combo'and self:LethalRoll(qContext,u)then return true end
 end
 return mode=='Combo'and self:FlashE(u)or false
end
-- Rammus-13: Flash toward a target 325..325+Flash away, then E once the Flash is observed at the landing
-- (Core:FlashFollow, flash_first). Off by default; E readiness and both costs are checked before the Flash.
function RammusChampion:FlashE(u)
 local combo=self.flashCombo
 if not combo or combo:Busy()or not Menu.Misc.FlashE:Value()or not Menu.Combo.E:Value()or not self:Ready(_E)or not IsValid(u)then return false end
 local status=Core:FlashStatus();if not status then return false end
 local eCost=myHero:GetSpellData(_E).mana;if not finite(eCost)or myHero.mana<status.cost+eCost then return false end
 local d=GetDistance(u.pos,myHero.pos);if d<=325 or d>325+status.range-25 then return false end
 local aim=myHero.pos:Extended(u.pos,math.min(status.range,d-200))
 local uid,handle=id(u),u.handle
 local function authorized()return Menu.Misc.FlashE:Value()and Menu.Combo.E:Value()and GetMode()=='Combo'end
 local function valid(pos)return self:Ready(_E)and self:Current(u,uid,handle)and point(pos)~=nil and GetDistance(u.pos,pos)<=300 and self:Safe(pos,true)end
 return combo:Start{order='flash_first',aim=aim,authorized=authorized,valid=valid,mana=eCost,
  follow=function(context)return self:CastE(u,context,nil,'interactive')end}==true
end
function RammusChampion:Combo()return self:Combat('Combo')end
function RammusChampion:Harass()return self:Combat('Harass')end
function RammusChampion:Flee()
 local context=Core:ModeContext('Flee')
 if self.profile.rKind=='landing'and Menu.Misc.FleeR:Value()and not self.fleeRUsed and self:Ready(_R)then
  local pos=self:PlayerAim();if pos and GetDistance(pos,myHero.pos)>800 then pos=myHero.pos:Extended(pos,800)end
  if pos and self:Safe(pos,false)and self:StartR({position=pos},Core:ModeContext('Flee',function()return Menu.Misc.FleeR:Value()end),true)then self.fleeRUsed=true;return true end
 end
 if Menu.Misc.FleeE:Value()then local u=GetTarget(325);if self:CastE(u,context)then return true end end
 if Menu.Misc.FleeQ:Value()then return self:StartRoll(nil,Core:ModeContext('Flee',function()return Menu.Misc.FleeQ:Value()end),true)end
 return false
end
function RammusChampion:Assist()
 if Menu.Misc.Slam:Value()and not self.slamUsed and self:EngageR(Core:HeldContext(function()return Menu.Misc.Slam:Value()end),1)then self.slamUsed=true;return true end
 if Menu.Misc.Roll:Value()and not self.rollUsed and self:Ready(_Q)then
  local u=GetTarget(900)
  if self:StartRoll(u,Core:HeldContext(function()return Menu.Misc.Roll:Value()end),false)then self.rollUsed=true;return true end
 end
 return false
end
-- Rammus-14: the R area, prepared here only. Normal: 400 around the committed landing, a landing found in the
-- last 0.3 s, or (R bind held) the bind's landing on the selected target; Classic: Tremors around Rammus while the
-- R bind is held or Combo may cast R. Draw reads this row and the current hero position only.
function RammusChampion:RArea()
 local p=self.profile;if not self:Ready(_R)and not self.landing then return nil end
 local held=Menu.Misc.Slam:Value();local combo=GetMode()=='Combo'and Menu.Combo.R:Value()
 if p.rKind=='tremors'then return(held or combo or self.landing)and {self=true,radius=p.rRadius}or nil end
 if self.landing and point(self.landing.position)then return {position=point(self.landing.position),radius=p.rRadius}end
 local seen=self.rPlanSeen
 if seen and Game.Timer()-seen.at<=.3 then return {position=point(seen.position),radius=p.rRadius}end
 if held then local u=GetTarget(self:UltimateRange()+p.rRadius);local plan=IsValid(u)and self:RGeometry(u,1)
  if plan then return {position=plan.position,radius=p.rRadius}end
 end
end
function RammusChampion:PrepareDraw()
 if not Menu.Draw.Preview:Value()and not Menu.Draw.Ranges:Value()then self.preview=nil;return end
 -- No roll/stance text: the game shows them. Kept for a second so a late preparation never blinks it.
 local p=self.landing or self.roll
 self.preview={position=p and point(p.position or p.movePos or p.target and p.target.pos),
  rRange=self:UltimateRange(),rArea=Menu.Draw.Preview:Value()and self:RArea()or nil,expires=Game.Timer()+1}
end
function RammusChampion:Tick()
 collectMoves(self)
 if ShouldWait()then cleanup(self,'unavailable');return end
 self:SampleMs();self:TickTremorsProbe()
 if self.flashCombo and self.flashCombo:Busy()and self.flashCombo:Maintain()then return end
 if not Menu.Misc.Roll:Value()then self.rollUsed=false end
 if not Menu.Misc.Slam:Value()then self.slamUsed=false end
 local mode=GetMode();if mode~='Flee'then self.fleeRUsed=false end
 if self.drawFallback then self:PrepareDraw()end
 if self:ContinueInterrupt()or self:InterruptE()or self:ContinueR()then return end
 if self.roll and self.profile.rKind=='landing'and self:Rolling()then
  if self:Assist()then return end
  if mode=='Combo'and Menu.Combo.R:Value()and Core.manaAbove(Menu.Combo.Mana:Value())
   and self:EngageR(Core:ModeContext('Combo',function()return Menu.Combo.R:Value()end),nil,true)then return end
  if mode=='Flee'and self:Flee()then return end
 end
 if self:ContinueRoll()or IsCasting()then return end
 if self:Assist()or self:Peel()or self:AllyPeel()then return end
 -- Without a mode key (Combo and Harass have their own W switch and mana limit).
 if mode~='Flee'and mode~='Combo'and mode~='Harass'and Menu.Misc.AutoW:Value()and self:DefendW(nil,function()return Menu.Misc.AutoW:Value()and GetMode()~='Flee'end)then return end
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')and self:LaneClear()then return end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function RammusChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.Ranges:Value()then
  if IsReady(_E)then Draw.Circle(myHero.pos,325,1,Draw.Color(255,120,200,255))end
  if IsReady(_R)then Draw.Circle(myHero.pos,self:UltimateRange(),1,Draw.Color(255,200,160,100))end
 end
 local p=self.preview
 if p and p.expires>Game.Timer()and Menu.Draw.Preview:Value()then
  if p.position and(self.landing or self.roll)then Draw.Circle(p.position,75,1,Draw.Color(255,255,200,100))end
  local a=p.rArea;if a and IsReady(_R)then Draw.Circle(a.self and myHero.pos or a.position,a.radius,1,Draw.Color(255,255,140,60))end
 end
end
-- Health-bar damage (S9): ready Q and R (Normal landing; Classic one Tremors tick) plus one attack. Partial: the
-- passive, W reflect and later Tremors ticks are not modelled.
function RammusChampion:ComboDamage(u)
 if not IsValid(u)then return 0 end
 local total=(self:Ready(_Q)and self:GetQDmg(u)or 0)+(self:Ready(_R)and self:GetRDmg(u)or 0)
 local ok,aa=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
 return total+(ok and finite(aa)and aa or 0),true
end
-- Evade offers (S6): W as a resistance effect (both profiles, numbers from the profile), Normal R as a dash only
-- against a lethal hit (lethalOnly). The R speed is the asset MinDashSpeed lower bound (slower than the real
-- 900-2000 dash, so Evade never expects an earlier arrival than the slam gives).
function RammusChampion:WResist(kind)
 local p=self.profile;local rank=myHero:GetSpellData(_W).level
 if p.wResist then return p.wResist[rank]end
 local flat,share=(kind=='armor'and p.wArmor or p.wMR)[rank],(kind=='armor'and p.wArmorShare or p.wMRShare)[rank]
 local total=kind=='armor'and myHero.armor or myHero.magicResist
 if not flat or not share or not finite(total)or total<0 then return nil end
 return flat+share*total
end
function RammusChampion:RegisterEvade()
 local p=self.profile
 if Core.RegisterEffect and p.wSource then
  self.wOffered,self.wReason=Core:RegisterEffect({kind='resist',name='Rammus.W',slot=_W,key=HK_W,profile=p.id,source=p.wSource,
   delay=p.wDelay,duration=p.wDuration,ready=function()return self:Ready(_W)end,
   armor=function()return self:WResist('armor')end,magicResist=function()return self:WResist('mr')end})
 end
 if p.rKind=='landing'and p.rSource then
  self.mobilityOffered,self.mobilityReason=Core:RegisterMobility({kind='dash',slot=_R,key=HK_R,name=p.r,range=p.rRange,speeds={p.rSpeed},
   castDelays={p.rDelay},toPoint=true,lethalOnly=true,profile=p.id,label='Soaring Slam',source=p.rSource,allowed=function(target)
    if self.landing then return false,'engage_in_progress'end
    if target==nil then return true end
    if GetDistance(target,myHero.pos)>p.rRange+.01 then return false,'out_of_range'end
    return type(Game.isWall)=='function'and Game.isWall(target)==false and not IsUnderTurret2(target),'unsafe_landing'
   end})
 end
end
-- Measurement traces (dev recorder only; no gameplay decision reads them).
-- rammus_slam_flight (Rammus-7/10): 1 s average movement speed before the cast, planned and travelled distance,
-- delay from the observed cast to the first dash sample and the flight time. rammus_roll_speed (Rammus-5): movement
-- speed during an observed roll. rammus_classic_q_rolling (Rammus-9): the Classic Q slot while rolling (cancel
-- name). rammus_tremors_tick / rammus_tremors_hits (Rammus-1/8): first Tremors damage and the hit distances.
function RammusChampion:SampleMs()
 local now=Game.Timer();local list=self.msSamples
 if #list>0 and now-list[#list].at<.05 then return end
 if finite(myHero.ms)then list[#list+1]={at=now,ms=myHero.ms}end
 while #list>0 and(now-list[1].at>1 or #list>24)do table.remove(list,1)end
end
function RammusChampion:AverageMs()
 local list=self.msSamples or {};if #list==0 then return finite(myHero.ms)and myHero.ms or nil end
 local sum=0;for i=1,#list do sum=sum+list[i].ms end;return sum/#list
end
function RammusChampion:TraceSlam(p)
 if not Core.logger or not p.origin then return end
 local now=Game.Timer()
 Core:Trace('rammus_slam_flight',{averageMs=p.averageMs and math.floor(p.averageMs)or nil,planned=math.floor(GetDistance(p.position,p.origin)),
  travelled=math.floor(GetDistance(myHero.pos,p.origin)),delay=p.dashAt and p.observedAt and p.dashAt-p.observedAt or nil,
  flight=p.dashAt and now-p.dashAt or nil,dashSeen=p.dashSeen==true,reason=p.reason})
end
function RammusChampion:TraceRoll(p)
 if not Core.logger then return end
 p.rolledAt=p.rolledAt or Game.Timer()
 Core:Trace('rammus_roll_speed',{elapsed=Game.Timer()-p.rolledAt,ms=myHero.ms},.2)
 if self.profile.id=='classic'then local d=myHero:GetSpellData(_Q)
  Core:Trace('rammus_classic_q_rolling',{name=d and d.name,toggle=d and d.toggleState,cd=d and d.currentCd,canUse=Game.CanUseSpell(_Q)},1)
 end
end
function RammusChampion:ProbeTremors(p)
 if not Core.logger or self.tremorsProbe then return end
 local rows={};local list=_G.SDK.ObjectManager:GetEnemyHeroes(self.profile.rRadius+100)
 for i=1,math.min(#list,5)do local u=list[i];if IsValid(u)then rows[#rows+1]={unit=u,handle=u.handle,health=u.health}end end
 if #rows>0 then self.tremorsProbe={at=Game.Timer(),rows=rows}end
end
function RammusChampion:TickTremorsProbe()
 local probe=self.tremorsProbe;if not probe then return end
 local now=Game.Timer();if now-probe.at>1.5 then Core:Trace('rammus_tremors_tick',{timeout=true});self.tremorsProbe=nil;return end
 local hits={}
 for _,row in ipairs(probe.rows)do local u=row.unit
  if u.handle==row.handle and finite(u.health)and u.health<row.health then hits[#hits+1]=math.floor(GetDistance(u.pos,myHero.pos))end
 end
 if #hits>0 then Core:Trace('rammus_tremors_tick',{delay=now-probe.at});Core:Trace('rammus_tremors_hits',{distances=hits,radius=self.profile.rRadius});self.tremorsProbe=nil end
end
function RammusChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Rammus: controls','Rammus: profiles'},function(page)
  return {title=page==1 and 'Rammus controls'or 'Rammus spell states',cards=page==1 and {
   {'MODES','Provider binds select Combo, Harass, lane/jungle, LastHit and Flee. Ability farming is one toggle and starts off.'},
   {'POWERBALL','Hold the Q bind for selected-target steering. Combo rolls into the target, ends the defensive stance to chase a target walking away when nothing is about to hit you, and rolls into another enemy the roll kills when the target cannot be reached; Harass does not roll unless you turn it on. Movement begins only after an observed cast and rolling state, and stops on obstacles or lost consent.'},
   {'R ASSIST','Hold the R bind for R. The bind needs only the selected target. Combo R needs its enemy count, or a single enemy when the landing kills it, when your roll carries it into the knock-up circle (Normal) or while it is taunted by you (Classic); the Normal escape R has its own switch. Safety and E mana reserve apply before mobility. Optional Flash then taunt reaches a target just out of E range.'}}or {
   {'TAUNT','E uses fresh range and taunt state. It interrupts channels (Normal also rolls into a channel out of E range), taunts an enemy dashing onto you or an ally next to you, and an enemy attacking an ally next to you; each has a switch. Normal rolling interruption needs the observed cancel stage; Classic cancellation remains unverified.'},
   {'STANCE','W answers an enemy champion\'s attack, targeted spell or skillshot that is about to hit you, also without a mode key (never in Flee or while rolling; minion and turret damage do not trigger it). While farming it answers the attack of the unit you fight. Q and W conflict and are never toggled blindly. Normal E damage applies only to monsters; Classic E applies its separate armor debuff.'},
   {'ULTIMATE','Normal predicts a safe Soaring Slam landing within the conservative base range. Classic Tremors checks its area around Rammus and never supplies a dash. Cast observation does not prove arrival or damage.'}}}
 end)
end
Core:StandardPolicy(RammusChampion,{damageTypes={Q='magical',E='magical'},
 channel=function(self,q)return not Core:SelfChanneling()or q.owner=='CancelRoll'and self:Ready(_Q,true)end,
 costPaid=function(self,q,slot)return slot==_Q and q.owner=='CancelRoll'and self:Ready(_Q,true)end,
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot,q.owner=='CancelRoll',q.owner=='PowerballChase')end;return true end})
RammusChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Rammus"]="Rammus"}
local normalSupported={["Rammus"]=true}

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
