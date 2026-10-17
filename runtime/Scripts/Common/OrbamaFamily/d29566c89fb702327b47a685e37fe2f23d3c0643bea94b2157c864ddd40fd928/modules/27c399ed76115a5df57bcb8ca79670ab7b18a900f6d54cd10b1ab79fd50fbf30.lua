return function(require)
local U=require('leesin.util')
local DamageDisplay=require('Overlay.client')
local DrawDamage=require('Overlay.damage')
local O={};O.__index=O
local currentDraw
local function api()return currentDraw or Draw end
function O.new(ctx)
    local self=setmetatable({ctx=ctx,preparationCursor=1},O)
    self.preparationConfig={intervalMs=0,maxDelayMs=250,units=1,maxUnits=1}
    self.preparationWork=function()return self:prepareTarget()end
    return self
end
function O:installOverlay(app)
 local c=self.ctx;local overlay=c.sdk.Overlay
 if not overlay or not overlay.GetCapabilities or not overlay:GetCapabilities().ownedScopes then return false end
 local family=_G.AyyyyIO;local identity=myHero
 if family and family.GetOverlayScope then self.scope=family:GetOverlayScope('champion')
 else self.scope=overlay:Register('Lee.display',{active=function()return app.active and SDK==c.sdk and myHero==identity end})end
 if not self.scope then return false end
 self.scope:Renderer('lee-status',function()self:status()end,4);self.statusSeparated=true
 self.scope:Renderer('lee',function(d)currentDraw=d;local ok,err=pcall(self.draw,self);currentDraw=nil;if not ok then error(err)end end,2)
 return true
end
function O:status()
 local c=self.ctx;if not self.scope then return end
 local enabled=c.config:get('autoJungle');local reason=enabled and(not c.config:get('enabled')and 'suspended'or c.input.farmPaused and 'paused')or nil
 -- Same line as every champion: "Auto-jungle [J] routing to Wolves" (state from the shared router).
 local router=enabled and not reason and c.farm and c.farm.router
 self.scope:Set('autojungle',{kind='status',feature='champion',anchor='hud',label='Auto-jungle',bind=c.config:key('farmKey'),enabled=enabled,
  reason=reason,detail=router and router.StateText and router:StateText()or nil,priority=100,expires=c:now()+.2})
 if not c.sharedUtilities then self.scope:Set('autosmite',{kind='status',feature='objectives',anchor='hud',label='Auto-Smite',bind=c.config:key('smiteKey'),enabled=c.config:get('autosmite'),priority=100,expires=c:now()+.2})end
end
local colors,provider={},nil
local function color(r,g,b)
    if provider~=api().Color then colors={};provider=api().Color end
    local key=r*65536+g*256+b
    if colors[key]==nil then colors[key]=api().Color(230,r,g,b) end
    return colors[key]
end
local function circle(p,r,col)
    if U.position(p) and U.finite(r) and r>0 and r<20000 then api().Circle(U.vector(p),r,2,col) end
end
local function line(a,b,col)
    if not U.position(a) or not U.position(b) then return end
    local p,q=U.vector(a):To2D(),U.vector(b):To2D()
    if U.finite(p.x)and U.finite(p.y)and U.finite(q.x)and U.finite(q.y)then
        local overlay=SDK and SDK.Overlay
        if overlay then local x,y,bx,by=overlay:Clip(p.x,p.y,q.x,q.y);if x then api().Line(x,y,bx,by,2,col)end
        else api().Line(p.x,p.y,q.x,q.y,2,col)end
    end
end
local function arrow(a,b,col)
    if not U.position(a) or not U.position(b) then return end
    local p,q=U.vector(a):To2D(),U.vector(b):To2D()
    if not U.finite(p.x)or not U.finite(p.y)
        or not U.finite(q.x) or not U.finite(q.y) then return end
    local dx,dy=q.x-p.x,q.y-p.y;local length=math.sqrt(dx*dx+dy*dy)
    if length<8 then return end
    dx,dy=dx/length,dy/length
    local size=math.min(18,length*.3);local bx,by=q.x-dx*size,q.y-dy*size
    api().Line(p.x,p.y,q.x,q.y,3,col)
    api().Line(q.x,q.y,bx-dy*size*.55,by+dx*size*.55,3,col)
    api().Line(q.x,q.y,bx+dy*size*.55,by-dx*size*.55,3,col)
end
function O:insecDrawing(i)
    local c=self.ctx;local green,amber,white=color(65,225,165),color(255,195,75),color(220,225,235)
    -- Rendering consumes the last controller geometry. It must not change the
    -- plan, destination, prediction lead or resource contract on a Draw call.
    local prepared=self.insecDisplay
    if not prepared or prepared.instance~=i or c:now()-prepared.at>.25 then return end
    local start,stand,endpoint,display=prepared.start,prepared.stand,prepared.endpoint,prepared.display
    circle(i.target.pos,85,amber);circle(stand,28,amber)
    if endpoint then
        -- Short directional arrow remains readable when the true endpoint is
        -- offscreen. Its head is at the destination, never at the kicked unit.
        arrow(start,U.toward(start,endpoint,math.min(550,U.dist(start,endpoint))),green)
        circle(endpoint,35,green)
        if c.config:get('drawInsecTolerance') then
            local ray=U.toward(start,endpoint,320);local dx,dz=ray.x-start.x,ray.z-start.z
            local angle=math.rad(c.config:get('insecAngle'));local cs,sn=math.cos(angle),math.sin(angle)
            for _,side in ipairs({-1,1}) do
                line(start,{x=start.x+dx*cs-dz*sn*side,y=start.y,z=start.z+dx*sn*side+dz*cs},color(35,95,75))
            end
        end
    end
    if i.recipient and U.position(i.recipient.pos) and not i.recipient.dead and (i.recipient.health or 0)>0 then
        circle(i.recipient.pos,65,green)
        local p=U.vector(i.recipient.pos):To2D()
        if p.onScreen then api().Text('KICK TO '..(i.recipient.charName or 'ALLY'),13,p.x+18,p.y-30,green) end
    end
    if display then
        local from=myHero.pos
        for n,step in ipairs(display.steps) do
            line(from,step.pos,amber);circle(step.pos,22,amber);from=step.pos
            local p=U.vector(step.pos):To2D()
            if p.onScreen then
                local name=step.kind=='q' and 'Q' or step.kind=='ward' and 'WARD > W' or step.kind:upper()
                api().Text(n..' '..name,12,p.x+12,p.y+10,amber)
            end
        end
        if display.walk then line(from,display.walk,amber) end
    end
    if i.alignment and not i.preview then line(myHero.pos,i.alignment.pos,amber) end
    if self.scope then
        local flash=i.flashConsent and 'FLASH APPROVED'or 'NO FLASH'
        self.scope:Set('insec-detail',{kind='detail',feature='preview',anchor='hud',text=(i.preview and 'PREVIEW 'or 'INSEC ')..(i.target.charName or 'TARGET')..' / '..flash..' / '..(i.resource or 'Finding approach'),priority=100,expires=c:now()+.1})
        return
    end
    local size=Game.Resolution and Game.Resolution() or {x=1920,y=1080}
    local x,y=math.max(12,size.x*.5-230),math.max(80,size.y-230)
    if api().Rect then api().Rect(x,y,460,84,api().Color(210,15,22,29)) end
    api().Text((i.preview and 'PREVIEW  ' or 'INSEC  ')..(i.target.charName or 'TARGET')..'  |  '..(i.kind=='ally' and 'TO ALLY' or 'TO CURSOR'),16,x+12,y+8,white)
    local fallback=i.flashReason and i.flashReason:find('Flash fallback:',1,true)
    local flash=i.flashConsent and 'FLASH APPROVED' or i.preview and 'FLASH MAY BE PROPOSED' or fallback and 'FLASH: NO WARD FALLBACK' or 'NO FLASH'
    local details=flash..'  |  '..(i.resource or 'Finding approach')
    if #details>66 then details=details:sub(1,63)..'...' end
    api().Text(details,13,x+12,y+31,amber)
    local previewKey=U.keyLabel(c.config:key('insecPreviewKey'))
    api().Text(i.preview and 'Release '..previewKey..': confirm shown route' or i.confirmBlocked and 'Hold '..previewKey..' to revise the plan'
        or 'Hold: continue   Right-click: move   Release: cancel',12,x+12,y+56,white)
end
-- Prepared results only: the multi-kick proposal kept by combat:multi and the
-- Smite + Q blocker kept by spells:q1. Drawing never searches.
function O:kickDrawing()
    local c=self.ctx;local now=c:now();local red,amber=color(255,90,100),color(255,195,75)
    local k=c.combat.kickProposal
    if k and k.at and now-k.at<=.5 and c:enemyValid(k.primary) then
        circle(k.primary.pos,90,red);line(k.primary.pos,k.endpoint,red);circle(k.endpoint,30,red)
        if k.flash or k.ward then circle(k.origin,35,amber) end
        local p=U.vector(k.primary.pos):To2D()
        if p.onScreen then api().Text('HITS '..tostring(k.hits)..' / KILLS '..tostring(k.kills)..(k.flash and ' (FLASH)' or k.ward and ' (WARD)' or ''),14,p.x+20,p.y-40,red) end
    end
    local s=c.spells.smiteBlockerShown
    if s and now-s.at<=.6 and U.valid(s.unit) then
        circle(s.unit.pos,70,amber)
        local p=U.vector(s.unit.pos):To2D()
        if p.onScreen then api().Text('SMITE > Q',13,p.x+16,p.y-24,amber) end
    end
end
function O:prepareAction()
 local c=self.ctx;local i=c.combat.insec
 if not i or not c.config:get('draw')then self.insecDisplay=nil;return end
    local view={};for key,value in pairs(i) do view[key]=value end
    local old=i.geometryTarget or i.target.pos;local predicted=i.plannedTarget or old
    local start={x=i.target.pos.x+predicted.x-old.x,y=i.target.pos.y,z=i.target.pos.z+predicted.z-old.z}
    local aim=i.destination or c.aim
    if i.kind=='ally' and not i.locked and c.config:get('insecTrackAlly') and U.valid(i.recipient) then aim=i.recipient.pos end
    if i.locked and i.direction then aim={x=start.x+i.direction.x*1200,y=start.y,z=start.z+i.direction.z*1200} end
    local stand,endpoint=c.combat:direction({pos=start},aim)
    view.plannedTarget=start;view.plannedEndpoint=endpoint;view.stand=stand
    local display=c.combat.planner:adapt(view,i.plan);i.displayPlan=display

 self.insecDisplay={instance=i,at=c:now(),start=start,stand=stand,endpoint=endpoint,display=display}
end
function O:prepareTarget()
    local c=self.ctx;local target=self.preparationTarget;self.preparationTarget=nil
    if not target then return false end
    local id=U.id(target);local now=self:preparationNow()
    self.damagePreview=self.damagePreview or {}
    self.damagePreview[id]=nil
    if (c.config:get('damageSelected')or c.sharedUtilities and c.config:get('damageCurrent'))and not U.same(target,self.currentTarget)then return true end
    if not U.valid(target)then return true end
    local point=U.vector(target.pos):To2D()
    if not point.onScreen or not c:enemyValid(target)then return true end
    local safe,max=c.damageModel:both(target)
    if U.id(target)==id and U.valid(target)
        and (not(c.config:get('damageSelected')or c.sharedUtilities and c.config:get('damageCurrent'))or U.same(target,self.currentTarget))then
        self.damagePreview[id]={safe=safe,max=max,target=target,handle=target.handle,at=now,
            health=target.health,shield=target.allShield or 0,physicalShield=target.shieldAD or 0,magicalShield=target.shieldAP or 0}
        self.preparedAt=now
    end
    return true
end
function O:preparationNow()
    if type(GetTickCount)=='function'then return GetTickCount()/1000 end
    return self.ctx:now()
end
function O:prepare()
    local c=self.ctx;local now=self:preparationNow()
    self:prepareAction()
    self.currentTarget=c:locked()or ((c.mode=='fight'or c.mode=='combo'or c.mode=='harass')and c:target(1300))
    local preparation=c.sdk.Preparation
    local supported=preparation and preparation.version==1 and type(preparation.Register)=='function'
    if not supported and self.preparedAt and now-self.preparedAt<.1 then return end
    if self.displayError or not c.config:get('draw')or not c.config:visible('damageBars',c.sdk,c.mode)or not c.damageModel then
        self.preparedAt=now;self.damagePreview={}
        if self.preparationScope then self.preparationScope:CancelJob('damage')end
        return
    end
    if supported then
        if not self.preparationScope then
            local family=_G.AyyyyIO
            if family and type(family.GetPreparationScope)=='function'then
                self.preparationScope=family:GetPreparationScope('champion.display')
            else self.preparationScope=preparation:Register('Lee display '..tostring(self))end
        end
        if not self.preparationScope then return end
        local roster=c.enemies or {};local count=math.min(#roster,32)
        local selectedOnly=(c.config:get('damageSelected')or c.sharedUtilities and c.config:get('damageCurrent'));local selected=selectedOnly and self.currentTarget
        local current={};local eligible=0
        for index=1,count do
            local target=roster[index];local id=U.id(target)
            if id and (not selectedOnly or U.same(target,selected))then current[id]=target;eligible=eligible+1 end
        end
        self.damagePreview=self.damagePreview or {}
        for id,row in pairs(self.damagePreview)do
            -- A row lives a second: a refused or late preparation must not blink the bar.
            if current[id]~=row.target or now-(row.at or self.preparedAt or 0)>1 then self.damagePreview[id]=nil end
        end
        if eligible==0 then self.preparationScope:CancelJob('damage');return end
        local candidate,nextIndex
        for offset=0,count-1 do
            local index=(self.preparationCursor+offset-1)%count+1
            local target=roster[index];local id=U.id(target);local row=id and self.damagePreview[id]
            if id and current[id]==target and (not row or now-(row.at or self.preparedAt or 0)>=.1)then
                candidate=target;nextIndex=index%count+1;break
            end
        end
        if not candidate then return end
        self.preparationTarget=candidate
        local ran,reason,detail=self.preparationScope:Run('damage',self.preparationConfig,self.preparationWork)
        self.preparationTarget=nil
        if ran then self.preparationCursor=nextIndex end
        if not ran and reason=='callback_error'then self.damagePreview={};self.displayError=true;self.preparationScope:CancelJob('damage');print('[AyyyyIO/LeeSin] Damage display preparation disabled')end
    else
        self.preparedAt=now;self.damagePreview={}
        local selectedOnly=(c.config:get('damageSelected')or c.sharedUtilities and c.config:get('damageCurrent'));local selected=selectedOnly and self.currentTarget
        for _,target in ipairs(c.enemies or {})do
            if (not selectedOnly or U.same(target,selected))and U.valid(target)then
                local point=U.vector(target.pos):To2D()
                if point.onScreen and c:enemyValid(target)then
                    local safe,max=c.damageModel:both(target)
                    self.damagePreview[U.id(target)]={safe=safe,max=max,target=target,handle=target.handle,at=now,
                        health=target.health,shield=target.allShield or 0,physicalShield=target.shieldAD or 0,magicalShield=target.shieldAP or 0}
                end
            end
        end
    end
end
function O:close()
    if self.scope then self.scope:Close();self.scope=nil end
    if self.preparationScope then self.preparationScope:Close();self.preparationScope=nil end
    self.damagePreview={};self.preparedAt=nil
end
function O:damageBars()
    local c=self.ctx;local cfg=c.config
    if self.scope and not self.publishDamage then self.publishDamage=DamageDisplay.publisher(_G,self.scope)end
    local rows={}
    local function publish()
        if self.publishDamage then self.publishDamage(rows,nil,nil,#rows==0)
        else for _,row in ipairs(rows)do DrawDamage(_G,api(),row,1)end end
    end
    if not cfg:visible('damageBars',c.sdk,c.mode) or not c.damageModel then publish();return end
    local now=self:preparationNow()
    if not self.preparedAt or now-self.preparedAt>1 then publish();return end
    local width,height=cfg:get('damageWidth'),cfg:get('damageHeight')
    local selected=(cfg:get('damageSelected')or c.sharedUtilities and cfg:get('damageCurrent'))and self.currentTarget
    for _,target in ipairs(c.enemies or {}) do
        -- Prepared display eligibility is refreshed by prepare, not by api().
        -- This row authorizes rendering only; gameplay validators remain fresh.
        local result=self.damagePreview and self.damagePreview[U.id(target)]
        local prepared=result and result.target==target and result.handle==target.handle
            and now-(result.at or self.preparedAt or 0)<=1
        if prepared and target.team~=myHero.team and target.team~=300 and U.valid(target)
            and U.finite(target.maxHealth) and target.maxHealth>0
            and (not(cfg:get('damageSelected')or c.sharedUtilities and cfg:get('damageCurrent'))or U.same(target,selected)) and (c.sharedUtilities or c:enemyValid(target)) then
            local safe,max=result.safe or {},result.max or {}
            local function add(estimate,offset,col,label,killable)
                if #rows>=10 or not U.finite(estimate.damage)or estimate.damage<1 then return end
                local id,handle=U.id(target),target.handle
                rows[#rows+1]={unit=target,damage=estimate.damage,partial=estimate.partial==true,killable=killable,snapshot=result,
                    killValid=function()return DamageDisplay.KillCurrent(target,result)end,
                    key='damage:'..tostring(id)..':'..offset,
                    appearance={width=width,height=height,offsetX=cfg:get('damageX'),offsetY=cfg:get('damageY'),
                        stripOffset=offset,color=col,partialMarker=false,text=cfg:get('damageText'),label=label},
                    valid=function()return U.id(target)==id and target.handle==handle and self:preparationNow()-(result.at or 0)<=1 end}
            end
            if cfg:get('damageSafe')then add(safe,0,{220,65,225,165},'Cautious ~',safe.lethal==true)end
            if cfg:get('damageMax')then add(max,height+1,{220,255,175,75},'All-in ~',false)end
        end
    end
    publish()
end
function O:ranges()
    local c=self.ctx;local cfg=c.config
    if myHero.dead or not cfg:get('draw') or not api().Circle then return end
    -- Ranges of ready abilities only (own spell data, no search).
    if cfg:visible('drawQRange',c.sdk,c.mode) and c:ready(0) then circle(myHero.pos,c.profile.qRange,color(90,175,235)) end
    if cfg:visible('drawWRange',c.sdk,c.mode) and c:ready(1) then circle(myHero.pos,c.profile.wRange,color(65,225,165)) end
    if cfg:visible('drawERange',c.sdk,c.mode) and c:ready(2) then circle(myHero.pos,c.profile.eRange,color(255,195,75)) end
    if cfg:visible('drawRRange',c.sdk,c.mode) and c:ready(3) then circle(myHero.pos,c.profile.rRange,color(255,90,100)) end
    if cfg:visible('drawWardRange',c.sdk,c.mode) then circle(myHero.pos,c.wards:range(),color(220,225,235)) end
end
function O:draw()
    local c=self.ctx;if not api()then return end
    if not self.statusSeparated then self:status()end
    if c.guide and c.config:get('guideOpen') then if c.sdk.Overlay then c.sdk.Overlay.forcedLayer=5 end;c.guide:draw(api());if c.sdk.Overlay then c.sdk.Overlay.forcedLayer=nil end;return end
    if not c.config:get('draw') then return end
    local white,green,amber,red=color(220,225,235),color(65,225,165),color(255,195,75),color(255,90,100)
    self:ranges()
    self:damageBars()
    if c.config:get('drawMultiKick') then self:kickDrawing() end
    local p=c.wards.previewState
    if c.config:visible('drawWard',c.sdk,c.mode) and c.input:held('wardKey') and not c.input.wardCancelled and p then
        local col=not p.valid and red or (p.kind=='assisted' or p.kind=='approach') and amber or green
        circle(p.pos,45,col);line(p.raw,p.pos,col)
        if p.path then
            local from=myHero.pos
            for _,point in ipairs(p.path) do line(from,point,amber);from=point end
            circle(p.stand,35,amber);line(p.stand,p.pos,col)
            if p.walkTo then circle(p.walkTo,20,white) end
        end
        if p.raw then circle(p.raw,15,white) end
        if p.pos then
            local s=U.vector(p.pos):To2D()
            if s.onScreen then
                local label=p.valid and p.kind or p.reason or 'Invalid'
                if c.config:get('diagnostics') and c.terrain.provider and c.terrain.provider.static then label=label..' [static map grid]' end
                api().Text(label,16,s.x+15,s.y,col)
            end
        end
    end
    local i=c.combat.insec
    if i and c.config:visible('drawInsec',c.sdk,c.mode) then
        self:insecDrawing(i)
    end
    if c.config:visible('drawWard',c.sdk,c.mode) and c.wards.pending then
        local pending=c.wards.pending;circle(pending.pos,45,amber)
        if pending.path then
            local from=myHero.pos
            for index=pending.index,#pending.path do line(from,pending.path[index],amber);from=pending.path[index] end
            line(from,pending.pos,green)
        end
    end
end
return O

end
