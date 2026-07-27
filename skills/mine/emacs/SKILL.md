---
name: emacs
description: "Control Emacs via tmux for interactive editing, magit operations, and buffer navigation using evil-mode (vim keybindings)."
---

# Emacs Skill

Use Emacs as an interactive editor via tmux.
This skill assumes Doom Emacs or a similar evil-mode configuration with vim keybindings.

## Prerequisites

Invoke the tmux skill (mandatory!) for session setup and key sending.

Start emacsclient in terminal mode with `emacsclient -c -nw`.

All key sequences below are shown as typed in Emacs. Send them via `tmux send-keys`:
- Use `C-m` for Enter
- Use `Escape` for Escape key
- Control keys: `C-c`, `C-g`, etc.
- Meta keys: `M-x`, etc.

Example - `M-x magit C-m` means:
```bash
tmux -S "$SOCKET" send-keys -t "$TARGET" M-x 'magit' C-m
```

CRITICAL: After every key sequence, capture the pane output to verify state before proceeding.

## General Buffer Navigation (Evil/Vim Bindings)

Basic movement: Standard vim line movement (`h`, `j`, `k`, `l`, `gg`, `G`)

Search:
- `/pattern C-m` - search forward (cursor jumps to first match)
- `n` / `N` - next/previous match
- Always verify cursor position via status bar line number after search

Visual mode:
- `v` - enter visual mode (character selection)
- `V` - enter visual line mode (line selection)
- After selecting, use operator keys (e.g., `s` in magit to stage selection)

Cancel/Quit:
- `C-g` - cancel current operation (emacs universal cancel)
- `Escape` - exit insert/visual mode back to normal mode
- `q` - quit current buffer/window (context dependent)

Execute commands:
- `M-x command-name C-m` - run any emacs command

Reading the Status Bar:
- Format: `line:column` (e.g., `346:2` = line 346, column 2)
- Helps verify search worked and cursor is positioned correctly

Toggling Line Numbers:
- `M-x doom/toggle-line-numbers C-m` - cycle through three states: no line numbers, relative line numbers, absolute line numbers
- By default: magit buffers don't show line numbers, normal file buffers do
- Useful for reconciling cursor position when line numbers aren't visible

## Projectile (Project Navigation)

Switch to a project:
- `M-x projectile-switch-project C-m`
- Type project path/name, then `C-m` to select

## Magit (Git Interface)

### Opening Magit

- `M-x magit C-m`
- May show a repo picker if not in a git repo. Use search or type to filter, then `C-m` to select.
- If already in a project it'll open the magit screen directly.

### Magit Status Buffer

The magit status buffer shows sections:
- Untracked files
- Unstaged changes
- Staged changes
- Stashes
- Recent commits

### Expanding/Collapsing Sections

- Navigate to a section header (e.g., "Unstaged changes") with `j`/`k` or search
- Press `Tab` to expand/collapse the section
- Sections with `…` suffix are collapsed
- When expanded, files are listed; press `Tab` on a file to show its diff hunks

### Staging Changes

Stage entire hunk:
- Navigate cursor anywhere inside a hunk
- Press `s` to stage that hunk

Stage specific lines (partial hunk staging):
1. Navigate to the first line you want to stage
2. Press `v` to enter visual mode
3. Use `j`/`k` to expand selection to desired lines
4. Press `s` to stage only the selected lines

Stage entire file:
- Navigate to the filename line
- Press `s`

Unstage:
- Navigate to staged item
- Press `u` to unstage

### Committing

1. Press `c` to open commit transient menu
2. Press `c` again to create a regular commit
3. A commit message buffer opens:
   - Press `i` to enter insert mode
   - Type your commit message
   - Press `Escape` to exit insert mode
   - Press `C-c C-c` to finalize the commit
   - Press `C-c C-k` to cancel

### Refreshing

- Press `g` to refresh the magit status buffer after external git operations

### Common Magit Keys

| Key | Action |
|-----|--------|
| `s` | Stage (hunk, file, or visual selection) |
| `u` | Unstage |
| `c c` | Create commit |
| `c a` | Amend commit |
| `Tab` | Expand/collapse section or file |
| `g` | Refresh buffer |
| `q` | Quit magit buffer |
| `$` | Show git process output |
| `l l` | Show log |
| `d d` | Show diff |
| `P p` | Push |
| `F p` | Pull |

## Common Pitfalls

- Forgetting to send `C-m` to confirm commands
- Sending multi-character vim commands: `gg` should be sent as two separate keys: `send-keys 'g' 'g'`
- Not capturing/verifying output before next command
- Visual selection in magit: Be precise with line selection or you'll stage unwanted lines

## Tips

- Always capture pane output after sending commands to verify state (see tmux skill).
- When in doubt about magit state, press `g` to refresh the buffer.
- If a command seems stuck, `C-g` twice usually cancels.
- For simple git operations like `git commit --amend -m "message"`, using bash directly is often simpler than navigating magit.
