return function(require)
-- Delayed-death marks: a hostile buff on the player that detonates later
-- (Death Mark, Hemoplague, a Time Bomb ...). A reviewed catalog row (`mark`)
-- names the own buff and when it pops: `delay` seconds after the buff started,
-- or at its expiry. The pop becomes a `targeted` row, so walking never "dodges"
-- it, while stasis, untargetability and other timed defenses are judged against
-- its impact time. Damage stays unknown; the reviewed tier carries its weight.
-- The player's buffs are sampled only while an enemy champion with mark rows is
-- in the game.
local G=require('evade.geometry')
local M={};M.__index=M
M.interval=.1;M.maxBuffs=64;M.maxTracked=8;M.window=.1
function M.new(threats)return setmetatable({threats=threats,rows={},count=0,nextAt=0},M)end
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
function M:Scan(observer,now)
    if now<self.nextAt then return end
    self.nextAt=now+M.interval
    local index=self:Index(observer)
    for id,row in pairs(self.rows)do
        if now>row.ends+.25 then self.rows[id]=nil;self.count=self.count-1 end
    end
    if not index then return end
    local hero=observer.g.myHero
    local ok,count=pcall(function()return hero.buffCount end)
    if not ok or not G.finite(count)or count<0 then return end
    observer.hostCalls=(observer.hostCalls or 0)+1
    for i=0,math.min(count,M.maxBuffs)do
        observer.hostCalls=observer.hostCalls+1
        local read,b=pcall(hero.GetBuff,hero,i)
        local name=read and b and b.valid~=false and type(b.name)=='string'and b.name:lower()
        local record=name and index[name]
        if record and(not G.finite(b.count)or b.count>0)then
            local m=record.mark;local started=b.startTime
            local expires=b.expireTime;if not G.finite(expires)or expires<=0 then expires=b.endTime end
            local at
            if m.delay~=nil and G.finite(started)and started>0 then at=started+m.delay
            elseif G.finite(expires)and expires>0 then at=expires end
            local champion=self.owners[record];local owner=caster(observer,champion)
            if at and at>=now-.05 and at-now<=20 and owner and observer:Allowed(owner,record)then
                local id='mark:'..record.name..':'..tostring(G.finite(started)and started or at)
                local row=self.rows[id]
                if row or self.count<M.maxTracked then
                    if not row then row={observedAt=now};self.rows[id]=row;self.count=self.count+1 end
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
end
return M

end
