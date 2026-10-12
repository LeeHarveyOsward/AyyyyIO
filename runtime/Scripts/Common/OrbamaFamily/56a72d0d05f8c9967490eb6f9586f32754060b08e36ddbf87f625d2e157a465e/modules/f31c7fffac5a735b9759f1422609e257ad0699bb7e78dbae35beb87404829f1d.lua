return function(require)
-- Caster-attached zones. One generic kind for every "area around (or in front
-- of) the caster while it lasts": a reviewed catalog row (`aura`) names the own
-- buff that marks the effect, and the zone follows the caster while that buff is
-- observed (Judgment, Slicing Maelstrom, Aura of Despair, Glacial Storm ...).
-- `Follow` keeps a cast-derived zone on its caster the same way.
-- Possible contact only: tick phase and damage are not asserted. The zone is a
-- stationary sample of the caster's current position, grown by the distance the
-- caster can cover before the next sample.
local G=require('evade.geometry')
local A={};A.__index=A
A.interval=.1          -- buff sampling period (s) per caster with aura rows
A.reach=1500           -- casters farther than radius + reach are not sampled
A.maxBuffs=64;A.maxActive=16
A.linger=.35           -- a zone outlives one missed sample, never its buff expiry
function A.new(threats)return setmetatable({threats=threats,active={},count=0,followers={},nextAt={}},A)end
-- Lower-cased buff names -> aura row, built once per loaded champion set.
function A.Index(set)
    if set.__auraIndex~=nil then return set.__auraIndex end
    local index=false
    for _,r in pairs(set)do
        local a=type(r)=='table'and r.name and r.aura
        if a and(r.walkThreat or r.defensiveThreat)then
            index=index or {}
            for _,name in ipairs(a.buffs or {})do index[name:lower()]=r end
        end
    end
    set.__auraIndex=index;return index
end
local function facing(owner,origin,range)
    local dir=owner.dir
    if not G.point(dir)or(dir.x==0 and dir.z==0)then return nil end
    local n=math.sqrt(dir.x*dir.x+dir.z*dir.z)
    return {x=origin.x+dir.x/n*range,y=origin.y or 0,z=origin.z+dir.z/n*range}
end
local function publish(self,observer,owner,ownerID,record,expires,now)
    local a=record.aura;local pos=owner.pos
    if not G.point(pos)then return false end
    local id='aura:'..tostring(ownerID)..':'..record.name
    local row=self.active[id]
    if not row and self.count>=A.maxActive then return false end
    local origin=G.copy(pos)
    local speed=owner.ms;local slack=G.finite(speed)and speed>0 and math.min(60,speed*A.interval)or 0
    local t={id=id,instanceID=id,stageID=id,damageID=id,casterID=ownerID,profile=record.profile,evidence='observed',
        ability=record.id,abilityName=record.castAlias or record.name,champion=owner.charName,source=record.source,
        shape=a.shape or 'circle',origin=origin,b=origin,radius=(a.radius or 0)+slack,innerRadius=a.innerRadius,
        halfAngle=a.halfAngle,length=a.range,
        -- A known buff expiry is a stable end; an early removal retires the zone below.
        starts=row and row.starts or now,ends=expires or now+A.linger+A.interval,persistent=true,aura=true,
        observedAt=row and row.observedAt or now,blockable=false,parryable=false,untargetableBlockable=false,
        tier=record.tier,zonePolicy=a.zonePolicy,cc=record.cc,ccUnknown=record.ccUnknown,ccHard=record.ccHard,
        timingScope='caster-attached zone while the own buff is observed'}
    if t.shape~='circle'and t.shape~='ring'then
        local b=facing(owner,origin,a.range or 1)
        if not b then return false end
        t.b=b
        if a.originForward then
            local dx,dz=G.direction(origin,b)
            t.origin={x=origin.x+dx*a.originForward,y=origin.y,z=origin.z+dz*a.originForward}
            t.b={x=t.origin.x+dx*(a.range or 1),y=origin.y,z=t.origin.z+dz*(a.range or 1)}
        end
    end
    if not G.valid(t)or not observer.threats:Observe(t)then return false end
    if not row then
        row={starts=now,observedAt=now};self.active[id]=row;self.count=self.count+1
        if observer.onThreat then observer.onThreat(t)end
    end
    row.seen=now;return true
end
local function readBuff(owner,index)
    local b=owner:GetBuff(index)
    if not b or b.valid==false or type(b.name)~='string'or b.name==''then return nil end
    local count=b.count
    if G.finite(count)and count<=0 then return nil end
    local expires=b.expireTime
    if not G.finite(expires)or expires<=0 then expires=b.endTime end
    return b.name,G.finite(expires)and expires>0 and expires or nil
end
-- One pass per scan: casters with aura rows, near the player, at the sampling period.
function A:Scan(observer,now)
    local hero=observer.g.myHero.pos
    for _,owner in ipairs(observer.roster)do
        local set=observer.loaded[owner.charName]
        local index=set and A.Index(set)
        if index then
            local ownerID=owner.networkID or owner.handle
            if ownerID and now>=(self.nextAt[ownerID]or 0)then
                self.nextAt[ownerID]=now+A.interval
                local pos=owner.pos
                if owner.valid~=false and owner.visible~=false and not owner.dead and G.point(pos)and G.point(hero)
                    and G.dist(pos,hero)<=A.reach+(set.__auraReach or 600)then
                    local ok,count=pcall(function()return owner.buffCount end)
                    if ok and G.finite(count)and count>=0 then
                        observer.hostCalls=(observer.hostCalls or 0)+1
                        for i=0,math.min(count,A.maxBuffs)do
                            observer.hostCalls=observer.hostCalls+1
                            local read,name,expires=pcall(readBuff,owner,i)
                            local record=read and name and index[name:lower()]
                            if record and expires~=false and(not expires or expires>now)and observer:Allowed(owner,record)then
                                publish(self,observer,owner,ownerID,record,expires,now)
                            end
                        end
                    end
                end
            end
        end
    end
    for id,row in pairs(self.active)do
        if now-row.seen>A.linger then
            self.threats:Remove(id);self.active[id]=nil;self.count=self.count-1
        end
    end
    for id,f in pairs(self.followers)do
        local t=self.threats.byID[id]
        if not t or t.ends<now or f.owner.dead then self.followers[id]=nil
        elseif now>=t.starts then -- before it starts the zone is where it was cast (a blink may follow)
            local pos=f.owner.pos
            if G.point(pos)and G.dist(pos,t.origin)>5 then
                local moved=self.threats:Snapshot(id)
                moved.origin=G.copy(pos);moved.b=G.copy(pos)
                self.threats:Observe(moved)
            end
        end
    end
end
-- Keep a cast-derived caster-centred circle on its caster (catalog `cast.follow`).
function A:Follow(id,owner,spec)
    local t=self.threats.byID[id]
    if t and t.shape=='circle'then self.followers[id]={owner=owner}end
end
return A

end
