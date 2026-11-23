# ClauseOS Source Bundle & Notebook Forensic Audit Report

> **Audit Scope:** 177-file `clauseos-source-bundle.md` (`v0.9.0-dev.1`) audited internally (code, configs, tests, ADRs) and cross-referenced against all 27 sources in the **Clause Docs** notebook (`ADR 0001`–`0013`, `TASK.md`, `README.md`, and session transcripts).

---

## 1. Executive Summary

* **Core Stage 0/1/2 Hermetic Substrate (`cx.bat`, `cx.ps1`, `cx.sh`, `config/env/*.toml`, `MISE_ENV="paths,ai,cloud"`, `plugins/cx-*`, `installer_scoop.ps1`):** **Strong & Production-Grade.** The 8-pass symbol expansion TOML SSOT compiler, host hygiene redlines, in-place sterilized Scoop (`# clause-scoop-patches: 1` + `HKCU\Environment\Path` snapshot/restore), confined Brew, and all six hardware-aware Lua toolchains accurately implement `ADR 0001`–`0005`.
* **Curriculum & Portal Specifications (`docs/ccefs/00`–`04`):** **Aligned.** The 5-document sequential `00` $\rightarrow$ `04` CCEFS suite cleanly captures the Seax-first architecture, 4-Track Vieo.ai portal, Quad synthesis model, 27-package Illuminate mapping, and `ADR 0007`–`0013`.
* **Critical Drift & Bugs Found in the Bundle:** **7 concrete internal defects** were identified where legacy pre-TOML files, copy-paste errors, or outdated test assertions remain in the tracked bundle and will cause runtime or CI failures if not patched.

---

## 2. Critical Internal Findings (Code, Configs, Tests & ADRs)

### **Finding 1 (CRITICAL — Runtime Break): `scripts/cli/nu/config/env.nu` Still Reads Retired `.env` & Legacy Variables**

* **Location:** `scripts/cli/nu/config/env.nu` (Lines 12–109)
* **Issue:** In Phase 9 (`900356ce`, `ADR 0004` Addendum), ClauseOS retired root `.env` / `env.ps1` / `env.sh` in favor of `config/env/*.toml` compiled by `cx.ps1` and `cx.sh`. However, `env.nu` still attempts to parse `.env` and unconditionally indexes `$env.WIN_LOCALAPPDATA`, `$env.WIN_APPDATA`, `$env.WIN_CLAUSE_BIN_DIR`, `$env.POSIX_CLAUSE_BIN_DIR`, `$env.POSIX_CLAUSE_LOGS_DIR`, etc.
* **Impact:** When `cx.ps1` or `cx.sh` hands off to Nushell (`nu --env-config scripts/cli/nu/config/env.nu`), none of those `WIN_*` or `POSIX_*` keys exist in `config/env/*.toml`, causing Nushell startup errors (`column 'WIN_LOCALAPPDATA' cannot be found`).
* **Fix:** Refactor `env.nu` to trust the canonical `CLAUSE_*`, `HOME`, `USERPROFILE`, `LOCALAPPDATA`/`APPDATA`, and `XDG_*` variables already exported by `cx.ps1` / `cx.sh` (with fallback defaults only if invoked standalone outside `cx`), and preserve the two-pass `;` / `:` PATH canonicalization and `ssh` proxy wrapper.

### **Finding 2 (CRITICAL — ADR Corruption): `docs/adr/adr_006-micro-instance-virtualization.md` Is a Duplicate of `ADR 005`**

* **Location:** `docs/adr/adr_006-micro-instance-virtualization.md` (Lines 1–33)
* **Issue:** The file content is an exact copy-paste duplicate of `ADR 005: Unified Model Storage & Ecosystem Cache Projection` instead of the `cx vm` (WSL2 / Lima) specification recorded in the notebook (`ADR 0006`).
* **Impact:** Breaks ground-truth ADR traceability (`ADR 0008` closed-world `.ground` invariant) and loses the `WSL2` (`ext4.vhdx` in `.home/AppData/Local/Programs/vms/`) and `Lima` (`$LIMA_HOME` in `.home/.local/share/vms/`) contract.
* **Fix:** Restore `docs/adr/adr_006-micro-instance-virtualization.md` from the notebook's `ADR 006` specification (and note the Multipass vs. WSL2/Lima evaluation from the session transcript).

### **Finding 3 (HIGH — Disabled CI Gate): `.github/workflows/ci.yml` Has `cx test` Commented Out**

* **Location:** `.github/workflows/ci.yml` (Lines 74, 84)
* **Issue:** Both `# ./cx.sh test` and `# .\cx.ps1 test` are commented out in CI.
* **Impact:** CI currently verifies that `cx.sh` / `cx.ps1` exits `0` on `clause boot:check`, but **never executes** `tests/system/run_all.nu` (`test_stage0.nu`, `test_stage1.nu`, `test_hermeticity.nu`).
* **Fix:** Uncomment `./cx.sh test` and `.\cx.ps1 test` in `.github/workflows/ci.yml` once `test_stage1.nu` (Finding 4) is updated.

### **Finding 4 (HIGH — Stale Test Paths): `tests/system/test_stage1.nu` Asserts Pre-Mise `apps/` Paths**

* **Location:** `tests/system/test_stage1.nu` (Lines 19–48)
* **Issue:** `test_stage1.nu` checks `$CLAUSE_APPS_DIR/{lemonade,fastflowlm,apm,vscode,pulumi}`. Since Phase 9 (`ADR 0002` Addendum), all six plugins and tools (`lemonade`, `fastflowlm`, `inferssd`, `unsloth`, `comfyui`, `code`, `apm`, `pulumi`) install into `$MISE_INSTALLS_DIR/<tool>/<version>/` rather than `$CLAUSE_APPS_DIR`.
* **Impact:** Running `cx test` fails immediately on Stage 1 assertions even when all tools are healthy.
* **Fix:** Update `test_stage1.nu` to probe `$env.MISE_INSTALLS_DIR` (or `mise where <tool>`) across active `MISE_ENV` overlays (`ai`, `cloud`), including `inferssd` and portable VS Code `data/` directory checks.

### **Finding 5 (HIGH — Syntax/Citation Artifacts): `tests/env/test_env.nu` & `test_env.sh` Contain Literal `` Markers & Dead Paths**

* **Location:** `tests/env/test_env.nu` (Lines 13–34), `tests/env/test_env.sh` (Lines 10–25), `tests/env/test_env.ps1` (Line 25), `tests/env/run_tests.nu` (empty), `tests/env/run_test.sh` (empty)
* **Issue:**
  1. `test_env.nu` and `test_env.sh` contain literal `` paste strings that break Nushell and POSIX `sh` execution.
  2. `test_env.ps1` and `test_env.sh` source deleted files (`scripts/cli/pwsh/config/env.ps1` and `scripts/cli/sh/config/env.sh`).
  3. `tests/env/run_tests.nu` and `tests/env/run_test.sh` are 0-byte empty files.
* **Fix:** Clean the citation artifacts and update `tests/env/*` to test `cx.ps1` / `cx.sh` TOML environment compilation directly, or consolidate them into `tests/system/test_stage0.nu`.

### **Finding 6 (MEDIUM — Nested Subshell Guard): `cx.sh` Missing `_CALLER_CLAUSE_STATUS` Preservation**

* **Location:** `cx.sh` (Lines 16–20, 179–185, 376)
* **Issue:** `cx.ps1` saves `$CallerClauseStatus = $env:CLAUSE_STATUS`, verifies `$CallerMiseDataDir` is inside `$ClauseHomeNorm`, and sets `$env:CLAUSE_STATUS = "online"` before Stage 3 so nested `cx` invocations (like `cx pkg:add` calling `nu mod.nu`) skip redundant host-manager redlines. `cx.sh` lacks `_CALLER_CLAUSE_STATUS` handling and never exports `CLAUSE_STATUS="online"`.
* **Fix:** Mirror `cx.ps1`'s `_CALLER_CLAUSE_STATUS` save/verify/export logic in `cx.sh`.

### **Finding 7 (MEDIUM — Incomplete `ADR 0005` / `TASK.md` Deliverable): `plugins/cx-comfyui/hooks/post_install.lua` Missing `extra_model_paths.yaml` Generation**

* **Location:** `plugins/cx-comfyui/hooks/post_install.lua` (Lines 350–380)
* **Issue:** `ADR 0005` and `TASK.md` (Phase 10) require ComfyUI's `PostInstall` hook to generate `extra_model_paths.yaml` inside `source_dir` pointing `base_path` to `$HF_HOME` (`$HF_HUB_CACHE` = `$HF_HOME/hub`) so ComfyUI and Unsloth share model weights with zero duplication. Currently, `post_install.lua` generates the CLI shims without writing `extra_model_paths.yaml`.
* **Fix:** Add `extra_model_paths.yaml` generation in `plugins/cx-comfyui/hooks/post_install.lua` reading `os.getenv("HF_HOME")` (with fallback to `CLAUSE_CACHE_DIR .. "/huggingface"`).

---

## 3. Secondary Hygiene & Alignment Notes (Bundle vs. Notebook)

1. **ADR Filename Slug Mismatch (`docs/adr/` vs. `README.md` / `TASK.md`):**
   * On disk, ADRs 001–005 use underscores (`adr_001_hermetic_state_confinement...md`), ADRs 006–013 use hyphens (`adr_006-micro-instance-virtualization.md`), while `README.md` and `TASK.md` link to `docs/adr/0001-hermetic-state-confinement...md` (no `adr_` prefix). Standardizing all 13 filenames to `0001-<slug>.md` through `0013-<slug>.md` will fix every broken Markdown link.
2. **Unified `$HF_HOME` Path Evolution (`ADR 0005` vs. `config/env/40-ml-hub.toml`):**
   * Early notebook transcripts (`10/28/26`) placed `HF_HOME` at `.home/.local/share/models`, which was later standardized in Phase 9 (`40-ml-hub.toml`) to `HF_HOME = "${CLAUSE_CACHE_DIR}/huggingface"` (`HF_HUB_CACHE = "${HF_HOME}/hub"`, `HF_ASSETS_CACHE = "${HF_HOME}/assets"`). Update `docs/adr/0005-unified-model-storage-hub.md` to match `40-ml-hub.toml`.
3. **Unimplemented Roadmap Files Referenced in `README.md` & `TASK.md`:**
   * `compiler/seaxc/`, `services/orchestrator/`, `packages/carrier_jet/`, `packages/clause_cli/`, `tools/ring/`, `ops/config/{nomad,consul,vault}.hcl`, `scripts/cli/nu/commands/{identity,vm,infra}.nu`, `llms.txt` (0 bytes), `mkdocs.yml` (0 bytes), and `apm.yml` (0 bytes) are documented as active `v0.9.0-dev.1` roadmap targets in `TASK.md` (Phases 10–14) and mapped cleanly to `docs/ccefs/01-ccefs-30-modules-v4.3.md`.
4. **Plugin Metadata URLs (`plugins/cx-*/metadata.lua`):**
   * `metadata.lua` still lists `homepage = "https://github.com/vieo-ai/mise-comfyui"` (and `mise-inferssd`, `mise-lemonade`, `mise-unsloth`, `mise-vscode`, `mise-fastflowlm`) while `.mise.ai.toml` and `TASK.md` standardized the org repos to `https://github.com/vieo-ai/cx-*`.
5. **Doc Typo in `docs/README.md`, `site/README.md`, `projects/README.md`, `scripts/README.md`:**
   * Several early READMEs still reference `clause.ps1`, `/clause/projects`, `just docs-build`, and `scripts/console/nu/` instead of `cx.ps1`, `.home/`, `cx`, and `scripts/cli/nu/`.

---

## 4. Recommended Immediate Remediation Order

1. **Patch `docs/adr/adr_006-micro-instance-virtualization.md`** (restore true `cx vm` ADR content) and update `ADR 005` to match `40-ml-hub.toml`.
2. **Patch `scripts/cli/nu/config/env.nu` and `cx.sh`** so Nushell startup and nested POSIX subshells rely 100% on `config/env/*.toml` and `CLAUSE_STATUS="online"`.
3. **Update `tests/system/test_stage1.nu`**, clean `tests/env/*`, and **re-enable `cx test` in `.github/workflows/ci.yml`**.
4. **Add `extra_model_paths.yaml` generation to `plugins/cx-comfyui/hooks/post_install.lua`** to close out Phase 10's Model Hub unification.
