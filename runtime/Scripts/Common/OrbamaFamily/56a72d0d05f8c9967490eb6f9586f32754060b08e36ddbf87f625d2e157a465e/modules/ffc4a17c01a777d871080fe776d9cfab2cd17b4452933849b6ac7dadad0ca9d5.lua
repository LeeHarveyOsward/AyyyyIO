return function(require)
local G=require('evade.geometry')
local P={}
local function buffReader(owner)return owner.GetBuff,owner.buffCount end
local function currentPassive(reader,owner,index,name,began,now,requiredUntil)
 local buff=reader(owner,index)
 if not buff or buff.valid==false or type(buff.name)~='string'or buff.name:lower()~=name then return false end
 local expires=buff.expireTime
 if not G.finite(expires)or expires<=0 then expires=buff.endTime end
 return G.finite(buff.count)and buff.count>0 and G.finite(buff.startTime)and buff.startTime>=0
  and buff.startTime<=began and G.finite(expires)and expires>now and expires>began
  and(requiredUntil==nil or expires>requiredUntil)
end
-- Read only for a new profiled cast that needs death-state authorization. The
-- containing observed cast epoch handles deduplication, without a global cache.
function P.Authorize(owner,spell,definition,now,requiredUntil)
 local cast=definition and definition.cast
 if not owner.dead and not(cast and cast.requiresPassive)then return true end
 local policy=cast and cast.postDeath
 if type(policy)~='table'or policy.version~=1 or policy.identity~=owner.charName
  or policy.profile~=definition.profile or policy.source~=definition.source
  or type(policy.buff)~='string'or policy.buff==''then return false,'postdeath_not_profiled'end
 local began=spell.startTime
 if began==nil or began==0 then began=spell.castStartTime end
 local maxAge=2
 if requiredUntil~=nil then
  if not cast.channel or cast.channel.kind~='timed_targeted_effect'
   or not G.finite(now)or not G.finite(began)or not G.finite(requiredUntil)
   or requiredUntil<now or requiredUntil<began or requiredUntil-began>20 then
   return false,'postdeath_channel_deadline_unknown'
  end
  maxAge=requiredUntil-began
 end
 if not G.finite(now)or not G.finite(began)or began<=0 or began>now+.1 or now-began>maxAge then
  return false,'invalid_cast_start'
 end
 -- A native method lookup or a returned buff property can throw separately
 -- from GetBuff itself. Scope those failures to this cast's passive evidence.
 local available,reader,count=pcall(buffReader,owner)
 if not available or type(reader)~='function'or not G.finite(count)or count<0 or count%1~=0 then
  return false,'postdeath_buffs_unavailable'
 end
 if count>63 then return false,'postdeath_buff_budget'end
 for index=0,count do
  local ok,confirmed=pcall(currentPassive,reader,owner,index,policy.buff,began,now,requiredUntil)
  if not ok then return false,'postdeath_buff_read_failed',index+1 end
  if confirmed then return true,nil,index+1 end
 end
 return false,'postdeath_passive_unconfirmed',count+1
end
return P

end
