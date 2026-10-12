return function(require)
-- Controller display adapter. Optional work never delays mechanical validation.
local M={}
function M.new(g,owner,active,draw,state,estimate,sharedScope)
 local sdk=g.SDK;local service=sdk and sdk.Overlay
 if not service or not service.GetCapabilities or not service:GetCapabilities().ownedScopes then return end
 local family=g.AyyyyIO
 local scope=sharedScope
 if not scope then if family and family.GetOverlayScope then scope=family:GetOverlayScope('champion')else scope=service:Register(owner,{active=active})end end
 if not scope then return end
 local c={scope=scope,service=service,active=active}
 if state then scope:Renderer(owner..'.status',function()
  local now=g.Game.Timer();local records=state()
  for id,r in pairs(records or {})do r.feature='champion';r.anchor='hud';r.expires=now+.2;scope:Set(id,r)end
 end,4)end
 scope:Renderer(owner,function(d)if draw then draw(d)end end,2)
 local preparation=sdk.Preparation
 -- estimate() answers unit,damage,partial (one row) or a list of
 -- {unit,damage,partial,killable,far} (one health-bar row per enemy, at most 5;
 -- a far row draws no health bar, only its minimap mark).
 -- A killable row also gets a small "KILL" label at the enemy on the minimap. It
 -- stays MAP_HOLD seconds after the last killable estimate, so an estimate that
 -- crosses the threshold back and forth or a skipped preparation never blinks it;
 -- it goes at once when the enemy dies, leaves vision or changes identity.
 local MAP_HOLD=1
 local published,marked={},{}
 local function publish(a,b,c2)
  local rows=b~=nil and{{unit=a,damage=b,partial=c2}}or type(a)=='table'and a or{}
  local now,seen=g.Game.Timer(),{}
  for i=1,math.min(#rows,5)do local r=rows[i];local unit=r.unit
   if unit and r.damage and r.damage>0 then
    local id,handle=unit.networkID,unit.handle
    local function live()return unit.networkID==id and unit.handle==handle and unit.valid~=false and not unit.dead and unit.visible==true end
    if not r.far then
     local key=i==1 and #rows==1 and'current-damage'or'damage:'..tostring(id)
     seen[key]=true
     scope:Set(key,{feature='damage',kind='damage',anchor='healthbar',unit=unit,damage=r.damage,partial=r.partial~=false,killable=r.killable==true,
      priority=60,expires=now+.25,valid=live})
    end
    if r.killable==true and id then
     local key='kill-map:'..tostring(id)
     scope:Set(key,{feature='damage',kind='text',anchor='minimap',unit=unit,text='KILL',size=10,priority=55,
      expires=now+MAP_HOLD,valid=live})
     marked[key]=now
    end
   end
  end
  for key in pairs(published)do if not seen[key]then scope:Remove(key)end end
  published=seen
  for key,at in pairs(marked)do if now-at>=MAP_HOLD then marked[key]=nil;scope:Remove(key)end end
 end
 c.publish=publish
 if estimate and preparation and preparation.version==1 then
  c.preparation=preparation:Register(owner..'.damage',{active=active})
  c.config={intervalMs=100,maxDelayMs=250,units=1,maxUnits=1}
  c.work=function()publish(estimate());return true end
 end
 function c:Prepare(visible)
  if not self.active()then self:Close();return end
  if not visible then if self.preparation then self.preparation:CancelJob('damage')end;publish(nil);return end
  if self.failed or not estimate then return end
  local ok,reason,err
  if self.preparation then ok,reason,err=self.preparation:Run('damage',self.config,self.work)
  elseif g.Game.Timer()>=(self.nextAt or 0)then self.nextAt=g.Game.Timer()+.1;ok,err=pcall(function()
   publish(estimate())
  end);if not ok then reason='callback_error'end end
  if reason=='callback_error'then self.failed=true;publish(nil);if self.preparation then self.preparation:CancelJob('damage')end;service:Error(owner,'damage preparation',err)end
 end
 function c:Close()if self.preparation then self.preparation:Close();self.preparation=nil end;scope:Close()end
 return c
end
return M

end
