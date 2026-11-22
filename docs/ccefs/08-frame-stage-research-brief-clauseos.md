# Frame-Stage Research Brief & Governance Decision (ClauseOS)

**Document Identifier:** `docs/ccefs/08-frame-stage-research-brief-clauseos.md`  
**Classification:** Track 1 CCEFS Foundation Specification & Verification Gate  
**Governance Hierarchy:** Supreme Single Source of Truth Overlay (`06` to `05` to `00`–`04` to `a`–`t`)  
**Analytical Perspective:** Principal Systems Architect / PhD Curriculum Fellow (Quad Synthesis: *Fowler P-EAA* + *Gang of Four* + *Otwell DX* + *Storer Zero-Allocation Audio/Video DSP*)

---

## 1. Executive Context & Frame-Stage Objectives

The CCEFS (Carrier-Class Enterprise From Scratch) initiative and its living reference implementation, ClauseOS (`clause.os` / `cx`), transition into the formal Frame Stage to establish inviolable decision boundaries, freeze evidential requirements, and eliminate specification drift prior to active compiler bootstrapping and cluster orchestrator construction.

The foundational thesis of ClauseOS dictates that the code is the product, not the end result. In accordance with the project constitution, all technical claims and architectural milestones must adhere to the two-tier Supreme Single Source of Truth (SSOT) hierarchy:

* **Tier 1 (Live Repository State):** The repository source bundle (`06-clauseos-source-bundle.md`, version v0.9.0-dev.1, tracking 195 files) in conjunction with the forensic audit report (`05-source-bundle-audit-report.md`) represents the absolute single source of truth for the implemented codebase. In any scenario where architectural documents or subordinate research materials diverge from the live codebase, the source code wins unconditionally as it reflects physical ground-truth implementation.
* **Tier 2 (Architectural & Curriculum Specifications):** The project master specification (`00-PROJECT-SPECIFICATION-v3.0.md`) through the curriculum portal blueprint (`04-vieo-ai-curriculum-portal.md`), alongside the Canonical ADR Ledger (`adr_001` through `adr_013`), govern systemic requirements, module sequencing, and domain contracts.

The objective of this brief is to define core decisions, refine falsifiable research questions, bound operational scope, choose the analytical review type, establish strict evidence rules, map stakeholder responsibilities across twelve specialized disciplines, and evaluate five mandatory readiness gates before authorizing work on Stage 1 (Language & Compiler Toolchain) and Stage 2 (Distributed Orchestrator & Infrastructure).

---

## 2. Core Architectural Decisions (Task 16)

This research brief formally governs three interdependent architectural decisions that establish the baseline for all subsequent CCEFS progression.

### Decision A: Stage 0 Hermetic Substrate Certification & Defect Remediation

Determine whether the live Stage 0 substrate inside `.home/` satisfies zero-leak, deterministic confinement criteria as mandated by Architecture Decision Records 0001 and 0004, and resolve the seven documented implementation defects identified in the forensic audit report.

Stage 0 provides the isolated userland execution environment across Windows NT, Linux, and macOS. It redirects `$HOME`, `$USERPROFILE`, and `$XDG_*` base directories entirely into `${CLAUSE_PROJECT_ROOT}/.home/`. Two decision options exist:

1. **Option A.1 (Proceed Without Remediation):** Advance directly to compiler construction while leaving known Stage 0 audit defects open in the backlog.
2. **Option A.2 (Surgical Remediation Gate):** Gate Stage 1 compiler construction on the complete remediation of active configuration and script defects, ensuring the host operating system remains sterile and continuous integration gates actively verify every commit.

Selecting Option A.1 introduces cascading non-deterministic failures into compiler builds, package management commands, and cross-platform continuous integration pipelines. Option A.2 preserves host sterility and guarantees reproducible compilation environments. The reversal cost of Option A.1 is extreme: reversing contaminated host state requires manual filesystem intervention, registry cleanup on Windows hosts, and complete recreation of the `.home/` sandbox across developer workstations.

### Decision B: Compiler Architecture Reconciliation (`seaxc` vs. `cxc` Fork)

Formally arbitrate between building a greenfield compiler from scratch in Rust versus executing an upstream-clean fork of the Gleam compiler core inside `packages/clause/`.

Master curriculum specifications (`01-ccefs-30-modules-v4.3.md` and `03-stage1-2-compiler-orchestrator-v4.3.md`) describe building the `seaxc` compiler toolchain from scratch in Rust, including a hand-written Pratt parser, AST macro system, bytecode virtual machine, and multi-target code generation engine. Conversely, architecture blueprints (`docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md` and transcript `d48-gleam-to-clause-forking`) demonstrate that forking `gleam-lang/gleam` inside `packages/clause/` to produce the `cxc` CLI binary provides an immediate, battle-tested Hindley-Milner type system, Language Server Protocol infrastructure, and a robust code generation pipeline adaptable to Mark Sibley's Monkey-X multi-target paradigm (`Target::Rust`, `Target::Beam`, `Target::Client`). Two options exist:

1. **Option B.1 (Greenfield Seaxc Construction):** Implement lexing, Pratt parsing, type checking, and code generation from zero in Rust (`crates/seax-*`).
2. **Option B.2 (Gleam Core Upstream-Clean Fork):** Fork `gleam-lang/gleam` inside `packages/clause/`, rebranding the compiler CLI to `cxc`, retaining native `.gleam` compatibility, adding `.cx` syntax extensions, and introducing `--target rust` code generation alongside standard `--target beam`.

Option B.1 requires substantial engineering effort dedicated to solving solved problems in type theory, parsing edge cases, and language server protocols. Option B.2 delivers immediate production-grade static typing, full Hex package ecosystem reuse, and direct interop with the Erlang runtime while focusing architectural innovation on multi-target transpilation and zero-allocation systems hooks. Reversal after committing to a greenfield compiler architecture imposes months of rebuild penalty across syntax definitions, standard libraries, and editor tooling.

### Decision C: Domain Lexicon Purity Gate (`ADR 0007` Compliance)

Enforce absolute architectural boundaries on the Clause language grammar, standard library (`stdlib/clause/`), and runtime primitives, confining them strictly to the approved Nine Canonical Operational Pillars while quarantining generic business SaaS constructs.

ClauseOS is engineered specifically for carrier-grade telecommunications, real-time media DSP, distributed broadcast playout, autonomous tactical operations, and infrastructure engineering. Generic commercial verticals dilute compiler design and pollute standard library namespaces. Two options exist:

1. **Option C.1 (Unrestricted Domain Grammar):** Permit ad-hoc domain keywords and commercial business logic to enter the primary language grammar and standard library.
2. **Option C.2 (Strict Open-Core Quarantine):** Restrict compiler keywords, top-level constructs, and standard namespaces strictly to `kernel`, `app`, `infra`, `deck`, `comms`, `studio`, `stage`, `stream`, and `tactical` / `tigah`. All secondary industry models must be quarantined into external, optional enterprise packages (`.apm/` or `.enterprise/`).

Option C.1 leads to semantic bloat and unstable compiler AST definitions. Option C.2 establishes a durable, defensible open-core substrate with clear commercialization boundaries. Deprecating polluted language syntax or moving standard library namespaces after downstream applications depend on them breaks backward compatibility.

---

## 3. Research Questions & Falsification Probes (Task 17)

To prevent vague exploration, all research inquiries are formulated as falsifiable, deterministic engineering probes.

### Primary Research Question

Can the ClauseOS hermetic userland (`.home/`) deterministically host, build, and verify the multi-target Clause compiler (`cxc` / `seaxc`) across Windows NT, Linux, and macOS without writing a single file, environment variable, or registry key to the host operating system?

### Secondary Research Questions & Empirical Tests

#### Secondary Question 1: Package Manager Hermeticity and Path Shim Visibility
Does the in-place patching of Scoop in `installer_scoop.ps1` eliminate host registry mutation while exposing installed binary shims to Nushell sessions without polluting the host environment path?

* **Falsification Probe:** Execute `installer_scoop.ps1` on a clean Windows NT host, install CLI packages (`jq`, `ripgrep`), and assert:
  1. Registry key `HKCU:\Environment` contains zero modified keys.
  2. The host Start Menu contains zero newly created shortcuts.
  3. Installed binaries are resolvable inside Nushell via `$env:PATH`.

#### Secondary Question 2: Toolchain Isolation and Build Artifact Containment
Does adding explicit toolchain variable declarations (`CARGO_HOME` and `RUSTUP_HOME`) to `config/env/20-toolchains.toml` prevent the Rust toolchain from leaking build caches, downloaded crates, and toolchain binaries into host profile directories?

* **Falsification Probe:** Trigger a clean `cargo build` of `packages/clause/` within the isolated environment and verify that `%USERPROFILE%\.cargo` and `~/.cargo` remain untouched, with all downloads landing within `${CLAUSE_DATA_DIR}/cargo`.

#### Secondary Question 3: Dual-Plane Compilation and Dirty-Scheduler Safety
Can the `cxc` compiler lower `.cx` syntax into `--target rust` (linking native DSP engines like `oximedia` and `nih-plug`) and `--target beam` (Erlang/OTP supervision actors) while safely managing cross-plane interop via `tools/ring` without starving Erlang schedulers?

* **Falsification Probe:** Generate a high-throughput audio DSP processing loop inside `.cx`, compile to native Rust, expose via Dirty-Scheduler NIFs to an Erlang actor supervision tree, and assert that standard reductions per scheduling turn remain within the 2,000 to 4,000 ceiling without causing thread lockups.

#### Secondary Question 4: Domain Purity AST Gating
Does the Clause compiler front-end successfully reject ungrounded commercial vertical syntax at the parser level while cleanly resolving canonical pillar constructs?

* **Falsification Probe:** Submit source files containing anti-keywords (such as `retail_pos`, `hospital_ehr`, `bakery`) to `cxc` and verify deterministic parse failure, while valid pillar constructs (`trunk`, `rack`, `stage`, `infra`) lower to target code without error.

---

## 4. Scope Boundaries & Anti-Keyword Redlines (Task 18)

Operational boundaries define the exact systems under active development, explicit functional exclusions, and the tracked physical paths within the repository.

### In-Scope Functional Systems

The active implementation encompasses three foundational tiers:

1. **Stage 0 Hermetic Substrate:**
   * Root entrypoint trampolines: `cx.bat`, `cx.ps1`, `cx.sh`.
   * Declarative environment configuration: `config/env/00-core.toml`, `10-identity.toml`, `20-toolchains.toml`, `30-shell.toml`, `40-ml-hub.toml`.
   * Shell runtime and environment initialization: `scripts/cli/nu/core/boot.nu`, `config/env.nu`, `config/config.nu`.
   * Package plane isolation: `installer_scoop.ps1`, `installer_brew.sh`, `scripts/cli/nu/commands/pkg/scoop.nu`.
2. **Toolchain & Hardware Acceleration Matrix:**
   * Dynamic five-way GPU and NPU probe logic covering AMD APU/ROCm, Apple Silicon Metal, Intel oneAPI, and DirectML.
   * Centralized model cache projection: shared `$HF_HOME` anchor across ComfyUI, FastFlowLM, Lemonade, and Unsloth.
3. **Stage 1 & Stage 2 Core Specifications:**
   * Reconciled compiler blueprint: `packages/clause/` (`cxc`) emitting `--target rust` and `--target beam`.
   * Distributed control plane: `packages/clause_jet/` executing over Erlang/OTP 29.
   * Micro-instance virtualization substrate: WSL2 and Lima management via `cx vm`.
   * Unified verification suite: `tests/system/run_all.nu`, `test_stage0.nu`, `test_stage1.nu`.

### Out-of-Scope Exclusions & Anti-Keywords

The following domains, patterns, and methodologies are strictly excluded from the open-core substrate:

1. **Generic Business & Commercial Verticals:**
   * Anti-keywords: `retail-pos`, `bakery`, `hospital-ehr`, `clinical-trials`, `legal-billing`, `real-estate-mls`, `general-saas`.
   * Enforcement: Any domain construct not represented within the Nine Canonical Pillars is quarantined to optional enterprise cartridges.
2. **Unconfined Shell Execution:**
   * No production logic may run in interactive host shells outside the hermetic bootloader and Nushell command router.
3. **Unbounded Frontier Model Training:**
   * Large foundation model pre-training from scratch is excluded; the AI engineering scope is strictly bounded to local 1B–7B domain SLMs, LoRA fine-tuning, and quantized coprocessors.

### Tracked Workspace Boundaries

The physical workspace boundaries governed by this framework encompass the following directories and operations:

| Path Prefix | Governance Role | Permitted Operations |
| :--- | :--- | :--- |
| `config/env/*.toml` | Single Source of Truth for Environment | Declarative updates via TOML compiler |
| `scripts/cli/nu/` | Nushell Operational Control Plane | Core command logic and wrappers |
| `docs/ccefs/00`–`04` | Master Curriculum Specifications | Targeted synchronization diffs |
| `docs/adr/` | Canonical Architectural Decision Records | Additions and historical restorations |
| `tests/system/` | Binary Verification Harness | Deterministic assertion test scripts |
| `packages/clause/` | Compiler Implementation Subsystem | Gleam core fork and emitters |
| `packages/clause_jet/` | Mission Control & Agent Runtime | Erlang/OTP supervision trees |

---

## 5. Review Methodology & Multi-Lens Panel (Task 19)

Given the carrier-grade reliability standards demanded by ClauseOS, conversational or superficial reviews are rejected. The evaluation follows a formal three-stage audit workflow:

1. **Stage 1: Forensic Codebase Diff Inspection (Tier 1 SSOT: 06 to 05):**  
   Deterministic parsing and verification of ASTs, shell scripts, TOML manifests, and path shims against physical files in the live repository snapshot.
2. **Stage 2: Multi-Lens Domain Panel (Isolated Discipline Analysis):**  
   Evaluation across four specialized engineering disciplines to ensure non-interference, performance guarantees, and contract compliance.
3. **Stage 3: Single-Writer Synthesis & Verification Gate:**  
   Binary execution of automated test suites and issuance of formal GO, REVISE, or STOP gating decisions.

### Multi-Lens Competency Panel

The review evaluates all system components through four primary architectural perspectives:

* **Systems & Sandboxing Lens (Domain 8):** Verifies filesystem confinement, Landlock and Seatbelt boundary compliance, KnownFolder and XDG base directory isolation, process tree trapping, and zero host pollution.
* **Telecommunications & Carrier Switching Lens (Domain 2):** Verifies Erlang/OTP supervision hierarchies, 2,000 to 4,000 reduction preemption limits, zero-downtime routing, SIP signaling compliance, and non-blocking state machine design.
* **Recording & Transmedia DSP Lens (Domains 3, 4, 6):** Enforces Julian Storer's real-time zero-allocation memory discipline on audio threads, lock-free ring buffers, ITU-R BS.1770-4 loudness compliance, ACEScc color science, and SMPTE timecode accuracy.
* **AI Engineering & Autonomous Agents Lens (Domain 12):** Audits 1B–7B contained domain SLM inference, unified model weight caching in `$HF_HOME`, MCP/A2A communication contracts, and context compaction loops.

---

## 6. Evidence Hierarchy & Grounding Rules (Task 20)

Every architectural assertion and curriculum milestone must be supported by verifiable evidence ranked according to five immutable tiers.

### Five-Tier SSOT Precedence Hierarchy

The governance structure strictly enforces precedence from physical code down to historical transcripts:

1. **Tier 1: Live Implementation Reality (Absolute Precedence):**  
   Comprises `06-clauseos-source-bundle.md` (v0.9.0-dev.1), `05-source-bundle-audit-report.md` (Forensic Defect Baseline), and Note `n01-scoop-path-audit` (Physical PATH Verification).
2. **Tier 2: Supreme Architectural & Curriculum Specifications:**  
   Comprises `docs/ccefs/00-PROJECT-SPECIFICATION-v3.0.md` through `04-vieo-ai-curriculum-portal.md`, the Canonical ADR Ledger (`adr_001` through `adr_013`), `docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md`, and `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md`.
3. **Tier 3: Industry Standards & Rigorous Systems Literature:**  
   Comprises Martin Fowler's *Patterns of Enterprise Application Architecture* (`a06`), Gang of Four *Design Patterns* (`a02`/`a07`), Thorsten Ball's compiler treatises (`k01`–`k03`), Tim Boring's orchestrator treatise (`k04`), international audio/video broadcast standards (ITU-R BS.1770-4, EBU R128, ACEScc, SMPTE IMF), Rust systems design patterns (`l13`, `l14`), and Elixir/BEAM architecture (`l04`).
4. **Tier 4: Tactical AI Harnesses & Agentic Frameworks:**  
   Comprises Claude Code from Source (`r14`–`r16`), OpenClaw implementations (`r02`, `r10`, `r22`), *AI Engineering From Scratch* Volumes 1–6 (`e01`–`e06`), and the Agentic SDLC & Enterprise OS specifications (`t01`, `t03`, `t05`, `t06`).
5. **Tier 5: Engineering Design Transcripts & Evolution Logs:**  
   Comprises Gemini engineering transcripts `d01` through `d51`, serving exclusively as historical context and design rationale.

### Operational Grounding Rules

To ensure strict evidentiary integrity, four operational rules govern all synthesis:

* **Source Code Supremacy:** If any architectural document (`00`–`04`), design transcript (`d01`–`d51`), or subordinate research document conflicts with `06-clauseos-source-bundle.md` or `05-source-bundle-audit-report.md`, the live codebase wins unconditionally.
* **Explicit Drift Flagging:** Any specification describing features or crates not yet present in `06` must be explicitly annotated as `[SPEC DRIFT / UNIMPLEMENTED IN 06]`.
* **Closed-World Checkpoint:** Unreferenced external packages or speculative design patterns not present in the notebook corpus are strictly barred from entering specifications.
* **Non-Destructive Editing:** Foundational documents must not be truncated or deleted. Adjustments must follow targeted diff batches as codified in `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md`.

---

## 7. Stakeholder Matrix & Domain Ownership (Task 21)

Stakeholder roles across the twelve operational domains are structured using the RACI framework to delineate operational boundaries:

| Competency Domain | Primary Responsibility | RACI | Key Artifact Deliverables |
| :--- | :--- | :---: | :--- |
| **Domain 1: Military & Tactical Networking** | Zero-trust RF links, air-gap survivability | **C** | EMCON scripts, offline validation gates |
| **Domain 2: Telecom & Carrier Switching** | Class 5 softswitches, SIP trunking, BEAM OTP | **R** | `packages/clause_jet/`, Kazoo bridge |
| **Domain 3: Recording & Music DSP** | Zero-allocation audio DSP, mastering loudness | **R** | `oximedia` bindings, `nih-plug` CLAP/VST3 |
| **Domain 4: Film & Live Broadcasting** | ACEScc pipeline, SMPTE IMF, live playout | **C** | Playout control bus, OTIO adapters |
| **Domain 5: Streaming & IPTV/OTT** | CMAF packaging, Membrane transcoding | **C** | HLS/DASH pipelines, transcode workers |
| **Domain 6: 3D, Virtual Production & Surfaces** | 3D Gaussian Splatting, Storytold Craft | **I** | Neural rendering hooks, tactile glass |
| **Domain 7: Media Accounting & Rights** | Automated split sheets, residual governance | **C** | Smart contract rules, ASC 926 ledger |
| **Domain 8: Hermetic Systems & Sandboxing** | OS userland isolation, zero host leak | **R** | `cx.ps1`, `cx.sh`, `config/env/*.toml` |
| **Domain 9: Cloud & Micro-Virtualization** | HashiStack, bare-metal iPXE, `cx vm` | **R** | `crates/clause-pulumi`, Lima/WSL2 hooks |
| **Domain 10: Software & Language Engineering**| `cxc` compiler, Pratt parser, multi-codegen | **R** | `packages/clause/`, Monkey-X emitters |
| **Domain 11: DevOps, SecOps & CI/CD** | Offline CI validation, kernel sandboxes | **R** | `tests/system/run_all.nu`, CI workflows |
| **Domain 12: AI Engineering & SLM Harnesses** | 1B–7B domain SLMs, local coprocessors | **R** | TIGAH engine, `$HF_HOME` shared cache |
| **Founder / L0 Executive** | Overall project stewardship, release signoff | **A** | Final governance decisions (GO/REVISE) |

*(Legend: **R** = Responsible, **A** = Accountable, **C** = Consulted, **I** = Informed)*

---

## 8. Readiness Assessment & Binary Gating Evaluation (Task 22)

Readiness to transition from the Frame Stage into active Stage 1 implementation is evaluated across five mandatory, binary-scored gates:

| Gate ID | Gating Criterion | Target Files & Scope | Evaluation Result |
| :---: | :--- | :--- | :---: |
| **G-01** | Hermetic Isolation of `.home/` | `cx.ps1`, `cx.sh`, `config/env/00-core.toml` | **PASS** |
| **G-02** | Toolchain Sterilization | `installer_scoop.ps1`, `pkg/scoop.nu` | **PASS** |
| **G-03** | Hardware & Model Hub Anchor | `config/env/40-ml-hub.toml`, `plugins/cx-*` | **PASS** |
| **G-04** | Audit Defect Remediation | `env.nu`, `ci.yml`, `test_stage1.nu`, etc. | **FAIL** |
| **G-05** | SSOT Document Synchronization | `docs/ccefs/00` through `04` specifications | **FAIL** |

### Detailed Gate Audit Findings

The empirical findings for each evaluated gate are documented as follows:

* **Gate G-01: Hermetic Isolation of `.home/` (PASSED):** Host environment variables `$HOME` and `$USERPROFILE` are redirected into `${CLAUSE_PROJECT_ROOT}/.home/`. KnownFolder and XDG paths point strictly to local project storage. No host pollution is detected.
* **Gate G-02: Toolchain Sterilization (PASSED):** The script `installer_scoop.ps1` successfully stubs `Set-EnvVar` and start menu shortcut creation via the in-place patch marker `# clause-scoop-patches: 1`. Scoop operations cannot write to the Windows Registry.
* **Gate G-03: Hardware Acceleration & Model Hub Anchor (PASSED):** Dynamic five-way GPU probes are established. The unified model hub correctly sets `$HF_HOME` to `${CLAUSE_CACHE_DIR}/huggingface`, preventing weight duplication across local inference engines.
* **Gate G-04: Audit Defect Remediation (FAILED):** The seven implementation defects cataloged in `05-source-bundle-audit-report.md` remain unmerged in `06-clauseos-source-bundle.md`:
  1. `scripts/cli/nu/config/env.nu` attempts to parse a non-existent `.env` file and references retired `WIN_*` environment variables.
  2. `docs/adr/adr_006-micro-instance-virtualization.md` contains a copy-paste duplicate of `ADR 005` (Model Storage), losing its WSL2/Lima specification.
  3. `.github/workflows/ci.yml` has `./cx.sh test` and `.\cx.ps1 test` commented out, disabling continuous integration verification.
  4. `tests/system/test_stage1.nu` asserts retired paths (`$CLAUSE_APPS_DIR`) instead of canonical paths (`$MISE_INSTALLS_DIR`).
  5. `tests/env/test_env.nu` and `test_env.sh` contain literal citation strings that break parsing.
  6. `cx.sh` lacks session preservation handling for nested subshells (`_CALLER_CLAUSE_STATUS`).
  7. `plugins/cx-comfyui` omits the generation of `extra_model_paths.yaml` linking ComfyUI checkpoints directly to `$HF_HOME`.
  8. Forensic note `n01-scoop-path-audit` confirms that `$env:SCOOP\shims` is absent from `$env:PATH`, preventing Scoop packages from being executed in Nushell.
* **Gate G-05: SSOT Document Synchronization (FAILED):** Master curriculum specifications describe implementing `seaxc` from scratch in Rust, while the accepted technical architecture (`docs/ccefs/06-blueprint` and transcript `d48`) mandates forking `gleam-lang/gleam` inside `packages/clause/` (`cxc`). The three-batch synchronization plan outlined in `docs/ccefs/07` has not yet been committed to disk.

---

## 9. Formal Governance Verdict & Workflow Return Loop

```
================================================================================
                    FRAME-STAGE GATE DECISION: REVISE
================================================================================
VERDICT: REVISE (Execution Gated on Remediation of Gates G-04 and G-05)
CONFORMANCE SCORE: 60% (3 of 5 Gates Satisfied)
BLOCKING CONDITIONS:
  [!] Active code and configuration defects from 05 audit report unmerged.
  [!] Specification drift between curriculum docs (00–04) and compiler blueprint.
================================================================================
```

### Rationale for Verdict

Under the core discipline of Curriculum-Driven Development, initiating compiler construction or orchestrator scheduling on top of an active audit failure violates the fundamental invariants of carrier-class engineering. Building the compiler toolchain while the base environment script (`env.nu`) throws errors on startup and continuous integration tests are disabled creates an untrusted foundation.

Execution does not abort (`STOP`) nor recklessly advance (`GO`). It returns to the Stage 0 Remediation and Synchronization workflow.

### Remediation Protocol: The Workflow Return Loop

In strict adherence to the Frame Stage rules ("a failed condition returns to the correct earlier workflow before release"), execution returns to **Stage 0 Defect Remediation & Document Tree Synchronization**:

1. **Step 1: Execute Batch 3 Code & Configuration Fixes:**
   * Rewrite `scripts/cli/nu/config/env.nu` to consume compiled TOML variables exported by `cx.ps1` and `cx.sh`.
   * Inject `$env:SCOOP\shims` into `$env:PATH` in `cx.ps1` and `config/env/20-toolchains.toml`.
   * Restore canonical WSL2/Lima text to `docs/adr/adr_006-micro-instance-virtualization.md`.
   * Uncomment `cx test` executions in `.github/workflows/ci.yml`.
   * Update path assertions in `tests/system/test_stage1.nu` to inspect `$MISE_INSTALLS_DIR`.
   * Strip citation paste artifacts from `tests/env/test_env.nu` and `test_env.sh`.
   * Add `_CALLER_CLAUSE_STATUS` session preservation handling to `cx.sh`.
   * Generate `extra_model_paths.yaml` in the `plugins/cx-comfyui` post-install hook.
2. **Step 2: Execute Batch 1 & Batch 2 Document Tree Synchronization:**
   * Batch 1: Synchronize ADRs (`006`, `010`, `011`, `012`, `013`), `README.md`, and `TASK.md`.
   * Batch 2: Apply targeted diffs to `docs/ccefs/00-PROJECT-SPECIFICATION-v3.0.md` through `04-vieo-ai-curriculum-portal.md`.
3. **Step 3: Run Deterministic Verification Harness:**
   * Execute `cx test` (running `tests/system/run_all.nu`).
   * Assert exit code zero across all platform runners.
   * Advance verdict from **REVISE** to **GO**, authorizing Stage 1 compiler construction (`packages/clause/` `cxc`).

---

## 10. Preserved Authorization & Document Handoff

This brief represents the authoritative baseline for the CCEFS Frame Stage. The decisions, research questions, scope definitions, evidence rules, stakeholder mappings, and gating results documented herein are locked.

Upon user confirmation of Batch 3 remediation execution, Gates G-04 and G-05 will be re-evaluated. When both clear, the gate decision will formally advance from **REVISE** to **GO**, authorizing full execution of Stage 1 compiler construction.
