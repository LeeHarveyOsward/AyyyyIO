return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("105d25b3d528397643ce147540e7b847313529612ff58156df19d70a7c09ae91")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("04b3201d7674a3b04c12a7732b3345f73bbccf0f40cfb72203e846891e06f379")
modules.championProfiles=(function()
local factories={}
factories["Lulu"]=function()return _G.OrbamaFamily:Require("1c71573de449468bf65911ab2d7d66d123c04d24b76c3e208f693c8d46d2e7f1")()end
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
if champion=="Lulu" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Lulu',profiles={normal=true,classic=true},
 Create=function(context)
-- Independent implementation. Installed profiles and comparison families are
-- pinned in CombatProfiles/lulu-provenance.json; sends never manufacture Pix.
local profiles=ChampionProfiles('Lulu')
local finite,id,point,own,expiry,manaAbove=Core.finite,Core.id,Core.point,Core.mine,Core.buffExpiry,Core.manaAbove
local readyAttack={attack='ready'}
local function cleanup(self)self.pix=nil;self.transfer=nil;self.preview=nil;self.ranges=nil;self.wProbe=nil;self.defenseReject=nil;self.allySettings={}end
local LuluChampion=class("LuluChampion")
function LuluChampion:__init()
 self.profile=assert(profiles[myHero.charName]);self.eMinions=self.profile.id~='normal';self.QRange=950;self.WRange=650;self.ERange=650;self.RRange=900
 self.QSpell={Type=OrbamaPrediction.SPELLTYPE_LINE,Delay=.25,Radius=60,Range=950,Speed=1450,Collision=false}
 self.EImpact={Delay=self.profile.eDelay,Speed=math.huge}
 self.WAllyImpact={Delay=self.profile.wDelay,Speed=self.profile.wAllySpeed}
 self.WEnemyImpact={Delay=self.profile.wDelay,Speed=self.profile.wSpeed}
 self.RImpact={Delay=self.profile.rDelay,Speed=math.huge}
 self.allySettings={};self:LoadMenu();self:DiscoverAllies();self.objectIndex=1
 self.wConsent=Core:TargetConsent(Menu.Support.WTargets,self,'Polymorph: ','W');self.wConsent:Refresh()
 Callback.Add('Tick',function()self:Tick()end);Callback.Add('Draw',function()self:Draw()end)
 Core:RegisterCleanup('Lulu',function()cleanup(self)end)
 local ok,why=Core:RegisterPreparation('Lulu.preview',{intervalMs=150,maxDelayMs=500,units=2,maxUnits=2},
  function()self:PreparePreview();return true end,function()return Menu.Draw.Preview:Value()end,function()self.preview=nil end)
 self.preparation=ok;self.previewFallback=not ok and why=='unsupported'
 self:RegisterDefense()
 Core:RegisterComboDamage(function(u)return self:ComboDamage(u),true end)
end
function LuluChampion:LoadMenu()
 Menu=MenuElement({type=MENU,id='Classic_AIO_'..myHero.charName,name='AyyyyIO - Lulu'})
 for _,mode in ipairs({'Combo','Harass'})do
  Menu:MenuElement({type=MENU,id=mode,name=mode})
  for _,slot in ipairs({'Q','W','E'})do Menu[mode]:MenuElement({id=slot,name='Use '..slot,value=mode=='Combo'or slot~='W'})end
  Menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Combo'and 15 or 40,min=0,max=100,step=5})
 end
 Menu.Combo:MenuElement({id='AllyW',name='Use W to empower an attacking ally',value=true})
 Menu.Combo:MenuElement({id='R',name='Use R on an ally to knock up enemies',value=true})
 Menu.Combo:MenuElement({id='RCount',name='R must knock up this many enemies',value=2,min=1,max=5,step=1})
 Menu.Harass:MenuElement({id='Transfer',name='Send Pix with E to reach a far target with Q',value=true})
 Menu:MenuElement({type=MENU,id='Support',name='Protect allies without holding a mode key'})
 Menu.Support:MenuElement({id='W',name='Polymorph attackers, divers and channels (W)',value=true})
 Menu.Support:MenuElement({id='WDash',name='Polymorph enemies dashing at you (W)',value=true,menu=false})
 Menu.Support:MenuElement({id='AllyW',name='Speed up an ally fighting a champion (W)',value=true})
 Menu.Support:MenuElement({id='EWindup',name='Use E on an ally who is attacking an enemy',value=false})
 Menu.Support:MenuElement({id='R',name='Save a low, stunned or heavily hit ally (R)',value=true})
 Menu.Support:MenuElement({id='RHP',name='Save allies with R below health %',value=30,min=5,max=90,step=5})
 Menu.Support:MenuElement({id='RKnockup',name='Knock up enemies around an ally without Combo (R)',value=true})
 Menu.Support:MenuElement({id='RKnockCount',name='Without Combo, R must knock up this many enemies',value=3,min=1,max=5,step=1})
 Menu.Support:MenuElement({id='QImmobile',name='Hit enemies who cannot move with Q',value=true})
 Menu.Support:MenuElement({id='Mana',name='Only above mana %',value=10,min=0,max=100,step=5})
 -- One entry per ally (player menu standard 2026-10-11): who is helped first, 0 never helps that ally.
 Menu.Support:MenuElement({type=MENU,id='Priorities',name='Ally priority (0 = never help)'})
 Menu.Support:MenuElement({type=MENU,id='WTargets',name='Polymorph with W'})
 Menu:MenuElement({type=MENU,id='Clear',name='Farming'})
 Menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=SpellFarmDefault(),toggle=true,key=73,callback=function(v)CheckChatBlock(Menu.Clear.SpellFarm,v)end})
 for _,kind in ipairs({'LaneClear','JungleClear'})do
  Menu.Clear:MenuElement({type=MENU,id=kind,name=kind})
  Menu.Clear[kind]:MenuElement({id='Q',name='Use Q',value=true})
  if self.eMinions then Menu.Clear[kind]:MenuElement({id='E',name='Use E',value=true})end
  Menu.Clear[kind]:MenuElement({id='Mana',name='Only above mana %',value=30,min=0,max=100,step=5})
 end
 Menu.Clear.LaneClear:MenuElement({id='Count',name='Lane minions Q must hit',value=3,min=1,max=10,step=1})
 Menu:MenuElement({type=MENU,id='LastHit',name='LastHit'})
 Menu.LastHit:MenuElement({id='Q',name='Use Q on minions an attack cannot take',value=true})
 if self.eMinions then Menu.LastHit:MenuElement({id='E',name='Use E on minions an attack cannot take',value=true})end
 Menu.LastHit:MenuElement({id='Mana',name='Only above mana %',value=20,min=0,max=100,step=5})
 Menu:MenuElement({type=MENU,id='Misc',name='Behaviour'})
 Menu.Misc:MenuElement({id='QAssist',name='Q the selected target (E first if far)',key=string.byte('T')})
 Menu.Misc:MenuElement({id='RAssist',name='Cast R on an ally in danger',key=string.byte('U')})
 Menu.Misc:MenuElement({id='FleeW',name='Use W to escape in Flee',value=true})
 Menu.Misc:MenuElement({id='FleeQ',name='Use Q to slow a chasing enemy in Flee',value=true})
 Menu:MenuElement({type=MENU,id='Draw',name='Drawings'})
 Menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
 Menu.Draw:MenuElement({id='Preview',name='Q range from Pix',value=true})
end
function LuluChampion:Ready(slot)
 local d=myHero:GetSpellData(slot);local key=({[0]='q',[1]='w',[2]='e',[3]='r'})[slot]
 return key and d and d.name==self.profile[key]and finite(d.level)and d.level%1==0 and d.level>=1 and d.level<=(slot==_R and 3 or 5)
  and finite(d.currentCd)and d.currentCd==0 and Game.CanUseSpell(slot)==0 and finite(d.mana)and d.mana>=0 and d.mana<=myHero.mana or false
end
-- side: 'ally' (the player first) | 'enemy'.
function LuluChampion:Rows(side,range)return Core:Rows('hero',range,side=='ally'and 'self')end
function LuluChampion:FarmRows(kind)return Core:Rows(kind,2250)end
function LuluChampion:Current(u)return u~=nil and point(u.pos)~=nil and Core:CurrentUnit(u,u.team==myHero.team)end
function LuluChampion:DiscoverAllies()
 for _,u in ipairs(self:Rows('ally',3000))do if not self.allySettings[id(u)]then local key=StableUnitMenuKey(self,'A',u)
  Menu.Support.Priorities:MenuElement({id=key,name=u.charName,value=self:RolePriority(u),min=0,max=5,step=1,from='Automation.Support.Allies.'..key..'.Priority'})
  self.allySettings[id(u)]={node=Menu.Support.Priorities[key],handle=u.handle}
 else self.allySettings[id(u)].handle=u.handle end end;self.nextDiscovery=Game.Timer()+1
end
-- First-discovery default: the provider's carry priority 5 (marksmen, hyper-carries) starts at 5, everyone else
-- at 3. A saved value is the player's choice and is never touched. Classic names use the base champion's row.
function LuluChampion:RolePriority(u)
 local data=_G.SDK and _G.SDK.Data;local heroes=data and type(data.HEROES)=='table'and data.HEROES
 local name=type(u.charName)=='string'and(u.charName:match('^Jade_(.+)$')or u.charName)
 local row=heroes and name and heroes[name]
 return type(row)=='table'and row[1]==5 and 5 or 3
end
-- An ally with priority 0 gets no E, W or R (`slot` is kept for the callers).
function LuluChampion:AllyAllowed(u,slot)local row=self.allySettings[id(u)];return row and row.handle==u.handle and row.node:Value()>0 or false end
-- The health below which R saves `u`.
function LuluChampion:RLine(u)return Menu.Support.RHP:Value()/100*u.maxHealth end
-- W polymorph consent per enemy champion (rerank menu_ux); allies and non-champions need none.
function LuluChampion:PolymorphAllowed(u)return u.team==myHero.team or self.wConsent==nil or self.wConsent:Allowed(u)==true end
function LuluChampion:Priority(u)local row=self.allySettings[id(u)];return row and row.node:Value()or 1 end
-- The player's own single active buff of that name; a foreign, unattributed or duplicate copy is nil.
function LuluChampion:Buff(u,name)return(Core:OwnBuff(u,name,true,true))end
function LuluChampion:ShieldValue()
 local d=myHero:GetSpellData(_E);local base=self.profile.shield[d.level]
 return base and finite(myHero.ap)and math.max(0,base+self.profile.shieldAP*myHero.ap)or 0
end
function LuluChampion:RHealth()
 local base=self.profile.rHealth[myHero:GetSpellData(_R).level]
 return base and finite(myHero.ap)and math.max(0,base+self.profile.rAP*myHero.ap)or 0
end
function LuluChampion:GetQDmg(u)
 local base=self.profile.qBase[myHero:GetSpellData(_Q).level]
 return base and finite(myHero.ap)and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,(base+.5*myHero.ap)*(u.type==Obj_AI_Minion and self.profile.qMinion or 1))or 0
end
function LuluChampion:GetEDmg(u)
 if self.profile.id=='normal'and u.type~=Obj_AI_Hero then return 0 end
 local base=self.profile.eBase[myHero:GetSpellData(_E).level]
 return base and finite(myHero.ap)and _G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_MAGICAL,base+self.profile.eAP*myHero.ap)or 0
end
-- Where a champion will be in `h` seconds on its current native path (dash end, or walking at move speed).
local function ahead(u,h)
 local path=u.pathing;local to=path and path.endPos
 if not path or not point(to)then return u.pos end
 if path.isDashing then return to end
 if not path.hasMovePath or not finite(u.ms)or u.ms<=0 then return u.pos end
 if GetDistance(u.pos,to)<=u.ms*h then return to end
 return u.pos:Extended(to,u.ms*h)
end
-- Health-bar damage (shared display): ready Q and E on a champion, plus one attack.
function LuluChampion:ComboDamage(u)
 local total=_G.SDK.Damage:CalculateDamage(myHero,u,_G.SDK.DAMAGE_TYPE_PHYSICAL,finite(myHero.totalDamage)and myHero.totalDamage or 0)
 if self:Ready(_Q)then total=total+self:GetQDmg(u)end
 if self:Ready(_E)then total=total+self:GetEDmg(u)end
 return total
end
function LuluChampion:PixValid(row)
 if not row or type(Game.Object)~='function'then return nil end
 local u=Game.Object(row.index)
 if not u or u.valid~=true or u.dead==true or id(u)~=row.id or u.handle~=row.handle or u.name~='RobotBuddy'
  or not own(u.owner)or not point(u.pos)then return nil end
 local ends=expiry(u);if ends~=nil and(not finite(ends)or ends>0 and ends<=Game.Timer())then return nil end
 return u
end
function LuluChampion:DiscoverPix()
 if type(Game.ObjectCount)~='function'or type(Game.Object)~='function'then self.pix=nil;return end
 if self.pix and not self:PixValid(self.pix)then self.pix=nil end
 local count=Game.ObjectCount();if not finite(count)or count%1~=0 or count<0 then return end
 for _=1,math.min(count,16)do if self.objectIndex>count then self.objectIndex=1 end
  local index=self.objectIndex;self.objectIndex=index+1;local u=Game.Object(index)
  if u and u.name=='RobotBuddy'and own(u.owner)then local row={index=index,id=id(u),handle=u.handle}
   if self:PixValid(row)then self.pix=row;break end
  end
 end
end
function LuluChampion:Origins()
 local rows={myHero};local pix=self:PixValid(self.pix)
 if pix and GetDistance(pix.pos,myHero.pos)>1 then rows[2]=pix end;return rows
end
function LuluChampion:QGeometry(u,aim,origins,predicted,scopedCurrent)
 if not point(aim)or not(scopedCurrent or self:Current(u))or GetDistance(aim,myHero.pos)>2250 or type(OrbamaPrediction.GetCollision)~='function'then return nil end
 local rays={};local hit=false
 for _,origin in ipairs(origins or self:Origins())do local length=GetDistance(aim,origin.pos)
  if length>=1 then local endpoint=origin.pos:Extended(aim,950);local target=predicted or u.pos
   if predicted and predicted.sources then target=nil
    for _,row in ipairs(predicted.sources)do if row.id==id(origin)and row.handle==origin.handle then target=row.pos;break end end
   end
   if target then
   local dx,dz=endpoint.x-origin.pos.x,endpoint.z-origin.pos.z;local x,z=target.x-origin.pos.x,target.z-origin.pos.z
   local along=(x*dx+z*dz)/950;local cross=math.abs(x*dz-z*dx)/950
   if along>=0 and along<=950 and cross<=60 then
    local wall,_,count=OrbamaPrediction:GetCollision(origin.pos,endpoint,1450,.25,60,{OrbamaPrediction.COLLISION_YASUOWALL},id(u))
    if wall==false and finite(count)and count==0 then rays[#rays+1]={origin=origin,endpoint=point(endpoint)};hit=true end
   end
   end
  end
 end;return hit and rays or nil
end
function LuluChampion:QPlan(u)
 if not self:Ready(_Q)or not self:Current(u)or u.team==myHero.team or GetDistance(u.pos,myHero.pos)>2250 then return nil end
 local origins=self:Origins();local pred=Core:Prediction(self.QSpell);local candidates={};local targets={sources={}}
 for _,origin in ipairs(origins)do if GetDistance(u.pos,origin.pos)<=950 then
  pred:GetPrediction(u,origin);local aim,unitPos=point(pred.CastPosition),point(pred.UnitPosition)
  if pred:CanHit(2)and aim and unitPos then candidates[#candidates+1]={aim=aim,origin=origin}
   targets.sources[#targets.sources+1]={id=id(origin),handle=origin.handle,pos=unitPos}
  end
 end end
 for _,candidate in ipairs(candidates)do local rays=self:QGeometry(u,candidate.aim,origins,targets)
  if rays then local primary=false;for _,ray in ipairs(rays)do if ray.origin==candidate.origin then primary=true end end
   if primary then return {position=point(candidate.aim),target=targets,rays=rays,origin=id(candidate.origin),originHandle=candidate.origin.handle}end
  end
 end
end
function LuluChampion:CastQ(u,context,permission)
 if permission and not permission()then return false end;local plan=self:QPlan(u);if not plan then return false end;local handle=u.handle
 local function resolve()
  if u.handle~=handle or permission and not permission()then return nil,'q_context_changed'end
  local fresh=self:QPlan(u);if not fresh then return nil,'q_origins_changed'end
  return {position=fresh.position,data={target=fresh.target,origin=fresh.origin,originHandle=fresh.originHandle}}
 end
 -- Q accepts a world aim (asset command range 25000). Each actual bolt is
 -- limited independently to 950; the union search/transport budget is 2250.
 return Core:Cast(HK_Q,plan.position,{intentTarget=u,context=context,range=2250,resolve=resolve,prevalidateWorldCast=true,deferAttackWindup=true,
  validate=function(q,r)
   if not self:Ready(_Q)or u.handle~=handle or not self:Current(u)or permission and not permission()or not r or not r.data then return false end
   local origins=self:Origins();local valid=false
   for _,o in ipairs(origins)do if id(o)==r.data.origin and o.handle==r.data.originHandle then valid=true end end
   return valid and self:QGeometry(u,r.position,origins,r.data.target)~=nil
  end})
end
function LuluChampion:CastTarget(slot,u,context,permission,observation)
 local range=slot==_R and 900 or 650
 if not self:Ready(slot)or not self:Current(u)or GetDistance(u.pos,myHero.pos)>range or permission and not permission()then return false end
 if u.team==myHero.team and not self:AllyAllowed(u,slot==_E and 'E'or slot==_R and 'R'or 'W')then return false end
 if slot==_W and not self:PolymorphAllowed(u)then return false end
 if slot==_E and u.team~=myHero.team and self:GetEDmg(u)<=0 then return false end
 local handle=u.handle;local key=({[1]=HK_W,[2]=HK_E,[3]=HK_R})[slot]
 if not observation and slot==_E then observation=function(q)
  local a=Core:NativeCast(q,self.profile.e)
  return a and(a.target==id(u)or a.target==handle)
   and u.handle==handle and self:Current(u)
 end end
 local ok=Core:Cast(key,u,{context=context,range=range,observe=observation,validate=function()
  return self:Ready(slot)and u.handle==handle and self:Current(u)and GetDistance(u.pos,myHero.pos)<=range
   and(u.team~=myHero.team or self:AllyAllowed(u,slot==_E and 'E'or slot==_R and 'R'or 'W'))and(slot~=_W or self:PolymorphAllowed(u))
   and(not permission or permission())
 end})
 if ok and slot==_W and u.team~=myHero.team and u.type==Obj_AI_Hero then self:BeginWProbe(u,Core.lastIntent)end
 return ok
end
-- Development evidence for two open numbers: when the polymorph lands after our W (cast time: asset .175 s,
-- wiki .2419 s) and whether it stops a cast the enemy is winding up (Lulu-7 stays off until that is known).
function LuluChampion:BeginWProbe(u,intent)
 local a=u.activeSpell
 self.wProbe={unit=u,handle=u.handle,intent=intent,started=Game.Timer(),expires=Game.Timer()+1.5,
  cast=a and a.valid and not Core:IsAttackCast(a)and finite(a.castEndTime)and a.castEndTime>Game.Timer()and {name=a.name,start=a.startTime,ends=a.castEndTime}or nil}
end
function LuluChampion:MaintainWProbe()
 local p=self.wProbe;if not p then return end
 local now=Game.Timer();local u=p.unit;local r=p.intent and Core.adapter:Poll(p.intent.id)
 if r and r.sentAt and not p.sentGame then p.sentGame=now end
 if p.sentGame and not p.landed and finite(u.buffCount)and u.buffCount>=0 and u.buffCount<=128 then
  for i=0,u.buffCount do local b=u:GetBuff(i)
   if b and type(b.name)=='string'and b.name:lower():find('luluw',1,true)and finite(b.count)and b.count>0 then p.landed=now;p.buff=b.name;break end
  end
 end
 if p.cast and not p.stopped then local a=u.activeSpell
  if not a or not a.valid or a.startTime~=p.cast.start or a.isStopped then p.stopped=now end
 end
 if now>p.expires or u.handle~=p.handle or p.landed and(not p.cast or p.stopped or now>p.cast.ends)then
  Core:Trace('lulu_w_probe',{target=u.charName,sentAfter=p.sentGame and p.sentGame-p.started,landedAfterSend=p.landed and p.sentGame and p.landed-p.sentGame,
   buff=p.buff,cast=p.cast and p.cast.name,castEndsAfterLanding=p.cast and p.landed and p.cast.ends-p.landed,stoppedEarly=p.cast and p.stopped~=nil and p.stopped<p.cast.ends or nil},.5)
  self.wProbe=nil
 end
end
function LuluChampion:RegisterDefense()
 if not Core.RegisterShield then return false end
 local function capacityKnown()
  -- Base capacity alone cannot certify survival under an unmodeled shield
  -- reduction. Keep ordinary assistance available; only suppress this forecast.
  local count=myHero.buffCount
  if not finite(count)or count%1~=0 or count<0 or count>128 then self.defenseReject='shield_buff_state_unreadable';return false end
  for i=0,count do local b=myHero:GetBuff(i)
   if b then
    if not finite(b.count)or b.count<0 then self.defenseReject='shield_buff_state_unreadable';return false end
    if b.count>0 then local ends=expiry(b)
     if not finite(ends)or ends>Game.Timer()then self.defenseReject='unknown_shield_modifier_state';return false end
    end
   end
  end;self.defenseReject=nil;return true
 end
 -- The shared timed-shield offer: Evade judges the danger, so neither the
 -- support mana limit nor the per-ally switch applies to the player's own dodge.
 local ok,why,adapter=Core:RegisterShield({name='Lulu.E',slot=_E,key=HK_E,profile=self.profile.id,spell=self.profile.e,
  source=self.profile.shieldSource,amount=function()return self:ShieldValue()end,duration=self.profile.shieldDuration,delay=self.profile.eDelay,
  ready=function()return capacityKnown()and not self:Buff(myHero,self.profile.shieldBuff)end,target=function()return myHero end,kind='object'})
 self.defense=adapter
 -- Wild Growth's health works as protection for its duration. It is the ultimate:
 -- offered only under the same bound as the automatic save (its switch and the
 -- health limit), so a hit the player survives comfortably never spends it.
 local p=self.profile
 local _,_,rAdapter=Core:RegisterShield({name='Lulu.R',slot=_R,key=HK_R,profile=p.id,spell=p.r,source=p.rSource,
  amount=function()local base=p.rHealth[myHero:GetSpellData(_R).level];return base and finite(myHero.ap)and base+p.rOfferAP*math.max(0,myHero.ap)or 0 end,
  duration=p.rDuration,delay=p.rDelay,target=function()return myHero end,kind='object',
  ready=function()return Menu.Support.R:Value()and myHero.maxHealth>0 and myHero.health<=self:RLine(myHero)end})
 self.rDefense=rAdapter;return ok,why
end
-- What is about to hit `u` (Core:AllyThreat: champion attack, targeted cast,
-- turret shot, tracked skillshot). `minimum` is the time our own cast needs: an
-- attack or skillshot landing sooner cannot be answered any more. champions=true
-- leaves turrets out (the ultimate is not spent on turret or minion chip damage).
function LuluChampion:Threat(u,minimum,champions)
 local t=Core:AllyThreat(u,1.5,champions and {turrets=false}or nil)
 if t and(t.kind=='cast'or t.kind=='turret'or t.impactIn>=minimum)then return t end
end
function LuluChampion:AutoShield()
 if not manaAbove(Menu.Support.Mana:Value())or not self:Ready(_E)or self:ShieldValue()<=0 then return false end
 local best,threat,score;local minimum=OrbamaPrediction:GetLaunchDelay(self.EImpact)+.05
  for _,u in ipairs(self:Rows('ally',650))do if self:AllyAllowed(u,'E')and not self:Buff(u,self.profile.shieldBuff)then local t=self:Threat(u,minimum)
  if t then local value=self:Priority(u)*1000+(1-u.health/u.maxHealth)*100
   if not best or value>score then best,threat,score=u,t,value end
  end
 end end
 return best and self:CastTarget(_E,best,{priority='critical'},function()return manaAbove(Menu.Support.Mana:Value())
   and not self:Buff(best,self.profile.shieldBuff)and threat.valid()end)or false
end
function LuluChampion:Channel(u,token)
  local a=u.activeSpell;return self:Current(u)and Core:CanInterrupt(u,OrbamaPrediction:GetImpactTime(self.WEnemyImpact,u.pos,myHero),.05)
  and(not token or a.startTime==token.start and a.name==token.name)
end
function LuluChampion:AutoW(context,permission)
 if not self:Ready(_W)or not Menu.Support.W:Value()or not manaAbove(Menu.Support.Mana:Value())then return false end
 for _,u in ipairs(self:Rows('enemy',650))do if self:PolymorphAllowed(u)and self:Channel(u)then local token={start=u.activeSpell.startTime,name=u.activeSpell.name}
  return self:CastTarget(_W,u,context or {priority='critical'},function()return Menu.Support.W:Value()and manaAbove(Menu.Support.Mana:Value())
   and self:Channel(u,token)and(not permission or permission())end)
 end end
 -- A diver: an enemy dashing onto the player or onto an ally W may protect.
 if Menu.Support.WDash:Value()then local allies=self:Rows('ally',1200)
  local function diving(u)
   if Core:ApproachingDash(u,myHero.pos,650)then return true end
   for i=2,#allies do local ally=allies[i];if self:AllyAllowed(ally,'W')and Core:ApproachingDash(u,ally.pos,300)then return true end end
   return false
  end
  for _,u in ipairs(self:Rows('enemy',650))do
   if self:PolymorphAllowed(u)and diving(u)and Core:SpellProtected(u)==false then
    return self:CastTarget(_W,u,context or {priority='critical'},function()return Menu.Support.W:Value()and Menu.Support.WDash:Value()
     and manaAbove(Menu.Support.Mana:Value())and(not permission or permission())and diving(u)and Core:SpellProtected(u)==false end)
   end
  end
 end
  -- An engage that is neither a channel nor a dash (profile catalogue by buff name), closing on Lulu or an ally.
  for _,u in ipairs(self:Rows('enemy',650))do local name=self:PolymorphAllowed(u)and self:Engaging(u)
   if name and Core:SpellProtected(u)==false then
    return self:CastTarget(_W,u,context or {priority='critical'},function()return Menu.Support.W:Value()and manaAbove(Menu.Support.Mana:Value())
     and(not permission or permission())and self:Engaging(u)==name and Core:SpellProtected(u)==false end)
   end
  end
  -- A melee champion about to land the first hit on a weak or high-priority ally (or Lulu).
  local melee,victim=self:MeleePeel()
  if melee then
   return self:CastTarget(_W,melee,context or {priority='critical'},function()return Menu.Support.W:Value()and manaAbove(Menu.Support.Mana:Value())
    and(not permission or permission())and select(2,self:MeleePeel())==victim and Core:SpellProtected(melee)==false end)
  end
  -- A champion attacking or casting at an ally is polymorphed when W lands first.
  local best,attacker,threat,score
  for _,u in ipairs(self:Rows('ally',1200))do if self:AllyAllowed(u,'W')then local t=Core:AllyThreat(u,1.5,{turrets=false,skillshots=false})
   local e=t and t.source
   if e and e.type==Obj_AI_Hero and self:PolymorphAllowed(e)and GetDistance(e.pos,myHero.pos)<=650 and t.impactIn>OrbamaPrediction:GetImpactTime(self.WEnemyImpact,e.pos,myHero)+.05 then
   local value=self:Priority(u)*1000+(1-u.health/u.maxHealth)*100
   if not best or value>score then best,attacker,threat,score=u,e,t,value end
  end
 end end
 return best and self:CastTarget(_W,attacker,context or {priority='critical'},function()return Menu.Support.W:Value()and manaAbove(Menu.Support.Mana:Value())
   and self:AllyAllowed(best,'W')and threat.valid()and(not permission or permission())end)or false
end
function LuluChampion:Engaging(u)
 local list=self.profile.wEngage;if not list or not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 then return nil end
 for i=0,u.buffCount do local b=u:GetBuff(i);local name=b and type(b.name)=='string'and b.name:lower()
  if name and list[name]and finite(b.count)and b.count>0 and(expiry(b)or 0)>Game.Timer()then
   Core:Trace('lulu_engage_state',{name=name,isChanneling=u.activeSpell and u.activeSpell.isChanneling,isInterruptible=u.activeSpell and u.activeSpell.isInterruptible},2)
   -- Closing: 0.25 s ahead on its path it is nearer to Lulu or to an ally W may protect.
   local later=ahead(u,.25)
   for _,ally in ipairs(self:Rows('ally',1200))do
    if(ally==myHero or self:AllyAllowed(ally,'W'))and GetDistance(later,ally.pos)<GetDistance(u.pos,ally.pos)-10 and GetDistance(u.pos,ally.pos)<=900 then return name end
   end
   return nil
  end
 end
end
-- The melee enemy (attack range under 300) within its attack reach + 100 of Lulu or of an allowed ally that is
-- below 60% health or priority 4 or more, and not moving away. Returns enemy, ally.
function LuluChampion:MeleePeel()
 for _,ally in ipairs(self:Rows('ally',1200))do
  local weak=ally==myHero or self:AllyAllowed(ally,'W')and(ally.maxHealth>0 and ally.health/ally.maxHealth<.6 or self:Priority(ally)>=4)
  if weak then
   for _,u in ipairs(self:Rows('enemy',650))do
    if finite(u.range)and u.range<300 and self:PolymorphAllowed(u)then
     local reach=u.range+(u.boundingRadius or 65)+(ally.boundingRadius or 65)+100;local d=GetDistance(u.pos,ally.pos)
     if d<=reach and GetDistance(ahead(u,.25),ally.pos)<=d+5 then return u,ally end
    end
   end
  end
 end
end
-- Enemies R knocks up around `u`: their position on their current path at R's landing, inside the radius.
function LuluChampion:RCount(u)
 local h=OrbamaPrediction:GetLaunchDelay(self.RImpact);if not finite(h)then h=self.profile.rDelay end
 local center=ahead(u,h);local n=0
 for _,enemy in ipairs(self:Rows('enemy',1400))do if GetDistance(ahead(enemy,h),center)<=self.profile.rRadius then n=n+1 end end;return n
end
-- The allowed ally (Lulu included) whose R knocks up the most enemies (at least `count`), then priority.
function LuluChampion:KnockupAlly(count)
 local best,score
 for _,ally in ipairs(self:Rows('ally',900))do if self:AllyAllowed(ally,'R')then local n=self:RCount(ally)
  if n>=count then local value=n*100+self:Priority(ally);if not best or value>score then best,score=ally,value end end
 end end
 return best
end
function LuluChampion:KnockupR(count,context,permission)
 if not self:Ready(_R)or not count()then return false end
 local best=self:KnockupAlly(count());if not best then return false end
 return self:CastTarget(_R,best,context,function()return permission()and self:RCount(best)>=count()end)
end
-- Damage of the enemy champion attacks already winding up or in flight at `u` that land between `minimum` and
-- 1.5 s (one per attacker, the provider's attack estimate). nil when one of them has no estimate.
function LuluChampion:IncomingAttackDamage(u,minimum)
 local total,now=0,Game.Timer()
 for _,enemy in ipairs(self:Rows('enemy',2000))do
  local cast=Core:CastWindup(enemy,-1,1.25,true,u.networkID,u.handle)
  local speed=enemy.attackData and enemy.attackData.projectileSpeed
  if cast and(speed==math.huge or finite(speed)and speed>0)then
   local impact=cast.castEndTime+(speed==math.huge and 0 or GetDistance(enemy.pos,u.pos)/speed)-now
   if impact>=minimum and impact<=1.5 then
    local ok,damage=pcall(_G.SDK.Damage.GetAutoAttackDamage,_G.SDK.Damage,enemy,u)
    if not ok or not finite(damage)or damage<0 then return nil end
    total=total+damage
   end
  end
 end
 return total
end
-- Why `u` needs Wild Growth now, or nil: below the health line with an attributed champion threat; below it
-- under hard crowd control with an enemy champion within its attack range + 100; or the attacks already on
-- their way take it below the line.
function LuluChampion:SaveReason(u,minimum)
 if not self:AllyAllowed(u,'R')or not finite(u.maxHealth)or u.maxHealth<=0 then return nil end
 local line=self:RLine(u)
 if u.health<=line then
  local t=self:Threat(u,minimum,true);if t then return 'threat',t end
  local cc=GetHardCCDuration(u)
  if finite(cc)and cc>minimum then
   for _,enemy in ipairs(self:Rows('enemy',1500))do
    if finite(enemy.range)and GetDistance(enemy.pos,u.pos)<=enemy.range+(enemy.boundingRadius or 65)+(u.boundingRadius or 65)+100 then return 'controlled'end
   end
  end
  return nil
 end
 local damage=self:IncomingAttackDamage(u,minimum)
 if damage and damage>0 and u.health+(finite(u.shieldAD)and u.shieldAD or 0)-damage<=line then return 'incoming'end
end
function LuluChampion:RescueR(context,permission)
 if not self:Ready(_R)or not manaAbove(Menu.Support.Mana:Value())or permission and not permission()then return false end
 -- Champion damage only: an enemy champion's attack, targeted cast, tracked skillshot, a champion next to a
 -- controlled ally, or attacks on their way. Turret shots and minion attacks never spend the ultimate.
 local best,reason,threat,score;local minimum=OrbamaPrediction:GetLaunchDelay(self.RImpact)+.05
 for _,u in ipairs(self:Rows('ally',900))do local why,t=self:SaveReason(u,minimum)
  if why then local value=self:Priority(u)*1000+(1-u.health/u.maxHealth)*100;if not best or value>score then best,reason,threat,score=u,why,t,value end end
 end
 return best and self:CastTarget(_R,best,context or {priority='critical'},function()
   if permission and not permission()or not manaAbove(Menu.Support.Mana:Value())then return false end
   local why=self:SaveReason(best,minimum)
   return why==reason and(why~='threat'or threat.valid())end)or false
end
function LuluChampion:AllyW(context,permission)
 if not self:Ready(_W)then return false end;local best,score,token
 local enemies=self:Rows('enemy',2000)
 for _,u in ipairs(self:Rows('ally',650))do local a=Core:CastWindup(u,OrbamaPrediction:GetImpactTime(self.WAllyImpact,u.pos,myHero)+.05,1.5,self.profile.wAS)
  if self:AllyAllowed(u,'W')and a and not a.isChanneling then
   for _,enemy in ipairs(enemies)do if a.target==id(enemy)or a.target==enemy.handle then
    local value=self:Priority(u)*1000
    if not best or value>score then best,score,token=u,value,a end;break
   end end
  end
 end
 return best and self:CastTarget(_W,best,context,function()return(not permission or permission())
  and Core:MatchesCastWindup(best,token,OrbamaPrediction:GetImpactTime(self.WAllyImpact,best.pos,myHero)+.05,1.5,self.profile.wAS)end)or false
end
-- An ally powering up (attack steroid by native cast name, Normal catalogue) with an enemy champion within its
-- attack range + 300: W speeds it up. A name the host does not use never matches.
function LuluChampion:Steroid(u)
 local list=self.profile.wSteroids;local a=u.activeSpell;local now=Game.Timer()
 if not list or not a or not a.valid or type(a.name)~='string'or not list[a.name:lower()]or not finite(a.startTime)or a.startTime>now or now-a.startTime>.6 then return nil end
 local reach=(finite(u.range)and u.range or 500)+300
 for _,enemy in ipairs(self:Rows('enemy',reach+200))do if GetDistance(enemy.pos,u.pos)<=reach then return a.name..':'..a.startTime end end
end
function LuluChampion:SteroidW(context,permission)
 if not self:Ready(_W)or not self.profile.wSteroids then return false end
 local best,token,score
 for _,u in ipairs(self:Rows('ally',650))do if u~=myHero and self:AllyAllowed(u,'W')then local s=self:Steroid(u)
  if s then local value=self:Priority(u);if not best or value>score then best,token,score=u,s,value end end
 end end
 return best and self:CastTarget(_W,best,context,function()return(not permission or permission())and self:Steroid(best)==token end)or false
end
function LuluChampion:OffensiveE()
 if not Menu.Support.EWindup:Value()or not self:Ready(_E)or not manaAbove(Menu.Support.Mana:Value())then return false end
 local best,token,score;local enemies=self:Rows('enemy',2000)
 for _,u in ipairs(self:Rows('ally',650))do
  if self:AllyAllowed(u,'E')and not self:Buff(u,self.profile.shieldBuff)then
   local a=Core:CastWindup(u,OrbamaPrediction:GetLaunchDelay(self.EImpact)+.05,1.5,true)
   if a then for _,enemy in ipairs(enemies)do if a.target==id(enemy)or a.target==enemy.handle then
    local value=self:Priority(u)*1000
    if not best or value>score then best,token,score=u,a,value end;break
   end end end
  end
 end
 return best and self:CastTarget(_E,best,{priority='interactive'},function()return Menu.Support.EWindup:Value()
  and manaAbove(Menu.Support.Mana:Value())and not self:Buff(best,self.profile.shieldBuff)
  and Core:MatchesCastWindup(best,token,OrbamaPrediction:GetLaunchDelay(self.EImpact)+.05,1.5,true)end)or false
end
function LuluChampion:Combat(mode)
 local node=Menu[mode];if not manaAbove(node.Mana:Value())then return false end;local context=Core:ModeContext(mode)
 local u=GetTarget(2250);if not self:Current(u)then return false end
 -- Combo R: the count is the goal, whoever the selected target is.
 if mode=='Combo'and Menu.Combo.R:Value()and self:KnockupR(function()return Menu.Combo.RCount:Value()end,context,
  function()return Menu.Combo.R:Value()and manaAbove(node.Mana:Value())end)then return true end
 if node.W:Value()and mode=='Combo'and Menu.Combo.AllyW:Value()and self:AllyW(context,function()return node.W:Value()and Menu.Combo.AllyW:Value()and manaAbove(node.Mana:Value())end)then return true end
 if node.W:Value()and self:CastTarget(_W,u,context,function()return node.W:Value()and manaAbove(node.Mana:Value())end)then return true end
 local function qAllowed()return node.Q:Value()and manaAbove(node.Mana:Value())end
 if node.Q:Value()and self:CastQ(u,context,qAllowed)then return true end
 -- Out of Q reach from here: extend Q through Pix (E on a unit near the target, then Q). Harass behind its switch.
 if(mode=='Combo'or Menu.Harass.Transfer:Value())and node.Q:Value()and node.E:Value()and GetDistance(u.pos,myHero.pos)>950
  and self:StartTransfer(u,context,function()return node.Q:Value()and node.E:Value()and manaAbove(node.Mana:Value())
   and(mode=='Combo'or Menu.Harass.Transfer:Value())end,false)then return true end
 -- The selected target cannot be hit: up to four other enemies a bolt (from Lulu or Pix) reaches.
 if node.Q:Value()and self:Ready(_Q)then local tried=0
  for _,other in ipairs(self:Rows('enemy',2250))do if other~=u then tried=tried+1;if tried>4 then break end
   if self:CastQ(other,context,qAllowed)then return true end
  end end
 end
 return node.E:Value()and self:CastTarget(_E,u,context,function()return node.E:Value()and manaAbove(node.Mana:Value())end)or false
end
function LuluChampion:Combo()return self:Combat('Combo')end
function LuluChampion:Harass()return self:Combat('Harass')end
function LuluChampion:RescueUseful(u,slot)
 -- The shared LastHit rule; this champion's regressions pin the 'ready' attack weighing.
 return Core:Rescue(u,slot==_Q and .25+GetDistance(u.pos,myHero.pos)/1450 or .175,
  function()return slot==_Q and self:GetQDmg(u)or self:GetEDmg(u)end,readyAttack)
end
function LuluChampion:FarmQ(u,kind,rescue)
 local plan=self:QPlan(u);if not plan then return nil end;local count=0
 -- Farming only claims current units; future splash/Pix passive bolts are not
 -- counted as confirmed incoming damage or extra CS.
 local origins=self:Origins()
 for _,other in ipairs(self:FarmRows(kind))do if self:QGeometry(other,plan.position,origins,other.pos,true)then
  if rescue and other~=u then return nil end;count=count+1
 end end
 if rescue and not self:RescueUseful(u,_Q)then return nil end;return count
end
function LuluChampion:Clear(kind)
 if not Core:FarmModeEnabled(kind)or not Menu.Clear.SpellFarm:Value()then return false end
 local node=Menu.Clear[kind=='lane'and 'LaneClear'or 'JungleClear'];if not manaAbove(node.Mana:Value())then return false end
 local context=Core:FarmContext(kind,function()return Menu.Clear.SpellFarm:Value()end)
 local rows=self:FarmRows(kind)
 for i=1,math.min(#rows,6)do local u=rows[i]
  if node.Q:Value()and self:Ready(_Q)then local count=self:FarmQ(u,kind,false)
   if count and count>=(kind=='lane'and Menu.Clear.LaneClear.Count:Value()or 1)and self:CastQ(u,context,function()
    local fresh=self:FarmQ(u,kind,false);return Menu.Clear.SpellFarm:Value()and node.Q:Value()and manaAbove(node.Mana:Value())
     and fresh and fresh>=(kind=='lane'and Menu.Clear.LaneClear.Count:Value()or 1)end)then return true end
  end
  if node.E and node.E:Value()and self:GetEDmg(u)>0 and self:CastTarget(_E,u,context,function()return Menu.Clear.SpellFarm:Value()and node.E:Value()and manaAbove(node.Mana:Value())end)then return true end
 end;return false
end
function LuluChampion:LaneClear()return self:Clear('lane')end
function LuluChampion:JungleClear()return self:Clear('jungle')end
function LuluChampion:LastHit()
 local node=Menu.LastHit;if not manaAbove(node.Mana:Value())then return false end
 for _,u in ipairs(self:FarmRows('lane'))do
  if node.E and node.E:Value()and self:RescueUseful(u,_E)and self:CastTarget(_E,u,Core:ModeContext('LastHit'),function()return node.E:Value()and manaAbove(node.Mana:Value())and self:RescueUseful(u,_E)end)then return true end
  if node.Q:Value()and self:FarmQ(u,'lane',true)and self:CastQ(u,Core:ModeContext('LastHit'),function()return node.Q:Value()and manaAbove(node.Mana:Value())and self:FarmQ(u,'lane',true)~=nil end)then return true end
 end;return false
end
function LuluChampion:Assist()
 if Menu.Misc.RAssist:Value()and self:RescueR(Core:HeldContext(function()return Menu.Misc.RAssist:Value()end),function()return Menu.Misc.RAssist:Value()end)then return true end
 if self.transfer and self.transfer.assist and not Menu.Misc.QAssist:Value()then self.transfer=nil end
 if self.transfer then return self:ContinueTransfer()end
 if not Menu.Misc.QAssist:Value()then return false end
 local held=function()return Menu.Misc.QAssist:Value()end;local context=Core:HeldContext(held)
 local target=GetTarget(2250);if not self:Current(target)or not self:Ready(_Q)then return false end
 if self:CastQ(target,context,held)then return true end
 return self:StartTransfer(target,context,held,true)
end
-- E -> Q through Pix: E sends Pix to a unit near a target Q cannot reach from
-- here; Q follows only once the own E cast was seen on that recipient, Pix is
-- there and the recipient carries the player's E buff.
function LuluChampion:StartTransfer(target,context,permission,assist)
 if self.transfer or not self:Ready(_Q)or not self:Ready(_E)or myHero.mana<myHero:GetSpellData(_Q).mana+myHero:GetSpellData(_E).mana then return false end
 local rows=self:Rows('ally',650);for _,enemy in ipairs(self:Rows('enemy',650))do rows[#rows+1]=enemy end
 -- Classic E targets and damages units: a minion or monster that survives it can carry Pix too.
 if self.eMinions then local impact=OrbamaPrediction:GetLaunchDelay(self.EImpact)
  for _,kind in ipairs({'lane','jungle'})do for _,u in ipairs(Core:Rows(kind,650))do
   local hp=Core:UnshieldedLegacyForecast(u,impact+.5)
   if finite(hp)and hp>self:GetEDmg(u)+20 then rows[#rows+1]=u end
  end end
 end
 for _,u in ipairs(rows)do if GetDistance(u.pos,target.pos)<=800 and u~=myHero and(u.team~=myHero.team or self:AllyAllowed(u,'E'))then
  if self:CastTarget(_E,u,context,function()return permission()and self:Current(target)and self:Ready(_Q)
   and myHero.mana>=myHero:GetSpellData(_Q).mana+myHero:GetSpellData(_E).mana and GetDistance(u.pos,target.pos)<=800 end)then
    self.transfer={target=target,handle=target.handle,recipient=u,recipientHandle=u.handle,intent=Core.lastIntent,expires=Game.Timer()+1.5,
     context=context,permission=permission,assist=assist};return true
  end
 end end;return false
end
function LuluChampion:ContinueTransfer()
 local row=self.transfer;if not row then return false end
 local continuation=row.permission()and Core:ContinuationState(row.intent,row.expires)
 if not continuation or not self:Current(row.target)or row.target.handle~=row.handle or not self:Current(row.recipient)or row.recipient.handle~=row.recipientHandle then self.transfer=nil;return false end
 local pix=self:PixValid(self.pix)
 if continuation=='observed'and not row.intent.ambiguous
  and pix and GetDistance(pix.pos,row.recipient.pos)<=150 and self:Buff(row.recipient,row.recipient.team==myHero.team and self.profile.shieldBuff or self.profile.pixEnemyBuff)then
  local ok=self:CastQ(row.target,row.context,row.permission);if ok then self.transfer=nil end;return ok
 end;return false
end
-- An enemy that cannot move (hard control or a channel) long enough for the bolt is hit without a mode key.
function LuluChampion:ImmobileQ()
 if not Menu.Support.QImmobile:Value()or not self:Ready(_Q)or not manaAbove(Menu.Harass.Mana:Value())then return false end
 for _,row in ipairs(Core:ZoneTargets({range=2250,arm=.25,lifetime=6,arrivals=false}))do
  local u=row.unit
  if u and(row.kind=='control'or row.kind=='channel')and self:Current(u)then
   local origin=myHero.pos;local pix=self:PixValid(self.pix)
   if pix and GetDistance(pix.pos,u.pos)<GetDistance(origin,u.pos)then origin=pix.pos end
   local need=.25+GetDistance(origin,u.pos)/1450
   if row.freeAt-Game.Timer()>=need and self:CastQ(u,{priority='interactive'},function()
    return Menu.Support.QImmobile:Value()and manaAbove(Menu.Harass.Mana:Value())and row.valid()end)then return true end
  end
 end
 return false
end
-- A killable enemy champion is finished with Q (also from Pix) or E without a mode key.
function LuluChampion:Finisher()
 local q,e=self:Ready(_Q),self:Ready(_E);if not q and not e then return false end
 local context={priority='interactive'}
 for _,u in ipairs(self:Rows('enemy',2250))do
  local function qKills()return Core:Lethal(u,.25+GetDistance(u.pos,myHero.pos)/1450,function()return self:GetQDmg(u)end,{kind='magical'})end
  local function eKills()return GetDistance(u.pos,myHero.pos)<=650 and Core:Lethal(u,OrbamaPrediction:GetLaunchDelay(self.EImpact),function()return self:GetEDmg(u)end,{kind='magical'})end
  if e and eKills()and self:CastTarget(_E,u,context,eKills)then return true end
  if q and qKills()and self:CastQ(u,context,qKills)then return true end
 end;return false
end
function LuluChampion:Flee()
 local context=Core:ModeContext('Flee')
 if Menu.Misc.FleeW:Value()then
  if self:AutoW(context,function()return Menu.Misc.FleeW:Value()end)then return true end
  if self:CastTarget(_W,myHero,context,function()return Menu.Misc.FleeW:Value()end)then return true end
 end
 local u=GetTarget(2250);return Menu.Misc.FleeQ:Value()and self:Current(u)and self:CastQ(u,context,function()return Menu.Misc.FleeQ:Value()end)or false
end
function LuluChampion:PreparePreview()
 -- Pix only (no shield or R text: the game shows the shield bar). Kept for a second so a late preparation
 -- never blinks it; Draw follows Pix's live position while it is the same living object.
 local pix=self:PixValid(self.pix)
 self.preview={pix=pix,handle=pix and pix.handle,expires=Game.Timer()+1}
end
-- Which ranges Draw shows: only abilities that are ready, read in Tick.
function LuluChampion:PrepareRanges()
 if not Menu.Draw.Ranges:Value()then self.ranges=nil;return end
 self.ranges={q=self:Ready(_Q),w=self:Ready(_W),e=self:Ready(_E),r=self:Ready(_R),expires=Game.Timer()+1}
end
function LuluChampion:Tick()
 if ShouldWait()or not Core:Available()then self.transfer=nil;return end
 if Game.Timer()>=(self.nextDiscovery or 0)then self:DiscoverAllies()end
 if self.wConsent then self.wConsent:Maintain()end
 if Menu.Draw.Preview:Value()or Menu.Misc.QAssist:Value()or(GetMode()=='Combo'and Menu.Combo.Q:Value())or(GetMode()=='Harass'and Menu.Harass.Q:Value())then self:DiscoverPix()end
 if self.previewFallback and Menu.Draw.Preview:Value()and Game.Timer()>=(self.nextPreview or 0)then self:PreparePreview();self.nextPreview=Game.Timer()+.15 end
 self:PrepareRanges();self:MaintainWProbe()
 if IsCasting()then return end
 if self:AutoShield()or self:AutoW()or self:Assist()then return end
 if Menu.Support.R:Value()and self:RescueR(nil,function()return Menu.Support.R:Value()end)then return end
 local background={priority='interactive'}
 local function supportMana()return manaAbove(Menu.Support.Mana:Value())end
 if Menu.Support.RKnockup:Value()and GetMode()~='Combo'and supportMana()and self:KnockupR(function()return Menu.Support.RKnockCount:Value()end,{priority='critical'},
  function()return Menu.Support.RKnockup:Value()and supportMana()end)then return end
 if self:Finisher()or self:OffensiveE()then return end
 if Menu.Support.AllyW:Value()and supportMana()then
  local function allowed()return Menu.Support.AllyW:Value()and supportMana()end
  if self:SteroidW(background,allowed)or GetMode()~='Combo'and self:AllyW(background,allowed)then return end
 end
 if self:ImmobileQ()then return end
 local mode=GetMode();if mode=='Combo'then self:Combo()elseif mode=='Harass'then self:Harass()
 elseif mode=='LaneClear'then if Core:FarmModeEnabled('lane')and self:LaneClear()then return end;if Core:FarmModeEnabled('jungle')then self:JungleClear()end
 elseif mode=='LastHit'then self:LastHit()elseif mode=='Flee'then self:Flee()end
end
function LuluChampion:Draw()
 if myHero.dead then return end
 local r=self.ranges
 if Menu.Draw.Ranges:Value()and r and r.expires>Game.Timer()then
  if r.q then Draw.Circle(myHero.pos,950,1,Draw.Color(255,100,200,255))end
  if r.w or r.e then Draw.Circle(myHero.pos,650,1,Draw.Color(255,100,200,255))end
  if r.r then Draw.Circle(myHero.pos,900,1,Draw.Color(255,100,200,255))end
 end
 local p=self.preview;if Menu.Draw.Preview:Value()and p and p.expires>Game.Timer()then
  local pix=p.pix;if pix and pix.dead~=true and pix.valid~=false and pix.handle==p.handle and point(pix.pos)then Draw.Circle(pix.pos,950,1,Draw.Color(150,150,100,255))end
 end
end
function LuluChampion:RegisterGuide(guide)
 return guide:Register('champion',{'Lulu: assistance','Lulu: profiles'},function(page)return {title=page==1 and 'Lulu assistance'or 'Pix and profiles',cards=page==1 and {
  {'MODES','Provider binds choose Combo, Harass, separate lane/jungle farming, LastHit and Flee. Abilities farm only while the spell-farm toggle is on.'},
   {'PROTECTION','E shields an ally an enemy champion is about to hit. W polymorphs the attacker, a melee enemy about to land the first hit, an engaging or channelling enemy or one dashing at you, and speeds up an ally who is fighting or powering up. R saves an ally below the health limit who is about to be hit or is stunned next to an enemy, or whose incoming attacks would take it below the limit; minion and turret damage never triggers it. R also knocks up enough enemies around an ally (Combo has its own count). Enemies who cannot move are hit with Q. Per-ally switches and R health limits, priorities (carries start at 5), per-enemy polymorph switches and the mana limit apply.'},
  {'ASSIST','Hold the Q bind for selected Q. When the target is out of reach, E moves Pix to a unit near it first and Q follows once Pix has arrived. Hold the R bind to save a low ally who is being attacked.'}}or {
  {'PIX','Both outgoing Q rays share one cursor aim; Pix enables targets beyond Lulu range. Allied team or an E cooldown alone never identifies Pix.'},
  {'PROFILES','Normal W speeds up an ally who is attacking; Classic W empowers an ally who is casting. Each shield, damage and R bonus-health coefficient uses its own installed profile.'},
  {'LIMITS','R is bonus health, not modeled as healing or shielding. Evade self-shield forecasts pause under unknown active buffs; ordinary E assistance remains available. Q uses a conservative single-bolt bound; passive bolts and item procs are excluded from CS claims.'}}}end)
end
Core:RegisterPolicy({damageTypes={Q='magical',E='magical'},methods={Combo=function()return Core:ModeContext('Combo')end,Harass=function()return Core:ModeContext('Harass')end,
 LaneClear=function()return Core:FarmContext('lane',function()return Menu.Clear.SpellFarm:Value()end)end,JungleClear=function()return Core:FarmContext('jungle',function()return Menu.Clear.SpellFarm:Value()end)end,
 LastHit=function()return Core:ModeContext('LastHit')end,Flee=function()return Core:ModeContext('Flee')end},channel=function()return not Core:SelfChanneling()end,
 validate=function(self,q,slot)if type(slot)=='number'and slot>=_Q and slot<=_R then return self:Ready(slot)end;return true end})
LuluChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Lulu"]="Lulu"}
local normalSupported={["Lulu"]=true}

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
