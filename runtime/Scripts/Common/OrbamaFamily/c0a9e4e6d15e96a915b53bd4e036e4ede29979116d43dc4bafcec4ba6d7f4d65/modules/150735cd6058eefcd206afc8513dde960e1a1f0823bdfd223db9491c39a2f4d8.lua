return function(require)
-- Shared bounded controller primitives. Champion decisions remain in extensions.
return function(g,C,P)
 local H,G,SDK=g.myHero,g.Game,g.SDK
 local finite=P.Finite
 local function id(u)return u and(u.networkID or u.handle)end
 local function distance(a,b)local dx,dz=a.x-b.x,a.z-b.z;return math.sqrt(dx*dx+dz*dz)end
 local function point(p)return p and finite(p.x)and finite(p.z)and g.Vector(p.x,p.y or H.pos.y,p.z)end
 local slots={'Q','W','E','R'}
 local F={};F.__index=F
 F.id=id;F.distance=distance;F.point=point;F.finite=finite
 function F:newController(controller,hooks)
  local self=setmetatable({controller=controller,profile=assert(P.Get(H.charName)),targets={},sequences={},gestures={},objects={},predictionSettings={},predictionCount=0,nextDiscovery=0},F)
  local ext=assert(hooks);self.ext=ext
  self:LoadMenu();controller.profile=self.profile
  self.consent=C:TargetConsent(self.menu.Misc.Targets,self);self.targets=self.consent.targets
  C:RegisterCleanup(self.profile.champion,function(reason)self:Cleanup(reason)end)
  g.Callback.Add('Tick',function()controller:Tick()end);g.Callback.Add('Draw',function()controller:Draw()end)
  if SDK.Orbwalker.OnPostAttack then SDK.Orbwalker:OnPostAttack(function(args)self:ObserveAttack(args)end)end
  local accepted,why=C:RegisterPreparation(self.profile.champion..'.preview',{intervalMs=125,maxDelayMs=400,units=1,maxUnits=1},
   function()self:PreparePreview();return true end,function()return self.menu.Draw.Preview:Value()end,function()self.preview=nil end)
  self.previewFallback=not accepted and why=='unsupported'
  if ext.initialize then ext.initialize(self)end
  C:RegisterComboDamage(ext.comboDamage and function(u)return ext.comboDamage(self,u)end or function(u)
   local total=0
   for slot=0,3 do if self:Ready(slot)then local ok,d=pcall(self.Damage,self,slot,u);if ok and finite(d)and d>0 then total=total+d end end end
   local ok,aa=pcall(SDK.Damage.GetAutoAttackDamage,SDK.Damage,H,u,true);if ok and finite(aa)then total=total+aa end
   return total,true
  end)
  self:DiscoverTargets();return self
 end
 -- One menu for every controller built on this core. An entry exists only when
 -- the champion implements it: hooks name the shared options they read in
 -- `options`, the abilities each mode uses in `modeSlots` ({LastHit={'Q'},...}),
 -- and the selected-target binds they implement in `assistLabels`.
 -- An absent option still answers its default, so readers need no guards.
 function F:LoadMenu()
  local ext=self.ext;local menu=g.MenuElement({type=g.MENU,id='Classic_AIO_'..H.charName,name='AyyyyIO - '..self.profile.champion});self.menu=menu
  local used={};for _,name in ipairs(ext.options or {})do used[name]=true end
  local all=ext.options==nil
  local function option(node,shown,spec)
   if shown then node:MenuElement(spec);return end
   local value=spec.value
   node[spec.id]={fixed=true,Value=function(_,v)if v~=nil then value=v end;return value end,Key=function()return spec.key end}
  end
  for _,mode in ipairs({'Combo','Harass','LaneClear','JungleClear','LastHit','Flee'})do
   menu:MenuElement({type=g.MENU,id=mode,name=mode})
    for _,slot in ipairs(slots)do
      local ability=self.profile[slot:lower()];local mobility=ability and ability.mobility==true
     -- Defaults use every advantage the kit offers: the whole combo while the
     -- player holds Combo, dashes included; poke without committing in Harass;
     -- mobility to escape in Flee. Farming is still gated by the one toggle.
     -- A hook table overrides single entries in `defaults[mode][slot]`.
     local value=slot~='R'and(mode=='Combo'or mode=='Flee'and mobility or mode~='Flee'and not mobility)
     local override=ext.defaults and ext.defaults[mode]and ext.defaults[mode][slot]
     if override~=nil then value=override end
     -- `modeSlots[mode]` lists the abilities the champion really uses in that
     -- mode; the others answer their default without a menu entry.
     local declared=ext.modeSlots and ext.modeSlots[mode]
     local shown=declared==nil
     if declared then for _,used in ipairs(declared)do if used==slot then shown=true;break end end end
     option(menu[mode],shown,{id=slot,name='Use '..slot,value=value})
    end
   menu[mode]:MenuElement({id='Mana',name='Only above mana %',value=mode=='Harass'and 35 or(mode=='Combo'or mode=='Flee')and 0 or 15,min=0,max=100,step=5})
  end
  menu:MenuElement({type=g.MENU,id='Clear',name='Farming'})
   menu.Clear:MenuElement({id='SpellFarm',name='Use abilities to farm (lane, jungle, last hit)',value=g.SpellFarmDefault(),toggle=true,key=73,callback=function(v)g.CheckChatBlock(menu.Clear.SpellFarm,v)end})
  menu.LaneClear:MenuElement({id='Count',name='Lane minions an ability must hit',value=2,min=1,max=10,step=1})
  menu:MenuElement({type=g.MENU,id='Misc',name='Behaviour'})
  menu.Misc:MenuElement({type=g.MENU,id='Targets',name='Enemy champions abilities may target'})
  local labels=ext.assistLabels or ext.assist and all and {[0]='Cast Q at the selected target',[3]='Cast R at the selected target'}or {}
  option(menu.Misc,labels[0]~=nil,{id='QAssist',name=labels[0]or '',key=string.byte('T')})
  option(menu.Misc,labels[3]~=nil,{id='RAssist',name=labels[3]or '',key=string.byte('U')})
  option(menu.Misc,all or used.Risk,{id='Risk',name='Dash to enemies outside attack range',value=true})
  option(menu.Misc,all or used.Risk or used.HP,{id='HP',name='Never dash in below health %',value=30,min=0,max=100,step=5})
  option(menu.Misc,all or used.Risk,{id='Enemies',name='Never dash into more enemies than',value=2,min=0,max=5,step=1})
  option(menu.Misc,all or used.Independent,{id='Independent',name='Use shields and heals without holding a mode key',value=true})
  option(menu.Misc,ext.secure~=nil,{id='KillSecure',name='Finish killable enemies without holding a mode key',value=true})
  option(menu.Misc,ext.secure~=nil,{id='KSMana',name='Finishers only above mana %',value=0,min=0,max=100,step=5})
  option(menu.Misc,ext.gapclose~=nil,{id='Gapclose',name='Answer enemy dashes onto you',value=true})
  -- No switch: Evade always may use defensive abilities and judges the danger
  -- itself. The id still answers true for readers written against the old menu.
  option(menu.Misc,false,{id='Evade',name='',value=true})
  option(menu.Misc,all or used.Interrupt,{id='Interrupt',name='Interrupt enemy channels while fighting',value=true})
  option(menu.Misc,all or used.PreferPassive,{id='PreferPassive',name='Use a ready empowered attack before casting',value=true})
  menu:MenuElement({type=g.MENU,id='Draw',name='Drawings'})
  menu.Draw:MenuElement({id='Ranges',name='Ranges of ready abilities',value=false})
  -- `previewLabel` names what the champion draws from its prepared preview; without
  -- one there is no switch and no preview work (enemy health bars already show the
  -- combo damage, the game shows passive and buff state).
  option(menu.Draw,ext.previewLabel~=nil,{id='Preview',name=ext.previewLabel or '',value=ext.previewLabel~=nil})
  -- `strikeLabel` names the angled strike the champion steers (F:MaintainStrike); off by default.
  option(menu.Draw,ext.strikeLabel~=nil,{id='Strike',name=ext.strikeLabel or '',value=false})
  if ext.menu then ext.menu(self,menu)end
 end
 function F:Cleanup(reason)
  for _,s in pairs(self.sequences)do if s.action then C.adapter:Cancel(s.action,reason or 'controller_closed')end;if s.reservation then C.adapter:ReleaseReservation(s.reservation,reason or 'controller_closed')end end
  if self.retiredReservation then C.adapter:ReleaseReservation(self.retiredReservation,reason or 'controller_closed');self.retiredReservation=nil end
  self.sequences={};self.preview=nil;self.objects={};self.attack=nil;self.gestures={}
  C:ReleaseAttackPreference(self.profile.champion)
  if self.steering then self.steering:Release(reason or 'cleanup')end;self.strikePlan=nil
  if self.ext.cleanup then self.ext.cleanup(self,reason)end
 end
 -- Units, consent, buffs and the rescue rule live in the shared core (core.lua).
 function F:Rows(kind,range,allies)return C:Rows(kind,range,allies)end
 function F:Current(u,allies)return C:CurrentUnit(u,allies)end
 function F:Reach(u,range,allies)return C:Reach(u,range,allies)end
 function F:DiscoverTargets()self.consent:Refresh();self.nextDiscovery=self.consent.nextRefresh end
 function F:Allowed(u)return self.consent:Allowed(u)end
 function F:Target(range)
  local ts=SDK.TargetSelector;local selected=ts.GetSelectedTarget and ts:GetSelectedTarget()
  if selected and self:Reach(selected,range)and self:Allowed(selected)then return selected end
  local candidate=ts:GetTarget(range,SDK.DAMAGE_TYPE_PHYSICAL)
  if self:Reach(candidate,range)and self:Allowed(candidate)then return candidate end
  for _,u in ipairs(self:Rows('hero',range))do if self:Allowed(u)then return u end end
 end
 function F:Buff(u,names,owned)return C:OwnBuff(u,names,owned)end
 function F:Stats(u)
  u=u or H;return {totalDamage=u.totalDamage,bonusDamage=u.bonusDamage,ap=u.ap,health=u.health,maxHealth=u.maxHealth,
   level=u.levelData and u.levelData.lvl,critChance=u.critChance,critDamage=SDK.Damage:GetCriticalStrikePercent(u),heroType=g.Obj_AI_Hero}
 end
 function F:Ready(slot)
  local s=H:GetSpellData(slot);local names=self.profile.names[slot+1];local known=false
  for _,name in ipairs(names or {})do if s and s.name==name then known=true;break end end
   local def=self.profile[slots[slot+1]:lower()];local maxRank=def.maxRank or(slot==3 and 3 or 5)
  if not known or not finite(s.level)or s.level%1~=0 or s.level<1 or s.level>maxRank or not finite(s.currentCd)or s.currentCd>0 or G.CanUseSpell(slot)~=0
   or not finite(s.mana)or s.mana<0 or not finite(H.mana)or H.mana<s.mana then return false end
   if def.requiresAmmo and(not finite(s.ammo)or s.ammo<=0)then return false end
  if def.healthCost and H.health-H.health*def.healthCost<math.max(1,H.maxHealth*self.menu.Misc.HP:Value()/100)then return false end
  return not self.ext.ready or self.ext.ready(self,slot,s)~=false
 end
 function F:Range(slot)return P.Range(H.charName,slot,H:GetSpellData(slot).level)end
 function F:Damage(slot,u,options)
  options=options or {};if self.profile.usesMantraDamage then options.mantra=self:Buff(H,self.profile.mantraNames)~=nil;options.ultimateRank=H:GetSpellData(3).level end
  local raw,kind=P.Raw(H.charName,slot,H:GetSpellData(slot).level,self:Stats(),u,options)
  if raw<=0 or kind=='shield'then return 0 end
  local dtype=kind=='physical'and SDK.DAMAGE_TYPE_PHYSICAL or kind=='magical'and SDK.DAMAGE_TYPE_MAGICAL or SDK.DAMAGE_TYPE_TRUE
  return SDK.Damage:CalculateDamage(H,u,dtype,raw)
 end
 function F:Raw(slot,u,options)return P.Raw(H.charName,slot,H:GetSpellData(slot).level,self:Stats(),u,options)end
 function F:Mana(node)return finite(H.maxMana)and(H.maxMana<=0 or H.mana/H.maxMana*100>=node.Mana:Value())end
 function F:Permission(mode,slot)
  local node=self.menu[mode];return node and node[slots[slot+1]]:Value()and self:Mana(node)
   and((mode~='LaneClear'and mode~='JungleClear'and mode~='LastHit')or self.menu.Clear.SpellFarm:Value())
 end
 function F:Context(mode,condition)
  if mode=='LaneClear'or mode=='JungleClear'then return C:FarmContext(mode=='JungleClear'and 'jungle'or 'lane',function()return self.menu.Clear.SpellFarm:Value()and(not condition or condition())end)end
  return C:ModeContext(mode,condition)
 end
 function F:Mode()
  local mode=g.GetMode();if mode=='LaneClear'and not C:FarmModeEnabled('lane')and C:FarmModeEnabled('jungle')then return 'JungleClear'end;return mode
 end
 function F:Safe(pos,offense)
  pos=point(pos);if not pos or type(G.isWall)~='function'or G.isWall(pos)~=false or g.IsUnderTurret2(pos)then return false end
  if offense and(H.health/H.maxHealth*100<self.menu.Misc.HP:Value()or g.GetEnemyCount(650,pos)>self.menu.Misc.Enemies:Value())then return false end
  return true
 end
 function F:AttackReach(u)return SDK.Data:IsInAutoAttackRange(H,u)==true end
 function F:Prediction(u,spec,allies)
  if not self:Current(u,allies)then return end
  local signature=table.concat({spec.cone or 0,spec.circle and 1 or 0,spec.delay or .25,spec.radius or 50,spec.range or 1000,spec.speed or math.huge,spec.collision and 1 or 0},':')
  local settings=self.predictionSettings[signature]
  if not settings then
   if self.predictionCount>=16 then return nil end
   settings={Type=spec.cone and g.OrbamaPrediction.SPELLTYPE_CONE or spec.circle and g.OrbamaPrediction.SPELLTYPE_CIRCLE or g.OrbamaPrediction.SPELLTYPE_LINE,
    Delay=spec.delay or .25,Radius=spec.radius or 50,Range=spec.range or 1000,Speed=spec.speed or math.huge,Collision=spec.collision==true,
    DirectionalCast=not spec.circle and not spec.cone,AimErrorWorld=not spec.circle and not spec.cone and 5 or 0,
   Angle=spec.cone,CollisionTypes={g.OrbamaPrediction.COLLISION_MINION,g.OrbamaPrediction.COLLISION_ENEMYHERO,g.OrbamaPrediction.COLLISION_YASUOWALL}}
   self.predictionSettings[signature]=settings;self.predictionCount=self.predictionCount+1
  end
  local pred=C:Prediction(settings);pred:GetPrediction(u,H)
  if pred:CanHit(2)and point(pred.CastPosition)then return pred end
  return nil,pred.RejectReason
 end
 function F:Native(q,names)
  for _,name in ipairs(names or {})do if C:NativeCast(q,name)then return true end end;return false
 end
 function F:Cast(slot,u,context,options)
  options=options or {};local range=options.range or self:Range(slot)
  if not self:Ready(slot)or u and not self:Reach(u,range,options.ally)or u and not options.ally and not self:Allowed(u)then return false end
  local identity,handle=id(u),u and u.handle
  local payload=u;local pred;if options.selfCast then payload=nil end
  if options.world then
   pred=self:Prediction(u,options.spec or self.profile[slots[slot+1]:lower()],options.ally);if not pred then return false end;payload=pred.CastPosition
  elseif options.position then payload=point(options.position);if not payload then return false end end
   if options.check and not options.check(nil,{position=payload and(payload.pos or payload),
    data=pred and {unitPosition=point(pred.UnitPosition)}})then return false end
  local key=g['HK_'..slots[slot+1]]
  local reserved=self.sequences.mantra
  local reservation=options.reservation or reserved and slot==reserved.slot and reserved.reservation
  local ok=C:Cast(key,payload,{owner=options.owner or context and context.mode or self.profile.champion..slots[slot+1],reservation=reservation,slot=slot,intentTarget=u,context=context,range=(not options.selfCast)and range or nil,ttl=options.ttl or 180,
   priority=options.priority,independent=context and context.combat==true,survivePointerMotion=context and context.combat==true,
   prevalidateWorldCast=options.world==true or options.position~=nil,deferAttackWindup=options.weave~=false,
   resolve=options.resolve,observe=options.observe,
   validate=function(q,resolved)
    return self:Ready(slot)and(not u or id(u)==identity and u.handle==handle and self:Reach(u,range,options.ally))
     and(not u or options.ally or self:Allowed(u))and(not options.permission or options.permission())and(not options.check or options.check(q,resolved))
   end})
  if ok then
   local intent=C.lastIntent
   if options.after then C:AfterCast(key,function(q)options.after(q or intent)end)end
   return true,intent
  end;return false
 end
 function F:ObserveAttack(args)
  local observation=C:AttackWitness(self.attack,args and args.Target)
  if observation and observation~=self.attack then self.attack=observation;if observation.at<=G.Timer()and self.ext.attack then self.ext.attack(self,observation)end end
 end
 function F:Line(a,b,p,width)
  local dx,dz=b.x-a.x,b.z-a.z;local len=dx*dx+dz*dz;if len<1 then return false end
  local t=((p.x-a.x)*dx+(p.z-a.z)*dz)/len
  if t<0 or t>1 then return false end
  return(p.x-a.x-t*dx)^2+(p.z-a.z-t*dz)^2<=width*width,t
 end
 function F:AreaRows(pos,radius,kind)
  local rows={};for _,u in ipairs(self:Rows(kind or 'hero',2000))do if distance(pos,u.pos)<=radius+(u.boundingRadius or 0)then rows[#rows+1]=u end end;return rows
 end
  function F:Impact(slot,u)
   local s=self.profile[slots[slot+1]:lower()]
   if not s or not u or not point(u.pos)or not g.OrbamaPrediction.GetImpactTime then return math.huge end
   return g.OrbamaPrediction:GetImpactTime({Delay=s.delay or .25,Speed=s.speed or math.huge},u.pos,H)
  end
 function F:Rescue(u,slot,options)
  if not self:Current(u)or u.team==300 or u.type==g.Obj_AI_Hero then return false end
  return C:Rescue(u,self:Impact(slot,u),function()
   local damage=self:Damage(slot,u,options);if self.ext.farmDamage then damage=self.ext.farmDamage(self,slot,u,damage,options)end
   return damage
  end)
 end
 -- The shared kill rule (C:Lethal) for this profile's slot: its impact time and
 -- its damage, including the champion's own farm damage hook.
 function F:Lethal(slot,u,opts)
  if not self:Current(u)then return false end
  opts=opts or {};if opts.kind==nil and u.type==g.Obj_AI_Hero then local spec=self.profile[slots[slot+1]:lower()];opts.kind=spec and spec.type end
  return C:Lethal(u,opts.impact or self:Impact(slot,u),function()
   local damage=self:Damage(slot,u,opts.damage);if self.ext.farmDamage then damage=self.ext.farmDamage(self,slot,u,damage,opts.damage)end
   return damage
  end,opts)
 end
 -- The enemies a trap or zone ability should be placed under (C:ZoneTargets),
 -- limited to champions the player allows.
 function F:ZoneTargets(spec)
  local rows=C:ZoneTargets(spec);local out={}
  for _,row in ipairs(rows)do if not row.unit or self:Allowed(row.unit)then out[#out+1]=row end end
  return out
 end
  function F:SequenceValid(s)
   if not s or not finite(s.expires)or s.expires<=G.Timer()or not C.adapter:ContextValid({context=s.context},'continuation')
   or s.target and((not s.allowDead and not self:Current(s.target,s.ally))or id(s.target)~=s.identity or s.target.handle~=s.handle)then return false end
   local state=C:ContinuationState(s.intent,s.expires)
   return state~=nil,state
 end
 function F:MaintainSequences()
  if self.retiredReservation then C.adapter:ReleaseReservation(self.retiredReservation,'sequence_complete');self.retiredReservation=nil end
  -- Extensions own a finite set of stages. Snapshot their keys before a
  -- continuation can replace one stage with another (Lua 5.1 next is invalid
  -- after that table rehash). A newly created phase starts on the next Tick.
  local keys=self.sequenceKeys or {};self.sequenceKeys=keys;local count=0
  for key in pairs(self.sequences)do count=count+1;keys[count]=key end
  for index=count+1,#keys do keys[index]=nil end
  for index=1,count do local key=keys[index];local s=self.sequences[key]
   if s then
    if not self:SequenceValid(s)then
     if s.action then C.adapter:Cancel(s.action,'sequence_invalid')end
     if s.reservation then C.adapter:ReleaseReservation(s.reservation,'sequence_invalid')end
     self.sequences[key]=nil
    elseif self.ext.continue then self.ext.continue(self,key,s)end
   end
  end
 end
 function F:Combat(mode)
  local u=self:Target(1600);if not u then return false end
  return self.ext.combat(self,u,mode,self:Context(mode),false)
 end
 function F:Farm(kind,mode,lastHit)
  if not self:Mana(self.menu[mode])then return false end
  local rows=self:Rows(kind,1300);local target
  for _,u in ipairs(rows)do if not target or lastHit and u.health<target.health or not lastHit and u.maxHealth>target.maxHealth then target=u end end
  if not target then return false end
  -- A LastHit spell is a rescue (F:Rescue) and goes out ahead of background farming.
  return self.ext.farm(self,target,rows,mode,lastHit and C:RescueContext(self:Context(mode))or self:Context(mode),lastHit)
 end
 function F:Flee()
  return self.ext.flee and self.ext.flee(self,self:Context('Flee'))or false
 end
 function F:Assist()
  for _,a in ipairs({{'QAssist',0},{'RAssist',3}})do
   local node=self.menu.Misc[a[1]];if not node:Value()then self.gestures[a[1]]=nil
   elseif not self.gestures[a[1]]then local u=self:Target(math.max(self:Range(a[2]),1200))
    if u and self.ext.assist and self.ext.assist(self,a[2],u,C:HeldContext(function()return node:Value()end))then self.gestures[a[1]]=true;return true end
   end
  end;return false
 end
 function F:Tick()
  if g.ShouldWait()then self:Cleanup('unavailable');return end
  if G.Timer()>=self.nextDiscovery then self:DiscoverTargets()end
  self:MaintainSequences()
  if self.ext.observe then self.ext.observe(self)end
  -- A kit names the enemy its attacks should go to (netted, marked, charged);
  -- the shared preference holds it on a short lease renewed here every tick.
  if self.ext.attackTarget then
   local preferred=self.ext.attackTarget(self,self:Mode())
   if preferred then C:PreferAttack(self.profile.champion,preferred,.25)else C:ReleaseAttackPreference(self.profile.champion)end
  end
  if self.ext.strike then self:MaintainStrike()end
  if self:Assist()then return end
  if not C:SelfChanneling(true)then
   if self.ext.gapclose and self.ext.gapclose(self)then return end
   if self.menu.Misc.KillSecure:Value()and self.ext.secure and self.ext.secure(self)then return end
  end
  if self.ext.background and self.ext.background(self)then return end
  if not C:SelfChanneling(true)then
   local mode=self:Mode()
   if mode=='Combo'or mode=='Harass'then self:Combat(mode)
   elseif mode=='LaneClear'or mode=='JungleClear'then
    if C:FarmModeEnabled('lane')and self.menu.Clear.SpellFarm:Value()then if self:Farm('lane','LaneClear',false)then return end end
    if C:FarmModeEnabled('jungle')and self.menu.Clear.SpellFarm:Value()then self:Farm('jungle','JungleClear',false)end
   elseif mode=='LastHit'then if self.menu.Clear.SpellFarm:Value()then self:Farm('lane','LastHit',true)end elseif mode=='Flee'then self:Flee()end
  end
  if self.previewFallback and self.menu.Draw.Preview:Value()and G.Timer()>=(self.nextPreview or 0)then self.nextPreview=G.Timer()+.125;self:PreparePreview()end
 end
 -- Angled strike (strike.lua, docs/ANGLED-STRIKES.md): while `ext.strike(f,mode)`
 -- names an armed strike (target, spec, opts) the scorer picks the side to strike
 -- from (replanned every .15 s, outside any input callback) and the shared
 -- steering walks there on the movement lease. One trace row per decision change.
 function F:MaintainStrike()
  local S=C.strike;local steering=self.steering
  if not steering then steering=S.Steering(self.profile.champion..'.strike');self.steering=steering end
  local u,spec,opts=self.ext.strike(self,self:Mode())
  if not u then if steering:Release(spec or 'unarmed')then self:TraceStrike(self.strikePlan,steering.last)end;self.strikePlan=nil;self.strikeKey=nil;return end
  local plan=self.strikePlan;local now=G.Timer()
  if not plan or plan.expires<=now or plan.target~=id(u)then
   plan=S.Plan(u,spec,opts);self.strikePlan=plan
  end
  local was=steering.active;local _,state=steering:Update(plan,u)
  local key=tostring(plan.target)..':'..tostring(plan.reason)..':'..tostring(state)
  if key~=self.strikeKey then self.strikeKey=key;self:TraceStrike(plan,state,was)end
 end
 function F:TraceStrike()end
 function F:PreparePreview()
  -- Kept for a second: a late preparation must not blink the drawing; Draw checks
  -- what each element needs (ready ability, living visible unit) on its own.
  local u=self:Target(1300);local preview={expires=G.Timer()+1,profile=self.profile.id}
  if u then preview.target=id(u);preview.unit=u;preview.position=point(u.pos)end
  if self.ext.preview then self.ext.preview(self,preview)end;self.preview=preview
 end
 function F:Draw()
  if H.dead then return end
  local plan=self.strikePlan
  if plan and plan.steer and self.menu.Draw.Strike:Value()and plan.point and plan.landing then
   local gold=g.Draw.Color(255,255,200,60)
   g.Draw.Circle(g.Vector(plan.point.x,H.pos.y,plan.point.z),60,2,gold);g.Draw.Circle(g.Vector(plan.landing.x,H.pos.y,plan.landing.z),40,2,gold)
  end
  -- Ranges of ready abilities only (own spell data, no search). Readiness and
  -- radius are refreshed at 10 Hz; the circles follow the hero every frame.
  if not self.menu.Draw.Ranges:Value()then return end
  local now=G.Timer();local ranges=self.rangeCache
  if not ranges then ranges={at=-1};self.rangeCache=ranges end
  if now>=ranges.at+.1 or now<ranges.at then
   ranges.at=now;local n=0
   for slot=0,3 do local range=self:Range(slot);if range>0 and self:Ready(slot)then n=n+1;ranges[n]=range end end
   for k=#ranges,n+1,-1 do ranges[k]=nil end
  end
  local pos=H.pos;local color=g.Draw.Color(255,120,180,255)
  for i=1,#ranges do g.Draw.Circle(pos,ranges[i],1,color)end
 end
 function F:RegisterGuide(guide)
  return guide:Register('champion',{self.profile.champion..': modes',self.profile.champion..': mechanics'},function(page)
   return {title=self.profile.champion..' '..self.profile.id,cards=page==1 and {
    {'MODES','Hold the provider combat, harass, farming, LastHit or Flee bind. Separate lane and jungle binds are supported.'},
    {'ASSIST','The selected-target binds under Controls cast at the champion you clicked. Releasing the bind cancels input that was not sent yet.'},
    {'SAFETY','Offensive mobility checks terrain and landing threats. Flash and autonomous travel are never inferred from a combat bind.'}}
    or self.ext.guide and self.ext.guide(self)or {{'OBSERVATION','Prepared damage and previews are estimates. Continuations require fresh observed mechanics, not input acceptance.'}}}
  end)
 end
 function F:ShieldDefense(slot,amount,duration,delay,target)
  -- The shared timed-shield service (core.lua). Evade judges the danger; the
  -- offer has no menu switch and needs no held mode key.
  if not C.RegisterShield then return end
  return C:RegisterShield({name=self.profile.champion..slots[slot+1],slot=slot,key=g['HK_'..slots[slot+1]],profile=self.profile.id,
   source='Champion mechanic profile and pinned active calculation assets',
   ready=function()return self:Ready(slot)end,amount=amount,duration=duration,delay=delay,target=target})
 end
 function F:IncomingTargetedCast(u,horizon)
   if not self:Current(u)then return false end
   local cast=C:CastWindup(u,-.05,horizon,nil,H.networkID,H.handle)
   if not cast then return false end
   local travel=0
   if cast.attack then
    local speed=u.attackData and u.attackData.projectileSpeed
    if speed~=math.huge and(not finite(speed)or speed<=0)then return false end
    travel=speed==math.huge and 0 or F.distance(u.pos,H.pos)/speed
   end
   local remaining=cast.castEndTime-G.Timer()+travel
   return remaining>=0 and remaining<=horizon
 end
 -- An enemy dash that ends on the player is answered whether or not a mode key
 -- is held: nobody chooses to be dived. While Combo or Harass is held the cast
 -- belongs to that mode (and ends with it); otherwise it stands on the switch.
 -- `slot` is the ability the hook casts (default E); the hook may fall back.
 function F:Gapclose(cast,slot)
  slot=slot or 2;local mode=self:Mode();local fighting=mode=='Combo'or mode=='Harass'
  local function enabled()return self.menu.Misc.Gapclose:Value()and(not fighting or self:Permission(mode,slot))end
  if not enabled()then return false end
  for _,u in ipairs(self:Rows('hero',800))do
   local function incoming()
    local p=self:Current(u)and self:Allowed(u)and C:ApproachingDash(u,H.pos,300)
    return p and distance(H.pos,p.to)+50<distance(H.pos,p.from)or false
   end
   local allowed=function()return enabled()and incoming()end
   local context=fighting and self:Context(mode,function()return self.menu.Misc.Gapclose:Value()end)
    or {priority='interactive',condition=function()return self.menu.Misc.Gapclose:Value()end}
   if incoming()and cast(self,u,context,allowed,true)then return true end
  end;return false
 end
 function F:KillSecure()
  local function allowed()return self.menu.Misc.KillSecure:Value()and(finite(H.maxMana)and(H.maxMana<=0 or H.mana/H.maxMana*100>=self.menu.Misc.KSMana:Value()))end
  if not allowed()then return false end
  for _,u in ipairs(self:Rows('hero',3500))do if self:Allowed(u)then
   for _,slot in ipairs(self.ext.secureSlots or {})do
    local function lethal()
     if not allowed()or not self:Current(u)or not self:Allowed(u)or not self:Ready(slot)or not self:Reach(u,self:Range(slot))or C:SpellProtected(u)~=false then return false end
     local spec=self.profile[({'q','w','e','r'})[slot+1]]
     local damage=self.ext.secureDamage and self.ext.secureDamage(self,slot,u)or self:Damage(slot,u)
     local estimate=C:HealthEstimate(u,self:Impact(slot,u),spec.type,damage)
     return estimate and estimate.lethal or false
    end
    if lethal()and self.ext.secureCast(self,slot,u,{priority='interactive',condition=allowed},lethal)then return true end
   end
  end end;return false
 end
 return F
end

end
