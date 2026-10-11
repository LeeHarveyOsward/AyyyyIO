return function(require)
-- One profile/map-bound observation owner. Consumers may keep route-local state,
-- but never manufacture camp deaths or transfer monster identities between camps.
local U=require('utils.util');local World=require('CombatProfiles.world')
local Timing=require('CombatProfiles.camp_timing')
local C={version=2};C.__index=C
local function identity(m)return U.id(m),m and m.handle,m and m.charName end
local function matches(m,r)
 local id,handle,name=identity(m)
 return id==r.id and handle==r.handle and name==r.name and m.team==300
end
local function remnant(m)return U.name(m and m.charName)=='srukrugminimini'end
local EMPTY={}
function C.new(app)return setmetatable({app=app,rows={},bindings={},revision=0,consumers={},generation=0},C)end
function C:Reset()
 self.rows={};self.bindings={};self.nativeDownUnreliable=nil;self.generation=self.generation+1;self.revision=self.revision+1;self.reconciledAt=nil
 self.map=self.app.g.Game.mapID;self.profile=self.app.profile.id
 local data=require(self.profile=='classic'and 'CombatProfiles.classic_camps'or 'CombatProfiles.normal_camps')
 if data.mapID~=self.map or data.mode~=self.profile then return end
 for _,anchor in ipairs(data.camps)do
  local id=tostring(self.map)..':'..self.profile..':'..tostring(anchor.team)..':'..anchor.name..':'..self.generation
  local timing=Timing[self.profile][anchor.category]
  self.rows[id]={id=id,layoutKey='map:'..anchor.name,name=anchor.name,category=anchor.category,team=anchor.team,pos=U.copy(anchor.pos),mapPos=U.copy(anchor.pos),
   map=self.map,profile=self.profile,instance=self.generation,spawnGeneration=0,state='unknown',availability='unknown',
   timing=timing,timerSource=timing and timing.source,estimated=not(timing and timing.verified),members={},knownMembers={},blockedUntil=0,fromMap=true}
  if self.profile=='classic'and anchor.name=='Camp_Order_Wraiths'then self.rows[id].walkPos={x=7443.1166992188,y=0,z=5663.0053710938}end
 end
 self.app.observations.camps=self.rows
 if self.app.farm then self.app.farm.known=self.rows end
end
function C:Current()
 if self.map~=self.app.g.Game.mapID or self.profile~=self.app.profile.id then self:Reset()end
 return self.rows
end
function C:Register(owner,active)
 if self.closed then return nil,'camp_service_closed'end
 if type(owner)~='string'or type(active)~='function'then return nil end
 self.consumers[owner]=active;local service=self;local scope={}
 function scope:Close()service.consumers[owner]=nil end
 function scope:Rows()local ok,yes=pcall(active);if not ok or not yes then return nil end;service:Refresh();return service:Current()end
 return scope
end
function C:Demand()
 if self.closed then return false end
 for owner,active in pairs(self.consumers)do local ok,yes=pcall(active);if ok and yes then return true end;if not ok then self.consumers[owner]=nil end end
 return false
end
function C:Safe(pos)
 if self.app:threats(pos,1000)>0 then return false end
 for _,turret in ipairs(self.app.observations.turrets or{})do
  if turret.team~=self.app.hero.team and turret.valid~=false and not turret.dead and U.dist(pos,turret.pos)<850+(turret.boundingRadius or 0)then return false end
 end
 return true
end
function C:Nearest(pos,category,radius)
 local best,distance=nil,radius or 900
 for _,r in pairs(self:Current())do
  if category==nil or category==r.category or category=='Camp'and not World.epics[r.category]then
   local d=math.min(U.dist(pos,r.mapPos),U.dist(pos,r.pos))
   if d<distance then best,distance=r,d end
  end
 end
 return best
end
function C:Down(r,at,precise)
 if self:Current()[r.id]~=r or r.awaitingRespawn then return end
 r.downAt=at;r.killedAt=at;r.killTimePrecise=precise==true;r.seenAlive=true;r.awaitingRespawn=true
 local duration=r.timing and r.timing.respawn
 r.expectedAt=at and duration and duration>0 and at+duration or nil
 r.state=at and 'empty_known'or 'empty_unknown';r.availability='observed_empty';r.at=self.app:now()
 r.layout=nil;r.focus=nil;r.blockedUntil=0;r.emptyUntil=nil;r.incomplete=nil
 -- The death is recorded on the row. Dead bindings are no longer reconciled;
 -- their identities stay rejected until a different identity respawns the camp.
 r.deadKeys=r.deadKeys or {}
 for key,b in pairs(r.knownMembers)do if b.dead then r.deadKeys[key]=true;self.bindings[key]=nil;r.knownMembers[key]=nil end end
 self.revision=self.revision+1
end
-- Coverage must describe the whole footprint and a complete current scan.
-- A projected point or a missing filtered snapshot is deliberately insufficient.
function C:ObserveCoverage(id,evidence)
 local r=self:Current()[id];local now=self.app:now()
 if not r or type(evidence)~='table'or evidence.map~=self.map or evidence.profile~=self.profile
  or evidence.instance~=r.instance or evidence.fullFootprint~=true or evidence.completeScan~=true
  or not U.finite(evidence.at)or now-evidence.at<0 or now-evidence.at>.2 then return false end
 if #r.members==0 and now>=(r.timing and r.timing.firstSpawn or 0)then
  r.emptyObservedAt=evidence.at
  if not r.awaitingRespawn then self:Down(r,nil,false)end
  return true
 end
 return false
end
-- A route reached the camp and found no current monster. This is not a death
-- and has no kill time: the camp died at an unknown moment no later than `at`,
-- so it is back no later than one respawn period from now. Until then it is
-- 'empty_unknown'; any living member observed earlier ends the interval.
function C:ObserveEmptyArrival(id,at)
 local r=self:Current()[id];local now=self.app:now()
 if not r or World.epics[r.category]or not U.finite(at)or at>now or now-at>.5 or #r.members>0 or r.awaitingRespawn then return false end
 if r.timing and r.timing.oneTime then return false end
 if r.timing and r.timing.firstSpawn and now<r.timing.firstSpawn then return false end
 local respawn=r.timing and r.timing.respawn
 if not U.finite(respawn)or respawn<=0 then respawn=60 end
 r.emptyObservedAt=at;r.emptyUntil=at+respawn;r.state='empty_unknown';r.availability='observed_empty'
 self.revision=self.revision+1
 return true
end
function C:ObserveObject(m)
 if not m or m.team~=300 or not U.valid(m)or not World.jungleEntity(m)then return false end
 local now=self.app:now();self.extra=self.extra or {}
 local id=U.id(m);local n,oldest,oldestAt=0,nil,math.huge
 for key,row in pairs(self.extra)do
  if now-row.at>.2 then self.extra[key]=nil
  else n=n+1;if key~=id and row.at<oldestAt then oldest,oldestAt=key,row.at end end
 end
 -- Bounded: a newer direct observation replaces the oldest retained one.
 if not self.extra[id]and n>=32 and oldest then self.extra[oldest]=nil end
 self.extra[id]={unit=m,at=now};self.extraSerial=(self.extraSerial or 0)+1;return true
end
-- A bound living member that now reads dead must be processed at once, even in
-- the same callback: a cheap field check over current bindings, no allocation.
function C:DeathPending()
 for _,b in pairs(self.bindings)do
  local m=b.unit
  if not b.dead and m and(m.dead==true or U.finite(m.health)and m.health<=0)then return true end
 end
 return false
end
-- Reconciliation runs once per clock value and object snapshot. Later consumers
-- in the same callback read the reconciled rows. A new snapshot, a direct
-- object observation or `force` reconciles again.
function C:Refresh(force)
 if self.closed then return {}end
 self:Current();local app=self.app;local now=app:now();local game=app.g.Game
 if force or now>=(self.scanAt or -1)then
  self.scanAt=now+.08
  if app.observations.minionsAt and now-app.observations.minionsAt<=.08 then self.objects=app.observations.minions
  else self.objects=app.observations:collect('Minion',4096);app.observations.minions=self.objects;app.observations.minionsAt=now end
  self.markers=app.observations:collect('Camp',128)
  -- Every scan is a new observation, even when a collector returns the same list.
  self.indexedObjects=nil
 end
 if self.objects~=self.indexedObjects then
  self.indexedObjects=self.objects;self.snapshotSerial=(self.snapshotSerial or 0)+1
  local current={};for _,m in ipairs(self.objects or {})do local id=U.id(m);if id then current[id]=m end end
  self.current=current
 end
 if not force and self.reconciledAt==now and self.reconciledSnapshot==self.snapshotSerial and self.reconciledExtra==self.extraSerial
  and not self:DeathPending()then
  self.reuses=(self.reuses or 0)+1;return self.rows
 end
 local newSnapshot=self.reconciledSnapshot~=self.snapshotSerial
 -- New identities and camp markers can only appear with a new object snapshot
 -- (every 80 ms) or a direct observation; bound members are reconciled every call.
 local admit=force or newSnapshot or self.reconciledExtra~=self.extraSerial
 self.reconciledAt=now;self.reconciledSnapshot=self.snapshotSerial;self.reconciledExtra=self.extraSerial
 self.reconciles=(self.reconciles or 0)+1
 local objects=self.objects or {};local current=self.current or {}
 if self.extra and next(self.extra)then
  local merged;local extended
  for id,row in pairs(self.extra)do if now-row.at>.2 then self.extra[id]=nil elseif not current[id]then
   if not merged then merged={};for i,m in ipairs(objects)do merged[i]=m end;extended={};for k,v in pairs(current)do extended[k]=v end end
   merged[#merged+1]=row.unit;extended[id]=row.unit
  end end
  if merged then objects=merged;current=extended end
 end
 for _,r in pairs(self.rows)do local members=r.members;for i=#members,1,-1 do members[i]=nil end end
 -- Reconcile each exact observed identity before admitting replacements.
 local hero=app.hero
 for key,b in pairs(self.bindings)do
  if not b.dead then
   local r=self.rows[b.camp];local m=current[b.id]
   -- A native lookup can only add information when the snapshot changed.
   if not m and newSnapshot and game.GetObjectByNetID then local ok,value=pcall(game.GetObjectByNetID,b.id);if ok then m=value end end
   if not m then m=b.unit end
   if not r or not matches(m,b)or U.dist(m.pos,r.mapPos)>1800 then
    self.bindings[key]=nil;if r then r.knownMembers[key]=nil;r.incomplete=true end
   elseif m.dead==true or U.finite(m.health)and m.health<=0 then
    b.dead=true;b.deadAt=now;b.witnessed=hero and U.dist(hero.pos,r.mapPos)<=1500 or false
    if self.profile=='normal'and r.category=='Krugs'and not remnant(m)then r.splitUntil=now+2 end
   elseif m.visible~=false and m.valid~=false and U.finite(m.health)and m.health>0 then
    b.unit=m;b.lastSeen=now;r.members[#r.members+1]=m
   end
  end
 end
 for _,m in ipairs(admit and objects or EMPTY)do
  if m.team==300 and World.jungleEntity(m)and U.valid(m)then
   local id,handle,name=identity(m);local key=tostring(id)..':'..tostring(handle)..':'..tostring(name)
   local b=self.bindings[key]
   if not b then
    local category=World.category(name)
    local r=self:Nearest(m.pos,category,self.profile=='classic'and 1100 or 1000)
    if not r and World.epics[category]then
     local instance=self.generation..':'..tostring(id)..':'..tostring(handle)
     local campID=tostring(self.map)..':'..self.profile..':0:'..category..':'..instance
     local timing=Timing[self.profile][category]
     r={id=campID,name=category,category=category,team=0,pos=U.copy(m.pos),mapPos=U.copy(m.pos),
      map=self.map,profile=self.profile,instance=instance,spawnGeneration=0,state='unknown',availability='unknown',
      timing=timing,timerSource=timing and timing.source,estimated=not(timing and timing.verified),members={},knownMembers={}}
     self.rows[campID]=r
    end
    if r and r.deadKeys and r.deadKeys[key]then r=nil end -- a dead identity never becomes a new spawn
    if r then
     local krugs=self.profile=='normal'and r.category=='Krugs'
     local tiny=krugs and remnant(m)
     -- Normal Krugs split when a larger Krug dies; those arrivals belong to the
     -- generation that is being cleared, never to a respawn.
     local split=krugs and not tiny and now<(r.splitUntil or 0)
     if r.awaitingRespawn and not tiny and not split then
      r.spawnGeneration=r.spawnGeneration+1;r.knownMembers={};r.incomplete=nil;r.deadKeys=nil
      for old,v in pairs(self.bindings)do if v.camp==r.id then self.bindings[old]=nil end end
      r.awaitingRespawn=false;r.expectedAt=nil;r.downAt=nil;r.killedAt=nil;r.emptyObservedAt=nil;r.seenCount=nil
     end
     b={id=id,handle=handle,name=name,camp=r.id,spawnGeneration=r.spawnGeneration,unit=m,lastSeen=now,split=split or nil}
     self.bindings[key]=b;r.knownMembers[key]=b;r.members[#r.members+1]=m
     r.seenCount=(r.seenCount or 0)+((tiny or split)and 0 or 1)
    end
   end
  end
 end
 for _,marker in ipairs(admit and self.markers or EMPTY)do
  if marker.pos then
   local r=self:Nearest(marker.pos,nil,self.profile=='classic'and 1100 or 650)
   if r then
    r.object=marker;r.nativeReportedUp=marker.isCampUp;r.nativeUp=marker.isCampUp;r.nativeAt=now
    if marker.isCampUp==false and #r.members>0 then r.markerUnreliable=true;self.nativeDownUnreliable=true end
    -- Markers never establish a death timestamp or erase a confirmed death.
   end
  end
 end
 for _,r in pairs(self.rows)do
  if self.nativeDownUnreliable and r.nativeUp==false then r.nativeUp=nil end
  local krugs=self.profile=='normal'and r.category=='Krugs'
  local allDead,originals,alive,last,hasDead,witnessed=true,0,0,nil,false,true
  for _,b in pairs(r.knownMembers)do
   if b.dead then hasDead=true end
   if not(b.split or krugs and remnant(b.unit))then
    originals=originals+1
    if not b.dead then allDead=false;alive=alive+1 else last=math.max(last or 0,b.deadAt);witnessed=witnessed and b.witnessed==true end
   end
  end
  local needed=r.timing and r.timing.members
  -- A dropped identity leaves this spawn incomplete. A complete living set of
  -- current identities is a new, fully bound generation.
  if r.incomplete and not r.awaitingRespawn and not hasDead and alive>=(needed or 1)then
   r.incomplete=nil;r.spawnGeneration=r.spawnGeneration+1
   for _,b in pairs(r.knownMembers)do b.spawnGeneration=r.spawnGeneration end
  end
  if originals>0 and allDead and not r.incomplete then
   if not needed or originals>=needed then self:Down(r,last,true)
   -- First seen part-cleared: every member we bound died in local view. The last
   -- observed death is a real observation, but the kill time is not certified.
   elseif witnessed and #r.members==0 then self:Down(r,last,false)end
  end
  if #r.members>0 then
   r.seenAlive=true;r.observedAt=now;r.at=now;r.emptyObservedAt=nil;r.emptyUntil=nil
   r.state=(r.awaitingRespawn or hasDead)and 'partial'or 'alive'
   r.availability=r.awaitingRespawn and 'clearing_remnants'or 'observed_alive'
   local main
   for _,m in ipairs(r.members)do
    if m.visible~=false and(not m.pathing or not m.pathing.hasMovePath)and m.health>=(m.maxHealth or m.health)
     and(m.maxHealth or 0)>=(r.aimHealth or 0)and(not main or (m.maxHealth or 0)>(main.maxHealth or 0)
      or m.maxHealth==main.maxHealth and tostring(U.id(m))<tostring(U.id(main)))then main=m end
   end
   if main then
    if not r.aimPos or U.dist(main.pos,r.aimPos)>1 then r.aimPos=U.copy(main.pos);r.walkPos=r.aimPos end
    r.aimHealth=main.maxHealth or 0
   end
   self:RememberLayout(r)
  elseif r.awaitingRespawn then
   r.availability='observed_empty';r.state=r.expectedAt and now>=r.expectedAt and 'expected_respawn'or r.downAt and 'empty_known'or 'empty_unknown'
  elseif r.emptyUntil and now<r.emptyUntil then r.state='empty_unknown';r.availability='observed_empty'
  else
   r.emptyUntil=nil
   if now-(r.observedAt or -math.huge)>1 then r.state='unknown';r.availability='unknown'end
  end
  local count=#r.members
  if r.seenState~=r.state or r.seenAvailability~=r.availability or r.seenMembers~=count or r.seenGeneration~=r.spawnGeneration then
   r.seenState,r.seenAvailability,r.seenMembers,r.seenGeneration=r.state,r.availability,count,r.spawnGeneration;self.changed=true
  end
 end
 -- Revision describes content: unchanged reconciliation keeps the same value.
 if self.changed then self.changed=nil;self.revision=self.revision+1 end
 app.observations.camps=self.rows
 if app.farm then app.farm.known=self.rows end
 return self.rows
end
function C:RememberLayout(camp)
    if #(camp.members or {})==0 then return end
    local c=self.app;local old=camp.layout;local unchanged=old and #old.rows==#camp.members
    if unchanged then for i,m in ipairs(camp.members)do local row=old.rows[i]
        if not U.valid(m)or row.unit~=m or row.health~=m.health or m.pathing and m.pathing.hasMovePath or U.dist(m.pos,row.pos)>1 then unchanged=false;break end
    end end
    if unchanged then old.at=c:now();return end
    local rows={}
    for _,m in ipairs(camp.members) do
        if not U.valid(m) or m.health<(m.maxHealth or m.health) or m.pathing and m.pathing.hasMovePath then
            camp.layout=nil;return
        end
        rows[#rows+1]={unit=m,pos=U.copy(m.pos),health=m.health,maxHealth=m.maxHealth,
            radius=m.boundingRadius or 45,at=c:now()}
    end
    camp.layout={rows=rows,at=c:now(),mode=c.profile.id,mapID=c.g.Game.mapID}
    local needed=camp.timing and camp.timing.members
    if #rows==needed then
        local saved={}
        for _,row in ipairs(rows) do saved[#saved+1]={pos=U.copy(row.pos),health=row.health,
            maxHealth=row.maxHealth,radius=row.radius,name=row.unit.charName} end
        camp.spawnLayout={rows=saved,at=c:now(),mode=c.profile.id,mapID=c.g.Game.mapID}
    end
end
function C:Formation(camp)
 if self:Current()[camp.id]~=camp then return end
 local recorded=require(self.profile=='classic'and 'CombatProfiles.classic_camp_formations'or 'CombatProfiles.normal_camp_formations')
 if recorded.mapID==self.map and recorded.mode==self.profile then
  local saved=recorded.camps[camp.layoutKey];return saved and saved.rows
 end
end
function C:Close()
 self.closed=true;self.consumers={};self.bindings={};self.extra={};self.objects=nil;self.markers=nil
end
function C:Snapshot()
 self:Current();local rows={}
 for _,r in pairs(self.rows)do rows[#rows+1]={id=r.id,category=r.category,pos=U.copy(r.pos),at=r.at,state=r.state,
  expectedAt=r.expectedAt,downAt=r.downAt,profile=self.profile,estimated=r.estimated,spawnGeneration=r.spawnGeneration,instance=r.instance}end
 return {at=self.app:now(),revision=self.revision,profile=self.profile,map=self.map,camps=rows}
end
function C:Anchors(origin,team)
 local rows={};for _,r in pairs(self:Current())do if not team or r.team==team then
  rows[#rows+1]={id=r.id,name=r.name,category=r.category,pos=U.copy(r.pos),team=r.team,distance=U.dist(origin,r.pos),state=r.state,profile=self.profile}
 end end
 table.sort(rows,function(a,b)return a.distance<b.distance end);return rows
end
return C

end
