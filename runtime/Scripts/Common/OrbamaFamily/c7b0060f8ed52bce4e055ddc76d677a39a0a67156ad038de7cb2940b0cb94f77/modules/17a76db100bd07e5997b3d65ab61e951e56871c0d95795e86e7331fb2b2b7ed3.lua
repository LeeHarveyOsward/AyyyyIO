return function(require)
local U=require('kata.util')
-- Shunpo offered to the defensive consumer (Evade) through SDK.ChampionMobility version 1. Katarina is its own
-- factory with its own ActionClient, so this is the unit-cast provider surface of the common controller core
-- (Active/CanStrike/Targets/Strike/Cancel) on this controller's submit path. Evade judges the danger and never
-- presses E; this side owns readiness, anchors, the landing, the dash policy and cleanup.
-- Shunpo is a BLINK: the provider says `blink=true` and declares no travel speed, because none exists. A consumer
-- that only models linear unit dashes refuses a provider without speeds, which is the safe outcome.
-- Only a profile with a verified range and cast time is published (profile.mobility); the Classic cast time is
-- not established, so Classic publishes nothing.
local E={};E.__index=E
function E.new(c)
    local self=setmetatable({c=c},E)
    local m=c.profile.mobility;local sdk=c.sdk;local landings={}
    if type(m)~='table'or not U.finite(m.range)or not U.finite(m.castDelay)or type(m.source)~='string'then return self end
    local other=sdk.ChampionMobility
    if other and other.Active and other:Active()then return self end
    local p={version=1,kind='unitDash',blink=true,owner='Katarina',champion=c.hero.charName,profile=c.profile.id,slot=2,
        resource=c.actions.client:SlotResource(2),range=m.range,castDelays={m.castDelay},source=m.source,label='Shunpo out of skillshots'}
    function p:Active()return p==sdk.ChampionMobility and c.active and c.sdk==SDK and c.hero==myHero and(not c.core or c.core:Current())end
    -- unit=nil: unit-independent readiness. An own channel is only given up when the hit would kill.
    function p:CanStrike(unit,request)
        if not p:Active()or not c:available()then return false,'controller_inactive'end
        if not c.state:ready(2)then return false,'spell_not_ready'end
        local id=c.actions.client:ResourceAction(p.resource,false)
        local own=id and c.actions.observations[id]
        if id and not(own and own.a.owner=='evade')then return false,'slot_input_in_flight'end
        if c.state:channel()and not(request and request.lethal)then return false,'own_channel'end
        if unit==nil then return true end
        if not c:anchorValid(unit)then return false,'target_invalid'end
        return true
    end
    function p:Targets(request)
        local ready,why=p:CanStrike(nil,request);if not ready then return {},why end
        local intent=request and U.position(request.intent)and request.intent or c:mouse()or c.hero.pos
        local rows={}
        for _,o in ipairs(c:anchors())do
            local dagger=c.state.daggers[U.id(o)];local at=dagger and dagger.pos or o.pos
            local landing=U.toward(at,intent,math.min(c.profile.eOffset-20,U.dist(at,intent)))
            -- Champion policy, not threat safety: never under an enemy turret, never into more enemies.
            if landing and c.mobility.terrain:wall(landing)==false and c.planner:safe(landing,nil,true)then
                rows[#rows+1]={unit=o,id=U.id(o),position=U.copy(at),landings={landing},score=U.dist(landing,intent)}
            end
        end
        table.sort(rows,function(a,b)return a.score<b.score end)
        -- The landing certified for a unit is the one Strike casts; nothing else is ever sent.
        landings={}
        for i=#rows,9,-1 do rows[i]=nil end
        for _,row in ipairs(rows)do landings[row.id]=row.landings[1]end
        return rows
    end
    function p:Strike(unit,options)
        options=options or {}
        local request={lethal=options.lethal==true}
        local yes,why=p:CanStrike(unit,request);if not yes then return nil,why end
        local id=U.id(unit);local landing=landings[id];if not landing then return nil,'landing_not_certified'end
        local now=c.actions.client:Now();local validate=options.validate
        local ok,record=c.actions:submit({slot=2,owner='evade',target=unit,anchor=unit,dagger=c.state.daggers[id],pos=landing,side=U.copy(landing),
            escape=true,release=request.lethal,priority='critical',ttl=math.max(1,math.min(250,(options.expires or now+100)-now)),
            validate=function()
                local can,blocked=p:CanStrike(unit,request);if not can then return false,blocked end
                if validate then return validate()end
                return true
            end})
        if not ok then return nil,record or 'controller_declined'end
        local request_id=record.id;local handle={}
        function handle:Poll(r)if r==request_id then return c.actions.client:Poll(request_id)end end
        function handle:Finish()return false,'controller_owner_observes_and_acknowledges'end
        function handle:Cancel(r,reason)if r==request_id then return c.actions.client:Cancel(request_id,reason)end end
        return request_id,'requested',handle
    end
    function p:Cancel(reason)c.actions:cancel('evade',reason or 'consumer_cancelled')end
    self.provider=p;sdk.ChampionMobility=p
    return self
end
function E:close()
    local p=self.provider;self.provider=nil
    if p and self.c.sdk.ChampionMobility==p then self.c.sdk.ChampionMobility=nil end
end
return E

end
