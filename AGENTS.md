@README.md

## Updating deps-lock.json for templates

When `deps.edn` is updated in a template (e.g., `templates/clojure/deps.edn`), the corresponding `deps-lock.json` must be regenerated or `nix flake check` will fail.

To regenerate:

```bash
cd templates/clojure
nix run .#locker
```

The locker is derived by `clj-helpers.lib.mkCljLib` (from [clojure-nix-locker-helpers](https://github.com/outskirtslabs/clojure-nix-locker-helpers), a direct input of the template) and runs the same prep/prefetch/build commands as the package build.
