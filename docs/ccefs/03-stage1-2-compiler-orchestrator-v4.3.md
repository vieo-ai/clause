# CCEFS Stages 1 & 2: Clause Compiler (`cxc`), Distributed Orchestrator & Native Pulumi IaC (Modules 1–10 — v4.3)

> **Document Status:** Supreme Architectural Specification (Tier 2 SSOT)  
> **Parent Steward:** Vieo (`vieo-ai`)  
> **Substrate:** ClauseOS (`clause` / `cx`)  
> **Default Language:** Clause (`.cx`) | **Compiler CLI:** `cxc` (`packages/clause/`)  
> **Control Plane:** `clause_jet` (`packages/clause_jet/` on Erlang/OTP 29)  
> **Reading Order (`docs/ccefs/`):** `00-PROJECT-SPECIFICATION-v3.0.md` $\rightarrow$ `01-ccefs-30-modules-v4.3.md` $\rightarrow$ `02-stage0-foundation-modules-v4.3.md` *(Stage 0)* $\rightarrow$ **`03-stage1-2-compiler-orchestrator-v4.3.md` *(Stages 1–2)*** $\rightarrow$ `04-vieo-ai-curriculum-portal.md` *(4-Track Portal)*

With the bare-metal userland sealed inside `.home/` (`Stage 0: Modules 0.1–0.5`), **Stage 1 (Modules 1–5)** constructs the **Clause (`.cx`)** compiler via the **`cxc`** Gleam compiler fork inside `${CLAUSE_BIN_DIR}`, and **Stage 2 (Modules 6–10)** constructs ClauseOS's distributed cluster orchestrator (`Task → Worker → Manager → Scheduler`), HashiStack control plane, bare-metal MaaS netbooter, and native `crates/clause-pulumi` infrastructure engine.

---

## **Stage 1: Building the Clause (`.cx`) Language & `cxc` Multi-Target Compiler Inside `.home/` (Modules 1–5)**

* **Gleam Fork Base**: `gleam-lang/gleam` compiler-core in Rust (`packages/clause/crates/*`), `i2y/jet` (`[c04]`), Thorsten Ball (`[c01]`, `[c01-lost]`, `[c02]`), Mark Sibley's *Monkey X (`transcc`)* (`[c05]`), and revived `andrzejressel/pulumi-gestalt` (`[c06]` `crates/clause-pulumi/`) (`ADR 0011`, `ADR 0012`)
* **Transpiler & Ecosystem Base**: Mark Sibley's *Monkey X (`transcc`)* multi-target codegen (`Target::Rust`, `Target::Beam`, `Target::Client`), direct `@external(rust, ...)` crate linking, and automatic `tools/ring` DirtyScheduler FFI synthesis (`ADR 0012`).
* **Shared Concept**: Constructing the **Clause (`.cx`)** compiler and toolchain by forking `gleam-lang/gleam` inside `packages/clause/` (`cxc`), preserving 100% of Gleam's Hindley-Milner type inference, algebraic data types, and pipe operator (`|>`), while adding Logos tokenization for Tier 1 declaration keywords, static domain verification passes, and Monkey-X multi-target emitters (`--target rust`, `--target beam`, `--target client`) so one `.cx` file compiles directly to **Pure Native Rust (`oximedia` / `nih-plug` / `Craft` / `crates/clause-pulumi`)**, **BEAM (`packages/clause_jet` on Erlang/OTP 29 with automated `tools/ring` NIF synthesis)**, and **Client (`Lustre` / `Plushie` / `Shore` / `O2K`)**.

### **Module Breakdown (Modules 1–5)**

* **Module 1 — Upstream-Clean Gleam Core Extraction & Branding Constants (`packages/clause/crates/*`, `brand.rs` — `[c01]`, `[c04]`, `d48`, `ADR 0011`):**
  * Extracts `compiler-core`, `compiler-cli`, `language-server`, and `compiler-wasm` into `packages/clause/crates/{clause-core,clause-cli,clause-lsp,clause-wasm,clause-runtime}`, implementing `brand.rs` defining `LANG_NAME = "Clause"`, `BIN_NAME = "cxc"`, `FILE_EXT = "cx"`, `MANIFEST_FILE = "clause.toml"`, and `ARTEFACT_DIR = "_clause_artefacts"`, while anchoring Cargo and Rustup caches to `${CLAUSE_DATA_DIR}/cargo` and `${CLAUSE_DATA_DIR}/rustup` via `config/env/20-toolchains.toml` to guarantee zero host directory pollution during compiler builds.
* **Module 2 — Nine-Pillar Grammar Extensions & AST Token Spans (`clause-core/src/parse/` — `[c01]` Ch. 2, `[c04]`, `d48`, `ADR 0011`):**
  * Table-driven Logos scanner and Pratt/recursive-descent parser recognizing Tier 1 top-level declarative block keywords (`kernel`, `service_provider`, `infra`, `provider`, `agent`, `gateway`, `trunk`, `bridge`, `dialplan`, `bus`, `rack`, `patchbay`, `split`, `stage`, `mcr`, `headend`, `airgap`, `sortie`) alongside Tier 2 contextual clauses (`@hangar`, `@airgap`, `@needs`, `@squawk`, `bridge`, `expose -> Schema`), preserving full span tracking and AST error recovery for directory-packaged agents (`agent.cx`, `team/`, `skills/`, `mcp/`, root `apm.yml`, `clause.toml`).
* **Module 3 — Static Domain Verification Passes (`clause-core/src/analyse/` — `[c01]` Ch. 3, `[c01-lost]` Ch. 5, `[c04]`, `ADR 0007`, `ADR 0011`):**
  * Augments Hindley-Milner type inference with domain-specific static passes: enforcing 100% split rights verification (`split TrackRights` summing to 100.0% + ISRC/IPI before `master.bounce`), audio bus/rack sample-rate and channel parity, `@airgap(emcon: LocalOnly)` static egress isolation, and compile-time `@needs`/`platform` capability checking (`Landlock`/`Seatbelt`) before code generation runs.
* **Module 4 — Monkey-X Multi-Target Codegen: `--target rust` (`clause-core/src/backend/rust.rs`, `clause-runtime` — `[c02]`, `[c05]`, `d48`, `ADR 0011`):**
  * Lowers type-checked ASTs into borrow-checker-safe native Rust crates (`Arc<T>` / `bytes::Bytes` uniform value representation): compiles `bus`/`rack` onto zero-allocation `oximedia` and `nih-plug` (CLAP/VST3) audio threads, `infra` onto `crates/clause-pulumi`, and handles `@external(rust, "crate::mod", "fn")` direct crate imports with zero heap allocations, zero IPC sockets, and zero FFI serialization overhead.
* **Module 5 — Monkey-X Multi-Target Codegen: `--target beam` & `--target client` (`backend/erlang.rs`, `backend/javascript.rs`, `clause-cli` — `[c02]`, `[c05]`, `d48`, `ADR 0011`, `ADR 0012`):**
  * **`--target beam` (Carrier Control Plane):** Lowers `.cx` agent and telecom declarations into Core Erlang / `.beam` bytecode executed by `packages/clause_jet` over Erlang/OTP 29, automatically synthesizing `tools/ring` DirtyScheduler NIF shims for `@external(rust, ...)` functions (`ADR 0012`).
  * **`--target client` (Touch Glass & Flight Deck):** Emits TypeScript / WebAssembly (`clause-wasm`) powering `Lustre` (Web/SSR), `Plushie` (Native Desktop), `Shore` (TUI), and `O2K` touch glass, dropping `cxc` into `${CLAUSE_BIN_DIR}`.

### **Laravel Component Adoption & Quad Model (Stage 1)**

* **Laravel Component Adoption & Target Primitives**:
  * **Target Primitives**: `IClauseCompiler`, `IMacroExpander`, `ISymbolResolver`, `IMultiTargetCodegen`, `IInfraProvider`
  * **Created Components**: `reflection` (`SymbolTable` & `clause-core` AST trait resolver), `json-schema` (`schema` & `jet_sap` Schema-Aligned Parsing emitter).
  * **Consumed Components**: `container` (`platform` / `provide` IoC dependency wiring), `auth` (`@needs` compile-time capability enforcement), `macroable` (compile-time AST extension system), `testing` (`cargo test --offline` compiler/VM golden tests).
* **Quad Model Mechanics**:
  * **Fowler / Clean Arch**: Separated Interface (target-agnostic Clause IR decoupled from `rust`, `beam`, and `client` codegen backends), Plugin (pluggable target emitters and native media crate bindings).
  * **GoF**: Interpreter / Visitor (recursive AST traversal in `analyse`, `clause_lower`, and `backend/*`), Builder (incremental bytecode/IR emission with jump back-patching), Strategy (multi-target codegen backends `transcc` style), Composite (nested AST expressions, statements, and lexical scopes).
  * **Otwell**: Expressive Fluent Chaining (`|>`), "The Language Is the Framework" zero-boilerplate `agent`/`tool`/`compact`/`gateway`/`dsp`/`infra` declarations.
  * **Storer / Systems Discipline**: Uniform Immutable Value Representation (`i64`/`f64`/`bool` Copy types + `Arc<str>`/`bytes::Bytes`/`Arc<Enum>` zero-copy handles in emitted Rust), Zero-Allocation Real-Time Audio/Video DSP Callbacks, and Deterministic Bytecode Disassembly (`Instructions.String()`).

---

## **Stage 2: Distributed Orchestrator, Micro-VMs & Native Pulumi IaC (Modules 6–10)**

* **Tim Boring Base**: *Build an Orchestrator in Go (From Scratch)* (`[c03]`, Chapters 1–13: `Task`, `TaskEvent`, `Worker`, `Manager`, `Scheduler` [`RoundRobin` & `E-PVM`], `Store` [`InMemory` & `BoltDB`], REST API, Health Checks, `Cobra` CLI)
* **ClauseOS & Pulumi Base**: `ops/config/{nomad,consul,vault}.hcl`, `cx vm` (WSL2 / Lima), `Pixiecore` + `Packer` MaaS, and revived `andrzejressel/pulumi-gestalt` (`crates/clause-pulumi/`) (`[c06]`, `ADR 0006`, `ADR 0010`, `ADR 0011`)
* **Agent Harness Equivalent**: `r15` Ch. 10 (7-Type 5-Status Task State Machine), `r20` Ch. 10 (`ResourceAwareOrchestrator`), `b21` Ch. 8 & 10 (DAG Scheduling & Operational Lifecycle)
* **Shared Concept**: Stripping away black-box container magic by building the five fundamental primitives of every cluster orchestrator (`Task`, `Worker`, `Manager`, `Scheduler`, `Store`) from scratch in Rust (`Ractor`/`Spawned` OTP actors in `clause_jet`) and wiring them directly to HashiStack (`Nomad`, `Consul`, `Vault`), `cx vm` micro-instances, `Pixiecore`/`Packer` bare-metal netbooting, and native `crates/clause-pulumi` cloud bursting.

### **Module Breakdown (Modules 6–10)**

* **Module 6 — Orchestrator Core: `Task → Worker → Manager → Scheduler` (`[c03]` Ch. 1–9):**
  * **Task 5-State Lifecycle & Transition Matrix (`[c03]` Ch. 2–4):** Models every workload (Docker container, Nomad `raw_exec` agent, `cx vm` micro-instance, or DSP render job) as a `Task` (`ID`, `ContainerID`, `Name`, `State`, `Image`, `Cpu`, `Memory`, `Disk`, `ExposedPorts`, `PortBindings`, `RestartPolicy`, `HealthCheck`, `RestartCount`, `StartTime`, `FinishTime`) driven by `TaskEvent` state triggers through a validated finite state machine (`Pending` $\rightarrow$ `Scheduled` $\rightarrow$ `Running` $\rightarrow$ `Completed` | `Failed`, enforced via `stateTransitionMap` and `ValidStateTransition(src, dst)`).
  * **Worker Execution Engine, FIFO Queue & `/proc` Telemetry (`[c03]` Ch. 4–6):** Each `Worker` owns an inbound FIFO `Queue` (desired state), a `Store` (current state), a runtime driver (`Docker` / `Nomad` / `cx vm`), and a periodic `CollectStats()` loop reading CPU (`idle` vs `nonIdle` delta percentage), `MemTotal`/`MemAvailable`, `DiskTotal`/`DiskFree`, and `LoadAvg`—exposed via REST/RPC endpoints (`GET /tasks`, `POST /tasks`, `DELETE /tasks/{taskID}`, `GET /stats`).
  * **Manager Control Plane, Reconciliation Loop & Active Health Checks (`[c03]` Ch. 7–9):** The `Manager` maintains cluster-wide `TaskDb`, `EventDb`, `WorkerNodes`, `WorkerTaskMap`, and `TaskWorkerMap` (`[c03]` Ch. 10.6 duplicate-stop bug fix: checking `TaskWorkerMap` before scheduling new work), running `ProcessTasks()`, `UpdateTasks()`, and `DoHealthChecks()` (polling `/health` and restarting up to `RestartCount < 3`).
* **Module 7 — Borg E-PVM Resource-Aware Scheduler & Persistent `Store` (`[c03]` Ch. 10–12):**
  * Separates scheduling into a 3-phase interface (`SelectCandidateNodes` feasibility filter $\rightarrow$ `Score` $\rightarrow$ `Pick`), implementing both `RoundRobin` and Google Borg's **Enhanced Parallel Virtual Machine (E-PVM)** marginal opportunity-cost scheduler (`LIEB = 1.53960071783900203869`, computing `memCost + cpuCost` marginal load deltas across cluster nodes) extended with ClauseOS GPU VRAM / NPU accelerator scoring (`ADR 0003`), backed by embedded persistent SQLite WAL / BoltDB `TaskStore` & `EventStore` and `cx` CLI subcommands (`worker`, `manager`, `run`, `stop`, `status`, `node`).
* **Module 8 — HashiStack Control Plane (`Nomad`, `Consul`, `Vault`) & Cross-Platform Micro-VMs (`cx vm` — `ADR 0006`, `ADR 0010`):**
  * Confines `Nomad` (`raw_exec`), `Consul` (SWIM mesh & DNS), and `Vault` (dynamic secret leases) inside `$CLAUSE_HOME/.local/share/`, and wraps `wsl.exe` / `limactl` under `cx vm` (`launch`, `exec`, `shell`, `list`, `stop`, `purge`) for ephemeral `k3s` and Linux-kernel guests.
* **Module 9 — Bare Metal as a Service (`Pixiecore` + `Packer` iPXE Netbooting — `ADR 0010`):**
  * Compiles deterministic in-memory golden rootfs images with `Packer` and drives API-controlled DHCP/TFTP/HTTP iPXE netboots via `Pixiecore` against Consul machine inventories.
* **Module 10 — Native `infra` Keyword & Revived `clause-pulumi` (`crates/clause-pulumi` / `clause_jet` — `[c06]`, `ADR 0010`, `ADR 0011`):**
  * Adopts and maintains `andrzejressel/pulumi-gestalt` inside the Rust workspace (`crates/clause-pulumi/`) with prominent attribution to Andrzej Ressel so Clause `infra` blocks compile to native, YAML-free Pulumi resource graphs (`cx cloud up` / `cx cloud detach`) for air-gapped cloud bursting.

### **Laravel Component Adoption & Quad Model (Stage 2)**

* **Laravel Component Adoption & Target Primitives**:
  * **Target Primitives**: `IOrchestratorManager`, `IWorkerNode`, `IScheduler`, `IWorkloadStore`, `IVirtualMachineDriver`, `ICloudBurstEngine`
  * **Created Components**: `queue` (`Pending` & worker FIFO task queues), `database` (Persistent `TaskStore` & `EventStore`), `process` (Container/Nomad/VM runtime drivers), `concurrency` (Concurrent manager reconciliation & health-check loops).
  * **Consumed Components**: `http` (Worker/Manager REST & RPC endpoints), `routing` (`/tasks`, `/stats`, `/nodes`), `encryption` (Vault token leases), `console` (`cx vm` & cluster CLI commands).
* **Quad Model Mechanics**:
  * **Fowler / Clean Arch**: Control Plane vs. Data Plane separation (`Manager` administrative state vs. `Worker` execution), Repository (`Store` interface decoupling domain structs from BoltDB/SQLite), Data Transfer Object (`TaskEvent` & `DockerResult`).
  * **GoF**: Strategy (pluggable `Scheduler` implementations: `RoundRobin` vs. `E-PVM`), State (explicit `stateTransitionMap` task finite state machine), Facade (`Manager` API hiding multi-worker placement from CLI users), Command (`TaskEvent` encapsulating start/stop state transitions).
  * **Otwell**: Clean Resource Routing (`/tasks`, `/tasks/{taskID}`, `/stats`, `/nodes`), Expressive CLI Subcommands (`worker`, `manager`, `run`, `stop`, `status`, `node`).
  * **Storer / Systems Discipline**: Authoritative Worker Reconciliation (workers own ground-truth container/process state; manager reconciles periodically without blocking), Bounded Restart Circuit Breakers (`RestartCount < 3`).
