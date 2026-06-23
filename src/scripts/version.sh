#!/usr/bin/env bash
# Export version metadata for ldflags (buildmeta injection).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

export Version="${ANVIL_VERSION:-0.0.0-dev}"
export Commit="$(git -C "$ROOT/.." rev-parse --short HEAD 2>/dev/null || echo unknown)"
export BuildTime="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
