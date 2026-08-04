---
name: local-org-issues-cli
description: Use the read-only local-issues CLI to inspect local Org ticket metadata. Use when listing tickets, selecting ready work, explaining blocker chains, checking readiness or assignees, producing table or JSON output, or diagnosing .scratch-org integrity.
---

# Local Org Issues CLI

Invoke `local-issues` directly from `PATH`. It reads saved canonical tickets without printing their bodies or changing tracker files.

Run it from the repository, or put `--root PATH` before the subcommand to query another repository. Use table output for compact reading and JSON for automation.

## Commands

- `local-issues list [--all] [--work-item NNN] [--format table|json]` lists ticket states, readiness, direct unresolved blockers, assignees, and titles.
- `local-issues suggest [--limit N] [--work-item NNN] [--format table|json]` selects unassigned, dependency-ready `READY-FOR-AGENT` work. By default, it returns one candidate and its absolute canonical ticket path.
- `local-issues why TICKET_ID [--all] [--format table|json]` explains dependency readiness and every unresolved blocker branch for one ticket.
- `local-issues doctor [--format table|json]` reports malformed metadata and dependency-integrity failures. It exits nonzero when it finds any problem.

## Usage rules

- The CLI supplies metadata, not ticket instructions. Read the canonical ticket returned by `suggest` before claiming or implementing it.
- Respect any selection order imposed by the calling skill; use the CLI to verify eligibility and readiness.
- Treat an empty `suggest` result as success, not a tracker failure.
- Use `doctor` for authoritative whole-tracker health checks.
