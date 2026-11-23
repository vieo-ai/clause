# Summary

<!-- Provide a concise summary of what changed and why. -->
<!-- Ensure the PR title follows Conventional Commits: feat:, fix:, refactor:, docs:, test:, chore: -->

-

## Related Issues

<!-- Link any issues resolved by this PR using closing keywords (e.g., Fixes #123, Closes #456). -->

- Fixes #

---

## Affected Subsystems & Target Platforms

<!-- Check all that apply -->

**Subsystems:**

- [ ] Stage 0 / 1 Substrate & Boot (`cx.bat`, `cx.ps1`, `cx.sh`, `config/env/*.toml`, `.clause.toml`)
- [ ] Polyglot CLI & Nushell Control Plane (`scripts/cli/nu/`, `scripts/cli/{pwsh,posix}/`)
- [ ] First-Party Mise Plugins (`plugins/cx-*`, `.mise.*.toml`)
- [ ] Compiler & Runtime (`compiler/seaxc/`, `packages/clause_cli/`, `packages/carrier_jet/`, `services/orchestrator/`)
- [ ] Infrastructure, MaaS & Micro-VMs (`ops/`, `cx vm`)
- [ ] TIGAH AI Coprocessors & Virtual Enterprise (`.enterprise/`, `40-ml-hub.toml`)
- [ ] Documentation, ADRs & CCEFS Curriculum (`docs/`, `README.md`, `CONTRIBUTING.md`)
- [ ] CI/CD & Verification Suites (`tests/`, `.github/`)

**Target Platforms:**

- [ ] Windows (`x64` / PowerShell 7 / Patched Scoop / WSL2)
- [ ] Linux (`x64` / `arm64` / POSIX / Landlock / Bubblewrap)
- [ ] macOS (`Apple Silicon` / `Intel` / Confined Brew / Seatbelt / Lima)
- [ ] Hardware Accelerator (`Strix Halo / ROCm`, `XDNA2 NPU`, `CUDA`, `Metal`)

---

## Verification & Hermeticity Checklist

<!-- All non-documentation PRs must pass deterministic offline gates inside the ClauseOS sandbox -->

- [ ] **Conventional Commit Title:** PR title uses a valid prefix (`feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`).
- [ ] **Zero-Leak Confinement:** All state, caches, binaries, and logs remain strictly inside `.home/` and resolve through `config/env/*.toml` SSOT variables (zero host registry, global `$PATH`, or dotfile mutations).
- [ ] **Systems Verification Gate:** `clause test` (`tests/system/run_all.nu`) passes cleanly.
- [ ] **Cross-Shell Invariant Gate:** `pwsh tests/env/run_tests.ps1` passes cleanly (if environment, bootloader, or shell scripts were touched).
- [ ] **Regression Coverage:** Added or updated automated test assertions covering new behavior and boundary/failure cases.

---

## Evidence & Additional Context

<!-- Paste relevant `clause doctor` / `clause test` output, benchmark metrics, or architectural notes. -->

-
