# CCEFS & Vieo.ai: Carrier-Class Engineering From Scratch — Master Curriculum (v4.3)

> **Thesis:** *"The code is the product, not the end results."*  
> **ClauseOS (`clause.os` / `cx`) IS the living reference implementation.** If you follow **Track 1 (CCEFS — The Master Track)** from Module 0.1 through Module 25, you end up building **ClauseOS itself** from an empty folder—a 100% open-source (MIT / Apache-2.0), forkable, programmable transmedia & cloud software factory sealed inside a zero-leak bare-metal userland sandbox (`.home/`), powered by **Seax (`.cx`)** as our default language and **Rust** as our second systems tier.

---

## Document Suite Navigation (`docs/ccefs/`)

* **`00-PROJECT-SPECIFICATION-v3.0.md`** — Master Architectural Vision, Quad Model & 27-Package Illuminate Mapping
* **`01-ccefs-30-modules-v4.3.md` *(This File)*** — Complete 6-Stage / 30-Module Master Curriculum Map
* **`02-stage0-foundation-modules-v4.3.md`** — Stage 0 Deep-Dive (`Modules 0.1–0.5`: Hermetic `.home/` Userland & AIEFS Spine)
* **`03-stage1-2-compiler-orchestrator-v4.3.md`** — Stage 1 & Stage 2 Deep-Dive (`Modules 1–10`: Seax Compiler `seaxc`, Monkey-X Codegen, Distributed Orchestrator & Pulumi IaC)
* **`04-vieo-ai-curriculum-portal.md`** — Vieo.ai Portal Architecture (`Track 1 CCEFS`, `Track 2 Claude/OpenClaw/Hermes in Seax`, `Track 3 AIEFS Encyclopedia`, `Track 4 Bonus Track`)

---

## The 4-Track Vieo.ai Curriculum Architecture

```text
====================================================================================================
                                    VIEO.AI LEARNING ARCHITECTURE
                   Reference Implementation: ClauseOS Monorepo (100% OSS: MIT/Apache-2.0)
                         Default Language: Seax (.cx)  |  Systems Tier 2: Rust
                         Runtime Substrate: ClauseOS (.home/)  |  Polyglot Targets
====================================================================================================

  [TRACK 1: CCEFS — THE MASTER TRACK (BUILD CLAUSEOS ITSELF)] (30 Modules: Stage 0 -> Stage 5)
   Builds the actual ClauseOS monorepo from an empty directory: Hermetic .home/ -> Seax Compiler
   (seaxc) -> Distributed Orchestrator & Pulumi IaC -> Transmedia/Telecom DSP (Craft/Membrane/
   Kazoo) -> Seax-Native Agent Harness -> Autonomous Virtual Enterprise (.enterprise/)
        │
        ├──▶ [TRACK 2: BUILD CLAUDE, OPENCLAW & HERMES IN SEAX] (Unified Framework Tracks)
        │     • Track 2A: Build Your Own Claude Code (learn.shareai.run -> Seax & Rust)
        │     • Track 2B: Build Your Own OpenClaw (build-your-own-openclaw -> Seax & Rust)
        │     • Track 2C: Build Your Own Hermes (Multi-Agent Mesh & Messaging -> Seax & Rust)
        │     * All agent, tool, memory, compaction & gateway features live natively as Seax keywords!
        │
        ├──▶ [TRACK 3: AIEFS ENCYCLOPEDIA] (aiengineeringfromscratch.com Reference Spine)
        │     • Deep-dive mathematical, ML, DL, Vision, Speech, NLP, Transformer, RL & LLM mini-courses
        │     • Cross-referenced inline by CCEFS & Agent tracks; code ported to Seax (default) & Rust
        │
        └──▶ [TRACK 4: BONUS TRACK — AIEFS CLAUDE CODE IN SEAX]
              • Companion end-to-end build porting the AIEFS Claude Code track natively into Seax/Rust
====================================================================================================
```

---

## Language Presentation & Porting Hierarchy (ClauseOS DX Standard)

Every lesson, code walkthrough, and interactive verification gate across **vieo.ai** follows a strict language-first presentation order:

1. **Default Primary Language — Seax (`.cx` / `.seax`):** Expressive Dart-flavored syntax where agent loops, schema repair (`expose -> Schema`), capability gates (`needs` / `platform`), pipelines, and real-time media/telecom streams are **first-class language keywords and framework primitives**, not third-party library glue.
2. **Systems Tier 2 — Rust (`cargo` / `crates/*`):** Zero-cost abstractions, compiler internals (`seaxc`), `Ractor`/`Spawned` OTP actors, `seax-vfs` content-addressed storage, and zero-allocation SIMD/DSP kernels (`oximedia`, `nih-plug`, `Craft`).
3. **Polyglot Target Parity (`seaxc --target ...` & ClauseOS Polyglot Router):** Code examples and runtime targets extend seamlessly to **BEAM/Gleam** (`air`), **TypeScript/Wasm**, **Python** (`uv` + Unsloth/PyTorch), **C++20**, **Go**, **Zig**, **Nushell**, and **PowerShell**.

---

## Track 1: CCEFS — The Master Track (Building ClauseOS From Scratch, 30 Modules)

### Stage 0: Sealing the Hermetic Bare-Metal Userland (Modules 0.1–0.5)

*(Deep-dive specification in `docs/ccefs/02-stage0-foundation-modules-v4.3.md`)*

*Goal: Turn an empty folder on a bare host OS into ClauseOS's self-bootstrapping, zero-leak `.home/` sandbox where every compiler, runtime, and model lives hermetically—with zero host OS contamination.*

* **Module 0.1 — Zero-Leak Profile Confinement & Stage 0 Trampolines (`cx.bat`, `cx.ps1`, `cx.sh`):**
  * Host hygiene redlines (hard-abort if unmanaged `mise`, `scoop`, or `brew` exist on host), `CLAUSE_STATUS="online"` boundary guards, and 8-pass `${VAR}` compilation of `config/env/{00-core,10-identity,20-toolchains,30-shell,40-ml-hub}.toml` into `.home/`. `[f01, ADR-0001, ADR-0004]` *(Encyclopedia Ref: AIEFS Vol. 1 Phase 00.01 Dev Environment & 00.10 Terminal & Shell)*
* **Module 0.2 — Three-Tier Toolchain Supply Chain (`Mise` Overlays + Sterilized `Scoop`/`Brew`):**
  * Pre-seeding `pwsh`, `nu`, `mise`, `uv`, in-place patched `scoop` (`# clause-scoop-patches: 1`, zero `HKCU:\Environment` or Start Menu writes), and confined `brew` (`$HOMEBREW_PREFIX`), with `cx pkg:*` auto-pinning into `.mise.{paths,ai,cloud}.toml`. `[f02, ADR-0002]` *(Encyclopedia Ref: AIEFS Vol. 1 Phase 00.06 Environments)*
* **Module 0.3 — Dynamic 5-Way Hardware Matrix & Unified `$HF_HOME` Model Hub:**
  * Runtime probing for `CUDA`, `ROCm` (Linux 7.2 / Windows 10.0), Intel `XPU`, Apple `MPS`, and `CPU`, anchoring Unsloth, ComfyUI (`extra_model_paths.yaml`), Lemonade, FastFlowLM, and InferSSD to one zero-duplication `$HF_HUB_CACHE`. `[f03, ADR-0003, ADR-0005]` *(Encyclopedia Ref: AIEFS Vol. 1 Phase 00.03 GPU Setup)*
* **Module 0.4 — Hermetic Identity Lock & Automated Verification Harness (`cx identity`, `cx test`):**
  * Strict import-only `.home/.ssh/config` and `.home/.gitconfig` isolation, cross-shell `;` vs `:` PATH canonicalization, and `run_all.nu` (`test_stage0.nu`, `test_stage1.nu`, `test_hermeticity.nu`). `[f04, ADR-0001, ADR-0004]` *(Encyclopedia Ref: AIEFS Vol. 1 Phase 00.02 Git & Collaboration)*
* **Module 0.5 — Content-Addressed Workspace (`seax-vfs`) & AIEFS Mathematical Spine:**
  * Building the SHA-256 content-addressed blob vault + atomic `os.rename` Markdown/JSONL state layer inside `.home/` (`crates/seax-vfs` in Rust + Seax bindings), anchored to the **AIEFS Encyclopedia (`Vol. 1–6`)**. `[e01–e06, ADR-0005, ADR-0008]` *(Encyclopedia Ref: AIEFS Vol. 1 Phase 00.09 Data Management)*

### Stage 1: Building the Seax (`.cx`) Language & Multi-Target Compiler Inside `.home/` (Modules 1–5)

*(Deep-dive specification in `docs/ccefs/03-stage1-2-compiler-orchestrator-v4.3.md`)*

*Goal: Build `seaxc` from scratch in Rust so Seax itself—not an external framework—natively unifies Claude Code, OpenClaw, Hermes, actors, and transmedia primitives inside `$CLAUSE_BIN_DIR`.*

* **Module 1 — Dart-Flavored Lexer & Token Spans (`crates/seax-token`, `crates/seax-lexer`):**
  * Single-pass `&str` scanner (`[c01]` Ch. 1) tokenizing Dart-style C-family syntax (`{ }`, `( )`, `[ ]`, `..` cascades, `->`, `async`/`await`, `schema`, `switch`) alongside native **agent/harness keywords** (`agent`, `skill`, `tool`, `memory`, `compact`, `gateway`, `channel`, `heartbeat`), **transmedia keywords** (`audio`, `video`, `midi`, `ndi`, `osc`, `smpte`, `dante`, `dsp`), **carrier keywords** (`actor`, `pipeline`, `telcom`, `broadcast`, `infra`), and **capability keywords** (`needs`, `platform`, `provide`, `expose`). `[c01, c04, ADR-0011]`
* **Module 2 — Pratt Expression Parser, Recursive-Descent Blocks & "Agent is a Directory" (`crates/seax-ast`, `crates/seax-parser`):**
  * Top-Down Operator Precedence parser (`[c01]` Ch. 2) for cascades (`..`), method chains, and index expressions, paired with recursive-descent declarations (`AgentDecl`, `ActorDecl`, `ToolDecl`, `GatewayDecl`, `PipelineDecl`, `DspDecl`, `InfraDecl`, `SchemaDecl`) and directory-packaged agents (`agent.cx`, `team/`, `skills/`, `mcp/`, `plugins/`, `package.seax`). `[c01, c04, ADR-0011]`
* **Module 3 — Syntactic AST Macros & Multi-File Contract/Capability Checker (`crates/seax-macro`, `crates/seax-checker`):**
  * Code-as-data `quote`/`unquote` and recursive `ast.Modify` macro expansion (`[c01-lost]` Ch. 5, `#if TARGET == "rust"` vs `"beam"`), followed by static AST verification (`[c01]` Ch. 3 + `[c04]` Jet AST guards) enforcing `expose ... -> Schema` contracts, exhaustive `switch` arms, media sample-rate/channel compatibility, and `needs`/`platform` hermetic capabilities before codegen. `[c01, c01-lost, c04, ADR-0011]`
* **Module 4 — Symbol Tables, Closure Conversion & Embedded Bytecode VM (`crates/seax-symbol`, `crates/seax-vm`):**
  * Recursive `SymbolTable` (`Global`, `Local`, `Builtin`, `Free`, `Function` scopes), single-pass jump back-patching (`changeOperand`), stack call `Frame`s, and `OpClosure`/`OpCurrentClosure` (`[c02]` Ch. 1–10) powering `seax eval` REPL and live macro/script evaluation inside `.home/`. `[c02]`
* **Module 5 — Monkey-X (`transcc`) Multi-Target Emitters & Self-Hosting in `.home/` (`crates/seax-codegen`, `seax-cli`):**
  * Lowering verified Seax IR (`[c05]`) to: (1) **`--target rust`** (borrow-checker-safe `Arc<T>`/`Bytes` code wired to `Ractor`/`Spawned` OTP actors + native media crates), (2) **`--target beam`** (`Core Erlang` / `.beam` bytecode for the `Air` runtime & `Glimr` interop), and (3) **`--target client`** (`TypeScript`/`Wasm` + `flutter_rust_bridge`), compiling `seaxc`, `air`, and `jet` directly into `$CLAUSE_BIN_DIR`. `[c02, c05, ADR-0011]`

### Stage 2: Distributed Orchestrator, Micro-VMs & Native Pulumi IaC (Modules 6–10)

*(Deep-dive specification in `docs/ccefs/03-stage1-2-compiler-orchestrator-v4.3.md`)*

*Goal: Build ClauseOS's cluster orchestrator and infrastructure thrust engine (`Jet`) from scratch in Rust + Seax so programs schedule workloads across local silicon, micro-VMs, bare metal, and cloud clusters.*

* **Module 6 — Orchestrator Core: `Task → Worker → Manager → Scheduler` (`[c03]` Ch. 1–9):**
  * Translating Tim Boring's *Cube* orchestrator into `Ractor`/`Spawned` OTP actors in Rust + Seax control facades: 5-state `Task` FSM (`Pending` $\rightarrow$ `Scheduled` $\rightarrow$ `Running` $\rightarrow$ `Completed`/`Failed`), `Worker` FIFO queue & `/proc` hardware telemetry, `Manager` reconciliation loops, and `/health` active restart circuit breakers (`RestartCount < 3`). `[c03, ADR-0010]`
* **Module 7 — Borg E-PVM Resource-Aware Scheduler & Persistent `Store` (`[c03]` Ch. 10–12):**
  * Pluggable `Scheduler` trait (`SelectCandidateNodes` $\rightarrow$ `Score` $\rightarrow$ `Pick`) implementing `RoundRobin` and Google Borg's **E-PVM** marginal cost algorithm (`LIEB`) extended with GPU VRAM/NPU scoring (`ADR 0003`), backed by persistent SQLite/BoltDB `TaskStore` & `EventStore` and `cx` CLI subcommands. `[c03, ADR-0003, ADR-0010]`
* **Module 8 — HashiStack Control Plane & Cross-Platform Micro-VMs (`cx vm`):**
  * Confining `Nomad` (`raw_exec`), `Consul` (SWIM mesh & DNS), and `Vault` (leased dynamic tokens) inside `$CLAUSE_HOME/.local/share/`, and building the unified `cx vm` driver (`wsl.exe` on Windows, `limactl` on macOS/Linux) for ephemeral `k3s` and Linux-kernel workloads. `[ADR-0006, ADR-0010]`
* **Module 9 — Bare Metal as a Service (`Pixiecore` + `Packer` iPXE Netbooting):**
  * Compiling deterministic in-memory golden rootfs images with `Packer` and driving API-controlled DHCP/TFTP/HTTP iPXE netboots via `Pixiecore` against Consul node inventories. `[ADR-0010]`
* **Module 10 — Native `infra` Keyword & Revived `pulumi-gestalt` (`crates/clause-pulumi` / `Jet`):**
  * Adopting and maintaining `andrzejressel/pulumi-gestalt` inside the Rust workspace so Seax `infra` declarations compile to native, YAML-free Pulumi resource graphs (`clause cloud up` / `clause cloud detach`) for air-gapped cloud bursting. `[c06, ADR-0010, ADR-0011]`

### Stage 3: Real-Time Transmedia Engine, RinG Bridge & Telecom Switchboard (Modules 11–15)

*Goal: Wire real-time audio/video DSP, the Storytold Craft creative suite, mainstream DAWs/NLEs, and the BEAM/Kazoo Class 5 softswitch directly into Seax's native keywords.*

* **Module 11 — `RinG` (Rust-in-Gleam) Type-Safe FFI & Dirty-Scheduler Isolation:**
  * Schema-driven code generator (`tools/ring/`) generating synchronized Rust and Gleam/BEAM types, routing fast calls to immediate NIFs and heavy DSP/tensor/I/O buffers to `DirtyCpu`/`DirtyIo` schedulers without blocking actor reductions. `[ADR-0012]`
* **Module 12 — Zero-Allocation Audio/Video DSP (`dsp`, `audio`, `video`, `oximedia`, `nih-plug`):**
  * Lowering Seax `dsp` blocks and `..` cascades directly onto pre-allocated ring/arena buffers linked to pure-Rust `oximedia` codecs and `nih-plug` VST3/CLAP audio graphs (JUCE real-time discipline). `[a00, ADR-0011, ADR-0012]` *(Encyclopedia Ref: AIEFS Vol. 2 Phase 06.01–06.02 & 06.11)*
* **Module 13 — Hardware Control Buses (`midi`, `ndi`, `osc`, `smpte`, `dante`, `AES67`):**
  * First-class Seax `telcom` and `broadcast` streams ingesting live `NDI`/`SRT`/`WebRTC` video, `AES67`/`PipeWire`/`JACK` multichannel audio, `SMPTE` timecode, and `OSC`/`MIDI` surfaces. `[ADR-0011, ADR-0012]`
* **Module 14 — Storytold `Craft` Suite Subtrees & Mainstream DAW/NLE Interchange:**
  * Mounting `vendor/craft/*` (`SoundCraft`, `FilmCraft`, `PhotoCraft`, `EffectCraft`, `WordCraft`, `GridCraft`, `CADCraft`, `craft-ai-mcp`) via `git subtree --squash`, alongside round-trip `OTIO`/`AAF`/`FCPXML`/`PSD` bridges for DaVinci Resolve, Pro Tools, Ableton Live, and Reaper. `[ADR-0009, ADR-0012]`
* **Module 15 — BEAM Carrier Backplane: `Membrane` Media Router & `Kazoo` Class 5 Softswitch:**
  * Compiling Seax `target: beam` topologies onto Erlang/OTP supervision trees running `Membrane` live OTT/IPTV/WebRTC media pipelines and `Kazoo` SIP/telephony call routing across distributed nodes. `[l04, ADR-0010, ADR-0011]`

### Stage 4: Seax-Native Agent Framework (`Claude Code` + `OpenClaw` + `Hermes`, Modules 16–20)

*Goal: Implement the unified Claude Code, OpenClaw, and Hermes cognitive architecture as native Seax language keywords and Rust runtime primitives (`agent`, `tool`, `memory`, `compact`, `gateway`, `channel`, `heartbeat`, `expose -> Schema`, `needs`/`platform`).*

* **Module 16 — `AsyncGenerator` Agent Kernel, `<thinking>` Channels, Retry Onion & `jet_sap` Schema Repair:**
  * Implementing the `while(true)` streaming turn loop (`r01`–`r22`), `Illuminate\Pipeline` middleware, `streamFn` provider normalization, 3-layer retry onion (`AuthProfile` rotation, exponential backoff with jitter, local coprocessor failover `Lemonade` $\leftrightarrow$ `InferSSD`), slot reservation (`8K` $\rightarrow$ `64K`), and Schema-Aligned Parsing (`expose ... -> Type`). `[b01, c04, l04, r01–r22, a05]` *(Encyclopedia Ref: AIEFS Vol. 3 Phase 05.20 & Vol. 4 Phase 11.03)*
* **Module 17 — Self-Describing `tool` Registry, `mtime` Guards, Structured Planning & Speculative Parallel Batching:**
  * Native Seax `tool` declarations compiling to fail-closed contracts (`IToolRegistry`), greedy-merge parallel read-only batching vs. serialized write mutexes, `mtime` staleness protection, quote-normalized `edit_file`, structured `ArchitectTool` / Tree-of-Thoughts planning, SSRF-guarded `web_fetch` (Turndown Markdown + 125-char quote cap), and `30KB` disk spill to `seax-vfs`. `[r14–r22, b06, b13, b14, b16]` *(Encyclopedia Ref: AIEFS Vol. 4 Phase 11.09 Function Calling)*
* **Module 18 — Multi-Gate Permission Pipeline, 2-Stage YOLO Classifier, Hook Bus & Kernel Sandboxes:**
  * Compile-time `needs`/`platform` capability enforcement (`ADR 0011`) paired with runtime regex allow/deny rules, reasoning-blind 2-stage SLM classifier (`ADR 0013`), `2s Promise.race` timeouts, non-invasive lifecycle hook event bus (`PreToolUse`, `PostToolUse`, `ThoughtGenerated`, `SessionStart` via Lua/Seax hooks), and macOS Seatbelt / Linux Bubblewrap / Landlock isolation. `[r14–r22, a02, t06]` *(Encyclopedia Ref: AIEFS Vol. 4 Phase 11.12 Guardrails)*
* **Module 19 — 4-Tier `compact` Engine, `SYSTEM_PROMPT_DYNAMIC_BOUNDARY` & Markdown `memory` (`/dream`):**
  * Native Seax `compact` and `memory` primitives implementing tool-result budgeting, snip, cached microcompact, `<analysis>` scratchpad autocompact (`compaction-safeguard`), static/dynamic KV-cache alignment (`90%` cache hit rate), bi-temporal `MEMORY.md` + SQLite FTS5/vector derived cache, and 4-phase `/dream` consolidation. `[e05, r14–r22]` *(Encyclopedia Ref: AIEFS Vol. 4 Phase 11.05 Context Engineering & 11.15 Prompt Caching)*
* **Module 20 — Multi-Channel `gateway` (`OpenClaw` + `Hermes`), `heartbeat` Cron, Task DAGs & `MCP`/`A2A` Bridges:**
  * Single-port converged WebSocket/HTTP `gateway` (`req`/`res`/`event` frames with idempotency keys), `7-level` channel binding cascade, `steer`/`queue`/`collect` lane semantics, SQLite/BoltDB persistent Task DAGs + `/bg` background lanes, `SHA-256` staggered 5-field vixie-cron + traceless `heartbeat` (`KAIROS`), Hermes mesh routing, and `MCP` (`s00`/`s01`) + `A2A` (`s02`) protocol hosts. `[c03, r11, r22, s00–s02]` *(Encyclopedia Ref: AIEFS Vol. 4 Phase 11.14 MCP & 11.16–11.17 Agent State Machines)*

### Stage 5: Autonomous Virtual Enterprise, Domain SLMs & Open-Core Release (Modules 21–25)

*Goal: Assemble the self-governing multi-agent organization inside `.enterprise/`, train contained domain SLMs locally, and ship ClauseOS as an unconstrained 100% open-source substrate alongside bespoke enterprise tailoring.*

* **Module 21 — Contained Domain SLM Distillation & Local Coprocessor Fleet (`Unsloth` + `Lemonade`/`InferSSD`):**
  * Curating closed-world training datasets from `docs/adr/`, `config/env/*.toml`, and `tests/`, distilling `1B–7B` task-specific SLMs into `$HF_HUB_CACHE` with zero sycophancy/evasion weights (`ADR 0013`), and running local inference daemons. `[e02, e04, ADR-0005, ADR-0013]` *(Encyclopedia Ref: AIEFS Vol. 4 Phase 10.06 SFT, 10.08 DPO, 10.11 Quantization, 11.08 LoRA/QLoRA)*
* **Module 22 — `.enterprise/` Virtual Corporation Hierarchy & Closed-World `.ground` Governance:**
  * Implementing `board/constitution.toml`, C-Suite coordinators (`ceo_agent`, `cto_agent`, `cpo_agent`), operational departments (`engineering`, `security_audit`, `site_reliability`, `documentation_qa`), and "Never delegate understanding" 4-phase swarm workflows. `[r15, r18, ADR-0008]`
* **Module 23 — Git Worktree Swarm Isolation, Protocol Handshakes, Adversarial Gatekeeper & Vault Merge Leases:**
  * Per-agent `.worktrees/` isolation, bare-git-repo attack scrubbing, atomic `os.rename` swarm mailboxes + UDS sockets, structured `plan_approval` & `shutdown` correlation-ID handshakes (`t00`/`t01`/`t05`), `exec-policy` TOCTOU verification, and adversarial gatekeeper validation (`cx test` + `cargo test --offline` exit `0`) unlocking dynamic Vault Git merge tokens. `[r15, r22, t00, t01, t05, ADR-0008, ADR-0010]`
* **Module 24 — Portable VS Code Cockpit, `APM` Cross-Harness Lockfiles & `Shore`/`Lustre` Telemetry:**
  * Confining Portable VS Code (`cx-vscode`) to `.home/` bound to the local coprocessor, synchronizing cross-harness skills/policies via `apm.yml` / `apm.lock.yaml` (so Claude Code, Codex, Cursor, Gemini, and Seax agents all plug into the same MCP ports), and rendering live operator dashboards in `Shore` TUI and `Lustre` Web. `[ADR-0009]`
* **Module 25 — 100% Open-Source Release Engine & Bespoke Enterprise Tailoring (`v1.0.0`):**
  * Full-matrix CI/CD hermeticity certification across Windows, Linux, and macOS, promoting `.clause.toml` to `v1.0.0` under permissive OSS licensing (MIT / Apache-2.0) with drop-in `config/xx-<custom>.toml` overlays, SBOM verification, and bespoke industry adaptation cartridges (HIPAA, FINRA/SEC, Defense Air-Gapped, Legacy Connectors). `[f01, b01, ADR-0007]`

---

## Track 2, Track 3 & Track 4 Overview (See `04-vieo-ai-curriculum-portal.md`)

* **Track 2 (Build Claude, OpenClaw & Hermes in Seax):** Extracts Modules 16–20 into three hands-on vertical build tracks (`2A: Claude Code`, `2B: OpenClaw`, `2C: Hermes`) using **Seax** as the default language (with **Rust** and polyglot targets), showing how their best mechanics live natively as Seax language keywords and framework primitives.
* **Track 3 (AIEFS Reference Encyclopedia):** Indexes all 223 chapters across *AI Engineering From Scratch* (`Vol. 1–6`) as a structured technical encyclopedia—ported to **Seax** (default) and **Rust** (systems/tensors)—so any CCEFS or Agent module can link directly to deep-dive theory and runnable code.
* **Track 4 (Bonus Track — AIEFS Claude Code in Seax):** Provides the complete companion track porting the AIEFS Claude Code course directly onto ClauseOS, Seax, and Rust.
