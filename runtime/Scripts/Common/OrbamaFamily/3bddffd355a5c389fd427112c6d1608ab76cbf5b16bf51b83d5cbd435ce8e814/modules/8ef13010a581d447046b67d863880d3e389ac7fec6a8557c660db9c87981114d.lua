return function(require)
-- Shared routing. Adapters expose kit mechanics, not another camp history.
-- Adapter hooks (all optional): enabled, available, hold, safe, destination,
-- rows, sideAllowed, routeDistance, target, engaged, selected, movement, clear
-- (returns true when it chose this tick's movement), move, attack, recovery,
-- cancel, preferred, walkable(a,b); kite=false. ownsAttacks: the adapter's clear attacks and moves for itself.
-- Route policies in J:Choose: a living damaged camp within DAMAGED_REACH is
-- finished first; an untouched early jungle starts at the nearer own buff and
-- follows its profile's full clear, skipping killed or unsafe camps; a preferred
-- camp (adapter.preferred, default Red/Blue) wins a
-- cost tie within BUFF_TIE world units of travel.
-- Shared defaults every core champion gets (generalized from Lee Sin, player request
-- 2026-10-11); an adapter hook replaces each one (Lee keeps his own):
--  * long walks click the minimap (J:Move, beyond MINIMAP_REACH);
--  * prefer home: with invading on, an available own-side camp still wins over
--    every enemy camp (J:HomeAvailable; replaced by adapter.sideAllowed);
--  * kiting: one step away from a melee monster after the router's own observed
--    attack windup, inside KITE_LEASH of the camp, back in range for the next attack
--    (J:Kite; adapter.kite=false or ownsAttacks turns it off);
--  * recovery below the recall setting: finish an engaged camp only when the
--    forecast survives it, otherwise retreat; recall only when safe and not under
--    attack, never replay an unobserved recall in place (J:Recovery; adapter.recovery).
local DEFAULT_KEY=74 -- J: each champion's own auto-jungle toggle (player requests 2026-10-10/11); champion binds avoid J.
local HOLD_MS=10000 -- the provider's longest owned key hold.
local SPAWN_GRACE=3 -- seconds a due camp may take to show its new monsters.
local CAMERA_KEY=32 -- Space: the game's default "center camera on champion" hold key.
local ROUTE_REFINE=3 -- Terrain route costs refine only the cheapest straight candidates.
local DAMAGED_REACH,BUFF_TIE,OPENING_START_UNTIL=500,250,120
-- Full-clear policy is independent of team; each side supplies its own positions.
local OPENING_ROUTES={
 normal={Blue={'Blue','Gromp','Wolves','Raptors','Red','Krugs'},Red={'Red','Krugs','Raptors','Wolves','Blue','Gromp'}},
 classic={Blue={'Blue','Wight','Wolves','Wraiths','Red','Golems'},Red={'Red','Golems','Wraiths','Wolves','Blue','Wight'}}
}
local MINIMAP_REACH=600 -- Lee's minimap travel distance: shorter walks click the ground.
-- Kiting (Lee's defaults farmKiteDistance/farmKiteLeash): longest step, camp leash
-- radius, shortest useful step, melee monster range.
local KITE_STEP,KITE_LEASH,KITE_MIN,KITE_MELEE=260,350,60,250
local RECALL_HP=25 -- default recall threshold, % health (Lee's recallHP default).
local RECALL_CONFIRM=1.5 -- seconds a sent recall may take to show its channel.
local RECONCILE_MOVE=80 -- an unobserved recall is retried only after moving this far.
return function(g,core,adapter)
 local H,G,SDK=g.myHero,g.Game,g.SDK;local client=core and core.client
 local J={enabled=false,state='idle',adapter=adapter,blocked={},generation=0,jobs={},keyHeld=false}
 local function finite(n)return type(n)=='number'and n==n and math.abs(n)<math.huge end
 local function copy(p)return p and{x=p.x,y=p.y or 0,z=p.z}end
 local function dist(a,b)if not a or not b then return math.huge end;local x,z=a.x-b.x,a.z-b.z;return math.sqrt(x*x+z*z)end
 local function valid(u)return u and u.team==300 and u.valid~=false and u.visible~=false and not u.dead and finite(u.health)and u.health>0 and u.isTargetable~=false end
 local epics={Dragon=true,Elder=true,Baron=true,Herald=true,Grubs=true,Atakhan=true}
 local function cheaper(a,b)if a.value~=b.value then return a.value<b.value end;return tostring(a.camp.id)<tostring(b.camp.id)end
 function J:Enabled()return adapter.enabled and adapter.enabled()or not adapter.enabled and self.enabled end
 function J:Active()
  if not client or self.closed or not self:Enabled()or self.paused or not core:Current()or H.dead or G.IsChatOpen()or not G.IsOnTop()then return false end
  if adapter.available and not adapter.available()then return false end
  local utility=SDK.OrbamaUtils
   if utility and (utility.active and not utility:active()or utility.Camps and utility.Camps.closed)then return false end
  local evade=SDK.Evade;if evade and evade.Evading and evade:Evading()then return false end
  for _,held in pairs(SDK.Orbwalker.Modes or{})do if held then return false end end
  return true
 end
 function J:Context(condition)
  local generation=self.generation
  return {priority='background',autoJungle=true,condition=function()return self:Active()and self.generation==generation and(not condition or condition())end}
 end
 function J:Cancel(reason)
  if client then client:CancelOwner('auto-jungle',reason or 'route_ended')end
  if adapter.cancel then adapter.cancel(reason)end
  self.command=nil;self.target=nil;self.camp=nil;self.emptyAt=nil;self.progressAt=nil;self.waitingSpawn=nil
 end
 function J:Pause(reason)
  self.paused=true;self.state='paused';self.reason=reason;self:Cancel(reason);self:ReleaseCamera()
 end
 function J:Start()
  self.paused=false;self.generation=self.generation+1;self:Cancel('route_restarted');self.state='routing';self.reason=nil
  self.opening=nil;self.openingPending=true
  self.cameraYielded=nil
  -- A new route never inherits a previous route's recovery, retreat or kite step.
  self.recovering=nil;self.retreatCamp=nil;self.recallReconcile=nil;self.recallObserved=nil
  self.recallID=nil;self.recallRequested=nil;self.kiteStep=nil;self.forecast=nil
 end
 function J:Close(reason)
  if self.closed then return end;self:Cancel(reason or 'controller_closed');self:ReleaseCamera();self.closed=true
  if self.scope then self.scope:Close()end
 end
 -- Camera while routing (player request 2026-10-11): hold the game's "center camera on
 -- champion" key while auto-jungle runs and release it the moment the route ends. No lock
 -- state has to be inferred. The input layer releases an owned key after at most 0.5 s, so
 -- the hold is renewed as soon as the previous one is released; it is refused while the
 -- player physically holds the key. A physical press hands the camera to the player until
 -- the route restarts.
 function J:CameraKey()local b=self.cameraBind;local k=b and b:Key();return type(k)=='number'and k>0 and k or nil end
 function J:ObserveCameraHold()end
 function J:ForgetCameraHold()end
 function J:Camera()
  local setting=self.cameraSetting;local key=self:CameraKey()
  if not client or not key or not setting or setting:Value()~=true or self.cameraYielded then return self:ReleaseCamera()end
  -- One owned hold of up to HOLD_MS (the provider's charge hold: the key stays down until
  -- cancelled or the deadline), renewed only when it has ended. Short key_down holds were
  -- capped at 0.5 s, so the camera visibly let go between them, and every renewal counted
  -- as competing input that made pending attacks ambiguous (live 2026-10-11).
  local now=client:Now();if now<(self.cameraNextAt or 0)then return end
  local id=self.cameraHold
  if id then
   local r=client:Poll(id)
   if r and(r.state=='waiting'or r.state=='requested'or r.sentAt and not r.releasedAt and not r.abortedAt and r.state~='cancelled')then
    if r.sentAt then self:ObserveCameraHold(id,r,key)end
    return
   end
   if r then client:Finish(id,true)end;self.cameraHold=nil
   if not(r and r.sentAt)then self.cameraNextAt=now+250;return end
  end
  if not client.BeginCharge then return end
  self.cameraHold=client:BeginCharge(key,{owner='auto-jungle-camera',resource='camera:center',priority='background',maxChargeMs=HOLD_MS,
   context={condition=function()return not self.closed and self:Active()and setting:Value()==true and not self.cameraYielded end},
   mechanical=function()return true end})
  self.cameraNextAt=now+100
 end
 -- Lets go of the key at once when the route ends (toggle off, pause, close, context ended):
 -- cancelling a charge hold releases its key.
 function J:ReleaseCamera()
  self:ForgetCameraHold()
  local id=self.cameraHold;if not id or not client then return end;self.cameraHold=nil;self.cameraNextAt=nil
  client:Cancel(id,'camera_hold_ended');client:Finish(id,true)
 end
 local STATE_TEXT={routing='routing to',clearing='clearing',waiting='waiting at',recovering='recovering',recalling='recalling',retreating='retreating',finishing='finishing',paused='paused',unavailable='unavailable',idle='idle'}
 function J:StateText()
  local text=STATE_TEXT[self.state]or tostring(self.state or '')
  local camp=self.camp and self.camp.category
  if camp and(self.state=='routing'or self.state=='clearing'or self.state=='waiting'or self.state=='finishing')then return text..' '..camp end
  if self.state=='waiting'then return 'waiting'end
  return text
 end
 function J:Event()end
 function J:Safe(camp)
  return not adapter.safe or adapter.safe(self:Destination(camp))==true
 end
 function J:Destination(camp)return adapter.destination and adapter.destination(camp)or camp.walkPos or camp.aimPos or camp.pos end
 local function due(camp)
  local at=camp.expectedAt or not camp.seenAlive and camp.timing and camp.timing.firstSpawn or nil
  if camp.emptyUntil and(not at or camp.emptyUntil>at)then at=camp.emptyUntil end
  return at
 end
 function J:Cost(camp,now,measured)
  -- The destination just computed is handed to routeDistance, which would
  -- otherwise derive the same point again from the camp's members.
  local destination=self:Destination(camp)
  local distance=dist(H.pos,destination);local speed=math.max(200,H.ms or 350);local travel=distance/speed
  if measured and adapter.routeDistance then local value=adapter.routeDistance(camp,destination);if finite(value)then travel=value/speed end end
  return travel+math.max(0,(due(camp)or now)-now-travel),distance
 end
 function J:Eligible(camp,now)
  if epics[camp.category]or camp.timing and camp.timing.removed or now<(self.blocked[camp.id]or 0)then return false end
  if camp.state=='empty_unknown'then return false end
  if camp.timing and camp.timing.oneTime and camp.awaitingRespawn then return false end
  if adapter.sideAllowed then if not adapter.sideAllowed(camp)then return false end
  elseif camp.team~=0 and camp.team~=H.team then
   if not(self.invadeSetting and self.invadeSetting:Value()==true)then return false end
   -- Invading never replaces available work on our own side (Lee's homeAvailable).
   if self:HomeAvailable(now)then return false end
  end
  return self:Safe(camp)
 end
 -- True when an own-side camp is up, due by the time we could reach it, or staging
 -- its first spawn, and could be routed to now. One answer per clock and row set.
 function J:HomeAvailable(now)
  local rows=self.homeRows;if not rows then return false end
  if self.homeAt==now and self.homeFor==rows then return self.homeValue end
  local found=false;local speed=math.max(200,H.ms or 350)
  for _,camp in pairs(rows)do
   if camp.team==H.team and self:Eligible(camp,now)then
    local at=due(camp)
    local up=camp.nativeUp~=false and not camp.awaitingRespawn and camp.availability~='observed_empty'
    local staging=camp.timing and camp.timing.firstSpawn and now<camp.timing.firstSpawn and not camp.seenAlive
    if up and(not at or at<=now)or staging or at and at<=now+dist(H.pos,self:Destination(camp))/speed then found=true;break end
   end
  end
  self.homeAt=now;self.homeFor=rows;self.homeValue=found;return found
 end
 -- One target choice per camp per tick; adapters may run a full camp search.
 function J:Target(camp)
  if not camp then return nil end
  local memo=self.targets
  if memo and memo.at==self.tickAt and memo[camp]~=nil then return memo[camp]or nil end
  local best
  if adapter.target then best=adapter.target(camp)
  else
   local distance=math.huge
   for _,u in ipairs(camp.members or{})do if valid(u)then local d=dist(H.pos,u.pos)
    if not best or (u.maxHealth or 0)>(best.maxHealth or 0)or u.maxHealth==best.maxHealth and d<distance then best,distance=u,d end
   end end
  end
  if memo and memo.at==self.tickAt then memo[camp]=best or false end
  return best
 end
 function J:Choose(rows,now,exclude)
  -- Straight costs for every candidate; bounded terrain refinement for the few cheapest.
  local candidates=self.candidates or {};self.candidates=candidates;local n=0;self.homeRows=rows
  for _,camp in pairs(rows)do if camp~=exclude and self:Eligible(camp,now)then
   local value,distance=self:Cost(camp,now,false)
   -- A living camp encountered on the route wins within its local clear reach.
   for _,m in ipairs(camp.members or{})do if valid(m)and dist(H.pos,m.pos)<650 then value=math.min(value,distance/math.max(200,H.ms or 350));break end end
   n=n+1;local row=candidates[n]or{};candidates[n]=row;row.camp=camp;row.value=value;row.distance=distance
  end end
  for i=n+1,#candidates do candidates[i]=nil end
  -- A living camp already damaged next to the player is finished first.
  local damaged,near
  for i=1,n do local camp=candidates[i].camp
   for _,m in ipairs(camp.members or{})do local d=dist(H.pos,m.pos)
    if valid(m)and finite(m.maxHealth)and m.health<m.maxHealth and d<DAMAGED_REACH and(not near or d<near)then damaged,near=candidates[i],d end
   end
  end
  if damaged then self.choice='damaged';return damaged.camp,damaged.value end
  table.sort(candidates,cheaper)
  if adapter.routeDistance then for i=1,math.min(ROUTE_REFINE,n)do
   local row=candidates[i];local measured=self:Cost(row.camp,now,true)
   if measured>row.value then row.value=measured end
  end end
  local best,cost=nil,math.huge
  for i=1,n do local row=candidates[i]
   if row.value<cost or row.value==cost and tostring(row.camp.id)<tostring(best and best.id)then best,cost=row.camp,row.value end
  end
   -- An early first clear starts at the nearer own buff, even when a small
   -- camp is closer. Select once; levelling and travel never restart the order.
  -- A preview (exclude given) reads the opening without advancing it.
  local preview=exclude~=nil
   if self.openingPending and not preview then
    self.openingPending=false
    local untouched=now<=OPENING_START_UNTIL
    local service=self.service or SDK.OrbamaUtils and SDK.OrbamaUtils.Camps
    local profile=service and service.profile
    for _,camp in pairs(rows)do
     profile=profile or camp.profile
     if camp.team==H.team and(camp.killedAt or camp.awaitingRespawn or(camp.spawnGeneration or 0)>0)then untouched=false end
    end
    local routes=OPENING_ROUTES[profile];local start,nearest
    if untouched and routes then for i=1,n do local row=candidates[i];local camp=row.camp
     if camp.team==H.team and routes[camp.category]and(not nearest or row.distance<nearest)then start,nearest=camp,row.distance end
    end end
    if start then self.opening={order=routes[start.category],index=1}end
   end
  local opening=self.opening
  if opening then
   for index=opening.index,#opening.order do
    for i=1,n do local row=candidates[i];local camp=row.camp
     if camp.category==opening.order[index]and camp.team==H.team and not camp.awaitingRespawn and not camp.killedAt then
      if not preview then opening.index=index end;self.choice='opening';return camp,row.value
     end
    end
   end
   if not preview then self.opening=nil end
  end
  -- A buff camp wins a near tie.
  if best then
   local speed=math.max(200,H.ms or 350);local chosen,chosenCost=best,cost
   local preferred=adapter.preferred or function(camp)return camp.category=='Red'or camp.category=='Blue'end
   if not preferred(best)then
    for i=1,n do local row=candidates[i]
     if row.value<=cost+BUFF_TIE/speed and preferred(row.camp)and(chosen==best or row.value<chosenCost)then chosen,chosenCost=row.camp,row.value end
    end
   end
   self.choice=chosen~=best and 'buff'or 'cost';return chosen,chosenCost
  end
  return best,cost
 end
 function J:Engaged(camp)
  if not camp then return false end
  if adapter.engaged then return adapter.engaged(camp)==true end
  for _,u in ipairs(camp.members or{})do
   local target=u.attackData and u.attackData.target
   if valid(u)and dist(H.pos,u.pos)<900 and(target==H.handle or target==H.networkID or u.health<u.maxHealth and self.lastAttackAt and G.Timer()-self.lastAttackAt<3)then return true end
  end
  return false
 end
 function J:Poll()
  if not client then return end
  for id in pairs(self.jobs)do
   local r=client:Poll(id)
   if not r then self.jobs[id]=nil
    elseif r.state=='send_uncertain'then self.uncertain=id
   elseif r.state=='cancelled_before_send'or r.state=='complete'or r.state=='aborted'or r.mechanical
    -- Own attack start seen, but the client called the evidence ambiguous (another input went
    -- out while it settled): it is not unknown to us, so release the attack resource now
    -- instead of after reconcile (live 2026-10-11: one attack per second on Krugs).
    or r.sentAt and self.attackSeen and self.attackSeen[id]and self.attackSeen[id].started then
     if self.command and self.command.id==id and not r.sentAt and(r.state=='cancelled_before_send'or r.state=='aborted')then self.command=nil end
     local finished=client:Finish(id,not r.mechanical and r.sentAt~=nil or nil)
     if finished or not client:HasAction(id)then self.jobs[id]=nil;if self.attackSeen then self.attackSeen[id]=nil end;if self.uncertain==id then self.uncertain=nil end end
   end
  end
 end
 function J:Move(destination)
  if self.uncertain or not destination or G.Timer()<(self.nextMove or 0)then return false end
  if adapter.move then return adapter.move(destination)end
  local walker=SDK.Orbwalker
  if not walker:CanMove()or walker:IsAutoAttacking()or walker.MovementEnabled==false then return false end
   local now=G.Timer();local command=self.command
   if self:ContinueMove(command,destination)then
    -- Input completion does not end the walking order. Keep this destination
    -- until arrival/combat, refusal, cancellation or the route's stall guard.
    return true
  end
  local map=SDK.Minimap;local target,kind,world
  if map and map.InputPoint and dist(H.pos,destination)>MINIMAP_REACH then target=map:InputPoint(g.Vector(destination));if target then kind='screen';world=copy(destination)end end
  if not target then
   local p=g.Vector(destination);local screen=p:To2D()
   if not map or not map.IsWorldScreenPoint or not map:IsWorldScreenPoint(screen)then return false,'safe_route_projection_unavailable'end
   target=p;kind='world'
  end
  local goal=copy(destination);local camp=self.camp
  local id,why=client:SubmitKeyed('auto-jungle:move',{owner='auto-jungle',type='move',resource='move',kind=kind,target=target,world=world,
   priority='background',expires=client:Now()+300,context=self:Context(),inputCompletion=true,autoAcknowledge=true,
   mechanical=function()return self.camp==camp and self:Active()and walker:CanMove()and not walker:IsAutoAttacking()and self:Safe({pos=goal})end})
   if id then self.jobs[id]=true;self.nextMove=now+.12;self.command={id=id,goal=goal,at=now}end
  return id~=nil,why
 end
 -- Used by the generic mover and by adapters with an existing transport.
 -- Rejected/uncertain sends are reconciled by their input owner, never replayed
 -- because the path wrapper briefly disappeared or the camera moved.
 function J:ContinueMove(command,destination)
  return command and command.goal and dist(command.goal,destination)<60
   and dist(H.pos,command.sent or command.goal)>160 or false
 end
 function J:Attack(u)
  if adapter.attack then return adapter.attack(u)end
  if self.uncertain or not valid(u)or not SDK.Orbwalker:CanAttack()or SDK.Orbwalker.AttackEnabled==false then return false end
  if not SDK.Data:IsInAutoAttackRange(H,u)then return false end
  local id,handle,name=u.networkID,u.handle,u.charName;local previous=SDK.Attack.ServerStart;local seen={}
  -- The client accepts only an evidence record (kind/source/unique/at); a bare true was
  -- rejected as invalid_evidence, so every auto-jungle attack stayed unconfirmed and held
  -- the attack resource until reconcile (live 2026-10-11: ~2.8 s without attacks each time).
  local function observed()
   local spell=H.activeSpell
   if SDK.Attack.ServerStart~=previous and spell and spell.valid and(spell.target==id or spell.target==handle)
    and(spell.isAutoAttack or SDK.Data.IsAttack and SDK.Data:IsAttack(spell.name))then
    self.lastAttackAt=G.Timer();self.attackStart=SDK.Attack.ServerStart;seen.started=true
    return {kind='mechanical',source='attack_observation',unique=true,at=client:Now()}
   end
   return false
  end
  local action,why=client:SubmitKeyed('auto-jungle:attack',{owner='auto-jungle',type='attack',resource='attack',kind='object',target=u,
   priority='background',expires=client:Now()+200,context=self:Context(),autoAcknowledge=true,
   mechanical=function()return valid(u)and u.networkID==id and u.handle==handle and u.charName==name
    and SDK.Orbwalker:CanAttack()and SDK.Data:IsInAutoAttackRange(H,u)end,
   observation=observed,
   -- Safe to forget once any newer attack started, the target is gone, or (the client asks
   -- only after the send settled) no attack is in progress and the next one may go: a sent
   -- attack that never started must not hold the attack resource forever (live 2026-10-11).
   reconcile=function()return SDK.Attack.ServerStart~=previous or not valid(u)
    or not SDK.Orbwalker:IsAutoAttacking()and SDK.Orbwalker:CanAttack()end})
  if action then self.jobs[action]=true;self.attackSeen=self.attackSeen or {};self.attackSeen[action]=seen end;return action~=nil,why
 end
 -- Terrain for a kite step. Unknown terrain is never walkable ground: without an
 -- adapter.walkable or the Summoner's Rift wall query, no kite step is taken.
 function J:Walkable(a,b)
  if adapter.walkable then return adapter.walkable(a,b)==true end
  if G.mapID~=11 or type(G.isWall)~='function'then return false end
  local d=dist(a,b);local steps=math.max(1,math.ceil(d/50))
  for i=1,steps do local t=i/steps
   local ok,wall=pcall(G.isWall,g.Vector({x=a.x+(b.x-a.x)*t,y=a.y or 0,z=a.z+(b.z-a.z)*t}))
   if not ok or wall~=false then return false end
  end
  return true
 end
 -- Kiting between attacks (Lee's farmKite, generalized). Only after the route's own
 -- observed attack on a melee camp monster has finished its windup, while the next
 -- attack is still cooling down: one step away, inside KITE_LEASH of the camp, short
 -- enough to be back in attack range when the attack is ready. Returns true while the
 -- step owns this tick's movement; false hands movement back (approach / attack).
 function J:Kite(camp,u)
  if adapter.kite==false or adapter.ownsAttacks or not client or self.uncertain then return false,'kite_off'end
  local walker,attack=SDK.Orbwalker,SDK.Attack
  if not attack or walker.MovementEnabled==false then return false,'movement_unavailable'end
  if not valid(u)or(u.range or 0)>KITE_MELEE then return false,'ranged_target'end
  local started=attack.ServerStart
  if not finite(started)or started<=0 or started~=self.attackStart then return false,'no_observed_attack'end
  local cycle=attack.GetAnimation and attack:GetAnimation();local finish=attack.CastEndTime
  if not finite(cycle)or cycle<=0 or not finite(finish)or finish<started then return false,'attack_timing_unknown'end
  local now=G.Timer()
  if now<finish or walker:IsAutoAttacking()or not walker:CanMove()or walker:CanAttack()then return false,'windup_or_ready'end
  local remaining=started+cycle-now;if remaining<=0 then return false,'attack_ready'end
  local latency=SDK.Data and SDK.Data.GetLatency and SDK.Data:GetLatency()
  local reserve=(finite(latency)and latency or .05)+.06
  local speed=math.max(1,H.ms or 350);local separation=dist(H.pos,u.pos)
  local range=SDK.Data and SDK.Data.GetAutoAttackRange and SDK.Data:GetAutoAttackRange(H,u)
  local ownRange=math.max(30,(finite(range)and range or(H.range or 125)+(H.boundingRadius or 35)+(u.boundingRadius or 45))-10)
  local step=self.kiteStep
  if step and step.started==started then
   -- Back in range for the next attack: the approach belongs to the caller.
   if step.phase=='return'or remaining<=math.max(0,separation-ownRange)/speed+reserve then step.phase='return';return false,'return_due'end
   return true
  end
  self.kiteStep=nil
  local center=camp and(camp.aimPos or camp.pos);if not center or dist(u.pos,center)>KITE_LEASH+150 then return false,'leash'end
  local budget=(remaining-reserve)*speed;local length=math.min(KITE_STEP,budget)
  if length<KITE_MIN then return false,'insufficient_time'end
  local dx,dz=H.pos.x-u.pos.x,H.pos.z-u.pos.z;local n=math.sqrt(dx*dx+dz*dz)
  if n<1 then dx,dz=1,0 else dx,dz=dx/n,dz/n end
  local enemyRange=(finite(u.range)and u.range>0 and u.range or 125)+(u.boundingRadius or 45)+(H.boundingRadius or 35)+25
  local best
  for _,angle in ipairs({0,.55,-.55,1.1,-1.1,1.57,-1.57,2.1,-2.1})do
   local x,z=dx*math.cos(angle)-dz*math.sin(angle),dx*math.sin(angle)+dz*math.cos(angle)
   for _,scale in ipairs({1,.75,.5})do
    local l=length*scale
    if l>=KITE_MIN then
     local p={x=H.pos.x+x*l,y=H.pos.y or 0,z=H.pos.z+z*l};local gap=dist(p,u.pos)
     if l+math.max(0,gap-ownRange)<=budget and dist(p,center)<=KITE_LEASH and(gap>=enemyRange or gap>separation+15)
      and self:Walkable(H.pos,p)then best=p;break end
    end
   end
   if best then break end
  end
  if not best then return false,'no_kite_step'end
  local map=SDK.Minimap;local target=g.Vector(best)
  if not map or not map.IsWorldScreenPoint or not target.To2D or not map:IsWorldScreenPoint(target:To2D())then return false,'safe_route_projection_unavailable'end
  local latest=started+cycle-reserve
  local id,why=client:SubmitKeyed('auto-jungle:move',{owner='auto-jungle',type='move',resource='move',kind='world',target=target,
   priority='background',expires=client:Now()+math.max(50,math.min(250,(remaining-reserve)*1000)),context=self:Context(),inputCompletion=true,autoAcknowledge=true,
   mechanical=function()return self.camp==camp and SDK.Attack.ServerStart==started and G.Timer()>=finish and G.Timer()<latest
    and walker:CanMove()and not walker:IsAutoAttacking()and not walker:CanAttack()end})
  if not id then return false,why end
  self.jobs[id]=true;self.command=nil;self.kiteStep={started=started,pos=best,phase='out',id=id}
  return true
 end
 function J:Recalling()
  local utils=SDK.OrbamaUtils
  if utils and utils.recalling then local ok,yes=pcall(utils.recalling,utils);if ok and yes then return true end end
  local active=H.activeSpell
  return active and active.valid and (active.name or ''):lower():find('recall',1,true)~=nil or false
 end
 function J:RecallThreshold()
  local setting=self.recallSetting;local value=setting and setting:Value()
  return (finite(value)and value or RECALL_HP)/100
 end
 -- Being hit right now: a monster of this (or the abandoned) camp targets us, or our
 -- health dropped within the last second.
 function J:UnderAttack(camp)
  if self.lastHurtAt and G.Timer()-self.lastHurtAt<1 then return true end
  for _,c in ipairs({camp or false,self.retreatCamp or false})do
   for _,m in ipairs(c and c.members or{})do
    local target=m.attackData and m.attackData.target
    if valid(m)and dist(H.pos,m.pos)<900 and(target==H.handle or target==H.networkID)then return true end
   end
  end
  return false
 end
 -- Lee's finish forecast without kit spells: our basic attacks against every living
 -- member (focus first), each member hitting us until it dies. Unknown data, an
 -- 8 s horizon or ending below the reserve is not survivable.
 function J:FinishForecast(camp)
  local result={safe=false,reason='insufficient_data',reserve=math.max(50,(H.maxHealth or 0)*.08),incoming=0}
  local attack,damage=SDK.Attack,SDK.Damage
  local cycle=attack and attack.GetAnimation and attack:GetAnimation()
  if not camp or not damage or not finite(cycle)or cycle<=0 then return result end
  local units={}
  for _,m in ipairs(camp.members or{})do
   if m.valid~=false and not m.dead and(m.health or 0)>0 then
    if not valid(m)or not finite(m.totalDamage)or not finite(m.attackSpeed)or m.attackSpeed<=0 then return result end
    local ok,aa=pcall(damage.GetAutoAttackDamage,damage,H,m);if not ok or not finite(aa)or aa<=0 then return result end
    local hit,taken=pcall(damage.CalculateDamage,damage,m,H,SDK.DAMAGE_TYPE_PHYSICAL or 0,m.totalDamage)
    if not hit or not finite(taken)then return result end
    units[#units+1]={unit=m,hp=m.health,aa=aa,damage=math.max(0,taken),rate=m.attackSpeed}
   end
  end
  if #units==0 or #units>12 then return result end
  local focus=self.target
  table.sort(units,function(a,b)if(a.unit==focus)~=(b.unit==focus)then return a.unit==focus end;return a.hp/a.aa<b.hp/b.aa end)
  local elapsed,finished=0,0
  for _,row in ipairs(units)do
   elapsed=elapsed+math.max(0,dist(H.pos,row.unit.pos)-(H.range or 125))/math.max(1,H.ms or 350)+math.ceil(row.hp/row.aa)*cycle
   if elapsed>8 then result.reason='clear_horizon_exceeded';return result end
   local incoming=finished
   for _,other in ipairs(units)do if not other.finished then incoming=incoming+other.damage*math.max(1,math.ceil(elapsed*other.rate))end end
   result.incoming=math.max(result.incoming,incoming)
   if H.health-result.incoming<result.reserve then result.reason='below_reserve';return result end
   row.finished=true;finished=finished+row.damage*math.max(1,math.ceil(elapsed*row.rate))
  end
  result.safe=true;result.reason='clear_above_reserve';result.elapsed=elapsed;return result
 end
 -- Walks toward the base, or straight away from the camp when the base is unknown.
 function J:Retreat(base,reason)
  if self.camp then self.retreatCamp=self.camp;self:Cancel(reason)end
  self.state='retreating';self.reason=reason;self.target=nil
  local goal=base
  if not goal then
   local from=self.retreatCamp and(self.retreatCamp.aimPos or self.retreatCamp.pos)
   if from then local dx,dz=H.pos.x-from.x,H.pos.z-from.z;local n=math.max(1,math.sqrt(dx*dx+dz*dz))
    goal={x=H.pos.x+dx/n*700,y=H.pos.y or 0,z=H.pos.z+dz/n*700}end
  end
  if goal then self:Move(goal)end
  return true
 end
 function J:EndRecall(cancel)
  local id=self.recallID;self.recallID=nil;self.recallRequested=nil;self.recallSentAt=nil
  if id and client and cancel then client:Cancel(id,'recall_withdrawn')end
 end
 -- Recovery (Lee's design without his kit): below the recall setting a survivable
 -- engaged camp is finished first; otherwise the route retreats while threatened or
 -- under attack and recalls only when safe. A recall whose channel never shows is
 -- not replayed in place: the route moves away first. Healing at base ends it.
 function J:Recovery()
  if adapter.recovery then return adapter.recovery()end
  local now=G.Timer();local hp=H.health/math.max(1,H.maxHealth)
  if self.lastHP and H.health<self.lastHP-.1 then self.lastHurtAt=now end;self.lastHP=H.health
  local utils=SDK.OrbamaUtils;local locations=utils and utils.observations and utils.observations.locations
  local base=locations and locations:Base(H.team)
  if self.recovering and base and dist(H.pos,base)<850 then
   self:EndRecall(false);self.recallObserved=nil;self.recallReconcile=nil;self.retreatCamp=nil
   self.state='recovering';if hp<.9 or H.maxMana>0 and H.mana/H.maxMana<.8 then return true end
   self.recovering=nil;self.command=nil;return false
  end
  if self:Recalling()then self.recallObserved=true;self.recovering=true;self.state='recalling';return true end
  if self.recallObserved then
   -- The channel ended away from base: interrupted. Move before asking again.
   self.recallObserved=nil;self:EndRecall(false);self.recallReconcile=copy(H.pos)
  end
  if not self.recovering and hp>=self:RecallThreshold()then return false end
  self.recovering=true
  local safe=self:Safe({pos=H.pos});local attacked=self:UnderAttack(self.camp)
  -- Finish an engaged camp only when the forecast survives it.
  if not self.recallID and safe and self.camp and self:Engaged(self.camp)then
   local f=self:FinishForecast(self.camp);self.forecast=f
   if f.safe then self.state='finishing';return false end
  end
  if self.recallID then
   local r=client:Poll(self.recallID)
   if r and r.sentAt then self.recallSentAt=self.recallSentAt or now end
   if not safe or attacked then
    -- Never stand under attack waiting for a recall.
    local sent=self.recallSentAt;self:EndRecall(true)
    if sent then self.recallReconcile=copy(H.pos)end
    return self:Retreat(base,'Retreating before recalling')
   end
   if r and r.state=='cancelled_before_send'then self:EndRecall(false)
   elseif not self.recallSentAt and r and(r.state=='waiting'or r.state=='requested')then self.state='recalling';return true
   elseif now-(self.recallSentAt or self.recallRequested or now)<RECALL_CONFIRM then self.state='recalling';return true
   else self:EndRecall(false);self.recallReconcile=copy(H.pos)end
  end
  if self.recallReconcile then
   if dist(H.pos,self.recallReconcile)<RECONCILE_MOVE then return self:Retreat(base,'Recall was not seen; moving first')end
   self.recallReconcile=nil
  end
  if not safe or attacked then return self:Retreat(base,safe and 'Retreating before recalling'or 'Retreating from a threat')end
  if self.camp then self.retreatCamp=self.camp;self:Cancel('recovery')end
  self.state='recovering';self.reason=nil
  -- Walking the last stretch is faster than an eight-second recall.
  if base and dist(H.pos,base)<1200 then self:Move(base);return true end
  if self.uncertain or now<(self.recallRetryAt or 0)then return true end
  local id=client:Submit({owner='auto-jungle',type='cast',kind='none',keys={g.HK_RECALL or 66},priority='background',
   expires=client:Now()+250,context=self:Context(),autoAcknowledge=true,
   mechanical=function()return self:Active()and self:Safe({pos=H.pos})and not self:UnderAttack(nil)end})
  if id then self.recallID=id;self.recallRequested=now;self.state='recalling'else self.recallRetryAt=now+.25 end
  return true
 end
 -- Returns true only when routing acted for this tick (recovery, a clear, a
 -- submitted or continuing movement). Idle, waiting and unavailable routes
 -- leave the caller's own automation (finishers, kill-secure) running.
 -- Follows the menu toggle: on starts a route, off ends it.
 function J:SyncToggle()
  local bind=self.bind;if not bind or adapter.enabled then return end
  local on=bind:Value()==true
  if self.resumePress then
   self.resumePress=nil
   if not on and self.enabled and self.paused then pcall(bind.Value,bind,true);on=bind:Value()==true;if on then self:Start();return end end
  end
  if on~=self.enabled then self.enabled=on;if on then self:Start()else self:Cancel('route_toggle_off');self:ReleaseCamera()end end
 end
 function J:Tick()
  self:SyncToggle();self:Poll();self.recoveryOwned=false
  if self:Enabled()and not self.paused then
   for _,held in pairs(SDK.Orbwalker.Modes or{})do if held then self:Pause('Combat mode takeover');return false end end
  end
  -- A short hold (skill allocation) keeps the route and its destination.
  if self.wasActive and adapter.hold and adapter.hold()then self.state='waiting';return false end
  if not self:Active()then
   if self.wasActive then self:Cancel('route_context_ended')end;self.wasActive=false
   self:ReleaseCamera();return false
  end
  self.wasActive=true;self.reason=nil;self:Camera()
  local now=G.Timer();self.tickAt=now
  local memo=self.targets or {};self.targets=memo
  if memo.at~=now then for k in pairs(memo)do memo[k]=nil end;memo.at=now end
  -- Recovery (retreat, recall, healing) needs no camp knowledge and always runs first.
  if self:Recovery()then self.recoveryOwned=true;return true end
  local service=SDK.OrbamaUtils and SDK.OrbamaUtils.Camps
  if not service or service.version~=2 or service.closed then self.state='unavailable';self.reason='Shared camp knowledge unavailable';return false end
  if service~=self.service then
   if self.scope then self.scope:Close()end;if self.service then self:Cancel('camp_service_changed')end;self.service=service
   self.scope=service:Register('AyyyyIO:auto-jungle',function()return not self.closed and self:Enabled()and core:Current()end)
  end
  -- An adapter that already holds this tick's reconciled rows passes them on.
  local rows=adapter.rows and adapter.rows()or service:Refresh()
  local engaged=self:Engaged(self.camp)
  if not engaged then
   local current=self.camp
   -- Commit the selected camp while travelling. New distance estimates and
   -- passing another living camp do not withdraw a valid walking order.
   local retained=false;for _,row in pairs(rows)do if row==current then retained=true;break end end
   if not current or not retained or not self:Eligible(current,now)or current.awaitingRespawn and not self:Target(current)and not self.waitingSpawn then
    local best=self:Choose(rows,now)
    self.camp=best;self.target=nil;self.command=nil;self.emptyAt=nil;self.progressAt=nil
    self.waitingSpawn=best and best.awaitingRespawn or nil
    if client then client:CancelKeyed('auto-jungle:move','route_destination_changed')end
    if adapter.selected then adapter.selected(best)end
    self:Event('selected',current and 'previous_camp_ended'or 'route_started')
   end
  end
  local camp=self.camp;if not camp then self.state='idle';self.reason='No safe eligible camp';return false end
  local u=self:Target(camp);self.target=u
  if adapter.movement and adapter.movement(camp,u)then self.state='routing';return true end
  local acted=false
  if u and dist(H.pos,u.pos)<=650 then
   self.emptyAt=nil;self.state='clearing';acted=true
   local moved=adapter.clear and adapter.clear(camp,u,self:Context())==true
   if not adapter.ownsAttacks then
    self:Attack(u)
    -- An adapter that owns its attacks, or chose a destination, keeps it; otherwise
    -- the shared kite step owns movement between attacks.
    if not moved then moved=self:Kite(camp,u)==true end
    if not moved and not SDK.Data:IsInAutoAttackRange(H,u)then self:Move(u.pos)end
   end
  else
   self.state=camp.expectedAt and 'respawn'or 'routing'
   local goal=self:Destination(camp)
   if dist(H.pos,goal)<250 and not u then
    self.emptyAt=self.emptyAt or now
    local at=due(camp)
    -- A Krug that just died may still split into new members.
    local splitting=now<(camp.splitUntil or 0)
    if splitting then self.state='waiting';self.reason='Waiting for the Krugs to split'
    elseif self.opening and self.opening.index==1 and not camp.seenAlive and now<=OPENING_START_UNTIL then
     -- Classic has no verified first-spawn clock. Early staging waits for a
     -- living buff instead of turning a missing pre-spawn snapshot into theft.
     self.state='waiting';self.reason='Waiting for the first camp'
    -- A camp waited on until its respawn gets SPAWN_GRACE after the expected time: new
    -- monsters appear and become targetable a moment after the timer (live 2026-10-11:
    -- Wolves were skipped the instant they were due, before they could be seen).
    elseif now-math.max(self.emptyAt,at or self.emptyAt)>=(at and at>self.emptyAt and SPAWN_GRACE or .16)and(not at or now>=at)then
     -- No reachable current monster: record the empty arrival (never a death
     -- time) and skip it until it can have respawned.
     if not(service.ObserveEmptyArrival and service:ObserveEmptyArrival(camp.id,self.emptyAt))then self.blocked[camp.id]=now+5 end
     self.camp=nil;self.command=nil;self.reason='No current reachable monster';return false
    else self.state='waiting'end
   else self.emptyAt=nil;acted=self:Move(goal)==true end
  end
  if not self.progressAt or dist(H.pos,self.progressPos)>60 then self.progressAt=now;self.progressPos=copy(H.pos)
  elseif not engaged and now-self.progressAt>4 and self.state=='routing'then
   self:Event('stalled','no_position_progress');self.blocked[camp.id]=now+15;self.camp=nil;self.progressAt=nil;self.command=nil
   if client then client:CancelKeyed('auto-jungle:move','route_stalled')end
  end
  return acted
 end
 if core and core.RegisterService then core:RegisterService('auto-jungle',J)end
 if not adapter.ownsControls and core and core.Bind then
  local menu=adapter.menu
  -- Per-champion on/off toggle (player request 2026-10-11: a toggle on J in each champion's Controls).
  if menu then
   if not menu.Controls then menu:MenuElement({type=g.MENU,id='Controls',name='Controls'})end
   local spec={id='AutoJungleKey',name='Auto-jungle on / off',key=DEFAULT_KEY,toggle=true,value=false}
   if adapter.menuID and adapter.menus then adapter.menus:Apply(spec,adapter.menuID,'Controls.AutoJungleKey','Controls.AutoJungleKey')end
   spec.toggle=true;spec.value=false
   menu.Controls:MenuElement(spec);J.bind=menu.Controls.AutoJungleKey
   if menu.Controls.Hide then menu.Controls:Hide(false)end
   local key={id='CameraCenterKey',name='Center-camera key (held while auto-jungling)',key=CAMERA_KEY,fixedKey=true}
   if adapter.menuID and adapter.menus then adapter.menus:Apply(key,adapter.menuID,'Controls.CameraCenterKey','Controls.CameraCenterKey')end
   menu.Controls:MenuElement(key);J.cameraBind=menu.Controls.CameraCenterKey
   -- Very few choices (player request 2026-10-11); everything else keeps its defaults.
   menu:MenuElement({type=g.MENU,id='AutoJungle',name='Auto-jungle'})
   local sub=menu.AutoJungle or menu.Automation and menu.Automation.AutoJungle
   if sub then
    sub:MenuElement({id='Invade',name='Route into the enemy jungle',value=false})
    sub:MenuElement({id='Camera',name='Keep the camera on your champion',value=true})
    -- The one recovery choice; kiting and minimap walks keep their defaults.
    sub:MenuElement({id='RecallHP',name='Recall below health %',value=RECALL_HP,min=10,max=60,step=5})
    J.invadeSetting=sub.Invade;J.cameraSetting=sub.Camera;J.recallSetting=sub.RecallHP
   end
   -- A saved "on" never starts routing by itself when the game loads.
   if J.bind and J.bind:Value()==true then pcall(J.bind.Value,J.bind,false)end
  end
  local overlay=SDK.Overlay
  if overlay and overlay.GetCapabilities and overlay:GetCapabilities().ownedScopes then
   -- One display scope per controller: inside the family the route draws into
   -- the controller's champion scope; only a standalone core registers its own.
   local family=g.AyyyyIO;local shared=family and family.GetOverlayScope and family:GetOverlayScope('champion')
   local scope=shared or overlay:Register('AyyyyIO.auto-jungle',{active=function()return not J.closed and core:Current()end})
   if scope then
    if shared then core:RegisterService('auto-jungle-display',{Close=function()scope:Remove('route-toggle');scope:Remove('route-state')end})
    else core:RegisterService('auto-jungle-display',scope)end
    scope:Renderer('auto-jungle-status',function()
     if J.closed or not core:Current()then scope:Remove('route-toggle');scope:Remove('route-state');return end
     -- The state follows the key on the same line: "Auto-jungle [J] routing to Wolves".
     scope:Set('route-toggle',{kind='status',feature='champion',anchor='hud',label='Auto-jungle',enabled=J:Enabled()==true,bind=J.bind and J.bind:Key()or DEFAULT_KEY,
      detail=J:Enabled()and J:StateText()or nil,priority=90,expires=G.Timer()+.25})
     scope:Remove('route-state')
    end,4)
   end
  end
  core:Bind(SDK.OnWndMsg,function(msg,key)
   -- Typing in chat is never a toggle or a manual movement command.
   if G.IsChatOpen and G.IsChatOpen()then if msg==257 and key==(J.bind and J.bind:Key()or DEFAULT_KEY)then J.keyHeld=false end;return end
   local edge=SDK.Input and SDK.Input.LastInputEdge
   if edge and edge.classification~='new manual press or unmatched echo'then return end
   if key==(J.bind and J.bind:Key()or DEFAULT_KEY)then
    -- The menu toggle flips on this press; a press while paused resumes instead of turning it off.
    if msg==257 then J.keyHeld=false elseif msg==256 and not J.keyHeld then
     J.keyHeld=true;if J.enabled and J.paused then J.resumePress=true end
    end
   elseif msg==256 and key==J:CameraKey()and J:Enabled()then J.cameraYielded=true;J:ReleaseCamera()
   -- Only a running route pauses: a click on a paused one must not cancel the held mode's casts.
   elseif J:Enabled()and not J.paused and (msg==516 or msg==513)then J:Pause('Physical mouse command')end
  end)
 end
 J.defaultKey=DEFAULT_KEY
 return J
end

end
