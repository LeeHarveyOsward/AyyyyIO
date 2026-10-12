return function(require)
-- Shared finite, anchored placement requests. Resource selection and readiness
-- remain in each service; consent, ownership, dispatch and cleanup share a path.
local U=require('utils.util')
local R={};R.__index=R
function R.new(c,name,first,last,maxRange)
 return setmetatable({c=c,name=name,first=first,last=last,maxRange=maxRange,requests=setmetatable({},{__mode='k'})},R)
end
function R:Request(position,options,lookup)
 options=options or {};local owner=options.owner;local label=self.name
 if type(owner)~='string'or owner==''or type(options.authorized)~='function'or type(options.validate)~='function'then
  return false,'explicit_'..label..'_permission_required'
 end
 local range=options.range
 if not U.finite(range)or range<=0 or range>self.maxRange or not position
  or not U.finite(position.x)or not U.finite(position.z)or position.y~=nil and not U.finite(position.y)
  or options.expires~=nil and not U.finite(options.expires)then return false,'invalid_'..label..'_geometry'end
  for slot=self.first,self.last do local event=self.c.actions:SlotEvent(slot)
  if event and self.requests[event]==owner then return false,label..'_request_pending'end
 end
 local resource,why=lookup(options);if not resource then return false,why end
 if resource.range and range>resource.range then return false,'invalid_'..label..'_geometry'end
 local aim=U.copy(position);local authorize,mechanical=options.authorized,options.validate
 local function yes(fn,...)local ok,value=pcall(fn,...);return ok and value==true end
 local function validate(resolved)
  local pos=resolved and resolved.position or aim
  return yes(authorize)and pos and U.finite(pos.x)and U.finite(pos.z)and(pos.y==nil or U.finite(pos.y))
   and U.dist(self.c.g.myHero.pos,pos)<=range and yes(mechanical,U.copy(pos))
 end
 if self.c:blocked()or not resource.ready()or not validate()then return false,label..'_plan_rejected'end
 local caps=self.c.actions.capabilities;local resolved=caps.resolveWorldTarget==true and not options.handoff
 local prepared=resolved and caps.prevalidateWorldCast==true and not options.dependency
 local accepted,event=self.c.actions:cast(resource.slot,U.copy(aim),label..':'..owner,{
  kind='world',context=options.context,priority=options.priority or 'interactive',
  evadeCompatible=options.evadeCompatible,reservation=options.reservation,
   dependency=options.dependency,dependencyGrant=options.dependencyGrant,dependencyState=options.dependencyState,handoff=options.handoff,
  prevalidateWorldCast=prepared,resolve=resolved and function()return {position=U.copy(aim)}end or nil,
  commitGuard=prepared and function()return not self.c:blocked()and yes(authorize)end or nil,
  ttl=250,expires=options.expires,readiness=resource.ready,validate=validate})
 if accepted then self.requests[event]=owner;event.target=U.copy(aim)end
 return accepted,event
end
function R:Cancel(event,owner)
 if type(owner)~='string'or owner==''or not event or self.requests[event]~=owner
  or self.c.actions.events[event.id]~=event then return false,'not_owned_'..self.name..'_request'end
 self.requests[event]=nil
 return self.c.actions.client:Cancel(event.id,self.name..'_plan_cancelled')
end
return R

end
