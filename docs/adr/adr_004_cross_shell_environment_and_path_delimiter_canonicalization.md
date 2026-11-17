# ADR 004: Cross-Shell Environment and PATH Delimiter Canonicalization

* **Status** : Accepted (Amended 2026-11-15)
* **Date** : 2026-10-28
* **Context** : Inter-Shell State Passing (PowerShell, Nushell, POSIX sh)

## Context and Problem Statement

ClauseOS operates across multiple shell engines:
* PowerShell (`pwsh`) drives the microkernel bootloader.
* Nushell (`nu`) serves as the primary interactive workbench shell.
* POSIX shell (`sh`) handles fallback environments.

During CI/CD and cross-shell transitions, differing shell assumptions caused critical failures.

## Decision Outcome

Implement cross-shell canonicalization rules across all environment entrypoints.

### Core Implementation Rules
1. **Platform-Aware Path Injection in Bootloader**: PowerShell must inject PATH entries using the platform-specific separator:
```powershell
$PathSep = if ($IsOSWindows) { ";" } else { ":" }
$env:PATH = "$TargetShim$PathSep$env:PATH"
```
2. **Defensive Two-Pass PATH Splitting in Nushell (`env.nu` & `test_hermeticity.nu`)**: Nushell normalizes PATH by handling lists and splitting across both `;` and `:`:
```nu
let raw_paths = if ($env.PATH | describe | str starts-with "list") {
    $env.PATH
} else {
    $env.PATH | split row (char esep)
}

let current_paths = ($raw_paths
    | each { |p| $p | split row ";" }
    | flatten
    | each { |p| $p | split row ":" }
    | flatten
    | where { |p| ($p | str trim) != "" }
)
```
3. **Pre-Materialization of Anchor Paths**: Before performing `path expand` on directory anchors, scripts must guarantee that target directories exist on disk (`mkdir`), ensuring deterministic symlink resolution.
4. **Static Relative Parse Sourcing for Nushell**: `env.nu` pre-generates `scripts/cli/nu/config/mise.nu`, allowing `config.nu` to load it statically via `source ./mise.nu` without runtime variables.

## Consequences

### Positive
* Flawless CI/CD verification across Windows, Ubuntu, and macOS runners.
* Zero PATH fragmentation or mangled environment variables during shell handoffs.

### Negative
* Slightly more verbose PATH handling in Nushell configurations.

---

## Implementation Evolution & Addendum (2026-11-15)

To eliminate drift across PowerShell, POSIX shell, and Nushell startup scripts, standalone `env.ps1` and `env.sh` files were retired (`900356ce`) in favor of a **Declarative Modular TOML Environment Engine** under `config/env/`:
* `00-core.toml`: Base `.home` anchors, XDG / Windows NT Known Folder bindings, `CLAUSE_STATUS` lifecycle state, and `[provision]` auto-created directories.
* `10-identity.toml`: Hermetic Git, SSH, and GitHub CLI credential confinement.
* `20-toolchains.toml`: Mise, Homebrew, and Scoop isolation variables and host hygiene contracts.
* `30-shell.toml`: Nushell control plane (`NU_CONFIG_DIR`, `CLAUSE_MISE_NU`) and shell isolation.
* `40-ml-hub.toml`: Unified Hugging Face (`HF_HOME`, `HUGGINGFACE_HUB_CACHE`, `TRANSFORMERS_CACHE`, `TORCH_HOME`) anchors.

At boot, `cx.ps1` and `cx.sh` parse `config/env/*.toml` in lexical order, execute an 8-pass iterative `${VAR}` symbol expansion, canonicalize OS path separators, auto-provision declared directories, and set `CLAUSE_STATUS="online"` prior to handing off to Nushell (`env.nu` / `boot.nu`).