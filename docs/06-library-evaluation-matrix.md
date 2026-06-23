# Library Evaluation Matrix

> Decisions for retain, upgrade, or replace during cleanroom rewrite.
> Research tickets tagged `research` use Firecrawl MCP before final decision.

## Go Runtime and Tooling

| Component | Source | Decision | Cleanroom | Notes |
|-----------|--------|----------|-----------|-------|
| Go version | 1.26.4 | **Retain** | 1.26.4+ | Match upstream |
| Module path | `github.com/coder/coder/v2` | **Replace** | `github.com/anvil/platform` | New module |
| Build | Makefile | **Rewrite** | Makefile | Same targets, new paths |
| Lint | golangci-lint | **Retain** | Same config adapted | |
| SQLC | sqlc | **Retain** | Same version | New query names |
| Swagger | swag | **Retain** | Generate from new handlers | |

## Go Dependencies

| Library | Usage (coderd) | Decision | Alternative | Wave |
|---------|-----------------|----------|-------------|------|
| `golang.org/x/xerrors` | 310 | **Replace** | std `errors` + `fmt` | 1 |
| `github.com/google/uuid` | 252 | **Retain** | — | 1 |
| `cdr.dev/slog/v3` | 178 | **Retain** | — | 1 |
| `github.com/go-chi/chi` | high | **Retain** | — | 3 |
| `github.com/lib/pq` / pgx | high | **Retain** | Evaluate pgx-only | 2 |
| `tailscale.com` (fork) | high | **Retain** | Coder fork required | 7 |
| `gvisor.dev` (fork) | agent | **Retain** | Coder fork | 6 |
| `github.com/ory/fosite` | oauth | **Retain** | RFC compliance | 3 |
| `github.com/hashicorp/terraform` | provisioner | **Retain** | — | 5 |
| `google.golang.org/grpc` | high | **Retain** | — | 5 |
| `github.com/prometheus/client_golang` | metrics | **Retain** | — | 3 |
| `github.com/coder/quartz` | scheduling | **Retain** | — | 4 |
| `github.com/imulab/go-scim` (fork) | SCIM | **Retain** | Coder fork | 9 |

## Frontend Dependencies

| Library | Decision | Notes | Wave |
|---------|----------|-------|------|
| React 19 | **Retain** | | 10 |
| Vite | **Retain** | | 10 |
| TanStack Query | **Retain** | Reorganize hook structure | 10 |
| Tailwind CSS | **Retain** | MUI removal complete | 10 |
| shadcn/ui | **Retain** | Manual component add | 10 |
| Biome | **Retain** | | 10 |
| Emotion/MUI | **Remove** | Not ported to cleanroom | 10 |
| Storybook | **Retain** | | 10 |
| Playwright | **Retain** | E2E in Wave 13 | 13 |
| Vitest | **Retain** | | 10 |

## Infrastructure

| Component | Decision | Wave |
|-----------|----------|------|
| PostgreSQL | **Retain** | 2 |
| Helm | **Rewrite charts** | 12 |
| Docker | **Rewrite Dockerfiles** | 12 |
| GitHub Actions | **Rewrite workflows** | 12 |

## Internal Package Replacements

| Source Package | Cleanroom Package | Wave |
|----------------|-------------------|------|
| `codersdk` | `clientsdk` | 1 |
| `coderd/database` | `persistence` | 2 |
| `coderd/database/dbauthz` | `persistence/accessgate` | 2 |
| `coderd/rbac` | `controlplane/policy` | 3 |
| `coderd/httpmw` | `controlplane/httppipeline` | 3 |
| `coderd/httpapi` | `controlplane/httpx` | 3 |
| `testutil` | `testkit` | 1 |
| `buildinfo` | `buildmeta` | 1 |

## Research Backlog (Firecrawl)

| ID | Question | Blocking Wave |
|----|----------|---------------|
| R-01 | pgx vs lib/pq: migration effort for SQLC | 2 |
| R-02 | slog vs cdr.dev/slog feature parity | 1 |
| R-03 | React Compiler adoption scope in rewrite | 10 |
| R-04 | OAuth2 error format audit (RFC 6749) | 3 |
| R-05 | Tailscale fork diff since last pin | 7 |
