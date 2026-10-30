return function(require)
-- Separate own-profile W values. Total DoT is not immediate attack damage.
local M={}
M.profiles={
 Nautilus={id='normal',shield='NautilusPiercingGazeShield',shieldBase={50,60,70,80,90},shieldHP={.08,.09,.10,.11,.12},
  shieldDuration=6,dotBase={30,40,50,60,70},dotAP=.4,dotDuration=nil,
  shieldSource='Normal W 50-90 +8-12% maximum health, 6 s: installed Nautilus asset and https://wiki.leagueoflegends.com/en-us/Nautilus (2026-10-08)'},
 Jade_Nautilus={id='classic',shield='Jade_NautilusW_Shield',shieldBase={100,150,200,250,300},shieldHP={.15,.15,.15,.15,.15},
   shieldStat='bonusHealth',shieldDuration=10,dotBase={40,65,90,115,140},dotAP=.4,dotDuration=2,
   -- The older research/family-assets extraction reads 10% and DoT 25..100; the installed 16.20 asset
   -- (sha e34aac3d, ShieldHealthRatio .15, stat 12 formula 2 = bonus health) and the Classic wiki agree on 15%.
   shieldSource='Classic W 100-300 +15% bonus health, 10 s: research/26.20-five-champions/Jade_Nautilus/spells.json (asset sha e34aac3d) and https://wiki.leagueoflegends.com/en-us/League_Classic/Nautilus (2026-10-08)'},
}
local function finite(v)return type(v)=='number'and v==v and v>-math.huge and v<math.huge end
function M.Active(identity,buff,at)
 local p=M.profiles[identity]
 if not p or not buff or type(buff.name)~='string'or buff.name:lower()~=p.shield:lower()
  or not finite(buff.count)or buff.count<=0 or not finite(at)then return false end
 local expires=finite(buff.expireTime)and buff.expireTime>0 and buff.expireTime or buff.endTime
 return finite(expires)and expires>at
end
function M.Dot(identity,rank,ap)
 local p=M.profiles[identity]
 if not p or not finite(rank)or rank%1~=0 or not p.dotBase[rank]or not finite(ap)then return nil,'dot_profile_or_rank_unknown'end
 return {kind='dot',damageType='magical',rawTotal=p.dotBase[rank]+p.dotAP*ap,duration=p.dotDuration,
  tickInterval=nil,firstTick=nil,refresh='replace_remaining',immediateCredit=0,
  timingVerified=false,observed=false,source='research/attack-effects-16.20'}
end
return M

end
