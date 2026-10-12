return function(require)
local U=require('kata.util')
local P={};P.__index=P
function P.new(c)return setmetatable({c=c},P)end
function P:safe(pos,target,escape)
    local c=self.c
    if not U.position(pos)then return false end
    if not c.config:get('turret')and c.state:turret(pos)then return false end
    if escape then return c.state:enemiesNear(pos,550)<=c.state:enemiesNear(c.hero.pos,550)end
    if c.state:interruptIncoming()then return false end
    if U.hp(c.hero)<c.config:get('minHP')then return false end
    if c:healthPrediction(c.hero,.45)<=0 then return false end
    return c.state:enemiesNear(pos,650)<=c.config:get('maxEnemies')
end
-- Classic Q mark: W, E, AA and R detonate an own mark. A Q that was requested
-- (pending) or observed toward this target and has not yet landed is worth
-- waiting for, bounded by its travel estimate.
function P:awaitingMark(target)
    local c=self.c
    if c.profile.id~='classic'or c.state:mark(target)then return false end
    local id=U.id(target);local now=Game.Timer()
    local q=c.state.qFlight
    if q and q.target==id and now<q.expires+.1 then return true end
    local p=c.actions:slotObservation(0)
    return p~=nil and p.a and U.id(p.a.target)==id and now-p.at<.9 or false
end
function P:target(range)
    local c=self.c;local ts=c.sdk.TargetSelector
    local selected=ts.GetSelectedTarget and ts:GetSelectedTarget()or ts.Selected
    if ts.MenuCheckSelected and not ts.MenuCheckSelected:Value()then selected=nil end
    if U.valid(selected)and selected.team~=c.hero.team and U.dist(c.hero.pos,selected.pos)<=range then return selected end
    if ts.GetTarget then local o=ts:GetTarget(range,c.sdk.DAMAGE_TYPE_MAGICAL);if U.valid(o)and not c.damage:protected(o)then return o end end
    local best,score
    for _,o in ipairs(c.enemies)do if U.valid(o)and U.dist(c.hero.pos,o.pos)<=range and not c.damage:protected(o)then
        local s=(o.health or 0)+U.dist(c.hero.pos,o.pos)*.2
        if not score or s<score then best,score=o,s end
    end end
    return best
end
-- ready(slot) overrides readiness (dispatch validation of a queued cast whose own slot is reserved).
function P:estimate(target,origin,exclude,ready)
    local c=self.c;local best={lethal=false,time=0,damage=0,parts={}}
    if not U.valid(target)or c.damage:protected(target)or c.damage:spellShield(target)then return best end
    -- Finite short horizons; no assumed takedown or dagger reset in any branch.
    local usable,aims,safeAt={},{},{}
    for slot=0,2 do usable[slot]=slot~=exclude and c.config:get('combo'..({'Q','W','E'})[slot+1])and(ready and ready(slot)or not ready and c:ready(slot))end
    usable.AA=exclude~='AA'
    for _,sequence in ipairs({{0,2,1,'AA'},{2,1,0,'AA'},{0,1,'AA'},{'AA',2,0,1}})do
        local pool=c.damage:pool(target,(target.health or 0)+10);local time=0
        local pos=origin;local used={}
        for _,slot in ipairs(sequence)do
            local range=slot==0 and c.profile.qRange or slot==2 and c.profile.eRange or slot==1 and c.profile.wRange or c:attackRange(target)
            local aim
            if usable[slot]then
                local at=time+.25;aim=aims[at]
                if not aim then aim=U.predict(target,at);aims[at]=aim end
            end
            local safe=true
            if aim and slot==2 and U.dist(pos,aim)<=range then
                local at=time+.25
                if safeAt[at]==nil then safeAt[at]=self:safe(aim,target)end
                safe=safeAt[at]
            end
            if aim and U.dist(pos,aim)<=range and safe then
                time=time+.25;pool.hp=pool.hp+(target.hpRegen or 0)*.25
                c.damage:apply(pool,c.damage:parts(slot,target,.25,pool));used[#used+1]=slot
                if slot==0 and c.profile.id=='classic'then pool.pendingMark=true end
                if slot==2 then pos=aim end
                if pool.hp<=0 then break end
            end
        end
        local result={lethal=pool.hp<=0,time=time,damage=math.max(0,target.health-pool.hp),parts=used}
        if result.lethal and(not best.lethal or result.time<best.time)or not best.lethal and result.damage>best.damage then best=result end
    end
    return best
end
-- Kills without a mode key: Q first (ranged), then W (self-centred, cannot misplace Katarina), then E, which
-- legal() keeps behind the dash limits (own health, enemy count, turret, incoming interrupt). damage:lethal counts
-- an own landed Q mark for W and E and refuses protected and spell-shielded targets.
function P:finisher()
    local c=self.c
    -- Shunpo-then-Q (Katarina-2): while the E is in flight nothing else is spent; once it is observed the Q
    -- follows within .5 s only if it still kills, otherwise nothing more is used.
    local follow=c.followQ
    if follow then
        local now=Game.Timer();local rec=follow.record
        if rec.observed and not follow.observedAt then follow.observedAt=now end
        if now>follow.expires or rec.finished and not rec.observed or follow.observedAt and now-follow.observedAt>.5 or not U.valid(follow.target)then
            c.followQ=nil
        elseif not follow.observedAt then return
        else
            local o=follow.target;local d=U.dist(c.hero.pos,o.pos)
            if c:ready(0)and d<=c.profile.qRange and c.damage:lethal(0,o,.25+d/c.profile.qSpeed)then
                local a={slot=0,target=o,owner='idle',lethal=true,followup=true};if c:legal(a)then return a end
            end
            return
        end
    end
    local q,w,e=c:ready(0),c.profile.id=='classic'and c:ready(1),c:ready(2)
    if not(q or w or e)then return end
    local gap
    for i=1,math.min(#c.enemies,8)do local o=c.enemies[i]
        if U.valid(o)then
            local d=U.dist(c.hero.pos,o.pos);local a
            if q and d<=c.profile.qRange and c.damage:lethal(0,o,.25+d/c.profile.qSpeed)then a={slot=0,target=o}
            elseif w and d<=c.profile.wRange and c.damage:lethal(1,o)then a={slot=1,target=o}
            elseif e and d<=c.profile.eRange and c.damage:lethal(2,o)then
                a={slot=2,target=o,anchor=o,combatTarget=o,pos=c.profile.id=='normal'and c:landing(o,o)or nil}
            end
            if a then a.owner='idle';a.lethal=true;if c:legal(a)then return a end end
            if e then a=self:daggerKill(o);if a then return a end end
            if not gap and q and e and d>c.profile.qRange and d<=c.profile.eRange+c.profile.qRange-50 then gap=self:gapQ(o)end
        end
    end
    return gap
end
-- Katarina-3: Shunpo onto an own landed dagger whose pickup slash (passive) kills the enemy.
function P:daggerKill(o)
    local c=self.c;local p=c.profile
    if p.id~='normal'or not next(c.state.daggers)then return end
    local kills
    for _,d in pairs(c.state.daggers)do
        if c.state:daggerValid(d)and U.dist(c.hero.pos,d.pos)<=p.eRange and U.dist(d.pos,o.pos)<=p.daggerRadius+p.daggerPickup then
            -- Land on the dagger itself: a point toward the enemy could put the cursor on the enemy instead.
            local landing=c:landing(d.object,nil,d.pos,d)
            if landing and U.dist(landing,U.predict(o,.2))<=p.daggerRadius then
                if kills==nil then kills=c.damage:lethalWith({'passive'},o,.3)end
                if not kills then return end
                local a={slot=2,target=o,anchor=d.object,dagger=d,pos=landing,side=U.copy(d.pos),combatTarget=o,owner='idle',lethal=true,
                    validate=function()return c.state:daggerValid(d)and c.damage:lethalWith({'passive'},o,.3),'dagger_kill_gone'end}
                if c:legal(a)then return a end
            end
        end
    end
end
-- Katarina-2: Shunpo to a unit (minion, monster, champion, own dagger; Classic also own ward) that brings an enemy
-- out of Q range inside it, when the Q then kills. The Q follows only after the E is observed (finisher above).
function P:gapQ(o)
    local c=self.c;local p=c.profile
    -- Classic Shunpo has no established cast time: a conservative .25 s.
    local eCast=p.mobility and p.mobility.castDelay or .25
    local at=eCast+.25+(p.qRange-50)/p.qSpeed
    if not c.damage:lethal(0,o,at)then return end
    local best,reach
    for _,anchor in ipairs(c:anchors())do
        if not U.same(anchor,o)then
            local dagger=c.state.daggers[U.id(anchor)]
            local landing=c:landing(anchor,o,nil,dagger)
            if landing then
                local r=U.dist(landing,U.predict(o,at))
                -- The farthest landing that still reaches is the safest one.
                if r<=p.qRange-50 and(not reach or r>reach)and c.mobility.terrain:wall(landing)==false and self:safe(landing,o)then
                    local a={slot=2,anchor=anchor,dagger=dagger,combatTarget=o,owner='idle',lethal=true,gapQ=o,
                        target=p.id=='classic'and anchor or o,pos=p.id=='normal'and landing or nil,
                        validate=function()return c.state:ready(0)and c.damage:lethal(0,o,at),'gap_q_no_longer_kills'end}
                    if c:legal(a)then best,reach=a,r end
                end
            end
        end
    end
    return best
end
-- owner differs from mode only for the poke while lane clearing ('laneharass'): Harass settings, Q and W only.
function P:combat(mode,owner)
    local c=self.c;owner=owner or mode
    if owner=='harass'and c.trade then
        local trade=c.trade
        if U.dist(c.hero.pos,trade.origin)<60 or Game.Timer()>trade.expires then c.trade=nil
        elseif Game.Timer()-trade.at>.55 or not U.valid(trade.target)then
            local a={kind='move',pos=trade.origin,owner='harass',validate=function()
                return c.mobility.terrain:walkLine(c.hero.pos,trade.origin,c.hero.boundingRadius or 35)==true
            end}
            if c:legal(a)then return a end
            c.trade=nil
        end
    end
    local target=self:target(c.profile.eRange+600)
    if not target then return end
    local d=U.dist(c.hero.pos,target.pos);local candidates={}
    local function add(a,score)
        a.owner=owner;a.target=a.target or target;a.score=score
        local legal,why=c:legal(a)
        if legal then
            local direct=a.slot~=2 or U.same(a.anchor,target)or c.profile.id=='normal'and a.pos and U.dist(a.pos,target.pos)<=150
            a.direct=direct
            local damage=direct and a.slot and a.slot<6 and c.damage:amount(a.slot,target,a.slot==3 and .5 or .25)or 0
            if a.rule then damage=c.items:damage(a.rule,target)end
            a.score=a.score+damage
            a.estimate=damage
            if direct and a.slot and a.slot<6 and c.damage:lethal(a.slot,target,a.slot==3 and .5 or .3)then a.score=a.score+2000;a.lethal=true end
            if a.rule and damage>0 and c.damage:apply(c.damage:pool(target,target.health+10),{magic=damage})<=0 then a.score=a.score+2000;a.lethal=true end
            -- Katarina-3: Shunpo onto a dagger whose pickup slash (plus the E itself when it strikes the target) kills.
            local p=c.profile
            if not a.lethal and a.slot==2 and a.dagger and a.pos and p.id=='normal'and U.dist(a.pos,a.dagger.pos)<=p.daggerPickup
                and U.dist(a.pos,U.predict(target,.2))<=p.daggerRadius and c.damage:lethalWith(direct and {2,'passive'}or {'passive'},target,.3)then
                a.score=a.score+2000;a.lethal=true
            end
            candidates[#candidates+1]=a
        elseif c.telemetry then c.telemetry:reject(a,why)
        end
    end
    if c:ready(0)and c.config:get(mode..'Q')and d<=c.profile.qRange then add({slot=0},60)end
    -- Classic order: Q first (mark), then W/E/AA detonate it. While a requested or
    -- flying Q has not marked the target, W/E wait unless they kill on their own.
    local waitMark=self:awaitingMark(target)
    local qFirst=c.profile.id=='classic'and c:ready(0)and c.config:get(mode..'Q')and d<=c.profile.qRange and not c.state:mark(target)
    if c:ready(1)and c.config:get(mode..'W')and d<=c.profile.wRange then
        if not waitMark or c.damage:lethal(1,target)then add({slot=1},(c.profile.id=='normal'and 180 or 100)-(qFirst and 200 or 0))end
    end
    if owner==mode and c:ready(2)and c.config:get(mode..'E')then
        local targetPos=U.predict(target,.2)
        for _,anchor in ipairs(c:anchors())do
            local pos=c:landing(anchor,target)
            if pos and U.dist(pos,targetPos)<=c.profile.wRange and self:safe(pos,target)then
                if mode~='harass'or c:hasReturn(pos,anchor)then
                    local extended=d>c.profile.wRange and 90 or -100
                    local dagger=c.state.daggers[U.id(anchor)]
                    local direct=U.same(anchor,target)
                    if not waitMark or direct and c.damage:lethal(2,target)then
                        add({slot=2,anchor=anchor,pos=c.profile.id=='normal'and pos or nil,target=c.profile.id=='classic'and anchor or target,
                            combatTarget=target,dagger=dagger},extended-(qFirst and 200 or 0)+(dagger and U.dist(pos,dagger.pos)<=c.profile.daggerPickup and c.damage:amount('passive',target)or 0))
                    end
                end
            end
        end
    end
    if mode=='combo'and c:ready(3)and c.config:get('comboR')and d<=c.profile.rActivation then
        local short=self:estimate(target,c.hero.pos,3)
        -- Death Lotus roots Katarina and is cancelled by her own casts: open with
        -- the ready Q/W/E burst in range and channel afterwards.
        local burst=c:ready(0)and c.config:get('comboQ')and d<=c.profile.qRange or c:ready(1)and c.config:get('comboW')and d<=c.profile.wRange
            or c:ready(2)and c.config:get('comboE')and d<=c.profile.eRange or waitMark
        if not short.lethal then add({slot=3},30+c.state:enemiesNear(c.hero.pos,450)*40-(burst and 400 or 0))end
    end
    if mode=='combo'then
        for slot=4,5 do if c:ready(slot)and U.summoner(c.state:spell(slot).name)=='summonerdot'and d<=600
            and not U.buff(target,{summonerdot=true},Game.Timer())and c.damage:lethal(slot,target,5)then add({slot=slot},10)end end
    end
    local item=c.items:activeCandidate(target,mode);if item then add(item,item.score or 0)end
    local best
    for _,a in ipairs(candidates)do if not best or a.score>best.score then best=a end end
    if c.state:channel()then
        if best and best.lethal and best.slot~=3 and not c.damage:lethal(3,target,.34)then best.release=true;return best end
        return mode=='combo'and self:sequenceRelease(target,candidates)or nil
    end
    if not best and mode=='combo'then
        if c.profile.id=='classic'and c.config:get('offensiveWards')and c:ready(2)and c.mobility:slot()and d>c.profile.eRange then
            local pos=U.toward(c.hero.pos,target.pos,math.min(580,d-150))
            local result=self:estimate(target,pos,2)
            if result.lethal and self:safe(pos,target)then return {kind='wardplan',owner='combo',pos=pos,target=target,lethal=true}end
        end
        if c.config:get('extended')and d>c.profile.eRange then
            local pos=U.toward(c.hero.pos,target.pos,math.min(375,d-100))
            if self:safe(pos,target)and self:estimate(target,pos).lethal then
                for slot=4,5 do if c:ready(slot)and U.summoner(c.state:spell(slot).name)=='summonerflash'then return {slot=slot,owner=mode,pos=pos,extended=true,target=target}end end
                for slot,x in pairs(c.items.inventory)do if x.rule and x.rule.active=='move'and c:ready(slot)and c.items:enabled(x.id)then
                    pos=U.toward(c.hero.pos,target.pos,x.rule.range)
                    if self:safe(pos,target)and self:estimate(target,pos).lethal then return {slot=slot,owner=mode,pos=pos,extended=true,rule=x.rule,itemID=x.id,target=target}end
                end end
            end
        end
    end
    if not best and owner==mode then best=self:pickup(mode,target)end
    return best
end
-- Katarina-7: leave Death Lotus for a short Q/W/E sequence that kills inside .6 s when the remaining daggers in
-- that window do not. Only the sequence's first cast is released; legal() re-runs this check at dispatch.
function P:sequenceRelease(target,candidates)
    local c=self.c
    local est=self:estimate(target,c.hero.pos,3)
    if not est.lethal or est.time>.6 or #est.parts<2 or c.damage:lethal(3,target,est.time+.1)then return end
    local first=est.parts[1];local pick
    for _,a in ipairs(candidates)do
        if a.slot==first and(a.slot~=2 or a.direct)and(not pick or a.score>pick.score)then pick=a end
    end
    if pick then pick.release=true;pick.sequence=true;pick.lethal=true end
    return pick
end
-- Katarina-1/4 (Normal): walk onto an own landed dagger whose pickup slash reaches the target (Combo/Harass: the
-- predicted target at arrival) or the wave/camp (clearing: >= clearHits lane minions or any monster). The walk
-- is an ordinary move intention: no movement or attack veto, and only while the attack is not ready (or, in
-- combat, the target is out of attack range). Clearing may Shunpo onto it instead (lane E off, jungle E on).
function P:pickup(mode,target)
    local c=self.c;local p=c.profile
    if p.id~='normal'or not next(c.state.daggers)then return end
    local clear=mode=='lane'or mode=='jungle'
    if not clear and not U.valid(target)then return end
    local orb=c.sdk.Orbwalker
    local canAttack=not orb.CanAttack or orb:CanAttack()
    local inRange=not clear and U.dist(c.hero.pos,target.pos)<=c:attackRange(target)
    local ms=math.max(1,c.hero.ms or 340)
    local best,score
    for _,d in pairs(c.state.daggers)do if c.state:daggerValid(d)then
        local dist=U.dist(c.hero.pos,d.pos)
        if dist<=p.eRange then
            local value=0
            if clear then
                local n,kills=0,0
                for i=1,math.min(#c.minions,128)do local o=c.minions[i]
                    if U.valid(o)and(mode=='jungle'and o.team==300 or mode=='lane'and o.team~=300 and o.team~=c.hero.team)and U.dist(o.pos,d.pos)<=p.daggerRadius then
                        n=n+1
                        if n<=8 then local hp=c:healthPrediction(o,dist/ms);if hp>0 and c.damage:amount('passive',o)>=hp then kills=kills+1 end end
                    end
                end
                if mode=='jungle'and n>=1 or mode=='lane'and n>=c.config:get('clearHits')then value=n+kills*2 end
            elseif U.dist(U.predict(target,dist/ms),d.pos)<=p.daggerRadius then value=1 end
            if value>0 then local s=value-dist*.001;if not score or s>score then best,score=d,s end end
        end
    end end
    if not best then return end
    local d=best;local dist=U.dist(c.hero.pos,d.pos)
    if dist<=360 and(not canAttack or not clear and not inRange)then
        if c.mobility.terrain:walkLine(c.hero.pos,d.pos,c.hero.boundingRadius or 35)==true and self:safe(d.pos,target)then
            return {kind='move',pos=U.copy(d.pos),owner=mode,pickup=true,target=target,validate=function()return c.state:daggerValid(d),'dagger_gone'end}
        end
    end
    if clear and c:spellFarm()and c:ready(2)and c.config:get(mode..'E')then
        local landing=c:landing(d.object,nil,d.pos,d)
        local a={slot=2,owner=mode,anchor=d.object,dagger=d,pos=landing,side=U.copy(d.pos),pickup=true,
            validate=function()return c.state:daggerValid(d),'dagger_gone'end}
        if landing and c:legal(a)then return a end
    end
end
-- Katarina-6/12: Bouncing Blades in a wave. Nearest next unit within qBounceRange that the chain has not hit
-- (Classic: also without an own mark), up to qBounces more, Classic losing qFalloff per bounce (linear, the
-- lower reading of "10% less each"). Scores forecast kills and, in Classic, marks that W can detonate.
function P:bounceValue(first,nearby,impact,cache)
    local c=self.c;local p=c.profile
    if not p.qBounces or #nearby<2 then return 0 end
    local hit={[first]=true};local at,from,value=impact,first,0
    for i=1,p.qBounces do
        local nextUnit,nd
        for _,o in ipairs(nearby)do
            if not hit[o]and U.valid(o)then local d=U.dist(from.pos,o.pos)
                if d<=p.qBounceRange and(not nd or d<nd)and(p.id~='classic'or not c.state:mark(o))then nextUnit,nd=o,d end
            end
        end
        if not nextUnit then break end
        hit[nextUnit]=true;at=at+nd/(p.qBounceSpeed or p.qSpeed);from=nextUnit
        local row=cache[nextUnit];if not row then row={damage=c.damage:amount(0,nextUnit)};cache[nextUnit]=row end
        local damage=row.damage*math.max(0,1-(p.qFalloff or 0)*i)
        local hp=c:healthPrediction(nextUnit,at)
        if hp>0 and damage>=hp then value=value+400
        elseif p.id=='classic'and U.dist(c.hero.pos,nextUnit.pos)<=p.wRange then value=value+20 end
    end
    return value
end
function P:farm(mode)
    local c=self.c;local usable={};local any=false
    for slot=0,2 do
        usable[slot]=c.config:get(mode..({'Q','W','E'})[slot+1])and c:ready(slot)
            and not(slot==1 and mode=='last'and c.profile.id=='normal')
        any=any or usable[slot]
    end
    if not any then return end
    local best,score;local nearby={};local hits=0;local cache={}
    for i=1,math.min(#c.minions,128)do local o=c.minions[i]
        if U.valid(o)and U.dist(c.hero.pos,o.pos)<=c.profile.eRange and(mode=='jungle'and o.team==300 or mode~='jungle'and o.team~=300 and o.team~=c.hero.team)then
            if #nearby<32 then nearby[#nearby+1]=o end
            if U.dist(c.hero.pos,o.pos)<=c.profile.wRange then hits=hits+1 end
        end
    end
    for _,o in ipairs(nearby)do
        local eligible=U.valid(o)and(mode=='jungle'and o.team==300 or mode~='jungle'and o.team~=c.hero.team and o.team~=300)
        if eligible and U.dist(c.hero.pos,o.pos)<c.profile.eRange then
            for slot=0,2 do if usable[slot]and not(slot==1 and(mode=='lane'or c.profile.id=='normal'and mode~='jungle')and hits<c.config:get('clearHits'))then
                local a={slot=slot,owner=mode,target=o,farm=true,anchor=slot==2 and o or nil}
                if c.profile.id=='normal'and slot==2 then a.pos=c:landing(o,o)end
                local impact=slot==0 and .25+U.dist(c.hero.pos,o.pos)/c.profile.qSpeed or slot==1 and c.profile.id=='normal'and 1.25 or .2
                local at,observedHP=Game.Timer(),o.health
                local hp=c:healthPrediction(o,impact)
                local damage=c.damage:amount(slot,o)
                local aaSaved=mode=='last'and hp>0 and damage>=hp and c:aaSaves(o,impact)or false
                local valid=hp>0 and(mode~='last'or damage>=hp and not aaSaved)
                -- Normal W only drops a dagger: a wave of clearHits, or (Katarina-5) any monster in reach that is
                -- still alive when the dagger lands 1.25 s later (impact above is that landing).
                if slot==1 and c.profile.id=='normal'then valid=mode~='last'and(hits>=c.config:get('clearHits')or mode=='jungle'and hp>0)end
                if slot==1 and mode=='lane'then valid=valid and hits>=c.config:get('clearHits')end
                local facts=valid and {target=o,impact=impact,hp=hp,damage=damage,aaSaved=aaSaved,at=at,observedHP=observedHP}
                if valid and c:legal(a,nil,facts)then
                    local s=(damage>=hp and 1000 or 0)+(slot==1 and hits*100 or 0)-(o.health or 0)*.01
                    if slot==0 and mode~='last'then s=s+self:bounceValue(o,nearby,impact,cache)end
                    if not score or s>score then best,score=a,s end
                end
            end end
        end
    end
    return best
end
return P

end
