return function(require)
-- Forecasts consume identified effects, never generic getdmg(slot) guesses.
local G=require('evade.geometry')
local D={}
function D.resistance(value,percent,flat)
    if not G.finite(value)then return nil end
    if percent~=nil and (not G.finite(percent)or percent<0 or percent>1)
      or flat~=nil and (not G.finite(flat)or flat<0)then return nil end
    if value<0 then return 2-100/(100-value)end
    return 100/(100+math.max(0,value*(1-(percent or 0))-(flat or 0)))
end
function D.amount(effect,stats)
    if type(effect)~='table'then return nil,'damage_unknown'end
    if effect.components~=nil then return nil,'damage_basis_unknown'end
    if effect.mitigated~=nil then
        if effect.kind~='physical'and effect.kind~='magical'and effect.kind~='true'then return nil,'damage_type_unknown'end
        if effect.raw~=nil or not G.finite(effect.mitigated)or effect.mitigated<0 then return nil,'damage_basis_unknown'end
        return effect.mitigated
    end
    if not G.finite(effect.raw)or effect.raw<0 then return nil,'damage_unknown'end
    if effect.kind=='true' then return effect.raw end
    if type(stats)~='table'then return nil,'damage_stats_unknown'end
    local multiplier=stats.damageMultiplier
    if multiplier==nil then multiplier=1 end
    if not G.finite(multiplier)or multiplier<0 then return nil,'damage_modifier_unknown'end
    local resist=effect.kind=='physical'and stats.armor or effect.kind=='magical'and stats.magicResist
    if resist==nil then return nil,'damage_type_unknown'end
    local scale=D.resistance(resist,effect.percentPen,effect.flatPen)
    if not scale then return nil,'damage_modifier_unknown'end
    local amount=effect.raw*scale*multiplier
    if not G.finite(amount)or amount<0 then return nil,'damage_overflow'end
    return amount
end
-- Optional absent pools mean none under the public forecast contract.
-- Invalid observed pools confer no protection and retain uncertainty.
local function pool(value,result,integer)
    if value==nil then return 0 end
    if not G.finite(value)or value<0 or integer and value~=math.floor(value)then
        result.unknown=true;result.reason='protection_amount_unknown';return 0
    end
    return value
end
function D.forecast(hits,stats,defense)
    if type(stats)~='table'then return {damage=0,cc=0,unknown=true,lethal=false,hits={},reason='damage_stats_unknown'}end
    local health=stats.health
    local result={damage=0,cc=0,unknown=false,lethal=false,hits={},health=health}
    if not G.finite(health)then result.unknown=true;return result end
    local general,physical,magic=pool(stats.shield,result),pool(stats.physicalShield,result),pool(stats.magicShield,result)
    local spellShield=pool(stats.spellShieldCharges,result,true)
    if defense~=nil and type(defense)~='table'then result.unknown=true;defense=nil end
    local defenseWindow=defense and G.finite(defense.starts)and G.finite(defense.ends)
        and defense.ends>defense.starts
    if defense and not defenseWindow then result.unknown=true end
    local protectionUntil=stats.invulnerableUntil
    if protectionUntil~=nil and not G.finite(protectionUntil)then
        result.unknown=true;protectionUntil=nil
    end
    local shield,shieldValid=0,false
 if defense and defense.kind=='shield'then
  shieldValid=G.finite(defense.amount)and defense.amount>=0
   and G.finite(defense.starts)and G.finite(defense.ends)and defense.ends>defense.starts
   and (defense.shieldType=='all'or defense.shieldType=='physical'or defense.shieldType=='magical')
  if shieldValid then shield=defense.amount else result.unknown=true end
  result.defenseShieldUsed=0
 end
 local reductions, reductionValid
 if defense and defense.kind=='reduction'then
  reductions=defense.fractions
  reductionValid=defenseWindow and type(reductions)=='table'and reductions['true']==nil
   and (reductions.physical~=nil or reductions.magical~=nil)
  if reductionValid then for kind,value in pairs(reductions)do
   if (kind~='physical'and kind~='magical')or not G.finite(value)or value<0 or value>1 then reductionValid=false;break end
  end end
  if not reductionValid then result.unknown=true end
  result.defenseDamageReduced=0
 end
 -- Staged reduction (Meditate: a stronger first part): contiguous stages tiling the window.
 local stages
 if reductionValid and defense.stages~=nil then
  stages=defense.stages
  local ok=type(stages)=='table'and #stages>=1 and #stages<=4 and stages[1].starts==defense.starts and stages[#stages].ends==defense.ends
  for i=1,ok and #stages or 0 do local st=stages[i]
   if type(st)~='table'or not G.finite(st.starts)or not G.finite(st.ends)or st.ends<=st.starts
    or i>1 and st.starts~=stages[i-1].ends or type(st.fractions)~='table'or st.fractions['true']~=nil then ok=false;break end
   for kind,value in pairs(st.fractions)do
    if (kind~='physical'and kind~='magical')or not G.finite(value)or value<0 or value>1 then ok=false;break end
   end
   if not ok then break end
  end
  if not ok then reductionValid=false;stages=nil;result.unknown=true end
 end
 -- The smallest reduction of every stage the hit interval touches (an uncertain arrival keeps the weaker one).
 local function fraction(kind,at,latest)
  if not stages then return reductions[kind]end
  local value
  for _,st in ipairs(stages)do
   if latest>=st.starts and at<st.ends then
    local v=st.fractions[kind]or 0;if value==nil or v<value then value=v end
   end
  end
  return value
 end
 -- Flat armor / magic resist for the window (converted per damage type through the resistance formula).
 local resistStats,resistValid
 if defense and defense.kind=='resist'then
  local a,m=defense.armor or 0,defense.magicResist or 0
  resistValid=defenseWindow and G.finite(a)and G.finite(m)and a>=0 and m>=0 and a+m>0
  if resistValid then
   resistStats={};for k,v in pairs(stats)do resistStats[k]=v end
   resistStats.armor=G.finite(stats.armor)and stats.armor+a or stats.armor
   resistStats.magicResist=G.finite(stats.magicResist)and stats.magicResist+m or stats.magicResist
  else result.unknown=true end
 end
 -- An own heal lands at `starts` (capped at missing health); bonus health (bonus=true) raises the
 -- maximum instead and is gone at `ends`. Neither changes control or protects from a hit.
 local healPending,bonusLeft
 if defense and defense.kind=='heal'then
  local amount=defense.amount
  if defenseWindow and G.finite(amount)and amount>=0 and(defense.bonus==true or G.finite(stats.maxHealth)and stats.maxHealth>0)then
   healPending=amount
  else result.unknown=true end
  result.defenseHealed=0
 end
 local directionalValid
 if defense and defense.kind=='directional_block'then
  local f,c=defense.facing,defense.center
  directionalValid=defenseWindow and type(f)=='table'and G.finite(f.x)and G.finite(f.z)and math.abs(f.x*f.x+f.z*f.z-1)<.01
   and G.point(c)and G.finite(defense.angle)and defense.angle>0 and defense.angle<=360
  if not directionalValid then result.unknown=true end
 end
 -- The hit comes from inside the blocked cone in front of the hero (source: caster or launch point).
 local function frontal(source)
  if not directionalValid or not G.point(source)then return false end
  local dx,dz=source.x-defense.center.x,source.z-defense.center.z;local length=math.sqrt(dx*dx+dz*dz)
  if length<1 then return false end
  return (dx*defense.facing.x+dz*defense.facing.z)/length>=math.cos(math.rad(defense.angle/2))-1e-9
 end
 local ordered={}
    if type(hits)~='table'or #hits>4096 then result.unknown=true;result.reason='invalid_hit_list';return result end
    local indexed={}
    for _,h in ipairs(hits)do
        local identity=type(h)=='table'and (h.damageID or h.id)
        if not identity or (type(identity)~='string'and type(identity)~='number')
        or type(identity)=='number'and not G.finite(identity)or not G.finite(h.at)
        or h.atLatest~=nil and (not G.finite(h.atLatest)or h.atLatest<h.at)then
            result.unknown=true;result.reason='invalid_hit_interval';return result
        end
        local index=indexed[identity]
        if index then
            local previous=ordered[index]
            local first,last=math.min(previous.at,h.at),math.max(previous.atLatest or previous.at,h.atLatest or h.at)
            local merged={id=previous.id,damageID=identity,abilityName=previous.abilityName,champion=previous.champion,at=first,atLatest=last,damage=previous.damage,
                tier=math.max(previous.tier or 0,h.tier or 0),wallBlocked=previous.wallBlocked==true and h.wallBlocked==true or nil,
                cc=previous.cc,ccUnknown=previous.ccUnknown,ccHard=previous.ccHard,blockable=previous.blockable,parryable=previous.parryable,
                untargetableBlockable=previous.untargetableBlockable==true and h.untargetableBlockable==true,
                basicAttack=previous.basicAttack==true and h.basicAttack==true or nil,sourcePos=previous.sourcePos,
                alreadyApplied=previous.alreadyApplied or h.alreadyApplied,externalCounted=previous.externalCounted or h.externalCounted}
            if previous.damage~=h.damage and (D.amount(previous.damage,stats)~=D.amount(h.damage,stats)
            or type(previous.damage)~='table'or type(h.damage)~='table'
            or previous.damage.kind~=h.damage.kind or previous.damage.uncertain~=h.damage.uncertain
            or previous.damage.components~=h.damage.components)
            or previous.cc~=h.cc or previous.ccUnknown~=h.ccUnknown or (previous.ccHard==true)~=(h.ccHard==true)
            or previous.blockable~=h.blockable or previous.abilityName~=h.abilityName or previous.champion~=h.champion
            or previous.parryable~=h.parryable or previous.untargetableBlockable~=h.untargetableBlockable then result.unknown=true;result.identityConflict=true end
            ordered[index]=merged
        else
            ordered[#ordered+1]=h;indexed[identity]=#ordered
        end
    end
    table.sort(ordered,function(a,b)return a.at<b.at or a.at==b.at and tostring(a.id)<tostring(b.id)end)
    local latestEnd,latestStart
    for _,h in ipairs(ordered)do
        local last=h.atLatest or h.at
        if latestEnd and h.at<=latestEnd and (last>h.at or latestEnd>latestStart)then result.orderUncertain=true end
        if not latestEnd or last>latestEnd then latestEnd=last;latestStart=h.at end
    end
    local seen={}
    for _,h in ipairs(ordered)do
        local id=h.damageID or h.id
        if not seen[id] and not h.alreadyApplied and not h.externalCounted then
            seen[id]=true;local blocked=false;local damageBlocked=false
            local latest=h.atLatest or h.at
            -- A heal is a moment, not a protection window.
            local windowed=defenseWindow and defense.kind~='heal'
            local inside=windowed and h.at>=defense.starts and latest<defense.ends
            local overlaps=windowed and latest>=defense.starts and h.at<defense.ends
            if healPending and h.at>=defense.starts then
                local amount=healPending;healPending=nil
                if defense.bonus~=true then amount=math.max(0,math.min(amount,stats.maxHealth-health))else bonusLeft=amount end
                health=health+amount;result.defenseHealed=amount
            end
            -- Bonus health may already be gone when this hit lands: it does not count for it.
            if bonusLeft and latest>=defense.ends then health=health-bonusLeft;bonusLeft=nil end
            if latest>h.at then result.timingUncertain=true end
            -- An interval touching the expiry boundary is not fully protected.
            -- Partial overlap retains unprotected damage and explicit uncertainty.
            local partial=overlaps and not inside
            if protectionUntil and latest<protectionUntil then blocked=true
            elseif protectionUntil and h.at<protectionUntil then result.unknown=true;result.protectionUncertain=true end
            -- The planner certified that this projectile crosses the standing wall first.
            if defense and defense.kind=='windwall'and h.wallBlocked==true then blocked=true end
            if inside and defense.kind~='shield'then
                if defense.kind=='invulnerable' or defense.kind=='stasis'then blocked=true end
                if defense.kind=='untargetable'and h.untargetableBlockable==true then blocked=true end
                if defense.kind=='damageImmune'then damageBlocked=true end
                if defense.kind=='parry'and h.parryable then blocked=true end
                if defense.kind=='attack_dodge'and h.basicAttack==true then blocked=true end
                if defense.kind=='directional_block'and frontal(h.sourcePos)then
                    if defense.blocksControl==true then blocked=true else damageBlocked=true end
                end
                if defense.kind=='spellShield'and h.blockable and not blocked and not defense.consumed then
                    blocked=true
                    local damage=h.damage;local amount=type(damage)=='table'and D.amount(damage,stats)or nil
                    local components=type(damage)=='table'and damage.components
                    if components~=nil then
                        amount=nil
                        if type(components)=='table'and #components>0 and #components<=8 and damage.raw==nil and damage.mitigated==nil then
                            amount=0
                            for _,part in ipairs(components)do local value=D.amount(part,stats)
                                if value==nil or part.uncertain then amount=nil;break end;amount=amount+value
                            end
                        end
                    end
                    if type(damage)=='table'and damage.uncertain then amount=nil end
                    if not G.finite(amount)or amount<0 then amount=nil end
                    result.blockedSpell={id=h.id,damageID=id,abilityName=h.abilityName,champion=h.champion,at=h.at,atLatest=latest,damage=amount,
                        ccHard=h.ccHard==true or G.finite(h.cc)and h.cc>0,
                        ccKnown=not h.ccUnknown and G.finite(h.cc)and h.cc>=0}
                    defense={kind='spent',starts=0,ends=0}
                end
            end
            if not blocked and spellShield>0 and h.blockable then spellShield=spellShield-1;blocked=true end
            if not blocked then
    if partial then result.unknown=true;result.protectionUncertain=true end
                local shieldActive=shieldValid and inside;local immuneShield=shield
                if not damageBlocked then
     local damage=type(h.damage)=='table'and h.damage or nil
                    if damage and damage.uncertain then result.unknown=true;if shieldActive then shield=0 end end
                    local components=damage and damage.components
                    local mixed=components~=nil
                    local count=mixed and type(components)=='table'and #components or 1
                    local valid=not mixed or type(components)=='table'and count>0 and count<=8
                        and damage.raw==nil and damage.mitigated==nil
                    if not valid then result.unknown=true;if shieldActive then shield=0 end else
                        for index=1,count do
                            local component=mixed and components[index]or damage
                            local amount=D.amount(component,inside and resistStats or stats)
                            if amount==nil then result.unknown=true;if shieldActive then shield=0 end else
                                if component.uncertain then result.unknown=true;if shieldActive then shield=0 end end
                                local kind=component.kind
                                local share=inside and reductionValid and fraction(kind,h.at,latest)
                                if share then
                                 local reduced=amount*share;amount=amount-reduced
                                 result.defenseDamageReduced=result.defenseDamageReduced+reduced
                                end
                                local typed=kind=='physical'and physical or kind=='magical'and magic or 0
                                local used=math.min(typed,amount);amount=amount-used
                                if kind=='physical'then physical=physical-used elseif kind=='magical'then magic=magic-used end
        used=math.min(general,amount);general=general-used;amount=amount-used
        -- Existing shield pools have no expiry attribution. Consume them first
        -- rather than assume the temporary defense preserves them for later hits.
        if shieldActive and (defense.shieldType=='all'or defense.shieldType==kind)then
         used=math.min(shield,amount);shield=shield-used;amount=amount-used
         result.defenseShieldUsed=result.defenseShieldUsed+used
        end
        result.damage=result.damage+amount;health=health-amount
        -- Basic-attack damage is reported apart: alone it never reaches the damage share (dash_adapter.Trigger).
        if h.basicAttack==true then result.attackDamage=(result.attackDamage or 0)+amount end
                            end
                            if health<=0 then break end
                        end
                    end
                end
                if G.finite(h.tier)and h.tier>(result.tier or 0)then result.tier=h.tier end
                local cc=h.cc;if cc==nil then cc=0 end
                -- A shield that also grants control immunity (ccImmune) removes this hit's
                -- control while it stood at the moment of contact.
                local immune=shieldActive and defense.ccImmune==true and immuneShield>0
            local invalidCC=not G.finite(cc)or cc<0
            if immune then cc=0;invalidCC=false end
            if invalidCC then cc=0;result.unknown=true end
            result.cc=result.cc+cc
            local ccUnknown=not immune and(h.ccUnknown or invalidCC or damageBlocked and h.cc==nil)
            if ccUnknown then result.ccUnknown=true end
            -- Hard control: a known positive duration, or reviewed hard control whose
            -- duration is unknown (ccHard: hooks, pulls, knockbacks). Adds no duration.
            local hard=not immune and(h.ccHard==true or cc>0)
            if hard then result.ccHard=true end
            if not damageBlocked or cc>0 or ccUnknown or hard then result.hits[#result.hits+1]=h.id end
            end
            if health<=0 then result.lethal=true;break end
        end
    end
    if result.orderUncertain and #result.hits>0 then result.unknown=true end
    result.health=health;return result
end
return D

end
