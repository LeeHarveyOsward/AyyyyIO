return function(require)
local L={};L.__index=L
function L.new(c)return setmetatable({c=c,requests={}},L)end
function L:Request(owner,slot,rank,allowed)
    local c=self.c;local g=c.g;local client=c.actions.client
    if slot<0 or slot>3 or not c.config:get('level')or c:blocked()then return false,'level_disabled'end
    if self.requests[owner]then return true,'waiting'end
    local function valid()
        local d=c:spell(slot)
        return c.config:get('level')and not c:blocked()and not c:recalling()and d.level==rank
            and(g.myHero.levelData.lvlPts or 0)>0 and(not allowed or allowed())
    end
    if not valid()then return false,'level_no_longer_allowed'end
    if g.Control.IsKeyDown and(g.Control.IsKeyDown(16)or g.Control.IsKeyDown(17)or g.Control.IsKeyDown(18))then return false,'manual_modifier'end
    -- Skill allocation is a held modifier around the spell key. A 'cast' with
    -- two keys is pulsed sequentially (modifier up before the spell key goes
    -- down), which casts the spell instead of learning it (live 2026-09-29).
    local id,why=client:Submit({type='chord',kind='none',keys={g.HK_LUS or 17,c.actions:key(slot)},
        owner='level:'..owner,resource='skill_allocation',priority='background',expires=client:Now()+250,
        mechanical=valid,reconcile=function()
            local level=c:spell(slot).level
            return type(level)=='number'and level>rank
        end})
    if not id then return false,why end
    self.requests[owner]={id=id,slot=slot,rank=rank};return true,id
end
function L:Cancel(owner)
    local q=self.requests[owner]
    if not q then return end
    -- A sent allocation cannot be withdrawn; Tick reconciles it. Repeating
    -- Cancel each LHO tick only produced 'already_sent' churn.
    local r=self.c.actions.client:Poll(q.id)
    if r and r.sentAt then return end
    self.c.actions.client:Cancel(q.id,'level_cancelled')
end
function L:Tick()
    local client=self.c.actions.client
    for owner,q in pairs(self.requests)do
        local r=client:Poll(q.id)
        if r and r.sentAt and not r.mechanical and(self.c:spell(q.slot).level or 0)>q.rank then
            local evidence={kind='mechanical',unique=true,source='skill_rank',at=client:Now()}
            local receipt=r.commandReceipt
            if receipt then evidence.attribution='command_key';evidence.key=receipt.key;evidence.generation=receipt.generation;evidence.session=receipt.session end
            client:Observe(q.id,evidence)
        end
        client:Reconcile(q.id)
        if not client:HasAction(q.id)then self.requests[owner]=nil end
    end
end
return L

end
