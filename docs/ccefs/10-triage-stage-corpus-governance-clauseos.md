# ClauseOS Triage-Stage Corpus Governance & Evidence Stratification

Artifact Designation: `docs/ccefs/10-triage-stage-corpus-governance-clauseos.md`  
Governance Overlay: Supreme Single Source of Truth Protocol (`06` -> `05` -> `00`–`04` -> `a`–`t`)  
Analytical Perspective: Principal Systems Architect / PhD Curriculum Fellow (Quad Synthesis: Fowler P-EAA + Gang of Four + Otwell DX + Storer Zero-Allocation Audio/Video DSP)

---

## 1. Architectural Framing and Governance Rationale

Following the formal execution of the Gather Stage, the ClauseOS engineering initiative enters the Triage Stage. The repository environment comprises 199 curated sources spanning Drive markdown files, PDFs, Google Docs, and Gemini engineering design transcripts, alongside one dedicated forensic note titled `n01-scoop-path-audit`. Within a project governed by zero-leak hermeticity and carrier-grade reliability invariants, uncurated evidence poses an existential architectural risk. Specifically, speculative conversational design chats, exploratory agent harnesses, or stale specification documents can inadvertently pollute downstream compiler construction and cluster orchestration if granted equal evidentiary standing.

The purpose of this governance artifact is to enforce rigid evidentiary hygiene across the entire knowledge base. By establishing five objective screening rubrics, appraising authority across a five-tier hierarchy, reconciling seven primary redundancy clusters, and mapping every active item to an explicit functional evidence role, the Triage Stage prevents specification drift from entering the physical codebase. This document formally delivers the Corpus Charter, the Stratified Priority Map, the Approved Active Corpus, and the active Gap Queue.

---

## 2. Gating Criteria and Screening Rubrics

To eliminate subjective evaluation and speculative drift, every source entering the active working memory of ClauseOS is appraised against five objective, binary-scored rubrics. A source that fails any foundational rubric is either restricted in its evidential scope or relegated to background contextual commentary.

### 2.1 The Five Objective Evaluation Rubrics

*   **Parity with Physical Codebase (P):** Measures whether the assertions, paths, and configurations described in the document accurately reflect the ground-truth implementation in `06-clauseos-source-bundle.md` or represent documented defects tracked in `05-source-bundle-audit-report.md`. A score of 1 indicates verified parity or tracked remediation; a score of 0 indicates an ungrounded or superseded technical claim.
*   **Authority Ranking (A):** Establishes the document's legal and architectural precedence within the project's constitutional hierarchy. Authority descends strictly from physical source code (Tier 1) down to informal conversational design logs (Tier 5).
*   **Relevance to Canonical Pillars (R):** Assesses whether the technical content directly governs one or more of the nine approved operational pillars defined in Architecture Decision Record 0007: kernel, app, infra, deck, comms, studio, stage, stream, or tactical. Content addressing quarantined commercial verticals fails this gate.
*   **Verifiability and Rigor (V):** Demands that all architectural assertions be supported by deterministic shell scripts, compilable AST schemas, mathematical proofs, official RFC standards, or reproducible empirical benchmarks. Narrative assertions lacking technical mechanics are rejected as speculative.
*   **Structural Distinctness (D):** Identifies whether the source introduces unique engineering mechanisms or merely duplicates existing specifications with alternative conversational phrasing. Redundant documents are consolidated into canonical anchors.

---

## 3. Relevance Screening and Lexicon Purity Boundaries

The repository's 199 sources were screened across the twelve operational competency domains and evaluated against the lexicon boundaries codified in Architecture Decision Record 0007.

### 3.1 Domain Mapping across Subsystems

*   **Systems and Userland Sandboxes (Domain 8):** Captured authoritatively in the root bootloaders `cx.bat`, `cx.ps1`, `cx.sh`, modular environment manifests `config/env/00-core.toml` through `40-ml-hub.toml`, and the shell literature spanning `l21` through `l32`.
*   **Compilers, Transpilers, and Multi-Target Codegen (Domain 10):** Governed by the compiler blueprint in `docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md`, transcript `d48-gleam-to-clause-forking`, and compiler engineering texts `k01` through `k03`.
*   **Telecommunications, Switching, and Media Streaming (Domains 2, 4, 5):** Grounded in the master architectural blueprints for Real-Time Communications, Digital Media Infrastructure, Open Source Broadcast, and the state of the BEAM ecosystem.
*   **Recording DSP and Zero-Allocation Systems (Domain 3):** Bound by the real-time audio constraints of Julian Storer's JUCE discipline, `oximedia`, and `nih-plug`, interfacing via native Rust dirty-scheduler bridges.
*   **AI Engineering and Autonomous Harnesses (Domain 12):** Governed by the Claude Code extraction series `r01` through `r22`, protocol standards `s01` through `s05`, and the AI Engineering From Scratch encyclopedia `e01` through `e06`.

### 3.2 Quarantine of Anti-Keywords and Non-Carrier Verticals

In strict enforcement of Architecture Decision Record 0007, generic business applications, retail point-of-sale systems, bakery management software, electronic health record workflows, and hospital clinical data models are formally designated as anti-keywords. Such domains are prohibited from entering the standard library of the Clause language (`stdlib/clause/`). Where enterprise business orchestration appears in discussion transcripts (such as `d20-onemancompany-framework-review` or `d23-ai-company-os-evaluation-report`), it is strictly quarantined to downstream commercial cartridges (`.apm/` or `.enterprise/`), ensuring the core operating system maintains carrier-class purity.

---

## 4. Source Identity Verification and Catalog Integrity

All 199 selected sources and the single forensic note were verified against their canonical storage identities and media classifications.

| Prefix and Classification | Volume | Media Format | Governing Scope |
| :--- | :--- | :--- | :--- |
| **00–06 Numerical SSOT** | 7 documents | Drive Markdown | Tier 1 repository snapshot (`06`), defect audit report (`05`), and Tier 2 curriculum specifications (`00` through `04`). |
| **07–11 Indices & History** | 5 documents | Markdown / Doc | Resource legend, index maps, polyglot stack analyses, lesson templates, and git history (`11-git-history`). |
| **a00–a07 Design Patterns** | 8 documents | PDF / DOCX | Fowler enterprise patterns (`a06`), Gang of Four object-oriented foundations (`a02`, `a07`), and Laravel architecture (`a05`). |
| **b00–b23 Systems & AI** | 24 documents | PDF | Pragmatic software construction, Clean Architecture (`b02`), deep learning theory, and API systems architecture (`b23`). |
| **d01–d51 Design Logs** | 51 documents | Gemini Transcripts | Engineering deliberations capturing the evolution of the hermetic substrate, compiler pivots, and container models. |
| **e01–e06 AIEFS Encyclopedia**| 6 documents | PDF | Comprehensive curriculum covering AI engineering from mathematical foundations through production deployment. |
| **k01–k04 Compilers & VMs** | 4 documents | PDF | Thorsten Ball's interpreter, compiler, and macro system foundations, alongside Tim Boring's distributed orchestrator. |
| **l01–l49 Polyglot Stacks** | 49 documents | PDF | Deep technical specifications across 19 target runtimes, emphasizing Rust (`l13`, `l14`), Elixir/BEAM (`l04`), and shells. |
| **r01–r22 Agent Harnesses** | 22 documents | PDF | Source decompilations and architectural analyses of Claude Code, OpenClaw, and production coding harnesses. |
| **s01–s05 Protocol Standards** | 5 documents | PDF | Model Context Protocol landscape, security architectures, Agent-to-Agent protocols, and the Longhorn harness. |
| **t01–t09 Strategic Whitepapers**| 9 documents | Markdown (Drive) | Agentic software development life cycles, Agent Package Manager, AI Company OS, and prompt engineering protocols. |
| **Strategic Master Blueprints** | 10 documents | Google Docs | Industrial analyses spanning converged media economics, cloud infrastructure, broadcast engineering, and RTC backplanes. |
| **Forensic Audit Notes** | 1 note (`n01`) | Notebook Note | Byte-level verification of Scoop installation substrate, registry no-op patching, and session PATH exposure gaps. |

---

## 5. Authority Appraisal and the 5-Tier SSOT Precedence Hierarchy

Evidentiary conflicts within the ClauseOS knowledge base are adjudicated according to an immutable five-tier constitutional hierarchy. Lower-tier sources can inform, contextualize, or propose enhancements, but can never override higher-tier mandates.

### Tier 1: Live Implementation Reality (Absolute Precedence)
Tier 1 represents the ground-truth physical state of the repository. It comprises `06-clauseos-source-bundle.md` (version 0.9.0-dev.1 tracking 195 files), `05-source-bundle-audit-report.md` (the verified catalog of internal implementation defects), and Note `n01-scoop-path-audit` (the physical verification of package manager paths). When an architectural document claims a capability that does not exist in Tier 1 code, the physical code wins unconditionally, and the specification is cited as drifted.

### Tier 2: Supreme Architectural and Curriculum Specifications
Tier 2 governs formal system design, track syllabi, and architecture decision records. It encompasses `00-PROJECT-SPECIFICATION-v3.0.md` through `04-vieo-ai-curriculum-portal.md`, the canonical ADR ledger (`adr_001` through `adr_013`), `docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md`, and `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md`. Tier 2 provides the target blueprint that Tier 1 implementation must satisfy.

### Tier 3: Industry Standards, Formal Protocols, and Rigorous Systems Research
Tier 3 provides the algorithmic foundations, mathematical theorems, and engineering patterns that validate ClauseOS design choices. It includes Martin Fowler's enterprise application patterns, the Gang of Four structural catalog, Thorsten Ball's compiler mechanics, broadcast standards (ITU-R BS.1770-4, EBU R128, ACEScc, SMPTE IMF), and verified Rust systems literature.

### Tier 4: Agentic Frameworks, Harness Extractions, and Package Protocols
Tier 4 encompasses empirical analyses of production AI coding tools (`r01` through `r22`), protocol security specifications (`s01` through `s05`), the AI Engineering From Scratch encyclopedia (`e01` through `e06`), and the Agent Package Manager specifications (`t01` through `t09`). These sources define the operational patterns for autonomous CLI execution.

### Tier 5: Engineering Design Transcripts and Evolution Logs
Tier 5 includes the conversational design transcripts `d01` through `d51`, historical git logs (`11-git-history`), and polyglot stack surveys. These records supply historical context and explain why specific pivots occurred, but possess zero normative authority over code or formal specifications.

---

## 6. Duplicate Resolution and Redundancy Clusters

A forensic sweep across the 199 sources identified seven significant clusters of overlapping documentation, duplicate analysis, and conceptual drift. Each cluster is formally resolved to an authoritative anchor.

### Cluster 1: Greenfield Compiler vs. Gleam Core Fork
*   **Overlapping Material:** Stage 1 curriculum specifications in `01-ccefs-30-modules-v4.3.md` and `03-stage1-2-compiler-orchestrator-v4.3.md`, discussion transcripts `d03`, `d07`, and `d48`, and the compiler blueprint `docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md`.
*   **Evidentiary Conflict:** Early curriculum documents prescribe writing `seaxc` completely from scratch in Rust, implementing custom Pratt parsers, lexers, and bytecode stack machines. Conversely, `docs/ccefs/06` and transcript `d48` document the unanimous architectural decision to fork `gleam-lang/gleam` inside `packages/clause/` to emit the `cxc` binary with Monkey-X multi-target backends.
*   **Authoritative Resolution:** The Gleam core fork codified in `docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md` and transcript `d48` is the definitive architecture. Curriculum documents `01` and `03` are formally categorized as drifted specifications awaiting surgical synchronization under Batch 2 of `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md`.

### Cluster 2: Converged Media Economics and Infrastructure
*   **Overlapping Material:** Transcripts `d28-economics-of-converged-media-consolidation`, `d29-tech-giants-achieving-media-convergence`, `d30-the-economics-of-converged-media-entities`, `d33-digital-media-infrastructure-&-evolution-report`, `d40-the-ultimate-converged-media-empire`, and the strategic Google Docs on Media Convergence Strategy and Tech Media Convergence.
*   **Authoritative Resolution:** The comprehensive Google Docs *Media Convergence Strategy Analysis* and *Digital Media Infrastructure Blueprint* serve as the authoritative reference anchors. The conversational transcripts `d28`, `d29`, and `d30` are designated as secondary background context.

### Cluster 3: Claude Code Decompilation and Agent Harness Mechanics
*   **Overlapping Material:** The twenty-two-part harness extraction series spanning `r01` through `r22`, with intense concentration in `r01`, `r03`, `r08`, `r14`, `r15`, `r16`, and `r19`.
*   **Authoritative Resolution:** Document `r16-deep-dive-claude-code-source.pdf` alongside `r19-claude-code-decoding-agent-harness.pdf` are designated as the definitive technical anchors for the compacted context loop, tool-calling execution cycle, and subagent delegation model. High-level conceptual articles (`r05`, `r06`) are subordinated.

### Cluster 4: Multi-Channel Gateway Implementations in OpenClaw
*   **Overlapping Material:** Sources `r02-build-your-own-openclaw.pdf`, `r09-build-your-own-openclaw-py.pdf`, `r10-build-your-own-openclaw-ts.pdf`, `r11-claw0.pdf`, `r18-claw-decode.pdf`, and `r22-deep-dive-into-openclaw.pdf`.
*   **Authoritative Resolution:** Document `r22-deep-dive-into-openclaw.pdf` and the TypeScript implementation in `r10` represent the primary operational references for multi-channel gateway routing (Discord, Slack, CLI, Web). The early Python prototypes serve as secondary implementation guides.

### Cluster 5: Autonomous Virtual Enterprise and Company OS Models
*   **Overlapping Material:** Strategic whitepapers `t04_one_man_company.pdf.md`, `t05_ai_company_os.md`, and design transcripts `d20`, `d23`, and `d24`.
*   **Authoritative Resolution:** Whitepaper `t05_ai_company_os.md` and transcript `d24-corporate-organizational-structure-breakdown` are the canonical specifications governing corporate departmental hierarchy and subagent delegation. Document `t04` is retained as an operational case study.

### Cluster 6: OpenProse Multi-Agent Coordination Specification
*   **Overlapping Material:** Drive document `t06_openprose.md` and transcript `d17-openProse-repository-analysis`.
*   **Authoritative Resolution:** Drive document `t06_openprose.md` is the primary normative contract defining Markdown-based agent coordination syntax. Transcript `d17` is retained as implementation commentary.

### Cluster 7: Vieo Engineering Curriculum Portal Architecture
*   **Overlapping Material:** Specification `04-vieo-ai-curriculum-portal.md` and design transcripts `d44-master-vieo-v2`, `d45-master-vieo-v1`, and `d46-research-paper-vieo-valid`.
*   **Authoritative Resolution:** Specification `04-vieo-ai-curriculum-portal.md` is the sole Tier 2 specification governing the four-track educational portal. Transcripts `d44` through `d46` provide historical validation.

---

## 7. Evidence Role Functional Classification

Every active source within the ClauseOS knowledge base is classified into one of five distinct operational roles to govern its downstream utilization.

```text
Evidence Role Matrix:
1. Normative Ground Truth: 06-bundle, 05-audit, Note n01.
2. Architectural Rule & Spec SSOT: 00 through 04, ADR Ledger (adr_001–013), docs/ccefs/06, docs/ccefs/07.
3. Mechanistic & Algorithmic Engine: k01–k04, a00–a07, l13–l14, l04, Strategic Media/RTC Blueprints.
4. Tactical Agent & Harness Protocol: r01–r22, s01–s05, e01–e06, t01–t09.
5. Historical Context & Design Evolution: d01–d51, 09-polyglot-stack-analysis, 11-git-history.
```

### 7.1 Normative Ground Truth
Sources in this role represent physical code and verified execution behavior. They establish what the system actually does at runtime, defining the baseline against which all specifications are audited.

### 7.2 Architectural Rules and Specification SSOT
These documents define mandatory system constraints, directory topologies, language grammar, and curriculum syllabi. They hold constitutional authority over all future code additions.

### 7.3 Mechanistic and Algorithmic Engines
These texts supply the underlying theoretical models, algorithms, and design patterns. They govern how the Pratt parser evaluates precedence, how stack virtual machines resolve symbols, and how zero-allocation ring buffers process audio samples.

### 7.4 Tactical Agent and Harness Protocols
These documents define how autonomous CLI coding agents operate, structure prompt templates, manage context compaction, dispatch subagents, and secure tool execution gates.

### 7.5 Historical Context and Design Evolution
Sources in this category preserve the institutional memory of the project. They explain why earlier designs were refactored, documenting the rationale behind major architectural decisions without imposing normative constraints.

---

## 8. Competency Domain Balance Audit

An audit across the twelve operational domains was conducted to evaluate coverage density and ensure no critical subsystem suffers from evidentiary starvation.

| Domain Competency | Source Density | Qualitative Assessment | Identified Systemic Risk |
| :--- | :--- | :--- | :--- |
| **1. Tactical Networking & Zero-Trust** | 6 sources | Focused and adequate | None. Grounded in air-gapped field links and deterministic failover. |
| **2. Telecom & Softswitch Architecture** | 14 sources | Highly robust | None. Fully supported by Kazoo, Kamailio, and BEAM literature. |
| **3. Recording DSP & Audio Infrastructure** | 11 sources | Rigorous and deep | High implementation barrier requiring strict zero-allocation enforcement. |
| **4. Film, Video Post & Playout** | 12 sources | Highly robust | Requires continuous tracking of ACEScc color science and NDI buses. |
| **5. On-Demand Streaming & IPTV/CMAF** | 9 sources | Highly adequate | Fully covered by Membrane framework and CMAF packaging blueprints. |
| **6. Real-Time 3D & Virtual Production** | 8 sources | Emerging and adequate | Grounded in 3D Gaussian Splatting and Storytold Craft suites. |
| **7. Rights Administration & Media P&L** | 7 sources | Highly adequate | Governed by DDEX ERN 4.3 and single-franchise accounting automation. |
| **8. Hermetic Systems & Sandboxing** | 26 sources | Saturated | Active defects in path exposure and test harnesses must be repaired. |
| **9. Bare-Metal MaaS & Micro-VMs** | 12 sources | Highly robust | ADR 0006 copy corruption requires restoration of canonical text. |
| **10. Language Engineering & Codegen** | 38 sources | Saturated | Specification drift between early seaxc docs and cxc Gleam fork. |
| **11. DevOps, SecOps & Offline CI Gates** | 15 sources | Highly robust | Inactive CI test runners in ci.yml must be re-enabled. |
| **12. AI Engineering & Agent Harnesses** | 41 sources | Saturated | Strong saturation across Claude Code, OpenClaw, and AIEFS texts. |

---

## 9. The ClauseOS Corpus Charter

To preserve architectural integrity across all downstream development phases, the following four constitutional rules are codified into the Corpus Charter:

### Rule 1: Source-Code Supremacy
The physical source bundle `06-clauseos-source-bundle.md` (version 0.9.0-dev.1) followed by `05-source-bundle-audit-report.md` is the supreme single source of truth. Any statement in an architectural specification, design transcript, or subordinate text that conflicts with the physical code is invalid unless supported by a verified commit.

### Rule 2: Non-Destructive Editing and Traceable Diffs
Existing architectural specifications (`00` through `04`) and architecture decision records (`adr_001` through `adr_013`) must never be silently truncated, compressed, or overwritten. All modifications must be delivered as traceable, surgical diffs conforming to the synchronization roadmap in `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md`.

### Rule 3: The Nine Canonical Operational Pillars
The standard library and language grammar of Clause (`.cx`) are strictly restricted to the nine canonical pillars: kernel, app, infra, deck, comms, studio, stage, stream, and tactical. All generic commercial verticals (including retail, banking, and healthcare) are excluded from the core language and quarantined to optional enterprise cartridges.

### Rule 4: Closed-World Falsification and Grounding Gates
Any technical claim, crate dependency, package manifest, or runtime parameter that cannot be verified in the uploaded notebook sources or live repository snapshot must be visibly flagged as ungrounded and requires explicit user authorization before entering formal specifications.

---

## 10. Stratified Priority Map (P0–P3)

The knowledge base is stratified into four operational priority tiers to direct engineering focus during active implementation.

```text
Priority Stratification:
P0 (Critical Path): 06-bundle, 05-audit, Note n01, 00-spec through 04-portal, docs/ccefs/06, docs/ccefs/07, ADRs 001–013.
P1 (Mechanistic Engines): k01–k04, a00–a07, l13–l14, l04, l21–l32, Strategic Media/RTC Master Blueprints.
P2 (Tactical Harnesses): r01–r22, s01–s05, e01–e06, t01–t09.
P3 (Contextual Evolution): d01–d51, 08-resource-index, 09-polyglot-stack-analysis, 11-git-history.
```

### P0: Critical Path (Directly Blocking Stage 0 and Stage 1 Release)
Contains the live repository bundle, the verified defect audit report, the forensic Scoop path audit note, the supreme curriculum specifications, the Gleam compiler refactoring blueprint, the document synchronization plan, and the canonical ADR ledger. Every engineering decision in Stage 0 remediation and Stage 1 compiler bootstrapping directly derives from this tier.

### P1: Mechanistic Engines and Foundational Patterns
Encompasses the core engineering texts: Thorsten Ball's compiler and interpreter series, Tim Boring's orchestrator, Martin Fowler's enterprise architecture patterns, the Gang of Four catalog, comprehensive Rust systems literature, Elixir/BEAM internals, advanced shell programming guides, and the industrial media blueprints.

### P2: Tactical Harnesses and Agent Protocols
Comprises the Claude Code extraction series (`r01` through `r22`), the Model Context Protocol and Agent-to-Agent security standards (`s01` through `s05`), the complete AI Engineering From Scratch encyclopedia (`e01` through `e06`), and the enterprise agent specifications (`t01` through `t09`).

### P3: Contextual Evolution and Historical Transcripts
Encompasses the fifty-one Gemini design transcripts (`d01` through `d51`), the polyglot stack survey (`09`), the resource legend (`07`), and the git commit history (`11`). These documents provide institutional rationale and development history.

---

## 11. Approved Active Corpus Inventory

The approved active corpus comprises 199 verified sources and one forensic note, structured across eleven functional classifications:

1.  **Constitutional Specifications and Audit Reports:** Sources `00`, `01`, `02`, `03`, `04`, `05`, `06`, and Note `n01`.
2.  **Architectural Patterns and Clean Design:** Sources `a00` through `a07`, `b00` through `b04`, `b18`, and `b23`.
3.  **Compiler Construction and Systems Runtimes:** Sources `k01` through `k04`, and `l01` through `l49`.
4.  **Strategic Media, Broadcast, and Telecom Blueprints:** Ten Google Doc master blueprints and specialized media transcripts (`d33`, `d41`, `d42`, `d43`).
5.  **Agent Harnesses, Protocols, and AI Engineering:** Sources `r01` through `r22`, `s01` through `s05`, `e01` through `e06`, `b05` through `b16`, and `t01` through `t09`.
6.  **Engineering Design Transcripts:** Sources `d01` through `d51`.

*(Sources `w01` through `w05` remain excluded from active query evaluation per user directive).*

---

## 12. Formal Gap Queue and Remediation Pathways

The Triage Stage establishes the active Gap Queue, isolating five major structural discrepancies between documented specifications and physical repository code.

### GAP-01: Specification Drift in Compiler Toolchain
*   **Description:** Curriculum specifications `01-ccefs-30-modules-v4.3.md` and `03-stage1-2-compiler-orchestrator-v4.3.md` still prescribe building `crates/seax-core` from scratch in Rust, whereas the accepted architecture in `docs/ccefs/06-blueprint` and transcript `d48` mandates forking `gleam-lang/gleam` inside `packages/clause/` (`cxc`).
*   **Remediation Pathway:** Apply the Batch 2 surgical diffs defined in `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md` to align the curriculum with the Gleam compiler fork.

### GAP-02: Runtime Environment Hydration Defect in Nushell
*   **Description:** The script `scripts/cli/nu/config/env.nu` attempts to parse a non-existent legacy `.env` file and indexes obsolete `WIN_*` keys, generating errors during clean shell initialization.
*   **Remediation Pathway:** Apply the Batch 3 code patch documented in `05-source-bundle-audit-report.md`, refactoring `env.nu` to consume canonical environment variables compiled from `config/env/*.toml`.

### GAP-03: Scoop Package Shim Path Omission
*   **Description:** As audited in Note `n01-scoop-path-audit`, while `installer_scoop.ps1` sterilizes registry writes, neither `cx.ps1` nor `config/env/20-toolchains.toml` exposes `$env:SCOOP\shims` on session PATH, rendering Scoop-installed CLI applications unreachable.
*   **Remediation Pathway:** Inject the Scoop shims directory into `$env:PATH` during `cx.ps1` preflight and export `SCOOP_SHIMS` in `20-toolchains.toml`.

### GAP-04: ADR 0006 File Content Corruption
*   **Description:** The physical content of `docs/adr/adr_006-micro-instance-virtualization.md` in `06-clauseos-source-bundle.md` is an accidental copy-paste duplicate of ADR 005 (Model Storage), losing the canonical WSL2 and Lima micro-VM architecture.
*   **Remediation Pathway:** Restore the canonical micro-instance virtualization text preserved in `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md` and design transcript `d13`.

### GAP-05: Deactivated Automated Verification in CI
*   **Description:** The continuous integration manifest `.github/workflows/ci.yml` has the primary test execution commands (`./cx.sh test` and `.\cx.ps1 test`) commented out, allowing commits to pass without running the test suite.
*   **Remediation Pathway:** Uncomment test runner execution across Linux, macOS, and Windows runners in `ci.yml` and verify that `tests/system/run_all.nu` exits with code 0.
