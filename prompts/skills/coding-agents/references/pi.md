# Pi Coding Agent Reference

Lightweight coding agent supporting multiple providers.

This skill about the mechanics of spawning a pi coding agent.

For link tool mechanics (link_send / link_prompt / link_compact / link_list, the
Golden Rule, delivery shapes, anti-patterns) load Skill(pi-link-coordination)
and read it first.


## Invocation

```bash
# Interactive, use this by default unless human instructions otherwise
pi --link-name <scope>@<role>

# With prompt
pi --link-name <scope>@<role> "Your task"

# Non-interactive (runs and exits)
pi -p "Your task"

# Include files in prompt
pi --link-name <scope>@<role> @file.md @image.png "Analyze these"
```

## Naming your subagent

Your subagent's link name must follow this format: `<scope>@<role>`

`<scope>` is basename("$(pwd)")

Common `<role>`s: leader, dev, dev1, dev2, reviewer, researcher

## Key Flags

- `--link-name`: see Skill(pi-link-coordination)
- `--provider <name>`: Provider (default: google). Options: anthropic, openai, google, groq, etc.
- `--model <id>`: Model ID (default: gemini-2.5-flash)
- `--api-key <key>`: Override API key
- `-c, --continue`: Continue previous session
- `-r, --resume`: Select a session to resume
- `--tools <list>`: Comma-separated tools to enable (default: read,bash,edit,write). Also: grep, find, ls
- `--thinking <level>`: Thinking level: off, minimal, low, medium, high, xhigh
- `--system-prompt <text>`: Custom system prompt
- `--append-system-prompt <text>`: Append to system prompt
- `-p, --print`: Non-interactive mode, runs prompt and exits. Generally do not use this mode.

## Examples

```bash
# Read-only mode (no file modifications)
pi --link-name <scope>@<role> --tools link_list,link_send,read,grep,find,ls -p "Review the code in src/"
```

## Completion Detection

- Returns to shell prompt in non-interactive mode
- Returns to Pi prompt in interactive mode

## Exit Command

Standard exit or Ctrl+C

## Communicating and collaborating with Pi subagents

In general, prefer to communicate with the agents using the link tools rather than using Tmux to capture their terminal text.

1. Refer to the Skill(pi-link-coordination)
2. Using tmuxb send commands: Give your sub agent a name by running `/link-name <name>`
   a good name is <project-name>-<role> e.g. "cms-coder"
3. Connect them to the link hub `/link-connect`

Critical instruction: You and your subagent must always use `link_send(triggerTurn: true)`, Do not forget to add the `triggerTurn: true` argument!
