return function(require)
-- Safeguard (W1) onto an allied unit offered to the defensive consumer (Evade)
-- through SDK.ChampionMobility version 1, kind 'unitDash'. Lee is its own factory
-- with its own Actions path, so this is the unit-dash provider surface of the
-- common controller core (Active/CanStrike/Targets/Strike/Cancel) on Lee's submit
-- path. Evade judges the danger and never presses W; Lee owns readiness, the W
-- reservation for jumps (insec, wardjump, held keys), the unit list and cleanup.
-- Only a profile with a sourced dash speed and cast time publishes (Normal: wiki
-- V26.12, cast time none, 1350 + movement speed); Classic publishes nothing until
-- its W speed is measured (dev trace lee.ward.completed: dashDistance / dashMs).
-- Ward-hop (an alternative unitDash offer): a ward placed at a point Evade finds
-- clear, then W onto it. Its start delay is the ward-to-W handoff, modeled as the
-- cast-delay bracket HOP_DELAYS: live placement-send to W-send 91-188 ms (LHO
-- r14/r64 logs, docs/LHO-R14-PLAYTEST.md, LHO-R64-LUA38-LIVE-20260920.md) plus
-- the W send to dash start; a conservative bound until ward_timing samples with
-- owner 'evade' settle it. Offered only for a lethal or hard-crowd-control
-- threat (request.lethal / request.severe), with a ward source, W1 ready and no
-- jump reservation (insec, wardjump, held Lee keys); Evade proves the landing
-- clear under both delays, so a threat that lands first gets no offer.
local U=require('leesin.util')
local E={};E.__index=E
local MAX=8
local HOP_DELAYS={.15,.35}
local HOP_DIRECTIONS=8
function E.new(c)
    local self=setmetatable({c=c},E)
    local profile=c.profile;local sdk=c.sdk
    if not U.finite(profile.wSpeed) or not U.finite(profile.wCastDelay) or not sdk then return self end
    local other=sdk.ChampionMobility
    if other and other.Active and other:Active() then return self end
    local hero=myHero
    local function speed() return profile.wSpeed+(U.finite(myHero.ms) and myHero.ms or 0) end
    local p={version=1,kind='unitDash',owner='LeeSin',champion=hero.charName,profile=profile.id,slot=1,resource='slot:1',
        range=profile.wRange,speeds={speed()},castDelays={profile.wCastDelay},
        source='League wiki Lee Sin, last changed V26.12, read 2026-10-10',label='Safeguard onto an ally, minion or ward'}
    function p:Active()
        return sdk.ChampionMobility==p and c.app~=nil and c.app.active==true and not c.retired and myHero==hero
            and c.config:get('enabled')==true
    end
    -- unit=nil: unit-independent readiness. W stays with an insec, a wardjump,
    -- a chase or a held Lee key; Evade cannot take it from them.
    function p:CanStrike(unit,request)
        if not p:Active() or c:blocked() then return false,'controller_inactive' end
        if c:stage(1)~=1 or not c:ready(1) then return false,'spell_not_ready' end
        if c.actions:pendingCast(1) then return false,'slot_input_in_flight' end
        if c.wards.pending or c.combat.insec or c.input:held('wardKey') or c.input:held('cursorKey') or c.input:held('allyKey') then
            return false,'w_reserved_for_jump'
        end
        if unit==nil then return true end
        if not c.wards:jumpable(unit) then return false,'target_invalid' end
        if c:underTurret(unit.pos) and not (request and request.lethal) then return false,'enemy_turret' end
        return true
    end
    function p:Targets(request)
        local ready,why=p:CanStrike(nil,request);if not ready then return {},why end
        local rows={};local seen={}
        local intent=request and U.position(request.intent) and request.intent or nil
        local function add(u)
            local id=U.id(u)
            if id and not seen[id] and c.wards:jumpable(u) and (not c:underTurret(u.pos) or request and request.lethal) then
                seen[id]=true
                rows[#rows+1]={unit=u,id=id,position=U.copy(u.pos),landings={U.copy(u.pos)},speeds={speed()},
                    score=intent and U.dist(u.pos,intent) or -U.dist(myHero.pos,u.pos)}
            end
        end
        for _,w in ipairs(c.wards:objects()) do add(w) end
        for _,a in ipairs(c.allies or {}) do add(a) end
        for _,m in ipairs(c.minions or {}) do if m.team==myHero.team then add(m) end end
        table.sort(rows,function(a,b)return a.score<b.score end)
        for i=#rows,MAX+1,-1 do rows[i]=nil end
        return rows
    end
    function p:Strike(unit,options)
        options=options or {}
        local request={lethal=options.lethal==true}
        local yes,why=p:CanStrike(unit,request);if not yes then return nil,why end
        local identity,handle=U.id(unit),unit.handle;local validate=options.validate
        local ok,event=c.spells:w(unit,'evade',true,nil,function()
            if U.id(unit)~=identity or unit.handle~=handle then return false,'target_changed' end
            local can,blocked=p:CanStrike(unit,request);if not can then return false,blocked end
            if validate then return validate() end
            return true
        end)
        if not ok or type(event)~='table' then return nil,type(event)=='string' and event or 'controller_declined' end
        local id=event.cursorID or event.id;local result={}
        function result:Poll(r)if r==id then return c.actions.inputAction and c.actions:inputAction(event.cursorID) or event end end
        function result:Finish()return false,'controller_owner_observes_and_acknowledges' end
        function result:Cancel(r,reason)if r==id then return c.actions:cancel('evade',reason) end end
        return id,'requested',result
    end
    function p:Cancel(reason)c.actions:cancel('evade',reason or 'consumer_cancelled')end
    local hop={version=1,kind='unitDash',owner='LeeSin',champion=hero.charName,profile=profile.id,slot=1,resource='slot:1',
        range=math.min(profile.wRange,c.config:get('wardRange')),speeds={speed()},castDelays=HOP_DELAYS,wardHop=true,
        source=p.source..'; ward handoff bracket from LHO live logs (see evade.lua)',label='Place a ward, then Safeguard onto it'}
    function hop:Active()return p:Active() end
    function hop:CanStrike(spot,request)
        local ready,why=p:CanStrike(nil,request);if not ready then return false,why end
        if not c.wards:slot() then return false,'no_ward_source' end
        if spot==nil then return true end
        if type(spot)~='table' or not spot.wardSpot or not U.position(spot.pos) then return false,'target_invalid' end
        if U.dist(myHero.pos,spot.pos)>c.wards:range() then return false,'out_of_ward_range' end
        if c.wards.terrain:wall(spot.pos)~=false then return false,'not_open_ground' end
        if c:underTurret(spot.pos) and not (request and request.lethal) then return false,'enemy_turret' end
        return true
    end
    -- Ward spots around Lee at placement reach, the intent direction first.
    function hop:Targets(request)
        local ready,why=hop:CanStrike(nil,request);if not ready then return {},why end
        if not (request and (request.lethal or request.severe)) then return {},'ward_kept_for_severe_threats' end
        local origin=myHero.pos;local reach=c.wards:placementRange()
        local intent=request and U.position(request.intent) and request.intent or nil
        local base=intent and U.dist(origin,intent)>5 and math.atan2(intent.z-origin.z,intent.x-origin.x) or 0
        local rows={}
        for i=0,HOP_DIRECTIONS-1 do
            local k=i==0 and 0 or (i%2==1 and (i+1)/2 or -i/2)
            local angle=base+k*2*math.pi/HOP_DIRECTIONS
            local spot={wardSpot=true,pos={x=origin.x+math.cos(angle)*reach,y=origin.y,z=origin.z+math.sin(angle)*reach}}
            if hop:CanStrike(spot,request) then
                rows[#rows+1]={unit=spot,id='ward:'..i,position=U.copy(spot.pos),landings={U.copy(spot.pos)},speeds={speed()}}
            end
        end
        return rows
    end
    function hop:Strike(spot,options)
        options=options or {}
        local request={lethal=options.lethal==true}
        local yes,why=hop:CanStrike(spot,request);if not yes then return nil,why end
        local validate=options.validate
        -- The placement follows Evade's prepared state; once the ward is out, the
        -- W follows on W legality alone (wards.lua), never wasting the ward.
        if not c.wards:start(spot.pos,'evade',true,nil,function()
            if validate then return validate() end;return true end) then
            return nil,c.wards.refused or 'ward_refused'
        end
        local event=c.wards.pending and c.wards.pending.event
        if type(event)~='table' then return nil,'ward_refused' end
        c:trace('lee_wardhop',{spot=U.copy(spot.pos),origin=U.copy(myHero.pos),lethal=request.lethal,request=event.id,delays=HOP_DELAYS},'hop',.5)
        local id=event.cursorID or event.id;local result={}
        function result:Poll(r)if r==id then return c.actions.inputAction and c.actions:inputAction(event.cursorID) or event end end
        function result:Finish()return false,'controller_owner_observes_and_acknowledges' end
        function result:Cancel(r,reason)if r==id and c.wards.pending and c.wards.pending.owner=='evade' and not c.wards:committed() then c.wards:cancel(reason or 'evade_cancelled') end end
        return id,'requested',result
    end
    function hop:Cancel(reason)
        if c.wards.pending and c.wards.pending.owner=='evade' and not c.wards:committed() then c.wards:cancel(reason or 'consumer_cancelled') end
    end
    p.alternatives={hop};self.hop=hop
    self.provider=p;sdk.ChampionMobility=p
    return self
end
function E:close()
    local p=self.provider;self.provider=nil
    if p and self.c.sdk.ChampionMobility==p then self.c.sdk.ChampionMobility=nil end
end
return E

end
