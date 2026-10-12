return function(require)
local U=require('leesin.util');local P=require('leesin.profiles')
local F={};F.__index=F
function F.new(ctx,actions,spells,smite)
    return setmetatable({ctx=ctx,actions=actions,spells=spells,smite=smite,known={},state='idle'},F)
end
function F:startRoute()
 -- A new route never inherits a previous route's recovery or retreat.
 self.threatRetreat=nil;self.recoveryTrigger=nil;self.pressureSample=nil
 self.recoveryWanted=nil;self.recallReconcile=nil;self.recallObserved=false;self.recallAction=nil;self.recallLegacy=nil
 self.retreatCamp=nil;self.retreatMove=nil;self.returningHome=nil;self.recoveryReason=nil
 if self.state=='retreating'or self.state=='recall_pending'or self.state=='returning_base'or self.state=='finishing'then self.state='routing'end
 self.camp=nil;self.progressAt=nil;self.opening=nil;self.localException=nil
 self.actions.routeStop=nil;self.actions.routeObservation=nil;self.actions.routeCommand=nil
 self.probe=nil;self.travelTarget=nil;self.travelJob=nil;self:updateCamps()
 -- Finish an enemy camp the player started next to (an explicit, local exception).
 local c=self.ctx
 if c.config:get('farmLocalEnemyStart')then
  local nearest,engaged=650,false
  for _,camp in pairs(self.known)do
   if not P.epics[camp.category]and camp.team and camp.team~=0 and camp.team~=myHero.team and c:threats(camp.pos,1000)==0 then
    for _,m in ipairs(camp.members or {})do
     local distance=U.dist(myHero.pos,m.pos);local fighting=(m.health or 0)<(m.maxHealth or m.health or 0)
     if self:ordinaryTarget(m)and distance<=650 and(not self.localException or fighting and not engaged or fighting==engaged and distance<nearest)then
      self.localException,nearest,engaged=camp.id,distance,fighting
     end
    end
   end
  end
 end
 self:ensureRouter():Start()
 if self.localException then self.camp=self.known[self.localException]end
end
function F:krugRemnant(unit)
    return self.ctx.profile.id=='normal' and U.name(unit and unit.charName)=='srukrugminimini'
end
function F:living(camp)
    for _,m in ipairs(camp.members or {}) do if U.valid(m) then return true end end
    return false
end
function F:hasRemnants(camp)
    if self.ctx.profile.id~='normal' or camp.category~='Krugs' then return false end
    for _,m in ipairs(camp.members or {}) do
        if self:krugRemnant(m) and U.valid(m) then return true end
    end
    return false
end
function F:splitPending(camp)
    return camp and self.ctx.profile.id=='normal' and camp.category=='Krugs'
        and self.ctx:now()<(camp.splitUntil or 0)
end
function F:spawn()
    self.spawnPoints=self.spawnPoints or {}
    if self.spawnPos and not U.position(self.spawnPos) then self.spawnPos=nil end
    for _,team in ipairs({100,200}) do
        if self.spawnPoints[team] and not U.position(self.spawnPoints[team]) then self.spawnPoints[team]=nil end
    end
    if self.spawnPos and self.spawnPoints[100] and self.spawnPoints[200] then return self.spawnPos end
    local now=self.ctx:now()
    if Game.ObjectCount and Game.Object and now>(self.spawnScanAt or -2)+.5 then
        self.spawnScanAt=now
        local count=U.count(Game.ObjectCount(),65536)
        local first=self.spawnScanIndex or 1;if first>count then first=1 end
        local last=math.min(count,first+63)
        for i=first,last do
            local o=Game.Object(i)
            if o and ((Obj_AI_SpawnPoint and o.type==Obj_AI_SpawnPoint) or U.name(o.charName)=='spawnpoint') and U.position(o.pos) then
                local team=(o.team==100 or o.team==200) and o.team or o.isAlly and myHero.team
                if team then self.spawnPoints[team]=U.copy(o.pos) end
                if team==myHero.team then self.spawnPos=U.copy(o.pos) end
            end
        end
        self.spawnScanIndex=last>=count and 1 or last+1
    end
    if self.ctx.profile.id=='normal' then
        self.spawnPoints[100]=self.spawnPoints[100] or {x=400,y=180,z=420}
        self.spawnPoints[200]=self.spawnPoints[200] or {x=14300,y=180,z=14350}
        return self.spawnPos or self.spawnPoints[myHero.team]
    end
    -- Discover Classic spawn at load/respawn instead of copying a different map.
    if not self.spawnPos and U.position(myHero.pos) and (self.ctx:now()<25 or self.ctx:now()<180 and (myHero.levelData.lvl or 1)==1
        and (myHero.pos.x<1500 and myHero.pos.z<1500 or myHero.pos.x>13000 and myHero.pos.z>13000)) then
        self.spawnPos=U.copy(myHero.pos)
    end
    return self.spawnPos
end
function F:campTeam(pos)
    self:spawn()
    local spawns=self.spawnPoints
    if spawns and spawns[100] and spawns[200] then
        -- Relative proximity to both bases, never a fixed distance from ours.
        return U.dist(pos,spawns[100])<U.dist(pos,spawns[200]) and 100 or 200
    end
end
function F:updateCamps()
 local c=self.ctx;local service=c.sdk.OrbamaUtils and c.sdk.OrbamaUtils.Camps
 if not service or service.version~=2 then self.known={};c.status='Shared camp knowledge unavailable';return end
 if self.campService~=service then
   if self.campScope then self.campScope:Close()end;self.campService=service
  self.campScope=service:Register('AyyyyIO:LeeSin',function()return not c.retired and c.app and c.app.active end)
  if c.core and self.campScope then c.core:RegisterService('camp-knowledge',self.campScope)end
 end
 self.known=service:Refresh();self.mapSeeded=next(self.known)~=nil
 self.nativeDownUnreliable=service.nativeDownUnreliable==true
end
function F:epicSoon()
    for _,camp in pairs(self.known) do
        if P.epics[camp.category] and U.dist(myHero.pos,camp.pos)<3000 then
            for _,m in ipairs(camp.members or {}) do
                if U.valid(m) and m.health<(m.maxHealth or m.health)
                    and (self:alliesTaking(camp) or m.health<(m.maxHealth or m.health)*.5) then return true end
            end
        end
    end
    return false
end
function F:alliesTaking(camp)
    for _,a in ipairs(self.ctx.allies or {}) do
        if U.dist(a.pos,camp.pos)<1000 then
            local target=a.attackData and a.attackData.target
            local spell=a.activeSpell
            for _,m in ipairs(camp.members or {}) do
                if target==m.handle or (spell and spell.valid and spell.target==m.handle) then return true end
            end
        end
    end
    return false
end
function F:homeAvailable()
    -- One answer per state cycle: route choice asks once per candidate camp.
    local now=self.ctx:now()
    if self.homeAvailableAt==now then return self.homeAvailableValue end
    self.homeAvailableAt=now;self.homeAvailableValue=self:homeAvailableNow();return self.homeAvailableValue
end
function F:homeAvailableNow()
    local team=myHero.team
    for _,camp in pairs(self.known) do
        -- Only an own-side, non-epic camp can answer; others skip the travel estimate.
        if camp.team==team and not P.epics[camp.category] then
            local travel=U.dist(myHero.pos,self:walkDestination(camp))/math.max(200,myHero.ms or 350)
            local due=camp.expectedAt and camp.expectedAt<=self.ctx:now()+travel
            local available=camp.nativeUp~=false and not camp.awaitingRespawn and camp.availability~='observed_empty'
            if (available or due or self:staging(camp))
                and self.ctx:now()>=(camp.blockedUntil or 0) and self.ctx:threats(camp.pos,1000)==0
                and not self.ctx:underTurret(camp.pos) then return true end
        end
    end
    return false
end
-- `home` (own-side work available) is read only by the invading branch at the
-- end; without an explicit value it is computed there, not for every camp.
function F:sideAllowed(camp,home)
    if self.returningHome then return camp.team==myHero.team end
    if self.localException==camp.id and not P.epics[camp.category] then return true end
    -- One side setting (player request 2026-10-11): without "Route into the enemy jungle" only our side.
    if not self.ctx.config:get('invade') and (camp.team~=nil or self.mapSeeded) then return camp.team==myHero.team end
    -- Enemy-side camps need the invade setting; river and own-side camps never do.
    if camp.team~=nil and camp.team~=0 and camp.team~=myHero.team and not self.ctx.config:get('invade') then return false end
    if home==nil then home=self:homeAvailable() end
    return not home or camp.team==myHero.team or camp.team==0
end
-- Name classification is a pure function of charName: memoize it (bounded,
-- discarded when full). Validity and team are always read fresh.
local ordinaryNames,ordinaryNameCount={},0
function F:ordinaryTarget(target)
    if not (U.valid(target) and target.team==300) then return false end
    local name=target.charName or ''
    local ordinary=ordinaryNames[name]
    if ordinary==nil then
        ordinary=P.jungleEntity(target) and not P.epics[P.category(name)] or false
        if ordinaryNameCount>=512 then ordinaryNames={};ordinaryNameCount=0 end
        ordinaryNames[name]=ordinary;ordinaryNameCount=ordinaryNameCount+1
    end
    return ordinary
end
function F:routeDistance(camp,destination)
    local c=self.ctx;destination=destination or self:walkDestination(camp);local straight=U.dist(myHero.pos,destination)
    if not c.terrain:trusted() then return straight,'unverified straight distance' end
    self.routeCosts=self.routeCosts or {}
    local row=self.routeCosts[camp.id];local terrain=c.terrain
    if not row or row.provider~=terrain.provider or row.wall~=terrain.provider.isWall
        or U.dist(row.origin,myHero.pos)>150 or U.dist(row.destination,destination)>100 then
        row={origin=U.copy(myHero.pos),destination=U.copy(destination),provider=terrain.provider,wall=terrain.provider.isWall}
        row.work=coroutine.create(function()
            if terrain:walkLine(row.origin,row.destination,myHero.boundingRadius or 35) then return straight end
            local path,length=require('leesin.navigation').approach(terrain,row.origin,row.destination,220,straight*2+1500,
                function()coroutine.yield()end,function(p)return terrain:walkLine(p,row.destination,myHero.boundingRadius or 35)end,8)
            return path and length+U.dist(path[#path] or row.origin,row.destination)
        end)
        self.routeCosts[camp.id]=row
    end
    -- One bounded solver slice for the whole controller per state cycle.
    if not row.done and self.routeCostAt~=c:now() then
        self.routeCostAt=c:now()
        local ok,value=coroutine.resume(row.work)
        if not ok or coroutine.status(row.work)=='dead' then row.done=true;row.cost=ok and value or nil end
    end
    return row.cost or straight,row.cost and 'verified terrain route' or 'unverified straight distance'
end
-- Says why routing has nothing to do. Mirrors the eligibility rules in choose();
-- bounded by the known camp table, and only evaluated while no camp is selected.
function F:noCampReason()return self.router and self.router.reason or 'No safe camp available'end
function F:choose(exclude,preview)
 self:updateCamps();return self:ensureRouter():Choose(self.known,self.ctx:now(),exclude)
end
function F:staging(camp)
 return camp.timing and camp.timing.firstSpawn and self.ctx:now()<camp.timing.firstSpawn and not camp.seenAlive
end
function F:pause(reason)
    self.travelTarget=nil;self.travelJob=nil;self.probe=nil
    self.ctx.input:pauseFarm(reason);self.ctx.status=reason or 'Farming paused';self.state='paused'
    self.ctx.attackTarget=nil;self.ctx.moveTarget=nil
end
function F:kiteLine(origin,destination)
    local terrain=self.ctx.terrain;local radius=myHero.boundingRadius or 35
    -- Live positions can overlap conservative static-grid padding. Egress only
    -- permits leaving that padding; its centerline never crosses a wall.
    if terrain.egressLine then return terrain:egressLine(origin,destination,radius) end
    return terrain:walkLine(origin,destination,radius)
end
function F:kiteClick(point,target,center,leash,scene)
    local c=self.ctx;local distance=U.dist(myHero.pos,point)
    if distance<1 then return point end
    -- The click is a steering ray, not the turnaround waypoint. Only actual
    -- travel is leash-bounded. A straight, empty ray avoids native wall detours.
    local ground=require('leesin.ground')
    for _,length in ipairs({math.max(distance,1000),math.max(distance,800),math.max(distance,600),math.max(distance,400),math.max(distance,250),distance}) do
        local click=U.toward(myHero.pos,point,length)
        -- Same screen contract as every provider move: on screen and off a measured HUD.
        if ground.safePoint(c,click) and self:kiteLine(myHero.pos,click)
            and not ground.blocker(c,click,scene) then return click end
    end
    return nil
end
function F:kiteDecision(target,reason)
    local c=self.ctx;local camp=self.camp
    if not c.config.capture or not camp then return end
    local attack=c.sdk.Attack;local row=self.kiteDiagnostic or {};self.kiteDiagnostic=row
    row.reason=reason;row.at=c:now();row.target=U.id(target);row.name=target.charName
    row.range=target.range;row.main=camp.mainID;row.enabled=c.config:get('farmKite')
    row.autoAttacking=c.sdk.Orbwalker:IsAutoAttacking();row.canMove=c.sdk.Orbwalker:CanMove()
    row.ready=attack and attack.IsReady and attack:IsReady();row.serverStart=attack and attack.ServerStart
    row.castEnd=attack and attack.CastEndTime;row.cycle=attack and attack.GetAnimation and attack:GetAnimation()
    row.separation=U.dist(myHero.pos,target.pos);row.center=camp.kiteCenter;row.leash=c.config:get('farmKiteLeash')
    row.latency=c.latency;row.jitter=c.jitter;row.speed=myHero.ms
    row.position=U.copy(myHero.pos);row.targetPosition=U.copy(target.pos)
end
function F:kitePursuers(target)
    local out={}
    for _,m in ipairs(self.camp and self.camp.members or {target}) do
        if U.valid(m) and (m.range or 0)<=250 then
            out[#out+1]={pos=U.copy(m.pos),stop=math.max(75,m.range or 100)+(m.boundingRadius or 45)+(myHero.boundingRadius or 35)}
        end
    end
    return out
end
function F:kiteBound(point,target,center,leash,reserve,pursuers)
    local radius=U.dist(point,center)
    if radius<=leash then return true,false end
    -- The leash belongs to pursuing monsters, not Lee's hitbox. Permit a
    -- bounded outer arc when the preferred inner ring has no usable step.
    -- Reserve overshoot room for one delayed callback; check every melee pursuer.
    local margin=math.max(25,(myHero.ms or 350)*(reserve or .15))
    if radius>math.max(leash,U.dist(myHero.pos,center))+80 then return false end
    local checked=false
    local inward=radius<U.dist(myHero.pos,center)-15
    for _,m in ipairs(pursuers or self:kitePursuers(target)) do
        checked=true
        local gap=U.dist(m.pos,point)
        local chase=gap>m.stop and U.toward(m.pos,point,gap-m.stop) or m.pos
        local chasedRadius=U.dist(chase,center)
        if chasedRadius>leash-margin and not (inward and chasedRadius<=U.dist(m.pos,center)+1) then return false end
    end
    return checked,true
end
function F:kite(target)
    local c=self.ctx;local camp=self.camp;local attack=c.sdk.Attack
    if not camp then return end
    local name=U.name(target.charName)
    if (target.range or 0)>250 or name:find('wraith',1,true) or name:find('wight',1,true)
        or name:find('gromp',1,true) then self.kiteStep=nil;self:kiteDecision(target,'ranged_target');return end
    -- Remember the largest member, including after it dies. A surviving small
    -- monster must not become the "main" monster just because it is alone.
    for _,m in ipairs(camp.members or {}) do
        if (m.maxHealth or 0)>(camp.mainHealth or 0) then camp.mainHealth=m.maxHealth;camp.mainID=U.id(m) end
    end
    if not c.config:get('farmKite') or c:dash()
        or not attack or not attack.IsReady then self.kiteStep=nil;self:kiteDecision(target,'attack_or_movement_gate');return end
    if attack:IsReady() then
        if self.kiteStep and U.dist(myHero.pos,target.pos)>c:attackRange(target) then
            self.kiteStep.phase='attack'
        else self.kiteStep=nil end
        self:kiteDecision(target,'attack_ready');return
    end
    local cycle=attack.GetAnimation and attack:GetAnimation() or 1
    local started=attack.ServerStart
    if not started or started<=0 then self:kiteDecision(target,'missing_attack_start');return end -- No invented attack timing.
    local remaining=started+cycle-c:now()
    local finish=attack.CastEndTime and attack.CastEndTime>=started and attack.CastEndTime or started+c:windup()
    local preparing=c:now()<finish or c.sdk.Orbwalker:IsAutoAttacking() or not c.sdk.Orbwalker:CanMove()
    if remaining<=0 then self:kiteDecision(target,'attack_windup_or_ready');return end
    if preparing and self.kiteStep and self.kiteStep.started==started and self.kiteStep.target==U.id(target)
        and self.kiteStep.cycle==cycle then return end
    if not camp.kiteCenter then
        local center=camp.aimPos or camp.pos;local health=0
        local layout=camp.spawnLayout
        if layout and layout.mode==c.profile.id and layout.mapID==Game.mapID then
            for _,row in ipairs(layout.rows) do
                if (row.maxHealth or 0)>health then center=row.pos;health=row.maxHealth end
            end
        end
        camp.kiteCenter=U.copy(center)
    end
    local center=camp.kiteCenter;local leash=c.config:get('farmKiteLeash')
    local observed=camp.kiteHealth
    if observed and observed.id==U.id(target) and c:now()-observed.at<.5
        and target.health>observed.hp+math.max(30,target.maxHealth*.02) then
        camp.kiteRecoverUntil=c:now()+2;self.kiteStep=nil
        if c.config.capture then c:log('kite_reset_suspected',{target=U.id(target),health=target.health,previous=observed.hp}) end
    end
    camp.kiteHealth={id=U.id(target),hp=target.health,at=c:now()}
    -- Crossing the preferred leash ring is a reason to turn inward, not to
    -- disable kiting for the rest of the fight. Actual resets still suspend it.
    if U.dist(target.pos,center)>leash+150 or c:now()<(camp.kiteRecoverUntil or 0) then self.kiteStep=nil;self:kiteDecision(target,'leash_or_reset');return end
    local speed=math.max(1,myHero.ms or 350);local ownRange=math.max(30,c:attackRange(target)-10)
    local separation=U.dist(myHero.pos,target.pos)
    local timing=c.sdk.Input and c.sdk.Input.Timing
    -- Callback jitter is different from network ping. Refresh this reserve at
    -- most four times a second, keeping statistical work out of the fast path.
    if not self.kiteReserveAt or c:now()>=self.kiteReserveAt+.25 then
        self.kiteReserveAt=c:now()
        self.kiteReserve=timing and timing.reserve and U.clamp(timing:reserve()*.001,0,.2) or .06
    end
    local reserve=c.latency+math.max(.016,self.kiteReserve or .06)
    local returnTime=math.max(0,separation-ownRange)/speed
    local key=tostring(U.id(target))..':'..tostring(started)
    local step=self.kiteStep
    if step and step.key==key and step.cycle and math.abs(step.cycle-cycle)>.001 then
        self.kiteStep=nil;self.kiteSearch=nil;step=nil
    end
    local function publish(point)
        if not preparing then return point end
    end
    if step and step.key==key and step.phase=='attack' then return end
    local passedWaypoint=step and step.key==key and step.phase=='out'
        and (U.dist(myHero.pos,step.pos)<=25 or step.origin
            and (myHero.pos.x-step.origin.x)*(step.pos.x-step.origin.x)
                +(myHero.pos.z-step.origin.z)*(step.pos.z-step.origin.z)
                >=math.max(0,U.dist(step.origin,step.pos)-25)*U.dist(step.origin,step.pos))
    -- Begin returning while the attack is still cooling down. Use a stationary
    -- target for this budget: a chasing monster may help, but is not promised.
    local reachedOut=passedWaypoint and separation>ownRange
    if reachedOut or (separation>ownRange or self.kiteStep and self.kiteStep.key==key and self.kiteStep.phase=='out')
        and remaining<=returnTime+reserve then
        self.kiteStep={key=key,pos=U.copy(target.pos),phase='attack',target=U.id(target),started=started}
        if c.config.capture then c:log('kite_attack_due',{target=U.id(target),remaining=remaining,
            returnTime=returnTime,reserve=reserve,separation=separation}) end
        return -- The target attack order performs the approach, without a ground move.
    end
    if self.kiteStep and self.kiteStep.key==key then
        local p=self.kiteStep.pos
        if self.kiteStep.phase=='return' and separation<=ownRange or passedWaypoint or U.dist(myHero.pos,p)<=25 then
            -- The monster may have followed us faster than expected. Replan
            -- along the camp boundary instead of waiting at a reached waypoint.
            self.kiteStep=nil;self.kiteSearch=nil
        elseif U.dist(myHero.pos,p)>25 and self:kiteBound(p,target,center,leash,reserve) and self:kiteLine(myHero.pos,p) then
            -- Reuse the geometric ray for this attack instead of recomputing it
            -- on every Draw. Dispatch still checks current projected blockers.
            return publish(self.kiteStep.phase=='out' and self.kiteStep.click or p)
        else
            self.kiteStep=nil
        end
    end
    local budget=math.max(0,remaining-math.max(0,finish-c:now())-reserve)*speed
    local distance=math.min(c.config:get('farmKiteDistance'),budget)
    if distance<30 then self:kiteDecision(target,'insufficient_movement_time');return end
    local away=U.toward(target.pos,myHero.pos,1)
    local dx,dz=away.x-target.pos.x,away.z-target.pos.z
    if U.dist(myHero.pos,target.pos)<1 then dx,dz=1,0 end
    local enemyRange=((target.range or 0)>0 and target.range or 125)+(target.boundingRadius or 45)+(myHero.boundingRadius or 35)+25
    local direction=camp.kiteDirection or 1;local best,bestAngle,bestClick;local candidates={}
    local search=self.kiteSearch
    if search and search.key==key and c:now()<search.at+.08 and U.dist(myHero.pos,search.origin)<20
        and U.dist(target.pos,search.target)<20 then return end
    self.kiteSearch={key=key,at=c:now(),origin=U.copy(myHero.pos),target=U.copy(target.pos)}
    self:kiteDecision(target,'searching_or_following_plan')
    local scene=require('leesin.ground').scene(c)
    local pursuers=self:kitePursuers(target)
    -- Outward first; near the edge, turn tangentially and then inward. Keep a
    -- consistent rotation across attacks instead of flipping left/right.
    local radial=U.dist(myHero.pos,center)
    for _,angle in ipairs({0,.55,1.1,1.57,2.1,2.65,3.14,-.55,-1.1,-1.57,-2.1,-2.65}) do
        local a=angle*direction
        local x,z=dx*math.cos(a)-dz*math.sin(a),dx*math.sin(a)+dz*math.cos(a)
        for _,scale in ipairs({1,.75,.5}) do
            local length=distance*scale
            local p={x=myHero.pos.x+x*length,y=myHero.pos.y,z=myHero.pos.z+z*length}
            local gap=U.dist(p,target.pos);local back=math.max(0,gap-ownRange)
            local bounded,outer=self:kiteBound(p,target,center,leash,reserve,pursuers)
            local inward=radial>leash-40 and U.dist(p,center)<radial-15
                and gap>=math.max((target.boundingRadius or 45)+(myHero.boundingRadius or 35)+15,math.min(separation,enemyRange)-25)
            if length>=30 and length+back<=budget and bounded
                and (gap>=enemyRange or gap>separation+15 or inward) then
                local value=math.min(gap-enemyRange,45)*4+length*.15
                    + (angle>0 and 12 or angle<0 and -12 or 0)-math.abs(angle)*5
                    - (outer and 1000+math.max(0,U.dist(p,center)-leash) or 0)
                    + (inward and math.min(80,radial-U.dist(p,center)) or 0)
                candidates[#candidates+1]={pos=p,score=value,angle=angle,back=back,index=#candidates+1}
            end
        end
    end
    -- Score order first; the terrain lines (the costly part) are walked only
    -- until the first candidate whose lines and click both pass. Same choice as
    -- checking every candidate's lines before sorting; equal scores keep list order.
    table.sort(candidates,function(a,b)if a.score~=b.score then return a.score>b.score end;return a.index<b.index end)
    for _,candidate in ipairs(candidates) do
        local p=candidate.pos
        if self:kiteLine(myHero.pos,p) and (candidate.back==0 or self:kiteLine(p,U.toward(target.pos,p,ownRange))) then
            local click=self:kiteClick(p,target,center,leash,scene)
            if click then best,bestAngle,bestClick=p,candidate.angle,click;break end
        end
    end
    if best then
        self:kiteDecision(target,'outward_plan')
        if bestAngle<0 then camp.kiteDirection=-direction else camp.kiteDirection=direction end
        self.kiteStep={key=key,started=started,target=U.id(target),cycle=cycle,pos=best,click=bestClick,origin=U.copy(myHero.pos),phase='out',preparedAt=c:now(),castEnd=finish}
        if c.config.capture then c:log('kite_planned',{target=U.id(target),origin=U.copy(myHero.pos),destination=U.copy(best),
            center=U.copy(center),remaining=remaining,enemyRange=enemyRange,ownRange=ownRange,
                separation=U.dist(best,target.pos),travel=U.dist(myHero.pos,best),budget=budget,click=U.copy(bestClick),
                preparedDuringWindup=preparing,cycle=cycle,castEnd=finish,reserve=reserve}) end
        return publish(bestClick)
    end
    self:kiteDecision(target,'no_feasible_ground_and_return_budget')
end
function F:fastKite()
    local c=self.ctx;local camp=self.camp
    if (self.state~='clearing' and self.state~='finishing') or not camp or camp.nativeUp==false or camp.awaitingRespawn
        or not c.config:get('autoJungle') or c.input.farmPaused
        or c:blocked() or c:recalling() or c.wards.pending or c.combat.insec then return false end
    local target=camp.focus or c.attackTarget
    if not self:ordinaryTarget(target) then return false end
    -- Draw/post-attack can run before the next planning Tick. Dispatch a ready
    -- attack there too, through the same scoped API and native readiness gates.
    if U.same(c.attackTarget,target) and c.actions.attack and c.sdk.Orbwalker:CanAttack()
        and U.dist(myHero.pos,target.pos)<=c:attackRange(target) then
        return c.actions:attack(target,'farm')
    end
    local point=self:kite(target)
    local step=self.kiteStep
    if step and step.phase=='attack' and c.actions.attackApproach then
        return c.actions:attackApproach(target,'farm',step.key)
    end
    if not point then return false end
    local accepted,reason=self.actions:move(point,'farm');local id=self.actions.lastCursorAction
    if accepted and id and id~=self.kiteMoveID then
        self.kiteMoveID=id
        if c.config.capture then c:log('kite_move_request',{cursorID=id,target=U.id(target),destination=U.copy(point),
            attackStart=c.sdk.Attack.ServerStart,castEnd=c.sdk.Attack.CastEndTime,
            windupDeltaMs=c.sdk.Attack.CastEndTime and (c:now()-c.sdk.Attack.CastEndTime)*1000,
            phase=self.kiteStep and self.kiteStep.phase,preparedAt=self.kiteStep and self.kiteStep.preparedAt}) end
    end
    return accepted,reason
end
function F:clear(target)
    if not self:ordinaryTarget(target) then self.ctx.attackTarget=nil;return end
    -- Attacking and kiting intentionally replace the travel destination.
    -- Retire its endpoint check before Orbama issues the first combat order.
    self.actions.routeObservation=nil;self.actions.routeCommand=nil;self.actions.routeStop=nil
    if self.camp then self.camp.lastFoughtAt=self.ctx:now() end
    local c=self.ctx;c.attackTarget=target;c.moveTarget=nil
    -- Orbama remains responsible for attack readiness and windup cancellation.
    -- Retreat/return planning runs during cooldown; Orbama starts the next attack.
    local kite=self:kite(target)
    if kite then c.moveTarget=kite
    elseif self.kiteStep and self.kiteStep.phase=='attack' and c.actions.attackApproach then
        c.actions:attackApproach(target,'farm',self.kiteStep.key)
    elseif U.dist(myHero.pos,target.pos)>c:attackRange(target) then
        -- A monster's body is an attack destination, not a ground-click point.
        -- Keep the attack owner while approaching, including after a kite step
        -- or a focus change to another member of this same camp.
        if c.actions.attackApproach then
            c.actions:attackApproach(target,'farm','camp:'..tostring(self.camp and self.camp.id))
        else c.moveTarget=target.pos end
    end
    c.clear:tick(target,'farm')
end
function F:priority(m)
    local hits=m.health/math.max(1,self.ctx:aaDamage(m))
    -- Remove cheap camp attackers first; do not spend a full buff-sized clear
    -- on a small monster. AoE can finish the remaining small units together.
    return hits<=4 and -100000+hits or -(m.maxHealth or m.health)
end
function F:selectTarget(camp)
    if ((camp.nativeUp==false or camp.awaitingRespawn) and not self:hasRemnants(camp)) or P.epics[camp.category] then return end
    local c=self.ctx;local now=c:now();local units={};local main
    for _,m in ipairs(camp.members or {}) do if self:ordinaryTarget(m) then
        units[#units+1]=m
        if not main or (m.maxHealth or m.health)>(main.maxHealth or main.health) then main=m end
    end end
    local current=camp.focus;local early=(myHero.levelData.lvl or 1)<=c.config:get('farmSurvivalLevel') or U.hp(myHero)<40
    local smite=c.config:get('autosmite') and c.smite:ready() and not self:epicSoon() and c.smite:damage() or 0
    -- Invocation-local values: retain fresh HP each decision without querying
    -- SDK damage/buffs repeatedly for focus retention and diagnostic output.
    local hitCounts,scores={},{}
    local cycle=c.sdk.Attack.GetAnimation and c.sdk.Attack:GetAnimation() or 1
    local eLearned=(c:spell(2).level or 0)>0
    local function hits(m)
        if hitCounts[m]~=nil then return hitCounts[m] end
        local hp=m.health+(m.allShield or 0)
        if U.same(m,main) and c.smite:campTarget(m) and c.smite:inRange(m) then hp=hp-smite+c.config:get('smiteMargin') end
        local count=math.max(0,math.ceil(hp/math.max(1,c:aaDamage(m))))
        hitCounts[m]=count;return count
    end
    local function score(m)
        local count=hits(m);local move=math.max(0,U.dist(myHero.pos,m.pos)-c:attackRange(m))/math.max(1,myHero.ms or 350)
        if early then
            -- Weighted completion-time rule: remove damage sources according to
            -- remaining kill time / incoming DPS. Actual monster stats take
            -- priority; max-health scaling is an explicit fallback estimate.
            local damage=m.totalDamage or m.attackData and m.attackData.damage or math.max(8,(m.maxHealth or m.health)*.035)
            local rate=m.attackSpeed or (m.attackData and m.attackData.animationTime and 1/math.max(.2,m.attackData.animationTime)) or .7
            return (count*cycle+move)/math.max(1,damage*rate)
        end
        -- With AoE available, hit the durable member while cleave/E wears down
        -- the rest. Otherwise choose quick cleanup with minimal movement.
        if count<=2 then return -100+count+move end
        -- E entering cooldown must not flip focus back to healthy companions.
        -- Continue damaging the durable member between successive AoE cycles.
        if #units>1 and eLearned and count>2 then return -(m.maxHealth or m.health)/1000+move end
        return count*cycle+move
    end
    local best,bestScore=nil,math.huge
    for _,m in ipairs(units) do local value=score(m);scores[m]=value;if value<bestScore then best,bestScore=m,value end end
    if current then
        -- Host wrappers can change between scans for the same network identity.
        -- Retention must use this scan's object, health and cached score.
        local observed
        for _,m in ipairs(units) do if U.same(m,current) then observed=m;break end end
        if observed and (hits(observed)<=2 or scores[observed]<=bestScore+math.max(.05,math.abs(bestScore)*.25) or now<(camp.focusUntil or 0)) then best=observed end
    end
    if best and not U.same(best,current) then
        camp.focusUntil=now+.6
        if c.config.capture then c:log('camp_focus',{target=U.id(best),name=best.charName,policy=early and 'damage mitigation' or 'clear speed',remainingAttacks=hits(best)}) end
    end
    camp.focus=best
    return best
end
function F:localTarget(lane,jungle)
    local c=self.ctx;c:refresh();self:updateCamps()
    if lane==nil then lane=true end;if jungle==nil then jungle=true end
    if self.localCamp and jungle then
        local best,score=nil,math.huge
        for _,m in ipairs(self.localCamp.members or {}) do
            if U.valid(m) and U.dist(myHero.pos,m.pos)<=c:attackRange(m)+150 then
                local value=self:priority(m);if value<score then best,score=m,value end
            end
        end
        if best then return self:selectTarget(self.localCamp) or best end
    end
    self.localCamp=nil
    local anchor,distance=nil,math.huge
    for _,m in ipairs(c.minions or {}) do
        if U.valid(m) and m.team~=myHero.team and (m.team==300 and jungle or m.team~=300 and lane) then
            local d=U.dist(myHero.pos,m.pos)
            if d>1100 then d=math.huge end
            if d<distance then anchor,distance=m,d end
        end
    end
    if not anchor or anchor.team~=300 then return anchor end
    for _,camp in pairs(self.known) do
        local contains=false
        for _,m in ipairs(camp.members or {}) do if U.same(m,anchor) then contains=true;break end end
        if contains then
            self.localCamp=camp
            local best,score=nil,math.huge
            for _,m in ipairs(camp.members) do
                if U.valid(m) and U.dist(myHero.pos,m.pos)<=1100 then
                    local value=self:priority(m);if value<score then best,score=m,value end
                end
            end
            return self:selectTarget(camp) or best
        end
    end
    return anchor
end
function F:recovery()
    if self.ctx:recalling() or self.state=='recalling' then self.localException=nil end
    local c=self.ctx;local spawn=self:spawn();local now=c:now()
    if not spawn then c.status='Spawn position needs observation';return false end
    if U.dist(myHero.pos,spawn)<550 then
        if self.state~='base' then self.camp=nil;self.localException=nil;self.returningHome=true end
        if self.recallAction then self.actions:recallStatus(self.recallAction,true) end
        if self.state=='recalling' then if c.config.capture then c:log('farm_recall_arrived',{pos=U.copy(myHero.pos),spawn=U.copy(spawn)}) end end
        self.recallEndedAt=nil;self.recallObserved=false;self.recallAction=nil;self.recallLegacy=nil
        self.state='base';c.attackTarget=nil;c.moveTarget=nil
        if U.hp(myHero)<95 then c.status='Healing at base';return true end
        self.state='routing';self.recallAt=nil;self.recoveryWanted=nil;self.retreatCamp=nil;self.retreatMove=nil;self.recallReconcile=nil;self.recallSentTick=nil;return false
    end
    if c.input.farmPaused or not c.config:get('autoJungle') then return false end
    -- Full missile enumeration is needed before recovery, not on every healthy
    -- clear tick. The old path discarded that result in this exact case anyway.
    if self.lastRecoveryHP and myHero.health<self.lastRecoveryHP-.1 then self.lastHurtAt=now end
    self.lastRecoveryHP=myHero.health
    local low=U.hp(myHero)<c.config:get('recallHP')
    local wanted=self.recoveryWanted or low
    local awaiting=self.recallAction or self.recallLegacy or self.recallObserved or self.recallReconcile or c:recalling()
    local pressure=self:championPressure();local turret=c:underTurret(myHero.pos)
    if self.threatRetreat and not wanted and not awaiting then
        local safety=self:combatSafety(true)
        if pressure.count==0 and not turret and safety.monsters==0 and safety.missiles==0 and not safety.recentDamage and not safety.unknown then
            self.threatRetreat=nil;self.retreatCamp=nil;self.retreatMove=nil
            self:recoveryTransition('routing','threat_cleared_without_recall');return false
        end
        return self:retreat()
    end
    -- Do not begin another full camp on the reserve used to finish the last one.
    -- This only raises recovery intent before an engagement, never abandons one.
    if not wanted and not awaiting and self.camp and (not self.camp.lastFoughtAt or now-self.camp.lastFoughtAt>5)
        and U.hp(myHero)<math.min(50,c.config:get('recallHP')*2)
        and U.dist(myHero.pos,self:walkDestination(self.camp))<1100 then
        local forecast=self:finishForecast()
        if not forecast.safe then wanted=true end
    end
    if not wanted and not awaiting and pressure.count==0 and not turret then return false end
    if not wanted and not awaiting then
        self.threatRetreat=true;self.recoveryTrigger=turret and 'enemy_turret' or pressure.reason
        self:beginRetreat('immediate_threat',false);return self:retreat()
    end
    self.threatRetreat=nil
    self.recoveryTrigger=self.recoveryTrigger or (low and 'low_health' or 'insufficient_camp_reserve')
    local safe=self:recallSafe(true)
    local recallRecord=self.recallAction and self.actions:recallStatus(self.recallAction)
    if c:recalling() then
        self.recoveryWanted=true;self.localException=nil;self.recallObserved=true
        self:recoveryTransition('recalling','recall_observed');c.attackTarget=nil;c.moveTarget=nil;return true
    end
    if self.recallObserved then
        self.recallEndedAt=self.recallEndedAt or now
        if safe and now-self.recallEndedAt<.75 then c.status='Checking recall arrival';return true end
        self.recallObserved=false;self.recallAction=nil;self.recallLegacy=nil;self.recallReconcile=U.copy(myHero.pos)
        self:beginRetreat('recall_interrupted_by_game_state');return self:retreat()
    end
    if self.recallAction or self.recallLegacy then
        local r=recallRecord
        if r and r.state=='cancelled_before_send' then
            self.recallAction=nil;self:beginRetreat('recall_cancelled_before_send')
        elseif r and not r.sentAt then
            if not safe then
                self.actions:recallStatus(self.recallAction,true);self.recallAction=nil
                self:beginRetreat('threat_before_recall_send');return self:retreat()
            end
            self:recoveryTransition('recall_pending','awaiting_input');c.attackTarget=nil;c.moveTarget=nil
            c.status='Recall waiting for input';return true
        else
            local tick=self.actions.inputNow and self.actions:inputNow() or now*1000
            self.recallSentTick=r and r.sentAt or self.recallSentTick or tick
            local reserve=math.max(0,c.jitter or 0)*3
            if c.sdk.Input and c.sdk.Input.Timing and c.sdk.Input.Timing.reserve then reserve=math.max(reserve,c.sdk.Input.Timing:reserve()*.001) end
            local budget=math.min(3,1+reserve)*1000
            if tick-self.recallSentTick<budget and safe then
                self:recoveryTransition('recall_pending','awaiting_confirmation');c.attackTarget=nil;c.moveTarget=nil
                c.status='Recall awaiting confirmation';return true
            end
            self.recallAction=nil;self.recallLegacy=nil;self.recallSentTick=nil;self.recallReconcile=U.copy(myHero.pos)
            self:beginRetreat(safe and 'recall_confirmation_timeout' or 'threat_after_recall_send')
            return self:retreat()
        end
    end
    if self.recallReconcile then
        -- Positive movement away from the failed channel is a new game state;
        -- elapsed time or unchanged readiness alone does not replay B.
        if U.dist(myHero.pos,self.recallReconcile)<80 then return self:retreat() end
        self.recallReconcile=nil
    end
    if not wanted and safe then return false end
    if not wanted and self:combatSafety().champions==0 and not self:combatSafety().turret then return false end
    self.recoveryWanted=true
    -- Walking back into fountain range is faster than an eight-second recall
    -- from the platform edge. Only movement and health determine this boundary.
    if safe and U.dist(myHero.pos,spawn)<1200 then
        self:recoveryTransition('returning_base','near_fountain_walk')
        c.attackTarget=nil;c.moveTarget=U.copy(spawn);return true
    end
    if self.state~='retreating' and self.camp then
        local forecast=self:finishForecast()
        if c.config.capture then c:trace('finish_forecast',forecast,'finish_forecast',.5) end
        if forecast.safe then
            self:recoveryTransition('finishing','finish_active_camp',forecast)
            local target=self:selectTarget(self.camp)
            if target then self:clear(target);return true end
        end
    end
    if not safe then self:beginRetreat('unsafe_to_recall');return self:retreat() end
    if self.state~='recall_pending' then
        self.actions:cancel('farm');self.actions:cancel('escape')
        self.probe=nil;self.travelTarget=nil;self.travelJob=nil;self.opening=nil;self.localException=nil
        self.actions.routeStop=nil;self.actions.routeObservation=nil;self.actions.routeCommand=nil
        self:recoveryTransition('recall_pending','safe_recall_window')
    end
    c.attackTarget=nil;c.moveTarget=nil
    if c.actions:cursorBusy() or self.actions.api and self.actions.api:GetAvailability().cleanupPending then c.status='Recall waiting for input';return true end
    local accepted,why,submitted,id
    if self.actions.recall then accepted,why,submitted,id=self.actions:recall()
    else
        local input=c.sdk.Input
        if input and (input.Uncertain or not input:Available()) then c.status='Recall waiting for input';return true end
        local ok,result=pcall(Control.CastSpell,HK_RECALL or 66);accepted=ok and result~=false;submitted=accepted
    end
    local r=id and c.actions:inputAction(id)
    self.recallAction=(accepted or submitted or r and (r.state=='waiting' or r.state=='requested')) and id or nil
    if not accepted and not submitted then c.status='Recall waiting for input';return true end
    self.recallAt=now;self.recallSentTick=r and r.sentAt;self.recallObserved=false;self.recallEndedAt=nil
    if not self.actions.api then self.state='recalling';self.recallLegacy=true;self.recallSentTick=now*1000 end
    if c.config.capture then c:log('farm_recall_requested',{cursorID=id,submitted=submitted}) end
    c.status='Recall awaiting confirmation';return true
end
function F:ensureRouter()
 local c=self.ctx
 if not self.router then
  self.router=require('AyyyyIO.autojungle')(_G,c.core,{
   ownsControls=true,ownsAttacks=true,enabled=function()return c.config:get('autoJungle')end,
   available=function()return not c:blocked()and not c.input.farmPaused end,
   -- Skill allocation briefly owns input; the route waits instead of ending.
   hold=function()return c.leveling.pending~=nil and c.leveling.pending~=false end,
   safe=function(pos)return c:threats(pos,1000)==0 and not c:underTurret(pos)end,
   destination=function(camp)return self:walkDestination(camp)end,
   rows=function()return self.known end,
   sideAllowed=function(camp)return self:sideAllowed(camp)end,
   routeDistance=function(camp,destination)return self:routeDistance(camp,destination)end,
   -- Level-1 opening orders of this profile, followed from the camp the player starts at.
   opening=function()
    local level=myHero.levelData and myHero.levelData.lvl or 1
    if level==1 and P.openings then return P.openings[c.profile.id]end
   end,
   target=function(camp)return self:selectTarget(camp)end,
   engaged=function(camp)
    for _,m in ipairs(camp.members or{})do if self:ordinaryTarget(m)and U.dist(myHero.pos,m.pos)<900
     and(camp.lastFoughtAt and c:now()-camp.lastFoughtAt<3 or m.attackData and(m.attackData.target==myHero.handle or m.attackData.target==myHero.networkID))then return true end end
    return false
   end,
   selected=function(camp)self.camp=camp;self.probe=nil;self.travelTarget=nil;self.travelJob=nil end,
   movement=function(camp,target)self.camp=camp;self.state='routing';return target and self:travel(camp,target)or not target and self:probeCamp(camp)end,
   clear=function(camp,target)self.camp=camp;self.state='clearing';c.status='Clearing '..camp.category;self:clear(target);return true end,
   move=function(pos)c.moveTarget=pos;return true end,
   recovery=function()return self:recovery()end,
   cancel=function(reason)c.actions:cancel('farm');self.probe=nil;self.travelTarget=nil;self.travelJob=nil end})
  -- The shared camera hold (held center-camera key while routing), from Lee's own settings.
  self.router.cameraSetting={Value=function()return c.config:get('farmFollowCamera')==true end}
  self.router.cameraBind={Key=function()return c.config:key('farmCameraHoldKey')end}
 end
 return self.router
end
function F:tick()
 local c=self.ctx;self:ensureRouter()
 self:updateCamps()
 -- The local enemy-camp exception lasts until that camp is cleared.
 local exception=self.localException and self.known[self.localException]
 if self.localException and(not exception or exception.awaitingRespawn or exception.availability=='observed_empty'and not self:living(exception))then
  self.localException=nil
 end
 self.router.camp=self.camp
 self.router.paused=c.input.farmPaused==true
 self.router:Tick()
 -- Recovery owns Lee's camp, state and status for this tick; copying the
 -- router's view back would restart the retreat and cancel its actions.
 if self.router.recoveryOwned then return end
 self.camp=self.router.camp;self.state=self.router.state
 if self.state~='clearing'then c.status=self.router.reason or(self.camp and 'Routing: '..self.camp.category or 'No safe camp available')end
end
-- Formation estimates are separate from availability. A camp icon is never
-- used as a monster position, and known deaths veto every estimated shot.
function F:rememberLayout(camp)
 local service=self.ctx.sdk.OrbamaUtils and self.ctx.sdk.OrbamaUtils.Camps
 if service then service:RememberLayout(camp)end
end
function F:entryAvailable(camp)
    if camp.nativeUp==false then
        -- A living monster on screen is direct evidence; the marker is not
        -- (Classic live 2026-10-07: every marker read "down", so Q was never
        -- used to reach a camp that stood in plain sight).
        local seen=false
        for _,m in ipairs(camp.members or {}) do if U.valid(m) and m.team==300 then seen=true;break end end
        if not seen then return false end
    end
    if not camp.awaitingRespawn then return true end
    -- A timer can authorize an explicitly estimated probe, never an alive
    -- observation. Stale native true alone cannot erase our recorded kill.
    -- Where "down" markers proved meaningless this game, the absent marker is
    -- no veto either: the elapsed timer alone carries the estimate.
    return self.ctx.config:get('farmQRespawn') and (camp.nativeUp==true or self.nativeDownUnreliable and camp.nativeUp==nil) and camp.expectedAt
        and self.ctx:now()>=camp.expectedAt+.25 and not (camp.probeMissedAt and camp.probeMissedAt>=(camp.killedAt or 0))
end
function F:entryDiagnostic(camp,reason)
    local c=self.ctx;local distance=U.dist(myHero.pos,self:walkDestination(camp))
    self.entryDecision={camp=camp.id,reason=reason,distance=distance,at=c:now()}
    if distance>c.profile.qRange+150 or c:now()<(self.entryLogAt or 0) then return end
    self.entryLogAt=c:now()+1
    if c.config.capture then c:log('camp_entry_decision',{camp=camp.id,reason=reason,distance=distance,rank=c:spell(0).level,
        cd=c:spell(0).currentCd,energy=myHero.mana,nativeUp=camp.nativeUp,waiting=camp.awaitingRespawn,
        expectedAt=camp.expectedAt,source=self.entryCandidateCamp==camp.id and self.entrySource or nil,
        targets=self.entryCandidateCamp==camp.id and self.entryCandidates or nil}) end
end
function F:fogLayout(camp)
    local c=self.ctx
    -- A down marker proven unreliable becomes unknown, not a permanent veto
    -- against the profile's explicitly enabled spawn estimate. Known death,
    -- timer policy and recent combat still exclude the probe.
    if not (camp.nativeUp==true or self.nativeDownUnreliable and camp.nativeUp==nil) or not self:entryAvailable(camp) or camp.availability=='observed_empty' and not camp.awaitingRespawn
        or camp.lastFoughtAt and c:now()-camp.lastFoughtAt<20 then return end
    local layout=camp.layout
    if layout and (layout.mode~=c.profile.id or layout.mapID~=Game.mapID) then return end
    if layout and layout.mode==c.profile.id and layout.mapID==Game.mapID and c:now()-layout.at<=30 then
        for _,row in ipairs(layout.rows) do
            local m=row.unit
            if not m or m.dead or m.valid==false or (m.health or 0)<row.health
                or m.pathing and m.pathing.hasMovePath or U.dist(m.pos,row.pos)>15 then return end
        end
        return layout.rows,'recent stationary observation'
    end
    layout=camp.spawnLayout
    if layout and(layout.mode~=c.profile.id or layout.mapID~=Game.mapID)then return end
    if layout then return layout.rows,'learned spawn estimate' end
    local service=c.sdk.OrbamaUtils and c.sdk.OrbamaUtils.Camps
    local rows=service and service:Formation(camp)
    if rows then return rows,'recorded spawn estimate'end
end
-- The target-independent part of the Q1 upper bound (rank, raw damage, Classic
-- item multiplier, verification factor), shared by every row of one evaluation
-- scope (one callback; input or reentry starts a new scope). Fresh otherwise.
function F:qEntryBase()
    local c=self.ctx;local scope=U.buffScopeKey();local now=c:now()
    local b=self.qEntryBaseCache
    if scope and b and b.scope==scope and b.now==now then return b end
    b={scope=scope,now=now,rank=c:spell(0).level or 0}
    if b.rank>0 then
        local bonus=myHero.bonusDamage or math.max(0,(myHero.totalDamage or 0)-(myHero.baseDamage or 0))
        b.raw=(c.profile.qBase[b.rank] or 0)+c.profile.qRatio*bonus
        -- Classic Butcher amplifies spell damage too. Source: pinned 16.17.1
        -- Pinned mode item data. Use the strongest unique passive, not their sum.
        if c.profile.id=='classic' then
            local amps=c.profile.qMonsterAmplifiers;local multiplier=1
            local shared=c.sdk.SharedData;local inventory=shared and shared:GetInventory()
            for slot=6,11 do
                local item=inventory and inventory.ageMs<=80 and inventory.slots[slot] or myHero:GetItemData(slot)
                multiplier=math.max(multiplier,item and amps[item.itemID] or 1)
            end
            b.multiplier=multiplier
        end
        if c.profile.q1DataMap and c.profile.q1DataMap==Game.mapID then b.factor=1.1
        elseif not c.profile.damageVerified and not c.config:get('mechanicsVerified') then b.factor=2 end
    end
    self.qEntryBaseCache=scope and b or nil
    return b
end
function F:qEntryUpper(m)
    local c=self.ctx;local base=self:qEntryBase()
    if base.rank<=0 then return false end
    local raw=base.raw
    -- Upper-side estimate: never use a disabled/unverified damage overlay's
    -- zero as proof that a small monster will survive. Ignore monster caps.
    local damage=raw
    if m then
        local ok;ok,damage=pcall(c.sdk.Damage.CalculateDamage,c.sdk.Damage,myHero,m,c.sdk.DAMAGE_TYPE_PHYSICAL,raw)
        if not ok or type(damage)~='number' or damage~=damage or math.abs(damage)==math.huge then return end
    end
    local upper=math.max(raw,damage)
    if base.multiplier then upper=upper*base.multiplier end
    if base.factor then upper=upper*base.factor end
    return upper+25
end
function F:qSurvives(m,delay,health)
    local c=self.ctx;local upper=self:qEntryUpper(m)
    if not upper then return false end
    local hp=health or math.min(m.health,c:healthAt(m,delay))
    return hp>upper
end
function F:entryShot(camp,origin,fog)
    local c=self.ctx;origin=origin or myHero.pos
    self.entryCandidates=c.config.capture and {};self.entrySource=nil;self.entryCandidateCamp=camp.id
    if P.epics[camp.category] or not self:entryAvailable(camp) then return end
    local rows,source={}
    if fog then
        rows,source=self:fogLayout(camp);self.entrySource=source
        if not rows then self.entryShotReason='No eligible formation for this camp / spawn state';return end
    else
        for _,m in ipairs(camp.members or {}) do if self:ordinaryTarget(m) then
            rows[#rows+1]={unit=m,pos=m.pos,radius=m.boundingRadius or 45,maxHealth=m.maxHealth}
        end end
    end
    local best,bestScore,bestHealth
    local capture=c.config.capture
    -- Clear of other formation rows (cheap) and of native blockers (a collision
    -- query, the costly part).
    local function clearShot(row)
        for _,other in ipairs(rows) do if other~=row then
            local distance,t=U.segment(other.pos,origin,row.pos)
            local uncertainty=fog and 25 or 0
            if t>0 and t<1 and distance<c.profile.qRadius+other.radius+uncertainty then return false end
        end end
        return #c.spells:blockers(row.unit,row.pos,origin)==0
    end
    local survivors={}
    for index,row in ipairs(rows) do
        local m=row.unit;local aim=row.pos;local distance=U.dist(origin,aim)
        local inRange=distance<=c.profile.qRange
        local delay=.25+distance/c.profile.qSpeed+c.latency
        -- A distant candidate cannot be selected. Avoid damage, inventory,
        -- health prediction and collision host calls until it enters Q range.
        local upper=inRange and self:qEntryUpper(m) or nil
        local hp=inRange and (fog and row.health or m and math.min(m.health,c:healthAt(m,delay))) or nil
        local survives=upper and hp and hp>upper
        local report=capture and {name=row.name or m and m.charName,health=hp,upper=upper,distance=distance}
        if report then
            self.entryCandidates[#self.entryCandidates+1]=report
            report.reason=not inRange and 'Out of Q range' or not survives and 'Q1 survival reserve' or 'Collision'
        end
        if survives then
            local score=U.dist(origin,aim);local health=row.maxHealth or row.health or m.health
            if score<=c.profile.qRange then survivors[#survivors+1]={row=row,score=score,health=health,index=index,report=report}end
        end
    end
    if capture then
        -- Capture reports every survivor's collision result.
        for _,s in ipairs(survivors) do
            if clearShot(s.row) then
                s.report.reason='Eligible'
                if not bestHealth or s.health>bestHealth or s.health==bestHealth and s.score<bestScore then best,bestScore,bestHealth=s.row,s.score,s.health end
            end
        end
    else
        -- Preference order (highest health, then nearest, then list order) and the
        -- first clear shot: the same choice as testing every survivor.
        table.sort(survivors,function(a,b)
            if a.health~=b.health then return a.health>b.health end
            if a.score~=b.score then return a.score<b.score end
            return a.index<b.index
        end)
        for _,s in ipairs(survivors) do if clearShot(s.row) then best=s.row;break end end
    end
    if best then best.source=source or 'visible monster' end
    self.entryShotReason=best and 'Clear surviving target found' or 'No clear surviving target in Q range'
    return best
end
function F:walkDestination(camp)
    -- Camp icon/manager coordinates may sit beside the monsters or have no
    -- ground height. Prefer a live member's actual world position for walking.
    local main
    for _,m in ipairs(camp.members or {}) do
        if self:ordinaryTarget(m) and (not main or (m.maxHealth or m.health)>(main.maxHealth or main.health)) then main=m end
    end
    return main and main.pos or camp.walkPos or camp.pos
end
function F:travel(camp,target)
    local c=self.ctx;local now=c:now()
    if camp.nativeUp==false and not U.valid(target) or camp.awaitingRespawn or (c:spell(0).level or 0)==0 or P.epics[camp.category] or not c.config:get('farmQTravel') or not c.config:get('autoClearAbilities') or not c.config:get('autoClearQ')
        or not c.config:get('autoClearQ2') or c:dash() or c:threats(camp.pos,1000)>0 or c:underTurret(camp.pos) then
        self.travelTarget=nil;self.travelJob=nil;return false
    end
    if U.dist(myHero.pos,target.pos)<=c:attackRange(target)+40 then
        self.travelTarget=nil;self.travelJob=nil;return false
    end
    if self.travelTarget then
        local found=false
        for _,m in ipairs(camp.members or {}) do
            if U.valid(m) and c:mark(m) then
                found=true
                if c.spells:q2(m,'farm',false,true,true) then self.travelTarget=nil;self.travelJob=nil;if c.config.capture then c:log('camp_q2_entry') end;return true end
            end
        end
        if now>(self.travelUntil or 0) or not U.valid(self.travelTarget) then self.travelTarget=nil
        elseif found or c:stage(0)==1 then c.moveTarget=self:walkDestination(camp);return true
        else self.travelTarget=nil end
    end
    if not c:ready(0) or c:stage(0)~=1 then return false end
    -- If the selected visible monster is already quicker to reach on a clear
    -- walking line, skip expensive formation damage/collision enumeration.
    -- Pending Q follow-ups above still run; a wall preserves the entry search.
    if U.dist(myHero.pos,target.pos)<=650 and not self:entryFaster(target.pos,nil,camp)
        and self:kiteLine(myHero.pos,target.pos) then return false end
    -- Seeing an outer small monster must not disable the earlier, durable
    -- main-monster shot from the same camp's recorded formation.
    if c.config:get('farmQBlind') then
        local fogShot=self:entryShot(camp,myHero.pos,true)
        if fogShot and not U.valid(fogShot.unit) and self:probeCamp(camp) then return true end
    end
    local shot=self:entryShot(camp)
    if shot and self:entryFaster(shot.pos,nil,camp) and U.dist(myHero.pos,shot.pos)<=c.profile.qRange and c.spells:q1(shot.unit,'farm',false,function()
        return self:entryAvailable(camp) and self:qSurvives(shot.unit,
            .25+U.dist(myHero.pos,shot.unit.pos)/c.profile.qSpeed+c.latency),'entry_target_may_die'
    end) then
        self.travelTarget=shot.unit;self.travelUntil=now+2;c.moveTarget=self:walkDestination(camp)
        if c.config.capture then c:log('camp_q1_entry',{target=U.id(shot.unit),name=shot.unit.charName,
            health=shot.unit.health,upper=self:qEntryUpper(shot.unit),camp=camp.id,source=shot.source}) end
        return true
    end
    self:entryDiagnostic(camp,shot and (self.entryTiming and self.entryTiming.reason or 'Q dispatch declined')
        or self.entryShotReason or 'No eligible Q entry')
    -- Reposition around small blockers for a durable target, instead of firing
    -- a travel Q that would kill its first collision and remove the recast.
    local durable
    for _,m in ipairs(camp.members or {}) do
        if U.valid(m) and self:qSurvives(m,1) and (not durable or m.maxHealth>durable.maxHealth) then durable=m end
    end
    return durable and self:entryPath(camp,durable) or false
end
function F:entryWalkingPath(destination)
    local path=myHero.pathing
    if not path or not path.hasMovePath or path.isDashing or not U.position(path.endPos)
        or U.dist(path.endPos,destination)>100 or type(myHero.GetPath)~='function' then return end
    local first,last=path.pathIndex,path.pathCount
    if not U.finite(first) or not U.finite(last) or first%1~=0 or last%1~=0
        or first<0 or last<first or last-first>=32 then return end
    local previous=myHero.pos;local length=0
    for index=first,last do
        local ok,point=pcall(myHero.GetPath,myHero,index)
        if not ok or not U.position(point) then return end
        length=length+U.dist(previous,point);previous=point
    end
    if U.dist(previous,path.endPos)>25 then return end
    return length+U.dist(previous,destination)
end
function F:entryFaster(destination,origin,camp)
    local c=self.ctx;origin=origin or myHero.pos
    local distance=U.dist(origin,destination)
    local walkDistance=U.dist(myHero.pos,destination)
    local source='straight distance'
    local native=self:entryWalkingPath(destination)
    if native then walkDistance=native;source='native walking path' end
    -- Q crosses camp walls; walking takes a detour. Share the bounded route
    -- solver. A pending route is not evidence that walking is faster.
    if not native and c.terrain:trusted() and not self:kiteLine(myHero.pos,destination) then
        walkDistance,source=self:routeDistance(camp or {id='entry',pos=destination},destination)
        if source~='verified terrain route' then
            self.entryTiming={reason='Walking route estimate pending',source=source}
            return false
        end
    end
    local walk=math.max(0,walkDistance-250)/math.max(1,myHero.ms or 350)
    local jump=U.dist(myHero.pos,origin)/math.max(1,myHero.ms or 350)+.25+distance/c.profile.qSpeed+distance/1800+c.latency
    self.entryTiming={walkDistance=walkDistance,walkSeconds=walk,jumpSeconds=jump,source=source,
        reason=jump+.08<walk and 'Q route is faster' or 'Walking is faster from current position'}
    return jump+.08<walk
end
function F:entryPath(camp,target)
    local c=self.ctx;local now=c:now()
    -- Opportunistic micro-adjustments only. The normal route remains one
    -- native click to the camp, never a separate stop at the Q range boundary.
    if self.returningHome or not c.config:get('farmQAdjust') or not c.terrain:trusted() or not c:ready(0) or c:stage(0)~=1 then
        self.travelJob=nil;return false
    end
    if U.dist(myHero.pos,camp.pos)>c.profile.qRange+90 then return false end
    local job=self.travelJob
    if job then
        if job.camp==camp.id and now<job.deadline and U.dist(myHero.pos,job.pos)>25 then
            c.moveTarget=job.pos;return true
        end
        self.travelJob=nil;self.microRetryAt=now+.5
        -- Never stop at an old aim point when the shot has become invalid.
        c.moveTarget=self:walkDestination(camp);return false
    end
    if now<(self.microRetryAt or 0) then return false end
    local toward=U.toward(myHero.pos,camp.pos,1)
    local dx,dz=toward.x-myHero.pos.x,toward.z-myHero.pos.z
    for _,offset in ipairs({45,-45,90,-90}) do
        local point={x=myHero.pos.x-dz*offset,y=myHero.pos.y,z=myHero.pos.z+dx*offset}
        if c.terrain:walkLine(myHero.pos,point,math.min(45,myHero.boundingRadius or 35)) then
            local shot=self:entryShot(camp,point,target==nil)
            if shot and U.dist(point,shot.pos)<=c.profile.qRange and self:entryFaster(shot.pos,point,camp) then
                self.travelJob={camp=camp.id,pos=point,deadline=now+.6};c.moveTarget=point
                c.status='Small Q aim adjustment: '..camp.category;return true
            end
        end
    end
    return false
end
function F:probeCamp(camp)
    local c=self.ctx;local now=c:now()
    if not self:entryAvailable(camp) or (c:spell(0).level or 0)==0 or not c.config:get('farmQTravel') or not c.config:get('farmQBlind') or not c.config:get('autoClearAbilities')
        or not c.config:get('autoClearQ') or not c.config:get('autoClearQ2') or c:dash()
        or P.epics[camp.category] or c:threats(camp.pos,1000)>0 or c:underTurret(camp.pos) then
        self:entryDiagnostic(camp,not self:entryAvailable(camp) and 'Spawn not eligible for a probe'
            or (c:spell(0).level or 0)==0 and 'Q not learned' or 'Entry disabled or unsafe')
        self.probe=nil;return false
    end
    local probe=self.probe
    if probe and probe.camp~=camp.id then self.probe=nil;probe=nil end
    if probe and c.actions.syncWindow then
        local state=c.actions:syncWindow(probe)
        if state=='waiting' or state=='uncertain' then c.status='Waiting for Q input';return true end
        if state=='cancelled' then self.probe=nil;self.travelJob=nil;return false end
    end
    if probe then
        -- Fresh object enumeration avoids the camp grouping's 400 ms cache
        -- delaying a confirmed Q2. Never dash to a champion hit by the probe.
        if Game.MinionCount and Game.Minion then for i=1,U.count(Game.MinionCount(),4096) do
            local m=Game.Minion(i)
            if m and m.team==300 and U.dist(m.pos,camp.pos)<700 and U.valid(m) and c:mark(m) then
                -- Shared camp knowledge is informed opportunistically; a full
                -- observation buffer never blocks the confirmed recast.
                local service=c.sdk.OrbamaUtils and c.sdk.OrbamaUtils.Camps
                if service and service:ObserveObject(m) then service:Refresh() end
                if c.spells:q2(m,'farm',false,true,true) then self.probe=nil;self.travelJob=nil;if c.config.capture then c:log('camp_probe_confirmed',{name=camp.category}) end;return true end
            end
        end end
        if now<=probe.deadline then c.moveTarget=self:walkDestination(camp);c.status='Walking / waiting for camp Q mark: '..camp.category;return true end
        self.probe=nil;self.travelJob=nil
        local visible=false;for _,m in ipairs(camp.members or {}) do if U.valid(m) then visible=true end end
        if not visible then
            if self.router then self.router.blocked[camp.id]=now+20;self.router.camp=nil end;camp.probeMissedAt=now;self.camp=nil;self.progressAt=nil
            c.status='Camp probe missed; selecting next camp';if c.config.capture then c:log('camp_probe_missed',{name=camp.category}) end;return true
        end
        if c.config.capture then c:log('camp_probe_missed_visible',{name=camp.category}) end;return false
    end
    if not c:ready(0) or c:stage(0)~=1 or camp.availability=='observed_empty' and not camp.awaitingRespawn then
        self:entryDiagnostic(camp,'Q unavailable / stage / empty camp');return false
    end
    local shot=self:entryShot(camp,myHero.pos,true)
    if not shot then self:entryDiagnostic(camp,self.entryShotReason or 'No eligible shot');return self:entryPath(camp) end
    local aim=U.copy(shot.pos)
    local route=self.camp
    local faster=self:entryFaster(aim,nil,camp)
    if faster and c.spells:q1Camp(aim,function()
        -- Camp observations, routing and menu changes can invalidate a fog
        -- probe while the input owner is busy. Do not shoot the old intent.
        if self.camp~=route or not self:fogLayout(camp)
            or not c.config:get('farmQTravel')
            or not c.config:get('farmQBlind') or not c.config:get('autoClearQ2')
            or c:threats(camp.pos,1000)>0 or c:underTurret(camp.pos) then return false,'camp_entry_changed' end
        return true
    end) then
        self.probe={camp=camp.id,aim=aim,event=c.actions.spellObservations[0],deadline=now+.25+U.dist(myHero.pos,aim)/c.profile.qSpeed+math.max(.4,c.latency*2+c.jitter*3+.2)}
        c.status='Q approach: '..camp.category..' ['..shot.source..(camp.awaitingRespawn and '; respawn estimated' or '')..']'
        self:entryDiagnostic(camp,'Q probe requested')
        if c.config.capture then c:log('camp_probe_requested',{name=camp.category,origin=U.copy(myHero.pos),destination=aim,
            source=shot.source,respawnEstimate=camp.awaitingRespawn or false,
            targetName=shot.name or shot.unit and shot.unit.charName,distance=U.dist(myHero.pos,aim)}) end;return true
    end
    self:entryDiagnostic(camp,not faster and (self.entryTiming and self.entryTiming.reason or 'Walking route unavailable') or 'Q dispatch / visible collision blocked')
    return self:entryPath(camp)
end
function F:fastTick()
    local c=self.ctx;local camp=self.camp
    if self.recallAction or self.state=='recalling' or not camp or not self:entryAvailable(camp) or P.epics[camp.category] or not (self.probe or self.travelTarget) or c.input.farmPaused or not c.config:get('autoJungle')
        or not c.config:get('farmQTravel') or not c.config:get('autoClearAbilities') or not c.config:get('autoClearQ2')
        or self.probe and not c.config:get('farmQBlind') or c:threats(camp.pos,1000)>0
        or c:blocked() or c:recalling() or c:dash() then return false end
    self.actions:tick()
    if Game.MinionCount and Game.Minion then for index=1,U.count(Game.MinionCount(),4096) do
        local m=Game.Minion(index)
        if m and m.team==300 and U.dist(m.pos,camp.pos)<700 and U.valid(m) and c:mark(m) then
            local service=c.sdk.OrbamaUtils and c.sdk.OrbamaUtils.Camps
            if service then service:ObserveObject(m);service:Refresh()end
            if c.spells:q2(m,'farm',false,true,true) then
                self.probe=nil;self.travelTarget=nil;self.travelJob=nil
                if c.config.capture then c:log('camp_q2_entry',{target=U.id(m),immediate=true}) end;return true
            end
        end
    end end
    return false
end
require('leesin.recovery')(F)
return F

end
