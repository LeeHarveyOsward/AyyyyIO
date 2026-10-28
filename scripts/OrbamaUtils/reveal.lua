return function(require)
-- Reveal a fog point for a long-range ability (Xerath R, Jhin R, Karthus R,
-- a global ultimate on a hidden target): the ready reveal trinket that reaches
-- the point, else a ward when the point is within ward range. Placement,
-- consent, ownership and cleanup share the anchored request path.
local U=require('utils.util')
local Requests=require('utils.placement_requests')
local R={};R.__index=R
-- Normal: Farsight Alteration, 4000 cast range (wiki Farsight_Alteration, read
-- 2026-10-08). Classic: Farsight Orb (4000) and Scrying Orb (2500), the Season 4
-- blue trinkets, at ids 770000 + the era id (the documented Classic id rule in
-- CombatProfiles/world.lua; not yet seen live: an absent id simply never matches).
R.items={
 normal={{id=3363,range=4000}},
 classic={{id=773363,range=4000},{id=773342,range=2500}},
}
R.wardRange=600
function R.new(c)return setmetatable({c=c,requests=Requests.new(c,'reveal',6,12,4000)},R)end
function R:Available(position)
 local c=self.c;if c:blocked()then return nil,'unavailable'end
 local hero=c.g.myHero;local distance=position and U.dist(hero.pos,position)
 for _,row in ipairs(R.items[c.profile.id]or{})do
  if not distance or distance<=row.range then
   for slot=6,12 do local item=hero:GetItemData(slot)
    if item and item.itemID==row.id and c:ready(slot)and(c:spell(slot).currentCd or 0)==0 then
     return {slot=slot,itemID=row.id,range=row.range,kind='trinket'}
    end
   end
  end
 end
 if c.Wards and(not distance or distance<=R.wardRange)then
  local ward=c.Wards:Available()
  if ward then return {slot=ward.slot,itemID=ward.itemID,source=ward.source,range=R.wardRange,kind='ward'}end
 end
 return nil,'no_reveal_source'
end
function R:Request(position,options)
 return self.requests:Request(position,options,function()
  local resource,why=self:Available(position);if not resource then return nil,why end
  local slot,itemID=resource.slot,resource.itemID
  if resource.kind=='ward'then
   resource.ready=function()return self.c.Wards:Ready(slot,resource.source)end
  else
   resource.ready=function()local item=self.c.g.myHero:GetItemData(slot);return item and item.itemID==itemID and self.c:ready(slot)end
  end
  return resource
 end)
end
function R:Cancel(event,owner)return self.requests:Cancel(event,owner)end
return R

end
