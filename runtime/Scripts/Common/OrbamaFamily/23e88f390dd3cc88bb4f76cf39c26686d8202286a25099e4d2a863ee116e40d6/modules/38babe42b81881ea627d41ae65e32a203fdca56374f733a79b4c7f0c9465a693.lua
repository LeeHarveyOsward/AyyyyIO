return function(require)
-- Angled strikes: abilities whose effect depends on where the champion stands
-- relative to the enemy (a knock-back whose direction follows the caster-target
-- line, a wall stun, a side bonus). Contract: docs/ANGLED-STRIKES.md.
--
-- Spec (data, per ability and profile, in the champion's combat profile as
-- `<ability>.strike`):
--   push      'away' (along caster->target) | 'toward' (back to the caster)
--   distance  {min,max} units the target is moved
--   scale     'travel' (min..max over `full` units the caster travelled) | nil (min)
--   full      units of travel for the maximum (scale='travel')
--   wall      {stun=s}: the target hitting terrain inside the distance is stunned
--   source    provenance of every number above
-- The scorer (S.Plan) compares a bounded set of approach angles and returns the
-- side to strike from; S.Steering walks there on the shared movement lease.
return function(g,C)
 local H,G=g.myHero,g.Game
 local S={}
 local function finite(v)return type(v)=='number'and v==v and v>-math.huge and v<math.huge end
 local function point(p)return p and finite(p.x)and finite(p.z)and {x=p.x,y=p.y or 0,z=p.z}or nil end
 local function dist(a,b)local dx,dz=a.x-b.x,a.z-b.z;return math.sqrt(dx*dx+dz*dz)end
 local function at(o,angle,r)return {x=o.x+math.cos(angle)*r,y=o.y,z=o.z+math.sin(angle)*r}end
 local function wrap(a)while a>math.pi do a=a-2*math.pi end;while a<-math.pi do a=a+2*math.pi end;return a end
 local function id(u)return u and(u.networkID or u.handle)end

 -- Score weights (one unit: one ally champion in follow-up reach of the landing).
 local W={ally=1,allyDamage=1,turret=2,wall=2.5,team=.75,enemyTurret=1.5,travel=.5,exposure=.75,hit=1,flash=.5}
 S.weights=W
 S.MIN_GAIN=.5 -- a steered side must beat the straight approach by this much
 S.ANGLE_STEP=math.pi/6 -- candidates every 30 degrees ...
 S.MAX_TURN=2*math.pi/3 -- ... up to 120 degrees around the target from the straight approach
 S.ALIGNED=math.pi/9 -- 20 degrees: the hero stands on the chosen side
 S.FOLLOW=1 -- seconds of an ally's walking that still count as follow-up reach

 -- Terrain: true wall, false open ground, nil unknown (no host query or an error).
 function S.WallAt(p)
  if type(G.isWall)~='function'or not p then return nil end
  local ok,result=pcall(G.isWall,g.Vector(p.x,p.y or 0,p.z))
  if not ok or type(result)~='boolean'then return nil end
  return result
 end
 -- A wall the target hits when moved `length` from `to` along from->to: the same
 -- cross-section (20 to either side of the line) at one 20-unit step, so an
 -- unrelated thin obstacle or a one-sided corner does not count.
 function S.WallBehind(from,to,length)
  if not from or not to or dist(from,to)<1 then return false end
  local d=dist(from,to);local ux,uz=(to.x-from.x)/d,(to.z-from.z)/d
  local margin=20
  local function corridor(k)
   local p={x=to.x+ux*k,y=to.y or 0,z=to.z+uz*k}
   if S.WallAt(p)~=true then return false end
   return S.WallAt({x=p.x-uz*margin,y=p.y,z=p.z+ux*margin})==true and S.WallAt({x=p.x+uz*margin,y=p.y,z=p.z-ux*margin})==true
  end
  for k=0,length,20 do if corridor(k)then return true end end
  return corridor(length)
 end
 -- Knock-back distance for a spec: rank-free min..max by travel share.
 function S.Distance(spec,travel)
  local d=spec and spec.distance;if type(d)~='table'or not finite(d[1])then return nil end
  local hi=finite(d[2])and d[2]or d[1]
  if spec.scale=='travel'and finite(spec.full)and spec.full>0 and finite(travel)then
   return d[1]+(hi-d[1])*math.max(0,math.min(1,travel/spec.full))
  end
  return d[1]
 end
 -- Where the target ends when struck from `caster`: moved `distance` along the
 -- push rule, stopping at terrain (wallHit). Unknown terrain stops nothing.
 function S.Landing(spec,caster,target,distance)
  local d=dist(caster,target);if d<1 or not finite(distance)then return nil end
  local ux,uz=(target.x-caster.x)/d,(target.z-caster.z)/d
  if spec.push=='toward'then ux,uz=-ux,-uz;distance=math.min(distance,math.max(0,d-50))end
  if spec.wall then
   local hit=S.WallBehind(caster,target,distance)
   if spec.push~='toward'and hit then return {x=target.x+ux*distance,y=target.y,z=target.z+uz*distance},true end
  end
  local steps=math.max(1,math.ceil(distance/75));local last=target
  for k=1,steps do local p={x=target.x+ux*distance*k/steps,y=target.y,z=target.z+uz*distance*k/steps}
   if S.WallAt(p)==true then return last,true end;last=p end
  return last,false
 end

 local function units(method)
  local m=g.SDK and g.SDK.ObjectManager;if not m or type(m[method])~='function'then return {}end
  return C:DecisionUnits(method)
 end
 local function alive(u)return u and u.valid~=false and u.dead~=true and point(u.pos)~=nil end
 local function flashReady(u)
  if type(u.GetSpellData)~='function'then return false end
  for slot=4,5 do local ok,s=pcall(u.GetSpellData,u,slot);local name=ok and s and type(s.name)=='string'and s.name:lower()
   if name and name:find('flash',1,true)and s.currentCd==0 then return true end end
  return false
 end
 local function leaving(u)
  local p=u.pathing;local to=p and p.hasMovePath==true and point(p.endPos)
  return to and dist(to,H.pos)>dist(u.pos,H.pos)+50 or false
 end

 -- The board around one target, read once per plan: allies with their reach and
 -- damage share, allied and enemy turrets, the other enemies and their centre.
 local function board(target,T)
  local b={allies={},turrets={},enemyTurrets={},enemies={}}
  for _,u in ipairs(C:Rows('hero',2500,true))do
   if u~=H and alive(u)and dist(u.pos,T)<=2200 then
    local reach=(u.range or 0)+(u.boundingRadius or 0)+(target.boundingRadius or 0)+(finite(u.ms)and u.ms or 0)*S.FOLLOW
    local damage=(finite(u.totalDamage)and u.totalDamage or 0)*2+(finite(u.ap)and u.ap or 0)*.6
    b.allies[#b.allies+1]={pos=point(u.pos),reach=reach,share=math.min(1,damage/math.max(1,target.health or 1))}
   end
  end
  for _,t in ipairs(units('GetAllyTurrets'))do if alive(t)and dist(t.pos,T)<=2000 then b.turrets[#b.turrets+1]={pos=point(t.pos),reach=750+(t.boundingRadius or 0)+(target.boundingRadius or 0)}end end
  for _,t in ipairs(units('GetEnemyTurrets'))do if alive(t)and dist(t.pos,T)<=2000 then b.enemyTurrets[#b.enemyTurrets+1]={pos=point(t.pos),reach=750+(t.boundingRadius or 0)}end end
  local sx,sz,n=0,0,0
  for _,u in ipairs(C:Rows('hero',2500))do
   if u~=target and alive(u)then b.enemies[#b.enemies+1]=point(u.pos)
    if dist(u.pos,T)<=1200 then sx,sz,n=sx+u.pos.x,sz+u.pos.z,n+1 end end
  end
  if n>0 then b.centre={x=sx/n,y=T.y,z=sz/n}end
  return b
 end
 local function under(list,p)for _,t in ipairs(list)do if dist(t.pos,p)<=t.reach then return true end end;return false end
 local function crowd(b,p)local n=0;for _,e in ipairs(b.enemies)do if dist(e,p)<=600 then n=n+1 end end;return n end

 -- The value of a landing (allies, turret, wall stun, enemy team, enemy turret).
 local function value(spec,b,T,L,wallHit,distance,parts)
  local ally=0;for _,a in ipairs(b.allies)do if dist(a.pos,L)<=a.reach then ally=ally+W.ally+W.allyDamage*a.share end end
  parts.ally=ally
  parts.turret=under(b.turrets,L)and W.turret or 0
  parts.wall=spec.wall and wallHit and W.wall or 0
  parts.team=b.centre and distance>0 and W.team*math.max(-1,math.min(1,(dist(L,b.centre)-dist(T,b.centre))/distance))or 0
  local was,is=under(b.enemyTurrets,T),under(b.enemyTurrets,L)
  parts.enemyTurret=is and not was and -W.enemyTurret or was and not is and W.enemyTurret/3 or 0
  return parts.ally+parts.turret+parts.wall+parts.team+parts.enemyTurret
 end

 -- Plan one strike on `target`. opts:
 --   distance  knock-back distance now (S.Distance), required
 --   standoff  distance from the target's centre at which the strike lands, required
 --   lethal    fn() -> true when the strike or the next seconds kill anyway (no steering)
 --   remaining seconds the strike stays armed (nil: unbounded)
 --   window    most extra seconds steering may cost (default .6)
 --   speed     the hero's speed (default myHero.ms)
 -- Returns a plan: steer, reason, angle (side of the target to strike from),
 -- point (approach point), ring, landing, score, straight (score of the straight
 -- approach), gain, window, parts, candidates, refused. Bounded: at most nine
 -- candidates and about eight terrain queries each.
 function S.Plan(target,spec,opts)
  opts=opts or {};local now=G.Timer()
  local T,Hp=point(target and target.pos),point(H.pos)
  local plan={target=id(target),at=now,expires=now+.15,steer=false,candidates=0,refused=0}
  if not T or not Hp or not spec then plan.reason='invalid';return plan end
  local d=dist(Hp,T);local standoff,distance=opts.standoff,opts.distance
  if d<1 or not finite(standoff)or not finite(distance)then plan.reason='invalid';return plan end
  if opts.lethal and opts.lethal()then plan.reason='kill_now';return plan end
  local ring=standoff+100;plan.ring=ring
  if d<=ring-25 then plan.reason='in_reach';return plan end
  local speed=finite(opts.speed)and opts.speed>0 and opts.speed or(finite(H.ms)and H.ms>0 and H.ms or 345)
  local window=opts.window or .6
  local straight=math.atan2(Hp.z-T.z,Hp.x-T.x);plan.straightAngle=straight
  local b=board(target,T)
  local tms=finite(target.ms)and target.ms or 0
  local away,flash=leaving(target),flashReady(target)
  local evade=g.SDK and g.SDK.Evade;evade=evade and type(evade.IsDangerous)=='function'and evade or nil
  local baseCrowd=crowd(b,at(T,straight,standoff))
  local approach=(d-ring)/speed
  local best,base
  local turns={0};for k=1,math.floor(S.MAX_TURN/S.ANGLE_STEP+1e-6)do turns[#turns+1]=k*S.ANGLE_STEP;turns[#turns+1]=-k*S.ANGLE_STEP end
  for _,turn in ipairs(turns)do
   local angle=wrap(straight+turn);local caster=at(T,angle,standoff);plan.candidates=plan.candidates+1
   local time=ring*math.abs(turn)/speed;local refused
   if turn~=0 then
    local a=at(T,angle,ring);local m=at(T,wrap(straight+turn/2),ring)
    if time>window then refused='too_far'
    elseif opts.remaining and approach+time+.15>opts.remaining then refused='expires'
    elseif S.WallAt(a)~=false or S.WallAt(m)~=false then refused='wall'
    elseif away and(tms>=speed or approach+time+tms*time/(speed-tms)+.15>(opts.remaining or math.huge))then refused='costs_hit'
    elseif evade then local ok,danger=pcall(evade.IsDangerous,evade,g.Vector(a.x,a.y,a.z),now+approach+time);if not ok or danger~=false then refused='danger'end end
   end
   if refused then plan.refused=plan.refused+1
   else
    local landing,wallHit=S.Landing(spec,caster,T,distance)
    if landing then
     local parts={}
     local v=value(spec,b,T,landing,wallHit,distance,parts)
     -- A target walking away opens tms*time that the hero closes at the speed difference.
     local hit=turn~=0 and away and tms*time/(speed-tms)or 0
     parts.travel=-W.travel*time
     parts.exposure=-W.exposure*math.max(0,crowd(b,caster)-baseCrowd)
     parts.hit=-(W.hit*hit+(flash and W.flash*time or 0))
     local row={angle=angle,turn=turn,point=at(T,angle,ring),landing=landing,wallHit=wallHit,time=time,parts=parts,
      score=v+parts.travel+parts.exposure+parts.hit}
     if turn==0 then base=row end
     if not best or row.score>best.score then best=row end
    end
   end
  end
  if not base then plan.reason='invalid';return plan end
  plan.straight=base.score;plan.straightLanding=base.landing
  plan.angle,plan.point,plan.landing,plan.score,plan.parts,plan.wallHit=best.angle,best.point,best.landing,best.score,best.parts,best.wallHit
  plan.gain=best.score-base.score;plan.window=best.time+.3
  if best==base then plan.reason='straight_best'
  elseif plan.gain<S.MIN_GAIN then plan.reason='no_gain'
  else plan.steer=true;plan.reason='steer'end
  return plan
 end

 -- One steering lease per owner. Update(plan,target) each tick while the strike
 -- is armed: orbit at the plan's ring toward its side (at most 45 degrees per
 -- waypoint), then walk straight at the target from there until the strike
 -- lands; Release(reason) otherwise. Refuses (and releases) on the hero's death,
 -- an Evade dodge, a lost target, terrain on the way and the plan's time window.
 -- A timed-out or aligned strike is not steered again until Release.
 function S.Steering(owner)
  local st={owner=owner}
  function st:Release(reason)
   if self.active then C:ReleaseMovePreference(owner)end
   local was=self.active;self.active=nil;self.phase=nil;self.started=nil;self.done=nil;self.identity=nil;self.angle=nil;self.window=nil
   if reason then self.last=reason end
   return was==true
  end
  local function stop(self,reason,keep)
   if self.active then C:ReleaseMovePreference(owner)end;self.active=nil;self.last=reason
   if keep then self.done=reason end
   return false,reason
  end
  function st:Update(plan,target)
   if not plan then self:Release('no_plan');return false,'no_plan'end
   if H.dead or not C:Current()then self:Release('dead');return false,'dead'end
   local evade=g.SDK and g.SDK.Evade
   if evade and type(evade.Evading)=='function'and evade:Evading()then return stop(self,'evade')end
   if not target or not C:CurrentUnit(target)or id(target)~=plan.target then self:Release('target_lost');return false,'target_lost'end
   if self.identity~=plan.target then self:Release();self.identity=plan.target end
   if self.done then return false,self.done end
   -- Started: the side stays chosen (hysteresis) while the plan only stops
   -- finding enough gain because the hero is already part of the way round.
   if plan.reason=='kill_now'or plan.reason=='invalid'then return stop(self,plan.reason,true)end
   if plan.steer then self.angle=plan.angle
   elseif not self.phase then return stop(self,plan.reason)end
   local now=G.Timer()
   if not self.started then self.started=now;self.window=plan.window or .5 end
   if now-self.started>self.window+.25 then return stop(self,'timeout',true)end
   local T,Hp=point(target.pos),point(H.pos)
   local d=dist(Hp,T);local ring=plan.ring or d
   if self.phase=='commit'then
    if d<=ring-80 then return stop(self,'in_reach',true)end
   else
    local current=math.atan2(Hp.z-T.z,Hp.x-T.x);local delta=wrap(self.angle-current)
    if math.abs(delta)<=S.ALIGNED then self.phase='commit'
    else
     if d<=ring-25 then return stop(self,'in_reach',true)end
     local step=(delta>0 and 1 or -1)*math.min(math.abs(delta),math.pi/4)
     local waypoint=at(T,wrap(current+step),ring)
     local mid={x=(waypoint.x+Hp.x)/2,y=Hp.y,z=(waypoint.z+Hp.z)/2}
     if S.WallAt(waypoint)~=false or S.WallAt(mid)~=false then return stop(self,'wall',true)end
     local ok,why=C:PreferMove(owner,waypoint,.25);if not ok then return stop(self,why or 'lease_refused')end
     self.active=true;self.phase='orbit';return true,'orbit'
    end
   end
   local ok,why=C:PreferMove(owner,T,.25);if not ok then return stop(self,why or 'lease_refused')end
   self.active=true;return true,'commit'
  end
  return st
 end
 return S
end

end
