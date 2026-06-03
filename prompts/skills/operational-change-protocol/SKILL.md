---
name: operational-change-protocol
description: Use this OCP when executing or preparing to execute commands that change a live or important system, service reloads/restarts, package changes, deployments, migrations, firewall/network/access changes, credential rotation, NixOS switch/test/boot/deploy, or incident mitigation. It guides safe operations with a persisted ledger for scope, preflight, baseline, rollback, validation, and evidence.
---

# Operational Change Protocol

Operational changes are commands that apply changes to a live or important system: editing configuration directly on a target host, activating or deploying config-as-code, restarting services, changing packages, modifying firewalls, running migrations, resizing disks, changing permissions, deploying code, patching hosts, changing credentials, and mitigating incidents.

## Prime directive

Do not run state-changing commands until a persisted operation ledger exists for the planned change.

Before the first state-changing command:

1. Create a Markdown operation ledger on disk.
2. Record scope, execution context, exact commands, command preflight, baseline checks, rollback, validation, and abort criteria.
3. Keep the ledger current as commands run and observations change.
4. Present the ledger and get an explicit go/no-go unless the operator already authorized this exact plan.

Creating the ledger itself is allowed before the full ledger exists. Chat history does not count as a persisted ledger.

Do not improvise on a live system. Inspect first, write the commands down, preflight them, then execute one deliberate step at a time.

## Ledger location

Persist the ledger before changing the target system.

Preferred locations:

1. If `./prompts/` exists, invoke Skill(prompts-documents) and create a new document or update the one you are working from. OCP ledgers are workflow documents; do not commit them unless the operator asks.
2. Otherwise, if the current project directory is writable, create `.agents/ocp/YYYYMMDDTHHMMSSZ-<slug>.md`.

Record `Ledger path:` at the top. For remote operations, prefer storing the ledger on the operator workstation or project workspace, not on the target host, unless the operator wants target-local records.

Update the ledger immediately after each executed command with command, exit code, output summary, evidence, and decision. If the plan changes, update the planned step before running the revised command. If risk or scope changes, ask for another go/no-go.

Redact secrets, private keys, tokens, passwords, customer data, and sensitive log excerpts.

## Risk and command classes

Risk:

- Low: local, reversible, non-customer-impacting, already tested, or limited to inactive state.
- Medium: may affect a service, package, config, firewall, scheduled job, persistent state, or deployment, but impact is bounded and rollback is straightforward.
- High: may cause outage, data loss, lockout, security exposure, irreversible migration, broad fleet impact, network isolation, boot failure, or difficult rollback.

High-risk changes require stronger baselines, explicit backup or restore points, smaller rollout units, and a go/no-go point before mutation.

Command classes:

- Read-only: inspects state and should not alter persistent state, except ordinary access timestamps or logs.
- Preflight/build: does not activate the target change but may write caches, package indexes, build outputs, or `/nix/store` paths.
- Idempotent: may change state, but repeated runs converge to the same result.
- Reversible: changes state and has a prepared rollback.
- Destructive: deletes, overwrites, restarts critical services, changes access rules, modifies data, or may interrupt availability.
- Irreversible: cannot be fully undone with known commands.

Backups, `apt-get update`, package index refreshes, Nix builds, and cache/store writes are state changes. They may be safe preparatory steps, but record them when they matter.

Destructive and irreversible commands require explicit scope proof. Avoid irreversible commands unless the operator accepts the recovery limits.

## Ledger workflow

Create one ledger and keep it updated in place. Use grouped blocks, not wide Markdown tables.

### 1. Scope

Record:

- Operation
- Mode: maintenance, patch, upgrade, deployment, incident mitigation, repair, or other
- Risk
- Target system(s) and service(s)
- Objective
- Out of scope
- Expected effect(s)
- Expected non-effect(s)
- Abort criteria
- Rollback summary
- Assumptions and unknowns

Convert vague requests such as “update the server,” “fix nginx,” or “restart stuff” into specific targets and exact commands.

### 2. Execution context

Record:

- Host
- User
- Privilege method: none, sudo, root shell, service account, container exec, database role, or other
- Working directory
- Shell or command runner
- Required environment variables
- Relevant config and data paths
- Maintenance window or urgency

If using SSH, sudo, containers, Kubernetes, chroot, virtualenv, tmux, screen, a database shell, or a deployment tool, specify where each command runs.

### 3. Planned commands

For each command, add a block:

```markdown
#### Planned step N: <purpose>

- Context: <host> / <user> / <working directory>
- Command type: read-only | preflight/build | idempotent | reversible | destructive | irreversible
- Command:
    <exact command>
- Why this command is needed:
- Preflight done or required:
- Expected result:
- Evidence to capture:
- Stop or rollback if:
```

Separate read-only checks from state-changing commands. Do not hide changes inside unexplained scripts, aliases, shell functions, or copied one-liners. If a script is used, inspect it first, summarize what it changes, verify syntax, and identify rollback steps.

### 4. Command preflight

Preflight proves each planned command is available, valid, scoped to the intended resource, and not accidentally broader than intended.

Do not waste time opening man pages for well-known tools and ordinary flags you already know, such as common `cp`, `mv`, `find`, `grep`, `systemctl`, `journalctl`, `rsync`, or package-manager usage. Do inspect help, manuals, project docs, or examples when a tool is unfamiliar, flags are unusual, behavior differs by platform, the command is destructive, or syntax is uncertain.

Useful checks:

```bash
pwd
whoami
hostname -f
command -v <tool>
<tool> --version
sudo -l
```

Scripts and generated shell:

```bash
bash -n ./script.sh
shellcheck ./script.sh
```

Service configs before reload or restart:

```bash
sudo nginx -t
sudo apachectl configtest
sudo sshd -t
sudo visudo -cf /etc/sudoers
sudo systemd-analyze verify /etc/systemd/system/example.service
```

File operations: prove the target set before changing it.

```bash
pwd
ls -la /exact/path
stat /exact/path
readlink -f /exact/path
find /exact/path -maxdepth 1 -type f -name '*.log' -print
rsync -av --dry-run /source/ /dest/
```

Before recursive deletion, ownership changes, permission changes, moves, or copies, list the exact affected files first. Do not rely on unreviewed globs.

Package changes: prefer policy, simulation, and version checks before mutation.

```bash
apt-cache policy <package>
sudo apt-get install --simulate <package>
sudo apt-get upgrade --simulate
dnf repoquery <package>
sudo dnf upgrade --assumeno <package>
yum info <package>
```

Treat `apt-get update`, `dnf makecache`, and similar metadata refreshes as preparatory mutations, not read-only checks.

Nix and NixOS: build or evaluate before activation.

```bash
nix flake check
nix build .#nixosConfigurations.<host>.config.system.build.toplevel
nixos-rebuild dry-build --flake .#<host>
nixos-rebuild build --flake .#<host>
sudo nixos-rebuild dry-activate --flake .#<host>
```

Nix evaluation and builds usually do not alter the active system, but they can write to `/nix/store`, fetch inputs, consume disk, and query substituters. Use normal user privileges for build/eval when possible; use `sudo` for activation or target-local checks that require it.

Treat these as state-changing activations:

```bash
sudo nixos-rebuild test --flake .#<host>
sudo nixos-rebuild boot --flake .#<host>
sudo nixos-rebuild switch --flake .#<host>
sudo nixos-rebuild switch --flake .#<host> --target-host <host>
```

For NixOS rollback, capture current generation and prepare rollback commands:

```bash
readlink -f /run/current-system
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
sudo nixos-rebuild switch --rollback
sudo /nix/var/nix/profiles/system-<generation>-link/bin/switch-to-configuration switch
```

For deploy-rs, Colmena, Morph, NixOps, or similar tools, run build, eval, dry-run, or plan mode first when available. Record the exact deploy/apply/switch command as a mutation.

Databases: prefer transaction tests, explain plans, schema diffs, backups, and row-count checks before mutation.

```sql
BEGIN;
-- intended change here
-- validation query here
ROLLBACK;
```

Only use a transaction test when it accurately represents the production operation and does not take unsafe locks or trigger side effects.

Firewall, network, and access changes: verify current access and prepare timed rollback or out-of-band access before applying the change.

```bash
sudo iptables-save
sudo nft list ruleset
sudo ufw status verbose
ss -tulpn
ip route
```

When possible, schedule an automatic rollback before lockout-prone changes.

### 5. Baseline

Run read-only checks that establish current state. Capture outputs or concise summaries in the ledger.

Common checks:

```bash
date -u
hostname -f
whoami
uptime
systemctl status <service> --no-pager
systemctl is-active <service>
systemctl is-enabled <service>
journalctl -u <service> --since '-15 min' --no-pager
ss -tulpn
df -h
free -h
```

For configs and files, record ownership, mode, checksums, and explicit backup paths:

```bash
sudo ls -l /path/to/config
sudo sha256sum /path/to/config
BACKUP="/path/to/config.bak.$(date -u +%Y%m%dT%H%M%SZ)"
sudo cp -a /path/to/config "$BACKUP"
printf 'backup=%s\n' "$BACKUP"
```

Do not plan rollback from a wildcard such as `/path/to/config.bak.*`.

For app health and metrics, capture current status, error rate, request rate, latency, queue depth, disk usage, and service-specific health when available.

### 6. Rollback

Write rollback as exact commands before the change starts. Record:

- Rollback trigger(s)
- Rollback command(s)
- Rollback validation command(s)
- Backup or restore point
- Expected rollback result
- Known rollback limitations

Preflight rollback where non-destructive. Verify the backup exists, the previous package version is available, the previous release directory exists, or the previous NixOS generation is known.

### 7. Go/no-go

Before any mutation, ensure preflight and baseline match expectations and rollback is ready. Ask for explicit go/no-go unless the operator already authorized the exact plan.

Record:

- Decision: pending, go, or no-go
- Decider
- Decision time
- Notes

### 8. Execution log

Run planned commands in order. After each command, append:

```markdown
#### Executed step N: <purpose>

- Command:
    <exact command>
- Exit code:
- Output summary:
- Evidence captured:
- Observed state:
- Expected result met: yes | no | unclear
- Decision: continue | stop | rollback | revise plan
```

Do not batch unrelated changes. Do not keep going to “see if the next step fixes it.” If output differs from expectation, stop, record the observation, and reassess.

When editing files, preserve ownership and permissions or record them before changing. Validate config before reload or restart.

When restarting services, prefer reload only when the service supports safe reload and the change does not require restart. Otherwise state why restart is required.

### 9. Post-validation

Run planned post-validation commands. Prefer repeating relevant baseline checks so before and after can be compared.

Validate intended effects and expected non-effects: service health, logs since change start, listeners, package versions, NixOS generation, application health, database row counts or schema state, permissions, disk usage, load, scheduled jobs, and unrelated critical services.

### 10. Close the ledger

Finish with:

- Final status: succeeded, rolled back, partially applied, or failed and needs follow-up
- Commands actually run
- Baseline evidence
- Change evidence
- Post-validation evidence
- Expected non-effects checked
- Unexpected observations
- Rollback used: yes or no
- Residual risk
- Follow-up required

If rollback occurred, document the original failure and rollback validation result.

## Incident mode

During an incident, use a compressed persisted ledger. The goal is stabilization, not perfect cleanup or root-cause analysis.

Minimum fields:

```markdown
# Incident Operation Ledger: <short title>

- Ledger path:
- Incident symptom:
- Immediate objective:
- Target system/service:
- Risk:
- Fast baseline command(s):
- Proposed mitigation command(s):
- Rollback command(s):
- Abort condition:
- Validation command(s):
- Go/no-go decision:
- Execution log:
- Result:
```

Prefer the smallest safe mitigation: restart one failed service, disable one bad config, roll back one deploy, restore one known-good file, drain one host, or revert one feature flag.

Do not perform broad exploratory changes during an incident. If the system is unstable, favor known rollback over speculative fix. Capture enough evidence for later diagnosis before destroying volatile clues, but do not delay urgent stabilization when impact is ongoing.

## Safety patterns

Prefer exact paths. Avoid broad globs until the matched set has been printed and reviewed.

Prefer dry-runs and scope proof before mutation:

```bash
find /var/log/example -maxdepth 1 -type f -name '*.old' -print
rsync -av --dry-run /src/ /dst/
```

Avoid unless scope and variables are proven and the operation is justified:

```bash
chmod -R 777 /path
chown -R user:user /
rm -rf $DIR/*
kill -9 $(pgrep something)
```

Before variables appear in destructive commands, print and validate them:

```bash
printf 'DIR=<%s>\n' "$DIR"
test -n "$DIR"
test "$DIR" != "/"
find "$DIR" -maxdepth 1 -type f -print
```

## When a full ledger is unnecessary

For purely read-only investigation, use ordinary diagnostic reasoning. Still label commands as read-only and avoid accidental mutation.

For a trivial local development change with no live-system impact, a short persisted note is enough: objective, command, expected result, undo step, and validation.

For any live server, production-adjacent system, security boundary, persistent data store, remote access path, or critical personal infrastructure, use the full protocol.

Editing files in a repository, including NixOS configuration, is not by itself an operational change. Use ordinary development workflow for file edits; use this protocol when you plan to activate, switch, deploy, or otherwise apply those files to a live or important target and the risk is high.
