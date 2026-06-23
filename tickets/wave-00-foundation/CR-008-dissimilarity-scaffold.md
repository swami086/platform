# CR-008: Dissimilarity Check Script Scaffold

| Field | Value |
|-------|-------|
| **Wave** | 0 |
| **Batch** | B |
| **Skill** | senior-backend |
| **Status** | planned |
| **Depends on** | CR-005 |

## Objective

Scaffold automated similarity detection between source and cleanroom file pairs.

## Files to Create

| Action | Path |
|--------|------|
| Create | `scripts/check-dissimilarity.sh` |
| Create | `scripts/lib/tokenize.py` |

## Algorithm

1. Load `path-mapping.json`
2. For each mapping, pair source `.go`/`.ts` files by relative path
3. Tokenize (lowercase, split on non-alphanumeric)
4. Compute 5-gram Jaccard similarity
5. Fail if any file > 50 LOC has similarity > 0.15

## Acceptance Criteria

- [ ] Script runs on Wave 0 stub files (similarity ~0 by definition)
- [ ] Produces JSON report with per-file scores
- [ ] Exit code 1 on threshold violation
- [ ] Python script uses stdlib only (per engineering-skills convention)

## Verification

```bash
./cleanroom-platform/scripts/check-dissimilarity.sh \
  --source /Users/swami/Documents/Coder_OSS/coderd/httpapi \
  --target /Users/swami/Documents/Coder_OSS/cleanroom-platform/src/controlplane/httpx \
  --threshold 0.15
```

Expected: pass (target mostly empty) or N/A with clear message.
