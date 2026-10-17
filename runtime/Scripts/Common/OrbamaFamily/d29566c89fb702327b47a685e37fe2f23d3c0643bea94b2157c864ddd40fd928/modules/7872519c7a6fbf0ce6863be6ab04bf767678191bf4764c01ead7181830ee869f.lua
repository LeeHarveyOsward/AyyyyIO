return function(require)
return function()
-- Shared Graves mechanics data. Values preserved from the maintained controller.
-- Ranking pass 2026-10-10: Normal fullReload 2.08 s, the reload of both shells from empty
-- (https://wiki.leagueoflegends.com/en-us/Graves/LoL, page V26.17, read 2026-10-10); bounds the
-- observed-empty lease of the controller (Graves-1). Classic has no shells.
return {
 Graves={id='normal',q='GravesQLineSpell',w='GravesSmokeGrenade',e='GravesMove',r='GravesChargeShot',
  qBase={50,75,100,125,150},qAD=.55,returnBase={80,125,170,215,260},returnAD={.45,.6,.75,.9,1.05},
  qRange=800,qSpeed=3000,qRadius=40,qDelay=.25,returnSpeed=1600,returnRadius=100,wallDelay=.2,endDelay=1,
  wRadius=200,eMin=275,eRange=375,eSpeed=750,grit='GravesEGrit',maxGrit=8,
  rBase={275,425,575},rCone={200,320,440},rAD=1.5,rConeAD=1.2,coneRange=735,recoil=400,fullReload=2.08},
 Jade_Graves={id='classic',q='Jade_GravesQ',w='Jade_GravesW',e='Jade_GravesMove',r='Jade_GravesChargeShot',
  qBase={60,95,130,165,200},qAD=.8,qRange=800,qSpeed=2000,qRadius=50,qAngle=15.32,qPenalty=.35,qDelay=.25,
  wRadius=210,eMin=0,eRange=425,eSpeed=850,grit='Jade_GravesPassive_Counter',maxGrit=10,eBuff='Jade_GravesE_Buff',
  rBase={250,350,450},rCone={140,230,320},rAD=1.4,rConeAD=1,coneRange=800,recoil=0},
}

end
end
