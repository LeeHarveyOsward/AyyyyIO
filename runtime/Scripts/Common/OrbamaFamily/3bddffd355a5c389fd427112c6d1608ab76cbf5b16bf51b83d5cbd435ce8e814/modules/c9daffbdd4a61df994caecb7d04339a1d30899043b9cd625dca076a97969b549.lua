return function(require)
local U=require('utils.util')
local World=require('CombatProfiles.world')
local W=require('ChampionMobility.wards')(U)
local Requests=require('utils.placement_requests')
local Service={};Service.__index=Service
function Service.new(c)
    local context=setmetatable({profile=World.wards[c.profile.id]},{__index=c})
    return setmetatable({c=c,requests=Requests.new(c,'ward',6,12,625),inventory=setmetatable({ctx=context,actions=c.actions},{__index=W})},Service)
end
function Service:Available(itemID)
    if self.c:blocked()then return nil,'unavailable'end
    local slot=self.inventory:slot(itemID)
    if not slot then return nil,'no_usable_ward'end
    local item=self.c.g.myHero:GetItemData(slot)
    local id=item and item.itemID
    return {slot=slot,itemID=U.finite(id)and id>0 and id<4294967295 and id%1==0 and id or nil,
        source=self.inventory:sourceIdentity(slot,item),at=self.c:now(),profile=self.c.profile.id}
end
function Service:Ready(slot,itemID)
    local item=self.c.g.myHero:GetItemData(slot)
    return not self.c:blocked()and(not itemID or self.inventory:sourceIdentity(slot,item)==itemID)
        and self.inventory:itemReady(slot,item)and self.inventory:hasCharges(slot,item)
end
function Service:FindNearby(pos,range,team)
    local game=self.c.g.Game;local found={}
    if not game.WardCount or not game.Ward then return found end
    for i=1,U.count(game.WardCount(),512)do
        local ward=game.Ward(i)
        if U.valid(ward)and(not team or ward.team==team)and U.dist(pos,ward.pos)<=range then found[#found+1]=ward end
    end
    return found
end
function Service:Request(position,options)
    return self.requests:Request(position,options,function(o)
        local available,why=self:Available(o.itemID);if not available then return nil,why end
        local slot,source=available.slot,available.source
        available.ready=function()
            local item=self.c.g.myHero:GetItemData(slot)
            return self.inventory:sourceIdentity(slot,item)==source and self.inventory:itemReady(slot,item,true)
                and self.inventory:hasCharges(slot,item)
        end
        return available
    end)
end
function Service:Cancel(event,owner)
    return self.requests:Cancel(event,owner)
end
return Service

end
