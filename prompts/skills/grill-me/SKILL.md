---
name: grill-me
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree. Use when user wants to stress-test a plan, get grilled on their design, or mentions "grill me".
---

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time.

If a question can be answered by exploring the codebase, explore the codebase instead.

## Human Depth Control

The user controls how deep we go into any branch.

Recognize these phrases, and any close equivalent:

- "Zoom out"
- "No deeper"
- "Park this branch"
- "Good enough for now"
- "Move up a level"
- "What's the bigger question?"
- "Challenge the premise"

When the user says this (or something like that), immediately stop asking more detailed questions in the current branch.

Then:
1. Briefly summarize what we learned in that branch.
2. Name any unresolved assumptions.
3. Return to the parent decision or bigger strategic question.
4. Ask one next high-leverage question from that higher level to proceed.
