<a id="package-datomic"></a>

# Package datomic

------------------------------------------------------------------------

package datomic
<a id="package-description"></a>

The Datomic peer library is designed to be embedded in application servers. It is the gateway to the rest of the database, submitting [transactions](../../06-reference/02-transactions/transactions.md) and receive live notifications from the transactor. It also provides local, in memory access to the database, including [caching](../../05-operation/01-pro/12-running-on-aws/running-on-aws.md) and [query](../../06-reference/03-query-and-pull/query-and-pull.md) capability. It contains all the communication components needed for connecting to the transactor and [storage](../../05-operation/01-pro/01-storage-services/storage-services.md) services, as well as Datalog and other facilities for managing your data. The peer library can act in standalone mode, using an in-memory database as a stand-in for the other components.

- <a id="class-summary"></a>

  <a id="class-summary.tabpanel"></a>

  Class
  Description
  [Attribute](interfaces/attribute/attribute.md "interface in datomic")
  Programmatic representation of a [schema attribute](../../06-reference/01-schema/01-schema-reference/schema-reference.md).
  [Connection](interfaces/connection/connection.md "interface in datomic")
  A connection to a database for submitting and monitoring transactions, and retrieving the current value of the database.
  [Database](interfaces/database/database.md "interface in datomic")
  An immutable, point-in-time database value.
  [Database.Predicate](interfaces/database-predicate/database-predicate.md "interface in datomic")\<T\>
  Boolean-valued function for [`filtering`](interfaces/database/database.md#filter(datomic.Database.Predicate)) a database.
  [Datom](interfaces/datom/datom.md "interface in datomic")
  An immmutable, point-in-time fact: `[entity, attribute, value, transaction, added]`
  [Entity](interfaces/entity/entity.md "interface in datomic")
  Implements the [Entity API](../../06-reference/07-entities/entities.md) for associative navigation by attribute keys.
  [ListenableFuture](interfaces/listenable-future/listenable-future.md "interface in datomic")\<T\>
  A future that supports completion listeners.
  [Log](interfaces/log/log.md "interface in datomic")
  Implements the [Log API](../09-log-api/additional-log-api/additional-log-api.md).
  [Peer](classes/peer/peer.md "class in datomic")
  Main entry point, used to manage connections, submit transactions, and query.
  [QueryRequest](classes/query-request/query-request.md "class in datomic")
  Container for parameters to [`Peer.query(QueryRequest)`](classes/peer/peer.md#query(datomic.QueryRequest))
  [Util](classes/util/util.md "class in datomic")
  Utilities for creating and using data structures.
