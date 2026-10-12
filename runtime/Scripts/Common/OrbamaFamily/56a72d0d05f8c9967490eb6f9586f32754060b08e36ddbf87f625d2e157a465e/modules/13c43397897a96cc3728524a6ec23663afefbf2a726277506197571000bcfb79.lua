return function(require)
-- Traps and placed objects (Yordle Snap Trap, Noxious Trap, Flame Chompers,
-- Jack in the Box ...). A reviewed catalog row (`hazard`) names the object's own
-- unit name(s), trigger radius and lifetime. A hostile object with that name
-- becomes a stationary persistent circle: walking into it is a hit, so the
-- planner leaves it, refuses destinations inside it and replaces a current path
-- that would cross it. A trap that turns invisible is remembered where it was
-- last seen until its own lifetime ends or the object is seen removed. It counts
-- as armed from the first sight: when it was placed is not known (the row's `arm`
-- time documents the mechanic only).
-- `advisory` rows (turrets, plants, barrels) are large attack ranges, not
-- triggers: they only weigh on where a dodge ends (app Context), never force one.
-- Objects come from the provider's shared per-tick caches; nothing is enumerated
-- here unless an enemy champion with hazard rows is in the game.
local G=require('evade.geometry')
local H={};H.__index=H
H.interval=.25;H.maxTracked=32;H.reach=2500;H.maxScan=400
function H.new(threats)return setmetatable({threats=threats,rows={},count=0,nextAt=0,names={},advisory={}},H)end
-- Lower-cased object names -> hazard record, over every loaded enemy set.
function H:Index(observer)
    if self.indexed==observer.loadedCount then return self.index end
    self.indexed=observer.loadedCount;local index=nil
    self.owners={}
    for champion,set in pairs(observer.loaded)do
        for _,r in pairs(set)do
            local z=type(r)=='table'and r.name and r.hazard
            if z then
                index=index or {}
                self.owners[r]=champion
                for _,name in ipairs(z.objects or {})do index[name:lower()]=r end
            end
        end
    end
    self.index=index or false;return self.index
end
local function objectName(self,u)
    local key=u.networkID or u.handle
    local cached=key and self.names[key]
    if cached~=nil then return cached end
    local name=u.charName
    if type(name)~='string'or name==''then name=u.name end
    name=type(name)=='string'and name:lower()or false
    if key then self.names[key]=name end
    return name
end
local function consider(self,observer,index,u,now,hero,myTeam)
    if not u or u.team==myTeam or u.team==300 then return end
    local name=objectName(self,u)
    local record=name and index[name]
    if not record then return end
    local pos=u.pos
    if not G.point(pos)or G.dist(pos,hero)>H.reach then return end
    local key=u.networkID or u.handle;if not key then return end
    local id='hazard:'..tostring(key)
    local row=self.rows[id]
    if u.dead==true or u.valid==false then
        if row then row.gone=true end
        return
    end
    local z=record.hazard
    if not row then
        if self.count>=H.maxTracked then return end
        row={id=id,record=record,first=now,expires=now+(z.lifetime or 60),position=G.copy(pos)}
        self.rows[id]=row;self.count=self.count+1
    end
    row.seen=now;row.position=G.copy(pos);row.team=u.team
end
function H:Scan(observer,now)
    if now<self.nextAt then return end
    self.nextAt=now+H.interval
    local index=self:Index(observer)
    if not index then
        if self.count>0 then for id in pairs(self.rows)do self.threats:Remove(id);self.rows[id]=nil end;self.count=0;self.advisory={}end
        return
    end
    local sdk=observer.g.SDK;local cached=sdk and sdk.Cached
    local hero=observer.g.myHero.pos;local myTeam=observer.g.myHero.team
    if not cached or not G.point(hero)then return end
    for _,method in ipairs({'GetWards','GetMinions'})do
        local read=cached[method]
        if type(read)=='function'then
            local ok,list=pcall(read,cached)
            if ok and type(list)=='table'then
                observer.hostCalls=(observer.hostCalls or 0)+1
                for i=1,math.min(#list,H.maxScan)do consider(self,observer,index,list[i],now,hero,myTeam)end
            end
        end
    end
    local advisory={}
    for id,row in pairs(self.rows)do
        local record=row.record;local z=record.hazard
        if row.gone or now>row.expires then
            self.threats:Remove(id);self.rows[id]=nil;self.count=self.count-1
        elseif z.advisory then
            advisory[#advisory+1]={position=row.position,range=z.radius,weight=z.weight or 1}
        else
            local t={id=id,instanceID=id,stageID=id,damageID=id,casterID=row.team or 0,profile=record.profile,evidence='observed',
                ability=record.id,abilityName=record.castAlias or record.name,champion=self.owners[record],source=record.source,
                shape='circle',origin=row.position,b=row.position,radius=z.radius,
                starts=row.first,ends=row.expires,persistent=true,hazard=true,observedAt=row.first,
                blockable=false,parryable=false,untargetableBlockable=false,tier=record.tier,zonePolicy=z.zonePolicy,
                cc=record.cc,ccUnknown=record.ccUnknown,ccHard=record.ccHard,
                timingScope='placed object: trigger radius until its own lifetime ends or it is seen removed'}
            local fresh=self.threats.byID[id]==nil
            if G.valid(t)and self.threats:Observe(t)and fresh and observer.onThreat then observer.onThreat(t)end
        end
    end
    self.advisory=advisory
end
return H

end
