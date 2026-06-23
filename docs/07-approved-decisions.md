# Approved Decisions (2026-06-23)

| Decision | Status | Value |
|----------|--------|-------|
| Project codename | **Approved** | `anvil` |
| Go module path | **Approved** | `github.com/anvil/platform` |
| GitHub repository | **Created** | https://github.com/swami086/platform |
| License | **Approved** | GNU AGPL v3.0 (original work, see NOTICE.md) |
| Derivative status | **Approved** | New source code is **not** labeled derivative of Coder_OSS |
| API compatibility | **Approved** | External REST/gRPC contracts unchanged; internals fully rewritten |
| Enterprise scope | **Approved** | Full parity included |
| Wave 0 start | **Deferred** | Do not begin until explicitly requested |

## GitHub Module Path Note

The Go module is `github.com/anvil/platform`. The repository is hosted at `https://github.com/swami086/platform` until an `anvil` GitHub organization is created. After org creation, either:

1. Transfer the repository to `anvil/platform`, or
2. Create `anvil/platform` and update the remote

Then add the `go-import` meta tag if the module path and hosting URL differ during transition.

## Next Action When Ready

Reply **start wave 0** to begin CR-001 through CR-008 implementation.
