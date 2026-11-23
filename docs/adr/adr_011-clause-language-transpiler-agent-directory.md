# ADR 011: Clause Programming Language, Multi-Target Transpiler, and Agent Directory Pattern

## Status

Accepted (Amended 2026-11-20)

## Context

Authoring complex transmedia pipelines (audio, video, SMPTE, MIDI, NDI, Dante), autonomous multi-agent hierarchies, and distributed infrastructure in disconnected DSLs, prompt templates, and shell scripts causes brittle glue code and high cognitive overhead.

## Decision

Create **Clause** (extension `.cx`), a carrier-class transmedia, systems, and agentic programming language constructed as an upstream-clean fork of **`gleam-lang/gleam`** inside `packages/clause/`, emitting the **`cxc`** CLI binary (`cxc run`, `cxc build`, `cxc check`, `cxc lsp`) with Mark Sibley's Monkey X (`transcc`) multi-target transpilation:

1. **Language Design & Sound Type System**:
   * **Gleam ML/Rust Core Heritage**: Retains 100% of Gleam's Hindley-Milner type inference, algebraic data types, exhaustive pattern matching, pipe operator (`|>`), `use` callbacks, and `@external` FFI.
   * **First-Class Domain Primitives**: Extends the grammar with dedicated keywords for the **Nine Canonical Operational Pillars** (`kernel`, `app`, `infra`, `deck`, `comms`, `studio`, `stage`, `stream`, and `tactical`/`tigah`).
   * **Concept-as-Code**: Agent behaviors, telecom dialplans, audio DSP summing graphs, and cloud infrastructure DAGs execute as typed code verified at compile time rather than ungrounded Markdown prompts.

2. **Monkey X Multi-Target Transpiler Architecture (`Target::Rust`, `Target::Beam`, `Target::Client`)**:
   * Decouples the sound front-end parser and type checker from code emission via three pluggable backends:
     * **`--target beam` (Carrier Control Plane)**: Transpiles control planes, SIP dialplans, show-control switches, and agent supervisors into Core Erlang / `.beam` bytecode for distributed Erlang/OTP 29 release packages (`packages/clause_jet/`).
     * **`--target rust` (Native Systems Data Plane)**: Transpiles compute-critical hot paths, real-time audio/video DSP blocks, and declarative infrastructure directly into native Cargo crates linking `oximedia`, `nih-plug` (CLAP/VST3), the Storytold `Craft` suite, and revived `pulumi-gestalt` (`crates/clause-pulumi`).
     * **`--target client` (Touch Glass & Mobile)**: Transpiles UI viewports, flight decks, and telemetry surfaces into TypeScript / ES6 and WebAssembly powering `Lustre` (Web/SSR), `Plushie` (Native Desktop), `Shore` (TUI), and Open Stage Control (`O2K`).
   * Direct native Rust crate imports via `@external(rust, "crate::mod", "fn")` compile with zero memory copies on `--target rust` and synthesize automatic `tools/ring` dirty-scheduler NIFs on `--target beam` (`ADR 0012`).

3. **Unified "Agent is a Directory" Architecture**:
   * Blends Jet's "agent as file" model with Monkey X package modularity.
   * An agent or complete department is an isolated directory containing:
     * Root coordinator (`agent.cx`) and sub-agent files (`team/*.cx`).
     * Executable skill definitions (`skills/*.cx`).
     * Embedded MCP servers (`mcp/*/server.cx`).
     * Native DSP/NIF plugins (`plugins/*.cx`).
     * Manifest, permissions, and leased credentials (`clause.toml`).
   * An agent directory compiles and executes as a headless BEAM service, an HTTP API, a desktop tool, or a Nomad worker job.

4. **Domain Purity Invariant (`ADR 0007` Compliance)**:
   * Language keywords and standard library namespaces (`stdlib/clause/`) are strictly confined to the Nine Canonical Operational Pillars. Generic commercial business verticals (retail POS, bakery software, hospital EHR) are barred from compiler core crates and quarantined to optional downstream `.enterprise/` or `.apm/` cartridges.

## Consequences

* **Positive**: Unmatched execution range—one language syntax drives real-time audio/video DSP, cloud orchestration, and autonomous agent logic across both Erlang/OTP and native Rust silicon.
* **Positive**: Packaging agents as self-contained directories eliminates configuration sprawl and makes agent departments portable and versionable.
* **Positive**: Static type safety and compile-time validation for distributed agent messaging and hardware buses.
* **Positive**: Upstream-clean fork: Isolates custom Clause extensions into dedicated AST lower passes, branding constants (`brand.rs`), and backend emitters, preserving 100% compatibility with Hex ecosystem packages and upstream compiler updates.
* **Negative**: Requires maintaining multi-target codegen emitters in `packages/clause/crates/clause-core/src/backend/` (`rust.rs`, `erlang.rs`, `javascript.rs`).

---

## Architectural Refinement & Addendum (2026-11-20)

Following architectural consensus in transcript `d48-gleam-to-clause-forking` and the publication of `docs/ccefs/06-clause-cxc-gleam-refactoring-multi-target-blueprint.md`:

1. **Nomenclature Standardization**: The language is formally designated **Clause** (`.cx`), compiled by **`cxc`** (`packages/clause/` outputting `${CLAUSE_BIN_DIR}/cxc`), managed under corporate steward **Vieo** (`vieo-ai`), with local neural coprocessors unified under **TIGAH** (*Transmedia Intelligent Generative Autonomous Hermetic*).
2. **Unified Runtime Consolidation**: The legacy `Air` / `Jet` runtime division is retired. Runtime execution consolidates into:
   * **`cxc`**: Multi-target compiler CLI (`cxc run`, `cxc build`, `cxc check`).
   * **`packages/clause_jet/`**: The Erlang/OTP mission control runtime supervising agent swarms, tool routing, and schema repair (`jet_sap`).
   * **`crates/clause-pulumi/`**: Revived `pulumi-gestalt` (`catapult`) executing programmatic cloud infrastructure compilation directly from `.cx` `infra` declarations.
