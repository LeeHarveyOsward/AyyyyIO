return function(require)
-- Built-in own defensive abilities (evade.defensedata, own asset rows): spell
-- shields, a parry, damage immunity, wind walls (Wind Wall, Blade Whirl) and
-- shields that also remove crowd control (Black Shield). Selection stays in
-- app:Tick (EvaluateDefense/Better); this adapter offers and prepares.
-- These are one-shot answers on a cooldown: with walking evidence they are
-- offered only for a hit that matters (lethal, hard control, the shared share
-- of current health, or - with unknown damage - a reviewed tier of 4-5).
local G=require('evade.geometry')
local Dash=require('evade.dash_adapter')
local profiles=require('evade.defensedata')
local M={}
M.maxWalls=3;M.wallReach=2500;M.wallSpread=math.cos(math.rad(20))
-- A directional parry (Fiora W) is aimed at the source of the hit it answers so its
-- counter-strike can reach the attacker: Riposte range 900 (Template:Data_Fiora/Riposte,
-- read 2026-10-10). Farther sources keep the movement-direction aim.
M.parryReach=900
function M.Install(app)
    local g=app.g;local h=g.myHero;local p=profiles[h.charName]
    if not p then return end
    local function ready()
        if not app:Available()or h.charName~=p.identity then return false end
        if app.menu and not app.menu.SpellsEnabled:Value()then return false end
        if p.ultimate and not app.permissions.ultimates then return false end
        local s=h:GetSpellData(p.slot)
        return s and s.name==p.name and (s.level or 0)>0 and app:DefenseReady('slot:'..p.slot,g.Game.CanUseSpell(p.slot)==0)
            and G.finite(s.mana)and h.mana>=s.mana
    end
    local function rank()
        local s=h:GetSpellData(p.slot);local level=s and s.level
        return G.finite(level)and level>=1 and math.min(5,math.floor(level))or nil
    end
    local function matters(ctx)
        local baseline=ctx.walkingBaseline
        if type(baseline)~='table'then return true end -- a direct query without walking evidence is judged by its caller
        local walking=ctx.walking
        return(Dash.Trigger(app,walking and walking.known and walking or baseline))
    end
    -- `aim`: unit direction of a directional wall (toward where the projectile comes from).
    local function effect(ctx,aim)
        local starts=ctx.now+.05+(p.castDelay or 0)
        -- Delay narrows the guaranteed protection window; it must not extend it.
        local e={kind=p.kind,starts=starts,ends=ctx.now+p.duration,immobilizes=p.kind=='parry',
            immobilizedUntil=p.kind=='parry'and starts+p.duration or nil}
        if p.kind=='windwall'then
            local w=p.wall;local o=ctx.origin
            if w.radius then e.wall={center=G.copy(o),radius=w.radius}
            else
                local level=rank();local width=level and w.widths[level]
                if not width or not aim then return nil end
                local half=width/2;local px,pz=-aim.z,aim.x
                local function ends(distance)
                    local cx,cz=o.x+aim.x*distance,o.z+aim.z*distance
                    return {x=cx+px*half,y=o.y or 0,z=cz+pz*half},{x=cx-px*half,y=o.y or 0,z=cz-pz*half}
                end
                -- The wall drifts from the caster to its far end: both ends of that sweep must be crossed.
                local a,b=ends(w.near);local a2,b2=ends(w.far)
                e.wall={a=a,b=b,a2=a2,b2=b2}
            end
        elseif p.kind=='shield'then
            local level=rank();local base=level and p.amounts[level]
            if not base then return nil end
            local ap=h.ap;e.shieldType=p.shieldType;e.ccImmune=p.ccImmune==true
            e.amount=base+(p.apRatio or 0)*(G.finite(ap)and ap>0 and ap or 0)
        end
        return e
    end
    -- Unit direction toward the source of the hit a parry answers: the earliest forecast
    -- hit with hard control, else the earliest hit, among the walking outcome then the
    -- baseline. A caster still in the roster is read at its current position.
    local function parryAim(ctx)
        local o=ctx.origin;local heroes=app.observer and app.observer.heroes
        local best,bestAt,bestHard
        for _,result in ipairs({ctx.walking,ctx.walkingBaseline})do
            if type(result)=='table'and type(result.hits)=='table'then
                for i=1,math.min(#result.hits,32)do local t=app.threats.byID[result.hits[i]]
                    if t then
                        local caster=heroes and t.casterID and heroes[t.casterID]
                        local from=caster and caster.dead~=true and caster.visible~=false and G.point(caster.pos)and caster.pos
                            or t.castOrigin or t.origin
                        local hard=t.ccHard==true or G.finite(t.cc)and t.cc>0
                        local at=G.finite(t.starts)and t.starts or math.huge
                        if G.point(from)and G.dist(from,o)>1 and G.dist(from,o)<=M.parryReach
                            and(not best or hard and not bestHard or hard==bestHard and at<bestAt)then
                            best,bestAt,bestHard=from,at,hard
                        end
                    end
                end
            end
        end
        if not best then return nil end
        local dx,dz=G.direction(o,best);return {x=dx,z=dz}
    end
    -- Directions of the blockable projectiles in flight, most urgent first (bounded).
    local function wallAims(ctx)
        local out={};local list=app.threats.list;local o=ctx.origin
        local rows={}
        for i=1,math.min(#list,64)do
            local s=list[i]
            if s.windwall==true and s.shape=='missile'and s.ends>=ctx.now and not app.threats.suppressed[s.id]then
                local from=G.center(s,math.max(ctx.now,s.launch or s.starts))
                if G.point(from)and G.dist(from,o)<=M.wallReach and G.dist(from,o)>1 then rows[#rows+1]={from=from,at=s.starts}end
            end
        end
        table.sort(rows,function(a,b)return a.at<b.at end)
        for _,row in ipairs(rows)do
            local dx,dz=G.direction(o,row.from);local fresh=true
            for _,aim in ipairs(out)do if aim.x*dx+aim.z*dz>=M.wallSpread then fresh=false;break end end
            if fresh then out[#out+1]={x=dx,z=dz};if #out>=M.maxWalls then break end end
        end
        return out
    end
    app:RegisterDefense('champion:'..p.identity,{validated=true,source=p.source,
        options=function(ctx)
            if not ready()or not matters(ctx)then return {}end
            local function option(e,aim)
                return {validated=true,profile=p.profile,resource='slot:'..p.slot,cost=p.ultimate and 100 or 20,
                    ultimate=p.ultimate,effect=e,slot=p.slot,aim=aim,
                    -- Blade Whirl is certified where it was cast.
                    path=p.kind=='windwall'and p.wall.radius and {G.copy(ctx.origin)}or nil}
            end
            if p.kind=='windwall'and not p.wall.radius then
                local out={}
                for _,aim in ipairs(wallAims(ctx))do local e=effect(ctx,aim);if e then out[#out+1]=option(e,aim)end end
                return out
            end
            local e=effect(ctx);if not e then return {}end
            return {option(e,p.kind=='parry'and p.directional and parryAim(ctx)or nil)}
        end,
        prepare=function(option,ctx)
            if not ready()then return end
            if not app.sdk.Actions:GetAvailability().available then return end
            local revision,terrainRevision=app.threats.revision,app.terrain.revision;local generation=app.serial
            local result=app:EvaluateDefense(option,nil,ctx)
            if not app.defenses:PolicyAllowed(option.resource,option,ctx,result)
                or not app:DefenseUseful(result,ctx)or revision~=app.threats.revision or terrainRevision~=app.terrain.revision then return end
            local key=g[({'HK_Q','HK_W','HK_E','HK_R'})[p.slot+1]]
            if not key then return end
            local expires=app.clock()+20
            local aim
            if option.aim then aim={x=ctx.origin.x+option.aim.x*100,y=ctx.origin.y,z=ctx.origin.z+option.aim.z*100}
            elseif p.directional then
                aim=G.lerp(ctx.origin,ctx.intent,G.dist(ctx.origin,ctx.intent)>1 and 100/G.dist(ctx.origin,ctx.intent)or 0)
                if G.dist(aim,ctx.origin)<1 then aim={x=ctx.origin.x+100,y=ctx.origin.y,z=ctx.origin.z}end
            end
            local intent={type='cast',key=key,target=aim or p.targeted and h or nil,kind=aim and 'world'or p.targeted and 'object'or nil,
                resource=option.resource,expires=expires,
                mechanical=function()
                    return ready()and app.defenses:PolicyAllowed(option.resource,option,ctx,result)
                        and revision==app.threats.revision and terrainRevision==app.terrain.revision and generation==app.serial and app.clock()<=expires,
                        'defense_state_changed'
                end}
        if aim then
            intent.prevalidateWorldCast=true
            intent.resolve=function()
                if not ready()or revision~=app.threats.revision or terrainRevision~=app.terrain.revision or generation~=app.serial
                    or app.clock()>expires then return nil,'defense_state_changed'end
                local fresh=app:Context();local evaluated=app:EvaluateDefense(option,nil,fresh)
                if not app.defenses:PolicyAllowed(option.resource,option,fresh,evaluated)
                    or not app:DefenseUseful(evaluated,fresh)or revision~=app.threats.revision or terrainRevision~=app.terrain.revision then return nil,'defense_route_changed'end
                return {position=aim}
            end
            intent.commitGuard=function()return app.active and app.serial==generation and app.threats.revision==revision and app.terrain.revision==terrainRevision and app.clock()<=expires end
            end
            return intent
        end})
end
return M

end
