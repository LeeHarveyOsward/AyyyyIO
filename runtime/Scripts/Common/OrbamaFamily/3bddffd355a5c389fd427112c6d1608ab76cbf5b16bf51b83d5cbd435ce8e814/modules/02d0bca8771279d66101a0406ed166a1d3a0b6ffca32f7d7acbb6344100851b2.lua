return function(require)
-- Champion-dash defense (e.g. Vayne Q). Offered only when walking cannot reach
-- safety and a full-length dash lands completely clear of every modeled threat
-- under each timing in the controller's declared bracket. Evade never presses
-- the champion key: the active controller publishes SDK.ChampionMobility
-- (version 1) and executes the dash through its own ActionClient, slot
-- reservation and policy. Selection stays in app:Tick (EvaluateDefense/Better).
local G=require('evade.geometry')
local Flash=require('evade.flash_adapter')
local Danger=require('evade.danger')
local M={}
-- Bounded search: 12 directions around the player intent, one full-length
-- endpoint each (a tumble does not stop short), at most 6 timing samples per
-- endpoint, one shared work budget and at most three offers.
M.directions=12;M.maxTimings=6;M.workBudget=48000;M.maxOffered=3;M.cost=40;M.expiresMs=120
-- A provider may also declare (version 1, kind 'dash', additive fields):
--   blink=true    instant displacement after the cast delay (Arcane Shift, Riftwalk, Deceive):
--                 nothing is hit on the way and terrain between the two points does not matter;
--                 `speeds` is not needed.
--   toPoint=true  the dash or blink ends at the chosen point, not always at full length
--                 (Rocket Jump, Valkyrie): shorter landings are tried when the far one is unsafe.
--   lethalOnly=true  the dash is kept for a hit that would kill (Malphite R): it is not offered for
--                 hard control or a damage share alone. Also valid on a unitDash provider.
-- Without either field the contract is unchanged: one full-length dash per direction.
M.reaches={1,.75,.5}
-- Unit dash (kind 'unitDash', e.g. Irelia Q onto a minion): the controller
-- lists at most 8 units with every place the dash may end; each landing is
-- modeled as a linear dash from the hero under every declared timing and all
-- must land clear. A cast the controller expects to be refunded costs less, so
-- it wins among equally safe landings. unitSlack covers hero movement during
-- the reaction delay in the model's range bound (legality is the controller's
-- check); a unit that moved more than unitDrift from where it was certified
-- cancels the request. refundCycleMs: see ready() below.
M.maxCandidates=8;M.maxLandings=3;M.maxUnitTimings=4;M.freeCost=5;M.unitSlack=75;M.unitDrift=60;M.refundCycleMs=1500
local function walkingSafe(r)return r and r.known and (r.safe or r.walkSafe==true)end
-- Several offers per champion (additive to version 1): the published root may
-- list further complete version-1 providers in `alternatives` (Wukong Normal W
-- dash and E unit dash). Offers() enumerates the root, its `.unit`, then each
-- alternative and its `.unit`, at most maxProviders, in that order. Every offer
-- keeps its own slot resource, readiness, policy and cleanup; the options of all
-- offers of one kind compete under Evade's ordinary rules (planner Better).
M.maxProviders=6
function M.Offers(app)
    local root=app.sdk.ChampionMobility;local out={}
    local function add(p)
        if type(p)~='table'or #out>=M.maxProviders then return end
        for _,q in ipairs(out)do if q==p then return end end
        out[#out+1]=p
    end
    if type(root)~='table'then return out end
    add(root);add(root.unit)
    if type(root.alternatives)=='table'then
        for i=1,math.min(#root.alternatives,M.maxProviders)do local a=root.alternatives[i]
            add(a);if type(a)=='table'then add(a.unit)end
        end
    end
    return out
end
-- The offer is still published (root, unit or alternative). Table reads only.
function M.Installed(app,p)
    if type(p)~='table'then return false end
    for _,q in ipairs(M.Offers(app))do if q==p then return true end end
    return false
end
-- Every valid offer accepted by `check(app,p)`, plus the most informative refusal.
function M.Matching(app,check)
    local offers=M.Offers(app);local out,why={},nil
    for _,p in ipairs(offers)do
        local valid,reason=check(app,p)
        if valid then out[#out+1]=valid elseif not why or reason~='mobility_contract_unsupported'then why=reason end
    end
    if #offers==0 then why='no_mobility_provider'end
    return out,why
end
local function validDash(app,p)
    local h=app.g.myHero
    if p.version~=1 or p.kind~='dash'or type(p.Active)~='function'or type(p.CanDash)~='function'
        or type(p.Dash)~='function'then return nil,'mobility_contract_unsupported'end
    local ok,active=pcall(p.Active,p);if not ok or active~=true then return nil,'mobility_inactive'end
    if p.champion~=h.charName then return nil,'mobility_champion_mismatch'end
    if not G.finite(p.range)or p.range<=0 or p.range>1000 or type(p.castDelays)~='table'or #p.castDelays==0
        or p.blink~=nil and p.blink~=true or p.toPoint~=nil and p.toPoint~=true
        or p.lethalOnly~=nil and p.lethalOnly~=true then return nil,'mobility_profile_invalid'end
    if p.blink~=true then
        if type(p.speeds)~='table'or #p.speeds==0 then return nil,'mobility_profile_invalid'end
        for _,v in ipairs(p.speeds)do if not G.finite(v)or v<=0 then return nil,'mobility_profile_invalid'end end
    end
    for _,v in ipairs(p.castDelays)do if not G.finite(v)or v<0 or v>1 then return nil,'mobility_profile_invalid'end end
    return p
end
M.ValidDash=validDash
-- Every valid point-dash offer; Provider() keeps the first (version-1 callers).
function M.Providers(app)return M.Matching(app,validDash)end
function M.Provider(app)local list,why=M.Providers(app);if list[1]then return list[1]end;return nil,why or 'no_mobility_provider'end
-- A unit-dash offer: published alone, as `.unit` of a point-dash provider, or as an alternative.
local function validUnit(app,p)
    local h=app.g.myHero
    if p.version~=1 or p.kind~='unitDash'or type(p.Active)~='function'or type(p.CanStrike)~='function'
        or type(p.Strike)~='function'or type(p.Targets)~='function'then return nil,'mobility_contract_unsupported'end
    local ok,active=pcall(p.Active,p);if not ok or active~=true then return nil,'mobility_inactive'end
    if p.champion~=h.charName then return nil,'mobility_champion_mismatch'end
    if not G.finite(p.range)or p.range<=0 or p.range>1500 or type(p.speeds)~='table'or type(p.castDelays)~='table'
        or #p.speeds==0 or #p.castDelays==0 or p.lethalOnly~=nil and p.lethalOnly~=true then return nil,'mobility_profile_invalid'end
    for _,v in ipairs(p.speeds)do if not G.finite(v)or v<=0 then return nil,'mobility_profile_invalid'end end
    for _,v in ipairs(p.castDelays)do if not G.finite(v)or v<0 or v>1 then return nil,'mobility_profile_invalid'end end
    return p
end
M.ValidUnit=validUnit
function M.UnitProviders(app)return M.Matching(app,validUnit)end
function M.UnitProvider(app)local list,why=M.UnitProviders(app);if list[1]then return list[1]end;return nil,why or 'no_mobility_provider'end
local installed=M.Installed
-- Every declared timing (speed x cast delay corners), bounded.
local function timings(p,range,speeds,limit)
    local out={}
    if p.blink==true and not speeds then
        for _,delay in ipairs(p.castDelays)do
            if #out<(limit or M.maxTimings)then out[#out+1]={kind='blink',range=range,castDelay=delay}end
        end
        return out
    end
    for _,delay in ipairs(p.castDelays)do for _,speed in ipairs(speeds or p.speeds)do
        if #out<(limit or M.maxTimings)then out[#out+1]={kind='dash',range=range,castDelay=delay,speed=speed}end
    end end
    return out
end
-- Trigger policy (evade.danger Matters): lethal, lethal with the enemy follow-up during its control, or a
-- forecast danger of at least the shared share of current health (menu MinDamage). Hard control counts
-- through what the enemy team can do during it; without that evidence it always qualifies.
function M.Trigger(app,outcome)
    local share=app.menu and app.menu.MinDamage and app.menu.MinDamage:Value()or 20
    return Danger.Matters(outcome,share/100,app.g.myHero.health)
end
function M.Install(app)
    local g=app.g;local h=g.myHero
    local dashOptions,prepareDash,unitOptions,prepareUnit
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
    -- target=nil asks for direction-independent readiness (cooldown, mana,
    -- controller consent). That result also drives the no-replay rule: a sent
    -- or uncertain dash stays unavailable until the controller reports it unavailable.
    local function ready(p,target)
        if not app:Available()then return false,'evade_unavailable'end
        local ok,yes,why=pcall(p.CanDash,p,target)
        if not ok then return false,'mobility_error'end
        if target==nil then
            if not app:DefenseReady(p.resource,yes==true)then return false,yes and 'awaiting_cooldown_cycle'or why or 'mobility_refused'end
            return true
        end
        if not yes then return false,why or 'mobility_refused'end
        return true
    end
    -- All declared timings must land clear; returns the slowest-arrival result.
    local function evaluate(option,p,ctx)
        local worst
        for _,mobility in ipairs(timings(p,option.mobility.range))do
            local copy={};for k,v in pairs(option)do copy[k]=v end;copy.mobility=mobility
            local r=app:EvaluateDefense(copy,nil,ctx)
            if not Flash.LandingSafe(app,r,ctx.walkingBaseline)then return nil,r end
            if not worst or (r.arrival or 0)>(worst.arrival or 0)then worst=r end
        end
        return worst
    end
    app:RegisterDefense('champion:dash',{validated=true,source='SDK.ChampionMobility v1 (controller-published profile)',
        active=function()return app.active and h.charName~=nil end,
        options=function(ctx)
            local all={}
            -- Live s366 (Classic Vayne): no dash_considered row in a whole game with unsafe hits, so it
            -- stayed unknown whether the tumble was missing, switched off or refused. Name each.
            local providers,why=M.Providers(app)
            if #providers==0 then  do end end
            for _,p in ipairs(providers)do
                for _,option in ipairs(dashOptions(p,ctx))do all[#all+1]=option end
            end
            return all
        end,
        prepare=function(option,ctx)return prepareDash(option,ctx)end})
    -- Point dash of one offer. Bounded per offer; at most maxProviders offers.
    function dashOptions(p,ctx)
            if p.profile~=profileName or ctx.profile~=profileName then  do end ;return {}end
            local allowed,m=consent(p);if not allowed then  do end ;return {}end
            local walking,baseline=ctx.walking,ctx.walkingBaseline
            if type(baseline)~='table'then  do end ;return {}end
            if walkingSafe(walking)then return {}end
            local outcome=walking and walking.known and walking or baseline
            local trigger,triggerWhy=M.Trigger(app,outcome,m)
            if not trigger then  do end ;return {}end
            if p.lethalOnly==true and outcome.lethal~=true then  do end ;return {}end
            local nominal,reason=ready(p,nil)
            if not nominal then  do end ;return {}end
            local work={};for k,v in pairs(ctx)do work[k]=v end;work.sharedBudget={remaining=M.workBudget}
            local threatRevision,terrainRevision=app.threats.revision,app.terrain.revision
            local origin=ctx.origin;local base=0
            if G.point(ctx.intent)and G.dist(origin,ctx.intent)>5 then base=math.atan2(ctx.intent.z-origin.z,ctx.intent.x-origin.x)end
            local offered,considered,safe,refused={},0,0,{}
            for i=0,M.directions-1 do
                local k=i==0 and 0 or (i%2==1 and (i+1)/2 or -i/2)
                local angle=base+k*2*math.pi/M.directions;local dx,dz=math.cos(angle),math.sin(angle)
                -- Farthest landing first; a point-targeted dash or blink may also stop short.
                for _,share in ipairs((p.blink==true or p.toPoint==true)and M.reaches or {1})do
                local reach=p.range*share
                local q={x=origin.x+dx*reach,y=origin.y,z=origin.z+dz*reach}
                -- Cheap centre query first. Unknown terrain is not walkable ground.
                if app.terrain:Wall(q,ctx.now,ctx.radius)==false then
                    considered=considered+1
                    local first=timings(p,reach)[1]
                    local option={validated=true,profile=profileName,resource=p.resource,cost=M.cost,championDash=true,
                        provider=p,mobility=first,reach=reach,
                        direction={x=dx,z=dz},path={q},landing=q,threatRevision=threatRevision,terrainRevision=terrainRevision}
                    local r=evaluate(option,p,work)
                    if r then
                        local yes,blocked=ready(p,q)
                        if yes then
                            safe=safe+1
                            local at=#offered+1
                            for j=1,#offered do if app.planner:Better(r,offered[j].result,ctx)then at=j;break end end
                            table.insert(offered,at,{option=option,result=r})
                            if #offered>M.maxOffered then offered[#offered]=nil end
                            break
                        else refused[blocked or 'refused']=(refused[blocked or 'refused']or 0)+1 end
                    end
                end
                if work.sharedBudget.remaining<=0 then break end
                end
                if work.sharedBudget.remaining<=0 or app.threats.revision~=threatRevision
                    or app.terrain.revision~=terrainRevision then break end
            end
            if app.threats.revision~=threatRevision or app.terrain.revision~=terrainRevision then  do end ;return {}end
            local result={};for i,row in ipairs(offered)do result[i]=row.option end
             do end 
            return result
    end
    function prepareDash(option,ctx)
            local p=option.provider
            if not installed(app,p)or not validDash(app,p)or p.resource~=option.resource then return nil,'dash_provider_changed'end
            if not consent(p)then return nil,'dash_consent_withdrawn'end
            local ok,why=ready(p,nil);if ok then ok,why=ready(p,option.landing)end
            if not ok then return nil,why end
            if option.threatRevision~=app.threats.revision or option.terrainRevision~=app.terrain.revision then return nil,'dash_state_changed'end
            local generation,revision,terrainRevision=app.serial,app.threats.revision,app.terrain.revision
            local expires=app.clock()+M.expiresMs;local direction=option.direction
            local resolved={point=G.copy(option.landing)}
            -- Cheap cancellation/context state only: no host or planner calls.
            local function current()
                return app.active and generation==app.serial and revision==app.threats.revision
                    and terrainRevision==app.terrain.revision and app.clock()<=expires and installed(app,p)
            end
            return {type='cast',kind='world',target=G.copy(option.landing),resource=option.resource,expires=expires,
                championDash={provider=p},resolvedLanding=resolved,
                mechanical=function()return current(),'dash_state_changed'end,
                commitGuard=function()return current(),'dash_state_changed'end,
                -- Full validation immediately before positioning, from fresh state.
                -- The tumble always travels its full length from the current origin.
                resolve=function()
                    if not current()then return nil,'dash_state_changed'end
                    local fresh=app:Context()
                    if fresh.trajectoryReason then return nil,fresh.trajectoryReason end
                    local reach=option.reach or p.range
                    local landing={x=fresh.origin.x+direction.x*reach,y=fresh.origin.y,z=fresh.origin.z+direction.z*reach}
                    local baseline=app.planner:Evaluate(fresh.currentPath or {fresh.origin},fresh,nil,true)
                    if walkingSafe(baseline)then  do end ;return nil,'dash_threat_resolved'end
                    fresh.walkingBaseline=baseline
                    local copy={};for k,v in pairs(option)do copy[k]=v end;copy.path={landing};copy.landing=landing
                    if not evaluate(copy,p,fresh)or not current()then  do end ;return nil,'dash_endpoint_changed'end
                    resolved.point=G.copy(landing)
                     do end 
                    return {position=landing}
                end}
    end
    -- Unit dash. unit=nil asks for unit-independent readiness.
    local function unitReady(p,unit,request)
        if not app:Available()then return false,'evade_unavailable'end
        local ok,yes,why=pcall(p.CanStrike,p,unit,request)
        if not ok then return false,'mobility_error'end
        if unit==nil then
            -- A refunded dash is ready again when it ends, possibly without one
            -- sample of it unavailable. Its travel is long over after
            -- refundCycleMs, so fresh readiness then permits a new decision.
            local prior=app.defenseSent[p.resource]
            if prior and p.refunds==true and yes==true and app.clock()-prior.at>=M.refundCycleMs then prior.unavailableObserved=true end
            if not app:DefenseReady(p.resource,yes==true)then return false,yes and 'awaiting_cooldown_cycle'or why or 'mobility_refused'end
            return true
        end
        if not yes then return false,why or 'mobility_refused'end
        return true
    end
    -- Every landing under every timing must be clear; returns the slowest arrival.
    local function evaluateUnit(option,p,ctx)
        local worst
        for _,mobility in ipairs(timings(p,p.range+M.unitSlack,option.speeds,M.maxUnitTimings))do
            for _,landing in ipairs(option.landings)do
                local copy={};for k,v in pairs(option)do copy[k]=v end;copy.mobility=mobility;copy.path={landing}
                local r=app:EvaluateDefense(copy,nil,ctx)
                if not Flash.LandingSafe(app,r,ctx.walkingBaseline)then return nil,r end
                if not worst or (r.arrival or 0)>(worst.arrival or 0)then worst=r end
                if ctx.sharedBudget and ctx.sharedBudget.remaining<=0 then return nil end
            end
        end
        return worst
    end
    app:RegisterDefense('champion:unitDash',{validated=true,source='SDK.ChampionMobility v1 unitDash (controller-published profile)',
        active=function()return app.active and h.charName~=nil end,
        options=function(ctx)
            local all={}
            for _,p in ipairs((M.UnitProviders(app)))do
                for _,option in ipairs(unitOptions(p,ctx))do all[#all+1]=option end
            end
            return all
        end,
        prepare=function(option,ctx)return prepareUnit(option,ctx)end})
    function unitOptions(p,ctx)
            if p.profile~=profileName or ctx.profile~=profileName then  do end ;return {}end
            local allowed,m=consent(p);if not allowed then  do end ;return {}end
            local walking,baseline=ctx.walking,ctx.walkingBaseline
            if type(baseline)~='table'then  do end ;return {}end
            if walkingSafe(walking)then return {}end
            local outcome=walking and walking.known and walking or baseline
            local trigger,triggerWhy=M.Trigger(app,outcome,m)
            if not trigger then  do end ;return {}end
            if p.lethalOnly==true and outcome.lethal~=true then  do end ;return {}end
            local nominal,reason=unitReady(p,nil)
            if not nominal then  do end ;return {}end
            -- severe: lethal or hard crowd control (Flash.Severe), for offers that spend more than the ability.
            local req={lethal=outcome.lethal==true,severe=Flash.Severe(outcome,false)==true,intent=G.copy(ctx.intent or ctx.origin),mode=ctx.orbwalkerMode}
            local ok,list=pcall(p.Targets,p,req)
            if not ok or type(list)~='table'then  do end ;return {}end
            local work={};for k,v in pairs(ctx)do work[k]=v end;work.sharedBudget={remaining=M.workBudget}
            local threatRevision,terrainRevision=app.threats.revision,app.terrain.revision
            local result,considered={},0
            for i=1,math.min(#list,M.maxCandidates)do local c=list[i]
                local at=type(c)=='table'and c.unit and G.point(c.position)and type(c.landings)=='table'and c.position
                local landings={}
                for j=1,at and math.min(#c.landings,M.maxLandings)or 0 do local q=c.landings[j]
                    if not G.point(q)then landings={};break end
                    landings[j]={x=q.x,y=q.y or ctx.origin.y,z=q.z}
                end
                if #landings>0 then
                    considered=considered+1
                    local speeds
                    if type(c.speeds)=='table'and #c.speeds>0 then
                        speeds={};for j=1,math.min(#c.speeds,3)do local v=c.speeds[j]
                            if not G.finite(v)or v<=0 then speeds=nil;break end;speeds[j]=v end
                    end
                    -- The controller's order is kept (refunded casts first).
                    local option={validated=true,profile=profileName,resource=p.resource,cost=c.free==true and M.freeCost or M.cost,
                        provider=p,championDash=true,unitDash=true,unit=c.unit,unitID=c.id,unitPosition={x=at.x,y=at.y or ctx.origin.y,z=at.z},
                        landings=landings,landing=landings[1],path={landings[1]},speeds=speeds,free=c.free==true,lethal=req.lethal,
                        mobility=timings(p,p.range+M.unitSlack,speeds,1)[1],threatRevision=threatRevision,terrainRevision=terrainRevision}
                    if evaluateUnit(option,p,work)and unitReady(p,c.unit,req)then result[#result+1]=option end
                end
                if #result>=M.maxOffered or work.sharedBudget.remaining<=0 or app.threats.revision~=threatRevision
                    or app.terrain.revision~=terrainRevision then break end
            end
            if app.threats.revision~=threatRevision or app.terrain.revision~=terrainRevision then  do end ;return {}end
             do end 
            return result
    end
    function prepareUnit(option,ctx)
            local p=option.provider
            if not installed(app,p)or not validUnit(app,p)or p.resource~=option.resource then return nil,'dash_provider_changed'end
            if not consent(p)then return nil,'dash_consent_withdrawn'end
            local req={lethal=option.lethal==true}
            local ok,why=unitReady(p,nil,req);if ok then ok,why=unitReady(p,option.unit,req)end
            if not ok then return nil,why end
            if option.threatRevision~=app.threats.revision or option.terrainRevision~=app.terrain.revision then return nil,'dash_state_changed'end
            local generation,revision,terrainRevision=app.serial,app.threats.revision,app.terrain.revision
            local expires=app.clock()+M.expiresMs;local unit,at=option.unit,option.unitPosition
            -- Cheap cancellation/context state only: Evade's own revisions and
            -- one position read of the unit. The controller's validator checks
            -- identity, range and eligibility from fresh state before the send.
            local function current()
                if not(app.active and generation==app.serial and revision==app.threats.revision
                    and terrainRevision==app.terrain.revision and app.clock()<=expires and installed(app,p))then return false,'dash_state_changed'end
                local pos=unit.pos
                if not G.point(pos)or G.dist(pos,at)>M.unitDrift then return false,'dash_target_moved'end
                return true
            end
            return {type='cast',kind='object',target=G.copy(option.landing),resource=option.resource,expires=expires,
                championDash={provider=p,submit=M.SubmitUnit,unit=unit,lethal=option.lethal==true},
                mechanical=current,commitGuard=current}
    end
end
-- Hands a prepared unit-dash intent to the controller. Returns id, status, handle.
function M.SubmitUnit(app,intent)
    local d=intent.championDash;local p=d and d.provider
    if not p or not installed(app,p)then return nil,'dash_provider_changed'end
    local ok,id,status,handle=pcall(p.Strike,p,d.unit,{owner='evade_dash',priority='critical',expires=intent.expires,
        lethal=d.lethal,validate=function()return intent.mechanical()end})
    if not ok then return nil,'mobility_error'end
    return id,status,handle
end
-- Hands a prepared intent to the controller. Returns id, status, handle.
function M.Submit(app,intent)
    local p=intent.championDash and intent.championDash.provider
    if not p or not installed(app,p)then return nil,'dash_provider_changed'end
    local ok,id,status,handle=pcall(p.Dash,p,intent.target,{owner='evade_dash',priority='critical',expires=intent.expires,
        resolve=intent.resolve,validate=function()return intent.mechanical()end,commitGuard=intent.commitGuard})
    if not ok then return nil,'mobility_error'end
    return id,status,handle
end
return M

end
