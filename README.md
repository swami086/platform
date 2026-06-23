# Anvil Platform

> **Status:** Wave 0 complete — ready for Wave 1 (shared libraries).

Anvil Platform (`github.com/swami086/platform`) is an independent clean-room implementation of a remote development environment control plane.

**Repository:** https://github.com/swami086/platform

## Approved Scope (2026-06-23)

| Item | Decision |
|------|----------|
| Codename | `anvil` |
| Go module | `github.com/swami086/platform` |
| License | GNU AGPL v3.0 ([LICENSE](LICENSE), [NOTICE.md](NOTICE.md)) |
| Legal posture | Original work; **not** labeled derivative of Coder_OSS |
| API compatibility | External REST/gRPC contracts unchanged; internals fully rewritten |
| Enterprise | Full parity included |
| Wave 0 start | **Complete** | CR-001 through CR-008 |

## Planning Documents

| Document | Description |
|----------|-------------|
| [docs/07-approved-decisions.md](docs/07-approved-decisions.md) | Locked decisions and GitHub notes |
| [docs/00-charter.md](docs/00-charter.md) | Goals, constraints, success criteria |
| [docs/01-architecture-inventory.md](docs/01-architecture-inventory.md) | Torbit-derived subsystem map |
| [docs/02-refactoring-strategy.md](docs/02-refactoring-strategy.md) | Clean-room rules and naming |
| [docs/03-phase-plan.md](docs/03-phase-plan.md) | 13 waves, 208 tickets |
| [docs/04-verification-protocol.md](docs/04-verification-protocol.md) | Torbit verification per batch |
| [docs/05-execution-model.md](docs/05-execution-model.md) | Subagent parallel batching |
| [docs/06-library-evaluation-matrix.md](docs/06-library-evaluation-matrix.md) | Dependency decisions |
| [tickets/TICKET-INDEX.md](tickets/TICKET-INDEX.md) | Master ticket registry |

## Implementation Location (when Wave 0 starts)

```
src/
```

Planning and contracts live at the repository root. Implementation code lands under `src/` per wave tickets.

## Scale Estimate

~1,530 Go files, ~1,856 TypeScript files, 208 tickets across 13 waves. See [docs/03-phase-plan.md](docs/03-phase-plan.md).

## Start Implementation

Wave 0 is complete. Reply **start wave 1** to execute CR-101 through CR-112 (shared libraries).
