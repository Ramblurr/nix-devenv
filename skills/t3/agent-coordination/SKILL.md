---
name: agent-coordination
description: Coordinate peer threads under T3 Code. Use for communication or shared-resource ownership between concurrent agents, including unrelated top-level threads and separate sub-agent trees.
---

# Agent coordination

Follow the runtime-injected **T3 Code orchestration** instructions (`<t3_code_orchestration>`) for thread operations. Discover `t3_thread_list`, `t3_thread_read` and `t3_thread_send` and read their live descriptions for discovery, inspection and messaging. If these instructions or tools are unavailable, ask rather than fall back to Pi Link.

Use existing peer threads for coordination; use Skill(sub-agents) for delegated work and its normal completion mechanism. Peer messaging is not a substitute for the runtime's delegation or review lifecycle.

## Find peers

Scope discovery to the project, including relevant sub-agent trees. Confirm environment, repository and checkout identity before contacting a peer; titles and idle status do not establish resource ownership. Include the resource, requested action and your reply address in messages. A successful send is not agreement.

## Shared Git access

Identify every thread or coordinator sharing the index or HEAD. Follow an existing coordinator's commit-lock protocol. Otherwise agree on one coordinator or obtain explicit exclusive-access agreement from every affected peer before staging. An announcement is not a grant.

Include the checkout, expected HEAD and scope of the operation in the request. A coordinator's agreement must cover its affected children. Recheck HEAD and the index after access is granted; stop on unexpected changes. Send release/all-clear after commit or abort.

Follow T3's runtime lifecycle instructions while awaiting replies. If peer discovery, communication or ownership is uncertain, stop and ask rather than assume exclusive access. Silence, a finished thread and stale messages do not release a lock.
