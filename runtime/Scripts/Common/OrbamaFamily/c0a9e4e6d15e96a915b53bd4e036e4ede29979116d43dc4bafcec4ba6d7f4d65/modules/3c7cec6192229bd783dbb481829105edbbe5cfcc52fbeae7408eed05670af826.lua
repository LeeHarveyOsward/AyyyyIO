return function(require)
-- Planning only. Game seconds and world units; no callbacks, timers or input.
local M={version=1,healthMaxAge=60}
local function finite(v)return type(v)=='number'and v==v and v>-math.huge and v<math.huge end
local function distance(a,b)local x,z=a.x-b.x,a.z-b.z;return math.sqrt(x*x+z*z)end
-- Primary Normal reference: Riot patch25.07 fountain8% maximum +16% missing HP/s.
-- Continuous best-supported estimate; the native tick phase remains unknown.
-- Classic needs its own matched fountain rule.
function M.FountainHealth(profile,map,health,elapsed,fountainElapsed)
 if profile~='normal'or map~=11 then return nil,'fountain_profile_unverified'end
 if not finite(health.health)or not finite(health.maxHealth)or health.health<=0 or health.maxHealth<=0
  or not finite(health.hpRegen)or not finite(elapsed)or elapsed<0 then return nil,'recall_health_unknown'end
 local current=math.min(health.maxHealth,health.health+math.max(0,health.hpRegen)*elapsed)
 if not finite(fountainElapsed)or fountainElapsed<0 then fountainElapsed=1 end
 -- Best-supported continuous estimate. Native fountain tick phase is unknown.
 local healed=1.5*health.maxHealth+(current-1.5*health.maxHealth)*math.exp(-.16*fountainElapsed)
 return math.min(health.maxHealth,healed), 'continuous_fountain_estimate_tick_phase_unknown'
end
function M.Prepare(g,prediction,scope,unit,spell,spec,anchor)
 if not scope or not scope:Alive()or not unit or unit.dead or unit.valid==false then return nil,'recall_target_invalid'end
 local recall,why=scope:Recall(unit);if not recall then return nil,why end
 if anchor and(recall.id~=anchor.id or recall.handle~=anchor.handle or recall.name~=anchor.name
  or recall.started~=anchor.started or recall.ends~=anchor.ends)then return nil,'recall_changed'end
 local base; base,why=scope:Base(recall.team);if not base then return nil,why end
 if not finite(spell.Range)or distance(g.myHero.pos,base.pos)>spell.Range then return nil,'base_out_of_range'end
 local now=g.Game.Timer();local flight=prediction:GetImpactTime(spell,base.pos,g.myHero.pos)
 if not finite(flight)or flight<=0 then return nil,'recall_flight_unknown'end
 -- Centre arrival stays after completion. First projectile contact may precede
 -- centre crossing, so compensate the entire footprint at the landing speed.
 local body=unit.boundingRadius
 if not finite(body)or body<0 or body>300 then return nil,'recall_target_radius_unknown'end
 local velocity=spell.Motion and spell.Motion.maxSpeed or spell.Speed
 if not(spec.selfCast and velocity==math.huge)and(not finite(velocity)or velocity<=0)then return nil,'recall_projectile_speed_unknown'end
 local footprint=(spell.Radius or 0)+body+(spell.AimErrorWorld or 0)
 local contactMargin=spec.selfCast and 0 or footprint/velocity
 if spell.Motion and not spec.selfCast then
  -- Contact can straddle a speed transition. Integrate the leading edge with
  -- the same flight clock as the centre, rather than using maximum speed.
  local origin=g.myHero.pos;local span=distance(origin,base.pos)
  local fraction=span>0 and math.max(0,span-footprint)/span or 0
  local edge={x=origin.x+(base.pos.x-origin.x)*fraction,y=origin.y or 0,z=origin.z+(base.pos.z-origin.z)*fraction}
  local edgeFlight=prediction:GetImpactTime(spell,edge,origin)
  if not finite(edgeFlight)or edgeFlight<0 or edgeFlight>flight then return nil,'recall_contact_time_unknown'end
  contactMargin=flight-edgeFlight
 end
 local arrival=now+flight
 local earliest=recall.ends+.06+contactMargin
 local latest=earliest+.10
 if arrival<earliest then return nil,'recall_cast_not_due'end
 if arrival>latest then return nil,'recall_cast_window_missed'end
 -- A recall often starts in fog. The last full observation is aged forward with
 -- regeneration and fountain healing; beyond this bound it is not trusted.
 local health;health,why=scope:Health(unit,M.healthMaxAge);if not health then return nil,why end
 if health.at>now then return nil,'recall_health_future'end
 local effective;effective,why=M.FountainHealth(recall.profile,recall.map,health,arrival-health.at,math.max(0,arrival-recall.ends))
 if not effective then return nil,why end
 local shield=health.shieldAD or health.shieldAll
 if spec.damageType~='physical'then shield=finite(shield)and finite(health.shieldAP)and shield+health.shieldAP or nil end
 if not finite(shield)or shield<0 then return nil,'recall_shield_unknown'end
 if unit.isImmortal==true or unit.isInvulnerable==true or spec.protected and spec.protected(unit,arrival)then return nil,'recall_target_protected'end
 if spec.flightBounds then
  local lower,upper=spec.flightBounds(distance(g.myHero.pos,base.pos))
  if not finite(lower)or not finite(upper)or now+lower<earliest or now+upper>latest then return nil,'recall_flight_uncertain'end
 end
 local damage=spec.damage(unit,health,effective,distance(g.myHero.pos,base.pos))*(spec.damageFloor or 1)
 if not finite(damage)or damage<=effective+shield then return nil,'recall_not_lethal'end
 if spell.Collision then
  local blocked,_,count=prediction:GetCollision(g.myHero.pos,base.pos,spell.Speed,
   prediction:GetLaunchDelay(spell),spell.Radius+(spell.AimErrorWorld or 0),spell.CollisionTypes,recall.id,
   spell.Motion and{motion=spell.Motion}or nil)
  if blocked or count>(spell.MaxCollision or 0)then return nil,'recall_ray_blocked'end
 end
 return {position=base.pos,data={id=recall.id,handle=recall.handle,name=recall.name,started=recall.started,
  ends=recall.ends,team=recall.team,map=recall.map,profile=recall.profile,arrival=arrival,
  health=effective,damage=damage,healthModel=why,flight=flight,latestArrival=latest,guaranteed=false}}
end
return M

end
