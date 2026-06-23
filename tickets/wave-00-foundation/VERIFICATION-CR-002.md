# VERIFICATION-CR-002

## Ticket
CR-002: Makefile and build pipeline

## Torbit
- Definitions in buildmeta: Info, Version vars
- Files: Makefile, build.sh, version.sh, cmd/anvil/main.go indexed

## Commands
- `make build`: PASS → `build/anvil`
- `./build/anvil --version`: `anvil 0.0.0-dev (d90a1f3)`
- `make test`: PASS

## Root Cause Fixed
version.sh originally printed KEY=value lines; build.sh sourced them without binding. Fixed by exporting shell variables directly.
