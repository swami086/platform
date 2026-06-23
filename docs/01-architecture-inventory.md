# Architecture Inventory (Torbit-Derived)

> Source: Torbit graph for `project_id = 6923339167500771290` (`/Users/swami/Documents/Coder_OSS`), indexed 2026-06-22.

## System Overview

```
                    ┌─────────────────────────────────────┐
                    │           Web UI (site/)            │
                    │   React + Vite + TypeScript         │
                    └──────────────┬──────────────────────┘
                                   │ REST
                    ┌──────────────▼──────────────────────┐
                    │         Control Plane               │
                    │   coderd/ (591 Go files)            │
                    │   Chi HTTP, PostgreSQL, dbauthz     │
                    └─┬────────────┬──────────────┬───────┘
                      │ gRPC       │ tailnet      │ pubsub
          ┌───────────▼──┐  ┌──────▼──────┐  ┌───▼────────┐
          │ provisionerd │  │   tailnet   │  │ enterprise/ │
          │ + provisioner│  │  + vpn      │  │ wsproxy etc │
          └──────┬───────┘  └──────┬──────┘  └────────────┘
                 │ Terraform       │ WireGuard/DERP
          ┌──────▼───────┐  ┌──────▼──────┐
          │  Cloud/VM    │  │   agent/    │
          │  Resources   │  │ (126 files) │
          └──────────────┘  └─────────────┘
```

## Top-Level Package Map

| Source Package | Go Files | TS/Other | Cleanroom Target | Priority |
|----------------|--------:|---------:|------------------|----------|
| `coderd/` | 591 | — | `src/controlplane/` | P0 |
| `coderd/database/` | 1,310* | — | `src/persistence/` | P0 |
| `site/` | 4 | 5,853 | `src/console/` | P1 |
| `cli/` | 159 | — | `src/terminal/` | P1 |
| `agent/` | 126 | — | `src/workspace-agent/` | P1 |
| `enterprise/` | 114 | — | `src/premium/` | P2 |
| `codersdk/` | 93 | — | `src/clientsdk/` | P0 |
| `aibridge/` | 69 | — | `src/ai-gateway/` | P2 |
| `tailnet/` | 31 | — | `src/mesh/` | P1 |
| `provisionerd/` | 11 | — | `src/orchestrator/` | P1 |
| `provisioner/` | 20 | — | `src/executor/` | P1 |
| `provisionersdk/` | 14 | — | `src/executor-sdk/` | P1 |
| `cmd/` | 33 | — | `src/cmd/` | P1 |
| `forge/` | 54 | — | `src/extensions/` | P3 |
| `scaletest/` | 63 | — | `src/loadtest/` | P3 |
| `vpn/` | 12 | — | `src/tunnel/` | P2 |
| `pty/` | 14 | — | `src/terminal-pty/` | P2 |

\* `coderd/database/` includes generated SQLC output and migrations (majority of coderd file count).

## Control Plane (`coderd/`) Submodule Inventory

| Submodule | Files | Hub Role | Rewrite Notes |
|-----------|------:|----------|---------------|
| `database/` | 1,310 | SQLC, migrations, dbauthz | Regenerate from rewritten queries; preserve schema |
| `x/` | 292 | Extensions (chatd, etc.) | Sub-packages per feature |
| `notifications/` | 119 | Email/webhook dispatch | Event-driven rewrite |
| `httpmw/` | 72 | HTTP middleware chain | Reorder middleware composition |
| `templatebuilder/` | 62 | Template compilation | New builder pipeline names |
| `rbac/` | 52 | Authorization rules | Policy engine rewrite |
| `agentapi/` | 38 | Agent-facing API | gRPC/REST handlers |
| `aibridged/` | 27 | AI bridge daemon hooks | |
| `workspaceapps/` | 20 | App proxying | |
| `httpapi/` | 20 | Response helpers | |
| `oauth2provider/` | 19 | OAuth2 server | RFC compliance mandatory |
| `provisionerdserver/` | 8 | Provisioner gRPC server | |
| `schedule/` | 9 | Autostart/stop | |
| `prebuilds/` | 10 | Prebuilt workspaces | |

### Import Hubs (rewrite order matters)

These files have the highest import fan-out; rewrite only after dependencies exist:

| File | Import Edges | Target |
|------|-------------:|--------|
| `coderd/coderd.go` | 109 | `controlplane/server.go` |
| `coderd/coderdtest/coderdtest.go` | 103 | `controlplane/testkit/server.go` |
| `coderd/x/chatd/chatd.go` | 54 | `controlplane/features/chat/service.go` |
| `coderd/provisionerdserver/` | 51 | `controlplane/orchestration/grpc.go` |
| `coderd/workspaceagents.go` | 50 | `controlplane/handlers/workspace_agents.go` |

## Binary Entry Points (`cmd/`)

| Binary | Cleanroom Name |
|--------|----------------|
| `cmd/coder/main.go` | `cmd/anvil/main.go` |
| `cmd/cliui/main.go` | `cmd/tui/main.go` |
| `cmd/forge-*` (11 binaries) | `cmd/ext-*` (extensions namespace) |

## Agent Subsystem (`agent/`)

| Module | Files | Responsibility |
|--------|------:|----------------|
| `agentcontainers/` | 52 | Container runtime integration |
| `agentcontext/` | 18 | Agent lifecycle context |
| `agentssh/` | 16 | SSH server in workspace |
| `agentsocket/` | 12 | Socket forwarding |
| `reconnectingpty/` | 5 | Resilient PTY sessions |
| `proto/` | 13 | Agent gRPC definitions |

## Enterprise (`enterprise/`)

| Module | Files | Responsibility |
|--------|------:|----------------|
| `enterprise/coderd/` | 139 | Premium API extensions |
| `enterprise/cli/` | 95 | Premium CLI commands |
| `enterprise/audit/` | 13 | Audit log pipeline |
| `enterprise/wsproxy/` | 7 | Regional workspace proxy |
| `enterprise/dbcrypt/` | 6 | Database encryption |

## Frontend (`site/src/`)

| Area | ~Files | Stack |
|------|-------:|-------|
| `src/` (total) | 1,795 | React 19, Vite, TanStack Query, Tailwind, shadcn |
| Pages | ~200+ | Route-based |
| Components | ~400+ | Shared UI primitives |
| API client | ~50 | Generated types from swagger |

## Database Layer

| Asset | Count | Strategy |
|-------|------:|----------|
| Migration files | 1,141 | Semantic replay: same DDL outcomes, new migration IDs/names |
| SQLC query files | 77 | Rewrite SQL with equivalent semantics, new query names |
| Generated Go | auto | `make gen` after query rewrite |

## Graph Statistics

| Edge Type | Count |
|-----------|------:|
| DEFINES | 83,185 |
| IMPORTS | 32,153 |
| CALLS | 11,980 |

## External Dependency Hotspots (coderd)

| Import | Usage Count | Retain? |
|--------|------------:|---------|
| `github.com/coder/coder/v2/coderd/database` | 232 | Rewrite (internal) |
| `github.com/coder/coder/v2/codersdk` | 210 | Rewrite (internal) |
| `github.com/google/uuid` | 252 | Retain |
| `cdr.dev/slog/v3` | 178 | Retain |
| `golang.org/x/xerrors` | 310 | Evaluate: migrate to std `errors` |
| `tailscale.com` (fork) | many | Retain fork |

Full library decisions: [06-library-evaluation-matrix.md](06-library-evaluation-matrix.md).
