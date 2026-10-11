return function(require)
return function()
-- Skarner numbers the shared row in CombatProfiles/abilities.lua (M.controllers.Skarner, not edited by the
-- champion work) does not carry. The controller overlays these on a private copy of that row.
return {
 -- https://wiki.leagueoflegends.com/en-us/Skarner read 2026-10-10: Shattered Earth empowers the next three attacks
 -- (+25 attack range) within the qHold window of the shared row; throwing Upheaval ends Shattered Earth. The buff that
 -- carries the window is not confirmed by an asset or a live record: qBuff names the candidate from the installed asset
 -- index (entries.json 'SkarnerQ'); without it the controller times the window from its own observation of the stage.
 -- Impale cast time 0.75 s (shared geometry row).
 Skarner={qEmpowerRange=25,qLapseMargin=.5,qBuff='SkarnerQ',rInterruptDelay=.75,
  source='https://wiki.leagueoflegends.com/en-us/Skarner (read 2026-10-10)'},
 -- research/family-assets/Jade_Skarner/spells.json (installed 16.20 assets): Jade_SkarnerR castFrame 7.5 (0.25 s at 30
 -- frames per second), BaseDamage 100/150/200 at ranks 1-3, suppression 1.75 s; Jade_SkarnerW MSBonus .15/.17/.19/.21/.23.
 -- https://wiki.leagueoflegends.com/en-us/League_Classic/Skarner read 2026-10-10: Impale +50% AP; the same damage again when
 -- the suppression ends (not counted: the player may cancel the drag).
 Jade_Skarner={rCast=.25,rBase={100,150,200},rAP=.5,wSpeed={.15,.17,.19,.21,.23},
  source='research/family-assets/Jade_Skarner/spells.json; https://wiki.leagueoflegends.com/en-us/League_Classic/Skarner (read 2026-10-10)'},
}

end
end
