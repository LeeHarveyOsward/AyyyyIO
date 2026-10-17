# AyyyyIO

The AyyyyIO script family for GoS:

| Script | What it is |
|---|---|
| **Orbama** | orbwalker, input pipeline and SDK |
| **OrbamaPrediction** | prediction |
| **OrbamaUtils** | activator, Auto-Smite, enemy cooldown tracker, recall and ward trackers, awareness |
| **EvAYYYYde** | evade |
| **AyyyyIO** | 59 champions, Normal and Classic profiles |

## Install or update

Press **Win+R** and paste:

```
powershell -NoExit -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/LeeHarveyOsward/AyyyyIO/main/install.ps1 | iex"
```

or run `irm https://raw.githubusercontent.com/LeeHarveyOsward/AyyyyIO/main/install.ps1 | iex` in PowerShell.

The installer finds your GoS folder (or asks for it), downloads the release, checks every
file against `manifest.json` and enables the five family scripts.
**Every other active script is switched off** so only the family runs; their files and settings are kept.
Reload the scripts in game afterwards. Running the same line again repairs or updates an install; old
releases are removed, so updates never pile up files.

- Keep your other scripts enabled: `& ([scriptblock]::Create((irm https://raw.githubusercontent.com/LeeHarveyOsward/AyyyyIO/main/install.ps1))) -KeepOtherScripts`

## Updates

Once installed, the family updates itself: in game it checks this repository every 10 minutes while
you are idle, downloads a new release in the background, verifies every file and switches to it the
next time you reload your scripts.

## What's in this repository

```
install.ps1          the installer
manifest.json        every file: where it comes from, where it is installed, SHA-256 and size
family-channel       the current release for the in-game updater
scripts/
  loaders/           the five entries GoS lists (Orbama.lua, AyyyyIO.lua, ...)
  Orbama/            orbwalker and SDK
  OrbamaPrediction/  prediction
  OrbamaUtils/       utilities
  EvAYYYYde/         evade; threats/ holds each champion's spell data (250 profiles)
  AyyyyIO/           champion core; champions/<Name>/ holds each champion's script and mechanics data
  shared/            libraries the scripts share (combat data, terrain, input geometry, overlay, guide, updater)
  release/           this release's module manifest and activation selector
sprites/             portraits and icons for the overlay
```

The files are built and stripped for release (no development tooling). In your game folder they are
stored by their SHA-256 under `Scripts/Common/OrbamaFamily/`; the loader checks every file's hash
before running it. The `updates` branch holds the same release in that layout for the in-game updater.

Release `d29566c89fb702327b47a685e37fe2f23d3c0643bea94b2157c864ddd40fd928`.
