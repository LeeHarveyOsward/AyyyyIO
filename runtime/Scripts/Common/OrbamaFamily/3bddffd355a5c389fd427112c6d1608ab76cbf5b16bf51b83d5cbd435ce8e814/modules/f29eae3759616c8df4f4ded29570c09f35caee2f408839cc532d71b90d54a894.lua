return function(require)
local U=require('kata.util')
local I={};I.__index=I
-- Explicit scope: no stacking/periodic/rune damage is invented for unsupported effects.
-- Modern on-hit values below match the active Orbama item mechanics; provenance in docs.
local normal={
    [3115]={onhit='nashor'},[3153]={onhit='bork'},[3091]={onhit='wits'},[3124]={onhit='rage'},[3302]={onhit='rage'},
    [6672]={onhit='kraken',attackOnly=true},
    -- Spellblade rows (research/spellblade.md, wikis read 2026-10-10): counted only while the primed buff is on
    -- Katarina, once per simulated sequence. Lich Bane 45% AP since V26.10; Dusk and Dawn is magic.
    [3100]={onhit='blade',base=.75,ap=.45,magic=true,buff={lichbane=true}},[3057]={onhit='blade',base=1,buff={sheen=true}},
    [3078]={onhit='blade',base=2,buff={['3078trinityforce']=true}},[3508]={onhit='blade',base=1.25,buff={['3508buff']=true}},
    [6662]={onhit='blade',base=1.5,buff={['6662buff']=true}},[2510]={onhit='blade',base=.75,ap=.1,magic=true,buff={['2510_sheenhands']=true}},
    [3157]={active='stasis',range=0},[3152]={active='move',range=275},[3146]={active='target',range=600,unknownDamage=true}}
-- Classic ids are 770000 + the old id. Spellblade: Sheen 100% base AD, Trinity Force 200% base AD, Lich Bane 50 +
-- 75% AP magic (no AD term), Iceborn Gauntlet 125% base AD (League_Classic/Items wiki + client shop, 2026-10-10,
-- research/spellblade.md). Primed buff names are asset-record candidates (Sheen_Jade, LichBane_Jade,
-- ItemFrozenFist; Trinity Force reuses a Sheen buff), live unverified: an unseen buff only means no bonus is counted.
local classicBlade={sheen_jade=true,sheen=true,lichbane_jade=true,itemfrozenfist=true}
local classic={
    [773057]={onhit='blade',base=1,buff=classicBlade},[773078]={onhit='blade',base=2,buff=classicBlade},
    [773100]={onhit='blade',flat=50,ap=.75,magic=true,buff=classicBlade},[773025]={onhit='blade',base=1.25,buff=classicBlade},
    [773157]={active='stasis',range=0},[773128]={active='amplify',range=750,maxHP=.15,amp=1.2},
    [773146]={active='target',range=600,unknownDamage=true},[773144]={active='target',range=450,raw=100},
    [773153]={active='target',range=450,maxHP=.15}}

function I.new(c)return setmetatable({c=c,inventory={},catalog=c.profile.id=='classic'and classic or normal},I)end
function I:refresh()
    self.inventory={}
    for slot=6,12 do local item=self.c.hero:GetItemData(slot);if item and(item.itemID or 0)>0 then
        self.inventory[slot]={id=item.itemID,rule=self.catalog[item.itemID],data=item}
    end end
end
-- Item actives have no menu entries (a good default): `item<id>` answers nil, so every catalogued active is allowed.
function I:enabled(id)local v=self.c.config:get('item'..id);return v~=false end
function I:damage(rule,target)
    local raw=rule.raw or rule.maxHP and rule.maxHP*(target.maxHealth or 0)or 0
    if self.c.profile.id=='classic'and rule.active=='target'and rule.maxHP then raw=math.max(100,raw)end
    return self.c.damage:mitigate(target,'magic',raw)
end
function I:onhit(o,sim,trigger)
    local h=self.c.hero;local m,p=0,0;sim=sim or {};sim.procs=sim.procs or {}
    for _,item in pairs(self.inventory)do local r=item.rule
        if r and r.onhit and(not r.attackOnly or trigger=='AA')and(not r.buff or not sim.procs.spellblade and U.buff(h,r.buff,Game.Timer()))then
            local value=0
            if r.onhit=='nashor'then m=m+15+.15*(h.ap or 0)
            elseif r.onhit=='wits'then m=m+45
            elseif r.onhit=='rage'then m=m+30
            elseif r.onhit=='bork'then value=(sim.hp or o.health)*.09;if o.type~=h.type then value=math.min(100,value)end;p=p+value
            elseif r.onhit=='kraken'then
                local buff=U.buff(h,{['6672buff']=true},Game.Timer())
                if not sim.procs.kraken and buff and buff.count==2 then
                    local level=h.levelData.lvl;p=p+(150+math.max(0,level-8)*5)*(1+.75*(1-math.min(1,(sim.hp or o.health)/math.max(1,o.maxHealth))))
                    sim.procs.kraken=true
                end
            elseif r.onhit=='blade'then
                local raw=(r.base or 0)*(h.baseDamage or 0)+(r.ap or 0)*(h.ap or 0)+(r.flat or 0)
                if r.magic then m=m+raw else p=p+raw end
            end
            if r.buff then sim.procs.spellblade=true end
        end
    end
    return m,p
end
function I:stasisNeeded()
    local c=self.c
    local hp=c.sdk.HealthPrediction or c.sdk.Health
    if hp and hp.GetIncoming and next(hp:GetIncoming(c.hero.handle))and c:healthPrediction(c.hero,.45)<=0 then return true end
    if U.hp(c.hero)>c.config:get('stasisHP')then return false end
    -- Require an attributable attack/cast targeting Katarina, not just nearby enemies.
    for _,o in ipairs(c.enemies)do
        local a=U.valid(o)and o.activeSpell
        if a and a.valid and(a.target==U.id(c.hero)or a.target==c.hero.handle)
            and(a.castEndTime or a.endTime or 0)>=Game.Timer()then return true end
    end
    return false
end
function I:activeCandidate(target,mode)
    for slot,item in pairs(self.inventory)do local r=item.rule
        if r and r.active and self:enabled(item.id)and self.c:ready(slot)then
            if r.active=='stasis'and self:stasisNeeded()then return {slot=slot,owner='defense',rule=r,itemID=item.id,release=true,priority='critical'}end
            if mode=='combo'and U.valid(target)and not self.c.damage:protected(target)then
                if (r.active=='target'or r.active=='amplify')and U.dist(self.c.hero.pos,target.pos)<=r.range then
                    return {slot=slot,target=target,owner=mode,rule=r,itemID=item.id,score=r.active=='amplify'and 700 or 80}
                end
            end
        end
    end
end
return I

end
