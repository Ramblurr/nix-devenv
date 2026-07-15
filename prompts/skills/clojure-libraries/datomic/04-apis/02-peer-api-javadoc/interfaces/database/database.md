Package [datomic](../../peer-api-javadoc.md)
<a id="interface-database"></a>

# Interface Database

<a id="class-description"></a>

------------------------------------------------------------------------

public interface Database

An immutable, point-in-time database value.

- <a id="nested-class-summary"></a>

  ## Nested Class Summary

  Nested Classes
  Modifier and Type
  Interface
  Description
  `static interface `
  [`Database.Predicate`](../database-predicate/database-predicate.md "interface in datomic")`<`[`T`](../database-predicate/database-predicate.md "type parameter in Database.Predicate")`>`
  Boolean-valued function for [`filtering`](#filter(datomic.Database.Predicate)) a database.

- <a id="field-summary"></a>

  ## Field Summary

  Fields
  Modifier and Type
  Field
  Description
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`AEVT`](#AEVT)
  Names the [AEVT index](../../../../06-reference/04-indexes/01-index-model/index-model.md#aevt).
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`AVET`](#AVET)
  Names the [AVET index](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet).
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`EAVT`](#EAVT)
  Names the [EAVT index](../../../../06-reference/04-indexes/01-index-model/index-model.md).
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`VAET`](#VAET)
  Names the [VAET index](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet).

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  [`Database`](database.md "interface in datomic")
  [`asOf`](#asOf(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` t)`
  Returns the value of the database filtered to include data up to `t`, inclusive
  [`Long`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Long.html "class or interface in java.lang")
  [`asOfT`](#asOfT())`()`
  [`asOf(Object)`](#asOf(java.lang.Object)) [t value](../../../../12-glossary/glossary.md#t).
  [`Attribute`](../attribute/attribute.md "interface in datomic")
  [`attribute`](#attribute(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` attrId)`
  Returns information about an [attribute](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md).
  `long`
  [`basisT`](#basisT())`()`
  [t value](../../../../12-glossary/glossary.md#t) of the most recent transaction in this db.
  [`Iterable`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")`<`[`Datom`](../datom/datom.md "interface in datomic")`>`
  [`datoms`](#datoms(java.lang.Object,java.lang.Object...))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` index, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`... components)`
  Implements the [Datoms API](../../../../06-reference/04-indexes/01-index-model/index-model.md) for raw access to matching index data.
  [`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")
  [`dbStats`](#dbStats())`()`
  Queries for database stats.
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`entid`](#entid(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` entityId)`
  Returns the entity id associated with any kind of entity identifier.
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`entidAt`](#entidAt(java.lang.Object,java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` partition, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` timePoint)`
  Returns a fabricated entity id in the supplied partition whose T component is at or after the supplied t
  [`Entity`](../entity/entity.md "interface in datomic")
  [`entity`](#entity(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` entityId)`
  Returns an [entity](../../../../06-reference/07-entities/entities.md): a lazy, dynamic associative view of datoms sharing an entity id.
  [`Database`](database.md "interface in datomic")
  [`filter`](#filter(datomic.Database.Predicate))`(`[`Database.Predicate`](../database-predicate/database-predicate.md "interface in datomic")`<`[`Datom`](../datom/datom.md "interface in datomic")`> pred)`
  Returns a value of the database containing only Datoms satisfying the predicate.
  [`Database`](database.md "interface in datomic")
  [`filter`](#filter(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` pred)`
   
  [`Database`](database.md "interface in datomic")
  [`history`](#history())`()`
  Returns a history database value containing all assertions and retractions across time.
  [`String`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")
  [`id`](#id())`()`
  Opaque, globally unique database id.
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`ident`](#ident(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` idOrKey)`
  Returns the symbolic keyword associated with an id, or the key itself if passed.
  [`Stream`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html "class or interface in java.util.stream")`<`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`>`
  [`indexPull`](#indexPull(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` options)`
  "Walks an index, pulling entities via :e if :avet or :v if :aevt, using the selector, returning a Stream of the results.
  [`Iterable`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")`<`[`Datom`](../datom/datom.md "interface in datomic")`>`
  [`indexRange`](#indexRange(java.lang.Object,java.lang.Object,java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` attrid, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` start, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` end)`
  Returns a range of [AVET-indexed](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet) datoms.
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`invoke`](#invoke(java.lang.Object,java.lang.Object...))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` entityId, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`... args)`
  Look up the [database function](../../../../06-reference/02-transactions/04-transaction-functions/transaction-functions.md) of the entity at `entityId`, and invoke the function with `args`.
  `boolean`
  [`isFiltered`](#isFiltered())`()`
  Does database have a filter set with e.g.
  `boolean`
  [`isHistory`](#isHistory())`()`
  True for databases created with [`history()`](#history())
  `long`
  [`nextT`](#nextT())`()`
  next [t value](../../../../12-glossary/glossary.md#t) that will be assigned by this database.
  [`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")
  [`pull`](#pull(java.lang.Object,java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` pattern, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` entityId)`
  Returns a hierarchical selection of attributes for entityId.
  [`List`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")`<`[`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")`>`
  [`pullMany`](#pullMany(java.lang.Object,java.util.List))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` pattern, `[`List`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")` entityIds)`
  Returns hierarchical selections of attributes for entityIds.
  [`Iterable`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")`<`[`Datom`](../datom/datom.md "interface in datomic")`>`
  [`rseekDatoms`](#rseekDatoms(java.lang.Object,java.lang.Object...))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` index, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`... components)`
  Like [`seekDatoms(java.lang.Object, java.lang.Object...)`](#seekDatoms(java.lang.Object,java.lang.Object...)), but iterates the index in reverse, beginning at or before the point where the given components would reside.
  [`Iterable`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")`<`[`Datom`](../datom/datom.md "interface in datomic")`>`
  [`seekDatoms`](#seekDatoms(java.lang.Object,java.lang.Object...))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` index, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`... components)`
  Raw access to index data, starting at nearest match to input
  [`Database`](database.md "interface in datomic")
  [`since`](#since(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` t)`
  Returns the value of the database filtered to include only data since `t`, exclusive
  [`Long`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Long.html "class or interface in java.lang")
  [`sinceT`](#sinceT())`()`
  [`since(Object)`](#since(java.lang.Object)) [t value](../../../../12-glossary/glossary.md#t).
  [`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")
  [`with`](#with(java.util.List))`(`[`List`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")` txData)`
  Returns a database with `txData` applied locally in memory.


- <a id="field-detail"></a>

  <a id="field-details"></a>

  ## Field Details

  - <a id="EAVT"></a>

    <a id="eavt"></a>

    ### EAVT

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") EAVT
    Names the [EAVT index](../../../../06-reference/04-indexes/01-index-model/index-model.md).

    Pass to APIs that take an index name such as [`datoms(Object, Object...)`](#datoms(java.lang.Object,java.lang.Object...)).

  - <a id="AEVT"></a>

    <a id="aevt"></a>

    ### AEVT

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") AEVT
    Names the [AEVT index](../../../../06-reference/04-indexes/01-index-model/index-model.md#aevt).

    Pass to APIs that take an index name such as [`datoms(Object, Object...)`](#datoms(java.lang.Object,java.lang.Object...)).

  - <a id="AVET"></a>

    <a id="avet"></a>

    ### AVET

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") AVET
    Names the [AVET index](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet).

    Pass to APIs that take an index name such as [`datoms(Object, Object...)`](#datoms(java.lang.Object,java.lang.Object...)).

  - <a id="VAET"></a>

    <a id="vaet"></a>

    ### VAET

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") VAET
    Names the [VAET index](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet).

    Pass to APIs that take an index name such as [`datoms(Object, Object...)`](#datoms(java.lang.Object,java.lang.Object...)).

- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="id()"></a>

    <a id="id"></a>

    ### id

    [String](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang") id()
    Opaque, globally unique database id.
    Returns:  
    the database id

  - <a id="basisT()"></a>

    <a id="basist"></a>

    ### basisT

    long basisT()
    [t value](../../../../12-glossary/glossary.md#t) of the most recent transaction in this db.
    Returns:  
    a t value

  - <a id="nextT()"></a>

    <a id="nextt"></a>

    ### nextT

    long nextT()
    next [t value](../../../../12-glossary/glossary.md#t) that will be assigned by this database.
    Returns:  
    a t value

  - <a id="asOfT()"></a>

    <a id="asoft"></a>

    ### asOfT

    [Long](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Long.html "class or interface in java.lang") asOfT()
    [`asOf(Object)`](#asOf(java.lang.Object)) [t value](../../../../12-glossary/glossary.md#t).
    Returns:  
    a t value, or null

  - <a id="sinceT()"></a>

    <a id="sincet"></a>

    ### sinceT

    [Long](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Long.html "class or interface in java.lang") sinceT()
    [`since(Object)`](#since(java.lang.Object)) [t value](../../../../12-glossary/glossary.md#t).
    Returns:  
    a t value, or null

  - <a id="isHistory()"></a>

    <a id="ishistory"></a>

    ### isHistory

    boolean isHistory()
    True for databases created with [`history()`](#history())
    Returns:  
    true for history databases

  - <a id="with(java.util.List)"></a>

    <a id="with"></a>

    ### with

    [Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util") with([List](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util") txData)
    Returns a database with `txData` applied locally in memory.

    It is as if the data was applied in a [transaction](../../../../06-reference/02-transactions/transactions.md), but no actual transaction takes place.
    Parameters:  
    `txData` - in the same format as expected by [`transact`](../connection/connection.md#transact(java.util.List))

    Returns:  
    a map as returned by transact

  - <a id="asOf(java.lang.Object)"></a>

    <a id="asof"></a>

    ### asOf

    [Database](database.md "interface in datomic") asOf([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") t)
    Returns the value of the database filtered to include data up to `t`, inclusive
    Parameters:  
    `t` - a [time-point](../../../../12-glossary/glossary.md#time-point)

    Returns:  
    the value of the database as of some point t, inclusive

  - <a id="since(java.lang.Object)"></a>

    <a id="since"></a>

    ### since

    [Database](database.md "interface in datomic") since([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") t)
    Returns the value of the database filtered to include only data since `t`, exclusive
    Parameters:  
    `t` - a [time-point](../../../../12-glossary/glossary.md#time-point)

    Returns:  
    the value of the database since some point t, exclusive

  - <a id="history()"></a>

    <a id="history"></a>

    ### history

    [Database](database.md "interface in datomic") history()
    Returns a history database value containing all assertions and retractions across time.

    A history database can be used for [`datoms(Object, Object...)`](#datoms(java.lang.Object,java.lang.Object...)) and [`indexRange(Object, Object, Object)`](#indexRange(java.lang.Object,java.lang.Object,java.lang.Object)), for [`queries`](../../classes/peer/peer.md#query(java.lang.Object,java.lang.Object...)), and for [`asOf(Object)`](#asOf(java.lang.Object)) and [`since(Object)`](#since(java.lang.Object)).

    A history database *cannot* be used with APIs that require a single point-in-time, i.e. [`entity(Object)`](#entity(java.lang.Object)) or [`with(java.util.List)`](#with(java.util.List)).

    Note that queries will return all of the additions and retractions, which can be distinguished by [`Datom.added()`](../datom/datom.md#added())

    Returns:  
    a history Database

  - <a id="filter(datomic.Database.Predicate)"></a>

    <a id="filter"></a>

    ### filter

    [Database](database.md "interface in datomic") filter([Database.Predicate](../database-predicate/database-predicate.md "interface in datomic")\<[Datom](../datom/datom.md "interface in datomic")\> pred)
    Returns a value of the database containing only Datoms satisfying the predicate.

    The predicate will be passed the unfiltered db and a Datom Chained calls to `filter` compose predicates with logical 'and'.
    Parameters:  
    `pred` - a `Predicate<Datom>` or `clojure fn`

    Returns:  
    the value of the database satisfying the predicate

    Since:  
    0.8.3627

  - <a id="filter(java.lang.Object)"></a>

    <a id="filter-2"></a>

    ### filter

    [Database](database.md "interface in datomic") filter([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") pred)

  - <a id="isFiltered()"></a>

    <a id="isfiltered"></a>

    ### isFiltered

    boolean isFiltered()
    Does database have a filter set with e.g. [`filter(datomic.Database.Predicate)`](#filter(datomic.Database.Predicate))?
    Returns:  
    true if db has a filter

    Since:  
    0.8.3627

  - <a id="entity(java.lang.Object)"></a>

    <a id="entity"></a>

    ### entity

    [Entity](../entity/entity.md "interface in datomic") entity([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") entityId)
    Returns an [entity](../../../../06-reference/07-entities/entities.md): a lazy, dynamic associative view of datoms sharing an entity id.
    Parameters:  
    `entityId` - an [entity identifier](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entity-identifiers)

    Returns:  
    an [`Entity`](../entity/entity.md "interface in datomic")

  - <a id="attribute(java.lang.Object)"></a>

    <a id="attribute"></a>

    ### attribute

    [Attribute](../attribute/attribute.md "interface in datomic") attribute([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") attrId)
    Returns information about an [attribute](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md).
    Parameters:  
    `attrId` - an [entity identifier](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entity-identifiers) for an attribute

    Returns:  
    an [`Attribute`](../attribute/attribute.md "interface in datomic")

    Since:  
    0.9.4470

  - <a id="ident(java.lang.Object)"></a>

    <a id="ident"></a>

    ### ident

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") ident([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") idOrKey)
    Returns the symbolic keyword associated with an id, or the key itself if passed.
    Parameters:  
    `idOrKey` - an id or keyword

    Returns:  
    a keyword, or nil if not found

  - <a id="entid(java.lang.Object)"></a>

    <a id="entid"></a>

    ### entid

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") entid([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") entityId)
    Returns the entity id associated with any kind of entity identifier.
    Parameters:  
    `entityId` - an [entity identifier](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entity-identifiers)

    Returns:  
    an id, or nil if not found

  - <a id="entidAt(java.lang.Object,java.lang.Object)"></a>

    <a id="entidat"></a>

    ### entidAt

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") entidAt([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") partition, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") timePoint)
    Returns a fabricated entity id in the supplied partition whose T component is at or after the supplied t

    . Entity ids sort by partition, then T component, such T components interleaving with transaction numbers. Thus this method can be used to fabricate a time-based entity id component for use in \#seekDatoms.
    Parameters:  
    `partition` - an [entity identifier](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entity-identifiers) for a partition

    `timePoint` - a [time-point](../../../../12-glossary/glossary.md#time-point)

    Returns:  
    a fabricated entity id at or after some point t

  - <a id="invoke(java.lang.Object,java.lang.Object...)"></a>

    <a id="invoke"></a>

    ### invoke

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") invoke([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") entityId, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")... args)
    Look up the [database function](../../../../06-reference/02-transactions/04-transaction-functions/transaction-functions.md) of the entity at `entityId`, and invoke the function with `args`.
    Parameters:  
    `entityId` - an [entity identifier](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entity-identifiers)

    `args` - the arguments to the database function

    Returns:  
    the return value of the database function

  - <a id="datoms(java.lang.Object,java.lang.Object...)"></a>

    <a id="datoms"></a>

    ### datoms

    [Iterable](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")\<[Datom](../datom/datom.md "interface in datomic")\> datoms([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") index, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")... components)
    Implements the [Datoms API](../../../../06-reference/04-indexes/01-index-model/index-model.md) for raw access to matching index data.

    The index must be supplied, and, optionally, one or more leading components of the index can be supplied to narrow the result. [EAVT](../../../../06-reference/04-indexes/01-index-model/index-model.md) and [AEVT](../../../../06-reference/04-indexes/01-index-model/index-model.md#aevt) indexes will contain all datoms [AVET](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet) will contain datoms for attributes where either `:db/index` or `:db/unique` are true. [VAET](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet) will contain datoms for attributes of :db.type/ref - it is the reverse index
    Parameters:  
    `index` - one of [`EAVT`](#EAVT), [`AEVT`](#AEVT), [`AVET`](#AVET), or [`VAET`](#VAET)

    `components` - supply any datom components to match, in order corresponding to the index

    Returns:  
    the datoms in the specified index matching the specified components

  - <a id="seekDatoms(java.lang.Object,java.lang.Object...)"></a>

    <a id="seekdatoms"></a>

    ### seekDatoms

    [Iterable](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")\<[Datom](../datom/datom.md "interface in datomic")\> seekDatoms([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") index, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")... components)
    Raw access to index data, starting at nearest match to input

    . Arguments are the same as to [`datoms(java.lang.Object, java.lang.Object...)`](#datoms(java.lang.Object,java.lang.Object...)), but their interpretation is different in two important ways:
    1.  The match need not be exact. Results will begin with the closest matching datom
    2.  No termination. Results will continue all the way to the end of the index.

    `seekDatoms` is for more advanced applications, and [`datoms(Object, Object...)`](#datoms(java.lang.Object,java.lang.Object...)) should be preferred wherever it is adequate. `seekDatoms` is typically used in conjunction with [`entidAt(Object, Object)`](#entidAt(java.lang.Object,java.lang.Object)) to implement [new entity scans](../../../../06-reference/04-indexes/01-index-model/index-model.md).
    Parameters:  
    `index` - one of [`EAVT`](#EAVT), [`AEVT`](#AEVT), [`AVET`](#AVET), or [`VAET`](#VAET)

    `components` - supply any datom components to search for, in order corresponding to the index

    Returns:  
    all of the datoms in the specified index at or after the specified components

  - <a id="rseekDatoms(java.lang.Object,java.lang.Object...)"></a>

    <a id="rseekdatoms"></a>

    ### rseekDatoms

    [Iterable](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")\<[Datom](../datom/datom.md "interface in datomic")\> rseekDatoms([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") index, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")... components)
    Like [`seekDatoms(java.lang.Object, java.lang.Object...)`](#seekDatoms(java.lang.Object,java.lang.Object...)), but iterates the index in reverse, beginning at or before the point where the given components would reside. Only terminates at the start of the index, thus callers must supply their own termination logic.
    Parameters:  
    `index` - one of [`EAVT`](#EAVT), [`AEVT`](#AEVT), [`AVET`](#AVET), or [`VAET`](#VAET)

    `components` - supply any datom components to search for, in order corresponding to the index

    Returns:  
    datoms in the specified index at or before the specified components, iterating backward

  - <a id="indexRange(java.lang.Object,java.lang.Object,java.lang.Object)"></a>

    <a id="indexrange"></a>

    ### indexRange

    [Iterable](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")\<[Datom](../datom/datom.md "interface in datomic")\> indexRange([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") attrid, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") start, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") end)
    Returns a range of [AVET-indexed](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet) datoms.

    Parameters:  
    `attrid` - an [entity identifier](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entity-identifiers) naming an indexed attribute.

    `start` - start value or null if from beginning

    `end` - end value (non-inclusive), or null if through end

    Returns:  
    an [`Iterable`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang") over [`Datom`](../datom/datom.md "interface in datomic") positioned between start (inclusive) and end (exclusive)

  - <a id="pull(java.lang.Object,java.lang.Object)"></a>

    <a id="pull"></a>

    ### pull

    [Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util") pull([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") pattern, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") entityId)
    Returns a hierarchical selection of attributes for entityId.
    Parameters:  
    `pattern` - A [pattern](../../../../06-reference/03-query-and-pull/03-pull/pull.md), or a String containing a pattern serialized into edn.

    `entityId` - An [entity identifier](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entity-identifiers)

    Returns:  
    A map containing a selection for the entityId passed in.

    Since:  
    0.9.5040

  - <a id="indexPull(java.lang.Object)"></a>

    <a id="indexpull"></a>

    ### indexPull

    [Stream](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html "class or interface in java.util.stream")\<[Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")\> indexPull([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") options)
    "Walks an index, pulling entities via :e if :avet or :v if :aevt, using the selector, returning a Stream of the results.
    Parameters:  
    `options` - a data structure describing the indexPull serialized into edn

    - a map that includes the `:index`, `:selector`, `:start`, and `:reverse` keys

    |  |  |
    |----|----|
    | `:index`  | :avet or :aevt |
    | `:selector`  | a pull selector (see 'pull') |
    | `:start`  | A vector in the same order as the index indicating the initial position. At least :a must be specified. Iteration is limited to datoms matching :a. |
    | `:reverse`  | optional, when true iterate the index in reverse order |

    indexPull map keys

    Returns:  
    an [`Stream`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html "class or interface in java.util.stream") of the indexPull results

    Since:  
    0.9.6079

  - <a id="pullMany(java.lang.Object,java.util.List)"></a>

    <a id="pullmany"></a>

    ### pullMany

    [List](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")\<[Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")\> pullMany([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") pattern, [List](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util") entityIds)
    Returns hierarchical selections of attributes for entityIds.
    Parameters:  
    `pattern` - A [pattern](../../../../06-reference/03-query-and-pull/03-pull/pull.md), or a String containing a pattern serialized into edn.

    `entityIds` - A list of [entity identifiers](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entity-identifiers)

    Returns:  
    A list of maps containing a selection for each entityId passed in.

    Since:  
    0.9.5040

  - <a id="dbStats()"></a>

    <a id="dbstats"></a>

    ### dbStats

    [Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util") dbStats()
    Queries for database stats.
    Returns:  
    a map with at least the following keys:

    |            |                                                 |
    |------------|-------------------------------------------------|
    | `:datoms`  | total count of datoms in the (history) database |

    dbStats return keys
