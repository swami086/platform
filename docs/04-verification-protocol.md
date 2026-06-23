# Verification Protocol

Every ticket batch MUST complete this protocol before closure.

## Pre-Batch (Torbit)

### 1. Identify source scope

```sql
-- Replace PATH_PREFIX with subsystem, e.g. 'coderd/rbac/'
SELECT path, language, name
FROM gl_file
WHERE project_id = 6923339167500771290
  AND path LIKE 'PATH_PREFIX%'
ORDER BY path
LIMIT 200;
```

### 2. Map definitions to rewrite

```sql
SELECT file_path, name, definition_type, start_line, end_line
FROM gl_definition
WHERE project_id = 6923339167500771290
  AND file_path LIKE 'PATH_PREFIX%'
  AND definition_type IN ('Function', 'Method', 'Struct', 'Interface')
ORDER BY file_path, start_line;
```

### 3. Map import dependencies

```sql
SELECT i.import_path, i.identifier_name, COUNT(*) as refs
FROM gl_imported_symbol i
WHERE i.project_id = 6923339167500771290
  AND i.file_path LIKE 'PATH_PREFIX%'
GROUP BY i.import_path, i.identifier_name
ORDER BY refs DESC
LIMIT 50;
```

### 4. Record baseline metrics

Store in ticket notes:

- Source file count
- Definition count by type
- Import edge count

## Post-Batch (Torbit)

### 1. Re-index cleanroom tree

```
index(path="/Users/swami/Documents/platform")
```

### 2. Verify target files exist

```sql
SELECT path, language
FROM gl_file
WHERE project_id = <NEW_PROJECT_ID>
  AND path LIKE 'controlplane/%'  -- adjust per wave
ORDER BY path;
```

### 3. Compare definition coverage

| Metric | Source | Target | Tolerance |
|--------|-------:|-------:|-----------|
| Exported functions | N | M | M >= N (may add helpers) |
| Struct types | N | M | M == N (semantic parity) |
| HTTP handlers | N | M | M == N |
| Test functions | N | M | M >= N |

### 4. Import graph sanity

```sql
SELECT relationship_kind, COUNT(*) as cnt
FROM gl_edge e
JOIN gl_file f ON e.source_id = f.id
WHERE f.project_id = <NEW_PROJECT_ID>
GROUP BY relationship_kind;
```

Expect IMPORTS and DEFINES to grow monotonically per wave.

## Test Verification

### Go packages

```bash
cd /Users/swami/Documents/platform/src
make test RUN=TestPatternForPackage
```

### Frontend

```bash
cd /Users/swami/Documents/platform/src/console
pnpm test path/to/affected
pnpm lint
```

### Integration (Waves 4+)

```bash
make test RUN=TestIntegration
```

## Contract Verification (Waves 3+)

1. Generate swagger from cleanroom control plane
2. Diff against baseline swagger captured in Wave 0
3. Fail on any removed public route or changed request/response schema

## Dissimilarity Check

```bash
/Users/swami/Documents/platform/scripts/check-dissimilarity.sh \
  --source /Users/swami/Documents/Coder_OSS \
  --target /Users/swami/Documents/platform/src \
  --map-file /Users/swami/Documents/platform/docs/path-mapping.json
```

## Failure Handling

| Failure Type | Action |
|--------------|--------|
| Missing definition | Add implementation ticket; do not stub |
| Test failure | Root-cause fix in same batch; no skip |
| Import cycle | Refactor boundaries; Torbit trace cycle |
| API drift | Revert handler; fix contract first |
| High similarity | Rewrite affected functions; re-run check |

## Verification Artifacts

Each closed ticket stores in `tickets/<wave>/VERIFICATION-<ticket-id>.md`:

- Torbit SQL outputs (baseline + post)
- Test command output (pass/fail)
- Dissimilarity score
- Reviewer sign-off
