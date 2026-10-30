return function(require)
-- Delayed-death marks: a hostile buff on the player that detonates later
-- (Death Mark, Hemoplague, a Time Bomb ...). A reviewed catalog row (`mark`)
-- names the own buff and when it pops: `delay` seconds after the buff started,
-- or at its expiry. The pop becomes a `targeted` row, so walking never "dodges"
-- it, while stasis, untargetability and other timed defenses are judged against
-- its impact time. Damage stays unknown; the reviewed tier stands in for it (evade.danger).
-- The player's buffs are sampled only while an enemy champion with mark rows is
-- in the game.
local G=require('evade.geometry')
local M={};M.__index=M
M.interval=.1;M.maxBuffs=64;M.maxTracked=8;M.maxRetired=64;M.window=.1
function M.new(threats)return setmetatable({threats=threats,rows={},contacts={},contactCount=0,retired={},retiredCount=0,count=0,nextAt=0},M)end
function M:Index(observer)
    if self.indexed==observer.loadedCount then return self.index end
    self.indexed=observer.loadedCount;local index=nil;self.owners={}
    for champion,set in pairs(observer.loaded)do
        for _,r in pairs(set)do
            local m=type(r)=='table'and r.name and r.mark
            if m then
                index=index or {};self.owners[r]=champion
                for _,name in ipairs(m.buffs or {})do index[name:lower()]=r end
            end
        end
    end
    self.index=index or false;return self.index
end
local function caster(observer,champion)
    for _,h in ipairs(observer.roster)do if h.charName==champion then return h end end
end
-- buffCount is the host's upper slot boundary. Its final slot may be nil;
-- a hole before that boundary, failed field read or unknown active slot is not
-- proof that any previously observed mark disappeared.
local function buff(hero,i,count,index)
    local b=hero:GetBuff(i)
    if b==nil then return i==count end
    local stacks=b.count
    if stacks==0 then return true end
    if b.valid==false or G.finite(stacks)and stacks<0 then return false end
    local known=G.finite(stacks)and stacks>0
    local name=b.name
    if type(name)~='string'or name==''then return false end
    local record=index[name:lower()]
    if not record then return known end
    local expires=b.expireTime;if not G.finite(expires)or expires<=0 then expires=b.endTime end
    return known,record,b.startTime,expires
end
function M:Retire(id,now)
    -- Keep the old identity through its original horizon. Native wrappers can
    -- echo after a complete removal scan; they must not schedule another pop.
    -- At capacity, retain uncertainty rather than evicting an unexpired guard.
    if not self.retired[id]and self.retiredCount>=M.maxRetired then return end
    local t=self.threats:Snapshot(id)
    local horizon=self.rows[id].ends
    if t and t.ends>now then
        if not self.contacts[id]and self.contactCount>=M.maxTracked then return end
        horizon=math.max(horizon,t.ends)
        -- Absence may be an early detonation, not a harmless dispel. Preserve
        -- that possible immediate contact with the original damage identity.
        if t.starts>now then
            t.starts=now;t.impactLatest=now+M.window;t.ends=now+M.window
            t.markRemovedAt=now
            t.timingScope='complete player buff scan lost this mark identity; possible early pop at observation'
            if not self.threats:Observe(t)then return end
        end
        if not self.contacts[id]then self.contactCount=self.contactCount+1 end
        self.contacts[id]=t.ends
    end
    if not self.retired[id]then self.retiredCount=self.retiredCount+1 end
    self.retired[id]=horizon
    self.rows[id]=nil;self.count=self.count-1
end
function M:Scan(observer,now)
    local hero=observer.g.myHero
    if not hero then return end
    if hero.dead==true then
        for id in pairs(self.rows)do self.threats:Remove(id);self.rows[id]=nil end
        for id in pairs(self.contacts)do self.threats:Remove(id);self.contacts[id]=nil end
        for id in pairs(self.retired)do self.retired[id]=nil end
        self.count=0;self.contactCount=0;self.retiredCount=0;return
    end
    if now<self.nextAt then return end
    self.nextAt=now+M.interval
    local index=self:Index(observer)
    for id,ends in pairs(self.contacts)do
        if now>=ends then self.threats:Remove(id);self.contacts[id]=nil;self.contactCount=self.contactCount-1 end
    end
    for id,ends in pairs(self.retired)do
        if now>=ends then self.retired[id]=nil;self.retiredCount=self.retiredCount-1 end
    end
    for id,row in pairs(self.rows)do
        if now>row.ends+.25 then self.rows[id]=nil;self.count=self.count-1 end
    end
    if not index then return end
    observer.hostCalls=(observer.hostCalls or 0)+1
    local ok,count=pcall(function()return hero.buffCount end)
    if not ok or not G.finite(count)or count<0 or count~=math.floor(count)then return end
    local complete=count<=M.maxBuffs;local seen,observed={},{}
    for i=0,math.min(count,M.maxBuffs)do
        observer.hostCalls=observer.hostCalls+1
        local read,known,record,started,expires=pcall(buff,hero,i,count,index)
        if not read or not known then complete=false end
        if read and record then
            local m=record.mark
            local at
            if m.delay~=nil and G.finite(started)and started>0 then at=started+m.delay
            elseif G.finite(expires)and expires>0 then at=expires end
            if G.finite(at)then
                local id='mark:'..record.name..':'..tostring(G.finite(started)and started or at)
                seen[id]=true;observed[#observed+1]={id=id,record=record,at=at}
            else complete=false end
        end
    end
    observer.hostCalls=observer.hostCalls+1
    local stable,lastCount=pcall(function()return hero.buffCount end)
    if not stable or lastCount~=count then complete=false end
    -- Reconcile before admission so a full set of refreshed marks can replace
    -- all its old identities without losing the new scheduled hits to the cap.
    if complete then for id in pairs(self.rows)do if not seen[id]then self:Retire(id,now)end end end
    for _,sample in ipairs(observed)do
        local id,record,at=sample.id,sample.record,sample.at
        local m=record.mark;local champion=self.owners[record];local owner=caster(observer,champion)
        if not self.retired[id]and at>=now-.05 and at-now<=20 and owner and observer:Allowed(owner,record)then
            local row=self.rows[id]
            if row or self.count<M.maxTracked then
                if not row then row={observedAt=now};self.rows[id]=row;self.count=self.count+1 end
                if self.contacts[id]then self.contacts[id]=nil;self.contactCount=self.contactCount-1 end
                row.ends=at+M.window
                local t={id=id,instanceID=id,stageID=id,damageID=id,casterID=owner.networkID or owner.handle or 0,
                    targetID=hero.networkID,profile=record.profile,evidence='observed',ability=record.id,
                    abilityName=record.castAlias or record.name,champion=champion,source=record.source,
                    shape='targeted',starts=math.max(now,at),impactLatest=math.max(now,at)+M.window,ends=math.max(now,at)+M.window,
                    observedAt=row.observedAt,mark=true,tier=record.tier,blockable=false,parryable=false,
                    untargetableBlockable=m.untargetable~=false,unknownDamage=true,
                    cc=record.cc,ccUnknown=record.ccUnknown,ccHard=record.ccHard,
                    timingScope='own buff on the player; pop at buff start + own delay or at buff expiry'}
                local fresh=self.threats.byID[id]==nil
                if G.valid(t)and self.threats:Observe(t)and fresh and observer.onThreat then observer.onThreat(t)end
            end
        end
    end
end
return M

end
