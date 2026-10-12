return function(require)
local U=require('utils.util')
local data=require('utils.itemdata')
local A={};A.__index=A
local cc={[5]=true,[7]=true,[8]=true,[9]=true,[10]=true,[12]=true,[22]=true,[23]=true,[25]=true,[26]=true,[29]=true,[35]=true}
local allyCC={[5]=true,[7]=true,[8]=true,[9]=true,[11]=true,[12]=true,[22]=true,[23]=true,[29]=true}
local healing={regenerationpotion=true,healthpotion=true,item2003=true,itemcrystalflask=true,
    itemminiregenpotion=true,itemdarkcrystalflask=true,crystalflask=true}
function A.new(c)return setmetatable({c=c,claims={}},A)end
-- The app's per-instant item read (one native read per slot per game time).
local function itemAt(c,slot)if c.item then return c:item(slot)end;return c.g.myHero:GetItemData(slot)end
function A:CC(unit,summoner)
    local c=self.c;local found=false
    if not unit.GetBuff then return false end
    for i=0,U.count(unit.buffCount or 0,256)do
        local b=unit:GetBuff(i)
        if b and(b.count or 0)>0 and(U.buffEnd(b)or c:now()+1)>c:now()+.15 then
            if b.type==30 or b.type==31 then return false end
            if cc[b.type]and(not summoner or b.type~=25)then found=true end
        end
    end
    return found
end
function A:Claim(name,want)
    if self.claims[name]==want then return want end
    local ok,why=self.c.actions.client:Claim(name,want)
    -- Releasing a claim this scope never held is already the desired state.
    if ok or not want and why=='not_owner' then self.claims[name]=want end
    return ok and want
end
function A:Request(slot,target,options)
    options=options or {};local c=self.c
    if slot<4 or slot>12 then return false,'not_a_utility_resource'end
    local function allowed()
        if slot>=6 and not c.config:get('items')then return false,'items_disabled'end
        if slot<6 and U.name(c:spell(slot).name)=='summonerdot'and not c.config:get('ignite')then return false,'ignite_disabled'end
        if options.offensive and not c.config:get('offense')then return false,'offensive_items_disabled'end
        local item=slot>=6 and itemAt(c,slot);local rule=item and data[c.profile.id][item.itemID]
        if rule and rule.allyCleanse and not c.config:get('cleanse')then return false,'ally_cleanse_disabled'end
        if rule and rule.cleanse and not self:Claim('qss',c.config:get('cleanse')==true)then return false,'qss_owned_elsewhere'end
        if slot<6 and U.name(c:spell(slot).name)=='summonerboost'
            and not self:Claim('cleanse',c.config:get('cleanse')==true)then return false,'cleanse_owned_elsewhere'end
        if rule then for _,flag in ipairs({'cleanse','shield','stasis'})do
            if rule[flag]and not c.config:get(flag)then return false,flag..'_disabled'end
        end end
        if item and data.potions[c.profile.id][item.itemID]and not c.config:get('potions')then return false,'potions_disabled'end
        return true
    end
    local yes,why=allowed();if not yes then return false,why end
    local validate=options.validate
    local request={};for k,v in pairs(options)do request[k]=v end
    request.validate=function(resolved)local ok,reason=allowed();if not ok then return false,reason end;return not validate or validate(resolved)end
    return c.actions:cast(slot,target,options.owner or 'activator',request)
end
function A:Submit(intent,slot,options)
    options=options or {}
    local ok,event=self:Request(slot,intent.target,{owner=options.owner or intent.owner,
        priority=intent.priority,context=intent.context,kind=intent.kind,resolve=intent.resolve,
        validate=intent.mechanical,expires=intent.expires,reservation=intent.reservation,
        offensive=options.offensive,allowChannel=options.allowChannel})
    if ok then return event.id,self.c.actions.client end
    return nil,event
end
function A:Evade(intent,slot,id)
    local c=self.c
    if not c.config:get('items')then return nil,'items_disabled'end
    local validate=intent.mechanical
    local ok,event=self:Request(slot,nil,{owner='evade',urgent=true,priority='critical',evadeCompatible=true,
        expires=intent.expires,reservation=intent.reservation,allowChannel=true,
        validate=function()
            return c.g.myHero:GetItemData(slot).itemID==id and c.config:get('items')and validate()
        end})
    if not ok then return nil,event end
    return event.id,'requested',c.actions:ConsumerHandle(event)
end
-- Clearing camps: a living jungle monster within 900 and no enemy champion within
-- 1200. Camp damage is steady and predictable, so the potion threshold there is
-- its own (potionJungleHP; 85 as in the ancestor LHO r84's jungle potions); every
-- other context, fights included, keeps potionHP.
function A:Clearing()
    local c=self.c;local h=c.g.myHero
    if c:threats(h.pos,1200)>0 then return false end
    for _,m in ipairs(c.minions or {})do if m.team==300 and U.valid(m)and U.dist(h.pos,m.pos)<900 then return true end end
    return false
end
function A:PotionThreshold()return self:Clearing()and self.c.config:get('potionJungleHP')or self.c.config:get('potionHP')end
function A:Potion(slot)
    local c=self.c;local h=c.g.myHero;local item=itemAt(c,slot)
    local rule=item and data.potions[c.profile.id][item.itemID]
    if not rule or not c.config:get('potions')or U.hp(h)>self:PotionThreshold()or c:recalling()
        or U.buff(h,healing,c:now())or h.maxHealth-h.health<rule.heal*.8 then return false end
    local d=c:spell(slot);local count=rule.charge and math.max(d.ammo or 0,item.ammo or 0,
        c.profile.id=='classic'and U.stackCount(item)or 0)or U.stackCount(item)
    return count>0 and c:ready(slot)
end
function A:Shield(range)
    local c=self.c;local h=c.g.myHero
    if U.hp(h)<=c.config:get('shieldHP')and c:threats(h.pos,700)>0 then return true end
    for _,ally in ipairs(c.allies)do
        if U.valid(ally)and U.dist(h.pos,ally.pos)<=range and U.hp(ally)<=c.config:get('shieldHP')and c:threats(ally.pos,700)>0 then return true end
    end
    return false
end
function A:AllyCleanse(slot,ally)
    local c=self.c;local range=c:spell(slot).range
    if not c.config:get('cleanse')or not U.valid(ally)or ally.team~=c.g.myHero.team
        or not U.finite(range)or range<=0 or range>1500 or U.dist(c.g.myHero.pos,ally.pos)>range then return false end
    -- Use only host-observed range. No modern value is borrowed for Classic.
    for i=0,U.count(ally.buffCount or 0,256)do
        local b=ally.GetBuff and ally:GetBuff(i)
        if b and allyCC[b.type]and(b.count or 0)>0 and(U.buffEnd(b)or 0)>c:now()+.15 then return true end
    end
    return false
end
function A:Tick()
    local c=self.c;local enabled=not c:blocked();local cleanse=enabled and c.config:get('cleanse')
    self:Claim('cleanse',cleanse==true);self:Claim('qss',cleanse and c.config:get('items')==true or false)
    if not enabled then return end
    if c.config:get('offense')then
        local shared=c.sdk.SharedData
        local attack=shared and shared.GetAttack and shared:GetAttack()
        local ended=attack and attack.castEndTime
        if type(ended)=='number'and ended>0 and ended<=c:now()and c:now()-ended<.3 then c.lastAttackFinished=ended end
        if not c.g.AyyyyIO and not c.classicActivator then
            local mode=c.sdk.ORBWALKER_MODE_COMBO
            if mode and c.sdk.Orbwalker.Modes[mode]then
                local target=c.sdk.TargetSelector:GetTarget(1000,c.sdk.DAMAGE_TYPE_PHYSICAL)
                if target then self:Offense(target,{modes={mode}})end
            end
        end
    end
    if not c.classicActivator and c.config:get('summonerDefense')then
        for slot=4,5 do
            local name=U.name(c:spell(slot).name)
            if name=='summonerheal'or name=='summonerbarrier'then
                local function useful()return c.config:get('summonerDefense')and U.hp(c.g.myHero)<25 and self:Threat()end
                if useful()then self:Request(slot,nil,{owner='summoner_defense',urgent=true,validate=useful})end
            end
        end
    end
    if cleanse and self.claims.cleanse then
        for slot=4,5 do
            if U.name(c:spell(slot).name)=='summonerboost'and c:ready(slot)and self:CC(c.g.myHero,true)then
                self:Request(slot,nil,{owner='cleanse',urgent=true,validate=function()
                    return self.claims.cleanse and c.config:get('cleanse')and self:CC(c.g.myHero,true)
                end})
            end
        end
    end
    if not c.config:get('items')then return end
    local rules,potions=data[c.profile.id],data.potions[c.profile.id]
    for slot=6,11 do
        local item=itemAt(c,slot);local rule=item and rules[item.itemID]
        -- Every branch below needs an item rule, or a potion rule outside the
        -- Classic activator. Skip native readiness reads for other slots.
        if (rule or not c.classicActivator and item and potions[item.itemID]) and c:ready(slot)then
            if rule and rule.allyCleanse and not c.classicActivator then
                for _,ally in ipairs(c.allies)do
                    if self:AllyCleanse(slot,ally)then
                        self:Request(slot,ally,{owner='ally_cleanse',urgent=true,validate=function()return self:AllyCleanse(slot,ally)end})
                        break
                    end
                end
            elseif rule and rule.stasis and not c.classicActivator and c.config:get('stasis')and U.hp(c.g.myHero)<c.config:get('stasisHP')and self:Threat()then
                self:Request(slot,nil,{owner='stasis',urgent=true,validate=function()
                    return c.config:get('stasis')and U.hp(c.g.myHero)<c.config:get('stasisHP')and self:Threat()
                end})
            elseif rule and rule.cleanse and self.claims.qss and self:CC(c.g.myHero)then
                self:Request(slot,nil,{owner='qss',urgent=true,validate=function()
                    return self.claims.qss and c.config:get('cleanse')and self:CC(c.g.myHero)
                end})
            elseif not c.classicActivator and rule and rule.shield and c.config:get('shield')and self:Shield(rule.range)then
                self:Request(slot,nil,{owner='shield',urgent=true,validate=function()
                    return c.config:get('shield')and self:Shield(rule.range)
                end})
            elseif not c.classicActivator and self:Potion(slot)then
                self:Request(slot,nil,{owner='potion',validate=function()return self:Potion(slot)end})
            end
        end
    end
end
function A:Threat()
    local c=self.c;local h=c.g.myHero
    for _,u in ipairs(c.observations.heroes)do if u.team~=h.team and U.valid(u)and U.dist(u.pos,h.pos)<800 then
        local a=u.activeSpell
        if a and a.valid and(a.target==h.handle or a.target==h.networkID)or U.dist(u.pos,h.pos)<(u.range or 125)+150 then return true end
    end end
    return false
end
function A:ItemAllowed(slot,target)
    local c=self.c
    local item=itemAt(c,slot);local rule=item and data[c.profile.id][item.itemID]
    if not rule or rule.shield or rule.cleanse or rule.allyCleanse or rule.stasis or c.config:get(rule.group)==false or not c.config:get('offense')or not U.valid(target)
        or not c:ready(slot)or U.dist(c.g.myHero.pos,target.pos)>rule.range
        or rule.champion and target.type~=c.g.myHero.type or c.sdk.Orbwalker:IsAutoAttacking()
        or rule.reset and not(c.lastAttackFinished and c:now()-c.lastAttackFinished<.3)then return false end
    return true,rule
end
function A:Offense(target,context)
    local c=self.c
    if not c.config:get('offense')or not U.valid(target)then return false end
    for slot=6,11 do
        local item=itemAt(c,slot);local rule=item and data[c.profile.id][item.itemID]
        if rule and not rule.shield and not rule.cleanse and not rule.allyCleanse and(not rule.champion or target.type==c.g.myHero.type)then
            local function valid()return self:ItemAllowed(slot,target)end
            if valid()then
                local ok=self:Request(slot,rule.targeted and target or nil,{owner='offense',offensive=true,context=context,validate=valid})
                if ok then return true end
            end
        end
    end
    return false
end
return A

end
