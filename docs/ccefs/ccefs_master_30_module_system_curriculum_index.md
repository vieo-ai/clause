# CCEFS: Carrier-Class Engineering From Scratch — 30-Module Master System Curriculum (Version 4.0)

> **Evolution from v3.2 (`01-unified-agent-harness-24-modules-v3.2.md`) to v4.0:**
> In v3.2, Modules 1–24 specified the **Unified Agent Harness** in isolation. In **v4.0 (CCEFS)**, those 24 modules sit directly atop **Stage 0 (Modules 0.1–0.6)**—transforming the curriculum from a standalone agent harness into a complete **Carrier-Class Operating Environment, Compiler, Distributed Orchestrator, Transmedia Engine, and Autonomous Virtual Enterprise**.

---

## Complete 6-Stage / 30-Module Curriculum Map

### **Stage 0: The Hermetic Microkernel, AI Engineering Foundations, Orchestrator & Seax Carrier Substrate (Modules 0.1–0.6)**
*(Full specifications in `docs/ccefs/01-stage0-foundation-modules-v3.2.md`)*
* **Module 0.1:** Zero-Leak Profile Confinement & Stage 0 Trampolines (`cx.bat`, `cx.ps1`, `cx.sh`, `config/env/*.toml` 8-pass symbol compiler) `[f01, ADR-0001, ADR-0004]`
* **Module 0.2:** Three-Tier Toolchain Supply Chain (`Mise` Overlays `MISE_ENV="paths,ai,cloud"`, `plugins/cx-*` Lua Subtrees, In-Place Patched `Scoop`/`Brew`, `toml_pin.nu`) `[f02, ADR-0002]`
* **Module 0.3:** Dynamic 5-Way Hardware Acceleration Matrix (`CUDA`, `ROCm`, `XPU`, `MPS`, `CPU`) & Unified `$HF_HOME` Model Hub `[f03, ADR-0003, ADR-0005]`
* **Module 0.4:** Distributed Orchestrator Primitives (`Task → Worker → Manager → Scheduler` [`RoundRobin` & Borg `E-PVM`], `Store` [`InMemory` & `BoltDB`/SQLite]) & HashiStack (`Nomad`, `Consul`, `Vault`, `cx vm`, `Pixiecore` MaaS) `[c03, ADR-0006, ADR-0010]`
* **Module 0.5:** AIEFS (*AI Engineering From Scratch*, Vol. 1–6) — Grounded AI Engineering Foundations, Content-Addressed Storage & Deterministic State Vaults (`crates/seax-vfs`) `[e01–e06, ADR-0005, ADR-0008]`
* **Module 0.6:** Seax (`.cx`) Language Frontend, Pratt Parser, Syntactic AST Macros (`quote`/`unquote`/`ast.Modify`), Contract Checker & Monkey-X (`transcc`) Multi-Target Compiler (`seaxc` $\rightarrow$ `Ractor`/`Spawned` Rust + `Craft`/`oximedia`/`nih-plug` + Revived `pulumi-gestalt` | `BEAM`/`Glimr` | `Client`/`Wasm`) `[c01, c01-lost, c02, c04, c05, c06, ADR-0011, ADR-0012]`

---

### **Stage 1: Core Agent Foundation & Interactive Controls (Modules 1–5)**
*(Grounded on `seax-runtime` `Ractor`/BEAM actors, `seax-checker` `needs`/`platform` gates, and `config/env/*.toml`)*
* **Module 1:** Agent Core Loop & Execution Kernel (`while True` / `AsyncGenerator` turn loop, `<thinking>` channels, `Illuminate\Pipeline` middleware) `[r01–r22, b06–b21]`
* **Module 2:** Tool Execution & Dispatch Mapping (`IToolRegistry`, Schema-Aligned Parsing `jet_sap`, `DirtyCpu`/`DirtyIo` scheduler isolation, `mtime` safety guards) `[c04, r01–r22, ADR-0012]`
* **Module 3:** Session Persistence & Slash Commands (`SQLite WAL`, `journal.jsonl`, `/goal`, `/loop`, `/resume`, Nushell/Shore TUI) `[r01–r22, ADR-0004]`
* **Module 4:** Multi-Gate Permission Pipeline (`needs`/`platform` capability tokens + 2-Stage AST/SLM Classifier + OS Seatbelt/Bubblewrap/Landlock sandbox) `[r01–r22, t06, ADR-0011, ADR-0013]`
* **Module 5:** Non-Invasive Hook System (`PreToolUse`, `PostToolUse`, `ThoughtGenerated`, `SessionStart` event bus & Lua/Seax plugin hooks) `[r01–r22, a02]`

---

### **Stage 2: Context Management, Planning & Skill Loading (Modules 6–9)**
*(Grounded on `crates/seax-vfs` content-addressed spills, `SKILL.md` + "Agent is a Directory" manifests, and local SLM summarization)*
* **Module 6:** Todo Planning & In-Memory Task Lists (Structured plan state machines, `ArchitectTool`, Tree-of-Thoughts branching) `[r01–r22, b06, b13]`
* **Module 7:** Subagent Task Delegation & Context Isolation (Fresh context windows, child `Ractor`/OTP actors, byte-identical Fork cache sharing) `[r01–r22, b06, b07]`
* **Module 8:** Dynamic Skill Loading (`SKILL.md` progressive disclosure + "Agent is a Directory" `agent.cx` / `skills/` / `package.seax`) `[r01–r22, ADR-0009, ADR-0011]`
* **Module 9:** Context Compaction & Token Budgeting (4-tier compaction cascade, >30KB disk spill to `seax-vfs`, `SYSTEM_PROMPT_DYNAMIC_BOUNDARY`, `compaction-safeguard`) `[r01–r22, b13, b16]`

---

### **Stage 3: Memory, Prompts, Web Knowledge & Resilience (Modules 10–13)**
*(Grounded on AIEFS `[e01]`–`[e06]`, `$HF_HOME` local coprocessors `Lemonade`/`FastFlowLM`/`InferSSD`, and `/dream` consolidation)*
* **Module 10:** Persistent Memory Architecture (Plain Markdown `MEMORY.md` source of truth, bi-temporal tracking, FTS5 + vector derived cache, 4-phase `/dream` consolidation) `[e05, r01–r22, ADR-0005]`
* **Module 11:** Multi-Layer System Prompt Assembly (`constitution.toml`, `SOUL.md`, `CLAUDE.md`, closed-world `.ground` anchors, static/dynamic cache split) `[r01–r22, ADR-0008, ADR-0013]`
* **Module 12:** Web & Air-Gapped Knowledge Retrieval Tools (SSRF-guarded `web_fetch`, Turndown Markdown conversion, 125-char quote cap, offline ADR/doc search) `[r01–r22, b14, b16]`
* **Module 13:** Error Recovery & Resilient API Retries (Exponential backoff with jitter, 3-layer retry onion, local coprocessor failover `Lemonade` $\leftrightarrow$ `InferSSD`, `AuthProfile` rotation) `[b01, l04, r01–r22]`

---

### **Stage 4: Asynchronous Infrastructure & Always-On Runtime (Modules 14–17)**
*(Grounded on Tim Boring's `Task → Worker → Manager → Scheduler` `[c03]`, HashiCorp Nomad `raw_exec`, and OpenClaw multi-channel gateways)*
* **Module 14:** File-Persisted Task DAG System (SQLite/BoltDB persistent DAGs, node-level rollback, Nomad `raw_exec` batch dispatch) `[c03, r01–r22, ADR-0010]`
* **Module 15:** Background Task Threading (`/bg` non-blocking worker lanes, `DirtyCpu`/`DirtyIo` media renders, `<task-notification>` ingress) `[r01–r22, ADR-0012]`
* **Module 16:** Event-Driven Pub/Sub & Multi-Platform Runtime (Single-port converged WebSocket/HTTP gateway, Telegram, Slack, Discord, WhatsApp, NDI/OSC studio tallies) `[r01–r22, b07, b16]`
* **Module 17:** Scheduled Cron Tasks, Heartbeats & Proactive Posting (5-field vixie-cron with SHA-256 staggering, traceless heartbeats, `KAIROS` proactive alerts) `[r01–r22, b13, b19]`

---

### **Stage 5: Multi-Agent Routing, Orchestration, Transmedia Craft & Virtual Enterprise (Modules 18–24)**
*(Grounded on `.enterprise/` governance, `storytold/craft-*` subtrees, revived `pulumi-gestalt`, and Open-Core release promotion)*
* **Module 18:** Multi-Agent Source Routing & Concurrency Semaphores (7-level binding cascade, two-tier lane queues, E-PVM GPU/NPU resource-aware placement) `[c03, r01–r22, ADR-0003]`
* **Module 19:** Agent Teams & File-Based Message Bus (`.enterprise/` departments, atomic `os.rename` file mailboxes, UDS sockets, Consul service discovery) `[r01–r22, ADR-0008]`
* **Module 20:** Team Protocols & Correlation Handshakes (Agent-to-Agent `A2A` protocol, `plan_approval` & `shutdown` handshakes, idempotency keys) `[s02, t00, t01, t05, r01–r22]`
* **Module 21:** Autonomous Agents & Self-Organizing Task Claiming (Backlog polling, contained 1B–7B domain SLMs via Unsloth, adversarial gatekeeper validation) `[r01–r22, b13, ADR-0008, ADR-0013]`
* **Module 22:** Git Worktree Workspace Isolation (Per-agent `.worktrees/` sandboxes, diff-bound auditing, bare-git-repo attack scrubbing, Vault-gated PR merges) `[r01–r22, ADR-0008]`
* **Module 23:** Model Context Protocol (MCP), Craft Transmedia Suite & Revived `pulumi-gestalt` Bridges (`s00`/`s01` MCP servers, `vendor/craft/*` `SoundCraft`/`FilmCraft`/`PhotoCraft`/`EffectCraft`/`WordCraft`/`GridCraft`/`CADCraft` IPC, Portable VS Code cockpit, native `infra` cloud bursting) `[c06, s00, s01, t02, t03, ADR-0009, ADR-0010, ADR-0012]`
* **Module 24:** Comprehensive Integrated Carrier-Class System & Open-Core Release Engine (End-to-end verification across all 30 modules, `v1.0.0` open-core promotion, commercial industry cartridges) `[f01, b01, r01–r22, ADR-0007]`