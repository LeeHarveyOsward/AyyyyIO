return function(require)
-- Runtime identifiers: repository ClassicAIO + Riot Data Dragon 16.17.1.
-- Classic combat coefficients are candidates, deliberately gated until measured.
local P={version='16.17.1',build='2026-10-10-ranking',neutralTeam=300}
local World=require('CombatProfiles.world')
P.classicSmiteTargets=World.classicSmiteTargets
P.normalSmiteTargets=World.normalSmiteTargets
P.smites=World.smites
P.epics=World.epics
P.respawns=World.respawns
P.category=World.category
P.jungleEntity=World.jungleEntity
-- Normal ranges/knockback/shield: League wiki Lee Sin page, last changed V26.12, read 2026-10-10
-- (docs/LEESIN-PROVENANCE.json). Q1 stays at the conservative 1100 until collision-ray traces
-- confirm the listed 1200. The knockback is 800, reduced by up to Lee's plus the target's gameplay
-- radius (wiki bug note): kickRadiusReduction makes every consumer use the shortest such kick.
P.normal={id='normal',hero='LeeSin',qRange=1100,qSpeed=1800,qRadius=60,wRange=700,
    eRange=450,e2Range=550,rRange=375,kickDistance=800,kickRadiusReduction=true,q2Range=1250,smiteRange=500,
    wShield={60,105,150,195,240},wShieldAP=.8,wSpeed=1350,wCastDelay=0,
    qBase={60,90,120,150,180},qRatio=.9,eBase={35,60,85,110,135},eRatio=.9,
    rBase={175,400,625},rRatio=2,damageVerified=false,
    yellowWard=World.wards.normal.yellowWard,wards=World.wards.normal.wards,vision=World.wards.normal.vision}
P.classic={id='classic',hero='Jade_LeeSin',qRange=1100,qSpeed=1800,qRadius=60,wRange=700,
    -- Q1 BaseDamage/ADRatio confirmed in research/leesin/jade_leesin.bin.json.
    -- This narrow provenance does not certify Q2, item procs or other modes.
    q1DataMap=453,
    qMonsterAmplifiers={[771039]=1.1,[771080]=1.2,[773207]=1.3,[773209]=1.3},
    eRange=350,e2Range=500,rRange=375,kickDistance=1200,q2Range=1300,smiteRange=760,
    qBase={50,80,110,140,170},qRatio=.9,eBase={60,95,130,165,200},eRatio=1,
    rBase={200,400,600},rRatio=2,damageVerified=false,
    yellowWard=World.wards.classic.yellowWard,wardInventoryCharges=World.wards.classic.wardInventoryCharges,
    wards=World.wards.classic.wards,vision=World.wards.classic.vision}
P.qMarks={leesinqone=true,leesinqonemanager=true,leesinqprimed=true,leesinq2=true}
P.passive={leesinpassivebuff=true,leesinpassivecosmetic=true,leesinpassive=true}
P.eMarks={leesineone=true,leesinetempest=true,leesineonemanager=true}
P.immortal={judicatorintervention=true,kindredrnodeathbuff=true,undyingrage=true,
    kayler=true,zileanchronoshift=true,tryndamereundyingrage=true,zhonyasringshield=true}
-- Host flag disambiguation from pinned GG IsHeroImmortal; observed on normal
-- Jinx in the 55-minute trace. Not proof of a successful resurrection.
P.reviveReady={willrevive=true}
-- Names also used by repository Leona/KillerLib defensive-target checks;
-- OrbamaPrediction documents runtime buff type 4 as SpellShield.
P.kickBlocked={morganae=true,bansheesveil=true,sivire=true,nocturneshroudofdarkness=true,
    olafragnarok=true,poppydiplomaticimmunity=true,malzaharpassiveshield=true}
function P.get(hero)
    if hero=='LeeSin' then return P.normal elseif hero=='Jade_LeeSin' then return P.classic end
end
P.openings={
    normal={{'Red','Krugs','Raptors','Wolves','Blue','Gromp'},{'Blue','Gromp','Wolves','Raptors','Red','Krugs'}},
    classic={{'Red','Golems','Wraiths','Wolves','Blue','Wight'},{'Blue','Wight','Wolves','Wraiths','Red','Golems'}}}
-- Fallback discovery centers only for regular SR. Classic uses observed Camp objects.
P.centers={{3735,7890,100,'Blue'},{3781,6444,100,'Wolves'},{2112,8450,100,'Gromp'},
    {6824,5508,100,'Raptors'},{7772,4028,100,'Red'},{8482,2706,100,'Krugs'},
    {11032,7002,200,'Blue'},{11008,8386,200,'Wolves'},{12702,6444,200,'Gromp'},
    {7987,9471,200,'Raptors'},{7108,10892,200,'Red'},{6317,12146,200,'Krugs'},
    {10423,5181,0,'River'},{4397,9610,0,'River'}}
P.campNames={ [1]='Blue',[2]='Wolves',[3]='Raptors',[4]='Red',[5]='Krugs',[6]='Dragon',
    [7]='Blue',[8]='Wolves',[9]='Raptors',[10]='Red',[11]='Krugs',[12]='Baron',
    [13]='Gromp',[14]='Gromp',[15]='River',[16]='River',[17]='Herald'}
return P

end
