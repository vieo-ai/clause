# Gather-Stage Research Protocol & Evidence Library

**Artifact Designation:** `docs/ccefs/09-gather-stage-research-protocol-clauseos.md`  
**Classification:** Track 1 CCEFS Foundation Specification & Evidence Protocol  
**Governance Overlay:** Supreme Single Source of Truth (SSOT) Protocol (`06` $\rightarrow$ `05` $\rightarrow$ `00`–`04` $\rightarrow$ `a`–`t`)  
**Analytical Perspective:** Principal Systems Architect / PhD Curriculum Fellow (Quad Synthesis: *Fowler P-EAA* + *Gang of Four* + *Otwell/Laravel DX* + *Storer Real-Time Zero-Allocation Audio/Video DSP*)

---

## Executive Summary & Gather Stage Context

This protocol establishes the formal search architecture, knowledge routing parameters, controlled vocabulary mappings, primary seed libraries, citation chains, grey literature extraction logs, and saturation audits for the ClauseOS project. It operationalizes the governance requirements defined during the Frame Stage, establishing an immutable evidential boundary across the project repository, verified defect reports, curriculum specifications, and subordinate systems literature.

The methods and criteria codified in this document govern all active data gathering, ensuring that technical claims regarding userland hermeticity, toolchain isolation, compiler construction, and carrier-grade media pipelines remain strictly grounded in verifiable implementation artifacts.

## 1. Controlled Vocabulary and Keyword Taxonomies

To eliminate linguistic ambiguity across twelve complex engineering domains and prevent colloquial drift from degrading architectural specifications, search terms are organized into closed, non-overlapping synonym rings. These rings reflect the nine canonical operational pillars established in the architecture decision records, defining explicit boundaries between core substrate primitives and external domain extensions.

The controlled terminology links systems programming concepts with carrier softswitching, digital signal processing, distributed scheduling, and contained neural execution.

| Canonical Operational Pillar | Primary Controlled Terminology | Synonym Rings and Polyglot Equivalents | Prohibited Anti-Keywords |
| :--- | :--- | :--- | :--- |
| Kernel and Systems Substrate (`clause/kernel`) | `kernel`, `init`, `syscall`, `trap`, `pcb`, `hal`, `driver`, `vfs`, `inode`, `vmm`, `fault`, `microvm`, `overlay`, `pin` | Landlock, Seatbelt, Bubblewrap, KnownFolder redirection, XDG Base Directory, PID 1, cgroup isolation, process overlay, storage lease | `retail-pos`, `bakery`, `general-saas`, `hospital-ehr`, `clinical-trials` |
| Application Lifecycle and Dependency Injection (`clause/app`) | `service_provider`, `register`, `boot`, `defer`, `contract`, `bind`, `singleton`, `publish`, `container`, `pipeline` | Inversion of Control container, dynamic supervisor child specification, scoped resolution, lazy provider, middleware cascade | `untyped-globals`, `adhoc-dispatch`, `magic-autoload` |
| Cloud Infrastructure and Provisioning (`clause/infra`) | `infra`, `provider`, `stack`, `resource`, `output`, `preview`, `up`, `refresh`, `destroy`, `pxe`, `catapult` | Revived Pulumi engine, HashiCorp Nomad execution driver, Consul service mesh, Vault dynamic lease, Pixiecore netboot, Packer rootfs | `manual-ssh`, `clickops`, `unversioned-state` |
| Mission Control and Surface Presentation (`clause/deck`) | `cx`, `cxc`, `jet`, `air`, `ground`, `deck`, `hangar`, `squawk`, `capcom`, `surface`, `model`, `telemetry` | Flight deck telemetry, Elm architecture model-view-update, Lustre web client, Plushie native interface, Shore terminal interface | `untyped-dom-mutation`, `jquery-patterns` |
| Carrier Telecommunications and Softswitching (`clause/comms`) | `sbc`, `trunk`, `leg`, `bridge`, `dialplan`, `acd`, `cdr`, `sip`, `sdp`, `rtp` | Kazoo softswitch, Kamailio boundary controller, RTPEngine proxy, session initiation protocol, ICE and STUN traversal | `unsupervised-sockets`, `blocking-io` |
| Recording Studio and Real-Time Audio DSP (`clause/studio`) | `stem`, `bus`, `rack`, `master`, `patchbay`, `take`, `split`, `dub`, `residual`, `recoup` | Zero-allocation audio engine, CLAP and VST3 plugin architectures, JUCE audio buffers, ITU loudness gating, DDEX metadata standards | `heap-alloc-in-audio-thread`, `mp3-mastering` |
| Live Broadcast and Virtual Production (`clause/stage`) | `slate`, `reel`, `grade`, `stage`, `splat`, `mcr`, `playout`, `cue`, `timecode`, `osc`, `midi`, `dmx` | Master control room, Apple ProRes mezzanine profiles, Academy Color Encoding System, SMPTE timecode, Gaussian splatting, OpenTimelineIO | `lossy-mezzanine`, `uncalibrated-displays` |
| Streaming Headend and IPTV Transcoding (`clause/stream`) | `headend`, `mux`, `ingest`, `srt`, `transcode`, `abr`, `cmaf`, `drm`, `manifest` | TVHeadend ingest, TSDuck transport stream processor, Membrane framework, fragmented MP4 packaging, Common Media Application Format | `flash-video`, `rtmp-playout-only` |
| Tactical Operations and Contained AI (`clause/tigah`) | `agent`, `skill`, `tool`, `memory`, `compact`, `gateway`, `lane`, `heartbeat`, `expose`, `sortie` | Model context protocol, agent-to-agent protocol, local distilled domain models, emergency emissions control, air-gapped execution | `unconstrained-generalist-chat`, `prompt-injection` |

Anti-keywords represent domain concepts strictly excluded from the core compiler grammar and standard library. Any extracted evidence bearing anti-keyword signatures is quarantined from the core repository and directed to optional downstream commercial cartridges.

## 2. Knowledge Routing and Database Partitions

To enforce evidential integrity and prevent informal discussions from superseding operational code, repository materials are partitioned into five hierarchical data strata. Every search query routes to specific strata based on the evidential authority required.

The routing architecture guarantees that live codebase files and verified audit reports always maintain supreme precedence over design proposals, academic papers, and historical transcripts.

### Stratum 0: Ground-Truth Codebase Physical Store

This stratum encompasses the tracked source files in the primary repository snapshot. It represents the physical reality of what currently executes across shell bootloaders, configuration manifests, engine wrappers, and native code modules. All factual claims regarding current system capabilities must be grounded in this layer first. In the event of a conflict between Stratum 0 and any subsequent stratum, Stratum 0 wins unconditionally.

### Stratum 1: Verified Audit Defect Ledger and Forensic Notes

This stratum contains the authoritative defect catalogs, source audits, and physical environment notes. It documents confirmed runtime exceptions, path resolution omissions, configuration drift, and test failures. Stratum 1 provides the empirical basis for defect isolation and repair planning, serving as a forensic overlay directly on the physical codebase.

### Stratum 2: Supreme Architectural and Curriculum Specifications

This stratum includes the master project specification, the thirty-module curriculum syllabus, the deep-dive module architectures, the compiler multi-target blueprint, and the canonical architecture decision records. These documents define the authoritative design rules, structural invariants, and pedagogical sequences that govern the evolution of the project.

### Stratum 3: Curated Systems Research and Technical Standards

This stratum comprises peer-reviewed engineering texts, language reference manuals, compiler construction handbooks, formal network protocols, digital signal processing standards, and security whitepapers. It supplies the formal mechanics, algorithms, and design patterns referenced by the curriculum.

### Stratum 4: Engineering Design Transcripts and Evolution Logs

This stratum contains conversational transcripts, design deliberations, and historical rationale recorded during development. These materials document the background reasoning and alternatives evaluated during system evolution, but they remain non-normative and cannot override specifications or physical code.

## 3. Structured Search Queries and Retrieval Logic

To satisfy the four secondary research questions defined in the Frame Stage, queries are formulated as structured Boolean expressions targeting specific technical mechanisms. These queries systematically interrogate the strata, extracting evidence without introducing narrative noise.

The queries isolate exact syntax, variable names, and error signatures across the repository files.

### Query Set 1: Hermetic Confinement and Package Path Shims

This query targets the mechanism by which the package manager substrate isolates binary installations and exposes executable shims to the environment without contaminating host registries.

```text
("installer_scoop.ps1" OR "pkg/scoop.nu") AND ("# clause-scoop-patches: 1" OR "Set-EnvVar") AND ("shims" OR "CLAUSE_BIN_DIR") AND ("n01-scoop-path-audit")
```

### Query Set 2: Toolchain Isolation and Build Artifact Redirection

This query investigates whether build toolchains, specifically the Rust compiler and Cargo package manager, redirect compilation caches and home directories into the hermetic jail.

```text
("20-toolchains.toml" OR "config/env") AND ("CARGO_HOME" OR "RUSTUP_HOME") AND ("CLAUSE_DATA_DIR" OR "host pollution") AND ("packages/clause" OR "cxc")
```

### Query Set 3: Multi-Target Compiler Backends and Dual-Plane Execution

This query probes the architectural division between native Rust compilation for digital signal processing and Erlang/OTP compilation for distributed actor supervision.

```text
("packages/clause" OR "cxc" OR "seaxc") AND ("--target rust" OR "transcc" OR "backend/rust.rs") AND ("--target beam" OR "packages/clause_jet") AND ("@external(rust" OR "tools/ring")
```

### Query Set 4: Domain Purity and Canonical Lexicon Boundaries

This query verifies whether the compiler standard library syntax strictly adheres to the approved operational pillars or contains generic commercial vertical drift.

```text
("ADR 0007" OR "06-clause-cxc-gleam-refactoring-multi-target-blueprint.md") AND ("9 canonical" OR "pillars") AND ("commercial cartridges" OR "anti-keywords" OR "bakery" OR "healthcare")
```

## 4. Primary Seed Source Inventory

The seed inventory identifies the foundational documents that anchor the research protocol. These sources provide the authoritative baseline for all downstream verification, extraction, and synthesis activities.

Each seed source is mapped to its evidentiary stratum, functional domain, and technical contribution.

| Seed Identifier | Canonical Source Document | Evidentiary Stratum | Functional Domain | Technical Contribution |
| :--- | :--- | :--- | :--- | :--- |
| S-01 | Complete Source and Architecture Bundle (`06-clauseos-source-bundle.md`) | Stratum 0 | Systems Substrate | Ground-truth code snapshot containing all bootloaders, manifests, and scripts. |
| S-02 | Source Bundle Audit Report (`05-source-bundle-audit-report.md`) | Stratum 1 | Quality Assurance | Authoritative catalog of the seven documented codebase defects. |
| S-03 | Master Project Specification (`00-PROJECT-SPECIFICATION-v3.0.md`) | Stratum 2 | Quad Model Architecture | Governs the thirty curriculum modules, enterprise patterns, and domain competencies. |
| S-04 | Gleam Compiler Multi-Target Blueprint (`docs/ccefs/06-clause-cxc...`) | Stratum 2 | Language Engineering | Defines the compiler fork, AST lowers, and multi-target code generators. |
| S-05 | Document Synchronization Plan (`docs/ccefs/07-clauseos-document...`) | Stratum 2 | Documentation Parity | Maps specification drift and details the three-batch remediation strategy. |
| S-06 | Hermetic State Confinement Record (`docs/adr/adr_001...`) | Stratum 2 | Security and Isolation | Enforces userland directory redirection and host operating system isolation. |
| S-07 | Cross-Shell Environment Record (`docs/adr/adr_004...`) | Stratum 2 | Shell Architecture | Codifies the eight-pass iterative symbol expansion engine for environment manifests. |
| S-08 | Language and Agent Pattern Record (`docs/adr/adr_011...`) | Stratum 2 | Language Design | Establishes the agent directory pattern and execution runtime divisions. |
| S-09 | Native Bridge Integration Record (`docs/adr/adr_012...`) | Stratum 2 | Systems FFI | Specifies type-safe native integration between Rust libraries and the BEAM runtime. |
| S-10 | Parser Construction Foundation (`k01-writing-an-interpreter-in-go.pdf`) | Stratum 3 | Compiler Design | Provides the theoretical basis for Pratt parsing and AST macro expansion. |
| S-11 | Bytecode Machine Foundation (`k03-writing-a-compiler-in-go.pdf`) | Stratum 3 | Virtual Machines | Governs symbol resolution, stack machines, and bytecode emission. |
| S-12 | Distributed Orchestration Foundation (`k04-build-an-orchestrator-in-go.pdf`) | Stratum 3 | Distributed Systems | Informs task finite-state machines and worker node scheduling. |
| S-13 | Agent Harness Foundations (`r01` through `r22`) | Stratum 3 | AI Harnesses | Details context compaction, subagent dispatch, and tool-call loops. |
| S-14 | Forensic Path Audit Note (`n01-scoop-path-audit`) | Stratum 1 | Substrate Audit | Identifies the physical omission of Scoop executable shims from the shell PATH. |

## 5. Citation Chains and Network Traversal

The validity of the architecture depends upon unbroken citation chains linking theoretical foundations to empirical implementations. Traversal across upstream dependencies and downstream consumers confirms that no architectural layer operates in isolation.

The dependency graph below maps the relationships connecting low-level userland confinement to high-level multi-target compilation and distributed execution.

### Upstream Foundations

The compiler architecture derives its type inference and structural scanner from the Gleam compiler core, which provides a production-tested Hindley-Milner type system. Syntactic macro systems and recursive descent parsing patterns trace directly to Thorsten Ball's interpreter and compiler engineering methodologies. Task orchestration models build upon Tim Boring's distributed worker state machines.

### Primary Architectural Synthesis

The Gleam compiler fork, housed within the clause package, serves as the unifying synthesis layer. It ingests source files written in Clause and performs front-end semantic validation, symbol resolution, and type checking. Syntax extensions capture the nine operational pillars, providing structured language primitives for infrastructure, telecom, media, and autonomous agents.

### Downstream Execution Targets

Compilation branches into three discrete runtime targets:

1. Native Systems Data Plane: Compiled via `--target rust`, lowering high-throughput digital signal processing, lock-free ring buffers, audio plugins, and native cloud graphs directly into Cargo crates.
2. Distributed Control Plane: Compiled via `--target beam`, lowering signaling state machines, softswitch routing, telecom trunking, and autonomous agent supervision into Erlang/OTP release packages.
3. Client Presentation Tier: Compiled via `--target client`, lowering visual surfaces, flight decks, and master control interfaces into web, desktop, and terminal runtimes.

Cross-runtime data exchange between the Erlang control plane and native Rust libraries is mediated by the RinG bridge, which automatically synthesizes dirty-scheduler native interface functions to prevent real-time signal processing from blocking actor reductions.

## 6. Grey Literature and Engineering Transcripts

Engineering deliberations recorded across fifty-one design transcripts provide vital operational context explaining why specific architectural pathways were adopted and others discarded. Reviewing this grey literature resolves ambiguities that are not fully detailed in the formal specifications.

The query log below extracts the key evidentiary findings established during past technical investigations.

| Query Reference | Source Transcript | Evidentiary Finding Extracted | Architectural Impact |
| :--- | :--- | :--- | :--- |
| Gleam Fork Evaluation | `d48-gleam-to-clause-forking` | Evaluated greenfield compiler construction against forking the Gleam codebase. Unanimously adopted forking Gleam inside the clause package to inherit mature type inference and focus engineering resources on multi-target emitters. | Formally supersedes the greenfield compiler implementation described in early curriculum specifications. |
| Specification Decoupling | `d38-AIDSL-v2.4.0-specification-evaluation` | Confirmed that language parsing and abstract syntax tree structures should remain strictly decoupled from codegen backends, enabling clean polyglot emission. | Validates the pluggable backend emitter design inside the compiler core. |
| Transmedia Engine Hierarchy | `d04-hermetic-transmedia-engine-architecture` | Established the four-tier architectural model spanning carrier backplanes, Erlang control runtimes, native engines, and grounded local storage. | Defined the structural relationship between `clause_jet`, the compiler, and local repository storage. |
| Hypervisor GPU Limitations | `d13-strix-halo-hyper-v -limitations` | Proved that default Windows Hyper-V configurations block direct access to neural processing units and unified memory. Mandated ephemeral micro-virtual machines with native device passthrough. | Enforces the architectural requirements for virtual machine orchestration under ADR 0006. |
| Package Path Audit | `n01-scoop-path-audit` | Audited physical package installations on Windows NT. Proved that while package manager scripts prevent registry pollution, they fail to expose installed binary shims to the default shell path. | Establishes an active substrate defect requiring immediate remediation in environment manifests. |
| Document Synchronization | `07-clauseos-document-tree-synchronization-plan` | Cataloged discrepancies between curriculum documents and live code files. Established the three-batch surgical patch plan. | Replaces wholesale file overwrites with granular, non-destructive diff updates. |

## 7. Saturation Records and Deliberate Falsification

Research saturation is achieved when repetitive queries across all evidential strata produce consistent findings without uncovering contradictory mechanisms. Saturation confirms that the boundaries of the system are fully understood.

To validate saturation, deliberate falsification probes were executed against the primary technical claims.

| Research Question Area | Saturation Level | Evidentiary Status | Convergence Finding |
| :--- | :--- | :--- | :--- |
| Userland Confinement and Binary Shims | Saturated | Defect Isolated | Repository code and audit notes confirm that package shims are omitted from the active path. |
| Toolchain Isolation and Build Dirt | Saturated | Remediation Defined | Manifests lack Cargo home redirection, permitting build dirt unless patched. |
| Multi-Target Compilation Feasibility | Saturated | Architecture Confirmed | Compiler blueprints and transcripts confirm that forking Gleam provides the optimal multi-target path. |
| Domain Purity and Canonical Pillars | Saturated | Redline Enforced | Architecture decision records and blueprints explicitly exclude generic commercial verticals. |

### Falsification Probe 1: Upstream Maintenance Tax on Compiler Fork

The hypothesis that forking the Gleam compiler creates an unsustainable upstream maintenance burden was subjected to adversarial scrutiny. Review of the implementation blueprint demonstrates that the fork isolates all custom extensions into dedicated AST lower modules, brand identifiers, and backend emitters. Core type checker files and parser spans remain aligned with upstream patterns, allowing the compiler to cleanly ingest upstream language updates and Hex ecosystem packages. The hypothesis of an unmanageable maintenance burden is falsified.

### Falsification Probe 2: Scheduler Starvation from Native DSP Buffers

The hypothesis that executing digital signal processing within a dual-plane architecture risks starving the Erlang actor scheduler was evaluated against real-time performance bounds. Evidence from the architecture decision records demonstrates that heavy media processing never executes within standard BEAM reduction loops. High-throughput audio buffers compile directly to native Rust via the studio pillar, communicating with actors exclusively through dirty-scheduler native interface functions or isolated distribution nodes. The hypothesis of scheduler starvation is falsified.

### Falsification Probe 3: Registry Leakage from Windows Package Management

The hypothesis that package manager operations inevitably write state to the Windows NT registry was tested against physical installation scripts. Examination of the package installation routines confirms that environment variable setters and shortcut creators are explicitly stubbed with no-op functions. Package installations write exclusively to the isolated project directory. The hypothesis of inevitable registry leakage is falsified, confirming that the remaining issue is purely one of path visibility.

## 8. Preserved Protocol Status

The parameters, vocabulary mappings, database routes, seed directories, citation networks, and falsification records compiled in this protocol represent the complete evidential foundation for the Gather Stage.

All technical criteria established herein remain locked and preserved for downstream verification and execution.
