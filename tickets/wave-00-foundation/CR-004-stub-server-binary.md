# CR-004: Stub Anvil Server Binary

| Field | Value |
|-------|-------|
| **Wave** | 0 |
| **Batch** | B |
| **Skill** | senior-backend |
| **Status** | planned |
| **Depends on** | CR-001, CR-002 |
| **Blocks** | CR-006 |

## Objective

Create minimal HTTP server stub proving the build pipeline end-to-end.

## Source Reference (Torbit)

```sql
SELECT file_path, name FROM gl_definition
WHERE project_id = 6923339167500771290
  AND file_path = 'cmd/coder/main.go'
  AND name = 'main';
```

## Files to Create

| Action | Path |
|--------|------|
| Create | `src/cmd/anvil/main.go` |
| Create | `src/controlplane/server/stub.go` |
| Create | `src/buildmeta/version.go` |
| Create | `src/controlplane/server/stub_test.go` |

## Implementation Sketch

`main.go` boots chi router with:

- `GET /healthz` → 200 `{"status":"ok"}`
- `GET /api/v2/buildinfo` → version JSON

Use different struct names: `BootOptions`, `ServeStub`, not `Options`, `Start`.

## Acceptance Criteria

- [ ] `./build/anvil server --port 8080` starts HTTP server
- [ ] `/healthz` returns 200
- [ ] Test covers health endpoint with `httptest`
- [ ] Zero imports from coder module

## Verification

```bash
cd cleanroom-platform/src
make build
./build/anvil server --port 19999 &
curl -s http://localhost:19999/healthz
make test RUN=TestStubHealth
```

Torbit: verify `controlplane/server/stub.go` definitions exist.
