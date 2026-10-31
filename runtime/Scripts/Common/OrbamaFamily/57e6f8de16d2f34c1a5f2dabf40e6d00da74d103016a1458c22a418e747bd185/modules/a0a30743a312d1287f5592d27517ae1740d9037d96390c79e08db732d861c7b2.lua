return function(require)
-- Areas anchored on a game unit or object (catalogue `anchored`, see docs/ORBAMA-EVADE.md
-- "Impact areas and anchored effects"). The area's centre is the anchor's live position,
-- refreshed every scan; it never moves on a guess. Selectors:
--
-- * `target`: the cast's own native target (an enemy champion of the player, an ally of
--   the player, or the player). The cast-derived area follows it; an unresolved target
--   removes the area (unknown anchor: no threat).
-- * `near`:   the first unit that comes within `stick` of the cast-derived area's centre
--   once the area is active (a bomb that sticks). Until then the area stays where it
--   landed (the ground is the real fallback); afterwards it follows that unit.
-- * `object`: the caster's own object with one of the listed names nearest to the area's
--   centre at the cast (within `leash` of the caster); none: no threat.
-- * `hit`:    the unit a straight flight was observed to stop on (evade.impacts reports the
--   stop). A new circle (`radius`, from the stop plus `delay`, for `window`) follows it.
--   A stop that no unit explains, or the player as the unit, publishes nothing (the
--   flight's own hit already carries its effect on the player).
--
-- An anchor that dies, becomes invalid or invisible takes its area with it. Bounded: at
-- most `max` live anchors; one position read per anchor per scan.
local G=require('evade.geometry')
local C=require('evade.collision')
local A={max=16,leash=2000,slack=50}
A.__index=A
function A.new(threats)return setmetatable({threats=threats,entries={},order={},count=0},A)end
function A.Valid(spec)
    if type(spec)~='table'then return nil,'invalid_anchor'end
    local unit=spec.unit
    if unit=='near'then
        if not G.finite(spec.stick)or spec.stick<=0 or spec.stick>1000 then return nil,'invalid_anchor_stick'end
    elseif unit=='object'then
        if type(spec.objects)~='table'or #spec.objects<1 or #spec.objects>8 then return nil,'invalid_anchor_objects'end
    elseif unit=='hit'then
        if not G.finite(spec.radius)or spec.radius<=0 or spec.radius>2000 then return nil,'invalid_anchor_radius'end
        local d,w=spec.delay or 0,spec.window or .15
        if not G.finite(d)or d<0 or d>10 or not G.finite(w)or w<0 or w>10 then return nil,'invalid_anchor_timing'end
    elseif unit~='target'then return nil,'invalid_anchor_unit'end
    return true
end
local function usable(u)
    return u and u.valid~=false and not u.dead and u.visible~=false and G.point(u.pos)
end
local function same(u,id)return u and id~=nil and id~=0 and(u.networkID==id or u.handle==id)end
-- A champion by native id: the enemy roster index, the player's allies, the player.
local function champion(observer,id)
    if id==nil or id==0 then return nil end
    local u=observer.heroes and observer.heroes[id]
    if u then return u end
    for _,ally in ipairs(observer.allies or {})do if same(ally,id)then return ally end end
    local me=observer.g.myHero
    if same(me,id)then return me end
end
-- Entries are kept in the order they were anchored: one scan's updates never depend on
-- table iteration order.
local function track(self,id,entry)
    local prior=self.entries[id]
    entry.id=id
    if prior then
        for i=1,self.count do if self.order[i]==prior then self.order[i]=entry;break end end
    else
        if self.count>=A.max then return false end
        self.count=self.count+1;self.order[self.count]=entry
    end
    self.entries[id]=entry;return true
end
-- Move a published area onto its anchor's position (only when it moved).
local function follow(self,id,pos,radius)
    local row=self.threats.byID[id]
    if not row then return false end
    if G.dist(pos,row.origin)<=5 and(radius==nil or radius==row.radius)then return true end
    local moved=self.threats:Snapshot(id)
    moved.origin=G.copy(pos);moved.b=G.copy(pos);if radius then moved.radius=radius end
    return self.threats:Observe(moved)~=nil
end
local function objectsOf(observer,owner,names,center)
    local cached=observer.g.SDK and observer.g.SDK.Cached
    if not cached then return nil end
    local best,bestDistance
    for _,method in ipairs({'GetMinions','GetWards'})do
        local read=cached[method]
        if type(read)=='function'then
            local ok,list=pcall(read,cached)
            if ok and type(list)=='table'then
                observer.hostCalls=(observer.hostCalls or 0)+1
                for i=1,math.min(#list,128)do
                    local u=list[i]
                    if usable(u)and u.team==owner.team and type(u.name)=='string'and names[u.name:lower()]
                        and G.dist(u.pos,owner.pos)<=A.leash then
                        local d=G.dist(u.pos,center)
                        if not best or d<bestDistance then best,bestDistance=u,d end
                    end
                end
            end
        end
    end
    return best
end
-- A cast-derived area just published with an anchor (`target`, `near`, `object`).
-- Returns true when tracked; false,reason when the area was removed (unknown anchor).
function A:Cast(observer,threat,owner,spell,spec,now)
    local id=threat.id
    local valid,why=A.Valid(spec)
    if not valid then self.threats:Remove(id);return false,why end
    if threat.shape~='circle'and threat.shape~='ring'then self.threats:Remove(id);return false,'anchor_shape'end
    if spec.unit=='near'then
        return track(self,id,{mode='stick',stick=spec.stick,owner=owner})
    end
    local unit
    if spec.unit=='target'then
        local target=spell and spell.target
        unit=champion(observer,target)
    elseif spec.unit=='object'then
        local names={};for _,n in ipairs(spec.objects)do names[n:lower()]=true end
        unit=objectsOf(observer,owner,names,threat.origin)
    end
    if not usable(unit)then self.threats:Remove(id);return false,'anchor_unresolved'end
    local radius
    if type(spec.radii)=='table'and G.finite(spec.slot)and type(owner.GetSpellData)=='function'then
        -- Rank-dependent radius, read once at the cast (the profile maximum otherwise).
        observer.hostCalls=(observer.hostCalls or 0)+1
        local ok,data=pcall(owner.GetSpellData,owner,spec.slot)
        local rank=ok and data and data.level
        local value=G.finite(rank)and spec.radii[rank]
        if G.finite(value)and value>0 and value<=threat.radius then radius=value end
    end
    if not track(self,id,{mode='follow',unit=unit,unitID=unit.networkID or unit.handle})then return false,'anchor_capacity'end
    follow(self,id,unit.pos,radius)
    return true
end
-- The flight of `entry` (evade.impacts) stopped within [o, o+dir*reach]: the unit it hit.
function A:Hit(observer,entry,o,reach,now)
    local spec=entry.anchor;local base=entry.base
    if not spec or spec.unit~='hit'then return end
    local policy=base.collide or{minion=true,monster=true,champion=true}
    local units,n=C.Units(observer)
    local caster=observer.heroes and observer.heroes[base.casterID]
    local team=caster and caster.team
    local b={x=o.x+entry.dx*reach,y=o.y or 0,z=o.z+entry.dz*reach}
    local best,bestDistance
    for i=1,n do
        local u=units[i]
        if policy[u.category]and(team==nil or u.team~=team)and usable(u.unit)then
            local d=G.segment(u.unit.pos,o,b)-(base.radius or 0)-u.radius
            if d<=A.slack and(not best or d<bestDistance)then best,bestDistance=u.unit,d end
        end
    end
    local me=observer.g.myHero
    if usable(me)and G.finite(me.boundingRadius)then
        local d=G.segment(me.pos,o,b)-(base.radius or 0)-me.boundingRadius
        if d<=A.slack and(not best or d<bestDistance)then return end -- the flight hit the player
    end
    if not best then return end
    local id=entry.parent..':anchor'
    local starts=entry.lastAt+(spec.delay or 0)
    local t={id=id,instanceID=base.instanceID,stageID=id,damageID=tostring(base.damageID or base.id)..':anchor',
        casterID=base.casterID,profile=base.profile,evidence='observed',ability=base.ability,abilityName=base.abilityName,
        champion=base.champion,source=base.source,shape='circle',origin=G.copy(best.pos),b=G.copy(best.pos),radius=spec.radius,
        starts=starts,ends=now+(spec.delay or 0)+(spec.window or .15),persistent=spec.persistent,observedAt=now,anchored=true,
        blockable=false,parryable=false,untargetableBlockable=false,tier=spec.tier or base.tier,
        cc=spec.cc,ccHard=spec.ccHard,ccUnknown=spec.ccUnknown,zones=spec.zones,
        timingScope='observed stop of the flight on a unit plus reviewed delay; centre follows that unit'}
    if spec.damage and G.finite(spec.damage)and spec.damage>0 and type(base.damage)=='table'then
        local scaled={};for k,v in pairs(base.damage)do scaled[k]=v end;scaled.raw=(base.damage.raw or 0)*spec.damage;t.damage=scaled
    end
    if not G.valid(t)or not track(self,id,{mode='follow',unit=best,unitID=best.networkID or best.handle})then return end
    if self.threats:Observe(t)and observer.onThreat then observer.onThreat(t)end
end
-- Units a sticking area may attach to: the shared snapshot, the enemy roster, the player.
local function stickTo(observer,center,stick)
    local best,bestDistance
    local function consider(u,radius)
        if usable(u)then
            local d=G.dist(u.pos,center)-(radius or 0)
            if d<=stick and(not best or d<bestDistance)then best,bestDistance=u,d end
        end
    end
    local units,n=C.Units(observer)
    for i=1,n do consider(units[i].unit,units[i].radius)end
    for _,h in ipairs(observer.roster or {})do consider(h,h.boundingRadius)end
    consider(observer.g.myHero,observer.g.myHero.boundingRadius)
    return best
end
function A:Scan(observer,now)
    local index=1
    while index<=self.count do
        local e=self.order[index];local id=e.id
        local row=self.threats.byID[id]
        local done=not row or row.ends<now
        if not done and e.mode=='stick'then
            if now>=row.starts then
                local unit=stickTo(observer,row.origin,e.stick)
                if unit then e.mode='follow';e.unit=unit;e.unitID=unit.networkID or unit.handle;follow(self,id,unit.pos)end
            end
        elseif not done then
            local u=e.unit
            if usable(u)and(e.unitID==nil or same(u,e.unitID))then follow(self,id,u.pos)
            else self.threats:Remove(id);done=true end -- the anchor is gone: so is its area
        end
        if done then self.entries[id]=nil;table.remove(self.order,index);self.count=self.count-1
        else index=index+1 end
    end
end
return A

end
