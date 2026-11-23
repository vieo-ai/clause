# ADR 008: Virtual Enterprise Organizational Hierarchy & Agent Governance

## Status

Accepted (Amended 2026-11-23)

## Context

ClauseOS requires an autonomous multi-agent operating structure to execute end-to-end development, architecture governance, security auditing, and delivery workflows directly within the workspace. Rather than relying on flat conversational loops or unconstrained prompt chains, the system requires a structured organizational hierarchy with explicit lines of authority, role segregation, and guardrails for repository write access.

## Decision

Establish a structured **Virtual Enterprise** framework anchored within the **`.apm/` (Agent Package Manager)** workspace:

1. **Workspace Single Source of Truth (`.apm/`)**:
   - **Workspace Package Manifest (`.apm/apm.yml`)**: Top-level constraints, immutable boundaries (license preservation, sandbox isolation, token budget caps), dependencies, and departmental package bindings.
   - **Department Heads & Orchestrators (`.apm/agents/*.agent.md`)**:
     - `board-of-intent`: Strategic ratification, KPI bounding, and constitutional trust gates.
     - `ceo`: Cross-department orchestration, milestone planning, and task DAG assignment.
     - `cto`: Architectural integrity, ADR enforcement, code quality standards.
     - `cpo`: UX consistency, CLI ergonomics, feature delivery tracking.
     - `engineering`: Feature implementation, bug fixes, refactoring, test suites.
     - `security-audit`: Dependency vulnerability checks, hermetic boundary verification, secret leak prevention.
     - `site-reliability`: Nomad workload health, Consul service mesh integrity, telemetry.
     - `documentation-qa`: ADR authoring, README synchronization, task tracking.
   - **Modular Capabilities (`.apm/skills/<name>/SKILL.md`)**: Portable, step-by-step execution workflows.
   - **Normative Directives & Contracts (`.apm/instructions/*.clause.md`)**: Domain contracts and kernel execution rules.
   - **Pluggable Extensions (`.apm/plugins/`)**: Tool schemas, MCP protocol servers, and Lua bridges.
   - **Internal Roles (`.apm/hidden-subagents/`)**: Atomic worker agents kept out of primary UI dropdowns.

2. **Cross-Harness Compilation (`apm build` / `cx apm build`)**:
   - The `.apm/` directory serves as the sole authoritative authoring surface. Executing `apm build` deterministically projects artifacts into downstream harness formats:
     - **`.claude/`**: Emits `CLAUDE.md`, `.claude/skills/`, `.claude/agents/`, and `settings.json`.
     - **`.agents/` & `AGENTS.md`**: Projects portable agent directives for OpenCode, Codex, and OpenClaw.
     - **`.vscode/`**: Emits Copilot workspace agent prompts and tool definitions.

3. **Communication & Coordination Primitives**:
   - **Service & Mailbox Discovery**: Agents register capabilities and status via **Consul**.
   - **Workload Execution**: Autonomous batch operations (code generation, test passes, model runs) are scheduled through **Nomad** using `raw_exec` tasks confined to `.home/`.
   - **Access Leases**: Repository write credentials and sensitive keys are dynamically granted via short-lived **Vault** leases.

4. **Workspace Confinement & Auditability**:
   - Agents operate strictly under `$env:CLAUSE_PROJECT_ROOT` with changes isolated to dedicated feature branches.
   - Direct writes to protected branches (`main`, `release/*`) are strictly forbidden; all pull/merge actions require a green pass from the local assertion test suite (`cx test`).

### 5. Adversarial Verification & Gatekeeper Guardrails

- **Untrusted Worker Output**: Verbal completion claims ("I fixed the issue and tests pass") from worker agents are classified as unverified hypotheses.
- **Independent Supervisory Validation**: Task state cannot advance to `COMPLETED` until an independent supervisory agent executes deterministic verification gates against the generated artifact.
- **Mechanical Assertion Contracts**:
  - Exit code `0` from the hermetic test runner (`run_tests.nu`).
  - Zero out-of-boundary path modifications via git diff assertions.
  - Schema conformity verification.
- **Gated Leases**: Vault dynamically issues short-lived merge tokens exclusively to the supervisor upon mechanical assertion pass.

### 6. Source-Grounded Single Source of Truth (SSOT) & Closed-World Invariant

- **Closed-World Constraint**: The repository documentation (`docs/adr/`, `TASK.md`, and versioned schemas) represents the sole canonical ground truth. Speculative training knowledge not anchored in local source material is classified as unverified hallucination.
- **Bidirectional Traceability**: Code artifacts, configuration keys, and architectural structures must trace directly to an accepted ADR or schema specification.
- **Dual-Plane Separation**:
  - *Human Collaboration Plane (Chat)*: Conversational, flexible, and iterative; compiles human intent into grounded task specifications.
  - *Operational Execution Plane (Strict)*: Non-conversational, deterministic, and role-locked; executed via Nomad `raw_exec` with binary exit codes.

## Consequences

- **Positive**: Complete elimination of ad-hoc custom directory structures; all agents and skills conform to the standardized APM package format.
- **Positive**: Single-source-of-truth authoring with deterministic compilation into `.claude/`, `.agents/`, and `.vscode/`.
- **Positive**: High enterprise auditability—every agent action maps to a job ticket, execution log, and git commit.
- **Negative**: Requires authoring and maintaining `apm build` projection templates for new external harnesses.
