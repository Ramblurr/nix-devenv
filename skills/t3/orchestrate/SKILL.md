---
name: orchestrate
description: Coordinate a ticket queue under T3 Code. Use when managing several agents or sequencing implementation, validation and review before advancing to the next ticket.
---

# Orchestrate

Follow the runtime-injected **T3 Code orchestration** instructions (`<t3_code_orchestration>`) and [Sub-agents](../sub-agents/SKILL.md) for delegation. Use [Agent coordination](../agent-coordination/SKILL.md) for peer communication and shared resources, including other top-level threads and their trees. This skill adds queue discipline, not a second tool protocol.

1. Identify ready tickets, dependencies and each ticket's completion criteria. Give concurrent agents disjoint ownership; serialize shared Git index and HEAD changes.
2. Dispatch bounded assignments with ticket/spec paths, owned scope, required validation and review, and expected deliverables. Include any permission to delegate reviews in the assignment.
3. Keep a local `orchestration.org` in the work-item directory: ticket states, task handles, checkout locations, outstanding work and next actions. Timestamp observations; record the commit or uncommitted state covered by validation and review.
4. Accept a ticket only after checking its deliverables, validation and required reviews, plus commits and ticket closure when requested. Resolve blockers before advancing dependent work.

Use T3's lifecycle instructions to wait, recover or cancel work; do not import Pi pod provisioning or callback protocols. Resume from the ledger and reconcile task state before dispatching duplicate work.
