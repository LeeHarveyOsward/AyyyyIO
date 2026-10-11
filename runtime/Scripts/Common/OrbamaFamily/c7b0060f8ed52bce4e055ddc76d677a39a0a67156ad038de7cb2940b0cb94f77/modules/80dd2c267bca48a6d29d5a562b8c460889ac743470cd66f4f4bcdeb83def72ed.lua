return function(require)
return function()
-- Shared Nautilus mechanics data. Values preserved from the maintained controller.
return {
 Nautilus={id='normal',q='NautilusAnchorDrag',w='NautilusPiercingGaze',e='NautilusSplashZone',r='NautilusGrandLine',
  rCast='NautilusGrandLineStart',shield='NautilusPiercingGazeShield',passive='NautilusPassiveCheck',root='NautilusPassiveRoot',
  qRoot='NautilusAnchorDragRoot',passiveCD=6,qBase={85,125,165,205,245},qAP=.9,eBase={55,90,125,160,195},eRange=600,eArea=600,
   rBase={150,275,400},
   -- Wiki Nautilus read 2026-10-10: Q reach 1122 (asset display range 1150), radius 90, speed 2000, cast .25; R cast .46,
   -- homing charge 275 units/s accelerating by 466.67 units/s per second, eruption radius 225 (knock-back band 300);
   -- Q is a 1 s stun. qControl lists the own Q-control buff names E and R wait for (the stun's native name is
   -- unconfirmed: dev trace nautilus_hook_buffs records the hooked target's buffs).
   qRange=1122,qRadius=90,qSpeed=2000,qCast=.25,rCast=.46,rSpeed=275,rAccel=466.67,rRadius=225,
   qControl={'NautilusAnchorDragRoot'},
   geometrySource='https://wiki.leagueoflegends.com/en-us/Nautilus (read 2026-10-10)'},
 Jade_Nautilus={id='classic',q='Jade_NautilusQ',w='Jade_NautilusW',e='Jade_NautilusE',r='Jade_NautilusR',
  rCast='Jade_NautilusR_Start',shield='Jade_NautilusW_Shield',passive='Jade_NautilusPassive_Check',root='Jade_NautilusPassive_Root',
  qRoot='Jade_NautilusQ_Root',passiveCD=9.75,qBase={60,105,150,195,240},qAP=.75,eBase={60,100,140,180,220},eRange=400,eArea=550,
   rBase={200,325,450},
   -- League_Classic/Nautilus read 2026-10-10: same Q (1122, width 180, speed 2000) and R geometry/charge as Normal;
   -- R cast .46, speed 275 + 466.67 per second, radius 225/300 (Classic page). Q is a 1 s stun there too.
   qRange=1122,qRadius=90,qSpeed=2000,qCast=.25,rCast=.46,rSpeed=275,rAccel=466.67,rRadius=225,
   qControl={'Jade_NautilusQ_Root'},
   geometrySource='https://wiki.leagueoflegends.com/en-us/League_Classic/Nautilus (read 2026-10-10)'},
}

end
end
