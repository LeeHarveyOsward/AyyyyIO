return function(require)
-- Per-ability unit collision for observed and cast-derived straight flights.
-- A reviewed catalog policy (`collide`) says which unit classes stop the
-- projectile; evade.blockers finds the first CERTAIN blocker and the threat is
-- shortened there, so standing behind a minion is recognised as safe. Units come
-- from the shared per-tick minion cache of the provider and the allied roster; the
-- snapshot is built at most once per scan and only when a colliding threat exists.
local G=require('evade.geometry')
local B=require('evade.blockers')
local C={reach=2600,maxUnits=64,workPerScan=512}
C.options={margin=10,errorRate=100,aliveMargin=.1,maxUnits=64,maxWork=96}
local function add(units,count,u,category,hero)
    if not u or u.valid==false or u.dead or u.visible==false or u.isTargetable==false then return count end
    local pos=u.pos
    if not G.point(pos)or G.dist(pos,hero)>C.reach then return count end
    local radius=u.boundingRadius
    if not G.finite(radius)or radius<=0 then return count end
    -- A unit about to die is not a certain blocker.
    local health,maximum=u.health,u.maxHealth
    if G.finite(health)and G.finite(maximum)and maximum>0 and health<math.min(150,maximum*.25)then return count end
    local speed=u.ms;local moving=u.pathing and u.pathing.hasMovePath==true
    count=count+1
    local row=units[count];if not row then row={};units[count]=row end
    row.x,row.z,row.radius,row.category,row.team=pos.x,pos.z,radius,category,u.team
    row.vx,row.vz,row.aliveUntil=0,0,nil
    -- Direction of travel is not read: a moving unit may leave in any direction.
    row.errorRate=moving and G.finite(speed)and speed>0 and speed or nil
    row.id=u.networkID or u.handle
    return count
end
function C.Units(observer)
    if observer.blockScan==observer.scanID then return observer.blockUnits,observer.blockCount end
    local units=observer.blockUnits or {};local count=0
    observer.blockScan=observer.scanID;observer.blockUnits=units
    observer.blockWork=observer.blockWork or {};observer.blockWork.remaining=C.workPerScan
    local g=observer.g;local hero=g.myHero.pos
    local cached=g.SDK and g.SDK.Cached
    if G.point(hero)then
        if cached and type(cached.GetMinions)=='function'then
            local ok,list=pcall(cached.GetMinions,cached)
            if ok and type(list)=='table'then
                observer.hostCalls=(observer.hostCalls or 0)+1
                for i=1,#list do
                    if count>=C.maxUnits then break end
                    local u=list[i]
                    count=add(units,count,u,u and u.team==300 and 'monster'or 'minion',hero)
                end
            end
        end
        for _,ally in ipairs(observer.allies or {})do
            if count>=C.maxUnits then break end
            count=add(units,count,ally,'champion',hero)
        end
    end
    observer.blockCount=count;return units,count
end
function C.Clip(observer,threat,now)
    local policy=B.policy(threat.collide)
    if not policy or threat.shape~='missile'then return threat end
    local units,count=C.Units(observer)
    if count==0 then return threat end
    local caster=observer.heroes[threat.casterID];local team=caster and caster.team or nil
    local distance,at,index=B.firstContact(threat,policy,units,count,now,team,C.options,observer.blockWork)
    if not distance or not G.finite(at)then return threat end
    return B.clip(threat,distance,at,units[index].id)
end
return C

end
