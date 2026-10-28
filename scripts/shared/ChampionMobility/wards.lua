return function(require)
return function(U)
local World=require('CombatProfiles.world')
local W={}
-- The owner's action layer says whether a cast on this slot is still in flight.
-- Lee Sin's exposes pendingCast, the shared Utils layer SlotBusy; a ward request
-- through Utils (every champion's ward jump) errored on the missing method.
local function busy(actions,slot)
    if type(actions.pendingCast)=='function' then return actions:pendingCast(slot) end
    if type(actions.SlotBusy)=='function' then return actions:SlotBusy(slot) end
    return false
end
local function number(value)
    return U.finite(value)and value>=0 and value%1==0 and value<4294967295 and value or nil
end
-- How this inventory item places a ward: 'charge', 'stack', 'stored', 'cooldown'
-- or nil. The profile's id table decides; an id it does not know is recognised
-- by its item-spell name (World.wardSpellKind) so a missing id cannot block a
-- jump, and is reported once so the table can be completed.
function W:wardKind(slot,item)
    local c=self.ctx;item=item or myHero:GetItemData(slot)
    local id=item and number(item.itemID)
    local kind=id and c.profile.wards[id];if kind then return kind,id end
    if World.wardExcluded[id] then return nil end
    local spell=c:spell(slot);local name=spell and spell.name
    local nativeID=type(name)=='string'and tonumber(name:match('^(%d+)Spell$'))
    local rank
    kind=nativeID and c.profile.wards[nativeID]
    if not kind then kind,rank=World.wardSpellKind(name)end
    if not kind then return nil end
    self.wardFallbacks=self.wardFallbacks or {}
    local key=id and id>0 and id or name
    if not self.wardFallbacks[key] then
        self.wardFallbacks[key]=name
        if type(c.log)=='function' then pcall(c.log,c,'ward_source_by_spell_name',{item=id,spell=name,kind=kind,slot=slot}) end
    end
    return kind,nativeID or(id and id>0 and id or nil),rank
end
function W:sourceIdentity(slot,item)
    local kind,id=W.wardKind(self,slot,item)
    if not kind then return nil end
    return id or('spell:'..self.ctx:spell(slot).name)
end
-- Charges without trusting one host field. The host reports them in the
-- inventory ammo, the stack count or the item spell's ammo and leaves the others
-- at zero (live 2026-10-08: itemAmmo was 0 for every item, the trinket's charge
-- was in the spell ammo and a ward's in its stacks). A single inventory item
-- also reports one stack, so the stack count only counts where it is the
-- charge: purchased ward stacks and the Sightstone-type items of this profile.
function W:wardCharges(slot,item,kind)
    local c=self.ctx;item=item or myHero:GetItemData(slot)or{}
    local d=c:spell(slot) or {}
    -- An empty inventory row contradicting a native ward spell is unavailable
    -- inventory data. Its zero fields do not establish an empty ward stack.
    local id=number(item.itemID);local inventory=id and id>0
    local itemAmmo=inventory and number(item.ammo)or nil
    local spellAmmo=number(d.ammo)
    local stacks,stackCount
    if inventory and(kind=='stack' or c.profile.wardInventoryCharges and c.profile.wardInventoryCharges[id])then
        stacks=number(item.stacks);stackCount=number(item.stackCount)
    end
    return math.max(itemAmmo or 0,spellAmmo or 0,stacks or 0,stackCount or 0),
        itemAmmo~=nil or spellAmmo~=nil or stacks~=nil or stackCount~=nil
end
function W:itemReady(slot,item,owned)
    local c=self.ctx;item=item or myHero:GetItemData(slot)
    local kind,id=self:wardKind(slot,item);if not kind then return false end
    local d=c:spell(slot)
    if (d.currentCd or 0)>0 or busy(self.actions,slot) and not owned then return false end
    local inventory=c.profile.wardInventoryCharges and c.profile.wardInventoryCharges[id]
    -- An empty Sightstone is refused before the host's readiness is consulted.
    local charges,known=self:wardCharges(slot,item,kind)
    if inventory and known and charges<=0 then return false end
    if c:ready(slot) then return true end
    -- The host's item readiness can stay non-zero for a Classic Sightstone or
    -- ward stack that has charges; do not let it veto that representation.
    if inventory or c.profile.id=='classic' and kind=='stack' then
        return d.currentCd==0 and charges>0 and (owned or not busy(self.actions,slot))
    end
    return false
end
function W:hasCharges(slot,item)
    item=item or myHero:GetItemData(slot)
    local kind=self:wardKind(slot,item);if not kind then return false end
    -- A cooldown item (Wriggle's Lantern) is ready by its cooldown alone.
    if kind=='cooldown'then return true end
    local charges,known=self:wardCharges(slot,item,kind)
    return known and charges>0 or not known and self:itemReady(slot,item)
end
-- Which ready source is spent first (World.wardRank): the free trinket charge,
-- then Sightstone-type charges, cooldown items, purchased sight wards and, only
-- when nothing cheaper exists, a Control / Vision ward.
function W:slot(itemID)
    local c=self.ctx;local best,bestRank=nil,math.huge
    for slot=6,12 do
        local item=myHero:GetItemData(slot);local kind,id,nativeRank=self:wardKind(slot,item)
        if kind and (not itemID or W.sourceIdentity(self,slot,item)==itemID) and self:itemReady(slot,item) and self:hasCharges(slot,item) then
            local rank=nativeRank or World.wardRank(c.profile,id,kind)
            if rank<bestRank then best,bestRank=slot,rank end
        end
    end
    return best
end
-- Placed ward objects: which unit names are wards, and which of them an ally
-- can jump to (World.wardObject / World.wardJumpable).
function W.isWardObject(unit) return World.wardObject(unit and unit.charName) end
function W.wardJumpable(unit) return World.wardJumpable(unit and unit.charName) end

return W
end

end
