#!/usr/bin/env bash
# Print Torbit SQL baselines for a source tree prefix (run queries via Torbit MCP).
set -euo pipefail

PREFIX="${1:-}"
if [[ -z "$PREFIX" ]]; then
  echo "usage: torbit-baseline.sh <path-prefix>" >&2
  echo "example: torbit-baseline.sh coderd/httpapi/" >&2
  exit 1
fi

PROJECT_ID="${TORBIT_SOURCE_PROJECT_ID:-6923339167500771290}"

cat <<EOF
# Torbit MCP run_sql queries for prefix: ${PREFIX}
# Source project_id: ${PROJECT_ID}

## 1) File count
SELECT COUNT(*) AS file_count
FROM gl_file
WHERE project_id = ${PROJECT_ID}
  AND path LIKE '${PREFIX}%';

## 2) Definitions by type
SELECT definition_type, COUNT(*) AS def_count
FROM gl_definition
WHERE project_id = ${PROJECT_ID}
  AND file_path LIKE '${PREFIX}%'
GROUP BY definition_type
ORDER BY def_count DESC;

## 3) Top import paths
SELECT import_path, COUNT(*) AS usage
FROM gl_imported_symbol
WHERE project_id = ${PROJECT_ID}
  AND file_path LIKE '${PREFIX}%'
GROUP BY import_path
ORDER BY usage DESC
LIMIT 20;
EOF
