return function(require)
local G=require('evade.geometry')
local H={};H.__index=H
local function copy(t,depth)
    if type(t)~='table'then return t end
    if (depth or 0)>12 then error('excessive threat depth')end
    local o={};for k,v in pairs(t)do if type(v)~='function'and type(v)~='userdata'then o[k]=copy(v,(depth or 0)+1)end end;return o
end
-- Compare the stored, copied representation. Unchanged host samples must not
-- invalidate prepared actions or rebuild indexes. Bound this optional fast path;
-- an oversized/unequal record falls back to the ordinary fresh copy and revision.
local function same(a,b,depth,left)
 if depth>12 then return false,left end
 for k,v in pairs(a)do
  left=left-1;if left<0 then return false,left end
  local kind=type(v)
  if not(depth==0 and k=='revision')and kind~='function'and kind~='userdata'then
   local other=b[k]
   if kind=='table'then
    if type(other)~='table'then return false,left end
    local equal;equal,left=same(v,other,depth+1,left);if not equal then return false,left end
   elseif v~=other then return false,left end
  end
 end
 for k,v in pairs(b)do
  left=left-1;if left<0 then return false,left end
  local kind=type(v)
  if not(depth==0 and k=='revision')and kind~='function'and kind~='userdata'then
   local other=type(a[k])
   if other=='nil'or other=='function'or other=='userdata'then return false,left end
  end
 end
 return true,left
end
local function addCandidate(store,index,serial,candidates,seen)
    if seen[index]~=serial then
        seen[index]=serial;candidates[#candidates+1]=store.list[index]
    end
end
function H.new()return setmetatable({byID={},positions={},list={},revision=0,serial=0,overflow=false,max=512,suppressed={},
    queryCandidates={},querySeen={},querySerial=0,boundX0={},boundX1={},boundZ0={},boundZ1={},indexX0={},indexX1={},indexZ0={},indexZ1={},indexGlobal={}},H)end
function H:Observe(event)
    if type(event)~='table'or not event.id or not event.casterID or not event.profile then return nil,'identity_required'end
    local valid,why=G.valid(event);if not valid then return nil,why end
    if event.evidence~='observed' and event.evidence~='cast-derived' then return nil,'observation_required'end
    local old=self.byID[event.id]
 if old then
  local a,b=event.origin or event.a,old.origin or old.a
  -- Moving observations normally change these cheap terms. Avoid recursively
  -- comparing unchanged metadata before the first changed motion field.
  if event.starts==old.starts and event.ends==old.ends and event.shape==old.shape
   and(not a and not b or a and b and a.x==b.x and a.y==b.y and a.z==b.z)
   and same(event,old,0,256)then return old.id end
 end
    if not old and #self.list>=self.max then self.overflow=true;self.overflowUntil=math.max(self.overflowUntil or 0,event.ends);return nil,'threat_capacity'end
    local row=copy(event);self.serial=self.serial+1;row.revision=self.serial
    if old then
        self.list[self.positions[row.id]]=row
    else self.list[#self.list+1]=row;self.positions[row.id]=#self.list end
    self.byID[row.id]=row;self.revision=self.revision+1;return row.id
end
-- A suppressed threat stays observed (and drawn) but no query returns it: the
-- planner does not move for it (evade.policy). Returns true when the state changed.
function H:Suppress(id,reason)
    reason=reason or nil
    if self.suppressed[id]==reason or not self.byID[id]then return false end
    self.suppressed[id]=reason;self.revision=self.revision+1;return true
end
function H:Remove(id)
    local row=self.byID[id];if not row then return false end
    self.byID[id]=nil;self.suppressed[id]=nil
    local index=self.positions[id];local last=self.list[#self.list]
    self.list[index]=last;self.positions[last.id]=index;self.list[#self.list]=nil;self.positions[id]=nil
    self.revision=self.revision+1;return true
end
function H:Expire(now)
    for i=#self.list,1,-1 do local v=self.list[i];if v.ends<now then self:Remove(v.id)end end
    if self.overflowUntil and now>self.overflowUntil and #self.list<self.max then self.overflow=false;self.overflowUntil=nil end
end
function H:Snapshot(id)
    if id then
        local row=self.byID[id]
        if not row then for _,candidate in ipairs(self.list)do if candidate.stageID==id then row=candidate;break end end end
        return row and copy(row)
    end
    local out={};for _,r in ipairs(self.list)do out[#out+1]=copy(r)end;return out
end
-- Use the geometry's explicit length, not merely its orientation endpoint.
-- Numeric bounds are shared by indexing and final candidate rejection.
local function bounds(s,padding)
    local p=s.origin or s.a;local q=s.b or p
    local qx,qz=q.x,q.z
    if s.shape=='rectangle'and s.length~=nil then
        local dx,dz=G.direction(p,q);qx=p.x+dx*s.length;qz=p.z+dz*s.length
    end
    local r=(s.shape=='cone'and(s.length or G.dist(p,q))or s.shape=='arc'and s.arcRadius or 0)
        +(s.radius or 0)+(padding or 0)
    return math.min(p.x,qx)-r,math.max(p.x,qx)+r,math.min(p.z,qz)-r,math.max(p.z,qz)+r
end
function H:Query(a,b,t0,t1,radius,out,everything)
    out=out or {};for i=#out,1,-1 do out[i]=nil end
    if self.indexRevision~=self.revision then
        local dirty=not self.buckets or self.indexCount~=#self.list
        for index,s in ipairs(self.list)do
            local unbounded=s.shape=='targeted'or s.shape=='compound'or s.motion~=nil
            local x0,x1,z0,z1
            if not unbounded then
                local left,right,bottom,top=bounds(s)
                self.boundX0[index],self.boundX1[index]=left,right
                self.boundZ0[index],self.boundZ1[index]=bottom,top
                -- A fixed flight's prepared contour is a conservative index
                -- envelope. Actual current bounds above still reject queries
                -- behind the projectile; timing and rows are never cached.
                if s.shape=='missile'and G.point(s.contourOrigin)then
                    local p=s.contourOrigin;local a=s.origin or s.a;local b=s.b
                    local dx,dz=b.x-a.x,b.z-a.z;local px,pz=p.x-a.x,p.z-a.z
                    local cross=px*dz-pz*dx
                    -- A redirected/off-ray contour cannot provide the stable
                    -- envelope optimization. Use actual bounds in that case.
                    if px*dx+pz*dz<=0 and cross*cross<=(dx*dx+dz*dz)*1e-6 then
                        local r=s.radius or 0
                        left,right=math.min(left,p.x-r),math.max(right,p.x+r)
                        bottom,top=math.min(bottom,p.z-r),math.max(top,p.z+r)
                    end
                end
                x0,x1=math.floor(left/512),math.floor(right/512)
                z0,z1=math.floor(bottom/512),math.floor(top/512)
                if (x1-x0+1)*(z1-z0+1)>128 then unbounded=true end
            end
            if self.indexGlobal[index]~=unbounded or not unbounded and
                (self.indexX0[index]~=x0 or self.indexX1[index]~=x1
                 or self.indexZ0[index]~=z0 or self.indexZ1[index]~=z1)then dirty=true end
            self.indexGlobal[index]=unbounded
            self.indexX0[index],self.indexX1[index]=x0,x1
            self.indexZ0[index],self.indexZ1[index]=z0,z1
        end
        if dirty then
            self.buckets={};self.global={};self.indexBuilds=(self.indexBuilds or 0)+1
            for index=1,#self.list do
                if self.indexGlobal[index]then self.global[#self.global+1]=index
                else
                    for x=self.indexX0[index],self.indexX1[index]do
                        for z=self.indexZ0[index],self.indexZ1[index]do
                            local column=self.buckets[x]
                            if not column then column={};self.buckets[x]=column end
                            local bucket=column[z]
                            if not bucket then bucket={};column[z]=bucket end
                            bucket[#bucket+1]=index
                        end
                    end
                end
            end
        end
        self.indexCount=#self.list;self.indexRevision=self.revision
    end
    local candidates,seen=self.queryCandidates,self.querySeen
    for i=#candidates,1,-1 do candidates[i]=nil end
    self.querySerial=self.querySerial+1;local serial=self.querySerial
    for _,s in ipairs(self.global)do addCandidate(self,s,serial,candidates,seen)end
    local left,right=math.min(a.x,b.x),math.max(a.x,b.x)
    local bottom,top=math.min(a.z,b.z),math.max(a.z,b.z)
    local x0,x1=math.floor((left-radius)/512),math.floor((right+radius)/512)
    local z0,z1=math.floor((bottom-radius)/512),math.floor((top+radius)/512)
    if (x1-x0+1)*(z1-z0+1)>256 then for index=1,#self.list do addCandidate(self,index,serial,candidates,seen)end
    else
        for x=x0,x1 do
            local column=self.buckets[x]
            if column then
                for z=z0,z1 do
                    local bucket=column[z]
                    if bucket then for _,index in ipairs(bucket)do addCandidate(self,index,serial,candidates,seen)end end
                end
            end
        end
    end
    -- `everything`: public queries report what is there, not what the player chose to ignore.
    local suppressed=everything and {}or self.suppressed
    for _,s in ipairs(candidates)do
        if not suppressed[s.id]and(s.motionUnknown or s.shape=='compound'and G.uncertainMotion(s)or s.ends>=t0)and s.starts<=t1 then
            local include=s.shape=='targeted'or s.shape=='compound'or s.motion~=nil
            if not include then
                local index=self.positions[s.id]
                include=left<=self.boundX1[index]+radius and right>=self.boundX0[index]-radius
                    and bottom<=self.boundZ1[index]+radius and top>=self.boundZ0[index]-radius
            end
            if include then out[#out+1]=s end
        end
    end
    return out
end
return H

end
