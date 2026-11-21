# ClauseOS Document Tree Synchronization & Drift Remediation Plan

> **Audit Basis:** `06-clauseos-source-bundle.md` (`v0.9.0-dev.1`, 178 tracked files) + `05-source-bundle-audit-report.md` + `docs/architecture/clause-cxc-refactoring-blueprint.md`
>
> **Purpose:** Map every stale reference (`seax` / `seaxc`, `compiler/seaxc/`, `packages/carrier_jet/`, `Air` / `Jet` split, missing `TIGAH` & 9-Pillar lexicon, and the 7 internal bundle defects) across the tracked documentation tree prior to applying non-destructive updates.

---

## 1. Executive Summary of Document Tree Drift

Now that the architectural nomenclature and compiler design are locked in:
* **Parent Steward:** **Vieo** (`vieo-ai`)
* **Operating Substrate:** **ClauseOS (`cx`)** — Carrier Exchange
* **Programming Language:** **Clause (`.cx`)** in `packages/clause/`
* **Compiler CLI Binary:** **`cxc`** (`cxc run`, `cxc build`, `cxc check`, `cxc lsp`)
* **Neural & Agentic Stack:** **TIGAH** (*Transmedia Intelligent Generative Autonomous Hermetic*) + **`packages/clause_jet/`**
* **9 Canonical Operational Pillars:** `kernel` (Systems/DevOps), `app` (Service Providers), `infra` (Cloud/Pulumi), `mission` / `deck` (Aviation & NASA Mission Control), `comms` (Telecom), `studio` (Recording/Publishing), `stage` (Film/Broadcast), `stream` (IPTV/OTT), and `tactical` / `tigah` (Military/AI)

Every tracked document in the repository falls into one of **four synchronization tiers** below.

---

## 2. Tier 1: Supreme SSOT Curriculum & Portal Specifications (`docs/ccefs/00`–`04`)

| File Path | Current Drift / Stale References | Required Surgical Updates |
| :--- | :--- | :--- |
| **`docs/ccefs/00-PROJECT-SPECIFICATION-v3.0.md`** | • Refers to language/compiler as **Seax (`seaxc`)** in `compiler/seaxc/` and **Air / Jet** split (`packages/carrier_jet/`).<br>• Missing explicit **TIGAH** neural tier & **9-Pillar** domain purity rule (`ADR 0007` boundary).<br>• Section 3 Source Inventory lacks the **`d` (`d01`–`d99`)** Discussions prefix. | • Replace `Seax` / `seaxc` / `compiler/seaxc/` with **Clause (`.cx`)** / **`cxc`** / **`packages/clause/`**.<br>• Replace `packages/carrier_jet/` with **`packages/clause_jet/`** and codify **TIGAH**.<br>• Lock in the **9 Canonical Operational Pillars** + **3-Tier Grammar Strategy** + **`@external(rust, ...)`** direct crate imports.<br>• Add row **`d` (`d01`–`d99`)** to Section 3 Source Inventory. |
| **`docs/ccefs/01-ccefs-30-modules-v4.3.md`** | • Stage 1 (Modules 1–5) describes building `seaxc` from scratch (`crates/seax-token`, `seax-lexer`, `seax-vm`) rather than forking `gleam-lang/gleam` inside `packages/clause/` (`clause-core`, `clause-cli` $\rightarrow$ `cxc`, `clause-lsp`, `clause-wasm`, `clause-runtime`) with Monkey-X (`transcc`) `--target rust` + `--target beam` + `--target client`.<br>• References `packages/carrier_jet/` and `seax-vfs`. | • Align Stage 1 (Modules 1–5) to the **`packages/clause/` (`cxc`) Gleam-fork + Monkey-X (`transcc`)** architecture (`clause-core`, `clause-runtime`, `brand.rs`, Tier 1–3 9-pillar grammar, `@external(rust, ...)` + `RinG`).<br>• Update `seax-vfs` $\rightarrow$ `clause-vfs` (`.ground/`) and `carrier_jet` $\rightarrow$ `clause_jet`. |
| **`docs/ccefs/02-stage0-foundation-modules-v4.3.md`** | • Module 0.5 references `seax-vfs` and `Seax`. | • Update `seax-vfs` $\rightarrow$ `clause-vfs` (`.ground/` content-addressed VFS) and align terminology with **ClauseOS (`cx`)** and **TIGAH**. |
| **`docs/ccefs/03-stage1-2-compiler-orchestrator-v4.3.md`** | • Stage 1 deep-dive (`Modules 1–5`) uses `crates/seax-*` naming and `Air` / `Jet` split instead of `packages/clause/crates/clause-*` (`cxc`), `packages/clause_jet/`, and the 9-pillar lexicon (`kernel`, `service_provider`, `infra`, `provider`, `agent`, `gateway`, `trunk`, `bridge`, `dialplan`, `bus`, `rack`, `patchbay`, `split`, `stage`, `mcr`, `headend`, `airgap`, `sortie`). | • Re-anchor Stage 1 (`Modules 1–5`) on `packages/clause/crates/{clause-core,clause-cli,clause-lsp,clause-wasm,clause-runtime}` outputting `cxc`.<br>• Update Stage 2 (`Module 10`) to reference `infra` / `provider` compiling to `crates/clause-pulumi` (`catapult`). |
| **`docs/ccefs/04-vieo-ai-curriculum-portal.md`** | • Track 2 is titled *"Claude, OpenClaw & Hermes Unified Inside Seax"* and references `seaxc` / `crates/seax-*` / `seax-vfs`. | • Update Track 2 to **"Claude, OpenClaw & Hermes Unified Inside Clause (`.cx`) & TIGAH"** (`packages/clause/` + `packages/clause_jet/` + `packages/tigah/`). |

---

## 3. Tier 2: Architecture Decision Records (`docs/adr/`)

| File Path | Current Drift / Defect in `06` Bundle | Required Surgical Updates |
| :--- | :--- | :--- |
| **`docs/adr/adr_011-seax-language-transpiler-agent-directory.md`** *(Rename recommended: `adr_011-clause-language-transpiler-agent-directory.md`)* | • Still titled **Seax Programming Language** with `compiler/seaxc/`, `package.seax`, `packages/carrier_jet/`, and `Air` (`cx air run`) / `Jet` (`cx jet up`) split. | • Amend status to `Accepted (Amended 2026-11-20)`.<br>• Codify **Clause (`.cx`)**, **`cxc`** (`packages/clause/`), **`clause.toml`**, **`packages/clause_jet/`**, **TIGAH**, the **9 Canonical Pillars** (3-tier grammar), and **`@external(rust, ...)` + `RinG`** dual-target execution. |
| **`docs/adr/adr_006-micro-instance-virtualization.md`** | • **[CRITICAL BUG from `05` Audit]:** File body is an accidental duplicate of ADR 005 (*Unified Model Storage*). | • Restore the canonical **ADR 006: Cross-Platform Micro-Instance Virtualization (`cx vm`)** specification (`wsl.exe` on Windows, `limactl` on POSIX, confined inside `.home/`). |
| **`docs/adr/adr_010-beam-orchestrator-nomad-scheduler-maas.md`** | • Mentions Gleam orchestrator & Pulumi Automation API without referencing `packages/clause/` (`cxc`), `crates/clause-pulumi` (`catapult`), or `clause_jet`. | • Append **Implementation Evolution Addendum (2026-11-20)** linking `infra` / `provider` `.cx` declarations directly to `crates/clause-pulumi` (`pulumi-gestalt`) and `packages/clause_jet/`. |
| **`docs/adr/adr_012-ring-rust-in-gleam-bridge.md`** | • Describes `RinG` solely as manual `ring-codegen` between Rust and Gleam. | • Append **Addendum (2026-11-20)**: Document how `cxc` invokes `tools/ring` automatically whenever a `.cx` module with `@external(rust, ...)` compiles to `--target beam`. |
| **`docs/adr/adr_013-curated-domain-slms-vs-saturated-generalists.md`** | • Generic reference to `1B–7B` domain SLMs without naming the **TIGAH** neural tier (`cx hangar`). | • Append **Addendum (2026-11-20)**: Formally designate the contained domain SLM suite and local inference hub (`${HF_HOME}`) as **TIGAH** (`tigah-coder`, `tigah-instruct`, `tigah-audio`, `tigah-midi`, `tigah-vision`). |
| **`docs/adr/adr_001` – `005`, `007` – `009`** | • Consistent with codebase (`002` and `004` already have `2026-11-15` addenda). | • No structural rewrite needed; verify cross-links to `ADR 011` (`Clause` / `cxc`). |

---

## 4. Tier 3: Root Repository Documentation (`README.md`, `TASK.md`, `llms.txt`, `mkdocs.yml`)

| File Path | Current Drift / Stale References | Required Surgical Updates |
| :--- | :--- | :--- |
| **`README.md`** | • Directory tree & OS primitives table reference `packages/carrier_jet/`, `Seax`, and omit `packages/clause/` (`cxc`), `packages/tigah/`, `tools/ring/`, `crates/clause-pulumi/`, and the **7-Layer Architecture**. | • Update canonical directory tree (`packages/clause/`, `packages/clause_jet/`, `packages/tigah/`, `tools/ring/`, `crates/clause-pulumi/`).<br>• Add the **Vieo $\rightarrow$ ClauseOS (`cx`) $\rightarrow$ TIGAH $\rightarrow$ Clause (`.cx`) / `cxc`** overview, 7-layer stack diagram, and `cxc run` / `cxc build` quick-start commands. |
| **`TASK.md`** | • Phase 12 still titled *"Seax Language Compiler Core (`seaxc`), Air & Jet Runtimes"* under `compiler/seaxc/` and `packages/carrier_jet/`.<br>• ADR table links use `0001-...` instead of actual filenames `adr_001_...`. | • Update Phase 12 to **"Clause Language Compiler (`cxc`), TIGAH & `clause_jet` Runtimes"** under `packages/clause/` and `packages/clause_jet/`.<br>• Fix ADR markdown links to match actual `docs/adr/adr_001_...` filenames on disk.<br>• Incorporate the remaining `05-source-bundle-audit-report.md` stabilization items. |
| **`llms.txt` & `mkdocs.yml`** | • Navigation & LLM index reference `Seax` / `seaxc` and omit `docs/architecture/clause-cxc-refactoring-blueprint.md`. | • Add `docs/architecture/clause-cxc-refactoring-blueprint.md` to `mkdocs.yml` and `llms.txt`, and update `Seax` $\rightarrow$ `Clause (.cx)` / `cxc` / `TIGAH`. |

---

## 5. Tier 4: Live Code & CI Defects Flagged in `05-source-bundle-audit-report.md` (For Synchronized Fix)

While updating the documentation tree, these **6 remaining code/config defects** from `05-source-bundle-audit-report.md` should be patched in lockstep so `06-clauseos-source-bundle.md` stays 100% green:
1. **`scripts/cli/nu/core/env.nu`:** Remove legacy `.env` file parsing and read environment variables exported by `cx.ps1`/`cx.sh` from `config/env/*.toml`.
2. **`config/env/20-toolchains.toml`:** Add `CARGO_HOME = "${CLAUSE_DATA_DIR}/cargo"` and `RUSTUP_HOME = "${CLAUSE_DATA_DIR}/rustup"` so compiling `packages/clause` (`cxc`) never pollutes host `~/.cargo`.
3. **`.github/workflows/ci.yml`:** Uncomment `./cx.sh test` and `.\cx.ps1 test` so `run_all.nu` executes in CI.
4. **`tests/system/test_stage1.nu` & `tests/env/test_env.{nu,sh}`:** Update legacy `.home/.../apps/` assertions to `$MISE_INSTALLS_DIR` and strip literal citation markers.
5. **`cx.sh`:** Preserve `_CALLER_CLAUSE_STATUS="online"` across nested subshells (matching `cx.ps1`).
6. **`plugins/cx-comfyui/hooks/post_install.lua`:** Generate `extra_model_paths.yaml` pointing to `$HF_HUB_CACHE`.

---

## 6. Recommended Execution Order (Awaiting Your Authorization)

To keep every commit atomic, verifiable, and non-destructive, we can update the document tree in **three clean batches**:

1. **Batch 1 — ADRs & Root Ledger (`docs/adr/adr_011*`, `adr_006*`, `adr_010*`, `adr_012*`, `adr_013*`, `README.md`, `TASK.md`, `mkdocs.yml`, `llms.txt`)**
2. **Batch 2 — Supreme SSOT Curriculum & Portal Specs (`docs/ccefs/00`–`04`)**
3. **Batch 3 — Code/Config Synchronization (`config/env/20-toolchains.toml`, `scripts/cli/nu/commands/build.nu`, `boot.nu`, and the `05` audit fixes)**

Which batch would you like me to generate first?