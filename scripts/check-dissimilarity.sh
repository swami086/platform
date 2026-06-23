#!/usr/bin/env bash
# Fail when cleanroom files are too similar to reference source.
set -euo pipefail

SOURCE=""
TARGET=""
THRESHOLD="0.15"
MAPPING=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source) SOURCE="$2"; shift 2 ;;
    --target) TARGET="$2"; shift 2 ;;
    --threshold) THRESHOLD="$2"; shift 2 ;;
    --mapping) MAPPING="$2"; shift 2 ;;
    *) echo "unknown arg: $1" >&2; exit 1 ;;
  esac
done

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PY="$ROOT/scripts/lib/tokenize.py"

if [[ -n "$MAPPING" ]]; then
  python3 - "$MAPPING" "$THRESHOLD" "$PY" <<'PY'
import json, subprocess, sys
from pathlib import Path

mapping_path, threshold, py = sys.argv[1], sys.argv[2], sys.argv[3]
root = Path(mapping_path).resolve().parent.parent
with open(mapping_path) as f:
    data = json.load(f)

source_root = Path(data["source_repo"])
exit_code = 0
for entry in data["mappings"]:
    src_dir = source_root / entry["source"]
    tgt_dir = root / data.get("target_root", "src/") / entry["target"]
    if not src_dir.exists() or not tgt_dir.exists():
        continue
    proc = subprocess.run(
        ["python3", py, "--source", str(src_dir), "--target", str(tgt_dir), "--threshold", threshold],
        capture_output=True,
        text=True,
    )
    print(proc.stdout)
    if proc.returncode != 0:
        exit_code = 1
raise SystemExit(exit_code)
PY
  exit $?
fi

if [[ -z "$SOURCE" || -z "$TARGET" ]]; then
  echo "usage: check-dissimilarity.sh --source DIR --target DIR [--threshold 0.15]" >&2
  echo "   or: check-dissimilarity.sh --mapping docs/path-mapping.json" >&2
  exit 1
fi

python3 "$PY" --source "$SOURCE" --target "$TARGET" --threshold "$THRESHOLD"
