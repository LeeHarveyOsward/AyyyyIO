return function(require)
-- 2026-10-08: W and R damage rows confirmed on the matching page of each profile; the R stun (1 s at the caster up
-- to 3.5 s by distance flown) and the 400 area around the first champion hit were read from the same pages
-- (`rSource`). The controller only ever counts on the 1 s minimum. Volley speed lives in abilities.lua.
-- 2026-10-10 (champion ranking Ashe-1/3/5/9): Normal Volley fan 7/8/9/10/11 arrows over 27.75/37/37/46.25/46.25
-- degrees, each arrow 20 wide, stopped by the first unit (wiki Ashe read 2026-10-10). Classic arrow count and cone
-- are not stated (wiki League_Classic/Ashe read 2026-10-10; the asset castConeAngle 20 is the indicator only):
-- no fan for Classic until 'ashe_volley_missile' development traces measure them. E: speed 1400, reveal
-- radius 1000 (both wikis read 2026-10-10). peelHealth/fleeRange are controller policy, not mechanics.
-- 2026-10-10 (final data accuracy, Ashe-7): Volley speed bounds {1500,2000}. Re-examined installed assets: VolleyAttack /
-- VolleyAttackWithSound / VolleyCenterAttack / VolleyRightAttack (Ashe.wad ashe.bin sha256 fbf0223c...) and the
-- Jade_AsheVolleyAttack pair carry missileSpeed 1500 and the same 1500 in the FixedSpeed movement component; no second
-- field (initial/max speed, acceleration) exists, so no field explains the wiki's 2000 (Template:Data_Ashe/Volley,
-- League_Classic/Ashe). Unresolved: the controller predicts under both and calibrates from its own arrows in play.
local profiles={
    Ashe={id='normal',qToggle=false,qReady='asheqcastready',qActive='asheqbuff',qStacks=4,
        wRange=1200,wDamage={60,95,130,165,200},wAD='bonusDamage',eRange={25000,25000,25000,25000,25000},rDamage={200,400,600},rAP=1.2,
        rStunMin=1,rStunMax=3.5,rBlast=400,rSource='https://wiki.leagueoflegends.com/en-us/Ashe (read 2026-10-08)',
        wArrows={7,8,9,10,11},wCone={27.75,37,37,46.25,46.25},wArrowWidth=20,volleyMissiles={'VolleyAttack','VolleyAttackWithSound'},wSpeeds={1500,2000},
        eSpeed=1400,eReveal=1000,peelHealth=.4,fleeRange=900},
    Jade_Ashe={id='classic',qToggle=true,qManaPerAttack=8,
        wRange=1300,wDamage={40,55,70,85,100},wAD='totalDamage',eRange={2500,3250,4000,4750,5500},rDamage={250,425,600},rAP=1,
        rStunMin=1,rStunMax=3.5,rBlast=400,rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Ashe (read 2026-10-08)',
        wArrowWidth=20,volleyMissiles={'Jade_AsheVolleyAttack','Jade_AsheVolleyAttackWithSound'},wSpeeds={1500,2000},eSpeed=1400,eReveal=1000,peelHealth=.4,fleeRange=900,scoutHealth=.3},
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
