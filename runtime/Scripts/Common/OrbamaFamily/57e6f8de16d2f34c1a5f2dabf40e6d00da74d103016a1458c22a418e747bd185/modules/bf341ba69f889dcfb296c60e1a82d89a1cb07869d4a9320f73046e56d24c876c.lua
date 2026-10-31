return function(require)
-- At most five champion primaries and five kick directions. Flash stand points
-- only with the opt-in "Flash for multi-kicks" switch (Flash, then R).
local U=require('leesin.util')
local K={};K.__index=K
function K.new(ctx) return setmetatable({ctx=ctx},K) end
function K:predict(unit,delay)
    local now=self.ctx:now()
    if self.predictionAt~=now then self.predictionAt=now;self.predictions={} end
    -- Share equivalent arrival estimates across the bounded direction search.
    -- Never carry predictions into the next game tick.
    local bucket=math.floor(delay/.025+.5);local key=tostring(U.id(unit))..':'..bucket
    local cached=self.predictions[key]
    if cached then return cached.valid and cached.pos or nil end
    local predicted
    if unit.GetPrediction and unit.pathing and unit.pathing.hasMovePath then
        local ok,p=pcall(unit.GetPrediction,unit,math.huge,bucket*.025)
        if ok and p and type(p.x)=='number' and type(p.z)=='number' and p.x==p.x and p.z==p.z
            and math.abs(p.x)<100000 and math.abs(p.z)<100000 then predicted=U.copy(p) end
    else predicted=U.copy(unit.pos) end
    self.predictions[key]={valid=predicted~=nil,pos=predicted}
    return predicted
end
function K:evaluate(primary,origin,ward,flash)
    local c=self.ctx;local b=c.combat
    if not c:enemyValid(primary) or b:kickProtected(primary) then return end
    local delay=.25+(ward and b.tactics:wardArrival() or flash and .1 or 0)
    local start=self:predict(primary,delay)
    if not start or U.dist(origin,start)>c.profile.rRange or U.dist(origin,start)<25 then return end
    local endpoint=U.toward(origin,start,U.dist(origin,start)+c:kickLength(primary))
    local result={primary=primary,origin=U.copy(origin),endpoint=endpoint,hits=1,kills=0,secondaryKills=0,
        damage=0,ward=ward,flash=flash or nil,hitIDs={[U.id(primary)]=true},impactDelay=delay}
    local damage=c:combatDamage(3,primary)
    local margin=c.config:get('combatDamageMargin')
    local lock=c:locked()
    local function add(unit,value,secondary)
        result.damage=result.damage+math.min(value,U.effectiveHP(unit))
        if U.same(unit,lock) then result.lockDamage=math.min(value,U.effectiveHP(unit)) end
        if value>=U.effectiveHP(unit)+margin+(unit.hpRegen or 0)*(delay+.6) then
            result.kills=result.kills+1
            if U.same(unit,lock) then result.lockKill=1 end
            if secondary then result.secondaryKills=result.secondaryKills+1 end
        end
    end
    add(primary,damage,false)
    -- Current normal League retains the flying body after death (Riot 26.10).
    -- Do not import that mechanic into Classic; omit uncertain lethal carriers.
    local carrier=c.profile.id=='normal' or primary.health>c:spellDamageEstimate(3,primary)+margin
    if carrier then
        for _,enemy in ipairs(c.enemies or {}) do
            if c:enemyValid(enemy) and not result.hitIDs[U.id(enemy)] and not b:kickProtected(enemy) then
                local _,fraction=U.segment(enemy.pos,start,endpoint)
                local predicted=self:predict(enemy,delay+.6*fraction)
                if predicted then
                    local d,t=U.segment(predicted,start,endpoint)
                    local radius=math.min(100,primary.boundingRadius or 65)+(enemy.boundingRadius or 65)
                    if t>0 and t<1 and d<=radius-10 then
                        result.hits=result.hits+1;result.hitIDs[U.id(enemy)]=true
                        -- Base R against the secondary target's own resistances.
                        -- Unverified bonus-health collateral is not counted.
                        add(enemy,c:combatDamage(3,enemy),true)
                    end
                end
            end
        end
    end
    if lock and not result.hitIDs[U.id(lock)] then return end
    result.worthwhile=result.hits>=2 and ((c.config:get('multi') and result.hits>=math.max(2,c.config:get('multiHits')))
        or (c.config:get('collateralKills') and result.secondaryKills>0))
    result.score=result.kills*10000+result.hits*1000+result.damage*.05-(ward and 200 or 0)-(flash and 400 or 0)
    return result
end
function K:better(candidate,best)
    if not best then return true end
    -- Lexicographic priorities cannot be overturned by a damage-score scale.
    for _,field in ipairs({'lockKill','lockDamage','kills','hits','damage'}) do
        local a,b=candidate[field] or 0,best[field] or 0
        if a~=b then return a>b end
    end
    if (best.flash and true or false)~=(candidate.flash and true or false) then return best.flash and true or false end
    return best.ward and not candidate.ward
end
-- Flash slot for a multi-kick reposition: opt-in switch, Flash ready, R and the
-- Flash itself affordable, not already requested.
function K:flashSlot()
    local c=self.ctx
    if not c.config:get('multiFlash') then return end
    for slot=4,5 do
        if U.name(c:spell(slot).name)=='summonerflash' and c:ready(slot) and not c.actions:pendingCast(slot) then return slot end
    end
end
function K:best(reposition)
    local c=self.ctx;local best
    if #(c.enemies or {})<2 or not c.config:get('multi') and not c.config:get('collateralKills') then return end
    reposition=reposition and c.config:get('comboWard') and c.config:get('comboW') and c.wards:available()
        and not c.wards.pending and c:now()>=(c.wards.fightRetryAt or 0)
    local wardRange=reposition and c.wards:range() or 0
    local flash=c.mode=='fight' and self:flashSlot() and not c.wards.pending and 400 or 0
    wardRange=math.max(wardRange,flash)
    -- No prediction or ward search for a single eligible champion. The second
    -- champion may be outside R range, but must be reachable by the kicked body.
    local nearby=0
    local reach=c.profile.rRange+c:kickLength(nil)+wardRange+250
    for _,enemy in ipairs(c.enemies or {}) do
        if c:enemyValid(enemy) and U.dist(myHero.pos,enemy.pos)<=reach and not c.combat:kickProtected(enemy) then nearby=nearby+1 end
    end
    if nearby<2 then return end
    if not c.config:get('collateralKills') and nearby<math.max(2,c.config:get('multiHits')) then return end
    for n,primary in ipairs(c.enemies or {}) do
        if n>5 then break end
        if c:enemyValid(primary) and U.dist(myHero.pos,primary.pos)<=c.profile.rRange+wardRange+100
            and not c.combat:kickProtected(primary) then
            local direct=self:evaluate(primary,myHero.pos,false)
            if direct and direct.worthwhile and self:better(direct,best) then best=direct end
            if (reposition or flash>0) and U.dist(myHero.pos,primary.pos)<wardRange+c.profile.rRange then
                for m,other in ipairs(c.enemies or {}) do
                    if m>5 then break end
                    if c:enemyValid(other) and not U.same(primary,other) then
                        local arrival=.25+c.combat.tactics:wardArrival()
                        local collateral=.6*U.clamp(U.dist(primary.pos,other.pos)/math.max(1,c:kickLength(primary)),0,1)
                        local a,b=self:predict(primary,arrival),self:predict(other,arrival+collateral)
                        local stand=a and b and U.toward(a,b,-180)
                        local open=stand and not c:underTurret(stand) and c.terrain:wall(stand)==false
                        local distance=stand and U.dist(myHero.pos,stand)
                        local kinds={}
                        if open and reposition and distance<=c.wards:range() and c.wards:canStart(stand) then kinds[#kinds+1]='ward' end
                        -- Flash, then R: only for a plan that kills or reaches the hit minimum.
                        if open and flash>0 and distance<=flash-10 then kinds[#kinds+1]='flash' end
                        for _,kind in ipairs(kinds) do
                            local plan=self:evaluate(primary,stand,kind=='ward',kind=='flash')
                            if plan and plan.worthwhile and (not direct or not direct.worthwhile
                                or plan.kills>direct.kills or plan.hits>direct.hits)
                                and self:better(plan,best) then best=plan end
                        end
                    end
                end
            end
        end
    end
    return best
end
return K

end
