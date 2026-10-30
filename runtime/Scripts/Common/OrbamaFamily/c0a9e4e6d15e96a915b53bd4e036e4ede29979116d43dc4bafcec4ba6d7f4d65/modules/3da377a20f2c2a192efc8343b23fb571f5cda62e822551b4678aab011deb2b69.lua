return function(require)
return function(g,previous,resolve)
    local cast=g.myHero.activeSpell
    if not cast or not cast.valid or cast.isStopped or type(cast.castEndTime)~='number'
        or cast.castEndTime~=cast.castEndTime then return previous end
    local data=g.SDK and g.SDK.Data
    if not(cast.isAutoAttack or data and data.IsAttack and data:IsAttack(cast.name or ''))then return previous end
    local now=g.Game.Timer()
    if cast.castEndTime<now-.35 or cast.castEndTime>now+2 then return previous end
    local id=cast.target
    if type(id)=='table'or type(id)=='userdata'then id=id.networkID or id.handle end
    if not id or id==0 then return nil end
    if previous and previous.at==cast.castEndTime and previous.nativeTarget==id then return previous end
    local target=resolve(id)
    if not target or not target.networkID or(target.networkID~=id and target.handle~=id)then return nil end
    if not target.valid or target.dead or not target.isTargetable or not target.visible or (target.health or 0)<=0 then return nil end
    return {target=target.networkID,handle=target.handle,object=target,at=cast.castEndTime,
        nativeTarget=id,startTime=cast.startTime,name=cast.name}
end

end
