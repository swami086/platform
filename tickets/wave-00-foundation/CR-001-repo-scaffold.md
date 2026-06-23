# CR-001: Repository Scaffold and go.mod

| Field | Value |
|-------|-------|
| **Wave** | 0 |
| **Batch** | A |
| **Skill** | senior-devops |
| **Status** | planned |
| **Depends on** | Plan approval |
| **Blocks** | CR-002, CR-004, all Wave 1+ |

## Objective

Create the cleanroom source tree skeleton with Go module, directory layout, and README.

## Source Reference (Torbit, read-only)

```sql
SELECT path FROM gl_file
WHERE project_id = 6923339167500771290
  AND path IN ('go.mod', 'Makefile', 'README.md')
LIMIT 10;
```

## Files to Create

| Action | Path |
|--------|------|
| Create | `src/go.mod` |
| Create | `src/README.md` |
| Create | `src/controlplane/doc.go` |
| Create | `src/clientsdk/doc.go` |
| Create | `src/persistence/doc.go` |

## go.mod Content

```go
module github.com/swami086/platform

go 1.26.4
```

## Directory Layout

```
src/
├── cmd/anvil/
├── controlplane/
├── clientsdk/
├── persistence/
├── workspace-agent/
├── orchestrator/
├── executor/
├── executor-sdk/
├── mesh/
├── terminal/
├── console/
├── premium/
├── testkit/
├── buildmeta/
└── scripts/
```

## Acceptance Criteria

- [ ] `go mod tidy` succeeds in `src/`
- [ ] All package directories exist with `doc.go`
- [ ] Module path is `github.com/swami086/platform`
- [ ] No imports from `github.com/coder/coder/v2`

## Verification

```bash
cd cleanroom-platform/src && go mod verify
```

Torbit: index path, confirm `gl_file` count >= 5.

## Engineering Notes

Use `senior-architect` naming from docs/02-refactoring-strategy.md. Do not copy any file from Coder_OSS.
