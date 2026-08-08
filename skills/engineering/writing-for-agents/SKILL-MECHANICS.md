# Skill mechanics

This reference covers the parts of [SKILL.md](SKILL.md) that apply only to skills.

## Invocation

Choose model-reachable invocation when the agent must discover the skill independently or another skill must call it. Use a direct human trigger when human judgment should decide whether the skill runs. Follow the target harness's metadata convention for that choice.

A model-reachable skill needs a concise description with the task and its distinct trigger cases. A direct-trigger skill needs a clear human-facing summary.

## Splitting skills

Create another skill only when it has a distinct trigger term or hides a later sequence that distracts from the current work. Otherwise keep the material together and use disclosed reference for conditional details.

## Router skills

When several direct-trigger skills become difficult to remember, provide one index skill that names each one and when to use it. The index helps the human choose; it does not replace that judgment.
