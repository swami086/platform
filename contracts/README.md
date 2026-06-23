# API Contract Baseline

This directory stores **interface specifications** used to verify HTTP API parity during Anvil Platform development.

- `swagger-baseline.json`: Public `/api/v2/*` routes extracted for diff comparison in Wave 3+.
- This is contract metadata, not implementation source code.

Compare a candidate swagger export:

```bash
./scripts/diff-swagger.sh contracts/swagger-baseline.json path/to/candidate.json
```
