<a id="all-classes-and-interfaces"></a>

# All Classes and Interfaces

<a id="all-classes-table"></a>

<a id="all-classes-table.tabpanel"></a>

Class

Description

[Attribute](../interfaces/attribute/attribute.md "interface in datomic")

Programmatic representation of a [schema attribute](../../../06-reference/01-schema/01-schema-reference/schema-reference.md).

[Connection](../interfaces/connection/connection.md "interface in datomic")

A connection to a database for submitting and monitoring transactions, and retrieving the current value of the database.

[Database](../interfaces/database/database.md "interface in datomic")

An immutable, point-in-time database value.

[Database.Predicate\<T\>](../interfaces/database-predicate/database-predicate.md "interface in datomic")

Boolean-valued function for [`filtering`](../interfaces/database/database.md#filter(datomic.Database.Predicate)) a database.

[Datom](../interfaces/datom/datom.md "interface in datomic")

An immmutable, point-in-time fact: `[entity, attribute, value, transaction, added]`

[Entity](../interfaces/entity/entity.md "interface in datomic")

Implements the [Entity API](../../../06-reference/07-entities/entities.md) for associative navigation by attribute keys.

[ListenableFuture\<T\>](../interfaces/listenable-future/listenable-future.md "interface in datomic")

A future that supports completion listeners.

[Log](../interfaces/log/log.md "interface in datomic")

Implements the [Log API](../../09-log-api/additional-log-api/additional-log-api.md).

[Peer](../classes/peer/peer.md "class in datomic")

Main entry point, used to manage connections, submit transactions, and query.

[QueryRequest](../classes/query-request/query-request.md "class in datomic")

Container for parameters to [`Peer.query(QueryRequest)`](../classes/peer/peer.md#query(datomic.QueryRequest))

[Util](../classes/util/util.md "class in datomic")

Utilities for creating and using data structures.
