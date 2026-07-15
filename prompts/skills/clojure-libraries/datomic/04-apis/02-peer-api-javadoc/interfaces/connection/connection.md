Package [datomic](../../peer-api-javadoc.md)
<a id="interface-connection"></a>

# Interface Connection

<a id="class-description"></a>

------------------------------------------------------------------------

public interface Connection

A connection to a database for submitting and monitoring transactions, and retrieving the current value of the database.

- <a id="field-summary"></a>

  ## Field Summary

  Fields
  Modifier and Type
  Field
  Description
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`DB_AFTER`](#DB_AFTER)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`DB_BEFORE`](#DB_BEFORE)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TEMPIDS`](#TEMPIDS)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TX_DATA`](#TX_DATA)
   

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  [`Database`](../database/database.md "interface in datomic")
  [`db`](#db())`()`
  Retrieves the current database value.
  `void`
  [`gcStorage`](#gcStorage(java.util.Date))`(`[`Date`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Date.html "class or interface in java.util")` olderThan)`
  Reclaim storage garbage older than a certain age.
  [`Log`](../log/log.md "interface in datomic")
  [`log`](#log())`()`
  Retrieves the current value of the log.
  `void`
  [`release`](#release())`()`
  Request the release of resources associated with this connection.
  `void`
  [`removeTxReportQueue`](#removeTxReportQueue())`()`
  Removes the queue associated with this connection.
  `boolean`
  [`requestIndex`](#requestIndex())`()`
  Request that a [background indexing job](../../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md#indexing) begin immediately.
  [`ListenableFuture`](../listenable-future/listenable-future.md "interface in datomic")`<`[`Database`](../database/database.md "interface in datomic")`>`
  [`sync`](#sync())`()`
  Retrieve a database value that includes all transactions completed at the time `sync` was called.
  [`ListenableFuture`](../listenable-future/listenable-future.md "interface in datomic")`<`[`Database`](../database/database.md "interface in datomic")`>`
  [`sync`](#sync(long))`(long t)`
  Retrieve a database value that includes all transactions completed up to and including time t.
  [`ListenableFuture`](../listenable-future/listenable-future.md "interface in datomic")`<`[`Database`](../database/database.md "interface in datomic")`>`
  [`syncExcise`](#syncExcise(long))`(long t)`
  Retrieve a database value that is aware of all [excisions](../../../../05-operation/01-pro/15-excision/excision.md) up to a [database t](../../../../12-glossary/glossary.md#t).
  [`ListenableFuture`](../listenable-future/listenable-future.md "interface in datomic")`<`[`Database`](../database/database.md "interface in datomic")`>`
  [`syncIndex`](#syncIndex(long))`(long t)`
  Retrieve a database value that is [indexed](../../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md#indexing) through the [database t](../../../../12-glossary/glossary.md#t) passed in.
  [`ListenableFuture`](../listenable-future/listenable-future.md "interface in datomic")`<`[`Database`](../database/database.md "interface in datomic")`>`
  [`syncSchema`](#syncSchema(long))`(long t)`
  Retrieve a database value that is aware of all [schema changes](../../../../06-reference/01-schema/02-changing-schema/changing-schema.md) up to a [database t](../../../../12-glossary/glossary.md#t).
  [`ListenableFuture`](../listenable-future/listenable-future.md "interface in datomic")`<`[`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")`>`
  [`transact`](#transact(java.util.List))`(`[`List`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")` txData)`
  Submits a [transaction](../../../../06-reference/02-transactions/transactions.md), blocking until a result is available.
  [`ListenableFuture`](../listenable-future/listenable-future.md "interface in datomic")`<`[`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")`>`
  [`transactAsync`](#transactAsync(java.util.List))`(`[`List`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")` txData)`
  Like [`transact(java.util.List)`](#transact(java.util.List)), but returns immediately, with timeout logic left up to the caller.
  [`BlockingQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/BlockingQueue.html "class or interface in java.util.concurrent")`<`[`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")`>`
  [`txReportQueue`](#txReportQueue())`()`
  Gets the single transaction report queue associated with this connection, creating it if necessary.


- <a id="field-detail"></a>

  <a id="field-details"></a>

  ## Field Details

  - <a id="DB_BEFORE"></a>

    <a id="db-before"></a>

    ### DB_BEFORE

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") DB_BEFORE

  - <a id="DB_AFTER"></a>

    <a id="db-after"></a>

    ### DB_AFTER

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") DB_AFTER

  - <a id="TX_DATA"></a>

    <a id="tx-data"></a>

    ### TX_DATA

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TX_DATA

  - <a id="TEMPIDS"></a>

    <a id="tempids"></a>

    ### TEMPIDS

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TEMPIDS

- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="requestIndex()"></a>

    <a id="requestindex"></a>

    ### requestIndex

    boolean requestIndex()
    Request that a [background indexing job](../../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md#indexing) begin immediately.

    Background indexing will happen asynchronously. You can track indexing completion with [`syncIndex(long)`](#syncIndex(long)).
    Returns:  
    true if indexing job successfully scheduled.

  - <a id="db()"></a>

    <a id="db"></a>

    ### db

    [Database](../database/database.md "interface in datomic") db()
    Retrieves the current database value. Does not communicate with the transactor, nor block.
    Returns:  
    an immutable database value.

  - <a id="log()"></a>

    <a id="log"></a>

    ### log

    [Log](../log/log.md "interface in datomic") log()
    Retrieves the current value of the log. Does not communicate with the transactor, nor block.
    Returns:  
    an immutable log value

    Since:  
    0.8.4122

  - <a id="sync()"></a>

    <a id="sync"></a>

    ### sync

    [ListenableFuture](../listenable-future/listenable-future.md "interface in datomic")\<[Database](../database/database.md "interface in datomic")\> sync()
    Retrieve a database value that includes all transactions completed at the time `sync` was called.

    `sync` is a primitive for coordinating activity across peer processes. `sync` always communicates with the transactor, and should only be used when the following two conditions hold
    1.  coordination is required
    2.  peers have no way to agree on a basis t for coordination

    If you do not require coordination, prefer [`db()`](#db()). If peers can share a known basis t, prefer [`sync(long)`](#sync(long)).
    The future returned by sync can take arbitrarily long to complete. Waiters should specify a timeout.

    Returns:  
    a database future.

    Since:  
    0.8.3993

  - <a id="sync(long)"></a>

    <a id="sync-2"></a>

    ### sync

    [ListenableFuture](../listenable-future/listenable-future.md "interface in datomic")\<[Database](../database/database.md "interface in datomic")\> sync(long t)
    Retrieve a database value that includes all transactions completed up to and including time t.

    `sync` is a primitive for coordinating activity across peer processes. `sync` does not communicate with the transactor, but it can block if the peer has not yet been notified of transactions up to time t. If you do not require coordination, prefer [`db()`](#db()). If peers do not share a basis t, prefer [`sync()`](#sync()).

    The future returned by sync can take arbitrarily long to complete. Waiters should specify a timeout.

    Parameters:  
    `t` - a [database t](../../../../12-glossary/glossary.md#t).

    Returns:  
    a database future.

    Since:  
    0.8.3993

  - <a id="syncIndex(long)"></a>

    <a id="syncindex"></a>

    ### syncIndex

    [ListenableFuture](../listenable-future/listenable-future.md "interface in datomic")\<[Database](../database/database.md "interface in datomic")\> syncIndex(long t)
    Retrieve a database value that is [indexed](../../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md#indexing) through the [database t](../../../../12-glossary/glossary.md#t) passed in.

    Does not communicate with the transactor, so the future may be available immediately. The future can take arbitrarily long to complete. Waiters should specify a timeout.
    Parameters:  
    `t` - a database t.

    Returns:  
    a database future.

    Since:  
    0.9.4470

  - <a id="syncSchema(long)"></a>

    <a id="syncschema"></a>

    ### syncSchema

    [ListenableFuture](../listenable-future/listenable-future.md "interface in datomic")\<[Database](../database/database.md "interface in datomic")\> syncSchema(long t)
    Retrieve a database value that is aware of all [schema changes](../../../../06-reference/01-schema/02-changing-schema/changing-schema.md) up to a [database t](../../../../12-glossary/glossary.md#t).

    Does not communicate with the transactor, so the future may be available immediately. The future can take arbitrarily long to complete. Waiters should specify a timeout.
    Parameters:  
    `t` - a database t.

    Returns:  
    a database future.

    Since:  
    0.9.4470

  - <a id="syncExcise(long)"></a>

    <a id="syncexcise"></a>

    ### syncExcise

    [ListenableFuture](../listenable-future/listenable-future.md "interface in datomic")\<[Database](../database/database.md "interface in datomic")\> syncExcise(long t)
    Retrieve a database value that is aware of all [excisions](../../../../05-operation/01-pro/15-excision/excision.md) up to a [database t](../../../../12-glossary/glossary.md#t).

    Does not communicate with the transactor, so the future may be available immediately. The future can take arbitrarily long to complete. Waiters should specify a timeout.
    Parameters:  
    `t` - a database t.

    Returns:  
    a database future.

    Since:  
    0.9.4470

  - <a id="transact(java.util.List)"></a>

    <a id="transact"></a>

    ### transact

    [ListenableFuture](../listenable-future/listenable-future.md "interface in datomic")\<[Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")\> transact([List](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util") txData)
    Submits a [transaction](../../../../06-reference/02-transactions/transactions.md), blocking until a result is available.

    Parameters:  
    `txData` - a list of data to be added, containing any combination of [assertions](../../../../06-reference/02-transactions/transactions.md), [retractions](../../../../06-reference/02-transactions/transactions.md), [transaction functions](../../../../06-reference/02-transactions/04-transaction-functions/transaction-functions.md#transaction-functions), or [entity maps](../../../../06-reference/02-transactions/transactions.md):

    | Type | Example |
    |----|----|
    | assertion | `[:db/add some-id :some-attr/name "Some attr value"]` |
    | retraction | `[:db/retract some-id :some-attr/name "Some attr value"]` |
    | transaction function | `[:some/fn-name args-for-fn ...]` |
    | entity map | `{:db/id some-id :some-attr/name "some value" :another-attr/name 42 ...}` |

    Transaction data items

    Returns:  
    a future that can be used to monitor the completion of the transaction. If the transaction commits, the future's value is a map, with the following keys:

    |  |  |
    |----|----|
    | `DB_BEFORE` | Database value before the transaction |
    | `DB_AFTER` | Database value after the transaction |
    | `TX_DATA` | Collection of [`Datom`](../datom/datom.md "interface in datomic")s produced by the transaction |
    | `TEMPID` | Use with [`Peer.resolveTempid(datomic.Database, java.lang.Object, java.lang.Object)`](../../classes/peer/peer.md#resolveTempid(datomic.Database,java.lang.Object,java.lang.Object)) to resolve temporary ids. |

    Transaction return keys

    If the transaction aborts, attempts to get the future's value throw an ExecutionException, wrapping a Error containing error information. If the transaction times out, the call to transact itself will throw a RuntimeException. The transaction timeout can be set via the system property datomic.txTimeoutMsec, and defaults to 10000 (10 seconds).

    See Also:  
    - [`ListenableFuture`](../listenable-future/listenable-future.md "interface in datomic")

  - <a id="transactAsync(java.util.List)"></a>

    <a id="transactasync"></a>

    ### transactAsync

    [ListenableFuture](../listenable-future/listenable-future.md "interface in datomic")\<[Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")\> transactAsync([List](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util") txData)
    Like [`transact(java.util.List)`](#transact(java.util.List)), but returns immediately, with timeout logic left up to the caller.
    Parameters:  
    `txData` - see `transact`

    Returns:  
    see `transact`

  - <a id="txReportQueue()"></a>

    <a id="txreportqueue"></a>

    ### txReportQueue

    [BlockingQueue](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/BlockingQueue.html "class or interface in java.util.concurrent")\<[Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")\> txReportQueue()
    Gets the single transaction report queue associated with this connection, creating it if necessary.

    The transaction report queue receives reports from all transactions in the system. Objects on the queue have the same keys as returned by [`transact(java.util.List)`](#transact(java.util.List)). The returned queue may be consumed from more than one thread. Note that the returned queue does not block producers, and will consume memory until you consume the elements from it. Reports will be added to the queue at some point after the db has been updated If this connection originated the transaction, the transaction future will be notified first, before a report is placed on the queue.
    Returns:  
    a queue

  - <a id="removeTxReportQueue()"></a>

    <a id="removetxreportqueue"></a>

    ### removeTxReportQueue

    void removeTxReportQueue()
    Removes the queue associated with this connection.

  - <a id="gcStorage(java.util.Date)"></a>

    <a id="gcstorage"></a>

    ### gcStorage

    void gcStorage([Date](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Date.html "class or interface in java.util") olderThan)
    Reclaim storage garbage older than a certain age.

    As part of [capacity planning](../../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md#garbage-collection) for a Datomic system, you should schedule regular (e.g daily, weekly) calls to `gcStorage`.
    Parameters:  
    `olderThan` - limits how recent garbage may be collected

  - <a id="release()"></a>

    <a id="release"></a>

    ### release

    void release()
    Request the release of resources associated with this connection.

    Method returns immediately, resources will be released asynchronously. This method should only be called when the entire process is no longer interested in the connection. Note that Datomic connections do not adhere to an acquire/use/release pattern. They are thread-safe, cached, and long lived. Many processes (e.g. application servers) will never call release.
    Since:  
    0.8.3861
