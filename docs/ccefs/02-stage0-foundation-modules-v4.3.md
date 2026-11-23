# CCEFS Stage 0: Sealing the Hermetic Bare-Metal Userland (Modules 0.1–0.5 — v4.3)

> **Reading Order (`docs/ccefs/`):** `00-PROJECT-SPECIFICATION-v3.0.md` $\rightarrow$ `01-ccefs-30-modules-v4.3.md` $\rightarrow$ **`02-stage0-foundation-modules-v4.3.md` *(Stage 0)*** $\rightarrow$ `03-stage1-2-compiler-orchestrator-v4.3.md` *(Stages 1–2)* $\rightarrow$ `04-vieo-ai-curriculum-portal.md` *(4-Track Portal)*

The foundation tracks in **ClauseOS (`[f01]`–`[f04]`, `ADR 0001`–`0013`)** and **AIEFS (*AI Engineering From Scratch*, `[e01]`–`[e06]`)** form the non-negotiable bare-metal userland sandbox (`.home/`) inside which **Stage 1 (Seax Language & Compiler `seaxc` — Modules 1–5)**, **Stage 2 (Distributed Orchestrator & Pulumi IaC — Modules 6–10)**, **Stage 3 (Real-Time Transmedia & Telecom Switchboard — Modules 11–15)**, **Stage 4 (Seax-Native Agent Harness — Modules 16–20)**, and **Stage 5 (Autonomous Virtual Enterprise & Open-Core Release — Modules 21–25)** are built and executed.

---

## **Stage 0: Sealing the Hermetic Bare-Metal Userland (Modules 0.1–0.5)**

### **Module 0.1: Zero-Leak Profile Confinement & Stage 0 Trampolines**

* **ClauseOS Base**: `cx.bat`, `cx.ps1`, `cx.sh`, `config/env/00-core.toml`–`40-ml-hub.toml` (`[f01]`, `ADR 0001`, `ADR 0004`) | **Orchestrator Equivalent**: `[c03]` Ch. 12 (`Cobra` CLI entrypoints & environment isolation) | **Agent Harness Equivalent**: `r14` Ep. 12 (Startup Fast-Path & Trust Boundary), `r15` Ch. 2 (Under-300ms Bootstrap Pipeline), `r16` Ch. 2–3 (7-Dimension Config Merge & MDM), `r19` Ch. 5 (6-Layer Config Priority Chain)
* **Shared Concept**: Starting from an empty folder on a bare host OS, establishing a zero-leak process sandbox and single-source-of-truth (SSOT) environment compiler before any toolchain binary, compiler, or LLM agent executes—guaranteeing that deleting `.home/` completely resets the machine with zero host OS residue.
* **ClauseOS Substrate Mechanics (`[f01]`, `ADR 0001`, `ADR 0004`)**:
  1. **Symmetrical Root Trampolines (`cx.bat` $\rightarrow$ `cx.ps1`, `cx.sh`):** Single-command invocation from outside or inside the shell (`cx test`, `cx pkg:add`, `cx vm`), preserving `CLAUSE_STATUS="online"` across nested subshells without reboot loops.
  2. **Declarative Modular TOML SSOT (`config/env/*.toml`):** Replaces drifted `.ps1`/`.sh` env scripts with 5 lexical modules (`00-core.toml`, `10-identity.toml`, `20-toolchains.toml`, `30-shell.toml`, `40-ml-hub.toml`), parsed via 8-pass iterative `${VAR}` symbol expansion and platform-normalized paths (`windows` vs. `posix`).
  3. **Known-Folder & XDG Redirection:** Redirects `$HOME`, `$USERPROFILE`, `$APPDATA`, `$LOCALAPPDATA`, `$XDG_CONFIG_HOME`, `$XDG_DATA_HOME`, `$XDG_CACHE_HOME`, `$GIT_CONFIG_GLOBAL`, `$GH_CONFIG_DIR`, and `GIT_SSH_COMMAND` strictly into `${CLAUSE_PROJECT_ROOT}/.home/`.
  4. **Stage 0 Preflight Host Hygiene Redline:** Scrubs CI runner paths (`\scoop\shims`, `/homebrew/`, `/linuxbrew/`) and hard-aborts if unmanaged global `mise`, `scoop`, or `brew` binaries or active host `MISE_SHELL` sessions are detected outside `$CLAUSE_HOME`.
  5. **Cross-Shell PATH Canonicalization (`ADR 0004`):** Enforces `;` vs `:` delimiter discipline in `cx.ps1` and defensive two-pass delimiter splitting in Nushell `env.nu`, plus static parse-time `./mise.nu` generation.
* **Laravel Component Adoption & Target Primitives**:
  * **Target Primitives**: `IBootloader`, `IConfigCompiler`, `IHermeticSandbox`
  * **Created Components**: `config` (Modular TOML SSOT compiler), `console` (Universal `cx` entrypoint & Nushell router), `filesystem` (`.home/` anchor provisioner).
  * **Consumed Components**: `container`, `config`, `console`, `filesystem`, `log` (`$CLAUSE_BOOTSTRAP_LOG`).
* **Quad Model Mechanics**:
  * **Fowler / Clean Arch**: Separated Interface (platform-agnostic TOML manifests vs. OS-specific `cx.ps1`/`cx.sh` bootstrappers), Layer Supertype (invariant `.home/` anchors).
  * **GoF**: Template Method (identical 3-stage boot sequence across Windows/Linux/macOS), Strategy (platform-specific path normalization and tar/curl extraction).
  * **Otwell**: Convention over Configuration (zero manual PATH setup; `config/env/*.toml` auto-discovered in lexical order).
  * **Storer / Systems Discipline**: Zero-Leak Confinement & Fail-Fast Redlines (immediate termination on unmanaged host package managers before a single byte is downloaded).

---

#### **Module 0.2: Three-Tier Toolchain Supply Chain (`Mise` Overlays, Lua Subtrees & Patched `Scoop`/`Brew`)**

* **ClauseOS Base**: `.clause.toml`, `.mise.toml`, `.mise.{paths,ai,cloud}.toml`, `plugins/cx-*`, `installer_scoop.ps1`, `installer_brew.sh`, `toml_pin.nu` (`[f02]`, `ADR 0002`) | **Orchestrator Equivalent**: `[c03]` Appendix A (Deterministic dependency pinning) | **Agent Harness Equivalent**: `r14` Ep. 4 (Declarative Plugin Reconciliation), `r16` Ch. 21 (Plugin Extension Surfaces), `r22` Ch. 29.5 (Environment `requires` Pre-Filtering)
* **Shared Concept**: Decoupling base CLI tools, heavy multi-language/AI runtimes, and general OS utilities into three isolated tiers inside `.home/` so Rust/Cargo, BEAM/Gleam, Python wheels, and package managers never collide or mutate host state.
* **ClauseOS Supply-Chain Mechanics (`[f02]`, `ADR 0002`)**:
  1. **Tier 1 — Stage 0/1 Pre-Mise Bootstrap (`.clause.toml` + `scripts/cli/{pwsh,posix}/installers/`):** Self-contained installers pre-seed `pwsh`, `nu`, `mise`, `uv`, in-place patched `scoop` (`$CLAUSE_CACHE_DIR/toolchain/scoop`), and confined `brew` (`$HOMEBREW_PREFIX`) directly into `$CLAUSE_BIN_DIR`.
  2. **In-Place Scoop Sterilization (`installer_scoop.ps1`):** Patches `lib/core.ps1`, `lib/shortcuts.ps1`, `lib/system.ps1` (`Set-EnvVar` no-op override), and `libexec/scoop-import.ps1` (`# clause-scoop-patches: 1`) so Scoop never writes to `HKCU:\Environment`, `HKCU:\Software\Classes`, or Windows Start Menu folders.
  3. **Tier 2 — Layered `MISE_ENV` Overlays & First-Party Lua Plugins (`MISE_ENV="paths,ai,cloud"`):** Separates path shims (`.mise.paths.toml`), AI/BEAM runtimes (`.mise.ai.toml`: `erlang`, `elixir`, `gleam`, `rebar` + Windows `rebar3.cmd` trampoline, `cx-lemonade`, `cx-fastflowlm`, `cx-inferssd`, `cx-unsloth`, `cx-comfyui`, `cx-vscode`), and cloud/orchestration tools (`.mise.cloud.toml`: `nomad`, `consul`, `vault`, `packer`, `boundary`, `pulumi`, `brew:lima`).
  4. **Git Subtree Plugin Stewardship (`cx plugin add|pull|push`):** Mounts first-party Lua plugins (`plugins/cx-*`) and upstream reference repositories (`references/*`, `vendor/craft/*`) via `git subtree --squash` with `git ls-remote` commit provenance.
  5. **Tier 3 — Unified Polyglot Package Control Plane (`cx pkg:*` + `toml_pin.nu`):** Routes `cx pkg:add`, `cx pkg:mise`, `cx pkg:scoop`, and `cx pkg:brew` while automatically pinning resolved versions back into `.mise.<env>.toml`.
* **Laravel Component Adoption & Target Primitives**:
  * **Target Primitives**: `IToolchainDriver`, `IPackageAdapter`, `IVersionPinner`
  * **Created Components**: `macroable` (Lua plugin hook engine `available.lua`, `pre_install.lua`, `post_install.lua`, `env_keys.lua`), `process` (Isolated `uv` venv builders).
  * **Consumed Components**: `config`, `filesystem`, `process`, `hashing` (SHA-256 release verification in `cx-inferssd` / `installer_wsl.ps1`).
* **Quad Model Mechanics**:
  * **Fowler / Clean Arch**: Plugin Architecture (isolated Mise Lua plugins), Gateway (confined Scoop/Brew adapters), Separated Interface (abstracting OS package managers behind `cx pkg:add`).
  * **GoF**: Adapter (`scoop.nu` and `brew.nu` adapting native package managers to TOML pinning), Proxy (Protection Proxy blocking `-g`/`--global` and `--cask` flags), Factory Method (`uv` manufacturing per-app Python interpreters).
  * **Otwell**: Expressive Package Commands (`cx pkg:add inferssd@v0.1.4 -e ai`), Automatic Manifest Pinning (`toml_pin.nu`).
  * **Storer / Systems Discipline**: Idempotent Fast-Path Checks (bypassing downloads in milliseconds when target binaries and `# clause-scoop-patches: 1` markers exist).

---

#### **Module 0.3: Dynamic 5-Way Hardware Acceleration Matrix & Unified `$HF_HOME` Model Hub**

* **ClauseOS Base**: `config/env/40-ml-hub.toml`, `plugins/cx-{unsloth,comfyui,lemonade,fastflowlm,inferssd}` (`[f03]`, `ADR 0003`, `ADR 0005`, `ADR 0013`) | **Orchestrator Equivalent**: `[c03]` Ch. 6 & 10 (Hardware resource telemetry & capability-aware placement) | **Agent Harness Equivalent**: `b14` Ch. 9–10 (Inference Engines `vLLM`/`LitServe` & Model Gateways), `b19` Ch. 3 & 8 (Hardware Acceleration & Edge Coprocessors)
* **Shared Concept**: Runtime GPU/NPU/SSD hardware probing paired with a single zero-duplication model weights hub (`$HF_HOME`) serving local OpenAI-compatible neural coprocessors (`1B–7B` contained domain SLMs) without requiring host GPU driver installs.
* **ClauseOS Hardware & Model Hub Mechanics (`[f03]`, `ADR 0003`, `ADR 0005`, `ADR 0013`)**:
  1. **5-Way Runtime Accelerator Probing (`ADR 0003`):** Probes `nvidia-smi` (CUDA `cu124`/`cu126`/`cu128`/`cu130`), `/dev/kfd` & `rocminfo` (Linux ROCm 7.2), `Win32_VideoController` (Windows ROCm 10.0 `torch[device-all]`), Intel Arc (`xpu`), Apple Silicon (`mps`), and Intel macOS (`x86_64` CPU fallback filtering `comfy-angle`).
  2. **Unified Model Storage Anchor (`40-ml-hub.toml` / `ADR 0005`):** Anchors `HF_HOME = "${CLAUSE_CACHE_DIR}/huggingface"`, `HF_HUB_CACHE = "${HF_HOME}/hub"`, `HF_ASSETS_CACHE = "${HF_HOME}/assets"`, `TRANSFORMERS_CACHE`, `TORCH_HOME`, and `INFERSSD_HOME` to one shared disk tree—eliminating duplicate multi-GB GGUF/safetensors downloads across Unsloth, ComfyUI (`extra_model_paths.yaml`), Lemonade, FastFlowLM, and InferSSD.
  3. **Contained Domain SLMs vs. Saturated Generalists (`ADR 0013`):** Uses Unsloth to distill and quantize task-specific `1B–7B` worker models directly into `$HF_HUB_CACHE` trained strictly on repository ADRs, schemas, and test vectors—stripping latent sycophancy/evasion behaviors and running locally via `Lemonade` (`:13305`) / `InferSSD` (`:13306`).
* **Laravel Component Adoption & Target Primitives**:
  * **Target Primitives**: `IHardwareHAL`, `IModelHub`, `ICoprocessorSupervisor`
  * **Created Components**: `cache` (Unified `$HF_HOME` weights cache), `http` (OpenAI-compatible local coprocessor client).
  * **Consumed Components**: `config`, `filesystem`, `process`, `cache`, `http`.
* **Quad Model Mechanics**:
  * **Fowler / Clean Arch**: Gateway (OpenAI-compatible `/v1/chat/completions` facade over Lemonade/FastFlowLM/InferSSD), Registry (centralized `$HF_HUB_CACHE` blob catalog).
  * **GoF**: Strategy (5-way wheel index & backend selection), Flyweight (sharing single read-only GGUF/safetensors blobs across multiple concurrent inference engines).
  * **Otwell**: Zero-Config Hardware Auto-Detection, Unified Coprocessor Facade.
  * **Storer / Systems Discipline**: Zero-Copy NVMe/VRAM Streaming (`InferSSD` direct SSD-to-GPU paging) and Graceful CPU Fallback.

---

#### **Module 0.4: Hermetic Identity Lock & Automated Verification Harness (`cx identity`, `cx test`)**

* **ClauseOS Base**: `config/env/10-identity.toml`, `scripts/cli/nu/commands/identity.nu`, `tests/system/{run_all.nu,test_stage0.nu,test_stage1.nu,test_hermeticity.nu}` (`[f04]`, `ADR 0001`, `ADR 0004`) | **Orchestrator Equivalent**: `[c03]` Ch. 1.9.5 & Ch. 12 (Security isolation & CLI health verification) | **Agent Harness Equivalent**: `r16` Ch. 30 (`Doctor.tsx` Self-Check Dashboard), `r22` Ch. 32.4 (`openclaw security audit`)
* **Shared Concept**: Sealing cryptographic Git/SSH credentials inside `.home/.ssh` and `.home/.gitconfig` while running an automated cross-platform verification harness (`cx test`) that proves zero host pollution before any compiler or agent code is built.
* **ClauseOS Identity & Verification Mechanics (`[f04]`, `ADR 0001`, `ADR 0004`)**:
  1. **Hermetic Git & SSH Credential Lock (`10-identity.toml`):** Confines `GIT_CONFIG_GLOBAL` (`${CLAUSE_HOME}/.gitconfig`), `GH_CONFIG_DIR` (`${CLAUSE_CONFIG_DIR}/gh`), and `GIT_SSH_COMMAND` (`ssh -F '${CLAUSE_SSH_CONFIG}' -o UserKnownHostsFile='${CLAUSE_SSH_KNOWN_HOSTS}'`), paired with an `ssh` proxy function in `cx.ps1` and `cx.sh`.
  2. **Interactive Identity Management (`cx identity {setup, import, new, show}`):** Guides operators to import existing host SSH keypairs or mint fresh Ed25519 keys strictly inside `.home/.ssh/` without ever modifying `~/.ssh`.
  3. **Automated Hermeticity Assertion Suite (`cx test` / `run_all.nu`):** Executes `test_stage0.nu` (bootloader & TOML symbol resolution), `test_stage1.nu` (Mise shims & patched Scoop/Brew), and `test_hermeticity.nu` (asserting zero host PATH leakage, zero `HKCU:\Environment` mutations, and macOS `/var` vs `/private/var` symlink canonicalization).
* **Laravel Component Adoption & Target Primitives**:
  * **Target Primitives**: `IIdentityVault`, `IHermeticityAuditor`, `ITestRunner`
  * **Created Components**: `testing` (`run_all.nu` / `cx test` hermeticity assertions), `encryption` (Isolated SSH key & Git credential routing).
  * **Consumed Components**: `config`, `console`, `filesystem`, `testing`, `encryption`.
* **Quad Model Mechanics**:
  * **Fowler / Clean Arch**: Service Layer (`identity.nu` credential provisioning), Separated Interface (platform-independent `run_all.nu` assertions).
  * **GoF**: Proxy (`ssh` command wrapper enforcing `-F $CLAUSE_SSH_CONFIG`), Command (`cx test` diagnostic test suite).
  * **Otwell**: Expressive Verification (`cx test`, `cx identity setup`), Zero-Leak Defaults.
  * **Storer / Systems Discipline**: Continuous Invariant Enforcement (CI/CD blocks every commit that leaks a single path or registry key outside `.home/`).

---

#### **Module 0.5: AIEFS (*AI Engineering From Scratch*) & Content-Addressed Workspace (`seax-vfs`)**

* **AIEFS & ClauseOS Base**: *AIEFS (AI Engineering From Scratch)* (`[e01]`–`[e06]`: Vol. 1 Foundations, Vol. 2 Deep Learning, Vol. 3 Language, Vol. 4 LLMs, Vol. 5 Agents, Vol. 6 Production), `ADR 0005` (Unified Model Storage), `ADR 0008` (Closed-World `.ground` & Virtual Enterprise Directory), `ADR 0011` ("Agent is a Directory") | **Agent Harness Equivalent**: `r14` Ep. 9–10 (JSONL Sidechains & `memdir`), `r15` Ch. 11 & 18 (Bet 2: File-Based Memory Over Databases), `r18` Secret #8 (Plain Markdown Memory), `r22` Ch. 28 & 32.5 (Files as Immutable Truth & Git-Versioned Workspaces)
* **Shared Concept**: Grounding every compiler, runtime, and agent layer in first-principles AI engineering (*AI Engineering From Scratch* `[e01]`–`[e06]`) while treating the `.home/` filesystem itself as the primary semantic, content-addressed, and transactional state substrate—eliminating fragile external vector-DB daemons while providing cryptographic provenance, semantic path mounting, and atomic snapshot rollbacks.
* **AIEFS (*AI Engineering From Scratch*) & Filesystem Substrate Mechanics (`[e01]`–`[e06]`, `ADR 0005`, `ADR 0008`, `ADR 0011`)**:
  1. **First-Principles AI Engineering Stack (`[e01]`–`[e06]`):** Establishes the complete mathematical and engineering spine from *AI Engineering From Scratch*—foundations & tensor mechanics (`[e01]`), neural architectures & training loops (`[e02]`), tokenization & sequence modeling (`[e03]`), transformer LLM internals & inference optimization (`[e04]`), agentic control loops & tool grounding (`[e05]`), and production evaluation, observability, & deployment (`[e06]`).
  2. **Content-Addressed Immutable Asset & Blob Vault (`crates/seax-vfs`):** Stores media stems, rendered frames, model weights, and intermediate tool outputs (>30KB disk spills) by SHA-256 content digest inside `.home/`, enabling zero-copy deduplication and instant deterministic cache hits across agents and Craft editors.
  3. **Filesystem-as-Topology ("Agent is a File, Folder is a Department"):** Maps directory structure directly to runtime supervision and capability boundaries (`agent.cx`, `team/`, `skills/`, `mcp/`, `plugins/`, `package.seax`), allowing operators to inspect, diff, and version-control entire agent organizations with standard `git` and POSIX/Nushell tools.
  4. **Semantic Mounts & Dual-Index Derived Caches:** Keeps human-readable Markdown (`MEMORY.md`, `CLAUDE.md`, `constitution.toml`, daily logs) and JSONL transcripts as the **immutable source of truth**, while maintaining rebuildable SQLite WAL + FTS5 + embedding indexes as disposable derived caches (`r22` Ch. 28).
  5. **Atomic Two-Step Commit & Snapshot Rollback (`os.rename` + Git Checkpoints):** All state mutations write to `.tmp` files and commit via atomic `os.rename`, paired with per-subgoal Git worktree checkpoints so failed agent runs roll back cleanly without corrupting shared workspace state.
* **Laravel Component Adoption & Target Primitives**:
  * **Target Primitives**: `IAIEFSStore`, `IContentAddressedVault`, `ISemanticMount`
  * **Created Components**: `filesystem` (Content-addressed VFS & atomic rename engine), `hashing` (SHA-256 blob addressing & integrity verification).
  * **Consumed Components**: `filesystem`, `hashing`, `database` (SQLite WAL/FTS5 derived index), `encryption` (Vault-encrypted secret mounts).
* **Quad Model Mechanics**:
  * **Fowler / Clean Arch**: Unit of Work (atomic `.tmp` $\rightarrow$ `os.rename` transactional commits), Repository (unified VFS interface over local disk and content-addressed blobs).
  * **GoF**: Flyweight (content-addressed SHA-256 blob sharing across multiple agents and timelines), Memento (deterministic filesystem & Git worktree snapshots), Composite (recursive directory-as-department supervision tree).
  * **Otwell**: Files-as-Source-of-Truth (`MEMORY.md`, `package.seax`), Zero-Ceremony Directory Conventions.
  * **Storer / Systems Discipline**: Immutable Blob Addressing (zero-copy sharing of large audio/video buffers and model checkpoints), Derived-Cache Rebuildability.

> **Next Stage:** With the `.home/` bare-metal userland sealed (`Modules 0.1–0.5`), proceed to **`03-stage1-2-compiler-orchestrator-v4.3.md`** to build the **Seax (`.cx`)** compiler (`Stage 1: Modules 1–5`) and **Distributed Orchestrator + Pulumi IaC** (`Stage 2: Modules 6–10`).
