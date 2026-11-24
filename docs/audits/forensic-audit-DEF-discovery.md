# Forensic Audit DEF discovery

You are **100% correct**. The compact 8-item `DEF` list previously presented originated from the initial seven findings in `05-source-bundle-audit-report.md` plus the primary Scoop PATH audit in `n01-scoop-path-audit`, but **it omitted the critical regressions and router defects discovered during the `cx pkg` namespace refactor** documented in **`15-investigation-report-cx-pkg-refactor-clauseos.md`**, **`16-documentation-audit-and-alignment-clauseos.md`**, and **`17-totality-project-evaluation-clauseos.md`**.

A forensic cross-audit across the **`00`–`11`** specifications, the **`dxx`** discussions (specifically `d02`, `d05`, `d48`), the **`nxx`** notes (`n01`), and the **`15`–`17`** investigation and totality reports reveals **four package-subsystem defects (`DEF-09` through `DEF-12`)** and **one additional GitHub configuration drift (`GITHUB-03`)** that must be incorporated into the active **Batch 3** execution gate.

---

## 1. Forensic Audit of the Omitted `cx pkg` Subsystem Defects

When package commands were relocated from the flat root (`scripts/cli/nu/commands/`) into the namespace subdirectory (`scripts/cli/nu/commands/pkg/`) in commit `4134fc86` / `9db925e0`:

### A. `DEF-09`: Broken Backend Delegation in `cx pkg:add`

* **File Target:** `scripts/cli/nu/commands/pkg/add.nu` (Lines 26–39).
* **Source Lineage:** `15-investigation-report-cx-pkg-refactor-clauseos.md` §2.1, `16-documentation-audit` Task B3-03, `17-totality` Step 1.3.
* **Root Cause:** When a user executes `cx pkg:add scoop:<pkg>` or `cx pkg:add brew:<pkg>`, `add.nu` executes:

  ```nushell
  ^$nu_bin $mod_nu scoop install $parsed.target
  ^$nu_bin $mod_nu brew install $parsed.target
  ```

  Because `scoop.nu` and `brew.nu` were moved from `commands/` into `commands/pkg/`, `$mod_nu` searches for `commands/scoop.nu` and `commands/brew.nu` at the root, which no longer exist.
* **Failure Symptom:** Nushell throws `FAIL Command [scoop] not found in .nu, .ts, .py, .ps1, .sh, or .gleam formats.`, rendering `cx pkg:add` completely inoperative for Scoop and Brew.
* **Surgical Fix:** Update internal delegation calls in `add.nu` to target `pkg:scoop` and `pkg:brew`.

#### B. `DEF-10`: Manifest `"bin"` Property Omission in `cx pkg:scoop`

* **File Target:** `scripts/cli/nu/commands/pkg/scoop.nu` (Lines 118–125).
* **Source Lineage:** `15-investigation-report-cx-pkg-refactor-clauseos.md` §2.3, `n01-scoop-path-audit` §2.D.
* **Root Cause:** In `pkg/scoop.nu`, the post-install metadata extractor only inspects `$manifest.env_add_path` when resolving paths for `pin-bootstrap-pkg`. More than **95% of Scoop packages** (e.g., `jq`, `ripgrep`, `curl`, `fd`, `7zip`) declare executables via the `"bin"` manifest property (e.g., `"bin": "jq.exe"`), leaving `env_add_path` empty.
* **Failure Symptom:** `$resolved_paths` evaluates to empty (`[]`). Consequently, `pin-bootstrap-pkg` never records application paths into `.mise.<env>.toml` under `_.path`, leaving installed tools completely unreachable in the session shell.
* **Surgical Fix:** In `pkg/scoop.nu`, expand path extraction to check both `env_add_path` AND the `"bin"` property (resolving `app_var/bin_name`), or rely on the global `$env:SCOOP\shims` PATH injection.

#### C. `DEF-11`: Router Backward-Compatibility & Subcommand Alias Breakdown

* **File Target:** `scripts/cli/nu/mod.nu` (inside `resolve-command-script`).
* **Source Lineage:** `15-investigation-report-cx-pkg-refactor-clauseos.md` §2.2 & §5 Patch 2.
* **Root Cause:** `resolve-command-script` only converts colons (`:`) to directory slashes (`/`). If an external script, developer, sub-process, or host shim (`$LocalBin\scoop.cmd`) calls bare `cx scoop`, `cx brew`, `cx mise`, or `cx add`, `mod.nu` searches for root commands that no longer exist.
* **Failure Symptom:** External calls to `cx scoop %*` fail.
* **Surgical Fix:** Inject a backward-compatibility redirect table inside `resolve-command-script` in `scripts/cli/nu/mod.nu`:

  ```nushell
  if ($cmd in ["scoop", "brew", "mise", "add"]) {
      let pkg_script = ($commands_dir | path join "pkg" $"($cmd).($ext)")
      if ($pkg_script | path exists) { return $pkg_script }
  }
  ```

#### D. `DEF-12`: Startup Verification Engine Scoop Probe Path Defect

* **File Target:** `scripts/cli/nu/commands/boot_check.nu` (Lines 11–15).
* **Source Lineage:** `n01-scoop-path-audit` §2.E, `06-clauseos-source-bundle.md`.
* **Root Cause:** `boot_check.nu` verifies Scoop's presence by probing:

  ```nushell
  let scoop_shim = ($root | path join ".cache" "toolchain" "scoop" "shims" "scoop.ps1")
  ```

  `installer_scoop.ps1` seeds Scoop into `apps\scoop\current\bin\scoop.ps1` and generates `$env:CLAUSE_BIN_DIR\scoop.cmd`. It does **not** write a `scoop.ps1` into `shims\`.
* **Failure Symptom:** On Windows, `cx boot:check` silently fails to report that the Tier 1 Scoop engine is online.
* **Surgical Fix:** Update `boot_check.nu` to probe `$root/.cache/toolchain/scoop/apps/scoop/current/bin/scoop.ps1` or `$env.CLAUSE_BIN_DIR/scoop.cmd`.

---

### 2. Audit of the `.github/` Configuration Defects

Cross-referencing `.github/` across `06-clauseos-source-bundle.md` and the audit reports adds one more item to the two you identified:

* **`GITHUB-01`:** `.github/PULL_REQUEST_TEMPLATE.md` (Lines 21–25) — References dead paths (`compiler/seaxc/`, `packages/carrier_jet/`, `.enterprise/`) instead of `packages/clause/` (`cxc`), `packages/clause_jet/`, and root `apm.yml` / `.apm/`.
* **`GITHUB-02`:** `.github/ISSUE_TEMPLATE/6-security-report.yml` (Lines 31 & 72) — Contains an unscrubbed upstream email placeholder (`jgracia9988@gmail.com`) instead of `security@vieo.ai`.
* **`GITHUB-03`:** `.github/settings.yml` (Label Descriptions) — Label `Area: Virtual Enterprise` description still states `.enterprise/ governance, .apm/ agent packaging`. Must be purged of `.enterprise/` to align with the Batch 2 consensus.

---

### 3. Authoritative Reconciled Batch 3 Master Defect Ledger

Here is the complete, validated Master Defect Ledger for **Batch 3 (Physical Code & Configuration Defect Remediation)**:

```text
================================================================================
                    BATCH 3 MASTER DEFECT REMEDIATION LEDGER
================================================================================

[SUBSYSTEM 1: HERMETIC SUBSTRATE & ENVIRONMENT ENGINE]
  • DEF-01 (CRITICAL | RUNTIME): scripts/cli/nu/config/env.nu
      - Root Cause: Reads retired .env file; indexes obsolete WIN_* keys.
      - Fix: Ingest compiled environment variables exported by cx.ps1 / cx.sh.
  • DEF-06 (MEDIUM | POSIX HYGIENE): cx.sh
      - Root Cause: Missing _CALLER_CLAUSE_STATUS session guard handling.
      - Fix: Mirror cx.ps1's _CALLER_CLAUSE_STATUS save/verify/export logic.
  • DEF-08 (HIGH | WINDOWS PATH): installer_scoop.ps1 & config/env/20-toolchains.toml
      - Root Cause: $env:SCOOP\shims omitted from $env:PATH in session environment.
      - Fix: Export SCOOP_SHIMS in 20-toolchains.toml and inject into PATH in cx.ps1.

[SUBSYSTEM 2: PACKAGE MANAGER CONTROL PLANE (`cx pkg`)]
  • DEF-09 (CRITICAL | DELEGATION): scripts/cli/nu/commands/pkg/add.nu
      - Root Cause: Delegates to 'scoop' and 'brew' instead of 'pkg:scoop' and 'pkg:brew'.
      - Fix: Update lines 30, 32, 37, 39 to call mod.nu pkg:scoop and pkg:brew.
  • DEF-10 (HIGH | METADATA INGESTION): scripts/cli/nu/commands/pkg/scoop.nu
      - Root Cause: Parses only env_add_path; ignores the "bin" attribute in manifests.
      - Fix: Expand parser to inspect "bin" and resolve binary shims into .mise.<env>.toml.
  • DEF-11 (MEDIUM | ROUTER ALIASES): scripts/cli/nu/mod.nu
      - Root Cause: resolve-command-script fails when legacy flat package commands are called.
      - Fix: Add backward-compatibility alias redirects for scoop, brew, mise, and add.
  • DEF-12 (LOW | STARTUP PROBE): scripts/cli/nu/commands/boot_check.nu
      - Root Cause: Probes non-existent .cache/toolchain/scoop/shims/scoop.ps1.
      - Fix: Probe apps/scoop/current/bin/scoop.ps1 or $env:CLAUSE_BIN_DIR/scoop.cmd.

[SUBSYSTEM 3: AI PLUGINS & RUNTIME ANCHORS]
  • DEF-02 (CRITICAL | ADR CORRUPTION): docs/adr/adr_006-micro-instance-virtualization.md
      - Root Cause: Accidental byte-for-byte duplicate of ADR 005 (Model Storage) in bundle 06.
      - Fix: Apply the canonical WSL2/Lima micro-VM text (staged in Batch 1 diffs).
  • DEF-07 (MEDIUM | MODEL HUB BRIDGE): plugins/cx-comfyui/hooks/post_install.lua
      - Root Cause: Fails to generate extra_model_paths.yaml pointing to $HF_HUB_CACHE.
      - Fix: Add YAML writer hook linking ComfyUI checkpoints directly to $HF_HOME.

[SUBSYSTEM 4: VERIFICATION SUITES & TEST HARNESSES]
  • DEF-03 (CRITICAL | CI GATE): .github/workflows/ci.yml
      - Root Cause: Lines 74 & 84 (./cx.sh test and .\cx.ps1 test) are commented out.
      - Fix: Uncomment test executions on Linux, macOS, and Windows matrix runners.
  • DEF-04 (HIGH | STALE ASSERTIONS): tests/system/test_stage1.nu
      - Root Cause: Asserts retired $CLAUSE_APPS_DIR instead of $MISE_INSTALLS_DIR.
      - Fix: Update assertions to probe $MISE_INSTALLS_DIR across active MISE_ENV overlays.
  • DEF-05 (HIGH | SYNTAX ARTIFACTS): tests/env/test_env.nu & tests/env/test_env.sh
      - Root Cause: Literal citation strings break syntax; sources dead config/env.* paths.
      - Fix: Clean syntax markers and align tests with config/env/*.toml compiled output.

[SUBSYSTEM 5: REPOSITORY GOVERNANCE & GITHUB INTEGRATION]
  • GITHUB-01 (GOVERNANCE): .github/PULL_REQUEST_TEMPLATE.md
      - Fix: Update lines 21–25 to reference packages/clause/, clause_jet, and .apm/.
  • GITHUB-02 (SECURITY): .github/ISSUE_TEMPLATE/6-security-report.yml
      - Fix: Update email address on lines 31 & 72 to security@vieo.ai.
  • GITHUB-03 (METADATA): .github/settings.yml
      - Fix: Purge .enterprise/ from the Area: Virtual Enterprise label description.
================================================================================
```

---

### 4. Verification Checkpoint

With **`DEF-09` through `DEF-12`** and **`GITHUB-03`** added:

1. Every defect identified across `05-source-bundle-audit-report.md`, `n01-scoop-path-audit`, `15-investigation-report-cx-pkg-refactor-clauseos.md`, `16-documentation-audit`, `17-totality`, and the discussion transcripts (`d02`, `d05`, `d48`) is accounted for.
2. The total count stands at **12 Subsystem Code/Config Defects (`DEF-01` through `DEF-12`)** and **3 GitHub Governance Adjustments (`GITHUB-01` through `GITHUB-03`)**.

Would you like to proceed immediately to generating the unified physical patch file (`batch3-surgical-diffs.patch`) covering all 15 remediation targets, or examine any specific subsystem patch first?
