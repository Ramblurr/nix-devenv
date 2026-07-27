---
name: operational-troubleshooting
description: Operational troubleshooting through read-only evidence. Use when a running system needs diagnosis rather than a code fix.
---

# Operational Troubleshooting

Build an **evidence chain** from the symptom to the failing boundary. The result is a read-only diagnosis and a recommended next action.

## Boundary

Before each command, state where it will run and classify it as read-only or state-changing. Use source and configuration only to understand the system path.

A confirmed application defect routes to Skill(diagnosing-bugs). A state-changing command routes to Skill(operational-change-protocol) before it runs. This investigation ends where code editing or operational mutation begins.

## 1. Bound the symptom

Capture:

- Expected and observed behavior
- Affected and unaffected scope
- First known failure and last known good time
- Current impact
- Exact environment, system, version, and deployment identity

Use exact timestamps with an explicit timezone.

**Complete when:** the symptom identifies what failed, where, when, and for whom.

## 2. Trace one example

Map the relevant component boundaries. Follow one known-failing request, event, or record through them; add one known-good comparison when available. Name the observation point at each boundary.

**Complete when:** every hop and observation point in the example's path is named.

## 3. Establish the baseline

Capture current state before adopting a hypothesis: service health, errors, throughput, latency, saturation, resource pressure, active deployment and configuration identity, and adjacent dependency health. Use bounded, explicit queries and verify unfamiliar commands.

**Complete when:** the baseline records the target, time, command or query, and observed value for every relevant boundary.

## 4. Correlate the evidence

Join logs, metrics, traces, change events, and data state by timestamp and stable identifiers. Compare the failing and known-good examples at each boundary. Check identifiers, counts, ordering, timestamps, schemas, checksums, and transformations.

Preserve command context, filters, units, hosts, and timezones. Redact secrets and sensitive customer data.

**Complete when:** every suspected boundary has input/output evidence or a named evidence gap.

## 5. Falsify hypotheses

Rank hypotheses with their predictions and evidence for and against. Test one prediction at a time with a read-only observation, seeking evidence that disproves it.

When observation cannot distinguish the hypotheses, identify the exact access, log, trace, dump, or approved instrumentation needed.

**Complete when:** one cause is supported and competing explanations are contradicted, or the remaining evidence gap is explicit.

## 6. Report and route

Report the scope, timeline, evidence chain, cause or strongest remaining hypothesis, contributing factors, unknowns, and recommended action. Label facts, hypotheses, and unknowns distinctly.

Apply the Boundary routing rule to the recommended action and carry the evidence chain into the receiving skill.

**Complete when:** the report is self-contained and its next action follows directly from the evidence.
