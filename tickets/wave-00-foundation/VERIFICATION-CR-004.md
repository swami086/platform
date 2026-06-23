# VERIFICATION-CR-004

## Ticket
CR-004: Stub anvil server binary

## Torbit Definitions (stub.go)
- BootOptions (Struct)
- ServeStub (Function)
- handleHealth, handleBuildInfo, writeJSON (Function)

## Commands
- `make build`: PASS
- `make test RUN=TestStub`: PASS
- `curl /healthz`: `{"status":"ok"}`
- `curl /api/v2/buildinfo`: version JSON

## Imports
No `github.com/coder/coder` imports (verified via grep in CI step).
