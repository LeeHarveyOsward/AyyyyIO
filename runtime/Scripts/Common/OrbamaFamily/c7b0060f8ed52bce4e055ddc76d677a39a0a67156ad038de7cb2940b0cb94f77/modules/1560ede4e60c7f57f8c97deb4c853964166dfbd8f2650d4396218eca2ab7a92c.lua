return function(require)
local U=require('utils.util');local P=require('CombatProfiles.world')
local S={};S.__index=S
-- Pure functions of the host charName string. Live team, health, position,
-- visibility and targetability are never memoised here.
local NIL_CLASS={category=P.category(nil),normalized=U.name(nil),jungle=P.jungleEntity(nil)}
NIL_CLASS.epic=P.epics[NIL_CLASS.category]==true
local classes,classCount={},0
local function classify(name)
    if type(name)~='string'then return NIL_CLASS end
    local row=classes[name]
    if row then return row end
    if classCount>=512 then classes={};classCount=0 end
    local category=P.category(name)
    row={category=category,epic=P.epics[category]==true,jungle=P.jungleEntity({charName=name}),normalized=U.name(name)}
    classes[name]=row;classCount=classCount+1
    return row
end
S.classify=classify
-- While every nearby objective camp is freshly observed down, the broad native
-- object sweep is chunked more finely and runs less often. Hover and network-ID
-- discovery, retained indices and listed minions still refresh on every call.
S.knownDownChunk=128;S.knownDownInterval=.1;S.campStateMaxAge=1;S.respawnLead=5
-- Armed boss Smite (the ancestor LHO r84 smitePreaim, without its early hover):
-- a boss in range whose health falls fast enough to reach the lethal threshold
-- within armWindow seconds gets its critical Smite queued behind a ready gate
-- on current lethal health. It owns no cursor and sends nothing while the gate
-- is closed; the provider dispatches it at its next pass once lethal, with the
-- request, aim candidates and slot reservation already in place. The send-time
-- validator still re-reads every mechanic. Unsent, it expires after armTTL ms.
S.armWindow=.3;S.armTTL=400;S.armSample=.1
function S.new(ctx,actions) return setmetatable({ctx=ctx,actions=actions},S) end
function S:resolve()
    for slot=4,5 do
        local d=self.ctx:spell(slot);local name=(d.name or ''):lower()
        if name=='summonersmite_jade' then return slot,true,d end
        if P.smites[U.name(name)] then return slot,false,d end
    end
end
function S:damageFor(slot,classic,d)
    local override=self.ctx.config:get('smiteOverride')
    if override>0 then return override end
    if not slot then return 0 end
    if classic then
        -- Live Classic exposes its current true-damage value on the caster.
        local buff=U.buff(myHero,{smitedamagebuff=true},self.ctx:now())
        local value=buff and buff.stacks
        if buff and (buff.count==nil or buff.count>0) and type(value)=='number' and value>=100 and value<=2000 then return value end
        return 460+30*U.clamp((myHero.levelData and myHero.levelData.lvl) or 1,1,18)
    end
    return P.smites[U.name(d.name)] or 0
end
function S:damage()
    local override=self.ctx.config:get('smiteOverride')
    if override>0 then return override end
    return self:damageFor(self:resolve())
end
function S:readyFor(slot,classic,d,validatingOwnedRequest)
    if not slot or not self.ctx:ready(slot)then return false end
    if not validatingOwnedRequest then
        local id,action,reserved=self.actions:SlotAction(slot)
        if id or reserved then
            if not action or action.sentAt or action.sendAttemptedAt or action.state~='waiting'then return false end
        end
    end
    return classic or (type(d.ammo)=='number' and d.ammo>0)
end
function S:ready(validatingOwnedRequest)
    local slot,classic,d=self:resolve()
    return self:readyFor(slot,classic,d,validatingOwnedRequest)
end
function S:inRange(target)
    local _,classic=self:resolve()
    local range=classic and 760 or 500
    -- Center-to-center is deliberately conservative until edge semantics are measured.
    return U.dist(myHero.pos,target.pos)<=range
end
function S:Policy(target)
 local cfg=self.ctx.config;if not cfg:get('autosmite')then return false end
 local cat=classify(target and target.charName).category
 return cfg:get(P.epics[cat]and 'smiteBosses'or(cat=='Red'or cat=='Blue')and 'smiteBuffs'or 'smiteOther')==true
end
function S:cast(target,owner,requireLethal,options)
    options=options or {}
    if not options.authorized and not self:Policy(target)then return false,'smite_category_disabled'end
    if not self:ready() or not U.valid(target) or target.team==myHero.team or target.isImmortal or not self:inRange(target) then return false end
    local slot,classic=self:resolve()
    -- An enemy lane minion only through an explicit laneMinion request.
    local minion=options.laneMinion==true and target.team~=300
    if minion and classic then return false,'classic_minion_smite_unverified'end
    local function eligible(t)if minion then return self:minionTarget(t)end;return self:campTarget(t)end
    if not eligible(target) then return false,minion and 'not_a_lane_minion'or nil end
    local margin=self:margin(target)
    if requireLethal and not options.armed and (target.health or 0)+(target.allShield or 0)>self:damage()-margin then return false end
    local identity=U.id(target);local handle,name=target.handle,target.charName
    local lookup=self.objectiveLookups and self.objectiveLookups[identity]
    local function matches(m)
        return (type(m)=='table' or type(m)=='userdata') and U.id(m)==identity and m.handle==handle and m.charName==name
    end
    local function currentTarget()
        if not lookup then return matches(target)and target or nil end
        if Game.GetObjectByNetID then
            local ok,m=pcall(Game.GetObjectByNetID,identity)
            if ok and matches(m) then return m end
        end
        if lookup.index and Game.Object then
            local m=Game.Object(lookup.index)
            if matches(m) then return m end
        end
        if Game.GetUnderMouseObject then
            local ok,m=pcall(Game.GetUnderMouseObject)
            if ok and matches(m) then return m end
        end
    end
    -- Send-time validation deliberately re-reads everything: slot, readiness,
    -- identity, range, eligibility, HP and shield. No preparation is reused.
    local function validAtKeypress()
        if not options.authorized and not self:Policy(target)then return false,'smite_category_disabled'end
        if not self:ready(true) or self:resolve()~=slot then return false,'smite_slot_or_readiness_changed' end
        local target=currentTarget()
        if not U.valid(target) or not eligible(target) or target.isImmortal then return false,'smite_target_unavailable' end
        if not self:inRange(target) then return false,'smite_out_of_range' end
        if requireLethal and target.health+(target.allShield or 0)>self:damage()-self:margin(target) then return false,'smite_not_lethal' end
        return (options.authorized and options.authorized()or not options.authorized and self.ctx.config:get('autosmite')) and not self.ctx:blocked() and self:ready(true)
            and self:resolve()==slot
            and U.valid(target) and eligible(target) and not target.isImmortal and self:inRange(target)
            and (not requireLethal or target.health+(target.allShield or 0)<=self:damage()-self:margin(target))
    end
    -- Smite is the most urgent input. A Smite whose target could not be verified
    -- under the cursor (no key was sent) is requested again on the next callback;
    -- only consecutive aim failures on the same monster back off, bounded (bosses
    -- .1 s, others .25 s), so a cursor that keeps moving cannot starve other input.
    -- Live 2026-10-10 (Yi, red buff at 25:04): one aim_position_mismatch cost the
    -- whole former .25 s backoff before the lethal Smite was sent.
    -- Sent or uncertain input is never replayed here.
    local epic=P.epics[classify(target.charName).category]==true
    local last=self.lastSmite
    if last and last.identity==identity then
        if not last.checked then
            local r=self.actions.inputAction and self.actions:inputAction(last.id)
            local reason=r and tostring(r.reason or '')or ''
            local aimFailed=r and not r.sentAt and(r.state=='aborted'or r.state=='cancelled_before_send')
                and(reason:find('hover',1,true)or reason:find('aim',1,true)or reason:find('capture',1,true)or reason:find('identity',1,true))
            if aimFailed then
                last.checked=true;last.aimFailures=(last.aimFailures or 0)+1
                local n=last.aimFailures
                last.retryAt=self.ctx:now()+(n<=1 and 0 or math.min(epic and .1 or .25,.05*(n-1)))
            elseif not r or r.sentAt or r.state=='complete'or r.state=='cancelled_before_send'or r.state=='aborted'then last.checked=true;last.aimFailures=nil end
        end
        if last.retryAt and self.ctx:now()<last.retryAt then return false,'smite_retry_backoff'end
    end
    -- Armed: held unsent until the current target is lethal (no cursor before).
    local ready=options.armed==true and requireLethal==true and function()
        local t=currentTarget()
        return U.valid(t) and t.health+(t.allShield or 0)<=self:damage()-self:margin(t)
    end or nil
    local accepted,event=self.actions:cast(slot,target,owner,{urgent=true,interrupt=true,delay=.02,verifyHover=true,independent=true,
        smiteExecute=requireLethal==true and epic,validate=validAtKeypress,context=options.context,ready=ready,ttl=ready and S.armTTL or nil})
    if accepted and type(event)=='table'and(not last or last.id~=event.id)then
        self.lastSmite={id=event.id,event=event,identity=identity,
            aimFailures=last and last.identity==identity and last.checked and last.aimFailures or nil}
    end
    return accepted,event
end
function S:Status(target)
    local slot,classic,d=self:resolve()
    local event=slot and self.actions:SlotEvent(slot)
    return {at=self.ctx:now(),profile=self.ctx.profile.id,slot=slot,ready=self:readyFor(slot,classic,d),damage=self:damageFor(slot,classic,d),
        range=classic and 760 or 500,inRange=target and self:inRange(target)or nil,
        eligible=target and self:campTarget(target)or nil,pending=event and {id=event.id,status=event.status,at=event.at}or nil}
end
function S:Request(target,options)
    options=options or {}
    if not options.owner or type(options.authorized)~='function'then return false,'explicit_authorization_required'end
    return self:cast(target,options.owner,options.lethal~=false,options)
end
function S:margin(target)
    return self.ctx.config:get(classify(target.charName).epic and 'smiteEpicMargin' or 'smiteMargin')
end
function S:campTarget(target)
    if not target or target.team~=300 then return false end
    local class=classify(target.charName)
    if not class.jungle then return false end
    if class.epic then return true end
    -- Identity, never relative HP: a surviving/scaled companion must not
    -- become the main monster when the large monster dies or leaves vision.
    local names=self.ctx.profile.id=='classic' and P.classicSmiteTargets or P.normalSmiteTargets
    return names[class.normalized]==true
end
-- An enemy lane minion (Normal only), for an explicit Request with
-- options.laneMinion=true: a champion clearing its own skillshot path, never
-- automatic Smite. Normal Smite deals its listed true damage to minions as to
-- monsters (League wiki Smite, V26.01, read 2026-10-10). Classic minion Smite
-- is not verified for this mode and is refused in cast().
function S:minionTarget(target)
    if not target or self.ctx.profile.id~='normal' or not Obj_AI_Minion or target.type~=Obj_AI_Minion
        or target.team==300 or target.team==myHero.team or not U.valid(target) then return false end
    return classify(target.charName).normalized:find('minion',1,true)~=nil
end
-- Health slope of one boss, from samples at least armSample apart (bounded rows).
function S:healthSlope(m,now)
    local id=U.id(m);if not id or not U.finite(m.health) then return 0 end
    local rows=self.objectiveHealth or {};self.objectiveHealth=rows
    local prior=rows[id];local dps=0
    if prior and now-prior.at>=.05 and now-prior.at<=.6 then dps=math.max(0,(prior.hp-m.health)/(now-prior.at)) end
    if not prior or now-prior.at>=S.armSample or now<prior.at then
        local n=0;for key,row in pairs(rows) do if now-row.at>2 or now<row.at then rows[key]=nil else n=n+1 end end
        if n<8 or rows[id] then rows[id]={hp=m.health,at=now} end
    end
    return dps
end
-- True only when every nearby objective camp is known down away from its
-- expected respawn, in rows the shared camp service reconciled recently.
-- Unknown, stale, up or unmatched state keeps full cadence.
function S:objectivesKnownDown(now)
    local c=self.ctx;local service=c.Camps
    if not service or service.closed or type(service.reconciledAt)~='number' or now-service.reconciledAt>S.campStateMaxAge then return false end
    local any=false
    for _,r in pairs(service.rows or {}) do
        if P.epics[r.category] and r.pos and U.dist(myHero.pos,r.pos)<1400 then
            if r.state~='empty_known' or #(r.members or {})>0
                or r.expectedAt and now>=r.expectedAt-S.respawnLead then return false end
            any=true
        end
    end
    return any
end
-- `monsters`: the neutral (team 300) members of `targets`, read in this refresh.
-- Only a neutral identity can be added below, so only those need de-duplication.
-- Returns the targets and the neutral list, both extended with added monsters.
function S:objectiveTargets(targets,nearObjective,monsters)
    local c=self.ctx;local now=c:now();local extra={};local seen={};local lookups={};local listed=false
    self.objectiveLookups=lookups
    local origin=myHero.pos
    if not monsters then monsters={};for _,m in ipairs(targets) do if m.team==300 then monsters[#monsters+1]=m end end end
    for _,m in ipairs(monsters) do
        local id=U.id(m);if id then seen[id]=true end
        local class=classify(m.charName)
        if class.epic and class.jungle and U.valid(m) and U.dist(origin,m.pos)<1600 then listed=true end
    end
    local function accept(m,source,index)
        local kind=type(m)
        if kind~='table' and kind~='userdata' then return false end
        -- Most native objects are not objective monsters. Reject their identity
        -- before reading live health/visibility/targetability through the host.
        -- Eligible identities still receive every fresh mechanical check.
        if not Obj_AI_Minion or m.type~=Obj_AI_Minion or m.team~=300 then return false end
        local class=classify(m.charName)
        if not class.epic or not class.jungle
            or not U.valid(m) or U.dist(myHero.pos,m.pos)>=1600 then return false end
        local id=U.id(m);if not id then return false end
        if lookups[id] and index then lookups[id].index=index end
        if not seen[id] then
            seen[id]=true;extra[#extra+1]=m;lookups[id]={index=index}

        end
        return true
    end
    if Game.GetUnderMouseObject then
        local ok,m=pcall(Game.GetUnderMouseObject)
        if ok and accept(m,'native_hover') then self.objectiveID=U.id(m) end
    end
    if self.objectiveID and Game.GetObjectByNetID then
        local ok,m=pcall(Game.GetObjectByNetID,self.objectiveID)
        if not ok or not m or U.id(m)~=self.objectiveID or not accept(m,'native_identity') then
            self.objectiveID=nil
        end
    end
    if nearObjective and not listed and Game.ObjectCount and Game.Object then
        local indices=self.objectiveIndices or {};local retained={}
        for _,index in ipairs(indices) do
            local m=Game.Object(index)
            if accept(m,'native_object_index',index) then retained[#retained+1]=index end
        end
        self.objectiveIndices=retained
        if now>=(self.objectiveScanAt or 0) then
            local quiet=#retained==0 and #extra==0 and self:objectivesKnownDown(now)
            local count=U.count(Game.ObjectCount(),65536)
            local index=self.objectiveScanIndex or 1
            if index>count then index=1 end
            local stop=math.min(count,index+(quiet and S.knownDownChunk or 512)-1)
            local indexed={};for _,i in ipairs(retained) do indexed[i]=true end
            for i=index,stop do
                if not indexed[i] and accept(Game.Object(i),'native_object_scan',i) and #retained<8 then
                    retained[#retained+1]=i
                end
            end
            self.objectiveScanIndex=stop>=count and 1 or stop+1
            self.objectiveScanAt=now+(#retained>0 and .1 or quiet and S.knownDownInterval or .02)
            self.objectiveScanQuiet=quiet
        end
    elseif not nearObjective then
        self.objectiveIndices=nil;self.objectiveScanIndex=nil;self.objectiveScanAt=nil
    end
    if #extra==0 then return targets,monsters end
    local result={};for _,m in ipairs(targets) do result[#result+1]=m end
    local neutral={};for _,m in ipairs(monsters) do neutral[#neutral+1]=m end
    for _,m in ipairs(extra) do result[#result+1]=m;neutral[#neutral+1]=m end
    return result,neutral
end
-- One identity preparation per refresh (Game.Timer value + SDK observation
-- cycle + unchanged minion source list), shared by the urgent epic-only pass and
-- the ordinary tick pass. It holds wrappers only; every health/range/eligibility
-- read stays per call, and cast() plus its send-time validator re-read all
-- mechanics.
function S:prepareTargets(now)
    local c=self.ctx
    local shared=c.sdk and c.sdk.SharedData;local cycle=shared and shared.cycle
    local cache=c.monsterCache
    local source=cache and cache.source==c.minions and cache.units or c.minions or {}
    local prep=self.prepared
    if prep and prep.at==now and prep.cycle==cycle and prep.source==source then
        return prep.targets,prep.freshScan,prep.monsters
    end
    local targets=source
    -- The neutral members are found once per refresh: the candidate passes below
    -- and the objective lookup read only those, never every lane minion again.
    local origin=myHero.pos
    local function neutral(list)
        local out={};for _,m in ipairs(list) do if m and m.team==300 then out[#out+1]=m end end;return out
    end
    local monsters=neutral(targets)
    -- Re-enumerate in a nearby objective contest so replacement wrappers and
    -- fresh health do not wait for the general 80 ms object-cache refresh.
    local freshScan=false
    for _,m in ipairs(monsters) do
        if classify(m.charName).epic and U.dist(origin,m.pos)<1400 then freshScan=true;break end
    end
    -- A boss appearing in vision must not first wait for the ordinary cache.
    -- Profile-bound camp anchors are only a reason to enumerate, never proof
    -- that an objective exists, is visible, or is legally smiteable.
    if not freshScan then
        for _,camp in pairs(c.farm and c.farm.known or {}) do
            if P.epics[camp.category] and U.dist(origin,camp.pos)<1400 then freshScan=true;break end
        end
    end
    if freshScan and Game.MinionCount and Game.Minion then
        targets={}
        for i=1,U.count(Game.MinionCount(),4096) do local fresh=Game.Minion(i);if fresh then targets[#targets+1]=fresh end end
        monsters=neutral(targets)
    end
    targets,monsters=self:objectiveTargets(targets,freshScan,monsters)
    prep=prep or {};self.prepared=prep
    prep.at=now;prep.cycle=cycle;prep.source=source;prep.targets=targets;prep.freshScan=freshScan;prep.monsters=monsters
    return targets,freshScan,monsters
end
function S:auto(epicsOnly)
    local c=self.ctx
    local stamp=epicsOnly and 'epicAt' or 'fullAt'
    local now=c:now()
    if self[stamp]==now then return false end
    self[stamp]=now
    local best,rank=nil,-1
    local enabled=c.config:get('autosmite')
    if not enabled or c:blocked()then
        self.decision=not enabled and 'Toggle OFF'or 'Unavailable / cooldown / pending input'
        return false
    end
    -- One Smite slot resolution per call. cast() resolves again for dispatch.
    local slot,classic,spell=self:resolve()
    local ready=self:readyFor(slot,classic,spell)
    if not ready then
        self.decision='Unavailable / cooldown / pending input'
        return false
    end
    local targets,freshScan,monsters=self:prepareTargets(now)
    if #targets==0 and not self.contest then
        self.decision='No eligible monster in range'
        if not freshScan then return false end
    end
    local damage=self:damageFor(slot,classic,spell)
    -- One synchronous candidate pass shares its range profile. No input is sent
    -- until cast(), which resolves readiness/range again and retains dispatch
    -- validation. Candidate count must not multiply native spell-data reads.
    local range=classic and 760 or 500
    local reserve=not epicsOnly and c.config:get('smiteReserve')==true and c.farm and c.farm:epicSoon()
    self.decision='No eligible monster in range'
    local objectiveCount=0;local warm,warmExcess
    local margins=c.config;local origin=myHero.pos
    -- Neutral members only (read once per refresh); health, range and validity
    -- are read here for every candidate.
    for _,m in ipairs(monsters) do
        do
        local class=classify(m.charName);local cat=class.category;local epic=class.epic
        local distance=U.dist(origin,m.pos)
        if epic and distance<1600 and objectiveCount<8 then
            objectiveCount=objectiveCount+1

        end
        if distance<=range and class.jungle and U.valid(m) then
            local lethal=damage-margins:get(epic and 'smiteEpicMargin' or 'smiteMargin')
            local dps=epic and self:healthSlope(m,now) or 0
            if self:Policy(m)and(epic or not epicsOnly and self:campTarget(m)and not reserve) and m.health+(m.allShield or 0)<=lethal then
                local score=(cat=='Baron' or cat=='Elder') and 4 or epic and 3 or (cat=='Red' or cat=='Blue') and 2 or 1
                if score>rank then best,rank=m,score end
            elseif epic and dps>0 and self:Policy(m) then
                local excess=m.health+(m.allShield or 0)-lethal
                if excess<=dps*S.armWindow and excess<=damage*.5 and (not warm or excess<warmExcess) then warm,warmExcess=m,excess end
            elseif not epic and reserve then self.decision='Reserved for active nearby objective'
            elseif m.health+(m.allShield or 0)>lethal then self.decision='Waiting for lethal health' end
        end
        end
    end
    local ok=false
    if best then
        ok=self:cast(best,'autosmite',true)
        self.decision=ok and 'Execute requested' or 'Execute waiting for dispatcher'
    elseif warm then
        local armed=self:cast(warm,'autosmite',true,{armed=true})
        self.decision=armed and 'Armed: waiting for lethal health' or 'Waiting for lethal health'
    end
    self.contest=objectiveCount>0 or freshScan
    return ok
end
function S:clear(target,owner)
    if not self.ctx.config:get('autosmite') or not self:ready() or not U.valid(target) then return false end
    if self:auto(true) then return true end
    if classify(target.charName).epic then return self:cast(target,'autosmite',true) end
    if not self:Policy(target)then return false end
    -- Attack priority may be a small monster while the buff is already lethal.
    for _,camp in pairs(self.ctx.farm and self.ctx.farm.known or {}) do
        local found=false
        for _,m in ipairs(camp.members or {}) do if U.same(m,target) then found=true;break end end
        if found then
            for _,m in ipairs(camp.members or {}) do
                if U.valid(m) and self:campTarget(m) and (not self:campTarget(target)
                    or (m.maxHealth or 0)>(target.maxHealth or 0)) then target=m end
            end
            break
        end
    end
    if not self:campTarget(target) then return false end
    if self.ctx.config:get('smiteReserve')==true and self.ctx.farm and self.ctx.farm:epicSoon() then return false end
    return self:cast(target,'autosmite',true)
end
function S:followAim()
    local c=self.ctx;local aim=self.actions.hoverAim
    if not aim or aim.owner~='autosmite' or not c.config:get('autosmite') or c:blocked() then return false end
    if not self.actions:ownsHoverAim(aim.target,'autosmite') then return false end
    if not self:Policy(aim.target)or not classify(aim.target.charName).epic and c.config:get('smiteReserve')==true and c.farm:epicSoon()then return false end
    return self:cast(aim.target,'autosmite',true)
end
return S

end
