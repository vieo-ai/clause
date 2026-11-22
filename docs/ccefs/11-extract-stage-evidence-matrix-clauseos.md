# ClauseOS Extract-Stage Evidence Matrix & Source Register

This document serves as the formal **Extract-Stage Evidence Matrix, Source Paper Cards, and Passage Register** for the **CCEFS: Building ClauseOS** project. It establishes an empirical baseline reconciling the live codebase (`06-clauseos-source-bundle.md`), forensic audit defect reports (`05-source-bundle-audit-report.md`), forensic notes (`n01-scoop-path-audit`), supreme curriculum specifications (`00-PROJECT-SPECIFICATION-v3.0.md` through `04-vieo-ai-curriculum-portal.md`), and the subordinate research corpus (`a` through `t`).

All extractions are governed strictly by the **Hierarchy Supremacy Rule**: physical code in `06-clauseos-source-bundle.md` (v0.9.0-dev.1, 195 tracked files) takes precedence over all other documentation. Specification claims that are unbacked by repository code are marked explicitly as specification drift.

---

## 1. Structured Extraction Schema (CES-10)

To guarantee downstream compiler, runtime, and curriculum usability across all twelve project domains, every source analysis conforms to the unified **ClauseOS Extraction Schema (CES-10)**:

| Field Identifier | Name | Scope and Verification Constraint |
| :--- | :--- | :--- |
| **F-01** | Record Identifier | Canonical tracking key (e.g., `EX-01-SRC-BUNDLE`, `EX-02-CCEFS-SPEC`). |
| **F-02** | Source Reference | Notebook document title, authority stratum, and version hash. |
| **F-03** | Method Class | Empirical implementation, formal specification, or algorithmic proof. |
| **F-04** | Target Runtime | Operating system kernel, hypervisor boundary, or virtual machine stack. |
| **F-05** | Quantitative Measures | Measurable performance indicators (reductions, latency, loudness limits). |
| **F-06** | Grounded Findings | Operational invariants, state representations, and execution primitives. |
| **F-07** | Bounded Limits | Failure modes, anti-patterns, and memory or scheduler ceilings. |
| **F-08** | Visual / Topology | Structural layouts, directory hierarchies, and dispatch graphs. |
| **F-09** | Passage Anchors | Line-level citations mapping claims directly to source contexts. |
| **F-10** | Drift / Defect State | Divergence between written specifications and live codebase reality. |

---

## 2. Authoritative Source Paper Cards

### Source Card 1: Live Implementation Repository (`06-clauseos-source-bundle.md`)

* **Record Identifier:** `EX-01-SRC-BUNDLE`
* **Source Reference:** `06-clauseos-source-bundle.md` (v0.9.0-dev.1, 195 tracked files, generated 2026-11-21) [Stratum 0 / Tier 1 SSOT].
* **Method Class (Task 39):** Multi-stage shell and script orchestration implementing an 8-pass iterative symbol expansion compiler (`${VAR}`) across modular environment manifests (`config/env/*.toml`), defensive multi-pass path splitting across semicolon (`;`) and colon (`:`), in-place runtime binary patching of package managers via marker injection (`# clause-scoop-patches: 1`), and Git subtree squash management.
* **Target Population (Task 40):** Windows NT 10.0+ (x64), Linux (x86_64, aarch64 musl/gnu), and macOS Darwin (x86_64, arm64).
* **Measures and SLOs (Task 41):**
  * Zero-byte modification of host `%USERPROFILE%`, `HKCU:\Environment`, or `~` outside the repository boundary.
  * Sub-millisecond environment compilation across five modular configuration files (`00-core.toml` through `40-ml-hub.toml`).
  * Total state containment within `${CLAUSE_PROJECT_ROOT}/.home/`.
* **Grounded Findings (Task 42):**
  * The hermetic sandbox maps `CLAUSE_DATA_DIR` to `.home/AppData/Local` on Windows NT and `.home/.local/share` on POSIX systems.
  * Package plane isolation in `installer_scoop.ps1` replaces `Set-EnvVar` with an empty function and sets `create_startmenu_shortcut = $false` to eliminate registry pollution.
  * The Nushell control plane prepends `$env:CLAUSE_BIN_DIR` to the session path in `config.nu` and `env.nu`, intercepting system binaries.
* **Limits and Defects (Task 43):**
  * `scripts/cli/nu/config/env.nu` still attempts to read a legacy `.env` file and indexes obsolete `WIN_LOCALAPPDATA` keys, producing errors during clean boot.
  * `docs/adr/adr_006-micro-instance-virtualization.md` contains an accidental duplicate of `ADR 0005` (Model Storage).
  * `.github/workflows/ci.yml` has `./cx.sh test` and `.\cx.ps1 test` commented out, disabling continuous integration verification.
  * `installer_scoop.ps1` omits `$env:SCOOP\shims` from `$env:PATH`, preventing standard CLI execution of Scoop-installed packages.
* **Visual Topology (Task 44):**
  * The root trampolines (`cx.ps1` and `cx.sh`) ingest `config/env/*.toml`, run an 8-pass expansion loop, configure the `.home/` jail, verify the `Set-EnvVar` no-op patch, and launch `scripts/cli/nu/core/boot.nu`.
* **Passage Anchors (Task 45):**
  * `config/env/00-core.toml` (lines 14–48): Directory isolation anchors.
  * `installer_scoop.ps1` (lines 35–85): Scoop registry and shortcut patching.
  * `cx.ps1` (lines 14–80): Iterative symbol expansion algorithm.

### Source Card 2: CCEFS Master Curriculum Specification (`docs/ccefs/00-PROJECT-SPECIFICATION-v3.0.md`)

* **Record Identifier:** `EX-02-CCEFS-SPEC`
* **Source Reference:** `docs/ccefs/00-PROJECT-SPECIFICATION-v3.0.md` (v3.0) [Stratum 2 / Tier 2 SSOT].
* **Method Class (Task 39):** Quad Synthesis Model combining Fowler's *Patterns of Enterprise Application Architecture* (P-EAA), Gang of Four structural patterns, Taylor Otwell's Laravel Illuminate component ergonomics, and Julian Storer's JUCE real-time zero-allocation memory discipline.
* **Target Population (Task 40):** 30 sequential curriculum modules mapping 27 Laravel Illuminate packages directly into Rust systems programming, Erlang/OTP actors, and Clause primitives.
* **Measures and SLOs (Task 41):**
  * Elimination of boilerplate across MCP/A2A JSON-RPC envelopes and WebRTC/SIP streams.
  * Compile-time contract enforcement via two-stage classifiers (AST syntax gate plus local SLM pre-screen) within a 2-second timeout window.
  * Deterministic test gate execution (`cx test` / `cargo test --offline`) returning exit code `0`.
* **Grounded Findings (Task 42):**
  * `illuminate/container` maps to `IContainer` (Module 0) for Inversion of Control auto-wiring without global singletons.
  * `illuminate/pipeline` maps to `IPipeline` (Module 0.1) executing `send().through().then()` middleware over prompts, tool calls, and DSP graphs.
  * `illuminate/filesystem` maps to `ContentAddressedWorkspace` enforcing atomic file writes (`os.rename`) inside `.home/`.
* **Limits and Defects (Task 43):**
  * Refers to the language as `Seax` (`seaxc`) in `compiler/seaxc/` and references an `Air`/`Jet` split, whereas the live architecture has pivoted to `Clause` (`.cx`) and `cxc` forked inside `packages/clause/`.
* **Visual Topology (Task 44):**
  * Fowler P-EAA establishes boundaries (Unit of Work, Separated Interface); Gang of Four supplies mechanics (Strategy, Adapter, Visitor); Laravel provides ergonomics (Fluent Cascades, ServiceProviders); JUCE enforces real-time zero-allocation hotpaths.
* **Passage Anchors (Task 45):**
  * `00-PROJECT-SPECIFICATION-v3.0.md` (§1.3, lines 45–62): Laravel DX and JUCE DSP synthesis.
  * `00-PROJECT-SPECIFICATION-v3.0.md` (§1.5, lines 75–125): 27 Illuminate packages mapped to ClauseOS primitives.

### Source Card 3: Gleam Compiler & Multi-Target Transpiler Blueprint (`docs/ccefs/06-blueprint`)

* **Record Identifier:** `EX-03-CXC-BLUEPRINT`
* **Source Reference:** `docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md` / `d48-gleam-to-clause-forking` [Stratum 2 / Tier 2 SSOT].
* **Method Class (Task 39):** Direct fork of `gleam-lang/gleam` inside `packages/clause/` emitting the `cxc` CLI binary, preserving the Hindley-Milner type inference engine and decoupling code emission via pluggable backends (`Target::Rust`, `Target::Beam`, `Target::Client`) modeled after Mark Sibley's Monkey-X `transcc`.
* **Target Population (Task 40):** Multi-target code generation targeting native Rust (`cargo build`), distributed Erlang/OTP (`.beam`), and client-side ECMAScript/WebAssembly (`Lustre`, `Plushie`, `Shore`, `O2K`).
* **Measures and SLOs (Task 41):**
  * Direct zero-cost crate linking via `@external(rust, ...)` without FFI boundary marshaling overhead on `--target rust`.
  * Automatic synthesis of dirty-scheduler NIFs (`tools/ring/`, `ADR 0012`) when `@external(rust, ...)` is compiled for `--target beam`.
  * Prevention of scheduler starvation by isolating compute-heavy DSP into Erlang `DirtyCpu` / `DirtyIo` threads.
* **Grounded Findings (Task 42):**
  * Language grammar is partitioned into **Three Syntactic Tiers**:
    1. *Tier 1 (Top-Level Declarations):* `kernel`, `service_provider`, `infra`, `provider`, `agent`, `gateway`, `trunk`, `bridge`, `dialplan`, `bus`, `rack`, `patchbay`, `split`, `stage`, `mcr`, `headend`, `airgap`, `sortie`.
    2. *Tier 2 (Contextual Clauses and Attributes):* `@hangar`, `@airgap`, `@needs`, `@squawk`, `stem`, `take`, `slate`, `reel`, `grade`, `scram`.
    3. *Tier 3 (Standard Library Namespaces):* `clause/kernel`, `clause/app`, `clause/infra`, `clause/comms`, `clause/studio`, `clause/stage`, `clause/stream`, `clause/tactical`, `clause/tigah`.
* **Limits and Defects (Task 43):**
  * Core language grammar strictly quarantines generic consumer/commercial verticals (healthcare, retail POS, banking) per `ADR 0007` to maintain carrier domain purity.
* **Visual Topology (Task 44):**
  * `.cx` source files enter the `cxc` front-end (Logos scanner, Pratt parser, Hindley-Milner typing) and branch into `Target::Rust` (native DSP, `oximedia`), `Target::Beam` (Kazoo Class 5 softswitch, Membrane), and `Target::Client` (Lustre, Plushie).
* **Passage Anchors (Task 45):**
  * `docs/ccefs/06-blueprint` (§1.2, lines 15–35): Multi-target compiler decoupling.
  * `docs/ccefs/06-blueprint` (§3.1, lines 60–110): 9 Canonical Operational Pillars and 3-Tier Grammar.

### Source Card 4: Curated Domain SLMs vs. Saturated Generalists (`docs/adr/adr_013`)

* **Record Identifier:** `EX-04-ADR-013-SLM`
* **Source Reference:** `docs/adr/adr_013-curated-domain-slms-vs-saturated-generalists.md` [Stratum 2 / Tier 2 SSOT].
* **Method Class (Task 39):** Two-View Architectural Model separating unconstrained human-facing conversational steering (The Reservoir) from deterministic, task-specific worker execution (The Cup) utilizing 1B–7B local SLMs fine-tuned via `Unsloth` on `$HF_HOME`.
* **Target Population (Task 40):** TIGAH domain SLM family: `tigah-coder`, `tigah-instruct`, `tigah-audio`, `tigah-midi`, `tigah-vision`.
* **Measures and SLOs (Task 41):**
  * Sub-50ms inference latency for local CLI command loops.
  * Complete elimination of evasion vectors and narrative excuses by stripping conversational prose from fine-tuning corpora.
  * Binary exit code verification: worker models execute schema contracts, run local test gates (`cx test`), return `$?`, and terminate.
* **Grounded Findings (Task 42):**
  * Generalist frontier models (70B–400B+) suffer from information saturation, introducing latent representations of sycophancy, conflicting framework dialects, and hallucinated flags.
  * Contained worker SLMs operate exclusively on domain-restricted weight spaces saturated with canonical ground-truth ADRs, AST schemas, and test vectors.
* **Limits and Defects (Task 43):**
  * Requires maintaining local distillation datasets as repository contracts evolve.
* **Visual Topology (Task 44):**
  * View 1 (Conversational Steering) handles intent elicitation and schema generation without direct repository write access. View 2 (Contained Operational Workers) executes code, runs `cx test`, asserts `$? == 0`, and exits.
* **Passage Anchors (Task 45):**
  * `docs/adr/adr_013` (lines 12–45): The Cup vs. The Reservoir architectural duality.
  * `config/env/40-ml-hub.toml` (lines 1–25): `$HF_HOME` and model cache anchors.

### Source Card 5: Forensic Scoop Installation and PATH Audit (`n01-scoop-path-audit`)

* **Record Identifier:** `EX-05-NOTE-SCOOP`
* **Source Reference:** `n01-scoop-path-audit` (Forensic Audit Note) [Stratum 1 / Tier 1 Forensic Overlay].
* **Method Class (Task 39):** Static code audit and physical path inspection of `installer_scoop.ps1`, `scripts/cli/nu/commands/pkg/scoop.nu`, and `config/env/*.toml`.
* **Target Population (Task 40):** Windows NT execution environment utilizing Scoop for package management.
* **Measures and SLOs (Task 41):**
  * Zero host registry writes to `HKCU:\Environment`.
  * Deterministic execution of Scoop-installed binaries via session `$env:PATH`.
* **Grounded Findings (Task 42):**
  * `installer_scoop.ps1` patches `Set-EnvVar` to an empty function body and disables Start Menu shortcut creation, successfully preventing registry contamination.
  * Scoop installs application shims into `$env:SCOOP\shims`, where `$env:SCOOP` defaults to `$env:CLAUSE_DATA_DIR/toolchain/scoop`.
* **Limits and Defects (Task 43):**
  * Neither `cx.ps1` nor `config/env/20-toolchains.toml` exposes `$env:SCOOP\shims` on `$env:PATH`.
  * `scripts/cli/nu/commands/pkg/scoop.nu` only parses `env_add_path` from package manifests and completely ignores the `"bin"` property, preventing 95% of installed tools from being discovered or executed.
* **Visual Topology (Task 44):**
  * Scoop installs binaries to `$env:SCOOP/apps/<pkg>/current/` and writes proxy executables to `$env:SCOOP/shims`. Because this path is omitted from Nushell's `$env:PATH`, tools are installed but unreachable from the shell prompt.
* **Passage Anchors (Task 45):**
  * `n01-scoop-path-audit` (§1): Core audit finding on PATH omission.
  * `n01-scoop-path-audit` (§2.C): Forensic analysis of missing shim exports in `cx.ps1`.

---

## 3. Cross-Domain Evidence Matrix

The matrix below synthesizes extracted methods, platforms, quantitative measures, findings, and limits across all major subsystems:

| Subsystem and Pillar | Extraction Key | Primary Source Reference | Implementation Methodology | Platform and Runtime | Quantitative Measure and SLO | Grounded Finding and Invariant | Observed Limit or Spec Drift |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Hermetic Substrate** (`kernel`) | `EX-01` | `06-bundle` / `02-stage0` | 8-pass TOML compiler (`config/env/*.toml`), `.home/` jail, path splitting. | Windows NT, Linux, macOS. | 0 host bytes modified; 100% confined to `.home/`. | `CLAUSE_DATA_DIR` isolates userland; `USERPROFILE` overridden. | `env.nu` still reads legacy `.env`. |
| **Package Management** (`infra`) | `EX-02` | `06-bundle` / `n01-note` | In-place code patching (`# clause-scoop-patches: 1`), no-op `Set-EnvVar`. | Windows NT, POSIX. | 0 HKCU registry writes; 0 Start Menu `.lnk` files. | `installer_scoop.ps1` prevents registry pollution. | `$SCOOP/shims` missing from PATH. |
| **Compiler Core** (`deck`) | `EX-03` | `docs/ccefs/06` / `d48` | Gleam fork in `packages/clause/`, Monkey-X multi-target emitters. | Rust, BEAM, WebAssembly. | Zero-cost direct crate imports (`@external(rust, ...)`). | 9 Canonical Pillars split into 3-tier grammar. | Specs `00`–`03` still reference `seaxc`. |
| **Native Systems & DSP** (`studio`) | `EX-04` | `01-modules` / `ADR 012` | Native Rust lowered to lock-free ring buffers (`oximedia`, `nih-plug`). | AMD APU, x86_64, Apple Silicon. | Zero heap allocation on real-time audio threads. | High-throughput DSP bypasses BEAM garbage collection. | Requires `tools/ring` NIF synthesis. |
| **Carrier Switchboard** (`comms`) | `EX-05` | `01-modules` / `d43` | Erlang/OTP 29 supervision trees, Kazoo Class 5 softswitch, Kamailio. | Distributed BEAM cluster. | 99.999% uptime; 2,000-reduction preemptive turns. | Declarative `trunk`, `bridge`, `dialplan` primitives. | Softswitch clustering unseeded in `06`. |
| **IaC Cloud Engine** (`infra`) | `EX-06` | `01-modules` / `ADR 010` | Revived `pulumi-gestalt` (`crates/clause-pulumi`) compiled from `infra`. | Multi-Cloud, Bare-Metal. | YAML-free, typed dependency graphs (`Output<T>`). | Programmatic cloud bursting (`catapult`) and detach. | `crates/clause-pulumi` unmerged in `06`. |
| **Domain Neural Hub** (`tigah`) | `EX-07` | `ADR 013` / `40-ml-hub` | Unified model cache (`$HF_HOME`), 1B–7B SLMs fine-tuned via `Unsloth`. | Vulkan, ROCm, CUDA, DirectML. | Sub-50ms CLI turn latency; zero duplicate weights. | `extra_model_paths.yaml` bridges ComfyUI to `$HF_HOME`. | Post-install hook missing YAML bridge. |

---

## 4. Diagrammatic & Topological Extractions

### 4.1 Physical Userland Confinement Hierarchy

The layout below documents the exact filesystem jail established by `cx.bat`, `cx.ps1`, `cx.sh`, and `config/env/00-core.toml` through `40-ml-hub.toml`:

* **`${CLAUSE_PROJECT_ROOT}/`**
  * **`.home/`** (Host Isolation Jail)
    * **`AppData/Local/`** (Windows NT Known Folder Redirection)
      * **`Programs/bin/`** (`$env:CLAUSE_BIN_DIR` hosting Nushell, Mise, cxc)
      * **`Programs/apps/`** (Isolated runtime engines)
      * **`Programs/logs/`** (Bootstrap and execution logs)
      * **`cache/huggingface/`** (`$HF_HOME` shared neural weights)
      * **`cache/toolchain/scoop/`** (Confined Scoop installation and shims)
    * **`.local/`** (POSIX XDG Redirection)
      * **`bin/`** (`$CLAUSE_BIN_DIR`)
      * **`share/mise/installs/`** (`$MISE_INSTALLS_DIR` hosting Erlang, Elixir, Gleam)
      * **`share/models/`** (Shared Hugging Face cache on POSIX)
  * **`config/env/`** (Declarative Environment SSOT)
    * **`00-core.toml`** (Base paths, identity redirection, provisioning)
    * **`10-identity.toml`** (Git, SSH, and GitHub CLI identity containment)
    * **`20-toolchains.toml`** (Mise, Scoop, and Homebrew paths and shims)
    * **`30-shell.toml`** (Nushell initialization and prompt configuration)
    * **`40-ml-hub.toml`** (Model caches: `HF_HOME`, `TORCH_HOME`)
  * **`packages/`** (Core Monorepo Modules)
    * **`clause/`** (`cxc` multi-target compiler forked from Gleam core)
    * **`clause_jet/`** (Erlang/OTP agent supervision engine)
  * **`cx.ps1` / `cx.sh`** (Stage 0 Microkernel Bootloaders)

### 4.2 Dual-Plane Execution and Compilation Dispatch

The operational flow below charts how `cxc` separates declarative control logic from high-throughput data pipelines:

1. **Source Input:** Developer authors `.cx` source files containing domain declarations (`kernel`, `trunk`, `bus`, `agent`).
2. **Compiler Front-End (`cxc`):** Logos lexer tokenizes source; Pratt parser constructs the AST; Hindley-Milner type system infers schemas.
3. **Target Dispatch:**
   * **`Target::Rust` (Data Plane):** Emits native Rust linking `oximedia`, `nih-plug`, and `clause-pulumi`. Enforces zero heap allocations on real-time threads.
   * **`Target::Beam` (Control Plane):** Emits Erlang/OTP modules targeting OTP 29. Dispatches signaling to Kazoo softswitch and actor supervisors to `clause_jet`.
   * **`Target::Client` (Flight Deck):** Emits client modules for Lustre (Web), Plushie (Desktop), and Shore (TUI).
4. **Inter-Plane Bridge (`tools/ring`):** High-throughput data calls between BEAM actors and native Rust kernels route through Erlang Dirty Schedulers (`DirtyCpu` / `DirtyIo`), avoiding garbage-collection pauses.

---

## 5. Comprehensive Passage Register

The register below anchors every architectural invariant to its exact physical source location across the notebook corpus:

| Passage Identifier | Canonical Source Document | Source Location | Grounded Invariant or Technical Evidence |
| :--- | :--- | :--- | :--- |
| **`PAS-01`** | `00-PROJECT-SPECIFICATION-v3.0.md` | §1.3 (lines 45–62) | Laravel DX and JUCE real-time zero-allocation DSP synthesis. |
| **`PAS-02`** | `00-PROJECT-SPECIFICATION-v3.0.md` | §1.4 (lines 65–70) | Target Synthesis Formula: P-EAA + GoF + Laravel + JUCE. |
| **`PAS-03`** | `00-PROJECT-SPECIFICATION-v3.0.md` | §1.5 (lines 75–125) | 27 Illuminate packages mapped to ClauseOS and BEAM primitives. |
| **`PAS-04`** | `01-ccefs-30-modules-v4.3.md` | Stage 1 (lines 80–120) | Pratt parser, AST macros, bytecode VM, and Monkey-X emitters. |
| **`PAS-05`** | `02-stage0-foundation-modules-v4.3.md` | Module 0.2 (lines 40–95) | Scoop in-place sterilization (`# clause-scoop-patches: 1`). |
| **`PAS-06`** | `05-source-bundle-audit-report.md` | §1.0 (lines 10–35) | Audit of 177 files confirming seven critical internal defects. |
| **`PAS-07`** | `05-source-bundle-audit-report.md` | §2.0 Finding 1 (lines 40–55) | `scripts/cli/nu/config/env.nu` reading retired `.env` file. |
| **`PAS-08`** | `05-source-bundle-audit-report.md` | §2.0 Finding 2 (lines 60–75) | `adr_006` duplicate body corruption requiring restoration. |
| **`PAS-09`** | `06-clauseos-source-bundle.md` | `config/env/00-core.toml` | Root anchors: `CLAUSE_DATA_DIR`, `CLAUSE_HOME`, `USERPROFILE`. |
| **`PAS-10`** | `06-clauseos-source-bundle.md` | `config/env/20-toolchains.toml`| Toolchain paths: `MISE_DATA_DIR`, `SCOOP`, `HOMEBREW_PREFIX`. |
| **`PAS-11`** | `06-clauseos-source-bundle.md` | `config/env/30-shell.toml` | Nushell environment: `NU_CONFIG_DIR`, `CLAUSE_BOOT_NU`. |
| **`PAS-12`** | `06-clauseos-source-bundle.md` | `docs/adr/adr_004...md` | Cross-shell canonicalization and 8-pass TOML compiler addendum. |
| **`PAS-13`** | `06-clauseos-source-bundle.md` | `docs/adr/adr_006...md` | ADR 005 body duplicated under `adr_006` filename in codebase. |
| **`PAS-14`** | `06-clauseos-source-bundle.md` | `docs/adr/adr_008...md` | Closed-world `.ground` SSOT and mechanical gatekeeper contracts. |
| **`PAS-15`** | `06-clauseos-source-bundle.md` | `docs/adr/adr_010...md` | BEAM backplane, Nomad scheduler, and Pixiecore MaaS. |
| **`PAS-16`** | `06-clauseos-source-bundle.md` | `docs/adr/adr_011...md` | Directory-based agent pattern and Seax/Air/Jet runtime split. |
| **`PAS-17`** | `06-clauseos-source-bundle.md` | `docs/adr/adr_012...md` | RinG bridge: Dirty-scheduler NIF routing for zero-allocation Rust. |
| **`PAS-18`** | `06-clauseos-source-bundle.md` | `docs/adr/adr_013...md` | Curated 1B–7B domain SLMs vs. saturated generalist models. |
| **`PAS-19`** | `06-clauseos-source-bundle.md` | `docs/ccefs/07-sync-plan` | Master document drift synchronization map and 3-batch plan. |
| **`PAS-20`** | `06-clauseos-source-bundle.md` | `scripts/cli/nu/.../scoop.nu` | Hijacked Scoop command and manifest parsing logic. |
| **`PAS-21`** | `06-clauseos-source-bundle.md` | `scripts/cli/nu/.../env.nu` | Defect location: parsing legacy `.env` file instead of TOML. |
| **`PAS-22`** | `06-clauseos-source-bundle.md` | `.../installer_scoop.ps1` | Implementation of `Set-EnvVar` no-op override and registry snapshot. |
| **`PAS-23`** | `06-clauseos-source-bundle.md` | `tests/env/test_env.nu` | Defect location: literal citation strings breaking execution. |
| **`PAS-24`** | `06-clauseos-source-bundle.md` | `tests/system/test_stage0.nu` | Stage 0 assertions verifying `mise` and `nu` binaries. |
| **`PAS-25`** | `n01-scoop-path-audit` | Note Section 1 | Forensic verdict: Scoop apps are not reachable on session PATH. |
| **`PAS-26`** | `n01-scoop-path-audit` | Note Section 2.C | Proof that `$env:SCOOP\shims` is omitted from `cx.ps1` and TOML. |

---

## 6. Extraction Quality Gate & Release Conditions

The extractions compiled in this document provide an unbroken chain of custody between written curriculum modules, architecture records, and the physical code snapshot. 

Advancing from the **Extract Stage** into downstream compiler compilation and runtime assembly requires satisfying two final conditions:
1. **Defect Remediation (Batch 3):** The eight implementation bugs identified in Source Cards 1 and 5 must be patched in the physical files.
2. **Specification Synchronization (Batch 2):** Curriculum documents `00-PROJECT-SPECIFICATION-v3.0.md` through `04-vieo-ai-curriculum-portal.md` must be updated to replace obsolete `seaxc` references with the `cxc` Gleam compiler fork.
