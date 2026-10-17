return function(require)
local U=require('utils.util')
local F={}
function F.new(c)
    local g=c.g;local V={c=c,last={},delayed={}}
    local offensive={[773128]=true,[773146]=true,[773144]=true,[773153]=true,[773092]=true,[773142]=true,
        [773131]=true,[773069]=true,[773023]=true,[773056]=true,[773074]=true,[773077]=true,[773042]=true}
    function V:Cast(key,target,options)
        options=options or {};local slot
        for s=4,12 do if c.actions:key(s)==key then slot=s;break end end
        if not slot then return false end
        if slot<6 and U.name(c:spell(slot).name):find('smite',1,true)then return false end
        if slot<6 and U.name(c:spell(slot).name)=='summonerdot'and not c.config:get('ignite')then return false end
        local item=slot>=6 and g.myHero:GetItemData(slot)
        local ok,event=c.Activator:Request(slot,target,{owner=options.owner,priority=options.priority,
            offensive=item and offensive[item.itemID],context=options.context,validate=options.validate})
        if ok then self.last[key]=event end
        return ok
    end
    function V:AfterCast(key,fn)
        local event=self.last[key];if event then event.callbacks=event.callbacks or {};event.callbacks[#event.callbacks+1]=fn end
    end
    function V:Delayed(id,seconds,fn)
        if self.delayed[id]then return end
        self.delayed[id]=true
        g.DelayAction(function()self.delayed[id]=nil;if c:active()and not c:blocked()then fn()end end,seconds)
    end
    function V:ModeContext(name)return {modes={c.sdk['ORBWALKER_MODE_'..name:upper()]}}end
    function V:RunDecision(_,fn)if not c:blocked()then fn()end end
    local E={Core=V,Callback={Add=function(event,fn)if event=='Tick'then V.tick=fn end end}}
    -- The Classic activator shows no menu of its own (player menu standard 2026-10-11): its per-item
    -- thresholds keep their defaults, and the Items and summoner spells switches (items, potions,
    -- damage items, cleanse, shields, stasis, Ignite) govern every request it makes. Smite is the
    -- Smite group's alone.
    local function fixed(spec)
        local value,key=spec.value,spec.key;local node={args=spec}
        function node:Value(v)if v~=nil then value=v end;return value end
        function node:Key()return key end
        function node:Hide()end
        function node:Remove()end
        function node:MenuElement(child)local n=fixed(child);self[child.id]=n;return n end
        return node
    end
    E.MenuElement=fixed
    E.GetDistance=function(a,b)return U.dist(a.pos or a,(b and(b.pos or b))or g.myHero.pos)end
    E.IsValid=U.valid;E.GetBuffs=function(o)
        local list={};if o and o.GetBuff then for i=0,U.count(o.buffCount or 0,256)do
            local b=o:GetBuff(i);if b and(b.count or 0)>0 then list[#list+1]=b end
        end end;return list
    end
    E.HasBuffContainsName=function(o,name)
        for _,b in ipairs(E.GetBuffs(o))do if b.name and b.name:lower():find(name:lower(),1,true)then return true end end
        return false
    end
    E.IsInvulnerable=function(o)
        if o.isImmortal==true then return true end
        for _,b in ipairs(E.GetBuffs(o))do if b.type==18 then return true end end
        return false
    end
    E.GetEnemyCount=function(range,pos)return c:threats(pos,range)end
    E.GetTarget=function(range)return c.sdk.TargetSelector:GetTarget(range,c.sdk.DAMAGE_TYPE_PHYSICAL)end
    E.GetMode=function()
        for _,name in ipairs({'Combo','Harass','LaneClear','JungleClear','LastHit','Flee'})do
            if c.sdk.Orbwalker.Modes[c.sdk['ORBWALKER_MODE_'..name:upper()]]then return name end
        end
    end
    E.ShouldWait=function()return c:blocked()or c.sdk.Orbwalker:IsAutoAttacking()end
    E.IsUnderTurret=function(o)
        for _,t in ipairs(c.observations.turrets)do
            local range=t.range or t.attackRange
            if U.valid(t)and t.team~=g.myHero.team and U.finite(range)and U.dist(t.pos,o.pos)<=range then return true end
        end
        return false
    end
    E.CheckChatBlock=function()return c:blocked()end
    return E,V
end
return F

end
