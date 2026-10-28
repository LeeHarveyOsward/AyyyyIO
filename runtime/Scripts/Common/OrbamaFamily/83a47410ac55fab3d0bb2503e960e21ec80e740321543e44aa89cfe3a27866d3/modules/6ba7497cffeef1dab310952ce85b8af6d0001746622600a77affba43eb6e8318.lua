return function(require)
-- Area where a straight flight stops (catalogue `impact`, see docs/ORBAMA-EVADE.md
-- "Impact areas and anchored effects"). A flight with an impact explodes where it stops:
-- at the unit it collides with under its policy, else at its range end. One threat per
-- flight, id `<flight id>:impact`, of shape `compound`:
--
-- * predicted (the flight is still in the air): one part per possible stop. Every unit
--   that may meet the flight gives an interval of the line (evade.blockers.possibleStops),
--   the flight's own end (its range end, or its certain blocker) another. A circle impact
--   over an interval is the capsule its centre can sweep; a cone starts at the interval's
--   near end and is lengthened by the interval. Each part is active from the earliest
--   arrival at its near end to the latest arrival at its far end, plus delay and window.
--   At most `parts` parts (the last absorbs the rest). A new prediction that the published
--   one already covers (a shrinking reach, unchanged units) is not republished.
-- * observed: when the projectile is seen to disappear, the stop lies between its last
--   sample and how far it could fly since; that is the only part left when a predicted
--   part explains it (a possible stop or the range end). An unexplained disappearance
--   (fog, a wind wall, a stop outside the snapshot) adds that part to the prediction.
--
-- Recomputed once per scan from the flight's current row, flights in the order they were
-- first tracked; the unit snapshot is the shared evade.collision one. No host calls of its
-- own; parts reuse per-flight buffers.
local G=require('evade.geometry')
local B=require('evade.blockers')
local C=require('evade.collision')
local I={max=24,parts=4,linger=1,slack=1}
I.__index=I
local from,to={},{}
function I.new(threats)return setmetatable({threats=threats,tracked={},order={},count=0},I)end
-- Spec checks shared by the observer paths; nil,reason for anything incomplete.
function I.Valid(spec)
    if type(spec)~='table'then return nil,'invalid_impact'end
    local d,w=spec.delay or 0,spec.window or .15
    if not G.finite(d)or d<0 or d>10 or not G.finite(w)or w<0 or w>10 then return nil,'invalid_impact_timing'end
    if spec.shape=='circle'then
        if not G.finite(spec.radius)or spec.radius<=0 or spec.radius>2000 then return nil,'invalid_impact_radius'end
    elseif spec.shape=='cone'then
        if not G.finite(spec.range)or spec.range<=0 or spec.range>3000 or not G.finite(spec.halfAngle)
            or spec.halfAngle<=0 or spec.halfAngle>=math.pi/2 then return nil,'invalid_impact_cone'end
    else return nil,'invalid_impact_shape'end
    if spec.on~=nil and not B.policy(spec.on)then return nil,'invalid_impact_units'end
    return true
end
local function arrival(row,distance,launch)
    local early,late=G.travelTimeBounds(row,math.max(0,distance))
    if not G.finite(early)or not G.finite(late)then return nil end
    return launch+early,launch+late
end
local function place(p,key,x,y,z)
    local q=p[key];if not q then q={};p[key]=q end
    q.x,q.y,q.z=x,y,z
end
-- Part `index` of `list`: stop centres from o+d*a to o+d*b, active [starts,ends]. `span`
-- keeps those stop centres (a cone's apex range) for the coverage test.
local function part(list,index,spec,o,dx,dz,a,b,starts,ends)
    local p=list[index]
    if not p then p={span={}};list[index]=p end
    local ax,az,y=o.x+dx*a,o.z+dz*a,o.y or 0
    p.starts,p.ends=starts,ends
    place(p,'origin',ax,y,az)
    local s=p.span;s.ax,s.az,s.bx,s.bz=ax,az,o.x+dx*b,o.z+dz*b
    if spec.shape=='cone'then
        local length=spec.range+(b-a)
        p.shape='cone';p.radius=0;p.halfAngle=spec.halfAngle;p.length=length
        place(p,'b',ax+dx*length,y,az+dz*length)
    elseif b-a<1 then
        p.shape='circle';p.radius=spec.radius;p.b=nil;p.halfAngle=nil;p.length=nil
    else
        p.shape='line';p.radius=spec.radius;p.halfAngle=nil;p.length=nil
        place(p,'b',o.x+dx*b,y,o.z+dz*b)
    end
    return p
end
-- Distance from (x,z) to the segment of span s.
local function off(s,x,z)
    local vx,vz=s.bx-s.ax,s.bz-s.az;local d=vx*vx+vz*vz
    local t=d>0 and math.max(0,math.min(1,((x-s.ax)*vx+(z-s.az)*vz)/d))or 0
    local qx,qz=x-(s.ax+vx*t),z-(s.az+vz*t)
    return math.sqrt(qx*qx+qz*qz)
end
-- Every new part inside one published part of the same shape: its stop span within the
-- published span (same direction) and its time within the published time.
local function covered(new,count,old,oldCount)
    if count>oldCount then return false end
    for i=1,count do
        local n,hit=new[i],false
        for j=1,oldCount do
            local o=old[j]
            if(o.shape==n.shape or o.shape=='line'and n.shape=='circle')and n.starts>=o.starts and n.ends<=o.ends
                and off(o.span,n.span.ax,n.span.az)<=I.slack and off(o.span,n.span.bx,n.span.bz)<=I.slack
                -- A cone with its apex further along the same axis is inside while its far edge is.
                and(n.shape~='cone'or n.halfAngle==o.halfAngle and G.dist(o.origin,n.b)<=o.length+I.slack)then
                hit=true;break
            end
        end
        if not hit then return false end
    end
    return true
end
local function publish(self,observer,entry,count,source)
    local base=entry.base;local spec=entry.spec
    if count==0 then self.threats:Remove(entry.id);entry.published=nil;entry.shown=0;return end
    local parts={};local starts,ends=math.huge,-math.huge
    for i=1,count do
        local p=entry.parts[i];parts[i]=p
        starts=math.min(starts,p.starts);ends=math.max(ends,p.ends)
    end
    entry.shown=count
    local t={id=entry.id,instanceID=base.instanceID,stageID=entry.id,damageID=entry.damageID,casterID=base.casterID,
        profile=base.profile,evidence=base.evidence,ability=base.ability,abilityName=base.abilityName,champion=base.champion,
        source=base.source,shape='compound',parts=parts,radius=spec.radius or 0,origin=parts[1].origin,b=parts[count].b or parts[count].origin,
        starts=starts,ends=ends,observedAt=base.observedAt,blockable=not spec.separate and base.blockable or false,parryable=base.parryable,
        untargetableBlockable=base.untargetableBlockable,impact=true,impactSource=source,impactOf=entry.parent,
        timingScope=source=='predicted'and'predicted stops of the flight plus reviewed delay'or'observed stop of the flight plus reviewed delay',
        damage=entry.damage,cc=entry.cc,ccHard=entry.ccHard,ccUnknown=entry.ccUnknown,tier=entry.tier,zones=spec.zones}
    if G.valid(t)and observer.threats:Observe(t)then
        if not entry.published and observer.onThreat then observer.onThreat(t)end
        entry.published=true
    end
end
-- Effects of the impact: the flight's own (one hit, same identity) unless the row gives the
-- area its own damage, control, tier or zones (a separate hit).
local function effects(entry,row,spec)
    if not spec.separate then
        entry.damageID=row.damageID;entry.damage=row.damage
        entry.cc,entry.ccHard,entry.ccUnknown,entry.tier=row.cc,row.ccHard,row.ccUnknown,row.tier
        return
    end
    entry.damageID=tostring(row.damageID or row.id)..':impact'
    local damage=row.damage
    if spec.damageUnknown or type(damage)~='table'or not G.finite(spec.damage)or spec.damage==0 then
        entry.damage=nil -- unknown, or control only: the tier stands in
    else
        local scaled={};for k,v in pairs(damage)do scaled[k]=v end
        scaled.raw=(damage.raw or 0)*spec.damage;entry.damage=scaled
    end
    entry.cc,entry.ccHard,entry.ccUnknown=spec.cc,spec.ccHard,spec.ccUnknown
    entry.tier=spec.tier or row.tier
end
-- A published flight row that carries an impact (and/or a hit anchor, evade.anchors).
function I:Track(observer,row,spec,anchor,now)
    local entry=self.tracked[row.id]
    if not entry then
        if self.count>=I.max then return false end
        entry={id=row.id..':impact',parent=row.id,parts={},next={},shown=0}
        self.tracked[row.id]=entry;self.count=self.count+1;self.order[self.count]=entry
    end
    entry.spec=spec;entry.anchor=anchor;entry.base=row;entry.observed=row.evidence=='observed'
    if spec then effects(entry,row,spec)end
    entry.expires=math.max(entry.expires or 0,row.ends+(spec and(spec.delay or 0)+(spec.window or .15)or 0)+I.linger)
    entry.seenAt=now
    return true
end
-- The flight's live geometry from its current row, kept for the observed stop. Returns the
-- origin, direction and full length (nil when the row has no usable straight flight).
local function geometry(entry,row)
    local o,b=row.origin or row.a,row.unblockedB or row.b
    if row.shape~='missile'or row.motion or row.motionUnknown or not G.point(o)or not G.point(b)then return end
    local length=G.dist(o,b);if length<1 then return end
    local dx,dz=(b.x-o.x)/length,(b.z-o.z)/length
    local last=entry.lastPos or {};entry.lastPos=last;last.x,last.y,last.z=o.x,o.y or 0,o.z
    entry.lastAt=row.positionObservedAt or row.launch or row.starts;entry.dx,entry.dz=dx,dz
    entry.length=math.min(length,G.dist(o,row.b))
    entry.fastest=row.speedUncertain and row.maxSpeed or math.max(row.speed or 0,row.maxSpeed or 0,row.speedStep and row.speedStep.speed or 0)
    return o,b,dx,dz,length
end
-- Predicted stops of a flight still in the air, from its current row.
function I:Predict(observer,entry,row,now)
    local spec=entry.spec
    local o,b,dx,dz,length=geometry(entry,row)
    if not o then return end
    local launch=row.launch or row.starts
    local delay,window=spec.delay or 0,spec.window or .15
    -- The whole flight from its current position (a cast-derived row keeps the blocker it was
    -- clipped at when cast; the stop is found again here from this scan's units).
    local flight=entry.flight or {};entry.flight=flight
    flight.shape,flight.origin,flight.radius,flight.speed,flight.launch,flight.starts='missile',o,row.radius,row.speed,launch,row.starts
    flight.acceleration,flight.minSpeed,flight.maxSpeed,flight.speedUncertain=row.acceleration,row.minSpeed,row.maxSpeed,row.speedUncertain
    flight.speedStep=row.speedStep
    flight.b=b
    local units,n,team=nil,0,nil
    local policy=spec.on or row.collide
    if policy or row.collide then
        units,n=C.Units(observer)
        local caster=observer.heroes and observer.heroes[row.casterID]
        team=caster and caster.team or nil
    end
    if row.collide and n>0 then
        local stop=B.firstContact(flight,row.collide,units,n,now,team,C.options,observer.blockWork)
        if stop and stop<length then
            length=math.max(stop,1)
            local q=entry.stop or {};entry.stop=q
            q.x,q.y,q.z=o.x+dx*length,o.y or 0,o.z+dz*length;flight.b=q
        end
    end
    entry.length=math.min(entry.length,length)
    local count=0
    if policy and n>0 then
        count=B.possibleStops(flight,policy,units,n,now,team,C.options,observer.blockWork,from,to,I.parts-1)
    end
    local list,used=entry.next,0
    for i=1,count do
        local early=arrival(row,from[i],launch);local _,late=arrival(row,to[i],launch)
        if early and late then used=used+1;part(list,used,spec,o,dx,dz,from[i],to[i],early+delay,late+delay+window)end
    end
    if spec.atEnd~=false then
        local early,late=arrival(row,length,launch)
        if early then used=used+1;part(list,used,spec,o,dx,dz,length,length,early+delay,late+delay+window)end
    end
    -- The published prediction still holds every new stop: keep it (no revision, no redraw).
    -- Fewer stops (a unit gone) or one outside it: publish the new one.
    if entry.published and used==entry.shown and covered(list,used,entry.parts,entry.shown)then return end
    entry.next,entry.parts=entry.parts,list
    publish(self,observer,entry,used,'predicted')
end
-- The projectile disappeared: handled in the next Scan, in tracking order.
function I:Stopped(observer,parentID,now)
    local entry=self.tracked[parentID]
    if entry and entry.lastPos and not entry.stopped then entry.stopped=true;entry.stopAt=now end
end
-- Its stop lies between its last sample and as far as it could fly since (never past its end).
local function collapse(self,observer,entry)
    local now=entry.stopAt;entry.stopAt=nil
    local o=entry.lastPos;local reach=math.min(entry.length,entry.fastest*math.max(0,now-entry.lastAt))
    if entry.anchor and observer.anchored then observer.anchored:Hit(observer,entry,o,reach,now)end
    local spec=entry.spec
    -- A flight that passes through units (no stopping policy of its own) sets its impact off
    -- on the way; its end is not where that happened. The prediction keeps its own times.
    if not spec or not entry.observed or not entry.base.collide then return end
    -- Explained by a published part: a possible stop or the range end overlapping the stop span.
    local explained=false
    for i=1,entry.shown do
        local s=entry.parts[i].span
        local a=(s.ax-o.x)*entry.dx+(s.az-o.z)*entry.dz;local b=(s.bx-o.x)*entry.dx+(s.bz-o.z)*entry.dz
        if math.max(a,b)>=-1 and math.min(a,b)<=reach+1 then explained=true;break end
    end
    local count=explained and 1 or math.min(entry.shown+1,I.parts+1)
    part(entry.parts,count,spec,o,entry.dx,entry.dz,0,reach,entry.lastAt+(spec.delay or 0),now+(spec.delay or 0)+(spec.window or .15))
    publish(self,observer,entry,count,explained and'observed_stop'or'observed_stop_unexplained')
end
local function forget(self,index)
    local entry=self.order[index]
    self.tracked[entry.parent]=nil
    table.remove(self.order,index);self.count=self.count-1
end
-- Once per scan, after the missile pass: refresh flights in the air, settle stopped ones,
-- forget finished ones.
function I:Scan(observer,now)
    local index=1
    while index<=self.count do
        local entry=self.order[index];local parentID=entry.parent
        local row=self.threats.byID[parentID]
        local drop=false
        if now>entry.expires then drop=true
        elseif entry.stopAt then collapse(self,observer,entry)
        elseif row and not entry.stopped then
            if entry.spec then self:Predict(observer,entry,row,now)
            elseif entry.anchor then geometry(entry,row)end -- live geometry for a hit anchor alone
        elseif not row and not entry.observed and not entry.stopped and entry.seenAt<now and entry.base.ends>now then
            -- A cast-derived flight taken over by its projectile (or cancelled): the
            -- projectile carries its own impact under its own row.
            self.threats:Remove(entry.id);drop=true
        end
        if drop then forget(self,index)else index=index+1 end
    end
end
return I

end
