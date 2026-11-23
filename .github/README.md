<p align="center">
  <img src="../resources/images/clause-workflow.jpg" alt="Clause OS Workflow" width="100%">
</p>
<div align="center">

# 🐾 ClauseOS (`clause`)

**Autonomous, Hermetic Single-Driver OS Environment & Air-Gapped Cloud Bursting Platform**

[![CI / CD Matrix](https://img.shields.io/badge/CI%2FCD-100%25%20Passing-brightgreen?style=for-the-badge&logo=githubactions&logoColor=white)](#)
[![Platforms](https://img.shields.io/badge/Platforms-Windows%20%7C%20Linux%20%7C%20macOS-blue?style=for-the-badge&logo=linux&logoColor=white)](#)
[![Isolation](https://img.shields.io/badge/Confinement-Zero--Contamination%20Bare--Metal-orange?style=for-the-badge&logo=buffer&logoColor=white)](#)
[![Hardware Acceleration](https://img.shields.io/badge/Hardware-CUDA%20%7C%20ROCm%20%7C%20XPU%20%7C%20MPS-purple?style=for-the-badge&logo=nvidia&logoColor=white)](#)
[![Virtual Enterprise](https://img.shields.io/badge/Agents-Autonomous%20Virtual%20Enterprise-indigo?style=for-the-badge&logo=anthropic&logoColor=white)](#)

<p align="center">
  <a href="#-overview">Overview</a> •
  <a href="#-core-architectural-pillars">Architectural Pillars</a> •
  <a href="#-operating-system-primitives-mapping">OS Primitives</a> •
  <a href="#-canonical-directory-hierarchy">Directory Layout</a> •
  <a href="#-unified-model-cache--ai-storage">AI Storage</a> •
  <a href="#-cross-platform-micro-virtualization-cx-vm">Virtualization</a> •
  <a href="#-autonomous-virtual-enterprise">Virtual Enterprise</a> •
  <a href="#-beam-distributed-backplane--gleam-orchestration">BEAM Backplane</a> •
  <a href="#-clause-carrier-language--multi-target-transpiler">Clause Language</a> •
  <a href="#-ring-rust-in-gleam-native-bridge">RinG Bridge</a> •
  <a href="#-hardware-acceleration-matrix">Hardware Matrix</a> •
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-open-core--monetization-strategy">Strategy</a> •
  <a href="#-architecture-decision-records">ADRs</a>
</p>

</div>
---

> ## 🚧 Active Development & Architectural Stabilization
>
> **ClauseOS is currently in rapid, heavy active development (`v0.9.0-dev.1`).**
>
> * The foundational hermetic substrate, modular `config/env/*.toml` environment engine, layered `MISE_ENV` overlays, `cx pkg:*` polyglot package control plane, dynamic GPU auto-detection, and all six first-party `plugins/cx-*` AI/dev toolchains (`v0.8.0-dev.10`) are fully operational and passing 100% green CI/CD across Windows, Linux, and macOS.
> * Advanced higher-order subsystems—including complete HashiStack daemon topologies (`nomad`, `consul`, `vault`, `packer`, `boundary`), the BEAM/Gleam distributed orchestrator, Pixiecore bare-metal provisioning (MaaS), the `cx vm` hypervisor bridge, Clause (`.cx`) / `cxc` compiler toolchains, and the `.enterprise/` multi-agent organization schemas—are actively being stabilized and wired into the command plane.
> * Certain declared commands, modules, and configurations may evolve or undergo refactoring between milestone snapshots. Please refer to [TASK.md](TASK.md) and the [ADRs](docs/adr/) for active tracking.

---

## 🧭 Overview

**ClauseOS** is a bare-metal, self-contained operating system environment architecture designed to execute directly on the host machine while operating entirely within a hermetically confined profile directory (`.home/`). By redirecting `$HOME`, `$USERPROFILE`, and standard OS directory structures strictly into this localized root, ClauseOS eliminates host-level package managers, path pollution, global registry tampering, and configuration drift.

ClauseOS functions as an **Air-Gapped Seed Node**: a mobile command center capable of operating completely offline, self-bootstrapping isolated developer toolchains and specialized neural runtimes, bursting infrastructure into remote clouds via Pulumi, and cleanly detaching while cloud clusters continue autonomous operations.

Unlike virtual machines or Docker containers, ClauseOS introduces **zero hypervisor overhead** for local tools and grants applications unhindered, direct bare-metal access to hardware acceleration pipelines (NVIDIA CUDA, AMD ROCm, Intel XPU, and Apple Silicon MPS).

---

## 🏛️ Core Architectural Pillars

### 1. 🛡️ True Bare-Metal Hermetic Confinement

* **Immutable State Root (`.home/`):** All configurations, state stores, caches, models, and application data reside inside `CLAUSE_PROJECT_ROOT/.home`.
* **Zero Global Pollution:** Deleting `.home/` completely resets the environment to a pristine state without leaving residual files, PATH edits, or registry entries on the host machine.
* **Automated Hermeticity Assertions:** Continuous CI/CD testing (`tests/system/test_hermeticity.nu`) guarantees zero host path leakage or shell delimiter bleeding.

### 2. ⚙️ Three-Tier Orchestration Model (`Stage 0 Bootstrap` + `Mise Overlays` + `Confined OS Adapters`)

* **Stage 0 & 1 (Microkernel Bootstrap — `.clause.toml` & `config/env/*.toml`):** `cx.ps1` and `cx.sh` enforce host hygiene preflight redlines, compile modular SSOT environment definitions (`00-core.toml` through `40-ml-hub.toml`), and pre-seed core primitives (`nu`, `mise`, in-place patched `scoop`, isolated `brew`, and `wsl`) directly into `.home/`.
* **Stage 2 (Layered Mise Overlays & Custom ClauseOS Plugins — `.mise*.toml` & `plugins/cx-*`):** Managed via `mise` across `MISE_ENV="paths,ai,cloud"`, provisioning core runtimes (`uv`, `pulumi`, `packer`), HashiStack orchestrators (`nomad`, `consul`, `vault`, `boundary`), BEAM/Gleam toolchains (`erlang`, `elixir`, `gleam`, `rebar`), and first-party hardware-aware AI plugins (`lemonade`, `fastflowlm`, `inferssd`, `unsloth`, `comfyui`, `code`).
* **Stage 3 (Unified Polyglot Package Control Plane — `cx pkg:*`):** Dispatches `cx pkg:add`, `cx pkg:mise`, `cx pkg:scoop` (in-place patched to block `HKCU:\Environment` writes and Start Menu `.lnk` creation), and `cx pkg:brew`, automatically pinning resolved versions back into `.mise*.toml` via `toml_pin.nu`.

### 3. 🧠 Unified Ecosystem Model Storage (`HF_HOME`)

* Consolidates all AI checkpoints, LoRAs, UNet backbones, and GGUF quantizations into a single shared root (`${CLAUSE_CACHE_DIR}/huggingface` via `config/env/40-ml-hub.toml`).
* Eliminates redundant multi-gigabyte weight downloads across Unsloth, ComfyUI, Lemonade, FastFlowLM, and InferSSD.

### 4. 📦 Cross-Platform Micro-Virtualization (`cx vm`)

* Unified, disposable micro-instance engine running Linux-exclusive workloads (e.g., bare-metal Kubernetes/k3s, systemd daemons, eBPF probes) without privileged host daemons.
* Dynamically dispatches to **WSL2** on Windows (rootfs tarball imports confined to `.home/`) and **Lima (`limactl`)** on macOS/Linux with native multi-distro support (Alpine, Ubuntu, Debian).

### 5. 🤖 Autonomous Virtual Enterprise

* Built-in multi-agent corporate hierarchy (Board of Directors, Executive Leadership, Operational Departments) governed by `constitution.toml`.
* Autonomous agents leverage local neural coprocessors, execute batch tasks via Nomad `raw_exec` with full repo write privileges, and collaborate through an embedded Portable VS Code command harness.
* **Dual-Plane Execution & Closed-World Grounding:** Conversational chat handles intent and steering in the UI, while critical operations run non-conversationally via Nomad `raw_exec` batch jobs with strict exit-code gates.
* **Two-View Model (Contained SLMs vs. Saturated Generalists):** Upstream models handle intent shaping; worker agents utilize 1B–7B parameter models distilled and fine-tuned locally with Unsloth on verified ADRs, schemas, and test vectors, removing latent representations of evasion or hallucination.
* **Adversarial Gatekeeping:** Verbal completion claims are treated as unverified; supervising agents execute automated validation guardrails (git diff file bounds, hermetic test runs, schema validation) before Vault grants dynamic merge tokens.

### 6. 🌐 Distributed BEAM Backplane & Bare Metal as a Service (MaaS)

* **Gleam Orchestrator Core:** Positions Erlang/OTP and Gleam as the distributed cluster backplane, using soft real-time supervision trees to isolate node failures and telemetry without an etcd consensus bottleneck.
* **Nomad Execution with Ephemeral K8s:** Nomad manages bare-metal binaries and GPU jobs; Kubernetes (k3s) is treated as an optional guest target rather than the platform's control plane.
* **Zero-Touch Netboot Provisioning:** Integrates Pixiecore for API-driven iPXE bare-metal booting against Consul inventories, consuming in-memory golden rootfs images generated via Packer.
* **Programmatic IaC via Pulumi:** Replaces static HCL Terraform workflows with the Pulumi Automation API to manage networking, cloud bursting, and service state directly in code.

### 7. 🧬 Clause (`.cx`) Transmedia Language & Multi-Target Transpiler

* **Gleam ML/Rust Core Heritage:** Functional, static typing engineered by forking `gleam-lang/gleam` inside `packages/clause/` (`cxc`), retaining 100% of its Hindley-Milner type inference engine and Language Server Protocol (`cxc lsp`).
* **Native Transmedia & Actor Keywords:** First-class language keywords for the Nine Canonical Operational Pillars (`kernel`, `app`, `infra`, `deck`, `comms`, `studio`, `stage`, `stream`, `tactical`/`tigah`).
* **Monkey X Multi-Target Transpiler:** The `cxc` compiler lowers code directly to target-native representations without virtual-machine emulation:
  * `--target beam` $
ightarrow$ Compiles to Core Erlang AST and `.beam` bytecode executed by `packages/clause_jet/` over Erlang/OTP 29.
  * `--target rust` $
ightarrow$ Compiles to optimized native Rust linked with `oximedia`, `nih-plug` (CLAP/VST3), Storytold `Craft`, and `crates/clause-pulumi`.
  * `--target client` $
ightarrow$ Compiles to TypeScript and WebAssembly for interactive agent dashboards and web control planes (`Lustre`, `Plushie`, `Shore`, `O2K`).
* **Agent-as-a-Folder Architecture:** A complete agent or operational department is packaged as an isolated directory containing its coordinator (`agent.cx`), sub-agents (`team/`), capabilities (`skills/`), embedded MCP servers (`mcp/`), and target manifest (`clause.toml`).

### 8. 🔗 RinG (Rust-in-Gleam) Integration Bridge

* Inspired by Rinf (Rust in Flutter), RinG code-generates strongly typed messaging channels between Rust and Gleam.
* Protects the BEAM scheduler by routing lightweight operations to immediate NIFs while offloading heavy DSP buffers, tensor routines, and file I/O to `DirtyCpu`/`DirtyIo` schedulers or ports.
* Wraps native Rust worker threads directly in supervised `gleam_otp` actors.

---

## 🧩 Operating System Primitives Mapping

ClauseOS maps userland binaries and services directly into functional OS system primitives:

| OS Primitive | ClauseOS Component | Hermetic Target Location | System Function |
| :--- | :--- | :--- | :--- |
| **Microkernel / Exec** | `cx.bat` / `cx.ps1` / `cx.sh` | `CLAUSE_PROJECT_ROOT/cx.*` | Stage 0 bootloader, `config/env/*.toml` compiler & sandbox barrier enforcement |
| **Shell & Init (PID 1)** | Nushell (`nu`) | `.home/AppData/Local/Programs/bin/nu` or `.home/.local/bin/nu` | Interactive command processor, polyglot CLI router & process supervisor |
| **Driver & HAL** | Mise | `.home/.../bin/mise` | Unified toolchain driver, `MISE_ENV` overlay engine & dynamic runtime manager |
| **Package Adapters** | `cx pkg:*` (`Scoop` / `Brew`) | `.home/.../cache/toolchain/` | In-place patched Scoop & confined Homebrew with `toml_pin.nu` auto-pinning |
| **Private Python Driver** | `uv` (Astral) | `.home/.../bin/uv` | Hermetic virtual environment & wheel resolution engine |
| **Micro-Hypervisor** | `cx vm` (WSL2 / Lima) | `.home/.../vms/` | Disposable Linux micro-instances for k3s & Linux-only daemons |
| **AI Fine-Tuning Engine** | Unsloth (`cx-unsloth`) | `.home/.../mise/installs/unsloth/` | Hardware-accelerated LLM parameter-efficient training & SLM distillation |
| **Neural Studio** | ComfyUI (`cx-comfyui`) | `.home/.../mise/installs/comfyui/` | Node-based diffusion model inference & visual studio |
| **Neural Coprocessors** | Lemonade / FastFlowLM / InferSSD | `.home/.../mise/installs/{lemonade,fastflowlm,inferssd}/` | Embedded local LLM inference daemons & background agents |
| **Window Manager / UI** | Portable VS Code (`cx-vscode`) | `.home/.../mise/installs/code/` | Primary graphical cockpit & agent host harness |
| **Distributed Backplane** | Erlang (BEAM) / Gleam | `.home/.../mise/installs/erlang` | Fault-tolerant distributed actor subsystem & orchestrator core |
| **Transmedia Language** | Clause (`cxc`) / `clause_jet` | `packages/clause/` $
rightarrow$ `${CLAUSE_BIN_DIR}/cxc` | Multi-target carrier language compiler (`cxc`), BEAM actor runtime (`clause_jet`) & infra engine (`catapult`) |
| **Native Bridge** | RinG (Rust-in-Gleam) | `tools/ring/` | Type-safe code generator & dirty-scheduler FFI bridge |
| **Infra Kernel** | Pulumi CLI & `clause-pulumi` | `crates/clause-pulumi/` | Multi-cloud resource orchestration & programmatic Automation API |
| **Workload Scheduler** | HashiCorp Nomad | `.home/.../bin/nomad` | Distributed job & container orchestrator (`raw_exec`) |
| **Service Registry** | HashiCorp Consul | `.home/.../bin/consul` | Service discovery, mesh DNS, & Raft consensus |
| **Secrets Engine** | HashiCorp Vault | `.home/.../bin/vault` | Cryptographic key storage, leased tokens, & identity management |
| **MaaS Boot Engine** | Pixiecore | `.home/.../bin/pixiecore` | API-driven DHCP/TFTP/HTTP iPXE netboot runner |
| **Golden Image Builder** | HashiCorp Packer | `.home/.../bin/packer` | Deterministic in-memory micro-distro image compiler |
| **Zero-Trust Access** | HashiCorp Boundary | `.home/.../bin/boundary` | Identity-based user and agent access gateway |

---

## 📂 Canonical Directory Hierarchy

ClauseOS maps platform-specific conventions directly into the `.home/` sandbox:

```text
CLAUSE_PROJECT_ROOT/
├── .enterprise/                          # Virtual Enterprise Configuration Root
│   ├── board/                            # Board of Directors & constraints (constitution.toml)
│   ├── executive/                        # C-Suite agent schemas (CEO, CTO, CPO)
│   ├── departments/                      # Operational departments (Engineering, Security, SRE, QA)
│   ├── skills/                           # Modular CLI skills & toolsets (git-ops, test-runner)
│   └── plugins/                          # Dynamic reasoning extensions for agent harness
├── .home/                                # Hermetic Root ($HOME & $USERPROFILE)
│   ├── AppData/Local/Programs/           # [Windows] Binaries, apps, and logs
│   │   ├── bin/                          # Unified Stage 0/1 binaries & Mise shims
│   │   ├── apps/                         # Isolated application deployments
│   │   ├── vms/                          # Confined WSL2 Virtual Hard Disks (ext4.vhdx)
│   │   └── logs/                         # Bootstrap & system execution logs
│   ├── .local/                           # [POSIX] Linux / macOS Application & Binary Root
│   │   ├── bin/                          # Unified binaries & shims
│   │   ├── apps/                         # Isolated application deployments
│   │   ├── share/                        # Persistent application data (Mise, Nomad, Consul, Vault)
│   │   │   └── vms/                      # Confined Lima micro-instances ($LIMA_HOME)
│   │   └── logs/                         # Bootstrap & execution logs
│   ├── .config/                          # [POSIX] XDG Config Home (Mise config, etc.)
│   ├── .cache/                           # Cache root (Mise, uv, Scoop/Brew toolchain, Hugging Face hub)
│   ├── .ssh/                             # Confined SSH client configuration (config, known_hosts)
│   └── .gitconfig                        # Isolated Git user identity file
├── crates/                               # Core Systems Crates (Rust)
│   └── clause-pulumi/                    # Revived pulumi-gestalt native Rust IaC engine (catapult)
├── config/                               # Single Source of Truth (SSOT) Environment Modules
│   └── env/                              # Modular TOML manifests parsed at Stage 0 boot (00-core..40-ml-hub)
├── docs/                                 # Documentation & architecture records
│   ├── adr/                              # Architecture Decision Records (ADRs)
│   └── ccefs/                            # CCEFS 30-Module Curriculum Specifications (00 through 17)
├── ops/                                  # Infrastructure as Code & Orchestration
│   ├── config/                           # Nomad, Consul, and Vault HCL configs
│   ├── jobs/                             # Nomad job definitions (agent workers, batch runs, k3s)
│   ├── packer/                           # Packer templates for in-memory golden rootfs images
│   └── stacks/                           # Pulumi Cloud Infrastructure definitions
├── packages/                             # Monorepo Core Packages & Language Extensions
│   ├── clause/                           # Forked gleam-lang/gleam compiler workspace emitting cxc
│   ├── clause_jet/                       # BEAM/OTP 29 distributed execution & mission control
│   └── tigah/                            # TIGAH agent runtime, MCP/A2A routers & SLM bindings
├── plugins/                              # First-party cross-platform Lua runtime plugins (git subtrees)
│   ├── cx-comfyui/                       # Hardware-aware ComfyUI provisioning & isolation
│   ├── cx-fastflowlm/                    # FastFlowLM local NPU/GPU inference engine
│   ├── cx-inferssd/                      # InferSSD high-throughput local inference runtime
│   ├── cx-lemonade/                      # Lemonade OpenAI-compatible local LLM server
│   ├── cx-unsloth/                       # Hardware-aware Unsloth fine-tuning environment
│   └── cx-vscode/                        # Portable VS Code ("code") agent host deployment
├── projects/                             # User projects & workspace repositories
├── references/                           # Upstream reference architecture subtrees
├── scripts/                              # Canonical automation scripts
│   ├── cli/                              # Userland CLI utilities & interactive environments
│   │   ├── nu/                           # Nushell control plane (core/*, config/*, commands/*)
│   │   ├── posix/                        # POSIX Stage 1 bootstrap installers (installers/*.sh)
│   │   └── pwsh/                         # PowerShell tooling
│   │       └── installers/               # Stage 1 pre-Mise bootstrap installers
├── services/                             # Core distributed system daemons
│   └── orchestrator/                     # Gleam/OTP cluster orchestrator application
├── tests/                                # Test harness suites
│   ├── env/                              # Environment compilation unit tests
│   └── system/                           # Automated hermeticity and stage verification suites
├── tools/                                # Internal developer tool suites
│   └── ring/                             # RinG (Rust-in-Gleam) schema & dirty-scheduler NIF generator
├── .clause.toml                          # Central OS manifest & application toggle declarations
├── .mise.toml                            # Toolchain dependency & version manifest
├── .mise.paths.toml                      # Hermetic PATH & shim overlay (MISE_ENV="paths")
├── .mise.ai.toml                         # AI coprocessors, Unsloth, ComfyUI & BEAM/Gleam overlay (MISE_ENV="ai")
├── .mise.cloud.toml                      # HashiStack, Pulumi, Packer & VM overlay (MISE_ENV="cloud")
├── cx.bat                                # Windows Entrypoint Trampoline
├── cx.ps1                                # PowerShell Stage 0 Microkernel Bootloader
└── cx.sh                                 # POSIX (Linux/macOS) Stage 0 Microkernel Bootloader
```

---

## 🧠 Unified Model Cache & AI Storage

All AI workloads share a single, zero-duplication model cache rooted in `$HF_HOME`:

```text
.home/.cache/huggingface/                 # [POSIX] (.home/AppData/Local/cache/huggingface/ on Windows)
├── hub/
│   ├── models--unsloth--Qwen2.5-Coder-7B-Instruct/   ◄── Shared by Unsloth & Coprocessor
│   ├── models--black-forest-labs--FLUX.1-schnell/    ◄── Read by ComfyUI via extra_model_paths.yaml
│   └── models--bartowski--Llama-3.2-3B-GGUF/         ◄── FastFlowLM / Lemonade / InferSSD Daemon
└── assets/                                            ◄── Hugging Face Hub assets cache ($HF_ASSETS_CACHE)
```

* **Zero Duplication:** Unsloth fine-tunes weights directly against the same Hugging Face cache that ComfyUI queries for image generation and the agent daemons read for inference.
* **Hermetic Portability:** Backing up or moving `$HF_HOME` preserves the complete weights library without touching host OS directories.

---

## 📦 Cross-Platform Micro-Virtualization (`cx vm`)

For services requiring a full Linux kernel (such as lightweight Kubernetes via `k3s`, systemd services, or container daemons), ClauseOS exposes the unified `cx vm` subsystem:

```text
                               ┌─────────────────┐
                               │     cx vm       │
                               └────────┬────────┘
                                        │
                 ┌──────────────────────┴──────────────────────┐
                 ▼                                             ▼
         [Host == Windows]                             [Host == macOS / Linux]
                 │                                             │
          WSL2 Driver                                     Lima Driver
       (wsl.exe --import)                              (limactl start)
                 │                                             │
    Confined: .home/.../vms/                      Confined: $LIMA_HOME (.home/.../vms/)
  Distros: Alpine, Ubuntu, Debian               Distros: Alpine, Ubuntu, Debian
```

```nushell
# Launch a featherweight Alpine instance in ~1 second
cx vm launch k3s-node --distro alpine

# Execute commands directly inside the micro-instance
cx vm exec k3s-node -- uname -a

# Open an interactive shell
cx vm shell k3s-node

# Cleanly purge the VM and wipe all state
cx vm purge k3s-node
```

---

## 🤖 Autonomous Virtual Enterprise

ClauseOS includes an enterprise agent harness designed to run autonomous developer and operational teams directly inside the workspace:

```text
.enterprise/
├── board/                              # Governance & constraints (constitution.toml)
├── executive/
│   ├── ceo_agent                       # Strategic roadmap & issue dispatching
│   ├── cto_agent                       # Architectural integrity, ADR enforcement, code audits
│   └── cpo_agent                       # Feature delivery & developer UX tracking
├── departments/
│   ├── engineering/                    # Full repo write access (feature branches, test suites)
│   ├── security_audit/                 # Static analysis, dependency audits, secret scanning
│   ├── site_reliability/               # Nomad workload monitoring & Consul mesh health
│   └── documentation_qa/               # ADR authoring & documentation sync
└── skills/                             # Modular CLI toolsets (git-ops, test-runner, adr-writer)
```

* **Write-Access Guardrails:** Agents run via Nomad `raw_exec` tasks with credentials leased through Vault. Code modifications occur on isolated feature branches and require green passes from `cx test` before pull requests are finalized.
* **Portable Cockpit:** Portable VS Code runs natively within the profile, bound directly to the local coprocessor (`http://localhost:8000/v1`) for local code intelligence.

---

## 🌐 BEAM Distributed Backplane & Gleam Orchestration

ClauseOS departs from traditional infrastructure stacks by positioning the **BEAM VM** as the primary distributed backplane and **Gleam** as the core orchestration language:

* **Soft Real-Time OTP Actors:** Cluster membership, node telemetry, and agent mailboxes are modeled as typed Gleam OTP actors (`gleam_otp`). Failure in a worker node or hardware process is isolated to its supervision tree branch without triggering global cluster churn.
* **Nomad Workload Scheduler:** Workloads are dispatched to Nomad via typed Gleam HTTP clients. Bare-metal binaries, local GPU models, and containerized micro-services execute via Nomad's `raw_exec` and container drivers.
* **Bare Metal as a Service (Pixiecore & iPXE):** The Gleam orchestrator coordinates with Pixiecore to netboot unprovisioned physical metal directly into memory using Packer-generated rootfs tarballs, automatically admitting machines into the Consul mesh.
* **Ephemeral Kubernetes (k3s):** Kubernetes is scheduled as a guest workload on Nomad inside disposable micro-instances (`cx vm`) only when tenants require standard K8s manifests.

---

## ⚡ Hardware Acceleration Matrix

ClauseOS dynamically queries the host hardware at runtime to resolve and inject the correct binary index without requiring host driver installations:

```text
                                [ Hardware Probing Subsystem ]
                                               │
             ┌─────────────────────────────────┼─────────────────────────────────┐
             ▼                                 ▼                                 ▼
        [ Windows ]                        [ Linux ]                         [ macOS ]
             │                                 │                                 │
     ┌───────┴───────┐                 ┌───────┴───────┐                 ┌───────┴───────┐
     ▼               ▼                 ▼               ▼                 ▼               ▼
  NVIDIA            AMD             NVIDIA            AMD             Apple Silicon    Intel
(CUDA 12/13)    (ROCm 10.0)      (CUDA 12/13)     (ROCm 7.2)         (Native MPS)   (CPU Fallback)
```

* **NVIDIA CUDA:** Probes driver version via `nvidia-smi` and maps to `cu124`, `cu126`, `cu128`, or `cu130`.
* **AMD ROCm (Linux):** Probes `/dev/kfd` and `rocminfo`, targeting `https://download.pytorch.org/whl/rocm7.2`.
* **AMD ROCm (Windows):** Queries `Win32_VideoController` and configures AMD multi-architecture wheels (`torch[device-all]==2.13.0+rocm10.0.0`).
* **Intel Arc (XPU):** Detects Arc GPUs and binds `https://download.pytorch.org/whl/xpu`.
* **Apple Silicon (macOS `arm64`):** Leverages native Apple Metal Performance Shaders (`mps`).
* **macOS Intel (`x86_64`):** Gracefully falls back to CPU execution and automatically filters out unsupported architecture wheels (e.g. `comfy-angle`) to avoid dependency resolution errors.

---

## 🚀 Quick Start

### 1. Launch the Microkernel Bootloader

Run the unified `cx` command for your platform. This provisions Stage 0 tools, initializes directory anchors, configures `.home/`, syncs `.mise.toml`, runs active `renv` recipes, and drops you into the hermetic Nushell environment:

**Windows (CMD / PowerShell):**

```cmd
cx
```

**Linux / macOS (POSIX Shell):**

```bash
./cx.sh
```

### 2. Verify State Hermeticity

Once inside the ClauseOS Nushell session, verify that your environment is completely confined to `.home/`:

```nushell
cx test
```

### 3. Manage Hermetic Packages & Plugins

```nushell
# Install packages across Mise, hermetically patched Scoop, or Homebrew with auto-pinning
cx pkg:add mise:ripgrep
cx pkg:scoop install jq
cx pkg:brew install htop

# Synchronize first-party Lua runtime plugins via git subtrees
cx plugin pull inferssd https://github.com/vieo-ai/cx-inferssd.git
```

### 4. Launch Orchestration & AI Workloads

```nushell
# Start local HashiCorp Nomad dev cluster
nomad agent -dev -config ops/config/nomad.hcl

# Launch local Neural Coprocessor Daemon
coprocessor start --engine lemonade --port 8000

# Launch ComfyUI Studio
comfyui --listen 127.0.0.1 --port 8188

# Launch Unsloth Fine-Tuning CLI
unsloth --help
```

---

## ☁️ Cloud Bursting & Detachment Flow

ClauseOS acts as an air-gapped seed node. It provisions remote cloud infrastructure (AWS, GCP, Azure, Hetzner, Bare Metal) using embedded Pulumi and HashiStack primitives, promotes remote nodes to quorum, and detaches cleanly:

```nushell
# 1. Burst local workspace state to cloud infrastructure
clause cloud up

# 2. Verify remote Nomad & Consul cluster consensus
clause cluster status

# 3. Sever local connection (Local node drains; Cloud cluster continues autonomous execution)
clause cloud detach
```

---

## 💼 Open-Core & Monetization Strategy

ClauseOS strictly adheres to an unconstrained, developer-first open-core model:

* **Open-Source Base Substrate (100% Free & Unrestricted):**
  * Complete hermetic single-driver OS environment (`.home/` confinement).
  * Unlimited local node orchestration, clustering (Nomad/Consul/Vault/Boundary), and cloud bursting via Pulumi.
  * BEAM/Gleam distributed backplane and Pixiecore bare-metal provisioning (MaaS).
  * Dynamic 5-way GPU auto-detection and cross-platform virtualization (`cx vm`).
  * Clause (`.cx`) / `cxc` compiler toolchain and folder-based agent development model.
  * Base Virtual Enterprise agent harness, skill runner, and portable editor cockpit.
  
* **Commercial Tier (Industry Adaptation & Enterprise Blueprints):**
  * **Regulated Industry Packs:** Pre-configured Virtual Enterprise cartridges for HIPAA Healthcare, FINRA/SEC FinTech, and Defense air-gapped environments.
  * **Enterprise Compliance & Governance:** Cryptographic audit trails, Open Policy Agent (OPA) agent guardrails, and automated board-level risk controls.
  * **Legacy Enterprise Connectors:** Turnkey bridges to SAP, Oracle, Epic, and corporate identity providers.

---

## 📚 Architecture Decision Records (ADRs)

Key architectural decisions are documented under `docs/adr/`:

* [**ADR 0001**: Hermetic State Confinement and Canonical Directory Hierarchy](../docs/adr/adr_001_hermetic_state_confinement_and_canonical_directory_hierarchy.md)

* [**ADR 0002**: Two-Tier Toolchain Orchestration (`mise` and `renv`)](../docs/adr/adr_002_two_tier_toolchain_orchestration_mise_renv.md)

* [**ADR 0003**: Dynamic Multi-Vendor Hardware Acceleration Matrix](../docs/adr/adr_003_dynamic_multi_vendor_hardware_acceleration_matrix.md)

* [**ADR 0004**: Cross-Shell Environment and PATH Delimiter Canonicalization](../docs/adr/adr_004_cross_shell_environment_and_path_delimiter_canonicalization.md)

* [**ADR 0005**: Unified Model Storage & Ecosystem Cache Projection](../docs/adr/adr_005_unified_model_storage_hub.md)

* [**ADR 0006**: Cross-Platform Micro-Instance Virtualization (`cx vm`)](../docs/adr/adr_006-micro-instance-virtualization.md)

* [**ADR 0007**: Open-Core Substrate vs. Industry Adaptation Commercialization](../docs/adr/adr_007-open-core-and-monetization.md)

* [**ADR 0008**: Virtual Enterprise Organizational Hierarchy & Agent Governance](../docs/adr/adr_008-virtual-enterprise-agent-hierarchy.md)

* [**ADR 0009**: VS Code Agent Host, Extensibility Plugins, and Skill Toolsets](../docs/adr/adr_009-agent-skills-plugins-vscode-harness.md)

* [**ADR 0010**: Distributed BEAM Backplane, Gleam Orchestration, Nomad Scheduling, and MaaS](../docs/adr/adr_010-beam-orchestrator-nomad-scheduler-maas.md)

* [**ADR 0011**: Clause Programming Language, Multi-Target Transpiler, and Agent Directory Pattern](../docs/adr/adr_011-clause-language-transpiler-agent-directory.md)

* [**ADR 0012**: RinG (Rust-in-Gleam) Type-Safe Native Integration Bridge](../docs/adr/adr_012-ring-rust-in-gleam-bridge.md)

* [**ADR 0013**: Curated Domain SLMs vs. Saturated Generalist Models](../docs/adr/adr_013-curated-domain-slms-vs-saturated-generalists.md)

---

<div align="center">

Built With ❤️ By Vieo

</div>
