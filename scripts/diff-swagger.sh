#!/usr/bin/env bash
# Compare two OpenAPI/swagger JSON files for breaking public API changes.
set -euo pipefail

LEFT="${1:?usage: diff-swagger.sh baseline.json candidate.json}"
RIGHT="${2:?usage: diff-swagger.sh baseline.json candidate.json}"

python3 - "$LEFT" "$RIGHT" <<'PY'
import json
import sys

left_path, right_path = sys.argv[1], sys.argv[2]

with open(left_path) as f:
    left = json.load(f)
with open(right_path) as f:
    right = json.load(f)

left_paths = left.get("paths", {})
right_paths = right.get("paths", {})

removed = sorted(set(left_paths) - set(right_paths))
added = sorted(set(right_paths) - set(left_paths))

breaking = []
for path in sorted(set(left_paths) & set(right_paths)):
    left_methods = set(left_paths[path].keys())
    right_methods = set(right_paths[path].keys())
    missing_methods = sorted(left_methods - right_methods)
    if missing_methods:
        breaking.append({"path": path, "missing_methods": missing_methods})

report = {
    "removed_paths": removed,
    "added_paths": added,
    "paths_with_missing_methods": breaking,
    "breaking_change_count": len(removed) + len(breaking),
}

print(json.dumps(report, indent=2))

if report["breaking_change_count"] > 0:
    sys.exit(1)
PY
