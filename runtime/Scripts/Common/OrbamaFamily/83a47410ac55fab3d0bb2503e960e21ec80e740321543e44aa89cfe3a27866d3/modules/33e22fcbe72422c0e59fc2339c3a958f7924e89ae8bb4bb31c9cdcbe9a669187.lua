return function(require)
return function()
-- Shared Lulu mechanics data. Values preserved from the maintained controller.
-- shieldSource names where the E shield figures offered to Evade were read (2026-10-08).
local D=(function()
return {
 LuluQ={
  BaseDamage={60,95,130,165,200},MinionMod=.7,
 },
 LuluWTwo={
  mCastTime=.2419,missileSpeed=2250,
 },
 LuluE={
  BaseDamage={70,110,150,190,230},BaseShield={70,110,150,190,230},DamageAPRatio=.5,ShieldAPRatio=.5,ShieldDuration=2.5,
 },
 LuluR={
  AoERadius=400,BonusHealth={275,425,575},BuffDuration=7,mCastTime=.25,
 },
 Jade_LuluW={
  missileSpeed=2000,
 },
 Jade_LuluWTwo={
  missileSpeed=2250,
 },
 Jade_LuluE={
  BaseDamage={80,130,180,230,280},BaseShield={60,105,150,195,240},DamageAPRatio=.6,ShieldAPRatio=.4,ShieldDuration=6,
 },
 Jade_LuluQ={
  BaseDamage={80,125,170,215,260},
 },
 Jade_LuluR={
  AoERadius=400,BonusHealth={300,450,600},BuffDuration=7,mCastTime=.25,
 },
}
end)()
return {
 Lulu={id='normal',q='LuluQ',w='LuluW',e='LuluE',r='LuluR',qBase=D.LuluQ.BaseDamage,qMinion=D.LuluQ.MinionMod,
  eBase=D.LuluE.BaseDamage,eAP=D.LuluE.DamageAPRatio,shield=D.LuluE.BaseShield,shieldAP=D.LuluE.ShieldAPRatio,shieldDuration=D.LuluE.ShieldDuration,
   -- wDelay: the larger of the installed asset (.175) and the wiki W cast time (.2419, V25.16, read 2026-10-10)
   -- until the lulu_w_probe recorder settles it; a later landing only makes W interrupts stricter.
   rHealth=D.LuluR.BonusHealth,rAP=.55,wAS=true,wSpeed=D.LuluWTwo.missileSpeed,wAllySpeed=math.huge,eDelay=.175,wDelay=D.LuluWTwo.mCastTime,rDelay=D.LuluR.mCastTime,rRadius=D.LuluR.AoERadius,
   shieldBuff='lulufaerieshield',pixEnemyBuff='luluevision',rDuration=D.LuluR.BuffDuration,rOfferAP=.55,
   rSource='https://wiki.leagueoflegends.com/en-us/Lulu Wild Growth: +275/425/575 (+55% AP) health for 7 s, range 900, no cast time (read 2026-10-08); rDelay is the installed timing (later start = safe side)',
   shieldSource='https://wiki.leagueoflegends.com/en-us/Lulu Help, Pix!: 70-230 (+50% AP), 2.5 s, no cast time (read 2026-10-08); eDelay is the installed asset timing',
   -- Ally attack steroids W answers (native cast names, lower case): spell names in the installed assets
   -- research/family-assets/<Champion>/spells.json (read 2026-10-10). A name the host does not report never matches.
   wSteroids={twitchfullautomatic=true,vayneinquisition=true,kogmawbioarcanebarrage=true,asheq=true,kaisae=true,tristanaq=true,xayahw=true,highlander=true},
   -- Engage states that are neither channels nor dashes (buff names, lower case; same asset spell names). Logged by
   -- the lulu_engage_state recorder; a name the host does not use never matches.
   wEngage={hecarimramp=true,powerball=true,highlander=true,kaisae=true,swainr=true,neekor=true}},
 Jade_Lulu={id='classic',q='Jade_LuluQ',w='Jade_LuluW',e='Jade_LuluE',r='Jade_LuluR',qBase=D.Jade_LuluQ.BaseDamage,qMinion=1,
  eBase=D.Jade_LuluE.BaseDamage,eAP=D.Jade_LuluE.DamageAPRatio,shield=D.Jade_LuluE.BaseShield,shieldAP=D.Jade_LuluE.ShieldAPRatio,shieldDuration=D.Jade_LuluE.ShieldDuration,
   rHealth=D.Jade_LuluR.BonusHealth,rAP=.5,wAS=false,wSpeed=D.Jade_LuluWTwo.missileSpeed,wAllySpeed=D.Jade_LuluW.missileSpeed,eDelay=.175,wDelay=.175,rDelay=D.Jade_LuluR.mCastTime,rRadius=D.Jade_LuluR.AoERadius,
   shieldBuff='Jade_LuluFaerieShield',pixEnemyBuff='Jade_LuluFaerieBurn',rDuration=D.Jade_LuluR.BuffDuration,rOfferAP=0,
   -- The asset holds no AP coefficient for BonusHealth; rAP=.5 above is the kept controller value, so the Evade offer counts the base only.
   rSource='research/family-assets/Jade_Lulu/spells.json:2456,2482 (BonusHealth 300/450/600, BuffDuration 7; 2026-10-08); AP share not in the asset: offer uses the base amount',
   shieldSource='research/family-assets/Jade_Lulu/spells.json:705,718,731 (60-240 +40% AP, 6 s; 2026-10-08); eDelay is the installed asset timing',
   -- Classic W empowers casters (no attack-steroid catalogue). Engage states: Classic asset spell names (2026-10-10).
   wEngage={jade_rammusq=true,jade_masteryihighlander=true}},
}

end
end
