return function(require)
return function()
-- Shared Rell mechanics data. Values preserved from the maintained controller.
return {Rell={id='normal',q='RellQ',w='RellW_Dismount',w2='RellW_MountUp',e='RellE',r='RellR',
 qBase={60,100,140,180,220},qAP=.6,qRange=600,qForward=520,qBehind=220,qStep=100,qRadius=75,qDelay=.4,qStun=.65,
 -- Crash Down reach, 2026-10-08: https://wiki.leagueoflegends.com/en-us/Rell "Target range 100 - 400", effect radius 180,
 -- cast 0.625, slide 320 over 0.5 s; patch 13.11 notes also give a 400 jump. The installed asset's
 -- castRangeDisplayOverride is 450 (kept as wDisplayRange, the drawn indicator); casts are planned inside 400.
 -- The leap itself has no published speed (the page describes it as happening over the cast time).
 wBase={60,90,120,150,180},wAP=.6,w2Base={10,25,40,55,70},w2AP=.4,wRange=400,wMinRange=100,wDisplayRange=450,wSlide=320,wRadius=180,wDelay=.625,
 -- Mount Up empowers the next attack for 3.5 s with 100 bonus range (same page). The two buff names are leads from a
 -- reference script (zgRell), not live verified: a name that never appears simply never triggers its rule.
 wAttackWindow=3.5,wAttackRange=100,wAttackBuff='rellwempoweredattack',wKnockupBuff='rellw_knockup',
 shieldBase={20,40,60,80,100},shieldHP=.11,wResist=.15,wKnockup=.4,wStun=.8,w2Stun=.6,
 eRange=1200,ePct={.05,.055,.06,.065,.07},eAP=.0003,eDuration=3,eBuffer=2,eRadius=300,eFast=.3,eSlow=.15,
 -- Full Tilt monster/structure cap by level (Rell-5): installed asset RellE mSpellCalculations 1925773807 =
 -- level curve 150 -> 300 (read 2026-10-10). The wiki (V14.23) lists 150-317.65; the installed asset wins.
 eMonsterCap={150,300},
 -- Mount Up speed burst (S6 haste offer): asset RellW_MountUp HasteTooltip/RellW_Dismount MountUpSpeed .3 with a 2 s
 -- decay (calc 2803503575), wiki en-us/Rell "+30% decaying over 2 s", read 2026-10-10.
 mountHaste=.3,mountHasteDecay=2,
 mountSource='family-assets/Rell/spells.json RellW_Dismount MountUpSpeed + RellW_MountUp calc 2803503575 (2 s) + wiki en-us/Rell, read 2026-10-10',
 rDPS={75,125,175},rAP=.55,rDuration=2,rInitial=425,rRadius=375,rHorizon=225,rForce=300,
 passive='rellp_debuff',maxStacks=5,passivePct=.03,passiveLife=5,refreshLife=3.5,
 mounted='rellw_mountedbuff',dismounted='rellw_dismountedbuff',shield='rellw_shield',eEmpower='relle_empowerself',storm='rellr'}}

end
end
