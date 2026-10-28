return function(require)
local G=require('evade.geometry')
local Terrain=require('evade.terrain')
local Threats=require('evade.threats')
local Planner=require('evade.planner')
local Observer=require('evade.observer')
local Defenses=require('evade.defenses')
local Metrics=require('evade.diagnostics')
local Drawing=require('evade.drawing')
local DefenseAdapter=require('evade.defense_adapter')
local ItemAdapter=require('evade.item_adapter')
local FlashAdapter=require('evade.flash_adapter')
local DashAdapter=require('evade.dash_adapter')
local UntargetableAdapter=require('evade.untargetable_adapter')
local Flash=require('evade.flash_adapter')
local Recorder=require('evade.recorder')
local FlightLog=require('evade.flightlog')
local Trajectory=require('evade.trajectory')
local Positioning=require('evade.positioning')
local Policy=require('evade.policy')
local Collision=require('evade.collision')
local Danger=require('evade.danger')
local ControlWindow=require('CombatProfiles.control_window')
local ChampionMotion=require('CombatProfiles.champion_motion')
local createClient=require('ActionClient')
local A={};A.__index=A
function A.new(g)
    local self=setmetatable({g=g,sdk=g.SDK,active=true,intervening=false,reason='starting',serial=0,
        build='OrbamaEvade-90',permissions={items=true,ultimates=false,summoners=false},enabled=true,
        nextDecision=0,nextMove=0,pending={},inputDirty=true,hooks={},adapters={},defenseSent={},movementObservations={}},A)
    self.hero=g.myHero
    self.controlWindow=self.sdk.ControlWindow or ControlWindow
    self.clock=function()return self.sdk.Actions:Now()end
    self.blockedDestinations={}
    self.moveModes={self.sdk.ORBWALKER_MODE_FLEE,self.sdk.ORBWALKER_MODE_COMBO,self.sdk.ORBWALKER_MODE_HARASS,
        self.sdk.ORBWALKER_MODE_LANECLEAR,self.sdk.ORBWALKER_MODE_JUNGLECLEAR,self.sdk.ORBWALKER_MODE_LASTHIT}
    self.client=createClient(g,{name='OrbamaEvade',active=function()return self:Current()end})
    self.terrain=Terrain.new(nil,g.myHero.team);self.threats=Threats.new()
    self.planner=Planner.new(self.terrain,self.threats);self.defenses=Defenses.new()
    self.observer=Observer.new(g,self.threats,require('evade.catalog'));self.metrics=Metrics.new(self.clock)
    -- Live danger: the enemy team for the follow-up during hard control (evade.danger), shared by policy and planner.
    self.danger=Danger.new({enemies=function()return self.observer.roster end,sets=function(name)return self.observer.loaded[name]end})
    self.planner.danger=self.danger
    self.drawing=Drawing.new(g)
    self.recorder=Recorder.new(g)
    self.flightlog=FlightLog.new(self)
    -- A reviewed tier standing in for unknown damage and control is reported once per threat.
    self.danger.onFallback=function(t,record)
        if self.recorder.enabled then  do end end
    end
    self.observer.diagnostics=function()return self.recorder.enabled and not self.recorder.failed end
    -- Reviewed per-ability unit collision: shorten a blockable flight at its first certain blocker.
    self.observer.clip=Collision.Clip
    self.observer.onReject=function(kind,fields) do end end
    self.observer.onKnownCast=function(owner,spell,definition)
        local start,placement,finish=spell.startPos,spell.placementPos,spell.endPos
         do end 
    end
    -- Development-only allied detection shadow; public builds stub evade.shadow.
    self.observer.shadow=require('evade.shadow').new(require('evade.catalog'),function(kind,fields) do end end)
    self.spellMenus={}
    self.observer.onDiscover=function(name,set)self:AddSpellMenus(name,set)end
    self.observer.enabled=function(champion,name)
        local group=self.spellMenus[champion];local option=group and group[name]
        return not option or option:Value()
    end
    self.observer.onUnknown=function(name,owner,d,missile,now)
        local pos=missile and missile.pos;local start=d.startPos;local finish=d.endPos
         do end 
    end
    self.observer.onExcluded=function(kind,owner,record,object,data,now,epoch)
        if kind=='cast'then
             do end 
            local start,placement,finish=data.startPos,data.placementPos,data.endPos
             do end 
        else
            local pos,start,finish=object.pos,data.startPos,data.endPos
             do end 
        end
    end
    self.observer.onThreat=function(t)
        self.nextDecision=0 -- A newly attributed cast need not wait for the ordinary planning cadence.
        if self.recorder.enabled and not self.recorder.failed then
             do end 
        end
         do end 
        if t.castOrigin or t.shape=='targeted'then  do end end
    end
    self.observer.onMissileIngress=function(report)
         do end 
        for _,sample in ipairs(report.samples)do  do end end
    end
    self.observer.onMissileObservation=function(owner,missile,data,pos,now,threat)
        local start,finish=data.startPos,data.endPos
         do end 
    end
    self.observer.onUnknownCast=function(owner,spell)
         do end 
        local start=spell.startPos;local placement=spell.placementPos;local finish=spell.endPos
         do end 
    end
    return self
end
-- A sent defense is offered again only after the host showed it unavailable once. A press that never became
-- a cast (stunned, input lost) leaves it ready: after 1.5 s that is evidence too, not a permanent lock.
local DEFENSE_CONFIRM_MS=1500
function A:DefenseReady(resource,ready)
    local prior=self.defenseSent[resource]
    if prior and ready and not prior.unavailableObserved and self.clock()-prior.at>DEFENSE_CONFIRM_MS then
        self.defenseSent[resource]=nil;prior=nil
    end
    if prior then
        if not ready then prior.unavailableObserved=true;return false end
        if not prior.unavailableObserved then return false end
        self.defenseSent[resource]=nil
    end
    return ready==true
end
function A:AddSpellMenus(champion,set)
    if not self.menu or not self.menu.Spells or self.spellMenus[champion]then return end
    local entries={};self.spellMenus[champion]=entries
    local groups={}
    for _,r in pairs(set)do if type(r)=='table'and r.name and (r.walkThreat or r.defensiveThreat)then
        groups[r.menuGroup or 'Other']=r.menuLabel or r.menuGroup or 'Other effects'
    end end
    if not next(groups)then return end
    self.menu.Spells:MenuElement({type=self.g.MENU,id=champion,name=champion})
    local root=self.menu.Spells[champion]
    local ordered,known={},{}
    for _,group in ipairs({'Q','QQ','QW','W','E','EQ','R','Passive','Other'})do if groups[group]then ordered[#ordered+1]=group;known[group]=true end end
    local extra={};for group in pairs(groups)do if not known[group]then extra[#extra+1]=group end end;table.sort(extra)
    for _,group in ipairs(extra)do ordered[#ordered+1]=group end
    for _,group in ipairs(ordered)do if groups[group]then
        root:MenuElement({id='ability_'..group,name=groups[group],value=true})
    end end
    for name,r in pairs(set)do if type(r)=='table'and r.name and (r.walkThreat or r.defensiveThreat)then
        local option=root['ability_'..(r.menuGroup or 'Other')]
        entries[name]=option;entries[r.name]=option
        if r.castAlias then entries[r.castAlias]=option end
    end end
end
function A:GetState()
    return {active=self.active and self.intervening,enabled=self.enabled,reason=self.reason,build=self.build,
        threatRevision=self.threats.revision,terrainRevision=self.terrain.revision,profile=self.profile,
        threats=#self.threats.list,observationIncomplete=self.threats.observationIncomplete==true,coverage='partial',mapReady=self.terrain:Ready(),terrainSource=self.terrain.source,decisionAt=self.decisionAt}
end
function A:Evading()return self.active and self.intervening end
function A:GetThreatState(id)
    if id then return self.threats:Snapshot(id)end
    local snapshot=self.threats:Snapshot()
    return {revision=self.threats.revision,overflow=self.threats.overflow,observationIncomplete=self.threats.observationIncomplete==true,threats=snapshot}
end
function A:GetDangerIntervals(position,from,to,options)
    options=options or {};local now=self.g.Game.Timer();from=from or now;to=to or from+2
    local radius=options.radius or self.g.myHero.boundingRadius
    local result={complete=false,exact=true,possible=false,intervals={},revision=self.threats.revision}
    if not G.point(position)or not G.finite(from)or not G.finite(to)or from<now or to<from or to-from>10
        or not G.finite(radius)or radius<0 then result.reason='invalid_interval';return result end
    if self.threats.observationIncomplete then result.reason='observation_incomplete';return result end
    if self.threats.overflow then result.reason='threat_capacity';return result end
    local work=options.workBudget or 12000
    if not G.finite(work)or work<0 then result.reason='invalid_budget';return result end
    local budget={remaining=math.min(12000,work)}
    for _,row in ipairs(self.threats:Query(position,position,from,to,radius,{},true))do
        if row.shape~='targeted'then
            local occupied=G.intervals(row,position,position,from,to,radius,budget)
            result.exact=result.exact and occupied.exact
            result.possible=result.possible or occupied.possible==true
            for _,span in ipairs(occupied.intervals)do
                result.intervals[#result.intervals+1]={id=row.id,instanceID=row.instanceID,damageID=row.damageID,
                    starts=span.starts,ends=span.ends,exact=occupied.exact,possible=occupied.possible==true}
            end
            if not occupied.complete then result.reason=occupied.reason;return result end
        end
    end
    result.complete=true;result.work=math.min(12000,work)-budget.remaining;return result
end
function A:IsDangerous(position,at)
    if self.threats.observationIncomplete then return true,'observation_incomplete'end
    if not G.point(position)or self.threats.overflow then return true,'unknown'end
    local now=self.g.Game.Timer();at=at or now
    if not G.finite(at)or at<now then return true,'invalid_time'end
    local radius=self.g.myHero.boundingRadius;local budget={remaining=12000};local query={}
    if not G.finite(radius)then return true,'radius_unknown'end
    for _,s in ipairs(self.threats:Query(position,position,at,at,radius,query,true))do
        if s.shape~='targeted'then
            local hit,why=G.sweep(s,position,position,at,at,radius,budget)
            if hit~=false then return true,why end
        end
    end
    return false
end
function A:SafePosition()
    local route=self.route
    if not self:Available()or not route or not (route.safe or route.walkSafe)or not route.path
        or route.threatRevision~=self.threats.revision or route.terrainRevision~=self.terrain.revision then return end
    local result=self:EvaluatePath(route.path)
    if result.known and (result.safe or result.walkSafe)then return G.copy(result.path[1])end
end
function A:MovementDestinationAllowed(point,now)
    for _,blocked in ipairs(self.blockedDestinations)do
        if now<blocked.expires and G.dist(point,blocked.position)<=64 then return false end
    end
    return true
end
function A:RejectMovementDestination(point)
    local now=self.g.Game.Timer()
    for i=#self.blockedDestinations,1,-1 do
        if self.blockedDestinations[i].expires<=now then table.remove(self.blockedDestinations,i)end
    end
    if #self.blockedDestinations>=8 then table.remove(self.blockedDestinations,1)end
    self.blockedDestinations[#self.blockedDestinations+1]={position=G.copy(point),expires=now+.35}
    self.route=nil;self.nextDecision=0;self.nextMove=0
     do end 
end
local NATIVE_BUDGET=200
-- Extra hero radius for threat contact (not terrain). Live 2026-10-08: a route that cleared Sona's ultimate by
-- 9 units, 1 unit after a slow, ended in the stun; a hook judged clear by about nothing was the next hit.
local SAFETY_MARGIN=30
function A:Context(ranking)
    local h=self.g.myHero;local now=self.g.Game.Timer()
    local cursorAim=self.sdk.Actions:GetPlayerPosition();local aim=cursorAim;local forced=false
    local recent=self.moveIntent and now-self.moveIntent.at<=.15
    local orb=self.sdk.Orbwalker;local mode
    if orb:IsEnabled()and orb.MovementEnabled and orb.Menu.MovementEnabled:Value()then
        for _,id in ipairs(self.moveModes)do if orb:HasMode(id)then mode=id;break end end
    end
    local command=mode~=nil or recent==true
    if mode~=nil and G.point(orb.ForceMovement)then aim=orb.ForceMovement;forced=true
    elseif recent and self.moveIntent.target then aim=self.moveIntent.target end
    local attack=h.attackData;local windup=0
    if self.sdk.Orbwalker:IsAutoAttacking()and attack then
        local finish=(attack.endTime or 0)-(attack.windDownTime or 0)
        if G.finite(finish)then windup=math.max(0,math.min(1.5,finish-now))end
    end
    -- The observed attack cast is direct windup evidence. Host attackData stays
    -- stale for spell-issued attacks (live Classic Jade_VayneQ_Attack: attackData
    -- finished 6 s earlier), which let a dodge click be sent mid-windup and lost.
    local finish=self:AttackCastEnd(h,now)
    if finish then windup=math.max(windup,math.min(1.5,finish-now))end
    local currentPath,trajectoryReason=Trajectory.Read(h)
    local motionService=self.sdk.ChampionMotion or ChampionMotion
    local control=self.controlWindow.ReadCached(h,self.sdk.BuffManager,now)
    if not control.motionClassified then motionService.AnnotateControl(control,h,now)end
    local observedMotion,motionReason=motionService.ReadPath(h,now,control)
    if observedMotion then currentPath={G.copy(observedMotion.to)};trajectoryReason=nil end
    local intentSource=forced and 'forced'or aim~=cursorAim and 'movement'or 'cursor'
    local intentReason
    if not forced then
        local screen;local read=self.sdk.Actions.GetPlayerScreenPosition
        if type(read)=='function'then local okay,value=pcall(read,self.sdk.Actions);if okay then screen=value end end
        local matched,why=Trajectory.CursorMatches(self.g,aim,screen)
        if not matched and G.point(cursorAim)and(not G.point(aim)or aim.x~=cursorAim.x or aim.z~=cursorAim.z or aim.y~=cursorAim.y)then
            matched,why=Trajectory.CursorMatches(self.g,cursorAim,screen)
            if matched then aim=cursorAim;intentSource='cursor'end
        end
        if not matched then
            aim=currentPath[#currentPath]or h.pos;command=false;intentReason=why
            intentSource=#currentPath>0 and G.dist(h.pos,aim)>1 and 'observed_path'or 'position'
        end
    end
    local controlHoldUntil=control and control.stationaryKnownDuration>0 and now+control.stationaryKnownDuration or nil
    local speedChanges=self:HasteSchedule(h,now)
    -- The orbwalker's attack (target, reach, windup, readiness) for route ranking and the weave check.
    local attackPlan=ranking~=false and Positioning.Attack(self.g,self.sdk,mode,now)or nil
    return {origin=G.copy(h.pos),now=now,speed=h.ms,radius=h.boundingRadius,heroID=h.networkID,
        -- Work budget of one decision: native terrain queries (about 20 us each live, so about 4 ms).
        -- The host clock steps by ~15.6 ms and cannot bound a 4 ms search.
        nativeBudget=NATIVE_BUDGET,margin=SAFETY_MARGIN,refineRoutes=self.refineRoutes,
        profile=h.charName:match('^Jade_')and 'classic'or 'normal',intent=G.copy(aim or h.pos),command=command==true,orbwalkerMode=mode,
        intentSource=intentSource,intentReason=intentReason,
        currentPath=currentPath,trajectoryReason=trajectoryReason,flee=mode==self.sdk.ORBWALKER_MODE_FLEE,
        observedMotion=observedMotion,motionReason=motionReason,
        motionNow=observedMotion and function()return self.g.Game.Timer()end or nil,
        controlHoldUntil=controlHoldUntil,controlWindow=control,
        speedKnownUntil=control and control.slowObserved and now+control.speedStableFor or nil,speedChanges=speedChanges,
        movementConstraintUnknown=control and(control.unavailable or control.truncated or control.pendingCasterMotion and not observedMotion or control.knockDuration>0 or control.forcedDuration>0
            or control.stationaryDuration>0 and control.stationaryKnownDuration==0)or false,
        -- Held in place for a time the host does not state: where the hero stands is still known.
        heldInPlace=control and not(control.unavailable or control.truncated or control.pendingCasterMotion and not observedMotion
            or control.knockDuration>0 or control.forcedDuration>0)and control.stationaryDuration>0 and control.stationaryKnownDuration==0 or false,
        destinationDanger=ranking~=false and Positioning.Snapshot(self.g,self.sdk,self.observer.roster,h.boundingRadius,
            self.observer.hazards and self.observer.hazards.advisory)or nil,
        attack=attackPlan,combatCost=Positioning.Combat(attackPlan),facing=h.dir,
        moveAllowed=function(point)return self:MovementDestinationAllowed(point,now)end,
        delay=.035+windup,sendLag=math.min(.1,self.tickInterval or 0),waypointDelay=.035,windup=windup,stats={health=h.health,maxHealth=h.maxHealth,armor=h.armor,magicResist=h.magicResist,
            shield=h.allShield or 0,physicalShield=h.shieldAD or 0,magicShield=h.shieldAP or 0}}
end
-- Castend of the hero's own observed attack cast, or nil. Uses the SDK attack
-- recognition (host isAutoAttack=false occurs for empowered attack names).
function A:AttackCastEnd(h,now)
    local decoder=self.controlWindow.AttackCastEnd or ControlWindow.AttackCastEnd
    return decoder(h,now,self.sdk.Data)
end
-- A sent walking command whose path change has not been observed yet is in flight.
-- Its replacement by an attack/move cannot be distinguished from host latency, so
-- the orbwalker's attacks stay blocked for this bounded window (live: a Combo attack
-- issued right after the dodge click replaced it; the hero then idled into Graves R).
local MOVE_FLIGHT_MS=250
function A:MovementInFlight(route)
    for _,record in pairs(self.pending)do if not record.defense then return true end end
    local now=self.clock()
    for _,event in ipairs(self.movementObservations)do
        if not event.observed and now<=event.sentAt+MOVE_FLIGHT_MS
            and(not route or route.path and route.path[1]and G.dist(route.path[1],event.destination)<=25)then return true end
    end
    return false
end
function A:PreMovement(args)
    -- Capture an actual orbwalker request even when our shared movement gate
    -- suppresses it. No raw input or expensive planning in this callback.
    if not self:Available()then return end
    if not args.Process and not (self.client.locks.evade and self.client.locks.evade.move)then return end
    local target=self.sdk.Orbwalker.ForceMovement or args.Target
    if target and target.pos then target=target.pos end
    self.moveIntent={at=self.g.Game.Timer(),target=G.point(target)and G.copy(target)or nil}
end
-- Live 2026-10-04 (user report, Lee clear / Kog combo): attacks stopped while a
-- threat persisted although Evade itself was not moving the hero. Without an
-- active Evade intervention an unsafe-windup hold is bounded; afterwards the
-- attack proceeds (the hold produced neither a dodge nor an attack).
local ATTACK_HOLD_MS=750
-- The probe route after a proposed windup is not input: a straight walk toward the
-- cursor that meets a wall (or a destination Evade just refused) says nothing about
-- whether the windup itself is safe. Live 2026-10-10 (Master Yi jungle, 25:00/26:45):
-- 15 of 20 attack holds came from a cursor intent across a camp wall (`live_wall`),
-- delaying ready attacks by 300-750 ms while the only threats were 2000 units away.
-- Unknown terrain is not in this set: it still holds the attack.
local ROUTE_REFUSAL={static_wall=true,live_wall=true,dynamic_wall=true,movement_destination_rejected=true}
-- `severe`: the windup turns an escape that works now into a lethal or hard-control hit. That attack is
-- refused for as long as it stays true; the bounded release is for holds that protect nothing more.
function A:HoldAttack(args,why,detail,severe)
    local now=self.clock()
    if self.intervening then self.attackHold=nil;args.Process=false;return end
    local hold=self.attackHold
    if not hold or hold.reason~=why then
        -- A changed reason is logged; the hold keeps its start, so the bound is not renewed.
        if hold then hold.reason=why else hold={since=now,reason=why};self.attackHold=hold end
         do end end
    if severe or now-hold.since<ATTACK_HOLD_MS then args.Process=false;return end
    if not hold.released then hold.released=true
         do end end
end
function A:PreAttack(args)
    if not args.Process or not self:Available()then return end
    if self.sdk.Orbwalker:HasMode(self.sdk.ORBWALKER_MODE_FLEE)then args.Process=false;return end
    if not self.terrain:Ready()or #self.threats.list==0 then self.attackHold=nil;return end
    if args.Approach then if self.intervening then args.Process=false end;return end
    -- This hook needs timed safety, not destination/target ranking.
    local windup=Positioning.Windup(self.g,self.sdk)
    if not windup then self:HoldAttack(args,'attack_data_missing');return end
    -- This is a proposed attack: its future windup (Orbama's, plus the weave margin the planner uses) must
    -- be stationary even if the hero is walking now. The existing observed windup is not sufficient.
    local result,severe=self:StandingRisk(windup+self.planner.weaveMargin)
    if not result.known or not (result.safe or result.walkSafe)then
        -- Lethal or hard control after the windup, on a route that avoids it without the attack: the
        -- attack is what makes the dodge impossible. Refused while that holds, never released by time.
        self:HoldAttack(args,severe and(result.lethal and 'lethal_windup'or 'hard_cc_windup')or result.known and 'unsafe_windup'or 'unknown_windup',
            result.reason,severe)
    else self.attackHold=nil end
end
-- The route the hero follows now (the dodge being walked, else the commanded or current path), evaluated
-- with `pause` seconds standing first (an attack windup, an own cast time), and whether that pause alone
-- turns it into a lethal or hard-control hit (`severe`): the same route walked at once is clear.
function A:StandingRisk(pause)
    local ctx=self:Context(false)
    local free={};for k,v in pairs(ctx)do free[k]=v end
    ctx.windup=pause;ctx.delay=.035+ctx.windup;ctx.sendLag=nil
    local length=math.max(0,ctx.speed*(self.planner.horizon-ctx.delay)*.8)
    local route=self.route and self.route.path
        or Trajectory.Clip(ctx.command and {ctx.intent}or ctx.currentPath or {ctx.origin},ctx.origin,length)
    local result=self:EvaluatePath(route,ctx)
    -- Standing through the pause and the rest of the horizon is then the evidence:
    -- the hero is where it stands, so no terrain query is needed for that route.
    if not result.known and ROUTE_REFUSAL[result.reason]then
        local stay=self.planner:Evaluate({G.copy(ctx.origin)},ctx,nil,true)
        if stay.known then result=stay end
    end
    local severe=false
    if result.known and not(result.safe or result.walkSafe)
        and(result.lethal==true or result.ccHard==true or G.finite(result.cc)and result.cc>0)then
        local now=self:EvaluatePath(route,free)
        severe=now.known and(now.safe or now.walkSafe)==true
    end
    return result,severe
end
-- Cast-time gate for cooperating ActionClient clients: may a champion cast that keeps the hero in place for
-- `seconds` (its own cast time) start now? False while standing that long (plus the weave margin) turns the
-- route the hero follows into a lethal or hard-control hit that walking it avoids (StandingRisk); the client
-- then waits, never cancels, and asks again. Evade's own answers (dashes, shields it requested) are not
-- asked. Nothing is evaluated without a modelled threat; one evaluation per clock sample, threat revision
-- and 50 ms of cast time. `cast_held` / `cast_released` record each held action once.
function A:CastAllowed(seconds,owner,key,id)
    local now=self.clock();local verdict=false
    if G.finite(seconds)and seconds>0 and self:Available()and #self.threats.list>0 and self.terrain:Ready()then
        local bucket=math.max(1,math.floor(seconds*20+.5))
        local memo=self.castMemo
        if not memo or memo.at~=now or memo.revision~=self.threats.revision then
            memo={at=now,revision=self.threats.revision};self.castMemo=memo
        end
        verdict=memo[bucket]
        if verdict==nil then
            local result,severe=self:StandingRisk(bucket/20+self.planner.weaveMargin)
            verdict=severe and(result.lethal==true and 'lethal_cast_time'or 'hard_cc_cast_time')or false
            memo[bucket]=verdict
        end
    end
    local held=self.castHolds
    local row=held and id~=nil and held[id]
    if not verdict then
        if row then
            held[id]=nil
             do end 
        end
        return true
    end
    if id~=nil and not row then
        held=held or {};self.castHolds=held
        local count=0;for _ in pairs(held)do count=count+1 end
        if count>=32 then for k in pairs(held)do held[k]=nil end end
        held[id]={since=now,reason=verdict}
         do end 
    end
    return false,verdict
end
function A:RefreshTerrain()
    local id=self.g.Game.mapID
    if self.mapID and self.mapID~=id then
        self:Cancel('map_changed');self.terrain.grid=nil;self.terrain.runtime=false;self.terrain:SetUnknown(true)
    end
    if self.terrain:Ready()then return true end
    if self.clock()<(self.nextTerrain or 0)then return false end
    self.nextTerrain=self.clock()+1000
    local ok,why=self.terrain:BindRuntime(self.g)
    if ok then self.mapID=id;self.profile=self.g.myHero.charName:match('^Jade_')and 'classic'or 'normal'
    else self.terrainReason=why end
    return ok
end
function A:GetCapabilities()return {commandedWaypointTiming=true,timedWalkingSpeed=true,maxSpeedChanges=16,timedShields=true,typedDamageReduction=true,ownedDefenseSubmission=true,targetedImpactIntervals=true,walkingSafety=true,defenseRegistration=true,defenseRegistrationVersion=1,defensePolicies=true,defensePolicyVersion=1,
    -- Own effect kinds an offer's `effect.kind` may name besides the shield/protection windows (version 1).
    defenseEffectVersion=1,defenseEffects={reduction=true,resist=true,haste=true,heal=true,directional_block=true,attack_dodge=true,owned_teleport=true},
    -- An owned teleport may offer a reach (`place`) instead of fixed destinations: Evade chooses the landing.
    ownedTeleportPlace=true,
    -- A cooperating ActionClient client asks CastAllowed(castTime) before a cast that keeps the hero in place.
    castTimeGate=true}end
local EFFECT_KINDS={reduction=true,resist=true,haste=true,heal=true,directional_block=true,attack_dodge=true}
-- Walking speed during an own haste, counted conservatively: a flat or percent bonus is added in full up to
-- 415 and half above it (the soft caps scale the excess by .8, then .5). Percent applies to the current speed.
local HASTE_SOFT_CAP=415
function A.HasteSpeed(base,e)
    if not G.finite(base)or base<=0 or type(e)~='table'then return nil end
    local bonus
    if e.flat~=nil then
        if e.percent~=nil or not G.finite(e.flat)or e.flat<=0 or e.flat>1000 then return nil end;bonus=e.flat
    elseif G.finite(e.percent)and e.percent>0 and e.percent<=3 then bonus=base*e.percent
    else return nil end
    local below=math.max(0,math.min(bonus,HASTE_SOFT_CAP-base))
    return base+below+(bonus-below)*.5
end
-- A sent own haste keeps counting for the walking that follows it: until the host shows the faster speed
-- (bounded grace after its start), then until it ends. An unobserved boost is dropped, never assumed.
function A:HasteSchedule(h,now)
    local boost=self.hasteBoost
    if not boost then return nil end
    local speed=h.ms
    if now>=boost.ends or not G.finite(speed)then self.hasteBoost=nil;return nil end
    local after=math.min(boost.base,speed)
    if speed>=boost.speed-1 then boost.observed=true;return {{at=boost.ends,speed=after}}end
    if boost.observed or now>boost.starts+.25 then self.hasteBoost=nil;return nil end
    return {{at=math.max(now,boost.starts),speed=boost.speed},{at=boost.ends,speed=after}}
end
-- An own haste protects nothing: it is a faster walking route that starts after the cast. With no route
-- given, the planner searches one at the boosted speed (bounded: half the native budget, 24 candidates).
function A:EvaluateHaste(option,path,ctx)
    local e=option.effect
    if ctx.speedChanges~=nil or ctx.speedKnownUntil~=nil then return {safe=false,known=false,reason='haste_speed_modifier_unknown'}end
    local boosted=A.HasteSpeed(ctx.speed,e)
    if not boosted or e.starts<ctx.now or e.castStops~=nil and type(e.castStops)~='boolean'then return {safe=false,known=false,reason='invalid_haste'}end
    local copy={};for k,v in pairs(ctx)do copy[k]=v end
    copy.speedChanges={{at=e.starts,speed=boosted},{at=e.ends,speed=ctx.speed}}
    -- The walking order follows the cast: one more click after it is sent.
    copy.delay=math.max(ctx.delay or 0,e.starts-ctx.now+.035+(ctx.sendLag or 0));copy.sendLag=nil
    if e.castStops then copy.controlHoldUntil=math.max(ctx.controlHoldUntil or ctx.now,e.starts)end
    local route=path or option.path;local result
    if route then result=self.planner:Evaluate(route,copy)
    else
        copy.refineRoutes=nil;copy.sharedBudget=nil;copy.candidateLimit=24
        copy.nativeBudget=math.floor((ctx.nativeBudget or NATIVE_BUDGET)/2)
        result=self.planner:Plan(copy)
    end
    if not result then return {safe=false,known=false,reason='haste_no_route'}end
    result.hasteSchedule={speed=boosted,base=ctx.speed,starts=e.starts,ends=e.ends}
    return result
end
-- A directional block without a facing is offered once per threat source (at most three distinct
-- directions); Evade writes the unit `aim` (and `effect.facing`) the controller casts toward.
function A:DefenseVariants(candidate,ctx,baseline)
    if candidate.option.place~=nil then return self:PlaceVariants(candidate,ctx)end
    local e=candidate.option.effect
    if not(type(e)=='table'and e.kind=='directional_block'and e.facing==nil)then return {candidate}end
    local out,aims={},{};local origin=ctx.origin
    local spread=G.finite(e.angle)and math.cos(math.rad(math.max(1,math.min(360,e.angle))/4))or 1
    for _,list in ipairs({baseline and baseline.hits or {},ctx.walking and ctx.walking.hits or {}})do
        for _,id in ipairs(list)do
            local t=self.threats.byID[id];local source=t and(t.castOrigin or t.origin)
            if #aims<3 and G.point(source)and G.dist(source,origin)>1 then
                local dx,dz=G.direction(origin,source);local fresh=true
                for _,a in ipairs(aims)do if a.x*dx+a.z*dz>=spread then fresh=false;break end end
                if fresh then aims[#aims+1]={x=dx,z=dz}end
            end
        end
    end
    for _,aim in ipairs(aims)do
        local option={};for k,v in pairs(candidate.option)do option[k]=v end
        local effect={};for k,v in pairs(e)do effect[k]=v end
        effect.facing=aim;option.effect=effect;option.aim=aim
        local copy={};for k,v in pairs(candidate)do copy[k]=v end;copy.option=option
        out[#out+1]=copy
    end
    return out
end
-- A two-step owned teleport (Zed: W places a shadow, W2 swaps to it once the shadow is seen) offers a reach,
-- not a point: option.place={range,minRange,speed,lead,recastLead,observe}. Evade picks the landing: 8 directions
-- around the player intent, each at the full and the shortest legal reach on open ground (at most 16 variants).
-- Each is modeled as a blink that lands only after the first cast (lead), the travel (reach/speed), the time to
-- see the object (observe) and the recast (recastLead): a threat that lands earlier is not dodged by it, so the
-- ordinary planner rejects the variant. The controller sends the recast only once the object is observed.
local PLACE_DIRECTIONS,PLACE_SLACK=8,50
function A:PlaceVariants(candidate,ctx)
    local p=candidate.option.place;local out={}
    if type(p)~='table'or not(G.finite(p.range)and p.range>0 and p.range<=2000 and G.finite(p.minRange)and p.minRange>=0
        and p.minRange<=p.range and G.finite(p.speed)and p.speed>0 and G.finite(p.lead)and p.lead>=0
        and G.finite(p.recastLead)and p.recastLead>=0 and G.finite(p.observe)and p.observe>=0)
        or not G.point(ctx.origin)then return out end
    local origin=ctx.origin;local base=0
    if G.point(ctx.intent)and G.dist(origin,ctx.intent)>5 then base=math.atan2(ctx.intent.z-origin.z,ctx.intent.x-origin.x)end
    local reaches={p.range};if p.minRange>0 and p.minRange<p.range then reaches[2]=p.minRange end
    for i=0,PLACE_DIRECTIONS-1 do
        local k=i==0 and 0 or(i%2==1 and(i+1)/2 or -i/2)
        local angle=base+k*2*math.pi/PLACE_DIRECTIONS;local dx,dz=math.cos(angle),math.sin(angle)
        for _,reach in ipairs(reaches)do
            local q={x=origin.x+dx*reach,y=origin.y,z=origin.z+dz*reach}
            -- Unknown terrain is not open ground.
            if self.terrain:Wall(q,ctx.now,ctx.radius)==false then
                local option={};for key,v in pairs(candidate.option)do option[key]=v end
                option.landing=q;option.path={q};option.reach=reach
                option.mobility={kind='blink',range=reach+PLACE_SLACK,castDelay=p.lead+reach/p.speed+p.observe+p.recastLead}
                local copy={};for key,v in pairs(candidate)do copy[key]=v end;copy.option=option
                out[#out+1]=copy
            end
        end
    end
    return out
end
-- When an own effect is worth its cooldown (beyond being Better and useful):
--  haste      only when walking cannot escape and the boosted route is fully walk-safe;
--  heal       only to survive a lethal hit that cannot be walked out of;
--  teleport   only to a landing that is completely clear (as a blink);
--  the others (reduction, resist, directional block, attack dodge) for a hit that matters.
function A:EffectWorth(option,result,baseline,walking)
    local e=option.effect;local kind=type(e)=='table'and e.kind
    local outcome=walking and walking.known and walking or baseline
    if option.ownedTeleport then return Flash.LandingSafe(self,result,baseline)and(DashAdapter.Trigger(self,outcome))end
    if not EFFECT_KINDS[kind]then return true end
    if kind=='haste'then
        return result.known==true and(result.safe or result.walkSafe==true)and not result.lethal
            and not(walking and walking.known and(walking.safe or walking.walkSafe==true))
    end
    if kind=='heal'then return baseline.lethal==true and outcome.lethal==true and not result.lethal end
    return(DashAdapter.Trigger(self,outcome))
end
function A:EvaluatePath(path,context)return self.planner:Evaluate(path,context or self:Context())end
function A:EvaluateDefense(option,path,context)
    if type(option)~='table'or option.validated~=true then return {safe=false,known=false,reason='defense_unverified'}end
    local ctx=context or self:Context()
    if option.profile~=ctx.profile then return {safe=false,known=false,reason='defense_profile_mismatch'}end
    if option.effect~=nil and type(option.effect)~='table'then return {safe=false,known=false,reason='invalid_defense_effect'}end
    if option.effect and (not G.finite(option.effect.starts)or not G.finite(option.effect.ends)
        or option.effect.ends<=option.effect.starts)then
        return {safe=false,known=false,reason='invalid_defense_window'}
    end
    if option.effect and option.effect.kind=='haste'then return self:EvaluateHaste(option,path,ctx)end
    if option.effect and option.effect.kind=='directional_block'then
        -- Blocks only while the hero stands (a channel) facing the chosen direction.
        if type(option.effect.facing)~='table'then return {safe=false,known=false,reason='directional_block_unaimed'}end
        if not option.effect.immobilizes then return {safe=false,known=false,reason='directional_block_needs_channel'}end
        local copy={};for k,v in pairs(option)do copy[k]=v end
        local effect={};for k,v in pairs(option.effect)do effect[k]=v end
        effect.center=G.copy(ctx.origin);copy.effect=effect;option=copy
    end
 if option.mobility or option.speedChanges then
  local copy={};for k,v in pairs(ctx)do copy[k]=v end
  copy.mobility=option.mobility or ctx.mobility
  copy.speedChanges=option.speedChanges or ctx.speedChanges;ctx=copy
 end
    -- Self defenses retain existing movement unless their mechanics immobilize.
    local route=path or option.path or ctx.currentPath or {ctx.origin}
    if option.effect and (option.effect.kind=='stasis'or option.effect.immobilizes)then
        local copy={};for k,v in pairs(ctx)do copy[k]=v end
        local untilTime=option.effect.immobilizedUntil or option.effect.ends
        if not G.finite(untilTime)or not G.finite(option.effect.starts)or not G.finite(option.effect.ends)
            or untilTime<option.effect.ends or untilTime<ctx.now or untilTime-ctx.now>10 then
            return {safe=false,known=false,reason='invalid_immobility_window'}
        end
        copy.delay=math.max(ctx.delay or 0,option.effect.starts-ctx.now)
        copy.immobilizedUntil=math.max(untilTime,ctx.immobilizedUntil or untilTime)
        copy.horizon=math.max(ctx.horizon or self.planner.horizon,untilTime-ctx.now+.05);ctx=copy
        route={ctx.origin}
    end
    return self.planner:Evaluate(route,ctx,option.effect)
end
function A:DefenseUseful(result,ctx,baseline)
    if not baseline and not result.safe then
        baseline=self.planner:Evaluate(ctx.currentPath or {ctx.origin},ctx,nil,true)
    end
    return self.planner:DefenseExecutable(result,baseline)
end
function A:RegisterDefense(name,adapter)return self.defenses:Register(name,adapter)end
function A:UnregisterDefense(name,registration)return self.defenses:Unregister(name,registration)end
function A:RegisterDefensePolicy(resource,name,spec)return self.defenses:RegisterPolicy(resource,name,spec)end
function A:UnregisterDefensePolicy(resource,name,registration)return self.defenses:UnregisterPolicy(resource,name,registration)end
function A:RegisterController(name,adapter)
    local old=self.adapters[name]
    if old and old.active then local ok,active=pcall(old.active);if ok and active==false then self.adapters[name]=nil end end
    if self.adapters[name]or type(adapter)~='table'or type(adapter.committed)~='function'or type(adapter.yield)~='function'then return false end
    self.adapters[name]=adapter;return true
end
function A:ReleaseCommitments(result)
    local policies={};for _,a in pairs(self.adapters)do policies[#policies+1]=a end
    for _,c in pairs(self.sdk.ActionClientHub and self.sdk.ActionClientHub.clients or {})do
        if not c.closed and c:IsActive()and c.evadePolicy then policies[#policies+1]=c.evadePolicy end
    end
    for _,a in ipairs(policies)do
        local ok,committed=pcall(a.committed)
        if not ok then return false,'controller_state_unknown'end
        if committed then
            if not result.lethal or result.unknown then return false,'champion_commitment'end
            local yes,released=pcall(a.yield,{likelyDeath=true,expires=self.clock()+100,reason='evade_likely_death'})
            if not yes or released~=true then return false,'champion_release_pending'end
        end
    end
    return true
end
-- Called by a map observation adapter. A map ID alone never selects a variant.
function A:BindTerrain(observation)
    local maps=require('evade.mapdata')
    if type(observation)~='table'or observation.observed~=true or observation.mapID~=self.g.Game.mapID
        or type(observation.variant)~='string'or type(observation.source)~='string'
        or type(observation.liveWall)~='function' then return false,'map_observation_required'end
    local map=maps[observation.mapID];local name=map and map.variants[observation.variant]
    local factory=name and map.grids[name]
    if not factory then return false,'map_variant_unavailable'end
    local grid=factory()
    if observation.navigationHash~=grid.sha256 then return false,'map_asset_mismatch'end
    self:Cancel('terrain_changed');self.terrain.grid=grid;self.terrain.live=observation.liveWall
    self.terrain.revision=self.terrain.revision+1;self.terrain:SetUnknown(false)
    self.mapID=observation.mapID;self.profile=observation.variant;return true
end
function A:Cancel(reason)
    if self.preparation then self.preparation:CancelJob('route_refinement')end
    for id,record in pairs(self.pending)do
        if record.client then record.client:Cancel(id,reason)end
    end
    -- Every cancellation advances the generation bound by prepared guards and resolvers.
    self.serial=self.serial+1;self.intervening=false;self.reason=reason
    -- Owner cancels and unblocks are needed only after Evade submitted walking/defense
    -- input, requested an emergency release or blocked input since the last completed
    -- cleanup, or while it still tracks pending input. Idle clean ticks make no calls.
    if self.inputDirty or next(self.pending)then
        self.client:CancelOwner('walking',reason);self.client:CancelOwner('defense',reason)
        self.client:SetBlocked('evade','attack',false);self.client:SetBlocked('evade','move',false)
        self.inputDirty=false
    end
    self.route=nil;self.gaze=nil
end
function A:Bypass()
    return self.menu and self.menu.Bypass:Value()or self.bypass==true
end
function A:Available()
    return self:Current()and self.enabled and not self:Bypass()and not self.g.myHero.dead
        and self.g.Game.IsOnTop()and not self.g.Game.IsChatOpen()
end
function A:Current()
    return self.active and self.g.SDK==self.sdk and self.g.myHero==self.hero and self.sdk.Evade==self
end
-- Bounded alternatives along the chosen escape direction when a unit would
-- intercept the ground click (live: 7/59 dodges refused as ground_hover_obstructed).
local HOVER_MARGIN,HOVER_STEPS=50,{90,-90,180,-180}
function A:HoverAlternative(path,fresh,baseline)
    local destination=path[1];local origin=fresh.origin
    local distance=G.dist(origin,destination)
    if distance<=5 then return end
    local units=Positioning.HoverUnits(self.g,self.sdk,origin,distance+400,32)
    -- A click next to the hero lands on the own model (live: a 31-unit dodge waited 172 ms and was
    -- refused as ground_hover_obstructed). The same direction is clicked further out instead.
    units[#units+1]={position=origin,radius=G.finite(fresh.radius)and fresh.radius or 65}
    if not Positioning.HoverBlocked(units,destination,HOVER_MARGIN)then return end
    local dx,dz=(destination.x-origin.x)/distance,(destination.z-origin.z)/distance
    for _,step in ipairs(HOVER_STEPS)do
        local reach=distance+step
        if reach>=60 then
            local candidate={x=origin.x+dx*reach,y=destination.y or origin.y or 0,z=origin.z+dz*reach}
            if not Positioning.HoverBlocked(units,candidate,HOVER_MARGIN)then
                local alternative={candidate};for i=2,#path do alternative[i]=path[i]end
                local evaluated=self:EvaluatePath(alternative,fresh)
                if self.planner:Executable(evaluated,baseline,fresh)then return candidate,evaluated end
            end
        end
    end
    return nil,nil,'hover_alternative_unavailable'
end
function A:PrepareMove(route,context,impact)
    -- Route evaluation always runs before positioning. The certificate and guard
    -- retain only immutable revisions, coordinates and a short monotonic expiry.
    -- The waiting window follows the threat: a held/just-clicked physical right
    -- button can delay acquisition (live: 3 dodges expired at 100 ms while the
    -- player held RMB). The resolver revalidates the whole route at acquisition,
    -- so waiting longer never sends a stale plan; it is capped well below a replan.
    local window=100
    if G.finite(impact)and context and G.finite(context.now)then
        window=math.max(100,math.min(250,(impact-context.now-.035)*1000))
    end
    local destination=G.copy(route.path[1]);local deadline=self.clock()+window
    local generation=self.serial;local certificate;local resolved={point=destination}
    local function guard()
        return self:Available()and generation==self.serial and certificate~=nil
            and certificate.threat==self.threats.revision and certificate.terrain==self.terrain.revision
            and self.clock()<=certificate.expires,'evade_preparation_stale'
    end
    local intent={type='move',kind='world',target=destination,owner='walking',resource='evade:movement',
        priority='critical',expires=deadline,prevalidateWorldMove=true,surviveMovementCommands=true,resolvedDestination=resolved,
        commitGuard=guard,mechanical=function()return guard()end,
        resolve=function()
            if not self:Available()or self.serial~=generation then return nil,'evade_cancelled'end
            local fresh=self:Context();fresh.delay=.035;fresh.sendLag=nil -- acquired: the click goes out now
            if fresh.trajectoryReason then return nil,fresh.trajectoryReason end
            local margin=fresh.margin or 0
            -- Padded shapes first, then exact ones: a tight escape is still sent.
            local function check(path)
                local ok,evaluated,baseline
                for _,pad in ipairs(margin>0 and {margin,0}or {0})do
                    fresh.margin=pad;evaluated=self:EvaluatePath(path,fresh);baseline=nil
                    if not (evaluated.safe or evaluated.walkSafe)then baseline=self:EvaluatePath({fresh.origin},fresh)end
                    ok=self.planner:Executable(evaluated,baseline,fresh)
                    if ok then break end
                end
                return ok,evaluated,baseline
            end
            local path=route.path
            local ok,evaluated,baseline=check(path)
            if not ok then
                -- The hero kept walking while the request waited and the committed destination no longer
                -- works. Take the route of the newest decision instead of dropping the dodge and asking again
                -- a callback later (live: `evade_route_changed` 20 ms after the request, nothing sent).
                local latest=self.route
                if latest and latest~=route and latest.path and G.point(latest.path[1])and (latest.safe or latest.walkSafe)
                    and latest.threatRevision==self.threats.revision and G.dist(latest.path[1],fresh.origin)>5 then
                    ok,evaluated,baseline=check(latest.path)
                    if ok then
                         do end 
                        path=latest.path;destination=G.copy(path[1])
                    end
                end
            end
            if not ok then return nil,'evade_route_changed'end
            local position=destination;resolved.requested=G.copy(destination)
            local alternative,alternativeEvaluation=self:HoverAlternative(path,fresh,baseline)
            if alternative then
                position,evaluated=alternative,alternativeEvaluation
                 do end 
            end
            if evaluated.threatRevision~=self.threats.revision or evaluated.terrainRevision~=self.terrain.revision then return nil,'evade_preparation_stale'end
            certificate={threat=evaluated.threatRevision,terrain=evaluated.terrainRevision,expires=math.min(deadline,self.clock()+20)}
            resolved.point=G.copy(position);resolved.route=evaluated
            return {position=position,data={threatRevision=certificate.threat,terrainRevision=certificate.terrain}}
        end,
        reconcile=function()return true end}
    return intent
end
function A:Collect()
    self.client:Collect()
    for id,record in pairs(self.pending)do
        local client=record.client or self.client
        local r=client:Poll(id)
        if r and record.defense and (r.sentAt or r.state=='send_uncertain')and not record.defenseRecorded then
            record.defenseRecorded=true;self.defenseSent[record.resource]={at=self.clock()}
        end
        -- Only a sent haste counts for the walking after it (HasteSchedule drops it if never observed).
        if r and record.haste and r.sentAt and not record.hasteArmed then
            record.hasteArmed=true;local s=record.haste
            self.hasteBoost={speed=s.speed,base=s.base,starts=s.starts,ends=s.ends}
        end
        if record.resolved and record.resolved.point then
            local resolved=record.resolved
            if r and r.sentAt and not record.routeAdjusted and resolved.route then
                -- A checked hover alternative is the sent route. Do not mistake
                -- its native endpoint for a deviation from the unrelocated plan.
                if self.route and self.route.path and resolved.requested
                    and G.dist(self.route.path[1],resolved.requested)<=25 then self.route=resolved.route end
                record.routeAdjusted=true
            end
            record.destination=resolved.point
        end
        if r and r.sentAt and not record.measured then
            record.measured=true
             do end 
            if G.finite(r.acquiredAt)and G.finite(r.requestedAt)then  do end end
            if G.finite(r.positionedAt)then  do end end
            if record.origin and record.destination and #self.movementObservations<16 then
                self.movementObservations[#self.movementObservations+1]={id=id,decision=record.decision,origin=record.origin,destination=record.destination,sentAt=r.sentAt,expires=r.sentAt+750}
            end
        end
        if record.dash and not record.outcomeLogged and(not r or r.state=='cancelled_before_send'or r.releasedAt and not r.cleanupPending)then
            record.outcomeLogged=true
            local pos=self.g.myHero.pos
             do end 
        end
        if not r or r.state=='cancelled_before_send'then
            if not record.cancelLogged then
                record.cancelLogged=true
                if r and r.reason=='ground_hover_obstructed'and not r.sentAt and record.destination then
                    self:RejectMovementDestination(record.destination)
                end
                 do end 
            end
            local finished,why=client:Finish(id)
            if finished or why~='cleanup_pending'then self.pending[id]=nil end
        elseif r.releasedAt and not r.cleanupPending then
            if not record.releaseLogged then
                record.releaseLogged=true
                 do end 
                if r.acquiredAt then  do end end
                if r.sentAt then  do end end
            end
            -- Release input/resource bookkeeping, preserving historical uncertainty.
            local finished,why=client:Finish(id,'input settled; gameplay effect unverified')
            if finished or why~='cleanup_pending'then self.pending[id]=nil
            elseif not record.cleanupLogged then
                record.cleanupLogged=true; do end 
            end
        end
    end
    local routeNow=self.clock();local observedPath,observedReason
    if self.recorder.enabled and not self.recorder.failed then
        for _,event in ipairs(self.movementObservations)do
            if (event.routeSamples or 0)<3 and routeNow>=(event.nextRouteSample or 0)then
                observedPath,observedReason=Trajectory.Read(self.g.myHero);break
            end
        end
    end
    for i=#self.movementObservations,1,-1 do local event=self.movementObservations[i]
        local pos=self.g.myHero.pos;local expired=self.clock()>event.expires
        if not expired and observedPath and (event.routeSamples or 0)<3 and routeNow>=(event.nextRouteSample or 0)then
            event.routeSamples=(event.routeSamples or 0)+1;event.nextRouteSample=routeNow+50
            local endpoint=observedPath[#observedPath]
             do end 
        end
        if not expired and G.dist(pos,event.origin)>5 then
            local dx,dz=G.direction(event.origin,event.destination);local x,z=G.direction(event.origin,pos)
            if dx*x+dz*z>.5 then
                 do end ;expired=true
                event.observed=true
                 do end 
            end
        end
        if expired then
            if not event.observed then  do end end
            table.remove(self.movementObservations,i)
        end
    end
end
function A:Tick()
    if not self.active then return end
    self:Collect()
    if self.menu then
        -- The on/off bind is a letter key now, and the host's menu flips a toggle bind even while the chat is
        -- open: typing that letter must not switch Evade (live 2026-10-08: Evade loaded switched off for a
        -- whole game). A change seen while the chat is open, or just closed, is put back.
        local value=self.menu.Enabled:Value()==true;local now=self.clock()
        local chat=type(self.g.Game.IsChatOpen)=='function'and self.g.Game.IsChatOpen()==true
        if chat then self.chatUntil=now+250 end
        if self.toggleSeen~=nil and value~=self.toggleSeen then
            local typed=chat or now<(self.chatUntil or -1)
            if typed then pcall(self.menu.Enabled.Value,self.menu.Enabled,self.toggleSeen);value=self.toggleSeen end
            if self.recorder and self.recorder.enabled then  do end end
        end
        self.toggleSeen=value;self.enabled=value;self.permissions.items=self.menu.Items:Value()
        self.permissions.ultimates=self.menu.Ultimates:Value();self.permissions.summoners=self.menu.Summoners~=nil and self.menu.Summoners:Value()==true end
    local diagnostic=false
    if diagnostic and not self.recorder.enabled then
        self.recorder.enabled=true; do end 
    else self.recorder.enabled=diagnostic==true end
    self.metrics.enabled=diagnostic==true
     do end 
    if self.loggedReason~=self.reason then
        self.loggedReason=self.reason; do end 
    end
     do end 
    local now=self.g.Game.Timer();local start=self.clock()
    -- A requested click is acquired on a later callback (live: 63 ms from request to send at a 36 ms
    -- cadence). Walking routes are planned with one observed callback interval of extra delay (`sendLag`).
    local elapsed=self.lastTickAt and now-self.lastTickAt
    if elapsed and elapsed>0 and elapsed<.25 then self.tickInterval=self.tickInterval and self.tickInterval+(elapsed-self.tickInterval)*.2 or elapsed end
    self.lastTickAt=now
    -- Observation and drawing remain available while automatic input is off.
    local ok,why=self.observer:Tick(now); do end 
     do end 
    if not ok then self:Cancel(why);return end
    for i=#self.threats.list,1,-1 do local t=self.threats.list[i]
        if t.champion and t.abilityName and not self.observer.enabled(t.champion,t.abilityName)then self.threats:Remove(t.id)end
    end
    if not self.preparationAvailable then self:PrepareOptional()end
    self:ReportUnmodeled(now)
    if not self:Available()then self:Cancel(not self.enabled and 'disabled'or self:Bypass()and 'bypass'or 'inactive_context');return end
    if not self:RefreshTerrain()then self:Cancel('map_variant_unknown');return end
    if self.gaze then
        local threat=self.threats.byID[self.gaze.id]
        if not threat or now>threat.ends then self:Cancel('gaze_window_ended')
        else
            local context=self:Context()
            local baseline=self.planner:Evaluate(context.currentPath or {context.origin},context,nil,true)
            local fresh=not baseline.known
            for _,id in ipairs(baseline.hits or {})do if id~=threat.id and not self.gaze.hits[id]then fresh=true;break end end
            if not fresh then
                baseline.hits={threat.id}
                if self:TurnFromGaze(context,baseline,start)then return end
            end
            self:Cancel('gaze_context_changed')
        end
    end
    if now<self.nextDecision then return end;self.nextDecision=now+.025
    if #self.threats.list==0 then self:Cancel('no_modeled_threat');return end
    -- Judgement before planning: cheap poke does not break a recall, channel or trade (evade.policy).
    if Policy.Apply(self,now)>=#self.threats.list then self:Cancel('threats_not_worth_moving');return end
    local ctx=self:Context()
    ctx.commitPrevious=self.route~=nil and self:MovementInFlight(self.route)
    local best,baseline=self.planner:Plan(ctx,self.route)
    -- Held in place (root or stun without a stated end): no walking route can be judged, but standing there
    -- can. Answers that need no movement (shield, spell shield, stasis, wall) are still weighed against it.
    local held=not best and ctx.heldInPlace and baseline.contextual==true
    if held then
        local copy={};for k,v in pairs(ctx)do copy[k]=v end
        copy.movementConstraintUnknown=false;copy.immobilizedUntil=ctx.now+self.planner.horizon
        ctx=copy;baseline=self.planner:Evaluate({ctx.origin},ctx,nil,true);best=baseline
    end
    -- Preserve an observed attack's remaining windup whenever the evaluated
    -- escape still succeeds. Only abandon it when immediate movement is safer.
    local preserveWindup=ctx.windup>0 and best and (best.safe or best.walkSafe)
    -- Classic: a right-click sent during the attack windup was neither applied nor
    -- buffered (live Jade_VayneQ_Attack, 185.06-185.30: path unchanged 156 ms after
    -- send). Do not plan as if movement cancels the windup there.
    local windupHolds=ctx.profile=='classic'and ctx.windup>0
    local abandoned=false
    if ctx.windup>0 and not preserveWindup and not windupHolds and not held then
        local immediate={};for k,v in pairs(ctx)do immediate[k]=v end;immediate.delay=.035;immediate.windup=0
        local urgent=self.planner:Plan(immediate,self.route)
        if self.planner:Better(urgent,best,ctx)then best=urgent;abandoned=true end
    end
    -- What this decision does to the own attack (decision_attack): an observed windup is finished or
    -- cancelled here; a ready attack is kept or delayed by the planner's weave check (planner:Weave).
    if best and ctx.windup>0 and not held then
        best.attack=abandoned and 'cancelled'or 'kept'
        best.attackReason=abandoned and 'windup_unsafe'or preserveWindup and 'windup_fits'or windupHolds and 'classic_windup_holds'or 'no_faster_escape'
    end
    local weaving=not held and best and(best.attackReason=='attack_fits'or best.attackReason=='attack_fits_alternative')
    self.decisionAt=now; do end 
    self.preview={at=now,intent=G.copy(ctx.intent),impact=baseline.firstImpact,
        arrival=best and best.arrival,safe=best and best.safe,walkSafe=best and best.walkSafe}
    self.decisionID=nil
    if best then  do end ; do end end
    if baseline.safe then self:Cancel('current_route_clear');return end
    local chosen
    -- An unavailable walking route must not skip a valid defensive option.
    -- When walking is safe, preserve cooldowns and avoid a second search.
    -- Read-only walking evidence for policy-gated adapters (Flash: walking cannot escape).
    ctx.walking,ctx.walkingBaseline=best,baseline
    for _,offered in ipairs(not (best and best.safe)and self.defenses:Options(ctx,self.permissions)or {})do
        for _,candidate in ipairs(self:DefenseVariants(offered,ctx,baseline))do
        local option=candidate.option
        -- A dash, blink or haste cannot be used while held; its route would be judged as if it could.
        if not (held and (option.mobility or option.path or option.effect and option.effect.kind=='haste'))then
        local result=self:EvaluateDefense(option,nil,ctx)
        result.resourceCost=option.cost or 0
        if self.defenses:PolicyAllowed(candidate.resource,option,ctx,result)and Policy.Worth(self,option,baseline)
            and self:DefenseUseful(result,ctx,baseline)and self:EffectWorth(option,result,baseline,ctx.walking)
            and self.planner:Better(result,best,ctx)then
            candidate.evaluation=result;best=result;chosen=candidate
        end
        end
        end
    end
    if not best or not best.known then self:Cancel('no_evaluated_route');return end
    if not chosen and not self.planner:Executable(best,baseline,ctx)then
        -- Nothing dodges it: a gaze spell can still be answered by facing the right way.
        if not held and self:TurnFromGaze(ctx,baseline,start)then return end
        self:Cancel('no_safe_executable_response');return
    end
    local released,reason=self:ReleaseCommitments(baseline)
    if not released then self:Cancel(reason);return end
    self.intervening=true;self.reason=chosen and 'defensive_action'or 'walking';self.route=best
    -- The final PreAttack hook checks this route with the proposed windup. Keep
    -- harmless attacks eligible while preventing ordinary moves from replacing it.
    self.inputDirty=true
    self.client:SetBlocked('evade','attack',self:MovementInFlight());self.client:SetBlocked('evade','move',true)
    -- The ready attack fits before this dodge: leave the attack open (PreAttack checks the same route with
    -- the windup) and send the dodge once the attack has started or no longer fits. Movement stays blocked.
    if weaving and not chosen and not best.continuing and not next(self.pending)and not self:MovementInFlight()then
        self.reason='weaving_attack';return
    end
    if best.continuing and not chosen then
        self.reason=(best.safe or best.walkSafe)and 'following_safe_route'or 'following_zone_exit';return
    end
    -- Input release precedes native path acknowledgement. Keep an equally safe,
    -- freshly evaluated committed destination during the existing bounded flight
    -- window instead of sending another click or reversing it on stale waypoints.
    if best.committed and not chosen and not next(self.pending)and self:MovementInFlight(best)then self.reason='awaiting_dodge_movement';return end
    if preserveWindup and not chosen then self.reason='finishing_safe_attack';return end
    if windupHolds and not chosen then self.reason='awaiting_attack_windup';return end
    if next(self.pending)or start<self.nextMove then return end
    if chosen then
        local intent,prepareReason=self.defenses:Prepare(chosen,ctx)
        if intent then
            self.decisionID=nil
            intent.owner='defense';intent.priority='critical'
            -- A scheduled (decide-ahead) defense may wait up to 150 ms more behind its own ready gate.
            local scheduled=G.finite(intent.scheduledMs)and math.max(0,math.min(150,intent.scheduledMs))or 0
            intent.expires=math.min(intent.expires or start+100,start+100+scheduled)
            self.inputDirty=true
            if baseline.lethal and not baseline.unknown then self.client:RequestEmergencyRelease(intent.resource,{likelyDeath=true,expires=start+100})end
            local id,status,client
            if intent.championDefense then
                local execution=intent.championDefense
                if type(execution.submit)=='function'and intent.mechanical()then
                    local ok,a,b,c=pcall(execution.submit,intent)
                    if ok then id,status,client=a,b,c else status='champion_defense_error'end
                else status='champion_defense_changed'end
            elseif intent.utilityFlash then
                local utils=self.sdk.OrbamaUtils
                local caps=utils and utils:active()and utils.GetCapabilities and utils:GetCapabilities()
                if caps and caps.flashRequests and utils.Flash then
                    local available=utils.Flash:Available()
                    if available and intent.resource=='slot:'..available.slot then
                        local owner='EvAYYYYde:defense'
                        local ok,event=utils.Flash:Request(intent.target,{owner=owner,range=intent.utilityFlash.range,
                            expires=intent.expires,priority=intent.priority,context=intent.context,evadeCompatible=true,
                            authorized=intent.utilityFlash.authorized,
                            validate=function(position)
                                if not intent.mechanical()then return false end
                                local resolved=intent.resolve()
                                return resolved and G.point(resolved.position)and G.dist(resolved.position,position)<.001
                            end})
                        if ok then
                            id,status=event.id,'requested'
                            client=utils.actions:ConsumerHandle(event,function(request)return utils.Flash:Cancel(request,owner)end)
                        else status=event end
                    else status='flash_resource_changed'end
                else status='OrbamaUtils Flash unavailable'end
            elseif intent.utilityItem then
                local utils=self.sdk.OrbamaUtils
                if utils and utils:active()then id,status,client=utils.Activator:Evade(intent,intent.utilityItem.slot,intent.utilityItem.id)
                else status='OrbamaUtils unavailable'end
            elseif intent.championDash then
                -- The champion controller owns the key, slot and cleanup.
                id,status,client=(intent.championDash.submit or DashAdapter.Submit)(self,intent)
                 do end 
            else id,status=self.client:Submit(intent)end
             do end 
            if id then self.pending[id]={defense=true,dash=intent.championDash~=nil,resource=intent.resource,client=client,decision=self.decisionID,haste=best.hasteSchedule,
                    destination=intent.championDash and G.copy(intent.target),resolved=intent.resolvedLanding}
            else self:Cancel(status or 'defense_submission_declined')end
        else
             do end 
            self:Cancel(prepareReason or 'defense_declined')
        end
    elseif self.planner:Executable(best,baseline,ctx)and best.path and G.dist(best.path[1],ctx.origin)>5 then
        self.decisionID=nil
        self.inputDirty=true
        local intent=self:PrepareMove(best,ctx,baseline.firstImpact)
        local id,status=self.client:Submit(intent)
         do end 
 if id then
            self.pending[id]={origin=G.copy(ctx.origin),destination=G.copy(best.path[1]),resolved=intent.resolvedDestination,decision=self.decisionID};self.nextMove=start+60
            -- Block the orbwalker's attack before its own tick can replace this click.
            self.client:SetBlocked('evade','attack',true)
        else self:Cancel(status or 'movement_submission_declined')end
    else self:Cancel('no_safe_executable_response')end
end
-- One short move order that turns the hero away from (or toward) a gaze caster.
-- It is a facing change, not an escape: sent only when no route or defense exists.
function A:TurnFromGaze(ctx,baseline,start)
    local point,threat,sense=Policy.Gaze(self,ctx,baseline)
    if not threat then return false end
    -- Keep ordinary combat until the final reaction window. The existing native
    -- cast completion is the impact clock; a turn cannot remove R's damage.
    if G.finite(threat.starts)and threat.starts-ctx.now>math.max(.12,(ctx.delay or .035)+.08)then return false end
    if not self.gaze then
        local hits={};for _,id in ipairs(baseline.hits or {})do hits[id]=true end
        self.gaze={id=threat.id,hits=hits}
    end
    self.intervening=true;self.reason='turning_from_gaze';self.inputDirty=true
    self.client:SetBlocked('evade','attack',true);self.client:SetBlocked('evade','move',true)
    if not point then
        if not self.gaze.aligned then
            self.gaze.aligned=true
             do end 
        end
        return true
    end
    if next(self.pending)or start<self.nextMove then return true end
    local checked=self.planner:Evaluate({point},ctx)
    if not checked.known or checked.terrainValidated~=true then return false end
    for _,id in ipairs(checked.hits or {})do if id~=threat.id and not self.gaze.hits[id]then return false end end
    local generation=self.serial;local deadline=self.clock()+100
    local function guard()return self:Available()and generation==self.serial and self.clock()<=deadline
        and self.threats.byID[threat.id]==threat and self.g.Game.Timer()<=threat.ends,'evade_preparation_stale'end
    self.intervening=true;self.reason='turning_from_gaze';self.inputDirty=true
    self.client:SetBlocked('evade','move',true)
    local id,status=self.client:Submit({type='move',kind='world',target=point,owner='walking',resource='evade:movement',
        priority='critical',expires=deadline,prevalidateWorldMove=true,surviveMovementCommands=true,
        commitGuard=guard,mechanical=guard,resolve=function()
            if not guard()then return nil,'evade_cancelled'end
            return {position=point}
        end,reconcile=function()return true end})
     do end 
    if id then self.pending[id]={origin=G.copy(ctx.origin),destination=G.copy(point),decision=self.decisionID};self.nextMove=start+120;return true end
    return false
end
-- Development summary of what was seen but is not modelled (feeds coverage work).
function A:ReportUnmodeled(now)
    local observer=self.observer
    if not observer.unmodeledDirty or now<(self.nextUnmodeledReport or 0)then return end
    self.nextUnmodeledReport=now+30;observer.unmodeledDirty=false
    local names={};for name in pairs(observer.unmodeled or {})do if #names<32 then names[#names+1]=name end end
    table.sort(names)
     do end 
end
function A:PrepareOptional()
    if not self.active or self.contourDisplayFailed then return end
    if #self.threats.list==0 or self.menu and(not self.menu.DrawEnabled:Value()or not self.menu.DrawThreats:Value())then
        if self.preparation then self.preparation:CancelJob('contours')end
        self.drawing:ResetPreparation();return
    end
    local ok,reason,err
    if self.preparation then
        ok,reason,err=self.preparation:Run('contours',self.contourPreparationConfig,self.prepareContours)
        if reason~='callback_error'then return end
    elseif self.preparationAvailable then return
    else
        local now=self.g.Game.Timer()
        if now<(self.nextContourPreparation or 0)then return end
        self.nextContourPreparation=now+.025
        ok,err=pcall(self.drawing.Prepare,self.drawing,self,now)
        if ok then return end
    end
    self.drawing:ResetPreparation()
    self.contourDisplayFailed=true;if self.preparation then self.preparation:CancelJob('contours')end
     do end 
end
function A:Shutdown()
    if not self.active then return end;self:Cancel('unload');self.active=false;self.hasteBoost=nil;self.client:Close('unload')
    if self.preparation then self.preparation:Close()end
    self.drawing:ResetPreparation()
    if self.overlayScope then self.overlayScope:Close();self.overlayScope=nil end
    for _,h in ipairs(self.hooks)do for i=#h.list,1,-1 do if h.list[i]==h.fn then table.remove(h.list,i)end end end
    if self.sdk.Evade==self then self.sdk.Evade=nil end
    if self.g.JustEvade==self.compat then self.g.JustEvade=nil end
end
function A:Install()
    self.sdk.Evade=self
    local service=self.sdk.Preparation
    if service and service.version==1 then
        self.preparationAvailable=true
        local hero=self.g.myHero
        local active=function()return self.active and self.g.SDK==self.sdk and self.g.myHero==hero and self.sdk.Evade==self end
        local family=self.g.OrbamaFamily
        if family and family.GetPreparationScope then
            self.preparation=family:GetPreparationScope('EvAYYYYde','optional',active)
        else self.preparation=service:Register('EvAYYYYde.optional',{active=active})end
        self.contourPreparationConfig={intervalMs=25,maxDelayMs=100,units=1,maxUnits=8}
        self.routePreparationConfig={intervalMs=0,maxDelayMs=50,units=1,maxUnits=8}
        self.prepareContours=function(token)return self.drawing:Prepare(self,self.g.Game.Timer(),token)end
        self.refineRoutes=function(fn)
            if not self.preparation then return false,'preparation_unavailable'end
            return self.preparation:Run('route_refinement',self.routePreparationConfig,fn)
        end
    end
    local function attach(list,fn)
        local guard=function(...)
            if not self:Current()then self:Shutdown();return end
            return fn(...)
        end
        list[#list+1]=guard;self.hooks[#self.hooks+1]={list=list,fn=guard}
    end
    attach(type(self.sdk.OnUrgent)=='table'and self.sdk.OnUrgent or self.sdk.OnTick,function()
        local ok,err=pcall(self.Tick,self);if not ok then self:Cancel('runtime_error'); do end ; do end end
    end)
    if self.preparationAvailable then attach(self.sdk.OnTick,function()self:PrepareOptional()end)end
    local overlay=self.sdk.Overlay
    if overlay and overlay.GetCapabilities and overlay:GetCapabilities().ownedScopes then
        self.overlayScope=overlay:Register('EvAYYYYde',{active=function()return self:Current()end})
    end
    local function draw(d)
        if self.drawError then return end
        local began=self.clock()
        local ok,err=pcall(self.drawing.Draw,self.drawing,self,d)
         do end 
        if not ok and not self.drawError then self.drawError=tostring(err); do end ; do end end
    end
    if self.overlayScope then self.overlayScope:Renderer('evade-status',function()self.drawing:Status(self)end,4);self.drawing.statusSeparated=true;self.overlayScope:Renderer('evade',draw,1)else attach(self.sdk.OnDraw,function()draw()end)end
    attach(self.sdk.Orbwalker.OnPreAttackCb,function(args)self:PreAttack(args)end)
    attach(self.sdk.Orbwalker.OnMoveCb,function(args)self:PreMovement(args)end)
    if self.g.MenuElement then
        self.menu=self.g.MenuElement({type=self.g.MENU,id='OrbamaEvade',name='EvAYYYYde'})
        for _,name in ipairs({'Controls','Automation','Tracking','Appearance'})do self.menu:MenuElement({type=self.g.MENU,id=name,name=name})end
        local filled={}
        local migration=self.sdk.MenuMigration
        local function savedRow(path)
            local node=migration and migration.saved and migration.saved.OrbamaEvade
            for part in path:gmatch('[^.]+')do node=type(node)=='table'and node[part]or nil end
            return type(node)=='table'and node or nil
        end
        -- Fixed behaviour for players (no menu entry), still switchable by benchmarks and consumers.
        local function fixed(value)return {Value=function(_,v)if v~=nil then value=v end;return value end}end
        -- `from`: where an earlier build saved this entry. The toggle is stored under a new id because a
        -- saved F6 (key 117) reloads the scripts and can never work: its saved state moves, F6 becomes the default.
        local entries={{id='Toggle',alias='Enabled',from='Controls.Enabled',name='Evade on / off',value=true,key=75,toggle=true},
            -- Mouse 5 (player choice 2026-10-10): a modifier (Ctrl/Shift/Alt) cannot be the pause key, because
            -- Ctrl+Q/W/E/R levels abilities in League and the combo could not cast while it is held.
            {id='PauseHold',alias='Bypass',from='Controls.Bypass',name='Pause Evade while held',key=6},
            {id='DrawThreats',name='Draw incoming skillshots',value=true},
            {id='DrawPath',name='Draw escape path',value=true},{id='DrawStatus',name='Show Evade status and binds',value=true},
            {id='SpellsEnabled',name='Use my abilities to dodge or block',value=true},
            {id='Items',name='Use defensive items',value=true},{id='Ultimates',name='Allow ultimates to dodge or block',value=false},
            {id='MinDamage',from='DashDefense.MinDamage',name='Abilities and items only for hits above health %',value=20,min=0,max=100,step=5}}
        for _,v in ipairs(entries)do
            local group=v.key and 'Controls'or v.id:match('^Draw')and 'Appearance'or v.id=='RecordDiagnostics'and 'Tracking'or 'Automation'
            local alias,from=v.alias or v.id,v.from;v.alias=nil;v.from=nil
            if migration then
                migration:Apply(v,'OrbamaEvade',from or v.id,group..'.'..v.id)
                if v.key and type(v.value)=='boolean'then
                    local row=savedRow(group..'.'..v.id)or from and savedRow(from)or savedRow(v.id)
                    if row and type(row.__active)=='boolean'then v.value=row.__active end
                end
            end
            if v.id=='Toggle'and v.key==117 then v.key=75 end
            if v.id=='PauseHold'and(v.key==16 or v.key==17 or v.key==18)then v.key=6 end
            if migration and type(v.value)=='number'and not v.key then
                -- A saved number (the host may store it as value or as state), kept inside the entry's bounds.
                local row=savedRow(group..'.'..v.id)or from and savedRow(from)
                local number=row and(type(row.__value)=='number'and row.__value or type(row.__active)=='number'and row.__active)
                if number then v.value=math.max(v.min or number,math.min(v.max or number,number))end
            end
            self.menu[group]:MenuElement(v);self.menu[alias]=self.menu[group][v.id];filled[group]=true
        end
        -- Developer overlays are menu entries only in a recording build; drawing as a whole has no switch.
        for _,v in ipairs({{id='DrawAllThreats',name='Also draw skillshots far from you',value=false},
            {id='DrawIntent',name='Draw where Evade wants to move',value=false},{id='DrawTiming',name='Draw skillshot timing',value=false}})do
            if self.menu.RecordDiagnostics then
                if migration then migration:Apply(v,'OrbamaEvade','Appearance.'..v.id,'Tracking.'..v.id)end
                self.menu.Tracking:MenuElement(v);self.menu[v.id]=self.menu.Tracking[v.id]
            else self.menu[v.id]=fixed(false)end
        end
        self.menu.DrawEnabled=fixed(true)
        -- A group without entries (Tracking in a release build) is not shown.
        for _,name in ipairs({'Controls','Automation','Tracking','Appearance'})do
            local node=self.menu[name];if not filled[name]and node and type(node.Hide)=='function'then pcall(node.Hide,node,true)end
        end
        self.menu:MenuElement({type=self.g.MENU,id='Spells',name='Enemy skillshots'})
    end
    DefenseAdapter.Install(self)
    ItemAdapter.Install(self)
    FlashAdapter.Install(self)
    DashAdapter.Install(self)
    UntargetableAdapter.Install(self)
    self.compat={Evading=function()return self:Evading()end,Loaded=function()return self.active end,
        IsDangerous=function(first,second)return self:IsDangerous(second or first)end,
        SafePos=function()return self:SafePosition()end}
    if not self.g.JustEvade then self.g.JustEvade=self.compat end
    if self.g.Callback and self.g.Callback.Add then self.g.Callback.Add('UnLoad',function()self:Shutdown()end)end
    -- Optional host adapter, never inferred from a map number or champion name.
    if type(self.g.OrbamaEvadeMapObservation)=='function'then
        local ok,observation=pcall(self.g.OrbamaEvadeMapObservation)
        if ok then self:BindTerrain(observation)end
    end
end
function A.boot(g)
    -- Host library order is not provider readiness. Keep one inert bootstrap
    -- until Orbama publishes its API, without loading or replacing any provider.
    local pending=g.OrbamaEvadeBootstrap
    if pending and pending.waiting then return end
    local state={waiting=true};g.OrbamaEvadeBootstrap=state
    local function stop()
        state.waiting=false
        if g.OrbamaEvadeBootstrap==state then g.OrbamaEvadeBootstrap=nil end
        if g.Callback and g.Callback.Del then
            if state.tick then pcall(g.Callback.Del,'Tick',state.tick)end
            if state.unload then pcall(g.Callback.Del,'UnLoad',state.unload)end
        end
    end
    local function attempt()
        if not state.waiting then return end
        local sdk=g.SDK
        if not sdk or not sdk.OrbamaVersion or not sdk.Actions or type(sdk.OnTick)~='table' then return end
        if sdk.Evade then stop();return sdk.Evade end
    if g.JustEvade or g.ExtLibEvade or g.superEvade or g.DepressiveEvade then
            stop();if g.print then g.print('[OrbamaEvade] Another evade provider is present; unload it before enabling OrbamaEvade.')end;return
        end
        local caps=type(sdk.Actions.GetCapabilities)=='function'and sdk.Actions:GetCapabilities()
        if not caps or not caps.prevalidateWorldMove then
            stop();if g.print then g.print('[OrbamaEvade] Reload the updated Orbama provider first.')end;return
        end
        stop();local self=A.new(g);self:Install();return self
    end
    local ready=attempt()
    if not state.waiting then return ready end
    if g.Callback and g.Callback.Add then
        state.tick=attempt;state.unload=stop
        g.Callback.Add('Tick',state.tick);g.Callback.Add('UnLoad',state.unload)
        if g.print then g.print('[OrbamaEvade] Waiting for Orbama to initialize.')end
    else
        stop();if g.print then g.print('[OrbamaEvade] Orbama is unavailable and the host has no startup callback.')end
    end
end
return A

end
