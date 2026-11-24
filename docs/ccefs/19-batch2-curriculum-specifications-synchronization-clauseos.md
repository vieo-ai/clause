# Batch 2 Curriculum Specifications Synchronization & Execution Record

**Artifact Designation:** `docs/ccefs/19-batch2-curriculum-specifications-synchronization-clauseos.md`  
**Classification:** Track 1 CCEFS Foundation Specification & Batch 2 Execution Record  
**Governance Overlay:** Supreme Single Source of Truth (SSOT) Protocol (`06` $\rightarrow$ `05` $\rightarrow$ `00`–`04` $\rightarrow$ `a`–`t`)  
**Analytical Perspective:** Principal Systems Architect / PhD Curriculum Fellow (Quad Synthesis: *Fowler P-EAA* + *Gang of Four* + *Otwell/Laravel DX* + *Storer Real-Time Zero-Allocation Audio/Video DSP*)

---

## 1. Executive Context & Batch 2 Mandate

Following the successful completion and locking of **Batch 1 (Architecture Decision Records & Root Ledgers Synchronization)**, the project advances to **Batch 2: Supreme Curriculum Specifications Synchronization**.

Under the **Supreme Single Source of Truth (SSOT) Protocol**, the five master curriculum specifications residing in `docs/ccefs/` (`00-PROJECT-SPECIFICATION-v3.0.md` through `04-vieo-ai-curriculum-portal.md`) govern the system architecture, track syllabi, and educational progression of the CCEFS initiative.

However, forensic analysis in `05-source-bundle-audit-report.md`, `16-documentation-audit-and-alignment-clauseos.md`, and `17-totality-project-evaluation-clauseos.md` identified significant specification drift in these foundational documents:

1. **The Compiler Construction Drift:** Curriculum specifications `00` through `04` still prescribed building a greenfield `seaxc` compiler from scratch in Rust with stack-based bytecode VMs (`crates/seax-*`). This was superseded on November 20, 2026, by the landmark consensus in `docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md` and transcript `d48-gleam-to-clause-forking`, which mandates an upstream-clean fork of `gleam-lang/gleam` inside `packages/clause/` emitting the `cxc` binary with Monkey-X multi-target emitters (`--target rust`, `--target beam`, `--target client`).
2. **The Phantom Directory Contamination:** Early specifications referenced an ungrounded `.enterprise/` directory for corporate hierarchy and agent packaging. In reality, the Virtual Enterprise is modeled, packaged, and governed strictly via **APM (Agent Package Manager)** anchored in root `apm.yml` and `.apm/`, with deterministic projections via `apm build` into `.claude/`, `.agents/`, and `.vscode/`.
3. **Source Prefix Taxonomy Gap:** Section 3 of `00-PROJECT-SPECIFICATION-v3.0.md` omitted row **`d` — Discussions & Design Transcripts (`d01`–`d99`)**, which records the authoritative design provenance of platform pivots.

This document executes and records the formal synchronization of all five curriculum specifications, permanently reconciling theoretical documentation with the live repository baseline in `06-clauseos-source-bundle.md` (v0.9.0-dev.1).

---

## 2. The Gleam Compiler Fork Consensus (`cxc`)

The core architectural pivot codified across Batch 2 is the transition from a greenfield compiler to the upstream-clean fork of `gleam-lang/gleam`:

* **Upstream Heritage Preserved:** Preserves 100% of Gleam's Rust lexer, fault-tolerant parser, Hindley-Milner type inference engine, exhaustive pattern matching, formatter, and language server (`clause-lsp`), eliminating years of compiler frontend development risk.
* **Sovereign Workspace Anchor:** Situated cleanly inside `packages/clause/` with workspace crates:
  * `clause-core`: Type checker, AST passes, and multi-target code generators.
  * `clause-cli`: Emits `[[bin]] name = "cxc"` installed into `${CLAUSE_BIN_DIR}/cxc`.
  * `clause-lsp`: Language Server Protocol daemon.
  * `clause-wasm`: WebAssembly compiler runtime.
  * `clause-runtime`: Native Rust runtime linking `oximedia`, `nih-plug`, and `clause-pulumi`.
* **Monkey-X Multi-Target Codegen Architecture:**
  * **`--target beam`:** Compiles telecom switches, agent loops, and supervisors into Core Erlang / `.beam` bytecode for distributed Erlang/OTP 29 releases (`packages/clause_jet/`).
  * **`--target rust`:** Compiles compute-heavy hot paths, zero-allocation DSP, and cloud infrastructure directly into native Cargo crates with zero heap copies via direct `@external(rust, ...)` crate imports.
  * **`--target client`:** Compiles touch-glass flight decks and MVU viewports into TypeScript / WebAssembly powering `Lustre`, `Plushie`, and `Shore`.
* **Automatic `tools/ring` Dirty-Scheduler Bridging (`ADR 0012`):** When `.cx` source targeting the BEAM invokes `@external(rust, ...)`, `cxc` automatically synthesizes DirtyScheduler NIF shims, routing DSP and heavy I/O to `DirtyCpu`/`DirtyIo` threads.

---

## 3. Excision of Phantom Directories & Canonical APM Architecture

Batch 2 permanently excises `.enterprise/` and `enterprise/` across all five curriculum specifications. All references have been replaced with the canonical **Agent Package Manager (APM)** architecture grounded in `t03_agent_package_manager.md`:

```text
clause / cx (Workspace Root)
├── apm.yml                               # Root APM package & workspace manifest
├── .apm/                                 # Agent Package Manager state directory
│   ├── agents/                           # Department heads & role orchestrators (*.agent.md)
│   ├── skills/                           # Procedural skills (<name>/SKILL.md)
│   ├── instructions/                     # Normative contracts (*.clause.md) & directives
│   ├── plugins/                          # Tool definitions & MCP bridges
│   └── hidden-subagents/                 # Internal specialized worker agents
├── .apm_modules/                         # Installed external APM dependencies
└── [Generated Downstream Projections via `apm build`]
    ├── .claude/                          # CLAUDE.md, .claude/agents/, .claude/skills/, settings.json
    ├── .agents/ & AGENTS.md              # Harness-agnostic directives (OpenCode, Codex, OpenClaw)
    └── .vscode/                          # Copilot workspace agent prompts and tool definitions
```

---

## 4. Master Synchronization Audit Matrix

| Document Path | Prior Inconsistency / Specification Drift | Synchronized Canonical Baseline | Verification Status |
| :--- | :--- | :--- | :---: |
| **`docs/ccefs/00-PROJECT-SPECIFICATION-v3.0.md`** | Referenced `seaxc` in `compiler/seaxc/`; Air/Jet split; missing TIGAH, 9 pillars, and row `d` in taxonomy; contained ghost `.enterprise/` references. | Codified Clause (`.cx`) / `cxc`, 9 Canonical Pillars, `@external(rust, ...)` direct linking, root `apm.yml` & `.apm/`, and added row `d` (`d01`–`d99`). | **100% SYNCHRONIZED** |
| **`docs/ccefs/01-ccefs-30-modules-v4.3.md`** | Stage 1 (Modules 1–5) described building `crates/seax-*` from scratch; Module 22 referenced `.enterprise/`. | Stage 1 re-anchored on `packages/clause/` (`cxc`) Gleam fork; Module 0.5 updated to `clause-vfs` (`.ground/`); Module 22 updated to root `apm.yml` and `.apm/`. | **100% SYNCHRONIZED** |
| **`docs/ccefs/02-stage0-foundation-modules-v4.3.md`** | Module 0.5 referenced `seax-vfs`, Seax, and `package.seax`; next-stage pointer referenced `seaxc`. | Module 0.5 aligned with `clause-vfs` (`.ground/`), root `apm.yml`, and `clause.toml`; next-stage pointer aligned with Clause (`.cx`) / `cxc`. | **100% SYNCHRONIZED** |
| **`docs/ccefs/03-stage1-2-compiler-orchestrator-v4.3.md`** | Modules 1–5 described writing lexer, Pratt parser, and stack VM from scratch; Module 10 used legacy Jet. | Modules 1–5 detail `packages/clause/crates/*`, Logos scanner, Pratt parser, HM typing, and Monkey-X codegen; Module 10 lowers `infra` to `crates/clause-pulumi`. | **100% SYNCHRONIZED** |
| **`docs/ccefs/04-vieo-ai-curriculum-portal.md`** | Track 2 titled "Build Claude/OpenClaw in Seax"; referenced MkDocs for site generation. | Track 2 retitled to "Build Claude, OpenClaw & Hermes in Clause (`.cx`) & TIGAH"; presentation engine codified as Lustre SSG in `packages/clause_site/`. | **100% SYNCHRONIZED** |

---

## 5. The Nine Canonical Operational Pillars & Domain Purity Invariant

In strict compliance with **`ADR 0007`**, all syntax additions to Clause (`.cx`) and the standard library (`stdlib/clause/`) across `00` through `04` are restricted to the **Nine Canonical Operational Pillars**:

1. **Systems & Microkernel (`clause/kernel`):** OS internals, bare-metal confinement, sandboxing.
2. **Service Providers & Container Lifecycle (`clause/app`):** Two-phase boot, lazy deferral, dependency injection.
3. **Cloud Providers & Pulumi IaC (`clause/infra`):** Revived `clause-pulumi` (`catapult`), bare-metal MaaS.
4. **Aviation & Mission Control (`clause/mission`, `clause/deck`):** Flight decks, telemetry, Capcom, Elm/MVU surfaces.
5. **Telecom & Carrier Switching (`clause/comms`):** Kazoo Class 5 softswitch, Kamailio SBC, SIP/WebRTC trunking.
6. **Recording & Music Publishing (`clause/studio`):** Zero-allocation audio DSP (`oximedia`, `nih-plug`, `SoundCraft`), DDEX rights.
7. **Film, Broadcast & Virtual Production (`clause/stage`):** Mezzanine post (ACEScc, OTIO), 3DGS, show control (NDI, SMPTE).
8. **IPTV, OTT & Streaming (`clause/stream`):** Live headends, CMAF packaging, CPIX DRM, SCTE-35 splicing.
9. **Military Tactical & TIGAH AI (`clause/tactical`, `clause/tigah`):** Zero-trust links, EMCON airgap, contained 1B–7B SLMs.

Generic commercial verticals (retail POS, generic SaaS boilerplate) are barred from the core grammar and relegated to downstream `.apm/` packages.

---

## 6. Formal Gate Release Record

```text
================================================================================
                    FRAMEWORK RELEASE RECORD & GOVERNANCE GATE
================================================================================
RELEASE IDENTIFIER: CCEFS-BATCH2-CURRICULUM-SYNC-V1.0
TIMESTAMP: 2026-11-23T13:30:00-08:00
AUTHORIZING ROLE: Principal Research & Systems Architect / PhD Curriculum Fellow
GOVERNING MANDATE: Supreme SSOT Constitution (06 -> 05 -> 00–04)

AUDIT CHECKPOINT SUMMARY:
  [✓] Specification Parity:        100% Aligned with packages/clause/ (cxc) Gleam Fork
  [✓] Ghost Directory Purge:       0 Occurrences of .enterprise/ in 00–04
  [✓] APM Architectural SSOT:     Root apm.yml & .apm/ Systematically Codified
  [✓] Domain Purity Boundary:      9 Canonical Operational Pillars Statically Enforced
  [✓] Repository Taxonomy:         Prefix 'd' Formally Added to Section 3 of 00-spec

================================================================================
                    FINAL RELEASE VERDICT: FULL PASS
================================================================================
VERDICT RATIONALE:
Batch 2 has achieved complete theoretical and architectural reconciliation across all five 
master curriculum specifications. Specifications 00 through 04 now perfectly mirror the live 
repository baseline, the Gleam compiler fork, and the canonical APM architecture.

DOWNSTREAM UNLOCKING:
With Batch 1 and Batch 2 cleared, the project advances to Batch 3: Physical Code & Configuration 
Defect Remediation (scripts/cli/nu/config/env.nu, cx.ps1, config/env/20-toolchains.toml, 
and .github/workflows/ci.yml).
================================================================================
```
