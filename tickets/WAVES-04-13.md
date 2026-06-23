# Waves 4-13: Full Ticket Definitions

Detailed tickets for waves beyond 0-3. Each ticket follows the same structure as Wave 0 examples.

---

## Wave 4: Control Plane Features (CR-401 to CR-428)

| ID | Title | Source Files (Torbit prefix) | Target | Batch |
|----|-------|------------------------------|--------|-------|
| CR-401 | Workspace CRUD handlers | `coderd/workspaces.go` | `controlplane/handlers/workspaces.go` | A |
| CR-402 | Workspace build lifecycle | `coderd/workspacebuilds.go` | `controlplane/handlers/builds.go` | A |
| CR-403 | Workspace agent registration | `coderd/workspaceagents.go` | `controlplane/handlers/agents.go` | B |
| CR-404 | Template CRUD | `coderd/templates.go` | `controlplane/handlers/templates.go` | B |
| CR-405 | Template versions | `coderd/templateversions.go` | `controlplane/handlers/template_versions.go` | C |
| CR-406 | Template import/export | `coderd/templateimport.go`, `templateexport.go` | `controlplane/handlers/template_io.go` | C |
| CR-407 | Template builder | `coderd/templatebuilder/` (62 files, split 4 tickets) | `controlplane/blueprint/` | D |
| CR-408 | Template builder tests | `coderd/templatebuilder/*_test.go` | `controlplane/blueprint/*_test.go` | D |
| CR-409 | Devbox composer | `coderd/wsbuilder/` | `controlplane/devboxcomposer/` | A |
| CR-410 | Workspace apps proxy | `coderd/workspaceapps/` | `controlplane/appproxy/` | B |
| CR-411 | Workspace stats | `coderd/workspacestats/` | `controlplane/metrics/workspace/` | C |
| CR-412 | Schedule autostart/stop | `coderd/schedule/` | `controlplane/lifecycle/schedule/` | C |
| CR-413 | Autobuild triggers | `coderd/autobuild/` | `controlplane/lifecycle/autobuild/` | D |
| CR-414 | Prebuilds | `coderd/prebuilds/` | `controlplane/lifecycle/prebuilds/` | D |
| CR-415 | Dynamic parameters | `coderd/dynamicparameters/` | `controlplane/parameters/` | A |
| CR-416 | Files API | `coderd/files/` | `controlplane/handlers/files.go` | B |
| CR-417 | Git SSH keys | `coderd/gitsshkey/` | `controlplane/handlers/git_keys.go` | B |
| CR-418 | Notifications dispatch | `coderd/notifications/` (split 2 tickets) | `controlplane/notify/` | C |
| CR-419 | Notifications templates | `coderd/notifications/templates/` | `controlplane/notify/templates/` | C |
| CR-420 | AI providers | `coderd/ai_providers.go` | `controlplane/handlers/ai_providers.go` | D |
| CR-421 | AI tasks | `coderd/aitasks.go` | `controlplane/handlers/ai_tasks.go` | D |
| CR-422 | AI bridge daemon | `coderd/aibridged/`, `aibridgedserver/` | `controlplane/aibridge/` | A |
| CR-423 | Chat feature (chatd) | `coderd/x/chatd/` (292 files, split 3 tickets) | `controlplane/features/chat/` | B-D |
| CR-424 | Agent API gRPC | `coderd/agentapi/` | `controlplane/agentrpc/` | A |
| CR-425 | Provisioner server gRPC | `coderd/provisionerdserver/` | `controlplane/orchestration/` | B |
| CR-426 | Telemetry | `coderd/telemetry/` | `controlplane/telemetry/` | C |
| CR-427 | Usage metering | `coderd/usage/` | `controlplane/usage/` | C |
| CR-428 | Wave 4 integration: template to workspace | integration test | `controlplane/integration/` | D |

**CR-407 sub-split:** CR-407a archive provider, CR-407b variable parsing, CR-407c provisioner graph, CR-407d rich parameters.

**CR-423 sub-split:** CR-423a chat service core, CR-423b chat API handlers, CR-423c chat persistence.

---

## Wave 5: Provisioning (CR-501 to CR-514)

| ID | Title | Source | Target | Batch |
|----|-------|--------|--------|-------|
| CR-501 | Executor SDK proto | `provisionersdk/proto/` | `executor-sdk/proto/` | A |
| CR-502 | Executor SDK Go client | `provisionersdk/*.go` | `executor-sdk/` | A |
| CR-503 | Executor Terraform runner | `provisioner/` | `executor/terraform/` | B |
| CR-504 | Executor plugin interface | `provisioner/` interfaces | `executor/plugin/` | B |
| CR-505 | Orchestrator proto | `provisionerd/proto/` | `orchestrator/proto/` | C |
| CR-506 | Orchestrator runner | `provisionerd/runner/` | `orchestrator/runner/` | C |
| CR-507 | Orchestrator main service | `provisionerd/*.go` | `orchestrator/service.go` | D |
| CR-508 | Enterprise provisionerd | `enterprise/provisionerd/` | `premium/orchestrator/` | D |
| CR-509 | Provisioner job queue integration | cross-package | `controlplane/orchestration/jobs.go` | A |
| CR-510 | Terraform path utilities | `provisionersdk/tfpath/` | `executor-sdk/tfpath/` | B |
| CR-511 | Provisioner scripts | `provisionersdk/scripts/` | `executor-sdk/scripts/` | C |
| CR-512 | Provisioner integration test | test harness | `orchestrator/integration/` | D |
| CR-513 | Executor unit tests | `provisioner/*_test.go` | `executor/*_test.go` | A |
| CR-514 | Wave 5 E2E terraform round-trip | integration | `orchestrator/e2e/` | D |

---

## Wave 6: Agent (CR-601 to CR-616)

| ID | Title | Source | Target | Batch |
|----|-------|--------|--------|-------|
| CR-601 | Agent main entry | `agent/agent.go` | `workspace-agent/runner.go` | A |
| CR-602 | Agent context lifecycle | `agent/agentcontext/` | `workspace-agent/context/` | A |
| CR-603 | Agent SSH server | `agent/agentssh/` | `workspace-agent/ssh/` | B |
| CR-604 | Agent socket forwarding | `agent/agentsocket/` | `workspace-agent/sockets/` | B |
| CR-605 | Reconnecting PTY | `agent/reconnectingpty/`, `pty/` | `workspace-agent/pty/`, `terminal-pty/` | C |
| CR-606 | Agent containers | `agent/agentcontainers/` (52 files, 2 tickets) | `workspace-agent/containers/` | C-D |
| CR-607 | Agent file transfer | `agent/agentfiles/` | `workspace-agent/files/` | D |
| CR-608 | Agent exec | `agent/agentexec/` | `workspace-agent/exec/` | A |
| CR-609 | Agent proc management | `agent/agentproc/` | `workspace-agent/process/` | B |
| CR-610 | File finder | `agent/filefinder/` | `workspace-agent/search/` | B |
| CR-611 | Immortal streams | `agent/immortalstreams/` | `workspace-agent/streams/` | C |
| CR-612 | Boundary log proxy | `agent/boundarylogproxy/` | `workspace-agent/boundary/` | C |
| CR-613 | Agent proto definitions | `agent/proto/` | `workspace-agent/proto/` | D |
| CR-614 | Agent unit tests | `agent/unit/` | `workspace-agent/testing/` | D |
| CR-615 | Agent reaper | `agent/reaper/` | `workspace-agent/reaper/` | A |
| CR-616 | Agent integration test | agent connectivity | `workspace-agent/integration/` | B |

---

## Wave 7: Networking (CR-701 to CR-710)

| ID | Title | Source | Target | Batch |
|----|-------|--------|--------|-------|
| CR-701 | Mesh core | `tailnet/*.go` | `mesh/core/` | A |
| CR-702 | Mesh proto | `tailnet/proto/` | `mesh/proto/` | A |
| CR-703 | DERP metrics | `tailnet/derpmetrics/` | `mesh/derp/metrics/` | B |
| CR-704 | Mesh test utilities | `tailnet/tailnettest/` | `mesh/testkit/` | B |
| CR-705 | VPN tunnel | `vpn/` | `tunnel/` | C |
| CR-706 | Enterprise tailnet | `enterprise/tailnet/` | `premium/mesh/` | C |
| CR-707 | Enterprise DERP mesh | `enterprise/derpmesh/` | `premium/derpmesh/` | D |
| CR-708 | Dev tunnel | `coderd/devtunnel/` | `controlplane/devtunnel/` | D |
| CR-709 | Mesh connectivity test | `tailnet/test/` | `mesh/integration/` | A |
| CR-710 | Wave 7 STUN/DERP integration test | integration | `mesh/e2e/` | B |

---

## Wave 8: CLI (CR-801 to CR-814)

| ID | Title | Source | Target | Batch |
|----|-------|--------|--------|-------|
| CR-801 | CLI root and config | `cli/root.go`, `cli/config/` | `terminal/root.go` | A |
| CR-802 | Login and auth commands | `cli/login.go`, `cli/logout.go` | `terminal/auth/` | A |
| CR-803 | Workspace commands | `cli/` workspace cmds | `terminal/devbox/` | B |
| CR-804 | Template commands | `cli/` template cmds | `terminal/blueprint/` | B |
| CR-805 | Agent SSH commands | `cli/` ssh cmds | `terminal/ssh/` | C |
| CR-806 | Port forward commands | `cli/` port-forward | `terminal/tunnel/` | C |
| CR-807 | User/org admin commands | `cli/` admin | `terminal/admin/` | D |
| CR-808 | Provisioner daemon CLI | `cli/` provisionerd | `terminal/orchestrator/` | D |
| CR-809 | Server command | `cli/server.go` | `terminal/server/` | A |
| CR-810 | TUI components | `cmd/cliui/` | `cmd/tui/` | B |
| CR-811 | CLI formatting/output | `cli/` display helpers | `terminal/output/` | C |
| CR-812 | CLI test utilities | `cli/` tests | `terminal/testing/` | D |
| CR-813 | Enterprise CLI | `enterprise/cli/` (95 files, 2 tickets) | `premium/terminal/` | A-B |
| CR-814 | CLI parity test vs `--help` tree | integration | `terminal/parity/` | C |

---

## Wave 9: Enterprise (CR-901 to CR-918)

| ID | Title | Source | Target | Batch |
|----|-------|--------|--------|-------|
| CR-901 | Premium license system | `enterprise/coderd/license/` | `premium/licensing/` | A |
| CR-902 | Premium API extensions | `enterprise/coderd/` (split 4 tickets) | `premium/controlplane/` | A-D |
| CR-903 | Audit pipeline | `enterprise/audit/` | `premium/audit/` | B |
| CR-904 | Database encryption | `enterprise/dbcrypt/` | `premium/dbcrypt/` | B |
| CR-905 | Workspace proxy | `enterprise/wsproxy/` | `premium/regionalproxy/` | C |
| CR-906 | Replica sync | `enterprise/replicasync/` | `premium/replication/` | C |
| CR-907 | Trial management | `enterprise/trialer/` | `premium/trial/` | D |
| CR-908 | AI seats | `enterprise/aiseats/` | `premium/aiseats/` | D |
| CR-909 | AI bridge proxy | `enterprise/aibridgeproxyd/` | `premium/aibridgeproxy/` | A |
| CR-910 | Premium scaletest | `enterprise/scaletest/` | `premium/loadtest/` | B |
| CR-911 | SCIM endpoint | forge + enterprise SCIM | `premium/scim/` | C |
| CR-912 | Branding API | forge branding | `premium/branding/` | C |
| CR-913 | Governance hooks | forge governance | `premium/governance/` | D |
| CR-914 | Identity bridge | forge identity | `premium/identity/` | D |
| CR-915 | Multi-org | enterprise org features | `premium/multorg/` | A |
| CR-916 | Session logging | enterprise session | `premium/sessionlog/` | B |
| CR-917 | Compliance export | enterprise compliance | `premium/compliance/` | C |
| CR-918 | Premium integration test | license-gated features | `premium/integration/` | D |

---

## Wave 10: Frontend (CR-1001 to CR-1024)

| ID | Title | Source | Target | Batch |
|----|-------|--------|--------|-------|
| CR-1001 | Console scaffold (Vite/React) | `site/package.json`, vite config | `console/` | A |
| CR-1002 | API client layer | `site/src/api/` | `console/src/api/` | A |
| CR-1003 | Generated types pipeline | `site/src/api/typesGenerated.ts` | `console/src/api/generated/` | B |
| CR-1004 | Shared UI components | `site/src/components/` (split 3 tickets) | `console/src/ui/` | B-D |
| CR-1005 | Auth pages | `site/src/pages/LoginPage/` etc. | `console/src/features/auth/` | C |
| CR-1006 | Workspaces pages | `site/src/pages/WorkspacesPage/` | `console/src/features/devboxes/` | C |
| CR-1007 | Templates pages | `site/src/pages/TemplatesPage/` | `console/src/features/blueprints/` | D |
| CR-1008 | Users/admin pages | admin pages | `console/src/features/admin/` | A |
| CR-1009 | Agents/AI pages | AgentsPage, chat UI | `console/src/features/agents/` | B |
| CR-1010 | Settings pages | settings | `console/src/features/settings/` | B |
| CR-1011 | Deployment/setup pages | deployment | `console/src/features/setup/` | C |
| CR-1012 | App routing | `site/src/App.tsx` | `console/src/app/` | C |
| CR-1013 | Theme and Tailwind config | tailwind.config.js | `console/tailwind.config.ts` | D |
| CR-1014 | Storybook setup | `.storybook/` | `console/.storybook/` | D |
| CR-1015 | Storybook stories batch 1 | auth, workspaces | `console/src/**/*.stories.tsx` | A |
| CR-1016 | Storybook stories batch 2 | templates, admin | stories | B |
| CR-1017 | Storybook stories batch 3 | agents, settings | stories | C |
| CR-1018 | Unit tests (vitest) | `site/src/test/` | `console/src/testing/` | D |
| CR-1019 | E2E scaffold | `site/e2e/` | `console/e2e/` | A |
| CR-1020 | Remove MUI migration complete | N/A (cleanroom) | verify zero MUI imports | B |
| CR-1021 | React Query hook reorganization | queries | feature-colocated hooks | C |
| CR-1022 | Static assets | `site/static/` | `console/public/` | D |
| CR-1023 | Console build embed in Go | site embed | `controlplane/static/` | A |
| CR-1024 | Wave 10 UI smoke test | manual + storybook CI | `console/ci/` | B |

---

## Wave 11: Extensions (CR-1101 to CR-1110)

| ID | Title | Source | Target |
|----|-------|--------|--------|
| CR-1101 | AI gateway core | `aibridge/` | `ai-gateway/` |
| CR-1102 | Forge extension binaries | `cmd/forge-*`, `forge/` | `extensions/`, `cmd/ext-*` |
| CR-1103 | Mission control | `cmd/forge-mission-control/` | `cmd/ext-mission-control/` |
| CR-1104 | Load test harness | `scaletest/` | `loadtest/` |
| CR-1105 | Internal googleopenai | `internal/googleopenai/` | `ai-gateway/providers/` |
| CR-1106 | Archive test utilities | `archive/` tests | `buildmeta/archive/` |
| CR-1107 | Dogfood templates | `dogfood/` | `examples/dogfood/` |
| CR-1108 | Example templates | `examples/` | `examples/templates/` |
| CR-1109 | Offline docs build | `offlinedocs/` | `tools/offlinedocs/` |
| CR-1110 | Extension integration test | cross-extension | `extensions/integration/` |

---

## Wave 12: Deploy/Ops (CR-1201 to CR-1208)

| ID | Title | Source | Target |
|----|-------|--------|--------|
| CR-1201 | Dockerfile (server) | `Dockerfile*` | `deploy/Dockerfile` |
| CR-1202 | Helm chart core | `helm/`, `deploy/helm/` | `deploy/helm/anvil/` |
| CR-1203 | Develop script | `scripts/develop.sh` | `scripts/develop.sh` |
| CR-1204 | Git hooks | `.githooks/` | `.githooks/` |
| CR-1205 | GitHub Actions full CI | `.github/workflows/` | `.github/workflows/` |
| CR-1206 | Monitoring dashboards | `monitoring/` | `deploy/monitoring/` |
| CR-1207 | Support utilities | `support/` | `tools/support/` |
| CR-1208 | Wave 12 deploy smoke test | helm install | `deploy/smoke/` |

---

## Wave 13: Verification (CR-1301 to CR-1306)

| ID | Title | Description |
|----|-------|-------------|
| CR-1301 | Full test suite | `make test` entire cleanroom tree |
| CR-1302 | Swagger parity diff | Zero breaking public API changes |
| CR-1303 | Dissimilarity audit | All mapped files < 15% similarity |
| CR-1304 | Torbit structural parity report | Subsystem graph comparison |
| CR-1305 | E2E Playwright suite | Core user flows (license permitting) |
| CR-1306 | Ship readiness review | Gate G6 checklist |

---

## Per-Ticket Acceptance Template

Every ticket above, when executed, must satisfy:

1. Torbit pre-batch baseline recorded
2. All listed source files have cleanroom counterparts
3. Unit tests pass for target package
4. Dissimilarity check passes for batch
5. Torbit post-batch definition count verified
6. No imports from `github.com/coder/coder/v2`
7. Code review subagent approval
