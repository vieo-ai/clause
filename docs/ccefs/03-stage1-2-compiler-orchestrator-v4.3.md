# CCEFS Stages 1 & 2: Seax Compiler (`seaxc`), Distributed Orchestrator & Pulumi IaC (Modules 1–10 — v4.3)

> **Reading Order (`docs/ccefs/`):** `00-PROJECT-SPECIFICATION-v3.0.md` $\rightarrow$ `01-ccefs-30-modules-v4.3.md` $\rightarrow$ `02-stage0-foundation-modules-v4.3.md` *(Stage 0)* $\rightarrow$ **`03-stage1-2-compiler-orchestrator-v4.3.md` *(Stages 1–2)*** $\rightarrow$ `04-vieo-ai-curriculum-portal.md` *(4-Track Portal)*

With the bare-metal userland sealed inside `.home/` (`Stage 0: Modules 0.1–0.5`), **Stage 1 (Modules 1–5)** constructs the **Seax (`seaxc`, `.cx`)** compiler and embedded bytecode VM inside `$CLAUSE_BIN_DIR`, and **Stage 2 (Modules 6–10)** constructs ClauseOS's distributed cluster orchestrator (`Task → Worker → Manager → Scheduler`), HashiStack control plane, bare-metal MaaS netbooter, and native `pulumi-gestalt` infrastructure engine.

---

## **Stage 1: Building the Seax (`.cx`) Language & Multi-Target Compiler Inside `.home/` (Modules 1–5)**

* **Thorsten Ball Base**: *Writing An Interpreter In Go* (`[c01]`, Ch. 1–4: Lexer, Pratt Parser, AST, Evaluator, Objects, `HashKey`), *The Lost Chapter: A Macro System For Monkey* (`[c01-lost]`, Ch. 5: `quote`, `unquote`, `ast.Modify`, `DefineMacros`, `ExpandMacros`), *Writing A Compiler In Go* (`[c02]`, Ch. 1–10: Bytecode `code.Make`/`ReadOperands`, Stack VM, Jump Back-Patching `changeOperand`, `SymbolTable` scopes [`Global`, `Local`, `Builtin`, `Free`, `Function`], Call `Frame`s, `OpClosure` & `OpCurrentClosure`)
* **Transpiler & Ecosystem Base**: Mark Sibley's *Monkey X (`transcc`)* (`[c05]`), `i2y/jet` (`[c04]` `agent`/`actor`/`needs`/`platform`/`jet_sap`), and revived `andrzejressel/pulumi-gestalt` (`[c06]` `crates/clause-pulumi/`) (`ADR 0011`, `ADR 0012`)
* **Shared Concept**: Building the **Seax (`seaxc`, `.cx`)** compiler in Rust using Thorsten Ball's exact textbook pipeline—extended with syntactic AST macros (`[c01-lost]`), Jet's capability/schema contracts (`[c04]`), and Mark Sibley's Monkey X (`transcc`) multi-target code generation (`[c05]`)—so one Dart-flavored source file compiles directly to **Pure Rust (`Ractor`/`Spawned` OTP actors + `Craft`/`oximedia`/`nih-plug` + revived `pulumi-gestalt`)**, **BEAM (`Core Erlang` / `Glimr` interop)**, and **Client (`TypeScript`/`Wasm` / `Flutter`)**.

### **Module Breakdown (Modules 1–5)**

* **Module 1 — Single-Pass Lexer & Token Spans (`crates/seax-token`, `crates/seax-lexer` — `[c01]` Ch. 1):**
  * Zero-copy `&str` scanner with `position`/`readPosition`/`peekChar` tracking line/column spans, tokenizing Dart-style C-family syntax (`{ }`, `( )`, `[ ]`, `..` cascades, `->`, `async`/`await`, `schema`, `switch`) alongside first-class **agent/harness keywords** (`agent`, `skill`, `tool`, `memory`, `compact`, `gateway`, `channel`, `heartbeat`), **transmedia keywords** (`audio`, `video`, `midi`, `ndi`, `osc`, `smpte`, `dante`, `dsp`), **carrier keywords** (`actor`, `pipeline`, `telcom`, `broadcast`, `infra`), and **capability keywords** (`needs`, `platform`, `provide`, `expose`).
* **Module 2 — Pratt Expression & Recursive-Descent Block Parser (`crates/seax-ast`, `crates/seax-parser` — `[c01]` Ch. 2):**
  * Top-Down Operator Precedence parser mapping `prefixParseFn` (`nud`) and `infixParseFn` (`led`) across binding power levels (`LOWEST` $\rightarrow$ `EQUALS` $\rightarrow$ `LESSGREATER` $\rightarrow$ `SUM` $\rightarrow$ `PRODUCT` $\rightarrow$ `PREFIX` $\rightarrow$ `CASCADE` `..` $\rightarrow$ `CALL` $\rightarrow$ `INDEX`), paired with recursive-descent declarations (`AgentDecl`, `ActorDecl`, `ToolDecl`, `GatewayDecl`, `PipelineDecl`, `DspDecl`, `InfraDecl`, `SchemaDecl`, `PlatformDecl`) and non-halting error recovery (`expectPeek` / `peekError`).
* **Module 3 — Syntactic AST Macro Expansion & Multi-File Contract/Capability Checker (`crates/seax-macro`, `crates/seax-checker` — `[c01]` Ch. 3 + `[c01-lost]` Ch. 5 + `[c04]`):**
  * Implements code-as-data `quote` / `unquote` and generic recursive AST rewriting (`ast.Modify(node, ModifierFunc)`), extracting compile-time `macro` definitions (`DefineMacros`) and expanding DSL/platform macros (`ExpandMacros`, e.g., `#if TARGET == "rust"` vs `"beam"`) before walking all parsed project ASTs (including "Agent is a Directory" manifests `agent.cx`, `team/`, `skills/`, `mcp/`, `package.seax`) to enforce `expose ... -> Schema` contracts, exhaustive `switch` arms, `oximedia`/`nih-plug` audio/video sample-rate & channel contracts, and compile-time `needs` / `platform` hermetic capability isolation.
* **Module 4 — Recursive Symbol Table, Closure Capture & Embedded Bytecode VM (`crates/seax-symbol`, `crates/seax-vm` — `[c02]` Ch. 1–10):**
  * Resolves bindings across `GlobalScope`, `LocalScope`, `BuiltinScope`, `FreeScope` (capturing free variables for closures), and `FunctionScope` (self-referencing recursive closures via `OpCurrentClosure`), using single-pass jump back-patching (`changeOperand`) and stack-frame base pointers (`Frame`) for Seax's fast embedded bytecode REPL/scripting VM (`seax eval`) alongside the lowered multi-target IR.
* **Module 5 — Monkey X (`transcc`) Multi-Target Emitters & Self-Hosting in `.home/` (`crates/seax-codegen`, `seax-cli` — `[c05]` + `[c06]` + `ADR 0011`):**
  * **`--target rust` (Primary Native Engine):** Emits borrow-checker-safe Rust (`Arc<T>` / `bytes::Bytes` uniform value representation) lowering `agent`/`actor`/`pipeline` onto **Ractor / Spawned** OTP supervision trees, `dsp` blocks onto zero-allocation **`oximedia` / `nih-plug`** threads and **`vendor/craft/*`** subtrees, and `infra` blocks onto **revived `pulumi-gestalt`** (`crates/clause-pulumi/`) for native YAML-free infrastructure provisioning.
  * **`--target beam` (Distributed Mesh & Glimr Interop):** Emits Core Erlang / `.beam` bytecode (and speaks native Erlang Distribution `erl_dist` / `Joerl`) for multi-node BEAM clusters and Gleam (`Glimr`) services.
  * **`--target client` (Touch Glass & Field Mobile):** Emits TypeScript / WebAssembly and `flutter_rust_bridge` bindings for browser consoles and iOS/Android companion apps, installing `seaxc`, `air`, and `jet` into `$CLAUSE_BIN_DIR`.

### **Laravel Component Adoption & Quad Model (Stage 1)**

* **Laravel Component Adoption & Target Primitives**:
  * **Target Primitives**: `ISeaxCompiler`, `IMacroExpander`, `ISymbolResolver`, `IMultiTargetCodegen`, `IInfraProvider`
  * **Created Components**: `reflection` (`SymbolTable` & `seax-checker` AST resolver), `json-schema` (`schema` & `jet_sap` Schema-Aligned Parsing emitter).
  * **Consumed Components**: `container` (`platform` / `provide` IoC dependency wiring), `auth` (`needs` compile-time capability enforcement), `macroable` (AST macro system), `testing` (`cargo test --offline` compiler/VM golden tests).
* **Quad Model Mechanics**:
  * **Fowler / Clean Arch**: Separated Interface (target-agnostic Seax IR decoupled from `rust`, `beam`, and `client` codegen backends), Plugin (pluggable target emitters and native media crate bindings).
  * **GoF**: Interpreter / Visitor (recursive AST traversal in `seax-macro`, `seax-checker`, and `seax-codegen`), Builder (incremental bytecode/IR emission with jump back-patching), Strategy (multi-target codegen backends `transcc` style), Composite (nested AST expressions, statements, and lexical `SymbolTable` scopes).
  * **Otwell**: Dart-Inspired Fluent Cascades (`buffer..deesser()..limiter()..render()`), "The Language Is the Framework" zero-boilerplate `agent`/`tool`/`compact`/`gateway`/`dsp`/`infra` declarations.
  * **Storer / Systems Discipline**: Uniform Immutable Value Representation (`i64`/`f64`/`bool` Copy types + `Arc<str>`/`bytes::Bytes`/`Arc<Enum>` zero-copy handles in emitted Rust), Zero-Allocation Real-Time Audio/Video DSP Callbacks, and Deterministic Bytecode Disassembly (`Instructions.String()`).

---

## **Stage 2: Distributed Orchestrator, Micro-VMs & Native Pulumi IaC (Modules 6–10)**

* **Tim Boring Base**: *Build an Orchestrator in Go (From Scratch)* (`[c03]`, Chapters 1–13: `Task`, `TaskEvent`, `Worker`, `Manager`, `Scheduler` [`RoundRobin` & `E-PVM`], `Store` [`InMemory` & `BoltDB`], REST API, Health Checks, `Cobra` CLI)
* **ClauseOS & Pulumi Base**: `ops/config/{nomad,consul,vault}.hcl`, `cx vm` (WSL2 / Lima), `Pixiecore` + `Packer` MaaS, and revived `andrzejressel/pulumi-gestalt` (`[c06]`, `ADR 0006`, `ADR 0010`, `ADR 0011`)
* **Agent Harness Equivalent**: `r15` Ch. 10 (7-Type 5-Status Task State Machine), `r20` Ch. 10 (`ResourceAwareOrchestrator`), `b21` Ch. 8 & 10 (DAG Scheduling & Operational Lifecycle)
* **Shared Concept**: Stripping away black-box container magic by building the five fundamental primitives of every cluster orchestrator (`Task`, `Worker`, `Manager`, `Scheduler`, `Store`) from scratch in Rust (`Ractor`/`Spawned` OTP actors) and wiring them directly to HashiStack (`Nomad`, `Consul`, `Vault`), `cx vm` micro-instances, `Pixiecore`/`Packer` bare-metal netbooting, and native `pulumi-gestalt` cloud bursting.

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
* **Module 10 — Native `infra` Keyword & Revived `pulumi-gestalt` (`crates/clause-pulumi` / `Jet` — `[c06]`, `ADR 0010`, `ADR 0011`):**
  * Adopts and maintains `andrzejressel/pulumi-gestalt` inside the Rust workspace (`crates/clause-pulumi/`) with prominent attribution to Andrzej Ressel so Seax `infra` blocks compile to native, YAML-free Pulumi resource graphs (`clause cloud up` / `clause cloud detach`) for air-gapped cloud bursting.

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
