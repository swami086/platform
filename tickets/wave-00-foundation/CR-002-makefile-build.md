# CR-002: Makefile and Build Pipeline

| Field | Value |
|-------|-------|
| **Wave** | 0 |
| **Batch** | A |
| **Skill** | senior-devops |
| **Status** | planned |
| **Depends on** | CR-001 |
| **Blocks** | CR-004, CR-003 |

## Objective

Rewrite build toolchain with equivalent targets: `build`, `build-slim`, `test`, `lint`, `fmt`, `gen`, `clean`.

## Source Reference

Study (do not copy) `/Users/swami/Documents/Coder_OSS/Makefile` target names only.

## Files to Create

| Action | Path |
|--------|------|
| Create | `src/Makefile` |
| Create | `src/scripts/build.sh` |
| Create | `src/scripts/version.sh` |

## Required Make Targets

```makefile
.PHONY: build build-slim test lint fmt gen clean pre-commit

build:
	@./scripts/build.sh fat

build-slim:
	@./scripts/build.sh slim

test:
	go test ./...

lint:
	golangci-lint run ./...

fmt:
	gofmt -w .

gen:
	@echo "gen: sqlc/swagger placeholders for Wave 2+"

clean:
	rm -rf build/
```

## Acceptance Criteria

- [ ] `make build` compiles stub binary to `build/anvil`
- [ ] `make test` runs (passes with doc.go packages only)
- [ ] `make lint` runs without config errors
- [ ] Target names match upstream for developer muscle memory

## Verification

```bash
cd cleanroom-platform/src && make build && ./build/anvil --version
```

Expected: version string from buildmeta stub.
