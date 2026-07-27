---
name: wayland-automation
description: Automate the niri Wayland compositor - query and manage windows via niri IPC (JSON + jq), take screenshots of specific windows via OBS dynamic cast + obs-cmd, send keyboard/text input via wtype, control the mouse with wlrctl, and manipulate the clipboard with wl-clipboard. Only works on niri/Wayland, not X11.
---

# Wayland Automation with niri

Patterns for automating a niri Wayland desktop: querying windows, taking screenshots, sending input, and clipboard operations.

Tools: `niri msg` (IPC), `obs-cmd` (OBS WebSocket), `wtype` (virtual keyboard), `wlrctl` (virtual pointer/mouse), `wl-copy`/`wl-paste` (clipboard), `jq` (JSON filtering).

## Environment Check

```bash
echo $WAYLAND_DISPLAY   # should print wayland-1 or similar
pgrep niri               # should return a PID
```

If either fails, this skill does not apply.

---

## Nested Niri Sessions (Recommended for Automation)

Running a nested niri-inside-niri session allows the agent to interact with GUI applications without disrupting the user's desktop. The nested session is an isolated Wayland compositor running inside a window on the parent desktop.

### When to use nested sessions

Ask the user whether they want a nested session. Use nested when:
- The agent needs to move the mouse, click, or type into GUI apps
- The user wants to keep using their desktop while the agent works
- You need a controlled, predictable environment (single output, known geometry)

Use the parent session directly when:
- You only need to take screenshots (OBS dynamic cast works without mouse control)
- The user explicitly wants you to interact with their live desktop

### Starting a nested niri session

Ask the user if they already have a nested niri running. If so, they will provide the socket path. If not, start one:

```bash
# Start nested niri in the background
niri &
```

niri will print its IPC socket path on startup, e.g.:
```
IPC listening on: /run/user/1000/niri.wayland-2.1708311.sock
```

Extract the WAYLAND_DISPLAY name and NIRI_SOCKET path from the output. The WAYLAND_DISPLAY is the `wayland-N` portion (e.g., `wayland-2`).

### Environment variables for nested session

All CLI tools must be told to target the nested session via environment variables:

```bash
# For niri IPC commands:
NIRI_SOCKET=/run/user/1000/niri.wayland-2.XXXXXXX.sock niri msg --json windows

# For wlrctl (mouse control):
WAYLAND_DISPLAY=wayland-2 wlrctl pointer move 100 50

# For wtype (keyboard input):
WAYLAND_DISPLAY=wayland-2 wtype "Hello"

# For wl-clipboard:
WAYLAND_DISPLAY=wayland-2 wl-copy "text"
WAYLAND_DISPLAY=wayland-2 wl-paste

# For launching GUI apps inside the nested session:
WAYLAND_DISPLAY=wayland-2 some-app &
```

You can set both variables in a shell for convenience:

```bash
export NIRI_SOCKET=/run/user/1000/niri.wayland-2.XXXXXXX.sock
export WAYLAND_DISPLAY=wayland-2
```

### Screenshotting nested sessions

The nested niri appears as a window in the parent niri (title "niri", app_id may be null). Use the parent niri's OBS dynamic cast to capture it:

```bash
# Find the nested niri window in the PARENT niri (no NIRI_SOCKET override)
niri msg --json windows | jq '[.[] | select(.title == "niri")] | first | .id'

# Set dynamic cast target on the parent
niri msg action set-dynamic-cast-window --id <NESTED_NIRI_WINDOW_ID>
sleep 1

# Screenshot via OBS (obs-cmd always talks to OBS on the parent)
obs-cmd save-screenshot "Desktop" "png" "/tmp/nested_screenshot.png"
```

### Mouse control in nested sessions

The corner-anchor technique works cleanly in nested sessions because the nested niri has a single output starting at (0, 0):

```bash
# Anchor to top-left of nested output
WAYLAND_DISPLAY=wayland-2 wlrctl pointer move -9999 -9999

# Move to target position (absolute within nested output)
WAYLAND_DISPLAY=wayland-2 wlrctl pointer move <X> <Y>

# Click
WAYLAND_DISPLAY=wayland-2 wlrctl pointer click
```

### Workflow summary for nested sessions

1. Start or connect to nested niri (get socket path and WAYLAND_DISPLAY)
2. Launch target app inside nested session: `WAYLAND_DISPLAY=wayland-2 some-app &`
3. Set OBS dynamic cast to the nested niri window (via parent niri IPC)
4. Query window layout inside nested session: `NIRI_SOCKET=... niri msg --json windows`
5. Screenshot via OBS, analyze the image
6. Control mouse/keyboard inside nested session using `WAYLAND_DISPLAY=wayland-2` with wlrctl/wtype

---

## niri IPC

niri exposes window and workspace state via `niri msg`. Use `--json` for machine-readable output.

### List all windows

```bash
niri msg --json windows
```

Returns a JSON array. Each object has: `id` (int), `title` (string), `app_id` (string), `pid` (int), `workspace_id` (int), `is_focused` (bool), `is_floating` (bool), `is_urgent` (bool), and a `layout` object.

The `layout` object contains:
- `tile_pos_in_workspace_view`: [x, y] position of the tile in logical coordinates relative to the workspace viewport, or `null` if the window is scrolled out of view
- `tile_size`: [width, height] of the tile in logical pixels
- `window_size`: [width, height] of the window content
- `window_offset_in_tile`: [x, y] offset of the window within its tile (usually [0, 0])

### Find a window ID with jq

```bash
# By app_id (exact match)
niri msg --json windows | jq '[.[] | select(.app_id == "firefox")] | first | .id'

# By app_id (pattern, case-insensitive)
niri msg --json windows | jq '[.[] | select(.app_id | test("ghostty"; "i"))] | first | .id'

# By title substring (case-insensitive)
niri msg --json windows | jq '[.[] | select(.title | test("some pattern"; "i"))] | first | .id'
```

A result of `null` means no matching window is open.

### Other queries

```bash
niri msg focused-window          # active window info
niri msg --json focused-window   # same, as JSON
niri msg workspaces              # list workspaces
niri msg --json focused-output   # focused monitor info
```

### Window actions

```bash
niri msg action focus-workspace 2          # switch workspace
niri msg action close-window               # close focused window
niri msg action focus-window --id <ID>     # focus a specific window
```

---

## Screenshot a Specific Application Window

Captures a single window by routing it through niri's dynamic cast target and taking a screenshot via OBS Studio.

Requirements: niri, OBS Studio running with WebSocket server enabled, a Screen Capture source configured to capture "niri Dynamic Cast Target", and `obs-cmd`.

### Step 1: Verify OBS is running

```bash
obs-cmd scene current
```

If this errors, ABORT. Tell the human: "OBS must be open with WebSocket server enabled, and a Screen Capture source configured to capture the 'niri Dynamic Cast Target' window."

### Step 2: Discover the OBS source name

```bash
obs-cmd scene-item list <SCENE_NAME>
```

Use the scene name from step 1. Look for the Screen Capture source name in the output. Note the exact name for step 6.

If no suitable source is found, ABORT and ask the human to configure a Screen Capture source in OBS that captures "niri Dynamic Cast Target".

### Step 3: Find the target window's niri ID

The target application must already be open. Use the jq patterns from the "niri IPC" section above.

If the result is `null`, ABORT and tell the human the application must be open first.

### Step 4: Set dynamic cast target

```bash
niri msg action set-dynamic-cast-window --id <WINDOW_ID>
```

### Step 5: Wait for cast to establish

```bash
sleep 1
```

### Step 6: Take screenshot via OBS

```bash
obs-cmd save-screenshot "<SOURCE_NAME>" "png" "<OUTPUT_PATH>"
```

- SOURCE_NAME: the source name discovered in step 2
- OUTPUT_PATH: absolute path ending in `.png`
- Optional: `--width <N>` and `--height <N>` for custom dimensions

### Step 7: Clear cast target (optional)

```bash
niri msg action clear-dynamic-cast-target
```

---

## Text and Key Input (wtype)

wtype simulates keyboard input on Wayland via the virtual-keyboard protocol. It is like xdotool type for Wayland.

### Basic text

```bash
wtype "Hello World"
```

### Special keys (-k for press-and-release)

```bash
wtype -k Return       # Enter
wtype -k Tab
wtype -k Escape
wtype -k BackSpace
wtype -k Delete
wtype -k space
wtype -k Up
wtype -k Down
wtype -k Left
wtype -k Right
wtype -k Home
wtype -k End
wtype -k Page_Up
wtype -k Page_Down
wtype -k F1           # through F12
```

Key names are resolved by libxkbcommon.

### Modifiers (-M to press, -m to release)

Valid modifiers: `shift`, `capslock`, `ctrl`, `logo` (Super/Win), `alt`, `altgr`.

```bash
wtype -M ctrl -k c          # Ctrl+C
wtype -M ctrl -k v          # Ctrl+V
wtype -M ctrl -k a          # Ctrl+A
wtype -M ctrl -k s          # Ctrl+S
wtype -M ctrl -k z          # Ctrl+Z
wtype -M alt -k Tab         # Alt+Tab
wtype -M alt -k F4          # Alt+F4
wtype -M shift -k Tab       # Shift+Tab
wtype -M logo -k d          # Super+D
wtype -M ctrl -M shift -k t # Ctrl+Shift+T
```

Modifiers are released automatically when wtype exits.

### Multi-line and sequenced input

wtype does not interpret `\n`. Use separate invocations with key presses between them:

```bash
wtype "Line 1" && wtype -k Return && wtype "Line 2"
```

### Timing control

```bash
wtype -d 50 "slow typing"                      # 50ms delay between keystrokes
wtype -s 500 -k Return                         # sleep 500ms then press Enter
wtype "first" && sleep 0.5 && wtype "second"   # shell-level delay between commands
```

### Press and release separately (-P / -p)

```bash
wtype -P ctrl          # press ctrl (hold)
wtype -k c             # type c while ctrl is held
wtype -p ctrl          # release ctrl
```

### Read from stdin

```bash
echo "text to type" | wtype -
```

---

## Mouse Control (wlrctl)

wlrctl provides virtual pointer control on Wayland via the wlr-virtual-pointer protocol. It supports relative mouse movement, clicking, and scrolling.

### Click

```bash
wlrctl pointer click              # left click (default)
wlrctl pointer click left         # explicit left click
wlrctl pointer click right        # right click
wlrctl pointer click middle       # middle click
```

Supported buttons: `left`, `right`, `middle`, `extra`, `side`, `forward`, `back`.

### Move (relative only)

wlrctl moves the cursor by a relative displacement in pixels. There is no absolute positioning.

```bash
wlrctl pointer move 100 0         # move 100px right
wlrctl pointer move -50 0         # move 50px left
wlrctl pointer move 0 200         # move 200px down
wlrctl pointer move 0 -100        # move 100px up
wlrctl pointer move 50 -30        # move diagonally
```

dx = positive right, negative left. dy = positive down, negative up.

### Scroll

```bash
wlrctl pointer scroll 5 0         # scroll down
wlrctl pointer scroll -5 0        # scroll up
wlrctl pointer scroll 0 3         # scroll right
wlrctl pointer scroll 0 -3        # scroll left
```

Arguments are `<dy> <dx>` (vertical first, then horizontal).

### Move cursor to a known absolute position (corner-anchor technique)

Since wlrctl only supports relative movement, establish a known position by overshooting to a corner, then move by exact offset:

```bash
# 1. Anchor to top-left corner of the output
wlrctl pointer move -9999 -9999

# 2. Move to the desired absolute position (in output-local logical pixels)
wlrctl pointer move <TARGET_X> <TARGET_Y>
```

This works because the compositor clamps the cursor at the output edge.

### Click at a specific position within a window

Combine the corner-anchor technique with niri IPC layout data to click at a pixel offset inside a window.

```bash
# 1. Anchor to top-left corner
wlrctl pointer move -9999 -9999

# 2. Get the window's position on the output
LAYOUT=$(niri msg --json focused-window | jq '.layout')
TILE_X=$(echo "$LAYOUT" | jq '.tile_pos_in_workspace_view[0]')
TILE_Y=$(echo "$LAYOUT" | jq '.tile_pos_in_workspace_view[1]')
OFF_X=$(echo "$LAYOUT" | jq '.window_offset_in_tile[0]')
OFF_Y=$(echo "$LAYOUT" | jq '.window_offset_in_tile[1]')

# 3. Compute absolute position: window origin + offset within window
#    TX, TY are the target pixel coordinates within the window (0,0 = top-left)
TX=35   # e.g. x position of "File" menu
TY=80   # e.g. y position of "File" menu
TARGET_X=$(echo "$TILE_X + $OFF_X + $TX" | bc)
TARGET_Y=$(echo "$TILE_Y + $OFF_Y + $TY" | bc)

# 4. Move and click
wlrctl pointer move $TARGET_X $TARGET_Y
wlrctl pointer click
```

Note: `tile_pos_in_workspace_view` is `null` when the window is scrolled out of the visible viewport. The window must be visible on screen for this to work.

### wlrctl window management

wlrctl also provides window management via the foreign toplevel protocol. Match windows by `app_id`, `title`, or `state`.

```bash
wlrctl window focus firefox                         # focus by app_id
wlrctl window focus title:"My Window"               # focus by title
wlrctl window close app_id:firefox                  # close by app_id
wlrctl window maximize app_id:firefox               # maximize
wlrctl window minimize app_id:signal                # minimize
wlrctl window fullscreen title:"Video"              # fullscreen
wlrctl window find firefox                          # exit 0 if window exists
wlrctl window waitfor app_id:firefox                # block until window appears
```

### Multi-output gotcha: focus across monitors

`wlrctl window focus` may fail to activate a window when the cursor is on a different output. Use `niri msg action focus-window --id <ID>` instead -- it works across outputs:

```bash
ID=$(niri msg --json windows | jq '[.[] | select(.app_id == "firefox")] | first | .id')
niri msg action focus-window --id "$ID"
```

Note: `focus-window` does NOT warp the mouse cursor into the window. After focusing, the cursor may still be on a different output. To also move the cursor, combine with the corner-anchor technique on the correct output.

### wl-kbptr (human-interactive mouse positioning)

wl-kbptr is a keyboard-driven mouse positioning tool. It overlays a grid on the screen and lets the user select a position by typing label characters, then refines with binary subdivision. Press Enter to finalize the cursor position, Escape to cancel.

wl-kbptr does NOT work with virtual keyboards (wtype/wlrctl keyboard). It only responds to physical keyboard input. This makes it unsuitable for fully automated agent workflows. Use it when:
- A human is in the loop and can type on a physical keyboard
- You need the human to precisely position the cursor for you

```bash
# Default mode (tile grid, then bisect refinement)
WAYLAND_DISPLAY=wayland-2 wl-kbptr

# Bisect-only mode (4 quadrants, keep subdividing)
WAYLAND_DISPLAY=wayland-2 wl-kbptr -o 'modes=bisect'

# Split mode (arrow keys to narrow down)
WAYLAND_DISPLAY=wayland-2 wl-kbptr -o 'modes=split'

# Print coordinates only (don't move cursor or click)
WAYLAND_DISPLAY=wayland-2 wl-kbptr --only-print

# Restrict to a specific area
WAYLAND_DISPLAY=wayland-2 wl-kbptr --restrict '800x600+100+50'
```

Bisect home row keys: a/s/d/f select quadrants (top-left/top-right/bottom-left/bottom-right), g = left click, h = right click, b = middle click. Backspace undoes the last selection. Enter/Space confirms.

---

## Clipboard (wl-clipboard)

### Copy

```bash
echo "text" | wl-copy                      # text to clipboard
wl-copy < file.txt                          # file contents
wl-copy --type image/png < image.png        # image
wl-copy --primary "text"                    # primary selection
```

### Paste

```bash
wl-paste                                    # get clipboard text
wl-paste --type text/plain                  # specific MIME type
wl-paste --type image/png > image.png       # image from clipboard
wl-paste --list-types                       # list available types
```

### Watch clipboard changes

```bash
wl-paste --watch echo "Clipboard changed"
```

---

## obs-cmd Reference

obs-cmd controls OBS Studio via the obs-websocket v5 protocol. Default connection: `obsws://localhost:4455/secret`. Override with `--websocket` flag or `OBS_WEBSOCKET_URL` env var.

### Scenes

```bash
obs-cmd scene current                        # get current scene name
obs-cmd scene switch "Scene Name"            # switch scene
obs-cmd scene-item list "Scene" "Source"      # list scene items
obs-cmd scene-item enable "Scene" "Source"    # show source
obs-cmd scene-item disable "Scene" "Source"   # hide source
obs-cmd scene-item toggle "Scene" "Source"    # toggle visibility
```

### Screenshots

```bash
obs-cmd save-screenshot "Source" "png" "/path/to/file.png"
obs-cmd save-screenshot "Source" "jpg" "/path/to/file.jpg" --width 1920 --height 1080
obs-cmd save-screenshot "Source" "jpg" "/path/to/file.jpg" --compression-quality 90
```

### Recording

```bash
obs-cmd recording start
obs-cmd recording stop
obs-cmd recording toggle
obs-cmd recording status
```

### Streaming

```bash
obs-cmd streaming start
obs-cmd streaming stop
obs-cmd streaming toggle
obs-cmd streaming status
```

### Audio

```bash
obs-cmd audio toggle "Mic/Aux"
obs-cmd audio mute "Desktop Audio"
obs-cmd audio unmute "Mic/Aux"
obs-cmd audio status "Mic/Aux"
```

### System info

```bash
obs-cmd info
```

---

## Practical Patterns

### Form input

```bash
wtype "username"
wtype -k Tab
wtype "password"
wtype -k Tab
wtype -k Return
```

### Select all, copy, read

```bash
wtype -M ctrl -k a
sleep 0.1
wtype -M ctrl -k c
content=$(wl-paste)
echo "$content"
```

### Paste from clipboard

```bash
echo "new content" | wl-copy
wtype -M ctrl -k v
```

### Unicode via clipboard (wtype does not go through IME)

```bash
echo "日本語テキスト" | wl-copy
wtype -M ctrl -k v
```

---

## Troubleshooting

| Problem | Fix |
|---|---|
| `obs-cmd` connection refused | Enable WebSocket server in OBS: Tools > WebSocket Server Settings |
| Screenshot is black/empty | Verify OBS Screen Capture source captures "niri Dynamic Cast Target" |
| `save-screenshot` source not found | Run `obs-cmd scene-item list <SCENE>` for exact source name (case-sensitive) |
| Window ID is `null` | App not open or app_id/title pattern wrong; run `niri msg --json windows` to inspect |
| `niri msg` not found | Ensure niri IPC socket is available; only works on niri/Wayland |
| wtype does nothing | Check `$WAYLAND_DISPLAY` is set and niri is running |
| wlrctl click/move has no effect | Check `$WAYLAND_DISPLAY`; ensure niri supports wlr-virtual-pointer-unstable-v1 |
| Mouse not at expected position after focus | `focus-window` does not warp cursor; use corner-anchor technique instead |
| Nested niri: commands affect parent | Set `WAYLAND_DISPLAY` for wlrctl/wtype/wl-clipboard, `NIRI_SOCKET` for niri msg |
| Nested niri: app opens on parent desktop | Launch app with `WAYLAND_DISPLAY=wayland-2` to target nested session |
| Clipboard empty | Check `wl-paste --list-types`; ensure wl-clipboard can connect to Wayland |
