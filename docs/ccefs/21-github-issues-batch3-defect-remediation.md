# ClauseOS Repository Master Issue Specifications (Batch 3 Defect Remediation)

**Artifact Designation:** `docs/ccefs/21-github-issues-batch3-defect-remediation.md`  
**Classification:** Track 1 CCEFS Toolchain Substrate & Repository Defect Registry  
**Governance Hierarchy:** Supreme Single Source of Truth (SSOT) Protocol (`06` $\rightarrow$ `05` $\rightarrow$ `00`–`04` $\rightarrow$ `a`–`t`)  
**Analytical Perspective:** Principal Systems Architect / PhD Curriculum Fellow (Quad Synthesis: *Fowler P-EAA* + *Gang of Four* + *Otwell/Laravel DX* + *Storer Real-Time Zero-Allocation Audio/Video DSP*)

---

## Executive Summary & Issue Generation Mandate

To operationalize the findings of **`05-source-bundle-audit-report.md`**, **`n01-scoop-path-audit`**, **`15-investigation-report-cx-pkg-refactor-clauseos.md`**, and **`20-sovereign-engineering-architecture-synthesis-v2.md`**, this document formalizes the production-ready GitHub Issue specifications for all **12 Subsystem Code & Configuration Defects (`DEF-01` through `DEF-12`)** and **3 Repository Governance Issues (`GITHUB-01` through `GITHUB-03`)**.

Every issue specification conforms strictly to the schema defined in `.github/ISSUE_TEMPLATE/` and assigns authoritative labels synchronized with `.github/settings.yml` (including standard baseline labels: `bug`, `documentation`, `duplicate`, `enhancement`, `good first issue`, `help wanted`, `invalid`, `question`, `wontfix`).

---

## Issue Registry Index

| Issue ID | Canonical Issue Title | Primary Labels | Milestone | Severity / Priority |
| :--- | :--- | :--- | :--- | :--- |
| **`DEF-01`** | `[Bug]: Refactor env.nu to consume compiled TOML environment variables` | `bug`, `Area: Substrate & Boot`, `Priority: Critical`, `Severity: Blocker` | `v0.9.0-dev.1` | Blocker |
| **`DEF-02`** | `[Bug]: Restore canonical WSL2/Lima micro-VM text in adr_006` | `bug`, `documentation`, `Area: Docs & Curriculum`, `Priority: Critical` | `v0.9.0-dev.1` | Blocker |
| **`DEF-03`** | `[Bug]: Re-enable automated CI test execution in ci.yml` | `bug`, `Area: CI-CD & Tests`, `Priority: Critical`, `Severity: Blocker` | `v0.9.0-dev.1` | Blocker |
| **`DEF-04`** | `[Bug]: Update test_stage1.nu path assertions to probe MISE_INSTALLS_DIR` | `bug`, `Area: CI-CD & Tests`, `Priority: High`, `Severity: Major` | `v0.9.0-dev.1` | Major |
| **`DEF-05`** | `[Bug]: Strip literal citation markers from test_env.nu and test_env.sh` | `bug`, `Area: CI-CD & Tests`, `Priority: High`, `Severity: Major` | `v0.9.0-dev.1` | Major |
| **`DEF-06`** | `[Bug]: Add _CALLER_CLAUSE_STATUS nested subshell guard to cx.sh` | `bug`, `Target: Linux`, `Target: macOS`, `Area: Substrate & Boot` | `v0.9.0-dev.1` | Major |
| **`DEF-07`** | `[Enhancement]: Generate extra_model_paths.yaml in ComfyUI post-install hook` | `enhancement`, `Area: TIGAH & AI`, `Area: Plugins & Toolchains` | `v0.9.0-dev.1` | Medium |
| **`DEF-08`** | `[Bug]: Export SCOOP_SHIMS and inject into session PATH in cx.ps1` | `bug`, `Target: Windows`, `Area: Substrate & Boot`, `Priority: High` | `v0.9.0-dev.1` | Major |
| **`DEF-09`** | `[Bug]: Fix broken delegation to scoop and brew in commands/pkg/add.nu` | `bug`, `Area: Plugins & Toolchains`, `Priority: Critical`, `Severity: Blocker` | `v0.9.0-dev.1` | Blocker |
| **`DEF-10`** | `[Bug]: Ingest manifest 'bin' property in commands/pkg/scoop.nu` | `bug`, `Target: Windows`, `Area: Plugins & Toolchains`, `Priority: High` | `v0.9.0-dev.1` | Major |
| **`DEF-11`** | `[Enhancement]: Add backward-compatible alias redirects for package managers in mod.nu` | `enhancement`, `Area: CLI & DX`, `Priority: Medium` | `v0.9.0-dev.1` | Medium |
| **`DEF-12`** | `[Bug]: Fix non-existent Scoop probe path in commands/boot_check.nu` | `bug`, `Target: Windows`, `Area: Substrate & Boot`, `Priority: Low` | `v0.9.0-dev.1` | Minor |
| **`GITHUB-01`** | `[Docs]: Synchronize subsystem checklist paths in PULL_REQUEST_TEMPLATE.md` | `documentation`, `Area: Docs & Curriculum`, `Priority: Medium` | `v0.9.0-dev.1` | Minor |
| **`GITHUB-02`** | `[Security]: Update contact email in ISSUE_TEMPLATE/6-security-report.yml` | `Area: Security`, `Priority: High`, `Severity: Minor` | `v0.9.0-dev.1` | Minor |
| **`GITHUB-03`** | `[Docs]: Purge phantom enterprise directory from .github/settings.yml labels` | `documentation`, `Area: Virtual Enterprise`, `Priority: Low` | `v0.9.0-dev.1` | Trivial |

---

## Detailed Issue Specifications

### Issue DEF-01: Refactor `env.nu` to Consume Compiled TOML Environment Variables

* **Issue Title:** `[Bug]: Refactor env.nu to consume compiled TOML environment variables`
* **Labels:** `bug`, `Area: Substrate & Boot`, `Priority: Critical`, `Severity: Blocker`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `scripts/cli/nu/config/env.nu` (Lines 1–85)
* **Problem Statement:**  
  During Stage 0 boot, `cx.ps1` and `cx.sh` compile the 5 modular configuration files (`config/env/00-core.toml` through `40-ml-hub.toml`) via an 8-pass iterative symbol expansion algorithm and export the resulting environment variables directly into the session process. However, `scripts/cli/nu/config/env.nu` still attempts to read a retired legacy `.env` file and indexes obsolete `WIN_*` keys (e.g., `WIN_LOCALAPPDATA`). On clean machines where `.env` does not exist, Nushell boot halts with missing variable errors.
* **Acceptance Criteria & Verification Gate:**  
  1. Remove legacy `.env` file parsing logic from `scripts/cli/nu/config/env.nu`.
  2. Ingest existing session environment variables directly (`$env.CLAUSE_HOME`, `$env.CLAUSE_DATA_DIR`, `$env.CLAUSE_BIN_DIR`, `$env.CLAUSE_CACHE_DIR`, `$env.HF_HOME`).
  3. Verify that Nushell boots cleanly without warnings or errors via `.\cx.ps1` and `./cx.sh`.
  4. Binary Gate: `cx test` passes `tests/system/test_stage0.nu` with exit code `0`.

---

### Issue DEF-02: Restore Canonical WSL2/Lima Micro-VM Text in `adr_006`

* **Issue Title:** `[Bug]: Restore canonical WSL2/Lima micro-VM specification in adr_006`
* **Labels:** `bug`, `documentation`, `Area: Docs & Curriculum`, `Area: Infra & MaaS`, `Priority: Critical`, `Severity: Blocker`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `docs/adr/adr_006-micro-instance-virtualization.md`
* **Problem Statement:**  
  The physical file content of `docs/adr/adr_006-micro-instance-virtualization.md` in repository snapshot `06` is a byte-for-byte duplicate of `ADR 005` (*Unified Model Storage & Ecosystem Cache Projection*). The architectural decision record governing cross-platform micro-instances (`cx vm`), WSL2 bare-metal hypervisor bridges (`installer_wsl.ps1`), Lima macOS/Linux confinement, and rootless Podman/k3s execution is completely missing from the live ADR ledger.
* **Acceptance Criteria & Verification Gate:**  
  1. Replace the duplicated text in `docs/adr/adr_006-micro-instance-virtualization.md` with the canonical specification staged in `batch1-surgical-diffs.patch`.
  2. Verify that ADR 006 explicitly details `installer_wsl.ps1`, Lima instances in `$LIMA_HOME`, and `cx vm {launch, exec, shell, list, stop, purge}`.
  3. Ensure zero ungrounded containerization claims enter the document.

---

### Issue DEF-03: Re-Enable Automated CI Test Execution in `ci.yml`

* **Issue Title:** `[Bug]: Uncomment test execution steps in GitHub Actions workflow ci.yml`
* **Labels:** `bug`, `Area: CI-CD & Tests`, `Priority: Critical`, `Severity: Blocker`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `.github/workflows/ci.yml` (Lines 74 & 84)
* **Problem Statement:**  
  In `.github/workflows/ci.yml`, line 74 (`# run: ./cx.sh test`) and line 84 (`# run: .\cx.ps1 test`) are commented out. Consequently, GitHub Actions passes green builds without ever running the system hermeticity test suite (`tests/system/run_all.nu`). Regressions can enter `main` without detection.
* **Acceptance Criteria & Verification Gate:**  
  1. Uncomment line 74 in `.github/workflows/ci.yml` so POSIX runners execute `./cx.sh test`.
  2. Uncomment line 84 in `.github/workflows/ci.yml` so Windows runners execute `.\cx.ps1 test`.
  3. Ensure all CI jobs execute `tests/system/run_all.nu` and require exit code `0` across Ubuntu, Windows, and macOS.

---

### Issue DEF-04: Update `test_stage1.nu` Path Assertions to Probe `MISE_INSTALLS_DIR`

* **Issue Title:** `[Bug]: Update path assertions in test_stage1.nu to inspect MISE_INSTALLS_DIR`
* **Labels:** `bug`, `Area: CI-CD & Tests`, `Priority: High`, `Severity: Major`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `tests/system/test_stage1.nu` (Lines 22–35)
* **Problem Statement:**  
  `tests/system/test_stage1.nu` verifies toolchain hydration by inspecting the legacy path `$CLAUSE_APPS_DIR` (e.g., `.home/AppData/Local/Programs/apps/`). Under the modular Mise architecture (`ADR 0002`), runtimes such as Erlang, Elixir, and Gleam are installed into `$MISE_INSTALLS_DIR` (`.home/.local/share/mise/installs/` on POSIX, `.home/AppData/Local/mise/installs/` on Windows). The test fails falsely even when toolchains are correctly installed.
* **Acceptance Criteria & Verification Gate:**  
  1. Update `tests/system/test_stage1.nu` to assert the presence of installed runtimes in `$env.MISE_INSTALLS_DIR`.
  2. Support active `MISE_ENV="paths,ai,cloud"` multi-overlay profiles.
  3. Binary Gate: `nu tests/system/test_stage1.nu` returns exit code `0`.

---

### Issue DEF-05: Strip Literal Citation Markers from `test_env.nu` and `test_env.sh`

* **Issue Title:** `[Bug]: Strip literal citation markers from environment test scripts`
* **Labels:** `bug`, `Area: CI-CD & Tests`, `Priority: High`, `Severity: Major`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target Files:** `tests/env/test_env.nu`, `tests/env/test_env.sh`
* **Problem Statement:**  
  `tests/env/test_env.nu` and `tests/env/test_env.sh` contain copy-pasted literal citation markers (e.g., `[cite: 14]`, `[cite: 18]`) and attempt to source dead pre-TOML shell scripts (`config/env.nu`, `config/env.sh`). Running the environment test suite results in syntax errors and script aborts.
* **Acceptance Criteria & Verification Gate:**  
  1. Strip all non-code citation markers from `tests/env/test_env.nu` and `tests/env/test_env.sh`.
  2. Update environment assertions to validate variables compiled from `config/env/*.toml`.
  3. Binary Gate: `./tests/env/test_env.sh` and `nu tests/env/test_env.nu` exit `0`.

---

### Issue DEF-06: Add `_CALLER_CLAUSE_STATUS` Nested Subshell Guard to `cx.sh`

* **Issue Title:** `[Bug]: Add _CALLER_CLAUSE_STATUS recursion guard to POSIX bootloader cx.sh`
* **Labels:** `bug`, `Target: Linux`, `Target: macOS`, `Area: Substrate & Boot`, `Priority: Medium`, `Severity: Major`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `cx.sh` (Lines 14–25)
* **Problem Statement:**  
  `cx.ps1` preserves session state across nested CLI subshells by checking `_CALLER_CLAUSE_STATUS="online"` and validating that `$env:MISE_DATA_DIR` resides within `$env:CLAUSE_HOME`. `cx.sh` lacks this symmetrical check, causing nested calls (such as `cx pkg:add` invoking `cx pkg:scoop`) on POSIX systems to re-run the entire preflight validation sequence, degrading execution performance.
* **Acceptance Criteria & Verification Gate:**  
  1. Mirror `cx.ps1`'s nested caller check in `cx.sh`:

     ```bash
     if [ "${CLAUSE_STATUS:-}" = "online" ] && [ -n "${_CALLER_CLAUSE_STATUS:-}" ]; then
         # Fast-path nested invocation
     fi
     ```

  2. Ensure nested subshells preserve environment variables without recursive re-initialization.

---

### Issue DEF-07: Generate `extra_model_paths.yaml` in ComfyUI Post-Install Hook

* **Issue Title:** `[Enhancement]: Generate extra_model_paths.yaml in ComfyUI plugin hook`
* **Labels:** `enhancement`, `Area: TIGAH & AI`, `Area: Plugins & Toolchains`, `Priority: Medium`, `Severity: Minor`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `plugins/cx-comfyui/hooks/post_install.lua`
* **Problem Statement:**  
  Under `ADR 0005`, all neural model weights must reside in the unified `$HF_HUB_CACHE` directory (`.home/.../cache/huggingface/hub`). ComfyUI defaults to searching for checkpoints inside its own local `models/` directory. `plugins/cx-comfyui/hooks/post_install.lua` does not emit an `extra_model_paths.yaml` file, causing ComfyUI to fail to discover models stored in the shared hub or duplicate multi-gigabyte files.
* **Acceptance Criteria & Verification Gate:**  
  1. Add logic to `plugins/cx-comfyui/hooks/post_install.lua` to dynamically generate `extra_model_paths.yaml` inside ComfyUI's root directory.
  2. Bind `checkpoints`, `unet`, `clip`, `vae`, and `loras` paths directly to `$HF_HUB_CACHE` and `$INFERSSD_HOME`.
  3. Verify that ComfyUI starts and discovers unified models without file duplication.

---

### Issue DEF-08: Export `SCOOP_SHIMS` and Inject into Session `PATH` in `cx.ps1`

* **Issue Title:** `[Bug]: Expose Scoop shims on session PATH in cx.ps1 and 20-toolchains.toml`
* **Labels:** `bug`, `Target: Windows`, `Area: Substrate & Boot`, `Priority: High`, `Severity: Major`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target Files:** `config/env/20-toolchains.toml`, `cx.ps1`
* **Problem Statement:**  
  Forensic audit `n01-scoop-path-audit` revealed that while `installer_scoop.ps1` successfully neutralizes registry writes via `# clause-scoop-patches: 1`, neither `cx.ps1` nor `config/env/20-toolchains.toml` exposes `$env:SCOOP\shims` on session `$env:PATH`. Applications installed via Scoop (e.g., `jq`, `ripgrep`, `curl`) reside on disk in `.home/.../toolchain/scoop/shims` but cannot be located or executed by the shell.
* **Acceptance Criteria & Verification Gate:**  
  1. In `config/env/20-toolchains.toml`, export `SCOOP_SHIMS = "${SCOOP}/shims"`.
  2. In `cx.ps1`, prepend `$env:SCOOP\shims` to `$env:PATH` when initializing the Windows environment.
  3. Verify that `jq --version` and `rg --version` execute successfully from a clean shell session.

---

### Issue DEF-09: Fix Broken Backend Delegation in `commands/pkg/add.nu`

* **Issue Title:** `[Bug]: Fix broken delegation to scoop and brew in commands/pkg/add.nu`
* **Labels:** `bug`, `Area: Plugins & Toolchains`, `Priority: Critical`, `Severity: Blocker`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `scripts/cli/nu/commands/pkg/add.nu` (Lines 26–39)
* **Problem Statement:**  
  During the `cx pkg` refactor (`docs/ccefs/15`), package management commands were moved from `commands/` into `commands/pkg/`. In `add.nu`, the backend match block delegates to `^$nu_bin $mod_nu scoop install ...` and `brew install ...`. Because `mod.nu` only searches for top-level command scripts, the router fails with `Command [scoop] not found`, rendering `cx pkg:add` completely non-functional for Scoop and Brew backends.
* **Acceptance Criteria & Verification Gate:**  
  1. In `scripts/cli/nu/commands/pkg/add.nu`, update lines 30, 32, 37, and 39 to invoke `pkg:scoop` and `pkg:brew`:

     ```nushell
     ^$nu_bin $mod_nu pkg:scoop install $parsed.target
     ^$nu_bin $mod_nu pkg:brew install $parsed.target
     ```

  2. Verify that running `cx pkg:add scoop:7zip` successfully invokes the Scoop wrapper and auto-pins the package.

---

### Issue DEF-10: Ingest Manifest `"bin"` Property in `commands/pkg/scoop.nu`

* **Issue Title:** `[Bug]: Extract manifest 'bin' property for path pinning in commands/pkg/scoop.nu`
* **Labels:** `bug`, `Target: Windows`, `Area: Plugins & Toolchains`, `Priority: High`, `Severity: Major`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `scripts/cli/nu/commands/pkg/scoop.nu` (Lines 118–125)
* **Problem Statement:**  
  In `pkg/scoop.nu`, lines 118–125 only parse `$manifest.env_add_path` when resolving `$resolved_paths` for `pin-bootstrap-pkg`. Over 95% of Scoop packages (e.g., `jq`, `fd`, `curl`) specify their executables using the `"bin"` property (e.g., `"bin": "jq.exe"`), leaving `env_add_path` empty. Consequently, installed binaries are never pinned to `.mise.<env>.toml` `_.path`.
* **Acceptance Criteria & Verification Gate:**  
  1. In `scripts/cli/nu/commands/pkg/scoop.nu`, expand path extraction to inspect both `env_add_path` and `"bin"` (supporting strings, arrays, and nested arrays).
  2. Automatically append resolved binary paths to `.mise.<env>.toml` `_.path` via `pin-bootstrap-pkg`.

---

### Issue DEF-11: Add Backward-Compatible Alias Redirects in `mod.nu`

* **Issue Title:** `[Enhancement]: Add backward-compatible alias redirects for package managers in mod.nu`
* **Labels:** `enhancement`, `Area: CLI & DX`, `Priority: Medium`, `Severity: Minor`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `scripts/cli/nu/mod.nu` (`resolve-command-script`)
* **Problem Statement:**  
  External host wrappers (`$LocalBin\scoop.cmd`) and developers accustomed to flat commands (`cx scoop`, `cx brew`, `cx mise`, `cx add`) experience runtime errors because `resolve-command-script` only converts colons to slashes.
* **Acceptance Criteria & Verification Gate:**  
  1. In `scripts/cli/nu/mod.nu`, add a backward-compatibility redirect table inside `resolve-command-script`:

     ```nushell
     if ($cmd in ["scoop", "brew", "mise", "add"]) {
         let pkg_script = ($commands_dir | path join "pkg" $"($cmd).($ext)")
         if ($pkg_script | path exists) { return $pkg_script }
     }
     ```

  2. Verify that running `cx scoop --help` transparently executes `scripts/cli/nu/commands/pkg/scoop.nu`.

---

### Issue DEF-12: Fix Non-Existent Scoop Probe Path in `commands/boot_check.nu`

* **Issue Title:** `[Bug]: Fix incorrect Scoop probe path in commands/boot_check.nu`
* **Labels:** `bug`, `Target: Windows`, `Area: Substrate & Boot`, `Priority: Low`, `Severity: Minor`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `scripts/cli/nu/commands/boot_check.nu` (Lines 11–15)
* **Problem Statement:**  
  `boot_check.nu` attempts to verify Scoop's installation on Windows by checking for `$root/.cache/toolchain/scoop/shims/scoop.ps1`. `installer_scoop.ps1` seeds Scoop into `apps/scoop/current/bin/scoop.ps1` and generates `$LocalBin\scoop.cmd`. The checked file never exists, causing `cx boot:check` to report a false failure for Scoop.
* **Acceptance Criteria & Verification Gate:**  
  1. Update `boot_check.nu` to probe `$root/.cache/toolchain/scoop/apps/scoop/current/bin/scoop.ps1` or `$env.CLAUSE_BIN_DIR/scoop.cmd`.
  2. Verify that `cx boot:check` accurately reports `[PASS] Scoop Package Substrate Online` on Windows.

---

### Issue GITHUB-01: Synchronize Subsystem Checklist in `PULL_REQUEST_TEMPLATE.md`

* **Issue Title:** `[Docs]: Synchronize subsystem checklist paths in PULL_REQUEST_TEMPLATE.md`
* **Labels:** `documentation`, `Area: Docs & Curriculum`, `Priority: Medium`, `Severity: Minor`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `.github/PULL_REQUEST_TEMPLATE.md` (Lines 21–25)
* **Problem Statement:**  
  Lines 21–25 still reference dead, pre-Batch 1 & 2 paths:

  ```markdown
  - [ ] Compiler & Runtime (compiler/seaxc/, packages/clause_cli/, packages/carrier_jet/, services/orchestrator/)
  - [ ] TIGAH AI Coprocessors & Virtual Enterprise (phantom enterprise directory, 40-ml-hub.toml)
  ```

  This causes PR contributors to verify against non-existent directories.
* **Acceptance Criteria & Verification Gate:**  
  1. Update the checklist to reference `packages/clause/` (`cxc`), `packages/clause_jet/`, `crates/clause-pulumi/`, and root `apm.yml` / `.apm/`.
  2. Purge all occurrences of `compiler/seaxc` and obsolete enterprise paths.

---

### Issue GITHUB-02: Update Contact Email in `ISSUE_TEMPLATE/6-security-report.yml`

* **Issue Title:** `[Security]: Update contact email in ISSUE_TEMPLATE/6-security-report.yml`
* **Labels:** `Area: Security`, `Priority: High`, `Severity: Minor`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `.github/ISSUE_TEMPLATE/6-security-report.yml` (Lines 31 & 72)
* **Problem Statement:**  
  Lines 31 and 72 contain an unscrubbed upstream email placeholder (`jgracia9988@gmail.com`). This leaks third-party configuration and contradicts `.github/SECURITY.md`.
* **Acceptance Criteria & Verification Gate:**  
  1. Replace all occurrences of `jgracia9988@gmail.com` with `security@vieo.ai`.
  2. Verify consistency with `.github/SECURITY.md`.

---

### Issue GITHUB-03: Purge Phantom Enterprise Directory from `.github/settings.yml` Labels

* **Issue Title:** `[Docs]: Purge phantom enterprise directory from .github/settings.yml labels`
* **Labels:** `documentation`, `Area: Virtual Enterprise`, `Priority: Low`, `Severity: Trivial`, `Status: Ready`
* **Assignees:** `@mrpastewart`
* **Target File:** `.github/settings.yml`
* **Problem Statement:**  
  In `.github/settings.yml`, the description for label `Area: Virtual Enterprise` reads:
  `phantom enterprise governance, .apm/ agent packaging, MCP/A2A protocols, and VS Code / Claude / Codex harness compilation.`
  Under the Batch 2 consensus, phantom enterprise is dead and replaced by root `apm.yml` and `.apm/`.
* **Acceptance Criteria & Verification Gate:**  
  1. Update the label description to:
     `.apm/ agent packaging, root apm.yml workspace, MCP/A2A protocols, and VS Code / Claude / Codex harness compilation.`
  2. Verify that `.github/settings.yml` contains zero occurrences of phantom enterprise directories.

---

## Downstream Execution Gate

With all 15 issue specifications finalized, this document is compiled and delivered as **`docs/ccefs/21-github-issues-batch3-defect-remediation.md`**.

The immediate next action is executing **Batch 3 Physical Code Repairs**, verifying that `cx test` passes with exit code `0`, and creating these corresponding issues on GitHub.
