return function(require)
return function()
-- Shared Fizz mechanics data. Values preserved from the maintained controller.
-- Normal R tiers (2026-10-10): the shark grows with the distance the lure travelled before it attached:
--  under 455 small, 455-910 medium, over 910 large (https://wiki.leagueoflegends.com/en-us/Fizz, read 2026-10-10;
--  thresholds not in the decoded assets). Medium x1.25 and large x1.5 of the small damage: asset FizzR DataValues
--  MidDamageMulti 1.25 / LargeDamageMulti 1.5 (research/family-assets/Fizz/spells.json), which equals the wiki's
--  225-525 (+75% AP) and 270-630 (+90% AP). `band`: inside 40 units past a threshold the lower tier is credited
--  (prediction error). Classic R has one fixed damage.
-- E timing (both profiles): Fizz is untargetable for 0.75 s and lands after it (Normal wiki 2026-10-10, Classic per
--  fizz-provenance.json eTiming); the hop transport before it is unmeasured, so 0.75 is a lower bound on the landing.
-- Normal E2 (2026-10-10): e2Radius 225 = FizzE DataValues SmallAoESize and FizzETwo mEffectAmount[3]
--  (research/family-assets/Fizz/spells.json; wiki Trickster effect radius 225, read 2026-10-10). e2Cast 0.15 =
--  FizzETwo castFrame 4.535 at 30 frames/s (same asset). The hop speed is published nowhere (wiki, assets: missileSpeed
--  20 is a placeholder), so e2Speed stays unset and the slam horizon is the cast-frame lower bound; the dev trace
--  fizz_e2_landing records seconds and hop length to settle it.
-- Normal wReachBonus 50: the W-empowered attack gains 50 bonus range (wiki Seastone Trident, read 2026-10-10).
return {
 Fizz={id='normal',q='FizzQ',w='FizzW',e='FizzE',e2='FizzETwo',buffer='FizzEBuffer',r='FizzR',
  wBuff='FizzWActive',wAttack='FizzWBasicAttack',onHit='FizzOnHitBuff',bleed='FizzWDOT',fish='FizzRCling',
  qBase={10,25,40,55,70},qAP=.55,wBase={50,75,100,125,150},wAP=.45,wDuration=4,
  dotBase={30,45,60,75,90},dotAP=.25,eBase={80,130,180,230,280},eAP=.95,
  rBase={180,300,420},rAP=.6,rRange=1300,rSpeed=1300,rDelay=2,rTiered=true,
  rTiers={near=455,far=910,band=40,mid=1.25,large=1.5},eLanding=.75,
  e2Radius=225,e2Cast=.15,wReachBonus=50},
 Jade_Fizz={id='classic',q='Jade_FizzQ',w='Jade_FizzW',e='Jade_FizzE',e2='Jade_FizzETwo',buffer='Jade_FizzEBuffer',r='Jade_FizzR',
  wBuff='Jade_FizzWActive',bleed='Jade_FizzWDOT',fish='Jade_FizzRCling',
  qBase={10,40,70,100,130},qAP=.4,wBase={10,15,20,25,30},wAP=.2,wDuration=5,
  dotBase={30,40,50,60,70},dotAP=.35,dotMissing={.04,.05,.06,.07,.08},eBase={70,120,170,220,270},eAP=.75,
  rBase={200,325,450},rAP=1,rRange=1275,rSpeed=1350,rDelay=1.5,rTiered=false,eLanding=.75},
}

end
end
