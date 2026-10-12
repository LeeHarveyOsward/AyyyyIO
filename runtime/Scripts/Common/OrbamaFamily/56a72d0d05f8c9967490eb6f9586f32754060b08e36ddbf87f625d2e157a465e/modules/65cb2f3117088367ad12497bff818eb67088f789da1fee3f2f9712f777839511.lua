return function(require)
local U={}
function U.finite(n)return type(n)=='number'and n==n and math.abs(n)<math.huge end
function U.count(n,limit)return U.finite(n)and n>=0 and n<=limit and math.floor(n)or 0 end
function U.clamp(n,a,b)return math.max(a,math.min(b,n))end
function U.copy(p)return p and {x=p.x,y=p.y or 0,z=p.z}end
function U.vector(p)return Vector(p.x,p.y or 0,p.z)end
function U.screenDist(a,b)if not a or not b then return math.huge end;local x,y=a.x-b.x,a.y-b.y;return math.sqrt(x*x+y*y)end
function U.dist(a,b)
    if not a or not b or not U.finite(a.x)or not U.finite(a.z)or not U.finite(b.x)or not U.finite(b.z)then return math.huge end
    local x,z=a.x-b.x,a.z-b.z;return math.sqrt(x*x+z*z)
end
function U.id(o)return o and(o.networkID or o.handle)end
function U.same(a,b)return a and b and(a==b or U.id(a)and U.id(a)==U.id(b))end
function U.valid(o)return o and o.valid~=false and o.visible~=false and not o.dead and o.isTargetable~=false
    and o.pos and U.finite(o.health)and o.health>0 end
-- A pure function of the string: memoised (bounded, a full memo starts over), so
-- buff and summoner scans do not lower-case and gsub the same names every tick.
local nameMemo,nameMemoSize={},0
function U.name(s)
    s=s or '';local value=nameMemo[s]
    if value then return value end
    value=s:lower():gsub('^jade_',''):gsub('_jade$',''):gsub('[^%w]','')
    if nameMemoSize>=1024 then nameMemo={};nameMemoSize=0 end
    nameMemo[s]=value;nameMemoSize=nameMemoSize+1
    return value
end
function U.buffEnd(b)
    if U.finite(b.expireTime)and b.expireTime>0 then return b.expireTime end
    if U.finite(b.endTime)and b.endTime>0 then return b.endTime end
end
function U.buff(o,names,now)
    if not o or not o.GetBuff then return end
    for i=0,U.count(o.buffCount or 0,256)do
        local b=o:GetBuff(i)
        if b and b.name and names[U.name(b.name)]and(b.count or b.stacks or 0)>0 then
            local finish=U.buffEnd(b);if not finish or finish>now then return b end
        end
    end
end
function U.hp(o)return(o.health or 0)/math.max(1,o.maxHealth or 1)*100 end
function U.stackCount(o)return math.max(o and o.stacks or 0,o and o.stackCount or 0)end
return U

end
