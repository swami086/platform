#!/usr/bin/env bash
# Build the anvil binary (fat includes all packages; slim is default trim).
set -euo pipefail

MODE="${1:-fat}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="$ROOT/build"
BIN="$OUT_DIR/anvil"

mkdir -p "$OUT_DIR"

# shellcheck source=scripts/version.sh
source "$ROOT/scripts/version.sh"

LDFLAGS="-X github.com/swami086/platform/buildmeta.Version=${Version}"
LDFLAGS="${LDFLAGS} -X github.com/swami086/platform/buildmeta.Commit=${Commit}"
LDFLAGS="${LDFLAGS} -X github.com/swami086/platform/buildmeta.BuildTime=${BuildTime}"

if [[ "$MODE" == "slim" ]]; then
  LDFLAGS="${LDFLAGS} -s -w"
fi

cd "$ROOT"
go build -ldflags "$LDFLAGS" -o "$BIN" ./cmd/anvil

echo "built $BIN ($MODE)" >&2
