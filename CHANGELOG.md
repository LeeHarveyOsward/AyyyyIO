# Changelog

Release tags use the existing updater sequence: `v<sequence>`. The public Git history begins at v3.

Entries for v3 through v8 were reconstructed from published commits. Dates below are the original publication dates; the GitHub release records and tags were added later. Tags identify the last published snapshot of each sequence, including any installer or documentation fixes made before the next sequence.

The one-line installer follows `main`. GitHub Releases retain the historical snapshots. Offline checks establish implementation behavior, not live game outcomes.

## [v11](https://github.com/LeeHarveyOsward/AyyyyIO/releases/tag/v11) - 2026-10-30

Smarter farming, steadier input and opt-in support logs

### Shared farming and waveclear
- Time incoming minion attacks from native cast end. Prevent already-landed damage from being subtracted again, a confirmed cause of early shots.
- Keep tracking launched attacks after the source retargets, casts again, disappears or dies.
- Include our own confirmed launched ranged attacks in the incoming-hit forecast.
- Observe allied turret projectiles, keep their damage through target switches, verify identities and avoid double-counting.
- Use available native turret timing instead of fixed substitutes when data is missing.
- Add a bounded attack scheduler for upcoming last-hit windows and spare waveclear/harass attacks.
- Stay cautious around uncertain allied aggro, exact lethal boundaries and minions forecast dead.
- Keep safe Senna soul collection without giving up an upcoming last hit.
- Coordinate rescue spells with the attack schedule and keep other last hits.
- Account for known spell cast locks when evaluating subsequent attacks.
- Exclude validated spell last-hit targets only after the spell is actually sent; admission or cancellation does not claim a minion.
- Refresh farming forecasts at dispatch and keep cooldown-based spell rescues.
- Keep champion attack preferences behind shared farming policy.

### Champion farming and combat
- Vayne: calculate post-Q attack flight from the resolved tumble endpoint. Keep follow-ups through delayed observations, require an actual send and native readiness, and do not repeat an already-observed empowered attack.
- Classic Vayne: respect unknown projectile timing in SDK target selection.
- Caitlyn: restore verified Classic AA travel, distinguish ordinary attacks and Headshots, and use shared timing in combat finishers.
- Ahri and Ezreal: unknown AA flight no longer counts as instant or wrongly vetoes rescue Q.
- Seraphine: include AA projectile travel when comparing farm spells with a ready attack.
- Corki: remove guessed AA timing from spell-plus-attack finishers.
- Ashe, Sivir, Teemo, Twitch and Twisted Fate: use checked shared attack-impact timing in affected farming/combat decisions.
- Normal Lux: coordinate Q's two-minion last-hit set with the attack schedule. Recheck both identities, final ray, collision order, damage and impacts before sending.
- Twitch: coordinate farm E's complete eligible kill set with the attack schedule. Never register a partial set when capacity is exceeded.
- Separate multi-minion spell coordination capacity from the smaller bounded attack search.
- Fizz, Jax, Wukong, Normal Shen and cougar Nidalee: an empowerment cast no longer claims damage from the basic attack that must still follow.
- Recognize fresh profile-declared empowerment buffs as shared attack-reset evidence.

### Orbwalking, input and skill allocation
- Stop repeating sent moves at an unchanged cursor location.
- Allow a fresh move after an attack or relevant input/state change, so attack-move cycles keep working.
- Clear stale right-button state after Evade clicks through a held button; this could block held combat modes until another manual click.
- Confirm the held modifier before sending the skill key in an allocation chord.
- Require an actual rank increase before reporting allocation success.
- Keep scheduled key-up retries instead of spending them repeatedly in one frame.
- Report completed held-key cleanup consistently.
- Share supported recall recognition, including SuperRecall, across the affected SDK, Utils, Lee Sin and Katarina guards.

### Recall tracking and global ultimates
- Restore recall countdowns/progress bars using validated native channel timing when buff clocks are corrupt.
- Keep established deadlines stable, detect restarted recalls and keep valid buff timing when channel duration is unavailable.
- Add Normal Jinx recall-to-base R sniping through the shared planner.
- Share Jinx R's stepped flight model across Evade, prediction, combat and recall shots.
- Include contact timing, qualified health observations, regeneration, fountain healing, shields and supported blockers in relevant recall-shot decisions.
- Apply Ezreal's Classic recall-shot damage reduction only to Classic, not Normal.
- Refresh timing and permission at dispatch; cancel unsent work when the opportunity ends.

### Orbamautils drawings and menus
- Move the minimap missing-time option under Last seen position in fog, keeping saved settings.
- Simplify Appearance labels and remove redundant Enemy titles.
- Add per-feature team filters: enemies on, allies off by default.
- Add optional ally cooldown tracking, including the player, in two compact side-by-side panels of up to five rows each.
- Prefer qualified native ally cooldowns, keep useful deadlines across missing samples and label calculated fallbacks as estimates.
- Draw actual remaining movement waypoints, and skip native waypoint reads for disabled teams.
- Show known levels independently of XP. Draw XP only when profile/map/data support it.
- Replace ward squares with ward glyphs, team colours, type markings and suitable timers.
- Apply feature and ward-type minimap switches together.
- Keep intersecting ward sight-radius circles visible when the ward itself is off screen.

### Opt-in support recording
- Start recording OFF after every reload, regardless of a previous saved opt-in.
- Add bounded public support recording; keep detailed development hooks lazy and ability capture separately opt-in.
- Keep five RECORDING SESSIONS, not necessarily five games, at up to 8 MiB each.
- Export one FamilySupport.jsonl through Orbama > Support logs, with filename and folder shown in the menu.
- Cap retained slots at 40 MiB and the export at another 40 MiB, plus a small index.
- Export incrementally during safe idle maintenance, pause recording for sharing and show storage/error messages.
- Remove legacy champion file sinks so old preferences cannot start separate unbounded logs.
- Make provider collection, development profiling and Evade diagnostics follow the recording switch.
- Add development evidence for farm readiness/settings/schedules, incoming hits, Q follow-ups and item observations.
- Remove redundant telemetry rows, add stationary missile heartbeats and recover capture capacity from lingering wrappers.
- Encode invalid native text safely and mark uncertainty.
- Nothing uploads automatically.

### Performance, packaging and verification
- Reuse scalar outline coordinates instead of retaining projection objects; reproject freshly each draw.
- In the affected offline LuaJIT comparison, median drawing allocation fell from 14.5 KiB to 1.8 KiB with matching decisions.
- All 24 stress runs pass without relaxed budgets.
- 4,874 Evade checks and 5,484 coverage assertions pass.
- Regenerate stale bundles and repair fixtures for recording defaults, buffer reservations, modifiers and export seeking.
- All 201 full-gate selections have passing results across retained/repaired batches. This was not a new full-suite run on one final commit.
- Final public candidate passes both Lua engines, archive readback, source parity, deterministic rebuild and 963 isolated installer assertions.

### Known limits
- Perfect CS and live FPS gains are not proven.
- Arbitrary whole-wave ability/reset planning and future allied retarget prediction remain incomplete.
- Native inventory slot mapping still limits BORK activation.
- Live fountain-hit timing remains unverified.

Public support recording starts off. Enable it under Orbama > Support logs when reporting a problem. Prepare the share file there, then share FamilySupport.jsonl from LOLEXT/Scripts/Common. A full script reload is required after updating.

## [v10](https://github.com/LeeHarveyOsward/AyyyyIO/releases/tag/v10) - 2026-10-28

Farming, ward jumps and game-end cleanup

### Fixed

- Keep waveclear from selecting invalid minions or minions forecast dead over living alternatives.
- Let Katarina damage revival targets without treating the native death-prevention flag as damage immunity. Real invulnerability remains protected, and revival targets are excluded from guaranteed-kill estimates.
- Resolve supported ward sources from native spell identity and readiness when inventory rows are unavailable. Preserve that source through Lee Sin's wardjump and insec, Katarina's queued ward mobility and shared reveal casts. Unknown charge counts remain unknown.
- Keep orbwalking active when world-cursor samples are corrupt.
- Retire callbacks safely during dispatch, cancel pending work and release owned input at unload. Late callbacks stay inert after host replacement.
- Apply sourced stationary cast times at shared dispatch and separate Nautilus R's cast name from its duration.

### Development recordings

- Add bounded farming and Katarina Q evidence with explicit coverage gaps.
- Preserve important cast observations under recorder pressure, resolve missile-owner handles and skip native reads for samples that cannot be retained.

### Verification and limits

The integrated farming build passed 122 sequential shared runners and all 24 stress runs with unchanged budgets. The Katarina correction passed 318 checks in both Lua engines and profiles, plus its release gate. The exact stripped release passed byte readback, source reproducibility, installer, controller initialization, load-order, unload and lazy-loading checks. Earlier unchanged champion packages retain their completed checks from the resumed gate.

Live recordings show wardjump completion and clean unloads. The farming fix was loaded, but CS attribution and total missed opportunities remain unknown. The Katarina correction still needs live confirmation after reload. No perfect-farming or live FPS claim is made. Native inventory item IDs, stacks and charges remain unreliable; ward resolution does not repair the compiled inventory reader. Public builds exclude development diagnostics.

## [v9](https://github.com/LeeHarveyOsward/AyyyyIO/releases/tag/v9) - 2026-10-28

Lucian, Hecarim, shared ability data and steadier dodges

### Added

- Lucian for Normal and Classic. Abilities go between attacks and never over a pending double shot, Q reaches through minions, E only lands where the target stays in attack range, and R finishes enemies out of attack range. Classic R is cast only through the selected-target bind because its shot count is not established.
- Evade recognizes Classic Lucian's Q, W and R instead of treating them as unknown casts.
- Orbama handles the Classic Lucian E attack reset and the movement and attack rules during his R.
- Hecarim for Normal and Classic, including shared approach-angle steering for his empowered E attack. Steering considers allied follow-up, terrain, escape risk and whether the hit already kills.
- Evade models projectiles that stop on the second unit, curved and fixed-time flights, impact areas, attached areas, charged ranges, growing areas and stepped projectile speeds where researched data supports them.

### Changed

- Update champion mechanics, cooldowns and Evade data for patch 26.21.
- Use the same readiness check for Classic item actives as for other casts, and read the native item spell slot.
- Share extracted ability values between champion mechanics and Evade, with explicit Normal and Classic stages and provenance.
- Score threat damage, control and displacement against the current game state, and share safe attack windows with the orbwalker.

### Fixed

- Keep a dodge route stable while the game still reports the old path, without sending the same click again.
- Keep prepared Evade outlines visible when only their timing refreshes.
- Reject recall observations with invalid clocks.
- Allow Evade's own defensive casts while it is dodging.
- Let Aatrox E follow the live Q wrapper cast and record each Q result once.
- Let Fiora Q chase freely moving targets and defer an early post-attack callback until the observed attack windup ends.
- Clear stale chat input latches when chat closes.

### Verification

The individual changes have focused offline checks and live-log evidence. The final combined development build passed syntax loading in Lua 5.1 and LuaJIT and deployment readback. Broader combined behavioural and performance gates were deferred at the owner's request to deploy immediately. Full ability coverage and live correctness remain unverified.

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
