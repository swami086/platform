# CR-007: Torbit Index and Verification Scripts

| Field | Value |
|-------|-------|
| **Wave** | 0 |
| **Batch** | A |
| **Skill** | senior-devops |
| **Status** | planned |
| **Depends on** | CR-001 |

## Objective

Automate Torbit pre/post batch verification per docs/04-verification-protocol.md.

## Files to Create

| Action | Path |
|--------|------|
| Create | `scripts/torbit-baseline.sh` |
| Create | `scripts/torbit-verify-batch.sh` |
| Create | `scripts/torbit-index-cleanroom.sh` |

## torbit-baseline.sh

Accepts `--prefix coderd/rbac/` and outputs:

- File count
- Definition count by type
- Top 20 import paths

Uses Torbit MCP `run_sql` queries from verification protocol.

## torbit-index-cleanroom.sh

```bash
#!/usr/bin/env bash
# Invokes Torbit index on cleanroom-platform/src
echo "Index via Torbit MCP: index(path=cleanroom-platform/src)"
```

## Acceptance Criteria

- [ ] Scripts document exact SQL queries for manual MCP execution
- [ ] Baseline script tested against Coder_OSS `coderd/httpapi/` prefix
- [ ] Index script documents when to re-index (every 4 tickets)

## Verification

Run baseline against known prefix; output matches manual Torbit query results from planning session.
