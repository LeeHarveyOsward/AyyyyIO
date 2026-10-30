return function()
-- GENERATED: tools/build_ayyyyio_controllers.py; Classic data; release payload.
local modules={}
modules.overlayClient=(function(require) return _G.OrbamaFamily:Factory("c15dfe50118b0ba11d3499e69a188b763f7bf413b791dd04a0a0d9fa6f2bb92a")(require) end)(require)
modules.actionClient=(function(require) return _G.OrbamaFamily:Factory("e80d2d89d6979a56680ad4df176d2d31edbb448d5b2d34c591286a9ce0f7d93f")(require) end)(require)
modules.abilityProfiles=_G.OrbamaFamily:Require("87fc978fa73e523712f1ec719253e8493c20f284d3949f8cbbfb4c93b2998870")
modules.championProfiles=(function()
local factories={}
factories["Caitlyn"]=function()return _G.OrbamaFamily:Require("7e9b2eff920d1fdc2220ba41c50d289867e1c86facd8a1d911d416c542d2bffc")()end
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
modules.observeAttack=(function(require) return _G.OrbamaFamily:Factory("3da377a20f2c2a192efc8343b23fb571f5cda62e822551b4678aab011deb2b69")(require) end)(require)
modules.recallCast=(function(require) return _G.OrbamaFamily:Factory("3c7cec6192229bd783dbb481829105edbbe5cfcc52fbeae7408eed05670af826")(require) end)(require)
modules.skillOrders=(function(require) return _G.OrbamaFamily:Factory("c960de90c594e7c207e7efeaca5198f2250fe65b01459ca5f3ac5dfb7747935f")(require) end)(require)
modules.healthWindow=(function(require) return _G.OrbamaFamily:Factory("d533b0ef74c68b495c1d2541cc3e687ebd5a9d43ecc9bd9706750c9b1a16fec9")(require) end)(require)
modules.yunaraProfile=(function(require) return _G.OrbamaFamily:Factory("d0f8a7ede995c1c4ae39ff50186c21819723104154d9a4a209da8a785993462e")(require) end)(require)
modules.nautilusProfile=(function(require) return _G.OrbamaFamily:Factory("f730083274ce090a6b9cdaf348846a2fa53f89ad6c57c53a6c09767f82770c84")(require) end)(require)
modules["autojungle"]=_G.OrbamaFamily:Require("8ef13010a581d447046b67d863880d3e389ac7fec6a8557c660db9c87981114d")
modules["combatMechanics"]=_G.OrbamaFamily:Require("ba52643cc532b91600830ad315958c7c83c7fb8f12edb7d0a0462abb16309ea7")
modules["gameplay"]=_G.OrbamaFamily:Require("150735cd6058eefcd206afc8513dde960e1a1f0823bdfd223db9491c39a2f4d8")
modules["strike"]=_G.OrbamaFamily:Require("38babe42b81881ea627d41ae65e32a203fdca56374f733a79b4c7f0c9465a693")
modules["prediction"]=(function(require) return _G.OrbamaFamily:Factory("223a065ecf7929552d5f8dafcf2453fd9147cd6e9940ce97dc80add73aa9913b")(require) end)(require)
modules["policies"]=(function(require) return _G.OrbamaFamily:Factory("e26056d70e5dac93ebb21f4ae4fe96863a06915a942bb75b795567a932448a23")(require) end)(require)
modules["core"]=(function(require) return _G.OrbamaFamily:Factory("f7d98e88d54ea77cb1c1c4aa026b699688271ff1aa4f6e769036de5dccf63c4f")(require) end)(require)
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
    return _G.SDK.IsRecalling(unit,Core.validating==true)
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
if champion=="Caitlyn" then
local entry=(function()
-- Factory entry. The common compositor provides isolated lexical helpers.
return {name='Caitlyn',profiles={normal=true,classic=true},
 Create=function(context)
local GameplayHooks=(function(g,C,P)
 local H,G,SDK=g.myHero,g.Game,g.SDK
 local function position(r,fallback)return r and r.position or fallback end
 local finite,id=C.finite,C.id
 local function permission(f,mode,slot)return function()return f:Permission(mode,slot)end end
  local function channel(u)return u and C:IsChannelCast(u.activeSpell,false)end
 local function incoming(f,u,horizon)return f:IncomingTargetedCast(u,horizon)end
 local Hooks={}

 function Hooks.menu(f,m)
  m.Misc:MenuElement({id='REnemy',name='Never cast R with more enemies nearby than',value=0,min=0,max=5,step=1})
  m.Misc:MenuElement({id='RMin',name='Only cast R on targets farther than',value=850,min=0,max=1500,step=25,menu=false})
  m.Misc:MenuElement({id='EQAssist',name='Net, then Q the selected target',key=string.byte('N')})
 end
 function Hooks.prior(f,u,aim)
  local count=0;local targetDistance=f.distance(H.pos,u.pos)
  for _,kind in ipairs({'hero','lane','jungle'})do for _,v in ipairs(f:Rows(kind,1300))do
   if id(v)~=id(u)and f.distance(H.pos,v.pos)<targetDistance and f:Line(H.pos,aim,v.pos,f.profile.q.radius+(v.boundingRadius or 0))then count=count+1 end
  end end;return count
 end
 function Hooks.qOptions(f,u,aim)return {prior=Hooks.prior(f,u,aim or u.pos),trapped=f.profile.id=='normal'and f:Buff(u,f.profile.trapNames,true)~=nil}end
 -- Caitlyn-12: an aim whose line also hits a second champion at Q impact. Both
 -- are predicted; the aim goes through the second one when the target's
 -- predicted point stays on that line (at most four other champions).
 function Hooks.doubleAim(f,u)
  local q=f.profile.q;local pu=f:Prediction(u,q);if not pu then return nil end
  local a=f.point(pu.CastPosition);local reach=q.flightRange or q.range
  for _,v in ipairs(f:Rows('hero',q.range))do
   if id(v)~=id(u)and f:Allowed(v)then
    local pv=f:Prediction(v,q);local b=pv and f.point(pv.CastPosition)
    if b and f.distance(H.pos,b)>1 then
     if f:Line(H.pos,H.pos:Extended(a,reach),b,q.radius+(v.boundingRadius or 0))then return nil,v end
     if f:Line(H.pos,H.pos:Extended(b,reach),a,q.radius+(u.boundingRadius or 0)*.5)then return b,v end
    end
   end
  end
 end
 function Hooks.castQ(f,u,context,allowed,buffered)
  if not buffered and f:Buff(H,f.profile.headshotNames)and f:AttackReach(u)and f.menu.Misc.PreferPassive:Value()then return false end
  if not buffered then
   local aim,second=Hooks.doubleAim(f,u)
   if aim and f:Cast(0,u,context,{position=aim,permission=allowed,weave=true,
    resolve=function()local b=Hooks.doubleAim(f,u);return b and {position=b}or nil end,
    check=function(_,r)local p=position(r,aim);local pu=f:Prediction(u,f.profile.q)
     return pu~=nil and f:Line(H.pos,H.pos:Extended(p,f.profile.q.flightRange or f.profile.q.range),f.point(pu.CastPosition),f.profile.q.radius+(u.boundingRadius or 0)*.5)~=false
      and f:Current(second)end})then return true end
  end
  return f:Cast(0,u,context,{world=true,permission=allowed,weave=not buffered})
 end
 -- Q roots Caitlyn for its whole cast. On a target she can already attack it is
 -- a loss unless the target cannot move for that long or Q kills; and she does
 -- not stand still with an enemy on top of her.
 function Hooks.qWorth(f,u)
  local function lethal()return f:Lethal(0,u,{damage=Hooks.qOptions(f,u)})end
  if g.GetEnemyCount(400,H.pos)>0 then return lethal()end
  if not f:AttackReach(u)then return true end
  local cc=g.GetHardCCDuration(u)
  return finite(cc)and cc>=f.profile.q.delay or lethal()
 end
 -- The netted or trapped enemy takes the Headshot: the shared attack preference
 -- keeps attacks on it while it is in attack range (shortest mark first).
 function Hooks.attackTarget(f,mode)
  if mode~='Combo'and mode~='Harass'then return end
  local best,ends
  for _,u in ipairs(f:Rows('hero',1400))do if f:Allowed(u)and f:AttackReach(u)then
   local b=f:Buff(u,f.profile.trapNames)or f.profile.netNames and f:Buff(u,f.profile.netNames)
   local stop=b and C.buffExpiry(b)
   if stop and(not ends or stop<ends)then best,ends=u,stop end
  end end
  return best
 end
 function Hooks.traps(f)
  local rows={};local method=SDK.ObjectManager.GetAllyMinions
  if method then for _,u in ipairs(method(SDK.ObjectManager,1000))do
   if u and u.valid and not u.dead and type(u.charName)=='string'and u.team==H.team and u.charName:lower():find('caitlyn',1,true)and u.charName:lower():find('trap',1,true)then
    if C.mine(u.owner or u.ownerID)then
     local tracked=false;for _,trap in pairs(f.objects)do if trap.object==u or not trap.object and f.distance(trap.position,u.pos)<100 then trap.object=u;trap.id=id(u);tracked=true;break end end
     if not tracked then rows[#rows+1]={position=u.pos,object=u,id=id(u),observed=true}end
    end
   end
  end end
  for key,trap in pairs(f.objects)do
   if trap.expires and trap.expires<=G.Timer()or trap.object and(trap.object.dead or trap.object.valid==false or id(trap.object)~=trap.id)then f.objects[key]=nil
   else rows[#rows+1]=trap end
  end;return rows
 end
 function Hooks.trapClear(f,pos)
  for _,trap in ipairs(Hooks.traps(f))do if f.distance(trap.position,pos)<150 then return false end end
  return true
 end
 -- A trap at a point (no unit): on Caitlyn against a diver, under an enemy in
 -- stasis or arriving, at the end of a dash. `valid` re-reads the evidence at
 -- dispatch; `reserve` keeps that many charges for a controlled target.
 function Hooks.trapAt(f,pos,context,allowed,valid,reserve)
  pos=f.point(pos);if not pos or not f:Ready(1)or f.distance(H.pos,pos)>f.profile.w.range or not Hooks.trapClear(f,pos)then return false end
  local rank=H:GetSpellData(1).level;local max=f.profile.w.max[rank]
  if not max or #Hooks.traps(f)>=max then return false end
  if reserve and f.profile.w.requiresAmmo and(H:GetSpellData(1).ammo or 0)<=reserve then return false end
  return f:Cast(1,nil,context,{position=pos,range=f.profile.w.range,resolve=function()return {position=pos}end,permission=allowed,
   check=function(_,r)return Hooks.trapClear(f,position(r,pos))and #Hooks.traps(f)<max and(not valid or valid())end,
   after=function(q)
    f.objects[q.id]={position=f.point(q.world or q.target or pos),expires=f.profile.w.duration and G.Timer()+f.profile.w.duration[rank]or nil,observedCast=true,discoveryUnknown=f.profile.trapLifetimeUnknown}
    f.trapDiscoveryUnknown=f.profile.trapLifetimeUnknown
   end})
 end
 local function always()return true end
 -- No mode key: a trap under an enemy who cannot move until it has armed
 -- (stasis, revive, hard control, a channel) or who is arriving by teleport.
 function Hooks.zoneTrap(f)
  if not f:Ready(1)then return false end
  local arm=g.OrbamaPrediction:GetLaunchDelay({Delay=f.profile.w.delay})+f.profile.w.arm+.05;if not finite(arm)then return false end
  for _,row in ipairs(f:ZoneTargets({range=f.profile.w.range,arm=arm,lifetime=20}))do
   if Hooks.trapAt(f,row.position,{priority='interactive',condition=always},nil,row.valid)then return true end
  end;return false
 end
 -- A melee enemy standing on Caitlyn walks into a trap at her feet.
 function Hooks.selfTrap(f,context,allowed)
  for _,u in ipairs(f:Rows('hero',260))do
   if f:Allowed(u)and(u.range or 0)<=300 then
    return Hooks.trapAt(f,H.pos,context,allowed,function()return f:Current(u)and f.distance(H.pos,u.pos)<=320 end,1)
   end
  end;return false
 end
 -- No mode key: Q at an enemy outside attack range who cannot move until it lands.
 function Hooks.controlledQ(f)
  if not f:Ready(0)or not C.manaAbove(f.menu.Harass.Mana:Value())then return false end
  for _,u in ipairs(f:Rows('hero',f.profile.q.range))do if f:Allowed(u)and not f:AttackReach(u)then
   local function held()local cc=g.GetHardCCDuration(u);return finite(cc)and cc>=f:Impact(0,u)-.1 and g.GetEnemyCount(400,H.pos)==0 end
   if held()and f:Cast(0,u,{priority='interactive',condition=always},{world=true,permission=held})then return true end
  end end;return false
 end
  function Hooks.castW(f,u,context,allowed)
   if not f:Ready(1)or not f:Reach(u,800)then return false end
   local arm=g.OrbamaPrediction:GetLaunchDelay({Delay=f.profile.w.delay})+f.profile.w.arm+.05
   if not finite(arm)then return false end
  local remaining=g.GetHardCCDuration(u);local cast=u.activeSpell
  local channelEnd=cast and channel(u)and cast.castEndTime or nil
   if (not finite(remaining)or remaining<arm)and(not finite(channelEnd)or channelEnd-G.Timer()<arm)then return false end
  local pos=f.point(u.pos);if not Hooks.trapClear(f,pos)then return false end
  local rank=H:GetSpellData(1).level;local max=f.profile.w.max[rank]
  if not max or #Hooks.traps(f)>=max then return false end
  return f:Cast(1,u,context,{position=pos,range=800,resolve=function()return {position=f.point(u.pos)}end,permission=allowed,
   check=function(_,r)local p=position(r,u.pos);local cc=g.GetHardCCDuration(u)
     local currentArm=g.OrbamaPrediction:GetLaunchDelay({Delay=f.profile.w.delay})+f.profile.w.arm+.05
     return finite(currentArm)and Hooks.trapClear(f,p)and #Hooks.traps(f)<max
      and(finite(cc)and cc>=currentArm or channel(u)and u.activeSpell.castEndTime-G.Timer()>=currentArm)
   end,
   after=function(q)
    -- An observed deployment owns only a bounded reservation. Lifetime-unknown
    -- Classic traps require object discovery before a long-term count is trusted.
    f.objects[q.id]={position=f.point(q.world or q.target or pos),expires=f.profile.w.duration and G.Timer()+f.profile.w.duration[rank]or nil,observedCast=true,discoveryUnknown=f.profile.trapLifetimeUnknown}
    f.trapDiscoveryUnknown=f.profile.trapLifetimeUnknown
   end})
 end
 function Hooks.recoil(f,aim)
  if f.distance(H.pos,aim)<1 then return end
  return H.pos:Extended(aim,-f.profile.e.recoil)
 end
 -- noFollow: the net alone (a peel or the net-then-Headshot finisher), no buffered Q.
 function Hooks.castE(f,u,context,allowed,noFollow,followupCheck)
  local origin=f.point(H.pos)
  return f:Cast(2,u,context,{world=true,permission=allowed,check=function(_,r)
   local landing=Hooks.recoil(f,position(r,u.pos))
   return landing and f:Safe(landing,false)and(not followupCheck or followupCheck(landing))
  end,
   after=function(q)
    if noFollow then return end
    f.sequences.eq={action=q.id,intent=q,target=u,identity=id(u),handle=u.handle,context=context,origin=origin,expires=G.Timer()+1.1,observed=true}
   end})
 end
 function Hooks.continue(f,key,s)
  if key~='eq'or not s.observed then return end
  -- E then Q: the Q is pressed while the net is still being fired, the game
  -- buffers it and it leaves on the recoil (the E-Q cancel). The recoil runs
  -- along the same line, so the aim holds; only the reach shrinks by it.
  if not s.buffered then
   s.buffered=true
   if f:Reach(s.target,f:Range(0)-f.profile.e.recoil)and Hooks.castQ(f,s.target,s.context,function()return f:SequenceValid(s)end,true)then f.sequences.eq=nil;return end
  end
  if H.pathing and H.pathing.isDashing and f.distance(H.pos,s.origin)>20 then s.dash=true end
  if s.dash and not(H.pathing and H.pathing.isDashing)and f.distance(H.pos,s.origin)>100 then
   local ok=Hooks.castQ(f,s.target,s.context,function()return f:SequenceValid(s)end)
   if ok then f.sequences.eq=nil end
  end
 end
  function Hooks.rClear(f,u)
   local impact=f:Impact(3,u);if not finite(impact)then return false end
  for _,v in ipairs(f:Rows('hero',4000))do if id(v)~=id(u)then
   local uncertainty=math.min(500,(v.ms or 0)*impact)
   local on=f:Line(H.pos,u.pos,v.pos,f.profile.r.radius+(v.boundingRadius or 0)+uncertainty)
   if on then return false end
  end end;return true
 end
 function Hooks.rLethal(f,u)
  local forecast=C:HealthEstimate(u,f:Impact(3,u),'physical',f:Damage(3,u))
  return forecast and forecast.lethal and C:SpellProtected(u)==false and not C:CannotDie(u,f:Impact(3,u))or false
 end
 -- The automatic R: a kill it can reach, never channelled inside enemy turret
 -- range (Caitlyn-7). An off-screen target is refused: R needs a champion under
 -- the cursor, the provider confirms an object cast only on screen (Orbama
 -- input.lua SetPosition/projection onScreen gates) and its minimap cast is a
 -- ground point that names no unit (Caitlyn-1, final rerank 2026-10-10). Every
 -- tick re-reads it, so R goes out on the first tick the kill comes on screen;
 -- until then the preview marks it on the minimap and names it under Caitlyn,
 -- and the dev recorder keeps the candidate (caitlyn_r_offscreen).
 function Hooks.castR(f,u,context,allowed,manual)
  if manual then return f:Ready(3)and f:Cast(3,u,context,{weave=false})or false end
  if not f:Ready(3)or f.distance(H.pos,u.pos)<f.menu.Misc.RMin:Value()or g.IsUnderTurret2(H.pos)or not Hooks.rClear(f,u)
   or g.GetEnemyCount(900,H.pos)>f.menu.Misc.REnemy:Value()then return false end
  local function lethal()return Hooks.rLethal(f,u)end
  if not lethal()then return false end
  if not(u.pos2D and u.pos2D.onScreen)then
   C:Trace('caitlyn_r_offscreen',{target=id(u),distance=math.floor(f.distance(H.pos,u.pos)),profile=f.profile.id},2000)
   return false
  end
  return f:Cast(3,u,context,{weave=false,permission=allowed,
   check=function()return lethal()and u.pos2D and u.pos2D.onScreen and not g.IsUnderTurret2(H.pos)and Hooks.rClear(f,u)
    and g.GetEnemyCount(900,H.pos)<=f.menu.Misc.REnemy:Value()and f.distance(H.pos,u.pos)>=f.menu.Misc.RMin:Value()end})
 end
 -- Caitlyn-5: the Q finisher does not root Caitlyn beside another enemy, nor
 -- when a ready basic attack kills before Q lands.
 function Hooks.qFinisherOk(f,u)
  for _,v in ipairs(f:Rows('hero',400))do if id(v)~=id(u)then return false end end
  if f:AttackReach(u)and SDK.Orbwalker:CanAttack()then
   local impact=C:AttackImpact(u)
   if impact and impact<=f:Impact(0,u)and C:Lethal(u,impact,function()return SDK.Damage:GetAutoAttackDamage(H,u,true)end,{attack=true})then return false end
  end
  return true
 end
 -- Caitlyn-4: a trap where a moving combo target will stand when it has armed,
 -- on its current path, keeping one charge; never on a target one attack kills.
 function Hooks.pathTrapPoint(f,u)
  local w=f.profile.w;local path=u.pathing
  if not path or path.hasMovePath~=true or path.isDashing or not f.point(path.endPos)then return nil end
  local arm=g.OrbamaPrediction:GetLaunchDelay({Delay=w.delay})+w.arm;if not finite(arm)then return nil end
  local pred=f:Prediction(u,{circle=true,delay=arm,radius=w.radius,range=w.range,speed=math.huge})
  if not pred or not pred:CanHit(3)then return nil end
  local p=f.point(pred.CastPosition);if not p or f.distance(H.pos,p)>w.range then return nil end
  local on,t=f:Line(u.pos,path.endPos,p,100)
  if not on or f.distance(u.pos,p)>800 then return nil end
  return p,f.point(path.endPos)
 end
 function Hooks.pathTrap(f,u,context,allowed)
  if not f:Ready(1)or not f:Reach(u,f.profile.w.range+200)then return false end
  local attackImpact=f:AttackReach(u)and C:AttackImpact(u)
  if attackImpact and C:Lethal(u,attackImpact,function()return SDK.Damage:GetAutoAttackDamage(H,u,true)end,{attack=true})then return false end
  local p,goal=Hooks.pathTrapPoint(f,u);if not p then return false end
  local ok=Hooks.trapAt(f,p,context,allowed,function()
   local path=u.pathing;return f:Current(u)and path and path.hasMovePath==true and f.point(path.endPos)~=nil and f.distance(path.endPos,goal)<=150
    and f:Line(u.pos,path.endPos,p,120)==true
  end,1)
  if ok then f.pathTrapWatch={unit=u,id=id(u),at=G.Timer(),position=p};C:Trace('caitlyn_path_trap',{target=id(u),distance=math.floor(f.distance(u.pos,p))})end
  return ok
 end
 -- Caitlyn-6 (Normal): the net, then the Headshot it enables, finishes the enemy.
 function Hooks.netFinisherDamage(f,u)
  local stats=f:Stats();local passive=P.Passive(H.charName,stats,u)
  if not finite(passive)or passive<0 then return 0 end
  return f:Damage(2,u)+SDK.Damage:CalculateDamage(H,u,SDK.DAMAGE_TYPE_PHYSICAL,H.totalDamage+passive)
 end
 function Hooks.netFinisher(f,mode,context)
  if f.profile.id~='normal'or not f.profile.netNames or not f.menu.Misc.KillSecure:Value()or not f:Permission(mode,2)or not f:Ready(2)then return false end
  for _,u in ipairs(f:Rows('hero',f:Range(2)))do
   if f:Allowed(u)then
    local function kills(landing)
     if not f:Current(u)or C:SpellProtected(u)~=false then return false end
     landing=landing or Hooks.recoil(f,u.pos)
     local impact=landing and C:AttackImpact(u,landing,'headshot')
     local e=f.profile.e;local launch=g.OrbamaPrediction:GetLaunchDelay({Delay=e.delay})
     if not impact or not finite(launch)or not finite(e.recoilSpeed)or e.recoilSpeed<=0 then return false end
     local afterNet=math.max(f:Impact(2,u),launch+e.recoil/e.recoilSpeed)
     return not f:Lethal(2,u)and C:Lethal(u,afterNet+impact,function()return Hooks.netFinisherDamage(f,u)end)
    end
    if kills()and Hooks.castE(f,u,context,function()return f:Permission(mode,2)and f.menu.Misc.KillSecure:Value()and kills()end,true,kills)then return true end
   end
  end;return false
 end
 function Hooks.combat(f,u,mode,context)
  if Hooks.netFinisher(f,mode,context)then return true end
  if f:Permission(mode,1)and Hooks.castW(f,u,context,permission(f,mode,1))then return true end
  if f:Permission(mode,2)and(f.distance(H.pos,u.pos)<350 or incoming(f,u,.7))and Hooks.castE(f,u,context,permission(f,mode,2))then return true end
  if f:Permission(mode,1)and Hooks.selfTrap(f,context,permission(f,mode,1))then return true end
  if f:Permission(mode,1)and Hooks.pathTrap(f,u,context,permission(f,mode,1))then return true end
  if f:Permission(mode,0)and Hooks.qWorth(f,u)and Hooks.castQ(f,u,context,function()return f:Permission(mode,0)and Hooks.qWorth(f,u)end)then return true end
  return f:Permission(mode,3)and Hooks.castR(f,u,context,permission(f,mode,3))or false
 end
 function Hooks.background(f)
  if C:SelfChanneling(true)then return false end
  -- One bind for the net-then-Q on the clicked champion.
  local node=f.menu.Misc.EQAssist
  if not node:Value()then f.gestures.EQAssist=nil
  elseif not f.gestures.EQAssist then
   local u=f:Target(f:Range(2))
   if u and Hooks.castE(f,u,C:HeldContext(function()return node:Value()end))then f.gestures.EQAssist=true;return true end
  end
  return Hooks.zoneTrap(f)or Hooks.controlledQ(f)
 end
 -- Lane minions on the Q line from Caitlyn through `aim`, and how many of them
 -- the pierced Q kills (each weighed once, at the reduced pierce damage).
 function Hooks.lineCount(f,aim,rows,killable)
  local far=H.pos:Extended(aim,f.profile.q.flightRange or f.profile.q.range);local hits,kills=0,0
  for i,v in ipairs(rows)do if f:Line(H.pos,far,v.pos,f.profile.q.radius+(v.boundingRadius or 0))then hits=hits+1;if killable and killable[i]then kills=kills+1 end end end
  return hits,kills
 end
 -- Caitlyn-8: up to 12 minions in reach are tried as the aim; the line with the
 -- most minions wins, ties to the most kills. Never from inside enemy turret range.
 function Hooks.bestLine(f,rows)
  local killable={};local reach=f.profile.q.range
  for i,v in ipairs(rows)do if i>24 then break end;killable[i]=f:Lethal(0,v,{damage={prior=1}})end
  local best,bestHits,bestKills;local tried=0
  for _,v in ipairs(rows)do
   if tried>=12 then break end
   if f.distance(H.pos,v.pos)<=reach then
    tried=tried+1
    local hits,kills=Hooks.lineCount(f,v.pos,rows,killable)
    if not best or hits>bestHits or hits==bestHits and kills>bestKills then best,bestHits,bestKills=v,hits,kills end
   end
  end
  return best,bestHits or 0
 end
 function Hooks.farm(f,u,rows,mode,context,last)
  if not f:Permission(mode,0)then return false end
  if not last and mode=='LaneClear'then
   if g.IsUnderTurret2(H.pos)then return false end
   local count=f.menu.LaneClear.Count:Value()
   local best,hits=Hooks.bestLine(f,rows);if not best or hits<count then return false end
   u=best
   return f:Cast(0,u,context,{world=true,permission=function()
    if not f:Permission(mode,0)or g.IsUnderTurret2(H.pos)then return false end
    return Hooks.lineCount(f,u.pos,f:Rows('lane',1300))>=f.menu.LaneClear.Count:Value()
   end})
  end
  local pred=f:Prediction(u,f.profile.q);if not pred then return false end
  local opts=Hooks.qOptions(f,u,pred.CastPosition)
  -- Caitlyn-9: a rescue whose target is first on the line takes full damage;
  -- minions behind it are a by-product.
  if last and(opts.prior~=0 or not f:Rescue(u,0,opts))then return false end
  return f:Cast(0,u,context,{world=true,permission=function()
   if not f:Permission(mode,0)then return false end
   if not last then return true end
   local current=Hooks.qOptions(f,u)
   return current.prior==0 and f:Rescue(u,0,current)
  end})
 end
 -- Flee: the net is fired away from the cursor, so the recoil carries Caitlyn
 -- toward it. No target is needed; the landing must be open ground.
 function Hooks.flee(f,context)
  local function aim()local c=f.point(g.mousePos);return c and f.distance(H.pos,c)>50 and H.pos:Extended(c,-400)or nil end
  local function open(p)local landing=p and Hooks.recoil(f,p);return landing and f:Safe(landing,false)or false end
  local p=aim()
  if p and f:Permission('Flee',2)and open(p)and f:Cast(2,nil,context,{position=p,range=f.profile.e.range,
   resolve=function()local a=aim();return a and {position=a}or nil end,permission=permission(f,'Flee',2),check=function(_,r)return open(position(r,p))end})then return true end
  local u=f:Target(750);if not u then return false end
  if f:Permission('Flee',1)and Hooks.castW(f,u,context,permission(f,'Flee',1))then return true end
  return f:Permission('Flee',1)and Hooks.selfTrap(f,context,permission(f,'Flee',1))or false
 end
 -- Evade may use the net as a dodge: the recoil carries Caitlyn a fixed length directly away from
 -- the aim, so the cast point is the mirror of the landing Evade asks for. Offered only for a profile
 -- whose recoil speed is established (Normal: 390 at 1000, cast .15; Classic has no recoil speed).
 function Hooks.initialize(f)
  local e=f.profile.e;if not e.recoilSpeed or not e.mobilitySource then return end
  f.mobilityOffered,f.mobilityReason=C:RegisterMobility({kind='dash',slot=2,key=g.HK_E,name=f.profile.names[3][1],range=e.recoil,speeds={e.recoilSpeed},castDelays={e.delay},
   profile=f.profile.id,source=e.mobilitySource,label='Use the net recoil (Caitlyn E)',
   aim=function(landing)local l=f.point(landing);return l and f.distance(H.pos,l)>1 and H.pos:Extended(l,-300)or nil end,
   allowed=function(pos)return not f.sequences.eq and(not pos or f:Safe(pos,false))end})
 end
 Hooks.options={}
 Hooks.modeSlots={Combo={'Q','W','E','R'},Harass={'Q','W','E','R'},LaneClear={'Q'},JungleClear={'Q'},LastHit={'Q'},Flee={'W','E'}}
 -- R only ever fires on a kill it can reach, so every fighting mode may use it; a trap on a held pursuer helps the escape.
 Hooks.defaults={Combo={R=true},Harass={R=true},Flee={W=true}}
 Hooks.assistLabels={[0]='Cast Q at the selected target',[3]='Cast R at the selected target'}
 -- The R bind is the player's decision: it needs only the selected target in range.
 function Hooks.assist(f,slot,u,context)return slot==0 and Hooks.castQ(f,u,context)or slot==3 and Hooks.castR(f,u,context,nil,true)or false end
 -- Caitlyn-10: prepared by the shared preview budget, drawn without a search:
 -- every enemy in R range the automatic R rule kills (at most five).
 Hooks.previewLabel='Mark enemies R can kill'
 function Hooks.preview(f,p)
  local kills={};local range=f:Range(3)
  if range>0 and f:Ready(3)then
   for _,u in ipairs(f:Rows('hero',range))do
    if #kills>=5 then break end
    if f:Allowed(u)and Hooks.rLethal(f,u)then kills[#kills+1]={unit=u,id=id(u),name=tostring(u.charName or'enemy'):gsub('^Jade_','')}end
   end
  end
  p.rKills=kills
 end


 Hooks.secureSlots={0,2,3}
 function Hooks.secureDamage(f,slot,u)if slot~=0 then return f:Damage(slot,u)end;local p=f:Prediction(u,f.profile.q);return p and f:Damage(slot,u,Hooks.qOptions(f,u,p.CastPosition))or 0 end
 -- A dash onto Caitlyn is answered with the net; with the net down, a trap
 -- where the dash ends.
 function Hooks.gapclose(f)return f:Gapclose(function(_,u,context,allowed)
  if Hooks.castE(f,u,context,allowed)then return true end
  local dash=C:ApproachingDash(u,H.pos,300)
  return dash and Hooks.trapAt(f,dash.to,context,allowed)or false
 end)or Hooks.peel(f)end
 -- Caitlyn-11: a melee enemy within 300 whose attack or targeted cast on
 -- Caitlyn is observed gets the net (safe recoil), with or without a mode key;
 -- never from inside enemy turret range.
 function Hooks.peel(f)
  local mode=f:Mode();local fighting=mode=='Combo'or mode=='Harass'
  local function enabled()return f.menu.Misc.Gapclose:Value()and(not fighting or f:Permission(mode,2))and not g.IsUnderTurret2(H.pos)end
  if not enabled()or not f:Ready(2)then return false end
  for _,u in ipairs(f:Rows('hero',300))do
   local function attacking()return f:Current(u)and f:Allowed(u)and(u.range or 0)<=300 and f.distance(H.pos,u.pos)<=300 and incoming(f,u,.6)end
   if attacking()then
    local context=fighting and f:Context(mode,function()return f.menu.Misc.Gapclose:Value()end)
     or {priority='interactive',condition=function()return f.menu.Misc.Gapclose:Value()end}
    if Hooks.castE(f,u,context,function()return enabled()and attacking()end,true)then return true end
   end
  end;return false
 end
 -- Dev recorder: path-trap outcome and observed Headshots at a known crit
 -- chance (settle the Normal passive crit term, Caitlyn-3).
 function Hooks.observe(f)
  local w=f.pathTrapWatch
  if w then
   local u=w.unit
   if f:Current(u)and f:Buff(u,f.profile.trapNames)then C:Trace('caitlyn_path_trap_hit',{target=w.id,after=G.Timer()-w.at});f.pathTrapWatch=nil
   elseif G.Timer()-w.at>4 or not f:Current(u)then C:Trace('caitlyn_path_trap_miss',{target=w.id});f.pathTrapWatch=nil end
  end
  if f:Buff(H,f.profile.headshotNames)then f.headshotSeenAt=G.Timer()end
 end
 function Hooks.attack(f,observation)
  local u=observation and observation.object
  if not u or u.type~=g.Obj_AI_Hero or not f.headshotSeenAt or not finite(observation.startTime)or f.headshotSeenAt<observation.startTime-.1 then return end
  local stats=f:Stats()
  C:Trace('caitlyn_headshot',{target=observation.target,at=observation.at,health=u.health,armor=u.armor,critChance=stats.critChance,
   critDamage=stats.critDamage,totalDamage=stats.totalDamage,level=stats.level,predicted=P.Passive(H.charName,stats,u)})
 end
 function Hooks.secureCast(f,slot,u,context,lethal)
  if slot==0 then
   if not Hooks.qFinisherOk(f,u)then return false end
   return Hooks.castQ(f,u,context,function()return lethal()and Hooks.qFinisherOk(f,u)end)
  end
  return slot==2 and Hooks.castE(f,u,context,lethal)or slot==3 and Hooks.castR(f,u,context,lethal)
 end
 function Hooks.secure(f)return f:KillSecure()end
 return Hooks
end)(_G,Core,CombatMechanics)
-- 26.20 independent Normal/Classic controller, assembled through the shared core.
local CaitlynChampion=class("CaitlynChampion")
function CaitlynChampion:__init()self.engine=Core:CreateGameplay(self,GameplayHooks);Menu=self.engine.menu end
function CaitlynChampion:Tick()return self.engine:Tick()end
function CaitlynChampion:Combo()return self.engine:Combat('Combo')end
function CaitlynChampion:Harass()return self.engine:Combat('Harass')end
function CaitlynChampion:LaneClear()return self.engine:Farm('lane','LaneClear',false)end
function CaitlynChampion:JungleClear()return self.engine:Farm('jungle','JungleClear',false)end
function CaitlynChampion:LastHit()return self.engine:Farm('lane','LastHit',true)end
function CaitlynChampion:Flee()return self.engine:Flee()end
-- Caitlyn-10: R-killable enemies from the prepared preview (world ring and
-- minimap marker), R range on the minimap under the ranges switch.
-- Range rings per ability: bright while it is ready, faint on cooldown (cheap readiness reads only).
function CaitlynChampion:Draw()
 local f=self.engine
 if myHero.dead then return end
 local minimap=type(Draw.CircleMinimap)=='function'
 if f.menu.Draw.Ranges:Value()then
  for slot=0,3 do local range=f:Range(slot)
   if range>0 then local color=f:Ready(slot)and Draw.Color(255,120,180,255)or Draw.Color(60,120,180,255)
    Draw.Circle(myHero.pos,range,1,color);if slot==3 and minimap then Draw.CircleMinimap(myHero.pos,range,1,color)end
   end
  end
 end
 local p=f.preview
 if not f.menu.Draw.Preview:Value()or not p or not p.rKills or p.expires<=Game.Timer()or not f:Ready(3)then return end
 local line=0
 for _,row in ipairs(p.rKills)do local u=row.unit
  if u and u.valid and not u.dead and u.visible and(u.networkID or u.handle)==row.id then
   Draw.Circle(u.pos,110,2,Draw.Color(255,255,70,70))
   if minimap then Draw.CircleMinimap(u.pos,400,2,Draw.Color(255,255,70,70))end
   -- Off screen R cannot be aimed: say who it kills so the camera can be moved there.
   local at=myHero.pos2D
   if not(u.pos2D and u.pos2D.onScreen)and at and at.onScreen~=false then
    Draw.Text('R kills '..row.name..' (off screen)',16,at.x-60,at.y+30+line*18,Draw.Color(255,255,70,70));line=line+1
   end
  end
 end
end
function CaitlynChampion:Ready(slot)return self.engine:Ready(slot)end
function CaitlynChampion:GetQDmg(u)return self.engine:Damage(0,u)end
function CaitlynChampion:GetWDmg(u)return self.engine:Damage(1,u)end
function CaitlynChampion:GetEDmg(u)return self.engine:Damage(2,u)end
function CaitlynChampion:GetRDmg(u)return self.engine:Damage(3,u)end
function CaitlynChampion:RegisterGuide(guide)return self.engine:RegisterGuide(guide)end
function CaitlynChampion:FeatureStatus()return {profile=self.profile.id,patch=CombatMechanics.patch,liveVerified=false}end
local modes={};for _,mode in ipairs({'Combo','Harass','LaneClear','JungleClear','LastHit','Flee'})do local name=mode;modes[name]=function()return Core:ModeContext(name)end end
Core:RegisterPolicy({methods=modes,channel=function()return not Core:SelfChanneling(true)end,validate=function(self,q,slot)return type(slot)~='number'or slot<0 or slot>3 or self:Ready(slot)end})
CaitlynChampion()

return Core.champion
end}

end)()
assert(entry.profiles[env.myHero.charName:match('^Jade_')and'classic'or'normal'],'unsupported_champion_profile')
return entry.Create({core=Core,env=env})
end
end
local classicSupported={["Jade_Caitlyn"]="Caitlyn"}
local normalSupported={["Caitlyn"]=true}

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
