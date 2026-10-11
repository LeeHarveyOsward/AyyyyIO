return function(require)
return function()
-- Shared Karma Normal/Classic mechanics; source pins remain in research/26.20-five-champions.
local profiles={}
profiles['Karma']=profiles['Karma']or {}
profiles['Karma'].combat={id='normal',champion='Karma',names={{'KarmaQ'},{'KarmaSpiritBind'},{'KarmaSolKimShield'},{'KarmaMantra'}},
  -- Q missile half-width 60, Mantra missile 80 (26.20 KarmaQMissile / KarmaQMissileMantra lineWidth; dossier
  -- 2026-10-10); Soulflare explodes at the end of its 950 range in a 280 radius (wiki Karma, V26.10, read 2026-10-10).
  q={range=950,radius=60,delay=.25,speed=1700,collision=true,type='magical',base={60,110,160,210,260},ap=.7,splash=280,
   mantra={range=950,radius=80,endBlast=280}},
  w={range=675,delay=.25,type='magical',base={40,65,90,115,140},ap=.45,leash=825,duration=2},
  e={range=800,type='shield',base={80,130,180,230,280},ap=.6,duration=2.5},r={range=0},
  mantraNames={'KarmaMantra'},tetherNames={'KarmaSpiritBind'},rqBase={40,100,160,220},rqAP=.3,rqDelayed={40,130,220,310},rqDelayedAP=.5,rwMissingHeal=.17,rwHealAP=.0001,reBase={45,85,125,165},reAP=.45}
profiles['Jade_Karma']=profiles['Jade_Karma']or {}
profiles['Jade_Karma'].combat={id='classic',champion='Karma',names={{'Jade_KarmaQ','Jade_KarmaQ_C'},{'Jade_KarmaW'},{'Jade_KarmaE','Jade_KarmaE_C'},{'Jade_KarmaR'}},
  q={range=650,radius=100,cone=33,delay=.25,speed=math.huge,type='magical',base={70,110,150,190,230,270},ap=.6},
  w={range=800,delay=.25,type='magical',base={80,125,170,215,260,305},ap=.7,duration=5,lineDuration=3},
  e={range=625,type='shield',base={80,120,160,200,240,280},ap=.8,duration=5,area=500},r={range=0},
  mantraNames={'Jade_KarmaR'},mantraChargeNames={'Jade_KarmaR_Charge'},rqHeal={35,55,75,95,115,135},rqMissing=.05,rqHealAP=.0002,rCharges=2,rRecharge={30,25,20},wSpeed={.1,.12,.14,.16,.18,.2},wMantra=2}
local normal,classic=profiles.Karma.combat,profiles.Jade_Karma.combat
normal.r.maxRank=4
for _,slot in ipairs({'q','w','e'})do classic[slot].maxRank=6 end
normal.usesMantraDamage=true
function normal.rawModifier(p,raw,s,slot,rank,stats,target,options,finite)
 if slot==0 and options.mantra then
  local r=options.ultimateRank
  if not finite(r)or r%1~=0 or not p.rqBase[r]then return 0,'mantra_rank_unknown'end
  raw=raw+p.rqBase[r]+p.rqAP*stats.ap
 end
 return raw,s.type
end
local function heal(p,rank,stats,active,mantra,finite)
 if not mantra or not finite(stats.ap)then return 0 end
 local missing=math.max(0,stats.maxHealth-stats.health)
 if p.id=='normal'then return missing*(p.rwMissingHeal+p.rwHealAP*stats.ap)end
 return(p.rqHeal[rank]or 0)+missing*(p.rqMissing+p.rqHealAP*stats.ap)
end
normal.heal=heal;classic.heal=heal
return profiles

end
end
