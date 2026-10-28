return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Amumu"]=function()return _G.OrbamaFamily:Require("b97377aa8fa73842ed03f344fd1a762b20c301a7687d9fab3f4ba2b406a9b6c1")()end
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
modules["combatMechanics"]=_G.OrbamaFamily:Require("9b0f0ca4dc10e89ac5153be241244434028523e5505df6b650ac40f1e6f736d3")
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
if champion=="Amumu" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Amumu',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent implementation. Installed asset candidates and unresolved server
-- mechanics are documented in CombatProfiles/amumu-provenance.json.
local profiles=ChampionProfiles('Amumu')
local finite,id,point=Core.finite,Core.id,Core.point
local function cleanup(self,reason)
 local p=self.wPlan;if p and p.action then Core.adapter:Cancel(p.action,reason or 'controller_closed')end
 self.wPlan=nil;self.wOwned=nil;self.attack=nil;self.preview=nil
end
local AmumuChampion=class("AmumuChampion")
function AmumuChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.wReach=math.max(self.profile.wRadius,self.profile.wReach or 0);self:LoadMenu();self.qConsent={};self:RefreshQConsent()
  local geometry=AbilityProfiles.geometry[myHero.charName]
  self.QRange=1100;self.ERange=geometry.E.range;self.RRange=geometry.R.range
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=80,Range=1100,Speed=2000,Collision=true,MaxCollision=0,
  CollisionTypes={OrbamaPrediction.COLLISION_MINION,OrbamaPrediction.COLLISION_ENEMYHERO,OrbamaPrediction.COLLISION_YASUOWALL}}
  self.ESpell=AbilityProfiles.Spell(myHero.charName,'E',OrbamaPrediction)
  self.RSpell=AbilityProfiles.Spell(myHero.charName,'R',OrbamaPrediction)
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Amumu',function(reason)cleanup(self,reason)end)
 local registered,reason=Core:RegisterPreparation('Amumu.preview',{intervalMs=100,maxDelayMs=400,units=2,maxUnits=2},
  function()self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.preparation=registered;self.previewFallback=not registered and reason=='unsupported'
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u)end)
end
function AmumuChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Amumu'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  -- Q pulls Amumu onto its target: the engage belongs to Combo, not to poking.
  for _,slot in ipairs({'Q','W','E'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=slot~='Q'or mode=='Combo'})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='R',name='Use R',value=true})
 Menu.Combo:MenuElement({id='RCount',name='Enemy champions R must hit',value=2,min=1,max=5,step=1})
 if self.profile.charges>0 then Menu.Harass:MenuElement({id='ReserveCharge',name='Keep one Q charge',value=true})end
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,mode in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=mode,name=mode=='LaneClear'and 'Lane clear'or 'Jungle clear'})
  for _,slot in ipairs({'Q','W','E'})do Menu.Clear[mode]:MenuElement({id=slot,name=mode=='LaneClear'and slot=='Q'and 'Use Q when an attack cannot last hit'or 'Use '..slot,value=true})end
  Menu.Clear[mode]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Minions near you for W and E',value=3,min=1,max=10,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='Last hit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q when no attack or E can (pulls you in)',value=true})
 Menu.LastHit:MenuElement({id='E',name='Use E when an attack cannot last hit',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=15,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({type=MENU,id='QTargets',name='Enemy champions Q may target'})
 Menu.Misc:MenuElement({id='QAssist',name='Cast Q at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='QHP',name='Never Q in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='QEnemies',name='Never Q into more enemies than',value=3,min=0,max=5,step=1})
 Menu.Misc:MenuElement({id='ReserveE',name='Keep mana for E after an engaging Q',value=true,menu=false})
 Menu.Misc:MenuElement({id='WMana',name='W only above mana %',value=15,min=0,max=100,step=5,menu=false})
 Menu.Misc:MenuElement({id='InterruptQ',name='Interrupt enemy channels with Q while fighting',value=true})
 if self.profile.rInterrupt then Menu.Misc:MenuElement({id='InterruptR',name='Interrupt enemy channels with R while fighting',value=false})end
 Menu.Misc:MenuElement({id='AutoR',name='Cast R without holding a mode key',value=true})
 Menu.Misc:MenuElement({id='AutoRCount',name='Enemy champions that R must hit',value=3,min=2,max=5,step=1})
 Menu.Misc:MenuElement({id='RFinish',name='Finish kills with R without a mode key',value=true})
 Menu.Misc:MenuElement({id='GapQ',name='Stun enemies that dash onto me with Q',value=true})
 Menu.Misc:MenuElement({id='FleeQ',name='Flee: Q to a unit towards the cursor',value=true})
 Menu.Misc:MenuElement({id='FleeR',name='Flee: R enemies next to you',value=false})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Preview',name='How many enemies R would hit',value=true})
end
function AmumuChampion:RefreshQConsent()
 local list=_G.SDK.ObjectManager:GetEnemyHeroes(2500)
 for i=1,math.min(#list,5)do local u=list[i];local identity=id(u)
  if identity and type(u.charName)=='string'and not self.qConsent[identity]then
   local key=StableUnitMenuKey(self,'Q',u)
   Menu.Misc.QTargets:MenuElement({id=key,name='Allow Q: '..u.charName,value=true})
   self.qConsent[identity]=Menu.Misc.QTargets[key]
  end
 end
 self.nextConsent=Game.Timer()+1
end
function AmumuChampion:QAllowed(u)
 if u.type~=Obj_AI_Hero then return true end
 local node=self.qConsent[id(u)]
 return node~=nil and node:Value()==true
end
function AmumuChampion:Reach(u,range)return IsValid(u)and u.team~=myHero.team and GetDistance(u.pos,myHero.pos)<=range end
function AmumuChampion:Current(u)
 if not IsValid(u)or not id(u)then return false end
  local list=u.type==Obj_AI_Hero and Core:DecisionUnits('GetEnemyHeroes')
   or self:NPCRows(u.team==300 and 'jungle'or 'lane',1500)
 local bound=u.type==Obj_AI_Hero and 5 or u.team==300 and 12 or 40
 for i=1,math.min(#list,bound)do local v=list[i];if id(v)==id(u)and v.handle==u.handle and IsValid(v)then return true end end
 return false
end
function AmumuChampion:Ready(slot,off)
 local name=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot];local d=myHero:GetSpellData(slot)
 if not name or not d or d.name~=self.profile[name]then return false,'unsupported_spell_stage'end
 if not finite(d.level)or d.level<1 then return false,'spell_unlearned'end
 if not finite(d.currentCd)or d.currentCd>0 or Game.CanUseSpell(slot)~=0 then return false,'spell_not_ready'end
 if not finite(d.mana)or d.mana<0 or(not off and d.mana>myHero.mana)then return false,'native_cost_unavailable'end
 if slot==_Q and self.profile.charges>0 and(not finite(d.ammo)or d.ammo%1~=0 or d.ammo<1 or d.ammo>2)then return false,'q_charges_unknown_or_empty'end
 if slot==_W and d.toggleState~=1 and d.toggleState~=2 then return false,'w_toggle_unknown'end
 return true
end
function AmumuChampion:Passive(u)
 if not u or not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 then return nil,'buff_snapshot_unknown'end
 for i=0,u.buffCount do local b=u:GetBuff(i)
  if b and b.name==self.profile.passive and finite(b.count)and b.count>0 then
   local source=b.source;if type(source)=='table'or type(source)=='userdata'then source=id(source)end
   local expiry=Core.buffExpiry(b)
   if (source==myHero.networkID or source==myHero.handle or b.sourcenID==myHero.networkID or b.sourcenID==myHero.handle)
    and(not source or source==0 or source==myHero.networkID or source==myHero.handle)
    and(not b.sourcenID or b.sourcenID==0 or b.sourcenID==myHero.networkID or b.sourcenID==myHero.handle)
    and finite(expiry)and expiry>Game.Timer()then return b,self.profile.passiveKind end
  end
 end
end
function AmumuChampion:Damage(u,slot)
 local rank=myHero:GetSpellData(slot).level;local base=slot==_Q and self.profile.qBase[rank]or slot==_E and self.profile.eBase[rank]or self.profile.rBase[rank]
 if not base or not finite(myHero.ap)then return 0 end
 -- Native MR already reflects Classic Cursed Touch. Normal bonus true damage
 -- is excluded until its exact host damage/mark timing is live measured.
  return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+(slot==_Q and self.profile.qAP or slot==_E and self.profile.eAP or self.profile.rAP)*myHero.ap)
end
function AmumuChampion:GetQDmg(u)return self:Damage(u,_Q)end
function AmumuChampion:GetEDmg(u)return self:Damage(u,_E)end
function AmumuChampion:GetRDmg(u)return self:Damage(u,_R)end
function AmumuChampion:SafeQ(pos,offense)
 if not point(pos)or type(Game.isWall)~='function'or Game.isWall(pos)~=false or IsUnderTurret2(pos)
  or GetEnemyCount(600,pos)>Menu.Misc.QEnemies:Value()then return false,'q_landing_unsafe_or_unknown'end
 if offense and(myHero.maxHealth<=0 or myHero.health/myHero.maxHealth*100<Menu.Misc.QHP:Value())then return false,'q_health_policy'end
 -- The E reserve belongs to an engage; an escape or a rescued minion needs only the Q, and
 -- a kill Q (offense='kill', the target dies at impact) needs no follow-up.
 if offense and offense~='kill'and Menu.Misc.ReserveE:Value()then local d=myHero:GetSpellData(_E)
  if not d or not finite(d.mana)or d.mana<0 or myHero:GetSpellData(_Q).mana+d.mana>myHero.mana then return false,'q_followup_budget'end
 end
 return true
end
function AmumuChampion:CastQ(u,context,permission,offense)
 if not self:Ready(_Q)or not self:Reach(u,1100)or not self:Current(u)or not self:QAllowed(u)or not self:QUnprotected(u)or not self:SafeQ(u.pos,offense)or(permission and not permission())then return false end
 local handle=u.handle;local pred=Core:Prediction(self.QSpell);pred:GetPrediction(u,myHero)
 if not pred:CanHit(2)or not point(pred.CastPosition)then return false end
 return Core:Cast(HK_Q,pred.CastPosition,{intentTarget=u,context=context,range=1100,prevalidateWorldCast=true,deferAttackWindup=true,
  validate=function(_,resolved)return self:Ready(_Q)and u.handle==handle and self:Current(u)and self:Reach(u,1100)and self:QAllowed(u)and self:QUnprotected(u)
   and self:SafeQ(u.pos,offense)and self:SafeQ(resolved and resolved.position or pred.CastPosition,offense)and(not permission or permission())end})
end
-- A spell shield or invulnerability wastes the stun and the pull (Amumu-7). An
-- unknown buff state (nil) is refused as well.
function AmumuChampion:QUnprotected(u)return u.type~=Obj_AI_Hero or Core:SpellProtected(u)==false end
function AmumuChampion:CastE(u,context,permission)
 if not self:Ready(_E)or not self:Reach(u,350)or not self:Current(u)then return false end
 local handle=u.handle
 return Core:Cast(HK_E,nil,{intentTarget=u,context=context,deferAttackWindup=true,validate=function()
  return self:Ready(_E)and u.handle==handle and self:Current(u)and self:Reach(u,350)and(not permission or permission())end})
end
function AmumuChampion:AttackPermission(u)
 local mode=GetMode();local node,context
 if u.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')then node=Menu[mode];context=Core:ModeContext(mode)
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then local kind=u.team==300 and 'jungle'or 'lane'
  if not Core:FarmModeEnabled(kind)then return nil end
  node=Menu.Clear[u.team==300 and 'JungleClear'or 'LaneClear'];context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 end
 if node and node.E:Value()and Core.manaAbove(node.Mana:Value())then return context end
end
function AmumuChampion:OnPostAttack(args)
 if ShouldWait()then return end
 local witness=Core:AttackWitness(self.attack,args and args.Target)
 if not witness or witness==self.attack or witness.at>Game.Timer()then return end
 self.attack=witness;local u=witness.object;local context=self:AttackPermission(u)
 if not context then return end
 return self:CastE(u,context,function()return self.attack==witness and Game.Timer()-witness.at<=.35 and self:AttackPermission(u)~=nil end)
end
function AmumuChampion:Nearby(kind,range)
  local list=kind=='hero'and Core:DecisionUnits('GetEnemyHeroes')or self:NPCRows(kind,range)
 local rows,seen={},{}
 for i=1,math.min(#list,kind=='hero'and 5 or kind=='jungle'and 12 or 40)do local u=list[i];local identity=id(u)
  if identity and not seen[identity]and self:Reach(u,range)and(kind=='hero'or(u.team==300)==(kind=='jungle'))then seen[identity]=true;rows[#rows+1]=u end
 end;return rows
end
function AmumuChampion:NPCRows(kind,range)
 return Core:DecisionValue('Amumu:NPC:'..kind..':'..range,function()
  local native=kind=='jungle'and _G.SDK.ObjectManager:GetMonsters(range)or _G.SDK.ObjectManager:GetEnemyMinions(range)
  local rows={};for i=1,math.min(#native,kind=='jungle'and 12 or 40)do rows[i]=native[i]end;return rows
 end)
end
-- radius: the aura's switch-on reach by default (wReach, Amumu-4: the larger of
-- the conflicting sources, so the aura is never left off where it could already
-- hurt); ManageW asks again with the release margin. Returns context, or nil and the reason ('no_units' alone is the
-- reason the release waits for, Amumu-3).
function AmumuChampion:WPermission(radius)
 radius=radius or self.wReach
 local mode=GetMode();local node,kind,context
 if mode=='Combo'or mode=='Harass'then node=Menu[mode];kind='hero';context=Core:ModeContext(mode)
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then
  for _,k in ipairs({'jungle','lane'})do
   local n=Menu.Clear[k=='jungle'and 'JungleClear'or 'LaneClear']
   if Core:FarmModeEnabled(k)and n.W:Value()and Core.manaAbove(n.Mana:Value())and #self:Nearby(k,radius)>=(k=='jungle'and 1 or Menu.Clear.LaneClear.Count:Value())then node=n;kind=k;context=Core:FarmContext(k,function()return Menu.Clear.SpellFarm:Value()end);break end
  end
 end
 if not node then return nil,mode=='LaneClear'and Menu.Clear.SpellFarm:Value()and 'no_units'or 'mode'end
 if not node.W:Value()or not Core.manaAbove(node.Mana:Value())or not Core.manaAbove(Menu.Misc.WMana:Value())then return nil,'mana_or_switch'end
 local e=myHero:GetSpellData(_E)
 if not finite(e.mana)or not finite(myHero:GetSpellData(_W).mana)or myHero.mana<myHero:GetSpellData(_W).mana*2+e.mana then return nil,'mana_or_switch'end
 if #self:Nearby(kind,radius)<(kind=='lane'and Menu.Clear.LaneClear.Count:Value()or 1)then return nil,'no_units'end
 return context
end
-- An owned aura stays on while a unit is within radius + 150, and for 0.5 s
-- after the last one left it, so units walking along the edge do not flap it.
function AmumuChampion:WHold(owned)
 if not owned or not Core.adapter:ContextValid({context=owned.context},'continuation')then return false end
 local now=Game.Timer();local _,why=self:WPermission(self.wReach)
 if why~='no_units'then return false end
 if self:WPermission(self.wReach+150)then owned.nearAt=now;return true end
 return owned.nearAt~=nil and now-owned.nearAt<.5
end
-- Development evidence for the aura radius (asset 300, wiki 350): units in the band
-- between the confirmed radius and 360 while the aura is on.
function AmumuChampion:TraceWEdge()
 if not Core.logger or not self.wOwned or myHero:GetSpellData(_W).toggleState~=2 then return end
 for _,kind in ipairs({'hero','jungle','lane'})do for _,u in ipairs(self:Nearby(kind,360))do
  local d=GetDistance(u.pos,myHero.pos)
  if d>self.profile.wRadius then Core:Trace('amumu_w_edge',{profile=self.profile.id,kind=kind,distance=d,bounding=u.boundingRadius,health=u.health,unit=id(u)},.25);return end
 end end
end
function AmumuChampion:ManageW()
 local d=myHero:GetSpellData(_W);local p=self.wPlan
 if p then local r=Core.adapter:Poll(p.action)
  if not r or r.jobCancelled or r.state=='cancelled_before_send'then self.wPlan=nil
  elseif r.state=='send_uncertain'then self.wPlan=nil;self.wOwned=nil
  elseif p.observed then self.wPlan=nil
  elseif Game.Timer()>p.expires then self.wPlan=nil end
  if self.wPlan then return false end
 end
 if d.toggleState==1 then self.wOwned=nil end
 local context=self:WPermission();local owned=self.wOwned
 if context and owned then owned.nearAt=Game.Timer()end
 local off=owned and d.toggleState==2 and(not context or not Core.adapter:ContextValid({context=owned.context},'continuation'))
 if off and not context and self:WHold(owned)then off=false end
 if not off and(d.toggleState~=1 or not context)then return false end
 if not self:Ready(_W,off)then return false end
 local plan={context=context,off=off,expires=Game.Timer()+1};self.wPlan=plan
 local ok=Core:Cast(HK_W,nil,{owner=off and 'WCleanup'or 'Aura',context=off and {priority='interactive'}or context,
  observe=function(q)return myHero:GetSpellData(_W).toggleState==(off and 1 or 2)and q.toggleState~=(off and 1 or 2)end,
  validate=function()return self.wPlan==plan and self:Ready(_W,off)and myHero:GetSpellData(_W).toggleState==(off and 2 or 1)
   and(off and self.wOwned==owned or not off and self:WPermission()~=nil)end})
 if not ok then self.wPlan=nil;return false end
 plan.action=Core.lastIntent.id
 Core:AfterCast(HK_W,function()if self.wPlan==plan then plan.observed=true;self.wOwned=not off and {context=context}or nil end end)
 return true
end
function AmumuChampion:RRows()
  return Core:DecisionValue('Amumu:RRows',function()
   local list=self:Nearby('hero',self.RRange+250);local rows={};local pred=Core:Prediction(self.RSpell)
   for _,u in ipairs(list)do pred:GetPrediction(u,myHero)
    if Core:SpellProtected(u)==false and pred:CanHit(2)and point(pred.UnitPosition)and GetDistance(pred.UnitPosition,myHero.pos)<=self.RRange then
     rows[#rows+1]={unit=u,id=id(u),handle=u.handle}
    end
   end;return rows
  end)
end
function AmumuChampion:CastR(u,context,count,permission)
 if not self:Ready(_R)or not self:Current(u)or not self:Reach(u,550)then return false end
 local handle=u.handle
 local function useful()
  if not self:Ready(_R)or u.handle~=handle or not self:Current(u)or(permission and not permission())then return false end
  local rows=self:RRows();local primary=false;for _,r in ipairs(rows)do if r.id==id(u)and r.handle==handle then primary=true end end
  return primary and #rows>=count
 end
 if not useful()then return false end
 return Core:Cast(HK_R,nil,{intentTarget=u,context=context,deferAttackWindup=true,validate=useful})
end
-- Combo R (Amumu-6): enough predicted enemies inside the radius; the primary is
-- the combat target when it is one of them, otherwise the first of the rows.
function AmumuChampion:ComboR(u,context,count,permission)
 if not self:Ready(_R)then return false end
 local rows=self:RRows();if #rows<count then return false end
 local primary=rows[1].unit
 for _,row in ipairs(rows)do if row.unit==u then primary=u;break end end
 return self:CastR(primary,context,count,permission)
end
function AmumuChampion:FinisherUseful(u,slot,geometryDeferred)
 local spell=slot==_Q and self.QSpell or slot==_E and self.ESpell or self.RSpell
 local range=slot==_Q and self.QRange or slot==_E and self.ERange or self.RRange
 if not self:Current(u)or u.type~=Obj_AI_Hero or not self:Reach(u,range)then return false end
 -- Q's own cast path predicts and checks the outgoing ray; the area casts are checked here.
 if slot~=_Q and not geometryDeferred then
  local prediction=Core:Prediction(spell);prediction:GetPrediction(u,myHero)
  if not prediction:CanHit(2)or not point(prediction.UnitPosition)or GetDistance(prediction.UnitPosition,myHero.pos)>range then return false end
 end
 -- The shared kill rule: spell protection, magic shields, regeneration and the health window.
 return(Core:Lethal(u,OrbamaPrediction:GetImpactTime(spell,slot==_Q and u.pos or myHero.pos,myHero),function()return self:Damage(u,slot)end,{kind='magical'}))
end
function AmumuChampion:Finishers()
 -- A kill E or Q takes is always taken (Q inside its health, enemy-count and turret limits). R is the
 -- ultimate and keeps its switch.
 for _,slot in ipairs({_E,_Q,_R})do
  local function consent()return slot~=_R or Menu.Misc.RFinish:Value()end
  if consent()and self:Ready(slot)and not Core.adapter:ResourceAction(Core.adapter:SlotResource(slot),false)then
   local candidates={};local range=slot==_Q and self.QRange or slot==_E and self.ERange or self.RRange
   for _,u in ipairs(self:Nearby('hero',range))do if self:FinisherUseful(u,slot)then candidates[#candidates+1]=u end end
   local selected=_G.SDK.TargetSelector.Selected
   if self:Current(selected)and self:Reach(selected,range)then candidates=self:FinisherUseful(selected,slot)and {selected}or {}end
   local u=_G.SDK.TargetSelector:GetTarget(candidates,_G.SDK.DAMAGE_TYPE_MAGICAL)
   if u then local function allowed()return consent()and self:FinisherUseful(u,slot,slot==_R)end
    local context={priority='interactive',condition=consent}
    if slot==_E and self:CastE(u,context,allowed)or slot==_Q and self:CastQ(u,context,allowed,'kill')
     or slot==_R and self:CastR(u,context,1,allowed)then return true end
   end
  end
 end;return false
end
-- An enemy dashing onto Amumu is answered with the bandage: he arrives next to Amumu, so this is no engage
-- and the engage health limit does not apply; turret and enemy-count limits still do.
function AmumuChampion:GapQ()
 if not Menu.Misc.GapQ:Value()or not self:Ready(_Q)then return false end
 for _,u in ipairs(self:Nearby('hero',1100))do
  if Core:ApproachingDash(u,myHero.pos,300)then
   return self:CastQ(u,{priority='interactive',condition=function()return Menu.Misc.GapQ:Value()end},function()
    return Menu.Misc.GapQ:Value()and(Core:ApproachingDash(u,myHero.pos,300)~=nil or self:Reach(u,300))end,false)
  end
 end;return false
end
function AmumuChampion:AutoR()
 if not Menu.Misc.AutoR:Value()or not self:Ready(_R)then return false end
 local rows=self:RRows();local count=Menu.Misc.AutoRCount:Value()
 if #rows<count then return false end
 local primary=rows[1].unit;local selected=_G.SDK.TargetSelector.Selected
 for _,row in ipairs(rows)do if row.unit==selected then primary=selected;break end end
 return self:CastR(primary,{priority='interactive'},count,function()
  return Menu.Misc.AutoR:Value()and Menu.Misc.AutoRCount:Value()<=count
 end)
end
function AmumuChampion:Channel(u,delay,token)
 local a=u and u.activeSpell
  return self:Current(u)and Core:CanInterrupt(u,delay)
  and(not token or token.name==a.name and token.start==a.startTime)
end
function AmumuChampion:Interrupt()
 local mode=GetMode();if mode~='Combo'and mode~='Harass'then return false end
 if not Core.manaAbove(Menu[mode].Mana:Value())then return false end
 local q=Menu.Misc.InterruptQ:Value()and self:Ready(_Q)
 local r=self.profile.rInterrupt and Menu.Misc.InterruptR:Value()and self:Ready(_R)
 if not q and not r then return false end
  local context=Core:ModeContext(mode)
  local rImpact=OrbamaPrediction:GetImpactTime(self.RSpell,myHero.pos,myHero)
  for _,u in ipairs(self:Nearby('hero',1100))do local a=u.activeSpell;local token=a and {name=a.name,start=a.startTime}
   if r and self:Channel(u,rImpact,token)and self:Reach(u,self.RRange)then
     if self:CastR(u,context,1,function()return Menu.Misc.InterruptR:Value()and self:Channel(u,OrbamaPrediction:GetImpactTime(self.RSpell,myHero.pos,myHero),token)and Core.manaAbove(Menu[mode].Mana:Value())end)then return true end
  end
   local delay=OrbamaPrediction:GetImpactTime(self.QSpell,u.pos,myHero)
  if q and self:Channel(u,delay,token)then
    if self:CastQ(u,context,function()return Menu.Misc.InterruptQ:Value()and self:Channel(u,OrbamaPrediction:GetImpactTime(self.QSpell,u.pos,myHero),token)and Core.manaAbove(Menu[mode].Mana:Value())end,true)then return true end
  end
 end
 return false
end
function AmumuChampion:Combat(mode)
 local node=Menu[mode];if not Core.manaAbove(node.Mana:Value())then return end
 local context=Core:ModeContext(mode);local u=GetTarget(1100);if not IsValid(u)then return end
 if mode=='Combo'and node.R:Value()and self:ComboR(u,context,node.RCount:Value(),function()return node.R:Value()and Core.manaAbove(node.Mana:Value())end)then return true end
 if self:ManageW()then return true end
 local recipient=node.E:Value()and self:ERecipient(u)
 if recipient and(not _G.SDK.Data:IsInAutoAttackRange(myHero,u)
  or not _G.SDK.Orbwalker:CanAttack()and Core:AttackWindupRemaining()<=0)then
  if self:CastE(recipient,context,function()return node.E:Value()and Core.manaAbove(node.Mana:Value())end)then return true end
 end
 if node.Q:Value()and not _G.SDK.Data:IsInAutoAttackRange(myHero,u)then
  return self:CastQ(u,context,function()local distance=GetDistance(u.pos,myHero.pos);return node.Q:Value()and Core.manaAbove(node.Mana:Value())
   and distance>=200
   and(mode~='Harass'or self.profile.charges==0 or not Menu.Harass.ReserveCharge:Value()or myHero:GetSpellData(_Q).ammo==2)end,true)
 end
end
-- The combat target when the burst (350 around Amumu after .25 s) reaches it,
-- otherwise the first other enemy champion it reaches.
function AmumuChampion:EHits(u)
 if not self:Reach(u,self.ERange)then return false end
 local pred=Core:Prediction(self.ESpell);pred:GetPrediction(u,myHero)
 return pred:CanHit(2)and point(pred.UnitPosition)~=nil and GetDistance(pred.UnitPosition,myHero.pos)<=self.ERange
end
function AmumuChampion:ERecipient(u)
 if self:EHits(u)then return u end
 for _,v in ipairs(self:Nearby('hero',self.ERange))do if v~=u and self:EHits(v)then return v end end
end
function AmumuChampion:Combo()return self:Combat('Combo')end
function AmumuChampion:Harass()return self:Combat('Harass')end
function AmumuChampion:FarmUseful(u,slot)
 local delay=slot==_Q and .25+GetDistance(u.pos,myHero.pos)/2000 or .25
 if u.team==300 or not self:Current(u)or not self:Reach(u,slot==_Q and 1100 or 350)then return false end
 local hp=Core:UnshieldedLegacyForecast(u,delay)
 if not finite(hp)or hp<=0 or hp+(u.hpRegen or 0)*delay>self:Damage(u,slot)then return false end
 if _G.SDK.Orbwalker:CanAttack()and _G.SDK.Data:IsInAutoAttackRange(myHero,u)then local windup=_G.SDK.Attack:GetWindup()
  if finite(windup)and windup>=0 then local attackHP=Core:UnshieldedLegacyForecast(u,windup)
   local damage=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,myHero.totalDamage)
   if finite(attackHP)and attackHP>0 and damage>=attackHP+(u.hpRegen or 0)*windup then return false end
  end
 end
 return slot~=_E or #self:Nearby('lane',350)==1
end
function AmumuChampion:Rescue(node,context)
 if not Core.manaAbove(node.Mana:Value())then return false end
 local best,slot
 for _,u in ipairs(self:Nearby('lane',1100))do
  for _,s in ipairs({_E,_Q})do if node[s==_E and 'E'or 'Q']:Value()and self:Ready(s)and self:FarmUseful(u,s)
   and(not best or u.maxHealth>best.maxHealth)then best,slot=u,s;break end end
 end
 if best then local function valid()return Core.manaAbove(node.Mana:Value())and node[slot==_Q and 'Q'or 'E']:Value()and self:FarmUseful(best,slot)end
  if slot==_Q then return self:CastQ(best,context,valid,false)else return self:CastE(best,context,valid)end
 end;return false
end
function AmumuChampion:Clear(kind)
 if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()then return false end
 local jungle=kind=='jungle';local node=Menu.Clear[jungle and 'JungleClear'or 'LaneClear']
 if not Core.manaAbove(node.Mana:Value())then return false end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 if self:ManageW()then return true end
 local units=self:Nearby(kind,1100);local best,near
 for _,u in ipairs(units)do
  if not best or u.maxHealth>best.maxHealth then best=u end
  if self:Reach(u,350)and(not near or u.maxHealth>near.maxHealth)then near=u end
 end
 if not best then return false end
 if node.E:Value()and near and #self:Nearby(kind,350)>=(jungle and 1 or Menu.Clear.LaneClear.Count:Value())then
  return self:CastE(near,context,function()return node.E:Value()and Core.manaAbove(node.Mana:Value())
   and #self:Nearby(kind,350)>=(jungle and 1 or Menu.Clear.LaneClear.Count:Value())end)
 end
 if jungle and node.Q:Value()and not _G.SDK.Data:IsInAutoAttackRange(myHero,best)then
  return self:CastQ(best,context,function()return node.Q:Value()and Core.manaAbove(node.Mana:Value())end,false)
 elseif jungle and node.Q:Value()and self:JungleQ(best)then
  return self:CastQ(best,context,function()return node.Q:Value()and Core.manaAbove(node.Mana:Value())and self:JungleQ(best)end,false)
 elseif not jungle and node.Q:Value()then return self:Rescue(node,context)end
 return false
end
-- Q for its damage and stun inside a camp (Amumu-2): Normal only with both
-- charges, so one stays for a fight; never when an enemy champion is within 1500
-- or the selected-target Q bind is held; never when the next attack (and a ready
-- E) already kill the monster.
function AmumuChampion:JungleQ(u)
 if not self:Current(u)or u.team~=300 or not self:Ready(_Q)then return false end
 if self.profile.charges>0 and myHero:GetSpellData(_Q).ammo~=2 then return false end
 if GetEnemyCount(1500,myHero.pos)>0 or Menu.Misc.QAssist:Value()then return false end
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)or windup<0 then windup=.25 end
 local ok,attack=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
 local damage=(ok and finite(attack)and attack or 0)+(self:Ready(_E)and self:Damage(u,_E)or 0)
 if damage<=0 then return true end
 local lethal,detail=Core:Lethal(u,windup,damage)
 return not lethal and detail~='dead_or_unknown_at_impact'
end
-- Health-bar damage (Amumu-9): ready Q (a charge), E and R plus the attacks of
-- the next 2 s. Passive bonus damage is left out (partial).
function AmumuChampion:ComboDamage(u)
 local total=0
 for _,slot in ipairs({_Q,_E,_R})do if self:Ready(slot)then total=total+self:Damage(u,slot)end end
 local ok,attack=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,myHero,u,true)
 if ok and finite(attack)then
  local okA,period=pcall(_G.SDK.Attack.GetAnimation,_G.SDK.Attack)
  if not okA or not finite(period)or period<=.2 then period=1 end
  total=total+attack*math.max(1,math.floor(2/period))
 end
 return total,true
end
function AmumuChampion:LaneClear()return self:Clear('lane')end
function AmumuChampion:JungleClear()return self:Clear('jungle')end
function AmumuChampion:LastHit()return self:Rescue(Menu.LastHit,Core:ModeContext('LastHit'))end
function AmumuChampion:Assist()
 if Menu.Misc.QAssist:Value()and self:Ready(_Q)then local u=GetTarget(1100);if IsValid(u)then
  return self:CastQ(u,Core:HeldContext(function()return Menu.Misc.QAssist:Value()end),function()return Menu.Misc.QAssist:Value()end,true)
 end end
end
function AmumuChampion:Flee()
 local context=Core:ModeContext('Flee')
 if Menu.Misc.FleeR:Value()then local u=GetTarget(550);if IsValid(u)and self:CastR(u,context,1,function()return Menu.Misc.FleeR:Value()end)then return true end end
 if not Menu.Misc.FleeQ:Value()or not point(mousePos)then return false end
 local best;local goal=point(mousePos)
 for _,kind in ipairs({'hero','jungle','lane'})do for _,u in ipairs(self:Nearby(kind,1100))do
  if GetDistance(u.pos,goal)+150<GetDistance(myHero.pos,goal)and self:SafeQ(u.pos,false)
   and(not best or GetDistance(u.pos,goal)<GetDistance(best.pos,goal))then best=u end
 end end
 if best then return self:CastQ(best,context,function()return Menu.Misc.FleeQ:Value()and point(mousePos)
  and GetDistance(best.pos,mousePos)+150<GetDistance(myHero.pos,mousePos)end,false)end
 return false
end
function AmumuChampion:PreparePreview()
 local ready,reason=self:Ready(_Q)
 -- Kept for a second so a late preparation never blinks it; Draw shows it only while R is ready.
 self.preview={count=#self:RRows(),profile=self.profile.id,qReason=not ready and reason or nil,expires=Game.Timer()+1}
end
function AmumuChampion:Tick()
 if ShouldWait()or not Core:Available()then
  local p=self.wPlan;if p and p.action then Core.adapter:Cancel(p.action,'unavailable')end
  self.wPlan=nil;self.attack=nil;self.preview=nil
  -- Chat/focus loss cannot safely inject a toggle. Preserve confirmed aura
  -- ownership so consent loss can stop its consumption after input returns.
  if myHero.dead then self.wOwned=nil end
  return
 end
 if Game.Timer()>=(self.nextConsent or 0)then self:RefreshQConsent()end
 if self.previewFallback and Menu.Draw.Preview:Value()and(not self.nextPreview or Game.Timer()>=self.nextPreview)then self:PreparePreview();self.nextPreview=Game.Timer()+.1 end
 if IsCasting()then return end
   self:TraceWEdge()
   if self:ManageW()or self:Assist()or self:Interrupt()or self:GapQ()or self:Finishers()or self:AutoR()then return end
 local mode=GetMode()
 if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')and self:LaneClear()then return end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function AmumuChampion:Draw()
 if myHero.dead then return end
 -- Ready abilities only; no W text (the game shows the toggle).
 if Menu.Draw.Ranges:Value()then for slot,r in pairs({[_Q]=1100,[_W]=self.profile.wRadius,[_E]=self.ERange,[_R]=self.RRange})do if IsReady(slot)then Draw.Circle(myHero.pos,r,1,Draw.Color(255,120,200,255))end end end
 local p=self.preview;if Menu.Draw.Preview:Value()and p and p.expires>Game.Timer()and p.count>0 and IsReady(_R)then
  Draw.Text('R hits '..p.count,16,myHero.pos2D.x,myHero.pos2D.y+50,Draw.Color(255,255,200,100))
 end
end
function AmumuChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Amumu: modes','Amumu: ownership'},function(page)
  return {title=page==1 and 'Amumu modes'or 'Resources and observation',cards=page==1 and {
   {'COMBAT','Provider Combo/Harass select targets. Q checks the outgoing ray and landing safety. E weaves after an observed completed attack.'},
   {'FARM','Spell farming has separate lane and jungle binds. LastHit rescues confirmed missed CS; E is tried before Q because Q pulls Amumu to the minion.'},
    {'ASSIST','The selected-target Q bind engages your chosen enemy. Combo R and automatic R each need their own enemy count. A kill E or Q takes is taken without a mode key (Q inside its health, enemy-count and turret limits); the R finisher has a switch. Each counts one conservative magic cast through the shared kill rule. Q also answers an enemy dashing onto Amumu. Flee Q chooses a safe object toward the cursor.'}}or {
   {'W','Only an observed script activation owns W. Consent release or mana limits request an owned toggle off. Manual W is preserved. Unload never injects a cleanup toggle.'},
   {'PROFILES','Normal Q requires native charges. Classic Q uses native cooldown. Normal true-damage passive and Classic MR reduction remain separate; unverified bonus damage is excluded.'},
   {'INTERRUPT','Held combat Q interrupts fresh actual channels that last beyond impact. Normal R has a separate option. Classic R interrupt is withheld until its disable semantics are verified.'}},
   note='Installed mechanics and offline regression do not establish live hits, resource timings or FPS.'}
 end)
end
Core:RegisterPolicy({damageTypes={Q='magical',E='magical',R='magical'},methods={
 Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,
 JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
  LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end,
  Finishers=function()return {priority='interactive'}end},
 channel=function()return not Core:SelfChanneling()end,
 costPaid=function(self,q,slot)return slot==_W and self.wPlan and self.wPlan.off end,
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot,slot==_W and self.wPlan and self.wPlan.off)end;return true end})
AmumuChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Amumu"]="Amumu"}
local normalSupported={["Amumu"]=true}

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
