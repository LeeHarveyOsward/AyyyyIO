return function(require)
-- Attribution only. Never merge projectile damage IDs or remove future waves.
local G=require('evade.geometry')
local L={}
function L.Match(active,byID,s)
    if s.shape~='missile'or s.motionUnknown or (s.acceleration or 0)~=0
    or type(s.stageID)~='string'or #s.stageID==0
    or type(s.nativeAlias)~='string'or not G.point(s.nativeEmitterOrigin)
    or not G.point(s.origin)or not G.point(s.b)or not G.finite(s.speed)or s.speed<=0 then
        return nil,'native_channel_evidence_incomplete'
    end
    local at=s.positionObservedAt or s.starts
    if not G.finite(at)then return nil,'native_channel_clock_missing'end
    local alias=s.nativeAlias:lower();local found
    for _,row in pairs(active)do
        local t=byID[row.id]
        if row.nativeAliases and row.nativeAliases[alias]and t and t.profile==s.profile
        and t.champion==s.champion and (s.casterID==row.owner or s.casterID==row.ownerHandle)
        and math.abs(s.speed-t.emissionSpeed)<=1e-6 then
            local origin=s.nativeEmitterOrigin;local distance=G.dist(origin,s.b)
            if distance>1 and distance<=t.length+row.nativeOriginRadius+1e-6
            and G.dist(origin,t.origin)<=row.nativeOriginRadius+1e-6 then
                local dx,dz=G.direction(origin,s.b);local cx,cz=G.direction(t.origin,t.b)
                local px,pz=s.origin.x-origin.x,s.origin.z-origin.z
                local progress=px*dx+pz*dz;local offset=math.abs(px*dz-pz*dx)
                local launch=at-progress/s.speed
                if dx*cx+dz*cz>=math.cos(t.halfAngle)-1e-9
                and offset<=row.nativeRayTolerance+1e-6 and progress>=-row.nativeRayTolerance
                and progress<=distance+row.nativeRayTolerance
                and launch>=t.emissionStart-row.nativeTimeTolerance
                and launch<=t.emissionEnd+row.nativeTimeTolerance then
                    if found and found~=row.id then return nil,'native_channel_ambiguous'end
                    found=row.id
                end
            end
        end
    end
    return found,found and 'native_channel_matched'or 'native_channel_not_matched'
end
-- Called only with Match's result. Does not rerun geometric attribution.
function L.SetParent(s,parent)
    if parent==s.channelInstanceID then return false end
    if parent then
        -- stageID remains the native projectile instance and damageID remains
        -- its independently established event. A channel is not one hit.
        s.channelInstanceID=parent;s.instanceID=parent
    elseif s.channelInstanceID then
        s.channelInstanceID=nil;s.instanceID=s.stageID
    else return false end
    return true
end
function L.Attach(active,byID,s)
    local parent,reason=L.Match(active,byID,s)
    return L.SetParent(s,parent),reason
end
-- Geometric containment only. Damage/stage identities remain independent.
-- Association alone is insufficient: a wider native projectile, redirect or
-- changed channel window must restore its individual geometry immediately.
function L.Covered(byID,s)
 local parent=s.channelInstanceID and byID[s.channelInstanceID]
 if not parent or parent.shape~='cone'or not parent.emissionSpeed or s.shape~='missile'
 or s.motion or s.motionUnknown or s.speedUncertain or s.speedStep or(s.acceleration or 0)~=0
 or parent.profile~=s.profile or parent.champion~=s.champion
 or parent.casterID~=s.casterID or not G.finite(s.radius)or s.radius>(parent.radius or 0)
 or not G.finite(s.speed)or math.abs(s.speed-parent.emissionSpeed)>1e-6
 or not G.point(s.nativeEmitterOrigin)or not G.point(s.origin)or not G.point(s.b)
 or not G.point(parent.origin)or not G.point(parent.b)
 or G.dist(s.nativeEmitterOrigin,parent.origin)>1e-6 then return nil end
 local dx,dz=G.direction(s.nativeEmitterOrigin,s.b);local cx,cz=G.direction(parent.origin,parent.b)
 local x,z=s.origin.x-parent.origin.x,s.origin.z-parent.origin.z
 local progress=x*dx+z*dz;local at=s.positionObservedAt or s.starts
 if not G.finite(at)or progress<0 or math.abs(x*dz-z*dx)>1e-6
 or G.dist(s.nativeEmitterOrigin,s.b)>parent.length+1e-6
 or dx*cx+dz*cz<math.cos(parent.halfAngle)-1e-9 then return nil end
 local launch=at-progress/s.speed
 if launch<parent.emissionStart-1e-6 or launch>parent.emissionEnd+1e-6 then return nil end
 return parent
end
return L

end
