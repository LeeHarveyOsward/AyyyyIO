return function(require)
local rules=require('evade.itemdata')
local M={}
function M.Install(app)
    local g=app.g;local h=g.myHero
    if type(h.GetItemData)~='function'or type(h.GetSpellData)~='function'then return end
    local function ready(slot,id)
        if not app:Available()or not app.permissions.items then return false end
        local utils=app.sdk.OrbamaUtils
        if not utils or not utils:active()or not utils.config:get('items')then return false end
        local item=h:GetItemData(slot);local spell=h:GetSpellData(slot)
        local rule=item and rules[item.itemID]
        local available=spell and g.Game.CanUseSpell(slot)==0 and (spell.currentCd or 0)<=0
        return rule and rule.profile==(h.charName:match('^Jade_')and 'classic'or 'normal')
            and item.itemID==id and app:DefenseReady('slot:'..slot,available),rule
    end
    app:RegisterDefense('stasis-items',{validated=true,source='research/evade/items/stasis-profiles.json',
        options=function(ctx)
            local options={}
            for slot=6,11 do
                local item=h:GetItemData(slot);local allowed,rule=ready(slot,item and item.itemID)
                if allowed then options[#options+1]={validated=true,profile=rule.profile,resource='slot:'..slot,
                    slot=slot,item=true,itemID=item.itemID,cost=80,
                    effect={kind='stasis',starts=ctx.now+.05,ends=ctx.now+rule.duration,
                        immobilizedUntil=ctx.now+.05+rule.duration}}
                end
            end
            return options
        end,
        prepare=function(option,ctx)
            if not ready(option.slot,option.itemID)then return end
            if not app.sdk.Actions:GetAvailability().available then return end
            local revision,terrainRevision=app.threats.revision,app.terrain.revision
            local result=app:EvaluateDefense(option,nil,ctx)
            if not app:DefenseUseful(result,ctx)or revision~=app.threats.revision or terrainRevision~=app.terrain.revision then return end
            local key=g['HK_ITEM_'..(option.slot-5)];if not key then return end
            local generation,expires=app.serial,app.clock()+20
            return {type='cast',key=key,resource=option.resource,expires=expires,utilityItem={slot=option.slot,id=option.itemID},
                mechanical=function()
                    return ready(option.slot,option.itemID)and revision==app.threats.revision
                        and terrainRevision==app.terrain.revision and generation==app.serial and app.clock()<=expires,'stasis_state_changed'
                end}
        end})
end
return M

end
