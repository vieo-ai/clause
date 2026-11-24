# CCEFS & Vieo.ai: Carrier-Class Engineering From Scratch — Master Curriculum (v4.3)

> **Document Status:** Supreme Architectural Specification (Tier 2 SSOT)  
> **Parent Steward:** Vieo (`vieo-ai`)  
> **Substrate:** ClauseOS (`clause` / `cx`)  
> **Default Language:** Clause (`.cx`) | **Compiler CLI:** `cxc` (`packages/clause/`)  
> **Control Plane:** `clause_jet` (`packages/clause_jet/` on Erlang/OTP 29)  
> **Agent & Virtual Enterprise SSOT:** Root `apm.yml` & `.apm/` (`apm build`)  
> **Thesis:** *"The code is the product, not the end results."*

**ClauseOS (`clause` / `cx`) IS the living reference implementation.** If you follow **Track 1 (CCEFS — The Master Track)** from Module 0.1 through Module 25, you end up building **ClauseOS itself** from an empty folder—a 100% open-source (MIT / Apache-2.0), forkable, programmable transmedia & cloud software factory sealed inside a zero-leak bare-metal userland sandbox (`.home/`), powered by **Clause (`.cx`)** as our default language, **Rust** as our systems data plane, and **BEAM/Erlang** as our distributed control plane.

---

## Document Suite Navigation (`docs/ccefs/`)

* **`00-PROJECT-SPECIFICATION-v3.0.md`** — Master Architectural Vision, Quad Model & 27-Package Illuminate Mapping
* **`01-ccefs-30-modules-v4.3.md`** ***(This File)*** — Complete 6-Stage / 30-Module Master Curriculum Map
* **`02-stage0-foundation-modules-v4.3.md`** — Stage 0 Deep-Dive (Modules 0.1–0.5: Hermetic `.home/` Userland, `clause-vfs` & AIEFS Spine)
* **`03-stage1-2-compiler-orchestrator-v4.3.md`** — Stage 1 & Stage 2 Deep-Dive (Modules 1–10: `cxc` Gleam Compiler Fork, Monkey-X Codegen, Distributed Orchestrator & Native Pulumi IaC)
* **`04-vieo-ai-curriculum-portal.md`** — Vieo.ai Learning Portal Architecture (Track 1 CCEFS, Track 2 Claude/OpenClaw/Hermes in Clause, Track 3 AIEFS Encyclopedia, Track 4 Bonus Track)

---

## The 4-Track Vieo.ai Curriculum Architecture

```text
====================================================================================================
                                    VIEO.AI LEARNING ARCHITECTURE
                   Reference Implementation: ClauseOS Monorepo (100% OSS: MIT/Apache-2.0)
                         Default Language: Clause (.cx)  |  Systems Tier 2: Rust
                         Runtime Substrate: ClauseOS (.home/)  |  Polyglot Targets
====================================================================================================

  [TRACK 1: CCEFS — THE MASTER TRACK (BUILD CLAUSEOS ITSELF)] (30 Modules: Stage 0 -> Stage 5)
   Builds the actual ClauseOS monorepo from an empty directory: Hermetic .home/ -> Clause Compiler
   (cxc fork in packages/clause/) -> Distributed Orchestrator & Pulumi IaC -> Transmedia/Telecom DSP
   (Craft/Membrane/Kazoo) -> Clause-Native Agent Harness -> Autonomous Virtual Enterprise (.apm/)
        │
        ├──▶ [TRACK 2: BUILD CLAUDE, OPENCLAW & HERMES IN CLAUSE] (Unified Framework Tracks)
        │     • Track 2A: Build Your Own Claude Code (learn.shareai.run -> Clause & Rust)
        │     • Track 2B: Build Your Own OpenClaw (build-your-own-openclaw -> Clause & Rust)
        │     • Track 2C: Build Your Own Hermes (Multi-Agent Mesh & Messaging -> Clause & Rust)
        │     * All agent, tool, memory, compaction & gateway features live natively as Clause keywords!
        │
        ├──▶ [TRACK 3: AIEFS ENCYCLOPEDIA] (aiengineeringfromscratch.com Reference Spine)
        │     • Deep-dive mathematical, ML, DL, Vision, Speech, NLP, Transformer, RL & LLM mini-courses
        │     • Cross-referenced inline by CCEFS & Agent tracks; code ported to Clause (default) & Rust
        │
        └──▶ [TRACK 4: BONUS TRACK — AIEFS CLAUDE CODE IN CLAUSE]
              • Companion end-to-end build porting the AIEFS Claude Code track natively into Clause/Rust
====================================================================================================
```

---

## Track 1: CCEFS — The Master Track (Building ClauseOS From Scratch, 30 Modules)

### Stage 0: Sealing the Hermetic Bare-Metal Userland (Modules 0.1–0.5)

*(Deep-dive specification in `docs/ccefs/02-stage0-foundation-modules-v4.3.md`)*  
*Goal: Turn an empty folder on a bare host OS into ClauseOS's self-bootstrapping, zero-leak `.home/` sandbox where every compiler, runtime, and model lives hermetically—with zero host OS contamination.*

* **Module 0.1 — Zero-Leak Profile Confinement & Stage 0 Trampolines (`cx.bat`, `cx.ps1`, `cx.sh`):**
  * Host hygiene redlines (hard-abort if unmanaged mise, scoop, or brew exist on host), `CLAUSE_STATUS="online"` boundary guards, and 8-pass `${VAR}` compilation of `config/env/{00-core,10-identity,20-toolchains,30-shell,40-ml-hub}.toml` into `.home/`. `[f01, ADR-0001, ADR-0004]` *(Encyclopedia Ref: AIEFS Vol. 1 Phase 00.01 Dev Environment & 00.10 Terminal & Shell)*
* **Module 0.2 — Three-Tier Toolchain Supply Chain (`Mise` Overlays + Sterilized `Scoop` / `Brew`):**
  * Pre-seeding `pwsh`, `nu`, `mise`, `uv`, in-place patched scoop (`# clause-scoop-patches: 1`, zero `HKCU:\Environment` or Start Menu writes), and confined brew (`$HOMEBREW_PREFIX`), with `cx pkg:*` auto-pinning into `.mise.{paths,ai,cloud}.toml`. `[f02, ADR-0002]` *(Encyclopedia Ref: AIEFS Vol. 1 Phase 00.06 Environments)*
* **Module 0.3 — Dynamic 5-Way Hardware Matrix & Unified `$HF_HOME` Model Hub:**
  * Runtime probing for CUDA, ROCm (Linux 7.2 / Windows 10.0), Intel XPU, Apple MPS, and CPU, anchoring Unsloth, ComfyUI (`extra_model_paths.yaml`), Lemonade, FastFlowLM, and InferSSD to one zero-duplication `$HF_HUB_CACHE`. `[f03, ADR-0003, ADR-0005]` *(Encyclopedia Ref: AIEFS Vol. 1 Phase 00.03 GPU Setup)*
* **Module 0.4 — Hermetic Identity Lock & Automated Verification Harness (`cx identity`, `cx test`):**
  * Strict import-only `.home/.ssh/config` and `.home/.gitconfig` isolation, cross-shell `;` vs `:` PATH canonicalization, and `run_all.nu` (`test_stage0.nu`, `test_stage1.nu`, `test_hermeticity.nu`). `[f04, ADR-0001, ADR-0004]` *(Encyclopedia Ref: AIEFS Vol. 1 Phase 00.02 Git & Collaboration)*
* **Module 0.5 — Content-Addressed Workspace (`clause-vfs` in `.ground/`) & AIEFS Mathematical Spine:**
  * Building the SHA-256 content-addressed blob vault + atomic `os.rename` Markdown/JSONL state layer inside `.home/` (`crates/clause-vfs` in Rust + Clause bindings), anchored to the **AIEFS Encyclopedia (Vol. 1–6)**. `[e01–e06, ADR-0005, ADR-0008]` *(Encyclopedia Ref: AIEFS Vol. 1 Phase 00.09 Data Management)*

---

### Stage 1: Building the Clause (`.cx`) Language & Multi-Target Compiler Inside `.home/` (Modules 1–5)

*(Deep-dive specification in `docs/ccefs/03-stage1-2-compiler-orchestrator-v4.3.md`)*  
*Goal: Construct `cxc` as an upstream-clean fork of `gleam-lang/gleam` inside `packages/clause/` so Clause itself—not an external framework—natively unifies Claude Code, OpenClaw, Hermes, actors, and transmedia primitives inside `$CLAUSE_BIN_DIR`.*

* **Module 1 — Upstream-Clean Gleam Core Extraction & Branding Constants (`packages/clause/crates/*`, `brand.rs`):**
  * Forking `gleam-lang/gleam` core compiler crates into `packages/clause/crates/{clause-core,clause-cli,clause-lsp,clause-wasm,clause-runtime}` (`[c01]` Ch. 1, `[c04]`, `[d48]`), implementing `brand.rs` defining `.cx` extension, `clause.toml` manifest, and `cxc` CLI binary, anchoring Cargo build cache to `${CLAUSE_DATA_DIR}/cargo` via `20-toolchains.toml`. `[c01, c04, d48, ADR-0011]`
* **Module 2 — Nine-Pillar Grammar Extensions & AST Token Spans (`clause-core/src/parse/`):**
  * Extending Logos lexer and recursive-descent block parser with Tier 1 top-level declaration keywords (`kernel`, `service_provider`, `infra`, `provider`, `agent`, `gateway`, `trunk`, `bridge`, `dialplan`, `bus`, `rack`, `patchbay`, `split`, `stage`, `mcr`, `headend`, `airgap`, `sortie`) paired with directory-packaged agents (`agent.cx`, `team/`, `skills/`, `mcp/`, `clause.toml`). `[c01, c04, d48, ADR-0011]`
* **Module 3 — Static Domain Verification Passes & Contract Checking (`clause-core/src/analyse/`):**
  * Static domain verification passes enforcing 100% split rights checks (`split`), audio/video sample-rate and channel parity (`bus`/`rack`), `@airgap(emcon: ...)` egress verification, and compile-time `@needs` capability isolation before codegen. `[c01, c01-lost, c04, ADR-0007, ADR-0011]`
* **Module 4 — Monkey-X Multi-Target Codegen: `--target rust` (`backend/rust.rs`):**
  * Lowering verified Clause AST to borrow-checker-safe native Rust crates linked to `oximedia`, `nih-plug` (CLAP/VST3), Storytold `Craft`, and `crates/clause-pulumi` via direct zero-copy crate imports (`@external(rust, ...)`). `[c02, c05, d48, ADR-0011]`
* **Module 5 — Monkey-X Multi-Target Codegen: `--target beam` & `--target client` (`backend/erlang.rs`, `backend/javascript.rs`):**
  * Lowering Clause AST to: (1) `--target beam` (Core Erlang / `.beam` bytecode for `packages/clause_jet` over Erlang/OTP 29, with automated `tools/ring` DirtyScheduler NIF synthesis for `@external(rust, ...)` calls), and (2) `--target client` (TypeScript/Wasm powering Lustre, Plushie, Shore, and O2K glass). `[c02, c05, d48, ADR-0011, ADR-0012]`

---

### Stage 2: Distributed Orchestrator, Micro-VMs & Native Pulumi IaC (Modules 6–10)

*(Deep-dive specification in `docs/ccefs/03-stage1-2-compiler-orchestrator-v4.3.md`)*  
*Goal: Build ClauseOS's cluster orchestrator and infrastructure thrust engine (`clause_jet` / `catapult`) from scratch in Rust + Clause so programs schedule workloads across local silicon, micro-VMs, bare metal, and cloud clusters.*

* **Module 6 — Orchestrator Core: `Task → Worker → Manager → Scheduler` (`[c03]` Ch. 1–9):**
  * Translating Tim Boring's *Cube* orchestrator into Erlang/OTP actors in `packages/clause_jet` + Clause control facades: 5-state Task FSM (`Pending` $
ightarrow$ `Scheduled` $
ightarrow$ `Running` $
ightarrow$ `Completed`/`Failed`), Worker FIFO queue & `/proc` hardware telemetry, Manager reconciliation loops, and `/health` active restart circuit breakers (`RestartCount < 3`). `[c03, ADR-0010]`
* **Module 7 — Borg E-PVM Resource-Aware Scheduler & Persistent `Store` (`[c03]` Ch. 10–12):**
  * Pluggable Scheduler trait (`SelectCandidateNodes` $
ightarrow$ `Score` $
ightarrow$ `Pick`) implementing RoundRobin and Google Borg's **E-PVM** marginal cost algorithm (`LIEB`) extended with GPU VRAM/NPU scoring (`ADR 0003`), backed by persistent SQLite/BoltDB `TaskStore` & `EventStore` and `cx` CLI subcommands. `[c03, ADR-0003, ADR-0010]`
* **Module 8 — HashiStack Control Plane & Cross-Platform Micro-VMs (`cx vm`):**
  * Confining Nomad (`raw_exec`), Consul (`SWIM` mesh & DNS), and Vault (leased dynamic tokens) inside `$CLAUSE_HOME/.local/share/`, and building the unified `cx vm` driver (`wsl.exe` on Windows, `limactl` on macOS/Linux) for ephemeral `k3s` and Linux-kernel workloads. `[ADR-0006, ADR-0010]`
* **Module 9 — Bare Metal as a Service (`Pixiecore` + `Packer` iPXE Netbooting):**
  * Compiling deterministic in-memory golden rootfs images with Packer and driving API-controlled DHCP/TFTP/HTTP iPXE netboots via Pixiecore against Consul node inventories. `[ADR-0010]`
* **Module 10 — Native `infra` Keyword & Revived `clause-pulumi` (`crates/clause-pulumi` / `catapult`):**
  * Adopting and maintaining revived `pulumi-gestalt` inside the Rust workspace (`crates/clause-pulumi/`) so Clause `infra` declarations compile to native, YAML-free Pulumi resource graphs (`cx cloud up` / `cx cloud detach`) for air-gapped cloud bursting. `[c06, ADR-0010, ADR-0011]`

---

### Stage 3: Real-Time Transmedia Engine, RinG Bridge & Telecom Switchboard (Modules 11–15)

*Goal: Wire real-time audio/video DSP, the Storytold Craft creative suite, mainstream DAWs/NLEs, and the BEAM/Kazoo Class 5 softswitch directly into Clause's native keywords.*

* **Module 11 — RinG (Rust-in-Gleam/Clause) Type-Safe FFI & Dirty-Scheduler Isolation:**
  * Schema-driven code generator (`tools/ring/`) generating synchronized Rust and Clause/BEAM types, routing fast calls to immediate NIFs and heavy DSP/tensor/I/O buffers to `DirtyCpu`/`DirtyIo` schedulers without blocking actor reductions (`ADR 0012`). `[ADR-0012]`
* **Module 12 — Zero-Allocation Audio/Video DSP (`dsp`, `bus`, `rack`, `stem`, `oximedia`, `nih-plug`):**
  * Lowering Clause `dsp` blocks and pipelines directly onto pre-allocated lock-free ring/arena buffers linked to pure-Rust `oximedia` codecs and `nih-plug` VST3/CLAP audio graphs (JUCE real-time discipline). `[a00, ADR-0011, ADR-0012]` *(Encyclopedia Ref: AIEFS Vol. 2 Phase 06.01–06.02 & 06.11)*
* **Module 13 — Hardware Control Buses (`midi`, `ndi`, `osc`, `smpte`, `dante`, `AES67`):**
  * First-class Clause telcom and broadcast streams ingesting live NDI/SRT/WebRTC video, AES67/PipeWire/JACK multichannel audio, SMPTE timecode, and OSC/MIDI surfaces. `[ADR-0011, ADR-0012]`
* **Module 14 — Storytold Craft Suite Subtrees & Mainstream DAW/NLE Interchange:**
  * Mounting `vendor/craft/*` (`SoundCraft`, `FilmCraft`, `PhotoCraft`, `EffectCraft`, `WordCraft`, `GridCraft`, `CADCraft`, `craft-ai-mcp`) via `git subtree --squash`, alongside round-trip OTIO/AAF/FCPXML/PSD bridges for DaVinci Resolve, Pro Tools, Ableton Live, and Reaper. `[ADR-0009, ADR-0012]`
* **Module 15 — BEAM Carrier Backplane: Membrane Media Router & Kazoo Class 5 Softswitch:**
  * Compiling Clause `--target beam` topologies onto Erlang/OTP supervision trees running Membrane live OTT/IPTV/WebRTC media pipelines and Kazoo SIP/telephony call routing across distributed nodes. `[l04, ADR-0010, ADR-0011]`

---

### Stage 4: Clause-Native Agent Framework (Claude Code + OpenClaw + Hermes, Modules 16–20)

*Goal: Implement the unified Claude Code, OpenClaw, and Hermes cognitive architecture as native Clause language keywords and runtime primitives (`agent`, `tool`, `memory`, `compact`, `gateway`, `channel`, `heartbeat`, `expose -> Schema`, `needs` / `platform`).*

* **Module 16 — AsyncGenerator Agent Kernel, `<thinking>` Channels, Retry Onion & `jet_sap` Schema Repair:**
  * Implementing the `while(true)` streaming turn loop (`r01`–`r22`), `Illuminate\Pipeline` middleware, `streamFn` provider normalization, 3-layer retry onion (AuthProfile rotation, exponential backoff with jitter, local coprocessor failover Lemonade $\leftrightarrow$ InferSSD), slot reservation (`8K` $
ightarrow$ `64K`), and Schema-Aligned Parsing (`expose ... -> Type`). `[b01, c04, l04, r01–r22, a05]` *(Encyclopedia Ref: AIEFS Vol. 3 Phase 05.20 & Vol. 4 Phase 11.03)*
* **Module 17 — Self-Describing `tool` Registry, `mtime` Guards, Structured Planning & Speculative Parallel Batching:**
  * Native Clause tool declarations compiling to fail-closed contracts (`IToolRegistry`), greedy-merge parallel read-only batching vs. serialized write mutexes, `mtime` staleness protection, quote-normalized `edit_file`, structured `ArchitectTool` / Tree-of-Thoughts planning, SSRF-guarded `web_fetch` (Turndown Markdown + 125-char quote cap), and 30KB disk spill to `clause-vfs`. `[r14–r22, b06, b13, b14, b16]` *(Encyclopedia Ref: AIEFS Vol. 4 Phase 11.09 Function Calling)*
* **Module 18 — Multi-Gate Permission Pipeline, 2-Stage YOLO Classifier, Hook Bus & Kernel Sandboxes:**
  * Compile-time `needs`/`platform` capability enforcement (`ADR 0011`) paired with runtime regex allow/deny rules, reasoning-blind 2-stage SLM classifier (`ADR 0013`), 2s `Promise.race` timeouts, non-invasive lifecycle hook event bus (`PreToolUse`, `PostToolUse`, `ThoughtGenerated`, `SessionStart` via Lua/Clause hooks), and macOS Seatbelt / Linux Bubblewrap / Landlock isolation. `[r14–r22, a02, t06]` *(Encyclopedia Ref: AIEFS Vol. 4 Phase 11.12 Guardrails)*
* **Module 19 — 4-Tier `compact` Engine, `SYSTEM_PROMPT_DYNAMIC_BOUNDARY` & Markdown `memory` (`/dream`):**
  * Native Clause `compact` and `memory` primitives implementing tool-result budgeting, snip, cached microcompact, `<analysis>` scratchpad autocompact (compaction-safeguard), static/dynamic KV-cache alignment (90% cache hit rate), bi-temporal `MEMORY.md` + SQLite FTS5/vector derived cache, and 4-phase `/dream` consolidation. `[e05, r14–r22]` *(Encyclopedia Ref: AIEFS Vol. 4 Phase 11.05 Context Engineering & 11.15 Prompt Caching)*
* **Module 20 — Multi-Channel `gateway` (`OpenClaw` + `Hermes`), `heartbeat` Cron, Task DAGs & `MCP` / `A2A` Bridges:**
  * Single-port converged WebSocket/HTTP gateway (req/res/event frames with idempotency keys), 7-level channel binding cascade, steer/queue/collect lane semantics, SQLite/BoltDB persistent Task DAGs + `/bg` background lanes, SHA-256 staggered 5-field vixie-cron + traceless heartbeat (`KAIROS`), Hermes mesh routing, and MCP (`s00`/`s01`) + A2A (`s02`) protocol hosts. `[c03, r11, r22, s00–s02]` *(Encyclopedia Ref: AIEFS Vol. 4 Phase 11.14 MCP & 11.16–11.17 Agent State Machines)*

---

### Stage 5: Autonomous Virtual Enterprise, Domain SLMs & Open-Core Release (Modules 21–25)

*Goal: Assemble the self-governing multi-agent organization inside root `apm.yml` and `.apm/`, train contained domain SLMs locally, and ship ClauseOS as an unconstrained 100% open-source substrate alongside bespoke enterprise tailoring.*

* **Module 21 — Contained Domain SLM Distillation & Local Coprocessor Fleet (`Unsloth` + `Lemonade` / `InferSSD`):**
  * Curating closed-world training datasets from `docs/adr/`, `config/env/*.toml`, and `tests/`, distilling 1B–7B task-specific SLMs into `$HF_HUB_CACHE` with zero sycophancy/evasion weights (`ADR 0013`), and running local inference daemons. `[e02, e04, ADR-0005, ADR-0013]` *(Encyclopedia Ref: AIEFS Vol. 4 Phase 10.06 SFT, 10.08 DPO, 10.11 Quantization, 11.08 LoRA/QLoRA)*
* **Module 22 — Agent Package Manager (APM) & Virtual Enterprise Directory Hierarchy:**
  * Implementing root `apm.yml`, `.apm/` SSOT (`.apm/agents/`, `.apm/skills/`, `.apm/instructions/`), C-Suite coordinators (`ceo_agent`, `cto_agent`, `cpo_agent`), operational departments (`engineering`, `security_audit`, `site_reliability`, `documentation_qa`), closed-world `.ground` governance, and "Never delegate understanding" 4-phase swarm workflows. `[r15, r18, t03, ADR-0008]`
* **Module 23 — Git Worktree Swarm Isolation, Protocol Handshakes, Adversarial Gatekeeper & Vault Merge Leases:**
  * Per-agent `.worktrees/` isolation, bare-git-repo attack scrubbing, atomic `os.rename` swarm mailboxes + UDS sockets, structured `plan_approval` & `shutdown` correlation-ID handshakes (`t00`/`t01`/`t05`), exec-policy TOCTOU verification, and adversarial gatekeeper validation (`cx test` + `cargo test --offline` exit `0`) unlocking dynamic Vault Git merge tokens. `[r15, r22, t00, t01, t05, ADR-0008, ADR-0010]`
* **Module 24 — Portable VS Code Cockpit, APM Cross-Harness Projections & Shore / Lustre Telemetry:**
  * Confining Portable VS Code (`cx-vscode`) to `.home/` bound to the local coprocessor, synchronizing cross-harness skills/policies via `apm build` emitting into `.claude/`, `.agents/`, and `.vscode/` (so Claude Code, Codex, Cursor, Gemini, and Clause agents all plug into the same MCP ports), and rendering live operator dashboards in Shore TUI and Lustre Web. `[ADR-0009]`
* **Module 25 — 100% Open-Source Release Engine & Bespoke Enterprise Tailoring (`v1.0.0`):**
  * Full-matrix CI/CD hermeticity certification across Windows, Linux, and macOS, promoting `.clause.toml` to `v1.0.0` under permissive OSS licensing (MIT / Apache-2.0) with drop-in `config/xx-<custom>.toml` overlays, SBOM verification, and bespoke industry adaptation cartridges (HIPAA, FINRA/SEC, Defense Air-Gapped, Legacy Connectors). `[f01, b01, ADR-0007]`

---

#### Track 2, Track 3 & Track 4 Overview (See `docs/ccefs/04-vieo-ai-curriculum-portal.md`)

* **Track 2 (Build Claude, OpenClaw & Hermes in Clause):** Extracts Modules 16–20 into three hands-on vertical build tracks (2A: Claude Code, 2B: OpenClaw, 2C: Hermes) using **Clause (`.cx`)** as the default language (with **Rust** and polyglot targets), showing how their best mechanics live natively as Clause language keywords and framework primitives.
* **Track 3 (AIEFS Reference Encyclopedia):** Indexes all 223 chapters across *AI Engineering From Scratch* (Vol. 1–6) as a structured technical encyclopedia—ported to **Clause (`.cx`)** (default) and **Rust** (systems/tensors)—so any CCEFS or Agent module can link directly to deep-dive theory and runnable code.
* **Track 4 (Bonus Track — AIEFS Claude Code in Clause):** Provides the complete companion track porting the AIEFS Claude Code course directly onto ClauseOS, Clause, and Rust.

---

#### Track 3: AIEFS Reference Encyclopedia (Vol. 1–6 Cross-Reference Map)

Because **AIEFS (*AI Engineering From Scratch*, `aiengineeringfromscratch.com`)** consists of focused, self-contained mini-courses on mathematical and algorithmic primitives rather than full end-to-end applications, **vieo.ai** positions it as the **Reference Encyclopedia** supporting Tracks 1, 2, and 4. Every encyclopedia entry provides:

1. **Default Clause (`.cx`) Implementation** (using Clause tensor/math primitives and functional pipes)
2. **Rust Systems Implementation** (zero-allocation `crates/*` implementation)
3. **Python / PyTorch / JAX Reference** (original AIEFS baseline for cross-verification)

| AIEFS Volume & Phases | Encyclopedia Domain | Key Chapters & Algorithms | Where Referenced in CCEFS & Agent Tracks |
| :--- | :--- | :--- | :--- |
| **Vol. 1: Foundations** (Phases 00–02, 52 Ch.) | Setup, Linear Algebra, Calculus, Autodiff, Probability, Bayes, Optimization, Info Theory, SVD, Tensors, Numerical Stability, Classical ML | Value-based autograd, SVD/PCA, Gram-Schmidt, Log-Sum-Exp, Adam/SGD, KDE/GMM, Isolation Forest, SMOTE | **CCEFS Modules 0.1–0.5** (`.home/` setup, GPU matrix, `clause-vfs`), **Module 7** (E-PVM scoring), **Module 12** (FFT/spectral DSP) |
| **Vol. 2: Deep Learning** (Phases 03–04, 06, 58 Ch.) | Neural Core, Computer Vision (CNNs, ViT, YOLO, U-Net, Diffusion, DiT, 3DGS, SAM 3, VLMs), Speech & Audio (STFT/Mel, Whisper, TTS, Codecs, VAD, Moshi) | Mini-framework (Module, Linear, AdamW), Im2col, RoIAlign, DDPM/Flow Matching, RVQ (Mimi/EnCodec), Silero VAD, Full-duplex S2S | **CCEFS Modules 12–14** (`oximedia`, `nih-plug`, SoundCraft/FilmCraft/PhotoCraft, real-time 20ms audio ring buffers) |
| **Vol. 3: Language** (Phases 05, 07, 45 Ch.) | NLP Foundations (BPE/Unigram, BM25, Hybrid RRF, NER, Coref, Knowledge Graphs, RAGAS) & Transformers (Self/Multi-Head Attention, RoPE, MoE, KV Cache, Flash Attention, Speculative Decoding) | Byte-level BPE, BM25 + RRF + Cross-Encoder, FSM Constrained Decoding, Causal Mask, GQA/MLA, PagedAttention, EAGLE | **CCEFS Modules 1–3** (Lexer/Parser/Grammar), **Module 16** (`jet_sap` constrained decoding), **Module 19** (`MEMORY.md` FTS5 + vector hybrid search & KV-cache alignment) |
| **Vol. 4: LLMs** (Phases 08–11, 68 Ch.) | Generative AI, Reinforcement Learning (MDP, PPO, GRPO, MARL), LLMs from Scratch (Pre-training, FSDP, SFT, RLHF, DPO, Constitutional AI, Quantization, DualPipe, NSA, MTP), LLM Engineering (Context Engineering, RAG, LoRA/QLoRA, Function Calling, Guardrails, MCP) | 124M Mini-GPT, Bradley-Terry RM, DPO/GRPO, NF4/GPTQ/AWQ quantization, Lost-in-the-Middle reordering, HyDE, Parent-Child chunking, MCP servers | **CCEFS Modules 16–21** (Agent kernel, tool registry, compact engine, MCP hosts, **Unsloth** domain SLM distillation & quantization in ADR 0013) |
| **Vol. 5: Agents** (Phases 12–16) | Multimodality, Protocols (MCP, A2A), Autonomy, Long-Horizon Planning, Multi-Agent Swarms | Tool orchestration, memory architectures, multi-agent coordination, verification loops | **CCEFS Modules 20, 22–23** & **Track 2A/2B/2C** (Claude Code, OpenClaw, Hermes, Virtual Enterprise governance) |
| **Vol. 6: Production** (Phases 17–19) | Infrastructure, Safety, Observability, Capstones | Telemetry, sandboxing, evaluation gates, deployment pipelines | **CCEFS Modules 8–10, 24–25** (HashiStack, `clause-pulumi`, Shore/Lustre, Open-Core `v1.0.0` release) |

---

#### Track 4: Bonus Track — AIEFS Claude Code in Clause

To bridge learners coming from the AIEFS ecosystem directly into **ClauseOS**, **Track 4** presents the **AIEFS Claude Code Track** ported end-to-end into **Clause (`.cx`)** and **Rust**:

* **Side-by-Side Idiom Translation:** Every chapter shows the concise **Clause (`.cx`)** native construct (`agent`, `tool`, `compact`, `memory`, `expose -> Schema`, `needs`) alongside its **Rust** systems implementation and the original Python reference.
* **Zero-Setup Execution Inside ClauseOS:** Learners clone the repository, run `cx` (or `./cx.sh`), and execute every lab offline inside `.home/` using local neural coprocessors (Lemonade / InferSSD)—zero API keys or host pollution required.
* **Agent-Ready `llms.txt` & `.ground` Index:** Every module on **vieo.ai** exposes a machine-readable `llms.txt` manifest so coding agents inside ClauseOS can tutor, verify exercises against `cx test`, and generate PRs directly against the curriculum specification.
