#!/usr/bin/env bash
# Re-index cleanroom-platform after each ticket (Torbit MCP index tool).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Torbit MCP: index(path=\"${REPO_ROOT}\")"
echo "Re-index after every ticket and every 4-ticket batch (see docs/05-execution-model.md)."

if command -v torbit >/dev/null 2>&1; then
  torbit index "$REPO_ROOT"
else
  echo "CLI not installed; invoke Torbit MCP index tool from the agent runtime." >&2
  exit 0
fi
