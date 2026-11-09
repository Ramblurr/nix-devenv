@README.md

## Updating deps-lock.json for templates

When `deps.edn` is updated in a template (e.g., `templates/clojure/deps.edn`), the corresponding `deps-lock.json` must be regenerated or `nix flake check` will fail.

To regenerate:

```bash
cd templates/clojure
nix run .#locker
```

The locker is derived by `clj-helpers.lib.mkCljLib` (from [clojure-nix-locker-helpers](https://github.com/outskirtslabs/clojure-nix-locker-helpers), a direct input of the template) and runs the same prep/prefetch/build commands as the package build.

## Maintaining the Claude plugin skill list

When adding, renaming, or deleting a non-harness-specific skill under `skills/` (such as `skills/mine/` or `skills/engineering/`), keep the `skills` array in `.claude-plugin/plugin.json` up to date. This rule does not apply to harness-specific skills. Keep Pi, Codex and T3 skills out of the Claude plugin; its existing `skills/claude/` entry is Claude-specific.
