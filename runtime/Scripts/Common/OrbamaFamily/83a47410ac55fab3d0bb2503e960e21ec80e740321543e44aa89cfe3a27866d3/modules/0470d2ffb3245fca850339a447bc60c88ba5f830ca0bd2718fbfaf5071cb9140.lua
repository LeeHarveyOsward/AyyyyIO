return function(require)
-- Reviewed harmless carriers that leave ground hazards at their native endpoints.
-- Two consistent motion samples are required. Disappearance never means impact.
local G=require('evade.geometry')
local M={};M.__index=M
function M.new()return setmetatable({tracks={},count=0,max=64,serial=0},M)end
function M:Prune(now)
 for id,row in pairs(self.tracks)do
  if now<row.first or now>row.ends then self.tracks[id]=nil;self.count=self.count-1 end
 end
end
function M:Missile(observer,owner,set,object,data,name,now)
 local definition=type(name)=='string'and(set[name]or set.__lower and set.__lower[name:lower()])
 local spec=definition and definition.landingZone
 if not spec then return false end
 -- Recognized carriers must never fall back to a harmful straight projectile.
 -- Exact reviewed non-tracking carriers use coherent motion at a fixed
 -- endpoint; native wrapper validity and target hints can be unreliable.
 if not observer:Allowed(owner,definition)or object.dead==true then return true end
 local pos,start,endpoint=object.pos,data.startPos,data.endPos
 local native=object.networkID or object.handle
 if not G.finite(native)or native<=0 or not G.point(pos)or not G.point(start)or not G.point(endpoint)
  or not G.finite(now)or not G.finite(spec.speed)or spec.speed<=0
  or not G.finite(data.speed)or math.abs(data.speed-spec.speed)>1
  or not G.finite(spec.radius)or spec.radius<=0 or not G.finite(spec.duration)or spec.duration<=0 then return true end
 local length=G.dist(start,endpoint);local remaining=G.dist(pos,endpoint)
 if length<1 or length>spec.maxTravel or remaining>length+20 or G.segment(pos,start,endpoint)>20 then return true end
 local id=tostring(owner.networkID)..':'..tostring(native);local row=self.tracks[id]
 if row and(row.owner~=data.owner or G.dist(row.start,start)>20 or G.dist(row.endpoint,endpoint)>1)then
  -- Keep the old possible ground hazard; a recycled object gets a fresh identity.
  self.tracks[id]=nil;self.count=self.count-1;row=nil
 end
 if not row then
  if self.count>=self.max then observer.threats.overflow=true;observer.threats.overflowUntil=math.max(observer.threats.overflowUntil or 0,now+spec.duration+1);return true end
  local arrival=now+remaining/spec.speed
  local launch=now-G.dist(start,pos)/spec.speed
  local damageID
  for _,prior in pairs(self.tracks)do
   if prior.owner==data.owner and prior.alias==definition.name and math.abs(prior.launch-launch)<=.15
    and G.dist(prior.start,start)<=150 then damageID=prior.damageID;break end
  end
  self.serial=self.serial+1;local unique='landing:'..id..':'..self.serial
  row={owner=data.owner,alias=definition.name,first=now,at=now,pos=G.copy(pos),start=G.copy(start),endpoint=G.copy(endpoint),
   arrival=arrival,launch=launch,ends=arrival+spec.duration+.1,id=unique,damageID=damageID or unique}
  self.tracks[id]=row;self.count=self.count+1;return true
 end
 if row.published or now<=row.at then return true end
 local dt=now-row.at;local moved=G.dist(row.pos,pos)
 local arrival=now+remaining/spec.speed
 if moved<=.001 then return true end
 if dt>.25 or math.abs(moved-spec.speed*dt)>math.max(30,spec.speed*dt*.3)
  or math.abs(arrival-row.arrival)>.08 or remaining>G.dist(row.pos,row.endpoint)+1 then
  row.at=now;row.pos=G.copy(pos);row.arrival=arrival;row.launch=now-G.dist(start,pos)/spec.speed
  row.ends=arrival+spec.duration+.1;return true
 end
 local threat={id=row.id,instanceID=row.damageID,stageID=row.id,damageID=row.damageID,casterID=owner.networkID,
  champion=owner.charName,profile=definition.profile,source=definition.source,ability=definition.id,abilityName=definition.name,
  evidence='observed',timingScope='observed-carrier-landing-envelope',shape='circle',origin=G.copy(row.endpoint),b=G.copy(row.endpoint),radius=spec.radius,
  starts=row.arrival-.08,ends=row.ends,persistent=true,blockable=false,parryable=false,ccUnknown=true,
  tier=definition.tier,zonePolicy=spec.zonePolicy,observedAt=row.first,castOrigin=G.copy(row.start)}
 if observer.threats:Observe(threat)then row.published=true;if observer.onThreat then observer.onThreat(threat)end end
 return true
end
return M

end
