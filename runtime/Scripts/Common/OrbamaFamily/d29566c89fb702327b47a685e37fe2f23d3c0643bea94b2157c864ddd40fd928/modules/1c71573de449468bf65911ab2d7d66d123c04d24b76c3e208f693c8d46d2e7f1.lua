return function(require)
return function()
-- Shared Lulu mechanics data. Values preserved from the maintained controller.
-- shieldSource names where the E shield figures offered to Evade were read (2026-10-08).
return {
 Lulu={id='normal',q='LuluQ',w='LuluW',e='LuluE',r='LuluR',qBase={60,95,130,165,200},qMinion=.7,
  eBase={70,110,150,190,230},eAP=.5,shield={70,110,150,190,230},shieldAP=.5,shieldDuration=2.5,
   -- wDelay: the larger of the installed asset (.175) and the wiki W cast time (.2419, V25.16, read 2026-10-10)
   -- until the lulu_w_probe recorder settles it; a later landing only makes W interrupts stricter.
   rHealth={275,425,575},rAP=.55,wAS=true,wSpeed=2250,wAllySpeed=math.huge,eDelay=.175,wDelay=.2419,rDelay=.25,rRadius=400,
   shieldBuff='lulufaerieshield',pixEnemyBuff='luluevision',rDuration=7,rOfferAP=.55,
   rSource='https://wiki.leagueoflegends.com/en-us/Lulu Wild Growth: +275/425/575 (+55% AP) health for 7 s, range 900, no cast time (read 2026-10-08); rDelay is the installed timing (later start = safe side)',
   shieldSource='https://wiki.leagueoflegends.com/en-us/Lulu Help, Pix!: 70-230 (+50% AP), 2.5 s, no cast time (read 2026-10-08); eDelay is the installed asset timing',
   -- Ally attack steroids W answers (native cast names, lower case): spell names in the installed assets
   -- research/family-assets/<Champion>/spells.json (read 2026-10-10). A name the host does not report never matches.
   wSteroids={twitchfullautomatic=true,vayneinquisition=true,kogmawbioarcanebarrage=true,asheq=true,kaisae=true,tristanaq=true,xayahw=true,highlander=true},
   -- Engage states that are neither channels nor dashes (buff names, lower case; same asset spell names). Logged by
   -- the lulu_engage_state recorder; a name the host does not use never matches.
   wEngage={hecarimramp=true,powerball=true,highlander=true,kaisae=true,swainr=true,neekor=true}},
 Jade_Lulu={id='classic',q='Jade_LuluQ',w='Jade_LuluW',e='Jade_LuluE',r='Jade_LuluR',qBase={80,125,170,215,260},qMinion=1,
  eBase={80,130,180,230,280},eAP=.6,shield={60,105,150,195,240},shieldAP=.4,shieldDuration=6,
   rHealth={300,450,600},rAP=.5,wAS=false,wSpeed=2250,wAllySpeed=2000,eDelay=.175,wDelay=.175,rDelay=.25,rRadius=400,
   shieldBuff='Jade_LuluFaerieShield',pixEnemyBuff='Jade_LuluFaerieBurn',rDuration=7,rOfferAP=0,
   -- The asset holds no AP coefficient for BonusHealth; rAP=.5 above is the kept controller value, so the Evade offer counts the base only.
   rSource='research/family-assets/Jade_Lulu/spells.json:2456,2482 (BonusHealth 300/450/600, BuffDuration 7; 2026-10-08); AP share not in the asset: offer uses the base amount',
   shieldSource='research/family-assets/Jade_Lulu/spells.json:705,718,731 (60-240 +40% AP, 6 s; 2026-10-08); eDelay is the installed asset timing',
   -- Classic W empowers casters (no attack-steroid catalogue). Engage states: Classic asset spell names (2026-10-10).
   wEngage={jade_rammusq=true,jade_masteryihighlander=true}},
}

end
end
