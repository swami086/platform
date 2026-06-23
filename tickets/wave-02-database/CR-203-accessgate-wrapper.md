# CR-203: accessgate Authorization Wrapper

| Field | Value |
|-------|-------|
| **Wave** | 2 |
| **Batch** | A |
| **Skill** | senior-security + senior-backend |
| **Status** | planned |
| **Depends on** | CR-201, CR-202 |
| **Blocks** | CR-304, all Wave 3+ |

## Objective

Rewrite `dbauthz` as `accessgate`: wraps persistence store with RBAC checks before every query.

## Torbit Pre-Batch

```sql
SELECT file_path, name, definition_type
FROM gl_definition
WHERE project_id = 6923339167500771290
  AND file_path LIKE 'coderd/database/dbauthz/%'
ORDER BY file_path;
```

Expected: ~93 import references to dbauthz across coderd.

## Source Scope

- `coderd/database/dbauthz/` (all `.go` files)
- `coderd/database/dbauthz/dbauthz.go` (primary wrapper)

## Target Files

| Action | Path |
|--------|------|
| Create | `persistence/accessgate/gate.go` |
| Create | `persistence/accessgate/gate_test.go` |
| Create | `persistence/accessgate/context.go` |
| Create | `persistence/accessgate/system.go` |
| Create | `persistence/accessgate/errors.go` |

## Key Types (cleanroom names)

| Source | Target |
|--------|--------|
| `dbauthz.Authorizer` | `accessgate.Enforcer` |
| `dbauthz.AsSystemRestricted` | `accessgate.WithSystemElevated` |
| `dbauthz.RejectUnauthorized` | `accessgate.DenyUnlessGranted` |
| `dbauthz.Wrap` | `accessgate.GuardStore` |

## Behavioral Requirements

- Every store method checks RBAC before DB call
- System context bypass is explicit and auditable
- OAuth2 endpoints using system access must use elevated context
- Error messages are distinct wording from source

## Acceptance Criteria

- [ ] All dbauthz store methods have accessgate equivalents
- [ ] Tests cover: authorized, unauthorized, system elevated
- [ ] No copy-paste from dbauthz source
- [ ] `make test RUN=TestAccessgate` passes

## Verification

Torbit: compare method count on dbauthz vs accessgate definitions.

Dissimilarity: run on paired files, threshold 0.15.
