---
name: agent-coordination
description: Coordinate peers through Pi Link. Use for communication or shared-resource ownership between concurrent agents, including unrelated top-level agents and separate sub-agent trees.
---

# Agent coordination

Use Pi Link for peer communication; no sub-agent relationship or tmux provisioning is required. You must read Skill(pi-link-tools) and the live tool descriptions. Use Skill(sub-agents) only when delegating work.

## Find peers

`link_list` shows your Link group, not a pool of available workers. Use `<role>@<scope>` names, where `<scope>` is the project directory basename. Confirm repository and checkout identity before coordinating resources; group membership alone does not prove shared ownership. Do not message or compact unrelated terminals, or repurpose an idle peer without agreement.

## Shared Git access

Identify every same-project agent or coordinator sharing the index or HEAD, including other top-level agents and their trees. Follow an existing coordinator's commit-lock protocol. Otherwise agree on one coordinator or obtain explicit exclusive-access agreement from every affected peer before staging. An announcement is not a grant.

Include the checkout, expected HEAD and scope of the operation in the request. A coordinator's agreement must cover its affected children. Recheck HEAD and the index after access is granted; stop on unexpected changes. Send release/all-clear after commit or abort.

If peer discovery, communication or ownership is uncertain, stop and ask rather than assume exclusive access. Silence, disconnection and stale messages do not release a lock.
