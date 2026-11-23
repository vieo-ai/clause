# Contributing to ClauseOS

Welcome to **ClauseOS** (`clause.os` / `cx`), the bare-metal hermetic operating substrate and carrier-class transmedia & AI orchestration platform stewarded by **Vieo** (`vieo-ai`). We appreciate your interest in contributing to our open-source ecosystem! This document outlines the operational discipline, testing gates, and contribution workflow for the repository.

## Code of Conduct

By participating in this project, you are expected to uphold our [Code of Conduct](CODE_OF_CONDUCT.md). Please review it to understand the standards expected of all contributors across issues, pull requests, and community channels.

## Ways to Contribute

There are many ways to contribute to ClauseOS and the broader Vieo stack:

- Reporting substrate bugs, path-leak edge cases, or cross-platform regressions (Windows NT, Linux, macOS)
- Building or hardening first-party runtime adapters in `plugins/cx-*` (Lua Mise adapters confined to `.home/`)
- Implementing polyglot CLI commands in `scripts/cli/{nu,ts,py,pwsh,posix}/commands/`
- Advancing the **Clause (`.cx`)** compiler (`clausec`), **TIGAH** runtime, or **CCEFS** curriculum modules (`docs/ccefs/`)
- Improving architectural documentation, ADRs (`docs/adr/`), and deterministic verification suites (`tests/`)

## Getting Started & Hermetic Workbench Setup

ClauseOS enforces a **zero-leak bare-metal sandbox (`.home/`)**. Never install dependencies globally onto your host OS or rely on host `$PATH` leakage.

1. Fork the repository (`vieo-ai/clause.os`) and clone your fork locally.
2. Enter the hermetic ClauseOS workbench using the Stage 0 microkernel bootloader for your platform:
   - **Windows:** `.\start.bat` or `.\start.ps1` (invokes `cx.ps1`)
   - **Linux / macOS:** `chmod +x start.sh && ./start.sh` (invokes `cx.sh`)
3. Stage 0 will automatically hydrate `.home/` (`.local/bin/`, `nu`, `mise`, overlays from `config/env/*.toml`, and `MISE_ENV="paths,ai,cloud"`) and drop you into the isolated Nushell workbench (`[ClauseOS]`).
4. Create a new branch for your contribution following the conventions below.
5. Make your changes adhering to our architectural standards (zero host-OS leakage, SSOT `config/env/*.toml` symbol expansion, and non-destructive spec editing).
6. Run the full verification suite locally before submitting a pull request.

## Branching Conventions

When creating a new branch for your contribution, please follow these naming conventions:

```text
docs/<description>
fix/<username>-<description>
feature/<username>-<description>
refactor/<username>-<description>
plugin/<username>-<plugin-name>
```

If the scope of the issue changes materially, open a new branch matching the updated scope.

## Local Testing & Verification Gates

All contributions must pass offline, deterministic verification inside the hermetic ClauseOS environment before pushing commits. Do not run tests against polluted host shells.

### Running the Systems & Environment Test Suites

You can invoke tests either **from outside** the workbench via the Stage 0 entrypoint or **from inside** the active Nushell workbench via the polyglot command router (`cx` / `clause`):

```nushell
# 1. Run the ClauseOS systems & hermeticity assertion suite (tests/system/run_all.nu)
clause test
# (Or from outside the workbench: .\start.bat test  |  ./start.sh test)

# 2. Run cross-shell environment invariant tests (PowerShell, Nushell, POSIX sh)
pwsh tests/env/run_tests.ps1
```

### Testing `plugins/cx-*` Adapters

When modifying or adding a first-party adapter under `plugins/cx-<name>/`:

1. Ensure all paths, caches, and model weights confine strictly to ClauseOS environment variables (`CLAUSE_ML_HUB_DIR`, `CLAUSE_CACHE_DIR`, `CLAUSE_TEMP_DIR`, etc.).
2. Run the adapter's self-contained verification task (`mise-tasks/test`) and push changes to its upstream subtree (`vieo-ai/cx-<name>`) via `cx plugin` so cross-OS GitHub Actions runners validate Windows, macOS, and Linux cleanly before pinning into `.mise.*.toml` overlays.

## Pull Request Requirements

- **Clear Intent:** Document the problem, architectural rationale, and affected subsystems (`cx.ps1`/`cx.sh`, `config/env/*.toml`, `scripts/cli/`, `plugins/cx-*`, `packages/*`, or `docs/`).
- **Automated Coverage:** All non-documentation pull requests must include automated assertions covering both expected behavior and failure/boundary cases (e.g., path isolation, nested session guards, or exit codes).
- **Zero-Leak Guarantee:** PRs that write outside `.home/`, mutate host registry/dotfiles, or bypass `config/env/*.toml` SSOT resolution will be rejected.
- **CI Parity:** Verify that GitHub Actions workflows (`.github/workflows/ci.yml`) pass across Windows, Linux, and macOS. If tests pass locally in your hermetic workbench but fail in CI, ping the maintainers on the PR or in the Vieo Discord.

## Commits, Versioning & Milestones

ClauseOS follows **SemVer pre-release milestones** (`v0.9.0-dev.N` leading toward `v1.0.0`) paired with **Conventional Commits** (`feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`) on pull request titles so release notes and changelog generation remain deterministic. Write clear, atomic commit messages explaining *why* a change was made.

## Licensing

ClauseOS and the open-source core of the Vieo stack are released under **MIT / Apache-2.0** (see [LICENSE](LICENSE) for repository-specific terms). By submitting a pull request, you agree that your contributions will be licensed under the project's open-source license.

Thank you for helping build sovereign, carrier-class infrastructure with **Vieo** and **ClauseOS**!