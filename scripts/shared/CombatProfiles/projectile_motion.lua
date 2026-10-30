return function(require)
if _G.OrbamaPrediction and _G.OrbamaPrediction.ProjectileMotion then return _G.OrbamaPrediction.ProjectileMotion end
-- World units and seconds. Shared by prediction, forecasts and Evade.
local M={};local min,max,sqrt=math.min,math.max,math.sqrt
local function finite(n)return type(n)=='number'and n==n and n>-math.huge and n<math.huge end
function M.Valid(s)
 return type(s)=='table'and finite(s.speed)and s.speed>0 and finite(s.acceleration or 0)
  and finite(s.minSpeed)and finite(s.maxSpeed)and s.minSpeed>0 and s.minSpeed<=s.speed and s.speed<=s.maxSpeed
  and(s.speedStep==nil or type(s.speedStep)=='table'and(s.acceleration or 0)==0
   and finite(s.speedStep.at)and s.speedStep.at>=0 and finite(s.speedStep.speed)
   and s.speedStep.speed>=s.minSpeed and s.speedStep.speed<=s.maxSpeed)
end
function M.Travel(s,dt)
 if s.speedUncertain then return nil end
 dt=max(0,dt);local step=s.speedStep
 if step then local first=min(dt,step.at/s.speed);return s.speed*first+step.speed*(dt-first)end
 local v=s.speed or 0;local a=s.acceleration or 0
 local floor,ceiling=s.minSpeed or 0,s.maxSpeed or math.huge;v=max(floor,min(ceiling,v))
 local limit=a>0 and ceiling or floor
 local ramp=a~=0 and max(0,(limit-v)/a)or math.huge;local first=min(dt,ramp)
 return v*first+.5*a*first*first+(dt-first)*(v+a*first)
end
function M.Time(s,distance)
 if s.speedUncertain then return nil end
 if distance<=0 then return 0 end
 local step=s.speedStep
 if step then return min(distance,step.at)/s.speed+max(0,distance-step.at)/step.speed end
 local v,a=s.speed or 0,s.acceleration or 0
 if a==0 then return v>0 and distance/v or math.huge end
 local floor,ceiling=s.minSpeed or 0,s.maxSpeed or math.huge;v=max(floor,min(ceiling,v))
 local limit=a>0 and ceiling or floor;local ramp=max(0,(limit-v)/a)
 local covered=ramp<math.huge and v*ramp+.5*a*ramp*ramp or math.huge
 if distance>covered then return limit>0 and ramp+(distance-covered)/limit or math.huge end
 return 2*distance/(v+sqrt(max(0,v*v+2*a*distance)))
end
return M

end
