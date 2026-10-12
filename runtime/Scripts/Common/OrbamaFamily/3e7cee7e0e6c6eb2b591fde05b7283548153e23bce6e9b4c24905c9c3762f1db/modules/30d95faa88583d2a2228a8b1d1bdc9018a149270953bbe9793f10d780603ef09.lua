return function(require)
local profiles={
    -- Spirit Rush. rSpeed is the base dash speed; the live dash adds 100% of movement speed, so the Evade offer
    -- declares rSpeedFloor = 1200 + base movement speed 330 and is refused while Ahri is slowed below 330.
    -- rBolt is ONE bolt: a dash fires at up to three different enemies, never twice at the same one.
    Ahri={id='normal',qDamage={35,60,85,110,135},qAP=.5,
        eDamage={80,120,160,200,240},eAP=.85,wDamage={40,60,80,100,120},wAP=.4,
        -- Fox-Fire acquisition radius (asset AhriW DataValues AcquisitionRange 550; BonusAcquisitionRange 725 for an
        -- enemy recently hit by Orb or Charm), read 2026-10-10. Drawn ring only.
        wRange=550,
        rName='AhriR',rBuffs={'AhriTumble','AhriR'},rRange=500,rSpeed=1200,rSpeedFloor=1530,rBaseMS=330,rDelay=0,
        rBolt={75,125,175},rAP=.35,rBoltRange=600,
        -- Charm-Flash (Ahri-2): "Orb and Charm cast from wherever Ahri is at the end of the cast time" (Normal wiki
        -- cast note, https://wiki.leagueoflegends.com/en-us/Ahri, read 2026-10-10). Not established for Classic.
        eFlashOrigin=true,
        rSource='research/family-assets/Ahri/spells.json AhriR DataValues (RDashDistance 500, RBaseDashSpeed 1200, RBaseDamage 75/125/175, RAPCoefficient .35, RAcquisitionRange 600) and AhriW BaseDamage 40..120 APRatio .4; https://wiki.leagueoflegends.com/en-us/Template:Data_Ahri/Spirit_Rush (target range 500, speed 1200 + 100% movement speed, cast time none), read 2026-10-08'},
    -- Q return pass (Ahri-1): the same amount as true damage (both wikis, read 2026-10-10). The return flight
    -- (asset missileSpeed 60 accelerating to 2600, acceleration not in the asset) is unmeasured, so qReturnTime is
    -- absent in both profiles and the return never counts toward a kill until the ahri_q_return trace sets it.
    -- Classic: the dash range is the pinned asset's castRangeDisplayOverride (450). The bolt is the asset's
    -- 70/110/150 (+30% AP); the Classic wiki page says 85/125/165 (+30% AP). Both are recorded and the lower one
    -- decides kills. Bolt reach: patch history V5.3 "acquisition range reduced to 600 from 700"; the lower is used.
    -- The dash speed is not established (asset missileSpeed 2200 is unexplained), so Classic R is not offered to Evade.
    Jade_Ahri={id='classic',qDamage={40,65,90,115,140},qAP=.325,
        eDamage={60,90,120,150,180},eAP=.35,wDamage={40,65,90,115,140},wAP=.4,
        -- Fox-Fire radius: asset Jade_AhriW has no acquisition DataValue; castRangeDisplayOverride 700 (read 2026-10-10).
        wRange=700,
        rName='Jade_AhriR',rBuffs={'Jade_AhriTumble','Jade_AhriR'},rRange=450,
        rBolt={70,110,150},rAP=.3,rBoltRange=600,
        -- Charm amplification: charmed enemies take 20% more damage from Ahri for 6 s
        -- (https://wiki.leagueoflegends.com/en-us/League_Classic/Ahri, read 2026-10-10). Applied while our own Charm is live.
        eAmp=.2,
        rSource='research/family-assets/Jade_Ahri/spells.json Jade_AhriR (castRangeDisplayOverride 450, BaseDamage ranks 1..3 70/110/150, APRatio .3, RecastDuration 10); https://wiki.leagueoflegends.com/en-us/League_Classic/Ahri (Spirit Rush 85/125/165 +30% AP, Fox-Fire 40/65/90/115/140 +40% AP), read 2026-10-08'},
}
return function(identity)
    local profile=profiles[identity]
    if not profile then return nil end
    local result={}
    for key,value in pairs(profile)do
        if type(value)=='table'then local copy={};for k,v in pairs(value)do copy[k]=v end;result[key]=copy
        else result[key]=value end
    end
    return result
end

end
