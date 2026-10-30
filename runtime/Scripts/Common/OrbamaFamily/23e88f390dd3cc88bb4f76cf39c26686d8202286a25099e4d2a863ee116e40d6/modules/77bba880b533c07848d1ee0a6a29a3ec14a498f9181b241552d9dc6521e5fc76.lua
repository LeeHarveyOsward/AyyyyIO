return function(require)
local G=require('evade.geometry')
local Contours=require('evade.contours')
local ChannelLink=require('evade.channel_link')
local V={};V.__index=V
function V.new(g)return setmetatable({g=g,prepared={},cache={},projected={},signature={},currentSignature={},builds=0,maxVertices=4096},V)end
local function on(app,key)return not app.menu or not app.menu[key]or app.menu[key]:Value()end
function V:ResetPreparation()
    self.work=nil
    for i=#self.prepared,1,-1 do self.prepared[i]=nil end
    for id in pairs(self.cache)do self.cache[id]=nil end
end
function V:Prepare(app,now,token)
    if not on(app,'DrawEnabled')or not on(app,'DrawThreats')then self:ResetPreparation();return true end
    local timing=on(app,'DrawTiming');local all=on(app,'DrawAllThreats')
    local work=self.work
    if not work or work.timing~=timing or work.all~=all or now<work.started then
        work={ids={},rows={},live={},vertices=0,index=1,started=now,timing=timing,all=all};self.work=work
        -- Capture bounded identities, not mutable list indexes. New observations
        -- remain in planning immediately and enter the next display pass.
        local ordered={};for i=1,math.min(512,#app.threats.list)do ordered[i]=app.threats.list[i]end
        table.sort(ordered,function(a,b)return a.starts==b.starts and tostring(a.id)<tostring(b.id)or a.starts<b.starts end)
        for i,s in ipairs(ordered)do work.ids[i]=s.id end
    end
    local first=true
    while work.index<=#work.ids do
        if not first and token and not token:Checkpoint(1)then return false end
        first=false
        local s=app.threats.byID[work.ids[work.index]];work.index=work.index+1
        if s and not ChannelLink.Covered(app.threats.byID,s)then
        local a=s.contourOrigin or s.origin or s.a
        if (not app.menu or not app.menu.DrawAllThreats or app.menu.DrawAllThreats:Value()or s.starts<=now+2 and(a and G.dist(a,self.g.myHero.pos)<2000 or a and s.b and G.segment(self.g.myHero.pos,a,s.b)<1500))and s.shape~='targeted'and s.ends>=now and(not a or G.dist(a,self.g.myHero.pos)<5000
            or s.b and G.segment(self.g.myHero.pos,a,s.b)<2000)then
            -- Apply the vertex budget before allocating a mesh. A compound
            -- threat can be much larger than one simple contour.
            if work.vertices+Contours.vertexCount(s)>self.maxVertices then break end
            local id=s.stageID or s.instanceID or s.id
            local key=Contours.signature(s,now,self.signature);local entry=self.cache[id]
            if not entry or not Contours.same(entry.signature,key)then
                if entry and app.recorder and app.recorder.enabled and now>=(self.nextChangeLog or 0)then
                    self.nextChangeLog=now+.0625
                    app.recorder:Event('contour_changed',{id=s.id,instanceID=s.instanceID,
                        reason=Contours.reason(entry.signature,key),evidence=s.evidence,
                        radius=s.radius,widthSource=s.widthSource,endpointSource=s.endpointSource,
                        x=a and a.x,z=a and a.z,toX=s.b and s.b.x,toZ=s.b and s.b.z})
                end
                local signature={};for i,v in ipairs(key)do signature[i]=v end
                entry={signature=signature,mesh=Contours.build(s,now),firstDrawn=entry and entry.firstDrawn}
                self.cache[id]=entry;self.builds=self.builds+1
            end
            local cost=Contours.cost(entry.mesh)
            if work.vertices+cost<=self.maxVertices then
                work.live[id]=true;work.vertices=work.vertices+cost
                local row={mesh=entry.mesh,starts=s.starts,ends=s.ends,entry=entry,id=s.id,source=s,
                    preparedAt=now,observedAt=s.observedAt,motionUnknown=s.motionUnknown}
                if not s.motionUnknown and not s.speedUncertain and timing and #work.rows<6 then
                    row.future={}
                    local start=s.launch or s.starts
                    if start>now then row.label={pos=G.center(s,now),text='Cast: '..math.floor((start-now)*1000)..' ms'}end
                    if s.shape=='missile'then for _,dt in ipairs({.25,.5})do
                        local at=now+dt
                        if at>=start and at<=s.ends then
                            row.future[#row.future+1]={pos=G.center(s,at),radius=s.radius,text='+'..math.floor(dt*1000)..' ms'}
                        end
                    end end
                end
                work.rows[#work.rows+1]=row
                if #work.rows>=64 then break end
            end
        end
        end
    end
    self.prepared=work.rows;self.work=nil
    for id in pairs(self.cache)do if not work.live[id]then self.cache[id]=nil end end
    return true
end
local function samePoint(a,b)
    return a==b or a and b and a.x==b.x and a.y==b.y and a.z==b.z
end
function V:Current(row,app,now)
    local source=row.source
    if not source then return row.ends>=now end -- Legacy, explicitly prepared external rows.
    local current=app.threats.byID[row.id]
    if not current or current.ends<now then return false end
    if (source.motion or source.shape=='compound')and now-row.preparedAt>.1 then return false end
    if source==current then return true end
    if source.instanceID~=nil and source.instanceID==current.instanceID and source.stageID==current.stageID
        and source.shape==current.shape and not source.motion and not current.motion
        and not source.speed and not current.speed and source.shape~='compound'then
        -- Observation refreshes do not invalidate an unchanged outline. A circle
        -- or ring can also follow its current observed anchor without a new mesh.
        if (source.shape=='circle'or source.shape=='ring')and source.radius==current.radius
            and source.innerRadius==current.innerRadius then
            local a,b=source.origin or source.a,current.origin or current.a
            return true,b.x-a.x,(b.y or 0)-(a.y or 0),b.z-a.z
        end
        if Contours.same(row.entry.signature,Contours.signature(current,now,self.currentSignature))then return true end
    end
    -- A progressing fixed missile keeps its prepared cast contour; Draw clips
    -- its passed tail per frame (V:Tail). Redirects, replacements and moving
    -- anchors must wait for fresh admitted preparation.
    return source.instanceID~=nil and source.instanceID==current.instanceID
        and source.stageID==current.stageID and source.shape=='missile'and current.shape=='missile'
        and not source.motion and not current.motion and source.radius==current.radius
        and samePoint(source.contourOrigin or source.origin,current.contourOrigin or current.origin)
        and samePoint(source.b,current.b)
end
-- Clip projected edges, not world contours. Both endpoints can be outside
-- while a long projectile still crosses the viewport.
local function clip(ax,ay,bx,by,width,height)
    if ax<0 and bx<0 or ax>width and bx>width or ay<0 and by<0 or ay>height and by>height then return end
    if ax>=0 and ax<=width and ay>=0 and ay<=height
        and bx>=0 and bx<=width and by>=0 and by<=height then return ax,ay,bx,by end
    local dx,dy=bx-ax,by-ay;local lo,hi=0,1
    if dx==0 then if ax<0 or ax>width then return end
    else
        local first,last=-ax/dx,(width-ax)/dx
        if first>last then first,last=last,first end
        lo=math.max(lo,first);hi=math.min(hi,last)
        if lo>hi then return end
    end
    if dy==0 then if ay<0 or ay>height then return end
    else
        local first,last=-ay/dy,(height-ay)/dy
        if first>last then first,last=last,first end
        lo=math.max(lo,first);hi=math.min(hi,last)
        if lo>hi then return end
    end
    return ax+dx*lo,ay+dy*lo,ax+dx*hi,ay+dy*hi
end
-- Distance along a prepared missile capsule already passed by the projectile's
-- rear edge (disc center at now). Matches the planner's moving-disc danger:
-- the same travel model as G.center/G.distance, including speed bounds, where
-- the slowest possible position is used. Returns 0 (full contour) whenever the
-- current threat is not a fixed flight on the prepared ray. No allocation.
function V.Tail(mesh,current,now)
    local tail=mesh and mesh.tail
    if not tail or not current or current.shape~='missile'or current.motion or current.motionUnknown then return 0 end
    local o=current.origin or current.a;if not o or not G.finite(o.x)or not G.finite(o.z)then return 0 end
    local px,pz=o.x-tail.ax,o.z-tail.az
    local cross=px*tail.dz-pz*tail.dx
    if cross>2 or cross<-2 then return 0 end
    local dt=now-(current.launch or current.starts);if not G.finite(dt)then return 0 end
    if dt<0 then dt=0 end
    local travel
    if current.speedUncertain then travel=(current.minSpeed or 0)*dt else travel=G.travel(current,dt)end
    if not G.finite(travel)then return 0 end
    local d=px*tail.dx+pz*tail.dz+travel
    if d<=0 then return 0 end
    if d>tail.length then d=tail.length end
    return d
end
-- Returns whether any part was submitted on screen. `probe` (until the first
-- visible draw of a contour) also proves circles visible before submitting
-- them; afterwards the shared overlay culls invisible circles at dispatch.
function V:Mesh(mesh,color,width,height,shift,offsetX,offsetY,offsetZ,probe)
    local projected=self.projected
    offsetX,offsetY,offsetZ=offsetX or 0,offsetY or 0,offsetZ or 0
    local tail=shift and shift>0 and mesh.tail
    local first,last=tail and tail.first or 0,tail and tail.last or -1
    local sx,sz=tail and tail.dx*shift or 0,tail and tail.dz*shift or 0
    -- Copy scalar coordinates into reusable storage. Host projection objects
    -- do not escape this vertex read; every Draw still projects fresh points.
    for i,p in ipairs(mesh.vertices)do
        local q
        if i>=first and i<=last then q=self:ScreenXYZ(p.x+sx+offsetX,p.y+offsetY,p.z+sz+offsetZ)
        else q=self:ScreenXYZ(p.x+offsetX,p.y+offsetY,p.z+offsetZ)end
        projected[i*2-1]=q and q.x or false;projected[i*2]=q and q.y or false
    end
    local d=self.display or self.g.Draw
    local line=d.Line;if not line then return false end
    local drawn=false
    for _,edge in ipairs(mesh.edges)do
        local a,b=edge[1]*2,edge[2]*2
        local ax,ay,bx,by=projected[a-1],projected[a],projected[b-1],projected[b]
        if ax and bx then
            if width then
                ax,ay,bx,by=clip(ax,ay,bx,by,width,height)
                if ax then line(ax,ay,bx,by,1,color);drawn=true end
            else line(ax,ay,bx,by,1,color);drawn=true end
        end
    end
    local circles,vector=mesh.circles,self.g.Vector
    if circles and circles[1]and d.Circle and vector then
        local overlay=probe and not drawn and self.g.SDK and self.g.SDK.Overlay
        for _,c in ipairs(circles)do
            local x,y,z=c.x+offsetX,c.y+offsetY,c.z+offsetZ
            if not overlay or overlay:CircleVisible(x,y,z,c.radius)then
                d.Circle(vector(x,y,z),c.radius,1,color);drawn=true;overlay=nil
            end
        end
    end
    return drawn
end
function V:Screen(p)
    if not G.point(p)then return end
    return self:ScreenXYZ(p.x,p.y,p.z)
end
function V:ScreenXYZ(x,y,z)
    if not G.finite(x)or not G.finite(z)then return end
    local vector=self.g.Vector
    if not vector then return end
    local v=vector(x,y or 0,z)
    if not v or type(v.To2D)~='function'then return end
    local q=v:To2D();if q and G.finite(q.x)and G.finite(q.y)then return q end
end
function V:Line(a,b,color,width)
    local x,y=self:Screen(a),self:Screen(b)
    if x and y and (self.display or self.g.Draw).Line then
        local overlay=self.g.SDK and self.g.SDK.Overlay
        if overlay then local ax,ay,bx,by=overlay:Clip(x.x,x.y,y.x,y.y);if ax then (self.display or self.g.Draw).Line(ax,ay,bx,by,width or 2,color)end
        else (self.display or self.g.Draw).Line(x.x,x.y,y.x,y.y,width or 2,color)end
    end
end
-- One native circle; the shared overlay culls it when it is off screen.
function V:Circle(p,r,color,width)
    if not G.point(p)or not G.finite(r)or r<=0 then return end
    local d=self.display or self.g.Draw;local vector=self.g.Vector
    if d.Circle and vector then d.Circle(vector(p.x,p.y or 0,p.z),r,width or 2,color)end
end
function V:Label(pos,text,color)
    local p=self:Screen(pos);local d=(self.display or self.g.Draw)
    if p and d.Text then d.Text(text,14,p.x+8,p.y-18,color)end
end
function V:Status(app)
    if not app.active then return end
    local g=self.g;local menu=app.menu
    local enabled=app.enabled;if menu and menu.Enabled then enabled=menu.Enabled:Value()end
    local function on(key)return not menu or not menu[key]or menu[key]:Value()end
    if app.overlayScope and on('DrawStatus')then
        local reason=enabled and(app:Bypass()and 'bypass'or not app.terrain:Ready()and 'terrain unavailable')or nil
        -- The shared row shows "off" only by colour and a hollow marker; the word is part of the label
        -- (live 2026-10-08: Evade stayed switched off for a whole game unnoticed).
        app.overlayScope:Set('evade',{kind='status',feature='evade',anchor='hud',label=enabled and 'Evade'or 'Evade off',
            bind=menu and menu.Enabled and menu.Enabled.Key and menu.Enabled:Key(),enabled=enabled,reason=reason,priority=100,expires=g.Game.Timer()+.2,
            secondary=menu and menu.Bypass and menu.Bypass.Key and {label='hold to bypass',bind=menu.Bypass:Key()}or nil})
    elseif app.overlayScope then app.overlayScope:Remove('evade')end
end
function V:Draw(app,display)
    self.display=display
    local g=self.g;local d=self.display or g.Draw;if not d or not d.Color or not app.active then return end
    local menu=app.menu
    local enabled=app.enabled;if menu and menu.Enabled then enabled=menu.Enabled:Value()end
    local function on(key)return not menu or not menu[key]or menu[key]:Value()end
    if not self.statusSeparated then self:Status(app)end
    if not on('DrawEnabled')then return end
    local now=g.Game.Timer();local red=d.Color(210,255,105,110);local green=d.Color(230,110,240,185)
    local amber=d.Color(210,250,205,95);local white=d.Color(230,235,235,240)
    local future=d.Color(150,110,185,255);local intent=d.Color(140,190,190,205)
    if on('DrawThreats')and #self.prepared>0 then
        local width,height
        if g.SDK and g.SDK.Overlay then width,height=g.SDK.Overlay:Viewport();width,height=width-1,height-1
        elseif type(g.Game.Resolution)=='function'then
            local ok,size=pcall(g.Game.Resolution)
            if ok and (type(size)=='table'or type(size)=='userdata')
                and G.finite(size.x)and G.finite(size.y)and size.x>=1 and size.y>=1 then
                width,height=size.x-1,size.y-1
            end
        end
        for _,s in ipairs(self.prepared)do
            local current,dx,dy,dz=self:Current(s,app,now)
            if current then
                local shift=s.mesh.tail and V.Tail(s.mesh,app.threats.byID[s.id],now)or 0
                local drawn=self:Mesh(s.mesh,(s.motionUnknown or s.starts>now)and amber or red,width,height,shift,dx,dy,dz,not s.entry.firstDrawn)
                if drawn and not s.entry.firstDrawn then
                    s.entry.firstDrawn=now
                    if s.observedAt then app.metrics:Sample('detection_to_first_draw_ms',(now-s.observedAt)*1000)end
                    -- The family development recorder is authoritative; its stripped
                    -- local metrics adapter does not persist Sample calls.
                    if app.recorder and app.recorder.enabled then
                        if now>=(self.nextFirstDrawLog or 0)then
                            self.nextFirstDrawLog=now+.0625
                            app.recorder:Event('first_contour_draw',{id=s.id,observedAt=s.observedAt,
                                delayMs=s.observedAt and(now-s.observedAt)*1000,
                                suppressed=self.suppressedFirstDraws or 0})
                            self.suppressedFirstDraws=0
                        else self.suppressedFirstDraws=(self.suppressedFirstDraws or 0)+1 end
                    end
                end
                if on('DrawTiming')and(not s.preparedAt or now-s.preparedAt<=.1)then
                    if s.label then self:Label(s.label.pos,s.label.text,future)end
                    for _,p in ipairs(s.future or {})do self:Circle(p.pos,p.radius,future);self:Label(p.pos,p.text,future)end
                end
            end
        end
    end
    local preview=app.preview
    if preview and now-preview.at<=.25 then
        if on('DrawIntent')and preview.intent then
            local origin=g.myHero.pos;local length=G.dist(origin,preview.intent)
            local endPos=length>450 and G.lerp(origin,preview.intent,450/length)or preview.intent
            self:Line(origin,endPos,intent,1)
        end
        if on('DrawTiming')and G.finite(preview.impact)and preview.impact>=now then
            self:Label(g.myHero.pos,'Projected contact: '..math.floor((preview.impact-now)*1000)..' ms',amber)
        end
    end
    if on('DrawPath')and app.route and app.route.path
        and app.route.threatRevision==app.threats.revision and app.route.terrainRevision==app.terrain.revision then
        local p=g.myHero.pos
        local color=app.route.safe and green or amber
        for _,q in ipairs(app.route.path)do self:Line(p,q,color,3);p=q end
        self:Circle(p,35,color)
    end
    if not app.overlayScope and on('DrawStatus')and d.Text then
        local state=not enabled and 'OFF'or app:Bypass()and 'BYPASS'or app.intervening and 'DODGING'
            or not app.terrain:Ready()and 'TERRAIN UNAVAILABLE'or 'ON'
        local text='Orbama Evade: '..state..' | '..tostring(#app.threats.list)..' threats'
        d.Text(text,18,30,160,enabled and green or white)
    end
end
return V

end
