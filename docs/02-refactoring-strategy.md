# Refactoring Strategy

## 1. Three Approaches Considered

### Approach A: Big-Bang Rewrite (Rejected)

Rewrite entire codebase in one branch, swap at cutover.

| Pros | Cons |
|------|------|
| Single integration point | 12+ months blocked; no incremental validation |
| No dual-maintenance | Highest risk of silent behavioral drift |

### Approach B: Strangler Fig with Compatibility Shim (Rejected)

Run new services alongside old, proxy between them.

| Pros | Cons |
|------|------|
| Incremental rollout | Requires maintaining two codebases indefinitely |
| Lower cutover risk | Violates "code should not look similar" (shim copies patterns) |

### Approach C: Wave-Based Cleanroom with Contract Tests (Recommended)

Build `cleanroom-platform/src/` as a standalone tree. Validate each wave via contract tests + Torbit graph comparison. Cut over when Wave 13 passes.

| Pros | Cons |
|------|------|
| Parallel subagent batches per wave | Requires disciplined wave gates |
| Torbit verifies structural parity | Temporary dual-tree during development |
| Contract tests catch API drift early | Long calendar time |

**Recommendation:** Approach C.

## 2. Naming Vocabulary Map

Consistent renaming prevents accidental similarity:

| Source Term | Cleanroom Term |
|-------------|----------------|
| `coder` / `coderd` | `anvil` / `controlplane` |
| `codersdk` | `clientsdk` |
| `workspace` | `devbox` (internal code only; API keeps `workspace`) |
| `template` | `blueprint` (internal); API keeps `template` |
| `provisionerd` | `orchestrator` |
| `provisioner` | `executor` |
| `agent` | `runner` (internal); API keeps `agent` |
| `tailnet` | `mesh` |
| `site` | `console` |
| `enterprise` | `premium` |
| `dbauthz` | `accessgate` |
| `httpmw` | `httppipeline` |
| `wsbuilder` | `devboxcomposer` |

**Rule:** User-facing strings (CLI, API JSON keys, env vars) stay unchanged. Internal Go/TS identifiers use the cleanroom vocabulary.

## 3. Code Rewrite Patterns

### Go

| Pattern | Source Style | Cleanroom Style |
|---------|--------------|-----------------|
| Error handling | `xerrors.Errorf` wrapping | `fmt.Errorf` with `%w` + typed sentinel errors |
| HTTP handlers | Methods on `API` struct | Handler structs per domain with injected deps |
| Database access | Direct store calls in handlers | Repository interfaces per aggregate |
| Options | Functional options on constructors | Explicit config structs |
| Tests | `coderdtest.New` | `testkit.BootServer` with builder pattern |

### TypeScript

| Pattern | Source Style | Cleanroom Style |
|---------|--------------|-----------------|
| Data fetching | react-query hooks in `api/queries/` | Feature-colocated hooks in `features/*/data/` |
| Components | Mixed MUI/shadcn | shadcn-only (complete MUI removal during rewrite) |
| Styling | Emotion + Tailwind coexistence | Tailwind-only |
| Stories | `*.stories.tsx` co-located | Same convention, new story names |

### SQL

- Rewrite query text with equivalent joins/filters
- Rename query constants (`-- name: GetUser` → `-- name: FetchAccountByID`)
- Preserve column aliases expected by application layer

## 4. Library Policy

### Retain unchanged

Libraries where replacement risk exceeds benefit:

- `tailscale.com` (Coder fork), `gvisor.dev` (Coder fork)
- PostgreSQL driver (`github.com/lib/pq` or `pgx`)
- `github.com/go-chi/chi`
- Protocol Buffers / gRPC stack
- Terraform core integration

### Upgrade during rewrite

| Library | Current | Target | Rationale |
|---------|---------|--------|-----------|
| `golang.org/x/xerrors` | heavy use (310 imports) | std `errors` + `fmt` | Deprecated pattern; simplify |
| Error logging | mixed | unified `log/slog` adapter | Consistency |
| Frontend MUI | partial | remove entirely | Already deprecated upstream |

### Evaluate per-wave (Firecrawl research)

- React Query version alignment
- Biome vs additional lint rules
- OAuth2 library (`github.com/ory/fosite` or equivalent)

## 5. Dissimilarity Enforcement

Wave 13 introduces CI check:

```bash
# scripts/check-dissimilarity.sh
# Compare token n-grams between source and cleanroom file pairs
# Fail if overlap > 15% for any file > 50 LOC
```

Manual review checklist per PR:

- [ ] No identical function bodies > 3 lines
- [ ] No identical comment blocks
- [ ] Different struct field ordering where safe
- [ ] Different test table names and fixture builders

## 6. Root Cause Discipline

When behavioral bugs surface during rewrite:

1. Reproduce with failing test in cleanroom tree
2. Trace via Torbit CALLS/IMPORTS edges to find divergence
3. Fix the implementation, not a compatibility shim
4. Document root cause in ticket closure

No `// TODO: fix later`, no feature flags to hide broken behavior.
