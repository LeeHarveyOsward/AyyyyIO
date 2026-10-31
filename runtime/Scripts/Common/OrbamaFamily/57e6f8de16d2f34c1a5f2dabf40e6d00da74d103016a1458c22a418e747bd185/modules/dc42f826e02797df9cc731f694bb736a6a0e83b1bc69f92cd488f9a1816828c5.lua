return function(require)
-- Opt-in Flash defense (default off). Flash is offered only when the walking
-- planner cannot escape a lethal (or known hard-CC) forecast and a bounded,
-- terrain-checked landing is safe from every modeled threat. Selection stays in
-- app:Tick through EvaluateDefense/Better; this adapter never sends input itself.
local G=require('evade.geometry')
local M={}
-- Exact host summoner names per profile. A profile is enabled only when both its
-- runtime name and its blink displacement are established for that profile.
M.profiles=require('CombatProfiles.flash')
-- Bounded search: 12 directions ordered around the player intent, up to four
-- wall-aware distances each, one shared work budget, at most three offers.
M.directions=12;M.distances={375,325,275,225};M.workBudget=48000;M.maxOffered=3;M.cost=150;M.expiresMs=50
-- Nonlethal hard control is worth Flash when its danger (evade.danger) reaches this share of current health.
M.severeShare=.2
local function walkingSafe(r)return r and r.known and (r.safe or r.walkSafe==true)end
function M.Severe(result,onlyLethal,share)
    if type(result)~='table'or not result.known then return false,'forecast_unknown'end
    if result.lethal==true then return true,'lethal'end
    if onlyLethal then return false,'not_lethal'end
    -- Missing CC data is not hard CC evidence. A known positive duration counts, and so
    -- does reviewed hard control whose duration is unknown (ccHard: hooks, pulls, knockbacks).
    if G.finite(result.cc)and result.cc>0 or result.ccHard==true then
        -- Weighed by what the enemy team can do during it (evade.danger); without that evidence it counts.
        if result.lethalRisk==true then return true,'lethal_follow_up'end
        if result.hitDanger==nil or result.followUpUnknown or result.hitDanger>=(share or M.severeShare)then return true,'hard_cc'end
        return false,'hard_cc_below_danger'
    end
    return false,'not_lethal_or_hard_cc'
end
-- A Flash landing must be completely clear: no modeled hit, potential hit, CC
-- uncertainty or added positioning danger. Partial mitigation never qualifies.
function M.LandingSafe(app,r,baseline)
    return type(r)=='table'and r.known==true and r.safe==true and not r.unknown and not r.lethal
        and r.terrainValidated==true and #(r.hits or {})==0 and (r.potentialCount or 0)==0 and not r.ccUnknown
        and (r.danger or 0)<=((baseline and baseline.danger)or 0)+.001
        and r.threatRevision==app.threats.revision and r.terrainRevision==app.terrain.revision
end
function M.Install(app)
    local g=app.g;local h=g.myHero
    if type(h.GetSpellData)~='function'then return end
    local profileName=h.charName:match('^Jade_')and 'classic'or 'normal'
    local p=M.profiles[profileName]
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
    if not p or p.verified~=true then
        -- Inspectable state; no adapter, menu consent or input path is registered.
        app.flashDefense={profile=profileName,disabled=p and p.reason or 'flash_profile_unknown'}
        return
    end
    app.flashDefense={profile=profileName,name=p.name}
    -- No Flash in either summoner slot: nothing to offer, nothing to show.
    local carried=false
    for slot=4,5 do local s=h:GetSpellData(slot);if s and s.name==p.name then carried=true end end
    if carried and app.menu and app.menu.Automation then
        -- One Flash switch (off) and its lethal-only choice, stored under ids of their own. Earlier builds
        -- asked twice (a global summoner switch and a Flash switch): Flash starts on only for a player who
        -- had both on. `menu.Summoners` is the name the code reads.
        local migration=app.sdk.MenuMigration;local saved=migration and migration.saved and migration.saved.OrbamaEvade or {}
        local function active(a,b)local row=type(saved[a])=='table'and saved[a][b];return type(row)=='table'and row.__active or nil end
        local on={id='Flash',name='Flash when nothing else can save you',value=false}
        local current=active('Automation','Flash')
        if type(current)=='boolean'then on.value=current
        else on.value=active('Automation','Summoners')==true and active('FlashDefense','Enabled')==true end
        local lethal={id='FlashOnlyLethal',name='Flash only for a hit that would kill',value=true}
        if migration then migration:Apply(lethal,'OrbamaEvade','FlashDefense.OnlyLethal','Automation.FlashOnlyLethal')end
        app.menu.Automation:MenuElement(on);app.menu.Automation:MenuElement(lethal)
        app.menu.Summoners=app.menu.Automation.Flash;app.menu.FlashOnlyLethal=app.menu.Automation.FlashOnlyLethal
    end
    local function consent()
        local m=app.menu
        if not m or not m.Summoners or not app.permissions.summoners then return false,false end
        return m.Summoners:Value()==true,m.FlashOnlyLethal:Value()==true
    end
    -- Slot and readiness come from the host every time: exact name, host
    -- CanUseSpell and cooldown. A sent or uncertain Flash stays unavailable
    -- until the host has been observed reporting it unavailable (DefenseReady).
    local function readySlot()
        if not app:Available()or not consent()then return nil end
        for slot=4,5 do
            local s=h:GetSpellData(slot)
            if s and s.name==p.name then
                local available=g.Game.CanUseSpell(slot)==0 and G.finite(s.currentCd or 0)and (s.currentCd or 0)<=0
                return app:DefenseReady('slot:'..slot,available)and slot or nil
            end
        end
    end
    local function landings(ctx,budget,visit)
        local origin=ctx.origin;local aim=ctx.intent;local base=0
        if G.point(aim)and G.dist(origin,aim)>5 then base=math.atan2(aim.z-origin.z,aim.x-origin.x)end
        for i=0,M.directions-1 do
            local k=i==0 and 0 or (i%2==1 and (i+1)/2 or -i/2)
            local angle=base+k*2*math.pi/M.directions;local dx,dz=math.cos(angle),math.sin(angle)
            -- Farthest non-wall point first: a landing beyond a thin wall is legal.
            -- Unknown terrain is not walkable ground; try a nearer point instead.
            for _,d in ipairs(M.distances)do
                if d<p.displacement then
                    local q={x=origin.x+dx*d,y=origin.y,z=origin.z+dz*d}
                    -- Cheap centre query first; then the champion disk (the same
                    -- check the blink evaluation applies) before a full evaluation.
                    if app.terrain:Wall(q,ctx.now,ctx.radius)==false
                        and app.terrain:Segment(q,q,ctx.radius,ctx.now,ctx.now,budget)==true then
                        if visit(q)==false then return end;break
                    end
                    if budget.remaining<=0 then return end
                end
            end
        end
    end
    app:RegisterDefense('summoner:flash',{validated=true,source=p.source,
        active=function()return app.active and h.charName~=nil end,
        options=function(ctx)
            local _,onlyLethal=consent()
            local slot=readySlot();if not slot then return {}end
            if ctx.profile~=profileName then  do end ;return {}end
            local walking,baseline=ctx.walking,ctx.walkingBaseline
            if type(baseline)~='table'then  do end ;return {}end
            if walkingSafe(walking)then  do end ;return {}end
            local outcome=walking and walking.known and walking or baseline
            local severe,why=M.Severe(outcome,onlyLethal)
            if not severe then  do end ;return {}end
            local work={};for k,v in pairs(ctx)do work[k]=v end;work.sharedBudget={remaining=M.workBudget}
            local threatRevision,terrainRevision=app.threats.revision,app.terrain.revision
            local offered,considered,safe={},0,0
            landings(ctx,work.sharedBudget,function(q)
                considered=considered+1
                local option={validated=true,profile=profileName,resource='slot:'..slot,summoner=true,cost=M.cost,slot=slot,
                    mobility={kind='blink',range=p.displacement,castDelay=p.castDelay},path={q},landing=q,
                    threatRevision=threatRevision,terrainRevision=terrainRevision}
                local r=app:EvaluateDefense(option,nil,work)
                if M.LandingSafe(app,r,baseline)then
                    safe=safe+1
                    -- Keep the best few by the planner's own ordering (safety,
                    -- danger, then intent direction). Tick re-ranks these offers.
                    local at=#offered+1
                    for j=1,#offered do if app.planner:Better(r,offered[j].result,ctx)then at=j;break end end
                    table.insert(offered,at,{option=option,result=r})
                    if #offered>M.maxOffered then offered[#offered]=nil end
                end
                if work.sharedBudget.remaining<=0 or app.threats.revision~=threatRevision
                    or app.terrain.revision~=terrainRevision then return false end
            end)
            if app.threats.revision~=threatRevision or app.terrain.revision~=terrainRevision then  do end ;return {}end
            local result={};for i,row in ipairs(offered)do result[i]=row.option end
             do end 
            return result
        end,
        prepare=function(option,ctx)
            local _,onlyLethal=consent()
            if readySlot()~=option.slot then return nil,'flash_not_ready'end
            if not app.sdk.Actions:GetAvailability().available then return nil,'flash_input_unavailable'end
            if option.threatRevision~=app.threats.revision or option.terrainRevision~=app.terrain.revision then return nil,'flash_state_changed'end
            local key=g[option.slot==4 and 'HK_SUMMONER_1'or 'HK_SUMMONER_2'];if not key then return nil,'flash_key_unknown'end
            local generation,revision,terrainRevision=app.serial,app.threats.revision,app.terrain.revision
            local expires=app.clock()+M.expiresMs;local landing=G.copy(option.landing)
            -- Cheap cancellation/context state only: no host or planner calls.
            local function current()
                return app:Current()and generation==app.serial and revision==app.threats.revision
                    and terrainRevision==app.terrain.revision and app.clock()<=expires
            end
            local intent={type='cast',key=key,kind='world',target=landing,resource=option.resource,expires=expires,
                prevalidateWorldCast=true,
                mechanical=function()return current()and readySlot()==option.slot,'flash_state_changed'end,
                commitGuard=function()return current(),'flash_state_changed'end,
                -- Full validation immediately before positioning, from fresh state.
                resolve=function()
                    if not current()or readySlot()~=option.slot then return nil,'flash_state_changed'end
                    local fresh=app:Context()
                    if fresh.trajectoryReason then return nil,fresh.trajectoryReason end
                    local distance=G.dist(fresh.origin,landing)
                    if distance>p.displacement-5 then  do end ;return nil,'flash_out_of_range'end
                    local baseline=app.planner:Evaluate(fresh.currentPath or {fresh.origin},fresh,nil,true)
                    if not M.Severe(baseline,onlyLethal)then  do end ;return nil,'flash_threat_resolved'end
                    local r=app:EvaluateDefense(option,nil,fresh)
                    if not M.LandingSafe(app,r,baseline)or not current()then  do end ;return nil,'flash_landing_changed'end
                     do end 
                    return {position=landing}
                end}
            local utils=app.sdk.OrbamaUtils
            local caps=utils and utils:active()and utils.GetCapabilities and utils:GetCapabilities()
            if caps and caps.flashRequests and utils.Flash then
                intent.utilityFlash={range=p.displacement,
                    authorized=function()return current()and app.active and app.enabled and not app:Bypass()and consent()end}
            end
            return intent
        end})
end
return M

end
