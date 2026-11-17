# ADR 002: Two-Tier Toolchain Orchestration (Mise + Renv)

* **Status** : Accepted (Amended 2026-11-15)
* **Date** : 2026-10-28
* **Context** : ClauseOS Runtime Lifecycle & Tool Provisioning

## Context and Problem Statement

A microkernel operating system environment requires a consistent set of base command-line tools (such as `uv`, `just`, `git`, `nu`), alongside heavy, specialized runtime stacks (such as PyTorch, CUDA, Unsloth, and ComfyUI).

Managing heavy AI engines inside a single global tool manager like `mise` introduces critical bottlenecks:
1. Mise locks tools globally across the project workspace, causing dependency and Python version collisions between applications requiring distinct PyTorch wheels or ABI versions.
2. Large Python AI ecosystems must not pollute the base developer shell with transitive packages.
3. Pre-Mise bootstrap tools (the bootloader toolchain) must be initialized before Mise runs, while application-level virtual environment recipes require Mise tools (specifically `uv`) to be already present and active.

## Decision Outcome

Chosen Option: **Split the pipeline into a strict two-tier architecture (mise base layer + renv application recipes)**.

```text
+-------------------------------------------------------------------------+
| STAGE 1: BOOTSTRAP INSTALLERS (scripts/cli/pwsh/installers/)            |
| -> Provision Stage 0 host tools (Mise, Nu, Just) into CLAUSE_BIN_DIR    |
+-------------------------------------------------------------------------+
                                    |
                                    v
+-------------------------------------------------------------------------+
| STAGE 2: TOOLCHAIN SYNC (mise install)                                  |
| -> Mise reads .mise.toml to provision core developer tools (e.g. uv)   |
| -> Shims injected into session PATH                                     |
+-------------------------------------------------------------------------+
                                    |
                                    v
+-------------------------------------------------------------------------+
| STAGE 3: APPLICATION RUNTIME RECIPES (scripts/cli/pwsh/renv/)           |
| -> Dedicated recipes triggered via .clause.toml declarations            |
| -> Each app gets a hermetic venv and private Python runtime via uv      |
| -> Dedicated trampolines generated in apps/<name>/bin                   |
+-------------------------------------------------------------------------+
```

### Technical Separation Rules
1. **`scripts/cli/pwsh/installers/`**:
   * Executes during **Stage 1** (Pre-Mise).
   * Contains self-contained bootstrap scripts (`installer_mise.ps1`, `installer_just.ps1`, etc.).
   * Emits binaries directly to `$env:CLAUSE_BIN_DIR`.
2. **`scripts/cli/pwsh/renv/`**:
   * Executes during **Stage 3** (Post-Mise).
   * Contains complex application recipes (`installer_unsloth.ps1`, `installer_comfyui.ps1`).
   * Relies on `$env:CLAUSE_BIN_DIR/uv` or Mise shims to provision dedicated Python interpreters in `$env:CLAUSE_APPS_DIR/<app>/python` and isolated virtual environments in `$env:CLAUSE_APPS_DIR/<app>/venv`.
   * Never shares Python interpreters or packages across applications.

## Consequences

### Positive
* Complete decoupling of base development tools from heavy AI dependencies.
* Zero risk of Unsloth and ComfyUI package version conflicts.
* Fast execution path: Idempotency checks bypass runtime provisioning in milliseconds once the environment hash is satisfied.

### Negative
* Disk space usage increases due to separate virtual environments for each AI application stack.

---

## Implementation Evolution & Addendum (2026-11-15)

Following Stage 0/1 stabilization (`v0.8.0-dev.1` – `v0.8.0-dev.10`), the Stage 3 `scripts/cli/pwsh/renv/` recipes (`unsloth`, `comfyui`, `vscode`) and local neural coprocessors (`lemonade`, `fastflowlm`, `inferssd`) were promoted into **first-party cross-platform Lua Mise plugins** maintained under `plugins/mise-*` as git subtrees (`cx plugin add|pull|push`).

This expanded the toolchain into a **Three-Tier Hermetic Orchestration Model**:
1. **Tier 1 — Stage 0/1 Microkernel Bootstrap (`.clause.toml` & `config/env/*.toml`)**: Self-contained installers in `scripts/cli/pwsh/installers/` and `scripts/cli/posix/installers/` pre-seed `pwsh`, `nu`, `mise`, `uv`, and hermetically confined `scoop` / `brew` directly into `$CLAUSE_BIN_DIR` / `$CLAUSE_APPS_DIR`.
2. **Tier 2 — Declarative Layered Mise Overlays & Lua Plugins (`.mise*.toml` + `plugins/mise-*`)**: Core runtimes, HashiStack, BEAM/Gleam, and AI engines (`unsloth`, `comfyui`, `code`, `lemonade`, `fastflowlm`, `inferssd`) are provisioned via layered `MISE_ENV="paths,ai,cloud"` manifests with isolated per-application virtual environments inside `$MISE_DATA_DIR/installs/`.
3. **Tier 3 — Confined OS Package Adapters (`cx pkg:*`)**: General-purpose utilities are installed through `cx pkg:add`, `cx pkg:scoop` (backed by `installer_scoop.ps1`'s in-place core patches to `lib/core.ps1`, `lib/shortcuts.ps1`, `lib/system.ps1`, and `libexec/scoop-import.ps1` plus `environment.ps1` registry PATH snapshot guards), and `cx pkg:brew`, with `toml_pin.nu` automatically pinning resolved versions into `.mise*.toml`.