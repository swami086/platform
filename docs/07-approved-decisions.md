# Approved Decisions (2026-06-23)

| Decision | Status | Value |
|----------|--------|-------|
| Project codename | **Approved** | `anvil` |
| Go module path | **Approved** | `github.com/swami086/platform` |
| GitHub repository | **Created** | https://github.com/swami086/platform |
| License | **Approved** | GNU AGPL v3.0 (original work, see NOTICE.md) |
| Derivative status | **Approved** | New source code is **not** labeled derivative of Coder_OSS |
| API compatibility | **Approved** | External REST/gRPC contracts unchanged; internals fully rewritten |
| Enterprise scope | **Approved** | Full parity included |
| Filesystem separation | **Approved** | `/Users/swami/Documents/platform` (not inside Coder_OSS) |
| Wave 0 | **Complete** | CR-001 through CR-008 verified |

## Module and Repository

Go module path and GitHub remote are aligned:

- Disk: `/Users/swami/Documents/platform`
- Remote: https://github.com/swami086/platform

See [08-filesystem-separation.md](08-filesystem-separation.md).

## Wave 0 Exit Criteria (Gate G1)

| Check | Status |
|-------|--------|
| `make build` produces `build/anvil` | PASS |
| `make test` | PASS |
| `make lint` (golangci-lint v1.64.8) | PASS |
| Stub server `/healthz` | PASS |
| Swagger baseline (268 paths) | PASS |
| Torbit index `/Users/swami/Documents/platform` | PASS |
| Dissimilarity scaffold | PASS |

## Next Action

Reply **start wave 1** to begin shared libraries (CR-101 through CR-112).
