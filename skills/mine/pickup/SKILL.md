---
name: pickup
description: Resume work from a saved handoff.
argument-hint: "Handoff path, filename, or number"
disable-model-invocation: true
---

# Pickup

Pick up an Org mode handoff from `.scratch-org/handoffs/`.

If the user supplied a path, filename, or three-digit number, resolve it to one existing handoff. If they supplied nothing, list the handoffs in numeric order and ask which one to use. Ask when a partial reference matches more than one file.

Read the selected handoff completely. Follow its artifact references instead of asking the user to repeat their contents, invoke its suggested skills, state the goal and current state briefly, then continue with its first concrete next step.

Pickup is complete when work has resumed or the user has been asked for a missing selection or next step.
