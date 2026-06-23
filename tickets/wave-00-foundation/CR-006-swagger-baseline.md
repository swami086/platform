# CR-006: Capture Swagger API Baseline

| Field | Value |
|-------|-------|
| **Wave** | 0 |
| **Batch** | B |
| **Skill** | senior-backend |
| **Status** | planned |
| **Depends on** | CR-004 |
| **Tags** | research |

## Objective

Snapshot current public API contract for parity diffing in Waves 3+.

## Process

1. Build Coder_OSS server swagger (read-only from source tree)
2. Store normalized JSON in cleanroom-platform (contract data, not code)

## Files to Create

| Action | Path |
|--------|------|
| Create | `contracts/swagger-baseline.json` |
| Create | `scripts/diff-swagger.sh` |
| Create | `contracts/README.md` |

## Acceptance Criteria

- [ ] Baseline contains all `/api/v2/*` paths
- [ ] diff script compares two swagger files and reports breaking changes
- [ ] No Coder_OSS source code copied into contracts/

## Verification

```bash
./cleanroom-platform/scripts/diff-swagger.sh \
  contracts/swagger-baseline.json \
  contracts/swagger-baseline.json
# Expected: no differences
```

## Note

Use Firecrawl only if swagger generation documentation is needed. Prefer running upstream `make gen` in read-only mode.
