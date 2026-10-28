return function(require)
local U=require('kata.util');local Ward=require('ChampionMobility.wards')(U)
local Nav=require('ChampionMobility.navigation')(U,require('ChampionMobility.navdata'))
local Terrain=require('ChampionMobility.terrain')(U,Nav)
local M={};M.__index=M
function M.new(c)
    local wardContext={profile=c.profile,spell=function(_,slot)return c:spell(slot)end,ready=function(_,slot)return c.state:ready(slot)end}
    local self=setmetatable({c=c,ctx=wardContext,actions=c.actions,doneHeld=false},M)
    self.terrain=Terrain.new(c);return self
end
M.itemReady=Ward.itemReady;M.slot=Ward.slot;M.hasCharges=Ward.hasCharges;M.wardKind=Ward.wardKind;M.wardCharges=Ward.wardCharges
function M:cancel(reason)
    if self.pending then
        self.c:record('jump',{event='cancel',reason=reason,state=self.pending.state,owner=self.pending.owner,
            held=self.c.config:get('jump'),doneHeld=self.doneHeld,age=Game.Timer()-(self.pending.at or Game.Timer())})
        self.c.actions:cancel(self.pending.owner,reason);self.pending=nil
    end
    self.preview=nil;self.job=nil
end
function M:existing(pos)
    local best,dist
    for _,o in ipairs(self.c:anchors())do local d=U.dist(o.pos,pos)
        if self.c:anchorValid(o)and d<150 and(not dist or d<dist)then best,dist=o,d end
    end
    return best
end
-- Katarina-8: the unit whose Shunpo landing ends nearest the cursor (champions of both teams, minions, monsters,
-- own daggers; Classic own wards), at least 200 closer than she stands, on walkable ground and not into more
-- enemies or under a turret. Returns the unit and the progress it gives.
function M:fleeAnchor(raw)
    local c=self.c;local base=U.dist(c.hero.pos,raw);local best,left
    for _,o in ipairs(c:anchors())do
        local d=c.state.daggers[U.id(o)]
        local landing=c.profile.id=='normal'and c:landing(o,nil,nil,d)or U.copy(d and d.pos or o.pos)
        if landing then local rest=U.dist(landing,raw)
            if base-rest>=200 and(not left or rest<left)and self.terrain:wall(landing)==false and c.planner:safe(landing,nil,true)then best,left=o,rest end
        end
    end
    return best,left and base-left
end
function M:start(pos,owner,target,unit)
    local c=self.c
    if self.pending or not c:ready(2)then return false end
    local anchor=unit or self:existing(pos)
    if anchor then
        local a={slot=2,target=anchor,anchor=anchor,dagger=c.state.daggers[U.id(anchor)],owner=owner,escape=owner~='combo',release=true,
            pos=c.profile.id=='normal'and c:landing(anchor,nil,nil,c.state.daggers[U.id(anchor)])or nil}
        local ok,record=c.actions:submit(a)
        if ok then self.pending={state='jumping',owner=owner,event=record,at=Game.Timer(),expires=Game.Timer()+2};c:record('jump',{event='existing_anchor',owner=owner});return true end
        return false
    end
    if c.profile.id=='normal'then return false end
    local slot=self:slot();if not slot or U.dist(c.hero.pos,pos)>c.config:get('wardRange')or self.terrain:wall(pos)~=false then return false end
    local source=Ward.sourceIdentity(self,slot)
    if owner~='jump'and not c.planner:safe(pos,target,owner~='combo')then return false end
    if owner=='combo'and(not U.valid(target)or not c.planner:estimate(target,pos,2).lethal or not c.planner:safe(pos,target))then return false end
    local ids={};for _,w in ipairs(c.state.objects.wards or {})do if U.id(w)then ids[U.id(w)]=true end end
    local p={state='placing',owner=owner,pos=U.copy(pos),ids=ids,target=target,at=Game.Timer(),expires=Game.Timer()+2}
    local ok,record=c.actions:submit({slot=slot,pos=pos,owner=owner,ward=true,release=true,
        validate=function()return Ward.sourceIdentity(self,slot)==source and c.state:ready(2)and self:itemReady(slot,nil,true)and self:hasCharges(slot)and self.terrain:wall(pos)==false and(owner=='jump'or c.planner:safe(pos,target,owner~='combo'))
            and U.dist(c.hero.pos,pos)<=c.config:get('wardRange')and(owner~='combo'or U.valid(target)and c.planner:estimate(target,pos,2).lethal and c.planner:safe(pos,target))end})
    if ok then p.event=record;self.pending=p;c:record('jump',{event='ward_requested',owner=owner,pos=pos});return true end
    c:record('jump',{event='ward_rejected',owner=owner,reason=record})
    return false
end
function M:advance()
    local c=self.c;local p=self.pending;if not p then return false end
    if not c:ownerActive(p.owner)or Game.Timer()>p.expires then self:cancel('jump_context_expired');return false end
    if p.state=='placing'then
        local raw=c.actions.client:Poll(p.event.id)
        if raw and raw.state=='cancelled_before_send'then
            -- Live 2026-10-03: an off-screen ward spot is refused by the input
            -- layer; retrying every tick spammed 37 requests in 5 s.
            self.retryAt=Game.Timer()+.3;self:cancel('ward_not_sent');return false
        end
        if raw and raw.sentAt then
            local match
            for i=1,U.count(Game.WardCount and Game.WardCount()or 0,512)do local w=Game.Ward(i)
                local owner=w and(w.ownerID or w.ownerNetworkID)
                if U.valid(w)and w.team==c.hero.team and not p.ids[U.id(w)]and U.dist(w.pos,p.pos)<90
                    and(not owner or owner==0 or owner==U.id(c.hero)or owner==c.hero.handle)then
                    if match then self:cancel('ambiguous_new_wards');return false end;match=w
                end
            end
            if match then
                c.actions.client:Observe(p.event.id,{kind='mechanical',unique=true,at=c.actions.client:Now(),source='new_ward_identity'})
                p.event.observed=true;p.anchor=match;p.state='ward_ready'
                c:record('jump',{event='ward_found',owner=p.owner,name=match.charName,delay=Game.Timer()-p.at})
            end
        end
    end
    if p.state=='ward_ready'then
        if not c:anchorValid(p.anchor)then self:cancel('ward_lost');return false end
        local function check()
            return U.valid(p.anchor)and c:anchorValid(p.anchor)and(p.owner~='combo'or U.valid(p.target)and c.planner:estimate(p.target,p.anchor.pos,2).lethal and c.planner:safe(p.anchor.pos,p.target))
        end
        if not check()then self:cancel('followup_no_longer_valid');return false end
        local ok,event=c.actions:submit({slot=2,target=p.anchor,anchor=p.anchor,owner=p.owner,escape=p.owner~='combo',release=true,validate=check})
        if ok then p.event=event;p.state='jumping'end
    end
    if p.state=='jumping'then
        if p.event.observed then c:record('jump',{event='jumped',owner=p.owner,duration=Game.Timer()-(p.at or Game.Timer())});self.doneHeld=true;self.pending=nil;return false end
        if p.event.finished then self:cancel('jump_unconfirmed');return false end
    end
    return true
end
function M:plan(raw)
    local c=self.c;local p
    if c.profile.id=='classic'then
        -- Same planning contract as Lee's wardjump preview (wards.lua W:preview):
        -- exact cursor landings are immediate; a range-clamped point is never
        -- accepted directly, the bounded approach search runs instead and its
        -- route (path, stand, wall crossing) is what gets shown and executed.
        local range=math.min(c.profile.eRange,c.config:get('wardRange'))
        if U.dist(c.hero.pos,raw)<=range and self.terrain:wall(raw)==false then
            self.job=nil;self.preview={valid=true,pos=U.copy(raw),raw=U.copy(raw),kind='exact'};return self.preview
        end
        local direct=self.terrain:landing(c.hero.pos,raw,range,self.preview)
        if direct.valid and direct.kind~='clamped'then self.job=nil;self.preview=direct;return direct end
        if not c.config:get('wardApproach')then return direct end
        local now=Game.Timer();local job=self.job
        local moved=job and(U.dist(job.raw,raw)>80 or U.dist(job.origin,c.hero.pos)>100)
        if not job or job.done and(U.dist(job.raw,raw)>1 or U.dist(job.origin,c.hero.pos)>1)or not job.done and moved and now-job.at>.35 then
            local origin,target,previous=U.copy(c.hero.pos),U.copy(raw),self.preview
            job={at=now,raw=target,origin=origin}
            job.work=coroutine.create(function()
                return self.terrain:plan(origin,target,range,previous,function()coroutine.yield()end,direct)
            end)
            self.job=job
        end
        if not job.done then
            local ok,result=coroutine.resume(job.work)
            if not ok then job.done=true;job.result={valid=false,pos=U.copy(raw),raw=U.copy(raw),reason='Navigation calculation failed'}
            elseif coroutine.status(job.work)=='dead'then job.done=true;job.result=result or {valid=false,pos=U.copy(raw),raw=U.copy(raw),reason='No landing'}end
        end
        if job.done then
            if job.result.valid then self.preview=job.result;return job.result end
            local last=self.preview
            if last and last.valid and last.kind=='approach'and U.dist(last.raw or raw,raw)<=80 then return last end
            return job.result
        end
        local last=self.preview
        if last and last.valid and last.kind~='exact'and U.dist(last.raw or raw,raw)<=80 then return last end
        return {valid=false,kind='planning',pos=U.copy(direct.pos or raw),raw=U.copy(raw),reason='Calculating approach'}
    else
        -- W stays on the near side. Only a real, correlated dagger authorizes E.
        local entry,exit=self.terrain:cursorCrossing(c.hero.pos,raw,250)
        if entry and exit and U.dist(entry,exit)<=200 then
            local near=U.toward(entry,c.hero.pos,45);local far=U.toward(exit,raw,40)
            if self.terrain:wall(near)==false and self.terrain:wall(far)==false and U.dist(near,far)<=c.profile.eOffset then
                p={valid=true,stand=near,pos=far,kind='modern_wall'};self.preview=p
            end
        end
    end
    return p
end
function M:tick(owner)
    local c=self.c
    if self:advance()then
        local p=self.pending
        if p and self.shown then self.shown.at=Game.Timer();self.shown.valid=true
            self.shown.label=p.state=='placing'and 'placing ward'or p.state=='ward_ready'and 'E to ward'or 'jumping'end
        return true
    end
    if not owner then self.doneHeld=false;self.job=nil;self.preview=nil;self.shown=nil;return false end
    if self.doneHeld then self.shown=nil;return true end
    local raw=c:mouse();if not raw then return true end
    -- Lee-style held preview: the full terrain plan is computed and shown every
    -- tick while T is held (also while E recharges); execution follows the plan.
    -- Katarina-9: Flee casts W for its movement speed (Normal: +50-90% decaying over 1.25 s with an enemy
    -- champion within 1000; Classic: speed only when it strikes a champion, so one must be inside W range).
    if owner=='flee'and c:ready(1)then
        local w={slot=1,owner='flee',fleeSpeed=true}
        if c:legal(w)then c.actions:submit(w)end
    end
    local range=math.min(c.profile.eRange,c.config:get('wardRange'))
    local anchor=self:existing(raw)
    local p=anchor and {valid=true,pos=U.copy(anchor.pos),raw=U.copy(raw),kind='unit'}or self:plan(raw)
    if not anchor then
        -- A unit hop is immediate; a ward (or a wall crossing) is used only when it gives clearly more progress.
        local unit,progress=self:fleeAnchor(raw)
        local planned=p and p.valid and p.pos and p.kind~='planning'and U.dist(c.hero.pos,raw)-U.dist(p.pos,raw)
        if unit and(not planned or planned<progress+150 or c.profile.id=='classic'and not self:slot()and p.kind~='modern_wall')then
            anchor=unit;local d=c.state.daggers[U.id(unit)]
            p={valid=true,pos=c.profile.id=='normal'and c:landing(unit,nil,nil,d)or U.copy(unit.pos),raw=U.copy(raw),kind='unit'}
        end
    end
    if not p then local pos=U.toward(c.hero.pos,raw,math.min(U.dist(c.hero.pos,raw),range))
        p={valid=self.terrain:wall(pos)==false,pos=pos,raw=U.copy(raw),kind='direct',reason='landing in wall'}end
    local ready=c:ready(2);local ward=anchor or self:slot()
    local far=p.pos and U.dist(c.hero.pos,p.pos)>range
    self.shown={pos=p.pos,raw=p.raw,path=p.path,stand=p.stand,walkTo=p.walkTo,at=Game.Timer(),
        valid=p.valid and ready and ward~=nil,approach=far or p.kind=='assisted'or p.kind=='approach',
        label=not p.valid and(p.reason or 'no landing')or not ready and 'E not ready'or not ward and 'no ward'
            or anchor and 'E'or far and 'walk > WARD > E'or 'WARD > E ('..tostring(p.kind or 'exact')..')'}
    if ready and p.valid and Game.Timer()<(self.retryAt or 0)then self.shown.valid=false;self.shown.label='ward not placeable here (off-screen?)'return true end
    if not ready or not p.valid then return true end
    if anchor then self:start(raw,owner,nil,anchor);return true end
    if p.kind=='modern_wall'then
        if U.dist(c.hero.pos,p.stand)>30 then
            if U.dist(c.hero.pos,p.stand)<=c.config:get('wardWalkRange')and self.terrain:walkLine(c.hero.pos,p.stand,35)then c.actions:submit({kind='move',pos=p.stand,owner=owner,release=true})end
        else
            local dagger
            for _,d in pairs(c.state.daggers)do if c.state:daggerValid(d)and U.dist(d.pos,p.stand)<=50 then dagger=d;break end end
            if dagger then
                local ok,record=c.actions:submit({slot=2,owner=owner,pos=p.pos,anchor=dagger.object,dagger=dagger,side=U.copy(p.pos),escape=true,release=true})
                if ok then self.pending={state='jumping',owner=owner,event=record,expires=Game.Timer()+2}end
            elseif c:ready(1)then c.actions:submit({slot=1,owner=owner,prepareWall=true,release=true})end
        end
    elseif U.dist(c.hero.pos,p.pos)<=math.min(c.profile.eRange,c.config:get('wardRange'))then self:start(p.pos,owner)
    elseif c.config:get('wardApproach')and p.walkTo and U.dist(c.hero.pos,p.walkTo)<=c.config:get('wardWalkRange')then
        c.actions:submit({kind='move',pos=p.walkTo,owner=owner,release=true,validate=function()return self.terrain:wall(p.walkTo)==false end})
    end
    return true
end
return M

end
