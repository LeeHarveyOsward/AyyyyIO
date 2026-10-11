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


## Updates

Once installed, the family updates itself: in game it checks this repository every 10 minutes while
you are idle, downloads a new release in the background, verifies every file and switches to it the
next time you reload your scripts. Running the install line again also updates.


## Contents

- `install.ps1` - the installer
- `manifest.json` - every file with its SHA-256 and size
- `runtime/` - the files exactly as they are installed under `LOLEXT`

Release `340392e5242a0deaceec6ef7ae75776798395e3cdf4af26bbe8922dacef67b37`.
