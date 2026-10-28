return function(require)
-- Judgement rules a competent player always applies (no switches):
--  * keep an own channel through cheap poke that carries no control (not a recall: the hit ends it anyway);
--  * keep a committed Combo trade through trivial poke while healthy;
--  * keep a pending last hit (LaneClear, LastHit) through trivial poke while healthy;
--  * stay in a fight aura around the enemy being fought when leaving it means not fighting;
--  * cross a low-damage puddle instead of abandoning an attack over it;
--  * spend items and ultimates only on hits that matter.
-- "Cheap" is the live danger (evade.danger: damage now after resists and shields, in shares of current
-- health) at or below a small share. A reviewed tier stands in only when the damage is unknown, and
-- unknown damage is held to a stricter bar (tierShare 2 passes a channel, only tier 1 a trade). Hard
-- control, a targeted effect, a mark or a possible-contact threat is never cheap. A suppressed threat
-- stays observed and drawn; the planner simply does not move for it.
local G=require('evade.geometry')
local Danger=require('evade.danger')
local Positioning=require('evade.positioning')
local ControlWindow=require('CombatProfiles.control_window')
-- tradeGuess: with unknown damage only a trivial hit (tier 1) is worth a trade. Live 2026-10-08: a tier-2
-- Ahri Q kept as "poke" took 19 % of current health on its two passes.
local P={cheapShare=.08,tradeGuess=.04,tradeHealth=.35,puddleHealth=.4,puddleDanger=.25,defaultShare=20}
-- The threat's danger record: the app's cached model when given, else the team-free formula.
local function danger(t,stats,model)
    if model then return model:Threat(t,stats,stats.origin,stats.now)end
    return Danger.Of(t,stats)
end
function P.Cheap(t,stats,guess,model)
    if t.shape=='targeted'or t.mark or t.ccHard==true or G.finite(t.cc)and t.cc>0 then return false end
    if t.potentialDamage then return false end
    local record=danger(t,stats,model)
    if record.value==nil then return false end
    return record.value<=(record.basis=='tier'and(guess or P.cheapShare)or P.cheapShare)
end
-- Own channel/recall from the native active spell (never a buff-name guess);
-- trade from the provider's Combo mode and its current target in attack reach.
function P.Context(app,now)
    local g,sdk=app.g,app.sdk;local h=g.myHero
    local ctx={health=h.health,maxHealth=h.maxHealth,armor=h.armor,magicResist=h.magicResist,
        shield=h.allShield or 0,physicalShield=h.shieldAD or 0,magicShield=h.shieldAP or 0,origin=G.point(h.pos)and G.copy(h.pos)or nil}
    local spell=h.activeSpell
    -- The host flags an attack windup as channelling, and isAutoAttack is false for empowered attack names
    -- (live: Jade_VayneQ_Attack and Jade_VayneR_UltAttack suppressed Ahri Q as keep_channel): SDK recognition.
    local window=app.controlWindow or ControlWindow
    local attacking=spell and (window.IsAttackCast or ControlWindow.IsAttackCast)(spell,sdk.Data)
    if spell and spell.valid and spell.isStopped~=true and spell.isChanneling==true and not spell.isAutoAttack and not attacking then
        ctx.channeling=true
        local name=type(spell.name)=='string'and spell.name:lower()or ''
        ctx.recalling=name:find('recall',1,true)~=nil
    end
    local orb=sdk.Orbwalker
    if orb and type(orb.HasMode)=='function'and orb:HasMode(sdk.ORBWALKER_MODE_COMBO)and type(orb.GetTarget)=='function'then
        local ok,target=pcall(orb.GetTarget,orb)
        if ok and target and target.valid~=false and not target.dead and target.visible~=false and G.point(target.pos)and G.point(h.pos)
            and G.finite(h.range)then
            local reach=h.range+(h.boundingRadius or 0)+(target.boundingRadius or 0)
            if G.dist(h.pos,target.pos)<=reach+50 then
                ctx.trading=true;ctx.target=target;ctx.targetID=target.networkID or target.handle;ctx.reach=reach
            end
        end
    end
    -- A pending last hit: Orbama's health prediction marks a minion in attack reach killable by the next attack.
    if orb and type(orb.HasMode)=='function'and(orb:HasMode(sdk.ORBWALKER_MODE_LASTHIT)or orb:HasMode(sdk.ORBWALKER_MODE_LANECLEAR))then
        local unit=Positioning.LastHit(sdk,h)
        if unit then ctx.farming=true;ctx.lastHitID=unit.networkID or unit.handle end
    end
    ctx.now=now
    ctx.share=G.finite(ctx.health)and G.finite(ctx.maxHealth)and ctx.maxHealth>0 and ctx.health/ctx.maxHealth or 0
    return ctx
end
function P.Reason(t,ctx,model)
    -- No rule keeps the player inside a hit that would kill: an aura is fought in only below lethal danger.
    if t.zonePolicy=='fight'and ctx.trading and t.casterID==ctx.targetID and G.finite(t.radius)and ctx.reach<t.radius
        and t.ccHard~=true and not(G.finite(t.cc)and t.cc>0)and ctx.share>P.tradeHealth then
        local record=danger(t,ctx,model)
        if not record.lethal and(record.value==nil or record.value<1)then return 'fight_aura'end
    end
    if t.zonePolicy=='puddle'and ctx.trading and ctx.share>P.puddleHealth then
        -- A puddle worth crossing at this health: its danger stays below a quarter of current health.
        local record=danger(t,ctx,model)
        if record.value==nil or record.value<P.puddleDanger then return 'puddle'end
    end
    if not(ctx.channeling or ctx.trading or ctx.farming)then return nil end
    -- A hit ends a recall whether or not the hero moved: standing still only adds the damage.
    if ctx.channeling and not ctx.recalling and P.Cheap(t,ctx,nil,model)then return 'keep_channel'end
    if ctx.trading and ctx.share>P.tradeHealth and P.Cheap(t,ctx,P.tradeGuess,model)then return 'keep_trade'end
    -- The same bar as a trade: a last hit is worth only trivial poke, never control, a targeted hit or a mark.
    if ctx.farming and ctx.share>P.tradeHealth and P.Cheap(t,ctx,P.tradeGuess,model)then return 'keep_last_hit'end
end
-- One pass per decision over the (small) threat list. Returns how many are suppressed.
function P.Apply(app,now)
    local store=app.threats;local list=store.list
    if #list==0 then return 0 end
    local ctx;local n=0
    for i=1,#list do
        local t=list[i];local reason=nil
        if t.tier~=nil or t.zonePolicy~=nil or t.damage~=nil then
            ctx=ctx or P.Context(app,now)
            reason=P.Reason(t,ctx,app.danger)
        end
        if store:Suppress(t.id,reason)and reason and app.recorder then
            local record=danger(t,ctx,app.danger)
            app.recorder:Event('threat_suppressed',{id=t.id,ability=t.abilityName,champion=t.champion,reason=reason,tier=t.tier,
                danger=record.value,dangerBasis=record.basis,damage=record.damage,control=record.control,followUp=record.followUp,
                hp=ctx.health,armor=ctx.armor,magicResist=ctx.magicResist,shield=ctx.shield})
        end
        if reason then n=n+1 end
    end
    return n
end
-- Items and ultimates answer only a forecast that matters (evade.danger Matters): lethal, lethal with the
-- enemy follow-up during its control, or a danger of at least the shared share of current health.
-- Cheaper options keep their own adapter policy.
function P.Worth(app,option,outcome)
    if not(option.item or option.ultimate)then return true end
    local share=app.menu and app.menu.MinDamage and app.menu.MinDamage:Value()or P.defaultShare
    return(Danger.Matters(outcome,share/100,app.g.myHero.health))
end
-- Gaze spells punish a facing (Petrifying Gaze stuns those facing the caster).
-- When the hit cannot be walked out of, the remaining answer is to face the
-- right way at impact: one short move order away from (or toward) the caster.
-- Returns the point to walk to, the threat and the wanted sense, or nil.
function P.Gaze(app,ctx,baseline)
    if type(baseline)~='table'or type(baseline.hits)~='table'then return nil end
    for _,id in ipairs(baseline.hits)do
        local t=app.threats.byID[id]
        if t and t.gaze and G.point(t.castOrigin or t.origin)then
            local caster=t.castOrigin or t.origin
            local dx,dz=G.direction(caster,ctx.origin)
            if t.gaze=='toward'then dx,dz=-dx,-dz end
            local dir=app.g.myHero.dir
            -- Already facing the safe way: nothing to send.
            if G.point(dir)and dir.x*dx+dir.z*dz>.5 then return nil,t,t.gaze end
            return {x=ctx.origin.x+dx*35,y=ctx.origin.y or 0,z=ctx.origin.z+dz*35},t,t.gaze
        end
    end
end
return P

end
