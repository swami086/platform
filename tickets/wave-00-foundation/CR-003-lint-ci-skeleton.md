# CR-003: Lint and CI Skeleton

| Field | Value |
|-------|-------|
| **Wave** | 0 |
| **Batch** | B |
| **Skill** | senior-devops |
| **Status** | planned |
| **Depends on** | CR-001, CR-002 |
| **Blocks** | Wave 1 |

## Objective

Establish golangci-lint config and GitHub Actions workflow skeleton for cleanroom CI.

## Files to Create

| Action | Path |
|--------|------|
| Create | `src/.golangci.yaml` |
| Create | `.github/workflows/cleanroom-ci.yaml` |
| Create | `src/.editorconfig` |
| Create | `src/biome.json` (placeholder for Wave 10) |

## CI Workflow Stages

1. Checkout
2. Setup Go 1.26
3. `make fmt` (check mode)
4. `make lint`
5. `make test`
6. `make build`

## Acceptance Criteria

- [ ] golangci-lint runs on empty packages
- [ ] CI workflow validates on push to `cleanroom/**` branches
- [ ] No reference to Coder_OSS paths in CI
- [ ] Em dash linter rule documented for future waves

## Verification

```bash
cd cleanroom-platform/src && make lint
```

Local act simulation optional; workflow YAML must be valid.
