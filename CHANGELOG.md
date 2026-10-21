# Changelog

Release tags use the existing updater sequence: `v<sequence>`. The public Git history begins at v3.

Entries for v3 through v8 were reconstructed from published commits. Dates below are the original publication dates; the GitHub release records and tags were added later. Tags identify the last published snapshot of each sequence, including any installer or documentation fixes made before the next sequence.

The one-line installer follows `main`. GitHub Releases retain the historical snapshots. Offline checks establish implementation behavior, not live game outcomes.

## [v8](https://github.com/LeeHarveyOsward/AyyyyIO/releases/tag/v8) - 2026-10-17

Champion casts, awareness and shared state

### Fixed

- Recognize Swain E return missiles with a zero native target and group the return stage under E.
- Respect Thresh Q2's own combat setting. Keep an observed leap active after its input receipt is collected, and end uncertain recast waits.
- Let Leona select a target within E range after considering farther R targets. Release engage plans when E is cancelled before sending.
- Use the recorded minimap fallback when matching calibration proves native coordinates are outside the render bounds.
- Keep ward expiry from drifting forward on every observation, and discard stale ward identities and movement endpoints.

### Changed

- Share health-bar damage drawing across controllers and withdraw stale KILL markers after healing, shield changes or identity replacement.
- Keep jungle travel on a stable camp destination and follow the shared opening route from the nearer eligible own buff.
- Prefer current native terrain collision while retaining profile-specific extracted navigation and team gates.
- Hide tracking options that have no supported display for their feature.

### Verification

The original publication passed focused offline checks for the changed components, public modules, updater and installer. Live confirmation of the forum reports was still pending. This entry does not establish a fix for the separately reported game exit.

[Published commit](https://github.com/LeeHarveyOsward/AyyyyIO/commit/05ec585a9cee43ff304fd4c7615e6269c5c2922f) · [Compare changes](https://github.com/LeeHarveyOsward/AyyyyIO/compare/v7...v8)

Runtime generation: `d29566c89fb702327b47a685e37fe2f23d3c0643bea94b2157c864ddd40fd928`.

## [v7](https://github.com/LeeHarveyOsward/AyyyyIO/releases/tag/v7) - 2026-10-12

One shared champion core

### Changed

- Ship the shared champion core once instead of embedding it into each champion program.
- Give each champion a folder containing its program and mechanics data.
- Use GoS consistently in the generated README.
- Keep the installed content-addressed module layout and updater paths compatible.

[Published commit](https://github.com/LeeHarveyOsward/AyyyyIO/commit/3dd795c95427678ea3a67d885cbe4540fe059192) · [Compare changes](https://github.com/LeeHarveyOsward/AyyyyIO/compare/v6...v7)

Runtime generation: `3e7cee7e0e6c6eb2b591fde05b7283548153e23bce6e9b4c24905c9c3762f1db`.

## [v6](https://github.com/LeeHarveyOsward/AyyyyIO/releases/tag/v6) - 2026-10-12

Clean up old installations and staged updates

### Fixed

- Remove completed installer staging copies and old release files while preserving generations that may still be in use.
- Clear obsolete staged updates before downloading a replacement release.
- Keep automatic recovery for an interrupted installation.

### Removed

- Remove the manual installer rollback option and permanent installation backups.

[Published commit](https://github.com/LeeHarveyOsward/AyyyyIO/commit/f29c170da7f1efaeb81b05cdbabb77dfdce67c8f) · [Compare changes](https://github.com/LeeHarveyOsward/AyyyyIO/compare/v5...v6)

Runtime generation: `64faddc7ebd40b0b905fe5d4fdcddda15cdcc368364fbf374ec7dcaf41762598`.

## [v5](https://github.com/LeeHarveyOsward/AyyyyIO/releases/tag/v5) - 2026-10-12

Readable release repository

### Changed

- Publish readable component files under `scripts/` and portrait assets under `sprites/` on `main`.
- Keep the content-addressed runtime store on the separate `updates` branch.
- Pin the updater channel to an immutable update-store commit and publish the channel after the store.
- Preserve the destination paths expected by installed loaders and updaters.

[Published commit](https://github.com/LeeHarveyOsward/AyyyyIO/commit/567cc74c47029e7ae6abfcaee22330f01b5119e8) · [Compare changes](https://github.com/LeeHarveyOsward/AyyyyIO/compare/v4...v5)

Runtime generation: `56a72d0d05f8c9967490eb6f9586f32754060b08e36ddbf87f625d2e157a465e`.

## [v4](https://github.com/LeeHarveyOsward/AyyyyIO/releases/tag/v4) - 2026-10-11

Installer recovery and path fixes

### Fixed

- Re-running the installer repairs damaged files, recovers an interrupted installation and replaces an existing install.
- The selected installation takes precedence over an older staged update.
- Shorten backup and staging paths to avoid failures on Windows installations without long-path support.

### Changed

- Publish the sequence-4 updater channel.
- Clarify GoS naming and installation instructions in the README.

This tag includes the installer and documentation fixes published before sequence 5.

[Published commit](https://github.com/LeeHarveyOsward/AyyyyIO/commit/37501364d8d9b8ad3b0724dba6dce0d9cddd0344) · [Compare changes](https://github.com/LeeHarveyOsward/AyyyyIO/compare/v3...v4)

Runtime generation: `340392e5242a0deaceec6ef7ae75776798395e3cdf4af26bbe8922dacef67b37`.

## [v3](https://github.com/LeeHarveyOsward/AyyyyIO/releases/tag/v3) - 2026-10-11

Initial public family

### Added

- Publish Orbama, OrbamaPrediction, OrbamaUtils, EvAYYYYde and AyyyyIO as one installable family.
- Add a PowerShell installer with package selection, destination discovery and manifest hash checks.
- Include the shared runtime, champion modules and overlay assets.

### Changed

- Download the repository archive once during installation instead of fetching every file separately.

This is the first release sequence present in the public repository history.

[Published commit](https://github.com/LeeHarveyOsward/AyyyyIO/commit/6ab71e02742f9f05a5a374695a8558eba9e203d4) · [Published files](https://github.com/LeeHarveyOsward/AyyyyIO/tree/6ab71e02742f9f05a5a374695a8558eba9e203d4)

Runtime generation: `c7b0060f8ed52bce4e055ddc76d677a39a0a67156ad038de7cb2940b0cb94f77`.
