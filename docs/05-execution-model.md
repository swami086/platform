# Execution Model

## Subagent Parallel Batching

### Batch sizing rules

| Constraint | Value |
|------------|-------|
| Max concurrent subagents | 4 |
| Max files per subagent | 8 |
| Max LOC per subagent | 2,000 |
| Min Torbit re-index interval | After every batch |

### Subagent prompt template

Each dispatched subagent receives:

```
Full Repository Path: /Users/swami/Documents/platform/src
Ticket: CR-XXX
Wave: N
Source scope (read-only): <torbit file list>
Target files (create/modify): <exact paths>
Engineering skill: senior-backend | senior-frontend | ...
Constraints:
  - Clean-room rewrite per docs/02-refactoring-strategy.md
  - No copy from Coder_OSS source
  - Torbit verify before marking complete
  - Root cause fixes only
Deliverables:
  - Implementation files
  - Tests
  - VERIFICATION-CR-XXX.md
```

### Orchestration flow

```
Plan approved
    → Wave N kickoff
    → Torbit pre-batch queries for ticket group
    → Dispatch 4 parallel subagents (tickets A,B,C,D)
    → Collect results + verification artifacts
    → Code review subagent (code-reviewer skill)
    → Torbit re-index
    → Human wave checkpoint (if gate)
    → Next ticket group
```

## Torbit Index Cadence

| Event | Action |
|-------|--------|
| Wave 0 complete | Initial index of `/Users/swami/Documents/platform` |
| Every 4 tickets | Re-index |
| Every wave boundary | Full re-index + manifest snapshot |
| Wave 13 | Final index + parity report |

```sql
-- Track indexing status
SELECT repo_path, status, last_indexed_at, commit_sha
FROM _orbit_manifest
WHERE repo_path LIKE '%/platform%';
```

## Engineering Skills per Wave

| Wave | Primary Skill | Review Skill |
|------|---------------|--------------|
| 0 | senior-devops | code-reviewer |
| 1 | senior-backend | code-reviewer |
| 2 | senior-backend + DATABASE patterns | senior-security |
| 3 | senior-backend + senior-security | code-reviewer |
| 4 | senior-fullstack | code-reviewer |
| 5 | senior-backend | code-reviewer |
| 6 | senior-backend | code-reviewer |
| 7 | senior-architect | code-reviewer |
| 8 | senior-fullstack | code-reviewer |
| 9 | senior-security | code-reviewer |
| 10 | senior-frontend | code-reviewer |
| 11 | senior-fullstack | code-reviewer |
| 12 | senior-devops | code-reviewer |
| 13 | senior-qa | code-reviewer |

## Firecrawl Usage

Trigger Firecrawl MCP when ticket tags include `research`:

- Library version compatibility
- Security CVE checks
- OAuth2/RFC reference validation

Record findings in ticket notes before implementation.

## Git Workflow

- Branch: `cleanroom/wave-N-<ticket-id>`
- Commit format: `refactor(<scope>): <message>`
- Scope = cleanroom path (e.g., `controlplane/auth`)
- Hooks mandatory; no `--no-verify`
- Merge to `cleanroom/main` only after verification passes

## Session Structure (per working session)

1. Read wave ticket index
2. Torbit pre-batch (3 SQL queries minimum)
3. Dispatch subagents
4. Await completion notifications
5. Run verification protocol
6. Update TICKET-INDEX.md status
7. Report to user at wave gate

## Estimated Timeline

| Phase | Calendar (1 agent + 4 subagents) |
|-------|----------------------------------|
| Waves 0-2 | 4-6 weeks |
| Waves 3-4 | 6-8 weeks |
| Waves 5-8 | 4-6 weeks |
| Waves 9-11 | 4-6 weeks |
| Wave 10 (frontend) | 6-8 weeks (parallel with 9) |
| Wave 12-13 | 2-3 weeks |
| **Total** | **~6-9 months** |

Accelerated with dedicated human team: ~3-4 months.
