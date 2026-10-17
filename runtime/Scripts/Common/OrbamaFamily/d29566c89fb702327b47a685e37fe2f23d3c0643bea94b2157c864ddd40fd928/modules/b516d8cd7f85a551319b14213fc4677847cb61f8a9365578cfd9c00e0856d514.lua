return function(require)
-- Untargetable unit-cast defense (e.g. Master Yi Alpha Strike) through
-- SDK.ChampionMobility version 1, kind 'untargetable'. The controller publishes
-- an ordered, bounded candidate list (its mode preference), its consent,
-- readiness and turret policy, and executes the object cast through its own
-- ActionClient. Evade never presses the champion key: it only certifies that a
-- candidate keeps the hero clear of every modeled threat and requests it.
--
-- Model per declared timing: the hero stays at the origin until the window
-- starts (send + castDelay), avoids explicitly eligible new contacts for the
-- declared minimum duration, then reappears at a landing. Every landing the
-- controller declares (struck unit and possible bounce units) must be clear
-- under every timing. Impacts outside that intersection are counted as hits.
local G=require('evade.geometry')
local Flash=require('evade.flash_adapter')
local Dash=require('evade.dash_adapter')
local M={}
-- Bounded work: at most 8 candidates x 4 landings x 3 timings, one shared budget.
M.maxCandidates=8;M.maxLandings=4;M.maxTimings=3;M.workBudget=48000;M.cost=40
-- Short intent life: the protection window is narrow, so dispatch slack is
-- added to the latest declared start rather than assumed away.
M.expiresMs=50
-- Decide ahead: when every locked (unit-targeted) threat at the player has a
-- known impact interval, the earliest covering send is
--   sMin = latest impact - (earliest start + duration) + edge
-- and the latest safe send is
--   sMax = earliest impact - (latest start + dispatch slack).
-- A decision up to scheduleLead before sMin certifies the candidate at sMin and
-- submits it with a ready gate that opens when the fresh rows say now >= sMin;
-- the guard refuses once the fresh rows say now > latest safe send. The lead
-- keeps the certification fresh and is bounded by Evade's intent expiry.
M.scheduleLead=.1;M.maxScheduled=16
-- Guard-to-send allowance of an object cast (cursor positioning; unmeasured).
M.sendSlack=.03
-- Protection must outlast the latest impact strictly, not end on it.
M.edge=.01
-- One untargetable offer: the root or an alternative (dash_adapter.Offers).
local function valid(app,p)
    local h=app.g.myHero
    if p.version~=1 or p.kind~='untargetable'or type(p.Active)~='function'or type(p.CanStrike)~='function'
        or type(p.Strike)~='function'or type(p.Targets)~='function'then return nil,'mobility_contract_unsupported'end
    local ok,active=pcall(p.Active,p);if not ok or active~=true then return nil,'mobility_inactive'end
    if p.champion~=h.charName then return nil,'mobility_champion_mismatch'end
    if not G.finite(p.range)or p.range<=0 or p.range>1500 or not G.finite(p.landingRange)or p.landingRange<p.range
        or p.landingRange>3000 or not G.finite(p.duration)or p.duration<=0 or p.duration>2
        or type(p.castDelays)~='table'or #p.castDelays==0 then return nil,'mobility_profile_invalid'end
    for _,v in ipairs(p.castDelays)do if not G.finite(v)or v<0 or v>1 then return nil,'mobility_profile_invalid'end end
    return p
end
M.Valid=valid
function M.Providers(app)return Dash.Matching(app,valid)end
function M.Provider(app)local list,why=M.Providers(app);if list[1]then return list[1]end;return nil,why or 'no_mobility_provider'end
-- Locked threats aimed at the player: bounded ids plus the impact envelope.
-- `outcome` (optional forecast): a defence-only row (basic attack, unlisted cast)
-- widens the window only when it is one of that forecast's hits; an unrelated
-- later attack must not make the dodge of a lethal hit unschedulable.
function M.TargetedWindow(app,h,outcome)
    local id=h.networkID;local rows,i0,i1={},math.huge,-math.huge
    local counted
    if type(outcome)=='table'and type(outcome.hits)=='table'then
        counted={};for _,hit in ipairs(outcome.hits)do counted[hit]=true end
    end
    for _,t in ipairs(app.threats.list)do
        if t.shape=='targeted'and t.targetID==id and G.finite(t.starts)and(not t.defenseOnly or not counted or counted[t.id])then
            if #rows>=M.maxScheduled then return nil end
            local latest=G.finite(t.impactLatest)and t.impactLatest or t.ends
            if not G.finite(latest)then return nil end
            rows[#rows+1]=t.id;i0=math.min(i0,t.starts);i1=math.max(i1,latest)
        end
    end
    if #rows==0 then return nil end
    return rows,i0,i1
end
local function bounds(p)
    local lo,hi=math.huge,-math.huge
    for _,v in ipairs(p.castDelays)do lo=math.min(lo,v);hi=math.max(hi,v)end
    return lo,hi
end
-- Send-time interval that covers [i0,i1] under every declared timing.
function M.SendWindow(p,i0,i1)
    local lo,hi=bounds(p)
    return i1-(lo+p.duration)+M.edge,i0-(hi+M.expiresMs/1000)
end
-- Every declared start; the latest also carries the dispatch slack.
local function timings(p)
    local out,latest={},-math.huge
    for _,v in ipairs(p.castDelays)do latest=math.max(latest,v)end
    for _,v in ipairs(p.castDelays)do if #out<M.maxTimings-1 then out[#out+1]=v end end
    out[#out+1]=latest+M.expiresMs/1000
    return out
end
-- A landing is acceptable only when completely clear: no modeled hit, potential
-- hit or CC uncertainty. Destination danger is not compared with the baseline:
-- the controller's mode order (e.g. Combo onto its target) owns that choice.
function M.LandingClear(app,r)
    return type(r)=='table'and r.known==true and r.safe==true and not r.unknown and not r.lethal
        and r.terrainValidated==true and #(r.hits or {})==0 and (r.potentialCount or 0)==0 and not r.ccUnknown
        and r.threatRevision==app.threats.revision and r.terrainRevision==app.terrain.revision
end
function M.Install(app)
    local g=app.g;local h=g.myHero
    local offer,prepare
    local profileName=h.charName:match('^Jade_')and 'classic'or 'normal'
    local diagnosticAt,diagnosticReason=-math.huge,nil
    -- Development diagnostics only; public builds strip every call of it.
    local note;note=function(reason,fields)
        local now=g.Game.Timer()
        if reason==diagnosticReason and now<diagnosticAt+.5 then return end
        diagnosticAt,diagnosticReason=now,reason
        if app.recorder.enabled and not app.recorder.failed then
            fields=fields or {};fields.reason=reason;fields.profile=profileName
             do end 
        end
    end
    -- One switch for every own ability (menu SpellsEnabled); the controller keeps its own policy.
    local function consent()return not app.menu or app.menu.SpellsEnabled:Value()==true end
    local function ready(p,unit,request)
        if not app:Available()then return false,'evade_unavailable'end
        local ok,yes,why=pcall(p.CanStrike,p,unit,request)
        if not ok then return false,'mobility_error'end
        if unit==nil then
            if not app:DefenseReady(p.resource,yes==true)then return false,yes and 'awaiting_cooldown_cycle'or why or 'mobility_refused'end
            return true
        end
        if not yes then return false,why or 'mobility_refused'end
        return true
    end
    -- One candidate: every landing under every timing must be clear.
    local function evaluate(option,p,ctx)
        local worst
        for _,delay in ipairs(timings(p))do
            local base=ctx.now+(ctx.delay or 0)
            local effect={kind='untargetable',starts=base+delay,ends=base+delay+p.duration}
            for i=1,math.min(#option.landings,M.maxLandings)do local landing=option.landings[i]
                local copy={validated=true,profile=option.profile,resource=option.resource,effect=effect,path={landing},
                    mobility={kind='blink',range=p.landingRange,castDelay=delay+p.duration}}
                local r=app:EvaluateDefense(copy,nil,ctx)
                if not M.LandingClear(app,r)then return nil,r end
                if not worst or (r.arrival or 0)>(worst.arrival or 0)then worst=r end
                if ctx.sharedBudget and ctx.sharedBudget.remaining<=0 then return nil end
            end
        end
        return worst
    end
    local function request(ctx,outcome)return {lethal=outcome and outcome.lethal==true,intent=G.copy(ctx.intent or ctx.origin),mode=ctx.orbwalkerMode}end
    app:RegisterDefense('champion:untargetable',{validated=true,source='SDK.ChampionMobility v1 untargetable (controller-published profile)',
        active=function()return app.active and h.charName~=nil end,
        options=function(ctx)
            -- Offers in published order; the first offer with a clear candidate wins.
            for _,p in ipairs((M.Providers(app)))do
                local rows=offer(p,ctx);if #rows>0 then return rows end
            end
            return {}
        end,
        prepare=function(option,ctx)return prepare(option,ctx)end})
    function offer(p,ctx)
            if p.profile~=profileName or ctx.profile~=profileName then  do end ;return {}end
            local allowed,m=consent(p);if not allowed then return {}end
            local walking,baseline=ctx.walking,ctx.walkingBaseline
            if type(baseline)~='table'then  do end ;return {}end
            -- Unlike a dash, targeted effects make walking unsafe without a
            -- walking contact; the full forecast (not walkSafe) decides.
            if walking and walking.known and walking.safe then return {}end
            local outcome=walking and walking.known and walking or baseline
            local trigger,triggerWhy=Dash.Trigger(app,outcome,m)
            if not trigger then  do end ;return {}end
            local nominal,reason=ready(p,nil)
            if not nominal then  do end ;return {}end
            -- Decide ahead for locked threats whose impact is too late to cover now.
            local base=ctx.now+(ctx.delay or 0);local offset,schedule=0,nil
            local ids,i0,i1=M.TargetedWindow(app,h,outcome)
            if ids then
                local sMin,sMax=M.SendWindow(p,i0,i1)
                if sMin>sMax then  do end ;return {}end
                if sMin>base then
                    if sMin-ctx.now>M.scheduleLead then  do end ;return {}end
                    offset=sMin-base
                    schedule={ids=ids,count=#app.threats.list,sendAt=sMin,latestSend=sMax}
                end
            end
            local req=request(ctx,outcome)
            local ok,list=pcall(p.Targets,p,req)
            if not ok or type(list)~='table'then  do end ;return {}end
            local work={};for k,v in pairs(ctx)do work[k]=v end;work.sharedBudget={remaining=M.workBudget}
            work.delay=(ctx.delay or 0)+offset
            local threatRevision,terrainRevision=app.threats.revision,app.terrain.revision
            local considered=0
            for i=1,math.min(#list,M.maxCandidates)do local c=list[i]
                if type(c)=='table'and c.unit and type(c.landings)=='table'and #c.landings>0 then
                    local landings={}
                    for j=1,math.min(#c.landings,M.maxLandings)do
                        local q=c.landings[j];if G.point(q)then landings[#landings+1]={x=q.x,y=q.y or ctx.origin.y,z=q.z}end
                    end
                    if #landings>0 then
                        considered=considered+1
                        local option={validated=true,profile=profileName,resource=p.resource,cost=M.cost,championUntargetable=true,provider=p,
                            unit=c.unit,unitID=c.id,landings=landings,landing=landings[1],lethal=req.lethal,
                            threatRevision=threatRevision,terrainRevision=terrainRevision,schedule=schedule}
                        local r=evaluate(option,p,work)
                        if r and ready(p,c.unit,req)then
                            -- First clear candidate in controller order wins.
                            option.path={landings[1]};option.mobility={kind='blink',range=p.landingRange,castDelay=offset+timings(p)[1]+p.duration}
                            option.effect={kind='untargetable',starts=base+offset+timings(p)[#timings(p)],
                                ends=base+offset+timings(p)[1]+p.duration}
                            if option.effect.ends<=option.effect.starts then option.effect.ends=option.effect.starts+.001 end
                             do end 
                            return {option}
                        end
                    end
                end
                if work.sharedBudget.remaining<=0 or app.threats.revision~=threatRevision
                    or app.terrain.revision~=terrainRevision then break end
            end
             do end 
            return {}
    end
    function prepare(option,ctx)
            local p=option.provider
            if not Dash.Installed(app,p)or not valid(app,p)or p.resource~=option.resource then return nil,'untargetable_provider_changed'end
            if not consent(p)then return nil,'untargetable_consent_withdrawn'end
            local req={lethal=option.lethal==true}
            local ok,why=ready(p,nil,req);if ok then ok,why=ready(p,option.unit,req)end
            if not ok then return nil,why end
            if option.threatRevision~=app.threats.revision or option.terrainRevision~=app.terrain.revision then return nil,'untargetable_state_changed'end
            local generation,revision,terrainRevision=app.serial,app.threats.revision,app.terrain.revision
            if option.schedule then return M.Scheduled(app,p,option,generation,terrainRevision)end
            local expires=app.clock()+M.expiresMs
            -- Cheap cancellation/context state only: no host or planner calls.
            -- The certified window already includes M.expiresMs dispatch slack.
            local function current()
                return app.active and generation==app.serial and revision==app.threats.revision
                    and terrainRevision==app.terrain.revision and app.clock()<=expires and Dash.Installed(app,p)
            end
            return {type='cast',kind='object',target=G.copy(option.landing),resource=option.resource,expires=expires,
                championDash={provider=p,submit=M.Submit,unit=option.unit,lethal=option.lethal==true},
                mechanical=function()return current(),'untargetable_state_changed'end,
                commitGuard=function()return current(),'untargetable_state_changed'end}
    end
end
-- A scheduled intent waits (ready gate) until the fresh locked rows say the
-- earliest covering send has arrived, and refuses once they say the latest safe
-- send has passed, a scheduled threat disappeared, a new threat appeared, or
-- Evade cancelled/changed terrain. Cheap reads of Evade's own rows only.
function M.Scheduled(app,p,option,generation,terrainRevision)
    local g=app.g;local s=option.schedule;local lo,hi=bounds(p)
    local slack=M.expiresMs/1000
    local function envelope()
        local byID=app.threats.byID;local i0,i1=math.huge,-math.huge
        if #app.threats.list~=s.count then return nil,'untargetable_threats_changed'end
        for _,id in ipairs(s.ids)do local t=byID[id]
            if not t then return nil,'untargetable_threat_removed'end
            i0=math.min(i0,t.starts);i1=math.max(i1,G.finite(t.impactLatest)and t.impactLatest or t.ends)
        end
        return i0,i1
    end
    local function guard()
        if not(app.active and generation==app.serial and terrainRevision==app.terrain.revision and Dash.Installed(app,p))then
            return false,'untargetable_state_changed'end
        local i0,i1=envelope();if not i0 then return false,i1 end
        local now=g.Game.Timer()
        -- The send follows this guard by at most the positioning allowance.
        if now+hi+M.sendSlack>i0 then return false,'untargetable_send_too_late'end
        if now+lo+p.duration<i1 then return false,'untargetable_send_too_early'end
        return true
    end
    -- Opens at the fresh earliest covering send. It never sends on its own:
    -- a missing/changed threat opens it so the guard refuses at once.
    local function ready()
        local i0,i1=envelope();if not i0 then return true end
        return g.Game.Timer()>=i1-(lo+p.duration)+M.edge
    end
    local now=g.Game.Timer()
    local waitMs=math.max(0,math.floor((s.latestSend+slack-now)*1000+.5))
    local scheduledMs=math.min(waitMs,math.floor(M.scheduleLead*1000+M.expiresMs))
    return {type='cast',kind='object',target=G.copy(option.landing),resource=option.resource,expires=app.clock()+scheduledMs,
        scheduledMs=scheduledMs,ready=ready,schedule={sendAt=s.sendAt,latestSend=s.latestSend,ids=s.ids},
        championDash={provider=p,submit=M.Submit,unit=option.unit,lethal=option.lethal==true},
        mechanical=guard,commitGuard=guard}
end
-- Hands a prepared intent to the controller. Returns id, status, handle.
function M.Submit(app,intent)
    local d=intent.championDash;local p=d and d.provider
    if not p or not Dash.Installed(app,p)then return nil,'untargetable_provider_changed'end
    local ok,id,status,handle=pcall(p.Strike,p,d.unit,{owner='evade_untargetable',priority='critical',expires=intent.expires,
        lethal=d.lethal,validate=function()return intent.mechanical()end,ready=intent.ready})
    if not ok then return nil,'mobility_error'end
    return id,status,handle
end
return M

end
