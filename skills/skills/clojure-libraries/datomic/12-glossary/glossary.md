<a id="content"></a>

<a id="glossary"></a>

# Glossary

<a id="outline-container-ACID"></a>

<a id="ACID"></a>

## ACID

<a id="text-ACID"></a>

Atomic, Consistent, Isolated, and Durable

<a id="outline-container-asOf"></a>

<a id="asOf"></a>

## asOf

<a id="text-asOf"></a>

A database value as of a point in time. With asOf, you can reuse existing queries and rules to ask questions about points in time other than the present.

<a id="outline-container-assertion"></a>

<a id="assertion"></a>

## Assertion

<a id="text-assertion"></a>

An atomic fact in the database, associating an [entity](#entity), [attribute](#attribute), [value](#value), and a [tx](#tx). Opposite of a [retraction](#retraction).

<a id="outline-container-attribute"></a>

<a id="attribute"></a>

## Attribute

<a id="text-attribute"></a>

Something that can be said about an [entity](#entity). An attribute has a name, e.g. `:person/first-name`, and a value type, e.g. `:db.type/long`, and a cardinality.

<a id="outline-container-attribute-identifier"></a>

<a id="attribute-identifier"></a>

## Attribute Identifier

<a id="text-attribute-identifier"></a>

An entity identifier that refers to an attribute.

<a id="outline-container-backup-uri"></a>

<a id="backup-uri"></a>

## Backup URI

<a id="text-backup-uri"></a>

A backup URI is a per-database URI specifying a backup location on a local filesytem path with 'file:/full/path/to/backup-directory' or an S3 path with 's3://bucket/prefix'.

<a id="outline-container-basis-t"></a>

<a id="basis-t"></a>

## Basis-t

<a id="text-basis-t"></a>

The database t that is the basis for the current database, i.e. the most recent point-in-time that this database has seen.

<a id="outline-container-cardinality"></a>

<a id="cardinality"></a>

## Cardinality

<a id="text-cardinality"></a>

Property of an [attribute](#attribute) that specifies how many values of the attribute can be associated with a single reference entity. Possible values are `:db.cardinality/one` and `:db.cardinality/many`.

<a id="outline-container-caches"></a>

<a id="caches"></a>

## Caches

<a id="text-caches"></a>

Nodes use a multi-layered cache that consists of an object Cache, [valcache](#valcache), and an EFS Cache.

<a id="outline-container-client"></a>

<a id="client"></a>

## Client

<a id="text-client"></a>

A process that uses a Datomic library to obtain [connection](#connection) to interact with one or more [database](#database).

<a id="outline-container-closed-world-assumption"></a>

<a id="closed-world-assumption"></a>

## Closed World Assumption

<a id="text-closed-world-assumption"></a>

Assumption that truth is what the database knows. Databases that intend to store data of record typically make the closed world assumption. Datomic adheres to the closed world model.

<a id="outline-container-component"></a>

<a id="component"></a>

## Component

<a id="text-component"></a>

A [reference attribute](#reference) that is part of its [entity](#entity). E.g. your arm is a component of you, but your sister isn't. An attribute is a component if it has `:db/isComponent` set to true.

<a id="outline-container-component-attribute"></a>

<a id="component-attribute"></a>

## Component Attribute

<a id="text-component-attribute"></a>

See [component](#component).

<a id="outline-container-compute-group"></a>

<a id="compute-group"></a>

## Compute-group

<a id="text-compute-group"></a>

An Auto Scaling Group of compute resources, either a primary compute group or a query group.

<a id="outline-container-connection"></a>

<a id="connection"></a>

## Connection

<a id="text-connection"></a>

Client object that provides access to a database. Programs can use a connection to submit transactions.

<a id="outline-container-consistent-hash-ring"></a>

<a id="consistent-hash-ring"></a>

## Consistent Hash Ring

<a id="text-consistent-hash-ring"></a>

Datomic uses a consistent hash ring to route transactions to a preferred Node per database. This is a performance optimization only: any Primary Compute Node can handle any transaction.

<a id="outline-container-coordination"></a>

<a id="coordination"></a>

## Coordination

<a id="text-coordination"></a>

The ability of a group of processes to negotiate who is responsible for the various [roles](#role) in a Datomic [system](#system).

<a id="outline-container-covering-index"></a>

<a id="covering-index"></a>

## Covering Index

<a id="text-covering-index"></a>

A covering index contains (rather than points to) the data. Datomic indexes are covering indexes.

<a id="outline-container-credentials"></a>

<a id="credentials"></a>

## Credentials

<a id="text-credentials"></a>

Information used to authenticate for a particular task. In accordance with the principle of least privilege, Datomic allows separate credentials for each different activity performed by a running system.

<a id="outline-container-database"></a>

<a id="database"></a>

## Database

<a id="text-database"></a>

A database is a set of datoms.

<a id="outline-container-datom"></a>

<a id="datom"></a>

## Datom

<a id="text-datom"></a>

An atomic fact in a database, composed of entity/attribute/value/transaction/added. Pronounced like "datum", but pluralized as datoms.

<a id="outline-container-database-uri"></a>

<a id="database-uri"></a>

## Database URI

<a id="text-database-uri"></a>

A Unique Resource Identifier pointing to a specific Datomic database. URI syntax is described in the [datomic.api/connect](../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/connect) doc string.

<a id="outline-container-data-function"></a>

<a id="data-function"></a>

## Data Function

<a id="text-data-function"></a>

A function installed in a database, i.e. an attribute value whose type is `:db/fn`.

<a id="outline-container-Datalog"></a>

<a id="Datalog"></a>

## Datalog

<a id="text-Datalog"></a>

A deductive query system, typically consisting of:

- A database of facts
- A set of rules for deriving new facts from existing facts
- A query processor that, given some partial specification of a fact or rule: finds all instances of that specification implied by the database and rules, i.e. all the matching facts

Datomic's built-in [query](#query) is an implementation of Datalog.
<a id="outline-container-domain-attribute"></a>

<a id="domain-attribute"></a>

## Domain attribute

<a id="text-domain-attribute"></a>

An attribute used to model something in your application domain.

<a id="outline-container-edn"></a>

<a id="edn"></a>

## EDN

<a id="text-edn"></a>

The [extensible data notation](https://github.com/edn-format/edn) is used by Datomic and other applications as a data transfer format.

<a id="outline-container-EFS-cache"></a>

<a id="EFS-cache"></a>

## EFS Cache

<a id="text-EFS-cache"></a>

A cache of segments in EFS that will typically contain the entirety of all databases, eliminating the need to read from S3.

<a id="outline-container-encrypted-credentials"></a>

<a id="encrypted-credentials"></a>

## Encrypted Credentials

<a id="text-encrypted-credentials"></a>

Encrypted form of credentials. Datomic encrypts credentials in places like EC2 user data to reduce the threat generic exploits.

<a id="outline-container-ensure"></a>

<a id="ensure"></a>

## Ensure

<a id="text-ensure"></a>

An operation that guarantees the existence and correct configuration of a resource. Ensure is typically built out of AWS primitives that create, query, and update resources.

<a id="outline-container-entity"></a>

<a id="entity"></a>

## Entity

<a id="text-entity"></a>

The first component of a [datom](#datom), specifying who or what the datom is about. Also the collection of datoms associated with a single entity, as in the Java type, Entity.

<a id="outline-container-entity-id"></a>

<a id="entity-id"></a>

## Entity id

<a id="text-entity-id"></a>

An opaque identifier assigned by Datomic that uniquely identifies an entity. Entity ids are integers for efficiency, but application programs should treat them as opaque ids.

<a id="outline-container-entity-identifier"></a>

<a id="entity-identifier"></a>

## Entity Identifier

<a id="text-entity-identifier"></a>

A value that identifies an entity. Can be an entity id, an ident, or a lookup ref.

<a id="outline-container-environment"></a>

<a id="environment"></a>

## Environment

<a id="text-environment"></a>

An instantiated set of all the resources need to run an application.

<a id="outline-container-external-key"></a>

<a id="external-key"></a>

## External Key

<a id="text-external-key"></a>

A unique identifier external to Datomic. Typical external key types are email address, UUID, and URI. External key attributes should be declared as `:db.unique/identity`.

<a id="outline-container-epoch"></a>

<a id="epoch"></a>

## Epoch

<a id="text-epoch"></a>

Period of time bounded by writing index to storage. During an epoch, indexing is done in memory. At epoch boundaries, the in-memory index is merged with the persistent index, and a new persistent index is written to the storage service (without blocking the system).

<a id="outline-container-excision"></a>

<a id="excision"></a>

## Excision

<a id="text-excision"></a>

The complete removal of a set of [datoms](#datom) matching a predicate. Excision should be a very infrequent operation, and should not be used to correct erroneous data.

<a id="outline-container-fact"></a>

<a id="fact"></a>

## Fact

<a id="text-fact"></a>

See [datom](#datom).

<a id="outline-container-Fressian"></a>

<a id="Fressian"></a>

## Fressian

<a id="text-Fressian"></a>

[Fressian](https://github.com/Datomic/fressian/wiki/Rationale) is an extensible binary format that is used everywhere data is serialized by Datomic: on the wire, at rest, and in caches. Fressian is designed to be:

- Self-describing
- Language-independent
- Extensible
- Simple to implement and consume
- Compact and fast
- Friendly to dynamic and static languages
- Compressible in domain-specific ways

<a id="outline-container-keyword"></a>

<a id="keyword"></a>

## Keyword

<a id="text-keyword"></a>

Data type representing a name, e.g. `:email` or (with namespace) `:customer/email`.

<a id="outline-container-ident"></a>

<a id="ident"></a>

## Ident

<a id="text-ident"></a>

A value of type `:db/ident` that uniquely identifies an [entity](#entity).

<a id="outline-container-index"></a>

<a id="index"></a>

## Index

<a id="text-index"></a>

Sorted collection of datoms. Indexes are named by the order in which datom components are used for sort, e.g. An index that sorts first by [entity](#entity), then [attribute](#attribute), then [value](#value), then [tx](#tx) is called EAVT.

<a id="outline-container-infrastructure"></a>

<a id="infrastructure"></a>

## Infrastructure

<a id="text-infrastructure"></a>

The set of all environments for an application.

<a id="outline-container-ions"></a>

<a id="ions"></a>

## Ions

<a id="text-ions"></a>

Your application code, running on Datomic compute nodes.

<a id="outline-container-lookup-ref"></a>

<a id="lookup-ref"></a>

## Lookup-ref

<a id="text-lookup-ref"></a>

A list containing a unique attribute and a value that identifies an entity.

<a id="outline-container-lru"></a>

<a id="lru"></a>

## LRU

<a id="text-lru"></a>

Least Recently Used.

<a id="outline-container-metrics"></a>

<a id="metrics"></a>

## Metrics

<a id="text-metrics"></a>

Statistics used to measure the health of a running system. By default, Datomic records metrics using Amazon's CloudWatch.

<a id="outline-container-namespace"></a>

<a id="namespace"></a>

## Namespace

<a id="text-namespace"></a>

Prefix portion of a [keyword](#keyword) used to make the keyword globally unique. Namespaces serve a similar function to table names in a relational store, without imposing any obligations or limitations, e.g. an entity can have attributes from more than one namespace.

<a id="outline-container-object-cache"></a>

<a id="object-cache"></a>

## Object Cache

<a id="text-object-cache"></a>

Nodes maintain an on-heap cache of segments containing the most recently used datoms.

<a id="outline-container-parameters"></a>

<a id="parameters"></a>

## Parameters

<a id="text-parameters"></a>

Named slots for application configuration data.

<a id="outline-container-partition"></a>

<a id="partition"></a>

## Partition

<a id="text-partition"></a>

A logical grouping of entities in a database. Partitions have unique qualified names. Every [entity](#entity) belongs to a partition that is assigned when the entity is created. Partitions act as a storage hint, so that larger systems can plan ahead for better locality of reference for entities that are frequently accessed together. Partitions are typically coarser grained than relational tables. Partitioning is invisible to the query system, and therefore has no impact on the code you write to access the database.

<a id="outline-container-peer"></a>

<a id="peer"></a>

## Peer

<a id="text-peer"></a>

A process that uses the Datomic library to interact with a system, and obtain [connections](#connection) to interact with one or more [databases](#database). Peers have in-memory access to database values, and an integrated Datalog query engine. There can be many kinds of peers, with capabilities varying by platform and need.

<a id="outline-container-primary-compute-stack"></a>

<a id="primary-compute-stack"></a>

## Primary Compute Stack

<a id="text-primary-compute-stack"></a>

A CloudFormation stack providing computational resources. Every Datomic system has a single primary compute stack, and may also have multiple query groups.

<a id="outline-container-pull"></a>

<a id="pull"></a>

## Pull

<a id="text-pull"></a>

A declarative way to make hierarchical selections of information about entities.

<a id="outline-container-query"></a>

<a id="query"></a>

## Query

<a id="text-query"></a>

Datomic's Datalog system. A query finds [values](#value) in a [database](#database) subject to the given constraints, and is specified as [edn](#edn).

<a id="outline-container-query-group"></a>

<a id="query-group"></a>

## Query Group

<a id="text-query-group"></a>

An AutoScaling Group (ASG) of nodes used to dedicate bandwidth, processing power, and caching to particular jobs. Unlike sharding, query groups never dictate who a client must talk to in order to store or retrieve information. Any node in any group can handle any request.

<a id="outline-container-reference"></a>

<a id="reference"></a>

## Reference

<a id="text-reference"></a>

An attribute that refers to another entity. References always have the value type `:db.type/ref`.

<a id="outline-container-REPL"></a>

<a id="REPL"></a>

## REPL

<a id="text-REPL"></a>

A Clojure REPL (standing for Read-Eval-Print Loop) is a programming environment which enables the programmer to interact with a running Clojure program and modify it, by evaluating one code expression at a time.

<a id="outline-container-reference-attribute"></a>

<a id="reference-attribute"></a>

## Reference Attribute

<a id="text-reference-attribute"></a>

See [reference](#reference).

<a id="outline-container-retraction"></a>

<a id="retraction"></a>

## Retraction

<a id="text-retraction"></a>

An atomic fact in the database, dissociating an [entity](#entity) from a particular [value](#value) of an [attribute](#attribute). Opposite of an [assertion](#assertion).

<a id="outline-container-role"></a>

<a id="role"></a>

## Role

<a id="text-role"></a>

Generic name for transactor/peer/persistence service., e.g. "The process claims the transactor role by placing a well-known value in SDB upon startup." Used in the config tools.

<a id="outline-container-rule"></a>

<a id="rule"></a>

## Rule

<a id="text-rule"></a>

A named group of [query](#query) constraints, to allow re-use of logic across queries.

<a id="outline-container-schema"></a>

<a id="schema"></a>

## Schema

<a id="text-schema"></a>

The set of possible attributes that can be associated with entities. Any entity can have any attribute.

<a id="outline-container-schema-attribute"></a>

<a id="schema-attribute"></a>

## Schema Attribute

<a id="text-schema-attribute"></a>

A built-in attribute used to define schema, e.g. all attributes are named by `:db/ident`.

<a id="outline-container-segment"></a>

<a id="segment"></a>

## Segment

<a id="text-segment"></a>

Indexes store datoms as a tree of segments, where the leaf nodes contain a few thousand datoms each.

<a id="outline-container-segment-cache"></a>

<a id="segment-cache"></a>

## Segment Cache

<a id="text-segment-cache"></a>

A cache that stores [fressian](glossary.md)-serialized data, e.g. in memcached. A segment cache takes much less memory than equivalent data in the [object cache](#object-cache), but is slower to access. [Peer](#peer) and [transactor](#transactor) processes use both object caches and segment caches.

<a id="outline-container-storage-resources"></a>

<a id="storage-resources"></a>

## Storage Resources

<a id="text-storage-resources"></a>

The durable elements managed by a Datomic system.

<a id="outline-container-storage-service"></a>

<a id="storage-service"></a>

## Storage Service

<a id="text-storage-service"></a>

Subsystem responsible for persistence. Datomic Cloud uses DynamoDB as its storage service.

<a id="outline-container-stringified-keyword"></a>

<a id="stringified-keyword"></a>

## Stringified Keyword

<a id="text-stringified-keyword"></a>

A string containing a Clojure keyword, e.g. `":name"` or `":person/name"`

<a id="outline-container-system"></a>

<a id="system"></a>

## System

<a id="text-system"></a>

A complete Datomic installation, consisting of storage resources, a primary compute stack, and optional query groups.

<a id="outline-container-time-point"></a>

<a id="time-point"></a>

## Time-point

<a id="text-time-point"></a>

Data structure that can be resolved to a point in time in a database. Can be a database t, a tx, or a date.

<a id="outline-container-t"></a>

<a id="t"></a>

## t

<a id="text-t"></a>

A point in time in a database. Every transaction is assigned a numeric t value greater than any previous t in the database, and all processes see a [consistent](../06-reference/02-transactions/05-acid/acid.md#consistency) succession of ts.

<a id="outline-container-tx"></a>

<a id="tx"></a>

## tx

<a id="text-tx"></a>

An [entity](#entity) representing a [transaction](#transaction). Every [datom](#datom) in a Datomic database includes the tx that created it, allowing recovery of the entire history of the database. Transactions are automatically associated with wall-clock time, but are otherwise ordinary entities. In particular, application code can make additional assertions about transactions.

<a id="outline-container-transaction"></a>

<a id="transaction"></a>

## Transaction

<a id="text-transaction"></a>

An atomic unit of work in a database. All Datomic writes are transactional, fully serialized, and ACID (Atomic, Consistent, Isolated, and Durable).

<a id="outline-container-transaction-function"></a>

<a id="transaction-function"></a>

## Transaction Function

<a id="text-transaction-function"></a>

A function that runs inside a transaction, taking the current database value plus user arguments and expanding into data to be added by the transaction.

<a id="outline-container-transaction-log"></a>

<a id="transaction-log"></a>

## Transaction Log

<a id="text-transaction-log"></a>

An accumulate-only log of all transactions, stored in DynamoDB.

<a id="outline-container-transactor"></a>

<a id="transactor"></a>

## Transactor

<a id="text-transactor"></a>

A process with the ability to commit transactions for a given database. At any moment in time, a running database has exactly one transactor, but any number of peers.

<a id="outline-container-tuple"></a>

<a id="tuple"></a>

## Tuple

<a id="text-tuple"></a>

An ordered list of elements. Datomic queries return sets of tuples.

<a id="outline-container-unique"></a>

<a id="unique"></a>

## Unique

<a id="text-unique"></a>

Attribute of an [attribute](#attribute). Each [entity](#entity) that has a [value](#value) for a `:db/unique` attribute must have a different value. `:db/unique` has two possible values:

- db.unique/value: attempts to assert a duplicate value will fail
- db.unique/identity: attempts to assert a duplicate identity will [upsert](#upsert)

<a id="outline-container-upsert"></a>

<a id="upsert"></a>

## Upsert

<a id="text-upsert"></a>

Either insert or update an [entity](#entity), depending on whether the unique entity already exists.

<a id="outline-container-valcache"></a>

<a id="valcache"></a>

## Valcache

<a id="text-valcache"></a>

An SSD-backed cache of segments. Valcache is similar in performance to memcached but durable and capacious.

<a id="outline-container-value"></a>

<a id="value"></a>

## Value

<a id="text-value"></a>

Something that does not change, e.g. 42, John, or \#inst "2012-02-29". A [datom](#datom) relates an [entity](#entity) to a value through an [attribute](#attribute).

<a id="outline-container-value-type"></a>

<a id="value-type"></a>

## Value type

<a id="text-value-type"></a>

Attribute of an [attribute](#attribute) that specifies the data structure that can be stored in the attribute. The value type determines how a [value](#value) is

- Serialized
- Sorted for indexing
- Represented in a programming language type
