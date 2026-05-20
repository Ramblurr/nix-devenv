---
name: brainstorming
description: Refine ideas into detailed designs through Socratic dialogue. Use when user has rough idea, needs to clarify requirements, explore approaches. 
---

# Brainstorming Ideas Into Designs

## Overview

Transform rough ideas into fully-formed designs through structured questioning and alternative exploration.

**Core principle:** Ask questions to understand, explore alternatives, present design incrementally for validation.

**Announce at start:** "I'm using the Brainstorming skill to refine your idea into a design."

## The Process

### Phase 1: Understanding

- Check current project state in working directory
- Ask ONE question at a time to refine the idea
- Prefer multiple choice when possible
- Gather: Purpose, constraints, success criteria
- Record: Take notes as you go in a concept document in `prompts/NNN-<thing>_concept.md` Skill(prompts-documents)
- Backoff: The user controls how deep we go into any branch. When the user indicates to not go any deeper, immediately stop asking more detailed questions in the current branch.
- Loop

### Phase 2: Exploration

- Propose 2-3 different approaches
- For each: Core architecture, trade-offs, complexity assessment
- Ask your human partner which approach resonates

### Phase 3: Design Presentation

- Present in 200-300 word sections
- Cover: Architecture, components, data flow, error handling, testing
- Ask after each section: "Does this look right so far?"

### Phase 4: Closure

Summarize:
- the problem
- selected approach
- rejected alternatives
- unresolved questions
- assumptions
- success criteria

Update the plan document Skill(writing-plans)

## When to Revisit Earlier Phases

**You can and should go backward when:**

- Partner reveals new constraint during Phase 2 or 3 → Return to Phase 1 to understand it
- Validation shows fundamental gap in requirements → Return to Phase 1
- Partner questions approach during Phase 3 → Return to Phase 2 to explore alternatives
- Something doesn't make sense → Go back and clarify

**Don't force forward linearly** when going backward would give better results.

## Remember

- One question per message during Phase 1
- Record/take notes in the concept document
- Apply YAGNI ruthlessly
- Explore 2-3 alternatives before settling
- Present incrementally, validate as you go
- Go backward when needed - flexibility > rigid progression
- Announce skill usage at start
