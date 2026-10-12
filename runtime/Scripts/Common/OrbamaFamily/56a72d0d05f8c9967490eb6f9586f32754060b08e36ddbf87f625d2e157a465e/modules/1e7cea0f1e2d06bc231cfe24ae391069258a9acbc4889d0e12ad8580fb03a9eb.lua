return function(require)
local renderer=require('Guide.ui')
local widths=require('Guide.font')
local G={};G.__index=G
local plain={}
local empty={}
function plain.spans(text)return {{text=text}}end
function plain.active()return nil end
local function label(key)
    if key>=112 and key<=123 then return 'F'..(key-111) end
    return tostring(key)
end
function G.new(g,family)
    local self=setmetatable({g=g,family=family,groups={},pages={},titles={},down={},page=1,open=false,scale=100,renderers={}},G)
    self.renderers[plain]=renderer(plain,widths)
    local cfg={}
    function cfg:get(key)
        if key=='guideOpen' then return self.owner.open elseif key=='guideScale' then return self.owner.scale end
        return self.owner.page
    end
    function cfg:set(key,value)
        if key=='guideOpen' then self.owner.open=value elseif key=='guideScale' then self.owner.scale=value end
    end
    function cfg:key(key)return key=='guideKey' and 119 or key=='guidePreviousKey' and 118 or 120 end
    cfg.owner=self;self.config=cfg
    self:Register('orbama',{'Orbama: controls','Orbama: execution'},function(index)
        if index==1 then return {title='Orbama controls',subtitle='Movement remains under your control.',cards={
            {'MODES','Use the mode bindings shown in the Orbama menu. Champion scripts use these same modes. Releasing a mode cancels its waiting intentions.'},
            {'TARGETS','Explicit target selection follows your saved preferences. This installation reserves an unseen selection for 1.5 seconds unless you change it.'},
            {'MOVEMENT','A move at the current pointer uses the smaller movement transport. Object attacks and casts still need the correct target or ground position.'}},note='Guide clicks are consumed before Orbama target selection. Other applications and foreign callbacks are outside this contract.'} end
        return {title='Requests, sends and results',subtitle='An accepted request is not a confirmed spell.',cards={
            {'PRIORITY','The dispatcher chooses executable work. Urgent unsent actions can replace eligible lower-priority work owned by the same client.'},
            {'AIM','Prediction, collision and terrain preparation happen before cursor acquisition. Prepared casts keep final commit work bounded.'},
            {'CLEANUP','Sent input keeps its required stabilization. Cancellation ends future steps and releases owned input; it cannot undo a spell already sent.'}},note='Advanced behavior requires the matching Orbama capability and explicit permission from the requesting script.'}
    end)
    if g.SDK.UIInput then
        self.handle=assert(g.SDK.UIInput:Register(self,function(msg,key)return self:Event(msg,key)end,
            function()return family.active and g.OrbamaFamily==family end))
    end
    self.draw=function()if family.active then self:Draw()end end
    local overlay=g.SDK.Overlay
    if overlay and overlay.GetCapabilities and overlay:GetCapabilities().ownedScopes then
        self.overlayScope=overlay:Register('Family.guide',{active=function()return family.active and g.OrbamaFamily==family end})
        if self.overlayScope then self.overlayScope:Renderer('guide',function(d)self.display=d;overlay.forcedLayer=5;self:Draw();overlay.forcedLayer=nil;self.display=nil end,5)end
    end
    if not self.overlayScope then table.insert(g.SDK.OnDraw,self.draw)end
    return self
end
function G:Register(owner,titles,page,config,links,activate)
    if self.groups[owner] then return false,'owner_registered' end
    self.groups[owner]=true
    for index,title in ipairs(titles) do
        self.pages[#self.pages+1]={owner=owner,index=index,page=page,config=config or self.config,links=links or plain,activate=activate}
        self.titles[#self.titles+1]=title
    end
    return true
end
function G:RegisterLee(guide,links)
    if self.groups.champion then return end
    self.config=guide.ctx.config
    local offset=#self.pages
    self:Register('champion',guide.titles,function(index)return guide:page(index)end,self.config,links,
        function(link)return guide:Activate(link)end)
    for i=offset+1,#self.pages do self.pages[i].topicOffset=offset end
    guide.familyManaged=true
end
function G:Search(text)
    local result={};text=(text or ''):lower()
    for i,title in ipairs(self.titles) do if title:lower():find(text,1,true)then result[#result+1]=i end end
    return result
end
function G:Available()
    local game=self.g.Game
    return self.family.active and not game.IsChatOpen() and (not game.IsOnTop or game.IsOnTop())
end
function G:Event(msg,key)
    if msg~=256 and msg~=257 and msg~=260 and msg~=261 and msg~=513 and msg~=514 then return false end
    if not self:Available() then self.down={};self.pressed=nil;return false end
    local cfg=self.config;local open=cfg:get('guideOpen')
    if msg==257 or msg==261 then local owned=self.down[key];self.down[key]=nil;return owned==true end
    if msg==256 or msg==260 then
        if key~=cfg:key('guideKey') and not (open and (key==cfg:key('guidePreviousKey') or key==cfg:key('guideNextKey'))) then return false end
        local sdk=self.g.SDK
        for _,bindings in pairs(sdk.Orbwalker.MenuKeys or {})do for _,node in ipairs(bindings)do
            if node.Key and node:Key()==key then return false end
        end end
        for _,name in ipairs({'Q','W','E','R','SUMMONER_1','SUMMONER_2'})do if self.g['HK_'..name]==key then return false end end
        if self.down[key] then return true end;self.down[key]=true
        if key==cfg:key('guideKey') then cfg:set('guideOpen',not open)
        else self.page=(self.page-1+(key==cfg:key('guideNextKey') and 1 or -1))%#self.pages+1 end
        self.hits={};self.pressed=nil;return true
    end
    if msg~=513 and msg~=514 then return false end
    if not open then self.pressed=nil;return false end
    local ui=self.renderers[plain];local pointer=ui.pointer();local inside=ui.inside(pointer,self.panel)
    local hit
    for _,candidate in ipairs(self.hits or {})do if ui.inside(pointer,candidate)then hit=candidate.link;break end end
    if msg==513 then self.pressed=inside and {link=hit,page=self.page} or nil;return inside==true end
    local pressed=self.pressed;self.pressed=nil
    local old=pressed and pressed.link
    if pressed and pressed.page==self.page and hit and old and
        hit.key==old.key and hit.topic==old.topic and hit.close==old.close and hit.global==old.global then
        if hit.close then cfg:set('guideOpen',false)
        elseif hit.topic then self.page=hit.topic+(hit.global and 0 or self.pages[self.page].topicOffset or 0)
        else local row=self.pages[self.page];if row.activate then row.activate(hit)end end
        self.content=nil
    end
    return pressed~=nil or inside==true
end
function G:Draw()
    if not self.config:get('guideOpen') or not self:Available() then self.hits=nil;return end
    local g=self.display and setmetatable({Draw=self.display},{__index=self.g})or self.g;local size=g.Game.Resolution and g.Game.Resolution() or {x=1920,y=1080}
    local scale=math.min((size.x-32)/850,(size.y-32)/620,math.max(.8,math.min(1.4,size.y/1080))*(self.config:get('guideScale') or 100)/100)
    if scale<=0 or not g.Draw or not g.Draw.Rect then return end
    if g.SDK.Overlay then g.SDK.Overlay:Reserve('guide',math.floor((size.x-850*scale)/2),math.floor((size.y-620*scale)/2),850*scale,620*scale)end
    local row=self.pages[self.page];if not row then return end
    self.ctx={config=row.config}
    local UI=self.renderers[row.links]
    if not UI then UI=renderer(row.links,widths);self.renderers[row.links]=UI end
    local ui=UI.new(self,math.floor((size.x-850*scale)/2),math.floor((size.y-620*scale)/2),scale,self.page)
    ui:rect(0,0,850,620,{13,21,29});ui:rect(0,0,218,620,{18,29,38})
    ui:text('AYYYYIO FAMILY',20,25,18,{91,231,186});ui:text('FIELD GUIDE',20,55,24,{237,244,248})
    local offset=math.floor((self.page-1)/13)*13
    for i=offset+1,math.min(#self.pages,offset+13)do
        local y=105+(i-offset-1)*32
        ui:hit(12,y-4,194,29,{topic=i,global=true,label=self.titles[i]})
        if i==self.page then ui:rect(12,y-4,194,29,{30,57,65})end
        ui:text(self.titles[i],22,y,12,{222,233,242})
    end
    local now=g.Game.Timer()
    if not self.content or self.contentPage~=self.page or now>=(self.contentAt or 0)+.2 then
        self.content=row.page(row.index);self.contentPage=self.page;self.contentAt=now;self.spanCache={}
    end
    local page=self.content;local rules=row.links.rules and row.links.rules(row.index) or empty
    ui:rich(page.title,240,25,575,24,rules,{237,244,248},true)
    local y=70+ui:rich(page.subtitle or '',240,70,575,14,rules,{142,163,180},true)+12
    for i,card in ipairs(page.cards or {}) do
        local cr=row.links.rules and row.links.rules(row.index,i) or rules
        ui:rich(card[1],240,y,575,13,cr,{164,187,209},true);y=y+24
        y=y+ui:rich(card[2],240,y,575,14,cr,nil,true)+18
    end
    ui:rich(page.note or '',240,math.max(y,526),575,12,rules,{180,195,211},true)
    ui:hit(240,590,145,22,{topic=(self.page-2)%#self.pages+1,global=true,label='Previous'})
    ui:hit(410,590,145,22,{topic=self.page%#self.pages+1,global=true,label='Next'})
    ui:hit(695,590,135,22,{close=true,label='Close'})
    ui:text(label(self.config:key('guidePreviousKey'))..' Previous',244,590,12,{139,184,255})
    ui:text(label(self.config:key('guideNextKey'))..' Next',414,590,12,{139,184,255})
    ui:text(label(self.config:key('guideKey'))..' Close',714,590,12,{91,231,186})
end
function G:Shutdown()
    if self.overlayScope then self.overlayScope:Close();self.overlayScope=nil end
    if self.handle then self.handle:Close()end
    local list=self.g.SDK.OnDraw
    for i=#list,1,-1 do if list[i]==self.draw then table.remove(list,i)end end
    self.down={};self.hits={};self.pressed=nil
end
return G

end
