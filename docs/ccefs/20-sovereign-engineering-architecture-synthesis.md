# Sovereign Engineering Briefing & Synthesis

---

## 1. Document Control, Authority Ranking & SSOT Precedence

The CCEFS engineering initiative and its living reference implementation, **ClauseOS (`clause.os` / `cx`)**, operate under a strict, non-negotiable two-tier **Supreme Single Source of Truth (SSOT)** overlay:

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        SUPREME SINGLE SOURCE OF TRUTH OVERLAY                          │
├────────────────────────────────────────────────────────────────────────────────────────┤
│ TIER 1: LIVE REPOSITORY & FORENSIC AUDIT (ABSOLUTE GROUND TRUTH)                       │
│ • 06-clauseos-source-bundle.md (v0.9.0-dev.1, 195 tracked files)                       │
│ • 05-source-bundle-audit-report.md (Forensic defect ledger)                            │
│ • Note n01-scoop-path-audit (Physical PATH verification & shim isolation)              │
│ RULE: Live codebase (06 -> 05) wins unconditionally over any architectural spec        │
│       or subordinate research text in the event of conflict or drift.                  │
├────────────────────────────────────────────────────────────────────────────────────────┤
│ TIER 2: SUPREME ARCHITECTURAL & CURRICULUM SPECIFICATIONS                              │
│ • docs/ccefs/00-PROJECT-SPECIFICATION-v3.0.md (Vision, Quad Model, 27 Illuminate pkgs)│
│ • docs/ccefs/01-ccefs-30-modules-v4.3.md (Track 1 Master 30-Module Curriculum Map)     │
│ • docs/ccefs/02-stage0-foundation-modules-v4.3.md (Stage 0: Modules 0.1–0.5)          │
│ • docs/ccefs/03-stage1-2-compiler-orchestrator-v4.3.md (Stage 1 & 2: Modules 1–10)     │
│ • docs/ccefs/04-vieo-ai-curriculum-portal.md (4-Track Architecture & AIEFS Index)      │
│ • Canonical ADR Ledger: docs/adr/adr_001 through adr_013                               │
│ • docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md                 │
│ • docs/ccefs/07-clauseos-document-tree-synchronization-plan.md                         │
├────────────────────────────────────────────────────────────────────────────────────────┤
│ SUBORDINATE RESEARCH TAXONOMY (Mechanics, Algorithmic Engines & Lineages)               │
│ • a (a00–a07): Architecture & Design Patterns (Fowler P-EAA, GoF, Laravel, Guardrails) │
│ • b (b00–b23): Software Engineering, AI Agents, Systems Design, MLOps, API Arch        │
│ • c (c00–c99): Contracts, Security Gate ACLs, Storer Zero-Allocation Rules, SLOs      │
│ • d (d01–d99): Engineering Transcripts, Historical Rationale & Design Debates          │
│ • e (e01–e06): AIEFS (AI Engineering From Scratch, Volumes 1–6)                       │
│ • f (f01–f16+): ClauseOS Hermetic Substrate & ADR System                               │
│ • k (k01–k06): Compilers, Interpreters, Stack VMs, Distributed Orchestrators          │
│ • l (l00–l50): Programming Languages, Shells & Tech Specs (19 Target Stacks)          │
│ • r (r01–r22): Claude Code, OpenClaw & Agent Harness Studies                           │
│ • s (s00–s05): Core Protocol Specs (MCP, A2A, Longhorn Harness)                        │
│ • t (t01–t09): Security Whitepapers, APM Specs & Enterprise AI Architecture             │
└────────────────────────────────────────────────────────────────────────────────────────┘
```

*(Grounded in `00-PROJECT-SPECIFICATION-v3.0.md`, `06-clauseos-source-bundle.md`, `05-source-bundle-audit-report.md`, `07-resource-legend`, `08-frame-stage-research-brief-clauseos.md`, and `14-cite-stage-verification-library-clauseos.md`).*

---

## 2. The Centerpiece Thesis & Operational Nomenclature

The foundational paradigm of the entire initiative dictates:
> **"The code is the product, not the end results."**
> **ClauseOS (`clause.os` / `cx`) IS the living reference implementation of Track 1 (CCEFS).**

Following Track 1 from Module 0.1 through Module 25 constructs **ClauseOS itself** from an empty folder inside a bare-metal, zero-leak sandbox (`.home/`). The platform eliminates "vibe coding" and throwaway scripts by treating educational modules as production work orders, verifiable via deterministic binary gates (`cargo test --offline` / `cx test`).

```text
+--------------------------------------------------------------------------------------------------+
|                                    VIEIO CORPORATE STEWARDSHIP                                   |
|                                         (vieo-ai)                                                |
+--------------------------------------------------------------------------------------------------+
                                                 │
                                                 ▼
+--------------------------------------------------------------------------------------------------+
|                            CLAUSEOS HERMETIC SUBSTRATE (`cx`)                                    |
|   • Stage 0/2 Microkernel Trampolines: `cx.bat`, `cx.ps1`, `cx.sh` -> Nushell Router             |
|   • Confinement: `.home/` (AppData/Local KnownFolders & POSIX XDG Redirection)                   |
|   • SSOT Engine: 8-Pass Iterative `${VAR}` Compiler over `config/env/*.toml`                      |
|   • Toolchain Supply Chain: 3-Tier Overlay (Mise + Sterilized Scoop + Confined Brew)             |
|   • Hardware Probes: 5-Way Matrix (AMD ROCm/Strix Halo, Apple Metal, CUDA, Intel, CPU)           |
+--------------------------------------------------------------------------------------------------+
          │                                      │                                      │
          ▼                                      ▼                                      ▼
+-------------------+                  +-------------------+                  +--------------------+
|  CLAUSE LANGUAGE  |                  |  MISSION CONTROL  |                  |    TIGAH NEURAL    |
|   & COMPILER      |                  |   & BACKPLANE     |                  |     COPROCESSOR    |
|  (`.cx` / `cxc`)  |                  |  (`clause_jet`)   |                  |   (`cx hangar`)    |
+-------------------+                  +-------------------+                  +--------------------+
| Upstream-clean    |                  | High-concurrency  |                  | Contained local    |
| fork of Gleam in  |                  | Erlang/OTP 29     |                  | 1B–7B domain SLMs  |
| `packages/clause` |                  | supervision trees |                  | (coder, instruct,  |
| with Monkey-X     |                  | in `packages/     |                  | audio, midi,       |
| multi-target      |                  | clause_jet/`      |                  | vision) anchored   |
| emitters          |                  |                   |                  | to `$HF_HOME`      |
+-------------------+                  +-------------------+                  +--------------------+
```

*(Grounded in `00-PROJECT-SPECIFICATION-v3.0.md` §1.1, `04-vieo-ai-curriculum-portal.md` §2, `06-clause-cxc-blueprint`, `ADR 0001`–`0013`, and `d48-gleam-to-clause-forking`).*

---

## 3. The 4-Track Learning & Platform Architecture (`vieo.ai`)

The **vieo.ai** engineering portal integrates four complementary tracks, utilizing the living-course ergonomics of `aiengineeringfromscratch.com` while reorienting the core completely around **ClauseOS (`.home/`)**, **Clause (`.cx`)**, and **Rust**:

```text
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                               VIEO.AI 4-TRACK CURRICULUM ARCHITECTURE                           │
├─────────┬───────────────────────────────────┬─────────────────────────────┬─────────────────────┤
│ Track   │ Role & Educational Scope          │ Reference Implementation    │ Default Stack       │
├─────────┼───────────────────────────────────┼─────────────────────────────┼─────────────────────┤
│ Track 1 │ CCEFS (Master Track / "The PhD")  │ ClauseOS Monorepo           │ Clause (.cx)        │
│         │ 30 Modules (Stage 0 -> Stage 5):  │ (v0.9.0-dev.1),             │ Systems: Rust       │
│         │ Builds ClauseOS, cxc compiler,    │ Ball Compilers (k01–k03),   │ Runtime: BEAM /     |
|         │ cluster orchestrator, transmedia  │ Boring Orchestrator (k04),  │ Gleam / Pulumi      │
│         │ switchboard, and .enterprise/     │ Storytold Craft, AIEFS      │                     │
├─────────┼───────────────────────────────────┼─────────────────────────────┼─────────────────────┤
│ Track 2 │ Build Claude, OpenClaw & Hermes   │ learn.shareai.run (r01–r14),│ Clause (.cx)        │
│         │ Vertical tracks (2A, 2B, 2C)      │ build-your-own-openclaw     │ Tier 2: Rust        │
│         │ proving how harness patterns live │ (r10, r22),                 │ Targets: TypeScript,│
│         │ natively as Clause keywords       │ Hermes A2A/MCP (s00–s02)    │ WebAssembly, BEAM   │
├─────────┼───────────────────────────────────┼─────────────────────────────┼─────────────────────┤
│ Track 3 │ AIEFS Reference Encyclopedia      │ aiengineeringfromscratch.com│ Clause (.cx)        │
│         │ 6 Volumes, 223 Chapters           │ (e01–e06 Volumes 1–6)       │ Tier 2: Rust        │
│         │ Deep-dive algorithmic references  │                             │ Reference: Python / │
│         │ supporting Tracks 1, 2, and 4     │                             │ PyTorch             │
├─────────┼───────────────────────────────────┼─────────────────────────────┼─────────────────────┤
│ Track 4 │ Bonus: AIEFS Claude Code in .cx   │ AIEFS Claude Code Track     │ Clause (.cx)        │
│         │ Direct port of AIEFS agent track  │ + r14–r22 Deep Dives        │ Tier 2: Rust        │
│         │ onto ClauseOS hermetic userland   │                             │                     │
└─────────┴───────────────────────────────────┴─────────────────────────────┴─────────────────────┘
```

*(Grounded in `04-vieo-ai-curriculum-portal.md` §1, `01-ccefs-30-modules-v4.3.md`, `e01`–`e06`, and `d01-project-document-update`).*

---

## 4. Track 2 Deep-Dive: Native Clause (`.cx`) Agent Keywords

Rather than treating agent mechanics as third-party library wrappers or brittle prompt templates, **Clause (`.cx`)** absorbs the architectures of **Claude Code**, **OpenClaw**, and **Hermes** directly into its language grammar (`packages/clause/crates/clause-core/`):

```text
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                      NATIVE CLAUSE (.cx) HARNESS PRIMITIVES & GUARANTEES                        │
├─────────────────────────┬──────────────────────┬────────────────────────────────────────────────┤
│ External Origin Lineage │ Clause Language Form │ Static & Runtime Verification Guarantee        │
├─────────────────────────┼──────────────────────┼────────────────────────────────────────────────┤
│ Autonomous Agent Unit   │ agent Name { ... }   │ Compiles to supervised Ractor actor (Rust) or  │
│ (Claude Code / OpenClaw)│                      │ OTP gen_statem (BEAM). Directory packaging.     │
├─────────────────────────┼──────────────────────┼────────────────────────────────────────────────┤
│ Streaming Turn Loop     │ loop async           │ Zero-allocation streaming turns with adaptive  │
│ (Track 2A: Claude Code) │ <thinking> stream    │ slot reservation (8K -> 64K). Prompt caching.  │
├─────────────────────────┼──────────────────────┼────────────────────────────────────────────────┤
│ Fail-Closed Tooling     │ tool name(args) -> T │ Read tools auto-batch in parallel; write tools │
│ (Track 2A: Claude Code) │ needs [fs.read]      │ acquire mutexes; mtime verified before edit.   │
├─────────────────────────┼──────────────────────┼────────────────────────────────────────────────┤
│ Schema Alignment & Auto │ expose prompt ->     │ Emits JSON Schema + jet_sap parsing; repairs   │
│ Repair (Jet / Claude)   │   TargetSchema       │ malformed model JSON without extra LLM hops.   │
├─────────────────────────┼──────────────────────┼────────────────────────────────────────────────┤
│ Capability & Sandboxes  │ needs [net.local]    │ Compile-time AST capabilities check; enforced  │
│ (ClauseOS ADR 0001/0011)│ platform [cuda]      │ at runtime by Landlock/Seatbelt + SLM filter.  │
├─────────────────────────┼──────────────────────┼────────────────────────────────────────────────┤
│ Context Compaction      │ compact block        │ 4-tier compaction (snip, micro, analysis,      │
│ (Claude Code / OpenClaw)│ memory (MEMORY.md)   │ /dream); spills tool results >30KB to VFS.     │
├─────────────────────────┼──────────────────────┼────────────────────────────────────────────────┤
│ Converged Gateway       │ gateway { ... }      │ Single-port multiplexed HTTP + WebSocket;      │
│ (Track 2B: OpenClaw)    │ lane [steer, queue]  │ handles mid-turn user steer interruptions.     │
├─────────────────────────┼──────────────────────┼────────────────────────────────────────────────┤
│ Proactive Execution     │ heartbeat every 15m  │ Deterministic SHA-256 jitter-staggered cron    │
│ (Track 2B: KAIROS)      │ schedule cron(...)   │ execution with zero-leak background execution. │
├─────────────────────────┼──────────────────────┼────────────────────────────────────────────────┤
│ Distributed Inter-Agent │ telcom + broadcast   │ Type-safe inter-node RPC; capability cards;    │
│ (Track 2C: Hermes/A2A)  │ a2a.connect()        │ automatic MCP/A2A client and server synthesis. │
└─────────────────────────┴──────────────────────┴────────────────────────────────────────────────┘
```

*(Grounded in `04-vieo-ai-curriculum-portal.md` §3.1, `docs/ccefs/06-blueprint` §3.1, `r08`, `r16`, `r18`, `r22`, and `s00`–`s02`).*

---

## 5. Track 3: The 6-Volume AIEFS Reference Encyclopedia Mapping

The **223 chapters** of *AI Engineering From Scratch* (`e01`–`e06`) provide the formal mathematical, tensor, and algorithmic foundations directly cross-referenced throughout the curriculum:

* **Volume 1: Foundations (Phases 00–02, 52 Ch.):** Matrix algebra, SVD/PCA, autodiff, Log-Sum-Exp, Adam/SGD optimization, isolation forests, SMOTE. Cross-referenced in **CCEFS Modules 0.1–0.5** (`.home/`, GPU detection, `clause-vfs`), **Module 7** (E-PVM scheduling), and **Module 12** (FFT spectral DSP).
* **Volume 2: Deep Learning Core (Phases 03–04, 06, 58 Ch.):** Mini-frameworks, im2col, ViT, YOLO, diffusion/flow matching, 3DGS, RVQ audio codecs (Mimi/EnCodec), Silero VAD, streaming speech-to-speech. Cross-referenced in **CCEFS Modules 12–14** (`oximedia`, `nih-plug`, SoundCraft/FilmCraft/PhotoCraft, 20ms real-time audio buffers).
* **Volume 3: Language & Transformers (Phases 05, 07, 45 Ch.):** Byte-level BPE, BM25 + RRF hybrid search, FSM constrained decoding, causal masking, RoPE, FlashAttention, speculative decoding (EAGLE). Cross-referenced in **CCEFS Modules 1–3** (lexer/parser), **Module 16** (`jet_sap` repair), and **Module 19** (`MEMORY.md` FTS5/vector hybrid search).
* **Volume 4: LLMs & Engineering (Phases 08–11, 68 Ch.):** 124M mini-GPT, DPO/GRPO reinforcement learning, NF4/AWQ quantization, context engineering, LoRA/QLoRA fine-tuning, MCP server engineering. Cross-referenced in **CCEFS Modules 16–21** (agent kernel, tool registries, compact engine, Unsloth 1B–7B domain SLM distillation in `ADR 0013`).
* **Volume 5: Agents & Protocols (Phases 12–16, 137 Ch.):** Multimodal VLMs, tool-use loops, MCP/A2A protocols, memory systems (MemGPT/Mem0), long-horizon planning, multi-agent swarms. Cross-referenced in **CCEFS Modules 20, 22–23** and **Track 2A/2B/2C** (`.enterprise/` organizational governance).
* **Volume 6: Production & Safety (Phases 17–19, 143 Ch.):** vLLM/SGLang serving internals, continuous batching, prefix caching, evaluation gates, guardrails, container sandboxes, capstone pipelines. Cross-referenced in **CCEFS Modules 8–10, 24–25** (HashiStack, `clause-pulumi`, Shore/Lustre, open-core v1.0.0 release).

---

## 6. The Nine Canonical Operational Pillars & 3-Tier Grammar

Under **`ADR 0007`** (Open-Core Substrate vs. Commercial Cartridges), compiler grammar keywords, standard library namespaces (`stdlib/clause/`), and runtime primitives are strictly confined to the **Nine Canonical Operational Pillars** to maintain carrier domain purity:

```gleam
// Canonical Showcase: Demonstrating the 3-Tier Clause (.cx) Grammar
import clause/kernel.{type ProcessId, type VfsLease}
import clause/app.{type ServiceProvider, type Container}
import clause/infra.{type Stack, type Resource}
import clause/deck.{type Surface, type SquawkTelemetry}
import clause/comms.{type Leg, type Trunk, type Dialplan}
import clause/studio.{type Stem, type Bus, Bit24, Hz48000, ItuBs1770_4}
import clause/stage.{type Slate, type Cue, AcesCc, Rec709}
import clause/stream.{type TransportStream, Srt, Cmaf, Widevine, Fast}
import clause/tactical.{type Sortie, type Emcon, Airgap}

@airgap(emcon: Airgap)
@needs([kernel.FsRead, comms.SipTrunk, studio.DanteDsp])
pub agent MasterPlayoutController {
  @hangar(model: "tigah-instruct-7b")

  // Tier 1 Top-Level Keyword: Dialplan Routing
  dialplan InboundBroadcastLeg {
    invite(incoming_leg: Leg) -> {
      use audio_stem <- studio.open_stem(Bit24, Hz48000)
      let pgm_bus: Bus = studio.bus("MCR_Master_Audio")

      // Telecom Bridge & Real-Time DSP Summing
      bridge incoming_leg <-> pgm_bus

      incoming_leg
      |> comms.pcm_stream
      |> studio.rack([studio.high_pass(80.0), studio.loudness_gate(ItuBs1770_4, -23.0)])
      |> studio.record_take(audio_stem)
      |> studio.sum_into(pgm_bus)
    }
  }

  // Tier 1 Top-Level Keyword: Playout Master Control Room
  on mcr.cue(shot: Slate) {
    shot
    |> stage.render_splat("hangar://sets/virtual_production_3dgs")
    |> stage.grade(from: AcesCc, to: Rec709)
    |> stream.pack_cmaf(segment_ms: 2000, chunk_ms: 200)
    |> stream.publish_origin(tier: Fast)
  }

  // Emergency Scram / Tactical Failover
  on tactical.scram(reason: String) {
    comms.drop_all_trunks()
    stage.cut_to_black()
    kernel.trap(fault: "EMERGENCY_SCRAM_TRIGGERED", context: reason)
  }
}
```

*(Grounded in `docs/ccefs/06-blueprint` §3.1, `d48-gleam-to-clause-forking`, `10-triage-stage`, and `11-extract-stage`).*

---

## 7. Codebase Implementation Audit Baseline (`06` vs `05`)

In conformance with the **Source-Code Supremacy Rule**, the physical state in `06-clauseos-source-bundle.md` (v0.9.0-dev.1) governs over all pending roadmap plans. The forensic audit (`05`) and path audit (`n01`) isolate **8 concrete defects** requiring remediation:

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        FORENSIC DEFECT REMEDIATION LEDGER                              │
├────────┬─────────────────────────────┬─────────────────────────────────────────────────┤
│ Defect │ File Location               │ Root Cause & Required Surgical Remediation      │
├────────┼─────────────────────────────┼─────────────────────────────────────────────────┤
│ DEF-01 │ scripts/cli/nu/config/      │ Reads legacy .env; references retired WIN_*     │
│        │   env.nu                    │ variables. Refactor to read compiled TOML envs. │
├────────┼─────────────────────────────┼─────────────────────────────────────────────────┤
│ DEF-02 │ docs/adr/adr_006-micro-     │ Body duplicated from ADR 005 (Model Storage).   │
│        │   instance-virtualization.md│ Restore canonical WSL2/Lima micro-VM spec.      │
├────────┼─────────────────────────────┼─────────────────────────────────────────────────┤
│ DEF-03 │ .github/workflows/ci.yml    │ ./cx.sh test and .\cx.ps1 test commented out.   │
│        │                             │ Uncomment lines 74 & 84 to restore CI gate.     │
├────────┼─────────────────────────────┼─────────────────────────────────────────────────┤
│ DEF-04 │ tests/system/test_stage1.nu │ Checks retired $CLAUSE_APPS_DIR instead of      │
│        │                             │ $MISE_INSTALLS_DIR. Update path assertion.      │
├────────┼─────────────────────────────┼─────────────────────────────────────────────────┤
│ DEF-05 │ tests/env/test_env.{nu,sh}  │ Contains literal paste citation markers.        │
│        │                             │ Strip [cite:...] strings breaking syntax.       │
├────────┼─────────────────────────────┼─────────────────────────────────────────────────┤
│ DEF-06 │ cx.sh                       │ Lacks _CALLER_CLAUSE_STATUS check for nested    │
│        │                             │ subshells. Add recursion preflight bypass.      │
├────────┼─────────────────────────────┼─────────────────────────────────────────────────┤
│ DEF-07 │ plugins/cx-comfyui/hooks/   │ Omits extra_model_paths.yaml bridge. Link       │
│        │   post_install.lua          │ ComfyUI checkpoints directly to $HF_HUB_CACHE.  │
├────────┼─────────────────────────────┼─────────────────────────────────────────────────┤
│ DEF-08 │ installer_scoop.ps1 /       │ Omission of $env:SCOOP\shims from $env:PATH.    │
│        │   cx.ps1 / 20-toolchains    │ Export shims on PATH so Scoop CLI tools work.   │
└────────┴─────────────────────────────┴─────────────────────────────────────────────────┘
```

*(Grounded in `05-source-bundle-audit-report.md`, `n01-scoop-path-audit`, `12-synthesize-stage`, `13-verify-stage`, and `18-batch1-sync`).*

---

## 8. Architectural Synchronization Execution Roadmap

Reconciling the entire repository without destructive rewrites follows the **Carbon Copy + Surgical Diff** principle established in `docs/ccefs/07-clauseos-document-tree-synchronization-plan.md`:

1. **Batch 1 — ADRs & Root Ledgers (Completed / Staged in `18-batch1-sync`):**
   * Restore `ADR 006` (WSL2 / Lima micro-virtualization).
   * Amend `ADR 011` to Clause (`.cx`) / `cxc` Gleam-fork architecture with Monkey-X backends and 9 pillars.
   * Append 2026-11-20 implementation addenda to `ADR 010` (catapult IaC), `ADR 012` (RinG NIF auto-synthesis), and `ADR 013` (TIGAH SLM branding).
   * Update `README.md` (scrub dead `justfile`, add 7-layer architecture, `cxc`), bump `TASK.md` to `v0.9.0-dev.1`, and populate `mkdocs.yml` / `llms.txt`.
2. **Batch 2 — Supreme SSOT Specifications (`docs/ccefs/00`–`04`):**
   * Update `docs/ccefs/00-PROJECT-SPECIFICATION-v3.0.md` to reference Clause (`.cx`), `cxc`, `packages/clause/`, `clause_jet`, TIGAH, and add the `d` (Discussions) prefix to the source inventory.
   * Align `01-ccefs-30-modules-v4.3.md` and `03-stage1-2-compiler-orchestrator-v4.3.md` with the `packages/clause/` (`cxc`) Gleam fork rather than greenfield Rust parser construction.
   * Synchronize `02-stage0-foundation-modules-v4.3.md` and `04-vieo-ai-curriculum-portal.md` to `clause-vfs` (`.ground/`) and Track 2 Clause (`.cx`) / TIGAH branding.
3. **Batch 3 — Substrate Code & Configuration Repairs (`DEF-01` through `DEF-08`):**
   * Apply physical code patches to `scripts/cli/nu/config/env.nu`, `config/env/20-toolchains.toml`, `cx.ps1`, `cx.sh`, `.github/workflows/ci.yml`, `test_stage1.nu`, `test_env.*`, and `plugins/cx-comfyui`.
   * Run `cx test` (executing `tests/system/run_all.nu`) to confirm exit code `0` across Windows, Linux, and macOS.
4. **Stage 1 Compiler Bootstrap Authorization:**
   * Upon green verification across all three platforms, flip governance verdict from **CONDITIONAL PASS** to **FULL PASS**, authorizing active compiler development inside `packages/clause/` (`cxc`).

---

⚡ Would you like to review the unified diff for **Batch 2 (`docs/ccefs/00` through `04`)** to align the curriculum specifications, or proceed directly to generating the physical patch script for **Batch 3 (`env.nu`, `cx.ps1`, `ci.yml`, `20-toolchains.toml`)**?
