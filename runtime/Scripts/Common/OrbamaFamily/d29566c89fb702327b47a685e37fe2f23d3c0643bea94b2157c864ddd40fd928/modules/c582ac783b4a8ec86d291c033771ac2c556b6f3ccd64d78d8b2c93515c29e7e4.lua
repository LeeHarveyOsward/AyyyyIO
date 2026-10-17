return function(require)
-- Caster-tracking returns and Irelia E blade segments (rows: tools/evade_returns.py).
-- A return homes on its caster's LIVE position, so its path is bounded, never
-- predicted exactly: every return threat is possible contact, not a certified hit.
-- Bound: a pursuer that always heads toward a point inside a convex set K stays in
-- the convex hull of its current position O and K. K is the disk the caster can
-- reach (speed x remaining flight), so the hull lies in the capsule from O to the
-- caster with that slack. Along the capsule the front is limited by the row's own
-- motion. An unattributable caster keeps only the physical reach of the missile.
local G=require('evade.geometry')
local R={};R.__index=R
local STALE=.1        -- position samples may lag one bounded host interval (observer stale-motion bound)
local MARGIN=.05      -- timing margin around own/live spawn windows
local CAP=4           -- flight horizon when no catch bound exists; rebuilt every tick while observed
local DASH_TOLERANCE=30
local LINK_DISTANCE=250
local PREDICTION_GRACE=.5 -- an unobserved predicted spawn stops warning this long after its window
local EPS=1e-3
local LIMIT={tracks=16,predictions=16,outbounds=32,groups=4,bladePredictions=4,casts=32,casters=64,misses=128}
function R.new()
    return setmetatable({tracks={},predictions={},outbounds={},casts={},casters={},groups={},blades={},
        bladePredictions={},count={tracks=0,predictions=0,outbounds=0,groups=0,bladePredictions=0,casts=0,casters=0},
        serial=0,work=0},R)
end
local function add(bucket,key,value)local row=bucket[key];if not row then row={};bucket[key]=row end;row[#row+1]=value end
-- One name index per loaded profile set; false when the profile has no rows.
function R.Index(set)
    local index=set.__returnIndex
    if index~=nil then return index end
    index={names={},casts={},misses={},missCount=0};local any=false
    local function name(key,entry)index.names[key]=entry;index.names[key:lower()]=entry end
    for key,r in pairs(set)do if type(r)=='table'and r.name then
        local rt=r.returnTracking
        if type(rt)=='table'then
            any=true;name(r.name,{kind='return',record=r})
            local spawn=rt.spawn
            if type(spawn)=='table'and spawn.anchor=='outbound_first_seen'and type(rt.outbound)=='string'then
                local entry=index.names[rt.outbound]
                if not entry then entry={kind='outbound',records={}};name(rt.outbound,entry)end
                if entry.kind=='outbound'then entry.records[#entry.records+1]=r end
            elseif type(spawn)=='table'and spawn.anchor=='cast'and type(spawn.cast)=='string'then
                add(index.casts,spawn.cast:lower(),r)
            end
        end
        local sm=r.segmentModel
        if type(sm)=='table'then
            any=true;name(r.name,{kind='segment',record=r})
            for _,join in ipairs(sm.joins or {})do name(join,{kind='segment',record=r})end
            if type(sm.anchor)=='table'and type(sm.anchor.blade)=='string'then name(sm.anchor.blade,{kind='blade',record=r})end
        end
    end end
    if not any then index=false end
    set.__returnIndex=index
    return index
end
-- Exact names first; a bounded miss cache keeps other missiles of these profiles allocation-free.
local function lookup(index,name)
    if type(name)~='string'then return end
    local entry=index.names[name]
    if entry or index.misses[name]then return entry end
    entry=index.names[name:lower()]
    if not entry and index.missCount<LIMIT.misses then index.misses[name]=true;index.missCount=index.missCount+1 end
    return entry
end
local function overflow(o,now,untilTime)
    o.threats.overflow=true
    o.threats.overflowUntil=math.max(o.threats.overflowUntil or 0,untilTime or now+.5)
end
-- Live caster evidence, read once per scan. A displacement faster than walking is
-- a dash: the next model is rebuilt from the new position with the observed speed.
function R:Caster(owner,now)
    local id=owner.networkID or owner.handle
    local c=self.casters[id]
    if not c then
        if self.count.casters>=LIMIT.casters then return nil end
        c={};self.casters[id]=c;self.count.casters=self.count.casters+1
    end
    if c.at==now then return c end
    c.at=now;c.dead=owner.dead==true
    local ms=owner.ms;c.ms=G.finite(ms)and ms>0 and ms or nil
    local pos=owner.pos
    local visible=owner.visible~=false and owner.valid~=false and G.point(pos)
    -- A corpse does not move; its reported position stays usable while dead.
    if visible or c.dead and G.point(pos)then
        if c.seenPos and now>c.seenAt then
            local dt=now-c.seenAt;local jump=G.dist(c.seenPos,pos)
            if jump>(c.ms or 0)*dt+DASH_TOLERANCE then
                c.dashSpeed=jump/dt;c.dashUntil=now+.25;c.dashes=(c.dashes or 0)+1
            end
        end
        local pathing=owner.pathing
        c.dashing=pathing~=nil and pathing.isDashing==true
        if c.seenPos then c.seenPos.x,c.seenPos.y,c.seenPos.z=pos.x,pos.y or 0,pos.z else c.seenPos=G.copy(pos)end
        c.seenAt=now
    end
    c.visible=visible
    return c
end
-- Upper bound on caster speed for the remaining flight; nil means unbounded.
local function casterBound(c,now)
    if not c then return nil end
    if c.dead then return 0 end
    if not c.visible or not c.ms or c.dashing then return nil end
    local v=c.ms
    if c.dashSpeed and c.dashUntil and now<=c.dashUntil then v=math.max(v,c.dashSpeed)end
    return v
end
-- Own motion from a speed at least the current one (speed is nondecreasing).
local function motion(rt,elapsed,out)
    out=out or {}
    if rt.speed then out.speed=rt.speed;out.acceleration=nil;out.minSpeed=nil;out.maxSpeed=nil;return out end
    out.speed=math.min(rt.maxSpeed,math.max(rt.minSpeed,rt.initialSpeed+rt.acceleration*math.max(0,elapsed)))
    out.acceleration=rt.acceleration;out.minSpeed=rt.minSpeed;out.maxSpeed=rt.maxSpeed
    return out
end
-- Latest time at which a pursuer starting `distance` away still flies: the gap
-- closes at least as fast as own travel minus caster speed. Convex gain, so the
-- first crossing is a monotone predicate; 24 halvings bound the work.
local function catch(model,distance,caster,self)
    if distance<=0 then return 0,true end
    if not model.acceleration or model.acceleration==0 then
        local closing=model.speed-caster
        if closing<=0 or distance/closing>CAP then return CAP,false end
        return distance/closing,true
    end
    if G.travel(model,CAP)-caster*CAP<distance then return CAP,false end
    local lo,hi=0,CAP
    for _=1,24 do
        local mid=(lo+hi)*.5
        if G.travel(model,mid)-caster*mid>=distance then hi=mid else lo=mid end
    end
    self.work=self.work+24
    return hi,true
end
-- Linear front bound over [0,span]: the chord of a convex travel curve.
local function front(model,span)
    if span<=0 then return model.speed end
    return math.max(model.speed,G.travel(model,span)/span)
end
-- Capsule toward the caster with endpoint slack; the rear stays at the sampled origin.
local function envelope(origin,target,radius,launch,starts,ends,speed)
    local b=target;local length=G.dist(origin,target)
    if length<1 then b={x=origin.x+1,y=origin.y or 0,z=origin.z};length=1 end
    local span=math.max(ends-launch,EPS)
    return {shape='missile',origin=origin,b=b,radius=radius+1,speedUncertain=true,
        minSpeed=math.min(EPS,length/span),maxSpeed=math.max(speed,EPS),launch=launch,starts=starts,ends=ends}
end
-- Unknown endpoint: the missile's own reachable disk, growing with its front bound.
local function reach(origin,radius,launch,starts,ends,speed)
    local span=math.max(ends-launch,EPS);local initial=radius+1;local final=initial+speed*span
    return {shape='circle',origin=origin,radius=final,contactPossible=true,
        radiusTransition={initial=initial,final=final,starts=launch,ends=launch+span},starts=starts,ends=ends}
end
local function threatBase(o,owner,record,id,damageID,instanceID,evidence)
    return {id=id,instanceID=instanceID,stageID=id,damageID=damageID,casterID=owner.networkID or owner.handle,
        profile=record.profile,evidence=evidence,ability=record.id,abilityName=record.name,champion=owner.charName,
        source=record.source,shape='compound',radius=record.returnTracking.width,blockable=false,
        cc=record.cc,ccUnknown=record.ccUnknown,ccHard=record.ccHard,damage=o:Damage(owner,record)}
end
-- Geometry for a return flying from `origin`. `launch`: earliest possible sample or
-- spawn time (front bound origin). `flightStart`: time from which the catch bound counts
-- (the latest spawn for a pending prediction). `wait`: caster motion allowed before then.
function R:Shape(threat,rt,c,now,origin,launch,flightStart,model,endpoint,wait)
    local vc=casterBound(c,now);local target=endpoint;local mode='fixed_point'
    if target then vc=0
    elseif vc and c.seenPos then
        target=c.seenPos;mode=vc==0 and 'dead_caster'or 'owner'
    end
    local width=rt.width;local starts=math.max(now,launch)
    local rows={rebuilds=c and c.dashes or 0}
    if target then
        local flight,bounded=catch(model,G.dist(origin,target)+vc*(wait or 0),vc,self)
        local ends=math.max(flightStart,starts)+flight
        -- Caster motion since the earliest sample/spawn the envelope may represent.
        local slack=vc*(ends-math.min(now,launch))
        threat.parts={envelope(G.copy(origin),G.copy(target),width+slack,launch,starts,ends,front(model,ends-launch))}
        threat.b=G.copy(target)
        rows.mode=mode;rows.casterSpeed=vc;rows.slack=slack;rows.flightBound=flight;rows.bounded=bounded
        rows.dash=c and c.dashUntil~=nil and now<=c.dashUntil or nil
        threat.starts,threat.ends=starts,ends
    else
        local ends=math.max(flightStart,starts)+CAP
        threat.parts={reach(G.copy(origin),width,launch,starts,ends,front(model,ends-launch))}
        threat.b=c and c.seenPos and G.copy(c.seenPos)or G.copy(origin);threat.endpointUncertain=true
        rows.mode='endpoint_uncertain';rows.flightBound=CAP;rows.bounded=false
        rows.reason=not c and 'caster_unattributed'or c.dashing and 'caster_dashing'
            or not c.visible and 'caster_not_visible'or 'caster_speed_unknown'
        threat.starts,threat.ends=starts,ends
    end
    threat.returnTracking=rows;threat.origin=G.copy(origin)
    return threat
end
function R:Publish(o,threat,fresh)
    local accepted=o.threats:Observe(threat)
    if accepted and fresh and o.onThreat then o.onThreat(threat)end
    return accepted
end
-- An own-profile return aimed at its caster. A reviewed stage may also accept
-- native target=0 when live evidence shows the host omits its caster target.
-- Other targets stay with the ordinary observer.
function R:Return(o,owner,record,m,d,now,key)
    local rt=record.returnTracking;local dead=rt.deadVariantOf~=nil
    local target=d.target
    local toCaster=target~=nil and target~=0 and(target==owner.networkID or target==owner.handle)
    local zeroTargetOwner=target==0 and rt.zeroTargetOwner==true and not dead
    if not toCaster and not zeroTargetOwner and not(dead and target==0 and G.point(d.endPos))then return false end
    if not G.point(m.pos)then return false end
    local id='return:missile:'..tostring(key);local ownerID=owner.networkID or owner.handle
    local t=self.tracks[id]
    if t and(t.owner~=ownerID or t.stage~=record.name)then
        o.threats:Remove(id);self.tracks[id]=nil;self.count.tracks=self.count.tracks-1;t=nil
    end
    if not o:Allowed(owner,record)then
        if t then o.threats:Remove(id);self.tracks[id]=nil;self.count.tracks=self.count.tracks-1 end
        return true
    end
    local fresh=false
    if not t then
        if m.valid==false then return true end -- a stale wrapper cannot start a track
        if self.count.tracks>=LIMIT.tracks then overflow(o,now);return true end
        t={owner=ownerID,stage=record.name,firstAt=now,model={}}
        local pid,p=self:Link(ownerID,record.name,m.pos,now)
        if p then
            o.threats:Remove(pid);self.predictions[pid]=nil;self.count.predictions=self.count.predictions-1
            t.damageID,t.instanceID,t.spawnAt=p.damageID,p.instanceID,p.sE
        else t.damageID,t.instanceID=id,id end
        self.tracks[id]=t;self.count.tracks=self.count.tracks+1;fresh=true
    end
    t.at=now
    local c=self:Caster(owner,now)
    -- Upper bound on age: the object can precede its first sample by one stale interval.
    local model=motion(rt,now-math.min(t.spawnAt or math.huge,t.firstAt-STALE),t.model)
    local threat=threatBase(o,owner,record,id,t.damageID,t.instanceID,'observed')
    -- The dead variant flies to a fixed point: the corpse it targets or its native endpoint.
    local endpoint
    if dead then
        endpoint=toCaster and c and c.seenPos or d.endPos
        if not G.point(endpoint)then endpoint=G.point(d.endPos)and d.endPos or nil end
        if not endpoint then
            o.threats:Remove(id);self.tracks[id]=nil;self.count.tracks=self.count.tracks-1;return false
        end
    end
    self:Shape(threat,rt,c,now,m.pos,now-STALE,now,model,endpoint,0)
    threat.returnTracking.stage=record.name;threat.returnTracking.linked=t.spawnAt~=nil
    self:Publish(o,threat,fresh)
    return true
end
function R:Link(ownerID,stage,pos,now)
    local best,bestID,distance
    for pid,p in pairs(self.predictions)do
        -- An early object still is this leg: one identity, never a duplicate warning.
        if p.owner==ownerID and p.record.name==stage and now<=p.expires then
            local gap=G.dist(p.origin,pos)
            if gap<=LINK_DISTANCE and(not distance or gap<distance)then best,bestID,distance=p,pid,gap end
        end
    end
    return bestID,best
end
function R:Predict(o,owner,record,pid,origin,sE,sL,instanceID)
    if self.predictions[pid]then return self.predictions[pid]end
    if self.count.predictions>=LIMIT.predictions then overflow(o,sL);return end
    if not o:Allowed(owner,record)then return end
    local p={owner=owner.networkID or owner.handle,hero=owner,record=record,origin=G.copy(origin),sE=sE,sL=sL,
        expires=sL+PREDICTION_GRACE,damageID=pid,instanceID=instanceID or pid,fresh=true,model={}}
    self.predictions[pid]=p;self.count.predictions=self.count.predictions+1
    return p
end
-- Outbound flights anchor an early return warning at their own endpoint.
function R:Outbound(o,owner,records,m,d,now,key)
    local ob=self.outbounds[key];local ownerID=owner.networkID or owner.handle
    if ob and ob.owner~=ownerID then self.outbounds[key]=nil;self.count.outbounds=self.count.outbounds-1;ob=nil end
    if not ob then
        if self.count.outbounds>=LIMIT.outbounds then overflow(o,now);return end
        ob={owner=ownerID,records=records,firstAt=now,hero=owner}
        self.outbounds[key]=ob;self.count.outbounds=self.count.outbounds+1
    end
    ob.at=now
    if G.point(d.endPos)then
        if ob.native then ob.native.x,ob.native.y,ob.native.z=d.endPos.x,d.endPos.y or 0,d.endPos.z else ob.native=G.copy(d.endPos)end
    end
end
function R:Cast(o,owner,spell,now)
    -- Spell-state checks first: an idle caster (most heroes, most ticks) needs no team reads.
    if spell.valid==false or spell.isStopped==true or type(spell.name)~='string'or owner.team==o.g.myHero.team then return end
    local set=o.loaded[owner.charName];local index=set and R.Index(set)
    if not index then return end
    local rows=index.casts[spell.name:lower()]
    if not rows then return end
    local start=spell.startTime
    if not G.finite(start)or start<=0 then start=spell.castStartTime end
    if not G.finite(start)or start<=0 or start>now+.1 or now-start>2 then return end
    local finish=spell.castEndTime
    if not G.finite(finish)or finish<start then finish=start end
    local ownerID=owner.networkID or owner.handle
    local key=tostring(ownerID)..':'..tostring(start)
    if self.casts[key]then return end
    if self.count.casts>=LIMIT.casts then overflow(o,now);return end
    self.casts[key]=start+5;self.count.casts=self.count.casts+1
    local origin=G.point(spell.startPos)and spell.startPos or owner.pos
    if not G.point(origin)then return end
    for _,record in ipairs(rows)do
        local spawn=record.returnTracking.spawn
        self:Predict(o,owner,record,'return:predicted:cast:'..key..':'..record.name,origin,
            start+spawn.min-MARGIN,finish+spawn.max+MARGIN,'cast:'..key)
    end
end
-- Irelia E: collinear converging carriers of one owner form ONE stationary segment.
function R:Segment(o,owner,record,m,d,now,key)
    if d.target~=nil and d.target~=0 then return false end
    local finish=d.endPos;local start=G.point(d.startPos)and d.startPos or m.pos
    if not G.point(finish)or not G.point(start)then return false end
    if not o:Allowed(owner,record)then return true end
    local ownerID=owner.networkID or owner.handle;local group
    for _,g in pairs(self.groups)do
        if g.owner==ownerID and g.record==record then
            local a=g.origin
            local sa=math.abs((start.x-a.x)*g.dz-(start.z-a.z)*g.dx)
            local sb=math.abs((finish.x-a.x)*g.dz-(finish.z-a.z)*g.dx)
            if sa<=40 and sb<=40 then group=g;break end
        end
    end
    if not group then
        if self.count.groups>=LIMIT.groups then overflow(o,now);return true end
        local dx,dz=G.direction(start,finish)
        self.serial=self.serial+1
        local id='segment:'..tostring(ownerID)..':'..self.serial
        group={id=id,owner=ownerID,record=record,origin=G.copy(start),dx=dx,dz=dz,lo=0,hi=0,firstAt=now,hero=owner,
            damageID=id,instanceID=id,fresh=true}
        -- The anchored prediction becomes this observed segment's identity.
        for pid,p in pairs(self.bladePredictions)do
            if p.owner==ownerID and math.abs(p.dx*dx+p.dz*dz)>=.95
              and math.abs((start.x-p.a.x)*p.dz-(start.z-p.a.z)*p.dx)<=60 then
                group.damageID,group.instanceID,group.linked=p.damageID,p.damageID,true
                o.threats:Remove(pid);self.bladePredictions[pid]=nil;self.count.bladePredictions=self.count.bladePredictions-1
                break
            end
        end
        self.groups[id]=group;self.count.groups=self.count.groups+1
    end
    local function extend(p)
        local along=(p.x-group.origin.x)*group.dx+(p.z-group.origin.z)*group.dz
        if along<group.lo then group.lo=along end
        if along>group.hi then group.hi=along end
    end
    extend(start);extend(finish)
    group.at=now
    return true
end
-- Remember the first blade; the second blade within its own recast window predicts the segment.
function R:Blade(o,owner,record,m,d,now,key)
    if not G.point(d.endPos)then return end
    local anchor=record.segmentModel.anchor;local ownerID=owner.networkID or owner.handle
    local b=self.blades[ownerID]
    if b and b.key==key then return end
    local blade={key=key,endpoint=G.copy(d.endPos),arrival=now+anchor.bladeTravel}
    if b and not b.paired and now<=b.arrival+anchor.window+.1 and G.dist(b.endpoint,blade.endpoint)>=1
      and o:Allowed(owner,record)and self.count.bladePredictions<LIMIT.bladePredictions then
        local dx,dz=G.direction(b.endpoint,blade.endpoint);local over=anchor.overshoot[2]+10
        self.serial=self.serial+1
        local pid='segment:predicted:'..tostring(ownerID)..':'..self.serial
        self.bladePredictions[pid]={owner=ownerID,record=record,hero=owner,dx=dx,dz=dz,
            a={x=b.endpoint.x-dx*over,y=b.endpoint.y,z=b.endpoint.z-dz*over},
            b={x=blade.endpoint.x+dx*over,y=blade.endpoint.y,z=blade.endpoint.z+dz*over},
            starts=now,ends=now+anchor.particleDelay[2]+.1,damageID=pid,fresh=true}
        self.count.bladePredictions=self.count.bladePredictions+1
        blade.paired=true
    end
    self.blades[ownerID]=blade
end
function R:Missile(o,owner,set,m,d,now)
    local index=R.Index(set)
    if not index then return false end
    local entry=lookup(index,m.name)or lookup(index,d.name)
    if not entry then return false end
    local key=m.networkID or m.handle
    if not key then return false end
    if entry.kind=='return'then return self:Return(o,owner,entry.record,m,d,now,key)end
    if entry.kind=='segment'then return self:Segment(o,owner,entry.record,m,d,now,key)end
    if entry.kind=='outbound'then self:Outbound(o,owner,entry.records,m,d,now,key)
    elseif entry.kind=='blade'then self:Blade(o,owner,entry.record,m,d,now,key)end
    return false
end
local function rectangle(o,owner,record,id,damageID,a,b,starts,ends,evidence)
    local length=G.dist(a,b)
    if length<1 then local dx,dz=G.direction(a,b);b={x=a.x+dx,y=a.y,z=a.z+dz};length=1 end
    return {id=id,instanceID=damageID,stageID=id,damageID=damageID,casterID=owner.networkID or owner.handle,
        profile=record.profile,evidence=evidence,ability=record.id,abilityName=record.name,champion=owner.charName,
        source=record.source,shape='rectangle',origin=a,b=b,length=length,radius=record.segmentModel.radius,
        starts=starts,ends=ends,blockable=false,cc=record.cc,ccUnknown=record.ccUnknown,ccHard=record.ccHard,
        damage=o:Damage(owner,record),segmentModel=true}
end
-- After a complete missile pass: retire absent objects, publish predictions and segments.
function R:Finish(o,now)
    for id,t in pairs(self.tracks)do
        if t.at~=now then o.threats:Remove(id);self.tracks[id]=nil;self.count.tracks=self.count.tracks-1 end
    end
    for key,ob in pairs(self.outbounds)do
        if ob.at==now then
            local seen=o.seen['missile:'..tostring(key)]
            local endpoint=seen and seen.owner and G.point(seen.endpoint)and seen.endpoint or ob.native
            if endpoint then
                for _,record in ipairs(ob.records)do
                    local spawn=record.returnTracking.spawn
                    local p=self:Predict(o,ob.hero,record,'return:predicted:'..tostring(key)..':'..record.name,endpoint,
                        ob.firstAt+spawn.min-MARGIN,ob.firstAt+spawn.max+MARGIN,seen and seen.instanceID)
                    -- The outbound endpoint can be revised while that flight is observed.
                    if p then p.origin.x,p.origin.y,p.origin.z=endpoint.x,endpoint.y or 0,endpoint.z end
                end
            end
        elseif now>ob.firstAt+5 then self.outbounds[key]=nil;self.count.outbounds=self.count.outbounds-1 end
    end
    for pid,p in pairs(self.predictions)do
        local hero=o.heroes[p.owner]
        if now>p.expires then
            o.threats:Remove(pid);self.predictions[pid]=nil;self.count.predictions=self.count.predictions-1
        else
            local rt=p.record.returnTracking
            local live=hero==p.hero and hero or nil;local c=live and self:Caster(live,now)
            local threat=threatBase(o,p.hero,p.record,pid,p.damageID,p.instanceID,'cast-derived')
            -- Pending: the caster may move until the latest spawn and the flight bound counts
            -- from there. Overdue: it may have moved since the earliest spawn; count from now.
            local pending=now<=p.sL
            local model=motion(rt,0,p.model)
            self:Shape(threat,rt,c,now,p.origin,p.sE,pending and p.sL or now,model,nil,pending and p.sL-now or now-p.sE)
            threat.returnTracking.predicted=true;threat.returnTracking.stage=p.record.name
            threat.returnTracking.spawnEarliest=p.sE;threat.returnTracking.spawnLatest=p.sL
            if self:Publish(o,threat,p.fresh)then p.fresh=false end
        end
    end
    for id,g in pairs(self.groups)do
        if g.at~=now then o.threats:Remove(id);self.groups[id]=nil;self.count.groups=self.count.groups-1
        else
            local a={x=g.origin.x+g.dx*g.lo,y=g.origin.y,z=g.origin.z+g.dz*g.lo}
            local b={x=g.origin.x+g.dx*g.hi,y=g.origin.y,z=g.origin.z+g.dz*g.hi}
            local threat=rectangle(o,g.hero,g.record,id,g.damageID,a,b,g.firstAt,now+g.record.segmentModel.lease,'observed')
            threat.segmentLinked=g.linked
            if self:Publish(o,threat,g.fresh)then g.fresh=false end
        end
    end
    for pid,p in pairs(self.bladePredictions)do
        if now>p.ends then o.threats:Remove(pid);self.bladePredictions[pid]=nil;self.count.bladePredictions=self.count.bladePredictions-1
        else
            local threat=rectangle(o,p.hero,p.record,pid,p.damageID,p.a,p.b,p.starts,p.ends,'cast-derived')
            threat.segmentPredicted=true
            if self:Publish(o,threat,p.fresh)then p.fresh=false end
        end
    end
    for key,expires in pairs(self.casts)do if now>expires then self.casts[key]=nil;self.count.casts=self.count.casts-1 end end
    for id,b in pairs(self.blades)do
        if now>b.arrival+10 then self.blades[id]=nil end
    end
    for id,c in pairs(self.casters)do
        if now-c.at>10 then self.casters[id]=nil;self.count.casters=self.count.casters-1 end
    end
end
return R

end
