@README.md

## Updating deps-lock.json for templates

When `deps.edn` is updated in a template (e.g., `templates/clojure/deps.edn`), the corresponding `deps-lock.json` must be regenerated or `nix flake check` will fail.

To regenerate (from within this repo, the template's `devenv` input must be overridden to the local checkout):

```bash
cd templates/clojure
nix run --override-input devenv path:../.. .#locker
```

The locker is derived by `devenv.clojure.mkCljLib` (from [clojure-nix-locker-helpers](https://github.com/outskirtslabs/clojure-nix-locker-helpers)) and runs the same prep/prefetch/build commands as the package build.
