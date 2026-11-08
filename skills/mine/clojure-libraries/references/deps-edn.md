# deps.edn reference

Condensed from Alex Miller's [upstream reference](https://github.com/clojure/clojure-site/blob/d664fff7d2967bbb74157082796d28e1731d1d35/content/reference/deps_edn.adoc). Covers the configuration surface, not the full CLI or dependency-resolution algorithm. Example versions illustrate syntax, not version recommendations.

## Paths and dependencies

| Key | Value and effect |
|---|---|
| `:paths` | Ordered collection of source/resource directory strings or keywords referring to path vectors in `:aliases`. Expanded paths precede dependencies on the classpath. |
| `:deps` | Map of qualified library symbols to coordinate maps; resolution expands these direct dependencies to include transitives. |

Paths are relative to the project root. Absolute paths are exceptional; paths outside the project root are deprecated and warn. A local dependency is the appropriate representation of another project.

Path aliases hold vectors directly: `{:paths [:sources] :aliases {:sources ["src/clj" "src/cljc"]}}`.

Dependencies follow project paths, ordered by depth from the root, then alphabetically within each depth. Resolution generally prefers newer versions, subject to constraints; see [dependency expansion](https://clojure.org/reference/dep_expansion), rather than assuming “newest always wins”.

## Coordinates

### Maven

- Library symbol: `groupId/artifactId`; classifier variant: `groupId/artifactId$classifier`.
- Required coordinate: `:mvn/version`, a string such as `"1.2.3"` or `"1.2.3-SNAPSHOT"`.
- Only jar artifacts are supported; a BOM pom is not a supported dependency artifact.
- Download cache defaults to `~/.m2/repository`; `:mvn/local-repo` changes it.

### Git

| Key | Contract |
|---|---|
| `:git/url` | Explicit repository URL, or inferred from the library symbol below. Explicit wins. |
| `:git/sha` | Required: full 40-character SHA, or prefix when paired with `:git/tag`. Legacy `:sha` is accepted. |
| `:git/tag` | Optional tag; must resolve to the same commit as the SHA. Legacy `:tag` is accepted. |

Branches and tags without SHAs are not valid pins. Between ancestor and descendant SHAs, resolution prefers the descendant. Unrelated SHAs cause classpath construction to fail.

| Library-symbol prefix (`ORG/PROJECT` follows) | Inferred URL |
|---|---|
| `io.github.` or `com.github.` | `https://github.com/ORG/PROJECT.git` |
| `io.gitlab.` or `com.gitlab.` | `https://gitlab.com/ORG/PROJECT.git` |
| `io.bitbucket.` or `org.bitbucket.` | `https://bitbucket.org/ORG/PROJECT.git` |
| `io.beanstalkapp.` or `com.beanstalkapp.` | `https://ORG.git.beanstalkapp.com/PROJECT.git` |
| `ht.sr.` | `https://git.sr.ht/~ORG/PROJECT` |
| `org.codeberg.` or `page.codeberg.` | `https://codeberg.org/ORG/PROJECT.git` |

For example, `io.github.clojure/tools.deps.graph` infers the GitHub URL. Public repositories normally use anonymous HTTPS; SSH uses your SSH identity. Other protocols, including local/file, may work. Git working trees are cached per SHA under `~/.gitlibs` by default.

### Local

`:local/root` is required: an absolute path or a path relative to the project directory, pointing to a directory or jar. A local jar's embedded `pom.xml`, if present, supplies transitive dependencies.

### Shared coordinate attributes

| Key | Value and effect |
|---|---|
| `:exclusions` | Vector of library symbols excluded as transitives through this dependency; supported on any dependency. Not a global ban on those libraries. |
| `:deps/root` | Relative subdirectory within a file-based dependency in which to find its manifest; useful for monorepos. |
| `:deps/manifest` | Override manifest detection with `:deps` or `:pom`. Auto-detection prefers `deps.edn` over `pom.xml` when both exist. `:mvn` and `:jar` exist but need not be specified. |

## Aliases

`:aliases` maps names to EDN data consumed by the CLI or other tools. CLI aliases normally contain argument maps; path aliases contain vectors. Custom tool configuration belongs in well-known namespaced aliases: arbitrary top-level keys may not survive processing.

### Dependency and classpath keys

| Alias key | Value | Effect |
|---|---|---|
| `:extra-deps` | `{lib coord}` | Add to the base dependency set. |
| `:override-deps` | `{lib coord}` | Force coordinates instead of the versions resolution would choose. |
| `:default-deps` | `{lib coord}` | Supply coordinates where none were specified; not a force/override. |
| `:replace-deps` (synonym `:deps`) | `{lib coord}` | Replace project `:deps`. |
| `:extra-paths` | Collection of path strings | Add source/resource paths; keep them at or under the project root. |
| `:replace-paths` (synonym `:paths`) | Collection of path strings | Replace project `:paths`. |
| `:classpath-overrides` | `{lib "path"}` | Replace the classpath location found for a dependency, e.g. with local debug classes. |

### Execution keys

| Alias key | Value and effect |
|---|---|
| `:ns-default` | Namespace symbol used to resolve an unqualified `:exec-fn`. |
| `:ns-aliases` | Map of alias symbols to namespace symbols used to resolve qualified `:exec-fn` symbols. |
| `:exec-fn` | Default function symbol for `-X` execution. Unqualified: requires `:ns-default`. Qualified with a known alias: expand via `:ns-aliases`. Otherwise: use as fully qualified. |
| `:exec-args` | Default argument map for `-X` / `-T`; subsequent CLI key/value pairs override defaults. |
| `:jvm-opts` | Collection of JVM option strings for `-M`, `-X`, `-T`, or a REPL. |
| `:main-opts` | Collection of program argument strings for `-M`. Last alias supplying this key wins; values do not accumulate. CLI arguments after `-M` can add main options. |

See the [CLI reference](https://clojure.org/reference/clojure_cli#aliases) for alias selection, per-key merge rules, and mode-specific behavior; do not infer one universal merge rule from this table.

## Maven repository configuration

Top-level `:mvn/repos` maps repository names to configuration maps. Built-ins are checked first, in order: `"central"` (`https://repo1.maven.org/maven2/`), then `"clojars"` (`https://repo.clojars.org/`). Additional repositories must be declared in the top-level project configuration. Repositories in dependency poms or dependency `deps.edn` files are ignored, including those needed for transitives.

| Repository key | Value / default |
|---|---|
| `:url` | Required repository-root URL. HTTP is disabled by default; the CLI documents `CLOJURE_CLI_ALLOW_HTTP_REPO` for exceptions. |
| `:releases` | Optional policy map for release artifacts. |
| `:snapshots` | Optional policy map for snapshot artifacts; same keys as `:releases`. |

Both policy maps accept:

| Policy key | Values / default |
|---|---|
| `:enabled` | Boolean; default `true`. |
| `:update` | `:daily` (default), `:always`, `:never`, or an integer interval in minutes. |
| `:checksum` | `:warn` (default), `:fail`, or `:ignore`. |

Top-level `:mvn/local-repo` is a string path overriding the Maven cache directory. See [CLI Maven configuration](https://clojure.org/reference/clojure_cli#procurer_maven) for additional procurer settings. Local dependencies have no procurer configuration.

## Tool publishing and library preparation

`:tools/usage` supplies installation defaults for deps.edn-based CLI tools loaded from GitHub or local directories. Supported keys: `:exec-args`, `:ns-default`, `:ns-aliases`.

`:deps/prep-lib` declares preparation needed before a source library can be used, such as Java compilation or resource generation. The CLI prevents execution when required prep is incomplete; the declaration is not an automatic build on every run.

| Prep key | Contract |
|---|---|
| `:ensure` | Project-relative directory path; existence means preparation is complete. This is an existence check, not a freshness check. |
| `:alias` | Keyword alias invoked with `-T` for preparation. |
| `:fn` | Function invoked with `-T` for preparation. |

Shape: `{:deps/prep-lib {:ensure "target/classes" :alias :build :fn compile-java}}`. The project must supply that build alias and function; generated classes must be included in its paths.

## Runtime basis

The basis describes the resolved dependency environment and is a superset of merged `deps.edn`. The `clojure.java.basis` API exposes initial and current bases; `add-libs` and related functions may change the current basis.

| Basis key | Meaning |
|---|---|
| `:basis-config` | Inputs used to create the basis; supports recreation, notably by `sync-deps`. See fields below. |
| `:argmap` | Merged arguments used for dependency resolution and classpath computation, supplied through aliases and/or direct args. |
| `:libs` | Every direct/transitive library mapped to its resolved coordinate plus metadata. Its `:paths` vector lists that library's classpath files; most other added keys are non-normative. |
| `:classpath` | Map of path strings to inclusion reasons, usually `{:lib-name lib}` or `{:path-key key}`. |
| `:classpath-roots` | Ordered vector of classpath paths; its entries match `:classpath` keys. Use this vector, not map iteration, for ordering. |

`:basis-config` fields:

- `:dir`: project directory, absolute or relative; defaults to current directory.
- `:root`, `:user`, `:project`: each accepts `:standard`, a path, or a literal map. Standard sources are respectively the classpath, user config directory, and project `:dir`.
- `:extra`: additional source, a path or literal map.
- `:aliases`: vector of selected alias keywords.
- `:args`: explicit argument map applied after alias argument maps merge.
