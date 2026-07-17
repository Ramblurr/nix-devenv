# Datomic Data Modeling Guide

Use this guide before adding schema, choosing reference directions, defining uniqueness, or changing entity lifecycles.
Treat schema as a durable public API and model domain facts rather than tables or object classes.
Confirm whether the target is Datomic Local, Cloud, or Pro before choosing edition-specific APIs or indexes.
If the edition or API remains unknown and changes the decision, stop and ask.

## Design checklist

1. Name the domain entities, facts, identities, relationships, lifetimes, and state transitions.
2. List invariants and decide which layer enforces each one.
3. List the read patterns, history requirements, and expected cardinalities.
4. Prefer additive schema and one stored direction per relationship.
5. Test prospective transactions with `d/with`, then inspect `:db-after`.
6. Exercise retractions, duplicate writes, partial data, races, and migrations before shipping.

## Mental model

- A datom is `[entity attribute value transaction added?]`.
- A database value is an immutable view of all facts at one point in time.
- A connection advances, but a database value does not.
- An entity is an open set of attributes, not a row constrained to one table shape.
- Schema defines attributes and constraints; it does not close entity shapes.
- Reference attributes form a graph and Datomic indexes them in both directions.
- Every transaction also creates a queryable transaction entity.

Capture one database value at the start of a unit of work and pass it through every read.
Repeatedly calling `d/db` can mix facts from different points in time.

## Attribute schema

A basic attribute needs an ident, value type, and cardinality.
Add only the optional behavior the domain requires.

```clojure
{:db/ident       :person/id
 :db/valueType   :db.type/uuid
 :db/cardinality :db.cardinality/one
 :db/unique      :db.unique/identity
 :db/doc         "Stable public identifier for a person"}
```

| Schema attribute | Use |
|---|---|
| `:db/ident` | Name schema entities and enumerated values. |
| `:db/valueType` | Select the stored scalar, ref, or tuple type. |
| `:db/cardinality` | Choose one value or a set of values per entity. |
| `:db/unique` | Enforce database-wide cardinality-one uniqueness and optionally enable upsert. |
| `:db/isComponent` | Declare parent-to-child recursive retraction, not exclusive ownership. |
| `:db/noHistory` | Reduce stored history without guaranteeing privacy or removal. |
| `:db/index` | Request AVET indexing where supported; Cloud maintains every attribute in AVET. |
| `:db/fulltext` | Request eventual full-text indexing in supported editions; Cloud does not support it. |
| `:db.attr/preds` | Validate every transacted value for an attribute. |
| `:db/doc` | Record precise domain meaning, units, format, and lifecycle notes. |

Treat `:db/valueType` as permanent because Datomic cannot update it after creation.
Use namespaced idents and reserve `:db` and `:db.*` for Datomic.
Avoid a local ident name beginning with `_` because it prevents reverse lookup syntax.
Use a consistent scale for every `bigdec` attribute.
Cloud and Local strings have a 4096-character limit, and tuple strings have a 256-character limit.
Before adding uniqueness to an existing Pro attribute, enable AVET, wait for `sync-schema`, and verify current values are unique.
`:db/noHistory` is a storage optimization and can prevent excision from guaranteeing full removal.

## Names and entity shapes

Group attributes that usually occur together under a domain namespace such as `:person/name` or `:order/number`.
A namespace communicates expected shape without restricting which attributes an entity may hold.
Reuse a generic attribute such as `:time/created` only when its meaning and lifecycle are identical across entity kinds.

Plan for accretion.
Code should select the attributes it understands instead of assuming an entity has a fixed or exhaustive set of keys.
Do not iterate an entire entity map into side effects or serialized output.

## Identity and enumerations

Use `:db.unique/identity` for stable external keys such as UUIDs, account numbers, and product codes.
It supports lookup refs and upsert by unifying transaction data with an existing entity.
Use `:db.unique/value` when duplicates must fail rather than unify.
Remember that one tempid carrying unique identities owned by different existing entities causes a conflict.
Historical databases may still contain duplicates that predate a uniqueness constraint.

Use lookup refs to name existing entities in writes instead of querying their eids first.
Transaction lookup refs resolve against `db-before`, so they cannot identify an entity created in the same transaction.

```clojure
[:db/add
 [:person/id #uuid "7cf6c5da-cb6f-4b41-9650-bc1ee35f6744"]
 :person/name
 "Ada"]
```

Represent enumeration values as ref targets whose entities have idents.

```clojure
[{:db/ident       :person/status
  :db/valueType   :db.type/ref
  :db/cardinality :db.cardinality/one}
 {:db/ident :person.status/active}
 {:db/ident :person.status/suspended}]
```

Transact every enum ident before referencing it.
Idents name enum values but do not constrain a ref to that set; enforce closed membership separately.
Do not use idents for ordinary domain identities or fixture-only names because all idents remain resident in compute memory.

## Reference direction

Store each relationship once.
Datalog can traverse either direction, and pull supports reverse references.
Do not maintain inverse attributes such as both `:release/artists` and `:artist/releases`.

For a one-to-many container relationship, default to a cardinality-one ref from contained entity to container.
For example, prefer `:passenger/vehicle` over `:vehicle/passengers` when a passenger belongs to at most one vehicle.

| Concern | Prefer `:contained/container` | Prefer `:container/contained` |
|---|---|---|
| One-container invariant | Cardinality one enforces one current parent with normal last-write-wins behavior. | Requires additional invariant enforcement. |
| Entity and pull size | Keeps the forward collection small. | Can create very large forward collections. |
| EAVT history | Shows parent changes on each contained entity. | Mixes membership churn into the container history. |
| Schema discovery | Reverse relationship needs documentation or metaschema. | Container schema visibly names its children. |
| Component lifetime | Cannot encode parent-owned component cascade on this ref. | Required because `:db/isComponent` belongs on the parent-to-child ref. |
| `d/index-pull` | Needs VAET or AVET; Pro may need `:db/index`. | Supports efficient forward index-pull pagination. |
| Heavy membership churn | May touch more dispersed EAVT and AEVT segments. | May cluster updates around fewer container entities. |

Pull limits a many-valued ref to 1000 results by default and does not page through that collection.
Use a query or suitable index access for unbounded relationships.
Document important reverse refs because `d/touch` and wildcard pull do not reveal them.
Add a custom ref-range annotation or entity spec when namespace inspection cannot explain the graph.

## Components and lifetimes

Place `:db/isComponent true` on a parent-to-child ref only when the child exists solely as part of the parent.
This lifetime requirement is one reason to choose `:container/contained` over the lower-cardinality default.
Component status enables recursive retraction but does not enforce exclusive ownership; enforce one-parent ownership separately.
`retractEntity` retracts the target's facts, incoming refs, and recursive components, so it can also rewrite composite values.
A tuple component attribute is unrelated to `:db/isComponent`.

Prefer explicit domain states such as `:account.status/closed` or `:student.status/unenrolled` over using entity retraction as a lifecycle model.
Existence, eligibility, archival, and deletion are different domain concepts.
References do not provide SQL-style foreign-key policies.

Centralize destructive operations when incoming refs or composites matter.
A domain transaction function can reject deletion, cascade selected relationships, retract selected facts, or preserve an audit state.
Use raw `retractEntity` only after checking incoming refs, components, tuple effects, and history requirements.

## Invariants and validation

Choose enforcement by scope.

| Mechanism | Enforcement |
|---|---|
| Boundary validation | Rejects malformed requests early but cannot protect other writers. |
| Attribute predicate | Automatically checks asserted values for one attribute. |
| Unique attribute | Automatically protects one current database-wide value. |
| Transaction function | Checks preconditions and derives atomic transaction data from `db-before`. |
| Entity spec with `:db/ensure` | Checks required attributes and entity predicates only when the transaction opts in. |
| Domain transaction builder | Makes valid operations easy but requires all callers to use it. |

Attribute and entity predicates must be available to the process performing the transaction.
Installing a predicate or entity spec does not retroactively validate existing data.
A required attribute in an entity spec is not globally required because each relevant transaction must assert `:db/ensure`.
Keep transaction functions and entity predicates minimal and pure because both run in the serialized write path.
Keep attribute predicates cheap because Datomic invokes them for every relevant value.

## Unique tuples

Tuples contain two to eight scalar values, and `nil` is legal in any slot.
Use tuples for multi-attribute identity or to avoid expensive joins across high-population attributes.

A composite tuple declares `:db/tupleAttrs` and Datomic derives its value whenever a member attribute changes.
A heterogeneous tuple declares `:db/tupleTypes` and application transaction data asserts its value explicitly.
A homogeneous tuple declares one `:db/tupleType` for a variable-length sequence.

Treat a unique composite as a high-commitment choice.
Use one only when its members are stable, lifecycle operations are controlled, and `nil` has the required uniqueness semantics.

Composite footguns:

- Missing or retracted member attributes become `nil` tuple slots.
- Datomic treats matching `nil` slots as equal for uniqueness.
- Retracting one referenced entity can leave many derived tuples with colliding partial values.
- Datomic always maintains a composite when any member changes.
- Composite membership cannot be changed or maintenance disabled later.
- Installing a composite does not backfill existing entities until a member attribute is transacted again.

Prefer an explicitly maintained heterogeneous unique tuple when members are optional, derived, mutable, or likely to evolve.
The application can omit that tuple while a member is absent and can later deprecate the attribute without automatic composite maintenance.
This flexibility shifts responsibility to the transaction operations that create and change the entity.

If a deployed composite proves wrong, retract its uniqueness and optional Pro AVET index, mark it deprecated, and stop depending on it.
Cloud retains AVET, and every edition continues automatic composite maintenance.
Never reuse its name for a different meaning.
Backfill a new composite gradually by reasserting one member value in bounded batches.

## Schema evolution and migrations

Grow schema by adding attributes, enum entities, relationships, specs, predicates, and annotations.
Never remove a public name or reuse it with a different meaning.
When meaning or type changes, add a versioned replacement and migrate consumers and data.

Add an alias by asserting another ident on the same schema entity while retaining the old ident.

```clojure
[:db/add :person/email :db/ident :person/primary-email]
```

Annotate deprecated attributes with `:db/doc` and project-specific metadata such as `:schema/see-instead`.
Schema is ordinary data, so keep installation transactions in source control and make additive installation idempotent.

Run data migrations as named, retry-safe domain operations.
When a migration fits one transaction, guard its application and record completion in that transaction.
For a batched migration, persist resumable checkpoints or atomic claims and record completion only after the final batch succeeds.
Use bounded batches for large rewrites and preserve application compatibility throughout mixed old and new data.

Use `d/with` to rehearse migrations and inspect `:db-after` before transacting.
Use the real transaction result's `:db-after` to observe exactly that transaction rather than a later connection value.

## Transaction design

Make domain command functions return transaction data instead of writing directly when practical.
This keeps business rules composable and lets tests exercise them with `d/with`.
Route writes that affect invariants through a small set of named operations.

Add facts about who, why, source, request, and correlation to the transaction entity.

```clojure
[{:db/id            "datomic.tx"
  :tx/source        :source/import
  :tx/correlation-id #uuid "ad6b4e2e-7fd8-45b9-ab84-524557e4daa7"}]
```

Use `:db/cas` for read-modify-write operations that require optimistic concurrency.
Retry only conflict anomalies, refresh the database value before retrying, and bound retries.

When importing history, set `:db/txInstant` only when source time matters.
Imported instants must increase monotonically and must not move ahead of the transactor clock.
Pipeline independent bulk transactions through the async API with bounded concurrency, backpressure, and explicit error handling.

## Read and query design

Use Datalog to identify entities and express joins or rules.
Use pull to shape the returned data and navigate bounded relationships.
On the Peer API, entity values are cheap map-like views tied to an immutable database value and work well inside domain logic.
At process or network boundaries, return explicit pulled maps rather than lazy entity views.

For Datalog:

- Put a selective clause early.
- Make each later clause join through a variable already bound when possible.
- Pass collections with collection bindings instead of running one query per value.
- Use `_` for values that need neither binding nor unification.
- Parameterize query data instead of interpolating strings or rebuilding equivalent query forms.
- Prefer query over raw indexes unless the task is a direct scan, import, export, or external integration.

Peer reads avoid the traditional client-server N+1 round trip, but segment loading and query work still have costs.
Client API locality depends on topology, and Datomic Local runs in process.
Batch inputs and shape results deliberately whenever an API call crosses a process boundary.
Measure representative data before replacing clear queries with index code.

Use `t` or transaction ids when exact ordering matters because multiple transactions can share a millisecond `:db/txInstant`.
Use a history database for audit questions and retain the `added?` value to distinguish assertions from retractions.
Pass multiple database values to one query when identity comes from one time basis and changed facts from another.
Use the log API when transaction time is the most selective criterion.

## Application boundaries

A practical request path has four explicit layers:

1. Capture one database value.
2. Resolve external identities with lookup refs, finders, or pull.
3. Run pure domain functions that return values or transaction data.
4. Serialize an explicit client-facing map.

Do not build a large ORM before ordinary data, pull, and small helper functions prove insufficient.
Keep validation declarations and Datomic schema related, but do not force one abstraction to own persistence, API shape, and all domain rules.

## Tests and development

- Store fixtures as ordinary transaction data.
- Give fixtures stable domain identities rather than `:db/ident` names.
- Install the same schema, predicates, transaction functions, and migration path used in production.
- Prefer Datomic Local for Local or Cloud applications and the Pro in-memory database for Peer applications.
- Test Pro Client applications against a Client topology instead of assuming Peer in-memory behavior.
- Start each mutating test from a fresh database or a supported fork of an immutable fixture baseline.
- Invalidate cached fixture baselines whenever schema or fixture code reloads.
- Test transaction builders with `d/with`, then cover integration behavior against the target edition.
- Rehearse sensitive production-derived data only under the same access and privacy controls as production.

## Reject these defaults

| Anti-pattern | Better default |
|---|---|
| Store both directions of a ref | Store one direction and query the inverse. |
| Use idents as domain IDs | Use a domain attribute with `:db.unique/identity`. |
| Model deletion with `retractEntity` | Model lifecycle state and centralize destructive operations. |
| Put unique composite tuples over optional refs | Enforce lifecycle discipline or use an explicit heterogeneous tuple. |
| Change or reuse an attribute's meaning | Add a new attribute and migrate additively. |
| Call `d/db` before every read | Pass one immutable database value through the unit of work. |
| Build Datalog by string interpolation | Use parameterized query data structures. |
| Pull an unbounded many-ref | Query or page through a suitable index. |
| Reach for raw indexes first | Start with Datalog and pull, then measure. |

## Source notes

This guide condenses the official [Best Practices](06-reference/08-best-practices/best-practices.md), [Data Modeling](06-reference/01-schema/03-data-modeling/data-modeling.md), and [Schema Reference](06-reference/01-schema/01-schema-reference/schema-reference.md).
It also incorporates the supplemental [reference-direction](choosing-ref-directions.md), [unique-composite](unique-composite-attribute-footguns.md), and [web application](datomic-web-app-a-practical-guide.md) articles.
Use the full references for API grammar, edition-specific behavior, and worked examples.
