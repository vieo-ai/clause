# ClauseOS Project Ledger & Architectural Milestones

## Overview

ClauseOS is a zero-overhead, bare-metal microkernel environment, distributed BEAM cloud OS, and transmedia agent workbench. It enforces deterministic, hermetic state isolation across Windows, Linux, and macOS without host pollution.

This ledger documents the chronological evolution of the system based on git commit history from repository creation to full green matrix cross-platform CI/CD status, followed by active and upcoming architectural phases.

---

## Chronological Commit History & Architectural Phases

### Phase 1: Inception & Core Scaffolding (Oct 19, 2026)

* **`559d454d`**: Initial repository commit.
* **`fb3ac8b3` – `adfc8725`**: Initial core manifests initialized (`.gitattributes`, `.gitconfig`, `.gitignore`, `.mise.toml`, `.clause.toml`, `apm.yml`, `justfile`).
* **`253d5229` – `fadde797`**: Bootstrap entry points introduced (`clause.bat`, `clause.ps1`, `clause.sh`, `install.bat`, `install.sh`, `start.bat`, `start.sh`) for provisioning PowerShell Core dynamically.
* **`41cca74f` – `ed9124fa`**: Initial GitHub Actions matrix established for cross-platform runner detection and validation.
* **`d04f9194` – `4726d4ed`**: Initial environment scripts added (`env.ps1`, `env.nu`, `env.sh`) establishing baseline variables.
* **`90843fca` – `92050c04`**: Windows profile confinement and cleanup to prevent OS dotfile leaks into host profile paths.
* **`0e159177` – `61ee92cd`**: Introduction of Universal Command Router, ASCII banner command, and Startup Verification Engine.
* **`e29e17d8` – `d131ecfc`**: Git subtree automation scripts for ecosystem dependencies (`cozystack`, `framework`, `glimr`, `hashistack`, `loom`, `lustre`, `plushie`, `shore`, `stacker`, `tauri`, `typhoon`, `upsonic`).
* **`5fb1c964` – `87ca9f15`**: Dynamic Nushell Mise activation overlay generation (`mise.nu`).

### Phase 2: Hermetic Isolation & Stage 0 Verification (Oct 20 – 21, 2026)

* **`638eab2d` – `849ae19c`**: System verification suites implemented in `run_all.nu`, establishing `test_stage0.nu`, `test_stage1.nu`, and baseline `test_hermeticity.nu`.
* **`a940bade`**: Updated hermeticity tests to assert `.local/bin` presence in `PATH`.
* **`658b1257` – `b6d20121`**: Standardization of entrypoint naming to `cx.bat`, `cx.ps1`, and `cx.sh`, aliasing `carrier` and `cx` to the microkernel bootloader.
* **`1f523da6`**: Unified entrypoint routing.

### Phase 3: Project Root Consolidation & Clean Architecture (Oct 22 – 24, 2026)

* **`26c0a28b` – `da01e74f`**: Git config global redirection (`.gitconfig` isolation at root) and `sync_jet.ps1` implementation.
* **`3c489de5` – `ea334a86`**: Restructuring of `.mise.toml` to support core language runtimes and toolchain finalization hooks.
* **`d25d29b8` – `328eb6d6`**: Removal of obsolete user directories from git tracking, enforcing all state to `.home/`.

### Phase 4: Canonical Script Hierarchy & Test Framework (Oct 26 – 27, 2026)

* **`6ddde493` – `a50143a7`**: Rewrite of `boot.ps1`, `env.nu`, `env.sh`, and `env.ps1` to canonical specification:
  * Windows NT path anchoring (`AppData\Local`, `AppData\Roaming`).
  * POSIX XDG path anchoring (`.local`, `.config`, `.cache`).
  * Universal `CLAUSE_PROJECT_ROOT` resolution via `FILE_PWD`.
* **`00d3267f` – `55692e5c`**: Environment testing harness added across all shell dialects (`run_tests.ps1`, `run_tests.nu`, `run_test.sh`).
* **`1b287dcb` – `cce4c743`**: Refactored Nushell handoff and diagnostic logging inside `boot.ps1`.
* **`5efd44d6` – `769c8d93`**: Comprehensive rewrite of `test_hermeticity.nu` and `test_stage0.nu` asserting strict confinement.
* **`872e5387` – `e910c210`**: Modularization of installer scripts into dedicated subdirectories.

### Phase 5: Renv Runtime Split & Pulumi Integration (Oct 27, 2026)

* **`876a9f3f` – `5cde151b`**: Addition of Pulumi infrastructure engine installer and binary path resolution.
* **`6a441003`**: Addition of Python and package runtimes to `.mise.toml`, seeding standalone `uv`.
* **`d42e0b46` & `ef1ab516`**: Creation of initial installer recipes for Unsloth AI Engine and ComfyUI.
* **`38808378`**: Relocation of application installers to `scripts/cli/pwsh/renv/` establishing the two-tier architecture.
* **`ae706f65` – `5cecce66`**: Integration of `unsloth/bin` into `.mise.toml` `_.path` and dispatching post-Mise runtime recipes in Stage 3.

### Phase 6: Directory Provisioning & Cache Hardening (Oct 28, 2026 - Early)

* **`09a4dd3be` – `e59cbc0a`**: Introduction and enforcement of `CLAUSE_CACHE_DIR` across Windows, Linux, and macOS.
* **`e7358ed8`**: Added fallback resolution for `uv` binary via direct bin, PATH, and Mise shims with diagnostic error logging.
* **`b4f405e3`**: Cleaned and re-created `CLAUSE_TEMP_DIR` on boot to prevent stale locks while ensuring directory existence for child scripts.
* **`8970e0fef` – `8a1381b6`**: Guaranteed existence of `CLAUSE_BIN_DIR` before PATH expansion.
* **`e6e0e0e4`**: Ensured `CLAUSE_TEMP_DIR` and `CLAUSE_CACHE_DIR` exist before Unsloth writes override files.

### Phase 7: Cross-Shell PATH & Nushell Delimiter Normalization (Oct 28, 2026 - Midday)

* **`a9f80ea0`**: Fixed `boot.ps1` Mise shim PATH injection to use platform-aware delimiters (`:` on POSIX, `;` on Windows), preventing delimiter bleed.
* **`26d47ba9` – `c4b2b397`**: Hardened Nushell `env.nu` and `test_hermeticity.nu` with defensive two-pass entry splitting across both `;` and `:`.
* **`0ee86088` – `501bafdb`**: Refined path expansion logic to handle macOS `/var` vs `/private/var` symlink canonicalization.
* **`3f588384`**: Streamlined Nushell `config.nu` to load `source ./mise.nu` via static parse-time relative resolution, removing parse-time variable errors and restoring `$env.config` processing.

### Phase 8: ComfyUI Hardware Matrix & macOS Intel Fix (Oct 28, 2026 - Afternoon)

* **`cb09ba0f` – `0b8bdb47`**: Registered ComfyUI in `.clause.toml` and added `comfyui/bin` to `.mise.toml` `_.path`.
* **`9db433a1` – `2e8e5150`**: Implemented `scripts/cli/pwsh/renv/installer_comfyui.ps1` with 5-way hardware acceleration and error logging.
* **`d452e807`**: Added conditional wheel requirement filter for macOS Intel (`x86_64`) runners to bypass `comfy-angle`, enabling 100% green CI/CD status across all platforms.

### Phase 9: Modular SSOT Engine, Polyglot Package Control Plane & AI Plugin Supply Chain (Oct 29 – Nov 15, 2026) [`v0.8.0-dev.10`]

* **`49f55c6a` – `26262b4e`**: Expanded `README.md` with BEAM distributed backplane, Gleam orchestration, Seax, and RinG interoperability; registered HashiStack (`nomad`, `consul`, `vault`, `boundary`, `pulumi`, `packer`) and BEAM/Gleam (`erlang`, `elixir`, `gleam`, `rebar`) runtimes across layered `MISE_ENV` overlays.
* **`0f74e6ec` – `dafcd966` & `d41253bb`**: Consolidated Stage 0 microkernel bootloader logic directly into `cx.ps1` and `cx.sh` (removing standalone `boot.ps1` and `justfile`).
* **`8734d9f5` – `eb6c74f2`**: Implemented ClauseOS Git Subtree Plugin Synchronizer (`cx plugin add|pull|push`) in `scripts/cli/nu/commands/plugin.nu` with `git ls-remote` upstream commit resolution.
* **`06f59fe5` – `0fd9557e`**: Mounted first-party cross-platform Lua runtime plugins as git subtrees under `plugins/` (initially `mise-*`, standardized to `plugins/cx-*`: `cx-lemonade`, `cx-fastflowlm`, `cx-vscode`/`code`, `cx-unsloth`, and `cx-comfyui`), followed by multi-platform CI stabilization (`0dc2eecf` – `aebb7936`, including Rebar3 Windows `.cmd` launcher generation).
* **`803b5b43` – `a0994de6` & `900356ce`**: Retired standalone `env.ps1`/`env.sh` scripts and introduced declarative `config/env/*.toml` modules (`00-core.toml`, `10-identity.toml`, `20-toolchains.toml`, `30-shell.toml`, `40-ml-hub.toml`) parsed via 8-pass iterative `${VAR}` symbol expansion in `cx.ps1` and `cx.sh`.
* **`277cb20d` – `dbd1af44`**: Added `wsl = "3.0.5"` to `.clause.toml` and implemented `scripts/cli/pwsh/installers/installer_wsl.ps1` with GitHub release verification and elevation gates.
* **`80a53d59` – `d82553e3`**: Introduced layered `MISE_ENV` overlays (`.mise.paths.toml`, `.mise.ai.toml`, `.mise.cloud.toml`, `.mise.local.toml`) with default `MISE_ENV="paths,ai,cloud"`.
* **`d553c444` – `9db925e0`**: Implemented hermetically confined Scoop (`installer_scoop.ps1` with in-place core patches to `lib/core.ps1`, `lib/shortcuts.ps1`, `lib/system.ps1`, `libexec/scoop-import.ps1`, and `environment.ps1` registry PATH snapshot guards), Homebrew (`installer_brew.sh`), and the Unified Polyglot Package Control Plane (`cx pkg`, `cx pkg:add`, `cx pkg:mise`, `cx pkg:scoop`, `cx pkg:brew`) with `toml_pin.nu` auto-pinning.
* **`fdfcdacc` – `134373e0`**: Enforced Stage 0 preflight redlines against unmanaged host `mise`/`scoop`/`brew` installations, CI runner path scrubbing, and `CLAUSE_STATUS="online"` nested session boundary validation.
* **`fe7fabc5` – `2a8cc8b5`**: Mounted `plugins/cx-inferssd` subtree (`vieo-ai/cx-inferssd`, originally `mise-inferssd`), achieved green multi-platform CI builds (`Windows`, `Linux`, `macOS`), and pinned `inferssd = "v0.1.4"` in `.mise.ai.toml`.

### Phase 10: CCEFS Curriculum Formalization, Source Audits & The Gleam Compiler Pivot (Nov 16 – 20, 2026) [`v0.9.0-dev.1`]

* **`5d2d9bd` – `aae107e`**: Updated project ledger with Phase 9 supply-chain milestones; revised `README.md` for `v0.9.0-dev.1` version bump and enhanced orchestration model details.
* **`181da03` – `1c32679`**: Formally amended `ADR 002` (three-tier substrate), `ADR 004` (modular TOML environment engine), and `ADR 011` (status update and architectural refinements).
* **`cdfd244` – `1b60551`**: Standardized plugin organization and repository naming from `mise-*` to `cx-*` (`cx-comfyui`, `cx-fastflowlm`, `cx-inferssd`, `cx-lemonade`, `cx-unsloth`, `cx-vscode`) to ensure clean compatibility with upstream Mise.
* **`8ba0681` – `06c2481`**: Enforced strict repository hygiene and developer privacy, replacing personal credentials in `.gitconfig` with template placeholders and ignoring the entire `.home/` sandbox in `.gitignore`.
* **`18c318e`**: Implemented the ClauseOS Source Bundle & PDF Exporter (`scripts/cli/nu/commands/bundle.nu`), automating the packing of all tracked repository files, ADRs, and manifests into a consolidated, reproducible snapshot (`cx bundle`).
* **`f288705` – `ff20149`**: Formalized the foundational CCEFS 30-Module Master Curriculum Specification suite in `docs/ccefs/`:
  * `00-PROJECT-SPECIFICATION-v3.0.md` (Quad Synthesis Model, 27-package Illuminate mapping, and 12-domain competencies).
  * `01-ccefs-30-modules-v4.3.md` (The complete 6-stage syllabus from Stage 0 bare-metal userland through Stage 5 open-core release).
  * `02-stage0-foundation-modules-v4.3.md` (Stage 0 deep-dive on `.home/` confinement and toolchain supply chain).
  * `03-stage1-2-compiler-orchestrator-v4.3.md` (Stages 1 & 2 deep-dive on compiler construction and distributed orchestration).
  * `04-vieo-ai-curriculum-portal.md` (The 4-track portal architecture linking Track 1 CCEFS with the AIEFS Encyclopedia).
* **`7fa82f1`**: Executed comprehensive forensic audit across all 177 tracked files, publishing `05-source-bundle-audit-report.md` isolating the seven internal code, test, and documentation defects.
* **`ce34294`**: Added `.ground` content-addressed VFS directory to `.gitignore` to prevent tracking of runtime-generated virtual filesystem blobs.
* **`4ba1a51`**: **The Gleam Compiler Pivot:** Authored `docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md`, establishing the landmark consensus to fork `gleam-lang/gleam` inside `packages/clause/` (`cxc`) with Monkey-X multi-target emitters (`--target rust`, `--target beam`, `--target client`), direct `@external(rust, ...)` crate linking, and the Nine Canonical Operational Pillars.
* **`1698aef`**: Authored `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md`, establishing the non-destructive 3-batch surgical remediation roadmap.
* **`7028e06` & `61970fb`**: Mounted `plugins/cx-multipass` Git subtree (`vieo-ai/cx-multipass @ fdf3db8`) for cross-platform Ubuntu instance provisioning.

### Phase 11: Research Governance Framework, Namespace Audits & Totality Reconciliation (Nov 20 – 22, 2026)

* **`4b20313` – `3693926`**: Designed and published the seven-stage research governance architecture series in `docs/ccefs/`:
  * `08-frame-stage-research-brief-clauseos.md` (`4b20313`): Core architectural decisions, falsifiable research questions, scope boundaries, and readiness gating.
  * `09-gather-stage-research-protocol-clauseos.md` (`3b4f750`): Search architecture, controlled vocabulary rings, 5-stratum routing, and 14 primary seed sources.
  * `10-triage-stage-corpus-governance-clauseos.md` (`57dff79`): 5-tier SSOT authority appraisal, deduplication clusters, and 199-source active corpus charter.
  * `11-extract-stage-evidence-matrix-clauseos.md` (`536892e`): Structured CES-10 extraction schema, authoritative source cards, and 26 passage anchors.
  * `12-synthesize-stage-cross-reconciliation-clauseos.md` (`e110335`): Cross-system insight matrix, contradiction register, gap map, and authoritative claim ledger.
  * `13-verify-stage-audit-and-reconciliation-clauseos.md` (`64c59e8`): Verification gauntlet, numerical bounds, Quad Synthesis compliance, and repair specifications.
  * `14-cite-stage-verification-library-clauseos.md` (`3693926`): Cryptographic version provenance, physical locator mapping, claim-to-citation fit audit, and release record.
* **`83130c3` – `d120f06`**: Refined titles, standardized classifications, and added constitutional metadata preambles across governance specifications 08 through 14.
* **`c4f101b`**: Removed unused legacy `material` documentation directory and streamlined `mkdocs.yml` navigation structure.
* **`47a42ca`**: Published `15-investigation-report-cx-pkg-refactor-clauseos.md`, conducting a forensic audit of the `cx pkg` namespace relocation and diagnosing the delegation regression in `commands/pkg/add.nu`.
* **`3ec4542`**: Published `16-documentation-audit-and-alignment-clauseos.md`, evaluating all 13 ADRs, root ledgers, and curriculum specifications against the current project scope.
* **`941fc14`**: Published `17-totality-project-evaluation-clauseos.md`, reconciling the entire repository history across all 204 Git commits and establishing the definitive 3-step action roadmap.

---

## Architectural Decision Records (ADRs)

| ADR | Title | Key Commits / Context | Status |
| :--- | :--- | :--- | :--- |
| [ADR 0001](docs/adr/adr_001_hermetic_state_confinement_and_canonical_directory_hierarchy.md) | Hermetic State Confinement and Canonical Directory Hierarchy | `6ddde493`, `872e5387`, `09a4dd3b`, `e59cbc0a` | Accepted |
| [ADR 0002](docs/adr/adr_002_two_tier_toolchain_orchestration_mise_renv.md) | Two-Tier Toolchain Orchestration (Mise + Renv) | `6a441003`, `38808378`, `5cecce66`, `06f59fe5`, `4134fc86`, `181da03` | Accepted (Amended) |
| [ADR 0003](docs/adr/adr_003_dynamic_multi_vendor_hardware_acceleration_matrix.md) | Dynamic Multi-Vendor Hardware Acceleration Matrix | `d42e0b46`, `9db433a1`, `2e8e5150`, `d452e807` | Accepted |
| [ADR 0004](docs/adr/adr_004_cross_shell_environment_and_path_delimiter_canonicalization.md) | Cross-Shell Environment and PATH Delimiter Canonicalization | `a9f80ea0`, `26d47ba9`, `501bafdb`, `a0994de6`, `134373e0`, `86cf83b` | Accepted (Amended) |
| [ADR 0005](docs/adr/adr_005_unified_model_storage_hub.md) | Unified Model Storage & Ecosystem Cache Projection | `4e34401e` (`40-ml-hub.toml`), `HF_HOME` Anchoring | Accepted |
| [ADR 0006](docs/adr/adr_006-micro-instance-virtualization.md) | Cross-Platform Micro-Instance Virtualization (`cx vm`) | `dbd1af44` (`installer_wsl.ps1`), `41c0f152` (`brew:lima`), `61970fb` | Accepted (Restored) |
| [ADR 0007](docs/adr/adr_007-open-core-and-monetization.md) | Open-Core Substrate vs. Industry Adaptation Commercialization | Base Substrate vs. Enterprise Industry Packs, 9 Canonical Pillars | Accepted |
| [ADR 0008](docs/adr/adr_008-virtual-enterprise-agent-hierarchy.md) | Virtual Enterprise Governance, Adversarial Gates & Grounding | Board, Executive, Department Schemas, SSOT Guardrails | Accepted |
| [ADR 0009](docs/adr/adr_009-agent-skills-plugins-vscode-harness.md) | VS Code Agent Host, Extensibility Plugins, and Skill Toolsets | Portable VS Code, Plugin & Skill Routers | Accepted |
| [ADR 0010](docs/adr/adr_010-beam-orchestrator-nomad-scheduler-maas.md) | Distributed BEAM Backplane, Gleam Orchestration, Nomad Scheduling, and MaaS | BEAM/OTP Core, Nomad Scheduler, Pixiecore, Pulumi, catapult addendum | Accepted (Amended) |
| [ADR 0011](docs/adr/adr_011-clause-language-transpiler-agent-directory.md) | Clause Programming Language, Multi-Target Transpiler, and Agent Directory Pattern | Monkey X Transpiler Backend, packages/clause/ (cxc), 9 Pillars | Accepted (Amended 2026-11-20) |
| [ADR 0012](docs/adr/adr_012-ring-rust-in-gleam-bridge.md) | RinG (Rust-in-Gleam) Type-Safe Native Integration Bridge | Schema-Driven FFI, Dirty Scheduler Routing, Typed Actors, cxc synthesis | Accepted (Amended) |
| [ADR 0013](docs/adr/adr_013-curated-domain-slms-vs-saturated-generalists.md) | Curated Domain SLMs vs. Saturated Generalist Models | Contained Task-Specific SLMs, Two-View Strategy, TIGAH branding | Accepted (Amended) |

---

## Active Roadmap & Implementation Milestones

### Active Phase: Document Tree Synchronization & Code Defect Remediation (Current Milestone: `v0.9.0-dev.1`)

* [x] **Batch 1: Architecture Decision Records & Root Ledgers Synchronization**:
  * Restored canonical text of `docs/adr/adr_006-micro-instance-virtualization.md` (`cx vm` WSL2/Lima specification), resolving corruption defect `DEF-02`.
  * Amended `docs/adr/adr_011-clause-language-transpiler-agent-directory.md` to reflect Clause (`.cx`), `cxc` Gleam compiler fork, and the Nine Canonical Operational Pillars.
  * Appended dated implementation evolution addenda to `ADR 010`, `ADR 012`, and `ADR 013`.
  * Updated `README.md` to scrub deleted files (`justfile`, `boot.ps1`), add canonical package trees (`packages/clause`, `clause_jet`, `tigah`), and document the 7-Layer Architecture.
  * Aligned all `TASK.md` ADR markdown hyperlinks with physical on-disk filenames.
  * Populated `mkdocs.yml` navigation structure and `llms.txt` context index.
* [ ] **Batch 3: Physical Code & Configuration Defect Remediation**:
  * Refactor `scripts/cli/nu/config/env.nu` to consume compiled TOML environment variables exported by `cx.ps1` and `cx.sh`, eliminating legacy `.env` reads (`DEF-01`).
  * Prepend `$env:SCOOP\shims` to session `$env:PATH` in `cx.ps1` and export `SCOOP_SHIMS` in `config/env/20-toolchains.toml` (`DEF-08`).
  * Update delegation calls in `scripts/cli/nu/commands/pkg/add.nu` from `scoop` and `brew` to `pkg:scoop` and `pkg:brew`, and add alias fallbacks in `scripts/cli/nu/mod.nu`.
  * Uncomment `./cx.sh test` and `.\cx.ps1 test` in `.github/workflows/ci.yml` so that GitHub Actions actively runs `run_all.nu` (`DEF-03`).
  * Update path assertions in `tests/system/test_stage1.nu` to inspect `$MISE_INSTALLS_DIR` instead of legacy `$CLAUSE_APPS_DIR` (`DEF-04`).
  * Strip literal citation markers from `tests/env/test_env.nu` and `test_env.sh` (`DEF-05`).
  * Mirror `cx.ps1`'s `_CALLER_CLAUSE_STATUS="online"` session preservation guard inside `cx.sh` (`DEF-06`).
  * Update `plugins/cx-comfyui/hooks/post_install.lua` to emit `extra_model_paths.yaml` bound to `$HF_HUB_CACHE` (`DEF-07`).
* [ ] **Batch 2: Supreme Curriculum Specifications Synchronization (`docs/ccefs/00`–`04`)**:
  * Synchronize `00-PROJECT-SPECIFICATION-v3.0.md` to replace `seaxc` with Clause (`.cx`) / `cxc`, add TIGAH, 9 pillars, and `d` (`d01`–`d99`) discussions prefix.
  * Synchronize `01-ccefs-30-modules-v4.3.md` Stage 1 (Modules 1–5) to reflect the `packages/clause/` (`cxc`) Gleam compiler fork and Monkey-X backends.
  * Synchronize `02-stage0-foundation-modules-v4.3.md` Module 0.5 to align `clause-vfs` (`.ground/`) with ClauseOS (`cx`).
  * Synchronize `03-stage1-2-compiler-orchestrator-v4.3.md` Stage 1 & 2 deep-dives to reflect `packages/clause/crates/*` and `crates/clause-pulumi`.
  * Synchronize `04-vieo-ai-curriculum-portal.md` Track 2 syllabus to "Build Claude, OpenClaw & Hermes in Clause (`.cx`) & TIGAH".

### Phase 12: Clause Language Compiler Core (`cxc`), TIGAH & `clause_jet` Runtimes (Stage 1 Master Track)

* [ ] **Compiler Workspace Extraction (`packages/clause/`)**:
  * Fork `gleam-lang/gleam` core into `packages/clause/crates/{clause-core,clause-cli,clause-lsp,clause-wasm,clause-runtime}`.
  * Implement `brand.rs` establishing Clause branding, `.cx` extension, `clause.toml` manifest, and `cxc` binary target.
  * Anchor Cargo build cache to `${CLAUSE_DATA_DIR}/cargo` via `20-toolchains.toml`.
* [ ] **Nine-Pillar Grammar & Type Checking Extensions**:
  * Implement Tier 1 top-level declaration keywords (`kernel`, `service_provider`, `infra`, `provider`, `agent`, `gateway`, `trunk`, `bridge`, `dialplan`, `bus`, `rack`, `patchbay`, `split`, `stage`, `mcr`, `headend`, `airgap`, `sortie`).
  * Add static domain passes: 100% split rights verification, sample-rate matching, and `@airgap` egress checks.
* [ ] **Monkey-X Multi-Target Codegen Engine**:
  * Implement `backend/rust.rs` emitting borrow-checker-safe native Rust crates linked to `oximedia`, `nih-plug`, and `crates/clause-pulumi`.
  * Implement direct crate linking via `@external(rust, ...)` without FFI marshaling overhead.
  * Implement `backend/erlang.rs` lowering agent and telecom declarations into Erlang/OTP 29 supervision trees for `packages/clause_jet/`.
  * Implement automatic `tools/ring` DirtyScheduler NIF synthesis for `@external(rust, ...)` calls targeting `--target beam`.
  * Implement `backend/javascript.rs` emitting client viewports and MVU surfaces for Lustre, Plushie, and Shore.
* [ ] **Directory-Based Agent Execution Model**:
  * Implement self-contained agent directory packaging (`agent.cx`, `team/`, `skills/`, `mcp/`, `clause.toml`).
  * Wire polyglot build commands into the command router (`cx build`, `cx run`).

### Phase 13: Distributed Orchestration, Micro-VMs & Bare-Metal MaaS (Stage 2 Master Track)

* [ ] **BEAM Cluster Orchestrator (`packages/clause_jet/` & `services/orchestrator/`)**:
  * Translate Tim Boring's Cube orchestrator into OTP actors: 5-state Task FSM (`Pending` -> `Scheduled` -> `Running` -> `Completed`/`Failed`).
  * Implement Google Borg E-PVM marginal cost scheduler extended with GPU VRAM/NPU telemetry.
* [ ] **Hermetic Cluster Daemon Anchoring**:
  * Author `ops/config/nomad.hcl` bound to `$CLAUSE_HOME/.local/share/nomad` with `raw_exec` enabled.
  * Author `ops/config/consul.hcl` bound to `$CLAUSE_HOME/.local/share/consul` with UI enabled.
  * Author `ops/config/vault.hcl` bound to `$CLAUSE_HOME/.local/share/vault` with local TCP listener.
* [ ] **Cross-Platform Micro-Instance Virtualization (`cx vm`)**:
  * Build on `installer_wsl.ps1` to manage `.home/AppData/Local/Programs/vms/<name>/ext4.vhdx` with systemd and isolated paths.
  * Build on Lima bootstrap to manage `$LIMA_HOME` bound to `.home/.local/share/vms/`.
  * Wire CLI subcommands (`cx vm {launch, exec, shell, list, stop, purge}`).
* [ ] **Bare Metal as a Service (Pixiecore & Packer)**:
  * Coordinate API-driven iPXE netboots via Pixiecore against Consul inventories.
  * Author Packer templates for memory-resident micro-distros with embedded Stage 0 trampolines.

### Phase 14: Transmedia DSP, Carrier Telecom & Virtual Enterprise Swarms (Stages 3–5)

* [ ] **Transmedia DSP & Hardware Buses**:
  * Wire zero-allocation audio threads (`oximedia`, `nih-plug`) to `bus`, `rack`, and `stem` language primitives.
  * Ingest live NDI, SDI, SMPTE, Dante, AES67, OSC, and MIDI streams.
  * Mount Storytold Craft suites (`vendor/craft/*`) via Git subtrees alongside round-trip OTIO/AAF/FCPXML bridges.
* [ ] **Carrier Softswitch & Media Routing**:
  * Compile `.cx` `target: beam` topologies to Erlang/OTP 29 running Kazoo Class 5 softswitch and Membrane live OTT pipelines.
* [ ] **TIGAH Agent Swarms & Virtual Enterprise Governance**:
  * Scaffold `.enterprise/` (and `.apm/`) board, executive, and departmental hierarchies.
  * Train contained 1B–7B domain SLMs via Unsloth into `$HF_HUB_CACHE` with zero-evasion weights.
  * Enforce adversarial gatekeeper validation (`cx test` exit `0`) unlocking dynamic Vault Git merge tokens.

### Phase 15: Release Promotion & Commercial Fork

* [ ] **Substrate Audit**: Full pass of `run_all.nu` hermeticity and orchestration tests on Windows, Linux, and macOS runners.
* [ ] **Version Promotion**: Promote `.clause.toml` from `v0.9.0-dev.1` to `1.0.0` and cut `v1.0.0` git tag (stripping `-dev` / milestone markers).
* [ ] **Publish Open Core**: Ship the unconstrained Apache 2.0 / MIT substrate.
* [ ] **Fork Commercial Track**: Initialize the enterprise repository for industry-specific compliance packs and connectors (`ADR 0007`).

---

## Immediate Implementation Step

With the project ledger synchronized with `11-git-history` (Commits `559d454d` through `941fc14`) and aligned with the `v0.9.0-dev.1` source bundle, the immediate action is executing **Batch 3 Code Defect Remediation** (`env.nu` TOML hydration, Scoop shims in PATH, `add.nu` delegation fix, and uncommenting CI tests) to flip the governance gate to **FULL PASS** and unblock **Phase 12 (packages/clause/ cxc compiler construction)**.
