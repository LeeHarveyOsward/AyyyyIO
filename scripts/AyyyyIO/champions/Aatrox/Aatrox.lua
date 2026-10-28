return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Aatrox"]=function()return _G.OrbamaFamily:Require("57d15d0f8cebe6aa3d875d4919bbac62a934b3237b651f9f0fe67bcb65868a23")()end
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
if champion=="Aatrox" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Aatrox',profiles={normal=true,classic=true},
 Create=function(context)
local GameplayHooks=(function(g,C,P)
 local H,G,SDK=g.myHero,g.Game,g.SDK
 local function position(r,fallback)return r and r.position or fallback end
 local finite,id=C.finite,C.id
 local function permission(f,mode,slot)return function()return f:Permission(mode,slot)end end
 local function hp(u)return u.health/u.maxHealth end
 local profile=P.Get(H.charName);local classic=profile~=nil and profile.id=='classic'
 local Hooks={}

 -- Each profile shows only the switches its kit reads; the other profile never reaches those reads.
 function Hooks.menu(f,m)
  if classic then m.Misc:MenuElement({id='HealW',name='Switch W to healing below health %',value=50,min=10,max=100,step=5,menu=false});return end
  m.Misc:MenuElement({id='Sweet',name='Wait for Q sweet spots when a later cast still fits',value=true,menu=false})
  m.Misc:MenuElement({id='Reposition',name='Use E to move Q onto its sweet spot',value=true})
 end
 function Hooks.stage(f)
  local name=H:GetSpellData(0).name
  if f.profile.id=='classic'then return 1 end
  return name=='AatroxQ'and 1 or name=='AatroxQ2'and 2 or name=='AatroxQ3'and 3 or nil
 end
 function Hooks.shape(f,stage,origin,aim,target,sweet)
  if not origin or not aim or not target then return false end
  local p=f.profile.qStages[stage];local length=f.distance(origin,aim)
  if length<1 then return false end
  local ux,uz=(aim.x-origin.x)/length,(aim.z-origin.z)/length
  local tx,tz=target.x-origin.x,target.z-origin.z
  local forward,side=tx*ux+tz*uz,math.abs(tx*uz-tz*ux)
  if stage==3 then
   local cx,cz=origin.x+p.center*ux,origin.z+p.center*uz
   return(target.x-cx)^2+(target.z-cz)^2<=(sweet and p.sweetRadius or p.radius)^2
  end
  if forward<(sweet and p.sweetMin or -(p.back or 0))or forward>p.range then return false end
  if stage==2 then
   -- Trapezoid: p.near half-width at p.back behind Aatrox, p.width at full range.
   local t=(forward+p.back)/(p.range+p.back);return side<=p.near+(p.width-p.near)*t
  end
  return side<=p.width
 end
 -- Prediction settings per stage (Q3: a fixed circle p.center ahead, hit radius p.radius).
 function Hooks.spec(f,stage,reach)
  local shape=f.profile.qStages[stage]
  if stage==3 then return {range=shape.center+shape.radius+(reach or 0),radius=shape.sweetRadius,delay=.6,speed=math.huge,circle=true}end
  return {range=shape.range+(reach or 0),radius=60,delay=.6,speed=math.huge}
 end
 function Hooks.reach(f,stage)local shape=f.profile.qStages[stage];return stage==3 and shape.center+shape.radius or shape.range end
 -- Distance from the target the dash should leave Aatrox at, per stage (middle of the sweet band).
 local anchor={[1]=550,[2]=410,[3]=200}
 -- E is allowed for this context: the reposition switch and the mode's own E
 -- switch (which also applies the spell-farm toggle); a context without a mode
 -- (finisher, selected-target bind) needs only the reposition switch.
 function Hooks.eAllowed(f,context)
  return f.menu.Misc.Reposition:Value()and(not context or not context.mode or f:Permission(context.mode,2))
 end
 -- Q and E planned together before Q (DepressiveAIONext model): at most 16
 -- dash destinations 75-300 from Aatrox (sweet anchors on the target ray, side
 -- steps around the target, backsteps); the first whose landing is safe and
 -- puts the predicted target in the stage's sweet spot, shortest dash first.
 -- The Q direction is the one from the landing to the target; the hitbox
 -- follows Aatrox when the dash lands during the 0.6 s cast (wiki V26.19).
 function Hooks.plan(f,stage,target)
  local here=f.point(H.pos);if not here or not target then return nil end
  local d=f.distance(here,target);if d<1 then return nil end
  local ux,uz=(target.x-here.x)/d,(target.z-here.z)/d
  local candidates={};local want=anchor[stage]
  for _,angle in ipairs({0,.35,-.35,.7,-.7})do
   local c,sn=math.cos(angle),math.sin(angle)
   local rx,rz=-(ux*c-uz*sn),-(ux*sn+uz*c)
   candidates[#candidates+1]=g.Vector(target.x+rx*want,H.pos.y,target.z+rz*want)
  end
  for _,k in ipairs({150,300})do candidates[#candidates+1]=g.Vector(here.x-ux*k,H.pos.y,here.z-uz*k)end
  for _,k in ipairs({-1,1})do candidates[#candidates+1]=g.Vector(here.x-uz*k*200,H.pos.y,here.z+ux*k*200)end
  local best,bestDash
  for i=1,math.min(#candidates,16)do local dest=candidates[i];local dash=f.distance(here,dest)
   if dash>=75 and dash<=300 and(not bestDash or dash<bestDash)and f:Safe(dest,true)then
    local aim=g.Vector(here.x+target.x-dest.x,H.pos.y,here.z+target.z-dest.z)
    if Hooks.shape(f,stage,dest,target,target,true)then best={destination=dest,aim=aim,dash=dash,stage=stage};bestDash=dash end
   end
  end
  return best
 end
 -- The W chain (Aatrox-3): an observed own tether pulls the target to the
 -- chain centre when it ends with the target still inside. The centre is the
 -- target position when the tether was first seen. The chain radius is not
 -- published: 150 is used (below DepressiveAIONext's 185 + bounding radius) and
 -- 'aatrox_w_pull' traces settle it. Returns the centre when the pull lands
 -- before a Q cast now would (0.6 s) and the target cannot walk out first.
 function Hooks.pull(f,u)
  local b=f:Buff(u,f.profile.tetherNames,true);local w=f.tether
  if not b then return nil end
  if not w or w.id~=id(u)or w.start~=b.startTime then
   w={id=id(u),handle=u.handle,start=b.startTime,centre=f.point(u.pos),unit=u};f.tether=w
  end
  local ends=C.buffExpiry(b);local now=G.Timer()
  if not finite(ends)or ends<=now or ends>now+.6 or not w.centre then return nil end
  local reach=f.distance(u.pos,w.centre)+(finite(u.ms)and u.ms or 500)*(ends-now)
  if reach>=f.profile.wChainRadius then return nil end
  return w.centre,ends
 end
 -- Seconds left to recast the current Q stage: the stage change Aatrox
 -- observed (Hooks.observe) plus the 4 s window (asset QExtensionTime).
 function Hooks.window(f,stage)
  local seen=f.qStageSeen;if not seen or seen.stage~=stage or not finite(seen.at)then return nil end
  return seen.at+f.profile.qWindow-G.Timer()
 end
 function Hooks.observe(f)
  local stage=f.profile.id=='normal'and Hooks.stage(f)
  if stage and(not f.qStageSeen or f.qStageSeen.stage~=stage)then f.qStageSeen={stage=stage,at=G.Timer()}end
  local w=f.tether
  if w and w.unit and not f:Buff(w.unit,f.profile.tetherNames,true)then
   if not w.traced then w.traced=true
    C:Trace('aatrox_w_pull',{distanceFromCentre=w.centre and w.unit.pos and f.distance(w.unit.pos,w.centre),radiusUsed=f.profile.wChainRadius})
   end
   f.tether=nil
  end
  if C.logger and stage then Hooks.qProbe(f)end
 end
 -- Development measurement (Aatrox-7): the health an observed Q took from its target 0.75 s after the cast, with
 -- the stage, rank, champion level, the target's distance from the cast origin and the estimate the planner used.
 -- Settles the Q1/Q2 sweet depths and the minion share by level from play.
 function Hooks.qProbe(f)
  local seq=f.sequences and f.sequences.q
  -- One probe per Q action: the sequence can outlive its finished probe (live s390 traced one Q twice).
  if seq and seq.observed and seq.target and f.qProbed~=seq.action then local u=seq.target
   if g.IsValid(u)and finite(u.health)then f.qProbed=seq.action
    f.qProbe={action=seq.action,unit=u,handle=u.handle,health=u.health,at=G.Timer()+.75,stage=seq.stage,origin=seq.origin,
     level=H:GetSpellData(0).level,minion=u.type~=g.Obj_AI_Hero,estimate=f:Damage(0,u,{stage=seq.stage})}
   end
  end
  local probe=f.qProbe
  if probe and G.Timer()>=probe.at then f.qProbe=nil;local u=probe.unit
   if u and u.handle==probe.handle and finite(u.health)then
    C:Trace('aatrox_q_hit',{stage=probe.stage,rank=probe.level,minion=probe.minion,healthLost=probe.health-u.health,estimate=probe.estimate,
     distance=probe.origin and u.pos and f.distance(u.pos,probe.origin),championLevel=H.levelData and H.levelData.lvl})
   end
  end
 end
 function Hooks.castQ(f,u,context,allowed)
  local stage=Hooks.stage(f);if not stage or not f:Ready(0)then return false end
  if f.profile.id=='classic'then
   if not f.menu.Misc.Risk:Value()and not f:AttackReach(u)then return false end
   return f:Cast(0,u,context,{world=true,spec={range=650,radius=190,delay=.6,speed=math.huge,circle=true},permission=allowed,
    check=function(_,r)return f:Safe(position(r,u.pos),true)end})
  end
  local shape=f.profile.qStages[stage]
  -- A W pull that lands first: aim at the chain centre.
  local centre=Hooks.pull(f,u)
  if centre and Hooks.shape(f,stage,H.pos,centre,centre,false)then
   return f:Cast(0,u,context,{position=centre,range=Hooks.reach(f,stage),permission=allowed,resolve=function()return {position=centre}end,
    check=function(_,r)local now=Hooks.pull(f,u);return now~=nil and f.distance(now,centre)<1 and Hooks.stage(f)==stage end,
    after=function(q)f.sequences.q={action=q.id,intent=q,target=u,identity=id(u),handle=u.handle,context=context,expires=G.Timer()+.8,stage=stage,origin=f.point(H.pos),observed=true,mode=context and context.mode,start=q.observationGameTime or G.Timer()}end})
  end
  local planning=f:Ready(2)and Hooks.eAllowed(f,context)
  local spec=Hooks.spec(f,stage,planning and 300 or 0)
  local pred=f:Prediction(u,spec);if not pred then return false end
  local predicted=f.point(pred.UnitPosition);if not predicted then return false end
  local direct=f.distance(H.pos,predicted)<=(stage==3 and shape.center+shape.radius or shape.range)
  local sweet=direct and Hooks.shape(f,stage,H.pos,predicted,predicted,true)
  local plan=not sweet and planning and Hooks.plan(f,stage,predicted)or nil
  if not sweet and not plan and f.menu.Misc.Sweet:Value()then
   if not direct then return false end
   -- A non-sweet Q2/Q3 waits while a later cast still fits: more than 1 s of
   -- the recast window is left and the target stays within reach for the cast.
   local left=stage>1 and Hooks.window(f,stage)
   if left and left>1 and f.distance(H.pos,u.pos)+(finite(u.ms)and u.ms or 0)*.6<=(stage==3 and shape.center+shape.radius or shape.range+300)then return false end
  end
  if not direct and not plan then return false end
  local aim=plan and plan.aim or pred.CastPosition
  local function fits(r)
   local p=position(r,aim);local recipient=r and r.data and f.point(r.data.unitPosition)or predicted
   if Hooks.stage(f)~=stage then return false end
   if Hooks.shape(f,stage,H.pos,p,recipient,false)then return true end
   -- A planned cast only goes out while the E that completes it can follow.
   return plan~=nil and f:Ready(2)and Hooks.eAllowed(f,context)and Hooks.shape(f,stage,plan.destination,g.Vector(plan.destination.x+p.x-H.pos.x,H.pos.y,plan.destination.z+p.z-H.pos.z),recipient,false)
  end
  local options={range=plan and spec.range or spec.range,permission=allowed,check=function(_,r)return fits(r)end,
   after=function(q)
    f.sequences.q={action=q.id,intent=q,target=u,identity=id(u),handle=u.handle,context=context,expires=G.Timer()+.8,stage=stage,origin=f.point(H.pos),observed=true,
     mode=context and context.mode,plan=plan,start=q.observationGameTime or G.Timer()}
    if plan then f.lastPlan={destination=plan.destination,aim=plan.aim,expires=G.Timer()+.8}end
   end}
  if plan then options.position=plan.aim;options.resolve=function()return {position=plan.aim}end
  else options.world=true;options.spec=spec end
  return f:Cast(0,u,context,options)
 end
 -- The own Q cast in progress: every stage shows the wrapper name (profile qCast) while it casts.
 function Hooks.qCasting(f,cast,stage)
  if not cast or not cast.valid then return false end
  if cast.name==f.profile.qCast then return true end
  for i,name in ipairs(f.profile.names[1])do if cast.name==name and(stage==nil or stage==i)then return true end end
  return false
 end
 function Hooks.continue(f,key,s)
  -- A planned Q went out counting on this E; record once why the E did not follow (development trace).
  local function decline(reason)
   if s.plan and not s.declined then s.declined=reason;C:Trace('aatrox_e_follow',{reason=reason,stage=s.stage,cast=H.activeSpell and H.activeSpell.name})end
  end
  if key~='q'or not s.observed then return end
  if not Hooks.eAllowed(f,s.context)then return decline('e_not_allowed')end
  if not f:Ready(2)then return decline('e_not_ready')end
  local cast=H.activeSpell
  if not Hooks.qCasting(f,cast,s.stage)or cast.isStopped then return decline('no_own_q_cast')end
  if not finite(cast.castEndTime)or cast.castEndTime-G.Timer()<.2 then return decline('cast_ending')end
  local u=s.target;local aim=f.point(cast.placementPos or cast.endPos)
  if not aim then return decline('no_aim')end
  -- One bounded candidate: move the caster so the already-started outgoing shape reaches its sweetspot.
  local lineLength=f.distance(s.origin,aim);if lineLength<1 then return end
  local ux,uz=(aim.x-s.origin.x)/lineLength,(aim.z-s.origin.z)/lineLength
  local sweet=anchor[s.stage]
  local destination=s.plan and s.plan.destination or g.Vector(u.pos.x-ux*sweet,H.pos.y,u.pos.z-uz*sweet)
  if s.plan then
   -- The planned dash: the outgoing shape moves with Aatrox along the cast direction.
   local moved=g.Vector(destination.x+aim.x-s.origin.x,H.pos.y,destination.z+aim.z-s.origin.z)
   if not Hooks.shape(f,s.stage,destination,moved,u.pos,false)then destination=g.Vector(u.pos.x-ux*sweet,H.pos.y,u.pos.z-uz*sweet)end
  end
  if f.distance(H.pos,destination)<75 or f.distance(H.pos,destination)>300 then return decline('dash_length')end
  if not f:Safe(destination,true)then return decline('unsafe_landing')end
  local ok=f:Cast(2,nil,s.context,{position=destination,range=300,weave=false,resolve=function()return {position=destination}end,
   permission=function()return Hooks.eAllowed(f,s.context)end,
   check=function(_,r)
    local current=H.activeSpell;local p=position(r,destination)
    local moved=g.Vector(p.x+aim.x-s.origin.x,H.pos.y,p.z+aim.z-s.origin.z)
    return current and current.valid and not current.isStopped and current.name==cast.name and current.startTime==cast.startTime
     and current.castEndTime-G.Timer()>=.15 and f:Safe(p,true)and(Hooks.shape(f,s.stage,p,aim,u.pos,true)or s.plan~=nil and Hooks.shape(f,s.stage,p,moved,u.pos,false))
   end})
  if ok then f.sequences.q=nil end
 end
 function Hooks.toggle(f,u,context,allowed)
  if f.profile.id~='classic'or not f:Ready(1)or not f:AttackReach(u)then return false end
  local heal=f:Buff(H,f.profile.healNames);local damage=f:Buff(H,f.profile.damageNames)
  if not heal and not damage then return false end
  local wanted=hp(H)*100<f.menu.Misc.HealW:Value()
  if wanted and heal or not wanted and damage then return false end
  return f:Cast(1,nil,context,{selfCast=true,permission=allowed,check=function()return f:AttackReach(u)and(hp(H)*100<f.menu.Misc.HealW:Value())==wanted and(heal and f:Buff(H,f.profile.healNames)or damage and f:Buff(H,f.profile.damageNames))~=nil end})
 end
 function Hooks.castR(f,u,context,allowed)
  if f.profile.id=='classic'then
   -- Massacre is a long cooldown: for a target already worn down, a second
   -- enemy in its blast, or Aatrox himself in trouble; not on a full-health duel.
   local function worth()return f:Reach(u,550)and(hp(u)<=.6 or hp(H)<.5 or g.GetEnemyCount(550,H.pos)>=2)end
   if not worth()then return false end
   return f:Cast(3,u,context,{selfCast=true,range=550,permission=allowed,check=worth})
  end
  if not f:Reach(u,625)or hp(H)>.7 and g.GetEnemyCount(650,H.pos)<2 then return false end
  return f:Cast(3,nil,context,{selfCast=true,permission=allowed,check=function()return f:Reach(u,625)and not f:Buff(H,{'AatroxR'})end})
 end
 function Hooks.combat(f,u,mode,context)
  if f:Permission(mode,1)and Hooks.toggle(f,u,context,permission(f,mode,1))then return true end
  if f:Permission(mode,3)and Hooks.castR(f,u,context,permission(f,mode,3))then return true end
  if f.profile.id=='normal'and f.menu.Misc.PreferPassive:Value()and f:Buff(H,{'AatroxPassiveReady'})and f:AttackReach(u)then return false end
  if f:Permission(mode,0)and Hooks.castQ(f,u,context,permission(f,mode,0))then return true end
  local slot=f.profile.id=='normal'and 1 or 2
  if f:Permission(mode,slot)then
   local tether=f.profile.id=='normal'and f:Buff(u,f.profile.tetherNames,true)
   if not tether then return f:Cast(slot,u,context,{world=true,permission=permission(f,mode,slot)})end
  end;return false
 end
 function Hooks.farm(f,u,rows,mode,context,last)
  if last then
   if #rows~=1 then return false end
   local slot=f.profile.id=='classic'and 2 or 0
   if f:Permission(mode,slot)and f:Rescue(u,slot,{stage=Hooks.stage(f)})then
    return f.profile.id=='classic'and f:Cast(slot,u,context,{world=true,permission=function()return f:Permission(mode,slot)and f:Rescue(u,slot)and #f:Rows('lane',1000)==1 end})
     or Hooks.castQ(f,u,context,function()return f:Permission(mode,0)and f:Rescue(u,0,{stage=Hooks.stage(f)})and #f:Rows('lane',1000)==1 end)
   end;return false
  end
  if mode=='LaneClear'then
   if f:Permission(mode,1)and #rows>=f.menu.LaneClear.Count:Value()and Hooks.toggle(f,u,context,permission(f,mode,1))then return true end
   if f:Permission(mode,0)and Hooks.clearQ(f,rows,context,permission(f,mode,0))then return true end
   return classic and f:Permission(mode,2)and Hooks.clearE(f,rows,context,permission(f,mode,2))or false
  end
  if f:Permission(mode,1)and Hooks.toggle(f,u,context,permission(f,mode,1))then return true end
  if f:Permission(mode,0)and Hooks.castQ(f,u,context,permission(f,mode,0))then return true end
  if not classic and f:Permission(mode,1)and Hooks.jungleW(f,u,context,permission(f,mode,1))then return true end
  return classic and f:Permission(mode,2)and f:Cast(2,u,context,{world=true,permission=permission(f,mode,2)})or false
 end
 -- Lane clear Q at the aim that covers the most minions inside the stage's own
 -- shape (at most 24 candidate aims: the minion positions), cast only when it
 -- covers LaneClear.Count; ties go to the aim whose sweet spot covers a minion
 -- Q kills (C:Lethal).
 function Hooks.bestAim(f,rows,inside,sweetInside,reach)
  local best,bestCount,bestKill
  for i=1,math.min(#rows,24)do local aim=f.point(rows[i].pos)
   if aim and f.distance(H.pos,aim)<=reach then
    local count,kill=0,false
    for j=1,math.min(#rows,24)do local v=rows[j]
     if inside(aim,v)then count=count+1;if not kill and sweetInside and sweetInside(aim,v)and f:Lethal(0,v,{damage={stage=Hooks.stage(f),sweet=true}})then kill=true end end
    end
    if not bestCount or count>bestCount or count==bestCount and kill and not bestKill then best,bestCount,bestKill=aim,count,kill end
   end
  end
  return best,bestCount or 0
 end
 function Hooks.clearQ(f,rows,context,allowed)
  local need=f.menu.LaneClear.Count:Value()
  if classic then
   if #rows<need then return false end
   return Hooks.castQ(f,rows[1],context,allowed)
  end
  local stage=Hooks.stage(f);if not stage or not f:Ready(0)then return false end
  local shape=f.profile.qStages[stage];local reach=stage==3 and shape.center+shape.radius or shape.range
  local aim,count=Hooks.bestAim(f,rows,function(a,v)return Hooks.shape(f,stage,H.pos,a,v.pos,false)end,
   function(a,v)return Hooks.shape(f,stage,H.pos,a,v.pos,true)end,reach)
  if not aim or count<need then return false end
  return f:Cast(0,nil,context,{position=aim,range=reach,permission=allowed,resolve=function()return {position=aim}end,
   check=function(_,r)local p=position(r,aim);local n=0
    for _,v in ipairs(f:Rows('lane',reach+300))do if Hooks.shape(f,stage,H.pos,p,v.pos,false)then n=n+1 end end
    return Hooks.stage(f)==stage and n>=need end})
 end
 -- Classic Blades of Torment: the line (profile e.radius) through the most minions.
 function Hooks.clearE(f,rows,context,allowed)
  local need=f.menu.LaneClear.Count:Value();local spec=f.profile.e;if not f:Ready(2)then return false end
  local function inside(a,v)local stop=H.pos:Extended(a,spec.range);return(f:Line(H.pos,stop,v.pos,spec.radius+(v.boundingRadius or 0)))end
  local aim,count=Hooks.bestAim(f,rows,inside,nil,spec.range)
  if not aim or count<need then return false end
  return f:Cast(2,nil,context,{position=aim,range=spec.range,permission=allowed,resolve=function()return {position=aim}end,
   check=function(_,r)local p=position(r,aim);local n=0
    for _,v in ipairs(f:Rows('lane',spec.range))do if inside(p,v)then n=n+1 end end;return n>=need end})
 end
 -- Jungle W on the largest monster, unless one basic attack already kills it.
 function Hooks.jungleW(f,u,context,allowed)
  if u.team~=300 or not f:Ready(1)then return false end
  if C:Lethal(u,0,SDK.Damage:GetAutoAttackDamage(H,u,true))then return false end
  return f:Cast(1,u,context,{world=true,permission=allowed})
 end
 function Hooks.flee(f,context)
  -- The dash (Normal E, Classic Q) goes toward the cursor; the slow covers the retreat when it is not available.
  local dash,reach=classic and 0 or 2,classic and 650 or 300
  local cursor=f.point(g.mousePos)
  if cursor and f:Permission('Flee',dash)and f:Ready(dash)then
   local destination=H.pos:Extended(cursor,math.min(reach,f.distance(H.pos,cursor)))
   if f:Cast(dash,nil,context,{position=destination,range=reach,resolve=function()return {position=H.pos:Extended(g.mousePos,math.min(reach,f.distance(H.pos,g.mousePos)))}end,
    permission=permission(f,'Flee',dash),check=function(_,r)return f:Safe(position(r,destination),false)end})then return true end
  end
  local u=f:Target(800);if not u then return false end
  local slot=f.profile.id=='classic'and 2 or 1
  return f:Permission('Flee',slot)and f:Cast(slot,u,context,{world=true,permission=permission(f,'Flee',slot)})or false
 end
 Hooks.options=classic and {'Risk'}or {'HP'}
 -- The abilities each mode really reads (the others get no menu entry). Normal E repositions Q onto its sweet spot
 -- wherever Q is cast for the player (Combo, Harass, clears); Classic E is the cleave and Classic Q the dash.
 Hooks.modeSlots=classic and {Combo={'Q','W','E','R'},Harass={'Q','W','E','R'},LaneClear={'Q','W','E'},JungleClear={'Q','W','E'},LastHit={'E'},Flee={'Q','E'}}
  -- Normal LaneClear has no W reader (the heal toggle is Classic, jungle W is jungle only).
  or {Combo={'Q','W','E','R'},Harass={'Q','W','E','R'},LaneClear={'Q','E'},JungleClear={'Q','W','E'},LastHit={'Q'},Flee={'W','E'}}
 -- R is a fight steroid with its own condition; Flee also slows the pursuer (Classic E, Normal W).
 Hooks.defaults=classic and {Combo={R=true},Flee={E=true}}or {Combo={R=true},Flee={W=true}}
 Hooks.assistLabels={[0]='Cast Q at the selected target'}
 function Hooks.assist(f,slot,u,context)return slot==0 and Hooks.castQ(f,u,context)or false end
 Hooks.previewLabel=not classic and 'Planned E landing spot'or nil
 function Hooks.preview(f,p)
  -- No state text: the game shows the Q stage and the passive/W state itself.
  if f.profile.id~='classic'then
   local stage=Hooks.stage(f)
   if stage then local shape=f.profile.qStages[stage]
    p.qStage=stage;p.qReach=stage==3 and shape.center+shape.radius or shape.range
    p.qSweet=stage==3 and shape.center-shape.sweetRadius or shape.sweetMin;p.qSweetOuter=stage==3 and shape.center+shape.sweetRadius or shape.range
   end
   local plan=f.lastPlan;if plan and plan.expires>G.Timer()then p.plan={destination=plan.destination,aim=plan.aim,expires=plan.expires}end
  end
 end
 function Hooks.initialize(f)
  -- Stage-aware Q reach and sweet band (Ability ranges switch) and the planned
  -- E landing (Damage estimate switch), drawn from the prepared preview only.
  if not classic then
   f.Draw=function(self)
    if H.dead then return end
    local p=self.preview;local fresh=p and p.expires>G.Timer()
    if self.menu.Draw.Ranges:Value()then
     -- One ring per ready ability; Q at its current stage reach with the sweet band.
     if self:Ready(0)then
      if fresh and p.qReach then
       g.Draw.Circle(H.pos,p.qReach,1,g.Draw.Color(255,255,120,90))
       if p.qSweet and p.qSweet>0 then g.Draw.Circle(H.pos,p.qSweet,1,g.Draw.Color(160,255,200,90))end
      else local range=self:Range(0);if range>0 then g.Draw.Circle(H.pos,range,1,g.Draw.Color(255,120,180,255))end end
     end
     for slot=1,3 do local range=self:Range(slot);if range>0 and self:Ready(slot)then g.Draw.Circle(H.pos,range,1,g.Draw.Color(255,120,180,255))end end
    end
    local plan=fresh and p.plan
    if self.menu.Draw.Preview:Value()and plan and plan.expires>G.Timer()then
     g.Draw.Circle(plan.destination,50,2,g.Draw.Color(220,120,255,120));g.Draw.Circle(plan.aim,40,1,g.Draw.Color(220,255,90,90))
    end
   end
  end
  if f.profile.id=='normal'then C:RegisterMobility({kind='dash',slot=2,key=g.HK_E,name='AatroxE',range=300,speeds={800},castDelays={0},profile='normal',source='26.20 AatroxE active EMaxRange/EDashSpeed',
   allowed=function(pos)return not pos or f:Safe(pos,false)end})end
 end

 -- Normal W finishes with its first hit only; the second hit needs an unbroken tether and is not counted.
 Hooks.secureSlots=classic and {0,2}or {0,1}
 function Hooks.secureDamage(f,slot,u)return f:Damage(slot,u,slot==0 and{stage=Hooks.stage(f)}or nil)end
 function Hooks.secureCast(f,slot,u,context,lethal)return slot==0 and Hooks.castQ(f,u,context,lethal)or(slot==2 or slot==1)and f:Cast(slot,u,context,{world=true,permission=lethal})end
 -- The shared finisher reaches Q range; beyond it (up to Q range + the 300 E
 -- dash) a Q that kills with its non-sweet damage goes out with the planned E.
 function Hooks.secure(f)
  if f:KillSecure()then return true end
  if classic or not f.menu.Misc.KillSecure:Value()or not f:Ready(0)or not f:Ready(2)or not f.menu.Misc.Reposition:Value()then return false end
  local stage=Hooks.stage(f);if not stage then return false end
  local reach=Hooks.reach(f,stage)
  local function on()return f.menu.Misc.KillSecure:Value()end
  for _,u in ipairs(f:Rows('hero',reach+300))do
   if f.distance(H.pos,u.pos)>reach and f:Allowed(u)then
    local function lethal()
     if not on()or not f:Current(u)or C:SpellProtected(u)~=false then return false end
     local estimate=C:HealthEstimate(u,.6,'physical',f:Damage(0,u,{stage=Hooks.stage(f)}))
     return estimate and estimate.lethal or false
    end
    if lethal()and Hooks.castQ(f,u,{priority='interactive',condition=on},lethal)then return true end
   end
  end
  return false
 end
 return Hooks
end)(_G,Core,CombatMechanics)
-- 26.20 independent Normal/Classic controller, assembled through the shared core.
local AatroxChampion=class("AatroxChampion")
function AatroxChampion:__init()self.engine=Core:CreateGameplay(self,GameplayHooks);Menu=self.engine.menu end
function AatroxChampion:Tick()return self.engine:Tick()end
function AatroxChampion:Combo()return self.engine:Combat('Combo')end
function AatroxChampion:Harass()return self.engine:Combat('Harass')end
function AatroxChampion:LaneClear()return self.engine:Farm('lane','LaneClear',false)end
function AatroxChampion:JungleClear()return self.engine:Farm('jungle','JungleClear',false)end
function AatroxChampion:LastHit()return self.engine:Farm('lane','LastHit',true)end
function AatroxChampion:Flee()return self.engine:Flee()end
function AatroxChampion:Draw()return self.engine:Draw()end
function AatroxChampion:Ready(slot)return self.engine:Ready(slot)end
function AatroxChampion:GetQDmg(u)return self.engine:Damage(0,u)end
function AatroxChampion:GetWDmg(u)return self.engine:Damage(1,u)end
function AatroxChampion:GetEDmg(u)return self.engine:Damage(2,u)end
function AatroxChampion:GetRDmg(u)return self.engine:Damage(3,u)end
function AatroxChampion:RegisterGuide(guide)return self.engine:RegisterGuide(guide)end
function AatroxChampion:FeatureStatus()
 -- Classic Q leap offer to Evade waits for its travel time (development own_dash records measure it).
 return {profile=self.profile.id,patch=CombatMechanics.patch,liveVerified=false,
  classicEvadeQ={supported=false,reason='leap_travel_time_unmeasured_own_dash_records_it'}}
end
local modes={};for _,mode in ipairs({'Combo','Harass','LaneClear','JungleClear','LastHit','Flee'})do local name=mode;modes[name]=function()return Core:ModeContext(name)end end
Core:RegisterPolicy({methods=modes,channel=function(self,q)
 if not Core:SelfChanneling(true)then return true end
 local s=myHero.activeSpell
 return self.engine and self.profile.champion=='Aatrox'and self.profile.id=='normal'and q.key==HK_E
  and self.engine.sequences.q~=nil and GameplayHooks.qCasting(self.engine,s)
end,validate=function(self,q,slot)return type(slot)~='number'or slot<0 or slot>3 or self:Ready(slot)end})
AatroxChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Aatrox"]="Aatrox"}
local normalSupported={["Aatrox"]=true}

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
