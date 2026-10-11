return function(require)
-- Ground clicks are contextual inputs. Keep their endpoint off visible bodies.
-- This geometric guard is conservative; it is not pixel-perfect hover proof.
local U=require('leesin.util')
local G={}
function G.safePoint(c,pos)
    local p=U.vector(pos):To2D();local service=c.sdk and c.sdk.Minimap
    if service and service.IsWorldScreenPoint then return service:IsWorldScreenPoint(p) end
    -- Legacy test/host without the capability uses the same public geometry.
    local overlay=c.sdk and c.sdk.Overlay
    if overlay and overlay.HUDRects then return false end
    return p and p.onScreen==true
end
function G.blocker(c,pos,scene)
    return G.screenBlocker(c,U.vector(pos):To2D(),nil,scene)
end
local screen=require('InputGeometry.screen')(U)
G.scene=screen.scene;G.screenBlocker=screen.screenBlocker
function G.select(c,pos)
    if not G.safePoint(c,pos)then return nil,'ground_click_hud_or_offscreen'end
    local scene=G.scene(c)
    if not G.blocker(c,pos,scene) then return U.copy(pos) end
    local distance=U.dist(myHero.pos,pos);if distance<1 then return nil,'ground_direction_missing' end
    local radius=myHero.boundingRadius or 35
    local kite=c.mode=='farm' and c.farm and c.farm.kiteStep
    local camp=kite and c.farm.camp
    -- Bounded extension on the same unobstructed ray. Never ask native
    -- pathfinding to get around a wall merely to obtain an empty click point.
    for _,extra in ipairs({80,160,240,320}) do
        local p=U.toward(myHero.pos,pos,distance+extra)
        local outward=kite and kite.phase=='out'
        local inside=outward or not camp or not camp.kiteCenter or U.dist(p,camp.kiteCenter)<=c.config:get('farmKiteLeash')
        local clear=outward and c.farm:kiteLine(myHero.pos,p) or not outward and c.terrain:walkLine(myHero.pos,p,radius)
        if inside and G.safePoint(c,p) and clear
            and not G.blocker(c,p,scene) then return p end
    end
    -- If the ray is occupied or meets terrain, search nearby empty rays. Keep
    -- manual intent generally forward; an outward kite must increase separation.
    local dx,dz=(pos.x-myHero.pos.x)/distance,(pos.z-myHero.pos.z)/distance
    local target=kite and kite.phase=='out' and camp and camp.focus
    local separation=target and U.dist(myHero.pos,target.pos)
    for _,angle in ipairs({.35,-.35,.7,-.7,1.05,-1.05}) do
        local x,z=dx*math.cos(angle)-dz*math.sin(angle),dx*math.sin(angle)+dz*math.cos(angle)
        for _,length in ipairs({300,220,140,80}) do
            local p={x=myHero.pos.x+x*length,y=myHero.pos.y,z=myHero.pos.z+z*length}
            local inside=not camp or not camp.kiteCenter or U.dist(p,camp.kiteCenter)<=c.config:get('farmKiteLeash')
            local useful=target and U.dist(p,target.pos)>separation+15
                or not target and U.dist(p,pos)<distance
            if useful and inside and U.vector(p):To2D().onScreen and c.terrain:walkLine(myHero.pos,p,radius)
                and not G.blocker(c,p,scene) then return p end
        end
    end
    return nil,'ground_click_occupied'
end
return G

end
