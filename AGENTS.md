@README.md

## Updating deps-lock.json for templates

When `deps.edn` is updated in a template (e.g., `templates/clojure/deps.edn`), the corresponding `deps-lock.json` must be regenerated or `nix flake check` will fail.

To regenerate:

```bash
cd templates/clojure
deps-lock
```

`deps-lock` is provided by `clj-nix` and is available in the devshell.
