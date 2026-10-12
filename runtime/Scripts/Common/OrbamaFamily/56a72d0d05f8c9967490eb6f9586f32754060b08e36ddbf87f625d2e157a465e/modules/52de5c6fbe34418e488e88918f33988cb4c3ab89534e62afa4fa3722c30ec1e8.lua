return function(require)
return function()
-- Shared Shen mechanics data. Values preserved from the maintained controller.
return {
 Shen={id='normal',q='ShenQ',w='ShenW',e='ShenE',r='ShenR',eRange=600,qKind='blade',
  qBuff='ShenQBuff',qWeak='ShenQBuffWeak',qStrong='ShenQBuffStrong',wBuff='ShenWActive',rChannel='ShenRChannelBuffBar',
  passive='ShenPassiveShield',wRadius=350,wDuration=1.75,qPercent={.02,.025,.03,.035,.04},qCap={100,125,150,175,200},
  -- Twilight Assault (https://wiki.leagueoflegends.com/en-us/Template:Data_Shen/Twilight_Assault, read 2026-10-10):
  -- bonus magic damage 10-40 "based on level" (+2-4% (+1.5% per 100 AP) max health); when the blade hits a champion
  -- 5/5.5/6/6.5/7% (+2% per 100 AP) and +50% attack speed. The champion-hit tier is used only while ShenQBuffStrong is seen.
  -- The 10-40 flat part by champion level comes from the installed asset (research/family-assets/Shen/spells.json,
  -- ShenQ mSpellCalculations 290955862: QBaseOnHitDamage 10, +6 at levels 4, 7, 10, 13 and 16; read 2026-10-10).
  -- qFlat stays the level-1 value, used when the level cannot be read (a lower bound).
  qFlat=10,qFlatByLevel={10,10,10,16,16,16,22,22,22,28,28,28,34,34,34,40,40,40},
  qFlatSource='research/family-assets/Shen/spells.json ShenQ mSpellCalculations 290955862 (10 + 6 at levels 4/7/10/13/16; installed asset, read 2026-10-10)',
  qPercentAP=.015,qStrongPercent={.05,.055,.06,.065,.07},qStrongPercentAP=.02,
  qSource='https://wiki.leagueoflegends.com/en-us/Template:Data_Shen/Twilight_Assault read 2026-10-10',
  -- Shadow Dash for Evade. The speed is 800 + 100% movement speed (base 340 = 1140); a registration takes fixed
  -- numbers, so this is a bracket whose slow end (a roughly 40% slowed Shen) is the safety margin.
  eMin=300,eSpeeds={1000,1140},eDelays={0},
  eSource='https://wiki.leagueoflegends.com/en-us/Shen Shadow Dash: range 300-600, no cast time, speed 800 + 100% movement speed, base movement speed 340 (read 2026-10-08)'},
 Jade_Shen={id='classic',q='Jade_ShenQ',w='Jade_ShenW',e='Jade_ShenE',r='Jade_ShenR',eRange=575,qKind='target',
  qRange=475,qBase={60,100,140,180,220},qAP=.6,qDelay=.42,qSpeed=1500,qMark='Jade_ShenQ_Heal',
  passive='Jade_ShenPassive_Marker',passiveAttack='Jade_ShenPassive_Attack',wDuration=3,wBase={60,100,140,180,220},wAP=.6,
  wSource='research/family-assets/Jade_Shen/spells.json:1308,1321,1334 (Jade_ShenW BaseShieldAmount 60-220, APShieldMod .6, ShieldDuration 3; no cast-time field; 2026-10-08)',
  -- Same "bonus speed + movement speed" shape as Normal: DashBonusSpeed 800. The Classic base movement speed is not
  -- in the asset, so the fast end only assumes 300; the slow end is the margin. The E record carries an unnamed .25
  -- field (11704a2b) that may be a cast time: both 0 and .25 are declared and Evade must be safe under either.
  eMin=300,eSpeeds={1000,1100},eDelays={0,.25},
  eSource='research/family-assets/Jade_Shen/spells.json:488,501,514 (DashBonusSpeed 800, MinimumDistance 300, MaximumDistance 575; 2026-10-08)'},
}

end
end
