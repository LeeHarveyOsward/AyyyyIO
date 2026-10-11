return function(require)
local U=require('utils.util')
local L={};L.__index=L
function L.new(c)return setmetatable({c=c,map=c.g.Game.mapID,bases={},index=1,nextScan=0},L)end
function L:ResetMap()
 local map=self.c.g.Game.mapID
 if self.map~=map then self.map=map;self.bases={};self.index=1;self.nextScan=0 end
end
function L:Base(team)self:ResetMap();local b=self.bases[team];return b and b.pos end
function L:NeedsPrepare()
 self:ResetMap();local g=self.c.g
 return not(self.bases[100]and self.bases[200])and g.Obj_AI_SpawnPoint~=nil and g.Game.ObjectCount and g.Game.Object and self.c:now()>=self.nextScan
end
function L:Prepare(token)
 self:ResetMap();if self.bases[100]and self.bases[200]then return true end
 local g=self.c.g;if not g.Game.ObjectCount or not g.Game.Object or g.Obj_AI_SpawnPoint==nil then return true end
 local ok,n=pcall(g.Game.ObjectCount);if not ok or not U.finite(n)or n<0 then self.nextScan=self.c:now()+2;return false end
 n=math.min(65536,math.floor(n));local worked=0
 while self.index<=n and worked<64 do
  if worked>0 and token and not token:Checkpoint(1)then return false end
  local ok,o=pcall(g.Game.Object,self.index);self.index=self.index+1;worked=worked+1
  if ok and o then pcall(function()
   local team,pos=o.team,o.pos
   if o.type==g.Obj_AI_SpawnPoint and o.valid~=false and(team==100 or team==200)and pos and U.finite(pos.x)and U.finite(pos.z)then
    self.bases[team]={pos=U.copy(pos),source='native spawn point',map=self.map}
   end
  end)end
  if self.bases[100]and self.bases[200]then return true end
 end
 if self.index>n then self.index=1;self.nextScan=self.c:now()+2 end
 return false
end
return L

end
