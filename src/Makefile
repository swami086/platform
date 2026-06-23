.PHONY: build build-slim test lint fmt gen clean pre-commit fmt-check

RUN ?=

build:
	@./scripts/build.sh fat

build-slim:
	@./scripts/build.sh slim

test:
	@if [ -n "$(RUN)" ]; then go test ./... -run "$(RUN)" -count=1; else go test ./... -count=1; fi

lint:
	@command -v golangci-lint >/dev/null || (echo "install: go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.64.8" && exit 1)
	golangci-lint run ./...

fmt:
	gofmt -w .

fmt-check:
	@test -z "$$(gofmt -l .)" || (gofmt -l . && exit 1)

gen:
	@echo "gen: sqlc and swagger generation land in Wave 2+"

clean:
	rm -rf build/

pre-commit: fmt-check lint test build
