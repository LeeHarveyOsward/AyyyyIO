return function(require)
local U=require('utils.util')
local Profiles=require('CombatProfiles.flash')
local Requests=require('utils.placement_requests')
local F={};F.__index=F
function F.new(c)
 return setmetatable({c=c,profile=Profiles[c.profile.id],requests=Requests.new(c,'flash',4,5,400)},F)
end
function F:Available()
 local c=self.c;local p=self.profile
 if c:blocked()then return nil,'unavailable'end
 if not p or not p.verified then return nil,'flash_profile_unverified'end
 for slot=4,5 do local spell=c:spell(slot)
   if spell.name==p.name and not c.actions:SlotBusy(slot)and c:ready(slot)and U.finite(spell.mana)and spell.mana>=0 then
   return {slot=slot,range=p.displacement,profile=c.profile.id,name=p.name,source=p.source,at=c:now()}
  end
 end
 return nil,'no_usable_flash'
end
function F:Request(position,options)
 return self.requests:Request(position,options,function()
  local resource,why=self:Available();if not resource then return nil,why end
  local slot,name=resource.slot,resource.name
  resource.ready=function()
   local d=self.c:spell(slot)
   return self.profile.verified and d.name==name and self.c:ready(slot)and U.finite(d.mana)and d.mana>=0
  end
  return resource
 end)
end
function F:Cancel(event,owner)return self.requests:Cancel(event,owner)end
return F

end
