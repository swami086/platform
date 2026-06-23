#!/usr/bin/env bash
# Post-batch verification queries for cleanroom-platform (Torbit MCP).
set -euo pipefail

PREFIX="${1:-src/}"
PROJECT_ID="${TORBIT_TARGET_PROJECT_ID:-8285163519732299791}"

cat <<EOF
# Torbit MCP run_sql post-batch verification
# Target project_id: ${PROJECT_ID}
# Prefix: ${PREFIX}

## Definition coverage
SELECT file_path, name, definition_type
FROM gl_definition
WHERE project_id = ${PROJECT_ID}
  AND file_path LIKE '${PREFIX}%'
ORDER BY file_path, start_line;

## Import graph counts
SELECT relationship_kind, COUNT(*) AS edge_count
FROM gl_edge e
JOIN gl_file f ON e.source_id = f.id
WHERE f.project_id = ${PROJECT_ID}
  AND f.path LIKE '${PREFIX}%'
GROUP BY relationship_kind;
EOF
