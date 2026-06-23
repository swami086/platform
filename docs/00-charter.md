# Charter: Anvil Platform (Cleanroom Replatform)

## 0. Approved Decisions (2026-06-23)

| Item | Value |
|------|-------|
| Codename | `anvil` |
| Module | `github.com/swami086/platform` |
| GitHub | https://github.com/swami086/platform |
| License | GNU AGPL v3.0 — original work ([NOTICE.md](../NOTICE.md)) |
| Derivative labeling | **Prohibited** — do not describe Anvil as derivative of Coder_OSS |
| API compatibility | External REST/gRPC unchanged; internals fully rewritten |
| Enterprise | Full parity |
| Wave 0 | Deferred until explicit approval |

## 1. Mission

Produce a functionally equivalent remote development environment platform by **rewriting** every implementation file while preserving:

- Language stack (Go 1.26+, TypeScript/React, PostgreSQL, Protobuf/gRPC, Terraform provisioning)
- Subsystem topology (control plane, provisioner, agent, tailnet, CLI, site, enterprise)
- External contracts (HTTP API shapes, gRPC services, database schema semantics, CLI UX)
- Security model (dbauthz/RBAC, OAuth2 RFC compliance, agent token auth)

## 2. Clean-Room Constraints

### Must differ from source

- Package and directory naming (new vocabulary, not `coderd` → use `controlplane`, not `codersdk` → use `clientsdk`, etc.)
- Function, method, struct, and variable names
- File organization within packages (split/merge boundaries may change if responsibility stays clear)
- Comment prose and error message wording (behavior-preserving, not copy-paste)
- Internal algorithm structure (same outcomes, different control flow where safe)
- Test fixture naming and helper structure

### Must preserve

- HTTP route paths and swagger annotations (public API stability)
- Database table/column semantics (migrations may be regenerated with new filenames)
- gRPC `.proto` message and service contracts (field numbers, service names)
- CLI command tree and flag names (user-facing)
- Environment variable names consumed by operators
- Terraform provisioner protocol behavior

### Strictly forbidden

- Copy-paste of source blocks (automated similarity checks in CI)
- Workarounds that skip root-cause fixes (per user directive)
- Reading or importing plans/specs from `Coder_OSS/specs/` or `Forge/` (this plan is independent)
- Bypassing git hooks (`--no-verify`)

## 3. Engineering Skills Application

Each wave assigns a primary engineering skill role:

| Role | Skill path | Applied to |
|------|------------|------------|
| Architect | `engineering-skills/senior-architect` | Wave planning, interface design |
| Backend | `engineering-skills/senior-backend` | Go services, APIs, database |
| Frontend | `engineering-skills/senior-frontend` | `site/` equivalent |
| Fullstack | `engineering-skills/senior-fullstack` | Cross-cutting integration |
| Security | `engineering-skills/senior-security` | Auth, RBAC, audit |
| DevOps | `engineering-skills/senior-devops` | CI, Helm, deploy |
| QA | `engineering-skills/senior-qa` | Test strategy per wave |
| Code Review | `engineering-skills/code-reviewer` | Post-batch review gate |

## 4. Navigation and Verification (Torbit MCP)

**Before every batch:**

1. `run_sql` against `gl_file` / `gl_definition` for source subsystem
2. Map import graph for packages being rewritten
3. Record `project_id` baseline counts

**After every batch:**

1. `index` the new `cleanroom-platform/src/` path
2. Compare definition counts, import edges, and public API surface
3. Run targeted `make test` / `pnpm test` for touched packages
4. Document verification in ticket closure notes

## 5. Web Research (Firecrawl MCP)

Use Firecrawl MCP (not generic web search) when evaluating:

- Library upgrade paths (Go module replacements, React dependency migrations)
- Security advisories for retained dependencies
- RFC/OAuth2 compliance references

## 6. Non-Goals

- Changing the product's core value proposition
- Removing enterprise features
- Rewriting documentation prose in `docs/` (deferred to Wave 12)
- Migrating off PostgreSQL or Terraform

## 7. Success Criteria

| Criterion | Measurement |
|-----------|-------------|
| Build | `make build` succeeds |
| Unit tests | `make test` passes (full suite) |
| Frontend | `pnpm lint && pnpm test` passes in site |
| API parity | Swagger diff shows no breaking public changes |
| Code dissimilarity | <15% token overlap vs source (custom linter, Wave 13) |
| Architecture parity | Torbit graph: same subsystem count, equivalent import hubs |

## 8. Risk Register

| Risk | Mitigation |
|------|------------|
| Scope explosion (1,500+ Go files) | Strict wave gates; no cross-wave scope creep |
| License contamination | Clean-room process; no copy-paste; separate git history; standalone AGPL ([NOTICE.md](../NOTICE.md)) |
| API drift | Contract tests generated from swagger before Wave 3 |
| Test flakiness | Follow upstream testing patterns; no `time.Sleep` mitigations |
| Agent context limits | Max 8 files per subagent batch; Torbit re-index between batches |

## 9. Governance

- One ticket = one reviewable PR-sized unit (typically 3-12 files)
- Batch size for parallel subagents: 4 tickets max concurrent
- Human approval required at wave boundaries
- This document is the sole planning authority (no Forge/Coder_OSS spec imports)
