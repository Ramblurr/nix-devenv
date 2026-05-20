# Pi Coding Agent Reference

Lightweight coding agent supporting multiple providers.

Install: `npm install -g @mariozechner/pi-coding-agent`

## Invocation

```bash
# Interactive, use this by default unless human instructions otherwise
pi

# With prompt
pi "Your task"

# Non-interactive (runs and exits)
pi -p "Your task"

# Include files in prompt
pi @file.md @image.png "Analyze these"

# Continue previous session
pi -c "Continue our work"
```

## Key Flags

- `-p, --print`: Non-interactive mode, runs prompt and exits
- `--provider <name>`: Provider (default: google). Options: anthropic, openai, google, groq, etc.
- `--model <id>`: Model ID (default: gemini-2.5-flash)
- `--api-key <key>`: Override API key
- `-c, --continue`: Continue previous session
- `-r, --resume`: Select a session to resume
- `--tools <list>`: Comma-separated tools to enable (default: read,bash,edit,write). Also: grep, find, ls
- `--thinking <level>`: Thinking level: off, minimal, low, medium, high, xhigh
- `--system-prompt <text>`: Custom system prompt
- `--append-system-prompt <text>`: Append to system prompt

## Examples

```bash
# Use OpenAI
pi --provider openai --model gpt-4o-mini -p "Summarize src/"

# Read-only mode (no file modifications)
pi --tools read,grep,find,ls -p "Review the code in src/"

# High thinking level for complex tasks
pi --thinking high "Solve this complex problem"
```

## Completion Detection

- Returns to shell prompt in non-interactive mode
- Returns to Pi prompt in interactive mode

## Exit Command

Standard exit or Ctrl+C

## Communicating and collaborating with Pi subagents

1. Refer to the Skill(pi-link-coordination)
2. Using tmuxb send commands: Give your sub agent a name by running `/link-name <name>`
   a good name is <project-name>-<role> e.g. "cms-coder"
3. Connect them to the link hub `/link-connect`

Critical instruction: You and your subagent must always use `link_send(triggerTurn: true)`, Do not forget to add the `triggerTurn: true` argument!
