return function(require)
local U=require('tf.util')
local P=require('CombatProfiles.twisted_fate')
local F={};F.__index=F
function F.new(c)return setmetatable({c=c},F)end
function F:eligible(u,mode)
    local c=self.c
    if not U.target(u) or u.team==c.hero.team or u.type~=Obj_AI_Minion then return false end
    if mode=='JUNGLECLEAR' then return u.team==300 and U.dist(c.hero,u)<850 end
    return u.team~=300 and U.dist(c.hero,u)<c.profile.q.range
end
function F:hp(u,delay)return self.c.sdk.HealthPrediction:GetPrediction(u,delay)end
function F:impact(u)
    local c=self.c;local attack=c.sdk.Attack
    local wait=math.max(0,(attack.ServerStart or -10)+attack:GetAnimation()-Game.Timer())
    local impact=attack:GetImpactTime(u)
    return impact and wait+impact
end
function F:aa(u,color)
    local raw=self.c.combat:packet(u,color,self.c.state.eReady)
    return raw.physical+raw.magical+raw.trueDamage
end
function F:attackChoice(mode)
    local c=self.c;local s=c.state;local hit,best,urgent,hitHP,bestHP
    local examined=0
    for _,u in ipairs(s.minions)do
        examined=examined+1;if examined>128 then break end
        if self:eligible(u,mode) and U.dist(c.hero,u)<=c.sdk.Data:GetAutoAttackRange(c.hero,u)then
            local at=self:impact(u);local hp=self:hp(u,at or 0)
            if hp>0 then
                if not best or hp<bestHP then best=u;bestHP=hp end
                if at and hp<=self:aa(u,s.stage=='held' and s.color or nil)then
                    local losesWindow=self:hp(u,at+c.profile.q.delay)<=0
                    if not hit or losesWindow and not urgent or losesWindow==urgent and hp<hitHP then
                        hit=u;hitHP=hp;urgent=losesWindow
                    end
                end
            end
        end
    end
    return hit,best,urgent
end
function F:decision(reason,target)
    local c=self.c;if not c.config:get('diagnostics')then return end
    local id=target and U.id(target);local now=Game.Timer()
    if self.lastReason==reason and self.lastTarget==id and now<(self.nextDecision or 0)then return end
    self.lastReason=reason;self.lastTarget=id;self.nextDecision=now+.5
    c:record('farm_decision',{reason=reason,target=id,mode=c.state.mode})
end
function F:diagnostics(mode)
    local c=self.c;if not c.config:get('diagnostics')then return end
    local now=Game.Timer();if now<(self.nextDiagnostic or 0)then return end
    self.nextDiagnostic=now+.25
    local s=c.state;local attack=c.sdk.Attack;local n=0;local examined=0;local tracked={}
    local sdkRows={}
    for i,row in ipairs(c.sdk.HealthPrediction.FarmMinions or {})do
        if i>128 then break end
        if row.Minion then sdkRows[U.id(row.Minion)]=row end
    end
    c:record('farm_snapshot',{mode=mode,stage=s.stage,color=s.color,manual=c.cards.manual and c.cards.manual.color,
        attackBlocked=c.actions.client.locks.manual_card and c.actions.client.locks.manual_card.attack,
        providerCanAttack=c.sdk.Orbwalker:CanAttack(),
        attackJob=c.combat.attackID,serverStart=attack.ServerStart,castEnd=attack.CastEndTime,
        period=attack:GetAnimation(),windup=attack:GetWindup(),speed=attack:GetProjectileSpeed(),
        qReady=s:ready(0),wReady=s:ready(1,s.stage=='selecting'),eReady=s.eReady,mana=c.hero.mana})
    for _,u in ipairs(s.minions)do
        examined=examined+1;if examined>128 or n>=12 then break end
        if self:eligible(u,mode)then
            n=n+1;local at=self:impact(u);local row=sdkRows[U.id(u)]
            tracked[U.id(u)]={unit=u,health=u.health,at=now}
            c:record('farm_minion',{id=U.id(u),handle=u.handle,name=u.charName,team=u.team,health=u.health,
                maxHealth=u.maxHealth,distance=U.dist(c.hero,u),range=c.sdk.Data:GetAutoAttackRange(c.hero,u),
                aaImpact=at,hpAA=at and self:hp(u,at),aaDamage=self:aa(u,s.stage=='held' and s.color or nil),
                hpAfterQCast=at and self:hp(u,at+c.profile.q.delay),qImpact=c.profile.q.delay+U.dist(c.hero,u)/c.profile.q.speed,
                hpQ=self:hp(u,c.profile.q.delay+U.dist(c.hero,u)/c.profile.q.speed),qDamage=c.combat:qDamage(u),
                sdkLastHittable=row and row.LastHitable,sdkPredictedHP=row and row.PredictedHP,
                sdkUnkillable=row and row.Unkillable})
        end
    end
    for id,last in pairs(self.tracked or {})do
        if not tracked[id]then
            local u=last.unit;local dead=u.valid~=false and (u.dead or (u.health or 1)<=0)
            c:record('farm_minion_exit',{id=id,lastHealth=last.health,lastSeen=last.at,
                state=dead and 'death_observed' or 'left_sample',credit='unknown'})
        end
    end
    self.tracked=tracked
end
function F:qWorth(u,mode,attackWindowChecked,evaluation)
    local c=self.c;local s=c.state
    if not attackWindowChecked then
        local _,_,urgent=self:attackChoice(mode)
        if urgent then return false end -- Rechecked before a queued Q sends, too.
    end
    if evaluation and not evaluation.geometry then evaluation.geometry={}end
    local plan=c.q:plan(u,s.minions,evaluation and evaluation.geometry);if not plan then return false end
    local kills,total=0,0
    for _,m in ipairs(plan.hits)do
        if not self:eligible(m,mode)then return false end
        local id=U.id(m);local row=evaluation and evaluation[id]
        if not row then
            row={hp=self:hp(m,c.profile.q.delay+U.dist(c.hero,m)/c.profile.q.speed),damage=c.combat:qDamage(m)}
            if evaluation then evaluation[id]=row end
        end
        local hp,damage=row.hp,row.damage
        if hp>0 then
            total=total+math.min(damage,hp)
            if hp<=damage then kills=kills+1 elseif mode=='LASTHIT' then return false end
        end
    end
    if mode=='LASTHIT' then
        local aaTime=self:impact(u)
        local hpAA=aaTime and self:hp(u,aaTime)
        if c.effects:hasUnknownSplash()then return false end
        local inRange=U.dist(c.hero,u)<=c.sdk.Data:GetAutoAttackRange(c.hero,u)
        if inRange and hpAA and hpAA>0 and hpAA<=self:aa(u,s.stage=='held' and s.color or nil) then return false end
        return kills>0 and c.hero.mana>=s:cost(0)+s:reserve(0)
    end
    return total>0 and (kills>0 or #plan.hits>=2 or mode=='JUNGLECLEAR') and c.hero.mana>=s:cost(0)+s:reserve(0),kills,total
end
-- No minion to hit while lane clearing: a blue card for the structure the orbwalker is attacking. The empowered
-- attack triggers on structures in both profiles (wiki Twisted_Fate and League_Classic/Twisted_Fate, read
-- 2026-10-08); whether blue pays its mana back there is not established, so the reserve is checked without it.
function F:structure(mode)
    local c=self.c;local s=c.state
    if mode~='LANECLEAR'or c.cards.manual or not c.config:get(mode..'W')or s.stage=='held'or not s:ready(1,s.stage=='selecting')then return end
    local walker=c.sdk.Orbwalker;local t=walker.GetTarget and walker:GetTarget()
    local function valid()
        return t~=nil and U.target(t)and t.team~=c.hero.team
            and(Obj_AI_Turret~=nil and t.type==Obj_AI_Turret or Obj_AI_Barracks~=nil and t.type==Obj_AI_Barracks or Obj_AI_Nexus~=nil and t.type==Obj_AI_Nexus)
            and U.dist(c.hero,t)<=c.sdk.Data:GetAutoAttackRange(c.hero,t)
    end
    if not valid()or s.stage~='selecting'and c.hero.mana-s:cost(1)<s:reserve(1)then return end
    self:decision('blue_structure',t)
    return c.cards:auto('blue','clear',valid)
end
-- Red card splash: the eligible unit in attack range whose predicted position (at the card's impact) has the most
-- other eligible units within the profile's radius. The count includes the centre once; splash victims are counted
-- per unit, never the primary twice. Bounded to 24 units.
function F:redCentre(mode)
    local c=self.c;local s=c.state;local radius=c.profile.redRadius
    if not radius then return nil,0 end
    local units,positions={},{};local examined=0
    local windup=c.sdk.Attack:GetWindup()
    for _,u in ipairs(s.minions)do
        examined=examined+1;if examined>128 or #units>=24 then break end
        if self:eligible(u,mode)and U.dist(c.hero,u)<=c.sdk.Data:GetAutoAttackRange(c.hero,u)+radius then
            local at=self:impact(u)
            if at then
                units[#units+1]=u;positions[#units]=u.GetPrediction and u:GetPrediction(1500,math.max(windup,at))or u.pos
            end
        end
    end
    local best,count=nil,0
    for i,u in ipairs(units)do
        if U.dist(c.hero,u)<=c.sdk.Data:GetAutoAttackRange(c.hero,u)then
            local n=1
            for j=1,#units do if j~=i and U.dist(positions[i],positions[j])<=radius then n=n+1 end end
            if n>count or n==count and best and u.health>best.health then best=u;count=n end
        end
    end
    return best,count
end
-- A monster whose attack is aimed at TF.
function F:attacksMe(u)
    local h=self.c.hero;local data=u.attackData;local target=data and data.target
    if type(target)=='table'or type(target)=='userdata'then target=U.id(target)end
    return target~=nil and(target==h.handle or target==h.networkID)
end
function F:tick(mode,modeID)
    local c=self.c;local s=c.state
    self:diagnostics(mode)
    -- The family spell-farming toggle governs every farming mode: off means attacks only (no Q, no card).
    local spells=c.config:get('spellFarm')==true
    local hit,best,urgent=self:attackChoice(mode)
    local function attack(u)
        self:decision(urgent and 'save_aa_window' or 'aa_last_hit',u)
        return c.combat:attack(u,modeID,'farm_attack',function()
            local at=self:impact(u);if not at then return false end
            local hp=self:hp(u,at);local color=c.state.stage=='held' and c.state.color or nil
            return self:eligible(u,mode) and hp>0 and hp<=self:aa(u,color)
        end)
    end
    if hit and (urgent or mode=='LASTHIT')then return attack(hit)end
    local examined=0
    local qTarget,qKills,qTotal;local predicted=0
    -- These candidates are evaluated synchronously from the same fresh state.
    -- Reuse identical Q impact health/damage, never across ticks or dispatch.
    local evaluation={}
    local canQ=spells and c.config:get(mode..'Q') and s:ready(0) and not s:windupActive()
        and not c.actions:busy(0) and c.hero.mana>=s:cost(0)+s:reserve(0)
    for _,u in ipairs(s.minions)do
        examined=examined+1;if examined>128 then break end
        if self:eligible(u,mode)then
            if canQ and predicted<8 then
                predicted=predicted+1
                local worth,kills,total=self:qWorth(u,mode,true,evaluation);kills=kills or 1;total=total or 0
                if worth and (not qTarget or kills>qKills or kills==qKills and total>qTotal)then
                    qTarget=u;qKills=kills;qTotal=total
                end
            end
        end
    end
    if qTarget then
        self:decision('q_farm',qTarget)
        return c.q:cast(qTarget,modeID,function(t)return c.config:get(mode..'Q') and self:eligible(t,mode) and self:qWorth(t,mode)end)
    end
    if hit then return attack(hit)end
    -- A held red card goes to the best splash centre instead of the orbwalker's choice.
    if s.stage=='held'and s.color=='red'and mode~='LASTHIT'then
        local centre,count=self:redCentre(mode)
        if centre and count>=2 then
            self.redPlan={unit=centre,count=count,at=Game.Timer()};self:decision('red_centre',centre)
            c:record('red_planned',{target=U.id(centre),count=count,radius=c.profile.redRadius,held=true})
            return c.combat:attack(centre,modeID,'farm_attack',function()
                return self:eligible(centre,mode)and c.state.stage=='held'and c.state.color=='red'
                    and self:impact(centre)~=nil
            end)
        end
    end
    if not best then if not(spells and self:structure(mode))then self:decision('no_reachable_target')end;return end
    if c.config:get('level') and math.floor(Game.Timer())~=c.level.lastSample then
        local qOpportunity=c.q:plan(best,s.minions)
        c.level:sample(mode,{attack=true,period=c.sdk.Attack:GetAnimation(),
            q=qOpportunity and #qOpportunity.hits>=2 and true or nil,controlValue=0})
    end
    local bestImpact=self:impact(best)
    local bestHP=bestImpact and self:hp(best,bestImpact)
    self:decision('provider_clear_or_wait',best)
    if not spells or c.cards.manual or not c.config:get(mode..'W') or s.stage=='held' or not s:ready(1,s.stage=='selecting')then return end
    local blue=self:aa(best,'blue')
    if mode=='LASTHIT' then
        if bestHP and not c.effects:hasUnknownSplash() and bestHP<=blue and c.cards:waitFor('blue')<.4
            and c.hero.mana>=s:cost(1)+s:reserve(1)then c.cards:auto('blue','save_cs',function()
                local at=self:impact(best);if not at then return false end
                local hp=self:hp(best,at+c.cards:waitFor('blue'))
                return self:eligible(best,mode) and hp>0 and hp<=self:aa(best,'blue')
            end)end
    else
        local color,unit='blue',best
        -- Blue's refund is needed when, after paying W, a Wild Cards (and the reserve) is unaffordable or mana is low.
        local after=c.hero.mana-s:cost(1)
        local refund=after<s:reserve(1)+s:cost(0) or after<(c.hero.maxMana or 0)*.35
        local centre,count=self:redCentre(mode)
        if not refund and centre and count>=(mode=='JUNGLECLEAR'and 2 or 3)then
            color,unit='red',centre;self.redPlan={unit=centre,count=count,at=Game.Timer()}
            c:record('red_planned',{target=U.id(centre),count=count,radius=c.profile.redRadius,held=false})
        elseif mode=='JUNGLECLEAR'and c.hero.mana>=s:cost(1)+s:cost(0)then
            -- One monster in reach that is attacking TF: the gold stun removes that many seconds of its attacks.
            local near,examined=0,0
            for _,u in ipairs(s.minions)do
                examined=examined+1;if examined>128 then break end
                if self:eligible(u,mode)and U.dist(c.hero,u)<=c.sdk.Data:GetAutoAttackRange(c.hero,u)+200 then near=near+1 end
            end
            if near==1 and self:attacksMe(best)then color='gold'end
        end
        local recovery=color=='blue' and P.Rank(c.profile.blueRestore,s.spells[1].level) or 0
        if c.hero.mana>=s:cost(1) and math.min(c.hero.maxMana,c.hero.mana-s:cost(1)+recovery)>=s:reserve(1)then
            self:decision(color..'_card',unit)
            c.cards:auto(color,'clear',function()
                return self:eligible(unit,mode) and U.dist(c.hero,unit)<=c.sdk.Data:GetAutoAttackRange(c.hero,unit)
                    and (color~='red'or self:impact(unit)~=nil)
            end)
        end
    end
end
return F

end
