return function(require)
local P={}
local profiles={
 KogMaw={buff='kogmawbioarcanebarrage',base={3,3.75,4.5,5.25,6},ap=.015,monsterCap=100},
 Jade_KogMaw={buff='jade_kogmaww',base={2,3,4,5,6},ap=.01,monsterCap=100},
}
local function finite(value)
 return type(value)=='number'and value==value and value>-math.huge and value<math.huge
end
function P.BuffName(identity)
 local p=profiles[identity];return p and p.buff
end
function P.Active(identity,buff,now)
 local name=P.BuffName(identity)
 if not name or not buff or type(buff.name)~='string'or buff.name:lower()~=name
  or not finite(buff.count)or buff.count<=0 or not finite(now)then return false end
 local expiry=finite(buff.expireTime)and buff.expireTime>0 and buff.expireTime or buff.endTime
 return finite(expiry)and expiry>now
end
function P.RawW(identity,rank,ap,maxHealth,monster)
 local p=profiles[identity]
 if not p then return 0,'unsupported_profile'end
 if not finite(rank)or not p.base[rank]then return 0,'unlearned_or_invalid_rank'end
 if not finite(ap)or not finite(maxHealth)or maxHealth<=0 then return 0,'invalid_stats'end
 local damage=math.max(0,p.base[rank]+p.ap*ap)*maxHealth/100
 return monster and math.min(p.monsterCap,damage)or damage,'asset_derived'
end
return P

end
