# AyyyyIO

The AyyyyIO script family for GamingOnSteroids: **Orbama** (orbwalker and SDK), **OrbamaPrediction**,
**OrbamaUtils** (activator, Smite, wards, trackers), **EvAYYYYde** (evade) and **AyyyyIO** (champions,
Normal and Classic profiles).

## Install or update

Run in PowerShell:

```powershell
irm https://raw.githubusercontent.com/LeeHarveyOsward/AyyyyIO/main/install.ps1 | iex
```

The installer finds your GamingOnSteroids folder (or asks for it), downloads this release, checks every
file against `manifest.json`, backs up whatever it replaces and enables the five family scripts.
**Every other active script is switched off** so only the family runs; their files and settings are kept.
Reload the scripts in game afterwards.

To keep your other scripts enabled:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/LeeHarveyOsward/AyyyyIO/main/install.ps1))) -KeepOtherScripts
```

## Undo

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/LeeHarveyOsward/AyyyyIO/main/install.ps1))) -Rollback
```

restores the files and the script list from before the last install. Backups are kept in the
`.runtime-files` folder next to `LOLEXT`.

## Contents

- `install.ps1` - the installer
- `manifest.json` - every file with its SHA-256 and size
- `runtime/` - the files exactly as they are installed under `LOLEXT`

Release `c7b0060f8ed52bce4e055ddc76d677a39a0a67156ad038de7cb2940b0cb94f77`.
