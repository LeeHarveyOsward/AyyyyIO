return function(require)
return function(g, modules, champion)
    local sdk=g.SDK;local hero=g.myHero;local registry=g.AyyyyIOControllers;local slots,logicalSlots={},{}
    if registry and registry.Shutdown then registry:Shutdown('superseded') end
    local C={version='2.1.11',generation=(registry and registry.generation or 0)+1,enabled=true,
        pending={},history={},observedSpells={},spellStates={},locks={},menus={},diagnostics={},cleanupCount=0,metrics={requested=0,sent=0,observed=0,rejected=0},claims={}}
    g.AyyyyIOControllers=C
    C.core=assert(sdk.ChampionCore:Create({name='AyyyyIO:'..champion,clientName='AyyyyIOControllers',
        profile={id=hero.charName:match('^Jade_')and'classic'or'normal',champion=champion,runtime=hero.charName},
        current=function()return C.enabled and g.AyyyyIOControllers==C end,onDeactivate=function()C.enabled=false end}))
    function C:Trace()end
    local function point(v) return v and {x=v.x,y=v.y or 0,z=v.z} end
    local function finiteNumber(v)return type(v)=='number'and v==v and v>-math.huge and v<math.huge end
    local function pack(...)return {n=select('#',...),...}end
    local function clone(t)
        local o={};for k,v in pairs(t)do o[k]=v end;return setmetatable(o,getmetatable(t))
    end
    function C:CreateGameplay(controller,hooks)
        return assert(self.gameplay):newController(controller,hooks)
    end
    function C:Active()
        return self.core:Active()
    end
    function C:Cancel(owner,reason)
        for _,q in pairs(self.pending)do if not owner or q.owner==owner then q.cancelled=true;q.callbacks={};self.adapter:Cancel(q.id,reason or "owner_cancelled")end end
    end
    function C:RegisterCleanup(name,callback)
        local options={group='champion',limit=16}
        if type(name)~='string'or name==''or type(callback)~='function'then
            return self.core:RegisterCleanup(name,callback,options)
        end
        local registered=self.cleanupDispatchers and self.cleanupDispatchers[name]
        if registered and registered.original==callback then
            return self.core:RegisterCleanup(name,registered.dispatch,options)
        end
        local dispatch=function(reason)
            local previous=self.cleaningChampion;self.cleaningChampion=true
            local ok,why=pcall(callback,reason);self.cleaningChampion=previous
            if not ok then error(why,0)end
        end
        local accepted,why=self.core:RegisterCleanup(name,dispatch,options)
        if accepted then
            self.cleanupDispatchers=self.cleanupDispatchers or {}
            self.cleanupDispatchers[name]={original=callback,dispatch=dispatch}
        end
        return accepted,why
    end
    function C:Current()
        return self.core:Current()
    end
    function C:GetKnowledge()
        if self.knowledgeScope and self.knowledgeScope:Alive()then return self.knowledgeScope end
        local utilities=sdk.OrbamaUtils;local service=utilities and utilities.Knowledge
        if not service or type(service.Register)~='function'or not self:Current()then return nil,'knowledge_unavailable'end
        local scope,why=service:Register('AyyyyIO:'..champion,{active=function()return C:Current()end,lastSeen=true,recalls=true,bases=true})
        if not scope then return nil,why end
        self.knowledgeScope=scope
        self.core:RegisterCleanup('shared-knowledge',function()scope:Close();if C.knowledgeScope==scope then C.knowledgeScope=nil end end)
        return scope
    end
    local function unregisterDefenses(bindings)
        if not bindings then return end
        for _,row in pairs(bindings)do
            if row.provider and row.token then
                if row.resource then pcall(row.provider.UnregisterDefensePolicy,row.provider,row.resource,row.key,row.token)
                else pcall(row.provider.UnregisterDefense,row.provider,row.key,row.token)end
            end
            row.provider=nil;row.token=nil
        end
    end
    function C:RegisterDefense(name,spec)
        if not self:Current()then return false,'controller_closed'end
        if not sdk.OrbamaVersion then return false,'unsupported'end
        if type(name)~='string'or name==''or #name>80 or type(spec)~='table'or spec.validated~=true
            or type(spec.source)~='string'or spec.source==''or type(spec.options)~='function'or type(spec.prepare)~='function'
            or spec.active~=nil and type(spec.active)~='function'then return false,'verified_adapter_required'end
        self.defenseBindings=self.defenseBindings or {}
        local old=self.defenseBindings[name]
        if old then return old.original==spec,old.original==spec and 'already_registered'or 'defense_owner_exists'end
        if (self.defenseBindingCount or 0)>=8 then return false,'defense_limit'end
        local adapter={};for key,value in pairs(spec)do adapter[key]=value end
        local active=spec.active
        adapter.active=function()return self:Current()and(not active or active()==true)end
        local row={original=spec,adapter=adapter,key='AyyyyIO:'..hero.charName..':'..name..':'..self.generation}
        self.defenseBindings[name]=row
        self.defenseBindingCount=(self.defenseBindingCount or 0)+1
        self:MaintainDefenses(row)
        return true,'registered_or_waiting_for_evade'
    end
    function C:MaintainDefenses(added)
        local bindings=self.defenseBindings;if not bindings then return end
        local provider=sdk.Evade
        if self.defenseProvider==provider and not added then return end
        local changed=self.defenseProvider~=provider
        if changed then unregisterDefenses(bindings);self.defenseProvider=provider end
        if not provider or type(provider.GetCapabilities)~='function'or type(provider.RegisterDefense)~='function'
            or type(provider.UnregisterDefense)~='function'then return end
        local ok,caps=pcall(provider.GetCapabilities,provider)
        if not ok or not caps or not caps.defenseRegistration or caps.defenseRegistrationVersion~=1 then return end
        local pending=not changed and added and {added}or bindings
        for _,row in pairs(pending)do
            local ran,accepted,token
            if row.resource then
                if caps.defensePolicies and caps.defensePolicyVersion==1 and type(provider.RegisterDefensePolicy)=='function'
                    and type(provider.UnregisterDefensePolicy)=='function'then
                    ran,accepted,token=pcall(provider.RegisterDefensePolicy,provider,row.resource,row.key,row.adapter)
                end
            else ran,accepted,token=pcall(provider.RegisterDefense,provider,row.key,row.adapter)end
            if ran and accepted and token~=nil then row.provider=provider;row.token=token end
        end
    end
    function C:RegisterDefensePolicy(name,resource,spec)
        if not self:Current()then return false,'controller_closed'end
        if type(name)~='string'or name==''or #name>80 or type(resource)~='string'or resource==''or #resource>100
            or type(spec)~='table'or type(spec.allow)~='function'or type(spec.source)~='string'or spec.source==''
            or spec.active~=nil and type(spec.active)~='function'then return false,'defense_policy_required'end
        self.defenseBindings=self.defenseBindings or {};local key='policy:'..name
        local old=self.defenseBindings[key]
        if old then return old.original==spec and old.resource==resource,'defense_policy_owner_exists'end
        if(self.defenseBindingCount or 0)>=8 then return false,'defense_limit'end
        local adapter={};for k,v in pairs(spec)do adapter[k]=v end
        adapter.active=function()return self:Current()and(not spec.active or spec.active()==true)end
        local row={original=spec,adapter=adapter,resource=resource,key='AyyyyIO:'..hero.charName..':'..key..':'..self.generation}
        self.defenseBindings[key]=row;self.defenseBindingCount=(self.defenseBindingCount or 0)+1
        self:MaintainDefenses(row);return true,'registered_or_waiting_for_evade'
    end
    -- One timed-shield offer for every controller (class-style champions and the
    -- gameplay core). The defensive consumer (Evade) judges the danger; there is
    -- no per-ability switch. The controller declares the kit:
    --   name,slot,key,profile,source   identity and provenance of the numbers
    --   amount=fn                      current shield capacity (<=0: no offer)
    --   duration=number|fn             seconds the shield lasts
    --   delay=number                   cast delay; the provider launch estimate is added
    --   start=number                   instead of delay: fixed seconds from request to shield
    --   ready=fn                       champion state: stage, own sequence on the slot, consent of a recipient
    --   spell=string                   optional required spell name (stage)
    --   target=fn, kind=string         optional cast recipient and intent kind
    -- The service owns the shared readiness (controller available, timed-shield
    -- capability, spell learned/ready/affordable, no own input in flight on the
    -- key), the option and the dispatch-time mechanical check. A returned intent
    -- is a request, not a shield. Returns accepted, reason, spec.
    function C:RegisterShield(spec)
        if type(spec)~='table'or type(spec.name)~='string'or type(spec.slot)~='number'or spec.key==nil
            or type(spec.source)~='string'or spec.source==''or type(spec.amount)~='function'
            or spec.ready~=nil and type(spec.ready)~='function'or spec.target~=nil and type(spec.target)~='function'
            or type(spec.duration)~='function'and not finiteNumber(spec.duration)
            or(spec.start==nil)==(spec.delay==nil)or not finiteNumber(spec.start or spec.delay)or(spec.start or spec.delay)<0
            or spec.start and spec.start<.05 then return false,'invalid_shield_spec'end
        -- shieldType 'physical' or 'magical' for a shield that only absorbs that damage (default 'all');
        -- ccImmune=true for one that also removes control while it holds.
        local shieldType=spec.shieldType or 'all'
        if shieldType~='all'and shieldType~='physical'and shieldType~='magical'or spec.ccImmune~=nil and type(spec.ccImmune)~='boolean'then return false,'invalid_shield_spec'end
        local slot,key,resource,margin,fixed=spec.slot,spec.key,'slot:'..spec.slot,.05,spec.start~=nil
        local function capable()
            local evade=sdk.Evade;local caps=evade and evade.GetCapabilities and evade:GetCapabilities()
            return caps and caps.timedShields==true
        end
        local function ready()
            if g.myHero~=hero or not self:Available()then return false end
            local s=hero:GetSpellData(slot)
            if not s or(s.level or 0)<1 or spec.spell and s.name~=spec.spell or g.Game.CanUseSpell(slot)~=0 or(s.currentCd or 0)>0
                or type(s.mana)=='number'and s.mana>hero.mana then return false end
            local q=self.pending[key];if q and q.sentAt then return false end
            if spec.ready and not spec.ready()then return false end
            return true
        end
        local function amount()local v=spec.amount();return finiteNumber(v)and v or 0 end
        local function duration()local d=spec.duration;if type(d)=='function'then d=d()end;return finiteNumber(d)and d or 0 end
        -- Seconds from the request until the cast completes.
        local function lead()
            if fixed then return spec.start-margin end
            local p=g.OrbamaPrediction
            local v=p and p.GetLaunchDelay and p:GetLaunchDelay({Delay=spec.delay})
            return finiteNumber(v)and v or math.huge
        end
        local function window(now,l,d)
            if fixed then return now+spec.start,now+d end
            return now+l+margin,now+l+d
        end
        local adapter={validated=true,source=spec.source,
            options=function(context)
                if not capable()or not ready()or not finiteNumber(context.now)then return {}end
                local value,l,d=amount(),lead(),duration()
                if value<=0 or not finiteNumber(l)or d<=margin then return {}end
                local starts,ends=window(context.now,l,d)
                return {{validated=true,profile=spec.profile,resource=resource,slot=slot,cost=20,launch=l,
                    effect={kind='shield',shieldType=shieldType,ccImmune=spec.ccImmune==true or nil,amount=value,starts=starts,ends=ends}}}
            end,
            prepare=function(option,context)
                if not capable()or not ready()or not option.effect or option.profile~=spec.profile or option.resource~=resource
                    or option.effect.kind~='shield'or not finiteNumber(context.now)or not finiteNumber(option.launch)or lead()~=option.launch
                    or option.effect.amount~=amount()then return nil,'shield_state_changed'end
                local starts,ends=window(context.now,option.launch,duration())
                if option.effect.starts~=starts or option.effect.ends~=ends then return nil,'shield_state_changed'end
                local expires=self.adapter:Now()+20;local requested=g.Game.Timer()
                local target=nil;if spec.target then target=spec.target()end
                return {type='cast',key=key,target=target,kind=spec.kind,resource=resource,expires=expires,
                    mechanical=function()
                        local elapsed=g.Game.Timer()-requested;local l=lead()
                        return ready()and self.adapter:Now()<=expires and finiteNumber(elapsed)and elapsed>=0
                            and finiteNumber(l)and elapsed+l<=option.launch+margin and ends-context.now-elapsed>l
                            and option.effect.amount==amount(),'shield_state_changed'
                    end}
            end}
        local accepted,why=self:RegisterDefense(spec.name,adapter)
        return accepted,why,adapter
    end
    -- Own defensive effects beyond shields (Evade capability `defenseEffects`, version 1). One offer per
    -- registration; Evade judges the danger and asks for the cast, which this controller submits through its
    -- own ActionClient (C:Cast, owner 'evade_defense') with its slot readiness and cleanup. Common fields:
    --   kind,name,slot,key,profile,source   identity and provenance of every number below (profile data only)
    --   delay=number | start=number         as RegisterShield (cast delay plus launch estimate, or fixed lead)
    --   duration=number|fn                  seconds it lasts (not for an instant heal or a teleport)
    --   ready=fn, spell=string, ultimate=true, cost=number
    --   channel=true                        the hero can neither move nor attack while it lasts
    --   target=fn                           optional object recipient (default: no target, a self cast)
    -- Kind fields; a number or fn returning the current value. nil, non-finite or out of range: no offer.
    --   reduction         fraction (0..1, physical and magical) or fractions={physical=,magical=}; optional
    --                     stages={{seconds=s,fraction=f},...,{fraction=f}} (each measured from the cast landing,
    --                     the last one lasts to the end). True damage is never reduced.
    --   resist            armor and/or magicResist (flat bonus)
    --   haste             flat or percent (a fraction: .4 is 40 %) bonus movement speed; castStops=true when the
    --                     hero stands still until it lands
    --   heal              amount (instant, capped at missing health) or amount+bonus=true+duration (bonus health)
    --   directional_block angle (full cone, degrees), channel=true; blocksControl=true if it also stops control.
    --                     Cast toward the unit `option.aim` Evade picks (a world point 100 units away)
    --   attack_dodge      duration only (basic attacks miss)
    --   owned_teleport    destinations=fn -> up to 3 rows {id=, position={x,z}, cast=optional world point};
    --                     modeled as a blink to the row after the cast delay
    --                     or place={...} instead of destinations: a two-step teleport to an object the cast
    --                     creates (Zed W then W2). Evade (capability ownedTeleportPlace) picks the landing within
    --                     range; it is modeled as a blink after cast + range/speed + observe + recast.
    --                       range, minRange, speed (object travel), recastDelay, observe (s to see the object)
    --                       aim=fn(landing) -> legal world point for the first cast near it, or nil
    --                       submit=fn(point,valid,{owner,ttl}) -> first cast sent through C:Cast (C.lastIntent)
    --                       arrived=fn(landing) -> true once the created object is observed there
    --                       recast=fn(valid) -> second cast sent through C:Cast
    --                     Core sends the recast only after arrived() and while Evade still sees danger where the
    --                     hero stands and none at the landing; a missed observation, a gone threat, a refused
    --                     or cancelled first cast ends it with nothing replayed.
    -- Returns accepted, reason, adapter. A returned intent is a request, not the effect.
    local effectKinds={reduction=true,resist=true,haste=true,heal=true,directional_block=true,attack_dodge=true,owned_teleport=true}
    function C:RegisterEffect(spec)
        local function value(v)if type(v)=='function'then local ok,r=pcall(v);if ok then return r end;return nil end;return v end
        local function numberOrFn(v)return v==nil or type(v)=='function'or finiteNumber(v)end
        if type(spec)~='table'or not effectKinds[spec.kind]or type(spec.name)~='string'or spec.name==''
            or type(spec.slot)~='number'or spec.key==nil or type(spec.source)~='string'or spec.source==''
            or spec.profile~='normal'and spec.profile~='classic'
            or spec.ready~=nil and type(spec.ready)~='function'or spec.target~=nil and type(spec.target)~='function'
            or spec.spell~=nil and type(spec.spell)~='string'or spec.ultimate~=nil and type(spec.ultimate)~='boolean'
            or spec.channel~=nil and type(spec.channel)~='boolean'or spec.cost~=nil and(not finiteNumber(spec.cost)or spec.cost<0)
            or(spec.start==nil)==(spec.delay==nil)or not finiteNumber(spec.start or spec.delay)or(spec.start or spec.delay)<0
            or spec.start and spec.start<.05 or not numberOrFn(spec.duration)then return false,'invalid_effect_spec'end
        local kind=spec.kind
        local timed=not(kind=='owned_teleport'or kind=='heal'and spec.bonus~=true)
        if timed and spec.duration==nil or not timed and spec.duration~=nil and kind=='owned_teleport'then return false,'invalid_effect_spec'end
        if finiteNumber(spec.duration)and spec.duration<=0 then return false,'invalid_effect_spec'end
        local function range(v,lo,hi)return v==nil or type(v)=='function'or finiteNumber(v)and v>=lo and v<=hi end
        local ok=true
        if kind=='reduction'then
            ok=(spec.fraction~=nil)~=(spec.fractions~=nil)and range(spec.fraction,0,1)
                and(spec.fractions==nil or type(spec.fractions)=='table'or type(spec.fractions)=='function')
                and(spec.stages==nil or type(spec.stages)=='table'or type(spec.stages)=='function')
        elseif kind=='resist'then ok=(spec.armor~=nil or spec.magicResist~=nil)and range(spec.armor,0,1000)and range(spec.magicResist,0,1000)
        elseif kind=='haste'then ok=(spec.flat~=nil)~=(spec.percent~=nil)and range(spec.flat,1,1000)and range(spec.percent,.001,3)
            and(spec.castStops==nil or type(spec.castStops)=='boolean')
        elseif kind=='heal'then ok=spec.amount~=nil and numberOrFn(spec.amount)and(spec.bonus==nil or spec.bonus==true)
        elseif kind=='directional_block'then ok=spec.channel==true and spec.angle~=nil and range(spec.angle,1,360)
            and(spec.blocksControl==nil or type(spec.blocksControl)=='boolean')
        elseif kind=='owned_teleport'then
            local pl=spec.place
            if pl==nil then ok=type(spec.destinations)=='function'and spec.channel==nil
            else ok=spec.destinations==nil and spec.channel==nil and type(pl)=='table'and finiteNumber(pl.range)and pl.range>0 and pl.range<=2000
                and finiteNumber(pl.minRange)and pl.minRange>=0 and pl.minRange<=pl.range and finiteNumber(pl.speed)and pl.speed>0
                and finiteNumber(pl.recastDelay)and pl.recastDelay>=0 and finiteNumber(pl.observe)and pl.observe>=0 and pl.observe<=.5
                and type(pl.aim)=='function'and type(pl.submit)=='function'and type(pl.arrived)=='function'and type(pl.recast)=='function'end
        end
        if not ok then return false,'invalid_effect_spec'end
        local slot,key,resource,margin,fixed=spec.slot,spec.key,'slot:'..spec.slot,.05,spec.start~=nil
        local owner='evade_defense'
        local place=kind=='owned_teleport'and spec.place or nil
        local function capable()
            local evade=sdk.Evade;local ok2,caps=pcall(function()return evade and evade.GetCapabilities and evade:GetCapabilities()end)
            return ok2 and type(caps)=='table'and caps.defenseEffectVersion==1 and type(caps.defenseEffects)=='table'
                and caps.defenseEffects[kind]==true and caps.ownedDefenseSubmission==true and(not place or caps.ownedTeleportPlace==true)
        end
        local function ready(own)
            if g.myHero~=hero or not self:Available()then return false end
            -- A two-step teleport in flight owns this key until its recast is settled (`own`: its first cast).
            local inFlight=self.placeFollows and self.placeFollows[key]
            if inFlight and inFlight~=own then return false end
            local s=hero:GetSpellData(slot)
            if not s or(s.level or 0)<1 or spec.spell and s.name~=spec.spell or g.Game.CanUseSpell(slot)~=0 or(s.currentCd or 0)>0
                or type(s.mana)=='number'and s.mana>hero.mana then return false end
            local q=self.pending[key];if q and q.sentAt then return false end
            if spec.ready and not spec.ready()then return false end
            return true
        end
        local function lead()
            if fixed then return spec.start-margin end
            local pr=g.OrbamaPrediction
            local v=pr and pr.GetLaunchDelay and pr:GetLaunchDelay({Delay=spec.delay})
            return finiteNumber(v)and v or math.huge
        end
        local function fractions(v)
            if finiteNumber(v)and v>=0 and v<=1 then return {physical=v,magical=v}end
            if type(v)~='table'then return nil end
            local out={}
            for _,t in ipairs({'physical','magical'})do local x=v[t]
                if x~=nil then if not finiteNumber(x)or x<0 or x>1 then return nil end;out[t]=x end
            end
            if next(out)==nil then return nil end
            return out
        end
        -- The effect this registration offers now; nil when a profile number is missing.
        local function build(now,l)
            local e={kind=kind}
            local d=timed and value(spec.duration)
            if timed and(not finiteNumber(d)or d<=margin)then return nil end
            if fixed then e.starts=now+spec.start else e.starts=now+l+margin end
            e.ends=timed and(fixed and now+d or now+l+d)or e.starts+margin
            if e.ends<=e.starts then return nil end
            if spec.channel then e.immobilizes=true;e.immobilizedUntil=e.ends end
            if kind=='reduction'then
                local base=fractions(value(spec.fraction~=nil and spec.fraction or spec.fractions));if not base then return nil end
                e.fractions=base
                local stages=value(spec.stages)
                if stages~=nil then
                    if type(stages)~='table'or #stages<1 or #stages>4 then return nil end
                    local landed=e.starts-margin;local at=e.starts;e.stages={}
                    for i,row in ipairs(stages)do
                        local f=type(row)=='table'and fractions(row.fraction)
                        if not f then return nil end
                        local last=i==#stages
                        if last~=(row.seconds==nil)then return nil end
                        local finish=last and e.ends or math.min(e.ends,landed+row.seconds)
                        if not finiteNumber(finish)or finish<=at then return nil end
                        e.stages[i]={starts=at,ends=finish,fractions=f};at=finish
                        for t,x in pairs(f)do if(e.fractions[t]or 1)>x then e.fractions[t]=x end end
                    end
                end
            elseif kind=='resist'then
                local a,m=value(spec.armor),value(spec.magicResist)
                if a~=nil and(not finiteNumber(a)or a<0)or m~=nil and(not finiteNumber(m)or m<0)or(a or 0)+(m or 0)<=0 then return nil end
                e.armor,e.magicResist=a,m
            elseif kind=='haste'then
                local v=value(spec.flat~=nil and spec.flat or spec.percent)
                if not finiteNumber(v)or v<=0 then return nil end
                if spec.flat~=nil then e.flat=v else e.percent=v end
                e.castStops=spec.castStops==true or nil
            elseif kind=='heal'then
                local v=value(spec.amount);if not finiteNumber(v)or v<=0 then return nil end
                e.amount=v;e.bonus=spec.bonus
            elseif kind=='directional_block'then
                local v=value(spec.angle);if not finiteNumber(v)or v<=0 or v>360 then return nil end
                e.angle=v;e.blocksControl=spec.blocksControl==true or nil
            end
            return e
        end
        -- Identity of an offered effect without the aim Evade adds.
        local function signature(e)
            local parts={}
            for _,k in ipairs({'starts','ends','immobilizedUntil','armor','magicResist','flat','percent','amount','angle'})do parts[#parts+1]=tostring(e[k])end
            for _,t in ipairs({'physical','magical'})do parts[#parts+1]=tostring(e.fractions and e.fractions[t])end
            for _,st in ipairs(e.stages or {})do parts[#parts+1]=st.starts..':'..st.ends..':'..tostring(st.fractions.physical)..':'..tostring(st.fractions.magical)end
            return table.concat(parts,'|')
        end
        local function destinations()
            local ok2,list=pcall(spec.destinations)
            if not ok2 or type(list)~='table'then return {}end
            local out={}
            for i=1,math.min(#list,3)do local row=list[i]
                if type(row)=='table'and row.id~=nil and type(row.position)=='table'and finiteNumber(row.position.x)and finiteNumber(row.position.z)
                    and(row.cast==nil or type(row.cast)=='table'and finiteNumber(row.cast.x)and finiteNumber(row.cast.z))then out[#out+1]=row end
            end
            return out
        end
        local function destination(id,at)
            for _,row in ipairs(destinations())do
                if row.id==id and(row.position.x-at.x)^2+(row.position.z-at.z)^2<=625 then return row end
            end
        end
        local cost=spec.cost or(spec.ultimate and 100 or 20)
        -- Two-step teleport (place): the recast lead, the reach check and the follow-up that sends the recast.
        local function recastLead()
            local pr=g.OrbamaPrediction
            local v=pr and pr.GetLaunchDelay and pr:GetLaunchDelay({Delay=place.recastDelay})
            return finiteNumber(v)and v or nil
        end
        local function reach(at)local dx,dz=at.x-hero.pos.x,at.z-hero.pos.z;return math.sqrt(dx*dx+dz*dz)end
        local function placeAim(at)
            if type(at)~='table'or not finiteNumber(at.x)or not finiteNumber(at.z)then return nil end
            local d=reach(at);if d>place.range+50 or d<place.minRange-50 then return nil end
            local ok2,aim=pcall(place.aim,{x=at.x,y=at.y or hero.pos.y,z=at.z})
            if not ok2 or type(aim)~='table'or not finiteNumber(aim.x)or not finiteNumber(aim.z)then return nil end
            local dx,dz=aim.x-at.x,aim.z-at.z;if dx*dx+dz*dz>625 then return nil end
            return aim
        end
        -- Evade still sees an area threat where the hero stands (unknown counts as danger) and none at the landing.
        local function endangered(landing,l2)
            local evade=sdk.Evade
            if not evade or type(evade.GetDangerIntervals)~='function'or type(evade.IsDangerous)~='function'then return false,'evade_unavailable'end
            local now=g.Game.Timer();local here={x=hero.pos.x,y=hero.pos.y or 0,z=hero.pos.z}
            local ok2,d=pcall(evade.GetDangerIntervals,evade,here,now,now+1.5,{workBudget=6000})
            if not ok2 or type(d)~='table'then return false,'evade_error'end
            if d.complete==true and #(d.intervals or {})==0 then return false,'threat_gone'end
            local ok3,danger=pcall(evade.IsDangerous,evade,landing,now+l2)
            if not ok3 or danger~=false then return false,'landing_dangerous'end
            return true
        end
        local follow
        local function settle(reason)
            local f=follow;if not f then return end
            follow=nil;if self.placeFollows and self.placeFollows[key]==f then self.placeFollows[key]=nil end
            for _,q in ipairs({f.first,f.second})do
                local r=q and q.id and self.adapter:Poll(q.id)
                if r and not r.sentAt and r.state~='cancelled_before_send'and r.state~='send_uncertain'then self.adapter:Cancel(q.id,'teleport_place_'..reason)end
            end
            self:Trace('owned_teleport_place',{name=spec.name,reason=reason,stage=f.second and'recast'or f.firstSent and'travel'or'cast',
                elapsed=g.Game.Timer()-f.started,x=f.landing.x,z=f.landing.z})
        end
        local function maintain()
            local f=follow;if not f then return end
            if not self:InputAvailable()then return settle('input_unavailable')end
            local now=g.Game.Timer()
            if f.second then
                local r=self.adapter:Poll(f.second.id)
                if not r or r.sentAt or r.state=='cancelled_before_send'or r.state=='send_uncertain'then
                    return settle(r and r.sentAt and'recast_sent'or'recast_'..tostring(r and r.state or'lost'))end
                if now>f.recastBy then return settle('recast_late')end
                return
            end
            if not f.firstSent then
                local r=self.adapter:Poll(f.first.id)
                if not r or r.state=='cancelled_before_send'then return settle('cast_'..tostring(r and r.state or'lost'))end
                -- An uncertain send may still have cast: only the observed object allows the recast.
                if r.sentAt or r.state=='send_uncertain'then f.firstSent=true end
            end
            if f.recastBy and now>f.recastBy then return settle('recast_refused')end
            if not f.recastBy and now>f.deadline then return settle('object_not_observed')end
            if not f.firstSent then return end
            local ok2,arrived=pcall(place.arrived,f.landing);if not ok2 or arrived~=true then return end
            local wanted,why=endangered(f.landing,f.recastLead);if not wanted then return settle(why)end
            -- From the first observation the recast has a short window; a refusal inside it waits a tick.
            f.recastBy=f.recastBy or now+.25
            local function valid()
                if follow~=f or g.Game.Timer()>f.recastBy then return false end
                local ok3,still=pcall(place.arrived,f.landing);if not ok3 or still~=true then return false end
                return(endangered(f.landing,f.recastLead))
            end
            local savedContext,savedDecision=C.executionContext,C.decision
            C.executionContext,C.decision=nil,nil;self.lastIntent=nil
            local ran,accepted=pcall(place.recast,valid)
            C.executionContext,C.decision=savedContext,savedDecision
            local q=self.lastIntent
            if not ran then return settle('controller_error')end
            if accepted and q and q.key==key then f.second=q end
        end
        if place then
            self.placeMaintainers=self.placeMaintainers or {};self.placeMaintainers[#self.placeMaintainers+1]=maintain
            self.core:RegisterCleanup('owned_teleport_place:'..spec.name,function()pcall(settle,'cleanup')end)
        end
        local adapter={validated=true,source=spec.source,
            options=function(context)
                if not capable()or not finiteNumber(context.now)then return {}end
                -- Evade learns the slot went unavailable after a send (no replay before that).
                local evade,yes=sdk.Evade,ready()
                if evade and type(evade.DefenseReady)=='function'then yes=evade:DefenseReady(resource,yes)==true end
                if not yes then return {}end
                local l=lead();if not finiteNumber(l)then return {}end
                local e=build(context.now,l);if not e then return {}end
                local base={validated=true,profile=spec.profile,resource=resource,slot=slot,cost=cost,launch=l,ultimate=spec.ultimate}
                if kind~='owned_teleport'then base.effect=e;return {base}end
                if place then
                    local l2=recastLead();if not l2 then return {}end
                    base.ownedTeleport=true
                    base.place={range=place.range,minRange=place.minRange,speed=place.speed,lead=l,recastLead=l2,observe=place.observe}
                    return {base}
                end
                local out={}
                for _,row in ipairs(destinations())do
                    local option={};for k,v in pairs(base)do option[k]=v end
                    local at={x=row.position.x,y=row.position.y or hero.pos.y,z=row.position.z}
                    option.ownedTeleport=true;option.destinationID=row.id;option.landing=at;option.path={at}
                    option.mobility={kind='blink',range=30000,castDelay=math.max(0,e.starts-margin-context.now)}
                    out[#out+1]=option
                end
                return out
            end,
            prepare=function(option,context)
                if not capable()or not ready()or option.profile~=spec.profile or option.resource~=resource
                    or not finiteNumber(context.now)or not finiteNumber(option.launch)or lead()~=option.launch then return nil,'effect_state_changed'end
                local fresh=build(context.now,option.launch)
                if not fresh then return nil,'effect_state_changed'end
                local placed
                if place then
                    local pl=option.place
                    if not option.ownedTeleport or type(pl)~='table'or pl.range~=place.range or pl.speed~=place.speed
                        or pl.observe~=place.observe or not placeAim(option.landing)then return nil,'teleport_place_changed'end
                    local l2=recastLead();if not l2 then return nil,'teleport_place_changed'end
                    placed={landing={x=option.landing.x,y=option.landing.y or hero.pos.y,z=option.landing.z},recastLead=l2}
                elseif kind=='owned_teleport'then
                    if not option.ownedTeleport or not destination(option.destinationID,option.landing)then return nil,'teleport_destination_changed'end
                elseif type(option.effect)~='table'or option.effect.kind~=kind or signature(option.effect)~=signature(fresh)then return nil,'effect_state_changed'end
                local aim=option.aim
                if kind=='directional_block'and(type(aim)~='table'or not finiteNumber(aim.x)or not finiteNumber(aim.z))then return nil,'directional_block_unaimed'end
                local expires=self.adapter:Now()+20;local requested=g.Game.Timer();local mine
                local function valid()
                    local elapsed=g.Game.Timer()-requested;local l=lead()
                    if not ready(mine)or self.adapter:Now()>expires or not finiteNumber(elapsed)or elapsed<0 or not finiteNumber(l)
                        or elapsed+l>option.launch+margin then return false,'effect_state_changed'end
                    if placed then
                        if follow~=mine or not placeAim(placed.landing)then return false,'teleport_place_changed'end
                    elseif kind=='owned_teleport'then
                        if not destination(option.destinationID,option.landing)then return false,'teleport_destination_changed'end
                    else
                        local now=build(context.now,option.launch)
                        if not now or signature(now)~=signature(fresh)then return false,'effect_state_changed'end
                    end
                    return true
                end
                local intent={type='cast',key=key,resource=resource,expires=expires,mechanical=valid}
                intent.championDefense={submit=function(request)
                    if not valid()then return nil,'effect_state_changed'end
                    if placed then
                        local aim=placeAim(placed.landing);if not aim then return nil,'teleport_place_changed'end
                        local now=self.adapter:Now();local until_=request and request.expires or now+100
                        local ttl=math.max(1,math.min(250,until_-now))
                        local savedContext,savedDecision=C.executionContext,C.decision
                        C.executionContext,C.decision=nil,nil;self.lastIntent=nil
                        local ran,accepted=pcall(place.submit,aim,function()return valid()end,{owner=owner,ttl=ttl})
                        C.executionContext,C.decision=savedContext,savedDecision
                        local q=self.lastIntent
                        if not ran then return nil,'controller_error'end
                        if not accepted or not q or q.key~=key or not q.id then return nil,C.diagnostics.lastReject or 'controller_declined'end
                        local started=g.Game.Timer();local d=reach(placed.landing)
                        local f={first=q,landing=placed.landing,recastLead=placed.recastLead,started=started,
                            deadline=started+option.launch+d/place.speed+place.observe+.25}
                        follow=f;mine=f;self.placeFollows=self.placeFollows or {};self.placeFollows[key]=f
                        local id=q.id;local handle={}
                        function handle:Poll(r)if r==id then return C.adapter:Poll(id)end end
                        function handle:Finish()return false,'controller_owner_observes_and_acknowledges'end
                        -- Evade withdrawing the request before the first cast went out ends the whole sequence;
                        -- after it, the recast is judged on its own (observed object, danger still here).
                        function handle:Cancel(r,why)
                            if r~=id then return end
                            local receipt=C.adapter:Poll(id)
                            if follow==f and not(receipt and(receipt.sentAt or receipt.state=='send_uncertain'))then settle(why or'evade_cancelled')end
                            return C.adapter:Cancel(id,why)
                        end
                        return id,'requested',handle
                    end
                    local target
                    if kind=='directional_block'then
                        local o=hero.pos;target={x=o.x+aim.x*100,y=o.y or 0,z=o.z+aim.z*100}
                    elseif kind=='owned_teleport'then
                        local row=destination(option.destinationID,option.landing);if not row then return nil,'teleport_destination_changed'end
                        target=row.cast and {x=row.cast.x,y=row.cast.y or hero.pos.y,z=row.cast.z}or nil
                    elseif spec.target then target=spec.target()end
                    local now=self.adapter:Now();local until_=request and request.expires or now+100
                    local ttl=math.max(1,math.min(250,until_-now))
                    local savedContext,savedDecision=C.executionContext,C.decision
                    C.executionContext,C.decision=nil,nil
                    local ran,accepted,id=pcall(C.Cast,C,key,target,{owner=owner,priority='critical',ttl=ttl,independent=false,
                        validate=function()return valid()end})
                    C.executionContext,C.decision=savedContext,savedDecision
                    if not ran then return nil,'controller_error'end
                    if not accepted then return nil,C.diagnostics.lastReject or 'controller_declined'end
                    local handle={}
                    function handle:Poll(r)if r==id then return C.adapter:Poll(id)end end
                    function handle:Finish()return false,'controller_owner_observes_and_acknowledges'end
                    function handle:Cancel(r,why)if r==id then return C.adapter:Cancel(id,why)end end
                    return id,'requested',handle
                end}
                return intent
            end}
        local accepted,why=self:RegisterDefense(spec.name,adapter)
        return accepted,why,adapter
    end
    function C:CleanupRuntime(reason)
        if self.runtimeCleaned then return end
        self.runtimeCleaned=true
        self.enabled=false;self.reason=reason;self.locks={}
        local preference=self.attackPreference;self.attackPreference=nil;self.zoneWatch=nil
        if preference and sdk.Orbwalker.ForceTarget==preference.unit then sdk.Orbwalker.ForceTarget=nil end
        local movement=self.movePreference;self.movePreference=nil
        if movement and sdk.Orbwalker.ForceMovement==movement.position then sdk.Orbwalker.ForceMovement=nil end
        unregisterDefenses(self.defenseBindings);self.defenseBindings=nil;self.defenseBindingCount=nil;self.defenseProvider=nil
        self.placeMaintainers=nil
        local cleanup=self.cleanup;self.cleanup=nil;self.cleanupCount=0
        if cleanup then for name,callback in pairs(cleanup)do
            local ok,err=pcall(callback,reason)
            if not ok then self:Trace('cleanup_error',{owner=name,error=tostring(err):sub(1,256)})end
        end end
        self.display=nil;self.overlayScope=nil;self.preparationScope=nil
        self.preparationJobs=nil
        if self.mobility then
            if sdk.ChampionMobility==self.mobility then sdk.ChampionMobility=nil end
            self.mobility=nil
        end
        self.pending={};self.cleanupDispatchers=nil
    end
    C.core:RegisterCleanup('controller_runtime',function(reason)C:CleanupRuntime(reason)end)
    function C:Shutdown(reason)return self.core:Shutdown(reason)end
    C.adapter=C.core.client
    local A=C.adapter
    if A.CooperateWithEvade then
        A:CooperateWithEvade({committed=function()return C.locks.move==true or C.locks.attack==true end,
            yield=function(evidence)
                if not evidence.likelyDeath then return false end
                A:YieldUnsent();C.locks={};A:SetBlocked('champion','attack',false);A:SetBlocked('champion','move',false)
                return true
            end})
        A:RegisterEmergencyYield(function(resource)return A:YieldUnsent(resource)end)
    end
    local keyedMechanical=A:Capabilities().keyedMechanicalObservation==true
    local nativeSendGameTime=A:Capabilities().nativeSendGameTime==true
    local waitingIntentReuse=type(A.ReuseWaiting)=='function'and A:Capabilities().waitingIntentReuse==true
    function C:Available()
        return self:Active() and not g.myHero.dead and not g.Game.IsChatOpen() and g.Game.IsOnTop()
    end
    function C:InputAvailable()
        return self:Current()and not hero.dead and not g.Game.IsChatOpen()and g.Game.IsOnTop()
    end
    function C:RegisterPreparation(id,config,callback,enabled,clear)
        if type(id)~='string' or type(callback)~='function' then return false,'invalid' end
        if not self.preparationScope then
            local family=g.AyyyyIO
            if family and type(family.GetPreparationScope)=='function' then
                local scope,reason=family:GetPreparationScope('champion.display')
                self.preparationScope=scope
                if not scope and reason=='preparation_unavailable' and not (sdk.Preparation and sdk.Preparation.version==1)then return false,'unsupported' end
            elseif sdk.Preparation and sdk.Preparation.version==1 then
                self.preparationScope=sdk.Preparation:Register('Classic display '..tostring(self),{active=function()return C:Active()end})
            else return false,'unsupported' end
        end
        if not self.preparationScope then return false,'refused' end
        self.core:RegisterService('preparation',self.preparationScope)
        if not self.preparationTick then
            if not sdk.OnTick then self.preparationScope:Close();self.preparationScope=nil;return false,'refused' end
            self.preparationTick=self.core:Bind(sdk.OnTick,function()
                if not C:Active() then return end
                local ok,err=pcall(C.RunPreparations,C)
                if not ok then C:Trace('display_preparation_error',{error=tostring(err)})end
            end)
        end
        self.preparationJobs=self.preparationJobs or {}
        for _,job in ipairs(self.preparationJobs)do if job.id==id then return false,'duplicate' end end
        if #self.preparationJobs>=32 then return false,'capacity' end
        self.preparationJobs[#self.preparationJobs+1]={id=id,config=config,run=callback,enabled=enabled,clear=clear}
        return true,'registered'
    end
    function C:RunPreparations()
        if not self.preparationScope or not self.preparationJobs then return end
        for _,job in ipairs(self.preparationJobs)do
            if not job.failed then
                local ok,reason,detail=pcall(function()
                    if self:Available()and(not job.enabled or job.enabled())then
                        local ran,why,err=self.preparationScope:Run(job.id,job.config,job.run)
                        if not ran and why=='callback_error'then return why,err end
                    else self.preparationScope:CancelJob(job.id);if job.clear then job.clear()end end
                end)
                if not ok or reason=='callback_error'then
                    job.failed=true;self.preparationScope:CancelJob(job.id)
                    if job.clear then pcall(job.clear)end
                    self:Trace('display_preparation_error',{job=job.id,error=tostring(ok and detail or reason)})
                    print('[AyyyyIO] Display preparation disabled: '..job.id)
                end
            end
        end
    end
    local env=setmetatable({},{__index=g});env._G=env;C.env=env
    env.os=setmetatable({clock=function()return A:Now()/1000 end},{__index=g.os})
    env.SDK=setmetatable({},{__index=sdk});env.Core=C
    -- Primitives every champion controller needs: one definition here instead of
    -- a private copy per file. Plain functions (no self), safe to keep in locals.
    function C.finite(v)return type(v)=='number'and v==v and v>-math.huge and v<math.huge end
    function C.id(u)return u and(u.networkID or u.handle)end
    function C.point(p)return p and C.finite(p.x)and C.finite(p.z)and g.Vector(p.x,p.y or 0,p.z)end
    -- Native buffs report either expireTime or, when that is 0, endTime.
    function C.buffExpiry(b)return b and(b.expireTime and b.expireTime>0 and b.expireTime or b.endTime)end
    -- True when a buff/object source field (unit or id) is the player's champion.
    function C.mine(v)
        if type(v)=='table'or type(v)=='userdata'then v=C.id(v)end
        return v~=nil and(v==g.myHero.networkID or v==g.myHero.handle)
    end
    -- Resource gate for "Only above mana %" sliders; resourceless champions always pass.
    function C.manaAbove(percent)
        local hero=g.myHero
        return C.finite(hero.maxMana)and(hero.maxMana<=0 or C.finite(hero.mana)and hero.mana/hero.maxMana*100>=(percent or 0))
    end
    local overlay=sdk.Overlay
    if overlay and overlay.GetCapabilities and overlay:GetCapabilities().ownedScopes then
        if g.AyyyyIO and g.AyyyyIO.GetOverlayScope then C.overlayScope=g.AyyyyIO:GetOverlayScope('champion')
        else C.overlayScope=overlay:Register('AyyyyIO.display',{active=function()return C:Current()end})end
        if C.overlayScope then
            C.core:RegisterService('overlay',C.overlayScope)
            local facade=C.overlayScope:Facade();env.Draw=setmetatable({},{__index=facade})
            -- `state=true`: a marker of a state the player is in right now (a reveal radius while
            -- stealthed), not a range circle: it is drawn outside modes as well.
            -- Whether own-hero ranges are hidden is decided once per overlay frame
            -- (setting, pending actions, active modes), not once per circle.
            local decidedFrame,hideRanges
            env.Draw.Circle=function(pos,radius,width,color,state)
                local settings=C.overlayAppearance
                if not state and settings and radius>=200 and pos then
                    local frame=overlay.frame
                    if frame==nil or frame~=decidedFrame then
                        decidedFrame=frame
                        hideRanges=settings.ContextualRanges:Value()and next(C.pending)==nil
                        if hideRanges then for _,mode in pairs(sdk.Orbwalker.Modes)do if mode then hideRanges=false;break end end end
                    end
                    if hideRanges then local at=hero.pos;if at and pos.x==at.x and pos.z==at.z then return end end
                end
                facade.Circle(pos,radius,width,color)
            end
            env.Draw.Text=function(text,size,x,y,color)
                local lower=type(text)=='string'and text:lower()or ''
                -- Exact legacy status sentences now have one stable strip owner.
                if lower:find('^spell farm:')or lower:find('^spell harass:')then
                    local extra=text:match(' | (.+)$');if extra then C.overlayScope:Set('status-detail',{kind='detail',feature='preview',anchor='hud',text=extra,priority=60,expires=g.Game.Timer()+.2})end
                    return
                end
                local p=hero.pos2D
                if p and type(x)=='number'and type(y)=='number'and math.abs(x-p.x)<100 and y>=p.y and y<=p.y+150 then
                    local group=C.drawContext
                    if group then
                        if #group.lines<32 then group.lines[#group.lines+1]={text=tostring(text),size=size,color=color,x=x-p.x,y=y-p.y}end
                    else
                        C.overlayScope:Set('context:'..tostring(math.floor(y-p.y)),{kind='detail',feature='preview',anchor='hud',text=text,priority=60,expires=g.Game.Timer()+.2})
                    end
                    return
                end
                facade.Text(text,size,x,y,color)
            end
        end
    end
    function C:OverlayStatus()
        local scope=self.overlayScope;local menu=env.Menu;if not scope or not menu then return end
        local farm=menu.Clear and(menu.Clear.SpellFarm or menu.Clear.Enabled)
        if farm then scope:Set('spellfarm',{kind='status',feature='champion',anchor='hud',label='Spell farm',
            enabled=farm:Value()==true,bind=farm.Key and farm:Key(),priority=100,expires=g.Game.Timer()+.2})end
        local harass=menu.Clear and menu.Clear.SpellHarass or menu.Harass and menu.Harass.SpellHarass
        if harass then scope:Set('spellharass',{kind='status',feature='champion',anchor='hud',label='Spell harass',enabled=harass:Value()==true,bind=harass.Key and harass:Key(),priority=100,expires=g.Game.Timer()+.2})end
    end
    if C.overlayScope then C.overlayScope:Renderer('champion-status',function()C:OverlayStatus()end,4)end
    local prediction=modules.prediction(assert(g.OrbamaPrediction,'Prediction provider must be loaded'),g.myHero,g.Vector)
    env.OrbamaPrediction=prediction.facade;C.prediction=prediction
    prediction.knowledge=function()return C:GetKnowledge()end
    prediction.fogPermission=function()
        local mode=env.GetMode and env.GetMode()
        return C:Current()and(mode=='Combo'or mode=='Harass')
    end
    function C:PredictionTargetCurrent(unit,binding)
        if env.IsValid(unit)then return true end
        local spell=binding and binding.object;local fog=spell and spell.FogObservation
        local sample=fog and fog.sample
        return unit and sample and unit.visible==false and unit.valid~=false and not unit.dead
            and unit.team~=hero.team and(unit.networkID or unit.handle)==sample.id and unit.handle==sample.handle
            and unit.charName==sample.name and fog.scope:Alive()
    end
    function C:SkillshotTarget(settings,hitchance)
        if not prediction.fogPermission()then return nil end
        local knowledge=self:GetKnowledge();if not knowledge then return nil end
        local units=knowledge:Units(true);if not units then return nil end
        local spell=prediction:ForSettings(settings);local best,bestScore;local considered=0
        local range=settings.Range or math.huge
        for _,unit in ipairs(units)do
            if unit.visible==false then
                -- A recall without an observed starting position is timing only.
                local recall=knowledge:Recall(unit);if recall and not recall.positionKnown then recall=nil end
                local last=not recall and knowledge:LastSeen(unit,.75)
                local sample=recall or last
                if sample and sample.pos and env.GetDistance(sample.pos,hero.pos)<=range+(settings.Radius or 0)then
                    considered=considered+1;if considered>5 then break end
                    spell:GetPrediction(unit,hero)
                    if spell:CanHit(hitchance or 2)then
                        local score=spell.TimeToHit or math.huge
                        local selected=sdk.TargetSelector and sdk.TargetSelector.SelectedTarget
                        if selected==unit then score=score-100 end
                        if not bestScore or score<bestScore then best,bestScore=unit,score end
                    end
                end
            end
        end
        return best
    end
    function C:SkillshotCurrent(unit)
        if env.IsValid(unit)then return true end
        if not prediction.fogPermission()or not unit or unit.visible~=false or unit.valid==false or unit.dead or unit.team==hero.team then return false end
        local knowledge=self:GetKnowledge()
        local recall=knowledge and knowledge:Recall(unit)
        return knowledge and(recall and recall.positionKnown or knowledge:LastSeen(unit,.75)~=nil)or false
    end
    -- Cancels future base-snipe work only. A request that has been sent is an
    -- uncertain historical input: its record and callbacks (Karthus tracks its
    -- channel through them) stay intact.
    function C:CancelUnsent(owner,reason)
        for _,q in pairs(self.pending)do if q.owner==owner and not q.sentAt then q.cancelled=true;q.callbacks={};self.adapter:Cancel(q.id,reason or 'owner_cancelled')end end
    end
    function C:RecallBaseCast(spec)
        local owner='RecallBaseCast'
        local pending=self.pending[spec.key]
        local own=pending and pending.owner==owner
        if not spec.enabled()or not self:Available()or not spec.safe()then
            self.recallCastReason='recall_policy_or_input_unavailable'
            if own and not pending.sentAt then self:CancelUnsent(owner,'recall_policy_changed')end
            return false
        end
        if own then
            if not pending.sentAt then
                local scope=self:GetKnowledge();local unit=pending.recallUnit
                local resolved=scope and unit and modules.recallCast.Prepare(g,prediction.facade,scope,unit,spec.spell,spec,pending.recallAnchor)
                if not resolved then self:CancelUnsent(owner,'recall_conditions_changed')end
            end
            return false
        end
        if pending then self.recallCastReason='recall_slot_pending';return false end
        local slot=slots[spec.key]
        if slot==nil or not env.IsReady(slot)then self.recallCastReason='recall_spell_unavailable';return false end
        local scope=self:GetKnowledge();if not scope then self.recallCastReason='recall_knowledge_unavailable';return false end
        -- Only units with a running recall can be planned; none is the common case.
        local units=scope.RecallUnits and scope:RecallUnits(true,self.recallUnits)
        if not units then self.recallCastReason='recall_units_unavailable';return false end
        self.recallUnits=units
        if #units==0 then self.recallCastReason='recall_no_enemy_recall';return false end
        self.recallCastReason='recall_no_enemy_observations'
        for _,unit in ipairs(units)do
            local resolved,why=modules.recallCast.Prepare(g,prediction.facade,scope,unit,spec.spell,spec)
            self.recallCastReason=why
            if resolved then
                local anchor=resolved.data
                local function refresh()
                    if not spec.enabled()or not spec.safe()then return nil,'recall_policy_changed'end
                    return modules.recallCast.Prepare(g,prediction.facade,scope,unit,spec.spell,spec,anchor)
                end
                local accepted,id
                if spec.selfCast then
                    accepted,id=self:Cast(spec.key,nil,{owner=owner,context={},priority='interactive',ttl=100,
                        validate=function()local fresh,why=refresh();if fresh then return true end;return false,why or 'recall_plan_missing'end})
                else
                accepted,id=self:Cast(spec.key,resolved.position,{owner=owner,context={},independent=false,
                    priority='interactive',ttl=100,range=spec.spell.Range,prevalidateWorldCast=true,
                    directionalWorldCast=true,directionalAimError=spec.spell.AimErrorWorld or 0,
                    resolve=refresh,validate=function(_,fresh)
                        if not fresh or not fresh.data then return false,'recall_plan_missing'end
                        local data=fresh.data
                        return spec.enabled()and spec.safe()and data.id==anchor.id and data.handle==anchor.handle
                            and data.started==anchor.started and data.ends==anchor.ends and data.map==g.Game.mapID
                            and g.Game.Timer()+data.flight<=data.latestArrival
                    end,commitGuard=function()
                        return spec.enabled()and scope:Alive()and g.Game.Timer()+anchor.flight<=anchor.latestArrival
                    end})
                end
                if accepted then
                    local q=self.pending[spec.key]
                    if q and q.id==id then q.recallUnit=unit;q.recallAnchor=anchor;if spec.submitted then spec.submitted(q)end end
                    return true
                end
            end
        end
        return false
    end
    -- Skip only a duplicate held-combat intention. Its existing bounded request
    -- still resolves/validates afresh at dispatch. No old prediction is returned.
    prediction.defer=function(object,target,source)
        if C.validating or not C:Current()or not C.decision or not C.executionContext
            or C.executionContext.combat~=true or not target or not env.IsValid(target)then return false end
        local count=0
        for _,q in pairs(C.pending)do
            count=count+1;if count>16 then return false end
            local binding=q.prediction
            if binding and binding.object==object and binding.target==target
                and(binding.source or hero)==(source or hero)and q.owner==C.decision.name
                and(q.type==nil or q.type=='cast')and q.independent and not q.group and not q.reservation and not q.dependency
                and not q.cancelled and not q.sentAt and q.expires>A:Now()
                and q.priority==(C.executionContext.priority or 'normal')and A:ContextValid(q)then
                local r=A:Poll(q.id)
                return r and r.state=='waiting'and not r.sentAt and not r.jobCancelled and not r.cleanupPending or false
            end
        end
        return false
    end
    function C:Prediction(settings)return prediction:ForSettings(settings)end
    function C:ControlledHit(target,settings,position)
        local provider=prediction.facade
        if not env.IsValid(target)or type(provider.AssessHitWindow)~='function'then return false,nil,'control_window_unavailable'end
        local commit=(A:Capabilities().worldCommitMaxMs or 0)/1000
        local window=provider:AssessHitWindow(target,settings,position,hero,commit+.02,self.validating==true)
        -- Brief post-CC movement counts when its reachable footprint fits the
        -- actual outgoing shape. Attack/cast windups alone are not stationary CC.
        return window.known==true and(window.stationaryKnownDuration or 0)>0 and window.canHitLocked==true,window
    end
    function C:HealthEstimate(target,horizon,kind,damage)
        local service=sdk.HealthWindow or modules.healthWindow
        if not service or service.version~=1 then return nil,'health_window_unavailable'end
        if damage~=nil then return service.Qualify(target,horizon,kind,damage)end
        return service.Read(target,horizon,kind)
    end
    function C:MixedHealthEstimate(target,horizon,physical,magical)
        local service=sdk.HealthWindow
        if not service or service.version~=1 or type(service.QualifyMixed)~='function'then service=modules.healthWindow end
        if not service or service.version~=1 or type(service.QualifyMixed)~='function'then return nil,'mixed_health_window_unavailable'end
        return service.QualifyMixed(target,horizon,physical,magical)
    end
    function C:SpellProtected(target,onlyShield)
        local count=target and target.buffCount
        if type(count)~='number'or count~=count or count<0 or count>128 or count%1~=0 then return nil,'buff_state_unknown'end
        local now=g.Game.Timer()
        for i=0,count do
            local buff=target:GetBuff(i)
            if buff and(buff.type==4 or buff.type==16 or not onlyShield and buff.type==18)
                and(not finiteNumber(buff.count)or buff.count>0)then
                local finish=buff.expireTime
                if type(finish)~='number'or finish~=finish or finish<=0 then finish=buff.endTime end
                if not finiteNumber(finish)or finish<=0 then return true,'protection_expiry_unknown'end
                if finish>now then return true,buff.type==18 and 'invulnerable'or 'spell_shield'end
            end
        end
        return false
    end
    function C:SpellShielded(target)return self:SpellProtected(target,true)end
    -- A detached bounded view, not a cache or authorization from fogged health.
    -- The caller hoists invariant damage terms and chooses its impact horizon.
    function C:HealthRows(horizon,kind,damageFor,options)
        options=options or {}
        local view={rows={},kills=0,horizon=horizon,at=g.Game.Timer(),complete=true}
        if type(damageFor)~='function'then view.complete=false;view.reason='damage_resolver_missing';return view end
        local knowledge=options.includeHidden and self:GetKnowledge()
        local units=knowledge and knowledge:Units(true)
        view.rosterSource=units and 'shared_knowledge_identities'or 'provider_enemy_identities'
        units=units or self:DecisionUnits('GetEnemyHeroes')
        local seen={};local limit=options.limit or 16
        if not finiteNumber(limit)or limit<1 or limit%1~=0 then view.complete=false;view.reason='invalid_health_row_limit';return view end
        limit=math.min(16,limit)
        if #units>32 then view.complete=false;view.reason='health_roster_limit'end
        for index=1,math.min(#units,32)do
            local unit=units[index];local id=unit and(unit.networkID or unit.handle)
            if id and not seen[id]and unit.type==g.Obj_AI_Hero and unit.team~=hero.team and unit.valid~=false and not unit.dead then
                seen[id]=true
                if #view.rows>=limit then view.complete=false;view.reason='health_row_limit';break end
                local row={id=id,handle=unit.handle,name=unit.charName,known=false,lethal=false}
                if not env.IsValid(unit)then row.reason='not_visible'
                else
                    local shielded,why=self:SpellProtected(unit)
                    if shielded~=false then row.reason=why or 'spell_shield'
                    else
                        local estimate,reason=self:HealthEstimate(unit,horizon,kind,damageFor(unit))
                        if estimate then
                            for key,value in pairs(estimate)do row[key]=value end
                            row.known=true
                            if row.lethal then view.kills=view.kills+1 end
                        else row.reason=reason end
                    end
                end
                view.rows[#view.rows+1]=row
            end
        end
        return view
    end
    function C:RegisterGuide(guide,settings)
        if self.champion and self.champion.RegisterGuide then return self.champion:RegisterGuide(guide,settings)end
    end
    function C:DecisionUnits(method)
        local scope=not self.validating and self.evaluation
        if scope and not scope.valid then scope=nil end
        if scope and scope[method] then return scope[method] end
        local manager=sdk.ObjectManager
        local units=manager[method](manager)
        if scope then
            -- Keep a private identity list; positions, health and validity are
            -- read by each consumer. Never lend an SDK scratch array to a cache.
            local copy={};for i=1,#units do copy[i]=units[i] end
            scope[method]=copy;return copy
        end
        return units
    end
    function C:DecisionValue(key,compute)
        local scope=not self.validating and self.evaluation
        if not scope or not scope.valid then return compute()end
        local values=scope.values
        if not values then values={};scope.values=values end
        if values[key]==nil then values[key]=compute()end
        return values[key]
    end
    function C:DecisionUnit(method,identity,handle,limit)
        limit=limit or 512
        if type(method)~='string'or not finiteNumber(identity)or identity<=0
            or not finiteNumber(handle)or handle<=0 or not finiteNumber(limit)
            or limit%1~=0 or limit<1 or limit>512 then return nil end
        local scope=not self.validating and self.evaluation
        if not scope or not scope.valid then
            local units=self:DecisionUnits(method)
            local found
            for i=1,math.min(#units,limit)do local unit=units[i]
                if unit and(unit.networkID or unit.handle)==identity then
                    if unit.handle~=handle or found and found~=unit then return nil end
                    found=unit
                end
            end
            return found
        end
        -- Keep indexes in this owned evaluation, without a new producer closure
        -- or string key allocation for every membership check.
        local indexes=scope.unitIndexes
        if not indexes then indexes={};scope.unitIndexes=indexes end
        local methods=indexes[method]
        if not methods then methods={};indexes[method]=methods end
        local index=methods[limit]
        if not index then
            index={};local units=self:DecisionUnits(method)
            for i=1,math.min(#units,limit)do local unit=units[i];local key=unit and(unit.networkID or unit.handle)
                if key then
                    if index[key]==nil then index[key]=unit
                    elseif index[key]~=unit then index[key]=false end
                end
            end
            methods[limit]=index
        end
        local unit=index[identity]
        return unit and unit.handle==handle and unit or nil
    end
    for i,name in ipairs({'Q','W','E','R','SUMMONER_1','SUMMONER_2'})do
        local key=g['HK_'..name];if key then slots[key]=g['_'..name]or g[name];logicalSlots[key]=i-1 end
    end
    for i=1,7 do if g['HK_ITEM_'..i] then
        local key=g['HK_ITEM_'..i];logicalSlots[key]=i+5;slots[key]=A:NativeSpellSlot(i+5)
    end end
    function C:Stamp(key)
        local slot=slots[key];local d=slot and g.myHero:GetSpellData(slot)
        if not d then return '' end
        return tostring(d.name)..':'..tostring(d.currentCd)..':'..tostring(d.toggleState)..':'..tostring(d.ammo)
    end
    function C:Invoke(fn,selfObject,args,name)
        if not self:Active() then
            -- Explicit synchronous cleanup may clear champion-owned gameplay
            -- state through wrapped methods after deactivation. Core callback
            -- guards still reject stale callbacks, and Cast/Submit remain inactive.
            if self.cleaningChampion then return fn(selfObject,unpack(args,1,args.n or #args))end
            return
        end
        local root=self.evaluation==nil
        if root then self.evaluation=self.core:BeginEvaluation() end
        local old=self.decision;local previousContext=self.executionContext
        local declaration=self.policy and self.policy.methods[name]
        if not previousContext and declaration then self.executionContext=declaration(selfObject) end
        if not old and name~='Tick' and name~='OnTick' and name~='Draw' and name~='__init' and name~='LoadMenu' then
            self.decision={name=name,menuReads={}}
        end
        local results=pack(pcall(fn,selfObject,unpack(args,1,args.n or #args)));self.decision=old;self.executionContext=previousContext
        if root then self.core:EndEvaluation(self.evaluation);self.evaluation=nil end
        if not results[1] and name=='Draw'then
            if not self.displayError then self.displayError=tostring(results[2]);self:Trace('draw_error',{error=self.displayError})end
            return
        end
        if not results[1] then self:Trace('callback_error',{method=name,error=tostring(results[2])});self:Shutdown('champion_callback_error');error(results[2],0) end
        return unpack(results,2,results.n)
    end
    env.class=function(name)
        local class={};class.__index=class
        setmetatable(class,{__call=function(t,...)
            for k,fn in pairs(t)do if type(fn)=='function' then
                local original,method=fn,k
                t[k]=function(object,...)
                    -- An ordinary nested helper shares its protected outer call,
                    -- decision and evaluation. Preserve the root error boundary
                    -- without allocating a second argument/result envelope.
                    -- Dispatch validation, reentry/invalidation, diagnostics and
                    -- methods declaring their own context retain full protection.
                    if C.evaluation and C.evaluation.valid and C.decision and not C.validating
                        and not(C.policy and C.policy.methods and C.policy.methods[method])and C:Active()then
                        return original(object,...)
                    end
                    return C:Invoke(original,object,pack(...),method)
                end
            end end
            local object=setmetatable({},t);C.champion=object
            object:__init(...)
            if object.profile then C.core.profile=object.profile end
            local menus=sdk.MenuMigration
            -- One router per controller: a later class instantiation reuses it
            -- and its clear always reaches the current champion object.
            if not C.autoJungle then C.autoJungle=modules.autojungle(g,C.core,{
                menu=env.Menu,menuID='Classic_AIO_'..hero.charName,menus=menus,
                available=function()return C:Available()and not C:SelfChanneling(true)end,
                safe=function(pos)return env.GetEnemyCount(1000,pos)==0 and not env.IsUnderTurret2(pos)end,
                clear=function(camp,target,context)
                    local previous=C.executionContext;C.executionContext=context
                    local current=C.champion;local fn=current and current.JungleClear
                    local ok,why
                    if fn then ok,why=pcall(fn,current)
                    elseif current and current.Clear then ok,why=pcall(current.Clear,current)
                    else ok=true end
                    C.executionContext=previous;if not ok then error(why,0)end
                end,
                cancel=function(reason)for _,owner in ipairs({'JungleClear','jungle','clear'})do C:Cancel(owner,reason)end end})end
            return object
        end});env[name]=class;return class
    end
    local function guarded(fn)
        return function(...)if C:Active() then return fn(...) end end
    end
    env.Callback={Add=function(event,fn)
        if event=='Draw'and C.overlayScope then
            C.drawSerial=(C.drawSerial or 0)+1
            local id='champion:'..C.drawSerial
            local grouped=overlay:GetCapabilities().detailLineGroups==true
            local group={lines={}}
            C.overlayScope:Renderer(id,function()
                if not grouped then if not C.displayError then fn()end;return end
                if C.displayError then C.overlayScope:Remove('context:'..id);return end
                for index=#group.lines,1,-1 do group.lines[index]=nil end
                local previous=C.drawContext;C.drawContext=group
                local ok,why=pcall(fn);C.drawContext=previous
                if not ok then C.overlayScope:Remove('context:'..id);error(why,0)end
                if C.displayError then C.overlayScope:Remove('context:'..id);return end
                if #group.lines>0 then
                    local accepted,reason,detail=C.overlayScope:Set('context:'..id,{kind='detail',feature='preview',anchor='hud',lines=group.lines,
                        priority=60,expires=g.Game.Timer()+.2})
                    if not accepted and reason=='invalid_line_group'then error('Invalid champion display line group: '..tostring(detail or 'group structure'),0)end
                else C.overlayScope:Remove('context:'..id)end
            end,2)
            return
        end
        C.core:Bind(event,function(...)
            if event=='Tick'then C:GetKnowledge();C:Observe();C:MaintainClaims();if C.autoJungle then C.autoJungle:Tick()end;if C.display then C.display:Prepare(C.overlayAppearance and C.overlayAppearance.Damage:Value())end end
            return fn(...)
        end)
    end}
    env.DelayAction=function(fn,delay,args)
        local generation=C.generation
        g.DelayAction(function()if C:Active() and C.generation==generation then local values=args or {};fn(unpack(values,1,values.n or #values))end end,delay)
    end
    -- A champion never writes the provider's ForceTarget directly: an assignment
    -- becomes an owned, leased attack preference (C:PreferAttack) or its release.
    local orb=setmetatable({},{__index=sdk.Orbwalker,__newindex=function(t,key,value)
        if key~='ForceTarget'then rawset(t,key,value);return end
        if value==nil then C:ReleaseAttackPreference()else C:PreferAttack('champion',value,.25)end
    end});env.SDK.Orbwalker=orb
    function orb:SetAttack(allowed) C.locks.attack=not allowed;A:SetBlocked("champion","attack",not allowed) end
    function orb:SetMovement(allowed) C.locks.move=not allowed;A:SetBlocked("champion","move",not allowed) end
    for _,name in ipairs({'OnPreAttack','OnPreMovement','OnPostAttack','OnPostAttackTick','OnAttack'})do
        if sdk.Orbwalker[name] then
            orb[name]=function(_,fn)
                local lists={OnPreAttack='OnPreAttackCb',OnPreMovement='OnMoveCb',OnPostAttack='OnPostAttackCb',
                    OnPostAttackTick='OnPostAttackTickCb',OnAttack='OnAttackCb'}
                return C.core:Bind(assert(sdk.Orbwalker[lists[name]],'orbwalker callback list unavailable'),function(...)
                    local args=select(1,...);local mutable=type(args)=="table"
                    local was=mutable and args.Process
                    local result=fn(...)
                    if mutable and was==false then args.Process=false end
                    return result
                end,{register=function(callback)sdk.Orbwalker[name](sdk.Orbwalker,callback)end})
            end
        end
    end
    -- Never lend SDK's raw Cursor to champion code.
    env.SDK.Cursor=setmetatable({Add=function(_,key,target)return C:Cast(key,target,{independent=false,owner='manual'})end},
        {__index=function(_,key)if key=='Step' then return 0 end end})
    env.Control=setmetatable({CastSpell=function(key,target)return C:Cast(key,target)end,
        KeyDown=function()return false end,KeyUp=function()return false end},{__index=g.Control})
    env.require=function(name)
        if name=='OrbamaPrediction' then return true end
        return g.require(name)
    end
    local config=g.AyyyyIOControllersConfig or {};C.config=config
    local roots,actualPaths={},{}
    -- Shared menu rules for every champion (user audit 2026-10-07):
    -- every bind, at any depth, is listed under Controls; a label never names
    -- a key, because the bind can be changed; no default bind sits on a key the
    -- game itself uses by default (G and V pings, A/S/H/X orders, ...); and a
    -- group or submenu is shown only once it holds an entry.
    local reservedKeys,freeKeys,usedKeys,controlIDs,menuParent,shown={},{},{},{},{},{}
    for letter in ('QWERDFASGVBPMYCHXZL'):gmatch('.')do reservedKeys[letter:byte()]=true end
    for letter in ('TUNJKIO'):gmatch('.')do freeKeys[#freeKeys+1]=letter:byte() end
    local function savedAt(rootID,relative)
        local node=sdk.MenuMigration and sdk.MenuMigration.saved and sdk.MenuMigration.saved[rootID]
        for part in relative:gmatch('[^.]+')do node=type(node)=='table'and node[part]or nil end
        return type(node)=='table'
    end
    local function show(node)
        while node and not shown[node]do
            shown[node]=true;if type(node.Hide)=='function'then pcall(node.Hide,node,false)end
            node=menuParent[node]
        end
    end
    local function bindLabel(name,toggle)
        name=tostring(name or ''):gsub('^[Hh]old%s+%u%d?%s*:%s*',''):gsub('^[Hh]old%s*:%s*','')
        name=name:sub(1,1):upper()..name:sub(2)
        if not toggle and not name:lower():find('hold',1,true)then name=name..' (hold)'end
        return name
    end
    -- `menu=false` declares a setting that is only a good default (player menu standard
    -- 2026-10-11): no entry is shown and readers get the default. A submenu declared
    -- that way holds its children the same way.
    local function fixedNode(spec)
        local value,key=spec.value,spec.key
        local node={args=spec,fixed=true}
        function node:Value(v)if v~=nil then value=v end;return value end
        function node:Key()return key end
        function node:Hide()end
        function node:MenuElement(child)local n=fixedNode(clone(child));self[child.id]=n;return n end
        return node
    end
    local modeNames={LaneClear='Lane clear',JungleClear='Jungle clear',LastHit='Last hit'}
    local function routeMenu(parent,args,path,legacyPath)
        if args.menu==false then
            local node=fixedNode(clone(args))
            if parent then parent.node[args.id]=node end
            return node
        end
        -- `from` names the place a moved entry was saved at, relative to the root (e.g. 'Automation.Misc.Flash').
        local spec=clone(args);spec.leftIcon=nil;spec.menu=nil;local from=spec.from;spec.from=nil
        -- Mode names read as words in every champion's menu; the ids stay.
        spec.name=modeNames[spec.name]or spec.name
        local values=config.values or {};local migration=config.migration or {}
        if values[path]~=nil then spec.value=values[path]
        elseif migration.enabled==true and migration.values and migration.values[legacyPath]~=nil then
            local old=migration.values[legacyPath]
            if spec.value==nil or type(old)==type(spec.value) then spec.value=old end
        end
        local menu;local destination=parent and parent.node
        local rootID=path:match('^[^.]+');local rootMenu=roots[rootID]
        local bind=parent and rootMenu and type(spec.key)=='number'
        -- `fixedKey=true` marks a bind that must equal a game key (the ability key itself).
        local fixedKey=spec.fixedKey==true;spec.fixedKey=nil
        if bind then
            local ids=controlIDs[rootID]or {};controlIDs[rootID]=ids
            if rootMenu.Controls and parent.node~=rootMenu.Controls and not ids[spec.id]then destination=rootMenu.Controls;ids[spec.id]=true end
            spec.name=bindLabel(spec.name,spec.toggle==true)
        elseif parent and rootMenu and parent.node==rootMenu then
            local group=(spec.id=='Draw'or spec.id=='Drawings'or spec.id=='Drawing'or spec.id=='SharedAppearance')and 'Appearance'
                or(spec.type==g.MENU or type(spec.value)=='boolean')and 'Automation'
            if group and rootMenu[group]and spec.id~=group then destination=rootMenu[group]end
        end
        local newPath=parent and ((actualPaths[destination]or path:match('^(.*)%.'))..'.'..spec.id)or path
        local migrate=sdk.MenuMigration;local defaultKey=spec.key
        if migrate and parent and not(config.values and config.values[path]~=nil)then
            migrate:Apply(spec,rootID,path:sub(#rootID+2),newPath:sub(#rootID+2))
            if from then migrate:Apply(spec,rootID,from,newPath:sub(#rootID+2))end
        end
        if bind then
            local used=usedKeys[rootID]or {};usedKeys[rootID]=used
            -- A reserved default is replaced unless the player saved a bind at
            -- this entry's current place; an older saved copy of the default is not a choice.
            -- The same holds for a default another entry of this champion already took.
            if not fixedKey and(reservedKeys[defaultKey]or used[defaultKey])and spec.key==defaultKey and spec.key>6 and not savedAt(rootID,newPath:sub(#rootID+2))then
                for _,candidate in ipairs(freeKeys)do if not used[candidate]then spec.key=candidate;break end end
            end
            used[spec.key]=true
        end
        if parent then menu=parent.raw(destination,spec)or destination[spec.id];parent.node[spec.id]=menu
        else menu=g.MenuElement(spec)end
        if not menu then return menu end
        actualPaths[menu]=newPath
        if not parent then
            roots[rootID]=menu;shown[menu]=true
            for _,name in ipairs({'Controls','Automation','Tracking','Appearance'})do
                menu:MenuElement({type=g.MENU,id=name,name=name});actualPaths[menu[name]]=rootID..'.'..name
                menuParent[menu[name]]=menu;if type(menu[name].Hide)=='function'then pcall(menu[name].Hide,menu[name],true)end
            end
        elseif spec.type==g.MENU then
            menuParent[menu]=destination;if type(menu.Hide)=='function'then pcall(menu.Hide,menu,true)end
        else show(destination)end
        local rawValue=menu.Value
        if rawValue then menu.Value=function(node,...)
            local result=rawValue(node,...)
            if select('#',...)==0 and C.decision and C.decision.menuReads then C.decision.menuReads[node]=result end
            return result
        end end
        local raw=menu.MenuElement
        menu.MenuElement=function(node,child)
            return routeMenu({node=node,raw=raw},child,path..'.'..tostring(child.id),legacyPath..'.'..tostring(child.id))
        end
        return menu
    end
    env.MenuElement=function(args)
        local spec=clone(args);local legacy=spec.id
        spec.id=spec.id:gsub('Classic_AIO','AyyyyIOControllers'):gsub('ActivatorChampion','AyyyyIOControllersActivator')
        spec.name=spec.name:gsub('Classic AIO','AyyyyIO') -- one family name, whatever an older source file still says
        if g.AyyyyIO then spec.name='AyyyyIO - '..champion end
        local menu=routeMenu(nil,spec,spec.id,legacy);C.menus[spec.id]=menu;env.Menu=menu
        if C.overlayScope and not C.overlayAppearance then
            C.overlayAppearance=menu.Appearance
            C.overlayAppearance:MenuElement({id='Damage',name='Damage you can deal now, on enemy health bars',value=true})
            C.overlayAppearance:MenuElement({id='ContextualRanges',name='Ranges only during modes or pending actions',value=true})
            show(C.overlayAppearance)
        end
        return menu
    end
    function C:ModeContext(mode,condition)
        if(mode=='JungleClear'or mode=='LaneClear')and self.autoJungle and self.autoJungle:Active()then return self.autoJungle:Context(condition)end
        local names={Combo='COMBO',Harass='HARASS',LaneClear='LANECLEAR',JungleClear='JUNGLECLEAR',LastHit='LASTHIT',Flee='FLEE'}
        local modeID=sdk['ORBWALKER_MODE_'..names[mode]]
        if mode=='LaneClear' and not sdk.Orbwalker.Modes[modeID] and sdk.Orbwalker.Modes[sdk.ORBWALKER_MODE_JUNGLECLEAR] then modeID=sdk.ORBWALKER_MODE_JUNGLECLEAR end
        return {mode=mode,modes={modeID},condition=function()
                local held=mode=='JungleClear' and self:FarmModeEnabled('jungle') or mode~='JungleClear' and env.GetMode()==mode
                return held and (mode~='LastHit' or self:SpellFarmEnabled()) and (not condition or condition())
            end,
            combat=mode=='Combo' or mode=='Harass',priority=(mode=='LaneClear' or mode=='JungleClear' or mode=='LastHit') and 'background' or 'normal'}
    end
    function C:HeldContext(held)return {held=held,priority='interactive'}end
    -- The spell-farming toggle governs every farming mode, LastHit included
    -- (user report 2026-10-07: Q in LastHit with the toggle off). A controller
    -- without that toggle is unaffected.
    function C:SpellFarmEnabled()
        local menu=env.Menu;local farm=menu and menu.Clear and(menu.Clear.SpellFarm or menu.Clear.Enabled)
        if not farm or type(farm.Value)~='function' then return true end
        return farm:Value()==true
    end
    function C:LastHitSpellBlocked(context,target)
        if self:SpellFarmEnabled() then return false end
        if context then return context.mode=='LastHit' end
        return env.GetMode()=='LastHit' and target~=nil and target.type==g.Obj_AI_Minion and target.team~=300
    end
    -- New controllers opt into distinct farm binds. Legacy controllers retain
    -- their LaneClear facade until their consumers are migrated together.
    function C:FarmModeEnabled(kind)
        if kind=='jungle'and self.autoJungle and self.autoJungle:Active()then return true end
        local lane=sdk.ORBWALKER_MODE_LANECLEAR
        local jungle=sdk.ORBWALKER_MODE_JUNGLECLEAR
        local id=kind=='jungle' and jungle or kind=='lane' and lane
        if not id then return false end
        return env.GetMode()=='LaneClear' and sdk.Orbwalker.Modes[id]==true
    end
    function C:FarmContext(kind,condition)
        if kind=='jungle'and self.autoJungle and self.autoJungle:Active()then return self.autoJungle:Context(condition)end
        local id=kind=='jungle' and sdk.ORBWALKER_MODE_JUNGLECLEAR or sdk.ORBWALKER_MODE_LANECLEAR
        return {mode='LaneClear',modes={id},priority='background',condition=function()
            return self:FarmModeEnabled(kind) and (not condition or condition())
        end}
    end
    -- Legacy forecasts combine both shield pools. Only use their incoming-attack
    -- model when the cached starting scalar matches a fresh unshielded unit.
    function C:UnshieldedLegacyForecast(target,delay)
        local function finite(value)return type(value)=='number'and value==value and value>-math.huge and value<math.huge end
        if not target or not finite(delay)or delay<0 then return nil,'invalid_forecast_input'end
        local hp=target.health;local id=target.networkID;local handle=target.handle
        if not finite(hp)or hp<=0 or not id or not handle or target.dead==true or target.valid==false then return nil,'invalid_forecast_target'end
        if not finite(target.shieldAD)or not finite(target.shieldAP)or target.shieldAD~=0 or target.shieldAP~=0 then return nil,'shielded_legacy_forecast'end
        local prediction=sdk.HealthPrediction
        if not prediction or type(prediction.GetPrediction)~='function'then return nil,'forecast_unavailable'end
        local ok,seed=pcall(prediction.GetPrediction,prediction,target,0)
        if not ok or not finite(seed)or seed~=hp then return nil,'unknown_forecast_seed'end
        local success,value=pcall(prediction.GetPrediction,prediction,target,delay)
        if not success or not finite(value)then return nil,'invalid_forecast_result'end
        if target.networkID~=id or target.handle~=handle or target.health~=hp
            or target.dead==true or target.valid==false or target.shieldAD~=0 or target.shieldAP~=0 then return nil,'forecast_state_changed'end
        return value
    end
    -- Shared unit, buff, consent and farming services: one implementation for
    -- the gameplay core and the class-style champions. Every scan is bounded;
    -- validity, health and positions are read fresh on each call.
    local function flatDistance(a,b)local dx,dz=a.x-b.x,a.z-b.z;return math.sqrt(dx*dx+dz*dz)end
    local function unitMethod(kind,allies)
        return kind=='hero'and(allies and 'GetAllyHeroes'or 'GetEnemyHeroes')or kind=='jungle'and 'GetMonsters'or 'GetEnemyMinions'
    end
    -- kind: 'hero' | 'jungle' | 'lane'. A new, caller-owned list without duplicates.
    -- allies: true lists allied champions; 'self' also puts the player first.
    function C:Rows(kind,range,allies)
        local rows=self:DecisionUnits(unitMethod(kind,allies));local result,seen={},{}
        local cap=kind=='hero'and 10 or kind=='jungle'and 16 or 48;local origin=g.myHero.pos
        if allies=='self'and kind=='hero'and C.id(g.myHero)and env.IsValid(g.myHero)then seen[C.id(g.myHero)]=true;result[1]=g.myHero end
        for i=1,math.min(#rows,512)do if #result>=cap then break end;local u=rows[i];local identity=C.id(u)
            if identity and not seen[identity]and env.IsValid(u)and C.finite(u.health)and C.finite(u.maxHealth)and u.maxHealth>0
                and(not range or flatDistance(origin,u.pos)<=range)and(kind=='hero'or(u.team==300)==(kind=='jungle'))then
                seen[identity]=true;result[#result+1]=u
            end
        end
        return result
    end
    -- The wrapper still names the same living object in the provider's roster.
    -- (C:Current() without a unit is the controller's own liveness, hence the name.)
    function C:CurrentUnit(u,allies)
        if not u or not C.id(u)or not env.IsValid(u)then return false end
        if u==g.myHero then return true end
        local kind=u.type==g.Obj_AI_Hero and 'hero'or u.team==300 and 'jungle'or 'lane'
        local v=self:DecisionUnit(unitMethod(kind,allies),C.id(u),u.handle)
        return v~=nil and env.IsValid(v)and C.finite(v.health)and C.finite(v.maxHealth)and v.maxHealth>0
    end
    function C:Reach(u,range,allies)return self:CurrentUnit(u,allies)and flatDistance(g.myHero.pos,u.pos)<=range end
    -- An active buff by name (string or list, case-insensitive). `owned` also
    -- requires a populated source/owner field naming the player; a foreign or
    -- unattributed buff answers nil with the reason. `unique` also refuses a
    -- second active copy ('duplicate_buff') instead of answering the first.
    local ownerFields={'source','sourcenID','owner','ownerID','sourceID'}
    -- Lower-case buff names by slot for one unit, read once per decision
    -- evaluation and shared by every buff query in it (any cast attempt ends the
    -- evaluation). A matching slot still reads its buff wrapper fresh; validation
    -- and calls outside an evaluation get nil and scan directly. Live 2026-10-10:
    -- Master Yi's repeated full scans were ~7% of game time.
    -- An expired slot (count exactly 0) keeps its name on this host but can match
    -- no query: it is indexed as false, so lookups never read it again (live
    -- 2026-10-11: Yi keeps ~10 expired Double Strike slots). Any other count,
    -- including an unreadable one, keeps the name so callers still judge it.
    function C:BuffNames(u)
        local scope=not self.validating and self.evaluation
        if not scope or not scope.valid or not u then return nil end
        local index=scope.buffNames;if not index then index={};scope.buffNames=index end
        local row=index[u];if row~=nil then return row or nil end
        local count=u.buffCount
        if not C.finite(count)or count<0 or count>128 or count%1~=0 then index[u]=false;return nil end
        row={n=count}
        for i=0,count do local b=u:GetBuff(i);local name=b and b.name
            row[i]=type(name)=='string'and b.count~=0 and name:lower()or false
        end
        index[u]=row;return row
    end
    -- Lower-case set of a caller's name list, built once per list table.
    local nameSets=setmetatable({},{__mode='k'})
    local function nameSet(names)
        local set=nameSets[names]
        if not set then set={};for index=1,#names do set[names[index]:lower()]=true end;nameSets[names]=set end
        return set
    end
    -- Slot i can match: always without an index, else only when its cached name matches.
    local function candidate(index,i,single,set)
        if not index then return true end
        local name=index[i];if not name then return false end
        if single then return name==single end
        return set[name]==true
    end
    C.buffCandidate=candidate;C.buffNameSet=nameSet
    function C:OwnBuff(u,names,owned,unique)
        local finite=C.finite;local single=type(names)=='string'and names:lower()
        if not u or not names or not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 then return nil,'buff_snapshot_unknown'end
        local h=g.myHero;local now=g.Game.Timer();local found
        local index=self:BuffNames(u);if index and index.n~=u.buffCount then index=nil end
        local set=not single and nameSet(names)
        for i=0,u.buffCount do local b=candidate(index,i,single,set)and u:GetBuff(i)
            if b and type(b.name)=='string'and finite(b.count)and b.count>0 then
                local name=b.name:lower();local match=single==name
                if not single then match=set[name]==true end
                if match then
                    local ends=finite(b.expireTime)and b.expireTime>0 and b.expireTime or b.endTime
                    if not finite(ends)then return nil,'buff_expiry_unknown'end
                    if ends>now then
                        if owned then
                            local known=false
                            for index=1,#ownerFields do local owner=b[ownerFields[index]]
                                if owner and owner~=0 then
                                    if type(owner)=='table'or type(owner)=='userdata'then owner=C.id(owner)end
                                    if owner~=h.networkID and owner~=h.handle then return nil,'foreign_buff'end;known=true
                                end
                            end
                            if not known then return nil,'buff_ownership_unknown'end
                        end
                        if not unique then return b end
                        if found then return nil,'duplicate_buff'end
                        found=b
                    end
                end
            end
        end
        return found
    end
    -- The single active buff of that name (string or list, case-insensitive) for
    -- state the player applies: an unattributed buff is accepted, a populated
    -- source naming someone else is refused, and so is a second active copy,
    -- because then nothing says which one is ours. `named` also refuses a
    -- sourceName other than the player's champion. Returns buff, or nil, reason;
    -- nil without a reason means the buff is absent.
    function C:SelfBuff(u,names,named)
        local finite=C.finite;local single=type(names)=='string'and names:lower()
        if not u or not names or not finite(u.buffCount)or u.buffCount%1~=0 or u.buffCount<0 or u.buffCount>128 then return nil,'buff_snapshot_unknown'end
        local h=g.myHero;local now=g.Game.Timer();local found
        local index=self:BuffNames(u);if index and index.n~=u.buffCount then index=nil end
        local set=not single and nameSet(names)
        for i=0,u.buffCount do local b=candidate(index,i,single,set)and u:GetBuff(i)
            if b and type(b.name)=='string'then
                local name=b.name:lower();local match=single==name
                if not single then match=set[name]==true end
                if match then
                    if not finite(b.count)or b.count<0 then return nil,'buff_count_unknown'end
                    if b.count>0 then
                        local ends=C.buffExpiry(b)
                        if not finite(ends)then return nil,'buff_expiry_unknown'end
                        if ends>now then
                            for index=1,2 do local owner=b[ownerFields[index]]
                                if type(owner)=='table'or type(owner)=='userdata'then owner=C.id(owner)end
                                if owner and owner~=0 and owner~=h.networkID and owner~=h.handle then return nil,'foreign_buff'end
                            end
                            if named and b.sourceName and b.sourceName~=''and b.sourceName~=h.charName then return nil,'foreign_buff'end
                            if found then return nil,'duplicate_buff'end
                            found=b
                        end
                    end
                end
            end
        end
        return found
    end
    -- One "allow" switch per enemy champion under `node`, keyed by champion name
    -- so a saved choice survives the next game. Heroes are registered whenever
    -- the roster lists them (late loaders included); an unlisted hero is refused.
    -- `prefix` is the menu-id prefix a controller already saved under ('Unit').
    function C:TargetConsent(node,owner,label,prefix)
        local consent={targets={},nextRefresh=0}
        function consent:Refresh()
            local rows=C:DecisionUnits('GetEnemyHeroes')
            for i=1,math.min(#rows,10)do local u=rows[i];local identity=C.id(u)
                if identity and type(u.charName)=='string'and not self.targets[identity]then
                    local key=env.StableUnitMenuKey(owner,prefix or 'Unit',u)
                    node:MenuElement({id=key,name=(label or 'Allow: ')..u.charName,value=true});self.targets[identity]=node[key]
                end
            end
            self.nextRefresh=g.Game.Timer()+1
        end
        function consent:Maintain()if g.Game.Timer()>=self.nextRefresh then self:Refresh()end end
        function consent:Allowed(u)
            if not u then return u end
            if u.type~=g.Obj_AI_Hero then return true end
            local entry=self.targets[C.id(u)];return entry~=nil and entry:Value()==true
        end
        return consent
    end
    -- Last-hit rescue. A last hit is the basic attack's job: the spell is for a
    -- minion that dies before an attack can take it. `impact` is the seconds
    -- until the spell lands, `damage` its mitigated damage (a number, or a
    -- function called only once the minion is known to be alive at impact).
    -- opts.attack selects how the basic attack is weighed:
    --   nil     the rule: rescue only a minion that dies before the next attack
    --           can land (cooldown, approach, windup, flight), or between that
    --           attack, when it is not lethal, and the following one.
    --   'ready' earlier class-style rule, kept where a champion's regressions pin
    --           it: only an attack that is ready and in range right now counts,
    --           and only when it kills at its own landing.
    --   false   the caller has already ruled the basic attack out.
    -- opts.attackDamage (number or function(unit)) replaces the provider's
    -- attack damage when that figure is not guaranteed for this champion.
    function C:Rescue(unit,impact,damage,opts)
        local finite=C.finite;local h=g.myHero
        if not unit or not finite(impact)then return false end
        local hp=self:UnshieldedLegacyForecast(unit,impact)
        if not finite(hp)or hp<=0 then return false end
        local policy=opts and opts.attack
        -- Attacks that start after the cast are not in the forecast. A slow spell is
        -- not spent on a minion that survives its delay and travel only on paper
        -- (live 2026-10-07: Q landed after the minion died). This margin assumes the
        -- observed loss continues for the wait beyond a quick cast; it only refuses.
        if policy==nil and impact>.25 and hp-(unit.health-hp)*(impact-.25)/impact<=0 then return false end
        if type(damage)=='function'then damage=damage()end
        if type(damage)~='number'or damage<hp+(unit.hpRegen or 0)*impact then return false end
        if policy==false then return true end
        local attack=sdk.Attack;if not attack then return false end
        local own=opts and opts.attackDamage
        local windup=attack:GetWindup()
        if policy=='ready'and(not sdk.Orbwalker:CanAttack()or not sdk.Data:IsInAutoAttackRange(h,unit)or not finite(windup)or windup<0)then return true end
        local distance=flatDistance(h.pos,unit.pos);local reach=sdk.Data:GetAutoAttackRange(h,unit);local speed=attack:GetProjectileSpeed()
        local flight=type(speed)=='number'and speed>0 and speed<math.huge and finite(reach)and math.min(distance,reach)/speed or 0
        if policy=='ready'then
            local landing=windup+flight;local atAttack=self:UnshieldedLegacyForecast(unit,landing)
            if not finite(atAttack)or atAttack<=0 then return true end
            if type(own)=='function'then own=own(unit)end
            return(own or sdk.Damage:CalculateDamage(h,unit,sdk.DAMAGE_TYPE_PHYSICAL,h.totalDamage))<atAttack+(unit.hpRegen or 0)*landing
        end
        -- A minion that merely is in spell kill range (live 2026-10-07: a lone
        -- minion one attack from death) is left alone.
        local animation=attack:GetAnimation()
        local delay=attack:IsReady()and 0 or finite(attack.ServerStart)and finite(animation)and math.max(0,attack.ServerStart+animation-g.Game.Timer())or nil
        local gap=finite(reach)and math.max(0,distance-reach)or nil
        if not finite(animation)or animation<=0 or not finite(windup)or not finite(delay)or not gap
            or gap>0 and(not finite(h.ms)or h.ms<=0)then return false end
        local first=math.max(delay,gap>0 and gap/h.ms or 0)+windup+flight
        local atFirst=self:UnshieldedLegacyForecast(unit,first)
        if not finite(atFirst)then return false end
        if atFirst>0 then
            if type(own)=='function'then own=own(unit)end
            if(own or sdk.Damage:GetAutoAttackDamage(h,unit,true))>=atFirst then return false end
            local atSecond=self:UnshieldedLegacyForecast(unit,first+animation)
            if not finite(atSecond)or atSecond>0 then return false end
        end
        return true
    end
    -- A rescue cast is time-critical. Farming contexts carry priority
    -- 'background', which the provider dispatches only after the orbwalker's
    -- turn each tick; a rescue goes out at 'normal'. Pass the farming context
    -- the cast would use (a fresh table), or nothing for LastHit.
    -- A rescue is farming whatever mode is held (Harass, Combo, LaneClear): the
    -- spell-farming toggle is rechecked at dispatch (player rule 2026-10-07).
    function C:RescueContext(context)
        context=context or self:ModeContext('LastHit');context.priority='normal';context.farmRescue=true
        local condition=context.condition
        context.condition=function()return self:SpellFarmEnabled()and(not condition or condition())end
        return context
    end
    -- Lethal now / lethal at impact: one kill rule for LastHit, clear and finisher
    -- abilities (generalised from Classic Irelia's Q, live 2026-10-08).
    --   impact        seconds until the damage lands
    --   damage        mitigated damage: a number, or a function called only once
    --                 the unit is known to be alive on arrival
    --   opts.now      the cast must kill from CURRENT health. A cast that is only
    --                 refunded by the kill must not depend on someone else's hit
    --                 landing first; the forecast then only confirms the unit is
    --                 still alive on arrival.
    --   opts.margin   share of the estimate that is trusted (default .97)
    --   opts.flat     health added to the requirement (default 2)
    --   opts.kind     'physical'|'magical'|'true' for a champion: selects the
    --                 shield pools and, without opts.now, the shared health window
    --   opts.protection=false  the caller has already ruled out spell protection
    --   opts.attack   the damage is a basic attack (attack-only dodges count)
    -- Champions that cannot die at impact (undying, stasis, revive, zombie forms) or
    -- cannot be hit by it (untargetable, parry, projectile block) are refused, and
    -- the player's own Exhaust scales the damage down (C:CannotDie, C:OutgoingScale).
    -- Minions and monsters: attacks already in flight count through the provider's
    -- health forecast; regeneration over the wait is added. Returns lethal, detail.
    function C:Lethal(unit,impact,damage,opts)
        local finite=C.finite;opts=opts or {}
        if not unit or not env.IsValid(unit)or not finite(impact)or impact<0 or not finite(unit.health)or unit.health<=0 then return false,'invalid_target'end
        local margin,flat=opts.margin or .97,opts.flat or 2
        if unit.type==g.Obj_AI_Hero then
            if opts.protection~=false and self:SpellProtected(unit)~=false then return false,'protected'end
            local blocked,why=self:CannotDie(unit,impact,opts.attack==true);if blocked then return false,why end
            if type(damage)=='function'then damage=damage()end
            if not finite(damage)or damage<=0 then return false,'damage_unknown'end
            damage=damage*self:OutgoingScale()
            local kind=opts.kind
            if kind and not opts.now then
                local estimate=self:HealthEstimate(unit,impact,kind,damage*margin-flat)
                if estimate then return estimate.lethal==true,estimate end
            end
            local shield=(finite(unit.shieldAD)and unit.shieldAD or 0)+((kind==nil or kind=='magical')and finite(unit.shieldAP)and unit.shieldAP or 0)
            return damage*margin>=unit.health+shield+(opts.now and 0 or(unit.hpRegen or 0)*impact)+flat,'current_health'
        end
        local forecast=self:UnshieldedLegacyForecast(unit,impact)
        if not finite(forecast)or forecast<=0 then return false,'dead_or_unknown_at_impact'end
        if type(damage)=='function'then damage=damage()end
        if not finite(damage)or damage<=0 then return false,'damage_unknown'end
        local health=opts.now and unit.health or forecast
        return damage*margin>=health+(unit.hpRegen or 0)*impact+flat,health
    end
    -- Champion states in which a hit cannot kill (researched 2026-10-10, installed
    -- assets 16.20 + Orbama UndyingBuffs; experiments/champion-ranking-20261010/
    -- research/classic-and-shared-data.md). Names are lower case; Classic copies
    -- carry the jade_ prefix. `death`: the champion cannot die while it lasts;
    -- `hit`: the hit itself is avoided; `attack`: only basic attacks are avoided.
    local cannotDie={
        undyingrage='death',tryndamereundyingrage='death',kindredrnodeathbuff='death',chronoshift='death',chronorevive='death',
        zileanchronoshift='death',kayler='death',judicatorintervention='death',taricr='death',lissandrarself='death',bardrstasis='death',
        zhonyasringshield='death',willrevive='death',guardianangel='death',sionpassivezombie='death',kogmawicathiansurprise='death',
        karthusdeathdefiedbuff='death',aatroxpassivedeath='death',
        jade_tryndamereundyingrage='death',jade_zilean_chronoshift='death',jade_kayler='death',jade_kogmawicathiansurprise='death',
        jade_karthusdeathdefiedbuff='death',jade_aatroxpassivedeath='death',jade_zhonyasringshield='death',jade_taricrbuff='death',
        jade_sionpassive='death',
        vladimirsanguinepool='hit',alphastrike='hit',jade_masteryialphastrike='hit',fioraw='hit',samiraw='hit',melwreflect='hit',
        gwenwuntargetabilitymanager='hit',
        jaxe='attack',jade_jaxe='attack',shenwbuff='attack',
    }
    C.CannotDieBuffs=cannotDie
    -- true, reason while `unit` cannot be killed by a hit landing `impact` s from now.
    function C:CannotDie(unit,impact,attack)
        if unit.isTargetable==false then return true,'untargetable'end
        local count=unit.buffCount
        if type(count)~='number'or count~=count or count<0 or count>128 then return false end
        local landing=g.Game.Timer()+(impact or 0)
        for i=0,count do
            local buff=unit:GetBuff(i);local name=buff and buff.name
            local kind=type(name)=='string'and cannotDie[name:lower()]
            if kind and(kind~='attack'or attack)and(not finiteNumber(buff.count)or buff.count>0)then
                local finish=C.buffExpiry(buff)
                if not finiteNumber(finish)or finish<=0 or finish>=landing-.05 then
                    return true,kind=='death'and'cannot_die'or'hit_avoided'
                end
            end
        end
        return false
    end
    -- Outgoing damage share of the player's champion: Exhaust (Normal -35%, Classic
    -- -30%; wiki and assets read 2026-10-10). 1 without a known modifier.
    local exhaust={summonerexhaust=.65,summonerexhaustdebuff=.65,exhaustdebuff=.65,summonerexhaust_jade=.7,jade_summonerexhaust=.7}
    function C:OutgoingScale()
        local count=hero.buffCount
        if type(count)~='number'or count~=count or count<0 or count>128 then return 1 end
        local now=g.Game.Timer()
        for i=0,count do
            local buff=hero:GetBuff(i);local name=buff and buff.name
            local scale=type(name)=='string'and exhaust[name:lower()]
            if scale and(not finiteNumber(buff.count)or buff.count>0)then
                local finish=C.buffExpiry(buff)
                if not finiteNumber(finish)or finish>now then return scale end
            end
        end
        return 1
    end
    -- Chain while lethal: the weakest unit in `rows` the cast kills, which is the
    -- one most likely to be lost to someone else's hit. kills(unit) is the
    -- champion's C:Lethal call; reach(unit) and safe(unit) are optional filters.
    -- At most 24 rows are weighed. A refunded cast calls this again next tick.
    function C:LethalPick(rows,kills,reach,safe)
        local best
        for i=1,math.min(#rows,24)do local u=rows[i]
            if u and(not best or u.health<best.health)and(not reach or reach(u))and(not safe or safe(u))and kills(u)then best=u end
        end
        return best
    end
    -- One reset-on-kill cast in flight (Irelia Q, Tristana W, Akali R, ...). The
    -- lock only keeps a second cast from being queued on top of this one. It ends
    -- on the first solid evidence: the refund itself (target dead and the slot
    -- ready again), the cooldown having started (no refund), the cast never
    -- having been sent, or .3 s after the observed cast with no dash in progress.
    -- Maintain() answers that reason once, else nil; `lastReset` names the refund.
    function C:ResetChain(slot)
        local chain={slot=slot}
        function chain:Begin(unit,intent,ttl)
            self.row={unit=unit,id=C.id(unit),handle=unit and unit.handle,intent=intent,expires=g.Game.Timer()+(ttl or 1.5)}
        end
        function chain:Busy()return self.row~=nil end
        function chain:Clear()self.row=nil end
        function chain:Maintain()
            local r=self.row;if not r then return nil end
            local now=g.Game.Timer();local q=r.intent;local d=g.myHero:GetSpellData(slot)
            local function finish(reason)self.row=nil;return reason end
            if q and not q.sentAt and C.pending[q.key]~=q then return finish('not_sent')end
            if q and q.observedAt and not r.observedAt then r.observedAt=now end
            if not r.observedAt then return now>r.expires and finish('expired')or nil end
            local killed=r.unit and r.unit.handle==r.handle and(r.unit.dead==true or(r.unit.health or 0)<=0)
            local path=g.myHero.pathing;local dashing=path and path.isDashing==true
            if killed and d and d.currentCd==0 and g.Game.CanUseSpell(slot)==0 then
                self.lastReset={id=r.id,at=now,kind='kill_refund_observed'};return finish('refunded')
            end
            if d and C.finite(d.currentCd)and d.currentCd>0 then return finish('cooldown')end
            if not dashing and now-r.observedAt>.3 then return finish('settled')end
            return now>r.expires and finish('expired')or nil
        end
        return chain
    end
    -- Flash through the Utils service: the usable slot, the profile-verified blink
    -- distance and its cost, or nil and a reason (no Flash, profile unverified).
    function C:FlashStatus()
        local utils=sdk.OrbamaUtils;local service=utils and utils.Flash
        if not service or type(service.Available)~='function'or type(service.Request)~='function'or type(service.Cancel)~='function'
            or type(utils.GetCapabilities)~='function'or not utils:GetCapabilities().flashRequests then return nil,'utils_flash_contract_unavailable'end
        local status,why=service:Available()
        if type(status)~='table'or not C.finite(status.range)or status.range<=0 then return nil,why or 'flash_unavailable'end
        local data=hero:GetSpellData(status.slot)
        if not data or not C.finite(data.mana)or data.mana<0 then return nil,'flash_cost_unknown'end
        status.service=service;status.cost=data.mana;return status
    end
    -- Reveal a fog point (Xerath R, Jhin R, a global ultimate on a hidden
    -- target) with the ready reveal trinket or, within ward range, a ward,
    -- through the Utils Reveal service. valid(pos) is rechecked at dispatch.
    -- Returns accepted, event-or-reason.
    function C:Reveal(position,owner,valid,context)
        local utils=sdk.OrbamaUtils;local service=utils and utils.Reveal
        if not service or type(utils.GetCapabilities)~='function'or not utils:GetCapabilities().revealRequests then return false,'utils_reveal_unavailable'end
        local status,why=service:Available(position);if not status then return false,why end
        return service:Request(position,{owner=owner,range=status.range,context=context,authorized=function()return C:Available()end,
            validate=function(pos)return valid==nil or valid(pos)==true end})
    end
    -- Ignite in burst decisions: a ready Ignite the Utils activator is allowed to
    -- use. Damage is the full true-damage burn (70 + 20 per level over 5 s, both
    -- profiles; Classic asset + wiki, read 2026-10-10), range 600. A caller that
    -- counts it must also send it with C:Ignite. Returns status or nil, reason.
    function C:IgniteStatus(target)
        local utils=sdk.OrbamaUtils;if not utils or not utils.Activator or not utils.config or utils.config:get('ignite')~=true then return nil,'ignite_disabled'end
        for slot=4,5 do local d=hero:GetSpellData(slot);local name=d and type(d.name)=='string'and d.name:lower()
            if name and(name=='summonerdot'or name=='summonerdot_jade')and g.Game.CanUseSpell(slot)==0 then
                local level=hero.levelData and hero.levelData.lvl or 1
                if target and(not env.IsValid(target)or flatDistance(target.pos,hero.pos)>600+(target.boundingRadius or 0))then return nil,'ignite_out_of_range'end
                return {slot=slot,damage=70+20*(math.max(1,math.min(18,level))-1),duration=5,range=600}
            end
        end
        return nil,'no_ready_ignite'
    end
    function C:Ignite(target,owner,valid,context)
        local status,why=self:IgniteStatus(target);if not status then return false,why end
        return sdk.OrbamaUtils.Activator:Request(status.slot,target,{owner=owner or 'AyyyyIO.ignite',context=context,priority='interactive',
            validate=function()return env.IsValid(target)and flatDistance(target.pos,hero.pos)<=600+(target.boundingRadius or 0)and(valid==nil or valid()==true)end})
    end
    -- Spellblade (Sheen family): the bonus the next basic attack gains when an
    -- ability is cast now (research/spellblade.md, wiki 2026-10-10; Classic from
    -- the 16.20 assets). 0 while the bonus is already primed (the provider's attack
    -- damage counts it then) or during the item cooldown, which starts when the
    -- primed buff is used up (1.5 s Normal, 2 s Classic). Mitigated damage.
    local spellblade={
        normal={[3057]={base=1},[3078]={base=2},[3100]={base=.75,ap=.45,magic=true},[3508]={base=1.25},[6662]={base=1.5},[2510]={base=.75,ap=.1,magic=true}},
        classic={[773057]={base=1},[773078]={base=2},[773100]={flat=50,ap=.75,magic=true},[773025]={base=1.25}},
    }
    local spellbladeBuffs={sheen=true,['3078trinityforce']=true,lichbane=true,['3508buff']=true,['6662buff']=true,['2510_sheenhands']=true,
        sheen_jade=true,lichbane_jade=true,itemfrozenfist=true}
    local bladeState={primedAt=nil,usedAt=-math.huge}
    function C:SpellbladeBonus(target)
        local classic=hero.charName:match('^Jade_')~=nil;local rows=spellblade[classic and'classic'or'normal']
        local row;for slot=6,12 do local item=hero:GetItemData(slot);row=item and rows[item.itemID];if row then break end end
        if not row then return 0 end
        local now=g.Game.Timer();local primed=false
        for i=0,math.min(hero.buffCount or 0,128)do local b=hero:GetBuff(i)
            if b and(b.count or 1)>0 and type(b.name)=='string'and spellbladeBuffs[b.name:lower()]then primed=true;break end
        end
        if primed then bladeState.primedAt=now;return 0 end
        if bladeState.primedAt then bladeState.usedAt=bladeState.primedAt;bladeState.primedAt=nil end
        if now-bladeState.usedAt<(classic and 2 or 1.5)then return 0 end
        local raw=(row.base or 0)*(hero.baseDamage or 0)+(row.ap or 0)*(hero.ap or 0)+(row.flat or 0)
        if raw<=0 or not target then return raw end
        local kind=row.magic and sdk.DAMAGE_TYPE_MAGICAL or sdk.DAMAGE_TYPE_PHYSICAL
        local ok,damage=pcall(sdk.Damage.CalculateDamage,sdk.Damage,hero,target,kind,raw)
        return ok and finiteNumber(damage)and damage or 0
    end
    -- One Flash combination in flight, in either order (Annie Flash-R, Ahri E-Flash,
    -- Vayne Condemn-Flash, Yone Q3-Flash, Lee R-Flash, Malphite R-Flash, ...).
    --   local combo=Core:FlashFollow('AnnieFlashR')
    --   combo:Start{order='flash_first'|'spell_first', aim=<landing>, authorized=fn(), valid=fn(landing),
    --               follow=fn(context) -> cast submitted (through C:Cast; C.lastIntent is the spell),
    --               held=fn() (the bind; default authorized), window=s (spell_first: Flash in time), ttl=s}
    --   combo:Maintain() each tick before other decisions: true while it owns the next step.
    -- flash_first: Flash toward aim; the spell follows only once the Flash is observed and
    -- the champion stands at the landing. spell_first: the spell is cast now; the Flash is
    -- requested once that cast is observed and only inside `window` after it. Consent,
    -- target identity, reach and safety are rechecked through valid() at every step; an
    -- uncertain or refused send ends the combination and nothing is replayed.
    function C:FlashFollow(owner)
        local combo={owner=owner}
        local function stop(self,reason)
            local p=self.plan;if not p then return false end
            if p.event and not(p.event.status=='observed')then pcall(p.service.Cancel,p.service,p.event,owner)end
            if p.action and reason~='done'then local r=C.adapter:Poll(p.action);if r and not r.sentAt then C.adapter:Cancel(p.action,'flash_follow_'..tostring(reason))end end
            self.plan=nil;self.last={reason=reason,at=g.Game.Timer()};return false
        end
        local function requestFlash(self,p)
            local ok,event=p.service:Request(p.aim,{owner=owner,range=p.range,context=p.context,authorized=p.authorized,
                validate=function(pos)return self.plan==p and p.authorized()and C.finite(pos.x)and env.GetDistance(pos,hero.pos)<=p.range+1 and p.valid(pos)==true end})
            if not ok then return false,event end
            p.event=event;p.flashAt=g.Game.Timer();return true
        end
        function combo:Busy()return self.plan~=nil end
        function combo:Cancel(reason)return stop(self,reason or 'cancelled')end
        function combo:Start(spec)
            if self.plan then return false,'busy'end
            if not C:Available()or type(spec)~='table'or type(spec.follow)~='function'or type(spec.valid)~='function'
                or type(spec.authorized)~='function'or not spec.authorized()then return false,'not_authorized'end
            local status,why=C:FlashStatus();if not status then return false,why end
            if hero.mana<status.cost+(spec.mana or 0)then return false,'flash_mana'end
            local aim=C.point(spec.aim);if not aim then return false,'no_landing'end
            if env.GetDistance(aim,hero.pos)>status.range then aim=C.point(hero.pos:Extended(aim,status.range))end
            if type(g.Game.isWall)=='function'and g.Game.isWall(aim)~=false then return false,'landing_in_wall'end
            if spec.valid(aim)~=true then return false,'plan_invalid_at_landing'end
            local now=g.Game.Timer();local held=spec.held or spec.authorized
            local p={order=spec.order=='spell_first'and'spell_first'or'flash_first',aim=aim,origin=C.point(hero.pos),range=status.range,
                service=status.service,authorized=spec.authorized,valid=spec.valid,follow=spec.follow,window=spec.window or .2,
                context=C:HeldContext(held),expires=now+(spec.ttl or 1.2)}
            self.plan=p
            if p.order=='flash_first'then
                local ok,reason=requestFlash(self,p);if not ok then stop(self,reason or 'flash_refused');return false,reason end
                return true
            end
            if not p.follow(p.context)then stop(self,'spell_refused');return false,'spell_refused'end
            p.intent=C.lastIntent;p.spell=p.intent and p.intent.id;p.action=p.spell;return true
        end
        function combo:Maintain()
            local p=self.plan;if not p then return false end
            local now=g.Game.Timer()
            if not C:Available()or not p.authorized()or now>=p.expires then return stop(self,'ended')end
            local e=p.event
            if e and(e.gameplayCancelled or e.status=='cancelled_before_send'or e.status=='send_uncertain'or e.status=='rejected')then return stop(self,'flash_'..tostring(e.status))end
            local dashing=hero.pathing and hero.pathing.isDashing
            if p.order=='flash_first'then
                if p.followed then
                    local r=p.action and C.adapter:Poll(p.action)
                    if not r or r.sentAt or r.state=='cancelled_before_send'or r.state=='send_uncertain'then return stop(self,'done')end
                    return true
                end
                if e and e.status=='observed'and env.GetDistance(hero.pos,p.origin)>=100 and env.GetDistance(hero.pos,p.aim)<=80 and not dashing then
                    if p.valid(C.point(hero.pos))~=true then return stop(self,'plan_invalid_after_flash')end
                    if p.follow(p.context)then p.action=C.lastIntent and C.lastIntent.id;p.followed=true;return true end
                    return stop(self,'spell_refused')
                end
                return true
            end
            -- spell_first: the Flash only goes out after the spell's cast was observed.
            local q=p.intent;local r=p.spell and C.adapter:Poll(p.spell)
            if not r or not q then return stop(self,'spell_lost')end
            if r.state=='cancelled_before_send'or r.state=='send_uncertain'or q.cancelled then return stop(self,'spell_'..tostring(r.state))end
            if q.observedAt and not p.observedAt then p.observedAt=now end
            if e then return e.status=='observed'and stop(self,'done')or true end
            if p.observedAt then
                if now-p.observedAt>p.window then return stop(self,'flash_window_missed')end
                local ok,reason=requestFlash(self,p);if not ok then return stop(self,reason or 'flash_refused')end
            end
            return true
        end
        return combo
    end
    -- Shared attack-target preference: attack the enemy a kit has prepared (a
    -- netted or trapped target, a marked one, a charged one, a minion one attack
    -- away from a spell kill). The provider attacks its ForceTarget whenever that
    -- unit is valid, so a preference is only ever a unit inside attack range, held
    -- on a short lease the champion renews each tick, and it never replaces a
    -- unit the player selected or a ForceTarget someone else set. Owned cleanup:
    -- lapse, death, leaving attack range, release and controller shutdown all
    -- clear exactly the value this controller wrote.
    function C:PreferAttack(owner,unit,seconds)
        local walker=sdk.Orbwalker;local p=self.attackPreference
        if type(owner)~='string'or owner==''or not self:Current()then return false,'invalid_preference'end
        if not unit or not env.IsValid(unit)or sdk.Data:IsInAutoAttackRange(hero,unit)~=true then return false,'not_attackable'end
        local ours=p~=nil and walker.ForceTarget==p.unit
        if not ours and walker.ForceTarget~=nil then return false,'foreign_force_target'end
        local selected=sdk.TargetSelector and sdk.TargetSelector.Selected
        if selected and selected~=unit and unit.type==g.Obj_AI_Hero and env.IsValid(selected)and sdk.Data:IsInAutoAttackRange(hero,selected)==true then return false,'player_selection'end
        local now=g.Game.Timer()
        if ours and p.owner~=owner and p.unit~=unit and now<p.untilAt then return false,'preference_owned'end
        walker.ForceTarget=unit
        self.attackPreference={owner=owner,unit=unit,id=C.id(unit),handle=unit.handle,untilAt=now+math.max(.05,math.min(seconds or .25,1))}
        return true
    end
    -- The unit this controller currently prefers (optionally: for that owner).
    function C:AttackPreferred(owner)
        local p=self.attackPreference
        return p and(not owner or p.owner==owner)and sdk.Orbwalker.ForceTarget==p.unit and p.unit or nil
    end
    function C:ReleaseAttackPreference(owner)
        local p=self.attackPreference;if not p or owner and p.owner~=owner then return false end
        if sdk.Orbwalker.ForceTarget==p.unit then sdk.Orbwalker.ForceTarget=nil end
        self.attackPreference=nil;return true
    end
    function C:MaintainAttackPreference()
        local p=self.attackPreference;if not p then return end
        local u=p.unit
        if sdk.Orbwalker.ForceTarget~=u then self.attackPreference=nil;return end
        if g.Game.Timer()>p.untilAt or not env.IsValid(u)or C.id(u)~=p.id or u.handle~=p.handle
            or sdk.Data:IsInAutoAttackRange(hero,u)~=true then self:ReleaseAttackPreference()end
    end
    -- Shared movement preference: while a mode key is held the orbwalker walks to
    -- this world point instead of the cursor (Morgana keeping shackled enemies in
    -- the tether, a melee champion sticking to its target, Katarina walking onto
    -- a dagger). A lease of at most .5 s renewed each tick; never replaces a
    -- foreign ForceMovement; cleared on lapse, when no mode is held and at shutdown.
    function C:PreferMove(owner,position,seconds)
        local walker=sdk.Orbwalker;local p=self.movePreference;local pos=C.point(position)
        if type(owner)~='string'or owner==''or not pos or not self:Current()then return false,'invalid_preference'end
        local ours=p~=nil and walker.ForceMovement==p.position
        if not ours and walker.ForceMovement~=nil then return false,'foreign_force_movement'end
        local now=g.Game.Timer()
        if ours and p.owner~=owner and now<p.untilAt then return false,'preference_owned'end
        local v=g.Vector(pos.x,pos.y or hero.pos.y,pos.z)
        walker.ForceMovement=v
        self.movePreference={owner=owner,position=v,untilAt=now+math.max(.05,math.min(seconds or .25,.5))}
        return true
    end
    function C:ReleaseMovePreference(owner)
        local p=self.movePreference;if not p or owner and p.owner~=owner then return false end
        if sdk.Orbwalker.ForceMovement==p.position then sdk.Orbwalker.ForceMovement=nil end
        self.movePreference=nil;return true
    end
    function C:MaintainMovePreference()
        local p=self.movePreference;if not p then return end
        if sdk.Orbwalker.ForceMovement~=p.position then self.movePreference=nil;return end
        local modes=sdk.Orbwalker.Modes;local held=false
        for _,m in pairs(modes or {})do if m then held=true;break end end
        if g.Game.Timer()>p.untilAt or not held then self:ReleaseMovePreference()end
    end
    -- Enemies who cannot move yet, or are about to arrive: a trap or zone placed
    -- under them is waiting when they can act again. One scan for every kit with
    -- such an ability (Caitlyn W, Jinx E, Jhin E, Teemo R, ...).
    --   spec.range     reach from the player
    --   spec.arm       seconds from the request until the zone is active
    --   spec.lifetime  seconds the zone then waits (default 4)
    --   spec.control=false / spec.arrivals=false  leave that evidence out
    -- Evidence, in the order it is trusted:
    --   'stasis'   a named stasis or revive buff with a known expiry
    --   'control'  hard crowd control that outlasts `arm`
    --   'channel'  an observed channel that outlasts `arm`
    --   'revive'   an enemy seen dying with a ready revive item (4 s at the spot)
    --   'arrival'  a teleport or gate marker particle (first-seen time; the scan
    --              is a rolling, bounded sweep, so the arrival time is a window)
    -- Buff, item and particle names are leads from the reference scripts, not
    -- verified mechanics: a name that never appears simply never triggers.
    -- Rows are {kind,unit?,position,freeAt,valid()}; valid() re-reads the evidence
    -- at dispatch. Nothing here is a hit, and the caller owns range, charges,
    -- existing traps and its own permission.
    local stasisNames={
        zhonyasringshield=true,lissandrarself=true,chronorevive=true,bardrstasis=true,
        jade_zhonyasringshield=true}
    local arrivalParticles={
        {kind='teleport',all={'teledash_end','wardenemy'},seconds=4},
        {kind='teleport',all={'global_ss_teleport_target_red'},seconds=4},
        {kind='gate',all={'gatemarker_red'},seconds=1.5}}
    local reviveSeconds=4
    function C:ZoneTargets(spec)
        local finite=C.finite;local rows={};local now=g.Game.Timer()
        if type(spec)~='table'or not finite(spec.range)or not finite(spec.arm)or spec.arm<0 then return rows end
        local arm,lifetime,range=spec.arm,spec.lifetime or 4,spec.range
        local zone=self.zoneWatch;if not zone then zone={revive={},arrivals={},index=1,alive={}};self.zoneWatch=zone end
        -- The provider's roster only lists targetable champions; a champion in
        -- stasis or reviving is neither. Read the host roster (identities are
        -- stable for a game; refreshed every 2 s for late loaders).
        local enemies=zone.roster
        if not enemies or now>=(zone.rosterAt or 0)then
            enemies={}
            if type(g.Game.HeroCount)=='function'and type(g.Game.Hero)=='function'then
                local total=g.Game.HeroCount()
                if finite(total)and total%1==0 and total>0 then
                    for i=1,math.min(total,12)do local o=g.Game.Hero(i);if o and o.team~=hero.team and C.id(o)then enemies[#enemies+1]=o end end
                end
            end
            if #enemies==0 then local listed=self:DecisionUnits('GetEnemyHeroes');for i=1,math.min(#listed,10)do enemies[i]=listed[i]end end
            zone.roster=enemies;zone.rosterAt=now+2
        end
        local function near(p)return p and finite(p.x)and finite(p.z)and flatDistance(hero.pos,p)<=range end
        local function fits(freeAt)return freeAt-now>=arm and freeAt-now<=arm+lifetime end
        for i=1,math.min(#enemies,10)do local u=enemies[i];local identity=C.id(u)
            if identity and u.team~=hero.team then
                -- Revive: a death observed between two looks, with the item ready before it.
                local was=zone.alive[identity]
                if u.dead==true and was and was.ready and now-was.at<=1.5 and not zone.revive[identity]and finite(was.x)then
                    zone.revive[identity]={x=was.x,y=was.y,z=was.z,freeAt=now+reviveSeconds,handle=u.handle}
                end
                if u.dead~=true and u.valid~=false then
                    local ready=was and was.ready or false
                    if not was or now-(was.itemsAt or 0)>=1 then
                        ready=false
                        for slot=6,12 do local d=u.GetSpellData and u:GetSpellData(slot)
                            if d and type(d.name)=='string'and d.name:lower():find('guardianangel',1,true)and d.currentCd==0 then ready=true;break end
                        end
                        was=was or {};was.itemsAt=now
                    end
                    was.ready=ready;was.at=now;was.x,was.y,was.z=u.pos and u.pos.x,u.pos and u.pos.y,u.pos and u.pos.z;zone.alive[identity]=was
                    if zone.revive[identity]and now>zone.revive[identity].freeAt-reviveSeconds+.5 then zone.revive[identity]=nil end
                end
                local revive=zone.revive[identity]
                if revive then
                    if now>revive.freeAt then zone.revive[identity]=nil
                    elseif near(revive)and fits(revive.freeAt)then
                        rows[#rows+1]={kind='revive',unit=u,position=C.point(revive),freeAt=revive.freeAt,
                            valid=function()return zone.revive[identity]==revive and u.handle==revive.handle and revive.freeAt-g.Game.Timer()>=arm end}
                    end
                end
                -- A unit in stasis is untargetable, so targetability is not required here.
                local function present()return u.valid~=false and u.visible==true and u.dead~=true and finite(u.health)and u.health>0 end
                if present()and near(u.pos)then
                    local handle=u.handle
                    local function stasis()
                        if not finite(u.buffCount)or u.buffCount<0 or u.buffCount>128 then return nil end
                        local t=g.Game.Timer()
                        for index=0,u.buffCount do local b=u:GetBuff(index)
                            if b and type(b.name)=='string'and stasisNames[b.name:lower()]and finite(b.count)and b.count>0 then
                                local ends=C.buffExpiry(b);if finite(ends)and ends>t then return ends end
                            end
                        end
                    end
                    local function control()
                        local t=g.Game.Timer();local cc=spec.control~=false and env.GetHardCCDuration(u)
                        if finite(cc)and cc>0 then return t+cc,'control'end
                        local cast=spec.control~=false and u.activeSpell
                        if cast and self:IsChannelCast(cast,false)and finite(cast.castEndTime)and cast.castEndTime>t then return cast.castEndTime,'channel'end
                    end
                    local ends=stasis();local kind='stasis'
                    if not ends then ends,kind=control()end
                    if ends and fits(ends)then
                        local read=kind=='stasis'and stasis or control
                        rows[#rows+1]={kind=kind,unit=u,position=C.point(u.pos),freeAt=ends,
                            valid=function()local e=present()and u.handle==handle and read();return e~=nil and e~=false and e-g.Game.Timer()>=arm end}
                    end
                end
            end
        end
        if spec.arrivals~=false and type(g.Game.ParticleCount)=='function'and type(g.Game.Particle)=='function'then
            local count=g.Game.ParticleCount()
            if finite(count)and count%1==0 and count>0 then
                count=math.min(count,2048)
                for _=1,math.min(count,48)do
                    if zone.index>count then zone.index=1 end
                    local index=zone.index;zone.index=index+1
                    local o=g.Game.Particle(index);local name=o and o.valid~=false and type(o.name)=='string'and o.name:lower()
                    if name and o.pos and finite(o.pos.x)and finite(o.pos.z)then
                        for _,row in ipairs(arrivalParticles)do
                            local match=true;for _,part in ipairs(row.all)do if not name:find(part,1,true)then match=false;break end end
                            if match then
                                local key=row.kind..':'..math.floor(o.pos.x/50)..':'..math.floor(o.pos.z/50)
                                if not zone.arrivals[key]then
                                    local born=finite(o.spawnTime)and o.spawnTime or finite(o.startTime)and o.startTime or now
                                    if born>now or born<now-row.seconds then born=now end
                                    zone.arrivals[key]={kind=row.kind,x=o.pos.x,y=o.pos.y or 0,z=o.pos.z,freeAt=born+row.seconds,object=o,index=index,name=name}
                                end
                                break
                            end
                        end
                    end
                end
            end
            for key,row in pairs(zone.arrivals)do
                if now>row.freeAt+.25 then zone.arrivals[key]=nil
                elseif near(row)and fits(row.freeAt)then
                    rows[#rows+1]={kind='arrival',arrival=row.kind,position=C.point(row),freeAt=row.freeAt,
                        valid=function()
                            local live=g.Game.Particle(row.index)
                            return zone.arrivals[key]==row and live==row.object and live.valid~=false and row.freeAt-g.Game.Timer()>=arm
                        end}
                end
            end
        end
        table.sort(rows,function(a,b)return a.freeAt<b.freeAt end)
        return rows
    end
    -- Attacks and empowered attacks that carry crowd control: the shared list
    -- (CombatProfiles/cc_attacks.lua, also read by EvAYYYYde). Lower case.
    local ccAttacks=modules.ccAttacks.set
    C.CCAttackNames=ccAttacks
    -- Crowd-control immunity (Leona-5): the shared list (CombatProfiles/cc_immunity.lua).
    -- C:CCImmune(unit,impact) answers true, reason when a listed buff on `unit` still
    -- holds `impact` seconds from now (a buff without a readable expiry counts as
    -- holding: skipping a stun is the safe side), false when none does, and nil,
    -- 'buff_state_unknown' when the buffs cannot be read. Spell shields and
    -- invulnerability stay with C:SpellShielded / C:SpellProtected: a caller about to
    -- spend crowd control checks both. Bounded to 64 buffs; no cache.
    local ccImmunity=modules.ccImmunity.set
    C.CCImmunityNames=ccImmunity
    function C:CCImmune(unit,impact)
        local count=unit and unit.buffCount
        if type(count)~='number'or count~=count or count<0 or count>128 or count%1~=0 or type(unit.GetBuff)~='function'then
            return nil,'buff_state_unknown'end
        local at=g.Game.Timer()+(finiteNumber(impact)and impact>0 and impact or 0)
        for i=0,math.min(count,64)do
            local buff=unit:GetBuff(i)
            if buff and type(buff.name)=='string'and ccImmunity[buff.name:lower()]and(not finiteNumber(buff.count)or buff.count>0)then
                local finish=buff.expireTime
                if not finiteNumber(finish)or finish<=0 then finish=buff.endTime end
                if not finiteNumber(finish)or finish<=0 then return true,'cc_immune_expiry_unknown'end
                if finish>at then return true,buff.name:lower()end
            end
        end
        return false
    end
    -- A melee champion (attack range under 300) whose basic attack already
    -- reaches `ally` (edge to edge, 50 units of slack).
    local function meleeReach(enemy,ally)
        local range=enemy.range
        if not env.IsValid(enemy)or not finiteNumber(range)or range>=300 or not enemy.pos or not ally.pos then return false end
        local reach=range+(enemy.boundingRadius or 65)+(ally.boundingRadius or 65)+50
        return flatDistance(enemy.pos,ally.pos)<=reach
    end
    -- Enemy champions' targeted spell missiles in flight, indexed by target id
    -- once per game tick (at most 256 missiles read). Basic attacks are left to
    -- IncomingAttack. Rows: {missile,owner,name,speed}.
    local missileIndex={at=-1,rows={}}
    function C:TargetedMissiles()
        local now=g.Game.Timer();if missileIndex.at==now then return missileIndex.rows end
        local rows={};missileIndex.at=now;missileIndex.rows=rows
        local count=g.Game.MissileCount and g.Game.MissileCount()
        if not finiteNumber(count)or count<=0 then return rows end
        local enemies=self:DecisionUnits('GetEnemyHeroes')
        for i=1,math.min(256,count)do
            local m=g.Game.Missile(i);local d=m and m.missileData
            if d and m.valid~=false and not m.dead and m.pos and finiteNumber(d.speed)and d.speed>0 and d.target and d.target~=0 then
                local name=type(d.name)=='string'and d.name:lower()or''
                if not name:find('basicattack',1,true)and not name:find('critattack',1,true)then
                    local owner
                    for j=1,math.min(#enemies,5)do local e=enemies[j];if e and(e.networkID==d.owner or e.handle==d.owner)then owner=e;break end end
                    if owner then local list=rows[d.target];if not list then list={};rows[d.target]=list end
                        list[#list+1]={missile=m,owner=owner,name=d.name,speed=d.speed}end
                end
            end
        end
        return rows
    end
    -- What is about to hit an ally (or the player): the trigger for shields and
    -- heals. Evidence only, in this order of trust:
    --   'attack'    a champion's basic attack already winding up or in flight
    --   'cast'      a champion's targeted cast winding up on this unit
    --   'turret'    an enemy turret currently targeting this unit
    --   'skillshot' the unit stands in a tracked enemy spell: Evade's public
    --               threat model, asked about the ally's position (capability
    --               gated). Without Evade: the native-ray fallback below
    --               (fallback=true), an enemy champion's untargeted cast still
    --               winding up whose own native line covers the unit.
    --   'missile'   an enemy champion's targeted spell missile already flying at
    --               this unit (Annie Q, Brand E, ...), opts.missiles=false leaves it out
    -- Opt-in, lower-trust kinds (2026-10-10):
    --   'dash'      an enemy champion dashing to land within 300 of this unit
    --               (opts.dashes=true)
    --   'melee'     a melee champion already within its attack reach of this
    --               unit (opts.melee=true); the next attack, not an observed one
    --   'dot'       the unit carries an enemy's damaging debuff (opts.dots=true,
    --               C:DamagingDebuff below); reported only when no other kind
    --               is, with remaining=seconds and damage=remaining damage or nil
    -- Returns {kind,source?,impactIn,cc?,valid()} for the soonest threat within
    -- `horizon` seconds, or nil. cc=true marks an attack or cast that carries
    -- crowd control (C.CCAttackNames). opts.attacks/casts/turrets/skillshots=false
    -- leave one kind out. valid() re-reads that evidence at dispatch. The caller
    -- owns range, consent, health limits and whether the ability is worth it.
    function C:AllyThreat(ally,horizon,opts)
        local finite=C.finite;opts=opts or {}
        if not ally or not env.IsValid(ally)or not finite(horizon)or horizon<=0 or horizon>4 or not ally.pos then return nil end
        local now=g.Game.Timer();local best
        local allyID,allyHandle=ally.networkID,ally.handle
        local function offer(row)
            if row.name and ccAttacks[tostring(row.name):lower()]then row.cc=true end
            if not best or row.impactIn<best.impactIn then best=row end
        end
        if opts.dashes==true or opts.melee==true then
            local enemies=self:DecisionUnits('GetEnemyHeroes')
            for i=1,math.min(#enemies,5)do local enemy=enemies[i]
                if env.IsValid(enemy)and enemy.team~=ally.team and enemy.pos then
                    if opts.dashes==true and self:DashLanding(enemy,ally.pos,300,true)then
                        offer({kind='dash',source=enemy,impactIn=.25,valid=function()return env.IsValid(ally)and self:DashLanding(enemy,ally.pos,300,true)~=nil end})
                    elseif opts.melee==true and meleeReach(enemy,ally)then
                        offer({kind='melee',source=enemy,impactIn=.3,valid=function()return env.IsValid(ally)and meleeReach(enemy,ally)end})
                    end
                end
            end
        end
        if opts.missiles~=false then
            local list=self:TargetedMissiles()[allyID or -1]or self:TargetedMissiles()[allyHandle or -1]
            for _,m in ipairs(list or {})do
                local remaining=math.max(0,flatDistance(m.missile.pos,ally.pos)-(ally.boundingRadius or 65))/m.speed
                if remaining<=horizon then
                    offer({kind='missile',source=m.owner,impactIn=remaining,name=m.name,
                        valid=function()return m.missile.valid~=false and not m.missile.dead and env.IsValid(ally)end})
                end
            end
        end
        if opts.attacks~=false then
            local attack=self:IncomingAttack(ally,0,horizon)
            if attack then
                offer({kind='attack',source=attack.caster,impactIn=attack.delay,name=attack.name,
                    valid=function()local a=self:IncomingAttack(ally,0,horizon);return a~=nil and a.casterID==attack.casterID and a.start==attack.start end})
            end
        end
        if opts.casts~=false then
            local enemies=self:DecisionUnits('GetEnemyHeroes')
            for i=1,math.min(#enemies,5)do local enemy=enemies[i]
                if env.IsValid(enemy)and enemy.team~=ally.team then
                    local cast=self:CastWindup(enemy,-.05,horizon,false,allyID,allyHandle)
                    if cast then
                        offer({kind='cast',source=enemy,impactIn=math.max(0,cast.castEndTime-now),name=cast.name,
                            valid=function()return self:MatchesCastWindup(enemy,cast,-.05,horizon,false)end})
                    end
                end
            end
        end
        if opts.turrets~=false then
            local turrets=self:DecisionUnits('GetEnemyTurrets')
            for i=1,math.min(#turrets,16)do local turret=turrets[i]
                if env.IsValid(turret)and turret.targetID==allyID and allyID~=nil and flatDistance(turret.pos,ally.pos)<=1100 then
                    offer({kind='turret',source=turret,impactIn=.25,
                        valid=function()return env.IsValid(turret)and env.IsValid(ally)and turret.targetID==allyID end})
                    break
                end
            end
        end
        if opts.skillshots~=false then
            local evade=sdk.Evade
            if evade and type(evade.GetDangerIntervals)=='function'then
                local function read()
                    local ok,result=pcall(evade.GetDangerIntervals,evade,ally.pos,g.Game.Timer(),g.Game.Timer()+horizon,
                        {radius=ally.boundingRadius or 65,workBudget=2000})
                    if not ok or type(result)~='table'or result.complete~=true or type(result.intervals)~='table'then return nil end
                    local first
                    for index=1,math.min(#result.intervals,16)do local span=result.intervals[index]
                        if span and span.possible~=true and finite(span.starts)and(not first or span.starts<first.starts)then first=span end
                    end
                    return first
                end
                local span=read()
                if span then
                    local spanID=span.id -- the id, not the row: a provider may reuse its row tables
                    offer({kind='skillshot',impactIn=math.max(0,span.starts-now),id=spanID,
                        valid=function()local s=env.IsValid(ally)and read();return s~=nil and s~=false and s.id==spanID end})
                end
            else
                local enemies=self:DecisionUnits('GetEnemyHeroes')
                for i=1,math.min(#enemies,5)do local enemy=enemies[i]
                    if env.IsValid(enemy)and enemy.team~=ally.team then
                        local hit=self:NativeSkillshot(enemy,ally,horizon)
                        if hit then
                            offer({kind='skillshot',fallback=true,source=enemy,impactIn=hit.impactIn,name=hit.name,
                                valid=function()local again=env.IsValid(ally)and self:NativeSkillshot(enemy,ally,horizon)
                                    return again~=nil and again~=false and again.name==hit.name and again.start==hit.start end})
                        end
                    end
                end
            end
        end
        if opts.dots==true and not best then
            local dot=self:DamagingDebuff(ally)
            if dot and dot.remaining>0 then
                local name,source=dot.name,dot.source
                offer({kind='dot',source=source,impactIn=0,name=name,remaining=dot.remaining,damage=dot.damage,estimated=dot.estimated,
                    valid=function()local again=env.IsValid(ally)and self:DamagingDebuff(ally)
                        return again~=nil and again~=false and again.name==name and again.source==source end})
            end
        end
        return best
    end
    -- Damage over time (Lux-10 / Karma-5, 2026-10-10): the strongest enemy damaging
    -- debuff on `unit` (an ally or the player). Evidence, conservative:
    --   * host buff type 13 (Damage) or 24 (Poison) (Orbama BuffType), or a listed
    --     Ignite name, with a positive count and a readable expiry at least .25 s
    --     away (a burn about to end is not worth a shield);
    --   * the buff's source (sourcenID/source) is an enemy champion; a buff
    --     whose source is the unit's own team, or an unattributed one, is refused
    --     (Ignite alone may be unattributed: its name names an enemy summoner).
    -- Remaining damage: Ignite 70 + 20 per source level true damage over its 5 s
    -- (both profiles, as C:IgniteStatus; the source's level when known, else
    -- level 1, a lower bound), scaled by the remaining share of the buff.
    -- Any other debuff: damage=nil (unknown, estimated=false); the caller then
    -- decides from the unit's health alone. Bounded to 64 buffs and 5 enemies.
    -- Returns {name,source,remaining,damage,estimated,ignite} or nil.
    local igniteBuffs={summonerdot=true,summonerdot_jade=true}
    function C:DamagingDebuff(unit)
        local count=unit and unit.buffCount
        if type(count)~='number'or count~=count or count<0 or count>128 or type(unit.GetBuff)~='function'then return nil end
        local now=g.Game.Timer();local enemies=self:DecisionUnits('GetEnemyHeroes');local best
        local function sourceOf(b)
            local id=b.sourcenID;if id==nil or id==0 then id=b.source end
            if type(id)=='table'or type(id)=='userdata'then id=id.networkID or id.handle end
            if id==nil or id==0 then return nil,false end
            for i=1,math.min(#enemies,5)do local e=enemies[i]
                -- A burn outlives its caster: a dead enemy's debuff still counts.
                if e and(e.networkID==id or e.handle==id)then return e.team~=unit.team and e or nil,true end
            end
            return nil,true -- attributed to someone who is not a living enemy champion
        end
        for i=0,math.min(count,64)do
            local b=unit:GetBuff(i)
            local name=b and type(b.name)=='string'and b.name:lower()
            if name and(b.type==13 or b.type==24 or igniteBuffs[name])and finiteNumber(b.count)and b.count>0 then
                local finish=C.buffExpiry(b)
                if finiteNumber(finish)and finish>now+.25 then
                    local source,attributed=sourceOf(b);local ignite=igniteBuffs[name]==true
                    if source or ignite and not attributed then
                        local damage
                        if ignite then
                            local level=source and source.levelData and source.levelData.lvl
                            level=finiteNumber(level)and math.max(1,math.min(18,math.floor(level)))or 1
                            local duration=finiteNumber(b.duration)and b.duration>0 and b.duration or 5
                            damage=(70+20*(level-1))*math.min(1,(finish-now)/duration)
                        end
                        local row={name=name,source=source,remaining=finish-now,damage=damage,estimated=damage~=nil,ignite=ignite}
                        if not best or(row.damage or 0)>(best.damage or 0)or(row.damage or 0)==(best.damage or 0)and row.remaining>best.remaining then best=row end
                    end
                end
            end
        end
        return best
    end
    -- Skillshot evidence without Evade (Janna-14, 2026-10-10). Only fields the host
    -- exposes on activeSpell (also read by Evade's observer and reference scripts):
    -- startPos, placementPos/endPos, range, width, speed, castEndTime. An enemy
    -- champion's untargeted, non-attack cast still winding up (not a channel) is
    -- modelled as its native line: from startPos toward placementPos for the native
    -- range (500..2500; otherwise to the placement point), half its native width
    -- (30..400, the bounds Evade uses for unknown projectiles) plus the unit's
    -- radius. Contact = cast end plus travel at the native speed (none when the
    -- speed is not finite: instant). The shape is not known: a circle spell counts
    -- along its whole path, a line beyond its native range is not seen, and a cast
    -- missing any field is no evidence. Returns {impactIn,name,start} or nil.
    function C:NativeSkillshot(enemy,ally,horizon)
        local finite=C.finite
        local cast=self:ReadCast(enemy);local now=g.Game.Timer()
        if not cast or not cast.valid or cast.isStopped or cast.isChanneling==true or type(cast.name)~='string'or cast.name==''
            or self:IsAttackCast(cast)==true or(cast.target~=nil and cast.target~=0)
            or not finite(cast.startTime)or not finite(cast.castEndTime)or cast.castEndTime<now then return nil end
        local from,to=cast.startPos,cast.placementPos or cast.endPos
        if type(from)~='table'and type(from)~='userdata'or type(to)~='table'and type(to)~='userdata'
            or not finite(from.x)or not finite(from.z)or not finite(to.x)or not finite(to.z)then return nil end
        local width=cast.width
        if not finite(width)or width<30 or width>400 then return nil end
        local dx,dz=to.x-from.x,to.z-from.z;local aimed=math.sqrt(dx*dx+dz*dz)
        if aimed<50 then return nil end
        local length=finite(cast.range)and cast.range>=500 and cast.range<=2500 and math.max(aimed,cast.range)or aimed
        dx,dz=dx/aimed,dz/aimed
        local px,pz=ally.pos.x-from.x,ally.pos.z-from.z;local along=px*dx+pz*dz
        local radius=width/2+(ally.boundingRadius or 65)
        if along<-radius or along>length+radius then return nil end
        local clamped=math.max(0,math.min(length,along));local ox,oz=px-dx*clamped,pz-dz*clamped
        if ox*ox+oz*oz>radius*radius then return nil end
        local travel=finite(cast.speed)and cast.speed>0 and math.max(0,along-radius)/cast.speed or 0
        local impactIn=math.max(0,cast.castEndTime-now)+travel
        if impactIn>horizon then return nil end
        return {impactIn=impactIn,name=cast.name,start=cast.startTime}
    end
    -- The enemy to crowd-control away from `ally` (or the player), for peel
    -- abilities (knock-backs, stuns, slows, taunts): a champion dashing onto it,
    -- then the attacker of an attack on it, then a melee champion in reach.
    -- Returns enemy, kind, impactIn or nil. The caller owns range and consent.
    function C:PeelTarget(ally,horizon,opts)
        opts=opts or {}
        local threat=self:AllyThreat(ally,horizon or 1.5,{dashes=true,melee=opts.melee~=false,casts=opts.casts,turrets=false,skillshots=false})
        if threat and threat.source and threat.source.type==g.Obj_AI_Hero then return threat.source,threat.kind,threat.impactIn end
        return nil
    end
    function C:Fresh(fn,...)
        local previous=self.validating;self.validating=true
        local result=pack(pcall(fn,...));self.validating=previous
        if not result[1]then error(result[2],0)end
        return unpack(result,2,result.n)
    end
    -- The host reports isChanneling=true during basic-attack windups (live:
    -- Jade_VayneBasicAttack, Jade_VayneQ_Attack). Use SDK attack recognition so
    -- attacks are not mistaken for channels; real channels (recall etc.) remain.
    -- Orbama's post-attack callback has no arguments. LastTarget is
    -- only a cheap identity hint; the shared observer still requires the actual
    -- fresh native attack, recipient and completed windup. Never use GetTarget()
    -- to substitute a newly selected unit for the observed recipient.
    function C:AttackWitness(previous,target)
        local hint=target or sdk.Orbwalker.LastTarget
        return modules.observeAttack(g,previous,function(id)
            if hint and(hint.networkID==id or hint.handle==id)then return hint end
            local retained=previous and previous.object
            if not target and retained and(retained.networkID==id or retained.handle==id)then return retained end
        end)
    end
    function C:IsAttackCast(spell)
        if not spell or not spell.valid then return false end
        if spell.isAutoAttack==true then return true end
        local name=spell.name
        if type(name)~='string' or name=='' then return false end
        local data=sdk and sdk.Data
        if data and type(data.IsAttack)=='function' then
            local ok,yes=pcall(data.IsAttack,data,name)
            if ok then return yes and true or false end
        end
        return name:lower():find('attack',1,true)~=nil
    end
    function C:IsChannelCast(spell,includeStopped)
        if not spell or not spell.valid or spell.isChanneling~=true then return false end
        if not includeStopped and spell.isStopped==true then return false end
        return not self:IsAttackCast(spell)
    end
    -- Dangerous channels by native cast name (lower case) and their channel length
    -- in seconds, for hosts that leave isInterruptible unset. Names: installed
    -- assets 16.20 and Orbama's channel table; lengths: wiki (read 2026-10-10),
    -- Classic from the Classic assets. The host's castEndTime wins when later; an
    -- explicit isInterruptible=false always refuses.
    local channels={katarinar=2.5,fiddlesticksr=1.5,fiddlestickswr=2,fiddlesticksw=2,missfortunebullettime=3,caitlynaceinthehole=1,
        nunur=3,malzaharr=2.5,velkozr=2.3,xerathlocusofpower2=10,xeratharcanopulsechargeup=3,jhinr=10,karthusfallenone=3,pantheonr=2,
        destiny=1.5,gate=1.5,galior=2.75,warwickr=1.5,reapthewhirlwind=3,shenr=3,lucianr=3,varusq=4,pykeq=3,sionq=2,zace=1.8,viq=1.25,
        kaisae=1.2,urgotswap2=1,vladimire=1.5,
        jade_katarinar=2.5,jade_fiddlesticksr=5,jade_fiddlesticksw=5,jade_missfortunebullettime=2,jade_caitlynr=1,jade_nunur=3,
        jade_malzaharr=2.5,jade_karthusfallenone=3,jade_pantheonr=2,jade_pantheonechannel=.75,jade_twistedfatedestiny=1.5,
        jade_twistedfatee=3,jade_galior=2,jade_warwickr=1.8,jade_warwickrchannel=1.8,jade_jannareapthewhirlwind=4,
        jade_jannahowlinggale=3,jade_shenr=3,jade_sionq=2}
    C.ChannelNames=channels
    function C:CanInterrupt(target,impact,margin)
        if not env.IsValid(target)or type(impact)~='number'or impact~=impact or impact<0 or impact==math.huge then return false end
        local cast=target.activeSpell;local now=g.Game.Timer()
        margin=margin or .05
        if type(margin)~='number'or margin~=margin or margin<0 or margin>1 then return false end
        if not cast or not cast.valid or cast.isStopped==true or cast.isInterruptible==false then return false end
        local length=type(cast.name)=='string'and channels[cast.name:lower()]
        local channel=self:IsChannelCast(cast)and cast.isInterruptible==true or length and cast.isInterruptible==nil and not self:IsAttackCast(cast)
        if not channel or type(cast.startTime)~='number'or cast.startTime>now then return false end
        local finish=cast.castEndTime
        -- The catalogue length only stands in for a host that leaves the channel
        -- unflagged; a flagged channel's own castEndTime is authoritative.
        if length and cast.isInterruptible==nil then finish=math.max(type(finish)=='number'and finish or 0,cast.startTime+length)end
        return type(finish)=='number'and finish<math.huge and finish>now+impact+margin
    end
    -- A caster's native activeSpell, read once per decision scope (several
    -- allies' threat scans share it); outside a decision and during final
    -- validation it is read fresh.
    function C:ReadCast(caster)
        if self.validating or not self.evaluation or not self.evaluation.valid then return caster.activeSpell end
        local key='cast:'..tostring(caster.networkID or caster.handle or caster)
        local row=self:DecisionValue(key,function()return caster.activeSpell or false end)
        return row or nil
    end
    -- One native interpretation for current attack/spell windups. The copied
    -- witness is observation, not a command, a hit or an inferred future cast.
    function C:CastWindup(caster,minimum,maximum,attack,targetID,targetHandle)
        -- A negative minimum looks back past the end of the windup: a ranged attack
        -- is still in flight then, and the caster's attack cast remains readable.
        if not env.IsValid(caster)or not finiteNumber(minimum)or minimum<-1.5
            or not finiteNumber(maximum)or maximum<minimum or maximum>4 then return nil end
        local now=g.Game.Timer();local cast=self:ReadCast(caster)
        if not cast or not cast.valid or cast.isStopped or type(cast.name)~='string'or cast.name==''
            or not finiteNumber(cast.startTime)or cast.startTime>now or not finiteNumber(cast.castEndTime)
            or cast.castEndTime<now+minimum or cast.castEndTime>now+maximum then return nil end
        if(targetID or targetHandle)and not(targetID and cast.target==targetID or targetHandle and cast.target==targetHandle)then return nil end
        local casterID,casterHandle=caster.networkID,caster.handle
        if not finiteNumber(casterID)or casterID<=0 or casterID%1~=0 then casterID=nil end
        if not finiteNumber(casterHandle)or casterHandle<=0 or casterHandle%1~=0 then casterHandle=nil end
        if not casterID and not casterHandle then return nil end
        local isAttack=self:IsAttackCast(cast)==true
        if attack~=nil and isAttack~=attack then return nil end
        return {casterID=casterID,casterHandle=casterHandle,name=cast.name,start=cast.startTime,
            target=cast.target,castEndTime=cast.castEndTime,attack=isAttack,isChanneling=cast.isChanneling==true}
    end
    function C:MatchesCastWindup(caster,witness,minimum,maximum,attack)
        if type(witness)~='table'then return false end
        local current=self:CastWindup(caster,minimum,maximum,attack)
        return current~=nil and current.casterID==witness.casterID and current.casterHandle==witness.casterHandle
            and current.name==witness.name and current.start==witness.start and current.target==witness.target
    end
    -- Current native attack windups only. This is not a future attack command or
    -- a launched-missile tracker; callers retain their own effect/recipient policy.
    function C:IncomingAttack(target,minDelay,maxDelay)
        if not env.IsValid(target)or not target.pos or not finiteNumber(target.pos.x)or not finiteNumber(target.pos.z)
            or not finiteNumber(minDelay)or minDelay<0 or not finiteNumber(maxDelay)or maxDelay<minDelay or maxDelay>4 then return nil end
        local targetID,targetHandle=target.networkID,target.handle
        if not finiteNumber(targetID)or targetID<=0 or targetID%1~=0 then targetID=nil end
        if not finiteNumber(targetHandle)or targetHandle<=0 or targetHandle%1~=0 then targetHandle=nil end
        if not targetID and not targetHandle then return nil end
        local now=g.Game.Timer();local best
        local enemies=self:DecisionUnits('GetEnemyHeroes')
        for i=1,math.min(#enemies,5)do local enemy=enemies[i]
            if env.IsValid(enemy)and enemy.team~=target.team and enemy.pos
                and finiteNumber(enemy.pos.x)and finiteNumber(enemy.pos.z)then
                -- Include attacks already released: the impact time below, not the
                -- windup, decides whether one is still incoming.
                local cast=self:CastWindup(enemy,-1,1.25,true,targetID,targetHandle)
                if cast then
                    local speed=enemy.attackData and enemy.attackData.projectileSpeed
                    if speed==math.huge or finiteNumber(speed)and speed>0 then
                        local x,z=enemy.pos.x-target.pos.x,enemy.pos.z-target.pos.z
                        local impact=cast.castEndTime+(speed==math.huge and 0 or math.sqrt(x*x+z*z)/speed)
                        local delay=impact-now
                        if delay>=minDelay and delay<=maxDelay and(not best or impact<best.impactAt)then
                            best={caster=enemy,casterID=enemy.networkID,casterHandle=enemy.handle,name=cast.name,
                                start=cast.start,targetID=cast.target,targetHandle=targetHandle,castEndTime=cast.castEndTime,
                                impactAt=impact,delay=delay}
                        end
                    end
                end
            end
        end
        return best
    end
    function C:DashLanding(target,origin,landingRange,approaching)
        if not env.IsValid(target)then return nil end
        local motion=prediction.facade.ChampionMotion
        local snapshot=motion and motion.ReadPath(target,g.Game.Timer())
        if not snapshot then return nil end
        origin=origin or hero.pos
        local function squared(point)local x,z=point.x-origin.x,point.z-origin.z;return x*x+z*z end
        local after=squared(snapshot.to)
        if approaching and after>=squared(snapshot.from)or landingRange and after>=landingRange*landingRange then return nil end
        return snapshot
    end
    function C:ApproachingDash(target,origin,landingRange)
        return self:DashLanding(target,origin,landingRange,true)
    end
    -- Own channel for policy gates. Historical gates did not exclude stopped casts.
    function C:SelfChanneling(excludeStopped)
        return self:IsChannelCast(g.myHero.activeSpell,not excludeStopped)
    end
    -- Seconds until the observed own basic-attack windup completes (0 if none).
    function C:AttackWindupRemaining()
        local spell=g.myHero.activeSpell
        if not spell or not spell.valid or spell.isStopped==true or not self:IsAttackCast(spell) then return 0 end
        local finish=tonumber(spell.castEndTime);local now=g.Game.Timer()
        if not finish or finish~=finish or finish<=now then return 0 end
        return math.min(finish-now,1.5)
    end
    -- Seconds until the player's next basic attack may start (0: ready now), or
    -- nil when the orbwalker's attack timer is unavailable.
    function C:AttackReadyIn()
        local attack=sdk.Attack
        if type(attack)~='table'or type(attack.IsReady)~='function'or type(attack.GetAnimation)~='function'then return nil end
        local ok,ready=pcall(attack.IsReady,attack);if not ok then return nil end
        if ready then return 0 end
        local okAnimation,animation=pcall(attack.GetAnimation,attack)
        if not okAnimation or not finiteNumber(animation)or not finiteNumber(attack.ServerStart)then return nil end
        local latency=0;local data=sdk.Data
        if data and type(data.GetLatency)=='function'then local okLatency,value=pcall(data.GetLatency,data);if okLatency and finiteNumber(value)then latency=value end end
        return math.max(0,attack.ServerStart+animation-latency-g.Game.Timer())
    end
    -- Weaving: a spell with `castTime` seconds of cast fits between basic attacks
    -- when the own attack is not winding up and, with `target` inside attack
    -- range, the next attack is not ready before the cast ends (rivals cast in
    -- the attack cooldown; casting into a ready attack delays it). Without a
    -- target in range nothing is delayed. Returns ok, reason.
    function C:WeaveWindow(castTime,target)
        if self:AttackWindupRemaining()>0 then return false,'attack_windup'end
        if not target or not env.IsValid(target)then return true end
        local data=sdk.Data
        local inRange=data and type(data.IsInAutoAttackRange)=='function'and data:IsInAutoAttackRange(hero,target)
        if not inRange then return true end
        local readyIn=self:AttackReadyIn();if readyIn==nil then return true,'attack_timer_unknown'end
        castTime=finiteNumber(castTime)and math.max(0,castTime)or .25
        if readyIn<=0 then return false,'attack_ready'end
        return readyIn+.05>=castTime,readyIn+.05>=castTime and nil or'attack_due_during_cast'
    end
    -- Mana reserve: casting `slot` still leaves enough mana for every slot in
    -- `keep` that is learned and comes off cooldown within `within` seconds
    -- (Kog'Maw W, Twisted Fate R, an escape). Resourceless champions pass.
    function C:Affordable(slot,keep,within)
        local data=hero:GetSpellData(slot);local cost=data and data.mana
        if not finiteNumber(cost)or cost<0 then return false,'cost_unknown'end
        if not finiteNumber(hero.maxMana)or hero.maxMana<=0 then return true end
        local need=cost
        for _,other in ipairs(keep or {})do
            if other~=slot then local d=hero:GetSpellData(other)
                if d and(d.level or 0)>0 and finiteNumber(d.mana)and d.mana>0 and finiteNumber(d.currentCd)and d.currentCd<=(within or 3)then need=need+d.mana end
            end
        end
        return hero.mana>=need,hero.mana>=need and nil or'mana_reserved'
    end
    -- Best aim for an area ability over a bounded point set (predicted champion
    -- positions, minions, monsters). Pure geometry, no prediction or input.
    --   points  array of {x,z,weight?,unit?} (at most 24 are considered)
    --   shape   {kind='circle',radius,range} | {kind='line',width,range}
    --           | {kind='cone',angle(degrees, full width),range}; origin = shape.origin or the player
    --   opts.must  index of a point every candidate aim must hit (the main target)
    -- Candidates: every point, every pairwise midpoint (circle) or direction
    -- (line, cone), so at most 300 aims are scored. Returns aim, weight, hits
    -- (array of point indices) or nil when no candidate hits opts.must.
    function C:BestAim(points,shape,opts)
        opts=opts or {};local origin=C.point(shape.origin or hero.pos);local n=math.min(#points,24)
        if not origin or n==0 or not finiteNumber(shape.range)then return nil end
        local kind=shape.kind;local cosHalf=kind=='cone'and math.cos(math.rad((shape.angle or 0)/2))
        local function hits(ax,az)
            local dx,dz=ax-origin.x,az-origin.z;local length=math.sqrt(dx*dx+dz*dz)
            if kind~='circle'and length<1 then return {},-1 end
            local ux,uz=length>0 and dx/length or 0,length>0 and dz/length or 0
            local list,weight={},0
            for i=1,n do local q=points[i];local qx,qz=q.x-origin.x,q.z-origin.z;local inside
                if kind=='circle'then inside=(q.x-ax)^2+(q.z-az)^2<=shape.radius^2
                else
                    local along=qx*ux+qz*uz;local distance=math.sqrt(qx*qx+qz*qz)
                    if kind=='line'then inside=along>=0 and along<=shape.range and math.abs(qx*uz-qz*ux)<=(shape.width or 0)/2+(q.radius or 0)
                    else inside=distance<=shape.range and(distance==0 or along/distance>=cosHalf)end
                end
                if inside then list[#list+1]=i;weight=weight+(q.weight or 1)end
            end
            return list,weight
        end
        local best,bestWeight,bestHits
        local function try(ax,az)
            if kind=='circle'and(ax-origin.x)^2+(az-origin.z)^2>shape.range^2 then
                local dx,dz=ax-origin.x,az-origin.z;local l=math.sqrt(dx*dx+dz*dz);ax,az=origin.x+dx/l*shape.range,origin.z+dz/l*shape.range
            end
            local list,weight=hits(ax,az)
            if opts.must then local ok=false;for _,i in ipairs(list)do if i==opts.must then ok=true;break end end;if not ok then return end end
            if not best or weight>bestWeight then best,bestWeight,bestHits={x=ax,y=origin.y or 0,z=az},weight,list end
        end
        for i=1,n do local a=points[i];try(a.x,a.z)
            for j=i+1,n do local b=points[j]
                if kind=='circle'then if(a.x-b.x)^2+(a.z-b.z)^2<=(2*shape.radius)^2 then try((a.x+b.x)/2,(a.z+b.z)/2)end
                else try((a.x+b.x)/2,(a.z+b.z)/2)end
            end
        end
        if not best then return nil end
        return best,bestWeight,bestHits
    end
    -- Shared ultimate policy (keyless and Combo ultimates alike). spec:
    --   hits      enemy champions the cast hits (at their predicted positions)
    --   minimum   the menu's enemy count (0 or nil: the count reason is off)
    --   kills     fn(unit): the cast plus ready, affordable follow-ups kill it
    --   danger    true when the cast is the player's answer to a lethal threat
    --   consent   fn(unit): per-enemy permission (C:TargetConsent)
    -- Units that are invalid, without consent or that cannot die are not
    -- counted. Returns true and 'count' | 'kill' | 'danger', or false, reason.
    function C:UltimateWorth(spec)
        local count,killable=0,nil
        for _,u in ipairs(spec.hits or {})do
            if env.IsValid(u)and u.team~=hero.team and(not spec.consent or spec.consent(u))and not self:CannotDie(u,spec.impact or 0)then
                count=count+1
                if not killable and spec.kills and spec.kills(u)then killable=u end
            end
        end
        if count==0 then return false,'no_target'end
        if killable then return true,'kill',killable end
        if finiteNumber(spec.minimum)and spec.minimum>0 and count>=spec.minimum then return true,'count'end
        if spec.danger then return true,'danger'end
        return false,'not_worth'
    end
    -- Public champion mobility capability, version 1 (SDK.ChampionMobility).
    -- A defensive consumer (Evade) evaluates safety and requests a point; this
    -- controller owns the key, slot resource, readiness, champion policy and
    -- cleanup, and submits through its own ActionClient. Consumers never press
    -- the champion key. Returns acceptance plus a Poll/Cancel handle, not a dash.
    --
    -- Several offers per champion (additive to version 1): a spec with
    -- additional=true is appended to the active root provider's `alternatives`
    -- array (at most C.maxMobilityAlternatives) instead of replacing it; with no
    -- root yet it becomes the root. Each alternative is a complete version-1
    -- provider of its own kind ('dash', 'unitDash' or 'untargetable', a dash may
    -- carry its own `.unit`) with its own slot resource, readiness, policy and
    -- cleanup; it is active only while it is listed and the root is active. A
    -- version-1 consumer that reads only the root keeps working unchanged. One
    -- slot is offered once (mobility_slot_offered).
    C.maxMobilityAlternatives=4
    local function mobilityOffers(root)
        local out={}
        local function add(p)if type(p)=='table'then out[#out+1]=p end end
        add(root);if root then add(root.unit)
            for _,a in ipairs(root.alternatives or {})do add(a);add(a.unit)end
        end
        return out
    end
    -- The active root this controller may append to, or nil.
    function C:MobilityRoot()
        local root=self.mobility
        if root and sdk.ChampionMobility==root and root:Active()then return root end
    end
    local function attachMobility(self,provider,root)
        if root then
            for _,offer in ipairs(mobilityOffers(root))do if offer.slot==provider.slot then return false,'mobility_slot_offered'end end
            if #root.alternatives>=C.maxMobilityAlternatives then return false,'too_many_mobility_offers'end
            root.alternatives[#root.alternatives+1]=provider
            return true,provider
        end
        provider.alternatives={}
        self.mobility=provider;sdk.ChampionMobility=provider
        return true,provider
    end
    local function listed(root,provider)
        for _,a in ipairs(root.alternatives or {})do if a==provider then return true end end
        return false
    end
    function C:RegisterMobility(spec)
        local h=g.myHero
        local function finite(v)return type(v)=='number'and v==v and v>-math.huge and v<math.huge end
        if type(spec)=='table'and spec.additional~=nil and spec.additional~=true then return false,'invalid_mobility_spec'end
        local root=type(spec)=='table'and spec.additional==true and self:MobilityRoot()or nil
        if type(spec)=='table'and(spec.kind=='untargetable'or spec.kind=='unitDash')then return self:RegisterUntargetable(spec,nil,root)end
        if type(spec)~='table'or spec.kind~='dash'or type(spec.slot)~='number'or spec.key==nil
            or type(spec.name)~='string'or not finite(spec.range)or spec.range<=0
            or type(spec.castDelays)~='table'or #spec.castDelays==0 or type(spec.source)~='string'
            or spec.blink~=nil and spec.blink~=true or spec.toPoint~=nil and spec.toPoint~=true
            or spec.lethalOnly~=nil and spec.lethalOnly~=true then return false,'invalid_mobility_spec'end
        -- A blink (blink=true) has no travel, so it needs no speed; every other dash does.
        -- toPoint=true: the displacement ends at the chosen point rather than at full length.
        if spec.blink~=true and(type(spec.speeds)~='table'or #spec.speeds==0)then return false,'invalid_mobility_spec'end
        if sdk.ChampionMobility and sdk.ChampionMobility~=self.mobility and sdk.ChampionMobility.Active
            and sdk.ChampionMobility:Active()then return false,'mobility_owned_elsewhere'end
        local provider={version=1,kind='dash',owner='AyyyyIOControllers',champion=h.charName,profile=spec.profile,
            slot=spec.slot,resource='slot:'..spec.slot,range=spec.range,label=spec.label,source=spec.source,
            speeds=spec.speeds and {}or nil,castDelays={},blink=spec.blink,toPoint=spec.toPoint,lethalOnly=spec.lethalOnly}
        for i,v in ipairs(spec.speeds or {})do provider.speeds[i]=v end
        for i,v in ipairs(spec.castDelays)do provider.castDelays[i]=v end
        local owner='evade_dash'
        function provider:Active()
            if root then return listed(root,provider)and root:Active()end
            return C.mobility==provider and sdk.ChampionMobility==provider and g.myHero==h and C:Active()
        end
        function provider:CanDash(target)
            -- target=nil: direction-independent readiness only.
            if not provider:Active()or not C:Available()then return false,'controller_inactive'end
            if target~=nil and(type(target)~='table'or not finite(target.x)or not finite(target.z))then return false,'invalid_point'end
            local s=h:GetSpellData(spec.slot)
            if not s or s.name~=spec.name or (s.level or 0)<1 then return false,'spell_unavailable'end
            if g.Game.CanUseSpell(spec.slot)~=0 or (s.currentCd or 0)>0 then return false,'spell_not_ready'end
            if type(s.mana)=='number'and s.mana>h.mana then return false,'insufficient_mana'end
            local q=C.pending[spec.key]
            if q and q.owner~=owner and q.sentAt then return false,'slot_input_in_flight'end
            if spec.allowed then
                local ok,yes,why=pcall(spec.allowed,target)
                if not ok then return false,'champion_policy_error'end
                if not yes then return false,why or 'champion_policy'end
            end
            return true
        end
        function provider:Dash(target,options)
            if type(target)~='table'then return nil,'invalid_point'end
            local yes,why=provider:CanDash(target);if not yes then return nil,why end
            options=options or {}
            local resolveFn,validateFn=options.resolve,options.validate
            local now=A:Now();local ttl=math.max(1,math.min(250,(options.expires or now+100)-now))
            -- spec.aim(landing): the cast point for a landing, for a kit whose dash does not go
            -- to the cursor (a recoil away from the aim). The consumer only ever names landings.
            local function castPoint(landing)
                if not spec.aim then return landing end
                local ok,point=pcall(spec.aim,landing)
                return ok and type(point)=='table'and finite(point.x)and finite(point.z)and point or nil
            end
            local first=castPoint(target);if not first then return nil,'champion_policy'end
            local function check(resolved)
                local position=resolved and(resolved.landing or resolved.position)or target
                local ok,reason=provider:CanDash(position);if not ok then return false,reason end
                if validateFn then return validateFn(resolved)end
                return true
            end
            -- Detach any decision-local context: this is an independent background action.
            local savedContext,savedDecision=C.executionContext,C.decision
            C.executionContext,C.decision=nil,nil
            local ok,accepted,id=pcall(C.Cast,C,spec.key,{x=first.x,y=first.y or target.y or h.pos.y,z=first.z},{owner=owner,priority='critical',ttl=ttl,
                independent=false,prevalidateWorldCast=true,commitGuard=options.commitGuard,
                resolve=function()
                    local r,reason
                    if resolveFn then r,reason=resolveFn();if not r then return nil,reason or 'consumer_declined'end end
                    local position=r and r.position or target
                    local can,blocked=provider:CanDash(position);if not can then return nil,blocked end
                    local cast=castPoint(position);if not cast then return nil,'champion_policy'end
                    return {position=cast,landing=position}
                end,
                validate=function(_,resolved)return check(resolved)end})
            C.executionContext,C.decision=savedContext,savedDecision
            if not ok then return nil,'controller_error'end
            if not accepted then return nil,C.diagnostics.lastReject or 'controller_declined'end
            local handle={}
            function handle:Poll(request)if request==id then return A:Poll(id)end end
            function handle:Finish()return false,'controller_owner_observes_and_acknowledges'end
            function handle:Cancel(request,reason)if request==id then return A:Cancel(id,reason)end end
            return id,'requested',handle
        end
        function provider:Cancel(reason)C:Cancel(owner,reason or 'consumer_cancelled')end
        -- One provider slot: a champion with a point dash and a unit dash
        -- declares the second as spec.unit; it is published as provider.unit.
        if spec.unit~=nil then
            if type(spec.unit)~='table'or spec.unit.kind~='unitDash'then return false,'invalid_mobility_spec'end
            if spec.unit.slot==spec.slot then return false,'mobility_slot_offered'end
            local ok,why=self:RegisterUntargetable(spec.unit,provider);if not ok then return false,why end
        end
        if root then for _,offer in ipairs(mobilityOffers(provider))do
            for _,existing in ipairs(mobilityOffers(root))do if existing.slot==offer.slot then return false,'mobility_slot_offered'end end
        end end
        return attachMobility(self,provider,root)
    end
    -- SDK.ChampionMobility version 1, kind 'unitDash': a unit-targeted DASH (e.g.
    -- Irelia Q onto a minion). Same provider surface as 'untargetable' below
    -- (CanStrike/Targets/Strike) but no protection window: the consumer models a
    -- linear dash from the hero to each declared landing at every declared
    -- speed x cast delay and hit-tests the travel. Spec: slot,key,name,range,
    -- speeds,castDelays,targets(request),allowed(unit,request),source and
    -- optional refunds=true (the cooldown can return without being observed
    -- unavailable). A candidate is {unit,id,position,landings={points},free?,speeds?}:
    -- `landings` are all places the dash may end, `free` marks a cast the
    -- controller expects to be refunded, `speeds` overrides the declared bracket.
    -- SDK.ChampionMobility version 1, kind 'untargetable': a unit-targeted cast
    -- (e.g. Master Yi Alpha Strike) that makes the hero untargetable for a
    -- declared window and lands near a struck unit. The controller enumerates
    -- and orders eligible units (its mode policy), owns turret/consent/readiness
    -- policy and submits an object cast through its own ActionClient. The
    -- consumer (Evade) only evaluates threat safety and picks the first safe
    -- candidate in controller order. A request is not a landing or a dodge.
    function C:RegisterUntargetable(spec,parent,root)
        local h=g.myHero
        local function finite(v)return type(v)=='number'and v==v and v>-math.huge and v<math.huge end
        local dash=spec.kind=='unitDash'
        if type(spec.slot)~='number'or spec.key==nil or type(spec.name)~='string'or not finite(spec.range)or spec.range<=0
            or not dash and(not finite(spec.landingRange)or spec.landingRange<spec.range or not finite(spec.duration)or spec.duration<=0)
            or dash and(type(spec.speeds)~='table'or #spec.speeds==0)
            or type(spec.castDelays)~='table'or #spec.castDelays==0 or type(spec.targets)~='function'
            or type(spec.source)~='string'or spec.lethalOnly~=nil and(spec.lethalOnly~=true or not dash)then return false,'invalid_mobility_spec'end
        for _,v in ipairs(spec.castDelays)do if not finite(v)or v<0 or v>1 then return false,'invalid_mobility_spec'end end
        for _,v in ipairs(dash and spec.speeds or {})do if not finite(v)or v<=0 then return false,'invalid_mobility_spec'end end
        if not parent and sdk.ChampionMobility and sdk.ChampionMobility~=self.mobility and sdk.ChampionMobility.Active
            and sdk.ChampionMobility:Active()then return false,'mobility_owned_elsewhere'end
        local provider={version=1,kind=dash and 'unitDash'or 'untargetable',owner='AyyyyIOControllers',champion=h.charName,profile=spec.profile,
            slot=spec.slot,resource='slot:'..spec.slot,range=spec.range,landingRange=spec.landingRange,duration=spec.duration,
            label=spec.label,source=spec.source,castDelays={},speeds=dash and {}or nil,refunds=dash and spec.refunds==true or nil,
            lethalOnly=dash and spec.lethalOnly or nil}
        for i,v in ipairs(spec.castDelays)do provider.castDelays[i]=v end
        for i,v in ipairs(dash and spec.speeds or {})do provider.speeds[i]=v end
        local owner=dash and 'evade_dash'or 'evade_untargetable'
        local function identity(u)return u and (u.networkID or u.handle)end
        function provider:Active()
            if parent then return parent.unit==provider and parent:Active()end
            if root then return listed(root,provider)and root:Active()end
            return C.mobility==provider and sdk.ChampionMobility==provider and g.myHero==h and C:Active()
        end
        -- unit=nil: unit-independent readiness only. request={lethal=bool}.
        function provider:CanStrike(unit,request)
            if not provider:Active()or not C:Available()then return false,'controller_inactive'end
            local s=h:GetSpellData(spec.slot)
            if not s or s.name~=spec.name or (s.level or 0)<1 then return false,'spell_unavailable'end
            if g.Game.CanUseSpell(spec.slot)~=0 or (s.currentCd or 0)>0 then return false,'spell_not_ready'end
            if type(s.mana)=='number'and s.mana>h.mana then return false,'insufficient_mana'end
            local q=C.pending[spec.key]
            if q and q.owner~=owner and q.sentAt then return false,'slot_input_in_flight'end
            if unit~=nil then
                if not env.IsValid(unit)then return false,'target_invalid'end
                if env.GetDistance(unit.pos,h.pos)>spec.range then return false,'target_out_of_range'end
            end
            if spec.allowed then
                local ok,yes,why=pcall(spec.allowed,unit,request or {})
                if not ok then return false,'champion_policy_error'end
                if not yes then return false,why or 'champion_policy'end
            end
            return true
        end
        -- Ordered candidates: {unit,id,position,landings={points}}. Bounded by the controller.
        function provider:Targets(request)
            local ready,why=provider:CanStrike(nil,request);if not ready then return {},why end
            local ok,list=pcall(spec.targets,request or {})
            if not ok or type(list)~='table'then return {},'champion_policy_error'end
            local out={}
            for i=1,math.min(#list,8)do local c=list[i]
                if type(c)=='table'and c.unit and identity(c.unit)and type(c.landings)=='table'and #c.landings>0 then out[#out+1]=c end
            end
            return out
        end
        function provider:Strike(unit,options)
            options=options or {}
            local request={lethal=options.lethal==true}
            local yes,why=provider:CanStrike(unit,request);if not yes then return nil,why end
            local id0,handle0=identity(unit),unit.handle;local validateFn=options.validate
            local now=A:Now();local ttl=math.max(1,math.min(250,(options.expires or now+100)-now))
            local savedContext,savedDecision=C.executionContext,C.decision
            C.executionContext,C.decision=nil,nil
            -- options.ready: the consumer's decide-ahead gate (waits; never sends by itself).
            local ok,accepted,id=pcall(C.Cast,C,spec.key,unit,{owner=owner,priority='critical',ttl=ttl,independent=false,intentTarget=unit,
                ready=type(options.ready)=='function'and options.ready or nil,
                validate=function()
                    if identity(unit)~=id0 or unit.handle~=handle0 then return false,'target_changed'end
                    local can,blocked=provider:CanStrike(unit,request);if not can then return false,blocked end
                    if validateFn then return validateFn()end
                    return true
                end})
            C.executionContext,C.decision=savedContext,savedDecision
            if not ok then return nil,'controller_error'end
            if not accepted then return nil,C.diagnostics.lastReject or 'controller_declined'end
            local handle={}
            function handle:Poll(request)if request==id then return A:Poll(id)end end
            function handle:Finish()return false,'controller_owner_observes_and_acknowledges'end
            function handle:Cancel(request,reason)if request==id then return A:Cancel(id,reason)end end
            return id,'requested',handle
        end
        function provider:Cancel(reason)C:Cancel(owner,reason or 'consumer_cancelled')end
        if parent then parent.unit=provider;return true,provider end
        return attachMobility(self,provider,root)
    end
    function C:RegisterPolicy(policy)
        self.policy=policy
        if policy.channel then A:Condition('champion','channel',function(q)return self:Fresh(policy.channel,self.champion,q)end,policy.exceptions)end
    end
    -- The policy every class-style champion declares: the six mode methods
    -- (farming contexts gated on the spell-farm toggle), no casts over an own
    -- channel, and Q/W/E/R requests revalidated by champion:Ready(slot).
    -- `champion` is the class table. `extra` adds methods and sets or replaces
    -- any other field (damageTypes, costPaid, exceptions, killBonus, channel,
    -- validate); channel=false registers no channel gate.
    function C:StandardPolicy(champion,extra)
        local function farming()return self:SpellFarmEnabled()end
        local policy={methods={
            Combo=function()return self:ModeContext('Combo')end,Harass=function()return self:ModeContext('Harass')end,
            LaneClear=function()return self:FarmContext('lane',farming)end,JungleClear=function()return self:FarmContext('jungle',farming)end,
            LastHit=function()return self:ModeContext('LastHit')end,Flee=function()return self:ModeContext('Flee')end},
            channel=function()return not self:SelfChanneling()end,
            validate=function(object,q,slot)
                if type(slot)=='number'and slot>=0 and slot<=3 then return object:Ready(slot)end
                return true
            end}
        for key,value in pairs(extra or {})do
            if key=='methods'then for name,method in pairs(value)do policy.methods[name]=method end
            else policy[key]=value end
        end
        assert(extra and extra.validate or type(champion)=='table'and type(champion.Ready)=='function','StandardPolicy needs champion:Ready(slot) or its own validate')
        self:RegisterPolicy(policy);return policy
    end
    function C:RecentlyObserved(resource,spell,now)
        local observed=self.observedSlots and self.observedSlots[resource]
        if not observed or now-observed>=300 or not spell or(spell.currentCd or 0)>0 or(spell.ammo or 0)>0 then return false end
        local stage=self.observedSlotStages and self.observedSlotStages[resource]
        if stage and stage.at==observed then
            if type(stage.name)=='string'and stage.name~=''and type(spell.name)=='string'and spell.name~=''and stage.name~=spell.name then return false end
            if type(stage.toggle)=='number'and type(spell.toggleState)=='number'and stage.toggle~=spell.toggleState then return false end
        end
        return true
    end
    function C:ResourceObservation(id)
        if not id then return nil end
        -- These are spell evidence and gameplay continuations, never a second
        -- resource lease. Admission and replacement belong to the shared client.
        for _,q in pairs(self.pending)do if q.id==id then return q end end
    end
    function C:Cast(key,target,options)
        options=options or {};local binding=target and prediction.bindings[target]
        if options.type=='two_point' and (binding or options.resolve or options.prevalidateWorldCast or options.prevalidateWorldMove)then
            return false,'invalid_two_point_options'
        end
        local targetObject=options.intentTarget or target and target.pos and target or binding and binding.target
        local targetID=targetObject and (targetObject.networkID or targetObject.handle)
        self.lastIntent=nil
        -- An input attempt, sent or refused, ends the decision snapshot: what the
        -- next query reads must be fresh (classic_controller_optimization_spec).
        if self.evaluation then self.core:Invalidate()end
        if not self:Available() then return false end
        if options.type~='attack' and self:LastHitSpellBlocked(options.context,targetObject) then return false,'spell_farming_disabled' end
        local slot=options.slot or slots[key];if options.slot then slots[key]=options.slot end
        local logicalSlot=logicalSlots[key]
        if slot~=nil then
            if logicalSlot~=nil and A:NativeSpellSlot(logicalSlot)~=slot then return false,'native_slot_identity_changed'end
            if logicalSlot==nil then
                for candidate=0,12 do if A:NativeSpellSlot(candidate)==slot then logicalSlot=candidate;break end end
                if logicalSlot==nil then return false,'native_slot_unknown'end
                logicalSlots[key]=logicalSlot
            end
        end
        local resource=options.type=='attack'and 'attack' or logicalSlot~=nil and A:SlotResource(logicalSlot) or 'key:'..key
        local previousID=A:ResourceAction(resource,false)
        local previousObservation=self:ResourceObservation(previousID)
        local kind=not target and 'none' or target.pos and 'object' or target.z~=nil and 'world' or 'screen'
        local minimapWorld=options.world
        if minimapWorld then
            local function finite(n)return type(n)=='number'and n==n and n>-math.huge and n<math.huge end
            if kind~='screen' or binding or options.resolve or options.prevalidateWorldCast or options.type=='two_point'
                or not finite(minimapWorld.x)or not finite(minimapWorld.z)
                or minimapWorld.y~=nil and not finite(minimapWorld.y)then return false,'invalid_minimap_cast'end
            minimapWorld={x=minimapWorld.x,y=minimapWorld.y or 0,z=minimapWorld.z}
        end
        local mode=env.GetMode and env.GetMode();local decision=self.decision
        local owner=options.owner or (decision and decision.name or 'activator')
        local declaration=self.policy and self.policy.methods[owner]
        local context=self.executionContext or (declaration and declaration(self.champion)) or options.context
        if options.context then context=options.context end
        local combat=context and context.combat==true
        local now=A:Now();local spell=slot and g.myHero:GetSpellData(slot)
        -- Live 2026-10-03 (Vayne E): the host shows the cooldown a few frames after
        -- an observed cast, so the same spell was requested again immediately.
        -- Ammo spells (charges) are exempt; a visible cooldown ends the gate early.
        if options.type~='attack'and self:RecentlyObserved(resource,spell,now)then
            return false,'recently_observed'
        end
        local stamp=self:Stamp(key)
        local waiting=self.pending[key]
        local reusable=waitingIntentReuse and options.waitingKey and type(options.resolve)=='function'and not binding and kind=='world'
            and not options.type and not options.keys and not options.group and not options.reservation
            and not options.dependency and not options.handoff and not options.ready and not options.endPosition
            and not options.channelName and not options.cancelChannel and not options.world
            and not options.exceptions and not options.equivalence and not options.replace
            and not options.survivePointerMotion and options.independent==nil and not(context and context.held)
        if reusable and waiting and waiting.waitingKey==options.waitingKey and waiting.object==targetObject
            and waiting.owner==owner and waiting.stamp==stamp and waiting.range==options.range
            and waiting.targetID==targetID and waiting.targetHandle==(targetObject and targetObject.handle)
            and waiting.mode==(context and context.mode)
            and waiting.deferAttackWindup==options.deferAttackWindup
            and waiting.prevalidateWorldCast==options.prevalidateWorldCast then
            local id=A:ReuseWaiting({key=key,resource=resource,owner=owner,type='cast',waitingKey=options.waitingKey,
                targetID=targetID,stamp=stamp,context=context,priority=options.priority or(context and context.priority or'normal'),
                expires=now+(options.ttl or 250)})
            if id and id==waiting.id and previousID==id then
                self.metrics.requested=self.metrics.requested+1;self.lastIntent=waiting;return true,id
            end
        end
        local q={key=key,resource=resource,keys=options.keys or {key},type=options.type,kind=kind,target=kind=='world' and point(target) or target,
            targetID=targetID,targetHandle=targetObject and targetObject.handle,object=targetObject,owner=owner,mode=context and context.mode or nil,context=context,exceptions=options.exceptions,
            replace=options.replace or 'higher_priority',equivalence=options.equivalence,
            group=options.group,reservation=options.reservation,dependency=options.dependency,dependencyState=options.dependencyState,
            survivePointerMotion=options.survivePointerMotion,
            independent=options.independent~=false and combat and kind~='screen',
            priority=options.priority or (context and context.priority or 'normal'),expires=now+(options.ttl or 250),
            callbacks={},stamp=stamp,spellName=spell and spell.name,logicalSlot=logicalSlot,waitingKey=reusable and options.waitingKey or nil,
            deferAttackWindup=options.deferAttackWindup,
            toggleState=spell and spell.toggleState,ammo=spell and spell.ammo,cooldown=spell and spell.currentCd,requestGameTime=g.Game.Timer(),previousCastStart=g.myHero.activeSpell and g.myHero.activeSpell.startTime,requestedAt=now,range=options.range or binding and binding.settings.Range,objectRange=options.objectRange,itemID=logicalSlot and logicalSlot>=6 and (g.myHero:GetItemData(logicalSlot)or{}).itemID}
        q.observe=options.observe
        q.prediction=binding
        q.world=minimapWorld
        -- Opt-in: wait (within an extended deadline) for an observed own attack
        -- windup to finish instead of cancelling it with this cast.
        if options.deferAttackWindup and q.type~='attack' then
            local remaining=self:AttackWindupRemaining()
            if remaining>0 then q.expires=q.expires+math.floor(remaining*1000+.5) end
            q.ready=function()return self:AttackWindupRemaining()<=0 end
        end
        -- Caller wait gate (e.g. a scheduled defensive send): false waits until expiry.
        if type(options.ready)=='function'then
            local prior,gate=q.ready,options.ready
            q.ready=function()
                if prior and not prior()then return false end
                local ok,yes=pcall(gate);return ok and yes==true
            end
        end
        q.start=function()return self:Available()end
        q.continue=function()return not q.cancelled and self:InputAvailable() and A:ContextValid(q,'continuation') end
        local menuReads={};for node,value in pairs(decision and decision.menuReads or {})do menuReads[node]=value end
        local validate=modules.policies(self,q,slot,options)
        q.reconcile=function()
            local cast=g.myHero.activeSpell
            if q.type=='attack'then
                return not g.myHero.dead and not sdk.Attack:IsActive()and sdk.Orbwalker:CanAttack()
                    and not(cast and cast.valid)
            end
            return not g.myHero.dead and slot~=nil and g.Game.CanUseSpell(slot)==0
                and g.myHero:GetSpellData(slot).currentCd==0 and not (cast and cast.valid and not cast.isAutoAttack)
        end
        q.mechanical=function(resolved)
            if not q.continue() or not A:ContextValid(q) then return false,'context_changed' end
            if self:Stamp(key)~=q.stamp then return false,'spell_state_changed' end
            if slot then
                local current=g.myHero:GetSpellData(slot)
                if g.Game.CanUseSpell(slot)~=0 or not current or current.level==0 then return false,'spell_unavailable' end
                local paid=self.policy and self.policy.costPaid and self.policy.costPaid(self.champion,q,slot)
                if not paid and type(current.mana)=='number' and current.mana>g.myHero.mana then return false,'insufficient_mana' end
            end
            if q.itemID and (g.myHero:GetItemData(q.logicalSlot)or{}).itemID~=q.itemID then return false,'item_changed' end
            if targetObject and (not(kind=='world'and binding and self:PredictionTargetCurrent(targetObject,binding)or env.IsValid(targetObject)) or (targetObject.networkID or targetObject.handle)~=targetID) then return false,'target_invalid' end
            if q.range and q.target then
                local p=resolved and resolved.position or q.world or (q.kind=='object' and q.target.pos or q.target)
                if not p or env.GetDistance(p,g.myHero.pos)>q.range then return false,'target_out_of_range' end
            end
            for node,value in pairs(menuReads)do if node:Value()~=value then return false,'settings_changed'end end
            if binding and resolved then
                local valid,reason=prediction:Validate(binding,resolved)
                if not valid then return false,reason end
            end
            return validate(resolved)
        end
        local mechanical=q.mechanical;q.mechanical=function(resolved)
            local valid,reason=self:Fresh(mechanical,resolved)
            if valid and not q.sentAt then
                local cast=g.myHero.activeSpell
                q.dispatchCastStart=cast and cast.startTime;q.dispatchGameTime=g.Game.Timer()
            end
            q.lastValidationReason=not valid and (reason or 'champion_condition_changed') or nil
            return valid,reason
        end
        if options.resolve and kind=='world' then q.resolve=options.resolve end
        if binding then
            q.resolve=function()
                if not q.continue() or not self:PredictionTargetCurrent(targetObject,binding) then return nil,'intent_ended' end
                return prediction:Resolve(binding)
            end
        end
        if options.prevalidateWorldCast and (binding or type(options.resolve)=='function') and kind=='world' and A:Capabilities().prevalidateWorldCast then
            q.prevalidateWorldCast=true
            -- Explicit ability-stage opt-in, never inferred from line shape.
            if binding and binding.settings.DirectionalCast then
                if A:Capabilities().directionalWorldCast then
                    q.directionalWorldCast=true;q.directionalAimError=binding.object.AimErrorWorld or 0
                elseif binding.object.IsOnScreen==false then return false,'directional_cast_unavailable'end
            end
            if not binding and options.directionalWorldCast then
                local capabilities=A:Capabilities();local margin=options.directionalAimError or 0
                if not capabilities.directionalWorldCast then return false,'directional_cast_unavailable'end
                if not finiteNumber(margin)or margin<0 or margin>(capabilities.directionalAimErrorMax or 0)then return false,'invalid_directional_aim_error'end
                q.directionalWorldCast=true;q.directionalAimError=margin
            end
            local guard=options.commitGuard
            -- Optional caller guard: cheap cancellation/context state only.
            q.commitGuard=function()
                if not q.continue()then return false,'intent_ended'end
                if guard then return guard()end
                return true
            end
        end
        if not q.start() then return false end
        self.metrics.requested=self.metrics.requested+1
        local id,reason,admittedReceipt
        if q.type=='two_point'then id,reason=A:CastTwoPoint(key,q.target,options.endPosition,q)
        else id,reason,admittedReceipt=A:Submit(q)end
        -- Deduplication supplies the detached receipt it just read. Nothing has
        -- dispatched or called the host between admission and this consumption.
        local initial=id and(admittedReceipt or A:Poll(id))
        if not id then self.metrics.rejected=self.metrics.rejected+1;self.diagnostics.lastReject=reason;return false end
        if initial and initial.state=='cancelled_before_send' then
            self.metrics.rejected=self.metrics.rejected+1;self.diagnostics.lastReject=initial.reason or initial.state
            A:Finish(id)
            return false
        end
        if reason=='deduplicated' then
            local previous=previousObservation
            if not previous or previous.id~=id then
                self.diagnostics.lastReject='deduplicated_outside_controller_ownership'
                return false,self.diagnostics.lastReject
            end
            self.lastIntent=previous
            return true,id
        end
        local prior=previousObservation
        if prior and prior.id~=id then
            prior.cancelled=true;prior.callbacks={};self.pending[prior.key]=nil
            local previous=A:Poll(prior.id)
            prior.outcome=(prior.sentAt or previous and previous.sentAt) and 'unobserved_handoff' or 'replaced_before_send'
            self:FinishIntent(prior,previous)
        end
        q.id=id;self.pending[key]=q;self.lastIntent=q
        return true,id
    end
    local attackKey='__owned_attack'
    function C:CastTwoPoint(key,startPosition,endPosition,options)
        if not A:Capabilities().twoPointWorldCast then return false,'two_point_cast_unavailable'end
        local opts={};for k,v in pairs(options or {})do opts[k]=v end
        opts.type='two_point';opts.endPosition=endPosition;opts.independent=false
        return self:Cast(key,startPosition,opts)
    end
    function C:Attack(target,options)
        options=options or {}
        if not target or type(options.observe)~='function'or type(options.validate)~='function'then
            return false,'attack_observer_and_validator_required'
        end
        local opts={};for k,v in pairs(options)do opts[k]=v end
        opts.type='attack';opts.keys={};opts.slot=nil;opts.independent=false;opts.intentTarget=target
        local validate=options.validate
        opts.validate=function(q,resolved)
            local walker=sdk.Orbwalker
            if A:IsBlocked('attack')or walker.AttackEnabled==false
                or walker.Menu and walker.Menu.AttackEnabled and not walker.Menu.AttackEnabled:Value()then
                return false,'attack_blocked'
            end
            if not walker:CanAttack()or not sdk.Data:IsInAutoAttackRange(g.myHero,target)then
                return false,'attack_not_ready_or_in_range'
            end
            return validate(q,resolved)
        end
        return self:Cast(attackKey,target,opts)
    end
    function C:AfterAttack(fn)return self:AfterCast(attackKey,fn)end
    function C:RunDecision(name,fn)
        local old=self.decision;local previousContext=self.executionContext
        local declaration=self.policy and self.policy.methods[name]
        if not self.executionContext and declaration then self.executionContext=declaration(self.champion) end
        self.decision={name=name,menuReads={}}
        local ok,result=pcall(fn);self.decision=old;self.executionContext=previousContext;if not ok then error(result,0)end;return result
    end
    function C:Delayed(key,delay,fn)
        self.delayed=self.delayed or {};if self.delayed[key] then return end
        self.delayed[key]=true
        env.DelayAction(function()self.delayed[key]=nil;self:RunDecision(key,fn)end,delay)
    end
    function C:AfterCast(key,fn)
        local q=self.lastIntent
        if q and q.key==key and self.pending[key]==q then q.callbacks[#q.callbacks+1]=fn end
    end
    -- Gameplay observation survives acknowledgement of an input receipt. The
    -- original Core intent still supplies ownership/context; the caller supplies
    -- its bounded game-time continuation deadline, separate from client ms.
    function C:ContinuationState(intent,expires)
        if not self:Current()or type(intent)~='table'or not intent.id or not finiteNumber(expires)
            or g.Game.Timer()>expires or intent.cancelled or type(intent.continue)~='function'or not intent.continue()then
            return nil,'continuation_context_ended'
        end
        if finiteNumber(intent.observedAt)then return 'observed'end
        local receipt=A:Poll(intent.id)
        if not receipt or receipt.jobCancelled or receipt.state=='cancelled_before_send'or receipt.state=='send_uncertain'then
            return nil,receipt and receipt.state or 'receipt_unavailable'
        end
        return 'waiting'
    end
    -- Shared attribution for default and champion-specific observers. A send
    -- timestamp is only a boundary; the current native spell remains evidence.
    local function nativeAction(self,q,at)
        if not self:Current()or not q or not finiteNumber(q.sentAt)or not finiteNumber(q.observationGameTime)
            or not finiteNumber(q.requestGameTime)then return nil end
        local cast=g.myHero.activeSpell;at=at or g.Game.Timer()
        if not cast or not cast.valid or cast.isStopped
            or not finiteNumber(cast.startTime)or not finiteNumber(at)
            or cast.startTime<q.observationGameTime or cast.startTime<q.requestGameTime or cast.startTime>at
            or cast.startTime==q.previousCastStart or cast.startTime==q.dispatchCastStart then return nil end
        return cast
    end
    function C:NativeCast(q,name,at)
        local cast=nativeAction(self,q,at)
        return cast and not cast.isAutoAttack and cast.name==(name or q.spellName)and cast or nil
    end
    -- The sent slot's own cooldown started (or a charge was spent) while it still
    -- shows the requested stage. Evidence of the cast for abilities whose native
    -- cast the host does not show; a stage or form change is the caller's to read.
    function C:CooldownStarted(q)
        local slot=q and finiteNumber(q.sentAt)and slots[q.key];local d=slot and g.myHero:GetSpellData(slot)
        return d and d.name==q.spellName and(type(d.currentCd)=='number'and d.currentCd>(q.cooldown or 0)
            or type(d.ammo)=='number'and type(q.ammo)=='number'and d.ammo<q.ammo)or false
    end
    function C:NativeAttack(q,name,at)
        if not q or q.type~='attack'then return nil end
        local cast=nativeAction(self,q,at)
        -- A declared empowered-attack name is profile evidence even when the
        -- host's isAutoAttack flag and provider metadata omit that attack.
        return cast and (name and cast.name==name or not name and self:IsAttackCast(cast))and cast or nil
    end
    function C:Observe()
        -- Observe runs from two Tick bindings. Spell states at one game time
        -- cannot differ (input is applied by the game later): sample them once.
        local now=g.Game.Timer()
        if self.spellStatesAt~=now then
            self.spellStatesAt=now
            for slot=0,3 do
                local d=g.myHero:GetSpellData(slot);local old=self.spellStates[slot]
                if d then
                    if old and (d.currentCd>(old.cd or 0) or d.name~=old.name or d.toggleState~=old.toggle) then self.observedSpells[slot]=now end
                    self.spellStates[slot]={cd=d.currentCd,name=d.name,toggle=d.toggleState}
                end
            end
        end
        for key,q in pairs(self.pending)do
            local r=A:Poll(q.id)
            if not r or r.state=='cancelled_before_send' then self.pending[key]=nil;self.metrics.rejected=self.metrics.rejected+1
            else
                if r.jobCancelled then q.cancelled=true;q.callbacks={} end
                if r.state=='send_uncertain' or r.interrupted or r.competitor then q.ambiguous=true end
                if r.sentAt and not q.sentAt then q.sentAt=r.sentAt;self.metrics.sent=self.metrics.sent+1 end
                if not r.sentAt and not q.continue() then A:Cancel(q.id,'mode_or_context_ended')
                elseif r.sentAt then
                    q.sentGameTime=r.sentGameTime
                    q.observationGameTime=nativeSendGameTime and r.sentGameTime or q.dispatchGameTime
                    if nativeSendGameTime and not finiteNumber(r.sentGameTime)then q.observationGameTime=nil end
                    q.observationClock=nativeSendGameTime and 'native_key_send'or 'final_validation_only'
                    local slot=slots[key];local d=slot and g.myHero:GetSpellData(slot)
                    local changed
                    if q.observe then changed=q.observe(q)
                    else
                        local started=self:NativeCast(q)~=nil
                        changed=started or d and (d.name~=q.spellName or d.toggleState~=q.toggleState or type(d.currentCd)=='number' and d.currentCd>(q.cooldown or 0)
                            or type(d.ammo)=='number' and type(q.ammo)=='number' and d.ammo<q.ammo)
                    end
                    local receipt=not q.observe and keyedMechanical and r.commandReceipt
                    if changed and (not q.ambiguous or receipt) then
                        local observedAt=A:Now()
                        local evidence={kind='mechanical',at=observedAt,source=q.type=='attack'and 'attack_observation'or 'spell_state_transition',unique=true}
                        if receipt then
                            evidence.attribution='command_key';evidence.key=receipt.key
                            evidence.generation=receipt.generation;evidence.session=receipt.session
                        end
                        local accepted,why=A:Observe(q.id,evidence)
                        q.observationReason=why
                        if accepted then
                            q.observedAt=observedAt;self.metrics.observed=self.metrics.observed+1
                            if q.type~='attack'and not((q.ammo or 0)>0)then
                                self.observedSlots=self.observedSlots or {};self.observedSlots[q.resource]=observedAt
                                self.observedSlotStages=self.observedSlotStages or {}
                                self.observedSlotStages[q.resource]={at=observedAt,name=q.spellName,toggle=q.toggleState}
                            end
                            for _,fn in ipairs(q.callbacks)do if self:Active() and q.continue() then fn(q) end end
                            self.pending[key]=nil
                        else q.ambiguous=true end
                    end
                    if self.pending[key] and not q.observedAt and A:Now()>q.expires+750 then
                        q.outcome='unobserved_handoff'
                        if A:Reconcile(q.id) then self.pending[key]=nil end
                    end
                end
            end
            if not self.pending[key] then self:FinishIntent(q,r) end
        end
    end
    function C:FinishIntent(q,r)
        local key=q.key
        if not q.sentAt and r and r.sentAt then q.sentAt=r.sentAt;self.metrics.sent=self.metrics.sent+1 end
        q.outcome=q.outcome or (q.observedAt and 'mechanically_observed' or not q.sentAt and 'rejected_before_send' or 'unobserved')
        A:Finish(q.id)
        self.history[#self.history+1]={id=q.id,owner=q.owner,key=q.key,resource=q.resource,outcome=q.outcome,sentAt=q.sentAt,observedAt=q.observedAt}
        if #self.history>128 then table.remove(self.history,1)end
    end
    function C:Automation(name,on)
        if on and not self.claims[name] then self.claims[name]=A:Claim(name,true)==true
        elseif not on and self.claims[name] then A:Claim(name,false);self.claims[name]=nil end
        return on and self.claims[name]==true
    end
    function C:MaintainClaims() if env.CoreRefreshClaims then env.CoreRefreshClaims()end end
    function C:Chord(modifier,key) return self:Cast(key,nil,{keys={modifier,key},type='chord',independent=false}) end
    function C:HasObservedSpell() return g.myHero.activeSpell and g.myHero.activeSpell.valid and not g.myHero.activeSpell.isAutoAttack end
    -- Automatic ability levels for every champion (Utils "Level up abilities
    -- automatically"): the champion's standard order (CombatProfiles/skill_orders,
    -- dated guide sources) through the Utils skill-allocation executor. R at its
    -- listed levels, then each basic ability's first point in `first` order, then
    -- the `max` priority capped at ceil(level/2). A Classic kit uses its own row,
    -- or the Normal row only when that row says classicSameKit. One request at a
    -- time; an unconfirmed allocation is observed, never replayed.
    local leveling={nextAt=0}
    function C:SkillOrder()
        local rows=modules.skillOrders;local name=champion=='MonkeyKing'and'MonkeyKing'or champion
        local row=rows and rows[name];if not row then return nil end
        local classic=hero.charName:match('^Jade_')~=nil
        if classic then return row.classic or(row.normal and row.normal.classicSameKit and row.normal)or nil end
        return row.normal
    end
    function C:NextSkill()
        local order=self:SkillOrder();local data=hero.levelData
        if not order or type(data)~='table'or(data.lvlPts or 0)<=0 then return nil end
        local level=data.lvl or 1;local ranks={}
        for slot=0,3 do local d=hero:GetSpellData(slot);ranks[slot]=d and d.level or 0 end
        -- The audited source sequence first: the earliest level whose point the
        -- current ranks do not yet reflect (an innate R rank is not in it).
        local seq=type(order.seq)=='string'and order.seq or''
        if #seq>=level then
            local count={[0]=0,0,0,order.rInnate and 1 or 0};local letters={Q=0,W=1,E=2,R=3}
            for i=1,level do local slot=letters[seq:sub(i,i)]
                if slot then count[slot]=count[slot]+1;if ranks[slot]<count[slot]then return slot end end
            end
        end
        local rWanted=order.rInnate and 1 or 0;for _,at in ipairs(order.r or {6,11,16})do if level>=at then rWanted=rWanted+1 end end
        if ranks[3]<rWanted then return 3 end
        for _,slot in ipairs(order.first or {0,1,2})do if ranks[slot]==0 then return slot end end
        local top=order.maxRank or 5;local cap=math.min(top,math.ceil(level/2))
        for _,slot in ipairs(order.max or {0,1,2})do if ranks[slot]<cap then return slot end end
        for _,slot in ipairs(order.max or {0,1,2})do if ranks[slot]<top then return slot end end
        return nil
    end
    function C:AutoLevel()
        local utils=sdk.OrbamaUtils;local now=g.Game.Timer()
        if now<leveling.nextAt or not utils or not utils.Leveling or type(utils.Leveling.Request)~='function'then return end
        if leveling.pending then
            local p=leveling.pending;local d=hero:GetSpellData(p.slot)
            if d and(d.level or 0)>p.rank or now>=p.deadline then leveling.pending=nil;leveling.nextAt=now+(d and(d.level or 0)>p.rank and .3 or 2)end
            return
        end
        local slot=self:NextSkill();if slot==nil then return end
        local rank=hero:GetSpellData(slot).level or 0
        local ok,why=utils.Leveling:Request('AyyyyIO',slot,rank,function()return C:Active()and(hero:GetSpellData(slot).level or 0)==rank end)
        if ok then leveling.pending={slot=slot,rank=rank,deadline=now+.7};leveling.nextAt=now+.3
        else leveling.nextAt=now+(why=='waiting'and .3 or 1)end
    end
    C.core:Bind('Tick',function()
        if C:Active()then
            C:Observe();C:MaintainClaims();C:MaintainDefenses()
            for _,maintain in ipairs(C.placeMaintainers or {})do local ok,err=pcall(maintain);if not ok then C.diagnostics.placeError=tostring(err)end end
            C:MaintainAttackPreference();C:MaintainMovePreference();A:Tick()
            if champion~='LeeSin'and modules.skillOrders then local ok,err=pcall(C.AutoLevel,C);if not ok then C.diagnostics.levelError=tostring(err)end end
        end
    end)
    C.core:Bind('Load',function()C:Active()end)
    C.core:Bind('WndMsg',function(msg,key)
        if not C:Active() or msg~=256 then return end
        for k,q in pairs(C.pending)do
            if k==key and not A:IsSending() and not (sdk.Input and sdk.Input.LastInputEdge and sdk.Input.LastInputEdge.classification~='new manual press or unmatched echo') then
                local r=A:Poll(q.id)
                if r and r.sentAt then q.ambiguous=true else A:Cancel(q.id,'manual_spell')end
            end
        end
    end)
    -- Combo damage on enemy health bars: fn(unit) -> damage of the abilities and
    -- attacks the champion can deliver now (mitigated), partial (true when it
    -- leaves out terms it cannot model). With it registered the display shows
    -- every visible enemy within 2500 (at most 5) and marks a kill when the
    -- damage reaches health plus shields; without it, the next attack only.
    -- A killable enemy also gets a small minimap mark, out to MAP_KILL_RANGE
    -- (rows beyond 2500 draw only that mark; re-rank 2026-10-10, PussyAIO).
    local MAP_KILL_RANGE=20000
    function C:RegisterComboDamage(fn)if type(fn)=='function'then self.comboDamage=fn end end
    local function comboRows()
        local rows={};local enemies=C:DecisionUnits('GetEnemyHeroes')
        local estimate=C.comboDamage or function(unit)
            if not sdk.Data:IsInAutoAttackRange(hero,unit)then return 0,true end
            return sdk.Damage:GetAutoAttackDamage(hero,unit,true),true
        end
        for i=1,math.min(#enemies,5)do local u=enemies[i]
            local distance=env.IsValid(u)and u.team~=hero.team and flatDistance(u.pos,hero.pos)
            if distance and distance<=MAP_KILL_RANGE then
                local ok,damage,partial=pcall(estimate,u)
                if ok and finiteNumber(damage)and damage>0 then
                    local shields=(finiteNumber(u.shieldAD)and u.shieldAD or 0)+(finiteNumber(u.shieldAP)and u.shieldAP or 0)
                        +(finiteNumber(u.allShield)and u.allShield or 0)
                    local killable=damage>=u.health+shields and not C:CannotDie(u,0)
                    if distance<=2500 or killable then rows[#rows+1]={unit=u,damage=damage,partial=partial,killable=killable,far=distance>2500 or nil}end
                end
            end
        end
        return rows
    end
    if C.overlayScope and modules.overlayClient then
        C.display=modules.overlayClient.new(g,'AyyyyIO.display',function()return C:Current()end,nil,nil,function()
            return comboRows()
        end,C.overlayScope)
        if C.display then C.core:RegisterService('display',C.display)end
    end
    C.env=env;return C
end

end
