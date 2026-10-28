return function(require)
-- Observed waypoints describe movement; cursor intent only ranks alternatives.
local G=require('evade.geometry')
local T={}
-- A world cursor sample is usable as intent only when its native projection
-- agrees with the provider's logical player screen point. No input is sent.
function T.CursorMatches(g,point,screen)
    local ok,matched,reason=pcall(function()
        if not G.point(point)then return false,'cursor_world_unavailable'end
        if not screen or not G.finite(screen.x)or not G.finite(screen.y)then
            return false,'cursor_screen_unavailable'
        end
        local vector=g.Vector and g.Vector(point.x,point.y or 0,point.z)or point
        local projected=vector:To2D()
        if not projected or not G.finite(projected.x)or not G.finite(projected.y)then
            return false,'cursor_projection_unavailable'
        end
        local dx,dy=projected.x-screen.x,projected.y-screen.y
        if projected.onScreen==false or dx*dx+dy*dy>25 then return false,'cursor_projection_mismatch'end
        return true
    end)
    if not ok then return false,'cursor_projection_unavailable'end
    return matched==true,reason
end
function T.Read(hero)
    local p=hero.pathing
    if not p or not p.hasMovePath then return {G.copy(hero.pos)}end
    -- A dash needs its own speed/landing model. Do not replace it with walking.
    if p.isDashing then return {},'dash_trajectory_unmodeled'end
    local first,last=p.pathIndex,p.pathCount
    if not G.finite(first)or not G.finite(last)or first<0 or last<first
        or last-first>63 or type(hero.GetPath)~='function'then return {},'waypoints_unavailable'end
    local path={}
    for i=first,last do
        local point=hero:GetPath(i)
        if not G.point(point)then return {},'waypoint_unknown'end
        if G.dist(path[#path]or hero.pos,point)>1 then path[#path+1]=G.copy(point)end
    end
    if #path==0 then return {G.copy(hero.pos)}end
    return path
end
function T.Clip(path,origin,distance)
    if type(path)~='table'or #path==0 or #path>64 then return {}end
    local result={};local from=origin
    for _,point in ipairs(path)do
        if not G.point(point)then return {}end
        local length=G.dist(from,point)
        if length>distance then
            result[#result+1]=G.lerp(from,point,distance/length);return result
        end
        result[#result+1]=G.copy(point);distance=distance-length;from=point
    end
    return result
end
-- Absolute post-modifier speeds supplied by an evidenced observation/adapter.
-- Multipliers and stacking rules belong to the producing champion profile.
function T.SpeedSchedule(changes)
 if type(changes)~='table'or #changes>16 then return nil,'invalid_speed_schedule'end
 local count=0
 for key in pairs(changes)do
  count=count+1
  if count>16 or type(key)~='number'or key%1~=0 or key<1 or key>#changes then return nil,'invalid_speed_schedule'end
 end
 if count~=#changes then return nil,'invalid_speed_schedule'end
 local result={};local previous=-math.huge
 for i,row in ipairs(changes)do
  if type(row)~='table'or not G.finite(row.at)or row.at<=previous
   or not G.finite(row.speed)or row.speed<0 then return nil,'invalid_speed_schedule'end
  result[i]={at=row.at,speed=row.speed};previous=row.at
 end
 return result
end
function T.WalkTimed(from,to,at,limit,baseSpeed,changes,budget,visit)
 local speed,index=baseSpeed,1
 while changes[index]and changes[index].at<=at do speed=changes[index].speed;index=index+1 end
 local remaining=G.dist(from,to)
 if remaining==0 then
  local ok,why=visit(from,to,at,at)
  return ok and to or nil,at,ok,why
 end
 while at<limit do
  budget.remaining=budget.remaining-1
  if budget.remaining<0 then return nil,at,false,'trajectory_budget'end
  local boundary=changes[index]and math.min(limit,changes[index].at)or limit
  local duration=speed>0 and math.min(boundary-at,remaining/speed)or boundary-at
  local reached=speed>0 and duration>=remaining/speed
  local endpoint=reached and to or G.lerp(from,to,speed*duration/remaining)
  local ok,why=visit(from,endpoint,at,at+duration)
  if not ok then return nil,at,false,why end
  from,at=endpoint,at+duration
  if reached then return from,at,true end
  remaining=G.dist(from,to)
  if changes[index]and at>=changes[index].at then speed=changes[index].speed;index=index+1 end
 end
 return from,at,false
end

return T

end
