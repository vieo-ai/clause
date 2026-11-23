# Vieo.ai Engineering Portal: Curriculum Architecture & Track Blueprint

> **Reading Order (`docs/ccefs/`):** `00-PROJECT-SPECIFICATION-v3.0.md` $\rightarrow$ `01-ccefs-30-modules-v4.3.md` $\rightarrow$ `02-stage0-foundation-modules-v4.3.md` *(Stage 0)* $\rightarrow$ `03-stage1-2-compiler-orchestrator-v4.3.md` *(Stages 1–2)* $\rightarrow$ **`04-vieo-ai-curriculum-portal.md` *(4-Track Portal)***
> **The Centerpiece Thesis:** **"The code is the product, not the end results."**  
> **ClauseOS (`clause.os` / `cx`) IS the living reference implementation of the entire curriculum.**  
> Unlike tutorials that build toy scripts and throw them away, following **Track 1 (CCEFS — The Master Track)** from start to finish builds **ClauseOS itself** from an empty directory—a 100% open-source (MIT / Apache-2.0), forkable, programmable transmedia & cloud software factory that takes total control of userland inside a zero-leak bare-metal sandbox (`.home/`).

---

## 1. The Four-Track Learning Architecture

The **vieo.ai** learning portal adopts the interactive, living-course ergonomics of `aiengineeringfromscratch.com` (runnable code, animated architectural diagrams, self-grading verification gates, and an `llms.txt` agent-readable index), **flipped completely around ClauseOS (`.home/`), Seax (`.cx`), and Rust**:

| Track | Role in Portal | Reference Implementation & Source Lineage | Default Stack |
| :--- | :--- | :--- | :--- |
| **Track 1: CCEFS (The Master Track — Build ClauseOS Itself)** | End-to-end systems engineering flagship (30 Modules: Stage 0 $\rightarrow$ Stage 5). You literally construct **ClauseOS** (`cx`, `seaxc`, `air`, `jet`, `RinG`, HashiStack/Pulumi orchestrator, Craft/Membrane/Kazoo transmedia switchboard, and `.enterprise/`) from an empty folder. | **ClauseOS Monorepo (`v0.9.0-dev.1`)** (`ADR 0001`–`0013`), Ball Compiler Books, Boring Orchestrator, Monkey X, Jet, Storytold Craft, AIEFS, Claude Code, OpenClaw | **Seax (`.cx`)** + **Rust** (`seaxc`, `Ractor`, `seax-vfs`) + BEAM/Gleam/Pulumi |
| **Track 2: Build Your Own Claude, OpenClaw & Hermes** | Three vertical framework tracks (`2A`, `2B`, `2C`) proving how Claude Code, OpenClaw, and Hermes features live natively inside **Seax** as first-class keywords & unified runtime primitives. | `learn.shareai.run/en/` (`r01`–`r14`), `build-your-own-openclaw.kiyo-n-zane.com/` (`r11`, `r22`), Hermes Agent Architecture (`s00`–`s02`) | **Seax (`.cx`)** (default) $\rightarrow$ **Rust** (tier 2) $\rightarrow$ Polyglot targets |
| **Track 3: AIEFS Reference Encyclopedia** | 6-Volume, 223-chapter technical encyclopedia (`Vol. 1–6`) cross-referenced by Track 1 & Track 2 for deep dives on math, ML, vision, speech, NLP, transformers, RL, and LLM engineering. | `aiengineeringfromscratch.com` (`e01`–`e06`) | **Seax (`.cx`)** (default) + **Rust** (`ndarray`/`candle`/custom tensors) + Python/PyTorch reference |
| **Track 4: Bonus Track — AIEFS Claude Code** | Dedicated companion build track porting the AIEFS Claude Code curriculum directly onto ClauseOS's hermetic sandbox, Seax syntax, and Rust tool runners. | AIEFS Claude Code Track + `r14`–`r22` | **Seax (`.cx`)** + **Rust** |

---

## 2. Why "ClauseOS = The Reference Implementation" Changes Everything

1. **100% Open-Source & Forkable at Every Layer (MIT / Apache-2.0):**
   * Every layer you build in Track 1—from the `cx.bat` / `cx.ps1` / `cx.sh` microkernel bootloader and `config/env/*.toml` SSOT engine down to `seaxc`, pure-Rust transmedia codecs (`Craft` / `oximedia` / `nih-plug`), the BEAM/Gleam telecom & OTT backplane (`Kazoo` / `Membrane`), and local neural coprocessors (`Lemonade` / `FastFlowLM` / `InferSSD`)—is permissively licensed and 100% inspectable.
   * Learners and enterprises aren't trapped in a proprietary black-box SaaS: **you own the entire programmable software factory** and can fork, overlay (`config/xx-<custom>.toml`), or extend any layer in place.
2. **Same Monorepo, Every Scale (Stage-Shifted Capabilities):**
   * By completing Track 1, the exact same hermetic userland monorepo runs as:
     * **A local bare-metal developer & AI workstation** (`.home/` sandbox + local GPUs/NPUs + `$HF_HOME`),
     * **A real-time studio & Class 5 telecom softswitch** (`Seax` DSP cascades + `Craft` + `Membrane` + `Kazoo` over BEAM),
     * **An autonomous multi-agent corporation** (`.enterprise/` + `APM` cross-harness lockfiles + contained `1B–7B` domain SLMs), and
     * **A self-healing bare-metal & multi-cloud cluster** (`Nomad` / `Consul` / `Vault` / `Pixiecore` / `Pulumi` cloud bursting & detachment).
3. **Zero Toy Throwaway Code:**
   * Every chapter's verification gate runs against real ClauseOS workspace checks (`cx test` / `run_all.nu` and `cargo test --offline`). Your passing homework *is* a working subsystem of ClauseOS.

---

## 3. Track 2 Deep-Dive: Claude, OpenClaw & Hermes Unified Inside Seax

Rather than maintaining three incompatible agent frameworks, **Seax** absorbs the core mechanics of **Claude Code**, **OpenClaw**, and **Hermes** directly into the language grammar (`crates/seax-token`, `crates/seax-parser`, `crates/seax-checker`) and standard runtime (`crates/seax-agent`):

### 3.1 How External Agent Patterns Become Native Seax Keywords

| Concept / Feature | Origin Track | Seax Language Keyword / Primitive | Compile-Time & Runtime Guarantee (`seaxc`) |
| :--- | :--- | :--- | :--- |
| **Autonomous Agent Unit** | Claude Code + OpenClaw + Hermes | `agent Name { ... }` & directory packaging (`agent.cx`, `skills/`, `mcp/`, `package.seax`) | Compiles to a supervised `Ractor` actor (`--target rust`) or OTP `gen_statem` (`--target beam`). |
| **Streaming Turn Loop & Thinking** | Track 2A: Claude Code (`learn.shareai.run`) | `loop async` + `<thinking>` stream channel + `..` cascade middleware | Zero-allocation streaming turn loop with automatic slot reservation (`8K` $\rightarrow$ `64K`). |
| **Typed Tool Contracts & Parallel Batching** | Track 2A: Claude Code (`buildTool`, `mtime` guards) | `tool name(args) -> Result<T, Err>` + `needs [fs.read]` | Read-only tools auto-batch in parallel; write tools acquire path-scoped mutexes; `mtime` checked before edit. |
| **Schema-Aligned Output & Repair** | Jet (`jet_sap`) + Claude Code | `expose prompt -> TargetSchema` | Compiler generates JSON Schema + `jet_sap` parser that repairs malformed model JSON without extra LLM round-trips. |
| **Capability & Sandbox Gates** | ClauseOS (`ADR 0001`, `ADR 0011`) + Claude Code | `needs [net.local, fs.worktree]` & `platform [cuda, seatbelts]` | Checked statically by `seax-checker` before codegen; enforced at runtime by OS sandbox + 2-stage SLM classifier. |
| **4-Tier Context Compaction & Memory** | Track 2A: Claude Code + Track 2B: OpenClaw | `compact` block + `memory` (`MEMORY.md` + `/dream` consolidation) | Preserves `SYSTEM_PROMPT_DYNAMIC_BOUNDARY` for 90%+ KV-cache hits; spills tool outputs >30KB to `seax-vfs`. |
| **Multi-Channel Gateway & Lanes** | Track 2B: OpenClaw (`build-your-own-openclaw`) | `gateway` + `channel` + `lane [steer, queue, collect]` | Single-port converged WebSocket/HTTP server with 7-level routing cascade and idempotency keys. |
| **Proactive Heartbeats & Cron** | Track 2B: OpenClaw (`KAIROS`) | `heartbeat every 15.min` & `schedule cron(...)` | `SHA-256` jitter-staggered background execution with traceless state updates. |
| **Agent-to-Agent Mesh & Discovery** | Track 2C: Hermes + `A2A` (`s02`) + `MCP` (`s00`) | `telcom` + `broadcast` + `mcp.serve()` / `a2a.connect()` | Typed inter-agent RPC, capability advertisement, and zero-boilerplate MCP/A2A server/client generation. |

### 3.2 Track 2 Sub-Curricula (Seax Default + Rust Tier 2)

* **Track 2A — Build Your Own Claude Code in Seax (`learn.shareai.run` Port):**
  1. *The Streaming Agent Loop (`while(true)`)* — Implementing `AsyncGenerator` turns, provider normalization (`Lemonade`/`InferSSD`/Anthropic/OpenAI), and `<thinking>` streams in Seax (`agent.cx`) and Rust.
  2. *Fail-Closed `tool` Execution & `mtime` Protection* — Building `read_file`, `edit_file` (with quote normalization and `mtime` staleness checks), `bash` (with AST command screening), and `30KB` `seax-vfs` spillovers.
  3. *Multi-Gate Permissions & 2-Stage Classifier* — Enforcing `needs`/`platform` at compile time and running a contained `1B–3B` domain SLM classifier (`ADR 0013`) with `2s` timeouts at runtime.
  4. *4-Tier `compact` & `/dream` Memory Consolidation* — Implementing tool-result budgeting, snip, cached microcompact, `<analysis>` autocompact, and 4-phase background `/dream` consolidation over `MEMORY.md`.
  5. *Subagent Swarms & Worktree Isolation* — Spawning isolated `.worktrees/` subagents with atomic `os.rename` mailboxes and adversarial gatekeeper checks (`cx test`).

* **Track 2B — Build Your Own OpenClaw in Seax (`build-your-own-openclaw` Port):**
  1. *Converged Single-Port `gateway`* — Building the multiplexed HTTP + WebSocket control plane (`req`/`res`/`event` frames with idempotency keys) in Seax (`--target rust` / `--target beam`).
  2. *7-Level `channel` Binding Cascade* — Routing inbound messages across CLI, Portable VS Code, Shore TUI, Lustre Web, Slack, Discord, and Telegram to isolated agent sessions.
  3. *Concurrency `lane` Semantics (`steer`, `queue`, `collect`)* — Managing live mid-turn user interruptions (`steer`), sequential queuing, and batched multi-message collection (`collect`).
  4. *`KAIROS` Heartbeats & Staggered Cron* — Deterministic `SHA-256` jittered cron scheduling and background `heartbeat` wakeups that act only when state thresholds trigger.
  5. *Cross-Harness `APM` & `MCP` Host* — Mounting external `MCP` servers (`stdio`/`SSE`) and locking skills via `apm.yml` / `apm.lock.yaml` so Claude Code, Codex, Cursor, Gemini, and Seax agents share one deterministic userland.

* **Track 2C — Build Your Own Hermes in Seax (Distributed Agent Mesh & Telemetry):**
  1. *Typed `telcom` & `broadcast` Envelopes* — Designing zero-copy actor mailboxes and pub/sub event buses across local `Ractor` threads and remote BEAM nodes.
  2. *A2A (`Agent-to-Agent`) Protocol & Capability Cards* — Advertising agent `expose` schemas and delegating sub-tasks across heterogeneous agent nodes with Vault-leased capability tokens.
  3. *Multi-Agent Consensus & Adversarial Review* — Implementing proposer/critic/gatekeeper topologies where Hermes routes diffs through `security_audit` and `documentation_qa` agents before merge.
  4. *Distributed Tracing & `Shore`/`Lustre` Live Telemetry* — Streaming OpenTelemetry spans, token budgets, and KV-cache hit rates into the terminal (`Shore`) and web (`Lustre`) cockpits.

---

## 4. Track 3: AIEFS Reference Encyclopedia (`Vol. 1–6` Cross-Reference Map)

Because **AIEFS (*AI Engineering From Scratch*, `aiengineeringfromscratch.com`)** consists of focused, self-contained mini-courses on mathematical and algorithmic primitives rather than full end-to-end applications, **vieo.ai** positions it as the **Reference Encyclopedia** supporting Tracks 1, 2, and 4. Every encyclopedia entry provides:

1. **Default Seax (`.cx`) Implementation** (using Seax tensor/math primitives and `..` cascades)
2. **Rust Systems Implementation** (zero-allocation `crates/*` implementation)
3. **Python / PyTorch / JAX Reference** (original AIEFS baseline for cross-verification)

| AIEFS Volume & Phases | Encyclopedia Domain | Key Chapters & Algorithms | Where Referenced in CCEFS & Agent Tracks |
| :--- | :--- | :--- | :--- |
| **Vol. 1: Foundations** (`Phases 00–02`, 52 Ch.) | Setup, Linear Algebra, Calculus, Autodiff, Probability, Bayes, Optimization, Info Theory, SVD, Tensors, Numerical Stability, Classical ML | Value-based autograd, SVD/PCA, Gram-Schmidt, Log-Sum-Exp, Adam/SGD, KDE/GMM, Isolation Forest, SMOTE | **CCEFS Modules 0.1–0.5** (`.home/` setup, GPU matrix, `seax-vfs`), **Module 7** (E-PVM scoring), **Module 12** (FFT/spectral DSP) |
| **Vol. 2: Deep Learning** (`Phases 03–04, 06`, 58 Ch.) | Neural Core, Computer Vision (CNNs, ViT, YOLO, U-Net, Diffusion, DiT, 3DGS, SAM 3, VLMs), Speech & Audio (STFT/Mel, Whisper, TTS, Codecs, VAD, Moshi) | Mini-framework (`Module`, `Linear`, `AdamW`), Im2col, RoIAlign, DDPM/Flow Matching, RVQ (`Mimi`/`EnCodec`), Silero VAD, Full-duplex S2S | **CCEFS Modules 12–14** (`oximedia`, `nih-plug`, `SoundCraft`/`FilmCraft`/`PhotoCraft`, real-time `20ms` audio ring buffers) |
| **Vol. 3: Language** (`Phases 05, 07`, 45 Ch.) | NLP Foundations (BPE/Unigram, BM25, Hybrid RRF, NER, Coref, Knowledge Graphs, RAGAS) & Transformers (Self/Multi-Head Attention, RoPE, MoE, KV Cache, Flash Attention, Speculative Decoding) | Byte-level BPE, BM25 + RRF + Cross-Encoder, FSM Constrained Decoding, Causal Mask, GQA/MLA, PagedAttention, EAGLE | **CCEFS Modules 1–3** (Lexer/Parser/Grammar), **Module 16** (`jet_sap` constrained decoding), **Module 19** (`MEMORY.md` FTS5 + vector hybrid search & KV-cache alignment) |
| **Vol. 4: LLMs** (`Phases 08–11`, 68 Ch.) | Generative AI, Reinforcement Learning (MDP, PPO, GRPO, MARL), LLMs from Scratch (Pre-training, FSDP, SFT, RLHF, DPO, Constitutional AI, Quantization, DualPipe, NSA, MTP), LLM Engineering (Context Engineering, RAG, LoRA/QLoRA, Function Calling, Guardrails, MCP) | 124M Mini-GPT, Bradley-Terry RM, DPO/GRPO, NF4/GPTQ/AWQ quantization, Lost-in-the-Middle reordering, HyDE, Parent-Child chunking, MCP servers | **CCEFS Modules 16–21** (Agent kernel, `tool` registry, `compact` engine, `MCP` hosts, **Unsloth** domain SLM distillation & quantization in `ADR 0013`) |
| **Vol. 5: Agents** (`Phases 12–16`) | Multimodality, Protocols (`MCP`, `A2A`), Autonomy, Long-Horizon Planning, Multi-Agent Swarms | Tool orchestration, memory architectures, multi-agent coordination, verification loops | **CCEFS Modules 20, 22–23** & **Track 2A/2B/2C** (Claude Code, OpenClaw, Hermes, `.enterprise/` governance) |
| **Vol. 6: Production** (`Phases 17–19`) | Infrastructure, Safety, Observability, Capstones | Telemetry, sandboxing, evaluation gates, deployment pipelines | **CCEFS Modules 8–10, 24–25** (HashiStack, `pulumi-gestalt`, `Shore`/`Lustre`, Open-Core `v1.0.0` release) |

---

## 5. Track 4: Bonus Track — AIEFS Claude Code in Seax

To bridge learners coming from the AIEFS ecosystem directly into **ClauseOS**, **Track 4** presents the **AIEFS Claude Code Track** ported end-to-end into **Seax** and **Rust**:

* **Side-by-Side Idiom Translation:** Every chapter shows the concise **Seax (`.cx`)** native construct (`agent`, `tool`, `compact`, `memory`, `expose -> Schema`, `needs`) alongside its **Rust** systems implementation and the original Python reference.
* **Zero-Setup Execution Inside ClauseOS:** Learners clone the repository, run `cx` (or `./cx.sh`), and execute every lab offline inside `.home/` using local neural coprocessors (`Lemonade` / `InferSSD`)—zero API keys or host pollution required.
* **Agent-Ready `llms.txt` & `.ground` Index:** Every module on **vieo.ai** exposes a machine-readable `llms.txt` manifest so coding agents inside ClauseOS can tutor, verify exercises against `cx test`, and generate PRs directly against the curriculum specification.
