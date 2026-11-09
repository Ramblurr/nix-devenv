---
name: agent-coordination
description: Establish shared-resource ownership in standalone Claude Code. Use when concurrent agents need peer communication or exclusive Git access, including independent top-level sessions.
---

# Agent coordination

Native child-agent tools cover your delegated agents, not discovery or control of unrelated top-level sessions. Use their live descriptions to coordinate your own children; keep routine child results on the delegation mechanism.

For independent peers, use a peer transport only if the runtime explicitly supplies one and documents discovery and messaging. Otherwise ask the human to arrange exclusive ownership of the named checkout across all affected sessions and their children. Wait for confirmation before staging, committing or merging; silence and announcements are not grants.

Record the checkout, expected HEAD and operation scope. Recheck HEAD and the index after access is granted, stop on unexpected changes, and release ownership after completion or abort. An isolated checkout is an alternative for future work, not permission to mutate a shared destination during integration.

When running under T3 Code, use its `agent-coordination` skill and injected runtime instructions instead.
