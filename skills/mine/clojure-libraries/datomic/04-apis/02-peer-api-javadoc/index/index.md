<a id="index"></a>

# Index

[A](#I:A) [B](#I:B) [C](#I:C) [D](#I:D) [E](#I:E) [F](#I:F) [G](#I:G) [H](#I:H) [I](#I:I) [K](#I:K) [L](#I:L) [M](#I:M) [N](#I:N) [P](#I:P) [Q](#I:Q) [R](#I:R) [S](#I:S) [T](#I:T) [U](#I:U) [V](#I:V) [W](#I:W)   
[All Classes and Interfaces](../all-classes-and-interfaces/all-classes-and-interfaces.md)\|[All Packages](../all-packages/all-packages.md)
<a id="I:A"></a>

## A

[a()](../interfaces/datom/datom.md#a()) - Method in interface datomic.[Datom](../interfaces/datom/datom.md "interface in datomic")  
This datom's [attribute](../../../06-reference/01-schema/01-schema-reference/schema-reference.md) id.

[added()](../interfaces/datom/datom.md#added()) - Method in interface datomic.[Datom](../interfaces/datom/datom.md "interface in datomic")  
Is this datom added or retracted?

[addListener(Runnable, Executor)](../interfaces/listenable-future/listenable-future.md#addListener(java.lang.Runnable,java.util.concurrent.Executor)) - Method in interface datomic.[ListenableFuture](../interfaces/listenable-future/listenable-future.md "interface in datomic")  
Register a listener to run on the given executor.

[administerSystem(Map)](../classes/peer/peer.md#administerSystem(java.util.Map)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Administer a Datomic system.

[AEVT](../interfaces/database/database.md#AEVT) - Static variable in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Names the [AEVT index](../../../06-reference/04-indexes/01-index-model/index-model.md#aevt).

[apply(Database, T)](../interfaces/database-predicate/database-predicate.md#apply(datomic.Database,T)) - Method in interface datomic.[Database.Predicate](../interfaces/database-predicate/database-predicate.md "interface in datomic")  
Database-filtering predicate.

[ARGS](../classes/query-request/query-request.md#ARGS) - Static variable in class datomic.[QueryRequest](../classes/query-request/query-request.md "class in datomic")  
 

[asData()](../classes/query-request/query-request.md#asData()) - Method in class datomic.[QueryRequest](../classes/query-request/query-request.md "class in datomic")  
 

[asOf(Object)](../interfaces/database/database.md#asOf(java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns the value of the database filtered to include data up to `t`, inclusive

[asOfT()](../interfaces/database/database.md#asOfT()) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
[`Database.asOf(Object)`](../interfaces/database/database.md#asOf(java.lang.Object)) [t value](../../../12-glossary/glossary.md#t).

[attribute(Object)](../interfaces/database/database.md#attribute(java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns information about an [attribute](../../../06-reference/01-schema/01-schema-reference/schema-reference.md).

[Attribute](../interfaces/attribute/attribute.md "interface in datomic") - Interface in [datomic](../peer-api-javadoc.md)  
Programmatic representation of a [schema attribute](../../../06-reference/01-schema/01-schema-reference/schema-reference.md).

[AVET](../interfaces/database/database.md#AVET) - Static variable in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Names the [AVET index](../../../06-reference/04-indexes/01-index-model/index-model.md#avet).

<a id="I:B"></a>

## B

[basisT()](../interfaces/database/database.md#basisT()) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
[t value](../../../12-glossary/glossary.md#t) of the most recent transaction in this db.

<a id="I:C"></a>

## C

[cancel(Object)](../classes/peer/peer.md#cancel(java.lang.Object)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Cancels the current Datomic operation (query or transaction).

[cardinality()](../interfaces/attribute/attribute.md#cardinality()) - Method in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
The attribute's [cardinality](../../../06-reference/01-schema/01-schema-reference/schema-reference.md)

[CARDINALITY_MANY](../interfaces/attribute/attribute.md#CARDINALITY_MANY) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[CARDINALITY_ONE](../interfaces/attribute/attribute.md#CARDINALITY_ONE) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[connect(Object)](../classes/peer/peer.md#connect(java.lang.Object)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Connects to the specified database.

[Connection](../interfaces/connection/connection.md "interface in datomic") - Interface in [datomic](../peer-api-javadoc.md)  
A connection to a database for submitting and monitoring transactions, and retrieving the current value of the database.

[create(Object, Object...)](../classes/query-request/query-request.md#create(java.lang.Object,java.lang.Object...)) - Static method in class datomic.[QueryRequest](../classes/query-request/query-request.md "class in datomic")  
Creates a QueryRequest object.

[createDatabase(Object)](../classes/peer/peer.md#createDatabase(java.lang.Object)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Creates a database with the given name.

<a id="I:D"></a>

## D

[DATA](../interfaces/log/log.md#DATA) - Static variable in interface datomic.[Log](../interfaces/log/log.md "interface in datomic")  
 

[Database](../interfaces/database/database.md "interface in datomic") - Interface in [datomic](../peer-api-javadoc.md)  
An immutable, point-in-time database value.

[Database.Predicate\<T\>](../interfaces/database-predicate/database-predicate.md "interface in datomic") - Interface in [datomic](../peer-api-javadoc.md)  
Boolean-valued function for [`filtering`](../interfaces/database/database.md#filter(datomic.Database.Predicate)) a database.

[Datom](../interfaces/datom/datom.md "interface in datomic") - Interface in [datomic](../peer-api-javadoc.md)  
An immmutable, point-in-time fact: `[entity, attribute, value, transaction, added]`

[datomic](../peer-api-javadoc.md) - package datomic  
The Datomic peer library is designed to be embedded in application servers.

[datoms(Object, Object...)](../interfaces/database/database.md#datoms(java.lang.Object,java.lang.Object...)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Implements the [Datoms API](../../../06-reference/04-indexes/01-index-model/index-model.md) for raw access to matching index data.

[db()](../interfaces/connection/connection.md#db()) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Retrieves the current database value.

[db()](../interfaces/entity/entity.md#db()) - Method in interface datomic.[Entity](../interfaces/entity/entity.md "interface in datomic")  
 

[DB_AFTER](../interfaces/connection/connection.md#DB_AFTER) - Static variable in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
 

[DB_BEFORE](../interfaces/connection/connection.md#DB_BEFORE) - Static variable in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
 

[dbStats()](../interfaces/database/database.md#dbStats()) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Queries for database stats.

[deleteDatabase(Object)](../classes/peer/peer.md#deleteDatabase(java.lang.Object)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Deletes a database.

<a id="I:E"></a>

## E

[e()](../interfaces/datom/datom.md#e()) - Method in interface datomic.[Datom](../interfaces/datom/datom.md "interface in datomic")  
This datom's [entity id](../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entities).

[EAVT](../interfaces/database/database.md#EAVT) - Static variable in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Names the [EAVT index](../../../06-reference/04-indexes/01-index-model/index-model.md).

[entid(Object)](../interfaces/database/database.md#entid(java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns the entity id associated with any kind of entity identifier.

[entidAt(Object, Object)](../interfaces/database/database.md#entidAt(java.lang.Object,java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns a fabricated entity id in the supplied partition whose T component is at or after the supplied t

[entity(Object)](../interfaces/database/database.md#entity(java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns an [entity](../../../06-reference/07-entities/entities.md): a lazy, dynamic associative view of datoms sharing an entity id.

[Entity](../interfaces/entity/entity.md "interface in datomic") - Interface in [datomic](../peer-api-javadoc.md)  
Implements the [Entity API](../../../06-reference/07-entities/entities.md) for associative navigation by attribute keys.

<a id="I:F"></a>

## F

[filter(Database.Predicate\<Datom\>)](../interfaces/database/database.md#filter(datomic.Database.Predicate)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns a value of the database containing only Datoms satisfying the predicate.

[filter(Object)](../interfaces/database/database.md#filter(java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
 

[function(Map)](../classes/peer/peer.md#function(java.util.Map)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Generates a function object given a map of :lang - clojure or java :params - a list of parameter names used in the code :code - a string containing the code of the function body.

<a id="I:G"></a>

## G

[gcStorage(Date)](../interfaces/connection/connection.md#gcStorage(java.util.Date)) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Reclaim storage garbage older than a certain age.

[get(int)](../interfaces/datom/datom.md#get(int)) - Method in interface datomic.[Datom](../interfaces/datom/datom.md "interface in datomic")  
Positional getter, as if datom is tuple of `[e a v tx added]`

[get(Object)](../interfaces/entity/entity.md#get(java.lang.Object)) - Method in interface datomic.[Entity](../interfaces/entity/entity.md "interface in datomic")  
Gets the value of the attribute named by key, and is polymorphic on key type cardinality :many attributes will always return a collection, even when only one value

[getDatabaseNames(Object)](../classes/peer/peer.md#getDatabaseNames(java.lang.Object)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Returns a list of database names.

<a id="I:H"></a>

## H

[hasAVET()](../interfaces/attribute/attribute.md#hasAVET()) - Method in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
Does this attribute *currently* have an [AVET index](../../../06-reference/04-indexes/01-index-model/index-model.md#avet)?

[hasFulltext()](../interfaces/attribute/attribute.md#hasFulltext()) - Method in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
Does this attribute have a fulltext index?

[hasNoHistory()](../interfaces/attribute/attribute.md#hasNoHistory()) - Method in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
Is this a [noHistory](../../../06-reference/01-schema/01-schema-reference/schema-reference.md) attribute?

[history()](../interfaces/database/database.md#history()) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns a history database value containing all assertions and retractions across time.

<a id="I:I"></a>

## I

[id()](../interfaces/attribute/attribute.md#id()) - Method in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
The attribute's [entity id](../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entities)

[id()](../interfaces/database/database.md#id()) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Opaque, globally unique database id.

[ident()](../interfaces/attribute/attribute.md#ident()) - Method in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
The attribute's [ident](../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#idents) (programmatic name)

[ident(Object)](../interfaces/database/database.md#ident(java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns the symbolic keyword associated with an id, or the key itself if passed.

[indexPull(Object)](../interfaces/database/database.md#indexPull(java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
"Walks an index, pulling entities via :e if :avet or :v if :aevt, using the selector, returning a Stream of the results.

[indexRange(Object, Object, Object)](../interfaces/database/database.md#indexRange(java.lang.Object,java.lang.Object,java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns a range of [AVET-indexed](../../../06-reference/04-indexes/01-index-model/index-model.md#avet) datoms.

[invoke(Object, Object...)](../interfaces/database/database.md#invoke(java.lang.Object,java.lang.Object...)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Look up the [database function](../../../06-reference/02-transactions/04-transaction-functions/transaction-functions.md) of the entity at `entityId`, and invoke the function with `args`.

[isComponent()](../interfaces/attribute/attribute.md#isComponent()) - Method in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
Is this a [component](../../../06-reference/01-schema/01-schema-reference/schema-reference.md) attribute?

[isFiltered()](../interfaces/database/database.md#isFiltered()) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Does database have a filter set with e.g.

[isHistory()](../interfaces/database/database.md#isHistory()) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
True for databases created with [`Database.history()`](../interfaces/database/database.md#history())

[isIndexed()](../interfaces/attribute/attribute.md#isIndexed()) - Method in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
Is this attribute configured for an [AVET index](../../../06-reference/04-indexes/01-index-model/index-model.md#avet)?

<a id="I:K"></a>

## K

[keySet()](../interfaces/entity/entity.md#keySet()) - Method in interface datomic.[Entity](../interfaces/entity/entity.md "interface in datomic")  
 

<a id="I:L"></a>

## L

[list(Object...)](../classes/util/util.md#list(java.lang.Object...)) - Static method in class datomic.[Util](../classes/util/util.md "class in datomic")  
Creates an immutable List.

[listBackups(String)](../classes/peer/peer.md#listBackups(java.lang.String)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Lists all points in time available at the given `backup-uri`.

[ListenableFuture\<T\>](../interfaces/listenable-future/listenable-future.md "interface in datomic") - Interface in [datomic](../peer-api-javadoc.md)  
A future that supports completion listeners.

[log()](../interfaces/connection/connection.md#log()) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Retrieves the current value of the log.

[Log](../interfaces/log/log.md "interface in datomic") - Interface in [datomic](../peer-api-javadoc.md)  
Implements the [Log API](../../09-log-api/additional-log-api/additional-log-api.md).

<a id="I:M"></a>

## M

[map(Object...)](../classes/util/util.md#map(java.lang.Object...)) - Static method in class datomic.[Util](../classes/util/util.md "class in datomic")  
Creates an immutable Map.

<a id="I:N"></a>

## N

[name(Object)](../classes/util/util.md#name(java.lang.Object)) - Static method in class datomic.[Util](../classes/util/util.md "class in datomic")  
Returns the name part of a keyword or symbol.

[namespace(Object)](../classes/util/util.md#namespace(java.lang.Object)) - Static method in class datomic.[Util](../classes/util/util.md "class in datomic")  
Returns the namespace part of a keyword or symbol.

[nextT()](../interfaces/database/database.md#nextT()) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
next [t value](../../../12-glossary/glossary.md#t) that will be assigned by this database.

<a id="I:P"></a>

## P

[part(Object)](../classes/peer/peer.md#part(java.lang.Object)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Returns the partition of this entity id.

[Peer](../classes/peer/peer.md "class in datomic") - Class in [datomic](../peer-api-javadoc.md)  
Main entry point, used to manage connections, submit transactions, and query.

[pull(Object, Object)](../interfaces/database/database.md#pull(java.lang.Object,java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns a hierarchical selection of attributes for entityId.

[pullMany(Object, List)](../interfaces/database/database.md#pullMany(java.lang.Object,java.util.List)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns hierarchical selections of attributes for entityIds.

<a id="I:Q"></a>

## Q

[q(Object, Object...)](../classes/peer/peer.md#q(java.lang.Object,java.lang.Object...)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Like [`Peer.query(Object, Object...)`](../classes/peer/peer.md#query(java.lang.Object,java.lang.Object...)), but with a more specific return signature.

[qseq(Object, Object...)](../classes/peer/peer.md#qseq(java.lang.Object,java.lang.Object...)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Performs the query described by `query` and `inputs` (as per [`Peer.query(Object, Object...)`](../classes/peer/peer.md#query(java.lang.Object,java.lang.Object...))), Item transformations such as pull are deferred until the Stream is consumed.

[query(QueryRequest)](../classes/peer/peer.md#query(datomic.QueryRequest)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Like [`Peer.query(Object, Object...)`](../classes/peer/peer.md#query(java.lang.Object,java.lang.Object...)), but accepts a [`QueryRequest`](../classes/query-request/query-request.md "class in datomic") object.

[query(Object, Object...)](../classes/peer/peer.md#query(java.lang.Object,java.lang.Object...)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Executes a [datalog query](../../../06-reference/03-query-and-pull/query-and-pull.md).

[QUERY](../classes/query-request/query-request.md#QUERY) - Static variable in class datomic.[QueryRequest](../classes/query-request/query-request.md "class in datomic")  
 

[QueryRequest](../classes/query-request/query-request.md "class in datomic") - Class in [datomic](../peer-api-javadoc.md)  
Container for parameters to [`Peer.query(QueryRequest)`](../classes/peer/peer.md#query(datomic.QueryRequest))

<a id="I:R"></a>

## R

[read(String)](../classes/util/util.md#read(java.lang.String)) - Static method in class datomic.[Util](../classes/util/util.md "class in datomic")  
Reads one item from source, returning it.

[readAll(Reader)](../classes/util/util.md#readAll(java.io.Reader)) - Static method in class datomic.[Util](../classes/util/util.md "class in datomic")  
Reads all the data in reader, returning a List.

[release()](../interfaces/connection/connection.md#release()) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Request the release of resources associated with this connection.

[removeTxReportQueue()](../interfaces/connection/connection.md#removeTxReportQueue()) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Removes the queue associated with this connection.

[renameDatabase(Object, String)](../classes/peer/peer.md#renameDatabase(java.lang.Object,java.lang.String)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Renames a database.

[requestIndex()](../interfaces/connection/connection.md#requestIndex()) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Request that a [background indexing job](../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md#indexing) begin immediately.

[resolveTempid(Database, Object, Object)](../classes/peer/peer.md#resolveTempid(datomic.Database,java.lang.Object,java.lang.Object)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Resolve a tempid to the actual id assigned in a database.

[rseekDatoms(Object, Object...)](../interfaces/database/database.md#rseekDatoms(java.lang.Object,java.lang.Object...)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Like [`Database.seekDatoms(java.lang.Object, java.lang.Object...)`](../interfaces/database/database.md#seekDatoms(java.lang.Object,java.lang.Object...)), but iterates the index in reverse, beginning at or before the point where the given components would reside.

<a id="I:S"></a>

## S

[seekDatoms(Object, Object...)](../interfaces/database/database.md#seekDatoms(java.lang.Object,java.lang.Object...)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Raw access to index data, starting at nearest match to input

[shutdown(boolean)](../classes/peer/peer.md#shutdown(boolean)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Shutdown all peer resources.

[since(Object)](../interfaces/database/database.md#since(java.lang.Object)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns the value of the database filtered to include only data since `t`, exclusive

[sinceT()](../interfaces/database/database.md#sinceT()) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
[`Database.since(Object)`](../interfaces/database/database.md#since(java.lang.Object)) [t value](../../../12-glossary/glossary.md#t).

[squuid()](../classes/peer/peer.md#squuid()) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Constructs a semi-sequential UUID.

[squuidTimeMillis(UUID)](../classes/peer/peer.md#squuidTimeMillis(java.util.UUID)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Get the time component of a squuid.

[streamOn(Iterable)](../classes/util/util.md#streamOn(java.lang.Iterable)) - Static method in class datomic.[Util](../classes/util/util.md "class in datomic")  
Create a stream on an immutable Iterable.

[sync()](../interfaces/connection/connection.md#sync()) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Retrieve a database value that includes all transactions completed at the time `sync` was called.

[sync(long)](../interfaces/connection/connection.md#sync(long)) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Retrieve a database value that includes all transactions completed up to and including time t.

[syncExcise(long)](../interfaces/connection/connection.md#syncExcise(long)) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Retrieve a database value that is aware of all [excisions](../../../05-operation/01-pro/15-excision/excision.md) up to a [database t](../../../12-glossary/glossary.md#t).

[syncIndex(long)](../interfaces/connection/connection.md#syncIndex(long)) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Retrieve a database value that is [indexed](../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md#indexing) through the [database t](../../../12-glossary/glossary.md#t) passed in.

[syncSchema(long)](../interfaces/connection/connection.md#syncSchema(long)) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Retrieve a database value that is aware of all [schema changes](../../../06-reference/01-schema/02-changing-schema/changing-schema.md) up to a [database t](../../../12-glossary/glossary.md#t).

<a id="I:T"></a>

## T

[T](../interfaces/log/log.md#T) - Static variable in interface datomic.[Log](../interfaces/log/log.md "interface in datomic")  
 

[tempid(Object)](../classes/peer/peer.md#tempid(java.lang.Object)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Generates a temp id in the designated partition.

[tempid(Object, long)](../classes/peer/peer.md#tempid(java.lang.Object,long)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Generates a temp id in the designated partition.

[TEMPIDS](../interfaces/connection/connection.md#TEMPIDS) - Static variable in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
 

[timeout(long)](../classes/query-request/query-request.md#timeout(long)) - Method in class datomic.[QueryRequest](../classes/query-request/query-request.md "class in datomic")  
The number of milliseconds after which a query may be stopped.

[TIMEOUT](../classes/query-request/query-request.md#TIMEOUT) - Static variable in class datomic.[QueryRequest](../classes/query-request/query-request.md "class in datomic")  
 

[toString()](../classes/query-request/query-request.md#toString()) - Method in class datomic.[QueryRequest](../classes/query-request/query-request.md "class in datomic")  
 

[toT(Object)](../classes/peer/peer.md#toT(java.lang.Object)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Returns the t value associated with this tx.

[toTx(long)](../classes/peer/peer.md#toTx(long)) - Static method in class datomic.[Peer](../classes/peer/peer.md "class in datomic")  
Returns the tx associated with this t value.

[touch()](../interfaces/entity/entity.md#touch()) - Method in interface datomic.[Entity](../interfaces/entity/entity.md "interface in datomic")  
Touches all of the attributes of the entity, including any component entities recursively.

[transact(List)](../interfaces/connection/connection.md#transact(java.util.List)) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Submits a [transaction](../../../06-reference/02-transactions/transactions.md), blocking until a result is available.

[transactAsync(List)](../interfaces/connection/connection.md#transactAsync(java.util.List)) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Like [`Connection.transact(java.util.List)`](../interfaces/connection/connection.md#transact(java.util.List)), but returns immediately, with timeout logic left up to the caller.

[tx()](../interfaces/datom/datom.md#tx()) - Method in interface datomic.[Datom](../interfaces/datom/datom.md "interface in datomic")  
This datom's [transaction id](../../../06-reference/02-transactions/03-processing-transactions/processing-transactions.md).

[TX_DATA](../interfaces/connection/connection.md#TX_DATA) - Static variable in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
 

[txRange(Object, Object)](../interfaces/log/log.md#txRange(java.lang.Object,java.lang.Object)) - Method in interface datomic.[Log](../interfaces/log/log.md "interface in datomic")  
Returns a range of transactions in log, starting at start, or from beginning if start is null, and ending before end, or through end of log if end is null.

[txReportQueue()](../interfaces/connection/connection.md#txReportQueue()) - Method in interface datomic.[Connection](../interfaces/connection/connection.md "interface in datomic")  
Gets the single transaction report queue associated with this connection, creating it if necessary.

[TYPE_BIGDEC](../interfaces/attribute/attribute.md#TYPE_BIGDEC) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_BIGINT](../interfaces/attribute/attribute.md#TYPE_BIGINT) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_BOOLEAN](../interfaces/attribute/attribute.md#TYPE_BOOLEAN) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_BYTES](../interfaces/attribute/attribute.md#TYPE_BYTES) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_DOUBLE](../interfaces/attribute/attribute.md#TYPE_DOUBLE) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_FLOAT](../interfaces/attribute/attribute.md#TYPE_FLOAT) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_FN](../interfaces/attribute/attribute.md#TYPE_FN) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_INSTANT](../interfaces/attribute/attribute.md#TYPE_INSTANT) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_KEYWORD](../interfaces/attribute/attribute.md#TYPE_KEYWORD) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_LONG](../interfaces/attribute/attribute.md#TYPE_LONG) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_REF](../interfaces/attribute/attribute.md#TYPE_REF) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_STRING](../interfaces/attribute/attribute.md#TYPE_STRING) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_URI](../interfaces/attribute/attribute.md#TYPE_URI) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[TYPE_UUID](../interfaces/attribute/attribute.md#TYPE_UUID) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

<a id="I:U"></a>

## U

[unique()](../interfaces/attribute/attribute.md#unique()) - Method in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
Type of the attribute's [unique index](../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#unique-identities), if any.

[UNIQUE_IDENTITY](../interfaces/attribute/attribute.md#UNIQUE_IDENTITY) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[UNIQUE_VALUE](../interfaces/attribute/attribute.md#UNIQUE_VALUE) - Static variable in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
 

[Util](../classes/util/util.md "class in datomic") - Class in [datomic](../peer-api-javadoc.md)  
Utilities for creating and using data structures.

<a id="I:V"></a>

## V

[v()](../interfaces/datom/datom.md#v()) - Method in interface datomic.[Datom](../interfaces/datom/datom.md "interface in datomic")  
This datom's value.

[VAET](../interfaces/database/database.md#VAET) - Static variable in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Names the [VAET index](../../../06-reference/04-indexes/01-index-model/index-model.md#avet).

[valueType()](../interfaces/attribute/attribute.md#valueType()) - Method in interface datomic.[Attribute](../interfaces/attribute/attribute.md "interface in datomic")  
The attribute's [value type](../../../06-reference/01-schema/01-schema-reference/schema-reference.md)

<a id="I:W"></a>

## W

[with(List)](../interfaces/database/database.md#with(java.util.List)) - Method in interface datomic.[Database](../interfaces/database/database.md "interface in datomic")  
Returns a database with `txData` applied locally in memory.

[A](#I:A) [B](#I:B) [C](#I:C) [D](#I:D) [E](#I:E) [F](#I:F) [G](#I:G) [H](#I:H) [I](#I:I) [K](#I:K) [L](#I:L) [M](#I:M) [N](#I:N) [P](#I:P) [Q](#I:Q) [R](#I:R) [S](#I:S) [T](#I:T) [U](#I:U) [V](#I:V) [W](#I:W)   
[All Classes and Interfaces](../all-classes-and-interfaces/all-classes-and-interfaces.md)\|[All Packages](../all-packages/all-packages.md)
