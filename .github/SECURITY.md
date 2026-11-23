# Vieo & ClauseOS Security Policy

The **Vieo** (`vieo-ai`) team treats security, hermetic isolation, and cryptographic provenance as foundational invariants of **ClauseOS** (`clause.os` / `cx`), the **Clause (`.cx`)** compiler toolchain (`cxc`), and the **TIGAH** neural/agentic runtime. This document outlines our vulnerability disclosure protocol, supported release baselines, and defensive engineering architecture.

## Supported Versions

Security patches and advisories are actively maintained for the current development runway leading to `v1.0.0`:

| Version / Branch | Status | Support Scope |
| :--- | :--- | :--- |
| `v0.9.0-dev.x` (`main`) | :white_check_mark: Active | Full security fixes, Stage 0 bootloader hardening, and `cx-*` plugin supply-chain patches |
| `< v0.9.0-dev.1` | :x: Unsupported | End-of-life development snapshots; upgrade to the active `v0.9.0-dev.x` baseline |

## Reporting Security Vulnerabilities

If you discover a security vulnerability anywhere in **ClauseOS** (`vieo-ai/clause.os`), first-party `plugins/cx-*` adapters, the **Clause (`cxc`)** compiler, or **TIGAH** runtime components, we appreciate your help disclosing it responsibly:

1. **Do not** open a public GitHub issue, pull request, or Discord thread disclosing the vulnerability.
2. Submit a private report via **GitHub Security Advisories** (`https://github.com/vieo-ai/clause.os/security/advisories/new`) or email **[security@vieo.ai](mailto:security@vieo.ai)** containing:
   - Affected subsystem, file path, or `cx-*` plugin name (e.g., `cx.ps1`, `cx.sh`, `config/env/*.toml`, `scripts/cli/nu/`, `plugins/cx-*`)
   - A clear technical description of the vulnerability and threat model
   - Deterministic reproduction steps or proof-of-concept inputs
   - Potential impact (e.g., host-OS `.home/` sandbox escape, Windows registry/shortcut leakage, credential exposure, supply-chain hash bypass, or prompt/Unicode smuggling)
   - Your preferred attribution handle (optional)
3. The Vieo security maintainers will acknowledge receipt within **48 hours** and coordinate remediation, regression tests, and patch verification with you.
4. Once mitigated and verified against our CI/CD gates, you will be credited in the release notes and published security advisory (unless you request anonymity).

## Core Security Architecture & Practices

ClauseOS enforces defense-in-depth across its bare-metal userland substrate, package supply chain, and local AI execution planes:

- **Zero-Leak Hermetic Confinement (`.home/`):** Stage 0 bootloaders (`cx.ps1` and `cx.sh`) and modular SSOT environment manifests (`config/env/*.toml`) confine all user profiles, XDG/Windows Known Folders, SSH keys (`10-identity.toml`), and caches strictly inside `${CLAUSE_PROJECT_ROOT}/.home/`. Host hygiene preflight redlines reject unmanaged global `mise`, `scoop`, or `brew` installations and scrub CI runner paths before execution.
- **Sterilized Package Supply Chain (`# clause-scoop-patches: 1` & Confined `Brew`):** Third-party package managers are neutralized against host mutations—blocking `HKCU:\Environment` registry writes, Windows Start Menu `.lnk` creation, and global (`-g` / `--cask`) installation flags—while verifying SHA-256 release digests for downloaded runtime archives.
- **Dynamic Secret Leases & Identity Isolation:** Git and SSH configurations are locked to `.home/.gitconfig` and `.home/.ssh/`, and cluster/agent secrets are brokered via short-lived, scope-bound **HashiCorp Vault** dynamic leases rather than static plaintext credentials.
- **Local-First AI & Closed-World Grounding (`TIGAH`):** Local neural coprocessors (`Lemonade`, `FastFlowLM`, `InferSSD`, `Unsloth`, `ComfyUI`) operate offline against a unified `${HF_HOME}` cache with zero external telemetry phone-homes, while agent harnesses enforce default-deny capability boundaries and Unicode/bidi smuggling sanitization.
- **Deterministic Offline Verification Gates (`cx test`):** Every code contribution undergoes maintainer review and automated cross-platform verification (`tests/system/run_all.nu` and `tests/env/run_tests.ps1`) across Windows, Linux, and macOS runners to prove zero host leakage and exit-code determinism.

## Security Advisories & Responsible Disclosure

When a vulnerability is resolved:

- We publish a **Security Advisory** on GitHub and `vieo.ai` detailing the affected versions, root cause, CVSS impact assessment, patched commit/tag, and mitigation steps.
- We coordinate disclosure timelines with reporting researchers so fixes and automated regression assertions are deployed before public details are released.

## Contact

For security reports, PGP key requests, or architectural security inquiries, contact **[security@vieo.ai](mailto:security@vieo.ai)**.