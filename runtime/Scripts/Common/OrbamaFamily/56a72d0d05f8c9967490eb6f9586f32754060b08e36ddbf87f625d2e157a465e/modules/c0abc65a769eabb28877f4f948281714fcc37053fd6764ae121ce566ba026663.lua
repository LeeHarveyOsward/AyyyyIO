return function(require)
return function()
-- Sivir mechanics that are not in CombatProfiles/abilities.lua (M.controllers.Sivir keeps geometry and Q
-- coefficients). Normal and Classic are separate; no value is borrowed across profiles.
return {
 Sivir={id='normal',
  -- Boomerang Blade deals physical damage (https://wiki.leagueoflegends.com/en-us/Sivir, read 2026-10-10).
  qType='physical',qTypeSource='https://wiki.leagueoflegends.com/en-us/Sivir (Boomerang Blade: physical damage), read 2026-10-10',
  -- On the Hunt: 8/10/12 s, bonus movement speed 20-30% for Sivir and nearby allies (wiki read 2026-10-10).
  -- Used only as a chase tool in Combo (switch off by default).
  rKind='speed',rDuration={8,10,12},
  rSource='https://wiki.leagueoflegends.com/en-us/Sivir (On The Hunt: 8-12 s, +20-30% movement speed), read 2026-10-10'},
 Jade_Sivir={id='classic',
  -- Classic Boomerang Blade is magic damage: own Classic asset tooltip Spell_SivirQ_Jade_Tooltip "deals
  -- <magicDamage>@TotalDamage@ magic damage</magicDamage>" (research/evade/classic-localization-evidence.json,
  -- jade_sivir.bin sha256 daf32cce..., readback verified) and https://wiki.leagueoflegends.com/en-us/League_Classic/Sivir
  -- (read 2026-10-10). Earlier builds computed it as physical.
  qType='magical',qTypeSource='Classic asset tooltip Spell_SivirQ_Jade_Tooltip (magic damage), research/evade/classic-localization-evidence.json; wiki League_Classic/Sivir read 2026-10-10',
  -- Classic On The Hunt: 15 s, +25/45/65% attack speed and +25% movement speed, allies half (wiki League_Classic/Sivir,
  -- read 2026-10-10): a fight steroid, used in Combo while Sivir attacks the target.
  rKind='attack_speed',rDuration={15,15,15},
  rSource='https://wiki.leagueoflegends.com/en-us/League_Classic/Sivir (On The Hunt: 15 s, +25/45/65% attack speed), read 2026-10-10'},
}

end
end
