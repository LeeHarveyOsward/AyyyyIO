return function(require)
-- Shared mechanical predicates; gameplay extensions are registered in each champion module.
-- Does not execute a decision method, enumerate alternative targets, or start timers.
return function(C,q,slot,options)
    local e=C.env;local h=e.myHero;local object=C.champion
    local letter=({[0]='Q',[1]='W',[2]='E',[3]='R'})[slot]
    local spell=letter and (object[letter..'Spell'] or object[letter])
    if not q.range and letter then q.range=type(spell)=='table' and spell.Range or object[letter..'Range'] end
    -- A cast range of 0 is the data's way of saying "centred on the caster"
    -- (Malphite E, Amumu E and R, Sona W, Twitch E). It is not a reach of zero:
    -- the champion's own geometry check decides who is hit. Treating it as a
    -- limit rejected every such cast that named a target.
    if type(q.range)=='number' and q.range<=0 then q.range=nil end
    local method=q.owner
    local menu=e.Menu and (e.Menu[method] or e.Menu[method:lower()])
    if (method=='LaneClear' or method=='JungleClear') and e.Menu.Clear then menu=e.Menu.Clear[method] or e.Menu.Clear end
    if method=='FarmHarass' then menu=e.Menu.Harass end
    local function value(t,k)return t and t[k] and t[k].Value and t[k]:Value() end
    -- A transformed ability can retain its physical slot while using another
    -- menu setting. Capture the selected stage at request time; stamp/readiness
    -- checks still reject a subsequent spell-stage change.
    local setting=letter
    if letter and type(object.SpellMenuKey)=='function'then
        local key=object:SpellMenuKey(slot,q.spellName)
        if type(key)=='string'and value(menu,key)~=nil then setting=key end
    end
    return function(resolved)
        if options.validate then
            local valid,reason=options.validate(q,resolved)
            if not valid then return false,reason or 'spell_condition_changed' end
        end
        if letter then
            if value(menu,setting)==false or value(menu,'Enabled')==false then return false,'disabled'end
            local mana=value(menu,'Mana')
            if type(mana)=='number' and h.maxMana>0 and h.mana/h.maxMana*100<mana then return false,'mana_policy'end
            -- Recasts may have already paid their start cost. The host remains the mechanical readiness authority.
            -- `range` bounds the cast point; `objectRange` (default: the same) bounds the intent target, for a
            -- cast whose point is not on the target (a dash landing, a blast placed at its edge).
            if q.object and q.range and not(q.kind=='world'and q.prediction and q.prediction.object.FogObservation)
                and e.GetDistance(q.object.pos,h.pos)>(q.objectRange or q.range)then return false,'target_out_of_range'end
            if q.target and q.kind=='world' and q.range and e.GetDistance((resolved and resolved.position)or q.target,h.pos)>q.range then return false,'point_out_of_range'end
        end
        if method=='KillSteal' and q.object and letter and object['Get'..letter..'Dmg'] then
            local kind=C.policy and C.policy.damageTypes and C.policy.damageTypes[letter]
            if not kind then return false,'kill_damage_type_undeclared'end
            local shield=kind=='physical' and (q.object.shieldAD or 0) or kind=='magical' and (q.object.shieldAP or 0)
                or kind=='mixed' and ((q.object.shieldAD or 0)+(q.object.shieldAP or 0))
            if shield==nil or shield==false then return false,'kill_damage_type_unsupported'end
            local damage=object['Get'..letter..'Dmg'](object,q.object)
            if C.policy.killBonus then damage=damage+C.policy.killBonus(object,q,slot)end
            if damage<q.object.health+(q.object.hpRegen or 0)+shield then return false,'kill_threshold_changed'end
        end
        if C.policy and C.policy.validate then return C.policy.validate(object,q,slot,resolved)end
        return true
    end
end

end
