# Documentation Audit, Synchronization Ledger & Scope Alignment Report

**Artifact Designation:** `docs/ccefs/16-documentation-audit-and-alignment-clauseos.md`  
**Classification:** Track 1 CCEFS Foundation Specification & Documentation Audit Ledger  
**Governance Hierarchy:** Supreme Single Source of Truth (SSOT) Protocol (`06` $\\rightarrow$ `05` $\\rightarrow$ `00`–`04` $\\rightarrow$ `a`–`t`)  
**Analytical Perspective:** Principal Systems Architect / PhD Curriculum Fellow (Quad Synthesis: *Fowler P-EAA* + *Gang of Four* + *Otwell/Laravel DX* + *Storer Real-Time Zero-Allocation Audio/Video DSP*)

---

## 1. Executive Framing & Constitutional Governance

Following the compilation of the foundation research and verification artifacts, this audit performs a forensic examination of the entire documentation corpus preserved within `06-clauseos-source-bundle.md` (version v0.9.0-dev.1, tracking 195 files). The objective is to verify whether all tracked documentation—spanning Architecture Decision Records (`docs/adr/`), root operational ledgers (`README.md`, `TASK.md`), master curriculum specifications (`docs/ccefs/00` through `04`), and ancillary directory guides—remains aligned with the current, authoritative scope of the project.

The ClauseOS engineering initiative is governed by a strict two-tier Supreme Single Source of Truth (SSOT) protocol:

1. **Tier 1 (Live Implementation Reality):** The physical source code snapshot in `06-clauseos-source-bundle.md` along with the forensic audit reports (`05-source-bundle-audit-report.md`, `n01-scoop-path-audit`, and `15-investigation-report-cx-pkg-refactor-clauseos.md`) represents the unconditional ground-truth reality of the repository. In any instance where specifications, ADRs, or research documents describe capabilities, paths, or architectures not reflected in the live codebase, the physical code wins unconditionally.
2. **Tier 2 (Architectural & Curriculum Specifications):** The formal specifications in `docs/ccefs/00-PROJECT-SPECIFICATION-v3.0.md` through `04-vieo-ai-curriculum-portal.md`, together with the canonical ADR ledger (`adr_001` through `adr_013`), govern systemic design rules, track syllabi, and architectural invariants.

To maintain engineering discipline and prevent architectural drift, the system operational identity and scope are anchored to five core pillars:

* **Parent Steward:** **Vieo** (`vieo-ai`) operates as the sovereign enterprise steward and commercial custodian.
* **Operating Substrate:** **ClauseOS** (`clause.os` / `cx`) provides the bare-metal, zero-leak hermetic userland (`.home/` jail, 8-pass iterative TOML SSOT engine, and `cx pkg:*` package control plane).
* **Programming Language & Compiler:** **Clause** (`.cx`), compiled via the **`cxc`** CLI binary constructed by forking `gleam-lang/gleam` inside `packages/clause/` with Mark Sibley Monkey-X multi-target emitters (`--target rust`, `--target beam`, `--target client`).
* **Mission Control & Distributed Control Plane:** **`clause_jet`** (`packages/clause_jet/`), compiling to Erlang/OTP 29 on the BEAM virtual machine.
* **Neural Coprocessor Tier:** **TIGAH** (*Transmedia Intelligent Generative Autonomous Hermetic*), operating curated local 1B–7B domain SLMs (`tigah-coder`, `tigah-instruct`, `tigah-audio`, `tigah-midi`, `tigah-vision`) anchored in the shared `$HF_HOME` cache.
* **Domain Purity Boundary (`ADR 0007`):** The standard library (`stdlib/clause/`) and language grammar are strictly confined to the **Nine Canonical Operational Pillars** (`kernel`, `app`, `infra`, `deck`, `comms`, `studio`, `stage`, `stream`, and `tactical`/`tigah`). Generic commercial SaaS, healthcare, and retail business verticals are quarantined to optional downstream `.enterprise/` or `.apm/` cartridges.

The audit evaluates every document in the repository against these invariants, classifying findings into verified alignment, active documentation corruption, or specification drift.

---

## 2. Master ADR Ledger Audit (`docs/adr/`)

The 13 Architecture Decision Records tracked in `06-clauseos-source-bundle.md` represent the binding structural contracts of the platform. Each ADR was audited against the live codebase and current project architecture.

| ADR Identifier | Tracked Title in Bundle 06 | Current Alignment Status | Evidentiary Finding & Required Action |
| :--- | :--- | :--- | :--- |
| **ADR 0001** | Hermetic State Confinement and Canonical Directory Hierarchy | **ALIGNED** | Accurately defines `.home/` sandboxing, Windows Known Folder redirection, and POSIX XDG base anchors. Fully verified in `config/env/00-core.toml` and `cx.ps1`. |
| **ADR 0002** | Two-Tier Toolchain Orchestration (`mise` + `renv`) | **ALIGNED** | Contains the November 15, 2026 addendum codifying the promotion of `renv` recipes into first-party Lua plugins under `plugins/cx-*` and the 3-tier supply chain. |
| **ADR 0003** | Dynamic Multi-Vendor Hardware Acceleration Matrix | **ALIGNED** | Accurately governs 5-way GPU/NPU probes across AMD APU/ROCm, Apple Metal, Intel oneAPI, and DirectML. Implemented in `plugins/cx-*`. |
| **ADR 0004** | Cross-Shell Environment and PATH Delimiter Canonicalization | **ALIGNED** | Contains the November 15, 2026 addendum codifying the 8-pass iterative `${VAR}` symbol expansion engine across `config/env/*.toml`. |
| **ADR 0005** | Unified Model Storage & Ecosystem Cache Projection | **PARTIALLY ALIGNED** | Correctly establishes `$HF_HOME` centralization, but lacks cross-referencing to the Lua plugin hook `extra_model_paths.yaml` required for ComfyUI. |
| **ADR 0006** | Cross-Platform Micro-Instance Virtualization (`cx vm`) | **CORRUPTED (DEF-02)** | **CRITICAL DEFECT:** The file body in `06` is an accidental byte-for-byte duplicate of ADR 005 (Model Storage). The entire WSL2 and Lima micro-VM specification is missing on disk. |
| **ADR 0007** | Open-Core Substrate vs. Industry Adaptation Commercialization | **ALIGNED** | Foundational document defining open-core boundaries and establishing the 9 Canonical Operational Pillars. Governs vertical domain quarantine. |
| **ADR 0008** | Virtual Enterprise Organizational Hierarchy & Agent Governance | **ALIGNED** | Accurately specifies the `.enterprise/` (and `.apm/`) corporate hierarchy, closed-world `.ground` constraints, and mechanical gatekeeper assertion contracts. |
| **ADR 0009** | VS Code Agent Host, Extensibility Plugins, and Skill Toolsets | **ALIGNED** | Accurately specifies portable VS Code integration, Lua plugin lifecycles, and toolset definitions. |
| **ADR 0010** | Distributed BEAM Backplane, Gleam Orchestration, Nomad Scheduling, and MaaS | **STALE SPECIFICATION** | References Gleam daemons and Pulumi Automation API, but omits `cxc`, `packages/clause_jet/`, and native Rust `infra` blocks compiled via `crates/clause-pulumi`. |
| **ADR 0011** | Seax Language, Multi-Target Transpiler, and Agent Directory Pattern | **MAJOR SPEC DRIFT** | Titled *Seax Language*. Specifies building `compiler/seaxc/` from scratch in Rust with an obsolete `Air`/`Jet` runtime split. Omits Gleam fork, `cxc`, TIGAH, and 9 pillars. |
| **ADR 0012** | RinG (Rust-in-Gleam) Type-Safe Native Integration Bridge | **INCOMPLETE SPECIFICATION** | Models RinG purely as a standalone manual CLI generator. Omits automatic dirty-scheduler NIF synthesis executed by `cxc` during `--target beam` compilation. |
| **ADR 0013** | Curated Domain SLMs vs. Saturated Generalist Models | **PARTIALLY ALIGNED** | Accurately details Contained Cup architecture and 1B–7B parameter ceilings, but omits the formal **TIGAH** brand designation and `cx hangar` command verbs. |

### 2.1 Critical ADR Defect Isolation

#### ADR 0006 Corruption Analysis (`DEF-02`)

In `06-clauseos-source-bundle.md`, `docs/adr/adr_006-micro-instance-virtualization.md` opens with `# ADR 006: Host, Container, and Micro-VM Isolation Boundaries`, but lines 8 through 115 replicate the problem statement, decision drivers, and directory trees of ADR 005 verbatim.
The canonical architecture for `cx vm`—governing ephemeral WSL2 instances on Windows NT and Lima instances on macOS, managed via `scripts/cli/nu/commands/vm.nu`, providing bare-metal GPU passthrough and isolated container scheduling—has been completely overwritten in the tracked repository.

#### ADR 0011 Specification Drift Analysis

`docs/adr/adr_011-seax-language-transpiler-agent-directory.md` was drafted during early prototyping and reflects the following obsolete assumptions:

1. **Outdated Language Name:** Uses `Seax` (`.seax` manifests) instead of **Clause** (`.cx` / `clause.toml`).
2. **Outdated Compiler Location:** Directs builds to `compiler/seaxc/` instead of `packages/clause/`.
3. **Retired Runtime Bifurcation:** Splits runtime execution into `Air` (`cx air run` in `packages/carrier_jet/`) and `Jet` (`cx jet up`), which was formally retired in transcript `d48` and `docs/ccefs/06-blueprint` in favor of `cxc` multi-target compilation and `packages/clause_jet/`.
4. **Omission of the Gleam Core Fork:** Fails to document that `cxc` is forked from `gleam-lang/gleam` to inherit Hindley-Milner typing and language server infrastructure.
5. **Missing 9 Canonical Pillars:** Does not define top-level keyword restrictions or standard library namespace partitioning.

#### Cross-File ADR Hyperlink Breakages

The repository manifests an internal naming inconsistency across markdown files. Files on disk use underscores and prefixes (`adr_001_...md`, `adr_004_...md`, `adr_006-...md`), whereas `README.md` and `TASK.md` link to these records using a four-digit numeric convention (`0001-...md`, `0004-...md`, `0006-...md`). Every internal link between the root documentation and the ADR directory is currently broken.

---

## 3. Root Project Ledgers Audit (`README.md` & `TASK.md`)

The root documentation files serve as the primary entrypoint for human operators and autonomous agents. Both files contain significant legacy residue and directory omissions.

### 3.1 `README.md` Forensic Analysis

#### Dead Artifacts Listed in Directory Tree

The repository tree in `README.md` lists several files that were permanently deleted in earlier Git commits:

* **`justfile`:** Listed as the root task orchestrator. Deleted in commit `d41253bb` when all build, test, and package commands were migrated into the `cx` Nushell router.
* **`scripts/core/boot.ps1`:** Listed as the Windows microkernel entrypoint. Deleted in commit `dafcd966` when Stage 0 trampolines were consolidated into root `cx.ps1` and `cx.sh`.
* **`env.ps1` and `env.sh`:** Listed under `config/shell/`. Deleted in commit `900356ce` when the modular TOML SSOT engine (`config/env/*.toml`) was introduced.

#### Omitted Canonical Subsystems

The directory tree in `README.md` fails to display seven core structural directories present in the project architecture:

1. `config/env/`: The five modular TOML configuration files (`00-core.toml` through `40-ml-hub.toml`).
2. `packages/clause/`: The `cxc` compiler fork crate.
3. `packages/clause_jet/`: The Erlang/OTP agent mission control runtime.
4. `packages/tigah/`: The local neural engine and contained SLM weights.
5. `tools/ring/`: The RinG native dirty-scheduler bridge generator.
6. `crates/clause-pulumi/`: The revived native Rust cloud infrastructure compiler (`catapult`).
7. `plugins/cx-*`: The first-party Lua toolchain plugins (`cx-lemonade`, `cx-fastflowlm`, `cx-vscode`, `cx-unsloth`, `cx-comfyui`, `cx-inferssd`).

#### Branding and Workflow Divergence

* **Language Branding:** Refers to the language as `Seax` rather than **Clause (`.cx`)**.
* **Missing Hierarchy:** Lacks the governing corporate hierarchy: **Vieo** $\\rightarrow$ **ClauseOS** $\\rightarrow$ **TIGAH** $\\rightarrow$ **Clause**.
* **Missing Architecture Stack:** Lacks the 7-Layer unified topology diagram established in `d04` and `d25`.
* **Outdated CLI Commands:** Examples instruct users to run `just test` or `just setup` instead of `cx test` and `cx pkg:add`.
* **OS Primitives Table:** Continues to list `Just` as the task runner and omits **InferSSD** from the neural coprocessor tier.

### 3.2 `TASK.md` Forensic Analysis

#### Milestone Header Drift

The document header states:

```markdown
## Current Milestone: v0.1.5-dev (Substrate Stabilization)
```

In reality, the repository completed milestones `v0.8.0-dev.1` through `v0.8.0-dev.10` and advanced to **`v0.9.0-dev.1 (Platform Integration & Orchestration)`**, as confirmed by Git commit history (`11-git-history`) and the live source bundle metadata.

#### Omission of Completed Phase 9 (Supply Chain Milestones)

`TASK.md` jumps from Phase 8 (*Package Management & Renv Isolation*) directly to Phase 10 (*BEAM Backplane & Orchestrator Integration*). It omits the completed engineering work of Phase 9 (executed between October 29 and November 15, 2026):

* Implementation of the 5 modular TOML environment manifests (`config/env/*.toml`).
* Implementation of the 8-pass iterative `${VAR}` symbol compiler in `cx.ps1` and `cx.sh`.
* Establishment of the layered `MISE_ENV` overlays (`paths,ai,cloud`) and `CLAUSE_STATUS="online"` subshell preflight guard.
* Deployment of the unified `cx pkg:*` command suite (`pkg:add`, `pkg:mise`, `pkg:scoop`, `pkg:brew`) and `toml_pin.nu`.
* Implementation of in-place Scoop sterilization (`# clause-scoop-patches: 1`).
* Extraction of AI coprocessors into first-party Lua subtrees under `plugins/cx-*`.

#### Stale Milestone Titles in Active Backlog

* **Phase 12 Title:** Titled *"Seax Language Compiler Core (`seaxc`), Air & Jet Runtimes"*, targeting `compiler/seaxc/` and `packages/carrier_jet/`. Must be retitled to *"Clause Language Compiler (`cxc`), TIGAH & `clause_jet` Runtimes"* targeting `packages/clause/` and `packages/clause_jet/`.
* **Unsynchronized Phase 10 Checkboxes:** Items already committed in `06` remain marked as pending `[ ]`:
  * `HashiStack & BEAM Toolchain Hydration`: Pinned in `.mise.ai.toml` and `.mise.cloud.toml` (Erlang 29.1.2, Elixir 1.20.4, Gleam 1.19.2, Nomad 1.9.3, Consul 1.20.1, Vault 1.18.2).
  * `Model Hub Environment Unification`: Fully declared in `config/env/40-ml-hub.toml`.

---

## 4. Supreme Curriculum Specifications Audit (`docs/ccefs/00`–`04`)

The five foundational specifications in `docs/ccefs/` define the Track 1 curriculum and architectural blueprint. All five documents exhibit specification drift regarding compiler construction.

### 4.1 Master Project Specification (`00-PROJECT-SPECIFICATION-v3.0.md`)

* **Section 1.1 Language Scope:** Continues to designate the default language as `Seax` compiled via `seaxc` in `compiler/seaxc/`. Must be updated to **Clause (`.cx`)** compiled via `cxc` in `packages/clause/`.
* **Section 1.2 Runtime Division:** References the obsolete `Air` and `Jet` split instead of the unified `cxc` compiler and `clause_jet` OTP runtime.
* **Section 1.3 Missing Pillars:** Lacks formal codification of the **Nine Canonical Operational Pillars** from `ADR 0007`.
* **Section 3.0 Source Legend Inventory:** Catalogs 128 sources across letter prefixes `f`, `c`, `a`, `b`, `e`, `l`, `r`, `s`, `t`, but completely omits the **`d` (`d01`–`d99`)** engineering design transcripts. Because these transcripts document the consensus for the Gleam compiler fork (`d48`), micro-instance passthrough (`d13`), and converged media consolidation (`d40`), their omission leaves key decisions untraceable in the legend.

### 4.2 30-Module Curriculum Map (`01-ccefs-30-modules-v4.3.md`)

* **Stage 1 (Modules 1–5):** Prescribes constructing the compiler toolchain from scratch in Rust (`crates/seax-lexer`, `crates/seax-parser`, `crates/seax-macro`, `crates/seax-vm`, `crates/seax-trans`). This directly contradicts `docs/ccefs/06-blueprint` and transcript `d48`, which mandate forking `gleam-lang/gleam` inside `packages/clause/` (`cxc`) to inherit Hindley-Milner typing and language server protocols.
* **Stage 2 (Module 10):** Refers to `Jet` compiling native infrastructure declarations, rather than the revived `pulumi-gestalt` engine in `crates/clause-pulumi` (`catapult`).

### 4.3 Stage 0 Deep-Dive Specification (`02-stage0-foundation-modules-v4.3.md`)

* **Module 0.1 & 0.2:** Accurately captures Stage 0 trampolines, TOML compilation, and in-place Scoop patching.
* **Module 0.5 (Virtual Filesystem):** Refers to `crates/seax-vfs` and `seax` primitives. Must be synchronized to `crates/clause-vfs`, `.ground/`, and `ClauseOS` (`cx`).

### 4.4 Stages 1 & 2 Deep-Dive Specification (`03-stage1-2-compiler-orchestrator-v4.3.md`)

* **Modules 1 through 5:** Extensive technical specifications dedicated to hand-writing a Pratt parser, AST macro expander, and stack VM from scratch. Must be refactored into the Gleam compiler fork architecture: Logos scanner modifications, AST lower passes, Hindley-Milner type checking, and Monkey-X pluggable backend code generation (`Target::Rust`, `Target::Beam`, `Target::Client`).

### 4.5 4-Track Curriculum Portal Blueprint (`04-vieo-ai-curriculum-portal.md`)

* **Track 2 Title & Syllabus:** Titled *"Track 2: Build Claude, OpenClaw & Hermes in Seax"*. Must be updated to *"Track 2: Build Claude, OpenClaw & Hermes in Clause (.cx) & TIGAH"*, re-anchoring all lesson references to `packages/clause/` and `packages/clause_jet/`.

---

## 5. Ancillary Repository Documentation & Plugin Manifests

Minor documentation files across subdirectories were audited for consistency:

1. **`packages/README.md`:** Currently an empty placeholder. It must be populated with documentation describing the three monorepo packages: `packages/clause/` (`cxc` multi-target compiler), `packages/clause_jet/` (Erlang/OTP agent mission control), and `packages/tigah/` (contained domain SLMs).
2. **`ops/README.md`:** Summarizes HashiStack deployment but fails to specify the hermetic confinement mechanism: Nomad, Consul, and Vault execute as unprivileged binaries with state, configuration, and data confined strictly to `$CLAUSE_HOME/.local/share/` and `$CLAUSE_HOME/AppData/Local/`.
3. **`plugins/cx-*/metadata.lua` Repository Names:** The metadata files for all seven Lua plugins list legacy upstream repository names (`mise-comfyui`, `mise-lemonade`). These must be updated to reflect the canonical naming convention: `cx-comfyui`, `cx-lemonade`, `cx-fastflowlm`, and `cx-inferssd`.
4. **Documentation Configuration Manifests:** Documentation manifests must structure navigation around the corrected CCEFS curriculum stages and link to sanitized ADR filenames.

---

## 6. Three-Batch Synchronization & Remediation Roadmap

To resolve all identified documentation drift and active defects without violating the **Carbon Copy + Surgical Diff** principle (avoiding destructive file rewrites), updates must proceed strictly according to the three-batch plan established in `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md`.

```text
================================================================================
                    CLAUSEOS DOCUMENTATION SYNCHRONIZATION PLAN
================================================================================

[BATCH 1: ADRs & ROOT LEDGERS (High Priority)]
  ├── Task B1-01: docs/adr/adr_006 -> Restore canonical WSL2/Lima micro-instance spec (DEF-02)
  ├── Task B1-02: docs/adr/adr_011 -> Retitle to Clause (.cx), cxc Gleam fork, 9 pillars, RinG
  ├── Task B1-03: docs/adr/adr_010 -> Append addendum for cxc and crates/clause-pulumi (catapult)
  ├── Task B1-04: docs/adr/adr_012 -> Append addendum for automated cxc RinG dirty-scheduler NIFs
  ├── Task B1-05: docs/adr/adr_013 -> Append addendum codifying formal TIGAH SLM branding
  ├── Task B1-06: README.md -> Scrub dead files (justfile/boot.ps1), add 7 packages, 7-layer stack
  └── Task B1-07: TASK.md -> Bump to v0.9.0-dev.1, record Phase 9, retitle Phase 12, fix ADR links

[BATCH 2: SUPREME CURRICULUM SPECIFICATIONS (docs/ccefs/00–04)]
  ├── Task B2-01: docs/ccefs/00 -> Replace seaxc with Clause/cxc, add TIGAH, 9 pillars, d prefix
  ├── Task B2-02: docs/ccefs/01 -> Update Modules 1–5 to packages/clause/ (cxc) Gleam fork
  ├── Task B2-03: docs/ccefs/02 -> Align Module 0.5 with clause-vfs (.ground/) and ClauseOS (cx)
  ├── Task B2-04: docs/ccefs/03 -> Re-anchor Stage 1 deep-dive on packages/clause/ and clause-pulumi
  └── Task B2-05: docs/ccefs/04 -> Update Track 2 syllabus to Clause (.cx) and TIGAH

[BATCH 3: PHYSICAL CODE & CONFIG REPAIRS (Synchronized with Docs)]
  ├── Task B3-01: scripts/cli/nu/config/env.nu -> Refactor to consume compiled TOML exports (DEF-01)
  ├── Task B3-02: config/env/20-toolchains.toml & cx.ps1 -> Inject $SCOOP/shims into PATH (DEF-08)
  ├── Task B3-03: scripts/cli/nu/commands/pkg/add.nu -> Fix mod.nu delegation to pkg:scoop/pkg:brew
  ├── Task B3-04: .github/workflows/ci.yml -> Uncomment ./cx.sh test & .\cx.ps1 test (DEF-03)
  ├── Task B3-05: tests/system/test_stage1.nu -> Update path assertions to $MISE_INSTALLS_DIR (DEF-04)
  ├── Task B3-06: tests/env/test_env.{nu,sh} -> Strip literal citation strings (DEF-05)
  ├── Task B3-07: cx.sh -> Add _CALLER_CLAUSE_STATUS session guard handling (DEF-06)
  └── Task B3-08: plugins/cx-comfyui -> Emit extra_model_paths.yaml linking $HF_HOME (DEF-07)
================================================================================
```

---

## 7. Governance Verdict & Signoff

```text
================================================================================
                    DOCUMENTATION GOVERNANCE AUDIT VERDICT
================================================================================
AUDIT IDENTIFIER: CCEFS-CLAUSEOS-DOCS-AUDIT-V1.0
TIMESTAMP: 2026-11-22T18:30:00-08:00
AUTHORIZING ROLE: Principal Research & Systems Architect / PhD Curriculum Fellow
GOVERNING MANDATE: Supreme SSOT Protocol (06 -> 05 -> 00–04)

AUDIT SUMMARY BY COMPONENT:
  • Architecture Decision Records (docs/adr/):   1 Corrupted (ADR 006), 1 Major Drift (ADR 011),
                                                 3 Missing Addenda (ADR 010, 012, 013), Broken Links
  • Root Project Ledgers (README, TASK):         Dead Files (justfile, boot.ps1), Stale Milestone (v0.1.5),
                                                 Missing Phase 9, Missing Core Packages
  • Curriculum Specifications (docs/ccefs/00–04): Stale Greenfield Rust Compiler Specs (seaxc)
                                                 Missing Gleam Fork Alignment (cxc), Missing d Prefix
  • Physical Code & Config (Substrate):          8 Verified Defects (env.nu, Scoop PATH, add.nu, ci.yml)

================================================================================
                    FINAL AUDIT VERDICT: ACTION REQUIRED
================================================================================
VERDICT RATIONALE:
The documentation in `06-clauseos-source-bundle.md` exhibits well-defined, bounded 
specification drift and one critical file corruption (ADR 006). The live codebase 
and recent architecture blueprints (`docs/ccefs/06-blueprint`, `docs/ccefs/07-sync-plan`, 
`d48`) have evolved to a unified, production-grade model that must be back-ported to 
the documentation tree.

EXECUTION AUTHORIZATION:
Execution of Batch 1 (ADRs and Root Ledgers) and Batch 3 (Physical Code Repairs) is 
authorized to begin immediately upon user confirmation of the unified diff packages.
================================================================================
```
