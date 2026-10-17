return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Shen"]=function()return _G.OrbamaFamily:Require("52de5c6fbe34418e488e88918f33988cb4c3ab89534e62afa4fa3722c30ec1e8")()end
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
if champion=="Shen" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Shen',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent controller. Installed Normal and Classic kits share intentions,
-- geometry, resource gates and lifecycle, never their different Q/W mechanics.
local profiles=ChampionProfiles('Shen')
local finite,id,point,mine=Core.finite,Core.id,Core.point,Core.mine
-- Pinned by this champion's regressions: only a ready, in-range lethal attack keeps the spell (Core:Rescue).
local readyAttack={attack='ready'}
local function owned(u)
 if not u then return false end
 local found=false
 for _,key in ipairs({'owner','source','sourcenID','ownerID'})do local owner=u[key]
  if owner~=nil then
   if not mine(owner)then return false end
   found=true
  end
 end
 return found
end
local function cleanupFarm(self,reason)
 local p=self.farmPlan
 if p and p.action then Core.adapter:Cancel(p.action,reason)end
 if p and p.attack then Core.adapter:Cancel(p.attack,reason)end
 self.farmPlan=nil;Core.adapter:SetBlocked('ShenFarm','attack',false)
end
local function cleanupState(self,reason)
 cleanupFarm(self,reason)
 if self.rescue and self.rescue.action then Core.adapter:Cancel(self.rescue.action,reason)end
 self.rescue=nil;self.sword=nil;self.preview=nil;self.vorpal=nil;self.kiStrike=nil;self.attack=nil;self.qHold=nil;self.dashSample=nil
 if self.flashE then self.flashE:Cancel(reason)end
end
local ShenChampion=class("ShenChampion")
function ShenChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.scan=1;self:LoadMenu()
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 if Core.RegisterCleanup then Core:RegisterCleanup('Shen',function(reason)cleanupState(self,reason)end)end
 self:RegisterEvade()
end
function ShenChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Shen'})
 local classic=self.profile.qKind=='target'
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q',value=true})
  Menu[mode]:MenuElement({id='E',name='Use E (taunt dash into the target)',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='Mana',name='Only above energy %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
 -- Shen-6: Flash is never spent unless the player turns this on.
 Menu.Combo:MenuElement({id='EFlash',name='Flash then taunt a target just beyond E range',value=false})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  Menu.Clear[mode]:MenuElement({id='Q',name='Use Q',value=true})
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above energy %',value=20,min=0,max=100,step=5})
 end
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above energy %',value=15,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='EAssist',name='Cast E at the selected target',key=string.byte('U')})
 Menu.Misc:MenuElement({id='FleeE',name='Dash with E toward the cursor when fleeing',value=true})
 Menu.Misc:MenuElement({id='InterruptE',name='Taunt enemies who are channelling (E)',value=true})
 Menu.Misc:MenuElement({id='Gapclose',name='Taunt enemies who dash onto you or an ally (E)',value=true})
 if classic then Menu.Misc:MenuElement({id='WHP',name='Use W only below health %',value=70,min=1,max=100,step=5,menu=false})end
 Menu.Misc:MenuElement({id='ReserveE',name='Keep energy for E',value=true,menu=false})
 Menu.Misc:MenuElement({id='EEnemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R on an ally in danger',key=string.byte('T')})
 Menu.Misc:MenuElement({id='RHP',name='R only on allies below health %',value=35,min=1,max=100,step=5})
 Menu.Misc:MenuElement({id='REnemies',name='No R to an ally with more enemies than',value=3,min=0,max=5,step=1,menu=false})
 Menu.Misc:MenuElement({id='RSelfSafety',name='No R while enemies are next to you',value=true,menu=false})
 Menu.Misc:MenuElement({type=MENU,id='RTargets',name='Ally priority for R (0 = never)'})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='E',name='E range while E is ready',value=false})
 Menu.Draw:MenuElement({id='Plan',name=classic and 'R ally marker'or 'Spirit blade and R ally markers',value=true})
end
function ShenChampion:Cost(slot)local n=myHero:GetSpellData(slot).mana;return finite(n)and n>=0 and n or nil end
function ShenChampion:Ready(slot)
 local name=self.profile[({[0]='q',[1]='w',[2]='e',[3]='r'})[slot]]
 local s=myHero:GetSpellData(slot);local cost=self:Cost(slot)
 return name~=nil and s.name==name and IsReady(slot)and cost~=nil and myHero.mana>=cost
end
function ShenChampion:Budget(slot,reserve)
 if not self:Ready(slot)then return false end
 local cost=self:Cost(slot)
 if reserve and slot~=_E and Menu.Misc.ReserveE:Value()and myHero:GetSpellData(_E).level>0 then
  local e=self:Cost(_E);if not e then return false end;cost=cost+e
 end
 return cost<=myHero.mana
end
function ShenChampion:Buff(unit,name)return(Core:OwnBuff(unit,name,true))end
function ShenChampion:FreshSword(unit)
 return unit and not unit.dead and unit.team==myHero.team and type(unit.charName)=='string'
  and unit.charName:lower()=='shenspirit'and owned(unit)and point(unit.pos)~=nil and id(unit)~=nil
end
function ShenChampion:Sword()
 local sword=self.sword
 if not sword or not self:FreshSword(sword.object)or id(sword.object)~=sword.id then self.sword=nil;return nil end
 -- A retained wrapper must still resolve to the same object in the native list.
 local object=Game.Minion(sword.index)
 if object~=sword.object or id(object)~=sword.id or not self:FreshSword(object)then self.sword=nil;return nil end
 return object
end
function ShenChampion:DiscoverSword()
 if self.profile.qKind~='blade'then return end
 if self:Sword()then return end
 local n=Game.MinionCount();if not finite(n)or n<1 then self.scan=1;return end
 n=math.min(n,512)
 for i=1,math.min(n,24)do
  if self.scan>n then self.scan=1 end
  local index=self.scan;self.scan=self.scan+1;local u=Game.Minion(index)
  if self:FreshSword(u)then self.sword={object=u,id=id(u),index=index};return end
 end
end
function ShenChampion:Segment(a,b,p,radius)
 if not point(a)or not point(b)or not point(p)then return false end
 local dx,dz=b.x-a.x,b.z-a.z;local length=dx*dx+dz*dz;if length<1 then return false end
 local t=((p.x-a.x)*dx+(p.z-a.z)*dz)/length;if t<0 or t>1 then return false end
 local x,z=p.x-a.x-t*dx,p.z-a.z-t*dz;return x*x+z*z<=radius*radius
end
-- Where `u` stands `t` seconds from now along its current path (dash or walk).
function ShenChampion:PredictPoint(u,t)
 if not IsValid(u)or not point(u.pos)then return nil end;local p=u.pathing
 if not finite(t)or t<=0 or not p or not p.hasMovePath and not p.isDashing or not point(p.endPos)then return point(u.pos)end
 local speed=p.isDashing and p.dashSpeed or u.ms;if not finite(speed)or speed<=0 then return point(u.pos)end
 return point(u.pos:Extended(p.endPos,math.min(GetDistance(u.pos,p.endPos),speed*t)))
end
-- Shen-1: the pulled blade crosses `target` where it will stand when the blade passes it (blade speed 2000-5000,
-- wiki 2026-10-10: the slowest is assumed). `delay` looks further ahead for a crossing that is about to happen.
function ShenChampion:BladeCrosses(target,delay)
 local sword=self:Sword();if not sword or not IsValid(target)then return false end
 local at=self:PredictPoint(target,(delay or 0)+GetDistance(sword.pos,target.pos)/2000)
 return at~=nil and self:Segment(sword.pos,myHero.pos,at,110)
end
-- Any enemy champion (bounded) the pulled blade crosses: the champion hit slows it and doubles the empowerment.
function ShenChampion:CrossingEnemy()
 if self.profile.qKind~='blade'or not self:Sword()then return nil end
 local list=Core:Rows('hero',1500)
 for i=1,math.min(#list,5)do local u=list[i];if u.team~=myHero.team and self:BladeCrosses(u)then return u end end
end
-- Hold an attack-range Q for at most 1 s (anchored) while the selected target walks into the blade line.
function ShenChampion:HoldQ(target)
 local h=self.qHold;local now=Game.Timer()
 if h and(h.id~=id(target)or now>h.forget)then self.qHold=nil;h=nil end
 if h then return now<h.deadline end
 if self:BladeCrosses(target)or not(self:BladeCrosses(target,.5)or self:BladeCrosses(target,1))then return false end
 self.qHold={id=id(target),deadline=now+1,forget=now+3};return true
end
function ShenChampion:NormalQUseful(target)
 return self.profile.qKind=='blade'and IsValid(target)
  and(_G.SDK.Data:IsInAutoAttackRange(myHero,target)or target.type==Obj_AI_Hero and self:BladeCrosses(target))
  and not self:Buff(myHero,self.profile.qBuff)and not self:Buff(myHero,self.profile.qWeak)and not self:Buff(myHero,self.profile.qStrong)
end
function ShenChampion:CastQ(target,context,validate,priority)
 if not self:Budget(_Q,true)then return false end
 local normal=self.profile.qKind=='blade'
 if normal and not self:NormalQUseful(target)or not normal and not Core:Reach(target,self.profile.qRange)then return false end
 local ok=Core:Cast(HK_Q,not normal and target or nil,{intentTarget=target,context=context,priority=priority,deferAttackWindup=true,
  validate=function()
   return self:Budget(_Q,true)and(normal and self:NormalQUseful(target)or not normal and Core:Reach(target,self.profile.qRange))
    and(not validate or validate())
  end})
 if ok and not normal then
  local action=Core.lastIntent and Core.lastIntent.id;local targetID=id(target)
  if action then Core:AfterCast(HK_Q,function()
   self.vorpal={target=target,id=targetID,action=action,castObserved=true,expires=Game.Timer()+5}
  end)end
 end
 return ok
end
function ShenChampion:OnPostAttack(args)
 local witness=Core:AttackWitness(self.attack,args and args.Target)
 if not witness or witness==self.attack or witness.at>Game.Timer()then return end
 self.attack=witness
 local spell=myHero.activeSpell
 if self.profile.passiveAttack and spell and spell.name==self.profile.passiveAttack then
  self.kiStrike={at=witness.at,target=witness.id,castObserved=true}
 end
 -- Never infer a heal from an AA or a cast ledger. Healing is displayed only
 -- from the profile's owned native healing buff; no health/energy prediction.
end
function ShenChampion:ObserveMechanics()
 local p=self.vorpal
 if p and(p.expires<=Game.Timer()or id(p.target)~=p.id or not IsValid(p.target))then self.vorpal=nil end
 if self.profile.qKind=='target'then
  self.healObserved=self:Buff(myHero,self.profile.qMark)~=nil
  self.kiMarkerObserved=self:Buff(myHero,self.profile.passive)~=nil
 else
  local b=self:Buff(myHero,self.profile.qBuff)
  self.qCharges=b and b.count%1==0 and b.count<=3 and(b.stacks==nil or b.stacks==b.count)and b.count or nil
  self.qStrongObserved=self:Buff(myHero,self.profile.qStrong)~=nil
 end
end
function ShenChampion:GetQDmg(target)
 local rank=myHero:GetSpellData(_Q).level;if rank<1 or rank>5 or not IsValid(target)then return 0 end
 local raw
 if self.profile.qKind=='target'then raw=self.profile.qBase[rank]+self.profile.qAP*math.max(0,myHero.ap)
 else
  -- Flat part by champion level (asset breakpoints, profile qFlatByLevel); level-1 value when the level is unreadable.
  -- The champion-hit tier only while it is seen.
  local level=myHero.levelData and myHero.levelData.lvl
  local flat=finite(level)and self.profile.qFlatByLevel and self.profile.qFlatByLevel[math.max(1,math.min(18,math.floor(level)))]or self.profile.qFlat
  local strong=self:Buff(myHero,self.profile.qStrong)~=nil
  local percent=(strong and self.profile.qStrongPercent or self.profile.qPercent)[rank]
   +(strong and self.profile.qStrongPercentAP or self.profile.qPercentAP)*math.max(0,finite(myHero.ap)and myHero.ap or 0)/100
  raw=flat+percent*target.maxHealth
  if target.team==300 then raw=math.min(raw,self.profile.qCap[rank])end
 end
 return _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_MAGICAL,raw)
end
function ShenChampion:FarmUseful(target)
 local normal=self.profile.qKind=='blade';local range=normal and myHero.range+(target.boundingRadius or 0)+(myHero.boundingRadius or 0)or self.profile.qRange
 if not Core:Reach(target,range)or target.team==300 then return false end
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)or windup<0 then return false end
 -- Normal Q empowers the attack that follows it; Classic Q is its own projectile.
 return Core:Rescue(target,normal and .1+windup or self.profile.qDelay+GetDistance(target.pos,myHero.pos)/self.profile.qSpeed,
  self:GetQDmg(target)+(normal and _G.SDK.Damage:CalculateDamage(myHero,target,_G.SDK.DAMAGE_TYPE_PHYSICAL,math.max(0,myHero.totalDamage))or 0),readyAttack)
end
function ShenChampion:FarmQ(node,context,jungle)
 if self.farmPlan then return false end
 if not node.Q:Value()or not Core.manaAbove(node.Mana:Value())or not self:Budget(_Q,true)then return false end
 local range=self.profile.qRange or 300;local list=jungle and _G.SDK.ObjectManager:GetMonsters(range)or _G.SDK.ObjectManager:GetEnemyMinions(range);local best
 for i=1,math.min(#list,jungle and 12 or 40)do local u=list[i]
  if Core:Reach(u,range)and(jungle or self:FarmUseful(u))and(not best or u.maxHealth>best.maxHealth)then best=u end
 end
 if best then
  if not jungle and self.profile.qKind=='blade'then
   if Core:AttackWindupRemaining()>0 or not _G.SDK.Orbwalker:CanAttack()then return false end
   local p={target=best,id=id(best),context=context,expires=Game.Timer()+.9};self.farmPlan=p
   local ok=self:CastQ(best,context,function()return self.farmPlan==p and self:FarmUseful(best)end,'normal')
   if not ok then self.farmPlan=nil;return false end
   p.action=Core.lastIntent.id;Core.adapter:SetBlocked('ShenFarm','attack',true)
   Core:AfterCast(HK_Q,function()if self.farmPlan==p then p.observed=true end end)
   return true
  end
  return self:CastQ(best,context,not jungle and function()return self:FarmUseful(best)end or nil,not jungle and 'normal'or nil)
 end
end
function ShenChampion:ContinueFarm()
 local p=self.farmPlan;if not p then return false end
 local r=Core.adapter:Poll(p.action)
 if not r or r.jobCancelled or r.state=='cancelled_before_send'or p.expires<=Game.Timer()or id(p.target)~=p.id
  or not Core.adapter:ContextValid({context=p.context},'continuation')or not self:FarmUseful(p.target)then cleanupFarm(self,'farm_ended');return false end
 -- The empowerment was absent when Q was admitted (NormalQUseful), so its
 -- presence after the send is fresh evidence of the cast even when the slot's
 -- state change was not seen; attacks otherwise stayed blocked to the expiry.
 if not(p.observed or r.sentAt)or not(self:Buff(myHero,self.profile.qBuff)or self:Buff(myHero,self.profile.qWeak)or self:Buff(myHero,self.profile.qStrong))then return true end
 p.observed=true
 Core.adapter:SetBlocked('ShenFarm','attack',false)
 if p.attack then
  if not Core.pending['__owned_attack']then self.farmPlan=nil end
  return true
 end
 if not _G.SDK.Orbwalker:CanAttack()then return true end
 local ok=Core:Attack(p.target,{owner='QFarm',context=p.context,priority='normal',ttl=150,
  validate=function()
   return self.farmPlan==p and p.observed and(self:Buff(myHero,self.profile.qBuff)or self:Buff(myHero,self.profile.qWeak)or self:Buff(myHero,self.profile.qStrong))
    and self:FarmUseful(p.target)
  end,
  observe=function(q)
   local a=Core:NativeAttack(q,'ShenQAttack')
   return a
    and(a.target==p.target.handle or a.target==p.target.networkID)
  end})
 if ok then p.attack=Core.lastIntent.id end
 return true
end
function ShenChampion:LaneClear()
 if not Core:FarmModeEnabled('lane')or not Menu.Clear.SpellFarm:Value()then return false end
 return self:FarmQ(Menu.Clear.LaneClear,Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end),false)
end
function ShenChampion:JungleClear()
 if not Core:FarmModeEnabled('jungle')or not Menu.Clear.SpellFarm:Value()then return false end
 return self:FarmQ(Menu.Clear.JungleClear,Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end),true)
end
function ShenChampion:LastHit()return self:FarmQ(Menu.LastHit,Core:ModeContext('LastHit'),false)end
function ShenChampion:Endpoint(goal)
 local p=point(goal);if not p then return nil end;local distance=GetDistance(p,myHero.pos)
 if distance<1 then return nil end
 -- Both installed E kits enforce a minimum 300-unit dash. Close peel remains
 -- possible by aiming through the nearby target, then validating that landing.
 return myHero.pos:Extended(p,math.max(300,math.min(distance,self.profile.eRange)))
end
function ShenChampion:SafeEndpoint(p)
 return point(p)and GetDistance(p,myHero.pos)>=299.99 and GetDistance(p,myHero.pos)<=self.profile.eRange+.01
  and type(Game.isWall)=='function'and Game.isWall(p)==false and not IsUnderTurret2(p)
  and GetEnemyCount(600,p)<=Menu.Misc.EEnemies:Value()
end
-- Shen-2: where a moving target will be when the taunt dash reaches it (line, slowest dash speed, longest
-- declared delay, 100 corridor); the current position when no confident prediction exists.
function ShenChampion:Lead(target)
 local s=self.eLine
 if not s then local d=0;for _,v in ipairs(self.profile.eDelays)do d=math.max(d,v)end
  s={Type=OrbamaPrediction.SPELLTYPE_LINE,Range=self.profile.eRange,Radius=100,Delay=d,Speed=self.profile.eSpeeds[1],Collision=false};self.eLine=s end
 local pred=Core:Prediction(s);pred:GetPrediction(target,myHero)
 local p=pred:CanHit(2)and point(pred.CastPosition)
 if p and GetDistance(p,myHero.pos)<=self.profile.eRange then return p end
 return point(target.pos)
end
-- `through()` names the point the corridor must cross (Shen-4: a dash landing); by default the target's lead.
function ShenChampion:Dash(goal,target,context,through)
 if not self:Ready(_E)then return false end
 local targetID=id(target)
 local function cross()if not target then return nil end;if through then return through()end;return self:Lead(target)end
 local function legal(aim,pass)
  return self:Ready(_E)and self:SafeEndpoint(aim)and(not target or id(target)==targetID and point(pass)~=nil
   and(through and GetDistance(pass,myHero.pos)<=self.profile.eRange or not through and Core:Reach(target,self.profile.eRange))
   and self:Segment(myHero.pos,aim,pass,100))
 end
 local pass=cross();local p=self:Endpoint(pass or goal)
 if not legal(p,pass)then return false end
 local ok=Core:Cast(HK_E,p,{intentTarget=target,context=context,owner='Taunt',independent=false,prevalidateWorldCast=true,
  resolve=function()local now=cross();local aim=self:Endpoint(now or goal);if not legal(aim,now)then return nil,'dash_geometry_changed'end;return {position=aim,through=now}end,
  validate=function(q,resolved)return legal(resolved and resolved.position or q.target,resolved and resolved.through or target and point(target.pos))end})
 -- Shen-5: dev-recorder evidence for the dash length (Classic asset 575 vs wiki 600): where an observed
 -- E started and where Shen stood once the dash ended. A trace only; no decision reads it.
 if ok then Core:AfterCast(HK_E,function()self.dashSample={from=point(myHero.pos),aim=p,at=Game.Timer()}end)end
 return ok
end
function ShenChampion:TraceDash()
 local s=self.dashSample;if not s then return end;local path=myHero.pathing
 if Game.Timer()-s.at<.15 or path and path.isDashing and Game.Timer()-s.at<1.5 then return end
 Core:Trace('shen_e_distance',{profile=self.profile.id,distance=GetDistance(myHero.pos,s.from),aim=GetDistance(s.aim,s.from),range=self.profile.eRange})
 self.dashSample=nil
end
function ShenChampion:Combat(mode)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return false end
 local q=node.Q:Value()and self:Budget(_Q,true);local dash=node.E:Value()and self:Ready(_E)
 if not q and not dash then return false end
 local target=GetTarget(dash and self.profile.eRange or self.profile.qRange or 600);if not IsValid(target)then return false end
 local context=Core:ModeContext(mode)
 if q and self.profile.qKind=='blade'then
  local crossing=self:CrossingEnemy()
  if crossing and self:CastQ(crossing,context)then return true end
  if self:HoldQ(target)then q=false end
 end
 if q and self:CastQ(target,context)then return true end
 if dash then
  if self:Dash(target.pos,target,Core:ModeContext(mode,function()return node.E:Value()end))then return true end
  -- Shen-6: only a champion beyond E range (EFlash checks the distance) is a Flash target.
  if mode=='Combo'and Menu.Combo.EFlash:Value()then local far=GetTarget(self.profile.eRange+400);return IsValid(far)and self:EFlash(far)or false end
 end
end
-- Shen-6: Flash toward a champion just beyond E range, then taunt it once Shen stands at the Flash landing
-- (Core:FlashFollow flash_first: a dash continuing after a mid-dash Flash is not measured, a Flash landing is).
function ShenChampion:EFlash(target)
 if not Menu.Combo.EFlash:Value()or not IsValid(target)or target.type~=Obj_AI_Hero or not self:Ready(_E)then return false end
 if self.flashE and self.flashE:Busy()then return false end
 local status=Core:FlashStatus();if not status then return false end
 local d=GetDistance(target.pos,myHero.pos);if d<=self.profile.eRange or d>self.profile.eRange+status.range-50 then return false end
 local cost=self:Cost(_E);if not cost then return false end
 self.flashE=self.flashE or Core:FlashFollow('ShenFlashE');local handle=target.handle
 local function authorized()return Menu.Combo.EFlash:Value()and GetMode()=='Combo'and target.handle==handle and IsValid(target)end
 return self.flashE:Start{order='flash_first',aim=myHero.pos:Extended(target.pos,status.range),mana=cost,authorized=authorized,ttl=1.2,
  valid=function(landing)
   if not authorized()or GetDistance(target.pos,landing)>self.profile.eRange-25 then return false end
   local length=GetDistance(target.pos,landing);if length<1 then return false end
   local reach=math.max(300,math.min(length,self.profile.eRange))
   local finish={x=landing.x+(target.pos.x-landing.x)/length*reach,y=landing.y or 0,z=landing.z+(target.pos.z-landing.z)/length*reach}
   return type(Game.isWall)=='function'and Game.isWall(finish)==false and not IsUnderTurret2(finish)and GetEnemyCount(600,finish)<=Menu.Misc.EEnemies:Value()
  end,
  follow=function(context)return self:Dash(target.pos,target,context)end}
end
-- Shen-4: an enemy champion whose dash lands within 400 of Shen or an ally is taunted through that landing,
-- with every Dash bound (wall, enemy turret, enemy count). No mode key.
function ShenChampion:Gapclose()
 if not Menu.Misc.Gapclose:Value()or not self:Ready(_E)then return false end
 local enemies=Core:Rows('hero',self.profile.eRange+1200);local allies=self:Allies()
 for i=1,math.min(#enemies,5)do local u=enemies[i]
  if u.team~=myHero.team then
   for j=1,math.min(#allies,5)do local ally=allies[j]
    if GetDistance(ally.pos,myHero.pos)<=self.profile.eRange+400 then
     local snapshot=Core:DashLanding(u,ally.pos,400,true)
     if snapshot and point(snapshot.to)and GetDistance(snapshot.to,myHero.pos)<=self.profile.eRange then
      local function landing()local s=Core:DashLanding(u,ally.pos,400,true);if s and point(s.to)then return point(s.to)end
       if GetDistance(u.pos,ally.pos)<=400 then return point(u.pos)end end
      if self:Dash(snapshot.to,u,{priority='interactive',condition=function()return Menu.Misc.Gapclose:Value()and landing()~=nil end},landing)then return true end
     end
    end
   end
  end
 end
 return false
end
-- Classic Vorpal Blade is a targeted nuke: a champion it kills is finished without a mode key.
function ShenChampion:Finisher()
 if self.profile.qKind~='target'or not self:Ready(_Q)then return false end
 local list=Core:Rows('hero',self.profile.qRange)
 for i=1,#list do local u=list[i]
  local function kills()return Core:Reach(u,self.profile.qRange)and Core:Lethal(u,self.profile.qDelay+GetDistance(u.pos,myHero.pos)/self.profile.qSpeed,function()return self:GetQDmg(u)end,{kind='magical'})end
  if kills()then local handle=u.handle
   return Core:Cast(HK_Q,u,{owner='Finisher',priority='interactive',intentTarget=u,validate=function()return self:Ready(_Q)and u.handle==handle and kills()end})
  end
 end
 return false
end
-- The taunt stops a channel. It is still a dash into the enemy, so every Dash
-- bound applies (wall, enemy turret, enemy count at the landing).
function ShenChampion:Interrupt()
 if not Menu.Misc.InterruptE:Value()or not self:Ready(_E)then return false end
 local list=Core:Rows('hero',self.profile.eRange)
 for i=1,#list do local u=list[i];local a=u.activeSpell
  local function channel()return Core:CanInterrupt(u,GetDistance(u.pos,myHero.pos)/self.profile.eSpeeds[1]+self.profile.eDelays[#self.profile.eDelays])end
  if a and channel()then local start,name=a.startTime,a.name
   if self:Dash(u.pos,u,{priority='interactive',condition=function()local c=u.activeSpell
    return Menu.Misc.InterruptE:Value()and c and c.startTime==start and c.name==name and channel()end})then return true end
  end
 end
 return false
end
function ShenChampion:Combo()return self:Combat('Combo')end
function ShenChampion:Harass()return self:Combat('Harass')end
function ShenChampion:Flee()
 if Menu.Misc.FleeE:Value()and not self.fleeUsed and self:Dash(mousePos,nil,Core:ModeContext('Flee',function()return Menu.Misc.FleeE:Value()end))then self.fleeUsed=true;return true end
end
function ShenChampion:Allies()
 return Core:DecisionValue('Shen:allies',function()
  local list={};local n=math.min(Game.HeroCount(),16)
  for i=1,n do local u=Game.Hero(i);if u and u.team==myHero.team and IsValid(u)then list[#list+1]=u end end
  return list
 end)
end
-- Real incoming damage only (Core:AllyThreat; never proximity or minion attacks).
-- Normal W blocks basic attacks, so only a champion's attack on its way counts.
-- Classic Feint is a plain shield: an attack, a targeted cast, a tracked
-- skillshot or a turret shot on Shen all count.
function ShenChampion:IncomingAttack(target)
 if self.profile.qKind=='target'then return Core:AllyThreat(target,1.5)~=nil end
 return Core:AllyThreat(target,.75,{casts=false,turrets=false,skillshots=false})~=nil
end
function ShenChampion:FeintValue()
 local base=self.profile.wBase and self.profile.wBase[myHero:GetSpellData(_W).level]
 return base and finite(myHero.ap)and base+self.profile.wAP*math.max(0,myHero.ap)or 0
end
-- Evade offers. Shadow Dash is a point dash with a 300 minimum; Evade judges the
-- danger, so neither the mode switches nor the enemy-count limit apply (walls
-- still refuse). Classic Feint is a timed shield; Normal W blocks attacks only
-- and is not an answer to a spell, so it is not offered.
function ShenChampion:RegisterEvade()
 local p=self.profile
 self.mobilityOffered,self.mobilityReason=Core:RegisterMobility({kind='dash',slot=_E,key=HK_E,name=p.e,range=p.eRange,speeds=p.eSpeeds,castDelays=p.eDelays,toPoint=true,
  profile=p.id,label='Shadow Dash',source=p.eSource,allowed=function(target)
   if self.rescue or self:ChannelObserved()then return false,'stand_united'end
   if target==nil then return true end
   local d=GetDistance(target,myHero.pos)
   if d<p.eMin-.01 or d>p.eRange+.01 then return false,'outside_dash_length'end
   return type(Game.isWall)=='function'and Game.isWall(target)==false,'wall'
  end})
 if p.qKind=='target'and Core.RegisterShield then
  self.shieldOffered,self.shieldReason,self.shieldDefense=Core:RegisterShield({name='Shen.W',slot=_W,key=HK_W,profile=p.id,spell=p.w,source=p.wSource,
   amount=function()return self:FeintValue()end,duration=p.wDuration,delay=0,ready=function()return not self.rescue and not self:ChannelObserved()end})
 end
end
function ShenChampion:WRecipient()
 if not self:Budget(_W,true)then return nil end
 if self.profile.qKind=='target'then
  return myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100<=Menu.Misc.WHP:Value()and self:IncomingAttack(myHero)and myHero or nil
 end
 if self:Buff(myHero,self.profile.wBuff)then return nil end
 local sword=self:Sword();if not sword then return nil end
 local allies=self:Allies();for i=1,#allies do local u=allies[i]
  if GetDistance(u.pos,sword.pos)<=self.profile.wRadius and self:IncomingAttack(u)then return u end
 end
end
function ShenChampion:DefendW()
 local ally=self:WRecipient();if not ally then return false end
 return Core:Cast(HK_W,nil,{owner='Defense',priority='critical',
  intentTarget=ally,validate=function()return self:WRecipient()==ally end})
end
function ShenChampion:RUseful(ally)
 if not ally or ally==myHero or not IsValid(ally)or ally.team~=myHero.team or ally.maxHealth<=0
  or ally.health/ally.maxHealth*100>Menu.Misc.RHP:Value()then return false end
 if Menu.Misc.RSelfSafety:Value()and GetEnemyCount(600,myHero.pos)>0 then return false end
 if GetEnemyCount(900,ally.pos)==0 or GetEnemyCount(600,ally.pos)>Menu.Misc.REnemies:Value()then return false end
 return point(ally.pos)and type(Game.isWall)=='function'and Game.isWall(ally.pos)==false and not IsUnderTurret2(ally.pos)
end
function ShenChampion:RPriority(ally)
 local name=ally and ally.charName
 if type(name)~='string'or not name:match('^[%w_]+$')then return 0 end
 if not Menu.Misc.RTargets[name]then Menu.Misc.RTargets:MenuElement({id=name,name=name,value=3,min=0,max=5,step=1})end
 return Menu.Misc.RTargets[name]:Value()
end
function ShenChampion:RBest()
 local allies=self:Allies();local best,priority
 for i=1,#allies do local u=allies[i]
  if self:RUseful(u)then local weight=self:RPriority(u)
   if weight>0 and(not best or weight>priority or weight==priority and u.health/u.maxHealth<best.health/best.maxHealth)then best,priority=u,weight end
  end
 end
 return best
end
function ShenChampion:RCandidate()
 if not self:Ready(_R)then return nil end;local u=self:RBest()
 return u and {unit=u,name=u.charName,handle=u.handle}or nil
end
function ShenChampion:AssistR()
 if not Menu.Misc.RAssist:Value()then self.rescueUsed=false;return false end
 if self.rescue or self.rescueUsed or not self:Ready(_R)then return false end
 local best=self:RBest()
 if not best then return false end
 local p={target=best,id=id(best),expires=Game.Timer()+4.5,context=Core:HeldContext(function()return Menu.Misc.RAssist:Value()end)};self.rescue=p
 local ok=Core:Cast(HK_R,best,{owner='Rescue',priority='interactive',context=p.context,
  independent=false,validate=function()return self.rescue==p and id(best)==p.id and self:Ready(_R)and self:RUseful(best)and self:RPriority(best)>0 end})
 if not ok then self.rescue=nil;return false end
 p.action=Core.lastIntent.id;self.rescueUsed=true
 Core:AfterCast(HK_R,function()if self.rescue==p then p.observed=true end end)
 return true
end
function ShenChampion:ChannelObserved()
 local cast=myHero.activeSpell
 return cast and cast.valid and not cast.isStopped and cast.name==self.profile.r
  and finite(cast.startTime)and finite(cast.castEndTime)and cast.startTime<=Game.Timer()
  and cast.castEndTime>Game.Timer()and cast.castEndTime-cast.startTime>=2.9
end
function ShenChampion:ContinueRescue()
 local p=self.rescue;local channel=self:ChannelObserved()
 -- Mechanical channel is authoritative even if the player's held request was
 -- released. No artificial attack/movement lock is retained after release.
 if not p then return channel end
 local result=Core.adapter:Poll(p.action)
 if not result or result.jobCancelled or p.expires<=Game.Timer()or id(p.target)~=p.id or not IsValid(p.target)
  or not Core.adapter:ContextValid({context=p.context},'continuation')or not Menu.Misc.RAssist:Value()or ShouldWait()then self:Cleanup('rescue_ended');return channel end
 if p.observed and channel then p.channelSeen=true end
 if p.channelSeen and not channel then self.rescue=nil;return false end
 -- An observed R whose channel never shows (interrupted at once, or not shown
 -- by the host) gives the tick back after 0.5 s instead of at the 4.5 s expiry.
 if p.observed and not channel and not p.channelSeen then p.observedAt=p.observedAt or Game.Timer()
  if Game.Timer()-p.observedAt>.5 then self.rescue=nil;return false end
 end
 if result.state=='cancelled_before_send'then self.rescue=nil;return false end
 return true
end
function ShenChampion:Cleanup(reason)
 cleanupState(self,reason)
end
function ShenChampion:Tick()
 if ShouldWait()then self:Cleanup('unavailable');return end
 local mode=GetMode();if mode~='Flee'then self.fleeUsed=false end
 if not Menu.Misc.EAssist:Value()then self.assistUsed=false end
 if not Menu.Misc.RAssist:Value()then self.rescueUsed=false end
 if self:ContinueRescue()or IsCasting()then return end
 self:ObserveMechanics()
 self:TraceDash()
 self:DiscoverSword()
 if self.flashE and self.flashE:Maintain()then return end
 if self:AssistR()or self:DefendW()or self:Finisher()or self:Interrupt()or self:Gapclose()then return end
 if self:ContinueFarm()then return end
 if Menu.Misc.EAssist:Value()and not self.assistUsed then
  local target=GetTarget(self.profile.eRange)
  if IsValid(target)and self:Dash(target.pos,target,Core:HeldContext(function()return Menu.Misc.EAssist:Value()end))then self.assistUsed=true;return end
 end
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()elseif mode=='LaneClear'then
  if Core:FarmModeEnabled('lane')and self:LaneClear()then return end
  if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if Menu.Draw.Plan:Value()then local sword=self:Sword();local candidate=self.preview and self.preview.candidate;local next=self.preview and self.preview.nextCandidate or 0
  -- Shen-3: the ally the rescue bind would take, refreshed four times a second for the drawing only.
  if Game.Timer()>=next then candidate=self:RCandidate();next=Game.Timer()+.25 end
  self.preview={sword=sword and point(sword.pos),candidate=candidate,nextCandidate=next}
 end
end
function ShenChampion:Draw()
 if myHero.dead then return end
 if Menu.Draw.E:Value()and IsReady(_E)then Draw.Circle(myHero.pos,self.profile.eRange,1,Draw.Color(255,100,200,255))end
 if Menu.Draw.Plan:Value()then
  if self.rescue then Draw.Circle(self.rescue.target.pos,100,1,Draw.Color(255,100,255,100))end
  if self.preview and self.preview.sword then Draw.Circle(self.preview.sword,self.profile.wRadius,1,Draw.Color(255,120,200,255))end
  local c=self.preview and self.preview.candidate
  if c and not self.rescue and c.unit.handle==c.handle and not c.unit.dead then
   Draw.Circle(c.unit.pos,120,2,Draw.Color(255,255,220,80))
  end
 end
end
function ShenChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Shen: modes','Shen: rescue and defense'},function(page)
  return {title='Shen assistance',cards=page==1 and {
   {'MODES','Use provider Combo, Harass, lane/jungle, LastHit and Flee binds. Ability farming is one toggle and starts off.'},
   {'Q','Normal pulls the observed owned blade through any enemy champion it will cross (slow and stronger attacks), briefly waiting for the target to walk into the line, else empowers attacks. Classic casts Vorpal Blade directly and applies its healing mark.'},
   {'ENERGY','Q and W can preserve the cost of an escape E. Combo taunts with E inside the enemy limit; Harass keeps it unless you turn it on.'}}or {
   {'TAUNT','Hold the taunt bind for a safe taunt; the dash leads a moving target. Close targets can be crossed by the full minimum dash. Unknown terrain refuses the dash. An enemy who is channelling, or who dashes onto you or an ally, is taunted without a mode key, inside the same limits. Combo can Flash then taunt a target just beyond E range when you turn that on.'},
   {'DEFENSE','Normal W needs the actual owned blade and an enemy champion\'s basic attack on an ally in its zone. Classic Feint shields Shen against an incoming attack, targeted spell, skillshot or turret shot, and finishes a killable enemy with Q. Evade may use Shadow Dash and Classic Feint.'},
   {'RESCUE','Hold the rescue bind to assist Stand United on a threatened low-health ally visible on screen; the ally it would take is marked and named next to Shen. Off-screen casts are refused. Releasing cancels queued work; observed channels do not imply arrival.'}},note='R remains a player-authorized global action.'}
 end)
end
Core:StandardPolicy(ShenChampion,{damageTypes={Q='magical'},channel=function(self)return not self:ChannelObserved()and not Core:SelfChanneling()end})
ShenChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Shen"]="Shen"}
local normalSupported={["Shen"]=true}

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
