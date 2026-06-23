# Filesystem and Git Separation

Anvil Platform is **strictly separated** from Coder_OSS on disk and in git.

## Canonical locations

| Role | Path | Git remote |
|------|------|------------|
| **Anvil Platform (this repo)** | `/Users/swami/Documents/platform` | https://github.com/swami086/platform |
| **Reference only (read-only)** | `/Users/swami/Documents/Coder_OSS` | Upstream Coder; never commit Anvil code here |

## Rules

1. All new implementation lives in `/Users/swami/Documents/platform/src/`.
2. Do **not** recreate `Coder_OSS/cleanroom-platform/` (gitignored upstream).
3. Torbit indexes `/Users/swami/Documents/platform` for Anvil; Coder_OSS is indexed separately for reference queries.
4. `docs/path-mapping.json` `source_repo` points at Coder_OSS for clean-room path resolution only.

## Clone elsewhere

```bash
git clone https://github.com/swami086/platform.git
cd platform/src
make build
```

## Workspace setup

Open `/Users/swami/Documents/platform` as its own Cursor workspace root, separate from Coder_OSS, to avoid cross-contamination.
