<a id="content"></a>

<a id="log-api"></a>

# Log API

Datomic's database log is a recording of all transaction data in historic order, organized for efficient access by transaction. You can access the log:

- Programmatically [from methods](#connect-txrange) on *Connection*
- Via [query functions](#log-in-query)

<a id="outline-container-connect-txrange"></a>

<a id="connect-txrange"></a>

## Connection.log and Log.txRange

<a id="text-connect-txrange"></a>

[(d/log)](../../01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/log) returns an immutable log value.

``` clojure
(d/log conn)
=> #datomic.log.LogValue{... :olookup #object[datomic.cache$lookup_cache$reify__12495 0x21ff3fe3 "datomic.cache$lookup_cache$reify__12495@21ff3fe3"], :root-id #uuid "6643ba96-0cc9-46fd-8390-21b5e6001fd9", :tail #datomic.db.MemLog{:txes []}}
```

Given a log, you can retrieve an Iterable over a range in the log with [(d/tx-range](../../01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/tx-range):

``` clojure
(d/tx-range log 1000 1020)
=> #object[datomic.log$tx_range$reify__15766 0x614504c7 "datomic.log$tx_range$reify__15766@614504c7"]
```

The arguments are *startT* (inclusive), and *endT* (exclusive). Legal values for these arguments are:

- txes (transaction entity ids)
- ts (as e.g. returned from [Database.nextT](../../02-peer-api-javadoc/interfaces/database/database.md))
- transaction instants (java.util.Dates)
- *null* (to represent the beginning/end of the log)

Each map represents a single transaction, and contains two key/value pairs.

| Keyword | Java Constant | Value                  |
|---------|---------------|------------------------|
| :t      | Log.T         | the transaction t      |
| :data   | Log.DATA      | a collection of datoms |

The datoms implement the [datomic.Datom](../../02-peer-api-javadoc/interfaces/datom/datom.md) interface. In Clojure, they act as both sequential and associative collections, and can be destructured accordingly.

<a id="outline-container-log-in-query"></a>

<a id="log-in-query"></a>

## Log in Query: tx-ids and tx-data

<a id="text-log-in-query"></a>

The log API includes two convenience functions that are available within query. The *tx-ids* function takes arguments similar to *txRange* above, but returns a collection of transaction entity ids. You will typically use the collection binding form *\[?tx …\]* to capture the results.

``` clojure
[(tx-ids ?log ?t1 ?tx) [?tx ...]]
```

The following example query returns the count of transactions within the range \[t1, t2):

``` clojure
(d/q '[:find (count ?tx)
       :in $ ?log ?t1 ?t2
       :where [(tx-ids ?log ?t1 ?t2) [?tx ...]]]
     (d/db conn) (d/log conn) t1 t2)  
```

The *tx-data* function returns the datoms associated with a particular t or tx. You will typically use the relation binding form *\[ \[?e ?a ?v \_ ?op \] \]* to capture the results.

``` clojure
[(tx-data ?log ?tx) [[?e ?a ?v _ ?op]]]
```

Note the underscore binding. You should **not** bind the *?tx* position, as *?tx* is already bound on input to the function.

*tx-data* is the efficient way to get transaction data given t or tx. A common scenario is to use *tx-data* in combination with *tx-ids*, to return the datoms associated with a range in time. The following example query returns all the entities that were modified on August 1, 2013:

``` clojure
(d/q '[:find ?e
       :in $ ?log ?t1 ?t2
       :where [(tx-ids ?log ?t1 ?t2) [?tx ...]]
              [(tx-data ?log ?tx) [[?e]]]]
     (d/db conn) (d/log conn) #inst "2013-08-01" #inst "2013-08-02")
```

<a id="outline-container-implementation"></a>

<a id="implementation"></a>

## Implementation

<a id="text-implementation"></a>

Datomic's log is stored as a shallow tree of segments, where each segment typically contains thousands of datoms. The most recent data in the log is also maintained in memory on all transactor and peer processes.
