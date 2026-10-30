return function(require)
-- Shared health-bar rendering. Controllers supply prepared estimates and appearance only.
return function(g,d,r,scale,project)
 local function finite(v)return type(v)=='number'and v==v and math.abs(v)<math.huge end
 local u=r.unit
 if not u or u.dead or u.visible~=true or not finite(u.health)or u.health<=0 or not finite(u.maxHealth)or u.maxHealth<=0
  or not finite(r.damage)or r.damage<1 then return end
 scale=scale or 1;local a=r.appearance or {};local width=(a.width or 100)*scale;local height=(a.height or 3)*scale
 local hp=u.hpBar;local native=hp and finite(hp.x)and finite(hp.y)and hp.onScreen~=false and(hp.x~=0 or hp.y~=0)
 local p
 if not native then
  if project then p=project(u.pos)else local point=g.Vector(u.pos);p=point and point:To2D();if p and p.onScreen==false then p=nil end end
  if not p or not finite(p.x)or not finite(p.y)then return end
 end
 local x=native and hp.x+(a.offsetX or 0)*scale or p.x-width/2
 local y=(native and hp.y+(a.offsetY or 12)*scale or p.y-65*scale)+(a.stripOffset or 0)*scale
 local health=math.max(0,math.min(1,u.health/u.maxHealth))*width;local loss=math.min(health,r.damage/u.maxHealth*width)
 local col=a.color or {220,65,225,165};local size=math.floor(14*scale)
 d.Rect(x,y,health,height,d.Color(180,22,30,35));d.Rect(x+health-loss,y,loss,height,d.Color(unpack(col)))
 if r.partial and a.partialMarker~=false then d.Text('~',size,x-10*scale,y-5*scale,d.Color(220,200,210,215))end
 if a.text then d.Text((a.label or '~')..math.floor(r.damage)..(r.partial and ' *partial'or ''),math.floor(12*scale),x,y+height+3*scale,d.Color(230,230,230,240))end
 if r.killable and(not r.killValid or r.killValid())then d.Text('KILL',size,x+width+4*scale,y-5*scale,d.Color(240,255,70,70))end
 return true,x,y,native and 'healthbar'or 'world'
end

end
