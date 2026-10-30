return function(require)
-- Detached gameplay observations from the existing Utils tracker.
-- These are estimates and event facts; they cannot authorize input.
local U=require('utils.util')
local World=require('CombatProfiles.world')
local K={version=1};K.__index=K
local S={};S.__index=S
local function point(p)return p and U.finite(p.x)and U.finite(p.z)and U.copy(p)or nil end
local function current(u,row)
 return u and row and u.valid~=false and not u.dead and U.id(u)==row.id
  and u.handle==row.handle and u.charName==row.name and u.team==row.team
end
local function clone(row)
 local out={};for key,value in pairs(row)do
  if key~='unit'and key~='path'then out[key]=type(value)=='table'and U.copy(value)or value end
 end
 if row.path then out.path={};for i,p in ipairs(row.path)do out.path[i]=U.copy(p)end end
 return out
end
function K.new(c)return setmetatable({c=c,scopes={},count=0},K)end
function K:GetCapabilities()return {version=1,lastSeen=true,recallEvents=true,nativeBases=true,detachedSnapshots=true,healthObservations=true}end
function K:Alive()return not self.closed and self.c:active()end
function K:Register(owner,options)
 if not self:Alive()then return nil,'knowledge_inactive'end
 if type(owner)~='string'or owner==''or #owner>100 or type(options)~='table'or type(options.active)~='function'then return nil,'invalid_knowledge_scope'end
 if self.scopes[owner]then return nil,'knowledge_owner_registered'end
 if self.count>=16 then return nil,'knowledge_scope_limit'end
 local scope=setmetatable({service=self,owner=owner,active=options.active,lastSeen=options.lastSeen~=false,
  recalls=options.recalls~=false,bases=options.bases==true},S)
 self.scopes[owner]=scope;self.count=self.count+1;return scope
end
function K:Demand(kind)
 for _,scope in pairs(self.scopes)do
  if not scope:Alive()then scope:Close()elseif scope[kind]then return true end
 end
 return false
end
function K:Close()
 if self.closed then return end;self.closed=true
 for _,scope in pairs(self.scopes)do scope.closed=true end
 self.scopes={};self.count=0
end
function S:Alive()
 if self.closed or not self.service:Alive()or self.service.scopes[self.owner]~=self then return false end
 local ok,value=pcall(self.active);return ok and value==true
end
function S:Close()
 if self.closed then return end;self.closed=true
 local service=self.service
 if service.scopes[self.owner]==self then service.scopes[self.owner]=nil;service.count=service.count-1 end
end
function S:LastSeen(unit,maxAge)
 if not self:Alive()or not self.lastSeen then return nil,'knowledge_scope_inactive'end
 local c=self.service.c;local row=c.observations.lastSeen[U.id(unit)]
  if not current(unit,row)or row.map~=c.g.Game.mapID or row.profile~=c.profile.id or row.source~='observed'or row.estimated then return nil,'last_seen_identity_unknown'end
 local age=c:now()-row.at;maxAge=maxAge or .75
 -- Callers bound their own use; the hard ceiling keeps one observation from
 -- authorizing anything for the rest of a game.
 if not U.finite(maxAge)or maxAge<0 or maxAge>120 or age<0 or age>maxAge then return nil,'last_seen_expired'end
 local result=clone(row);result.age=age;result.revision=c.observations.revision
 result.profile=c.profile.id;result.map=c.g.Game.mapID;result.observed=true;return result
end
function S:Recall(unit)
 if not self:Alive()or not self.recalls then return nil,'knowledge_scope_inactive'end
 local c=self.service.c;local row=c.observations.recalls[U.id(unit)]
  if not current(unit,row)or row.map~=c.g.Game.mapID or row.profile~=c.profile.id or row.status~='started'or not U.finite(row.ends)
  or not World.recallNames[U.name(row.kind)]then return nil,'recall_unconfirmed'end
 local now=c:now();if now<row.started or now>=row.ends then return nil,'recall_window_ended'end
 local result=clone(row);result.remaining=row.ends-now;result.profile=c.profile.id;result.map=c.g.Game.mapID
 result.revision=c.observations.revision;result.observed=true;return result
end
function S:Recalls(enemyOnly)
 if not self:Alive()then return nil,'knowledge_scope_inactive'end
 local rows={};local n=0;local c=self.service.c
 for _,row in pairs(c.observations.recalls)do
  n=n+1;if n>32 then return nil,'recall_list_limit'end
  if not enemyOnly or row.team~=c.hero.team then local value=self:Recall(row.unit);if value then rows[#rows+1]=value end end
 end
 table.sort(rows,function(a,b)return a.id<b.id end);return rows
end
-- Units with a currently running recall, into a caller-owned buffer. Cheap when
-- nobody recalls: no allocation, no clone. Each unit is still revalidated by Recall.
local function byID(a,b)return tostring(U.id(a))<tostring(U.id(b))end
function S:RecallUnits(enemyOnly,out)
 if not self:Alive()or not self.recalls then return nil,'knowledge_scope_inactive'end
 local c=self.service.c;local now=c:now();local n=0;out=out or {}
 for _,row in pairs(c.observations.recalls)do
  if row.status=='started'and U.finite(row.ends)and now<row.ends and row.unit and(not enemyOnly or row.team~=c.hero.team)then
   n=n+1;out[n]=row.unit;if n>=32 then break end
  end
 end
 for i=#out,n+1,-1 do out[i]=nil end
 if n>1 then table.sort(out,byID)end
 return out
end
function S:Units(enemyOnly)
 if not self:Alive()then return nil,'knowledge_scope_inactive'end
  local c=self.service.c;local rows={}
  if c.observations.map~=c.g.Game.mapID then return rows end
 for index=1,math.min(32,#c.observations.heroes)do
  local unit=c.observations.heroes[index]
  if unit and unit.valid~=false and not unit.dead and(not enemyOnly or unit.team~=c.hero.team)then rows[#rows+1]=unit end
 end
 return rows
end
function S:Base(team)
 if not self:Alive()or not self.bases then return nil,'knowledge_scope_inactive'end
 local c=self.service.c;local value=c.observations.locations:Base(team)
 if not value then return nil,'native_base_unavailable'end
 return {pos=U.copy(value),team=team,map=c.g.Game.mapID,profile=c.profile.id,source='native_spawn_point'}
end
local function along(row,time)
 local distance=row.ms*time;local origin=U.copy(row.pos)
 for _,endpoint in ipairs(row.path or{})do
  local length=U.dist(origin,endpoint)
  if length>0 then
   if distance<=length then local t=distance/length;return {x=origin.x+(endpoint.x-origin.x)*t,y=origin.y,z=origin.z+(endpoint.z-origin.z)*t}end
   distance=distance-length;origin=endpoint
  end
 end
 return U.copy(origin)
end
function S:Predict(unit,horizon,options)
 if not U.finite(horizon)or horizon<0 or horizon>10 then return nil,'invalid_prediction_horizon'end
 local recall=self:Recall(unit)
 if recall and recall.positionKnown and horizon<recall.remaining then
  return {pos=recall.pos,uncertainty=recall.positionUncertainty or 0,source='observed_recall',
   fixedUntil=recall.ends,observationAt=recall.started,id=recall.id,handle=recall.handle,name=recall.name,estimated=true}
 end
 local row,why=self:LastSeen(unit,options and options.maxAge or .75);if not row then return nil,why end
 if not U.finite(row.ms)or row.ms<0 or row.ms>2000 or row.pathUnknown then return nil,'last_seen_motion_unknown'end
 local elapsed=row.age+horizon
 local maximum=math.max(600,row.ms*1.5)
 -- The last observed path is a hypothesis. The envelope allows a changed heading
 -- and starting movement after the last visible stationary observation.
 local predicted=along(row,elapsed)
 local confidence=options and options.confidence==true and U.finite(row.pathStableSince)
  and row.at-row.pathStableSince>=1 and row.age<=.15 and row.ms>0 and #row.path>0
 local uncertainty=confidence and maximum*row.age+row.ms*math.min(.15,horizon*.12)or maximum*elapsed
 return {pos=predicted,uncertainty=uncertainty,source='last_seen_path',observationAt=row.at,
  id=row.id,handle=row.handle,name=row.name,estimated=true,age=row.age,confidence=confidence and'high'or'normal',
  uncertaintyModel=confidence and'heuristic_stable_path_unseen_mobility_unknown'or'walking_envelope_unseen_mobility_unknown'}
end
function S:Health(unit,maxAge)
 local row,why=self:LastSeen(unit,maxAge or 1);if not row then return nil,why end
 if not U.finite(row.health)or row.health<=0 or not U.finite(row.maxHealth)or row.maxHealth<=0
  or not U.finite(row.hpRegen)or not U.finite(row.shieldAD)or not U.finite(row.shieldAP)then return nil,'observed_health_incomplete'end
 return {health=row.health,maxHealth=row.maxHealth,hpRegen=row.hpRegen,shieldAD=row.shieldAD,shieldAP=row.shieldAP,
  shieldAll=row.shieldAll,armor=row.armor,magicResist=row.magicResist,at=row.at,age=row.age,id=row.id,
  handle=row.handle,name=row.name,profile=row.profile,estimated=true}
end
function K:Sample(unit,row,previous)
 -- Called only for a visible, live observation by the one existing tracker.
 local path=unit.pathing;row.ms=U.finite(unit.ms)and unit.ms or nil
 for _,key in ipairs({'health','maxHealth','hpRegen','shieldAD','shieldAP','shieldAll','armor','magicResist'})do
  row[key]=U.finite(unit[key])and unit[key]or nil
 end
 row.path={};row.pathUnknown=false
 if path and path.isDashing then row.pathUnknown=true;return end
 if path and path.hasMovePath then
  local first,last=path.pathIndex,path.pathCount
  if not U.finite(first)or not U.finite(last)or first%1~=0 or last%1~=0 or first<0 or last<first or last-first>12 or not unit.GetPath then
   row.pathUnknown=true;return
  end
  for index=first,last do
   local ok,p=pcall(unit.GetPath,unit,index);p=ok and point(p)
   if not p then row.pathUnknown=true;row.path={};return end
   row.path[#row.path+1]=p
  end
 end
 local endpoint=row.path[#row.path]or row.pos
 local prior=previous and(previous.path and previous.path[#previous.path]or previous.pos)
  row.pathStableSince=current(unit,previous)and previous.map==row.map and previous.profile==row.profile and prior and U.dist(endpoint,prior)<=1
  and #row.path==#(previous.path or{})and previous.pathStableSince or row.at
end
return K

end
