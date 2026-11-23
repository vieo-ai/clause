# Clause (`.cx`) & `cxc`: Gleam Fork Refactoring & Multi-Target Transpilation Blueprint

> **Document Status:** Canonical Architectural Blueprint (SSOT Aligned)
>
> **Parent Steward:** Vieo (`vieo-ai`)
>
> **Substrate:** ClauseOS (`cx` — Carrier Exchange)
>
> **Language & Compiler:** Clause (`.cx`) in `packages/clause/` $\rightarrow$ CLI binary `cxc` (`cxc run`, `cxc build`, `cxc check`)
>
> **Neural & Agentic Stack:** TIGAH (*Transmedia Intelligent Generative Autonomous Hermetic*) + `packages/clause_jet/`
>
> **Governing References:** `00-PROJECT-SPECIFICATION-v3.0.md`, `01-ccefs-30-modules-v4.3.md`, `03-stage1-2-compiler-orchestrator-v4.3.md`, `ADR 0001`–`0013`

## 1. Strategic Thesis & Ecosystem Nomenclature

Rather than building a disconnected collection of scripts, YAML manifests, and fragile Python/TypeScript wrappers, ClauseOS forks and extends **`gleam-lang/gleam`** inside **`packages/clause/`**—emitting the **`cxc`** compiler CLI binary (`cxc run`, `cxc build`, `cxc check`, `cxc lsp`) for the **Clause (`.cx`)** programming language.

### 1.1 Canonical Naming Hierarchy (`Vieo` $\rightarrow$ `ClauseOS` $\rightarrow$ `TIGAH` $\rightarrow$ `Clause`)

| Tier | Name | Artifact / Surface | Architectural Role |
| ----- | ----- | ----- | ----- |
| **Parent Organization** | **Vieo** | `vieo-ai` | Sovereign commercial steward and open-core engineering organization (`ADR 0007`). |
| **Operating Substrate** | **ClauseOS (`cx`)** | `cx.bat`, `cx.ps1`, `cx.sh` $\rightarrow$ Nushell Router (`boot.nu`) | **Carrier Exchange (`cx` / `carrier` / `clause`)**: Bare-metal hermetic userland (`.home/`), 8-pass `config/env/*.toml` SSOT compiler, `Mise` overlays (`MISE_ENV="paths,ai,cloud"`), and polyglot package build/test router. |
| **Programming Language** | **Clause (`.cx`)** | `*.cx` source files, `clause.toml` manifests | Carrier-class functional-systems & transmedia programming language retaining 100% of Gleam's Hindley-Milner type system, algebraic data types, exhaustive pattern matching, via pipes, `use` callbacks, and `@external` FFI, extended with 9 canonical operational pillars. |
| **Compiler Toolchain & CLI** | **`cxc`** | `packages/clause/` $\rightarrow$ `${CLAUSE_BIN_DIR}/cxc` | **Clause Compiler CLI**: Forked from `gleam-lang/gleam` inside `packages/clause/` (written in Rust) and extended with Monkey-X (`transcc`) multi-target code generators (`--target beam`, `--target rust`, `--target client`). Replaces `gleam run` with `cxc run`. |
| **Neural & Agentic Tier** | **TIGAH** & **`clause_jet`** | `packages/clause_jet/`, `packages/tigah/` + `${HF_HOME}` | **TIGAH** (*Transmedia Intelligent Generative Autonomous Hermetic*): Contained `1B–7B` domain SLMs (`tigah-coder`, `tigah-instruct`, `tigah-audio`, `tigah-midi`, `tigah-vision`) running on local NPU/GPU coprocessors (`Lemonade`, `FastFlowLM`, `InferSSD`, `Unsloth`) + **`packages/clause_jet/`** OTP agent runtime (`build/erlang-shipment/entrypoint.{ps1,sh}`). |

### 1.2 Why Forking Gleam + Adding `Target::Rust` Is the Decisive Move

1. **Preserves Gleam's Sound ML Frontend (Zero Rewrite Tax):**

   Retains Gleam's Rust lexer, fault-tolerant parser, Hindley-Milner type inference engine, exhaustive pattern-matching checker, formatter, and Language Server (`clause-lsp`), immediately guaranteeing type-safe wiring across complex audio graphs, telecom state machines, and infrastructure DAGs.

2. **Eliminates Upstream Churn (`ADR 0007` Sovereignty):**

   Forking and rebranding into `packages/clause/` (emitting `cxc`) removes dependency on upstream Gleam release cadence while keeping full compatibility with the BEAM/Erlang/Elixir ecosystem (`erlang = "29.1.2"`, `elixir = "1.20.4-otp-29"`, `gleam = "1.19.2"`).

3. **True Dual-Plane Execution (`BEAM` Control Plane + `Rust` Data Plane):**

   * **BEAM (`--target beam`):** Compiles control planes, `dialplan` switches, `agent` loops, `mcr` playout controllers, and infrastructure supervisors into Core Erlang / `.beam` bytecode with preemptive 2,000-reduction scheduling, isolated \~2.5 KB per-process heaps, 9-nines supervision trees, and hot-code upgrades.

   * **Native Rust (`--target rust`):** Compiles compute-critical and zero-allocation hot paths (`rack`, `bus`, `stem`, `grade`, `stage`, `infra`) directly into native Rust crates linked to `oximedia`, `nih-plug` (VST3/CLAP), the Storytold `Craft` suite (`SoundCraft`, `FilmCraft`, `PhotoCraft`, `EffectCraft`, `CADCraft`, `WordCraft`, `GridCraft`), and revived `pulumi-gestalt` (`crates/clause-pulumi`).

   * **Client / Edge (`--target client`):** Compiles UI surfaces and sandboxed plugins to TypeScript / ES6 and WebAssembly (`clause-wasm`) powering `Lustre` (Web/SSR), `Plushie` (Native Desktop), `Shore` (TUI), `Open Stage Control / O2K` (Tactile Touch Glass), and `Extism` plugins.

## 2. Updated 7-Layer ClauseOS System Architecture

Reconciling the BEAM Microkernel topology, the `cJAG` (*Carrier, Jet, Air, Ground*) execution model, and the **Clause / `cxc` / `clause_jet` / TIGAH / Mission Control** nomenclature into one unified stack:

```text
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ LAYER 6: PRESENTATION & FLIGHT DECK (`cx deck` / `capcom`)                               │
│ • Multi-Surface Elm/MVU Cockpit: `Lustre` (Web/SSR), `Plushie` (Desktop), `Shore` (TUI), │
│   `Open Stage Control / O2K` (Tactile Touch Glass) & `Portable VS Code` (`cx-vscode`)    │
│ • Single-Channel HITL Operator Gateway (`capcom`) & Live `squawk` Telemetry Wall         │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ LAYER 5: AUTONOMOUS VIRTUAL ENTERPRISE & COMMERCIAL CARTRIDGES (`.enterprise/` & `.apm/`) │
│ • Board (`constitution.toml`), C-Suite (`ceo`/`cto`/`cpo`), & Core Departments           │
│ • Optional Commercial Vertical Cartridges (`ADR 0007` — HIPAA, FinTech, Legacy ERP)      │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ LAYER 4: TIGAH INTELLIGENCE & CARRIER DOMAIN ENGINES (`packages/clause_jet` & `packages/*`)│
│ • TIGAH Neural Tier (`cx hangar`): Contained 1B–7B SLMs (`tigah-coder`, `tigah-audio`,   │
│   `tigah-instruct`, `tigah-vision`) on `Lemonade`, `FastFlowLM`, `InferSSD`, `Unsloth`   │
│ • `cx air` (Transmedia, Telecom & Streaming): `Membrane`, `Kazoo`, `Kamailio`,           │
│   `RTPEngine`, `TVHeadend`, `TSDuck`, `Shaka CMAF`, `CasparCG`, `OTIO`, `DDEX` / `C2PA`  │
│ • `cx jet` (`packages/clause_jet/`): Directory-scoped `agent.cx` swarms, `MCP`/`A2A`     │
│   routers, `crates/clause-pulumi` (`catapult` IaC), `Nomad`, `Consul`, `Vault`, `Pixiecore`│
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ LAYER 3: CLAUSE LANGUAGE, COMPILER & NATIVE SILICON BRIDGE (`packages/clause` / `cxc`)   │
│ • `packages/clause/` (`cxc` CLI): Multi-target Monkey-X (`transcc`) compiler translating  │
│   `.cx` into `--target beam` (OTP), `--target rust` (Native), and `--target client`      │
│ • Native Rust Silicon (`--target rust` & `tools/ring` NIFs): Zero-allocation `oximedia`, │
│   `nih-plug` (VST3/CLAP), Storytold `Craft` suites (`SoundCraft`/`FilmCraft`/etc.)       │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ LAYER 2: BEAM MICROKERNEL & DISTRIBUTED BACKPLANE (Erlang/OTP 29 + Elixir + Gleam)       │
│ • Preemptive 2,000-reduction scheduler, isolated per-process heaps (~2.5 KB), 9-nines    │
│   OTP supervision trees (`kernel` / `init`), hot-code swaps, `los`/`aos` mesh recovery   │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ LAYER 1: CLAUSEOS HERMETIC SUBSTRATE & STAGE 0/2 BOOTLOADER (`cx` / `.home/` / `.ground/`)│
│ • `cx` Carrier Exchange (`cx.bat`, `cx.ps1`, `cx.sh` -> Nushell `boot.nu` router)        │
│ • 8-pass `config/env/*.toml` SSOT compiler, `.home/` zero-leak sandbox (`ADR 0001`)      │
│ • `.ground/` content-addressed VFS (`xxHash64`/`SHA-256`), `HNSW` vector truth & `blackbox`│
│ • `Mise` overlays (`MISE_ENV="paths,ai,cloud"`), patched `Scoop`, confined `Brew`, `cx vm` │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ LAYER 0: HOST HYPERVISOR & SILICON HAL (Windows NT / Linux / macOS + `eecom` Probes)     │
│ • Bare-metal CPU/RAM/PCIe & 5-way GPU/NPU Matrix (`ROCm`, `XDNA2`, `CUDA`, `Metal`)      │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

## 3. The 9 Canonical Operational Pillars & Domain Purity Rule

### 3.1 Domain Boundary Rule (`ADR 0007` Compliance)

ClauseOS and `cxc` are strictly scoped to **9 canonical carrier, transmedia, systems, and AI pillars**. Generic consumer verticals (e.g., retail/bakery packs) and regulated non-carrier industries (Healthcare/HIPAA, Legal, Retail Finance) are **explicitly excluded** from `cxc`'s core grammar and standard library; where needed, they live strictly as optional commercial `.enterprise/` / `.apm/` cartridges built *on top* of ClauseOS.

### 3.2 Complete 9-Pillar Lexicon Matrix

| \# | Pillar (`clause/*` Namespace) | Canonical Industry Scope | Core Domain Terms | Primary Target Compilation |
| ----- | ----- | ----- | ----- | ----- |
| **1** | **Systems & Microkernel** (`clause/kernel`) | OS internals, bare-metal confinement, sandboxing, DevOps/SecOps supply chains | `kernel`, `init`, `syscall`, `trap`, `pcb`, `hal`, `driver`, `vfs`, `inode`, `vmm`, `fault`, `microvm`, `overlay`, `pin`, `sandbox`, `lease`, `gate`, `sbom` | `--target beam` (`OTP` `PID 1`) + `--target rust` (`Landlock`/`Seatbelt`/`VFS`) |
| **2** | **Service Providers & Container Lifecycle** (`clause/app`) | Otwell/Laravel DI container, two-phase boot, lazy deferral, asset publishing | `service_provider`, `register`, `boot`, `defer`, `contract`, `bind`, `singleton`, `scoped`, `publish` | `--target beam` (`DynamicSupervisor`) + `--target rust` (`OnceLock`/`Arc`) |
| **3** | **Cloud Providers & Pulumi IaC** (`clause/infra`) | Revived `pulumi-gestalt` (`crates/clause-pulumi`), bare-metal MaaS (`Pixiecore`/`Packer`), cloud burst/detach | `infra`, `provider`, `stack`, `resource`, `output`, `preview`, `up`, `refresh`, `destroy`, `drift`, `reconcile`, `catalog`, `burst`, `detach`, `tenant`, `quota`, `image`, `pxe` | `--target rust` (`clause-pulumi`) driven by `--target beam` actors |
| **4** | **Aviation & NASA Mission Control** (`clause/mission`, `clause/deck`) | Carrier-deck control plane, DSN flight operations, Elm/MVU flight deck surfaces | `cx`, `cxc`, `jet`, `air`, `ground`, `deck`, `hangar`, `catapult`, `squawk`, `capcom`, `fido`, `eecom`, `gnc`, `uplink`, `downlink`, `go_nogo`, `los`, `aos`, `safe_mode`, `surface`, `model`, `update`, `view` | `--target beam` + `--target client` (`Lustre`/`Plushie`/`Shore`/`O2K`) |
| **5** | **Telecom & Carrier Switching** (`clause/comms`) | Kazoo Class 5 softswitch, Kamailio SBC, FreeSWITCH/RTPEngine, SIP/WebRTC trunking | `sbc`, `trunk`, `leg`, `bridge`, `dialplan`, `acd`, `cdr`, `handoff` | `--target beam` (`Kazoo`/`gen_statem`) + `--target rust` (`RTPEngine`/`oximedia`) |
| **6** | **Recording & Music Publishing** (`clause/studio`) | Zero-allocation audio DSP (`oximedia`, `nih-plug`, `SoundCraft`), DAW bridges, `DDEX`/`CISAC` rights & accounting | `stem`, `bus`, `rack`, `master`, `patchbay`, `take`, `split`, `dub`, `residual`, `recoup`, `clearance` | `--target rust` (zero-alloc DSP + `C2PA`/`audiowmark`) + `--target beam` (`DDEX`/ledger) |
| **7** | **Film, Broadcast & Virtual Production** (`clause/stage`) | Mezzanine post (`ACEScc`, `OTIO`), `3DGS` virtual sets, `FilmCraft`/`CADCraft`, show control (`NDI`/`OSC`/`MIDI`/`DMX`/`SMPTE`) | `slate`, `reel`, `grade`, `stage`, `splat`, `mcr`, `playout`, `cue`, `timecode`, `osc`, `midi`, `dmx`, `ndi`, `viewport` | `--target rust` (`FilmCraft`/`OpenColorIO`) + `--target beam` (`CasparCG`/`Membrane`) |
| **8** | **IPTV, OTT & Streaming** (`clause/stream`) | Linear/VOD headends (`TVHeadend`, `TSDuck`), `SRT`/`RIST` ingest, `ABR` transcoding, `CMAF`, `CPIX` DRM, `SCTE-35`, `WebRTC` SFU | `headend`, `mux`, `ingest`, `srt`, `rist`, `transcode`, `abr`, `cmaf`, `manifest`, `drm`, `cpix`, `epg`, `scte35`, `origin`, `shield`, `sfu`, `simulcast`, `vod`, `svod`, `fast` | `--target beam` (`Membrane`/`TVHeadend`) + `--target rust` (`Shaka`/`NVENC`) |
| **9** | **Military, Tactical & TIGAH AI** (`clause/tactical`, `clause/tigah`) | Zero-trust RF/field links, `EMCON`/airgap survivability, `Vault` ciphers, `TIGAH` autonomous agent harnesses (`MCP`/`A2A`) | `sortie`, `emcon`, `airgap`, `mesh`, `cipher`, `scram`, `agent`, `skill`, `tool`, `memory`, `compact`, `gateway`, `lane`, `heartbeat`, `expose`, `hooks`, `latch` | `--target beam` (`OTP` agent loops) + `--target rust` (`Sandbox`/`SLM` FFI) |

## 4. Three-Tier Compiler Grammar Strategy (Zero Keyword Bloat)

Because we preserved 100% of Gleam’s ML/Rust/Elm core—the Hindley-Milner type inference engine, algebraic data types, exhaustive pattern matching, pipe operator (`|>`), `use` callbacks, and `@external` FFI—**Clause (`.cx`)** avoids keyword soup by splitting the 9-pillar lexicon into **three crisp syntactic tiers**. Common domain nouns (`bus`, `leg`, `stage`, `stem`, `rack`, `tool`, `model`) remain legal as local variable names (`let stem = ...`) while receiving full static verification from `cxc`.

### 4.1 Tier 1: Top-Level Declarative Block Keywords (`Definition` AST Nodes)

Added to `clause-core/src/parse/token.rs` and `ast.rs` alongside Gleam's existing `fn`, `type`, `pub`, `import`, `const`—reserved strictly for major architectural units that compile into supervised processes, hardware graphs, or boundary contracts:

| Keyword | Domain Pillar | What It Declares & Compiles To (`cxc`) |
| ----- | ----- | ----- |
| **`kernel`** | Systems (`clause/kernel`) | Root `PID 1` supervision tree (`kernel ClauseRoot { ... }`) $\rightarrow$ OTP `application` supervisor (`--target beam`) + Rust runtime guard (`--target rust`). |
| **`service_provider`** | Container (`clause/app`) | Two-phase DI lifecycle module (`register` / `boot` / `defer`) $\rightarrow$ OTP `DynamicSupervisor` child specs (`--target beam`) + Rust `OnceLock`/`Arc` builder (`--target rust`). |
| **`infra` / `provider`** | Cloud / Pulumi (`clause/infra`) | Typed Pulumi resource DAG (`infra`) and driver binding (`provider`) $\rightarrow$ `crates/clause-pulumi` native Rust resource graphs (zero YAML). |
| **`agent`** | AI / TIGAH (`clause/tigah`) | Autonomous directory/process operative (`agent ShowDirector { ... }`) $\rightarrow$ OTP `gen_statem` (`--target beam`) or `Ractor` actor (`--target rust`) with compiled JSON schemas (`jet_sap`). |
| **`gateway`** | AI / Comms (`clause/tigah`, `clause/comms`) | Multi-channel ingress/egress hub (`MCP`, `A2A`, `WebSocket`, `SIP`) with `steer` / `queue` / `collect` lane scheduling. |
| **`trunk` / `bridge` / `dialplan`** | Telecom (`clause/comms`) | Carrier SIP/WebRTC artery (`trunk`), zero-copy RTP/audio matrix (`bridge a_leg <-> b_leg`), and Class 5 pattern-matched call router (`dialplan`) $\rightarrow$ Kazoo/RTPEngine (`--target beam`) + `oximedia` (`--target rust`). |
| **`bus` / `rack` / `patchbay` / `split`** | Recording (`clause/studio`) | Zero-allocation audio summing graph (`bus`), serial DSP chain (`rack`), PTP clock/I/O matrix (`patchbay`), and 100%-sum rights contract (`split`) $\rightarrow$ `nih-plug` / `SoundCraft` (`--target rust`). |
| **`stage` / `mcr`** | Film / Broadcast (`clause/stage`) | 3DGS/LED virtual production volume (`stage`) and 24/7 Master Control Room playout (`mcr`) $\rightarrow$ `FilmCraft` (`--target rust`) + `CasparCG`/`Membrane` (`--target beam`). |
| **`headend`** | IPTV / OTT (`clause/stream`) | Linear/VOD signal acquisition, `ABR` transcode, `CMAF` packaging, `CPIX` DRM, and `SCTE-35` splice pipeline $\rightarrow$ `TVHeadend`/`Membrane` + `Shaka Packager`. |
| **`airgap` / `sortie`** | Tactical / Aviation (`clause/tactical`, `clause/mission`) | Static `EMCON` egress-isolation boundary (`airgap`) and ephemeral compute/cloud burst envelope (`sortie`) $\rightarrow$ `Landlock`/`Seatbelt` + `Nomad`/`clause-pulumi`. |

### 4.2 Tier 2: Contextual Clauses, `@Attributes` & Built-In Prelude Types

Leverages Gleam's existing `@attribute` syntax (`@external`, `@deprecated`) and static type checker so domain contracts are verified at compile time with zero variable-name collisions:

* **Compiler & Runtime `@Attributes`:**

  * `@hangar(model: "tigah-audio-7b")` — Binds contained local SLM weight manifest from `${HF_HOME}`.

  * `@airgap(emcon: LocalOnly)` — Static egress check forbidding external HTTP/DNS routes at compile time.

  * `@needs([FsRead, DanteIo, VaultLease("secret/c2pa")])` — Hermetic capability gate enforced statically by `cxc` and at runtime by OS sandboxes (`Landlock`/`Seatbelt`).

  * `@squawk(max_retries: 3, circuit_breaker: 50ms)` — Configures OTP supervision & telemetry thresholds.

  * `@go_nogo(eecom: True, fido: True, gnc: True)` — Pre-launch readiness gate blocking execution on any `NoGo`.

  * `@clearance(split: ReleaseRights)` — Verifies chain-of-title and `SAG-AFTRA`/`AFM` residual rules before `master.bounce` or `playout`.

* **Contextual Block Clauses:**

  * `register(app) { ... }`, `boot(app) { ... }`, `defer provides: [...]` (inside `service_provider`)

  * `bridge a_leg <-> b_leg` (bidirectional media matrix binding)

  * `on los(duration) { ... }`, `on aos(peer) { ... }`, `on scram(reason) { ... }`, `on epg.ad_break(ms) { ... }`

  * `expose prompt -> TargetSchema` (generates JSON Schema + `jet_sap` deterministic repair parser)

* **Zero-Cost Prelude Types (`clause/prelude`):**

  * `Leg`, `Trunk`, `Stem(Bits, SampleRate)`, `Slate(ColorSpace)`, `Reel`, `SrtStream`, `CmafBundle`, `DrmPolicy`, `Cue`, `Timecode`, `Residual`, `Sortie`, `Pcb`, `Inode`, `Lease`, `Output(a)`.

### 4.3 Tier 3: Unified `clause/*` Standard Library Namespaces (`stdlib/clause/`)

Every operational primitive across all 9 pillars composes through Gleam's pipe operator (`|>`) and `use` resource scopes:

* `clause/kernel` — `init`, `syscall`, `trap`, `pcb`, `hal`, `driver`, `vfs`, `inode`, `vmm`, `fault`, `microvm`, `overlay`, `pin`, `sandbox`, `lease`, `gate`, `sbom`

* `clause/app` — `service_provider`, `contract`, `bind`, `singleton`, `scoped`, `publish`

* `clause/infra` — `provider`, `stack`, `resource`, `output`, `preview`, `up`, `refresh`, `destroy`, `drift`, `reconcile`, `catalog`, `tenant`, `quota`, `image`, `pxe`

* `clause/mission` & `clause/deck` — `cx`, `jet`, `air`, `ground`, `deck`, `hangar`, `catapult`, `squawk`, `capcom`, `fido`, `eecom`, `gnc`, `uplink`, `downlink`, `go_nogo`, `los`, `aos`, `safe_mode`, `surface`, `model`, `update`, `view`

* `clause/comms` — `sbc`, `trunk`, `leg`, `bridge`, `dialplan`, `acd`, `cdr`, `handoff`

* `clause/studio` — `stem`, `bus`, `rack`, `master`, `patchbay`, `take`, `split`, `dub`, `residual`, `recoup`, `clearance`

* `clause/stage` — `slate`, `reel`, `grade`, `stage`, `splat`, `mcr`, `playout`, `cue`, `timecode`, `osc`, `midi`, `dmx`, `ndi`, `viewport`

* `clause/stream` — `headend`, `mux`, `ingest`, `srt`, `rist`, `transcode`, `abr`, `cmaf`, `manifest`, `drm`, `cpix`, `epg`, `scte35`, `origin`, `shield`, `sfu`, `simulcast`, `vod`, `svod`, `fast`

* `clause/tactical` & `clause/tigah` — `sortie`, `emcon`, `airgap`, `mesh`, `cipher`, `scram`, `agent`, `skill`, `tool`, `memory`, `compact`, `gateway`, `lane`, `heartbeat`, `expose`, `hooks`, `latch`

* `clause/ground` — `.ground/` HNSW vector memory, `C2PA` cryptographic provenance signing, `audiowmark` steganography, `Vault` dynamic leases, and `blackbox` replay ledgers

### 4.4 Canonical End-to-End `.cx` Reference Showcase

```gleam
import clause/app.{Contract, Singleton}
import clause/comms.{type Leg}
import clause/ground
import clause/infra.{type Compute, type Network, Output}
import clause/mission.{type Telemetry}
import clause/stage.{type Slate, AcesCc, Rec709}
import clause/stream.{Cmaf, FairPlay, Fast, Srt, Widevine}
import clause/studio.{type Stem, Bit24, Hz48000}
import clause/tactical

// 1. Service Provider: Two-phase kernel registration with lazy deferral
pub service_provider StudioPlatformProvider {
  defer provides: [BurstRenderCluster]

  register(kernel) {
    kernel.bind(Contract.ICloudBurst, Singleton(infra.pulumi_driver(
      backend: "file://${PULUMI_HOME}",
      stack: "studio-burst-01",
    )))
  }

  boot(kernel) {
    let driver = kernel.make(Contract.ICloudBurst)
    driver.stream_events_to(mission.squawk_bus())
  }
}

// 2. Cloud Provider IaC: Compiles to crates/clause-pulumi (zero YAML)
pub infra BurstRenderCluster(provider: CloudProvider) {
  let vpc: Output(Network) = provider.network("clause-mesh", cidr: "10.42.0.0/16")
  let node: Output(Compute) = provider.compute(
    name: "gpu-render-01",
    image: "clauseos-transmedia-golden",
    gpu_passthrough: True,
    network: vpc.id,
  )
  export render_ip: node.public_ip
}

// 3. Autonomous Carrier Operative: Fuses Telecom, Studio DSP, Stage, OTT & Tactical OpSec
@airgap(emcon: LocalOnly)
@needs([DanteIo, VaultLease("secret/studio/c2pa")])
@squawk(max_retries: 3, circuit_breaker: 50ms)
pub agent TacticalShowrunner {
  @hangar(model: "tigah-instruct-7b")

  split ReleaseRights {
    isrc: "US-X7K-26-00099",
    master: #("Vieo Broadcast", 100.0),
  }

  dialplan InboundField {
    invite(field_leg: Leg) -> {
      use vocal_stem <- studio.open_stem(Bit24, Hz48000)
      let pgm_bus = studio.bus("BroadcastMaster")

      bridge field_leg <-> pgm_bus

      field_leg
      |> comms.pcm_stream
      |> studio.rack([studio.high_pass(100.0), studio.limiter(-1.0)])
      |> studio.record_take(vocal_stem)
      |> studio.sum_into(pgm_bus)
    }
  }

  on mcr.cue(shot: Slate) {
    shot
    |> stage.render_splat("hangar://sets/cyber_tokyo_3dgs")
    |> stage.grade(from: AcesCc, to: Rec709)
    |> stream.pack_cmaf(segment_ms: 2000, chunk_ms: 200)
    |> stream.drm_cpix(
      systems: [Widevine, FairPlay],
      kms: ground.vault_cpix("secret/studio/c2pa"),
    )
    |> ground.sign_c2pa(rights: ReleaseRights)
  }

  on mission.los(duration) {
    tactical.latch_emcon(LocalOnly)
    mission.engage_gnc_autonomy(policy: ground.strict_determinism)
  }

  on tactical.scram(reason: String) {
    comms.drop_all_trunks()
    stage.cut_to_black()
    comms.record_cdr("EMERGENCY_SCRAM", reason)
  }
}
```

## 5. Monorepo Workspace Layout (`packages/clause/`) & Monkey-X (`transcc`) Pipeline

### 5.1 Directory Structure Inside ClauseOS

Per ClauseOS's `packages/*` polyglot convention and `ADR 0001` hermetic confinement rules, the forked Gleam compiler lives at **`packages/clause/`** and outputs the **`cxc`** CLI binary (`cxc run`, `cxc build`, `cxc check`) into `${CLAUSE_BIN_DIR}`:

```text
CLAUSE_PROJECT_ROOT/
├── packages/
│   ├── clause/                               # Forked & restructured gleam-lang/gleam workspace
│   │   ├── Cargo.toml                        # Workspace root (CARGO_HOME anchored in .home/)
│   │   └── crates/
│   │       ├── clause-core/                  # Lexer, parser, HM type checker, IR & multi-target backends
│   │       │   └── src/
│   │       │       ├── brand.rs              # Single source of truth: `.cx`, `clause.toml`, `cxc`
│   │       │       ├── parse/                # Token & AST extensions for Tier 1 declarations
│   │       │       ├── analyse/              # Static domain guards (split=100%, sample rates, airgap)
│   │       │       └── backend/
│   │       │           ├── erlang.rs         # --target beam (Core Erlang / OTP supervision trees)
│   │       │           ├── rust.rs           # --target rust (transcc native Rust + DSP + Pulumi)
│   │       │           └── javascript.rs     # --target client (TypeScript / ES6 + MVU surfaces)
│   │       ├── clause-cli/                   # Outputs `[[bin]] name = "cxc"` -> ${CLAUSE_BIN_DIR}/cxc
│   │       ├── clause-lsp/                   # Clause (`.cx`) Language Server Protocol daemon
│   │       ├── clause-wasm/                  # Browser/Extism WASM compiler bindings
│   │       └── clause-runtime/               # Native Rust runtime (Ractor, oximedia, nih-plug, Craft, Pulumi)
│   ├── clause_jet/                           # Ported i2y/jet BEAM OTP supervision & schema repair (jet_sap)
│   │   └── build/erlang-shipment/            # Cross-platform entrypoint.{ps1,sh} dispatched by boot.nu
│   ├── tigah/                                # TIGAH agent runtime, MCP/A2A routers & SLM bindings
│   └── clause_site/                          # Lustre SSG documentation & Vieo.ai portal
├── tools/
│   └── ring/                                 # RinG (Rust-in-Gleam/Clause) DirtyScheduler NIF codegen (`ADR 0012`)
└── crates/
    └── clause-pulumi/                        # Revived `pulumi-gestalt` native Rust IaC engine
```

### 5.2 Hermetic Compiler Invariants (`ADR 0001` & `ADR 0004`)

1. **Cargo & Rustup Isolation (`config/env/20-toolchains.toml`):**

   `CARGO_HOME = "${CLAUSE_DATA_DIR}/cargo"` and `RUSTUP_HOME = "${CLAUSE_DATA_DIR}/rustup"` ensure compiling `packages/clause` (`cxc`) or any `--target rust` artifact never writes to host `~/.cargo` or `%USERPROFILE%\.cargo`.

2. **Hermetic Build Cache (`${CLAUSE_CACHE_DIR}/build/`):**

   All intermediate Cargo workspaces (`--target rust`), BEAM `.beam` outputs (`--target beam`), and client bundles (`--target client`) emit strictly into `${CLAUSE_CACHE_DIR}/build/{rust,beam,client}/`.

3. **Polyglot `packages/*` Build Loop & `boot.nu` Routing (`scripts/cli/nu/`):**

   * `cx build` scans `packages/*` topologically: compiles `packages/clause` first (`priority 0`), drops `cxc` into `${CLAUSE_BIN_DIR}`, and uses `cxc` (`cxc build` / `cxc run`) to compile all downstream `.cx` packages (`priority 1+`) in a single deterministic pass.
   * `scripts/cli/nu/core/boot.nu` routes `cx jet` directly to `./packages/clause_jet/build/erlang-shipment/entrypoint.ps1` (Windows) or `entrypoint.sh` (Linux/macOS), picking up rebuilds immediately without shell restarts.

### 5.3 Direct Rust Crate Imports (`@external(rust, ...)`) & Automatic `RinG` BEAM Bridging

Because `cxc` (`clause-core`) is engineered in Rust and emits native Rust crates when targeting `--target rust`, Clause (`.cx`) imports the Rust ecosystem directly using Gleam's existing `@external` attribute syntax:

```gleam
// Direct native Rust crate bindings declared in `clause.toml` (`[rust-dependencies]`)
@external(rust, "oximedia_pipeline::audio", "normalize_lufs")
pub fn normalize_lufs(buffer: AudioBuffer, target_lufs: Float) -> Result(AudioBuffer, DspError)

@external(rust, "clause_pulumi::engine", "deploy_stack")
pub fn deploy_stack(stack_name: String, graph: InfraGraph) -> Result(StackOutputs, InfraError)
```

* **Zero-Cost Direct Execution on `--target rust`:** `clause-core/src/backend/rust.rs` lowers `@external(rust, "crate::mod", "fn")` into direct Rust function calls (`oximedia_pipeline::audio::normalize_lufs(buffer, target_lufs)`), linking `oximedia`, `nih-plug`, Storytold `Craft` suites, `tokio`, and `crates/clause-pulumi` natively with **zero FFI serialization, zero IPC sockets, and zero heap copies**.
* **Automatic `RinG` Dirty-Scheduler Bridging on `--target beam` (`ADR 0012`):** When a `.cx` module compiled for `--target beam` invokes a `@external(rust, ...)` function, `cxc` and `tools/ring` (`ring-codegen`) automatically synthesize a type-safe `Rustler` NIF shim (routing fast calls to normal ERTS schedulers and heavy DSP/I/O to `DirtyCpu` / `DirtyIo` schedulers) or a hidden Erlang Distribution (`erl_dist`) node—allowing the **exact same `.cx` source and Rust crate imports** to run seamlessly across both compilation targets.

## 6. Phased Refactoring & Execution Sequence

| Phase | Deliverable | Verification Gate (`cx test`) |
| ----- | ----- | ----- |
| **Phase 1: Transplant & Rebrand (`packages/clause/` $\rightarrow$ `cxc`)** | Extract `gleam-lang/gleam` into `packages/clause/crates/{clause-core,clause-cli,clause-lsp,clause-wasm,clause-runtime}`, create `brand.rs` (`.cx`, `clause.toml`, `cxc`), and anchor `CARGO_HOME` in `config/env/20-toolchains.toml`. | `cargo build --release` emits `${CLAUSE_BIN_DIR}/cxc` and `cxc check` passes on a hello-world `.cx` module with zero writes outside `.home/`. |
| **Phase 2: Tier 1 Grammar & Static Domain Guards** | Add Tier 1 declarations (`kernel`, `service_provider`, `infra`, `provider`, `agent`, `gateway`, `trunk`, `bridge`, `dialplan`, `bus`, `rack`, `patchbay`, `split`, `stage`, `mcr`, `headend`, `airgap`, `sortie`) and compile-time checks (`split` = 100%, sample-rate parity, `@airgap` egress check) in `clause-core`. | `cargo test --offline` passes parser & static analyzer probes (`compile_ok` / `compile_fail`). |
| **Phase 3: Monkey-X `Target::Rust` Emitter (`backend/rust.rs`)** | Implement `backend/rust.rs` + `clause-runtime` lowering `bus`/`rack` to `oximedia`/`nih-plug`, `infra` to `crates/clause-pulumi`, `agent` to `Ractor` actors, and `@external(rust, ...)` direct crate calls. | `cxc build --target rust` and `cxc run --target rust` compile and execute a multi-pillar `.cx` module inside `${CLAUSE_CACHE_DIR}/build/rust/`. |
| **Phase 4: BEAM Backplane & `RinG` Integration (`backend/erlang.rs`)** | Extend `backend/erlang.rs` to lower `agent`, `dialplan`, `service_provider`, `mcr`, and `headend` into OTP `gen_statem` supervision trees wired to `packages/clause_jet` and `tools/ring` DirtyScheduler NIFs. | `cxc run --target beam` boots a supervised OTP node executing live `dialplan` + `studio` + `infra` actors under `cx test`. |
| **Phase 5: Polyglot Loop & `ADR 0011` Reconciliation** | Wire `scripts/cli/nu/commands/build.nu`, `test.nu`, and `boot.nu` (`packages/clause_jet/build/erlang-shipment/entrypoint.{ps1,sh}`) across `packages/*` and synchronize `docs/adr/adr_011-seax-language-transpiler-agent-directory.md`. | `cx build` and `cx test` execute end-to-end across Windows, Linux, and macOS with 100% hermeticity. |
