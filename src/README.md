# Anvil Platform Source

Go module: `github.com/swami086/platform`

Implementation code for Anvil Platform lives here. Planning documents remain at the repository root.

## Layout

| Path | Role |
|------|------|
| `cmd/anvil/` | Main server and CLI entry binary |
| `controlplane/` | HTTP API and domain services |
| `clientsdk/` | Public API client types |
| `persistence/` | Database layer |
| `workspace-agent/` | In-workspace runner |
| `orchestrator/` | Provision job supervisor |
| `executor/` | Terraform provisioner runtime |
| `executor-sdk/` | Provisioner gRPC SDK |
| `mesh/` | Overlay networking |
| `terminal/` | CLI commands |
| `console/` | Web UI (Wave 10) |
| `premium/` | Enterprise features |
| `testkit/` | Test utilities |
| `buildmeta/` | Version metadata |

## Commands

```bash
make build
make test
make lint
```
