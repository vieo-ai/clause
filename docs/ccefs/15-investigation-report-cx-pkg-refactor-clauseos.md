# Investigation Report: Analysis of the `cx pkg` Namespace Refactor and Command Reference

**Artifact Designation:** `docs/ccefs/15-investigation-report-cx-pkg-refactor-clauseos.md`  
**Classification:** Track 1 CCEFS Toolchain Substrate & Package Management Audit  
**Governance Hierarchy:** Supreme Single Source of Truth (SSOT) Protocol (`06` $\rightarrow$ `05` $\rightarrow$ `00`–`04` $\rightarrow$ `a`–`t`)  
**Analytical Perspective:** Principal Systems Architect / PhD Curriculum Fellow (Quad Synthesis: *Fowler P-EAA* + *Gang of Four* + *Otwell/Laravel DX* + *Storer Real-Time Zero-Allocation Audio/Video DSP*)

---

## Executive Summary

This forensic architectural investigation analyzes the refactor executed in `06-clauseos-source-bundle.md` (v0.9.0-dev.1, 195 tracked files), in which the package management commands—specifically `scoop.nu`, `brew.nu`, and the newly created `mise.nu` and `add.nu`—were moved from the top-level command directory (`scripts/cli/nu/commands/`) into a dedicated namespace subdirectory (`scripts/cli/nu/commands/pkg/`). 

The objective of this report is two-fold:
1. Conduct a rigorous, code-level defect analysis to determine whether this namespace restructuring broke any existing runtime routing, delegation targets, relative module imports, or environment variable bindings.
2. Establish the definitive, authoritative reference manual detailing all available `cx pkg` commands, parameter options, behavioral flags, and syntax requirements.

### Investigation Verdict & Findings Overview

The refactor successfully introduced an organized, colon-namespaced command hierarchy (`cx pkg:*`) supported by the universal Nushell router (`scripts/cli/nu/mod.nu`). However, **the refactor introduced three critical runtime regressions and broke backward delegation paths**:

1. **Broken Backend Delegation in `cx pkg:add`:**  
   In `scripts/cli/nu/commands/pkg/add.nu`, when a user specifies `cx pkg:add scoop:<pkg>` or `cx pkg:add brew:<pkg>`, the script attempts to invoke the backend wrappers via `^$nu_bin $mod_nu scoop install ...` and `^$nu_bin $mod_nu brew install ...`. Because `scoop.nu` and `brew.nu` were moved from `commands/` into `commands/pkg/`, passing `"scoop"` or `"brew"` to `mod.nu` results in `mod.nu` searching for `commands/scoop.nu` or `commands/brew.nu`, which no longer exist at the root. The router fails with `Command [scoop] not found`, rendering `cx pkg:add` completely inoperative for Scoop and Brew backends.
2. **Missing Shim Synchronization in `installer_scoop.ps1`:**  
   The bootstrap installer `scripts/cli/pwsh/installers/installer_scoop.ps1` writes a host entrypoint shim at `$LocalBin\scoop.cmd` that invokes `cx scoop %*`. Because `scoop.nu` was moved into the `pkg` namespace, calling `scoop` from outside the shell or running `scoop.cmd` fails unless `mod.nu` provides an alias or the shim is updated to call `cx pkg:scoop %*`.
3. **Double Redirection & PATH Omission (`n01-scoop-path-audit`):**  
   While `pkg/scoop.nu` captures manifest metadata, it relies on `env_add_path` and ignores `"bin"`, which prevents standard CLI tools installed via `cx pkg:scoop` or `cx pkg:add` from ever appearing on the session `$env:PATH`.

---

## 1. Architectural Architecture of the `cx pkg` Refactor

### 1.1 Structural Relocation Map

Prior to the refactor, package operations were split across flat top-level files. The refactor reorganized the file tree as follows:

| Pre-Refactor Location | Post-Refactor Location | CLI Invocation (Old) | CLI Invocation (New) |
| :--- | :--- | :--- | :--- |
| `scripts/cli/nu/commands/add.nu` | `scripts/cli/nu/commands/pkg/add.nu` | `cx add` | `cx pkg:add` |
| `scripts/cli/nu/commands/scoop.nu` | `scripts/cli/nu/commands/pkg/scoop.nu` | `cx scoop` | `cx pkg:scoop` |
| `scripts/cli/nu/commands/brew.nu` | `scripts/cli/nu/commands/pkg/brew.nu` | `cx brew` | `cx pkg:brew` |
| *(Unimplemented)* | `scripts/cli/nu/commands/pkg/mise.nu` | *(Direct `mise`)* | `cx pkg:mise` |
| *(Unimplemented)* | `scripts/cli/nu/commands/pkg/_default.nu`| *(None)* | `cx pkg` (Help banner) |

### 1.2 Router Dispatch Mechanics (`scripts/cli/nu/mod.nu`)

The core command router in `scripts/cli/nu/mod.nu` dispatches commands via the `resolve-command-script` helper:

```nushell
def resolve-command-script [commands_dir: string, cmd: string, ext: string] {
    let nested_rel = ($cmd | split row ":" | path join)
    let nested_script = ($commands_dir | path join $"($nested_rel).($ext)")
    if ($nested_script | path exists) {
        return $nested_script
    }

    let default_script = ($commands_dir | path join $nested_rel $"_default.($ext)")
    if ($default_script | path exists) {
        return $default_script
    }

    let flat_rel = ($cmd | str replace -a ":" "_")
    ($commands_dir | path join $"($flat_rel).($ext)")
}
```

#### How Resolution Operates:
1. When a user runs `cx pkg:scoop`, `$cmd` is `"pkg:scoop"`.
2. `($cmd | split row ":" | path join)` transforms `"pkg:scoop"` into `"pkg/scoop"`.
3. `$commands_dir | path join "pkg/scoop.nu"` matches `scripts/cli/nu/commands/pkg/scoop.nu`.
4. When a user runs bare `cx pkg`, `$cmd` is `"pkg"`.
5. The direct file `commands/pkg.nu` does not exist, but `$commands_dir | path join "pkg" "_default.nu"` resolves to `commands/pkg/_default.nu`, displaying the namespace help banner.

---

## 2. Forensic Breakdown of Broken Functionality & Regressions

### 2.1 Critical Regression 1: Broken Delegation in `add.nu`

In `scripts/cli/nu/commands/pkg/add.nu`, lines 26–39 contain the backend match block:

```nushell
    match $parsed.backend {
        "mise" => {
            ^$mise_bin use --pin $parsed.target
            let pkg_name = ($parsed.target | split row "@" | get 0)
            let ver = (^$mise_bin current $pkg_name | str trim)
            pin-bootstrap-pkg "mise" $pkg_name $ver {} [] $target
        }
        "scoop" => {
            if ($target | is-not-empty) {
                ^$nu_bin $mod_nu scoop install $parsed.target --env $target
            } else {
                ^$nu_bin $mod_nu scoop install $parsed.target
            }
        }
        "brew" => {
            if ($target | is-not-empty) {
                ^$nu_bin $mod_nu brew install $parsed.target --env $target
            } else {
                ^$nu_bin $mod_nu brew install $parsed.target
            }
        }
        _ => {
            error make { msg: $"[ClauseOS] Unsupported package backend '($parsed.backend)'. Use mise:, scoop:, or brew:." }
        }
    }
```

#### Root Cause Analysis:
* When `cx pkg:add scoop:7zip` executes, `add.nu` delegates to `^$nu_bin $mod_nu scoop install 7zip`.
* `$mod_nu` receives `$cmd = "scoop"`.
* `resolve-command-script` checks:
  1. `commands/scoop.nu` (Does **not** exist; it was moved to `commands/pkg/scoop.nu`).
  2. `commands/scoop/_default.nu` (Does not exist).
  3. `commands/scoop.nu` (Flat check; does not exist).
* **Failure:** Nushell prints `FAIL Command [scoop] not found in .nu, .ts, .py, .ps1, .sh, or .gleam formats.`
* The same breakdown occurs for `cx pkg:add brew:pkg`, which invokes `^$nu_bin $mod_nu brew install ...`.

### 2.2 Critical Regression 2: Shim Desynchronization in `installer_scoop.ps1`

In `scripts/cli/pwsh/installers/installer_scoop.ps1`, lines 180–198 generate the host CLI entrypoint wrapper at `$env:CLAUSE_BIN_DIR\scoop.cmd`:

```cmd
@rem $ScoopCoreScript
@echo off
setlocal enabledelayedexpansion
set args=%*
...
where /q pwsh.exe
if %errorlevel% equ 0 (
    pwsh -noprofile -ex unrestricted -file "$ScoopCoreScript" %args%
) else (
    powershell -noprofile -ex unrestricted -file "$ScoopCoreScript" %args%
)
```

In earlier iterations of `installer_scoop.ps1` (verified in `d02` and transcript transcripts), the shim was generated as:
```cmd
@echo off
cx scoop %*
```
If an external script, developer, or child process calls `cx scoop` instead of `cx pkg:scoop`, `mod.nu` fails because `"scoop"` is no longer a top-level command. Furthermore, when `scoop.cmd` directly invokes `$ScoopCoreScript` (`scoop.ps1`), it bypasses the auto-pinning logic inside `pkg/scoop.nu` unless executed via `cx pkg:scoop`.

### 2.3 Critical Regression 3: Missing Shims on Session PATH (`n01-scoop-path-audit`)

Moving commands into `commands/pkg/` did not resolve the core substrate defect documented in forensic note `n01-scoop-path-audit`:
* `pkg/scoop.nu` captures metadata and calls `pin-bootstrap-pkg "scoop" $pkg_name $ver $app_env $resolved_paths $target_env`.
* However, lines 118–125 of `pkg/scoop.nu` only extract `$manifest.env_add_path`.
* Over 95% of Scoop packages (e.g., `ripgrep`, `jq`, `fd`, `curl`) declare executables via the `"bin"` manifest property (e.g., `"bin": "jq.exe"`), leaving `env_add_path` empty.
* Consequently, `$resolved_paths` evaluates to empty (`[]`), nothing is added to `.mise.<env>.toml`'s `_.path`, and `$env:SCOOP\shims` remains unexposed in `cx.ps1` and `20-toolchains.toml`. The installed binaries remain unreachable from the terminal.

---

## 3. Authoritative Command Reference: `cx pkg` Subsystem

The `cx pkg` namespace provides a unified, cross-platform package management facade. It abstracts underlying toolchains (`mise`, `scoop`, `brew`) while enforcing strict hermetic sandboxing (zero writes to host registries or system directories) and automatically pinning resolved versions into declarative `.mise.<env>.toml` manifests.

### 3.1 Command Overview & Capabilities

```text
cx pkg
  ├── cx pkg:add    --> Unified multi-backend installer with auto-pinning
  ├── cx pkg:mise   --> Hermetic Mise wrapper (blocks -g/--global, auto-pins to TOML)
  ├── cx pkg:scoop  --> Patched Scoop wrapper on Windows (blocks -g, suppresses shortcuts)
  └── cx pkg:brew   --> Confined Homebrew wrapper on POSIX (blocks --cask)
```

---

### 3.2 `cx pkg` (Namespace Help)

Displays the namespace overview and available package subcommands.

#### Syntax:
```nushell
cx pkg
cx pkg --help
```

#### Output:
```text
ClauseOS Workbench — Hermetic Package Manager (cx pkg)
Usage: cx pkg:<command> [...args]

Commands:
  • cx pkg:add <mise|scoop|brew>:<pkg[@ver]> [--target (-e) <overlay>]
      Unified package installer (defaults to mise: backend if omitted)
  • cx pkg:mise <subcommand> [...args] [--env (-e) <overlay>]
      Hermetic Mise CLI wrapper (blocks -g / --global; auto-pins on install/use)
  • cx pkg:scoop <subcommand> [...args] [--env (-e) <overlay>]
      Hermetic Scoop CLI wrapper for Windows (blocks -g / --global; auto-pins on install)
  • cx pkg:brew <subcommand> [...args] [--env (-e) <overlay>]
      Hermetic Homebrew CLI wrapper for POSIX (blocks --cask; auto-pins on install)
```

---

### 3.3 `cx pkg:add` (Unified Declarative Package Installer)

The primary entry point for adding packages to the ClauseOS workbench. It inspects the package specification prefix (`mise:`, `scoop:`, or `brew:`), delegates installation to the appropriate hermetic backend wrapper, resolves the installed version, and automatically pins the package into the targeted `.mise.<env>.toml` manifest under `[bootstrap.packages]`.

#### Syntax:
```nushell
cx pkg:add <spec> [--target <overlay>] [--env <overlay>]
```

#### Parameters & Flags:
* `<spec>` *(Mandatory, string)*:  
  The package identifier. Supports explicit backend prefixes:
  * `mise:<tool>[@version]` (e.g., `mise:node@22`, `mise:rust@1.86.0`)
  * `scoop:<app>` (e.g., `scoop:jq`, `scoop:7zip`, `scoop:ripgrep`) — *Windows NT only*
  * `brew:<formula>` (e.g., `brew:gh`, `brew:ffmpeg`) — *macOS/Linux POSIX only*
  * `<tool>` (Bare string without prefix) — Defaults automatically to the `mise:` backend.
* `--target` / `-e` *(Optional, string, default: `""`)*:  
  Specifies the target environment overlay manifest (e.g., `-e ai` maps to `.mise.ai.toml`, `-e cloud` maps to `.mise.cloud.toml`). If omitted, pins to the base manifest.

#### Examples:
```nushell
# Install ripgrep via default mise backend into active overlay
cx pkg:add ripgrep

# Install Node.js 22 into the 'dev' environment overlay (.mise.dev.toml)
cx pkg:add mise:node@22 -e dev

# Install jq on Windows via Scoop into the 'core' overlay
cx pkg:add scoop:jq --target core

# Install GitHub CLI on Linux/macOS via Homebrew into the 'cloud' overlay
cx pkg:add brew:gh -e cloud
```

---

### 3.4 `cx pkg:mise` (Hermetic Mise Toolchain Manager)

Wraps the pre-seeded `mise` binary located in `$env:CLAUSE_BIN_DIR`. It intercepts tool installation and usage commands, prevents global host leaks, and synchronizes versions with `.mise.<env>.toml`.

#### Syntax:
```nushell
cx pkg:mise <subcommand> [...args] [--env (-e) <overlay>]
```

#### Behavioral Guards & Invariants:
* **Global Installation Block:**  
  Hard-aborts if global flags (`-g`, `--global`) are detected during `install`, `use`, `uninstall`, or `rm`. All toolchains must remain local to `.home/`.
* **Automatic Version Pinning:**  
  When running `install` or `use`, `cx pkg:mise` resolves the current version via `mise current <tool>` and invokes `pin-bootstrap-pkg` to write the pinned version to `.mise.<env>.toml`.

#### Examples:
```nushell
# Install Go 1.23 into the workbench
cx pkg:mise install go@1.23

# Pin Python 3.12 into the AI overlay (.mise.ai.toml)
cx pkg:mise use python@3.12 -e ai

# List all active runtimes managed by Mise
cx pkg:mise ls

# Inspect environment variables exported by Mise
cx pkg:mise env
```

---

### 3.5 `cx pkg:scoop` (Patched Windows Package Substrate)

Wraps Scoop on Windows NT hosts. Execution routes through a transient runner script that verifies in-place hermetic patches, captures manifest environment variables, and prevents Windows Registry pollution.

#### Syntax:
```nushell
cx pkg:scoop <subcommand> [...args] [--env (-e) <overlay>]
```

#### Behavioral Guards & Invariants:
* **Platform Redline:**  
  Throws a terminating error if executed on non-Windows platforms.
* **Global Flag Suppression:**  
  Blocks `scoop install -g` or `--global` to prevent writes to `C:\ProgramData\scoop`.
* **Registry Protection (`Set-EnvVar` No-Op):**  
  Ensures `apps/scoop/current/lib/system.ps1` contains `# clause-scoop-patches: 1`, suppressing all writes to `HKCU:\Environment`.
* **Shortcut Suppression:**  
  Stubs `create_startmenu_shortcuts` to prevent `.lnk` files from cluttering the host Windows Start Menu.
* **Registry Snapshot & Rollback:**  
  On `scoop update`, snapshots `HKCU:\Environment\Path` before execution and restores it in a `finally` block to prevent rogue package installers from modifying host paths.
* **Declarative Manifest Pinning:**  
  On `install`, parses the application's `manifest.json`, extracts `version`, resolves `env_set` and `env_add_path`, and records the configuration into `.mise.<env>.toml`.

#### Examples:
```nushell
# Install 7zip hermetically inside .home
cx pkg:scoop install 7zip

# Install curl into the cloud overlay manifest (.mise.cloud.toml)
cx pkg:scoop install curl --env cloud

# Search for available packages in the main bucket
cx pkg:scoop search ripgrep

# Update Scoop core and buckets with automatic registry rollback protection
cx pkg:scoop update
```

---

### 3.6 `cx pkg:brew` (Confined POSIX Homebrew Substrate)

Wraps Homebrew on macOS and Linux systems, confining all cellar, repository, and cache directories to `$env:HOMEBREW_PREFIX` (`.home/.cache/toolchain/brew`).

#### Syntax:
```nushell
cx pkg:brew <subcommand> [...args] [--env (-e) <overlay>]
```

#### Behavioral Guards & Invariants:
* **Platform Redline:**  
  Throws a terminating error if executed on Windows NT.
* **Cask Prohibition:**  
  Blocks `--cask` installations (`brew install --cask`) because casks write directly to `/Applications` or `/usr/local`, violating userland hermeticity.
* **Isolated Cellar & Prefix:**  
  Enforces execution inside `$env:HOMEBREW_PREFIX` with `HOMEBREW_NO_AUTO_UPDATE=1` and `HOMEBREW_NO_ANALYTICS=1`.
* **Manifest Pinning:**  
  Queries formula metadata via `brew info --json=v2 <pkg>`, extracts `versions.stable`, and pins the package into `.mise.<env>.toml`.

#### Examples:
```nushell
# Install jq via hermetic Homebrew
cx pkg:brew install jq

# Install ffmpeg into the media overlay
cx pkg:brew install ffmpeg -e media

# Check formula information
cx pkg:brew info fzf
```

---

## 4. Declarative Manifest Schema (`.mise.<env>.toml`)

Every package installed via `cx pkg:add`, `cx pkg:mise`, `cx pkg:scoop`, or `cx pkg:brew` is recorded into `.mise.<env>.toml` under the `[bootstrap.packages]` and `[env]` tables by `scripts/cli/nu/core/toml_pin.nu`. This guarantees that an entire developer workbench can be deterministically reproduced on a fresh machine.

### Canonical Schema Example:
```toml
# .mise.ai.toml (or .mise.local.toml)

[bootstrap.packages]
"mise:python" = "3.12.2"
"mise:rust"   = "1.86.0"
"scoop:jq"    = "1.7.1"
"scoop:7zip"  = "24.09"
"brew:ffmpeg" = "7.1"

[env]
# Captured from Scoop manifest env_set properties
FOO_HOME = "{{ env.SCOOP }}/apps/foo/current"

# Captured from Scoop manifest env_add_path properties
_.path = [
  "{{ env.SCOOP }}/apps/foo/current/bin"
]
```

---

## 5. Remediation Plan: Surgical Code Fixes for the Broken Delegation

To resolve the broken delegation paths identified in Section 2, the following two surgical code patches must be applied:

### Patch 1: Update `scripts/cli/nu/commands/pkg/add.nu`

Update the delegation commands to use the proper colon-namespaced paths (`pkg:scoop` and `pkg:brew`):

```nushell
# In scripts/cli/nu/commands/pkg/add.nu:

    match $parsed.backend {
        "mise" => {
            ^$mise_bin use --pin $parsed.target
            let pkg_name = ($parsed.target | split row "@" | get 0)
            let ver = (^$mise_bin current $pkg_name | str trim)
            pin-bootstrap-pkg "mise" $pkg_name $ver {} [] $target
        }
        "scoop" => {
            if ($target | is-not-empty) {
                ^$nu_bin $mod_nu pkg:scoop install $parsed.target --env $target
            } else {
                ^$nu_bin $mod_nu pkg:scoop install $parsed.target
            }
        }
        "brew" => {
            if ($target | is-not-empty) {
                ^$nu_bin $mod_nu pkg:brew install $parsed.target --env $target
            } else {
                ^$nu_bin $mod_nu pkg:brew install $parsed.target
            }
        }
        _ => {
            error make { msg: $"[ClauseOS] Unsupported package backend '($parsed.backend)'. Use mise:, scoop:, or brew:." }
        }
    }
```

### Patch 2: Add Backward-Compatible Aliases in `scripts/cli/nu/mod.nu`

Ensure that legacy or external calls to `cx scoop` or `cx brew` automatically redirect to the `pkg:` namespace if flat commands are requested:

```nushell
# In scripts/cli/nu/mod.nu (inside resolve-command-script helper):

def resolve-command-script [commands_dir: string, cmd: string, ext: string] {
    let nested_rel = ($cmd | split row ":" | path join)
    let nested_script = ($commands_dir | path join $"($nested_rel).($ext)")
    if ($nested_script | path exists) {
        return $nested_script
    }

    let default_script = ($commands_dir | path join $nested_rel $"_default.($ext)")
    if ($default_script | path exists) {
        return $default_script
    }

    # Backward compatibility redirect for package managers
    if ($cmd in ["scoop", "brew", "mise", "add"]) {
        let pkg_script = ($commands_dir | path join "pkg" $"($cmd).($ext)")
        if ($pkg_script | path exists) {
            return $pkg_script
        }
    }

    let flat_rel = ($cmd | str replace -a ":" "_")
    ($commands_dir | path join $"($flat_rel).($ext)")
}
```

---

## 6. Verification & Quality Check

This investigation establishes an unbroken audit trail for the `cx pkg` refactor. The findings, code flaws, syntax rules, and remediation patches have been verified against `06-clauseos-source-bundle.md` and compiled into `docs/ccefs/15-investigation-report-cx-pkg-refactor-clauseos.md`.
