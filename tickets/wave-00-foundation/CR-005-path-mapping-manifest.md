# CR-005: Source-to-Cleanroom Path Mapping

| Field | Value |
|-------|-------|
| **Wave** | 0 |
| **Batch** | A |
| **Skill** | senior-architect |
| **Status** | planned |
| **Depends on** | CR-001 |

## Objective

Machine-readable mapping file used by dissimilarity checker and subagent prompts.

## Files to Create

| Action | Path |
|--------|------|
| Create | `docs/path-mapping.json` |
| Create | `scripts/resolve-path.sh` |

## path-mapping.json Structure

```json
{
  "mappings": [
    {"source": "coderd/", "target": "controlplane/", "wave": 3},
    {"source": "coderd/database/", "target": "persistence/", "wave": 2},
    {"source": "codersdk/", "target": "clientsdk/", "wave": 1},
    {"source": "agent/", "target": "workspace-agent/", "wave": 6},
    {"source": "cli/", "target": "terminal/", "wave": 8},
    {"source": "site/", "target": "console/", "wave": 10},
    {"source": "enterprise/", "target": "premium/", "wave": 9},
    {"source": "tailnet/", "target": "mesh/", "wave": 7},
    {"source": "provisionerd/", "target": "orchestrator/", "wave": 5},
    {"source": "provisioner/", "target": "executor/", "wave": 5},
    {"source": "provisionersdk/", "target": "executor-sdk/", "wave": 5},
    {"source": "aibridge/", "target": "ai-gateway/", "wave": 11},
    {"source": "forge/", "target": "extensions/", "wave": 11},
    {"source": "scaletest/", "target": "loadtest/", "wave": 11},
    {"source": "vpn/", "target": "tunnel/", "wave": 7},
    {"source": "pty/", "target": "terminal-pty/", "wave": 6},
    {"source": "testutil/", "target": "testkit/", "wave": 1},
    {"source": "buildinfo/", "target": "buildmeta/", "wave": 1}
  ]
}
```

## Acceptance Criteria

- [ ] Every top-level Go package from Torbit inventory has a mapping entry
- [ ] `scripts/resolve-path.sh coderd/rbac/acl.go` prints cleanroom path
- [ ] JSON validates

## Verification

```bash
./cleanroom-platform/scripts/resolve-path.sh coderd/database/queries/users.sql
# Expected: persistence/queries/users.sql
```
