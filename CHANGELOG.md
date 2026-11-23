# ClauseOS Changelog

All notable changes to the **ClauseOS** (`clause` / `cx`) substrate, toolchain supply chain, compiler blueprints, and governance specifications are documented in this ledger.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and tracks chronological development from initial commit `559d454` (`2026-10-19`) through `941fc14` (`2026-11-22`).

---

## [v0.9.0-dev.1] — Platform Integration, Compiler Pivot & Research Governance (`2026-11-16` – `2026-11-22`)

### ✨ New Features

* **First-Party `cx-*` Toolchain Plugin Standardization**: Renamed and standardized all local AI and runtime Mise plugins from `mise-*` to `cx-*` (`plugins/cx-comfyui`, `plugins/cx-fastflowlm`, `plugins/cx-inferssd`, `plugins/cx-lemonade`, `plugins/cx-unsloth`, `plugins/cx-vscode`) to prevent upstream Mise registry collisions and align with the `cx` CLI namespace (`6435a07`, `048d39e`, `cdfd244`, `4579825`, `1b60551`).
* **Cross-Platform Micro-Virtualization (`cx-multipass`)**: Mounted `plugins/cx-multipass` (`vieo-ai/cx-multipass` @ `fdf3db8`) as a Git subtree to orchestrate isolated Linux micro-VMs across Windows, macOS, and Linux (`7028e06`, `61970fb`).
* **Clause (`.cx`) & `cxc` Gleam Fork Blueprint**: Published `docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md` (`4ba1a51`) and `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md` (`1698aef`), codifying the fork of `gleam-lang/gleam` inside `packages/clause/` (`cxc`) with Monkey-X multi-target emitters (`--target rust`, `--target beam`, `--target client`), `clause_jet` OTP mission control, `TIGAH` domain SLMs, and the Nine Canonical Operational Pillars.
* **CCEFS 30-Module Master Curriculum Suite (`v4.3`)**: Authored and structured the sequential specification suite in `docs/ccefs/` (`00-PROJECT-SPECIFICATION-v3.0.md`, `01-ccefs-30-modules-v4.3.md`, `02-stage0-foundation-modules-v4.3.md`, `03-stage1-2-compiler-orchestrator-v4.3.md`, and `04-vieo-ai-curriculum-portal.md`) (`f288705` – `ff20149`).
* **Seven-Stage Research & Verification Governance Architecture**: Added `docs/ccefs/08-frame-stage` through `14-cite-stage` (`4b20313` – `3693926`, refined in `83130c3` – `d120f06`) to enforce claim-to-citation fit, physical path verification, and release gate checkpoints.
* **Forensic Audits & Totality Evaluation**: Published `05-source-bundle-audit-report.md` (`7fa82f1`), `15-investigation-report-cx-pkg-refactor-clauseos.md` (`47a42ca`), `16-documentation-audit-and-alignment-clauseos.md` (`3ec4542`), and `17-totality-project-evaluation-clauseos.md` (`941fc14`).
* **Source Bundle & PDF Exporter**: Implemented automated Markdown and PDF repository bundle generation (`18c318e`).

### 🔧 Improvements

* **ADR Implementation Addenda**: Amended `ADR 002` (`181da03`, `9c1a0e2`), `ADR 004` (`86cf83b`), and `ADR 011` (`1c32679`) to reflect the three-tier orchestration model and modular TOML environment engine.
* **Root Ledger & Documentation Streamlining**: Updated `TASK.md` (`5d2d9bd`) and `README.md` (`aae107e`) for `v0.9.0-dev.1`, and removed unused `material` directory and legacy MkDocs configuration (`c4f101b`).

### 🛡️ Security & Hermeticity

* **Git Identity & `.home` Hygiene**: Scrubbed personal Git identity details in `.gitconfig` (`8ba0681`), removed tracked `.home/.gitconfig` (`4bbc10b`, `06c2481`), and added `.ground` to `.gitignore` (`ce34294`).

---

## [v0.8.0-dev.1 – v0.8.0-dev.10] — Declarative TOML Engine, Polyglot Package Plane & AI Supply Chain (`2026-10-29` – `2026-11-15`)

### ✨ New Features

* **Declarative Modular TOML Environment Compiler (`config/env/*.toml`)**: Introduced five lexical environment modules (`00-core.toml`, `10-identity.toml`, `20-toolchains.toml`, `30-shell.toml`, `40-ml-hub.toml`) (`803b5b4` – `4e34401`, `9e1673d` – `3726286`) compiled via 8-pass iterative `${VAR}` symbol expansion inside `cx.ps1` and `cx.sh` (`6b3e6f7`, `a0994de`).
* **Unified Polyglot Package Control Plane (`cx pkg:*`)**: Implemented `cx pkg`, `cx pkg:add`, `cx pkg:mise`, `cx pkg:scoop`, and `cx pkg:brew` (`4134fc8`, `c924e05`, `9e28c93`, `eec1a34`, `b36ea14`, `5eef32e`, `9db925e`) backed by `scripts/cli/nu/core/toml_pin.nu` (`6a33fe5`) to automatically pin resolved package versions into `.mise.<env>.toml`.
* **Layered `MISE_ENV` Overlays**: Partitioned toolchains across `.mise.paths.toml` (`ebf50f4`), `.mise.ai.toml` (`4423b86`), and `.mise.cloud.toml` (`808f2e8`) with default `MISE_ENV="paths,ai,cloud"` (`d82553e`), hydrating HashiStack (`nomad`, `consul`, `vault`, `boundary`, `pulumi`, `packer`) and BEAM/Gleam (`erlang`, `elixir`, `gleam`, `rebar`) runtimes (`627be10`, `c3a7c96`).
* **First-Party Lua AI & Dev Toolchain Plugins**: Mounted and verified six Git subtree plugins across Windows, Linux, and macOS CI:
  * `lemonade` (`06f59fe`, `0dc2eec` – `38a8921`, `fa3af85`)
  * `fastflowlm` (`2e41ea9`, `c745559` – `395ba68`, `d69b898`)
  * `vscode` / `code` (`f35794d`, `b4a5c92` – `bc06eb1`)
  * `unsloth` (`b9b32f0`, `d17df50` – `efebceb`)
  * `comfyui` (`0fd9557`, `5c3ef1a` – `ad4b43f`)
  * `inferssd@v0.1.4` (`ad11635`, `c29d666` – `2a8cc8b`)
* **Git Subtree Plugin Synchronizer (`cx plugin`)**: Added `scripts/cli/nu/commands/plugin.nu` (`add`, `pull`, `push`) with upstream `git ls-remote` commit provenance (`87d49f5` – `eb6c74f`).
* **Hermetic Drop-In Installers & Virtualization Bootstraps**: Created modular installers for `mise` (`4bc72c2`), `nu` (`63c1ea6`), confined Homebrew (`d553c44`), sterilized Scoop (`750ca19`), WSL2 (`dbd1af4`), and Lima (`c8434b9`, `41c0f15`).

### 🔧 Improvements

* **Windows Rebar3 Launcher & Engine Health Probes**: Added automated `rebar3.cmd` launcher generation (`aebb793`) and direct filesystem probes verifying required engines in `MISE_INSTALLS_DIR` (`874c5aa` – `7e45ac3`).
* **Cross-Platform Environment Scrubbing**: Added scrubbing of Windows NT keys in POSIX/Nushell (`8d63469`, `8c81493`) and POSIX XDG keys in Windows runtimes (`b4b5d40`).

### 🛡️ Security & Hermeticity

* **In-Place Scoop Sterilization**: Patched Scoop core scripts (`lib/core.ps1`, `lib/shortcuts.ps1`, `lib/system.ps1`, `libexec/scoop-import.ps1` marked `# clause-scoop-patches: 1`) during installation (`14c1073`, `87346e0`) to prevent host registry (`HKCU:\Environment`) mutations and Start Menu shortcuts.
* **Host Hygiene Redlines & Subshell Guards**: Enforced Stage 0 preflight checks blocking unmanaged host `mise`, `scoop`, and `brew` installations (`fdfcdac`, `83962fd`, `7a3789f`) and implemented `CLAUSE_STATUS="online"` caller status preservation in `cx.ps1` (`134373e`).
* **Hermetic Git & SSH Confinement**: Locked `GIT_CONFIG_GLOBAL`, `GH_CONFIG_DIR`, and `GIT_SSH_COMMAND` inside `.home/` (`c2d1dd4`, `3b8f64a`, `d319d0b`, `57382b2`).

### 💥 Breaking Changes & Cleanup

* **Consolidated Stage 0 Entrypoints**: Merged microkernel boot logic directly into `cx.ps1` and `cx.sh` (`0f74e6e`, `f55f81b`) and deleted standalone `boot.ps1` (`dafcd96`).
* **Retired `justfile` and Legacy Env Scripts**: Removed `justfile` (`d41253b`) in favor of the `cx` Nushell router, and deleted deprecated `env.ps1`, `env.sh` (`900356c`), and `.env.example` (`5247456`).

---

## [v0.1.0-milestone.1 – v0.1.0-milestone.7] — Bare-Metal Substrate Inception (`2026-10-19` – `2026-10-28`)

### ✨ New Features

* **Workspace Inception & Zero-Leak `.home/` Sandbox**: Initialized repository (`559d454`), core manifests (`fb3ac8b` – `adfc872`), Apache 2.0 License (`202cbb1`), and strict `.home/` redirection for Windows Known Folders (`AppData\Local`, `AppData\Roaming`) and POSIX XDG directories (`.local`, `.config`, `.cache`) (`90843fc`, `d25d29b`, `6ddde49`).
* **Universal `cx` CLI Entrypoints**: Standardized top-level entrypoints to `cx.bat`, `cx.ps1`, and `cx.sh` (`658b125`, `b6d2012`, `1f523da`) with dynamic Nushell Mise activation overlay generation (`87ca9f1`).
* **System Verification & Hermeticity Suite (`cx test`)**: Implemented `tests/system/run_all.nu`, `test_stage0.nu`, `test_stage1.nu`, and `test_hermeticity.nu` (`638eab2` – `849ae19`), alongside cross-shell environment tests (`ba11244` – `55692e5`).
* **Two-Tier `renv` Runtime Split & 5-Way Hardware Acceleration Matrix**: Added standalone `uv` (`6a44100`), Pulumi bootstrap (`876a9f3`), and isolated application recipes (`3880837`) with 5-way GPU/CPU probing (CUDA, ROCm, Intel XPU, Apple Metal, and macOS Intel CPU fallback) for Unsloth (`d42e0b4`) and ComfyUI (`9db433a`, `d452e80`).
* **Architecture Decision Records (`ADR 0001` – `ADR 0013`)**: Authored initial ADRs codifying hermetic confinement, toolchain orchestration, hardware acceleration, cross-shell PATH canonicalization, unified model storage, micro-virtualization, open-core boundaries, virtual enterprise governance, BEAM orchestration, Seax transpilation, RinG FFI, and curated domain SLMs (`853f2c3` – `126bab5`).

### 🐛 Fixes

* **Cross-Shell PATH Delimiters & macOS Symlink Canonicalization**: Resolved `;` vs. `:` PATH delimiter mismatches across `boot.ps1` and Nushell (`a9f80ea` – `c4b2b39`), normalized macOS `/var` vs. `/private/var` temp paths (`0ee8608`, `501bafd`), and switched `config.nu` to static parse-time `./mise.nu` loading (`3f58838`).
* **Cache & Temp Directory Hardening**: Guaranteed deterministic provisioning of `CLAUSE_CACHE_DIR`, `CLAUSE_TEMP_DIR`, and `CLAUSE_BIN_DIR` on boot (`09a4dd3` – `e6e0e0e`).