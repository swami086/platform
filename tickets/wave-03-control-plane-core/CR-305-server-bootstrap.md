# CR-305: Server Bootstrap and Routing

| Field | Value |
|-------|-------|
| **Wave** | 3 |
| **Batch** | C |
| **Skill** | senior-architect + senior-backend |
| **Status** | planned |
| **Depends on** | CR-301, CR-302, CR-303, CR-304 |
| **Blocks** | All Wave 4 handlers |

## Objective

Rewrite the control plane server entry (`coderd.go`, 109 import edges) as composable bootstrap.

## Torbit Pre-Batch

```sql
SELECT COUNT(*) FROM gl_imported_symbol
WHERE project_id = 6923339167500771290
  AND file_path = 'coderd/coderd.go';
-- Expected: ~109
```

## Source Scope

- `coderd/coderd.go` (primary)
- `coderd/apiroot.go`
- Route registration patterns

## Target Files

| Action | Path |
|--------|------|
| Create | `controlplane/server/bootstrap.go` |
| Create | `controlplane/server/router.go` |
| Create | `controlplane/server/options.go` |
| Create | `controlplane/server/lifecycle.go` |
| Create | `controlplane/server/bootstrap_test.go` |

## Architecture Change

Source: monolithic `API` struct with methods.

Cleanroom: decomposed `Platform` struct with injected:

- `RouteRegistry`
- `MiddlewareStack` (from httppipeline)
- `PolicyEnforcer` (from policy)
- `GuardedStore` (from accessgate)

Route registration split by domain files in Wave 4.

## Acceptance Criteria

- [ ] Server boots with chi router
- [ ] `/healthz` and `/api/v2/` root respond
- [ ] Swagger annotations present on stub routes
- [ ] Import count in bootstrap.go < 40 (deferred to handler packages)
- [ ] Dissimilarity vs coderd.go < 0.15

## Verification

```bash
make test RUN=TestBootstrap
make build && ./build/anvil server --port 19998 &
curl -s http://localhost:19998/api/v2/
```

Swagger diff: no regressions vs baseline for existing routes.

## Root Cause Note

Do not stub missing handlers with 501. Register routes only when handler package exists, or return proper `ErrNotImplemented` with RFC7807-style body from httpx.
