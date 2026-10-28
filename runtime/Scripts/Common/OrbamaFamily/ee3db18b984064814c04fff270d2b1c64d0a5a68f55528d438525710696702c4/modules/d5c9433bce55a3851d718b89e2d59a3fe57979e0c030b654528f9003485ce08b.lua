return function(require)
local T=require('ChampionMobility.terrain')(require('leesin.util'),require('leesin.navigation'))
local new=T.new
T.new=function(ctx)return new(ctx,_G.LeeSin_Terrain)end
return T

end
