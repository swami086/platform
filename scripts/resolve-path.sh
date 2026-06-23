#!/usr/bin/env bash
# Resolve a Coder_OSS source path to its cleanroom target path.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAPPING="${SCRIPT_DIR}/../docs/path-mapping.json"
SOURCE_PATH="${1:?Usage: resolve-path.sh <source-path>}"

if [[ ! -f "$MAPPING" ]]; then
  echo "error: path-mapping.json not found at $MAPPING" >&2
  exit 1
fi

python3 - "$MAPPING" "$SOURCE_PATH" <<'PY'
import json, sys

mapping_file, source = sys.argv[1], sys.argv[2]
with open(mapping_file) as f:
    data = json.load(f)

best = None
for entry in sorted(data["mappings"], key=lambda e: -len(e["source"])):
    if source.startswith(entry["source"]):
        best = entry
        break

if not best:
    print(f"unmapped:{source}")
    sys.exit(2)

target = source.replace(best["source"], best["target"], 1)
print(target)
PY
