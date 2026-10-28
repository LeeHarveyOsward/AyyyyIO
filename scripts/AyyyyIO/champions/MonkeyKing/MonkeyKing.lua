return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("c573bc09602a9a132c55899af54011b1d90ef4191ab35858361d95c72391fe90")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["MonkeyKing"]=function()return _G.OrbamaFamily:Require("3e23c72723f19c02d4a8cdde1454d5f314b9655bd17886feae4c84db71ba296e")()end
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
if champion=="MonkeyKing" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='MonkeyKing',profiles={normal=true,classic=true},
 Create=function(context)
-- Independently written. Installed profile evidence: CombatProfiles/wukong-provenance.json.
-- Stealth, native cast, clone identity, knockup and damage remain distinct facts.
local profiles=ChampionProfiles('MonkeyKing')
local finite,id,point,manaAbove,buffExpiry=Core.finite,Core.id,Core.point,Core.manaAbove,Core.buffExpiry
-- Stricter than Core.mine: every present owner/source field must be the player.
local function owned(u)
 if not u then return false end;local witness=false
 for _,key in ipairs({'owner','source','sourcenID','ownerID'})do local v=u[key]
  if v~=nil and v~=0 then if type(v)=='table'or type(v)=='userdata'then v=id(v)end
   if v~=myHero.networkID and v~=myHero.handle then return false end;witness=true
  end
 end;return witness
end
-- Pinned by this champion's regressions: only a ready, in-range lethal attack keeps the spell (Core:Rescue).
local readyAttack={attack='ready'}
local function cleanup(self,reason)
 for _,p in ipairs({self.farm or false,self.dash or false,self.spin or false})do if p then
  for _,key in ipairs({'action','follow'})do if p[key]then Core.adapter:Cancel(p[key],reason or 'ended')end end
 end end
 self.farm=nil;self.dash=nil;self.spin=nil;self.clone=nil;self.cloneSearch=nil;self.preview=nil;self.attack=nil;self.evadeCloneRequest=nil
 Core.adapter:SetBlocked('WukongFarm','attack',false)
end
local MonkeyKingChampion=class("MonkeyKingChampion")
function MonkeyKingChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.scan=1;self:LoadMenu();self.allow=Core:TargetConsent(Menu.Misc.Targets,self,'');self.consent=self.allow.targets;self:DiscoverTargets()
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 _G.SDK.Orbwalker:OnPostAttack(function(args)self:OnPostAttack(args)end)
 Core:RegisterCleanup('Wukong',function(reason)cleanup(self,reason)end)
 local ok,why=Core:RegisterPreparation('Wukong.preview',{intervalMs=150,maxDelayMs=450,units=1,maxUnits=1},function()self:PreparePreview();return true end,
  function()return Menu.Draw.Preview:Value()or Menu.Draw.Ranges:Value()end,function()self.preview=nil end)
 self.previewFallback=not ok and why=='unsupported'
 if Core.RegisterComboDamage then Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)end
 if self.profile.wRange>0 then
  Core:RegisterMobility({kind='dash',slot=_W,key=HK_W,name=self.profile.w,range=self.profile.wRange,speeds={self.profile.wSpeed},castDelays=self.profile.wDelays,
   profile=self.profile.id,label='Warrior Trickster',source=self.profile.wSource,
   allowed=function(p)return not self.dash and not self.farm and not self:Spinning()
    and self:Ready(_W)and(p==nil or GetDistance(p,myHero.pos)>=self.profile.wMin and GetDistance(p,myHero.pos)<=self.profile.wRange and self:Safe(p,false))end})
  -- MonkeyKing-6: Normal Nimbus Strike as a second offer (SDK.ChampionMobility alternatives), asset numbers in eDash.
  local d=self.profile.eDash
  if d then
   self.mobilityOffered,self.mobilityReason=Core:RegisterMobility({kind='unitDash',additional=true,slot=_E,key=HK_E,name=self.profile.e,range=d.range,
    speeds={d.speed},castDelays={0},profile=self.profile.id,label='Nimbus Strike',source=d.source,
    targets=function(request)return self:EvadeNimbusTargets(request)end,
    allowed=function(u,request)local ok,why=self:EvadeNimbusAllowed(u,request);return ok,why end})
  end
 elseif self.profile.eSpeed then
  -- Classic W is a stationary decoy, not a dash. Classic Nimbus Strike has an
  -- asset dash speed, so it is offered as a unit dash (Normal: speed unpublished).
  self.mobilityOffered,self.mobilityReason=Core:RegisterMobility({kind='unitDash',slot=_E,key=HK_E,name=self.profile.e,range=650,speeds={self.profile.eSpeed},castDelays={0},
   profile=self.profile.id,label='Nimbus Strike',source=self.profile.eSource,
   targets=function(request)return self:EvadeNimbusTargets(request)end,
   allowed=function(u,request)local ok,why=self:EvadeNimbusAllowed(u,request);return ok,why end})
 end
end
-- Champion policy for an Evade Nimbus Strike; the danger is Evade's judgement,
-- so the engage limits (health, W reserve, enemy count) do not apply. A wall
-- landing is refused; a landing under an enemy turret only for a lethal threat.
function MonkeyKingChampion:EvadeNimbusAllowed(u,request)
 if self.dash or self.farm or self:Spinning()then return false,'own_sequence'end
 if u==nil then return true end
 if not self:Current(u)or not self:Allowed(u)then return false,'target_ineligible'end
 local p=self:EEndpoint(u)
 if not p or type(Game.isWall)~='function'or Game.isWall(p)~=false then return false,'landing_unsafe'end
 if IsUnderTurret2(p)and not(request and request.lethal)then return false,'enemy_turret'end
 return true
end
-- At most 8 units in reach: minions and monsters before champions (a dodge should not start a fight it need not).
function MonkeyKingChampion:EvadeNimbusTargets(request)
 local rows={}
 for _,kind in ipairs({'lane','jungle','hero'})do for _,u in ipairs(self:Rows(kind,650))do
  if #rows>=8 then return rows end
  if self:EvadeNimbusAllowed(u,request)then rows[#rows+1]={unit=u,id=id(u),position=point(u.pos),landings={point(self:EEndpoint(u))},kind=kind}end
 end end
 return rows
end
function MonkeyKingChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Wukong'})
 for _,mode in ipairs({'Combo','Harass'})do Menu:MenuElement({type=MENU,id=mode,name=mode})
  Menu[mode]:MenuElement({id='Q',name='Use Q',value=true})
  Menu[mode]:MenuElement({id='E',name='Use E to dash to the target',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='W',name='Use W',value=mode=='Combo'})
  Menu[mode]:MenuElement({id='Order',name='When both E and W are on',value=1,drop={'E first, then W','W first, then E'},menu=false})
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 40 or 0,min=0,max=100,step=5,menu=mode=='Harass'})
 end
 Menu.Combo:MenuElement({id='R',name='Use R',value=true})
 Menu.Combo:MenuElement({id='RCount',name='R must hit this many enemies',value=2,min=1,max=5,step=1})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do Menu.Clear:MenuElement({type=MENU,id=kind,name=kind})
  for _,slot in ipairs({'Q','E','W'})do Menu.Clear[kind]:MenuElement({id=slot,name='Use '..slot,value=true})end
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions E must hit',value=3,min=1,max=3,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='E',name='Dash with E to minions an attack cannot take',value=true})
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({type=MENU,id='Targets',name='Enemy champions abilities may target'})
 Menu.Misc:MenuElement({id='EAssist',name='Cast E at the selected target',key=string.byte('U')})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R at the selected target',key=string.byte('T')})
 Menu.Misc:MenuElement({id='FleeW',name='Use W in Flee',value=true})
 Menu.Misc:MenuElement({id='FleeE',name='Use E on a unit toward the cursor in Flee',value=true})
 Menu.Misc:MenuElement({id='ReserveW',name='Keep W for after a long E dash',value=true,menu=false})
 Menu.Misc:MenuElement({id='ManualQ',name='Q after attacking a champion, also outside modes',value=true})
 Menu.Misc:MenuElement({id='InterruptR',name='R to stop a dangerous channel',value=true})
 Menu.Misc:MenuElement({id='AutoR',name='R automatically when enough enemies are around',value=true})
 Menu.Misc:MenuElement({id='AutoRCount',name='Enemies needed for automatic R',value=3,min=2,max=5,step=1})
 Menu.Misc:MenuElement({id='HP',name='Never dash in below health %',value=30,min=0,max=100,step=5})
 Menu.Misc:MenuElement({id='Enemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Preview',name='Clone and W landing spot',value=true})
end
function MonkeyKingChampion:Rows(kind,range)return Core:Rows(kind,range)end
-- A cheap check for units a caller has already confirmed with Current.
function MonkeyKingChampion:Reach(u,range)return IsValid(u)and u.team~=myHero.team and point(u.pos)and GetDistance(u.pos,myHero.pos)<=range end
function MonkeyKingChampion:Current(u)return Core:CurrentUnit(u)end
function MonkeyKingChampion:DiscoverTargets()self.allow:Refresh()end
function MonkeyKingChampion:Allowed(u)return self.allow:Allowed(u)end
function MonkeyKingChampion:Buff(u,name)return(Core:OwnBuff(u,name,true))end
function MonkeyKingChampion:Spinning()
 local d=myHero:GetSpellData(_R);local a=myHero.activeSpell
 return d and d.name==self.profile.leave or self:Buff(myHero,self.profile.r)~=nil
  or a and a.valid and not a.isStopped and a.name==self.profile.r and finite(a.castEndTime)and a.castEndTime>Game.Timer()or false
end
function MonkeyKingChampion:Ready(slot,second)
 local d=myHero:GetSpellData(slot);local expected=self.profile[({[0]='q',[1]='w',[2]='e',[3]='r'})[slot]]
 if not d or d.name~=expected or not finite(d.level)or d.level<1 or not finite(d.currentCd)or d.currentCd>0 or Game.CanUseSpell(slot)~=0
  or not finite(d.mana)or d.mana<0 or not finite(myHero.mana)or myHero.mana<d.mana then return false end
 if slot==_Q and self:Buff(myHero,self.profile.q)then return false end
 if slot==_W and self:Buff(myHero,self.profile.stealth)then return false end
 if slot==_R then local b=self:Buff(myHero,self.profile.rRecast)
  if second then return self.profile.rRecast~=nil and b~=nil and d.toggleState==2 end
  return not b and d.toggleState~=2 and not self:Spinning()
 end;return true
end
function MonkeyKingChampion:Safe(p,offense)
 if not point(p)or type(Game.isWall)~='function'or Game.isWall(p)~=false or IsUnderTurret2(p)or GetEnemyCount(600,p)>Menu.Misc.Enemies:Value()then return false end
 return not offense or finite(myHero.maxHealth)and myHero.maxHealth>0 and myHero.health/myHero.maxHealth*100>=Menu.Misc.HP:Value()
end
function MonkeyKingChampion:QReach(u)
 local bonus=self.profile.qBonusRange[myHero:GetSpellData(_Q).level]
 return bonus and finite(myHero.range)and finite(myHero.boundingRadius)and finite(u and u.boundingRadius)
  and self:Reach(u,myHero.range+bonus+myHero.boundingRadius+u.boundingRadius)or false
end
function MonkeyKingChampion:Observe(q,name,u)
 local a=Core:NativeCast(q,name);return a
  and(not u or a.target==id(u)or a.target==u.handle)or false
end
function MonkeyKingChampion:CastQ(u,context,permission)
 if not self:Ready(_Q)or self:Spinning()or not self:Current(u)or not self:QReach(u)or not self:Allowed(u)or permission and not permission()then return false end
 local handle=u.handle
 return Core:Cast(HK_Q,nil,{owner='CrushingBlow',context=context,intentTarget=u,range=500,
  -- Q has no cast time, so the host may show no native cast. The owned
  -- empowerment appearing after the key (Ready refuses Q while it is present) is
  -- the outcome itself; the last-hit plan otherwise blocks attacks to its expiry.
  observe=function(q)return self:Observe(q,self.profile.q)or q.sentAt~=nil and self:Buff(myHero,self.profile.q)~=nil end,
  validate=function()return self:Ready(_Q)and not self:Spinning()and self:Current(u)and u.handle==handle and self:QReach(u)and self:Allowed(u)and(not permission or permission())end})
end
function MonkeyKingChampion:AttackPermission(u)
 local mode=GetMode();local node,context
 if u.type==Obj_AI_Hero and(mode==nil or mode=='None'or mode=='')then
  -- No mode held: Q after the player's own attack on a consented champion, under the Harass mana gate.
  return Menu.Misc.ManualQ:Value()and self:Allowed(u)and manaAbove(Menu.Harass.Mana:Value())
   and {priority='interactive',condition=function()return Menu.Misc.ManualQ:Value()end}or nil
 end
 if u.type==Obj_AI_Hero and(mode=='Combo'or mode=='Harass')then node=Menu[mode];context=Core:ModeContext(mode)
 elseif mode=='LaneClear'and Menu.Clear.SpellFarm:Value()then local kind=u.team==300 and 'jungle'or 'lane'
  if not Core:FarmModeEnabled(kind)then return nil end;node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'];context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 end
 return node and node.Q:Value()and manaAbove(node.Mana:Value())and context or nil
end
function MonkeyKingChampion:OnPostAttack(args)
 if ShouldWait()or not Core:Available()or self.farm or self.dash or self:Spinning()then return end
 local a=Core:AttackWitness(self.attack,args and args.Target);if not a or a==self.attack or a.at>Game.Timer()then return end
 self.attack=a;local context=self:AttackPermission(a.object);if not context then return end
 return self:CastQ(a.object,context,function()return self.attack==a and Game.Timer()-a.at<=.35 and self:AttackPermission(a.object)~=nil end)
end
function MonkeyKingChampion:EEndpoint(u)
 if not self:Reach(u,650)then return nil end
 return u.pos:Extended(myHero.pos,math.min(75,GetDistance(u.pos,myHero.pos)))
end
function MonkeyKingChampion:CastE(u,context,permission,offense)
 if self.dash or self.farm or not self:Ready(_E)or self:Spinning()or not self:Current(u)or not self:Allowed(u)or not self:Safe(self:EEndpoint(u),offense)then return false end
 -- The W reserve guards a long gap-closing dash only: inside attack reach E is damage and attack speed.
 local p={target=u,id=id(u),handle=u.handle,context=context,origin=point(myHero.pos),expires=Game.Timer()+1.25,
  reserveW=offense and not _G.SDK.Data:IsInAutoAttackRange(myHero,u)};self.dash=p
 local function valid()
  local landing=self:EEndpoint(u)
  local engage=self.cloneSearch and self.cloneSearch.engage
  local spent=engage and engage.observed and engage.id==id(u)and engage.handle==u.handle and engage.permission()
   and Core.adapter:ContextValid({context=engage.context},'continuation')
  if p.reserveW and Menu.Misc.ReserveW:Value()and not spent then local e=myHero:GetSpellData(_E);local w=myHero:GetSpellData(_W)
   if not self:Ready(_W)or myHero.mana<e.mana+w.mana then return false end
  end
  return self.dash==p and self:Ready(_E)and not self:Spinning()and self:Current(u)and u.handle==p.handle and id(u)==p.id and self:Allowed(u)
   and self:Safe(landing,offense)and self:Safe(myHero.pos:Extended(landing,GetDistance(landing,myHero.pos)*.5),offense)and(not permission or permission())
 end
 if not valid()then self.dash=nil;return false end
 local ok=Core:Cast(HK_E,u,{owner='Nimbus',context=context,intentTarget=u,range=650,independent=false,
  observe=function(q)return self:Observe(q,self.profile.e,u)end,validate=valid})
 if not ok then self.dash=nil;return false end;p.action=Core.lastIntent.id
 Core:AfterCast(HK_E,function()if self.dash==p then p.observed=true end end);return true
end
function MonkeyKingChampion:ContinueDash()
 local p=self.dash;if not p then return false end;local r=Core.adapter:Poll(p.action)
 if not r or r.jobCancelled or r.state=='send_uncertain'or r.state=='cancelled_before_send'or p.expires<=Game.Timer()
  or not Core.adapter:ContextValid({context=p.context},'continuation')or id(p.target)~=p.id or p.target.handle~=p.handle or not self:Current(p.target)then
  if p.action then Core.adapter:Cancel(p.action,'dash_ended')end;self.dash=nil;return false
 end
 if not p.observed then return true end
 -- The lock keeps Q, W and R from being queued on top of the dash. It ends when
 -- the observed cast's dash is over or, for a dash too short to be seen (a
 -- target already in melee range), a moment after the cast. Requiring a seen
 -- dash of more than 40 units held it for 1.25 s and blocked the post-attack Q.
 p.observedAt=p.observedAt or Game.Timer()
 if myHero.pathing and myHero.pathing.isDashing then p.dashSeen=true;return true end
 if p.dashSeen or Game.Timer()-p.observedAt>.3 then self.dash=nil;return false end
 return true
end
function MonkeyKingChampion:WAim(goal)
 if self.profile.wRange==0 then return point(myHero.pos)end
 if not point(goal)then return nil end
 local distance=GetDistance(goal,myHero.pos);if distance<self.profile.wMin then return nil end
 return myHero.pos:Extended(goal,math.min(distance,self.profile.wRange))
end
function MonkeyKingChampion:CastW(goal,context,permission,offense,refresh,engageTarget)
 if not self:Ready(_W)or self.farm or self.dash or self:Spinning()or permission and not permission()then return false end
 local normal=self.profile.wRange>0
 local function safe(p)return not normal and not offense or self:Safe(p,offense)end
 local aim=self:WAim(goal);if not aim or not safe(aim)then return false end
 local search={origin=point(myHero.pos),started=Game.Timer(),expires=Game.Timer()+self.profile.cloneDuration+.3}
 if engageTarget then search.engage={target=engageTarget,id=id(engageTarget),handle=engageTarget.handle,context=context,permission=permission,expires=Game.Timer()+1.2}end
 local function feasible()
  if not engageTarget then return true end;local e=myHero:GetSpellData(_E);local w=myHero:GetSpellData(_W)
  return self:Ready(_E)and self:Current(engageTarget)and engageTarget.handle==search.engage.handle and self:Allowed(engageTarget)
   and myHero.mana>=w.mana+e.mana and self:Safe(self:EEndpoint(engageTarget),true)
 end
 if not feasible()then return false end
 local function resolve()local p=self:WAim(refresh and refresh()or goal);if not p or not safe(p)then return nil end;return {position=p}end
 local function valid(_,r)return self:Ready(_W)and not self:Spinning()and not self.dash and not self.farm and safe(normal and r and r.position or myHero.pos)
  and feasible()and(not permission or permission())end
 local ok=Core:Cast(HK_W,normal and aim or nil,{owner='Trickster',context=context,independent=false,prevalidateWorldCast=normal,
  resolve=normal and resolve or nil,observe=function(q)return self:Observe(q,self.profile.w)end,validate=valid})
 if ok then Core:AfterCast(HK_W,function()search.observed=true;if search.engage then search.engage.observed=true end;self.cloneSearch=search;self.scan=1 end)end
 return ok
end
function MonkeyKingChampion:ContinueEngage()
 local p=self.cloneSearch and self.cloneSearch.engage;if not p then return false end
 if p.expires<=Game.Timer()or not p.permission()or not Core.adapter:ContextValid({context=p.context},'continuation')or not self:Current(p.target)or p.target.handle~=p.handle then
  self.cloneSearch.engage=nil;return false
 end
 if p.started then return false end
 if IsCasting()then return true end
 if self:CastE(p.target,p.context,p.permission,true)then p.started=true;return true end;return false
end
function MonkeyKingChampion:ObserveEvadeClone()
 local a=myHero.activeSpell
 if not a or not a.valid or a.isStopped or a.name~=self.profile.w or not finite(a.startTime)or a.startTime>Game.Timer()or Game.Timer()-a.startTime>.3 then return end
 for i=#Core.history,math.max(1,#Core.history-7),-1 do local q=Core.history[i]
  if q.key==HK_W and q.owner=='evade_dash'and q.observedAt and self.evadeCloneRequest~=q.id and Core.adapter:Now()-q.observedAt<=300 then
   self.evadeCloneRequest=q.id;self.cloneSearch={observed=true,origin=point(a.startPos or myHero.pos),started=a.startTime,expires=a.startTime+self.profile.cloneDuration+.3};self.scan=1;return
  end
 end
end
function MonkeyKingChampion:CloneEligible(u)
 local p=self.cloneSearch
 if not p or not p.observed or p.expires<=Game.Timer()or not u or u.dead or u.team~=myHero.team or u.type~=Obj_AI_Minion or not point(u.pos)or not id(u)or not owned(u)then return false end
 -- Explicit clone marker plus owner is required. Same-team lookalikes and
 -- Nimbus cosmetic copies never become the Warrior Trickster clone.
 local marker=u.isClone==true or self.profile.cloneBuff and self:Buff(u,self.profile.cloneBuff)~=nil
 local birth=u.spawnTime or u.creationTime
 return marker and finite(birth)and birth>=p.started-.05 and birth<=Game.Timer()and GetDistance(u.pos,p.origin)<=600 or false
end
function MonkeyKingChampion:Clone()
 local c=self.clone;if not c or not Game.Minion or Game.Minion(c.index)~=c.object or id(c.object)~=c.id or c.object.handle~=c.handle or not self:CloneEligible(c.object)then self.clone=nil;return nil end
 return c.object
end
function MonkeyKingChampion:DiscoverClone()
 if not self.cloneSearch or self.cloneSearch.expires<=Game.Timer()then self.clone=nil;self.cloneSearch=nil;return end
 if self:Clone()or not Game.MinionCount or not Game.Minion then return end
 local n=Game.MinionCount();if not finite(n)or n<1 then return end;n=math.min(n,512)
 for i=1,math.min(n,24)do if self.scan>n then self.scan=1 end;local index=self.scan;self.scan=self.scan+1;local u=Game.Minion(index)
  if self:CloneEligible(u)then self.clone={object=u,index=index,id=id(u),handle=u.handle};return end
 end
end
function MonkeyKingChampion:CloneContribution(u)
 local clone=self:Clone();if not clone or self.profile.id~='normal'or not self:Current(u)or not self:Allowed(u)then return nil end
 local a=clone.activeSpell;local ratio=self.profile.cloneRatio[myHero:GetSpellData(_W).level]
 if not ratio or not a or not a.valid or a.isStopped or not Core:IsAttackCast(a)or(a.target~=id(u)and a.target~=u.handle)
  or not finite(a.startTime)or a.startTime<self.cloneSearch.started or not finite(a.castEndTime)or a.castEndTime<Game.Timer()
  or not finite(clone.range)or not finite(clone.boundingRadius)or not finite(u.boundingRadius)
  or GetDistance(clone.pos,u.pos)>clone.range+clone.boundingRadius+u.boundingRadius then return nil end
 return {target=id(u),impact=a.castEndTime,ratio=ratio,source='owned_native_clone_attack'}
end
-- Consented enemies within the spin radius of Wukong, and of his clone once its own Cyclone has been
-- observed this session (Normal clone mimics R; unknown = not counted).
function MonkeyKingChampion:RCount()
 local n,seen=0,{};for _,u in ipairs(self:Rows('hero',self.profile.rRadius))do if self:Allowed(u)then n=n+1;seen[id(u)]=true end end
 local c=self.cloneCycloneSeen and self:Clone()
 if c and point(c.pos)then
  for _,u in ipairs(self:Rows('hero',self.profile.rRadius+GetDistance(c.pos,myHero.pos)))do
   if not seen[id(u)]and self:Allowed(u)and GetDistance(u.pos,c.pos)<=self.profile.rRadius then n=n+1;seen[id(u)]=true end
  end
 end
 return n
end
-- Development observation (MonkeyKing-4): the owned clone casting its own Cyclone while Wukong spins.
function MonkeyKingChampion:ObserveCloneCyclone()
 if self.cloneCycloneSeen or self.profile.id~='normal'then return end
 local c=self:Clone();local a=c and c.activeSpell
 if a and a.valid and not a.isStopped and type(a.name)=='string'and a.name==self.profile.r then
  self.cloneCycloneSeen=true;Core:Trace('wukong_clone_cyclone',{name=a.name,at=Game.Timer()})
 end
end
-- One Cyclone tick on `u`, raw physical before mitigation (profile: Normal % max health + AD, Classic base + AD).
function MonkeyKingChampion:RTick(u)
 local p=self.profile;local rank=myHero:GetSpellData(_R).level;if not finite(rank)or not p.rTick then return nil end
 local ad=myHero.totalDamage;if not finite(ad)then return nil end
 local perSecond
 if p.rPctPerSec then local pct=p.rPctPerSec[rank];if not pct or not finite(u.maxHealth)then return nil end;perSecond=pct*u.maxHealth+p.rADPerSec*ad
 elseif p.rBasePerSec then local base=p.rBasePerSec[rank];if not base then return nil end;perSecond=base+p.rADPerSec*ad end
 return perSecond and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,perSecond*p.rTick)
end
-- Ticks `u` surely takes from a spin started now: the knock-up, then its walk out of the radius at its own
-- speed (Wukong's chase is not counted), whole ticks only, capped by the spin.
function MonkeyKingChampion:RTicks(u)
 local p=self.profile;if not p.rTicks or not finite(u.ms)then return 0 end
 local d=GetDistance(u.pos,myHero.pos);if d>p.rRadius then return 0 end
 local inside=(p.rKnockupSeconds or 0)+(u.ms>0 and(p.rRadius-d)/u.ms or math.huge)
 return math.max(0,math.min(p.rTicks,math.floor(inside/p.rTick)))
end
-- R kills `u` with the ticks it surely takes (first spin only; the recast is not counted), plus an observed
-- clone attack landing before the last counted tick.
function MonkeyKingChampion:RKills(u)
 if not self:Current(u)or not self:Allowed(u)or not self:Reach(u,self.profile.rRadius)then return false end
 local ticks=self:RTicks(u);if ticks<1 then return false end
 local tick=self:RTick(u);if not tick then return false end
 local horizon=ticks*self.profile.rTick
 return(Core:Lethal(u,horizon,function()return ticks*tick+self:CloneDamage(u,horizon)end,{kind='physical'}))
end
-- Damage of an observed owned clone attack on `u` that lands within `within` seconds (Normal), else 0.
function MonkeyKingChampion:CloneDamage(u,within)
 local c=self:CloneContribution(u);if not c or c.impact>Game.Timer()+(within or 0)then return 0 end
 local aa=_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true);return finite(aa)and aa*c.ratio or 0
end
function MonkeyKingChampion:RSecond(p,continuation)
 local b=self:Buff(myHero,self.profile.rRecast)
 return p and p.observed and(not p.follow or continuation)and p.expires>Game.Timer()and self.profile.rRecast and b and finite(b.startTime)
  and b.startTime>=p.started-.05 and Game.Timer()-p.started>=self.profile.rLockout and not self:Spinning()and self:Ready(_R,true)or false
end
-- safety: replaces the engage limits for a spin where the enemies are already on Wukong (interrupt, keyless
-- group spin); independent: a background intention not tied to a held mode.
function MonkeyKingChampion:CastR(u,context,permission,safety,independent)
 local function safe()if safety then return safety()end;return self:Safe(myHero.pos,true)end
 if self.spin or self.dash or self.farm or not self:Ready(_R)or not self:Current(u)or not self:Reach(u,self.profile.rRadius)or not self:Allowed(u)or not safe()then return false end
 local p={target=u,id=id(u),handle=u.handle,context=context,permission=permission,started=Game.Timer(),expires=Game.Timer()+(self.profile.recastWindow or self.profile.spinDuration)+.25,knockups={}};self.spin=p
 local ok=Core:Cast(HK_R,nil,{owner='Cyclone',context=context,intentTarget=u,range=self.profile.rRadius,independent=independent==true,
  observe=function(q)return self:Observe(q,self.profile.r)end,validate=function()return self.spin==p and self:Ready(_R)and not self.dash and self:Current(u)and id(u)==p.id and u.handle==p.handle
   and self:Reach(u,self.profile.rRadius)and self:Allowed(u)and safe()and(not permission or permission())end})
 if not ok then self.spin=nil;return false end;p.action=Core.lastIntent.id
 Core:AfterCast(HK_R,function()if self.spin==p then p.observed=true;p.firstNative=Game.Timer()end end);return true
end
function MonkeyKingChampion:ObserveKnockups(p)
 if not p.observed then return end
 for _,u in ipairs(self:Rows('hero',600))do if finite(u.buffCount)and u.buffCount>=0 and u.buffCount<=128 then for i=0,u.buffCount do local b=u:GetBuff(i)
  local native=b and(self.profile.knockup and b.name==self.profile.knockup or not self.profile.knockup and b.type==30)
  local ending=buffExpiry(b)
  if native and finite(b.count)and b.count>0 and owned(b)and finite(b.startTime)and b.startTime>=p.firstNative-.05 and finite(ending)and ending>Game.Timer()then
   p.knockups[id(u)]={first=p.knockups[id(u)]and p.knockups[id(u)].first or b.startTime,last=b.startTime,second=p.follow~=nil}
  end
 end end end
end
function MonkeyKingChampion:ContinueSpin()
 local p=self.spin;if not p then return false end;local r=Core.adapter:Poll(p.action)
 if not r or r.jobCancelled or r.state=='send_uncertain'or r.state=='cancelled_before_send'or p.expires<=Game.Timer()
  or not Core.adapter:ContextValid({context=p.context},'continuation')or not self:Current(p.target)or p.target.handle~=p.handle then
  if p.action then Core.adapter:Cancel(p.action,'spin_ended')end;if p.follow then Core.adapter:Cancel(p.follow,'spin_ended')end;self.spin=nil;return false
 end
 self:ObserveKnockups(p)
 if self:Spinning()then p.spinSeen=true;self:ObserveCloneCyclone();return true end
 if p.follow then if not Core.pending[HK_R]then self.spin=nil end;return false end
 if self.profile.id=='classic'and p.spinSeen then self.spin=nil;return false end
 if not self:RSecond(p)or self:RCount()<Menu.Combo.RCount:Value()then return false end
 local ok=Core:Cast(HK_R,nil,{owner='Cyclone',context=p.context,intentTarget=p.target,range=self.profile.rRadius,independent=false,
  observe=function(q)return self:Observe(q,self.profile.r)end,validate=function()return self.spin==p and self:RSecond(p,true)
   and self:Current(p.target)and p.target.handle==p.handle and self:Reach(p.target,self.profile.rRadius)and self:Allowed(p.target)
   and self:RCount()>=Menu.Combo.RCount:Value()and self:Safe(myHero.pos,true)and(not p.permission or p.permission())end})
 if ok then p.follow=Core.lastIntent.id end;return ok
end
function MonkeyKingChampion:Damage(u,slot)
 local rank=myHero:GetSpellData(slot).level;local bonus=myHero.bonusDamage
 if not finite(myHero.totalDamage)or not finite(myHero.ap)or not finite(bonus)then return 0 end
 if slot==_Q and self.profile.qBase[rank]then return _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,
  self.profile.qBase[rank]+myHero.totalDamage*self.profile.qTotalAD+bonus*self.profile.qBonusAD)end
 if slot==_E and self.profile.eBase[rank]then return _G.SDK.Damage:CalculateDamage(myHero,u,self.profile.eKind=='physical'and _G.SDK.DAMAGE_TYPE_PHYSICAL or _G.SDK.DAMAGE_TYPE_MAGICAL,
  self.profile.eBase[rank]+bonus*self.profile.eAD+myHero.ap*self.profile.eAP)end;return 0
end
function MonkeyKingChampion:UsefulCS(u,slot,empowered)
 if not self:Current(u)or u.type==Obj_AI_Hero or u.team==300 or(slot==_Q and not self:QReach(u)or slot==_E and not self:Reach(u,650))then return false end
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)or windup<0 then return false end
 -- Q lands with the attack it empowers; an unsent Q still needs its cast first.
 local impact=slot==_Q and windup+(empowered and 0 or .25)or GetDistance(myHero.pos,u.pos)/1050+.3
 -- An observed clone attack landing first that takes the minion leaves no rescue to do.
 local clone=self:CloneDamage(u,impact)
 if clone>0 then local hp=Core:UnshieldedLegacyForecast(u,impact);if not finite(hp)or clone>=hp then return false end end
 return Core:Rescue(u,impact,function()return self:Damage(u,slot)end,readyAttack)
end
function MonkeyKingChampion:LastHit()
 if self.farm or self.dash or self:Spinning()or not manaAbove(Menu.LastHit.Mana:Value())then return false end
 local q=Menu.LastHit.Q:Value()and self:Ready(_Q);local e=Menu.LastHit.E:Value()and self:Ready(_E);if not q and not e then return false end
 local best,slot;for _,u in ipairs(self:Rows('lane',650))do local s=q and self:UsefulCS(u,_Q)and _Q or e and self:UsefulCS(u,_E)and _E
  if s and(not best or u.maxHealth>best.maxHealth)then best,slot=u,s end
 end;if not best then return false end;local context=Core:RescueContext()
 if slot==_E then return self:CastE(best,context,function()return Menu.LastHit.E:Value()and manaAbove(Menu.LastHit.Mana:Value())and self:UsefulCS(best,_E)end,false)end
 local p={target=best,id=id(best),handle=best.handle,context=context,expires=Game.Timer()+.9};self.farm=p
 if not self:CastQ(best,context,function()return self.farm==p and Menu.LastHit.Q:Value()and manaAbove(Menu.LastHit.Mana:Value())and self:UsefulCS(best,_Q)end)then self.farm=nil;return false end
 p.action=Core.lastIntent.id;Core.adapter:SetBlocked('WukongFarm','attack',true)
 Core:AfterCast(HK_Q,function()if self.farm==p then p.observed=true end end);return true
end
function MonkeyKingChampion:ContinueFarm()
 local p=self.farm;if not p then return false end;local r=Core.adapter:Poll(p.action)
 if not r or r.jobCancelled or r.state=='send_uncertain'or r.state=='cancelled_before_send'or p.expires<=Game.Timer()or not Core.adapter:ContextValid({context=p.context},'continuation')
  or not Menu.LastHit.Q:Value()or id(p.target)~=p.id or p.target.handle~=p.handle or not self:UsefulCS(p.target,_Q,p.observed)then cleanup(self,'farm_ended');return false end
 if not p.observed or not self:Buff(myHero,self.profile.q)then return true end
 Core.adapter:SetBlocked('WukongFarm','attack',false);if p.follow then if not Core.pending['__owned_attack']then self.farm=nil end;return true end
 if not _G.SDK.Orbwalker:CanAttack()then return true end
 local ok=Core:Attack(p.target,{owner='LastHit',context=p.context,validate=function()return self.farm==p and self:Buff(myHero,self.profile.q)~=nil and self:Current(p.target)
  and p.target.handle==p.handle and self:UsefulCS(p.target,_Q,true)end,
  observe=function(q)local a=Core:NativeAttack(q,self.profile.qAttack);return a
   and(a.target==p.id or a.target==p.handle)end})
 if ok then p.follow=Core.lastIntent.id end;return true
end
-- The empowered attack (Q bonus plus the attack, Damage(_Q)) and an observed clone attack kill at the windup.
function MonkeyKingChampion:QAttackKills(u)
 local windup=_G.SDK.Attack:GetWindup();if not finite(windup)or windup<0 or not self:Current(u)then return false end
 return(Core:Lethal(u,windup+.05,function()return self:Damage(u,_Q)+self:CloneDamage(u,windup+.05)end,{kind='physical',attack=true}))
end
-- Q before an attack: the target is beyond attack reach but inside Q's longer reach, or the empowered attack
-- kills. The empowered target becomes the attack preference.
function MonkeyKingChampion:QFirst(u,context,permission)
 if self.farm or self.dash or self:Spinning()or not self:Ready(_Q)or not self:Current(u)or not self:Allowed(u)or not self:QReach(u)then return false end
 local inReach=_G.SDK.Data:IsInAutoAttackRange(myHero,u)
 local function wanted()return not _G.SDK.Data:IsInAutoAttackRange(myHero,u)or self:QAttackKills(u)end
 if inReach and not self:QAttackKills(u)then return false end
 if not self:CastQ(u,context,function()return wanted()and(not permission or permission())end)then return false end
 Core:AfterCast(HK_Q,function()if Core.PreferAttack then Core:PreferAttack('CrushingBlow',u,1)end end)
 return true
end
function MonkeyKingChampion:Combat(mode)
 local node=Menu[mode];if not manaAbove(node.Mana:Value())then return false end
 local context=Core:ModeContext(mode)
 if node.Q:Value()then local t=GetTarget(650)
  if t and self:QFirst(t,context,function()return node.Q:Value()and manaAbove(node.Mana:Value())end)then return true end
 end
 local r=mode=='Combo'and Menu.Combo.R:Value()and self:Ready(_R);local e=node.E:Value()and self:Ready(_E);local w=node.W:Value()and self:Ready(_W)
 if not r and not e and not w then return false end;local u=GetTarget(650);if not self:Current(u)or not self:Allowed(u)then return false end
 local targetID,targetHandle=id(u),u.handle
 if r and self:RCount()>=Menu.Combo.RCount:Value()then return self:CastR(u,context,function()return Menu.Combo.R:Value()and manaAbove(node.Mana:Value())end)end
 if r and self:RKills(u)then return self:CastR(u,context,function()return Menu.Combo.R:Value()and manaAbove(node.Mana:Value())and self:RKills(u)end)end
 local function nimbus()return e and self:CastE(u,context,function()return node.E:Value()and manaAbove(node.Mana:Value())end,true)end
 local cloneFirst=node.Order:Value()==2 and e
 local function clone()return w and self:Reach(u,self.profile.wRange>0 and 550 or 300)and self:CastW(u.pos,context,function()return node.W:Value()
  and(not cloneFirst or node.E:Value())and id(u)==targetID and u.handle==targetHandle and self:Current(u)and self:Allowed(u)and manaAbove(node.Mana:Value())end,true,function()return u.pos end,cloneFirst and u or nil)end
 if node.Order:Value()==2 then if clone()then return true end;return nimbus()end
 if nimbus()then return true end;return clone()
end
function MonkeyKingChampion:Combo()return self:Combat('Combo')end
function MonkeyKingChampion:Harass()return self:Combat('Harass')end
function MonkeyKingChampion:Clear(kind)
 if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()then return false end
 local node=Menu.Clear[kind=='jungle'and 'JungleClear'or 'LaneClear'];if not manaAbove(node.Mana:Value())then return false end
 local e=node.E:Value()and self:Ready(_E);local w=node.W:Value()and self:Ready(_W);if not e and not w then return false end
 local rows=self:Rows(kind,650);local best,count
 for _,u in ipairs(rows)do local n=1;for _,v in ipairs(rows)do if v~=u and GetDistance(u.pos,v.pos)<=self.profile.eExtra then n=math.min(3,n+1)end end
  if(not best or n>count or n==count and u.maxHealth>best.maxHealth)then best,count=u,n end
 end;if not best then return false end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 if e and(kind=='jungle'or count>=node.Count:Value())then return self:CastE(best,context,function()
  if not node.E:Value()or not Menu.Clear.SpellFarm:Value()or not manaAbove(node.Mana:Value())then return false end
  if kind=='jungle'then return true end;local n=1;for _,u in ipairs(self:Rows(kind,650))do if u~=best and GetDistance(u.pos,best.pos)<=self.profile.eExtra then n=math.min(3,n+1)end end;return n>=node.Count:Value()
 end,false)end
 return w and self:Reach(best,300)and self:CastW(best.pos,context,function()return node.W:Value()and Menu.Clear.SpellFarm:Value()and manaAbove(node.Mana:Value())and self:Current(best)end,false,function()return best.pos end)or false
end
function MonkeyKingChampion:LaneClear()return self:Clear('lane')end
function MonkeyKingChampion:JungleClear()return self:Clear('jungle')end
function MonkeyKingChampion:Flee()
 if Menu.Misc.FleeW:Value()and not self.fleeWUsed and self:CastW(mousePos,Core:ModeContext('Flee'),function()return Menu.Misc.FleeW:Value()end,false,function()return mousePos end)then self.fleeWUsed=true;return true end
 if not Menu.Misc.FleeE:Value()or not self:Ready(_E)or not point(mousePos)then return false end
 local rows=self:Rows('hero',650);for _,u in ipairs(self:Rows('lane',650))do rows[#rows+1]=u end;for _,u in ipairs(self:Rows('jungle',650))do rows[#rows+1]=u end
 local best;for _,u in ipairs(rows)do local p=self:EEndpoint(u);if p and GetDistance(p,mousePos)+150<GetDistance(myHero.pos,mousePos)and self:Safe(p,false)
  and(not best or GetDistance(p,mousePos)<GetDistance(self:EEndpoint(best),mousePos))then best=u end end
 return best and self:CastE(best,Core:ModeContext('Flee'),function()local p=self:EEndpoint(best);return Menu.Misc.FleeE:Value()and p and GetDistance(p,mousePos)+150<GetDistance(myHero.pos,mousePos)end,false)or false
end
function MonkeyKingChampion:Assist()
 if Menu.Misc.EAssist:Value()and not self.eAssistUsed then local u=GetTarget(650)
  if self:Current(u)and self:CastE(u,Core:HeldContext(function()return Menu.Misc.EAssist:Value()end),function()return Menu.Misc.EAssist:Value()end,true)then self.eAssistUsed=true;return true end
 end
 if Menu.Misc.RAssist:Value()and not self.rAssistUsed then local u=GetTarget(self.profile.rRadius)
  if self:Current(u)and self:CastR(u,Core:HeldContext(function()return Menu.Misc.RAssist:Value()end),function()return Menu.Misc.RAssist:Value()end)then self.rAssistUsed=true;return true end
 end;return false
end
-- A champion Nimbus Strike kills is finished without a mode key. It is a dash
-- onto the enemy, so every engage limit applies (wall, enemy turret, enemy count,
-- health limit, the W reserve when that option is on, per-champion consent).
function MonkeyKingChampion:Finisher()
 if self.dash or self.farm or not self:Ready(_E)then return false end
 local kind=self.profile.eKind=='physical'and 'physical'or 'magical'
 for _,u in ipairs(self:Rows('hero',650))do
  local function kills()local at=GetDistance(u.pos,myHero.pos)/1050+.3
   return self:Reach(u,650)and Core:Lethal(u,at,function()return self:Damage(u,_E)+self:CloneDamage(u,at)end,{kind=kind})end
  if self:Allowed(u)and kills()and self:CastE(u,{priority='interactive'},kills,true)then return true end
 end
 return false
end
-- A champion in attack reach the empowered attack kills: Q without a mode key.
function MonkeyKingChampion:QFinisher()
 if self.farm or self.dash or not self:Ready(_Q)then return false end
 for _,u in ipairs(self:Rows('hero',650))do
  if self:Allowed(u)and _G.SDK.Data:IsInAutoAttackRange(myHero,u)and self:QAttackKills(u)
   and self:QFirst(u,{priority='interactive'})then return true end
 end
 return false
end
local function notUnderTurret()return not IsUnderTurret2(myHero.pos)end
-- R knocks up: it stops a dangerous channel (shared catalogue, C:CanInterrupt) of a consented enemy in reach.
function MonkeyKingChampion:InterruptR()
 if not Menu.Misc.InterruptR:Value()or self.spin or not self:Ready(_R)then return false end
 for _,u in ipairs(self:Rows('hero',self.profile.rRadius))do
  if self:Allowed(u)and Core:CanInterrupt(u,.1,.05)then
   return self:CastR(u,{priority='interactive'},function()return Menu.Misc.InterruptR:Value()and Core:CanInterrupt(u,.1,.05)end,notUnderTurret,true)
  end
 end
 return false
end
-- R without a mode key when enough consented enemies are already within the spin (not under an enemy turret).
function MonkeyKingChampion:AutoR()
 if not Menu.Misc.AutoR:Value()or self.spin or not self:Ready(_R)then return false end
 local need=Menu.Misc.AutoRCount:Value();if self:RCount()<need then return false end
 local best;for _,u in ipairs(self:Rows('hero',self.profile.rRadius))do if self:Allowed(u)and(not best or GetDistance(u.pos,myHero.pos)<GetDistance(best.pos,myHero.pos))then best=u end end
 return best~=nil and self:CastR(best,{priority='interactive'},function()return Menu.Misc.AutoR:Value()and self:RCount()>=Menu.Misc.AutoRCount:Value()end,notUnderTurret,true)
end
-- Health-bar estimate (S9): empowered attack when Q is ready (else one attack), E, the R ticks it surely takes.
function MonkeyKingChampion:ComboDamage(u)
 if not IsValid(u)then return 0 end
 local total=self:Ready(_Q)and self:Damage(u,_Q)or(_G.SDK.Damage:GetAutoAttackDamage(myHero,u,true)or 0)
 if self:Ready(_E)then total=total+self:Damage(u,_E)end
 if self:Ready(_R)then local tick=self:RTick(u);if tick then total=total+tick*self:RTicks(u)end end
 return finite(total)and total or 0
end
function MonkeyKingChampion:PreparePreview()
 -- Clone contribution is informational; budget refusals retain the discovery
 -- cursor, and no gameplay continuation waits for this optional scan.
 -- No status text: the game shows spin, E and passive state. Kept for a second so a late preparation never
 -- blinks; Draw follows the clone's live position and shows the landing only while W is ready.
 self:DiscoverClone()
 local c=self:Clone()
 local wReady=self:Ready(_W)
 self.preview={expires=Game.Timer()+1,clone=c,cloneHandle=c and c.handle,landing=wReady and self:WAim(mousePos),eReady=self:Ready(_E),rReady=self:Ready(_R)}
 self.nextPreview=Game.Timer()+.15
end
function MonkeyKingChampion:FeatureStatus()
 return {clone={supported=true,reason='requires_explicit_owner_clone_marker_creation_time_and_native_list'},
  normalEvadeW={supported=self.profile.id=='normal',reason=self.profile.id=='classic'and 'classic_w_has_no_evidenced_dash_geometry'or nil},
  evadeE={supported=self.mobilityOffered==true,reason=self.mobilityOffered~=true and(self.mobilityReason or 'nimbus_dash_speed_unpublished_for_this_profile')or nil},
  classicR2={supported=false,reason='classic_has_no_recast_trait_or_owned_recast_alias'},
  stealthDefense={supported=false,reason='stealth_does_not_establish_untargetability_or_immunity'}}
end
function MonkeyKingChampion:Tick()
 if ShouldWait()or not Core:Available()then cleanup(self,'unavailable');return end
 self.allow:Maintain()
 if not Menu.Misc.EAssist:Value()then self.eAssistUsed=false end
 if not Menu.Misc.RAssist:Value()then self.rAssistUsed=false end;if GetMode()~='Flee'then self.fleeWUsed=false end
 self:ObserveEvadeClone()
 if self:ContinueDash()or self:ContinueFarm()or self:ContinueSpin()or self:Spinning()or IsCasting()then return end
 if self:ContinueEngage()or self:Assist()or self:InterruptR()or self:Finisher()or self:QFinisher()or self:AutoR()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if self:LaneClear()then return end;self:JungleClear()
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
 if self.previewFallback and(Menu.Draw.Preview:Value()or Menu.Draw.Ranges:Value())and Game.Timer()>=(self.nextPreview or 0)then self:PreparePreview()end
end
function MonkeyKingChampion:Draw()
 if myHero.dead then return end;local p=self.preview;local fresh=p and p.expires>Game.Timer()
 -- Ranges of ready abilities only, from the prepared preview (no readiness reads here).
 if Menu.Draw.Ranges:Value()and fresh then
  if p.eReady then Draw.Circle(myHero.pos,650,1,Draw.Color(255,150,200,255))end
  if p.rReady then Draw.Circle(myHero.pos,self.profile.rRadius,1,Draw.Color(255,255,180,100))end
 end
 if fresh and Menu.Draw.Preview:Value()then
  local c=p.clone;if c and not c.dead and c.handle==p.cloneHandle and point(c.pos)then Draw.Circle(c.pos,80,1,Draw.Color(255,100,255,200))end
  if p.landing then Draw.Circle(p.landing,45,1,Draw.Color(255,255,220,100))end
 end
end
function MonkeyKingChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Wukong: modes','Wukong: assistance'},function(page)return {title='Wukong',cards=page==1 and {
  {'MODES','Use provider Combo, Harass, separate Lane/Jungle, LastHit and Flee. Q follows a landed attack. Combo dashes in with E, uses W and spins with R when enough enemies are in reach; Harass keeps the dash and W off by default.'},
  {'FARM','Abilities farm only while the spell-farm toggle is on. LastHit Q and E are used on minions an attack cannot take.'},
  {'ENGAGE','Choose whether E or W goes first. E never dashes into a wall, under an enemy turret, below the health limit or into more enemies than configured; a long E dash can wait for W. Q goes first when it lets the attack reach or the empowered attack kills; R also spins when its ticks kill the target.'}}or {
  {'ASSIST','Hold the E bind for a safe Nimbus to the selected champion and the R bind for a nearby Cyclone. Press R yourself to stop spinning. Releasing a bind cancels what was not sent yet.'},
  {'PROFILES','Normal has a moving mimicking clone, magic Nimbus and two spins. Classic has a stationary explosive decoy, physical Nimbus and one spin.'},
  {'DEFENSE','Normal offers W and Nimbus Strike onto a unit to Evade as dodges; Classic offers Nimbus Strike only. Stealth is not treated as immunity. Classic Flee W uses stealth; escape E needs an existing reachable enemy. An enemy champion Nimbus Strike kills is finished without a mode key, inside the engage limits. Without a mode key R stops a dangerous channel and spins when enough enemies are around; Q follows your own attack on a champion.'}}}end)
end
Core:StandardPolicy(MonkeyKingChampion,{damageTypes={Q='physical'},
 channel=function(self)return not self:Spinning()and not Core:SelfChanneling()end,
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot,slot==_R and self.spin and self.spin.observed)end;return true end})
MonkeyKingChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Wukong"]="MonkeyKing"}
local normalSupported={["MonkeyKing"]=true}

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
