# Ticket Index

> Status legend: `planned` | `ready` | `in-progress` | `verified` | `blocked`

## Summary

| Wave | Tickets | Status |
|------|--------:|--------|
| 0 Foundation | 8 | planned |
| 1 Shared Libs | 12 | planned |
| 2 Database | 18 | planned |
| 3 Control Plane Core | 22 | planned |
| 4 Control Plane Features | 28 | planned |
| 5 Provisioning | 14 | planned |
| 6 Agent | 16 | planned |
| 7 Networking | 10 | planned |
| 8 CLI | 14 | planned |
| 9 Enterprise | 18 | planned |
| 10 Frontend | 24 | planned |
| 11 Extensions | 10 | planned |
| 12 Deploy/Ops | 8 | planned |
| 13 Verification | 6 | planned |
| **Total** | **208** | |

---

## Wave 0: Foundation

| ID | Title | Files | Batch | Status |
|----|-------|------:|-------|--------|
| [CR-001](wave-00-foundation/CR-001-repo-scaffold.md) | Repository scaffold and go.mod | 5 | A | planned |
| [CR-002](wave-00-foundation/CR-002-makefile-build.md) | Makefile and build pipeline | 3 | A | planned |
| [CR-003](wave-00-foundation/CR-003-lint-ci-skeleton.md) | Lint and CI skeleton | 4 | B | planned |
| [CR-004](wave-00-foundation/CR-004-stub-server-binary.md) | Stub anvil server binary | 4 | B | planned |
| [CR-005](wave-00-foundation/CR-005-path-mapping-manifest.md) | Source-to-cleanroom path mapping | 2 | A | planned |
| [CR-006](wave-00-foundation/CR-006-swagger-baseline.md) | Capture swagger API baseline | 2 | B | planned |
| [CR-007](wave-00-foundation/CR-007-torbit-index-setup.md) | Torbit index and verification scripts | 3 | A | planned |
| [CR-008](wave-00-foundation/CR-008-dissimilarity-scaffold.md) | Dissimilarity check script scaffold | 2 | B | planned |

## Wave 1: Shared Libraries

| ID | Title | Source Scope | Batch | Status |
|----|-------|--------------|-------|--------|
| CR-101 | buildmeta package | `buildinfo/` | A | planned |
| CR-102 | cryptorand package | `cryptorand/` | A | planned |
| CR-103 | archive package | `archive/` | A | planned |
| CR-104 | apiversion package | `apiversion/` | B | planned |
| CR-105 | clientsdk core types | `codersdk/` (part 1) | B | planned |
| CR-106 | clientsdk workspace types | `codersdk/` (part 2) | C | planned |
| CR-107 | clientsdk agent types | `codersdk/` (part 3) | C | planned |
| CR-108 | clientsdk HTTP client | `codersdk/` (part 4) | D | planned |
| CR-109 | testkit core utilities | `testutil/` (part 1) | D | planned |
| CR-110 | testkit assertions | `testutil/` (part 2) | A | planned |
| CR-111 | testkit postgres helpers | `testutil/` (part 3) | B | planned |
| CR-112 | Wave 1 integration test | all wave 1 | C | planned |

## Wave 2: Database (sample; see wave folder for all 18)

| ID | Title | Source Scope | Status |
|----|-------|--------------|--------|
| CR-201 | Migration runner infrastructure | `coderd/database/migrations/` | planned |
| CR-202 | SQLC config and gen pipeline | `coderd/database/sqlc.yaml` | planned |
| CR-203 | accessgate authorization wrapper | `coderd/database/dbauthz/` | planned |
| CR-204 | Users and authentication queries | queries/users*.sql | planned |
| CR-205 | Organizations and members queries | queries/organizations*.sql | planned |
| CR-206 | Roles and permissions queries | queries/roles*.sql | planned |
| CR-207 | Templates and versions queries | queries/templates*.sql | planned |
| CR-208 | Workspaces and builds queries | queries/workspaces*.sql | planned |
| CR-209 | Agents and metadata queries | queries/agents*.sql | planned |
| CR-210 | Workspace apps queries | queries/workspace_apps*.sql | planned |
| CR-211 | Provisioning jobs queries | queries/provisioner*.sql | planned |
| CR-212 | Notifications queries | queries/notifications*.sql | planned |
| CR-213 | Audit log queries | queries/audit*.sql | planned |
| CR-214 | AI providers and tasks queries | queries/ai*.sql | planned |
| CR-215 | Tailnet and DERP queries | queries/tailnet*.sql | planned |
| CR-216 | Files and gitsshkey queries | queries/files*.sql | planned |
| CR-217 | dbgen test fixtures | `coderd/database/dbgen/` | planned |
| CR-218 | Wave 2 migration integration test | full persistence | planned |

## Wave 3: Control Plane Core (sample)

| ID | Title | Source Scope | Status |
|----|-------|--------------|--------|
| CR-301 | httpx response helpers | `coderd/httpapi/` | planned |
| CR-302 | httppipeline middleware | `coderd/httpmw/` | planned |
| CR-303 | policy engine (RBAC) | `coderd/rbac/` | planned |
| CR-304 | accessgate integration | `coderd/database/dbauthz/` usage | planned |
| CR-305 | Server bootstrap and routing | `coderd/coderd.go` | planned |
| CR-306 | User authentication handlers | `coderd/userauth.go` | planned |
| CR-307 | API key management | `coderd/apikey/` | planned |
| CR-308 | OAuth2 provider | `coderd/oauth2provider/` | planned |
| CR-309 | External auth (OIDC/Git) | `coderd/externalauth/` | planned |
| CR-310 | Health checks | `coderd/healthcheck/` | planned |
| CR-311 | Prometheus metrics | `coderd/prometheusmetrics/` | planned |
| CR-312 | Pubsub infrastructure | `coderd/pubsub/` | planned |
| CR-313 | Tracing | `coderd/tracing/` | planned |
| CR-314 | Runtime config | `coderd/runtimeconfig/` | planned |
| CR-315 | Audit handler wiring | `coderd/audit/` | planned |
| CR-316 | testkit server harness | `coderd/coderdtest/` | planned |
| CR-317 | OIDC test fixtures | `coderd/coderdtest/oidctest/` | planned |
| CR-318 | Crypto keys | `coderd/cryptokeys/` | planned |
| CR-319 | User password utilities | `coderd/userpassword/` | planned |
| CR-320 | IDP sync | `coderd/idpsync/` | planned |
| CR-321 | Wave 3 auth integration test | auth flow E2E | planned |
| CR-322 | Wave 3 server smoke test | server boot | planned |

## Waves 4-13

Detailed tickets for remaining waves are in their respective folders:

- [wave-04-control-plane-features/](wave-04-control-plane-features/) — CR-401 through CR-428
- [wave-05-provisioning/](wave-05-provisioning/) — CR-501 through CR-514
- [wave-06-agent/](wave-06-agent/) — CR-601 through CR-616
- [wave-07-networking/](wave-07-networking/) — CR-701 through CR-710
- [wave-08-cli/](wave-08-cli/) — CR-801 through CR-814
- [wave-09-enterprise/](wave-09-enterprise/) — CR-901 through CR-918
- [wave-10-frontend/](wave-10-frontend/) — CR-1001 through CR-1024
- [wave-11-extensions/](wave-11-extensions/) — CR-1101 through CR-1110
- [wave-12-deploy-ops/](wave-12-deploy-ops/) — CR-1201 through CR-1208
- [wave-13-verification/](wave-13-verification/) — CR-1301 through CR-1306

See [WAVES-04-13.md](WAVES-04-13.md) for full ticket definitions.
