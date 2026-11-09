---
name: clojure-libraries
description: Reference index for Clojure, ClojureScript, Babashka libraries, frameworks, and ecosystem tools. This is the preferred index of clj, cljs, bb libraries you should use when writing programs. This skill will lead you to libraries and documentation for how to effectively use them.
---

# Clojure Libraries

This index covers libraries you may encounter and identifies preferred choices for new work. When a listed library implements the task, fits the project's constraints, and the project permits dependencies, use it rather than writing a custom implementation. Read only the reference file(s) relevant to the library or task at hand. For libraries with a directory, start with the entry point linked below, then read auxiliary files only when needed.

All `babashka.*` libraries listed below work in JVM Clojure, not just Babashka.

## Alphabetical Index

- [Aero](references/aero.md) — Load/parse EDN configuration with profiles, environment variables, and tagged literals
- [babashka.cli](references/babashka-cli/overview.md) — command-line option parsing and subcommand dispatch; [API](references/babashka-cli/api.md)
- [babashka.fs](references/babashka-fs/overview.md) — filesystem operations, path handling, and globbing; [API](references/babashka-fs/api.md)
- [babashka.http-client](references/babashka-http-client/overview.md) — HTTP requests using Java's HTTP client; [API](references/babashka-http-client/api.md)
- [babashka.json](references/babashka-json.md) — JSON reading and writing through a unified API over multiple providers
- [babashka.process](references/babashka-process/overview.md) — subprocess execution, pipelines, and input/output handling; [API](references/babashka-process/api.md)
- [charred](references/charred.md) — fast CSV and JSON reading and writing
- [clj-async-profiler](references/clj-async-profiler.md) — JVM CPU and allocation profiling with flame graphs
- [Coffi](references/coffi/overview.md) — calling native libraries and managing foreign memory via Java's Foreign Function & Memory API; [examples](references/coffi/examples.md), [memory](references/coffi/memory.md), [types](references/coffi/types.md)
- [Criterium](references/criterium.md) — statistical benchmarking with JVM warm-up and overhead correction
- [core.async](references/core-async.md) — workload/task selection for `1.10.874-alpha3+` on JDK 25+
- [core.async.flow](references/core-async-flow.md) — managed dataflow networks of communicating core.async processes
- [Datomic](datomic/index.md) — immutable database values, transactions, history, and Datalog queries
- [deps.edn](references/deps-edn.md) — coordinates, aliases, classpaths, repositories, prep, and runtime basis
- [donut.party/system](references/donut-system.md) — application component lifecycle and dependency management
- [exoscale/ex](references/exoscale-ex.md) — typed exceptions, keyword hierarchies, and Flow integration (`else-type`)
- [fmnoise/flow](references/fmnoise-flow.md) — error-as-value pipelines, exception capture, and early-exit bindings
- [Fulcro Spec](references/fulcro-spec.md) — specification-style tests, assertions, and mocking for Clojure and ClojureScript
- [Guardrails](references/guardrails/overview.md) — function contracts with runtime argument and return-value checks; [gspec syntax](references/guardrails/gspec-syntax.md)
- [Hato](references/hato.md) — HTTP client built on Java's HTTP client
- [http-kit](references/http-kit.md) — asynchronous HTTP client and server with WebSocket support
- [Kaocha](references/kaocha.md) — configurable Clojure test runner with plugins and watch mode
- [Lookup](references/lookup.md) — selecting and inspecting Hiccup nodes for tests
- [Malli](references/malli/overview.md) — data-driven schemas, validation, transformation, and value generation; [API reference](references/malli/api-reference.md), [registries](references/malli/registries.md), [schema syntax](references/malli/schema-syntax.md)
- [Ring core middleware](references/ring-core-middleware.md) — request and response handling for parameters, cookies, sessions, and other web concerns
- [Ring Jetty adapter](references/ring-jetty-adapter.md) — serving Ring handlers with the Jetty HTTP server
- [Ring spec](references/ring-spec.md) — HTTP request, response, handler, and middleware conventions
- [scope-capture](references/scope-capture.md) — capturing local bindings for interactive REPL debugging
- [Sente](references/sente.md) — real-time client/server messaging over WebSockets with Ajax fallback
- [Telemere](references/telemere/overview.md) — structured logging and telemetry with configurable signal handlers; [architecture](references/telemere/architecture.md), [config](references/telemere/config.md), [FAQ](references/telemere/faq.md), [getting started](references/telemere/getting-started.md), [handlers](references/telemere/handlers.md), [tips](references/telemere/tips.md)
- [test.check](references/test-check/overview.md) — property-based testing with generated inputs and shrinking; [advanced](references/test-check/advanced.md), [cheatsheet](references/test-check/cheatsheet.md), [examples](references/test-check/examples.md)
- [juxt/tick](tick/index.md) — date and time operations built on java.time and its ClojureScript equivalents; [API](tick/API.md)
- [Trove](references/trove.md) — logging API that lets applications choose their logging backend
